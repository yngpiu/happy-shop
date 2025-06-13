package com.happyshop.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.happyshop.dao.OrderDAO;
import com.happyshop.dao.OrderDetailDAO;
import com.happyshop.dao.ProductDAO;
import com.happyshop.entity.Order;
import com.happyshop.entity.OrderDetail;
import com.happyshop.entity.Product;
import com.happyshop.entity.User;
import com.happyshop.service.CartService;

/**
 * ===== CONTROLLER ĐƠN HÀNG USER =====
 * 
 * Controller xử lý các chức năng đơn hàng phía user:
 * - Thanh toán đơn hàng từ giỏ hàng
 * - Hiển thị danh sách đơn hàng của user
 * - Xem chi tiết đơn hàng cụ thể
 * - Xem lịch sử sản phẩm đã mua
 * 
 * Tính năng:
 * - Order checkout process
 * - Order history management
 * - Order detail viewing
 * - Purchase item tracking
 * 
 * Author: Development Team
 * Version: 1.0 - User Order Management System
 */
@Controller
public class OrderController {
	
	// ================= DEPENDENCY INJECTION =================
	
	@Autowired
	ProductDAO pdao;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	CartService cart;
	
	@Autowired
	OrderDAO dao;
	
	@Autowired
	OrderDetailDAO ddao;

	// ================= CHECKOUT OPERATIONS =================

	/**
	 * Hiển thị form thanh toán với thông tin đơn hàng
	 * @param order Order entity để bind form data
	 * @return String view name cho checkout form
	 */
	@GetMapping("/order/checkout")
	public String showForm(@ModelAttribute("order") Order order) {
		User user = (User) session.getAttribute("user");

		order.setOrderDate(new Date());
		order.setUser(user);
		order.setAmount(cart.getAmount());
		order.setStatus(1);
		return "order/checkout";
	}
	
	/**
	 * Xử lý thanh toán đơn hàng và tạo order details
	 * @param model Model để truyền thông báo
	 * @param order Order entity từ form
	 * @return String redirect URL sau khi đặt hàng thành công
	 */
	@PostMapping("/order/checkout")
	public String purchase(Model model, 
			@ModelAttribute("order") Order order){
		Collection<Product> list = cart.getItems();
		List<OrderDetail> details = new  ArrayList<>();
		
		// Tạo order details từ cart items
		for(Product product:list) {
			OrderDetail detail =new OrderDetail();
			detail.setOrder(order);
			detail.setProduct(product);
			detail.setUnitPrice(product.getUnitPrice());
			detail.setQuantity(product.getQuantity());
			detail.setDiscount(product.getDiscount());
			details.add(detail);
		}
		
		// Lưu order và details
		dao.create(order, details);
		cart.clear();
		 
		model.addAttribute("message", "Đặt hàng thành công!");
		
		return "redirect:/order/list";
	}
	
	// ================= ORDER VIEWING OPERATIONS =================
	
	/**
	 * Hiển thị danh sách đơn hàng của user hiện tại
	 * @param model Model để truyền danh sách orders
	 * @return String view name cho order list
	 */
	@GetMapping("/order/list")
	public String list(Model model) {
		User user = (User) session.getAttribute("user");
		List<Order> orders = dao.findByUser(user);
		model.addAttribute("orders", orders);
		return "order/list";
	}
	
	/**
	 * Hiển thị chi tiết đơn hàng cụ thể
	 * @param model Model để truyền order và details
	 * @param id ID của đơn hàng
	 * @return String view name cho order detail
	 */
	@GetMapping("/order/detail/{id}")
	public String detail(Model model, @PathVariable("id") Integer id) {
		Order order = dao.findById(id);
		List<OrderDetail> details = ddao.findByOrder(order);
		model.addAttribute("order", order);
		model.addAttribute("details", details);
		return "order/detail";
	}
	
	/**
	 * Hiển thị danh sách sản phẩm đã mua của user
	 * @param model Model để truyền danh sách items
	 * @return String view name cho purchased items
	 */
	@GetMapping("/order/items")
	public String items(Model model) {
		User user = (User) session.getAttribute("user");
		List<Product> list = dao.findItemsByUser(user);
		model.addAttribute("list", list);
		return "product/list_order_item";
	}
}




