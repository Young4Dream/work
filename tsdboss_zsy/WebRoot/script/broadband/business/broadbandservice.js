/*----------------------------------------
	name: WebRoot/script/broadband/business/broadbandservice.js
	author: wangli
	version: 1.0 
	description: 宽带业务专用js脚本 
	Date: 2011-08-31
---------------------------------------------*/
//查询部门
function querykeysBm(){
	var key='';
	var sBM='';
	var code='';
	var bmtypekey = $("#bmtypekey").val();
	var querykeybm = $("#querykeybm").val();
	var selectsbmkey = $("#selectsbmkey").val();
	selectsbmkey=selectsbmkey.replace(/(^\s*)|(\s*$)/g,"");	
	if(selectsbmkey==""){alert("请输入查询条件！");return false;}
	//通过部门名称查询
	if(querykeybm=="1"){
		if(bmtypekey=="Bm1"){
			key="dbsql_phone.querysBm_keysbm";
		}else if(bmtypekey=="Bm2"){
			key="dbsql_phone.querysBm_codekey";
			code=$("#sBm1code").val();
		}else if(bmtypekey=="Bm3"){
			key="dbsql_phone.querysBm_codekey";
			code=$("#sBm2code").val();
		}else if(bmtypekey=="Bm3"){
			key="dbsql_phone.querysBm_codekey";
			code=$("#sBm2code").val();
		}
	//通过索引键查询	
	}else if(querykeybm=="2"){        		
		if(bmtypekey=="Bm1"){
			key="dbsql_phone.querysBm_keysbmname";
		}else if(bmtypekey=="Bm2"){
			key="dbsql_phone.querysBm_codenamekey";
			code=$("#sBm1code").val();
		}else if(bmtypekey=="Bm3"){
			key="dbsql_phone.querysBm_codenamekey";
			code=$("#sBm2code").val();
		}else if(bmtypekey=="Bm3"){
			key="dbsql_phone.querysBm_codenamekey";
			code=$("#sBm2code").val();
		}
	}
	$("#querybmcontext").empty();
	var res = fetchMultiArrayValue(key,6,"&key="+tsd.encodeURIComponent(selectsbmkey)+"&code="+code);
	if(res[0]==undefined || res[0][0]==undefined)
	{
		$("#querybmcontext").append("<tr><td>没有信息！！！</td></tr>");
		$("#sbmname").val("");
		return false;
	}
	for(var i=0;i<res.length;i++){
		sBM += "<tr onClick=\"getbmname('"+res[i][1]+"');getbmcode('"+res[i][0]+"');\" id=\""+res[i][0]+"\"><td><center>";
		sBM += res[i][1];
		sBM += "</center></td></tr>";
	}
	$("#querybmcontext").append(sBM);
	$("#sbmname").val("");
}	
/****
*得到部门库中的第一级部门
****/
function yijisBmhth(){        
    var sBM="";            
    if($("#usertype option:selected").text()!="办公用户"){
				alert("只有公费用户可以选择一级部门！");
				$("#sBm1").val("");
				$("#sBm2").val("");
				$("#sBm3").val("");
				$("#sBm4").val("");
				return false;
	}
    $("#querysBmtitle").text("选择一级部门");
    $("#bmtypekey").val("Bm1");
    autoBlockForm('querysBm',5,'close',"#ffffff",false);//弹出查询框	     	
	$("#querybmcontext").empty();
	var res = fetchMultiArrayValue("dbsql_phone.querysBm",6,"");	
	if(res[0]==undefined || res[0][0]==undefined)
	{
		$("#querybmcontext").append("<tr><td>没有信息！！！</td></tr>");
		$("#sbmname").val("");
		return false;
	}
	for(var i=0;i<res.length;i++){
		sBM += "<tr onClick=\"getbmname('"+res[i][1]+"');getbmcode('"+res[i][0]+"');\" id=\""+res[i][0]+"\"><td><center>";
		sBM += res[i][1];
		sBM += "</center></td></tr>";
	}
	$("#querybmcontext").append(sBM);
	$("#sbmname").val("");
}	
/****
*得到部门库中的第二级部门
****/
function addsBmerhth()
{                  	
   sBM="";
   if($("#sBm1").val()==""){alert("请选择一级部门");return false;}
   $("#hth").val("");
   $("#Hth_hthdang").val("");
   $("#Hth_yhdang").val("");
   $("#querysBmtitle").text("选择二级部门");           
   autoBlockForm('querysBm',5,'close',"#ffffff",false);//弹出查询框          	       
   $("#bmtypekey").val("Bm2");	
   $("#querybmcontext").empty();
	var res = fetchMultiArrayValue("dbsql_phone.querysBm_code",6,"&code="+$("#sBm1code").val());
	if(res[0]==undefined || res[0][0]==undefined)
	{
		$("#querybmcontext").append("<tr><td>没有信息！！！</td></tr>");
		$("#sBm1code").val("");
		$("#sbmname").val("");
		return false;
	}	
	$("#hth").val("");
    $("#Hth_hthdang").val("");
    $("#Hth_yhdang").val("");					
	for(var i=0;i<res.length;i++){
		sBM += "<tr onClick=\"getbmname('"+res[i][1]+"');getbmcode('"+res[i][0]+"');\" id=\""+res[i][0]+"\"><td><center>";
		sBM += res[i][1];
		sBM += "</center></td></tr>";
	}
	$("#querybmcontext").append(sBM);
	$("#querybmcontext tr").css("line-height","25px");
	$("#sbmname").val("");
}	
 
