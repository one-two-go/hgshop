package com.bawei.hgshop.service;

import java.util.List;

import com.bawei.hgshop.pojo.Cart;

public interface CartService {

	void addCart(Cart cart);
	
	List<Cart> list(Integer userId);

	void updateNum(Integer id, Integer pnum);
	
	void deleteCartItems(Integer[] ids);
	
	void clearCart(Integer userId);

	Cart getCartByKey(Integer userId, Integer skuId);

	List<Cart> preOrder(Integer userId, Integer[] ids);

	void deleteCartItemsBySkuIds(Integer[] skuIds, Integer userId);
}
