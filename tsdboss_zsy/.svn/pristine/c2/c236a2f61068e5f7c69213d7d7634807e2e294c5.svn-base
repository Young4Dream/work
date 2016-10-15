<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
	String userid = (String) session.getAttribute("userid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>The billing month Archive</title>  
    
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
	<script type="text/javascript">
	$(function(){
		
		$("#navBar").append(genNavv());
		gobackInNavbar("navBar");
		getMonth();
		
	});
	function getCurrentMonth()
	{
		var users='<%=session.getAttribute("userid") %>';
		var tablename=$("#tablename").val();
		var hzyf = fetchSingleValue("revenue.globalParam5",6,"");
		var month=$("#month").val();
		if(hzyf!=undefined && hzyf!="")
		{
			//
			if(confirm("<fmt:message key='hfgd.currentpaymonth' />" + hzyf + "<fmt:message key='hfgd.issure' />"))
			{
				var exists = fetchSingleValue("hfgd.existscurr",6,"&hzyf=" + hzyf+'&tablename='+tablename+'_billing');
				if(hzyf!=undefined && hzyf!="" && exists!=undefined && exists!="")
				{
					if(exists!="0")
					{
						
						//if(confirm("已存在 " + hzyf + " 的计费月归档数据，重新归档将覆盖已有数据，是否重新归档？"))
						if(confirm("<fmt:message key='hfgd.Alreadyexists' />" + hzyf + "<fmt:message key='hfgd.ifTofile' />"))
						{
							
						}
						else
						{
							return false;
						}
					}
					var urll = tsd.buildParams({ packgname:'service',
							clsname:'Procedure',//类名
							method:'exequery',//方法名
							ds:'tsdCharge',
							tsdExeType:'query',//操作类型 
							datatype:'xmlattr',//返回数据格式 
							tsdpname:'exarchive.userinfo'
						});
					loadPopup();
					$.ajax({
						url:"mainServlet.html?" + urll+'&archivemonth='+tsd.encodeURIComponent(month)+'&userid='+tsd.encodeURIComponent(users)+'&tablename='+tsd.encodeURIComponent(tablename),
						async:true,
						cache:false,
						timeout:100000,
						type:'post',
						success:function(xml){
							var res = $("row:first",xml).attr("res");
							if(res=="SUCCESS"){
								//alert("成功归档当前计费月数据");
								alert("<fmt:message key='hfgd.success' />");
							}
							else
							{
								alert("<fmt:message key='hfgd.Failure' />");
								//alert("归档失败");	
							}
							disablePopup();
						},
						complete:function(){
							disablePopup();
						}
					});
				}
				else
				{
					//alert("获取数据失败");
					alert("<fmt:message key='hfgd.getdatafailure' />");
				}
			}
		}
	}
	
	function getMonth(){
		var res = fetchMultiArrayValue("hfgd.getmonth",6,"");
		if(res[0]==undefined||res[0][0]==undefined||res[0][0]==""||res[0]=="")
		{
			
		}else{
			var str="";
			for(var n=0;n<res.length;n++){
				str += "<option value='"+res[n][0]+"'>"+res[n][0]+"</option>"
				//document.getElementById("month").options.add(new Option(res[0][j],res[0],[j]));
			};
			$("#month").html(str);
		}
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
	</script>
	<style type="text/css">
		label{float:right;text-align:left;margin-left:0px;}
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
	</style>
  </head>
  
  <body>
  	<div id="navBar">
		mo<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:
	</div>
    <fieldset style="border:1px solid #cccccc;margin-left:200px;margin-right:200px;margin-top:100px;">
		<legend style="font-size:14px;"><!-- 计费月收入归档 --><fmt:message key="hfgd.Thebillingmonthincome" /></legend>
		&nbsp;<select id='tablename'>
		<option value='yhdang'><!-- 用户档案归档 --><fmt:message key="hfgd.userFilearchiving" /></option>
		<option value='hthdang'><!-- 合同号档案归档 --><fmt:message key="hfgd.hthFilearchiving" /></option>
		<option value='attachfee'><!-- 月固定费归档 --><fmt:message key="hfgd.MonthlyfeeFilearchiving" /></option>
		<option value='hfintime'><!-- 套餐费用归档 --><fmt:message key="hfgd.SetfeeFilearchiving" /></option>
		<option value='insteadoffee'><!-- 代缴费用归档 --><fmt:message key="hfgd.BillpaymentFilearchiving" /></option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select id='month'></select>
		<br />
	    <button class="tsdbutton" onclick="getCurrentMonth()">
	    <!-- 计算当前收费月月收入归档数据 -->
	    <fmt:message key="hfgd.Calculationdata" />
	    </button> 
	    <br />
    </fieldset>
	<div id="loading">
		<div style="height:40px"></div>
		<img src="style/images/public/loading.gif" />
		<br />
		<!-- 正在归档当前计费月收入…… -->
		<fmt:message key="hfgd.incomeing" />
		<br />
		<div id="ontimehzinfo" style="border-top:1px solid #ccc;max-heigth:400px;overflow-y:auto;">
		</div>
	</div>
	<div id="backgroundPopup"></div>
  </body>
</html>