/****
*得到部门库中的第三级部门
****/
function addsBmsanhth(){
  var sBM='';
  if($("#sBm2").val()==""){alert("请选择二级部门");return false;}
  $("#querysBmtitle").text("选择三级部门");
  autoBlockForm('querysBm',5,'close',"#ffffff",false);//弹出查询框	      
  $("#bmtypekey").val("Bm3");
  $("#querybmcontext").empty();
  var res = fetchMultiArrayValue("dbsql_phone.querysBm_code",6,"&code="+$("#sBm2code").val());
	if(res[0]==undefined || res[0][0]==undefined)
	{
		$("#querybmcontext").append("<tr><td>没有信息！！！</td></tr>");
		$("#sBm2code").val("");
		$("#sbmname").val("");
		return false;
	}	
	$("#hth").val("");
    $("#Hth_hthdang").val("");
    $("#Hth_yhdang").val("");		
	for(var i=0;i<res.length;i++){
		sBM += "<tr onClick=\"getbmname('"+res[i][1]+"');getbmcode('"+res[i][0]+"');\" id=\""+res[i][0]+"\"><td><center>";
		sBM += res[i][1];
		sBM += "</center></td></tr>";
	}
	$("#querybmcontext").append(sBM);
	$("#querybmcontext tr").css("line-height","25");
	$("#sbmname").val("");
}	 

/****
*得到部门库中的第四级部门
****/
function addsBmsihth(){          
  var sBM='';
  if($("#sBm3").val()==""){alert("请选择三级部门");return false;}
  $("#querysBmtitle").text("选择四级部门");	
  autoBlockForm('querysBm',5,'close',"#ffffff",false);//弹出查询框      
  $("#bmtypekey").val("Bm4");
  $("#querybmcontext").empty();
  var res = fetchMultiArrayValue("dbsql_phone.querysBm_code",6,"&code="+$("#sBm3code").val());
	if(res[0]==undefined || res[0][0]==undefined)
	{
		$("#querybmcontext").append("<tr><td>没有信息！！！</td></tr>");
		$("#sBm3code").val("");
		$("#sbmname").val("");
		return false;
	}	
	$("#hth").val("");
    $("#Hth_hthdang").val("");
    $("#Hth_yhdang").val("");		
	for(var i=0;i<res.length;i++){
		sBM += "<tr onClick=\"getbmname('"+res[i][1]+"');getbmcode('"+res[i][0]+"');\" id=\""+res[i][0]+"\"><td><center>";
		sBM += res[i][1];
		sBM += "</center></td></tr>";
	}
	$("#querybmcontext").append(sBM);
	$("#querybmcontext").css("line-height","25px");
	$("#sbmname").val("");
}	
/********
	*弹出部门选择面板 点击信息时调用该方法
*@param：key 合同号值;
	*@return;
*********/
function getbmname(keyname){
      $("#sbmname").val(keyname);//把得到的部门添加到隐藏域中点击确定的时候在从隐藏域中取		      		            
}
function getbmcode(keycode){
	if(keycode!=""&&keycode!=undefined){
      	$("#sbmcode").val(keycode);//把得到的部门添加到隐藏域中点击确定的时候在从隐藏域中取
      }else{
      	$("#sbmcode").val("");//把得到的部门添加到隐藏域中点击确定的时候在从隐藏域中取
      }
      $("#querybmcontext tr").css('background-color','#ffffff');
      document.getElementById(keycode).style.background='#0080FF';  
}

