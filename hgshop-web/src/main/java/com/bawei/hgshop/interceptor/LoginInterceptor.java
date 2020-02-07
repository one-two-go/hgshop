package com.bawei.hgshop.interceptor;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.dubbo.config.annotation.Reference;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.bawei.hgshop.pojo.User;
import com.bawei.hgshop.service.UserService;

/**
 * 用户登录处理拦截器
 * <p>Title: LoginInterceptor</p>
 */
public class LoginInterceptor implements HandlerInterceptor {
	
	@Reference(url="dubbo://localhost:20890")
	private UserService userService;

	private String getTokenFromCookie(HttpServletRequest request) {
		String token = null;
		Cookie[] cookies = request.getCookies();
		for (Cookie cookie : cookies) {
			if ("token".equalsIgnoreCase(cookie.getName())) {
				token = cookie.getValue();
				break;
			}
		}
		return token;
	}
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// 前处理，执行handler之前执行此方法。
		//返回true，放行	false：拦截
		//1.从cookie中取token
		String token = getTokenFromCookie(request);
		//2.如果没有token，未登录状态，跳转到登录页
		if (StringUtils.isBlank(token)) {
			response.sendRedirect("http://localhost:9090/toLogin?redirectUrl=" + request.getRequestURL() + "?" + request.getQueryString());
			return false;
		}
		//3.取到token，需要调用用户服务，根据token取用户信息
		Map<String, Object> map = userService.getUserByToken(token);
		//4.没有取到用户信息。登录过期，直接放行。
		if (!"1000".equals(map.get("code").toString())) {
			response.sendRedirect("http://localhost:9090/toLogin?redirectUrl=" + request.getRequestURL() + "?" + request.getQueryString());
			return false;
		}
		//5.取到用户信息。登录状态。
		User user = (User) map.get("data");
		//6.把用户信息放到request中。只需要在Controller中判断request中是否包含user信息。放行
		request.setAttribute("user", user);
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView)
			throws Exception {
		//handler执行之后，返回ModeAndView之前
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		//完成处理，返回ModelAndView之后。
		//可以在此处理异常

	}

}
