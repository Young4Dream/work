<%----------------------------------------
	name: gfrevenue.jsp 
	author: cz
	version: 1.0, 2011-03-28
	description: 公费账户缴费
	modify: 
			
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>    
	<title>公费电话明细打印</title>
	
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
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen" />
		
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
		$(function(){
			$("#navBar").append(genNavv());
			gobackInNavbar("navBar");
			fetchHzyf();
			fetchMokuaiju();
			setUserRight();
			fetchPaytype();
			$("#ghZq").change(function(){
				$("#ghHth").select().focus();
			});
			
			Dat = loadData("vw_gfdhjiaofei","<%=languageType%>",2);
			loadHths('~','~');
			
			ghexecuteDelete();
			$(window).unload(function(){
				ghexecuteDelete();
			});
		});
		
		var Dat = ""; // jqGrid表格使用
		
		function fetchHzyf()
		{
			var res = fetchMultiValue("ghdhdetail.hzyf",6,"");
			var optHtml = "";
			for(var ii=0;ii<res.length;ii++)
			{
				optHtml += "<option value=\"" + res[ii] + "\">" + res[ii] + "</option>";
			}
			$("#ghZq").html(optHtml);
			var curhzyf = fetchSingleValue("ghdhdetail.nowmonth",6,"");
			if(curhzyf!="")
			{
				$("#ghZq").val(curhzyf);
			}
		}
		
		function fetchMokuaiju()
		{
			var res = fetchMultiArrayValue("gfdhjiaofei.mokuaiju",6,"");
			var optHtml = "";
			if(res[0]!=undefined && res[0][0]!=undefined)
			{
				for(var ii=0;ii<res.length;ii++)
				{
					optHtml += "<option value=\"" + res[ii][1] + "\">" + res[ii][0] + "</option>";
				}
				$("#ghMokuaiju").html(optHtml);
			}			
		}
		
		function fetchPaytype()
		{
			var res = fetchMultiArrayValue("gfdhjiaofei.paytype",6,"");
			var optHtml = "";
			if(res[0]!=undefined && res[0][0]!=undefined)
			{
				for(var ii=0;ii<res.length;ii++)
				{
					optHtml += "<option value=\"" + res[ii][1] + "\">" + res[ii][0] + "</option>";
				}
				$("#ghFFFs").html(optHtml);
				$("#ghFFFs").val("transfer");
			}			
		}
		
		function loadHths(hZyf,mokuaiju)
		{
			$("#container").html("<table id=\"maingrid\" class=\"scroll\"></table><div style=\"text-align:left\" id=\"maingridpager\" class=\"scroll\"></div>");
						
			var urlstr=tsd.buildParams({packgname:'service',//java包
										clsname:'ExecuteSql',//类名
										method:'exeSqlData',//方法名
										ds:'tsdCharge',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdcf:'mssql',//指向配置文件名称
										tsdoper:'query',//操作类型 
										datatype:'xml',//返回数据格式 
										tsdpk:'gfdhjiaofei.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										tsdpkpagesql:'gfdhjiaofei.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});

			$("#maingrid").jqGrid({
					url:'mainServlet.html?'+urlstr + "&cols=" + Dat.FieldName.join(",") + "&mokuaiju=" + encodeURIComponent(mokuaiju) + "&hzyf=" + encodeURIComponent(hZyf),
					datatype: 'xml', 
					colNames:Dat.colNames, 
					colModel:Dat.colModels, 
					       	rowNum:100, //默认分页行数
					       	multiselect:true,
					       	rowList:[30,50,100,1000], //可选分页行数
					       	useDefault:true,
					       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
					       	pager: jQuery('#maingridpager'), 
					       	sortname: 'Pay_Flag', //默认排序字段
					       	viewrecords: true, 
					       	sortorder: 'asc',//默认排序方式 
					       	caption:'合同号列表',//"宽带业务流水", 
					       	height:320, //高
					       	width:document.documentElement.clientWidth-57,
					       	loadComplete:function(){
					       		$("#maingrid").find("tr").each(function(){
					       			if($(this).find("td:last").text()=="已缴费")
					       			{
					       				$(":checkbox",this).attr("disabled","disabled");
					       				$(this).css("color","gray");
					       			}
					       		});
					       		//alert($("#maingrid").html());
							},onSelectRow:function(idx){
								if($("#jqg_" + idx).attr("disabled")==true)
									$("#maingrid").setSelection(idx,false);
							},onSelectAll:function(selrows,chk){
								if(chk)
								{
									var tmparr = [];
									for(var kl=0;kl<selrows.length;kl++)
										tmparr.push(selrows[kl]);
									
									for(var iok=0;iok<tmparr.length;iok++)
									{
										if($("#jqg_" + tmparr[iok]).attr("disabled")==true)
										{
											$("#maingrid").setSelection(tmparr[iok],false);
										}
									}
								}
							}
					}).navGrid('#maingridpager', {edit: false, add: false, add: false, del: false, search: false}, //options 
						{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
						{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
						{reloadAfterSubmit:false}, // del options 
						{} // search options 
						); 
		}
		
		function ghSearch()
		{
			loadHths($("#ghZq").val(),$("#ghMokuaiju").val());
		}
		
		function ghCalYjf()
		{
			var area = $("#area").val();
			var skrid = $("#skrid").val();			
			//缴费月份
			var sjm = $("#ghZq").val();
			//
			var resss = fetchMultiPValue("revenue.HFYS_Cacul_Yjf",1,"&SkrID="+skrid+"&Sj_SfMonth="+sjm+"&sSkfs="+tsd.encodeURIComponent($("#ghFFFs").val())+"&Area="+tsd.encodeURIComponent(area)+"&Kemu=" + tsd.encodeURIComponent("电话费")+"&Version=200501");
			
			if(resss[0]!=undefined||resss[0][3]!=undefined)
			{
				if(resss[0][3]=='')
				{
					var yjff = parseFloat(resss[0][0],10);
					if(isNaN(yjff)) yjff = "0.00";
					//余额提示
					var ssye = parseFloat(resss[0][1],10);
					if(isNaN(ssye)) ssye = "0.00";
					else ssye = ssye.toFixed(2);
					if(yjff<=0)
					{
						alert("当前选择账户"+$("#container").data("hths")+"无需缴费");
						return false;	
					}
					else
					{
						//alert(yjff);
						$("#container").data("yjf",yjff);
						return true;
					}					
				}
				else
				{
					alert(resss[0][3]);
					return false;
				}
			}
			else
			{
				alert("未知错误！");
				$("#ghSearchBox").select().focus();
				return false;
			}
		}
		
		function ghCheckHth()
		{
			var area = $("#area").val();
			var skrid = $("#skrid").val();
			var hthsel = $("#maingrid").getGridParam("selarrrow");
			if(hthsel.length==0)
			{
				alert("请选择要缴费的合同号");
				return;
			}
			var tval = [];
			for(var ii=0;ii<hthsel.length;ii++)
			{
				var tmp = $("#maingrid").getCell(hthsel[ii],"HTH");
				if(null==tmp)
				{
					alert("没有可缴费的合同号");
					return;
				}
				tval.push(tmp);
			}
			
			var dhNum = tval.join(",");
			
			tsd.QualifiedVal=true;
			var param = "&Area=";
			param += tsd.encodeURIComponent(area);
			param += "&SkrID=";
			param += tsd.encodeURIComponent(skrid);
			param += "&Hth=";
			param += tsd.encodeURIComponent(dhNum);
			param += "&Version=200404";
			if(tsd.Qualified()==false){return false;}
			
			res = fetchMultiPValue("revenue.HFYS_Check_Hth",1,param);
			if(res[0]!=undefined && res[0][0]!=undefined && res[0][0] == "")
			{				
				//记录电话号码
				$("#container").data("hths",dhNum);				
				return true;
			}
			else
			{
				alert(res[0][0]==undefined?"当前输入账号无法缴费，请联系管理人员":res[0][0]);
				return false;
			}
		}
		
		function ghJiaoFei()
		{
			//电话缴费实收金额
			var ghss = $("#container").data("yjf");
			var res = fetchMultiPValue("revenue.JiaoFei",1,"&Version=200404&Kemu="+tsd.encodeURIComponent("电话费")+"&Bcss=" + ghss + "&Bcss_gdf=0&SkrID="+$("#skrid").val() + "&Skfs=" + tsd.encodeURIComponent($.trim($("#ghFFFs").val())));
			
			if(res=="")
			{
				//alert("jiaofei suc");
				return true;
			}
			else
			{
				alert("缴费失败:"+res);
				return false;
			}
		}
		//缴费确认
		function ghJiaoFeiSuccess()
		{
			//电话缴费实收金额
			var ghss = $("#container").data("yjf");
			var res = fetchMultiPValue("revenue.JiaoFeiChengGong",1,"&Version=200404&Kemu="+tsd.encodeURIComponent("电话费")+"&Bcss=" + ghss + "&SkrID="+$("#skrid").val() + "&Skfs=" + tsd.encodeURIComponent($.trim($("#ghFFFs").val())));
			if(res[0][0]==""||res[0][0]=="SUCCEED")
			{
				return true;
			}
			else
			{
				if(res[0][1]!=undefined)
				{
					alert(getretdescript("Hfys_Bill_Ok",res[0][1],"","",$("#lanType").val()));
				}
				return false;
			}
		}
		
		function ghPay()
		{
			if(ghCheckHth() && ghCalYjf())
			{
				//return false;
				if(confirm("你确定要对账户 " + $("#container").data("hths") + " 进行缴费么？应缴费用金额 " + $("#container").data("yjf") + " 元"))
				{
					if(ghJiaoFei() && ghJiaoFeiSuccess())
					{
						alert("缴费成功");
						printThisReport1('<%=request.getParameter("imenuid")%>',
							"ghdhmx","&skrid=" + $("#skrid").val(),
							'<%=(String)session.getAttribute("userid")%>',
							'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
							'<%=(String)session.getAttribute("departname")%>',1);
					}
				}
			}
		}
		
		/////删除当前登录用户的**信息
		function ghexecuteDelete()
		{
			executeNoQuery('revenue.del1',1,"&skrid=" + $("#skrid").val());
			executeNoQuery('revenue.del2',1,"&skrid=" + $("#skrid").val());
			executeNoQuery('revenue.del3',1,"&skrid=" + $("#skrid").val());
		}
		
		///设置权限
		function setUserRight()
		{
			var allRi = fetchMultiPValue("Duty.getPower",6,"&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
			if(typeof allRi == 'undefined' || allRi.length == 0)
			{
				//alert("取权限失败");
				$("#ableForOtherArea").val("false");
				var area = $("#area").val();
				
				$("#ghMokuaiju").val(area);
				$("#ghMokuaiju").attr("disabled","disabled");
				return false;
			}
			if(allRi[0][0]=="all")
			{
				$("#ableForOtherArea").val('true');	
				return true;
			}
			var ableForOtherArea = "false";
			
			for(var i = 0;i<allRi.length;i++){
				if(getCaption(allRi[i][0],'ableForOtherArea','')=="true")
					ableForOtherArea = 'true';	
			}
			/*if(ableForOtherArea=="true")
				$("#tj_way_st").css("display","inline");
			*/	
			if(ableForOtherArea=="true")
			{
				
			}
			else
			{
				var area = $("#area").val();
				if(area.indexOf("-")>-1)
				{
					area = area.substring(2,area.length);alert(area);
				}
				$("#ghMokuaiju").val(area);
				$("#ghMokuaiju").attr("disabled","disabled");
			}
			$("#ableForOtherArea").val(ableForOtherArea);
		}
		
		</script>
		<style type="text/css">
		.tsdbutton{margin:2px;padding:2px 18px 2px 18px;height:24px;}
		.tsdbtn{line-height:28px;padding:2px 12px 2px 12px;  height:28px; margin-top:4px; margin-left:5px; background: url(style/imgs/buttonbg.jpg) repeat-x; border: #CCCCCC 1px solid; cursor: pointer; }
		.inputbox{{margin-left:10px; background:url(style/imgs/inputText_bg.jpg) repeat-x ; width:180px; border:#999999 solid 1px;  text-align:left; color:#000000; font-size:12px; font-weight:bold; height:22px; line-height: 23px; }}
			
		</style>
  </head>
  
  <body>
    
	<div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:
	</div>
		账期：<select id="ghZq"><option>账期</option></select>
		通信站：<select id="ghMokuaiju" style="width:120px"><option>通信站</option></select>
		<button class="tsdbutton" id="searchByHth" onclick="ghSearch()" style="margin-bottom:0px">查找</button>
		收费方式：<select id="ghFFFs"><option>收费方式</option></select>
	<br />
	<div id="container">
		<table id="maingrid" class="scroll"></table>
		<table id="maingridpager" class="scroll"></table>
	</div>
	<button class="tsdbutton" id="searchByHth" onclick="ghPay()" style="margin-bottom:0px">缴费并打印收费发票</button>
	
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea")%>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea")%>' />
	<input type="hidden" id="skrid" name="skrid" value='<%=session.getAttribute("userid")%>' />

	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
	
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid%>' />
	<input type="hidden" id="zid" name="zid" value='<%=zid%>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType%>' />
		
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
  </body>
</html>
