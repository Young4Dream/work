<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/PhonechangeUserName.jsp
    Function:   电话更名
    Author:     gm
    Date:       2010-10
    Description: 
    Modify: 
     2010-10月份 对该页面进行移植，并对版式进行修改；
     2010-11-03 把公用的CSS提取出来放到style/css/telephone/business/businesspublic.css；
     
     2013-01-18 从中石油挪过来
-----------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
	String area = (String) session.getAttribute("chargearea");
	String depart = (String) session.getAttribute("departname");
	String userareaid = (String) session.getAttribute("userarea");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>电话更名业务</title>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />		
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
		<script src="script/public/mainStyle.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservice.js" type="text/javascript" language="javascript"></script>
		<script src="script/telephone/business/phoneInstalled.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservicenew.js" type="text/javascript" language="javascript"></script>		
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
		<script src="script/telephone/business/businesspublic.js" type="text/javascript" language="javascript"></script>	
		<!-- 打印报表弹出窗口 -->
		<script src="script/telephone/business/businessreprint.js" type="text/javascript" language="javascript"></script>
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
		<!--设置全局字体大小-->
		<link href="style/css/telephone/business/fontsize_all.css" rel="stylesheet" type="text/css"/>
		
		<!-- easyui -->
		<link rel="stylesheet" type="text/css"
			href="style/css/easyui/themes/default/easyui.css"></link>
		<link rel="stylesheet" type="text/css"
			href="style/css/easyui/themes/icon.css"></link>
		<link rel="stylesheet" type="text/css"
			href="style/css/easyui/demo.css"></link>
		<script type="text/javascript"
			src="plug-in/easyui/jquery.easyui.min.js"></script>			
    <script type="text/javascript">
       jQuery(document).ready(function()
	   {	    
	    $("#navBar").append(genNavv());    
	    PageInitial();
	    getinternation();	//businesspublic.js中  自动加载显示框 		
	    ghSetPayName();		//加载付费方式
	    ghSetPhoneType();	//加载话机类型
	    init();
		//加载业务联系人
		loadStaffBm();		
	    ghPayMoney('p_purchase');//通过移机标识查询一次性费用
	    gethide("p_changename");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数
	    getfufeitype();//付费方式   
	    				//话机类型 
	    $("#ghSearchBox").select();
	    $("#ghSearchBox").focus();
		$("#tableyhdang select").attr("disabled","disabled");
		$("#tableyhdang :text").attr("disabled","disabled");
		$("#newYhxm").attr("disabled","disabled");
		$("#newhthYhxm").attr("disabled","disabled");
	   }); 
	   
       function getquerytype(){
			var modiftype = $("#ghSearchWay").val();
			if(modiftype=="3"){
				var hth = $("#ghSearchBox").val();
				hth=hth.replace(/(^\s*)|(\s*$)/g,"");
				if(hth.length==0){
					alert("<fmt:message key="phone.getinternet0041" />");
					return;
				}				
				selecthth(hth);	
				
			}else{
				ghSearch();			
			}			
		}
       
       /**
        *弹出合同号搜索框
        **/
       function selecthth(hth){
	       $("#selecththcontent").val("");//每次查询前清空查询条件
	       $("#selecththvalue").val("2");//每次查询前查询类型还原
	       autoBlockForm('selecthth',5,'close',"#ffffff",false);//弹出查询框
	       $("#selecththkey").empty();//每次查询前将以前的数据清空  
	       var res = fetchMultiArrayValue("dbsql_phonelnstalled.selecththkey02hth",6,"&param="+tsd.encodeURIComponent(hth));
	       if(res[0]==undefined || res[0][0]==undefined){
				$("#selecththkey").append("<tr><td>没有该合同号信息</td></tr>");
				return false;
		   }
           var ify="";
           for(var i=0;i<res.length;i++){
               ify +="<tbody>";
               ify += "<tr onClick=\"getHTHXZ('"+res[i][0]+"')\" onDblClick=\"getsavexzhth('"+res[i][0]+"','"+res[i][1]+"')\" id=\""+res[i][0]+"\">";					
				ify += "<td style=\"width: 250px;height: 20px\"><center>";
				ify += res[i][0];
				ify += "</center></td>";
				ify += "<td width=\"250px;\"><center>";
				ify += res[i][1];
				ify += "</center></td>";
				ify += "<td width=\"500px;\"><center>";
				ify += res[i][2];
				ify += "</center></td>";
				ify +="</tr>";
				ify +="</tbody>";
           }
           $("#selecththkey").append(ify);
	       
       }
       
       /**
       *双击保存合同号
       **/
       function getsavexzhth(savehth,hthdh){
    	   $("#ghSearchBox").val(savehth);
    	   $("#hdhd").val(hthdh);
    	   setTimeout($.unblockUI,15);
       }
       
	   /*******
	   * 清除被锁定账号
	   * @param;
	   * @return;
	   ********/
	   function unLockDh()
	   {
	   		var userid = tsd.encodeURIComponent($("#userid").val());	   		
	   		executeNoQueryProc("PhoneDH.ifCanSouLi",6,"&OperID=" + userid + "&Func=1");
	   		ClearTmpData();
	   }
	   
	   function ClearTmpData()
	   {
	   		var userid = tsd.encodeURIComponent($("#userid").val());	   		
	   		executeNoQueryProc("PhoneService.POPEN",6,"&userid=" + userid);
	   }
	   
	   /*******
	   	* 从真实姓名对应的多个账户中选择要查询的账户
	   	* @param: Yhmc用户名称、Dh电话、Yhdz用户地址;
	   	* @return;
	  	********/
		function userChoose(Yhmc,Dh,Yhdz)
		{
		    var yw=fetchMultiArrayValue("select.yw",6,"&dh="+Dh);
			    $("#yw").val(yw);
			var result = fetchMultiPValue("PhoneDH.ifCanSouLi",6,"&OperID=" + tsd.encodeURIComponent($("#userid").val()) + "&Ywlx="+tsd.encodeURIComponent("p_changename")+"&NowYwArea="+tsd.encodeURIComponent($("#area").val())+"&Dh="+Dh);
			if(result[0]!=undefined && result[0][0]!="")
			{
				alert(result[0][1]);
				return;
			}
			
			if($("#ghSearchWay").val()=="1")
			{
				$("#ghSearchBox").val(Yhmc);
			}
			else if($("#ghSearchWay").val()=="2")
			{
				$("#ghSearchBox").val(Yhdz);
			}
			else
			{
				$("#ghSearchBox").val(Dh);
			}
			$("#phone").val(Dh);
			ghSerBasicInfo(Dh);			
			$("#newYhxm").select();
			$("#newYhxm").focus();	
			$('#hdhd').val(Dh);		
			ghZF(Dh);
			gethTC(Dh);
			getdhBYTC(Dh);
			//加载业务联系人
			//loadStaffBm();
			$("#newYhxm").removeAttr("disabled");	
			$("#newhthYhxm").removeAttr("disabled");
			setTimeout($.unblockUI,1);
		}						
		
		/*******
	   	* 点击保存拼接参数调用过程处理更名修改
	  	* @param;
	   	* @return;
	  	********/
		function gj()
		{   var userarea='<%=userareaid%>';
		 	var params='';
		 	var phonetype = $("#payType").val(); //付费方式
			var area = $("#area").val();	//区域
			var depart = $("#depart").val();	//部门
			var userid = $("#userid").val();	//工号
			var phone = $("#hdhd").val();	//电话
			var payitem=$('#payItem').val();
			var yjfee=$('#cYingJiao').val();
			var sjfee=$('#sj').val();
			if(phone=="" || phone==null || phone==undefined)
			{
				alert("请先查询要办理更名业务的用户");
				$("#ghSearchBox").select();
				$("#ghSearchBox").focus();
				return false;
			}
			var yj=$('#cYingJiao').val();
			var sj=$('#sj').val();
			if(sj == '' || sj == null || sj == undefined)
			{
				alert('请输入实缴金额！');
				return false;
			}
			if(sj<yj)
			{
				alert('实缴金额不能小于应缴金额！');
				$('#sj').focus();
				return false;
			}
			var linkphone=$('#linkphone').val();
			if(linkphone == '' || linkphone == null || linkphone == undefined)
			{
				alert('请输入联系电话！');
				return false;
			}
			var linkman=$('#linkman').val();
			if(linkman == '' || linkman == null || linkman == undefined)
			{
				alert('请输入联系人名称！');
				return false;
			}
			var bz=$('#phonepkBz').val();
	 		//每次拼接参数必须添加此判断
	 		params+='&Area='+tsd.encodeURIComponent(area);
	 		params+='&phonetype='+tsd.encodeURIComponent(phonetype);
			params+='&UserID='+tsd.encodeURIComponent(userid);
	 		params+='&Depart='+tsd.encodeURIComponent(depart);
			params+='&dh='+phone;			
	 		params+='&payItem='+tsd.encodeURIComponent(payitem);
			params+='&yjfee='+yjfee;
			params+='&sjfee='+sjfee;
			params+='&lxr='+tsd.encodeURIComponent(linkman);
			params+='&lxdh='+tsd.encodeURIComponent(linkphone);
	 		params+='&bz='+tsd.encodeURIComponent(bz);
	 		//params+="&YwArea="+tsd.encodeURIComponent($("#yw").val());
	 		params+='&userarea='+tsd.encodeURIComponent($("#yw").val());
			var result = fetchMultiPValue("PhoneService.GJ",6,params);
			if(result[0]==undefined || result[0][0]==undefined || result[0][0]=='-1')
			{
				alert("业务失败");
			}
			else
			{
				$('#resultid').val(result[0]);
				/*$("#jobidid").val(result[0][0]);
				$("#ppaytype").val(cPayType);
				$("#fee").val(cYingJiao);		
				$("#ghSearchBox").select();
			    $("#ghSearchBox").focus();
				//判断是否打印工单，从tsd_ini表中配置Y为打印
				printworkorder('p_changename');//script/telephone/business/businessreprint.js中
				writeLogInfo("","modify",loginfo);				
				pageReset();*/
				clear();	//清除
				autoBlockForm('thedisplayprint', 150, 'printclose', "#ffffff", false);
			}
		}
		
		/*******
	   	* 页面重置
	  	* @param;
	   	* @return;
	  	********/
		function pageReset()
		{
			$(":text").val("");
        	$("#tableyhdang :text").val("");
        	$("#tableyhdang select").val("");
        	$("#staff_bm").val("").trigger("change");        	
			//业务备注框
			$("#phonepkBz").val("");
			$("#cPayType").val("cash").trigger("change");
			$("#danweiHTHbox").removeAttr("checked");	
			$("#newYhxm").attr("disabled","disabled");
			$("#newhthYhxm").attr("disabled","disabled");				
			ghPayMoney('p_changename');	//通过更名标识来查询一次性费用		
			refreshbusinessfee();		
			gethide("p_changename");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数
			unLockDh();
		}       		
		/*******
	   	* 加载业务联系人
	  	* @param;
	   	* @return;
	  	********/
		function loadStaffBm()
		{
			var urlstr=tsd.buildParams({  
							packgname:'service',		//java包
							clsname:'AskConstant',		//类名
							method:'askConstantTable',	//方法名
							identity:'FINAL.Staff',	//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							pattern:'select',			//访问方式 select：查询常量表信息，update：更新常量表信息
							argument:''				//对常量表的过滤条件
			 				});		
				var ywlxsbm='';
				$.ajax({
					url:'mainServlet.html?'+urlstr,					
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
							$(xml).find('row').each(function(){
		                 			ywlxsbm +="<option value='"+$(this).attr("sbm")+"'>"+$(this).attr("sbm")+"</option>";
							});			
							$("#staff_bm").html("<option value='' selected=true>--<fmt:message key="gjh.select"/>--</option>");		
							$("#staff_bm").append($("#staff_bm").html()+ywlxsbm);
					}
			});	
		}
       	
       	/*******
	   	* 取详细的业务联系人
	  	* @param;
	   	* @return;
	  	********/
		function staff_chg()
		{
			var bmm = $("#staff_bm").val();
			
			if(bmm!="" && bmm!=undefined)
			{
				var urlstr=tsd.buildParams({  
							packgname:'service',		//java包
							clsname:'AskConstant',		//类名
							method:'askConstantTable',	//方法名
							identity:'FINAL.Staff2',	//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							pattern:'select',			//访问方式 select：查询常量表信息，update：更新常量表信息
							argument:'sbm:'+tsd.encodeURIComponent(bmm)				//对常量表的过滤条件
			 				});		
				var ywlxs='';
				$.ajax({
					url:'mainServlet.html?'+urlstr,					
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
							$(xml).find('row').each(function(){
		                 			ywlxs +="<option value='"+$(this).attr("username")+"'>"+$(this).attr("username")+"</option>";
							});				
							$("#staff_ry").html("<option value='' selected=true>--<fmt:message key="gjh.select"/>--</option>");		
							$("#staff_ry").append($("#staff_ry").html()+ywlxs);
					}
			});	
			}
			else
			{
				$("#staff_ry").empty();
			}
		}	

