package com.happyshop.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Cấu hình để bật tính năng Spring Scheduling
 * Cho phép các @Scheduled methods chạy tự động theo lịch
 */
@Configuration
@EnableScheduling
public class SchedulingConfig {
	// Không cần thêm gì, chỉ cần @EnableScheduling annotation
} 