<%----------------------------------------
	name: editpromain.jsp
	author: chenliang
	version: 1.0, 2010-06-02
	description: 编辑存储过程信息
	modify: 
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/fck" prefix="FCK"%>
<%@ page language="java"
	import="java.util.*,com.tsd.javabean.PromainBean" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";

	String userid = (String) session.getAttribute("userid");

	PromainBean nb = (PromainBean) request.getAttribute("promaininfo");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
	String id = request.getParameter("id");

	String diskeys = request.getParameter("diskeys");
	boolean disflag = false;
	if ("readinfos".equals(diskeys)) {
		disflag = true;
	}
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>存储过程维护_修改</title>
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
		<!-- 该页面js脚本 -->
		<script src="script/system/fieldAliasManager.js" type="text/javascript" language="javascript"></script>
<script type="text/javascript">
/**
 * 初始化
 * @param 无参数
 * @return 无返回值
 */
jQuery(document).ready(function () 
{
    var thisdata = loadData('pro_main', '<%=languageType%>', 1, '修改');
    $("#pid").html(thisdata.getFieldAliasByFieldName('pname'));//存储过程名称
    $('#sshownames').html(thisdata.getFieldAliasByFieldName('pdatabase'));//所在数据源
    $('#snames').html(thisdata.getFieldAliasByFieldName('pmemo'));//内容
    $('#spronames').html(thisdata.getFieldAliasByFieldName('pcmemo'));//备注
    $('#spagenames').html(thisdata.getFieldAliasByFieldName('pdatabaseip'));//数据源IP
    $("#wpid").html(thisdata.getFieldAliasByFieldName('pname'));
    $('#wsshownames').html(thisdata.getFieldAliasByFieldName('pdatabase'));
    $('#wsnames').html(thisdata.getFieldAliasByFieldName('pmemo'));
    $('#wspronames').html(thisdata.getFieldAliasByFieldName('pcmemo'));
    $('#wspagenames').html(thisdata.getFieldAliasByFieldName('pdatabaseip'));
    $("#bjtime").html(thisdata.getFieldAliasByFieldName('uptime'));//上传时间
    $("#bjman").html(thisdata.getFieldAliasByFieldName('upman'));//上传人
    $("#bjip").html(thisdata.getFieldAliasByFieldName('upip'));//上传IP
    var disflag = '<%=disflag%>';
    if (disflag == 'true')
    {
        var disupman = '<%=nb.getUpman()%>';
        disupman = getTrueValue('tsdBilling', 'sys_user', 'username', 'userid', disupman, '1', '1');
        $('#disupman').html(disupman);
        $('#queryinfos').show();
        $('#add').hide();
    }
    else {
        $('#queryinfos').hide();
        $('#add').show();
    }
    $('#disid').focus();
});
/**
 * 校验是否输入数据
 * @param 无参数
 * @return 无返回值(数据验证成功)/false(数据验证不成功)
 */
function checkedInput()
{
    var id = $('#disid').val();
    var sshowname = $('#sshowname').val();
    var spagename = $('#spagename').val();
    var pmemo = $('#pmemo').val();
    var pcmemo = $('#pcmemo').val();
    if ('' == id) {
        alert('请输入存储过程名称!');
        $('#disid').focus();
        return false;
    }
    if ('' == sshowname) {
        alert('请输入数据源!');
        $('#sshowname').focus();
        return false;
    }
    if ('' == spagename) {
        alert('请输入数据源IP!');
        $('#spagename').focus();
        return false;
    }
    if ('' == pmemo) {
        alert('请输入存储过程内容!');
        $('#pmemo').focus();
        return false;
    }
    if ('' == pcmemo) {
        alert('请输入变更原因!');
        $('#pcmemo').focus();
        return false;
    }
    if (confirm('您确定要修改这条记录吗?'))
    {
        if (id != '' && sshowname != '' && spagename != '' && pmemo != '' && pcmemo != '') {
            return true;
        }
        else {
            alert('提交数据非法,终止操作!');
        }
    }
    else {
        $('#close').click();
        return false;
    }
}

/**
 * 点击关闭
 * @param ids
 * @return 无返回值
 */
function willclose(ids)
{
    if (ids == 1)
    {
        window.location.href = "mainServlet.html?pagename=system/promain.jsp?imenuid=<%=imenuid%>&pmenuname=<%=pmenuname%>&imenuname=<%=imenuname%>&groupid=<%=zid%>";
    }
    else
    {
        if (confirm('您要修改的数据尚未保存，确定要退出吗?'))
        {
            window.location.href = "mainServlet.html?pagename=system/promain.jsp?imenuid=<%=imenuid%>&pmenuname=<%=pmenuname%>&imenuname=<%=imenuname%>&groupid=<%=zid%>";
        }
        else {
            $('#disid').focus();
        }
    }
}
/**
 * 获取选择值的真实值
 * @param ds(数据源)
 * @param tablename(表名)
 * @param code
 * @param thelimit
 * @param limitvalue
 * @param theif
 * @param theend
 * @return String
 */
