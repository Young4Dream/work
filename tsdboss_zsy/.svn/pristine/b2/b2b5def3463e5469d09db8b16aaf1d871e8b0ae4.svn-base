<%----------------------------------------
	name: ipManager.jsp
	author: chenliang
	version: 1.0, 2009-11-26
	description: 对IP数据的一个管理
	modify: 
		2009-11-26 chenliang  添加功能注释.
      	2009-12-02 chenliang  添加日志和国际化信息.
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
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
		<title>IPManage</title>
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
		
		<!-- 验证框架需要导入的js文件 -->
		<script src="plug-in/jquery/validate/jquery.validate.js" type="text/javascript"></script>
	
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
        tsdpname : 'ipManager.getPower', //存储过程的映射名称
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
    var editright = '';
    var editfields = '';
    var exportright = '';
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
        editright = 'true';
        exportright = 'true';
        queryright = 'true';
        saveQueryMright = 'true';
        isReadonly(false);
        document.getElementById('ip').disabled = true;
        flag = true;
    }
    else if (spower != '' && spower != 'all@')
    {
        var spowerarr = spower.split('@');
        for (var i = 0; i < spowerarr.length - 1; i++)
        {
            addright += getCaption(spowerarr[i], 'add', '') + '|';
            deleteright += getCaption(spowerarr[i], 'delete', '') + '|';
            editright += getCaption(spowerarr[i], 'edit', '') + '|';
            editfields += getCaption(spowerarr[i], 'editfields', '');
            exportright += getCaption(spower, 'export', '') + '|';
            queryright += getCaption(spowerarr[i], 'query', '') + '|';
            saveQueryMright += getCaption(spowerarr[i], 'saveQueryM', '') + '|';
        }
    }
    var hasadd = addright.split('|');
    var hasdelete = deleteright.split('|');
    var hasedit = editright.split('|');
    var hasexport = editright.split('|');
    var hasquery = queryright.split('|');
    var hassaveQueryM = saveQueryMright.split('|');
    var str = 'true';
    if (flag == true)
    {
        $("#addright").val(addright);
        $("#deleteright").val(deleteright);
        $("#editright").val(editright);
        $("#exportright").val(editright);
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
        for (var i = 0; i < hasedit.length; i++) {
            if (hasedit[i] == 'true') {
                $("#editright").val(str);
                break;
            }
        }
        for (var i = 0; i < hasexport.length; i++) {
            if (hasedit[i] == 'true') {
                $("#exportright").val(str);
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
/**
 * 在进行删除操作时，查看当前ip是否已被使用
 * @param ip(ip号)
 * @return boolean
 */
function isUsedIP(ip)
{
    var flag = false;
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'ipManager.isusedip'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var canloginip = $(this).attr("canloginip");
                var iparr = canloginip.split('~');
                for (var i = 0; i < iparr.length; i++) {
                    if (strtrim(iparr[i]) == ip) {
                        flag = true;
                        break;
                    }
                }
            });
        }
    });
    return flag;
}
/**
 * 页面初始化时加载系统区域，供用户进行选择
 * @param area(地区)
 * @param tablename(表名)
 * @param str
 * @return 无返回值
 */
function getArea(area, tablename, str, othersql)
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
        tsdpk : 'ipManager.getArea'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&area=' + area + '&tablename=' + tablename + '&other=' + othersql, datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            var selectarea = $("#selectarea").val();
            var thearea = '';
            if (area == 'Ywarea') {
                thearea = 'sarea' + str;
            }
            else if (area == 'area') {
                thearea = 'chargearea' + str;
            }
            $("#" + thearea).html("<option value=''>" + selectarea + "</option>");
            var thisarea = '';
            if($(xml).find('row:first').attr("xuhao")=="undefined") return;
            $(xml).find('row').each(function ()
            {
                thisarea += "<option value='" + $(this).attr(area.toLowerCase()) + "' xuhao='" + $(this).attr("xuhao") + "'>" + $(this).attr(area.toLowerCase()) + "</option>";
            });
            $("#" + thearea).html($("#" + thearea).html() + thisarea);
        }
    });
}

function ywareaChange(cid)
{
	var xuhao = $("#" + cid + " option:selected").attr("xuhao");
	if(xuhao=="" || xuhao==undefined)
		xuhao=-1;
	if(cid=="sarea")
		getArea('area', 'Asys_Area', '', 'ywareaid=' + xuhao);
	else if(cid=="sareabatch")
		getArea('area', 'Asys_Area', 'batch', 'ywareaid=' + xuhao);
}
/**************************************
                存储过程操作示例
/**
 * 初始化页面
 * @param 无参数
 * @return 无返回值
 */
