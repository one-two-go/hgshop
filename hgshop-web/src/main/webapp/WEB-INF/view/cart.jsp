<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>商城首页</title>
		<jsp:include page="common.jsp"></jsp:include>
	
		<script>
		$(function(){
			var total=0;
			var totalPrice=0;
			$('.ck').on('click',function(){
				var id=$(this).val();
				var pnum=$('#qty'+id).val();
				var subPrice=$('#sub-price'+id).text();
				
				total=parseInt($('#total').text());
				totalPrice=parseFloat($('#totalPrice').text());
				
				if(this.checked){
    				total += parseFloat(pnum);
    				totalPrice += parseFloat(subPrice);
				}else{
					total -= parseFloat(pnum);
    				totalPrice -= parseFloat(subPrice);
				}
				$('#total').text(total);
				$('#totalPrice').text(totalPrice);
			});
    		$('#cbk,#cbk1').on('click',function(){
    			total=0;
				totalPrice=0;
    			$('.ck').prop('checked', this.checked);
    			$('.ck').map(function(){
    				if(this.checked){
    					var id=$(this).val();
        				var pnum=$('#qty'+id).val();
        				var subPrice=$('#sub-price'+id).text();
        				total += parseFloat(pnum);
        				totalPrice += parseFloat(subPrice);	
    				}else{
    					total=0;
    					totalPrice=0;
    				}
    				$('#total').text(total);
    				$('#totalPrice').text(totalPrice);
    			});
    		});
    	})
    	function decrement(id){
			var qty = $("#qty"+id).val();
			var price = $('#price'+id).text();
			if(!isNaN(qty) && qty>1){
				qty--;
				$("#qty"+id).val(qty);
				var subPrice = parseFloat(price) * qty;
				$('#sub-price'+id).text(subPrice);
				if($('.ck[value="'+id+'"]')[0].checked){
					total=parseInt($('#total').text());
					totalPrice=parseFloat($('#totalPrice').text());
					total -= parseInt(1);
					totalPrice -= parseFloat(price);
					$('#total').text(total);
    				$('#totalPrice').text(totalPrice);
				}
				$.post('updateNum',{id:id,pnum:qty},function(){
				});
			}
		}
		function increment(id){
			var qty = $("#qty"+id).val();
			var price = parseFloat($('#price'+id).text());
			if(!isNaN(qty)){
				qty++;
			}
			$("#qty"+id).val(qty);
			var subPrice = price * qty;
			$('#sub-price'+id).text(subPrice);

			if($('.ck[value="'+id+'"]')[0].checked){
				total=parseInt($('#total').text());
				totalPrice=parseFloat($('#totalPrice').text());
				total += parseInt(1);
				totalPrice += parseFloat(price);
				$('#total').text(total);
   				$('#totalPrice').text(totalPrice);
			}
			$.post('updateNum',{id:id,pnum:qty},function(){
			});
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
    				$.post('deleteCartItems',{ids:ids},function(data){
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
    		window.location.href='preOrder?ids='+ids;
    	}
		</script>
	</head>

	<body>
		<div class="container-fluid">

		<jsp:include page="header.jsp"></jsp:include>	

		<div class="container-fluid" style="margin:5px 15px">
			<div class="row">
				<div class="col-md-12">
					<h2>购物车 ${total}</h2>
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
				<div class="col-md-2">￥<span class="price" id="price${cart.id}">${cart.price}</span></div>
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
				<div class="col-md-2">￥<span class="sub-price" id="sub-price${cart.id}">${cart.subPrice}</span></div>
				<div class="col-md-1"><a href="javascript:void(0)" onclick="deleteCart(${cart.id})">删除</a></div>
			</div>
			</c:forEach>
			
			
			<div class="row cart_list_footer">
				<div class="col-md-4">
					<span><input type="checkbox" id="cbk1">全选</span>
					<span><a href="javascript:void(0)" onclick="deleteCart()">删除选中商品</a></span>
					<span><a href="clearCart">清理购物车</a></span>
				</div>
				<div class="col-md-8">
					<span style="float:right" class="jiesuan"><a href="javascript:void(0)" class="submit-btn" onclick="preOrder()">去结算</a></span>
					<span style="float:right">总价: <span style="color:red">￥<span id="totalPrice">0</span></span></span>
					<span style="float:right">已选择<span style="color:red" id="total">0</span>件商品</span>
				</div>
			</div>
		</div>
	</div>	
			
	<jsp:include page="footer.jsp"></jsp:include>
			
	</body>

</html>