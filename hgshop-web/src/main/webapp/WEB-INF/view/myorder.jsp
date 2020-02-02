<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>我的订单</title>
		<jsp:include page="common.jsp"></jsp:include>
	</head>

	<body>
		<div class="container-fluid">
		<jsp:include page="header.jsp"></jsp:include>
		
		<div class="container-fluid" style="margin:5px 15px">
			<div class="row">
				<div class="col-md-12">
					<h5>我的订单</h5>
				</div>
			</div>
			<div class="row">
				<div class="col-md-offset-9 col-md-3">
					<form action="myorder" method="post">
						<div style="margin:5px">
							<input id="search" type="text" name="keyword" width="100%" class="form-control" placeholder="Search" value="${keyword1}">
						</div>
						<button class="search-btn" type="submit"></button>
					</form>
				</div>
			</div>
			<div class="row order_list_header">
				<div class="col-md-2">近三个月订单</div>
				<div class="col-md-4">订单详情</div>
				<div class="col-md-1">收货人</div>
				<div class="col-md-2">金额</div>
				<div class="col-md-2">全部状态</div>
				<div class="col-md-1">操作</div>
			</div>
			<c:forEach items="${map.items}" var="order">
			<div class="row order_list_body">
				<div class="order_list">
					<div class="col-md-2">${order.createTime}</div>
					<div class="col-md-2">订单号： ${order.orderId}</div>	
				</div>
				<c:forEach items="${order.orderDetails}" var="orderDetail">
				<div class="order_detail_list">
					<div class="col-md-6 order_detail">
						<div class="col-md-8" style="padding-left:0px">
							<div><img src="pic/${orderDetail.image}" width="50px" height="50px" style="float:left"/></div>
							<div class="p-name">${orderDetail.title}</div>
						</div>
						<div class="col-md-2"><span class="price">X${orderDetail.num}</span></div>
						<div class="col-md-2"><span class="price">卖了换钱</span></div>
					</div>
					<div class="col-md-1 order_detail">
						<div class="p-name">xxx</div>
					</div>
					<div class="col-md-2 order_detail">
						<div class="p-name">总额 ¥${order.actualPrice}</div>
					</div>
					<div class="col-md-2 order_detail">
						<div class="p-name">
							<span>已取消</span>
							<br/>
							<a>订单详情</a>
						</div>
					</div>
					<div class="col-md-1 order_detail">
						<div class="p-name"><a>立即购买</a></div>
					</div>
				</div>
				</c:forEach>
			</div>
			</c:forEach>
			
		</div>

	
	
	<!--分页 -->
	<div style="float:right;margin-right:30px;">
		<ul class="pagination" style="text-align: center; margin-top: 10px;">
			<!-- 上一页 -->
			<!-- 判断当前页是否是第一页 -->
			<li>
				<a href="productList?currentPage=${pageBean.currentPage-1}" aria-label="Previous">
					<span aria-hidden="true">上一页</span>
				</a>
			</li>
			<!-- 判断当前页 -->
			<li class="active"><a href="javascript:void(0);">1</a></li>
			<li><a href="productList?currentPage=2">2</a></li>			
			<!-- 判断当前页是否是最后一页 -->			
			<li>
				<a href="productList?currentPage=2" aria-label="Next"> 
					<span aria-hidden="true">下一页</span>
				</a>
			</li>
		</ul>
	</div>
	<!-- 分页结束 -->
			
	<jsp:include page="footer.jsp"></jsp:include>
	</div>
	</body>

</html>