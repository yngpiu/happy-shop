package com.happyshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.http.ResponseEntity;
import java.util.HashMap;
import java.util.Map;

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
	 * @return ResponseEntity với thông tin cart hoặc lỗi
	 */
	@ResponseBody
	@RequestMapping("/cart/update/{id}/{qty}")
	public ResponseEntity<Map<String, Object>> update(@PathVariable("id") Integer id, @PathVariable("qty") Integer qty) {
		try {
			cart.update(id, qty);
			
			Map<String, Object> response = new HashMap<>();
			response.put("success", true);
			response.put("count", cart.getCount());
			response.put("amount", cart.getAmount());
			response.put("message", "Cập nhật số lượng thành công");
			
			return ResponseEntity.ok(response);
		} catch (RuntimeException e) {
			Map<String, Object> response = new HashMap<>();
			response.put("success", false);
			response.put("message", e.getMessage());
			
			return ResponseEntity.badRequest().body(response);
		}
	}
	
	/**
	 * Thêm sản phẩm vào giỏ hàng (AJAX)
	 * @param id ID của sản phẩm cần thêm
	 * @return ResponseEntity với thông tin cart hoặc lỗi
	 */
	@ResponseBody
	@RequestMapping("/cart/add/{id}")
	public ResponseEntity<Map<String, Object>> add(@PathVariable("id") Integer id) {
		try {
			cart.add(id);
			
			Map<String, Object> response = new HashMap<>();
			response.put("success", true);
			response.put("count", cart.getCount());
			response.put("amount", cart.getAmount());
			response.put("message", "Thêm sản phẩm vào giỏ hàng thành công");
			
			return ResponseEntity.ok(response);
		} catch (RuntimeException e) {
			Map<String, Object> response = new HashMap<>();
			response.put("success", false);
			response.put("message", e.getMessage());
			
			return ResponseEntity.badRequest().body(response);
		}
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
	
	/**
	 * Lấy số lượng sản phẩm trong giỏ hàng (AJAX)
	 * @return Integer số lượng sản phẩm trong giỏ hàng
	 */
	@ResponseBody
	@RequestMapping("/cart/count")
	public Integer getCount() {
		return cart.getCount();
	}
	
	/**
	 * Cập nhật số lượng sản phẩm trong giỏ hàng (POST method)
	 * @param id ID của sản phẩm
	 * @param quantity Số lượng mới từ form data
	 * @return ResponseEntity với thông tin cart
	 */
	@ResponseBody
	@RequestMapping(value = "/cart/update/{id}", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updateQuantity(
			@PathVariable("id") Integer id, 
			@RequestParam("quantity") Integer quantity) {
		
		try {
			cart.update(id, quantity);
			
			Map<String, Object> response = new HashMap<>();
			response.put("success", true);
			response.put("count", cart.getCount());
			response.put("amount", cart.getAmount());
			response.put("message", "Cập nhật thành công");
			
			return ResponseEntity.ok(response);
		} catch (RuntimeException e) {
			Map<String, Object> response = new HashMap<>();
			response.put("success", false);
			response.put("message", e.getMessage());
			
			return ResponseEntity.badRequest().body(response);
		} catch (Exception e) {
			Map<String, Object> response = new HashMap<>();
			response.put("success", false);
			response.put("message", "Lỗi khi cập nhật giỏ hàng: " + e.getMessage());
			
			return ResponseEntity.badRequest().body(response);
		}
	}
	
	/**
	 * Lấy thông tin tóm tắt giỏ hàng (AJAX)
	 * @return Map chứa thông tin tóm tắt giỏ hàng
	 */
	@ResponseBody
	@RequestMapping("/cart/summary")
	public Map<String, Object> getSummary() {
		Map<String, Object> summary = new HashMap<>();
		summary.put("count", cart.getCount());
		summary.put("subtotal", cart.getAmount());
		
		// Calculate total with shipping
		double total = cart.getAmount();
		if (total > 0 && total < 500000) {
			total += 30000; // Add shipping fee
		}
		summary.put("total", total);
		
		return summary;
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
