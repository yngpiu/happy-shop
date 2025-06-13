package com.happyshop.controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.happyshop.dao.CategoryDAO;
import com.happyshop.dao.ProductDAO;
import com.happyshop.entity.Category;
import com.happyshop.entity.Product;

/**
 * ===== CONTROLLER QUẢN LÝ SẢN PHẨM =====
 * 
 * Xử lý tất cả các yêu cầu liên quan đến quản lý sản phẩm:
 * - CRUD operations (Create, Read, Update, Delete)
 * - Soft delete với thùng rác
 * - Upload và xử lý hình ảnh
 * - Thống kê và báo cáo
 * 
 * Author: Admin System
 * Version: 2.0 - Enhanced with soft delete functionality
 */
@Controller
@RequestMapping("/admin/product")
public class ProductMangerController {

	// ================= DEPENDENCY INJECTION =================
	
	@Autowired
	private ProductDAO productDAO;
	
	@Autowired
	private CategoryDAO categoryDAO;
	
	@Autowired
	private ServletContext servletContext;
	
	// ================= MAIN CRUD OPERATIONS =================
	
	/**
	 * Hiển thị trang danh sách sản phẩm chính
	 * Bao gồm thống kê và danh sách sản phẩm đang hoạt động
	 */
	@GetMapping("/index")
	public String index(Model model) {
		try {
			// Lấy danh sách sản phẩm đang hoạt động
			List<Product> products = productDAO.findAllActive();
			model.addAttribute("list", products);
			
			// Thêm thống kê vào model
			addStatisticsToModel(model);
			
			// Thêm số đơn hàng cho từng sản phẩm
			addOrderCountsToModel(model, products);
			
			return "admin/product/index";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Có lỗi xảy ra khi tải danh sách sản phẩm: " + e.getMessage());
		return "admin/product/index";
	}
	}
	
	/**
	 * Hiển thị trang thùng rác sản phẩm
	 * Bao gồm các sản phẩm đã bị xóa tạm thời
	 */
	@GetMapping("/trash")
	public String trash(Model model) {
		try {
			// Lấy danh sách sản phẩm trong thùng rác
			List<Product> trashedProducts = productDAO.findAllDeleted();
			model.addAttribute("trashedList", trashedProducts);
			
			// Thống kê cho thùng rác
			addTrashStatisticsToModel(model, trashedProducts);
			
			return "admin/product/trash";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Có lỗi xảy ra khi tải thùng rác: " + e.getMessage());
			return "admin/product/trash";
		}
	}
	
	/**
	 * Hiển thị trang thêm sản phẩm mới
	 */
	@GetMapping("/insert")
	public String showInsertForm(Model model) {
		try {
			// Tạo product trống cho form
			Product product = new Product();
			model.addAttribute("product", product);
			
			// Lấy danh sách categories để chọn
			List<Category> categories = categoryDAO.findAllActive();
			model.addAttribute("categories", categories);
			
			return "admin/product/insert";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Có lỗi xảy ra khi tải form thêm sản phẩm: " + e.getMessage());
		return "admin/product/index";
	}
	}
	
