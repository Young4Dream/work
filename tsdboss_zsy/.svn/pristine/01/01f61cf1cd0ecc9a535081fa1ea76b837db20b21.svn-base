<%----------------------------------------
	name: XQLineManager.jsp
	author: youhongyu
	version: 1.0, 2009-11-26
	description: 小区号线设备管理
	modify: 
---------------------------------------------%>
<%@page import="com.tsd.service.util.Log"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
	String managearea = (String) session.getAttribute("managearea");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");

	String departname = (String) session.getAttribute("departname");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>UserLine-Manager</title>
		
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
		<!-- 资费菜单样式 -->
		<link href="style/css/pubMode/tariff.css" rel="stylesheet" type="text/css" />
		<!-- 日期插件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>		
		
		<!-- 验证数据长度 -->
		<script src="script/public/datalength.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script  src="script/public/infotest.js" type="text/javascript"></script>
		<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>
		<script src="script/telephone/linemanagement/XQLineManager.js" type="text/javascript"></script>
		<script src="script/telephone/linemanagement/linePublic.js" type="text/javascript"></script>
		
<script type="text/javascript">

/**
* 初始化 回车键事件
* @param 
* @return 
*/
document.onkeydown = function (event)
{
    e = event ? event : (window.event ? window.event : null);
    if (e.keyCode == 13) {
        queryTheInfo();//根据电话或宽带账号进行信息查询
        return false;
    }
}
/**
* 查看当前用户的扩展权限，对spower字段进行解析
* @param 
* @return 
*/
function getUserPower()
{
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', clsname : 'Procedure', method : 'exequery', ds : 'tsdBilling', //数据源名称 对应的spring配置的数据源
        tsdpname : 'userLineManager.getPower', //存储过程的映射名称
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
    var exportright = '';
    var printright = '';
    var editright = '';
    var editrouteright = '';
    
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
    if (spower == 'all@') {
        exportright = 'true';
        printright = 'true';
        editright = 'true';
        editrouteright = '10'//即可编辑电话路由信息又可编辑宽带路由信息
        flag = true;
    }
    else if (spower != '' && spower != 'all@')
    {
        var spowerarr = spower.split('@');
        for (var i = 0; i < spowerarr.length - 1; i++)
        {
            printright += getCaption(spowerarr[i], 'print', '') + '|';
            exportright += getCaption(spowerarr[i], 'export', '') + '|';
            editright += getCaption(spowerarr[i], 'edit', '') + '|';
            editrouteright += getCaption(spowerarr[i], 'editroute', '') + '|';
        }
    }
    var hasprint = printright.split('|');
    var hasexport = exportright.split('|');
    var hasedit = editright.split('|');
    var haseditroute = editrouteright.split('|');
    
    var str = 'true';
    if (flag == true)
    {
        $("#exportright").val(exportright);
        $("#printright").val(printright);
        $("#editright").val(editright);
        $("#editrouteright").val(editrouteright);
    }
    else
    {
    	for (var i = 0; i < hasexport.length; i++) {
            if (hasexport[i] == 'true') {
                $("#exportright").val(str);
                break;
            }
        }
        //数字排序，sort默认对字符串进行排序
        var　strarr = new Array();
        for (var i = 0; i < haseditroute.length; i++) {
            if(haseditroute[i]!=''){
            	strarr.push(haseditroute[i]);
            }
        }
        //排序取最大
        strarr = strarr.sort(function(x,y){return parseInt(x)-parseInt(y);}); 
        $('#editrouteright').val(strarr[strarr.length-1]);//权限最大优先
        
        for (var i = 0; i < hasprint.length; i++) {
            if (hasprint[i] == 'true') {
                $("#printright").val(str);
                break;
            }
        }
        for (var i = 0; i < hasedit.length; i++) {
            if (hasedit[i] == 'true') {
                $("#editright").val(str);
                break;
            }
        }
    }
}
/**
* 页面初始化
* @param 
* @return 
*/
jQuery(document).ready(function () 
{
    /**************************
    **   取得当前导航菜单名称    *
    ************************/
    $("#navBar1").append(genNavv());
    
    /**************************
    **  判断用户权限    *
    ************************/
    getUserPower();
    var printright = $("#printright").val();
    if (printright == "true") {
        document.getElementById("print").disabled = false;
    }
    var exportright = $("#exportright").val();
    if (exportright == "true") {
        document.getElementById("export").disabled = false;
    }
    
    
    thisReady();//加载jqgrid    
    showShareJqgrid();//打印共享号线面板中的jqgrid    
    showTelJQgrid();//加载电话路由jqgrid
    /*
    //加载宽带路由jqgrid
    showbBroadJQgrid();
   */
    //拖拽透明显示
    $("#editform").draggable({});
    printRountPan(4,'new');
 
});

/**
* 初始化加载jqgrid
* @param 
* @return 
*/
function thisReady()
{
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xml', //返回数据格式 
        tsdpk : 'XQLineManager.query', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : 'XQLineManager.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    var languageType = $('#languageType').val();
    var management = '<fmt:message key="userline.linemanager"/>';
    
    var thismkj = getMoKuaiJusByArea();
    thismkj = "'"+thismkj.toString().replace(new RegExp(",","g"),"','").replace(new RegExp("~","g"),"','")+"'";	
       
    /**
     var mkjs = getMoKuaiJus();
    //获取用户所在部门的的模块局
    if (mkjs != '' && mkjs != null)
    {
        var mkj = mkjs.split(',');
        var thismkj = "";
        for (var i = 0 ; i < mkj.length; i++) {
            thismkj += "'" + mkj[i] + "',";
        }
        var num = thismkj.lastIndexOf(',');
        thismkj = thismkj.substring(0, num);
		
    }
    else {
        mkjs = '';
    }
    */
    var column = '';
    var thisdata = loadData('air_users', languageType, 1);
    column = thisdata.FieldName.join(',');
    if (thisdata.FieldName[0] == undefined)
    {
        //号线资料表数据列如果都无别名，则会提示该错误
        alert('<fmt:message key="userline.isnotdisplay"/>!');
        return false;
    }
    //查询时需要用到的
    $('#thismkj').val(thismkj);
    $('#thiscolumn').val(column);
    $('#thiscolnames').val(thisdata.colNames);
    $('#thiscolmodels').val(thisdata.colModels);
    var gridData = getTheField(1);
    //电话动态列名的生成
    var broadData = getTheFieldForBroad(2);
    
    //宽带动态列名的生成
    var theviewoperations = '';
    var thefieldalias = fetchFieldAlias('air_users', '<%=languageType%>');
    var Dh = thefieldalias['Dh'];
    var Jhj = thefieldalias['UserName'];
    var UserBM = thefieldalias['UserBM'];
    var userAddr = thefieldalias['userAddr'];
    var Regdate = thefieldalias['Regdate'];
    var linkMan = thefieldalias['linkMan'];
    var linkDh = thefieldalias['linkDh'];
    var MoKuaiJu = thefieldalias['MoKuaiJu'];
    var DhType = thefieldalias['DhType'];
    var bmzc = thefieldalias['bmzc'];
    var oper = '<fmt:message key="global.operation"/>';
    //电话只显示电话信息，不显示绑定电话，宽带显示
    jQuery("#editgrid").jqGrid(
    {
        url : 'mainServlet.html?' + urlstr + '&str=' + tsd.encodeURIComponent(thismkj), datatype : 'xml', 
        colNames : [Dh, Jhj, UserBM,bmzc, userAddr, Regdate, MoKuaiJu,DhType], 
        colModel : [ 
        //{
        //    name : 'viewOperation', index : 'viewOperation', width : 100
        //},
        //如果有操作列 请勿更改或者删除
        {
            name : 'Dh', index : 'Dh', width : 150
        },
        {
            name : 'UserName', index : 'UserName', width : 150
        },
        {
            name : 'UserBM', index : 'UserBM', width : 185
        },
        {
            name : 'bmzc', index : 'bmzc', width : 120
        },
        {
            name : 'userAddr', index : 'userAddr', width : 300
        },
        {
            name : 'Regdate', index : 'Regdate', width : 195
        },
        {
            name : 'MoKuaiJu', index : 'MoKuaiJu'
        },
        {
            name : 'DhType', index : 'DhType'
        } ], rowNum : 10, //默认分页行数
        rowList : [10, 15, 20], //可选分页行数
        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images/', pager : jQuery('#pagered'), sortname : 'Regdate', 
        //默认排序字段
        viewrecords : true, //hidegrid: false, 
        sortorder : 'desc', //默认排序方式 
        caption : management, 
        height : 150, //高
        width : document.documentElement.clientWidth - 63,
        loadComplete : function ()
        {
            $("#editgrid").setSelection('0');
            $("#editgrid").focus();
            ///自动适应 工作空间
            // var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
            // setAutoGridHeight("editgrid",reduceHeight);
            //var editinfo = $("#editinfo").val();
            //addRowOperBtn('editgrid', '&nbsp;&nbsp;&nbsp;&nbsp;<img src="images/ltubiao_01.gif" alt="' + editinfo + '"/>', 
            //'queryUserAddr', 'Dh', 'click', 1);
            //addRowOperBtn('editgrid', '', '', 'DeviceNo', 'click', 2);
            //executeAddBtn('editgrid', 2);
            thisOnfocus();
        },
        onSelectRow: function (ids){
        	if (ids != null) 
            {
                var Dh= $("#editgrid").getCell(ids, "Dh");
                $("#Dh").val(Dh);
                $("#dh_rount").val(Dh);
                
                //记录当前电话对应的模块局
                var MoKuaiJu =$("#editgrid").getCell(ids, "MoKuaiJu")
                $('#limitroute').val(MoKuaiJu);   
                
                ///////////////////////////////////////                
                //记录当前电话对应的类型：电话phone  宽带broadband
                var DhType =$("#editgrid").getCell(ids, "DhType")       
            
                $("#Dh_shareSel").val(Dh); 
                $("#DhType_shareSel").val(DhType); 
                
                //更新电话路由jqgrid
                var column = $('#ziduansF_info').val();
                reloadRouteData('XQLineManager.querylineinfo', 'XQLineManager.querylineinfopage', 
                'editgrid_info', Dh, column,'2') ;
              
              /**  
                //更新宽带路由jqgrid                
                column = $('#ziduansF_broad').val();
                reloadRouteData('userLineManager.querylineinfo', 'userLineManager.querylineinfopage', 
                'editgrid_broad', Dh, column,'2') ; 
               */
           }
        },
        ondblClickRow : function (ids) 
        {
        	
        }
    }).navGrid('#pagered', {
        edit : false, add : false, add : false, del : false, search : false
    },
    //options 
    {
        height : 100, reloadAfterSubmit : true, closeAfterEdit : true
    },
    // edit options 
    {
        height : 100, reloadAfterSubmit : true, closeAfterAdd : true
    },
    // add options 
    {
        reloadAfterSubmit : false
    },
    // del options 
    {} // search options 
    );
    
   
}

