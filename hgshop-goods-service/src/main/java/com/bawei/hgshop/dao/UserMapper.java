package com.bawei.hgshop.dao;

import org.apache.ibatis.annotations.Param;

import com.bawei.hgshop.pojo.User;

public interface UserMapper {

	int check(@Param("param")String param, @Param("type")Integer type);

	int register(User user);

	User getUserBySearch(String name);


}
