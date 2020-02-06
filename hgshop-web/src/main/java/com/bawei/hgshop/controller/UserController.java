package com.bawei.hgshop.controller;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.dubbo.config.annotation.Reference;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bawei.hgshop.pojo.User;
import com.bawei.hgshop.service.UserService;
import com.fasterxml.jackson.databind.util.JSONPObject;

@Controller
public class UserController {

	@Reference(url="dubbo://localhost:20890")
	private UserService userService;
	
	@RequestMapping("/toRegister")
	public String toRegister() {
		return "register";
	}
	
	/**
	 * 校验注册时，用户名/邮箱/手机号是否唯一
	 * @param param	用户名值/邮箱号/手机号
	 * @param type 1:用户名 2:邮箱 3:手机号
	 * @return
	 */
	@RequestMapping("/check")
	@ResponseBody
	public boolean check(String param, Integer type){
		return userService.check(param, type);
	}
	
	@PostMapping("/register")
	@ResponseBody
	public boolean register(User user) {
		return userService.register(user);
	}
	
	@RequestMapping("/toLogin")
	public String toLogin() {
		return "login";
	}
	
	@PostMapping("/login")
	@ResponseBody
	public Map<String, Object> login(String name, String password, HttpServletResponse response) {
		Map<String, Object> map = userService.login(name, password);
		//如果code=1000,登录成功，写token到cookie
		if (map.get("code").equals("1000")) {
			addCookie(map.get("msg").toString(), response);
		}
		return map;
	}
	
	private void addCookie(String token, HttpServletResponse response) {
		Cookie cookie = new Cookie("token", token);
		response.addCookie(cookie);
	}

	@RequestMapping("/logout")
	public String logout(String token) {
		userService.logout(token);
		return "login";
	}
	
	@RequestMapping("/token")
	@ResponseBody
	public Object getUserByToken(String token, String callback) {
		Map<String, Object> map = userService.getUserByToken(token);
		if (StringUtils.isNotBlank(callback)) {
			return new JSONPObject(callback, map);
		}
		return map;
	}
}
	