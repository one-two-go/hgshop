<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<base href="${pageContext.request.contextPath}/"/>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>商城首页</title>
		<jsp:include page="common.jsp"></jsp:include>
	
		<script>
		$(function(){
			$(':checkbox').prop('checked', true);
			
			var total=0;
			var totalPrice=0;
			//每个购物项的复选框选中/不选中
			$('.ck').on('click',function(){
				var id=$(this).val();
				var pnum=$('#qty'+id).val();
				var subPrice=$('#h-sub-price'+id).val();
				
				total=parseInt($('#total').text());
				totalPrice=parseInt($('#h-totalPrice').val());
				
				if(this.checked){
					//如果该复选框处于勾选状态
    				total += parseInt(pnum);
    				totalPrice += parseInt(subPrice);
				}else{
					//如果该复选框处于未勾选状态
					total -= parseInt(pnum);
    				totalPrice -= parseInt(subPrice);
				}
				$('#total').text(total);
				$('#h-totalPrice').val(totalPrice);
				$('#totalPrice').text(totalPrice/100);
			});
			//全选/全不选
    		$('#cbk,#cbk1').on('click',function(){
    			total=0;
				totalPrice=0;
				//1.各个复选框选中/不选中
    			$('.ck,#cbk,#cbk1').prop('checked', this.checked);
				//2.遍历各个复选框
    			$('.ck').map(function(){
    				if(this.checked){
    				//2.1.如果该复选框处于选中状态
    					var id=$(this).val();
        				var pnum=$('#qty'+id).val();
        				var subPrice=$('#h-sub-price'+id).val();
        				total += parseInt(pnum);
        				totalPrice += parseInt(subPrice);	
    				}else{
    					//2.2.如果该复选框处于未选中状态
    					//total=0;
    					//totalPrice=0;
    				}
    				$('#total').text(total);
    				$('#h-totalPrice').val(totalPrice);
    				$('#totalPrice').text(totalPrice/100);
    			});
    		});
    	})
    	function decrement(id){
			var qty = $("#qty"+id).val();
			var price = $('#h-price'+id).val();
			if(!isNaN(qty) && qty>1){
				qty--;
				$("#qty"+id).val(qty);
				var subPrice = parseInt(price) * qty;
				$('#h-sub-price'+id).val(subPrice);
				$('#sub-price'+id).text(subPrice/100);
				if($('.ck[value="'+id+'"]')[0].checked){
					total=parseInt($('#total').text());
					totalPrice=parseInt($('#h-totalPrice').val());
					total -= parseInt(1);
					totalPrice -= parseInt(price);
					$('#total').text(total);
					$('#h-totalPrice').val(totalPrice);
    				$('#totalPrice').text(totalPrice/100);
				}
				$.post('cartdb/updateNum',{id:id,pnum:qty},function(){
				});
			}
		}
		function increment(id){
			var qty = $("#qty"+id).val();  //数量输入框的值
			var price = $('#h-price'+id).val(); //单价隐藏域的值
			if(!isNaN(qty)){
				qty++;
				$("#qty"+id).val(qty);//1.数量输入框的值累加
				var subPrice = parseInt(price) * qty;
				$('#h-sub-price'+id).val(subPrice); //2.小计隐藏域的值
				$('#sub-price'+id).text(subPrice/100); //2.小计显示的值
				//3.根据复选框是否勾选进行处理，如果勾选状态，累加商品总数/累加总价格
				if($('.ck[value="'+id+'"]')[0].checked){
					total=parseInt($('#total').text());  //获取总数
					totalPrice=parseInt($('#h-totalPrice').val()); //获取总价
					total += parseInt(1);  //总价+1
					totalPrice += parseInt(price); //总价+单价
					$('#total').text(total); //填充总数
					$('#h-totalPrice').val(totalPrice); //填充总价的隐藏域
	   				$('#totalPrice').text(totalPrice/100); //填充总价
				}
				$.post('cartdb/updateNum',{id:id,pnum:qty},function(){
				});
			}
		}
    	function deleteCart(ids){
    		if(ids==undefined){
    			//批量删除 [user1,user2,user3]  ----> [1,2,3]
    			ids = $('.ck:checked').map(function(){
    				return this.value;
    			}).get().join(',');
    		}
    		if(ids!=''){
    			if(confirm('确定要删除选中的数据吗?')){
    				$.post('cartdb/deleteCartItems',{ids:ids},function(data){
    					if(data){
    	    				window.location.reload();
    	    			}else{
    	    				alert('删除失败');
    	    			}
    	    		},'json');
    			}
    		}else{
    			alert('请选中要删除的数据');
    		}
    	}
    	function preOrder(){
    		var ids= $('.ck:checked').map(function(){
    			return this.value;
    		}).get().join();
    		window.location.href='order/preOrder?ids='+ids;
    	}
		</script>
	</head>

	<body>
		<div class="container-fluid">

		<jsp:include page="header.jsp"></jsp:include>	

		<div class="container-fluid" style="margin:5px 15px">
			<div class="row">
				<div class="col-md-12">
					<h2>购物车 ${total1}</h2>
				</div>
			</div>
			<div class="row cart_list_header">
				<div class="col-md-1"><input type="checkbox" id="cbk">全选</div>
				<div class="col-md-4">商品</div>
				<div class="col-md-2">单价</div>
				<div class="col-md-2">数量</div>
				<div class="col-md-2">小计</div>
				<div class="col-md-1">操作</div>
			</div>
			<c:forEach items="${cartList}" var="cart">
			<div class="row cart_list">
				<div class="col-md-1"><input type="checkbox" class="ck" value="${cart.id}"></div>
				<div class="col-md-4">
					<div><img src="pic/${cart.image}" width="80px" height="80px" style="float:left"/></div>
					<div><div class="p-name">${cart.title}</div></div>
				</div>
				<div class="col-md-2">￥
				<input type="hidden" id="h-price${cart.id}" value="${cart.price}">
				<span class="price" id="price${cart.id}">${cart.price/100}</span>
				</div>
				<div class="col-md-2">
					<div class="custom-qty">
						<button
							onclick="decrement(${cart.id});"
							class="reduced items" type="button">
							<i class="fa fa-minus"></i>
						</button>
						<input type="text" class="input-text qty" title="Qty"
							value="${cart.pnum}" maxlength="8" id="qty${cart.id}" name="qty">
						<button
							onclick="increment(${cart.id});"
							class="increase items" type="button">
							<i class="fa fa-plus"></i>
						</button>
					</div>
				</div>
				<div class="col-md-2">￥
				<input type="hidden" id="h-sub-price${cart.id}" value="${cart.subPrice}">
				<span class="sub-price" id="sub-price${cart.id}">${cart.subPrice/100}</span>
				</div>
				<div class="col-md-1"><a href="javascript:void(0)" onclick="deleteCart(${cart.id})">删除</a></div>
			</div>
			</c:forEach>
			
			
			<div class="row cart_list_footer">
				<div class="col-md-4">
					<span><input type="checkbox" id="cbk1">全选</span>
					<span><a href="javascript:void(0)" onclick="deleteCart()">删除选中商品</a></span>
					<span><a href="cartdb/clearCart">清理购物车</a></span>
				</div>
				<div class="col-md-8">
					<span style="float:right" class="jiesuan"><a href="javascript:void(0)" class="submit-btn" onclick="preOrder()">去结算</a></span>
					<span style="float:right">总价: <span style="color:red">￥
					<input type="hidden" id="h-totalPrice" value="${totalPrice}">
					<span id="totalPrice">${totalPrice/100}</span>
					</span></span>
					<span style="float:right">已选择<span style="color:red" id="total">${total }</span>件商品</span>
				</div>
			</div>
		</div>
	</div>	
			
	<jsp:include page="footer.jsp"></jsp:include>
			
	</body>

</html>