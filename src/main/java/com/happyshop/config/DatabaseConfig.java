package com.happyshop.config;

import java.io.IOException;
import java.util.Properties;

import javax.sql.DataSource;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;

/**
 * ===== CẤU HÌNH HIBERNATE =====
 * 
 * Class cấu hình Hibernate và Database:
 * - Cấu hình DataSource connection
 * - Cấu hình Hibernate SessionFactory
 * - Cấu hình Transaction Manager
 * - Load properties từ file cấu hình
 * 
 * Tính năng:
 * - Tự động tạo SessionFactory từ properties
 * - Quản lý transaction với HibernateTransactionManager
 * - Scan entity package tự động
 * - Cấu hình dialect và session context
 * 
 * Author: Development Team
 * Version: 1.0 - Database Configuration System
 */
@Configuration
@PropertySource("classpath:datasource.properties")
public class DatabaseConfig {
	
	// ================= DEPENDENCY INJECTION =================
	
	@Autowired
	Environment env;

	// ================= DATASOURCE CONFIGURATION =================
	
	/**
	 * Cấu hình DataSource từ properties file
	 * @return DataSource đã cấu hình
	 */
	@Bean
	public DataSource getDataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName(env.getProperty("db.driver"));
		dataSource.setUrl(env.getProperty("db.url"));
		dataSource.setUsername(env.getProperty("db.username"));
		dataSource.setPassword(env.getProperty("db.password"));
		return dataSource;
	}
	
	// ================= HIBERNATE CONFIGURATION =================
	
	/**
	 * Cấu hình Hibernate SessionFactory
	 * @param dataSource DataSource để kết nối database
	 * @return SessionFactory đã cấu hình
	 * @throws IOException nếu có lỗi đọc properties
	 */
	@Bean
	@Autowired
	public SessionFactory getSessionFactory(DataSource dataSource) throws IOException{
		LocalSessionFactoryBean factoryBean=new LocalSessionFactoryBean();
		factoryBean.setPackagesToScan(new String[] {"com.happyshop.entity"});
		factoryBean.setDataSource(dataSource);
		Properties props=factoryBean.getHibernateProperties();
		props.put("hibernate.dialect", env.getProperty("hb.dialect"));
		props.put("hibernate.show_sql", env.getProperty("hb.show-sql"));
		props.put("current_session_context_class", env.getProperty("hb.session"));
		factoryBean.afterPropertiesSet();
		SessionFactory sessionFactory=factoryBean.getObject();
		return sessionFactory;
	}
	
	// ================= TRANSACTION MANAGEMENT =================
	
	/**
	 * Cấu hình Hibernate Transaction Manager
	 * @param sessionFactory SessionFactory để quản lý transaction
	 * @return HibernateTransactionManager đã cấu hình
	 */
	@Bean
	@Autowired
	public HibernateTransactionManager getTransactionManager(SessionFactory sessionFactory) {
		return new HibernateTransactionManager(sessionFactory);
	}
}