/**
 *是否收费来控制输入
 */
function isCharges()
{
	var isCharges=$('#isCharges').attr('checked');
	if(isCharges==true)
	{
		$('#yj').removeAttr('disabled');
		$('#sj').removeAttr('disabled');
		$('#payType').removeAttr('disabled');
	}
	else
	{
		$('#sj').attr('disabled','disabled');
		$('#yj').attr('disabled','disabled');
		$('#payType').attr('disabled','disabled');
	}
}

/**
 *加载付费方式
 */
function ghSetPayName()
{
	var paynames = fetchMultiArrayValue("revenue.nfetchPayName",6,"");
	$.each(paynames,function(i,n){
		$("#payType").append("<option rptfile=\"" + n[1] + "\" cval=\""+ n[2] +"\" value=\"" + n[2] +"\"" + (n[0]==""?" selected=\"selected\"":"") + ">" + n[0] + "</option>");
	});
}
/**
 *加载话机类型
 */
function ghSetPhoneType()
{
	var paynames = fetchMultiArrayValue("revenue.nfetchPhoneType",6,"&tsection="+tsd.encodeURIComponent('话机类型'));
	$.each(paynames,function(i,n){
		$("#phoneType").append("<option rptfile=\"" + n[1] + "\" cval=\""+ n[1] +"\" value=\"" + n[1] +"\"" + (n[0]==""?" selected=\"selected\"":"") + ">" + n[0] + "</option>");
	});
}

