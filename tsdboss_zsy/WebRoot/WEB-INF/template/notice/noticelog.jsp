<%----------------------------------------
	name: noticelog.jsp
	author: chenliang
	version: 1.0, 2010-03-19
	description: 阅读日志的一个管理
	modify: 
		
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>NoticeType-Manager</title>
		
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
		<!-- 验证数据长度 -->
		<script src="script/public/datalength.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script  src="script/public/infotest.js" type="text/javascript"></script>
		<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>
				
		
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
        tsdpname : 'noticetype.getPower', //存储过程的映射名称
        tsdExeType : 'query', datatype : 'xmlattr' 
    });
    /************************
                *   调用存储过程需要的参数 *
                **********************/
    var userid = '<%=userid %>';
    var groupid = '<%=zid %>';
    var imenuid = '<%=imenuid %>';
    /****************
                *   拼接权限参数 *
                **************/
    var addright = '';
    var deleteright = '';
    var editright = '';
    var queryright = '';
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
        for (var i = 0; i < spowerarr.length - 1; i++)
        {
            addright += getCaption(spower, 'add', '') + '|';
            deleteright += getCaption(spower, 'delete', '') + '|';
            editright += getCaption(spower, 'edit', '') + '|';
            queryright += getCaption(spower, 'query', '') + '|';
            editfields += getCaption(spower, 'editfields', '');
        }
    }
    else if (spower == 'all@')
    {
        $("#addright").val(str);
        $("#deleteright").val(str);
        $("#editright").val(str);
        $("#queryright").val(str);
        flag = true;
    }
    var hasadd = addright.split('|');
    var hasdelete = deleteright.split('|');
    var hasedit = editright.split('|');
    var hasquery = queryright.split('|');
    if (flag == false)
    {
        for (var i = 0; i < hasadd.length; i++) {
            if (hasadd[i] == 'true') {
                $("#addright").val(str);
                break;
            }
        }
        for (var i = 0; i < hasdelete.length; i++) {
            if (hasdelete[i] == 'true') {
                $("#deleteright").val(str);
                break;
            }
        }
        for (var i = 0; i < hasedit.length; i++) {
            if (hasedit[i] == 'true') {
                $("#editright").val(str);
                break;
            }
        }
        for (var i = 0; i < hasquery.length; i++) {
            if (hasquery[i] == 'true') {
                $("#queryright").val(str);
                break;
            }
        }
    }
    $("#editfields").val(editfields);
}
/**************************************
                存储过程操作示例
                -------------------------------
                具体参数请参照《泰思达WEB平台开发手册》
                -------------------------------
            **************************************/
/**
 * 初始化
 * @param 无参数
 * @return 无返回值
 */
jQuery(document).ready(function () 
{
    /**********************
            **   获取当前导航菜单  *
            **********************/
    $("#navBar1").append(genNavv());
    /**********************
            **   取得当前用户的权限  *
            **********************/
    getUserPower();
    var delright = $("#deleteright").val();
    if (delright == "true")
    {
        document.getElementById("opendel1").disabled = false;
        document.getElementById("opendel2").disabled = false;
    }
    var queryright = $("#queryright").val();
    if (queryright == "true")
    {
        document.getElementById("query1").disabled = false;
        document.getElementById("query2").disabled = false;
    }
    ///设置命令参数
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xml', //返回数据格式 
        tsdpk : 'noticelog.query', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'noticelog.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    //jqgrid隐藏某一列的值
    jQuery("#editgrid").jqGrid(
    {
        url : 'mainServlet.html?' + urlstr, datatype : 'xml', colNames : ['ID', '通告标题', '阅读人', '阅读时间', 
        '登陆IP'], colModel : [ {
            name : 'id', index : 'id', hidden : true
        },
        {
            name : 'title', index : 'title'
        },
        {
            name : 'username', index : 'username', width : 50
        },
        {
            name : 'readtime', index : 'readtime', width : 150
        },
        {
            name : 'loginip', index : 'loginip', width : 150
        } ], rowNum : 10, //默认分页行数
        rowList : [10, 15, 20], //可选分页行数
        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images/', pager : jQuery('#pagered'), sortname : 'id', //默认排序字段
        viewrecords : true, multiselect : true, multiselectWidth : 20, sortorder : 'desc', //默认排序方式 
        caption : '通知通告阅读日志管理', height : 300, //高
        width : document.documentElement.clientWidth - 62,
        loadComplete : function ()
        {
            if ($("#editgrid tr.jqgrow[id='1']").text() == "") {
                $("#editgrid tr.jqgrow[id='1']").remove();
                return false;
            }
            //addRowOperBtn('editgrid','<img src="images/ltubiao_01.gif" alt="修改"/>','openRowModify','id','click',1);
            //addRowOperBtn('editgrid','<img src="images/ltubiao_02.gif" alt="删除"/>','deleteRow','groupid','click',2);
            //executeAddBtn('editgrid',1);
        }
    }).navGrid('#pagered', {
        edit : false, add : false, add : false, del : false, search : false
    },
    //options 
    {
        height : 280, reloadAfterSubmit : true, closeAfterEdit : true
    },
    // edit options 
    {
        height : 280, reloadAfterSubmit : true, closeAfterAdd : true
    },
    // add options 
    {
        reloadAfterSubmit : false
    },
    // del options 
    {} // search options 
    );
});
/**
 * 删除信息
 * @param 无参数
 * @return 无返回值
 */