jQuery(document).ready(function () 
{
    /**************************
            **   取得当前导航菜单名称    *
            ************************/
    $("#navBar1").append(genNavv());
    /**********************
            **   取得当前菜单名称    *
            **********************/
    var management = $("#management").val();
    $("#titlee").html(management);
    /**********************
            **   取得系统可选用区域  *
            **********************/
    //getArea('area', 'Asys_Area', '', '1!=1');
    //getArea('area', 'Asys_Area', 'batch', '1!=1');
    getArea('Ywarea', 'Area_Ywsl', '', '1=1');
    getArea('Ywarea', 'Area_Ywsl', 'batch', '1=1');
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
    var exportright = $("#exportright").val();
    if (exportright == "true")
    {
        document.getElementById("exp1").disabled = false;
        document.getElementById("exp2").disabled = false;
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
        tsdpk : 'ipManager.query', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'ipManager.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    var column = '';
    var thisdata = loadData('sys_ipaddr', '<%=languageType%>', 1, '<fmt:message key="ipManager.modifyAndDelete"/>');
    column = thisdata.FieldName.join(',');
    var disip = thisdata.getFieldAliasByFieldName('ip');
    var dissarea = thisdata.getFieldAliasByFieldName('sarea');
    var dischargearea = thisdata.getFieldAliasByFieldName('chargearea');
    var dismemo = thisdata.getFieldAliasByFieldName('memo');
    $("#qxid").html(disip);
    $("#qxname").html(dissarea);
    $("#qchargearea").html(dischargearea);
    $("#sqxid").html(disip);
    $("#sqxname").html(dissarea);
    $("#schargearea").html(dischargearea);
    $("#qxmemo").html(dismemo);
    $("#sqxnames").html(dissarea);
    $("#sqchargearea").html(dischargearea);
    $("#sqxmemo").html(dismemo);
    $('#thecolumn').val(column);
    thisdata.setWidth({
        Operation : 80
    });
    jQuery("#editgrid").jqGrid(
    {
        url : 'mainServlet.html?' + urlstr + '&cloumn=' + column, datatype : 'xml', colNames : thisdata.colNames, 
        colModel : thisdata.colModels, rowNum : 15, //默认分页行数
        rowList : [10, 15, 20], //可选分页行数
        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images/', pager : jQuery('#pagered'), sortname : 'ip', //默认排序字段
        viewrecords : true, //hidegrid: false, 
        sortorder : 'asc', //默认排序方式 
        caption : management, 
        height: document.documentElement.clientHeight - 182,
        //width: document.documentElement.clientWidth - 42,
        loadComplete : function ()
        {
            $("#editgrid").setSelection('0', true);
            $("#editgrid").focus();
            ///自动适应 工作空间
            // var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
            //setAutoGridHeight("editgrid",reduceHeight);
            /*********定义需要的行链接按钮************
                                        ////@1  表格的id
                                        ////@2  链接名称
                                        ////@3  链接地址或者函数名称
                                        ////@4  行主键列的名称 可以是隐藏列
                                        ////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
                                        ////@6  按钮的位置，，，不允许重复，不允许跳跃， 范围：1+    */
            var editinfo = $("#editinfo").val();
            var deleteinfo = $("#deleteinfo").val();
            addRowOperBtn('editgrid', '<img src="style/images/public/ltubiao_01.gif" alt="'+'<fmt:message key="ipManager.modify" />'+'"/>', 'openRowModify', 
            'ip', 'click', 1);
            addRowOperBtn('editgrid', '<img src="style/images/public/ltubiao_02.gif" alt="'+'<fmt:message key="ipManager.delete" />'+'"/>', 'deleteRow', 
            'ip','click', 2);
            /****执行行按钮添加********
                                        *@1 表格ID
                                        *@2 操作按钮数量 等于定义数量
                                        *依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
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
});
/*********************************
                **             添加信息            **
                ***********************************/
/**
 * 弹出添加面板
 * @param 无参数
 * @return 无返回值
 */
function openText()
{ 
    var addinfo = $("#addinfo").val();
    isReadonly(false) ;
    //tsd.setTitle($("#input-Unit .title h3"),addinfo);
    $(".top_03").html(addinfo);
    $('#titlediv').html(addinfo);
    $("#saveadd").show();
    $("#saveexit").show();
    autoBlockForm('add', 60, 'close', "#ffffff", false);
    //弹出查询面板
    $("#modify").hide();
    clearText('operform');
    hideError();
    //隐藏错误信息 
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
    var groupid = $("#ip").val();
    var groupname = $("#sarea").val();
    var chargearea = $("#chargearea").val();
    var memo = $("#memo").val();
    //对IP还得进一步进行判断
    if (groupid != null && groupid != "")
    {
        //如果有可能值是汉字 请使用tsd.encodeURIComponent()函数转码
        if (isIP(groupid)) {
            params += "&ip=" + tsd.encodeURIComponent(groupid);
        }
        else
        {
            //alert("请输入正确格式的 IP 地址。");
            alert("<fmt:message key='ipManager.inputIP' />");
            $("#ip").select().focus();
            return false;
        }
    }
    else
    {
        var operationtips = $("#operationtips").val();
        var inputip = $("#inputip").val();
        alert(inputip, operationtips);
        $("#ip").focus();
        return false;
    }
    if (groupname != "") {
        params += "&sarea=" + tsd.encodeURIComponent(groupname);
    }
    else
    {
        //alert("请选择IP所属业务区域。");
        alert("<fmt:message key='ipManager.IPAddressAreaChoose' />");
        $("#sarea").focus();
        return false;
    }
    if (chargearea != "") {
        params += "&chargearea=" + tsd.encodeURIComponent(chargearea);
    }
    else
    {
        //alert("请选择IP所属营业区域。");
        alert("<fmt:message key='ipManager.IPAddressBusinessAreaChoose' />");
        $("#chargearea").focus();
        return false;
    }
    params += "&memo=" + tsd.encodeURIComponent(memo);
    var thestate = $('#thestate').val();
    var theloginfo = '';
    var thetype = '';
    var thefieldalias = fetchFieldAlias('sys_ipaddr', '<%=languageType%>');
    if (thestate == 0)
    {
        //添加权限组信息,记录日志
        thetype = 'add';
        theloginfo = "(sys_ipaddr)" + tsd.encodeURIComponent("<fmt:message key='global.add'/>") + tsd.encodeURIComponent("IP：");
        theloginfo += tsd.encodeURIComponent(thefieldalias['ip']) + ':' + tsd.encodeURIComponent(groupid) + ',';
        theloginfo += tsd.encodeURIComponent(thefieldalias['sarea']) + ':' + tsd.encodeURIComponent(groupname) + ',';
        theloginfo += tsd.encodeURIComponent(thefieldalias['chargearea']) + ':' + tsd.encodeURIComponent(chargearea) + ',';
        if (memo != '' && null != memo)
        {
            theloginfo += tsd.encodeURIComponent(thefieldalias['memo']) + ':' + tsd.encodeURIComponent(memo);
        }
    }
    else if (thestate == 1)
    {
        //修改权限组信息,记录日志
        thetype = 'modify';
        theloginfo = "(sys_ipaddr)" + tsd.encodeURIComponent("<fmt:message key='global.edit'/>") + groupid + tsd.encodeURIComponent("IP") + tsd.encodeURIComponent("<fmt:message key='usermanager.info'/>.");
        var thearr = getIpInfo(groupid, 0);
        if (thearr['sarea'] != groupname)
        {
            theloginfo += tsd.encodeURIComponent(thefieldalias['sarea']) + ':' + tsd.encodeURIComponent(thearr['sarea']) + '>>>' + tsd.encodeURIComponent(groupname) + ';';
        }
        if (thearr['chargearea'] != chargearea)
        {
            theloginfo += tsd.encodeURIComponent(thefieldalias['chargearea']) + ':' + tsd.encodeURIComponent(thearr['chargearea']) + '>>>' + tsd.encodeURIComponent(chargearea) + ';';
        }
        if (thearr['memo'] != memo)
        {
            theloginfo += tsd.encodeURIComponent(thefieldalias['memo']) + ':' + tsd.encodeURIComponent(thearr['memo']) + '>>>' + tsd.encodeURIComponent(memo) + ';';
        }
    }
    writeLogInfo('', thetype, theloginfo);
    //每次拼接参数必须添加此判断
    if (tsd.Qualified() == false) {
        return false;
    }
    return params;
}
/**
 * 拼参数
 * @param ip(ip地址)
 * @param type(类型)
 * @return 数组
 */
function getIpInfo(ip, type)
{
    var arr = new Array();
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'ipManager.queryByKey' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&ip=' + ip, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var ip = $(this).attr("ip");
                var sarea = $(this).attr("sarea");
                var chargearea = $(this).attr("chargearea");
                var memo = $(this).attr("memo");
                //在做修改时需要进行判断的值参数
                arr['ip'] = ip;
                arr['sarea'] = sarea;
                arr['chargearea'] = chargearea;
                arr['memo'] = memo;
                if (type == 1)
                {
                    var theuserinfo = fetchFieldAlias('sys_ipaddr', '<%=languageType%>');
                    var delinfo = '';
                    delinfo += tsd.encodeURIComponent(theuserinfo['ip']) + ':' + tsd.encodeURIComponent(ip) + ';' ;
                    delinfo += tsd.encodeURIComponent(theuserinfo['sarea']) + ':' + tsd.encodeURIComponent(sarea) + ';' ;
                    delinfo += tsd.encodeURIComponent(theuserinfo['chargearea']) + ':' + tsd.encodeURIComponent(chargearea) + ';' ;
                    delinfo += tsd.encodeURIComponent(theuserinfo['memo']) + ':' + tsd.encodeURIComponent(memo) + ';' ;
                    $('#thedelinfo').val(delinfo);
                }
            });
        }
    });
    return arr;
}
/**
 * 添加完成，进行数据交互即保存
 * @param thesave(保存类型：1.保存添加；2.保存退出)
 * @return 数组
 */
function saveInfo(thesave)
{
    /****************************************
                    *   是否是可输入ID，查看数据库中是否存在此id  *
                    ****************************************/
    var groupid = $("#ip").val();
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'ipManager.querygroupid'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            var flag = false;
            $(xml).find('row').each(function ()
            {
                var gid = $(this).attr("ip");
                if (gid == groupid)
                {
                    var operationtips = $("#operationtips").val();
                    var worninfo = $("#worninfo").val();
                    alert(worninfo, operationtips);
                    flag = true;
                }
            });
            if (flag == false)
            {
                $('#thestate').val(0);
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
                    tsdpk : 'ipManager.save'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
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
                            var operationtips = $("#operationtips").val();
                            var successful = $("#successful").val();
                            alert(successful, operationtips);
                            if (thesave == 1) {
                                clearText('operform');
                                $('#ip').focus();
                            }
                            else if (thesave == 2) {
                                setTimeout($.unblockUI, 15);
                                reloadData();
                            }
                        }
                    }
                });
            }
        }
    });
}
/**
 * 重新加载
 * @param 无参数
 * @return 无返回值
 */
