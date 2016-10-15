<%----------------------------------------
	name: ordermenu.jsp
	author: chenliang
	version: 1.0, 2010-05-14
	description: 用户可对系统菜单进行自定义显示
	modify: 
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.io.File"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/big/";
	String icon = basePath + "style/icon/";
	
	String languageType = (String)session.getAttribute("languageType");//系统语言环境
%>
<%
	String rootPath = request.getRealPath("/style/icon/big/");//大图标所在文件夹
	
	File thepath = new File(rootPath);
	int x = 0;
	if(thepath.listFiles().length>0){
		for(int i = 0 ; i < thepath.listFiles().length;i++){
			if(thepath.listFiles()[i].toString().endsWith(".png")){
				x++;
			}
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>自定义显示菜单</title>
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
		<style type="text/css">
			.spanstyle{display:-moz-inline-box; display:inline-block; width:200px}
			.tdborder{border: 1px; border-style: solid; border-color: #87CEFA;line-height:20px}
			#ishidestyle a {
				cursor: hand;
				text-decoration: none;}
			#ishidestyle a:hover {
				color: red;
			}
			#editlabelstyle a {
				cursor: hand;
				text-decoration: none;}
			#editlabelstyle a:hover {
				color: #FF8C00;
			}
		</style>
<script type="text/javascript">
/**
 * 显示初始化数据
 * @param 无参数
 * @return 无返回值
 */
jQuery(document).ready(function () 
{
    $("#navBar1").append(genNavv());
    //显示导航
    disMyMenu();
    //已定制的显示菜单
});
/**
 * 显示当前可浏览菜单
 * @param 无参数
 * @return 无返回值
 */
function disMenu()
{
    var dismymenu = $('#dismymenu').val();
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', clsname : 'Procedure', method : 'exequery', ds : 'tsdBilling', //数据源名称 对应的spring配置的数据源
        tsdpname : 'main.getMenu', //存储过程的映射名称
        tsdExeType : 'query', datatype : 'xmlattr' 
    });
    var userid = '<%=session.getAttribute("userid") %>';
    var groupid = '<%=session.getAttribute("groupid") %>';
    //在存储过程中要传的参数
    $.ajax(
    {
        url : 'mainServlet.html?userid=' + userid + urlstr + '&groupid=' + groupid, datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 3000, async : true , //同步方式
        success : function (xml)
        {
            var infos = '';
            var i = 1;
            var pmenuarr = new Array();
            $(xml).find('row').each(function ()
            {
                var imenuid = $(this).attr("imenuid");
                if (dismymenu.indexOf(imenuid) ==- 1 || dismymenu == '')
                {
                    var iparentid = $(this).attr("iparentid");
                    var imenuname = $(this).attr("smenuname");
                    var simgico = $(this).attr("simgico");
                    var imenuurl = $(this).attr("smenuurl");
                    var menuname = getCaption(imenuname, '<%=languageType %>', '');
                    var str = '';
                    pmenuarr.push(imenuid + '~' + menuname);
                    if (iparentid != 0)
                    {
                        if (i * 1 % 2 == 0) {
                            str = '<br/>';
                        }
                        var ipmenuname = '';
                        for (var m = 0; m < pmenuarr.length; m++) {
                            var marr = pmenuarr[m].split('~');
                            if (iparentid == marr[0]) {
                                ipmenuname = marr[1];
                                break;
                            }
                        }
                        var listvalue = imenuid + '~' + imenuname + '~' + imenuurl + '~' + ipmenuname;
                        infos += "<span class='spanstyle'><input type='checkbox' id='menuids" + i + "' name='menuids' value='" + listvalue + "' style='width:15px;height:15px;'><img src='" + simgico + "' style='margin-left:5px' alt='菜单图标'/><label style='text-align: left;margin-left:2px'>" + menuname + "</label></span>" + str;
                        i++;
                    }
                }
            });
            if (infos != '') {
                $('#dismenuopertor').show();
                $('#thelistmenu').html(infos);
            }
            else
            {
                $('#dismenuopertor').hide();
                $('#thelistmenu').html('<center style="margin-top: 100px;"><img src="style/images/public/dismenu.gif" alt="提示信息"/><br />您暂无菜单可配置...</center>');
            }
        }
    });
}
/**
 * 显示已经订制的菜单 
 * @param 无参数
 * @return 无返回值
 */