/**
* 双击用户宽带号线资料详细信息的jqgrid中记录，显示电话用户号线信息
* @param flag：标识是电话或是宽带 ，broadband：宽带；phone：电话
* @return 
*/
function displayDetailInfos(flag){
		var thisDh = $('#Dh').val();
        var thecolum = '';
        var thesql = '';
        
        if(flag=='broadband'){
        	thecolum = $('#thisbroadcolumn').val();
    		thesql = $('#thisbroadhiddensql').val();
        }else if(flag=='phone'){
        	thecolum = $('#thishiddencolumn').val();
        	thesql = $('#thishiddensql').val();
        }
        
        
        var thiscolum = thecolum.split(',');
        //var theinput = '<hr/>';
        var len = thiscolum.length;
        var theresult = '';
        
        for (var i = 0 ; i < thiscolum.length; i++)
        {
            var thevalue = getTheValues(thiscolum[i]);
            theresult += thevalue + ',';
            //theinput += "<p style='margin-left:200px'><span class='tmpspanstyle'>" + thiscolum[i] + "</span><input type='text' id='" + thevalue + "s' disabled='disabled'/></p><hr/>" ;
        }
        
        var urlstr = tsd.buildParams(
        {
            packgname : 'service', //java包
            clsname : 'ExecuteSql', //类名
            method : 'exeSqlData', //方法名
            ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf : 'mssql', //指向配置文件名称
            tsdoper : 'query', //操作类型 
            datatype : 'xmlattr', //返回数据格式 
            tsdpk : 'userLineManager.getTheVlaue'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax(
        {
            url : 'mainServlet.html?' + urlstr + '&column=' + thesql + '&Dh=' + thisDh, datatype : 'xml', 
            cache : false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout : 1000, async : false , //同步方式
            success : function (xml)
            {
            	var arrstr = new Array();
                $(xml).find('row').each(function ()
                {
                    var arr = theresult.split(',');
                    for (var i = 0 ; i < arr.length ; i++)
                    {
                        if (arr[i] != '' && undefined != arr[i]) {
                            var arrval = $(this).attr(arr[i].toLowerCase());  
                            if(arrval!=''){
                            	if(arrval!=undefined){
									arrstr.push(arr[i]+'~'+arrval);                            	
                            	}
                            }                       
                        }
                    }
                });
                //是否是进行查看信息操作
                if(arrstr.length>0){
                	var infos = ''
	                var xx = 0;
	                for(var i = 0 ; i < arrstr.length;i++){
	                	var arrs = arrstr[i].split('~');
	                	var devicetips = getDeviceTips(arrs[0]);//Value1
	                	var tips = '';
	                	if(xx!=arrstr.length-1){
	                		tips = '<img src="style/images/public/arrow-next.gif" />';
	                	}
	                	//数据格式： 设备名称-->设备图标-->设备值 
	                	infos += '<td><table><tr><td style="border: 1px; border-style: solid; border-color: #87CEFA;" align="center">' + devicetips[0] + '</td></tr><tr><td align="center" style="border: 1px; border-style: solid; border-color: #87CEFA;"><img width="64px" height="64px" src="' + devicetips[1] + '"/></td></tr><tr><td align="center" style="color:red;border: 1px; border-style: solid; border-color: #87CEFA;">' + arrs[1] + '</td></tr></table></td><td>'+tips+'</td>';  
	                	xx++;
	                }
	                if(infos!=''){
						$("#thisdeviceform").html('<table  cellpadding="5px" cellspacing="5px"><tr><td><table width="50px" style="border: 1px; border-style: solid; border-color: #87CEFA;"><tr><td style="border: 1px; border-style: solid; border-color: #87CEFA;">设备名称</td></tr><tr height="64px"><td style="border: 1px; border-style: solid; border-color: #87CEFA;">设备图标</td></tr><tr><td style="border: 1px; border-style: solid; border-color: #87CEFA;">配置信息</td></tr></table></td>'+infos+'</tr></table>');                
	                }
	                autoBlockForm('deviceinfoform', 5, 'deviceinfoformclose', "#ffffff", false);
                }else{
                	//alert('操作有误!');
                }
                
            }
        });
}
/**
* 查看用户信息按钮事件，显示用户详细信息
* @param flag：标识是电话或是宽带 ，broadband：宽带；phone：电话
* @return 
*/
function queryDhInfos()
{
    var dh = $('#Dh').val();
    if (dh != '')
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
            tsdpk : 'userLineManager.querydhinfos'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax(
        {
            url : 'mainServlet.html?dh=' + dh + urlstr, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout : 1000, async : false , //同步方式
            success : function (xml)
            {
                $(xml).find('row').each(function ()
                {
                    //UserName,UserBM,userAddr,linkMan,linkDh,MoKuaiJu
                    var UserName = $(this).attr("UserName".toLowerCase());
                    if (UserName != undefined)
                    {
                        var UserBM = $(this).attr("UserBM".toLowerCase());
                        var userAddr = $(this).attr("userAddr".toLowerCase());
                        var linkMan = $(this).attr("linkMan".toLowerCase());
                        var linkDh = $(this).attr("linkDh".toLowerCase());
                        var MoKuaiJu = $(this).attr("MoKuaiJu".toLowerCase());
                        var Regdate = $(this).attr("Regdate".toLowerCase());
                        
                        var bm1 = $(this).attr("bm1");
                        var bm2 = $(this).attr("bm2");
                        var bm3 = $(this).attr("bm3");
                        var bm4 = $(this).attr("bm4");
                        var dhgn = $(this).attr("dhgn");
                        var bz2 = $(this).attr("bz2");
                        var ywarea = $(this).attr("ywarea");
                        var yhxz = $(this).attr("yhxz");
                        var yhlb = $(this).attr("yhlb");
                        var sflx = $(this).attr("sflx");
                        
                        $('#dis_bm1').html(bm1);
                        $('#dis_bm2').html(bm2);
                        $('#dis_bm3').html(bm3);
                        $('#dis_bm4').html(bm4);
                        $('#dis_dhgn').html(dhgn);
                        $('#dis_bz2').html(bz2);
                        $('#dis_ywarea').html(ywarea);
                        $('#dis_yhlb').html(yhlb);
                        $('#dis_sflx').html(sflx);
                        $('#dis_yhxz').html(yhxz);
                        
                        $('#dis_username').html(UserName);
                        
                        $('#dis_userbm').html(UserBM);
                        $('#dis_useraddress').html(userAddr);
                        $('#dis_linkman').html(linkMan);
                        $('#dis_mkj').html(MoKuaiJu);
                        $('#dis_Regdate').html(Regdate);
                        $('#dis_linkdh').html(linkDh);
                        $('#dis_dh').html(dh);
                        autoBlockForm('userdhinfos', 20, 'closedhinfos', "#ffffff", false);
                        //弹出查询面板
                    }
                });
            }
        });
    }
    else {
        alert('请选择你要查看的用户!');
    }
}
var theSql = [];
//传到后台去的sql
var theCloumn = [];
//需要显示的列值
var theModel = [];
//jqgrid的model
var thehiddensql = [];
//查询动态生成输入列时需要的sql



/**
* 获取jqgrid的动态列
* @param type：设备归属类型
* @return 返回jqgrid的动态列
*/
function getTheField(type)
{
    var gridData = new Object();
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'userLineManager.getTheField'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&type=' + type, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                //拼字符串初始化列
                theCloumn.push($(this).attr("FieldName".toLowerCase()));
                thehiddensql.push($(this).attr("NodeField".toLowerCase()));
                theSql.push($(this).attr("NodeField".toLowerCase()) + ' as ' + tsd.encodeURIComponent($(this).attr("FieldName".toLowerCase())));
                var theField = $(this).attr("NodeField".toLowerCase());
                var temp = "{name:'" + theField + "',index:'" + theField + "',width:80}";
                theModel.push(eval("(" + temp + ")"));
            });
        }
    });
    $('#thishiddencolumn').val(theCloumn);
    $('#thishiddensql').val(thehiddensql);
    theSql.unshift("'" + "viewOperation" + "'");
    theCloumn.unshift('&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message key="global.operation"/>');
    theModel.unshift(eval("(" + "{name:'viewOperation',index:'viewOperation',width:45}" + ")"));
    gridData.theCloumn = theCloumn;
    gridData.theSql = theSql;
    gridData.theModel = theModel;
    return gridData;
}
var theBroadSql = [];
//传到后台去的sql
var theBroadCloumn = [];
//需要显示的列值
var theBroadModel = [];
//jqgrid的model
var theBroadhiddensql = [];
//查询动态生成输入列时需要的sql

