package com.happyshop.dao;

import java.util.List;

import com.happyshop.entity.Order;
import com.happyshop.entity.OrderDetail;
import com.happyshop.entity.Product;
import com.happyshop.entity.User;

/**
 * ===== INTERFACE DAO QUẢN LÝ ĐƠN HÀNG =====
 * 
 * Interface định nghĩa các thao tác database cho Order entity:
 * - CRUD operations cơ bản cho đơn hàng
 * - Tạo đơn hàng kèm chi tiết
 * - Tìm kiếm đơn hàng theo user
 * - Lấy danh sách sản phẩm đã mua
 * 
 * Tính năng:
 * - Order management operations
 * - Order with details creation
 * - User-based order filtering
 * - Purchase history tracking
 * 
 * Author: Development Team
 * Version: 1.0 - Order Data Access Interface
 */
public interface OrderDAO {
	
	// ================= CRUD OPERATIONS =================
	
	/**
	 * Tìm đơn hàng theo ID
	 * @param id ID của đơn hàng
	 * @return Order entity hoặc null nếu không tìm thấy
	 */
	Order findById(Integer id);

	/**
	 * Lấy tất cả đơn hàng trong hệ thống
	 * @return List<Order> danh sách tất cả đơn hàng
	 */
	List<Order> findAll();

	/**
	 * Tạo đơn hàng mới
	 * @param entity Order entity cần tạo
	 * @return Order entity đã được tạo
	 */
	Order create(Order entity);

	/**
	 * Cập nhật thông tin đơn hàng
	 * @param entity Order entity với thông tin mới
	 */
	void update(Order entity);

	/**
	 * Xóa đơn hàng theo ID
	 * @param id ID của đơn hàng cần xóa
	 * @return Order entity đã bị xóa
	 */
	Order delete(Integer id);

	// ================= ADVANCED OPERATIONS =================

	/**
	 * Tạo đơn hàng kèm chi tiết đơn hàng
	 * @param order Order entity cần tạo
	 * @param details List<OrderDetail> chi tiết đơn hàng
	 */
	void create(Order order, List<OrderDetail> details);

	/**
	 * Tìm tất cả đơn hàng của một user
	 * @param user User entity
	 * @return List<Order> danh sách đơn hàng của user
	 */
	List<Order> findByUser(User user);

	/**
	 * Lấy danh sách sản phẩm đã mua của user
	 * @param user User entity
	 * @return List<Product> danh sách sản phẩm đã mua
	 */
	List<Product> findItemsByUser(User user);
}
