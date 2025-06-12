package com.happyshop.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.happyshop.dao.OrderDAO;
import com.happyshop.dao.OrderDetailDAO;
import com.happyshop.entity.Order;

/**
 * ===== CONTROLLER QUẢN LÝ ĐỚN HÀNG =====
 * 
 * Xử lý các chức năng quản lý đơn hàng:
 * - Xem danh sách đơn hàng
 * - Xem chi tiết đơn hàng  
 * - Thay đổi trạng thái đơn hàng
 * - Thống kê và báo cáo
 * 
 * Không có chức năng: thêm, sửa, xóa đơn hàng
 * 
 * Author: Admin System
 * Version: 1.0 - Order Management System
 */
@Controller
@RequestMapping("/admin/order")
public class OrderManager {

	// ================= DEPENDENCY INJECTION =================
	
	@Autowired
	private OrderDAO orderDAO;
	
	@Autowired 
	private OrderDetailDAO orderDetailDAO;

	// ================= MAIN OPERATIONS =================
	
	/**
	 * Hiển thị trang danh sách đơn hàng chính
	 * Bao gồm thống kê và danh sách đơn hàng
	 */
	@GetMapping("/index")
	public String index(Model model) {
		try {
			// Lấy danh sách tất cả đơn hàng
			List<Order> orders = orderDAO.findAll();
			model.addAttribute("list", orders);
			
			// Thêm thống kê vào model
			addStatisticsToModel(model, orders);
			
			// Thêm số lượng sản phẩm cho từng đơn hàng
			addItemCountsToModel(model, orders);
			
			return "admin/order/index";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Có lỗi xảy ra khi tải danh sách đơn hàng: " + e.getMessage());
			return "admin/order/index";
		}
	}
	
	/**
	 * Hiển thị chi tiết đơn hàng
	 */
	@GetMapping("/details/{id}")
	public String details(@PathVariable("id") Integer id, Model model) {
		try {
			// Tìm đơn hàng theo ID
			Order order = orderDAO.findById(id);
			if (order == null) {
				model.addAttribute("error", "Không tìm thấy đơn hàng với ID: " + id);
				return "redirect:/admin/order/index";
			}
			
			model.addAttribute("order", order);
			
			// Lấy chi tiết đơn hàng
			model.addAttribute("orderDetails", orderDetailDAO.findByOrder(order));
			
			return "admin/order/details";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Có lỗi xảy ra khi tải thông tin đơn hàng: " + e.getMessage());
			return "redirect:/admin/order/index";
		}
	}

	// ================= STATUS MANAGEMENT =================
	
