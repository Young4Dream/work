 function btnOK(){
	 
	var txtHth = $("#txtTel").val();
	 if (txtHth == ''){
		 alert("请输入合同号！");
		 return;
	 }
	 
	 var txtOldpsword = $("#txtOld").val();
	 if (txtOldpsword == ''){
		 alert("原密码不能为空！");
		 return;
	 }
	 
	 var txtNewpsword = $("#txtNew").val();
	 if (txtNewpsword == ''){
		 alert("新密码不能为空！");
		 return;
	 }
	 
	 var txtNew2psword = $("#txtNew2").val();
	 if (txtNew2psword == ''){
		 alert("确认密码不能为空！");
		 return;
	 }
	 
	 if (txtNewpsword!=txtNew2psword){
		 alert("两次输入的密码不正确！");
		 return;
	 }
	 
	 $.ajax({   
		 /*${pageContext.request.contextPath}*/
			url:'../AccountLogin.action',
			data:{
				"hth":txtHth,
				"passwork":txtOldpsword,
			},
			type:'post',     
			dataType:'json',
			 cache:false,  // 异步     
			error:function(){     
					alert('连接数据库出现问题！');
			},     
					        
			success:function(data){
			   if (data == 'undefined'||data == null ||data == '' ){
				   alert("用户名或密码错误！！！");
					  return;
			   }  else{$(data).each(function(index) {
				   var indexs = data[index];
				   var hth = indexs.hth;
				   var mima = txtNewpsword;
				   alert(txtNewpsword);
				   $.ajax({     
						url:'../AccountPassword.action',
						data:{
							"hth":hth,
							"passwork":mima,
						},
						type:'post',     
						dataType:'json',
						 cache:false,  // 异步     
						error:function(){     
								alert('连接数据库出现问题！');     
						},     
								        
						success:function(data){
						   if (data == 'undefined'||data == null ||data == '' ){
							   alert("用户名或密码错误！！！");
								  return;
								  }
						   alert(data);
						}
						 });
			   }); 
			   }
			}
	        });
 }
 function checkDh(){
	 var dh=$('#txtUser').val();
	 var mima=$('#txtPassword').val();
	 $.ajax({
		 url:'../dhLogin.action',
		 type:'post',
		 cache:'false',
		 data:{'dh':dh,'mima':mima},
		 dataType:'json',
		 error:function(){alert('登录失败！');},
		 success:function(data){
			 
		 }
		 
	 });
 }