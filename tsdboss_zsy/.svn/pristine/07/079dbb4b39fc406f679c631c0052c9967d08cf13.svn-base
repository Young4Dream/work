<%----------------------------------------
	name: addressManage.jsp
	author: 陈泽
	version: 1.0, 2010-10-11
	description: 地址库管理
	modify: 
		2010-11-5 youhongyu 添加注释功能
		2010-12-14 liwen    导出数据字段控制		
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String languageType = (String) session.getAttribute("languageType");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
    String yemiantype = request.getParameter("yemiantype");
	String imenuid = request.getParameter("imenuid");
	String returnhide = request.getParameter("returnhide");
	String zid = (String) session.getAttribute("groupid");//request.getParameter("groupid");
	String lanType = (String) session.getAttribute("languageType");	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<title></title>
	<base target="_self"/> 
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
		<!-- 分项卡 -->
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css"
			type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css"
			type="text/css" media="projection, screen" />
		
		<script src="plug-in/jquery/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
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
		<!-- 验证框架需要导入的js文件 -->
		<script src="plug-in/jquery/validate/jquery.validate.js" type="text/javascript"></script>
	  	<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script type="text/javascript" src="script/telephone/sysdataset/infotest.js"></script>
		<script src="script/public/datalength.js" type="text/javascript"></script>
		<!-- 菜单样式 -->
		<link rel="stylesheet" href="style/css/telephone/usermanagement/single_thirteen.css" type="text/css" />	
		
		<style type="text/css">
			#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
			cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
			#grid1 a,#grid2 a,#grid3 a,#grid4 a{font-weight:bold;}
			body{text-align:left;}
			
			.spanstyle{display:-moz-inline-box; display:inline-block; width:135px}
		</style>
	<script type="text/javascript">
	var Dat = "";
	var Dat1 = "";
	var Dat2='';
	//字段别名键值对数组
	var filAlias = "";
	//Grid标题
	var captions = ["<fmt:message key='addressManage.xq' />","<fmt:message key='addressManage.ld' />","<fmt:message key='addressManage.dy' />","<fmt:message key='addressManage.mp' />"];//,"楼栋号","单元号","门牌号"];
	//状态，记录操作是是哪一个Grid
	var tabStatus = 1;
	
	var seledRow = -1;
	
	
	/**
	* 页面初始化
	* @param 
	* @return 
	*/
	$(function(){
		//其他地方调用此页面时把横条显示的“返回”隐藏掉
		if($("#returnhide").val()=='NO'){
			$("#navBar1").hide();
			$("#guanbi").show();
		}else{
			$("#guanbi").hide();			
		}
	    var yemiantype = $("#yemiantype").val();	       
		$("#navBar1").append(genNavv());
		gobackInNavbar("navBar1");
		document.title = decodeURIComponent(parseUrl(document.location.search,"imenuname",'地址库管理'));
		
		if(yemiantype=="null"){$("#selectqd").hide();}		
		Dat2 = loadData("sys_address_s",$("#lanType").val(),1);	
		Dat = loadData("sys_address",$("#lanType").val(),1);
		Dat1 = loadData("sys_address",$("#lanType").val(),1);	
		Dat1.colModels[4].hidden=true;
		Dat1.setWidth({Operation:90,addrcode:140,addrname:280});			
		Dat.setWidth({Operation:90,addrcode:140,addrname:200});
		filAlias = fetchFieldAlias("sys_address",$("#lanType").val());
		setUserRight();		
		InitialField();		
		loadGrid1(getParam(1,""));
		loadGrid2("");
		loadGrid3("");
		loadGrid4("");
		
		//bindStatusToModifyAndDelete();
		$("#addform").draggable({handle:"#thisdrag"});
		
		$("#test").click(function(){		
			alert(seledRow);
		});		
	});
	
	/**
	* 初始化页面标签信息
	* @param 
	* @return 
	*/
	function InitialField()
	{	
		$("#addrname_l").text(Dat.getFieldAliasByFieldName("addrname"));
		$("#addrarea_l").text(Dat.getFieldAliasByFieldName("addrarea"));		
		InitialArea();
	}
	/**
	* 初始化区域
	* @param 
	* @return 
	*/
	function InitialArea()
	{
		var res = fetchMultiValue("AddrManage.queryArea",6,"");
		if(res[0]==undefined)
		{
			return false;
		}
		else
		{
			var temp = "";
			for(var i=0;i<res.length;i++)
			{
				temp += "<option value=\"";
				temp += res[i];
				temp += "\" ";
				if(res[i]==$("#userarea").val())
				{
					temp += "selected=\"selected\" ";
				}
				temp += ">";
				temp += res[i];
				temp += "</option>"
			}
			$("#addrarea").append(temp);
			
			//$("#addrarea").val($("#userarea").val());
			$("#addrarea_hide").text($("#addrarea").val());
			
			$("#addrarea").change(function(){
				$("#addrarea_hide").text($(this).val());
			});
		}
	}
	
	
	/**
	* 拼接进行地址查询参数
	* @param idx：标识目前加载的是第几级地址
	* @param param： addrcode值
	* @return 返回查询参数，包括sql查询字段、地址编码
	*/
	function getParam(idx,param)
	{
		var temp = tsd.buildParams({ 	packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xml',//返回数据格式 
						 					tsdpk:'AddrManage.query' + idx,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdpkpagesql:'AddrManage.queryAll' + idx//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
						 					});
		var temp2 = "";
		if(idx > 1)
		{
			temp2 = "&addr" + (idx - 1);
			temp2 = temp2 + "=";
			temp2 = temp2 + param;
		}		
		return temp + temp2 + "&cols=" + Dat.FieldName.join(",");
	}
	
	/**
	* 拼接进行地址查询参数
	* @param idx：标识目前加载的是第几级地址
	* @param param： addrcode值
	* @return 返回查询参数，包括sql查询字段、地址编码
	*/
	function getParam2(idx,param)
	{
		var temp = tsd.buildParams({ 	packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xml',//返回数据格式 
						 					tsdpk:'AddrManage.query' + idx,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdpkpagesql:'AddrManage.queryAll' + idx//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
						 					});
		var temp2 = "";
		if(idx > 1)
		{
			temp2 = "&addr" + (idx - 1);
			temp2 = temp2 + "=";
			temp2 = temp2 + param;
		}		
		return temp + temp2 + "&cols=" + Dat2.FieldName.join(",");
	}
	/**
	* 生成添加地址的地址编码
	* @param addressNo：地址编码
	* @return 返回地址编码
	*/
	function incrementNo(addressNo)
	{
		var lastIndexOfDot= addressNo.lastIndexOf(".");
		var dest = "";
		var src = "";
		var lenOfDest = 0;
		var lenOfS = 0;
		var temp;
		
		if(lastIndexOfDot<0)
		{
			dest = addressNo;
			src = "";
		}
		else
		{
			dest = addressNo.substring(lastIndexOfDot + 1);
			src = addressNo.substring(0,lastIndexOfDot + 1);
		}
		
		lenOfDest = dest.length;
		
		temp =parseInt(dest,10) + 1;
		
		temp = temp.toString();
		
		lenOfS = lenOfDest-temp.length;
		for(var i=0;i<lenOfS;i++)
		{
			temp = "0" + temp;
		}
		dest = temp;
		
		return src + dest;
	}
	
	
	/**
	* 更换按钮状态
	* @param sta ： 0修改  1新增
	* @return 
	*/
	function toggleBtn(sta)
	{
		if(sta==0)
		{
			$("#save").hide();
			$("#modify").show();
		}
		else if(sta==1)
		{
			$("#save").show();
			$("#modify").hide();
		}
	}
	
	
	 /**
	 * jqgrid上修改按钮操作 ，打开修改面板并加载将要修改的数据	 	
	 * @param idx 来判断是在哪个面板进行的操作
	 * @return 
	 */
	function openRowModify(idx)
	{		
		tabStatus = idx;
		
		clearText("addform");

		toggleBtn(0);
		
		//tsd.setTitle($("#input-Unit .title h3"),"<fmt:message key='global.edit' />");
		$("#titlediv").text("<fmt:message key='global.edit' />");
		
		// autoBlockFormAndSetWH("addform",20,10,"close21","#FFFFFF",false,600,'auto');
		autoBlockForm('addform',60,'close21',"#ffffff",false);
		
		$("#addrname").select();
		$("#addrname").focus();
	}
	
	

	/**
	 * 打开添加面板	 	
	 * @param idx 来判断是在哪个面板进行的操作
	 * @return 
	 */
	function openAddForm(idx)
	{
		tabStatus = idx;		
				
		if(tabStatus==1)
		{
			//$("#inputtext p:first").css("display","block");
			$("#addform table tr:eq(0)").css("display","block");
			
			$("#addrarea_hide").css("display","none");
		}
		else
		{
			//$("#inputtext p:first").css("display","none");
			$("#addform table tr:eq(0)").css("display","none");
			
			$("#addrarea_hide").val($("#grid1").getCell(idx,'addrarea'));
		}
		
		if(checkPrevStatus())
		{
			//alert("请选择上一级地址");
			alert("<fmt:message key='addressManage.choosePar' />");
			return false;
		}
		
		clearText("addform");		
		
		toggleBtn(1);
		//tsd.setTitle($("#input-Unit .title h3"),"<fmt:message key='global.add' />");
		
		$("#titlediv").text("<fmt:message key='global.add' />");
		autoBlockForm('addform',60,'close21',"#ffffff",false);		
		
		$("#addrname").select();
		$("#addrname").focus();
		//autoBlockFormAndSetWH("addform",60,10,"close21","#FFFFFF",true,600,'auto');
	}
	
	

	/**
	 * 添加数据	 	
	 * @param 
	 * @return 
	 */
	function addAddr()
	{
		
		var lenn = gLenn();
		
		var prevNo = "";
		//alert("SEL1:"+seledRow);
		//非第一个表格的时候取前缀
		if(seledRow > 0)
		{
			prevNo = $("#grid"+(tabStatus-1)).getCell(seledRow,"addrcode");
		}
		//判断是否存在
		var addrForAdd = $.trim($("#addrname").val());
		
		//文旭明后加的代码，主要是得到四个级别的地址存储到隐藏域中，模块对话框返回值的时候用到		
		var address1 = $("#address1").val();
		var address2 = $("#address2").val();
		var address3 = $("#address3").val();
		var address4 = $("#address4").val();

		/**
		if(address4==""&&address1!=""&&address2!=""&&address3!=""){
		  $("#address4").val(addrForAdd);
		  getaddress();
		}**/
		
		var res = "";
		if(tabStatus!=1)
		{
			res = fetchSingleValue("AddrManage.existed",6,"&addrname="+tsd.encodeURIComponent(addrForAdd)+"&lenn="+lenn+"&addrcode="+prevNo+"&addrarea="+tsd.encodeURIComponent($("#addrarea_hide").text()));
		}
		else
		{
			res = fetchSingleValue("AddrManage.existed1",6,"&addrname="+tsd.encodeURIComponent(addrForAdd)+"&lenn="+lenn+"&addrcode="+prevNo+"&addrarea="+tsd.encodeURIComponent($("#addrarea_hide").text()));
		}
		if(res == undefined || parseInt(res)>0)
		{
			//alert(addrForAdd + " 已经存在");
			alert(addrForAdd + " <fmt:message key='addressManage.existed' />");
			return false;
		}
		
		var maxx = fetchSingleValue("AddrManage.sMax",6,"&lenn="+lenn+"&addrcode="+prevNo);
		
		if(maxx == undefined)
		{		    
			//var tmp = "";
			if(tabStatus==1)
			{
				maxx = "0000";
			}
			else if(tabStatus==2)
			{
				maxx = prevNo + ".0000";
			}
			else if(tabStatus==3)
			{
				maxx = prevNo + ".000";
			}
			else
			{
				maxx = prevNo + ".000";
				$("#address4").val(addrForAdd);
		        getaddress();
			}
			//maxx = prevNo + 
		}else{
		   if(tabStatus==4){
		      $("#address4").val(addrForAdd);
		      getaddress();
		   } 
		}
		
		var c_idd = incrementNo(maxx);
		//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
		
		var params = "&addrcode=";
		params += tsd.encodeURIComponent(c_idd);
		params += "&addrname=";
		params += tsd.encodeURIComponent(addrForAdd);
		params += "&userid=";
		params += tsd.encodeURIComponent($("#skrid").val());
		if(tabStatus==1)
		{
		
			params += "&addrarea=";
			params += tsd.encodeURIComponent($("#addrarea").val());	
		}
		
		if(tsd.Qualified()==false){return false;}
		
		var ress = "";
		if(tabStatus==1)
		{
			ress = executeNoQuery("AddrManage.add",6,params);
		}
		else
		{
			ress = executeNoQuery("AddrManage.add1",6,params);
		}
		
		if(ress=="true"||ress==true)
		{
			jAlert("<fmt:message key='global.successful' />","<fmt:message key='global.operationtips' />");
			var loginfo = "";
			loginfo += "TableName:sys_address;";
			loginfo += tsd.encodeURIComponent(filAlias["addrcode"]);
			loginfo += ":";
			loginfo += tsd.encodeURIComponent(c_idd);
			loginfo += ";";
			loginfo += tsd.encodeURIComponent(filAlias["addrname"]);
			loginfo += ":";
			loginfo += tsd.encodeURIComponent(addrForAdd);
			loginfo += ";";
			loginfo += tsd.encodeURIComponent(filAlias["addrarea"]);
			loginfo += ":";
			loginfo += tsd.encodeURIComponent($("#addrarea_hide").text());
			loginfo += ";";
			
			writeLogInfo("","add",loginfo);
		}
		setTimeout($.unblockUI, 15);
		//alert(tabStatus);
		$("#grid"+tabStatus).trigger("reloadGrid");
		clearText("addform");
	}
	
	/**
	 * 得到隐藏域中的地址，返回给父级页面中的地址栏里（文旭明添加的代码） 	
	 * @param 
	 * @return 
	 */
	function getaddress(){
	   var allGrid=$("#allGrid").val();
	   var address1 = $("#address1").val();
	   var address2 = $("#address2").val();
	   var address3 = $("#address3").val();
	   var address4 = $("#address4").val(); 	   

	   if(allGrid=="1"&&address1==""){alert("请选择小区号！");return false;}
	   if(allGrid=="2"&&address2==""){alert("请选择楼栋号！");return false;}
	   if(allGrid=="3"&&address3==""){alert("请选择单元号！");return false;}
	   if(allGrid=="4"&&address4==""){alert("请选择门牌号！");return false;}	   
	   window.returnValue=address1+address2+address3+address4;
	   
	   $("#address1").val("");
	   $("#address2").val("");
	   $("#address3").val("");
	   $("#address4").val("");
	   $("#allGrid").val("");
	   window.close();
	}
	
	
	/**
	 * 删除记录	
	 * @param addrcode：地址编码
	 * @return 
	 */
	function deleteRow(addrcode)
	{
		if($("#deleteright").val()=="false")
		{
			//jAlert("你没有删除权限","提示");
			jAlert("<fmt:message key='global.deleteright' />","<fmt:message key='global.operationtips' />");
			//return false;
		}
		else
		{
			//更新状态
			bindStatusToModifyAndDelete(addrcode);
			//删除
			
			var infoo = "你确定要删除";
			if(tabStatus<4)
			{
				infoo += captions[tabStatus-1];
				infoo += "下的所有数据吗？";
			}
			else
			{
				infoo += "本条数据吗?";
			}
			
			jConfirm(infoo,"<fmt:message key='global.operationtips' />",function(i){
				if(i){
					var addrname = fetchSingleValue("AddrManage.sell",6,"&addrcode="+addrcode);
					
					executeNoQuery("AddrManage.delete",6,"&addrcode="+addrcode);
					//记日志	
					
					var loginfo = "";
					loginfo += "TableName:sys_address;";
					loginfo += tsd.encodeURIComponent(filAlias["addrcode"]);
					loginfo += ":";
					loginfo += tsd.encodeURIComponent(addrcode);
					loginfo += ";  ";
					loginfo += tsd.encodeURIComponent(filAlias["addrname"]);
					loginfo += ":";
					loginfo += tsd.encodeURIComponent(addrname);
					loginfo += ";";	
					loginfo += tsd.encodeURIComponent(filAlias["addrarea"]);
					loginfo += ":";
					loginfo += tsd.encodeURIComponent($("#addrarea_hide").text());
					loginfo += ";";			
					
					writeLogInfo("","delete",loginfo);
					//alert(tabStatus);
					var kld = tabStatus;
					while(kld<=4)
					{
						$("#grid" + kld).trigger("reloadGrid");
						kld ++;
					}
					//$("#grid" + tabStatus).trigger("reloadGrid");
					//$("#grid" + (tabStatus + 1)).trigger("reloadGrid");	
				}
			});
		}
	}
	
	/**
	 * 修改按钮事件，弹出修改面板记录	
	 * @param addrcode：地址编码
	 * @return 
	 */
	function modifyRow(addrcode)
	{
		if($("#editright").val()=="false")
		{
			//jAlert("你没有修改权限","提示");
			jAlert("<fmt:message key='global.editright' />","<fmt:message key='global.operationtips' />");
			//return false;
		}
		else
		{
			//更新状态
			bindStatusToModifyAndDelete(addrcode);
			
			if(tabStatus==1)
			{
				//$("#inputtext p:first").css("display","block");
				$("#addform table tr:eq(0)").css("display","block");
				
				$("#addrarea_hide").css("display","none");
			}
			else
			{
				//$("#inputtext p:first").css("display","none");
				$("#addform table tr:eq(0)").css("display","none");
			}
			
			var addrname = fetchMultiArrayValue("AddrManage.sell",6,"&addrcode="+addrcode);
			
			if(addrname[0] == undefined||addrname[0][0] == undefined)
			{
				return false;
			}
			
			clearText("addform");
			
			$("#addrname").val(addrname[0][0]);
			$("#addrname1").text(addrname[0][0]);
			$("#addrcode").text(addrcode);
			if(addrname[0][1]!=""&&addrname[0][1]!=undefined)
				$("#addrarea option[value='"+addrname[0][1]+"']").attr("selected","selected");
			
			toggleBtn(0);
			tsd.setTitle($("#input-Unit .title h3"),"<fmt:message key='global.edit' />");
			autoBlockForm('addform',60,'close21',"#ffffff",false);			
				
			$("#addrname").select();
			$("#addrname").focus();
		}
	}
	
	/**
	 * 修改面板修改按钮事件，修改记录	
	 * @param 
	 * @return 
	 */
	function ModifyData()
	{
		var lenn = gLenn();
		
		var addrcode = $("#addrcode").text();
		var prevNo = "";
		if(addrcode.lastIndexOf(".")<0)
		{
			prevNo = "";
		}
		else
		{
			prevNo = addrcode.substring(0,addrcode.lastIndexOf("."));
		}
		//alert(prevNo);
		//判断是否存在
		var addrForAdd = $.trim($("#addrname").val());
		var res = fetchSingleValue("AddrManage.existed",6,"&addrname="+tsd.encodeURIComponent(addrForAdd)+"&lenn="+lenn+"&addrcode="+prevNo+"&addrarea="+tsd.encodeURIComponent($("#addrarea_hide").text()));
		if(res == undefined || parseInt(res)>0)
		{
			//alert(addrForAdd + " 已经存在");
			alert(addrForAdd + " <fmt:message key='addressManage.existed' />");
			return false;
		}
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
		
		var params = "&addrname="+tsd.encodeURIComponent($("#addrname").val())+"&addrcode="+$("#addrcode").text()+"&userid="+$("#skrid").val();
		if(tabStatus==1)
		{
			params += "&addrarea="+tsd.encodeURIComponent($("#addrarea").val());
		}
		
		if(tsd.Qualified()==false){return false;}
		
		//执行修改
		var res = "";//executeNoQuery("AddrManage.update",6,param);
		
		
		if(tabStatus==1)
		{
			ress = executeNoQuery("AddrManage.update",6,params);
		}
		else
		{
			ress = executeNoQuery("AddrManage.update1",6,params);
		}
		
		if(res=="true"||res==true)
		{
			jAlert("<fmt:message key='global.successful' />","<fmt:message key='global.operationtips' />");
			
			var loginfo = "";
			loginfo += "TableName:sys_address;";
			loginfo += tsd.encodeURIComponent(filAlias["addrcode"]);
			loginfo += ":";
			loginfo += tsd.encodeURIComponent(addrcode);
			loginfo += ";";
			loginfo += tsd.encodeURIComponent(filAlias["addrname"]);
			loginfo += ":";
			loginfo += tsd.encodeURIComponent($("#addrname1").text());
			loginfo += ">>>";
			loginfo += tsd.encodeURIComponent(addrForAdd);	
			loginfo += ";";	
			loginfo += tsd.encodeURIComponent(filAlias["addrarea"]);
			loginfo += ":";
			loginfo += tsd.encodeURIComponent($("#addrarea_hide").text());
			loginfo += ";";		
			
			writeLogInfo("","modify",loginfo);
		}
		setTimeout($.unblockUI, 15);//关闭面板
		$("#grid"+tabStatus).trigger("reloadGrid");//重新加载数据
		
		
	}
	
	/**
	 * 检测上一次地址是否有选中,
	 * @param 
	 * @return 返回true为没有选中，false有被选中的
	 */	
	function checkPrevStatus()
	{
		if(tabStatus>1)
		{
			if($("#grid"+(tabStatus-1)).getGridParam("selrow")==null)
			{				
				return true;
			}
			else
			{	
				seledRow = $("#grid"+(tabStatus-1)).getGridParam("selrow");			
				return false;
			}
		}
		seledRow = -1;
		return false;
	}

	
	
	/**
	 * 高级查询、组合排序 打开查询窗口
	 * @param oper 0：排序操作；否则为查询操作
	 * @param status：标识是在哪级地址打开的查询
	 * @return
	 */	
	function showDialog(oper,status)
	{
	
		if(tabStatus!=status)
		{
			$("#fusearchsql").val("");
		}
		
		tabStatus = status;
		
		if(checkPrevStatus())
		{
			//alert("请选择上一级地址");
			alert("<fmt:message key='addressManage.choosePar' />");
			return false;
		}
		var page = oper==0?openDiaO('sys_address'):openDiaQueryG('query','sys_address',status);		
	}
	
	/**
	 * 组合排序
	 * @param sqlstr 进行组合排序的排序sql子语句
	 * @return 
	 */
	function zhOrderExe(sqlstr){
				
		var params ='&orderby='+sqlstr;
		
		var tparam = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
		if(tparam=='&fusearchsql='){
			tparam +='1=1';
		}			    
	 			 	
	 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:'AddrManage.queryByOrder' + tabStatus,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  tsdpkpagesql:'AddrManage.queryByOrderpage' + tabStatus
									});
		var link = urlstr1 + params + tparam;	
		
		link = link + "&cols=" + Dat.FieldName.join(",");
		
		var prevNo = "";
		//alert("SEL1:"+seledRow);
		//非第一个表格的时候取前缀
		if(seledRow > 0)
		{
			prevNo = $("#grid"+(tabStatus-1)).getCell(seledRow,"addrcode");
		}
		
		if(tabStatus>1)
		{
			link += "&addr=";
			link += prevNo;
		}
		//alert(link);
			
	 	$("#grid" + tabStatus).setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
	 	//setTimeout($.unblockUI, 15);//关闭面板
		 	
	}
	
	/**
	 * 高级查询按钮点击事件
	 * @param status：标识是在哪级地址打开的查询
	 * @return 
	 */	
	function openSearch(status)
	{
		$("#queryName").val("query");
		showDialog(1,status);
	}
	
	/**
	 * 进行通用查询 批量删除 批量修改入口；
	 	根据隐藏域queryName 判断是何种操作 delete：批量删除 ；modify：批量修改；其他：高级查询
	 * @param 
	 * @return 
	 */   
	function fuheExe()
	{
		var queryName= document.getElementById("queryName").value;
		fuheQuery();		
	}
	
	/**
	 * 高级查询操作，通过高级查询面板生成查询条件，查询和刷新jqgrid面板中的信息	 
	 * @param 
	 * @return 
	 */
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
									  tsdpk:'AddrManage.fuheQueryByWhere' + tabStatus,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  tsdpkpagesql:'AddrManage.fuheQueryByWherepage' + tabStatus
									});
		
		var link = urlstr1 + params;
		
		link = link + "&cols=" + Dat.FieldName.join(",");
		
		var prevNo = "";
		//alert("SEL1:"+seledRow);
		//非第一个表格的时候取前缀
		if(seledRow > 0)
		{
			prevNo = $("#grid"+(tabStatus-1)).getCell(seledRow,"addrcode");
		}
		
		if(tabStatus>1)
		{
			link += "&addr=";
			link += prevNo;
		}
		
	 	$("#grid" + tabStatus).setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
	 	setTimeout($.unblockUI, 15);//关闭面板			
	}
	
	
	
	/**
	 * 根据地址编码设置状态
	 * @param addrcode:地址编码
	 * @return 
	 */
	function bindStatusToModifyAndDelete(addrcode)
	{
		var len = addrcode.length;
		if(len==4)
		{
			tabStatus = 1;
		}
		else if(len==9)
		{
			tabStatus = 2;
		}
		else if(len==13)
		{
			tabStatus = 3;
		}
		else
		{
			tabStatus = 4;
		}
	}
	
	
	/**
	 * 获得相应状态的地址编码的长度
	 * @param 
	 * @return 返回地址编码的长度
	 */
	function gLenn()
	{
		if(tabStatus==1)
		{
			return 4;
		}
		else if(tabStatus == 2)
		{
			return 9;
		}
		else if(tabStatus == 3)
		{
			return 13;
		}
		else
		{
			return 17;
		}
	}
	
	
	/**
	 * 导出数据
	 * @param 
	 * @return 
	 */
	function DownFile(status)
	{
		if(tabStatus!=status)
		{
			$("#fusearchsql").val("");
		}
		tabStatus = status;
		
		/*
		var urlstr=tsd.buildParams({ packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'datafileDown',//返回数据格式 
										  tsdpk:'AddrManage.export' + tabStatus
										});
		
		
		
		//alert(param);
		//return false;
		if($("#download").size()==0)
			$("body").append("<iframe id='download' name='download' width='0' height='0'></iframe>");
		$("#download").attr("src","mainServlet.html?"+urlstr+param);
		
		*/
		
		if(checkPrevStatus())
		{
			alert("<fmt:message key='addressManage.choosePar' />");
			return false;
		}
		
		var expStatus = "sys_address";
		if(status != 1) {
			expStatus = "sys_address_s";
		}
		thisDownLoad('tsdBilling','mssql',expStatus,$("#lanType").val(),5);
	}
	
	
	/**
	 * 导出面板确定按钮事件，导出数据
	 * @param 
	 * @return 
	 */
	function DownSure()
	{
		var param = "";
		
		var prevNo = "";
		var table_alias='';
		//alert("SEL1:"+seledRow);
		//非第一个表格的时候取前缀
		if(seledRow > 0)
		{
			prevNo = $("#grid"+(tabStatus-1)).getCell(seledRow,"addrcode");
			
			if(tabStatus==2)
			{
				prevNo += ".____";
			}
			else if(tabStatus==3)
			{
				prevNo += ".___";
			}
			else if(tabStatus==4)
			{
				prevNo += ".___";
			}
			
			if(tabStatus==1){
				table_alias='sys_address';
			} else{
				table_alias='sys_address_s';
			}
			
			param = " addrcode like '" + prevNo + "'";
		}
		else
		{
			param = " length(addrcode)=4";
		}
		//保存复合查询sql语句
		var restoredsql = $("#fusearchsql").val();
		
		var params = $("#fusearchsql").val();			
		if(params==''){
			params +=param;
		}
		else
		{
			params +=" and ";
			params +=param;
		}
		$("#fusearchsql").val(params);
		getTheCheckedFields('tsdBilling','mssql','sys_address',table_alias);
		//还原sql语句
		$("#fusearchsql").val(restoredsql);
		
	}
	
	
	/**
	 * 打印报表
	 * @param status：标识用于判断对哪级地址的操作
	 * @return 
	 */
	function printR(status)
	{
		if(tabStatus!=status)
		{
			$("#fusearchsql").val("");
		}
		tabStatus = status;
		
		if(checkPrevStatus())
		{
			//alert("请选择上一级地址");
			alert("<fmt:message key='addressManage.choosePar' />");
			return false;
		}
		
		var prevNo = "";
		var param = "";
		//alert("SEL1:"+seledRow);
		//非第一个表格的时候取前缀
		
		var tparams = '&fusearchsql='+$("#fusearchsql").val();			
		if(tparams=='&fusearchsql='){
			tparams ='1=1';
		}
		
		if(seledRow > 0)
		{
			prevNo = $("#grid"+(tabStatus-1)).getCell(seledRow,"addrcode");
		}
		
		var param = "&addr=" + prevNo;
		
		var rName = ["XQ","LD","DY","MP"];
		
		printThisReport1('<%=request.getParameter("imenuid")%>',status+'','&fusearchsql='+cjkEncode(tparams) + param,'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');
		//printThisReport("AddressManage_" + rName[tabStatus-1],"&fusearchsql="+cjkEncode(tparams) + param);
		
		
	}
	
	
	/**
	 * 加载表格第一级地址jqgrid
	 * @param param：查询参数包括sql查询字段、地址编码
	 * @return 
	 */
	function loadGrid1(param)
	{
		$("#g_g_1").empty();
		//添加表格
		$("#g_g_1").append("<table id=\"grid1\" class=\"scroll\"></table><div id=\"pager1\" class=\"scroll\" style=\"text-align:left;\"></div>" );
		
		jQuery("#grid1").jqGrid({
			url:'mainServlet.html?' + param + "&cols=" + Dat.FieldName.join(","), 
			datatype: 'xml', 
			colNames:Dat.colNames,
			colModel:Dat.colModels,
			       	rowNum:10, 
			       	rowList:[10,20,30], 
			       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
			       	pager: jQuery('#pager1'), 
			       	sortname:'addrcode', 
			       	viewrecords: true, 
			       	sortorder: 'asc', 
			       	caption:captions[0], 
			       	height:130,
			       	width:(document.documentElement.clientWidth-54)/2,
			       	loadComplete:function(){			       		
			       		if($("#grid1 tr.jqgrow[id='1']").html()=="")
							return false;
			       		addRowOperBtn("grid1","<img src=\"style/images/public/ltubiao_01.gif\" title=\"<fmt:message key='global.edit' />\" />",'modifyRow','addrcode','click',1);
			       		addRowOperBtn("grid1","<img src=\"style/images/public/ltubiao_02.gif\" title=\"<fmt:message key='global.delete' />\" />",'deleteRow','addrcode','click',2);
					    executeAddBtn("grid1",2);
					    $("#allGrid").val("1");
			       	},
			       	onSelectRow:function(idx){
			       		//alert($("#grid1").getCell(idx,'addrcode'));
			       		$("#address1").val($("#grid1").getCell(idx,'addrname'));//模块对话框专用代码
			       		$("#address2").val("");
                        $("#address3").val("");
                        $("#address4").val(""); 
			       		$("#addrarea_hide").val($("#grid1").getCell(idx,'addrarea'));
			       		$("#grid2").setGridParam({url:"mainServlet.html?"+getParam2(2,$("#grid1").getCell(idx,'addrcode'))}).trigger("reloadGrid");
			       		loadGrid3("");
			       		loadGrid4("");	                    
			       		//$("#grid3").setGridParam({url:"mainServlet.html?"+getParam(3,"")}).trigger("reloadGrid");			       		
			       		//$("#grid4").setGridParam({url:"mainServlet.html?"+getParam(4,"")}).trigger("reloadGrid");
			       	}
			       
			}).navGrid('#pager1', {edit: false, add: false, add: false, del: false, search: false}, //options 
				{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
				{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
				{reloadAfterSubmit:false}, // del options 
				{} // search options 
				); 
	}
	
	/**
	 * 加载表格第二级地址jqgrid
	 * @param param：空值
	 * @return 
	 */
	function loadGrid2(param)
	{
		$("#g_g_2").empty();
		//添加表格
		$("#g_g_2").append("<table id=\"grid2\" class=\"scroll\"></table><div id=\"pager2\" class=\"scroll\" style=\"text-align:left;\"></div>" );
		var strr = 'mainServlet.html?' + param + "&cols=" + Dat2.FieldName.join(",");
		jQuery("#grid2").jqGrid({
			url:'mainServlet.html?' + param + "&cols=" + Dat2.FieldName.join(","), 
			datatype: 'xml', 
			colNames:Dat2.colNames,
			colModel:Dat2.colModels,
			       	rowNum:10, 
			       	rowList:[10,20,30], 
			       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
			       	pager: jQuery('#pager2'), 
			       	sortname:'addrcode', 
			       	viewrecords: true, 
			       	sortorder: 'asc', 
			       	caption:captions[1], 
			       	height:130,
			       	width:(document.documentElement.clientWidth-54)/2,
			       	loadComplete:function(){
			       		if($("#grid2 tr.jqgrow[id='1']").html()=="")
							return false;
			       		addRowOperBtn("grid2","<img src=\"style/images/public/ltubiao_01.gif\" title=\"<fmt:message key='global.edit' />\" />",'modifyRow','addrcode','click',1);
			       		addRowOperBtn("grid2","<img src=\"style/images/public/ltubiao_02.gif\" title=\"<fmt:message key='global.delete' />\" />",'deleteRow','addrcode','click',2);
					    executeAddBtn("grid2",2);
					    $("#allGrid").val("2");
			       	},
			       	onSelectRow:function(idx){
			       	    $("#address2").val($("#grid2").getCell(idx,'addrname'));//模块对话框专用代码
			       	    $("#address3").val("");
                        $("#address4").val(""); 
			       		$("#grid3").setGridParam({url:"mainServlet.html?"+getParam2(3,$("#grid2").getCell(idx,'addrcode'))}).trigger("reloadGrid");			       		
			       		loadGrid4("");
			       		//$("#grid4").setGridParam({url:"mainServlet.html?"+getParam(4,"")}).trigger("reloadGrid");
			       	}
			       
			}).navGrid('#pager2', {edit: false, add: false, add: false, del: false, search: false}, //options 
				{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
				{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
				{reloadAfterSubmit:false}, // del options 
				{} // search options 
				); 
	}
	
	/**
	 * 加载表格第三级地址jqgrid
	 * @param param：空值
	 * @return 
	 */
	function loadGrid3(param)
	{
		$("#g_g_3").empty();
		//添加表格
		$("#g_g_3").append("<table id=\"grid3\" class=\"scroll\"></table><div id=\"pager3\" class=\"scroll\" style=\"text-align:left;\"></div>" );
		
		jQuery("#grid3").jqGrid({
			url:'mainServlet.html?' + param + "&cols=" + Dat.FieldName.join(","), 
			datatype: 'xml', 
			colNames:Dat2.colNames,
			colModel:Dat2.colModels,
			       	rowNum:10, 
			       	rowList:[10,20,30], 
			       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
			       	pager: jQuery('#pager3'), 
			       	sortname:'addrcode', 
			       	viewrecords: true, 
			       	sortorder: 'asc', 
			       	caption:captions[2], 
			       	height:130,
			       	width:(document.documentElement.clientWidth-54)/2,
			       	loadComplete:function(){
			       		if($("#grid3 tr.jqgrow[id='1']").html()=="")
							return false;
			       		addRowOperBtn("grid3","<img src=\"style/images/public/ltubiao_01.gif\" title=\"<fmt:message key='global.edit' />\" />",'modifyRow','addrcode','click',1);
			       		addRowOperBtn("grid3","<img src=\"style/images/public/ltubiao_02.gif\" title=\"<fmt:message key='global.delete' />\" />",'deleteRow','addrcode','click',2);
					    executeAddBtn("grid3",2);
					    $("#allGrid").val("3");
			       	},
			       	onSelectRow:function(idx){
			       		$("#address3").val($("#grid3").getCell(idx,'addrname'));//模块对话框专用代码
			       		$("#address4").val("");
			       		$("#grid4").setGridParam({url:"mainServlet.html?"+getParam2(4,$("#grid3").getCell(idx,'addrcode'))}).trigger("reloadGrid");
			       	}
			       
			}).navGrid('#pager3', {edit: false, add: false, add: false, del: false, search: false}, //options 
				{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
				{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
				{reloadAfterSubmit:false}, // del options 
				{} // search options 
				); 
	}
	
	/**
	* 查看当前用户的扩展权限，对spower字段进行解析
	* @param 
	* @return 
	*/
	function setUserRight()
	{
		//alert($("#skrid").val()+":"+$("#imenuid").val()+":"+$("#zid").val());
		var allRi = fetchMultiPValue("addressManage.getPower",6,"&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
		
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
		}
		//alert(addright+":"+delBright+":"+editBright);
		$("#addright").val(addright);
		
		if(addright=="false")
		{
			$("#openadd1").attr("disabled","disabled");
			$("#openadd2").attr("disabled","disabled");
			$("#openadd3").attr("disabled","disabled");
			$("#openadd4").attr("disabled","disabled");
			
			$("#openadd11").attr("disabled","disabled");
			$("#openadd21").attr("disabled","disabled");
			$("#openadd31").attr("disabled","disabled");
			$("#openadd41").attr("disabled","disabled");
		}	
		
		$("#editright").val(editright);
		$("#deleteright").val(deleteright);
		
		$("#exportright").val(exportright);
		$("#printright").val(printright);
		if(exportright=="false")
		{
			$("#export1").attr("disabled","disabled");
			$("#export2").attr("disabled","disabled");
			$("#export3").attr("disabled","disabled");
			$("#export4").attr("disabled","disabled");
			
			$("#export11").attr("disabled","disabled");
			$("#export21").attr("disabled","disabled");
			$("#export31").attr("disabled","disabled");
			$("#export41").attr("disabled","disabled");
		}
		if(printright=="false")
		{
			$("#print1").attr("disabled","disabled");
			$("#print2").attr("disabled","disabled");
			$("#print3").attr("disabled","disabled");
			$("#print4").attr("disabled","disabled");
			
			$("#print11").attr("disabled","disabled");
			$("#print21").attr("disabled","disabled");
			$("#print31").attr("disabled","disabled");
			$("#print41").attr("disabled","disabled");
		}
		//alert(editright+":"+deleteright+":"+exportright);
	}
	

	/**
	 * 加载表格第四级地址jqgrid
	 * @param param：空值
	 * @return 
	 */
	function loadGrid4(param)
	{
		$("#g_g_4").empty();
		//添加表格
		$("#g_g_4").append("<table id=\"grid4\" class=\"scroll\"></table><div id=\"pager4\" class=\"scroll\" style=\"text-align:left;\"></div>" );
		
		jQuery("#grid4").jqGrid({
			url:'mainServlet.html?' + param + "&cols=" + Dat2.FieldName.join(","), 
			datatype: 'xml', 
			colNames:Dat2.colNames,
			colModel:Dat2.colModels,
			       	rowNum:10, 
			       	rowList:[10,20,30], 
			       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
			       	pager: jQuery('#pager4'), 
			       	sortname:'addrcode', 
			       	viewrecords: true, 
			       	sortorder: 'asc', 
			       	caption:captions[3], 
			       	height:130,
			       	width:(document.documentElement.clientWidth-54)/2,
			       	loadComplete:function(){
			       		if($("#grid4 tr.jqgrow[id='1']").html()=="")
							return false;
			       		addRowOperBtn("grid4","<img src=\"style/images/public/ltubiao_01.gif\" title=\"<fmt:message key='global.edit' />\" />",'modifyRow','addrcode','click',1);
			       		addRowOperBtn("grid4","<img src=\"style/images/public/ltubiao_02.gif\" title=\"<fmt:message key='global.delete' />\" />",'deleteRow','addrcode','click',2);
					    executeAddBtn("grid4",2);
					    $("#allGrid").val("4");
			       	},
			       	onSelectRow:function(idx){
			       		$("#address4").val($("#grid4").getCell(idx,'addrname'));//模块对话框专用代码			       		
			       	}
			       
			}).navGrid('#pager4', {edit: false, add: false, add: false, del: false, search: false}, //options 
				{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
				{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
				{reloadAfterSubmit:false}, // del options 
				{} // search options 
				); 
	}
	</script>
  </head>
  
  <body>
	<form name="childform" id="childform">
		<input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
		<input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
	</form>
	<input type='hidden' id='yemiantype' value='<%=yemiantype %>'/>
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /> 
	
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid%>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid%>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=lanType%>' />
	
	<input type="hidden" id="skrid" name="skrid" value='<%=request.getSession().getAttribute("userid")%>' />
	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' /> 
	
	<input type='hidden' id='userarea' value='<%=session.getAttribute("userarea")%>' /> 
	
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' /> 
	<input type="hidden" name="languageType" id="languageType" value='<%=lanType%>' />
    

	<div id="navBar1">
		<img src="style/icon/dot11.gif" style="margin-left: 10px" />
		<fmt:message key="global.location" />:	
	</div>

	<table>
		<tr>
			<td>
				<div id="buttons">
					<button type="button" id="openorder1" onclick="showDialog(0,1)">
						<!--排序--><fmt:message key="tariff.order" />
					</button>		
					<button type="button" id="openadd1" onclick="openAddForm(1)">
						<!--添加--><fmt:message key="global.add" />
				    </button>
				    <button type="button" onclick="openSearch(1)">
						<!--高级查询--><fmt:message key="global.query" />
					</button>
					<button type="button" id="export1" onclick="DownFile(1)"> 
						<!--导出--><fmt:message key="global.exportdata" />
					</button>					
					<button type="button" id="print1" onclick="printR(1)">
						<!--打印--><fmt:message key="tariff.printer" />
					</button>			
				</div>
				<div id="g_g_1"></div>
				<div id="buttons">
					<button type="button" id="openorder11" onclick="showDialog(0,1)">
						<!--排序--><fmt:message key="tariff.order" />
					</button>		
					<button type="button" id="openadd11" onclick="openAddForm(1)">
						<!--添加--><fmt:message key="global.add" />
				    </button>
				    <button type="button" onclick="openSearch(1)">
						<!--高级查询--><fmt:message key="global.query" />
					</button>
					<button type="button" id="export11" onclick="DownFile(1)"> 
						<!--导出--><fmt:message key="global.exportdata" />
					</button>					
					<button type="button" id="print11" onclick="printR(1)">
						<!--打印--><fmt:message key="tariff.printer" />
					</button>			
				</div>
			</td>
			<td>
				<div id="buttons">
					<button type="button" id="openorder2" onclick="showDialog(0,2)">
						<!--排序--><fmt:message key="tariff.order" />
					</button>		
					<button type="button" id="openadd2" onclick="openAddForm(2)">
						<!--添加--><fmt:message key="global.add" />
				    </button>
				    <button type="button" onclick="openSearch(2)">
						<!--高级查询--><fmt:message key="global.query" />
					</button>
					<button type="button" id="export2" onclick="DownFile(2)"> 
						<!--导出--><fmt:message key="global.exportdata" />
					</button>					
					<button type="button" id="print2" onclick="printR(2)">
						<!--打印--><fmt:message key="tariff.printer" />
					</button>			
				</div>
				<div id="g_g_2"></div>
				<div id="buttons">
					<button type="button" id="openorder21" onclick="showDialog(0,2)">
						<!--排序--><fmt:message key="tariff.order" />
					</button>		
					<button type="button" id="openadd21" onclick="openAddForm(2)">
						<!--添加--><fmt:message key="global.add" />
				    </button>
				    <button type="button" onclick="openSearch(2)">
						<!--高级查询--><fmt:message key="global.query" />
					</button>
					<button type="button" id="export21" onclick="DownFile(2)"> 
						<!--导出--><fmt:message key="global.exportdata" />
					</button>					
					<button type="button" id="print21" onclick="printR(2)">
						<!--打印--><fmt:message key="tariff.printer" />
					</button>			
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div id="buttons">
					<button type="button" id="openorder3" onclick="showDialog(0,3)">
						<!--排序--><fmt:message key="tariff.order" />
					</button>		
					<button type="button" id="openadd3" onclick="openAddForm(3)">
						<!--添加--><fmt:message key="global.add" />
				    </button>
				    <button type="button" onclick="openSearch(3)">
						<!--高级查询--><fmt:message key="global.query" />
					</button>
					<button type="button" id="export3" onclick="DownFile(3)"> 
						<!--导出--><fmt:message key="global.exportdata" />
					</button>					
					<button type="button" id="print3" onclick="printR(3)">
						<!--打印--><fmt:message key="tariff.printer" />
					</button>			
				</div>
				<div id="g_g_3"></div>
				<div id="buttons">
					<button type="button" id="openorder31" onclick="showDialog(0,3)">
						<!--排序--><fmt:message key="tariff.order" />
					</button>		
					<button type="button" id="openadd31" onclick="openAddForm(3)">
						<!--添加--><fmt:message key="global.add" />
				    </button>
				    <button type="button" onclick="openSearch(3)">
						<!--高级查询--><fmt:message key="global.query" />
					</button>
					<button type="button" id="export31" onclick="DownFile(3)"> 
						<!--导出--><fmt:message key="global.exportdata" />
					</button>					
					<button type="button" id="print31" onclick="printR(3)">
						<!--打印--><fmt:message key="tariff.printer" />
					</button>			
				</div>
			</td>
			<td>
				<div id="buttons">
					<button type="button" id="openorder4" onclick="showDialog(0,4)">
						<!--排序--><fmt:message key="tariff.order" />
					</button>		
					<button type="button" id="openadd4" onclick="openAddForm(4)">
						<!--添加--><fmt:message key="global.add" />
				    </button>
				    <button type="button" onclick="openSearch(4)">
						<!--高级查询--><fmt:message key="global.query" />
					</button>
					<button type="button" id="export4" onclick="DownFile(4)"> 
						<!--导出--><fmt:message key="global.exportdata" />
					</button>					
					<button type="button" id="print4" onclick="printR(4)">
						<!--打印--><fmt:message key="tariff.printer" />
					</button>			
				</div>
				<div id="g_g_4"></div>
				<div id="buttons">
					<button type="button" id="openorder41" onclick="showDialog(0,4)">
						<!--排序--><fmt:message key="tariff.order" />
					</button>		
					<button type="button" id="openadd41" onclick="openAddForm(4)">
						<!--添加--><fmt:message key="global.add" />
				    </button>
				    <button type="button" onclick="openSearch(4)">
						<!--高级查询--><fmt:message key="global.query" />
					</button>
					<button type="button" id="export41" onclick="DownFile(4)"> 
						<!--导出--><fmt:message key="global.exportdata" />
					</button>					
					<button type="button" id="print41" onclick="printR(4)">
						<!--打印--><fmt:message key="tariff.printer" />
					</button>			
				</div>
			</td>
		</tr>
	</table>
    <center>
		      <div id="buttons">
		                <button type="button" id="selectqd" onclick="getaddress()" >
							确定
						</button>
						<button type="button" id="guanbi" onclick="window.close();" >
							关闭
						</button>
			  </div>
    </center> 
	<div id="inputs1">
		<form class="neirong" id="addform" style="display:none;width:660px;" onsubmit="return false;">
			<input type="text" style="width:0px;height:0px;margin-left:-1000px;" />
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;" onclick="javascript:$('#close21').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>	
			</div>
		
			<div class="midd" style="background-color:#FFFFFF;text-align:left;">
				
				<table width="640">
					<tr>
						<td style="width:220px;height:32px;" class="labelclass">
							<label for="addrarea">
								<span id="addrarea_l"></span><span id="addrarea_hide"></span>
							</label>
						</td>
						<td class="tdstyle">
							<select id="addrarea" style="margin-left:0px;width:162px;" class="textclass"></select>
						</td>
					</tr>
					<tr>
						<td class="labelclass">
							<label for="addrname">
								<span id="addrname_l"></span><span id="addrcode" style="display:none;"></span><span id="addrname1" style="display:none;"></span>
							</label>
						</td>
						<td>
							<input type="text" name="addrname" id="addrname" style="margin-left:0px;width:162px;" class="textclass" ></input>
						</td>
					</tr>
				</table>
			</div>
		
			<div class="midd_butt">
				<button type="submit" id="save" onclick="addAddr()" class="tsdbutton">
					<!-- 保存 --><fmt:message key="global.save"/>
				</button>
				<button type="submit" id="modify" onclick="ModifyData()" class="tsdbutton">
					<!-- 修改 --><fmt:message key="global.edit" />
				</button>
				<button type="button" id="close21" class="tsdbutton">
					<!-- 关闭 --><fmt:message key="global.close" />
				</button>
			</div>
		</form>
		
	</div>
	
	
	
	<!-- 导出数据 -->
	<div class="neirong" id="thefieldsform" style="display: none;width:800px">
		<div class="top">
			<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
						<div class="top_03" id="titlediv">选择您要导出的数据字段</div>
						<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
					</div>
					<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();">关闭</a></div>
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
				全选
			</button>
			<button type="submit" class="tsdbutton" id="query" onclick="DownSure()">
				<fmt:message key="global.ok" />
			</button>
			<button type="button" class="tsdbutton" id="closethisinfo" >
				<fmt:message key="global.close" />
			</button>
			
		</div>
	</div>	

	<input type="hidden" id="addright" />
	<input type="hidden" id="deleteright" />
	<input type="hidden" id="editright" />
	<input type="hidden" id="delBright" />
	<input type="hidden" id="editBright" />
	<input type="hidden" id="exportright" />
	<input type="hidden" id="printright" />
	<!-- 文旭明后来加入的代码 -->
	<input type="hidden" id="address1" />
	<input type="hidden" id="address2" />
	<input type="hidden" id="address3" />
	<input type="hidden" id="address4" />	
	<input type="hidden" id="allGrid"/>	
	<input type="hidden" id="returnhide" value="<%=returnhide %>"/>
  </body>
</html>