function thisReload()
{
    reloadData();
}

/**
 * 删除信息
 * @param key(唯一标识)
 * @return 无返回值(删除成功)/false(数据库中无此条记录)
 */
function deleteRow(key)
{
    var deleteright = $("#deleteright").val();
    /**************************
                     *    是否有执行删除的权限    *
                     *************************/
    if (deleteright == "true")
    {
        var deleteinformation = $("#deleteinformation").val();
        var operationtips = $("#operationtips").val();
        if (confirm('<fmt:message key="global.deleteinformation"/>'))
        {
            /******************
                                 *  IP是否已被使用  *  
                                *****************/
            if (isUsedIP(key) == false)
            {
                var urlstr = tsd.buildParams(
                {
                    packgname : 'service', //java包
                    clsname : 'ExecuteSql', //类名
                    method : 'exeSqlData', //方法名
                    ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
                    tsdcf : 'mssql', //指向配置文件名称
                    tsdoper : 'exe', //操作类型 
                    tsdpk : 'ipManager.delete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
                });
                getIpInfo(key, 1);
                var thedelinfo = $('#thedelinfo').val();
                writeLogInfo('', 'delete', tsd.encodeURIComponent("<fmt:message key='global.delete'/>") + tsd.encodeURIComponent("IP：") + key + tsd.encodeURIComponent("<fmt:message key='usermanager.info'/>：") + thedelinfo);
                $.ajax(
                {
                    url : 'mainServlet.html?' + urlstr + '&ip=' + key, cache : false, //如果值变化可能性比较大 一定要将缓存设成false
                    timeout : 1000, async : false , //同步方式
                    success : function (msg)
                    {
                        if (msg == "true")
                        {
                            var operationtips = $("#operationtips").val();
                            var successful = $("#successful").val();
                            alert(successful, operationtips);
                            setTimeout($.unblockUI, 15);
                            reloadData();
                        }
                    }
                });
            }
            else
            {
                var operationtips = $("#operationtips").val();
                var deletefailed = $("#deletefailed").val();
                alert(deletefailed, operationtips);
            }
        }
    }
    else
    {
        var operationtips = $("#operationtips").val();
        var deletepower = $("#deletepower").val();
        alert(deletepower, operationtips);
    }
}
/**
 * 预修改信息
 * @param key(唯一标识)
 * @return 无返回值
 */
