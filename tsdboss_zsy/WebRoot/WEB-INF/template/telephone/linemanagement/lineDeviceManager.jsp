<%----------------------------------------
	name: lineDeviceManager.jsp
	author: chenliang
	version: 1.0, 2009-11-26
	description: 对号线设备的管理
	modify: 
		2009-11-26:  添加功能注释.
      	2009-12-02:  添加日志和国际化信息.
	  	2009-12-06:  修改日志功能
	  	2009-12-08:  修改国际化信息
	  	2010-08-04:  删除设备提示部门信息，批量删除端子端口	
	  	2011-6-7 ：   youhongyu 添加第三级设备
 ----------------------------------------%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%@page import="java.io.File"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	
	String devicepath = basePath + "style/icon/device/";
	
	String userid = (String) session.getAttribute("userid");
%>
<%	
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
	
	String rootPath = request.getRealPath("style/images/public/");//大图标所在文件夹
	
	File thepath = new File(rootPath);
	int x = 0;
	if(thepath.listFiles().length>0){
		for(int i = 0 ; i < thepath.listFiles().length;i++){
			if(thepath.listFiles()[i].toString().endsWith(".jpg")){
				x++;
			}
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>LineDevice-Manager</title>
<!-- 导入的js文件 -->
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<script src="style/js/mainStyle.js" type="text/javascript"></script>
		<script type="text/javascript" src="plug-in/jquery/validate/jquery.validate.js"></script>
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
		<!-- tab滑动门需要导入的包 *注意路径 -->
		<script src="plug-in/jquery/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<!-- tab滑动门 需要导入的样式表 *注意路径-->
		<script type="text/javascript" src="css/tree/dtree.js"></script>
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<!-- 收费结账专用js -->
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 页面国际化 -->
		<script type="text/javascript" src="script/broadband/business/Internationalization.js"></script>
<!-- 导入js文件结束 -->
<!-- 导入css文件开始 -->
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs-ie.css"	type="text/css" media="projection, screen" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="css/tree/dtree.css" />
		
<!-- 导入css文件结束 -->
<script type="text/javascript">
/******************************************
            **  查看当前用户的扩展权限，对spower字段进行解析 *
            *****************************************/
function getUserPower()
{
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', clsname : 'Procedure', method : 'exequery', ds : 'tsdBilling', //数据源名称 对应的spring配置的数据源
        tsdpname : 'lineDeviceManager.getPower', //存储过程的映射名称
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
    var adddeviceright = '';
    var adddevicetyperight = '';
    var addnodenameright = '';
    var editdeviceright = '';
    var editdevicetyperight = '';
    var editnodenameright = '';
    var deletedeviceright = '';
    var deletedevicetyperight = '';
    var deletenodenameright = '';
    var addbatchdeviceright = '';
    var　batchdeleteright = '';
    
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
        adddeviceright = 'true';
        adddevicetyperight = 'true';
        addnodenameright = 'true';
        editdeviceright = 'true';
        editdevicetyperight = 'true';
        editnodenameright = 'true';
        deletedeviceright = 'true';
        deletedevicetyperight = 'true';
        deletenodenameright = 'true';
        addbatchdeviceright = 'true';
        batchdeleteright = 'true';
        flag = true;
    }
    else if (spower != '' && spower != 'all@')
    {
        var spowerarr = spower.split('@');
        for (var i = 0; i < spowerarr.length - 1; i++)
        {
            adddeviceright += getCaption(spowerarr[i], 'adddevice', '') + '|';
            adddevicetyperight += getCaption(spowerarr[i], 'adddevicetype', '') + '|';
            addnodenameright += getCaption(spowerarr[i], 'addnodename', '') + '|';
            editdeviceright += getCaption(spowerarr[i], 'editdevice', '') + '|';
            editdevicetyperight += getCaption(spowerarr[i], 'editdevicetype', '') + '|';
            editnodenameright += getCaption(spowerarr[i], 'editnodename', '') + '|';
            deletedeviceright += getCaption(spowerarr[i], 'deletedevice', '') + '|';
            deletedevicetyperight += getCaption(spowerarr[i], 'deletedevicetype', '') + '|';
            deletenodenameright += getCaption(spowerarr[i], 'deletenodename', '') + '|';
            addbatchdeviceright += getCaption(spowerarr[i], 'addbatchdevice', '') + '|';
            editfields += getCaption(spowerarr[i], 'editfields', '');
            batchdeleteright += getCaption(spowerarr[i], 'delB', '');
        }
    }
    var hasadddevice = adddeviceright.split('|');
    var hasadddevicetype = adddevicetyperight.split('|');
    var hasaddnodename = addnodenameright.split('|');
    var haseditdevice = editdeviceright.split('|');
    var haseditdevicetype = editdevicetyperight.split('|');
    var haseditnodename = editnodenameright.split('|');
    var hasdeletedevice = deletedeviceright.split('|');
    var hasdeletedevicetype = deletedevicetyperight.split('|');
    var hasdeletenodename = deletenodenameright.split('|');
    var hasaddbatchdevice = addbatchdeviceright.split('|');
    var hasbatchdelete = batchdeleteright.split('|');
    
    var str = 'true';
    if (flag == true)
    {
        $("#adddeviceright").val(adddeviceright);
        $("#adddevicetyperight").val(adddevicetyperight);
        $("#addnodenameright").val(addnodenameright);
        $("#addbatchdeviceright").val(addbatchdeviceright);
        $("#editdeviceright").val(editdeviceright);
        $("#editdevicetyperight").val(editdevicetyperight);
        $("#editnodenameright").val(editnodenameright);
        $("#deletedeviceright").val(deletedeviceright);
        $("#deletedevicetyperight").val(deletedevicetyperight);
        $("#deletenodenameright").val(deletenodenameright);
        $("#batchdeleteright").val(batchdeleteright);
    }
    else
    {
        for (var i = 0; i < hasadddevice.length; i++) {
            if (hasadddevice[i] == 'true') {
                $("#adddeviceright").val(str);
                break;
            }
        }
        for (var i = 0; i < hasbatchdelete.length; i++) {
            if (hasbatchdelete[i] == 'true') {
                $("#batchdeleteright").val(str);
                break;
            }
        }
        
        for (var i = 0; i < hasadddevicetype.length; i++) {
            if (hasadddevicetype[i] == 'true') {
                $("#adddevicetyperight").val(str);
                break;
            }
        }
        for (var i = 0; i < hasaddnodename.length; i++) {
            if (hasaddnodename[i] == 'true') {
                $("#addnodenameright").val(str);
                break;
            }
        }
        for (var i = 0; i < haseditdevice.length; i++) {
            if (haseditdevice[i] == 'true') {
                $("#editdeviceright").val(str);
                break;
            }
        }
        for (var i = 0; i < haseditdevicetype.length; i++) {
            if (haseditdevicetype[i] == 'true') {
                $("#editdevicetyperight").val(str);
                break;
            }
        }
        for (var i = 0; i < haseditnodename.length; i++) {
            if (haseditnodename[i] == 'true') {
                $("#editnodenameright").val(str);
                break;
            }
        }
        for (var i = 0; i < hasdeletedevice.length; i++) {
            if (hasdeletedevice[i] == 'true') {
                $("#deletedeviceright").val(str);
                break;
            }
        }
        for (var i = 0; i < hasdeletedevicetype.length; i++) {
            if (hasdeletedevicetype[i] == 'true') {
                $("#deletedevicetyperight").val(str);
                break;
            }
        }
        for (var i = 0; i < hasdeletenodename.length; i++) {
            if (hasdeletenodename[i] == 'true') {
                $("#deletenodenameright").val(str);
                break;
            }
        }
        for (var i = 0; i < hasaddbatchdevice.length; i++) {
            if (hasaddbatchdevice[i] == 'true') {
                $("#addbatchdeviceright").val(str);
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
jQuery(document).ready(function () 
{
    /************
     *
     * 取当前用户权限
     */
    getUserPower();
    /************
	   *
	   * 取导航菜单函数
	   */
    $("#navBar1").append(genNavv());
    /************
            *
            * 取模块局函数
            */
    getMoKuaiJu('mokuaiju');
    getMoKuaiJu('moduleBu');
    var adddeviceright = $("#adddeviceright").val();
    if (adddeviceright == "true") {
        document.getElementById("addone1").disabled = false;
    }
    var adddevicetyperight = $("#adddevicetyperight").val();
    if (adddevicetyperight == "true") {
        document.getElementById("addtwo1").disabled = false;
        document.getElementById("addfour1").disabled = false;
    }
    var addnodenameright = $("#addnodenameright").val();
    if (addnodenameright == "true") {
        document.getElementById("addthree1").disabled = false;
    }
    var addbatchdeviceright = $("#addbatchdeviceright").val();
    if (addbatchdeviceright == "true") {
        document.getElementById("batchthree1").disabled = false;
    }
    var batchdeleteright = $("#batchdeleteright").val();
    if (batchdeleteright == "true") {
        document.getElementById("opendel2").disabled = false;
    }
    
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xml', //返回数据格式 
        tsdpk : 'lineDeviceManager.queryone', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'lineDeviceManager.queryonepage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    var oper = $("#operation").val();
    var languageType = $("#languageType").val();
    var thefieldalias = fetchFieldAlias('air_device', '<%=languageType %>');
    var deviceno = thefieldalias['DeviceNo'];
    var devicename = thefieldalias['DeviceName'];
    var deviceicon = thefieldalias['DeviceIcon'];
    var devicememo = thefieldalias['memo'];
    var devicenodesects = thefieldalias['NodeSects'];
    
    $('#DeviceNodeSects').html(devicenodesects);
    $('#DeviceNamee').html(devicename);
    $('#DeviceIconn').html(deviceicon);
    $('#DeviceIconn4').html(deviceicon);
    $('#Devicememo1').html(devicememo);
    $('#Devicememo2').html(devicememo);
    $('#Devicememo2_f').html(devicememo);
    $('#Devicememo3').html(devicememo);
    $('#Devicememo4').html(devicememo);
    var theonedevice = $('#onedevice').val();
    var thisin = '';
    var thisdata = loadData('air_device', languageType, 1);
    thisdata.setWidth({
        Operation : 60
    });

    jQuery("#editgrid_one").jqGrid(
    {
        url : 'mainServlet.html?' + urlstr + '&DeviceNo=' + thisin, datatype : 'xml', 
        colNames : ['修改|删除',deviceno, devicename, devicenodesects,devicememo], 
        colModel : [ {
            name : 'viewOperation', index : 'viewOperation', width : 60
        },
        {
            name : 'DeviceNo', index : 'DeviceNo', width : 60
        },
        {
            name : 'DeviceName', index : 'DeviceName', width : 60
        },
        {
            name : 'NodeSects', index : 'NodeSects', width : 60
        },
        {
            name : 'memo', index : 'memo',width : 90
        } ], 
        rowNum : 10, //默认分页行数
        rowList : [10, 15, 20], //可选分页行数
        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images//', pager : jQuery('#pagered_one'), sortname : 'DeviceNo', 
        //默认排序字段
        viewrecords : true, sortorder : 'asc', //默认排序方式 
        caption : '路由信息列表', height : 110, //高
        width : (document.documentElement.clientWidth - 80) / 2,
        loadComplete : function ()
        {
            if ($("#editgrid_one tr.jqgrow[id='1']").html() == "") {
                return false;
            }
            $("#editgrid_one").setSelection('1', true);
            $("#editgrid_one").focus();
            var editinfo = $("#editinfo").val();
            var deleteinfo = $("#deleteinfo").val();
            addRowOperBtn('editgrid_one', '<img src="style/images/public/ltubiao_01.gif" alt="' + editinfo + '"/>', 
            'queryOneInfo', 'DeviceNo', 'click', 1 );
            addRowOperBtn('editgrid_one', '<img src="style/images/public/ltubiao_02.gif" alt="' + deleteinfo + '"/>', 
            'deleteOne', 'DeviceNo', 'click', 2);
            executeAddBtn('editgrid_one', 2);
        },
        onSelectRow : function (ids) 
        {
            if (ids != null) 
            {
                var DeviceNo = '';
                var DeviceName = '';
                var module=$('#moduleBu').val();
                DeviceName = $("#editgrid_one").getCell(ids, "DeviceName");
                $("#DeviceName").val(DeviceName);
                DeviceNo = $("#editgrid_one").getCell(ids, "DeviceNo");
                
                $("#DeviceNo2").val("");
                $("#DeviceNo").val(DeviceNo);
                DeviceNo = tsd.encodeURIComponent(DeviceNo);
                $("#editgrid_two").setGridParam({
                    url : "mainServlet.html?" + urlstr_two + "&DeviceNo=" + DeviceNo+"&mokuaiju="+tsd.encodeURIComponent(module)
                }).trigger('reloadGrid');
                /**
                $("#editgrid_three").setGridParam(
                {
                    url : "mainServlet.html?" + urlstr_three + "&DeviceNo=" + DeviceNo + '&lan=<%=languageType %>'
                }).trigger('reloadGrid');
                */
            }
        }
    }).navGrid('#pagered_one', {
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
    $('#two').val(urlstr_two)
    var urlstr_two = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xml', //返回数据格式 
        tsdpk : 'lineDeviceManager.querytwo', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'lineDeviceManager.querytwopage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    $('#two').val(urlstr_two);
    var thefieldalias = fetchFieldAlias('Air_DeviceType', '<%=languageType %>');
    var deviceno = thefieldalias['DeviceNo'];
    var devicetype = thefieldalias['DeviceType'];
    var mkj = thefieldalias['mokuaiju'];
    var deviceicon = thefieldalias['DeviceIcon'];
    $('#DeviceTypee').html(devicetype);
    $('#mokuaijuu').html(mkj);
    $('#DeviceIconn2').html(deviceicon);
    var thetwodevice = $('#twodevice').val();
    jQuery("#editgrid_two").jqGrid(
    {
        datatype : 'xml', colNames : ['修改|删除', deviceno, devicetype, mkj, devicememo], colModel : [ {
            name : 'viewOperation', index : 'viewOperation', width : 90
        },
        //如果有操作列 请勿更改或者删除
        {
            name : 'DeviceNo', index : 'DeviceNo'
        },
        {
            name : 'DeviceType', index : 'DeviceType'
        },
        {
            name : 'mokuaiju', index : 'mokuaiju'
        },
        {
            name : 'memo', index : 'memo'
        } ], rowNum : 10, //默认分页行数
        rowList : [10, 15, 20], //可选分页行数
        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images//', pager : jQuery('#pagered_two'), sortname : 'DeviceType', 
        //默认排序字段
        viewrecords : true, sortorder : 'asc', //默认排序方式 
        caption : '设备信息列表', height : 110, //高 
        width : (document.documentElement.clientWidth - 80) / 2,
        loadComplete : function ()
        {
            if ($("#editgrid_two tr.jqgrow[id='1']").html() == "") {
                return false;
            }
            //查询后，默认选中第一条
            $("#editgrid_two").setSelection('1');
            $("#editgrid_two").focus();
            //新老数据,主键不一样，这如何处理?
            var editinfo = $("#editinfo").val();
            var deleteinfo = $("#deleteinfo").val();
            addRowOperBtn('editgrid_two', '<img src="style/images/public/ltubiao_01.gif" alt="' + editinfo + '"/>', 
            'queryTwoInfo', 'DeviceNo', 'click', 1);
            addRowOperBtn('editgrid_two', '<img src="style/images/public/ltubiao_02.gif" alt="' + deleteinfo + '"/>', 
            'deleteTwo', 'DeviceNo', 'click', 2);
            executeAddBtn('editgrid_two', 2);
        },
        onSelectRow : function (ids) 
        {
            if (ids != null) 
            {
                var DeviceNo = '';
                var DeviceType = '';
                DeviceType = $("#editgrid_two").getCell(ids, "DeviceType");
                $("#DeviceType").val(DeviceType);
                mokuaiju = $("#editgrid_two").getCell(ids, "mokuaiju");
                $("#thismokuaiju").val(mokuaiju);
                DeviceNo = $("#editgrid_two").getCell(ids, "DeviceNo");
                
                $("#DeviceNo2").val(DeviceNo);                
                DeviceNo = tsd.encodeURIComponent(DeviceNo);                
                $("#editgrid_four").setGridParam(
                {
                    url : "mainServlet.html?" + urlstr_four + "&DeviceNo=" + DeviceNo + '&lan=<%=languageType %>'
                }).trigger('reloadGrid');
                
            }
        }
    }).navGrid('#pagered_two', {
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
   
    var urlstr_three = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xml', //返回数据格式 
        tsdpk : 'lineDeviceManager.querythree', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'lineDeviceManager.querythreepage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    var thefieldalias = fetchFieldAlias('Air_DeviceMx', '<%=languageType %>');
    var dno = thefieldalias['DeviceNo'];
    var nodename = thefieldalias['NodeName'];
    var nodestate = thefieldalias['NodeState'];
    var mkjj = thefieldalias['MoKuaiJu'];
    var deviceiconn = thefieldalias['DeviceIcon'];
    $('#NodeNamee').html(nodename);
    $('#NodeStatee').html(nodestate);
    $('#DeviceIconn3').html(deviceiconn);
    var thethreedevice = $('#threedevice').val();
    jQuery("#editgrid_three").jqGrid(
    {
        datatype : 'xml', colNames : ['修改|删除', dno, nodename, nodestate, mkjj, '可复用',devicememo], 
        colModel : [ {
            name : 'viewOperation', index : 'viewOperation', width : 70
        },
        //如果有操作列 请勿更改或者删除
        {
            name : 'DeviceNo', index : 'DeviceNo'
        },
        {
            name : 'NodeName', index : 'NodeName'
        },
        {
            name : 'NodeState', index : 'NodeState'
        },
        {
            name : 'mokuaiju', index : 'mokuaiju'
        },
        {
            name : 'Multiplexing', index : 'Multiplexing'
        },
        {
            name : 'memo', index : 'memo'
        } ], rowNum : 10, //默认分页行数
        rowList : [10, 15, 20], //可选分页行数
        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images//', 
        pager : jQuery('#pagered_three'), 
        sortname : 'NodeName', 
        //默认排序字段
        viewrecords : true, //hidegrid: false, 
        sortorder : 'asc', //默认排序方式 
        caption : '端口信息列表', height : 110, //高 
        width : (document.documentElement.clientWidth - 80) / 2,
        loadComplete : function ()
        {
            if ($("#editgrid_three tr.jqgrow[id='1']").html() == "") {
                return false;
            }
            //查询后，默认选中第一条
            $("#editgrid_three").setSelection('1');
            $("#editgrid_three").focus();
            //新老数据主键不一样，这如何处理?
            var editinfo = $("#editinfo").val();
            var deleteinfo = $("#deleteinfo").val();
            addRowOperBtn('editgrid_three', '<img src="style/images/public/ltubiao_01.gif" alt="' + editinfo + '"/>', 
            'queryThreeInfo', 'DeviceNo', 'click', 1);
            addRowOperBtn('editgrid_three', '<img src="style/images/public/ltubiao_02.gif" alt="' + deleteinfo + '"/>', 
            'deleteThree', 'DeviceNo', 'click', 2);
            executeAddBtn('editgrid_three', 2);
        }
    }).navGrid('#pagered_three', {
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
    
    
    
     var urlstr_four = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xml', //返回数据格式 
        tsdpk : 'lineDeviceManager.queryfour', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'lineDeviceManager.queryfourpage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
   
    var thefieldalias = fetchFieldAlias('air_devicetype_sub', '<%=languageType %>');
    var devicenof = thefieldalias['DeviceNo'];
    var devicetypef = thefieldalias['DeviceType'];
    var mkjf = thefieldalias['mokuaiju'];
    var deviceiconf = thefieldalias['DeviceIcon'];
    $('#DeviceTypee_f').html(devicetypef);
    $('#mokuaijuu_f').html(mkjf);
    //var thetwodevice = $('#twodevice').val();
    
    jQuery("#editgrid_four").jqGrid(
    {
        datatype : 'xml', 
        colNames : ['修改|删除', devicenof, devicetypef, mkjf, devicememo], 
        colModel : [ {
          	name : 'viewOperation', index : 'viewOperation', width : 90
        },
        //如果有操作列 请勿更改或者删除
        {
            name : 'DeviceNo', index : 'DeviceNo'
        },
        {
            name : 'DeviceType', index : 'DeviceType'
        },
        {
            name : 'mokuaiju', index : 'mokuaiju'
        },        
        {
            name : 'memo', index : 'memo'
        } 
        ], 
        rowNum : 10, //默认分页行数
        rowList : [10, 15, 20], //可选分页行数
        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images//', 
        pager : jQuery('#pagered_four'), 
        sortname : 'DeviceType', 
        //默认排序字段
        viewrecords : true, sortorder : 'asc', //默认排序方式 
        caption : '设备模块信息列表', height : 110, //高 
        width : (document.documentElement.clientWidth - 80) / 2,
        loadComplete : function ()
        {
            if ($("#editgrid_four tr.jqgrow[id='1']").html() == "") {
                return false;
            }
            //查询后，默认选中第一条
            $("#editgrid_four").setSelection('1');
            $("#editgrid_four").focus();
            //新老数据,主键不一样，这如何处理?
            var editinfo = $("#editinfo").val();
            var deleteinfo = $("#deleteinfo").val();
            addRowOperBtn('editgrid_four', '<img src="style/images/public/ltubiao_01.gif" alt="' + editinfo + '"/>', 
            'queryFourInfo', 'DeviceNo', 'click', 1);
            addRowOperBtn('editgrid_four', '<img src="style/images/public/ltubiao_02.gif" alt="' + deleteinfo + '"/>', 
            'deleteFour', 'DeviceNo', 'click', 2);
            executeAddBtn('editgrid_four', 2);
            /*
            $("#DeviceType_f").val("");
            $("#thismokuaiju_f").val("");
            $("#DeviceNo2_f").val("");
            */
        },
        onSelectRow : function (ids) 
        {
            if (ids != null) 
            {
                var DeviceNo = '';
                var DeviceType = '';
                DeviceType = $("#editgrid_four").getCell(ids, "DeviceType");
                $("#DeviceType_f").val(DeviceType);
                mokuaiju = $("#editgrid_four").getCell(ids, "mokuaiju");
                $("#thismokuaiju_f").val(mokuaiju);
                DeviceNo = $("#editgrid_four").getCell(ids, "DeviceNo");
                
                $("#DeviceNo2_f").val(DeviceNo);                
                DeviceNo = tsd.encodeURIComponent(DeviceNo);                
                $("#editgrid_three").setGridParam(
                {
                    url : "mainServlet.html?" + urlstr_three + "&DeviceNo=" + DeviceNo + '&lan=<%=languageType %>'
                }).trigger('reloadGrid');
                
            }
        }
    }).navGrid('#pagered_four', {
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
/**********************************
            **    在初始化页面的时候将面板加载进来 **
            **********************************/
$(document).ready(function ()
{
    //参数为你要验证的表单的id 
    //myValidate("oneform");
    //myValidate("twoform");
    //myValidate("threeform");
    $("#saveone").show();
    $("#savetwo").show();
    $("#savethree").show();
    $("#modifyone").hide();
    $("#modifytwo").hide();
    $("#modifythree").hide();
});
//弹出添加面板
function openText(str)
{
	if(str=="twoform"){
		var DeviceNokey = $("#DeviceNo").val();
		if(DeviceNokey==""){
			alert("请选择路由名称！");
			return false;
		}
	}else if(str=="threeform"||str=="batchaddform"){
		var DeviceNo2key = $("#DeviceNo2_f").val();
		if(DeviceNo2key==""){
			alert("请选择设备模块！");
			return false;
		}
	}else if(str=="fourform"){
		var DeviceNo2key = $("#DeviceNo2").val();
		if(DeviceNo2key==""){
			alert("请选择设备！");
			return false;
		}
	}
	
	$('#operflag').val('');
    var addinfo = $("#addinfo").val();
    
    $("#saveoneadd").show();
    $("#savetwoadd").show();
    $("#savethreeadd").show();
    $("#savefouradd").show();
    $("#saveoneexit").show();
    $("#savetwoexit").show();
    $("#savethreeexit").show();
    $("#savefourexit").show();
    $('#trhide1').hide();
    $('#trhide2').hide();
    $('#trhide3').hide();
    $('#trhide4').hide();
    $("#modifyone").hide();
    $("#modifytwo").hide();
    $("#modifythree").hide();
    $("#modifyfour").hide();
    
    $('#loadingtable').hide();
    $('#tdivs').show();
    //弹出查询面板
    autoBlockForm(str, 20, 'close' + str, "#ffffff", false);
    clearText(str + "s");
    if(str=="fourform"){
    	 $("#mokuaiju_f").val($("#thismokuaiju").val());
    }
    //隐藏错误信息
    hideError();     
}
//添加完成，进行数据交互即保存
function saveInfo(str, thesave)
{
    var thissql = '';
    var params = '';
    var tsdpk = '';
    var tsdpksql = '';
    var gridid = '';
    var DeviceNostr = '';
    //记录日志信息
    var theloginfo = '';
    var thefieldalias = fetchFieldAlias('air_device', '<%=languageType %>');
    var theno = tsd.encodeURIComponent(thefieldalias['DeviceNo']);
    var thename = tsd.encodeURIComponent(thefieldalias['DeviceName']);
    var theicon = tsd.encodeURIComponent(thefieldalias['DeviceIcon']);
    var mokuaiju = tsd.encodeURIComponent(thefieldalias['mokuaiju']);
    if (str == 1)
    {
        theloginfo += tsd.encodeURIComponent('<fmt:message key="line.addone" />:');
        var DeviceName = $('#thisDeviceName').val();
        var NodeSects = $('#NodeSects').val();
        
        if (DeviceName == '' || DeviceName == null) {
            alert('请输入设备名称!');
            $('#thisDeviceName').focus();
            return false;
        }
        var DeviceNo = '';
        var thisno = getDeviceNo(1, 3, 'Air_Device', DeviceNo);
        if (thisno == 'null') {
            thisno = 0;
        }
        thisno = thisno * 1 + 1 * 1;
        var FieldName = 'Value' + thisno;
        thisno = thisno + '';
        if (thisno.length == 1) {
            thisno = '00' + thisno;
        }
        else if (thisno.length == 2) {
            thisno = '0' + thisno;
        }
        DeviceNo = thisno;
        var DeviceIcon = $('#DeviceIcon' + str).val();
       /**
      	//去掉设备图标必填要求
        if(DeviceIcon==''){
        	alert('请选择设备图标');
        	$('#DeviceIcon' + str).focus();
        	return;
        }
       */
        if (NodeSects == '') {
            alert('请选择设备归属!');
            $('#NodeSects').focus();
            return false;
        }
        params += "&DeviceName=" + tsd.encodeURIComponent(DeviceName);
        params += "&DeviceNo=" + tsd.encodeURIComponent(DeviceNo);
        params += "&FieldName=" + tsd.encodeURIComponent(FieldName);
        params += "&DeviceIcon=" + DeviceIcon;
        params += "&NodeSects=" + NodeSects;
        
        thissql = 'lineDeviceManager.saveone';
        tsdpk = 'lineDeviceManager.queryone';
        tsdpksql = 'lineDeviceManager.queryonepage';
        gridid = 'editgrid_one';
        theloginfo += theno + ':' + tsd.encodeURIComponent(DeviceNo) + ',';
        theloginfo += thename + ':' + tsd.encodeURIComponent(DeviceName) + ',';
        theloginfo += theicon + ':' + tsd.encodeURIComponent(DeviceIcon);
    }
    else if (str == 2)
    {
        var thealias = fetchFieldAlias('air_devicetype', '<%=languageType %>');
        var DeviceType = $('#thisDeviceType').val();
        if (DeviceType == '' || DeviceType == null) {
            alert('请输入设备类型!');
            $('#thisDeviceType').focus();
            return false;
        }
        var DeviceNo = '';
        DeviceNostr = $('#DeviceNo').val();
        var thisno = getDeviceNo(5, 4, 'Air_DeviceType', DeviceNostr);
        if (thisno == 'null') {
            thisno = 0;
        }
        thisno = thisno * 1 + 1 * 1;
        thisno = thisno + '';
        if (thisno.length == 1) {
            thisno = '000' + thisno;
        }
        else if (thisno.length == 2) {
            thisno = '00' + thisno;
        }
        else if (thisno.length == 3) {
            thisno = '0' + thisno;
        }
        DeviceNo = DeviceNostr + '.' + thisno;
        var mokuaiju = $('#mokuaiju').val();
        if(mokuaiju=='0'){
        	alert('请选择模块局');
        	$('#mokuaiju').focus();
        	return;
        }
        var DeviceIcon = $('#DeviceIcon' + str).val();
        /**
        //去掉设备图标必填要求
        if(DeviceIcon==''){
        	alert('请选择设备图标');
        	$('#DeviceIcon' + str).focus();
        	return;
        }
        */
        params += "&DeviceType=" + tsd.encodeURIComponent(DeviceType);
        params += "&DeviceNo=" + tsd.encodeURIComponent(DeviceNo);
        params += "&mokuaiju=" + tsd.encodeURIComponent(mokuaiju);
        params += "&DeviceIcon=" + DeviceIcon;
        thissql = 'lineDeviceManager.savetwo';
        tsdpk = 'lineDeviceManager.querytwo';
        tsdpksql = 'lineDeviceManager.querytwopage';
        gridid = 'editgrid_two';
        theloginfo += tsd.encodeURIComponent('<fmt:message key="line.addtwo" />:');
        theloginfo += theno + ':' + tsd.encodeURIComponent(DeviceNo) + ',';
        theloginfo += tsd.encodeURIComponent(thealias['DeviceType']) + ':' + tsd.encodeURIComponent(DeviceType) + ',';
        theloginfo += tsd.encodeURIComponent(thealias['mokuaiju']) + ':' + tsd.encodeURIComponent(mokuaiju) + ',';
        theloginfo += theicon + ':' + tsd.encodeURIComponent(DeviceIcon);
    }
    else if (str == 3)
    {
        var themx = fetchFieldAlias('air_devicemx', '<%=languageType %>');
        var NodeName = $('#NodeName').val();
        if (NodeName == '' || NodeName == null) {
            alert('请输入端子名称!');
            $('#NodeName').focus();
            return false;
        }
        var DeviceNo = '';
        DeviceNostr = $('#DeviceNo2_f').val();
        var thisno = getDeviceNo(15, 5, 'Air_DeviceMx', DeviceNostr);
        if (thisno == 'null') {
            thisno = 0;
        }
        thisno = thisno * 1 + 1 * 1;
        thisno = thisno + '';
        if (thisno.length == 1) {
            thisno = '0000' + thisno;
        }
        else if (thisno.length == 2) {
            thisno = '000' + thisno;
        }
        else if (thisno.length == 3) {
            thisno = '00' + thisno;
        }
        else if (thisno.length == 4) {
            thisno = '0' + thisno;
        }
        DeviceNo = DeviceNostr + '.' + thisno;
        var DeviceName = $('#DeviceName').val();
        var DeviceType = $('#DeviceType').val();
        var NodeState = $('#NodeState').val();
        var Multiplexing = $('#Multiplexing3').val();
        var dh = $("#dh").val().replace(/(^\s*)|(\s*$)/g,"");
        if(NodeState==''){
        	alert('请选择端子状态');
        	$('#NodeState').focus();
        	return;
        }
        var DeviceIcon = $('#DeviceIcon' + str).val();
        /**
        //去掉设备图标必填要求
        if(DeviceIcon==''){
        	alert('请选择设备图标');
        	$('#DeviceIcon' + str).focus();
        	return;
        }
        */
        var mokuaiju = $('#thismokuaiju').val();
        params += "&DeviceName=" + tsd.encodeURIComponent(DeviceName);
        params += "&DeviceType=" + tsd.encodeURIComponent(DeviceType);
        params += "&NodeName=" + tsd.encodeURIComponent(NodeName);
        params += "&NodeState=" + tsd.encodeURIComponent(NodeState);
        params += "&DeviceNo=" + tsd.encodeURIComponent(DeviceNo);
        params += "&mokuaiju=" + tsd.encodeURIComponent(mokuaiju);
		params += "&dh_phone=" + tsd.encodeURIComponent(dh);
        params += "&DeviceIcon=" + DeviceIcon;
        params += "&Multiplexing=" + Multiplexing;
        thissql = 'lineDeviceManager.savethree';
        tsdpk = 'lineDeviceManager.querythree';
        tsdpksql = 'lineDeviceManager.querythreepage';
        gridid = 'editgrid_three';
        theloginfo += tsd.encodeURIComponent('<fmt:message key="line.addthree" />:');
        theloginfo += theno + ':' + tsd.encodeURIComponent(DeviceNo) + ',';
        theloginfo += thename + ':' + tsd.encodeURIComponent(DeviceName) + ',';
        theloginfo += tsd.encodeURIComponent(themx['DeviceType']) + ':' + tsd.encodeURIComponent(DeviceType) + ',';
        theloginfo += tsd.encodeURIComponent(themx['NodeName']) + ':' + tsd.encodeURIComponent(NodeName) + ',';
        theloginfo += tsd.encodeURIComponent(themx['NodeState']) + ':' + tsd.encodeURIComponent(NodeState) + ',';
        theloginfo += tsd.encodeURIComponent(themx['MoKuaiJu']) + ':' + tsd.encodeURIComponent(mokuaiju) + ',';
        theloginfo += tsd.encodeURIComponent(themx['DeviceIcon']) + ':' + tsd.encodeURIComponent(DeviceIcon);
        theloginfo += tsd.encodeURIComponent('可复用') + ':' + tsd.encodeURIComponent(Multiplexing);
    }else if (str == 4)
    {       
        var DeviceType = $('#thisDeviceType_f').val();
        if (DeviceType == '' || DeviceType == null) {
            alert('请输入设备类型!');
            $('#thisDeviceType_f').focus();
            return false;
        }
        
        // 计算设备模块编号
        var DeviceNo = '';
        DeviceNostr = $('#DeviceNo2').val();
        var thisno = getDeviceNo(10, 4, 'Air_DeviceType_sub', DeviceNostr);
        if (thisno == 'null') {
            thisno = 0;
        }
        thisno = thisno * 1 + 1 * 1;
        thisno = thisno + '';
        if (thisno.length == 1) {
            thisno = '000' + thisno;
        }
        else if (thisno.length == 2) {
            thisno = '00' + thisno;
        }
        else if (thisno.length == 3) {
            thisno = '0' + thisno;
        }
        DeviceNo = DeviceNostr + '.' + thisno;
        
        var mokuaiju = $('#mokuaiju_f').val();
        
        params += "&DeviceNo=" + tsd.encodeURIComponent(DeviceNo);
        params += "&mokuaiju=" + tsd.encodeURIComponent(mokuaiju);
        params += "&DeviceType=" + tsd.encodeURIComponent(DeviceType);
        thissql = 'lineDeviceManager.savefour';
        tsdpk = 'lineDeviceManager.queryfour';
        tsdpksql = 'lineDeviceManager.queryfourpage';
        gridid = 'editgrid_four';        
        
        theloginfo += tsd.encodeURIComponent('<fmt:message key="line.addtwo" />:');
        theloginfo += theno + ':' + tsd.encodeURIComponent(DeviceNo) + ',';
        theloginfo += tsd.encodeURIComponent($("#DeviceTypee_f").text()) + ':' + tsd.encodeURIComponent(DeviceType) + ',';
        theloginfo += tsd.encodeURIComponent($("#mokuaijuu_f").text()) + ':' + tsd.encodeURIComponent(mokuaiju) + ',';
    }
    writeLogInfo('', 'add', theloginfo);
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : thissql//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    var dismemo = $('#memo' + str).val();   
    if(str==4){
	    dismemo = $('#memo2_f').val();
    }
    params += '&memo=' + tsd.encodeURIComponent(dismemo);
    urlstr += params;
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&lan=<%=languageType %>', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (msg)
        {
            if (msg == "true")
            {
                var operationtips = $("#operationtips").val();
                var successful = $("#successful").val();
                alert(successful, operationtips);
                if (thesave == 1)
                {
                    if (str == 1) {
                        clearText('oneforms');
                        $('#DeviceName').focus();
                    }
                    else if (str == 2) {
                        clearText('twoforms');
                        $('#DeviceType').focus();
                    }
                    else if (str == 3) {
                        clearText('threeforms');
                        $('#NodeName').focus();
                    }
                    else if (str == 4) {
                        clearText('fourforms');
                        $("#mokuaiju_f").val($("#thismokuaiju").val());
                        $('#DeviceType_f').focus();
                    }
                }
                else if (thesave == 2) {
                    setTimeout($.unblockUI, 15);
                    reloadThisData(tsdpk, tsdpksql, gridid, DeviceNostr);
                }
            }
        }
    });
}
//修改路由信息
function queryOneInfo(key)
{
    var editdevice = $('#editdeviceright').val();
    if (editdevice == 'true')
    {
    	$('#operflag').val(1);
    	
        var editinfo = $("#editinfo").val();
        $('#onefromtitle').html(editinfo);
        $("#modifyone").show();
        $("#saveoneadd").hide();
        $("#saveoneexit").hide();
        hideError();
        //隐藏错误信息 
        clearText('oneforms');
        $("#oneDeviceNo").val(key);
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
            tsdpk : 'lineDeviceManagerOne.queryByKey' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax(
        {
            url : 'mainServlet.html?' + urlstr + '&DeviceNo=' + key, datatype : 'xml', cache : false, 
            //如果值变化可能性比较大 一定要将缓存设成false
            timeout : 1000, async : false , //同步方式
            success : function (xml)
            {
                $(xml).find('row').each(function ()
                {
                    var DeviceName = $(this).attr("devicename");
                    var DeviceIcon = $(this).attr("deviceicon");
                    var NodeSects = $(this).attr("nodesects");
                    
                    var memo = $(this).attr("memo");
                    $("#memo1").val(memo);
                    $("#thisDeviceName").val(DeviceName);
                    $("#DeviceIcon1").val(DeviceIcon);
                    $("#NodeSects").val(NodeSects);
                    $('#trhide1').hide();
                    $('#theairdevicevalue').val(DeviceName + ',' + DeviceIcon);
                });
                autoBlockForm('oneform', 20, 'closeoneform', "#ffffff", false);
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
function queryTwoInfo(key)
{
    var editdevicetype = $('#editdevicetyperight').val();
    if (editdevicetype == 'true')
    {
    	$('#operflag').val(1);
    	
        var editinfo = $("#editinfo").val();
        $('#twofromtitle').html(editinfo);
        $("#modifytwo").show();
        $("#savetwoadd").hide();
        $("#savetwoexit").hide();
        hideError();
        //隐藏错误信息 
        clearText('twoforms');
        $("#twoDeviceNo").val(key);
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
            tsdpk : 'lineDeviceManagerTwo.queryByKey' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax(
        {
            url : 'mainServlet.html?' + urlstr + '&DeviceNo=' + key, datatype : 'xml', cache : false, 
            //如果值变化可能性比较大 一定要将缓存设成false
            timeout : 1000, async : false , //同步方式
            success : function (xml)
            {
                $(xml).find('row').each(function ()
                {
                    var DeviceType = $(this).attr("devicetype");
                    var mokuaiju = $(this).attr("mokuaiju");
                    var DeviceIcon = $(this).attr("deviceicon");
                    var memo = $(this).attr("memo");
                    $("#memo2").val(memo);
                    $("#thisDeviceType").val(DeviceType);
                    $("#mokuaiju").val(mokuaiju);
                    $("#DeviceIcon2").val(DeviceIcon);
                    $('#trhide2').hide();
                    $('#theairdevicetypevalue').val(DeviceType + ',' + mokuaiju + ',' + DeviceIcon);
                });
                autoBlockForm('twoform', 20, 'closetwoform', "#ffffff", false);
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
function queryThreeInfo(key)
{
    var editnodename = $('#editnodenameright').val();
    if (editnodename == 'true')
    {
    	$('#operflag').val(1);
        var editinfo = $("#editinfo").val();
        $('#threefromtitle').html(editinfo);
        $("#modifythree").show();
        $("#savethreeadd").hide();
        $("#savethreeexit").hide();
        hideError();
        //隐藏错误信息 
        clearText('threeforms');
        $("#threeDeviceNo").val(key);
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
            tsdpk : 'lineDeviceManagerThree.queryByKey' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax(
        {
            url : 'mainServlet.html?' + urlstr + '&DeviceNo=' + key, datatype : 'xml', cache : false, 
            //如果值变化可能性比较大 一定要将缓存设成false
            timeout : 1000, async : false , //同步方式
            success : function (xml)
            {
                $(xml).find('row').each(function ()
                {
                    var NodeName = $(this).attr("nodename");
                    var NodeState = $(this).attr("nodestate");
                    var DeviceIcon = $(this).attr("deviceicon");
                    var memo = $(this).attr("memo");
                    var Multiplexing = $(this).attr("multiplexing");
					var dh = $(this).attr("dh");
                    $("#memo3").val(memo);
                    $("#NodeName").val(NodeName);
                    $("#NodeState").val(NodeState);
                    $("#DeviceIcon3").val(DeviceIcon);
                    $("#Multiplexing3").val(Multiplexing);
					$("#dh").val(dh);
                    $('#trhide3').hide();
                    $('#theairdevicemxvalue').val(NodeName + ',' + NodeState + ',' + DeviceIcon);
                });
                autoBlockForm('threeform', 20, 'closethreeform', "#ffffff", false);
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

function queryFourInfo(key)
{
    var editdevicetype = $('#editdevicetyperight').val();
    if (editdevicetype == 'true')
    {
    	$('#operflag').val(1);
    	
        var editinfo = $("#editinfo").val();
        $('#fourfromtitle').html(editinfo);
        $("#modifyfour").show();
        $("#savefouradd").hide();
        $("#savefourexit").hide();
        hideError();
        //隐藏错误信息 
        clearText('fourforms');
        $("#fourDeviceNo").val(key);
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
            tsdpk : 'lineDeviceManagerFour.queryByKey' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax(
        {
            url : 'mainServlet.html?' + urlstr + '&DeviceNo=' + key, datatype : 'xml', cache : false, 
            //如果值变化可能性比较大 一定要将缓存设成false
            timeout : 1000, async : false , //同步方式
            success : function (xml)
            {
                $(xml).find('row').each(function ()
                {
                    var DeviceType = $(this).attr("devicetype");
                    var mokuaiju = $(this).attr("mokuaiju");
                    var memo = $(this).attr("memo");
                    $("#memo2_f").val(memo);
                    $("#thisDeviceType_f").val(DeviceType);
                    $("#mokuaiju_f").val(mokuaiju);
                     $('#theairdevicetypevalue').val(DeviceType + ',' + mokuaiju + ',' + memo);
                });
                autoBlockForm('fourform', 20, 'closefourform', "#ffffff", false);
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

//将修改后的信息保存起来
function editFourInfo()
{
    var DeviceType = $('#thisDeviceType_f').val();
    var mokuaiju = $('#mokuaiju_f').val();
    key = $("#fourDeviceNo").val();
    var theairdevicetype = $('#theairdevicetypevalue').val();
    var thearr = theairdevicetype.split(',');
    var theloginfo = tsd.encodeURIComponent('(air_devicetype)修改三级设备" />：');
    if (thearr[0] != DeviceType)
    {
        theloginfo += tsd.encodeURIComponent($("#DeviceTypee_f").text()) + ':' + tsd.encodeURIComponent(thearr[0]) + '>>>' + tsd.encodeURIComponent(DeviceType) + ',';
    }
    if (thearr[1] != mokuaiju)
    {
        theloginfo += tsd.encodeURIComponent($("#mokuaijuu_f").text()) + ':' + tsd.encodeURIComponent(thearr[1]) + '>>>' + tsd.encodeURIComponent(mokuaiju) + ',';
    }
    writeLogInfo('', 'modify', theloginfo);
    ///设置命令参数
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : 'lineDeviceManagerFour.edit'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&DeviceNo=' + key + '&DeviceType=' + tsd.encodeURIComponent(DeviceType) + '&mokuaiju=' + tsd.encodeURIComponent(mokuaiju) + '&memo=' + tsd.encodeURIComponent($('#memo2_f').val()), 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
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
                DeviceNostr = $('#DeviceNo2').val();
                reloadThisData('lineDeviceManager.queryfour', 'lineDeviceManager.queryfourpage', 'editgrid_four', 
                DeviceNostr);
            }
        }
    });
}
//将修改后的信息保存起来
function editOneInfo()
{
    var DeviceName = $('#thisDeviceName').val();
    var DeviceIcon = $('#DeviceIcon1').val();
    var NodeSects = $('#NodeSects').val();
    if(DeviceName==''){
    	alert('请输入设备名称!');
    	$('#thisDeviceName').focus();
    	return;
    }
    /** 
    //去掉设备图标必填要求
    if(DeviceIcon==''){
    	alert('请选择设备图标!');
    	$('#DeviceIcon1').focus();
    	return;
    }
    */
    if(NodeSects==0){
    	alert('请选择设备归属!');
    	$('#NodeSects').focus();
    	return;
    }
    key = $("#oneDeviceNo").val();
    var theairdevice = $('#theairdevicevalue').val();
    var thearr = theairdevice.split(',');
    var theloginfo = tsd.encodeURIComponent('(air_device)<fmt:message key="line.editone" />：');
    var theinfo = fetchFieldAlias('air_device', '<%=languageType %>');
    if (thearr[0] != DeviceName)
    {
        theloginfo += tsd.encodeURIComponent(theinfo['DeviceName']) + ':' + thearr[0] + '>>>' + tsd.encodeURIComponent(DeviceName) + ',';
    }
    if (thearr[1] != DeviceIcon)
    {
        theloginfo += tsd.encodeURIComponent(theinfo['DeviceIcon']) + ':' + thearr[1] + '>>>' + tsd.encodeURIComponent(DeviceIcon);
    }
    writeLogInfo('', 'modify', theloginfo);
    ///设置命令参数
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : 'lineDeviceManagerOne.edit'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&DeviceNo=' + key + '&DeviceName=' + tsd.encodeURIComponent(DeviceName) + '&DeviceIcon=' + DeviceIcon + '&NodeSects=' + NodeSects + '&memo=' + tsd.encodeURIComponent($('#memo1').val()), 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
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
                reloadThisData('lineDeviceManager.queryone', 'lineDeviceManager.queryonepage', 'editgrid_one', 
                '');
            }
        }
    });
}
//将修改后的信息保存起来
function editTwoInfo()
{
    var DeviceType = $('#thisDeviceType').val();
    var mokuaiju = $('#mokuaiju').val();
    var DeviceIcon = $('#DeviceIcon2').val();
    key = $("#twoDeviceNo").val();
    var theairdevicetype = $('#theairdevicetypevalue').val();
    var thearr = theairdevicetype.split(',');
    var theloginfo = tsd.encodeURIComponent('(air_devicetype)<fmt:message key="line.edittwo" />：');
    var theinfo = fetchFieldAlias('air_devicetype', '<%=languageType %>');
    if (thearr[0] != DeviceType)
    {
        theloginfo += tsd.encodeURIComponent(theinfo['DeviceType']) + ':' + thearr[0] + '>>>' + tsd.encodeURIComponent(DeviceType) + ',';
    }
    if (thearr[1] != mokuaiju)
    {
        theloginfo += tsd.encodeURIComponent(theinfo['mokuaiju']) + ':' + thearr[1] + '>>>' + tsd.encodeURIComponent(mokuaiju) + ',';
    }
    if (thearr[2] != DeviceIcon)
    {
        theloginfo += tsd.encodeURIComponent(theinfo['DeviceIcon']) + ':' + thearr[2] + '>>>' + tsd.encodeURIComponent(DeviceIcon);
    }
    writeLogInfo('', 'modify', theloginfo);
    ///设置命令参数
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : 'lineDeviceManagerTwo.edit'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&DeviceNo=' + key + '&DeviceType=' + tsd.encodeURIComponent(DeviceType) + '&mokuaiju=' + tsd.encodeURIComponent(mokuaiju) + '&DeviceIcon=' + DeviceIcon + '&memo=' + tsd.encodeURIComponent($('#memo2').val()), 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
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
                DeviceNostr = $('#DeviceNo').val();
                reloadThisData('lineDeviceManager.querytwo', 'lineDeviceManager.querytwopage', 'editgrid_two', 
                DeviceNostr);
            }
        }
    });
}
//将修改后的信息保存起来
function editThreeInfo()
{
    var NodeName = $('#NodeName').val();
    var NodeState = $('#NodeState').val();
    var DeviceIcon = $('#DeviceIcon3').val();
    var Multiplexing = $("#Multiplexing3").val();
	var dh = $("#dh").val().replace(/(^\s*)|(\s*$)/g,"");
    key = $("#threeDeviceNo").val();
    var theairdevicemx = $('#theairdevicemxvalue').val();
    var thearr = theairdevicemx.split(',');
    var theloginfo = tsd.encodeURIComponent('(air_devicemx)<fmt:message key="line.editthree" />：');
    var theinfo = fetchFieldAlias('air_devicemx', '<%=languageType %>');
    if (thearr[0] != NodeName)
    {
        theloginfo += tsd.encodeURIComponent(theinfo['NodeName']) + ':' + thearr[0] + '>>>' + tsd.encodeURIComponent(NodeName) + ',';
    }
    if (thearr[1] != NodeState)
    {
        theloginfo += tsd.encodeURIComponent(theinfo['NodeState']) + ':' + thearr[1] + '>>>' + tsd.encodeURIComponent(NodeState) + ',';
    }
    if (thearr[2] != DeviceIcon)
    {
        theloginfo += tsd.encodeURIComponent(theinfo['DeviceIcon']) + ':' + thearr[2] + '>>>' + tsd.encodeURIComponent(DeviceIcon);
    }
    writeLogInfo('', 'modify', theloginfo);
    ///设置命令参数
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : 'lineDeviceManagerThree.edit'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&DeviceNo=' + key + '&NodeName=' + tsd.encodeURIComponent(NodeName) + '&NodeState=' + tsd.encodeURIComponent(NodeState) + '&DeviceIcon=' + DeviceIcon +'&Multiplexing='+Multiplexing+ '&memo=' + tsd.encodeURIComponent($('#memo3').val())+'&dh_phone='+dh, 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
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
                DeviceNostr = $('#DeviceNo2').val();
                reloadThisData('lineDeviceManager.querythree', 'lineDeviceManager.querythreepage', 'editgrid_three', 
                DeviceNostr);
            }
        }
    });
}
/**********************
*  当前设备是否有二级设备
*
*/
function queryForDelete(tablename, DeviceNo)
{
    var num = 0;
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'lineDeviceManagerThree.queryfordelete' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&tablename=' + tablename + '&DeviceNo=' + DeviceNo, datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                num = $(this).attr("num");
            });
        }
    });
    return num;
}
//获取删除的信息
function getTheDeleteInfo(theno, tablename, type)
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
        tsdpk : 'lineDeviceManager.queryByKey' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&DeviceNo=' + theno + '&tablename=' + tablename, 
        datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var DeviceIcon = $(this).attr("deviceicon");
                var delinfo = '';
                if (type == 1)
                {
                    var theinfo = fetchFieldAlias('air_device', '<%=languageType %>');
                    var DeviceName = $(this).attr("devicename");
                    delinfo += tsd.encodeURIComponent(theinfo['DeviceName']) + ':' + tsd.encodeURIComponent(DeviceName) + ';' ;
                    delinfo += tsd.encodeURIComponent(theinfo['DeviceIcon']) + ':' + tsd.encodeURIComponent(DeviceIcon) + ';' ;
                }
                else if (type == 2)
                {
                    var theinfo = fetchFieldAlias('air_devicetype', '<%=languageType %>');
                    var DeviceType = $(this).attr("devicetype");
                    var mokuaiju = $(this).attr("mokuaiju");
                    delinfo += tsd.encodeURIComponent(theinfo['DeviceType']) + ':' + tsd.encodeURIComponent(DeviceType) + ';' ;
                    delinfo += tsd.encodeURIComponent(theinfo['mokuaiju']) + ':' + tsd.encodeURIComponent(mokuaiju) + ';' ;
                    delinfo += tsd.encodeURIComponent(theinfo['DeviceIcon']) + ':' + tsd.encodeURIComponent(DeviceIcon) + ';' ;
                }
                else if (type == 3)
                {
                    var theinfo = fetchFieldAlias('air_devicemx', '<%=languageType %>');
                    var DeviceName = $(this).attr("devicename");
                    var DeviceType = $(this).attr("devicetype");
                    var NodeName = $(this).attr("nodename");
                    var NodeState = $(this).attr("nodestate");
                    var MoKuaiJu = $(this).attr("moKuaiju");
                    delinfo += tsd.encodeURIComponent(theinfo['DeviceName']) + ':' + tsd.encodeURIComponent(DeviceName) + ';' ;
                    delinfo += tsd.encodeURIComponent(theinfo['DeviceType']) + ':' + tsd.encodeURIComponent(DeviceType) + ';' ;
                    delinfo += tsd.encodeURIComponent(theinfo['NodeName']) + ':' + tsd.encodeURIComponent(NodeName) + ';' ;
                    delinfo += tsd.encodeURIComponent(theinfo['NodeState']) + ':' + tsd.encodeURIComponent(NodeState) + ';' ;
                    delinfo += tsd.encodeURIComponent(theinfo['MoKuaiJu']) + ':' + tsd.encodeURIComponent(MoKuaiJu) + ';' ;
                    delinfo += tsd.encodeURIComponent(theinfo['DeviceIcon']) + ':' + tsd.encodeURIComponent(DeviceIcon) + ';' ;
                }
                 else if (type == 4)
                {
                    var theinfo = fetchFieldAlias('air_devicetype', '<%=languageType %>');
                    var DeviceType = $(this).attr("devicetype");
                    var mokuaiju = $(this).attr("mokuaiju");
                    delinfo += tsd.encodeURIComponent(theinfo['DeviceType']) + ':' + tsd.encodeURIComponent(DeviceType) + ';' ;
                    delinfo += tsd.encodeURIComponent(theinfo['mokuaiju']) + ':' + tsd.encodeURIComponent(mokuaiju) + ';' ;
                }
                writeLogInfo('', 'delete', tsd.encodeURIComponent("<fmt:message key='global.delete'/>") + tsd.encodeURIComponent("<fmt:message key='line.thedevice' />：") + theno + tsd.encodeURIComponent("<fmt:message key='usermanager.info'/>：") + delinfo);
            });
        }
    });
}
/**************************
**   查询当前用户的详细地址   *
************************/
function queryTheDeleteValue(key)
{
    var theValue = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'userLineManager.getTheDeleteValue'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&DeviceNo=' + tsd.encodeURIComponent(key), 
        datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                theValue = $(this).attr("fieldname");
            });
        }
    });
    return theValue;
}
/**************************
**   查询当前用户的详细地址    *
************************/
function queryTheLineFields()
{
    var thelinefields = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'userLineManager.getTheLineFields'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var linefields = $(this).attr("linefields");
                var bm = $(this).attr("bm");
                if (undefined != bm) {
                    thelinefields += linefields + '~' + bm + '@';
                }
            });
        }
    });
    return thelinefields;
}

