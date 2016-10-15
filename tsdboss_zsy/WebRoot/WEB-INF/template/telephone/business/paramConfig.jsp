<%-- 
    File Name:  tariff/Set1rate.jsp
    Function:   
    Author:     chenze
    Date:       2010-10-11
    Description: 
    Modify:     youhongyu 移植 	
                2010-11-5   chenze  添加注释
                2010-11-10   尤红玉  头部注释
                2010-11-26  chenze  增加高级查询和导出数据时Blob字段转换
                2010-12-10  liwen   修改，新增，查询弹出面板的标题修改
                2010-12-15 youhongyu   修改本查询为模板功能，使其能区分本次要保存的查询内容是来自哪个表
                2010-12-17 youhongyu   查询有问题，输入计费网名为公网，查询不出结果.解决方法：将附有初始值的text框的值置空
                					    打开通用查询，头部无法正确显示当前批操作类型问题更正
                
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>

<%
	String imenuid = request.getParameter("imenuid");
	String zid = (String)session.getAttribute("groupid");//request.getParameter("groupid");
	String lanType = (String) session.getAttribute("languageType");
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Definition relay Bureau to Group</title>
   
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="AeroWindow/js/jquery-1.4.2.min.js" type="text/javascript"></script>
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
		
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script type="text/javascript" src="script/public/datalength.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<!-- 资费菜单样式 -->
		<link href="style/css/pubMode/tariff.css" rel="stylesheet" type="text/css" />
		<!-- 日期插件 -->	
		<!--<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>		
		
		--><!-- 分项卡 -->	
		<script src="plug-in/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
		
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen"/>
					
		<style type="text/css">
			.header { 
				font-size: 100%; font-weight: bold; text-align: left;
				padding: 2px;
				background-image: url(images/headerbg.gif) ;
				color: #FFFFFF;
				width: 100%;
				height:10px;
				white-space: nowrap;
			}
		</style>
	<script type="text/javascript">
	
	</script>
	<script type="text/javascript">
	
	$(function(){
	
		initData();//初始化数据
		
		var stantartThreadNum = $("#StantartThreadNum").val();
		if(stantartThreadNum != null && stantartThreadNum != undefined){
			if(stantartThreadNum == 1){
				$("#StantartThreadNum").attr("disabled",true);
			}
		}
		
		$("#Model").change(function(){
			if($(this).val() == 1){
				$("#StantartThreadNum").val(1);
				$("#StantartThreadNum").attr("disabled",true);
			}else if($(this).val() == 2){
				$("#StantartThreadNum").attr("disabled",false);
			}
		});
	});
	
	
	
	//初始化数据
	function initData(){
		var urlstr='';
		var dsstr = 'tsdBilling';
		var tsdcfstr = 'oracle';
		urlstr=tsd.buildParams({ 	  
			  packgname:'service',//java包
			  clsname:'OceParaService',//类名
			  method:'query',//方法名
			  ds:dsstr,//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
			  tsdcf:tsdcfstr,//指向配置文件名称
			  tsdoper:'query',//操作类型 
			  datatype:'xml',//返回数据格式 
			  tsdpk:'publicmode.sumKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		});	
		$.ajax({
			url:"mainServlet.html?"+urlstr,
			type:'post',
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				$("#tab").html("");
				
				if(xml != ''){
					var items = $.parseJSON(xml);
					
					//构建标签
					$.each(items, function(i, item) {
						var inputBox = '';
						var nullable = '';
						if(item.nullable == 'N'){
							nullable = '<font style="color:red;">*</font>';
						}
						if(item.isselect == 'Y'){
							var dataDict = item.dataDict;
							var options = parseDataDict(dataDict);
							var readonly= '';
							if(item.readonly == 'Y'){
								readonly='disabled:disabled';
							}
							
							inputBox = '<select displayName="'+item.displayName+'" id="'+item.name+'" name="paramsInfo" style="width:136px;margin-left:0px;'+readonly+'" title="'+item.tips+'" nullable="'+item.nullable+'" ispasswd="'+item.ispasswd+'" regex="'+item.regex+'">';
							
							inputBox+=options;
							inputBox+='</select>'+nullable;
						}else{
							var readonly= '';
							if(item.readonly == 'Y'){
								readonly='readonly="readonly"';
							}
							var maxlength = 38;
							if(item.maxlength != '' && item.maxlength != null){
								maxlength = item.maxlength;
							}
							inputBox = '<input displayName="'+item.displayName+'" type="text" id="'+item.name+'" name="paramsInfo" maxlength="'+maxlength+'" value="'+item.value+'" '+readonly+' class="text" style="width:300px;" title="'+item.tips+'" nullable="'+item.nullable+'" ispasswd="'+item.ispasswd+'" regex="'+item.regex+'"/>'+nullable;
						}
						$("#tab").append("<tr bgcolor='' align='center' height='27'>"+
					      "<td align='right' >"+
					      item.displayName+":"+
					      "</td>"+
					      "<td align='left'>"+
					      inputBox+
					      "</td>"+
					      "</tr>");
					});
					
					//循环赋值
					$.each(items, function(i, item) {
						$("#"+item.name).val(item.value);
					});
				}
			}
		});
		
		var model = $("#Model");
		if(model == 1){
			$("#StantartThreadNum").val(1);
			$("#StantartThreadNum").attr("disabled",true);
		}
		getStatus();
	}
	
	//解析字典数据
	function parseDataDict(dataDict){
		var dataDict = dataDict.substring(6,dataDict.indexOf("/>"));
		var item = dataDict.split(";");
		var ret = '<option value="">--请选择--</option>';
		for(var i = 0; i < item.length; i ++){
			var vals = item[i].split(":");
			if(vals.length == 1){
				ret += '<option value="'+vals[0]+'">'+vals[0]+'</option>';
			}else{
				ret += '<option value="'+vals[0]+'">'+vals[1]+'</option>';
			}
		}
		return ret;
	}
	//重置数据
	function resetMtd(){
		$('[name="paramsInfo"]').each(function(){
			$(this).val("");
		});
	}
	//提交
	function submitMtd(){
		if(confirm("保存成功之后分拣模块会自动重启，是否继续？")){
			var params = '';
			var errorCount = 0;
			$('[name="paramsInfo"]').each(function(){
				var nullable = $(this).attr("nullable");
				var val = $(this).val();
				if(val == ''){
					if(nullable == 'N'){
						alert($(this).attr("displayName")+"不可为空");
						errorCount++;
						return false;
					}
				}
				params+=$(this).attr("id");
				params+=":::";
				params+=$(this).val();
				params+=";;;";
			});
			
			if(errorCount > 0){
				return;
			}
			submitFinal(params);
		}
	}
	
	function submitFinal(param){
		var urlstr='';
		var dsstr = 'tsdBilling';
		var tsdcfstr = 'oracle';
		urlstr=tsd.buildParams({ 	  
			  packgname:'service',//java包
			  clsname:'OceParaService',//类名
			  method:'update',//方法名
			  ds:dsstr,//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
			  tsdcf:tsdcfstr,//指向配置文件名称
			  tsdoper:'query',//操作类型 
			  datatype:'xml',//返回数据格式 
			  tsdpk:'publicmode.sumKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		});	
		$.ajax({
			url:"mainServlet.html?"+urlstr+"&params="+param,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				if(xml == 'yes'){
					restart();
					alert("操作成功");
					//window.location.reload();
				}else{
					alert("操作失败");
				}
			}
		});
	}
	
	//启动
	function start(){
		var urlstr='';
		var dsstr = 'tsdBilling';
		var tsdcfstr = 'oracle';
		urlstr=tsd.buildParams({ 	  
			  packgname:'service',//java包
			  clsname:'OceParaService',//类名
			  method:'status',//方法名
			  ds:dsstr,//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
			  tsdcf:tsdcfstr,//指向配置文件名称
			  tsdoper:'query',//操作类型 
			  datatype:'xml',//返回数据格式 
			  tsdpk:'publicmode.sumKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		});	
		$.ajax({
			url:"mainServlet.html?"+urlstr+"&status=1",
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				getStatus();
			}
		});
	}
	
	//停止
	function stop(){
		var urlstr='';
		var dsstr = 'tsdBilling';
		var tsdcfstr = 'oracle';
		urlstr=tsd.buildParams({ 	  
			  packgname:'service',//java包
			  clsname:'OceParaService',//类名
			  method:'status',//方法名
			  ds:dsstr,//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
			  tsdcf:tsdcfstr,//指向配置文件名称
			  tsdoper:'query',//操作类型 
			  datatype:'xml',//返回数据格式 
			  tsdpk:'publicmode.sumKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		});	
		$.ajax({
			url:"mainServlet.html?"+urlstr+"&status=2",
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				getStatus();
			}
		});
	}
	
	//重启
	function restart(){
		var urlstr='';
		var dsstr = 'tsdBilling';
		var tsdcfstr = 'oracle';
		urlstr=tsd.buildParams({ 	  
			  packgname:'service',//java包
			  clsname:'OceParaService',//类名
			  method:'status',//方法名
			  ds:dsstr,//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
			  tsdcf:tsdcfstr,//指向配置文件名称
			  tsdoper:'query',//操作类型 
			  datatype:'xml',//返回数据格式 
			  tsdpk:'publicmode.sumKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		});	
		$.ajax({
			url:"mainServlet.html?"+urlstr+"&status=3",
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				getStatus();
			}
		});
	}
	
	//获取状态
	function getStatus(){
		var urlstr='';
		var dsstr = 'tsdBilling';
		var tsdcfstr = 'oracle';
		urlstr=tsd.buildParams({ 	  
			  packgname:'service',//java包
			  clsname:'OceParaService',//类名
			  method:'status',//方法名
			  ds:dsstr,//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
			  tsdcf:tsdcfstr,//指向配置文件名称
			  tsdoper:'query',//操作类型 
			  datatype:'xml',//返回数据格式 
			  tsdpk:'publicmode.sumKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		});	
		$.ajax({
			url:"mainServlet.html?"+urlstr+"&status=4",
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				if(xml == 'yes'){
					$("#runstatus").attr("color","#00FF00");
					$("#runstatus").html("运行中");
				}else if(xml == 'no'){
					$("#runstatus").attr("color","red");
					$("#runstatus").html("停止运行");
				};
				
			}
		});
	}
	

//页面跳转
function jumpPage(pagename){
	if (!pagename || pagename == "#") {
		return;
	}
	$('#main-frame', parent.document).attr('src', 'mainServlet.html?pagename=' + pagename + '&tsdtemp=' + Math.random());
}
	</script>
</head>

<body style="background-color:#F4FCFE;">
	<div id="navBar">
		<img src="style/icon/dot11.gif" style="margin-left: 10px" />
		<fmt:message key="global.location" />
		: 套餐管理 >>> 分拣配置
		<div style="position:fixed; right:35px;line-height:20px;">
			<a onclick="parent.history.back(); return false;" href="javascript:void(0);">返 回</a>
		</div>
	</div>
  	<br />
  	<div id="hdParam" style="display:none;">
  		<input id="json1"/>
  	</div>
	<form id="addform" action="#"
		style="width: 98.5%;text-align:center;margin:0px auto;text-align:center;">
		<div id="rate_panel">
			<fieldset class="fieldset" style="width: 997px;">
				<legend style="margin-top:20px; font-size:13px;color:#000000;margin-left:15px;">
					<b>分拣配置</b>
				</legend>
				<table border="0"  style="width: 90%;" id="tab">
					
				</table>
				
				<input style="display: none;" type="text" id="json1"
					name="ratePagMain.json" value="" />
				<div id="buttons" style="background:url(); border-top:0px; border-bottom:0px;">
					<!-- 提交 -->
					<button type='button' class="module_btn" id="form_submit"  onclick="submitMtd();">
						保存
					</button>
				</div>
				
				<div id="buttons" style="width:800px; height:1px;  font-size:0; background:#000000;margin-top:20px;">
				</div>
				
				<div style="height:30px; margin-top:10px;">
					状态:&nbsp;&nbsp;<font id="runstatus" style="font-weight:900;"></font>
				</div>
				<div id="buttons" style="background:url(); border-top:0px; border-bottom:0px;">
					<!-- 启动 -->
					<button type='button' class="module_btn" id="form_submit"  onclick="start();">
						启动
					</button>
					<!-- 停止 -->
					<button  type='button' onclick="stop();">
						停止
					</button>
					<button  type='button' onclick="restart();">
						重启
					</button>
				</div>
			</fieldset>
		</div>
	</form>
</body>
</html>
