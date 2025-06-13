package com.happyshop.controller.admin;

import java.io.File;
import java.io.IOException;


import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.happyshop.dao.UserDAO;
import com.happyshop.entity.User;
import com.happyshop.service.CookieService;

/**
 * ===== CONTROLLER QUẢN LÝ TÀI KHOẢN ADMIN =====
 * 
 * Controller xử lý các chức năng tài khoản admin:
 * - Đăng xuất admin
 * - Quản lý profile admin
 * - Đổi mật khẩu admin
 * - Kích hoạt tài khoản người dùng
 * 
 * Note: Đăng nhập admin đã được tích hợp vào /account/login
 * 
 * Tính năng:
 * - Profile management với upload ảnh
 * - Password change với validation
 * - User account activation
 * 
 * Author: Development Team
 * Version: 2.0 - Unified Login System
 */
@Controller
public class AccountAdminController {

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
	HttpServletRequest request;

	@RequestMapping("/admin/logout")
	public String logout(Model model) {
		session.removeAttribute("user");
		return "redirect:/account/login";
	}
	
	@GetMapping("/admin/account/activate/{id}")
	public String activate(Model model,@PathVariable("id") String id) {
		User user = dao.findById(id);
		user.setActivated(true);
		dao.update(user);
		
		return "redirect:/account/login";
	}
	
	@GetMapping("/admin/profile")
	public String edit(Model model) {
		User user = (User) session.getAttribute("user");
		model.addAttribute("form", user);

		return "admin/account/edit";
	}

	@PostMapping("/admin/profile")
	public String edit(Model model, @ModelAttribute("form") User user,BindingResult errors,
			@RequestParam("photo_file") MultipartFile file) throws IllegalStateException, IOException {
		if (errors.hasErrors()) {
			model.addAttribute("message", "Vui lòng sửa các lỗi sau đây!");
			return "admin/account/edit";
		} 
		if(!file.isEmpty()) {
			try {
				// Kiểm tra định dạng file
				String contentType = file.getContentType();
				if (contentType == null || !contentType.startsWith("image/")) {
					model.addAttribute("message", "Vui lòng chọn file ảnh hợp lệ!");
					return "admin/account/edit";
				}
				
				// Kiểm tra kích thước file (max 2MB)
				if (file.getSize() > 2 * 1024 * 1024) {
					model.addAttribute("message", "Kích thước ảnh không được vượt quá 2MB!");
					return "admin/account/edit";
				}
				
				String dir = app.getRealPath("static/images/customers");
				File directory = new File(dir);
				
				// Tạo thư mục nếu không tồn tại
				if (!directory.exists()) {
					directory.mkdirs();
				}
				
				File f = new File(dir, file.getOriginalFilename());
				file.transferTo(f);
				user.setPhoto(f.getName());
			} catch (Exception e) {
				model.addAttribute("message", "Lỗi khi upload ảnh: " + e.getMessage());
				return "admin/account/edit";
			}
		}
		dao.update(user);
		session.setAttribute("user", user);

		model.addAttribute("message", "Cập nhật thành công!");

		return "admin/account/edit";
	}
	
	@GetMapping("/admin/change")
	public String change(Model model) {
		User user = (User) session.getAttribute("user");
		model.addAttribute("form", user);
		return "admin/account/change";
	}

	@PostMapping("/admin/change")
	public String change(Model model, 
			@ModelAttribute("form") User users,
			@RequestParam("id") String id, 
			@RequestParam("pw") String pw,
			@RequestParam("pw1") String pw1, 
			@RequestParam("pw2") String pw2) {
		
		// Kiểm tra mật khẩu mới có ít nhất 6 ký tự
		if (pw1.length() < 6) {
			model.addAttribute("message", "Mật khẩu mới phải có ít nhất 6 ký tự!");
			return "admin/account/change";
		}
		
		// Kiểm tra xác nhận mật khẩu
		if (!pw1.equals(pw2)) {
			model.addAttribute("message", "Xác nhận mật khẩu không trùng khớp!");
			return "admin/account/change";
		}
		
		User user = dao.findById(id);
		if (user == null) {
			model.addAttribute("message", "Tài khoản không tồn tại!");
			return "admin/account/change";
		}
		
		if (!pw.equals(user.getPassword())) {
			model.addAttribute("message", "Mật khẩu hiện tại không đúng!");
			return "admin/account/change";
		}
		
		// Cập nhật mật khẩu mới
		user.setPassword(pw1);
		dao.update(user);
		// Cập nhật session
		session.setAttribute("user", user);

		model.addAttribute("message", "Thay đổi mật khẩu thành công!");
		return "admin/account/change";
	}
	

	
}








