package com.happyshop.dao;

import java.util.List;

import com.happyshop.entity.Product;

/**
 * Interface DAO cho quản lý sản phẩm
 * Hỗ trợ CRUD operations và soft delete
 */
public interface ProductDAO {
	
	// ================= CRUD OPERATIONS =================
	
	/**
	 * Tạo mới sản phẩm
	 * @param entity Product cần tạo
	 */
	void create(Product entity);
	
	/**
	 * Cập nhật thông tin sản phẩm
	 * @param entity Product cần cập nhật
	 */
	void update(Product entity);
	
	/**
	 * Tìm sản phẩm theo ID
	 * @param id ID của sản phẩm
	 * @return Product tìm được hoặc null
	 */
	Product findById(Integer id);
	
	/**
	 * Lấy tất cả sản phẩm (bao gồm cả đã xóa)
	 * @return List<Product> danh sách tất cả sản phẩm
	 */
	List<Product> findAll();
	
	/**
	 * Lấy danh sách sản phẩm đang hoạt động (chưa bị xóa)
	 * @return List<Product> danh sách sản phẩm active
	 */
	List<Product> findAllActive();
	
	/**
	 * Lấy danh sách sản phẩm đã bị xóa (soft delete)
	 * @return List<Product> danh sách sản phẩm trong thùng rác
	 */
	List<Product> findAllDeleted();
	
	// ================= SOFT DELETE OPERATIONS =================
	
	/**
	 * Xóa sản phẩm (backward compatibility - thực hiện soft delete)
	 * @param id ID của sản phẩm cần xóa
	 */
	void delete(Integer id);
	
	/**
	 * Xóa mềm sản phẩm (chuyển vào thùng rác)
	 * @param id ID của sản phẩm cần xóa
	 */
	void softDelete(Integer id);
	
	/**
	 * Khôi phục sản phẩm từ thùng rác
	 * @param id ID của sản phẩm cần khôi phục
	 */
	void restore(Integer id);
	
	/**
	 * Xóa vĩnh viễn sản phẩm khỏi database
	 * @param id ID của sản phẩm cần xóa vĩnh viễn
	 */
	void permanentDelete(Integer id);
	
	// ================= STATISTICS & COUNTS =================
	
	/**
	 * Đếm tổng số sản phẩm
	 * @return Long số lượng tổng
	 */
	Long countAll();
	
	/**
	 * Đếm số sản phẩm đang hoạt động
	 * @return Long số lượng active
	 */
	Long countActive();
	
	/**
	 * Đếm số sản phẩm đã bị xóa
	 * @return Long số lượng deleted
	 */
	Long countDeleted();
	
	/**
	 * Đếm số sản phẩm còn hàng (available = true)
	 * @return Long số lượng có sẵn
	 */
	Long countAvailable();
	
	/**
	 * Đếm số sản phẩm đặc biệt (special = true)
	 * @return Long số lượng special
	 */
	Long countSpecial();
	
	/**
	 * Đếm số đơn hàng có chứa sản phẩm này
	 * @param productId ID của sản phẩm
	 * @return Long số lượng đơn hàng
	 */
	Long countOrdersByProduct(Integer productId);
	
	// ================= FILTER BY CATEGORY =================
	
	/**
	 * Lấy sản phẩm theo loại sản phẩm
	 * @param categoryId ID của category
	 * @return List<Product> danh sách sản phẩm
	 */
	List<Product> findByCategory(Integer categoryId);
	
	/**
	 * Lấy sản phẩm active theo loại sản phẩm  
	 * @param categoryId ID của category
	 * @return List<Product> danh sách sản phẩm active
	 */
	List<Product> findActiveByCategoryId(Integer categoryId);
	
	// ================= FRONTEND SUPPORT METHODS =================
	
	/**
	 * Lấy sản phẩm đặc biệt với số lượng giới hạn
	 * @param limit số lượng tối đa
	 * @return List<Product> danh sách sản phẩm đặc biệt
	 */
	List<Product> findSpecialProducts(int limit);
	
	/**
	 * Lấy sản phẩm đang hoạt động với số lượng giới hạn
	 * @param limit số lượng tối đa
	 * @return List<Product> danh sách sản phẩm active
	 */
	List<Product> findActiveProducts(int limit);
	
	/**
	 * Lấy sản phẩm theo category ID (cho frontend)
	 * @param categoryId ID của category
	 * @return List<Product> danh sách sản phẩm
	 */
	List<Product> findByCategoryId(Integer categoryId);
	
	/**
	 * Tìm sản phẩm theo từ khóa
	 * @param keywords từ khóa tìm kiếm
	 * @return List<Product> danh sách sản phẩm
	 */
	List<Product> findByKeywords(String keywords);
	
	/**
	 * Tìm sản phẩm theo danh sách ID (phân cách bởi dấu phẩy)
	 * @param ids chuỗi ID phân cách bởi dấu phẩy
	 * @return List<Product> danh sách sản phẩm
	 */
	List<Product> findByIds(String ids);
	
	// ================= AUTO CLEANUP =================
	
	/**
	 * Tìm sản phẩm đã hết hạn (đã bị xóa quá 30 ngày)
	 * @return List<Product> danh sách sản phẩm hết hạn
	 */
	List<Product> findExpiredProducts();
	
	/**
	 * Tự động xóa vĩnh viễn sản phẩm đã hết hạn
	 * @return int số lượng sản phẩm đã bị xóa
	 */
	int autoDeleteExpiredProducts();
}