//点击保存部门按钮
function savesBm(){
	var sbmname = $("#sbmname").val();
	var sbmtypekey = $("#bmtypekey").val();
	if(sbmname==""){alert("请选择部门！");return false;}
	var sbmcode = $("#sbmcode").val();
	if(sbmtypekey=="Bm1"){
		$("#sBm1").val(sbmname);
		$("#sBm1code").val(sbmcode);
		$("#sBm2").val("");
		$("#sBm3").val("");
		$("#sBm4").val("");
	}else if(sbmtypekey=="Bm2"){
		$("#sBm2").val(sbmname);
		$("#sBm2code").val(sbmcode);
		$("#sBm3").val("");
		$("#sBm4").val("");
		//$("#Bm3_yhdang").val("");
		//$("#Bm4_yhdang").val("");
	}else if(sbmtypekey=="Bm3"){
		$("#sBm3").val(sbmname); 
		$("#sBm3code").val(sbmcode);       		
		$("#sBm4").val("");
	}else if(sbmtypekey=="Bm4"){
		$("#sBm4").val(sbmname);
	}
	setTimeout($.unblockUI,15);
}
/**********************************************************************
function name:    fetchSingleValue
function:         fetchSingleValue(key,dss,param)

parameters:       key:要请求的SQL语句对应配置文件中键值
                  dss:数据源编号,0为宽带的 mysql数据源，1-7为固话的sqlServer数据源，具体查看函数identifyDs
                  param :
                  
return:           能取到值时返回取到的值，否则返回undefined
description:      从数据库中取单个值，通用
**********************************************************************/
function fetchSingleValue_rad(key,dss,param,dbCfgFile)
{
	var configFile = arguments[3];
	if(configFile==undefined)
	{
		configFile = dss?dbCfgFile:dbCfgFile;
	}
	var urlMm = tsd.buildParams({ packgname:'service',
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				//ds:identifyDs(dss),
				ds:'tsdBilling',
				tsdcf:configFile,//指向配置文件名称
				tsdoper:'query',//操作类型 
				datatype:'xml',//返回数据格式 
				tsdpk:key
			});
	//alert(urlMm +"_"+param);
	result = "";
	$.ajax({
		url:"mainServlet.html?" + urlMm + param,
		async:false,
		cache:false,
		timeout:1000,
		type:'post',
		success:function(xml){
			if (InvalidSessionPro(xml)) {return false};
			$(xml).find("row:first").each(function(){
				$(this).find("cell:first").each(function(){
					result = $(this).text();
				});
			});
		}
	});
	return result;
}
/**********************************************************************
function name:    fetchMultiPValue
function:         fetchMultiPValue(key,dss,param),通过存储过程取回多个值，返回值 N*M 数组

parameters:       key:要请求的存储过程的展现名
                  dss:数据源编号,0为宽带的 mysql数据源，1-7为固话的sqlServer数据源，具体查看函数identifyDs
                  param为需要的参数,格式为"&param1=value1&param2=value2";
                  
return:           能取到值时返回取到的值的多维数据，否则返回没有值的一维数据

description:      从数据库中取多值 N*M 数组，通用，主要用于取权限
**********************************************************************/
function fetchMultiPValue_rad(key,dss,param)
{
	var result = new Array();
	var i = 0;
	var j = 0;
	
	var urlMm = tsd.buildParams({ packgname:'service',
				clsname:'Procedure',//类名
				method:'exequery',//方法名
				ds:identifyDs(dss),
				tsdExeType:'query',//操作类型 
				datatype:'xml',//返回数据格式 
				tsdpname:key
				});
	//alert(urlMm +"_"+param);
	
	$.ajax({
		url:"radbusi?" + urlMm + param,
		async:false,
		cache:false,
		timeout:1000,
		type:'post',
		success:function(xml){			
			if (InvalidSessionPro(xml)) {return false};			
			$(xml).find("row").each(function(){				
				result[i++] = new Array();
				$(this).find("cell").each(function(){
					result[i-1].push($(this).text());
				});
			});
		}
	});	
	return result;
}

