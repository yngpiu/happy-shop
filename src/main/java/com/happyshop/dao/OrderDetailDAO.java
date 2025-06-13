package com.happyshop.dao;

import java.util.List;

import com.happyshop.entity.Order;
import com.happyshop.entity.OrderDetail;

/**
 * ===== INTERFACE DAO QUẢN LÝ CHI TIẾT ĐƠN HÀNG =====
 * 
 * Interface định nghĩa các thao tác database cho OrderDetail entity:
 * - CRUD operations cơ bản cho chi tiết đơn hàng
 * - Tìm kiếm chi tiết theo đơn hàng
 * - Quản lý thông tin sản phẩm trong đơn hàng
 * - Hỗ trợ tính toán giá trị đơn hàng
 * 
 * Tính năng:
 * - Order detail management
 * - Order-based detail filtering
 * - Product-order relationship
 * - Price calculation support
 * 
 * Author: Development Team
 * Version: 1.0 - Order Detail Data Access Interface
 */
public interface OrderDetailDAO {
	
	// ================= CRUD OPERATIONS =================
	
	/**
	 * Tìm chi tiết đơn hàng theo ID
	 * @param id ID của chi tiết đơn hàng
	 * @return OrderDetail entity hoặc null nếu không tìm thấy
	 */
	OrderDetail findById(Integer id);

	/**
	 * Lấy tất cả chi tiết đơn hàng trong hệ thống
	 * @return List<OrderDetail> danh sách tất cả chi tiết đơn hàng
	 */
	List<OrderDetail> findAll();

	/**
	 * Tạo chi tiết đơn hàng mới
	 * @param entity OrderDetail entity cần tạo
	 * @return OrderDetail entity đã được tạo
	 */
	OrderDetail create(OrderDetail entity);

	/**
	 * Cập nhật thông tin chi tiết đơn hàng
	 * @param entity OrderDetail entity với thông tin mới
	 */
	void update(OrderDetail entity);

	/**
	 * Xóa chi tiết đơn hàng theo ID
	 * @param id ID của chi tiết đơn hàng cần xóa
	 * @return OrderDetail entity đã bị xóa
	 */
	OrderDetail delete(Integer id);

	// ================= QUERY OPERATIONS =================

	/**
	 * Tìm tất cả chi tiết của một đơn hàng
	 * @param order Order entity
	 * @return List<OrderDetail> danh sách chi tiết đơn hàng
	 */
	List<OrderDetail> findByOrder(Order order);
}
