<%----------------------------------------
	name: noticetype.jsp
	author: chenliang
	version: 1.0, 2010-10-19
	description: 对通知类型的一个管理
	modify: 
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/fck" prefix="FCK"%>
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
        //isReadonly(false);
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
/**
 * 将受限字段复原
 * @param status(状态)
 * @return 无返回值
 */
function isReadonly(status)
{
    var fields = getFields('sys_powergroup');
    var fieldarr = fields.split(",");
    for (var j = 0 ; j < fieldarr.length - 1; j++)
    {
        if (document.getElementById(fieldarr[j]) != '' && document.getElementById(fieldarr[j]) != undefined) {
            document.getElementById(fieldarr[j]).disabled = status;
        }
    }
}
///////////////////进行字段判断
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
    var addright = $("#addright").val();
    if (addright == "true")
    {
        document.getElementById("openadd1").disabled = false;
        document.getElementById("openadd2").disabled = false;
    }
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
        tsdpk : 'noticetype.query', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'noticetype.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    var column = '';
    var thisdata = loadData('noticetype', '<%=languageType %>', 1, '修改');
    column = thisdata.FieldName.join(',');
    $('#thecolumn').val(column);
    $("#qid").html(thisdata.getFieldAliasByFieldName('id'));
    $("#qtypename").html(thisdata.getFieldAliasByFieldName('typename'));
    $("#qmemo").html(thisdata.getFieldAliasByFieldName('memo'));
    //jqgrid隐藏某一列的值
    thisdata.colModels[1].hidden = true;
    thisdata.setWidth({
        Operation : 40, typename : 200, memo : 200
    });
    jQuery("#editgrid").jqGrid(
    {
        url : 'mainServlet.html?' + urlstr + '&cloumn=' + column, datatype : 'xml', colNames : thisdata.colNames, 
        colModel : thisdata.colModels, rowNum : 15, //默认分页行数
        rowList : [10, 15, 20], //可选分页行数
        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images/', pager : jQuery('#pagered'), sortname : 'id', //默认排序字段
        viewrecords : true, multiselect : true, multiselectWidth : 20, sortorder : 'asc', //默认排序方式 
        caption : '公告类型配置管理', height : 300, //高
        //width:document.documentElement.clientWidth-32,
        loadComplete : function ()
        {
            if ($("#editgrid tr.jqgrow[id='1']").text() == "") {
                $("#editgrid tr.jqgrow[id='1']").remove();
                return false;
            }
            addRowOperBtn('editgrid', '<img src="style/images/public//ltubiao_01.gif" alt="修改"/>', 'openRowModify', 
            'id', 'click', 1);
            //addRowOperBtn('editgrid','<img src="images/ltubiao_02.gif" alt="删除"/>','deleteRow','groupid','click',2);
            executeAddBtn('editgrid', 1);
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
/*********************************
                **             添加信息            **
                ***********************************/
/**
 * 更新状态
 * @param 无参数
 * @return 无返回值
 */
function openText()
{
    clearText('operform');
    $('#saveadd').show();
    $('#saveexit').show();
    $('#modify').hide();
    autoBlockForm('add', 60, 'close', "#ffffff", false);
    //弹出查询面板
    $('#titlediv').html('<fmt:message key="global.add" />');
    //hideError();//隐藏错误信息 
}
/**
 * 拼参数
 * @param 无参数
 * @return String
 */
function buildParams()
{
    //每次拼接参数必须初始化此参数
    tsd.QualifiedVal = true;
    var params = '';
    var typename = $("#typename").val();
    var memo = $("#memo").val();
    if (typename == '' || null == typename) {
        alert('请输入公告类型名称!');
        $('#typename').focus();
        return false;
    }
    params += '&typename=' + tsd.encodeURIComponent(typename);
    params += '&memo=' + tsd.encodeURIComponent(memo);
    //每次拼接参数必须添加此判断
    if (tsd.Qualified() == false) {
        return false;
    }
    return params;
}
/**
 * 添加完成，进行数据交互即保存
 * @param thesave(添加状态：1.保存添加；2.保存退出)
 * @return 无返回值
 */
function saveInfo(thesave)
{
    var params = buildParams();
    if (params == false) {
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
        tsdpk : 'noticetype.save'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    urlstr += params;
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr, cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (msg)
        {
            if (msg == "true")
            {
                alert('操作成功!');
                if (thesave == 1) {
                    clearText('operform');
                    $('#typename').focus();
                }
                else if (thesave == 2) {
                    reloadData();
                }
            }
        }
    });
}
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
            tsdpk : 'noticetype.delete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
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
 * 修改信息
 * @param key(唯一标识)
 * @return 无返回值
 */
function openRowModify(key)
{
    var editright = $("#editright").val();
    if (editright == "true")
    {
        $('#thekey').val(key);
        $('#titlediv').html('<fmt:message key="global.edit" />');
        $("#modify").show();
        $("#saveadd").hide();
        $("#saveexit").hide();
        //hideError();
        //隐藏错误信息 
        clearText('operform');
        ///设置命令参数
        var urlstr = tsd.buildParams(
        {
            packgname : 'service', //java包
            clsname : 'ExecuteSql', //类名
            method : 'exeSqlData', //方法名
            ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf : 'mssql', //指向配置文件名称
            tsdoper : 'query', //操作类型 
            datatype : 'xmlattr', //返回数据格式 
            tsdpk : 'noticetype.queryByKey' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax(
        {
            url : 'mainServlet.html?' + urlstr + '&id=' + key, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout : 1000, async : false , //同步方式
            success : function (xml)
            {
                $(xml).find('row').each(function ()
                {
                    var typename = $(this).attr("typename");
                    var memo = $(this).attr("memo");
                    $("#typename").val(typename);
                    $("#memo").val(memo);
                    //var editfields = $("#editfields").val();
                    /*************************************
                                    **   将当前表的所有字段取出来，分割字符串 ***
                                    *************************************/
                    //var fields = getFields('noticetype');
                    //var fieldarr = fields.split(",");
                    /**********************************
                                    **   将当前表中的spower字段取出来 *****
                                    **********************************/
                    //var spower = editfields.split(",");
                    //if(spower.length>0){
                    // for(var i=0;i<spower.length;i++){
                    //  for(var j = 0 ; j <fieldarr.length-1;j++){
                    //   if(fieldarr[j]==spower[i]){
                    //    document.getElementById(fieldarr[j]).disabled = false;
                    //    break;
                    //   }
                    //  }
                    // }
                    //}
                });
                autoBlockForm('add', 60, 'close', "#ffffff", true);
                //弹出修改面板
            }
        });
    }
    else {
        alert('对不起，您没有修改权限!');
    }
}
/**
 * 将修改后的信息保存起来
 * @param 无参数
 * @return 无返回值(修改成功)/false(验证不通过)
 */
function modifyInfo()
{
    var params = buildParams();
    if (params == false) {
        return false;
    }
    var key = $("#thekey").val();
    ///设置命令参数
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : 'noticetype.modify'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    urlstr += params;
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&id=' + key, cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (msg)
        {
            if (msg == "true")
            {
                alert('<fmt:message key="global.successful"/>', '<fmt:message key="global.operationtips"/>');
                /*************
                                    ** 释放资源 **
                                    ************/
                reloadData();
            }
        }
    });
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
        tsdpk : 'noticetype.query', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'noticetype.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    var thecolumn = $('#thecolumn').val();
    $("#editgrid").setGridParam({
        url : 'mainServlet.html?' + urlstr + '&cloumn=' + thecolumn
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
        fuheQuery('noticetype.queryByWhere', 'noticetype.queryByWherepage');
    }
}


/**
 * 复合查询参数获取，@oper 操作类型 fuhe
 * @param 无参数
 * @return String(构造参数成功)/false(验证不通过)
 */
function fuheQbuildParams()
{
    //每次拼接参数必须初始化此参数
    tsd.QualifiedVal = true;
    var params = '';
    //如果有可能值是汉字 请使用encodeURI()函数转码
    var fusearchsql = encodeURIComponent($("#fusearchsql").val());
    params += '&fusearchsql=' + fusearchsql;
    //注意：不要在此做空的判断 即使为空 也必须放入请求中     
    //每次拼接参数必须添加此判断
    if (tsd.Qualified() == false) {
        return false;
    }
    return params;
}
/**
 * 组合排序
 * @param sqlstr(组合排序条件)
 * @return 无返回值
 */
function zhOrderExe(sqlstr)
{
    var params = '';
    params = fuheQbuildParams();
    if (params == '&fusearchsql=') {
        params += '1=1';
    }
    var column = $("#thecolumn").val();
    params = params + '&orderby=' + sqlstr + '&column=' + column;
    params += '&orderkey=id';
    params += '&ordertablename=noticetype';
    sql = 'main.queryByOrder';
    pagesql = 'main.queryByOrderpage';
    
    //此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)     
    var urlstr1 = tsd.buildParams(
    {
	        packgname : 'service', //java包
	        clsname : 'ExecuteSql', //类名
	        method : 'exeSqlData', //方法名
	        ds : 'tsdBilling', //数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
	        tsdcf : 'mssql', //指向配置文件名称
	        tsdoper : 'query', //操作类型 
	        datatype : 'xml', //返回数据格式 
	        tsdpk : sql, //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
	        tsdpkpagesql : pagesql 
    });
    
    var link = urlstr1 + params;
    
    $("#editgrid").setGridParam({
        url : 'mainServlet.html?' + link
    }).trigger("reloadGrid");
    //jAlert("操作成功","操作提示");
    setTimeout($.unblockUI, 15);
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
			<button type="button" id="order1" onclick="openDiaO('noticetype');" >
				<!-- 组合排序 -->	<fmt:message key="tariff.order" />
			</button>
			<button type="button" id="openadd1" onclick="openText()"
				disabled="disabled">
				<fmt:message key="global.add" />
			</button>
			<button type="button" id="query1" disabled="disabled" onclick="openDiaQueryG('query','noticetype')">
				高级查询
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
			<button type="button" id="order2" onclick="openDiaO('noticetype');" >
				<!-- 组合排序 --><fmt:message key="tariff.order" />
			</button>
			<button type="button" id="openadd2" onclick="openText()"
				disabled="disabled">
				<fmt:message key="global.add" />
			</button>
			<button type="button" id="query2" disabled="disabled" onclick="openDiaQueryG('query','noticetype')">
				高级查询
			</button>
			<button type="button" id="opendel2" onclick="deleteRows()"
				disabled="disabled">
				<fmt:message key="global.delete" />
			</button>
		</div>
		
		
		<!-- 添加内容区域 -->
		<div class="neirong" id="add" style="display: none;width: 600px">
				<div class="top">
					<div class="top_01" id="thisisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">项目名称</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#close').click();">关闭</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				
				
					<div class="midd" >
					   <form action="#" name="operform" id="operform" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="dflabelclass">
										<label for="typename">
											<span id="qtypename"></span>
										</label>
									</td>
									<td width="20%">
										<font style="color:red;">*</font>
										<input type="text" id="typename" class="textclass" style="width:80%;"/>
									</td>
									
									<td class="dflabelclass">
										<label for="memo">
											<span id="qmemo"></span>
										</label>
									</td>
									<td width="20%">
										<input type="text" id="memo" class="textclass"/>
									</td>
									
								</tr>
								
								
							</table>
						</form>
					</div>	
				
					<div class="midd_butt">
							<button type="submit" class="tsdbutton" id="saveadd" onclick="saveInfo(1)">
								保存添加
							</button>
							<button type="submit" class="tsdbutton" id="saveexit" onclick="saveInfo(2)" style="margin-left: 10px">
								保存退出
							</button>
							<button type="submit" class="tsdbutton" id="modify" onclick="modifyInfo();">
								<fmt:message key="global.edit" />
							</button>
							<button type="button" class="tsdbutton" id="close" style="margin-left: 10px" onclick="reloadData();">
								<fmt:message key="global.close" />
							</button>
					</div>
	<%
		String theIE = request.getHeader("User-Agent");
		int theflag = 0;
		if(theIE.indexOf("MSIE 6.0")!=-1){
			theflag = 1;
		}else if(theIE.indexOf("MSIE 7.0")!=-1||theIE.indexOf("MSIE 8.0")!=-1){
			theflag = 2;
		}
	%>		
	<%
		if(theflag==1){
	%>
		<br/>
		<br/>
		<br/>
		<br/>
	<%		
		}else if(theflag==2){
	%>
		<br/>
	<%		
		}
	%>
		</div>
		
		<input type='hidden' id="addright"/>
		<input type='hidden' id="deleteright"/>
		<input type='hidden' id="thecolumn"/>
		<input type='hidden' id="editright"/>
		<input type='hidden' id="thekey"/>
		<input type='hidden' id="queryright"/>
		
	</body>
</html>
