 /*****************************************************************
 * name: addWaitAdjust.js
 * author: youhongyu
 * version: 1.0, 2011-1-22
 * description:  手工添加调级用户
 * modify:
 *****************************************************************/
 /**
 * 获取电话功能
 * @param 
 * @return 
 */
 function gethcdhgn(){
 	$("#hcdhgn_key").empty();
 	var urlstr=tsd.buildParams({ 
    							packgname:'service',//java包
						 		clsname:'ExecuteSql',//类名
						 		method:'exeSqlData',//方法名
						 		ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 		tsdcf:'mssql',//指向配置文件名称
						 		tsdoper:'query',//操作类型 
						 		datatype:'xmlattr',//返回数据格式 
						 		tsdpk:'dbsql_phone.queryhcdhgn'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 	});
 	var htmlinfo =  '<option value="">--请选择--</option>';
 	$.ajax({
				url:'mainServlet.html?'+urlstr,
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
					$(xml).find('row').each(function(){
							var hwjb= $(this).attr("hwjb");
							var sname	= $(this).attr("sname");
							htmlinfo+='<option value="'+sname+'">'+sname+'</option>';						
					});
				}
		});
		$("#hcdhgn_key").html($("#hcdhgn_key").html()+htmlinfo);
 }
 
  /**
 * 获取新业务
 * @param 
 * @return 
 */
 function getnewbusine(){
 	$("#dhnewbusines_key").empty();
 	var urlstr=tsd.buildParams({ 
    							packgname:'service',//java包
						 		clsname:'ExecuteSql',//类名
						 		method:'exeSqlData',//方法名
						 		ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 		tsdcf:'mssql',//指向配置文件名称
						 		tsdoper:'query',//操作类型 
						 		datatype:'xmlattr',//返回数据格式 
						 		tsdpk:'dbsql_phone.querynewbusine'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 	});
 	var htmlinfo = '<option value="">--请选择--</option>';
 	$.ajax({
				url:'mainServlet.html?'+urlstr,
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
					$(xml).find('row').each(function(){
							var dhgn= $(this).attr("dhgn");
							var feetype	= $(this).attr("feetype");
							var csnum	= $(this).attr("csnum");
							htmlinfo+='<option value="'+dhgn+'" flf="'+csnum+'">'+feetype+'</option>';						
					});
				}
		});
		$("#dhnewbusines_key").html($("#dhnewbusines_key").html()+htmlinfo);
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
		var urlstr=buildParamsPro('Dhgn_newbusiness','query');	 
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
 	var hcdhgn_key = $("#hcdhgn_key").val();
 	var dhnewbusines_key = $("#dhnewbusines_key option:selected").text();
 	var selecttype = $("#selecttype").val();
 	if(selecttype==""){alert("请选择添加类型");$("#selecttype").select();$("#selecttype").focus();return false;}
 	if(hcdhgn_key==""&&dhnewbusines_key==""){alert("请选择新增内容！");return false;}
 	var newbusinetype = $("#newbusinetype").val();
 	if(newbusinetype==""&&dhnewbusines_key!=""){alert("请选择办理类型！");$("#newbusinetype").select();$("#newbusinetype").focus();return false;}
 	var valuekey = $("#valuekey").val().replace(/(^\s*)|(\s*$)/g,"");
 	if(selecttype=="dh"){
 		if(valuekey==""){alert("电话号不能为空！");return false;}
 		params +="&Dh="+ valuekey;
 	}else if(selecttype=="hth"){
 		if(valuekey==""){alert("合同号不能为空！");return false;}
 		params +="&Hth="+ tsd.encodeURIComponent(valuekey);
 	}
 	var userid = $('#useridd').val();
 	var newbusinecsnum = $("#newbusinecsnum").val();
 	var newbusinecsnum_two = $("#newbusinecsnum_two").val();
 	var newbusinecsnum_three = $("#newbusinecsnum_three").val();
 	if(newbusinecsnum==""){
 		params +="&newcsnum=";
 	}else if(newbusinecsnum!=""&&newbusinecsnum_two==""&&newbusinecsnum_three==""){
 		params +="&newcsnum="+tsd.encodeURIComponent(newbusinecsnum);
 	}else if(newbusinecsnum!=""&&newbusinecsnum_two!=""&&newbusinecsnum_three==""){
 		params +="&newcsnum="+tsd.encodeURIComponent(newbusinecsnum+"~"+newbusinecsnum_two);
 	}else if(newbusinecsnum!=""&&newbusinecsnum_two!=""&&newbusinecsnum_three!=""){
 		params +="&newcsnum="+tsd.encodeURIComponent(newbusinecsnum+"~"+newbusinecsnum_two+"~"+newbusinecsnum_three);
 	}
 	params +="&OutPrivilege="+ tsd.encodeURIComponent(hcdhgn_key);
 	params +="&newywmc="+ tsd.encodeURIComponent(dhnewbusines_key);
 	params +="&ctltype="+ tsd.encodeURIComponent(newbusinetype);
 	
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
