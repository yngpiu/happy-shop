package com.happyshop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.happyshop.interceptor.Authorizelnterceptor;
import com.happyshop.interceptor.Sharelnterceptor;

/**
 * ===== CẤU HÌNH INTERCEPTOR USER =====
 * 
 * Class cấu hình interceptor cho phần user:
 * - Đăng ký Share Interceptor cho tất cả request
 * - Đăng ký Authorization Interceptor cho các trang cần login
 * - Bảo vệ các chức năng user account
 * - Kiểm tra quyền truy cập các trang protected
 * 
 * Tính năng:
 * - Session management
 * - Authentication checking
 * - User authorization
 * - Protected route handling
 * 
 * Author: Development Team
 * Version: 1.0 - User Security Configuration
 */
@Configuration
public class InterceptorConfig implements WebMvcConfigurer {

	// ================= DEPENDENCY INJECTION =================

	@Autowired
	Sharelnterceptor share;		// Interceptor chia sẻ dữ liệu global

	@Autowired
	Authorizelnterceptor auth;	// Interceptor kiểm tra authentication

	// ================= INTERCEPTOR REGISTRATION =================
	
	/**
	 * Đăng ký các interceptor với registry
	 * @param registry InterceptorRegistry để đăng ký interceptor
	 */
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// Đăng ký Share Interceptor cho tất cả các request
		registry.addInterceptor(share).addPathPatterns("/**");

		// Đăng ký Auth Interceptor cho các trang cần đăng nhập
		registry.addInterceptor(auth).addPathPatterns(
				"/account/change", 		// Đổi mật khẩu
				"/order/checkout", 		// Thanh toán đơn hàng
				"/account/logout",		// Đăng xuất
				"/account/edit", 		// Chỉnh sửa thông tin
				"/order/list",			// Danh sách đơn hàng
				"/order/items",			// Chi tiết items
				"/order/detail",		// Chi tiết đơn hàng
				"/account/order/**");	// Tất cả order của user
	}
}
