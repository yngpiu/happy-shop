package com.happyshop.controller;

import java.io.File;
import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.happyshop.bean.MailInfo;
import com.happyshop.dao.UserDAO;
import com.happyshop.entity.User;
import com.happyshop.service.CookieService;
import com.happyshop.service.MailService;

/**
 * ===== CONTROLLER TÀI KHOẢN USER =====
 * 
 * Controller xử lý các chức năng tài khoản người dùng:
 * - Đăng nhập và đăng xuất
 * - Đăng ký tài khoản mới
 * - Quên mật khẩu và gửi email khôi phục
 * - Thay đổi mật khẩu
 * - Chỉnh sửa thông tin cá nhân
 * 
 * Tính năng:
 * - Authentication với session và cookie
 * - User registration với file upload
 * - Password recovery qua email
 * - Profile management
 * 
 * Author: Development Team
 * Version: 1.0 - User Account Management System
 */
@Controller
public class AccountController {

	// ================= DEPENDENCY INJECTION =================

	@Autowired
	UserDAO dao;

	@Autowired
	HttpSession session;

	@Autowired
	CookieService cookie;

	@Autowired
	ServletContext app;

	@Autowired
	MailService mailer;

	// ================= AUTHENTICATION OPERATIONS =================

	/**
	 * Hiển thị trang đăng nhập với thông tin từ cookie
	 * @param model Model để truyền dữ liệu cookie
	 * @return String view name cho login form
	 */
	@GetMapping("/account/login")
	public String login(Model model) {
		Cookie ckid = cookie.read("userid");
		Cookie ckpw = cookie.read("pass");
		if (ckid != null) { 
			String uid = ckid.getValue();
			String pwd = ckpw.getValue();

			model.addAttribute("uid", uid);
			model.addAttribute("pwd", pwd);
		}
		return "account/login";
	}

	/**
	 * Xử lý đăng nhập với validation và remember me
	 * @param model Model để truyền thông báo
	 * @param id Username đăng nhập
	 * @param pw Password đăng nhập
	 * @param rm Remember me option
	 * @return String redirect URL hoặc login view
	 */
	@PostMapping("/account/login")
	public String login(Model model, 
			@RequestParam("id") String id, 
			@RequestParam("pw") String pw, @RequestParam(value = "rm", defaultValue = "false") boolean rm) { 
		
		User user = dao.findById(id); 
		if (user == null) { 
			model.addAttribute("message", "Sai tên đăng nhập hoặc mật khẩu!");
		} else if (!pw.equals(user.getPassword())) { 
			model.addAttribute("message", "Sai mật khẩu!"); 
		} else if (user.getAdmin()) {
			model.addAttribute("message", "Bạn không có quyền!");
		} else {
			model.addAttribute("message", "Đăng nhập thành công!");
			session.setAttribute("user", user); 
			
			// Xử lý remember me
			if (rm == true) { 
				cookie.create("pass", user.getPassword(), 30); 
			} else { 
				cookie.delete("userid");
				cookie.delete("pass");
			}
			
			// Redirect về trang trước đó nếu có
			String backUrl = (String) session.getAttribute("back-url");
			if (backUrl != null) {
				return "redirect:" + backUrl;
			}
			return "redirect:/home";
		}
		return "account/login";
	}

	/**
	 * Xử lý đăng xuất và xóa session
	 * @param model Model object
	 * @return String redirect về trang chủ
	 */
	@RequestMapping("/account/logout") 
	public String logout(Model model) { 
		session.removeAttribute("user");
		return "redirect:/home";
	}

	// ================= REGISTRATION OPERATIONS =================

	/**
	 * Hiển thị form đăng ký tài khoản mới
	 * @param model Model để bind form
	 * @return String view name cho register form
	 */
	@GetMapping("/account/register")
	public String register(Model model) {
		User user = new User();
		model.addAttribute("form", user);
		return "account/register";
	}

	/**
	 * Xử lý đăng ký tài khoản với upload avatar
	 * @param model Model để truyền thông báo
	 * @param user User entity từ form
	 * @param errors BindingResult cho validation
	 * @param file MultipartFile cho avatar upload
	 * @return String view name sau khi xử lý
	 * @throws IllegalStateException File upload exception
	 * @throws IOException File I/O exception
	 * @throws MessagingException Email sending exception
	 */
	@PostMapping("/account/register")
	public String register(Model model, @Validated @ModelAttribute("form") User user, BindingResult errors,
			@RequestParam("photo_file") MultipartFile file)
			throws IllegalStateException, IOException, MessagingException {
		
		// Validation check
		if (errors.hasErrors()) {
			model.addAttribute("message", "Error");
			return "account/register";
		} else {
			User user2 = dao.findById(user.getId());
			if (user2 != null) {
				model.addAttribute("message", "Tên đăng nhập đã được sử dụng!");
				return "account/register";
			}
		}

		// Handle file upload
		if (file.isEmpty()) {
			user.setPhoto("user.png");
		} else {
			String dir = app.getRealPath("static/images/customers");
			File f = new File(dir, file.getOriginalFilename());
			file.transferTo(f);
			user.setPhoto(f.getName());
		}
		
		// Set default values and save
		user.setActivated(true);
		user.setAdmin(false);
		dao.create(user); 
		model.addAttribute("message", "Đăng ký thành công! Bạn có thể đăng nhập ngay bây giờ.");

		return "account/register";
	}

