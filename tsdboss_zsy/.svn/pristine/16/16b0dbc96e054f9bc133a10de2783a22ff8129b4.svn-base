<%----------------------------------------
	name: roleManager.jsp
	author: chenliang
	version: 1.0, 2009-11-26
	description: 对系统角色的管理
	modify: 
		  2009-11-26 chenliang  添加功能注释. 将页面扩展权限加载到模块中
	      2009-12-01 chenliang  更新日志，添加功能记录。
	      2009-12-06 chenliang  修改菜单添加修改日志时出现的bug
	      2009-12-12 chenliang  修改模块权限设置
	      2009-12-29 chenliang  进行全面的系统测试
	      2009-01-08 chenliang  ie6和ie7样式兼容问题
	      2010-04-21 chenliang  修改菜单配置权限时增加提示信息
		  2010-09-01 luoyulong  替换菜单为三级菜单
		  2012-02-06 chenliang  修改扩展权限配置和展现方式
		  
---------------------------------------------%>
<%@page import="com.tsd.service.util.Log"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	String groupid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Role-Manager</title>
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<!-- 菜单需要的文件 -->
		<link rel="stylesheet" type="text/css" href="style/css/system/tsdtree.css" />
		<script type="text/javascript" src="plug-in/extjs/ext-base.js"></script>
		<script type="text/javascript" src="plug-in/extjs/ext-all.js"></script>
		<script type="text/javascript" src="script/system/tsdtree.js"></script>
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
		<!-- 面板移动js -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
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
        tsdpname : 'roleManager.getPower', //存储过程的映射名称
        tsdExeType : 'query', datatype : 'xmlattr' 
    });
    /* 调用存储过程需要的参数 */
    var userid = $('#userid').val();
    /**
    if (userid == 'admin') {
        document.getElementById('systemadd').style.display = 'block';
    }
    */
    var groupid = $('#zid').val();
    var imenuid = $('#imenuid').val();
    /** 拼接权限参数 **/
    var editmenuright = '';//修改菜单权限
    var editmenupower = '';//修改配置权限
    var savemenu = ''; //保存菜单权限   
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
    var editmenuright = '';
    var editmenupowerright = '';
    var savemenuright = '';
    if (spower == 'all@')
    {
        editmenuright = 'true';
        editmenupowerright = 'true';
        savemenuright = 'true';
        flag = true;
    }
    else if (spower != '' && spower != 'all@')
    {
        var spowerarr = spower.split('@');
        for (var i = 0; i < spowerarr.length - 1; i++)
        {
            editmenuright += getCaption(spowerarr[i], 'editmenu', '') + '|';
            editmenupowerright += getCaption(spowerarr[i], 'editmenupower', '') + '|';
            savemenuright += getCaption(spowerarr[i], 'savemenu', '') + '|';
        }
    }
    var haseditmenu = editmenuright.split('|');
    var haseditmenupower = editmenupowerright.split('|');
    var hassavemenu = savemenuright.split('|');
    var str = 'true';
    if (flag == true)
    {
        $("#editmenus").val(editmenuright);
        $("#editmenupowers").val(editmenupowerright);
        $("#savemenus").val(savemenuright);
    }
    else
    {
        for (var i = 0; i < haseditmenu.length; i++) {
            if (haseditmenu[i] == 'true') {
                $("#editmenus").val(str);
                break;
            }
        }
        for (var i = 0; i < haseditmenupower.length; i++) {
            if (haseditmenupower[i] == 'true') {
                $("#editmenupowers").val(str);
                break;
            }
        }
        for (var i = 0; i < hassavemenu.length; i++) {
            if (hassavemenu[i] == 'true') {
                $("#savemenus").val(str);
                break;
            }
        }
    }
}
/**
 * 页面初始化加载的信息
 * @param 无参数
 * @return 无返回值
 */
jQuery(document).ready( function ()
{
    $("#navBar1").append(genNavv());
    //初始化导航信息
    getUserPower();
    //加载用户权限
    /***********************
                    * 权限判断，进行可执行操作 *
                    *********************/
    var editmenu = $('#editmenus').val();
    var editmenupower = $('#editmenupowers').val();
    var savemenu = $('#savemenus').val();
    if (editmenu == 'true') {
        document.getElementById('editmenu').disabled = false;
    }
    if (savemenu == 'true') {
        document.getElementById('savemenu').disabled = false;
    }
    /** 扩展权限放开
    if (editmenupower == 'true') {
        document.getElementById('editmenupower').disabled = false;
    }
    */
    getGroupInfo(); //获取权限组，显示权限组名称
    getMenu();//初始化菜单 
    checkboxDisabled(true);//初始化菜单复选框状态为不可选
} );
/**
 * 显示左边的权限组列表 
 * @param 无参数
 * @return 无返回值
 */
function getGroupInfo()
{
    var urlstrr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'roleManager.getgroupinfo'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstrr, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            var groupname = '';
            $(xml).find('row').each(function ()
            {
                var groupid = $(this).attr("groupid");
                groupname += "<div class='groupa' style='line-height:20px' id='style-div-" + groupid + "'><a href='javascript:getImenuID(" + groupid + ")'>" + $(this).attr("groupname") + "</a></div>";
            });
            $('#grouplist').html(groupname);
        }
    });
}
/**
 * 在菜单上方显示权限当前选中权限组 
 * @param groupid(唯一标识)
 * @return 无返回值
 */
function getGroupName(groupid)
{
    var urlstrr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'roleManager.getgroupname'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstrr + '&groupid=' + groupid, datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                $('#thisdisplaygroup').html("<div style='margin-bottom: 5px'><fmt:message key='role.thegroup'/>：" + $(this).attr("groupname") + "</div>");
            });
        }
    });
}
/**
 * 显示权限组的名称
 * @param groupid(唯一标识)
 * @return String
 */
function getTheName(groupid)
{
    var thename = '';
    var urlstrr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'roleManager.getgroupname'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstrr + '&groupid=' + groupid, datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                thename = $(this).attr("groupname");
            });
        }
    });
    return thename;
}
/**
 * 获取系统菜单
 * @param 无参数
 * @return 无返回值
 */
function getMenu(){
	//<%--
	var urlstr=tsd.buildParams({ 	
		packgname:'service',//java包
		clsname:'ExecuteSql',//类名
		method:'exeSqlData',//方法名
		ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
		tsdcf:'mssql',//指向配置文件名称
		tsdoper:'query',//操作类型 
		datatype:'xmlattr',//返回数据格式 
		tsdpk:'menuManager.getdisplaymenu'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
	});
	$.ajax({
		url:'mainServlet.html?'+urlstr,
		datatype:'xml',
		cache:false,//如果值变化可能性比较大 一定要将缓存设成false
		timeout: 1000,
		async: false ,//同步方式
		success:function(xml){
			/*************************
			*      全局系统树变量     *
			************************/
			mtree = new dTree('mtree','css/tree/images/system/menu/');
			mtree.config.folderLinks=true;
			mtree.config.useCookies=false;
			mtree.config.check=true;
			var sys = $("#global").val();
							
			mtree.add(0,-1,sys,'javascript:mtree.openAll()',"<fmt:message key='role.thetips'/>");
							
			//mtree.add(0,-1,sys);
			$(xml).find('row').each(function(){
				var id=$(this).attr("imenuid"); 
				var parentid=$(this).attr("iparentid"); 
				var name=$(this).attr("smenuname"); 
				var languageType = $("#languageType").val();
								
				var words = "关键字未找到";
				if(languageType=="en"){
					words = "The code is not found";
				}
				//对菜单进行国际化解析
				var splitname = getCaption(name,languageType,words);
				var sImgIco=$(this).attr("simgico"); 
				var url=$(this).attr("smenuurl");
								
				var thepower = '';
				if(parentid!=0){
					thepower = 'javascript:getSpower('+id+','+parentid+')';
				}
				mtree.add(id,parentid,splitname,thepower,splitname);
							
			});
			//$("#menulist").html(mtree.toString()); //old menu 
		}
	});
	//--%>
	setTimeout("$('#menuloadingdiv').hide()",3000);
	if (window.tsdtree && window.tsdtree.destroy) {
		window.tsdtree.destroy();
		$('#menu').html('<div id="menulist" style="margin:10px;"></div>');
	}
	window.tsdtree = Ext.app.tsd.treeRender("menulist","power");
}

/**
 * 在选择左边的权限组时，同步显示右边当前权限组所有的菜单
 * @param groupid(唯一标识)
 * @return 无返回值
 */
