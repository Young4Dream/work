<%----------------------------------------
	name: revparam.jsp
	author: chenze
	version: 1.0, 2010-10-20
	description: 电话营收参数配置
	modify: 
		2010-11-08 chenze 移植
		2010-11-08 chenze 添加注释

---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'sdyf.jsp' starting page</title>
    <link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
	<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
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
	
	<script src="plug-in/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
	<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
	<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen"/>
		

	<!-- 关于字符串需要用到的js -->
	<script type="text/javascript" src="script/public/main.js"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
	<style type="text/css">
	.btns,#kdButtons,#ghButtons{width:100%; float:left; *float:none; height:36px; background:url(style/imgs/buttonsbg.jpg) repeat-x; border-top:#CCCCCC 1px solid;border-bottom:#CCCCCC 1px solid;}
	.txtInput{width:110px;}
	
	</style>
	<script type="text/javascript">
	/**
	 * 页面加载时执行
	 * @param
	 * @return 
	 */
	$(function(){
		//加载导航栏
		$("#navBar").append(genNavv());
		//生成返回按钮
		gobackInNavbar("navBar");
		
		var optHtml = "";
		for(var i=1;i<=12;i++)
		{
			optHtml += "<option value=\""+i+"\">"+i+"</option>";
		}
		//初始化收费区段月数 欠费催缴月 ,滞纳金月,欠费降级月 
		$("#sfqdys,#qfcjrq_m,#znjrq_m,#qfjjrq_m").html(optHtml);
		
		optHtml = "";
		for(var i=1;i<=31;i++)
		{
			optHtml += "<option value=\""+i+"\">"+i+"</option>";
		}
		//初始化  欠费催缴日 ,滞纳金日,欠费降级日
		$("#qfcjrq_d,#znjrq_d,#qfjjrq_d").html(optHtml);
		
		$("#maintab fieldset").parent().css("height","170px");
		
		getBlockOne();
		getQzfs();
		getBlockTwo();
		getBlockThree();
	});
	/**
	 * 根据节和项取参数值
	 * @param tsection 配置节
	 * @param tident   配置项
	 * @return 配置值
	 */
	function getIni(tsection,tident)
	{
		var res = fetchSingleValue("Revenue.getIni",6,"&TS=" + tsd.encodeURIComponent(tsection) + "&TI=" + tsd.encodeURIComponent(tident));
		return res;
	}
	/**
	 * 根据节和项设置参数值(同步方式)
	 * @param tsection 配置节
	 * @param tident   配置项
	 * @param tval     要被设置的值
	 * @return  成功则为true失败为false
	 */
	function setIni(tsection,tident,tval)
	{
		if(tsection==undefined || tident==undefined || tval==undefined)
		{
			alert("请提供正确的参数");
			return false;
		}
		var res = executeNoQuery("Revenue.setIni",6,"&TS=" + tsd.encodeURIComponent(tsection) + "&TI=" + tsd.encodeURIComponent(tident) + "&TV=" + tsd.encodeURIComponent(tval));
		if(res=="true" || res==true)
		{
			return true;
		}
		else return false;
	}
	/**
	 * 根据节和项设置参数值(异步方式)
	 * @param tsection 配置节
	 * @param tident   配置项
	 * @param tval     要被设置的值
	 * @return  成功则为true失败为false
	 */
	function asyncSetIni(tsection,tident,tval)
	{
		var urll = tsd.buildParams({ packgname:'service',
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:'tsdBilling',
				tsdcf:'mssql',//指向配置文件名称
				tsdoper:'exe',//操作类型 
				datatype:'xml',//返回数据格式 
				tsdpk:'Revenue.setIni'
				});
		$.ajax({
			url:"mainServlet.html?" + urll + "&TS=" + tsd.encodeURIComponent(tsection) + "&TI=" + tsd.encodeURIComponent(tident) + "&TV=" + tsd.encodeURIComponent(tval),
			async:true,
			cache:false,
			timeout:2000,
			type:'post',
			success:function(xml)
			{
				if(xml=="true"){
					//alert(tsection + tident +　"　保存功能");
				}else{
					alert(tsection + tident +　"　保存失败");
				}
			}		
		});
	}
	/**
	 * 查询页面第一区块的值
	 * @param 
	 * @return  
	 */
	function getBlockOne()
	{
		var res = fetchMultiArrayValue("Revenue.getsfparam",6,"");
		if(res[0]==undefined || res[0][0]==undefined)
		{
			
		}
		else
		{
			$("#sfyf").val(res[0][0]);
			$("#cjrq").val(res[0][1]);
			$("#znjrq").val(res[0][2]);
			$("#qfjjrq").val(res[0][3]);
		}
	}
	/**
	 * 设置页面手工调整营收区块的值
	 * @param
	 * @return
	 */
	function setBlockOne()
	{
		executeNoQuery("Revenue.delsfparam",6,"&sfmonth=" + tsd.encodeURIComponent($("#sfyf").val()));
		var res = executeNoQuery("Revenue.addsfparam",6,"&sfmonth=" + tsd.encodeURIComponent($("#sfyf").val()) + "&qfcj=" + tsd.encodeURIComponent($("#cjrq").val()) + "&znjqs=" + tsd.encodeURIComponent($("#znjrq").val()) + "&qfjj=" + tsd.encodeURIComponent($("#qfjjrq").val()));
		if(res=="true" || res==true)
		{
			alert("保存成功");
		}
		else alert("保存失败");
	}
	
	/**
	 * 设置三种取整方式的值
	 * @param
	 * @return 
	 */
	function setQzfs()
	{
		var res = true;
		res = res && setIni("电话汇总表","取整方式",$("#dhhzbqz").val());
		res = res && setIni("合同号汇总表","取整方式",$("#hthhzbqz").val());
		res = res && setIni("收费结账","取整方式",$("#sfjzqz").val());
		if(res!=true)
			alert("部分数据保存失败");
		else
			alert("保存成功");
	}
	/**
	 * 获取取整方式的值
	 * @param
	 * @return
	 */
	function getQzfs()
	{
		$("#dhhzbqz").val(getIni("电话汇总表","取整方式"));
		$("#hthhzbqz").val(getIni("合同号汇总表","取整方式"));
		$("#sfjzqz").val(getIni("收费结账","取整方式"));
	}
	/**
	 * 获取 当前收费月,预收款年息,日滞纳金比率
	 * @param
	 * @return 
	 */
	function getBlockTwo()
	{
		//$("#dqsfyf").val(getIni("收费结账","当前收费月份"));
		$("#dqsfyf").val(getIni("charge","current paymonth"));
		$("#ysknx").val(getIni("收费结账","预收款年息"));
		$("#rznjbl").val(getIni("收费结账","日滞纳金比率"));
	}
	/**
	 * 设置 当前收费月,预收款年息,日滞纳金比率
	 * @param
	 * @return 
	 */
	function setBlockTwo()
	{
		var res = true;
		//asyncSetIni("收费结账","当前收费月份",$("#dqsfyf").val());
		asyncSetIni("charge","current paymonth",$("#dqsfyf").val());
		res = res && setIni("收费结账","预收款年息",$("#ysknx").val());
		res = res && setIni("收费结账","日滞纳金比率",$("#rznjbl").val());
		if(res!=true)
			alert("部分数据保存失败");
		else
			alert("保存成功");
			
		getBlockTwo();
	}
	/**
	 * 获取 收费区段月数,欠费催缴日期,滞纳金日期,欠费降级日期
	 * @param
	 * @return 
	 */
	function getBlockThree()
	{
		$("#sfqdys").val(getIni("收费区间默认参数","收费区段月数"));
		
		$("#qfcjrq_d").val(getIni("收费区间默认参数","欠费催缴日"));
		$("#znjrq_d").val(getIni("收费区间默认参数","纳金起算日"));
		$("#qfjjrq_d").val(getIni("收费区间默认参数","欠费降级日"));
		
		$("#qfcjrq_m").val(getIni("收费区间默认参数","欠费催缴月"));
		$("#znjrq_m").val(getIni("收费区间默认参数","纳金起算月"));
		$("#qfjjrq_m").val(getIni("收费区间默认参数","欠费降级月"));

	}
	/**
	 * 设置 收费区段月数,欠费催缴日期,滞纳金日期,欠费降级日期
	 * @param
	 * @return 
	 */
	function setBlockThree()
	{
		var res = true;
		res = res && setIni("收费区间默认参数","收费区段月数",$("#sfqdys").val());
		
		res = res && setIni("收费区间默认参数","欠费催缴日",$("#qfcjrq_d").val());
		res = res && setIni("收费区间默认参数","纳金起算日",$("#znjrq_d").val());
		res = res && setIni("收费区间默认参数","欠费降级日",$("#qfjjrq_d").val());
		
		res = res && setIni("收费区间默认参数","欠费催缴月",$("#qfcjrq_m").val());
		res = res && setIni("收费区间默认参数","纳金起算月",$("#znjrq_m").val());
		res = res && setIni("收费区间默认参数","欠费降级月",$("#qfjjrq_m").val());
		if(res!=true)
			alert("部分数据保存失败");
		else
			alert("保存成功");
			
		getBlockThree();
	}
	/**
	 * 数据输入格式校验 ，只能输入两位有效正数
	 * @param obj 将要被限制的控件
	 * @return 
	 */
	function numValid(obj)
	{		
		if($.browser.msie)
		{
			var dotPos = obj.value.indexOf(".");
			var lenAfterDot;
			
			if(dotPos==-1)
			{
				lenAfterDot = 0;
			}
			else
			{
				lenAfterDot = obj.value.length - dotPos -1;
			}
			
			var evt = window.event;
			//if(event.keyCode==190)
			//alert(event.keyCode);
			if (evt.keyCode < 48 || evt.keyCode > 57)
			{
				if(evt.keyCode==46)
				{
					if(dotPos==-1)
						lenAfterDot=0;
					else
						evt.returnValue = false;
				}
				else
				{
					evt.returnValue = false;
				}
			}
			else
			{
				if(dotPos!=-1)
				{
					if(lenAfterDot>=2)
					{
						evt.returnValue = false;
					}
				}
			}
		}
		else
		{
			obj.value=obj.value.replace(/[^0-9]/g,'');
		}
	}

	</script>
  </head>
  
  <body>
  	<div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:		
	</div>
	<div style="text-align:center;">
		<table id="maintab" width="950">
			<tr>
				<td>
					<fieldset style="text-align:left;width:450px;">
				    	<legend style="font-size:14px">手工调整营收参数</legend>
				    	<br />
						<table>
							<tr>
								<td>收费月份：</td><td><input type="text" name="sfyf" id="sfyf" class="txtInput" onfocus="WdatePicker({startDate:'%y-%M',dateFmt:'yyyyMM',alwaysUseStartDate:true});" /></td>
								<td>催缴日期：</td><td><input type="text" name="cjrq" id="cjrq" class="txtInput" onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" /></td>
							</tr>
							<tr>
								<td>滞纳金日期：</td><td><input type="text" name="znjrq" id="znjrq" class="txtInput" onfocus="WdatePicker({startDate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" /></td>
								<td>欠费降级日期：</td><td><input type="text" name="qfjjrq" id="qfjjrq" class="txtInput" onfocus="WdatePicker({startDate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" /></td>
							</tr>
						</table>
					    <button class="tsdbutton" onclick="setBlockOne()">保存</button> 
				    </fieldset>
				</td>
				<td>
					<fieldset style="text-align:left;width:450px;">
				    	<legend style="font-size:14px">当前收费月,预收款年息,日滞纳金比率</legend>
				    	<br />
						<table>
							<tr>
								<td>收费月份：</td><td><input type="text" name="dqsfyf" id="dqsfyf" class="txtInput" onfocus="WdatePicker({startDate:'%y%M',dateFmt:'yyyyMM',alwaysUseStartDate:true});" /></td>
								<td>预收款年息：</td><td><input type="text" name="ysknx" id="ysknx" class="txtInput" onkeypress="numValid(this)" /> </td>
							</tr>
							<tr>
								<td>日滞纳金比率：</td><td><input type="text" name="rznjbl" id="rznjbl" class="txtInput" onkeypress="numValid(this)" /></td>
								<td></td><td></td>
							</tr>
						</table>
					    <button class="tsdbutton" onclick="setBlockTwo()">保存</button> 
				    </fieldset>
				</td>
			</tr>
			<tr>
				<td>
					<fieldset style="text-align:left;width:450px;">
				    	<legend style="font-size:14px">收费区段月数,欠费催缴日期,滞纳金日期,欠费降级日期</legend>
				    	<br />
						<table>
							<tr>
								<td>收费区段月数：</td><td><select name="sfqdys" id="sfqdys" class="txtInput"></select></td>								
							</tr>
							<tr>
								<td>欠费催缴日期：</td><td>收费区段第<select name="qfcjrq_m" id="qfcjrq_m"></select>月的第<select name="qfcjrq_d" id="qfcjrq_d"></select>日&nbsp;&nbsp;&nbsp;&nbsp;</td>
							</tr>
							<tr>
								<td>滞纳金日期：</td><td>收费区段第<select name="znjrq_m" id="znjrq_m"></select>月的第<select name="znjrq_d" id="znjrq_d"></select>日&nbsp;&nbsp;&nbsp;&nbsp;</td>
							</tr>
							<tr>
								<td>欠费降级日期：</td><td>收费区段第<select name="qfjjrq_m" id="qfjjrq_m"></select>月的第<select name="qfjjrq_d" id="qfjjrq_d"></select>日&nbsp;&nbsp;&nbsp;&nbsp;</td>
							</tr>
						</table>
					    <button class="tsdbutton" onclick="setBlockThree()">保存</button> 
				    </fieldset>
				</td>
				<td>
					<fieldset style="text-align:left;width:450px;">
				    	<legend style="font-size:14px">取整设置</legend>
				    	<br />
						<table>
							<tr>
								<td>电话汇总表：</td><td><select name="dhhzbqz" id="dhhzbqz"><option value="不取整">不取整</option><option value="按角取整">按角取整</option><option value="按元取整">按元取整</option><option value="按五元取整">按五元取整</option><option value="按十元取整">按十元取整</option></select></td>
							</tr>
							<tr>
								<td>合同号汇总表：</td><td><select name="hthhzbqz" id="hthhzbqz"><option value="不取整">不取整</option><option value="按角取整">按角取整</option><option value="按元取整">按元取整</option><option value="按五元取整">按五元取整</option><option value="按十元取整">按十元取整</option></select></td>
							</tr>
							<tr>
								<td>收费结账：</td><td><select name="sfjzqz" id="sfjzqz"><option value="不取整">不取整</option><option value="按角取整">按角取整</option><option value="按元取整">按元取整</option><option value="按五元取整">按五元取整</option><option value="按十元取整">按十元取整</option></select></td>
							</tr>
						</table>
					    <button class="tsdbutton" onclick="setQzfs()">保存</button> 
				    </fieldset>
				</td>
			</tr>
		</table>
	    
  	</div>
  </body>
</html>
