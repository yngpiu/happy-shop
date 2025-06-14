package com.happyshop.interceptor;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.happyshop.entity.User;

@Component
public class AuthorizelnterceptorAdmin extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		// Kiểm tra user đã đăng nhập chưa
		if(user == null) {
			session.setAttribute("back-url-admin", request.getRequestURI());
			response.sendRedirect("/account/login");
			return false;
		}
		
		// Kiểm tra quyền admin (giả sử admin có id = 1 hoặc có field isAdmin)
		// Bạn có thể thay đổi logic này theo cấu trúc User entity của mình
		if(!user.getAdmin()) {  // Hoặc user.getId() != 1 hoặc !user.isAdmin()
			response.sendRedirect("/account/login?error=access_denied");
			return false;
		}
		
		return true;
	}
}
