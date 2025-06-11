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
	public String index(Model model) {
		Category entity = new Category();
		model.addAttribute("entity", entity);
		
		List<Category> list = dao.findAll();
		model.addAttribute("list", list);
		
		// Add product counts for each category
		Map<Integer, Long> productCounts = new HashMap<>();
		for (Category category : list) {
			Long count = dao.countProductsByCategory(category.getId());
			productCounts.put(category.getId(), count);
		}
		model.addAttribute("productCounts", productCounts);
		
		return "admin/category/index";
	}
	
	@RequestMapping("/admin/category/add")
	public String add(Model model) {
		Category entity = new Category();
		model.addAttribute("entity", entity);
		return "admin/category/add";
	}
	
	@RequestMapping("/admin/category/edit/{id}")
	public String edit(Model model, @PathVariable("id") Integer id) {
		Category entity = dao.findById(id);
		model.addAttribute("entity", entity);
		return "admin/category/edit";
	}
	
	@RequestMapping("/admin/category/create")
	public String create(RedirectAttributes model, @ModelAttribute("entity") Category entity) {
		dao.create(entity);
		model.addAttribute("message", "Thêm mới thành công!");
		return "redirect:/admin/category/index";
	}
	
	@RequestMapping("/admin/category/update")
	public String update(RedirectAttributes model, @ModelAttribute("entity") Category entity) {
		dao.update(entity);
		model.addAttribute("message", "Cập nhật thành công!");
		return "redirect:/admin/category/edit/"+entity.getId();
	}
	
	@RequestMapping(value = {"/admin/category/delete","/admin/category/delete/{id}"})
	public String delete(RedirectAttributes model, 
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
			
			// Safe to delete
			dao.delete(deleteId);
			model.addAttribute("message", "Xóa thành công!");
			
		} catch (DataIntegrityViolationException e) {
			model.addAttribute("error", "Không thể xóa loại sản phẩm này vì vẫn còn dữ liệu liên quan. Vui lòng kiểm tra và xóa các sản phẩm thuộc loại này trước.");
		} catch (Exception e) {
			model.addAttribute("error", "Có lỗi xảy ra khi xóa loại sản phẩm. Vui lòng thử lại!");
		}
		
		return "redirect:/admin/category/index";
	}
}
