package com.bawei.hgshop.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;

import org.apache.dubbo.config.annotation.Reference;
import org.apache.dubbo.config.annotation.Service;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.data.elasticsearch.core.aggregation.AggregatedPage;

import com.bawei.hgshop.dao.OrderMapper;
import com.bawei.hgshop.pojo.Order;
import com.bawei.hgshop.pojo.OrderDetail;
import com.bawei.hgshop.service.CartService;
import com.bawei.hgshop.service.OrderService;
import com.bawei.hgshop.util.ESUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Resource
	private OrderMapper orderMapper;
	
	@Reference(url="dubbo://localhost:20890")
	private CartService cartService;
	
	@Resource
    private ElasticsearchTemplate template;
	
	@Override
	public String createOrder(Order order) {
		//1.生成订单号
		String date = new SimpleDateFormat("yyyyMMdd").format(new Date());
		String result="";
        Random random=new Random();
        for(int i=0;i<5;i++){
            result += random.nextInt(10);
        }
		order.setOrderId(date + result);
		//3.订单状态(1:待支付 2:待收货 3.已发货 3.已收货 4.取消 5.待评价 6.已退货)
		order.setStatus(1);
		order.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		//4.保存order
        orderMapper.insertOrder(order);
        
        //5.插入订单明细
		for (OrderDetail orderDetail : order.getOrderDetails()) {
			orderDetail.setOrderId(order.getOrderId());
			//5.1.保存detail
	        orderMapper.insertOrderDetail(orderDetail);
	        //5.2.删除购物车已购买的购物项
	        cartService.deleteCartItemsBySkuIds(new Integer[]{Integer.parseInt(orderDetail.getSkuId())}, order.getUserId());
		}
		//6.将订单和订单明细存到ES中
//		saveESOrder(order);
		return order.getOrderId();
	}
	
	@Override
	public void saveESOrder(Order order) {
		template.putMapping(Order.class);
		ESUtils.saveObject(template, order.getOrderId() + "", order);
	}
	
	@Override
	public Map<String, Object> search(String keyword, Integer pageNum, Integer pageSize, Map<String, String> filter) {
		Map<String, Object> map = new HashMap<>();
		AggregatedPage<Order> result = (AggregatedPage<Order>)ESUtils.selectObjects(template, Order.class, pageNum, pageSize, new String[]{"orderId", "orderDetails.title", "orderDetails.skuId"}, keyword, "orderId", filter);
		
		long total = result.getTotalElements();
        int totalPage = result.getTotalPages();
        List<Order> items = result.getContent();
        
        
        map.put("pageNum", pageNum);
        map.put("pageSize", pageSize);
        map.put("total", total);
        map.put("totalPage", totalPage);
        map.put("items", items);
        
        return map;
	}
	
	@Override
	public Order getOrderById(String orderId) {
		return orderMapper.selectOrderById(orderId);
	}
	@Override
	public PageInfo<Order> orderList(Integer userId, String keyword, Integer pageNum, Integer pageSize) {
		PageHelper.startPage(pageNum, pageSize);
//		List<Order> orderList = orderMapper.selectOrderList(userId);
		List<Order> orderList = orderMapper.selectOrderListBySearch(keyword, userId);
		for (Order order : orderList) {
			List<OrderDetail> orderDetailList = orderMapper.selectOrderDetailListByOrderId(order.getOrderId());
			order.setOrderDetails(orderDetailList);
		}
		PageInfo<Order> pageInfo = new PageInfo<>(orderList);
		return pageInfo;
	}
}
