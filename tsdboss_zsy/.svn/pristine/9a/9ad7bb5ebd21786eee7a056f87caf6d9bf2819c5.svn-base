<%----------------------------------------
	name: orderlist.jsp
	author: chenliang
	version: 1.0, 2010-05-14
	description: 显示用户的自定义菜单
	modify: 
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.io.File"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/big/";
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
	<title>OrderList</title>
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="script/public/mainStyle.js" type="text/javascript"></script>
<style type="text/css">
	#discenter a{
		color:blue;
		text-decoration:none;
	}
	#discenter a:hover{
		color:red;
	}
	.astyle a{
		color:#000000;
		text-decoration:none;
	}
	.astyle a:hover{
		color:#ff9900;
	}
	body{
		font-family:Arial,宋体;
		font-size:14px;
	}
</style>
<script type="text/javascript">
/**
 * 显示初始化数据
 * @param 无参数
 * @return 无返回值
 */
jQuery(document).ready(function () { 
	$('#disorder').hide();	
	disOrderMenu();
});
/**
 * 显示用户自定义菜单
 * @param 无参数
 * @return 无返回值
 */
function disOrderMenu(){
	var urlstr=tsd.buildParams({ 	
									packgname:'service',//java包
				 					clsname:'ExecuteSql',//类名
				 					method:'exeSqlData',//方法名
				 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
				 					tsdcf:'mssql',//指向配置文件名称
				 					tsdoper:'query',//操作类型 
				 					datatype:'xmlattr',//返回数据格式 
				 					tsdpk:'orderlist.querymymenu'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
				 				});
	var userid = '<%=session.getAttribute("userid") %>';	
	var groupid = '<%=session.getAttribute("groupid") %>';	
	
	//在存储过程中要传的参数
	$.ajax({
			url:'mainServlet.html?userid='+userid+urlstr,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				var disinfos = '';
				$(xml).find('row').each(function(){
					var imenuname=$(this).attr("imenuname"); 
					if(imenuname!=undefined){
						var imenuicon=$(this).attr("imenuicon"); 
						var imenuurl=$(this).attr("imenuurl"); 
						var imenuid=$(this).attr("imenuid"); 
						var pmenuname=$(this).attr("ipmenuname"); 
						var disurl = imenuurl+'&imenuid='+imenuid+'&pmenuname='+pmenuname+'&imenuname='+imenuname+'&groupid='+groupid;
						//disinfos +="<span style='width:200px'><img src='<%=basePath%>style/icon/big/"+imenuicon+"' alt='"+imenuname+"'/></span><span style='width:200px'><a href='javascript:jumpPage("+imenuurl+");'>"+imenuname+"</a></span>";
						disinfos +="<span style='float:left;text-align:center'><table width='200px' align='center' border=0><tr><td><a hidefocus='true' href=javascript:jumpPage('"+disurl+"'); ><img src='<%=basePath%>style/icon/big/"+imenuicon+"' border=0 alt='"+imenuname+"'/></a></td></tr><tr><td class='astyle'><a hidefocus='true' href=javascript:jumpPage('"+disurl+"'); >"+imenuname+"</td></tr></table></span>";
					}
				});
				if(disinfos==''){
					$('#disorder').show();
				}else{
					$('#dismymenulist').html(disinfos);
					$('#dismymenulist').show();	
				}
			}
	});
}	

/**
 * 页面跳转
 * @param pagename(页面名称)
 * @return 无返回值
 */
function jumpPage(pagename){ 
	window.location.href='mainServlet.html?pagename='+pagename+'&tsdtemp='+Math.random();
}

/**
 * 配置自定义显示菜单
 * @param 无参数
 * @return 无返回值
 */
function disIni(){
	jumpPage('myfavorites/ordermenu.jsp&imenuid=3003&pmenuname=我的工号&imenuname=我的菜单&groupid=<%=session.getAttribute("groupid") %>');
}

</script>
  </head>
  
  <body>
  		<div id="dismymenulist" style="width: 100%;" ></div>
  		
  		<table id='disorder' style="background-position: right;background-repeat: no-repeat;background-image: url('style/images/public/ordertips.jpg');font-weight: bold;display: none" border=0 align='center' width='208px' height='240px'>
  			<tr>
  				<td height="40px">
  					<p style='margin-left: 88px;margin-top: 25px'>对不起，您尚未</p>
  				</td>
  			</tr>
  			<tr>
  				<td height="40px">
  					<p style='margin-left:60px;margin-top: 5px'>配置自定义显示</p>
  				</td>
  			</tr>
  			<tr>
  				<td height="30px">
  					<table border="0">
  						<tr>
  							<td width="104px"><p style='margin-left:55px'>菜单.</p></td>
  							<td width="104px" align="right">
  								<a href="javascript:disIni()"><img src="style/images/public/go.gif" border=0 style="margin-right: 5px;margin-bottom: 2px" alt="配置自定义显示菜单"/></a>
  							</td>
  						</tr>
  					</table>
  				</td>
  			</tr>
  			<tr>
  				<td height="100px">
					<p style="margin-right: 10px"><img src="style/images/public/notorder.gif" alt="忙碌中..."/></p>
				</td>
  			</tr>
  		</table>
  </body>
</html>
