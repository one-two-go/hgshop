package com.bawei.hgshop.service;

import java.util.Map;

import com.bawei.hgshop.pojo.User;

public interface UserService {

	boolean check(String param, Integer type);

	boolean register(User user);

	Map<String, Object> login(String name, String password);

	Map<String, Object> getUserByToken(String token);

	void logout(String token);

}
