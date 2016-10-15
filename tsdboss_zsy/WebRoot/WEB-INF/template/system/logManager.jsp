<%----------------------------------------
	name: logManager.jsp
	author: chenliang
	version: 1.0, 2009-11-26
	description: 对系统日志的管理
	modify: 
		  2009-11-26 chenliang  添加功能注释.
	      2009-12-03 chenliang  添加国际化，修改日志详细信息显示
	      2009-12-05 chenliang  修改jqgrid
	 	  2009-12-14 chenliang  修改jqgrid显示格式
	 	  2010-01-12 chenliang  查看日志添加权限
	 	  2010-12-25   youhongyu  导出提示修改
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		<title>logManager</title>
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
		<script type="text/javascript" src="script/public/datalength.js"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		
		<!-- 验证框架需要导入的js文件 -->
		<script src="plug-in/jquery/validate/jquery.validate.js" type="text/javascript"></script>
		<!-- 时间选择器需要导入的js文件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
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
        tsdpname : 'logManager.getPower', //存储过程的映射名称
        tsdExeType : 'query', datatype : 'xmlattr' 
    });
    /************************
                *   调用存储过程需要的参数 *
                **********************/
    var userid = $('#userid').val();
    var groupid = $('#zid').val();
    var imenuid = $('#imenuid').val();
    /****************
                *   拼接权限参数 *
                **************/
    var addright = '';
    var deleteright = '';
    var delBright = '';
    var printright = '';
    var rightgroup = '';
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
    if (spower == 'all@')
    {
        addright = 'true';
        deleteright = 'true';
        delBright = 'true';
        printright = 'true';
        rightgroup = '10';
        queryright = 'true';
        saveQueryMright = 'true';
        flag = true;
    }
    else if (spower != '' && spower != 'all@')
    {
        var spowerarr = spower.split('@');
        for (var i = 0; i < spowerarr.length - 1; i++)
        {
            addright += getCaption(spowerarr[i], 'export', '') + '|';
            deleteright += getCaption(spowerarr[i], 'delete', '') + '|';
            delBright += getCaption(spowerarr[i], 'delB', '') + '|';
            printright += getCaption(spowerarr[i], 'print', '') + '|';
            rightgroup += getCaption(spowerarr[i], 'RightsGroup', '') + '|';
            queryright += getCaption(spowerarr[i], 'query', '') + '|';
            saveQueryMright += getCaption(spowerarr[i], 'saveQueryM', '') + '|';
        }
    }
    var hasadd = addright.split('|');
    var hasdelete = deleteright.split('|');
    var hasdelB = delBright.split('|');
    var hasprint = printright.split('|');
    var hasrightgroup = rightgroup.split('|');
    var hasquery = queryright.split('|');
    var hassaveQueryM = saveQueryMright.split('|');
    var str = 'true';
    if (flag == true)
    {
        $("#addright").val(addright);
        $("#deleteright").val(deleteright);
        $("#delBright").val(delBright);
        $("#printright").val(printright);
        $("#rightgroup").val(rightgroup);
        $("#queryright").val(queryright);
        $("#saveQueryMright").val(saveQueryMright);
    }
    else
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
        for (var i = 0; i < hasdelB.length; i++) {
            if (hasdelB[i] == 'true') {
                $("#delBright").val(str);
                break;
            }
        }
        for (var i = 0; i < hasprint.length; i++) {
            if (hasprint[i] == 'true') {
                $("#printright").val(str);
                break;
            }
        }
        //alert(hasrightgroup[0]);
        $("#rightgroup").val(hasrightgroup[0]);
        //for(var i = 0;i<hasrightgroup.length;i++){
        //if(hasrightgroup[i]=='true'){
        //$("#rightgroup").val(str);
        // break;
        //}
        //}
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
}
/**
 * pagered隐藏
 * @param 无参数
 * @return 无返回值
 */
function thisWillDisplsy()
{
    document.getElementById('pagered').style.display = 'block';
}
/**************************************
                存储过程操作示例
                -------------------------------
                具体参数请参照《泰思达WEB平台开发手册》
                -------------------------------
            **************************************/
/**
 * 初始化页面数据
 * @param 无参数
 * @return 无返回值
 */
