<%----------------------------------------
	name: right-notices.jsp
	author: 陈良
	version: 1.0, 2010-10-13
	description: 明细话单档案管理
	modify: 
		2010-11-29 youhongyu 添加头部注释
		2010-11-29 youhongyu 移植
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.javabean.NoticeBean"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";

	String noticeid = request.getParameter("nid");
	String thisflag = request.getParameter("thisflag");
	
	NoticeBean nb = (NoticeBean)request.getAttribute("noticeinfo");
	String ntitle = null;
	boolean isflag = false;
	if(null!=nb){
		isflag = true;
		ntitle = nb.getTitle();
	}
	
	String typename = request.getParameter("typename");
	
	String disnoticesarr = request.getParameter("disnoticesarr");
	String disno = request.getParameter("disno");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>

    <title>分页显示</title>
    
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="expires" content="0" />    

 <!-- 默认风格 -->
<link rel="stylesheet" type="text/css" href="plug-in/pagination/pagestyle/default/css/pagination.css"/> 
<!-- 黑色风格 -->
<!-- <link rel="stylesheet" type="text/css" href="./theme/black/css/pagination.css"/> -->
<!-- 白色风格 -->
<!--<link rel="stylesheet" type="text/css" href="page/pagestyle/white/css/pagination.css"/> -->	

	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="script/public/mainStyle.js" type="text/javascript"></script>	
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>	
	
	<script language="javascript" src="plug-in/pagination/script/jquery-1.2.3.pack.js"></script>
	<script language="javascript" src="plug-in/pagination/script/jquery.cookie-min.js"></script>
	<script language="javascript" src="plug-in/pagination/script/pagination.js"></script>
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />

<style>
body{
	margin-top:0px;
	margin-left:0px;
	margin-right:0px;
	font-family:verdana,Arial, Helvetica, sans-serif;
	font-size:inherit;
	text-align:left;
}

div{
	font-family:verdana,Arial, Helvetica, sans-serif;
	font-size:inherit;
	text-align:left;
} 

.pgContainer {
	background-color:#F5FCFE;
	padding:10px;
	line-height:20px;
}

#pagetest5 .pgContainer {
	color:#93A5B3;
}

hr {
	margin:10px 0 10px 0;
	border:0;
	border-top:1px dashed #CCCCCC;
	height:0;
}

h3 {
	margin:5px 0;
	font-size:14px;
}

</style>

