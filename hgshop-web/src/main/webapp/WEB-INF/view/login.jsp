<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>商城首页</title>
		<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />
		<link rel="stylesheet" href="css/custom.css" type="text/css" />
		<link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
		
		<script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="js/bootstrap.min.js" type="text/javascript"></script>
	
		<script src="js/custom.js"></script>
		<style>
body {
	margin-top: 20px;
	margin: 0 auto;
}

.carousel-inner .item img {
	width: 100%;
	height: 300px;
}

.container .row div {
	/* position:relative;
	   float:left; */
	
}

font {
	color: #666;
	font-size: 22px;
	font-weight: normal;
	padding-right: 17px;
}
</style>
	<script type="text/javascript">
		$(function(){
			redirectUrl = '${redirectUrl}';
		});
		function login(){
			$.post("/login", $("#loginForm").serialize(),function(data){
				if (data.code == 1000) {
					if (redirectUrl == '') {
						location.href = "http://localhost:9090";
					} else {
						location.href = redirectUrl;
					}
				} else {
					alert("登录失败:" + data.code + "&" + data.msg);
				}
			});
		}
	</script>
	</head>

	<body>
		<div class="container-fluid">

<div class="container">
		<div class="row">
			<div class="col-md-3">
				<a href="index.html"> 
					<img alt="Shopholic" src="img/logo.png">
				</a>
			</div>
		</div>
	</div>


	<div class="container-fluid"
		style="margin-top:15px;height: 460px; background:#FF2C4C  url('img/loginbg.jpg') no-repeat;">
		<div class="row">
			<div class="col-md-7">
				<!--<img src="./image/login.jpg" width="500" height="330" alt="会员登录" title="会员登录">-->
			</div>

			<div class="col-md-5">
				<div
					style="width: 440px; border: 1px solid #E7E7E7; padding: 20px 0 20px 30px; border-radius: 5px; margin-top: 60px; background: #fff;">
					<font>会员登录</font>USER LOGIN
					<div>&nbsp;</div>
					<form class="form-horizontal" method="post" action="javascript:void(0)" id="loginForm">
						<div class="form-group">
							<label for="username" class="col-sm-2 control-label">用户名</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" id="name" name="name"
									placeholder="请输入用户名">
							</div>
						</div>
						<div class="form-group">
							<label for="password" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-6">
								<input type="password" class="form-control" id="password" name="password"
									placeholder="请输入密码">
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<input type="button" width="100" value="登录" name="submit" onclick="login()"
									style="background: url('./img/login.gif') no-repeat scroll 0 0 rgba(0, 0, 0, 0); height: 35px; width: 100px; color: white;">
							</div>
						</div>
					</form>
				</div>
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
		Copyright &copy; 2019 八维1706E 版权所有
	</div>
</div>
			
	</body>

</html>