/**
 *保存一条的购买记录
 */
function saveItem()
{
	var phoneType=$('#phoneType').val();//话机类型
	var amount=$('#amount').val();
	
	if(amount == 0 || amount == '' || amount == undefined)
	{
		alert('请输入购买数量！');
		return false;
	}
	$("#sj").removeAttr("disabled");
	if(phoneType=="--请选择--")
	{
	    alert("请选择需要购买的话机");
	    return false;
	}
	saveBuy(phoneType,amount);	//保存购买项
	
}

//保存一条的购买记录
function saveBuy(type,amount)
{	
	//获取参数
	var temptype=$('#temptype').val();
	var tempnum=parseInt($('#tempnum').val());
	$('#temptype').val(type);
	$('#tempnum').val(amount);
	var item=$('#payItem').val();
	//算出总金额
	var resmoney=fetchMultiArrayValue("purchase.queryprice",6,"&phonetype="+tsd.encodeURIComponent(type));
	var money=resmoney[0][0]*amount;	
	var resTypeNum=fetchSingleValue("purchase.queryCountByType",6,"&type="+tsd.encodeURIComponent($("#phoneType option:selected").text()));
	//保存记录
	if(resTypeNum>0)
	{
	   	executeNoQuery('purchase.updateItem',6,'&type='+tsd.encodeURIComponent($("#phoneType option:selected").text())+'&num='+amount+'&money='+money+"&userid="+$("#userid").val());
	}else
	{
		executeNoQuery('purchase.saveItem',6,'&type='+tsd.encodeURIComponent($("#phoneType option:selected").text())+'&num='+amount+'&money='+money+"&userid="+$("#userid").val());
	}
	//页面生成
	var res=fetchMultiArrayValue("purchase.queryItem",6,"");
	feeItem = "<table id=\"selTable\"><tr>";
	$('#payItem').empty();
	$("#selNum").empty();
	var feename="";
	for(var i=0;i<res.length;i++){
		var type1=res[i][0];
		var num1=res[i][1];
		var money=res[i][2];			
		feeItem += "<td><input type=\"checkbox\" onClick=\"getcheckfeegj('"+type1+"');\" checked=\"true\" style=\"width:22;padding:0px;border:0px;\" id=\"";
		feeItem += 'leader';
		feeItem += "\" />";			
		feeItem += "<span id=\"feeitem1";
		feeItem += "\" />";	
		feeItem += type1+num1+"部";
		feeItem += "</span>";
		feeItem += "</td>";		
		//$("#selNum").html(feeItem);
		//显示费用项目
		feename+=type1+': '+num1+'部'+money+'元'
		feeItem += "</tr><tr>";			
	}
	feeItem += "</tr></table>";
	var exists=$("#selNum").html();
	$("#selNum").html($("#selNum").html()+feeItem);
	$('#payItem').val(feename);
	$("#selNum table tr").css("line-height","26px");	
	var mm=fetchSingleValue("purchase.queryMoney",6,"");
	$('#cYingJiao').val(mm);
	$('#sj').focus();
	$('#sj').val($("#cYingJiao").val());
}