/**********************************************************************
function name:    fetchMultiPValue_main
function:         fetchMultiPValue_main(key,dss,param),通过存储过程取回多个值，返回值 N*M 数组

parameters:       key:要请求的存储过程的展现名
                  dss:数据源编号,0为宽带的 mysql数据源，1-7为固话的sqlServer数据源，具体查看函数identifyDs
                  param为需要的参数,格式为"&param1=value1&param2=value2";
                  
return:           能取到值时返回取到的值的多维数据，否则返回没有值的一维数据

description:      从数据库中取多值 N*M 数组，通用，主要用于取权限
**********************************************************************/
function fetchMultiPValue_rad_main(key,dss,param)
{
	var result = new Array();
	var i = 0;
	var j = 0;
	var urlMm = tsd.buildParams({ packgname:'service',
				clsname:'Procedure',//类名
				method:'exequery',//方法名
				ds:identifyDs(dss),
				tsdExeType:'query',//操作类型 
				datatype:'xml',//返回数据格式 
				tsdpname:key
				});
	//alert(urlMm +"_"+param);
	
	$.ajax({
		url:"mainServlet.html?" + urlMm + param,
		async:false,
		cache:false,
		timeout:1000,
		type:'post',
		success:function(xml){			
			if (InvalidSessionPro(xml)) {return false};			
			$(xml).find("row").each(function(){				
				result[i++] = new Array();
				$(this).find("cell").each(function(){
					result[i-1].push($(this).text());
				});
			});
		}
	});	
	return result;
}
/**********************************************************************
function name:    fetchMultiValue
function:         fetchMultiValue(key,dss,param),通过SQL语句取回多个值，返回值 N*M 数组

parameters:       key:要请求的的SQL语句在配置文件中的键值
                  dss:数据源编号,0为宽带的 mysql数据源，1-7为固话的sqlServer数据源，具体查看函数identifyDs
                  param为需要的参数,格式为"&param1=value1&param2=value2";
                  
return:           能取到值时返回取到的值的 N*M 多维数据，否则返回没有值的一维 1*0 数据

description:      从数据库中取多值 N*M 数组，其值为key查询的结果集的所有数据，通用
**********************************************************************/
function fetchMultiArrayValue_rad(key,dss,param)
{
	var result = new Array();
	var i = 0;
	var j = 0;
	var configFile = arguments[3];
	if(configFile==undefined)
	{
		configFile = dss?'mssql':'mysql';
	}
	
	var urlMm = tsd.buildParams({ packgname:'service',
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:identifyDs(dss),
				tsdcf:configFile,//指向配置文件名称
				tsdoper:'query',//操作类型 
				datatype:'xml',//返回数据格式 
				tsdpk:key
				});
	$.ajax({
		url:"mainServlet.html?" + urlMm + param,
		async:false,
		cache:false,
		timeout:1000,
		type:'post',
		success:function(xml){
			if (InvalidSessionPro(xml)) {return false};
			$(xml).find("row").each(function(){
				result[i++] = new Array();
				$(this).find("cell").each(function(){
					result[i-1].push($(this).text());
				});
			});
		}
	});
	
	return result;
}
//锁定账号 true可办理 false 不可办理
function kdLock(UserName,userid)
{
	var rel = fetchSingleValue("processingdistory.queryuseridname",6,"&userid="+userid);
	var res = fetchMultiPValue("kd.Lock",0,"&userid="+userid+"&account="+UserName+"&businesstype=setup&flag=in"+"&realname="+tsd.encodeURIComponent(rel));
	if(res[0]==undefined||res[0][0]==undefined||res[0][0]=="")
	{
		return true;
	}
	else
	{
		var info = "";
		info += "账号";
		info += UserName;
		info += "正被";
		info += res[0][0];
		info += "受理，请稍等...";
		alert(info);
		return false;
	}
}
//解锁账号
function kdunLock(userid)
{
	var res = fetchMultiPValue("kd.Lock",0,"&userid="+userid+"&flag=out");
}	
//离开页面时对锁定账号进行解锁
function jiesuo(){
      $(window).unload(function(){
		kdunLock();
   		});
}
/*********
* 返回用户的扩展权限			
**********/
function getUserPower(auserid,agroupid,amenuid){
	var urlstr=tsd.buildParams({  
		  packgname:'service',
		  clsname:'Procedure',
		  method:'exequery',
		  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
		  tsdpname:'BusinessCosts.getPower',//存储过程的映射名称
		  tsdExeType:'query',
		  datatype:'xmlattr'
	});
	/************************
	*   调用存储过程需要的参数 *
	**********************/
	var userid = auserid;	
	var groupid = agroupid;
	var imenuid = amenuid;		
	
	var spower = '';				
	$.ajax({
		url:'mainServlet.html?'+urlstr+'&userid='+userid+'&groupid='+groupid+'&menuid='+imenuid,
		datatype:'xml',
		cache:false,//如果值变化可能性比较大 一定要将缓存设成false
		timeout: 1000,
		async: false ,//同步方式
		success:function(xml){
			if (InvalidSessionPro(xml)) {return false};
			$(xml).find('row').each(function(){
					spower += $(this).attr("spower")+'@';
			});
		}
	});
	return spower;
}
//过期session处理函数
function InvalidSessionPro(xml){
    if (typeof(xml)=="string")
    {
	    if (xml == "session invalid")
	    {
	      	location.href="login.jsp";
	      	return true;
	    }
    }
    return false;
}
//取出宽带业务费 ywlx(业务类型)-如开户：r_setup
function getBussFee(ywlx){
	var res = fetchMultiArrayValue_rad('dbsql_rad.BussFee_New',6,"&ywlx="+ywlx,'business');		
	return res;
}

