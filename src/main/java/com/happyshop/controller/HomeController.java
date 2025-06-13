package com.happyshop.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.happyshop.dao.ProductDAO;
import com.happyshop.entity.Product;

/**
 * ===== CONTROLLER TRANG CHỦ USER =====
 * 
 * Controller xử lý các trang chính của website:
 * - Trang chủ với sản phẩm nổi bật
 * - Các trang thông tin (About, Contact, FAQ)
 * - Hiển thị sản phẩm mới nhất
 * 
 * Tính năng:
 * - Homepage product showcase
 * - Static information pages
 * - Featured products display
 * 
 * Author: Development Team
 * Version: 2.0 - Simplified Website Controller
 */
@Controller
public class HomeController {
	
	// ================= DEPENDENCY INJECTION =================
	
	@Autowired
	ProductDAO pdao;
	
	// ================= MAIN OPERATIONS =================
	
	/**
	 * Hiển thị trang chủ với sản phẩm nổi bật và mới nhất
	 * @param model Model để truyền dữ liệu sản phẩm
	 * @return String view name cho homepage
	 */
	@RequestMapping(value = {"", "/home"})
	public String index(Model model) {
		// Lấy 4 sản phẩm đặc biệt (special = true)
		List<Product> specialProducts = pdao.findSpecialProducts(4);
		model.addAttribute("list", specialProducts);
		
		// Lấy sản phẩm mới nhất (active products)
		List<Product> latestProducts = pdao.findActiveProducts(8);
		model.addAttribute("list1", latestProducts);
		
		return "home/index";
	}
	
	// ================= STATIC PAGES =================
	
	/**
	 * Hiển thị trang giới thiệu về cửa hàng
	 * @return String view name cho about page
	 */
	@RequestMapping("/about")
	public String about() {
		return "home/about";
	}
	
	/**
	 * Hiển thị trang thông tin liên hệ
	 * @return String view name cho contact page
	 */
	@RequestMapping("/contact")
	public String contact() {
		return "home/contact";
	}
	

	
	/**
	 * Hiển thị trang FAQ (Frequently Asked Questions)
	 * @return String view name cho FAQ page
	 */
	@RequestMapping("/faq")
	public String faq() {
		return "home/faq";
	}
	
	// ================= UTILITY OPERATIONS =================
	

}