function getcheckfeegj(key){
	var res = executeNoQuery('purchase.deletetype',6,'&key='+tsd.encodeURIComponent(key)+"&userid="+$("#userid").val());
	if(res=="true"){
		alert("删除成功！");
	}else{
		alert("删除失败！");
	}
	
	//页面生成
	var res=fetchMultiArrayValue("purchase.queryItem",6,"");
	feeItem = "<table id=\"selTable\"><tr>";
	$('#payItem').empty();
	$("#selNum").empty();
	var feename="";
	for(var i=0;i<res.length;i++){
		var type1=res[i][0];
		var num1=res[i][1];
		var money=res[i][2];			
		feeItem += "<td><input type=\"checkbox\" onClick=\"getcheckfeegj('"+type1+"');\" checked=\"true\" style=\"width:22;padding:0px;border:0px;\" id=\"";
		feeItem += 'leader';
		feeItem += "\" />";			
		feeItem += "<span id=\"feeitem1";
		feeItem += "\" />";	
		feeItem += type1+num1+"部";
		feeItem += "</span>";
		feeItem += "</td>";		
		//$("#selNum").html(feeItem);
		//显示费用项目
		feeItem += "</tr><tr>";		
		feename+=type1+num1+'部'+money+'元|'			
	}
	feeItem += "</tr></table>";	
	var exists=$("#selNum").html();
	$("#selNum").html(feeItem);
	$('#payItem').val(feename);
	$("#selNum table tr").css("line-height","26px");	
	var mm=fetchSingleValue("purchase.queryMoney",6,"");
	$('#cYingJiao').val(mm);
	$('#sj').focus();
	$('#sj').val($("#cYingJiao").val());
}

