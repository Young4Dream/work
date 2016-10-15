<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>修改滞纳金标志</title>
    
	<!-- 导入的js文件 -->
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
	<script src="script/public/mainStyle.js" type="text/javascript"></script>
	<!-- 弹出对话框需要导入的js文件 -->
	<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
	<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
	<!-- tab滑动门需要导入的包 *注意路径 -->
	<script src="plug-in/jquery/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<!-- tab滑动门 需要导入的样式表 *注意路径-->
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
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />

	<style type="text/css">
		.tsdbutton{margin:2px;padding:2px 12px 2px 12px;height:24px;margin-bottom:0px;}
		.tsdbtn{line-height:28px;padding:2px 12px 2px 12px;  height:28px; margin-top:4px; margin-left:5px; background: url(style/imgs/buttonbg.jpg) repeat-x; border: #CCCCCC 1px solid; cursor: pointer; }
		.inputbox{{margin-left:10px; background:url(style/imgs/inputText_bg.jpg) repeat-x ; width:180px; border:#999999 solid 1px;  text-align:left; color:#000000; font-size:12px; font-weight:bold; height:22px; line-height: 23px; }}
		#queryhthtab{width:780px;}
		#queryhthhftab{width:980px;}
		#queryhthtab tr th,#queryhthhftab tr th{border:1px solid #F6FbFe;background-color:#A9C8D9;height:32px;}
		#queryhthtab tr td,#queryhthhftab tr td{border:1px solid #A9C8D9;height:32px;}
		
	</style>
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
		
	<script type="text/javascript">
	$(function(){
		$("#navBar").append(genNavv());		
		gobackInNavbar("navBar");
		$("#queryhth").select().focus();
		$("#queryhth").keydown(function(event){
			if(event.keyCode==13)
			{
				ghSearch();
			}
		});
		$("#queryhthtab :checkbox,#queryhthhftab :checkbox").live("click",function(){
			if($(this).attr("checked")==true)
				$(this).attr("newval","1");
			else
				$(this).attr("newval","0");
		});
	});
	
	function ghSearch()
	{
		var queryhth = $("#queryhth").val();
		if($.trim(queryhth)=="")
		{
			alert("请输入要查询的电话号码或合同号");
			$("#queryhth").select().focus();
		}
		else
		{
			var hth = fetchSingleValue("modifyznj.checked",6,"&hth=" +　queryhth);
			if(hth=="" || hth==undefined)
			{
				alert("用户 " + queryhth + " 不存在");
				$("#localdata").removeData("hth");
				$("#queryhthtab tr:gt(0)").remove();
				$("#queryhthhftab tr:gt(0)").remove();
			}
			else
			{
				$("#localdata").data("hth",hth);
				getHthInfo(hth);
				getHthhf(hth);
			}
		}
	}
	function getHthInfo(queryhth)
	{
		var res = fetchMultiArrayValue("modifyznj.qhth",0,"&hth=" + queryhth);
		var tabHtml = "";
		if(res[0]!=undefined && res[0][0]!=undefined)
		{
			tabHtml += "<tr>";
			
			tabHtml += "<td><input type=\"checkbox\" id=\"hthd_chk\" newval=\"" + res[0][5] + "\" value=\"" + res[0][5] +  "\"";
			tabHtml += res[0][5]=="1"?" checked=\"checked\" ":"" ;
			tabHtml += " /></td>";
			
			tabHtml += "<td>";
			tabHtml += res[0][0];
			tabHtml += "</td>";
			tabHtml += "<td>";
			tabHtml += res[0][1];
			tabHtml += "</td>";
			
			tabHtml += "<td>";
			tabHtml += res[0][2];
			tabHtml += "</td>";
			tabHtml += "<td>";
			tabHtml += res[0][3];
			tabHtml += "</td>";
			
			tabHtml += "<td>";
			tabHtml += res[0][4];
			tabHtml += "</td>";
			tabHtml += "<td>";
			tabHtml += res[0][6];
			tabHtml += "</td>";
			
			tabHtml += "</tr>";
			
		}
		else
		{
			//alert("用户 " + queryhth + " 不存在");
		}
		
		$("#queryhthtab tr:gt(0)").remove();
		$("#queryhthtab").append(tabHtml);
	}
	
	function getHthhf(queryhth)
	{
		var res = fetchMultiArrayValue("modifyznj.qhthhf",0,"&hth=" + queryhth);
		var tabHtml = "";
		if(res[0]!=undefined && res[0][0]!=undefined)
		{
			for(var ii=0;ii<res.length;ii++)
			{
				tabHtml += "<tr>";
				
				tabHtml += "<td><input type=\"checkbox\" id=\"hf_chk_" + res[ii][0] + "\" hzyf=\"" + res[ii][0] + "\" newval=\"" + res[ii][4] + "\" value=\"" + res[ii][4] +  "\"";
				tabHtml += res[ii][4]=="1"?" checked=\"checked\" ":"" ;
				tabHtml += " /></td>";
				
				tabHtml += "<td>";
				tabHtml += res[ii][0];
				tabHtml += "</td>";
				tabHtml += "<td>";
				tabHtml += res[ii][1];
				tabHtml += "</td>";
				
				tabHtml += "<td>";
				tabHtml += res[ii][2];
				tabHtml += "</td>";
				tabHtml += "<td>";
				tabHtml += res[ii][3];
				tabHtml += "</td>";
				
				tabHtml += "<td>";
				tabHtml += res[ii][10];
				tabHtml += "</td>";
				tabHtml += "<td>";
				tabHtml += res[ii][5];
				tabHtml += "</td>";
				
				tabHtml += "<td>";
				tabHtml += res[ii][6];
				tabHtml += "</td>";
				tabHtml += "<td>";
				tabHtml += res[ii][7];
				tabHtml += "</td>";
				
				tabHtml += "<td>";
				tabHtml += res[ii][8];
				tabHtml += "</td>";
				tabHtml += "<td>";
				tabHtml += res[ii][9];
				tabHtml += "</td>";
				
				tabHtml += "</tr>";
			}
		}
		else
		{
			//alert("用户 " + queryhth + " 不存在");
		}
		
		$("#queryhthhftab tr:gt(0)").remove();
		$("#queryhthhftab").append(tabHtml);
	}
	
	function updateHthdang()
	{
		if($("#localdata").data("hth")==undefined)
		{
			alert("请先查询要修改滞纳金标志的用户");
			$("#queryhth").select().focus();
			return;
		}
		
		if($("#hthd_chk").attr("newval")==$("#hthd_chk").val())
		{
			alert("当前账号滞纳金标志无修改");			
			return false;
		}
		var res = false;
		if($("#hthd_chk").attr("checked")==true)
		{
			res = executeNoQuery("modifyznj.modifyhth",6,"&hth=" + $("#localdata").data("hth") + "&znjbz=1");			
		}
		else
		{
			res = executeNoQuery("modifyznj.modifyhth",6,"&hth=" + $("#localdata").data("hth") + "&znjbz=0");
		}
		if(res==true || res=="true")
		{
			alert("成功修改档案表滞纳金标志");
		}
		else
		{
			alert("修改失败");
		}
		getHthInfo($("#localdata").data("hth"));
	}
	
	function updateHthhf()
	{
		if($("#localdata").data("hth")==undefined)
		{
			alert("请先查询要修改滞纳金标志的用户");
			$("#queryhth").select().focus();
			return;
		}
		
		var chged = false;
		$("#queryhthhftab :checkbox").each(function(){
			if($(this).attr("newval")!=$(this).val())
				chged = true;
		});
		if(!chged)
		{
			alert("当前账号滞纳金标志无修改");			
			return false;
		}
		
		var hthschecked = "";
		var hthsnotchecked = "";
		$("#queryhthhftab :checkbox").each(function(){
			if($(this).attr("checked")==true)
				hthschecked += ",'" + $(this).attr("hzyf") + "'";
			else
				hthsnotchecked += ",'" + $(this).attr("hzyf") + "'";
		});
		hthschecked = hthschecked.replace(",","");
		hthsnotchecked = hthsnotchecked.replace(",","");
		if(hthschecked=="") hthschecked = "'0'";
		if(hthsnotchecked=="") hthsnotchecked = "'0'";
		
		var res = false;
		res = executeNoQuery("modifyznj.modifyhthhf",6,"&hth=" + $("#localdata").data("hth") + "&hzyfschecked=" + encodeURIComponent(hthschecked) + "&hzyfsnotchecked=" + encodeURIComponent(hthsnotchecked));			
		
		if(res==true || res=="true")
		{
			alert("成功修改收费信息表滞纳金标志");
		}
		else
		{
			alert("修改失败");
		}
		getHthhf($("#localdata").data("hth"));
	}
	
	function refreshZnj()
	{
		if($("#localdata").data("hth")==undefined)
		{
			alert("请先查询要重算滞纳金的用户");
			$("#queryhth").select().focus();
			return;
		}
		if(confirm("你确定要重新计算滞纳金么?"))
		{
			var urll = tsd.buildParams({ packgname:'service',
					clsname:'Procedure',//类名
					method:'exequery',//方法名
					ds:'tsdCharge',
					tsdExeType:'query',//操作类型 
					datatype:'xmlattr',//返回数据格式 
					tsdpname:'modifyznj.modify'
				});
			loadPopup();
			$.ajax({
				url:"mainServlet.html?" + urll + "&hth=" + $("#localdata").data("hth"),
				async:true,
				cache:false,
				timeout:100000,
				type:'post',
				success:function(xml){
					var res = $("row:first",xml).attr("lg_desc");
					alert(res);	
					
					disablePopup();
				},
				complete:function(){
					disablePopup();
				}
			});
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
  </head>
  
  <body>
    <div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />
		:
	</div>
	<label>
		电话或合同号：
		<input type="text" class="inputbox" id="queryhth" />
	</label>
	<button class="tsdbutton" onclick="ghSearch()">查询</button>
	
	<br />
	<h2>档案信息</h2>
	<table id="queryhthtab">
		<tr>
			<th> </th><th>合同号</th><th>用户姓名</th><th>一级部门</th><th>二级部门</th><th>用户地址</th><th>滞纳金标志</th>
		</tr>
	</table>
	<button class="tsdbutton" onclick="updateHthdang()">修改档案表滞纳金标志</button>
	<h2>扣费信息</h2>
	<table id="queryhthhftab">
		<tr>
			<th> </th><th>汇总月份</th><th>合同号</th><th>电话</th><th>用户姓名</th><th>滞纳金标志</th><th>上月余额</th><th>费用合计</th><th>应缴费</th><th>滞纳金</th><th>减免费</th>
		</tr>
	</table>
	<button class="tsdbutton" onclick="updateHthhf()">修改收费信息表滞纳金标志</button>
	<button class="tsdbutton" onclick="refreshZnj()">重新计算滞纳金</button>
	<div id="localdata"></div>
	<div id="loading">
		<div style="height:40px"></div>
		<img src="style/images/public/loading.gif" />
		<br />
		正在重算滞纳金……
		<br />
		<div id="ontimehzinfo" style="border-top:1px solid #ccc;max-heigth:400px;overflow-y:auto;">
		</div>
	</div>
	<div id="backgroundPopup"></div>
  </body>
</html>
