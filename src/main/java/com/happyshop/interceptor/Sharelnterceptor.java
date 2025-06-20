package com.happyshop.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.happyshop.dao.CategoryDAO;
import com.happyshop.dao.UserDAO;
import com.happyshop.entity.Category;
import com.happyshop.entity.User;

@Component
public class Sharelnterceptor extends HandlerInterceptorAdapter{
	
	@Autowired
	CategoryDAO dao;
	
	@Autowired
	UserDAO userDAO;
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		if (modelAndView != null) {
			// Only load active categories for frontend display
			List<Category> list=dao.findAllActive();
			modelAndView.addObject("cates", list);
			
			List<User> listUser = userDAO.findAll();
			modelAndView.addObject("users", listUser);
		}
	}
}