function getImenuID(groupid)
{
    //在做权限选择时进行赋值操作，权限选择提示信息要用到的参数
    /** 2012-02-07
    istips_ = 0;
    mainian = 0;
    flag = false;
    */
    $('#rightslist').hide();
    //临时参数
    $('#disflag').val('');
    //初始化权限菜单，将菜单权限列表清空
    clearTheList();
    //$("#menulist").html('');
    $("#thisgroupid").val(groupid);
    //获取部门名称
    //getGroupName(groupid);
    //是否进行了选择操作，选择了改变背景色
    $('#style-div-' + groupid).css('background-color', '#C0C0C0');
    var disgroupid = $('#disopergroupid').val();
    if (disgroupid != '') {
        $('#style-div-' + disgroupid).css('background-color', '#F5FCFE');
    }
    $('#disopergroupid').val(groupid);
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'roleManager.getimenuid'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&groupid=' + groupid, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
		var menuidstr = '';
		$(xml).find('row').each(function(){
			var imenuid = $(this).attr("imenuid");
			menuidstr += imenuid +'~';
		});
		menuidstr = menuidstr.substring(0,menuidstr.lastIndexOf('~'));
		var menuarr = menuidstr.split('~');
							
		//<%--
		var thename=document.getElementsByName("ian");  
		//将所有的复选框赋为没选中
		for(var i = 0;i<thename.length;i++){
			thename[i].checked=false;
		}
		//将所在权限组的值选中
		for(var i = 0 ; i< menuarr.length;i++){
			for(var j = 0; j <thename.length;j++){
				if(thename[j].value==menuarr[i]){
					thename[j].checked=true;
					break;
				}
			}
		}
		mtree.closeAll();
		//--%>
		tsdtree.collapseAll();
		tsdtree.checkedByIdList(menuarr);
            checkboxDisabled(true);
        }
    });
}
/**
 * 获取当前菜单有被选中状态
 * @param 无参数
 * @return String
 */
function checkedImenuid(){
	//<%--
	var thename=document.getElementsByName("ian");  
	var str = '';
	//将所有的复选框赋为未选中
	for(var i = 0;i<thename.length;i++){
		if(thename[i].checked==true){
			str += thename[i].value+',';		
		}
	}//--%>
	var str = tsdtree.getAllCheckId()+',';
	return str;
}

/**
 * 控制菜单可选状态
 * @param status(状态)
 * @return 无返回值
 */
function checkboxDisabled(status)
{
    var form = document.getElementById("menu");
    for (var i = 0; i < form.elements.length; i++) 
    {
        var element = form.elements[i];
        if (element.type == 'checkbox') {
            element.disabled = status;
        }
    }
}

/**
 * 调用存储过程，批量添加权限
 * @param 无参数
 * @return 无返回值
 */
function setPower()
{
    //当前是对哪个权限组进行赋权限
    var groupid = $('#thisgroupid').val();
    if (groupid != '' && groupid != null)
    {
        var urlstr = tsd.buildParams(
        {
            packgname : 'service', clsname : 'Procedure', method : 'exequery', ds : 'tsdBilling', //数据源名称 对应的spring配置的数据源
            tsdpname : 'roleManager.setMenuPower', //存储过程的映射名称
            tsdExeType : 'query', datatype : 'xmlattr' 
        });
        var smenuid = checkedImenuid();
        var num = smenuid.lastIndexOf(',');
        var imenuid = smenuid.substring(0, num);
        var arrimenuid = imenuid.split(',');
        var themenuid = $('#thelogmenuid').val();
        var thenum = themenuid.lastIndexOf(',');
        var themenuids = themenuid.substring(0, thenum);
        var arrthemenuid = themenuids.split(',');
        var thestr = '';
        if (arrimenuid.length > arrthemenuid.length)
        {
            //thestr += '新添权限菜单：';
            thestr += '<fmt:message key="roleManager.addNewList" />';
            if (arrthemenuid == 0) {
                thestr += arrimenuid;
            }
            else
            {
                for (var i = 0; i < arrthemenuid.length; i++)
                {
                    for (var j = 0; j < arrimenuid.length; j++) {
                        if (arrimenuid[i] != arrthemenuid[j]) {
                            thestr += arrimenuid[i] + ',';
                            break;
                        }
                    }
                }
            }
        }
        if (arrimenuid.length < arrthemenuid.length)
        {
            //thestr += '减少权限菜单：';
            thestr += '<fmt:message key="roleManager.deleteNewList" />';
            for (var i = 0; i < arrimenuid.length; i++)
            {
                for (var j = 0; j < arrthemenuid.length; j++) {
                    if (arrthemenuid[i] != arrthemenuid[j]) {
                        thestr += arrthemenuid[i] + ',';
                        break;
                    }
                }
            }
        }
        var thestrnum = thestr.lastIndexOf(',');
        thestr = thestr.substring(0, thestrnum);
        //记录修改菜单权限
        var thename = getTheName(groupid);
        //记录日志
        writeLogInfo('', 'modify', tsd.encodeURIComponent("<fmt:message key='global.edit'/>") + tsd.encodeURIComponent(thename) + tsd.encodeURIComponent("<fmt:message key='role.themodify'/>：") + tsd.encodeURIComponent(thestr));
        $.ajax(
        {
            url : 'mainServlet.html?' + urlstr + '&groupid=' + groupid + '&menuid=' + imenuid, datatype : 'xml', 
            cache : false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout : 1000, async : false , //同步方式
            success : function (xml)
            {
                $(xml).find('row').each(function ()
                {
                    var result = $(this).attr("res");
                    if (result == 0)
                    {
                        //提示信息，添加成功
                        alert('<fmt:message key="global.successful"/>', '<fmt:message key="global.operationtips"/>');
                        setTimeout($.unblockUI, 15);
                        getMenu();
                        //添加完权限重新加载菜单
                        checkboxDisabled(true);
                    }
                });
            }
        });
    }
    else
    {
        var operationtips = $("#operationtips").val();
        //请选择权限组
        alert("<fmt:message key='role.selectgroup'/>", operationtips);
    }
}

/**
 * 获取当前菜单的可扩展权限
 * @param imenuid
 * @param iparentid
 * @return 无返回值
 */
function toGaveImenuid(imenuid, iparentid)
{
    if (iparentid == undefined) {
        iparentid = 0;
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
        tsdpk : 'roleManager.gettheparambyimenuid'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&imenuid=' + imenuid + '&iparentid=' + iparentid, datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $("#rights").html('');
            var params = "<option value='0'><fmt:message key='ip.select'/></option>";
            var thespower = $('#thespower').val();
            //alert(thespower);
            $(xml).find('row').each(function ()
            {
                var spower = $(this).attr('paramname');
                //检查是否已有此权限
                if (thespower.indexOf(spower + '~') ==- 1)
                {
                    var paramalias = $(this).attr("paramalias");
                    var thealias = getCaption(paramalias, '<%=languageType %>', '');
                    params += "<option value='" + $(this).attr('paramname') + "'>" + thealias + "</option>";
                }
            });
            $("#rights").html(params);
        }
    });
}
/**
 * 获取某个菜单的可扩展权限
 * @param imenuid
 * @param iparentid
 * @return 无返回值
 */
