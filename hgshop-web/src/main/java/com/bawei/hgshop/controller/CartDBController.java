package com.bawei.hgshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.dubbo.config.annotation.Reference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bawei.hgshop.pojo.Cart;
import com.bawei.hgshop.pojo.User;
import com.bawei.hgshop.service.CartService;

@RequestMapping("/cartdb")
@Controller
public class CartDBController {

	@Reference(url="dubbo://localhost:20890",timeout=5000)
	private CartService cartService;
	
	@RequestMapping("/addCart")
	public String addCart(HttpServletRequest request, Integer skuId, Integer pnum) {
		//1.查询数据库中有没有该skuId对应的购物项
		User user = (User) request.getAttribute("user");
		Integer userId = user.getUid();
		Cart cart = cartService.getCartByKey(userId, skuId);
		//2.如果有，就修改数量
		if (cart != null) {
			cartService.updateNum(cart.getId(), cart.getPnum() + pnum);
		} else {
			//3.如果没有，就插入
			cart = new Cart();
			cart.setSkuId(skuId);
			cart.setPnum(pnum);
			cart.setUid(userId);
			cartService.addCart(cart);
		}
		return "redirect:/cartdb/cartList";
	}
	
	@RequestMapping("/cartList")
	public String list(HttpServletRequest request, Model model) {
		Integer totalPrice = 0;
		Integer total = 0;
		//①关联查询购物项和商品
		User user = (User) request.getAttribute("user");
		Integer userId = user.getUid();
		List<Cart> list = cartService.list(userId);
		//②计算total1/total/totalPrice/subPrice
		for (Cart cart : list) {
			cart.setSubPrice(cart.getPrice()*cart.getPnum()); //分
			totalPrice += cart.getSubPrice();
			total += cart.getPnum();
		}
		model.addAttribute("total1", list.size());
		model.addAttribute("totalPrice", totalPrice); //分
		model.addAttribute("total", total);
		model.addAttribute("cartList", list);
		return "cart";
	}
	
	@RequestMapping("/updateNum")
	@ResponseBody
	public void updateNum(Integer id, Integer pnum) {
		cartService.updateNum(id, pnum);
	}
	
	@RequestMapping("/deleteCartItems")
	@ResponseBody
	public boolean deleteCartItems(Integer[] ids) {
		cartService.deleteCartItems(ids);
		return true;
	}
	
	
	
	@RequestMapping("/clearCart")
	public String clearCart(HttpServletRequest request) {
		User user = (User) request.getAttribute("user");
		Integer userId = user.getUid();
		cartService.clearCart(userId);
		return "redirect:/cartdb/cartList";
	}
	
	
	
	
	
}
