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
    <title>品牌管理</title>

	<!-- Bootstrap core CSS -->
    <link href="resource/css/bootstrap.css" rel="stylesheet">
    <script type="text/javascript" src="resource/jquery/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="resource/bootstrap/js/bootstrap.min.js"></script>
    
    <script>
    	function addBrand(){
    		$.post('brandAdd',$('#modalForm1').serialize(),function(data){
    			if(data){
    				$("#myModal").modal('hide');
    				window.location.reload();
    			}else{
    				alert('添加品牌失败');
    			}
    		},'json');
    	}
    	function editBrand(){
    		$.post('brandAdd',$('#modalForm2').serialize(),function(data){
    			if(data){
    				$("#myModal2").modal('hide');
    				window.location.reload();
    			}else{
    				alert('编辑品牌失败');
    			}
    		},'json');
    	}
    	//修改模态框的数据回显和详情模态框的页面展示
    	function getBrandById(id,flag){
    		$.post('getBrandById',{id:id},function(data){
    			if(flag==1){
        			//修改模态框的数据回显
    				$('#id2').val(data.id);
        			$('#name2').val(data.name);
        			$('#firstChar2').val(data.firstChar);	
    			}else{
    				//详情模态框的页面展示
    				$('#name3').text(data.name);
        			$('#firstChar3').text(data.firstChar);	
    			}
    		},'json');
    	}
    	$(function(){
    		$('#cbk').on('click',function(){
    			$('.ck').prop('checked', this.checked);
    		});
    	})
    	function deleteBrand(ids){
    		if(ids==undefined){
    			//批量删除 [user1,user2,user3]  ----> [1,2,3]
    			ids = $('.ck:checked').map(function(){
    				return this.value;
    			}).get().join(',');
    		}
    		if(ids!=''){
    			if(confirm('确定要删除选中的数据吗?')){
    				$.post('brandDelete',{ids:ids},function(data){
    	    			if(data){
    	    				window.location.reload();
    	    			}else{
    	    				alert('删除品牌失败');
    	    			}
    	    		},'json');
    			}
    		}else{
    			alert('请选中要删除的数据');
    		}
    	}
    </script>
    
  </head>
  
  <body>
  	<div class="container-fluid">
  		<div class="row">
  			<form action="brandList" method="post">
				  <div class="form-group">
				    <label for="name">品牌名称</label>
				    <input type="text" class="form-control" id="name" name="name" placeholder="品牌名称" value="${brand.name }">
				  </div>
				  <div class="form-group">
				    <label for="firstChar">品牌首字母</label>
				    <input type="text" class="form-control" id="firstChar" name="firstChar" placeholder="品牌首字母" value="${brand.firstChar }">
				  </div>
				  <button class="btn btn-success" type="submit">搜索</button>
				</form>
  		</div>
  		
  		<div class="row" style="float: right;">
				<button class="btn btn-danger" onclick="deleteBrand()">批量删除</button>
				<button type="button" class="btn btn-primary btn-md" data-toggle="modal" data-target="#myModal">
				  新增品牌
				</button>
  		</div>
  		
  		<div class="row">
  			<table class="table table-striped">
		      <thead>
		        <tr>
		        	<th><input type="checkbox" id="cbk">全选</th>
		          <th>编号</th>
		          <th>品牌名称</th>
		          <th>首字母</th>
		          <th>状态</th>
		          <th>操作</th>
		        </tr>
		      </thead>
		      <tbody>
		      	<c:forEach items="${pageInfo.list}" var="brand" varStatus="index">
		        <tr>
		        	<td><input type="checkbox" class="ck" value="${brand.id}"/></td>
		          <td>${index.count}</td>
		          <td>${brand.name}</td>
		          <td>${brand.firstChar}</td>
		          <td>${brand.deletedFlag==0 ? '正常' : '删除'}</td>
		          <td>
		          	<button class="btn btn-danger" onclick="deleteBrand(${brand.id})">删除</button>
		          	<button type="button" class="btn btn-primary btn-md" data-toggle="modal" data-target="#myModal2" onclick="getBrandById(${brand.id},1);">
								  修改
								</button>
								<button type="button" class="btn btn-info btn-md" data-toggle="modal" data-target="#myModal3" onclick="getBrandById(${brand.id},2);">
								  查看
								</button>
		          </td>
		        </tr>
		        </c:forEach>
		      </tbody>
		    </table>
		    
		    <nav>
				  <ul class="pagination">
				  	<c:if test="${pageInfo.hasPreviousPage}">
				    <li>
				      <a href="brandList?pageNum=${pageInfo.prePage}&name=${brand.name}&firstChar=${brand.firstChar}">
				        <span aria-hidden="true">上一页</span>
				      </a>
				    </li>
				    </c:if>
				    <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
				    	<c:if test="${pageInfo.pageNum==pageNum}">
				    	<li class="active"><a href="brandList?pageNum=${pageNum}&name=${brand.name}&firstChar=${brand.firstChar}">${pageNum}</a></li>
				    	</c:if>
				    	<c:if test="${pageInfo.pageNum!=pageNum}">
				    	<li><a href="brandList?pageNum=${pageNum}&name=${brand.name}&firstChar=${brand.firstChar}">${pageNum}</a></li>
				    	</c:if>
				    </c:forEach>
				    <c:if test="${pageInfo.hasNextPage}">
				    <li>
				      <a href="brandList?pageNum=${pageInfo.nextPage}&name=${brand.name}&firstChar=${brand.firstChar}" aria-label="Next">
				        <span aria-hidden="true">下一页</span>
				      </a>
				    </li>
				    </c:if>
				  </ul>
				</nav>
  		</div>
  	</div>
  
  
  	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title">新增品牌</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" id="modalForm1" action="javascript:void(0);">
						  <div class="form-group">
						    <label for="name" class="col-sm-3 control-label">品牌名称</label>
						    <div class="col-sm-9">
						      <input type="text" class="form-control" id="name" name="name"  placeholder="品牌名称">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="firstChar" class="col-sm-3 control-label">品牌首字母</label>
						    <div class="col-sm-9">
						      <input type="text" class="form-control" id="firstChar" name="firstChar" placeholder="品牌首字母">
						    </div>
						  </div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" onclick="addBrand()">添加</button>
					</div>
				</div>
			</div>
		</div>
		<!-- /.modal -->



		<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title">编辑品牌</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" id="modalForm2" action="javascript:void(0);">
							<input type="hidden" id="id2" name="id">
						  <div class="form-group">
						    <label for="name" class="col-sm-3 control-label">品牌名称</label>
						    <div class="col-sm-9">
						      <input type="text" class="form-control" id="name2" name="name" placeholder="品牌名称">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="firstChar" class="col-sm-3 control-label">品牌首字母</label>
						    <div class="col-sm-9">
						      <input type="text" class="form-control" id="firstChar2" name="firstChar" placeholder="品牌首字母">
						    </div>
						  </div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" onclick="editBrand()">编辑</button>
					</div>
				</div>
			</div>
		</div>


	<div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title">查看品牌</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" id="modalForm3" action="javascript:void(0);">
						  <div class="form-group">
						    <label for="name" class="col-sm-3 control-label">品牌名称</label>
						    <div class="col-sm-9">
						    	<span id="name3"></span>
						    </div>
						  </div>
						  <div class="form-group">
						  	<label for="firstChar" class="col-sm-3 control-label">品牌首字母</label>
						    <div class="col-sm-9">
						    	<span id="firstChar3"></span>
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
  </body>
</html>
