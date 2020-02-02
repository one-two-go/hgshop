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
		<title>分类管理</title>
		<link href="resource/css/bootstrap.css" rel="stylesheet">
		<link rel="stylesheet" href="resource/css/bootstrap-treeview.css" />
		<script type="text/javascript" src="resource/jquery/jquery-3.4.1.js"></script>
	  	<script type="text/javascript" src="resource/bootstrap/js/bootstrap.min.js"></script>
	  	<script type="text/javascript" src="resource/bootstrap/js/bootstrap-treeview.js" ></script>
		<script>
		function addCategory(){
			if($("#parentName").val()==''){
				$("#parentId").val(0);
			}
    		$.post('categoryAdd',$('#modalForm1').serialize(),function(data){
    			if(data){
    				$("#myModal").modal('hide');
    				window.location.reload();
    			}else{
    				alert('添加分类失败');
    			}
    		},'json');
    	}
    	function editCategory(){
    		if($("#parentName2").val()==''){
				$("#parentId2").val(0);
			}
    		$.post('categoryAdd',$('#modalForm2').serialize(),function(data){
    			if(data){
    				$("#myModal2").modal('hide');
    				window.location.reload();
    			}else{
    				alert('编辑分类失败');
    			}
    		},'json');
    	}
    	//修改模态框的数据回显和详情模态框的页面展示
    	function getCategoryById(id,flag){
    		$.post('getCategoryById',{id:id},function(data){
    			if(flag==1){
        			//修改模态框的数据回显
    				$('#id2').val(data.id);
        			$('#name2').val(data.text);
        			$('#parentId2').val(data.parentId);	
        			$('#parentName2').val(data.parentName);	
    			}else{
    				//详情模态框的页面展示
    				$('#name3').text(data.text);
        			$('#parentName3').text(data.parentName);	
    			}
    		},'json');
    	}
    	$(function(){
    		$("#parentName").click(function() {
    			$.post('getAllCategories', {}, function(data) {
    				var options = {
   						levels : 2,
   						data : data,
   						onNodeSelected : function(event, data) {
   							$("#parentId").val(data.id);
   							$("#parentName").val(data.text);
   							$("#tree").hide();//选中树节点后隐藏树
   						}
   					};
    				$('#tree').treeview(options);
					$('#tree').show();
    			});
			});
    		$("#parentName2").click(function() {
    			$.post('getAllCategories', {}, function(data) {
    				var options = {
   						levels : 2,
   						data : data,
   						onNodeSelected : function(event, data) {
   							$("#parentId2").val(data.id);
   							$("#parentName2").val(data.text);
   							$("#tree2").hide();//选中树节点后隐藏树
   						}
   					};
    				$('#tree2').treeview(options);
					$('#tree2').show();
    			});
			});
    	})
    	function deleteCategory(id){
   			if(confirm('确定要删除选中的数据吗?')){
   				$.post('categoryDelete',{id:id},function(data){
   	    			if(data.code==20010){
   	    				window.location.reload();
   	    			}else{
   	    				alert(data.code + "@" + data.msg);
   	    			}
   	    		},'json');
   			}
    	}
    </script>
	</head>

	<body>
		<div class="container-fluid">
			<div class="row">
				<form action="categoryList" method="post">
					<div class="form-group">
						<label for="name">分类名称</label>
						<input type="text" class="form-control" id="name" name="name" placeholder="分类名称" value="${category.name}">
					</div>
					<button type="submit" class="btn btn-success">搜索</button>
				</form>
			</div>
			<div class="row navbar-right">
				<button type="button" class="btn btn-primary btn-md" data-toggle="modal" data-target="#myModal">
				  新增分类
				</button>
			</div>
			<div class="row">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>编号</th>
							<th>分类名称</th>
							<th>父分类名称</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${pageInfo.list}" var="category" varStatus="index">
						<tr>
							<td>${index.count}</td>
							<td>${category.name}</td>
							<td>${category.parentName}</td>
							<td>
					          	<button class="btn btn-danger" onclick="deleteCategory(${category.id})">删除</button>
					          	<button type="button" class="btn btn-primary btn-md" data-toggle="modal" data-target="#myModal2" onclick="getCategoryById(${category.id},1);">修改</button>
								<button type="button" class="btn btn-info btn-md" data-toggle="modal" data-target="#myModal3" onclick="getCategoryById(${category.id},2);">查看</button>
					        </td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<nav>
				  <ul class="pagination">
				  	<c:if test="${pageInfo.hasPreviousPage}">
				    <li>
				      <a href="categoryList?pageNum=${pageInfo.pageNum-1}&name=${category.name}">
				        <span aria-hidden="true">上一页</span>
				      </a>
				    </li>
				    </c:if>
				    <!-- [1,2,3,4,5] -->
				    <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
				    	<c:if test="${pageInfo.pageNum==pageNum}">
				    	<li class="active"><a href="categoryList?pageNum=${pageNum}&name=${category.name}">${pageNum}</a></li>
				    	</c:if>
				    	<c:if test="${pageInfo.pageNum!=pageNum}">
				    	<li><a href="categoryList?pageNum=${pageNum}&name=${category.name}">${pageNum}</a></li>
				    	</c:if>
				    </c:forEach>
				    <c:if test="${pageInfo.hasNextPage}">
				    <li>
				      <a href="categoryList?pageNum=${pageInfo.pageNum+1}&name=${category.name}" aria-label="Next">
				        <span aria-hidden="true">下一页</span>
				      </a>
				    </li>
				    </c:if>
				  </ul>
				</nav>

			</div>
		</div>
		<!-- 新增分类 -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"  onclick="$('#tree').hide()"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title">新增分类</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" id="modalForm1" action="javascript:void(0);">
						  <div class="form-group">
						    <label for="name" class="col-sm-3 control-label">分类名称</label>
						    <div class="col-sm-9">
						      <input type="text" class="form-control" id="name" name="name" placeholder="分类名称">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="firstChar" class="col-sm-3 control-label">父分类名称</label>
						    <div class="col-sm-9">
						      <input type="hidden" class="form-control" id="parentId" name="parentId"> 
							  <input type="text" class="form-control" id="parentName" name="parentName" placeholder="选择父分类">
						      <div id="tree" style="display: none; position:absolute; z-index:1010; background-color:white;"></div>
						    </div>
						  </div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" onclick="$('#tree').hide()">关闭</button>
						<button type="button" class="btn btn-primary" onclick="addCategory()">添加</button>
					</div>
				</div>
			</div>
		</div>
		<!-- /.modal -->



		<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="$('#tree2').hide()"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title">编辑分类</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" id="modalForm2" action="javascript:void(0);">
						  <input type="hidden" id="id2" name="id">
						  <div class="form-group">
						    <label for="name" class="col-sm-3 control-label">分类名称</label>
						    <div class="col-sm-9">
						      <input type="text" class="form-control" id="name2" name="name" placeholder="分类名称">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="firstChar" class="col-sm-3 control-label">父分类名称</label>
						    <div class="col-sm-9">
						      <input type="hidden" class="form-control" id="parentId2" name="parentId"> 
							  <input type="text" class="form-control" id="parentName2" name="parentName" placeholder="选择父分类">
						      <div id="tree2" style="display: none; position:absolute; z-index:1010; background-color:white;"></div>
						    </div>
						  </div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" onclick="$('#tree2').hide()">关闭</button>
						<button type="button" class="btn btn-primary" onclick="editCategory()">编辑</button>
					</div>
				</div>
			</div>
		</div>
		<!-- /.modal -->
		
		<div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title">查看分类</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" id="modalForm3" action="javascript:void(0);">
						  <div class="form-group">
						    <label for="name" class="col-sm-3 control-label">分类名称</label>
						    <div class="col-sm-9">
						      <span id="name3"></span>
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="firstChar" class="col-sm-3 control-label">父分类名称</label>
						    <div class="col-sm-9">
						      <span id="parentName3"></span>
						    </div>
						  </div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>
		<!-- /.modal -->
	</body>

</html>