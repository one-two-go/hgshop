<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  	<base href="${pageContext.request.contextPath }/">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>hgshop后台管理系统</title>

	<!-- Bootstrap core CSS -->
    <link href="resource/css/bootstrap.css" rel="stylesheet"/>
    <link rel="stylesheet" href="resource/css/bootstrap-treeview.css" />
    <script type="text/javascript" src="resource/jquery/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="resource/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="resource/bootstrap/js/bootstrap-treeview.js" ></script>
    
    <script>
    	$(function(){
    		$("#categoryName").click(function() {
    			$.post('getAllCategories1', {}, function(data) {
    				var options = {
   						levels : 2,
   						data : data,
   						onNodeSelected : function(event, data) {
   							$("#categoryId").val(data.id);
   							$("#categoryName").val(data.text);
   							$("#tree").hide();//选中树节点后隐藏树
   						}
   					};
    				$('#tree').treeview(options);
					$('#tree').show();
    			});
			});
    		$("#categoryName2").click(function() {
    			$.post('getAllCategories1', {}, function(data) {
    				var options = {
   						levels : 2,
   						data : data,
   						onNodeSelected : function(event, data) {
   							$("#categoryId2").val(data.id);
   							$("#categoryName2").val(data.text);
   							$("#tree2").hide();//选中树节点后隐藏树
   						}
   					};
    				$('#tree2').treeview(options);
					$('#tree2').show();
    			});
			});
    	});
    	//【新增商品】按钮或【修改】按钮点击时调用
    	function preAddSpu(){
			//获取品牌列表
    		$.post("getAllBrands", {},function(data) {
    			//遍历数据
    			$('#brandId').html("<option value=''>--请选择--</option>");
               	for(var i in data){
                    $('#brandId').append("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
                }
			},"json");
       }
    	function addSpu(flag){
    		var obj1,obj2;
    		if(!flag){
    			//添加
    			obj1=$('#modalForm')[0];
    			obj2=$('#myModal');
    		}else{
    			//修改
    			obj1=$('#modalForm2')[0];
    			obj2=$('#myModal2');
    		}
    		var formData = new FormData(obj1);
    		$.ajax({
                type:'post',
                data:formData,
                url:'spuAdd',
				processData : false, // 告诉jQuery不要去处理发送的数据
				contentType : false, // 告诉jQuery不要去设置Content-Type请求头
				dataType:'json',
				success:function(data){
                	if(data){
                		//关闭模态框
                        obj2.modal('hide');
                        window.location.reload();
                       }else{
                        alert("商品操作失败");
                       }
	 				 }
			   });
    	}
    	//在线预览图片
    	function show(obj,flag){
    		var obj1;
    		if(!flag){
    			obj1=$("#smallPic12");
    		}else{
    			obj1=$("#smallPic22");
    		}
    		var rd = new FileReader();//创建文件读取对象
            var files = obj.files[0];//获取file组件中的文件
            rd.readAsDataURL(files);//文件读取装换为base64类型
            rd.onloadend = function(e) {
                //加载完毕之后获取结果赋值给img
                obj1.prop('src', this.result);
                obj1.show();
            }
    	}
    	function getSpuById(id){
    		$.post("getAllBrands", {},function(data) {
    			//遍历数据
    			$('#brandId2').html("<option value=''>--请选择--</option>");
               	for(var i in data){
                    $('#brandId2').append("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
                }
			},"json");
    		
    		
    		$.post('getSpuById',{id:id},function(data){
    				$("#smallPic22").prop("src", "pic/" + data.smallPic);
        			$("#smallPic22").show();
        			$('#id2').val(data.id);
        			$('#smallPic20').val(data.smallPic);
        			$('#goodsName2').val(data.goodsName);
        			$('#caption2').val(data.caption);
        			$('#isMarketable2').val(data.isMarketable);
        			$('#brandId2').val(data.brandId);
        			$('#brandId2 option[value=' + data.brandId + ']').prop('selected',true);
        			$('#categoryId2').val(data.categoryId);
        			$('#categoryName2').val(data.cName);
    		},'json');
    	}
    	function viewById(id){
    		$.post('getSpuById',{id:id},function(data){
    			$("#smallPic32").prop("src", "pic/" + data.smallPic);
    			$("#smallPic32").show();
    			$('#goodsName3').text(data.goodsName);
    			$('#caption3').text(data.caption);
    			$('#isMarketable3').text(data.isMarketable==0 ? '上架' : '下架');
    			$('#brandName3').text(data.bName);
    			$('#categoryName3').text(data.cName);
    		},'json');
    	}
    	$(function(){
    		$('#cbk').on('click',function(){
    			$('.ck').prop('checked', this.checked);
    		});
    	})
    	function deleteSpu(ids){
    		if(!ids){
    			ids = $('.ck:checked').map(function(){
    				return this.value;
    			}).get().join(',');
    		}
    		if(ids!=''){
    			if(confirm('确定要删除选中的数据吗?')){
    				$.post('spuDelete',{ids:ids},function(data){
    	    			if(data){
    	    				window.location.reload();
    	    			}else{
    	    				alert('删除spu失败');
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
						<!-- 加入了列 填充整行 -->
						<form class="col-sm-12" action="spuList" method="post">
							<div class="form-group">
								<label>商品名称</label> 
								<input type="text" name="goodsName" class="form-control" placeholder="请输入品牌名称" value="${spu.goodsName}">
							</div>

							<div class="form-group">
								<label>商品副标题</label> 
								<input type="text" name="caption" class="form-control" placeholder="请输入商品副标题" value="${spu.caption}">
							</div>
							<!-- 隐藏分类的id值 -->
							<input type="hidden" id="cid" name="categoryId" value="${spu.categoryId}"/>
							<button class="btn btn-success" type="submit">搜索</button>
						</form>
					</div>

					<!-- 外边距(下方) 10像素的大小 -->
					<div class="row" style="margin-bottom: 10px;">
						<!-- 右端对齐 -->
						<div class="col-sm-12" align="right">
							<input type="button" class="btn btn-danger"
								onclick="deleteSpu()" value="批量删除" />
							<button class="btn btn-primary btn-sm" onclick="preAddSpu()"
								data-toggle="modal" data-target="#myModal">添加商品</button>
						</div>
					</div>


					<div class="row">
						<table class="table table-striped">
							<thead>
								<tr>
									<th scope="col"><input type="checkbox" id="cbk" />全选</th>
									<th scope="col">序号</th>
									<th scope="col">图标</th>
									<th scope="col">商品名称</th>
									<th scope="col">商品状态</th>
									<th scope="col">商品品牌</th>
									<th scope="col">商品分类</th>
									<th scope="col">操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${pageInfo.list}" var="spu" varStatus="index">
									<tr>
										<td scope="row">
											<input type="checkbox" class="ck" value="${spu.id}"/>
										</td>
										<td>${index.count}</td>
										<td class="col-sm-2">
											<img class="img-responsive" src="pic/${spu.smallPic}"/>
										</td>
										<td class="col-sm-2">${spu.goodsName}</td>
										<td>${spu.isMarketable==0 ? '上架' : '下架'}</td>
										<td>${spu.bName}</td>
										<td>${spu.cName}</td>
										<td>
											<a href="javascript:void(0)" onclick="deleteSpu(${spu.id})" class="btn btn-info">删除</a>
											<button class="btn btn-info btn-sm" data-toggle="modal"
												data-target="#myModal2"
												onclick="getSpuById(${spu.id})">修改</button>
											<button class="btn btn-primary btn-sm" data-toggle="modal"
												data-target="#myModal3"
												onclick="viewById(${spu.id})">详情</button></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						<nav>
				  <ul class="pagination">
				  	<c:if test="${pageInfo.hasPreviousPage}">
				    <li>
				      <a href="spuList?pageNum=${pageInfo.prePage}&goodsName=${spu.goodsName}&caption=${spu.caption}&categoryId=${spu.categoryId}">
				        <span aria-hidden="true">上一页</span>
				      </a>
				    </li>
				    </c:if>
				    <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
				    	<c:if test="${pageInfo.pageNum==pageNum}">
				    	<li class="active"><a href="spuList?pageNum=${pageNum}&goodsName=${spu.goodsName}&caption=${spu.caption}&categoryId=${spu.categoryId}">${pageNum}</a></li>
				    	</c:if>
				    	<c:if test="${pageInfo.pageNum!=pageNum}">
				    	<li><a href="spuList?pageNum=${pageNum}&goodsName=${spu.goodsName}&caption=${spu.caption}&categoryId=${spu.categoryId}">${pageNum}</a></li>
				    	</c:if>
				    </c:forEach>
				    <c:if test="${pageInfo.hasNextPage}">
				    <li>
				      <a href="spuList?pageNum=${pageInfo.nextPage}&goodsName=${spu.goodsName}&caption=${spu.caption}&categoryId=${spu.categoryId}" aria-label="Next">
				        <span aria-hidden="true">下一页</span>
				      </a>
				    </li>
				    </c:if>
				  </ul>
				</nav>
					</div>

	</div>


	<!-- ////////////////添加模态框 //////////////////////////////-->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">

		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<!-- 关闭的x效果 -->
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>

					<!-- 模态框的标题 -->
					<h4 class="modal-title" id="spuAddModalLabel">添加商品操作</h4>
				</div>
				<div class="modal-body">
					<form id="modalForm" enctype="multipart/form-data" action="javascript:void(0)">
						<div class="form-group row">
							<label for="goodsName"
								class="col-sm-3 col-form-label col-form-label-sm">商品名称</label>
							<div class="col-sm-9">
								<input type="text" class="form-control form-control-sm"
									id="goodsName" name="goodsName" placeholder="请输入商品名称">
							</div>
						</div>

						<div class="form-group row">
							<label for="caption" class="col-sm-3 col-form-label">商品副标题</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="caption"
									name="caption" placeholder="请输入商品的副标题">
							</div>
						</div>

						<div class="form-group row">
							<label for="isMarketable" class="col-sm-3 col-form-label">商品状态</label>
							<div class="col-sm-9">
								<select class="form-control" id="isMarketable" name="isMarketable">
									<option value="">请选择</option>
									<option value="0">上架</option>
									<option value="1">下架</option>
								</select>
							</div>
						</div>

						<div class="form-group row">
							<label for="brandId" class="col-sm-3 col-form-label">商品品牌</label>
							<div class="col-sm-9">
								<select class="form-control" id="brandId" name="brandId">
									<option value="">请选择品牌</option>
								</select>
							</div>
						</div>

						<div class="form-group row">
							<label for="categoryName" class="col-sm-3 col-form-label">商品分类</label>
							<!-- 左边部分 -->
							<div class="col-sm-9">
								<input type="hidden" class="form-control" id="categoryId" name="categoryId"> 
								<input type="text" class="form-control" id="categoryName" placeholder="选择商品分类">
								<div id="tree" style="display: none; position:absolute; z-index:1010; background-color:white; "></div>
							</div>
						</div>


						<div class="form-group row">
							<label for="smallPic1" class="col-sm-3 col-form-label">商品图标</label>
							<div class="col-sm-9">
								<input type="file" class="form-control" id="smallPic11"
									name="file" onchange="show(this)"/>
								<img id="smallPic12" alt="商品图标" style="display:none">
							</div>
						</div>


					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="addSpu()">添加</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- ///////////////////添加模态框结束//////////////////////////// -->

	<!-- ////////////////修改模态框 //////////////////////////////-->
	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">

		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<!-- 关闭的x效果 -->
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>

					<!-- 模态框的标题 -->
					<h4 class="modal-title">修改商品</h4>
				</div>
				<div class="modal-body">
					<form id="modalForm2" enctype="multipart/form-data" action="javascript:void(0)">
						<input type="hidden" name="id" id="id2"/>
						<input type="hidden" name="smallPic" id="smallPic20"/>
						<div class="form-group row">
							<label for="goodsName2"
								class="col-sm-3 col-form-label col-form-label-sm">商品名称</label>
							<div class="col-sm-9">
								<input type="text" class="form-control form-control-sm"
									id="goodsName2" name="goodsName" placeholder="请输入商品名称">
							</div>
						</div>

						<div class="form-group row">
							<label for="caption2" class="col-sm-3 col-form-label">商品副标题</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="caption2"
									name="caption" placeholder="请输入商品的副标题">
							</div>
						</div>

						<div class="form-group row">
							<label for="isMarketable2" class="col-sm-3 col-form-label">商品状态</label>
							<div class="col-sm-9">
								<select class="form-control" id="isMarketable2" name="isMarketable">
									<option value="">请选择</option>
									<option value="0">上架</option>
									<option value="1">下架</option>
								</select>
							</div>
						</div>

						<div class="form-group row">
							<label for="brandId2" class="col-sm-3 col-form-label">商品品牌</label>
							<div class="col-sm-9">
								<select class="form-control" id="brandId2" name="brandId">
									<option value="">请选择品牌</option>
								</select>
							</div>
						</div>

						<div class="form-group row">
							<label for="categoryName2" class="col-sm-3 col-form-label">商品分类</label>
							<!-- 左边部分 -->
							<div class="col-sm-9">
								<input type="hidden" class="form-control" id="categoryId2" name="categoryId"> 
								<input type="text" class="form-control" id="categoryName2" placeholder="选择商品分类">
								<div id="tree2" style="display: none; position:absolute; z-index:1010; background-color:white; "></div>
							</div>
						</div>


						<div class="form-group row">
							<label for="smallPic21" class="col-sm-3 col-form-label">商品图标</label>
							<div class="col-sm-9">
								<input type="file" class="form-control" id="smallPic21"
									name="file" onchange="show(this,2)"/>
								<img id="smallPic22" alt="商品图标" style="display:none;width:50%;height:50%">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="addSpu(2)">编辑</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- ///////////////////修改模态框结束//////////////////////////// -->
	
	<!-- ////////////////查看模态框 //////////////////////////////-->
	<div class="modal fade" id="myModal3" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">

		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<!-- 关闭的x效果 -->
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>

					<!-- 模态框的标题 -->
					<h4 class="modal-title">查看商品</h4>
				</div>
				<div class="modal-body">
					<form id="modalForm3" action="javascript:void(0)">
						<div class="form-group row">
							<label for="goodsName3"
								class="col-sm-3 col-form-label col-form-label-sm">商品名称</label>
							<div class="col-sm-9">
								<span id="goodsName3"></span>
							</div>
						</div>

						<div class="form-group row">
							<label for="caption3" class="col-sm-3 col-form-label">商品副标题</label>
							<div class="col-sm-9">
								<span id="caption3"></span>
							</div>
						</div>

						<div class="form-group row">
							<label for="isMarketable3" class="col-sm-3 col-form-label">商品状态</label>
							<div class="col-sm-9">
								<span id="isMarketable3"></span>
							</div>
						</div>

						<div class="form-group row">
							<label for="brandName3" class="col-sm-3 col-form-label">商品品牌</label>
							<div class="col-sm-9">
								<span id="brandName3"></span>
							</div>
						</div>

						<div class="form-group row">
							<label for="categoryName3" class="col-sm-3 col-form-label">商品分类</label>
							<!-- 左边部分 -->
							<div class="col-sm-9">
								<span id="categoryName3"></span>
							</div>
						</div>
						<div class="form-group row">
							<label for="smallPic32" class="col-sm-3 col-form-label">商品图标</label>
							<div class="col-sm-9">
								<img id="smallPic32" alt="商品图标">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- ///////////////////查看模态框结束//////////////////////////// -->
	
</body>
</html>