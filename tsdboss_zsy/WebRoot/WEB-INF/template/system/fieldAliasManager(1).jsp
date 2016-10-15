<%----------------------------------------
	name: fieldAliasdManager.jsp
	author: chenliang
	version: 1.0, 2009-11-26
	description: 对字段别名的一个管理
	modify: 
		2009-11-26 chenliang  添加功能注释. 
      	2009-12-03 chenliang  添加日志和国际化信息
     	2010-01-08 chenliang IE6和IE7样式兼容
     	2010-09-25 chenliang oracle数据库
     	2010-12-17 liwen      1.导出时表别名，字段别名国际化处理；2. 表字段信息排序报错问题 ； 
---------------------------------------------%>
<%@page import="com.tsd.service.util.Log"%><%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
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
<%	request.setCharacterEncoding("utf-8");
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");

	String imenuname = request.getParameter("imenuname");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>字段别名管理</title>
		<meta http-equiv="cache-control" content="no-cache"/>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		
				
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
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<!-- 该页面js脚本 -->
		<script src="script/system/fieldAliasManager.js" type="text/javascript" language="javascript"></script>
		
<script type="text/javascript">
/**
 * 初始化
 * @param 无参数
 * @return 无返回值
 */
$(function ()
{
    $("#operform").draggable({
        handle : "#thisdrags"
    });
});
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
        tsdpname : 'fieldAliasManager.getPower', //存储过程的映射名称
        tsdExeType : 'query', datatype : 'xmlattr' 
    });
    /************************
                *   调用存储过程需要的参数 *
                **********************/
    var userid = $('#userid').val();
    var groupid = $('#zid').val();
    var imenuid = $('#imenuid').val();
    /****************
     *   拼接权限参数 
    **************/
    var addright = '';
    var deleteright = '';
    var editright = '';
    var exportright = '';
    var queryright = '';
    var editotherright = '';
    var createfieldright = '';
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
   
    if (spower == 'all@')
    {
        addright = 'true';
        deleteright = 'true';
        editright = 'true';
        editotherright = 'true';
        exportright = 'true';
        queryright = 'true';
        createfieldright = 'true';
        editfields = getI18n('en', 'rb_table');
        //editfields = getFields('rb_table');
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
            editotherright += getCaption(spowerarr[i], 'editother', '') + '|';
            createfieldright += getCaption(spowerarr[i], 'createfieldright', '') + '|';
            editfields += getCaption(spowerarr[i], 'editfields', '');
            exportright += getCaption(spower, 'export', '') + '|';
            queryright += getCaption(spower, 'query', '') + '|';
        }
    }
    var hasadd = addright.split('|');
    var hasdelete = deleteright.split('|');
    var hasedit = editright.split('|');
    var haseditother = editotherright.split('|');
    var hascreatefield = createfieldright.split('|');
    var hasexport = editright.split('|');
    var hasquery = queryright.split('|');
    var str = 'true';
    if (flag == true)
    {
        $("#addright").val(addright);
        $("#deleteright").val(deleteright);
        $("#editright").val(editright);
        $("#editotherright").val(editotherright);
        $("#createfieldright").val(createfieldright);
        $("#exportright").val(editright);
        $("#queryright").val(queryright);
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
        for (var i = 0; i < haseditother.length; i++) {
            if (haseditother[i] == 'true') {
                $("#editotherright").val(str);
                break;
            }
        }
        for (var i = 0; i < hascreatefield.length; i++) {
            if (hascreatefield[i] == 'true') {
                $("#createfieldright").val(str);
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
    }
    $("#editfields").val(editfields);
}
/**
 * 初始化数据
 * @param 无参数
 * @return 无返回值
 */
jQuery(document).ready(function () 
{
    thisShowOrder();
    $("#navBar1").append(genNavv());
    //加载页面导航菜单
    getUserPower();
    //加载页面是初始化判断当前用户权限
    var addright = $("#addright").val();
    if (addright == "true")
    {
        document.getElementById("openadd1").disabled = false;
        //document.getElementById("openadd2").disabled=false;
        document.getElementById("openadd11").disabled = false;
    }
    var createfieldright = $("#createfieldright").val();
    if (createfieldright == "true")
    {
        document.getElementById("createfield1").disabled = false;
        //document.getElementById("createfield2").disabled=false;
        document.getElementById("createfield11").disabled = false;
    }
    var exportright = $("#exportright").val();
    if (exportright == "true")
    {
        document.getElementById("exp1").disabled = false;
        document.getElementById("exp2").disabled = false;
        document.getElementById("exp11").disabled = false;
        document.getElementById("exp21").disabled = false;
    }
    var queryright = $("#queryright").val();
    if (queryright == "true")
    {
        document.getElementById("query1").disabled = false;
        document.getElementById("query2").disabled = false;
        document.getElementById("query11").disabled = false;
        document.getElementById("query21").disabled = false;
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
        tsdpk : 'fieldAliasManager.query', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'fieldAliasManager.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    var opr = $("#operation").val();
    //加载数据列
    var thisdata = loadData('rb_table', '<%=languageType %>', 1);
    //var tablename = thisdata.getFieldAliasByFieldName('Table_Name');
    //var tablealias = thisdata.getFieldAliasByFieldName('Table_Alias');
    var tablename = '表名';
    var tablealias = '表别名';
    var tablezhalias = "<fmt:message key='fieldalias.tbzhalias' />";
    var tableenalias = "<fmt:message key='fieldalias.tbenalias' />";
    $("#tname").html(tablename);
    $("#tzhalias").html(tablezhalias);
    $("#tenalias").html(tableenalias);
    
   	/***********************************************************
	*@2010.12.17 liwen
	*对表别名和 字段别名国际化的处理
	*这个地方需要判断用的是什么数据库，EDB和ORACLE对INSTR函数处理方式不同
	************************************************************/
	$.ajax ( {
		url : 'mainServlet.html?packgname=service&clsname=DBService&method=service&operate=decideDBType&ds=tsdBilling',
		datatpe:'xml',     
		cache:false,
		timeout: 1000,
		async: false ,
		success:function(data){ 
			 if (data == 'enterprisedb')  {
				//theclos = theclos.replace('Table_Alias',"SUBSTR(Table_Alias,POSITION('<%=languageType %>' IN Table_Alias)*3-1,POSITION('/}' IN SUBSTR(Table_Alias,POSITION('<%=languageType %>' IN Table_Alias)))-POSITION('<%=languageType %>' IN Table_Alias)-2)");
			 	$('#thecolumn').val("Table_Name,SUBSTR(Table_Alias,POSITION('<%=languageType %>' IN Table_Alias)*3-1,POSITION('/}' IN SUBSTR(Table_Alias,POSITION('<%=languageType %>' IN Table_Alias)))-POSITION('<%=languageType %>' IN Table_Alias)-2) as table_alias");
			 } else {
				//theclos = theclos.replace('Table_Alias',"SUBSTR(Table_Alias,INSTR(Table_Alias,'<%=languageType %>')*3-1,INSTR(Table_Alias,'/}',INSTR(Table_Alias,'<%=languageType %>'))-INSTR(Table_Alias,'<%=languageType %>')-3) ");
			 	$('#thecolumn').val("Table_Name,SUBSTR(Table_Alias,INSTR(Table_Alias,'<%=languageType %>')*3-1,INSTR(Table_Alias,'/}',INSTR(Table_Alias,'<%=languageType %>'))-INSTR(Table_Alias,'<%=languageType %>')-3) as table_alias");
			 }
		}
	}) ;
    //$('#thecolumn').val("Table_Name,case instr(table_alias,'<%=languageType%>') when 0 then '' else substr(table_alias,instr(table_alias,'<%=languageType%>')" + tsd.encodeURIComponent('+') + "3,case when instr(table_alias,'/}',instr(table_alias,'<%=languageType%>'))-instr(table_alias,'<%=languageType%>')" + tsd.encodeURIComponent('-') + "3 <=0 then 0 else instr(table_alias,'/}',instr(table_alias,'<%=languageType%>'))-instr(table_alias,'<%=languageType%>')" + tsd.encodeURIComponent('-') + "3 end ) end as table_alias");
    
    var management = $('#imenuname').val();
    var ttalias = $('#ttalias').val();
    jQuery("#editgrid").jqGrid(
    {
        url : 'mainServlet.html?' + urlstr + '&languageType=' + $("#languageType").val(), datatype : 'xml', 
        colNames : ['修改|删除', tablename, tablealias], colModel : [ {
            name : 'viewOperation', index : 'viewOperation', width : 26
        },
        {
            name : 'table_name', index : 'table_name', width : 90
        },
        {
            name : 'table_alias', index : 'table_alias'
        }
        /***此处列对应着查询结果集字段，列数必须跟colNames列数对应***/
        //如果有操作列 请勿更改或者删除
        ], rowNum : 10, //默认分页行数
        rowList : [10, 15, 20], //可选分页行数
        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images/', pager : jQuery('#pagered'), sortname : 'table_name', 
        //默认排序字段
        viewrecords : true, //hidegrid: false, 
        //sortorder : 'asc', //默认排序方式 
        caption : ttalias, height : 220, //高
        width : document.documentElement.clientWidth - 32,
        loadComplete : function ()
        {
            $("#editgrid").setSelection('0', true);
            $("#editgrid").focus();
            ///自动适应 工作空间
            // var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
            //setAutoGridHeight("editgrid",200);
            var editinfo = $("#editinfo").val();
            var deleteinfo = $("#deleteinfo").val();
            addRowOperBtn('editgrid', '<img src="style/images/public/ltubiao_01.gif" alt="修改"/>', 'openRowModify', 
            'table_name', 'click', 1);
            addRowOperBtn('editgrid', '<img src="style/images/public/ltubiao_02.gif" alt="删除"/>', 'deleteRow', 'table_name', 
            'click', 2);
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
                var tablename = '';
                tablename = $("#editgrid").getCell(ids, "table_name");
                $("#table_name").val(tablename);
                tablename = tsd.encodeURIComponent(tablename);
                $("#editgrid_son").setGridParam(
                {
                    url : "mainServlet.html?" + urlstr_son + "&table_name=" + tablename + "&languageType=<%=languageType %>"
                }).trigger('reloadGrid');
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
    ////设置附表命令参数
    var urlstr_son = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xml', //返回数据格式 
        tsdpk : 'fieldAliasManager.querytable', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'fieldAliasManager.querytablepage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    //对附表进行国际化
    var thedata = loadData('Rb_Field', '<%=languageType %>', 1);
    var table_name = thedata.getFieldAliasByFieldName('Table_Name');
    var field_name = thedata.getFieldAliasByFieldName('Field_Name');
    var field_alias = thedata.getFieldAliasByFieldName('Field_Alias');
    var data_type = thedata.getFieldAliasByFieldName('DataType');
    var DataDict = thedata.getFieldAliasByFieldName('DataDict');
    //数据字典
    var WebSelectable = thedata.getFieldAliasByFieldName('WebSelectable');
    //是否显示
    var ShowOrder = thedata.getFieldAliasByFieldName('ShowOrder');
    //显示顺序
    var ShowWidth = thedata.getFieldAliasByFieldName('ShowWidth');
    //显示宽度
    var Selectable = thedata.getFieldAliasByFieldName('Selectable');
    //是否可查询
    var nOrderby = thedata.getFieldAliasByFieldName('nOrderby');
    //查询顺序
    $('#fieldname').html(field_name);
    $('#DataTypes').html(data_type);
    $('#DataDicts').html(DataDict);
    $('#WebSelectables').html(WebSelectable);
    $('#ShowOrders').html(ShowOrder);
    $('#ShowWidths').html(ShowWidth);
    $('#Selectables').html(Selectable);
    $('#nOrderbys').html(nOrderby);
    $('#fieldzhalias').html('<fmt:message key="fieldalias.fdzhalias" />');
    $('#fieldenalias').html('<fmt:message key="fieldalias.fdenalias" />');
    $('#fieldcolumn').val("table_name,field_name,case instr(field_alias,'<%=languageType %>') when 0 then '' else substr(field_alias,instr(field_alias,'<%=languageType %>')" + tsd.encodeURIComponent('+') + "3,case when instr(field_alias,'/}',instr(field_alias,'<%=languageType %>'))-instr(field_alias,'<%=languageType %>')" + tsd.encodeURIComponent('-') + "3 <=0 then 0 else instr(field_alias,'/}',instr(field_alias,'<%=languageType %>'))-instr(field_alias,'<%=languageType %>')" + tsd.encodeURIComponent('-') + "3 end ) end as field_alias,datatype,DataDict,WebSelectable,ShowOrder,ShowWidth,Searchable,nOrderby");
    var oppr = $("#operation").val();
    var ffalias = $('#ffalias').val();
    jQuery("#editgrid_son").jqGrid(
    {
        /*执行存储过程---------------- 
                tsdpname：可以调用其他存储过程，
                注意：tsdpname不是真正对应存储过程名称 而是通过系统进行映射，查看映射名请参照 存储过程维护页
                ds：对应applicationContent.xml里配置的数据源 
                */
        //url:'mainServlet.html?'+urlstr_son+"&table_name="+table_name,
        height : 220, //高
        datatype : 'xml', 
        colNames : ['修改', table_name, field_name, field_alias, data_type, DataDict, 
        WebSelectable, ShowOrder, ShowWidth, Selectable, nOrderby], 
        colModel : [ {
            name : 'viewOperation', index : 'viewOperation'
        },
        //如果有操作列 请勿更改或者删除
        {
            name : 'table_name', index : 'table_name'
        },
        {
            name : 'field_name', index : 'field_name'
        },
        {
            name : 'field_alias', index : 'field_alias'
        },
        {
            name : 'datatype', index : 'datatype'
        },
        {
            name : 'DataDict', index : 'DataDict'
        },
        {
            name : 'WebSelectable', index : 'WebSelectable'
        },
        {
            name : 'ShowOrder', index : 'ShowOrder'
        },
        {
            name : 'ShowWidth', index : 'ShowWidth'
        },
        {
            name : 'Searchable', index : 'Searchable'
        },
        {
            name : 'nOrderby', index : 'nOrderby'
        } ], rowNum : 10, //默认分页行数
        rowList : [10, 15, 20], //可选分页行数
        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images/', pager : jQuery('#pagered_son'), sortname : 'field_name', 
        //默认排序字段
        viewrecords : true, //hidegrid: false, 
        sortorder : 'asc', //默认排序方式 
        caption : ffalias, width : document.documentElement.clientWidth - 80,
        loadComplete : function ()
        {
            //查询后，默认选中第一条
            $("#editgrid_son").setSelection('0', true);
            $("#editgrid_son").focus();
            var editinfo = $("#editinfo").val();
            var deleteinfo = $("#deleteinfo").val();
            addRowOperBtn('editgrid_son', '<img src="style/images/public/ltubiao_01.gif" alt="修改"/>', 'openRowModify_son', 
            'field_name', 'click', 1, 'table_name');
            addRowOperBtn('editgrid_son', '', '', 'table_name', 'click', 2);
            executeAddBtn('editgrid_son', 2);
        }
    }).navGrid('#pagered_son', {
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
    //是否有执行删除的权限
    if (deleteright == "true")
    {
        var deleteinformation = $("#deleteinformation").val();
        var operationtips = $("#operationtips").val();
        if (confirm('<fmt:message key="global.deleteinformation"/>'))
        {
            /******************
                                 *  IP是否已被使用  *  
                                *****************/
            var urlstr = tsd.buildParams(
            {
                packgname : 'service', //java包
                clsname : 'ExecuteSql', //类名
                method : 'exeSqlData', //方法名
                ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
                tsdcf : 'mssql', //指向配置文件名称
                tsdoper : 'exe', //操作类型 
                tsdpk : 'fieldAliasManager.delete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
            });
            getAliasInfo('table_alias', 'rb_table', 'table_name', key, 1);
            var thedelinfo = $('#thedelinfo').val();
            writeLogInfo('', 'delete', tsd.encodeURIComponent("<fmt:message key='global.delete'/>") + tsd.encodeURIComponent("<fmt:message key='fieldalias.table' />：") + key + tsd.encodeURIComponent("<fmt:message key='usermanager.info'/>：") + thedelinfo);
            $.ajax(
            {
                url : 'mainServlet.html?' + urlstr + '&table_name=' + key, cache : false, //如果值变化可能性比较大 一定要将缓存设成false
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
                        reloadDataSon('tsdtemp');
                    }
                }
            });
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
 * 修改信息 
 * @param key(唯一标识)
 * @return 无返回值
 */
function openRowModify(key)
{
    var editright = $("#editright").val();
    if (editright == "true")
    {
        var editinfo = $("#editinfo").val();
        tsd.setTitle($("#input-Unit .title h3"), editinfo);
        $("#modify").show();
        $("#saveadd").hide();
        $("#saveexit").hide();
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
            tsdpk : 'fieldAliasManager.queryByKey' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax(
        {
            url : 'mainServlet.html?' + urlstr + '&table_name=' + key, datatype : 'xml', cache : false, 
            //如果值变化可能性比较大 一定要将缓存设成false
            timeout : 1000, async : false , //同步方式
            success : function (xml)
            {
                $(xml).find('row').each(function ()
                {
                    var talias = $(this).attr('table_alias');
                    var languageType = $("#languageType").val();
                    var tablezhalias = getCaption(talias, 'zh', '');
                    var tableenalias = getCaption(talias, 'en', '');
                    $('#tablename').val(key);
                    $('#tablezhalias').val(tablezhalias);
                    $('#tableenalias').val(tableenalias);
                    isReadOnly('tablename', true);
                });
                autoBlockForm('operform', 160, 'close', "#ffffff", false);
                //弹出查询面板
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
 * 拼参数 
 * @param 无参数
 * @return String
 */
function buildParams()
{
    var params = '';
    var zh = '{zh='; 
    var en = '{en=';
    var str = '/}';
    var tablename = $('#tablename').val();
    var tablezhalias = $('#tablezhalias').val();
    var tableenalias = $('#tableenalias').val();
    var tablealias = zh + tsd.encodeURIComponent(tablezhalias) + str + en + tsd.encodeURIComponent(tableenalias) + str;
    params += '&table_name=' + tablename;
    params += '&table_alias=' + tablealias;
    var thestate = $('#thestate').val();
    var theloginfo = '';
    var thetype = '';
    var thefieldalias = fetchFieldAlias('rb_table', '<%=languageType %>');
    if (thestate == 0)
    {
        //添加表别名信息,记录日志
        thetype = 'add';
        theloginfo = "(rb_table)" + tsd.encodeURIComponent("<fmt:message key='global.add'/>") + tsd.encodeURIComponent("<fmt:message key='fieldalias.table' />：");
        theloginfo += tsd.encodeURIComponent(thefieldalias['Table_Name']) + ':' + tsd.encodeURIComponent(tablename) + ',';
        if (tablezhalias != '' && null != tablezhalias)
        {
            theloginfo += tsd.encodeURIComponent("<fmt:message key='fieldalias.tbzhalias' />") + ':' + tsd.encodeURIComponent(tablezhalias) + ',';
        }
        if (tableenalias != '' && null != tableenalias)
        {
            theloginfo += tsd.encodeURIComponent("<fmt:message key='fieldalias.tbenalias' />") + ':' + tsd.encodeURIComponent(tableenalias);
        }
    }
    else if (thestate == 1)
    {
        //修改表别名信息,记录日志
        thetype = 'modify';
        theloginfo = "(rb_table)" + tsd.encodeURIComponent("<fmt:message key='global.edit'/>") + tablename + tsd.encodeURIComponent("<fmt:message key='fieldalias.tablealias' />") + tsd.encodeURIComponent("<fmt:message key='usermanager.info'/>.");
        //select 
        var thearr = getAliasInfo('table_alias', 'rb_table', 'table_name', tablename, 0);
        if (thearr['zhalias'] != tablezhalias)
        {
            theloginfo += tsd.encodeURIComponent("<fmt:message key='fieldalias.tbzhalias' />") + ':' + tsd.encodeURIComponent(thearr['zhalias']) + '>>>' + tsd.encodeURIComponent(tablezhalias) + ';';
        }
        if (thearr['enalias'] != tableenalias)
        {
            theloginfo += tsd.encodeURIComponent("<fmt:message key='fieldalias.tbenalias' />") + ':' + tsd.encodeURIComponent(thearr['enalias']) + '>>>' + tsd.encodeURIComponent(tableenalias) + ';';
        }
    }
    writeLogInfo('', thetype, theloginfo);
    return params;
}
/**
 * 去别名的函数 
 * @param thealias
 * @param tablename(表名)
 * @param fields(字段)
 * @param key
 * @param thetype
 * @return 数组
 */
function getAliasInfo(thealias, tablename, fields, key, thetype)
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
        tsdpk : 'fieldAliasManager.queryByTheKey' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&thealias=' + thealias + '&tablename=' + tablename + '&fields=' + fields + '&key=' + key, 
        datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var thealias = $(this).attr("alias");
                //在做修改时需要进行判断的值参数
                arr['zhalias'] = getCaption(thealias, 'zh', "<fmt:message key='fieldalias.noalias' />");
                arr['enalias'] = getCaption(thealias, 'en', "<fmt:message key='fieldalias.noalias' />");
                if (thetype == 1)
                {
                    var theinfo = fetchFieldAlias('rb_table', '<%=languageType %>');
                    var delinfo = '';
                    delinfo += tsd.encodeURIComponent(theinfo['Table_Name']) + ':' + tsd.encodeURIComponent(tablename) + ';' ;
                    delinfo += tsd.encodeURIComponent("<fmt:message key='fieldalias.tbzhalias' />") + ':' + tsd.encodeURIComponent(arr['zhalias']) + ';' ;
                    delinfo += tsd.encodeURIComponent("<fmt:message key='fieldalias.tbenalias' />") + ':' + tsd.encodeURIComponent(arr['enalias']) + ';' ;
                    $('#thedelinfo').val(delinfo);
                }
            });
        }
    });
    return arr;
}
/**
 * 将修改后的信息保存起来 
 * @param 无参数
 * @return 无返回值
 */
function modifyInfo()
{
    $('#thestate').val(1);
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : 'fieldAliasManager.modify'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    var params = buildParams();
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
                isReadOnly('tablename', false);
                setTimeout($.unblockUI, 15);
                reloadData();
                reloadDataSon('tsdtemp');
            }
        }
    });
}
/**
 * 显示可编辑的顺序
 * @param 无参数
 * @return 无返回值
 */
function thisShowOrder()
{
    var thisorder = '';
    for (var i = 0 ; i < 100; i++) {
        thisorder += '<option value="' + i + '">' + i + '</option>';
    }
    $('#ShowOrder').html(thisorder);
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
        tsdpk : 'fieldAliasManager.query', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'fieldAliasManager.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    var languageType = $("#languageType").val();
    $("#editgrid").setGridParam({
        url : 'mainServlet.html?' + urlstr + '&languageType=' + languageType
    }).trigger("reloadGrid");
}
/**
 * 存在字段别名表信息 
 * @param tsdtemp(临时参数-随机数)
 * @return 无返回值
 */
function reloadDataSon(tsdtemp)
{
    var urlstr_son = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xml', //返回数据格式 
        tsdpk : 'fieldAliasManager.querytable', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'fieldAliasManager.querytablepage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    var languageType = $("#languageType").val();
    $("#editgrid_son").setGridParam(
    {
        url : "mainServlet.html?" + urlstr_son + "&table_name=" + tsdtemp + "&languageType=" + languageType
    }).trigger('reloadGrid');
}
/**
 * 修改信息 
 * @param key
 * @param key2
 * @return 无返回值
 */
function openRowModify_son(key, key2)
{
    var editright = $("#editotherright").val();
    if (editright == "true")
    {
        var editinfo = $("#editinfo").val();
        tsd.setTitle($("#input-Unit .title h3"), editinfo);
        $("#modify_son").show();
        $('#fhname').val(key);
        $('#thname').val(key2);
        $('#fname').val(key);
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
            tsdpk : 'fieldAliasManager.queryfieldByKey' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax(
        {
            url : 'mainServlet.html?' + urlstr + '&field_name=' + key + '&table_name=' + key2, datatype : 'xml', 
            cache : false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout : 1000, async : false , //同步方式
            success : function (xml)
            {
                $(xml).find('row').each(function ()
                {
                    var fieldalias = $(this).attr('field_alias');
                    var DataType = $(this).attr('DataType'.toLowerCase());
                    if (DataType == 'null') {
                        DataType = '';
                    }
                    var DataDict = $(this).attr('DataDict'.toLowerCase());
                    if (DataDict == 'null') {
                        DataDict = '';
                    }
                    var WebSelectable = $(this).attr('WebSelectable'.toLowerCase());
                    var ShowOrder = $(this).attr('ShowOrder'.toLowerCase());
                    var ShowWidth = $(this).attr('ShowWidth'.toLowerCase());
                    var Selectable = $(this).attr('Searchable'.toLowerCase());
                    
                    var field_length = $(this).attr('field_length');
                    var keytype = $(this).attr('keytype');
                    var selecttype = $(this).attr('selecttype');
                    var mulSelectOper = $(this).attr('mulselectoper');
                    var inputtype = $(this).attr('inputtype');
                    var isquery = $(this).attr('isquery');
                    
                    var iselectname = $(this).attr("selectname");
                    var irelatedfield = $(this).attr("related_field");
                    var iuniquegroup = $(this).attr("uniquegroup");
                    var ibsum = $(this).attr("bsum");
                    
                    if (Selectable == 'null') {
                        Selectable = '';
                    }
                    var nOrderby = $(this).attr('nOrderby'.toLowerCase());
                    if (nOrderby == 'null') {
                        nOrderby = '';
                    }
                    var zhstr = '';
                    var enstr = '';
                    if (fieldalias != '' && fieldalias != null) {
                        zhstr = getCaption(fieldalias, 'zh', '');
                        enstr = getCaption(fieldalias, 'en', '');
                    }
                    $('#fzhalias').val(zhstr);
                    $('#fenalias').val(enstr);
                    $('#DataType').val(DataType);
                    $('#DataDict').val(DataDict);
                    $('#WebSelectable').val(WebSelectable);
                    $('#ShowOrder').val(ShowOrder);
                    $('#ShowWidth').val(ShowWidth);
                    $('#Selectable').val(Selectable);
                    $('#nOrderby').val(nOrderby);
                    
                    $("#bSum").val(ibsum);
                    $('#field_length').val(field_length);
                    $('#keytype').val(keytype);
                    $('#selecttype').val(selecttype);
                    $('#mulSelectOper').val(mulSelectOper);
                    $('#inputtype').val(inputtype);
                    $('#isquery').val(isquery);
                    
                    $("#selectname").val(iselectname);
                    $("#related_field").val(irelatedfield);
                    $("#uniquegroup").val(iuniquegroup);
                    
                });
                //$('#DataDict').focus();
                autoBlockForm('operfieldform', 100, 'closethis', "#ffffff", false);
                //弹出查询面板
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
function modifyInfo_son()
{
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : 'fieldAliasManager.fieldmodify'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    var zh = '{zh=';
    var en = '{en=';
    var str = '/}';
    
    tsd.QualifiedVal=true;
    
    var tablename = $('#thname').val();
    var fzhalias = $('#fzhalias').val();
    var fenalias = $('#fenalias').val();
    //data_type,DataDict,WebSelectable,ShowOrder,ShowWidth,Selectable,nOrderby
    var DataType = $('#DataType').val();
    var DataDict = $('#DataDict').val();
    var WebSelectable = $('#WebSelectable').val();
    var ShowOrder = $('#ShowOrder').val();
    var ShowWidth = $('#ShowWidth').val();
    var Selectable = $('#Selectable').val();
    var nOrderby = $('#nOrderby').val();
    
    var field_length  = $('#field_length').val();
    var keytype = $('#keytype').val();
    var selecttype = $('#selecttype').val();
    var mulSelectOper = $('#mulSelectOper').val();
    
    var inputtype = $('#inputtype').val();
    var isquery  = $('#isquery').val();
    
    var bsumv = $("#bSum").val();
    
    var selectnamev  = $('#selectname').val();
    selectnamev = selectnamev.replace(new RegExp("'","g"),"''");
    var relatedfieldv  = $('#related_field').val();
    var uniquegroupv  = $('#uniquegroup').val();
    
    var params = '';
    params += '&DataType=' + DataType;
    var xxxtmp = tsd.encodeURIComponent(DataDict.replace(/[\'<>=]/g,""));
    if(tsd.Qualified()==false){
		$("#DataDict").select().focus();
		return false;
	}
	params += '&DataDict=' + tsd.encodeURIComponent(DataDict.replace(/\'/g,"_vv_v__v_").replace(/</g,"_vv_v__w_").replace(/>/g,"_vv_v__x_").replace(/=/g,"_vv_v__y_"));
    params += '&WebSelectable=' + WebSelectable;
    params += '&ShowOrder=' + ShowOrder;
    params += '&ShowWidth=' + ShowWidth;
    params += '&Selectable=' + Selectable;
    params += '&nOrderby=' + nOrderby;
    
    params += '&field_length=' + field_length;
    params += '&keytype=' + keytype;
    params += '&selecttype=' + selecttype;
    params += '&mulSelectOper=' + tsd.encodeURIComponent(mulSelectOper);    
    params += '&inputtype=' + inputtype;
    params += '&isquery=' + isquery;
    params += '&selectname=' + tsd.encodeURIComponent(selectnamev);
    params += '&relatedfield=' + tsd.encodeURIComponent(relatedfieldv);
    params += '&uniquegroup=' + tsd.encodeURIComponent(uniquegroupv);
    params += "&bsum=" + encodeURIComponent(bsumv);
    
    var fieldalias = zh + tsd.encodeURIComponent(fzhalias) + str + en + tsd.encodeURIComponent(fenalias) + str;
    var thestate = $('#thestate').val();
    var theloginfo = '';
    var thetype = '';
    var thefieldalias = fetchFieldAlias('Rb_Field', '<%=languageType %>');
    //修改表别名信息,记录日志
    thetype = 'modify';
    theloginfo = "(Rb_Field)" + tsd.encodeURIComponent("<fmt:message key='global.edit'/>") + tablename + tsd.encodeURIComponent("<fmt:message key='fieldalias.fieldalias' />") + tsd.encodeURIComponent("<fmt:message key='usermanager.info'/>.");
    //select 
    var thearr = getAliasInfo('field_alias', 'Rb_Field', 'field_name', tablename, 0);
    
    if (thearr['zhalias'] != fzhalias)
    {
        theloginfo += tsd.encodeURIComponent("<fmt:message key='fieldalias.fdzhalias' />") + ':' + tsd.encodeURIComponent(thearr['zhalias']) + '>>>' + tsd.encodeURIComponent(fzhalias) + ';';
    }
    if (thearr['enalias'] != fenalias)
    {
        theloginfo += tsd.encodeURIComponent("<fmt:message key='fieldalias.fdenalias' />") + ':' + tsd.encodeURIComponent(thearr['enalias']) + '>>>' + tsd.encodeURIComponent(fenalias) + ';';
    }
	if(tsd.Qualified()==false){
		$("#thequery").focus();
		return false;
	}
	params = params.replace(/_vv_v__v_/g,"''");
	params = params.replace(/_vv_v__w_/g,"<");
	params = params.replace(/_vv_v__x_/g,">");
	params = params.replace(/_vv_v__y_/g,"=");
    
    writeLogInfo('', thetype, theloginfo);
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + params + '&field_name=' + tsd.encodeURIComponent($('#fhname').val()) + '&field_alias=' + fieldalias + '&table_name=' + tablename, 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (msg)
        {
            if (msg == "true")
            {
                var operationtips = $("#operationtips").val();
                var successful = $("#successful").val();
                alert(successful, operationtips);
                setTimeout($.unblockUI, 15);
                reloadDataSon($('#thname').val());
            }
        }
    });
}
/**
 * 生成字段别名
 * @param 无参数
 * @return 无返回值
 */
function createField()
{
	if($('#editgrid').getGridParam('selrow')==null){
		alert('请选择要生成别名的表');
		return;
	}
	
    var tablename = $('#table_name').val();
    if (tablename != '' && tablename != null)
    {
        var init = $("#init").val();
        var confirm = $("#confirm").val();
        var operationtips = $("#operationtips").val();
        jConfirm(init + tablename + confirm + '?', operationtips, function (x) 
        {
            if (x == true)
            {
                var urlstr = tsd.buildParams(
                {
                    packgname : 'service', clsname : 'Procedure', method : 'exequery', ds : 'tsdBilling', 
                    //数据源名称 对应的spring配置的数据源
                    tsdpname : 'fieldAliasManager.Jfgl_BuildTableField', //存储过程的映射名称
                    tsdExeType : 'exe' 
                });
                $.ajax(
                {
                    url : 'mainServlet.html?' + urlstr + '&tablename=' + tablename, datatype : 'xml', 
                    cache : false, //如果值变化可能性比较大 一定要将缓存设成false
                    timeout : 1000, async : false , //同步方式
                    success : function ()
                    {
                        $('#table_name').val('');
                        reloadDataSon(tablename);
                    }
                });
            }
        });
    }
    else
    {
        var operationtips = $("#operationtips").val();
        var selecttable = $("#selecttable").val();
        alert(selecttable, operationtips);
    }
}
/**
 * 保存添加的表别名信息
 * @param thesave(保存状态：1.保存添加；2.保存退出)
 * @return 无返回值
 */
function saveInfo(thesave)
{
    var tablename = $('#tablename').val();
    if (tablename != '' && tablename != null)
    {
        if (isCreate(tablename) == false)
        {
            var urlstr = tsd.buildParams(
            {
                packgname : 'service', //java包
                clsname : 'ExecuteSql', //类名
                method : 'exeSqlData', //方法名
                ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
                tsdcf : 'mssql', //指向配置文件名称
                tsdoper : 'exe', //操作类型 
                tsdpk : 'fieldAliasManager.save'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
            });
            $('#thestate').val(0);
            var params = buildParams();
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
                            clearText('operforms');
                            $('#tablename').focus();
                        }
                        else if (thesave == 2) {
                            setTimeout($.unblockUI, 15);
                            reloadData();
                        }
                    }
                }
            });
        }
        else
        {
            var operationtips = $("#operationtips").val();
            //var successful = $("#successful").val();
            alert("<fmt:message key='fieldalias.isexist' />!", operationtips);
        }
    }
    else
    {
        var operationtips = $("#operationtips").val();
        //var successful = $("#successful").val();
        alert("<fmt:message key='fieldalias.notnull' />!", operationtips);
        $('#tablename').focus();
    }
}
/**
 * 在初始化页面的时候将面板加载进来
 * @param 无参数
 * @return 无返回值
 */
$(document).ready(function ()
{
    //参数为你要验证的表单的id 
    //myValidate("operform");
    //在页面初始化时加载动态加载事件
    blockForm('openadd1', 'operform', 160, 'close', "#ffffff", false);
    blockForm('openadd2', 'operform', 160, 'close', "#ffffff", false);
});
/**
 * 执行复合查询出提交过来的相应操作
 * @param 无参数
 * @return 无返回值
 */
function fuheExe()
{
    var queryName = $('#queryName').val();
    if (queryName == "query")
    {
        var flag = $('#whichorderoper').val();
        if (flag == 'top')
        {
            fuheQueryAlias('fieldAliasManager.fuhequerybywhere', 'fieldAliasManager.fuhequerybywherepage', 
            'editgrid');
        }
        else if (flag == 'down')
        {
            fuheQueryAlias('fieldAliasManager.fuhequeryfieldbywhere', 'fieldAliasManager.fuhequeryfieldbywherepage', 
            'editgrid_son');
        }
    }
}
/**
 * 弹出添加字段面板
 * @param 无参数
 * @return 无返回值
 */
function openText()
{
    var addinfo = $("#addinfo").val();
    //tsd.setTitle($("#input-Unit .title h3"),addinfo);
    $("#saveadd").show();
    $("#saveexit").show();
    $("#modify").hide();
    clearText('operforms');
 //   hideError();
    //隐藏错误信息 
}
/**
 * 是否设置为可读
 * @param id(唯一标识)
 * @param status(状态)
 * @return 无返回值
 */
function isReadOnly(id, status)
{
    document.getElementById(id).readOnly = status;
}
/**
 * 是否已经存在
 * @param tablename(表名)
 * @return boolean
 */
function isCreate(tablename)
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
        tsdpk : 'fieldAliasManager.querytableByKey' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    var flag = false;
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&table_name=' + tablename, datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var num = $(this).attr('num');
                if (num > 0) {
                    flag = true;
                }
            });
        }
    });
    return flag;
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
        alert('请先用高级查询，再保存。');
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
 * @return String(参数验证成功)/false(参数验证不成功)
 */
function fuheQbuildParams()
{
    //每次拼接参数必须初始化此参数
    tsd.QualifiedVal = true;
    var params = '';
    //如果有可能值是汉字 请使用encodeURI()函数转码
    var fusearchsql = $("#fusearchsql").val()
    fusearchsql = fusearchsql.replace(new RegExp(' Table_Name ',"g")," lower(Table_Name) ");
    
    fusearchsql = encodeURIComponent(fusearchsql);
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
 * @param sqlstr(排序参数)
 * @return 无返回值
 */
function zhOrderExe(sqlstr)
{
	
    var params = '';
    var flag = $('#whichorderoper').val();
    var sql = '';
    var pagesql = '';
    params = fuheQbuildParams();
    if (params == '&fusearchsql=') {
        params += '1=1';
    }
    var column = '';
    var key = '';
    var keyvalue = '';
    var jqid = '';
    if (flag == 'top')
    {
        key = 'Table_Name';
        keyvalue = 'rb_table';
        jqid = 'editgrid';
        column = $("#thecolumn").val();
        sql = 'main.queryByOrder';
        pagesql = 'main.queryByOrderpage';
    }
    else if (flag == 'down')
    {
        key = 'ID';
        keyvalue = 'Rb_Field';
        jqid = 'editgrid_son';
        column = $("#fieldcolumn").val();
        var ordername = $('#table_name').val();
        params += '&rbtablename=' + ordername;
        sql = 'fieldAliasManager.queryByOrder';
        pagesql = 'fieldAliasManager.queryByOrderpage';
    }
    params += '&orderby=' + sqlstr + '&column=' + column;
    params += '&orderkey=' + key;
    params += '&ordertablename=' + keyvalue;
    var languageType = $("#languageType").val();
    params += '&languageType=' + languageType;
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
    $("#" + jqid).setGridParam({
        url : 'mainServlet.html?' + link
    }).trigger("reloadGrid");
    //jAlert("操作成功","操作提示");
    setTimeout($.unblockUI, 15);
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
        url : 'mainServlet.html?' + urlstr + '&tablename=' + tablename.toLowerCase(), datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var thefieldname = $(this).attr("Field_Name".toLowerCase()) ;
                var thefieldalias = getCaption($(this).attr("Field_Alias".toLowerCase()), '<%=languageType %>', '');
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
 * 执行的是哪个查询
 * @param str
 * @return 无返回值
 */
function whichOper(str)
{
    $('#whichorderoper').val(str);
}
/**
 * 执行的是那个导出
 * @param 无参数
 * @return 无返回值
 */
function whichExport()
{
    var oper = $('#whichorderoper').val();
    var tablename = '';
    if (oper == 'top') {
        tablename = 'rb_table';
        getTheCheckedFields2('tsdBilling', 'mssql', tablename);
    }
    else if (oper == 'down')
    {
        tablename = 'Rb_Field';
        getTheCheckedFields2('tsdBilling', 'mssql', tablename, undefined, 'ian');
    }
}

/**********************************************************
function name:    getTheCheckedFields2(ds,tsdcf,table)
function:		   获取选中的数据列
parameters:        ds：数据源
				   tsdcf：数据源配置
				   table: 表名,要显示数据的表的名称
				   table2: 别名表中的table_name的值
				   flag：外加附带限制条件
********************************************************/
function getTheCheckedFields2(ds,tsdcf,table,table2,flagfield){
	var thename=document.getElementsByName('thefields');  				
	var thevalue = '';
	var theclos = '';
	var atable = table;
	if(table2!=undefined){
		atable = table2;
	}
	var arr = displayFields(atable);
	var limitarr = thename.length;
	//如果字段较多则只取前20个
	var limitflag = false;
	var disi = 0;
	for(var i = 0 ; i < limitarr;i++){
		if(thename[i].checked==true){
	    	disi++;
	    }
	}
	if(disi>20){
		limitarr = 20;
		limitflag = true;
	}					
	for(var i=0;i<limitarr;i++){
		if(thename[i].checked==true){
			theclos += arr[i] + ',';
		}
	}
	theclos = theclos.substring(0,theclos.lastIndexOf(','));
	/***********************************************************
	*@2010.12.17 liwen
	*对表别名和 字段别名国际化的处理
	*这个地方需要判断用的是什么数据库，EDB和ORACLE对INSTR函数处理方式不同
	************************************************************/
	$.ajax ( {
		url : 'mainServlet.html?packgname=service&clsname=DBService&method=service&operate=decideDBType&ds=tsdBilling',
		datatpe:'xml',     
		cache:false,
		timeout: 1000,
		async: false ,
		success:function(data){ 
			 if (data == 'enterprisedb')  {
				theclos = theclos.replace('Table_Alias',"SUBSTR(Table_Alias,POSITION('<%=languageType %>' IN Table_Alias)*3-1,POSITION('/}' IN SUBSTR(Table_Alias,POSITION('<%=languageType %>' IN Table_Alias)))-POSITION('<%=languageType %>' IN Table_Alias)-2)");
				theclos = theclos.replace('Field_Alias',"SUBSTR(Field_Alias,POSITION('<%=languageType %>' IN Field_Alias)*3-1,POSITION('/}' IN SUBSTR(Field_Alias,POSITION('<%=languageType %>' IN Field_Alias)))-POSITION('<%=languageType %>' IN Field_Alias)-2)");
			 } else {
				theclos = theclos.replace('Table_Alias',"SUBSTR(Table_Alias,INSTR(Table_Alias,'<%=languageType %>')*3-1,INSTR(Table_Alias,'/}',INSTR(Table_Alias,'<%=languageType %>'))-INSTR(Table_Alias,'<%=languageType %>')-3) ");
				theclos = theclos.replace('Field_Alias',"SUBSTR(Field_Alias,INSTR(Field_Alias,'<%=languageType %>')*3-1,INSTR(Field_Alias,'/}',INSTR(Field_Alias,'<%=languageType %>'))-INSTR(Field_Alias,'<%=languageType %>')-3)");
			 }
		}
	}) ;
	
	thisDataDownload(ds,tsdcf,theclos,table,flagfield,limitflag,atable);				
	//将面板关闭
	setTimeout($.unblockUI, 15);
}

/**
 * 初始化第一次显示导出数据，不带任何条件的
 * @param 无参数
 * @return 无返回值
 */
var ina = 0;
function operFirst()
{
    if (ina == 0) {
        $('#fusearchsql').val('');
        i = 1;
    }
}			
</script>
			
<style type="text/css">
.tdstyle{border-bottom:1px solid #A9C8D9;}
.spanstyle{display:-moz-inline-box; display:inline-block; width:115px}
.titlemargin{margin-left:90px !important;margin-left:45px;}
</style>
	</head>

	<body>
		<!-- 用户操作导航-->
		<form name="childform" id="childform">
			<input type="text" id="queryName" name="queryName"
				style="display: none" />
			<input type="text" id="queryName_son" name="queryName_son"
				style="display: none" />
			<input type="text" id="querysql" name="querysql"
				style="display: none" />
			<input type="text" id="querysql_son" name="querysql_son"
				style="display: none" />
			<input type="text" id="fusearchsql" name="fusearchsql"
				style="display: none" />
			<input type="text" id="gridinfo" name="gridinfo"
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
		<div id="buttons" style="text-align: left;">
			<button type="button" id="order2"
				onclick="whichOper('top');openDiaO('rb_table');">
				<!-- 组合排序 -->
				<fmt:message key="tariff.order" />
			</button>
			<button type="button" id="openadd1" onclick="openText()"
				disabled="disabled">
				<fmt:message key="global.add" />
			</button>
			<button type="button" id="query1"
				onclick="whichOper('top');openDiaQueryG('query','rb_table')"
				disabled="disabled">
				高级查询
			</button>
			<button type="button" id="exp1"
				onclick="whichOper('top');thisDownLoad('tsdBilling','mssql','rb_table','<%=languageType %>',6)"
				disabled="disabled">
				<fmt:message key="global.exportdata" />
			</button>
			<button type="button" id="createfield1" onclick="createField()"
				disabled="disabled">
				<fmt:message key="fieldalias.createalias" />
			</button>
		</div>
		<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>
		<div id="buttons" style="text-align: left;">
			<button type="button" id="order21"
				onclick="whichOper('top');openDiaO('rb_table');">
				<!-- 组合排序 -->
				<fmt:message key="tariff.order" />
			</button>
			<button type="button" id="openadd11" onclick="openText()"
				disabled="disabled">
				<fmt:message key="global.add" />
			</button>
			<button type="button" id="query11"
				onclick="whichOper('top');openDiaQueryG('query','rb_table')"
				disabled="disabled">
				高级查询
			</button>
			<button type="button" id="exp11"
				onclick="whichOper('top');thisDownLoad('tsdBilling','mssql','rb_table','<%=languageType %>',6)"
				disabled="disabled">
				<fmt:message key="global.exportdata" />
			</button>
			<button type="button" id="createfield11" onclick="createField()"
				disabled="disabled">
				<fmt:message key="fieldalias.createalias" />
			</button>
		</div>
		
		
		<!-- 用户操作标题以及放一些快捷按钮-->
		<div id="buttons" style="text-align: left;">
			<!-- 这里的按钮可以自由更换 但格式要对 -->			
			<button type="button" id="order2"
				onclick="if($('#editgrid').getGridParam('selrow')==null){ alert('请从表别名列表中选择要执行排序操作的表');return;}whichOper('down');openDiaO('rb_field');">
				<!-- 组合排序 -->
				<fmt:message key="tariff.order" />
			</button>
			<button type="button" id="query2"
				onclick="if($('#editgrid').getGridParam('selrow')==null){ alert('请从表别名列表中选择要执行查询的表');return;}whichOper('down');openDiaQueryG('query','rb_field')"
				disabled="disabled">
				高级查询
			</button>
			<button type="button" id="exp2"
				onclick="if($('#editgrid').getGridParam('selrow')==null){ alert('请从表别名列表中选择要执行数据导出的表');return;}whichOper('down');operFirst();thisDownLoad('tsdBilling','mssql','rb_field','<%=languageType %>',6)"
				disabled="disabled">
				<fmt:message key="global.exportdata" />
			</button>
		</div>
		<table id="editgrid_son" class="scroll" cellpadding="0"
			cellspacing="0"></table>
		<div id="pagered_son" class="scroll" style="text-align: left;"></div>
		<div id="buttons" style="text-align: left;">
			<!-- 这里的按钮可以自由更换 但格式要对 -->			
			<button type="button" id="order21"
				onclick="if($('#editgrid').getGridParam('selrow')==null){ alert('请从表别名列表中选择要执行排序操作的表');return;}whichOper('down');openDiaO('rb_field');">
				<!-- 组合排序 -->
				<fmt:message key="tariff.order" />
			</button>
			<button type="button" id="query21"
				onclick="if($('#editgrid').getGridParam('selrow')==null){ alert('请从表别名列表中选择要执行查询的表');return;}whichOper('down');openDiaQueryG('query','rb_field')"
				disabled="disabled">
				高级查询
			</button>
			<button type="button" id="exp21"
				onclick="if($('#editgrid').getGridParam('selrow')==null){ alert('请从表别名列表中选择要执行数据导出的表');return;}whichOper('down');operFirst();thisDownLoad('tsdBilling','mssql','rb_field','<%=languageType %>',6)"
				disabled="disabled">
				<fmt:message key="global.exportdata" />
			</button>
		</div>
		
		<!-- 表单输入区域 -->
		<div class="neirong" id="operform" style="display: none; width: 800px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							添加字段表
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
				<form action="#" id="operforms" onsubmit="return false;">
					<input type="hidden" id=''/>
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td class="dflabelclass">
								<label for="tname">
									<span id="tname"></span>
								</label>
							</td>
							<td width="20%" class="dftdstyle">
								<input type="text" class="textclass" id="tablename" /><font style="color: red;">*</font>
							</td>

							<td class="dflabelclass">
								<label for="tzhalias">
									<span id="tzhalias"></span>
								</label>
							</td>
							<td width="20%" class="dftdstyle">
								<input type="text" class="textclass" id="tablezhalias" />
							</td>
							<td class="dflabelclass">
								<label for="tenalias">
									<span id="tenalias"></span>
								</label>
							</td>
							<td width="20%" class="dftdstyle">
								<input type="text" class="textclass" id="tableenalias" />
							</td>
						</tr>
					</table>
				</form>
			</div>

			<div class="midd_butt">

				<button type="submit" class="tsdbutton" id="saveadd"
					onclick="saveInfo(1)">
					保存添加
				</button>
				<button type="submit" class="tsdbutton" id="saveexit"
					onclick="saveInfo(2)" style="margin-left: 15px">
					保存退出
				</button>
				<button type="submit" class="tsdbutton" id="modify"
					onclick="modifyInfo()">
					<fmt:message key="global.edit" />
				</button>

				<button type="button" class="tsdbutton" id="close"
					style="margin-left: 15px" style="margin-left: 10px"
					onclick="clearText('operforms');isReadOnly('tablename',false);reloadData();">
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
			<br />
			<br />
			<br />
			<br />
			<%		
		}else if(theflag==2){
	%>
			<br />
			<%		
		}
	%>
		</div>

		<div class="neirong" id="operfieldform"
			style="display: none; width: 800px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							修改字段别名
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#closethis').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>

			</div>

			<div class="midd">
				<form action="#" name="operfieldform" id="operfieldforms"
					onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td class="labelclass">
								<label for="fname">
									<span id="fieldname"></span>
								</label>

							</td>
							<td width="20%" class="tdstyle">
								<input type="text" class="textclass" id="fname"
									readonly="readonly" />
							</td>

							<td class="labelclass">
								<label for="fzhalias">
									<span id="fieldzhalias"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<input type="text" class="textclass" id="fzhalias" />
							</td>

							<td class="labelclass">
								<label for="fenalias">
									<span id="fieldenalias"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<input type="text" class="textclass" id="fenalias" />
							</td>
						</tr>

						<tr>
							<td class="labelclass">
								<label for="DataDict">
									<span id="DataDicts"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle" colspan="5">
								<textarea id="DataDict" style="width:98%;height:38px;margin-left:5px;"></textarea>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="bSum">
									是否求和
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<select name="bSum" id="bSum" class="textclass">
									<option value="0">否</option>
									<option value="1">是</option>
								</select>
							</td>
							<td class="labelclass">
								<label for="DataType">
									<span id="DataTypes"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<select id="DataType" class="textclass">
									<option value="dtUnknow">
										dtUnknow
									</option>
									<option value="dtGraphic">
										dtGraphic
									</option>

									<option value="dtString">
										dtString
									</option>
									<option value="dtDouble">
										dtDouble
									</option>
									<option value="dtBoolean">
										dtBoolean
									</option>
									<option value="dtdatetime">
										dtdatetime
									</option>
									<option value="dtInteger">
										dtInteger
									</option>
								</select>
							</td>

							<td class="labelclass">
								<label for="WebSelectable">
									<span id="WebSelectables"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<select id="WebSelectable" class="textclass">
									<option value="T">
										显示
									</option>
									<option value="F">
										不显示
									</option>
								</select>
							</td>

						</tr>


						<tr>
							<td class="labelclass">
								<label for="ShowOrder"">
									<span id="ShowOrders"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<select id="ShowOrder" class="textclass">

								</select>
							</td>
							<td class="labelclass">
								<label for="ShowWidth">
									<span id="ShowWidths"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<input type="text" class="textclass" id="ShowWidth" />
							</td>

							<td class="labelclass">
								<label for="Selectable">
									<span id="Selectables"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<select id="Selectable" class="textclass">
									<option value="T">
										是
									</option>
									<option value="F">
										否
									</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="nOrderby">
									<span id="nOrderbys"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<input type="text" class="textclass" id="nOrderby" />
							</td>
							<td class="labelclass">
								<label >
									<fmt:message key="length" />
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<input type="text" class="textclass" id="field_length" style="ime-mode: Disabled" 
								 onkeypress="var k=event.keyCode; return k>=48&&k<=57" maxlength="4" 
								 onpaste="return   !clipboardData.getData('text').match(/\D/)" 
								 ondragenter="return false" value="0"
								/>
							</td>
							<td class="labelclass">
								<label >
									<fmt:message key="keytype" />
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<select id="keytype" class="textclass">
									<option value="0">
										<fmt:message key="keytype.0" />
									</option>
									<option value="1">
										<fmt:message key="keytype.1" />
									</option>
									<option value="2">
										<fmt:message key="keytype.2" />
									</option>
									<option value="3">
										<fmt:message key="keytype.3" />
									</option>
								</select>
							</td>
						</tr>
						
						<tr>
							<td class="labelclass">
								<label >
									<fmt:message key="selecttype" />
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<select id="selecttype" class="textclass">
									<option value="0">
										<fmt:message key="selecttype.0" />
									</option>
									<option value="1">
										<fmt:message key="selecttype.1" />
									</option>
									<option value="2">
										<fmt:message key="selecttype.2" />
									</option>
									<option value="3">
										<fmt:message key="selecttype.3" />
									</option>
									<option value="11">
										<fmt:message key="selecttype.11" />
									</option>
									<option value="12">
										<fmt:message key="selecttype.12" />
									</option>
									<option value="13">
										<fmt:message key="selecttype.13" />
									</option>
								</select>
							</td>
							
							<td class="labelclass">
								<label>
									<fmt:message key="mulSelect.oper" />
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<select id="mulSelectOper" class="textclass">
									<option value="">
										<fmt:message key="AddUser.PleaseSelect" />
									</option>
									<option value=",">
										,
									</option>
									<option value="+">
										+
									</option>
									<option value="~">
										~
									</option>
								</select>
							</td>
							
							<td class="labelclass">
								<label >
									<fmt:message key="inputtype" />
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<select id="inputtype" class="textclass">
									<option value="1">
										<fmt:message key="inputtype.1" />
									</option>
									<option value="2">
										<fmt:message key="inputtype.2" />
									</option>
								</select>
							</td>
							
						</tr>
						<tr>
							<td class="labelclass">
								<label >
									<fmt:message key="isquery" />
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<select id="isquery" class="textclass">
									<option value="0">
										<fmt:message key="isquery.0" />
									</option>
									<option value="1">
										<fmt:message key="isquery.1" />
									</option>
								</select>
							</td>
							<td class="labelclass">
								<label >
									关联字段
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<input id="related_field"  class="textclass" type="text" name="related_field" />
							</td>
							<td class="labelclass">
								<label >
									字段分组
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<select id="uniquegroup" name="uniquegroup" class="textclass">
									<option value="">
										无分组
									</option>
									<option value="1">
										分组一
									</option>
									<option value="2">
										分组二
									</option>
									<option value="3">
										分组三
									</option>
									<option value="4">
										分组四
									</option>
									<option value="5">
										分组五
									</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label>关联信息</label>
							</td>
							<td class="tdstyle" colspan="5">
								<textarea id="selectname" style="width:98%;height:38px;margin-left:5px;"></textarea>
								<!-- <input type="text" name="selectname" id="selectname" class="textclass" style="width:350px" /> -->
							</td>
						</tr>
						
					</table>
				</form>
			</div>

			<div class="midd_butt">
				<button type="submit" class="tsdbutton" id="modify_son"
					onclick="modifyInfo_son()">
					<fmt:message key="global.save" />
				</button>
				<button type="button" class="tsdbutton" id="closethis"
					style="margin-left: 10px" onclick="clearText('operfieldforms')">
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
			<br />
			<br />
			<br />
			<br />
			<%		
		}else if(theflag==2){
	%>
			<br />
			<%		
		}
	%>
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
			<input type="hidden" id="init"
				value="<fmt:message key="fieldalias.init"/>" />
			<input type="hidden" id="confirm"
				value="<fmt:message key="fieldalias.confirm"/>" />
			<input type="hidden" id="selecttable"
				value="<fmt:message key="fieldalias.selecttable"/>" />
			<input type="hidden" id="ttalias"
				value="<fmt:message key="fieldalias.tablealias"/>" />
			<input type="hidden" id="ffalias"
				value="<fmt:message key="fieldalias.fieldalias"/>" />

			<input type="hidden" id="addright" />
			<input type="hidden" id="deleteright" />
			<input type="hidden" id="editright" />
			<input type="hidden" id="queryright" />

			<input type="hidden" id="exportright" />

			<input type="hidden" id="editotherright" />

			<input type="hidden" id="editfields" />

			<input type="hidden" id="table_name" />
			<input type="hidden" id="thestate" />
			<input type="hidden" id="thedelinfo" />

			<input type="hidden" id="fhname" />
			<input type="hidden" id="thname" />
			<input type="hidden" id="createfieldright" />
			<input type="hidden" id="thecolumn" />
			<input type="hidden" id="fieldcolumn" />

			<input type="hidden" id="whichorderoper" />

			<input type="hidden" id="imenuname" value="<%=imenuname %>" />

			<input type="hidden" id="ordertable" />
			<input type="hidden" id="userid" value="<%=userid%>" />
			<input type='hidden' id='userloginip'
				value='<%=Log.getIpAddr(request)%>' />
			<input type='hidden' id='userloginid'
				value='<%=session.getAttribute("userid")%>' />
			<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />

		</div>

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
							选择您要导出的数据字段
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#closethisinfo').click();">关闭</a>
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
							<td>n
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
					全选
				</button>
				<button type="submit" class="tsdbutton" id="query"
					onclick="whichExport()">
					<fmt:message key="global.ok" />
				</button>
				<button type="button" class="tsdbutton" id="closethisinfo">
					<fmt:message key="global.close" />
				</button>

			</div>
		</div>
	</body>
</html>
