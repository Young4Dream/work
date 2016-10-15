<%----------------------------------------
	name: main.jsp
	author: chenliang
	version: 1.0, 2010-11-04
	description: 扎帐操作
	modify: 
	    chenze  2010-11-29  修改导航菜单位置
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.tsd.service.util.Log"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
	String userid = (String) session.getAttribute("userid");//工号
	String groupid = (String) session.getAttribute("groupid");//所在权限组
	String username = (String) session.getAttribute("username");//工号名称
	String userarea = (String) session.getAttribute("userarea");//业务区域
	String chargearea = (String) session.getAttribute("chargearea");//营收区域
	String departname = (String) session.getAttribute("departname");//所在部门
	String languageType = request.getParameter("languageType");//系统语言环境
	if (!languageType.equals("en")) {
		if (languageType.equals("vi")){
			languageType = "vi";  //越南语		
		}
		else
		{
			languageType = "zh";
		}
	}
	session.setAttribute("languageType", languageType);//将语言环境存储到session中去
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><fmt:message key="main.thetitle" /></title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<script type="text/javascript" src="plug-in/extjs/ext-base.js"></script>
		<script type="text/javascript" src="plug-in/extjs/ext-all.js"></script>		
		<!-- jquery -->
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<script type="text/javascript" src="script/public/main.js"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />	
		<script type="text/javascript" src="script/system/tsdtree.js"></script>		
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>			
		<link rel="Shortcut Icon" href="style/images/public/favicon.ico"/>
		<link rel="stylesheet" type="text/css" href="style/css/system/main.css" />
		<link rel="stylesheet" type="text/css" href="style/css/system/tsdtree.css" />
		<link rel="stylesheet" type="text/css" href="style/skin0.css" />
		<script src="script/system/main.js" type="text/javascript" language="javascript"></script>
		
		<link href="AeroWindow/css/AeroWindow.css?r=123" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="AeroWindow/js/jquery-1.4.2.min.js"></script> 
    <script type="text/javascript" src="AeroWindow/js/jquery-ui-1.8.1.custom.min.js"></script> 
    <script type="text/javascript" src="AeroWindow/js/jquery.easing.1.3.js"></script>         
    <script type="text/javascript" src="AeroWindow/js/jquery-AeroWindow.js"></script>
