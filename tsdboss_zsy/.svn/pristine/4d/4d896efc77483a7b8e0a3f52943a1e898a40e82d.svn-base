<%----------------------------------------
	name: NuserManager.jsp
	author: chenze
	version: 1.0, 2010-12-28
	description: 
	modify: 
	
		2011-01-11  chenze  增加特殊账号限制
		
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = (String)session.getAttribute("groupid");//request.getParameter("groupid");
	String lanType = (String) session.getAttribute("languageType");
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Definition relay Bureau to Group</title>
    <!-- 导入的js文件 -->
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
	<script src="script/public/mainStyle.js" type="text/javascript"></script>
	<script src="style/js/mainStyle.js" type="text/javascript"></script>
	<!-- 弹出对话框需要导入的js文件 -->
	<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
	<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
	<!-- tab滑动门需要导入的包 *注意路径 -->
	<script src="plug-in/jquery/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<script type="text/javascript" src="script/public/infotest.js"></script>
	<!-- tab滑动门 需要导入的样式表 *注意路径-->
	<script type="text/javascript" src="css/tree/dtree.js"></script>
	<!-- 弹出面板需要导入js文件 -->
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
	<!-- 关于字符串需要用到的js -->
	<script type="text/javascript" src="script/public/main.js"></script>
	<!-- 收费结账专用js -->
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<!-- 时间控件 -->
	<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
	<!-- 导入js文件结束 -->
	<!-- 导入css文件开始 -->
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
	<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
	<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />

	<link rel="stylesheet" type="text/css" href="css/tree/dtree.css" />
	<link rel="stylesheet" type="text/css" href="plug-in/MultiSelect/jquery.multiSelect.css" />
	<script type="text/javascript" src="plug-in/MultiSelect/jquery.multiSelect.js"></script>
	<!-- 导入css文件结束 -->
	<style type="text/css">
		#editgrid a{font-weight:bold;}
		body{text-align:left;}
		input,select{margin-left:0px;}		
		.textclass{width:180px;margin-left:0px;}		
		.spanstyle{display:-moz-inline-box; display:inline-block; width:135px}		
		.disabledStar{display:none;}
		.tdstyle{border-bottom:1px solid #A9C8D9;line-height:32px;}
		
		.multiSelect{width:172px;margin-left:0px;height:18px;line-height:18px;}
		.multiSelectOptions{width:180px;}
		#Ctrl1_canloginip_tab_container{max-height:100px;overflow-y:auto;}
		#Ctrl1_canloginip_tab{width:96%;margin-left:auto;margin-right:auto;}
		#Ctrl1_canloginip_tab td{line-height:26px;border:1px solid #CDD;width:20%;}
		#Ctrl1_vi_canloginip_tab_container{max-height:100px;overflow-y:auto;}
		#Ctrl1_vi_canloginip_tab{width:96%;margin-left:auto;margin-right:auto;}
		#Ctrl1_vi_canloginip_tab td{line-height:26px;border:1px solid #EED;width:20%}
	</style>
	
	<script type="text/javascript">
	
	var Dat = "";
	var tabStatus = 1;	
	var tables = ['sys_user'];
	var fuheM = false;	
	var firstLoad = [true];
	//工号管理
	var mNames = ["<fmt:message key='userManager.GonghaowuManagement' />"];
		
	//用于数据格式的验证
	var regularExp = [];
	regularExp["integer"] = /^\d+$/;
	regularExp["double"] = /^\d+|\d+\.\d+$/;
	//修改数据时保存原记录
	var sourceData = new Array();
	
	$(function(){
		$("#navBar").append(genNavv());
		setUserRight();
				
		getI118n();
		loadFeilu(Dat);
		
		$("#close21").click(function(){fuheM=false;});	
		//测试
		//vValid("ST7","ST7_ld");		
		//初始化面板面板里的下拉列表
		InitialDropdownList();	
	});
	
	/////取字符串长度
	function getLength(str)
	{
		var len = 0;
		for(var i=0;i<str.length;i++)
		{
			if(str.charCodeAt(i)>255)
				len += 2;
			else
				len += 1;				
		}
		return len;
	}
	
	function loadFeilu(models)
	{
		//models.setHidden(["ID"]);
		var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'NuserManager.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'NuserManager.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
		var fileds = "," + models.FieldName.join(",") + ",";
		fileds = fileds.replace(",groupid,",",getMultiValues(groupid,'sys_powergroup','groupid','groupname') groupid,");
		fileds = fileds.replace(",limitlogin,",",case limitlogin when 'true' then '"+"<fmt:message key='userManager.yes' />"+"' when 'false' then '"+"<fmt:message key='userManager.yes' />"+"' else limitlogin end limitlogin,");	
		fileds = fileds.replace(",logined,",",case logined when 'true' then '是' when 'false' then '否' else logined end logined,");		
		fileds = fileds.substring(1,fileds.length-1);
		fileds = tsd.encodeURIComponent(fileds);
		$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr + '&cols=' + fileds  + "&cols1=" + Dat.FieldName.join(",") + "&tablename=" + tables[tabStatus-1],
				datatype: 'xml', 
				colNames:models.colNames,//["<fmt:message key='global.operation' />","NetName","Bjzg","Bjdm","Jbjcm","Jbfl","Tfjcm","Tffl","Qjms","Fuf","Fjf","Fjl","Jmlx",'rowguid'], 
				colModel:models.colModels, 
		       	rowNum:10, //默认分页行数
		       	rowList:[10,15,20], //可选分页行数
		       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/',
		       	pager: jQuery('#pagered'), 
		       	sortname: 'userid', //默认排序字段
		       	viewrecords: true, 
		       	sortorder: 'desc',//默认排序方式 
		       	caption:mNames[tabStatus-1], 
		       	height:document.documentElement.clientHeight-182,
		       	//width:document.documentElement.clientWidth-27,
		       	loadComplete:function(){
						////@1  表格的id
						////@2  链接名称
						////@3  链接地址或者函数名称
						////@4  行主键列的名称 可以是隐藏列
						////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
						////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	*/
						addRowOperBtn('editgrid',"<img src=\"style/images/public/ltubiao_01.gif\" title=\"<fmt:message key='global.edit' />\" />",'openRowModify','userid','click',1);
						addRowOperBtn('editgrid',"<img src=\"style/images/public/ltubiao_02.gif\" title=\"<fmt:message key='global.delete' />\" />",'deleteRow','userid','click',2);
						addRowOperBtn('editgrid',"<img src=\"style/images/public/ltubiao_03.gif\" title=\"<fmt:message key='userManager.detailed' />\" />",'detailRow','userid','click',3);
					    /****执行行按钮添加********
						*@1 表格ID
						*@2 操作按钮数量 等于定义数量
						*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
						executeAddBtn('editgrid',3);
						
						var ids = $("#editgrid").getDataIDs();
						
						for(var i=0;i<ids.length;i++)
						{
							
						}
					}
				}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
	}
	////////////////////////////////////////////////////////////////////////////////
	//////					取国际化信息
	///////////////////////////////////////////////////////////////////////////////	
	function getI118n()
	{
		
		//alert(tabStatus-1);
		Dat = loadData(tables[tabStatus-1],$("#languageType").val(),1,"<fmt:message key='userManager.modifyAndDeleteAndDetailed' />");
		Dat.colModels[0].width=100;	
		//alert(Dat.FieldName);
		var i = 0;
		if(firstLoad[tabStatus-1])
		{
			//设置新增面板别名
			var labels = $("#cl_from"+(tabStatus) + " label");			
			var temp = "";
			$.each(labels,function(i,n){
				
				temp = $(n).attr("for");
				temp = temp.replace("Ctrl"+tabStatus+"_","");
				$("#" + "Ctrl" + tabStatus + "_" + "Lbl_" + temp).text(Dat.getFieldAliasByFieldName(temp.toLowerCase()));				
			});
			//添加红色星号
			HighLight();
			//alert($("#NetName_label_1").text());
			
			//设置查询面板
			var labels = $("#se_from"+(tabStatus) + " label");			
			var temp = "";
			$.each(labels,function(i,n){
				temp = $(n).attr("for");
				temp = temp.replace("Ctrl"+tabStatus+"_Sel_","");
				$("#" + "Ctrl" + tabStatus + "_Sel_" + "Lbl_" + temp).text(Dat.getFieldAliasByFieldName(temp));				
			});
			
			//设置锁定面板
			var labels = $("#lk_from"+(tabStatus) + " label");			
			var temp = "";
			$.each(labels,function(i,n){
				
				temp = $(n).attr("for");
				temp = temp.replace("Ctrl"+tabStatus+"_lk_","");
				
				$("#" + "Ctrl" + tabStatus + "_lk_" + "Lbl_" + temp).text(Dat.getFieldAliasByFieldName(temp));				
			});
			
			//设置详细面板
			var labels = $("#vi_from"+(tabStatus) + " label");			
			var temp = "";
			$.each(labels,function(i,n){				
				temp = $(n).attr("for");
				temp = temp.replace("Ctrl"+tabStatus+"_vi_","");
				//if(temp=="last_login") {alert(temp);return;}//如果是营业区域，则不处理别名
				$("#" + "Ctrl" + tabStatus + "_vi_" + "Lbl_" + temp).text(Dat.getFieldAliasByFieldName(temp));				
			});
			firstLoad[tabStatus-1] = false;
			//$('#Ctrl1_Lbl_DEFAREAs').text($('#Ctrl1_Lbl_DEFAREA').text());
		}	
	}
	
	////////////////////////////////////////////////////////////////////////////////
	//////					加星显示关键字
	///////////////////////////////////////////////////////////////////////////////	
	function HighLight()
	{
		$("#Ctrl" + tabStatus + "_userid").parent().append("<span style=\"color:#FF0000;\">*</span>");
		$("#Ctrl" + tabStatus + "_username").parent().append("<span style=\"color:#FF0000;\">*</span>");	
		$("#Ctrl" + tabStatus + "_groupid").parent().append("<span style=\"color:#FF0000;\">*</span>");
		$("#Ctrl" + tabStatus + "_departname").parent().append("<span style=\"color:#FF0000;\">*</span>");	
		$("#Ctrl" + tabStatus + "_userarea").parent().append("<span style=\"color:#FF0000;\">*</span>");
		$("#Ctrl" + tabStatus + "_password").parent().append("<span style=\"color:#FF0000;\">*</span>");			
	}
	
	//初始化添加面板里的下拉框
	function InitialDropdownList()
	{
		var optHtml = "";
		//部门
		var bmlist = fetchMultiValue("NuserManager.getDeptName",6,"");
		if(bmlist[0]!=undefined)
		{
			//optHtml = "<option value=\"\">请选择</option>";
			optHtml = "<option value=\"\">"+"<fmt:message key='userManager.choose' />"+"</option>";
			
			for(var i=0;i<bmlist.length;i++)
			{
				optHtml += "<option value=\"" + bmlist[i] + "\">" + bmlist[i] + "</option>";
			}
			$("#Ctrl1_departname").html(optHtml);
		}
		//部门
		var asysarealist = fetchMultiValue("NuserManager.asysarea",6,"");
		if(asysarealist[0]!=undefined)
		{
			optHtml = "<option value=\"\">请选择</option>";
			for(var i=0;i<asysarealist.length;i++)
			{
				optHtml += "<option value=\"" + asysarealist[i] + "\">" + asysarealist[i] + "</option>";
			}
			$("#Ctrl1_DEFAREA").html(optHtml);
		}
		//取权限组
		var grouplist = fetchMultiArrayValue("NuserManager.getGroupInfo",6,"");
		if(grouplist[0]!=undefined && grouplist[0][1]!=undefined)
		{
			optHtml = "";
			for(var i=0;i<grouplist.length;i++)
			{
				optHtml += "<option tval=\"" + grouplist[i][0] + "\" value=\"" + grouplist[i][0] + "\">" + grouplist[i][1] + "</option>";
			}
			$("#Ctrl1_groupid").html(optHtml).multiSelect({ oneOrMoreSelected: '*'},function(){},'Ctrl1_groupid',',');
			$("#Ctrl1_groupid").next(".multiSelectOptions").find(".selectAll:first").hide();
			$("#Ctrl1_groupid").next(".multiSelectOptions").find(":checkbox").each(function(){
				var pval = $.trim($(this).parent().text());
				var tval = $(this).val();
				if(pval=="administrators" || pval=="dataadministrators")
				{
					$(this).attr("sysgroup",pval);
				}
			});
			$(":checkbox[name='Ctrl1_groupid'][sysgroup]").click(function(){
				var pval = $.trim($(this).parent().text());
				var tval = $(this).val();
				if(pval=="administrators" || pval=="dataadministrators")
				{
					//$(":checkbox[name='Ctrl1_groupid'][sysgroup]")
					//alert($(":checkbox[name='Ctrl1_groupid']:checked").size());
					
					//alert($("#Ctrl1_groupid").attr("trueval"));
					//alert($(":checkbox[name='Ctrl1_groupid'][value='" + tval + "']").attr("checked"));
					//alert($(":checkbox[name='Ctrl1_groupid'][value='" + tval + "']:checked").size());
					if($(":checkbox[name='Ctrl1_groupid'][value='" + tval + "']").attr("checked"))
					{
						$(":checkbox[name='Ctrl1_groupid']:checked").not($(this)).click();
						$(":checkbox[name='Ctrl1_groupid']").not($(this)).attr("disabled","disabled");
						$("#Ctrl1_groupid").attr("trueval",tval).val(pval);
					}
					else
					{
						$("#:checkbox[name='Ctrl1_groupid']").not($(this)).removeAttr("disabled");
						$("#Ctrl1_groupid").attr("trueval","").val("");
					}
				}
			});
		}
		//取区域 
		var arealist = fetchMultiArrayValue("NuserManager.getArea",6,"");
		if(arealist[0]!=undefined && arealist[0][0]!=undefined)
		{
			optHtml = "";
			for(var i=0;i<arealist.length;i++)
			{
				optHtml += "<option areaid=\"" + arealist[i][1] + "\" tval=\"" + arealist[i][1] + "\" value=\"" + arealist[i][0] + "\">" + arealist[i][1] + "</option>";
			}
			$("#Ctrl1_userarea").html(optHtml).multiSelect({ oneOrMoreSelected: '*'},function(){
				//alert($("#Ctrl1_userarea").attr("trueval"));//.next(".multiSelectOptions").size());//.find("input:checkbox:checked").not('.selectAll').size());
				//根据业务区域生成营收区域
				var ywarea = $("#Ctrl1_userarea").attr("trueval");
				if(ywarea=="") ywarea = "-1";
				var chargearea = fetchMultiValue("NuserManager.getChargeArea",6,"&areaid=" + encodeURIComponent(ywarea));
				var optHtml = "<select name=\"Ctrl1_chargename\" id=\"Ctrl1_chargename\" class=\"textclass\">";
				
				if(chargearea[0]!=undefined)
				{
					for(var ii=0;ii<chargearea.length;ii++)
					{
						optHtml += "<option value=\"" + chargearea[ii] + "\">" + chargearea[ii] + "</option>";
					}
					optHtml += "</select>";
					$("#Ctrl1_chargename").parent("td").html(optHtml);
					
					$("#Ctrl1_chargename").multiSelect({ oneOrMoreSelected: '*'},function(){
						
					},"Ctrl1_chargename",",");
				}
				else
				{
					optHtml += "<option value=\"\">请选择</option>";
					optHtml += "</select>";
					$("#Ctrl1_chargename").parent("td").html(optHtml);
				}
			},'Ctrl1_userarea',',');
			//alert($("#Ctrl1_userarea").next(".multiSelectOptions").find(":checkbox:checked").size());
			$("#Ctrl1_userarea").next(".multiSelectOptions").find(":checkbox:checked").attr("checked","false");
			$("#Ctrl1_userarea").next(".multiSelectOptions").find(".selectAll:first").hide();
			//alert($("#Ctrl1_userarea").next(".multiSelectOptions").find(":checkbox:checked").size());
		}
	}
	
	/**
		重置营业区域下拉
	*/
	function resetChargeArea()
	{
		var optHtml = "<select name=\"Ctrl1_chargename\" id=\"Ctrl1_chargename\" class=\"textclass\">";
		optHtml += "<option value=\"\">请选择</option>";
		optHtml += "</select>";
		$("#Ctrl1_chargename").parent("td").html(optHtml);
		
	}
	
		
	////////////////////////////////////////////////////////////////////////////////
	//////					禁用主键的表单
	///////////////////////////////////////////////////////////////////////////////	
	function disablePrimary()
	{
		$("#Ctrl"+tabStatus+"_userid").attr("disabled","disabled");
		//$("#Ctrl"+tabStatus+"_Xuhao_XH").attr("disabled","disabled");
	}
	////////////////////////////////////////////////////////////////////////////////
	//////					恢复所有表单可用
	///////////////////////////////////////////////////////////////////////////////	
	function makeAllEnabled()
	{
		$("#Ctrl"+tabStatus+"_userid").removeAttr("disabled");
		//$("#Ctrl"+tabStatus+"_Xuhao_XH").removeAttr("disabled");
	}
	
	/**
	 *  打开IP设置页面
	 *  param  ips  已选中的IP地址
	 *  Return null
	 */
	function openIPDefinePanel(ips)
	{
		var ywarea = $("#Ctrl1_userarea").val();
		var charea = $("#Ctrl1_chargename").val();
		var ips = $("#Ctrl1_canloginip").val();
		
		if(ywarea=="" || ywarea=="请选择")
		{
			alert("请选择管理区域");
			return false;
		}
		if(charea=="" || charea=="请选择")
		{
			alert("请选择营收区域");
			return false;
		}
		if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){  
			window.showModalDialog("mainServlet.html?pagename=system/ipEditor.jsp?ips="+"ips"+ "&ywarea=" + encodeURIComponent(ywarea) + "&charea=" + encodeURIComponent(charea) + "&_t="+Math.random(),window,"dialogWidth:700px; dialogHeight:300px; center:yes; scroll:no;status=no");
	    }
	    else{
			window.showModalDialog("mainServlet.html?pagename=system/ipEditor.jsp?ips="+"ips"+ "&ywarea=" + encodeURIComponent(ywarea) + "&charea=" + encodeURIComponent(charea) + "&_t="+Math.random(),window,"dialogWidth:690px; dialogHeight:400px; center:yes;topmargin:0;leftmargin:0;marginheight:0;marginwidth:0;scroll:yes;status:no");
		}
	}
	/**
	 *  取当前已有IP,用于模态窗口取值
	 *  param  
	 *  Return 当前可登陆IP
	 */
	function transferCurrentIP()
	{
		return $("#Ctrl1_canloginip").val();
	}
	/**
	 *  返回设置的IP地址
	 *  param  ips  已选中的IP地址
	 *  Return null
	 */
	function setIPDefine(ips,cid)
	{
		if(ips==undefined || ips=="") return false;
		if(cid==undefined)
			cid="";
		else
			cid = "_"+cid;
		
		$("#Ctrl1"+cid+"_canloginip").val(ips.replace(/,/g,"~"));
		var ipss = [];
		if(ips.indexOf(",")>0)
		{
			ipss = ips.split(",");
		}
		else
		{
			ipss.push(ips);
		}
		var tabHtml = "";
		var ii = 0;
		for(ii = 0;ii<ipss.length;ii++)
		{
			if((ii+1)%5==1)
				tabHtml += "</tr><tr>";
				
			tabHtml += "<td>" + ipss[ii] + "</td>";				
		}
		if(ii%5!=0)
		{
			var kk = ii%5;
			while(kk<5)
			{
				tabHtml += "<td></td>";
				kk++;
			}
			tabHtml += "</tr>";
		}
		tabHtml = tabHtml.replace("</tr>","");
		
		$("#Ctrl1"+cid+"_canloginip_tab").html(tabHtml);
	}
	
	
	//////////////////////////////////////////////////////////////////////
	/////       更换按钮状态 0修改  1新增   2查询
	/////////////////////////////////////////////////////////////////////
	function toggleBtn(sta)
	{
		if(sta==0)
		{
			$("#cl_from"+tabStatus+"save").hide();
			$("#cl_from"+tabStatus+"exit").hide();
			$("#cl_from"+tabStatus+"modify").show();
			$("#cl_from"+tabStatus+"search").hide();
		}
		else if(sta==1)
		{
			$("#cl_from"+tabStatus+"save").show();
			$("#cl_from"+tabStatus+"exit").show();
			$("#cl_from"+tabStatus+"modify").hide();
			$("#cl_from"+tabStatus+"search").hide();
		}
		else if(sta==2)
		{
			$("#cl_from"+tabStatus+"save").hide();
			$("#cl_from"+tabStatus+"exit").hide();
			$("#cl_from"+tabStatus+"modify").hide();
			$("#cl_from"+tabStatus+"search").show();
		}
	}
	function detailRow()
	{
		//生成参数串
		var params = "&userid=" + tsd.encodeURIComponent(arguments[0]);
			
		var urlMm = tsd.buildParams({ packgname:'service',
			clsname:'ExecuteSql',//类名
			method:'exeSqlData',//方法名
			ds:'tsdBilling',
			tsdcf:'mssql',//指向配置文件名称
			tsdoper:'query',//操作类型 
			datatype:'xmlattr',//返回数据格式 
			tsdpk:"NuserManager.detail"
			});
		
		$.ajax({
			url:"mainServlet.html?" + urlMm + params + "&tablename=" + tables[tabStatus-1],
			async:false,
			cache:false,
			timeout:1000,
			type:'post',
			success:function(xml){
				$(xml).find("row").each(function(){
					var lables = $("#vi_from" + tabStatus + " label");
					//$.each(lables,function(i,n){
					for(var k=0;k<lables.length;k++)
					{
						var tmp = $(lables[k]).attr("for");
						if(tmp=="" || tmp==undefined || tmp==null)
							continue;
						tmp = tmp.replace("Ctrl"+tabStatus+"_vi_","");
						if(tmp=="canloginip")
						{
							var ips = $(this).attr(tmp.toLowerCase());
							if(ips!=undefined)
								ips = ips.replace(/~/g,",");
							setIPDefine(ips,"vi");
							if($.trim(ips)=="")
								ips="~";
							var chargearea = fetchMultiValue("NuserManager.getuserchargearea",6,"&canloginip=" + encodeURIComponent(ips));							
							if(chargearea[0]!=undefined)
								$("#Ctrl1_vi_chargename").html(chargearea.join(","));
						}
						else if(tmp=="userarea")
						{
							$("#Ctrl"+tabStatus+"_vi_"+tmp).html($(this).attr(tmp.toLowerCase()).replace(/~/g,","));
						}
						else if(tmp.toLowerCase()=="last_login")
						{
							$("#Ctrl"+tabStatus+"_vi_Last_login").html($(this).attr(tmp.toLowerCase()));
						}
						else
						{
							$("#Ctrl"+tabStatus+"_vi_"+tmp).html($(this).attr(tmp.toLowerCase()));								
						}
					}	
				});
			}
		});
		
		autoBlockFormAndSetWH("vi_from"+tabStatus,10,10,"vi_from"+tabStatus+"Close","#FFFFFF",false,750,'auto');
	}
	//////////////////////////////////////////////////////////////////////
	/////                     打开修改面板
	/////////////////////////////////////////////////////////////////////
	function openRowModify()
	{
		if($("#editright").val()=="false")
		{
			//alert("你没有修改权限");
			alert("<fmt:message key='userManager.younotchangePermissions' />");
			//return false;
		}
		else
		{
			clearText("cl_from" + tabStatus);
			$(".multiSelectOptions :checkbox:checked").attr("checked",false).parent().removeClass("checked");
			$(".multiSelectOptions :disabled").removeAttr("disabled");
			$(".multiSelect").attr("trueval","");
			$("#Ctrl1_canloginip_tab").html("");
			resetChargeArea();
			toggleBtn(0);
			disablePrimary();
			//生成参数串
			var params = "&userid=" + tsd.encodeURIComponent(arguments[0]);
						
			$("#cl_from"+tabStatus+"modify").data("modifystr",params);
	
			//alert(params);
			//取如参数字段对应的数据
			//var res = fetchMultiArrayValue(pkeys[tabStatus-1]+".queryByKey",2,params);
			delete sourceData;
			sourceData = new Array();
			
			var urlMm = tsd.buildParams({ packgname:'service',
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:'tsdBilling',
				tsdcf:'mssql',//指向配置文件名称
				tsdoper:'query',//操作类型 
				datatype:'xmlattr',//返回数据格式 
				tsdpk:"NuserManager.queryByKey"
				});
			
			$.ajax({
				url:"mainServlet.html?" + urlMm + params + "&tablename=" + tables[tabStatus-1],
				async:false,
				cache:false,
				timeout:1000,
				type:'post',
				success:function(xml){
					$(xml).find("row").each(function(){
						var lables = $("#cl_from" + tabStatus + " label");
						//$.each(lables,function(i,n){
						for(var k=0;k<lables.length;k++)
						{
							var tmp = $(lables[k]).attr("for");
							if(tmp=="" || tmp==undefined || tmp==null)
								continue;
							tmp = tmp.replace("Ctrl"+tabStatus+"_","");
							if(tmp.toLowerCase()=="groupid" || tmp=="userarea")
							{
								//$("#Ctrl"+tabStatus+"_"+tmp+" option[value='"+$.trim($(this).attr(tmp.toLowerCase()))+"']").attr("selected","selected");
								var tmppp = $(this).attr(tmp.toLowerCase());
								if(tmppp=="")
									continue;
									
								var tm4p = [];
								if(tmppp.indexOf("~")>0)
									tm4p = tmppp.split("~");
								else
									tm4p.push(tmppp);
								//alert("#Ctrl"+tabStatus+"_" + tmp);
								var tm5p = null;//保存最后一个checkbox对象
								for(var ii=0;ii<tm4p.length;ii++)
								{
									if(tmp=="groupid")
									{
										$("#Ctrl"+tabStatus+"_" + tmp).next(".multiSelectOptions").find("input:checkbox[value='"+tm4p[ii]+"']").each(function(){
											$(this).attr("checked","checked");//.click().attr("checked","checked");
											$(this).click().attr("checked","checked");
										});
									}
									else if(tmp=="userarea")
									{
										$("#Ctrl"+tabStatus+"_" + tmp).next(".multiSelectOptions").find("label").each(function(){
											if($(this).text()==tm4p[ii]){
												$(this).find(":checkbox:first").attr("checked","checked");//.click().attr("checked","checked");
												tm5p = $(this).find(":checkbox:first");
												if(ii==(tm4p.length-1))
													$(tm5p).click().attr("checked","checked");
											}
										});
									}
								}
								//if(tm5p!=null)
								//$(tm5p).click();
							}
							else if(tmp=="canloginip")
							{
								var ips = $(this).attr(tmp.toLowerCase());
								if(ips!=undefined)
									ips = ips.replace(/~/g,",");
								setIPDefine(ips);
								if($.trim(ips)=="")
									ips="~";
								var ipareas = fetchMultiValue("NuserManager.getuserchargearea",6,"&canloginip="+tsd.encodeURIComponent(ips));
								
								for(var ii=0;ii<ipareas.length;ii++)
								{
									$("#Ctrl"+tabStatus+"_chargename").next(".multiSelectOptions").find("input:checkbox[value='"+ipareas[ii]+"']").each(function(){
										$(this).attr("checked","checked");//.click().attr("checked","checked");
										if(ii==(ipareas.length-1))
											$(this).click().attr("checked","checked");
									});
								}
							}
							else
							{
								$("#Ctrl"+tabStatus+"_"+tmp).val($(this).attr(tmp.toLowerCase()));
								if(tmp=="password")
									$("#Ctrl"+tabStatus+"_"+tmp+"_c").val($(this).attr(tmp.toLowerCase()));
							}
							sourceData[tmp] = $(this).attr(tmp.toLowerCase());
						}	
					});
				}
			});
			
			autoBlockFormAndSetWH("cl_from"+tabStatus,10,10,"cl_from"+tabStatus+"Close","#FFFFFF",false,750,'auto');
		}
	}
	/**
	 *  检测页面输入 数据
	 *  param  
	 *  Return null
	 */
	function validInput()
	{
		
	}
	//////////////////////////////////////////////////////////////////////
	/////                      添加记录
	/////////////////////////////////////////////////////////////////////
	function addForFeilu()
	{	
		var j=0;
		var queryStr = "";
		
		var cuserid = $.trim($("#Ctrl1_userid").val());
		if(cuserid=="")
		{
			//alert("请输入要添加的工号");
			alert("<fmt:message key='userManager.inputJobNumber' />");
			$("#Ctrl1_userid").select().focus();
			return false;
		}
		
		if(cuserid=="admin" || cuserid=="administrator")
		{
			//alert(cuserid + " 为系统限制账号，不允许页面添加");
			alert(cuserid + "<fmt:message key='userManager.CanNotAdd' />");
			$("#Ctrl1_userid").select().focus();
			return false;
		}
		
		var exists = fetchSingleValue("NuserManager.existed",6,"&userid=" + encodeURIComponent(cuserid));
		if(parseInt(exists,10)>0)
		{
			//alert("你所输入的工号已经存在，请重新输入");
			alert("<fmt:message key='userManager.jobNumberExist' />");
			$("#Ctrl1_userid").select().focus();
			return false;
		}
		var cusername = $.trim($("#Ctrl1_username").val());
		if(cusername=="")
		{
			//alert("请输入用户姓名");
			alert("<fmt:message key='userManager.inputUsername' />");
			$("#Ctrl1_username").select().focus();
			return false;
		}
		var cpassword = $.trim($("#Ctrl1_password").val());
		if(cpassword=="")
		{
			//alert("请输入用户密码");
			alert("<fmt:message key='userManager.inputPassword' />");
			$("#Ctrl1_password").select().focus();
			return false;
		}
		var cpasswordv = $("#Ctrl1_password_c").val();
		if(cpasswordv=="")
		{
			//alert("请输入确认密码");
			alert("<fmt:message key='userManager.inputConfirmPassword' />");
			$("#Ctrl1_password_c").select().focus();
			return false;
		}
		if(cpasswordv != cpassword)
		{
			//alert("请确认用户密码,两次输入必须相同");
			alert("<fmt:message key='userManager.ConfirmUserPassword' />");
			$("#Ctrl1_password_c").select().focus();
			return false;
		}
		var cgroupid = $("#Ctrl1_groupid").val();
		if(cgroupid=="")
		{
			//alert("请设置用户所属的权限组");
			alert("<fmt:message key='userManager.setUserGroup' />");
			$("#Ctrl1_groupid").select().focus();
			return false;
		}
		var cdepartname = $("#Ctrl1_departname").val();
		if(cdepartname=="")
		{
			//alert("请设置用户所属的部门");
			alert("<fmt:message key='userManager.setUserDepartment' />");
			$("#Ctrl1_departname").select().focus();
			return false;
		}
		var cuserarea = $("#Ctrl1_userarea").val();
		if(cuserarea=="")
		{
			//alert("请设置用户所属的业务区域");
			alert("<fmt:message key='userManager.setUserArea' />");
			$("#Ctrl1_userarea").select().focus();
			return false;
		}
		var cemail = $("#Ctrl1_email").val();
		if(cemail!="" && !/\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/.test(cemail))
		{
			//alert("请输入正确格式的EMail地址");
			alert("<fmt:message key='userManager.inputEMailAddress' />");
			$("#Ctrl1_email").select().focus();
			return false;
		}
			
		//日志信息
		var loginfo = "";
		
		//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
		
		loginfo += tsd.encodeURIComponent(mNames[tabStatus-1]);
		loginfo += ";TableName:";
		loginfo += tables[tabStatus-1];
		loginfo += ";";

		//拼接参数串
		var lables = $("#cl_from" + tabStatus + " label");
		//$.each(lables,function(i,n){
		for(var k=0;k<lables.length;k++)
		{
			var tmp = $(lables[k]).attr("for");
			//去除multiSelect生成的label
			if(tmp==null || tmp==undefined || tmp=="")
				continue;
			var dtype = $("#"+tmp).attr("dtype");
			var tvalue = $("#" + tmp).val();
			var dfield = tmp.replace("Ctrl" + tabStatus + "_","");
			if(dfield=="groupid")
			{
				tvalue = $("#" + tmp).attr("trueval").replace(/,/g,"~");
			}
			else if(dfield=="userarea")
			{
				tvalue = tvalue.replace(/,/g,"~");
			}
			
			if(dtype!=undefined)
			{
				if((dtype=="integer" || dtype=="double") && tvalue=="")
				{
					tvalue = "0";
				}
				if(!regularExp[dtype].test(tvalue))
				{
					//alert($.trim($(lables[k]).text()) + "数据格式不正确,必须为有效的" + getType(dtype) + ".");
					alert($.trim($(lables[k]).text()) + "<fmt:message key='userManager.DataTypeisError' />" + getType(dtype) + ".");
					
					$("#"+tmp).select();
					$("#"+tmp).focus();
					return false;
				}
			}
			
			//如果是计费类别费率减免的备注 默认为空格
			
			queryStr += "&";
			queryStr += tmp.replace("Ctrl"+tabStatus+"_","");
			queryStr += "=";
			queryStr += tsd.encodeURIComponent(tvalue);
			
			
			loginfo += tsd.encodeURIComponent(Dat.getFieldAliasByFieldName(tmp.replace("Ctrl"+tabStatus+"_","")));
			loginfo += ":";
			loginfo += tsd.encodeURIComponent(tvalue)
			loginfo += ";";
			
		}
		
		if(tsd.Qualified()==false){return false;}
		
		var res = executeNoQuery("NuserManager.add",6,queryStr);
		
		if(res=="true"||res==true)
		{
			alert("<fmt:message key='global.successful' />");
			
			writeLogInfo("","add",loginfo);
		}
		
		$("#editgrid").trigger("reloadGrid");
		clearText("cl_from"+tabStatus);
		$(".multiSelectOptions :checkbox:checked").attr("checked",false).parent().removeClass("checked");
		$(".multiSelectOptions :disabled").removeAttr("disabled");
		$(".multiSelect").attr("trueval","");
		resetChargeArea();
		$("#Ctrl1_canloginip_tab").html("");
		//第一个主键输入框获得焦点
		$("#Ctrl"+tabStatus+"_userid").select().focus();		
		
		return true;
	}
	//保存退出函数
	function addForExit()
	{
		var res = addForFeilu();
		if(res) setTimeout($.unblockUI, 15);
	}
	
	function getType(type)
	{
		if(type=="integer")
		{
			//return "整数";
			return "<fmt:message key='userManager.integer' />";
		}
		else if(type=="double")
		{
			//return "数字";
			return "<fmt:message key='userManager.number' />";
		}
		if(type=="datetime")
		{
			//return "日期";
			return "<fmt:message key='userManager.date' />";
		}
		else
		{
			//return "字符串";
			return "<fmt:message key='userManager.string' />";
		}
	}
	/////修改数据
	function ModifyData()
	{
		var cusername = $.trim($("#Ctrl1_username").val());
		if(cusername=="")
		{
			//alert("请输入用户姓名");
			alert("<fmt:message key='userManager.inputUsername' />");
			$("#Ctrl1_username").select().focus();
			return false;
		}
		var cpassword = $.trim($("#Ctrl1_password").val());
		if(cpassword=="")
		{
			//alert("请输入用户密码");
			alert("<fmt:message key='userManager.inputPassword' />");
			$("#Ctrl1_password").select().focus();
			return false;
		}
		var cpasswordv = $("#Ctrl1_password_c").val();
		if(cpasswordv=="")
		{
			//alert("请输入确认密码");
			alert("<fmt:message key='userManager.inputConfirmPassword' />");
			$("#Ctrl1_password_c").select().focus();
			return false;
		}
		if(cpasswordv != cpassword)
		{
			//alert("请确认用户密码,两次输入必须相同");
			alert("<fmt:message key='userManager.ConfirmUserPassword' />");
			$("#Ctrl1_password_c").select().focus();
			return false;
		}
		var cgroupid = $("#Ctrl1_groupid").val();
		if(cgroupid=="")
		{
			//alert("请设置用户所属的权限组");
			alert("<fmt:message key='userManager.setUserGroup' />");
			$("#Ctrl1_groupid").select().focus();
			return false;
		}
		var cdepartname = $("#Ctrl1_departname").val();
		if(cdepartname=="")
		{
			//alert("请设置用户所属的部门");
			alert("<fmt:message key='userManager.setUserDepartment' />");
			$("#Ctrl1_departname").select().focus();
			return false;
		}
		var cuserarea = $("#Ctrl1_userarea").val();
		if(cuserarea=="")
		{
			//alert("请设置用户所属的业务区域");
			alert("<fmt:message key='userManager.setUserArea' />");
			$("#Ctrl1_userarea").select().focus();
			return false;
		}
		var cemail = $("#Ctrl1_email").val();
		if(cemail!="" && !/\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/.test(cemail))
		{
			//alert("请输入正确格式的EMail地址");
			alert("<fmt:message key='userManager.inputEMailAddress' />");
			$("#Ctrl1_email").select().focus();
			return false;
		}
		//alert("O:"+ObuildParams());
		//return false;
		
		//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
		
		//修改参数
		var querystr = "";
		
		//日志信息
		var loginfo = "";
		
		loginfo += tsd.encodeURIComponent(mNames[tabStatus-1]);
		loginfo += ";TableName:";
		loginfo += tables[tabStatus-1];
		loginfo += ";";
		
		var modifystr = $("#cl_from"+tabStatus+"modify").data("modifystr");
		
		
		//拼接参数串
		var lables = $("#cl_from" + tabStatus + " label");
		//$.each(lables,function(i,n){
		for(var k=0;k<lables.length;k++)
		{
			var tmp = $(lables[k]).attr("for");
			
			//去除multiSelect生成的label
			if(tmp==null || tmp==undefined || tmp=="")
				continue;
			
			var dtype = $("#"+tmp).attr("dtype");
			var tvalue = $("#" + tmp).val();
							
			if(dtype!=undefined)
			{
				if((dtype=="integer" || dtype=="double") && tvalue=="")
				{
					tvalue = "0";
				}
				if(!regularExp[dtype].test(tvalue))//格式验证
				{
					//alert($.trim($(lables[k]).text()) + "数据格式不正确,必须为有效的" + getType(dtype) + ".");
					alert($.trim($(lables[k]).text()) + "<fmt:message key='userManager.DataTypeisError' />" + getType(dtype) + ".");
					$("#"+tmp).select();
					$("#"+tmp).focus();
					return false;
				}					
			}
			
			var fieldname = tmp.replace("Ctrl"+tabStatus+"_","");
			
			if(fieldname=="groupid")
			{
				tvalue = $("#" + tmp).attr("trueval").replace(/,/g,"~");
			}
			else if(fieldname=="userarea")
			{
				tvalue = tvalue.replace(/,/g,"~");
			}
			
			//如果是计费类别费率减免的备注 默认为空格
			
			//拼参数
			querystr += "&";
			querystr += fieldname;
			querystr += "_v=";
			querystr += tsd.encodeURIComponent(tvalue);
		
			//记录有修改的字段
			if(tvalue!=sourceData[fieldname])
			{
				loginfo += tsd.encodeURIComponent(Dat.getFieldAliasByFieldName(fieldname));
				loginfo += ":";
				loginfo += tsd.encodeURIComponent(sourceData[fieldname]);
				loginfo += ">>>";
				loginfo += tsd.encodeURIComponent(tvalue);
				loginfo += ";";
			}
		}
		
		if(tsd.Qualified()==false){return false;}		
								
		var res = executeNoQuery("NuserManager.modify",6,querystr+modifystr);
		if(res=="true"||res==true)
		{
			//alert("修改数据成功");
			alert("<fmt:message key='userManager.modifyDataSuccess' />");				
			writeLogInfo("","modify",loginfo);
		}
		setTimeout($.unblockUI, 15);//关闭面板
		$("#editgrid").trigger("reloadGrid");//重新加载数据
	
	}
	/////删除记录
	function deleteRow()
	{
		if(arguments[0]=="admin" || arguments[0]=="administrator" )
		{
			//alert("超级管理员用户不允许删除");
			alert("<fmt:message key='userManager.userIsAdmin' />");
			return;
		}
		if($("#deleteright").val()=="false")
		{
			//alert("你没有删除权限");
			alert("<fmt:message key='userManager.youcantdelete' />");
			//return false;
		}
		else
		{//生成参数串
			var params = "&userid="+tsd.encodeURIComponent(arguments[0]);
			
			//删除
			//if(confirm("你确定要删除本条记录吗?"))
			if(confirm("<fmt:message key='userManager.youSuerDelete' />"))
			{
				var res = executeNoQuery("NuserManager.deleteByKey",6,params);
				if(res==true || res=="true")
				{
					//记日志
					var loginfo = "";			
					loginfo += mNames[tabStatus-1];
					loginfo += ";TableName:";
					loginfo += tables[tabStatus-1];
					loginfo += ";";
					loginfo = tsd.encodeURIComponent(loginfo);
					
					//工号
					params = tsd.encodeURIComponent("<fmt:message key='userManager.jobNUM' />");
					params += tsd.encodeURIComponent(arguments[0]);
					
					loginfo = loginfo + params;
					
					writeLogInfo("","delete",loginfo);
					//重新加载数据
					$("#editgrid").trigger("reloadGrid");
				}
				else
				{
					//alert("删除失败");
				}
			}
			
		}
	}
	////////////////////////////////////////////////////////////////////////////////
	//////					打开添加面板
	///////////////////////////////////////////////////////////////////////////////	
	function openAddForm()
	{
		makeAllEnabled();
		toggleBtn(1);
		$(".multiSelectOptions :checkbox:checked").attr("checked",false).parent().removeClass("checked");
		$(".multiSelectOptions :disabled").removeAttr("disabled");
		$(".multiSelect").attr("trueval","");
		resetChargeArea();
		$("#Ctrl1_canloginip_tab").html("");
		clearText("cl_from"+tabStatus);
		
		autoBlockFormAndSetWH("cl_from"+tabStatus,10,10,"cl_from"+tabStatus+"Close","#FFFFFF",false,750,'auto');
		//$("#Ctrl"+tabStatus+"_Xuhao").focus();
	}
	
	////////////////////////////////////////////////////////////////////////////////
	//////					打开查询面板
	///////////////////////////////////////////////////////////////////////////////	
	function openSearchForm()
	{
		clearText("se_from"+tabStatus);
		$(".multiSelectOptions :checkbox:checked").attr("checked",false).parent().removeClass("checked");
		$(".multiSelectOptions :disabled").removeAttr("disabled");
		$(".multiSelect").attr("trueval","");
		resetChargeArea();
		$("#Ctrl1_canloginip_tab").html("");
		autoBlockFormAndSetWH("se_from"+tabStatus,10,10,"se_from"+tabStatus+"Close","#FFFFFF",false,750,'auto');
		
	}
	
	
	////////////////////////////////////////////////////////////////////////////
	////                          条件排序
	///////////////////////////////////////////////////////////////////////////
	function zhOrderExe(sqlstr){
		
		var params ='&orderby='+sqlstr + "&tablename=" + tables[tabStatus-1];	
		
		var tparam = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
		if(tparam=='&fusearchsql='){
			tparam ='&fusearchsql=1=1';
		}			    
	 	
	 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:"NuserManager.queryByOrder",//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  tsdpkpagesql:'NuserManager.queryByOrderpage'
									});
		var fileds = "," + Dat.FieldName.join(",") + ",";
		fileds = fileds.replace(",groupid,",",getMultiValues(groupid,'sys_powergroup','groupid','groupname') groupid,");
		fileds = fileds.replace(",limitlogin,",",case limitlogin when 'true' then '是' when 'false' then '否' else limitlogin end limitlogin,");		
		fileds = fileds.replace(",logined,",",case logined when 'true' then '是' when 'false' then '否' else logined end logined,");
		fileds = fileds.substring(1,fileds.length-1);
		fileds = tsd.encodeURIComponent(fileds);
		var link = urlstr1 + params  + "&cols=" + fileds  + "&cols1=" + Dat.FieldName.join(",") + tparam;
					
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
	 	//setTimeout($.unblockUI, 15);//关闭面板		 	
	}
	
	function openSearch()
	{
		//$("#queryName").val("查询");
		$("#queryName").val("<fmt:message key='userManager.query' />");
		showDialog(1);
	}
	
	function openBatchDelete()
	{
		//$("#queryName").val("删除");
		$("#queryName").val("<fmt:message key='userManager.delete' />");
		showDialog(1);
	}
	
	function openBatchEdit()
	{
		//$("#queryName").val("修改");
		$("#queryName").val("<fmt:message key='userManager.modify' />");
		showDialog(1);
	}
	///////批操作
	function fuheExe()
	{
		var queryName= document.getElementById("queryName").value;
		if(queryName=="query")
		{
			fuheQuery();
		}
		else if(queryName=="queryset")
		{
			$("#Ctrl1_wheresql").val($("#fusearchsql").val().replace(/'/g,"\""));
			$("#Ctrl1_wheredesc").val($("#fusearchdesciption").val());
		}
	}
	
	
	/////复合查询
	function fuheQuery()
	{
		var params = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
		if(params=='&fusearchsql='){
			params +='1=1';
		}				
	 	
	 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:'NuserManager.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  tsdpkpagesql:'NuserManager.fuheQueryByWherepage'
									});
		var fileds = "," + Dat.FieldName.join(",") + ",";
		fileds = fileds.replace(",groupid,",",getMultiValues(groupid,'sys_powergroup','groupid','groupname') groupid,");
		fileds = fileds.replace(",limitlogin,",",case limitlogin when 'true' then '"+"<fmt:message key='userManager.yes' />"+"' when 'false' then '"+"<fmt:message key='userManager.no' />"+"' else limitlogin end limitlogin,");		
		fileds = fileds.replace(",logined,",",case logined when 'true' then '"+"<fmt:message key='userManager.yes' />"+"' when 'false' then '"+"<fmt:message key='userManager.no' />"+"' else logined end logined,");
		fileds = fileds.substring(1,fileds.length-1);
		fileds = tsd.encodeURIComponent(fileds);
		var link = urlstr1 + params + "&cols=" + fileds + "&cols1=" + Dat.FieldName.join(",") + "&tablename=" + tables[tabStatus-1];
		
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
	 	setTimeout($.unblockUI, 15);//关闭面板			
	}
	
	//////////////////
	function setUserRight()
	{
		//alert($("#skrid").val()+":"+$("#imenuid").val()+":"+$("#zid").val());
		var allRi = fetchMultiPValue("set1Rate.getPower",6,"&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
		
		if(typeof allRi == 'undefined' || allRi.length == 0)
		{
			//alert("取权限失败");
			return false;
		}
		if(allRi[0][0]=="all")
		{
			return true;
		}
		var addright = "false";
		
		var deleteright = "false";
		var editright = "false";
		
		var exportright = "false";
		var printright = "false";
		
		var queryright = "false";
		var saveQueryMright = "false";
				
		for(var i = 0;i<allRi.length;i++){
			if(getCaption(allRi[i][0],'add','')=="true")
				addright = "true";
			if(getCaption(allRi[i][0],'delete','')=="true")
				deleteright = "true";
			if(getCaption(allRi[i][0],'edit','')=="true")							
				editright = "true";
			if(getCaption(allRi[i][0],'export','')=="true")
				exportright = "true" ;
			if(getCaption(allRi[i][0],'print','')=="true")
				printright = "true";
				
			if(getCaption(allRi[i][0],'query','')=="true")
				queryright = "true";
				
			if(getCaption(allRi[i][0],'saveQueryM','')=="true")
				saveQueryMright = "true";
		}
		//alert(addright+":"+delBright+":"+editBright);
		$("#addright").val(addright);
		
		if(addright=="false")
		{
			$("#openadd1").attr("disabled","disabled");
			$("#openadd2").attr("disabled","disabled");
		}
				
		$("#editright").val(editright);
		$("#deleteright").val(deleteright);
		
		$("#exportright").val(exportright);
		$("#printright").val(printright);
		if(exportright=="false")
		{
			$("#export1").attr("disabled","disabled");
			$("#export2").attr("disabled","disabled");
		}
		if(printright=="false")
		{
			$("#print1").attr("disabled","disabled");
			$("#print2").attr("disabled","disabled");
		}
		
		if(queryright="false")
		{
			
			$("#gjcx1").attr("disabled","disabled");
			$("#gjcx2").attr("disabled","disabled");
		}
		
		
		if(saveQueryMright="false")
		{
			$("#savequery1").attr("disabled","disabled");
			$("#savequery2").attr("disabled","disabled");
		}
		//alert(editright+":"+deleteright+":"+exportright);
	}
	
	
	////////////////////////////////////////////////////////////////////////////
	///////////////////////////                下载文件
	///////////////////////////////////////////////////////////////////////////
	function DownFile()
	{
	
		thisDownLoad('tsdBilling','mssql',tables[tabStatus-1],$("#lanType").val(),5);
	}
	
	
	function DownSure()
	{
	
		getTheCheckedFields('tsdBilling','mssql',tables[tabStatus-1]);
	}
	
	function getDefineSql()
	{
		var tablename = $("#Ctrl1_tablename").val();
		if(tablename=="")
		{
			//alert("请选择要设置的表名");
			alert("<fmt:message key='userManager.setTableName' />");
			$("#Ctrl1_tablename").select().focus();
			return false;
		}
		openDiaQueryG('queryset',tablename);
	}
	
	////////////////////////////////////////////////////////////////////////////
	///////////////////////////                打印报表
	///////////////////////////////////////////////////////////////////////////
	function printR()
	{
		var params = ''+$("#fusearchsql").val();			
		if(params==''){
			params ='1=1';
		}
		printThisReport("set1rate" + tables[tabStatus-1],"&fusearchsql="+encodeURIComponent(cjkEncode($.trim(params))));
	}
	
	//保存本次高级查询方法
	function addQuery(){
		saveModQuery(tabStatus);
	}
	
	//模板查询你
	function modQuery(){
		 openQueryM(tabStatus);
	}
	
	function FeeTypeChange(obj)
	{
		if(obj.value=="<fmt:message key='userManager.broadband' />")
		{
			$("#Ctrl1_Lbl_Dh").text("<fmt:message key='userManager.InternetAccount' />");
		}
		else
		{
			$("#Ctrl1_Lbl_Dh").text("<fmt:message key='userManager.TelNumber' />");
		}
	}
	
	/** 简单查询
	 *  @param
	 *  @return
	 *
	 */
	function SimpleSearch()
	{
		var queryStr = "";
		//拼接参数串
		var lables = $("#se_from" + tabStatus + " label");
		//$.each(lables,function(i,n){
		for(var k=0;k<lables.length;k++)
		{
			var tmp = $(lables[k]).attr("for");
			if(tmp=="" || tmp==undefined || tmp==null)
				continue;
			var dtype = $("#"+tmp).attr("dtype");
			var tvalue = $("#"+tmp).val();
			
			
			//if(tvalue!="" && tvalue!=null && tvalue!='请选择')
			if(tvalue!="" && tvalue!=null && tvalue!="<fmt:message key='userManager.select' />")
			{
				if(dtype!=undefined && !regularExp[dtype].test(tvalue))
				{
					//alert($.trim($(lables[k]).text()) + "数据格式不正确,必须为有效的" + getType(dtype) + ".");
					alert($.trim($(lables[k]).text()) + "<fmt:message key='userManager.DataTypeisError' />" + getType(dtype) + ".");
					
					$("#"+tmp).select();
					$("#"+tmp).focus();
					return false;
				}
				
				queryStr += " and ";
				queryStr += tmp.replace("Ctrl"+tabStatus+"_Sel_","");
				
				queryStr += " = ";				
				
				if(dtype==undefined)
					queryStr += "'";
				
				tsd.QualifiedVal=true;	
				queryStr += tvalue;
				if(tsd.Qualified()==false){$("#"+tmp).select();$("#"+tmp).focus();return false;}
				
				if(dtype==undefined)
					queryStr += "'";
				
			}
		}
		queryStr = $.trim(queryStr);
		if(queryStr=="")
		{
			//alert("请至少提供一个查询条件");
			alert("<fmt:message key='userManager.inputInquiresTheConditions' />");
			return false;
		}
		//去第一个逗号
		queryStr = queryStr.replace("and","");
		
		$("#fusearchsql").val(queryStr);		
		fuheQuery();
	}
	
	/** 弹出接触锁定用户面板
	 *  @param
	 *  @return
	 *
	 */
	function unlockUser()
	{
		var res = $("#editgrid").getGridParam("selrow");
		if(res!=null)
		{
			var uid = $("#editgrid").getCell(res,"userid");
			$("#Ctrl1_lk_userid").val(uid);
		}
		autoBlockFormAndSetWH("lk_from"+tabStatus,10,10,"lk_from"+tabStatus+"Close","#FFFFFF",false,750,'auto');
	}
	/** 解锁用户
	 *  @param
	 *  @return
	 *
	 */
	function userUnlock()
	{
		var cuserid = $.trim($("#Ctrl1_lk_userid").val());
		if(cuserid=="")
		{
			//alert("请输入要操作的工号");
			alert("<fmt:message key='userManager.inputOperationJobNumber' />");
			$("#Ctrl1_lk_userid").select().focus();
			return;
		}
		var exists = fetchSingleValue("NuserManager.existed",6,"&userid=" + encodeURIComponent(cuserid));
		if(parseInt(exists,10)==0)
		{
			//alert("你所输入的工号不存在，请重新输入");
			alert("<fmt:message key='userManager.jobNumberNotExist' />");
			$("#Ctrl1_userid").select().focus();
			return false;
		}
		
		var cval = $("#Ctrl1_lk_state").val();
		
		var res = executeNoQuery("NuserManager.unlockuser",6,"&state=" + cval + "&userid="+ tsd.encodeURIComponent(cuserid));
		if(res=="true" || res==true)
		{
			//alert("操作成功");
			alert("<fmt:message key='userManager.OperationSuccess' />");
			$("#editgrid").trigger("reloadGrid");
		}
		else
		{
			//alert("操作失败");
			alert("<fmt:message key='userManager.OperationFailed' />");
		}
		setTimeout($.unblockUI,200);
	}
	</script>
</head>

<body> 
<form name="childform" id="childform">
	<input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
	<input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
	<input type="text" id="fusearchdesciption" name="fusearchdesciption" style="display: none"/>
</form>

<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 

<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
<!-- 语言 -->
<input type="hidden" id="lanType" name="lanType" value='<%=lanType %>' />

<input type="hidden" id="skrid" name="skrid" value='<%=request.getSession().getAttribute("userid") %>' />

<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
<input type="hidden" name="languageType" id="languageType" value='<%=lanType %>' />
  	<div id="navBar">
		<img src="style/icon/dot11.gif" style="margin-left: 10px" />
		<fmt:message key="global.location" />
		:		
	</div>
  	<!-- 资费设置导航条-->
	<div id='tariffBar' style="font-size: 14px; text-align: left;">
	</div>
  	
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="openorder1" onclick="openDiaO('sys_user');">
			<!--排序--><fmt:message key="order.title" />
		</button>		
		<button type="button" id="openadd1" onclick="openAddForm()">
			<!--添加--><fmt:message key="global.add" />
	    </button>
	    <button type="button" onclick="openSearchForm()">
			<!--查询-->
			<fmt:message key="global.query" />
		</button>
		<button onclick='modQuery()' id='mbquery1'>
				<fmt:message key="oper.mod"/>
		</button>
	   <button type="button" id="gjcx1" onclick="openDiaQueryG('query','sys_user');">
			<!--高级查询--><fmt:message key="oper.queryA" />
		</button>
		<button type="button" id='savequery1' onclick="openModT()">
				<fmt:message key="oper.modSave"/>
		</button>
		<button type="button" id="export1" onclick="DownFile()"> 
			<!--导出--><fmt:message key="global.exportdata" />
		</button>
		<button type="button" id="unlockuser1" onclick="unlockUser()">
			<!--解除锁定--><fmt:message key="userManager.removeLock" />
		</button>
	</div>
	
	<div id="gridd">
	    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>
	</div>

	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="openorder2" onclick="openDiaO('sys_user');">
			<!--排序--><fmt:message key="order.title" />
		</button>		
		<button type="button" id="openadd2" onclick="openAddForm()">
			<!--添加--><fmt:message key="global.add" />
	    </button>
	    <button type="button" onclick="openSearchForm()">
			<!--查询-->
			<fmt:message key="global.query" />
		</button> 
		<button onclick='modQuery()' id='mbquery2'>
				<fmt:message key="oper.mod"/>
		</button>
	   <button type="button" id="gjcx2" onclick="openDiaQueryG('query','sys_user');">
			<!--高级查询--><fmt:message key="oper.queryA" />
		</button>
		<button type="button" id='savequery2' onclick="openModT()">
				<fmt:message key="oper.modSave"/>
		</button>
		<button type="button" id="export2" onclick="DownFile()"> 
			<!--导出--><fmt:message key="global.exportdata" />
		</button>
		<button type="button" id="unlockuser2" onclick="unlockUser()"> 
			解除锁定
		</button>
	</div>
	
	
	<!-- Number 1 一 -->
	<form class="neirong" id="cl_from1" style="display:none;width:720px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<!-- 工号管理 --><fmt:message key="userManager.jobNumberManager" />
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#cl_from1Close').click();">
					<!-- 关闭 --><fmt:message key="userManager.close" />
					</a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;overflow-x:hidden;">
			<table style="width:100%">
				<tr>
					<td class="labelclass" width="16%;">
						<label for="Ctrl1_userid"><!-- 工号 -->
							<span id="Ctrl1_Lbl_userid"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">					
						<input type="text" id="Ctrl1_userid" class="textclass" />						
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_username"><!-- 姓名 -->
							<span id="Ctrl1_Lbl_username"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input name="Ctrl1_username" id="Ctrl1_username" class="textclass"  />   
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_password"><!-- 密码 -->
							<span id="Ctrl1_Lbl_password"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="password" name="Ctrl1_password" id="Ctrl1_password" class="textclass" />
					</td>
					<td class="labelclass" width="16%">
						<span id="Ctrl1_Lbl_password_c">
						<!-- 确认密码 --><fmt:message key="userManager.ConfirmPassword" />
						</span>
					</td>
					<td width="34%" class="tdstyle">
						<input type="password" name="Ctrl1_password_c" id="Ctrl1_password_c" class="textclass" />			
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_groupid"><!-- 权限组  -->
							<span id="Ctrl1_Lbl_groupid"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl1_groupid" id="Ctrl1_groupid" class="textclass"></select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_departname"><!-- 部门  -->
							<span id="Ctrl1_Lbl_departname"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl1_departname" id="Ctrl1_departname" class="textclass"></select>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_userarea"><!-- 管理区域  -->
							<span id="Ctrl1_Lbl_userarea"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl1_userarea" id="Ctrl1_userarea" class="textclass"></select>
					</td>
					<td class="labelclass" width="16%">
						<span id="Ctrl1_Lbl_DEFAREAs">
						<!-- 营业区域 --><fmt:message key="userManager.BusinessArea" />
						</span>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl1_chargename" id="Ctrl1_chargename" class="textclass">
							<option value="">
							<!-- 请选择 -->
							<fmt:message key="userManager.choose" />
							</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_canloginip"><!-- 可登陆IP  -->
							<span id="Ctrl1_Lbl_canloginip"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle" colspan="3">
						<textarea name="Ctrl1_canloginip" id="Ctrl1_canloginip" class="textclass" style="display:none;"></textarea>
						<div id="Ctrl1_canloginip_tab_container"><table id="Ctrl1_canloginip_tab"></table></div>
						<button onclick="openIPDefinePanel('')" class="tsdbutton" style="line-height:18px;">
							<!-- 编辑IP地址 -->
							<fmt:message key="userManager.editorIPAddress" />
						</button>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_linktel"><!-- 联系电话  -->
							<span id="Ctrl1_Lbl_linktel"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_linktel" id="Ctrl1_linktel" class="textclass" />
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_email"><!-- EMail  -->
							<span id="Ctrl1_Lbl_email"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_email" id="Ctrl1_email" class="textclass" />
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_limitlogin"><!-- 限制登陆  -->
							<span id="Ctrl1_Lbl_limitlogin"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl1_limitlogin" id="Ctrl1_limitlogin" class="textclass">
							<option value="true">
							<!-- 是 -->
							<fmt:message key="userManager.yes" />
							</option>
							<option value="false" selected="selected">
							<!-- 否 -->
							<fmt:message key="userManager.no" />
							</option>
						</select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_logined"><!-- 登陆状态  -->
							<span id="Ctrl1_Lbl_logined"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl1_logined" id="Ctrl1_logined" class="textclass">
							<option value="true">
								<!-- 是 -->
								<fmt:message key="userManager.yes" />
							</option>
							<option value="false" selected="selected">
								<!-- 否 -->
								<fmt:message key="userManager.no" />
							</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_DEFAREA"><!-- 备注  -->
							<span id="Ctrl1_Lbl_DEFAREA"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl1_DEFAREA" id="Ctrl1_DEFAREA" class="textclass">
							
						</select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_bz"><!-- 备注  -->
							<span id="Ctrl1_Lbl_bz"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<textarea name="Ctrl1_bz" id="Ctrl1_bz" class="textclass" style="width:200px;height:36px;"></textarea>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="cl_from1save" onclick="addForFeilu()">
				<!-- 保存添加 -->
				<fmt:message key="userManager.saveAndAdd" />
			</button>
			<button type="button" class="tsdbutton" id="cl_from1exit" onclick="addForExit()">
				
				<!-- 保存退出 -->
				<fmt:message key="userManager.saveAndclose" />
			</button>
			<button type="button" class="tsdbutton" id="cl_from1modify" onclick="ModifyData()">
				<!-- 修改 -->
				<fmt:message key="userManager.modify" />
			</button>
			<button type="button" class="tsdbutton" id="cl_from1search" onclick="SimpleSearch()">
				<!-- 查询 -->
				<fmt:message key="userManager.query" />
			</button>
			<button type="button" class="tsdbutton" id="cl_from1Close">
				<!-- 关闭 -->
				<fmt:message key="userManager.close" />
			</button>
		</div>
	</form>
		
	<!-- Number 1 一 Search -->
	<form class="neirong" id="se_from1" style="display:none;width:720px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<!-- 工号管理 简单查询 -->
						<fmt:message key="userManager.jobNumberManagerAndquery" />
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#se_from1Close').click();"><fmt:message key="userManager.close" /></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;overflow-x:hidden;">
			<table style="width:100%">
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_Sel_userid"><!-- 工号 -->
							<span id="Ctrl1_Sel_Lbl_userid"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_Sel_userid" id="Ctrl1_Sel_userid" class="textclass" />
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_Sel_username"><!-- 姓名 -->
							<span id="Ctrl1_Sel_Lbl_username"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_Sel_username" id="Ctrl1_Sel_username" class="textclass" />
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="se_from1search" onclick="SimpleSearch()">
				<!-- 查询 -->
				<fmt:message key="userManager.query" />
			</button>
			<button type="button" class="tsdbutton" id="se_from1Close">
				<!-- 关闭 -->
				<fmt:message key="userManager.close" />
			</button>
		</div>
	</form>
	
	<form class="neirong" id="lk_from1" style="display:none;width:720px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<!-- 工号解锁与锁定 -->
						<fmt:message key="userManager.jobNumberLock" />
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#lk_from1Close').click();"><fmt:message key="userManager.close" /></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;overflow-x:hidden;">
			<table style="width:100%">
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_lk_userid"><!-- 工号 -->
							<span id="Ctrl1_lk_Lbl_userid"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_lk_userid" id="Ctrl1_lk_userid" class="textclass" />
					</td>
					<td class="labelclass" width="16%">
						<!-- <span id="Ctrl1_lk_Lbl_state">状态</span> -->
						<span id="Ctrl1_lk_Lbl_state"><fmt:message key="userManager.state" /></span>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl1_lk_state" id="Ctrl1_lk_state" class="textclass">
							<!-- 解除锁定 锁定工号-->		
							<option value="false"><fmt:message key="userManager.removeLock" /></option>
							<option value="true"><fmt:message key="userManager.LockJobNumber" /></option>
						</select>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="lk_from1search" onclick="userUnlock()">
				<!-- 确定 -->
				<fmt:message key="userManager.sure" />
			</button>
			<button type="button" class="tsdbutton" id="lk_from1Close">
				<!-- 关闭 -->
				<fmt:message key="userManager.close" />
			</button>
		</div>
	</form>
	
	<!-- Number 1 一 -->
	<form class="neirong" id="vi_from1" style="display:none;width:720px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<!-- 工号管理 详细信息 -->
						<fmt:message key="userManager.jobNumberManagerAndMsg" />
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#vi_from1Close').click();">
					<!-- 关闭 -->
					<fmt:message key="userManager.close" />
					</a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;overflow-x:hidden;">
			<table style="width:100%">
				<tr>
					<td class="labelclass" width="16%;">
						<label for="Ctrl1_vi_userid"><!-- 工号 -->
							<span id="Ctrl1_vi_Lbl_userid"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">					
						<span id="Ctrl1_vi_userid"></span>						
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_username"><!-- 姓名 -->
							<span id="Ctrl1_vi_Lbl_username"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_username"></span>   
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_password"><!-- 密码 -->
							<span id="Ctrl1_vi_Lbl_password"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_password"></span>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_last_login"><!-- 上次登陆 -->
							<!-- <span id="Ctrl1_vi_Lbl_Last_login">上次登陆</span> -->
							<span id="Ctrl1_vi_Lbl_Last_login"><fmt:message key="userManager.lastLanding" /></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_Last_login"></span>			
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_groupid"><!-- 权限组  -->
							<span id="Ctrl1_vi_Lbl_groupid"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_groupid" ></span>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_departname"><!-- 部门  -->
							<span id="Ctrl1_vi_Lbl_departname"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_departname"></span><span style="display:inline-block;visibility:hidden">1</span>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_userarea"><!-- 管理区域  -->
							<span id="Ctrl1_vi_Lbl_userarea"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_userarea"></span>
					</td>
					<td class="labelclass" width="16%">
						<span id="Ctrl1_vi_Lbl_chargename"></span>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_chargename"></span><span style="display:inline-block;visibility:hidden">1</span>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_canloginip"><!-- 可登陆IP  -->
							<span id="Ctrl1_vi_Lbl_canloginip"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle" colspan="3">
						<span id="Ctrl1_vi_canloginip"></span>
						<div id="Ctrl1_vi_canloginip_tab_container"><table id="Ctrl1_vi_canloginip_tab"></table></div>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_linktel"><!-- 联系电话  -->
							<span id="Ctrl1_vi_Lbl_linktel"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_linktel"></span>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_email"><!-- EMail  -->
							<span id="Ctrl1_vi_Lbl_email"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_email"></span><span style="display:inline-block;visibility:hidden">1</span>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_limitlogin"><!-- 限制登陆  -->
							<span id="Ctrl1_vi_Lbl_limitlogin"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_limitlogin"></span>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_logined"><!-- 登陆状态  -->
							<span id="Ctrl1_vi_Lbl_logined"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_logined"></span>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_DEFAREA"><!-- 备注  -->
							<span id="Ctrl1_vi_Lbl_DEFAREA"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_DEFAREA"></span><span style="display:inline-block;visibility:hidden">1</span>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_bz"><!-- 备注  -->
							<span id="Ctrl1_vi_Lbl_bz"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_bz"></span><span style="display:inline-block;visibility:hidden">1</span>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="vi_from1Close">
				<fmt:message key="userManager.close" />
			</button>
		</div>
	</form>	
	
	<!-- 添加模板面板 -->
	<div id="modT" name='modT' style="display: none"  class="neirong">
		<br/>
		<div class="top">
		<div class="top_01">
				<div class="top_01left">
					<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
					<div class="top_03" >
					<!-- 功能名称 -->
					<fmt:message key="userManager.functionName"/>
					</div>
					<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
				</div>
				<div class="top_01right"><a href="#" onclick="closeoMod()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
			</div>
		<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
		</div>
			<div class="midd" >
			<form id='addquery' name="addquery" onsubmit="return false;" action="#" >
				<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
				
				  	<tr >
					    <td width="12%" align="right" class="labelclass"><label id="nameg_mod"><fmt:message key="oper.modName"/></label></td>							
					    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
					    	<input type="text" name="name_mod" id="name_mod" onpropertychange="TextUtil.NotMax(this)" maxlength="50" class="textclass"/>
					    	
					    	<font style="color: #ff0000;">*</font></td>
					    
					    <td width="12%" align="right"  class="labelclass"><label id=''></label></td>
					    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
										    
					     <td width="12%" align="right"  class="labelclass"></td>
				    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
				    	
				 	 </tr>	
			  
				</table>
			</form>	
			<div class="midd_butt">
			<!-- 保存 --><button class="tsdbutton" id="saveModB" style="width:80px;heigth:27px;" onclick="addQuery()" ><fmt:message key="global.save" /></button>
		 	<!-- 关闭 --><button class="tsdbutton" id="closeModB" style="width:63px;heigth:27px;" onclick="closeoMod()" ><fmt:message key="global.close" /></button>
			</div>	
		</div>
	</div>
	
	<!-- 导出数据 -->
	<div class="neirong" id="thefieldsform" style="display: none;width:800px">
		<div class="top">
			<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
						<div class="top_03" id="titlediv">
						<!-- 选择您要导出的数据字段 -->
						<fmt:message key="userManager.checkDerivedData" />
						</div>
						<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
					</div>
					<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();"><fmt:message key="userManager.close" /></a></div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
		</div>
		<div class="midd" >
			   <form action="#" onsubmit="return false;">
				<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<div id="thelistform" style="margin-left: 10px;max-height: 200px">
						
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="midd_butt">
			<button type="submit" class="tsdbutton" id="query" onclick="checkedAllFields()">
				<fmt:message key="userManager.checkAll" />
			</button>
			<button type="submit" class="tsdbutton" id="query" onclick="DownSure()">
				<fmt:message key="global.ok" />
			</button>
			<button type="button" class="tsdbutton" id="closethisinfo" >
				<fmt:message key="global.close" />
			</button>			
		</div>
	</div>	
	
	<!-- 查询树信息存放 -->
	<input type="hidden" id='treepid' />	
	<input type="hidden" id='treecid' />	
	<input type="hidden" id='treestr' />	
	<input type="hidden" id='treepic' />
	
	<!-- 高级查询 模板隐藏域 -->
	<input type="hidden" id="queryright"/>
	<input type="hidden" id="queryMright"/>
	<input type="hidden" id="saveQueryMright"/>		
	
	<input type="hidden" id="useridd" value="<%=session.getAttribute("userid") %>"/>
	
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=session.getAttribute("languageType") %>' />
	
	<input type="hidden" id="addright" />
	<input type="hidden" id="deleteright" />
	<input type="hidden" id="editright" />
	<input type="hidden" id="delBright" />
	<input type="hidden" id="editBright" />
	<input type="hidden" id="exportright" />
	<input type="hidden" id="printright" />
	
	<input type="hidden" id="queryright" />
	<input type="hidden" id="saveQueryMright" />
	<input type="hidden" id="operationtips"	value="<fmt:message key="global.operationtips"/>" />
	<input type="hidden" id="successful" value="<fmt:message key="global.successful"/>" />
</body>
</html>