//删除操作 第一个面板设备类型
function deleteOne(key)
{
    var deletedeviceright = $("#deletedeviceright").val();
    /**************************
    *    是否有执行删除的权限    *
    *************************/
    if (deletedeviceright == "true")
    {
        var deleteinformation = $("#deleteinformation").val();
        var operationtips = $("#operationtips").val();
        if (queryForDelete('Air_DeviceType', key) > 0) {
            deleteinformation = $('#isalldelete').val() + '?';
        }
        if(confirm(deleteinformation)) 
        {
            
                //该设备已分配给部门，不可随意删除
                var thevalue = queryTheDeleteValue(key);
                //返回数据格式： Value1,Value2,Value3~系统管理员@
                var thelinefields = queryTheLineFields();
                var theflag = false;
                var flagbm = '';
                if (thelinefields.indexOf('@') !=- 1)
                {
                    var linearr = thelinefields.split('@');
                    for (var i = 0; i < linearr.length; i++)
                    {
                        var lineinfos = linearr[i].split('~');
                        var valarr = lineinfos[0].split(',');
                        var breakflag = false;
                        for (var j = 0 ; j < valarr.length ; j++) {
                            if (valarr[j] == thevalue) {
                                breakflag = true;
                            }
                        }
                        if (breakflag == true) {
                            flagbm = lineinfos[1];
                            theflag = true;
                            break;
                        }
                    }
                }
                if (theflag == false)
                {
                    //
                    getTheDeleteInfo(key, 'air_device', 1);
                    //删除二级设备
                    if (queryForDelete('Air_DeviceType', key) > 0)
                    {
                        //getTheDeleteInfo(key,'air_devicetype',2);
                        beforeDelete('Air_DeviceType', key);
                        //删除三级设备
                        if(queryForDelete('Air_DeviceType_sub', key) > 0){
                        	beforeDelete('Air_DeviceType_sub', key);
                        	//删除四级设备
	                        if (queryForDelete('Air_DeviceMx', key) > 0) {
	                            //getTheDeleteInfo(key,'air_devicemx',3);
	                            beforeDelete('Air_DeviceMx', key);
	                        }
	                    }
                    }
                    var urlstr = tsd.buildParams(
                    {
                        packgname : 'service', //java包
                        clsname : 'ExecuteSql', //类名
                        method : 'exeSqlData', //方法名
                        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
                        tsdcf : 'mssql', //指向配置文件名称
                        tsdoper : 'exe', //操作类型 
                        tsdpk : 'lineDeviceManagerThree.deleteone'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
                    });
                    $.ajax(
                    {
                        url : 'mainServlet.html?' + urlstr + '&DeviceNo=' + key, cache : false, //如果值变化可能性比较大 一定要将缓存设成false
                        timeout : 1000, async : false , //同步方式
                        success : function (msg)
                        {
                            if (msg == "true")
                            {
                                var operationtips = $("#operationtips").val();
                                var successful = $("#successful").val();
                                alert(successful, operationtips);
                                
                                setTimeout($.unblockUI, 15);
                                //刷新第一个jqgrid
                                reloadThisData('lineDeviceManager.queryone', 'lineDeviceManager.queryonepage', 
                                'editgrid_one', '');
                                //刷新第二个jqgrid
                                var DeviceNostr = $('#DeviceNo').val();
                                reloadThisData('lineDeviceManager.querytwo', 'lineDeviceManager.querytwopage', 
                                'editgrid_two', DeviceNostr);
                                //刷新第三个jqgrid
                                var DeviceNostrr = $('#DeviceNo2').val();
                                reloadThisData('lineDeviceManager.queryfour', 'lineDeviceManager.queryfourpage', 
                                'editgrid_four', DeviceNostrr);
                                //刷新第四个jqgrid
                                var DeviceNostrr_f = $('#DeviceNo2_f').val();
                                reloadThisData('lineDeviceManager.querythree', 'lineDeviceManager.querythreepage', 
                                'editgrid_three', DeviceNostrr_f);
                                //同步删除路由表中的信息
                                deleteRouteSect(key);
                            }
                        }
                    });
                }
                else
                {
                    //alert('<fmt:message key="line.theworninfo" />!');
                    alert('对不起，该设备已分配给部门[' + flagbm + ']，不可随意删除!');
                    //
                    return false;
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

//删除设备的同时同步删除路由表中的信息
	//即完整路由信息
function  deleteRouteSect(key){
	var urlstr = tsd.buildParams(
    {
         packgname : 'service', //java包
         clsname : 'ExecuteSql', //类名
         method : 'exeSqlData', //方法名
         ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
         tsdcf : 'mssql', //指向配置文件名称
         tsdoper : 'exe', //操作类型 
         tsdpk : 'lineDeviceManager.deleteroutesect'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
     });
     $.ajax(
     {
         url : 'mainServlet.html?NodeName=' + key + urlstr, cache : false, //如果值变化可能性比较大 一定要将缓存设成false
         timeout : 1000, async : false , //同步方式
         success : function (msg)
         {
             if (msg == "true")
             {
                 
             }
         }
     });

}


function deleteTwo(key)
{
    var deletedevicetyperight = $("#deletedevicetyperight").val();
    /**************************
    *    是否有执行删除的权限    *
    *************************/
    if (deletedevicetyperight == "true")
    {
        var deleteinformation = $("#deleteinformation").val();
        var operationtips = $("#operationtips").val();
         if (queryForDelete('Air_DeviceType_sub', key) > 0) {
            deleteinformation = $('#isalldelete').val() + '?';
        }
        if (confirm(deleteinformation)) 
        {               
               	 //
                 getTheDeleteInfo(key, 'air_devicetype', 2);                 
                  //删除三级设备
                  if(queryForDelete('Air_DeviceType_sub', key) > 0){
                  		beforeDelete('Air_DeviceType_sub', key);
                  		//删除四级设备
                    if (queryForDelete('Air_DeviceMx', key) > 0) {
                        //getTheDeleteInfo(key,'air_devicemx',3);
                        beforeDelete('Air_DeviceMx', key);
                    }
               	}
                                
                var urlstr = tsd.buildParams(
                {
                    packgname : 'service', //java包
                    clsname : 'ExecuteSql', //类名
                    method : 'exeSqlData', //方法名
                    ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
                    tsdcf : 'mssql', //指向配置文件名称
                    tsdoper : 'exe', //操作类型 
                    tsdpk : 'lineDeviceManagerThree.deletetwo'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
                });
                $.ajax(
                {
                    url : 'mainServlet.html?' + urlstr + '&DeviceNo=' + key, cache : false, //如果值变化可能性比较大 一定要将缓存设成false
                    timeout : 1000, async : false , //同步方式
                    success : function (msg)
                    {
                        if (msg == "true")
                        {
                            var operationtips = $("#operationtips").val();
                            var successful = $("#successful").val();
                            alert(successful, operationtips);
                            
                            setTimeout($.unblockUI, 15);
                            //更新第二个jqgrid
                            DeviceNostr = $('#DeviceNo').val();
                            reloadThisData('lineDeviceManager.querytwo', 'lineDeviceManager.querytwopage', 
                            'editgrid_two', DeviceNostr);
                            //更新第三个jqgrid
                            DeviceNostrr = $('#DeviceNo2').val();
                            reloadThisData('lineDeviceManager.queryfour', 'lineDeviceManager.queryfourpage', 
                            'editgrid_four', DeviceNostrr);
                            
                            //更新第四个jqgrid
                             DeviceNostrr = $('#DeviceNo2').val();
                            reloadThisData('lineDeviceManager.querythree', 'lineDeviceManager.querythreepage', 
                            'editgrid_three', DeviceNostrr);
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
function deleteThree(key)
{
    var deletenodenameright = $("#deletenodenameright").val();
    /**************************
                     *    是否有执行删除的权限    *
                     *************************/
    if (deletenodenameright == "true")
    {
        var deleteinformation = $("#deleteinformation").val();
        var operationtips = $("#operationtips").val();
        if (confirm(deleteinformation)) 
        {
            
                getTheDeleteInfo(key, 'air_devicemx', 3);
                var urlstr = tsd.buildParams(
                {
                    packgname : 'service', //java包
                    clsname : 'ExecuteSql', //类名
                    method : 'exeSqlData', //方法名
                    ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
                    tsdcf : 'mssql', //指向配置文件名称
                    tsdoper : 'exe', //操作类型 
                    tsdpk : 'lineDeviceManagerThree.deletethree'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
                });
                $.ajax(
                {
                    url : 'mainServlet.html?' + urlstr + '&DeviceNo=' + key, cache : false, //如果值变化可能性比较大 一定要将缓存设成false
                    timeout : 1000, async : false , //同步方式
                    success : function (msg)
                    {
                        if (msg == "true")
                        {
                            var operationtips = $("#operationtips").val();
                            var successful = $("#successful").val();
                            alert(successful, operationtips);
                            setTimeout($.unblockUI, 15);
                            
                            var DeviceNostr = $('#DeviceNo2_f').val();
                            reloadThisData('lineDeviceManager.querythree', 'lineDeviceManager.querythreepage', 
                            'editgrid_three', DeviceNostr);
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


function deleteFour(key)
{
    var deletedevicetyperight = $("#deletedevicetyperight").val();
    /**************************
    *    是否有执行删除的权限    *
    *************************/
    if (deletedevicetyperight == "true")
    {
        var deleteinformation = $("#deleteinformation").val();
        var operationtips = $("#operationtips").val();
        if (queryForDelete('Air_DeviceMx', key) > 0) {
            deleteinformation = $('#isalldelete').val() + '?';
        }
        if (confirm(deleteinformation)) 
        {
                getTheDeleteInfo(key, 'air_devicetype_sub', 4);
                if (queryForDelete('Air_DeviceMx', key) > 0) {
                    //getTheDeleteInfo(key,'air_devicemx',3);
                    beforeDelete('Air_DeviceMx', key);
                }
                var urlstr = tsd.buildParams(
                {
                    packgname : 'service', //java包
                    clsname : 'ExecuteSql', //类名
                    method : 'exeSqlData', //方法名
                    ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
                    tsdcf : 'mssql', //指向配置文件名称
                    tsdoper : 'exe', //操作类型 
                    tsdpk : 'lineDeviceManagerThree.deletefour'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
                });
                $.ajax(
                {
                    url : 'mainServlet.html?' + urlstr + '&DeviceNo=' + key, cache : false, //如果值变化可能性比较大 一定要将缓存设成false
                    timeout : 1000, async : false , //同步方式
                    success : function (msg)
                    {
                        if (msg == "true")
                        {
                            var operationtips = $("#operationtips").val();
                            var successful = $("#successful").val();
                            alert(successful, operationtips);
                            setTimeout($.unblockUI, 15);
                            
                            var DeviceNostrr = $('#DeviceNo2').val();
                            reloadThisData('lineDeviceManager.queryfour', 'lineDeviceManager.queryfourpage', 
                            'editgrid_four', DeviceNostrr);
                            
                            var DeviceNostr = $('#DeviceNo2_f').val();
                            reloadThisData('lineDeviceManager.querythree', 'lineDeviceManager.querythreepage', 
                            'editgrid_three', DeviceNostr);                            
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
function beforeDelete(tablename, DeviceNo)
{
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : 'lineDeviceManagerThree.beforedelete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&DeviceNo=' + DeviceNo + '&tablename=' + tablename, cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (msg) {}
    });
}
/*********************************
                **             重载信息            **
                ***********************************/
function reloadThisData(tsdpk, tsdpksql, gridid, DeviceNostr)
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
        tsdpk : tsdpk, //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : tsdpksql//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    $("#" + gridid).setGridParam({
        url : 'mainServlet.html?' + urlstr + '&DeviceNo=' + DeviceNostr + '&lan=<%=languageType %>'
    }).trigger("reloadGrid");
    setTimeout($.unblockUI, 15);
    //关闭面板
}
/******************
*  获取最大当前设备号
*/
function getDeviceNo(sta, end, tablename, DeviceNo)
{
    var maxDeviceNo = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'lineDeviceManager.queryDeviceNo' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&tablename=' + tablename + '&sta=' + sta + '&end=' + end + '&DeviceNo=' + DeviceNo, 
        datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                maxDeviceNo = $(this).attr("deviceno");
            });
        }
    });
    return maxDeviceNo;
}
function getMoKuaiJu(id)
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
        tsdpk : 'lineDeviceManager.getMoKuaiJu'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            var thisselect = $("#thisselect").val();
            if(id!='moduleBu')
            {
            	$("#"+id).html("<option value='0'>" + thisselect + "</option>");
            }
            $(xml).find('row').each(function ()
            {
                var area = "<option value='" + $(this).attr("mokuaiju") + "'>" + $(this).attr("mokuaiju") + "</option>";
                $("#"+id).html($("#"+id).html() + area);
            });
        }
    });
}

function disDisplayLoading(){
	$('#loadingtable').hide();
    $('#tdivs').show();
}

//批量添加端口
function batchAddDevice(){
	//必填项验证
    var thisvalue = $('#thisvalue1').val();
    var pleaseinput = $('#pinput').val();
    if (thisvalue == '' || thisvalue == null)
    {
        var operationtips = $("#operationtips").val();
        var fixed = $("#fixed").val();
        alert(pleaseinput + '<fmt:message key="line.fixed" />', operationtips);
        disDisplayLoading();
        $('#thisvalue1').focus();
        return false;
    }
    var stavalue = $('#stavalue1').val();
    if (stavalue == '' || stavalue == null)
    {
        var operationtips = $("#operationtips").val();
        var stavalue = $("#stavalue1").val();
        alert(pleaseinput + '<fmt:message key="line.stavalue" />', operationtips);
        disDisplayLoading();
        $('#stavalue1').focus();
        return false;
    }
    var endvalue = $('#endvalue1').val();
     
    var stavalue01 = parseInt(stavalue);
    var endvalue01 = parseInt(endvalue);
    if (endvalue == '' || endvalue == null)
    {
        var operationtips = $("#operationtips").val();
        var endvalue = $("#endvalue1").val();
        alert(pleaseinput + '<fmt:message key="line.endvalue" />', operationtips);
        disDisplayLoading();
        $('#endvalue1').focus();
        return false;
    }
    else if (endvalue01 <=stavalue01 ||endvalue.length > 5 || endvalue.length < stavalue.length)
    {
        var operationtips = $("#operationtips").val();
        var endworn = $("#endworn").val();
        alert('结束值1 不能小于 开始值1', operationtips);
        disDisplayLoading();
        $('#endvalue1').focus();
        return false;
    }
   //第二层的起始值是否大于截止值
    var stavalue2 = parseInt($('#stavalue2').val()); 
    var endvalue2 = parseInt($('#endvalue2').val());
    if (endvalue2 <=stavalue2 || endvalue2.length < stavalue2.length)
    {
        var operationtips = $("#operationtips").val();
        alert('结束值2 不能小于 开始值2', operationtips);
        disDisplayLoading();
        $('#endvalue2').focus();
        return false;
    } 
    //第三层的起始值是否大于截止值
    var stavalue3 = parseInt($('#stavalue3').val()); 
    var endvalue3 = parseInt($('#endvalue3').val());
    if (endvalue3 <=stavalue3 || endvalue3.length < stavalue3.length)
    {
        var operationtips = $("#operationtips").val();
        alert('结束值3 不能小于 开始值3', operationtips);
        disDisplayLoading();
        $('#endvalue3').focus();
        return false;
    }  
    //第四层的起始值是否大于截止值
    var stavalue4 = parseInt($('#stavalue4').val()); 
    var endvalue4 = parseInt($('#endvalue4').val());
    if (endvalue4 <=stavalue4 || endvalue4.length < stavalue4.length)
    {
        var operationtips = $("#operationtips").val();
        alert('结束值4 不能小于 开始值4', operationtips);
        disDisplayLoading();
        $('#endvalue4').focus();
        return false;
    }   
    
    /**
     //补全倍数
    var addnum = endvalue.length;
    var isadd0 = $('#isadd0').val();
    
    var DeviceIcon4 = $('#DeviceIcon4').val();
    //去掉端口必填要求
    if (DeviceIcon4 == '' || DeviceIcon4 == null)
    {
        var operationtips = $("#operationtips").val();
        var selecticon = $("#selecticon").val();
        alert(selecticon, operationtips);
        disDisplayLoading();
        $('#DeviceIcon4').focus();
        return false;
    }
    */
	$('#loadingtable').show();
    $('#tdivs').hide();
	setTimeout('batchAddDeviceLazy()',1000);
}
//参数拼接
function batchAddBuildParam(){
	var params = '';
	var loginfo = '';
	
	var thisvalue1 = $('#thisvalue1').val();    
    var stavalue1 = $('#stavalue1').val();
    var endvalue1 = $('#endvalue1').val();
    
    var thisvalue2 = $('#thisvalue2').val();    
    var stavalue2 = $('#stavalue2').val();
    var endvalue2 = $('#endvalue2').val();
    
    var thisvalue3 = $('#thisvalue3').val();    
    var stavalue3 = $('#stavalue3').val();
    var endvalue3 = $('#endvalue3').val();
    
    var thisvalue4 = $('#thisvalue4').val();    
    var stavalue4 = $('#stavalue4').val();
    var endvalue4 = $('#endvalue4').val();
    
    //补全倍数
    var addnum1 = endvalue1.length;
    var addnum2 = endvalue2.length;
    var addnum3 = endvalue3.length;
    var addnum4 = endvalue4.length;
    
    var isadd0 = $('#isadd0').val();
    var DeviceIcon4 = $('#DeviceIcon4').val();
    
    var DeviceNo = $('#DeviceNo').val();
    var DeviceNo2 = $('#DeviceNo2').val().substring(4, 8);
	var DeviceNo2_f = $('#DeviceNo2_f').val();
	
	var dismemo = $('#memo4').val();
	var Multiplexing = $("#Multiplexing32").val();
	params += '&Multiplexing=' + tsd.encodeURIComponent(Multiplexing);
	params += '&fixvalue1=' + tsd.encodeURIComponent(thisvalue1);
    params += '&stratv1=' + stavalue1 ;
    params += '&endv1=' + endvalue1 ;
    
    params += '&fixvalue2=' + tsd.encodeURIComponent(thisvalue2);
    params += '&stratv2=' + stavalue2 ;
    params += '&endv2=' + endvalue2 ;
    
    params += '&fixvalue3=' + tsd.encodeURIComponent(thisvalue3);
    params += '&stratv3=' + stavalue3 ;
    params += '&endv3=' + endvalue3 ;
    
    params += '&fixvalue4=' + tsd.encodeURIComponent(thisvalue4);
    params += '&stratv4=' + stavalue4 ;
    params += '&endv4=' + endvalue4 ;
    
    params += '&fill=' + isadd0 ;
    params += '&fillnum1=' + addnum1 ;
    params += '&fillnum2=' + addnum2 ;
    params += '&fillnum3=' + addnum3 ;
    params += '&fillnum4=' + addnum4 ;
    
    params += '&fno=' + DeviceNo ;
    params += '&sno=' + DeviceNo2 ;
    params += '&sto='+DeviceNo2_f;
    params += '&devicon=' + DeviceIcon4 ;
    params += '&memo=' + tsd.encodeURIComponent(dismemo);
	
	loginfo = tsd.encodeURIComponent("<fmt:message key='line.batchadd' />：") 
    + tsd.encodeURIComponent("<fmt:message key='line.fixed' />1：") 
    + tsd.encodeURIComponent(thisvalue1) + ';' 
    + tsd.encodeURIComponent("<fmt:message key='line.sta' />1：") 
    + tsd.encodeURIComponent(stavalue1) + ';' 
    + tsd.encodeURIComponent("<fmt:message key='line.end' />1：") 
    + tsd.encodeURIComponent(endvalue1) + ';' 
    
    + tsd.encodeURIComponent("<fmt:message key='line.fixed' />2：") 
    + tsd.encodeURIComponent(thisvalue2) + ';' 
    + tsd.encodeURIComponent("<fmt:message key='line.sta' />2：") 
    + tsd.encodeURIComponent(stavalue2) + ';' 
    + tsd.encodeURIComponent("<fmt:message key='line.end' />2：") 
    + tsd.encodeURIComponent(endvalue2) + ';' 
    
    + tsd.encodeURIComponent("<fmt:message key='line.fixed' />3：") 
    + tsd.encodeURIComponent(thisvalue3) + ';' 
    + tsd.encodeURIComponent("<fmt:message key='line.sta' />3：") 
    + tsd.encodeURIComponent(stavalue3) + ';' 
    + tsd.encodeURIComponent("<fmt:message key='line.end' />3：") 
    + tsd.encodeURIComponent(endvalue3) + ';' 
    
    + tsd.encodeURIComponent("<fmt:message key='line.fixed' />4：") 
    + tsd.encodeURIComponent(thisvalue4) + ';' 
    + tsd.encodeURIComponent("<fmt:message key='line.sta' />4：") 
    + tsd.encodeURIComponent(stavalue4) + ';' 
    + tsd.encodeURIComponent("<fmt:message key='line.end' />4：") 
    + tsd.encodeURIComponent(endvalue4) + ';' 
    
    + tsd.encodeURIComponent("<fmt:message key='line.fill' />0：") 
    + tsd.encodeURIComponent(isadd0) + ';' 
    + tsd.encodeURIComponent("<fmt:message key='line.icon' />：") 
    + tsd.encodeURIComponent(DeviceIcon4)
    + tsd.encodeURIComponent("是否可复用：") 
    + tsd.encodeURIComponent(Multiplexing)
	
	$("#loginfo").val(loginfo);
	
	return params;
}
function batchAddDeviceLazy()
{      
    
    var urlstr = tsd.buildParams(
    {
        packgname : 'service',
        clsname : 'Procedure',
        method : 'exequery',
        ds : 'tsdBilling',//数据源名称 对应的spring配置的数据源
        tsdpname : 'lineDeviceManager.Air_BatchAddDevice', //存储过程的映射名称
        tsdExeType : 'exe'
    });
    
    var params = batchAddBuildParam();
    params = params+urlstr;
    var loginfo = $("#loginfo").val();
    writeLogInfo('', 'add', loginfo);
    $.ajax(
    {
        url : 'mainServlet.html?' + params, 
        datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            if(xml=='true'){
            	setTimeout($.unblockUI, 15);
	            var operationtips = $("#operationtips").val();
	            var successful = $("#successful").val();
	            alert(successful, operationtips);
				var DeviceNostr = $('#DeviceNo2_f').val();
	            reloadThisData('lineDeviceManager.querythree', 'lineDeviceManager.querythreepage', 'editgrid_three',DeviceNostr);
            }
        }
    });
}
function whichshow(ids)
{
    $('#trhide' + ids).show();
}

//
function fuheExe()
{
    var queryName = $('#queryName').val();
    if (queryName == "delete") {
        fuheDelMx();
    }
    else {
        //fuheQuery();
    }
}


function fuheDelMx(){

	//jConfirm(deleteinformation,operationtips,function(x){
 	if(confirm('您确认要删除这些数据吗?'))
 	{	 
 		//获取选中的行的devno editgrid_four DeviceNo
 		var rowid = jQuery("#editgrid_four").getGridParam("selrow");			
		if (rowid == null) 
		{				
			alert("请先选中三级设备，再进行此操作！");
			return;
		}
		var deviceNo=$("#editgrid_four").getCell(rowid,'DeviceNo');
 		
 		var params = fuheQbuildParams();
 		params += '&deviceno=' + deviceNo ;	
 		//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
	 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'exe',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:'lineDeviceManager.deletedeviceport'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  
									});
		var link='mainServlet.html?'+urlstr1+params; 
		
	 	$.ajax({
				url:link,
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(msg){
					if(msg=="true"){
						alert('删除成功!');
						var DeviceNostr = $('#DeviceNo2').val();
			            reloadThisData('lineDeviceManager.querythree', 'lineDeviceManager.querythreepage', 'editgrid_three', 
			            DeviceNostr);
					}	
				}
		});
	}
		
}


//获取图标
function disListIcon(ids,idsshow,idsval)
{
    var disinfos = '';
    var disname = 'disradio'+idsval;
    for (var i = 1 ; i < <%= x %> ; i++)
    {
        var disradio = '<input type="radio" onclick="disCheckIcon('+ "'" + idsval + "'" + ')" value="style/icon/device/' + i + '.jpg" style="margin-left:5px" name="'+disname+'" id="icon' + i + '" />';
        var info = '<label><img style="margin-left: 2px" width="128px" height="128px" src="<%=devicepath %>' + i + '.jpg"/></label>';
        var thestr = '';
        if (i % 4 == 0) {
            thestr = '<br/>';
        }
        disinfos += disradio + info + thestr;
    }
    $('#'+ids).html(disinfos);
    $('#'+idsshow).show();
    var disflag = $('#operflag').val();
	if(disflag==1){
		var disval = $('#'+idsval).val();
		forChecked(disname,disval);
	}
}
//显示选中图标
function disCheckIcon(ids)
{
	var disname = 'disradio'+ids;
    var tagname = document.getElementsByName(disname);
    for (var i = 0 ; i < tagname.length; i++) {
        if (tagname[i].checked == true) {
            $('#'+ids).val(tagname[i].value);
            break;
        }
    }
}
//显示选中数据
function forChecked(ids,disval){
	var tagname = document.getElementsByName(ids);
    for (var i = 0 ; i < tagname.length; i++) {
    	if( tagname[i].value == disval){
    		tagname[i].checked = true;
    		break;
    	}
    }
}

        /****************
       	*备注限制函数
       	*oTextArea:内容
       	*******************/
       	var TextUtil = new Object();
            TextUtil.NotMax = function(oTextArea){
                var maxText = oTextArea.getAttribute("maxlength"); 
                if(oTextArea.value.length > maxText){
                        oTextArea.value = oTextArea.value.substring(0,maxText); 
                        alert("输入超出限制！"); 
                } 
            }     
            
	//批量删除端口
	function deletedk(){
		var DeviceNo2key = $("#DeviceNo2").val();
		if(DeviceNo2key==""){
			alert("请选择设备类型！");
			return false;
		}
		openDiaQueryG('delete','air_devicemx')
	}
	//添加面板关闭按钮点击事件
	//params: status :1 一级设备 2：二级设备 3：三级设备 4：四级设备
	function closeButClick(status){
		if(status==1){
			reloadThisData('lineDeviceManager.queryone', 'lineDeviceManager.queryonepage', 'editgrid_one','');
		}else if(status==2){
			var DeviceNostr = $("#DeviceNo").val();			
			reloadThisData('lineDeviceManager.querytwo', 'lineDeviceManager.querytwopage', 'editgrid_two',DeviceNostr);
		}else if(status==3){
			var DeviceNostr=$("#DeviceNo2").val();		
			reloadThisData('lineDeviceManager.queryfour', 'lineDeviceManager.queryfourpage', 'editgrid_four',DeviceNostr);
		}else if(status==4){
			var DeviceNostr=$("#DeviceNo2_f").val();			
			reloadThisData('lineDeviceManager.querythree', 'lineDeviceManager.querythreepage', 'editgrid_three',DeviceNostr);
		}			    
	}
	
	/**
	 *根据模块局获取路由设备信息
	 */
	function queryRouting()
	{
	 	var mokuai=$('#moduleBu').val();
	 	var DeviceNo=$("#DeviceNo").val();
	 	var urlstr_two=$("#two").val();
	 	$("#editgrid_two").setGridParam({
            url : "mainServlet.html?" + urlstr_two + "&DeviceNo=" + DeviceNo +"&mokuaiju="+tsd.encodeURIComponent(mokuai)
        }).trigger('reloadGrid');
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
		<div style="padding-left: 10px;">
			请选择模块局：<select id="moduleBu" class="textclass" style="width: 140px" onchange="queryRouting()"></select>
		</div>
		<table cellspacing="5px">
			<tr>
				<td>
				<div id="buttons" style="width: 99%">
					<button type="button" id="addone1" onclick="openText('oneform')"
						disabled="disabled">
						添加路由
					</button>
				</div>			
					<table id="editgrid_one" class="scroll" cellpadding="0" cellspacing="0"></table>
					<div id="pagered_one" class="scroll" style="text-align: left;"></div>
				</td>
				<td>
					<div id="buttons" style="width: 99%">
						<button type="button" id="addtwo1" onclick="openText('twoform')"
							disabled="disabled">
							添加设备
						</button>
					</div>
					<table id="editgrid_two" class="scroll" cellpadding="0" cellspacing="0"></table>
					<div id="pagered_two" class="scroll" style="text-align: left;"></div>
				</td>
			</tr>
			<tr>
				<td >
					<div id="buttons" style="width: 99%">
						<button type="button" id="addfour1" onclick="openText('fourform')"
							disabled="disabled">
							添加设备
						</button>
					</div>				
					<table id="editgrid_four" class="scroll" cellpadding="0" cellspacing="0"></table>
					<div id="pagered_four" class="scroll" style="text-align: left;"></div>
				</td>
				
				<td>
					<div id="buttons" style="width: 99%">
						<button type="button" id="addthree1" onclick="openText('threeform')"
							disabled="disabled">
							添加端口
						</button>
						<button type="button" id="batchthree1" onclick="openText('batchaddform')"
							disabled="disabled">
							批量添加端口
						</button>
						<button type="button" id="opendel2"
							onclick="deletedk();" disabled="disabled">
							<!--批量删除-->
							<fmt:message key="tariff.deleteb" />
						</button>
					</div>
					<table id="editgrid_three" class="scroll" cellpadding="0" cellspacing="0"></table>
					<div id="pagered_three" class="scroll" style="text-align: left;"></div>
				</td>
			</tr>
		</table>
		
		
		<!-- 一级设备的面板 -->
		<div class="neirong" id="oneform" style="display: none;width:700px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="onefromtitle">添加路由</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:closeButClick(1);">关闭</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd" >
					   <form action="#" name="oneforms"
							id="oneforms" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="labelclass">
									<label id="DeviceNamee"></label>
								</td>
								<td class="tdstyle">
									<input type="text" id="thisDeviceName" class="textclass" style="width: 150px" maxlength="20"  onpropertychange="TextUtil.NotMax(this)"/>
									<font style="color:red;margin-left: 10px">*</font>
								</td>
								<td class="labelclass">
									<label id="DeviceIconn"></label>
								</td>
								<td class="tdstyle">
									<input type="text" id="DeviceIcon1" class="textclass" style="width: 150px" onfocus="disListIcon('oneiconlist','trhide1','DeviceIcon1')" readonly="readonly"/>
								</td>
							</tr>
							<tr id='trhide1'>
								<td colspan="6" class='tdstyle'>
									<div id="oneiconlist"
										style="height: 250px;overflow-y: auto;overflow-x: hidden;">
									</div>
								</td>
							</tr>
							<tr>
								<td class="dflabelclass">
									<label id="DeviceNodeSects"></label>
								</td>
								<td>
									<select id="NodeSects" class="textclass" style="width: 150px">
										<option value='0'>请选择</option>
										<option value='1'>电话</option>
										<option value='2'>宽带</option>
										
									</select>
									<font style="color:red;margin-left: 10px">*</font>
								</td>
								<td class="dflabelclass">
									<label id="Devicememo1"></label>
								</td>
								<td>
									<input type="text" id="memo1" class="textclass" style="width: 150px" maxlength="120"  onpropertychange="TextUtil.NotMax(this)"/>
								</td>
								
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" id="saveoneadd" onclick="saveInfo(1,1)">
							保存添加
					</button>
					<button type="submit" class="tsdbutton" id="saveoneexit" onclick="saveInfo(1,2)" style="margin-left: 10px">
							保存退出
					</button>
					<button type="submit" class="tsdbutton" id="modifyone"
							onclick="editOneInfo()">
							<fmt:message key="global.edit" />
					</button>
					<button type="button" class="tsdbutton" id="closeoneform"
							style="margin-left: 10px" onclick="closeButClick(1);">
							<fmt:message key="global.close" />
					</button>
				</div>
		</div>
		
		
		<!-- 二级设备的面板 -->
		<div class="neirong" id="twoform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="twofromtitle">添加设备</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:closeButClick(2);">关闭</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd" >
					   <form action="#" name="twoforms"
							id="twoforms" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="labelclass">
									<label id="DeviceTypee"></label>
								</td>
								<td class="tdstyle">
									<input type="text" id="thisDeviceType" class="textclass" style="width: 140px" maxlength="20"  onpropertychange="TextUtil.NotMax(this)"/>
									<font style="color:red;margin-left: 10px">*</font>
								</td>
								<td class="labelclass">
									<label id="mokuaijuu"></label>
								</td>
								<td class="tdstyle">
									<select id="mokuaiju" class="textclass" style="width: 140px"></select>
									<font style="color:red;margin-left: 10px">*</font>
								</td>
								
								<td class="labelclass">
									<label id="DeviceIconn2"></label>
								</td>
								<td class="tdstyle">
									<input type="text" id="DeviceIcon2" onfocus="disListIcon('twoiconlist','trhide2','DeviceIcon2')" class="textclass" style="width: 140px" readonly="readonly"/>
								</td>
							</tr>
							<tr id='trhide2'>
								<td colspan="6" align="center" class="tdstyle">
									<div id="twoiconlist"
										style="height: 250px;overflow-y: auto;overflow-x: hidden;">
									</div>
								</td>
							</tr>
							<tr>
								<td class="dflabelclass">
									<label id="Devicememo2"></label>
								</td>
								<td>
									<input type="text" id="memo2" class="textclass" style="width: 140px" maxlength="120"  onpropertychange="TextUtil.NotMax(this)"/>
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
					<button type="submit" class="tsdbutton" id="savetwoadd" onclick="saveInfo(2,1)">
							保存添加
						</button>
						<button type="submit" class="tsdbutton" id="savetwoexit" onclick="saveInfo(2,2)" style="margin-left: 10px">
							保存退出
						</button>
						
						<button type="submit" class="tsdbutton" id="modifytwo"
							onclick="editTwoInfo()">
							<fmt:message key="global.edit" />
						</button>
						<button type="button" id="closetwoform" class="tsdbutton"
							 style="margin-left: 10px" onclick="closeButClick(2);">
							<fmt:message key="global.close" />
						</button>
				</div>
		</div>
		
		<!-- 三级级设备的面板 -->
		<div class="neirong" id="fourform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="fourfromtitle">添加设备模块</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:closeButClick(3);">关闭</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd" >
					   <form action="#" name="fourforms"
							id="fourforms" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="labelclass">
									<label id="DeviceTypee_f"></label>
								</td>
								<td class="tdstyle">
									<input type="text" id="thisDeviceType_f" class="textclass" style="width: 140px" maxlength="20"  onpropertychange="TextUtil.NotMax(this)"/>
									<font style="color:red;margin-left: 10px">*</font>
								</td>
								<td class="labelclass">
									<label id="mokuaijuu_f"></label>
								</td>
								<td class="tdstyle">
									<input type="text" id="mokuaiju_f" class="textclass2" style="width: 140px" disabled="disabled"/>
								</td>
								
								<td class="dflabelclass">
									<label id="Devicememo2_f"></label>
								</td>
								<td>
									<input type="text" id="memo2_f" class="textclass" style="width: 140px" maxlength="120"  onpropertychange="TextUtil.NotMax(this)"/>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" id="savefouradd" onclick="saveInfo(4,1)">
							保存添加
						</button>
						<button type="submit" class="tsdbutton" id="savefourexit" onclick="saveInfo(4,2)" style="margin-left: 10px">
							保存退出
						</button>
						
						<button type="submit" class="tsdbutton" id="modifyfour"
							onclick="editFourInfo()">
							<fmt:message key="global.edit" />
						</button>
						<button type="button" id="closefourform" class="tsdbutton"
							style="margin-left: 10px" onclick="closeButClick(3);">
							<fmt:message key="global.close" />
						</button>
				</div>
		</div>
		
		
		<!-- 端口添加的面板 -->
		<div class="neirong" id="threeform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="threefromtitle">添加端口</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:closeButClick(4);">关闭</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd" >
					   <form action="#" name="threeforms"
							id="threeforms" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="labelclass">
									<label id="NodeNamee"></label>
								</td>
								<td class="tdstyle">
									<input type="text" id="NodeName" class="textclass" style="width: 150px" maxlength="20"  onpropertychange="TextUtil.NotMax(this)"/>
									<font style="color:red;margin-left: 10px">*</font>
								</td>
								<td class="labelclass">
									<label id="NodeStatee"></label>
								</td>
								<td class="tdstyle">
									<select id="NodeState" class="textclass" style="width: 150px">
										<option value="0"><fmt:message key="ip.select" /></option>
										<option value="free"><fmt:message key="line.free" /></option>
										<option value="using"><fmt:message key="line.using" /></option>
										<option value="bad"><fmt:message key="line.bad" /></option>
									</select>
									<font style="color:red;margin-left: 10px">*</font>
								</td>
								
								<td class="labelclass">
									<label id="DeviceIconn3"></label>
								</td>
								<td class="tdstyle">
									<input type="text" id="DeviceIcon3" onfocus="disListIcon('threeiconlist','trhide3','DeviceIcon3')" class="textclass" style="width: 120px" readonly="readonly"/>
								</td>
							</tr>
							<tr id='trhide3'>
								<td colspan="6" align="center" class="tdstyle">
									<div id="threeiconlist"
										style="height: 250px;overflow-y: auto;overflow-x: hidden;">
									</div>
								</td>
							</tr>
							<tr>
								<td class="dflabelclass">
									<label id="DeviceMultiplexing3">可复用</label>
								</td>
								<td >
									<select id="Multiplexing3" class="textclass" style="width: 150px">
										<option value="0">否</option>
										<option value="1">是</option>
									</select>
								</td>
								<td class="dflabelclass">
									<label id="phone">电话</label>
								</td>
								<td>
									<input type="text" id="dh" class="textclass" style="width: 150px"/>
								</td>
								<td class="dflabelclass">
									<label id="Devicememo3"></label>
								</td>
								<td>
									<input type="text" id="memo3" class="textclass" style="width: 150px" maxlength="120"  onpropertychange="TextUtil.NotMax(this)"/>
								</td>								
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" id="savethreeadd" onclick="saveInfo(3,1)">
						保存添加
					</button>
					<button type="submit" class="tsdbutton" id="savethreeexit" onclick="saveInfo(3,2)" style="margin-left: 10px">
						保存退出
					</button>
					
					<button type="submit" class="tsdbutton" id="modifythree"
						onclick="editThreeInfo()">
						<fmt:message key="global.edit" />
					</button>
					<button type="button" class="tsdbutton" id="closethreeform"
						onclick="closeButClick(4);" style="margin-left: 10px">
						<fmt:message key="global.close" />
					</button>
				</div>
		</div>
		
		<!-- 批量添加三级设备的面板 -->
		<div class="neirong" id="batchaddform" style="display: none;width:900px">
		       <div id="tdivs">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">批量添加端口</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:closeButClick(4);">关闭</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd">
					   <form action="#" name="batchaddforms"
							id="batchaddforms" onsubmit="return false;">
						<table width="100%"  border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="labelclass">
									<fmt:message key="line.fixed" />1
								</td>
								<td class="tdstyle">
									<input type="text" id="thisvalue1" class="textclass" style="width: 150px" maxlength="10"  onpropertychange="TextUtil.NotMax(this)"/>
									<font style="color:red;margin-left: 10px">*</font>
								</td>
								<td class="labelclass">
									<fmt:message key="line.stavalue" />1
								</td>
								<td class="tdstyle">
									<input type="text" id="stavalue1" onkeyup="value=value.replace(/[^\d]/g,'')" class="textclass" style="width: 150px" maxlength="10"  onpropertychange="TextUtil.NotMax(this)"/>
									<font style="color:red;margin-left: 10px">*</font>
								</td>
								<td class="labelclass">
									<fmt:message key="line.endvalue" />1
								</td>
								<td class="tdstyle">
									<input type="text" id="endvalue1" onkeyup="value=value.replace(/[^\d]/g,'')" class="textclass" style="width: 150px" maxlength="10"  onpropertychange="TextUtil.NotMax(this)"/>
									<font style="color:red;margin-left: 10px">*</font>
								</td>
								
							</tr>
							<tr>
								<td class="labelclass">
									<fmt:message key="line.fixed" />2
								</td>
								<td class="tdstyle">
									<input type="text" id="thisvalue2" class="textclass" style="width: 150px" maxlength="10"  onpropertychange="TextUtil.NotMax(this)"/>
								</td>
								<td class="labelclass">
									<fmt:message key="line.stavalue" />2
								</td>
								<td class="tdstyle">
									<input type="text" id="stavalue2" onkeyup="value=value.replace(/[^\d]/g,'')" class="textclass" style="width: 150px" maxlength="10"  onpropertychange="TextUtil.NotMax(this)"/>
								</td>
								<td class="labelclass">
									<fmt:message key="line.endvalue" />2
								</td>
								<td class="tdstyle">
									<input type="text" id="endvalue2" onkeyup="value=value.replace(/[^\d]/g,'')" class="textclass" style="width: 150px" maxlength="10"  onpropertychange="TextUtil.NotMax(this)"/>
								</td>
								
							</tr>
							<tr>
								<td class="labelclass">
									<fmt:message key="line.fixed" />3
								</td>
								<td class="tdstyle">
									<input type="text" id="thisvalue3" class="textclass" style="width: 150px" maxlength="10"  onpropertychange="TextUtil.NotMax(this)"/>
								</td>
								<td class="labelclass">
									<fmt:message key="line.stavalue" />3
								</td>
								<td class="tdstyle">
									<input type="text" id="stavalue3" onkeyup="value=value.replace(/[^\d]/g,'')" class="textclass" style="width: 150px" maxlength="10"  onpropertychange="TextUtil.NotMax(this)"/>
								</td>
								<td class="labelclass">
									<fmt:message key="line.endvalue" />3
								</td>
								<td class="tdstyle">
									<input type="text" id="endvalue3" onkeyup="value=value.replace(/[^\d]/g,'')" class="textclass" style="width: 150px" maxlength="10"  onpropertychange="TextUtil.NotMax(this)"/>
								</td>								
							</tr>
							<tr>
								<td class="labelclass">
									<fmt:message key="line.fixed" />4
								</td>
								<td class="tdstyle">
									<input type="text" id="thisvalue4" class="textclass" style="width: 150px" maxlength="10"  onpropertychange="TextUtil.NotMax(this)"/>
								</td>
								<td class="labelclass">
									<fmt:message key="line.stavalue" />4
								</td>
								<td class="tdstyle">
									<input type="text" id="stavalue4" onkeyup="value=value.replace(/[^\d]/g,'')" class="textclass" style="width: 150px" maxlength="10"  onpropertychange="TextUtil.NotMax(this)"/>
								</td>
								<td class="labelclass">
									<fmt:message key="line.endvalue" />4
								</td>
								<td class="tdstyle">
									<input type="text" id="endvalue4" onkeyup="value=value.replace(/[^\d]/g,'')" class="textclass" style="width: 150px" maxlength="10"  onpropertychange="TextUtil.NotMax(this)"/>
								</td>								
							</tr>
							<tr>
								<td class="labelclass">
									<label id="isadd00"><fmt:message key="line.add0" /></label>
								</td>
								<td class="tdstyle">
									<select id="isadd0" class="textclass" style="width: 150px">
										<option value="0"><fmt:message key="ip.select" /></option>
										<option value="1" selected="selected"><fmt:message key="main.thetrue" /></option>
										<option value="2"><fmt:message key="main.thefalse" /></option>
									</select>
									<font style="color:red;margin-left: 15px">*</font>
								</td>
								
								<td class="labelclass">
									<label id="DeviceIconn4"></label>
								</td>
								<td class="tdstyle">
									<input type="text" id="DeviceIcon4" onfocus="disListIcon('fouriconlist','trhide4','DeviceIcon4')" class="textclass" style="width: 150px" readonly="readonly"/>
								</td>
								<td class="labelclass">
									<label id="Devicememo4"></label>
								</td>
								<td class="tdstyle">
									<input type="text" id="memo4" class="textclass" style="width: 150px"/>
								</td>
							</tr>
							<tr>
								<td class="dflabelclass">
									<label id="DeviceMultiplexing32">可复用</label>
								</td>
								<td >
									<select id="Multiplexing32" class="textclass" style="width: 150px">
										<option value="0" selected="selected">否</option>
										<option value="1">是</option>
									</select>
								</td>
								<td class="dflabelclass"></td>
								<td></td>
								<td class="dflabelclass"></td>
								<td></td>
							</tr>
							<tr id='trhide4'>
								<td colspan="6" align="center">
									<div id="fouriconlist"
										style="height: 250px;overflow-y: auto;overflow-x: hidden;">
									</div>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" id="savebatch" onclick="batchAddDevice()">
						<fmt:message key="line.stacretate" />
					</button>
						
					<button type="button" class="tsdbutton" id="closebatchaddform"
						 style="margin-left: 10px" onclick="closeButClick(4);">
						<fmt:message key="global.close" />
					</button>
				</div>
				</div>
				<table width="100%" id="loadingtable" style="display: none;margin-top: 100px" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="6" align="center">							
							<img src="style/images/public/loading.gif" />							
						</td>						
					</tr>
					<tr>
						<td>
							端口生成中，请稍等…………
						</td>
					</tr>
				</table>
		</div>
		
		<input type="hidden" id="iconpath" value="<%=iconpath%>" />
		
		<input type="hidden" id="batchdeleteright"/>
		
		<div style="display: none">
			<input type="hidden" id="operation"
					value="<fmt:message key="global.operation"/>" />
			<input type="hidden" id="deleteinfo"
					value="<fmt:message key="global.delete"/>" />
			<input type="hidden" id="editinfo"
					value="<fmt:message key="global.edit"/>" />
			<input type="hidden" id="addinfo"
					value="<fmt:message key="global.add"/>" />
			<input type="hidden" id="operationtips"
					value="<fmt:message key="global.operationtips"/>" />
			<input type="hidden" id="successful"
					value="<fmt:message key="global.successful"/>" />
			<input type="hidden" id="deleteinfo"
					value="<fmt:message key="global.delete"/>" />
			<input type="hidden" id="deleteinformation"
					value="<fmt:message key="global.deleteinformation"/>" />
			<input type="hidden" id="DeviceNo"/>
			<input type="hidden" id="DeviceNo2"/>
			<input type="hidden" id="DeviceName"/>
			<input type="hidden" id="DeviceType"/>
			
			<input type="hidden" id="thismokuaiju"/>
			
			
			<input type="hidden" id="thisselect" value="<fmt:message key="ip.select"/>"/>
			
			<input type="hidden" id="oneDeviceNo"/>
			<input type="hidden" id="twoDeviceNo"/>
			<input type="hidden" id="threeDeviceNo"/>
			
			<input type="hidden" id="adddeviceright"/>
			<input type="hidden" id="adddevicetyperight"/>
			<input type="hidden" id="addnodenameright"/>
			<input type="hidden" id="addbatchdeviceright"/>
			
			<input type="hidden" id="editdeviceright"/>
			<input type="hidden" id="editdevicetyperight"/>
			<input type="hidden" id="editnodenameright"/>
			
			<input type="hidden" id="deletedeviceright"/>
			<input type="hidden" id="deletedevicetyperight"/>
			<input type="hidden" id="deletenodenameright"/>
			<input type="hidden" id="editfields"/>
			
			<input type="hidden" id="theairdevicevalue"/>
			<input type="hidden" id="theairdevicetypevalue"/>
			<input type="hidden" id="theairdevicemxvalue"/>
			
			<input type="hidden" id="deletepower"
					value="<fmt:message key="global.deleteright"/>" />
			<input type="hidden" id="editpower"
					value="<fmt:message key="global.editright"/>" />
			
			<input type="hidden" id="imenuid" value="<%=imenuid%>" />
				<input type="hidden" id="zid" value="<%=zid%>" />
				<%
					if (!languageType.equals("en")) {
						languageType = "zh";
					}
				%>

			<input type="hidden" id="languageType" value="<%=languageType%>" />
			<input type="hidden" id="userid" value="<%=userid%>" />
			
			<input type="hidden" id="onedevice"
					value="<fmt:message key="line.onedevice"/>" />
			<input type="hidden" id="twodevice"
					value="<fmt:message key="line.twodevice"/>" />
			<input type="hidden" id="threedevice"
					value="<fmt:message key="line.threedevice"/>" />
			<input type="hidden" id="isalldelete"
					value="<fmt:message key="line.isalldelete"/>" />
			<input type="hidden" id="pinput"
					value="<fmt:message key="line.input"/>" />
			<input type="hidden" id="endworn"
					value="<fmt:message key="line.endworn"/>" />
			<input type="hidden" id="valueequals"
					value="<fmt:message key="line.equals"/>" />
			<input type="hidden" id="selecticon"
					value="<fmt:message key="line.selecticon"/>" />
			
			<input type='hidden' id='userloginip'
					value='<%=Log.getIpAddr(request)%>' />
				<input type='hidden' id='userloginid'
					value='<%=session.getAttribute("userid")%>' />
				<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
			
			<input type='hidden' id='operflag'/>
			
			<input type="hidden" id="DeviceNo2_f"/>
			<input type="hidden" id="thismokuaiju_f"/>
			<input type="hidden" id="DeviceType_f"/>
			<input type="hidden" id="fourDeviceNo"/>
			<input type="hidden" id="two"/>
			<input type="hidden" id="loginfo"/>
		</div>
  </body>
</html>
