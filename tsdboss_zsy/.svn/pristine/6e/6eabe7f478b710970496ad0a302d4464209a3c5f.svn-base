<%----------------------------------------
	name: broadband/charge/feeAdjust.jsp
	Function: 电话，宽带 费用调整
	author: chenze
	version: 1.0, 2010-11-8
	description:  
	modify: 
		2010-11-08  chenze  添加电话费用调整
		2010-11-16  chenze  修改 电话费用调整成功之后查询实时余额
		2010-11-25  chenze  修改 选项卡标题
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
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>    
	<title><!-- 收费结帐 --><fmt:message key="Revenue.chargeCheckout" /></title>
	<!-- 导入的js文件 -->
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
	<script src="script/public/mainStyle.js" type="text/javascript"></script>
	<script src="style/js/mainStyle.js" type="text/javascript"></script>
	<!-- 弹出对话框需要导入的js文件 -->
	<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
	<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
	<!-- tab滑动门需要导入的包 *注意路径 -->
	<script src="plug-in/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
	<script src="plug-in/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<!-- tab滑动门 需要导入的样式表 *注意路径-->
	<script type="text/javascript" src="css/tree/dtree.js"></script>
	<!-- 弹出面板需要导入js文件 -->
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
	<!-- 关于字符串需要用到的js -->
	<script type="text/javascript" src="script/public/main.js"></script>
	<!-- 收费结账专用js -->
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
<!-- 导入js文件结束 -->
<!-- 导入css文件开始 -->
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
	<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
	<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs-ie.css"	type="text/css" media="projection, screen" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	
	<link rel="stylesheet" type="text/css" href="css/tree/dtree.css" />
