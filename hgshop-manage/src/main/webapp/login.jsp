<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>HgShop登录页</title>

    <!-- Bootstrap core CSS -->
    <link href="resource/css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="resource/css/signin.css" rel="stylesheet">
  
  	<script type="text/javascript" src="resource/jquery/jquery-3.4.1.js"></script>
  	<script type="text/javascript" src="resource/bootstrap/js/bootstrap.min.js"></script>
  
  	<script>
  		function login(){
  			//ajax
  			$.post('login',$('#loginForm').serialize(),function(result){
  				if(result.code==200){
  					window.location.href='index';
  				}else{
  					var str = '<div class="alert alert-warning alert-dismissible" role="alert">'
	  					+'<button type="button" class="close" data-dismiss="alert" aria-label="Close">'
	  					+'<span aria-hidden="true">&times;</span></button>'
	  					+'<strong>' + result.code + '::' + result.msg + '</strong></div>';
	  				
  					$('#loginForm').append(str);
  				}
  			},'json');
  		}
  		
  	</script>
  
  </head>

  <body>

    <div class="container">

      <form class="form-signin" action="javascript:void(0)" method="post" id="loginForm">
        <h2 class="form-signin-heading" style="text-align: center;">HgShop</h2>
        <div class="form-group">
        	<label for="username">用户名</label>
        	<input type="text" id="username" name="username" class="form-control" placeholder="请输入用户名" required autofocus>
       	</div>
       	<div class="form-group">
	       	<label for="password">密码</label>
	        <input type="password" id="password" name="password" class="form-control" placeholder="请输入密码" required>
        </div>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> 记住我
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" onclick="login();">登录</button>
      </form>

    </div>

  </body>
</html>
