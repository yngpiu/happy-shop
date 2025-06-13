package com.happyshop;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceTransactionManagerAutoConfiguration;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;

/**
 * ===== MAIN APPLICATION CLASS =====
 * 
 * Class chính để khởi chạy ứng dụng Spring Boot:
 * - Cấu hình auto configuration
 * - Loại trừ các tự động cấu hình database mặc định
 * - Sử dụng Hibernate configuration tùy chỉnh
 * - Entry point của toàn bộ hệ thống
 * 
 * Tính năng:
 * - Disable Spring Boot auto datasource configuration
 * - Enable custom Hibernate configuration
 * - Main application bootstrap
 * 
 * Author: Development Team
 * Version: 1.0 - Happy Shop E-commerce System
 */
@SpringBootApplication
@EnableAutoConfiguration(exclude= {
		DataSourceAutoConfiguration.class,
		DataSourceTransactionManagerAutoConfiguration.class,
		HibernateJpaAutoConfiguration.class	
})
public class JavaWebApplication {

	// ================= APPLICATION ENTRY POINT =================
	
	/**
	 * Main method - điểm khởi chạy ứng dụng
	 * @param args tham số dòng lệnh
	 */
	public static void main(String[] args) {
		SpringApplication.run(JavaWebApplication.class, args);
	}
}