function getSpower(imenuid, iparentid)
{
	/**
    var disflag = $('#disflag').val();
    if (disflag == 1) {
        alert('在添加菜单权限前,请先保存菜单!');
        return;
    }
    else
    {
    */
        $('#cleartext').click();
        //显示权限时显示中文
        $('#thismenuid').val(imenuid);
        var groupid = $('#thisgroupid').val();
        if (groupid != '')
        {
           	var thispower = fetchMultiArrayValue('roleManager.getspower',6,'&groupid=' + groupid + '&imenuid=' + imenuid);
           	var valarr = new Array();
           	//thispower[0][0] = '{receive=true/}{submitjob=true/}{print=true/}';
           	if(thispower[0][0] != '' && thispower[0][0] != undefined){
				//返回数据格式：{receive=true/}{submitjob=true/}{print=true/}
				//thispower[0][0] = thispower[0][0].replace(/\/}{/g, ',');
				valarr = thispower[0][0].substring(1,thispower[0][0].length-2).split('/}{');
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
                tsdpk : 'roleManager.getsrolepower'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
            });
            $.ajax(
            {
                url : 'mainServlet.html?' + urlstr + '&groupid=' + groupid + '&imenuid=' + imenuid, datatype : 'xml', 
                cache : false, //如果值变化可能性比较大 一定要将缓存设成false
                timeout : 1000, async : false , //同步方式
                success : function (xml)
                {
                	var displayinfo = '';
                    $(xml).find('row').each(function ()
                    {
                    	//paramname,paramalias,defaultvalues,type,dict,description
                        var paramname = $(this).attr("paramname");
                        if(paramname!=undefined){
                        	var paramalias = $(this).attr("paramalias");
                        	paramalias = paramalias==''?'':getCaption(paramalias, '<%=languageType %>', 'zh');
                        	var defaultvalues = $(this).attr("defaultvalues");
                        	//var type = $(this).attr("type");
                        	//var dict = $(this).attr("dict");
                        	var powerstatus = '';
                        	if(valarr.length!=0){
                        		for(var i = 0 ; i < valarr.length; i++){
                        			var arrtmp = valarr[i].split('=');
                        			if(arrtmp[0]==paramname){
                        				powerstatus = arrtmp[1];
                        				break;
                        			}
                        		}
                        	}
                        	if(powerstatus==''){
                        		powerstatus = defaultvalues;
                        	}
							if(powerstatus=='true'){
								//powerstatus = '有';
								powerstatus = '<fmt:message key="roleManager.have" />';
							}else if(powerstatus=='false'){
								//无
								powerstatus = '<fmt:message key="roleManager.nothave" />';
							}                        	
                        	var description = $(this).attr("description");
                        	description = description==''?'':getCaption(description, '<%=languageType %>', 'zh');
							displayinfo +='<tr><td class="roletdleft"><a href="javascript:void(0)" title="'+description+'" onclick=javascript:$("#'+paramname+'_power").toggle();>'+paramalias+'</a><p id="'+paramname+'_power" style="color:blue;display:none">'+description+'</p></td><td class="roletdright">'+powerstatus+'</td></tr>';
                        }
                        /** 2012-02-06
	                        var spower = $(this).attr("spower");
	                        var memo = $(this).attr("memo");
	                        $('#thismemo').val(memo);
	                        $('#getthispower').val(spower); 
	                        splitSpower(spower);//将返回的权限进行解析
                        */
                    });
                    if(displayinfo!=''){
                    	// 权限名称 权限状态
						$('#spowerdiv').html('<table style="margin-left: 5px;width: 330px;border:1px dotted #000;" cellspacing="3px"><tr><td class="roletdleft"><fmt:message key="role.powername" /></td><td class="roletdright">&nbsp;<fmt:message key="roleManager.WhetherHaveAccess" /></td></tr>'+displayinfo+'</table>');                    
                    	$('#spoweredit').show();
                    }else{
                    	$('#spowerdiv').html('<label style="font-size:13px;line-height:30px;width:240px;"><fmt:message key="roleManager.Withoutpermission" /></label>');
                    	$('#spoweredit').hide();
                    }
                	$('#rightslist').show();
                }
            });
        }
        else
        {
            var operationtips = $("#operationtips").val();
            //请选择权限组
            alert("<fmt:message key='role.selectgroup'/>", operationtips);
        }
        //加载可选权限菜单 2012-02-06
        //toGaveImenuid(imenuid, iparentid);
    //}
}
/**
 * 解析菜单权限
 * @param spower
 * @return 无返回值
 */
function splitSpower(spower)
{
    /******************************
                * 将取出来的权限进行解析，生成列表 *
                *****************************/
    if (spower != undefined)
    {
        document.getElementById('rightslist').style.display = '';
        //返回数据格式：{add=true,delete=false/}
        var apower = spower.replace(/}/g, '');
        var bpower = apower.replace(/{/g, '');
        var powerarr = bpower.split('/');
        var key = '';
        var val = '';
        var menupower = $('#menupower').val();
        var powername = $('#powername').val();
        var powervalue = $('#powervalue').val();
        //powervalue = '是否有权限';
        powervalue = '<fmt:message key="roleManager.WhetherHaveAccess" />';
        var basepath = $('#basepath').val();
        var btable = '<div class="title" style="text-align: left;"><h4><img src="' + basepath + '55.gif" style="margin-left: 10px;vertical-align: middle;"/>&nbsp;' + menupower + '</h4></div><div style="margin-top:5px;float:left;"><ul><li style="float:left; word-wrap:break-word; overflow:hidden;width:71%;text-align: left;border: 1px;">' + powername + '</li><li style="float: left;word-wrap:break-word; overflow:hidden;">' + powervalue + '</li></ul><br/><hr/>';
        var etable = '</div>';
        var content = '';
        //添加修改权限时需要添加的参数变量
        var thespower = '';
        var thealias = '';
        for (var i = 0; i < powerarr.length - 1; i++ )
        {
            //解析数据格式：add=true,edit=false
            var temp = powerarr[i].split('=');
            //原来有的权限在权限列表中是不显示的 
            thespower += temp[0] + '~';
            thealias += temp[1] + '~';
            var thetemp = getTheAlias(temp[0]);
            var btr = '<ul>';
            key = "<li><div class='groupa'  style='float:left; word-wrap:break-word; overflow:hidden;width:71%;text-align: center;border: 1px;line-height:20px'><a href='javascript:getThisType(\"" + temp[0] + "\")'>" + thetemp + "</a></div>";
            var thistmp = temp[1];
            if (thistmp == 'true') {
                thistmp = '<fmt:message key="main.thetrue"/>';
            }
            else if (thistmp == 'false') {
                thistmp = '<fmt:message key="main.thefalse"/>';
            }
            val = '<div style="float: left;word-wrap:break-word; overflow:hidden;line-height:20px">' + thistmp + '</div></li>';
            var etr = '</ul>';
            content += btr + key + val + etr ;
        }
        //权限设置显示权限列表
        $('#rightslist').html(btable + content + etable + '<hr/>');
        $('#thespower').val(thespower);
        //在修改可编辑字段时要用到的参数
        $('#thealias').val(thealias);
    }
    else {
        document.getElementById('rightslist').style.display = 'none';
    }
}
/**
 * 将权限菜单关键字英文转化为中文
 * @param str
 * @return String
 */
function getTheAlias(str)
{
    var splitcode = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'spowerManager.queryByKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&paramname=' + str, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var paramalias = $(this).attr("paramalias");
                /*****************
                                *  解析关键字别名 *
                                ***************/
                var languageType = $("#languageType").val();
                var words = "<fmt:message key='roleManager.KeyWordNotFound' />";
                if (languageType == "en") {
                    words = "The code is not found";
                }
                splitcode = getCaption(paramalias, languageType, words);
            });
        }
    });
    return splitcode;
}

/**
 * 取参数别名表进行国际化
 * @param 无参数
 * @return 无返回值
 */
function getParamAlias()
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
        tsdpk : 'roleManager.getparamalias'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var paramalias = $(this).attr("paramalias");
                var paramname = $(this).attr("paramname");
                /*****************
                                *  解析关键字别名 *
                                ***************/
                var languageType = $("#languageType").val();
                var words = '<fmt:message key="roleManager.KeyWordNotFound" />';
                if (languageType == "en") {
                    words = "The code is not found";
                }
                var splitcode = getCaption(paramalias, languageType, words);
                var rightscode = "<option value='" + paramname + "'>" + paramname + "(" + splitcode + ")" + "</option>";
                $("#rights").html(rightscode);
            });
        }
    });
}
/**
 * 改变输入框状态
 * @param status(状态)
 * @return 无返回值
 */
function isAvailable(status)
{
    document.getElementById('rights').disabled = status;
    document.getElementById('setrights').readOnly = status;
    document.getElementById('rightselect').disabled = status;
    document.getElementById('memo').readOnly = status;
}
/****************************
            *  添加时确认是否选中菜单权限组 *
            ***************************/
function hasSelected()
{
    var groupid = $('#thisgroupid').val();
    var imenuid = $('#imenuid').val();
    if (groupid != '' && imenuid != '') {
        isAvailable(false);
    }
    else
    {
        var operationtips = $("#operationtips").val();
        //请选择菜单权限组
        alert("<fmt:message key='role.selectmenu'/>", operationtips);
    }
    document.getElementById("themodifyright").style.display = 'none';
    document.getElementById("rights").style.display = 'block';
}
/**
 * 获取选择输入类型
 * @param 无参数
 * @return 无返回值
 */
