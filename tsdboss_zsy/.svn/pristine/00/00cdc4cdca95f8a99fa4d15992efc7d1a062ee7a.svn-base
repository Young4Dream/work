<%----------------------------------------
	name: tsdboss/WEB-INF/template/telephone/charge/chargeparamset.jsp
	author: lvkui
	version: 2.0, 2012-10-31
	description: 电话营收参数配置
	modify: 


---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>电话营收参数配置</title>
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<script src="script/public/mainStyle.js" type="text/javascript"></script>
		

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
		var s_czyf=getIni("汇总选项","当前出帐月");
		$("#czyf").val(s_czyf);
		if (s_czyf == undefined)
		{
		    $("#div_fir").attr("style","display:none;");
		}
		
		var s_ztsf = getIni("charge","pause charge");
		$("#ztsf").val(s_ztsf);
		if(s_ztsf == undefined){
			$("#div_ztsf").attr("style","display:none;"); 
		}		
		
		var s_sfyf=getIni("收费结账","当前收费月份");
		if (s_sfyf == undefined)
		  s_sfyf=getIni("charge","current paymonth");
		$("#sfyf").val(s_sfyf);
		if (s_sfyf == undefined)
		{
		    $("#div_sec").attr("style","display:none;");      
		}
		
		var s_fbyf=getIni("汇总选项","WEB发布月");
		$("#fbyf").val(s_fbyf);
		if (s_fbyf == undefined)
		{
		    $("#div_thr").attr("style","display:none;");      
		}
		
		var optHtml = "";
		for(var i=1;i<=12;i++)
		{
			optHtml += "<option value=\""+i+"\">"+i+"</option>";
		}
		//初始化收费区段月数 欠费催缴月 ,滞纳金月,欠费降级月 
		//$("#sfqdys,#qfcjrq_m,#znjrq_m,#qfjjrq_m").html(optHtml);
		
		optHtml = "";
		for(var i=1;i<=31;i++)
		{
			optHtml += "<option value=\""+i+"\">"+i+"</option>";
		}
		//初始化  欠费催缴日 ,滞纳金日,欠费降级日
		//$("#qfcjrq_d,#znjrq_d,#qfjjrq_d").html(optHtml);
		
		//$("#maintab fieldset").parent().css("height","170px");
		
		//getBlockOne();
		//getQzfs();
		//getBlockTwo();
		//getBlockThree();
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
				if(xml=="true") alert(tsection + tident +"　保存功能");
				else
					alert(tsection + tident + "　保存失败");
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
	/**
	 * func  在月份输入框获取焦点时是否可以选择月份
	 * @param id:月份输入框的id属性值
	 * @return 
	 * @desc  月份输入框的自定义属性"sel"的值为1时表示不能选择，为0时表示可以选择
	 */
	function getYearAndMonth(id)
	{
        var sval = $("#"+id).attr("sel");
		//alert(sval);
		if (sval=="1")
		    return;
		else
		    WdatePicker({startDate:'%y-%M',dateFmt:'yyyyMM',alwaysUseStartDate:true});
	}
	/**
	 * func  设置月份输入框的修改状态
	 * @param id:月份输入框的id属性值
	 * @return 
	 * @desc  修改 保存 取消按钮的id属性值命令规则为：所在月份输入框的id加上"_"，再加上功能标识
	 */
    function setModifyStatus(id)
	{
        var sval = $("#"+id).val();
		$("#back_"+id).val(sval);
		$("#"+id).attr("sel","0");
		$("#"+id+"_edit").attr("disabled","disabled");
		$("#"+id+"_save").removeAttr("disabled");
		$("#"+id+"_cancel").removeAttr("disabled");
		
		if(id == "ztsf"){
			$("#ztsf").removeAttr("disabled");
		}
	}
	/**
	 * func  保存修改结果
	 * @param id:月份输入框的id属性值
	 * @return 
	 * @desc  修改 保存 取消按钮的id属性值命令规则为：所在月份输入框的id加上"_"，再加上功能标识
	 */
	function save(id)
	{
		if (id=="ztsf"){
			var sval = $("#"+id).val();
			var bval = false;
			if (sval==undefined || sval=="")
			{
			    alert("请选择正确的参数");
				return;
			}			
			 bval=setIni("charge","pause charge",sval);
			 if (bval){
				 $("#"+id+"_edit").removeAttr("disabled");
				 $("#"+id).attr("disabled","disabled");
				 $("#"+id+"_save").attr("disabled","disabled");
				 $("#"+id+"_cancel").attr("disabled","disabled");
				 $("#"+id).attr("sel","1");
				 alert("数据保存成功！");
			 }
			 else
				{
				    alert("对不起，数据保存失败！");
				}
		}else{
				var sval = $("#"+id).val();
				var bval = false;
				if (sval==undefined || sval=="")
				{
				    alert("请选择一个正确的月份。");
					return;
				}
				if (id=="czyf")
				    bval=setIni("汇总选项","当前出帐月",sval);
			    else if (id=="sfyf")
				    bval=setIni("charge","current paymonth",sval);
				else if (id=="fbyf")
				    bval=setIni("汇总选项","WEB发布月",sval);
				if (bval)
				{	
				    $("#back_"+id).val("");
				    $("#"+id+"_edit").removeAttr("disabled");
				    $("#"+id+"_save").attr("disabled","disabled");
				    $("#"+id+"_cancel").attr("disabled","disabled");
				    $("#"+id).attr("sel","1");
					alert("数据保存成功！");
				}
				else
				{
				    alert("对不起，数据保存失败！");
				}
		}
		
	}
	/**
	 * func  取消修改状态，并将值还原
	 * @param id:月份输入框的id属性值
	 * @return 
	 * @desc  修改 保存 取消按钮的id属性值命令规则为：所在月份输入框的id加上"_"，再加上功能标识
	 */
	function cancel(id)
	{
	    var sval = $("#back_"+id).val();
		$("#"+id).val(sval);
		$("#back_"+id).val("");
		$("#"+id+"_edit").removeAttr("disabled");
		$("#"+id+"_save").attr("disabled","disabled");
		$("#"+id+"_cancel").attr("disabled","disabled");
		$("#"+id).attr("sel","1");
	}
	</script>
  </head>
  
  <body>
  	<div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:		
	</div>
	
	<div style="text-align:left; padding-top:20px; padding-left:10px" id="div_ztsf">
        <fieldset style="text-align:left;width:450px; margin-top:20px">
		    <legend style="font-size:14px">设置收费控制</legend>
		    <br />
			<table id="ztsftab" width="100%">
			    <tr>
			        <td><span>是否暂停收费：</span></td>
			        <!-- <td><input type="text" name="ztsf" id="ztsf" class="txtInput" readonly="true" sel="1"/></td> -->
			        <td>
			        <select id="ztsf" class="txtInput" readonly="true"  disabled>
						<option value="T">是</option>
						<option value="F">否</option>
			        </select>
			        </td>
			        <td>
			        &nbsp;&nbsp;<button class="tsdbutton" id="ztsf_edit" onClick="setModifyStatus('ztsf')">修&nbsp;&nbsp;改</button>
				    &nbsp;&nbsp;<button class="tsdbutton" id="ztsf_save" onClick="save('ztsf')" disabled="disabled">保&nbsp;&nbsp;存</button>
			        &nbsp;&nbsp;<button class="tsdbutton" id="ztsf_cancel" onClick="cancel('ztsf')" disabled="disabled">取&nbsp;&nbsp;消</button></td>
			</tr>
			</table>
		</fieldset>	   	
	</div>	
	
	<div style="text-align:left; padding-top:20px; padding-left:10px" id="div_fir">
        <fieldset style="text-align:left;width:450px; margin-top:20px">
		    <legend style="font-size:14px">设置当前出帐月</legend>
		    <br />
			<table id="maintab" width="100%">
			    <tr>
			        <td><span>当前出帐月：</span></td>
			        <td><input type="text" name="czyf" id="czyf" class="txtInput" onFocus="getYearAndMonth('czyf');" readonly="true"  sel="1"/></td>
			        <td>
			        &nbsp;&nbsp;<button class="tsdbutton" id="czyf_edit" onClick="setModifyStatus('czyf')">修&nbsp;&nbsp;改</button>
				    &nbsp;&nbsp;<button class="tsdbutton" id="czyf_save" onClick="save('czyf')" disabled="disabled">保&nbsp;&nbsp;存</button>
			        &nbsp;&nbsp;<button class="tsdbutton" id="czyf_cancel" onClick="cancel('czyf')" disabled="disabled">取&nbsp;&nbsp;消</button></td>
			</tr>
			</table>
		</fieldset>	   	
	</div>
	
	<div style="text-align:left; padding-top:20px; padding-left:10px" id="div_sec">
        <fieldset style="text-align:left;width:450px; margin-top:20px">
		    <legend style="font-size:14px">设置当前收费月</legend>
		    <br />
			<table id="sectab" width="100%">
			    <tr>
			        <td><span>当前收费月：</span></td>
			        <td><input type="text" name="sfyf" id="sfyf" class="txtInput" onFocus="getYearAndMonth('sfyf');" readonly="true"  sel="1"/></td>
			        <td>
			        &nbsp;&nbsp;<button class="tsdbutton" id="sfyf_edit" onClick="setModifyStatus('sfyf')">修&nbsp;&nbsp;改</button>
				    &nbsp;&nbsp;<button class="tsdbutton" id="sfyf_save" onClick="save('sfyf')" disabled="disabled">保&nbsp;&nbsp;存</button>
			        &nbsp;&nbsp;<button class="tsdbutton" id="sfyf_cancel" onClick="cancel('sfyf')" disabled="disabled">取&nbsp;&nbsp;消</button></td>
			</tr>
			</table>
		</fieldset>	   	
	</div>