<script type="text/javascript">
window.onbeforeunload = function(){ 
    var n = window.event.screenX - window.screenLeft; 
    var b = n > document.documentElement.scrollWidth - 40;
    if(b && window.event.clientY < 0 || window.event.altKey){ 
    	window.event.returnValue = userLogout();//回调函数
    } 
    /********** 电话停机保号到期提示  宽带到期提示 ***********/
				$("#maturitypanel").draggable(); 
				$('#maturitypanel').css('top', '200px');  					
				isMaturity();//电话停机保号到期提示  宽带到期提示
							/**
			 * 电话停机保号到期提示  宽带到期提示
			 * @param 无参数
			 * @return 无返回值
			 */
			 function isMaturity(){
				//ZSYXM-151系统登陆--登陆系统时，对停机保号到期及宽带到期用户的提醒仅显示在丰和大厦及丰和园小区区域，在其它区域不显示。
				var managearea ='<%=session.getAttribute("managearea") %>';
				var isFHXQ = managearea.indexOf('丰和园小区');
				var isFHDS = managearea.indexOf('丰和大厦');
				if(isFHXQ!=-1||isFHDS!=-1)
				{
					var urlstr=tsd.buildParams({ 
									packgname : 'service', //java包
							        clsname : 'ExecuteSql', //类名
							        method : 'exeSqlData', //方法名
							        ds : 'tsdBilling', //数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
							        tsdcf : 'mssql', //指向配置文件名称
							        tsdoper : 'query', //操作类型 
							        datatype : 'xmlattr', //返回数据格式 
							        tsdpk :'main.getMaturity' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    				});
    				
    				var areastr ='&area='+tsd.encodeURIComponent('<%=session.getAttribute("managearea") %>');
    					alert('<%=session.getAttribute("userid") %>');    
    					alert('<%=session.getAttribute("managearea") %>');
    					alert('<%=departname %>');
    					alert(areastr);
    					
    							
					$.ajax({
							url:'mainServlet.html?userid=<%=session.getAttribute("userid") %>'+urlstr+'&dept='+tsd.encodeURIComponent('<%=departname %>')+areastr,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 3000,
							async: false ,//同步方式
							success:function(xml){
								var isMaturityC =0;
								var type ;
								var count;
								var times;
								$(xml).find('row').each(function(){
									type = $(this).attr("type");
									count = $(this).attr("nums");
									times = $(this).attr("times");
									if(type=='phone' && count>0 ){//第一条记录
										isMaturityC ++;										
										$("#maturityinfo").html("<p>电话用户：截止到本月底将有"+count+"人停机保号到期</p>"+$("#maturityinfo").html());										
									}else if(type=='broadband_3' && count>0 ){//第三条记录
										isMaturityC++;
										$("#maturityinfo").html($("#maturityinfo").html()+"<p>宽带用户：下个月将有"+count+"个私费用户宽带到期</p>");
									}else if(type=='broadband_4' && count>0 ){//第三条记录
										isMaturityC++;
										$("#maturityinfo").html($("#maturityinfo").html()+"<p>宽带用户：下个月将有"+count+"个公费用户宽带到期</p>");
									}
									/**
									else if(type=='broadband_1' && count>0 ){//第二条记录
										isMaturityC++;
										$("#maturityinfo").html($("#maturityinfo").html()+"<p>宽带用户：" +"最近"+times+"天将要有"+count+"人私费用户到期</p>");
									}else if(type=='broadband_2' && count>0 ){//第三条记录
										isMaturityC++;
										$("#maturityinfo").html($("#maturityinfo").html()+"<p>宽带用户：" +"最近"+times+"天将要有"+count+"人公费用户到期</p>");
									}*/
								});
								
								//如果今天有到期提示，则弹出提示框
								if(isMaturityC > 0){
									autoBlockForm('maturitypanel', '0', 'maturityclose', "#ffffff", true);       
								}								
							}
					});
				}
			 }
}
//用户退出
function userLogout(){
	//if(confirm('您确定要退出系统吗?')) {
		logInfo();
		var userid = $("#userloginid").val();
		executeNoQuery("dbsql_phone.deleteCurrentPay_userid",6,"&userid="+userid);
		var urlstr="mainServlet.html?exitLogin=true";
		$.ajax({
			url:urlstr,
			type: 'post',
			cache:false,
			timeout: 2000,
			async: false ,//同步方式
			complete: function(){					
				window.open("","_self");//for ie7-8 
				window.close();	 
			}
		});
	//}
}
$(function(){
					
			 
	//加载菜单
	Ext.app.tsd.treeRender('menu-panel');
	//getUserPower();
	var hasnotice = fetchSingleValue('dbsql_main.hasnotice',6,'');//是否有通知通告
	var noticeurl = '';
	if(hasnotice=='Y'){
		sysNotice();//加载系统公告
		$('#noticelist,#leftnotices').show();
		noticeurl = 'mainServlet.html?pagename=right-notices.jsp&getproc=false';
	}else{
		noticeurl = 'mainServlet.html?pagename=right.jsp';
	}
	var hasworkflow = fetchSingleValue('dbsql_main.hasworkflow',6,'');//是否有工单管理模块
	
	if(hasworkflow=='Y'){
		//getNewJob();//获取显示工单信息
		//window.setInterval('getNewJob()', 15 * 60 * 1000);
		thisDisplay();
		 //显示面板信息
        $('#tiptitle').html('您有新的工单到达!');
        $('#tipstemp').html('<span class="close" id="tipclose" onclick=javascript:$("#winpop").hide("slow")>X</span>');
	}
	$('#main-frame').attr('src',noticeurl);
	writeLogInfo(tsd.encodeURIComponent("<fmt:message key='main.systemoper'/>"),'system',
		tsd.encodeURIComponent("<fmt:message key='main.user'/><%=userid%><fmt:message key='main.loginsystem'/>"));
});