function getType()
{
    var urlstrr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'roleManager.gettype'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    var param = $('#rights').val();
    if ('' == param || null == param || 0 == param) {
        param = $('#therealparam').val();
    }
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstrr + '&paramname=' + param, datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var type = $(this).attr("type");
                var dict = $(this).attr("dict");
                if (type == 'select')
                {
                    $('#rightselect').html('');
                    $('#rightselect').html('<option><fmt:message key="ip.select"/></option>');
                    var svalue = dict.split('~');
                    for (var i = 0 ; i < svalue.length; i++)
                    {
                        var thistmp = svalue[i];
                        if (thistmp == 'true') {
                            thistmp = '<fmt:message key="main.thetrue"/>';
                        }
                        else if (thistmp == 'false') {
                            thistmp = '<fmt:message key="main.thefalse"/>';
                        }
                        var rightscode = "<option value='" + svalue[i] + "'>" + thistmp + "</option>";
                        $("#rightselect").html($("#rightselect").html() + rightscode);
                    }
                    document.getElementById("gettypeinput").style.display = 'none';
                    document.getElementById("gettypeselect").style.display = 'block';
                    /*******************
                                    *  选择的是那种值类型 *
                                    *****************/
                    $('#whichtype').val(1);
                    /*************************
                                    * 要进行的操作是修改还是删除 *
                                    ***********************/
                    var opertype = $('#opertype').val(0);
                }
                else if (type == 'input')
                {
                    document.getElementById("gettypeinput").style.display = 'block';
                    document.getElementById("gettypeselect").style.display = 'none';
                    $('#whichtype').val(0);
                    $('#opertype').val(0);
                }
                else if (type == 'list') {
                    $('#isthelist').val(0);
                    getTheAliasList();
                }
            });
        }
    });
}
/**
 * 获取参数别名表
 * @param theimenuid
 * @return String
 */
function getTheMemo(theimenuid)
{
    var thename = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'roleManager.getthetable'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&imenuid=' + theimenuid, datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                if ($(this).attr("memo") != undefined) {
                    thename = $(this).attr("memo");
                }
            });
        }
    });
    return thename;
}
/**
 * 获取权限别名
 * @param 无参数
 * @return 无返回值
 */
function getTheAliasList(tbconfig)
{
    var theimenuid = $('#thismenuid').val();
    //通过权限菜单id取memo中表名
    var thename = '';
    if(undefined == tbconfig || '' == tbconfig){
    	var urlstr = tsd.buildParams(
	    {
	        packgname : 'service', //java包
	        clsname : 'ExecuteSql', //类名
	        method : 'exeSqlData', //方法名
	        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
	        tsdcf : 'mssql', //指向配置文件名称
	        tsdoper : 'query', //操作类型 
	        datatype : 'xmlattr', //返回数据格式 
	        tsdpk : 'roleManager.getthetable'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
	    });
	    $.ajax(
	    {
	        url : 'mainServlet.html?' + urlstr + '&imenuid=' + theimenuid, datatype : 'xml', cache : false, 
	        //如果值变化可能性比较大 一定要将缓存设成false
	        timeout : 1000, async : false , //同步方式
	        success : function (xml)
	        {
	            $(xml).find('row').each(function ()
	            {
	                if ($(this).attr("memo") != '' && $(this).attr("memo") != 'undefined') {
	                    thename = $(this).attr("memo");
	                }
	            });
	        }
	    });
	    if (thename == '' || null == thename || undefined == thename) {
	        //alert('未配置权限菜单表字段，生成字段失败');
	        alert("<fmt:message key='weblog.ToAdmin' />");
	        //$('#cleartext').click();
	        return false;
	    }
    }else{
    	thename = tbconfig;
    }
    var thevalue = "";
    
    //通过表名去别名表中取可编辑字段
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
        url : 'mainServlet.html?' + urlstr + '&tablename=' + thename, datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            
            var i = 1;
            $(xml).find('row').each(function ()
            {
            	if(undefined != $(this).attr("field_name")){
	                var thebr = '';
	                if (i * 1 % 6 == 0) {
	                    thebr = '<br/>';
	                }
	                thevalue += "<span class='spanstyle'><input type='checkbox' onclick='eidtClickForVal()' name='thefields' value='" + $(this).attr("field_name") + "' style='width:16px;height:16px;'><label style='text-align: left;margin-left:5px;font-size:12px'>" + getCaption($(this).attr("field_alias"), 
	                '<%=languageType %>', '') + "</label></span>" + thebr;
	                i++;
                }
            });
            //$('#thelistform').html(thevalue);
            
            /**
            var theflag = $('#flagvalue').val();
            var param = $('#thefieldlist').val();
            if (theflag == 1) {
                forChecked('thefields', param);
            }
            */
            //autoBlockForm('adds', 60, 'Qclose', "#ffffff", false);
        }
    });
    return thevalue;
}

/**
 * 选中原来的值
 * @param name
 * @param thisvalue
 * @return 无返回值
 */
