<%-- 
    File Name:  tariff/Set1rate.jsp
    Function:   
    Author:     chenze
    Date:       2010-10-11
    Description: 
    Modify:     youhongyu 移植 	
                2010-11-5   chenze  添加注释
                2010-11-10   尤红玉  头部注释
                2010-11-26  chenze  增加高级查询和导出数据时Blob字段转换
                2010-12-10  liwen   修改，新增，查询弹出面板的标题修改
                2010-12-15 youhongyu   修改本查询为模板功能，使其能区分本次要保存的查询内容是来自哪个表
                2010-12-17 youhongyu   查询有问题，输入计费网名为公网，查询不出结果.解决方法：将附有初始值的text框的值置空
                					    打开通用查询，头部无法正确显示当前批操作类型问题更正
                
--%>
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
   
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="AeroWindow/js/jquery-1.4.2.min.js" type="text/javascript"></script>
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
		
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script type="text/javascript" src="script/public/datalength.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<!-- 资费菜单样式 -->
		<link href="style/css/pubMode/tariff.css" rel="stylesheet" type="text/css" />
		<!-- 日期插件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>		
		
		<!-- 分项卡 -->	
		<script src="plug-in/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
		
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen"/>
					
		<style type="text/css">
			.header { 
				font-size: 100%; font-weight: bold; text-align: left;
				padding: 2px;
				background-image: url(images/headerbg.gif) ;
				color: #FFFFFF;
				width: 100%;
				height:10px;
				white-space: nowrap;
			}
		</style>
	<script type="text/javascript">
	
	</script>
	<script type="text/javascript">
	
	$(function(){
		
		//初始化数据
		var cmd = request("cmd");
		var id = request("id");
		
		if(cmd == 4){
			$("#openadd1").attr("disabled",true);
		}
		
		if(cmd == 2 || cmd == 4){
			//加载详细数据
			var url = 'packageMainServlet.html';
			$.ajax({
				url:url,
				data:'cmd='+2+"&id="+id,
				datatype:'html',
				type:'post',
				cache:false,
				timeout: 1000,
				async: false,//同步方式
				success:function(res){
					var resArray = res.split("/=/");
					var initData = resArray[0];
					
					//初始化页面原始参数
					var packageTypes = initData.split("/*/")[0];
					var packageBuses = initData.split("/*/")[1];
					var gifts = initData.split("/*/")[2];
					var salePolicys = initData.split("/*/")[3];
			        packageTypes = $.parseJSON(packageTypes);
			        
					$.each(packageTypes, function(i, item) {
						$("#packageType").append("<option value="+item.id+">"+item.pagShort+"</option>");
			        });
			        
			        packageBuses = $.parseJSON(packageBuses);
			        $.each(packageBuses, function(i, item) {
						$("#nid").append("<option value="+item.id+">"+item.pbName+"</option>");
						$("#hdParam").append("<input id='"+item.id+"TCYW' businessNum='"+item.businessNum+"' businessView='"+item.businessView+"' costPrice='"+item.costPrice+"' bType='"+item.BType+"' bnUnit='"+item.businessUnit+"'/>");
			        });
			        
			         gifts = $.parseJSON(gifts);
			        $.each(gifts, function(i, item) {
						$("#gid").append("<option value="+item.id+">"+item.giftName+"</option>");
			        });
			        salePolicys = $.parseJSON(salePolicys);
			        $.each(salePolicys, function(i, item) {
						$("#rateSalePolicy").append("<option value="+item.id+">"+item.saleName+"</option>");
			        });
			        bindParam($("#nid").val());
					
					//初始化页面套餐和费率内容
					var packageData = resArray[1];
					var packageMain = packageData.split("/*/")[0];
					var packageRate = packageData.split("/*/")[1];
					//res = $.parseJSON(res);
					packageMain = $.parseJSON(packageMain);
				    $("#keyId").val(packageMain.id);
			        $("#packageName").val(packageMain.packageName);
			        $("#packageNameOld").val(packageMain.packageName);
			        $("#packageType").val(packageMain.packageType);
			        $("#packageTypeOld").val(packageMain.packageType);
			        $("#packageFee").val(packageMain.packageFee);
			        $("#packageStatus").val(packageMain.packageStatus); 
			        $("#pagFreeNum").val(packageMain.pagFreeNum); 
			        $("#gid").val(packageMain.gid);
			        $("#remark").val(packageMain.remark);
			        $("#operator").val(packageMain.operator);
			        
			        if(packageMain.packageType == 7){
			        	$("#bnThreshold").attr("disabled",true);
			        }else{
			        	$("#bnThreshold").attr("disabled",false);
			        }
		        	packageRate = $.parseJSON(packageRate);
		        	$.each(packageRate, function(i, item) {
						var table = document.getElementById("addrate_table");
  						var id = table.rows.length;
  						
  						var bnUnitName = '';
  						if(item.bnUnit == 1){
  							bnUnitName = "时长";
  						}else if(item.bnUnit == 2){
  							bnUnitName = "流量";
  						}else if(item.bnUnit == 3){
  							bnUnitName = "次";
  						}else if(item.bnUnit == 4){
  							bnUnitName = "其他";
  						}
  						
  						var rateStatusName = '';
  						if(item.rateStatus == 0){
  							rateStatusName = '启用';
  						}else{
  							rateStatusName = '未启用';
  						}
  						
  						var bTypeName = '';
  						if(item.BType == 1){
  							bTypeName = "语音";
  						}else if(item.BType == 2){
  							bTypeName = "宽带";
  						}else if(item.BType == 3){
  							bTypeName = "短信";
  						}else if(item.BType == 4){
  							bTypeName = "其他";
  						}
  						
  						var rateStatusName = '';
  						if(item.rateStatus == 0){
  							rateStatusName = '启用';
  						}else{
  							rateStatusName = '未启用';
  						}
  						
			          	var tr="<tr align='center' height='25'>";
					 	tr+="<td name='id' >"+id+"</td>";
					 	tr+="<td name='nid' style='display:none'>"+item.nid+"</td>";
					 	tr+="<td name='nidName' >"+item.nidName+"</td>";
					 	tr+="<td name='bType' style='display:none'>"+item.BType+"</td>";
	 					tr+="<td name='bTypeName' >"+bTypeName+"</td>";
					 	tr+="<td name='bnUnit' style='display:none'>"+item.bnUnit+"</td>";
					 	tr+="<td name='bnUnitName'>"+bnUnitName+"</td>";
					 	tr+="<td name='bnRatePrice' >"+item.bnRatePrice+"</td>";
					 	tr+="<td name='costPrice'>"+item.costPrice+"</td>";
					 	tr+="<td name='bnUnitNum' style='display:none'>"+item.bnUnitNum+"</td>";
					 	tr+="<td name='bnUnitValue' style='display:none'>"+item.bnUnitValue+"</td>";
					 	tr+="<td name='bnThreshold'>"+item.bnThreshold+"</td>";
					 	tr+="<td name='rateStatus' style='display:none'>"+item.rateStatus+"</td>";
					 	tr+="<td name='rateStatusName' style='display:none'>"+rateStatusName+"</td>";
					 	tr+="<td name='rateSalePolicy' style='display:none'>"+item.rateSalePolicy+"</td>";
	 					tr+="<td name='rateSalePolicyName'>"+item.rateSalePolicyName+"</td>";
					 	if(packageMain.packageType == 7){
					 		//非兜底套餐隐藏
					 		tr+="<td name='freeResVolume' style='display:none'>"+item.freeResVolume+"</td>";
					 		//兜底套餐
					 		tr+="<td name='basicNumMin' style='display:none'>"+item.basicNumMin+"</td>";
					 		tr+="<td name='basicNumMax'>"+item.basicNumMax+"</td>";
					 		tr+="<td name='basicFee'>"+item.basicFee+"</td>";
					 		var basicFeeHid = $("#basicFeeHid").val();
					 		$("#basicFeeHid").val(parseInt(basicFeeHid)+1);
					 	}else{
					 		//非兜底套餐显示
					 		tr+="<td name='freeResVolume'>"+item.freeResVolume+"</td>";
					 		//兜底套餐
					 		tr+="<td name='basicNumMin'  style='display:none'>"+item.basicNumMin+"</td>";
					 		tr+="<td name='basicNumMax'  style='display:none'>"+item.basicNumMax+"</td>";
					 		tr+="<td name='basicFee'  style='display:none'>"+item.basicFee+"</td>";
					 		var notbasicFeeHid = $("#notbasicFeeHid").val();
					 		$("#notbasicFeeHid").val(parseInt(notbasicFeeHid)+1);
					 	}
					 	$("#basicFeeHid").attr("packageType",packageMain.packageType);
					 	$("#notbasicFeeHid").attr("packageType",packageMain.packageType);
						//特服费率显示
				 		tr+="<td name='specialRate' >"+item.specialRate+"</td>";
					 	tr+="<td> <span onclick='$(this).parent().parent().remove();delrow("+item.nid+","+item.bnThreshold+");' ><span style='color: red; cursor:pointer;'>删除</span></td>";
						tr+="</tr>";
					 	$("#addrate_table").append(tr);
					 	
					 	if(item.bnThreshold == 0){
					 		var hdParam = $("#"+item.nid+"Max").val();
					 		if(hdParam+"" == 'undefined'){
					 			$("#hdParam").append("<input id='"+item.nid+"Max'/>");
					 		}
					 	}
			        });
			        
					
					var packageType = $("#packageType").val();
					if(packageType == 7){
						//兜底套餐
						$(".basicFeeUp").hide();
						$(".basicFeeDown").show();
					}else{
						//其他套餐
						$(".basicFeeUp").show();
						$(".basicFeeDown").hide();
					}
				}
			});
		}
		
		if(cmd == 4){
			$(".modPage").hide();
			$(".detailPage").show();
		}
		
		$("#form_submit").click(function(){
			//套餐id
			var keyId = $("#keyId").val();
		
			//套餐名称
			var packageName = $.trim($("#packageName").val());
			if(packageName == null || packageName == ''){
				alert("套餐名称不可为空");
				return;
			}
			
			//套餐类型
			var packageType = $("#packageType").val();
			if(packageType == null || packageType == ''){
				alert("套餐类型不可为空");
				return;
			}
			
			//套餐计划固定费
			var packageFee = $.trim($("#packageFee").val());
			if(packageFee != null && packageFee != ''){
				if(isNaN(packageFee)){
					alert("套餐计划固定费必须为数字");
					return;
				}
			}
			
			//包月费免费期数
			var pagFreeNum = $.trim($("#pagFreeNum").val());
			var numTest = /^(0|[1-9][0-9]*)$/;
			if(pagFreeNum != null && pagFreeNum != ''){
				if(!numTest.test(pagFreeNum)){
					alert("包月费免费期数必须为数字");
					return;
				}
			}
			
			//运营商
			var operator = $("#operator").val();
			
			//某个套餐业务是否存在阶梯阀值为0的费率
			var maxCount=0;
			$("#addrate_table tr").find("td[name='nid']").each(function(){
				var nid = $(this).text();
				var val = $("#"+nid+"Max").val();
				if(val+"" == "undefined"){
					var valName = $("#nid").find("option[value='"+nid+"']").text();
					alert(valName + " 必须设定一条费率阶梯阀值为 0 的最大值");
					maxCount++;
					return false;
				}
		 	});
		 	
		 	if(maxCount != 0){
		 		return;
		 	}
		 	
		 	//提交数据
		 	var table =document.getElementById("addrate_table");
			var id = table.rows.length;
			if((packageType == 6 || packageType == 7) && id<=1){
				//费率套餐必须添加至少一条费率!
            	alert("费率套餐必须添加至少一条费率!");
                return false;
			}

			var packageNameOld = $("#packageNameOld").val();
			var packageTypeOld = $("#packageTypeOld").val();
			if(packageNameOld == packageName && packageTypeOld == packageType){
				//若套餐名和类型未变，可以更改其他属性
				buildJson();
			
				var json1 = $("#json1").val();

				var packageStatus = $("#packageStatus").val();
				
				var gid = $("#gid").val();
				
				var remark = $("#remark").val();
				
				var url = 'packageMainServlet.html';
				
				$.ajax({
					url:url,
					data:'cmd='+6+"&keyId="+keyId+"&packageName="+packageName+"&packageType="+packageType+"&packageFee="+packageFee+"&pagFreeNum="+pagFreeNum+
						"&packageStatus="+packageStatus+"&gid="+gid+"&remark="+remark+"&operator="+operator+"&json1="+json1,
					datatype:'html',
					type:'post',
					cache:false,
					timeout: 1000,
					async: false,//同步方式
					success:function(res){
						if(res == 'yes'){
							alert("操作成功");
							turnToMainPage();
						}else{
							alert("操作失败");
						}
					}
				});
			}else{
				//若套餐名已更改，需判断唯一性
				var urlstr='';
				var dsstr = 'tsdBilling';
				var tsdcfstr = 'oracle';
				urlstr=tsd.buildParams({ 	  
										  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:dsstr,//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:tsdcfstr,//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:'publicmode.keyExist'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
				});	
				$.ajax({
					url:"mainServlet.html?"+urlstr+"&tablename=ocs_package_main&whereinfo=package_name='"+tsd.encodeURIComponent(packageName)+"' and package_type="+packageType,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
						$(xml).find('row').each(function(){
							$(xml).find('cell').each(function(){
								if($(this).text() == '0'){
									buildJson();
			
									var json1 = $("#json1").val();
					
									var packageStatus = $("#packageStatus").val();
									
									var gid = $("#gid").val();
									
									var remark = $("#remark").val();
									
									var url = 'packageMainServlet.html';
									
									$.ajax({
										url:url,
										data:'cmd='+6+"&keyId="+keyId+"&packageName="+packageName+"&packageType="+packageType+"&packageFee="+packageFee+"&pagFreeNum="+pagFreeNum+
											"&packageStatus="+packageStatus+"&gid="+gid+"&remark="+remark+"&operator="+operator+"&json1="+json1,
										datatype:'html',
										type:'post',
										cache:false,
										timeout: 1000,
										async: false,//同步方式
										success:function(res){
											if(res == 'yes'){
												alert("操作成功");
												turnToMainPage();
											}else{
												alert("操作失败");
											}
										}
									});
								}else{
									alert("套餐名称 套餐类型 已经被使用，请重新输入!");
								}
							});	
						});	
					}
				});
			}
				
     
		});
		
		//费率添加
	 	$("#addrate_submit").click(function(){
	 		addrate_oper();
	 	});
	 	
	 	//切换套餐业务
	 	$("#nid").change(function(){
	 		var nid = $(this).val();
	 		bindParam(nid);
	 		$("#rateSalePolicy").attr("disabled",false);
	 	});
	});
	
	function bindParam(nid){
		var businessNum = $("#"+nid+"TCYW").attr("businessNum");
		var businessView = $("#"+nid+"TCYW").attr("businessView");
		var costPrice = $("#"+nid+"TCYW").attr("costPrice");
		var bType = $("#"+nid+"TCYW").attr("bType");
		var bnUnit = $("#"+nid+"TCYW").attr("bnUnit");
		$("#bnUnitNum").val(businessNum);
		$("#bnUnitValue").val(businessView);
		$("#costPrice").val(costPrice);
		$("#bType").val(bType);
		$("#bnUnit").val(bnUnit);
	}
	
	//绑定json属性
	function buildJson(){
			var json = "";
		 		var name;
		 		var text;
		 		var content;
	            $("#addrate_table tr").each(function(trindex,tritem){
	            	if(trindex!=0){
	            		json+="{"
		                $(tritem).find("td").each(function(tdindex,tditem){
		                	name =$(tditem).attr('name'); 
		                	if(name!=undefined && name!="bidname" && name != "nidName" && name != "bnUnitName" && name != "rateStatusName" && name != "bTypeName" && name != "rateSalePolicyName"){
		                		text = trim($(tditem).text());
		                		// bnUnitValue 为字符型, json 需要加双引号
		                		if( name == "bnUnitValue")
		                			json +="\""+ name +"\":\""+text+"\",";
		                		else
		                			json +="\""+ name +"\":"+text+",";
		                	}
		                	
		                });
		                json+="\"remark\":\"1\"";
		                json+="},"
	            	}
	            });
	            json=json.substring(0,json.length-1);
	            $("#json1").val("["+json+"]");
		}
	
	/*--获取网页传递的参数--*/
	function request(paras)
		{
			var url = location.href;
			var paraString = url.substring(url.indexOf("?")+1,url.length).split("&");
			var paraObj = {}
			for (i=0; j=paraString[i]; i++){
			paraObj[j.substring(0,j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=")+1,j.length);
		}
			var returnValue = paraObj[paras.toLowerCase()];
			if(typeof(returnValue)=="undefined"){
			return "";
		}else{
			return returnValue;
		}
	}

	//构建table tr
	function addrate_oper()
	{
		
		//套餐业务id
	 	var nid = $("#nid").find("option:selected").val(); 
	 	//套餐业务名称
	 	var nidName = $("#nid").find("option:selected").text();
	 	var bType = $("#bType").find("option:selected").val();
	 	var bTypeName = $("#bType").find("option:selected").text();
	 	//计费基本单位
	 	var bnUnit = $("#bnUnit").find("option:selected").val();
	 	//计费基本单位名称
	 	var bnUnitName = $("#bnUnit").find("option:selected").text();
	 	//计费基本单位数量
	 	var bnUnitNum = $("#bnUnitNum").val();
	 	//计费基本单位显示值
	 	var bnUnitValue = $("#bnUnitValue").val();
	 	//费率阶梯阀值
	 	var bnThreshold = $("#bnThreshold").val();
	 	//特服费率
	 	var specialRate = $("#specialRate").val();
	 	if(bnThreshold >0 ){//如果费率阶梯阀值大于0则是阶梯费率不能添加特服费率
	 		if(specialRate != 0){//如果特服费率大于0该条不能添加
	 			alert("阶梯费率业务不能添加特服费率！");
	 			return;
	 		}else{//如果特服费率为0判断之前添加的是否有费率阀值为0的如果有将其特服费率置为0
	 			var resetSpecialFee = false;
	 			$("#addrate_table tr").each(function(trindex,tritem){
					$(tritem).find("td").each(function(tdindex,tditem){	
						var name =$(tditem).attr('name');
						if(name=="nid" && nid == trim($(tditem).text())){
							resetSpecialFee = true;
						}
						if(name=="specialRate" && resetSpecialFee && trim($(tditem).text())>0){
							alert("阶梯费率业务特服费率被置为0！");
							$(tditem).text("0");
							restSpecialFee = false;
						}
					});
			 	});
	 		}
	 	}
	 	
	 	//业务费率成本
	 	var costPrice = $("#costPrice").val();
	 	//业务费率
	 	var bnRatePrice = $("#bnRatePrice").val();
	 	//业务费率状态
	 	var rateStatus = $("#rateStatus").find("option:selected").val();
	 	//业务费率状态名称
	 	var rateStatusName = $("#rateStatus").find("option:selected").text();
	 	//免费资源容量
	 	var freeResVolume = $("#freeResVolume").val();
	 	
	 	if(nid == null || nid == ''){
	 		//套餐业务不可为空
	 		alert("套餐业务不可为空");
	 		return;
	 	}
	 	
	 	if(bType < 0){
	 		alert("业务类别不可为空");
	 		return;
	 	}
	 	
	 	if(bnUnitNum == null || bnUnitNum == ''){
	 		//基本单位数量不可为空
	 		alert("基本单位数量不可为空");
	 		return;
	 	}
	 	if(bnUnitValue == null || bnUnitValue == ''){
	 		//基本单位数量显示值不可为空
	 		alert("基本单位数量显示值不可为空");
	 		return;
	 	}
	 	
	 	if(costPrice!=null&&costPrice!=""){
		 	if(isNaN(costPrice)){
		 		//业务费率成本必须是数字
		 		alert("业务费率成本必须为数字");
				return;
			}
		}
		
		if(bnUnit < 0){
			alert("基本单位不可为空");
			return;
		}
		
	 	if(bnRatePrice!=null&&bnRatePrice!="")
	 	{
	 		if(isNaN(bnRatePrice)){
	 			//业务费率必须是数字
	 			alert("业务费率必须为数字");
				return ;
			}
	 	}
	 	else
	 	{
	 		//业务费率不能为空
	 		alert("业务费率不能为空");
	 		return ;
	 	}
	 	
	 	if(isNaN(bnThreshold)){
 			//费率阶梯阀值必须是数字
 			alert("费率阶梯阀值必须为数字");
			return ;
		}
		
		var packageType = $("#packageType").val();
	 	var basicNumMin = $("#basicNumMin").val();
	 	var basicNumMax = $("#basicNumMax").val();
	 	var basicFee = $("#basicFee").val();
	 	var re = /^(0|[1-9][0-9]*)$/;
	 	if(packageType == 7){
	 		//兜底套餐
	 		if(!re.test(basicNumMin)){
	 			alert("基本次数下限必须为整数");
				return ;
			}
			if(!re.test(basicNumMax)){
	 			alert("基本次数上限必须为整数");
				return ;
			}
			if(isNaN(basicFee)){
	 			alert("基本话费必须为数字");
				return ;
			}
	 	}else{
	 		if(freeResVolume != null && $.trim(freeResVolume) != ''){
	 			if(isNaN(freeResVolume)){
		 			//免费资源容量必须是数字
		 			alert("免费资源容量必须为数字");
					return ;
				}
		 	}else{
		 		freeResVolume = 0;
		 	}
	 	}
	 	
	 	var rateSalePolicy = $("#rateSalePolicy").find("option:selected").val();
	 	var rateSalePolicyName = '';
	 	if(rateSalePolicy != -1){
	 		rateSalePolicyName = $("#rateSalePolicy").find("option:selected").text();
	 	}
		
	 	//判断阶梯
		var name;
		var nidtext = "";
		var thresHold = "";
		var freeResVolumetext = "";
		var rateSalePolicytext = "";
		$("#addrate_table tr").each(function(trindex,tritem){
			$(tritem).find("td").each(function(tdindex,tditem){	
				name =$(tditem).attr('name');
				if(name=="nid")
				{
					nidtext = nidtext + "," + trim($(tditem).text());
				}
				if(name=="bnThreshold")
				{
					thresHold = thresHold + "," + trim($(tditem).text());
				}
				if(name=='freeResVolume'){
					freeResVolumetext = freeResVolumetext + "," + trim($(tditem).text());
				}
				if(name=='rateSalePolicy'){
					rateSalePolicytext = rateSalePolicytext + "," + trim($(tditem).text());
				}
			});
	 	});
	 	
	 	//保存免费资源
		var map = {}
		var map2 = {}//保存优惠
	 	// 非空校验
	 	if( nidtext!="" && thresHold!="" && freeResVolumetext != "")
	 	{
		 	// 解析已添加校验参数
		 	var nidtexts = nidtext.split(",");
		 	var thresHolds = thresHold.split(",");
			var freeResVolumes = freeResVolumetext.split(",");
			var rateSalePolicys = rateSalePolicytext.split(",");
		 	for( var i=0;i<nidtexts.length;i++ )
		 	{
		 		// 校验重复
			 	if( nid==nidtexts[i] && bnThreshold==thresHolds[i])
			 	{
			 		//已存在该费率
			 		alert("已存在该费率");
			 		return false;
			 	}
			 	
			 	//保存免费资源
			 	if(freeResVolumes[i] != ''){
			 		if(parseInt(freeResVolumes[i]) != 0){
				 		map[nidtexts[i]] = freeResVolumes[i];
				 	}
			 	}
			 	
			 	//保存优惠
			 	if(rateSalePolicys[i] != ''){
				 	map2[nidtexts[i]] = rateSalePolicys[i];
			 	}
			}
			
			for( var i=0;i<nidtexts.length;i++ ){
				if(parseInt(freeResVolume) != 0 && map[nid] != undefined && map[nid] != '' ){
					//alert("'"+nidName+"' 已添加免费资源，不可重复添加");
					freeResVolume = 0;
				}
			}
			
			for( var i=0;i<nidtexts.length;i++ ){
				if(map2[nid] != undefined && map2[nid] != '' ){
					if(rateSalePolicy != map2[nid]){
						alert("同一个【"+nidName+"】只能选择一种优惠策略！");
						return;
					};
					
					//rateSalePolicy = map2[nid];
					
					//$("#rateSalePolicy").val(rateSalePolicy);
					//if(rateSalePolicy > 0){
						//rateSalePolicyName = $("#rateSalePolicy").find("option:selected").text();
					//}else{
						//rateSalePolicyName = '';
					//}
				}
			}
		}
		
	 	
	 	var table = document.getElementById("addrate_table");
  		var id = table.rows.length;
  			
	 	var tr="<tr align='center' height='25'>";
	 	tr+="<td name='id' >"+id+"</td>";
	 	tr+="<td name='nid' style='display:none'>"+nid+"</td>";
	 	tr+="<td name='nidName' >"+nidName+"</td>";
	 	tr+="<td name='bType' style='display:none'>"+bType+"</td>";
	 	tr+="<td name='bTypeName' >"+bTypeName+"</td>";
	 	tr+="<td name='bnUnit' style='display:none'>"+bnUnit+"</td>";
	 	tr+="<td name='bnUnitName'>"+bnUnitName+"</td>";
	 	tr+="<td name='bnRatePrice' >"+bnRatePrice+"</td>";
	 	tr+="<td name='costPrice'>"+costPrice+"</td>";
	 	tr+="<td name='bnUnitNum' style='display:none'>"+bnUnitNum+"</td>";
	 	tr+="<td name='bnUnitValue' style='display:none'>"+bnUnitValue+"</td>";
	 	tr+="<td name='bnThreshold'>"+bnThreshold+"</td>";
	 	tr+="<td name='rateStatus' style='display:none'>"+rateStatus+"</td>";
	 	tr+="<td name='rateStatusName' style='display:none'>"+rateStatusName+"</td>";
	 	
	 	tr+="<td name='rateSalePolicy' style='display:none'>"+rateSalePolicy+"</td>";
	 	tr+="<td name='rateSalePolicyName'>"+rateSalePolicyName+"</td>";
	 	if(packageType == 7){
	 		//非兜底套餐
	 		tr+="<td name='freeResVolume' style='display:none'>"+freeResVolume+"</td>";
	 		//兜底套餐
	 		tr+="<td name='basicNumMin' style='display:none'>"+basicNumMin+"</td>";
	 		tr+="<td name='basicNumMax'>"+basicNumMax+"</td>";
	 		tr+="<td name='basicFee'>"+basicFee+"</td>";
	 	}else{
	 		//非兜底套餐
	 		tr+="<td name='freeResVolume'>"+freeResVolume+"</td>";
	 		//兜底套餐
	 		tr+="<td name='basicNumMin'  style='display:none'>"+basicNumMin+"</td>";
	 		tr+="<td name='basicNumMax'  style='display:none'>"+basicNumMax+"</td>";
	 		tr+="<td name='basicFee'  style='display:none'>"+basicFee+"</td>";
	 	}
	 	//特服费率
 		tr+="<td name='specialRate'>"+specialRate+"</td>";
	 	tr+="<td> <span onclick='$(this).parent().parent().remove();delrow("+nid+","+bnThreshold+");' ><span style='color: red; cursor:pointer;'>删除</span></td>";
		tr+="</tr>";
	 	$("#addrate_table").append(tr);
	 	
	 	if(bnThreshold == 0){
	 		var hdParam = $("#"+nid+"Max").val();
	 		if(hdParam+"" == 'undefined'){
	 			$("#hdParam").append("<input id='"+nid+"Max'/>");
	 		}
	 	}
	 	
	 	//重置数据
	 	$("#rateStatus").val("0");
	 	$("#bnRatePrice").val("");
	 	$("#bnThreshold").val("0");
	 	$("#freeResVolume").val("0");
	 	$("#basicNumMin").val("0");
	 	$("#basicNumMax").val("0");
	 	$("#basicFee").val("0");
	 	var packageType = $("#packageType").val();
	 	if(packageType == 7){
	 		var basicFeeHid = $("#basicFeeHid").val();
	 		$("#basicFeeHid").val(parseInt(basicFeeHid)+1);
	 		$("#basicFeeHid").attr("packageType",packageType);
	 	}else{
	 		var notbasicFeeHid = $("#notbasicFeeHid").val();
	 		$("#notbasicFeeHid").val(parseInt(notbasicFeeHid)+1);
	 		$("#notbasicFeeHid").attr("packageType",packageType);
	 	}
	 	
	 	//$("#rateSalePolicy").attr("disabled",true);
	};	
	
	//重置数据
	function resetMtd(){
		$("#packageName").val("");
		$("#packageFee").val("0");
		$("#packageStatus").val("1");
		$("#pagFreeNum").val("0");
		$("#gid").val("-1");
		$("#remark").val("");
		$("#bnRatePrice").val("");
		$("#bnThreshold").val("0");
		$("#rateStatus").val("0");
		$("#freeResVolume").val("0");
		$("#basicNumMin").val("0");
	 	$("#basicNumMax").val("0");
	 	$("#basicFee").val("0");
	}
	
	//删除row
	function delrow(nid, bnThreshold)
	{
		var packageType = $("#packageType").val();
		if(packageType == 7){
			var basicFeeHid = $("#basicFeeHid").val();
			$("#basicFeeHid").val(parseInt(basicFeeHid)-1);
		}else{
			var notbasicFeeHid = $("#notbasicFeeHid").val();
			$("#notbasicFeeHid").val(parseInt(notbasicFeeHid)-1);
		}
		
		if(bnThreshold == 0){
			$("#"+nid+"Max").remove();
		}
	}
		
	//显示费率
	function showRate(){
		$("#addrate_div").show();
	}
	
	//隐藏费率
	function hideRate(){
		$("#addrate_div").hide();
	}
	//跳转到首页
	function turnToMainPage(){
		//jumpPage('telephone/business/packageMain.jsp');
		window.history.back();
	}
	
	//切换套餐类型
	function changePackageType(){
		var basicFeeHid = parseInt($("#basicFeeHid").val());
		var basicFeeHidPtype = $("#basicFeeHid").attr("packageType");
		var notbasicFeeHid = parseInt($("#notbasicFeeHid").val());
		var notbasicFeeHidPtype = $("#notbasicFeeHid").attr("packageType");
		
		var packageType = $("#packageType").val();
		if(packageType == 7){
			if(notbasicFeeHid != 0){
				$("#packageType").val(notbasicFeeHidPtype);
				alert("请先删除非兜底套餐费率");
				return;
			}
			//兜底套餐
			$(".basicFeeUp").hide();
			$(".basicFeeDown").show();
			$("#bnThreshold").attr("disabled",true);
		}else{
			if(basicFeeHid != 0){
				$("#packageType").val(basicFeeHidPtype);
				alert("请先删除兜底套餐费率");
				return;
			}
			//其他套餐
			$(".basicFeeUp").show();
			$(".basicFeeDown").hide();
			$("#bnThreshold").attr("disabled",false);
		}
	}
		//页面跳转
function jumpPage(pagename){
	if (!pagename || pagename == "#") {
		return;
	}
	$('#main-frame', parent.document).attr('src', 'mainServlet.html?pagename=' + pagename + '&tsdtemp=' + Math.random());
}
	</script>
</head>

<body style="background-color:#F4FCFE;"> 
	<div id="navBar">
		<img src="style/icon/dot11.gif" style="margin-left: 10px" />
		<fmt:message key="global.location" />
		: 套餐管理 >>> <a href="#" onclick="turnToMainPage();">套餐管理</a> >>> 修改
		<div style="position:fixed; right:35px;line-height:20px;">
			<a onclick="parent.history.back(); return false;" href="javascript:void(0);">返 回</a>
		</div>
	</div>
  	<br />
  	<div id="hdParam" style="display:none;">
  		<input id="json1"/>
  		<input id="basicFeeHid" packageType="" value="0"/>
  		<input id="notbasicFeeHid" packageType="" value="0"/>
  	</div>
	<form id="addform" action="#"
		style="width: 99.5%;text-align:center;margin:0px auto;text-align:center;">
		<div id="rate_panel" style="margin-left:-100px;width: 99.5%">
			<fieldset class="fieldset" style="width: 957px;">
				<legend style="margin-top:20px; font-size:13px;color:#000000;margin-left:0px;">
					<b>费率套餐设置</b>
				</legend>
				<table border="0"  style="width: 90%;">
					<tr bgcolor="" align="center" height="27">
						<td align="right" >
							套餐名称:
						</td>
						<td align="left">
							<input type="hidden" id="keyId"/>
							<input type="hidden" id="packageNameOld" name="packageNameOld" class="text"
								value="" />
							<input type="text" id="packageName" name="packageName" class="text"
								value="" />
							<span style="color: red">*</span>
						</td>
						<td align="right">
							套餐类型:
						</td>
						<td align="left">
							<input type="hidden" id="packageTypeOld" name="packageTypeOld" class="text"
								value="" />
							<select id="packageType" name="packageType" style="width:217px; margin-left:0px;" onchange="changePackageType();">
								
							</select>
							<span style="color: red">*</span>
						</td>
						<td align="right">
						</td>
					</tr>
					<tr bgcolor="" align="center" height="27">
					<td align="right">
							套餐计划固定费:
						</td>
						<td align="left">
							<input type="text" id="packageFee" name="packageFee" class="text"
								value="0" />
						</td>
						<td align="right">
							费率套餐状态:
						</td>
						<td align="left">
							<select id="packageStatus" name="packageStatus" style="width:217px;margin-left:0px;">
								<option value="1">创建</option>
								<option value="2">已发布</option>
								<option value="3">下线</option>
							</select>
							<span style="color: red">*</span>
						</td>
						<td align="right">
						</td>
						<td>
						</td>
					</tr>
					<tr bgcolor="" align="center" height="27">
						<td align="right">
							包月费免费期数:
						</td>
						<td align="left">
							<input type="text" id="pagFreeNum" name="pagFreeNum" class="text"
								value="0" />
						</td>
						<td align="right">
							赠送礼品:
						</td>
						<td align="left">
							<select id="gid" name="gid" style="width:217px;margin-left:0px;">
								<option value="-1">--请选择--</option>
							</select>							
						</td>
						<td align="right"></td><td></td>
					</tr>
					<tr bgcolor="" align="center" height="27">
						<td align="right">
							运营商:
						</td>
						<td align="left">
							<select id="operator" name="operator" style="width:136px;margin-left:0px;">
								<option value="1">电信</option>
								<option value="2">联通</option>
								<option value="3">内部</option>
							</select>	
						</td>
						<td align="right">
						</td>
						<td align="left">
						</td>
						<td align="right"></td><td></td>
					</tr>
					
					<tr height="35">
						<td align="right">
							套餐描述:
						</td>
						<td colspan="4" align="left">
							<textarea id="remark" name="remark" class="text" rows="4" style="width: 625px;"></textarea>
						</td>
						<td colspan="2">
							<center>
								<div id="buttons" style="background:url(); border-top:0px; border-bottom:0px;">
									<!-- 添加费率 -->
									<button type="button" id="openadd1" onclick="showRate();">
										添加费率
								    </button>
							    </div>
							</center>
						</td>
	
					</tr>
				</table>
	
				<div id="addrate_div"
					style="display: none;  position: relative;">
					<fieldset id="addrate_panel" class="fieldset" style="width:953px;">
						<legend style="font-size: 13px; color:#000000;margin-left:0px;">
							<b>添加套餐业务费率</b>
						</legend>
						<table border="0">
							<tr height="29">
								<td align="right">
									套餐业务:
								</td>
								<td align="left" >
									<select id="nid" class="" style="margin-left:0px;">
										
									</select>
									<span style="color: red">*</span>
								</td>
								<td align="right">
									业务类别:
								</td>
								<td align="left">
									<select id="bType" class="" style="margin-left:0px;width:135px;" disabled="disabled">
										<option value="-1"></option>
										<option value="1">语音</option>
										<option value="2">宽带</option>
										<option value="3">短信</option>
										<option value="4">其他</option>
									</select>
								</td>
								<td align="right">
									基本单位数量:
								</td>
								<td align="left">
									<input id="bnUnitNum" class="text_subitem" type="text" value="" readonly="true"  style="background-color:#ECE9D8;"/>
								</td>
							</tr>
							<tr height="29">
								<td align="right">
									基本单位显示值:
								</td>
								<td align="left">
									<input id="bnUnitValue" class="text_subitem" type="text" value="" readonly="true" style="background-color:#ECE9D8;"/>
								</td>
								<td align="right">
									业务费率成本:
								</td>
								<td align="left">
								 <input id="costPrice" class="text_subitem" type="text" value="" readonly="true" style="background-color:#ECE9D8;"/>
								</td>
								<td align="right">
									基本单位:
								</td>
								<td width="200" align="left">
									<select id="bnUnit" class="text_subitem" style="margin-left:0px;width:136px;" disabled="disabled">
										<option value="-1"></option>
										<option value="1">时长</option>
										<option value="2">流量</option>
										<option value="3">次</option>
										<option value="4">其他</option>
									</select>
									<span style="color: red">*</span>
								</td>
							</tr>
	
							<tr>
								<td align="right">
									业务费率:
								</td>
								<td width="200" align="left">
									<input id="bnRatePrice" type="text" class="text_subitem" />
									<font color="red"><b>*</b></font>
								</td>
								<td align="right">
									费率阶梯阀值:
								</td>
								<td width="200" align="left">
									<input id="bnThreshold" type="text" class="text_subitem" value="0"/>
								</td>
								<td align="right">
									业务费率状态:
								</td>
								<td align="left">
									<select id="rateStatus" class="text_subitem" style="margin-left:0px;width:136px;">
										<option value="0">启用</option>
										<option value="1">未启用</option>
									</select>
								</td>
							</tr>
							
							<tr>
								<td align="right">
									优惠策略:
								</td>
								<td align="left">
									<select id="rateSalePolicy" name="rateSalePolicy" style="width:136px;margin-left:0px;">
									<option value="-1">--请选择--</option>
								</select>
								</td>
								<td align="right" class="basicFeeUp">
									免费资源容量:
								</td>
								<td align="left" class="basicFeeUp">
									<input id="freeResVolume" type="text" class="text_subitem" value="0"/>
								</td>
								<td align="right" class="basicFeeDown" style="display:none;">基本次数下限:</td>
								<td align="left" class="basicFeeDown" style="display:none;"><input id="basicNumMin" type="text" class="text_subitem" value="0"/></td>
								<td align="right" class="basicFeeDown" style="display:none;">基本次数上限:</td>
								<td align="left" class="basicFeeDown" style="display:none;"><input id="basicNumMax" type="text" class="text_subitem" value="0"/></td>
							</tr>
			
							<tr class="basicFeeDown" style="display:none;">
								<td align="right">基本话费:</td>
								<td align="left"><input id="basicFee" type="text" class="text_subitem" value="0"/></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td align="right">特服费率:</td>
								<td align="left"><input id="specialRate" type="text" class="text_subitem" value="0"/></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
							 	<td colspan="5" align="right">
							 		&nbsp;
							 	</td>
								<td colspan="2" align="left">
									<div id="buttons" style="background:url(); border-top:0px; border-bottom:0px;">
										<!-- 确定 -->
										<button id="addrate_submit" type='button' class="module_btn">
											确定
										</button>
										<!-- 取消 -->
										<button  id="addrate_closepanel" type='button' class="reset_btn" onclick="hideRate();">
											取消
										</button>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="8" align="center"></td>
							</tr>
						</table>
					</fieldset>
				</div>
	
				<div style="display: block;  position: relative;"
					align="center">
					<table id="addrate_table" class="tableClass" style="width: 100%;"
						align="center">
						<tr style="background-color: #E1DCF4;" align="center" height="25">
							<td>
								<b>No</b>
							</td>
							<td>
								<b>套餐业务</b>
							</td>
							<td>
								<b>业务类别</b>
							</td>
							<td>
								<b >基本单位</b>
							</td>
							<td>
								<b>业务费率</b>
							</td>
							<td>
								<b>业务费率成本</b>
							</td>
							<!--<td>
								<b>基本单位数量</b>
							</td>
							<td>
								<b>基本单位显示值</b>
							</td>
							--><td>
								<b>费率阶梯阀值</b>
							</td>
							<!--<td>
								<b>业务费率状态</b>
							</td>
							--><td>
								<b>优惠策略</b>
							</td>
							<td  class="basicFeeUp">
								<b>免费资源容量</b>
							</td>
							<!--<td class="basicFeeDown" style="display:none;">
								<b>基本次数下限</b>
							</td>
							--><td class="basicFeeDown" style="display:none;">
								<b>基本次数上限</b>
							</td>
							<td class="basicFeeDown" style="display:none;">
								<b>基本话费</b>
							</td>
							<td>
								<b>特服费率</b>
							</td>
							<td>
								<b>操作</b>
							</td>
						</tr>
					</table>
				</div>
				<div id="buttons" style="background:url(); border-top:0px; border-bottom:0px;">
					<!-- 提交 -->
					<button type='button' class="module_btn modPage" 
					id="form_submit">
						提交
					</button>
					<!-- 重置 -->
					<button  type='button' class="reset_btn modPage" onclick="resetMtd();">
						重置
					</button>
					
					<!-- 确定 -->
					<button  type='button' style="display:none;" class="detailPage" onclick="javascript:window.history.back();" >
						确定
					</button>
				</div>
				
			</fieldset>
		</div>
	</form>
</body>
</html>