/**
* 获取电话 jqgrid的动态列名的生成
* @param type：设备归属类型
* @return 返回jqgrid的动态列
*/
function getTheFieldForBroad(type)
{
    var gridData = new Object();
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'userLineManager.getTheField'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&type=' + type, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                //拼字符串初始化列
                theBroadCloumn.push($(this).attr("FieldName".toLowerCase()));
                theBroadhiddensql.push($(this).attr("NodeField".toLowerCase()));
                theBroadSql.push($(this).attr("NodeField".toLowerCase()) + ' as ' + tsd.encodeURIComponent($(this).attr("FieldName".toLowerCase())));
                theBroadModel.push(eval("(" + "{name:'" + $(this).attr("NodeField".toLowerCase()) + "',index:'" + $(this).attr("FieldName".toLowerCase()) + "',width:80}" + ")"));
            });
        }
    });
    $('#thisbroadcolumn').val(theBroadCloumn);
    $('#thisbroadhiddensql').val(theBroadhiddensql);
    theBroadSql.unshift("'" + "viewOperation" + "'");
    theBroadCloumn.unshift('&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message key="global.operation"/>');
    theBroadModel.unshift(eval("(" + "{name:'viewOperation',index:'viewOperation',width:30}" + ")"));
    gridData.theBroadCloumn = theBroadCloumn;
    gridData.theBroadSql = theBroadSql;
    gridData.theBroadModel = theBroadModel;
    return gridData;
}
/**
* 更新、查询操作中 实现jqgrid刷新面板的显示和隐藏
* @param str：控制可见性参数  str：block 显示；str：none 隐藏
* @return 
*/
function isThisHidden(str)
{
    document.getElementById('pagered').style.display = str;
    document.getElementById('pagered_info').style.display = str;
    document.getElementById('pagered_other').style.display = str;
}

/**
* 查询路由信息
* @param
* @return 
*/
function queryRouteInfo()
{
    //var editright = $("#editright").val();
    //if (editright == "true")
    //{
    	$('#modifyinfo').show();
        isThisHidden('none');
        $('#whichedit').val(1);
        //在对电话或宽带信息的一个判断
        var thisDh = $('#Dh').val();
        var thecolum = $('#thishiddencolumn').val();
        var thesql = $('#thishiddensql').val();
        var thiscolum = thecolum.split(',');
        var theinput = '<hr/>';
        var len = thiscolum.length;
        var theresult = '';
        var flags = "disabled='disabled'";
	    if('<%=session.getAttribute("userid") %>'=='admin'){
	    	flags = '';
	    }
        for (var i = 0 ; i < thiscolum.length; i++)
        {
            var thevalue = getTheValues(thiscolum[i]);
            theresult += thevalue + ',';
           
            theinput += "<p style='margin-left:100px'><span class='tmpspanstyle'>" + thiscolum[i] + "</span><input class='n_value' type='text' id='" + thevalue + "' disabled='disabled'/><input type='hidden' class='par_noo' id='" + thevalue + "_h' /><input class='src_value' type='hidden' id='" + thevalue + "_y' /><button style='margin-left:10px' class='btn_2k3' "+flags+" id='" + thevalue + "b' onclick=getDeviceType('" + thevalue + "')><fmt:message key='userline.changedevice'/></button><button class='btn_2k3' style='margin-left:20px' "+flags+" id='" + thevalue + "c' onclick=clearTheValue('" + thevalue + "')><fmt:message key='userline.cleardata'/></button></p><hr/>" ;
        }
        $("#thisinput").html(theinput);
        var urlstr = tsd.buildParams(
        {
            packgname : 'service', //java包
            clsname : 'ExecuteSql', //类名
            method : 'exeSqlData', //方法名
            ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf : 'mssql', //指向配置文件名称
            tsdoper : 'query', //操作类型 
            datatype : 'xmlattr', //返回数据格式 
            tsdpk : 'userLineManager.getTheVlaue'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax(
        {
            url : 'mainServlet.html?' + urlstr + '&column=' + thesql + '&Dh=' + thisDh, datatype : 'xml', 
            cache : false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout : 1000, async : false , //同步方式
            success : function (xml)
            {
                $(xml).find('row').each(function ()
                {
                    var arr = theresult.split(',');
                    var theloginfo = '';
                    for (var i = 0 ; i < arr.length ; i++)
                    {
                        if (arr[i] != '' && undefined != arr[i]) {
                            $('#' + arr[i]).val($(this).attr(arr[i].toLowerCase()));
                            $('#' + arr[i] + '_y').val($(this).attr(arr[i].toLowerCase()));
                            theloginfo += $(this).attr(arr[i].toLowerCase()) + ',';
                        }
                    }
                    $('#thestainfo').val(theloginfo);
                });
            }
        });
        var linefields = getLineFields();
        if (linefields != '' && linefields != null)
        {
            var thelinefields = linefields.split(',');
            for (var i = 0; i < thelinefields.length - 1; i++)
            {
                if (document.getElementById(thelinefields[i]) != '' && document.getElementById(thelinefields[i]) != null)
                {
                    document.getElementById(thelinefields[i] + 'b').disabled = false;
                    document.getElementById(thelinefields[i] + 'c').disabled = false;
                }
            }
        }
        autoBlockForm('editform', 5, 'editclose', "#ffffff", false);
        //弹出查询面板
    //}
    //else {
    //    alert('<fmt:message key="userline.theright"/>!');
    //}
}

/**
* 根据设备val值，获取别名
* @param thename：设备val值
* @return 
*/
function getTheValues(thename)
{
    var thevalue = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'userLineManager.getthevalues'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&DeviceName=' + tsd.encodeURIComponent(thename), datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                thevalue = $(this).attr("FieldName".toLowerCase());
            });
        }
    });
    return thevalue;
}




/**
* 根据部门获取用户权限
* @param bm：部门信息
* @return 用户权限字符串
*/
function getUserOperation(bm)
{
    var thevalue = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'userLineManager.getbm'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&Bm=' + tsd.encodeURIComponent(bm), datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                thevalue = $(this).attr("UserOperate".toLowerCase());
            });
        }
    });
    return thevalue;
}

/**
* 查询路由详细信息 
* @param
* @return
*/
function queryBandInfo()
{
	$('#modifyinfo').show();
    isThisHidden('none');
    var thisDh = $('#Dh').val();
    var thecolum = $('#thisbroadcolumn').val();
    var thesql = $('#thisbroadhiddensql').val();
    var thiscolum = thecolum.split(',');
    var theinput = '';
    var len = thiscolum.length;
    var theresult = '';
    var flags = "disabled='disabled'";
    if('<%=session.getAttribute("userid") %>'=='admin'){
    	flags = '';
    }
    for (var i = 0 ; i < thiscolum.length; i++)
    {
        var thevalue = getTheValues(thiscolum[i]);
        theresult += thevalue + ',';
        //theinput += "<p><label>" + thiscolum[i] + "</label><input type='text' id='" + thevalue + "' disabled='disabled'/><button disabled='disabled' id='" + thevalue + "b' onclick=getDeviceType('" + thevalue + "')><fmt:message key='userline.changedevice'/></button><button style='margin-left:10px;margin-right:105px' disabled='disabled' id='" + thevalue + "c' onclick=clearTheValue('" + thevalue + "')><fmt:message key='userline.cleardata'/></button></p>" ;
    	theinput += "<p style='margin-left:100px'><span class='tmpspanstyle'>" + thiscolum[i] + "</span><input class='n_value' type='text' id='" + thevalue + "' disabled='disabled'/><input class='par_noo' type='hidden' id='" + thevalue + "_h' /><input class='src_value' type='hidden' id='" + thevalue + "_y' /><button style='margin-left:10px' class='btn_2k3' "+flags+" id='" + thevalue + "b' onclick=getDeviceType('" + thevalue + "')><fmt:message key='userline.changedevice'/></button><button class='btn_2k3' style='margin-left:20px' "+flags+" id='" + thevalue + "c' onclick=clearTheValue('" + thevalue + "')><fmt:message key='userline.cleardata'/></button></p><hr/>" ;
    }
    $("#thisinput").html('<hr/>'+theinput);
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'userLineManager.getTheVlaue'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&column=' + thesql + '&Dh=' + thisDh, datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var theloginfo = '';
                for (var i = 1 ; i <= len ; i++)
                {
                    $('#Value' + i).val($(this).attr("value" + i));
                    $('#Value' + i + '_y').val($(this).attr("value" + i));
                    theloginfo += $(this).attr("value" + i) + ',';
                }
                $('#thestainfo').val(theloginfo);
            });
        }
    });
    var linefields = getLineFields();
    if (linefields != '' && linefields != null)
    {
        var thelinefields = linefields.split(',');
        for (var i = 0; i < thelinefields.length - 1; i++)
        {
            if (document.getElementById(thelinefields[i]) != '' && document.getElementById(thelinefields[i]) != null)
            {
                document.getElementById(thelinefields[i] + 'b').disabled = false;
                document.getElementById(thelinefields[i] + 'c').disabled = false;
            }
        }
    }
    autoBlockForm('editform',5, 'editclose', "#ffffff", false);
    //弹出查询面板
}

