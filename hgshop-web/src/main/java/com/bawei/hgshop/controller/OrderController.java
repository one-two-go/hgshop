package com.bawei.hgshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.dubbo.config.annotation.Reference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bawei.hgshop.pojo.Cart;
import com.bawei.hgshop.pojo.Order;
import com.bawei.hgshop.pojo.Sku;
import com.bawei.hgshop.pojo.User;
import com.bawei.hgshop.service.CartService;
import com.bawei.hgshop.service.OrderService;
import com.bawei.hgshop.service.SkuService;
import com.github.pagehelper.PageInfo;

@RequestMapping("/order")
@Controller
public class OrderController {

	@Reference(url="dubbo://localhost:20890",timeout=5000)
	private OrderService orderService;
	
	@Reference(url="dubbo://localhost:20890",timeout=5000)
	private CartService cartService;
	
	@Reference(url="dubbo://localhost:20890",timeout=5000)
	private SkuService skuService;
	
	/**
	 * 订单页面
	 * @param ids
	 * @param request
	 * @return
	 */
	@RequestMapping("/preOrder")
	public String preOrder(Integer[] ids, HttpServletRequest request) {
		User user = (User) request.getAttribute("user");
		Integer userId = user.getUid();
		
		List<Cart> cartList = cartService.preOrder(userId, ids);
		Integer totalPrice = 0;
		Integer total = 0;
		
		for (Cart cart : cartList) {
			Sku sku = skuService.getSkuById2(cart.getSkuId());
			cart.setTitle(sku.getTitle());
			cart.setImage(sku.getImage());
			cart.setPrice(sku.getPrice());
			cart.setSubPrice(cart.getPrice() * cart.getPnum());
			totalPrice += cart.getSubPrice();
			total += cart.getPnum();
		}
		request.setAttribute("totalPrice", totalPrice);
		request.setAttribute("total", total);
		request.setAttribute("postFee", 10*100);
		request.setAttribute("actualPrice", totalPrice+10*100);
		// 把列表传递给页面
		request.setAttribute("cartList", cartList);
		
		return "order";
	}
	
	/**
	 * 创建订单
	 * @param order
	 * @param request
	 * @return
	 */
	@RequestMapping("/createOrder")
	public String createOrder(Order order, HttpServletRequest request) {
		User user = (User) request.getAttribute("user");
		Integer userId = user.getUid();
		order.setUserId(userId);
		orderService.createOrder(order);
		return "redirect:/order/myorder";
	}
	
	@RequestMapping("/myorder")
	public String orderList(HttpServletRequest request, Model model, String keyword, @RequestParam(defaultValue="1")Integer pageNum, @RequestParam(defaultValue="3")Integer pageSize) {
		//1.获取数据
		User user = (User) request.getAttribute("user");
		Integer userId = user.getUid();
		
		PageInfo<Order> pageInfo = orderService.orderList(userId, keyword, pageNum, pageSize);
		model.addAttribute("pageInfo", pageInfo);
		
//		Map<String, String> filter = new HashMap<>();
//		filter.put("userId", userId+"");
//		Map<String, Object> map = orderService.search(keyword, pageNum, pageSize, filter);
//		//2.填充数据
//		model.addAttribute("map", map);
		model.addAttribute("keyword1", keyword);
		return "myorder";
	}
	
	@RequestMapping("/getOrderById")
	public String getOrderById(String id, HttpServletRequest request){
		Order order = orderService.getOrderById(id);
		request.setAttribute("order", order);
		return "order_detail";
	}
	
	/*@InitBinder
    public void initBinder(WebDataBinder binder, WebRequest request) {
        //转换日期格式
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        //注册自定义的编辑器
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
        
    }*/
}
	