$(document).ready(function() {
		jobwindow();
		setInterval("jobwindow()",300*1000);		
 });
 
 function jobwindow(){ 		
		var resultis0 = fetchMultiPValue("main.queryjobwindows",6,"&deptname="+tsd.encodeURIComponent($("#departname").val()));
		if(resultis0[0]==undefined || resultis0[0][0]==undefined || resultis0[0][0]=='-1'||(resultis0[0][0]==0&&resultis0[0][1]==0&&resultis0[0][2]==0)){		
			return;
		}else{
        	$('#jobWindow').AeroWindow({
			  WindowTitle:          '工单提醒',
			  WindowPositionTop:    document.documentElement.clientHeight-190,
			  WindowPositionLeft:   document.documentElement.clientWidth-190,
			  WindowWidth:          160,
			  WindowHeight:         120,
			  WindowAnimation:      'easeOutBounce'        
			});
 			queryJobnum();
 			
 			
		}			
 	}
 	
 
//查询各种工单数
 function queryJobnum(){
 	var result = fetchMultiPValue("main.queryjobwindows",6,"&deptname="+tsd.encodeURIComponent($("#departname").val()));
		if(result[0]==undefined || result[0][0]==undefined || result[0][0]=='-1'){
				$("#teljob").text("数据异常");
				$("#radjob").text("数据异常");
				$("#t112job").text("数据异常");
		}else{
				if($("#departname").val()=="机务室"){
					$("#jws").show();
				}else{
					$("#jws").hide();
				}
				$("#teljob").text(result[0][0]);
				$("#radjob").text(result[0][1]);
				$("#t112job").text(result[0][2]);
				$("#kjnum").text(result[0][3]);
		 	 $("#showsound").html('<EMBED id="player2" src="<%=basePath %>help/sound.WAV" hidden="false" autoplay="true"/>');
 	 		
		}
}

//用户注销
function exitLogin(){
    if (confirm('您确定要注销吗?')) {
        logInfo();
		var userid = $("#userloginid").val();
		executeNoQuery("dbsql_phone.deleteCurrentPay_userid",6,"&userid="+userid);	
		var urlstr="mainServlet.html?exitLogin=true";
		$.ajax({
			url:urlstr,
			type: 'post',
			cache:false,
			timeout: 2000,
			async: false ,//同步方式
			complete: function(){						
    			setTimeout(function(){window.location.href = "login.jsp";},0); 
			}
		});
	}
}
//记录日志信息
function logInfo(){
	executeNoQuery("login.userStatus",6,'&userid=<%=userid %>');//退出时更新用户状态
	writeLogInfo(tsd.encodeURIComponent('<fmt:message key="main.systemoper"/>'),
			'system',tsd.encodeURIComponent("<fmt:message key='main.user'/><%=userid %><fmt:message key='main.logoutsystem'/>"));
}			
//取得系统公告
function sysNotice()
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
        tsdpk : 'notices.displaynoticelist'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    var params = '';
    params += '&userarea=' + tsd.encodeURIComponent('<%=userarea%>');
    params += '&chargearea=' + tsd.encodeURIComponent('<%=chargearea %>');
    params += '&dept=' + tsd.encodeURIComponent('<%=departname %>');
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + params + '&displaylimit=5', 
        datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 2000, async : false , //同步方式
        success : function (xml)
        {
            var innerinfo = '<li><font color="#FFFFFF">&nbsp;</font></li>';
            $(xml).find('row').each(function ()
            {
                var title = $(this).attr('title');
                var nid = $(this).attr('nid');
                if (title == undefined) {
                    title = '暂无系统公告';
                    innerinfo += title;
                }else {
                    innerinfo += '<li><a href=javascript:exeServlet(' + nid + ')>' + title + '</a></li>';
                }
            });
            $('#scrollMsg').html('<ul>'+innerinfo+'</ul>');
        }
    });
}



