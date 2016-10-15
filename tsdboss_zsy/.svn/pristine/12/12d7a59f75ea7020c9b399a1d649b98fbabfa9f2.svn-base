<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/UserDetailsQuery.jsp
    Function:   电话用户详细资料查询
    Author:     wenxuming
    Date:       2011-04-19
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
		<title>电话用户详细信息查询</title>
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
		#input-Unit .title{text-align:left;}
		.inputbox{{margin-left:20px; background:url(style/imgs/inputText_bg.jpg) repeat-x ; width:180px; border:#999999 solid 1px;  text-align:left; color:#000000; font-size:12px; font-weight:bold; height:22px; line-height: 23px; }}
		hr {border:1px #A9C8D9 dotted;}
		.tdstyle{border-bottom:1px solid #A9C8D9;}
		#tdiv td{line-height:26px;}
		</style>
		
		<script type="text/javascript">
		jQuery(document).ready(function()
		{
			$("#navBar").append(genNavv());
		    gobackInNavbar("navBar");
		    $("#tabs").tabs();   
		    $("#ghSearchBox").select();
		    $("#ghSearchBox").focus();		    
		});		
		/*******
	   	* 从真实姓名对应的多个账户中选择要查询的账户
	   	* @param:Yhmc用户名称，Dh电话，Yhdz用户地址;
	   	* @return;
	  	********/
		function userChoose(Yhmc,Dh,Yhdz)
		{   		
			$("#querydh").val(Dh);
			var reshth = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=Hth&tablename=yhdang&key=Dh='"+Dh+"'");
			$("#queryhth").val(reshth);
			tabsChg('yhdang','HX');
			setTimeout($.unblockUI,1);
		}
		
		
		function tabsChg(tablename,show){
			$("#gridd").empty();
			$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
			$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
			$("#editgrid").empty();
			getfield(tablename);//得到列名
			var languageType = $("#languageType").val();
			var reszh = fetchFieldAlias(tablename,languageType);
			$("#userphonecontent").empty();
			var res = fetchMultiArrayValue("dbsql_phone.allqueryyhdang",6,"&userid="+tsd.encodeURIComponent("userinfo")+"&tablename="+tsd.encodeURIComponent(tablename));			
			var queryres="<table id='userphonecontent' width='75%' border='0' cellspacing='0' cellpadding='1'  cellspacing='5' style='background-color: #F8F8FF; border-collapse: collapse; float: left;'>";			
			if(res[0]==undefined ||res[0][0]==undefined)
			{
				queryres="</tr><td><apan>请在rb_field_user表中配置数据信息！！！</span>/td></tr>";
			}else{
				queryres += "<tr>";							
					var j=0;					
	            	for(var i=0;i<res.length;i++){
		                queryres +="<td  class='labelclass'><h4>"+reszh[res[i][0]]+"</h4></td>";        			
	        			queryres +="<td width='20%'><span id="+res[i][0]+" style='font-size:1.2em;'></span></td>";	        			
	        			j++;
	        			if(j==3){
	        				queryres+="</tr><tr>";
	        				j=0;
	        			}
	        		}
	            queryres+="</tr></table>";            	
				$("#gridd").html(queryres);
			}
			queryphone(tablename,show);
		}
		
		function getfield(tablename){
			//var res = fetchMultiArrayValue("dbsql_phone.alltablefield",6,"&userid="+tsd.encodeURIComponent("userinfo")+"&tablename="+tsd.encodeURIComponent(key));
			var res = fetchMultiArrayValue("dbsql_phone.allqueryyhdang",6,"&userid="+tsd.encodeURIComponent("userinfo")+"&tablename="+tsd.encodeURIComponent(tablename));
			var widthlength="";
			var fieldvalue="";
			for(var i=0;i<res.length;i++){
				widthlength+=res[i][1]+",";
				fieldvalue+=res[i][0]+","
			}
			widthlength = widthlength.substring(0,widthlength.length-1);
			fieldvalue = fieldvalue.substring(0,fieldvalue.length-1);
			$("#fieldvalue").val(fieldvalue);
			$("#widthlength").val(widthlength);
			$("#count").val(res.length);
		}
		
		function queryphone(tablename,show){
			var params='';
			if(tablename=="yhdang"){
				params = "&key=" + "Dh='"+$("#querydh").val()+"'";	
			}else if(tablename=="hthdang"||tablename=="jiaofei"){
				params = "&key=" + "Hth='"+$("#queryhth").val()+"'";	
			}else if(tablename=="teljob"){
				params = "&key=" + "Xdh='"+$("#querydh").val()+"'";	
			}else{
				params = "&key=" + "Dh='"+$("#querydh").val()+"'";
			}
			var fieldvalue = $("#fieldvalue").val();
			if(fieldvalue==""||fieldvalue=="undefined"){return;}					
			params += "&cloum=" + fieldvalue;
			params += "&tablename=" + tablename;
			var res = fetchMultiArrayValue("dbsql_phone.querytabledate",6,params);
			if(res[0]==undefined ||res[0][0]==undefined||res[0][0]==""||res==""){
				$("#userphonecontent").empty();
				$("#userphonecontent").html("<tr><td>该项没有用户信息！！！</td></tr>");
				return;
			}else{
				var array="";
				array=fieldvalue.split(",");
				var tablequeryres="";
					for(var i=0;i<array.length;i++){						
						if(array[i]=='Tjbz'){
							$("#"+array[i]+"").text(gethwjbtjbz(res[0][i]));							
						}else if(array[i]=='Tjbz'&&tablename=="hthdang"){
							$("#"+array[i]+"").text(res[0][i]=='Y'?'是':'否');
						}else if(array[i]=='CustType'){
							$("#"+array[i]+"").text(getcusttype(res[0][i]));
						}else if(array[i]=='CallPayType'){
							$("#"+array[i]+"").text(getPayPolicy(res[0][i]));						
						}else if(array[i]=='ZnjBz'){
							$("#"+array[i]+"").text(getZNJLogo(res[0][i]));
						}else{
							$("#"+array[i]+"").text(res[0][i]);
						}
					}
					$("#userphonecontent").append(tablequeryres);
				}
		}
		
		function getGrid(tablename,sequence){
			$("#gridd").empty();
			$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
			$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
			$("#editgrid").empty();
			getfield(tablename);//得到列名
			var params="";
			if(tablename=='jiaofei'||tablename=='hthhf'){
				params += "&key=" + "Hth='"+$("#queryhth").val()+"'";	
			}else if(tablename=='teljob'){
				params += "&key=" + "xDh='"+$("#querydh").val()+"'";
			}else{
				params += "&key=" + "Dh='"+$("#querydh").val()+"'";
			}
			var fieldvalue = $("#fieldvalue").val();
			var widthlength = $("#widthlength").val();
			if(fieldvalue==""||fieldvalue=="undefined"){return;}
			params += "&cloum=" + fieldvalue;
			params += "&tablename=" + tablename;
			var languageType = $("#languageType").val();
			var reszh = fetchFieldAlias(tablename,languageType);
			var array = fieldvalue.split(',');
			var warray = widthlength.split(',');
			var colnstr=[];
			var colmstr=[];
			for(var i=0;i<array.length;i++){
				colnstr.push(reszh[array[i]]);
				colmstr.push({name:array[i],index:array[i],width:parseInt(warray[i],10)});			
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
					//'区域','实收金额','电话','合同号','是否已销账','收费时间','结清日期','收费科目','缴费票据号','收款方式','收费类型','收款员','收费月份','用户名称','用户性质','应交费','预收款','滞纳金','支票号'
					//{name:'Area',index:'Area',width:100},{name:'Byck',index:'Byck',width:100},{name:'Dh',index:'Dh',width:100},{name:'Hth',index:'Hth',width:100},{name:'IsXz',index:'IsXz',width:100},{name:'Jfshj',index:'Jfshj',width:100},{name:'Jqrq',index:'Jqrq',width:100},{name:'Kemu',index:'Kemu',width:100},{name:'Lsz',index:'Lsz',width:100},{name:'Pay_Flag',index:'Pay_Flag',width:100},{name:'Sflx',index:'Sflx',width:100},{name:'Skry',index:'Skry',width:100},{name:'Yf',index:'Yf',width:100},{name:'Yhmch',index:'Yhmch',width:100},{name:'Yhxz',index:'Yhxz',width:100},{name:'Yjf',index:'Yjf',width:100},{name:'Ysk',index:'Ysk',width:100},{name:'Znj',index:'Znj',width:100},{name:'out_bz11',index:'out_bz11',width:100},
					//Area,Byck,Dh,Hth,IsXz,Jfshj,Jqrq,Kemu,Lsz,Pay_Flag,Sflx,Skry,Yf,Yhmch,Yhxz,Yjf,Ysk,Znj,out_bz11
					jQuery("#editgrid").jqGrid({
						url:'mainServlet.html?'+urlstr+params,
						datatype: 'xml', 						
						colNames:colnstr,
						colModel:colmstr,
						rowNum:10, //默认分页行数
						rowList:[10,15,20], //可选分页行数
						//multiselect:true,
						imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						pager: jQuery('#pagered'), 
						sortname: sequence, //默认排序字段
						//hidegrid: false, 
						sortorder: 'desc',//默认排序方式 
						//caption:infoo,				       	
						height:300, //高
						//	width:document.documentElement.clientWidth-27,
						loadComplete:function(){
							var ids = $("#editgrid").getDataIDs();
								for(var i=0;i<ids.length;i++)
								{
									var pf = $("#editgrid").getCell(ids[i],"Pay_Flag");
									var pfname = gettsd_ini(pf);
									if(pfname!=undefined)
									{
										$("#editgrid").setRowData(ids[i],{"Pay_Flag":pfname});
									}
									var Sgnr = $("#editgrid").getCell(ids[i],"Sgnr");
									var Sgnrname = getywsl_code(Sgnr);
									if(Sgnrname!=undefined)
									{
										$("#editgrid").setRowData(ids[i],{"Sgnr":Sgnrname});
									}
								}			
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
		
		function gettsd_ini(key){
			var res = fetchSingleValue('dbsql_phone.querytsd_ini',6,"&tsection=payitem&tident="+key);
			return res;
		}
		function getywsl_code(key){
			var res = fetchSingleValue('dbsql_phone.queryywsl_code',6,"&ywlx="+key);
			return res;
		}
		
		 /*******
        *根据停机标志查询停机状态 
        *@param
        *@return
        ********/ 
        function gethwjbtjbz(tfjstatus)
        {
        	var tjbz;
           var urlstr=tsd.buildParams({  
							packgname:'service',		//java包
							clsname:'AskConstant',		//类名
							method:'askConstantTable',	//方法名
							identity:'FINAL.HwjbDef',	//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							pattern:'select',			//访问方式 select：查询常量表信息，update：更新常量表信息
							argument:'hwjb:'+tsd.encodeURIComponent(tfjstatus)				//对常量表的过滤条件
			 				});
			 	tjbz='';
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
							$(xml).find('row').each(function(){
		                 			tjbz = $(this).attr("bz");
							});
					}
				});
			return tjbz;	
        }
        
        /***********************
			* 客户类型
			* @param;
			* @return;
		    *************************/
			function getcusttype(key){
				var str;
				var urlstr=tsd.buildParams({  
							packgname:'service',		//java包
							clsname:'AskConstant',		//类名
							method:'askConstantTable',	//方法名
							identity:'FINAL.custtype',	//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							pattern:'select',			//访问方式 select：查询常量表信息，update：更新常量表信息
							argument:'custid:'+tsd.encodeURIComponent(key)				//对常量表的过滤条件
			 				});
				$.ajax({
					url:'mainServlet.html?'+urlstr,					
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
							$(xml).find('row').each(function(){
		                 			str = $(this).attr("custtype");
							});							
					}
				});
				return str;
			}
			
		/*******
        *生成付费
        *@param
        *@return
        ********/       
        function getPayPolicy(key)
        {
           var str;
           var urlstr=tsd.buildParams({  
							packgname:'service',		//java包
							clsname:'AskConstant',		//类名
							method:'askConstantTable',	//方法名
							identity:'FINAL.CallPayType',	//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							pattern:'select',			//访问方式 select：查询常量表信息，update：更新常量表信息
							argument:'callpaytype:'+tsd.encodeURIComponent(key)				//对常量表的过滤条件
			 				});		
				$.ajax({
					url:'mainServlet.html?'+urlstr,					
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
							$(xml).find('row').each(function(){
		                 			str=$(this).attr("typename");
							});	
					}
				});
			return str;	
        }
        
        /*******
        *生成滞纳金标志下拉框  
        *@param
        *@return
        ********/     
        function getZNJLogo(key)
        {
          var str;
           var urlstr=tsd.buildParams({  
							packgname:'service',		//java包
							clsname:'AskConstant',		//类名
							method:'askConstantTable',	//方法名
							identity:'FINAL.ZnjBz',	//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							pattern:'select',			//访问方式 select：查询常量表信息，update：更新常量表信息
							argument:'znjbz:'+tsd.encodeURIComponent(key)					//对常量表的过滤条件
			 				});
				$.ajax({
					url:'mainServlet.html?'+urlstr,					
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
							$(xml).find('row').each(function(){
		                 			str=$(this).attr("bz");
							});							
					}
				});
			return str;	
        } 
	</script>
  <body>
    <div id="navBar">
			<img src="style/icon/dot11.gif" />
			<fmt:message key="global.location" />:
		</div>
		<div id="input-Unit">
				<div id="inputtext">
					<table id="kdBar" style="margin-left: 10px;" cellspacing="10px">
						<tr>
							<td>
								查询方式
								<select id="ghSearchWay" style="width: 100px;" >
									<option value="0">
										电话
									</option>
									<option value="1">
										用户名
									</option>
									<option value="2">
										用户地址
									</option>
								</select>
							</td>
							<td>
								<input type="text" class="" id="ghSearchBox" name="ghSearchBox" />
							</td>
							<td>
								<button class="tsdbutton" id="submitButton" onclick="ghSearch()" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
									查找
								</button>
							</td>
							<td width="290"></td>
						</tr>
					</table>
				</div>
			</div>	
	<!-- Tabs -->
	<div id="tabs">	
		<ul>
			<li><a href="#gridd" onclick="tabsChg('yhdang','HX')"><span>用户信息</span></a></li>
			<li><a href="#gridd" onclick="tabsChg('hthdang','HX')"><span>合同号信息</span></a></li>
			<li><a href="#gridd" onclick="getGrid('jiaofei','Jfshj')"><span>缴费信息</span></a></li> 
			<li><a href="#gridd" onclick="getGrid('teljob','sgrq')"><span>业务变更内容</span></a></li>
			<li><a href="#gridd" onclick="getGrid('hfintime','opertime')"><span>电话套餐</span></a></li>
			<li><a href="#gridd" onclick="getGrid('attachfee','opertime')"><span>电话固定费</span></a></li>
			<li><a href="#gridd" onclick="getGrid('insteadoffee','opertime')"><span>代缴信息</span></a></li>
			<li><a href="#gridd" onclick="getGrid('huizong','hzyf')"><span>电话账单</span></a></li>
			<li><a href="#gridd" onclick="getGrid('hthhf','hzyf')"><span>合同号账单</span></a></li>
		</ul>
		<div id="gridd">
		    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>			
		</div>
	</div>
	<input type="hidden" id="languageType" value="<%=languageType%>" />
	<input type="hidden" id="fieldvalue" />
	<input type="hidden" id="querydh"/>
	<input type="hidden" id="queryhth"/>
	<input type="hidden" id="widthlength"/>
	<div class="neirong" id="multiSearch"
			style="display: none; overflow-x: hidden;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							电话用户信息查询
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;"
							onclick="javascript:$('#kdMultiSearchClose').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd"
				style="background-color: #FFFFFF; text-align: left;">
				<div id="grid" style="margin-top: 0px;"></div>
			</div>
			<div class="midd_butt" style="width: 100%;">
				<button type="button" class="tsdbutton" id="kdMultiSearchClose">
					关闭
				</button>
			</div>
		</div>
		<!-- 2012-09-21 chenjianliang start -->
		<!-- 用户查询面板国际化标签引入 -->
		<jsp:include page="../business/phone_internet.jsp"  flush="true" />	
		<!-- 2012-09-21 chenjianliang start -->
  </body>
</html>
