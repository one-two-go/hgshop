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
    <link href="resource/css/bootstrap.css" rel="stylesheet">
    <script type="text/javascript" src="resource/jquery/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="resource/bootstrap/js/bootstrap.min.js"></script>
    <script>
    	function preAddSpec(){
    		$('.add-option').remove();
    	}
    	var index=0; //【新增规格】时，规格选项递增的索引值
    	var index2=0; //【修改规格】时，规格选项递增的索引值
    	function addSpecOption(flag){
    		var obj1,obj2;
    		if(flag==1){
    			//新增模态框
    			obj1=$('#addForm');
    			obj2=index;
    		}else{
    			//修改模态框
    			obj1=$('#editForm');
    			obj2=index2;
    		}
    		
    		var str = '<div class="form-group add-option">'
    			+'<label class="col-sm-3 control-label">规格内容</label>'
    			+'<div class="col-sm-6">'
    			+'  <input type="text" class="form-control" name="options[' + obj2 + '].optionName"  placeholder="规格内容">'
    			+'</div>'
    			+'<div class="col-sm-3">'
    			+'<input type="button" class="btn-danger" value="删除" onclick="deleteOption(this)">'
    			+'</div>'
    			+'</div>';
    		obj1.append(str);
    		if(flag==1){
    			index++;
    		}else{
    			index2++;
    		}
    		
    		
    	}
    	function deleteOption(obj){
    		$(obj).parent().parent().remove();
    	}
    	function addSpec(flag){
			var obj1,obj2;
			if(flag==1){
				//新增
				obj1=$('#addForm');
				obj2=$('#myModal');
			}else{
				obj1=$('#editForm');
				obj2=$('#myModal2');
			}
    		$.post('specAdd',obj1.serialize(),function(data){
    			if(data){
    				obj2.modal('hide');
    				window.location.reload();
    			}else{
    				alert('操作规格失败!');
    			}
    		});
    	}
    	function getSpecById(id){
    		$('.add-option').remove();
    		$.post('getSpecById',{id:id},function(data){
    			$('#id2').val(data.id);
    			$('#specName2').val(data.specName);
    			for(var i in data.options){
    				var str = '<div class="form-group add-option">'
    	    			+'<label for="specName1" class="col-sm-3 control-label">规格内容</label>'
    	    			+'<div class="col-sm-6">'
    	    			+'  <input type="text" class="form-control" name="options[' + index2 + '].optionName" value="' + data.options[i].optionName + '"  placeholder="规格内容">'
    	    			+'</div>'
    	    			+'<div class="col-sm-3">'
    	    			+'<input type="button" class="btn-danger" value="删除" onclick="deleteOption(this)">'
    	    			+'</div>'
    	    			+'</div>';
    	    		$('#editForm').append(str);
    	    		index2++;
    			}
    		});	
    	}
    	function view(id){
    		$('.add-option').remove();
    		$.post('getSpecById',{id:id},function(data){
    			$('#specName3').text(data.specName);
    			for(var i in data.options){
    				var str = '<div class="form-group add-option">'
    	    			+'<label for="specName1" class="col-sm-3 control-label">规格内容</label>'
    	    			+'<div class="col-sm-9">'
    	    			+'<span>' + data.options[i].optionName + '</span>'
    	    			+'</div>'
    	    			+'</div>';
    	    		$('#viewForm').append(str);
    			}
    		});	
    	}
    	$(function(){
    		$('#cbk').on('click',function(){
    			$('.ck').prop('checked', this.checked);
    		});
    	})
    	function deleteSpec(ids){
    		if(ids==undefined){
    			//批量删除 [user1,user2,user3]  ----> [1,2,3]
    			ids = $('.ck:checked').map(function(){
    				return this.value;
    			}).get().join(',');
    		}
    		if(ids!=''){
    			if(confirm('确定要删除选中的数据吗?')){
    				$.post('specDelete',{ids:ids},function(data){
    	    			if(data){
    	    				window.location.reload();
    	    			}else{
    	    				alert('删除规格失败');
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
  			<form action="specList" method="post">
				  <div class="form-group">
				    <label for="specName">规格名称</label>
				    <input type="text" class="form-control" id="specName" name="specName" placeholder="规格名称" value="${spec.specName}">
				  </div>
				  <button class="btn btn-success" type="submit">搜索</button>
				</form>
  		</div>
  		
  		<div class="row" style="float: right;">
				  <button class="btn btn-danger" onclick="deleteSpec()">批量删除</button>
					<button type="button" class="btn btn-primary btn-md" data-toggle="modal" data-target="#myModal" onclick="preAddSpec()">
				  	新增规格
					</button>
  		</div>
  		
  		<div class="row">
  			<table class="table table-striped">
		      <thead>
		        <tr>
		        	<th><input type="checkbox" id="cbk">全选</th>
		          <th>编号</th>
		          <th>规格名称</th>
		          <th>规格选项</th>
		          <th>操作</th>
		        </tr>
		      </thead>
		      <tbody>
		      	<c:forEach items="${pageInfo.list}" var="spec" varStatus="index">
		        <tr>
		        	<td><input type="checkbox" class="ck" value="${spec.id}"/></td>
		          <td>${index.count }</td>
		          <td>${spec.specName }</td>
		          <td>
		          		${spec.optionNames}
		          </td>
		          <td>
		          	<button class="btn btn-danger" onclick="deleteSpec(${spec.id})">删除</button>
		          	<button type="button" class="btn btn-primary btn-md" data-toggle="modal" data-target="#myModal2" onclick="getSpecById(${spec.id})">
								  修改
								</button>
								<button type="button" class="btn btn-primary btn-md" data-toggle="modal" data-target="#myModal3" onclick="view(${spec.id})">
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
				      <a href="specList?pageNum=${pageInfo.prePage}&specName=${spec.specName}">
				        <span aria-hidden="true">上一页</span>
				      </a>
				    </li>
				    </c:if>
				    <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
				    	<c:if test="${pageInfo.pageNum==pageNum}">
				    	<li class="active"><a href="specList?pageNum=${pageNum}&specName=${spec.specName}">${pageNum}</a></li>
				    	</c:if>
				    	<c:if test="${pageInfo.pageNum!=pageNum}">
				    	<li><a href="specList?pageNum=${pageNum}&specName=${spec.specName}">${pageNum}</a></li>
				    	</c:if>
				    </c:forEach>
				    <c:if test="${pageInfo.hasNextPage}">
				    <li>
				      <a href="specList?pageNum=${pageInfo.nextPage}&specName=${spec.specName}" aria-label="Next">
				        <span aria-hidden="true">下一页</span>
				      </a>
				    </li>
				    </c:if>
				  </ul>
				</nav>
  		</div>
  	</div>
  
  
  		<!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="preAddSpec(1)"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">新增规格参数</h4>
		      </div>
		      <div class="modal-body">
		        <form class="form-horizontal" id="addForm" method="post">
						  <div class="form-group">
						    <label for="specName1" class="col-sm-3 control-label">规格名称</label>
						    <div class="col-sm-9">
						      <input type="text" class="form-control" id="specName1" name="specName" placeholder="规格名称">
						    </div>
						  </div>
						  <div class="form-group">
						    <div class="col-sm-3">
									<input type="button" class="btn btn-info" value="增加选项内容" id="addOption"
										onclick="addSpecOption(1)" />
								</div>
						  </div>
						</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="preAddSpec(1)">关闭</button>
		        <button type="button" class="btn btn-primary" onclick="addSpec(1)">添加</button>
		      </div>
		    </div>
		  </div>
		</div>


		<!-- Modal -->
		<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="preAddSpec(2)"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">编辑规格参数</h4>
		      </div>
		      <div class="modal-body">
		        <form class="form-horizontal" id="editForm">
		        	<input type="hidden" id="id2" name="id"/>
						  <div class="form-group">
						    <label for="specName2" class="col-sm-3 control-label">规格名称</label>
						    <div class="col-sm-9">
						      <input type="text" class="form-control" id="specName2" name="specName" placeholder="规格名称">
						    </div>
						  </div>
						  <div class="form-group">
						    <div class="col-sm-3">
									<input type="button" class="btn btn-info" value="增加选项内容" id="addOption"
										onclick="addSpecOption(2)" />
								</div>
						  </div>
						</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="preAddSpec(2)">关闭</button>
		        <button type="button" class="btn btn-primary" onclick="addSpec(2)">添加</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- Modal -->
		<div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="preAddSpec(2)"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">查看规格参数</h4>
		      </div>
		      <div class="modal-body">
		        <form class="form-horizontal" id="viewForm">
						  <div class="form-group">
						    <label for="specName3" class="col-sm-3 control-label">规格名称</label>
						    <div class="col-sm-9">
						      <span id="specName3"></span>
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
