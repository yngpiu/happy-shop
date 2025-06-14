package com.happyshop.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.happyshop.interceptor.Authorizelnterceptor;
import com.happyshop.interceptor.AuthorizelnterceptorAdmin;
import com.happyshop.interceptor.Sharelnterceptor;

/**
 * ===== CẤU HÌNH WEB MVC TỔNG HỢP =====
 * 
 * Class cấu hình tổng hợp cho toàn bộ hệ thống:
 * - Quản lý tất cả interceptor trong một nơi
 * - Cấu hình authentication cho user và admin
 * - Chia sẻ dữ liệu global qua Share Interceptor
 * - Bảo vệ các route cần authentication
 * 
 * Tính năng:
 * - Unified interceptor management
 * - Role-based access control
 * - Session management
 * - Protected route handling
 * 
 * Author: Development Team
 * Version: 2.0 - Unified Configuration System
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	// ================= DEPENDENCY INJECTION =================

	@Autowired
	private Sharelnterceptor shareInterceptor;

	@Autowired
	private Authorizelnterceptor userAuthInterceptor;

	@Autowired
	private AuthorizelnterceptorAdmin adminAuthInterceptor;

	// ================= INTERCEPTOR REGISTRATION =================
	
	/**
	 * Đăng ký tất cả interceptor cho hệ thống
	 * @param registry InterceptorRegistry để đăng ký interceptor
	 */
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		// 1. Share Interceptor - Áp dụng cho tất cả request
		registry.addInterceptor(shareInterceptor)
				.addPathPatterns("/**");

		// 2. User Authentication Interceptor - Bảo vệ các trang user
		registry.addInterceptor(userAuthInterceptor)
				.addPathPatterns(
					"/account/change", 		// Đổi mật khẩu
					"/account/edit", 		// Chỉnh sửa thông tin
					"/account/logout",		// Đăng xuất
					"/account/order/**",	// Tất cả order của user
					"/order/checkout", 		// Thanh toán đơn hàng
					"/order/list",			// Danh sách đơn hàng
					"/order/items",			// Chi tiết items
					"/order/detail/**"		// Chi tiết đơn hàng
				);

		// 3. Admin Authentication Interceptor - Bảo vệ toàn bộ admin area
		registry.addInterceptor(adminAuthInterceptor)
				.addPathPatterns("/admin/**")
				.excludePathPatterns(
					"/admin/login",			// Trang login admin
					"/admin/static/**"		// Static resources
				);
	}
} 