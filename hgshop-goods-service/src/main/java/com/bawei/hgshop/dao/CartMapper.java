package com.bawei.hgshop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bawei.hgshop.pojo.Cart;

public interface CartMapper {

	void insertCart(Cart cart);

	List<Cart> list(int i);

	void updateNum(@Param("id")Integer id, @Param("pnum")Integer pnum);

	void deleteCartItems(Integer[] ids);

	void deleteAll(Integer userId);

	Cart selectCartByKey(@Param("userId")Integer userId, @Param("skuId")Integer skuId);

	List<Cart> preOrder(@Param("userId")Integer userId, @Param("ids")Integer[] ids);

	void deleteCartItemsBySkuIds(@Param("skuIds")Integer[] skuIds, @Param("userId")Integer userId);

	

}
