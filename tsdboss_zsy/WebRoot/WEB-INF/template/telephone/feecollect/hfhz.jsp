<%----------------------------------------
	name: hfhz.jsp 
	author: 孙琳
	version: 1.0, 2010-11-04
	description: 话费汇总
	modify: 
			2010-12-13  liwen   去掉汇总时调试打印语句
			2010-12-14  chenze  修改扣费调用方式，增加等待状态
			2011-02-27  cz      修改扣费调用方式，去除callpaytype等无用参数
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>    
	<title><!-- 收费结帐 --><fmt:message key="Revenue.chargeCheckout" /></title>
	
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>				
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
		<!-- 分项卡 -->
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css"
			type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css"
			type="text/css" media="projection, screen" />
		
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
		<script src="script/public/datalength.js" type="text/javascript"></script>
		<!-- 菜单样式 -->
		<link rel="stylesheet" href="style/css/telephone/usermanagement/single_thirteen.css" type="text/css" />
		
		<script language="javascript">
		
		/**
		 * 初始化
		 * @param 无参数
		 * @return 无返回值
		 */
		$(function(){
			$("#navBar").append(genNavv());
			gobackInNavbar("navBar");
			$("#queryparam td:even").css({"background-color":"#c9d4ea","text-align":"right","padding-right":"1em"});
			fetchHzyf();//loadPopup();
			//fetchNetname();
			fetchYhlb();
		});
		/**
		 * 初始化汇总月份
		 * @param 无参数
		 * @return 无返回值
		 */
		function fetchHzyf()
		{
			var res = fetchMultiValue("hfhz.newhzyf",6,"");
			$.each(res,function(i,n){
				$("#hzyf").append("<option>" + n + "</option>");
			});
		}
		
		/**
		 * 初始化用户类别
		 * @param 无参数
		 * @return 无返回值
		 */
		function fetchYhlb()
		{
			
			var isyhlb = fetchMultiValue("isyhlb",6,"","oracle_hz");
			if(isyhlb =="Y"){
				var res = fetchMultiArrayValue("hfhz.yhlb",6,"");
				var yhlb_cb = "";
				$.each(res,function(i,n){
					yhlb_cb += "<label><input name='yhlb' disabled='disabled' type='checkbox' value='"+n[0]+"' />"+n[1]+" </label>";
				});
				$("#yhlb").append(yhlb_cb);
			}else{
				$("#isyhlb td").html("");
			}
		}
		
		/**
		 * 初始化计费网名
		 * @param 无参数
		 * @return 无返回值
		 */
		function fetchNetname()
		{
			var res = fetchMultiValue("Hfhz.netName",6,"");
			$("#netname").append("<option value=\"\">---<fmt:message key='global.select' />---</option>");
			$.each(res,function(i,n){
				$("#netname").append("<option value=\"" + n + "\">" + n + "</option>");
			});
		}
		/**
		 * 汇总指定条件的记录
		 * @param 无参数
		 * @return 无返回值
		 */
		function executeHz()
		{
			
			
			dateNow = fetchSingleValue("hfhz.now",6,"");
			//hfhz.Hz
			var Hzyf = $("#hzyf").val();
			
			var params = "&Hzyf="+Hzyf;
			
			
			//判断汇总类型
			var hzType = $("input[name='chargeType']:checked").val();
			var HthLimit = "(";
			// 0：按合同号  1：按用户性质
			if(hzType == 0){
				var hthl = $("#hth").val();
				if($.trim(hthl)!=""){
					hthl = hthl.replace(/\n+/g,",").replace(/\s/g,'');
					hthl = "'" + hthl.replace(/,/g,"','") + "'";
					HthLimit += hthl + ")";
				}
			}else{
				var Yhlb = "(" ;
				//取用户性质
				$("input[name='yhlb']").each(function(){ 
					if($(this).attr("checked")){
						Yhlb += "'";
						Yhlb += $(this).val();
						Yhlb += "'";
						Yhlb += ",";
	                }
					
				});
				Yhlb = Yhlb.substring(0, Yhlb.lastIndexOf(","));
				if(Yhlb =="" || Yhlb == null){
					Yhlb = "(" ;
					$("input[name='yhlb']").each(function(){
						Yhlb += "'";
						Yhlb += $(this).val();
						Yhlb += "'";
						Yhlb += ",";
					});
					Yhlb = Yhlb.substring(0, Yhlb.lastIndexOf(","));
				}
				
				Yhlb +=  ")";
					
					
				params += "&Yhlb="+Yhlb;
				
			}
			if(HthLimit!="("){
				params += "&HthLimit="+HthLimit;
			}
			
			params += "&UserID="+"${userid}";
			
			//alert(params);
			var status_succ = false;
			hz_success_falg = 0;
			refreshOntimeInfo();
			loadPopup();
			
			var isjava = fetchMultiValue("isjava",6,"","oracle_hz");
			var url = "";
			//新汇总流程 donglei 2015-10-14
			if(isjava =="Y"){
				url = "hzServlet.html?" + params;
			}else{
				var urll = tsd.buildParams({ packgname:'service',
					clsname:'Procedure',//类名
					method:'exequery',//方法名
					ds:'tsdBilling',
					tsdExeType:'query',//操作类型 
					datatype:'xmlattr',//返回数据格式 
					tsdpname:'hfhz.Hz'
				});
				url = "mainServlet.html?" + urll + params;
			}
			//alert(url);
			$.ajax({
				url:url,
				async:true,
				cache:false,
				timeout:6000000,
				type:'post',
				success:function(result){
					if(isjava =="Y"){
						
						if(result=="success"){						
							status_succ = true;
							alert("汇总成功！");
						}else{
							alert("汇总失败！");
						}
					}else{
						var res = $("row:first",result).attr("res");
						var tag = $("row:first",result).attr("tag");
						if(res=="SUCCEED"){						
							status_succ = true;
						}
						alert(tag);
					}
					disablePopup();
					// 清空日志显示div
					var info = fetchMultiValue("hfhz.log",6,"&lgproc=hfhz&userid=" + tsd.encodeURIComponent(UserID) + "&begindate=" + encodeURIComponent(dateNow));
					if(info[0]!=undefined)
					{
						$("#hzinfo").val(info.join("\n"));
					}
					hz_success_falg = 1;
				},
				complete:function(xhr,status)
				{
					if(!status_succ)
						alert("<fmt:message key='syswarn.gatherfail' />");
					
					disablePopup();
					var info = fetchMultiValue("hfhz.log",6,"&lgproc=hfhz&userid=" + tsd.encodeURIComponent(UserID) + "&begindate=" + encodeURIComponent(dateNow));
					if(info[0]!=undefined)
					{
						$("#hzinfo").val(info.join("\n"));
					}
					hz_success_falg = 1;
				}
			});
			
			
			/* 老的汇总流程*/ 
			/*
			var urll = tsd.buildParams({ packgname:'service',
						clsname:'Procedure',//类名
						method:'exequery',//方法名
						ds:'tsdBilling',
						tsdExeType:'query',//操作类型 
						datatype:'xmlattr',//返回数据格式 
						tsdpname:'hfhz.Hz'
				});
			
			//执行发布请求，成功之后调用initResultInfo()方法显示结果
			
			$.ajax({
				url:"mainServlet.html?" + urll + params,
				async:true,
				cache:false,
				timeout:6000000,
				type:'post',
				success:function(xml){
					
					var res = $("row:first",xml).attr("res");
					var tag = $("row:first",xml).attr("tag");
					if(res=="SUCCEED"){						
						status_succ = true;
						alert(tag);
					}else{
						alert(tag);
					}
					
					disablePopup();
					var info = fetchMultiValue("hfhz.log",6,"&lgproc=hfhz&userid=" + tsd.encodeURIComponent(UserID) + "&begindate=" + encodeURIComponent(dateNow));
					if(info[0]!=undefined)
					{
						$("#hzinfo").val(info.join("\n"));
					}
					hz_success_falg = 1;
				},
				complete:function(xhr,status)
				{
					if(!status_succ)
						alert("<fmt:message key='syswarn.gatherfail' />");
					
					disablePopup();
					var info = fetchMultiValue("hfhz.log",6,"&lgproc=hfhz&userid=" + tsd.encodeURIComponent(UserID) + "&begindate=" + encodeURIComponent(dateNow));
					if(info[0]!=undefined)
					{
						$("#hzinfo").val(info.join("\n"));
					}
					hz_success_falg = 1;
				}
			});
			
			*/
		}
		/**
		 * 汇总按钮
		 * @param 无参数
		 * @return 无返回值
		 */
		function Hz()
		{
			//if(confirm("<fmt:message key='Hfhz.sureToHz' />？"))
			//{
				//if(confirm("你确定要汇总指定条件的记录吗？"))
			if(confirm("<fmt:message key='Hfhz.sureToHz' />？"))
			{	
				//showWait();
				executeHz();//alert("OK");					
				//hideWait();
			}
			//}
		}
		//汇总成功标志
		var hz_success_falg = 0;
		var UserID = "<%=session.getAttribute("userid") %>";
		var dateNow = fetchSingleValue("hfhz.now",6,"");
		/**
		  取实时汇总日志
		*/
		function refreshOntimeInfo()
		{
			var urlMm = tsd.buildParams({ packgname:'service',
					clsname:'ExecuteSql',//类名
					method:'exeSqlData',//方法名
					ds:"tsdCharge",
					tsdcf:'mssql',//指向配置文件名称
					tsdoper:'query',//操作类型 
					datatype:'xmlattr',//返回数据格式 
					tsdpk:'hfhz.log'
			});
			//执行发布请求，成功之后调用initResultInfo()方法显示结果
			$.ajax({
				url:"mainServlet.html?" + urlMm + "&lgproc=hfhz&userid=" + tsd.encodeURIComponent(UserID) + "&begindate=" + encodeURIComponent(dateNow),
				async:true,
				cache:false,
				timeout:6000000,
				type:'post',
				success:function(xml){
					var infoo = "";
					$(xml).find("row").each(function(){
						if($(this).attr("info")!=undefined)
							infoo += $(this).attr("info") + "<br />";
					});
					$("#ontimehzinfo").html(infoo);
				},
				complete:function(){
					if(hz_success_falg==0)
						setTimeout("refreshOntimeInfo()",2000);
				}
			});
		}
		/**
		 * 显示等待
		 * @param 无参数
		 * @return 无返回值
		 */
		function showWait()
		{
			$("#loading").css("display","block");//loadPopup();
		}
		/**
		 * 隐藏等待
		 * @param 无参数
		 * @return 无返回值
		 */
		function hideWait()
		{
			$("#loading").css("display","none");//disablePopup();
		}
		/**
		 * 弹窗
		 * @param 无参数
		 * @return 无返回值
		 */
		var popupStatus = 0;
		function loadPopup(){
			centerPopup();
			//loads popup only if it is disabled
			if(popupStatus==0){
				$("#backgroundPopup").css({
					"opacity": "0.7"
				});
				$("#backgroundPopup").css("display","block");
				$("#loading").css("display","block");
				popupStatus = 1;
			}
		}
		/**
		 * disablePopup
		 * @param 无参数
		 * @return 无返回值
		 */
		function disablePopup(){
			//disables popup only if it is enabled
			if(popupStatus==1){
				$("#backgroundPopup").fadeOut("slow");
				$("#loading").fadeOut("slow");
				popupStatus = 0;
			}
		}
		/**
		 * centering popup
		 * @param 无参数
		 * @return 无返回值
		 */
		function centerPopup(){
			//request data for centering
			var windowWidth = document.documentElement.clientWidth;
			var windowHeight = document.documentElement.clientHeight;
			var popupHeight = $("#loading").height();
			var popupWidth = $("#loading").width();
			//centering
			$("#loading").css({
				"position": "absolute",
				"top": windowHeight/2-popupHeight/2,
				"left": windowWidth/2-popupWidth/2
			});
			//only need force for IE6
			
			$("#backgroundPopup").css({
				"height": windowHeight
			});			
		}	
		
		function clearall(){
			
			$("#hth").val("");
			$("#hzinfo").val("");
		
		}
		
		function changeChargeType(){
			var chargeType = $("input[name='chargeType']:checked").val();
			if(chargeType == 0){
				$("#yhlb").find("*").attr("disabled","disabled");
				$("#hth").attr("disabled","");
			}else{
				$("#yhlb").find("*").removeAttr("disabled");
				$("#hth").attr("disabled","true");
			}
		}
		</script>
		<style type="text/css">
			#loading{
				display:none;
				position:fixed;
				_position:absolute; /* hack for internet explorer 6*/
				height:300px;
				width:608px;
				text-align:center;
				background:#FFFFFF;
				border:2px solid #cecece;
				z-index:2;
				padding:12px;
				font-size:13px;
				overflow-y:auto;
			}
			#backgroundPopup{
				display:none;
				position:fixed;
				_position:absolute; /* hack for internet explorer 6*/
				height:100%;
				width:100%;
				top:0;
				left:0;
				background:#ffffff;
				border:1px solid #cecece;
				z-index:1;
			}
			.tsdbutton{margin:2px;padding:0px 10px 5px 10px;height:24px;line-height:24px;margin-bottom:-2px;}
			.tsdbtn{line-height:28px;padding:2px 12px 2px 12px;  height:28px; margin-top:4px; margin-left:5px; background: url(style/imgs/buttonbg.jpg) repeat-x; border: #CCCCCC 1px solid; cursor: pointer; }
			.inputbox{{margin-left:2px; background:url(style/imgs/inputText_bg.jpg) repeat-x ; width:180px; border:#999999 solid 1px;  text-align:left; color:#000000; font-size:12px; font-weight:bold; height:22px; line-height: 23px; }}
			#queryparam{border:#7691c7 1px solid;width:560px;margin-left:auto;margin-right:auto;margin-top:60px;}
			#queryparam td{line-height:28px;border:#7691c7 1px solid;}
			#hzyf,#ptype_rd_commonuser,#ptype_rd_biguser{margin-left:2px;}
			#feedetailcontainer{width:600px;margin:auto;}
			#feedetailcontainer{margin-left:20px;}
			.feedetail{border:#7691c7 0px solid;width:560px;margin-left:auto;margin-right:auto;margin-top:20px;}
			.feedetail td{line-height:28px;border:#7691c7 0px solid;}
		</style>
  </head>
  
  <body style="overflow-y:hidden;">
	<input type="hidden" name="skrid" id="skrid" value="<%=session.getAttribute("userid") %>"/>
  
	<div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:
	</div>
	
	<table id="queryparam">
		<tr>
			<td width="25%">汇总月份</td>
			<td>
				<select name="hzyf" id="hzyf" style="width: 200px;margin-top: 5px;margin-bottom: 5px;">
				</select>
				<button id="hz" name="hz" class="tsdbutton" onclick="Hz()" style="margin-left: 20px;margin-top: 5px;margin-bottom: 5px;"><fmt:message key='Hfhz.summary' /></button>
				<button class="tsdbutton" onclick="clearall();" style="margin-right: 20px;margin-top: 5px;margin-bottom: 5px;">清空</button>
			</td>
		</tr>
		
		<tr id="isyhlb">
			<td width="25%"><label for="chargeType1"><input type="radio" id="chargeType1" name="chargeType" value="1" onclick="changeChargeType();"/>按用户类别</label></td>
			<td>
				<span id="yhlb" ><!-- <label><input name="yhlb" type="checkbox" value="办公用户" />办公用户 </label><label><input name="yhlb" type="checkbox" value="私人用户 " />私人用户 </label> --></span>
			</td>
		</tr>
		<tr>
			<td width="25%"><label for="chargeType2"><input type="radio" id="chargeType2" name="chargeType" checked value="0" onclick="changeChargeType();"/>按合同号</label> </td>
			<td>
				<textarea name="hth" id="hth" class="inputbox" style="width:200px;height:150px;"></textarea>
				<font color="red">(可指定多合同号,每个合同号一行)</font>
			</td>
		</tr>
		<tr>
			<td width="25%"><fmt:message key="hfhz.gatherlog" /></td>
			<td>
				<textarea name="hzinfo" id="hzinfo" class="inputbox" style="width:412px;height:200px;overflow-y:auto" readonly="readonly"></textarea>
			</td>
		</tr>
	</table>
	
	
	

	<fieldset style="border:1px solid #cccccc;margin-left:200px;margin-right:200px;margin-top:100px;display: none;">
		<legend style="font-size:14px;"><fmt:message key="hfhz.feegather" /></legend>
	    <table width="660" style="margin-left:auto;margin-right:auto;margin-top:30px;font-size:14px;">
	    	<tr>
	    		<td width="320">
		    		<table>
			    		<tr>
					    	<td width="320">			    		
							    <!-- 汇总月份 --><b><fmt:message key='Hfhz.summaryMonth' /></b>：
						    </td>
						</tr>
						<tr>							
						    <td>
							    <select id="hzyf1" style="width:160px"></select>
							</td>
						</tr>
						<tr>							    
					    	<td width="320">
					    		<!-- 仅针对以下合同号汇总（每个合同号一行） --><fmt:message key="hfhz.componynumber" />
					    		<br />
				    			<textarea name="hth1" id="hth1" style="width:220px;height:220px;"></textarea>
					    	</td>
				    	</tr>
			    	</table>
		    	</td>
		    	<td width="320">
		    		<fmt:message key="hfhz.gatherlog" />
		    		<br />
	    			<textarea name="hzinfo1" id="hzinfo1" style="width:280px;height:240px;overflow-y:auto" readonly="readonly"></textarea>
		    	</td>
		    </tr>
		    <tr>
			    <td colspan="2" style="text-align:center;">
			    	<button id="hz" name="hz" class="tsdbutton" onclick="Hz()" style="width:80px;"><!-- 汇总 --><fmt:message key='Hfhz.summary' /></button>
			    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    	</td>
		    	
		    </tr>
	    </table>
	
    </fieldset>

  <div id="loading">
		<div style="height:40px"></div>
		<img src="style/images/public/loading.gif" />
		<br />
		<!-- 正在汇总，请稍候 --><fmt:message key='Hfhz.wait' />……
		<br />
		<div id="ontimehzinfo" style="border-top:1px solid #ccc;heigth:200px;overflow-y:auto;">
		</div>
  </div>
  <div id="backgroundPopup"></div>
  </body>
</html>
