<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	
	String userid = (String) session.getAttribute("userid");
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>telReprint</title>
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
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservice.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservicenew.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/public.js" type=text/javascript language="javascript"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->	
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
		<link href="style/css/telephone/charge/charge_phone.css" rel="stylesheet" type="text/css" />		
		<script language="javascript" type="text/javascript">
		//页面初始化
		$(function(){
			//页面所在位置
			$("#navBar").append(genNavv());
			$("#d_hthnum").select().focus();
			loadJqgrid('0');
		});
		function loadJqgrid(key){
			$("#hth_bmsave").attr("disabled","disabled");
			$("#newhthbm").attr("disabled","disabled");	
			$("#newbm").val("");
			$("#hthhidden").val("");	
			$("#bm1hidden").val("");
			var d_hthnum = $("#d_hthnum").val().replace(/(^\s*)|(\s*$)/g,"");
			if(d_hthnum==""&&key=='1'){
				alert("大客户号不能为空！");
				$("#d_hthnum").select().focus();
				return;
			}
			$("#jqgrid").empty();
			var jqgrid ="<table id='editgrid' class='scroll' cellpadding='0' cellspacing='0'></table>";
		    	jqgrid +="<div id='pagered' class='scroll' style='text-align: left;'></div>";
		    $("#jqgrid").html(jqgrid);	
			var urlstr=tsd.buildParams({ 	  
										packgname:'service',//java包
										clsname:'ExecuteSql',//类名
										method:'exeSqlData',//方法名
										ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdcf:'mssql',//指向配置文件名称
										tsdoper:'query',//操作类型 
										datatype:'xml',//返回数据格式 
										tsdpk:'PhoneModifyHthBm.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										tsdpkpagesql:'PhoneModifyHthBm.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
			});
			jQuery("#editgrid").jqGrid({
						url:'mainServlet.html?'+urlstr+'&hth='+d_hthnum,
						datatype: 'xml', 
						//colNames:col[0],
						colNames:['合同号','电话','用户名称','一级部门','二级部门','三级部门','四级部门','用户类别','用户性质','是否代收'], 
						colModel:[{name:'hth',index:'hth',width:100}, 
				           			{name:'dh',index:'dh',width:80},
				           			{name:'yhmc',index:'yhmc',width:130},
				           			{name:'bm1',index:'bm1',width:130},
				           			{name:'bm2',index:'bm2',width:130},
				           			{name:'bm3',index:'bm3',width:100},
				           			{name:'bm4',index:'bm4',width:100},
				           			{name:'yhlb',index:'yhlb',width:100},
				           			{name:'yhxz',index:'yhxz',width:100},
				           			{name:'bz2',index:'bz2',width:50},
				           		],
						       	rowNum:10, //默认分页行数
						       	rowList:[10,15,20], //可选分页行数
						       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						       	pager: jQuery('#pagered'), 
						       	sortname: 'hth', //默认排序字段
						       	viewrecords: true, 
						       	//hidegrid: false, 
						       	sortorder: 'asc',//默认排序方式 
						       	//caption:infoo,				       	
						       	height:400, //高
						        //width:document.documentElement.clientWidth-27,
						       	loadComplete:function(){
						       	    var ids = $("#editgrid").getDataIDs();
						       	    if(ids.length>1){
									$("#hth_bmsave").removeAttr("disabled","disabled");
									$("#newhthbm").removeAttr("disabled","disabled");	
									$("#hthhidden").val(d_hthnum);	
									$("#bm1hidden").val($("#editgrid").getCell(1,"bm1"));
									}											
								},
								ondblClickRow: function(ids) {
										
								}
						}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false}, //options 
							{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
							{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
							{reloadAfterSubmit:false}, // del options 
							{} // search options 
							); 
					
			}

        function yijisBmhth(){        
            var sBM="";            
            $("#querysBmtitle").text("选择部门");
	        $("#bmtypekey").val("Bm1");
	        autoBlockForm('querysBm',5,'close',"#ffffff",false);//弹出查询框	     	
			$("#querybmcontext").empty();
			var res = fetchMultiArrayValue("dbsql_phone.querysBm",6,"");
        	if(res[0]==undefined || res[0][0]==undefined)
			{
				$("#querybmcontext").append("<tr><td>没有信息！！！</td></tr>");
				$("#sbmname").val("");
				return false;
			}
			$("#hth").val("");
            $("#Hth_hthdang").val("");
            $("#Hth_yhdang").val("");
			for(var i=0;i<res.length;i++){
				sBM += "<tr onClick=\"getbmname('"+res[i][1]+"');getbmcode('"+res[i][0]+"');\" id=\""+res[i][0]+"\"><td><center>";
				sBM += res[i][1];
				sBM += "</center></td></tr>";
			}
			$("#querybmcontext").append(sBM);
			$("#sbmname").val("");
        }
        function querykeysBm(){
        	var key='';
        	var sBM='';
        	var code='';
        	var querykeybm = $("#querykeybm").val();
        	var selectsbmkey = $("#selectsbmkey").val();
        	selectsbmkey=selectsbmkey.replace(/(^\s*)|(\s*$)/g,"");	
        	if(selectsbmkey==""){alert("请输入查询条件！");return false;}
        	//通过部门名称查询
        	if(querykeybm=="1"){
        		key="dbsql_phone.querysBm_keysbm";
        	//通过索引键查询	
        	}else if(querykeybm=="2"){        		
        		key="dbsql_phone.querysBm_keysbmname";
        	}
        	$("#querybmcontext").empty();
			var res = fetchMultiArrayValue(key,6,"&key="+tsd.encodeURIComponent(selectsbmkey)+"&code="+code);
        	if(res[0]==undefined || res[0][0]==undefined)
			{
				$("#querybmcontext").append("<tr><td>没有信息！！！</td></tr>");
				$("#sbmname").val("");
				return false;
			}
			for(var i=0;i<res.length;i++){
				sBM += "<tr onClick=\"getbmname('"+res[i][1]+"');getbmcode('"+res[i][0]+"');\" id=\""+res[i][0]+"\"><td><center>";
				sBM += res[i][1];
				sBM += "</center></td></tr>";
			}
			$("#querybmcontext").append(sBM);
			$("#sbmname").val("");
        }
        
         /********
       	*弹出部门选择面板 点击信息时调用该方法
        *@param：key 合同号值;
       	*@return;
        *********/
        function getbmname(keyname){
		      $("#sbmname").val(keyname);//把得到的部门添加到隐藏域中点击确定的时候在从隐藏域中取		      		            
        }
        function getbmcode(keycode){
        	if(keycode!=""&&keycode!=undefined){
		      	$("#sbmcode").val(keycode);//把得到的部门添加到隐藏域中点击确定的时候在从隐藏域中取
		      }else{
		      	$("#sbmcode").val("");//把得到的部门添加到隐藏域中点击确定的时候在从隐藏域中取
		      }
		      $("#querybmcontext tr").css('background-color','#ffffff');
		      document.getElementById(keycode).style.background='#0080FF';  
        }	
        
        //点击保存部门按钮
        function savesBm(){
        	var sbmname = $("#sbmname").val();
        	if(sbmname==""){alert("请选择部门！");return false;}
       		$("#newbm").val(sbmname);
        	closeGB();
        }
        
        function BmSave(){
        	if($("#newbm").val().replace(/(^\s*)|(\s*$)/g,"")==""){
        		alert("新大客户名称不能为空！");return;
        	}
        	if($("#bm1hidden").val().replace(/(^\s*)|(\s*$)/g,"")==$("#newbm").val().replace(/(^\s*)|(\s*$)/g,"")){
        		alert("大客户名称没有被修改，不能继续执行操作,请到部门修改该大客户名称");return;
        	}
        	if(confirm("你确定对大客户号["+$("#hthhidden").val()+"]的部门名称由["+$("#bm1hidden").val()+"]修改为["+$("#newbm").val()+"]吗？","操作提示")){
	        	var result = fetchMultiPValue("PhoneModifyHthBm.updateBm",6,"&hth="+$("#hthhidden").val()+"&newhthbm="+tsd.encodeURIComponent($("#newbm").val())+"&UserID="+$("#userloginid").val());
				if(result[0]==undefined || result[0][0]==undefined || result[0][0]=='-1')
				{
					alert("修改大客户信息失败");
					loadJqgrid('1');
				}
				else
				{
					alert("操作成功！");
					loadJqgrid('1');
				}
			}
        }
	</script>
  </head>  
  <body> 
  	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
	<div id="navBar1">
		<table width="100%" height="26px">
			<tr>
				<td width="80%" valign="middle">
					<div id="navBar" style="float: left">
						<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
						<fmt:message key="global.location" />
						：
					</div>
				</td>
				<td width="20%" align="right" valign="top">
					<div id="d2back">
						<a href="javascript:void(0);"
							onclick="parent.history.back(); return false;"><fmt:message
								key="gjh.houtuei" /> </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				</td>
			</tr>
		</table>
	</div>
	<div id="ghBar" style="margin-left: 10px;">
		<table style="margin-top: 10px">
			<tr valign="middle">
				<td>
				&nbsp;&nbsp;<span style="font-size: 18px;font-weight: bold;">大客户号:</span>
				</td>
				<td>
				<input type="text" class="inputbox" id="d_hthnum" style="margin-left:2px;font-size: 16px;width:120px"/>
				</td>
				<td>
				&nbsp;
				<button class="tsdbutton" id="dhthnum" style="margin-bottom: 0px;height:27px;"
				    onclick="loadJqgrid('1');">
					查找
				</button>
				</td>
				<td>
				</td>
				<td>
					|&nbsp;&nbsp;<span style="font-size: 18px;font-weight: bold;">新大客户名称:</span>
				</td>
				<td>
				<input type="text" class="inputbox" id="newbm" style="margin-left:2px;font-size: 18px;width:220px" disabled/>
				</td>
				<td>
				&nbsp;
				<button class="tsdbutton" id="newhthbm" style="margin-bottom: 0px;height:27px;"
				    onclick="yijisBmhth();">
					查找
				</button>
				</td>
				<td>
				&nbsp;
				<button class="tsdbutton" id="hth_bmsave" style="margin-bottom: 0px;height:27px;"
				    onclick="BmSave();">
					保存
				</button>
				</td>
			</tr>
		</table>
	</div>
	<br/>
	<hr/>
	<div id="jqgrid">
		<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>
	</div>
	<div class="neirong" id="querysBm"	style="width:460px;display: none">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<span id="querysBmtitle"></span>
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;" onclick="closeGB()"><fmt:message key="global.close" /><!-- 关闭 --></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;text-align:left;height:260px;;">
			<div id="broadband_frame">
			   <div id="inputtext">
				<table id="xzhthselect" cellspacing="4">
					<tr>
						<td>查询类型</td>
						<td>
							<select id="querykeybm">
								<option value="1">大客户号</option>
								<option value="2">部门名称</option>								
							</select>
						</td>
						<td>
							<input type="text" id="selectsbmkey" name="selecththcontent" style="width:150px;"/>
						</td>
						<td>
							<button class="tsdbutton" id="submitButton" style="line-height:20px;"
									onclick="querykeysBm()">
									查找
								</button>
						</td>
						</tr>
				</table>
				</div>
				</div>					
					<table id="bytctabs" style="width: 433px;" border="1" cellpadding="0" bordercolor="#9AC0CD">
						<tr><td><center>部门名称</center></td></tr>
					</table>
				<div id="page" style="overflow-y:scroll;height:200px;">					
					<table border="1" cellpadding="0" bordercolor="#9AC0CD"
						id="querybmcontext" style="width: 433px;">												
					</table>					
				</div>
			</div>				
			<div class="midd_butt" style="width:450px;height:38px;">  
				<button id="hthChooseFormSave" onclick="savesBm();" class="tsdbutton" 
					style="margin-left: 20px;">
					<!-- 确定 -->
					<fmt:message key="Revenue.Save" />
				</button>
				<button id="hthChooseFormReset" onclick="javascript:setTimeout($.unblockUI,15);$('selectsbmkey').val('');" class="tsdbutton"  style="margin-left: 20px;">
					<fmt:message key="global.close" />
					<!-- 关闭 -->
				</button>
			</div>				
		</div>		
	<input type="hidden" id="sbmname"/>	
	<input type="hidden" id="sbmcode"/>
	<input type="hidden" id="hthhidden"/>
	<input type="hidden" id="bm1hidden"/>
  </body>
</html>