function getTrueValue(ds, tablename, code, thelimit, limitvalue, theif, theend)
{
    var realvalue = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : ds, //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mysql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'broadbandjob.querytruevalue' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    if (limitvalue == '' || null == limitvalue) {
        limitvalue = 1;
        thelimit = 1;
    }
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&tablename=' + tablename + '&code=' + code + '&thelimit=' + thelimit + '&theif=' + theif + '&theend=' + theend + '&limitvalue=' + limitvalue + '&tsdtemp=' + Math.random(), 
        datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                realvalue += $(this).attr(code);
            });
        }
    });
    return realvalue;
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
							<%=pmenuname%>
							>>> 修改存储过程信息
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

		<!-- 显示修改信息 -->
		<div class="neirong" id="add"
			style="display: none; margin-top: 20px; width: 800px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							修改
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="willclose('');">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form
					action="promain?opertype=modify&userid=<%=session.getAttribute("userid")%>"
					name="operform" method="post" id="operform"
					onsubmit="return checkedInput();return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td class="labelclass">
								<input type='hidden' name="imenuid" value="<%=imenuid%>" />
								<input type='hidden' name="pmenuname" value="<%=pmenuname%>" />
								<input type='hidden' name="groupid" value="<%=zid%>" />
								<input type='hidden' name="imenuname" value="<%=imenuname%>" />
								<input type='hidden' name="id" value="<%=id%>" />

								<label for="pid" id="pid"></label>
							</td>
							<td class="tdstyle">
								<input type="text" name="pname" id="disid"
									value="<%=nb.getPname()%>" class="textclass"
									style="width: 150px" />
								<font style="color: red;">*</font>
							</td>
							<td class="labelclass">
								<label for="sshownames" id="sshownames"></label>
							</td>
							<td class="tdstyle">
								<input type="text" name="pdatabase" id="sshowname"
									value="<%=nb.getPdatabase()%>" class="textclass"
									style="width: 150px" />
								<font style="color: red;">*</font>
							</td>

							<td class="labelclass">
								<label for="spagenames" id="spagenames"></label>
							</td>
							<td class="tdstyle">
								<input type="text" name="pdatabaseip" id="spagename"
									value="<%=nb.getPdatabaseip()%>" style="width: 150px"
									class="textclass" />
								<font style="color: red;">*</font>
							</td>
						</tr>

						<tr>
							<td class="labelclass">
								<label for="snames" style="width: 90px">
									<span id="snames"></span>
								</label>
							</td>
							<td class="tdstyle" colspan="5">
								<textarea rows="10" name='pmemo' id='pmemo' cols="112"><%=nb.getPmemo()%></textarea>
								<font style="color: red;">*</font>
							</td>
						</tr>
						<tr>
							<td class="dflabelclass">
								<label for="spronames" style="width: 90px">
									<span id="spronames"></span>
								</label>
							</td>
							<td colspan="5">
								<textarea rows="10" name='pcmemo' id='pcmemo' cols="112"><%=nb.getPcmemo()%></textarea>
								<font style="color: red;">*</font>
							</td>
						</tr>
					</table>
					<div class="midd_butt">
						<button type="submit" class="tsdbutton" id="saveinfo"
							style="margin-left: 10px">
							保存
						</button>

						<button type="button" class="tsdbutton" id="close"
							style="margin-left: 10px" onclick="willclose('');">
							<fmt:message key="global.close" />
						</button>
					</div>
				</form>
			</div>
		</div>

		<!-- 查看存储过程详细信息 -->
		<div class="neirong" id="queryinfos"
			style="display: none; margin-top: 20px; width: 800px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							查看存储过程详细信息
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#infosclose').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form action="#" onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td class="labelclass">
								<label for="pid" id="wpid"></label>
							</td>
							<td class="tdstyle">
								<%=nb.getPname()%>
							</td>
							<td class="labelclass">
								<label for="sshownames" id="wsshownames"></label>
							</td>
							<td class="tdstyle">
								<%=nb.getPdatabase()%>
							</td>

							<td class="labelclass">
								<label for="spagenames" id="wspagenames"></label>
							</td>
							<td class="tdstyle">
								<%=nb.getPdatabaseip()%>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="pid" id="bjtime"></label>
							</td>
							<td class="tdstyle">
								<%=nb.getUptime()%>
							</td>
							<td class="labelclass">
								<label for="sshownames" id="bjman"></label>
							</td>
							<td class="tdstyle" id="disupman">

							</td>

							<td class="labelclass">
								<label for="spagenames" id="bjip"></label>
							</td>
							<td class="tdstyle">
								<%=nb.getUpip()%>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="snames" style="width: 90px">
									<span id="wsnames"></span>
								</label>
							</td>
							<td class="tdstyle" colspan="5">
								<textarea rows="30" cols="112" readonly="readonly"><%=nb.getPmemo()%></textarea>
							</td>
						</tr>
						<tr>
							<td class="dflabelclass">
								<label for="spronames" style="width: 90px">
									<span id="wspronames"></span>
								</label>
							</td>
							<td colspan="5">
								<%=nb.getPcmemo()%>
							</td>
						</tr>
					</table>
					<div class="midd_butt">
						<button type="button" class="tsdbutton" id="infosclose"
							style="margin-left: 10px" onclick="willclose(1);">
							<fmt:message key="global.close" />
						</button>
					</div>
				</form>
			</div>
		</div>
		<input type="hidden" id="isreadvalue" />
	</body>
</html>