/**
* 获取变更的端子，并更新状态
* @param
* @return
*/
function updateChangedCell()
{
	var conts = $("#thisinput p");
	var freestr = "";
	var usingstr = "";
	var fv = fetchMultiKVValue("userLineManager.getnoandfield",6,"",["fieldname","deviceno"]);
	
	$(conts).each(function(i,n){
		var nval = $(":text.n_value",n).val();
		var sval = $("input.src_value",n).val();
		var pno = $("input.par_noo",n).val();
		var zno = $(":text.n_value",n).attr("id");
		if(sval=="" && nval!=sval)
			usingstr += " or (DeviceNo like '" + pno + "%' and NodeName='" + nval + "')";
		if(sval!="")
		{
			if(nval=="")
			{
				freestr += " or (DeviceNo like '" + fv[zno] + "%' and NodeName='" + sval + "')";
			}
			else if(nval!=sval)
			{
				usingstr += " or (DeviceNo like '" + pno + "%' and NodeName='" + nval + "')";
				freestr += " or (DeviceNo like '" + fv[zno] + "%' and NodeName='" + sval + "')";
			}
		}
	});
	
	usingstr = usingstr.replace("or","");
	freestr = freestr.replace("or","");
	
	if($.trim(usingstr)!="")
		executeNoQuery("userLineManager.updatestate",6,"&nstate=using&fuhesql=" + encodeURIComponent(usingstr));
		
	if($.trim(freestr)!="")
		executeNoQuery("userLineManager.updatestate",6,"&nstate=free&fuhesql=" + encodeURIComponent(freestr));
	
}

/**
* 对更新的路由信息进行保存
* @param
* @return
*/
function updateRouteInfo()
{
    isThisHidden('block');
    var thisDh = $('#Dh').val();
    var thecolum = '';
    var thesql = '';
    var thiscolum = '';
    var thissql = '';
    var thepk = '';
    var theparam = '';
    var theflag = 0;
    //判断是做号线还是电话修改
    var whichedit = $('#whichedit').val();
    if (isAir_Line(thisDh) == true)
    {
        //如果在号线表中存在当前电话记录，执行修改语句
        thepk = 'userLineManager.updateRouteInfo';
        var theupdatesql = '';
        //是否是修改宽带用户信息
        if (whichedit == 1)
        {
            thecolum = $('#thishiddencolumn').val();
            thesql = $('#thishiddensql').val();
            thiscolum = thecolum.split(',');
            thissql = thesql.split(',');
            var thestaloginfo = $('#thestainfo').val();
            var stainfoarr = '';
            if (thestaloginfo.indexOf(',') !=- 1) {
                stainfoarr = thestaloginfo.split(',');
            }
            var theloginfo = '';
            for (var i = 0 ; i < thissql.length; i++)
            {
                theupdatesql += thissql[i] + "='" + tsd.encodeURIComponent($('#' + thissql[i]).val()) + "',";
                if (stainfoarr != '')
                {
                    if (stainfoarr[i] != $('#' + thissql[i]).val())
                    {
                        theloginfo += tsd.encodeURIComponent(thiscolum[i]) + ':' + tsd.encodeURIComponent(stainfoarr[i]) + '>>>' + tsd.encodeURIComponent($('#' + thissql[i]).val()) + ';';
                    }
                }
            }
            writeLineInfo('', tsd.encodeURIComponent('电话号线'), tsd.encodeURIComponent('修改用户[' + thisDh + ']的电话号线资料信息：') + theloginfo);
            theflag = 1;
        }
        else
        {
            thecolum = $('#thisbroadcolumn').val();
            thesql = $('#thisbroadhiddensql').val();
            thiscolum = thecolum.split(',');
            thissql = thesql.split(',');
            var thestaloginfo = $('#thestainfo').val();
            var stainfoarr = '';
            if (thestaloginfo.indexOf(',') !=- 1) {
                stainfoarr = thestaloginfo.split(',');
            }
            var theloginfo = '';
            for (var i = 0 ; i < thissql.length; i++)
            {
                theupdatesql += thissql[i] + "='" + tsd.encodeURIComponent($('#' + thissql[i]).val()) + "',";
                if (stainfoarr != '')
                {
                    if (stainfoarr[i] != $('#' + thissql[i]).val() && stainfoarr[i] != 'undefined')
                    {
                        theloginfo += tsd.encodeURIComponent(thiscolum[i]) + ':' + tsd.encodeURIComponent(stainfoarr[i]) + '>>>' + tsd.encodeURIComponent($('#' + thissql[i]).val()) + ';';
                    }
                }
            }
            writeLineInfo('', tsd.encodeURIComponent('宽带号线'), tsd.encodeURIComponent('修改用户[' + thisDh + ']的宽带号线资料信息：') + theloginfo);
            theflag = 2;
        }
        var num = theupdatesql.lastIndexOf(',');
        var thisupdatesql = theupdatesql.substring(0, num);
        theparam = '&str=' + thisupdatesql + '&Dh=' + thisDh;
    }
    else
    {
        //insert into air_line(<str>) value(<thevalue>);
        //如果在号线表中不存在当前电话记录，执行添加语句
        thepk = 'userLineManager.addRouteInfo';
        var thevalue = '';
        if (whichedit == 1)
        {
            thesql = $('#thishiddensql').val() + ',Dh';
            thissql = thesql.split(',');
            thecolum = $('#thishiddencolumn').val();
            thiscolum = thecolum.split(',');
            var theloginfo = '';
            for (var i = 0 ; i < thissql.length; i++)
            {
                //var thevalue = getTheValues(thissql[i]);
                thevalue += "'" + tsd.encodeURIComponent($('#' + thissql[i]).val()) + "',";
                if (thiscolum[i] != undefined && $('#' + thissql[i]).val()!='')
                {
                    theloginfo += tsd.encodeURIComponent(thiscolum[i]) + ':' + tsd.encodeURIComponent($('#' + thissql[i]).val()) + ',';
                }
            }
            theflag = 1;
            writeLineInfo('',tsd.encodeURIComponent('电话号线'), tsd.encodeURIComponent('添加用户[' + thisDh + ']的电话号线资料信息：') + theloginfo);
        }
        else
        {
            thesql = $('#thisbroadhiddensql').val() + ',Dh';
            thissql = thesql.split(',');
            thecolum = $('#thisbroadcolumn').val();
            thiscolum = thecolum.split(',');
            var theloginfo = '';
            for (var i = 0 ; i < thissql.length; i++)
            {
                //var thevalue = getTheValues(thissql[i]);
                thevalue += "'" + tsd.encodeURIComponent($('#' + thissql[i]).val()) + "',";
                if (thiscolum[i] != undefined &&  $('#' + thissql[i]).val()!='')
                {
                    theloginfo += tsd.encodeURIComponent(thiscolum[i]) + ':' + tsd.encodeURIComponent($('#' + thissql[i]).val()) + ',';
                }
            }
            theflag = 2;
            writeLineInfo('', tsd.encodeURIComponent('宽带号线'), tsd.encodeURIComponent('添加用户[' + thisDh + ']的宽带号线资料信息：') + theloginfo);
        }
        //thevalues = thevalue + "'"+thisDh+"'";
        thevalues = thevalue.substring(0, thevalue.lastIndexOf(','));
        theparam = '&str=' + thesql + '&thevalue=' + thevalues;
    }
    //str返回数据格式：str=Value1='a',Value2='b',Value3='c'
    var tempstr_ = theparam.substring(theparam.indexOf('=') + 1, theparam.lastIndexOf('&'));
    var disflag = isNeeded(tempstr_);
    if (disflag == true) {
        return;
    }
    ///设置命令参数
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : thepk//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + theparam, cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (msg)
        {
            if (msg == "true")
            {
                var operationtips = $("#operationtips").val();
                var successful = $("#successful").val();
                alert(successful, operationtips);
                
                updateChangedCell();
                /*************
                 ** 释放资源 **
                 ************/
                setTimeout($.unblockUI, 15);
                if (theflag == 1)
                {
                    var column = $('#thisroute').val();
                    reloadRouteData('XQLineManager.querylineinfo', 'XQLineManager.querylineinfopage', 
                    'editgrid_info', thisDh, column) 
                }
                else if (theflag == 2)
                {
                    var column = $('#thisbroad').val();
                    reloadRouteData('XQLineManager.querylineinfo', 'XQLineManager.querylineinfopage', 
                    'editgrid_other', thisDh, column) 
                }
            }
        }
    });
}

/**
* 号线修改信息日志记录
* @param
* @return
*/
function writeLineInfo(modulename,logintype,loginfo){
	if(''==modulename){
		modulename = genModelName();
	}
	if(logintype!=''&&logintype!=null){
		var urlstr=tsd.buildParams({ 	
				 		 				packgname:'service',//java包
							 			clsname:'ExecuteSql',//类名
							 			method:'exeSqlData',//方法名
							 			ds:'tsdLog',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
							 			tsdcf:'mssql',//指向配置文件名称
							 			tsdoper:'exe',//操作类型 
							 			tsdpk:'userLineManager.loginfo'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							 		});
		$.ajax({
			url:'mainServlet.html?'+urlstr+'&userid=<%=session.getAttribute("userid") %>&modulename='+modulename+'&logtype='+logintype+'&loginfo='+loginfo+'&ipaddress=<%=Log.getIpAddr(request) %>',                    
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 3000,
			async: false ,//同步方式
			success:function(msg){}
		});
	}
}


/**
* 数据校验，判断配置信息是否有空值
* @param thesql：需要验证的字符串
* @return falg true：配置信息有空值 ；false：配置信息符合要求
*/
function isNeeded(thesql)
{
    var falg = false;
    thesql = thesql.replace(/\'/g, '');
    var valarr = thesql.split(',');
    var strarr = new Array();
    for (var i = 0 ; i < valarr.length; i++) {
        var tarr = valarr[i].split('=');
        if (tarr[1] == '') {
            //选项为空的保留
            strarr.push(tarr[0]);
        }
    }
    var type = $('#disoper').val();
    var sql = 'userLineManager.getneedvalue';
    //区分电话还是宽带
    if (type == 'broadband') {
        type = '宽带';
    }
    else if (type = 'phone') {
        type = '电话';
    }
    else if (type = 'sysoper') {
    	sql = 'userLineManager.getneedvaluelimit';
    }
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : sql//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?area=' + tsd.encodeURIComponent('<%=session.getAttribute("userarea")%>') + '&type=' + tsd.encodeURIComponent(type) + urlstr, 
        datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
        	var tipinfos = '';
            $(xml).find('row').each(function ()
            {
            
                var air_node = $(this).attr("air_node");
                if (air_node != undefined)
                {
                    tipinfos += air_node + '~';
                }
            });
            tipinfos = tipinfos.substring(0,tipinfos.lastIndexOf('~'));
            for (var i = 0 ; i < strarr.length; i++)
            {
                if (tipinfos.indexOf(strarr[i]) !=- 1)
                {
                    var devicename = getDeviceName(strarr[i]);
                    alert('对不起，[' + devicename + ']配置信息不允许为空，请重新选择设备!');
                    falg = true;
                    break;
                }
            }
        }
    });
    return falg;
}

