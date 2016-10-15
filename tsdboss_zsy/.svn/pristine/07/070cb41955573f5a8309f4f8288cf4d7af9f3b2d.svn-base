<%----------------------------------------
	name: StaffBlog.jsp
	author: wenxuming
	version: 1.0, 2010-03-21
	description: 工日志的管理填写
	modify: 
		2010-12-13 fck图片上传不了问题更正
---------------------------------------------%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/fck" prefix="FCK"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
	String area = (String) session.getAttribute("chargearea");
	String depart = (String) session.getAttribute("departname");
	String userareaid = (String) session.getAttribute("userarea");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
	
	String languageType = (String) session.getAttribute("languageType");
	/////////////////Java取当前时间
	SimpleDateFormat format = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	Date now = new Date();
	String nowTime = format.format(now);
	String initValue = "2999-01-01 00:00:00";
	//boolean b = ((Boolean)session.getAttribute("b")).booleanValue();
	String b = (String)request.getAttribute("b");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>My JSP 'StaffBlog.jsp' starting page</title>
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
		<!-- 时间选择器需要导入的js文件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
		
		<style type="text/css">
#input-Unit .title {
	width: 100%;
	height: 32px;
	background: url(image/kuangbg.jpg);
	border-bottom: 1px solid #C8D8E5;
	text-align: left;
	color: #3C3C3C;
}
</style>
		<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
		<link rel="stylesheet" href="common.css" type="text/css"
			media="screen" />
		<script type="text/javascript" src="xheditor-0.9.9/xheditor-zh-cn.js"></script>
		<style type="text/css">
		<!-- 时间选择器需要导入的js文件 -->
		
		#navBar1 {
			height: 26px;
			background: url(style/images/public/daohangbg.jpg);
			line-height: 28px;
		}
		
		#navBar1 .navBar {
			
		}
		
		#navBar1 .d2back {
			float: right
		}
		cas {
			float: left;
			width: 100%;
			height: 26px;
			background: url(style/imagse/public/daohangbg.jpg) repeat-x;
			line-height: 28px;
		}
		body {text-align: left}
		</style>
		<script type="text/javascript">
		/**
		 * 初始化
		 * @param 无参数
		 * @return 无返回值
		 */
       $(function(){
			var disinfos = '<%=pmenuname %>' + ' >>> ' + '<%=imenuname %>';
			
            $("#navBar").append(disinfos);
            
            $("#addlogtable").hide();
            $("#dtitle").hide();
            $("#buttons").hide();
            $("#logtitle").hide();//初始化时隐藏标题查询框
            var userid = $("#userid").val();	
            $("#save_update").hide();//初始化时隐藏修改保存按钮		
            
            var disuserid = '<%=session.getAttribute("userid") %>';
            var str = '';
            if(disuserid=='admin'){
            	str = 'admin';
            }
            
			var urlstr=tsd.buildParams({ packgname:'service',//java包
								clsname:'ExecuteSql',//类名
								method:'exeSqlData',//方法名
								ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
								tsdcf:'mssql',//指向配置文件名称
								tsdoper:'query',//操作类型 
								datatype:'xml',//返回数据格式 
								tsdpk:'staffblog.query'+str,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								tsdpkpagesql:'staffblog.queryPage'+str//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
							});
				
				jQuery("#loggrid").jqGrid({
					url:'mainServlet.html?' + urlstr+'&userid='+userid, 
					datatype: 'xml', 
					colNames:['查看|修改|删除','id','员工工号', '日志标题', '发布时间'],
					colModel:[{name:'viewOperation',index:'viewOperation', width:100},
					        {name:'id',index:'id', width:50,hidden:true}, 
					        {name:'userid',index:'userid', width:100}, 
					       	{name:'logname',index:'logname', width:110}, 
					       	{name:'logtime',index:'logtime', width:110},				       
					       	],
					       	rowNum:10, 
					       	rowList:[10,20,30], 
					       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
					       	pager: jQuery('#logpager'), 
					       	sortname:'logtime', 
					       	viewrecords: true, 
					       	sortorder: 'desc', 
					       	caption:"员工日志表", 
					       //	height:220,
					    	width:760,
					       	loadComplete:function(){
					        	addRowOperBtn('loggrid','<img src="style/images/public/ltubiao_03.gif" alt="编辑"/>','querylog','id','click',1);
					        	addRowOperBtn('loggrid','<img src="style/images/public/ltubiao_01.gif" alt="修改"/>','updatequerylog','id','click',2);
					        	addRowOperBtn('loggrid','<img src="style/images/public/ltubiao_02.gif" alt="删除"/>','deletelog','id','click',3);	
					        	executeAddBtnWithoutAddCell('loggrid',3);		
					        }, 
					        
					        ondblClickRow: function(ids) {
								if(ids != null) {
									var id =$("#loggrid").getCell(ids,"id");
									querylog(id);
								}
							}
					       
					}).navGrid('#logpager', {edit: false, add: false, add: false, del: false, search: false}, //options 
						{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
						{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
						{reloadAfterSubmit:false}, // del options 
						{} // search options 
						); 												
			
			//服务端（servlet）返回的结果进行判断提示					
			var b = $("#b").val();
				if(b!="null"){
				if(b=="YES"){
				   alert("操作成功！");
				   $("#b").val("");
				}else if(b=="NO"){
				   alert("操作失败！");
				   $("#b").val("");
				}				
			}		 
        });
        /**
		 * 查询员工日志结果集
		 * @param 无参数
		 * @return 无返回值
		 */
        function querylogall(){
          var userid = $("#userid").val();					
			var urlstr=tsd.buildParams({ packgname:'service',//java包
								clsname:'ExecuteSql',//类名
								method:'exeSqlData',//方法名
								ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
								tsdcf:'mssql',//指向配置文件名称
								tsdoper:'query',//操作类型 
								datatype:'xml',//返回数据格式 
								tsdpk:'staffblog.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								tsdpkpagesql:'staffblog.queryPage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
							});
			$("#loggrid").setGridParam({url:'mainServlet.html?'+urlstr+'&userid='+userid}).trigger("reloadGrid");			 								
        }
        
        /**
		 * 查看日志信息
		 * @param id(唯一标识)
		 * @return 无返回值
		 */
        function querylog(id){ 
            var userid;
            var logcontent;
            var logname; 
            var logtime;          
            var urlstr=tsd.buildParams({ packgname:'service',//java包
						 				 clsname:'ExecuteSql',//类名
						 				 method:'exeSqlData',//方法名
						 				 ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 				 tsdcf:'mssql',//指向配置文件名称
						 				 tsdoper:'query',//操作类型 
						 				 datatype:'xmlattr',
						 				 tsdpk:'stafblog.idquerry'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});		 								
			$.ajax({
					url:'mainServlet.html?'+urlstr+"&id="+id,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
					  $("#useridcx").empty();
					  $("#lognamecx").empty();
					  $("#addlogcontent").empty();
					  $("#logtimecx").empty();
					  $(xml).find('row').each(function(){
					      userid = $(this).attr("userid");					      
					      $("#useridcx").val(userid);
					      logname = $(this).attr("logname");
					      $("#lognamecx").val(logname);
					      logtime = $(this).attr("logtime");
					      $("#logtimecx").val(logtime);
					      logcontent = $(this).attr("logcontent");					      
					      $("#logcontentcx").val(logcontent);					      
					  });
					  $("#useridcx").append(userid);
					  $("#lognamecx").append(logname);
					  $("#addlogcontent").append(logcontent);
					  $("#logtimecx").append(logtime);
					}
				  });	
		   autoBlockForm('queryHTH',5,'close',"#ffffff",false);//弹出查询框		  
        }
        
        /**
		 * 查询要修改的日志信息
		 * @param id(唯一标识)
		 * @return 无返回值
		 */
        function updatequerylog(id){
            var userid;
            var logcontent;
            var logname; 
            var logtime;          
            var urlstr=tsd.buildParams({ packgname:'service',//java包
						 				 clsname:'ExecuteSql',//类名
						 				 method:'exeSqlData',//方法名
						 				 ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 				 tsdcf:'mssql',//指向配置文件名称
						 				 tsdoper:'query',//操作类型 
						 				 datatype:'xmlattr',
						 				 tsdpk:'stafblog.idquerry'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});		 								
			$.ajax({
					url:'mainServlet.html?'+urlstr+"&id="+id,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
					  $("#useridcx").empty();
					  $("#lognamecx").empty();
					  $("#addlogcontent").empty();
					  $("#logtimecx").empty();
					  $(xml).find('row').each(function(){
					      userid = $(this).attr("userid");					      
					      logname = $(this).attr("logname");
					      $("#titlename1").val(logname);
					      logtime = $(this).attr("logtime");
					      logcontent = $(this).attr("logcontent");					     
					      SetEditorContents(logcontent);
					      $("#updateid").val(id);//将id加入到隐藏域中			      
					  });
					 }
				  });
			//显示内容区域	  
			$("#logcontent1").val("");
            $("#addlogtable").show();
            $("#dtitle").show();
            $("#buttons").show();
            $("#buttons").focus();
			$("#save_update").show();//显示修改保存按钮
			$("#save_save").hide();//隐藏添加保存按钮
        }
        
        /**
		 * 执行修改日志信息操作
		 * @param 无参数
		 * @return 无返回值
		 */
        function updatelog(){
            getFckValue();
            var titlename1 = $("#titlename1").val();
            titlename1 = titlename1.replace(/(^\s*)|(\s*$)/g,'');
            var logcontent1 = $("#logcontent1").val();
            var imenuid = $("#imenuid").val();
            var pmenuname = $("#pmenuname").val();
            var imenuname = $("#imenuname").val();
            var zid = $("#zid").val();
            $("#imenuidto").val(imenuid);
            $("#pmenunameto").val(pmenuname);
            $("#imenunameto").val(imenuname);
            $("#zidto").val(zid);
            var logcententto = toTxt(logcontent1);            
            $("#logtype").val("2");//为2时为修改保存类型            
            if(titlename1.length==0){
             alert("日志标题不能为空！");
             $("#titlename1").focus();
             return false;
            }
            if(logcententto.length==0){
             alert("日志内容不能为空！");
             $("#logcontent1").focus();
             return false;
            }
            $("#logcontentto1").val(logcententto);
            var logcontentto1 = $("#logcontentto1").val();
            if(confirm("确定修改该日志吗?")){
            //提交from表单到servlet            
            document.addlogxx.action="adduserlog";
            document.addlogxx.submit();
            $("#logtype").val("");//提交后清空类型
            $("#updateid").val("");
            }
        }
        
        /**
		 * 删除日志
		 * @param id(唯一标识)
		 * @return 无返回值
		 */
        function deletelog(id){
            var urlstr=tsd.buildParams({ packgname:'service',
						 				 clsname:'ExecuteSql',
						 				 method:'exeSqlData',
						 				 ds:'tsdBilling',
						 				 tsdcf:'mssql',
						 				 tsdoper:'exe',
						 				 tsdpk:'deletelog.delete'
						 				});		
				 if(confirm("确定删除该日志吗?")){				 
					$.ajax({
							url:'mainServlet.html?'+urlstr+'&id='+id,
							type: 'post',//'GET'--将缓存数据,
							cache:false,
							timeout: 1000,
							async: false ,//同步方式
							success: function(msg){
								if(msg=="true"){									
									alert("删除成功！");
									var querylogselect = $("#querylogselect").val();
									if(querylogselect=="1"){
										  var logStarttime = $("#logStarttime").val();
										  var logStoptime = $("#logStoptime").val();
										  if(logStarttime.length!=0&&logStoptime.length!=0){
										    querytimelog();
										  }else{
										    querylogall();										    
										  }									 
									}else if(querylogselect=="2"){
									      var logtitleinfo = $("#logtitleinfo").val();
									      if(logtitleinfo.length!=0){
									         querytitlelog();
									      }else{
									         querylogall();
									      }									  
									}									
								}
							}
						});
				}			
        }               
        /**
		 * 验证填写信息
		 * @param 无参数
		 * @return 无返回值
		 */
        function logcontentzhuanhuan(){            
            getFckValue();
            var titlename1 = $("#titlename1").val();
            titlename1 = titlename1.replace(/(^\s*)|(\s*$)/g,'');
            var logcontent1 = $("#logcontent1").val();
            var userid = $("#userid").val();
            var imenuid = $("#imenuid").val();
            var pmenuname = $("#pmenuname").val();
            var imenuname = $("#imenuname").val();
            var zid = $("#zid").val();
            $("#imenuidto").val(imenuid);
            $("#pmenunameto").val(pmenuname);
            $("#imenunameto").val(imenuname);
            $("#zidto").val(zid);
            $("#useridaddlog").val(userid);
            var logcententto = toTxt(logcontent1);
            $("#logtype").val("1");//为1时为添加保存类型
            
            if(titlename1.length==0){
             alert("请填写日志标题！");
             $("#titlename1").focus();
             return false;
            }
            if(logcententto.length==0){
             alert("日志内容不能为空！");
             $("#logcontent1").focus();
             return false;
            }
            $("#logcontentto1").val(logcententto);
            var logcontentto1 = $("#logcontentto1").val();
            if(confirm("确定添加该日志吗?")){
            //提交from表单到servlet            
            document.addlogxx.action="adduserlog";
            document.addlogxx.submit();
            $("#logtype").val("");//提交后清空类型
            }
        }
        
        /**
		 * 特殊符号替换
		 * @param str(需要替换的字符)
		 * @return String
		 */
        function toTxt(str)
        {    
	    var RexStr = /\<|\>|\"|\'|\&/g  
	    str = str.replace(RexStr,    
        function(MatchStr){    
            switch(MatchStr){    
                case "<":    
                    return "&lt;";    
                    break;    
                case ">":    
                    return "&gt;";    
                    break;    
                case "\"":    
                    return "&quot;";    
                    break;    
                case "'":    
                    return "&#39;";   
                    break;    
                case "&":    
                    return "&amp;";    
                    break;    
                default :    
                    break;    
                   }    
		        }    
		    )    
		    return str;    
		}            
        /**
		 * 初始化面板
		 * @param 无参数
		 * @return 无返回值
		 */
        function tcmb()
        {
           SetEditorContents('');
           $("#logcontent1").empty();
		   $("#logcontent1").val("");
           $("#addlogtable").show();
           $("#titlename1").val("");
           $("#dtitle").show();
           $("#buttons").show();
           $("#buttons").focus(); 
           $("#save_update").hide();//隐藏修改保存按钮
		   $("#save_save").show();//显示添加保存按钮
        }
        /**
		 * 关闭面板
		 * @param 无参数
		 * @return 无返回值
		 */
        function closelog()
        {
           $("#sub11").bind("click",function(event){		         
		         event.preventDefault();  //阻止默认行为				 
		   });
		    setTimeout($.unblockUI,15);
        }
        /**
		 * 取消按钮
		 * @param 无参数
		 * @return 无返回值
		 */
        function quxiao()
        {
           SetEditorContents('');
            $("#logcontent1").empty();
		    $("#logcontent1").val("");
			$("#addlogtable").hide();
			$("#logcontentto1").val("");
			$("#dtitle").hide();
			$("#buttons").hide();
			$("#loggrid").focus();						            
			$("#titlename1").val("");
			var querylogselect = $("#querylogselect").val();
				if(querylogselect=="1"){
					//querytimelog();
				}else if(querylogselect=="2"){
					querytitlelog();
				}
        }
        
        /**
		 * 更新时间查询日志
		 * @param 无参数
		 * @return 无返回值
		 */
        function querytimelog()
        {
            var logStarttime = $("#logStarttime").val();
            var logStoptime = $("#logStoptime").val();
            
            if(logStarttime==''){
            	alert('请输入查询日志起始时间!');
            	$('#logStarttime').focus();
            	return false;
            }
            
            if(logStoptime==''){
            	alert('请输入查询日志结束时间!');
            	$('#logStoptime').focus();
            	return false;
            }
            
            var userid = $("#userid").val();
            var str = '';
            if(userid=='admin'){
            	str = userid;
            }
            var urlstr=tsd.buildParams({packgname:'service',//java包
										clsname:'ExecuteSql',//类名
										method:'exeSqlData',//方法名
										ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdcf:'mssql',//指向配置文件名称
										tsdoper:'query',//操作类型
										datatype:'xml',//返回数据格式
										tsdpk:'stafblog.logtimequery'+str,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										tsdpkpagesql:'stafblog.logtimequerypage'+str//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
							});
			$("#loggrid").setGridParam({url:'mainServlet.html?'+urlstr+"&logtimeto="+logStarttime+"&logtime="+logStoptime+"&userid="+userid}).trigger("reloadGrid");			 				
         }
        
        /**
		 * 更新标题查询日志
		 * @param 无参数
		 * @return 无返回值(操作成功)/false(验证不通过)
		 */
        function querytitlelog()
        {
            var userid = $("#userid").val();
            var logtitleinfo = $("#logtitleinfo").val();
            if(logtitleinfo==''){
            	alert('请输入查询日志标题!');
            	$('#logtitleinfo').focus();
            	return false;
            }
            
            logtitleinfo = logtitleinfo.replace(/(^\s*)|(\s*$)/g,'');
            var urlstr=tsd.buildParams({ packgname:'service',//java包
								clsname:'ExecuteSql',//类名
								method:'exeSqlData',//方法名
								ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
								tsdcf:'mssql',//指向配置文件名称
								tsdoper:'query',//操作类型
								datatype:'xml',//返回数据格式
								tsdpk:'stafblog.logtitlequery',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								tsdpkpagesql:'stafblog.logtitlequerypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
							});
			$("#loggrid").setGridParam({url:'mainServlet.html?'+urlstr+"&userid="+userid+"&logname="+tsd.encodeURIComponent(logtitleinfo)}).trigger("reloadGrid");			 				
        }
        
        /**
		 * 重置
		 * @param 无参数
		 * @return 无返回值
		 */
        function resettimelog()
        {
           $("#logStarttime").val("");
           $("#logStoptime").val("");
           $("#logtitleinfo").val("");
        }
        /**
		 * 获取FCK中数据
		 * @param 无参数
		 * @return 无返回值
		 */
        function getFckValue()
        {
			var editor = FCKeditorAPI.GetInstance("EditorAccessibility");
 			//alert(editor.EditorDocument.body.innerHTML);
			//document.getElementById("news_content").value = editor.EditorDocument.body.innerHTML;
			$('#logcontent1').val(editor.EditorDocument.body.innerHTML);
		}
        
        /**
		 * 设置编辑器中内容
		 * @param str(向编译器中放入的字符串)
		 * @return 无返回值
		 */
		function SetEditorContents(str)
		{ 
		     var oEditor = FCKeditorAPI.GetInstance("EditorAccessibility") ; 
			 oEditor.SetHTML(str) ; 
		}    
		 
		/**
		 * 查询方式改变后将清空原来的 
		 * @param 无参数
		 * @return 无返回值
		 */
        function closequery(){
            var querylogselect = $("#querylogselect").val();
            if(querylogselect=="1"){
               $("#logtitle").hide();//隐藏标题查询框
               $("#logtime").show();//显示时间查询框
               $("#logStarttime").select();
               $("#logStarttime").focus();               
            }else if(querylogselect=="2"){
               $("#logtitle").show();//显示标题查询框
               $("#logtime").hide();//隐藏时间查询框
               $("#logtitleinfo").select();
               $("#logtitleinfo").focus();
            }
            $("#logStarttime").val("");
            $("#logStoptime").val("");
            $("#logtitleinfo").val("");
            querylogall();
        } 
        
        var TextUtil = new Object(); 
            TextUtil.NotMax = function(oTextArea){ 
                var maxText = oTextArea.getAttribute("maxlength"); 
                if(oTextArea.value.length > maxText){ 
                        oTextArea.value = oTextArea.value.substring(0,maxText); 
                        alert("超出限制"); 
                } 
        }        
        
        /**
		 * 标题查询的时候回车事件
		 * @param event
		 * @return boolean
		 */
        function lastKey(event){
                    if(event.keyCode==13){
                        querytitlelog();
                        return false;
                    }
        }
    </script>
    <style type="text/css">
    	hr {margin:2px 0 2px 0;border:0;border-top:1px dashed #CCCCCC;height:0;}
    </style>
	</head>
	<body>
		<div id="navBar1">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
							<fmt:message key="global.location" />:
						</div>
					</td>
					<td width="20%" align="right" valign="middle">
						<div id="d2back">
							<a href="javascript:void(0);"
								onclick="parent.history.back(); return false;"><fmt:message key="gjh.houtuei"/></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div id="input-Unit">
			<div class="title">
				&nbsp;&nbsp;
				<img src="style/icon/65.gif"/>
				员工日志信息
			</div>
			<div id="inputtext">
				<table cellspacing="10px" border="0">				   
				    <tr>				      
				       <td>查询条件：</td>
					    <td>
					       <select id="querylogselect" onchange="closequery()">
					          <option value="1">日志时间</option>
					          <option value="2">日志标题</option>
					       </select>
					    </td>
					   <td>
				         <button class="tsdbutton" style="margin-bottom: 10px" id="addlog" onclick="tcmb()">
							新增日志
						</button>
				       </td>
				    </tr>
				</table>    
				
				<table cellspacing="10px" id="logtime">    
				
					<tr>					    
						<td>
							起始时间：
						</td>
						<td>
							<input type="text" name="logStarttime" id="logStarttime"
								style="width: 160px" class="required date"
								onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>
						</td>
						<td>
							结束时间：
						</td>
						<td>
							<input type="text" name="logStoptime" id="logStoptime"
								style="width: 160px" class="required date"
								onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" value="<%=nowTime %>"/>
						</td>
						<td>
							<button class="tsdbutton" id="likelog" style="margin-bottom: 10px" onclick="querytimelog()">
								<!-- 查询 --><fmt:message key="global.query"/>
							</button>
							<button class="tsdbutton" id="reset" style="margin-bottom: 10px" onclick="resettimelog()">
								<!-- 重置 --><fmt:message key="tariff.reset"/>
							</button>
						</td>
					</tr>
				</table>
				<hr/>
				<table cellspacing="10px" id="logtitle">
				   <tr>
				     <td>日志标题：</td>
				     <td>
				       <input type="text" name="logtitleinfo" id="logtitleinfo" style="width:200" onkeydown="return lastKey(event)"/>
				     </td>
				     <td>
						<button class="tsdbutton" id="likelog" style="margin-bottom: 10px" onclick="querytitlelog()">
							<!-- 查询 --><fmt:message key="global.query"/>
						</button>
					</td>
					<td>	
						<button class="tsdbutton" id="reset" style="margin-bottom: 10px" onclick="resettimelog()">
							<!-- 重置 --><fmt:message key="tariff.reset"/>
						</button>
					</td>
				   </tr>				 
				</table>   
			</div>
			
			<table id="loggrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="logpager" class="scroll" style="text-align: left"></div>				
					
			<form action="adduserlog" name="addlogxx" id="addlogxx"
				 onsubmit="return true;" method="post">
				<div class="title" id='dtitle'>
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					添加日志:
				</div>	
				<table cellspacing="10px" id="addlogtable">
					<tr>
						<td>
							标题：<input type="text" name="titlename1" id="titlename1" style="width: 150px"  onpropertychange="TextUtil.NotMax(this)" maxlength="20"/>
						</td>
					</tr>
					<tr>
						<td>
							日志内容：
						</td>
					</tr>
					<tr>
					    <td>
					    <!-- 
					    <textarea id="logcontent1" name="logcontent1" class="xheditor"
						rows="12" cols="40" style="width: 100%">
	         	       </textarea> -->
	         	       <FCK:editor id="EditorAccessibility" width="700" height="250"
											fontNames="宋体;黑体;隶书;楷体_GB2312;Arial;Comic Sans MS;Courier New;Tahoma;Times New Roman;Verdana"
											imageBrowserURL="${pageContext.request.contextPath}/plug-in/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector"
											linkBrowserURL="${pageContext.request.contextPath}/plug-in/FCKeditor/editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector"
											flashBrowserURL="${pageContext.request.contextPath}/plug-in/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Flash&Connector=connectors/jsp/connector"
											imageUploadURL="${pageContext.request.contextPath}/plug-in/FCKeditor/editor/filemanager/upload/simpleuploader?Type=Image"
											linkUploadURL="${pageContext.request.contextPath}/plug-in/FCKeditor/editor/filemanager/upload/simpleuploader?Type=File"
											flashUploadURL="${pageContext.request.contextPath}/plug-in/FCKeditor/editor/filemanager/upload/simpleuploader?Type=Flash">
					  </FCK:editor>
						<input type="hidden" name="logcontent1" id="logcontent1"/>				
						<input type="hidden" name="useridaddlog" id="useridaddlog"/>									
						<textarea rows="0" cols="0" style="visibility:hidden" id="logcontentto1" name="logcontentto1"></textarea>						 
						<input type="hidden" name="imenuidto" id="imenuidto"/>
						<input type="hidden" name="pmenunameto" id="pmenunameto"/>
						<input type="hidden" name="imenunameto" id="imenunameto"/>
						<input type="hidden" name="zidto" id="zidto"/>
						<input type="hidden" name="updateid" id="updateid"/>
						<!-- 定义servlet中处理的请求，1代表添加保存、2代表修改保存 -->
						<input type="hidden" name="logtype" id="logtype"/>										
					    </td>
					</tr>					    
				</table>				
				<div id="buttons">
			         <center>
			            <button class="tsdbutton" style="margin-bottom: 10px" id="save_save" onclick="logcontentzhuanhuan()">
							<!-- 保存 --><fmt:message key="global.save"/>
						</button>
						<button class="tsdbutton" style="margin-bottom: 10px" id="save_update" onclick="updatelog()">
							<!-- 保存 --><fmt:message key="global.save"/>
						</button>
						<button class="tsdbutton" style="margin-bottom: 10px" id="close" onclick="quxiao()">
							<!-- 取消 --><fmt:message key="Revenue.Cancel"/>
						</button>
					</center>
			  </div>			  		         	    
			</form>	
			<!-- 日志查询信息 -->
		    <div class="neirong" id="queryHTH" style="display: none;width:728px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif"/>
						</div>
						<div class="top_03" id="titlediv">
							日志查询信息
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif"/>
						</div>
					</div>
					<div class="top_01right">
						<a href="#" id="sub11" onclick="closelog()"><fmt:message key="global.close" /><!-- 关闭 --></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;text-align:left;">
			<div id="inputtext">						   					
						<table cellspacing="10px">
							<tr>
								<td>
									工号：<span id="useridcx" style=""></span>
								</td>
							</tr>
							<tr>
								<td>
									标题：<span id="lognamecx" style=""></span>
								</td>
							</tr>
							<tr>
								<td>
									日志内容：
								</td>
							</tr>
							<tr>
								<td>
									<span id="addlogcontent" style=""></span>
								</td>
							</tr>
							<tr>
								<td>发布时间：<span id="logtimecx" style=""></span>
								</td>
							</tr>
						</table>									
				     <div id="buttons">
				   <center>
					<button id="reset" onclick="closelog()" style="margin-left: 20px;">
						<fmt:message key="global.close" />
						<!-- 关闭 -->
					</button>
				  </center>	
				</div>
			  </div>	 
			</div>
		</div>
		<input type="hidden" id="userid" value="<%=userid%>" />
		<input type="hidden" id="area" value="<%=area%>" />
		<input type="hidden" id="depart" value="<%=depart%>" />
		<input type="hidden" id="imenuid" value="<%=imenuid%>"/>
		<input type="hidden" id="pmenuname" value="<%=pmenuname%>"/>
		<input type="hidden" id="imenuname" value="<%=imenuname%>"/>
		<input type="hidden" id="zid" value="<%=zid%>"/>
		<input type="hidden" id="userareaid" value="<%=userareaid%>" />						
		<input type="hidden" id="languageType" value="<%=languageType%>" />
		<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>'/>
		<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
		<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />	
		<input type='hidden' id="b" value="<%=b %>"/>
		</div>						
	</body>
</html>
