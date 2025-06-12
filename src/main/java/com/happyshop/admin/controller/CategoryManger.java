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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.happyshop.dao.CategoryDAO;
import com.happyshop.entity.Category;

/**
 * Controller xử lý các chức năng quản lý loại sản phẩm (Category)
 * Bao gồm: CRUD, soft delete, thùng rác, khôi phục
 */
@Controller
@RequestMapping("/admin/category")
public class CategoryManger {
	
	@Autowired
	CategoryDAO dao;
	
	// ================= HIỂN THỊ DANH SÁCH =================
	
	/**
	 * Hiển thị trang danh sách category đang hoạt động
	 * @param model Model để truyền dữ liệu ra view
	 * @param filter filter để lọc danh sách
	 * @return String tên view cần render
	 */
	@RequestMapping(value = { "/index", "/" }, method = RequestMethod.GET)
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
	
	/**
	 * Hiển thị trang thùng rác với các category đã bị xóa
	 * @param model Model để truyền dữ liệu ra view
	 * @return String tên view cần render
	 */
	@RequestMapping(value = "/trash", method = RequestMethod.GET)
	public String trash(Model model) {
		List<Category> trashedList = dao.findAllDeleted();
		Long expiringSoonCount = 0L; // Mock value, actual implementation needed
		Long recoverableCount = (long) trashedList.size();
		
		model.addAttribute("trashedList", trashedList);
		model.addAttribute("expiringSoonCount", expiringSoonCount);
		model.addAttribute("recoverableCount", recoverableCount);
		
		// Add product counts for each category
		Map<Integer, Long> productCounts = new HashMap<>();
		for (Category category : trashedList) {
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

	// ================= THÊM MỚI =================
	
	/**
	 * Hiển thị form thêm mới category
	 * @param model Model để truyền dữ liệu ra view
	 * @return String tên view cần render
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insert(Model model) {
		Category entity = new Category();
		model.addAttribute("entity", entity);
		
		// Add statistics for sidebar
		model.addAttribute("totalCategories", dao.countAll());
		model.addAttribute("activeCategories", dao.countActive());
		model.addAttribute("deletedCategories", dao.countDeleted());
		
		return "admin/category/insert";
	}
	
	/**
	 * Xử lý thêm mới category
	 * @param entity Category object từ form
	 * @param redirectAttributes để hiển thị thông báo
	 * @return String redirect URL
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(RedirectAttributes redirectAttributes, @ModelAttribute("entity") Category entity) {
		try {
			dao.create(entity);
			redirectAttributes.addAttribute("message", "Thêm mới loại sản phẩm thành công!");
			redirectAttributes.addAttribute("messageType", "success");
		} catch (Exception e) {
			redirectAttributes.addAttribute("error", "Có lỗi xảy ra khi thêm loại sản phẩm. Vui lòng thử lại!");
			redirectAttributes.addAttribute("messageType", "error");
		}
		return "redirect:/admin/category/index";
	}

	// ================= CẬP NHẬT =================
	
	/**
	 * Hiển thị form chỉnh sửa category
	 * @param id ID của category cần chỉnh sửa
	 * @param model Model để truyền dữ liệu ra view
	 * @return String tên view cần render
	 */
	@RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
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
	
	/**
	 * Xử lý cập nhật thông tin category
	 * Chỉ cập nhật tên, giữ nguyên các thông tin khác như created_at, updated_at
	 * @param id ID của category cần cập nhật
	 * @param name Tên mới của category
	 * @param redirectAttributes để hiển thị thông báo
	 * @return String redirect URL
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(RedirectAttributes model, @ModelAttribute("entity") Category entity) {
		try {
			// Get existing entity from database to preserve timestamps
			Category existing = dao.findById(entity.getId());
			if (existing != null) {
				// Copy only the editable fields
				existing.setName(entity.getName());
				// createdAt and updatedAt will be handled by @PreUpdate
				dao.update(existing);
			}
			model.addAttribute("message", "Cập nhật loại sản phẩm thành công!");
			model.addAttribute("messageType", "success");
			return "redirect:/admin/category/index";
		} catch (Exception e) {
			model.addAttribute("error", "Có lỗi xảy ra khi cập nhật loại sản phẩm. Vui lòng thử lại!");
			model.addAttribute("messageType", "error");
			return "redirect:/admin/category/edit/" + entity.getId();
		}
	}

	// ================= XÓA MỀM (SOFT DELETE) =================
	
	/**
	 * Xóa mềm category (chuyển vào thùng rác)
	 * @param id ID của category cần xóa
	 * @param redirectAttributes để hiển thị thông báo
	 * @return String redirect URL
	 */
	@RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
	public String delete(RedirectAttributes model, @PathVariable("id") Integer id) {
		try {
			// Check if category has any products
			Long productCount = dao.countProductsByCategory(id);
			
			if (productCount > 0) {
				Category category = dao.findById(id);
				model.addAttribute("error", "Không thể xóa loại sản phẩm '" + category.getName() + 
					"' vì còn " + productCount + " sản phẩm thuộc loại này. Vui lòng xóa hoặc chuyển các sản phẩm sang loại khác trước.");
				return "redirect:/admin/category/index";
			}
			
			// Move to trash (soft delete)
			Category category = dao.findById(id);
			dao.softDelete(id);
			model.addAttribute("message", "Đã chuyển loại sản phẩm '" + category.getName() + "' vào thùng rác. Có thể khôi phục trong vòng 30 ngày.");
			model.addAttribute("messageType", "success");
			
		} catch (Exception e) {
			model.addAttribute("error", "Có lỗi xảy ra khi xóa loại sản phẩm. Vui lòng thử lại!");
			model.addAttribute("messageType", "error");
		}
		
		return "redirect:/admin/category/index";
	}

	// ================= QUẢN LÝ THÙNG RÁC =================
	
	/**
	 * Khôi phục category từ thùng rác
	 * @param id ID của category cần khôi phục
	 * @param redirectAttributes để hiển thị thông báo
	 * @return String redirect URL - quay lại trang thùng rác
	 */
	@RequestMapping(value = "/restore/{id}", method = RequestMethod.POST)
	public String restore(RedirectAttributes model, @PathVariable("id") Integer id) {
		try {
			Category category = dao.findById(id);
			dao.restore(id);
			model.addAttribute("message", "Đã khôi phục loại sản phẩm '" + category.getName() + "' thành công!");
			model.addAttribute("messageType", "success");
		} catch (Exception e) {
			model.addAttribute("error", "Có lỗi xảy ra khi khôi phục loại sản phẩm. Vui lòng thử lại!");
			model.addAttribute("messageType", "error");
		}
		
		return "redirect:/admin/category/trash";
	}
	
	/**
	 * Xóa vĩnh viễn category khỏi database
	 * @param id ID của category cần xóa vĩnh viễn
	 * @param redirectAttributes để hiển thị thông báo
	 * @return String redirect URL - quay lại trang thùng rác
	 */
	@RequestMapping(value = "/permanent-delete/{id}", method = RequestMethod.POST)
	public String permanentDelete(RedirectAttributes model, @PathVariable("id") Integer id) {
		try {
			Category category = dao.findById(id);
			dao.permanentDelete(id);
			model.addAttribute("message", "Đã xóa vĩnh viễn loại sản phẩm '" + category.getName() + "'!");
			model.addAttribute("messageType", "success");
		} catch (DataIntegrityViolationException e) {
			model.addAttribute("error", "Không thể xóa vĩnh viễn loại sản phẩm này vì vẫn còn dữ liệu liên quan.");
			model.addAttribute("messageType", "error");
		} catch (Exception e) {
			model.addAttribute("error", "Có lỗi xảy ra khi xóa vĩnh viễn loại sản phẩm. Vui lòng thử lại!");
			model.addAttribute("messageType", "error");
		}
		
		return "redirect:/admin/category/trash";
	}
	
	/**
	 * Làm sạch thùng rác - xóa vĩnh viễn tất cả category đã bị xóa
	 * @param redirectAttributes để hiển thị thông báo
	 * @return String redirect URL - quay lại trang thùng rác
	 */
	@RequestMapping(value = "/empty-trash", method = RequestMethod.POST)
	public String emptyTrash(RedirectAttributes model) {
		try {
			List<Category> deletedList = dao.findAllDeleted();
			int count = deletedList.size();
			
			for (Category category : deletedList) {
				dao.permanentDelete(category.getId());
			}
			
			model.addAttribute("message", "Đã dọn sạch thùng rác! Xóa vĩnh viễn " + count + " loại sản phẩm.");
			model.addAttribute("messageType", "success");
		} catch (Exception e) {
			model.addAttribute("error", "Có lỗi xảy ra khi dọn sạch thùng rác. Vui lòng thử lại!");
			model.addAttribute("messageType", "error");
		}
		
		return "redirect:/admin/category/trash";
	}
}
