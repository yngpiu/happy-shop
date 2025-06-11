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
}
