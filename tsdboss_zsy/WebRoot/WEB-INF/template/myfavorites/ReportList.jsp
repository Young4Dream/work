<%----------------------------------------
	name: ReportList.jsp
	author: 孙琳
	version: 1.0, 2010-11-04
	description: 报表配置信息
	modify: 
	    2010-11-18  chenze  添加pagination插件css引用
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");	
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>    
	<title><!-- 收费结帐 --><fmt:message key="Revenue.chargeCheckout" /></title>
	
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
		<!-- tab滑动门需要导入的包 *注意路径 -->
		<script src="plug-in/jquery/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>
		<!-- tab滑动门 需要导入的样式表 *注意路径-->
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css" type="text/css" media="print,projection,screen" />
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen" />
		<!-- 收费结账专用js -->
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<!-- 白色风格 -->
	<link rel="stylesheet" type="text/css" href="plug-in/pagination/pagestyle/default/css/pagination.css"/>
	
	<script language="javascript" src="plug-in/jquery/jquery.cookie-min.js"></script>
	<script language="javascript" src="plug-in/pagination/script/pagination.js"></script>
	
	<script src="script/system/ajaxfileupload.js" type="text/javascript"></script>

	
	<style>
	body,div {
		font-size:13px;
		font-family:Verdana;
		text-align:left;
	}
	
	.pgContainer {
		background-color:#F9F9F9;
		padding:10px;
		line-height:20px;
	}
	
	#pagetest5 .pgContainer {
		color:#93A5B3;
		background:url(./temp/desk.jpg);
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
	
	.tHover{cursor:pointer;text-decoration:underline;color:#ffDFCC;}
	.tOut{cursor:default;text-decoration:none;color:#000;}
	
	a:visited{text-decoration:none;color:#000;}
	a:link{text-decoration:none;color:#000;}
	a:hover{text-decoration:underline;color:#F00;}
	
	a:active{text-decoration:underline;color:#F00;}
	</style>

	<script type="text/javascript">
		/**
		 * 初始化
		 * @param 无参数
		 * @return 无返回值
		 */
		$(function(){
			initialBar();
			
			initPage();//oadReportList();
			
			$("div[cid^='list_'] li").hover(function(){
					$(this).removeClass("tOut");
					$(this).addClass("tHover");
				},
				function(){
					$(this).removeClass("tHover");
					$(this).addClass("tOut");
				}
			);
			
			$("div[cid^='list_'] li").click(function(){
				$(this).parent().parent().next().slideToggle();
				
			});
			
			$(".pgFirst,.pgLast,.pgPrev,.pgNext").click(function(){				
				$("div[cid^='list_'] li").unbind("click");
				$("div[cid^='list_'] li").click(function(){
					$(this).parent().parent().next().slideToggle();
				});
				
				$("div[cid^='list_'] li").hover(function(){
						$(this).removeClass("tOut");
						$(this).addClass("tHover");
					},
					function(){
						$(this).removeClass("tHover");
						$(this).addClass("tOut");
					}
				);
			});
		});
		/**
		 * 初始化导航栏
		 * @param 无参数
		 * @return 无返回值
		 */
		function initialBar()
		{
			$("#navBar").append(genNavv());
			
			gobackInNavbar("navBar");
			
			if($.browser.mozilla)
			{
				//alert("F");
				//$("#printReportDirect").css("visibility","hidden");
			}
		}
		/**
		 * 初始化page
		 * @param 无参数
		 * @return 无返回值
		 */
		function initPage()
		{
			var initData = [];
			var res = fetchMultiArrayValue("cReport.reportList",7,"");
			if(res[0]==undefined || res[0][0]==undefined)
			{				
				
			}
			else
			{
				for(var i=0;i<res.length;i++)
				{
					var temp = "<div cid=\"list_";					
					temp += res[i][0];
					temp += "\" style=\"border-bottom:1px dashed #CCCCCC;height:18px;\">";
					
					temp += "<div style=\"float:left;\"><li><b>";	
					temp += getCaption(res[i][1],"zh","");
					temp += "</b></li></div>";
					
					temp += "<div style=\"float:right;width:430px;\">";						
					temp += "<div style=\"width:78px;float:left;\">";
					temp += "作者：";				
					temp += res[i][4];
					temp += "</div>";
					temp += "&nbsp;&nbsp;";
					temp += "时间：";	
					temp += res[i][5];
					temp += "&nbsp;&nbsp;";
					temp += "<a href=\"javascript:void(0)\" onclick=\"downloadFile('";
					temp += res[i][2];
					temp += "')\">";
					temp += "下载此报表";
					temp += "</a>";
					temp += "&nbsp;&nbsp;";
					
					temp += "<a href=\"javascript:void(0)\" onclick=\"openUploadDialog('";
					temp += res[i][2];
					temp += "')\">";
					temp += "重新上传";
					temp += "</a>";
					temp += "</div>";
					
					temp += "</div>";
					
					temp += "<div style=\"clear:both;text-indent:2em;display:none;background-color:#FFFFFF;padding:6px;\">";
					temp += "<p><b>文件</b>：";
					temp += res[i][2];
					temp += "</p><p>";
					temp += "<b>备注</b>：";
					temp += res[i][3];
					temp += "</p></div>";
					
					temp += "<br />";
					initData.push(temp);
				}
			}
			
			//alert(initData.length); 
			
			//$("#pagetest2").pagination({totalRecord:initData.length,dataStore:initData,groupSize:5,perPage:5,barPosition:'bottom'});
			$("#pagetest2").pagination({totalRecord:initData.length,dataStore:initData});
			//$("#pagetest2").pagination({totalRecord:66,dataStore:initData,showMode:'full',barPosition:'bottom'});
		}
		
		
		/**
		 * 文件下载
		 * @param reportname(文件名称)
		 * @return 无返回值
		 */
		function downloadFile(reportname)
		{
			if($("#reportdownload").size()<1)
			{
				$("body").append("<iframe id=\"reportdownload\" width=\"0\" height=\"0\"></iframe>");
			}
			$("#reportdownload").attr("src","mainServlet.html?packgname=service&clsname=FileDownLoad&method=download&tsdfilename=WEB-INF/reportlets/com/tsdreport/" + reportname);
		}
		
		function openUploadDialog(reportname)
		{
			$("#reportname").val(reportname);
			autoBlockForm('reportFileUploadPanel',20,'reportFileUploadClose',"#FFFFFF",false);
		}
		 
		/**
		 * 文件上传处理，查询文件是否已经存在
		 * @param fn
		 * @return boolean
		 */
		function fileExisted(fn)
		{
			var res = fetchSingleValue("cReport.reportExisted",7,"&reportname="+fn);
			if(parseInt(res,10)>0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		/**
		 * 判断文件类型
		 * @param 无参数
		 * @return boolean
		 */
		function checkFile()
		{
			var fileName = $("#upfile").val();
			var pattern = /[a-zA-Z]:\\[^\:\*\?\/\|\"\<\>]+\.cpt/
			
			//           /\w:\\(\w+\\){0,}\w+\.cpt/i;
			if(!pattern.test(fileName))
			{
				alert("请选择正确的报表文件进行上传。支持文件为(*.cpt)");
				return false;
			}
			else return true;
		}
		/**
		 * 上传文件
		 * @param 无参数
		 * @return 无返回值
		 */
		function uploadFile()
		{
			if(checkFile())
			{
				var filename = $("#upfile").val();
				var indexOfX = filename.lastIndexOf("\\");
				filename = filename.substring(indexOfX + 1);
				
				if($("#reportname").val()=="" && fileExisted(filename))
				{
					alert("文件" + filename + "已经存在");
					return false;
				}
				
				var urll = 'upfiles?tsdcf=mssql&fileStartName=Report&upDirKey=cReport.upDirKey';
				if($("#reportname").val()!="")
				{
					var tmp = $("#reportname").val();
					//tmp = tmp.replace(new RegExp("\\","g"),"\\\\");
					tmp = "&ufilename=" + tmp;
					urll = urll + tmp;
				}
				
				$("#start").ajaxStart(function(){
			     //文件上传中..."
			    });
			    //2.上传
			    $.ajaxFileUpload({
				    url: urll,//servlet路径 可携带参数
				    secureuri:false,
				    fileElementId:'upfile',
				    success:function(data, status)
				    {
				     	//如果文件上传成功
				     	alert("报表文件上传成功");
				     	
				     	$("#reportFileUploadClose").click();
				    },
				    error:function(data, status, e)
				    {
				   		//文件上失败
				   		alert("文件上传失败");
				   		alert(e);
				   		alert(status);
				    }
				});
			}
	  
		}
	</script>
  </head>
  
  <body>
    <div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:		
	</div>
	
	<div style="margin-left:50px;margin-right:50px;min-width:300px;">		
		<p style="line-height:52px;font-size:16px;font-weight:700;"> 报表配置信息<span style="font-size:12px;font-weight:100;">&nbsp;&nbsp;(单击报表名称查看备注)</span></p>
		<div id="pagetest2"></div>		
	</div>
	
	
	<!-- 报表文件上传下载 -->
	<div class="neirong" id="reportFileUploadPanel" style="display:none;width:560px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						报表文件上传下载
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#reportFileUploadClose').click();">关闭</a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;width:558px;height:200px;font-size:14px;">
			
			<form action="upfile" method="post"	enctype="multipart/form-data">
				<table id="reportFileUploadTab" width="60%" border="0" bordercolor="#eeeeee" cellspacing="0" cellpadding="1" align="center" style="font-size:14px;">
					<tr>
						<td>浏览文件：</td>
						<td><input name="upfile" type="file" id="upfile" onkeydown="return false" size="30" /></td>
					</tr>
					<tr></tr>
				</table>
			</form>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="reportFileUploadUpload" onclick="uploadFile()">
				上传
			</button>
			<button type="button" class="tsdbutton" id="reportFileUploadClose">
				关闭
			</button>
		</div>
		
		<input type="hidden" name="reportname" id="reportname" />
	</div>
  </body>
</html>