<!-- 导入css文件结束 -->
		<script>
			var Clerks = "";
			var Sys_Config = "";
			/**
			 * 页面加载时执行
			 * @param
			 * @return
			 */
			$(function(){
				$("#navBar").append(genNavv());		
				gobackInNavbar("navBar");
				$("#tabs").tabs();
				
				//初始化营业员信息
				Clerks = fetchMultiKVValue("Duty.fetchUserId",6,"",["userid","username"]);
		
				Sys_Config = fetchMultiKVValue("Duty.sysConfig",6,"",["tsection","tvalues"]);
				var dhPayForbid = fetchSingleValue("Duty.sysDhPayConfig",6,"");
				//如果设置有禁止电话缴费，则同时禁用电话功能
				if(dhPayForbid=="Y")
					Sys_Config["Phone"] = "Y";
				
				if(Sys_Config["Phone"]=="Y" || Sys_Config["Broadband"]=="Y")
				{
					$("#tabs ul").hide();
					if(Sys_Config["Broadband"]=="Y")
					{
						$("#gridkd").hide();$("#griddh").show();$("#ghSearchBox").select().focus();//$("#tabs ul li:eq(1) a").click();  //tabsChg(2);
					}
					else
					{	$("#griddh").hide();$("#gridkd").show();$("#kdSearchBox").select().focus(); //$("#tabs ul li:eq(0) a").click();  //tabsChg(1);
					}
				}
				else
					$("#kdSearchBox").select().focus();
				initDqsfy();
				loadKF('~');
				initDhTzyf('~');
				loadDhKF('~');
				
				$("#kdSearchBox").keydown(function(event){
					if(event.keyCode==13)
					{
						$("#searchByUserName").click();
					}
				});
				$("#ghSearchBox").keydown(function(event){
					if(event.keyCode==13)
					{
						$("#searchByDh").click();
					}
				});
				
				$("#adjustFee").keypress(function(event){
					if(event.keyCode==13 && !$("#kdsave").attr("disabled"))
					{
						//$("#kdsave").click();
						//判断调账费
						var afee = $("#adjustFee").val();
						afee = parseFloat(afee,10);
						afee = Math.abs(afee);
						if(afee>0)
						{
							$("#memo").select().focus();
							$("#memo").val('');
						}
						else
						{
							alert("请输入调账金额");
							$("#adjustFee").select().focus();
						}
					}
				});
				////备注框事件
				$("#memo").keypress(function(event){
					if(event.keyCode==13 && !$("#kdsave").attr("disabled"))
					{
						$("#kdsave").click();					
					}
				});
				
				$("#adjustDhFee").keypress(function(event){
					if(event.keyCode==13 && !$("#dhsave").attr("disabled"))
					{
						//判断调账费
						var afee = $("#adjustDhFee").val();
						afee = parseFloat(afee,10);
						afee = Math.abs(afee);
						if(afee>0)
						{
							$("#dhmemo").select().focus();
							$("#dhmemo").val('');
						}
						else
						{
							alert("请输入调账金额");
							$("#adjustDhFee").select().focus();
						}
					}
				});
				////备注框事件
				$("#dhmemo").keypress(function(event){
					if(event.keyCode==13 && !$("#dhsave").attr("disabled"))
					{
						$("#dhsave").click();					
					}
				}).focus(function(){
					if($(this).val()=="请在此处输入备注,必填   ")
						$(this).val("");
					$(this).removeClass("bzcolor");
				}).blur(function(){
					if($.trim($(this).val())=="")
						$(this).val("请在此处输入备注,必填   ").addClass("bzcolor");
				});
				
				$("#adjustDhType").change(function(){
					var dval = $(this).val();
					if(dval=="")
					{
						$("#adjustDhSType").html("<option value=\"1\">合计</option>");
					}
					else
					{
						var sql = "";
						var prefix = ""; 
						if(dval=="call_type_num"){
							sql = "adjustFee.callpaytype";
							prefix = "hf";
						}
						else if(dval=="ye")
						{
							sql = "adjustFee.ye";
							prefix = "";
						}
						else if(dval=="attachprice"){
							sql = "adjustFee.yz";
							prefix = "zfs";
						}
						else{
							sql = "adjustFee.hj";
							prefix = "";	
						}
						var res = fetchMultiArrayValue(sql,6,"");
						var optHtml = "";
						if(res[0]!=undefined || res[0][0]!=undefined)
						{
							for(var jk=0;jk<res.length;jk++)
							{
								optHtml += "<option value=\"" + res[jk][0] + "\">" + res[jk][1] + "</option>";
							}
							$("#adjustDhSType").html(optHtml);
						}
					}
				});
				
				$("#dhAdjustInputType").change(function(){
					var tisval = $(this).val();
					if(tisval=="1")
					{
						$("#dhAdjustInputTypeLabel").text("电话号码");
						$("#ghSearchBox").val("");
						//$("#dhAdjustTJDhDiv").css("display","none");
					}
					else
					{
						$("#dhAdjustInputTypeLabel").text("合同号码");
						$("#ghSearchBox").val("");
						//$("#dhAdjustTJDhDiv").css("display","inline");
					}
				});
			});
			/**
			 * 选项卡切换事件
			 * @param
			 * @return
			 */
			function tabsChg(idx)
			{
				if(idx==1)
					$("#kdSearchBox").select().focus();
				else
					$("#ghSearchBox").select().focus();
			}
			
						
			//公费返回true,否则返回false
			/**
			 * 取用户权限
			 * @param
			 * @return
			 */
			function idGF(UserName)
			{
				var res = fetchSingleValue("feeAdjust.isGF",0,"&UserName="+UserName);
				if(res=="1")
				{
					return true;
				}
				else
				{
					return false;
				}
			}
			/**
			 * 宽带用户查询
			 * @param
			 * @return
			 */
			function kdSearch()
			{
				if($.trim($("#kdSearchBox").val())=="")
				{
					alert("请输入要查询的用户账号");
					$("#kdSearchBox").select();
					$("#kdSearchBox").focus();
					return false;
				}
				else if(idGF($.trim($("#kdSearchBox").val())))
				{
					alert("公费用户，不能调账");
					$("#kdSearchBox").select();
					$("#kdSearchBox").focus();
					return false;
				}
				else
				{
					$("#kdsave").attr("disabled","disabled");
					
					var username = $.trim($("#kdSearchBox").val());
					
					tsd.QualifiedVal=true;
					
					username = tsd.encodeURIComponent(username);
					
					if(tsd.Qualified()==false){$("#kdSearchBox").select();$("#kdSearchBox").focus();return false;}
					
					
					
					var resa = fetchSingleValue("Revenue.queryByIDExtract",0,"&UN="+username);
					if(resa==undefined||resa=="")
					{
						alert("没有找到账号为"+$("#kdSearchBox").val()+"的用户");
						$("#kdSearchBox").select();
						$("#kdSearchBox").focus();
					}
					else
					{
						$("#kfInfoDiv").data("username",$.trim($("#kdSearchBox").val()));
						$("#adjustUN").val($("#kfInfoDiv").data("username"));
						$("#adjustFee").removeAttr("disabled");
						
						loadKF(username);		
						loadTZHistory(username);		
						
					}
				}
			}
			/**
			 * 宽带费用调整
			 * @param
			 * @return
			 */
			function kdAdjust()
			{
				if($.trim($("#adjustFee").val())=="")
				{
					alert("请输入调账金额");
					$("#adjustFee").select();
					$("#adjustFee").focus();
					return false;
				}
				
				var username = $("#kfInfoDiv").data("username");
				var userid = $("#skrid").val();
				var fee = $("#adjustFee").val();
				fee = parseFloat(fee);
				
				if(isNaN(fee))
				{
					alert("请输入正确的金额格式");
					$("#adjustFee").select();
					$("#adjustFee").focus();
					return false;
				}
				
				var memo = $("#memo").val();
				memo = memo.substring(0,500);
				memo = tsd.encodeURIComponent(memo);
				
				var loginfo = tsd.encodeURIComponent("宽带 调账");
				loginfo += ";";
				loginfo += tsd.encodeURIComponent("工号");
				loginfo += ":";
				loginfo += userid;
				loginfo += ";";
				loginfo += tsd.encodeURIComponent("账号");
				loginfo += ":";
				loginfo += username;
				loginfo += ";";
				loginfo += tsd.encodeURIComponent("调账金额");
				loginfo += ":";
				loginfo += fee;
				loginfo += ";";
				loginfo += tsd.encodeURIComponent("备注");
				loginfo += ":";
				loginfo += memo;
				
				var res = fetchMultiPValue("FeeAdjust.AD",0,"&username="+username+"&userid="+userid+"&fee="+fee+"&memo="+memo);
				
				if(res[0]==undefined || res[0][0]==undefined)
				{
				
				}
				else if(res[0][0]=="0")
				{
					alert("用户不存在");
					$("#kdSearchBox").select();
					$("#kdSearchBox").focus();
				}
				else if(res[0][0]=="-1")
				{
					alert("系统正在汇总，请半小时后再次尝试");
				}
				else
				{
					alert("调账成功");					
					
					$("#adjustFee").val("");
					$("#adjustFee").attr("disabled","disabled");
					
					$("#memo").val("");
					
					loadKF(username);
					loadTZHistory(username);
					
					$("#kdsave").attr("disabled","disabled");
					
					//$("#kdSearchBox").val("");
					$("#kdSearchBox").select();
					$("#kdSearchBox").focus();
					writeLogInfo("","modify",loginfo);
				}
			}
			/**
			 * 清空页面
			 * @param
			 * @return
			 */
			function clearSearchedInfo()
			{
				$("#kdSearchBox").val("");
				$("#adjustUN").val("");
				$("#adjustFee").val("");
				$("#memo").val("");
				$("#adjustFee").attr("disabled","disabled");
				
				loadKF('~');
				$("#kfInfoHis").empty();
				
				$("#kdsave").attr("disabled","disabled");
				
				$("#kfInfoDiv").removeData("username");
				
				$("#kdSearchBox").select();
				$("#kdSearchBox").focus();
			}
			
			/**
			 * 加载宽带jqGrid表格
			 * @param
			 * @return
			 */	
			function loadKF(UserName)
			{
				var tzRefresh = arguments[1];
				
				$("#kfInfoDiv").empty();
				$("#kfInfoDiv").append("<table id=\"kfGrid\" class=\"scroll\"></table>");
				$("#kfInfoDiv").append("<div id=\"kfPager\" class=\"scroll\" style=\"text-align:left\"></div>");
				
				var cols = "hzyf,FeeName,UserType,iFeeTypeTime,heji,basefee,newfee,adjustfee,syye,byss,byye,payflag,isend";
				var cna = "汇总月份,计费规则,用户类型,计费开始时间,合计,上网费,新业务费,调账费,上月余额,本月实收,本月余额,是否结清,是否结算";
				if($("#lanType").val()=="en")
				{
					cna = cols;
				}
				var colnn = cna.split(",");
				var coln = cols.split(",");
				var colm = [];
				
				for(var i=0;i<coln.length;i++)
				{
					var temp = "{name:'"+coln[i]+"',index:'"+coln[i]+"',width:62}";
					
					colm.push(new Function("return "+temp)());
				}
				colm[0].width=60;
				colm[1].width=120;
				colm[2].width=70;
				colm[3].width=150;
				
				colm[3].hidden=true;
				colm[9].hidden=true;
				
				
				var urlstr=tsd.buildParams({ packgname:'service',//java包
											clsname:'ExecuteSql',//类名
											method:'exeSqlData',//方法名
											ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											tsdcf:'mysql',//指向配置文件名称
											tsdoper:'query',//操作类型 
											datatype:'xml',//返回数据格式 
											tsdpk:'feeAdjust.list',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											tsdpkpagesql:'feeAdjust.listPage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
											});
				var params = "&UserName=" + (UserName==""?"~":UserName);		
			
				$("#kfGrid").jqGrid({
						url:'mainServlet.html?'+urlstr + params,
						datatype: 'xml', 
						colNames:colnn, 
						colModel:colm, 
						       	rowNum:10, //默认分页行数
						       	rowList:[10,15,20], //可选分页行数
						       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						       	pager: jQuery('#kfPager'), 
						       	sortname: 'hzyf', //默认排序字段
						       	viewrecords: true, 
						       	sortorder: 'desc',//默认排序方式 
						       	caption:'宽带扣费信息',//"宽带业务流水", 
						       	height:220, //高
						       	width:document.documentElement.clientWidth-67,
						       	loadComplete:function(){
						       		if($("#kfGrid tr.jqgrow[id='1']").html()!="")
						       		{
										var len = $("#kfGrid tr").size() - 1;
										
										for(var i=1;i<=len;i++)
										{
												var pflag = $("#kfGrid").getCell(i,"payflag");
												var eflag = $("#kfGrid").getCell(i,"isend");
												//alert(pflag);
												if(pflag=='yes')
												{
													$("#kfGrid").setRowData(i,{payflag:'是'});
												}
												else if(pflag=='no')
												{
													$("#kfGrid").setRowData(i,{payflag:'否'});
												}
													
												if(eflag=='yes')
												{
													$("#kfGrid").setRowData(i,{isend:'是'});
													//ableflag
												}
												else if(eflag=='no')
												{
													$("#kfGrid").setRowData(i,{isend:'否'});
													
													if(!$("#adjustFee").attr("disabled"))
													{													
														$("#kdsave").removeAttr("disabled");
											
														$("#adjustFee").select();
														$("#adjustFee").focus();
													}
												}
										}
									}
									else
									{
										if($("#kfInfoDiv").data("username") != undefined)
										{
											//alert("没有"+$("#kfInfoDiv").data("username")+"的扣费记录，不能调账");
										}
									}			
								}
						}).navGrid('#kfPager', {edit: false, add: false, add: false, del: false, search: false}, //options 
							{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
							{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
							{reloadAfterSubmit:false}, // del options 
							{} // search options 
							); 
			}
			
			/**
			 * 加载宽带调账历史列表
			 * @param
			 * @return
			 */
			function loadTZHistory(UserName)
			{
				$("#kfInfoHis").empty();
				$("#kfInfoHis").append("<table id=\"tzhisGrid\" class=\"scroll\"></table>");
				$("#kfInfoHis").append("<div id=\"tzhisPager\" class=\"scroll\" style=\"text-align:left\"></div>");
				
				var cols = "dLogDate,sLogDesc,sAdminName,memo";
				var cna = "调账时间,调账金额,工号,备注";
				if($("#lanType").val()=="en")
				{
					cna = cols;
				}
				var colnn = cna.split(",");
				var coln = cols.split(",");
				var colm = [];
				
				for(var i=0;i<coln.length;i++)
				{
					var temp = "{name:'"+coln[i]+"',index:'"+coln[i]+"',width:62}";
					
					colm.push(new Function("return "+temp)());
				}
				
				
				
				var urlstr=tsd.buildParams({ packgname:'service',//java包
											clsname:'ExecuteSql',//类名
											method:'exeSqlData',//方法名
											ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											tsdcf:'mysql',//指向配置文件名称
											tsdoper:'query',//操作类型 
											datatype:'xml',//返回数据格式 
											tsdpk:'feeAdjust.history',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											tsdpkpagesql:'feeAdjust.historyPage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
											});
				var params = "&UserName=" + (UserName==""?"~":UserName);		
			
				$("#tzhisGrid").jqGrid({
						url:'mainServlet.html?'+urlstr + params,
						datatype: 'xml', 
						colNames:colnn, 
						colModel:colm, 
						       	rowNum:10, //默认分页行数
						       	rowList:[10,15,20], //可选分页行数
						       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						       	pager: jQuery('#tzhisPager'), 
						       	sortname: 'adjustTime', //默认排序字段
						       	viewrecords: true, 
						       	sortorder: 'desc',//默认排序方式 
						       	caption:'宽带调账历史信息',//"宽带业务流水", 
						       	height:220, //高
						       	width:document.documentElement.clientWidth-57,
						       	loadComplete:function(){
									
								}
						}).navGrid('#tzhisPager', {edit: false, add: false, add: false, del: false, search: false}, //options 
							{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
							{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
							{reloadAfterSubmit:false}, // del options 
							{} // search options 
							); 
			}
			/**
			 * 数字格式校验
			 * @param
			 * @return
			 */
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
					//if(event.keyCode==190)
					//alert(event.keyCode);
					if (evt.keyCode < 48 || evt.keyCode > 57)
					{
						if(evt.keyCode==45)
						{
							if(obj.value=="")
							{
							
							}
							else
							{
								evt.returnValue = false;
							}
						}
						else if(evt.keyCode==46)
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
			
			/**
			  初始化调账月份
			*/
			function initDhTzyf(DhOrHth)
			{
				var res = fetchMultiValue("adjustFee.newhzyf",6,"&DhOrHth=" + DhOrHth);
				var opthtml = "<option value=\"auto\">当前统计月份</option>";
				if(res[0]!=undefined)
				{
					for(var i=0;i<res.length;i++)
						opthtml += "<option value=\"" + res[i] + "\">" + res[i] + "</option>";
				}
				$("#dhtztzyf").html(opthtml);
			}
			
			/**加载电话扣费列表
			 * 取用户权限
			 * @param
			 * @return
			 */
			function loadDhKF(DhOrHth)
			{
				var dhyee = $("#dhQf").attr("trueval");
				dhyee = parseFloat(dhyee);
				if(isNaN(dhyee)) dhyee = 0;
				
				if(dhyee<=0)
					paramtmp = " hzyf='" + $("#dqsfyf").val() + "' ";
				else
					paramtmp = " pay_flag='" + encodeURIComponent("N") + "' ";
				
				$("#dhInfoDiv").empty();
				$("#dhInfoDiv").append("<table id=\"dhGrid\" class=\"scroll\"></table>");
				$("#dhInfoDiv").append("<div id=\"dhPager\" class=\"scroll\" style=\"text-align:left\"></div>");
				
				var cols = "Hzyf,Yhmc,Bm1,Yhxz,Jmhf,Byye_Ysk,Byss,Yjf,Znj,Pay_Flag";
				var cna = "汇总月份,用户名称,一级部门,用户性质,减免话费,本月余额,本月实收,应缴费,滞纳金,是否结算";
				if($("#lanType").val()=="en")
				{
					cna = cols;
				}
				var colnn = cna.split(",");
				var coln = cols.split(",");
				var colm = [];
				
				for(var i=0;i<coln.length;i++)
				{
					var temp = "{name:'"+coln[i]+"',index:'"+coln[i]+"',width:62}";
					
					colm.push(new Function("return "+temp)());
				}
								
				var urlstr=tsd.buildParams({ packgname:'service',//java包
											clsname:'ExecuteSql',//类名
											method:'exeSqlData',//方法名
											ds:'tsdCharge',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											tsdcf:'mssql',//指向配置文件名称
											tsdoper:'query',//操作类型 
											datatype:'xml',//返回数据格式 
											tsdpk:'adjustFee.fetchKF_tmp',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											tsdpkpagesql:'adjustFee.fetchKFCnt_tmp'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
											});
				var params = "&DhOrHth=" + (DhOrHth==""?"~":DhOrHth) + "&fusearchsql=" + paramtmp;		
			
				$("#dhGrid").jqGrid({
						url:'mainServlet.html?'+urlstr + params,
						datatype: 'xml', 
						colNames:colnn, 
						colModel:colm, 
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#dhPager'), 
				       	sortname: 'Hzyf', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'desc',//默认排序方式 
				       	caption:"电话扣费信息", 
				       	height:220, //高
				       	width:document.documentElement.clientWidth-67,
				       	loadComplete:function(){
				       		if($("#dhGrid tr.jqgrow[id='1']").html()!="")
				       		{
								var len = $("#dhGrid tr").size() - 1;										
								for(var i=1;i<=len;i++)
								{
									if(!$("#adjustDhFee").attr("disabled"))
									{													
										$("#dhsave").removeAttr("disabled");
							
										$("#adjustDhFee").select().focus();
									}
								}
							}
							else
							{
								if($("#dhInfoDiv").data("dhorhth") != undefined)
								{
									//alert("没有"+$("#kfInfoDiv").data("username")+"的扣费记录，不能调账");
								}
							}			
						}
				}).navGrid('#dhPager', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
			}
			/**
			 * 电话用户查询
			 * @param
			 * @return
			 */
			function ghSearch()
			{
				if($.trim($("#ghSearchBox").val())=="")
				{
					alert("请输入要查询的电话号码或合同号");
					$("#ghSearchBox").select().focus();
					return false;
				}
				else
				{
					$("#dhsave").attr("disabled","disabled");
					
					var dhorhth = $.trim($("#ghSearchBox").val());
					
					var isdh = $.trim($("#dhAdjustInputType").val());
					
					tsd.QualifiedVal=true;					
					dhorhth = tsd.encodeURIComponent(dhorhth);					
					if(tsd.Qualified()==false){$("#ghSearchBox").select().focus();return false;}
					
					var dhtzhzyf = $("#dhtzhzyf").val();
					if(dhtzhzyf == undefined || dhtzhzyf ==""){
						alert("统计月份不能为空");
						return;
					}
					
					/* var resa = fetchSingleValue("adjustFee.checkDhHth",6,"&DhOrHth="+dhorhth+"&Tjyf="+dhtzhzyf);
					if(resa==undefined||resa=="" || resa=="0")
					{
						alert("没有找到账号为"+$("#ghSearchBox").val()+"的用户");
						$("#ghSearchBox").select().focus();
					}
					else
					{ }*/
					var checkadjust = fetchMultiPValue("adjustFee.dhadjustfee",1,"&hth=" + encodeURIComponent(dhorhth) + "&busi=phone&func=get&userid=" + encodeURIComponent($("#skrid").val())+"&isdh="+isdh);
					if(checkadjust[0]!=undefined && checkadjust[0][0]!=undefined)
					{   //alert(checkadjust[0][0]);
						if(checkadjust[0][0]=="SUCCEED")
						{
							$("#adjustfee_hth").val(checkadjust[0][3]);
							alert($("#adjustfee_hth").val());
							var tmpYe = parseFloat(checkadjust[0][1],10);
							$("#dhQf").attr("trueval",tmpYe);
							$("#dhQf").data("dqyf",tmpYe);
							if(tmpYe>0)  //负数为有余额，正数为欠费
							{
								$("#dhQfLbl").html("欠费金额");
								$("#dhQf").val(tmpYe);
							}
							else
							{
								$("#dhQf").val(tmpYe*(-1));
								$("#dhQfLbl").html("当前余额");
							}
							
							$("#dhInfoDiv").data("dhorhth",dhorhth);
							$("#adjustDh").val($("#dhInfoDiv").data("dhorhth"));
							$("#adjustDhFee").removeAttr("disabled");
							
							var qfysn = checkadjust[0][2];
							qfysn = parseInt(qfysn,10);
							if(isNaN(qfysn)) qfysn=0;
							
							if(qfysn<=1)
							{
								$("#dhtztzyfdiv").css("display","none");
							}
							else
							{
								$("#dhtztzyfdiv").css("display","inline");
							}
							
							initDhTzyf(dhorhth);
							loadDhKF(dhorhth);						
							loadDhTZHistory(dhorhth);
						}
						else{
							alert(checkadjust[0][1]);
							if(checkadjust[0][1] == "notexists"){
								alert("用户账号不存在");
							}else if(checkadjust[0][1] == "notexiststab"){
								alert("用户账单不存在");
							}else{
								alert("checkadjust[0][1]");
							}
						}
					}
					else
					{
						alert("未知的数据错误");
					}
				}
			}
			
			/**
			 * 电话费用调整
			 * @param
			 * @return
			 */
			function dhAdjust()
			{
				//var dhorhth = $("#dhInfoDiv").data("dhorhth");
				var dhorhth = $("#adjustfee_hth").val();
				if(dhorhth=="" || dhorhth==null)
				{
					alert("获取合同号失败，请重新查询！");
					return;
				}
				var userid = $("#skrid").val();
				
				var tzyf = $.trim($("#dhtzhzyf").val()); 
				if(tzyf=="" || tzyf==null)
				{
					alert("请选择要调账的月份");
					//$("#dhtzhzyf").select().focus();
					return;
				}
				
				var dadjutype = $("#dhAdjustType").val();
				if(dadjutype=="" || isNaN(parseInt(dadjutype,10)))
				{
					alert("请选择费用调整方式");
					$("#dhAdjustType").select().focus();
					return false;
				}
				dadjutype = parseInt(dadjutype);
				
				if($.trim($("#adjustDhFee").val())=="")
				{
					alert("请输入调账金额");
					$("#adjustDhFee").select().focus();
					return false;
				}
				
				var fee = $("#adjustDhFee").val();
				fee = parseFloat(fee);
				
				if(isNaN(fee))
				{
					alert("请输入正确的金额格式");
					$("#adjustFee").select().focus();
					return false;
				}
				fee = fee * dadjutype;
				
				var adtype = $("#adjustDhType").val();
				if(adtype=="")
				{
					alert("请选择调账类型");
					$("#adjustDhType").select().focus();
					return false;
				}
				
				var adstype = $("#adjustDhSType").val();
				if(adstype=="")
				{
					alert("请选择调账子类型");
					$("#adjustDhSType").select().focus();
					return false;
				}
				
				var memo = $.trim($("#dhmemo").val());
				if(memo=="请在此处输入备注,必填" || memo=="")
				{
					alert("请输入电话调账备注信息");
					$("#dhmemo").select().focus();
					return;
				}
				memo = memo.substring(0,260);
				memo = tsd.encodeURIComponent(memo);
				
				var lfee=$("#dhQf").data("dqyf");
				if(isNaN(parseFloat(lfee)))
				  lfee = 0;
				//统计电话 
				var tjdhnum = "";
				if($("#dhAdjustInputType").val()=="2")
				{
					tjdhnum = "&tjdhnum=" + $.trim($("#dhAdjustTJDhBox").val());
				
				}
				//目标调账月份
				var disttzyf = $("#dhtztzyf").val();
				
				//lfee = lfee * dadjutype;
				//alert("系统将自动追收用户费用还补给用户费用");
								
				var loginfo = tsd.encodeURIComponent("电话 调账");
				loginfo += ";";
				loginfo += tsd.encodeURIComponent("工号");
				loginfo += ":";
				loginfo += userid;
				loginfo += ";";
				loginfo += tsd.encodeURIComponent("电话号码或合同号");
				loginfo += ":";
				loginfo += dhorhth;
				loginfo += ";";
				loginfo += tsd.encodeURIComponent("调账金额");
				loginfo += ":";
				loginfo += fee;
				loginfo += ";";
				loginfo += tsd.encodeURIComponent("调账月份");
				loginfo += ":";
				loginfo += tzyf;
				loginfo += ";";
				loginfo += tsd.encodeURIComponent("当前金额");
				loginfo += ":";
				loginfo += lfee;
				loginfo += ";";
				loginfo += tsd.encodeURIComponent("备注");
				loginfo += ":";
				loginfo += memo;
				loginfo += ";";
				loginfo += tsd.encodeURIComponent("调账月份");
				loginfo += ":";
				loginfo += disttzyf;
				loginfo += ";";
				//loginfo += tsd.encodeURIComponent("统计电话");
				//loginfo += ":";
				//loginfo += $.trim($("#dhAdjustTJDhBox").val());
				
				var confirmInfo = "";
				if(fee>0) confirmInfo = "追收";
				else confirmInfo = "补贴";
				
				if(confirm("你确定要" + confirmInfo + "用户 [" + dhorhth + "] " + Math.abs(fee) + " 元费用吗？"))
				{
					var res = fetchMultiPValue("adjustFee.dhadjustfee",1,"&disttzyf=" + disttzyf + "&feetype=" + adtype + "&feeitem=" + adstype + "&hth="+dhorhth+"&ye="+lfee+"&userid="+userid+"&fee="+fee + tjdhnum+"&memo="+memo+"&countmonth=" + tzyf + "&busi=phone&func=save");
					
					if(res[0]==undefined || res[0][0]==undefined)
					{
						$("#dhAdjustTJDhBox").val("");
					}
					else if(res[0][0]=="FAILED")
					{
						alert(res[0][1]);
						$("#ghSearchBox").select().focus();
						$("#dhAdjustTJDhBox").val("");
					}
					else
					{
						alert("调账成功");
						
						$("#adjustDhFee").val("");
						$("#adjustDhFee").attr("disabled","disabled");
						//调账成功之后重新查询当前余额
						var checkadjust = fetchMultiPValue("adjustFee.dhadjustfee",1,"&hth=" + encodeURIComponent(dhorhth) + "&busi=phone&func=get&userid=" + encodeURIComponent($("#skrid").val()));
						if(checkadjust[0]!=undefined && checkadjust[0][0]!=undefined)
						{
							if(checkadjust[0][0]=="SUCCEED")
							{
								//$("#dhQf").val(checkadjust[0][1]);
								var tmpYe = parseFloat(checkadjust[0][1],10);
								if(isNaN(tmpYe)) tmpYe = 0;
								//余额
								$("#dhQf").data("dqyf",tmpYe);
								if(tmpYe>0)  //负数为有余额，正数为欠费
								{
									$("#dhQfLbl").html("欠费金额");
									$("#dhQf").val(tmpYe);									
								}
								else
								{
									$("#dhQf").val(tmpYe*(-1));
									$("#dhQfLbl").html("当前余额");
								}
							}
						}
						
						$("#dhmemo").val("");
						$("#dhAdjustTJDhBox").val("");
						initDhTzyf(dhorhth);
						loadDhKF(dhorhth);
						loadDhTZHistory(dhorhth);
						
						$("#dhsave").attr("disabled","disabled");
						
						//$("#ghSearchBox").val("");
						$("#ghSearchBox").select().focus();
						writeLogInfo("","modify",loginfo);
					}
				}
			}
			
			/**
			 * 加载电话调账历史列表
			 * @param
			 * @return
			 */
			function loadDhTZHistory(DhOrHth)
			{
				$("#dhInfoHis").empty();
				$("#dhInfoHis").append("<table id=\"dhtzhisGrid\" class=\"scroll\"></table>");
				$("#dhInfoHis").append("<div id=\"dhtzhisPager\" class=\"scroll\" style=\"text-align:left\"></div>");
				
				var cols = "Hzyf,Yhmc,Bm1,Yhxz,Jmhf,skr,skyf,skr_date,tjyf";
				var cna = "汇总时间,用户名称,部门,用户性质,减免话费,工号,收款月份,时间,统计月份";
				if($("#lanType").val()=="en")
				{
					cna = cols;
				}
				var colnn = cna.split(",");
				var coln = cols.split(",");
				var colm = [];
				
				for(var i=0;i<coln.length;i++)
				{
					var temp = "{name:'"+coln[i]+"',index:'"+coln[i]+"',width:62}";
					
					colm.push(new Function("return "+temp)());
				}
				
				var urlstr=tsd.buildParams({ packgname:'service',//java包
											clsname:'ExecuteSql',//类名
											method:'exeSqlData',//方法名
											ds:'tsdCharge',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											tsdcf:'mssql',//指向配置文件名称
											tsdoper:'query',//操作类型 
											datatype:'xml',//返回数据格式 
											tsdpk:'adjustFee.dhhistroy',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											tsdpkpagesql:'adjustFee.dhhistroypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
											});
				var params = "&DhOrHth=" + (DhOrHth==""?"~":DhOrHth);		
			
				$("#dhtzhisGrid").jqGrid({
						url:'mainServlet.html?'+urlstr + params,
						datatype: 'xml', 
						colNames:colnn, 
						colModel:colm, 
						       	rowNum:10, //默认分页行数
						       	rowList:[10,15,20], //可选分页行数
						       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						       	pager: jQuery('#dhtzhisPager'), 
						       	sortname: 'skr_date', //默认排序字段
						       	viewrecords: true, 
						       	sortorder: 'desc',//默认排序方式 
						       	caption:'电话调账历史信息',//"宽带业务流水", 
						       	height:220, //高
						       	width:document.documentElement.clientWidth-57,
						       	loadComplete:function(){
									var ids = $("#dhtzhisGrid").getDataIDs();
									for(var i=0;i<ids.length;i++)
									{
										var uid = $("#dhtzhisGrid").getRowData(ids[i]).skr;
										var kid = Clerks[uid];
										if(kid!=undefined)
										{
											$("#dhtzhisGrid").setRowData(ids[i],{"skr":kid+"(" + uid + ")"});
										}
									}
								}
						}).navGrid('#dhtzhisPager', {edit: false, add: false, add: false, del: false, search: false}, //options 
							{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
							{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
							{reloadAfterSubmit:false}, // del options 
							{} // search options 
							); 
			}
			/**
			 * 初始化电话费用统计月份
			 * @param
			 * @return
			 */
			function initDqsfy()
			{
				var resa = fetchSingleValue("adjustFee.yfdrop",1,"");
				//var optHtml = "";
				if(resa != undefined && resa != "")
				{
					/* for(var i=0;i<resa.length;i++)
					{
						optHtml += "<option value=\"" + resa[i] + "\">" + resa[i] + "</option>";
					} */
					
					$("#dqsfyf").val(resa);
					$("#dhtzhzyf").val(resa);
				}
			}
			
			/**
			 * 清空电话调账页面
			 * @param
			 * @return
			 */
			function clearghSearchedInfo()
			{
				$("#ghSearchBox,#adjustDhFee,#dhQf,#adjustDh").val("");
				$("#dhmemo").val("");
				$("#adjustDhFee").attr("disabled","disabled");
				$("#dhtzhzy").val($("#dqsfyf").val());
				initDhTzyf('~');
				loadDhKF('~');
				$("#dhInfoHis").empty();
				
				$("#dhsave").attr("disabled","disabled");
				
				$("#dhInfoDiv").removeData("dhorhth");
				
				$("#ghSearchBox").select().focus();
			}
			
			function openQueryFeePanel()
			{
				autoBlockForm('queryFeeDetailPanel',20,'queryFeeDetailPanelClose',"#FFFFFF",false);
				$("#dhorhth").select().focus();
				$("#feedetailcontainer").html("");
				$("#dhorhth").val("");
				$("#rd_commonuser").click();
				$("#ptype_rd_commonuser").val("1");
				if($("#dhInfoDiv").data("dhorhth")!="" && $("#dhInfoDiv").data("dhorhth")!=undefined)
				{
					$("#dhorhth").val($("#dhInfoDiv").data("dhorhth"));
					ghFeeSearch();
				}
			}
		
		$(function(){
			fetchHzyf();
			//setUserRight();
			//$("#queryparam td:even").css({"background-color":"#c9d4ea","text-align":"right","padding-right":"1em"});			
			$("#dhorhth").keydown(function(event){
				if(event.keyCode==13)
				{
					ghFeeSearch();
				}
			});
			//费用项名称
			hfcols = fetchMultiArrayValue("hfmxquery.feefl",6,"");
		});	
		var hfcols = null;
		function ghFeeSearch()
		{
			//清空数据
			$("#feedetailcontainer").html("");
			
			if($.trim($("#dhorhth").val())=="")
			{
				alert("请输入要查询的电话号码或合同号");
				$("#dhorhth").select().focus();
				return;
			}
			
			var checkedtype = $("#rd_commonuser").attr("checked")?1:2;
			var ssel = "1";
			if(checkedtype=="1")
				ssel = $("#ptype_rd_commonuser").val();
			else
				ssel = $("#ptype_rd_biguser").val();
			
			//hfmxquery.query
			var urlMm = tsd.buildParams({ packgname:'service',
						clsname:'Procedure',//类名
						method:'exequery',//方法名
						ds:'tsdBilling',
						tsdExeType:'query',//操作类型 
						datatype:'xmlattr',//返回数据格式 
						tsdpname:'hfmxquery.query'
				});
			//alert(urlMm +"_"+param);
			var param = "&qtype=" + ssel + "&userid=" + encodeURIComponent($("#skrid").val()) + "&dhorhth=" + encodeURIComponent($.trim($("#dhorhth").val())) + "&hzyf=" + $("#hzyf").val();
			$.ajax({
				url:"mainServlet.html?" + urlMm + param,
				async:true,
				cache:false,
				timeout:20000,
				type:'post',
				success:function(xml){
					if($(xml).find("row").size()<1)
					{
						alert("当前查询的用户没有费用信息");
						$("#dhorhth").select().focus();
						return;
					}
				
					$(xml).find("row").each(function(){
						procedureHfTable($(this),ssel);
					});
					//删除没有费用的记录
					$(".feedetail").each(function(){
						if($(this).find("tr").size()==1)
						{
							$(this).remove();
						}
					});
					if($(".feedetail").size()>0 && (ssel==4 || ssel==5))
						$("#feedetailcontainer").prepend("<table style=\"margin-left:auto;margin-right:auto;margin-top:20px;\"><tr><td colspan=\"2\">共 "+$(".feedetail").size()+" 用户</td></tr></table>");
					$(".feedetail").each(function(){
						$(this).find("tr:gt(0) td:even").css({"text-align":"center"});
					});
				}
			});
		}
		//生成费用表格
		function procedureHfTable(data,xtype)
		{
			if($(data).attr("btheji")==undefined || $(data).attr("btheji")=="")
			{
				alert("当前输入条件没有费用信息");
				$("#dhorhth").select().focus();
				return;
			}
			var tabHtml = "<table class=\"feedetail\">";
			var hfdata = $(data);
			
			if(xtype==1)
			{
				tabHtml += "<tr>";
				tabHtml += "<td colspan=\"2\" style=\"text-align:center\">电话号码：" + $(hfdata).attr("dh") + " 合同号：" + $(hfdata).attr("hth") + " " + $(hfdata).attr("yhmc") + " 汇总月份：" + $("#hzyf").val() +" 的费用清单</td>";
				tabHtml += "</tr>";
			}
			else if(xtype==2)
			{
				tabHtml += "<tr>";
				tabHtml += "<td colspan=\"2\" style=\"text-align:center\">合同号：" + $(hfdata).attr("hth") + " " + $(hfdata).attr("yhmc") + " 汇总月份：" + $("#hzyf").val() +" 的费用清单</td>";
				tabHtml += "</tr>";
			}
			else if(xtype=="3")
			{
				tabHtml += "<tr>";
				tabHtml += "<td colspan=\"2\" style=\"text-align:center\">大客户 " + $("#dhorhth").val() + " 汇总月份 " + $("#hzyf").val() +" 的费用清单</td>";
				tabHtml += "</tr>";
			}
			else if(xtype=="4")
			{
				tabHtml += "<tr>";
				tabHtml += "<td colspan=\"2\" style=\"text-align:center\">合同号：" + $(hfdata).attr("hth") + " " + $(hfdata).attr("yhmc") + " 汇总月份：" + $("#hzyf").val() +" 的费用清单</td>";
				tabHtml += "</tr>";
			}
			else if(xtype=="5")
			{
				tabHtml += "<tr>";
				tabHtml += "<td colspan=\"2\" style=\"text-align:center\">用户：" + $(hfdata).attr("dh") + " " + $(hfdata).attr("yhmc") + " 汇总月份：" + $("#hzyf").val() +" 的费用清单</td>";
				tabHtml += "</tr>";
			}
			
			for(var ii=0;ii<hfcols.length;ii++)
			{
				if($(hfdata).attr(hfcols[ii][0].toLowerCase())!="0")
				{
					tabHtml += "<tr>";
					tabHtml += "<td width=\"30%\">" + getCaption(hfcols[ii][1],$("#lanType").val(),hfcols[ii][1]) + "</td>";
					tabHtml += "<td>" + $(hfdata).attr(hfcols[ii][0].toLowerCase()) + "</td>";
					tabHtml += "</tr>";
				}
			}
			//查询代缴和daijiaofor
			if(xtype="1")
			{
				if($(hfdata).attr("Daijiao".toLowerCase())!="0")
				{
					tabHtml += "<tr>";
					tabHtml += "<td width=\"30%\">它方代缴</td>";
					tabHtml += "<td>" + $(hfdata).attr("Daijiao".toLowerCase()) + "</td>";
					tabHtml += "</tr>";
				}
				if($(hfdata).attr("DaijiaoFor".toLowerCase())!="0")
				{
					tabHtml += "<tr>";
					tabHtml += "<td width=\"30%\">代缴</td>";
					tabHtml += "<td>" + $(hfdata).attr("DaijiaoFor".toLowerCase()) + "</td>";
					tabHtml += "</tr>";
				}
			}
			//if($(hfdata).attr("btheji")!="0")
			//{
				tabHtml += "<tr>";
				tabHtml += "<td width=\"30%\">共计</td>";
				tabHtml += "<td>" + $(hfdata).attr("btheji") + "</td>";
				tabHtml += "</tr>";
			//}
			tabHtml += "</table>";
			
			$("#feedetailcontainer").append(tabHtml);
		}
		
		//普通用户集团用户切换事件
		function chgType(obj)
		{
			$("select[id^='ptype']").hide();
			$("#ptype_" + obj.id).show();
		}
		//取扣费月份
		function fetchHzyf()
		{
			var res = fetchMultiValue("ghdhdetail.hzyf",6,"");
			var optHtml = "";
			for(var ii=0;ii<res.length;ii++)
			{
				optHtml += "<option value=\"" + res[ii] + "\">" + res[ii] + "</option>";
			}
			$("#hzyf").html(optHtml);
			var curhzyf = fetchSingleValue("ghdhdetail.nowmonth",6,"");
			if(curhzyf!="")
			{
				$("#hzyf").val(curhzyf);
			}
		}
		
		</script>
		
		<style type="text/css">
			#chooseBox{padding-bottom:30px;}
			#chooseForJF,#chooseForFJ{width:80px;}
			.tsdbutton{margin:2px;padding:2px 18px 2px 18px;height:24px;}
			
			.tsdbtn{line-height:28px;padding:2px 12px 2px 12px;  height:28px; margin-top:4px; margin-left:5px; background: url(style/imgs/buttonbg.jpg) repeat-x; border: #CCCCCC 1px solid; cursor: pointer; }
			label { float:left;text-align:left; margin-left:10px; width: 80px; line-height: 28px; }
	
			.inputbox{{margin-left:20px; background:url(style/imgs/inputText_bg.jpg) repeat-x ; width:180px; border:#999999 solid 1px;  text-align:left; color:#000000; font-size:12px; font-weight:bold; height:22px; line-height: 23px; }}
			
			
			#kdBar p{clear:both;padding-left:10px;}
			/*宽带票据*/
			#kdFP{padding-top:30px;padding-bottom:30px;padding-left:10px;}
			#kdInfo{text-align:left;border:#eeeeee 1px solid;}
			#kdInfo td{	background-color:#ffffff;line-height:22px;}
			
			#kduserInfoPanelTabRight,#kduserInfoPanelTab{text-align:left;border:#eeeeee 1px solid;}
			#kduserInfoPanelTabRight td,#kduserInfoPanelTab td{background-color:#ffffff;line-height:22px;}
			
			.bolder{font-weight:bold;}
			#kduiJf,#kduiJob,#kduiGNB,#kduiTZ,#kduiKF,#kduiXX{cursor:pointer;}
			#kdStatus{padding-left:10px;}
			#bu_muser a{font-weight:bold;}
			
			.btns,#kdButtons,#ghButtons{width:100%; float:left; *float:none; height:36px; background:url(style/imgs/buttonsbg.jpg) repeat-x; border-top:#CCCCCC 1px solid;border-bottom:#CCCCCC 1px solid;}
			.bzcolor{color:#999;}
			
			#queryparam{border:#eee 1px solid;width:560px;margin-left:auto;margin-right:auto;margin-top:2px;}
			#queryparam td{line-height:28px;border:#eee 1px solid;}
			
			.feedetail{border:#eee 1px solid;width:560px;margin-left:auto;margin-right:auto;margin-top:10px;}
			.feedetail td{line-height:28px;border:#eee 1px solid;}
			
			#hzyf,#ptype_rd_commonuser,#ptype_rd_biguser{margin-left:10px;}
			#feedetailcontainer{width:600px;margin:auto;}
		</style>

  </head>
  
  <body>
    <div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:		
	</div>
	
	<div id="tabs">	
		<ul>
			<li><a href="#gridkd" onclick="tabsChg(1)"><span>宽带费用调整</span></a></li>
			<li><a href="#griddh" onclick="tabsChg(2)"><span>电话费用调整</span></a></li>
		</ul>
		<div id="gridkd">
			用户账号：<input type="text" id="kdSearchBox" class="inputbox" /><button class="tsdbutton" id="searchByUserName" onclick="kdSearch()">查找</button>
			<br />
			
			<div id="kfInfoDiv"></div>
			<table border="0">
				<tr>
					<td>
						调账账号：
					</td>
					<td>
						<input type="text" id="adjustUN" class="inputbox" style="width:100px" disabled="disabled" />
					</td>
					<td rowspan="2" width="60" align="right">
						备注:&nbsp;&nbsp;&nbsp;
					</td>
					<td rowspan="2">
						<textarea id="memo" rows="4" cols="32"></textarea>
					</td>
					<td rowspan="2">
						<span style="color:#FF0000">(调账只能调当月的，多次调账费用将累加，调账金额为正时是扣钱，为负时是加钱)</span>
					</td>
				</tr>
				<tr>
					<td>
						调账费：
					</td>
					<td>
						<input type="text" id="adjustFee" class="inputbox" style="width:100px" disabled="disabled" style="ime-mode:disabled;" onkeypress="numValid(this)" onpaste="return !clipboardData.getData('text').match(/\D/)" ondragenter="return   false" />
					</td>
				</tr>
			</table>
			
			<div id="buttons" style="text-align:center;">
				<button style="display:none;" onclick="testCAlert()">Test</button><button class="tsdbtn" id="kdsave" onclick="kdAdjust()" style="width:120px;" disabled>保存</button><span style="visibility:hidden;">____</span><button class="tsdbtn" style="width:120px;" onclick="clearSearchedInfo()">重置</button>
			</div>
			
			<div id="kfInfoHis"></div>
		</div>
		<div id="griddh">
			查询方式：<select id="dhAdjustInputType"  style="width: 90px;"> 
				<option value="1">电话号码</option>
				<option value="2">合同号码</option>
			</select>
			<span style="padding-left: 12px;" id="dhAdjustInputTypeLabel">电话号码</span>：<input type="text" id="ghSearchBox"  style="width:90px;"/>
			<!-- <div id="dhAdjustTJDhDiv" style="display:none">				
				统计电话：<input type="text" id="dhAdjustTJDhBox" class="inputbox" style="width:100px;" />
			</div> -->
			<div id="dhtztzyfdiv" style="display:none" style="padding-left: 12px;">
				调账月份：<select id="dhtztzyf"></select>
			</div>
			&nbsp;&nbsp;统计月份：<input type="text" id="dhtzhzyf" style="width:90px;"/>&nbsp;&nbsp;
			<button style="width:90px;" class="tsdbutton" id="searchByDh" onclick="ghSearch()">查找</button>
			<button style="width:90px;" class="tsdbutton" id="searchDhFee" onclick="openQueryFeePanel()">话费明细</button>
			<br />
			<div id="dhInfoDiv"></div>
			<div style="color:#FF0000;margin:7px 0px;display:none">提示：多次调账费用将累加，调账金额为正时是扣钱，为负时是加钱</div>
			<table border="0">
				<tr>
					<td>
						电话号码：
					</td>
					<td>
						<input type="text" id="adjustDh" class="inputbox" style="margin-left:0px;width:100px" disabled="disabled" />
					</td>
					<td>
						<span id="dhQfLbl">当前余额</span>：
					</td>
					<td>
						<input type="text" id="dhQf" class="inputbox" style="margin-left:0px;width:100px" disabled="disabled" />
					</td>
					<!-- 
					<td>
						欠费金额：
					</td>
					<td>
						<input type="text" id="dhYee" class="inputbox" style="margin-left:0px;width:100px" disabled="disabled" />
					</td>
					 -->
					<td>调整方式</td>
					<td>
						<select id="dhAdjustType" style="margin-left:0px;width:100px">
							<option value="">请选择</option>
							<option value="1">追收费用</option>
							<option value="-1">还补费用</option>
						</select>
					</td>
					<td rowspan="2">
						
						<textarea id="dhmemo" rows="6" cols="32" style="margin-left:2px;height:52px;" class="bzcolor">请在此处输入备注,必填   </textarea>
					</td>
					<td rowspan="2"></td>
				</tr>
				<tr>
					<td style="line-height:32px;">费用类型：</td>
					<td>
						<select style="margin-left:0px;width:100px" id="adjustDhType">
							<option value="heji">合计</option>
							<option value="ye">余额</option>
							<option value="attachprice">月固定费</option>
							<option value="call_type_num">通话费</option>
						</select>
					</td>
					<td>费用项目：</td>
					<td>
						<select style="margin-left:0px;width:100px" id="adjustDhSType">
							<option value="btheji">合计</option>
						</select>
					</td>
					<td>
						调账金额：
					</td>
					<td>
						<input type="text" id="adjustDhFee" class="inputbox" style="margin-left:0px;width:100px" disabled="disabled" style="ime-mode:disabled;" onkeypress="numValid(this)" onpaste="return !clipboardData.getData('text').match(/\D/)" ondragenter="return   false" />
					</td>
					
					<td width="60" align="right">
						
					</td>
					<td>
						
					</td>
					<td>
						
					</td>
					<td>
						
					</td>
				</tr>
			</table>
			
			<div id="buttons" style="text-align:center;">
				<button class="tsdbtn" id="dhsave" onclick="dhAdjust()" style="width:120px;" disabled>保存</button><span style="visibility:hidden;">____</span><button class="tsdbtn" style="width:120px;" onclick="clearghSearchedInfo()">重置</button>
			</div>
			
			<div id="dhInfoHis"></div>
		</div>
	</div>
	
	<div class="neirong" id="queryFeeDetailPanel" style="display:none;width:600px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						话费明细查询
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#queryFeeDetailPanelClose').click();">关闭</a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;width:600px;font-size:14px;max-height:320px;overflow-y:auto;overflow-x:hidden">
			<table id="queryparam">
				<tr>
					<td width="25%">电话或合同号</td>
					<td>
						<input type="text" id="dhorhth" name="dhorhth" class="inputbox" style="margin-left:10px;" />
						<div style="display:inline"><input type="radio" id="rd_commonuser" name="rd_user" checked onclick="chgType(this)" />普通用户</div>
						<div style="display:inline"><input type="radio" id="rd_biguser" name="rd_user" onclick="chgType(this)" />集团用户</div>
					</td>
				</tr>
				<tr>
					<td width="25%">汇总月份</td><td><select name="hzyf" id="hzyf" /></td>
				</tr>
				<tr>
					<td width="25%">操作</td>
					<td>
						<select id="ptype_rd_commonuser">
							<option value="1">按用户</option>
							<option value="2">按账号</option>
						</select>
						<select id="ptype_rd_biguser" style="display:none">
							<option value="3">按集团账户</option>
							<option value="4">按集团子账户</option>
							<option value="5">按用户</option>
						</select>
						<button class="tsdbutton" onclick="ghFeeSearch()" style="margin:2px;padding:0px 10px 5px 10px;">查询</button>
					</td>
				</tr>
			</table>
			<div id="feedetailcontainer">
				
			</div>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="queryFeeDetailPanelClose">
				关闭
			</button>
		</div>
		
	</div>
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>' />
	
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea") %>' />
	<input type="hidden" id="skrid" name="skrid" value='<%=session.getAttribute("userid") %>' />
	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
	
	<input type='hidden' id='dqsfyf' name='dqsfyf'  /> 
	
	<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 
	<!-- 查询陈成功后返回的hth -->
	<input type='hidden' id='adjustfee_hth' name='dqsfyf'  /> 
  </body>
</html>
