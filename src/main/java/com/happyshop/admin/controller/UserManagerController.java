package com.happyshop.admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.happyshop.dao.UserDAO;
import com.happyshop.entity.User;

/**
 * ===== CONTROLLER QUẢN LÝ NGƯỜI DÙNG =====
 * 
 * Xử lý tất cả các yêu cầu liên quan đến quản lý người dùng:
 * - CRUD operations (Create, Read, Update)
 * - Cấm/Mở cấm người dùng
 * - Upload và xử lý hình ảnh avatar
 * - Thống kê và báo cáo
 * 
 * Author: Admin System
 * Version: 1.0 - User Management System
 */
@Controller
@RequestMapping("/admin/user")
public class UserManagerController {

	// ================= DEPENDENCY INJECTION =================
	
	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private ServletContext servletContext;

	// ================= MAIN CRUD OPERATIONS =================
	
	/**
	 * Hiển thị trang danh sách người dùng chính
	 * Bao gồm thống kê và danh sách người dùng
	 */
	@GetMapping("/index")
	public String index(Model model) {
		try {
			// Lấy danh sách tất cả người dùng
			List<User> users = userDAO.findAll();
			model.addAttribute("list", users);
			
			// Thêm thống kê vào model
			addStatisticsToModel(model, users);
			
			return "admin/user/index";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Có lỗi xảy ra khi tải danh sách người dùng: " + e.getMessage());
			return "admin/user/index";
		}
	}
	
	/**
	 * Hiển thị trang thêm người dùng mới
	 */
	@GetMapping("/insert")
	public String showInsertForm(Model model) {
		try {
			// Tạo user trống cho form
			User user = new User();
			model.addAttribute("user", user);
			
			return "admin/user/insert";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Có lỗi xảy ra khi tải form thêm người dùng: " + e.getMessage());
			return "admin/user/index";
		}
	}
	
