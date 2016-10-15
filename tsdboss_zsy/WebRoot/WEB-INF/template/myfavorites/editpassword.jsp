<%----------------------------------------
	name: editpassword.jsp
	author: chenliang
	version: 1.0, 2009-11-26
	description: 当前登陆用户可对自己的登陆密码进行修改
	modify: 
		2009-11-26 chenliang  添加功能注释.
      	2009-12-01 chenliang  添加国际化信息
      	2010-12-13 youhongyu  页面按钮样式修改
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userid = (String) session.getAttribute("userid");
	String iconpath = basePath + "style/icon/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>修改密码</title>
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
		<style>
<!--
body {
	background-color: #FFFFFF;
}

-->
#thea {
	width: 600px;
	height: 200px;
	border:#99ccff 1px solid;
	background-color: #F5FCFE;
}

.theb {
	height: 1px;
	overflow: hidden;
}
</style>
		<script type="text/javascript">
/**
 * 加载当前页时，让密码框成为焦点
 * @param event
 * @return 无返回值
 */
document.onkeydown = function (event)
{
    e = event ? event : (window.event ? window.event : null);
    if (e.keyCode == 13) {
        $("#thisclick").click();
        $("#oldpassword").focus();
        return false;
    }
}
/**
 * 取导航菜单
 * @param 无参数
 * @return 无返回值
 */
jQuery(document).ready(function () 
{
    $("#navBar1").append(genNavv());
});
/**
 * 修改密码的函数
 * @param 无参数
 * @return 无返回值(操作成功)/false(验证不通过)
 */
function editpassword()
{
    var params = '';
    var oldpassword = $("#oldpassword").val();
    var password = $("#newpassword").val();
    var confirmpassword = $("#confirmpassword").val();
    //判断当前密码是否与原始密码一致
    if (isPassword(oldpassword) == true)
    {
        if (password == null || password == "")
        {
            // 密码是否符合要求
            alert("密码不能为空，请重新输入");
            $("#newpassword").focus();
            return false;
           
        }
        if(confirmpassword != password){
        	alert("确证密码与密码输入不一致请重新输入");
        	$("#confirmpassword").focus();
        	return false;
        	
        }
        else {
            params += "&password=" + tsd.encodeURIComponent(password);
        }
    }
    else
    {
        var operationtips = $("#operationtips").val();
        //var successful = $("#successful").val();
        alert("<fmt:message key='editpassword.theerror' />!", operationtips);
        $('#oldpassword').focus();
        return false;
    }
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : 'userManager.editpassword'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    urlstr += params;
    var thisuserid = $('#thisuserid').val();
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&userid=' + thisuserid, cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (msg)
        {
            if (msg == "true")
            {
                var operationtips = $("#operationtips").val();
                var successful = $("#successful").val();
                alert(successful, operationtips);
                clearText('thisform');
            }
        }
    });
}
/**
 * 判断当前输入密码是否与原始密码一致
 * @param password(密码)
 * @return boolean
 */
function isPassword(password)
{
    var flag = false;
    var thisuserid = $('#thisuserid').val();
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'userManager.querypassword'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&userid=' + thisuserid, datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var thispassword = $(this).attr("password");
                if (password == thispassword) {
                    flag = true;
                }
            });
        }
    });
    return flag;
}
/**
 * 加载页面时让密码输入框成为焦点
 * @param 无参数
 * @return 无返回值
 */
function thisOnfocus()
{
    $('#oldpassword').focus();
}			
</script>
	</head>

	<body onload="thisOnfocus()">
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
		<form id="thisform" onsubmit="return false;">
			<div style="margin-left: 100px; margin-top: 50px">
				<label style="margin-left: 10px;">
					<font color="red">(注意:修改密码时,新密码长度必须是8~16位,数字和字母的组合,禁止输入特殊字符,输入的特殊字符将被过滤.)</font>
				</label>
				<div id="thea">
					<table width="50%" border="0" align="center" cellpadding="0"
						cellspacing="0"
						style="line-height: 40px; text-align: left; font-size: 12px; color: #1A1A1A;">
						<tr>
							<td width="25%" align="right" >
								<span style="margin-right: 10px">
									<fmt:message key="editpassword.oldpassword" />:
								</span>
							</td>
							<td width="55%">
								<input type="password" id="oldpassword" name="textfield"
									style="width: 180px; height: 18px; color: #3D3D3D; text-align: left; border: 1px solid #E5E2E2; padding-top: 5px; padding-left: 2px;" />
							</td>
						</tr>
						<tr>
							<td align="right">
								<span style="margin-right: 10px">
									<fmt:message key="editpassword.newpassword" />:
								</span>
							</td>
							<td>
								<input type="password" id="newpassword" name="textfield"
									style="width: 180px; height: 18px; color: #3D3D3D; text-align: left; border: 1px solid #E5E2E2; padding-top: 5px; padding-left: 2px;"
									onkeyup="value=value.replace(/[\W]/g,'')"
									onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
							</td>
						</tr>
						<tr>
							<td align="right">
								<span style="margin-right: 10px">
									<fmt:message key="editpassword.confirmpassword" />:
								</span>
							</td>
							<td>
								<input type="password" id="confirmpassword" name="textfield"
									style="width: 180px; height: 18px; color: #3D3D3D; text-align: left; border: 1px solid #E5E2E2; padding-top: 5px; padding-left: 2px;"
									onkeyup="value=value.replace(/[\W]/g,'')"
									onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
							</td>
						</tr>

						<tr>
							<td height="55" colspan="2">
								<table width="100%" border="0" align="left" cellpadding="0"
									cellspacing="0">
									<tr align="center">
										<td>
											<div>
												<button type="button" style="line-height: 20px" id="thisclick" onclick="editpassword()" class="tsdbutton">
													<fmt:message key="editpassword.submit" />
												</button>
											</div>
										</td>
										<td>
											<div >
												<button type="button" style="line-height: 20px" id="thisclick" onclick="clearText('thisform');thisOnfocus()" class="tsdbutton">
													<fmt:message key="editpassword.reset" />
												</button>
											</div>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>

			</div>
		</form>
		<input type="hidden" id="thisuserid" value="<%=userid%>" />
		<input type="hidden" id="operationtips"
			value="<fmt:message key="global.operationtips"/>" />
		<input type="hidden" id="successful"
			value="<fmt:message key="global.successful"/>" />

	</body>
</html>
