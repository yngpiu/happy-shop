package com.happyshop.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.happyshop.dao.CategoryDAO;
import com.happyshop.entity.Category;

@Controller
public class CategoryManger {
	@Autowired
	CategoryDAO dao;
	
	@RequestMapping("/admin/category/index")
	public String index(Model model, @RequestParam(value = "filter", defaultValue = "all") String filter) {
		Category entity = new Category();
		model.addAttribute("entity", entity);
		
		List<Category> list;
		if ("active".equals(filter)) {
			list = dao.findAllActive();
		} else if ("deleted".equals(filter)) {
			list = dao.findAllDeleted();
		} else {
			list = dao.findAll();
		}
		model.addAttribute("list", list);
		model.addAttribute("currentFilter", filter);
		
		// Add product counts for each category
		Map<Integer, Long> productCounts = new HashMap<>();
		for (Category category : list) {
			Long count = dao.countProductsByCategory(category.getId());
			productCounts.put(category.getId(), count);
		}
		model.addAttribute("productCounts", productCounts);
		
		// Add statistics
		model.addAttribute("totalCategories", dao.countAll());
		model.addAttribute("activeCategories", dao.countActive());
		model.addAttribute("deletedCategories", dao.countDeleted());
		model.addAttribute("categoriesWithProducts", dao.countWithProducts());
		
		return "admin/category/index";
	}
	
	@RequestMapping("/admin/category/add")
	public String add(Model model) {
		Category entity = new Category();
		model.addAttribute("entity", entity);
		
		// Add statistics for sidebar
		model.addAttribute("totalCategories", dao.countAll());
		model.addAttribute("activeCategories", dao.countActive());
		model.addAttribute("deletedCategories", dao.countDeleted());
		
		return "admin/category/add";
	}
	
	@RequestMapping("/admin/category/edit/{id}")
	public String edit(Model model, @PathVariable("id") Integer id) {
		Category entity = dao.findById(id);
		if (entity == null) {
			model.addAttribute("error", "Không tìm thấy loại sản phẩm!");
			return "redirect:/admin/category/index";
		}
		
		model.addAttribute("entity", entity);
		
		// Add product count for this category
		Long productCount = dao.countProductsByCategory(id);
		Map<Integer, Long> productCounts = new HashMap<>();
		productCounts.put(id, productCount);
		model.addAttribute("productCounts", productCounts);
		
		return "admin/category/edit";
	}
	
	@RequestMapping("/admin/category/create")
	public String create(RedirectAttributes model, @ModelAttribute("entity") Category entity) {
		try {
			dao.create(entity);
			model.addAttribute("message", "Thêm mới loại sản phẩm thành công!");
		} catch (Exception e) {
			model.addAttribute("error", "Có lỗi xảy ra khi thêm loại sản phẩm. Vui lòng thử lại!");
		}
		return "redirect:/admin/category/index";
	}
	
	@RequestMapping("/admin/category/update")
	public String update(RedirectAttributes model, @ModelAttribute("entity") Category entity) {
		try {
			dao.update(entity);
			model.addAttribute("message", "Cập nhật loại sản phẩm thành công!");
			return "redirect:/admin/category/edit/" + entity.getId();
		} catch (Exception e) {
			model.addAttribute("error", "Có lỗi xảy ra khi cập nhật loại sản phẩm. Vui lòng thử lại!");
			return "redirect:/admin/category/edit/" + entity.getId();
		}
	}
	
	// Soft delete - move to trash
	@RequestMapping(value = {"/admin/category/move-to-trash", "/admin/category/move-to-trash/{id}"})
	public String moveToTrash(RedirectAttributes model, 
			@RequestParam(value="id", required = false) Integer id1, 
			@PathVariable(value="id", required = false) Integer id2) {
		
		Integer deleteId = (id1 != null) ? id1 : id2;
		
		try {
			// Check if category has any products
			Long productCount = dao.countProductsByCategory(deleteId);
			
			if (productCount > 0) {
				Category category = dao.findById(deleteId);
				model.addAttribute("error", "Không thể xóa loại sản phẩm '" + category.getName() + 
					"' vì còn " + productCount + " sản phẩm thuộc loại này. Vui lòng xóa hoặc chuyển các sản phẩm sang loại khác trước.");
				return "redirect:/admin/category/index";
			}
			
			// Move to trash (soft delete)
			Category category = dao.findById(deleteId);
			dao.softDelete(deleteId);
			model.addAttribute("message", "Đã chuyển loại sản phẩm '" + category.getName() + "' vào thùng rác. Có thể khôi phục trong vòng 30 ngày.");
			
		} catch (Exception e) {
			model.addAttribute("error", "Có lỗi xảy ra khi xóa loại sản phẩm. Vui lòng thử lại!");
		}
		
		return "redirect:/admin/category/index";
	}
	
	// Restore from trash
	@RequestMapping("/admin/category/restore/{id}")
	public String restore(RedirectAttributes model, @PathVariable("id") Integer id) {
		try {
			Category category = dao.findById(id);
			dao.restore(id);
			model.addAttribute("message", "Đã khôi phục loại sản phẩm '" + category.getName() + "' thành công!");
		} catch (Exception e) {
			model.addAttribute("error", "Có lỗi xảy ra khi khôi phục loại sản phẩm. Vui lòng thử lại!");
		}
		
		return "redirect:/admin/category/index";
	}
	
	// Permanent delete
	@RequestMapping("/admin/category/delete-permanent/{id}")
	public String permanentDelete(RedirectAttributes model, @PathVariable("id") Integer id) {
		try {
			Category category = dao.findById(id);
			dao.permanentDelete(id);
			model.addAttribute("message", "Đã xóa vĩnh viễn loại sản phẩm '" + category.getName() + "'!");
		} catch (DataIntegrityViolationException e) {
			model.addAttribute("error", "Không thể xóa vĩnh viễn loại sản phẩm này vì vẫn còn dữ liệu liên quan.");
		} catch (Exception e) {
			model.addAttribute("error", "Có lỗi xảy ra khi xóa vĩnh viễn loại sản phẩm. Vui lòng thử lại!");
		}
		
		return "redirect:/admin/category/index";
	}
	
	// Trash page
	@RequestMapping("/admin/category/trash")
	public String trash(Model model) {
		List<Category> deletedList = dao.findAllDeleted();
		model.addAttribute("list", deletedList);
		
		// Add product counts for each category
		Map<Integer, Long> productCounts = new HashMap<>();
		for (Category category : deletedList) {
			Long count = dao.countProductsByCategory(category.getId());
			productCounts.put(category.getId(), count);
		}
		model.addAttribute("productCounts", productCounts);
		
		// Add statistics
		model.addAttribute("totalCategories", dao.countAll());
		model.addAttribute("activeCategories", dao.countActive());
		model.addAttribute("deletedCategories", dao.countDeleted());
		
		return "admin/category/trash";
	}
	
	// Legacy delete method for backward compatibility
	@RequestMapping(value = {"/admin/category/delete","/admin/category/delete/{id}"})
	public String delete(RedirectAttributes model, 
			@RequestParam(value="id", required = false) Integer id1, 
			@PathVariable(value="id", required = false) Integer id2) {
		
		// Redirect to soft delete method
		return moveToTrash(model, id1, id2);
	}
}