	/**
	 * Xử lý thêm người dùng mới
	 */
	@PostMapping("/insert")
	public String insert(@ModelAttribute("user") User user,
	                    @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
	                    RedirectAttributes redirectAttributes) {
		try {
			// Kiểm tra trùng username
			User existingUser = userDAO.findById(user.getId());
			if (existingUser != null) {
				redirectAttributes.addFlashAttribute("error", 
					"Tên đăng nhập '" + user.getId() + "' đã được sử dụng!");
				return "redirect:/admin/user/insert";
			}
			
			// Xử lý upload hình ảnh
			handleImageUpload(user, imageFile);
			
			// Mặc định người dùng được kích hoạt và không bị cấm
			if (user.getActivated() == null) {
				user.setActivated(true);
			}
			
			if (user.getIsBanned() == null) {
				user.setIsBanned(false);
			}
			
			// Mặc định không phải admin
			if (user.getAdmin() == null) {
				user.setAdmin(false);
			}
			
			// Debug: In thông tin user trước khi lưu
			System.out.println("=== DEBUG USER BEFORE SAVE ===");
			System.out.println("ID: " + user.getId());
			System.out.println("Telephone: '" + user.getTelephone() + "'");
			System.out.println("Telephone length: " + (user.getTelephone() != null ? user.getTelephone().length() : "null"));
			System.out.println("========================");
			
			// Lưu người dùng vào database
			userDAO.create(user);
			
			redirectAttributes.addFlashAttribute("message", 
				"Thêm người dùng '" + user.getFullname() + "' thành công!");
			return "redirect:/admin/user/index";
			
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", 
				"Có lỗi xảy ra khi thêm người dùng: " + e.getMessage());
			return "redirect:/admin/user/insert";
		}
	}
	
	/**
	 * Hiển thị trang chỉnh sửa người dùng
	 */
	@GetMapping("/edit/{id}")
	public String showEditForm(@PathVariable("id") String id, Model model) {
		try {
			// Tìm người dùng theo ID
			User user = userDAO.findById(id);
			if (user == null) {
				model.addAttribute("error", "Không tìm thấy người dùng với ID: " + id);
				return "redirect:/admin/user/index";
			}
			
			model.addAttribute("user", user);
			
			return "admin/user/edit";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Có lỗi xảy ra khi tải thông tin người dùng: " + e.getMessage());
			return "redirect:/admin/user/index";
		}
	}
	
	/**
	 * Xử lý cập nhật thông tin người dùng
	 */
	@PostMapping("/edit/{id}")
	public String update(@PathVariable("id") String id,
	                    @ModelAttribute("user") User user,
	                    @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
	                    RedirectAttributes redirectAttributes) {
		try {
			// Lấy thông tin người dùng hiện tại từ database
			User existingUser = userDAO.findById(id);
			if (existingUser == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy người dùng để cập nhật");
				return "redirect:/admin/user/index";
			}
			
			// Cập nhật các trường có thể chỉnh sửa
			updateUserFields(existingUser, user);
			
			// Xử lý upload hình ảnh nếu có
			handleImageUpdate(existingUser, imageFile);
			
			// Cập nhật vào database
			userDAO.update(existingUser);
			
			redirectAttributes.addFlashAttribute("message", 
				"Cập nhật thông tin người dùng '" + existingUser.getFullname() + "' thành công!");
			return "redirect:/admin/user/edit/" + id;
			
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", 
				"Có lỗi xảy ra khi cập nhật người dùng: " + e.getMessage());
			return "redirect:/admin/user/edit/" + id;
		}
	}
	
	/**
	 * Cấm người dùng (đánh dấu isBanned = true)
	 */
	@PostMapping("/ban/{id}")
	public String banUser(@PathVariable("id") String id, RedirectAttributes redirectAttributes) {
		try {
			User user = userDAO.findById(id);
			if (user == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy người dùng để cấm");
				return "redirect:/admin/user/index";
			}
			
			user.setIsBanned(true);
			userDAO.update(user);
			
			redirectAttributes.addFlashAttribute("message", 
				"Đã cấm người dùng '" + user.getFullname() + "' thành công!");
			return "redirect:/admin/user/index";
			
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", 
				"Có lỗi xảy ra khi cấm người dùng: " + e.getMessage());
			return "redirect:/admin/user/index";
		}
	}
	
	/**
	 * Mở cấm người dùng (đánh dấu isBanned = false)
	 */
	@PostMapping("/unban/{id}")
	public String unbanUser(@PathVariable("id") String id, RedirectAttributes redirectAttributes) {
		try {
			User user = userDAO.findById(id);
			if (user == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy người dùng để mở cấm");
				return "redirect:/admin/user/index";
			}
			
			user.setIsBanned(false);
			userDAO.update(user);
			
			redirectAttributes.addFlashAttribute("message", 
				"Đã mở cấm người dùng '" + user.getFullname() + "' thành công!");
			return "redirect:/admin/user/index";
			
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", 
				"Có lỗi xảy ra khi mở cấm người dùng: " + e.getMessage());
			return "redirect:/admin/user/index";
		}
	}

	// ================= PRIVATE HELPER METHODS =================
	
	/**
	 * Xử lý upload hình ảnh cho người dùng mới
	 */
	private void handleImageUpload(User user, MultipartFile imageFile) throws IOException {
		if (imageFile != null && !imageFile.isEmpty()) {
			String fileName = imageFile.getOriginalFilename();
			user.setPhoto(fileName);
			
			// Lưu file vào thư mục
			String uploadPath = servletContext.getRealPath("/static/images/customers/" + fileName);
			File uploadFile = new File(uploadPath);
			
			// Tạo thư mục nếu chưa tồn tại
			uploadFile.getParentFile().mkdirs();
			
			imageFile.transferTo(uploadFile);
		} else {
			// Sử dụng ảnh mặc định
			user.setPhoto("user.png");
		}
	}
	
	/**
	 * Xử lý cập nhật hình ảnh cho người dùng hiện có
	 */
	private void handleImageUpdate(User existingUser, MultipartFile imageFile) throws IOException {
		if (imageFile != null && !imageFile.isEmpty()) {
			String fileName = imageFile.getOriginalFilename();
			existingUser.setPhoto(fileName);
			
			// Lưu file mới
			String uploadPath = servletContext.getRealPath("/static/images/customers/" + fileName);
			File uploadFile = new File(uploadPath);
			uploadFile.getParentFile().mkdirs();
			imageFile.transferTo(uploadFile);
		}
		// Nếu không có file mới, giữ nguyên ảnh cũ
	}
	
	/**
	 * Cập nhật các trường thông tin người dùng
	 */
	private void updateUserFields(User existingUser, User newUser) {
		if (newUser.getFullname() != null && !newUser.getFullname().trim().isEmpty()) {
			existingUser.setFullname(newUser.getFullname());
		}
		if (newUser.getEmail() != null && !newUser.getEmail().trim().isEmpty()) {
			existingUser.setEmail(newUser.getEmail());
		}
		if (newUser.getTelephone() != null && !newUser.getTelephone().trim().isEmpty()) {
			existingUser.setTelephone(newUser.getTelephone());
		}
		if (newUser.getPassword() != null && !newUser.getPassword().trim().isEmpty()) {
			existingUser.setPassword(newUser.getPassword());
		}
		if (newUser.getActivated() != null) {
			existingUser.setActivated(newUser.getActivated());
		}
		if (newUser.getIsBanned() != null) {
			existingUser.setIsBanned(newUser.getIsBanned());
		}
		if (newUser.getAdmin() != null) {
			existingUser.setAdmin(newUser.getAdmin());
		}
	}
	
	/**
	 * Thêm thống kê vào model
	 */
	private void addStatisticsToModel(Model model, List<User> users) {
		if (users != null) {
			int totalUsers = users.size();
			int activeUsers = (int) users.stream().filter(u -> u.getActivated() == null || u.getActivated()).count();
			int bannedUsers = (int) users.stream().filter(u -> u.getIsBanned() != null && u.getIsBanned()).count();
			int adminUsers = (int) users.stream().filter(u -> u.getAdmin() != null && u.getAdmin()).count();
			int regularUsers = totalUsers - adminUsers;
			
			model.addAttribute("totalUsers", totalUsers);
			model.addAttribute("activeUsers", activeUsers);
			model.addAttribute("bannedUsers", bannedUsers);
			model.addAttribute("adminUsers", adminUsers);
			model.addAttribute("regularUsers", regularUsers);
		} else {
			model.addAttribute("totalUsers", 0);
			model.addAttribute("activeUsers", 0);
			model.addAttribute("bannedUsers", 0);
			model.addAttribute("adminUsers", 0);
			model.addAttribute("regularUsers", 0);
		}
	}
} 