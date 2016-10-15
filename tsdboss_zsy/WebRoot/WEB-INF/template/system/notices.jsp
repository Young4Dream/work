<%----------------------------------------
	name: notices.jsp
	author: chenliang
	version: 1.0, 2010-03-10
	description: 对通知通告的一个管理
	modify: 
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/fck" prefix="FCK"%>
<%@ page language="java" import="java.util.*,com.tsd.javabean.NoticeBean" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";

	String userid = (String) session.getAttribute("userid");
	
	NoticeBean nb = (NoticeBean)request.getAttribute("noticeinfo");
	boolean ismodify = false;
	if(null!=nb&&!"".equals(ismodify)){
		ismodify = true;
	}
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
	
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>通知通告管理</title>
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
		<script type="text/javascript" src="script/public/transfer.js"></script>
		
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
        tsdpname : 'notices.getPower', //存储过程的映射名称
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
    var editfields = '';
    var queryright = '';
    var saveQueryMright = '';
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
            editfields += getCaption(spower, 'editfields', '');
            queryright += getCaption(spowerarr[i], 'query', '') + '|';
            saveQueryMright += getCaption(spowerarr[i], 'saveQueryM', '') + '|';
        }
    }
    else if (spower == 'all@')
    {
        $("#addright").val(str);
        $("#deleteright").val(str);
        $("#editright").val(str);
        $("#queryright").val(str);
        $("#saveQueryMright").val(str);
        flag = true;
    }
    var hasadd = addright.split('|');
    var hasdelete = deleteright.split('|');
    var hasedit = editright.split('|');
    var hasquery = queryright.split('|');
    var hassaveQueryM = saveQueryMright.split('|');
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
        for (var i = 0; i < hassaveQueryM.length; i++) {
            if (hassaveQueryM[i] == 'true') {
                $("#saveQueryMright").val(str);
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
    //$("#navBar1").append(genNavv());
    /**********************
            **   取得当前用户的权限  *
            **********************/
    getUserPower();
    getTypeName();
    //初始化公告类型
    var addright = $("#addright").val();
    if (addright == "true")
    {
        document.getElementById("openadd1").disabled = false;
        document.getElementById("openadd2").disabled = false;
    }
    var deleteright = $("#deleteright").val();
    if (deleteright == "true")
    {
        document.getElementById("opendel1").disabled = false;
        document.getElementById("opendel2").disabled = false;
    }
    var queryright = $("#queryright").val();
    var saveQueryMright = $("#saveQueryMright").val();
    if (queryright == "true")
    {
        document.getElementById("query1").disabled = false;
        document.getElementById("query2").disabled = false;
    }
    if (saveQueryMright == "true")
    {
        document.getElementById("savequery1").disabled = false;
        document.getElementById("savequery2").disabled = false;
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
        tsdpk : 'notices.query', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'notices.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    var column = '';
    var thisdata = loadData('notices', '<%=languageType %>', 1, '修改&nbsp;|&nbsp;详细');
    column = thisdata.FieldName.join(',');
    $('#thecolumn').val(column);
    $("#qnid").html(thisdata.getFieldAliasByFieldName('nid'));
    $("#qtitle").html(thisdata.getFieldAliasByFieldName('title'));
    $("#qmemo").html(thisdata.getFieldAliasByFieldName('memo'));
    $("#qtype").html(thisdata.getFieldAliasByFieldName('type'));
    $("#sqtype").html(thisdata.getFieldAliasByFieldName('type'));
    $("#quptime").html(thisdata.getFieldAliasByFieldName('uptime'));
    $("#squptime").html(thisdata.getFieldAliasByFieldName('uptime'));
    $("#qupman").html(thisdata.getFieldAliasByFieldName('upman'));
    $("#squpman").html(thisdata.getFieldAliasByFieldName('upman'));
    $("#qflag").html(thisdata.getFieldAliasByFieldName('flag'));
    $("#qtopinfo").html(thisdata.getFieldAliasByFieldName('topinfo'));
    $("#qnews").html(thisdata.getFieldAliasByFieldName('news'));
    $("#qisread").html(thisdata.getFieldAliasByFieldName('isread'));
    $("#qhots").html(thisdata.getFieldAliasByFieldName('hots'));
    //jqgrid隐藏某一列的值
    thisdata.colModels[1].hidden = true;
    thisdata.setWidth({
        Operation : 75, uptime : 148
    });
    jQuery("#editgrid").jqGrid(
    {
        url : 'mainServlet.html?' + urlstr + '&cloumn=' + column, datatype : 'xml',
         colNames : thisdata.colNames, 
        colModel : thisdata.colModels, rowNum : 15, //默认分页行数
        rowList : [10, 15, 20], //可选分页行数
        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images/', pager : jQuery('#pagered'), sortname : 'uptime', 
        //默认排序字段
        viewrecords : true, multiselect : true, multiselectWidth : 20, sortorder : 'desc', //默认排序方式 
        caption : '通知通告管理', height : 300, //高
        width:document.documentElement.clientWidth-75,
        loadComplete : function ()
        {
            if ($("#editgrid tr.jqgrow[id='1']").text() == "") {
                $("#editgrid tr.jqgrow[id='1']").remove();
                return false;
            }
            addRowOperBtn('editgrid', '<img src="style/images/public/ltubiao_01.gif" alt="修改"/>', 'exeServlet', 'nid', 
            'click', 1);
            addRowOperBtn('editgrid', '<img src="style/images/public/ltubiao_03.gif" alt="查看阅读日志"/>', 'readMemo', 'nid', 
            'click', 2);
            //addRowOperBtn('editgrid','<img src="style/images/public/ltubiao_02.gif" alt="删除"/>','deleteRow','groupid','click',2);
            executeAddBtn('editgrid', 2);
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
    var ismodify = '<%=ismodify %>';
    if (ismodify == 'true') {
        openRowUpdate();
    }
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
    SetEditorContents('');
    $('#isread').val(0);
    $('#readers').hide();
    $('#saveadd').show();
    $('#saveexit').show();
    $('#modify').hide();
    autoBlockForm('add', 10, 'close', "#ffffff", false);
    //弹出查询面板
    $('#titlediv').html('<fmt:message key="global.add" />');
}
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
    oEditor.SetHTML(str) ;
}
/**
 * 拼参数
 * @param 无参数
 * @return String
 */
function buildParams()
{
    //先取得fck编辑器中的输入值
    getFckValue();
    //每次拼接参数必须初始化此参数
    tsd.QualifiedVal = true;
    var params = '';
    var title = $("#title").val();
    if (title == '' || null == title) {
        alert('请输入公告标题!');
        $('#title').focus();
        return false;
    }
    var type = $("#type").val();
    var flag = $("#flag").val();
    var topinfo = $('#topinfo').val();
    var news = $('#news').val();
    var isstr = getTheChecked('values');
    var isreadstr = $('#isread').val();
    var isread = isstr + '@' + isreadstr;
    var memo = $("#memo").val();
    params += '&title=' + tsd.encodeURIComponent(title);
    params += '&type=' + tsd.encodeURIComponent(type);
    params += '&flag=' + tsd.encodeURIComponent(flag);
    params += '&topinfo=' + tsd.encodeURIComponent(topinfo);
    params += '&news=' + tsd.encodeURIComponent(news);
    params += '&upman=' + tsd.encodeURIComponent('<%=session.getAttribute("userid") %>');
    params += '&isread=' + tsd.encodeURIComponent(isread);
    var memostr = memo.replace(/<IMG/g, 'tsd_@');
    var memostrs = memostr.replace(/"/g, '@#');
    params += '&memo=' + tsd.encodeURIComponent(memostrs);
    //每次拼接参数必须添加此判断
    if (tsd.Qualified() == false) {
        return false;
    }
    return params;
}
/**
 * 添加完成，进行数据交互即保存
 * @param thesave(添加状态：1.保存增加；2.保存退出)
 * @return 无返回值
 */
function saveInfo(thesave)
{
    /***************************
                                *     判断完成，进行保存操作   * 
                                ***************************/
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
        tsdpk : 'notices.save'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
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
                if (thesave == 1)
                {
                    clearText('operform');
                    getTypeName();
                    SetEditorContents('');
                    $('#readers').hide();
                    $('#title').focus();
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
 * @return 无返回值(成功删除)/false(未选中要删除的类型)
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
            idarr.push($('#editgrid').getCell(arr[i], 'nid'));
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
    //设置命令参数
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : 'notices.delete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
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
}

/**
 * 修改信息
 * @param 无参数
 * @return 无返回值
 */
function openRowUpdate()
{
     <% if (ismodify == true)
    {
         %> $('#titlediv').html('<fmt:message key="global.edit" />');
        $("#modify").show();
        $("#saveinfo").hide();
        $("#title").val('<%=nb.getTitle() %>');
        $("#type").val('<%=nb.getType() %>');
        $("#flag").val('<%=nb.getFlag() %>');
        $('#topinfo').val('<%=nb.getTopinfo() %>');
        $('#news').val('<%=nb.getNews() %>');
        var isreadvalue = '<%=nb.getIsread() %>';
        if (isreadvalue.indexOf('@') !=- 1)
        {
            var arrstr = isreadvalue.split('@');
            $('#isread').val(arrstr[1]);
            //初始化值
            getTheRead();
            //初始化复选框显示
            forChecked('values', arrstr[0]);
            //显示选中值 
        }
        SetEditorContents('<%=nb.getMemo() %>');
        autoBlockForm('add', 10, 'close', "#ffffff", true);
        //弹出查询面板 
         <% 
    }
     %> 
}
/**
 * 执行servlet执行查询
 * @param key(唯一标识)
 * @return 无返回值
 */
function exeServlet(key)
{
    var hasright = $('#editright').val();
    if (hasright == 'true') {
        $('#nid').val(key);
        $('#issubmit').click();
    }
    else {
        alert('对不起，您无修改权限!');
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
        tsdpk : 'notices.modify'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
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
        tsdpk : 'notices.query', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'notices.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    var thecolumn = $('#thecolumn').val();
    $("#editgrid").setGridParam({
        url : 'mainServlet.html?' + urlstr + '&cloumn=' + thecolumn
    }).trigger("reloadGrid");
    setTimeout($.unblockUI, 15);
    //关闭面板
}

//$(function(){
// $("#add").draggable({dragPrevention:"input"}); //随便点击都可拖动
//});
/**
 * 先将所有系统营业区域取出
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
 * 阅读权限控制
 * @param 无参数
 * @return 无返回值
 */
function getTheRead()
{
    var isread = $('#isread').val();
    //var isreadvalue = '';//全局阅读权限为空
    if (isread != 0)
    {
        var isvalue = '';
        var name = '';
        var disinfo = '';
        if (isread == 1) {
            //业务区域
            isvalue = 'YwArea';
            name = 'Area_Ywsl';
            disinfo = '业务区域';
        }
        else if (isread == 2) {
            //营业区域
            isvalue = 'Area';
            name = 'Asys_Area';
            disinfo = '营业区域';
        }
        else if (isread == 3) {
            //部门
            isvalue = 'Bm';
            name = 'ScddBm';
            disinfo = '部门';
        }
        else if (isread == 4) {
            //工号
            isvalue = 'username';
            name = 'sys_user';
            disinfo = '工号';
        }
        $('#disinfo').html(disinfo + '列表');
        var urlstr = tsd.buildParams(
        {
            packgname : 'service', //java包
            clsname : 'ExecuteSql', //类名
            method : 'exeSqlData', //方法名
            ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf : 'mssql', //指向配置文件名称
            tsdoper : 'query', //操作类型 
            datatype : 'xmlattr', //返回数据格式 
            tsdpk : 'notices.displayinfo'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax(
        {
            url : 'mainServlet.html?' + urlstr + '&isvalue=' + isvalue + '&name=' + name, datatype : 'xml', 
            cache : false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout : 1000, async : false , //同步方式
            success : function (xml)
            {
                var thevalue = "";
                var i = 1;
                $(xml).find('row').each(function ()
                {
                    var thebr = '';
                    if (i * 1 % 6 == 0) {
                        thebr = '<br/>';
                    }
                    thevalue += "<span class='spanstyle'><input type='checkbox' name='values' value='" + $(this).attr(isvalue) + "' style='width:15px;height:15px;'><label style='text-align: left;margin-left:5px'>" + $(this).attr(isvalue) + "</label></span>" + thebr;
                    i++;
                });
                var disbutton = "<div style='margin-left:230px'><button type='button' id='ischeck' class='tsdbutton' onclick='checkedAll()' style='margin-top: 0px;padding:0px 8px 0px 8px;line-height: 20px'>全选</button><button type='button' class='tsdbutton' onclick='checkedOK()' style='margin-top: 0px;padding:0px 8px 0px 8px;line-height: 20px'>确定</button></div>";
                $('#displayinfos').html(thevalue + '<hr/>' + disbutton);
                $('#displayinfos').show('slow');
                $('#displaychk').hide('slow');
                $('#readers').show();
            }
        });
    }
    else {
        $('#readers').hide();
    }
    //$('#isreadvalue').val(isread);
}
var x = 0;
/**
 * 全选
 * @param 无参数
 * @return 无返回值
 */
function checkedAll()
{
    var tagname = document.getElementsByName('values');
    for (var i = 0 ; i < tagname.length; i++) {
        if (x == 0) {
            tagname[i].checked = true;
        }
        else if (x == 1) {
            tagname[i].checked = false;
        }
    }
    if (x == 0) {
        $('#ischeck').val('不选');
        x = 1;
    }
    else if (x == 1) {
        $('#ischeck').val('全选');
        x = 0;
    }
}
/**
 * 获取被选中的值
 * @param name(将要处理的name值)
 * @return String
 */
function getTheChecked(name)
{
    var thename = document.getElementsByName(name);
    var thevalue = '';
    for (var i = 0; i < thename.length; i++) {
        if (thename[i].checked == true) {
            thevalue += thename[i].value + '~';
        }
    }
    var num = thevalue.lastIndexOf('~');
    thevalue = thevalue.substring(0, num);
    $('#thecheckedvalue').val(thevalue);
    if (thevalue.indexOf('~') == 0) {
        thevalue = thevalue.substring(1, thevalue.length);
    }
    return thevalue;
}
/**
 * 将值标记为选中的
 * @param name(将要处理文本框的name值)
 * @param thisvalue(将要处理文本框的value值)
 * @return 无返回值
 */
function forChecked(name, thisvalue)
{
    if ('' != thisvalue && null != thisvalue)
    {
        var thenum = thisvalue.lastIndexOf('~');
        var m = 0;
        if (thenum ==- 1) {
            thisvalue += '~';
            m = 1;
        }
        var thearr = thisvalue.split('~');
        var tagname = document.getElementsByName(name);
        //获取name的所有的值
        for (var i = 0 ; i < tagname.length; i++)
        {
            //获取以前的记录选中值
            for (var j = 0; j < thearr.length - m; j++) {
                if (tagname[i].value == thearr[j]) {
                    tagname[i].checked = true;
                    break;
                }
            }
        }
    }
}
/**
 * 确认选择
 * @param 无参数
 * @return 无返回值
 */
function checkedOK()
{
    var checkedvalue = getTheChecked('values');
    $('#disinfo').html('阅读范围');
    $('#displayinfos').hide('slow');
    $('#displaychk').html(checkedvalue);
    $('#displaychk').show('slow');
}
/**
 * 替换字符串中全部的知道字符串
 * @param replacestr
 * @param replacevalue
 * @param str
 * @return String
 */
function replaceStr(replacestr, replacevalue, str)
{
    var displayStr = str.replace(/replacestr/g, replacevalue);
    return displayStr;
}
/**
 * 查看阅读日志详细信息
 * @param nid(唯一标识)
 * @return 无返回值
 */
function readMemo(nid)
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
        tsdpk : 'notices.queryreadmemo'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&nid=' + nid, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 3000, async : false , //同步方式
        success : function (xml)
        {
            var noticelog = '';
            var noticetitle = '';
            var x = 0;
            $(xml).find('row').each(function ()
            {
                var memotitle = $(this).attr('title');
                if (memotitle != undefined)
                {
                    noticetitle = memotitle;
                    var username = $(this).attr('username');
                    var readtime = $(this).attr('readtime');
                    var loginip = $(this).attr('loginip');
                    var sta = '<table width="350px" style="border:1px;border-style: solid; border-color: #87CEFA;" cellpadding="2px" cellspacing="1px"><tr>';
                    var infos = '<td width="150px"  style="border:1px;border-style: solid; border-color: #87CEFA;text-align:center">' + readtime + '</td>';
                    infos += '<td width="100px" style="border:1px;border-style: solid; border-color: #87CEFA;text-align:center"><b>' + username + '</b></td>';
                    infos += '<td width="100px" style="border:1px;border-style: solid; border-color: #87CEFA;text-align:center">' + loginip + '</td>';
                    var end = '</tr></table>';
                    noticelog += sta + infos + end;
                }
                else {
                    x = 1;
                }
            });
            var tabletitle = '<table width="350px" style="border:1px;border-style: solid; border-color: #87CEFA;" cellpadding="2px" cellspacing="1px"><tr><td width="145px" style="text-align:center;background-color:#CCCCCC">阅读时间</td><td width="100px"style="text-align:center;background-color:#CCCCCC">阅读人</td><td width="100px" style="text-align:center;background-color:#CCCCCC">登陆IP</td></tr></table>';
            if (x == 0)
            {
                $("#displayreadmemo").html('<h2><<' + noticetitle + '>>的阅读日志</h2>' + '<hr/>' + tabletitle + noticelog);
            }
            else {
                $("#displayreadmemo").html('<hr/><h2>暂无阅读信息...</h2><hr/>');
            }
            autoBlockForm('readmemo', 10, 'closememo', "#ffffff", false);
            //弹出查询面板
        }
    });
}
/**
 * 初始化面板拖动
 * @param 无参数
 * @return 无返回值
 */
$(function ()
{
    $("#readmemo").draggable({
        handle : "thisdrags"
    });
});
/**
 * 关闭通知通告阅读信息
 * @param 无参数
 * @return 无返回值
 */
function readmemohide()
{
    $('#readmemo').hide('slow');
}
/**
 * 校验是否输入数据
 * @param 无参数
 * @return boolean
 */
function checkedInput()
{
    getFckValue();
    //获取编辑器的输入值
    var title = $('#title').val();
    var memo = $('#memo').val();
    if ('' == title || null == title) {
        alert('请输入通告标题!');
        $('#title').focus();
        return false;
    }
    if ('' == memo || null == memo) {
        alert('请输入通告内容!');
        return false;
    }
    if (title != '' && memo != '') {
        return true;
    }
}
/*
//执行复合查询出提交过来的相应操作
function fuheExe()
{
    var queryName = $('#queryName').val();
    if (queryName == "query") {
        fuheQuery('notice.queryByWhere', 'notice.queryByWherepage');
    }
}
*/
/**
 * 执行复合查询出提交过来的相应操作
 * @param 无参数
 * @return 无返回值
 */
function fuheExe()
{
    var queryName = $('#queryName').val();
    if (queryName == "query") {
        fuheQuery();
    }
}
/**
 * 简单查询操作
 * @param 无参数
 * @return 无返回值
 */
function fuheQuery(){
	fuheQueryMain('notices.queryByWhere', 'notices.queryByWherepage');
}
/**
 * 简单查询具体操作
 * @param querysql(查询语句)
 * @param querypagesql(分页语句)
 * @return 无返回值
 */
function fuheQueryMain(querysql,querypagesql)
				{
					var params = fuheQbuildParams();			
					if(params=='&fusearchsql='){
						params +='1=1';
					}	
							
				 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
				 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
												  clsname:'ExecuteSql',//类名
												  method:'exeSqlData',//方法名
												  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												  tsdcf:'mssql',//指向配置文件名称
												  tsdoper:'query',//操作类型 
												  datatype:'xml',//返回数据格式 
												  tsdpk:querysql,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												  tsdpkpagesql:querypagesql
												});
					var languageType = $('#languageType').val();					
					var link = urlstr1 + params+'&lang='+languageType;	
					var column = $('#thecolumn').val();
				 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&cloumn='+column}).trigger("reloadGrid");
				 	setTimeout($.unblockUI, 15);//关闭面板			
				}
/**
 * 弹出简单查询面板
 * @param 无参数
 * @return 无返回值
 */
function openQueryNotice()
{
    clearText('querynoticeforms');
    var nowtime = getDate();
    nowtime = nowtime.substring(0, 10);
    $('#queryuptime').val(nowtime);
    $('#whichorder').val(0);
    //简单查询
    autoBlockForm('querynoticeform', 60, 'queryclose', "#ffffff", true);
    //弹出面板
}
/**
 * 获取系统时间
 * @param 无参数
 * @return int
 */
function getDate() 
{
    var d, s, t;
    d = new Date();
    s = d.getFullYear().toString(10) + "-";
    t = d.getMonth() + 1;
    s += (t > 9 ? "" : "0") + t + "-";
    t = d.getDate();
    s += (t > 9 ? "" : "0") + t + " ";
    //t=d.getHours();
    //s+=(t>9?"":"0")+t+":";
    //t=d.getMinutes();
    //s+=(t>9?"":"0")+t+":";
    //t=d.getSeconds();
    //s+=(t>9?"":"0")+t;
    return s;
}
/**
 * 执行查询
 * @param 无参数
 * @return 无返回值
 */
function queryNotice()
{
    var noticetype = $('#querynoticetype').val();
    var uptime = $('#queryuptime').val();
    var upman = $('#queryupman').val();
    var params = '';
    params += '&type=' + tsd.encodeURIComponent(noticetype);
    params += '&uptime=' + tsd.encodeURIComponent(uptime);
    params += '&upman=' + tsd.encodeURIComponent(upman);
    var expparams = ' 1=1 ';
    if (noticetype != '') {
        expparams += " and type='" + tsd.encodeURIComponent(noticetype) + "'";
    }
    if (uptime != '')
    {
        expparams += " and to_char(uptime,'yyyy-mm-dd hh24:mi:ss') like '%" + tsd.encodeURIComponent(uptime) + "%'";
    }
    if (upman != '') {
        expparams += " and upman='" + tsd.encodeURIComponent(upman) + "'";
    }
    $('#fusearchsql').val(expparams);
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        datatype : 'xml', //返回数据格式 
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        tsdpk : 'notices.queryjd', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'notices.querypagejd'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    var thecolumn = $('#thecolumn').val();
    $('#jdparams').val('&cloumn=' + thecolumn + params);
    $("#editgrid").setGridParam({
        url : 'mainServlet.html?' + urlstr + '&cloumn=' + thecolumn + params
    }).trigger("reloadGrid");
    setTimeout($.unblockUI, 15);
    //关闭面板
}



/**
 * 复合查询参数获取，@oper 操作类型 fuhe
 * @param 无参数
 * @return String
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
    var flag = $('#whichorder').val();
    var sql = '';
    var pagesql = '';
    //0：简单查询 1：高级查询
    if (flag == 0)
    {
        var jdparams = $('#jdparams').val();
        params += jdparams + '&tsdOrderBy=' + sqlstr;;
        sql = 'notices.queryjd';
        pagesql = 'notices.querypagejd';
    }
    else if (flag == 1 || flag == 2)
    {
        params = fuheQbuildParams();
        if (params == '&fusearchsql=') {
            params += '1=1';
        }
        var column = $("#thecolumn").val();
        params = params + '&orderby=' + sqlstr + '&column=' + column;
        params += '&orderkey=nid';
        params += '&ordertablename=notices';
        sql = 'main.queryByOrder';
        pagesql = 'main.queryByOrderpage';
    }
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
			.tdstylebottom{border-bottom:0px solid #A9C8D9;}
			.spanstyle{display:-moz-inline-box; display:inline-block; width:110px}
			hr {margin:2px 0 2px 0;border:0;border-top:1px dashed #CCCCCC;height:0;}
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
		<div id="navBar" >
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar1" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
							<fmt:message key="global.location" />
							:
							<%=pmenuname %> >>> <%=imenuname %>
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
			<button type="button" id="order1" onclick="openDiaO('notices');" >
				<!-- 组合排序 -->	<fmt:message key="tariff.order" />
			</button>
			<button type="button" id="openadd1" onclick="openText()"
				disabled="disabled">
				<fmt:message key="global.add" />
			</button>
			<button type="button" onclick="openQueryNotice()">
				<fmt:message key="global.query" />
			</button>
			<button type="button" id="query1" disabled="disabled"  onclick="openDiaQueryG('query','notices')">
				高级查询
			</button>
			<button id='gjquery1' onclick='openQueryM(1);' >
				<fmt:message key="oper.mod"/>
			</button>
			
			<button id='savequery1' onclick="openModT();" disabled="disabled">
				<fmt:message key="oper.modSave"/>
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
			<button type="button" id="order2" onclick="openDiaO('notices');" >
				<!-- 组合排序 -->	<fmt:message key="tariff.order" />
			</button>
			<button type="button" id="openadd2" onclick="openText()"
				disabled="disabled">
				<fmt:message key="global.add" />
			</button>
			<button type="button" onclick="openQueryGroup()">
				<fmt:message key="global.query" />
			</button>
			<button type="button" id="query2" disabled="disabled" onclick="openDiaQueryG('query','notices')">
				高级查询
			</button>
			<button id='gjquery2' onclick='openQueryM(1);' >
				<fmt:message key="oper.mod"/>
			</button>
			
			<button id='savequery2' onclick="openModT();" disabled="disabled">
				<fmt:message key="oper.modSave"/>
			</button> 
			<button type="button" id="opendel2" onclick="deleteRows()"
				disabled="disabled">
				<fmt:message key="global.delete" />
			</button>
		</div>
		
		<!-- 添加内容区域 -->
		<div class="neirong" id="add" style="display: none;width: 800px;">
				<div class="top">
					<div class="top_01" id="thisdrag">
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
					   <form action="notices" name="operform" method="post" id="operform" onsubmit="return checkedInput();return false;">
						<!-- <form action="#" name="operform" method="post" id="operform" onsubmit="return false;"> -->
						<input type='hidden' name="nmenuid" value="<%=imenuid %>"/>
						<input type='hidden' name="npmenuname" value="<%=pmenuname %>"/>
						<input type='hidden' name="ngroupid" value="<%=zid %>"/>
						<input type='hidden' name="nimenuname" value="<%=imenuname %>"/>
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="labelclass">
										<label for="title">
											<span id="qtitle"></span>
										</label>
									</td>
									<td width="20%" class="tdstyle">
										<input type="text" name="title" id="title" class="textclass" style="width: 88%"/>
										<font style="color:red;">*</font>
									</td>
									
									<td class="labelclass">
										<label for="type">
											<span id="qtype"></span>
										</label>
									</td>
									<td width="20%" class="tdstyle">
										<select id="type" name="type" style="width: 150px" class="textclass"></select>
										<font style="color:red;">*</font>
									</td>
									
									<td class="labelclass">
										<label for="flag">
											<span id="qflag"></span>
										</label>
									</td>
									<td width="20%" class="tdstyle">
										<select id="flag" name="flag" style="width: 150px" class="textclass">
											<option value="0" selected="selected">已审核</option>
											<option value="1">未审核</option>
										</select>
										<font style="color:red;">*</font>
									</td>
								</tr>
								
								
								<tr>
									<td class="labelclass">
										<label for="topinfo">
											<span id="qtopinfo"></span>
										</label>
									</td>
									<td width="20%" class="tdstyle">
										<select id="topinfo" name="topinfo" style="width: 150px" class="textclass">
											<option value="0" selected="selected">不置顶</option>
											<option value="1">置顶</option>
										</select>
										<font style="color:red;">*</font>
									</td>
									<td class="labelclass">
										<label for="news">
											<span id="qnews"></span>
										</label>
									</td>
									<td width="20%" class="tdstyle">
										<select id="news" name="news" style="width: 150px" class="textclass">
											<option value="0" selected="selected">不推荐</option>
											<option value="1">推荐</option>
										</select>
										<font style="color:red;">*</font>
									</td>
									<td class="labelclass">
										<label for="isread">
											<span id="qisread"></span>
										</label>
									</td>
									<td width="20%" class="tdstyle">
										<select id="isread" name="isread" style="width: 150px" class="textclass" onchange="getTheRead()">
											<option value="0" selected="selected">全局</option>
											<option value="1">业务区域</option>
											<option value="2">营业区域</option>
											<option value="3">部门</option>
											<option value="4">个人</option>
										</select>
										<font style="color:red;">*</font>
									</td>
								</tr>
								
								
								<tr id="readers" style="display: none">
									<td class="labelclass" id="disinfo">
									</td>
									<td width="20%" colspan="5" class="tdstyle">
										<div id="displayinfos" style="max-height:200px;overflow-y: auto;overflow-x: hidden;"></div>
										<div id="displaychk" style="display: none;max-height:200px;overflow-y: auto;overflow-x: hidden;"></div>
									</td>
								</tr>
								
								<tr>
									<td class="dflabelclass">
										<label for="memo">
											<span id="qmemo"></span>
										</label>
									</td>
									<td colspan="5" width="80%" style="text-align: left;">
										<FCK:editor id="EditorAccessibility" width="100%" height="200"
											fontNames="宋体;黑体;隶书;楷体_GB2312;Arial;Comic Sans MS;Courier New;Tahoma;Times New Roman;Verdana"
											imageBrowserURL="/tsd2009/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector"
											linkBrowserURL="/tsd2009/FCKeditor/editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector"
											flashBrowserURL="/tsd2009/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Flash&Connector=connectors/jsp/connector"
											imageUploadURL="/tsd2009/FCKeditor/editor/filemanager/upload/simpleuploader?Type=Image"
											linkUploadURL="/tsd2009/FCKeditor/editor/filemanager/upload/simpleuploader?Type=File"
											flashUploadURL="/tsd2009/FCKeditor/editor/filemanager/upload/simpleuploader?Type=Flash">
										</FCK:editor>
										
										<input type="hidden" name="memo" id="memo"/>
									</td>
								</tr>
							</table>
							
							<div class="midd_butt">
								<!-- 
								<button type="submit" class="tsdbutton" id="saveadd" onclick="saveInfo(1)">
									保存添加
								</button>
								<button type="submit" class="tsdbutton" id="saveexit" onclick="saveInfo(2)" style="margin-left: 10px">
									保存退出
								</button>
								 -->
								<button type="submit" class="tsdbutton" id="saveinfo" style="margin-left: 10px">
									保存
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
							
						</form>
					</div>	
		</div>
		
		<input type="hidden" id="isreadvalue"/>
		<input type='hidden' id="addright"/>
		<input type='hidden' id="deleteright"/>
		<input type='hidden' id="thecolumn"/>
		<input type='hidden' id="editright"/>
		<input type='hidden' id="exportright"/>
		<input type='hidden' id="thekey"/>
		
		<div style="display: none">
			<form action="notices" name="nidform" method="post">
				<input type='hidden' name="mmenuid" value="<%=imenuid %>"/>
				<input type='hidden' name="mpmenuname" value="<%=pmenuname %>"/>
				<input type='hidden' name="mgroupid" value="<%=zid %>"/>
				<input type='hidden' name="mimenuname" value="<%=imenuname %>"/>
				<input type='hidden' id="nid" name="nid"/>
				<input type="submit" id="issubmit" />
			</form>
		</div>
		
		
		
		<div class="neirong" id="readmemo" style="width: 540px;display: none;margin-top:20px">
				<div class="top">
					<div class="top_01" id="thisdrags">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03">查看阅读公告日志信息</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#closememo').click();">关闭</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd">
					<form action="#" method="post" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="tdstylebottom">
									<div id="displayreadmemo" style="line-height: 20px;max-height:300px;overflow-y: auto;overflow-x: hidden;text-align: center;">
									</div>
									<br />
								</td>
							</tr>
							
						</table>
						<div class="midd_butt">
							<button type="button" class="tsdbutton" id="closememo" style="margin-left: 10px" onclick="readmemohide()">
								<fmt:message key="global.close" />
							</button>
						</div>
						<%
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
				</form>
		</div>
		
		<!-- 添加模板面板 -->
<div id="modT" name='modT' style="display: none"  class="neirong">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" >功能名称</div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeoMod()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='addquery' name="addquery" onsubmit="return false;" action="#" >
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			
			  	<tr>
				    <td width="12%" align="right" class="labelclass"><label id="nameg_mod"><fmt:message key="oper.modName"/></label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="name_mod" id="name_mod" onkeyup="this.value=replaceStrsql(this.value,80)" class="textclass"/>
				    	<font style="color: #ff0000;">*</font></td>
				    
				    <td width="12%" align="right"  class="labelclass"><label id=''></label></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
					
				    <td width="12%" align="right"  class="labelclass"></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
			 	 </tr>	  
			</table>
		</form>
		<div class="midd_butt">
		<!-- 保存 --><button class="tsdbutton" id="saveModB" style="width:80px;heigth:27px;" onclick="saveModQuery(1);" ><fmt:message key="global.save" /></button>
	 	<!-- 关闭 --><button class="tsdbutton" id="closeModB" style="width:63px;heigth:27px;" onclick="closeoMod();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>			
					<!-- 查询树信息存放 -->
				<input type="hidden" id='treepid' />	
				<input type="hidden" id='treecid' />	
				<input type="hidden" id='treestr' />	
				<input type="hidden" id='treepic' />	
				
				<!-- 高级查询 模板隐藏域 -->
				<input type="hidden" id="queryright"/>
				<input type="hidden" id="saveQueryMright"/>		
				
				<input type="hidden" id="jdparams"/>		
				<input type="hidden" id="whichorder" value="2"/>		
		
				
				<input type="hidden" id="useridd" value="<%=userid %>"/>
		</div>
		
		
		
		<!-- 工号简单查询 -->
		<div class="neirong" id="querynoticeform" style="display: none;width:800px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
						<div class="top_03" id="titlediv">查询</div>
						<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
					</div>
					<div class="top_01right"><a href="#" onclick="javascript:$('#queryclose').click();">关闭</a></div>
				</div>
				<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
			</div>
			<div class="midd" >
				<form action="#" id="querynoticeforms" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>	
								<td class="dflabelclass">
									<label id="sqtype"></label>
								</td>
								<td>
									<input type="text" id="querynoticetype" style="width:150px" class="textclass"/>
								</td>
								<td class="dflabelclass">
									<label id="squptime"></label>
								</td>
								<td>
									<input type="text" id="queryuptime" style="width:150px" onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})" readonly="readonly" class="textclass"/>
								</td>
								<td class="dflabelclass">
									<label id="squpman"></label>
								</td>
								<td>
									<input type="text" id="queryupman" style="width:150px" class="textclass"/>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" onclick="queryNotice()">
						<fmt:message key="global.query" />
					</button>
					<button type="button" class="tsdbutton" id="queryclose" style="margin-left: 10px">
						<fmt:message key="global.close" />
					</button>
				</div>
		</div>		
		
		<input type="hidden" id="imenuid" value="<%=imenuid%>" />
		<input type="hidden" id="zid" value="<%=zid%>" />
		<input type="hidden" id="operationtips"
					value="<fmt:message key="global.operationtips"/>" />
		<input type="hidden" id="successful"
					value="<fmt:message key="global.successful"/>" />
	</body>
</html>