	/**
	 * Thay đổi trạng thái đơn hàng thành "Đang xử lý" (status = 1)
	 */
	@PostMapping("/process/{id}")
	public String processOrder(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
		try {
			Order order = orderDAO.findById(id);
			if (order == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy đơn hàng để xử lý");
				return "redirect:/admin/order/index";
			}
			
			order.setStatus(1); // Đang xử lý
			orderDAO.update(order);
			
			redirectAttributes.addFlashAttribute("message", 
				"Đã chuyển đơn hàng #" + order.getId() + " thành trạng thái 'Đang xử lý'");
			return "redirect:/admin/order/index";
			
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", 
				"Có lỗi xảy ra khi cập nhật trạng thái đơn hàng: " + e.getMessage());
			return "redirect:/admin/order/index";
		}
	}
	
	/**
	 * Thay đổi trạng thái đơn hàng thành "Đang giao" (status = 2)
	 */
	@PostMapping("/ship/{id}")
	public String shipOrder(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
		try {
			Order order = orderDAO.findById(id);
			if (order == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy đơn hàng để giao");
				return "redirect:/admin/order/index";
			}
			
			order.setStatus(2); // Đang giao
			orderDAO.update(order);
			
			redirectAttributes.addFlashAttribute("message", 
				"Đã chuyển đơn hàng #" + order.getId() + " thành trạng thái 'Đang giao'");
			return "redirect:/admin/order/index";
			
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", 
				"Có lỗi xảy ra khi cập nhật trạng thái đơn hàng: " + e.getMessage());
			return "redirect:/admin/order/index";
		}
	}
	
	/**
	 * Thay đổi trạng thái đơn hàng thành "Hoàn thành" (status = 3)
	 */
	@PostMapping("/complete/{id}")
	public String completeOrder(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
		try {
			Order order = orderDAO.findById(id);
			if (order == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy đơn hàng để hoàn thành");
				return "redirect:/admin/order/index";
			}
			
			order.setStatus(3); // Hoàn thành
			orderDAO.update(order);
			
			redirectAttributes.addFlashAttribute("message", 
				"Đã chuyển đơn hàng #" + order.getId() + " thành trạng thái 'Hoàn thành'");
			return "redirect:/admin/order/index";
			
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", 
				"Có lỗi xảy ra khi cập nhật trạng thái đơn hàng: " + e.getMessage());
			return "redirect:/admin/order/index";
		}
	}
	
	/**
	 * Thay đổi trạng thái đơn hàng thành "Đã hủy" (status = -1)
	 */
	@PostMapping("/cancel/{id}")
	public String cancelOrder(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
		try {
			Order order = orderDAO.findById(id);
			if (order == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy đơn hàng để hủy");
				return "redirect:/admin/order/index";
			}
			
			order.setStatus(-1); // Đã hủy
			orderDAO.update(order);
			
			redirectAttributes.addFlashAttribute("message", 
				"Đã hủy đơn hàng #" + order.getId());
			return "redirect:/admin/order/index";
			
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", 
				"Có lỗi xảy ra khi hủy đơn hàng: " + e.getMessage());
			return "redirect:/admin/order/index";
		}
	}

	/**
	 * Cập nhật trạng thái đơn hàng qua AJAX
	 * Endpoint mới để xử lý dropdown status change
	 */
	@PostMapping("/update-status")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> updateStatus(@RequestBody Map<String, Object> request) {
		Map<String, Object> response = new HashMap<>();
		
		try {
			// Lấy dữ liệu từ request
			Integer orderId = Integer.parseInt(request.get("orderId").toString());
			Integer newStatus = Integer.parseInt(request.get("newStatus").toString());
			
			// Tìm đơn hàng
			Order order = orderDAO.findById(orderId);
			if (order == null) {
				response.put("success", false);
				response.put("message", "Không tìm thấy đơn hàng với ID: " + orderId);
				return ResponseEntity.badRequest().body(response);
			}
			
			// Validate trạng thái hợp lệ
			if (!isValidStatus(newStatus)) {
				response.put("success", false);
				response.put("message", "Trạng thái không hợp lệ: " + newStatus);
				return ResponseEntity.badRequest().body(response);
			}
			
			// Cập nhật trạng thái
			Integer oldStatus = order.getStatus();
			order.setStatus(newStatus);
			orderDAO.update(order);
			
			// Phản hồi thành công
			response.put("success", true);
			response.put("message", "Đã cập nhật trạng thái đơn hàng thành công");
			response.put("orderId", orderId);
			response.put("oldStatus", oldStatus);
			response.put("newStatus", newStatus);
			response.put("statusName", getStatusName(newStatus));
			
			return ResponseEntity.ok(response);
			
		} catch (NumberFormatException e) {
			response.put("success", false);
			response.put("message", "Dữ liệu không hợp lệ");
			return ResponseEntity.badRequest().body(response);
		} catch (Exception e) {
			e.printStackTrace();
			response.put("success", false);
			response.put("message", "Có lỗi xảy ra khi cập nhật trạng thái: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
	}
	
	/**
	 * Kiểm tra trạng thái có hợp lệ không
	 */
	private boolean isValidStatus(Integer status) {
		return status != null && (status == -1 || status == 0 || status == 1 || status == 2 || status == 3);
	}

	// ================= UTILITY METHODS =================
	
	/**
	 * Thêm thống kê tổng quan vào model
	 */
	private void addStatisticsToModel(Model model, List<Order> orders) {
		// Tổng số đơn hàng
		int totalOrders = orders.size();
		
		// Đếm theo trạng thái
		long pendingOrders = orders.stream().filter(o -> o.getStatus() == null || o.getStatus() == 0).count();
		long processingOrders = orders.stream().filter(o -> o.getStatus() != null && o.getStatus() == 1).count();
		long shippingOrders = orders.stream().filter(o -> o.getStatus() != null && o.getStatus() == 2).count();
		long completedOrders = orders.stream().filter(o -> o.getStatus() != null && o.getStatus() == 3).count();
		long cancelledOrders = orders.stream().filter(o -> o.getStatus() != null && o.getStatus() == -1).count();
		
		// Tính tổng doanh thu
		double totalRevenue = orders.stream()
			.filter(o -> o.getStatus() != null && o.getStatus() == 3) // Chỉ tính đơn hoàn thành
			.mapToDouble(o -> o.getAmount() != null ? o.getAmount() : 0.0)
			.sum();
		
		model.addAttribute("totalOrders", totalOrders);
		model.addAttribute("pendingOrders", pendingOrders);
		model.addAttribute("processingOrders", processingOrders);
		model.addAttribute("shippingOrders", shippingOrders);
		model.addAttribute("completedOrders", completedOrders);
		model.addAttribute("cancelledOrders", cancelledOrders);
		model.addAttribute("totalRevenue", totalRevenue);
	}
	
	/**
	 * Thêm số lượng sản phẩm cho từng đơn hàng vào model
	 */
	private void addItemCountsToModel(Model model, List<Order> orders) {
		Map<Integer, Integer> itemCounts = new HashMap<>();
		for (Order order : orders) {
			int count = orderDetailDAO.findByOrder(order).size();
			itemCounts.put(order.getId(), count);
		}
		model.addAttribute("itemCounts", itemCounts);
	}
	
	/**
	 * Helper method để lấy tên trạng thái đơn hàng
	 */
	public static String getStatusName(Integer status) {
		if (status == null || status == 0) return "Chờ xử lý";
		switch (status) {
			case 1: return "Đang xử lý";
			case 2: return "Đang giao";
			case 3: return "Hoàn thành";
			case -1: return "Đã hủy";
			default: return "Không xác định";
		}
	}
	
	/**
	 * Helper method để lấy class CSS cho badge trạng thái
	 */
	public static String getStatusBadgeClass(Integer status) {
		if (status == null || status == 0) return "bg-warning text-dark";
		switch (status) {
			case 1: return "bg-info";
			case 2: return "bg-primary";
			case 3: return "bg-success";
			case -1: return "bg-danger";
			default: return "bg-secondary";
		}
	}
} 