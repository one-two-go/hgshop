package com.bawei.hgshop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bawei.hgshop.pojo.Order;
import com.bawei.hgshop.pojo.OrderDetail;

public interface OrderMapper {

	void insertOrder(Order order);

	void insertOrderDetail(OrderDetail orderDetail);

	Order selectOrderById(String orderId);

	List<Order> selectOrderList(Integer userId);

	List<OrderDetail> selectOrderDetailListByOrderId(String orderId);

	List<Order> selectOrderListBySearch(@Param("keyword")String keyword, @Param("userId")Integer userId);

}
