<%----------------------------------------
	name: feedback.jsp
	author: chenliang
	version: 1.0, 2010-03-16
	description: 用户对系统进行问题反馈
	modify: 
		2010-12-13 fck图片上传不了问题更正
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/fck" prefix="FCK"%>
<%@ page language="java"
	import="java.util.*,com.tsd.javabean.NoticeBean" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";

	String userid = (String) session.getAttribute("userid");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>问题反馈</title>
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

		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
/**
 * 查看当前用户的扩展权限，对spower字段进行解析
 * @param 无参数
 * @return 无返回值
 */
function getUserPower()
{
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', clsname : 'Procedure', method : 'exequery', ds : 'tsdBilling', //数据源名称 对应的spring配置的数据源
        tsdpname : 'feedback.getPower', //存储过程的映射名称
        tsdExeType : 'query', datatype : 'xmlattr' 
    });
    //调用存储过程需要的参数
    var userid = '<%=userid%>';
    var groupid = '<%=zid%>';
    var imenuid = '<%=imenuid%>';
    var editfields = '';
    var flag = false;
    var spower = '';
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&userid=' + userid + '&groupid=' + groupid + '&menuid=' + imenuid, 
        datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                spower += $(this).attr("spower") + '@';
            });
        }
    });
    var str = 'true';
    if (spower != '' && spower != 'all@')
    {
        var spowerarr = spower.split('@');
        for (var i = 0; i < spowerarr.length - 1; i++) {
            editfields += getCaption(spower, 'editfields', '');
        }
        if (editfields.indexOf(',') !=- 1)
        {
            var fieldarr = editfields.split(",");
            for (var j = 0 ; j < fieldarr.length - 1; j++)
            {
                if (document.getElementById(fieldarr[j]) != '' && document.getElementById(fieldarr[j]) != undefined) {
                    document.getElementById(fieldarr[j]).disabled = false;
                }
            }
        }
        else
        {
            if (document.getElementById(editfields) != '' && document.getElementById(editfields) != undefined) {
                document.getElementById(editfields).disabled = false;
            }
        }
    }
    else if (spower == 'all@') {
        isReadonly(false);
    }
}
/**
 * 初始化
 * @param 无参数
 * @return 无返回值
 */
jQuery(document).ready(function () 
{
    $("#navBar1").append(genNavv());
    getTypeName();//获取类型名称
    getFeedBackDept();//问题反馈上级部门
    //$('#type option:last').attr('selected','selected');
    $('#title').focus();
});
/**
 * 获取编辑器中内容
 * @param 无参数
 * @return 无返回值
 */
function getFckValue()
{
    var editor = FCKeditorAPI.GetInstance("EditorAccessibility");
    //alert(editor.EditorDocument.body.innerHTML);
    //document.getElementById("news_content").value = editor.EditorDocument.body.innerHTML;
    $('#memo').val(editor.EditorDocument.body.innerHTML);
}
/**
 * 设置编辑器中内容
 * @param str
 * @return 无返回值
 */
function SetEditorContents(str) 
{
    var oEditor = FCKeditorAPI.GetInstance("EditorAccessibility") ;
  //  alert(str);
    oEditor.SetHTML() ;
}
/**
 * 先将所有通告类型类型取出
 * @param 无参数
 * @return 无返回值
 */
function getTypeName()
{
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'notices.querynoticetype'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            var thisarea = '';
            $(xml).find('row').each(function ()
            {
                thisarea += "<option value='" + $(this).attr('typename') + "'>" + $(this).attr('typename') + "</option>";
            });
            $("#type").html(thisarea);
        }
    });
}
/**
 * 问题反馈上级部门
 * @param 无参数
 * @return 无返回值
 */
function getFeedBackDept()
{
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'notices.feedbackdept'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            var thisarea = '';
            $(xml).find('row').each(function ()
            {
                thisarea += "<option value='" + $(this).attr('tvalues') + "'>" + $(this).attr('tvalues') + "</option>";
            });
            $("#isread").html(thisarea);
        }
    });
}
/**
 * 点击关闭
 * @param 无参数
 * @return 无返回值
 */
function willclose()
{
    var title = $('#title').val();
    getFckValue();
    //获取编辑器的输入值
    var memo = $('#memo').val();
    if ('' != title || '' != memo)
    {
        if (confirm('您要上报的数据尚未提交，确定要关闭吗?')) {
            window.location.href = "mainServlet.html?pagename=right-notices.jsp";
        }
        else {
            $('#title').focus();
        }
    }
    else {
        window.location.href = "mainServlet.html?pagename=right-notices.jsp";
    }
}
/**
 * 校验是否输入数据
 * @param 无参数
 * @return 无返回值
 */
