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
			function getSkuByOptionId(obj,id){
				$(obj).siblings().removeClass('active');
				$(obj).addClass('active');
				var optionIds = $('.listing li.active input').map(function(){
					return this.value;
    			}).get().join(',');
				window.location.href='page?optionIds='+optionIds;
			}
			function decrement(){
				var qty = $("#qty").val();
				if(!isNaN(qty) && qty>1){
					qty--;
				}
				$("#qty").val(qty);
			}
			function increment(){
				var qty = $("#qty").val();
				if(!isNaN(qty)){
					qty++;
				}
				$("#qty").val(qty);
			}
			function addCart(){
				var skuId = ${map.sku.id};
				var pnum = $('#qty').val();
				window.location.href='cartdb/addCart?skuId=' + skuId + '&pnum=' + pnum;
			}
		</script>
	</head>

	<body>
		
		<jsp:include page="header.jsp"></jsp:include>
		
		
		<div class="container-fluid" style="margin:15px 30px">
			<div class="row">
				<div class="col-md-5">
					
					<div class="fotorama" data-nav="thumbs"
						data-allowfullscreen="native">
						<a href="#"><img src="pic/${map.sku.image}" alt="Shopholic"></a>
						<a href="#"><img src="img/2.jpg" alt="Shopholic"></a>
						<a href="#"><img src="img/3.jpg" alt="Shopholic"></a>
						<a href="#"><img src="img/4.jpg" alt="Shopholic"></a>
						<a href="#"><img src="img/5.jpg" alt="Shopholic"></a>
						<a href="#"><img src="img/6.jpg" alt="Shopholic"></a>
						<a href="#"><img src="img/4.jpg" alt="Shopholic"></a>
						<a href="#"><img src="img/5.jpg" alt="Shopholic"></a>
						<a href="#"><img src="img/6.jpg" alt="Shopholic"></a>
					</div>
				</div>
				<div class="col-md-7">
					<div>
						<h1 class="product-item-title">${map.sku.title}</h1>
					</div>
					<div class="product-item-sellpoint">
						${map.sku.sellPoint}
					</div>
					<div class="price-box" style="margin-top:20px">
						<span class="price">${map.sku.price/100}</span>
						<del class="price old-price">${map.sku.marketPrice}</del>
					</div>
					<hr>
					<c:forEach items="${map.specs}" var="spec">
					<div class="row">
						<div class="col-md-3">
							<span>${spec.specName}</span>
						</div>
						<div class="col-md-9">
							<div class="select-size">
								<ul class="listing">
									<c:forEach items="${spec.options}" var="option">
									<li
									<c:forEach items="${map.sku.skuSpec}" var="skuSpec">
										<c:if test="${option.id==skuSpec.specOptionId}">class="active"</c:if>
									</c:forEach>
									onclick="getSkuByOptionId(this,${option.id})"
									>	<input type="hidden" value="${option.id}">
										<span>${option.optionName}</span>
										
									</li>
									</c:forEach>
									<!-- <li class="active"><span>酒红</span></li> -->
								</ul>
							</div>
						</div>
					</div>
					</c:forEach>
					
					<div class="row">
						<div class="col-md-3">
							<span>数量:</span>
						</div>
						<div class="col-md-9">
							<div class="custom-qty">
								<button
									onclick="decrement();"
									class="reduced items" type="button">
									<i class="fa fa-minus"></i>
								</button>
								<input type="text" class="input-text qty" title="Qty"
									value="1" maxlength="8" id="qty" name="qty">
								<button
									onclick="increment();"
									class="increase items" type="button">
									<i class="fa fa-plus"></i>
								</button>
							</div>
						</div>
					</div>
					<div class="row" style="margin-top:20px">
						<div class="bottom-detail cart-button">
							<ul>
								<li class="pro-cart-icon"><a href="javascript:void(0)"
									title="Add to Cart" class="btn btn-color" onclick="addCart();"><span>加入购物车</span>
									</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="row" style="margin-top:10px" data-example-id="togglable-tabs">
				<ul id="myTabs" class="nav nav-tabs" role="tablist">
				  <li role="presentation" class="active"><a style="color: #555;" href="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">商品介绍</a></li>
				  <li role="presentation"><a style="color: #555;" href="#profile" role="tab" id="profile-tab" data-toggle="tab" aria-controls="profile">规格包装</a></li>
				  <li role="presentation"><a style="color: #555;" href="#profile" role="tab" id="profile-tab" data-toggle="tab" aria-controls="profile">商品评价</a></li>
				</ul>
				<div id="myTabContent" class="tab-content">
				  <div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
					<p>Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua, retro synth master cleanse. Mustache cliche tempor, williamsburg carles vegan helvetica. Reprehenderit butcher retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui irure terry richardson ex squid. Aliquip placeat salvia cillum iphone. Seitan aliquip quis cardigan american apparel, butcher voluptate nisi qui.</p>
				  </div>
				  <div role="tabpanel" class="tab-pane fade" id="profile" aria-labelledby="profile-tab">
					<p>Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid. Exercitation +1 labore velit, blog sartorial PBR leggings next level wes anderson artisan four loko farm-to-table craft beer twee. Qui photo booth letterpress, commodo enim craft beer mlkshk aliquip jean shorts ullamco ad vinyl cillum PBR. Homo nostrud organic, assumenda labore aesthetic magna delectus mollit. Keytar helvetica VHS salvia yr, vero magna velit sapiente labore stumptown. Vegan fanny pack odio cillum wes anderson 8-bit, sustainable jean shorts beard ut DIY ethical culpa terry richardson biodiesel. Art party scenester stumptown, tumblr butcher vero sint qui sapiente accusamus tattooed echo park.</p>
				  </div>
				  <div role="tabpanel" class="tab-pane fade" id="dropdown1" aria-labelledby="dropdown1-tab">
					<p>Etsy mixtape wayfarers, ethical wes anderson tofu before they sold out mcsweeney's organic lomo retro fanny pack lo-fi farm-to-table readymade. Messenger bag gentrify pitchfork tattooed craft beer, iphone skateboard locavore carles etsy salvia banksy hoodie helvetica. DIY synth PBR banksy irony. Leggings gentrify squid 8-bit cred pitchfork. Williamsburg banh mi whatever gluten-free, carles pitchfork biodiesel fixie etsy retro mlkshk vice blog. Scenester cred you probably haven't heard of them, vinyl craft beer blog stumptown. Pitchfork sustainable tofu synth chambray yr.</p>
				  </div>
				  <div role="tabpanel" class="tab-pane fade" id="dropdown2" aria-labelledby="dropdown2-tab">
					<p>Trust fund seitan letterpress, keytar raw denim keffiyeh etsy art party before they sold out master cleanse gluten-free squid scenester freegan cosby sweater. Fanny pack portland seitan DIY, art party locavore wolf cliche high life echo park Austin. Cred vinyl keffiyeh DIY salvia PBR, banh mi before they sold out farm-to-table VHS viral locavore cosby sweater. Lomo wolf viral, mustache readymade thundercats keffiyeh craft beer marfa ethical. Wolf salvia freegan, sartorial keffiyeh echo park vegan.</p>
				  </div>
				</div>
			</div>
			
			<div style="text-align: center;margin-top: 30px;">
				<ul class="list-inline">
					<li><a href="info.html">关于我们</a></li>
					<li><a>联系我们</a></li>
					<li><a>招贤纳士</a></li>
					<li><a>法律声明</a></li>
					<li><a>友情链接</a></li>
					<li><a>支付方式</a></li>
					<li><a>配送方式</a></li>
					<li><a>服务声明</a></li>
					<li><a>广告声明</a></li>
				</ul>
			</div>
			<div style="text-align: center;margin-top: 5px;margin-bottom:20px;">
				Copyright &copy; 2019 八维 版权所有
			</div>
		</div>		
	</body>

</html>