jQuery(document).ready(function () 
{
    $("#navBar1").append(genNavv());
    /**********************
            **   取得当前菜单名称    *
            **********************/
    $("#titlee").html('<fmt:message key="log.managment"/>');
    getUserPower();
    var addright = $("#addright").val();
    if (addright == "true")
    {
        document.getElementById("openadd1").disabled = false;
        document.getElementById("openadd2").disabled = false;
    }
    var delBright = $("#delBright").val();
    if (delBright == "true")
    {
        document.getElementById("opendel1").disabled = false;
        document.getElementById("opendel2").disabled = false;
    }
    var printright = $("#printright").val();
    if (delBright == "true")
    {
        document.getElementById("print1").disabled = false;
        document.getElementById("print2").disabled = false;
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
    var params = '';
    //权限组 10: 系统管理员 3: 营业班长 0: 营业员或普通工号 
    var rightgroup = $('#rightgroup').val();
    var sql = '';
    var sqlpage = '';
    if (rightgroup == 10)
    {
        //权限组：管理员
        params += '&key=1';
        params += '&value=1';
        $('#logkey').val(1);
        $('#logvalue').val(1);
        sql += 'logManager.query';
        sqlpage += 'logManager.querypage';
    }
    else if (rightgroup == 3)
    {
        //营业班长
        params += '&str=' + getYytIP('<%=request.getSession().getAttribute("chargearea") %>');
        $('#yybzread').val('yybz');
        sql += 'logManager.queryarea';
        sqlpage += 'logManager.queryareapage';
        //thisdata.colModels[0].hidden=true;
    }
    else
    {
        //其他 --没开通权限的工号就只显示工号本身的日志信息
        params += '&key=userid';
        params += '&value=<%=request.getSession().getAttribute("userid") %>';
        $('#logkey').val('userid');
        $('#logvalue').val('<%=request.getSession().getAttribute("userid") %>');
        sql += 'logManager.query';
        sqlpage += 'logManager.querypage';
        //thisdata.colModels[0].hidden=true;
    }
    ///设置命令参数
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdLog', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xml', //返回数据格式 
        tsdpk : sql, //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : sqlpage//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    var column = '';
    //删除
    var thisdata = loadData('sys_log', '<%=languageType %>', 1, '&nbsp;&nbsp;'+'<fmt:message key="logManager.delete" />');
    column = thisdata.FieldName.join(',');
    $('#slogtime').html(thisdata.getFieldAliasByFieldName('logtime'));
    $('#slogtype').html(thisdata.getFieldAliasByFieldName('logtype'));
    $('#smodel').html(thisdata.getFieldAliasByFieldName('modulename'));
    $('#slogip').html(thisdata.getFieldAliasByFieldName('ipaddress'));
    $('#suserid').html(thisdata.getFieldAliasByFieldName('userid'));
    $('#thecolumn').val(column);
    //日志详细信息
    var sta = '<div id="input-Unit"><div id="inputtext"><div class="title"><h3 class="titlemargin"><fmt:message key="logManager.InformationDetailed" /></h3><span class="lguanbi"><a href="#" onclick=javascript:$("#closelog").click();><fmt:message key="global.close" /></a></span></div>';
    var end = '</div></div>';
    //jqgrid隐藏某一列的值
    thisdata.colModels[1].hidden = true;
    if (rightgroup == 0 || rightgroup == 3) {
        thisdata.colModels[0].hidden = true;
    }
    thisdata.setWidth(
    {
    	Operation : 60
        //Operation : 40, lid : 40, logtime : 124, userid : 60, modulename : 134, logtype : 50, loginfo : 150, 
        //ipaddress : 80
    });
    jQuery("#editgrid").jqGrid(
    {
        url : 'mainServlet.html?' + urlstr + '&cloumn=' + column + params, datatype : 'xml', colNames : thisdata.colNames, 
        colModel : thisdata.colModels, rowNum : 15, //默认分页行数
        rowList : [10, 15, 20], //可选分页行数
        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images/', pager : jQuery('#pagered'), sortname : 'logtime', 
        //默认排序字段
        viewrecords : true, //hidegrid: false, 
        sortorder : 'desc', //默认排序方式 
        caption : '<fmt:message key="log.managment"/>',
        height : document.documentElement.clientHeight - 182,
        //width : document.documentElement.clientWidth - 53,
        loadComplete : function ()
        {
            if ($("#editgrid tr.jqgrow[id='1']").html() == "") {
                return false;
            }
            $("#editgrid").setSelection('0', true);
            $("#editgrid").focus();
            ///自动适应 工作空间
            // var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
            // setAutoGridHeight("editgrid",reduceHeight);
            /*********定义需要的行链接按钮************
                                        ////@1  表格的id
                                        ////@2  链接名称
                                        ////@3  链接地址或者函数名称
                                        ////@4  行主键列的名称 可以是隐藏列
                                        ////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
                                        ////@6  按钮的位置，，，不允许重复，不允许跳跃， 范围：1+    */
            addRowOperBtn('editgrid', '', '', 'lid', 'click', 1);
            //删除
            addRowOperBtn('editgrid', '<img src="style/images/public/ltubiao_02.gif" alt="'+'<fmt:message key="logManager.delete" />'+'"/>', 'deleteRow', 'lid', 'click', 2);
            /****执行行按钮添加********
                                        *@1 表格ID
                                        *@2 操作按钮数量 等于定义数量
                                        *依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
            executeAddBtn('editgrid', 2);
        },
        onSelectRow : function (ids) 
        {
            //ids是返回的rowid,然后根据它再返回meetid     
            if (ids != null) 
            {
                $('#thelogid').val($("#editgrid").getCell(ids, "lid"));
                var logtime = thisdata.getFieldAliasByFieldName('logtime');
                var logtimevalue = $("#editgrid").getCell(ids, "logtime");
                if (logtimevalue != '' && null != logtimevalue) {
                    logtimevalue = logtimevalue.substring(0, 19);
                }
                $('#logtime').html(logtime);
                $('#logtimevalue').html(logtimevalue);
                var logtype = thisdata.getFieldAliasByFieldName('logtype');
                var logtypevalue = $("#editgrid").getCell(ids, "logtype");
                $('#logtype').html(logtype);
                $('#logtypevalue').html(logtypevalue);
                var logmodel = thisdata.getFieldAliasByFieldName('modulename');
                var logmodelvalue = $("#editgrid").getCell(ids, "modulename");
                $('#logmodel').html(logmodel);
                $('#logmodelvalue').html(logmodelvalue);
                var loguserid = thisdata.getFieldAliasByFieldName('userid');
                var loguseridvalue = $("#editgrid").getCell(ids, "userid");
                loguseridvalue = getTrueValue('tsdBilling', 'sys_user', 'username', 'userid', loguseridvalue, 
                '1', '1');
                $('#loguserid').html(loguserid);
                $('#loguseridvalue').html(loguseridvalue);
                var logip = thisdata.getFieldAliasByFieldName('ipaddress');
                var logipvalue = $("#editgrid").getCell(ids, "ipaddress");
                $('#logip').html(logip);
                $('#logipvalue').html(logipvalue);
                var logmemo = thisdata.getFieldAliasByFieldName('loginfo');
                var logmemovalue = $("#editgrid").getCell(ids, "loginfo");
                $('#logmemo').html(logmemo);
                $('#logmemovalue').html(logmemovalue);
                //autoBlockForm('loginfos',10,'closelog',"#ffffff",false);//弹出日志面板
            }
        },
        ondblClickRow : function (ids) 
        {
            if (ids != null) 
            {
                $('#thelogid').val($("#editgrid").getCell(ids, "lid"));
                var logtime = thisdata.getFieldAliasByFieldName('logtime');
                var logtimevalue = $("#editgrid").getCell(ids, "logtime");
                if (logtimevalue != '' && null != logtimevalue) {
                    logtimevalue = logtimevalue.substring(0, 19);
                }
                $('#logtime').html(logtime);
                $('#logtimevalue').html(logtimevalue);
                var logtype = thisdata.getFieldAliasByFieldName('logtype');
                var logtypevalue = $("#editgrid").getCell(ids, "logtype");
                $('#logtype').html(logtype);
                $('#logtypevalue').html(logtypevalue);
                var logmodel = thisdata.getFieldAliasByFieldName('modulename');
                var logmodelvalue = $("#editgrid").getCell(ids, "modulename");
                $('#logmodel').html(logmodel);
                $('#logmodelvalue').html(logmodelvalue);
                var loguserid = thisdata.getFieldAliasByFieldName('userid');
                var loguseridvalue = $("#editgrid").getCell(ids, "userid");
                loguseridvalue = getTrueValue('tsdBilling', 'sys_user', 'username', 'userid', loguseridvalue, 
                '1', '1');
                $('#loguserid').html(loguserid);
                $('#loguseridvalue').html(loguseridvalue);
                var logip = thisdata.getFieldAliasByFieldName('ipaddress');
                var logipvalue = $("#editgrid").getCell(ids, "ipaddress");
                $('#logip').html(logip);
                $('#logipvalue').html(logipvalue);
                var logmemo = thisdata.getFieldAliasByFieldName('loginfo');
                var logmemovalue = $("#editgrid").getCell(ids, "loginfo");
                $('#logmemo').html(logmemo);
                $('#logmemovalue').html(logmemovalue);
                autoBlockForm('loginfos', 60, 'closelog', "#ffffff", false);
                //弹出日志面板
            }
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
 * @param key(唯一标识)
 * @return 无返回值
 */
function deleteRow(key)
{
    var deleteright = $("#deleteright").val();
    /**************************
                     *    是否有执行删除的权限    *
                     *************************/
    if (deleteright == "true")
    {
        if (confirm('<fmt:message key="global.deleteinformation"/>'))
        {
            var urlstr = tsd.buildParams(
            {
                packgname : 'service', //java包
                clsname : 'ExecuteSql', //类名
                method : 'exeSqlData', //方法名
                ds : 'tsdLog', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
                tsdcf : 'mssql', //指向配置文件名称
                tsdoper : 'exe', //操作类型 
                tsdpk : 'logManager.delete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
            });
            $.ajax(
            {
                url : 'mainServlet.html?' + urlstr + '&lid=' + key, cache : false, //如果值变化可能性比较大 一定要将缓存设成false
                timeout : 1000, async : false , //同步方式
                success : function (msg)
                {
                    if (msg == "true")
                    {
                        alert('<fmt:message key="global.successful"/>', '<fmt:message key="global.operationtips"/>');
                        setTimeout($.unblockUI, 15);
                        var yybz = $('#yybzread').val();
                        if (yybz == '') {
                            reloadDataLog('logManager.query', 'logManager.querypage');
                        }
                        else {
                            reloadDataLog('logManager.queryarea', 'logManager.queryareapage');
                        }
                    }
                }
            });
        }
    }
    else
    {
        alert('<fmt:message key="global.deleteright"/>', '<fmt:message key="global.operationtips"/>');
    }
}
/**
 * 页面跳转 
 * @param pagename(页面名称)
 * @return 无返回值
 */
function jumpPage(pagename)
{
    if (pagename == "#") {
        return;
    }
    window.location = 'mainServlet.html?pagename=' + pagename + "&tsdtemp=" + Math.random();
}
/**
 * 执行复合查询出提交过来的相应操作 
 * @param 无参数
 * @return 无返回值
 */
function fuheExe()
{
    var queryName = $('#queryName').val();
    if (queryName == "delete") {
        fuheDelLog('logManager.deletebywhere', '<fmt:message key="log.managment"/>');
    }
    else {
        fuheQuery();
    }
}
/**
 * 简单查询操作
 * @param 无参数
 * @return 无返回值
 */
function fuheQuery()
{
    var params = '';
    var rightgroup = $('#rightgroup').val();
    var sql = '';
    var sqlpage = '';
    if (rightgroup == 10)
    {
        //权限组：管理员
        params += '&key=1';
        params += '&value=1';
        sql += 'logManager.fuhequerybywhere';
        sqlpage += 'logManager.fuhequerybywherepage';
    }
    else if (rightgroup == 3)
    {
        //营业班长
        params += '&str=' + getYytIP('<%=request.getSession().getAttribute("chargearea") %>');
        sql += 'logManager.fuhequeryareabywhere';
        sqlpage += 'logManager.fuhequeryareabywherepage';
    }
    else
    {
        //其他
        params += '&key=userid';
        params += '&value=<%=request.getSession().getAttribute("userid") %>';
        sql += 'logManager.fuhequerybywhere';
        sqlpage += 'logManager.fuhequerybywherepage';
    }
    fuheQueryLog(sql, sqlpage, params);
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
 * @return 无返回值
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
                if (realvalue != undefined) {
                    realvalue = $(this).attr(code);
                    //是否已接收          
                }
            });
        }
    });
    return realvalue;
}
/**
 * 阅读日志
 * @param 无参数
 * @return 无返回值
 */
function readLog()
{
    var thelogid = $('#thelogid').val();
    if (thelogid != '' && thelogid != null) {
        autoBlockForm('loginfos', 60, 'closelog', "#ffffff", false);
        //弹出查询面板  
    }
    else
    {
        alert('<fmt:message key="log.selectlog"/>!', '<fmt:message key="global.operationtips"/>');
    }
}
/**
 * 拼接要显示的数据列
 * @param tablename(表名)
 * @return 数组
 */
function displayFields(tablename)
{
    var thearr = new Array();
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'roleManager.gettheeditfields'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&tablename=' + tablename, datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var thefieldname = $(this).attr("field_name") ;
                var thefieldalias = getCaption($(this).attr("field_alias"), '<%=languageType %>', '');
                if (thefieldalias != '')
                {
                    var disvalue = thefieldname + ' as ' + tsd.encodeURIComponent(thefieldalias);
                    thearr.push(disvalue);
                }
            });
        }
    });
    return thearr;
}
/**
 * 数据导出
 * @param ds(数据源)
 * @param tsdcf(指向配置文件名称)
 * @param cols(显示的列)
 * @param table(表名)
 * @return 无返回值
 */
 function thisDataDownload(ds,tsdcf,cols,table,flagsql,table2) {
						var params = fuheQbuildParams();
						if(params=='&fusearchsql='){
							params +='1=1';
						}
						
						// $('#status').show();//显示LOADING…						 
						var exporttype = $('#thelistform [name="exporttype"][checked=true]:radio').val();	
						var querycountp='&table='+table+params;					
						var resvalue = querytablecount(querycountp);
						if(exporttype=='xls'&&parseInt(resvalue,10)>65535){
							//alert("Excel数据导出超过系统最大值为65535条，无法执行导出操作！");
							alert("<fmt:message key='logManager.ExcelDataDerivedMax' />");
							return false;
						}else if(exporttype=='dbf'&&parseInt(resvalue,10)>100000){
							//alert("dbf数据导出超过系统最大值十万条，无法执行导出操作！");
							alert("<fmt:message key='logManager.dbfDataDerivedMax' />");
							return false;
						}else if(exporttype=='xmlx'&&parseInt(resvalue,10)>200000){
							//alert("xml数据导出超过系统最大值二十万条，无法执行导出操作！");
							alert("<fmt:message key='logManager.xmlDataDerivedMax' />");
							return false;
						}else if(exporttype=='txt'&&parseInt(resvalue,10)>500000){
							//alert("txt数据掏出超过系统最大值50万条，无法执行导出操作！");
							alert("<fmt:message key='logManager.txtDataDerivedMax' />");
							return false;
						}				
						
						
						params += '&tablealias='+table2;
						
						if(cols!=''&&cols!=null&&cols!=undefined){
							params += '&cols='+cols;
						}else{
							//alert('请选择导出字段!');
							alert("<fmt:message key='logManager.checkDerivedfield' />");
							return false;
						} 
						if(table!=''&&table!=null&&table!=undefined){
							params += '&table='+table;
						}else{
							//alert('请选择导出字段!');
							alert("<fmt:message key='logManager.checkDerivedfield' />");
							return false;
						}				
					    
					    params += '&exportflag=0';	
					    var rightgroup = $('#rightgroup').val();
					    var sql = '';
					    if (rightgroup == 10) {
					        sql += 'main.Export';
					    }
					    else if (rightgroup == 3)
					    {
					        //营业班长
					        params += '&str=' + getYytIP('<%=request.getSession().getAttribute("chargearea") %>');
					        sql += 'main.arealogexport';
					    }
					    else
					    {
					        //其他
					        params += '&userid=<%=request.getSession().getAttribute("userid") %>';
					        sql += 'main.useridlogexport';
					    }
					    
					 	var urlstr=tsd.buildParams({packgname:'service',//java包
													clsname:'ExecuteSql',//类名
													method:'exeSqlData',//方法名
													ds:ds,//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
													tsdcf:tsdcf,//指向配置文件名称
													tsdoper:'query',//操作类型
													datatype:exporttype,//返回数据格式 
													tsdpk:sql //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
													});													
						if($("#download").size()==0)
							$("body").append("<iframe id='download' name='download' width='0' height='0'></iframe>");							
					    $("#download").attr("src","mainServlet.html?"+urlstr + params);				    	
}

