package com.happyshop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.happyshop.interceptor.AuthorizelnterceptorAdmin;
import com.happyshop.interceptor.Sharelnterceptor;

/**
 * ===== CẤU HÌNH INTERCEPTOR ADMIN =====
 * 
 * Class cấu hình interceptor cho phần admin:
 * - Đăng ký Share Interceptor cho tất cả request
 * - Đăng ký Admin Authorization Interceptor
 * - Bảo vệ tất cả các trang admin
 * - Kiểm tra quyền admin trước khi truy cập
 * 
 * Tính năng:
 * - Admin authentication checking
 * - Administrative area protection
 * - Role-based access control
 * - Comprehensive admin route security
 * 
 * Author: Development Team
 * Version: 1.0 - Admin Security Configuration
 */
@Configuration
public class InterceptorConfigAdmin implements WebMvcConfigurer {
	
	// ================= DEPENDENCY INJECTION =================
	
	@Autowired
	Sharelnterceptor share;				// Interceptor chia sẻ dữ liệu global

	@Autowired
	AuthorizelnterceptorAdmin auth;		// Interceptor kiểm tra quyền admin

	// ================= INTERCEPTOR REGISTRATION =================
	
	/**
	 * Đăng ký các interceptor với registry cho admin area
	 * @param registry InterceptorRegistry để đăng ký interceptor
	 */
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// Đăng ký Share Interceptor cho tất cả các request
		registry.addInterceptor(share).addPathPatterns("/**");

		// Đăng ký Admin Auth Interceptor cho tất cả trang admin
		registry.addInterceptor(auth).addPathPatterns(
				"/admin/home/index", 				// Trang chủ admin
				"/admin/product/index", 			// Quản lý sản phẩm
				"/admin/category/index",			// Quản lý danh mục
				"/admin/category/add",				// Thêm danh mục
				"/admin/category/edit/**",			// Sửa danh mục
				"/admin/inventory/index",			// Quản lý tồn kho
				"/admin/profile",					// Profile admin
				"/admin/user/index",				// Quản lý người dùng
				"/admin/order/index", 				// Quản lý đơn hàng
				"/admin/report/inventory", 			// Báo cáo tồn kho
				"/admin/revenue/category",			// Doanh thu theo danh mục
				"/admin/revenue/customer",			// Doanh thu theo khách hàng
				"/admin/revenue/month",				// Doanh thu theo tháng
				"/admin/revenue/quarter",			// Doanh thu theo quý
				"/admin/change",					// Đổi mật khẩu admin
				"/admin/revenue/year",				// Doanh thu theo năm
				"/admin/report/revenue-by-category",	// Report doanh thu danh mục
				"/admin/report/revenue-by-customer", 	// Report doanh thu khách hàng
				"/admin/report/revenue-by-month",		// Report doanh thu tháng
				"/admin/report/revenue-by-quarter", 	// Report doanh thu quý
				"/admin/report/revenue-by-year");		// Report doanh thu năm
	}
}
