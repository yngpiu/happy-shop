package com.happyshop.config;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

import com.happyshop.JavaWebApplication;

/**
 * ===== CẤU HÌNH SERVLET INITIALIZER =====
 * 
 * Class khởi tạo servlet container cho deployment:
 * - Cấu hình WAR deployment
 * - Khởi tạo Spring Boot application
 * - Override configuration builder
 * - Support external servlet containers
 * 
 * Tính năng:
 * - WAR file deployment support
 * - Tomcat/Jetty compatibility
 * - Spring Boot application bootstrap
 * - External container integration
 * 
 * Author: Development Team
 * Version: 1.0 - Servlet Container Configuration
 */
public class ServletInitializer extends SpringBootServletInitializer {

	// ================= SERVLET CONFIGURATION =================
	
	/**
	 * Cấu hình Spring Application Builder cho WAR deployment
	 * @param application SpringApplicationBuilder instance
	 * @return SpringApplicationBuilder đã cấu hình
	 */
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(JavaWebApplication.class);
	}

}
