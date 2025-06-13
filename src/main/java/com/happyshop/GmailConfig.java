package com.happyshop;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

/**
 * ===== CẤU HÌNH GMAIL =====
 * 
 * Class cấu hình dịch vụ gửi email qua Gmail:
 * - Cấu hình SMTP server của Gmail
 * - Thiết lập authentication
 * - Cấu hình encoding UTF-8
 * - Cấu hình STARTTLS security
 * 
 * Tính năng:
 * - Gửi email thông qua Gmail SMTP
 * - Hỗ trợ HTML content
 * - Hỗ trợ file đính kèm
 * - Cấu hình bảo mật TLS
 * 
 * Author: Development Team
 * Version: 1.0 - Email Service Configuration
 */
@Configuration
public class GmailConfig {
	
	// ================= MAIL SENDER CONFIGURATION =================
	
	/**
	 * Cấu hình JavaMailSender cho Gmail
	 * @return JavaMailSender đã cấu hình với Gmail SMTP
	 */
	@Bean
	public JavaMailSender getJavaMailSender() {
		JavaMailSenderImpl sender=new JavaMailSenderImpl();
		sender.setDefaultEncoding("utf-8");
		sender.setHost("smtp.gmail.com");
		sender.setPort(587);
		sender.setUsername("happyshopsuport2022@gmail.com");
		sender.setPassword("@Happyshop");
		
		// Cấu hình properties cho SMTP
		Properties props=sender.getJavaMailProperties();
		props.setProperty("mail.transport.protocol","smtp");
		props.setProperty("mail.smtp.auth","true");
		props.setProperty("mail.smtp.starttls.enable","true");
		props.setProperty("mail.debug","true");
		
		return sender;
	}
}