function deleteRows()
{
    var arr = $('#editgrid').getGridParam('selarrrow');
    if (arr.length == 0) {
        alert('请勾选您要删除的类型!');
        return false;
    }
    var str = '';
    if (arr.length > 1) {
        str = '这些';
    }
    else {
        str = '这条';
    }
    if (confirm('您确定要删除' + str + '信息吗?'))
    {
        var idarr = new Array();
        for (var i = 0 ; i < arr.length ; i++) {
            idarr.push($('#editgrid').getCell(arr[i], 'id'));
        }
        deleteRow(idarr);
    }
}
/**
 * 删除信息具体操作
 * @param key(唯一标识)
 * @return 无返回值
 */
function deleteRow(key)
{
    var deleteright = $("#deleteright").val();
    if (deleteright == "true")
    {
        //jConfirm('您确定要删除', operationtips, function(x) { if(x==true){ 
        var urlstr = tsd.buildParams(
        {
            packgname : 'service', //java包
            clsname : 'ExecuteSql', //类名
            method : 'exeSqlData', //方法名
            ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf : 'mssql', //指向配置文件名称
            tsdoper : 'exe', //操作类型 
            tsdpk : 'noticelog.delete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax(
        {
            url : 'mainServlet.html?' + urlstr + '&id=' + key, cache : false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout : 1000, async : false , //同步方式
            success : function (msg)
            {
                if (msg == "true") {
                    alert('删除成功!');
                    reloadData();
                }
            }
        });
        //}});
    }
    else {
        alert('对不起,您无删除权限!');
    }
}
/**
 * 重载信息
 * @param 无参数
 * @return 无返回值
 */
function reloadData()
{
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        datatype : 'xml', //返回数据格式 
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        tsdpk : 'noticelog.query', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'noticelog.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    $("#editgrid").setGridParam({
        url : 'mainServlet.html?' + urlstr
    }).trigger("reloadGrid");
    setTimeout($.unblockUI, 15);
    //关闭面板
}
/**
 * 执行复合查询出提交过来的相应操作
 * @param 无参数
 * @return 无返回值
 */
function fuheExe()
{
    var queryName = $('#queryName').val();
    if (queryName == "query") {
        fuheQuery('noticelog.queryByWhere', 'noticelog.queryByWherepage');
    }
}			
</script>
		<style type="text/css">
			.tdstyle{border-bottom:1px solid #A9C8D9;}
		</style>
	</head>

	<body>
		<!-- 查询隐藏域 -->
		<form name="childform" id="childform">
			<input type="text" id="queryName" name="queryName" value=""
				style="display: none" />
			<input type="text" id="fusearchsql" name="fusearchsql"
				style="display: none" />
		</form>
		
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
									key="gjh.houtuei" />
							</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
		<!-- 用户操作按钮 -->
		<div id="buttons" style="text-align: left">
			<!-- 这里的按钮可以自由更换 但格式要对 -->
			<button type="button" id="query1" disabled="disabled" onclick="openDiaQueryG('query','notice_log')">
				<fmt:message key="global.query" />
			</button>
			<button type="button" id="opendel1" onclick="deleteRows()" 
				disabled="disabled">
				<fmt:message key="global.delete" />
			</button>
			
		</div>
		<!-- jqgrid显示区域 -->
		<div style="text-align: left">
			<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
		</div>
		<!-- 下方显示操作按钮 -->
		<div id="buttons" style="text-align: left">
			<!-- 这里的按钮可以自由更换 但格式要对 -->
			<button type="button" id="query2" disabled="disabled" onclick="openDiaQueryG('query','notice_log')">
				<fmt:message key="global.query" />
			</button>
			<button type="button" id="opendel2" onclick="deleteRows()"
				disabled="disabled">
				<fmt:message key="global.delete" />
			</button>
		</div>
	
		<input type='hidden' id="deleteright"/>
		<input type='hidden' id="queryright"/>
		<input type='hidden' id="thecolumn"/>
	</body>
</html>
