package com.happyshop.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;

/**
 * ===== CẤU HÌNH VIEW & TEMPLATE =====
 * 
 * Class cấu hình Apache Tiles framework:
 * - Cấu hình ViewResolver cho Tiles
 * - Thiết lập TilesConfigurer
 * - Load tiles definition file
 * - Support template layout system
 * 
 * Tính năng:
 * - Template-based view rendering
 * - Layout composition framework
 * - Reusable view components
 * - Dynamic template resolution
 * 
 * Author: Development Team
 * Version: 2.0 - View Template Configuration
 */
@Configuration
public class ViewConfig {
	
	// ================= VIEW RESOLVER CONFIGURATION =================
	
	/**
	 * Cấu hình ViewResolver sử dụng Tiles
	 * @return ViewResolver đã cấu hình với TilesView
	 */
	@Bean("viewResolver")
	public ViewResolver getViewResolver() {
		UrlBasedViewResolver r = new UrlBasedViewResolver();
		r.setViewClass(TilesView.class);
		return r;
	}

	// ================= TILES CONFIGURER =================
	
	/**
	 * Cấu hình TilesConfigurer với definition file
	 * @return TilesConfigurer đã load definition
	 */
	@Bean("tilesConfigurer")
	public TilesConfigurer getTilesConfigurer() {
		TilesConfigurer t = new TilesConfigurer();
		t.setDefinitions("/WEB-INF/tiles.xml");
		return t;
	}
}
