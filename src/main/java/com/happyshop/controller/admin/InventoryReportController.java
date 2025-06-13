package com.happyshop.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.happyshop.dao.ReportDAO;

/**
 * ===== CONTROLLER BÁO CÁO ADMIN =====
 * 
 * Controller xử lý các báo cáo và thống kê:
 * - Báo cáo tồn kho sản phẩm
 * - Báo cáo doanh thu theo danh mục
 * - Báo cáo doanh thu theo khách hàng
 * - Báo cáo doanh thu theo thời gian
 * 
 * Tính năng:
 * - Inventory reports generation
 * - Revenue analytics by category
 * - Customer purchase analysis
 * - Time-based revenue reports
 * 
 * Author: Development Team
 * Version: 1.0 - Admin Reporting System
 */
@Controller
public class InventoryReportController {
	
	// ================= DEPENDENCY INJECTION =================
	
	@Autowired
	ReportDAO dao;
	
	// ================= INVENTORY REPORTS =================
	
	/**
	 * Hiển thị báo cáo tồn kho sản phẩm
	 * @param model Model để truyền dữ liệu báo cáo
	 * @return String view name cho inventory report
	 */
	@RequestMapping("/admin/inventory/index")
	public String index(Model model) {
		model.addAttribute("data", dao.inventory());
		return "admin/report/inventory";
	}
	
	// ================= REVENUE REPORTS =================
	
	/**
	 * Báo cáo doanh thu theo danh mục sản phẩm
	 * @param model Model để truyền dữ liệu báo cáo
	 * @return String view name cho revenue by category report
	 */
	@RequestMapping("/admin/revenue/category")
	public String revenueByCategory(Model model) {
		model.addAttribute("data", dao.revenueByCategory());
		return "admin/report/revenue-by-category";
	}
	
	/**
	 * Báo cáo doanh thu theo khách hàng
	 * @param model Model để truyền dữ liệu báo cáo
	 * @return String view name cho revenue by customer report
	 */
	@RequestMapping("/admin/revenue/customer")
	public String revenueByCustomer(Model model) {
		model.addAttribute("data", dao.revenueByCustomer());
		return "admin/report/revenue-by-customer";
	}
	
	// ================= TIME-BASED REPORTS =================
	
	/**
	 * Báo cáo doanh thu theo năm
	 * @param model Model để truyền dữ liệu báo cáo
	 * @return String view name cho revenue by year report
	 */
	@RequestMapping("/admin/revenue/year")
	public String revenueByYear(Model model) {
		model.addAttribute("data", dao.revenueByYear());
		return "admin/report/revenue-by-year";
	}
	
	/**
	 * Báo cáo doanh thu theo quý
	 * @param model Model để truyền dữ liệu báo cáo
	 * @return String view name cho revenue by quarter report
	 */
	@RequestMapping("/admin/revenue/quarter")
	public String revenueByQuarter(Model model) {
		model.addAttribute("data", dao.revenueByQuarter());
		return "admin/report/revenue-by-quarter";
	}
	
	/**
	 * Báo cáo doanh thu theo tháng
	 * @param model Model để truyền dữ liệu báo cáo
	 * @return String view name cho revenue by month report
	 */
	@RequestMapping("/admin/revenue/month")
	public String revenueByMonth(Model model) {
		model.addAttribute("data", dao.revenueByMonth());
		return "admin/report/revenue-by-month";
	}
}