function checkedInput()
{
    getFckValue();
    //获取编辑器的输入值
    var title = $('#title').val();
    var memo = $('#memo').val();
    if ('' == title || null == title) {
        alert('请输入标题!');
        $('#title').focus();
        return false;
    }
    if ('' == memo || null == memo) {
        alert('请输入内容!');
        return false;
    }
    if (title != '' && memo != '')
    {
        if (confirm('问题汇总上报提交之后将不可修改，是否提交?'))
        {
            var type = $('#type').val();
            var isread = $('#isread').val();
            $('#feedbacktype').val(type);
            $('#feedbackdept').val(isread);
            return true;
        }
        else {
            return false;
        }
    }
}					
</script>
<style type="text/css">
.tdstyle {
	border-bottom: 1px solid #A9C8D9;
}

.spanstyle {
	display: -moz-inline-box;
	display: inline-block;
	width: 110px
}

hr {
	margin: 2px 0 2px 0;
	border: 0;
	border-top: 1px dashed #CCCCCC;
	height: 0;
}
</style>
	</head>

	<body>
		<!-- 用户操作导航-->
		<div id="navBar">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar1" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
							<fmt:message key="global.location" />
							:
						</div>
					</td>
					<td width="20%" align="right" valign="top">
						<div id="d2back">
							<a href="javascript:void(0);"
								onclick="parent.history.back(); return false;"><fmt:message
									key="gjh.houtuei" /> </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
		&nbsp;
		<!-- 添加内容区域 -->
		<div class="neirong" id="add" style="width: 800px; margin-top: 30px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							问题汇总上报
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#close').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>


			<div class="midd">
				<form action="notices" name="operform" method="post" id="operform"
					onsubmit="return checkedInput();return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td class="labelclass">
								<label for="title">
									<span id="qtitle">标题</span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<input type="text" name="title" id="title" class="textclass"
									style="width: 88%; margin-bottom: 10px" />
								<font style="color: red; vertical-align: middle;">*</font>
							</td>

							<td class="labelclass">
								<label for="type">
									<span id="qtype">类型</span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<select id="type" style="width: 140px" 
									class="textclass">
									<option value="问题汇总上报" selected="selected">
										问题汇总上报
									</option>
								</select>
								<font style="color: red;">*</font>
							</td>

							<td class="labelclass">
								<label for="isread">
									<span id="qisread">上报部门</span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<select id="isread"  style="width: 140px"
									class="textclass">
									<option value="管理员组" selected="selected">
										管理员组
									</option>
								</select>
								<font style="color: red;">*</font>
							</td>
						</tr>
						<tr>
							<td class="dflabelclass">
								<label for="memo">
									<span id="qmemo">内容</span>
								</label>
							</td>
							<td colspan="5" width="80%" style="text-align: left;" >
								<FCK:editor id="EditorAccessibility" width="100%" height="230"
									fontNames="宋体;黑体;隶书;楷体_GB2312;Arial;Comic Sans MS;Courier New;Tahoma;Times New Roman;Verdana"
									imageBrowserURL="${pageContext.request.contextPath}/plug-in/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector"
									linkBrowserURL="${pageContext.request.contextPath}/plug-in/FCKeditor/editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector"
									flashBrowserURL="${pageContext.request.contextPath}/plug-in/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Flash&Connector=connectors/jsp/connector"
									imageUploadURL="${pageContext.request.contextPath}/plug-in/FCKeditor/editor/filemanager/upload/simpleuploader?Type=Image"
									linkUploadURL="${pageContext.request.contextPath}/plug-in/FCKeditor/editor/filemanager/upload/simpleuploader?Type=File"
									flashUploadURL="${pageContext.request.contextPath}/plug-in/FCKeditor/editor/filemanager/upload/simpleuploader?Type=Flash">
								</FCK:editor>
								<input type="hidden" name="memo" id="memo" />
								<input type="hidden" name="feedback" value="true" />
								<input type="hidden" id="feedbacktype" name="feedbacktype" />
								<input type="hidden" id="feedbackdept" name="feedbackdept" />
							</td>
						</tr>
					</table>

					<div class="midd_butt">
						<button type="submit" class="tsdbutton" id="feedback">
							提交
						</button>
						<button type="button" class="tsdbutton" id="close"
							style="margin-left: 10px" onclick="willclose()">
							<fmt:message key="global.close" />
						</button>
					</div>
					<%
						String theIE = request.getHeader("User-Agent");
						int theflag = 0;
						if (theIE.indexOf("MSIE 6.0") != -1) {
							theflag = 1;
						} else if (theIE.indexOf("MSIE 7.0") != -1
								|| theIE.indexOf("MSIE 8.0") != -1) {
							theflag = 2;
						}
					%>
					<%
						if (theflag == 1) {
					%>
					<br />
					<br />
					<br />
					<br />
					<%
						} else if (theflag == 2) {
					%>
					<br />
					<%
						}
					%>
				</form>
			</div>
		</div>
		<input type="hidden" id="isreadvalue" />
	</body>
</html>