function disMyMenu()
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
        tsdpk : 'ordermenu.querymymenu'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?userid=<%=session.getAttribute("userid") %>' + urlstr, datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 3000, async : false , //同步方式
        success : function (xml)
        {
            var distitle = '<table width="512px" style="border: 1px; border-style: solid; border-color: #87CEFA;text-align:center" cellpadding="2px" cellspacing="1px">';
            var stastr = '<tr ><td class="tdborder" width="20px"><input type="checkbox" id="dismenuid" onclick="willChecked()" style="width:15px;height:15px;"></td><td class="tdborder" width="40px">序号</td><td class="tdborder" width="40px">大图标</td><td class="tdborder">原名称</td><td class="tdborder">自定义名称</td><td class="tdborder">是否可见</td><td class="tdborder">操作</td></tr>';
            var disinfos = '';
            var endstr = '</table>';
            var i = 1 ;
            var dismymenu = '';
            $(xml).find('row').each(function ()
            {
                var imenuid = $(this).attr("imenuid");
                var imenuname = $(this).attr("imenuname");
                var ioldname = $(this).attr("ioldname");
                var imenuicon = $(this).attr("imenuicon");
                var ishide = $(this).attr("ishide");
                if (imenuid != undefined && imenuid != '')
                {
                    var willhide = ishide;
                    dismymenu += imenuid + ',';
                    if (ishide == 0) {
                        ishide = '可见';
                    }
                    else if (ishide == 1) {
                        ishide = '隐藏';
                    }
                    else {
                        ishide = '数据格式错误';
                    }
                    disinfos += "<tr><td class='tdborder'><input type='checkbox' id='dis" + imenuid + "'  name='mymenuids' value='" + imenuid + "' style='width:15px;height:15px;'></td><td class='tdborder'>" + i + "</td><td class='tdborder'><img src='<%=basePath%>style/icon/big/" + imenuicon + "' width='24' height='24' alt='自定义图标'/></td><td class='tdborder'>" + ioldname + "</td><td class='tdborder'>" + imenuname + "</td><td class='tdborder' id='ishidestyle'><a href='javascript:;' hidefocus='true' onclick=isWillHide('" + imenuid + "','" + willhide + "')><span id='hide" + imenuid + "'>" + ishide + "</span></a></td><td class='tdborder'><label id='editlabelstyle'><a href='javascript:;' hidefocus='true' onclick=eidtDisMenu('" + imenuid + "','" + imenuicon + "','" + imenuname + "')>编辑</a></label></td></tr>";
                }
                i++;
            });
            if (disinfos != '')
            {
                dismymenu = dismymenu.substring(0, dismymenu.lastIndexOf(','));
                $('#dismymenu').val(dismymenu);
                $('#mymenulist').html(distitle + stastr + disinfos + endstr);
                disMenu();
                $('#dismymenuopertor').show();
            }
            else
            {
                $('#dismymenu').val('');
                disMenu();
                $('#dismymenuopertor').hide();
                $('#mymenulist').html('<center id="discenter" style="margin-top: 100px;"><img src="style/images/public/dismenu.gif" alt="提示信息"/><br />您尚未配置自定义显示菜单...</center>');
            }
        }
    });
}
/**
 * 选择可选菜单显示
 * @param 无参数
 * @return 无返回值
 */