function openRowModify(key)
{
    var editright = $("#editright").val();
    if (editright == "true")
    {
        document.getElementById('ip').disabled = true;
        var editinfo = $("#editinfo").val();
        //tsd.setTitle($("#input-Unit .title h3"),editinfo);
        $(".top_03").html(editinfo);
        $('#titlediv').html(editinfo);
        $("#modify").show();
        $("#saveadd").hide();
        $("#saveexit").hide();
        hideError();
        //隐藏错误信息 
        clearText('operform');
        $("#ip").val(key);
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
            tsdpk : 'ipManager.queryByKey' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax(
        {
            url : 'mainServlet.html?' + urlstr + '&ip=' + key, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout : 1000, async : false , //同步方式
            success : function (xml)
            {
                $(xml).find('row').each(function ()
                {
                    var groupname = $(this).attr("sarea");
                    var memo = $(this).attr("memo");
                    var chargearea = $(this).attr("chargearea");
                    
                    $("#sarea").val(groupname).trigger("change");
                    
                    $("#chargearea").val(chargearea);
                    $("#memo").val(memo);
                    var editfields = $("#editfields").val();
                    /*************************************
                                    **   将当前表的所有字段取出来，分割字符串 ***
                                    *************************************/
                    var fields = getFields('sys_ipaddr');
                    var fieldarr = fields.split(",");
                    /**********************************
                                    **   将当前表中的spower字段取出来 *****
                                    **********************************/
                    var spower = editfields.split(",");
                    if (spower.length > 0)
                    {
                        for (var i = 0; i < spower.length; i++)
                        {
                            for (var j = 0 ; j < fieldarr.length; j++)
                            {
                                if (fieldarr[j] == spower[i] && spower[i] != '') {
                                    document.getElementById(spower[i]).disabled = false;
                                    break;
                                }
                            }
                        }
                    }
                });
                autoBlockForm('add', 60, 'close', "#ffffff", false);
                //弹出面板
            }
        });
    }
    else
    {
        var operationtips = $("#operationtips").val();
        var editpower = $("#editpower").val();
        alert(editpower, operationtips);
    }
}
/**
 * 将修改后的信息保存起来
 * @param 无参数
 * @return 无返回值
 */
function modifyInfo()
{
    $('#thestate').val(1);
    var params = buildParams();
    if (params == false) {
        return false;
    }
    key = $("#ip").val();
    ///设置命令参数
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : 'ipManager.modify'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    urlstr += params;
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&ip=' + key, cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (msg)
        {
            if (msg == "true")
            {
                var operationtips = $("#operationtips").val();
                var successful = $("#successful").val();
                alert(successful, operationtips);
                /*************
                                    ** 释放资源 **
                                    ************/
                setTimeout($.unblockUI, 15);
                reloadData();
            }
        }
    });
}
/**
 * 重载信息代码块
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
        tsdpk : 'ipManager.query', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'ipManager.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    var column = $('#thecolumn').val();
    $("#editgrid").setGridParam({
        url : 'mainServlet.html?' + urlstr + '&cloumn=' + column
    }).trigger("reloadGrid");
    setTimeout($.unblockUI, 15);
    //关闭面板
}

/**
 * 在初始化页面的时候将面板加载进来 
 * @param 无参数
 * @return 无返回值
 */
$(document).ready(function ()
{
    //参数为你要验证的表单的id 
    myValidate("operform");
    $("#save").show();
    $("#modify").hide();
});
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
function fuheQuery()
{
    fuheDisQuery('ipManager.queryByWhere', 'ipManager.queryByWherepage');
}
/**
 * 查询重用代码块 
 * @param querysql(查询语句)
 * @param querypagesql(分页语句)
 * @return 无返回值
 */
function fuheDisQuery(querysql, querypagesql) 
{
    var params = fuheQbuildParams();
    if (params == '&fusearchsql=') {
        params += '1=1';
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
        tsdpk : querysql, //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : querypagesql 
    });
    var languageType = $('#languageType').val();
    var link = urlstr1 + params + '&lang=' + languageType;
    var column = $('#thecolumn').val();
    $("#editgrid").setGridParam({
        url : 'mainServlet.html?' + link + '&cloumn=' + column
    }).trigger("reloadGrid");
    setTimeout($.unblockUI, 15);
    //关闭面板   
}
/**
 * 将受限字段复原  
 * @param statu(状态)
 * @return 无返回值
 */
