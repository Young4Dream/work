<%----------------------------------------
	name: BussinessFeeAdjust.jsp
	author: wenxuming
	version: 1.0, 2011-08-23
	description: 查询明细话单
	modify: 
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
	String languageType = (String) session.getAttribute("languageType");
	
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date now = new Date();
	String nowTime = format.format(now);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Call Detail details</title>		
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
		<script type="text/javascript">
			/**
			 * 页面初始化
			 * @param 
			 * @return 
			 */		
			jQuery(document).ready(function () {
				//页面所在位置
				$("#navBar").append(genNavv());
				gobackInNavbar("navBar1");
				$("#querydh").select().focus();
				//查询业务类型下拉框
				var res = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&cloum=ywlx,showname&tablename=ywsl_code&key=typeid=50");
				if(res[0]!=undefined && res[0][0]!=undefined)
				{
					var optHtml = "<option value=\"\">--请选择--</option>";
					for(var ii=0;ii<res.length;ii++)
					{
						optHtml = optHtml + "<option value=\"" + res[ii][1] + "\">" + res[ii][1] + "</option>";
					}
					$("#businesstype").html(optHtml);
				}
			});
			
			/*********
			* 加载jqgrid
			* @param;
			* @return;
		    **********/
			function loadJqgrid(){	
					var Dh = $("#querydh").val().replace(/(^\s*)|(\s*$)/g,"");
					if(Dh==""){
						alert("请输入要查询的电话号码");$("#querydh").select().focus();return;
					}
					$("#gridd").empty();
					$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
					$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
					var businesstype = $("#businesstype").val();
					var res = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&cloum=count(*) as cont&tablename=vw_TelJob&key=xdh='"+tsd.encodeURIComponent(Dh)+"'"+" and sgnr='"+tsd.encodeURIComponent(businesstype)+"'");
					if(res[0][0]==0){
						alert("没有该电话的信息");
						//$("#editgrid").setGridParam({url:'mainServlet.html?'}).trigger("reloadGrid");
						return;
					}								
					/////设置命令参数 用于初始化jqgrid
					var urlstr=tsd.buildParams({
												packgname:'service',//java包
												clsname:'ExecuteSql',//类名
												method:'exeSqlData',//方法名
												ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												tsdcf:'mssql',//指向配置文件名称
												tsdoper:'query',//操作类型 
												datatype:'xml',//返回数据格式 
												tsdpk:'BussinessFeeAdjust.queryteljob',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												tsdpkpagesql:'BussinessFeeAdjust.queryteljobpage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
					});
					//设置jqgrid的头部参数
					var col=[[],[]];
					col=getRb_Field('vw_TelJob','ID','操作','200','ziduansF','Sgnr','Yjkx');//得到jqGrid要显示的字段
					var column = "ID,ID,Sgnr,Yjkx,Xdh,Sgrq,Hth,Area,Value18,Jlry,Xm,Ywarea,Dhlx,Lsh,IsPay";
					var navv = document.location.search;
					var infoo = decodeURIComponent(parseUrl(navv,"imenuname",""));	
					jQuery("#editgrid").jqGrid({
						url:'mainServlet.html?'+urlstr+'&column='+column+"&Dh="+Dh+"&sgnr="+tsd.encodeURIComponent(businesstype),
						datatype: 'xml', 
						colNames:['id','操作',
									'业务类型',
									'应缴款项',
									'现电话',
									'受理日期',
									'合同号',
									'营业点',
									'预存金额',
									'受理人员',
									'用户名称',
									'业务所在区域',
									'电话类型',
									'票据号',
									'付费方式'], 
						colModel:[{name:'ID',index:'ID',hidden:true,width:0},
									{name:'viewOperation',index:'viewOperation',width:170},
			    		   			{name:'Sgnr',index:'Sgnr',width:100}, 
				           			{name:'Yjkx',index:'Yjkx',width:150},
				           			{name:'Xdh',index:'Xdh',width:100},
				           			{name:'Sgrq',index:'Sgrq',width:150},
				           			{name:'Hth',index:'Hth',width:100},
				           			{name:'Area',index:'Area',width:150},
				           			{name:'Value18',index:'Value18',width:150},
				           			{name:'Jlry',index:'Jlry',width:100},
				           			{name:'Xm',index:'Xm',width:150},
				           			{name:'Ywarea',index:'Ywarea',width:100},
				           			{name:'Dhlx',index:'Dhlx',width:100},
				           			{name:'Lsh',index:'Lsh',width:150},
				           			{name:'IsPay',index:'IsPay',width:100},
				           		],
						       	rowNum:10, //默认分页行数
						       	rowList:[10,15,20], //可选分页行数
						       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						       	pager: jQuery('#pagered'), 
						       	sortname: 'Sgrq', //默认排序字段
						       	viewrecords: true, 
						       	//hidegrid: false, 
						       	sortorder: 'desc',//默认排序方式 
						       	caption:infoo,				       	
						       	height:300, //高
						       	loadComplete:function(){													
													addRowOperBtn('editgrid','<span style=\"color:red\">调整业务费</span>','savefrom','ID','click',1,'Xdh','Sgnr');									        	
										        	executeAddBtn('editgrid',1);	
												}
						}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false}, //options 
							{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
							{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
							{reloadAfterSubmit:false}, // del options 
							{} // search options 
							); 
					
			}
			
			function savefrom(str1,str2,str3){
				$("#jobid").val("");
				$("#feetype").val("");
				$("#dhfee").val("");
				$("#Bz").text("");
				$("#queryphone").text(str2);
				var res = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&cloum=feetype&tablename=ywsl_code&key=typeid=50 and showname='"+tsd.encodeURIComponent(str3)+"'");
				if(res[0]!=undefined && res[0][0]!=undefined)
				{
					var array=res[0][0].split("~");
					var optHtml = "<option value=\"\">--请选择--</option>";
					for(var ii=0;ii<array.length;ii++)
					{
						optHtml = optHtml + "<option value=\"" + array[ii] + "\">" + array[ii] + "</option>";
					}
					$("#feetype").html(optHtml);
					$("#jobid").val(str1);
					autoBlockFormAndSetWH('saveupdate',150,250,'close',"#ffffff",false);
				}
		}

		function getfeetypefee(){
			var feetype = $("#feetype").val();
			var res = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&cloum=fee&tablename=ywsl_feetype&key=feetype='"+tsd.encodeURIComponent(feetype)+"'");
				if(res[0]!=undefined && res[0][0]!=undefined)
				{
					$("#dhfee").val(res[0][0]);
				}else{
					$("#dhfee").val(0);
				}
		}

		//添加费用项保存
		function saveupdate(){
			var jobid = $("#jobid").val();
			var feetype = $("#feetype").val();
			var dhfee = $("#dhfee").val().replace(/(^\s*)|(\s*$)/g,"");
			var Bz = $("#Bz").val();
			if(feetype==""){alert("请选择费用项！");return;}
			if(dhfee==""){alert("费用金额不能为空");}
			var result = fetchMultiPValue("businessfee_tz.save",6,"&userid=" + tsd.encodeURIComponent($("#userid").val()) + "&jobid="+tsd.encodeURIComponent(jobid)+"&feetype="+tsd.encodeURIComponent(feetype)+"&fee="+dhfee+"&bz="+tsd.encodeURIComponent(Bz));
			if(result[0]!=undefined && result[0][0]!="")
			{
				alert(result[0][0]);
				closeGB();
				return false;
			}
		}
		</script>
  </head>
  
  <body>
		<input type='hidden' id='userloginip'
			value='<%=Log.getIpAddr(request)%>' />
		<input type='hidden' id='userloginid'
			value='<%=session.getAttribute("userid")%>' />
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
		<div id="broadband_frame">
			<div id="input-Unit">
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					输入查询条件
				</div>
				<div id="inputtext">
					<table style="margin-left: 10px;" cellspacing="10px">
						<tr>
							<td>电话号码：</td>
							<td>
								<input type="text" id="querydh" style="width:150px;"/>
							</td>
							<td>业务类型</td>
							<td>
								<select id="businesstype" style="width:150px;"></select>
							</td>
							<td>
								<button class="tsdbutton" id="submitButton" onclick="loadJqgrid()" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
									查找
								</button>
							</td>
						</tr>
					</table>
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					查询结果
				</div>
				<div id="gridd">
					<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
					<div id="pagered" class="scroll" style="text-align: left;"></div>
				</div>
			</div>
		</div>	
	</div>
	<div class="neirong" id="saveupdate" style="width:608px;display: none">
			<div class="top">
			<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
						<div class="top_03" id="titlediv">操作信息</div>
						<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
					</div>
					<div class="top_01right"><a href="#" onclick="closeGB();">关闭</a></div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
		</div>
			<div class="midd" style="background-color:#FFFFFF;height:100px;">
				<div id="inputtext">
					<table border="0" cellpadding="0" bordercolor="" id="" style="width: 596px;"  cellspacing="3">
						<tr>
							<td style="width:100px;" class='labelclass'>电话</td>
							<td><span id="queryphone"></span><input type="hidden" id="jobid"/></td>
							<td style="width:100px;" class='labelclass'>费用调整项</td>
							<td><select id="feetype" style="width:180px;" onchange="getfeetypefee();">
								</select>
							</td>	
							<td style="width:100px;" class='labelclass'>金额</td>
							<td>
								<input type="text" id="dhfee" style="width:100px;"/>
							</td>						
						</tr>
						<tr>
							<td class='labelclass'>备注</td>
							<td colspan='5'>
								<textarea name="Bz" id="Bz" rows="4" cols="40" style="width:370px;" maxlength="60"  onpropertychange="TextUtil.NotMax(this)"></textarea>
								<span style="color:red">*</span>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="midd_butt" style="width:596px;height:40px;">
				<button id="queryphonebutton" onclick="saveupdate();" class="tsdbutton" 
					style="margin-left: 20px;">
					保存
				</button>
			</div>
		</div>
		<input type="hidden" id="userid" value="<%=userid %>"/>
  </body>
</html>