function disSaveChecked()
{
    var tagname = document.getElementsByName("menuids");
    var x = 0;
    for (var i = 0 ; i < tagname.length; i++) {
        if (tagname[i].checked == true) {
            x++;
        }
    }
    $('#willtips').val(x);
    var disimenuid = '';
    if (x != 0)
    {
        if (confirm('您确定要自定义设置菜单吗?'))
        {
            var tips = 1;
            for (var i = 0 ; i < tagname.length; i++)
            {
                if (tagname[i].checked == true)
                {
                    var disvalue = tagname[i].value;
                    var disarr = disvalue.split('~');
                    disarr[1] = getCaption(disarr[1], '<%=languageType %>', '');
                    saveChecked(disarr[0], disarr[1], disarr[2], tips, disarr[3]);
                    tips++;
                }
            }
        }
    }
    else {
        alert('请选择您要保存的菜单!');
    }
}
/**
 * 保存所选中的
 * @param imenuid
 * @param imenuname
 * @param imenuurl
 * @param tips
 * @param ipmenuname
 * @return 无返回值
 */
function saveChecked(imenuid, imenuname, imenuurl, tips, ipmenuname)
{
    var params = '';
    params += 'imenuid=' + imenuid;
    params += '&imenuname=' + tsd.encodeURIComponent(imenuname);
    params += '&ipmenuname=' + tsd.encodeURIComponent(ipmenuname);
    params += '&imenuurl=' + imenuurl;
    params += '&imenuicon='+'1.png';
    params += '&userid=<%=session.getAttribute("userid") %>';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : 'ordermenu.savechecked'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + params + urlstr, cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (msg)
        {
            if (msg == "true")
            {
                var willtips = $('#willtips').val();
                if (tips == willtips) {
                    alert('保存成功!');
                    disMyMenu();
                    disMenu();
                }
            }
        }
    });
}
/**
 * 将图标设为隐藏
 * @param imenuid
 * @param ishide
 * @return 无返回值
 */
function isWillHide(imenuid, ishide)
{
    if (ishide == 0) {
        ishide = 1;
    }
    else if (ishide == 1) {
        ishide = 0;
    }
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : 'ordermenu.ishide'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?userid=<%=session.getAttribute("userid") %>&imenuid=' + imenuid + '&key=' + ishide + urlstr, 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (msg)
        {
            if (msg == "true") {
                disMyMenu();
            }
        }
    });
}
/**
 * 是否全选状态
 * @param 无参数
 * @return 无返回值
 */
function willChecked()
{
    var flag = document.getElementById('dismenuid').checked;
    var tagname = document.getElementsByName("mymenuids");
    for (var i = 0 ; i < tagname.length; i++) {
        tagname[i].checked = flag;
    }
}
/**
 * 编辑菜单
 * @param imenuid
 * @param imenuicon
 * @param imenuname
 * @return 无返回值
 */
function eidtDisMenu(imenuid, imenuicon, imenuname)
{
    $('#icontr').hide();
    $('#oldname').val(imenuname);
    $('#myname').val(imenuname);
    $('#disicon').val(imenuicon);
    $('#disimenuid').val(imenuid);
    autoBlockForm('editordermenu', 10, 'close', "#ffffff", true);
    //弹出查询面板
}
/**
 * 获取图标
 * @param 无参数
 * @return 无返回值
 */
function disListIcon()
{
    $('#icontr').show();
    var disinfos = '';
    for (var i = 1 ; i < <%= x %> ; i++)
    {
        var disradio = '<input type="radio" onclick="disCheckIcon()" value="' + i + '.png" style="margin-left:5px" name="disradio" id="icon' + i + '" />';
        var info = '<label><img style="margin-left: 2px" src="<%=iconpath %>' + i + '.png"/></label>';
        var thestr = '';
        if (i % 6 == 0) {
            thestr = '<br/>';
        }
        disinfos += disradio + info + thestr;
    }
    $('#iconlist').html(disinfos);
}
/**
 * 显示选中图标
 * @param 无参数
 * @return 无返回值
 */
function disCheckIcon()
{
    var tagname = document.getElementsByName("disradio");
    for (var i = 0 ; i < tagname.length; i++) {
        if (tagname[i].checked == true) {
            $('#disicon').val(tagname[i].value);
        }
    }
}

