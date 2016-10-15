<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%
	String sUserId = (String) session.getAttribute("userid");
	String sArea = (String) session.getAttribute("chargearea");
	String sDepart = (String) session.getAttribute("departname");
	String ywarea = (String) session.getAttribute("userarea");	
	String sMenuid = request.getParameter("imenuid");
	String sGroupid = request.getParameter("groupid");	
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	String iconpath = basePath + "style/icon/";		
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
		<script src="script/public/public.js" type=text/javascript language="javascript"></script>
		<script src="script/broadband/business/broadbandservice.js" type="text/javascript"></script>
		<script src="script/broadband/business/radbusiprint.js" type="text/javascript"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->	
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
		<link href="style/css/telephone/charge/charge_phone.css" rel="stylesheet" type="text/css" />	
		<style type="text/css">
		#input-Unit{ float:left; width:100%; text-align:center;}
		#input-Unit .title_rad{ width:100%; height:22px; border-bottom:1px solid #C8D8E5;  text-align:center; color:#3C3C3C; line-height: 22px; font-weight:bold; background:#CCCCFF;}
		.tsdbutton_rad{width:70px; height:22px;background: url(style/images/public/buttonsbg.jpg) repeat-x; border: #CCCCCC 1px solid; cursor: pointer;}		 
	</style>	
		<script language="javascript" type="text/javascript">
		//页面初始化
		$(function(){
			//页面所在位置
			$("#navBar").append(genNavv());
			$("#selectsbmkey").select().focus();
			loadJqgrid('0');
		});
		function loadJqgrid(key){
			$("#jqgrid").empty();
			var jqgrid ="<table id='editgrid' class='scroll' cellpadding='0' cellspacing='0'></table>";
		    	jqgrid +="<div id='pagered' class='scroll' style='text-align: left;'></div>";
		    $("#jqgrid").html(jqgrid);	
			var urlstr=tsd.buildParams({ 	  
										packgname:'service',//java包
										clsname:'ExecuteSql',//类名
										method:'exeSqlData',//方法名
										ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdcf:'business',//指向配置文件名称
										tsdoper:'query',//操作类型 
										datatype:'xml',//返回数据格式 
										tsdpk:'rad_busi_fanxiao.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										tsdpkpagesql:'rad_busi_fanxiao.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
			});
			jQuery("#editgrid").jqGrid({
						url:'mainServlet.html?'+urlstr+"&acct="+key+"&userid="+tsd.encodeURIComponent("<%=sUserId%>"),
						datatype: 'xml', 
						//colNames:col[0],
						colNames:['工单号','上网帐号','用户名称','缴费时间','原套餐','新套餐','金额','用户地址','收款人'], 
						colModel:[{name:'jobid',index:'jobid',width:100,hidden:true}, 
									{name:'INTERNETACCT',index:'INTERNETACCT',width:100}, 
				           			{name:'USERNAME',index:'USERNAME',width:130},
				           			{name:'PAYDATE',index:'PAYDATE',width:140},
				           			{name:'OLDPKGID',index:'OLDPKGID',width:180},
				           			{name:'PKGID',index:'PKGID',width:180},
				           			{name:'FEE',index:'FEE',width:80},
				           			{name:'USERADDR',index:'USERADDR',width:170},
				           			{name:'USERID',index:'USERID',width:80},
				           		],
						       	rowNum:1, //默认分页行数
						       	rowList:[10,15,20], //可选分页行数
						       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						       	pager: jQuery('#pagered'), 
						       	sortname: 'PAYDATE', //默认排序字段
						       	viewrecords: true, 
						       	//hidegrid: false, 
						       	sortorder: 'desc',//默认排序方式 
						       	caption:"返销条目信息",
						       	shrinkToFit: false,
						       	height:270, //高
						        width:document.documentElement.clientWidth-40,
						       	loadComplete:function(){
						       	    var ids = $("#editgrid").getDataIDs();
									$("#accthidden").val("");
									$("#lszhidden").val("");
									$("#lszhidden").val($("#editgrid").getCell(1,"jobid"));
									$("#accthidden").val($("#editgrid").getCell(1,"INTERNETACCT"));
									$("#fxsave").removeAttr("disabled");								
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
		
		//根据字段名和字段值查询raduserinfo表. 精确查找
		function queryRadUser_equal(){
			var fieldname = $("#queryfield").val(); 
			var fieldvalue = $("#queryvalue").val();
			queryRadUser_equalReal(fieldname,fieldvalue);			
		}
		function queryRadUser_equalReal(fieldname,fieldvalue){
			var res = fetchMultiArrayValue_rad('dbsql_rad.queryRadUser_equal',6,"&fieldname="+fieldname+"&fieldvalue="+tsd.encodeURIComponent(fieldvalue),'business');
			if (res != undefined && res!="" && res.length>0){
				loadJqgrid(res[0][0]);	
			}
			else{
				alert("没有符合条件的用户，请确认您的输入是否正确！");
				clear();
				initValue();
				$("#queryvalue").select();
				$("#queryvalue").focus();
			}
		}
			
		function popupQueryPanel(){
			queryRadUser_like();			
		}
		//根据字段名和字段值查询raduserinfo表. 模糊查找
		function queryRadUser_like(){
			var fieldname = $("#queryfield").val(); 
			var fieldvalue = $("#queryvalue").val();
			var s="";
			$("#tabqueryres").empty();
			s="<tr style='line-height: 22px; font-weight:bold; text-align:center;'>";
			s +="	<td width='80px'>用户账户</td>"
			s +="	<td width='100px'>用户名称</td>"
			s +="	<td>用户地址</td>"
			s +="	<td width='70px'>住宅电话</td>"
			s +="	<td width='90px'>移动电话</td>"
			s +="	</tr>";
			var res = fetchMultiArrayValue_rad('dbsql_rad.queryRadUser_like',6,"&fieldname="+fieldname+"&fieldvalue="+tsd.encodeURIComponent(fieldvalue),'business');			
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					if (res[i][0]==undefined || res[i][1]==undefined) {continue;}				
					s += "<tr style='line-height: 22px;' id='"+res[i][0]+"' onclick=\"selectRow('"+res[i][0]+"')\"; ondblclick=\"dbclickRow('"+res[i][0]+"');\">";					   				 
					s += "<td style='text-align:center'>"+res[i][0]+"</td>";
					s += "<td style='text-align:center'>"+res[i][1]+"</td>";
					s += "<td style='text-align:center'>"+res[i][2]+"</td>";
					s += "<td style='text-align:center'>"+res[i][3]+"</td>";
					s += "<td style='text-align:center'>"+res[i][4]+"</td>";
					s += "</tr>";					
				}
				if (s != ""){
					$("#tabqueryres").append(s);
				}	
				autoBlockFormAndSetWH('divquery',70,'','close',"#ffffff",false,'', '');
			}else{
				alert("没有符合条件的用户，请确认您的输入是否正确！");
				clear();
				initValue();
				$("#queryvalue").select();
				$("#queryvalue").focus();
			}
		}	
		
		//模糊查询面板选中一条记录，变底色		
		function selectRow(rowid){			
			$("#returnUserAcct").val(rowid);
			document.getElementById(rowid).style.background='#0080FF';
		}
		//模糊查询面板点确定时调用
		function setuserinfo(){
			var rows=document.getElementById('tabqueryres').getElementsByTagName('tr');		
			if (rows.length>1){
				if ($("#returnUserAcct").val()==""){
				 	alert("请先选中一条记录！");
					return;
				}				
				queryRadUser_equalReal('internetacct',$("#returnUserAcct").val());
			}
			setTimeout($.unblockUI,15);//关闭模糊查询面板
		}
		//双击查询面板中的记录行时调用
		function dbclickRow(rowid){					
			selectRow(rowid);
			setuserinfo(); 
		}	
		
		//调用宽带开户的后台存储过程
        function savedb(){  
        	//取出所有项目的值，若有可能包含中文的，都做下编码转换		
			var bdnum = $("#bdnum").val();
			var param="";
			if($("#accthidden").val()==""){
				alert("请查询销帐用户！");	
				return;
			}
			param+="&internetacct="+tsd.encodeURIComponent($("#accthidden").val());
			param+="&busifee=";
			param+="&workmemo="+tsd.encodeURIComponent("");
			param+="&busitype=crossfee";
			param+="&jobid="+$("#lszhidden").val();
			param+="&userid="+tsd.encodeURIComponent("<%=sUserId%>");
        	var department = tsd.encodeURIComponent("<%=sDepart%>");
        	var busiarea = tsd.encodeURIComponent("<%=sArea%>");
        	var busiywarea = tsd.encodeURIComponent("<%=ywarea%>");
        	param+="&department="+department+"&busiarea="+busiarea+"&busiywarea="+busiywarea;
			if(confirm("确定将该笔费用销账掉么？")){
				var res = fetchMultiPValue_rad("rad_busi",6,param);        	      
				if(res[0][0]=="SUCCEED"){
					alert("办理成功");
				}else if(res[0][0]=="FAILED"){
					alert("失败"+res[0][1]);
				}
				loadJqgrid('0');
				$("#selectsbmkey").val("");
				$("#accthidden").val("");
				$("#lszhidden").val("");
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
	<div style="width:100%; height:30px; text-align:left;font-weight:bold; margin-top: 25px; ">
			&nbsp;&nbsp;<img src="style/icon/65.gif" />&nbsp;&nbsp;&nbsp;&nbsp;
			查询方式:<select id="queryfield" style="width: 90px;" >
				<option value="internetacct">用户帐号</option>
				<option value="username">用户名称</option>
				<option value="useraddr">用户地址</option>
				<option value="dh" selected="selected">住宅电话</option>
				<option value="mobile">联系电话</option>
				<option value="area">用户区域</option>
			</select>
			<input type="text" id="queryvalue" style="width:162px;"/>
			<input  class="tsdbutton_rad" type="button" value="精确查询" onclick="queryRadUser_equal();"/>
			<input  class="tsdbutton_rad" type="button" value="模糊查询" onclick="popupQueryPanel();"/>
		</div>
	<br/>
	<hr/>
	<div id="jqgrid">
		<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>
	</div>
	<div id="buttons" style="text-align:center">
		<button id="fxsave" style="width:120px;" onClick="savedb()" disabled>返销</button><button id="kdback" style="width:120px;" onClick="setnull()"><!-- 返回 -->重置</button>
	</div>	
	<!-- 模糊查询结果div  -->
	<div class="neirong" id="divquery" style="width:550px;display: none">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<span>请选择您需要的记录</span>
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="setTimeout($.unblockUI,15);"><fmt:message key="global.close" /><!-- 关闭 --></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>
		<div class="midd" style="background-color:#FFFFFF;text-align:left;height:240px;">		
			<div id="page" style="overflow-y:scroll;height:100%;width: 100%;">					
				<table border="1" cellpadding="0" bordercolor="#9AC0CD" id="tabqueryres" style="width: 530px;">												
				</table>
			</div>
		</div>
		<div class="midd_butt" style="width:540px;height:38px;">  
			<button id="hthChooseFormSave" onclick="setuserinfo();" class="tsdbutton" 
				style="margin-left: 20px;">
				确定
			</button>
			<button id="hthChooseFormReset" onclick="javascript:setTimeout($.unblockUI,15);$('selectsbmkey').val('');" class="tsdbutton"  style="margin-left: 20px;">
				取消				
			</button>
			<button id="hthChooseFormsx" onclick="javascript:queryRadUser_like()" class="tsdbutton"  style="margin-left: 20px;">
				刷新				
			</button>
		</div>
	</div>		
	<input type="hidden" id="returnUserAcct"/>
	<input type="hidden" id="IsLimitArea"/>
	<input type="hidden" id="jobid"/>
	<input type="hidden" id="repfile"/>
	<input type="hidden" id="ywarea" value="<%=ywarea %>"/>
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->
	<input type="hidden" id="userid" value="<%=sUserId%>"/>
	<input type="hidden" id="lszhidden" />
	<input type="hidden" id="accthidden" />	
  </body>
</html>