/**
 *打印发票
 */
function invoicePrint(key)
{
	var printfile = "commonreport/dh_jobworkorder";
	var id=$('#resultid').val();
	if(key ==  1)	//直接打印
	{
		if (id != 'undefined' && id != null && id != '')
    	{
        	printWithoutPreview(printfile,"id_"+id);
        	$('#resultid').val('');
        	$('#printclose').click();
    	}
    	else {
        	alert('无工单可打印!');
    	}
	}
	
	if(key == 2)	//预览打印
	{
	    if (id != 'undefined' && id != null && id != '')
    	{
        	var theurl = "/tsdboss_zsy/ReportServer?reportlet=/com/tsdreport/" + printfile + ".cpt&JobID=" + id;
        	window.open(theurl);
        	$('#resultid').val('');
        	$('#printclose').click();
    	}
    	else {
        	alert('无工单可预览!');
    	}
	}
	
	if(key == 3)	//关闭打印面板
	{
		$('#printclose').click();
	}
}

/**
 *清除信息
 */
function clear()
{
	$('#ghSearchBox').val("");
	$('#sj').val("");
	$('#linkphone').val("");
	$('#linkman').val("");
	$('#payItem').val("");
	$('#amount').val("");
	$('#phonepkBz').val("");
	$('#hdhd').val("");
	$('#cYingJiao').val('0');
	$('#selTable').html("");
	$("#sj").attr("disabled","true");
	executeNoQuery("purchase.clerData",0,"");
} 

