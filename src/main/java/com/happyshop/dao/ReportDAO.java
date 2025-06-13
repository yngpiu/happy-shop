package com.happyshop.dao;

import java.util.List;

/**
 * ===== INTERFACE DAO BÁO CÁO & THỐNG KÊ =====
 * 
 * Interface định nghĩa các thao tác tạo báo cáo và thống kê:
 * - Báo cáo tồn kho sản phẩm
 * - Báo cáo doanh thu theo danh mục
 * - Báo cáo doanh thu theo khách hàng
 * - Báo cáo doanh thu theo thời gian
 * 
 * Tính năng:
 * - Inventory reporting
 * - Revenue analysis by category
 * - Customer purchase reports
 * - Time-based revenue analytics
 * 
 * Author: Development Team
 * Version: 1.0 - Reporting & Analytics Interface
 */
public interface ReportDAO {
	
	// ================= INVENTORY REPORTS =================
	
	/**
	 * Báo cáo tồn kho sản phẩm
	 * @return List<Object[]> danh sách thông tin tồn kho
	 */
	public List<Object[]> inventory();
	
	// ================= REVENUE REPORTS =================
	
	/**
	 * Báo cáo doanh thu theo danh mục sản phẩm
	 * @return List<Object[]> doanh thu từng danh mục
	 */
	public List<Object[]> revenueByCategory();
	
	/**
	 * Báo cáo doanh thu theo khách hàng
	 * @return List<Object[]> doanh thu từng khách hàng
	 */
	public List<Object[]> revenueByCustomer();
	
	// ================= TIME-BASED REPORTS =================
	
	/**
	 * Báo cáo doanh thu theo năm
	 * @return List<Object[]> doanh thu từng năm
	 */
	public List<Object[]> revenueByYear();
	
	/**
	 * Báo cáo doanh thu theo quý
	 * @return List<Object[]> doanh thu từng quý
	 */
	public List<Object[]> revenueByQuarter();
	
	/**
	 * Báo cáo doanh thu theo tháng
	 * @return List<Object[]> doanh thu từng tháng
	 */
	public List<Object[]> revenueByMonth();
}