function forChecked(name, thisvalue)
{
    if ('' != thisvalue && null != thisvalue)
    {
        var thenum = thisvalue.lastIndexOf(',');
        var m = 0;
        if (thenum ==- 1) {
            thisvalue += ',';
            m = 1;
        }
        var thearr = thisvalue.split(',');
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
 * 权限全选
 * @param 无参数
 * @return 无返回值
 */
function checkedAll()
{
    var tagname = document.getElementsByName('thefields');
    for (var i = 0; i < tagname.length; i++)
    {
        if (tagname[i].checked == true) {
            //$('#query').html('全选');
            $('#query').html('<fmt:message key="roleManager.checkAll" />');
            tagname[i].checked = false;
        }
        else {
            //$('#query').html('反选');
            $('#query').html('<fmt:message key="roleManager.checkOther" />');
            tagname[i].checked = true;
        }
    }
}
/**
 * 选中选中的权限
 * @param 无参数
 * @return 无返回值
 */
function getTheChecked()
{
    var thename = document.getElementsByName('thefields');
    var thevalue = '';
    for (var i = 0; i < thename.length; i++) {
        if (thename[i].checked == true) {
            thevalue += thename[i].value + ',';
        }
    }
    $('#setrights').val(thevalue);
    document.getElementById('gettypeinput').style.display = 'block';
    document.getElementById('gettypeselect').style.display = 'none';
    document.getElementById('fieldlistdiv').style.display = 'none';
    //将面板关闭
    setTimeout($.unblockUI, 15);
}

/**
 * 更新用户权限
 * @param 无参数
 * @return 无返回值
 */
function updateSpower()
{
    /*****************************
                *  添加权限，不可重复添加已有权限 *
                ****************************/
    var rights = $("#rights").val();
    var therights = $('#ismodifyright').val();
    //修改和删除时需要用到的参数
    var spower = $("#getthispower").val();
    //  菜单原来有的权限
    if (rights != 0 || null != therights || '' != therights)
    {
        //增加菜单权限
        if (spower == 'null') {
            spower = '';
        }
        var opertype = $('#opertype').val();
        var thisupdatevalue = '';
        var apower = spower.replace(/}/g, '');
        var bpower = apower.replace(/{/g, '');
        var powerarr = bpower.split('/');
        var flag = false;
        var isright = '';
        //alert(powerarr);
        for (var i = 0 ; i < powerarr.length - 1; i++)
        {
            var arr = powerarr[i].split('=');
            if (rights != 0) {
                isright = rights;
            }
            else {
                isright = therights;
            }
            //alert(isright);
            if (arr[0] == isright) {
                flag = true;
                thisupdatevalue = arr[1];
                //alert(thisupdatevalue);
            }
            //alert('therights:'+therights);
            //alert('isright:'+isright);
        }
        //第一次初始化数据时默认加载选择值
        if (isright == '') {
            isright = rights;
        }
        var whichtype = $("#whichtype").val();
        var setrights = $("#setrights").val();
        var rightselect = $("#rightselect").val();
        var thevalue = '';
        if (whichtype == 0) {
            thevalue = setrights;
        }
        else if (whichtype == 1) {
            thevalue = rightselect;
        }
        var groupid = $("#thisgroupid").val();
        var menuid = $("#thismenuid").val();
        var thegroupname = getTheNames('groupname', 'sys_powergroup', 'groupid', groupid);
        var menuname = getTheNames('smenuname', 'sys_menu', 'imenuid', menuid);
        var themenuname = getCaption(menuname, '<%=languageType %>', '');
        var thememo = $("#memo").val();
        var memo = '';
        var thememovalue = getTheMemo(menuid);
        //修改权限时确定是否要修改
        if (thememo == '') {
            memo = thememovalue;
        }
        else if (thememo != '')
        {
            if (thememo != thememovalue && thememovalue != undefined) {
                memo = thememo;
            }
            else {
                memo = thememovalue;
            }
        }
        var theSetRight = $('#setrights').val();
        //添加时如果加的是可编辑字段权限
        if (isright == 'editfields') {
            //可编辑字段为选中的值
            thevalue = theSetRight;
        }
        //新增的权限拼加
        var thisvalue = "{" + tsd.encodeURIComponent(isright) + "=" + tsd.encodeURIComponent(thevalue) + "/}";
        if (flag == false && opertype == 0)
        {
            var thisspower = spower + thisvalue;
            if (rights != '' && rights != null)
            {
                //if(setrights!=0&&rightselect==''||){//不做限制
                var urlstr = tsd.buildParams(
                {
                    packgname : 'service', //java包
                    clsname : 'ExecuteSql', //类名
                    method : 'exeSqlData', //方法名
                    ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
                    tsdcf : 'mssql', //指向配置文件名称
                    tsdoper : 'exe', //操作类型 
                    tsdpk : 'roleManager.updatespower'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
                });
                writeLogInfo('', 'add', '(sys_menu)' + tsd.encodeURIComponent("<fmt:message key='role.give'/>") + tsd.encodeURIComponent(thegroupname) + tsd.encodeURIComponent("<fmt:message key='role.is'/>") + tsd.encodeURIComponent(themenuname) + tsd.encodeURIComponent("<fmt:message key='global.add' />") + thisspower + tsd.encodeURIComponent("<fmt:message key='role.power'/>"));
                $.ajax(
                {
                    url : 'mainServlet.html?' + urlstr + '&groupid=' + groupid + '&imenuid=' + menuid + '&spower=' + thisspower + '&memo=' + tsd.encodeURIComponent(memo), 
                    cache : false, //如果值变化可能性比较大 一定要将缓存设成false
                    timeout : 1000, async : false , //同步方式
                    success : function (msg)
                    {
                        if (msg == "true")
                        {
                            alert('<fmt:message key="global.successful"/>', '<fmt:message key="global.operationtips"/>');
                            getSpower(menuid);
                            clearText('thisright');
                            isAvailable(true);
                        }
                    }
                });
                //}
            }
        }
        else
        {
            var setright = $('#setrights').val();
            if (opertype == 1)
            {
                //修改
                //新加的权限
                var thisspowerreplace = spower.replace('{' + isright + '=' + thisupdatevalue + '/}', '');
                //新旧权限进行拼加起来
                var thisspower = thisspowerreplace + thisvalue;
                //alert(thisspower);
                //return false;
                if (therights != '' && therights != null && therights != 0)
                {
                    //if(setrights!=0&&rightselect==''||){
                    var urlstr = tsd.buildParams(
                    {
                        packgname : 'service', //java包
                        clsname : 'ExecuteSql', //类名
                        method : 'exeSqlData', //方法名
                        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
                        tsdcf : 'mssql', //指向配置文件名称
                        tsdoper : 'exe', //操作类型 
                        tsdpk : 'roleManager.updatespower'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
                    });
                    writeLogInfo('', 'modify', '(sys_menu)' + tsd.encodeURIComponent(thegroupname) + tsd.encodeURIComponent("<fmt:message key='role.is'/>") + tsd.encodeURIComponent(themenuname) + tsd.encodeURIComponent("<fmt:message key='role.ispower'/>") + tsd.encodeURIComponent("<fmt:message key='role.hasedit'/>") + thisspower);
                    $.ajax(
                    {
                        url : 'mainServlet.html?' + urlstr + '&groupid=' + groupid + '&imenuid=' + menuid + '&spower=' + thisspower + '&memo=' + tsd.encodeURIComponent(memo), 
                        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
                        timeout : 1000, async : false , //同步方式
                        success : function (msg)
                        {
                            if (msg == "true")
                            {
                                alert('<fmt:message key="global.successful"/>', '<fmt:message key="global.operationtips"/>');
                                getSpower(menuid);
                                clearText('thisright');
                                isAvailable(true);
                            }
                        }
                    });
                    //}
                }
            }
            else if (opertype == 2)
            {
                //删除
                var thisspowerreplace = spower.replace('{' + isright + '=' + thisupdatevalue + '/}', '');
                var thisspower = thisspowerreplace;
                //if ((confirm('您确定要删除该权限吗?')))
                if ((confirm('<fmt:message key="roleManager.areYouSureDelete" />')))
                {
                    if (therights != '' && therights != null)
                    {
                        //if(setrights!=0&&rightselect==''||){
                        var urlstr = tsd.buildParams(
                        {
                            packgname : 'service', //java包
                            clsname : 'ExecuteSql', //类名
                            method : 'exeSqlData', //方法名
                            ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
                            tsdcf : 'mssql', //指向配置文件名称
                            tsdoper : 'exe', //操作类型 
                            tsdpk : 'roleManager.updatespower'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
                        });
                        writeLogInfo('', 'delete', '(sys_menu)' + tsd.encodeURIComponent(thegroupname) + tsd.encodeURIComponent("<fmt:message key='role.is'/>") + tsd.encodeURIComponent(themenuname) + tsd.encodeURIComponent("<fmt:message key='role.has'/>") + therights + tsd.encodeURIComponent("<fmt:message key='role.hasdeleteed'/>"));
                        $.ajax(
                        {
                            url : 'mainServlet.html?' + urlstr + '&groupid=' + groupid + '&imenuid=' + menuid + '&spower=' + thisspower + '&memo=' + tsd.encodeURIComponent(memo), 
                            cache : false, //如果值变化可能性比较大 一定要将缓存设成false
                            timeout : 1000, async : false , //同步方式
                            success : function (msg)
                            {
                                if (msg == "true")
                                {
                                    alert('<fmt:message key="global.successful"/>', '<fmt:message key="global.operationtips"/>');
                                    getSpower(menuid);
                                    clearText('thisright');
                                    isAvailable(true);
                                }
                            }
                        });
                        //}
                    }
                }
                document.getElementById("themodifyright").style.display = 'none';
                document.getElementById("rights").style.display = 'block';
            }
            else
            {
                //您要添加的权限已存在,请重新选择
                alert("<fmt:message key='role.selectagain'/>!", '<fmt:message key="global.operationtips"/>');
                $('#rights').focus();
            }
        }
        $('#opertype').val('');
    }
    else
    {
        //请选择菜单
        alert("<fmt:message key='role.themenu'/>!", '<fmt:message key="global.operationtips"/>');
        $('#rights').focus();
    }
}
/**
 * 通过id获取名称
 * @param namestr
 * @param tablename(表名)
 * @param id
 * @param idstr
 * @return String
 */
function getTheNames(namestr, tablename, id, idstr)
{
    var thename = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'roleManager.getthename'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&namestr=' + namestr + '&tablename=' + tablename + '&id=' + id + '&idstr=' + idstr, 
        datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                thename = $(this).attr("thename");
            });
        }
    });
    return thename;
}

/**
 * 显示当前用户点击的权限信息
 * @param param(参数)
 * @return 无返回值
 */