/**
*  取设备名称
* @param fieldName 设备val值
* @return 返回设备名称
*/	
function getDeviceName(fieldname)
{
    var valstr = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'userLineManager.getdevicename'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?fieldname=' + tsd.encodeURIComponent(fieldname) + urlstr, datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var str = $(this).attr("DeviceName".toLowerCase());
                if (str != undefined) {
                    valstr = str;
                }
            });
        }
    });
    return valstr;
}

/**
* 获取当前用户所在部门的模块局
* @param 
* @return 
* 改方法被 getMoKuaiJusByArea
function getMoKuaiJus()
{
    var mkjs = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'userLineManager.getMoKuaiJus'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    var departname = $('#departname').val();
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&departname=' + tsd.encodeURIComponent(departname), datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                mkjs = $(this).attr("modimokuaijus");
            });
        }
    });
    return mkjs;
}
*/
		/*********
		* 获取当前用户运行管理的模块局
		* @param;
		* @return;
		**********/
		function getMoKuaiJusByArea()
		{
			var managearea = $("#managearea_hidden").val();
			var userid ="<%=userid %>";
			var mokuaiju="";//存放用户可管理模块局			
			var userarea="";//存放用户可管理区域
			if(managearea!=undefined && managearea!=""){	
				userarea = "'"+managearea.toString().replace(new RegExp("~","g"),"','")+"'";
			}
			var key="";
			if(userid=="admin"){
				key="userLineManager.getAllMoKuaiJu";
			}else{
				key="userLineManager.getMoKuaiJus";			
			}
			var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mysql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					//tsdpk:"PhoneKaiHu.queryasys_areaywmokuaiju",//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdpk:key,
						 					tsdUserID:'ture'
						 				});	
		                   $.ajax({
					              url:'mainServlet.html?'+urlstr+'&area='+tsd.encodeURIComponent(userarea),
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){					              
					              $(xml).find('row').each(function(){					              	
					              	if(userid=="admin"){
										mokuaiju+=$(this).attr("mokuaiju")+',';
									}else{
										mokuaiju+=$(this).attr("ywmokuaiju")+',';		
									}
					              });
					              }
					       });
			//接却模块局拼接字符串的最后一个逗号
			if(mokuaiju.substr(mokuaiju.length-1)==','){
				mokuaiju=mokuaiju.substr(0,mokuaiju.length-1);
			}
			//generateTree(mokuaiju,mokuaijudq);
			return mokuaiju;
		}
       
/**
* 获取当前用户所在部门的LineFields
* @param 
* @return 
*/            
function getLineFields()
{
    var linefields = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'userLineManager.getLineFields'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    var departname = $('#departname').val();
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&Bm=' + tsd.encodeURIComponent(departname), datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                linefields += $(this).attr("LineFields".toLowerCase()) + ',';
            });
        }
    });
    var num = linefields.lastIndexOf(',');
    linefields = linefields.substring(0, num);
    return linefields;
}


/**
* 打开二级设备管理窗口
* @param NodeField：设备别名
* @return 
*/
function getDeviceType(NodeField)
{
    var mkj = $('#limitroute').val();
    window.showModalDialog('mainServlet.html?pagename=telephone/linemanagement/theDeviceType.jsp&NodeField=' + NodeField + '&mkj=' + tsd.encodeURIComponent(mkj), 
    window, "dialogWidth:820px; dialogHeight:450px; center:yes; scroll:yes");
}

/**
* 获取当前地址下拉框值
* @param id： 隐藏域id值
* @param strlen：地址id中截取的字符串长度
* @param strid：addrcode值
* @param str：提示信息
* @return 
*/
function getAddrName(id, strlen, strid, str)
{
    var thesql = 'userLineManager.getAddrName';
    if (strid == '') {
        thesql = 'userLineManager.getAddrNameBymkj';
    }
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : thesql//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    if (strid != '')
    {
        strid = $('#' + strid).val();
        if (strid == 0)
        {
            var operationtips = $("#operationtips").val();
            //var successful = $("#successful").val();
            alert('<fmt:message key="ip.select"/>' + str, operationtips);
            return false;
        }
    }
    if (strid == '')
    {
        var userarea = '<%=request.getSession().getAttribute("managearea")%>';
        if (userarea != '' && null != userarea)
        {
            var m = 0;
            if (userarea.indexOf('~') ==- 1) {
                userarea += '~';
                m = 1;
            }
            var thearea = userarea.split('~');
            for (var i = 0 ; i < thearea.length - m; i++)
            {
                $.ajax(
                {
                    url : 'mainServlet.html?' + urlstr + '&strlen=' + tsd.encodeURIComponent(strlen) + '&addrcode=' + tsd.encodeURIComponent(strid) + '&addrarea=' + tsd.encodeURIComponent(thearea[i]), 
                    datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
                    timeout : 1000, async : false , //同步方式
                    success : function (xml)
                    {
                        var checkaddrname = $("#selectaddrname").val();
                        $("#" + id).html("<option value='0'>" + checkaddrname + "</option>");
                        var addrname = '';
                        $(xml).find('row').each(function ()
                        {
                            if ($(this).attr("addrname") != undefined)
                            {
                                addrname += "<option value='" + $(this).attr("addrcode") + "'>" + $(this).attr("addrname") + "</option>";
                            }
                            else {
                                alert('暂无数据显示!');
                            }
                        });
                        $("#" + id).html($("#" + id).html() + addrname);
                    }
                });
            }
        }
        else {
            alert('<fmt:message key="userline.thearea"/>!');
        }
    }
    else
    {
        $.ajax(
        {
            url : 'mainServlet.html?' + urlstr + '&strlen=' + tsd.encodeURIComponent(strlen) + '&addrcode=' + tsd.encodeURIComponent(strid), 
            datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout : 1000, async : false , //同步方式
            success : function (xml)
            {
                var checkaddrname = $("#selectaddrname").val();
                $("#" + id).html("<option value='0'>" + checkaddrname + "</option>");
                var addrname = '';
                $(xml).find('row').each(function ()
                {
                    if ($(this).attr("addrname") != undefined)
                    {
                        addrname += "<option value='" + $(this).attr("addrcode") + "'>" + $(this).attr("addrname") + "</option>";
                    }
                    else {
                        alert('暂无数据显示!');
                    }
                });
                $("#" + id).html($("#" + id).html() + addrname);
            }
        });
    }
}


