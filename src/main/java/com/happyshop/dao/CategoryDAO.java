package com.happyshop.dao;

import java.util.List;

import com.happyshop.entity.Category;

public interface CategoryDAO {
	Category findById(Integer id);

	List<Category> findAll();
	
	List<Category> findAllActive();
	
	List<Category> findAllDeleted();

	Category create(Category entity);

	void update(Category entity);

	Category delete(Integer id);
	
	// Soft delete methods
	void softDelete(Integer id);
	
	void restore(Integer id);
	
	void permanentDelete(Integer id);
	
	Long countProductsByCategory(Integer categoryId);
	
	// Statistics methods
	Long countAll();
	
	Long countActive();
	
	Long countDeleted();
	
	Long countWithProducts();
	
	// Auto cleanup methods
	/**
	 * Tìm các category đã bị xóa mềm quá 30 ngày
	 * @return List<Category> danh sách category hết hạn
	 */
	List<Category> findExpiredCategories();
	
	/**
	 * Tự động xóa vĩnh viễn các category đã ở thùng rác quá 30 ngày
	 * @return int số lượng category đã bị xóa
	 */
	int autoDeleteExpiredCategories();
}