function getThisType(param)
{
    $('#therealparam').val(param);
    var urlstrr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'roleManager.gettype'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstrr + '&paramname=' + param, datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var paramalias = $(this).attr("paramalias");
                var description = $(this).attr("description");
                var thealia = getCaption(paramalias, '<%=languageType %>', '');
                var des = getCaption(description, '<%=languageType %>', '');
                var type = $(this).attr("type");
                var dict = $(this).attr("dict");
                $('#thisdict').val(dict);
                //菜单原来有的权限
                var spower = $("#getthispower").val();
                if (spower == 'null') {
                    spower = '';
                }
                var apower = spower.replace(/}/g, '');
                var bpower = apower.replace(/{/g, '');
                var powerarr = bpower.split('/');
                if (type != 'input')
                {
                    if (type == 'list')
                    {
                        //取出进行判断
                        var thealias = $('#thealias').val();
                        var alias = thealias.split('~');
                        var thefields = '';
                        for (var i = 0 ; i < alias.length; i++) {
                            if (alias[i].lastIndexOf(',') !=- 1) {
                                thefields += alias[i];
                                break;
                            }
                        }
                        $('#flagvalue').val(1);
                        document.getElementById("themodifyright").style.display = 'block';
                        document.getElementById("rights").style.display = 'none';
                        document.getElementById("gettypeinput").style.display = 'none';
                        document.getElementById("gettypeselect").style.display = 'none';
                        document.getElementById("fieldlistdiv").style.display = 'block';
                        $('#thefieldlist').val(thefields);
                    }
                    else
                    {
                        var svalue = dict.split('~');
                        $('#rightselect').html('');
                        $('#rightselect').html('<option value="0"><fmt:message key="ip.select"/></option>');
                        for (var i = 0 ; i < svalue.length; i++)
                        {
                            var thesvalue = svalue[i];
                            if (thesvalue == 'true') {
                                //thesvalue = '是';
                                thesvalue = '<fmt:message key="roleManager.yes" />';
                                
                            }
                            else if (thesvalue == 'false') {
                                //thesvalue = '否';
                                thesvalue = '<fmt:message key="roleManager.no" />';
                            }
                            var rightscode = "<option value='" + svalue[i] + "'>" + thesvalue + "</option>";
                            $("#rightselect").html($("#rightselect").html() + rightscode);
                        }
                        document.getElementById("themodifyright").style.display = 'block';
                        document.getElementById("rights").style.display = 'none';
                        document.getElementById("gettypeinput").style.display = 'none';
                        document.getElementById("gettypeselect").style.display = 'block';
                        document.getElementById("fieldlistdiv").style.display = 'none';
                    }
                    $('#themodifyright').val(thealia);
                    //修改时需要用到的参数
                    $('#ismodifyright').val(param);
                    $('#theparamalias').val(param);
                }
                else
                {
                    $('#rights').hide();
                    $('#themodifyright').val(thealia);
                    $('#themodifyright').show();
                    document.getElementById("gettypeinput").style.display = 'block';
                    document.getElementById("gettypeselect").style.display = 'none';
                    for (var i = 0 ; i < powerarr.length - 1; i++)
                    {
                        var arr = powerarr[i].split('=');
                        for (var j = 0 ; j < arr.length; j++ )
                        {
                            if (arr[j] == param)
                            {
                                $('#rights').val(param);
                                $('#ismodifyright').val(param);
                                $('#setrights').val(arr[j + 1]);
                                break;
                            }
                        }
                    }
                }
                var thismemo = $('#thismemo').val();
                if (thismemo == 'undefined') {
                    thismemo = '';
                }
                $('#memo').val(thismemo);
                $('#des').val(des);
                document.getElementById('savemenupower').disabled = true;
            });
        }
    });
}
/**
 * 全部将复选框置为不可用
 * @param param(参数)
 * @return 无返回值
 */
function flushit(param)
{
    if (param != '' && param != null) {
        document.getElementById(param).disabled = false;
    }
}
/**
 * 变更操作类型
 * @param num(改变的值)
 * @return 无返回值
 */
function changeType(num)
{
    if (num != '' && num != null) {
        $('#opertype').val(num);
    }
    //修改时如果要修改可编辑字段，则显示可编辑的字段
    var rights = $('#rights').val();
    if (rights == 'editfields')
    {
        getType();
        document.getElementById('rightselect').disabled = true;
        document.getElementById('memo').disabled = true;
    }
}
/**
 * 选择的是那种值类型
 * @param 无参数
 * @return 无返回值
 */
function changThisStaus()
{
    $('#whichtype').val(1);
    var param = $('#theparamalias').val();
}
/**
 * 替换空格
 * @param string(需要去除空格的值)
 * @return String
 */
function ignoreSpaces(string) 
{
    /************************
                * 保存描述信息时，去除空格 *
                **********************/
    var temp = "";
    string = '' + string;
    splitstring = string.split(" ");
    for (i = 0; i < splitstring.length; i++) {
        temp += splitstring[i];
    }
    return temp;
}
/**
 * 取消操作
 * @param 无参数
 * @return 无返回值
 */
function cancelOPer()
{
    getMenu();
    checkboxDisabled(true);
	$('#thisgroupid').val('');
    $('#thisdisplaygroup').html('');
    document.getElementById('rights').disabled = true;
}
/**
 * 清空列表
 * @param 无参数
 * @return 无返回值
 */
function clearTheList()
{
    //$('#rightslist').html('');
    //$('#rights').html('');
}
/**
 * 是否可用
 * @param str
 * @return 无返回值
 */
function isClickDis(str)
{
    $('#cleartext').click();
    $('#disflag').val(str);
}

//权限修改
function rolePowerEdit(){
	$('#operform').empty();
	//paramname,paramalias,defaultvalues,type,dict,description
	var dictstr = '';
	var spowertd = '';
	var chkdiv = '';
	var editfieldsdiv = '';
	var paramarr = new Array();
	//赋值
	var thispowerval = fetchMultiArrayValue('roleManager.getspower',6,'&groupid=' + $('#thisgroupid').val() + '&imenuid=' + $('#thismenuid').val());
	var thispower = fetchMultiArrayValue('roleManager.getsrolepower',6,'&groupid=' + $('#thisgroupid').val() + '&imenuid=' + $('#thismenuid').val());
	if(thispower[0][0] != '' && thispower[0][0] != undefined){
		for(var i = 0 ; i < thispower.length;i++){
			chkdiv = '<input type="checkbox" id="'+thispower[i][0]+'_chkid" name="chkspowers" value="'+thispower[i][0]+'_val"/>';
			paramarr.push(thispower[i][0]);//扩展权限关键字数据存储
			thispower[i][1] = thispower[i][1]==''?'':getCaption(thispower[i][1], '<%=languageType %>', 'zh');
	        //var defaultvalues = $(this).attr("defaultvalues");
	        var type = thispower[i][3];
	        if(type=='select'){
	        	var dictstr = thispower[i][4].split('~');
	        	var optionstr = '';
	        	for(var j = 0 ; j < dictstr.length;j++){
	        		var tempstr = '';
	        		if(dictstr[j]=='true'){
	        			//tempstr = '有';
	        			tempstr = '<fmt:message key="roleManager.have" />';
	        		}else if(dictstr[j]=='false'){
	        			//无
	        			tempstr = '<fmt:message key="roleManager.nothave" />';
	        		}else{
	        			tempstr = dictstr[j];
	        		}
	        		optionstr += '<option value="'+dictstr[j]+'">'+tempstr+'</option>';
	        	}
	        	//未分配
	        	dictstr = '<label id="'+thispower[i][0]+'_oldvallabel" style="display:none"></label><select id="'+thispower[i][0]+'_spoweredit" style="margin-left: 10px;width: 155px;height: 20px;line-height: 25px"><option value=""><fmt:message key="roleManager.NotAssigned" /></option>'+optionstr+'</select>';
	        	editfieldsdiv = '';
	        }else if(type=='input'){
	        	dictstr = '<label id="'+thispower[i][0]+'_oldvallabel" style="display:none"></label><input id="'+thispower[i][0]+'_spoweredit" type="text" style="margin-left: 10px;width: 150px;height: 20px;line-height: 25px"/>';
	        	editfieldsdiv = '';
	        }else if(type=='list'){
	        	//var spowerfield = '暂无可配置的字段';
	        	var spowerfield ='<fmt:message key="roleManager.WithoutField" />';
	        	//可编辑字段 
    			if(thispowerval[0][1]!=''){
    				spowerfield = getTheAliasList();
    			}
	        	//editfieldsdiv = '<br/>&nbsp;配置表名：&nbsp;&nbsp;<label id="'+thispower[i][0]+'_spoweroldtab" style="display:none">'+thispowerval[0][1]+'</label><input type="text" id="'+thispower[i][0]+'_powerconfig" value="'+thispowerval[0][1]+'"/><a href="javascript:void(0)" onclick="createFields()" style="margin-left:5px">生成字段</a><br/>&nbsp;权限字段：<br/><div id="'+thispower[i][0]+'_spowerfields">'+spowerfield+'<div>';
	        	editfieldsdiv = '<br/>&nbsp;<fmt:message key="roleManager.Configurationtable" />&nbsp;&nbsp;<label id="'+thispower[i][0]+'_spoweroldtab" style="display:none">'+thispowerval[0][1]+'</label><input type="text" id="'+thispower[i][0]+'_powerconfig" value="'+thispowerval[0][1]+'"/><a href="javascript:void(0)" onclick="createFields()" style="margin-left:5px"><fmt:message key="roleManager.Generatingfield" /></a><br/>&nbsp;<fmt:message key="roleManager.powerfield" /><br/><div id="'+thispower[i][0]+'_spowerfields">'+spowerfield+'<div>';
	        	dictstr = '<label id="'+thispower[i][0]+'_oldvallabel" style="display:none"></label><input id="'+thispower[i][0]+'_spoweredit" type="text" style="margin-left: 10px;width: 150px;height: 20px;line-height: 25px" disabled="disabled"/>';
	        }
	        var description = thispower[i][5];
            description = description==''?'':getCaption(description, '<%=languageType %>', 'zh');
			spowertd += '<tr><td class="roletdleft">'+chkdiv+'</td><td class="roletdright"><a href="javascript:void(0)" title="'+description+'" onclick=javascript:$("#'+thispower[i][0]+'_editpower").toggle();>&nbsp;'+thispower[i][1]+'</a><div id="'+thispower[i][0]+'_fields"></div><div id="'+thispower[i][0]+'_editpower" style="color:blue;display:none;font-size:13px">&nbsp;'+description+editfieldsdiv+'</div></td><td class="roletdright">'+dictstr+'</td></tr>';
		}
	}
	$('#operform').html('<table style="width: 660px;line-height: 25px" cellspacing="1px"><tr><td class="roletdleft" style="width:30px"><input type="checkbox" id="allchkspower"/></td><td class="roletdright" style="width:450px" align="center">权限名称</td><td class="roletdright" style="width:250px" align="center">权限状态</td></tr>'
			+spowertd+'</table>');
	
    var valarr = new Array();
    //thispower[0][0] = '{receive=true/}{submitjob=true/}{print=true/}';
    if(thispowerval[0][0] != '' && thispowerval[0][0] != undefined){
		//返回数据格式：{receive=true/}{submitjob=true/}{print=true/}
		//thispower[0][0] = thispower[0][0].replace(/\/}{/g, ',');
		valarr = thispowerval[0][0].substring(1,thispowerval[0][0].length-2).split('/}{');
   	}		
    if(valarr.length!=0){
    	for(var i = 0 ; i < valarr.length; i++){
        	var arrtmp = valarr[i].split('=');
        	if(arrtmp[1]!=''){
        		$('#'+arrtmp[0]+'_chkid').attr('checked','checked');
        		$('#'+arrtmp[0]+'_spoweredit').val(arrtmp[1]);
        	}
        	$('#'+arrtmp[0]+'_oldvallabel').text(arrtmp[1]);
      	}
    }
    if('' != $('#editfields_spoweredit').val()){
    	forChecked('thefields',$('#editfields_spoweredit').val());
    }
    
	$('#paramarr').val(paramarr);
	//绑定复选框事件
	$("#allchkspower").click( function(){$(":checkbox[name='chkspowers']").attr("checked",$("#allchkspower").attr("checked"));});
	autoBlockForm('savemenudiv', 20, 'menupowerclose', "#ffffff", false);
}