/**
* 查询当前用户的详细地址
* @param key： 判断电话或宽带的标识
* @return 
*/
function queryUserAddr(key)
{
    var editright = $("#editright").val();
    if (editright == "true")
    {
        $('#thisDh').val(key);
        if (isBroad(key) == false) {
            $('#thisedit').val(1);
            //电话
        }
        else {
            $('#thisedit').val(2);
            //宽带
        }
        var urlstr = tsd.buildParams(
        {
            packgname : 'service', //java包
            clsname : 'ExecuteSql', //类名
            method : 'exeSqlData', //方法名
            ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf : 'mssql', //指向配置文件名称
            tsdoper : 'query', //操作类型 
            datatype : 'xmlattr', //返回数据格式 
            tsdpk : 'userLineManager.getUserAddr'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax(
        {
            url : 'mainServlet.html?' + urlstr + '&Dh=' + tsd.encodeURIComponent(key), datatype : 'xml', 
            cache : false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout : 1000, async : false , //同步方式
            success : function (xml)
            {
                $(xml).find('row').each(function ()
                {
                    var useraddress = $(this).attr("userAddr".toLowerCase());
                    $('#useraddress').html(useraddress);
                    $('#userstaaddress').val();
                });
                clearText('addforms');
                autoBlockForm('addform', 20, 'close', "#ffffff", false);
                //弹出查询面板
            }
        });
    }
    else {
        alert('<fmt:message key="global.editright"/>!');
    }
}

/**
* 用户详细信息面板修改按钮事件 执行修改操作
* @param 
* @return 
*/
function editinfo()
{
    var xiaoquhao = $('#xiaoquhao').val();
    var loudonghao = $('#loudonghao').val();
    var danyuanhao = $('#danyuanhao').val();
    var mengpaihao = $('#mengpaihao').val();
    if (xiaoquhao == '0')
    {
        var operationtips = $("#operationtips").val();
        //var successful = $("#successful").val();
        //请选择小区号
        alert("<fmt:message key='ip.seelct'/><fmt:message key='userline.xqh'/>!", operationtips);
        $('#xiaoquhao').focus();
        return false;
    }
    if (loudonghao == '0')
    {
        var operationtips = $("#operationtips").val();
        //var successful = $("#successful").val();
        //请选择楼栋号
        alert("<fmt:message key='ip.seelct'/><fmt:message key='userline.ldh'/>!", operationtips);
        $('#loudonghao').focus();
        return false;
    }
    if (danyuanhao == '0')
    {
        var operationtips = $("#operationtips").val();
        //var successful = $("#successful").val();
        //请选择单元号
        alert("<fmt:message key='ip.seelct'/><fmt:message key='userline.dyh'/>!", operationtips);
        $('#danyuanhao').focus();
        return false;
    }
    if (mengpaihao == '0')
    {
        var operationtips = $("#operationtips").val();
        //var successful = $("#successful").val();
        //请选择门牌号
        alert("<fmt:message key='ip.seelct'/><fmt:message key='userline.mph'/>!", operationtips);
        $('#mengpaihao').focus();
        return false;
    }
    var thisDh = $("#thisDh").val();
    xiaoqu = queryAddr(xiaoquhao);
    loudong = queryAddr(loudonghao);
    danyuan = queryAddr(danyuanhao);
    mengpai = queryAddr(mengpaihao);
    var useraddr = xiaoqu + loudong + danyuan + mengpai;
    ///设置命令参数
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : 'userLineManager.edit'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&Dh=' + thisDh + '&userAddr=' + tsd.encodeURIComponent(useraddr), 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (msg)
        {
            if (msg == "true")
            {
                var theedit = $('#thisedit').val();
                if (theedit == 1)
                {
                    /********************************************
                                        *  修改地址电话的地址时，同时修改yhdang表里该电话的地址，
                                        *
                                        ********************************************/
                    updateUserInfo(thisDh, useraddr);
                    /*******************************************
                                        * 如果该用户有宽带，
                                        * 则同时修改air_users表里该电话的宽带的地址和redcheck(mysql数据库)表中的地址。
                                        *********************************************/
                    if (isBroad(thisDh) == true) {
                        updateBroadInfo(thisDh, useraddr);
                    }
                }
                else if (theedit == 2)
                {
                    /********************************************
                                        *  修改宽带的地址时，同时修改redcheck(mysql数据库)表中的地址，
                                        *
                                        ************************************/
                    updateBroadInfo(thisDh, useraddr);
                    /********************************************************
                                        *  如果该用户装了电话，则修改air_users表中该用户的电话的地址和yhdang表中的地址。
                                        *
                                        ********************************************/
                    if (isDh(thisDh) == true) {
                        updateUserInfo(thisDh, useraddr);
                    }
                }
                var userstaaddress = $('#userstaaddress').val();
                writeLogInfo('', 'modify', tsd.encodeURIComponent('<fmt:message key="userline.editaddr"/>：') + tsd.encodeURIComponent(userstaaddress) + '>>>' + tsd.encodeURIComponent(useraddr));
                var operationtips = $("#operationtips").val();
                var successful = $("#successful").val();
                alert(successful, operationtips);
                /*************
                ** 释放资源 **
                ************/
                setTimeout($.unblockUI, 15);
                clearText('addforms');
                var thismkj = $('#thismkj').val();
                var column = $('#thiscolumn').val();
                reloadThisData('userLineManager.query', 'userLineManager.querypage', 'editgrid', thismkj, 
                column);
            }
        }
    });
}

/**
* 查看当前的用户是否已装宽带
* @param Dh:电话
* @return flag=true：已安装宽带；flag=false：未安装宽带
*/
function isBroad(Dh)
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
        tsdpk : 'userLineManager.isbroad'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&jhj=' + Dh, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var DhType = $(this).attr("DhType".toLowerCase());
                if (DhType == 'broadband') {
                    flag = true;
                }
            });
        }
    });
    return flag;
}


/**
* 查看当前的用户是否已装电话
* @param Dh:电话
* @return flag=true：已安装电话；flag=false：未安装电话
*/
function isDh(Dh)
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
        tsdpk : 'userLineManager.isdh'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&Dh=' + Dh, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var jhj = $(this).attr("jhj");
                if (jhj != '' && jhj != null) {
                    flag = true;
                }
            });
        }
    });
    return flag;
}


/**
* 查看当前的号码已经在号线表里有记录
* @param Dh:电话
* @return flag=true：已有记录；flag=false：没有记录
*/
function isAir_Line(Dh)
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
        tsdpk : 'userLineManager.isair_line'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&Dh=' + Dh, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var num = $(this).attr("num");
                if (num != 0) {
                    flag = true;
                }
            });
        }
    });
    return flag;
}


/**
* 根据地址编码，获取地址名称 
* @param addrcode：地址编码
* @return 返回地址名称
*/
function queryAddr(addrcode)
{
    var addrname = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'userLineManager.getAddr'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&addrcode=' + tsd.encodeURIComponent(addrcode), datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                addrname += $(this).attr("addrname");
            });
        }
    });
    return addrname;
}


/**
* 获取交换机相关信息
* @param val：交换机名称
* @return 返回该交换机相关信息
*/
function getDeviceTips(val)
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
        tsdpk : 'userLineManager.getdevicetipsval'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?FieldName=' + val + urlstr, datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var str = $(this).attr("DeviceName".toLowerCase());
            	if(str!=undefined){
            		var stricon = $(this).attr("DeviceIcon".toLowerCase());
            		arr.push(str);
            		arr.push(stricon);
            	}
            });
        }
    });
    return arr;
}

/**
* 同步更新用户档地址信息
* @param Dh：用户电话
* @param Yhdz：地址信息
* @return 
*/
function updateUserInfo(Dh, Yhdz)
{
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : 'userLineManager.updateuserinfo'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&Yhdz=' + tsd.encodeURIComponent(Yhdz) + '&Dh=' + Dh, cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (msg) {}
    });
}


/**
* 如果用户装了宽带，同步更新用户宽带地址信息 
* @param Dh：用户电话
* @param Yhdz：地址信息
* @return 
*/
function updateBroadInfo(Dh, Yhdz)
{
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'broadband', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mysql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : 'userLineManager.updatebroadinfo'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&sAddress=' + tsd.encodeURIComponent(Yhdz) + '&sDh=' + Dh, 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (msg) {}
    });
}
  
/**
 * 进行通用查询 批量删除 批量修改入口；
 	根据隐藏域queryName 判断是何种操作 delete：批量删除 ；modify：批量修改；其他：高级查询
 * @param 
 * @return 
 */  
function fuheExe()
{
    var thismkj = $('#thismkj').val();
    //var thiscolumn= $('#thiscolumn').val();
    var queryName = $('#queryName').val();
    if (queryName == "query")
    {
        fuheQueryUserLine('XQLineManager.fuhequerybywhere', 'XQLineManager.fuhequerybywherepage', thismkj, thiscolumn);
    }
}

/**
 * 重载用户资料信息
 * @param 
 * @return 
 */ 
function reloadThisData(tsdpk, tsdpksql, gridid, thismkj, column)
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
        url : 'mainServlet.html?' + urlstr + '&str=' + thismkj + '&cloumn=' + column
    }).trigger("reloadGrid");
    setTimeout($.unblockUI, 15);
    //关闭面板
}





/**
 * 对下拉选项中没有的小区、楼栋、单元、门牌号码进行添加
 * @param 
 * @return 
 */
function addnewinfo()
{
    var groupid = $('#zid').val();
    window.showModalDialog('mainServlet.html?pagename=telephone/linemanagement/addressManage.jsp&imenuid=1085&pmenuname=号线管理 &imenuname=地址库管理 &groupid=' + groupid, 
    window, "dialogWidth:820px; dialogHeight:650px; center:yes; scroll:yes");
}

/**
 * 回调函数，用于设置设备时自动设置相同段中的其它设备
 * @param thei 字段名
 * @param str  值
 * @param pdvno二级设备编号 
 * @return 
 */
function getTheVlaue(thei, str, pdvno)
{
    $('#' + thei).val(str);
    $('#' + thei + "_h").val(pdvno);
    var dno = fetchSingleValue("routeSegment.getdeviceno",6,"&DeviceNo=" + tsd.encodeURIComponent(pdvno) + "&NodeName=" + tsd.encodeURIComponent(str));
    $(":button[difinedbysegment='"+thei+"']").prev(":text").val("");
    $(":button[difinedbysegment='"+thei+"']").removeAttr("difinedbysegment").removeAttr("disabled");
    var res = fetchMultiPValue("routeSegment.Proc",6,"&Func=GetSegmentWithFieldname&DeviceNo=" + dno);
    
    if(res[0]!=undefined && res[0][0]=='OK')
    {
	    var prevNode=res[0][1];
	    var nextNode=res[0][2];
	    if(prevNode!="")
	    {
		    if(prevNode.indexOf("_+_")>0)
		    	prevNode = prevNode.split("_+_");
		    else
		    	prevNode = [prevNode];
		    for(var i=0;i<prevNode.length;i++)
		    {
		    	var tmp = prevNode[i];
		    	$("#" + tmp[0]).val(tmp[1]);
		    	$("#" + tmp[0] + "b,#"+ tmp[0] + "c").attr({"difinedbysegment":thei,"disabled":"disabled"});
		    }
		    
	    }
	    if(nextNode!="")
	    {
		    if(nextNode.indexOf("_+_")>0)
		    	nextNode = nextNode.split("_+_");
		    else
		    	nextNode = [nextNode];
		    
		    for(var i=0;i<nextNode.length;i++)
		    {
		    	var tmp = nextNode[i].split(",");
		    	$("#" + tmp[0]).val(tmp[1]);
		    	$("#" + tmp[0] + "b,#"+ tmp[0] + "c").attr({"difinedbysegment":thei,"disabled":"disabled"});
		    }
		    
	    }
    }
    
}

/**
 * 在页面初始化时,鼠标焦点定位
 * @param 
 * @return 
 */
function thisOnfocus()
{
    $('#thisinputvalue').focus();
}





/**
 * 拼接要显示的数据列
 * @param tablename：表名，用于查询字段名和字段别名
 * @return 返回数据列
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
 * 导出数据按钮事件，获取选中的数据列
 * @param ds：数据源
 * @param tsdcf：数据源配置
 * @param table: 表名,要显示数据的表的名称
 * @param table2: 别名表中的table_name的值
 * @param flagfield：外加附带限制条件
 * @return 返回数据列
 */
