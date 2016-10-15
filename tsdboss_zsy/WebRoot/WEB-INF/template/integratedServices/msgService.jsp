<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userid = (String) session.getAttribute("userid");
	String imenuid = request.getParameter("imenuid");
	String zid = (String) session.getAttribute("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>综合业务-短信业务管理</title>

		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet"
			type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<!-- 分项卡 -->
		<link rel="stylesheet"
			href="plug-in/jquery/jquery.tabs/jquery.tabs.css" type="text/css"
			media="print, projection, screen" />
		<link rel="stylesheet"
			href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css" type="text/css"
			media="projection, screen" />
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jquery.tabs/jquery.tabs.js"
			type="text/javascript"></script>
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript"
			src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js"
			type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
			
		<script src="plug-in/ajaxfileupload.js" type="text/javascript"></script>

		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript"
			language="javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<!-- 验证框架需要导入的js文件 -->
		<script src="plug-in/jquery/validate/jquery.validate.js"
			type="text/javascript"></script>
		<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script type="text/javascript"
			src="script/telephone/sysdataset/infotest.js"></script>
		<!-- 时间选择器 -->
		<script src="plug-in/My97DatePicker/WdatePicker.js"
			type="text/javascript"></script>

		<!-- easyui -->
		<link rel="stylesheet" type="text/css"
			href="style/css/easyui/themes/default/easyui.css"></link>
		<link rel="stylesheet" type="text/css"
			href="style/css/easyui/themes/icon.css"></link>
		<link rel="stylesheet" type="text/css"
			href="style/css/easyui/demo.css"></link>
		<script type="text/javascript"
			src="plug-in/easyui/jquery.easyui.min.js"></script>
			
		<!-- 页面加载数据以及增删改查操作所需要js文件 -->
		<script language="javascript" src="script/integratedServices/sms/smsSend.js"></script>
		<script type="text/javascript">
				$(document).ready(function (){
					$('#tabs').tabs({
					  	  height:document.documentElement.clientHeight-5,
					  	  width:document.documentElement.clientWidth,
					      onSelect:function(title){   
					          if(title=="发送短信"){
					          	
					          }else if(title=="收件箱"){
					          	reloadData(3,'recvsmstable');
					          	$("#queryflag").val(3);
					          }else if(title=="发件箱"){
					          	reloadData(2,'SentSmsTable');
					          	$("#queryflag").val(2);
					          }else if(title=="待发送"){
					          	reloadData(1,'sendingsmstable');
					          	$("#queryflag").val(1);
					          }
					      }
					});
					$("#queryparam td:even").css({"background-color":"#c9d4ea","text-align":"right","padding-right":"1em"});
					loadsendinginfo(1,'sendingsmstable');
					loadsendinginfo(2,'SentSmsTable');
					loadsendinginfo(3,'recvsmstable');
					
				});
				
		</script>
		<style type="text/css">
			#queryparam{border:#7691c7 1px solid;width:560px;margin-left:auto;margin-right:auto;margin-top:60px;}
			#queryparam td{line-height:28px;border:#7691c7 1px solid;}
			
			* {
				margin: 0px;
				padding: 0px;
			}
			
			body {
				font-family: "宋体";
				font-size: 14px;
				color: #000000;
				background: #F4F9FD;
				text-align: center;
			}
			
			.main {
				padding-top: 20px;
				text-align: center;
				width: 1024px;
				height: 400px;
				margin: 5px auto 0px auto;
				border: 0px solid #9FBACD;
				background: #FFFFFF;
				font-size: 16px;
			}
			
			.txt {
				height: 22px;
				border: 1px solid #91c0e3;
				width: 180px;
			}
			
			.btn {
				background-color: #FFF;
				border: 1px solid #91c0e3;
				height: 24px;
				width: 70px;
			}
			
		</style>
	</head>

	<body>
		
		<div style="width: 100%;">
			<div id="tabs" class="easyui-tabs" style="width:100%;padding: 0 0 0 0;">
				<div title="发送短信">
					<table id="queryparam">
						<tr>
							<td width="25%">目标号码：</td>
							<td><textarea id="txtToNumberForSend" style="width: 350px;" rows="5" cols="10" ></textarea></td>
						</tr>
						<tr>
							<td>号码导入：</td>
							<td>
								<input type="file" class='txt' size="180" name="filePath" id="filePath" style="width: 180px;"/>
								<input class="btn" style="cursor: pointer;" type="button" id="filePathclick"
									name="filePathclick" onclick="upFile();" value='导入' />
							</td>
						</tr>
						<tr>
							<td>发送内容：</td>
							<td><textarea id="textContentForSend" style="width: 350px;" rows="5" cols="10"></textarea></td>
						</tr>
						<tr style="display: none;">
							<td>发送方式：</td>
							<td>
								<span><input type="radio" id="radSendTypeForSend"
											name="radSendTypeForSend" value="0" checked="checked" />即时发送</span>
									<span><input type="radio" id="radSendTypeForSend"
											name="radSendTypeForSend" value="1" />定时发送</span>
							</td>
						</tr>
						<tr style="display: none;">
							<td>发送日期：</td>
							<td>
								<input type="text" readonly="readonly" id="txtPlandateForSend"
										disabled="disabled"  class="txt"
										onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false,alwaysUseStartDate:true})" />
							</td>
						</tr>
						<tr>
							<td colspan="2" style="background-color: #fff;text-align: center;">
								<button onclick="sendSms();">  发送  </button>
								<button onclick="clearContent();">  清空  </button>
							</td>
						</tr>
					</table>
				</div>
				<div title="待发送">
					<!-- 用户操作标题以及放一些快捷按钮-->		
					<div id="buttons" style="width: 95%;">
					    <!--查询-->
					    <button type="button" onclick="queryinfo(1);">			
							<fmt:message key="global.query" />
						</button>
						
					</div>
					<table id="editgrid1" class="scroll" cellpadding="0" cellspacing="0"></table>
					<div id="pagered1" class="scroll" style="text-align: left;"></div>
				</div>
				<div title="发件箱">
					<!-- 用户操作标题以及放一些快捷按钮-->		
					<div id="buttons" style="width: 95%;">
					    <!--查询-->
					    <button type="button" onclick="queryinfo(2);">			
							<fmt:message key="global.query" />
						</button>
						
					</div>
					<table id="editgrid2" class="scroll" cellpadding="0" cellspacing="0"></table>
					<div id="pagered2" class="scroll" style="text-align: left;"></div>
				</div>
				<div title="收件箱">
					<!-- 用户操作标题以及放一些快捷按钮-->		
					<div id="buttons" style="width: 95%;">
					    <!--查询-->
					    <button type="button" onclick="queryinfo(3);">			
							<fmt:message key="global.query" />
						</button>
						
					</div>
					<table id="editgrid3" class="scroll" cellpadding="0" cellspacing="0"></table>
					<div id="pagered3" class="scroll" style="text-align: left;"></div>
				</div>
			</div>
		</div>
		<input type="hidden" name="skrid" id="skrid" value="<%=session.getAttribute("userid") %>"/>
		<input type="hidden" id="thecolumns1" />
		<input type="hidden" id="thecolumns2" />
		<input type="hidden" id="thecolumns3" />
		<input type="hidden" id="thecolumns4" />
		<input type="hidden" id="queryflag" />
		<input type="hidden" id="languageType" value="<%=languageType %>" />
		
		
		<div class="neirong" id="div_query_detail_ready_send"
			style="display: none; width: 600px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titledivs"></div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a
							href="#"
							onclick="javascript:$('#closethisinfo').click();"> <!-- 关闭 --> <fmt:message
								key="groupManager.close" /> </a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form action="#" name="operform" id="operform" onsubmit="return false;">
				<table width="100%" id="tdiv" border="0" cellspacing="0"
					cellpadding="0">
					<tr style="display: none;">
						<td width="12%" align="right" class="labelclass">
							<label for="memo" style="width: 90px">
								发件人
							</label>
						</td>
						
						<td class="dflabelclassOutBoxContent">
							<input type="text" class="textclass" style="width: 150px" disabled="disabled"
								id="txt_detail_ready_send_number" />
						</td>
					</tr>
					<tr style="display: none;">
						<td width="12%" align="right" class="labelclass">
							<label for="memo" style="width: 90px">
								收件人
							</label>
						</td>
						<td class="dflabelclassOutBoxContent">
							<input type="text" class="textclass" style="width: 150px" disabled="disabled"
								id="txt_detail_ready_receive_number" />
						</td>
					</tr>
					<tr style="display: none;">
						<td width="12%" align="right" class="labelclass">
							<label for="memo" style="width: 90px">
								计划发送时间
							</label>
						</td>
						<td class="dflabelclassOutBoxContent">
							<input id="txt_detail_ready_sent_time" class="textclass"
								disabled="disabled" style="width: 150px" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label style="width: 90px">
								内容
							</label>
						</td>
						<td class="dflabelclassOutBoxContent">
							<textarea id="txt_detail_ready_content" style="width: 500px;height: 100px;" disabled="disabled">
							</textarea>
						</td>
					</tr>
				</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="button" class="tsdbutton" id="closethisinfo" >
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>
		
		<div class="neirong" id="smsquery" style="display: none; width: 600px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titledivs"></div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a
							href="#"
							onclick="javascript:$('#closethisinfo1').click();"> <!-- 关闭 --> <fmt:message
								key="groupManager.close" /> </a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form action="#" name="queryform" id="queryform" onsubmit="return false;">
				<table width="100%" id="tdiv" border="0" cellspacing="0"
					cellpadding="0">
					<tr id="send">
						<td width="12%" align="right" class="labelclass">
								发送手机
						</td>
						
						<td class="tabinputclass" align="left">
							<input type="text"  class="textclass" style="width: 150px" 
								id="sendphone" />
						</td>
					</tr>
					<tr id="rec">
						<td width="12%" align="right" class="labelclass">
								接收手机
						</td>
						<td class="tabinputclass" align="left">
							<input type="text"  class="textclass" style="width: 150px"
								id="recphone" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
								时间
						</td>
						<td class="tabinputclass" align="left">
							<input id="starttime"  class="textclass"
								style="width: 150px"
								onfocus="WdatePicker({lang:'zh-cn',startDate:'%y-%M-01 ',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" />
							<label>
								至
							</label>
							<input id="stoptime"  class="textclass"
								style="width: 150px"
								onfocus="WdatePicker({lang:'zh-cn',startDate:'%y-%M-01 ',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
								内容
						</td>
						<td class="tabinputclass" align="left">
							<textarea id="smscontent" style="width: 400px;" rows="5" >
							</textarea>
						</td>
					</tr>
					<tr id="newflag" style="display: none;">
						<td width="12%" align="right" class="labelclass">
								结果
						</td>
						<td class="tabinputclass" align="left">
							<select id="sendres"  class="textclass"
								 style="width: 150px">
								<option value="" selected="selected">
									全部
								</option>
								<option value="1">
									成功
								</option>
								<option value="0">
									失败
								</option>
							</select>
						</td>
					</tr>
				</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="button" class="tsdbutton" id="queryinfo" onclick="queryGroup();" >
					查询
				</button>
				<button type="button" class="tsdbutton" id="closethisinfo1" >
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>
		
	</body>
</html>
