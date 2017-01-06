<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSON</title>
<script type="text/javascript" src="../js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	function getYhdang(){
		var hth='FH8899';
		 $.ajax({
			 url:'../NewFile.action',
			 type:'post',
			 cache:'false',
			 async:false,
			 data:{'hth':hth},
			 dataType:'json',
			 error:function(){alert('查询失败！');}, 
			 success:function(data){
				 var msg=data.msg;
				console.log(msg);
				 if (msg == 'undefined'||msg == null ||msg == '' ){
					   alert(msg);
					return;
				   }else{$(data).each(function(index) {
					   //var dataObj=eval("("+data.yhdangs+")");
					   var yhdang=data[index];
					   console.log(yhdang.dh+yhdang.mima);});
			 	};
				}
		 });
	}
</script>
</head>
<body>
<input type="submit" onclick="getYhdang()"/>
<div id="yhdangList"></div>
</body>
</html>