	/**
	 * Xử lý thêm sản phẩm mới
	 */
	@PostMapping("/insert")
	public String insert(@ModelAttribute("product") Product product,
	                    @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
	                    RedirectAttributes redirectAttributes) {
		try {
			// Xử lý upload hình ảnh
			handleImageUpload(product, imageFile);
			
			// Lưu sản phẩm vào database
			productDAO.create(product);
			
			redirectAttributes.addFlashAttribute("message", 
				"Thêm sản phẩm '" + product.getName() + "' thành công!");
			return "redirect:/admin/product/index";
			
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", 
				"Có lỗi xảy ra khi thêm sản phẩm: " + e.getMessage());
			return "redirect:/admin/product/insert";
		}
	}
	
	/**
	 * Hiển thị trang chỉnh sửa sản phẩm
	 */
	@GetMapping("/edit/{id}")
	public String showEditForm(@PathVariable("id") Integer id, Model model) {
		try {
			// Tìm sản phẩm theo ID
			Product product = productDAO.findById(id);
			if (product == null || product.isDeleted()) {
				model.addAttribute("error", "Không tìm thấy sản phẩm với ID: " + id);
		return "redirect:/admin/product/index";
	}
	
			model.addAttribute("product", product);
			
			// Lấy danh sách categories
			List<Category> categories = categoryDAO.findAllActive();
			model.addAttribute("categories", categories);
			
			// Thêm thông tin đơn hàng
			Long orderCount = productDAO.countOrdersByProduct(id);
			model.addAttribute("orderCount", orderCount);
			
			return "admin/product/edit";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Có lỗi xảy ra khi tải thông tin sản phẩm: " + e.getMessage());
			return "redirect:/admin/product/index";
		}
	}
	
	/**
	 * Xử lý cập nhật thông tin sản phẩm
	 */
	@PostMapping("/edit/{id}")
	public String update(@PathVariable("id") Integer id,
	                    @ModelAttribute("product") Product product,
	                    @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
	                    RedirectAttributes redirectAttributes) {
		try {
			// Lấy thông tin sản phẩm hiện tại từ database
			Product existingProduct = productDAO.findById(id);
			if (existingProduct == null || existingProduct.isDeleted()) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy sản phẩm để cập nhật");
				return "redirect:/admin/product/index";
			}
			
			// Cập nhật các trường có thể chỉnh sửa
			updateProductFields(existingProduct, product);
			
			// Xử lý cập nhật hình ảnh
			handleImageUpdate(existingProduct, imageFile);
			
			// Lưu cập nhật vào database
			productDAO.update(existingProduct);
			
			redirectAttributes.addFlashAttribute("message", 
				"Cập nhật sản phẩm '" + existingProduct.getName() + "' thành công!");
			return "redirect:/admin/product/index";
			
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", 
				"Có lỗi xảy ra khi cập nhật sản phẩm: " + e.getMessage());
			return "redirect:/admin/product/edit/" + id;
		}
	}

	// ================= SOFT DELETE OPERATIONS =================
	
	/**
	 * Chuyển sản phẩm vào thùng rác (soft delete)
	 */
	@PostMapping("/delete/{id}")
	public String moveToTrash(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
		try {
			Product product = productDAO.findById(id);
			if (product == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy sản phẩm để xóa");
				return "redirect:/admin/product/index";
			}
			
			if (product.isDeleted()) {
				redirectAttributes.addFlashAttribute("error", "Sản phẩm đã ở trong thùng rác");
				return "redirect:/admin/product/index";
			}
			
			// Thực hiện soft delete
			productDAO.softDelete(id);
			
			redirectAttributes.addFlashAttribute("message", 
				"Đã chuyển sản phẩm '" + product.getName() + "' vào thùng rác");
			return "redirect:/admin/product/index";
			
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", 
				"Có lỗi xảy ra khi xóa sản phẩm: " + e.getMessage());
		return "redirect:/admin/product/index";
		}
	}
	
	/**
	 * Khôi phục sản phẩm từ thùng rác
	 */
	@PostMapping("/restore/{id}")
	public String restore(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
		try {
			Product product = productDAO.findById(id);
			if (product == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy sản phẩm để khôi phục");
				return "redirect:/admin/product/trash";
			}
			
			if (!product.isDeleted()) {
				redirectAttributes.addFlashAttribute("error", "Sản phẩm không ở trong thùng rác");
				return "redirect:/admin/product/trash";
			}
			
			// Thực hiện khôi phục
			productDAO.restore(id);
			
			redirectAttributes.addFlashAttribute("message", 
				"Đã khôi phục sản phẩm '" + product.getName() + "' thành công");
			return "redirect:/admin/product/trash";
			
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", 
				"Có lỗi xảy ra khi khôi phục sản phẩm: " + e.getMessage());
			return "redirect:/admin/product/trash";
		}
	}
	
	/**
	 * Xóa vĩnh viễn sản phẩm khỏi hệ thống (bao gồm các đơn hàng liên quan)
	 */
	@PostMapping("/permanent-delete/{id}")
	public String permanentDelete(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
		try {
			Product product = productDAO.findById(id);
			if (product == null) {
				redirectAttributes.addFlashAttribute("error", "Không tìm thấy sản phẩm để xóa");
				return "redirect:/admin/product/trash";
			}
			
			String productName = product.getName();
			
			// Kiểm tra số đơn hàng liên quan
			Long orderCount = productDAO.countOrdersByProduct(id);
			
			// Xóa các OrderDetails liên quan trước (nếu có)
			if (orderCount > 0) {
				int deletedOrderDetails = productDAO.deleteOrderDetailsByProduct(id);
				System.out.println("Đã xóa " + deletedOrderDetails + " chi tiết đơn hàng liên quan đến sản phẩm ID: " + id);
			}
			
			// Xóa vĩnh viễn sản phẩm
			productDAO.permanentDelete(id);
			
			String message = "Đã xóa vĩnh viễn sản phẩm '" + productName + "'";
			if (orderCount > 0) {
				message += " (bao gồm " + orderCount + " đơn hàng liên quan)";
			}
			
			redirectAttributes.addFlashAttribute("message", message);
			return "redirect:/admin/product/trash";
			
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", 
				"Có lỗi xảy ra khi xóa vĩnh viễn sản phẩm: " + e.getMessage());
			return "redirect:/admin/product/trash";
		}
	}
	
	/**
	 * Dọn sạch toàn bộ thùng rác (bao gồm các đơn hàng liên quan)
	 */
	@PostMapping("/empty-trash")
	public String emptyTrash(RedirectAttributes redirectAttributes) {
		try {
			List<Product> trashedProducts = productDAO.findAllDeleted();
			
			if (trashedProducts.isEmpty()) {
				redirectAttributes.addFlashAttribute("message", "Thùng rác đã trống");
				return "redirect:/admin/product/trash";
			}
			
			int deletedCount = 0;
			int totalOrderDetails = 0;
			
			for (Product product : trashedProducts) {
				Long orderCount = productDAO.countOrdersByProduct(product.getId());
				
				// Xóa OrderDetails liên quan (nếu có)
				if (orderCount > 0) {
					int deletedOrderDetails = productDAO.deleteOrderDetailsByProduct(product.getId());
					totalOrderDetails += deletedOrderDetails;
				}
				
				// Xóa vĩnh viễn sản phẩm
				productDAO.permanentDelete(product.getId());
				deletedCount++;
			}
			
			String message = "Đã dọn sạch thùng rác: " + deletedCount + " sản phẩm đã xóa";
			if (totalOrderDetails > 0) {
				message += " (bao gồm " + totalOrderDetails + " chi tiết đơn hàng)";
			}
			
			redirectAttributes.addFlashAttribute("message", message);
			return "redirect:/admin/product/trash";
			
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", 
				"Có lỗi xảy ra khi dọn sạch thùng rác: " + e.getMessage());
			return "redirect:/admin/product/trash";
		}
	}

	// ================= UTILITY METHODS =================
	
	/**
	 * Xử lý upload hình ảnh sản phẩm
	 */
	private void handleImageUpload(Product product, MultipartFile imageFile) throws IOException {
		if (imageFile != null && !imageFile.isEmpty()) {
			String fileName = imageFile.getOriginalFilename();
			product.setImage(fileName);
			
			// Lưu file vào thư mục
			String uploadPath = servletContext.getRealPath("/static/images/products/");
			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdirs();
			}
			
			File destinationFile = new File(uploadPath + fileName);
			imageFile.transferTo(destinationFile);
		}
	}
	
	/**
	 * Xử lý cập nhật hình ảnh sản phẩm
	 */
	private void handleImageUpdate(Product existingProduct, MultipartFile imageFile) throws IOException {
		if (imageFile != null && !imageFile.isEmpty()) {
			String fileName = imageFile.getOriginalFilename();
			existingProduct.setImage(fileName);
			
			// Lưu file mới
			String uploadPath = servletContext.getRealPath("/static/images/products/");
			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdirs();
			}
			
			File destinationFile = new File(uploadPath + fileName);
			imageFile.transferTo(destinationFile);
		}
		// Nếu không có file mới, giữ nguyên ảnh cũ
	}
	
	/**
	 * Cập nhật các trường của sản phẩm từ form
	 */
	private void updateProductFields(Product existingProduct, Product newProduct) {
		existingProduct.setName(newProduct.getName());
		existingProduct.setDescription(newProduct.getDescription());
		existingProduct.setUnitPrice(newProduct.getUnitPrice());
		existingProduct.setDiscount(newProduct.getDiscount());
		existingProduct.setQuantity(newProduct.getQuantity());
		existingProduct.setProductDate(newProduct.getProductDate());
		existingProduct.setAvailable(newProduct.getAvailable());
		existingProduct.setSpecial(newProduct.getSpecial());
		existingProduct.setCategory(newProduct.getCategory());
	}
	
	/**
	 * Thêm thống kê tổng quan vào model
	 */
	private void addStatisticsToModel(Model model) {
		model.addAttribute("totalProducts", productDAO.countAll());
		model.addAttribute("activeProducts", productDAO.countActive());
		model.addAttribute("deletedProducts", productDAO.countDeleted());
		model.addAttribute("availableProducts", productDAO.countAvailable());
		model.addAttribute("specialProducts", productDAO.countSpecial());
	}
	
	/**
	 * Thêm số lượng đơn hàng cho từng sản phẩm vào model
	 */
	private void addOrderCountsToModel(Model model, List<Product> products) {
		Map<Integer, Long> orderCounts = new HashMap<>();
		for (Product product : products) {
			Long count = productDAO.countOrdersByProduct(product.getId());
			orderCounts.put(product.getId(), count);
		}
		model.addAttribute("orderCounts", orderCounts);
	}
	
	/**
	 * Thêm thống kê thùng rác vào model
	 */
	private void addTrashStatisticsToModel(Model model, List<Product> trashedProducts) {
		long expiringSoonCount = trashedProducts.stream()
			.filter(p -> p.getDaysSinceDeleted() > 23) // Còn ít hơn 7 ngày
			.count();
		
		long recoverableCount = trashedProducts.stream()
			.filter(p -> p.getDaysSinceDeleted() <= 30) // Còn có thể khôi phục
			.count();
		
		model.addAttribute("expiringSoonCount", expiringSoonCount);
		model.addAttribute("recoverableCount", recoverableCount);
	}
}
