<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>结算</title>
		<jsp:include page="common.jsp"></jsp:include>
		<script>
			function createOrder(){
				$('#orderForm').submit();
			}
		</script>
	</head>

	<body>
		<div class="container-fluid">

		<jsp:include page="header.jsp"></jsp:include>			

		<div class="container-fluid" style="margin:5px 15px">
			<form id="orderForm" action="createOrder" method="post">
			<div class="row">
				<div class="col-md-12">
					<h5 style="margin-left:-15px">填写并核对订单信息</h5>
				</div>
			</div>
			<div class="row order_info">
				<div class="row">
					<div class="row" style="padding:5px 15px">
						<div class="col-md-3">收货人信息</div>
						<div class="col-md-3" style="float:right">新增收货地址</div>
					</div>
					<div class="row">
						<div class="col-md-offset-1 col-md-1">11 北京</div>
						<div class="col-md-4">11北京 门头沟 军庄镇 斋堂镇灵水村110号北京110平安客栈</div>
						<div class="col-md-1">130****2221</div>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="row" style="padding:5px 15px">
						<div class="col-md-3">支付方式</div>
					</div>
					<div class="row">
						<div class="col-md-offset-1 col-md-2">
							<input type="radio" class="paymentType" name="paymentType" value="1"/>货到付款
							<input type="radio" class="paymentType" style="margin-left:5px" name="paymentType" value="2" checked/>在线支付
						</div>
						<div class="col-md-1">更多>></div>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="row" style="padding:5px 15px">
						<div class="col-md-3">送货清单</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<div class="row" style="margin-top:5px">
								<div class="col-md-offset-1 col-md-3">配送方式</div>
							</div>
							<div class="row" style="margin-top:5px">
								<div class="col-md-offset-2 col-md-3" style="border:1px solid red">
									<div>快递运输</div>
								</div>
							</div>
							<div class="row" style="margin-top:5px">
								<div class="col-md-offset-1 col-md-8">配送时间： 预计12月26日24:00前送达</div>
							</div>
							<div class="row" style="margin:5px 10px">
								<hr>
							</div>
							<div class="row" style="margin:5px 10px">
								<div class="col-md-8"><input type="checkbox"/>退换无忧 <font color="red">￥3.60</font></div>
							</div>
							<div class="row" style="margin:5px 10px">
								<div class="col-md-8">
									7天内退货，15天内换货，预计获得9.8元运费赔付(到小金库)。<a href="#">查看详情</a>
								</div>
							</div>
							<div class="row" style="margin:5px 10px">
								<hr>
							</div>
						</div>
						<div class="col-md-8">
							<!--<div class="row">
								<div class="col-md-6">商家：南极人女装羽绒旗舰店</div>
							</div>-->
							<c:forEach items="${cartList}" var="cart" varStatus="index">
							<div class="row">
								<input type="hidden" name="orderDetails[${index.index}].skuId" value="${cart.skuId}"/>
								<div class="col-md-2">
									<input type="hidden" name="orderDetails[${index.index}].image" value="${cart.image}"/>
									<img src="pic/${cart.image}" width="100px" height="100px"/>
								</div>
								<div class="col-md-6" style="margin-left:-30px">
									<input type="hidden" name="orderDetails[${index.index}].title" value="${cart.title}"/>
									<div>${cart.title} x${cart.pnum} 有货</div>
								</div>
								<div class="col-md-2">
									<input type="hidden" name="orderDetails[${index.index}].price" value="${cart.price}"/>
									<font color="red">￥ ${cart.price}</font>
								</div>
								<div class="col-md-1">
									<input type="hidden" name="orderDetails[${index.index}].num" value="${cart.pnum}"/>
									x${cart.pnum} 
								</div>
								<div class="col-md-1">
									有货 
								</div>
							</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="row" style="padding:5px 15px">
						<div class="col-md-3">发票信息</div>
					</div>
					<div class="row">
						<div class="col-md-2" style="margin-left:50px">不开发票 <a href="#">修改</a></div>
					</div>
				</div>
				
				<div class="row" style="margin-bottom:10px">
					<div class="row">
						<div class="col-md-2" style="float:right">运费<font color="red">￥${postFee}</font></div>
					</div>
					<div class="row">
						<div class="col-md-2" style="float:right">总价<font color="red">￥${totalPrice}</font></div>
					</div>
				</div>
			</div>
			
			<input type="hidden" name="postFee" value="${postFee}"/>
			<input type="hidden" name="totalPrice" value="${totalPrice}"/>
			<input type="hidden" name="actualPrice" value="${actualPrice}"/>
			
			<div class="row cart_list_footer">
				<div class="col-md-offset-4 col-md-8">
					<span style="float:right" class="jiesuan"><a href="javascript:void(0)" onclick="createOrder()" class="order-submit-btn">提交订单</a></span>
					<span style="float:right">实际总价: <span style="color:red">￥${actualPrice}</span></span>
					<span style="float:right"><span style="color:red">${total}</span>件商品</span>
				</div>
			</div>
			
			</form>
		</div>
	</div>	
	
	<jsp:include page="footer.jsp"></jsp:include>
			
	</body>

</html>