/**
 * 关闭面板
 * @param 无参数
 * @return 无返回值
 */
function willClose()
{
    $('#close').click();
}
/**
 * 保存显示信息
 * @param 无参数
 * @return 无返回值(操作成功)/false(验证不通过)
 */
function saveEdit()
{
    var params = '';
    var myname = $('#myname').val();
    var myicon = $('#disicon').val();
    if (myname == '') {
        alert('对不起,菜单显示名称不允许为空');
        $('#myname').focus();
        return false;
    }
    if (myicon == '') {
        alert('对不起,显示图标不允许为空');
        $('#disicon').focus();
        return false;
    }
    params += '&imenuname=' + tsd.encodeURIComponent(myname);
    params += '&imenuicon=' + myicon;
    var imenuid = $('#disimenuid').val();
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : 'ordermenu.saveedit'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?userid=<%=session.getAttribute("userid") %>&imenuid=' + imenuid + params + urlstr, 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (msg)
        {
            if (msg == "true") {
                alert('修改成功!');
                disMyMenu();
                willClose();
            }
        }
    });
}
/**
 * 移除自定义菜单
 * @param 无参数
 * @return 无返回值(操作成功)/false(验证不通过)
 */
function disDelMenu()
{
    var tagname = document.getElementsByName("mymenuids");
    var checkedids = '';
    for (var i = 0 ; i < tagname.length; i++) {
        if (tagname[i].checked == true) {
            checkedids += tagname[i].value + ',';
        }
    }
    if (checkedids == '') {
        alert('请选择您要删除的自定义菜单!');
        return false;
    }
    else
    {
        checkedids = checkedids.substring(0, checkedids.lastIndexOf(','));
        var tips = '';
        if (checkedids.indexOf(',') !=- 1) {
            tips = '这些';
        }
        else {
            tips = '这个';
        }
        if (confirm('您确定要删除' + tips + '菜单吗?'))
        {
            var urlstr = tsd.buildParams(
            {
                packgname : 'service', //java包
                clsname : 'ExecuteSql', //类名
                method : 'exeSqlData', //方法名
                ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
                tsdcf : 'mssql', //指向配置文件名称
                tsdoper : 'exe', //操作类型 
                tsdpk : 'ordermenu.deletemymenu'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
            });
            $.ajax(
            {
                url : 'mainServlet.html?userid=<%=session.getAttribute("userid") %>&imenuid=' + checkedids + urlstr, 
                cache : false, //如果值变化可能性比较大 一定要将缓存设成false
                timeout : 1000, async : false , //同步方式
                success : function (msg)
                {
                    if (msg == "true") {
                        alert('删除成功!');
                        disMyMenu();
                    }
                }
            });
        }
        else
        {
            if (checkedids.indexOf(','))
            {
                var checkedarr = checkedids.split(',');
                for (var i = 0 ; i < checkedarr.length; i++) {
                    $('#dis' + checkedarr[i]).removeAttr('checked');
                }
            }
            else {
                $('#dis' + checkedids).removeAttr('checked');
            }
            if (document.getElementById('dismenuid').checked) {
                document.getElementById('dismenuid').checked = false;
            }
            else {
                document.getElementById('dismenuid').checked = trues;
            }
        }
    }
}
/**
 * 菜单全选
 * @param 无参数
 * @return 无返回值
 */
function disGetAll()
{
    var tagname = document.getElementsByName("menuids");
    for (var i = 0; i < tagname.length; i++)
    {
        if (tagname[i].checked == true)
        {
            for (var j = 0 ; j < tagname.length; j++) {
                tagname[j].checked = false;
            }
            $('#disquery').html('全选');
            break;
        }
        else
        {
            for (var j = 0 ; j < tagname.length; j++) {
                tagname[j].checked = true;
            }
            $('#disquery').html('全不选');
            break;
        }
    }
}
</script>
</head>

