<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  	<base href="${pageContext.request.contextPath }/">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>hgshop后台管理系统</title>

<!-- Bootstrap core CSS -->
<link href="resource/css/bootstrap.css" rel="stylesheet" />
<link rel="stylesheet" href="resource/css/bootstrap-treeview.css" />
<script type="text/javascript" src="resource/jquery/jquery-3.4.1.js"></script>
<script type="text/javascript"
	src="resource/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="resource/bootstrap/js/bootstrap-treeview.js"></script>

<script type="text/javascript">
	$(function() {
		$('.main').css('height', window.screen.height);
		$.post('getAllCategories1', {}, function(data) {
			$('#tree').treeview({
				data : data,
				onNodeSelected : function(event, node) {
					$('iframe').prop('src', 'spuList?categoryId=' + node.id);
				}
			});
		});
	});
</script>
</head>

<body>

	<div class="container-fluid">
		<div class="row">
			<!-- 左边部分 -->
			<div class="col-md-3" id="tree"></div>
			<div class="col-md-9 main">
				<iframe width="100%" height="100%" name="mainFrame"
					src="" frameborder="0"></iframe>
			</div>
		</div>
	</div>



</body>
</html>