<!-- 	<div style="text-align:left; padding-top:20px; padding-left:10px" id="div_thr">
        <fieldset style="text-align:left;width:450px; margin-top:20px">
		    <legend style="font-size:14px">设置WEB发布月</legend>
		    <br />
			<table id="thrtab" width="100%">
			    <tr>
			        <td><span>WEB发布月：</span></td>
			        <td><input type="text" name="fbyf" id="fbyf" class="txtInput" onFocus="getYearAndMonth('fbyf');" readonly="true"  sel="1"/></td>
			        <td>
			        &nbsp;&nbsp;<button class="tsdbutton" id="fbyf_edit" onClick="setModifyStatus('fbyf')">修&nbsp;&nbsp;改</button>
				    &nbsp;&nbsp;<button class="tsdbutton" id="fbyf_save" onClick="save('fbyf')" disabled="disabled">保&nbsp;&nbsp;存</button>
			        &nbsp;&nbsp;<button class="tsdbutton" id="fbyf_cancel" onClick="cancel('fbyf')" disabled="disabled">取&nbsp;&nbsp;消</button></td>
			</tr>
			</table>
		</fieldset>	   	
	</div>	 -->
	<input type="hidden" id="back_czyf" value=""/>
	<input type="hidden" id="back_sfyf" value=""/>
	<input type="hidden" id="back_fbyf" value=""/>
	
	<div style="text-align:center; display:none">
		<table id="maintab" width="950">
			<tr>
				<td>
					<fieldset style="text-align:left;width:450px;">
				    	<legend style="font-size:14px">手工调整营收参数</legend>
				    	<br />
						<table>
							<tr>
								<td>收费月份：</td><td><input type="text" name="sfyf" id="sfyf" class="txtInput" onFocus="WdatePicker({startDate:'%y-%M',dateFmt:'yyyyMM',alwaysUseStartDate:true});" /></td>
								<td>催缴日期：</td><td><input type="text" name="cjrq" id="cjrq" class="txtInput" onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" /></td>
							</tr>
							<tr>
								<td>滞纳金日期：</td><td><input type="text" name="znjrq" id="znjrq" class="txtInput" onFocus="WdatePicker({startDate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" /></td>
								<td>欠费降级日期：</td><td><input type="text" name="qfjjrq" id="qfjjrq" class="txtInput" onFocus="WdatePicker({startDate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" /></td>
							</tr>
						</table>
					    <button class="tsdbutton" onClick="setBlockOne()">保存</button> 
				    </fieldset>
				</td>
				<td>
					<fieldset style="text-align:left;width:450px;">
				    	<legend style="font-size:14px">当前收费月,预收款年息,日滞纳金比率</legend>
				    	<br />
						<table>
							<tr>
								<td>收费月份：</td><td><input type="text" name="dqsfyf" id="dqsfyf" class="txtInput" onFocus="WdatePicker({startDate:'%y%M',dateFmt:'yyyyMM',alwaysUseStartDate:true});" /></td>
								<td>预收款年息：</td><td><input type="text" name="ysknx" id="ysknx" class="txtInput" onKeyPress="numValid(this)" /> </td>
							</tr>
							<tr>
								<td>日滞纳金比率：</td><td><input type="text" name="rznjbl" id="rznjbl" class="txtInput" onKeyPress="numValid(this)" /></td>
								<td></td><td></td>
							</tr>
						</table>
					    <button class="tsdbutton" onClick="setBlockTwo()">保存</button> 
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
					    <button class="tsdbutton" onClick="setBlockThree()">保存</button> 
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
					    <button class="tsdbutton" onClick="setQzfs()">保存</button> 
				    </fieldset>
				</td>
			</tr>
		</table>
	    
  	</div>
  </body>
</html>
