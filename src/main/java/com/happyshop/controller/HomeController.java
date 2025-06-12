package com.happyshop.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.happyshop.dao.ProductDAO;
import com.happyshop.entity.Product;



@Controller
public class HomeController {
	@Autowired
	ProductDAO pdao;
	
	@RequestMapping(value = {"", "/home"})
	public String index(Model model) {
		// Lấy 4 sản phẩm đặc biệt (special = true)
		List<Product> specialProducts = pdao.findSpecialProducts(4);
		model.addAttribute("list", specialProducts);
		
		// Lấy sản phẩm mới nhất (active products)
		List<Product> latestProducts = pdao.findActiveProducts(8);
		model.addAttribute("list1", latestProducts);
		
		return "home/index";
	}
	@RequestMapping("/about")
	public String about() {
		return "home/about";
	}
	@RequestMapping("/contact")
	public String contact() {
		return "home/contact";
	}
	@RequestMapping("/feedback")
	public String feedback() {
		return "home/feedback";
	}
	@RequestMapping("/faq")
	public String faq() {
		return "home/faq";
	}
	
	@ResponseBody
	@RequestMapping("/home/language")
	public void language() {

	}
}