<body>
	<div id="navBar">
		<table width="100%" height="26px">
			<tr>
				<td width="80%" valign="middle">
					<div id="navBar1" style="float: left">
						<img src="<%=icon%>dot11.gif" style="margin-left: 10px" />
						<fmt:message key="global.location" />
						:
					</div>
				</td>
				<td width="20%" align="right" valign="top">
					<div id="d2back">
						<a href="javascript:void(0);"
							onclick="parent.history.back(); return false;"><fmt:message
								key="gjh.houtuei" /> </a>
					</div>
				</td>
			</tr>
		</table>
	</div>
	&nbsp;
	<!-- 可浏览的菜单 -->
	<div class="neirong" id="thefieldsform"
		style="display: block; width: 440px;margin-top: 20px;height: 310px">
		<div class="top">
			<div class="top_01" id="thisdrags">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						可浏览菜单
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
					
				</div>
				<div class="top_01right">
					<!-- <a href="#" onclick="javascript:$('#closethisinfo').click();">关闭</a> -->
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
							<div id="thelistmenu"
								style="margin-left: 10px; max-height: 300px;overflow-y: auto;overflow-x: hidden;">
								<center style="margin-top: 120px">数据加载中...</center>
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="midd_butt" >
			<div id='dismenuopertor'>
				<button type="submit" class="tsdbutton" id="disquery"
					onclick="disGetAll()">
					全选
				</button>
				<button type="submit" class="tsdbutton" id="dissave"
					onclick="disSaveChecked()">
					提交
				</button>
			</div>
		</div>
	</div>
	
	<!-- 我的菜单 -->
	<div class="neirong" id="mymenuform"
		style="display: block; width: 540px;margin-top: 20px;margin-left: 450px">
		<div class="top">
			<div class="top_01" id="thisdrags">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						我的菜单
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<!-- <a href="#" onclick="javascript:$('#closethisinfo').click();">关闭</a> -->
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>
		<div class="midd">
			<form action="#" onsubmit="return false;" style="margin-top: 10px">
				<table width="100%" id="tdiv" border="0" cellspacing="0"
					cellpadding="0">
					<tr>
						<td>
							<div id="mymenulist"
								style="margin-left: 10px;margin-right: 10px; height: 300px;max-height: 300px;overflow-y: auto;overflow-x: hidden;">
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="midd_butt">
			<div id="dismymenuopertor">
				<button type="submit" class="tsdbutton" id="modify"
						onclick="disDelMenu()">
					<fmt:message key="global.delete" />
				</button>
			</div>
		</div>
	</div>
	
	<!-- 编辑显示菜单 -->
	<div class="neirong" id="editordermenu" style="display: none; width: 700px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							编辑自定义菜单
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="clearText('operform');willClose()">关闭</a>
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
								原名称
							</td>
							<td class="tdstyle">
								<input type="text" id="oldname"
									class="textclass" style="width: 150px"  disabled="disabled" />
							</td>
							<td class="labelclass">
								自定义名称
							</td>
							<td class="tdstyle">
								<input type="text" class="textclass"
									style="width: 150px" id="myname"/>
							</td>
							<td class="labelclass">
								显示图标
							</td>
							<td class="tdstyle">
								<input type="text" class="textclass" id="disicon" onfocus="disListIcon()"
									style="width: 150px"/>
							</td>
							
						</tr>
						<tr id="icontr" style="display: none">
							<td class="dflabelclass">
								大图标
							</td>
							<td colspan="5">
								<div id="iconlist"
									style="max-height: 250px;overflow-y: auto;overflow-x: hidden;">
								</div>	
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" id="modify"
					onclick="saveEdit()">
					<fmt:message key="global.edit" />
				</button>
				<button type="button" class="tsdbutton" id="close"
					style="margin-left: 10px"
					onclick="clearText('operform');">
					<fmt:message key="global.close" />
				</button>
			</div>
	</div>
	
	<input type="hidden" id="willtips"/>
	<input type="hidden" id="disimenuid"/>
	<input type="hidden" id="dismymenu"/>
</body>
</html>