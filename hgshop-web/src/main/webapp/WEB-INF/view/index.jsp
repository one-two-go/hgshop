<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>商城首页</title>
		<jsp:include page="common.jsp"></jsp:include>
	</head>

	<body>
		<div class="container-fluid">

		<jsp:include page="header.jsp"></jsp:include>

		<!-- 轮播图 -->
			<div class="container-fluid">
				<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
					<!-- 轮播图的中的小点 -->
					<ol class="carousel-indicators">
						<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
						<li data-target="#carousel-example-generic" data-slide-to="1"></li>
						<li data-target="#carousel-example-generic" data-slide-to="2"></li>
					</ol>
					<!-- 轮播图的轮播图片 -->
					<div class="carousel-inner" role="listbox">
						<div class="item active">
							<img src="img/banner1.jpg">
							<div class="carousel-caption">
								<!-- 轮播图上的文字 -->
							</div>
						</div>
						<div class="item">
							<img src="img/banner2.jpg">
							<div class="carousel-caption">
								<!-- 轮播图上的文字 -->
							</div>
						</div>
						<div class="item">
							<img src="img/banner3.jpg">
							<div class="carousel-caption">
								<!-- 轮播图上的文字 -->
							</div>
						</div>
					</div>

					<!-- 上一张 下一张按钮 -->
					<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
						<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a>
					<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
						<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
			</div>
			
			<!-- 最新商品 -->
			<div class="container-fluid" style="margin-bottom:50px">
				<div class="col-md-12">
					<h2>最新商品</h2>
				</div>
				<div class="col-md-12">
					<c:forEach items="${newSkus}" var="sku">
					<div class="col-md-2" style="text-align:center;height:250px;padding:2px;">
						<a href="page.html">
							<img src="pic/${sku.image}" width="100%" height="80%">
						</a>
						<p><font color="#E4393C" style="font-size:16px">${sku.price/100 }</font></p>
						<p><a href="page.html" style='color:#666'></a>${fn:substring(sku.title,0,20)}</p>
					</div>
					</c:forEach>
				</div>
			</div>
			
	
		<jsp:include page="footer.jsp"></jsp:include>
		</div>
	</body>

</html>