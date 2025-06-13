package com.happyshop.dao;

import java.util.List;

import com.happyshop.entity.User;

/**
 * ===== INTERFACE DAO QUẢN LÝ NGƯỜI DÙNG =====
 * 
 * Interface định nghĩa các thao tác database cho User entity:
 * - CRUD operations cơ bản
 * - Hỗ trợ phân trang dữ liệu
 * - Tìm kiếm và lọc người dùng
 * - Đếm số lượng và thống kê
 * 
 * Tính năng:
 * - Create, Read, Update, Delete User
 * - Pagination support với page size
 * - Count operations cho statistics
 * - Flexible search and filter methods
 * 
 * Author: Development Team
 * Version: 1.0 - User Data Access Interface
 */
public interface UserDAO {
	
	// ================= CRUD OPERATIONS =================
	
	/**
	 * Tìm người dùng theo ID
	 * @param id ID của người dùng
	 * @return User entity hoặc null nếu không tìm thấy
	 */
	User findById(String id);

	/**
	 * Lấy tất cả người dùng trong hệ thống
	 * @return List<User> danh sách tất cả người dùng
	 */
	List<User> findAll();

	/**
	 * Tạo người dùng mới
	 * @param entity User entity cần tạo
	 * @return User entity đã được tạo
	 */
	User create(User entity);

	/**
	 * Cập nhật thông tin người dùng
	 * @param entity User entity với thông tin mới
	 */
	void update(User entity);

	/**
	 * Xóa người dùng theo ID
	 * @param id ID của người dùng cần xóa
	 * @return User entity đã bị xóa
	 */
	User delete(String id);

	// ================= PAGINATION OPERATIONS =================

	/**
	 * Tính tổng số trang dựa trên kích thước trang
	 * @param pageSize số lượng record trên mỗi trang
	 * @return tổng số trang
	 */
	long getPageCount(int pageSize);

	/**
	 * Lấy dữ liệu người dùng theo trang
	 * @param pageNo số thứ tự trang (bắt đầu từ 0)
	 * @param pageSize số lượng record trên mỗi trang
	 * @return List<User> danh sách người dùng trong trang
	 */
	List<User> getPage(int pageNo, int pageSize);
}