//保存修改之后的权限
function spowerUpdate(){
	var spower = '';
	var thename = document.getElementsByName('chkspowers');
	if(thename.length==0){
		//alert('请选择要修改的记录');
		alert("<fmt:message key='roleManager.chooseRecord' />");
		return false;
	}
    var thevalue = '';
    var param = $('#paramarr').val();
    var paramarr = param.split(',');
    for (var i = 0; i < thename.length; i++) {
       	for(var j = 0 ; j < paramarr.length;j++){
       		if(paramarr[j]+'_val'==thename[i].value){
       			if (thename[i].checked == true) {
       				spower += paramarr[j]+'='+$('#'+paramarr[j]+'_spoweredit').val()+'@';
       			}else{
       				spower += paramarr[j]+'='+$('#'+paramarr[j]+'_oldvallabel').text()+'@';
       			}
       			break;
       		}
       	}
    }
    spower = spower.substring(0,spower.lastIndexOf('@'));
    spower = spower.replace(/@/g, '/}{');
    spower = '{'+spower+'/}';
    var editfieldtab = '';
    if($('#editfields_chkid').attr('checked')){
    	editfieldtab = $('#editfields_powerconfig').val();
    }else{
    	editfieldtab = $('#editfields_spoweroldtab').text();
    }
	var ress = executeNoQuery('roleManager.spowerupdate',6,'&memo='+editfieldtab+'&spower='+spower+'&groupid=' + $('#thisgroupid').val() + '&imenuid=' + $('#thismenuid').val());
	if(ress=='true'){
		//alert('保存成功');
		alert("<fmt:message key='roleManager.saveSuccess' />");
		getSpower($('#thismenuid').val());
		$('#menupowerclose').click();
	}
}

//生成字段
function createFields(){
	var tbconfig = $('#editfields_powerconfig').val();
	if('' != tbconfig){
		var divhtml = getTheAliasList(tbconfig);
		if('' == divhtml){
			//暂无可配置的字段
			divhtml = '<label style="margin-left:5px"><fmt:message key="roleManager.WithoutField" /></label>';
			
			
		}
		$('#editfields_spowerfields').html(divhtml);
	}
}
//选择权限进行赋值
function eidtClickForVal(){
	var thename = document.getElementsByName('thefields');
    var thevalue = '';
    for (var i = 0; i < thename.length; i++) {
        if (thename[i].checked == true) {
            thevalue += thename[i].value + ',';
        }
    }
    thevalue = thevalue.substring(0,thevalue.lastIndexOf(','));
    $('#editfields_spoweredit').val(thevalue);
}