function getTheCheckedFields_tmp(ds, tsdcf, table, table2, flagfield)
{
    var thename = document.getElementsByName('thefields');
    var thevalue = '';
    var theclos = '';
    var atable = table;
    if (table2 != undefined) {
        atable = table2;
    }
    var arr = displayFields(atable);
    for (var i = 0; i < thename.length; i++) {
        if (thename[i].checked == true) {
            theclos += arr[i] + ',';
        }
    }
    theclos = theclos.substring(0, theclos.lastIndexOf(','));
    //dataDownload('tsdBilling','mssql',theclos,'sys_user');
    
    thisDataDownload(ds, tsdcf, theclos, table, flagfield,table);
    //reloadData();
    //将面板关闭
    setTimeout($.unblockUI, 15);
}

/**********************************************************
				function name:    thisDataDownload(ds,tsdcf,cols,table)
				function:		  数据列下载
				parameters:       ds：数据源
								  tsdcf：sql配置
								  cols: 显示列
								  table: 表名
								  tmpdata:外加附带限制条件
								  table2:表别名
				return:			  
				description:    
********************************************************/
function thisDataDownload(ds,tsdcf,cols,table,flagsql,table2) {
						var params = fuheQbuildParams();
						var tsdpkstr ='';
						if(params=='&fusearchsql='){
							params +='1=1';
							tsdpkstr = 'XQLineManager.export';
						}else{
							tsdpkstr = 'XQLineManager.exportbywhere';
						}
						
						// $('#status').show();//显示LOADING…						 
						var exporttype = $('#thelistform [name="exporttype"][checked=true]:radio').val();	
						var querycountp='&table='+table+params;					
						var resvalue = querytablecount(querycountp);
						if(exporttype=='xls'&&parseInt(resvalue,10)>65535){
							alert("Excel数据导出超过系统最大值为65535条，无法执行导出操作！");
							return false;
						}else if(exporttype=='dbf'&&parseInt(resvalue,10)>100000){
							alert("dbf数据导出超过系统最大值十万条，无法执行导出操作！");
							return false;
						}else if(exporttype=='xmlx'&&parseInt(resvalue,10)>200000){
							alert("xml数据导出超过系统最大值二十万条，无法执行导出操作！");
							return false;
						}else if(exporttype=='txt'&&parseInt(resvalue,10)>500000){
							alert("txt数据掏出超过系统最大值50万条，无法执行导出操作！");
							return false;
						}				
						
						
						params += '&tablealias='+table2;
						
						if(cols!=''&&cols!=null&&cols!=undefined){
							params += '&cols='+cols;
						}else{
							alert('请选择导出字段!');
							return false;
						} 
						if(table!=''&&table!=null&&table!=undefined){
							params += '&table='+table;
						}else{
							alert('请选择导出字段!');
							return false;
						}																	
											
					    
					    params += '&exportflag=0';
					    //SELECT <cols> FROM <table> WHERE mokuaiju in(<str>) AND Dh='<Dh>'
					    //var column = $('#thiscolumn').val();
					    var dh = $('#thisinputvalue').val();
					    params += '&Dh=' + dh;
					    var thismkj = $('#thismkj').val();
					    params += '&str=' + tsd.encodeURIComponent(thismkj);
					    
					 	var urlstr=tsd.buildParams({packgname:'service',//java包
													clsname:'ExecuteSql',//类名
													method:'exeSqlData',//方法名
													ds:ds,//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
													tsdcf:tsdcf,//指向配置文件名称
													tsdoper:'query',//操作类型
													datatype:exporttype,//返回数据格式 
													tsdpk:tsdpkstr//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
													});													
						if($("#download").size()==0){
							$("body").append("<iframe id='download' name='download' width='0' height='0'></iframe>");
						}							
					    $("#download").attr("src","mainServlet.html?"+urlstr + params);				    	
}
					
