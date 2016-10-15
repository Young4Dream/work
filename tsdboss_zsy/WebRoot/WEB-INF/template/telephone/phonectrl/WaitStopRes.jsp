<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/phonectrl/WaitStopRes.jsp
    Function:   电话待停复用户
    Author:     wenxuming
    Date:       2011-04-25
    Description: 
    Modify:     
-----------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
	/////////////////Java取当前时间
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
	SimpleDateFormat formatto = new SimpleDateFormat("yyyy-MM-dd");
	Date now = new Date();
	String nowTime = format.format(now);
	String nowTimeto = formatto.format(now);
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
	String area = (String) session.getAttribute("chargearea");
	String depart = (String) session.getAttribute("departname");
	String userareaid = (String) session.getAttribute("userarea");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>电话待停复用户</title>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<!-- 分项卡 -->
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css"
			type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css"
			type="text/css" media="projection, screen" />		
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<!-- dtree需要导入文件 -->
		<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<!-- 验证框架需要导入的js文件 -->
		<script src="plug-in/jquery/validate/jquery.validate.js" type="text/javascript"></script>
	  	<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script type="text/javascript" src="script/telephone/sysdataset/infotest.js"></script>
		<!-- 时间选择器 -->
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservice.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservicenew.js" type="text/javascript" language="javascript"></script>
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>	
		<style type="text/css">
			#qftrid{background-color:#A9C8D9;border:#A9C8D9 solid 0px;}
			#qftrid{border-collapse:collapse;border:#A9C8D9 solid 1px;}
			#qfuser tr td{line-height:26px;border:#A9C8D9 solid 1px;TEXT-OVERFLOW: ellipsis;}
		</style>
		<style type="text/css">  
		.mytable{   
		   width:100%;
		   table-layout:fixed;
		   border:0px;   
		   margin:0px; 
		   }      
		.mytable tr td{   
		   text-overflow:ellipsis; /* for IE */    
		   -moz-text-overflow: ellipsis; /* for Firefox,mozilla */    
		    overflow:hidden;   
		    white-space: nowrap;   
		    border:0px;   
		    text-align:left;      
		   }
		   .mytable tr th{   
		    white-space: nowrap;   
		   border:0px;   
		    text-align:left   
		   }   
		</style> 
		<script type="text/javascript">
		 /*********
				* 业务受理除装机跟也修改属性以外的其他业务权限			
				* @param;
				* @return;
		    	**********/
				function getywslUserPower(){
				 var urlstr=tsd.buildParams({ 	  packgname:'service',
							 					  clsname:'Procedure',
												  method:'exequery',
							 					  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
							 					  tsdpname:'prodistorys.xuanxian',//存储过程的映射名称
							 					  tsdExeType:'query',
							 					  datatype:'xmlattr'
						 					});
				/************************
				*   调用存储过程需要的参数 *
				**********************/
				var userid = $('#userid').val();	
				var groupid = $('#zid').val();
				var imenuid = $('#imenuid').val();
				
				/****************
				*   拼接权限参数 *
				**************/
				var areajhj_idright='';
				var flag = false;
				
				var spower = '';				
				$.ajax({
						url:'mainServlet.html?'+urlstr+'&userid='+userid+'&groupid='+groupid+'&menuid='+imenuid,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							$(xml).find('row').each(function(){
									spower += $(this).attr("spower")+'@';
							});
						}
				});
				if(spower=='all@'){
						areajhj_idright='true';
						flag = true;
				}else if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');
						for(var i = 0;i<spowerarr.length-1;i++){
							areajhj_idright +=getCaption(spowerarr[i],'areajhj_id','')+'|';//一次性费用应缴费
						}
				}
				var hasareajhj_id = areajhj_idright.split('|');
				var str = 'true';
				if(flag==true){
					$("#areajhj_idright").val(areajhj_idright);	
				}else{
					for(var i = 0;i<hasareajhj_id.length;i++){
							$("#areajhj_idright").val(hasareajhj_id[i]);
							break;
						}
				}
			}

		jQuery(document).ready(function()
		{			
			$("#navBar").append(genNavv());
		    gobackInNavbar("navBar");
		    getywslUserPower();
		    Dat = loadData("hwjb_waitadjust","zh",1,'选择操作');		
		    Dat.setHidden(['Hwjb']);    
		    gettabletitle();
		    //gettabledate();
		    getJqgridDate();
		});	
		
		function gettabletitle(){
			var querystr=""
			var count=0;
			var fieldname='';			
			for(var i=0;i<Dat.FieldName.length;i++){
				count +=parseInt(Dat.ShowWidth[i],10)
			}
			$("#countlength").val(count);
			querystr +="<table id='qfusertitle' style='width:100%;height:25px;' class='mytable'>";
			querystr += "<tr id='qftrid'>";
			querystr += "<th style='width:3%;'><center>";
			querystr += "";
			querystr += "</center></th>";
			for(var i=0;i<Dat.FieldName.length;i++){
				if(Dat.FieldName[i]=="Hwjb"){
					querystr += "<th style='display:none;'>";
					querystr += Dat.FieldAlias[i];
					querystr += "</th>";
					fieldname += Dat.FieldName[i]+",";
				}else{
					querystr += "<th style='width:"+Dat.ShowWidth[i]*0.1+"%;'>";
					querystr += Dat.FieldAlias[i];
					querystr += "</th>";
					fieldname += Dat.FieldName[i]+",";
				}				
			}
			querystr += "</tr></table>";			
			$("#tabletitle").html(querystr);
			$("#fieldname").val(fieldname);
		}

		function gettabledate(query){
			$("#radiophone").val("");
			$("#radioHwjb").val("");
			$("#radioServiceType").val("");
			$("#radioAdjust_Man").val("");
			$("#qfuser").empty();
			var querystr = "";
			var params="";
			var fieldname = $("#fieldname").val();
			fieldname = fieldname.substring(0,fieldname.length-1);
			$("#tablevaluestr").empty();
			var queryphone = $("#queryphone").val();
			if(query=="query"){
				params="&key="+$("#fusearchsql").val()+"and d.jhj_id=j.jhjid";
			}else{
				params="&key=1=1 and d.jhj_id=j.jhjid";
			}
			fieldname=fieldname.replace('Jhj_ID','j.jhjname');
			if($("#areajhj_idright").val()=="false"){
				var res = fetchMultiArrayValue("dbsql_phone.queryjhjidarea",6,"&jhjarea="+tsd.encodeURIComponent($("#area").val()));
				if(res==undefined){res="";}
				var strinto="";
				for(var j=0;j<res.length;j++){
					strinto+=res[j][0]+","
				}
				strinto = strinto.substring(0,strinto.length-1);
		    	params+=" and jhj_id in("+res+")";
		    }
			var res = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&cloum="+fieldname+params+"&tablename=hwjb_waitadjust d,jhjid j");
			if(res==""||res==undefined||res=="undefined"){return;}
			var count = $("#countlength").val();
			querystr +="<div id='page' style='height: 530px; overflow-y: scroll; overflow-x: hidden; border-top: 1px solid gray; border-left: 1px solid gray;'><table id='qfuser' class='mytable'>";
			for(var i=0;i<res.length;i++){
				querystr += "<tr onClick=\"getselect('"+res[i][1]+"');\" id=\""+res[i][1]+"\">";				
				querystr += "<td  style='width:3%;'><center>";
				querystr += "<input type=\"radio\" id='v_bytctab_check"+res[i][1]+"' name='v_wsr_radio'  onClick=\"getradiovalue();\"  value='"+res[i][1]+","+res[i][4]+","+res[i][5]+","+res[i][6]+"' style='width:20px;'/>";
				querystr += "</center></td>";
				for(var j=0;j<Dat.FieldName.length;j++){
					if(Dat.FieldName[j]=="Hwjb"){
						querystr+="<td title='"+res[i][j]+"' style='display:none;'>"+res[i][j]+"</td>";
					}else{
						querystr+="<td title='"+res[i][j]+"' style='width:"+Dat.ShowWidth[j]*0.1+"%;'>"+res[i][j]+"</td>";
					}
				}
				querystr += "</tr>";
			}
			querystr +="</table></div>";
			$("#tablevaluestr").html(querystr);
		}

		function getselect(key){
			$("#qfuserhidden").val(key);
        	$("#qfuser tr ").css('background-color','#ffffff');
        	$("#qftrid").css('background-color','#A9C8D9');
		    document.getElementById(key).style.background='#00FFFF';
		}
		
		function fuheExe(){
			//gettabledate("query");
			getJqgridDate("query");
		}

		function getradiovalue(){
			var va = $("#qfuser input[name='v_wsr_radio']:checked").val();
			var array = va.split(",");
			$("#radiophone").val(array[0]);//电话dh
			$("#radioHwjb").val(array[1]);//业务代码Hwjb
			$("#radioServiceType").val(array[2]);//业务类型ServiceType
			$("#radioAdjust_Man").val(array[3]);//工号Adjust_Man
		}

		function savefrom(){
			$("#queryphone").text($("#radiophone").val());
			if($("#radiophone").val()==""){
				alert("请选择一个电话！");
				return;
			}
			autoBlockFormAndSetWH('saveupdate',150,250,'close',"#ffffff",false)
		}

		function dcfield(){
			thisDownLoad('tsdBilling','mssql','hwjb_waitadjust',$("#languageType").val(),5);
		}
		
		/**
		 * 导出面板确定按钮事件，导出数据
		 * @param 
		 * @return 
		 */
		function DownSure()
		{
			getTheCheckedFields('tsdBilling','mssql','hwjb_waitadjust');
		}

		function saveupdate(){
			var dh = $("#radiophone").val();//电话dh
			if(dh==""){alert("请选择一个电话！");return;}
			var hwjb = $("#radioHwjb").val();//业务代码Hwjb
			var ServiceType = $("#radioServiceType").val();//业务类型ServiceType
			var Adjust_Man = $("#radioAdjust_Man").val();//工号Adjust_Man
			var userid = $("#userid").val();
			var sfOperType = $("#sfOperType").val();
			var bz = $("#Bz").val().replace(/(^\s*)|(\s*$)/g,"");
			if(sfOperType==""){alert("请选择操作类型！");return;}
			if(bz==""){alert("请输入备注信息！");return;}
			var params="";
			params +="&Dh="+dh;
			params +="&Hwjb="+tsd.encodeURIComponent(hwjb);
			params +="&ServiceType="+tsd.encodeURIComponent(ServiceType);
			params +="&AdjustMan="+tsd.encodeURIComponent(Adjust_Man);
			params +="&userid="+tsd.encodeURIComponent(userid);
			params +="&res="+tsd.encodeURIComponent(sfOperType);
			params +="&memo="+tsd.encodeURIComponent(bz);
			var result = fetchMultiPValue("WaitStopRes.Hwjb_Adjust_Ok",6,params);			
			if(result[0]==undefined || result[0][0]==undefined || result[0][0]=='-1')
			{
				alert("操作失败！");
				return;
			}else{			
				alert("操作成功！");
				//gettabledate();
				getJqgridDate('')
				closeGB();
			}
		}

		/****************
	    *备注限制函数
	    *oTextArea:内容
	    *******************/
	    var TextUtil = new Object(); 
	      TextUtil.NotMax = function(oTextArea){ 
	          var maxText = oTextArea.getAttribute("maxlength"); 
	          if(oTextArea.value.length > maxText){ 
	                 oTextArea.value = oTextArea.value.substring(0,maxText); 
	                  alert("输入超出限制！"); 
	          } 
	      } 	
	</script>
	<script type="text/javascript">
		function getJqgridDate(query){
			$("#gridd").empty();
			$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
			$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
			$("#editgrid").empty();
			$("#radiophone").val("");
			$("#radioHwjb").val("");
			$("#radioServiceType").val("");
			$("#radioAdjust_Man").val("");
			$("#qfuser").empty();
			var querystr = "";
			var params="";
			var fieldname = $("#fieldname").val();
			fieldname = fieldname.substring(0,fieldname.length-1);
			$("#tablevaluestr").empty();
			var queryphone = $("#queryphone").val();
			if(query=="query"){
				params="&key="+$("#fusearchsql").val();
			}else{
				params="&key=1=1";
			}
			if($("#areajhj_idright").val()=="false"){
				var res = fetchMultiArrayValue("dbsql_phone.queryjhjidarea",6,"&jhjarea="+tsd.encodeURIComponent($("#area").val()));
				if(res==undefined){res="";}
				var strinto="";
				for(var j=0;j<res.length;j++){
					strinto+=res[j][0]+","
				}
				strinto = strinto.substring(0,strinto.length-1);
		    	params+=" and jhj_id in("+res+")";
		    }		    
			var urlstr=tsd.buildParams({
				packgname:'service',//java包
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
				tsdcf:'mssql',//指向配置文件名称
				tsdoper:'query',//操作类型 
				datatype:'xml',//返回数据格式 
				tsdpk:'dbsql_phone.queryFYtabledate',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
				tsdpkpagesql:'dbsql_phone.querypageFYtabledate'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
			});
			jQuery("#editgrid").jqGrid({
						url:'mainServlet.html?'+urlstr + "&cloum=Dh,"+fieldname+params+"&tablename=hwjb_waitadjust d",
						datatype: 'xml', 						
						colNames:Dat.colNames, 
						colModel:Dat.colModels, 
						rowNum:100, //默认分页行数
						multiselect:true,
						useDefault:true,
						rowList:[100,150,200], //可选分页行数
						//multiselect:true,
						imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						pager: jQuery('#pagered'), 
						sortname: 'ADJUST_TIME', //默认排序字段
						viewrecords: true,
						//hidegrid: false, 
						sortorder: 'desc',//默认排序方式 
						caption:'电话待停复用户',
						//caption:infoo,				       	
						height:400, //高
						//width:document.documentElement.clientWidth-27,
						loadComplete:function(){
							var ids = $("#editgrid").getDataIDs();
								for(var i=0;i<ids.length;i++)
								{
									var Jhj_ID = $("#editgrid").getCell(ids[i],"Jhj_ID");
									var Jhj_IDname = getJhj_ID(Jhj_ID);
									if(Jhj_IDname!=undefined)
									{
										$("#editgrid").setRowData(ids[i],{"Jhj_ID":Jhj_IDname});
									}
								}
							addRowOperBtn('editgrid',"<span style='color:red'>单选操作</span>",'Operation','Dh','click',1,'Hwjb','ServiceType','Adjust_Man');			        											        	
							executeAddBtnWithoutAddCell('editgrid',1);
												},
						ondblClickRow: function(ids) {
												}
						}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false}, //options 
							{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
							{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
							{reloadAfterSubmit:false}, // del options 
							{} // search options 
							); 				
		}
		
		function getJhj_ID(key){
			var res = fetchSingleValue("dbsql_phone.querytabledate",6,"&tablename=jhjid&cloum=jhjname&key=jhjid="+tsd.encodeURIComponent(key));
			return res;
		}
		
		function Operation(DH,Hwjb,ServiceType,Adjust_Man){
			//alert(DH+","+Hwjb+","+ServiceType+","+Adjust_Man);
			$("#radiophone").val(DH);//电话dh
			$("#radioHwjb").val(Hwjb);//业务代码Hwjb
			$("#radioServiceType").val(ServiceType);//业务类型ServiceType
			$("#radioAdjust_Man").val(Adjust_Man);//工号Adjust_Man
			savefrom();
		}

		function BatchOpen(){
			$("#queryphone").text("allphone");
			var Batchall = $("#editgrid").getGridParam("selarrrow");
			if(Batchall.length==0)
			{
				alert("请选择要批量处理的数据");
				return;
			}
			autoBlockFormAndSetWH('saveupdate',150,250,'close',"#ffffff",false)
		}
		
		function opentypeserve(){			
			if($("#queryphone").text()=="allphone"){
				BatchOpensave();
			}else{
				saveupdate();
			}
		}
		
		/*
		*批量炒作进行
		*
		*/
		function BatchOpensave(){			
			var Batchall = $("#editgrid").getGridParam("selarrrow");
			if(Batchall.length==0)
			{
				alert("请选择要批量处理的数据");
				return;
			}
			var tval = [];
			var params="";
			for(var ii=0;ii<Batchall.length;ii++)
			{
				var tmp_dh = $("#editgrid").getCell(Batchall[ii],"Dh");
				var tmp_Hwjb = $("#editgrid").getCell(Batchall[ii],"Hwjb");
				var tmp_ServiceType = $("#editgrid").getCell(Batchall[ii],"ServiceType");
				var tmp_Adjust_Man = $("#editgrid").getCell(Batchall[ii],"Adjust_Man");
				params="&Dh="+tsd.encodeURIComponent(tmp_dh)+"&Hwjb="+tsd.encodeURIComponent(tmp_Hwjb)+"&ServiceType="+tsd.encodeURIComponent(tmp_ServiceType)+"&Adjust_Man="+tsd.encodeURIComponent(tmp_Adjust_Man)+"&userid="+tsd.encodeURIComponent($("#userid").val());
				var insertRes = executeNoQuery("dbsql_phone.insertHwjbWaitAdjustTmp",6,params);
        		if(insertRes=="true" || insertRes==true)
        		{
        			//alert("添加数据成功");
        		}
        		else
        		{
        			var resboolean = executeNoQuery("dbsql_phone.insertHwjbWaitAdjustTmp",6,params);
        		}
				if(null==tmp_dh)
				{
					alert("没有可查询的电话："+tmp_dh);
				}
				//tval.push($.trim(tmp_dh));
			}
			var paramsStr="";
			var sfOperType = $("#sfOperType").val();
			var bz = $("#Bz").val().replace(/(^\s*)|(\s*$)/g,"");
			if(sfOperType==""){alert("请选择操作类型！");return;}
			if(bz==""){alert("请输入备注信息！");return;}
			paramsStr +="&opentype=batchopen";
			paramsStr +="&res="+tsd.encodeURIComponent(sfOperType);
			paramsStr +="&memo="+tsd.encodeURIComponent(bz);
			paramsStr +="&userid="+tsd.encodeURIComponent($("#userid").val());
			var result = fetchMultiPValue("WaitStopRes.Hwjb_Adjust_Ok",6,paramsStr);			
			if(result[0]==undefined || result[0][0]==undefined || result[0][0]=='-1')
			{
				alert("操作失败！");
				return;
			}else{			
				alert("操作成功！");
				//gettabledate();
				getJqgridDate('')
				closeGB();
			}
			
		}
	</script>
  </head>
  <body>
    <div id="navBar">
			<img src="style/icon/dot11.gif" />
			<fmt:message key="global.location" />:
	</div>
	<div id="input-Unit">
		<table cellspacing='5'>
			<tr>
				<td>
					<button id="" class="tsdbutton" onClick="openDiaQueryG('query','hwjb_waitadjust');" style="width:70px;">查询</button>
				</td>
				<td>
					<button id="" class="tsdbutton" onClick="BatchOpen()" style="width:70px;">批量操作</button>
				</td>
				<td>
					<button id="" class="tsdbutton" onClick="dcfield();" style="width:70px;">导出数据</button>
				</td>
			</tr>
		</table>
		<div id='tabletitle' style="display:none;">
			
		</div>
		<div id='tablevaluestr'>
		
		</div>
		<div id="gridd">
		    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>			
		</div>
		<table cellspacing='5'>
			<tr>
				<td>
					<button id="" class="tsdbutton" onClick="openDiaQueryG('query','hwjb_waitadjust');" style="width:70px;">查询</button>
				</td>
				<td>
					<button id="" class="tsdbutton" onClick="BatchOpen()" style="width:70px;">批量操作</button>
				</td>
				<td>
					<button id="" class="tsdbutton" onClick="dcfield();" style="width:70px;">导出数据</button>
				</td>
			</tr>
		</table>
	</div>
	<div class="neirong" id="saveupdate" style="width:478px;display: none">
			<div class="top">
			<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
						<div class="top_03" id="titlediv">操作信息</div>
						<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
					</div>
					<div class="top_01right"><a href="#" onClick="closeGB();">关闭</a></div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
		</div>
			<div class="midd" style="background-color:#FFFFFF;height:50px;">
				<div id="inputtext">
					<table border="0" cellpadding="0" bordercolor="" id="inpuththtable" style="width: 466px;"  cellspacing="3">
						<tr>
							<td style="width:50px;" class='labelclass'>电话</td>
							<td><span id="queryphone"></span></td>
							<td style="width:50px;" class='labelclass'>操作类型</td>
							<td><select id="sfOperType" style="width:180px;">
									<option value="">--请选择--</option>
									<option value="success">成功</option>
									<option value="failure">失败</option>
								</select>
								<span style="color:red">*</span>
							</td>
						</tr>
						<tr>
							<td class='labelclass'>备注</td>
							<td colspan='3'>
								<textarea name="Bz" id="Bz" rows="4" cols="60" style="width:330px;" maxlength="60"  onpropertychange="TextUtil.NotMax(this)"></textarea>
								<span style="color:red">*</span>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="midd_butt" style="width:468px;height:40px;">
				<button id="queryphonebutton" onClick="opentypeserve();" class="tsdbutton" 
					style="margin-left: 20px;">
					保存
				</button>
			</div>
		</div>
	<!-- 导出数据 -->
	<div class="neirong" id="thefieldsform" style="display: none;width:763px">
		<div class="top">
			<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
						<div class="top_03" id="titlediv">选择您要导出的数据字段</div>
						<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
					</div>
					<div class="top_01right"><a href="#" onClick="javascript:$('#closethisinfo').click();">关闭</a></div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
		</div>
		<div class="midd" >
			   <form action="#" onSubmit="return false;">
				<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<div id="thelistform" style="margin-left: 10px;max-height: 200px">
						
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="midd_butt" style="width:745px">
			<button type="submit" class="tsdbutton" id="query" onClick="checkedAllFields()">
				全选
			</button>
			<button type="submit" class="tsdbutton" id="query" onClick="DownSure()">
				<fmt:message key="global.ok" />
			</button>
			<button type="button" class="tsdbutton" id="closethisinfo" >
				<fmt:message key="global.close" />
			</button>
			
		</div>
	</div>		
	<!-- 高级查询 -->		
	<input type="hidden" id="queryName" name="queryName" value=""/>
	<input type="hidden" id="fusearchsql" name="fusearchsql"/>
	<!-- 查询树信息存放 保存模板查询 -->
	<input type="hidden" id='treepid'/>
	<input type="hidden" id='treecid'/>
	<input type="hidden" id='treestr'/>
	<input type="hidden" id='treepic'/>
	<input type="hidden" id="fieldname"/>
	<input type="hidden" id="countlength"/>
	<input type="hidden" id="languageType" value="<%=languageType %>"/>
	<input type="hidden" id="radiophone"/>
	<input type="hidden" id="radioHwjb"/>
	<input type="hidden" id="radioServiceType"/>
	<input type="hidden" id="radioAdjust_Man"/>
	<input type="hidden" id="areajhj_idright"/>
	<input type="hidden" id="userid" value="<%=userid %>"/>
	<input type="hidden" id="area" value="<%=area %>"/>
	<input type="hidden" id="zid" value="<%=zid %>"/>
	<input type="hidden" id="imenuid" value="<%=imenuid %>"/>
  </body>
</html>