</script>
<style type="text/css">
.a{margin-right:6%;border:1px solid #000;width:70%;overflow:left;text-overflow:ellipsis;}
.titlemargin{margin-left:82px !important;margin-left:42px;}
.spanstyle{display:-moz-inline-box; display:inline-block; width:115px;margin-left:5px}
hr {margin:2px 0 2px 0;border:0;border-top:1px dashed #CCCCCC;height:0;}
.groupa  a{cursor: hand;text-decoration: none;}
.groupa a:hover{color: #FF8C00;}
.roletdleft{border-bottom:1px dotted #000;}
.roletdright{border-left: 1px dotted #000;border-bottom:1px dotted #000;width:110px;word-break:break-all}
.roletdleft  a{cursor: hand;text-decoration: none;}
.roletdleft a:hover{color: #FF8C00;}
.roletdright a{cursor: hand;text-decoration: none;}
.roletdright a:hover{color: #FF8C00;}

</style>
	</head>


	<body style="SCROLLBAR-FACE-COLOR: #f6f6f6;SCROLLBAR-HIGHLIGHT-COLOR: #ffffff;SCROLLBAR-SHADOW-COLOR: #dddddd;SCROLLBAR-3DLIGHT-COLOR: #dddddd;SCROLLBAR-ARROW-COLOR: #616161;SCROLLBAR-TRACK-COLOR: #f6f6f6;SCROLLBAR-DARKSHADOW-COLOR: #ffffff;">
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
		<div id="buttons">
			<button type="button" id="editmenu" onclick="isClickDis(1);checkboxDisabled(false)"
				disabled="disabled">
				<!-- 修改 显示菜单 -->
				<fmt:message key="global.edit" />
			</button>
			<button type="button" id="savemenu" onclick="isClickDis(2);setPower()"
				disabled="disabled">
				<!-- 保存 修改的菜单 -->
				<fmt:message key="global.save" />
			</button>
			<button type="button" id="cancel"
				onclick="cancelOPer();clearTheList()">
				<!-- 取消操作 -->
				<fmt:message key="global.cancel" />
			</button>
		</div>
		<div style="width: 100%;">
			<!-- 左边权限组显示区 -->
			<div id=""
				style="margin-left: 25px; background-color: #F5FCFE;border:#99ccff 1px solid; width: 15%; float: left; margin-top: 20px">
				<div style="margin-top: 10px; margin-left: 10px;">
					<img src="<%=iconpath%>79.gif" style="margin-left: 10px;vertical-align: middle" />
					<!-- 可配置权限组 -->
					<fmt:message key="roleManager.groupCanBeConfigured" />
				</div>
				<hr/>
				<div id="grouplist" style="text-align: center">
				</div>
				<br />
			</div>
			
			<!-- 中间菜单显示区 -->
			<div id=""
				style="border:#99ccff 1px solid;margin-left: 35px; background-color: #F5FCFE; width: 25%; height: 30%; float: left; margin-top: 20px">
				<p id="thisdisplaygroup" style="margin-top: 2px;margin-left: 5px"></p>
				<div style="margin-top: 10px; margin-left: 20px;">
					<p class="groupa">
						<a href="javascript:{tsdtree.expandAll();}"><fmt:message key="role.openall" /></a> |
						<a href="javascript:{tsdtree.collapseAll();}"><fmt:message key="role.closeall" /></a>
					</p>
					<p class="groupa">
						<a href="javascript:{tsdtree.checkedAll(true);}">
						<!-- 全部选择 -->
						<fmt:message key="roleManager.checkAlls" />
						</a> |
						<a href="javascript:{tsdtree.checkedAll(false);}">
						<!-- 全部取消选择 -->
						<fmt:message key="roleManager.DeselectAll" />
						</a>
					</p>
				</div>
				<hr />
				<div id="menuloadingdiv" style="font-size: 13px;text-align: center;">
					<!-- 正在加载菜单数据，请稍候... -->
					<fmt:message key="roleManager.waiting" />
				</div>
				<form id='menu'>
					<div id="menulist" style="margin-top: 5px;margin-left: 10px;margin-right: 10px;"></div>
				</form>
				<br />
			</div>
			<br />
			<!-- 右边权限配置区 -->
			<div style="border:#99ccff 1px solid;margin-left: 50px; background-color: #F5FCFE; width: 32%; height: 30%; float: left; margin-top: 5px">
				<div id="inputs">
					<div id="input-Unit">
						<div id='rightslist' style="display: none">
							<div class="title" style="text-align: left" >
								<table style="width: 330px">
									<tr>
										<td>
											<h4>
											<img src="<%=iconpath%>55.gif" style="margin-left: 10px;vertical-align: middle;" />
											<!-- 当前菜单权限 -->
											<fmt:message key="role.menupower" />
											</h4>
										</td>
										<td align="right" class="groupa">
											<a href="javascript:void(0)" id="spoweredit" style="vertical-align: middle;" onclick="rolePowerEdit()">
											<!-- 权限修改 -->
											<fmt:message key="roleManager.Permissiontomodify" /></a>
										</td>
									</tr>
								</table>
							</div>
							<div id="spowerdiv">
							</div>
						</div>
						<div class="title" style="text-align: left">
							<h4>
								<img src="<%=iconpath%>41.gif" style="margin-left: 10px;vertical-align: middle;" />
								<!-- <fmt:message key="role.setgroup" /><!-- 权限组设置 -->
								<!-- 权限设置说明 --><fmt:message key="roleManager.powerDesc" />
							</h4>
						</div>
						<div style=" background-color: #F5FCFE;border:#99ccff 1px solid;line-height: 20px;margin-top: 1px;margin-left: 5px;margin-right: 5px;font-size: 13px">
							<!-- 
							1、权限设置即是给系统已配置好的的权限组分配菜单管理权限和页面操作权限；<br/>
							2、给权限组分配可管理菜单，选择要分配的权限组，在右边菜单树会默认勾选已分配的管理菜单。点击左上角修改按钮，
							复选框按钮状态变为可用，勾选要分配的菜单，确认之后点击左上角保存按钮进行数据保存，点击取消按钮放弃当前操作；<br/>
							3、给权限组可管理的菜单分配页面操作权限，点击要分配的菜单，在右上角会显示当前菜单所属权限组的页面详细操作权限，
							权限状态表示当前选中权限组对此页面的操作权限。点击右上角权限修改可对扩展权限进行编辑；<br/>
							4、点击权限名称下的权限可查看扩展权限详细说明；<br/>
							5、菜单隶属权限组，页面操作权限隶属菜单，在配置权限前请先确认要配置权限的菜单已属于该权限组；<br/>
							 -->
							 <fmt:message key="roleManager.Description1" /><br/>
							<fmt:message key="roleManager.Description2" />
							<fmt:message key="roleManager.Description22" /><br/>
							<fmt:message key="roleManager.Description3" />
							<fmt:message key="roleManager.Description33" /><br/>
							<fmt:message key="roleManager.Description4" /><br/>
							<fmt:message key="roleManager.Description5" /><br/>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 可忽略 -->
			<input type="hidden" id="operation"
				value="<fmt:message key="global.operation"/>" />
			<input type="hidden" id="operationtips"
				value="<fmt:message key="global.operationtips"/>" />
			<input type="hidden" id="successful"
				value="<fmt:message key="global.successful"/>" />
			<input type="hidden" id="deleteinformation"
				value="<fmt:message key="global.deleteinformation"/>" />
			<input type="hidden" id="languageType" value="<%=languageType%>" />
			<input type="hidden" id="userid" value="<%=userid%>" />
			<input type="hidden" id="global"
				value="<fmt:message key="main.global"/>" />
			<input type="hidden" id="menupower"
				value="<fmt:message key="role.menupower"/>" />
			<input type="hidden" id="powername"
				value="<fmt:message key="role.powername"/>" />
			<input type="hidden" id="powervalue"
				value="<fmt:message key="role.powervalue"/>" />
			<input type="hidden" id="imenuid" value="<%=imenuid%>" />
			<input type="hidden" id="zid" value="<%=groupid%>" />
			<input type="hidden" id="thismenuid" />
			<input type="hidden" id="thisgroupid" />
			<input type="hidden" id="thisspower" />
			<input type="hidden" id="thismemo" />

			<input type="hidden" id="thisdict" />
			<input type="hidden" id="getthispower" />
			<input type="hidden" id="whichtype" />
			<input type="hidden" id="opertype" />
			<input type="hidden" id="basepath" value="<%=iconpath%>" />

			<input type="hidden" id="add" />
			<input type="hidden" id="deleteinfo" />
			<input type="hidden" id="editmenus" />
			<input type="hidden" id="editmenupowers" />
			<input type="hidden" id="savemenus" />
			<input type="hidden" id="savemenupowers" />
			
			<input type="hidden" id="thespower"/>
			<input type="hidden" id="ismodifyright"/>
			<input type="hidden" id="thealias"/>
			<input type="hidden" id="theparamalias"/>
			<input type="hidden" id="therealparam"/>
			<input type="hidden" id="flagvalue"/>
			<input type="hidden" id="disflag"/>
				
			<input type="hidden" id="isthelist" />
			<input type="hidden" id="disclear" />
			<input type="hidden" id="canceloper" />
			<input type="hidden" id="thelogmenuid" />
			<input type="hidden" id="disopergroupid" />
			
			<input type='hidden' id='userloginip'
					value='<%=Log.getIpAddr(request)%>' />
				<input type='hidden' id='userloginid'
					value='<%=session.getAttribute("userid")%>' />
				<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
				
			<!-- 管理员在配置权限字段时显示的面板 -->
			<div class="neirong" id="adds" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">
								<!-- 选择可编辑字段 -->
				        		<fmt:message key="roleManager.checkCanEditData" /></div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#Qclose').click();">
							<!-- 关闭 -->
				        	<fmt:message key="roleManager.close" />
							</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd" >
					   <form action="#" name="editfieldform"
							id="editfieldform" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>	
								<td>
									<div id="thelistform" style="text-align: left;margin-left: 10px;max-height:200px;overflow-y: auto;overflow-x: hidden;">
									</div>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" id="query" onclick="checkedAll()">
							<!-- 全选 -->
							<fmt:message key="roleManager.checkAll" />
					</button>
					<button type="submit" class="tsdbutton" onclick="getTheChecked()">
							<fmt:message key="global.ok" />
					</button>
					<button type="button" class="tsdbutton" style="margin-left: 10px" id="Qclose">
							<fmt:message key="global.close" />
					</button>
				</div>
		</div>
		
	<div class="neirong" id="savemenudiv"
		style="display: none; width: 660px">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
					<div class="top_03" id="jobdivtitle">
					<!-- 权限修改 -->
					<fmt:message key="roleManager.Permissiontomodify" /></div>
					<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
				</div>
				<div class="top_01right">
					<a href="#" onclick="javascript:$('#menupowerclose').click();"><fmt:message key="global.close" /></a>
				</div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>
		</div>
		<div class="midd" id="operform" style="overflow-y: auto; overflow-x: hidden;max-height: 360px;font-size: 13px"></div>
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="savemenupower" onclick="spowerUpdate()"><fmt:message key="global.save" /></button>
			<button type="button" class="tsdbutton" id="menupowerclose" style="width: 60px"><fmt:message key="global.close" /></button>
		</div>
	  </div>
	  
	  <input type="hidden" id="paramarr"/>
	</body>
</html>