</script>
<style type="text/css">
.titlemargin{margin-left:90px !important;margin-left:45px;}
.titlemargin2{margin-left:73px !important;margin-left:39px;}
.btn_2k3 {
	BORDER-RIGHT: #87CEFA 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #87CEFA 1px solid; 
	
	FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, 
	
	StartColorStr=#FFFFFF, EndColorStr=#87CEFA); BORDER-LEFT: #87CEFA 1px solid; CURSOR: hand; 
	
	COLOR: black; BORDER-BOTTOM: #87CEFA 1px solid;height:30px;line-height:30px
}
hr {margin:2px 0 2px 0;border:0;border-top:1px dashed #CCCCCC;height:0;}
.tmpspanstyle{display:-moz-inline-box; display:inline-block; width:115px;text-align:right;margin-right:10px}
.spanstyle{display:-moz-inline-box; display:inline-block; width:115px}
.neirong .midd_XQ{
	width:99.8%;
	height:100%;
	float:left;
	border-right:1px solid #60b2e3;
	border-left:1px solid #60b2e3;
	border-bottom:1px solid #60b2e3;
	background-color: #ffffff;
}
.neirong .midd_XQ table{
	font-size:12px;
	padding-right:1%;
	text-align: left
}
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
		<div id="navBar" style="width: 99%">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar1" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
							<fmt:message key="global.location" />
							:
						</div>
					</td>
					<td width="10%" align="right" valign="top">
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
		<div id="buttons" style="width: 99%">
			<label style="margin-left: 10px">
				<fmt:message key="userline.thenum" />
				:
				<input id='thisinputvalue' type="text" />
			</label>
			<button type="button" id='isquery' onclick="queryTheInfo()">
				<fmt:message key="global.query" />
			</button>
			<button type="button" id="openadd1" onclick="openaddRount();"
				>
				<fmt:message key="global.add" />
			</button>

			<button type="button" onclick="queryDhInfos()">
				查看用户信息
			</button>
			<button type="button" onclick="openDiaQueryG('query','air_users')">
				<fmt:message key="userline.thequery" />
			</button>
			<button style="display: none" type="button" id="print"
				onclick="printThisReport('air_users','')" disabled="disabled">
				<fmt:message key="usermanager.printreport" />
			</button>
			<button type="button" id="export"
				onclick="thisDownLoad('tsdBilling','mssql','air_users','<%=languageType%>',6)"
				disabled="disabled">
				<fmt:message key="global.exportdata" />
			</button>
			<button type="button" id="OpneMenuPhone" onclick="changeMenu('phone')"	>
				电话工单管理
			</button>
			<button type="button" id="OpneMenuBroadband" onclick="changeMenu('broadband')"	>
				宽带工单管理
			</button>
		</div>
		<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>
		
		<div id="dhdiv" >
			<table id="editgrid_info" class="scroll" cellpadding="0"
				cellspacing="0"></table>
			<div id="pagered_info" class="scroll" style="text-align: left;"></div>
		</div>
		<div id="broaddiv" >
			<table id="editgrid_other" class="scroll" cellpadding="0"
				cellspacing="0"></table>
			<div id="pagered_other" class="scroll" style="text-align: left;"></div>
		</div>


		<div class="neirong" id="addform" style="display: none; width: 800px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="userline.editaddr" />
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
				<form action="#" name="addforms" id="addforms"
					onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td class="labelclass">
								<fmt:message key="userline.staaddr" />
							</td>
							<td colspan="3" class="tdstyle">
								<label id="useraddress" style="width: 150px"></label>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<fmt:message key="userline.xqh" />
							</td>
							<td class="tdstyle">
								<select id="xiaoquhao" class="textclass" style="width: 150px"
									onfocus="getAddrName('xiaoquhao','4','','')">
									<option value="0">
										<fmt:message key="ip.select" />
									</option>
								</select>
							</td>
							<td class="labelclass">
								<fmt:message key="userline.ldh" />
							</td>
							<td class="tdstyle">
								<select id="loudonghao" class="textclass" style="width: 150px"
									onfocus="getAddrName('loudonghao','9','xiaoquhao','<fmt:message key="userline.xqh"/>')">
									<option value="0">
										<fmt:message key="ip.select" />
									</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="dflabelclass">
								<fmt:message key="userline.dyh" />
							</td>
							<td>
								<select id="danyuanhao" class="textclass" style="width: 150px"
									onfocus="getAddrName('danyuanhao','13','loudonghao','<fmt:message key="userline.ldh"/>')">
									<option value="0">
										<fmt:message key="ip.select" />
									</option>
								</select>
							</td>
							<td class="dflabelclass">
								<fmt:message key="userline.mph" />
							</td>
							<td>
								<select id="mengpaihao" class="textclass" style="width: 150px"
									onfocus="getAddrName('mengpaihao','17','danyuanhao','<fmt:message key="userline.dyh"/>')">
									<option value="0">
										<fmt:message key="ip.select" />
									</option>
								</select>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" id="saveuser"
					onclick="editinfo()">
					<fmt:message key="global.edit" />
				</button>

				<button type="button" id="close" class="tsdbutton"
					onclick="clearText('addforms')" style="margin-left: 10px">
					<fmt:message key="global.close" />
				</button>

				<button type="submit" id="adduser" class="tsdbutton"
					onclick="addnewinfo()" style="margin-left: 10px">
					<fmt:message key="global.add" />
				</button>
			</div>
		</div>


		<div class="neirong" id="editform" style="display: none; width: 800px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="userline.editroute" />
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#editclose').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form action="#" name="editforms" id="editforms"
					onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td>
								<div id='thisinput'
									style="height: 300px;overflow-y: auto; overflow-x: hidden;"></div>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" id="modifyinfo"
					style="margin-right: 10%" onclick="updateRouteInfo()">
					<fmt:message key="global.edit" />
				</button>

				<button type="button" class="tsdbutton" id="editclose"
					onclick="isThisHidden('block');clearText('editforms')">
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>
		
		<!-- 路由设置面板 -->
		<div class="neirong" id="addRountform" style="display: none; width: 800px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="userline.editroute" />
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#addRountclose').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form action="#" name="addRountforms" id="addRountforms"
					onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<!-- 
						<tr>
							<td>
								<div style="padding-left: 20px;">
									<label>路由类型：</label>
									<input type="radio" name="Rounttype"  value="1" onClick="checkradioval(this.value)" checked="checked"/><label>电话</label>
									<input type="radio" name="Rounttype"  value="2" onClick="checkradioval(this.value)"/><label>宽带</label>
									
									<img style="margin-left:60px;_margin-left:30px;" src="style/images/public/tubiao_3.jpg" />
									<a href="#" onclick="printRountPan(1,'add');">添加一个路由</a>
								
								</div>
							</td>
						</tr>
					-->
						<tr>
							<td>
								
								<div id='addRountinput'
									style="height: 300px;overflow-y: auto; overflow-x: hidden;"></div>
								<input type="hidden" id="xqlineid"/>
								<input type="hidden" id="xqlineid_old"/>
								<input type="hidden" id="lineid"/>								
								<input type="hidden" id="Rmemo"/>
								<input type="hidden" id="Rrounttype"/>
								<input type="hidden" id="Rdh"/>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" id="modifyRount"
					style="margin-right: 10%" onclick="saveRouteInfo('modify');">
					<fmt:message key="global.edit" />
				</button>
				
				<button type="submit" class="tsdbutton" id="saveRount"
					style="margin-right: 10%" onclick="saveRouteInfo('add');">
					<fmt:message key="global.add" />
				</button>
				<button type="submit" class="tsdbutton" id="ParallelRount"
					style="margin-right: 10%" onclick="saveRouteInfo('Parallel');">
					并机
				</button>
				
				<button type="button" class="tsdbutton" id="addRountclose"
					onclick="isThisHidden('block');clearText('addRountforms');">
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>
		
		
		
		<!-- 共享号线面板 -->
		<div class="neirong" id="shareRountform" style="display: none; width: 800px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							共享号线电话选择
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#shareRountclose').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd_XQ">
				<div style="width: 100%;float: left;" >
					<label style="margin-left: 10px;">
						<fmt:message key="userline.thenum" />
						:
						<input id='dh_Sel' type="text" />
					</label>
					<button type="button" id='isquery_Sel'  class="tsdbutton" onclick="querySelInfo();">
						<fmt:message key="global.query" />
					</button>
				</div>
				<form action="#" name="addRountforms" id="addRountforms"
					onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td>
								<div id='addRountinput'
									style="height: 300px;overflow-y: auto; overflow-x: hidden;">
									<table id="editgrid_share" class="scroll" cellpadding="0" cellspacing="0"></table>
									<div id="pagered_share" class="scroll" style="text-align: left;"></div>
								</div>								
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" id="shareRount"
					style="margin-right: 20px;" onclick="saveShare();">
					共享
				</button>				
				<button type="button" class="tsdbutton" id="shareRountclose"
					onclick="$('#dh_Sel').val();">
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>
		
		<!-- 选中共享电话 -->
		
		<input type="hidden" id="Dh_shareOld"/>		
		<input type="hidden" id="DhType_shareSel"/>		
		<input type="hidden" id="line_shareSel"/>
		<input type="hidden" id="lineinfo_sharSel"/>
		
		<input type="hidden" id="Dh_shareSel"/>
		<input type="hidden" id="languageType" value="<%=languageType%>" />
		<input type="hidden" id="departname" value="<%=departname%>" />
		<input type='hidden' id='thisbasePath' value='<%=basePath%>' />

		<input type='hidden' id='thismkj' />
		<input type='hidden' id='thiscolumn' />
		<input type='hidden' id='thiscode' />
		<input type='hidden' id='Dh' />

		<input type='hidden' id='thiscolnames' />
		<input type='hidden' id='thiscolmodels' />

		<input type='hidden' id='printright' />
		<input type='hidden' id='exportright' />
		<input type="hidden" id="deleteinfo"
			value="<fmt:message key="global.delete"/>" />
		<input type="hidden" id="editinfo"
			value="<fmt:message key="global.edit"/>" />
		<input type="hidden" id="selectaddrname"
			value="<fmt:message key="ip.select"/>" />
		<input type="hidden" id="operationtips"
			value="<fmt:message key="global.operationtips"/>" />
		<input type="hidden" id="successful"
			value="<fmt:message key="global.successful"/>" />
		<input type="hidden" id="imenuid" value="<%=imenuid%>" />
		<input type="hidden" id="zid" value="<%=zid%>" />
		<%
			if (!languageType.equals("en")) {
				languageType = "zh";
			}
		%>

		<input type="hidden" id="languageType" value="<%=languageType%>" />
		<input type="hidden" id="userid" value="<%=userid%>" />
		<input type='hidden' id='thishiddencolumn' />
		<input type='hidden' id='thishiddensql' />
		<input type='hidden' id='thisroute' />

		<input type='hidden' id='thisbroadcolumn' />
		<input type='hidden' id='thisbroadsql' />
		<input type='hidden' id='thisbroadhiddensql' />
		<input type='hidden' id='thisbroad' />

		<input type='hidden' id='thedisplayhieght' />

		<input type='hidden' id='thisDh' />
		<input type='hidden' id='thisedit' />
		<input type='hidden' id='whichedit' />
		<input type='hidden' id='limitroute' />

		<input type='hidden' id='thestainfo' />

		<input type='hidden' id='userstaaddress' />

		<input type='hidden' id='editright' />

		<input type='hidden' id='userloginip'
			value='<%=Log.getIpAddr(request)%>' />
		<input type='hidden' id='userloginid'
			value='<%=session.getAttribute("userid")%>' />
		<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
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
							<td>
								<div id="thelistform"
									style="margin-left: 10px; height: 200px">

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
					onclick="getTheCheckedFields_tmp('tsdBilling','mssql','air_users')">
					<fmt:message key="global.ok" />
				</button>
				<button type="button" class="tsdbutton" id="closethisinfo">
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>

		<!-- 双击查看用户详细信息 -->

		<div class="neirong" id="userdhinfos"
			style="display: none; width: 800px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							用户详细信息
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#closedhinfos').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form action="#" name="userdhinfos" onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td class="labelclass">
								<label>
									电话
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<label id="dis_dh"></label>
							</td>
							<td class="labelclass">
								<label>
									用户名称
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<label id="dis_username" ></label>
							</td>

							<td class="labelclass">
								<label>
									用户单位
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<label id="dis_userbm"></label>
							</td>
						</tr>
						
						<tr>
							<td class="labelclass">
								<label>
									用户性质
								</label>
							</td>
							<td class="tdstyle">
								<label id="dis_yhxz"></label>
							</td>
							<td class="labelclass">
								<label>
									用户类别
								</label>
							</td>
							<td class="tdstyle">
								<label id="dis_yhlb"></label>
							</td>

							<td class="labelclass">
								<label>
									电话功能
								</label>
							</td>
							<td class="tdstyle">
								<label id="dis_dhgn"></label>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label>
									一级部门
								</label>
							</td>
							<td class="tdstyle">
								<label id="dis_bm1" ></label>
							</td>

							<td class="labelclass">
								<label>
									二级部门
								</label>
							</td>
							<td class="tdstyle">
								<label id="dis_bm2" ></label>
							</td>
							<td class="labelclass">
								<label>
									三级部门
								</label>
							</td>
							<td class="tdstyle">
								<label id="dis_bm3" ></label>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label>
									四级部门
								</label>
							</td>
							<td class="tdstyle">
								<label id="dis_bm4" ></label>
							</td>

							<td class="labelclass">
								<label>
									业务区域
								</label>
							</td>
							<td class="tdstyle">
								<label id="dis_ywarea" ></label>
							</td>
							<td class="labelclass">
								<label>
									收费类型
								</label>
							</td>
							<td class="tdstyle">
								<label id="dis_sflx" ></label>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label>
									装机日期
								</label>
							</td>
							<td class="tdstyle" >
								<label id="dis_Regdate"></label>
							</td>
							<td class="labelclass">
								<label>
									用户地址
								</label>
							</td>
							<td class="tdstyle" colspan="3">
								<label id="dis_useraddress"></label>
							</td>
						</tr>
						<tr>
							<td class="dflabelclass">
								<label>
									备注
								</label>
							</td>
							<td colspan="5">
								<label id="dis_bz2"></label>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="button" class="tsdbutton" id="closedhinfos"">
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>
		<input type="hidden" id="disoper" />
		<input type="hidden" id="editrouteright" />
		
		<!-- 号线配置信息 -->
		<div class="neirong" id="deviceinfoform" style="display: none; width: 800px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							用户号线配置信息
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#deviceinfoformclose').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form action="#" name="deviceinfoforms" id="deviceinfoforms"
					onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td align="center">
								<div id='thisdeviceform'
									style="height: 180px;width: 800px;overflow-x: auto; overflow-y: hidden;"></div>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="button" class="tsdbutton" id="deviceinfoformclose">
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>
		
		<!-- 隐藏域信息  -->
		<input type="hidden" id="dh_rount" />
		<input type="hidden" id="Rounttype_hide" value="1"/>
		<input type="hidden" id="ziduansF_info"/>
		<input type="hidden" id="ziduansF_broad"/>
		<input type="hidden" id="theloginfo"/> <!-- 日志信息 -->
		<input type="hidden" id="pleaseinput" value="<fmt:message key="userline.pleaseinput"/>"/>
		<input type="hidden" id="successful"
			value="<fmt:message key="global.successful"/>" />
		<input type="hidden" id="deleteinformation"
			value="<fmt:message key="global.deleteinformation"/>" />
		<input type='hidden' id='managearea_hidden' value='<%=managearea %>'/> <!-- 用户 -->
	</body>
</html>