	// ================= PASSWORD RECOVERY OPERATIONS =================

	/**
	 * Hiển thị form quên mật khẩu
	 * @param model Model object
	 * @return String view name cho forgot password form
	 */
	@GetMapping("/account/forgot")
	public String forgot(Model model) {
		return "account/forgot";
	}

	/**
	 * Xử lý khôi phục mật khẩu và gửi email
	 * @param model Model để truyền thông báo
	 * @param id Username cần khôi phục
	 * @param email Email của user
	 * @return String view name sau khi xử lý
	 * @throws MessagingException Email sending exception
	 */
	@PostMapping("/account/forgot")
	public String forgot(Model model, 
			@RequestParam("id") String id, 
			@RequestParam("email") String email)
			throws MessagingException {
		User user = dao.findById(id);
		if (user == null) {
			model.addAttribute("message", "Tên tài khoản không đúng!");
		} else if (!email.equals(user.getEmail())) {
			model.addAttribute("message", "Email không đúng!");
		} else {
			// Gửi email khôi phục mật khẩu
			String from = "happyshopsuport2022@gmail.com";
			String to = user.getEmail();
			String subject = "Quên mật khẩu!";
			String body = "Happy Shop xin chào! Mật khẩu của bạn là: " + user.getPassword();
			MailInfo mail = new MailInfo(from, to, subject, body);
			mailer.send(mail);
			model.addAttribute("message", "Mật khẩu đã được gửi đến mail của bạn!");
		}
		return "account/forgot";
	}

	// ================= PASSWORD CHANGE OPERATIONS =================

	/**
	 * Hiển thị form thay đổi mật khẩu
	 * @param model Model để bind user hiện tại
	 * @return String view name cho change password form
	 */
	@GetMapping("/account/change")
	public String change(Model model) {
		User user = (User) session.getAttribute("user");
		model.addAttribute("form", user);
		return "account/change";
	}

	/**
	 * Xử lý thay đổi mật khẩu với validation
	 * @param model Model để truyền thông báo
	 * @param users User entity từ form
	 * @param id Username
	 * @param pw Mật khẩu hiện tại
	 * @param pw1 Mật khẩu mới
	 * @param pw2 Xác nhận mật khẩu mới
	 * @return String view name sau khi xử lý
	 */
	@PostMapping("/account/change")
	public String change(Model model, 
			@ModelAttribute("form") User users,
			@RequestParam("id") String id, 
			@RequestParam("pw") String pw,
			@RequestParam("pw1") String pw1, 
			@RequestParam("pw2") String pw2) {
		if (!pw1.equals(pw2)) {
			model.addAttribute("message", "Xác nhận mật khẩu không trùng khớp!");
		} else {
			User user = dao.findById(id);
			if (user == null) {
				model.addAttribute("message", "Sai tài khoản!");
			} else if (!pw.equals(user.getPassword())) {
				model.addAttribute("message", "Mật khẩu hiện tại không đúng!");
			} else {
				user.setPassword(pw1);
				dao.update(user);
				model.addAttribute("message", "Thay đổi mật khẩu thành công!");
			}
		}
		return "account/change";
	}

	// ================= PROFILE EDIT OPERATIONS =================

	/**
	 * Hiển thị form chỉnh sửa thông tin cá nhân
	 * @param model Model để bind user hiện tại
	 * @return String view name cho edit profile form
	 */
	@GetMapping("/account/edit")
	public String edit(Model model) {
		User user = (User) session.getAttribute("user");
		model.addAttribute("form", user);
		return "account/edit";
	}

	/**
	 * Xử lý cập nhật thông tin cá nhân và avatar
	 * @param model Model để truyền thông báo
	 * @param user User entity từ form
	 * @param errors BindingResult cho validation
	 * @param file MultipartFile cho avatar upload
	 * @return String view name sau khi xử lý
	 * @throws IllegalStateException File upload exception
	 * @throws IOException File I/O exception
	 * @throws MessagingException Messaging exception
	 */
	@PostMapping("/account/edit")
	public String edit(Model model, @ModelAttribute("form") User user,BindingResult errors,
			@RequestParam("photo_file") MultipartFile file) throws IllegalStateException, IOException, MessagingException {
		if (errors.hasErrors()) {
			model.addAttribute("message", "Vui lòng sửa các lỗi sau đây!");
			return "account/edit";
		} 
		
		// Handle new photo upload
		if(!file.isEmpty()) {
			String dir = app.getRealPath("static/images/customers");
			File f = new File(dir, file.getOriginalFilename());
			file.transferTo(f);
			user.setPhoto(f.getName());
		}
		
		// Update user and session
		dao.update(user);
		session.setAttribute("user", user);
		model.addAttribute("message", "Cập nhật tài khoản thành công!");

		return "account/edit";
	}
}
