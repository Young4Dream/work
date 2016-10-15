<%----------------------------------------
	name: right-notices.jsp
	author: 陈良
	version: 1.0, 2010-10-13
	description: 
	modify: 
		2010-11-29 youhongyu 添加头部注释
---------------------------------------------%>

<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <head>
    
    <title>通知通告</title>
    
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="expires" content="0" />    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
	<meta http-equiv="description" content="This is my page" />
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="script/public/mainStyle.js" type="text/javascript"></script>
	<script src="script/public/printnews.js" type="text/javascript"></script>
	
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		.thisli{list-style-type:none;list-style-image:url(style/images/public/arrow.jpg);width:75%};
		.thisli li{border-bottom:1px dashed #ccc;line-height:15px};
		body,label,td{
			font-family:verdana,Arial, Helvetica, sans-serif;
			font-size:14px;
			text-align:left;
			text-overflow:ellipsis;
		}
		a{ color:#000000;text-decoration: none; } 
		a:hover { color: #F60; }
		#displaytopinfo a{color:red;text-decoration: none;}
		#displaytopinfo a:hover{color:blue;}
		hr {
			margin:1px 0 1px 0;
			border:0;
			border-top:1px dashed #CCCCCC;
			height:0;
		}
	</style>
	
	
	<style type="text/css">
<!--
/*通用*/

*{padding:0px;margin:0px;}
* li{list-style:none;}

.clearfix:after {
    content: "\0020";
    display: block;
    height: 0;
    clear: both;
}
.clearfix {
    _zoom: 1;
}
*+html .clearfix {
	overflow:auto;
}

.menu_navcc{width:920px; margin:0 auto;}
.menu_nav{width:920px;height:48px;background:url(style/images/public/nav_bg.gif) repeat-x;float:left;margin-top:18px;}
.menu_nav .nav_content{padding-left:25px;background:url(style/images/public/nav_l_bg.gif) no-repeat;float:left;}
.menu_nav .nav_content li{width:95px;height:48px;padding-left:15px;padding-right:13px;background:url(style/images/public/nav_li_right.gif) no-repeat right center;float:left;line-height:48px;text-align:center;font-size:14px;font-weight:bold;}
.menu_nav .nav_content li a{color:#fff;width:95px;height:48px;display:block;}
.menu_nav .nav_content li.current{line-height:37px;}
.menu_nav .nav_content li em{background:url(style/images/public/bid_new.gif) no-repeat;width:35px;height:21px;display:inline-block;position:absolute;top:-20px;left:40px;}

.menu_nav .nav_content li.current a,.menu_nav .nav_content li a:hover{width:95px;height:37px;background:url(style/images/public/nav_li_current.gif) no-repeat;display:block;color:#fff;}
.menu_nav .nav_content li a:hover{background:url(style/images/public/nav_li_hover.gif) no-repeat;line-height:37px;text-decoration:none;}

.menu_nav_right{padding-right:20px;background:url(style/images/public/nav_r_bg.gif) no-repeat right top;float:right;margin-left:50px;padding-top:13px;height:23px;padding-bottom:12px;}
p{
margin-bottom:15px}
-->
</style>
	
	
	
	<script type="text/javascript">
		$(document).ready(
		//先将所有系统营业区域取出
			function(){
				topInfo();//置顶信息
				tips();//提示个人工号信息
				noticeType();
				newNotices();
				
				$("#typelist a").live("click",function(){
					$("#typelist li").removeClass("current");
					$(this).closest("li").addClass("current");
				});
			}
		);		
		
		//系统最新的通知通告信息
		function newNotices(){
			var groupid = '<%=session.getAttribute("groupid") %>';
						var issys = false;
						if(groupid.indexOf('~')!=-1){
							var grouparr = groupid.split('~');
							for(var i = 0 ;i < grouparr.length ;i++ ){
								if(grouparr[i]=='1'||grouparr[i]=='administrators'){
									issys = true;
									break;
								}
							}	
						}else{
							if(groupid=='1'||groupid=='administrators'){
								issys = true;
							}
						}
						
						var sql = 'notices.querynoticelistlimit';
						//判断阅读权限
						if(issys==true){
							sql = 'notices.queryalllistlimit';
						}
												
						var urlstr=tsd.buildParams({ 	
					 		 						packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mssql',//指向配置文件名称
								 					tsdoper:'query',//操作类型 
								 					datatype:'xmlattr',//返回数据格式 
								 					tsdpk:sql//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
						var userarea = tsd.encodeURIComponent('<%=request.getSession().getAttribute("userarea") %>');//用户区域，大区域
						var chargearea = tsd.encodeURIComponent('<%=request.getSession().getAttribute("chargearea") %>');//营业区域
						var dept = tsd.encodeURIComponent('<%=request.getSession().getAttribute("departname") %>');//部门
						var username = tsd.encodeURIComponent('<%=request.getSession().getAttribute("username") %>');//部门
						
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&userarea='+userarea+'&chargearea='+chargearea+'&dept='+dept+'&username='+username,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 5000,
							async: true ,//同步方式
							success:function(xml){
									//var i = 1;
									//var pushinfo = "<table><th><td>ID</td><td>标题</td><td>发布时间</td><td>新闻类型</td></th>";
									//vArray.push('<table style="text-align:center;"><tr><th width="25px" bgcolor="#CCCCCC">ID</th><th width="500px" bgcolor="#CCCCCC">标题</th><th width="120px" bgcolor="#CCCCCC">发布时间</th><th width="80px" bgcolor="#CCCCCC">新闻类型</th></tr></table>');
									var noticeinfo = '';
									$(xml).find('row').each(function(){
									 	//数据显示格式：1.标题 推荐图标 时间 类型
									 	var nid = $(this).attr("nid");
									 	if(nid!=undefined){
									 		var title = $(this).attr("title");
									 		if(title.length>20){
									 			title = title.substring(0,20) + '...';
									 		}
										 	var uptime = $(this).attr("uptime");
										 	uptime = uptime.substring(0,10);
										 	var upman = $(this).attr("upman");
										 	var news = $(this).attr("news");
											var type = $(this).attr("type");
											
											var info = '<table style="margin-left:20px;" cellpadding="0" cellspacing="0"><tr>';
											//info += '<td>' + i + '</td>' ;
											var temps = '';
											var isshow = compareDate(uptime);
											if(news==1){
												var imgname = 'news';
												if(isshow==true){
													imgname = 'news-ian';
												}
												temps = '<img src="style/images/public/'+imgname+'.gif" style="margin-left:5px"/>';
											}else{
												if(isshow==true){
													temps = '<img src="style/images/public/news-ian.gif" style="margin-left:5px"/>';
												}
											}
											info +=  '<td width="360px"><a href="javascript:isThisDump('+nid+',false);"><image src="style/images/public/arrow.jpg" alt="查看详细信息"/>&nbsp;' + title + '&nbsp;' + temps + '</a></td>';
											info += '<td width="120px" style="text-align:center;">' + type + '</td>';
											uptimes = uptime.substring(0,10);
											info += '<td width="90px">' + uptimes + '</td>';
											info += '<td width="70px" style="text-align:center;">&nbsp;' + upman +'</td>';
											info += '</tr><tr><td colspan="4"><hr/></td></tr><table></div>';
										 	//i++;
										 	noticeinfo += info;
										 	$('#lookimg').show();
									 	}else{
									 		noticeinfo += '<center>对不起，暂无系统公告显示...</center>';
									 		$('#lookimg').hide();
									 	}
									});
									//var thisdisplaytitle = '<table style="margin-left:20px;text-align:center;" cellpadding="0" cellspacing="3px"><tr><th width="360px" height="25px" style="font-size:14px"  bgcolor="#CCCCCC">公告标题</th><th width="120px" height="25px" style="font-size:14px"  bgcolor="#CCCCCC">公告类型</th><th width="90px" style="font-size:14px" bgcolor="#CCCCCC">上传时间</th><th width="70px" style="font-size:14px" bgcolor="#CCCCCC">发布人</th></tr></table>';
									$('#isdisplay').html('<hr/>'+noticeinfo);
							}
						});
		
		}
		
		//比较时间
		function compareDate(edate){
			var today =  '<%=Log.getThisTime() %>';
			today = today.substring(0,10);
			var startDate = new Date(today.replace("-",",")).getTime() ;
			var endDate = new Date(edate.replace("-",",")).getTime() ;
			
			if( startDate > endDate ) 
			{  
			   return false;
			}
			return true;
    	}
		//跳转信息
		function isThisDump(nid,flag){
			var param = "rights.jsp&thisflag=true&nid="+nid;
			updateHots(nid);
			readNoticeLog(nid);
			if(flag==true){
				updateIsRead(nid);//更新阅读状态
			}
			$('#thisflag').val('true');
			$('#nid').val(nid);
			$('#willsubmit').click();
		}	
		//将修改后的信息保存起来
		function updateIsRead(thisnid){
					
			var urlstr=tsd.buildParams({ 	packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mssql',//指向配置文件名称
								 					tsdoper:'exe',//操作类型 
								 					tsdpk:'notices.updatehasread'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
			$.ajax({
							url:'mainServlet.html?'+urlstr+'&nid='+thisnid,
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(msg){
							}
			});
		}
		
		//将修改后的信息保存起来
		  function updateHots(thisnid){
					 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mssql',//指向配置文件名称
								 					tsdoper:'exe',//操作类型 
								 					tsdpk:'notices.updatehots'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&nid='+thisnid,
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(msg){}
						});
			}
		
		//记录阅读日志
		function readNoticeLog(nid){
					
					var urlstr=tsd.buildParams({ 	
								 		 						packgname:'service',//java包
											 					clsname:'ExecuteSql',//类名
											 					method:'exeSqlData',//方法名
											 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
											 					tsdcf:'mssql',//指向配置文件名称
											 					tsdoper:'exe',//操作类型 
											 					tsdpk:'notices.readnotcielog'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
					var username = tsd.encodeURIComponent('<%=session.getAttribute("username") %>');
					var loginip = '<%=Log.getIpAddr(request) %>';
					$.ajax({
							url:'mainServlet.html?'+urlstr+'&nid='+nid+'&username='+username+'&loginip='+loginip,                    
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 3000,
							async: true ,//同步方式
							success:function(msg){}
					});
					
			}
		
		//页面跳转
		function thisJump(){
			var params = $('#thistypename').val();
			var pagename = 'rights.jsp&typename='+params; 
			window.location.href = 'mainServlet.html?pagename='+pagename;
		}
		
		function thesys(){
			$('#thistypename').val('sys');
		}
		//置顶信息
		function topInfo(){
			var groupid = '<%=session.getAttribute("groupid") %>';
						var issys = false;
						if(groupid.indexOf('~')!=-1){
							var grouparr = groupid.split('~');
							for(var i = 0 ;i < grouparr.length ;i++ ){
								if(grouparr[i]=='1'||grouparr[i]=='administrators'){
									issys = true;
									break;
								}
							}	
						}else{
							if(groupid=='1'||groupid=='administrators'){
								issys = true;
							}
						}
						
						var sql = 'notices.querytopinfo';
						//判断阅读权限
						if(issys==true){
							sql = 'notices.querytopinfos';
						}
												
						var urlstr=tsd.buildParams({ 	
					 		 						packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mssql',//指向配置文件名称
								 					tsdoper:'query',//操作类型 
								 					datatype:'xmlattr',//返回数据格式 
								 					tsdpk:sql//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
						var userarea = tsd.encodeURIComponent('<%=request.getSession().getAttribute("userarea") %>');//用户区域，大区域
						var chargearea = tsd.encodeURIComponent('<%=request.getSession().getAttribute("chargearea") %>');//营业区域
						var dept = tsd.encodeURIComponent('<%=request.getSession().getAttribute("departname") %>');//部门
						var username = tsd.encodeURIComponent('<%=request.getSession().getAttribute("username") %>');//部门
						
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&userarea='+userarea+'&chargearea='+chargearea+'&dept='+dept+'&username='+username,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 5000,
							async: true ,//同步方式
							success:function(xml){
									//var i = 1;
									//var pushinfo = "<table><th><td>ID</td><td>标题</td><td>发布时间</td><td>新闻类型</td></th>";
									//vArray.push('<table style="text-align:center;"><tr><th width="25px" bgcolor="#CCCCCC">ID</th><th width="500px" bgcolor="#CCCCCC">标题</th><th width="120px" bgcolor="#CCCCCC">发布时间</th><th width="80px" bgcolor="#CCCCCC">新闻类型</th></tr></table>');
									var noticeinfo = '';
									$(xml).find('row').each(function(){
									 	//数据显示格式：1.标题 推荐图标 时间 类型
									 	var nid = $(this).attr("nid");
									 	if(nid!=undefined){
										 	var title = $(this).attr("title");
										 	if(title.length>30){
									 			title = title.substring(0,30) + '...';
									 		}
										 	noticeinfo = '<a href="javascript:isThisDump('+nid+',false);">' + title + '</a>';
										}
									});
									$('#displaytopinfo').html(noticeinfo);
							}
						});
		}
		
		//显示个人工号提示信息
		function tips(){
				var urlstr=tsd.buildParams({ 	
					 		 					packgname:'service',//java包
								 				clsname:'ExecuteSql',//类名
								 				method:'exeSqlData',//方法名
								 				ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 				tsdcf:'mssql',//指向配置文件名称
								 				tsdoper:'query',//操作类型 
								 				datatype:'xmlattr',//返回数据格式 
								 				tsdpk:'notices.queryusertips'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 			});
				var username = tsd.encodeURIComponent('<%=session.getAttribute("username") %>');
				$.ajax({
							url:'mainServlet.html?'+urlstr+'&username='+username,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 5000,
							async: true ,//同步方式
							success:function(xml){
									$(xml).find('row').each(function(){
									 	//数据显示格式：1.标题 推荐图标 时间 类型
									 	var nid = $(this).attr("nid");
									 	if(nid!=undefined){
										 	var title = $(this).attr("title");
										 	$('#distitle').val(title);
											$('#disid').val(nid);
											shownew();
										}
									});
							}
				});
		
		}
		
		var NewsTime = 5000; //每条新闻的停留时间
		var TextTime = 100;  //新闻标题文字出现等待时间，越小越快
		
		var newsi = 0;
		var txti = 0;
		var txttimer;
		var newstimer;
		//显示打字效果
		function shownew(){
		 	$('#disusernews').show();
		 	var newstitle = new Array(); //新闻标题
		 	var newshref = new Array();  //新闻链接
		 	var username = '<%=session.getAttribute("username") %>';
		 	newstitle[0] = username + '：系统管理员给您发了一条消息，' + $('#distitle').val();
		 	newshref[0] = $('#disid').val();
		
		 	var endstr = '_'
		 	hwnewstr = newstitle[newsi];
		 	newslink = newshref[newsi];
		 	if(txti==(hwnewstr.length-1)){endstr='';}
		 	if(txti>=hwnewstr.length){
		  		clearInterval(txttimer);
		  		clearInterval(newstimer);
		  		newsi++;
		  		if(newsi>=newstitle.length){
		   			newsi = 0
		  		}
		  		newstimer = setInterval('shownew()',NewsTime);
		  		txti = 0;
		  		return;
		 	}
			clearInterval(txttimer);
			document.getElementById('HotNews').href='javascript:isThisDump('+newslink+',true)';
			document.getElementById('HotNews').innerHTML = hwnewstr.substring(0,txti+1)+endstr;
			 
		 	txti++;
		 	txttimer = setInterval('shownew()',TextTime);
		}	
		
		//显示通知通告类型列表
		function noticeType(){
			var urlstr=tsd.buildParams({ 	
					 		 					packgname:'service',//java包
								 				clsname:'ExecuteSql',//类名
								 				method:'exeSqlData',//方法名
								 				ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 				tsdcf:'mssql',//指向配置文件名称
								 				tsdoper:'query',//操作类型 
								 				datatype:'xmlattr',//返回数据格式 
								 				tsdpk:'notices.querynoticetypes'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							 			});
			$.ajax({
							url:'mainServlet.html?'+urlstr,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 5000,
							async: true ,//同步方式
							success:function(xml){
									var noticelist = '<ul class="nav_content"><li class="current"><a href="javascript:;" onclick="thesys();newNotices()" title="系统公告" hidefocus="true"><span>最新公告</span></a></li>';
									$(xml).find('row').each(function(){
									 	 var typename = $(this).attr("typename");
										 noticelist += '<li><a href="javascript:typeNoticeList(\''+typename+'\')" title="'+typename+'" hidefocus="true"><span>'+typename+'</span></a></li>';							 	 
									});
									$('#typelist').html(noticelist+'</ul>');
							}
			});
		}
		
		//查看类型公告
		function typeNoticeList(typename){
			$('#thistypename').val(typename);
			var groupid = '<%=session.getAttribute("groupid") %>';
						var issys = false;
						if(groupid.indexOf('~')!=-1){
							var grouparr = groupid.split('~');
							for(var i = 0 ;i < grouparr.length ;i++ ){
								if(grouparr[i]=='1'||grouparr[i]=='administrators'){
									issys = true;
									break;
								}
							}	
						}else{
							if(groupid=='1'||groupid=='administrators'){
								issys = true;
							}
						}
						
						var sql = 'notices.querynoticelistlimittype';
						//判断阅读权限
						if(issys==true){
							sql = 'notices.queryalllistlimittype';
						}
												
						var urlstr=tsd.buildParams({ 	
					 		 						packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mssql',//指向配置文件名称
								 					tsdoper:'query',//操作类型 
								 					datatype:'xmlattr',//返回数据格式 
								 					tsdpk:sql//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
						var userarea = tsd.encodeURIComponent('<%=request.getSession().getAttribute("userarea") %>');//用户区域，大区域
						var chargearea = tsd.encodeURIComponent('<%=request.getSession().getAttribute("chargearea") %>');//营业区域
						var dept = tsd.encodeURIComponent('<%=request.getSession().getAttribute("departname") %>');//部门
						var username = tsd.encodeURIComponent('<%=request.getSession().getAttribute("username") %>');//部门
						var type = tsd.encodeURIComponent(typename);//公告类型
						
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&userarea='+userarea+'&chargearea='+chargearea+'&dept='+dept+'&typename='+type+'&username='+username,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 5000,
							async: true ,//同步方式
							success:function(xml){
									//var i = 1;
									//var pushinfo = "<table><th><td>ID</td><td>标题</td><td>发布时间</td><td>新闻类型</td></th>";
									//vArray.push('<table style="text-align:center;"><tr><th width="25px" bgcolor="#CCCCCC">ID</th><th width="500px" bgcolor="#CCCCCC">标题</th><th width="120px" bgcolor="#CCCCCC">发布时间</th><th width="80px" bgcolor="#CCCCCC">新闻类型</th></tr></table>');
									var noticeinfo = '';
									$(xml).find('row').each(function(){
									 	//数据显示格式：1.标题 推荐图标 时间 类型
									 	var nid = $(this).attr("nid");
									 	if(nid!=undefined){
									 		var title = $(this).attr("title");
									 		if(title.length>20){
									 			title = title.substring(0,20) + '...';
									 		}
										 	var uptime = $(this).attr("uptime");
										 	var upman = $(this).attr("upman");
										 	var news = $(this).attr("news");
											var type = $(this).attr("type");
											
											var info = '<table style="margin-left:20px;" cellpadding="0" cellspacing="0"><tr>';
											//info += '<td>' + i + '</td>' ;
											var temps = '';
											var isshow = compareDate(uptime);
											if(news==1){
												var imgname = 'news';
												if(isshow==true){
													imgname = 'news-ian';
												}
												temps = '<img src="style/images/public/'+imgname+'.gif" style="margin-left:5px"/>';
											}else{
												if(isshow==true){
													temps = '<img src="style/images/public/news-ian.gif" style="margin-left:5px"/>';
												}
											}
											info +=  '<td width="360px"><a href="javascript:isThisDump('+nid+',false);"><image src="style/images/public/arrow.jpg" alt="查看详细信息"/>&nbsp;' + title + '&nbsp;' + temps + '</a></td>';
											info += '<td width="120px" style="text-align:center;">' + type + '</td>';
											uptimes = uptime.substring(0,10);
											info += '<td width="90px">' + uptimes + '</td>';
											info += '<td width="70px" style="text-align:center;">&nbsp;' + upman +'</td>';
											info += '</tr><tr><td colspan="4"><hr/></td></tr><table></div>';
										 	//i++;
										 	noticeinfo += info;
										 	$('#lookimg').show();
									 	}else{
									 		noticeinfo += '<center>对不起，暂无该类型的通知通告...</center>';
									 		$('#lookimg').hide();
									 	}
									});
									//var thisdisplaytitle = '<table style="margin-left:20px;text-align:center;" cellpadding="0" cellspacing="3px"><tr><th width="360px" height="25px" style="font-size:14px"  bgcolor="#CCCCCC">公告标题</th><th width="120px" height="25px" style="font-size:14px"  bgcolor="#CCCCCC">公告类型</th><th width="90px" style="font-size:14px" bgcolor="#CCCCCC">上传时间</th><th width="70px" style="font-size:14px" bgcolor="#CCCCCC">发布人</th></tr></table>';
									$('#isdisplay').html('<hr/>'+noticeinfo);
							}
						});
		
		}
		
		
		
	</script>
	
  </head>
  
  <body>
  					<table align="center">
			  			<tr>
			  				<td>
								<div class="menu_navcc">
									<div class="menu_nav clearfix" style="overflow: hidden">
										<div id="typelist" >
											
										</div>
										<div class="menu_nav_right"></div>
									</div>
								</div>
							</td>
						<tr>
						<tr>
  							<td>
  								
	
	  							<center>
    							<fieldset style="width: 670px;margin-left: 20px;text-align:left;height: auto">
									<legend>
										<img src="style/images/public/tips.gif" width="60px" height="60px" border="0" />
									</legend>	
									<div id="disusernews" style="display: none">
										<hr />
										<center><a id='HotNews' href='' style="color:blue" target='_self'></a></center>
										<hr />
									</div>
									<label style="margin-left: 45px"><b>通知通告</b>:</label>
									<label>&nbsp;&nbsp;<span id="displaytopinfo"></span></label>
									<hr />
									
									<table>
										<tr>
											<td>
												<table style="margin-left:20px;text-align:center;" cellpadding="0" cellspacing="3px"><tr><th width="360px" height="25px" style="font-size:14px"  bgcolor="#CCCCCC">公告标题</th><th width="120px" height="25px" style="font-size:14px"  bgcolor="#CCCCCC">公告类型</th><th width="90px" style="font-size:14px" bgcolor="#CCCCCC">上传时间</th><th width="70px" style="font-size:14px" bgcolor="#CCCCCC">发布人</th></tr></table>
												<div id="isdisplay"></div>
											</td>
										</tr>
										<tr>
											<td>
												<div style="margin-top: 0px">
													<table style="margin-left: 25px">
														<tr>
															<td width="580px" id="distd">
																&nbsp;
															</td>
															<td id="lookimg">
																<img src="style/images/public/arrow_more.gif" alt="查看更多" />&nbsp;<a href="javascript:thisJump()">更多</a>
															</td>
														</tr>
													</table>
													<br />
												</div>
											</td>
										</tr>
									</table>
								</fieldset>
							</center>
						</td>
					</tr>
  			</table>
							
				<input type="hidden" id="distitle"/>
				<input type="hidden" id="disid"/>
				<input type="hidden" id="thistypename" value="sys"/>
				
		   		<div style="display: none">
					 <form action="notices" name="operform" method="post" id="operform">
						<input type='hidden' name="thisflag" id="thisflag"/>
						<input type='hidden' name="nid" id="nid"/>
						<input type="submit" id="willsubmit"/>
					 </form>			
				</div>
  </body>
</html>