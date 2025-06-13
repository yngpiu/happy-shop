package com.happyshop.dao;

import java.util.List;

import com.happyshop.entity.Category;

/**
 * ===== INTERFACE DAO QUẢN LÝ DANH MỤC =====
 * 
 * Interface định nghĩa các thao tác database cho Category entity:
 * - CRUD operations với soft delete support
 * - Quản lý danh mục sản phẩm
 * - Thống kê và đếm số lượng
 * - Tính năng thùng rác và khôi phục
 * 
 * Tính năng:
 * - Soft delete với khả năng khôi phục
 * - Auto cleanup expired categories
 * - Count products by category
 * - Statistics và reporting
 * 
 * Author: Development Team
 * Version: 1.0 - Category Data Access Interface
 */
public interface CategoryDAO {
	
	// ================= CRUD OPERATIONS =================
	
	/**
	 * Tìm danh mục theo ID
	 * @param id ID của danh mục
	 * @return Category entity hoặc null nếu không tìm thấy
	 */
	Category findById(Integer id);

	/**
	 * Lấy tất cả danh mục (bao gồm cả đã xóa)
	 * @return List<Category> danh sách tất cả danh mục
	 */
	List<Category> findAll();
	
	/**
	 * Lấy danh sách danh mục đang hoạt động
	 * @return List<Category> danh sách danh mục active
	 */
	List<Category> findAllActive();
	
	/**
	 * Lấy danh sách danh mục đã bị xóa
	 * @return List<Category> danh sách danh mục trong thùng rác
	 */
	List<Category> findAllDeleted();

	/**
	 * Tạo danh mục mới
	 * @param entity Category entity cần tạo
	 * @return Category entity đã được tạo
	 */
	Category create(Category entity);

	/**
	 * Cập nhật thông tin danh mục
	 * @param entity Category entity với thông tin mới
	 */
	void update(Category entity);

	/**
	 * Xóa danh mục (backward compatibility - thực hiện soft delete)
	 * @param id ID của danh mục cần xóa
	 * @return Category entity đã bị xóa
	 */
	Category delete(Integer id);
	
	// ================= SOFT DELETE OPERATIONS =================
	
	/**
	 * Xóa mềm danh mục (chuyển vào thùng rác)
	 * @param id ID của danh mục cần xóa
	 */
	void softDelete(Integer id);
	
	/**
	 * Khôi phục danh mục từ thùng rác
	 * @param id ID của danh mục cần khôi phục
	 */
	void restore(Integer id);
	
	/**
	 * Xóa vĩnh viễn danh mục khỏi database
	 * @param id ID của danh mục cần xóa vĩnh viễn
	 */
	void permanentDelete(Integer id);
	
	// ================= STATISTICS & COUNTS =================
	
	/**
	 * Đếm số lượng sản phẩm theo danh mục
	 * @param categoryId ID của danh mục
	 * @return số lượng sản phẩm trong danh mục
	 */
	Long countProductsByCategory(Integer categoryId);
	
	/**
	 * Đếm tổng số danh mục
	 * @return tổng số danh mục
	 */
	Long countAll();
	
	/**
	 * Đếm số danh mục đang hoạt động
	 * @return số danh mục active
	 */
	Long countActive();
	
	/**
	 * Đếm số danh mục đã bị xóa
	 * @return số danh mục trong thùng rác
	 */
	Long countDeleted();
	
	/**
	 * Đếm số danh mục có chứa sản phẩm
	 * @return số danh mục có sản phẩm
	 */
	Long countWithProducts();
	
	// ================= AUTO CLEANUP =================
	
	/**
	 * Tìm các danh mục đã bị xóa mềm quá 30 ngày
	 * @return List<Category> danh sách danh mục hết hạn
	 */
	List<Category> findExpiredCategories();
	
	/**
	 * Tự động xóa vĩnh viễn các danh mục đã ở thùng rác quá 30 ngày
	 * @return int số lượng danh mục đã bị xóa
	 */
	int autoDeleteExpiredCategories();
}
