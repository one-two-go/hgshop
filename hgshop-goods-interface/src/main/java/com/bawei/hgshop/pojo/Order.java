package com.bawei.hgshop.pojo;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

@Document(indexName="docs1",type="order",shards=1,replicas=1)
public class Order implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Field( type = FieldType.Keyword)
	private String orderId; //订单号
	private Integer totalPrice; //总价(没有加运费)
	private Integer actualPrice; //实际价格(总价 +运费)
	private Integer postFee; //运费
	private Integer paymentType; //支付方式
	private Integer userId; //用户id
	private Integer status; //订单状态(待付款/已付款/待发货/已发货/已收货/自动关闭)    还有订单各个状态对应的时间 
	private String createTime; //生成时间
	
	@Field( type = FieldType.Nested)
	private List<OrderDetail> orderDetails;
	
	//物流/买家留言/收货人信息/发票信息
	public Order() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Order(String orderId, Integer totalPrice, Integer actualPrice, Integer postFee, Integer paymentType, Integer userId,
			Integer status, String createTime) {
		super();
		this.orderId = orderId;
		this.totalPrice = totalPrice;
		this.actualPrice = actualPrice;
		this.postFee = postFee;
		this.paymentType = paymentType;
		this.userId = userId;
		this.status = status;
		this.createTime = createTime;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public Integer getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(Integer totalPrice) {
		this.totalPrice = totalPrice;
	}
	public Integer getActualPrice() {
		return actualPrice;
	}
	public void setActualPrice(Integer actualPrice) {
		this.actualPrice = actualPrice;
	}
	public Integer getPostFee() {
		return postFee;
	}
	public void setPostFee(Integer postFee) {
		this.postFee = postFee;
	}
	public Integer getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(Integer paymentType) {
		this.paymentType = paymentType;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
	public List<OrderDetail> getOrderDetails() {
		return orderDetails;
	}
	public void setOrderDetails(List<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}
	@Override
	public String toString() {
		return "Order [orderId=" + orderId + ", totalPrice=" + totalPrice + ", actualPrice=" + actualPrice
				+ ", postFee=" + postFee + ", paymentType=" + paymentType + ", userId=" + userId + ", status=" + status
				+ ", createTime=" + createTime + ", orderDetails=" + orderDetails + "]";
	}
	
	
	
}
