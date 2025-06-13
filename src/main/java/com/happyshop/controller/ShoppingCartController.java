package com.happyshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.happyshop.service.CartService;

/**
 * ===== CONTROLLER GIỎ HÀNG =====
 * 
 * Controller xử lý các thao tác giỏ hàng:
 * - Thêm sản phẩm vào giỏ hàng
 * - Cập nhật số lượng sản phẩm
 * - Xóa sản phẩm khỏi giỏ hàng
 * - Xem giỏ hàng và xóa toàn bộ
 * 
 * Tính năng:
 * - AJAX-based cart operations
 * - Real-time cart update
 * - Cart quantity management
 * - Shopping cart view rendering
 * 
 * Author: Development Team
 * Version: 1.0 - Shopping Cart Management System
 */
@Controller
public class ShoppingCartController {
	
	// ================= DEPENDENCY INJECTION =================
	
	@Autowired
	CartService cart;
	
	// ================= CART OPERATIONS =================
	
	/**
	 * Cập nhật số lượng sản phẩm trong giỏ hàng (AJAX)
	 * @param id ID của sản phẩm
	 * @param qty Số lượng mới
	 * @return Object[] chứa [count, amount] của giỏ hàng
	 */
	@ResponseBody
	@RequestMapping("/cart/update/{id}/{qty}")
	public Object[] update(@PathVariable("id") Integer id, @PathVariable("qty") Integer qty) {
		cart.update(id,qty);
		Object[] info= {cart.getCount(), cart.getAmount()};
		return info;
	}
	
	/**
	 * Thêm sản phẩm vào giỏ hàng (AJAX)
	 * @param id ID của sản phẩm cần thêm
	 * @return Object[] chứa [count, amount] của giỏ hàng sau khi thêm
	 */
	@ResponseBody
	@RequestMapping("/cart/add/{id}")
	public Object[] add(@PathVariable("id") Integer id) {
		cart.add(id);
		Object[] info= {cart.getCount(), cart.getAmount()};
		return info;
	}
	
	/**
	 * Xóa sản phẩm khỏi giỏ hàng (AJAX)
	 * @param id ID của sản phẩm cần xóa
	 * @return Object[] chứa [count, amount] của giỏ hàng sau khi xóa
	 */
	@ResponseBody
	@RequestMapping("/cart/remove/{id}")
	public Object[] remove(@PathVariable("id") Integer id) {
		cart.remove(id);
		Object[] info= {cart.getCount(), cart.getAmount()};
		return info;
	}
	
	// ================= VIEW OPERATIONS =================
	
	/**
	 * Hiển thị trang xem giỏ hàng
	 * @return String view name cho cart view
	 */
	@RequestMapping("/cart/view")
	public String view() {
		return "cart/view";
	}
	
	/**
	 * Xóa toàn bộ giỏ hàng (AJAX)
	 */
	@ResponseBody
	@RequestMapping("/cart/clear")
	public void clear() {
		cart.clear();
	}
}
