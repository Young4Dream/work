<%----------------------------------------
	name: publishData.jsp
	author: chenze
	version: 1.0, 2010-11-5
	description: 发布营收数据
	modify: 
		2009-11-3  chenze  添加注释，移植到oracle平台
		2009-11-25 chenze  修改发布按钮位置
		2009-12-8  chenze  edb下调试，修改过程调用参数格式
		
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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

	<!-- 弹出对话框需要导入的js文件 -->
	<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
	<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
	<!-- dtree需要导入文件 -->
	<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
	<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />
	
	<script src="plug-in/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
	<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
	<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen"/>
		

	<!-- 关于字符串需要用到的js -->
	<script type="text/javascript" src="script/public/main.js"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<style type="text/css">
	#container td{padding:10px;}
	.datDrop{width:56px;}
	.txtInfo{width:320px;height:220px;overflow:auto;}
	.divCont{width:200px;height:160px;overflow-y:auto;}
	.divCont ul{padding-left:0px;}
	fieldset{padding-right:0px;}
	.btns,#kdButtons,#ghButtons{width:100%; float:left; *float:none; height:36px; background:url(style/imgs/buttonsbg.jpg) repeat-x; border-top:#CCCCCC 1px solid;border-bottom:#CCCCCC 1px solid;}
	</style>
	<script type="text/javascript">
	$(function(){
		initialBar();
		$("#queryparam td:even").css({"background-color":"#c9d4ea","text-align":"right","padding-right":"1em"});
		
		//initYhxz();
		//initSffs();
		//initSfkm();
		//initSfmonth();//
		//loadPopup();
		fetchHzyf();
		fetchYhlb();
	});	
	
	//初始化导航栏
	function initialBar()
	{
		$("#navBar").append(genNavv());			
		gobackInNavbar("navBar");			
		if($.browser.mozilla)
		{
			//alert("F");
			//$("#printReportDirect").css("visibility","hidden");
		}
	}
	
	/**
	 * 初始化汇总月份
	 * @param 无参数
	 * @return 无返回值
	 */
	function fetchHzyf()
	{
		var res = fetchMultiValue("hfhz.newhzyf",6,"");
		$.each(res,function(i,n){
			$("#sfyf_hzyf").append("<option>" + n + "</option>");
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
		
	function initYhxz()
	{
		var yhxz = fetchMultiValue("publishData.yhxz",6,"");
		var yhxzHtml = "<ul>";
		if(yhxz!=undefined && yhxz[0]!=undefined)
		{
			for(var i=0;i<yhxz.length;i++)
			{
				yhxzHtml += "<li><label><input type=\"checkbox\" name=\"yhxz_@" + yhxz[i] + "\" id=\"yhxz_@" + yhxz[i] + "\" />" + yhxz[i] + "</label></li>";
			}
		}
		yhxzHtml += "</ul>";
		//alert(yhxzHtml);
		$("#yhxzDiv").html(yhxzHtml);
	}
	//加载收费方式模块
	function initSffs()
	{
		var sffs = fetchMultiValue("publishData.payitem",6,"");
		var sffsHtml = "<ul>";
		if(sffs!=undefined && sffs[0]!=undefined)
		{
			for(var i=0;i<sffs.length;i++)
			{
				sffsHtml += "<li><label><input type=\"checkbox\" name=\"sffs_@" + $.trim(sffs[i]) + "\" id=\"sffs_@" + $.trim(sffs[i]) + "\" />" + $.trim(sffs[i]) + "</label></li>";
			}
		}
		sffsHtml += "</ul>";
		//alert(sffsHtml);
		$("#sffsDiv").html(sffsHtml);
	}
	//加载收费科目模块
	function initSfkm()
	{
		var sfkm = fetchMultiValue("publishData.kemu",6,"");
		var sfkmHtml = "<ul>";
		if(sfkm!=undefined && sfkm[0]!=undefined)
		{
			for(var i=0;i<sfkm.length;i++)
			{
				sfkmHtml += "<li><label><input type=\"checkbox\" name=\"sfkm_@" + $.trim(sfkm[i]) + "\" id=\"sfkm_@" + $.trim(sfkm[i]) + "\" />" + $.trim(sfkm[i]) + "</label></li>";
			}
		}
		sfkmHtml += "</ul>";
		//alert(sffsHtml);
		$("#sfkmDiv").html(sfkmHtml);
	}
	//初始化当前时间
	function initSfmonth()
	{
		var sfsj = fetchMultiArrayValue("publishData.sfMonth",6,"");
		if(sfsj[0]==undefined || sfsj[0][0]==undefined)
		{
			alert("初始化时间失败");return;
		}
		else
		{
			var sfsjm = sfsj[0][1];
			var optHtml = "";
			sfsjm = parseInt(sfsjm) + 5;
			for(var i=0;i<10;i++)
			{
				optHtml += "<option value=\""+(sfsjm)+"\">" + (sfsjm--) + "</option>";
			}
			$("#sfyf_year").html(optHtml).val(sfsj[0][1]);
			optHtml = "";
			for(var i=1;i<=12;i++)
			{
				optHtml += "<option value=\""+(i<10?"0"+i:i)+"\">" + (i<10?"0"+i:i) + "</option>";
			}
			$("#sfyf_month").html(optHtml).val(sfsj[0][2]);
			
			
		}
	}
	//检测本月是否已经存在发布数据以确定是否继续发布
	function checkPub()
	{
		var res = fetchSingleValue("publishData.check",1,"&Hzyff=" + $("#sfyf_hzyf").val());
		if(res=="" || res==undefined)
		{
			return true;
		}
		else
		{
			if(confirm("存在本月的收费信息，继续发布吗？"))
			{
				return true;
			}
			else return false;
		}
	}
	/**
	 * 当发布成功之后，取发布结果信息
	 * 结果保存到ID为txtVal的文本域中
	 */
	function initResultInfo()
	{
		var resu = fetchMultiValue("hfhz.log",6,"&lgproc=MadeShouFei&userid=" + tsd.encodeURIComponent(UserID) + "&begindate=" + encodeURIComponent(dateNow));
		if(resu[0]!=undefined)
		{
			resu = resu.join("\n");
		}
		else
		{
			resu = "";
		}
		$("#txtVal").val(resu);
	}
	/**
	 * 发布数据
	 * 
	 */
	function beginPublish()
	{
		//要求确认是否发布
		if(confirm("确定发布收费信息吗？"))
		{
			//检测是否已有本月的发布数据 如果有需要确认是否继续
			if(checkPub())
			{
				if(confirm("在发布信息时，请所有营业员停止收费，继续发布？"))
				{
					dateNow = fetchSingleValue("hfhz.now",6,"");
					var sfmonth = $("#sfyf_hzyf").val();
					var params = "&SfMonth="+sfmonth;
					
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
						params += "&Hth="+HthLimit;
					}
					
					params += "&UserID="+"${userid}";
					loadPopup();
					hz_success_falg = 0;
					refreshOntimeInfo();
					//alert(params);
					//alert(params);return false;
					//executeNoQueryProc("publishData.MadeShouFei",6,params);
					var urll = tsd.buildParams({ packgname:'service',
								clsname:'Procedure',//类名
								method:'exequery',//方法名
								ds:'tsdBilling',
								tsdExeType:'exe',//操作类型 
								datatype:'xml',//返回数据格式 
								tsdpname:'publishData.MadeShouFei'
								});
					//执行发布请求，成功之后调用initResultInfo()方法显示结果
					$.ajax({
						url:"mainServlet.html?" + urll + params,
						async:true,
						cache:false,
						timeout:200000,
						type:'post',
						success:function(xml){
							if(xml=="true")
							{
								initResultInfo();
								alert("发布成功");
							}
							else
							{
								alert("发布失败");
							}
							hz_success_falg = 1;
							disablePopup();
						},
						complete:function(){
							setTimeout("initResultInfo()",20000);
							hz_success_falg = 1;
							disablePopup();
						}
					});
				}
			}
		}
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
			url:"mainServlet.html?" + urlMm + "&lgproc=MadeShouFei&userid=" + tsd.encodeURIComponent(UserID) + "&begindate=" + encodeURIComponent(dateNow),
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
					setTimeout("refreshOntimeInfo()",20000);
			}
		});
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
			
		$("#hthDiv").val("");
		$("#txtVal").val("");
	
	}
	
	//不同类型切换
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
		/*label{float:right;text-align:left;margin-left:0px;}*/
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
		#sfyf_hzyf,#ptype_rd_commonuser,#ptype_rd_biguser{margin-left:2px;}
		#feedetailcontainer{width:600px;margin:auto;}
		#feedetailcontainer{margin-left:20px;}
		.feedetail{border:#7691c7 0px solid;width:560px;margin-left:auto;margin-right:auto;margin-top:20px;}
		.feedetail td{line-height:28px;border:#7691c7 0px solid;}
	</style>
	</head>

	<body>
		<div id="navBar">
			<img src="style/icon/dot11.gif" />
			<fmt:message key="global.location" />:		
		</div>
		
		<table id="queryparam">
		<tr>
			<td width="25%">收费月份</td>
			<td>
				<select name="sfyf_hzyf" id="sfyf_hzyf" style="width: 200px;margin-top: 5px;margin-bottom: 5px;">
				</select>
				<button class="tsdbutton" onclick="beginPublish();" style="margin-left: 20px;margin-top: 5px;margin-bottom: 5px;">发布</button>
				<button class="tsdbutton" onclick="clearall();" style="margin-right: 20px;margin-top: 5px;margin-bottom: 5px;">清空</button>
			</td>
		</tr>
		<tr>
			<td width="25%"><label for="chargeType1"><input type="radio" name="chargeType" value="1" id="chargeType1" onclick="changeChargeType();"/>按用户类别</label></td>
			<td style="text-align:left;">
				<span id="yhlb"></span>
			</td>
		</tr>
		<tr>
			<td width="25%"><label for="chargeType2"><input type="radio" name="chargeType" id="chargeType2" checked value="0" onclick="changeChargeType();"/>按合同号</label> </td>
			<td>
				<textarea name="hthDiv" id="hth" class="inputbox" style="width:200px;height:150px;"></textarea>
				<font color="red">(可指定多合同号,每个合同号一行)</font>
			</td>
		</tr>
		<tr>
			<td width="25%">发布日志</td>
			<td>
				<textarea name="txtVal" id="txtVal" class="inputbox" style="width:412px;height:200px;overflow-y:auto" readonly="readonly"></textarea>
			</td>
		</tr>
	</table>
		
		
		
		<fieldset style="margin-left:200px;margin-right:200px;margin-top:100px;display: none;">
			<legend style="font-size:14px;">话费发布</legend>
			<table id="container" width="680">
				<tr>
					<td>
						收费月份
						<!-- <select class="datDrop" id="sfyf_year"></select>年<select class="datDrop" id="sfyf_month"></select>月 -->
						<select id="sfyf_hzyf1" style="width:150px"></select>
						<br />
						<br />
						仅发布以下合同号
						<textarea class="divCont" id="hthDiv1"></textarea>
					</td>
					
					<td>
						发布日志
						<textarea class="txtInfo" id="txtVal1" style="" readonly="readonly"></textarea>
						<br />
						
					</td>
				</tr>
				<tr>
					<td colspan="3" align="center">
						<button class="tsdbutton" onclick="beginPublish()">发  布</button>
					</td>
				</tr>
			</table>
		</fieldset>
		
		<div id="loading">
			<div style="height:40px"></div>
			<img src="style/images/public/loading.gif" />
			<br />
			正在发布收费数据……
			<br />
			<div id="ontimehzinfo" style="border-top:1px solid #ccc;max-heigth:400px;overflow-y:auto;">
			</div>
		</div>
		  <div id="backgroundPopup"></div>
	</body>
</html>