/**
*帐号加锁
**/
function inLock(busitype,usertype){
	var userid = tsd.encodeURIComponent($("#userid").val());	   		
	executeNoQueryProc("radbusi.rad_validcheck",6,"&OperID=" + userid + "&busitype="+busitype+"&opentype=lock&locktype=lockin&account="+tsd.encodeURIComponent(usertype));
}

/**
*帐号解锁
**/
function unIfLock(){
	var userid = tsd.encodeURIComponent($("#userid").val());
	executeNoQueryProc("radbusi.rad_validcheck",6,"&OperID="+userid+"&opentype=lock&locktype=unlock");
}

/**********************************************************************
function name:    numValid
function:         实收金额里限制输入两位小数。
parameters:                      
return:           
description:      
**********************************************************************/
function numValid(obj)
{		
	if($.browser.msie)
	{
		var dotPos = obj.value.indexOf(".");
		var lenAfterDot;
		
		if(dotPos==-1)
		{
			lenAfterDot = 0;
		}
		else
		{
			lenAfterDot = obj.value.length - dotPos -1;
		}
		
		var evt = window.event;
		if (evt.keyCode < 48 || evt.keyCode > 57)
		{
			if(evt.keyCode==46)
			{
				if(dotPos==-1)
					lenAfterDot=0;
				else
					evt.returnValue = false;
			}
			else
			{
				evt.returnValue = false;
			}
		}
		else
		{
			if(dotPos!=-1)
			{
				if(lenAfterDot>=2)
				{
					evt.returnValue = false;
				}
			}
		}
	}
	else
	{
		obj.value=obj.value.replace(/[^0-9]/g,'');
	}
} 	   


