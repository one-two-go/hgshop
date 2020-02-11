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

font {
	color: #3164af;
	font-size: 18px;
	font-weight: normal;
	padding: 0 10px;
}
</style>
	<script>
		function register(){
			$.ajax({
				url: "check",
				data: {"param":$("#username").val(),"type":1},
				success: function(data){
					if(!data){
						$.ajax({
							url: "check",
							data: {"param":$("#email").val(),"type":2},
							success: function(data){
								if(!data){
									$.ajax({
										url: "check",
										data: {"param":$("#telephone").val(),"type":3},
										success: function(data){
											if(!data){
												$.post("/register",$("#registerForm").serialize(), function(data){
													if(data){
														window.location.href="toLogin";
													} else {
														alert("注册失败");
													}
												});
											}else{
												alert("手机号已存在");
											}
										}	
									});
								}else{
									alert("邮箱已存在");
								}
							}
						});		
					}else{
						alert("用户名已存在");
					}
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
		style="width: 100%; background: url('image/regist_bg.jpg');">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8"
				style="background: #fff; padding: 40px 80px; margin: 30px; border: 7px solid #ccc;">
				<font>会员注册</font>USER REGISTER
				<form class="form-horizontal" style="margin-top: 5px;" id="registerForm" action="javascript:void(0)">
					<div class="form-group">
						<label for="username" class="col-sm-2 control-label">用户名</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="username" name="username"
								placeholder="请输入用户名">
							<span id="usernameInfo"></span>
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
						<label for="name" class="col-sm-2 control-label">昵称</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="name" name="name"
								placeholder="请输入昵称">
						</div>
					</div>
					<div class="form-group">
						<label for="email" class="col-sm-2 control-label">邮箱</label>
						<div class="col-sm-6">
							<input type="email" class="form-control" id="email" name="email"
								placeholder="请输入邮箱">
						</div>
					</div>
					<div class="form-group">
						<label for="telephone" class="col-sm-2 control-label">手机号</label>
						<div class="col-sm-6">
							<input type="tel" class="form-control" id="telephone" name="telephone"
								placeholder="请输入手机号">
						</div>
					</div>
					<div class="form-group">
						<label for="birthday" class="col-sm-2 control-label">生日</label>
						<div class="col-sm-6">
							<input type="date" class="form-control" id="birthday" name="birthday"
								placeholder="请输入生日">
						</div>
					</div>
					
					<div class="form-group opt">
						<label for="sex" class="col-sm-2 control-label">性别</label>
						<div class="col-sm-6">
							<label class="radio-inline"> 
							<input type="radio" id="sex1" name="sex" value="男">
								男
							</label> <label class="radio-inline"> 
							<input type="radio" id="sex2" name="sex" value="女">
								女
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="button" width="100" value="注册" name="submit" onclick="register()"
								style="height: 35px; width: 100px;">
						</div>
					</div>
				</form>
			</div>

			<div class="col-md-2"></div>

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