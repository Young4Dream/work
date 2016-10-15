<%----------------------------------------
	name: rad_busi_Delete.jsp
	author: wangli
	version: 1.0 
	description: 拆机(宽带账号销户) 
	Date: 2011-09-06
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	
	
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
	<script src="plug-in/jquery/ui/jquery.layout.js" type="text/javascript"></script>
	<script src="plug-in/jquery/ui/jquery-ui-1.7.1.custom.js" type="text/javascript"></script>
	<script src="script/broadband/business/broadbandservice.js" type="text/javascript"></script>
	<script src="script/broadband/business/radbusiprint.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script> <!-- 弹出面板需要导入js文件 -->	
    <script type="text/javascript" src="script/public/tsdpower.js"></script><!-- 页面权限控制 -->
    <script type="text/javascript" src="script/public/main.js"></script>
    <script type="text/javascript" src="script/public/mainStyle.js"></script>
    <script type="text/javascript" src="script/public/transfer.js"></script>	    
    <script type="text/javascript" src="script/public/revenue.js" ></script>    
    	
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
	<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
	<!-- 分项卡 -->
	<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css"
		type="text/css" media="print, projection, screen" />
	<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css"
		type="text/css" media="projection, screen" />
	<script src="plug-in/jquery.tabs/jquery.history_remote.pack.js"
		type="text/javascript"></script>
	<script src="plug-in/jquery.tabs/jquery.tabs.pack.js"
		type="text/javascript"></script>
	<script src="plug-in/jquery/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
	<style type="text/css">
		#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
		cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}

		#chooseBox{padding-bottom:30px;}
		#chooseForJF{width:80px;}
		.tsdbutton{margin:2px;padding:2px 18px 2px 18px;height:24px;}
		
		.tsdbtn{line-height:28px;padding:2px 12px 2px 12px;  height:28px; margin-top:4px; margin-left:5px; background: url(style/images/public/buttonbg.jpg) repeat-x; border: #CCCCCC 1px solid; cursor: pointer; }
		label { float:left;text-align:left; margin-left:10px; width: 80px; line-height: 28px; }
		#kdBar p{clear:both;padding-left:10px;}
		.inputbox{{margin-left:20px; background:url(style/images/public/inputText_bg.jpg) repeat-x ; width:180px; border:#999999 solid 1px;  text-align:left; color:#000000; font-size:12px; font-weight:bold; height:22px; line-height: 23px; }}
		
		/*宽带票据*/
		#kdFP{padding-top:30px;padding-bottom:30px;padding-left:10px;}
		#kdInfo,#kdFaultInfoT{text-align:left;border:#eeeeee 1px solid;margin-left:20px;}
		#kdInfo td,#kdFaultInfoT td{	background-color:#ffffff;line-height:26px;}
		
		#kduserInfoPanelTabRight,#kduserInfoPanelTab{text-align:left;border:#eeeeee 1px solid;}
		#kduserInfoPanelTabRight td,#kduserInfoPanelTab td{background-color:#ffffff;line-height:22px;}
		
		.bolder{font-weight:bold;}
		#kduiJf,#kduiJob{cursor:pointer;}
		
		#kdStatus{padding-left:10px;}
		
		.neirong .midd #grid table{line-height:18px;}
		#bu_muser a{font-weight:bold;}
		#input-Unit .title{ width:100%; height:32px; background:url(style/images/public/kuangbg.jpg); border-bottom:1px solid #C8D8E5;  text-align:left; color:#3C3C3C; }
		
		#kdButtons{width:100%; float:left; *float:none; height:36px; background:url(style/images/public/buttonsbg.jpg) repeat-x; border-top:#CCCCCC 1px solid;border-bottom:#CCCCCC 1px solid;}
	</style>	
	<script type="text/javascript">
		var mylayout;		
		var BusiFeeNames = "";
		var BusiFeeValues = "";						
		$(document).ready(function () {
			$("#navBar").append(genNavv());	
			//利用布局控件设置布局			
			mylayout = $('body').layout({ 
				applyDefaultStyles: true,
				east__size:416,
				center__resizable:false,
				north__resizable:false,
				south__resizable:false,
				north__closable:false,
				east__closable:false,
				south__closable:false,
				center__closable:false,									
				spacing_open:1										
			});	
			setEastWidth();			
			
	  		$('#tabs').tabs();//叶签初始化
			$( ".tabs-bottom .ui-tabs-nav, .tabs-bottom .ui-tabs-nav > *" )  
			    .removeClass( "ui-corner-all ui-corner-top" )  
			    .addClass( "ui-corner-left" );  
	  		$("input[id='queryvalue']").keypress(function(e)
   				{
   					if(e.keyCode==13)
   					{
   						queryRadUser_like();
   					}
   			});  
   			$("#jiaofeidetail").attr("disabled","disabled");
   			$("#busdetail").attr("disabled","disabled");
   			initRadUser_jiaofei();
   			//initRadUser_busi();
		});
		
		//设置east布局为整个body宽度的一半，这样center布局的宽度也是body宽度的一半
		function setEastWidth(){
			var w=document.body.clientWidth;
			var s=0;
			if (w<416){
				w = 416;
			}
			mylayout.sizePane('east', w);
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
					var rows=document.getElementById('tabqueryres').getElementsByTagName("tr");   
					rows[1].style.background='#0080FF';
					selectRow(rows[1].id);
				}	
				autoBlockFormAndSetWH('divquery',70,'','close',"#ffffff",false,'', '');
			}else{
				alert("没有符合条件的用户，请确认您的输入是否正确！");
				clear();
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
		//显示用户信息
		function queryRadUser_equalReal(fieldname,fieldvalue){
			var res = fetchMultiArrayValue_rad('dbsql_rad.queryRadUser_equal',6,"&fieldname="+fieldname+"&fieldvalue="+tsd.encodeURIComponent(fieldvalue),'business');
			if (res != undefined && res!="" && res.length>0){
				setValue(res);	
				$("#jiaofeidetail").attr("disabled","");
   				$("#busdetail").attr("disabled","");
				initRadUser_busi();				
			}
			else{
				alert("没有符合条件的用户，请确认您的输入是否正确！");
				$("#queryvalue").select();
				$("#queryvalue").focus();
			}
		}
		//根据查询结果数组，给控件赋值
		function setValue(arr){      	
        	$("#kdinUserName").text(arr[0][0]);
			$("#kdpassword").text(arr[0][23]);
			$("#kdsrealname").text(arr[0][1]);
			
			$("#kdlinkman").text(arr[0][19]);
			$("#kdlinkphone").text(arr[0][18]);
			$("#kdmobile").text(arr[0][17]);
			
			$("#kdbandphone").text(arr[0][20]);
			if(arr[0][15]!="" && arr[0][15] != "undefined"){
        		$("#kdcardtype").text(arr[0][15]);
        	}
			$("#kdcardnum").text(arr[0][16]);
			
			$("#kdaddress").text(arr[0][2]);
			$("#kdusertype").text(arr[0][8]);
			$("#kduserattr").text(arr[0][9]);
			
			$("#kdpaytype").text(arr[0][25]);
			$("#kdinsBm1").text(arr[0][3]);
			$("#kdinsBm2").text(arr[0][4]);
			
			$("#kdinsBm3").text(arr[0][5]);
			$("#kdinsBm4").text(arr[0][6]);
			$("#kdarea").text(arr[0][7]);
			
			$("#kduserarea").text(arr[0][24]);
			$("#kdremainfee").text(arr[0][27]);
			$("#kdremaintime").text(arr[0][28]);
			
			$("#kdremainoctets").text(arr[0][29]);
			$("#kdstatus").text(arr[0][14]);
			$("#kdradpkg").text(arr[0][13]);
			
			$("#kdspeed").text(arr[0][30]);
			$("#kdregdate").text(arr[0][10]);
			$("#kdstartdate").text(arr[0][11]);
			
			$("#kdenddate").text(arr[0][12]);
			$("#kdaccesstype").text(arr[0][21]);
			$("#kddelflag").text(arr[0][31]);
			
			$("#kddeldate").text(arr[0][32]);
			
			$("#kdinip").text(arr[0][6]);
			$("#kdinvlanid").text(arr[0][7]);
			$("#kdinwk").text(arr[0][8]);
			
			$("#kdremark").text(arr[0][22]);
        	 
		}
		//清空用户资料显示框
		function clear(){
			$("#kdinUserName").text("");
			$("#kdpassword").text("");
			$("#kdsrealname").text("");
			
			$("#kdlinkman").text("");
			$("#kdlinkphone").text("");
			$("#kdmobile").text("");
			
			$("#kdbandphone").text("");
			$("#kdcardtype").text("");
			$("#kdcardnum").text("");
			
			$("#kdaddress").text("");
			$("#kdusertype").text("");
			$("#kduserattr").text("");
			
			$("#kdpaytype").text("");
			$("#kdinsBm1").text("");
			$("#kdinsBm2").text("");
			
			$("#kdinsBm3").text("");
			$("#kdinsBm4").text("");
			$("#kdarea").text("");
			
			$("#kduserarea").text("");
			$("#kdremainfee").text("");
			$("#kdremaintime").text("");
			
			$("#kdremainoctets").text("");
			$("#kdstatus").text("");
			$("#kdradpkg").text("");
			
			$("#kdspeed").text("");
			$("#kdregdate").text("");
			$("#kdstartdate").text("");
			
			$("#kdenddate").text("");
			$("#kdaccesstype").text("");
			$("#kddelflag").text("");
			
			$("#kddeldate").text("");
			 
			$("#kdinip").text("");
			$("#kdinvlanid").text("");
			$("#kdinwk").text("");
			
			$("#kdremark").text("");
			
			$("#jiaofeidetail").attr("disabled","disabled");
   			$("#busdetail").attr("disabled","disabled");
   			
   			//$("#editgrid3").empty();
   			//$("#pagered3").empty();
		}	
		function reloadJiaofei(){
			var fname="internetacct";
			var fvalue=$("#returnUserAcct").val();
			reloadGrid("jiaofei",fname,fvalue);
		}
		function reloadBusi(){
			var fname="a.internetacct";
			var fvalue=$("#returnUserAcct").val();
			reloadGrid("busi",fname,fvalue);
		}
		
		/**
		 * 查询指定账号的缴费记录信息
		 * @param UserName 待查询的宽带账号
		 * @return
		 */
		function initRadUser_jiaofei(){
				var cols = "paydate,billno,internetacct,username,fee,pkgname,userid,feetype,paymode,memo";
				var cna = "缴费时间,缴费流水,帐号,用户名称,缴费金额,套餐名称,受理人员,费用类型,付款方式,备注";
				var colnn = cna.split(",");
				var coln = cols.split(",");
				var colm = [];
				
				for(var i=0;i<coln.length;i++)
				{
					var temp = "{name:'"+coln[i]+"',index:'"+coln[i]+",width:100'}";
					colm.push(new Function("return "+temp)());
				}					
				colm[0].width=140;
				colm[1].width=130;
				colm[2].width=70;
				colm[3].width=90;
				colm[4].width=70;
				colm[5].width=110;
				colm[6].width=70;
				colm[7].width=70;
				colm[8].width=70;
				colm[9].width=120;							
				
				$("#editgrid2").jqGrid({
						datatype: 'xml', 
						colNames:colnn, 
						colModel:colm, 
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered2'), 
				       	sortname: 'paydate', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'desc',//默认排序方式 
				       	caption:'历史缴费流水',//历史缴费流水,
						autowidth: true,
	       				shrinkToFit:false,
				       	height:document.documentElement.clientHeight-250, //高
				       	width:document.documentElement.clientWidth-90,
				       	loadComplete:function(){
										
						}
				}).navGrid('#pagered2', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
				); 
		}	
		function initRadUser_busi(){
			var cols = "jobdate,busitype,internetacct,userid,fee,complete,completedate,cancel,status,memo";
			var cna = "记录日期,业务类型,上网账号,受理工号,业务费,是否完工,完工日期,是否撤销,工单状态,备注";
			
			var colnn = cna.split(",");
			var coln = cols.split(",");
			var colm = [];
			for(var i=0;i<coln.length;i++)
			{
				var temp = "{name:'"+coln[i]+"',index:'"+coln[i]+"',width:120}";
				colm.push(new Function("return "+temp)());
			}
			colm[0].width=110;
			colm[1].width=80;
			colm[2].width=100;
			colm[3].width=80;
			colm[4].width=60;
			colm[5].width=60;
			colm[6].width=110;
			colm[7].width=60;
			colm[8].width=60;
			colm[9].width=130;				
				
			$("#editgrid3").jqGrid({
					datatype: 'xml', 
					colNames:colnn, 
					colModel:colm, 
			       	rowNum:10, //默认分页行数
			       	rowList:[10,15,20], //可选分页行数
			       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
			       	pager: jQuery('#pagered3'), 
			       	sortname: 'jobdate', //默认排序字段
			       	viewrecords: true, 
			       	sortorder: 'desc',//默认排序方式 
			       	caption:'业务受理历史记录',//业务受理历史记录, 
			       	autowidth: true,
	       			shrinkToFit:false,
			       	height:document.documentElement.clientHeight-250, //高
			       	width:document.documentElement.clientWidth-90,
			       	loadComplete:function(){
									
					}
			}).navGrid('#pagered3', {edit: false, add: false, add: false, del: false, search: false}, //options 
				{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
				{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
				{reloadAfterSubmit:false}, // del options 
				{} // search options 
			); 
		}
		/**
		 * 查询指定账号的业务记录信息
		 * @param UserName 待查询的宽带账号
		 * @return
		 */
		function reloadGrid(type,fieldname,fieldvalue)
		{
			if (fieldname=="" || fieldvalue==""){
				return false;
			}
			var sql="";
			var sqlpage="";
			var grid="";
			if (type=='jiaofei'){
				sql="dbsql_rad.queryjiaofei_equal";
				sqlpage="dbsql_rad.queryjiaofei_equalpage";
				grid="editgrid2";
			}else if(type='busi'){
				sql="dbsql_rad.querybusi_equal";
				sqlpage="dbsql_rad.querybusi_equalpage";
				grid="editgrid3";
			}
			var urlstr=tsd.buildParams({ packgname:'service',//java包
										clsname:'ExecuteSql',//类名
										method:'exeSqlData',//方法名
										ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdcf:'oracle_business',//指向配置文件名称
										tsdoper:'query',//操作类型 
										datatype:'xml',//返回数据格式 
										tsdpk:sql,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										tsdpkpagesql:sqlpage//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
			});
			var params = "&fieldname="+fieldname+"&fieldvalue="+tsd.encodeURIComponent(fieldvalue);
			$("#"+grid).setGridParam({url:'mainServlet.html?'+urlstr + params}).trigger("reloadGrid");		
		}
	</SCRIPT> 
</head>
<body>	
	<DIV class="ui-layout-north">
		<div id="navBar1" style="margin:-10px">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />您当前所在的位置 ：		 												 													
						</div>
					</td>
					<td width="20%" align="right" valign="top">
						<div id="d2back">
							<a href="javascript:void(0);" onclick="parent.history.back(); return false;">
								返回
							</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>					
		<div style="width:100%; height:30px; text-align:left;font-weight:bold; margin-top: 25px; ">
			&nbsp;&nbsp;<img src="style/icon/65.gif" />&nbsp;&nbsp;&nbsp;&nbsp;
			查询方式:<select id="queryfield" >
				<option value="internetacct">用户帐号</option>
				<option value="username">用户名称</option>
				<option value="useraddr">用户地址</option>
				<option value="dh">住宅电话</option>
				<option value="mobile">联系电话</option>
				<option value="area">用户区域</option>
			</select>
			<input type="text" class="inputbox"  id="queryvalue"/>
			<input  class="tsdbutton" style="width: 80px;" type="button" value="模糊查询" onclick="popupQueryPanel();"/>
		</div>
	</DIV> 
		
	<DIV class="ui-layout-center">	
		<div id="input-Unit" style="margin-top:-10px">
											
		</div>								
	</DIV> 
	<DIV class="ui-layout-east">
		<div id="input-Unit" style="margin-top:-10px">
				<div id="tabs"  class="tabs-nav">
					<ul>
						<li id="operDispatch">
							<a href="#fragment-27"  onclick=""><span id="recjob" onclick="clickStatus(0)">用户信息</span> </a>
						</li>
						<li id="jiaofeidetail">
							<a href="#fragment-28"  onclick=""><span id="newjob" onclick="reloadJiaofei();">历史缴费记录</span> </a>
						</li>
						<li id="busdetail">
							<a href="#fragment-29"  onclick=""><span id="hastreated" onclick="reloadBusi(2)">业务受理历史记录</span> </a>
						</li>
					</ul>	
					<div id="fragment-27">
							<table id="kdInfo" width="960" border="1" bordercolor="#eeeeee" cellspacing="0" cellpadding="1" style="background-color:#eeeeee;border-collapse:collapse" bgcolor="#eeeeee">
								<tr>
									<td width="100">账号</td><td width="200"><span id="kdinUserName"></span></td><td width="100">密码</td><td width="200"><span id="kdpassword"></span></td><td width="100">用户名称</td><td width="200"><span id="kdsrealname"></span></td>
								</tr>
								<tr>
									<td>联系人</td><td><span id="kdlinkman"></span></td><td>联系电话</td><td><span id="kdlinkphone"></span></td><td>移动电话</td><td><span id="kdmobile"></span></td>
								</tr>
								<tr>
									<td>绑定电话</td><td><span id="kdbandphone"></span></td><td>证件类型</td><td><span id="kdcardtype"></span></td><td>证件号码</td><td><span id="kdcardnum"></span></td>
								</tr>
								<tr>
									<td>用户地址</td><td colspan="5"><span id="kdaddress"></span></td>
								</tr>		
								<tr>
									<td>用户类型</td><td><span id="kdusertype"></span></td><td>用户性质</td><td colspan="1"><span id="kduserattr"></span></td><td>付费类型</td><td><span id="kdpaytype"></span></td>
								</tr>
								<tr>
									<td>一级部门</td><td><span id="kdinsBm1"></span></td><td>二级部门</td><td><span id="kdinsBm2"></span></td><td>三级部门</td><td><span id="kdinsBm3"></span></td>
								</tr>
								<tr>
									<td>四级部门</td><td><span id="kdinsBm4"></span></td><td>营业区域</td><td><span id="kdarea"></span></td><td>用户区域</td><td><span id="kduserarea"></span></td>
								</tr>		
								<tr>
									<td>余额</td><td><span id="kdremainfee"></span></td><td>剩余时长</td><td colspan="1"><span id="kdremaintime"></span></td><td>剩余流量</td><td><span id="kdremainoctets"></span></td>
								</tr>
								<tr>
									<td>状态</td><td><span id="kdstatus"></span></td><td>套餐</td><td colspan="1"><span id="kdradpkg"></span></td><td>带宽</td><td><span id="kdspeed"></span></td>
								</tr>
								<tr>
									<td>开户日期</td><td><span id="kdregdate"></span></td><td>计费日期</td><td colspan="1"><span id="kdstartdate"></span></td><td>到期日期</td><td><span id="kdenddate"></span></td>
								</tr>
								<tr>
									<td>接入方式</td><td><span id="kdaccesstype"></span></td><td>拆机标志</td><td><span id="kddelflag"></span></td><td>拆机日期</td><td><span id="kddeldate"></span></td>
								</tr>
								<tr style="display: none;">
									<td>绑定IP</td><td><span id="kdinip"></span></td><td>绑定VLANID</td><td><span id="kdinvlanid"></span></td><td>MAC地址</td><td><span id="kdinwk"></span></td>
								</tr>
								<tr>
									<td>备注</td><td colspan="5"><span id="kdremark"></span></td>
								</tr>
							</table>
					</div>
					<div id="fragment-28">
							<table id="editgrid2" class="scroll"cellpadding="0" cellspacing="0"></table>
							<div id="pagered2" class="scroll" style="text-align: left;"></div>
					</div>
					<div id="fragment-29">
							<table id="editgrid3" class="scroll"cellpadding="0" cellspacing="0"></table>
							<div id="pagered3" class="scroll" style="text-align: left;"></div>
					</div>
					<div id="fragment-30">
							<table id="editgrid3" class="scroll" cellpadding="0" cellspacing="0"></table>
							<div id="pagered3" class="scroll" style="text-align: left;"></div>
					</div>
				</div>
		</div>		 
	</DIV>		
	<input type="hidden" id="returnUserAcct"/>
	<input type="hidden" id="IsLimitArea"/>
	<input type="hidden" id="jobid"/>
	<input type="hidden" id="repfile"/>
	<input type="hidden" id="ywarea" value="<%=ywarea %>"/>
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->
	<input type="hidden" id="userid" value="<%=sUserId%>"/>
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
</body>
</thml>