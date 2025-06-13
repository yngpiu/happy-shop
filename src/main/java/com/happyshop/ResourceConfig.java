package com.happyshop;

import java.util.Locale;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;

/**
 * ===== CẤU HÌNH INTERNATIONALIZATION =====
 * 
 * Class cấu hình đa ngôn ngữ và tài nguyên:
 * - Cấu hình MessageSource cho i18n
 * - Thiết lập LocaleResolver
 * - Cấu hình locale change interceptor
 * - Support multiple language files
 * 
 * Tính năng:
 * - Multi-language support
 * - Dynamic language switching
 * - Cookie-based locale storage
 * - Reloadable resource bundles
 * 
 * Author: Development Team
 * Version: 1.0 - Internationalization Configuration
 */
@Configuration
public class ResourceConfig implements WebMvcConfigurer {
	
	// ================= MESSAGE SOURCE CONFIGURATION =================
	
	/**
	 * Cấu hình MessageSource cho hỗ trợ đa ngôn ngữ
	 * @return MessageSource đã cấu hình với file properties
	 */
	@Bean(name = "messageSource")
	public MessageSource getMessageSource() {
		ReloadableResourceBundleMessageSource ms = new ReloadableResourceBundleMessageSource();
		ms.setBasenames("classpath:static/i18n/account", "classpath:static/i18n/layout");
		ms.setDefaultEncoding("utf-8");
		return ms;
	}

	// ================= INTERCEPTOR CONFIGURATION =================
	
	/**
	 * Thêm LocaleChangeInterceptor để xử lý thay đổi ngôn ngữ
	 * @param registry InterceptorRegistry để đăng ký interceptor
	 */
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		LocaleChangeInterceptor inter = new LocaleChangeInterceptor();
		inter.setParamName("lang");
		registry.addInterceptor(inter).addPathPatterns("/home/language");
	}

	// ================= LOCALE RESOLVER CONFIGURATION =================
	
	/**
	 * Cấu hình LocaleResolver sử dụng Cookie
	 * @return LocaleResolver đã cấu hình với cookie storage
	 */
	@Bean("localeResolver")
	public LocaleResolver getLocaleResolver() {
		// SessionLocaleResolver
		CookieLocaleResolver r = new CookieLocaleResolver();
		r.setCookiePath("/");
		r.setCookieMaxAge(2 * 24 * 60 * 60);// 2 ngay
		r.setDefaultLocale(new Locale("en"));
		return r;
	}
}