/**
 *离开页面清除操作
 */
$(window).bind('beforeunload',function(){ 
	clear();
	return '您输入的内容尚未保存，确定离开此页面吗？'; 
}); 
/**
 *初始化数据
 */
function init()
{
	//返回杂费数组
	ghPayMoney('ghPayMoney');
}
    </script>    
	</head>       
	<body onUnload="unLockDh()">
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
		 <div id="broadband_frame">
				<div id="input-Unit">
					<div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/65.gif" />
						输入查询条件
					</div>
					<div id="inputtext">
					<table id="kdBar" style="margin-left: 10px;" cellspacing="10px">
						<tr>
							<td>
								<fmt:message key="phone.getinternet0179" /><!-- 查询方式 -->
								<select id="ghSearchWay" style="width:100px;">
									<option value="0">
										<fmt:message key="phone.getinternet0103" /><!-- 电话 -->
									</option>
									<option value="1">
										<fmt:message key="phone.getinternet0180" /><!-- 用户名 -->
									</option>
									<option value="2">
										<fmt:message key="phone.getinternet0113" /><!-- 用户地址-->
									</option>
									<option value="3">
										<fmt:message key="phone.getinternet0100" /><!-- 合同号-->
									</option>
								</select>
							</td>
							<td>
								<input type="text" class="" id="ghSearchBox" name="ghSearchBox" />
							</td>
							<td>
								<button class="tsdbutton" id="submitButton"
									onclick="getquerytype()" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
									<fmt:message key="phone.getinternet0466" /><!-- 查找 -->
								</button>
							</td>
							<td width="290"></td>
						</tr>
					</table>
				</div>
				<div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/65.gif" />
						购机信息
					</div>
					<div id="inputtext1">
					<table>
					<tr>
					<td>
					    <table width="860" cellspacing="3" style="text-align: left">
					     <tr>
					         <td >付费方式</td>
				             <td >
				              <select id="payType" name="payType" style="width:180px" disabled="disabled"></select>
				             </td>
				             <td height="32" align="right">联系电话</td>
				             <td >
				              <input type="text" id="linkphone" name="linkphone" /><font color="red">*</font>				              
				             </td>
				             <td height="32">&nbsp;联系人</td>
				             <td >
				              <input type="text" id="linkman" name="linkman" /><font color="red">*</font>				              
				             </td>
					       </tr>
					       <tr>  
				             <td height="32" align="right">购买话机</td>
				             <td >
				              <select id="phoneType" name="phoneType" style="width:180px"><option>--请选择--</option></select>			              
				             </td>
				             <td>购买数量</td>
				             <td>
				             	<input type="text" id="amount" />
				             </td>
				             <td>（部）</td>
				             <td colspan="1">
				             	<input type="button" id="ok" value="确认" onClick="saveItem()"/>
				             </td>
				             
					       </tr>
					       <tr>
				             <td height="32" >应缴费用</td>
				             <td >
				              <input type="text" id="cYingJiao" name="cYingJiao" style="width:180px" disabled="disabled"/>				              
				             </td>
				             <td height="32" style="display: none">实缴费用</td>
				             <td >
				              <input type="text" id="sj" name="sj" style="display: none"/>				              
				             </td>
				           </tr>
					       <td></td>
					       <td></td>
					      <!--  <tr>
				             <td height="32" align="right">联系电话</td>
				             <td >
				              <input type="text" id="linkphone" name="linkphone" style="width:180px"/>				              
				             </td>
				             <td height="32">&nbsp;联系人</td>
				             <td >
				              <input type="text" id="linkman" name="linkman" style="width:180px"/>				              
				             </td>
				           </tr> -->
					       
					       <tr align="left" >
				             <td height="32" >缴费款项</td>
				             <td colspan="5">
				              <input type="text" id="payItem" name="payItem" style="width:730px" disabled="disabled" value=""/>				              
				             </td>
				           </tr>
				           
					    </table>
					    </td>
					    
					</tr>
					<tr align="left">
					           <td style="text-align: left">费用项目
							    <div id="selNum" style="border-left: gray 1px solid; overflow-x: hidden; overflow-y: scroll; width: 340px; height: 110px; border-top: gray 1px solid;">
							    </div>
							   </td>
				           </tr>
					</table>
				</div>
				 <div id="inputtext1">
			    				    
				    <hr style="border: 1px dotted #CCCCCC;" />
				    <table cellspacing="3" style="background-color:#f7f7f7">
				       <tr>
				         <td>
				           <table cellspacing="8">
				              <tr>
				                <!-- <td valign="top"> -->
				                <td>
				                &nbsp;&nbsp;业务备注
				                </td>
				                <td>
				                  <textarea name="phonepkBz" id="phonepkBz" rows="4" cols="110" maxlength="60"  onpropertychange="TextUtil.NotMax(this)"></textarea>
				                </td>
				              </tr>
				           </table>
				         </td>
				      </tr>				      
				    </table>
				 </div> 
			</div>
	       <div id="buttons">
			<center>				
				<button id="save" onclick="gj()"
					style="margin-left: 20px;">
					<!-- 确定 -->
					<fmt:message key="Revenue.Save"/>
				</button>
				<button id="reset" onclick="pageReset()" style="margin-left: 20px;">
					<!-- 重置 -->
					<fmt:message key="AddUser.Reset" />
				</button>				
			</center>
		 </div>		
	</div>
	
	<div class="neirong" id="operform" style="display:none;overflow-x:hidden;width:600px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						单位合同号查询
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onClick="javascript:$('#operformClose').click();">关闭</a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>
		<div class="midd" style="background-color:#FFFFFF;text-align:left;height:260px;overflow-y:scroll;">
			<table border="1" cellpadding="0" bordercolor="#9AC0CD" id="queryHTHdw">
				          
			</table>
		</div>
		<div class="midd_butt" style="width:100%;">
			<button id="save" class="tsdbutton" onClick="getinputHTH()"
				style="margin-left: 20px;">
				<!-- 确定 -->
				<fmt:message key="Revenue.Save"/>
			</button>
			<button type="button" class="tsdbutton" onClick="closeGB();" id="operformClose">
				关闭
			</button>
		</div>
	</div>
	<div class="neirong" id="multiSearch" style="display:none;overflow-x:hidden;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						电话更名业务用户信息查询
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onClick="javascript:$('#kdMultiSearchClose').click();">关闭</a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>
		<div class="midd" style="background-color:#FFFFFF;text-align:left;">
			<div id="grid" style="margin-top:0px;"></div>
		</div>
		<div class="midd_butt" style="width:100%;">
			<button type="button" class="tsdbutton" id="kdMultiSearchClose">
				关闭
			</button>
		</div>
	</div>
	
	<div class="neirong" id="editbusinessfee"	style="width:702px;display: none">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							业务受理费
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;" onClick="removecheckbusi()"><!-- 关闭 --></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;height:100px;">
				<div id="inputtext">
					<table border="0" cellpadding="0" bordercolor="" id="inpuththtable" style="width: 687px;"  cellspacing="3">
						<tr>
							<td style="width:50px;">业务费用<br></td>
							<td><input type="text" id="feenamevalue" style="width:180px" disabled="disabled"/><br></td>
							<td>当前费用<br></td>
							<td><input type="text" id="feenumbervalue" style="width:100px" disabled="disabled"/><br></td>
							<td>实缴费用<br></td>
							<td><input type="text" id="sjfeevalue" style="width:100px"/><br></td>
						</tr>
						<tr>
							<td>
								备注
							<br></td>
							<td colspan="3">车<input type="text" id="businessbz" style="width:300px;"/>
							<br></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="midd_butt" style="width:689px;height:40px;">  
				<button id="hthChooseFormSave" onClick="savebusinessfee()" class="tsdbutton" 
					style="margin-left: 20px;">
					<!-- 确定 -->
					<fmt:message key="Revenue.Save" />
				</button>
				<button id="hthChooseFormReset" onClick="removecheckbusi()" class="tsdbutton"  style="margin-left: 20px;">
					<fmt:message key="global.close" />
					<!-- 关闭 -->
				</button>
			</div>
		</div>
	
	<!-- 打印派工单 -->
		<div class="neirong" id="thedisplayprint"
			style="display: none; width: 100%; margin-left: 50px">
			<div class="top">
				<div class="top_01">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							打印购机发票
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onClick="javascript:$('#printclose').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>

			</div>

	<div class="midd_butt" style="width:100%;padding:0px;">
		<button id="theprint" onClick="invoicePrint(1)"
			style="margin-left: 10px; margin-top: 10px" class=btn_2k3>
			直接打印
		</button>
		<button id="viewprint" onClick="invoicePrint(2)"
			style="margin-left: 10px" class=btn_2k3>
			打印预览
		</button>
		<button id="printclose" onClick="invoicePrint(3)"
			style="width: 50px; margin-left: 10px" class=btn_2k3>
			关闭
		</button>
	</div>
						
	<!-- 弹出报表打印框 -->	
	<div id="businessreprint"></div><!-- 加载的文件在script/telephone/business/businessreprint.js -->  
	<iframe id="printReportDirect"  style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>		
	<input type="hidden" id="userid" value="<%=userid%>" />
	<input type="hidden" id="area" value="<%=area%>" />
	<input type="hidden" id="depart" value="<%=depart%>" />
	<input type="hidden" id="userareaid" value="<%=userareaid%>" />
	<input type="hidden" id="imenuid" value="<%=imenuid %>"/>
	<input type="hidden" id="zid" value="<%=zid %>"/>
	<input type="hidden" id="languageType" value="<%=languageType %>"/>
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
	<input type="hidden" id="depart" value="<%=depart%>" />
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->
	<input type="hidden" id="useridright" name="useridright"/>
	<input type="hidden" id="feenameid" name="feenameid"/>
	<input type="hidden" id="inputDWHTH" name="inputDWHTH"/>	
	<input type="hidden" id="Subtype" name="Subtype"/>
	<input type="hidden" id="reportparam" />
	<input type="hidden" id="jobidid" />
	<input type="hidden" id="ppaytype" />
	<input type="hidden" id="fee" />
	<input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->
	<input type="hidden" id="yjfeehidden"/><!-- 页面获取应缴费存入隐藏于中 -->
	<input type="hidden" id="fufeitypepath"/>
	<input type="hidden" id="stiffbusinestype" value="phoneGM"/><!-- 电话工单打印类型 -->
	<input type="hidden" id="Prefeeval"/><!-- 预测金额打印票据时判断 -->
	<input type="hidden" id="leadernum" value="0" />
	<input type="hidden" id="generalnum" value="0" />
	<input type="hidden" id="lsavemount" value="0" />
	<input type="hidden" id="psavemount" value="0" />
	
	<input type="hidden" id="hdhd" value="" />
	<input type="hidden" id="resultid" value="" />
	<!-- 临时购机类型和购机数量 -->
	<input type="hidden" id="temptype" value="" />
	<input type="hidden" id="tempnum" value="0" />
	<input type="hidden" id="yw"/>
	<jsp:include page="phone_internet.jsp" flush="true"/>
	</body>
</html>