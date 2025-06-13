package com.happyshop.admin.controller;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.happyshop.dao.OrderDAO;
import com.happyshop.dao.ProductDAO;
import com.happyshop.dao.UserDAO;
import com.happyshop.entity.Order;
import com.happyshop.entity.Product;
import com.happyshop.entity.User;

/**
 * ===== CONTROLLER TRANG CHỦ ADMIN =====
 * 
 * Controller xử lý trang chủ admin dashboard:
 * - Hiển thị thống kê tổng quan hệ thống
 * - Thống kê người dùng, sản phẩm, đơn hàng
 * - Tính toán doanh thu tổng
 * - Hiển thị đơn hàng gần đây
 * 
 * Tính năng:
 * - Dashboard overview với key metrics
 * - Real-time statistics display
 * - Recent orders monitoring
 * - Low stock alerts
 * 
 * Author: Development Team
 * Version: 1.0 - Admin Dashboard System
 */
@Controller
public class AdminHomeController {
	
	// ================= DEPENDENCY INJECTION =================
	
	@Autowired
	UserDAO userDao;
	
	@Autowired
	ProductDAO productDao;
	
	@Autowired
	OrderDAO orderDao;
	
	// ================= MAIN OPERATIONS =================
	
	/**
	 * Hiển thị trang dashboard admin với thống kê tổng quan
	 * @param model Model để truyền dữ liệu ra view
	 * @return String view name cho admin dashboard
	 */
	@RequestMapping("/admin/home/index")
	public String index(Model model) {
		
		// Lấy dữ liệu từ database
		List<User> allUsers = userDao.findAll();
		List<Product> allProducts = productDao.findAll();
		List<Order> allOrders = orderDao.findAll();
		
		// Thống kê người dùng
		long totalUsers = allUsers.size();
		long activeUsers = allUsers.stream().filter(u -> u.getActivated()).count();
		
		// Thống kê sản phẩm
		long totalProducts = allProducts.size();
		long activeProducts = allProducts.stream().filter(p -> p.getAvailable()).count();
		
		// Thống kê đơn hàng
		long totalOrders = allOrders.size();
		long completedOrders = allOrders.stream().filter(o -> o.getStatus() != null && o.getStatus() == 3).count();
		
		// Tính tổng doanh thu (chỉ đơn hàng hoàn thành)
		double totalRevenue = allOrders.stream()
			.filter(o -> o.getStatus() != null && o.getStatus() == 3)
			.mapToDouble(o -> o.getAmount() != null ? o.getAmount() : 0.0)
			.sum();
		
		// 5 đơn hàng gần đây nhất
		List<Order> recentOrders = allOrders.stream()
			.sorted((o1, o2) -> o2.getOrderDate().compareTo(o1.getOrderDate()))
			.limit(5)
			.collect(Collectors.toList());
		
		// Sản phẩm sắp hết hàng (quantity <= 10)
		List<Product> lowStockProducts = allProducts.stream()
			.filter(p -> p.getQuantity() <= 10)
			.sorted((p1, p2) -> Integer.compare(p1.getQuantity(), p2.getQuantity()))
			.collect(Collectors.toList());
		
		// Đưa dữ liệu vào model
		model.addAttribute("totalUsers", totalUsers);
		model.addAttribute("activeUsers", activeUsers);
		model.addAttribute("totalProducts", totalProducts);
		model.addAttribute("activeProducts", activeProducts);
		model.addAttribute("totalOrders", totalOrders);
		model.addAttribute("completedOrders", completedOrders);
		model.addAttribute("totalRevenue", totalRevenue);
		model.addAttribute("recentOrders", recentOrders);
		model.addAttribute("lowStockProducts", lowStockProducts);
		
		return "admin/home/index";
	}
}
