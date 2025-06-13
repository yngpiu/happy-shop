package com.happyshop.service;

import java.util.Base64;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * ===== DỊCH VỤ QUẢN LÝ COOKIE =====
 * 
 * Service xử lý các thao tác cookie:
 * - Tạo cookie với mã hóa Base64
 * - Đọc cookie từ client request
 * - Xóa cookie (set max age = 0)
 * - Encoding/Decoding tự động
 * 
 * Tính năng:
 * - Cookie creation với expiry time
 * - Base64 encoding/decoding security
 * - Cookie path management
 * - Remember login functionality support
 * 
 * Author: Development Team
 * Version: 1.0 - Cookie Management Service
 */
@Service
public class CookieService {
	
	// ================= DEPENDENCY INJECTION =================
	
	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpServletResponse response;

	// ================= COOKIE OPERATIONS =================

	/**
	 * Tạo cookie mới với mã hóa Base64
	 * @param name Tên cookie
	 * @param value Giá trị cookie (sẽ được mã hóa)
	 * @param days Số ngày tồn tại
	 * @return Cookie đã được tạo
	 */
	public Cookie create(String name, String value, int days) {
		String encodedValue = Base64.getEncoder().encodeToString(value.getBytes());
		Cookie cookie = new Cookie(name, encodedValue);
		cookie.setMaxAge(days * 24 * 60 * 60);
		cookie.setPath("/");
		response.addCookie(cookie);
		return cookie;
	}

	/**
	 * Đọc cookie từ client request
	 * @param name Tên cookie cần đọc
	 * @return Cookie với giá trị đã được giải mã, null nếu không tìm thấy
	 */
	public Cookie read(String name) {
		Cookie[] cookies = request.getCookies(); //đọc từ client
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equalsIgnoreCase(name)) {
					String decodedValue = new String(Base64.getDecoder().decode(cookie.getValue()));
					cookie.setValue(decodedValue);
					return cookie;
				}
			}
		}
		return null;
	}

	/**
	 * Xóa cookie bằng cách set thời hạn tồn tại = 0
	 * @param name Tên cookie cần xóa
	 */
	public void delete(String name) {
		this.create(name, "", 0); //thời hạn tồn tại cookie = 0
	}
}