var xmlhttp;
//如果ActiveX对象可用，则使用的肯定是IE浏览器
if (window.ActiveXObject) {
    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
}
else {
    // 使用Javascript方法处理   
    xmlhttp = new XMLHttpRequest();
}
//触发函数
function getNewJob() 
{
    xmlhttp.open("POST", "mainServlet.html?pagename=telephone/workflow/getNewJob.jsp?groupid=<%=groupid %>", false);
    xmlhttp.onreadystatechange = getJobNo;
    //回调函数 
    xmlhttp.send();
}
//获取提示工单条数
function getJobNo() 
{
    if (xmlhttp.readyState == 4) 
    {
        var response = xmlhttp.responseText;
        document.getElementById('returnvalue').value = trim(response);
        //getTelJob();//回调函数
    }
}
//显示面板信息并同步加载声音提示
function thisDisplay()
{
	$('#winpop').show();
    document.getElementById('winpop').style.height = '0px';
    setTimeout("tips_pop()", 800);
    setTimeout("tips_pop()", 10000);
    
    //添加播放文件
    $('#soundtips').html('<embed src="help/sound.WAV" autoplay="false" playcount="3" hidden="true"/>');
}


</script>
	</head>
	<body > 
		<div id="header">
			<div id="header-logo-panel">
				<div id="header-logo"></div>
			</div>
			<div id="header-info">
				<div id="header-navbar" >
					<ul>
						<li id="header-navbar-help"><a href="<%=basePath %>help/help.doc">帮助手册</a></li>
						<li id="header-navbar-login"><a href="javascript:return false;" onclick="exitLogin()"><fmt:message key="main.Off" /></a></li>
						<li id="header-navbar-exit"><a href="javascript:return false;" onclick="userLogout()"><fmt:message key="main.quit" /></a></li>
					</ul>
				</div>
				<div id="header-logininfo">
					<ul style="color: #fff;">
						<li><fmt:message key="main.welcome"/>：<%=userid %>(<%=username %>)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<%=userarea %>&nbsp;>&nbsp;<%=chargearea %>&nbsp;>&nbsp;<%=departname %></li>
					</ul>
				</div>
				<div id="theme-panel">
					<ul>
						<li id="def"><div><img src="style/images/public/spacer.gif"/></div></li>
						<li id="t1"><div><img src="style/images/public/spacer.gif"/></div></li>
						<li id="t2"><div><img src="style/images/public/spacer.gif"/></div></li>
					</ul>
				</div>
			</div>
		</div>
		<div id="content" >
			<!-- 菜单 start -->
			<div id="left-content">
				<div id="left-title">
					<span id="left-title-left"></span>
					<span id="left-title-ico"></span>
					<span id="left-title-text">菜单</span>
					<span id="left-title-right"></span>
					<span>
						<span class="tool-el-icon-mymenu left-title-thirdmenu-ico" style="width:20px;background: url('style/images/skin_0/icon/004.gif') no-repeat;width:16px;height:13px;"></span>
						<!--<a class="left-title-thirdmenu-txt" href="javascript:jumpPage('myfavorites/orderlist.jsp');" title="我的常用菜单" style="margin-left: 3px">常用菜单</a>-->
						<!--<a class="left-title-thirdmenu-txt" href="javascript:void(0);jobwindow();" title="工单信息提示窗口" style="margin-left: 3px">工单提示</a>-->
					</span>
					<span>
						<!--<span class="tool-el-icon-notice left-title-thirdmenu-ico" style="width:20px;background: url('style/images/skin_0/icon/016.gif') no-repeat;width:11px;height:14px;margin-top:10px;"></span>-->
						<a class="left-title-thirdmenu-txt" href="javascript:jumpPage('right-Download.jsp&getproc=false');" title="下载插件" style="margin-left: 3px">下载</a>
					</span>
					<span id="leftnotices" style="display: none">
						<span class="tool-el-icon-notice left-title-thirdmenu-ico" style="width:20px;background: url('style/images/skin_0/icon/003.gif') no-repeat;width:11px;height:14px;"></span>
						<a class="left-title-thirdmenu-txt" href="javascript:jumpPage('right-notices.jsp&getproc=false');" title="通知通告" style="margin-left: 3px">通告</a>
					</span>
				</div>
				<div id="menu-panel" style="scrollBar-face-color: #C5D6FC"></div>
				<div id="separator"><a id="tag-separator" href="javascript:void(0);" onclick="{var _t=document.getElementById('content');_t.className=(_t.className=='unfold'?'':'unfold');}"></a></div>
			</div>
			<!-- 菜单 end -->
			<div id="main-content">
				<iframe id="main-frame" name="main-frame" frameborder="no" border="0px" marginwidth="0" marginheight="0" scrolling="auto"></iframe>
			</div>
		</div>
		<!-- 底部  start -->
		<div id="footer">
           <div style="text-align:center;">          
	           	<div class="header-notice" id="noticelist" style="float:left;height:30px; line-height:30px;display: none">
					<table width="400px" border="0" align="center" cellpadding="0"
						cellspacing="0">
						<tr>
							<td width="20px" valign="top" align="right">
								<img src="style/images/public/tips-i.gif" width="16" height="16" />
							</td>
							<td width="64px">
								<font style="color: #ffffff">&nbsp;系统公告:</font>
							</td>
							<td width="250px">
								<div id="scrollWrap">
									<div id="scrollMsg"></div>
								</div>
							</td>
						</tr>
					</table>
				</div>
					<!-- 
						<font size="2px"><fmt:message key="main.thetitle" /></font>--<font size="2px"><fmt:message key="login.warninfo4" /></font>
			 		-->
	       </div> 
		</div>
		   
		<!-- 底部 end -->
		<input type="hidden" id="groupid" value="<%=groupid %>" />
