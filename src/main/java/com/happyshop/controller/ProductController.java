package com.happyshop.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.happyshop.bean.MailInfo;
import com.happyshop.dao.ProductDAO;
import com.happyshop.entity.Product;
import com.happyshop.service.CookieService;
import com.happyshop.service.MailService;

/**
 * ===== CONTROLLER SẢN PHẨM USER =====
 * 
 * Controller xử lý các chức năng sản phẩm phía user:
 * - Hiển thị danh sách sản phẩm theo danh mục
 * - Hiển thị chi tiết sản phẩm
 * - Tìm kiếm sản phẩm theo từ khóa
 * - Quản lý sản phẩm yêu thích và đã xem
 * 
 * Tính năng:
 * - Product listing và filtering
 * - Product detail với view tracking
 * - Favorite products management
 * - Recently viewed products
 * 
 * Author: Development Team
 * Version: 1.0 - User Product Management System
 */
@Controller
public class ProductController {

	// ================= DEPENDENCY INJECTION =================

	@Autowired
	ProductDAO pdao;

	@Autowired
	CookieService cookie;

	@Autowired
	MailService mail;
	
	// ================= PRODUCT LISTING OPERATIONS =================
	
	/**
	 * Hiển thị danh sách sản phẩm theo danh mục
	 * @param model Model để truyền dữ liệu
	 * @param categoryId ID của danh mục
	 * @return String view name cho product list
	 */
	@RequestMapping("/product/list-by-category/{cid}")
	public String listByCategory(Model model, @PathVariable("cid") Integer categoryId) {
		List<Product> list = pdao.findByCategoryId(categoryId);
		model.addAttribute("list", list);
		return "product/list";
	}
	
	/**
	 * Hiển thị danh sách sản phẩm theo danh mục (layout khác)
	 * @param model Model để truyền dữ liệu
	 * @param categoryId ID của danh mục
	 * @return String view name cho product list copy
	 */
	@RequestMapping("/product/list-by-categorys/{cid}")
	public String listByCategorys(Model model, @PathVariable("cid") Integer categoryId) {
		List<Product> list = pdao.findByCategoryId(categoryId);
		model.addAttribute("list", list);
		return "product/list_copy";
	}

	/**
	 * Tìm kiếm sản phẩm theo từ khóa
	 * @param model Model để truyền dữ liệu
	 * @param keywords Từ khóa tìm kiếm
	 * @return String view name cho search results
	 */
	@RequestMapping("/product/list-by-keywords")
	public String listByKeywords(Model model, @RequestParam("keywords") String keywords) {
		List<Product> list = pdao.findByKeywords(keywords);
		model.addAttribute("list5", list);
		return "product/list";
	}

	/**
	 * Hiển thị danh sách sản phẩm đặc biệt
	 * @param model Model để truyền dữ liệu
	 * @param id Số lượng sản phẩm cần lấy
	 * @return String view name cho special products
	 */
	@RequestMapping("/product/list-by-special/{id}")
	public String listBySpecial(Model model, @PathVariable("id") Integer id) {
		// Lấy sản phẩm đặc biệt với số lượng theo ID (limit)
		List<Product> list = pdao.findSpecialProducts(id);
		model.addAttribute("list", list);
		return "product/list_special_full";
	}
	
	/**
	 * Hiển thị danh sách sản phẩm mới nhất
	 * @param model Model để truyền dữ liệu
	 * @param id Số lượng sản phẩm cần lấy
	 * @return String view name cho new products
	 */
	@RequestMapping("/product/list-by-new/{id}")
	public String listByNews(Model model, @PathVariable("id") Integer id) {
		// Lấy sản phẩm mới nhất với số lượng theo ID (limit)
		List<Product> list = pdao.findActiveProducts(id);
		model.addAttribute("list1", list);
		return "product/list-by-new_full";
	}

	// ================= PRODUCT DETAIL OPERATIONS =================

	/**
	 * Hiển thị chi tiết sản phẩm với tracking và gợi ý
	 * @param model Model để truyền dữ liệu
	 * @param id ID của sản phẩm
	 * @return String view name cho product detail
	 */
	@RequestMapping("/product/detail/{id}")
	public String detail(Model model, @PathVariable("id") Integer id) {
		Product prod = pdao.findById(id);
		model.addAttribute("prod", prod);

		// Tăng số lần xem
		prod.setViewCount(prod.getViewCount() + 1);
		pdao.update(prod);

		// Hàng cùng loại
		List<Product> list = pdao.findByCategoryId(prod.getCategory().getId());
		model.addAttribute("list", list);

		// Hàng yêu thích
		Cookie favo = cookie.read("favo");
		if (favo != null) {
			String ids = favo.getValue();
			List<Product> favo_list = pdao.findByIds(ids);
			model.addAttribute("favo", favo_list);
		}

		// Hàng đã xem
		Cookie viewed = cookie.read("viewed");
		String value = id.toString();
		if (viewed != null) {
			value = viewed.getValue();
			value += "," + id.toString();
		}
		cookie.create("viewed", value, 10);
		List<Product> viewed_list = pdao.findByIds(value);
		model.addAttribute("viewed", viewed_list);

		return "product/detail";
	}
	
	// ================= FAVORITE OPERATIONS =================

	/**
	 * Thêm sản phẩm vào danh sách yêu thích (AJAX)
	 * @param model Model object
	 * @param id ID của sản phẩm
	 * @return String "true" nếu thành công, "false" nếu đã tồn tại
	 */
	@ResponseBody
	@RequestMapping("/product/add-to-favo/{id}")
	public String addToFavorite(Model model, @PathVariable("id") Integer id) {
		Cookie favo = cookie.read("favo");
		String value = id.toString();
		if (favo != null) {
			value = favo.getValue();
			if (!value.contains(id.toString())) {
				value += "," + id.toString();
			}else {
				return "false";
			}
		}
		cookie.create("favo", value, 30);
		return "true";
	}

	/**
	 * Hiển thị trang danh sách sản phẩm yêu thích
	 * @param model Model để truyền dữ liệu
	 * @return String view name cho favorite products
	 */
	@RequestMapping("/product/favo")
	public String favo(Model model) {
		// Hàng yêu thích
		Cookie favo = cookie.read("favo");
		if (favo != null) {
			String ids = favo.getValue();
			List<Product> favo_list = pdao.findByIds(ids);
			model.addAttribute("favo", favo_list);
		}
		return "product/favo";
	}
	
	// ================= SHARING OPERATIONS =================

	/**
	 * Gửi thông tin sản phẩm cho bạn bè qua email (AJAX)
	 * @param model Model object
	 * @param info MailInfo chứa thông tin email
	 * @param req HttpServletRequest để lấy product ID
	 * @return String "true" nếu gửi thành công, "false" nếu lỗi
	 */
	@ResponseBody
	@RequestMapping("/product/send-to-friend")
	public String sendToFriend(Model model,MailInfo info,HttpServletRequest req) {
		//send mail
		info.setSubject("Thông tin hàng hóa");
		try {
			String id=req.getParameter("id");
			String link=req.getRequestURL().toString().replace("send-to-friend", "detail/"+id);
			info.setBody(info.getBody()+"<hr><a href='"+link+"'>Xem chi tiết...</a>");
			mail.send(info);
			return "true";
		} catch (Exception e) {
			e.printStackTrace();
			return "false";
		}
	}
}
