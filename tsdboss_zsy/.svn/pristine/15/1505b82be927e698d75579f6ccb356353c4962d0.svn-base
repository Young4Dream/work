<%----------------------------------------
	name: userInfo.jsp
	author: youhongyu
	version: 1.0, 2010-8-20
	description: 宽带用户信息查询 查询宽带用户基本信息、业务信息、缴费信息、扣费信息及故障信息
	modify: 
		2010-11-5 chenze  添加注释
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
	<title></title>
	
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>

		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
		<!-- dtree需要导入文件 -->
		<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />
		
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
		
		<script src="script/broadband/usercat/Internationalization.js" type="text/javascript" language="javascript"></script>
		
	
	
<!--  
	<script src="js/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>		
	<script src="js/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
	<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>		
	<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
	<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen"/>
	
	<script src="js/revenue/Internationalization.js" type="text/javascript" language="javascript"></script>
	-->
	
	<!-- 双导航栏异常处理 -->
	<style type="text/css">
		#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
		cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
	</style>

	<style type="text/css">
		#chooseBox{padding-bottom:30px;}
		#chooseForJF{width:80px;}
		.tsdbutton{margin:2px;padding:2px 18px 2px 18px;height:24px;}
		
		.tsdbtn{line-height:28px;padding:2px 12px 2px 12px;  height:28px; margin-top:4px; margin-left:5px; background: url(style/images/public/buttonbg.jpg) repeat-x; border: #CCCCCC 1px solid; cursor: pointer; }
		label { float:left;text-align:left; margin-left:10px; width: 80px; line-height: 28px; }

		.inputbox{{margin-left:20px; background:url(style/images/public/inputText_bg.jpg) repeat-x ; width:180px; border:#999999 solid 1px;  text-align:left; color:#000000; font-size:12px; font-weight:bold; height:22px; line-height: 23px; }}
		
		
		#kdBar p{clear:both;padding-left:10px;}
		/*宽带票据*/
		#kdFP{padding-top:30px;padding-bottom:30px;padding-left:10px;}
		#kdInfo,#kdFaultInfoT{text-align:left;border:#eeeeee 1px solid;margin-left:20px;}
		#kdInfo td,#kdFaultInfoT td{	background-color:#ffffff;line-height:26px;}
		
		#kduserInfoPanelTabRight,#kduserInfoPanelTab{text-align:left;border:#eeeeee 1px solid;}
		#kduserInfoPanelTabRight td,#kduserInfoPanelTab td{background-color:#ffffff;line-height:22px;}
		
		.bolder{font-weight:bold;}
		#kduiJf,#kduiJob{cursor:pointer;}
		
		#kdStatus{padding-left:10px;}
		
		.neirong .midd #grid table{line-height:18px;}
		#bu_muser a{font-weight:bold;}
		#input-Unit .title{ width:100%; height:32px; background:url(style/images/public/kuangbg.jpg); border-bottom:1px solid #C8D8E5;  text-align:left; color:#3C3C3C; }
		
		#kdButtons{width:100%; float:left; *float:none; height:36px; background:url(style/images/public/buttonsbg.jpg) repeat-x; border-top:#CCCCCC 1px solid;border-bottom:#CCCCCC 1px solid;}
	</style>

	<script type="text/javascript">
	$(function(){
		$("#navBar1").append(genNavv());
		gobackInNavbar("navBar1");
		setUserRight();
		
		brodbandinter($("#lanType").val());
		
		//故障查询按钮
		if($("#faultright").val()=='false')
		{
			$("#kdFinddFault").hide();
		}
		
		//宽带缴费查询面板拖动
		$("#multiSearch").draggable({handle:"#thisdrag"});
		//缴费历史
		loadJF("");
		//业务变更历史
		loadJOB("");
		//扣费历史
		loadKF("");
		//页面加载时输入框获得焦点
		$("#kdSearchBox").select();
		$("#kdSearchBox").focus();
		//查询方式变更事件
		$("#kdSearchWay").change(function(){
			$("#kdSearchBox").val("");
			$("#kdSearchBox").select();
			$("#kdSearchBox").focus();
			$("#c_p_address").css("display","none");
			if($("#kdSearchWay").val()=="3")
			{
				$("#kdSearchBox").click();
			}
		});
		
		$("#kdSearchBox").click(function(){
			if($("#kdSearchWay").val()=="3" && $("#c_p_address").css("display")!="block")
			{
				c_p_address_fun();
			}
		});
		
		//$("#kdInfo tr td:even").css("font-weight","bold");
		//查询按钮事件
		$("#kdSearchByUserName").click(function(){kdSearch();});
		
		$("#kdFinddFault").click(function(){
			kdFindFault();
		});
		//输入框回车事件
		$("#kdSearchBox").keydown(function(event){
			if(event.keyCode==13)
			{
				$("#kdSearchBox").blur();
				$("#kdSearchByUserName").click();
			}
		});
		
		//查询面板关闭事件
		$("#kdMultiSearchClose").click(function(){
			//$("#kdSearchWay").css("visibility","visible");
		});
		//查询面板键盘事件
		$(document).keydown(function(event){
			var panelStatus = $("#multiSearch").css("display");
			if(panelStatus == "block")
			{
				//alert(event.keyCode);
				var idx = $("#bu_muser").getGridParam("selrow");
				idx = parseInt(idx,10);
				//alert("A:"+idx);
				//alert(typeof idx);
				var len = $("#bu_muser").getDataIDs().length;
				//alert(typeof len);
				
				if(event.keyCode==40)
				{
					if(idx==null||isNaN(idx))
					{
						$("#bu_muser").setSelection("1");
					}
					else
					{
						$("#bu_muser").setSelection(idx+1);
					}
				}
				else if(event.keyCode==38)
				{
					if(idx==null||isNaN(idx))
					{
						$("#bu_muser").setSelection(len);
					}
					else
					{
						$("#bu_muser").setSelection(idx-1);
					}
				}
				else if(event.keyCode==37)
				{
					$("#bu_pager #prev").click();
				}
				else if(event.keyCode==39)
				{
					$("#bu_pager #next").click();
				}
				else if(event.keyCode==27)
				{
					$("#kdMultiSearchClose").click();
				}
				else if(event.keyCode==13)
				{
					if(idx==null||isNaN(idx)||idx==undefined)
					{
					}
					else
					{
						userChoose($("#bu_muser").getCell(idx,"UserName"),$("#bu_muser").getCell(idx,"sDh"),$("#bu_muser").getCell(idx,"sRealName"));
					}
				}
			}
		});
	});
	/**
	 * 从宽带论证故障记录表查询指定用户故障信息
	 * @param
	 * @return
	 */
	function kdFindFault()
	{		
		var username = $("#kdInfo").data("username");
		if(username==undefined||username=="")
		{
			alert("请先查询用户信息");
			$("#kdSearchBox").select();
			$("#kdSearchBox").focus();
		}
		else
		{
			//检测故障信息是否已显示，如果是隐藏状态，则显示
			if($("#fault").css("display")!="block")
			{
				$("#fault").show();
			}		
		
			var res = fetchMultiArrayValue("userInfo.fault",4,"&UserName="+username);
			
			if(res[0]==undefined||res[0][0]==undefined)
			{
				$("#kdFaultTime").text("");
				//日志信息
				$("#kdFaultInfo").text("");
				//日志原因
				$("#kdFaultReason").text("");
				return false;
			}
			else
			{
				//日志时间
				$("#kdFaultTime").text(res[0][0]);
				//日志信息
				$("#kdFaultInfo").text(res[0][1]);
				//日志原因
				
				if($.trim(res[0][2])!="")
				{
					$("#kdFaultReason").text(res[0][2]);
				}
				else
				{
					var ress = fetchMultiPValue("userInfo.faultReason",0,"&UserName="+username);
					
					if(ress[0]!=undefined && ress[0][0]!=undefined)
					{
						$("#kdFaultReason").text(ress[0][0]);
					}
				}
			}
		}
	}
	
	/**
	 * 用户信息查询
	 * @param
	 * @return
	 */
	function kdSearch()
	{
		//如果是地址查询且面板已显示，则先隐藏面板
		if($("#c_p_address").css("display")=="block")
		{
			$("#c_p_address").hide();
		}
		
		$("#kdInfo").removeData("username");
		$("#fault").hide();
		
		//模糊查询总数
		var keys=["Revenue.queryCountByIDM","Revenue.queryCountBysDhNameM","Revenue.queryCountBysRealNameM","userInfo.queryCountByAddress"];
		//精确查询
		var keyy=["Revenue.queryByIDExtract","Revenue.queryBySDHExtract","Revenue.queryBySRealNameExtract"];
		var infos = ["账号","电话","姓名","地址"];
		var idx = parseInt($("#kdSearchWay").val(),10);
		//alert(idx);
		if($.trim($("#kdSearchBox").val())=="")
		{
			alert("请输入要查询的用户"+infos[idx]);
			$("#kdSearchBox").select();
			$("#kdSearchBox").focus();
			return false;
		}		
		else
		{
			//每次拼接参数必须初始化此参数
			var param = "";
			tsd.QualifiedVal=true;
	
			param = tsd.encodeURIComponent($.trim($("#kdSearchBox").val()));
			
			if(tsd.Qualified()==false){$("#kdSearchBox").select();$("#kdSearchBox").focus();return false;}
			
					
			var temp = fetchSingleValue(keys[idx],0,"&UN="+param);
			if(temp=="0")
			{
				alert("没有符合条件的用户，请检查输入");
				$("#kdSearchBox").select();
				$("#kdSearchBox").focus();
			}
			else
			{
				kdMultiUser(idx,param);
			}
			
		}
	}
	
	/**
	 * 查询页面用户选择
	 * @param 
	 * @return
	 */
	function kdMultiUser(flag,UN)
	{
		if(flag!="1"&&flag!="2"&&flag!="3")
		{
			flag = 0;
		}
		//alert("Status:"+2);
		var keys = [["Revenue.queryByIDM","Revenue.queryCountByIDM"],["Revenue.queryBysDhM","Revenue.queryCountBysDhNameM"],["Revenue.queryBysRealNameM","Revenue.queryCountBysRealNameM"],["userInfo.queryByAddress","userInfo.queryCountByAddress"]];
		$("#grid").empty();
		$("#grid").append("<table id=\"bu_muser\" class=\"scroll\"></table><div id=\"bu_pager\" class=\"scroll\"></div>");
		var urlstr = tsd.buildParams({packgname:'service',//java包
							 					clsname:'ExecuteSql',//类名
							 					method:'exeSqlData',//方法名
							 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
							 					tsdcf:'mysql',//指向配置文件名称
							 					tsdoper:'query',//操作类型 
							 					datatype:'xml',
							 					tsdpk:keys[flag][0],//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							 					tsdpkpagesql:keys[flag][1],
							 					tsdUserID:'ture'
							 				});
		//var kdFormSett = ["kdUserName","kdsRealName"];
		//alert("Status:"+3);
		//alert(urlstr);
		$("#bu_muser").jqGrid({
				url:'mainServlet.html?' +urlstr+ "&UN="+UN, 
				datatype: 'xml', 
				colNames:['操作','姓名','帐号','电话','地址','用户类型'],
				colModel:[{name:'viewOperation',index:'viewOperation',width:50},{name:'sRealName',index:'sRealName',width:80},{name:'UserName',index:'UserName',width:120},{name:'sDh',index:'sDh',width:100},{name:'sAddress',index:'sAddress',width:280},{name:'usertype',index:'usertype',width:80}],
		       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
		       	pager: jQuery('#bu_pager'), 
		       	sortname:'UserName', 
		       	viewrecords: true, 
		       	rowNum:10, //默认分页行数
		       	//rowList:[10,20,30], //可选分页行数
		       	sortorder: 'asc', 
		       	//caption:'用户信息', 
		       	height:240,
		       	//width:726,
		       	loadComplete:function(){
		        	$("#bu_muser").setSelection(1);
		        	addRowOperBtn('bu_muser','选择','userChoose','UserName','click',1,'sDh','sRealName');
		        	executeAddBtn('bu_muser',1);
		        },
		        ondblClickRow:function(idx){
		        	userChoose($("#bu_muser").getCell(idx,"UserName"),$("#bu_muser").getCell(idx,"sDh"),$("#bu_muser").getCell(idx,"sRealName"));
		        }
			       
			}).navGrid('#bu_pager', {edit: false, add: false, add: false, del: false, search: false}, //options 
				{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
				{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
				{reloadAfterSubmit:false}, // del options 
				{} // search options 
				);
			//autoBlockForm("multiSearch","50","close","#FFFFFF",false);
			
			//autoBlockFormAndSetWH("multiSearch",20,20,"kdMultiSearchClose","#FFFFFF",false,720,354);
			autoBlockForm("multiSearch","50","kdMultiSearchClose","#FFFFFF",false);
		}
		
	/**
	 * 宽带用户信息查询面板用户选择方法
	 * @param
	 * @return
	 */
		function userChoose(UserName,sDh,sRealName,sAddress)
		{
			var idx = parseInt($("#kdSearchWay").val(),10);
			if(idx==0)
			{
				$("#kdSearchBox").val(UserName);
			}
			else if(idx==1)
			{
				$("#kdSearchBox").val(sDh);
			}
			else if(idx==2)
			{
				$("#kdSearchBox").val(sRealName);
			}
			else if(idx==3)
			{
				$("#kdSearchBox").val(sAddress);
			}
			
			loadBasicInfo(UserName);
			loadJF(UserName);
			loadJOB(UserName);
			loadKF(UserName);
			
			
			$("#kdInfo").data("username",UserName);
			
			//$("#kdSearchWay").css("visibility","visible");
			
			setTimeout($.unblockUI,1);
		}
		
	
	/**
	 * 查询用户基本信息
	 * @param UserName 用户账号
	 * @return
	 */
	function loadBasicInfo(UserName)
	{
		$("#kdInfo tr td:odd span").empty();
		
		var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mysql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xmlattr',//返回数据格式 
									tsdpk:'userInfo.info'
									});
		var params = "&UserName=" + (UserName==""?"~":UserName);
		
		$.ajax({
			url:"mainServlet.html?"+urlstr+params,
			cache:false,
			timeout:1000,
			success:function(xml){
				$(xml).find("row").each(function(){
					var username = $(this).attr("UserName".toLowerCase());
					if(username!=undefined)
					{
						$("#kdinUserName").text(username);
					}
					
					var password = $(this).attr("Value".toLowerCase());
					if(password!=undefined)
					{
						$("#kdinPassword").text(password);
					}
					
					var srealname = $(this).attr("sRealName".toLowerCase());
					if(srealname!=undefined)
					{
						$("#kdinsRealName").text(srealname);
					}
					
					var istatus = $(this).attr("iStatus".toLowerCase());
					if(istatus!=undefined)
					{
						$("#kdiniStatus").text(analizeKdStatus(istatus));
					}
					
					if(kdPause(UserName))
					{
						$("#kdiniStatus").text("申请停机");
					}
					
					var sbm1 = $(this).attr("sBm".toLowerCase());
					if(sbm1!=undefined)
					{
						$("#kdinsBm1").text(sbm1);
					}
					
					var sbm2 = $(this).attr("sBm2".toLowerCase());
					if(sbm2!=undefined)
					{
						$("#kdinsBm2").text(sbm2);
					}
					
					var sbm3 = $(this).attr("sBm3".toLowerCase());
					if(sbm3!=undefined)
					{
						$("#kdinsBm3").text(sbm3);
					}
					
					var sbm4 = $(this).attr("sBm4".toLowerCase());
					if(sbm4!=undefined)
					{
						$("#kdinsBm4").text(sbm4);
					}
					
					var fee5 = $(this).attr("Fee5".toLowerCase());
					if(fee5!=undefined)
					{
						$("#kdinFee5").text(fee5);
					}
					
					
					var remainfee = $(this).attr("RemainFee".toLowerCase());
					if(remainfee!=undefined)
					{
						$("#kdinRemainFee").text(remainfee);
					}
					
					var ye = (parseFloat(remainfee)-parseFloat(fee5)).toFixed(2);
					
					$("#kdinYE").text(ye);
					
					var sregdate = $(this).attr("sRegDate".toLowerCase());
					if(sregdate!=undefined)
					{
						$("#kdinsRegDate").text(sregdate);
					}
					//证件类型
					var zhengjian = ['教职工','本科生','研究生','离退休','护照','军官证','身份证','其它'];
					var idtype = $(this).attr("idtype");
					if(idtype!=undefined)
					{
						var zjj = zhengjian[parseInt(idtype,10)-1];
						if(zjj==undefined)
						{
							zjj = "其它";
						}
						$("#kdinZJ").text(zjj);
					}
					
					var idcard = $(this).attr("idcard");
					if(idcard!=undefined)
					{
						$("#kdinzjhm").text(idcard);
					}
					
					var sdh1 = $(this).attr("sDh1".toLowerCase());
					if(sdh1!=undefined)
					{
						$("#kdinUserType").text(analizeUserType(sdh1));
					}
					
					var lxr = $(this).attr("linkman");
					if(lxr!=undefined)
					{
						$("#kdinlxr").text(lxr);
					}
					
					//联系电话
					var lxdh = $(this).attr("linkphone");
					if(lxdh!=undefined)
					{
						$("#kdinlxdh").text(lxdh);
					}
					
					var feename = $(this).attr("iFeeType".toLowerCase());
					if(feename!=undefined)
					{
						var fename = fetchSingleValue("Revenue.loadType",0,"&FeeCode="+feename);
						if(fename==undefined)
						{
							fename = "";
						}
						$("#kdinfeename").text(fename);
					}
					
					var address = $(this).attr("sAddress".toLowerCase());
					if(address!=undefined)
					{
						$("#kdinsAddress").text(address);
					}
					
					var mobile = $(this).attr("mobile");
					if(mobile!=undefined)
					{
						$("#kdinMobile").text(mobile);
					}
					
					var dh = $(this).attr("sDh".toLowerCase());
					if(dh!=undefined)
					{
						$("#kdinsdh").text(dh);
					}
					
					var newb = fetchMultiArrayValue("Revenue.fetchAttachFee",0,"&UserName="+UserName);
					//var iSimultaneous = $(this).attr("iSimultaneous");
					//if(iSimultaneous!=undefined)
					//{
					//	$("#kdinzx").text(iSimultaneous);
					//}
					for(var klj=0;klj<newb.length;klj++)
					{
						if(newb[klj][0]=="addSimultaneous")
						{
							$("#kdinzx").text(newb[klj][2]);
						}
						else if(newb[klj][0]=="addSpeed")
						{
							$("#kdints").text(newb[klj][2]);
						}
					}
					
					
					var ipaddr = $(this).attr("ipaddr");
					if(ipaddr!=undefined)
					{
						$("#kdinip").text(ipaddr);
					}
					
					var speed = $(this).attr("speed");
					
					$("#kdinspeed").text(calBSpeed(speed));
					
					
					var vlanid = $(this).attr("vlanid");
					if(vlanid!=undefined)
					{
						$("#kdinvlanid").text(vlanid);
					}
					
					
					var iMacAutoBand = $(this).attr("iMacAutoBand".toLowerCase());
					if(iMacAutoBand!=undefined)
					{
						$("#kdinwk").text(iMacAutoBand);
					}
					
					//var tcc = fetchMultiArrayValue("userInfo.tc",6,"&UserName="+UserName);
					var tcc = fetchMultiPValue("Revenue.getPackageName",6,"&busiclass=broadband&nubmer="+UserName);
					
					if(tcc[0]!=undefined)
					{
						var packagename = tcc[0][0];
						if(packagename!=undefined)
						{
							$("#kdinpackagename").text(packagename);
						}
						
						var packagetype = tcc[0][3];
						if(packagetype!=undefined)
						{
							$("#kdinpackagetype").text("￥" + packagetype);
						}
					}
				});
			}	
		});
	}
	/**
	 * 解析用户类型
	 * @param usertype 用户类型
	 * @return
	 */
	function analizeUserType(usertype)
	{
		usertype = fetchSingleValue("Revenue.fUTP",0,"&TypeID="+usertype);
		if(usertype==undefined)
		{
			usertype = "";
		}
		return usertype;
	}
	/**
	 * 解析用户状态
	 * @param status 状态代码
	 * @return 状态
	 */
	function analizeKdStatus(status)
	{
		status = parseInt(status,10);
		switch(status)
		{
			case 0:
				return "正常";
				break;
			case 1:
				return "锁定";
				break;
			case 2:
				return "欠费";
				break;
			default:
				return "";
		}
	}
	
	/**
	 * 取用户停机状态
	 * @param UserName  用户账号
	 * @return 返回用户是否在停机保号状态 true为正在停机保号状态 false为不在停机保号状态
	 */
	function kdPause(UserName)
	{
		var res = fetchSingleValue("Revenue.pause",0,"&UserName="+UserName);

		if(typeof res == 'undefined' || res == "0")
		{
			return false;
		}
		else
		{
			return true;
		}
	}
	/**
	 * 查询指定账号的缴费记录信息
	 * @param UserName 待查询的宽带账号
	 * @return
	 */
	function loadJF(UserName)
	{
		$("#kdjf").empty();
		$("#kdjf").append("<table id=\"jfGrid\" class=\"scroll\"></table>");
		$("#kdjf").append("<div id=\"jfPager\" class=\"scroll\" style=\"text-align:left\"></div>");
		
		var cols = "UserName,AcctPayTime,PayMoney,Operator,lsz,thisPayMoney,lastPayMoney";
		var cna = "帐号,缴费时间,缴费金额,收费员,流水,本次缴费剩余金额,上次剩余金额";
		if($("#lanType").val()=="en")
		{
			cna = cols;
		}
		var colnn = cna.split(",");
		var coln = cols.split(",");
		var colm = [];
		
		for(var i=0;i<coln.length;i++)
		{
			var temp = "{name:'"+coln[i]+"',index:'"+coln[i]+",width:100'}";
			
			colm.push(new Function("return "+temp)());
		}
		
		colm[0].width=115;
		colm[3].width=80;
		//colm[4].width=110;
		//colm[5].width=90;
				
		var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mysql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'userInfo.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'userInfo.queryCnt'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
		var params = "&UserName=" + (UserName==""?"~":UserName);

		$("#jfGrid").jqGrid({
				url:'mainServlet.html?'+urlstr + params,
				datatype: 'xml', 
				colNames:colnn, 
				colModel:colm, 
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#jfPager'), 
				       	sortname: 'AcctPayTime', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'desc',//默认排序方式 
				       	caption:'营收流水',//"宽带营收流水", 
				       	height:220, //高
				       	//width:700,//document.documentElement.clientWidth-200,
				       	loadComplete:function(){
										
										}
				}).navGrid('#jfPager', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
	}
	
	/**
	 * 查询指定账号的业务记录信息
	 * @param UserName 待查询的宽带账号
	 * @return
	 */
	function loadJOB(UserName)
	{
		$("#kdjob").empty();
		$("#kdjob").append("<table id=\"jobGrid\" class=\"scroll\"></table>");
		$("#kdjob").append("<div id=\"jobPager\" class=\"scroll\" style=\"text-align:left\"></div>");
		
		var cols = "UserName,JobType,JobRecTime,lsz,UserID,sDh,sRealName,Fee,FeeName,Memo";
		var cna = "帐号,业务类型,受理时间,流水号,工号,电话,用户名称,金额,费用名称,备注";
		if($("#lanType").val()=="en")
		{
			cna = cols;
		}
		var colnn = cna.split(",");
		var coln = cols.split(",");
		var colm = [];
		
		for(var i=0;i<coln.length;i++)
		{
			var temp = "{name:'"+coln[i]+"',index:'"+coln[i]+"',width:120}";
			
			colm.push(new Function("return "+temp)());
		}
		colm[3].width=110;
		colm[3].width=170;
		colm[2].width=150;
		colm[4].width=80;
		colm[7].width=80;
		colm[8].width=110;
		colm[5].hidden=true;
		colm[6].hidden=true;
		
		var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mysql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'userInfo.queryjob',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'userInfo.queryjobCnt'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
		var params = "&UserName=" + (UserName==""?"~":UserName);		
	
		$("#jobGrid").jqGrid({
				url:'mainServlet.html?'+urlstr + params,
				datatype: 'xml', 
				colNames:colnn, 
				colModel:colm, 
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#jobPager'), 
				       	sortname: 'JobRecTime', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'desc',//默认排序方式 
				       	caption:'宽带业务流水',//"宽带业务流水", 
				       	height:220, //高
				       	//width:700,//document.documentElement.clientWidth-27,
				       	loadComplete:function(){
										
										}
				}).navGrid('#jobPager', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
	}
	
	/**
	 * 查询指定账号的扣费记录信息
	 * @param UserName 待查询的宽带账号
	 * @return
	 */
	function loadKF(UserName)
	{
		$("#kdkf").empty();
		$("#kdkf").append("<table id=\"kfGrid\" class=\"scroll\"></table>");
		$("#kdkf").append("<div id=\"kfPager\" class=\"scroll\" style=\"text-align:left\"></div>");
		
		//var cols = "hzyf,FeeName,iFeeTypeTime,heji,basefee,newfee,adjustfee,syye,byss,byye";
		//var cna = "汇总月份,计费规则,计费开始时间,合计,上网费,新业务费,调账费,上月余额,本月实收,本月余额";
		var cols = "hzyf,UserType,FeeName,heji,basefee,newfee,adjustfee,stts,qtts,kfts,byye";
		var cna = "汇总月份,用户类型,计费规则,合计,上网费,新业务费,调账费,申停天数,欠停天数,扣费天数,本月余额";
		if($("#lanType").val()=="en")
		{
			cna = cols;
		}
		var colnn = cna.split(",");
		var coln = cols.split(",");
		var colm = [];
		
		for(var i=0;i<coln.length;i++)
		{
			var temp = "{name:'"+coln[i]+"',index:'"+coln[i]+"',width:75}";
			
			colm.push(new Function("return "+temp)());
		}
		colm[0].width=90;
		colm[1].width=100;
		colm[2].width=140;
		
		
		var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mysql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'userInfo.queryKF',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'userInfo.queryKFCnt'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
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
				       	//width:700,//document.documentElement.clientWidth-27,
				       	loadComplete:function(){
										
										}
				}).navGrid('#kfPager', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
	}
	
	/**
	 * 取用户权限
	 * @param
	 * @return
	 */
	function setUserRight()
	{
		var allRi = fetchMultiPValue("revenue.getPower",6,"&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
		if(typeof allRi == 'undefined' || allRi.length == 0)
		{
			//alert("取权限失败");
			return false;
		}
		if(allRi[0][0]=="all")
		{
			$("#faultright").val('true');	
			return true;
		}
		var faultright = 'false';
		
		for(var i = 0;i<allRi.length;i++){
			if(getCaption(allRi[i][0],'faultright','')=="true")
				faultright = 'true';			
		}
		$("#faultright").val(faultright);			
		
	}
	
	/**
	 * 选择用户所在的区域
	 * @param
	 * @return
	 */
        
      function getuserareato(){
          var uareato="";
          
          var urlstr=tsd.buildParams({packgname:'service',//java包
					 					clsname:'ExecuteSql',//类名
					 					method:'exeSqlData',//方法名
					 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
					 					tsdcf:'mssql',//指向配置文件名称
					 					tsdoper:'query',//操作类型 
					 					datatype:'xmlattr',
					 					tsdpk:'adduser.getuserarea'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
					 				});										
		                $.ajax({
				              url:'mainServlet.html?'+urlstr,
				              datatype:'xml',
				              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				              timeout: 1000,
				              async: false ,//同步方式
				              success:function(xml){	
				              uareato="";
				              $("#seluserarea").empty();			       
				                $(xml).find('row').each(function(){	
				                  var xuhao = $(this).attr("Xuhao".toLowerCase());
				                  var ywarea = $(this).attr("YwArea".toLowerCase());
				                  if(ywarea!=undefined){
						            var ee="<option value='"+xuhao+"' "+ (ywarea==$("#area").val()?" selected='selected' ":"") +">"+ywarea+"</option>";
						            uareato=uareato+ee;								       
							      }
						        });								        				       						        
						        $("#c_p_address_seluserarea").html(uareato);					       
						      }
						});
      }   
	
	/**
	 * 选择地址
	 * @param
	 * @return
	 */
	function c_p_address_fun()
	{		 	     
		if($("#c_p_address").size()<1)
		{
			$("#kdSearchBox").after("<div id=\"c_p_address\"></div>");
		}
		var left = $("#kdSearchBox").offset().left -30;
		var top = $("#kdSearchBox").offset().top + 20;
		//alert($("#sAddress").parent().offset().left);
		$("#c_p_address").css({'position':'absolute','left':left,'top':top,'background-color':'#FFFFFF','border':'#99ccff 1px solid','height':'112px','width':'800px'});
		$("#c_p_address").empty();		
		var address_tab="<table id=\"address_tab\" style=\"\">";
		address_tab += "<tr><td colspan=\"10\"><h4>添加地址</h4></td></tr>";
		address_tab += "<tr><td align=\"right\">区域</td><td><select id=\"c_p_address_seluserarea\"><option value=\"\">--请选择--</option></select></td><td>小区号</td><td><select id=\"c_p_address_xq\"><option value=\"\">--请选择--</option></select></td><td>楼栋号</td><td><select id=\"c_p_address_ld\"><option value=\"\">--请选择--</option></select></td><td>单元号</td><td><select id=\"c_p_address_dy\"><option value=\"\">--请选择--</option></select></td><td>门牌号</td><td><select id=\"c_p_address_mp\"><option value=\"\">--请选择--</option></select></td></tr>";
		address_tab += "<tr><td><button id=\"c_p_address_bnok\" class=\"tsdbutton\">确定</button></td><td><button id=\"c_p_address_bncancel\" class=\"tsdbutton\">取消</button></td><td colspan=\"8\"></td></tr>";
		address_tab += "</table>";
		$("#c_p_address").append(address_tab);
		getuserareato();							
		var cpad = $("#c_p_address_addright").val();
		if(cpad=="true"){
		  $("#c_p_address_add").removeAttr("disabled");		  		  	  
		}
		$("select[id^='c_p_address_']").css("width","100px");		
		//c_p_bindToAddr(1,"c_p_address_xq","");
		var sua = $("select[id='c_p_address_seluserarea'] :selected").html();
		c_p_bindToAddr(1,"c_p_address_xq","&addrarea=" + tsd.encodeURIComponent(sua));
				
		//获得焦点时显示
		$("#c_p_address").show('slow');		
		$(document).one("click",function(event){
			//$("#c_p_address").hide('slow');
			//event.stopPropagation();
		});
		//修改区域后触发
		$("#c_p_address_seluserarea").change(function(){
			var sua = $("select[id='c_p_address_seluserarea'] :selected").html();
			c_p_bindToAddr(1,"c_p_address_xq","&addrarea=" + tsd.encodeURIComponent(sua));
		});
		//选择小区后更新楼栋数据
		$("#c_p_address_xq").change(function(){
			//alert($("#c_p_address_xq").val()); 
			var addr = $("#c_p_address_xq").val();
			if(addr!="")
			{
				c_p_bindToAddr(2,"c_p_address_ld","&addr=" + $("#c_p_address_xq").val());
			}
		});
		//选择楼栋后更新单元数据
		$("#c_p_address_ld").change(function(){
			//alert($("#c_p_address_xq").val()); 
			var addr = $("#c_p_address_ld").val();
			if(addr!="")
			{
				c_p_bindToAddr(3,"c_p_address_dy","&addr=" + $("#c_p_address_ld").val());
			}
		});
		//选择单元后更新门牌数据
		$("#c_p_address_dy").change(function(){
			//alert($("#c_p_address_xq").val()); 
			var addr = $("#c_p_address_dy").val();
			if(addr!="")
			{
				c_p_bindToAddr(4,"c_p_address_mp","&addr=" + addr);
			}
		});
		
		$("#c_p_address_bnok").click(function(){
			
			var info = "";
			var errinfo = "";
			
			var elems = ['xq','ld','dy','mp'];
			var infoo = ['小区号','楼栋号','单元号','门牌号'];
			
			for(var j=0;j<4;j++)
			{
				if($("#c_p_address_"+elems[j]).val() != "")
				{
					info += $("select[id='c_p_address_"+elems[j]+"'] :selected").html();
					info += ",";
				}else if(resto!=undefined){
				    errinfo += infoo[j];
					errinfo += ",";
				}	
			}
			info = info.replace(new RegExp(",","g"),"");
			
			if(info=="")
			{
				alert("请选择地址");
				$("#c_p_address_xq").focus();
			}
			else
			{
				//返回 地址写入查询框
				$("#kdSearchBox").val(info);
				//关闭面板
				$("#c_p_address").hide('slow');
				
				$("#kdSearchBox").select();
				$("#kdSearchBox").focus();
			}			
			
		});
		
		$("#c_p_address_bncancel").click(function(){
			//关闭面板
			$("#c_p_address").hide('slow');
		});
	}
	
	var resto="";
	/**
	 * 地址绑定函数
	 * @param UserName 待查询的宽带账号
	 * @return
	 */
	function c_p_bindToAddr(idx,selid,param)
	{		     
		var seluserarea = $("select[id='seluserarea'] :selected").html();
		
		var res = fetchMultiArrayValue("AddressBox.query"+idx,6,param+"&addrarea="+tsd.encodeURIComponent(seluserarea));
		var elems = ['xq','ld','dy','mp'];
		//alert(res[0] == undefined + ":" + res[0][0] == undefined);
		resto=res[0][0];
		if(res[0] == undefined || res[0][0] == undefined || res[0] == "")
		{
			for(var j=idx;j<=4;j++)
			{
				$("#c_p_address_"+elems[j-1]).empty();
				$("#c_p_address_"+elems[j-1]).append("<option value=\"\">--请选择--</option>");
			}
			
			return false;
		}
		$("#"+selid).empty();
		$("#"+selid).append("<option value=\"\">--请选择--</option>");
		var quanju="";
		for(var i=0;i<res.length;i++)
		{
		    var ee="<option value='"+res[i][0]+"'>"+res[i][1]+"</option>";	
		    quanju+=ee					
		}
		 $("#"+selid).html($("#"+selid).html()+quanju);
		//重置索引  > idx + 1 的下拉框
		for(var j=idx + 1;j<=4;j++)
		{
			$("#c_p_address_"+elems[j-1]).empty();
			$("#c_p_address_"+elems[j-1]).append("<option value=\"\">--请选择--</option>");
		}
	}
	
	</script>

  </head>
  
  <body style="text-align:left;">
    <div id="navBar1">
		<img src="style/icon/dot11.gif" style="margin-left: 10px" />
		<fmt:message key="global.location" />:
	</div>

	<div id="kdBar">		
		<span id="kdsWay">			
			查询方式
			<select id="kdSearchWay">
				<option value="0">账号</option>
				<option value="1">电话</option>
				<option value="2">用户名</option>
				<option value="3">用户地址</option>
			</select>
		</span>
		<input type="text" class="inputbox" id="kdSearchBox" name="kdSearchBox" /><button class="tsdbutton" id="kdSearchByUserName">查找</button><button class="tsdbutton" id="kdFinddFault">故障信息</button>
		
	</div>
		
	<div id="fault" style="display:none;">
		<br />
		<div id="input-Unit" style="margin-bottom:0px;">
			<div class="title" style="line-height:32px;">
				&nbsp;&nbsp;
				<img src="style/icon/45.gif" />
				故障信息
			</div>
			<table id="kdFaultInfoT" width="960" border="1" bordercolor="#eeeeee" cellspacing="0" cellpadding="1" style="background-color:#eeeeee;border-collapse:collapse" bgcolor="#eeeeee">
				<tr>
					<td width="100">时间</td><td width="220"><span id="kdFaultTime"></span></td><td width="100">信息</td><td><span id="kdFaultInfo"></span></td>
				</tr>
				<tr>
					<td width="100">原因</td><td colspan="3"><span id="kdFaultReason"></span></td>
				</tr>
			</table>	
		</div>
	</div>
	<br/>
	<div id="input-Unit" style="margin-bottom:0px;">
		<div id="">
			<div class="title" style="line-height:32px;">
				&nbsp;&nbsp;
				<img src="style/icon/45.gif" />
				用户信息
			</div>
		</div>
	</div>

	<table id="kdInfo" width="960" border="1" bordercolor="#eeeeee" cellspacing="0" cellpadding="1" style="background-color:#eeeeee;border-collapse:collapse" bgcolor="#eeeeee">
		<tr>
			<td width="100">账号</td><td width="200"><span id="kdinUserName"></span></td><td width="100">姓名</td><td width="200"><span id="kdinsRealName"></span></td><td width="100">电话</td><td width="200"><span id="kdinsdh"></span></td>
		</tr>
		<tr>
			<td>用户状态</td><td><span id="kdiniStatus"></span></td><td>用户类型</td><td><span id="kdinUserType"></span></td><td>计费规则</td><td><span id="kdinfeename"></span></td>
		</tr>
		<tr>
			<td>实时余额</td><td><span id="kdinYE"></span></td><td>出账月余额</td><td><span id="kdinRemainFee"></span></td><td>新月未出账金额</td><td><span id="kdinFee5"></span></td>
		</tr>
		<tr>
			<td>移动电话</td><td><span id="kdinMobile"></span></td><td>联系人</td><td><span id="kdinlxr"></span></td><td>联系电话</td><td><span id="kdinlxdh"></span></td>
		</tr>
		<tr>
			<td>密码</td><td><span id="kdinPassword"></span></td><td>证件类型</td><td><span id="kdinZJ"></span></td><td>证件号码</td><td><span id="kdinzjhm"></span></td>
		</tr>
		<tr>
			<td>一级部门</td><td><span id="kdinsBm1"></span></td><td>二级部门</td><td><span id="kdinsBm2"></span></td><td>三级部门</td><td><span id="kdinsBm3"></span></td>
		</tr>
		<tr>
			<td>四级部门</td><td><span id="kdinsBm4"></span></td><td>地址</td><td><span id="kdinsAddress"></span></td><td>开户日期</td><td><span id="kdinsRegDate"></span></td>
		</tr>
		<tr>
			<td>宽带提速</td><td colspan="3"><span id="kdints"></span></td><td>带宽</td><td><span id="kdinspeed"></span></td>
		</tr>
		<tr>
			<td>同时在线数</td><td colspan="1"><span id="kdinzx"></span></td><td>套餐类型</td><td><span id="kdinpackagename"></span></td><td>套餐宽带费</td><td><span id="kdinpackagetype"></span></td>
		</tr>
		<tr>
			<td>绑定IP</td><td><span id="kdinip"></span></td><td>绑定VLANID</td><td><span id="kdinvlanid"></span></td><td>MAC地址</td><td><span id="kdinwk"></span></td>
		</tr>
	</table>
			


	<div id="input-Unit" style="margin-bottom:0px;">
		<div id="">
			<div class="title" style="line-height:32px;">
				&nbsp;&nbsp;
				<img src="style/icon/45.gif" />
				缴费历史
			</div>
		</div>
	</div>

	<div id="kdjf"></div>
	<br />
	<div id="input-Unit" style="margin-bottom:0px;">
		<div id="">
			<div class="title" style="line-height:32px;">
				&nbsp;&nbsp;
				<img src="style/icon/45.gif" />
				工单历史
			</div>
		</div>
	</div>
	<div id="kdjob"></div>
	
	
	<br />
	<div id="input-Unit" style="margin-bottom:0px;">
		<div id="">
			<div class="title" style="line-height:32px;">
				&nbsp;&nbsp;
				<img src="style/icon/45.gif" />
				扣费信息
			</div>
		</div>
	</div>
	<div id="kdkf"></div>

	<!-- 宽带缴费查询面板 -->
	<div class="neirong" id="multiSearch" style="display:none;width:720px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						宽带缴费用户信息查询
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#kdMultiSearchClose').click();">关闭</a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;width:718px;overflow-x:hidden;">
			<div id="grid"></div>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="kdMultiSearchClose">
				关闭
			</button>
		</div>
	</div>

	<input type="hidden" id="skrid" name="skrid" value='<%=request.getSession().getAttribute("userid") %>' />
  	<input type="hidden" id="area" name="area" value='<%=request.getSession().getAttribute("userarea") %>' />
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />

	<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>' />
	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
	
	<input type='hidden' id='faultright' /> 
	</body>
</html>