<script language="javascript">
<!--
				/**
				 * 
				 * @param 
				 * @return 
				 */
				function _createArray(){
						var vArray = new Array();
						var groupid = '<%=session.getAttribute("groupid") %>';
						var issys = false;
						var flag = 2012;
						if(groupid.indexOf('~')!=-1){
							var grouparr = groupid.split('~');
							for(var i = 0 ;i < grouparr.length ;i++ ){
								if(grouparr[i]=='1'||grouparr[i]=='administrators'){
									issys = true;
									flag = 0;
									break;
								}
							}	
						}else{
							if(groupid=='1'||groupid=='administrators'){
								issys = true;
								flag = 0;
							}
						}
						
						var sql = 'notices.querynoticelist';
						//判断阅读权限
						if(issys==true){
							sql = 'notices.queryalllist';
							flag = 0;
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
						var username = tsd.encodeURIComponent('<%=request.getSession().getAttribute("username") %>');//姓名
						
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&userarea='+userarea+'&chargearea='+chargearea+'&dept='+dept+'&username='+username,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
									var i = 1;
									//var pushinfo = "<table><th><td>ID</td><td>标题</td><td>发布时间</td><td>新闻类型</td></th>";
									//vArray.push('<table style="text-align:center;"><tr><th width="25px" bgcolor="#CCCCCC">ID</th><th width="500px" bgcolor="#CCCCCC">标题</th><th width="120px" bgcolor="#CCCCCC">发布时间</th><th width="80px" bgcolor="#CCCCCC">新闻类型</th></tr></table>');
									$(xml).find('row').each(function(){
									 	//数据显示格式：1.标题 推荐图标 时间 类型
									 	var nid = $(this).attr("nid");
									 	var title = $(this).attr("title");
									 	if(title.length>23){
									 		title = title.substring(0,23) + '...';
									 	}
									 	var uptime = $(this).attr("uptime");
									 	var type = $(this).attr("type");
									 	var news = $(this).attr("news");
										var info = '<table><tr>';
										info += '<td width="25px" style="font-size: 14px">' + i + '</td>' ;
										info +=  '<td width="430px" id="distd"><a href="javascript:displayNoticeInfo('+nid+')" style="font-size: 14px"><image src="style/images/public/ltubiao_03.gif" alt="查看详细信息"/>&nbsp;' + title + '</a>';
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
										info += temps;
										info += '</td>';
										info += '<td width="150px" style="text-align:center;font-size:14px">' + type + '</td>';
										info += '<td width="120px">' + uptime + '</td>';
										info += '</tr></table>';
									 	vArray.push(info);
									 	i++;
									});
							}
						});
						//获取记录条数
						var counts = getCounts(userarea,chargearea,dept,flag);
						$('#counts').val(counts);
					return vArray;
				}
		
		/**
		 * 比较时间
		 * @param 
		 * @return 
		 */
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
		
		/**
		 * 查看类型公告
		 * @param 
		 * @return 
		 */	
		function typeNoticeArray(typename){
				var vArray = new Array();
						var groupid = '<%=session.getAttribute("groupid") %>';
						var issys = false;
						var flag = 2012;
						if(groupid.indexOf('~')!=-1){
							var grouparr = groupid.split('~');
							for(var i = 0 ;i < grouparr.length ;i++ ){
								if(grouparr[i]=='1'||grouparr[i]=='administrators'){
									issys = true;
									flag = 0;
									break;
								}
							}	
						}else{
							if(groupid=='1'||groupid=='administrators'){
								issys = true;
								flag = 0;
							}
						}
						
						var sql = 'notices.querynoticelistlimittypes';
						//判断阅读权限
						if(issys==true){
							sql = 'notices.queryalllistlimittypes';
							flag = 0;
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
						
						var type = tsd.encodeURIComponent(typename);//部门
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&userarea='+userarea+'&chargearea='+chargearea+'&dept='+dept+'&typename='+type+'&username='+username,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
									var i = 1;
									//var pushinfo = "<table><th><td>ID</td><td>标题</td><td>发布时间</td><td>新闻类型</td></th>";
									//vArray.push('<table style="text-align:center;"><tr><th width="25px" bgcolor="#CCCCCC">ID</th><th width="500px" bgcolor="#CCCCCC">标题</th><th width="120px" bgcolor="#CCCCCC">发布时间</th><th width="80px" bgcolor="#CCCCCC">新闻类型</th></tr></table>');
									$(xml).find('row').each(function(){
									 	//数据显示格式：1.标题 推荐图标 时间 类型
									 	var nid = $(this).attr("nid");
									 	var title = $(this).attr("title");
									 	if(title.length>23){
									 		title = title.substring(0,23) + '...';
									 	}
									 	var uptime = $(this).attr("uptime");
									 	var type = $(this).attr("type");
									 	var news = $(this).attr("news");
										var info = '<table><tr>';
										info += '<td width="25px" style="font-size: 14px">' + i + '</td>' ;
										info +=  '<td width="430px" id="distd"><a href="javascript:displayNoticeInfo('+nid+')" style="font-size: 14px"><image src="style/images/public/ltubiao_03.gif" alt="查看详细信息"/>&nbsp;' + title + '</a>';
										if(news==1){
											info += '<img src="style/images/public/news.gif" style="margin-left:5px"/>';
										} 	
										info += '</td>';
										info += '<td width="150px" style="text-align:center;font-size:14px">' + type + '</td>';
										info += '<td width="120px">' + uptime + '</td>';
										info += '</tr></table>';
									 	vArray.push(info);
									 	i++;
									});
							}
						});
						//获取记录条数
						var counts = getTypeCounts(userarea,chargearea,dept,flag,type);
						
						$('#counts').val(counts);
					return vArray;
		}	
				/**
				 * 初始化加载
				 * @param 
				 * @return 
				 */	
				$(document).ready(
					function(){		
						//$("#navBar1").append(genNavv());
						var thisflag = '<%=thisflag %>';
						if(thisflag=='true'){
							var thisnid = '<%=noticeid %>';	
							$('#listtitle').hide();
							$('#noticeinfo').show();
							$('#noticelist').hide();
							//updateHots(thisnid);//更新点击次数
							getNoticeInfo(thisnid,true);//显示详细公告信息
						}else{
							var isdis = '<%=ntitle %>';
							if(isdis!='null'){
								getNoticeInfo('123',false)
							}else{
								noticesListDisplay();//显示通知通告列表信息
							}
						}
						//完全模式
					}
				)
				//-->
			
				/**
				 * 点击显示阅读信息
				 * @param 
				 * @return 
				 */	
				function displayNoticeInfo(nid){
					updateHots(nid);//更新阅读日志
					$('#noticeid').val(nid);
					$('#noticeflag').val(true);
					$('#willsubmit').click();
				}
				
				
				
				/**
				 * 将修改后的信息保存起来
				 * @param 
				 * @return 
				 */	
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
							success:function(msg){
								if(msg=="true"){
									readNoticeLog(thisnid);
									getNoticeInfo(thisnid,true);//显示详细公告信息
								}	
							}
						});
				}
				
				
				/**
				 * 显示公告详细信息
				 * @param 
				 * @return 
				 */	
				function getNoticeInfo(thisnid,flag){
					//var urlstr=tsd.buildParams({ 	
					//				 		 	packgname:'service',//java包
					//							clsname:'ExecuteSql',//类名
					//							method:'exeSqlData',//方法名
					//							ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
					//							tsdcf:'mssql',//指向配置文件名称
					//							tsdoper:'query',//操作类型 
					//							datatype:'xmlattr',//返回数据格式 
					//							tsdpk:'notices.getnoticeinfo'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
					//						});
					//$.ajax({
					//		url:'mainServlet.html?'+urlstr+'&nid='+thisnid,
					//		datatype:'xml',
					//		cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					//		timeout: 1000,
					//		async: false ,//同步方式
					//		success:function(xml){
					//			$(xml).find('row').each(function(){
					//				var title = $(this).attr('title');
					//				var type = $(this).attr('type');
					//				var memo = $(this).attr('memo');
					//				var upman = $(this).attr('upman');
					//				var uptime = $(this).attr('uptime');
					//				var hots = $(this).attr('hots');
									<% 
										if(isflag==true){
									%>
										var isflag = '<%=isflag %>';
										if(isflag=='true'){
											if(flag==false){
												$('#noticelist').hide();
												$('#noticeinfo').show();
												$('#listtitle').hide();
											}
										}
									<%	
										}
									%>
								//});
							//}
					//});
				}
				
				
				/**
				 * 记录阅读日志
				 * @param 
				 * @return 
				 */	
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
				
				
				/**
				 * 显示公告详细信息
				 * @param 
				 * @return 
				 */
				function getCounts(userarea,chargearea,dept,flag){
					var counts = 0;
					var sql = 'notices.querylimitpage';
					if(flag==0){
						sql = 'notices.querypages';
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
					var username = tsd.encodeURIComponent('<%=request.getSession().getAttribute("username") %>');//部门
						
					$.ajax({
							url:'mainServlet.html?'+urlstr+'&userarea='+userarea+'&chargearea='+chargearea+'&dept='+dept+'&username='+username,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								$(xml).find('row').each(function(){
									counts = $(this).attr('counts');
								});
							}
					});
					return counts;
				}
				
				
				
				/**
				 * 显示公告详细信息
				 * @param 
				 * @return 
				 */
				function getTypeCounts(userarea,chargearea,dept,flag,typename){
					var counts = 0;
					var sql = 'notices.querylimitpagetypename';
					if(flag==0){
						sql = 'notices.querypagestypename';
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
					var username = tsd.encodeURIComponent('<%=request.getSession().getAttribute("username") %>');//部门
						
					$.ajax({
							url:'mainServlet.html?'+urlstr+'&userarea='+userarea+'&chargearea='+chargearea+'&dept='+dept+'&typename='+typename+'&username',
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								$(xml).find('row').each(function(){
									counts = $(this).attr('counts');
								});
							}
					});
					return counts;
				}
				
				
				/**
				 * 赋值操作
				 * @param 
				 * @return 
				 */
				function inthistype(){
					$('#sysintype').val('sys');
				}
				
				
				/**
				 * 页面跳转
				 * @param 
				 * @return 
				 */
				function noticesListDisplay(){ 
					var disno = '<%=disno %>';
					if('sys'==$('#sysintype').val()){
						var initData = _createArray();
						var num = $('#counts').val();
						$("#noticelist").pagination({totalRecord:num,dataStore:initData,showMode:'full',barPosition:'bottom'});
					}else if(disno!='null'){
						var initData = disReadinfo('<%=disnoticesarr %>');
						$("#noticelist").pagination({totalRecord:disno,dataStore:initData,showMode:'full',barPosition:'bottom'});
					}else{
						var initDatas = typeNoticeArray('<%=typename %>');
						var num = $('#counts').val();
						$("#noticelist").pagination({totalRecord:num,dataStore:initDatas,showMode:'full',barPosition:'bottom'});
					}
					$('#noticelist').show();//显示列表
					$('#noticeinfo').hide();//隐藏信息
					$('#listtitle').show();//隐藏标题
				}	
				
			
			/**
			 * 查看未阅读通知通告
			 * @param 
			 * @return 
			 */
			function disReadinfo(disdata){
				var vArray = new Array();
						var urlstr=tsd.buildParams({ 	
					 		 						packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mssql',//指向配置文件名称
								 					tsdoper:'query',//操作类型 
								 					datatype:'xmlattr',//返回数据格式 
								 					tsdpk:'main.disnoticesunread'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
						$.ajax({
							url:'mainServlet.html?ids='+disdata+urlstr,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 3000,
							async: false ,//同步方式
							success:function(xml){
									var i = 1;
									//var pushinfo = "<table><th><td>ID</td><td>标题</td><td>发布时间</td><td>新闻类型</td></th>";
									//vArray.push('<table style="text-align:center;"><tr><th width="25px" bgcolor="#CCCCCC">ID</th><th width="500px" bgcolor="#CCCCCC">标题</th><th width="120px" bgcolor="#CCCCCC">发布时间</th><th width="80px" bgcolor="#CCCCCC">新闻类型</th></tr></table>');
									$(xml).find('row').each(function(){
									 	//数据显示格式：1.标题 推荐图标 时间 类型
									 	var nid = $(this).attr("nid");
									 	var title = $(this).attr("title");
									 	if(title.length>23){
									 		title = title.substring(0,23) + '...';
									 	}
									 	var uptime = $(this).attr("uptime");
									 	var type = $(this).attr("type");
									 	var news = $(this).attr("news");
										var info = '<table><tr>';
										info += '<td width="25px" style="font-size: 14px">' + i + '</td>' ;
										info +=  '<td width="430px" id="distd"><a href="javascript:displayNoticeInfo('+nid+')" style="font-size: 14px"><image src="style/images/public/ltubiao_03.gif" alt="查看详细信息"/>&nbsp;' + title + '</a>';
										if(news==1){
											info += '<img src="style/images/public/news.gif" style="margin-left:5px"/>';
										} 	
										info += '</td>';
										info += '<td width="150px" style="text-align:center;font-size:14px">' + type + '</td>';
										info += '<td width="120px">' + uptime + '</td>';
										info += '</tr></table>';
									 	vArray.push(info);
									 	i++;
									});
							}
						});
					return vArray;
		}	
				
</script>

<style type="text/css">
	#navBar{ font-family:verdana,Arial, Helvetica, sans-serif;float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
	a:link,a:visited,a:active  { font-size:12px;color: #000000;	text-decoration: none;}
	a:hover {font-size:12px;text-decoration: none;color: red;}
</style>

</head>
<body>
<!-- 用户操作导航-->

				
		<div id="navBar">
			<table width="100%" border="0" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar1" style="float: left;font-size: 12px;">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
							您当前所在的位置是
							:
							通知通告信息 >>> 详细信息列表
						</div>
					</td>
					<td width="20%" align="right" valign="top">
						<div id="d2back" style="text-align: right;">
							<a href="javascript:void(0);"
								onclick="parent.history.back(); return false;">
								<fmt:message key="gjh.houtuei" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</a>
						</div>
					</td>
				</tr>
			</table>
		</div>
	
	<center>	
		
		<div style="width:750px;">	
			<span style="line-height: 60px"><img src="style/images/public/gbo.jpg" alt="通知通告" align="middle" /><b style="font-size: 14px">通知通告信息</b></span>
			<!-- 显示通知通告信息列表 -->
			<!-- 
			<div class="pgContainer" style="width:750px;font-size: 14px;"></div>
			 -->
			<!-- 显示标题 -->
			<div id="listtitle" style="background-color: #F5FCFE;width:750px;padding:0px;line-height:20px;display: none">
				<table style="text-align:center;" align="center"><tr><th width="25px" bgcolor="#CCCCCC" style="font-size: 14px">ID</th><th width="430px" bgcolor="#CCCCCC" style="font-size: 14px">标题</th><th width="145px" bgcolor="#CCCCCC" style="font-size: 14px">公告类型</th><th width="120px" bgcolor="#CCCCCC" style="font-size: 14px">发布时间</th></tr></table>
			</div>
			<!-- 显示通知通告详细信息 -->
			<div class="pgContainer" id="noticeinfo" style="width:750px;font-size: 14px;display: none">
				<%
					if(isflag==true){
				%>
					<center><b><%=nb.getTitle() %></b></center>
					<hr />
					<%=nb.getMemo()%>
					<hr/>
					
					<table align="center" cellpadding="5px" >
						<tr>
							<td>发布：<%=nb.getUpman() %></td>
							<td>时间：<%=nb.getUptime() %></td>
							<td>阅读：<%=nb.getHots() %>次</td>
							<td><a href="javascript:inthistype();noticesListDisplay()">更多>></a></td>
						</tr>
					</table>	
				<%
					}
				 %>
			</div>
			<!-- 显示通告列表信息 -->
			<div id="noticelist"></div>
		</div>
	</center>
	
	<input type="hidden" id="counts"/>
	
	<input type="hidden" id="sysintype" value="<%=typename %>"/>
	
	
	<div style="display: none">
		<form action="notices" name="operforms" method="post" id="operform">
			<input type='hidden' name="noticeflag" id="noticeflag"/>
			<input type='hidden' name="nid" id="noticeid"/>
			<input type="submit" id="willsubmit"/>
		</form>			
	</div>
	
</body>
</html>