<script type="text/javascript"> 
//显示通知通告信息的脚本，滚动显示信息
//<!-- 
try
{
    var isStoped = false;
    var oScroll = document.getElementById("scrollWrap");
    with (oScroll) {
        noWrap = true;
    }
    oScroll.onmouseover = new Function('isStoped = true');
    oScroll.onmouseout = new Function('isStoped = false');
    var preTop = 0;
    var curTop = 0;
    var stopTime = 0;
    var oScrollMsg = document.getElementById("scrollMsg");
    oScroll.appendChild(oScrollMsg.cloneNode(true));
    init_srolltext();
}
catch (e) {}
function init_srolltext()
{
    oScroll.scrollTop = 0;
    setInterval('scrollUp()', 25);
}
function scrollUp()
{
    if (isStoped) {
        return;
    }
    curTop += 1;
    if (curTop == 19) {
        stopTime += 1;
        curTop -= 1;
        if (stopTime == 180) {
            curTop = 0;
            stopTime = 0;
        }
    }else{
        preTop = oScroll.scrollTop;
        oScroll.scrollTop += 1;
        if (preTop == oScroll.scrollTop) {
            oScroll.scrollTop = 0;
            oScroll.scrollTop += 1;
        }
    }
}
//--> 
</script>
		<div id="winpop" style="display: none">
			<div class="title">
				<span id="tiptitle"></span>
				<label id="tipstemp"></label>
			</div>
			<div style="background-color: #FFFFFF">
				<div class="con" id="jobinfos" style="margin-top: 5px">
					有3条装机新工单到达，等待处理...
				</div>
			</div>
			<div id="soundtips"></div>
		</div>
		
	 <div id="jobWindow">
	  <p>
	  	<font style="font-size:16px;" id="jws">欠费开机[<span id="kjnum" style="color:red;"></span>]条！</font>
	  </p>
      <p>
        <font style="font-size:16px;">电话工单【<span id="teljob" style="color:red;"></span>】条！</font>
      </p>
      <p>
        <font style="font-size:16px;">宽带工单【<span id="radjob" style="color:red;"></span>】条！</font>
      </p>
      <p>
        <font style="font-size:16px;">故障工单【<span id="t112job" style="color:red;"></span>】条！</font>
      </p>
    </div>
    	<div id="showsound"></div>
		
				<!-- 电话停机保号到期提示 宽带到期提示 -->
		<div class="neirong" id="maturitypanel" style="display: none;z-index: 30;margin-left: 300px;width:600px;">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv_detail">到期提示</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
					<div class="midd" >
					   <form action="#" onsubmit="return false;">
							<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td height="100px" style="font-size: 14px" align="center" id="maturityinfo">
										
									</td>
								</tr>
							</table>
					 	</form>
					 </div>
			 	
					<div class="midd_butt">
						<button type="button" class="bkbutton" style="width: 80px;line-height: 20px" id="maturityclose" onclick="click()">
							确定
						</button>
					</div>
		</div>
    	<input type="hidden" id="departname" value="<%=departname %>" />
		<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
		<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
	</body>
</html>
