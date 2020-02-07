$(function() {
	$('.btn-sidebar-menu-dropdown').on("click", function() {
      $('.cat-dropdown').slideToggle();
    });
	checkLogin();
});
function checkLogin(){
	  var token = $.cookie("token");
		if(!token){
			return ;
		}
		$.ajax({
			url : "http://localhost:9090/token/",
			data: {"token": token},
			//<script src="http://localhost:8090/token" type="text/javascript"></script>
			//<script>
			//function callback(){
			// http://localhost:8090/token
			//return map;
			//<callback,map>
			//}
			//</script>
			//
			dataType : "jsonp", //ajax跨域 支持GET/POST
			type : "POST",
			success : function(data){
				if(data.code == 1000){
					var username = data.data.username;
					var html = username + '<a href=\"http://localhost:9090/logout?token=' + token + '\">[退出]</a>';
					$('#registerbar').remove();
					$("#loginbar").html(html);
				}
			}
		});
}
