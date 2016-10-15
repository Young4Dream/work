<%----------------------------------------
	name: deptLevelS.jsp
	author: youhongyu
	version: 1.0, 2009-12-09
	description: 部门级别设置 The departmental level is set
	modify: 
		2010-01-25 youhongyu 更改导出模块 
		2010-01-26 youhongyu 更改grid样式 grid字段可控 验证方法
		2010-03-05 youhongyu 面板的弹出方式
		2011-01-04 youhongyu 去掉一级部门合同号关联改成手动输入；删除一级部门时，其它三级部门相应更新
		2011-01-14 chenze    修改四级地址位数不够的问题 修正上次部门列表失去焦点时下级部门列表未刷新问题 修改jalert
		2012-02-16 youhongyu 对部门编码是否存在的验证不准确，导致后续程序将undefined作为部门编码处理而产生错误。
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
	String imenuid = request.getParameter("imenuid");
	String zid = (String) session.getAttribute("groupid");//request.getParameter("groupid");
	String lanType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>    
	<title></title>
	
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
	
	<style type="text/css">
		#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
		cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
		#grid1 a,#grid2 a,#grid3 a,#grid4 a{font-weight:bold;}
	</style>
	
	<script type="text/javascript">


	
	
	//var Dat = "";
	//字段别名键值对数组
	var filAlias = "";
	//Grid标题
	var captions = ["<fmt:message key='deptLevelS.dept1' />","<fmt:message key='deptLevelS.dept2' />","<fmt:message key='deptLevelS.dept3' />","<fmt:message key='deptLevelS.dept4' />"];//,"楼栋号","单元号","门牌号"];
	//状态，记录操作是是哪一个Grid
	var tabStatus = 1;
	
	var seledRow = -1;
	
	$(function(){
		//设置页面所在位置
		$("#navBar1").append(genNavv());
		gobackInNavbar("navBar1");
		
		//document.title = decodeURIComponent(parseUrl(document.location.search,"imenuname",'地址库管理'));
		
	//	Dat = loadData("department",$("#lanType").val(),1);
				
		filAlias = fetchFieldAlias("department",$("#languageType").val());
		
		//获取权限
		setUserRight();
		//设置添加面板字段名
		InitialField();
		//加载四级部门信息
		loadGrid1(getParam(1,""));
		loadGrid2("");
		loadGrid3("");
		loadGrid4("");
		
		//bindStatusToModifyAndDelete();
		/************************
		*    注销方法
		**********************/
		/************************
		$("#test").click(function(){
			alert(seledRow);
		});
		**********************/
	});