/**
 * 取营业区域的IP
 * @param yyt(改变地址)
 * @return 数组
 */
function getYytIP(yyt)
{
    var thearr = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'logManager.gettheyytip'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&chargearea=' + tsd.encodeURIComponent(yyt), datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var ip = $(this).attr("ip");
                thearr += "'" + ip + "',";
            });
            thearr = thearr.substring(0, thearr.lastIndexOf(','));
        }
    });
    return thearr;
}
/**
 * 弹出简单查询面板
 * @param 无参数
 * @return 无返回值
 */
function openQueryLog()
{
    clearText('querylogforms');
    var nowtime = getDate();
    nowtime = nowtime.substring(0, 10);
    $('#querylogtime').val(nowtime);
    $('#whichorder').val(0);
    //简单查询
    autoBlockForm('querylogform', 60, 'queryclose', "#ffffff", true);
    //弹出面板
}
/**
 * 执行查询
 * @param 无参数
 * @return 无返回值(执行成功)/false(IP不合法)
 */
function queryLog()
{
    var logtime = $('#querylogtime').val();
    var userid = $('#queryuserid').val();
    var modulename = $('#querymodel').val();
    var logtype = $('#querylogtype').val();
    var ipaddress = $('#querylogip').val();
    if (ipaddress != '')
    {
        if (isIP(ipaddress) == false) {
            //alert('您输入的IP不合法，请确认后再重新输入!');
            alert("<fmt:message key='logManager.ipIllegalAndInputAgain' />");
            $('#querylogip').focus();
            return false;
        }
    }
    var params = '';
    params += '&logtime=' + logtime;
    params += '&userid=' + tsd.encodeURIComponent(userid);
    params += '&modulename=' + tsd.encodeURIComponent(modulename);
    params += '&logtype=' + tsd.encodeURIComponent(logtype);
    params += '&ipaddress=' + tsd.encodeURIComponent(ipaddress);
    var expparams = ' 1=1 ';
    if (logtime != '') {
        expparams += " and convert(char(10),logtime,20) like '%" + logtime + "%'";
    }
    if (userid != '') {
        expparams += " and userid='" + userid + "'";
    }
    if (modulename != '') {
        expparams += " and modulename='" + modulename + "'";
    }
    if (logtype != '') {
        expparams += " and logtype='" + logtype + "'";
    }
    if (ipaddress != '') {
        expparams += " and ipaddress='" + ipaddress + "'";
    }
    $('#fusearchsql').val(expparams);
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        datatype : 'xml', //返回数据格式 
        ds : 'tsdLog', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        tsdpk : 'logManager.queryjd', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'logManager.querypagejd'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
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
 * 重写保存模板的方法
 * @param 无参数
 * @return 无返回值
 */
function opensaveQ()
{
    //获取查询树信息
    var fusearchsql = $("#fusearchsql").val();
    var treepid = $("#treepid").val();
    if (treepid == '' || fusearchsql == '&fusearchsql=') {
    	//alert('请先用高级查询，再保存。');
        alert("<fmt:message key='logManager.SeniorInquiresAndSave' />");
        return;
    }
    var addinfo = $("#addinfo").val();
    //tsd.setTitle($("#input-Unit .title h3"),addinfo);  
    clearText('addquery');
    hideError();
    //隐藏错误信息 
    autoBlockForm('modT', 60, 'closeModB', "#ffffff", false);
    //弹出查询面板
    //autoBlockFormAndSetWH('addquery',60,60,'Qclose',"#ffffff",false,730,'');//弹出查询面板
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
//组合排序

/**
 * 组合排序
 * @param sqlstr(需要组合排序的列)
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
        sql = 'logManager.queryjd';
        pagesql = 'logManager.querypagejd';
    }
    else if (flag == 1 || flag == 2)
    {
        params = fuheQbuildParams();
        if (params == '&fusearchsql=') {
            params += '1=1';
        }
        var column = $("#thecolumn").val();
        params = params + '&orderby=' + sqlstr + '&column=' + column;
        params += '&orderkey=lid';
        params += '&ordertablename=sys_log';
        sql = 'main.queryByOrder';
        pagesql = 'main.queryByOrderpage';
    }
    //此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)     
    var urlstr1 = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdLog', //数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
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
/**
 * 获取系统时间
 * @param 无参数
 * @return String
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
 * 打印报表
 * @param 无参数
 * @return 无返回值
 */
function printReport()
{
    var params = $("#fusearchsql").val();
    if (params == '') {
        params = '1=1';
    }
    printThisReport1('<%=request.getParameter("imenuid")%>','sys_log','&fusearchsql=' + encodeURIComponent(cjkEncode($.trim(params))),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');
}			
</script>
			
<style type="text/css">
.titlemargin{margin-left:90px !important;margin-left:45px;}
.spanstyle{display:-moz-inline-box; display:inline-block; width:115px}
</style>
	</head>

	<body>
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
		<!-- 用户操作标题以及放一些快捷按钮-->
		<div id="buttons">
			<button type="button" onclick="openQueryLog()">
				<fmt:message key="global.query" />
			</button>
			<button type="button" id="query1" disabled="disabled"
				onclick="openDiaQueryG('query','sys_log')">
				<!-- 高级查询 -->
				<fmt:message key="logManager.SeniorInquires" />
			</button>
			<button id='gjquery1' onclick='openQueryM(1);' >
				<fmt:message key="oper.mod"/>
			</button>
			
			<button id='savequery1' onclick="opensaveQ();" disabled="disabled">
				<fmt:message key="oper.modSave"/>
			</button> 
			<button type="button" id="openadd1"
				onclick="thisDownLoad('tsdBilling','mssql','sys_log','<%=languageType %>',6)"
				disabled="disabled">
				<!--导出-->
				<fmt:message key="global.exportdata" />
			</button>
			<button type="button" id="opendel1"
				onclick="openDiaQueryG('delete','sys_log')" disabled="disabled">
				<!--批量删除-->
				<fmt:message key="tariff.deleteb" />
			</button>
				<button type="button" id="print1" onclick="printReport()" disabled="disabled">
				<!--打印报表-->
				<fmt:message key="global.print" />
			</button>
			<button type="button" id="log1" onclick="readLog()">
				<!--查看日志详细信息-->
				<fmt:message key="log.readlog"/>
			</button>
		</div>
		<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>
		<div id="buttons">
			<button type="button" onclick="openQueryLog()">
				<fmt:message key="global.query" />
			</button>
			<button type="button" id="query2" disabled="disabled"
				onclick="openDiaQueryG('query','sys_log')">
				<!-- 高级查询 -->
				<fmt:message key="logManager.SeniorInquires" />
			</button>
			<button id='gjquery2' onclick='openQueryM(1);' >
				<fmt:message key="oper.mod"/>
			</button>
			
			<button id='savequery2' onclick="opensaveQ();" disabled="disabled">
				<fmt:message key="oper.modSave"/>
			</button> 
			<button type="button" id="openadd2"
				onclick="thisDownLoad('tsdBilling','mssql','sys_log','<%=languageType %>',6)"
				disabled="disabled">
				<!--导出-->
				<fmt:message key="global.exportdata" />
			</button>
			<button type="button" id="opendel2"
				onclick="openDiaQueryG('delete','sys_log')" disabled="disabled">
				<!--批量删除-->
				<fmt:message key="tariff.deleteb" />
			</button>
				<button type="button" id="print2" onclick="printReport()" disabled="disabled">
				<!--打印报表-->
				<fmt:message key="global.print" />
			</button>
			<button type="button" id="log2" onclick="readLog()">
				<!--查看日志详细信息-->
				<fmt:message key="log.readlog"/>
			</button>
		</div>

				<div style="display: none">
					<input type="hidden" id="imenuid" value="<%=imenuid%>" />
					<input type="hidden" id="zid" value="<%=zid%>" />
					<%
						if (!languageType.equals("en")) {
							languageType = "zh";
						}
					%>

					<input type="hidden" id="languageType" value="<%=languageType%>" />

					<input type="hidden" id="addright" />
					<input type="hidden" id="deleteright" />
					<input type="hidden" id="delBright" />
					<input type="hidden" id="printright" />

					<input type="hidden" id="userid" value="<%=userid%>" />

					<%@page import="com.tsd.service.util.Log"%>
					<input type='hidden' id='userloginip'
						value='<%=Log.getIpAddr(request)%>' />
					<input type='hidden' id='userloginid'
						value='<%=session.getAttribute("userid")%>' />
					<input type='hidden' id='thislogtime'
						value='<%=Log.getThisTime()%>' />
					<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 	  
					
					<input type="hidden" id="thecolumn" />
					<input type="hidden" id="thelogid" />
					
					<input type="hidden" id="rightgroup" />
					
					<input type="hidden" id="operationtips"
					value="<fmt:message key="global.operationtips"/>" />
				<input type="hidden" id="successful"
					value="<fmt:message key="global.successful"/>" />
				<input type="hidden" id="deleteinformation"
					value="<fmt:message key="global.deleteinformation"/>" />
				</div>
			
			<!-- 显示日志信息面板 -->
			<div class="neirong" id="loginfos" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02">
									<img src="style/images/public/neibut01.gif" />
								</div>
								<div class="top_03" id="titlediv">
									<!-- 日志详细信息 -->
									<fmt:message key="logManager.InformationDetailed" />
								</div>
								<div class="top_04">
									<img src="style/images/public/neibut03.gif" />
								</div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#closelog').click();">
							<!-- 关闭 -->
							<fmt:message key="logManager.close" />
							</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd" >
					   <form action="#" name="logform"
							id="logform" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="labelclass">
									<label id="logtime"></label>
								</td>
								<td class="tdstyle" width="150px">
									<label id="logtimevalue"></label>
								</td>
								<td class="labelclass">
									<label id="logtype"></label>
								</td>
								<td class="tdstyle">
									<label id="logtypevalue"></label>
								</td>
								
								<td class="labelclass">
									<label id="logmodel"></label>
								</td>
								<td class="tdstyle">
									<label id="logmodelvalue"></label>
								</td>
							</tr>
							
							<tr>
								<td class="labelclass">
									<label id="loguserid"></label>
								</td>
								<td class="tdstyle">
									<label id="loguseridvalue"></label>
								</td>
								<td class="labelclass">
									<label id="logip"></label>
								</td>
								<td class="tdstyle">
									<label id="logipvalue"></label>
								</td>
								
								<td class="labelclass">
									
								</td>
								<td class="tdstyle">
									
								</td>
							</tr>
							<tr>
								<td class="dflabelclass">
									<label id="logmemo" style="width: 90px"></label>
								</td>
								<td colspan="5"  style="max-height: 200px">
									<label id="logmemovalue"></label>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="button" class="tsdbutton" id="closelog" onclick="thisWillDisplsy()">
						<fmt:message key="global.close" />
					</button>
				</div>
		</div>
			
			<div class="neirong" id="thefieldsform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02">
									<img src="style/images/public/neibut01.gif" />
								</div>
								<div class="top_03" id="titlediv">
									<!-- 选择您要导出的数据字段 -->
									<fmt:message key="logManager.chooseData" />
								</div>
								<div class="top_04">
									<img src="style/images/public/neibut03.gif" />
								</div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();">
							<!-- 关闭 -->
							<fmt:message key="logManager.close" /></a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd" >
					   <form action="#" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<div id="thelistform" style="margin-left: 10px;max-height: 200px">
								
									</div>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" id="query" onclick="checkedAllFields()">
						<!-- 全选 -->
						<fmt:message key="logManager.checkAll" />
					</button>
					<button type="submit" class="tsdbutton" id="query" onclick="getTheCheckedFields('tsdLog','mssql','sys_log')">
						<fmt:message key="global.ok" />
					</button>
					<button type="button" class="tsdbutton" id="closethisinfo" >
						<fmt:message key="global.close" />
					</button>
					
				</div>
			</div>	
			
			
			<!-- 简单查询面板 -->
		<div class="neirong" id="querylogform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02">
									<img src="style/images/public/neibut01.gif" />
								</div>
								<div class="top_03" id="titlediv">
									<!-- 查询 -->
									<fmt:message key="logManager.query" />
								</div>
								<div class="top_04">
									<img src="style/images/public/neibut03.gif" />
								</div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#queryclose').click();">
							<!-- 关闭 -->
							<fmt:message key="logManager.close" />
							</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd" >
					   <form action="#" name="querylogforms"
							id="querylogforms" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>	
								<td class="labelclass">
									<label id="suserid"></label>
								</td>
								<td class="tdstyle">
									<input type="text" id="queryuserid" style="width:150px" class="textclass"/>
								</td>
								<td class="labelclass">
									<label id="slogtime"></label>
								</td>
								<td class="tdstyle">
									<input type="text" id="querylogtime" class="textclass" onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})" style="width:150px"/>
								</td>
								<td class="labelclass">
									<label id="smodel"></label>
								</td>
								<td class="tdstyle">
									<input type="text" id="querymodel" style="width:150px" class="textclass" />
								</td>
							</tr>
							<tr>	
								<td class="dflabelclass">
									<label id="slogtype"></label>
								</td>
								<td>
									<input type="text" id="querylogtype" class="textclass" style="width:150px"/>
								</td>
								
								<td class="dflabelclass">
									<label id="slogip"></label>
								</td>
								<td>
									<input type="text" id="querylogip" style="width:150px" class="textclass"/>
								</td>
								<td class="dflabelclass">
								</td>
								<td>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" onclick="queryLog()">
						<fmt:message key="global.query" />
					</button>
					<button type="button" class="tsdbutton" id="queryclose" style="margin-left: 10px">
						<fmt:message key="global.close" />
					</button>
				</div>
		</div>
		
		<!-- 添加模板面板 -->
		<div id="modT" name='modT' style="display: none"  class="neirong" style="width:800px">
			<br/>
			<div class="top">
			<div class="top_01">
					<div class="top_01left">
						<div class="top_02">
								<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
								<!-- 查询模板保存 -->
								<fmt:message key="logManager.InquiresTheTemplateSave" />
						</div>
						<div class="top_04">
								<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right"><a href="#" onclick="closeoMod()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
				</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
			</div>
				<div class="midd" >
				<form id='addquery' name="addquery" onsubmit="return false;" action="#" >
					<input type="hidden" ></input>
					<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
					  	<tr>
						    <td align="right" class="dflabelclass"><label id="nameg_mod"><fmt:message key="oper.modName"/></label></td>							
						    <td width="200px" align="left">
						    	<input type="text" name="name_mod" id="name_mod" onkeyup="this.value=replaceStrsql(this.value,80)" class="textclass" />
						    	<font style="color: #ff0000;">*</font></td>
						    
						    <td align="right"  class="dflabelclass"><label id=''></label></td>
						    <td width="150px" align="left"></td>
							
						    <td align="right"  class="dflabelclass"></td>
					    	<td width="150px" align="left"></td>
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
		
		<input type="hidden" id="logkey" />
		<input type="hidden" id="logvalue" />
		<input type="hidden" id="yybzread" />
	</body>
</html>
