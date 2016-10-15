 /*****************************************************************
 * name: addWaitAdjust.js
 * author: youhongyu
 * version: 1.0, 2011-1-22
 * description:  手工添加调级用户
 * modify:
 *****************************************************************/
 /**
 * 获取话务控制类型
 * @param 
 * @return 
 */
 function getServiceType(){
 	var urlstr=buildParamsPro('Hwjb_GetServiceType','query');
 	var htmlinfo = '';
 	$.ajax({
				url:'mainServlet.html?'+urlstr,
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
					$(xml).find('row').each(function(){
							var ServiceType= $(this).attr("servicetype");
							var reshwjb	= $(this).attr("reshwjb");
							htmlinfo+='<option value="'+reshwjb+'">'+ServiceType+'</option>';						
					});
				}
		});
		$("#servicetype_a").html($("#servicetype_a").html()+htmlinfo);
		$("#servicetype_b").html($("#servicetype_b").html()+htmlinfo);
 }
 /**
 *  打开保存面板
 * @param 
 * @return 
 */
function openadd(){
	 	markTable(0);//显示红色*号
	 	$(".top_03").html($("#addinfo").val());//标题		 	
	 	removeFieldDisabled(tablealiasName,prefix,suffixW);
		openpan();
		$("#save").show();
		clearText('operformT1');
}

/**
 * 添加操作 
 * @param 
 * @return 
 */
function addYH(){		
		//通过表单值构造数据操作参数
		var params=addBuildParams();		
		if(params==false){return false;}
		
		/***************************
		*    判断完成，进行保存操作   *
		***************************/	
		var urlstr=buildParamsPro('Hwjb_ManualAdd','query');	 
	 	$.ajax({
					url:'mainServlet.html?'+urlstr+params,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
						var res='';
						var resmessage ='';
						$(xml).find('row').each(function(){
								res= $(this).attr("res");
								resmessage= $(this).attr("resmessage");						
																		
						});
						// 提示成功或者失败
						alert(resmessage);
						$("#editgrid").trigger("reloadGrid");
						
						if(res==''){	
							setTimeout($.unblockUI, 0);//关闭面板							
							//写入日志操作						
							//transferApos()去掉字符串的'号，等特殊字符
							logwrite(1,transferApos($("#LogContentS").val()),'');
						}							
					}
		});			
}


/**
 * 根据业务参数的多少和属性进行修改
 * @param
 * @return
 */
function addBuildParams(){
 	//每次拼接参数必须初始化此参数
	tsd.QualifiedVal=true;				
 	var params='';
 	var logstr = '';//用于存放拼接写入日志的字符串
 	var servicetype_a = $("#servicetype_a").val();
 	if(servicetype_a==""){alert("请选择话务控制类型!");$("#servicetype_a").select();$("#servicetype_a").focus();return false;}
 	var selecttype = $("#selecttype").val();
 	if(selecttype==""){alert("请选择新增类型");$("#selecttype").select();$("#selecttype").focus();return false;}
 	var valuekey = $("#valuekey").val().replace(/(^\s*)|(\s*$)/g,"");
 	if(selecttype=="dh"){
 		params +="&Dh="+ valuekey;
 	}else if(selecttype=="hth"){
 		params +="&Hth="+ tsd.encodeURIComponent(valuekey);
 	}
 	var userid = $('#useridd').val();
 	params +="&hwjb="+ tsd.encodeURIComponent(servicetype_a);
 	//拼接惨数 	
 	params +="&UserID="+ tsd.encodeURIComponent(userid);
 	//拼接写入日志字符串
 	logstr +="userid: "+userid+"; ";
 	logstr += $("#dhg_a").text()+" : "+valuekey+"; ";
	//把要写入日志的字符串放入隐藏域
	$("#LogContentS").val(logstr);	
	//每次拼接参数必须添加此判断
	if(tsd.Qualified()==false){return false;}
	return params;
}



/**
 * 打开简单查询面板
 * @param
 * @return
 */
function openQuery(){	
		clearText("operformTQuery");//清空表格信息
	 	$(".top_03").html($("#queryinfo").val());//标题	 	
		autoBlockFormAndSetWH('QueryPan',60,5,'closeo',"#ffffff",false,1000,'');//弹出查询面板		
}

/**
 * 简单查询
 * @param
 * @return
 */
function QbuildParams(){
	
	tsd.QualifiedVal=true; 	//每次拼接参数必须初始化此参数
	var dh = $("#selectphone").val().replace(/(^\s*)|(\s*$)/g,"");
 	if(dh==""){alert("请输入电话号码!");$("#selectphone").select();$("#selectphone").focus();return;}
 	var paramsStr=' ( 1=1 ';	//查询字串  	
 	/*
 	var starttime_b = $("#starttime_b").val();
 	var endtiem_b = $("#endtiem_b").val();
 	var servicetype_b = $("#servicetype_b").val();
	if(starttime_b != ''){
 		paramsStr += " and Adjust_Time >= to_date(\'"+starttime_b+"\',\'YYYY-MM-DD HH24:MI:SS\')";
 	}
 	if(endtiem_b != ''){
 		paramsStr +=" and Adjust_Time<= to_date(\'"+endtiem_b+"\',\'YYYY-MM-DD HH24:MI:SS\')";
 	}
 	if(servicetype_b!=''){
 		paramsStr +=" and ServiceType ='"+servicetype_b+"' ";
 	}
 	*/
 	paramsStr +=" and dh ='"+dh+"' ";
 	paramsStr +=")";
	//每次拼接参数必须添加此判断
	if(tsd.Qualified()==false){return false;}
 	$("#fusearchsql").val(paramsStr);
 	fuheQuery();	
}