function isReadonly(status)
{
    var fields = getFields('sys_ipaddr');
    var fieldarr = fields.split(",");
    for (var j = 0 ; j < fieldarr.length - 1; j++) {
        document.getElementById(fieldarr[j]).disabled = status;
    }
}
/**
 * 弹出简单查询面板
 * @param 无参数
 * @return 无返回值
 */
function openQueryIP()
{
    clearText('queryipforms');
    $('#whichorder').val(0);
    //简单查询
    autoBlockForm('queryipform', 60, 'queryclose', "#ffffff", false);
    //弹出面板
}
/**
 * 执行查询
 * @param 无参数
 * @return 无返回值(操作成功)/false(IP不合法)
 */
function queryIP()
{
    var ip = $('#queryip').val();
    var chargearea = $('#querychargearea').val();
    var sarea = $('#querysarea').val();
    if (ip != '')
    {
        if (isIP(ip) == false) {
            //alert('您输入的IP不合法，请确认后再重新输入!');
            alert("<fmt:message key='ipManager.ipIllegalAndInputAgain' />");
            $('#queryip').focus();
            return false;
        }
    }
    var params = '';
    params += '&ip=' + ip;
    params += '&chargearea=' + tsd.encodeURIComponent(chargearea);
    params += '&sarea=' + tsd.encodeURIComponent(sarea);
    var expparams = ' 1=1 ';
    if (ip != '') {
        expparams += " and ip='" + ip + "'";
    }
    if (chargearea != '') {
        expparams += " and chargearea='" + chargearea + "'";
    }
    if (sarea != '') {
        expparams += " and sarea='" + sarea + "'";
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
        tsdpk : 'ipManager.queryjd', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'ipManager.querypagejd'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
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
        alert("<fmt:message key='ipManager.UseSeniorInquires' />");
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
/**
 * 组合排序 
 * @param sqlstr(组合排序语句)
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
        sql = 'ipManager.queryjd';
        pagesql = 'ipManager.querypagejd';
    }
    else if (flag == 1 || flag == 2)
    {
        params = fuheQbuildParams();
        if (params == '&fusearchsql=') {
            params += '1=1';
        }
        var column = $("#thecolumn").val();
        params = params + '&orderby=' + sqlstr + '&column=' + column;
        params += '&orderkey=ip';
        params += '&ordertablename=sys_ipaddr';
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
/**
 * 拼接要显示的数据列 
 * @param tablename(表名)
 * @return String
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
                var thefieldname = $(this).attr("Field_Name".toLowerCase()) ;
                var thefieldalias = getCaption($(this).attr("Field_Alias".toLowerCase()), '<%=languageType%>', '');
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
 * 弹出添加面板 
 * @param 无参数
 * @return 无返回值
 */
function openBatchText()
{
    clearText('batchaddform');
    autoBlockForm('batchadd', 60, 'close', "#ffffff", false);
    //弹出查询面板
}
/**
 * 批量添加IP
 * @param 无参数
 * @return 无返回值
 */
function batchAddIP()
{
    var params = '';
    var fixval = $('#fixval').val();
    if (fixval == '') {
        //alert('固定值不允许为空,请输入固定值!');
        alert("<fmt:message key='ipManager.FixedValueNotNull' />");
        $('#fixval').focus();
        return false;
    }
    var disip = fixval + '.1';
    if (isIP(disip) == false) {
        //alert('对不起,您输入的固定值不合法,请重新输入!');
        alert("<fmt:message key='ipManager.FixedValueIllegal' />");
        $('#fixval').focus();
        return false;
    }
    var staval = $.trim($('#staval').val());
    var endval = $.trim($('#endval').val());
    //alert(staval + " - " + endval);
    if (staval == '') {
        //alert('请输入IP起始值!');
        alert("<fmt:message key='ipManager.inputIPStartingValue' />");
        $('#staval').focus();
        return false;
    }
    if (endval == '') {
        //alert('请输入IP结束值!');
        alert("<fmt:message key='ipManager.inputIPEndValue' />");
        $('#endval').focus();
        return false;
    }
    staval = parseInt(staval,10);
    endval = parseInt(endval,10);
    if(isNaN(staval))
    {
    	//alert("请输入有效的IP起始值");
    	alert("<fmt:message key='ipManager.inputEffectiveIPStartingValue' />");
    	$('#staval').val('');
        $('#staval').focus();
        return false;
    }
    if(isNaN(endval))
    {
    	//alert("请输入有效的IP结束值");
    	alert("<fmt:message key='ipManager.inputEffectiveIPEndValue' />");
    	$('#endval').val('');
        $('#endval').focus();
        return false;
    }
    if (staval == 0) {
        //alert('对不起,输入起始值不能为0!');
        alert("<fmt:message key='ipManager.theStartingValueNot0' />");
        $('#staval').val('');
        $('#staval').focus();
        return false;
    }
    if (staval >= endval) {
        //alert('对不起,输入起始值必须小于结束值!');
        alert("<fmt:message key='ipManager.StartingValueLessThanEndValue' />");
        $('#staval').focus();
        return false;
    }
    if (endval > 255) {
        //alert('输入有误,IP最大为255!');
        alert("<fmt:message key='ipManager.inputErrorAndIPValueLessThan255' />");
        $('#endval').val(255);
        $('#endval').focus();
        return false;
    }
    var sareabatch = $('#sareabatch').val();
    if (sareabatch == '') {
        //alert('请选择IP所属业务区域!');
        alert("<fmt:message key='ipManager.ipAreaChoose' />");
        $('#sareabatch').focus();
        return false;
    }
    var chargeareabatch = $('#chargeareabatch').val();
    if (chargeareabatch == '') {
        //alert('请选择IP所属营业区域!');
		alert("<fmt:message key='ipManager.ipBusinessAreaChoose' />");
        $('#chargeareabatch').focus();
        return false;
    }
    var memo_batch = $('#memo_batch').val();
    params += '&fixval=' + fixval;
    params += '&staval=' + staval;
    params += '&endval=' + endval;
    params += '&ywarea=' + tsd.encodeURIComponent(sareabatch);
    params += '&chargearea=' + tsd.encodeURIComponent(chargeareabatch);
    params += '&memo=' + tsd.encodeURIComponent(memo_batch);
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', clsname : 'Procedure', method : 'exequery', ds : 'tsdBilling', //数据源名称 对应的spring配置的数据源
        tsdpname : 'ipManager.ip_batchadd', //存储过程的映射名称
        tsdExeType : 'query', datatype : 'xmlattr' 
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + params , datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var　distips = $(this).attr("res");
                if (distips != 0) {
                    //alert('成功添加[' + distips + ']个IP!');
                    //alert("<fmt:message key='ipManager.addSuccess' />" + distips + "<fmt:message key='ipManager.IPSome' />");
                	var successful = $("#successful").val();
                	alert(successful);
                }
                setTimeout($.unblockUI, 15);
                reloadData();
            });
        }
    });
}			
</script>
<style type="text/css">
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
									key="gjh.houtuei" /> </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
		<!-- 用户操作标题以及放一些快捷按钮-->
		<div id="buttons">
			<button type="button" id="order1" onclick="openDiaO('sys_ipaddr');">
				<!-- 组合排序 -->
				<fmt:message key="tariff.order" />
			</button>
			<button type="button" id="openadd1" onclick="openText()"
				disabled="disabled">
				<fmt:message key="global.add" />
			</button>
			<button type="button" id="openaddbatch" onclick="openBatchText()">
			<!-- 批量添加IP -->
			<fmt:message key="ipManager.addBatchIp" />	
			</button>
			<button type="button" onclick="openQueryIP()">
				<fmt:message key="global.query" />
			</button>
			<button type="button" id="query1" disabled="disabled"
				onclick="openDiaQueryG('query','sys_ipaddr')">
				<!-- 高级查询 -->
				<fmt:message key="ipManager.SeniorInquires" />
			</button>
			<button id='gjquery1' onclick='openQueryM(1);'>
				<fmt:message key="oper.mod" />
			</button>

			<button id='savequery1' onclick="opensaveQ();" disabled="disabled">
				<fmt:message key="oper.modSave" />
			</button>
			<button type="button" id="exp1"
				onclick="thisDownLoad('tsdBilling','mssql','sys_ipaddr','<%=languageType%>',6)"
				disabled="disabled">
				<fmt:message key="global.exportdata" />
			</button>
		</div>
		<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>
		<div id="buttons">
			<!-- 这里的按钮可以自由更换 但格式要对 -->
			<button type="button" id="order2" onclick="openDiaO('sys_ipaddr');">
				<!-- 组合排序 -->
				<fmt:message key="tariff.order" />
			</button>
			<button type="button" id="openadd2" onclick="openText()"
				disabled="disabled">
				<fmt:message key="global.add" />
			</button>
			<button type="button" onclick="openBatchText()">
			<!-- 批量添加IP -->
			<fmt:message key="ipManager.addBatchIp" />	
			</button>
			<button type="button" onclick="openQueryIP()">
				<fmt:message key="global.query" />
			</button>
			<button type="button" id="query2" disabled="disabled"
				onclick="openDiaQueryG('query','sys_ipaddr')">
				<!-- 高级查询 -->
				<fmt:message key="ipManager.SeniorInquires" />
			</button>
			<button id='gjquery2' onclick='openQueryM(1);'>
				<fmt:message key="oper.mod" />
			</button>

			<button id='savequery2' onclick="opensaveQ();" disabled="disabled">
				<fmt:message key="oper.modSave" />
			</button>
			<button type="button" id="exp2"
				onclick="thisDownLoad('tsdBilling','mssql','sys_ipaddr','<%=languageType%>',6)"
				disabled="disabled">
				<fmt:message key="global.exportdata" />
			</button>
		</div>

		<!-- 添加 -->
		<div class="neirong" id="add" style="display: none; width: 600px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<!-- 添加 -->
							<fmt:message key="ipManager.add" />
							
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="clearText('operform');reloadData();">
							<!-- 关闭 -->
							<fmt:message key="ipManager.close" />
						</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form action="#" name="operform" id="operform"
					onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td class="labelclass">
								<label for="qxid" id="qxid"></label>
							</td>
							<td class="tdstyle">
								<input type="text" name="ip" id="ip" class="textclass"
									style="width: 150px" disabled="disabled" />
								<font style="color: red;">*</font>
							</td>
							<td class="labelclass">
								<label for="qxname" id="qxname"></label>
							</td>
							<td class="tdstyle">
								<select id="sarea" class="textclass" style="width: 150px"
									disabled="disabled" onchange="ywareaChange('sarea')"></select>
								<font style="color: red; margin-left: 10px">*</font>
							</td>
						</tr>

						<tr>
							<td class="dflabelclass">
								<span id="qchargearea"></span>
							</td>
							<td>
								<select id="chargearea" class="textclass" style="width: 150px"
									disabled="disabled">
									<option value="">
									<!-- 请选择 -->
									<fmt:message key="ipManager.choose" />
									</option>
								</select>
								<font style="color: red; margin-left: 5px">*</font>
							</td>
							<td class="dflabelclass">
								<label for="qxmemo" style="width: 90px">
									<span id="qxmemo"></span>
								</label>
							</td>
							<td>
								<input type="text" name="memo" id="memo" style="width: 150px"
									class="textclass" disabled="disabled" />
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" style="width: 80px"
					id="saveadd" onclick="saveInfo(1)">
					<!-- 保存添加 -->
					<fmt:message key="ipManager.saveAndAdd" />
				</button>
				<button type="submit" class="tsdbutton" style="width: 80px"
					id="saveexit" onclick="saveInfo(2)" style="margin-left: 10px">
					<!-- 保存退出 -->
					<fmt:message key="ipManager.saveAndclose" />
				</button>
				<button type="submit" class="tsdbutton" id="modify"
					onclick="modifyInfo();">
					<fmt:message key="global.edit" />
				</button>
				<button type="button" class="tsdbutton" id="close"
					style="margin-left: 10px"
					onclick="clearText('operform');reloadData();">
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>

		<div
			style="position: absolute; z-index: -1; left: -8px; top: 0; width: 232px;">
			<iframe
				style="width: 100%; filter: alpha(opacity = 0); -moz-opacity: 0"></iframe>
		</div>

		<div style="display: none">
			<%
				if (!languageType.equals("en")) {
					languageType = "zh";
				}
			%>

			<input type="hidden" id="languageType" value="<%=languageType%>" />

			<input type="hidden" id="addinfo"
				value="<fmt:message key="global.add"/>" />
			<input type="hidden" id="deleteinfo"
				value="<fmt:message key="global.delete"/>" />
			<input type="hidden" id="editinfo"
				value="<fmt:message key="global.edit"/>" />
			<input type="hidden" id="queryinfo"
				value="<fmt:message key="global.query"/>" />

			<input type="hidden" id="operation"
				value="<fmt:message key="global.operation"/>" />
			<input type="hidden" id="operationtips"
				value="<fmt:message key="global.operationtips"/>" />
			<input type="hidden" id="successful"
				value="<fmt:message key="global.successful"/>" />
			<input type="hidden" id="deleteinformation"
				value="<fmt:message key="global.deleteinformation"/>" />
			<input type="hidden" id="management"
				value="<fmt:message key="ip.management"/>" />
			<input type="hidden" id="worninfo"
				value="<fmt:message key="ip.worn"/>" />
			<input type="hidden" id="worntips"
				value="<fmt:message key="ip.worntips"/>" />
			<input type="hidden" id="deletepower"
				value="<fmt:message key="global.deleteright"/>" />
			<input type="hidden" id="editpower"
				value="<fmt:message key="global.editright"/>" />
			<input type="hidden" id="deletefailed"
				value="<fmt:message key="ip.deletefailed"/>" />
			<input type="hidden" id="selectarea"
				value="<fmt:message key="ip.select"/>" />
			<input type="hidden" id="inputip"
				value="<fmt:message key="ip.inputip"/>" />
			<input type="hidden" id="selectarea"
				value="<fmt:message key="ip.selectarea"/>" />
			<input type="hidden" id="addmemo"
				value="<fmt:message key="ip.addmemo"/>" />
			<input type="hidden" id="ipvalid"
				value="<fmt:message key="ip.valid"/>" />


			<input type="hidden" id="addright" />
			<input type="hidden" id="batchaddipright" />

			<input type="hidden" id="deleteright" />
			<input type="hidden" id="editright" />
			<input type="hidden" id="exportright" />

			<input type="hidden" id="editfields" />

			<input type="hidden" id="thecolumn" />
			<input type="hidden" id="thedelinfo" />
			<input type="hidden" id="thestate" />
			<input type="hidden" id="userid" value="<%=userid%>" />
			<input type="hidden" id="imenuid" value="<%=imenuid%>" />
			<input type="hidden" id="zid" value="<%=zid%>" />
			<input type='hidden' id='userloginip'
				value='<%=Log.getIpAddr(request)%>' />
			<input type='hidden' id='userloginid'
				value='<%=session.getAttribute("userid")%>' />
			<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
		</div>

		<!-- 简单查询面板 -->
		<div class="neirong" id="queryipform"
			style="display: none; width: 800px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<!-- 查询 -->
							<fmt:message key="ipManager.query" />
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#queryclose').click();">
						<!-- 关闭 -->
						<fmt:message key="ipManager.close" />
						</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form action="#" name="queryipforms" id="queryipforms"
					onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td class="dflabelclass">
								<label id="sqxid"></label>
							</td>
							<td>
								<input type="text" id="queryip" class="textclass"
									style="width: 150px" />
							</td>

							<td class="dflabelclass">
								<label id="sqxname"></label>
							</td>
							<td>
								<input type="text" id="querysarea" style="width: 150px"
									class="textclass" />
							</td>
							<td class="dflabelclass">
								<label id="schargearea"></label>
							</td>
							<td>
								<input type="text" id="querychargearea" style="width: 150px"
									class="textclass" />
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" onclick="queryIP()">
					<fmt:message key="global.query" />
				</button>
				<button type="button" class="tsdbutton" id="queryclose"
					style="margin-left: 10px">
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>

		<!-- 添加模板面板 -->
		<div id="modT" name='modT' style="display: none" class="neirong"
			style="width:800px">
			<br />
			<div class="top">
				<div class="top_01">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<!-- 查询模板保存 -->
							<fmt:message key="ipManager.InquiresTheTemplateSave" />
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="closeoMod()"><span
							style="margin-left: 5px;"><fmt:message key="global.close" />
						</span>
						</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form id='addquery' name="addquery" onsubmit="return false;"
					action="#">
					<input type="hidden"></input>
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0" style="line-height: 33px; font-size: 12px;">
						<tr>
							<td align="right" class="dflabelclass">
								<label id="nameg_mod">
									<fmt:message key="oper.modName" />
								</label>
							</td>
							<td width="200px" align="left">
								<input type="text" name="name_mod" id="name_mod"
									onkeyup="this.value=replaceStrsql(this.value,80)"
									class="textclass" />
								<font style="color: #ff0000;">*</font>
							</td>

							<td align="right" class="dflabelclass">
								<label id=''></label>
							</td>
							<td width="150px" align="left"></td>

							<td align="right" class="dflabelclass"></td>
							<td width="150px" align="left"></td>
						</tr>
					</table>
				</form>
				<div class="midd_butt">
					<!-- 保存 -->
					<button class="tsdbutton" id="saveModB"
						style="width: 80px; heigth: 27px;" onclick="saveModQuery(1);">
						<fmt:message key="global.save" />
					</button>
					<!-- 关闭 -->
					<button class="tsdbutton" id="closeModB"
						style="width: 63px; heigth: 27px;" onclick="closeoMod();">
						<fmt:message key="global.close" />
					</button>
				</div>
			</div>
		</div>
		<!-- 查询树信息存放 -->
		<input type="hidden" id='treepid' />
		<input type="hidden" id='treecid' />
		<input type="hidden" id='treestr' />
		<input type="hidden" id='treepic' />

		<!-- 高级查询 模板隐藏域 -->
		<input type="hidden" id="queryright" />
		<input type="hidden" id="saveQueryMright" />

		<input type="hidden" id="jdparams" />
		<input type="hidden" id="whichorder" value="2" />

		<!-- 导出数据 -->
		<div class="neirong" id="thefieldsform"
			style="display: none; width: 800px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<!-- 选择您要导出的数据字段 -->
							<fmt:message key="ipManager.chooseData" />
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#closethisinfo').click();">
						<!-- 关闭 --><fmt:message key="ipManager.close" />
						</a>
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
							<td>
								<div id="thelistform"
									style="margin-left: 10px; max-height: 200px">

								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" id="query"
					onclick="checkedAllFields()">
					<!-- 全选 --><fmt:message key="ipManager.checkAll" />
				</button>
				<button type="submit" class="tsdbutton" id="query"
					onclick="getTheCheckedFields('tsdBilling','mssql','sys_ipaddr')">
					<fmt:message key="global.ok" />
				</button>
				<button type="button" class="tsdbutton" id="closethisinfo">
					<fmt:message key="global.close" />
				</button>

			</div>
		</div>

		<!-- 批量生成IP -->
		<div class="neirong" id="batchadd" style="display: none; width: 600px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<!-- 批量生成 --><fmt:message key="ipManager.ipMassProduction" />
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="clearText('batchaddform');reloadData();"><fmt:message key="ipManager.close" /></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form action="#" name="batchaddform" id="batchaddform"
					onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td class="labelclass">
								<label for="qxid">
									<!-- 固定值 --><fmt:message key="ipManager.FixedValue" />
								</label>
							</td>
							<td class="tdstyle">
								<input type="text" name="fixval" id="fixval" maxlength="11"
									class="textclass" style="width: 150px" />
								<font style="color: red;">*</font>
							</td>
							<td class="labelclass">
								<label for="qxname">
								<!-- 起始值 --><fmt:message key="ipManager.StatrValue" />
								</label>
							</td>
							<td class="tdstyle">
								<input type="text" name="staval" id="staval" value="1"
									maxlength="3" onkeyup="value=value.replace(/[^\d]/g,'')"
									class="textclass" style="width: 150px" />
								<font style="color: red; margin-left: 10px">*</font>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label>
									<!-- 结束值 --><fmt:message key="ipManager.EndValue" />
								</label>
							</td>
							<td class="tdstyle">
								<input type="text" name="endval" id="endval" maxlength="3"
									onkeyup="value=value.replace(/[^\d]/g,'')" class="textclass"
									style="width: 150px" />
								<font style="color: red;">*</font>
							</td>
							<td class="labelclass">
								<label for="qxname" id="sqxnames"></label>
							</td>
							<td class="tdstyle">
								<select id="sareabatch" class="textclass" style="width: 150px" onchange="ywareaChange('sareabatch')"></select>
								<font style="color: red; margin-left: 15px">*</font>
							</td>
						</tr>

						<tr>
							<td class="labelclass">
								<span id="sqchargearea"></span>
							</td>
							<td class="tdstyle">
								<select id="chargeareabatch" class="textclass"
									style="width: 150px">
									<option value=""><!-- 请选择 --><fmt:message key="ipManager.choose" /></option>
								</select>
								<font style="color: red; margin-left: 5px">*</font>
							</td>
							<td class="labelclass">
								<label for="sqxmemo" style="width: 90px">
									<span id="sqxmemo"></span>
								</label>
							</td>
							<td class="tdstyle">
								<input type="text" name="memo" id="memo_batch"
									style="width: 150px" class="textclass" />
							</td>
						</tr>
						<tr>
							<td class="dflabelclass">
								<!-- 说明 --><fmt:message key="ipManager.explain" />
							</td>
							<td colspan="3" style="color: red">
							<!-- 固定值格式：xxx.xxx.xxx 例如：100.80.20 IP范围：1~255. -->&nbsp;<fmt:message key="ipManager.FixedValueFormat" />
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" onclick="batchAddIP()">
					<fmt:message key="global.ok" />
				</button>
				<button type="button" class="tsdbutton" id="close"
					style="margin-left: 10px"
					onclick="clearText('batchaddform');reloadData();">
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>

		<input type="hidden" id="useridd" value="<%=userid%>" />

	</body>
</html>