/**
 * 设置添加面板字段名
 * @param 无参数
 * @return 无返回值
 */
	function InitialField()
	{
		
		
		////获取数据表对应字段国际化信息					
		var thisdata = loadData('department','<%=languageType %>',1);
		var DeptNameg = thisdata.getFieldAliasByFieldName('DeptName');
		var DeptGroupg = thisdata.getFieldAliasByFieldName('DeptGroup');
		$("#DeptNameg_a").text(DeptNameg);
		$("#DeptGroupg_a").text(DeptGroupg);		
		
		//设置添加面板的字段名
		$("#DeptName_l").text(DeptNameg);
	}
		
	/**
	 * 加载表格结构 jqgrid
	 * @param idx
	 * @param param
	 * @return String
	 */
	function getParam(idx,param)
	{
		var temp = tsd.buildParams({ 	    packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xml',//返回数据格式 
						 					tsdpk:'deptLevelS.query' + idx,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdpkpagesql:'deptLevelS.queryAll' + idx//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
						 					});
		var temp2 = "";
		
		if(idx > 1)
		{
			temp2 = "&addr" + (idx - 1);
			temp2 = temp2 + "=";
			temp2 = temp2 + param;
		}	
		return temp + temp2;
	}
	/**
	 * 加载表格结构
	 * @param addressNo
	 * @return String
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
	 * 更换按钮状态 0修改  1新增
	 * @param sta
	 * @return 无返回值
	 */
	function toggleBtn(sta)
	{
		if(sta==0)
		{
			$("#save").hide();
			$("#readd").hide();
			$("#modify").show();
		}
		else if(sta==1)
		{
			$("#save").show();
			$("#readd").show();
			$("#modify").hide();
		}
	}
	/**
	 * 打开添加面板
	 * @param idx
	 * @return 无返回值
	 */
	function openAddForm(idx)
	{
		markTable(0);//显示红色*号
		tabStatus = idx;
		if(idx==1){
			$(".top_03").html('<fmt:message key="global.add" />');//标题	
			removeDisabledN('department','','_a');
			
			clearText('operformT');
			openpan_a();
			$("#save_a").show();
		 	$("#readd_a").show();
		 	
		}else{				
			if(checkPrevStatus())
			{
				//alert("请选择上一级地址");
				var operationtips = "<fmt:message key='global.operationtips'/>";
				alert("<fmt:message key='deptLevelS.chooseDept' />",operationtips);
				return false;
			}
			$(".top_03").html('<fmt:message key="global.add" />');//标题	
			removeDisabledN('department','','');
			clearText('operformT1');
			openpan();
			$("#save").show();
		 	$("#readd").show();
			toggleBtn(1);
		}
		
	}	
	/**
	 * 添加数据
	 * @param saves
	 * @return 无返回值
	 */
	var closeflash_a = false;
	function saveObj_a(saves)
	{
		//确定部门编号位数
		//var lenn = gLenn();
		var lenn = 3;
		var prevNo = "";
		//alert("SEL1:"+seledRow);
		//非第一个表格的时候取前缀
		if(seledRow > 0)
		{
			prevNo = $("#grid"+(tabStatus-1)).getCell(seledRow,"DeptCode");
		}
		//判断是否存在
		var DeptName = $("#DeptName_a").val();
		if(DeptName==""||DeptName==null){
			var str=$("#DeptNameg_a").text();
			alert("<fmt:message key='tariff.input'/>"+str);
			$("#DeptName_a").focus();
			return false;
		}
		var res = fetchSingleValue("deptLevelS.existed",6,"&DeptName="+tsd.encodeURIComponent(DeptName)+"&lenn="+lenn+"&DeptCode="+prevNo);
		if(res == 'undefined' || parseInt(res)>0)
		{
			//判断部门是否已经存在			
			var str = $("#DeptNameg_a").text();
			alert(str + " <fmt:message key='addressManage.existed' />");
			$("#DeptName_a").focus();
			return false;
		}
		var maxx = fetchSingleValue("deptLevelS.sMax",6,"&lenn="+lenn+"&DeptCode="+prevNo);
		if(maxx == undefined)
		{
			//var tmp = "";
			if(tabStatus==1)
			{
				maxx = "000";
			}
		}
		
		var c_idd = incrementNo(maxx);
		//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
		var DeptGroup=delTrim($("#DeptGroup_a").val());
		var params = "&DeptCode=";
		params += tsd.encodeURIComponent(c_idd);
		params += "&DeptName=";
		params += tsd.encodeURIComponent(DeptName);
	
		params += "&DeptGroup=";
		params += tsd.encodeURIComponent(DeptGroup);
		
		
		if(tsd.Qualified()==false){return false;}
		
		var ress = executeNoQuery("deptLevelS.add1st",6,params);
		
		if(ress=="true"||ress==true)
		{			
			alert("<fmt:message key='global.successful' />","<fmt:message key='global.operationtips' />");
			var loginfo = "";
			loginfo += "TableName:Department;";
			loginfo += tsd.encodeURIComponent(filAlias["DeptCode"]);
			loginfo += ":";
			loginfo += tsd.encodeURIComponent(c_idd);
			loginfo += ";";
			loginfo += tsd.encodeURIComponent($("#DeptNameg_a").text());
			loginfo += ":";
			loginfo += tsd.encodeURIComponent(DeptName);
			loginfo += ";";
			loginfo += tsd.encodeURIComponent($("#DeptGroupg_a").text());
			loginfo += ":";
			loginfo += tsd.encodeURIComponent(DeptGroup);
			loginfo += ";";
			
			writeLogInfo("","add",loginfo);
		}
		if(saves==2){
			setTimeout($.unblockUI, 15);
			$("#grid"+tabStatus).trigger("reloadGrid");
			closeo();
		}else{
			closeflash_a=true;//表示关闭时需要刷新
			clearText("operformT");
			
		}		
		
	}
	var closeflash = false;
	/**
	 * 添加数据
	 * @param saves
	 * @return boolean
	 */
	function saveObj(saves)
	{
		var lenn = gLenn();
		var prevNo = "";
		//alert("SEL1:"+seledRow);
		//非第一个表格的时候取前缀
		if(seledRow > 0)
		{
			prevNo = $("#grid"+(tabStatus-1)).getCell(seledRow,"DeptCode");
		}
		
		//判断是否存在
		var addrForAdd = $.trim($("#DeptName").val());
		if(addrForAdd==""||addrForAdd==null){
			var str=$("#DeptName_l").text();						
			//alert("<fmt:message key='tariff.input'/>"+str,operationtips);
			alert("<fmt:message key='tariff.input'/>"+str);
			$("#DeptName").focus();
			return false;
		}
		var res = fetchSingleValue("deptLevelS.existed",6,"&DeptName="+tsd.encodeURIComponent(addrForAdd)+"&lenn="+lenn+"&DeptCode="+prevNo);
		
		if(res == 'undefined' || parseInt(res)>0)
		{
			//alert(addrForAdd + " 已经存在");
			var operationtips = "<fmt:message key='global.operationtips' />";
			var DeptNamestr = $("#DeptName_l").text();
			//alert(DeptNamestr + " <fmt:message key='addressManage.existed' />",operationtips);
			alert(DeptNamestr + " <fmt:message key='addressManage.existed' />");
			$("#DeptName").focus();
			//alert(addrForAdd + " <fmt:message key='addressManage.existed' />");
			return false;
		}
		
		var maxx = fetchSingleValue("deptLevelS.sMax",6,"&lenn="+lenn+"&DeptCode="+prevNo);
		if(maxx == undefined)
		{
			//var tmp = "";
			if(tabStatus==1)
			{
				maxx = "000";
			}
			else if(tabStatus==2)
			{
				maxx = prevNo + ".000";
			}
			else if(tabStatus==3)
			{
				maxx = prevNo + ".000";
			}
			else
			{
				maxx = prevNo + ".000";
			}
			//maxx = prevNo + 
		}
		
		var c_idd = incrementNo(maxx);
		//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
		
		var params = "&DeptCode=";
		params += tsd.encodeURIComponent(c_idd);
		params += "&DeptName=";
		params += tsd.encodeURIComponent(addrForAdd);
		
		
		if(tsd.Qualified()==false){return false;}
		
		var ress = executeNoQuery("deptLevelS.add",6,params);
		
		if(ress=="true"||ress==true)
		{
			alert("<fmt:message key='global.successful' />","<fmt:message key='global.operationtips' />");
			var loginfo = "";
			loginfo += "TableName:Department;";
			loginfo += tsd.encodeURIComponent(filAlias["DeptCode"]);
			loginfo += ":";
			loginfo += tsd.encodeURIComponent(c_idd);
			loginfo += ";";
			loginfo += tsd.encodeURIComponent(filAlias["DeptName"]);
			loginfo += ":";
			loginfo += tsd.encodeURIComponent(addrForAdd);
			loginfo += ";";
			
			writeLogInfo("","add",loginfo);
		}
		if(saves==2){
			setTimeout($.unblockUI, 15);
			$("#grid"+tabStatus).trigger("reloadGrid");
			closeo();
		}else{
			closeflash=true;//表示关闭时需要刷新
			clearText("operformT1");
			
		}		
		
	}
	/**
	 * 删除记录
	 * @param DeptCode
	 * @return 无返回值
	 */
	function deleteRow(DeptCode)
	{
		if($("#deleteright").val()=="false")
		{
			//alert("你没有删除权限","提示");
			alert("<fmt:message key='global.deleteright' />","<fmt:message key='global.operationtips' />");
			//return false;
		}
		else
		{
			//更新状态
			bindStatusToModifyAndDelete(DeptCode);
			//删除
			jConfirm("<fmt:message key='global.alert.del' />?","<fmt:message key='global.operationtips' />",function(i){
				if(i){
					var DeptName = fetchSingleValue("deptLevelS.sell",6,"&DeptCode="+DeptCode);
					
					executeNoQuery("deptLevelS.delete",6,"&DeptCode="+DeptCode);
					//记日志	
					
					var loginfo = "";
					loginfo += "TableName:Department;";
					loginfo += tsd.encodeURIComponent(filAlias["DeptCode"]);
					loginfo += ":";
					loginfo += tsd.encodeURIComponent(DeptCode);
					loginfo += ";  ";
					loginfo += tsd.encodeURIComponent(filAlias["DeptName"]);
					loginfo += ":";
					loginfo += tsd.encodeURIComponent(DeptName);			
					
					writeLogInfo("","delete",loginfo);
					
					var kld = tabStatus;
					while(kld<=4)
					{
						$("#grid" + kld).trigger("reloadGrid");
						kld ++;
					}
				}
			});
		}
	}
	/**
	 * 修改操作
	 * @param DeptCode
	 * @return boolean
	 */
	function modifyRow(DeptCode)
	{
		markTable(0);//显示红色*号
		var editinfo = $("#editinfo").val();
		$(".top_03").html(editinfo);//设置编辑框的标题
		
		if($("#editright").val()=="false")
		{
			//alert("你没有修改权限","提示");
			alert("<fmt:message key='global.editright' />","<fmt:message key='global.operationtips' />");
			//return false;
		}
		else
		{
			//更新状态
			bindStatusToModifyAndDelete(DeptCode);
			var DeptName = fetchSingleValue("deptLevelS.sell",6,"&DeptCode="+DeptCode);
			if(DeptName == 'undefined')
			{
				return false;
			}
			
			openpan();
			$("#modify").show();$("#reset").show();
			clearText('operformT1');
			
			$("#DeptName").val(DeptName);
			$("#DeptName1").text(DeptName);
			$("#DeptCode").text(DeptCode);
			
			toggleBtn(0);
			//tsd.setTitle($("#input-Unit .title h3"),"<fmt:message key='global.edit' />");
			//autoBlockForm('addform',60,'close21',"#ffffff",false);
			///autoBlockFormAndSetWH("addform",20,10,"close21","#FFFFFF",false,730,'');
		}
	}
	/**
	 * 修改操作2
	 * @param DeptCode
	 * @return boolean
	 */
	function modifyRow_a(DeptCode)
	{	
		markTable(0);//显示红色*号
		var editinfo = $("#editinfo").val();
		$(".top_03").html(editinfo);//设置编辑框的标题
		
		openpan_a();
		$("#modify_a").show();$("#reset_a").show();
		clearText('operformT');	
			
		if($("#editright").val()=="false")
		{
			//alert("你没有修改权限","提示");
			alert("<fmt:message key='global.editright' />","<fmt:message key='global.operationtips' />");
			//return false;
		}
		else
		{
		
			var urlstr=tsd.buildParams({  
							  packgname:'service',//java包
							  clsname:'ExecuteSql',//类名
							  method:'exeSqlData',//方法名
							  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
							  tsdcf:'mssql',//指向配置文件名称
							  tsdoper:'query',//操作类型 
							  datatype:'xmlattr',//返回数据格式 
							  tsdpk:'deptLevelS.sell1st'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							});	
			$.ajax({
				url:'mainServlet.html?'+urlstr+'&DeptCode='+DeptCode,
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
					//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值
					$(xml).find('row').each(function(){
					
						//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
						///如果sql语句中指定列名 则按指定名称给参数
						//hth,dh,bjbm,heji,bjsj,jlry,bz
						var DeptCode = $(this).attr("deptcode");							
						$("#DeptCode").text(DeptCode);
						
						var DeptName = $(this).attr("deptname");
						$("#DeptName_a").val(DeptName);
						$("#DeptName1_a").val(DeptName);
														
						var DeptGroup = $(this).attr("deptgroup");
						$("#DeptGroup_a").val(DeptGroup);
						$("#DeptGroup1_a").val(DeptGroup);
						
					});
				}
				
			});		
			$("#DeptName_a").trigger("onchange");
			//更新状态
			bindStatusToModifyAndDelete(DeptCode);
			
				
		}
	}
	/**
	 * 修改操作3
	 * @param DeptCode
	 * @return boolean
	 */
	function ModifyData_a()
	{
		var lenn = gLenn();
		
		var DeptCode = $("#DeptCode").text();
		var prevNo = "";
		if(DeptCode.lastIndexOf(".")<0)
		{
			prevNo = "";
		}
		else
		{
			prevNo = DeptCode.substring(0,DeptCode.lastIndexOf("."));
		}
		//alert(prevNo);
		
		//判断是否存在
		var DeptName = $("#DeptName_a").val();
		
		//必填项
		if(DeptName==""||DeptName==null){
			var str=$("#DeptNameg_a").text();
			alert("<fmt:message key='tariff.input'/>"+str);
			$("#DeptName_a").focus();
			return false;
		}		
		
		
		var res = fetchSingleValue("deptLevelS.existed1st",6,"&DeptName="+tsd.encodeURIComponent(DeptName)+"&DeptCode="+DeptCode);
		if(res == 'undefined' || parseInt(res)>0)
		{
			//alert(addrForAdd + " 已经存在");
			var DeptNamestr=$("#DeptNameg_a").text();
			alert(DeptNamestr + " <fmt:message key='addressManage.existed' />");
			$("#DeptName_a").focus();
			return false;
		}
		
		//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
		
		var param = "&DeptName="+tsd.encodeURIComponent($("#DeptName_a").val())+"&DeptGroup="+tsd.encodeURIComponent(delTrim($("#DeptGroup_a").val()))+"&DeptCode="+$("#DeptCode").text();
		
		if(tsd.Qualified()==false){return false;}
		
		//执行修改
		var res = executeNoQuery("deptLevelS.update1st",6,param);
		if(res=="true"||res==true)
		{
			alert("<fmt:message key='global.successful' />","<fmt:message key='global.operationtips' />");
			
			var loginfo = "";
			loginfo += "TableName:Department;";
			loginfo += tsd.encodeURIComponent(filAlias["DeptCode"]);
			loginfo += ":";
			loginfo += tsd.encodeURIComponent(DeptCode);
			loginfo += ";";
			loginfo += tsd.encodeURIComponent($("#DeptNameg_a").text());
			loginfo += ":";
			loginfo += tsd.encodeURIComponent($("#DeptName1_a").val());
			loginfo += ">>>";
			loginfo += tsd.encodeURIComponent($("#DeptName_a").val());	
			loginfo += ";";
			loginfo += tsd.encodeURIComponent($("#DeptGroupg_a").text());
			loginfo += ":";
			loginfo += tsd.encodeURIComponent($("#DeptGroup1_a").val());
			loginfo += ">>>";
			loginfo += tsd.encodeURIComponent(delTrim($("#DeptGroup_a").val()));		
				
			
			writeLogInfo("","modify",loginfo);
		}
		setTimeout($.unblockUI, 15);//关闭面板
		$("#grid"+tabStatus).trigger("reloadGrid");//重新加载数据
		closeo();
	}
	/**
	 * 修改操作4
	 * @param DeptCode
	 * @return boolean
	 */
	function ModifyData()
	{
		var lenn = gLenn();
		
		var DeptCode = $("#DeptCode").text();
		var prevNo = "";
		if(DeptCode.lastIndexOf(".")<0)
		{
			prevNo = "";
		}
		else
		{
			prevNo = DeptCode.substring(0,DeptCode.lastIndexOf("."));
		}
		//alert(prevNo);
		//判断是否存在
		var addrForAdd = $.trim($("#DeptName").val());
		var addrForAddold = $("#DeptName1").text();
		if(addrForAdd==addrForAddold){
			setTimeout($.unblockUI, 15);//关闭面板
			return false; 
		}
		if(addrForAdd==""||addrForAdd==null){
			var str=$("#DeptName_l").text();						
			//alert("<fmt:message key='tariff.input'/>"+str,operationtips);
			alert("<fmt:message key='tariff.input'/>"+str);
			$("#DeptName").focus();
			return false;
		}
		var res = fetchSingleValue("deptLevelS.existed",6,"&DeptName="+tsd.encodeURIComponent(addrForAdd)+"&lenn="+lenn+"&DeptCode="+prevNo);
		if(res == 'undefined' || parseInt(res)>0)
		{
			//alert(addrForAdd + " 已经存在");
			var operationtips = "<fmt:message key='global.operationtips' />";
			var DeptNamestr=$("#DeptName_l").text();
			//alert(DeptNamestr + " <fmt:message key='addressManage.existed' />",operationtips);
			alert(DeptNamestr + " <fmt:message key='addressManage.existed' />");
			$("#DeptName").focus();
			//alert(addrForAdd + " <fmt:message key='addressManage.existed' />");
			return false;
		}
		
		//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
		
		var param = "&DeptName="+tsd.encodeURIComponent(delTrim($("#DeptName").val()))+"&DeptCode="+$("#DeptCode").text();
		
		if(tsd.Qualified()==false){return false;}
		
		//执行修改
		var res = executeNoQuery("deptLevelS.update",6,param);
		if(res=="true"||res==true)
		{
			alert("<fmt:message key='global.successful' />","<fmt:message key='global.operationtips' />");
			
			var loginfo = "";
			loginfo += "TableName:Department;";
			loginfo += tsd.encodeURIComponent(filAlias["DeptCode"]);
			loginfo += ":";
			loginfo += tsd.encodeURIComponent(DeptCode);
			loginfo += ";";
			loginfo += tsd.encodeURIComponent(filAlias["DeptName"]);
			loginfo += ":";
			loginfo += tsd.encodeURIComponent($("#DeptName1").text());
			loginfo += ">>>";
			loginfo += tsd.encodeURIComponent(addrForAdd);			
			
			writeLogInfo("","modify",loginfo);
		}
		setTimeout($.unblockUI, 15);//关闭面板
		$("#grid"+tabStatus).trigger("reloadGrid");//重新加载数据
		closeo();
	}
	/**
	 * 检测上一次地址是否有选中,true为没有选中
	 * @param 无参数
	 * @return boolean
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
				//如果有选中的上级目录，则将选中的行号赋值给seledRow
				seledRow = $("#grid"+(tabStatus-1)).getGridParam("selrow");			
				return false;
			}
		}
		seledRow = -1;
		return false;
	}
	
	/**********************************
	 ************ *注销*************
	function dddd()
	{
		alert(Dat.FieldName);
	}
	********************************/
	/**
	 * 打开对话框
	 * @param oper
	 * @param status
	 * @return 无返回值
	 */
	function showDialog(oper,status)
	{
		tabStatus = status;
		
		if(checkPrevStatus())
		{
			var operationtips = "<fmt:message key='global.operationtips' />";
			alert("<fmt:message key='deptLevelS.chooseDept'/>",operationtips);
			//alert("<fmt:message key='addressManage.choosePar'/>");
			return false;
		}
		var talbename='';
		if(status=='1'){		
			talbename='department';
		}
		else{
			talbename='department_fu';
		}
		if(oper==0){
			openDiaO(talbename);
		}
		else{
			openDiaQ('query','department');
		}
		/************************************
		oper = oper==0?"order.jsp":"search.jsp";
		if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){  
			window.showModalDialog("/tsd2009/queryServlet?tablename=Department&url=/"+oper,window,"dialogWidth:610px; dialogHeight:320px; center:yes; scroll:no");
	    }
	    else{
			window.showModalDialog("/tsd2009/queryServlet?tablename=Department&url=/"+oper,window,"dialogWidth:620px; dialogHeight:580px; center:yes; scroll:no");
		}
		*********************************************/
	}
	
	/**
	 * 条件排序
	 * @param sqlstr(组合排序条件)
	 * @return 无返回值
	 */
	function zhOrderExe(sqlstr){
				
		var params ='&orderby='+sqlstr;	
		if(tabStatus==1){
			var column = $("#ziduansF").val();	
			params +='&column='+column;		
		}    
	 			 	
	 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:'deptLevelS.queryByOrder' + tabStatus,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  tsdpkpagesql:'deptLevelS.queryByOrderpage' + tabStatus
									});
		var link = urlstr1 + params;	
		
		var prevNo = "";
		//alert("SEL1:"+seledRow);
		//非第一个表格的时候取前缀
		if(seledRow > 0)
		{
			prevNo = $("#grid"+(tabStatus-1)).getCell(seledRow,"DeptCode");
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
	 * 打开查询面板
	 * @param status(状态)
	 * @return 无返回值
	 */
	function openSearch(status)
	{
		$("#queryName").val("query");
		showDialog(1,status);
	}
	
	/**
	 * 根据地址编码设置状态
	 * @param DeptCode
	 * @return 无返回值
	 */
	function bindStatusToModifyAndDelete(DeptCode)
	{
		var len = DeptCode.length;
		if(len==3)
		{
			tabStatus = 1;
		}
		else if(len==7)
		{
			tabStatus = 2;
		}
		else if(len==11)
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
	 * @param 无参数
	 * @return int
	 */
	function gLenn()
	{
		if(tabStatus==1)
		{
			return 3;
		}
		else if(tabStatus == 2)
		{
			return 7;
		}
		else if(tabStatus == 3)
		{
			return 11;
		}
		else
		{
			return 15;
		}
	}
	/**
	 * 下载文件
	 * @param status
	 * @return 无返回值
	 */
	function DownFile(status)
	{
		tabStatus = status;
		var urlstr=tsd.buildParams({ packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'datafileDown',//返回数据格式 
										  tsdpk:'deptLevelS.export' + tabStatus
										});
		if(checkPrevStatus())
		{
			var operationtips = "<fmt:message key='global.operationtips' />";
			alert("<fmt:message key='deptLevelS.chooseDept'/>",operationtips);
			//alert("<fmt:message key='addressManage.choosePar' />");
			return false;
		}
		
		var prevNo = "";
		//alert("SEL1:"+seledRow);
		//非第一个表格的时候取前缀
		if(seledRow > 0)
		{
			prevNo = $("#grid"+(tabStatus-1)).getCell(seledRow,"DeptCode");
		}
		
		var param = "&addr=" + prevNo;
		
		
		//alert(param);
		//return false;
		if($("#download").size()==0)
			$("body").append("<iframe id='download' name='download' width='0' height='0'></iframe>");
		$("#download").attr("src","mainServlet.html?"+urlstr+param);
	}
	/**
	 * 打印报表
	 * @param status(状态)
	 * @return 无返回值
	 */
	function printR(status)
	{
		tabStatus = status;
		
		if(checkPrevStatus())
		{
			//alert("请选择上一级地址");
			var operationtips = "<fmt:message key='global.operationtips' />";
			alert("<fmt:message key='deptLevelS.chooseDept'/>",operationtips);
			//alert("<fmt:message key='addressManage.choosePar' />");
			return false;
		}
		
		var prevNo = "";
		//alert("SEL1:"+seledRow);
		//非第一个表格的时候取前缀
		if(seledRow > 0)
		{
			prevNo = $("#grid"+(tabStatus-1)).getCell(seledRow,"DeptCode");
		}
		
		var param = "&deptC=" + prevNo;
		//var rName = ["XQ","LD","DY","MP"];
		printThisReport1('<%=request.getParameter("imenuid")%>',status+'',param,'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');
		
	}
	/**
	 * 加载表格 1 结构   
	 * @param param
	 * @return 无返回值
	 */
	function loadGrid1(param)
	{
		$("#g_g_1").empty();
		//添加表格
		$("#g_g_1").append("<table id=\"grid1\" class=\"scroll\"></table><div id=\"pager1\" class=\"scroll\" style=\"text-align:left;\"></div>" );
		var col=[[],[]];
		col=getRb_Field('department','DeptCode','<fmt:message key="deptLevelS.modifydelete" />','70','ziduansF');//得到jqGrid要显示的字段
		var column = $("#ziduansF").val();	
		
		jQuery("#grid1").jqGrid({
			url:'mainServlet.html?' + param+'&column='+column, 
			datatype: 'xml', 
			colNames:col[0],
			colModel:col[1],
			       	rowNum:10, 
			       	rowList:[10,20,30], 
			       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
			       	pager: jQuery('#pager1'), 
			       	sortname:'DeptCode', 
			       	viewrecords: true, 
			       	sortorder: 'asc', 
			       	caption:captions[0], 
			       	height:150,
			       	width:(document.documentElement.clientWidth-30)/2,
			       	loadComplete:function(){			       		
			       		if($("#grid1 tr.jqgrow[id='1']").html()==""){
							return false;
						}
			       		//addRowOperBtn("grid1","<fmt:message key='global.edit' />",'modifyRow','DeptCode','click',1);
			       		//addRowOperBtn("grid1","<fmt:message key='global.delete' />",'deleteRow','DeptCode','click',2);
			       		addRowOperBtnimage('grid1','modifyRow_a','DeptCode','click',1,"style/images/public/ltubiao_01.gif","<fmt:message key='global.edit' />","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
						addRowOperBtnimage('grid1','deleteRow','DeptCode','click',2,"style/images/public/ltubiao_02.gif","<fmt:message key='global.delete' />","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
						//addRowOperBtnimage('editgrid','openInfo','Zjjx','click',3,'images/ltubiao_03.gif',"详细","&nbsp;&nbsp;&nbsp;");//详细
			       		executeAddBtn("grid1",2);
			       		
			       		loadGrid2("");
			       		loadGrid3("");
			       		loadGrid4("");
			       	},
			       	onSelectRow:function(idx){
			       		//alert($("#grid1").getCell(idx,'addrcode'));
			       		//alert("mainServlet.html?"+getParam(2,$("#grid1").getCell(idx,'addrcode')));
			       		$("#grid2").setGridParam({url:"mainServlet.html?"+getParam(2,$("#grid1").getCell(idx,'DeptCode'))}).trigger("reloadGrid");
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
	 * 加载表格 2 结构   
	 * @param param(参数)
	 * @return 无返回值
	 */
	function loadGrid2(param)
	{
		$("#g_g_2").empty();
		//添加表格
		$("#g_g_2").append("<table id=\"grid2\" class=\"scroll\"></table><div id=\"pager2\" class=\"scroll\" style=\"text-align:left;\"></div>" );
		
		var col=[[],[]];
		col=getRb_Field('department_fu','DeptCode','<fmt:message key="deptLevelS.modifydelete" />','70','ziduansF1');//得到jqGrid要显示的字段
	
		
		jQuery("#grid2").jqGrid({
			url:'mainServlet.html?' + param, 
			datatype: 'xml', 
			colNames:col[0],
			colModel:col[1],
			       	rowNum:10, 
			       	rowList:[10,20,30], 
			       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
			       	pager: jQuery('#pager2'), 
			       	sortname:'DeptCode', 
			       	viewrecords: true, 
			       	sortorder: 'asc', 
			       	caption:captions[1], 
			       	height:150,
			       	width:(document.documentElement.clientWidth-30)/2,
			       	loadComplete:function(){
			       		if($("#grid2 tr.jqgrow[id='1']").html()==""){
							return false;
						}
			       		//addRowOperBtn("grid2","<fmt:message key='global.edit' />",'modifyRow','DeptCode','click',1);
			       		//addRowOperBtn("grid2","<fmt:message key='global.delete' />",'deleteRow','DeptCode','click',2);
			       		addRowOperBtnimage('grid2','modifyRow','DeptCode','click',1,"style/images/public/ltubiao_01.gif","<fmt:message key='global.edit' />","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
						addRowOperBtnimage('grid2','deleteRow','DeptCode','click',2,"style/images/public/ltubiao_02.gif","<fmt:message key='global.delete' />","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
						executeAddBtn("grid2",2);
						
						loadGrid3("");
						loadGrid4("");
			       	},
			       	onSelectRow:function(idx){
			       		$("#grid3").setGridParam({url:"mainServlet.html?"+getParam(3,$("#grid2").getCell(idx,'DeptCode'))}).trigger("reloadGrid");
			       		
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
	 * 加载表格结构   
	 * @param param(参数)
	 * @return 无返回值
	 */
	function loadGrid3(param)
	{
		$("#g_g_3").empty();
		//添加表格
		$("#g_g_3").append("<table id=\"grid3\" class=\"scroll\"></table><div id=\"pager3\" class=\"scroll\" style=\"text-align:left;\"></div>" );
		var col=[[],[]];
		col=getRb_Field('department_fu','DeptCode','<fmt:message key="deptLevelS.modifydelete" />','70','ziduansF1');//得到jqGrid要显示的字段
		jQuery("#grid3").jqGrid({
			url:'mainServlet.html?' + param, 
			datatype: 'xml', 
			colNames:col[0],
			colModel:col[1],
			       	rowNum:10, 
			       	rowList:[10,20,30], 
			       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
			       	pager: jQuery('#pager3'), 
			       	sortname:'DeptCode', 
			       	viewrecords: true, 
			       	sortorder: 'asc', 
			       	caption:captions[2], 
			       	height:150,
			       	width:(document.documentElement.clientWidth-30)/2,
			       	loadComplete:function(){
			       		if($("#grid3 tr.jqgrow[id='1']").html()=="")
							return false;
			       		//addRowOperBtn("grid3","<fmt:message key='global.edit' />",'modifyRow','DeptCode','click',1);
			       		//addRowOperBtn("grid3","<fmt:message key='global.delete' />",'deleteRow','DeptCode','click',2);
					    addRowOperBtnimage('grid3','modifyRow','DeptCode','click',1,"style/images/public/ltubiao_01.gif","<fmt:message key='global.edit' />","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
						addRowOperBtnimage('grid3','deleteRow','DeptCode','click',2,"style/images/public/ltubiao_02.gif","<fmt:message key='global.delete' />","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
						executeAddBtn("grid3",2);
						
						loadGrid4("");
			       	},
			       	onSelectRow:function(idx){
			       		
			       		$("#grid4").setGridParam({url:"mainServlet.html?"+getParam(4,$("#grid3").getCell(idx,'DeptCode'))}).trigger("reloadGrid");
			       	}
			       
			}).navGrid('#pager3', {edit: false, add: false, add: false, del: false, search: false}, //options 
				{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
				{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
				{reloadAfterSubmit:false}, // del options 
				{} // search options 
				); 
	}
	
	/**
	 * 判断权限   
	 * @param 无参数
	 * @return 无返回值
	 */
	function setUserRight()
	{
		//alert($("#skrid").val()+":"+$("#imenuid").val()+":"+$("#zid").val());
		var allRi = fetchMultiPValue("deptLevelS.getPower",6,"&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
		
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
		}
		if(printright=="false")
		{
			$("#print1").attr("disabled","disabled");
			$("#print2").attr("disabled","disabled");
			$("#print3").attr("disabled","disabled");
			$("#print4").attr("disabled","disabled");
		}
		//alert(editright+":"+deleteright+":"+exportright);
	}
	/**
	 * 加载表格 4 结构 
	 * @param param(参数)
	 * @return 无返回值
	 */
	function loadGrid4(param)
	{
		$("#g_g_4").empty();
		//添加表格
		$("#g_g_4").append("<table id=\"grid4\" class=\"scroll\"></table><div id=\"pager4\" class=\"scroll\" style=\"text-align:left;\"></div>" );
		var col=[[],[]];
		col=getRb_Field('department_fu','DeptCode','<fmt:message key="deptLevelS.modifydelete" />','70','ziduansF1');//得到jqGrid要显示的字段
		jQuery("#grid4").jqGrid({
			url:'mainServlet.html?' + param, 
			datatype: 'xml', 
			colNames:col[0],
			colModel:col[1],
			       	rowNum:10, 
			       	rowList:[10,20,30], 
			       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
			       	pager: jQuery('#pager4'), 
			       	sortname:'DeptCode', 
			       	viewrecords: true, 
			       	sortorder: 'asc', 
			       	caption:captions[3], 
			       	height:150,
			       	width:(document.documentElement.clientWidth-30)/2,
			       	loadComplete:function(){
			       		if($("#grid4 tr.jqgrow[id='1']").html()=="")
							return false;
			       		//addRowOperBtn("grid4","<fmt:message key='global.edit' />",'modifyRow','DeptCode','click',1);
			       		//addRowOperBtn("grid4","<fmt:message key='global.delete' />",'deleteRow','DeptCode','click',2);
			       		addRowOperBtnimage('grid4','modifyRow','DeptCode','click',1,"style/images/public/ltubiao_01.gif","<fmt:message key='global.edit' />","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
						addRowOperBtnimage('grid4','deleteRow','DeptCode','click',2,"style/images/public/ltubiao_02.gif","<fmt:message key='global.delete' />","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
						executeAddBtn("grid4",2);
			       	}
			}).navGrid('#pager4', {edit: false, add: false, add: false, del: false, search: false}, //options 
				{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
				{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
				{reloadAfterSubmit:false}, // del options 
				{} // search options 
				); 
	}
	
/**
 * 复合查询参数获取
 * @param 无参数
 * @return String
 */
 function fuheQbuildParams(){
 	//每次拼接参数必须初始化此参数
	tsd.QualifiedVal=true;
 	var params='';
 	var fusearchsql = encodeURIComponent($("#fusearchsql").val());
 	//如果有可能值是汉字 请使用encodeURI()函数转码
 	params+='&fusearchsql='+fusearchsql;			 	
 	//注意：不要在此做空的判断 即使为空 也必须放入请求中			 	
 	//每次拼接参数必须添加此判断
	if(tsd.Qualified()==false){return false;}
	return params;
 }
/**
 * 打开下载页面
 * @param status(状态)
 * @return 无返回值
 */
 var tabStatus = 0;
function openExport(status)
	{
		
		tabStatus = status;	
		if(checkPrevStatus())
		{
			var operationtips = "<fmt:message key='global.operationtips' />";
			alert("<fmt:message key='deptLevelS.chooseDept'/>",operationtips);
			//alert("<fmt:message key='addressManage.choosePar' />");
			return false;
		}
		
		var prevNo = "";
		//alert("SEL1:"+seledRow);
		//非第一个表格的时候取前缀
		if(seledRow > 0)
		{
			prevNo = $("#grid"+(tabStatus-1)).getCell(seledRow,"DeptCode");
		}	
		switch(tabStatus){
			case 1:
				$("#fusearchsql").val("length(DeptCode)=3");
				thisDownLoad('tsdBilling','mssql','department','<%=languageType %>');	
				break;
			case 2:
				$("#fusearchsql").val("DeptCode like '"+prevNo+".___'");
				thisDownLoad('tsdBilling','mssql','department_fu','<%=languageType %>');	
				break;
			case 3:
				$("#fusearchsql").val("DeptCode like '"+prevNo+".___'");
				thisDownLoad('tsdBilling','mssql','department_fu','<%=languageType %>');	
				break;
			case 4:
				$("#fusearchsql").val("DeptCode like '"+prevNo+".__'");
				thisDownLoad('tsdBilling','mssql','department_fu','<%=languageType %>');	
				break;
		}	
	}
/**
 * 下载函数，根据全局变量tabStatus进行判断状态
 * @param 无参数
 * @return 无返回值
 */
function getTheCheckedField(){
		switch(tabStatus){
			case 1:
				getTheCheckedFields('tsdBilling','mssql','department');
				break;
			case 2:
				getTheCheckedFields('tsdBilling','mssql','department','department_fu');
				break;
			case 3:
				getTheCheckedFields('tsdBilling','mssql','department','department_fu');	
				break;
			case 4:
				getTheCheckedFields('tsdBilling','mssql','department','department_fu');
				break;
		}	
}
 
	</script>
	
<script type="text/javascript">

/**
 * 关闭一级部门表格面板
 * @param 无参数
 * @return 无返回值
 */
function closeo_a(){
		if(closeflash_a){
		 		 closeflash_a=false;
		 		 $("#grid"+tabStatus).trigger("reloadGrid");		 		 
		 }
		 
		clearText('operformT');		
		setTimeout($.unblockUI, 15);
}
/**
 * 打开一级部门表格面板
 * @param 无参数
 * @return 无返回值
 */
function openpan_a(){		
		autoBlockFormAndSetWH('pan_a',60,5,'closeo_a',"#ffffff",false,1000,'');//弹出查询面板
		$("#readd_a").hide();$("#save_a").hide();$("#modify_a").hide();$("#reset_a").hide();$("#clearB_a").hide();
}
/**
 * 关闭表格面板
 * @param 无参数
 * @return 无返回值
 */
function closeo(){
		if(closeflash){
		 		 closeflash=false;
		 		 $("#grid"+tabStatus).trigger("reloadGrid");		 		 
		 }
		 
		clearText('operformT1');		
		setTimeout($.unblockUI, 15);
}
/**
 * 打开表格面板
 * @param 无参数
 * @return 无返回值
 */
function openpan(){		
		autoBlockFormAndSetWH('pan',60,5,'closeo',"#ffffff",false,1000,'');//弹出查询面板
		$("#readd").hide();$("#save").hide();$("#modify").hide();$("#reset").hide();$("#clearB").hide();
}
/**
 * 修改单挑记录时的信息重置方法
 * @param 无参数
 * @return 无返回值
 */
function resett(){
		var DeptCode=$("#DeptCode").text();
		
		markTable(1);//显示红色*号		
		$(".top_03").html('<fmt:message key="deptLevelS.detailmessage" />');//设置编辑框的标题
		
		
			//更新状态
			bindStatusToModifyAndDelete(DeptCode);
			var DeptName = fetchSingleValue("deptLevelS.sell",6,"&DeptCode="+DeptCode);
			if(DeptName == 'undefined')
			{
				return false;
			}
			
			openpan();
			$("#modify").show();$("#reset").show();
			clearText('operformT1');
			
			$("#DeptName").val(DeptName);
			$("#DeptName1").text(DeptName);
}	
/**
 * 修改单挑记录时的信息重置方法
 * @param 无参数
 * @return 无返回值
 */
function resett_a(){			
			$("#DeptName_a").val($("#DeptName1_a").val());
			$("#DeptGroup_a").val($("#DeptGroup1_a").val());
}
</script>
  </head>
  
  <body>
	<form name="childform" id="childform">
		<input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
		<input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
	</form>
	
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /> 
	<input type="hidden" id="skrid" name="skrid" value='<%=request.getSession().getAttribute("userid")%>' />	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' /> 
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' /> 
	<input type="hidden" name="languageType" id="languageType" value='<%=lanType%>' />
    

	<div id="navBar1" style="font-size:14px;">
		<img src="style/icon/dot11.gif" style="margin-left: 10px" />
		<fmt:message key="global.location" />
		:	
	</div>
<div id="zong" >
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
					<button type="button" id="export1" onclick="openExport(1)"> 
						<!--导出--><fmt:message key="global.exportdata" />
					</button>	
					<!--打印				
					<button type="button" id="print1" onclick="printR(1)">
						<fmt:message key="tariff.printer" />
					</button>	
					-->		
				</div>
				<div id="g_g_1"></div>
				<div id="buttons" style="display: none;">
					<button type="button" id="openorder11" onclick="showDialog(0,1)">
						<!--排序--><fmt:message key="tariff.order" />
					</button>		
					<button type="button" id="openadd11" onclick="openAddForm(1)">
						<!--添加--><fmt:message key="global.add" />
				    </button>
					<button type="button" id="export11" onclick="openExport(1)"> 
						<!--导出--><fmt:message key="global.exportdata" />
					</button>	
					<!--打印				
					<button type="button" id="print11" onclick="printR(1)">
						<fmt:message key="tariff.printer" />
					</button>	
					-->		
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
					<button type="button" id="export2" onclick="openExport(2)"> 
						<!--导出--><fmt:message key="global.exportdata" />
					</button>	
					<!--打印				
					<button type="button" id="print2" onclick="printR(2)">
						<fmt:message key="tariff.printer" />
					</button>
					-->			
				</div>
				<div id="g_g_2"></div>
					<div id="buttons" style="display: none;">
			
					<button type="button" id="openorder21" onclick="showDialog(0,2)">
						<!--排序--><fmt:message key="tariff.order" />
					</button>	
				
					<button type="button" id="openadd21" onclick="openAddForm(2)">
						<!--添加--><fmt:message key="global.add" />
				    </button>
					<button type="button" id="export21" onclick="openExport(2)"> 
						<!--导出--><fmt:message key="global.exportdata" />
					</button>
					<!--打印				
					<button type="button" id="print21" onclick="printR(2)">
						<fmt:message key="tariff.printer" />
					</button>
					-->				
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
					<button type="button" id="export3" onclick="openExport(3)"> 
						<!--导出--><fmt:message key="global.exportdata" />
					</button>	
					<!--打印				
					<button type="button" id="print3" onclick="printR(3)">
						<fmt:message key="tariff.printer" />
					</button>
					-->			
				</div>
				<div id="g_g_3"></div>
				<div id="buttons" style="display: none;">
				
					<button type="button" id="openorder31" onclick="showDialog(0,3)">
						<!--排序--><fmt:message key="tariff.order" />
					</button>	
					
					<button type="button" id="openadd31" onclick="openAddForm(3)">
						<!--添加--><fmt:message key="global.add" />
				    </button>
					<button type="button" id="export31" onclick="openExport(3)"> 
						<!--导出--><fmt:message key="global.exportdata" />
					</button>	
					<!--打印				
					<button type="button" id="print31" onclick="printR(3)">
						<fmt:message key="tariff.printer" />
					</button>	
					-->		
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
					<button type="button" id="export4" onclick="openExport(4)"> 
						<!--导出--><fmt:message key="global.exportdata" />
					</button>	
					<!--打印				
					<button type="button" id="print4" onclick="printR(4)">
						<fmt:message key="tariff.printer" />
					</button>	
					-->		
				</div>
				<div id="g_g_4"></div>
					<div id="buttons" style="display: none;">
					
					<button type="button" id="openorder41" onclick="showDialog(0,4)">
						<!--排序--><fmt:message key="tariff.order" />
					</button>
					
					<button type="button" id="openadd41" onclick="openAddForm(4)">
						<!--添加--><fmt:message key="global.add" />
				    </button>
					<button type="button" id="export41" onclick="openExport(4)"> 
						<!--导出--><fmt:message key="global.exportdata" />
					</button>	
					<!--打印				
					<button type="button" id="print41" onclick="printR(4)">
						<fmt:message key="tariff.printer" />
					</button>
					-->			
				</div>
			</td>
		</tr>
	</table>

</div>
<!-- 添加修改面板 -->
<div class="neirong" id="pan_a" style="display: none">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="deptLevelS.functionname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='operformT' name="operformT" onsubmit="return false;" action="#" >
		<input type="hidden" />
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			
			  <tr>			   
			    <td width="12%" align="right" class="labelclass"><label id="DeptNameg_a" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			   		
			   		<!-- 
			   		<select name="DeptName_a" id="DeptName_a" onchange="setHth();" class="textclass">
			   			<option value="">--请选择--</option>
			   		</select>
			   		 -->
			    	<input type="text" name="DeptName_a" id="DeptName_a" class="textclass"></input>	
			    	<label class="addred" ></label>
			    	<input type="hidden" id="DeptName1_a"/>				
					</td>								
			   
			   <!-- 
			    <td width="12%" align="right"  class="labelclass"><label id="hthg_a" ></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="hth_a" id="hth_a" class="textclass2" disabled="disabled"></input>	
			    </td>
			     -->
			
			    <td width="12%" align="right"  class="labelclass"><label id="DeptGroupg_a" ></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="DeptGroup_a" id="DeptGroup_a" class="textclass" onpropertychange="TextUtil.NotMax(this)" maxlength="32"></input>	
			    	<input type="hidden" id='DeptGroup1_a'/>
			    </td>
			    
			    <td width="12%" align="right"  class="labelclass"></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    </td>
			</tr>	 
		  
		</table>
		</form>	
		<div class="midd_butt">
		<!-- 保存新增 --><button class="tsdbutton" id="readd_a" style="width:80px;heigth:27px;" onclick="saveObj_a(1);" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
	 	<!-- 保存退出 --><button class="tsdbutton" id="save_a" style="width:80px;heigth:27px;" onclick="saveObj_a(2);" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
		<!-- 修改     --><button class="tsdbutton" id="modify_a" style="width:63px;heigth:27px;" onclick="ModifyData_a();"><fmt:message key="global.edit" /></button>		    
	    <!-- 清空     --><button class="tsdbutton" id="clearB_a" style="width:63px;heigth:27px;" onclick="clearText_a('operformT');" ><fmt:message key="global.clear" /></button>
	    <!-- 取消     --><button class="tsdbutton" id="reset_a" style="width:63px;heigth:27px;" onclick="resett_a();" ><fmt:message key="deptLevelS.cancel" /></button>
		<!-- 关闭 	 --><button class="tsdbutton" id="closeo_a" style="width:63px;heigth:27px;" onclick="closeo_a();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>


<!-- 添加修改面板 -->
<div class="neirong" id="pan" style="display: none">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="deptLevelS.functionname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='operformT1' name="operformT1" onsubmit="return false;" action="#" >
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			
			  <tr>			   
			    <td width="12%" align="right" class="labelclass"><label id="DeptName_l" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="DeptName" id="DeptName" class="textclass"></input>							
					<label class="addred" ></label></td>								
			   
			    <td width="12%" align="right"  class="labelclass"></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<span id="DeptCode" style="display:none;"></span><span id="DeptName1" style="display:none;"></span>	</td>
			
			    <td width="12%" align="right"  class="labelclass"></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
			</tr>	 
		  
		</table>
		</form>	
		<div class="midd_butt">
		<!-- 保存新增 --><button class="tsdbutton" id="readd" style="width:80px;heigth:27px;" onclick="saveObj(1);" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
	 	<!-- 保存退出 --><button class="tsdbutton" id="save" style="width:80px;heigth:27px;" onclick="saveObj(2);" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
		<!-- 修改     --><button class="tsdbutton" id="modify" style="width:63px;heigth:27px;" onclick="ModifyData();"><fmt:message key="global.edit" /></button>		    
	    <!-- 清空     --><button class="tsdbutton" id="clearB" style="width:63px;heigth:27px;" onclick="clearText('operformT1');" ><fmt:message key="global.clear" /></button>
	    <!-- 取消     --><button class="tsdbutton" id="reset" style="width:63px;heigth:27px;" onclick="resett();" ><fmt:message key="deptLevelS.cancel" /></button>
		<!-- 关闭 	 --><button class="tsdbutton" id="closeo" style="width:63px;heigth:27px;" onclick="closeo();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>


	<input type="hidden" id="addright" />
	<input type="hidden" id="deleteright" />
	<input type="hidden" id="editright" />
	<input type="hidden" id="delBright" />
	<input type="hidden" id="editBright" />
	<input type="hidden" id="exportright" />
	<input type="hidden" id="printright" />
					<input type="hidden" id="addinfo"
						value="<fmt:message key="global.add"/>" />
					<input type="hidden" id="deleteinfo"
						value="<fmt:message key="global.delete"/>" />
					<input type="hidden" id="editinfo"
						value="<fmt:message key="global.edit"/>" />
					<input type="hidden" id="queryinfo"
						value="<fmt:message key="global.query"/>" />

					<input type="hidden" id="operation"
						value="<fmt:message key="global.operation"/>" />
					<input type="hidden" id="operationtips"
						value="<fmt:message key="global.operationtips"/>" />
					<input type="hidden" id="successful"
						value="<fmt:message key="global.successful"/>" />
					<input type="hidden" id="deleteinformation"
						value="<fmt:message key="global.deleteinformation"/>" />
				
				<!-- grid自动 -->
			<input type="hidden" id='ziduansF' />
			<input type="hidden" id='ziduansF1' />
			<input type='hidden' id='thecolumn'/>	
		
		
		
		<!-- 导出数据 -->
			<div class="neirong" id="thefieldsform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv"><fmt:message key="deptLevelS.chooseexportdata" /></div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();"><fmt:message key="deptLevelS.close" /></a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd" >
					   <form action="#" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<div id="thelistform" style="margin-left: 10px;max-height: 200px;overflow-y: auto;overflow-x: hidden;">
								
									</div>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" id="query" onclick="checkedAllFields()">
						<fmt:message key="deptLevelS.selectall" />
					</button>
					<button type="submit" class="tsdbutton" id="query" onclick="getTheCheckedField()">
						<fmt:message key="global.ok" />
					</button>
					<button type="button" class="tsdbutton" id="closethisinfo" >
						<fmt:message key="global.close" />
					</button>
					
				</div>
		</div>	
		
		
		<input type="hidden" id="whickOper"/>
		<input type="hidden" id="imenuid" value="<%=imenuid%>" />
		<input type="hidden" id="zid" value="<%=zid%>" />
		<%
			if (!languageType.equals("en")) {
				languageType = "zh";
			}
		%>
		<input type="hidden" id="languageType" value="<%=languageType%>" />
  </body>
</html>
