package com.bawei.hgshop.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class IndexController {

	/**
	 * 登录
	 * @param session
	 * @param username
	 * @param password
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/login")
	@ResponseBody
	public Map<String, String> login(HttpSession session, String username, String password) throws IOException {
		Map<String, String> result = new HashMap<>();
		//1.获取admin.properties中的文件内容
		Properties props = new Properties();
		//访问当前类同级目录下的文件；如果访问根目录下的文件，必须加上/
		//this.getClass().getResourceAsStream("/admin.properties");
		InputStream is = this.getClass().getClassLoader().getResourceAsStream("admin.properties");
		props.load(is);
		String adminUser = props.getProperty("adminUser");
		String adminPassword = props.getProperty("adminPassword");
		//2.admin.properties中的内容与参数进行比较
		if (adminUser.equals(username) && adminPassword.equals(password)) {
			result.put("code", "200");
			result.put("msg", "登录成功");
			//2.1.将用户名存到session中
			session.setAttribute("adminName", username);
		} else {
			//2.2.返回错误码及错误信息
			result.put("code", "10086");
			result.put("msg", "用户名或密码不正确");
		}
		return result;
	}
	
	/**
	 * 注销
	 * @param session
	 * @return
	 */
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		//删除session中的管理员名称
		session.removeAttribute("adminName");
		//页面重定向到登录页
		return "redirect:/";
	}
	
	/**
	 * 后台主页
	 * @return
	 */
	@RequestMapping("/index")
	public String index() {
		return "index";
	}
	/**
	 * 欢迎页
	 * @return
	 */
	@RequestMapping("/welcome")
	public String welcome() {
		return "welcome";
	}
}
