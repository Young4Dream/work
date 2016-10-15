<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/PhoneModifyproperties.jsp
    Function:   电话修改属性
    Author:     wenxuming
    Date:       2010-10
    Description: 
    Modify: 
     2010-10月份 对该页面进行移植，并对版式进行修改；
     2010-11-03 把公用的CSS提取出来放到style/css/telephone/business/businesspublic.css；
     2010-11-04 设置代缴合同号信息提示，函数getdaijiaotishi()；
     2010-11-05 修改设置权限问题；
     2010-11-22 修改属性显示合同号用户性质时如果下拉框没有该数据可自动把查询出来的数据加载到select显示框中，添加了函数getyhlbisnull(yhlb,yhxz);
-----------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	/////////////////Java取当前时间
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
	SimpleDateFormat formatto = new SimpleDateFormat("yyyy-MM-dd");
	Date now = new Date();
	String nowTime = format.format(now);
	String nowTimeto = formatto.format(now);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<meta http-equiv="description" content="this is my page" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
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
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css"/>
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservice.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservicenew.js" type="text/javascript" language="javascript"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
		<script src="script/telephone/business/phoneInstalled.js" type="text/javascript"></script>
		<script src="script/telephone/business/phone_kjbq_gh.js" type="text/javascript"></script>
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
		<!--设置全局字体大小-->
		<link href="style/css/telephone/business/fontsize_all.css" rel="stylesheet" type="text/css"/>
		<script src="plug-in/MultiSelect/jquery.bgiframe.min.js" type="text/javascript"></script>
		<script src="plug-in/MultiSelect/jquery.multiSelect.js" type="text/javascript"></script>			
		<link href="plug-in/MultiSelect/jquery.multiSelect.css" rel="stylesheet" type="text/css" />
		<style type="text/css">
		#checkroutetype{
			width:400px;
			height:20px; 
		}
		</style>
		<script type="text/javascript">
		/*********
		* 初始加载
		* @param;
		* @return;
	    **********/
		 jQuery(document).ready(function(){
	 		$("#navBar").append(genNavv());		    	
	    	lodingpage();//异步获取加载页面提示，其中包括加载数据等在此方法中完成phoneInstalled.jsp中
	    	getUserPower();//权限
	    	gettable();//默认加载固定费跟包月费显示框		
			getTFGN();
			$("#Tfgn_yhdang").multiSelect({ oneOrMoreSelected: '*'},'','checkroutetype','~');	 		
			
			var res = fetchSingleValue("dbsql_phone.querytabledate",6,"&tablename=tsd_ini&cloum=tvalues&key=tident='setShows' and tsection='phonebusiness'"); 										
				var arrayRes="";
				var arrayShow="";
				if(res!=""&&res!=undefined){
					arrayRes=res.split('|');
					for(var i=0;i<arrayRes.length;i++){
						arrayShow=arrayRes[i].split(':');
						if(arrayShow[1]=="false"){
							$("#"+arrayShow[0]+"").hide();
						}else{
							$("#"+arrayShow[0]+"").show();
						}
						
					}				
				}
								
		});
		//用户信息暂存
		var _user_dhXGXX_ = false;		
		/*******
	   	* 电话基本信息
	   	* @param:Dh电话;
	   	* @return;
	  	********/
		function ghSerBasicInfo(Dh)
		{
			var result = fetchMultiPValue("PhoneDH.ifCanSouLi",6,"&OperID=" + tsd.encodeURIComponent($("#userid").val()) + "&Ywlx="+tsd.encodeURIComponent("p_editproperty")+"&NowYwArea="+tsd.encodeURIComponent($("#area").val())+"&Dh="+Dh);
						if(result[0]!=undefined && result[0][0]!="")
						{
							alert(result[0][1]);
							return false;
						}
			pageselect();
			addspeediFeeType(Dh);
			var urlstr=tsd.buildParams({packgname:'service',//java包
										clsname:'ExecuteSql',//类名
										method:'exeSqlData',//方法名
										ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdcf:'mssql',//指向配置文件名称
										tsdoper:'query',//操作类型 
										datatype:'xmlattr',//返回数据格式 
										tsdpk:'PhonemoveAddress.dhBasicInfo'
										});
			var params = "&Dh=" + Dh;
			$.ajax({
				url:"mainServlet.html?"+urlstr+params,
				cache:false,
				success:function(xml){
					$(xml).find("row").each(function(){						
						getdhBYTC(Dh);
						$("#Dh_yhdang").val($(this).attr("dh")==undefined?"":$(this).attr("dh"));						
						//用户姓名
						$("#Yhmc_yhdang").val($(this).attr("yhmc")==undefined?"":$(this).attr("yhmc"));						
						//合同号
						$("#Hth_yhdang").val($(this).attr("hth")==undefined?"":$(this).attr("hth"));						
						ghSerBasicInfoHthHf($(this).attr("hth"));
						ghSerBasicInfoHth($(this).attr("hth"));
						//一级部门
						$("#Bm1_yhdang").val($(this).attr("bm1")==undefined?"":$(this).attr("bm1"));						
						$("#Bm1_yhdang").trigger("change");
						//二级部门
						var bm2 = $(this).attr("bm2")==undefined?"":$(this).attr("bm2");
						$("#Bm2_yhdang").val(bm2);
						$("#Bm2_yhdang").trigger("change");
						//三级部门
						var bm3 = $(this).attr("bm3")==undefined?"":$(this).attr("bm3");
						$("#Bm3_yhdang").val(bm3);
						$("#Bm3_yhdang").trigger("change");
						//四级部门
						var bm4 = $(this).attr("bm4")==undefined?"":$(this).attr("bm4");
						$("#Bm4_yhdang").val(bm4);						
						//密码
						$("#Mima_yhdang").val($(this).attr("mima")==undefined?"":$(this).attr("mima"));
						//确认密码
						$("#toMima_yhdang").val($(this).attr("mima")==undefined?"":$(this).attr("mima"));
						//模块局
						$("#MokuaiJu_yhdang").val($(this).attr("mokuaiju")==undefined?"":$(this).attr("mokuaiju"));						
						//业务区域
						$("#YwArea_yhdang").val($(this).attr("ywarea")==undefined?"":$(this).attr("ywarea"));						
						//联系电话
						$("#Bz9_yhdang").val($(this).attr("bz9")==undefined?"":$(this).attr("bz9"));						
						//联系人
						$("#Bz8_yhdang").val($(this).attr("bz8")==undefined?"":$(this).attr("bz8"));											
						//计费起始
						$("#StartDate_yhdang").val($(this).attr("startdate")==undefined?"":$(this).attr("startdate"));						
						//计费终止
						$("#EndDate_yhdang").val($(this).attr("enddate")==undefined?"":$(this).attr("enddate"));						
						//装机日期
						$("#Reg_Date_yhdang").val($(this).attr("reg_date")==undefined?"":$(this).attr("reg_date"));						
						//强制停开
						$("#StopBz_yhdang").val($(this).attr("stopbz")==undefined?"":$(this).attr("stopbz"));						
						//停机标志
						$("#Tjbz_yhdang").val($(this).attr("tjbz")==undefined?"":$(this).attr("tjbz"));						
						//调级策略
						$("#AdjustSheduleNo_yhdang").val($(this).attr("adjustsheduleno")==undefined?"":$(this).attr("adjustsheduleno"));						
						//催缴策略
						$("#CallSheduleNo_yhdang").val($(this).attr("callsheduleno")==undefined?"":$(this).attr("callsheduleno"));						
						//计费类别
						$("#Jflb_yhdang").val($(this).attr("jflb")==undefined?"":$(this).attr("jflb"));						
						//补贴类别
						$("#Mfjb_yhdang").val($(this).attr("mfjb")==undefined?"":$(this).attr("mfjb"));						
						//话机类型
						$("#TypeNum_yhdang").val($(this).attr("typenum")==undefined?"":$(this).attr("typenum"));						
						//电话功能
						//$("#Dhgn_yhdang").val($(this).attr("dhgn")==undefined?"":getyhdangDHgn($(this).attr("dhgn")));						
						$("#Dhgn_yhdang").val($(this).attr("dhgn")==undefined?"":$(this).attr("dhgn"));
						//交换机编号
						$("#Jhj_ID_yhdang").val($(this).attr("jhj_id")==undefined?"":$(this).attr("jhj_id"));						
						//用户地址
						$("#Yhdz_yhdang").val($(this).attr("yhdz")==undefined?"":$(this).attr("yhdz"));
						//短信催缴号
						$("#Mobile_yhdang").val($(this).attr("mobile")==undefined?"":$(this).attr("mobile"));					
						//重要级别
						$("#Zyjb_yhdang").val($(this).attr("zyjb")==undefined?"":$(this).attr("zyjb"));						
						//证件类型
						$("#Bz6_yhdang").val($(this).attr("bz6")==undefined?"":$(this).attr("bz6"));						
						//证件号码
						$("#Bz7_yhdang").val($(this).attr("bz7")==undefined?"":$(this).attr("bz7"));				
						//正常话务级别
						//$("#TrafficLevel").val($(this).attr("Hwjb")==undefined?"":$(this).attr("Hwjb"));					
						$("#TrafficLevel").val($(this).attr("hwjb1")==undefined?"":$(this).attr("hwjb1"));
						$("#Hwjb1_yhdang").val($(this).attr("hwjb1")==undefined?"":$(this).attr("hwjb1"));		
						$("#CreditGrade_yhdang").val($(this).attr("creditgrade")==undefined?"":$(this).attr("creditgrade"));//信誉等级						
						$("#CreditPoint_yhdang").val($(this).attr("creditpoint")==undefined?"":$(this).attr("creditpoint"));//信誉积分						
						$("#CustType_yhdang").val($(this).attr("custtype")==undefined?"":$(this).attr("custtype"));//客户类型
						$("#yhxzyhdanghidden").val($(this).attr("usertype")==undefined?"":$(this).attr("usertype"));
						$("#UserType_yhdang").val($(this).attr("usertype")==undefined?"":$(this).attr("usertype"));//用户类型	
						setTimeout("getyhxzyhdang()",100);
						//************************************************************************************
						$("#Bz1_yhdang").val($(this).attr("bz1")==undefined?"":$(this).attr("bz1"));						
						$("#Bz3_yhdang").val($(this).attr("bz3")==undefined?"":$(this).attr("bz3"));
						$("#Bz4_yhdang").val($(this).attr("bz4")==undefined?"":$(this).attr("bz4"));
						$("#Bz5_yhdang").val($(this).attr("bz5")==undefined?"":$(this).attr("bz5"));
						//并机备注
						$("#cBingJiBeiZhu").val($(this).attr("bz5")==undefined?"":$(this).attr("bz5"));
					});
				}
			});
		}
		
		function getTFGN(){
	   		//clearMultiSelect_AABC();//清空多选下拉框
	   		var res = fetchMultiArrayValue("dbsql_phone.attachpriceTFGN",6,"",'business');
		 	if(res!=undefined&&res!=""){
		 		var str="<option value=''>--<fmt:message key="phone.getinternet0280" />--</option>";
			 	for(var j=0;j<res.length;j++){
			 		str+="<option value='"+res[j][0]+"'>"+res[j][0]+"</option>"
			 	}
			 	$("#Tfgn_yhdang").html(str);
		 	}else{
		 		$("#Tfgn_yhdang").html("<option value=''>--is null--</option>");
		 	}
		}
		
		//弹出修改功能面板点击保存调用
		function getDhgcparam(){
			if($("#newDhgn").val()==""){
				alert("请选择呼出权限！");
				$("#newDhgn").select().focus();
				return;
			}
			var multistr='';
			//var mulselectoper = obj.rows[i].mulselectoper;
			$("[name='Tfgn_yhdang'][checked]").each(function(){
				multistr +=$(this).val()+",";			
			}) ; 
			$("#Tfgn_yhdang").val("");
			//var len = multistr.lastIndexOf(mulselectoper);
			//if(len>0){multistr = multistr.substr(0,len);}
			$("#Dhgn_yhdang").val(multistr+$("#newDhgn").val());
			$("#newDhgn").val("");
			$("#tfgn_div").empty();
			$("#tfgn_div").append('<select id="Tfgn_yhdang" name="Tfgn_yhdang" style="width:400px;"></select>');	
			getTFGN();		
			$("#Tfgn_yhdang").multiSelect({ oneOrMoreSelected: '*'},'','checkroutetype','~');
			setTimeout($.unblockUI,15);				
		}
		
		function getyhxzyhdang(){	
			$("#UserType_yhdang").val($("#yhxzyhdanghidden").val());//用户类型	
		}
		
		
		//取话费余额和当前月话费
	function ghSerBasicInfoHthHf(Hth)
	{
		var res = fetchMultiArrayValue("PhonemoveAddress.dhBasicInfoHthHf",6,"&Hth="+Hth+"&dhfee="+tsd.encodeURIComponent("<fmt:message key="phone.getinternet0353" />"));//电话费
		if(res[0]==undefined||res[0][0]==undefined)
		{
			return false;
		}
		var str = res[0][1].substr(0,1);
		if(str=="-"){
			//$("#spanyucunYE").text("出帐月欠费");
			$("#spanyucunYE").text("<fmt:message key="phone.getinternet0143" />");
			//$("#spanyucunYE_title").text("出帐月欠费");
			$("#spanyucunYE_title").text("<fmt:message key="phone.getinternet0143" />");
			//话费余额
			$("#phoneBalance").val(res[0][1].substr(1,res[0][1].length));
			$("#phoneBalance_to").val(res[0][1].substr(1,res[0][1].length));
			$("#czyfee").val("NO");
		}else{
			//$("#spanyucunYE").text("出帐月余额");
			$("#spanyucunYE").text("<fmt:message key="phone.getinternet0148" />");
			//$("#spanyucunYE_title").text("出帐月余额");
			$("#spanyucunYE_title").text("<fmt:message key="phone.getinternet0148" />");
			//话费余额
			$("#phoneBalance").val(res[0][1]);
			$("#phoneBalance_to").val(res[0][1]);
			//如果不等于0说明有钱，要提示退费
			if(res[0][1]!="0"){
				$("#czyfee").val("YES");
			}
		}
		var str = res[0][0].substr(0,1);
		if(str=="-"){
			//$("#spanxinyueHF").text("实时欠费");
			$("#spanxinyueHF").text("<fmt:message key="phone.getinternet0150" />");
			$("#mothshuafei").val(res[0][0].substr(1,res[0][0].length));
			$("#sshfee").val("NO");
		}else{
			//$("#spanxinyueHF").text("实时余额");
			$("#spanxinyueHF").text("<fmt:message key="phone.getinternet0151" />");
			$("#mothshuafei").val(res[0][0]);
			$("#sshfee").val("YES");
		}
	}
				
		/*******
	   	* 取合同号档信息
	   	* @param:电话hth合同号;
	   	* @return;
	  	********/
		function ghSerBasicInfoHth(Hth)
		{
			var urlstr=tsd.buildParams({packgname:'service',//java包
										clsname:'ExecuteSql',//类名
										method:'exeSqlData',//方法名
										ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdcf:'mssql',//指向配置文件名称
										tsdoper:'query',//操作类型 
										datatype:'xmlattr',//返回数据格式 
										tsdpk:'PhonemoveAddress.dhBasicInfoHthdang'
										});
			var params = "&Hth=" + Hth;			
			$.ajax({
				url:"mainServlet.html?"+urlstr+params,
				cache:false,				
				success:function(xml){
					$(xml).find("row").each(function(){
						if($(this).attr("hth")==""||$(this).attr("hth")==undefined){
							//alert("没有该条件查询的大客户！");
							alert("<fmt:message key="phone.getinternet0235" />");
							return;
						}
						//合同号
						$("#Hth_hthdang").val($(this).attr("hth")==undefined?"":$(this).attr("hth"));
						//电话
						$("#Dh_hthdang").val($(this).attr("dh")==undefined?"":$(this).attr("dh"));
						//合同号
						$("#Yhmc_hthdang").val($(this).attr("yhmc")==undefined?"":$(this).attr("yhmc"));
						//用户类型
						$("#Yhlb_hthdang").val($(this).attr("yhlb")==undefined?"":$(this).attr("yhlb"));
						$("#usertype").val($(this).attr("yhlb")==undefined?"":$(this).attr("yhlb"));			
						//getyhlbisnull($(this).attr("yhlb"),$(this).attr("yhxz"));	
						getuyhxz();	
						//用户性质
						$("#Yhxz_hthdang").val($(this).attr("yhxz")==undefined?"":$(this).attr("yhxz"));			
						//付费策略
						$("#CallPayType_hthdang").val($(this).attr("callpaytype")==undefined?"":$(this).attr("callpaytype"));						
						//收费地点
						$("#Area_hthdang").val($(this).attr("area")==undefined?"":$(this).attr("area"));						
						//滞纳金标志
						$("#ZnjBz_hthdang").val($(this).attr("znjbz")==undefined?"":$(this).attr("znjbz"));
						//补贴类别
						$("#HthMfjb_hthdang").val($(this).attr("hthmfjb")==undefined?"":$(this).attr("hthmfjb"));
						//身份证号
						$("#IDCard_hthdang").val($(this).attr("idcard")==undefined?"":$(this).attr("idcard"));
						//部门1
						$("#sBm1").val($(this).attr("bm1")==undefined?"":$(this).attr("bm1"));
						//部门2
						$("#sBm2").val($(this).attr("bm2")==undefined?"":$(this).attr("bm2"));
						//部门3
						$("#sBm3").val($(this).attr("bm3")==undefined?"":$(this).attr("bm3"));
						//部门4
						$("#sBm4").val($(this).attr("bm4")==undefined?"":$(this).attr("bm4"));		
						$("#Boss_Name_hthdang").val($(this).attr("boss_name")==undefined?"":$(this).attr("boss_name"));//法人代表		
						$("#CompType_hthdang").val($(this).attr("comptype")==undefined?"":$(this).attr("comptype"));//单位类型
						$("#CreditGrade_hthdang").val($(this).attr("creditgrade")==undefined?"":$(this).attr("creditgrade"));//信誉等级	
						$("#CreditPoint_hthdang").val($(this).attr("creditpoint")==undefined?"":$(this).attr("creditpoint"));//信誉积分
						$("#CustType_hthdang").val($(this).attr("custtype")==undefined?"":$(this).attr("custtype"));//客户类型
						$("#Email_hthdang").val($(this).attr("email")==undefined?"":$(this).attr("email"));//邮件地址	
						$("#FixCode_hthdang").val($(this).attr("fixcode")==undefined?"":$(this).attr("fixcode"));//传真	
						$("#HomePage_hthdang").val($(this).attr("homepage")==undefined?"":$(this).attr("homepage"));//主页
						$("#linkTel_hthdang").val($(this).attr("linktel")==undefined?"":$(this).attr("linktel"));//联系电话			
						$("#Manageid_hthdang").val($(this).attr("manageid")==undefined?"":$(this).attr("manageid"));//营业执照
						$("#TradeType_hthdang").val($(this).attr("tradetype")==undefined?"":$(this).attr("tradetype"));//行业类型
						$("#Yhdz_hthdang").val($(this).attr("yhdz")==undefined?"":$(this).attr("yhdz"));//用户地址
						$("#Sflx_hthdang").val($(this).attr("sflx")==undefined?"":$(this).attr("sflx"));//用户地址						
			 	        $("#Bz2_hthdang").val($(this).attr("bz2")==undefined?"":$(this).attr("bz2")=="Y"?"<fmt:message key="phone.getinternet0354" />":"<fmt:message key="phone.getinternet0355" />");//是否大客户代收									
					});
				}
			});
		}
		
		function getuyhxz(){
			var select = document.getElementById("yhxz_hidden");
				var array;
				$("#Yhxz_hthdang").empty();
				$("#UserType_yhdang").empty();
				$("#Yhxz_hthdang").html($("#Yhxz_hthdang").html()+"<option value='' selected='true'>--<fmt:message key="phone.getinternet0280" />--</option>");
				$("#UserType_yhdang").html($("#UserType_yhdang").html()+"<option value='' selected='true'>--<fmt:message key="phone.getinternet0280" />--</option>");
				for(var i=1;i<=select.options.length;i++){
					var op=document.createElement("option");
					if(i<select.options.length){								
						if(select.options[i].lvalue==""||select.options[i].lvalue==undefined){
							select.options[i].lvalue="";
						}       
	  					op.value = select.options[i].lvalue;
	  					if(op.value=="undefined"||op.value==undefined||op.value==""){
	
	  					}else{
	  						array = op.value.split("|");					  						
	  						if(array[2]==$("#usertype").val()){
	  							$("#Yhxz_hthdang").html($("#Yhxz_hthdang").html()+"<option value="+array[0]+">"+array[0]+"</option>");
	  							$("#UserType_yhdang").html($("#UserType_yhdang").html()+"<option value="+array[1]+">"+array[0]+"</option>");
	  						}
	  					} 
	  				}	 					
				}
		}
		
		
		/*******
	   	* 查询判断用户类别是否在用户类别表中，否这自动添加到select中显示
	   	* @param:yhlb用户类别，yhxz用户性质;
	   	* @return;
	  	********/
		function getyhlbisnull(yhlb,yhxz){
			var res = fetchMultiArrayValue("query.yhlbisnull",6,"&yhlb="+tsd.encodeURIComponent(yhlb)+"&yhxz="+tsd.encodeURIComponent(yhxz));
			if(res[0]==undefined ||res[0][0]==undefined)
			{
				return false;
			}else if(res[0][0]=='0'){
				var querysel ="<option value='"+yhxz+"'>"+yhxz+"</option>";
				$("#Yhxz").append(querysel);			
			}			
		}

		/*******
	   	* 得到各类代缴合同号
	   	* @param:dh电话;
	   	* @return;
	  	********/
		function getdaijiaohth(dh){
			var urlstr=tsd.buildParams({packgname:'service',//java包
										clsname:'ExecuteSql',//类名
										method:'exeSqlData',//方法名
										ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdcf:'mssql',//指向配置文件名称
										tsdoper:'query',//操作类型 
										datatype:'xmlattr',//返回数据格式 
										tsdpk:'phonemodifypropertie.getdaijiaohth'
										});
			var params = "&dh=" + dh;
			$.ajax({
				url:"mainServlet.html?"+urlstr+params,
				cache:false,
				success:function(xml){
					$(xml).find("row").each(function(){
						//市话合同号
						$("#shhth").val($(this).attr("shhth")==undefined?"":$(this).attr("shhth"));						
						//本地合同号
						$("#bdhth").val($(this).attr("bdhth")==undefined?"":$(this).attr("bdhth"));						
						//长途合同号
						$("#cthth").val($(this).attr("cthth")==undefined?"":$(this).attr("cthth"));
						//IP长途合同号
						$("#iphth").val($(this).attr("iphth")==undefined?"":$(this).attr("iphth"));
						//信息台
						$("#xxthth").val($(this).attr("xxthth")==undefined?"":$(this).attr("xxthth"));
						//
						$("#swhth").val($(this).attr("swhth")==undefined?"":$(this).attr("swhth"));
						//月租合同号
						$("#yzhth").val($(this).attr("yzhth")==undefined?"":$(this).attr("yzhth"));
						//新业务合同号
						$("#xywhth").val($(this).attr("xywhth")==undefined?"":$(this).attr("xywhth"));
					});
				}
			});
		}
			
       jQuery(document).ready(function()
	   {	 	   			  				   
		    $("#navBar").append(genNavv());		    
		    $("#setHth1").attr("disabled","disabled");
		    $("#setHth2").attr("disabled","disabled");
		    $("#setHth3").attr("disabled","disabled");
		    $("#setHth4").attr("disabled","disabled");
		    $("#QKHth").attr("disabled","disabled");
		    //$("#dhzfform tr td:even").css({"text-align":"right"});		
		    $("#dhzfform :select").css("margin-left","10px");    		  
		    //PageInitial();  
		    $("#ghSearchBox").focus();
		    //ghPayMoney('修改属性');
		    $("#ghSearchBox").select();
		    $("#ghSearchBox").focus();			
		    il18nDWDJ();	   			  
	     	///电话杂费  终止日
			$("#ZFEndday").focus(function(){
				WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
			});		
		    if(getaddressEditer()=="NO"){
				    $("#Yhdz_yhdang").focus(function(){c_p_address_fun();});
					$("#Yhdz_yhdang").keyup(function(){notecheck();});
			}			
			changemodiftype();
			setTimeout("getchageyhlb()",800);
	   }); 	   	 
	   
	   function getchageyhlb(){
	   		$("#Yhlb_hthdang").change(function(){
				$("#usertype").val($("#Yhlb_hthdang :selected").text());	
				getUserProper();
			});
	   } 
	   
	   function pageselect(){	   	    
		    gettable();//默认加载固定费表格现实phone_kibq_gh.js函数中	
			hthCollection();				
			$("#Yhlb_hthdang").change(function(){
					var flf = $("#Yhlb option:selected").attr("flff");
					if(flf==undefined||flf=="undefined"||flf==""){
							
					}else{
							//getUserProper();
							//getUserProper_yhdang();
					}
			});
	   }
	   
    </script>
		<script language="javascript">                        
        /*******
	   	* 设置代缴合同号
	   	* @param;
	   	* @return;
	  	********/
        function setDJHTH()
        {
        	if($("#Dh_yhdang").val()=="")
        	{
        		//alert("请选择要办理该项业务的电话号码");
				alert("<fmt:message key="phone.getinternet0176" />");
        		$("#ghSearchBox").select().focus();
        		return false;
        	}
        	//用户类别
        	var cusertype = $("#Yhlb_hthdang").val();
        	if(cusertype=="" || cusertype==undefined)
        	{
        		//alert("请选择用户类别");
        		alert("<fmt:message key="phone.getselectyhlb" />");
        		$("#Yhlb_hthdang").select();
        		$("#Yhlb_hthdang").focus();
        		return false;
        	}
        	getPayment();//生成代缴费用信息
        	//私费
        	setXDJ('');
        }
        
        /*******
	   	* 设置单位合同号
	   	* @param;
	   	* @return;
	  	********/
        function setDJ()
        {
        	$("#setdaijiao").val("Y");
        	DisplayHthForm();
        }
        
        /*******
	   	* 设置代缴合同号
	   	* @param;
	   	* @return;
	  	********/
        function setXDJ_to()
        {        
        	//第一次打开面板时清空输入框
        	if($("#currentHthFirstOpen").val()=="Y")
        	{
        		$("#daijiaoinput input").val("");
        		$("#currentHthFirstOpen").val("N");
        	}
        	
        	$("#daijiaoinput input").click(function(){
        		//记录选中的合同号输入框的ID
        		//alert($(this).attr("id"));
        		$("#currentCheckedHthBox").val($(this).attr("id"));
        	});
        	
        	$("#dqueryHTHdw").empty();//每次查询前将以前的数据清空        	
        	getdaijiaohth($("#Dh_yhdang").val());//得到代缴合同好信息
        	autoBlockForm('dhthChooseForm',5,'dhthChooseFormReset',"#ffffff",false);//弹出查询框
            var res = fetchMultiArrayValue("phonelnstalled.isnotdanweiHTH",6,"");
            var ify="";
            ify += "<thead><tr><th width=\"200\"><center><h4><fmt:message key="phoneyewu.dwHTH" /></h4></center></th><th width=\"400\"><center><h4><fmt:message key="phone.getinternet0357" /></h4></center></th></tr></thead>";
            for(var i=0;i<res.length;i++){
                ify +="<tbody>";
                ify += "<tr id=\""+res[i][0]+"\">";					
				ify += "<td style=\"width: 200px;height: 20px\"><center>";
				ify += res[i][0];
				ify += "</center></td>";
				ify += "<td width=\"400\"><center>";
				ify += res[i][1];
				ify += "</center></td>";
				ify +="</tr>";
				ify +="</tbody>";
            }
            $("#dqueryHTHdw").append(ify);
            //jQuery.page("page1",5);
            
            $("#dqueryHTHdw tr").click(function(){
            	if($(this).html().toLowerCase().indexOf("<th")>-1)
            	{
            		return false;
            	}
            	$("#dqueryHTHdw tr").removeClass("selected");
            	
            	var did = $("#currentCheckedHthBox").val();        	
        		if(did!="")
        		{
        			$("#"+did).val($(this).attr("id"));
        		}
        		$(this).addClass("selected");
            });
            
            $("#dhthChooseFormSave").click(function(){
            	$("#currentHthSaved").val("Y")
            	setTimeout($.unblockUI,10);
            });
            
            $("#dhthChooseFormReset").click(function(){
            	$("#currentHthSaved").val("N")
            });
        }
              
       /*******
	   	* 生成并显示合同号面板
	   	* @param;
	   	* @return;
	  	********/
        function DisplayHthForm()
        {
        	$("#queryHTHdw").empty();//每次查询前将以前的数据清空
        	autoBlockForm('hthChooseForm',5,'close',"#ffffff",false);//弹出查询框
            var res = fetchMultiArrayValue("phonelnstalled.isnotdanweiHTH",6,"");
            var ify="";
            ify += "<thead><tr><th width=\"200\"><center><h4><fmt:message key="phoneyewu.dwHTH" /></h4></center></th><th width=\"400\"><center><h4><fmt:message key="phone.getinternet0357" /></h4></center></th></tr></thead>";
            for(var i=0;i<res.length;i++){
                ify += "<tbody>";
                ify += "<tr onClick=\"getHTHdanwei('"+res[i][0]+"')\" onDblClick=\"getinputHTH('"+res[i][0]+"')\" id=\""+res[i][0]+"\">";					
				ify += "<td style=\"width: 200px;height: 20px\"><center>";
				ify += res[i][0];
				ify += "</center></td>";
				ify += "<td width=\"400\"><center>";
				ify += res[i][1];
				ify += "</center></td>";
				ify +="</tr>";
				ify +="</tbody>";
            }
            $("#queryHTHdw").append(ify);
            //jQuery.page("page",5);
        }
                
        /*******
	   	* 得到弹出单位合同号信息选择后的合同号
	   	* @param:params合同号值;
	   	* @return;
	  	********/
		function getHTHdanwei(params)
		{
		      var inputDWHTH = params; 
		      $("#inputDWHTH").val(inputDWHTH);//把得到的单位合同号添加到隐藏域中点击确定的时候在从隐藏域中取
		      $("#queryHTHdw tr").css('background-color','#ffffff');
		      document.getElementById(params).style.background='#00ffff';
		 }
		 		
		/*******
	   	* 点击弹出合同号狂窗口保存
	   	* @param:inputDWHTH合同号值;
	   	* @return;
	  	********/
		function getinputHTH(inputDWHTH)
		{
		     var inputDWHTH = $("#inputDWHTH").val();//从隐藏域中得到单位合同号付给页面显示
		     $("#queryHTHdw tr").css('background-color','#ffffff');		     
		     if($("#setdaijiao").val()=="Y")
		     {//代缴合同号
		     	$("#gfhth").val(inputDWHTH);
		     }
		     $("#inputDWHTH").val("");//获取后将隐藏域中的清空		     
		     setTimeout($.unblockUI,15);
		}
		
		/*******
	   	* 关闭面板清空代缴
	   	* @param:inputDWHTH合同号值;
	   	* @return;
	  	********/
		function closeGB()
		{
		   setTimeout($.unblockUI,15);
		   $("#queryHTHdw tr").css('background-color','#ffffff');		   
		   $("#inputDWHTH").val("");//将隐藏域中的清空			   
			if($("#setdaijiao").val()=="Y")
		    {//代缴合同号
		    	$("#gfhth").val("");
		    }
		}
				
		/*******
	   	* 查看是否选择单位合同号，如果选择者弹出窗口显示单位同好和单位名称进行选择
	   	* @param;
	   	* @return;
	  	********/
        function isnotdanwei()
        {
            $("#setdaijiao").val("N");
            $("#danweiHTHbox").attr("checked","checked");
            var danweiHTHbox = $("#danweiHTHbox").attr("checked");//查看是否被选择
            if(danweiHTHbox==true){
            DisplayHthForm();
            }else{
               $("#danweiHTHbox").attr("checked","");
               $("#danweiHTH").val("");
               $("#inputDWHTH").val("");//将隐藏域中的清空	
            }            
        }
       
       
		function il18nDWDJ()
		{
			var i18n = fetchFieldAlias("daijiao","zh");
			$("#span_shhth").text(i18n["shhth"]);
			$("#span_bdhth").text(i18n["bdhth"]);
			$("#span_cthth").text(i18n["cthth"]);
			$("#span_iphth").text(i18n["iphth"]);
			$("#span_xxthth").text(i18n["xxthth"]);
			$("#span_swhth").text(i18n["swhth"]);
			$("#span_yzhth").text(i18n["yzhth"]);
			$("#span_xywhth").text(i18n["xywhth"]);
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
	   	   
	   /*******
	   	* 转存临时数据
	   	* @param:Dh电话;
	   	* @return;
	  	********/
	   function TransTmpData(Dh)
	   {
	   		var userid = tsd.encodeURIComponent($("#userid").val());	   		
	   		executeNoQueryProc("PhoneService.TranTmp",6,"&userid=" + userid + "&dh=" + tsd.encodeURIComponent(Dh));
	   }
	   
	   function ClearTmpData()
	   {
	   		var userid = tsd.encodeURIComponent($("#userid").val());	   		
	   		executeNoQueryProc("PhoneService.POPEN",6,"&userid=" + userid);
	   }
	   
		/*******
		* 从真实姓名对应的多个账户中选择要缴费的账户
		* @param:Yhmc用户名称，Dh电话，Yhdz用户地址;
		* @return;
		********/
		function userChoose(Yhmc,Dh,Yhdz)
		{
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
			$("#Dh_yhdang").val(Dh);
			$("#Yhdz_yhdang").val(Yhdz);
			$("#Yhmc_yhdang").val(Yhmc);	
			///根据电话获取用户信息
			ghSerBasicInfo(Dh);
			getPowerfalse();//判断权附值									
			gethTC(Dh);
			TransTmpData(Dh);
			addspeediFeeType(Dh);
			//缓存用户信息
			_user_dhXGXX_ = false;
			setTimeout("saveTmpUserInfo()",2000);
			getphonefeename();//固话杂费	
			$("#Hth_hthdang").attr("disabled","disabled");
		    $("#Dh_hthdang").attr("disabled","disabled");
		    $("#Hth_yhdang").attr("disabled","disabled");
		    $("#Dh_yhdang").attr("disabled","disabled");
		    $("#phoneBalance").attr("disabled","disabled");
		    $("#mothshuafei").attr("disabled","disabled");
		    // Added by zhumengfeng at 2016/06/08
		    // begin
		    $("#Dhgn_yhdang").attr("disabled", "disabled");
		    $("#YwArea_yhdang").attr("disabled", "disabled");
		    $("#StartDate_yhdang").attr("disabled", "disabled");
		    $("#EndDate_yhdang").attr("disabled", "disabled");
		    // end
		    
			setTimeout($.unblockUI,1);
		}
		
		/*******
		* 修改属性保存前拼接参数
		* @param;
		* @return;
		********/
		function saveTmpUserInfo()
		{
			var tmp = new Object();
			var hthyhmc = $("#Yhmc_hthdang").val();
			tmp["hthyhmc"]=hthyhmc;
			var hthyhlb = $("#Yhlb_hthdang").val();
			tmp["hthyhlb"]=hthyhlb;
			var hthyhxz = $("#Yhxz_hthdang").val();			
			tmp["hthyhxz"]=hthyhxz;
			var hthsBm1 = $("#sBm1").val();
			tmp["hthsBm1"]=hthsBm1;
			var hthsBm2 = $("#sBm2").val();
			tmp["hthsBm2"]=hthsBm2;
			var hthsBm3 = $("#sBm3").val();
			tmp["hthsBm3"]=hthsBm3;
			var hthsBm4 = $("#sBm4").val();
			tmp["hthsBm4"]=hthsBm4;
			var hthyhdz = $("#Yhdz_hthdang").val();
			tmp["hthyhdz"]=hthyhdz;
			var hthBz2 = $("#Bz2_hthdang").val();			
			tmp["hthBz2"]=hthBz2;
			var hthCallPayType = $("#CallPayType_hthdang").val();
			tmp["hthCallPayType"]=hthCallPayType;			
			var hthZnjBz = $("#ZnjBz_hthdang").val();
			tmp["hthZnjBz"]=hthZnjBz;			
			var hthArea = $("#Area_hthdang").val();
			tmp["hthArea"]=hthArea;			
			var hthlinkTel = $("#linkTel_hthdang").val();
			tmp["hthlinkTel"]=hthlinkTel;			
			var hthCustType = $("#CustType_hthdang").val();
			tmp["hthCustType"]=hthCustType;			
			var hthCreditPoint = $("#CreditPoint_hthdang").val();
			tmp["hthCreditPoint"]=hthCreditPoint;			
			var hthIDCard = $("#IDCard_hthdang").val();
			tmp["hthIDCard"]=hthIDCard;
						
			var address = $("#Yhdz_yhdang").val();
			tmp["address"]=address;
			var yhdangYhmc = $("#Yhmc_yhdang").val();
			tmp["yhdangYhmc"]=yhdangYhmc;
			var yhmc = $("#Yhmc_yhdang").val();
			tmp["yhmc"]=yhmc;		
			var bm1 = $("#Bm1_yhdang").val();
			tmp["bm1"]=bm1;
			var bm2 = $("#Bm2_yhdang").val();
			tmp["bm2"]=bm2;
			var bm3 = $("#Bm3_yhdang").val();			
			tmp["bm3"]=bm3;
			var bm4 = $("#Bm4_yhdang").val();			
			tmp["bm4"]=bm4;		
			var mima = $("#Mima_yhdang").val();
			tmp["mima"]=mima;		
			var zjlx = $("#Bz6_yhdang").val();
			tmp["zjlx"]=zjlx;		
			var zjhm = $("#Bz7_yhdang").val();
			tmp["zjhm"]=zjhm;		
			var lxr = $("#Bz8_yhdang").val();
			tmp["lxr"]=lxr;		
			var lxdh = $("#Bz9_yhdang").val();
			tmp["lxdh"]=lxdh;			
			var AdjustSheduleNo = $("#AdjustSheduleNo_yhdang").val();
			tmp["AdjustSheduleNo"]=AdjustSheduleNo;
			var CallSheduleNo = $("#CallSheduleNo_yhdang").val();
			tmp["CallSheduleNo"]=CallSheduleNo;			
			var Dhgn = $("#Dhgn_yhdang").val();
			tmp["Dhgn"]=Dhgn;			
			var MokuaiJu = $("#MokuaiJu_yhdang").val();
			tmp["MokuaiJu"]=MokuaiJu;
			var YwArea = $("#YwArea_yhdang").val();
			tmp["YwArea"]=YwArea;			
			var Reg_Date = $("#Reg_Date_yhdang").val();
			tmp["Reg_Date"]=Reg_Date;			
			var CreditPoint = $("#CreditPoint_yhdang").val();
			tmp["CreditPoint"]=CreditPoint;			
			var CustType = $("#CustType_yhdang").val();
			tmp["CustType"]=CustType;
			var UserType = $("#UserType_yhdang").val();
			tmp["UserType"]=UserType;
			_user_dhXGXX_ = tmp;
		}
				
		/*******
		* 执行修改属性调用过程修改操作
		* @param;
		* @return;
		********/
		function modifyProperties()
		{
			///////////////////////////////////////////////////////////////////
        	tsd.QualifiedVal=true;
        	var procparams = "";
        	//电话号码
        	var cphonenum = $("#Dh_yhdang").val();
        	if(cphonenum!=undefined&&$("#modiftype").val()=='dh'){
	        	cphonenum=cphonenum.replace(/(^\s*)|(\s*$)/g,"");
	        	if(cphonenum==""){								    
				    alert("<fmt:message key="phone.getinternet0140" />");
				    $("#ghSearchBox").select();
				    $("#ghSearchBox").focus();
				    return false;
				}
			}
			if($("#modiftype").val()!='dh'&&$("#dkhhth").val()==""){
				//alert("请查询大客户号");
				alert("<fmt:message key="phone.getinternet0170" />");
				$("#dkhhth").select();
				$("#dkhhth").focus();
				return;
			}
			var languageType = $("#languageType").val(); 
		    var Dat = loadData_phoneinstalled("Hthdang",languageType,2);
		    var reszh = fetchFieldAlias('Hthdang',languageType);			 
			 for(var i=0;i<Dat.FieldName.length;i++){
			 	var strhth = $("#"+Dat.FieldName[i]+"_hthdang").val();
			 	if(strhth!=undefined){
			 		strhth = strhth.replace(/(^\s*)|(\s*$)/g,"");
			        	if(strhth==""&&Judgefield_hthdang(Dat.FieldName[i]+"_hthdang")==true&&$("#"+Dat.FieldName[i]+"_hthdang").attr("disabled")!=true)
			        	{
			        		//alert("合同号信息中["+reszh[Dat.FieldName[i]]+"]不能为空!");
			        		alert("<fmt:message key="phone.getinternet0026" />"+reszh[Dat.FieldName[i]]+"<fmt:message key="phone.getinternet0027" />");
			        		$("#"+Dat.FieldName[i]+"_hthdang").select();
			        		$("#"+Dat.FieldName[i]+"_hthdang").focus();
			        		return false;
			        		break;
			        	}
		        	}
		        if(strhth==null){strhth="";}	
			 	procparams += "&"+Dat.FieldName[i]+"hth="+tsd.encodeURIComponent(strhth);
			 }
					var Email = $("#Email_hthdang").val();//邮件地址  
					if(Email!=undefined){
			        	Email=Email.replace(/(^\s*)|(\s*$)/g,"");
						var emailRegExp = new RegExp("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
						if ((!emailRegExp.test(Email)||Email.indexOf('.')==-1)&&Email!=""&&$("#Email_hthdang").attr("disabled")!=true){
							//alert("合同号信息中邮件格式不正确！！！");
							alert("<fmt:message key="phone.getinternet0029" />");
							$("#Email_hthdang").select();
							$("#Email_hthdang").focus();
							return false;
						}
					}
					var IDCard = $("#IDCard_hthdang").val();		        	
		        	if(IDCard!=undefined){
			        	IDCard=IDCard.replace(/(^\s*)|(\s*$)/g,"");
			        	if(IDCard!=""&&!/((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65)[0-9]{4})(([1|2][0-9]{3}[0|1][0-9][0-3][0-9][0-9]{3}[X0-9])|([0-9]{2}[0|1][0-9][0-3][0-9][0-9]{3}))$/.test(IDCard)&&$("#IDCard_hthdang").attr("disabled")!=true)
		        		{
			        		//alert("合同号信息中请输入正确的身份证号码");
			        		alert("<fmt:message key="phone.getinternet0030" />");
			        		$("#IDCard_hthdang").select();
			        		$("#IDCard_hthdang").focus();
			        		return false;
		        		}
		        	}
		        
		        //判断是只修改大客户信息还是电话信息
		        var modiftype = $("#modiftype").val();
		        if(modiftype=="dh"){	
					 var Dat = loadData_phoneinstalled("Yhdang",languageType,2);
					 var reszh = fetchFieldAlias('Yhdang',languageType);
					 for(var i=0;i<Dat.FieldName.length;i++){
					 	var stryhdang = $("#"+Dat.FieldName[i]+"_yhdang").val();
					 	if(stryhdang!=undefined){
					 		stryhdang = stryhdang.replace(/(^\s*)|(\s*$)/g,"");
					        	if(stryhdang==""&&Judgefield_yhdang(Dat.FieldName[i]+"_yhdang")==true&&$("#"+Dat.FieldName[i]+"_yhdang").attr("disabled")!=true)
					        	{
					        		//alert("用户档信息中["+reszh[Dat.FieldName[i]]+"]不能为空!");
					        		alert("<fmt:message key="phone.getinternet0031" />"+reszh[Dat.FieldName[i]]+"<fmt:message key="phone.getinternet0027" />");
					        		$("#"+Dat.FieldName[i]+"_yhdang").select();
					        		$("#"+Dat.FieldName[i]+"_yhdang").focus();
					        		return false;
					        		break;
					        	}
				        	}
				        if(stryhdang==null){stryhdang="";}		
					 	procparams += "&"+Dat.FieldName[i]+"yhdang="+tsd.encodeURIComponent(stryhdang);
					 }
					 var cDocumentsNumber = $("#Bz7_yhdang").val();
		        	 if(cDocumentsNumber!=undefined){
				        	cDocumentsNumber=cDocumentsNumber.replace(/(^\s*)|(\s*$)/g,"");
				        	if($("#Bz6_yhdang").val()=="<fmt:message key="phone.getinternet0345" />" && cDocumentsNumber!="" && !/((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65)[0-9]{4})(([1|2][0-9]{3}[0|1][0-9][0-3][0-9][0-9]{3}[X0-9])|([0-9]{2}[0|1][0-9][0-3][0-9][0-9]{3}))$/.test(cDocumentsNumber)&&$("#Bz7_yhdang").attr("disabled")!=true)
				        	{
				        		//alert("固话信息中请输入正确的身份证号码");
				        		alert("<fmt:message key="phone.getinternet0032" />");
				        		$("#Bz7_yhdang").select();
				        		$("#Bz7_yhdang").focus();
				        		return false;
				        	}
				     }
			     }
				//一级部门
	        	var csbm1 = $("#sBm1").val();
	        	if($("#usertype")=="<fmt:message key="phone.getinternet0384" />"&&$("#sBm1").val()=="")
	        	{
	        		//alert("当前用户类别为公费，请选择一级部门");
	        		alert("<fmt:message key="phone.getinternet0033" />");
	        		return false;
	        	}
	        	
	        	procparams += "&modiftype=";
				procparams += tsd.encodeURIComponent(modiftype);	
	        	
	        	procparams += "&Tjbzyhdang=";
	        	procparams += tsd.encodeURIComponent($("#Tjbz_yhdang").val());
	        	procparams += "&csbm1=";
	        	procparams += tsd.encodeURIComponent(csbm1);
	        	//二级部门
	        	var csbm2 = $("#sBm2").val();
	        	procparams += "&csbm2=";
				procparams += tsd.encodeURIComponent(csbm2);						
	        	//三级部门        	
	        	var csbm3 = $("#sBm3").val();
	        	procparams += "&csbm3=";
				procparams += tsd.encodeURIComponent(csbm3);	
	        	//四级部门        	
	        	var csbm4 = $("#sBm4").val();
	        	procparams += "&csbm4=";
				procparams += tsd.encodeURIComponent(csbm4);
				//备注
	        	var tBZZZ = $("#remark").val();
	        	procparams += "&zwbz=";
				procparams += tsd.encodeURIComponent(tBZZZ);	
				
				var Sflx_hthdang = $("#Sflx_hthdang").val();
				procparams += "&Sflxhth=";
				procparams += tsd.encodeURIComponent(Sflx_hthdang);						
				//工号
				var uuserid = $("#userid").val();
				procparams += "&uuserid=";
				procparams += tsd.encodeURIComponent(uuserid);
				//部门
				var udepart = $("#depart").val();
				procparams += "&udepart=";
				procparams += tsd.encodeURIComponent(udepart);
				var userareaid = $("#userareaid").val();
				procparams += "&userarea=";
				procparams += tsd.encodeURIComponent(userareaid);
				//区域营业厅
				var uarea = $("#area").val();
				procparams += "&uarea=";
				procparams += tsd.encodeURIComponent(uarea);
				//////////////////////////////////////////////////
				var loginfo = "";
					loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0396" />："+uuserid+")");
					loginfo += tsd.encodeURIComponent("<fmt:message key="phone.getinternet0423" />:");//表
					loginfo += "yhdang";
					loginfo += tsd.encodeURIComponent($('#ghSearchWay option:selected').text()+":");
					loginfo += $("#ghSearchBox").val();
					loginfo += tsd.encodeURIComponent("<fmt:message key="phone.getinternet0424" />：");//的相关信息
					////修改前的数据									
					var hthyhmc=_user_dhXGXX_["hthyhmc"];					
					var hthyhlb=_user_dhXGXX_["hthyhlb"];
					var hthyhxz=_user_dhXGXX_["hthyhxz"];
					var hthsBm1=_user_dhXGXX_["hthsBm1"];
					var hthsBm2=_user_dhXGXX_["hthsBm2"];
					var hthsBm3=_user_dhXGXX_["hthsBm3"];
					var hthsBm4=_user_dhXGXX_["hthsBm4"];
					var hthyhdz=_user_dhXGXX_["hthyhdz"];
					var hthBz2=_user_dhXGXX_["hthBz2"];
					var hthCallPayType=_user_dhXGXX_["hthCallPayType"];
					var hthZnjBz=_user_dhXGXX_["hthZnjBz"];
					var hthArea=_user_dhXGXX_["hthArea"];
					var hthlinkTel=_user_dhXGXX_["hthlinkTel"];
					var hthCustType=_user_dhXGXX_["hthCustType"];
					var hthCreditPoint=_user_dhXGXX_["hthCreditPoint"];
					var hthIDCard=_user_dhXGXX_["hthIDCard"];
										
					var address=_user_dhXGXX_["address"];
					var yhdangYhmc=_user_dhXGXX_["yhdangYhmc"];
					var yhmc=_user_dhXGXX_["yhmc"];
					var bm1=_user_dhXGXX_["bm1"];
					var bm2=_user_dhXGXX_["bm2"];
					var bm3=_user_dhXGXX_["bm3"];
					var bm4=_user_dhXGXX_["bm4"];
					var mima=_user_dhXGXX_["mima"];
					var zjlx=_user_dhXGXX_["zjlx"];
					var zjhm=_user_dhXGXX_["zjhm"];
					var lxr=_user_dhXGXX_["lxr"];
					var lxdh=_user_dhXGXX_["lxdh"];
					var AdjustSheduleNo=_user_dhXGXX_["AdjustSheduleNo"];
					var CallSheduleNo=_user_dhXGXX_["CallSheduleNo"];
					var Dhgn=_user_dhXGXX_["Dhgn"];
					var MokuaiJu=_user_dhXGXX_["MokuaiJu"];
					var YwArea=_user_dhXGXX_["YwArea"];
					var Reg_Date=_user_dhXGXX_["Reg_Date"];
					var CreditPoint=_user_dhXGXX_["CreditPoint"];
					var CustType=_user_dhXGXX_["CustType"];
					var UserType=_user_dhXGXX_["UserType"];
					///修改后的数据
					var hthyhmc1 = $("#Yhmc_hthdang").val();
					var hthyhlb1 = $("#Yhlb_hthdang").val();
					var hthyhxz1 = $("#Yhxz_hthdang").val();			
					var hthsBm11 = $("#sBm1").val();
					var hthsBm21 = $("#sBm2").val();
					var hthsBm31 = $("#sBm3").val();
					var hthsBm41 = $("#sBm4").val();
					var hthyhdz1 = $("#Yhdz_hthdang").val();
					var hthBz21 = $("#Bz2_hthdang").val();
					var hthCallPayType1 = $("#CallPayType_hthdang").val();	
					var hthZnjBz1 = $("#ZnjBz_hthdang").val();
					var hthArea1 = $("#Area_hthdang").val();
					var hthlinkTel1 = $("#linkTel_hthdang").val();
					var hthCustType1 = $("#CustType_hthdang").val();
					var hthCreditPoint1 = $("#CreditPoint_hthdang").val();
					var hthIDCard1 = $("#IDCard_hthdang").val();
					var address1 = $("#Yhdz_yhdang").val();
					var yhdangYhmc1 = $("#Yhmc_yhdang").val();
					var yhmc1 = $("#Yhmc_yhdang").val();	
					var bm11 = $("#Bm1_yhdang").val();
					var bm21 = $("#Bm2_yhdang").val();
					var bm31 = $("#Bm3_yhdang").val();			
					var bm41 = $("#Bm4_yhdang").val();				
					var mima1 = $("#Mima_yhdang").val();		
					var zjlx1 = $("#Bz6_yhdang").val();	
					var zjhm1 = $("#Bz7_yhdang").val();	
					var lxr1 = $("#Bz8_yhdang").val();
					var lxdh1 = $("#Bz9_yhdang").val();			
					var AdjustSheduleNo1 = $("#AdjustSheduleNo_yhdang").val();
					var CallSheduleNo1 = $("#CallSheduleNo_yhdang").val();		
					var Dhgn1 = $("#Dhgn_yhdang").val();		
					var MokuaiJu1 = $("#MokuaiJu_yhdang").val();
					var YwArea1 = $("#YwArea_yhdang").val();		
					var Reg_Date1 = $("#Reg_Date_yhdang").val();			
					var CreditPoint1 = $("#CreditPoint_yhdang").val();	
					var CustType1 = $("#CustType_yhdang").val();
					var UserType1 = $("#UserType_yhdang").val();							
				if(hthyhmc!=hthyhmc1){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0112" />:"+hthyhmc+"～"+hthyhmc1+")");}				
				if(hthyhlb!=hthyhlb1){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0074" />:"+hthyhlb+"～"+hthyhlb+")");}				
				if(hthsBm1!=hthsBm11){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0471" />:"+hthsBm1+"～"+hthsBm11+")");}//合同号1级部门
				if(hthsBm2!=hthsBm21){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0472" />:"+hthsBm2+"～"+hthsBm21+")");}	//合同号2级部门
				if(hthsBm3!=hthsBm31){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0473" />:"+hthsBm3+"～"+hthsBm31+")");}	//合同号3级部门
				if(hthsBm4!=hthsBm41){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0474" />:"+hthsBm4+"～"+hthsBm41+")");}//合同号4级部门
				if(hthyhdz!=hthyhdz1){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0475" />:"+hthyhdz+"～"+hthyhdz1+")");}//合同号用户地址
				if(hthBz2!=hthBz21){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0476" />:"+hthBz2+"～"+hthBz21+")");}//是否大客户代缴
				if(hthCallPayType!=hthCallPayType1){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0477" />:"+hthCallPayType+"～"+hthCallPayType1+")");}	//合同号付费策略		
				if(hthZnjBz1!=hthZnjBz){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0478" />:"+hthZnjBz+"～"+hthZnjBz1+")");}//滞纳金标志
				if(hthArea1!=hthArea){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0479" />:"+hthArea+"～"+hthArea1+")");}	//收费地点									  
				if(hthlinkTel1!=hthlinkTel){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0480" />:"+hthlinkTel+"～"+hthlinkTel1+")");}	//合同号联系人电话			
				if(hthCustType1!=hthCustType){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0481" />:"+hthCustType+"～"+hthCustType1+")");}	//合同号客户类型					  				
				if(hthCreditPoint!=hthCreditPoint1){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0482" />:"+hthCreditPoint+"～"+hthCreditPoint1+")");}		//合同号信誉积分		
				if(hthIDCard1!=hthIDCard){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0483" />:"+hthIDCard+"～"+hthIDCard1+")");}	//合同号证件号码							
				if(address1!=address){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0113" />:"+address+"～"+address1+")");}//用户地址
				if(yhmc1!=yhmc){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0112" />:"+yhmc+"～"+yhmc1+")");}//用户名称
				if(bm11!=bm1){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0484" />:"+bm1+"～"+bm11+")");}//一级部门
				if(bm21!=bm2){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0485" />:"+bm2+"～"+bm21+")");}//二级部门
				if(bm31!=bm3){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0486" />:"+bm3+"～"+bm31+")");}//三级部门
				if(bm41!=bm4){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0487" />:"+bm4+"～"+bm41+")");}//四级部门
				if(mima1!=mima){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0488" />:"+mima+"～"+mima1+")");}//账号密码
				if(zjlx1!=zjlx){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0489" />:"+zjlx+"～"+zjlx1+")");}//证件类型
				if(zjhm!=zjhm1){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0490" />:"+zjhm+"～"+zjhm1+")");}//证件号码
				if(AdjustSheduleNo1!=AdjustSheduleNo){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0491" />:"+AdjustSheduleNo+"～"+AdjustSheduleNo1+")");}//调剂策略
				if(CallSheduleNo1!=CallSheduleNo){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0492" />:"+CallSheduleNo+"～"+CallSheduleNo1+")");}//催缴策略
				if(Dhgn1!=Dhgn){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0493" />:"+Dhgn+"～"+Dhgn1+")");}//电话功能
				if(MokuaiJu1!=MokuaiJu){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0494" />:"+MokuaiJu+"～"+MokuaiJu1+")");}//模块局
				if(YwArea1!=YwArea){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0495" />:"+YwArea+"～"+YwArea1+")");}//业务区域
				if(Reg_Date1!=Reg_Date){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0496" />:"+Reg_Date+"～"+Reg_Date1+")");}//装机日期
				if(CreditPoint1!=CreditPoint){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0497" />:"+CreditPoint+"～"+CreditPoint1+")");}//用户档信誉积分
				if(CustType1!=CustType){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0498" />:"+CustType+"～"+CustType1+")");}//用户档客户类型
				if(UserType1!=UserType){loginfo += tsd.encodeURIComponent("(<fmt:message key="phone.getinternet0499" />:"+UserType+"～"+UserType1+")");}//用户档用户类型
				//////////////////////////////////////////////////
				procparams+="&ywbz="+loginfo;
				if(tsd.Qualified()==false){return false;}
				//alert("你修改的内容只能保存到用户档案信息中，业务功能修改无法开启！");	
				alert("<fmt:message key="phone.getinternet0236" />");
					var result = fetchMultiPValue("PhoneModifyproperties.updateProperty",6,procparams);
					if(result[0]==undefined || result[0][0]==undefined || result[0][0]=='-1')
					{
						//alert("修改失败！");
						alert("<fmt:message key="phone.getinternet0237" />");
						$("#ghSearchBox").select();
	            		$("#ghSearchBox").focus();
					}
					else
					{
							var userid = $("#userid").val();						      
							  ///写入日志
							  writeLogInfo("","modify",loginfo);
							  clernull();							  
							  //alert("修改成功！");
							  alert("<fmt:message key="phone.getinternet0238" />");
					}
			}

        /*******
		 * 确认代缴合同号提示
		 * @param;
		 * @return;
	     ********/  
        function getdaijiaotishi(){
        	var languageType = $("#languageType").val();        		
				var resname = fetchFieldAlias('daijiao',languageType); 
            	var phone = $("#Dh_yhdang").val();            	
            	var strdj = "";
            	//strdj +="确认代缴：\n\n";
            	strdj +="<fmt:message key="phone.getinternet0043" />";
            	//strdj +="电话["+phone+"]的用户由:\n\n";
            	strdj +="<fmt:message key="phone.getinternet0044" />"+phone+"<fmt:message key="phone.getinternet0045" />";
            	for(var i=0;i<arrraydaijiaohth.length;i++){
            		if($("#"+arrraydaijiaohth[i]+"").val()!=""){            			         		
            			strdj +=resname[arrraydaijiaohth[i]]+"["+$("#"+arrraydaijiaohth[i]+"").val()+"<fmt:message key="phone.getinternet0046" />";
            		}
            	}
            	alert(strdj);
        }

        /*******
		 * 重置页面信息
		 * @param;
		 * @return;
	     ********/
		function clernull(){
			$("#setHth").attr("disabled","disabled");
			$("#tableyhdang select").attr("disabled","disabled");
			$("#tableyhdang :text").attr("disabled","disabled");
			$("#tablehthdang select").attr("disabled","disabled");
			$("#tablehthdang :text").attr("disabled","disabled");
			$("#ghSearchBox").val("");
			$("#geththsbm :text").val("");
			$("#dhzftab").empty();
			$("#dhBYTC").empty();
			document.getElementById('form1').reset();
			//套餐项
			$("#dhTCX").empty();
			$("#Bm1_yhdang").val("");
			$("#Bm1_yhdang").trigger("change");
			$("#gfhth").val("");
			$("#remark").val("");
			$("#phonefeetype").val("");
			$("#phonefeename").empty();
			gettable();
			unLockDh();
		}
		
		/*******
        *停机标志
        *@param
        *@return
        ********/ 
        function gettjbz()
        {
          $("#Tjbz_yhdang").empty();
          var querysel="<option value=''>--<fmt:message key="phone.getinternet0365" />--</option>";
			var res = fetchMultiArrayValue("FINAL.HwjbDef",6,"");
				if(res[0]==undefined || res[0][0]==undefined)
        		{
        			return false;
        		}
        	for(var i=0;i<res.length;i++){
        		querysel+="<option value="+res[i][0]+">"+res[i][1]+"</option>";
        	}	
        	$("#Tjbz_yhdang").append(querysel);
        }
		
		//判断数据权限是否可编辑
			function getPowerfalse(){
				if($("#Yhmcright").val()=="true"){
					$("#Yhmc_hthdang").removeAttr("disabled");
				}else{
					$("#Yhmc_hthdang").attr("disabled","disabled");
				}
				if($("#Yhxzright").val()=="true"){
					$("#Yhxz_hthdang").removeAttr("disabled");
					$("#Yhlb_hthdang").removeAttr("disabled");
				}else{
					$("#Yhxz_hthdang").attr("disabled","disabled");
					$("#Yhlb_hthdang").attr("disabled","disabled");
				}
				if($("#CallPayTyperight").val()=="true"){
					$("#CallPayType_hthdang").removeAttr("disabled");
				}else{
					$("#CallPayType_hthdang").attr("disabled","disabled");
				}
				if($("#ZnjBzright").val()=="true"){
					$("#ZnjBz_hthdang").removeAttr("disabled");
				}else{
					$("#ZnjBz_hthdang").attr("disabled","disabled");
				}
				if($("#CustTyperight").val()=="true"){
					$("#CustType_hthdang").removeAttr("disabled");
				}else{
					$("#CustType_hthdang").attr("disabled","disabled");
				}
				if($("#CreditGraderight").val()=="true"){
					$("#CreditGrade_hthdang").removeAttr("disabled");
				}else{
					$("#CreditGrade_hthdang").attr("disabled","disabled");
				}
				if($("#CreditPointright").val()=="true"){
					$("#CreditPoint_hthdang").removeAttr("disabled");
				}else{
					$("#CreditPoint_hthdang").attr("disabled","disabled");
				}
				if($("#Boss_Nameright").val()=="true"){
					$("#Boss_Name_hthdang").removeAttr("disabled");
				}else{
					$("#Boss_Name_hthdang").attr("disabled","disabled");
				}
				if($("#linkTelright").val()=="true"){
					$("#linkTel_hthdang").removeAttr("disabled");
				}else{
					$("#linkTel_hthdang").attr("disabled","disabled");
				}				
				if($("#FixCoderight").val()=="true"){
					$("#FixCode_hthdang").removeAttr("disabled");
				}else{
					$("#FixCode_hthdang").attr("disabled","disabled");
				}
				if($("#TradeTyperight").val()=="true"){
					$("#TradeType_hthdang").removeAttr("disabled");
				}else{
					$("#TradeType_hthdang").attr("disabled","disabled");
				}
				if($("#CompTyperight").val()=="true"){
					$("#CompType_hthdang").removeAttr("disabled");
				}else{
					$("#CompType_hthdang").attr("disabled","disabled");
				}
				if($("#HomePageright").val()=="true"){
					$("#HomePage_hthdang").removeAttr("disabled");
				}else{
					$("#HomePage_hthdang").attr("disabled","disabled");
				}
				if($("#Emailright").val()=="true"){
					$("#Email_hthdang").removeAttr("disabled");
				}else{
					$("#Email_hthdang").attr("disabled","disabled");
				}
				if($("#Manageidright").val()=="true"){
					$("#Manageid_hthdang").removeAttr("disabled");
				}else{
					$("#Manageid_hthdang").attr("disabled","disabled");
				}
				if($("#Arearight").val()=="true"){
					$("#Area_hthdang").removeAttr("disabled");
				}else{
					$("#Area_hthdang").attr("disabled","disabled");
				}
				if($("#HthMfjbright").val()=="true"){
					$("#HthMfjb_hthdang").removeAttr("disabled");
				}else{
					$("#HthMfjb_hthdang").attr("disabled","disabled");
				}
				if($("#IDCardright").val()=="true"){
					$("#IDCard_hthdang").removeAttr("disabled");
				}else{
					$("#IDCard_hthdang").attr("disabled","disabled");
				}
				if($("#sBmright").val()=="true"){
					$("#setHth1").removeAttr("disabled");
					$("#setHth2").removeAttr("disabled");
					$("#setHth3").removeAttr("disabled");
					$("#setHth4").removeAttr("disabled");
					$("#QKHth").removeAttr("disabled");
				}else{
					$("#setHth1").attr("disabled","disabled");
					$("#setHth2").attr("disabled","disabled");
					$("#setHth3").attr("disabled","disabled");
					$("#setHth4").attr("disabled","disabled");
					$("#QKHth").attr("disabled","disabled");
				}
				if($("#modifyattachfeeright").val()=="true"){
					$("#phonefeetype,#dhzfsave,#dhzfdel").removeAttr("disabled");
				}else{
					$("#phonefeetype,#dhzfsave,#dhzfdel").attr("disabled","disabled");
				}
				if($("#Yhmc_yhdangright").val()=="true"){$("#Yhmc_yhdang").removeAttr("disabled");}
				if($("#Yhdz_yhdangright").val()=="true"){$("#Yhdz_yhdang").removeAttr("disabled");$("#Yhdz_hthdang").removeAttr("disabled");}
				if($("#sBm_yhdangright").val()=="true"){$("#Bm1_yhdang").removeAttr("disabled");$("#Bm2_yhdang").removeAttr("disabled");$("#Bm3_yhdang").removeAttr("disabled");$("#Bm4_yhdang").removeAttr("disabled");}
				if($("#Mima_yhdangright").val()=="true"){$("#Mima_yhdang").removeAttr("disabled");$("#toMima_yhdang").removeAttr("disabled");}
				if($("#Bz8_yhdangright").val()=="true"){
					$("#Bz8_yhdang").removeAttr("disabled");
					$("#Sflx_hthdang").removeAttr("disabled");
				}else{
					$("#Sflx_hthdang").attr("disabled","disabled");
				}
				if($("#Bz9_yhdangright").val()=="true"){$("#Bz9_yhdang").removeAttr("disabled");}
				if($("#Bz6_yhdangright").val()=="true"){$("#Bz6_yhdang").removeAttr("disabled");}
				if($("#Bz7_yhdangright").val()=="true"){$("#Bz7_yhdang").removeAttr("disabled");}
				if($("#Hwjb1_yhdangright").val()=="true"){$("#Hwjb1_yhdang").removeAttr("disabled");}
				if($("#Jflb_yhdangright").val()=="true"){$("#Jflb_yhdang").removeAttr("disabled");}
				if($("#Mfjb_yhdangright").val()=="true"){$("#Mfjb_yhdang").removeAttr("disabled");}
				if($("#Mobile_yhdangright").val()=="true"){$("#Mobile_yhdang").removeAttr("disabled");}
				if($("#AdjustSheduleNo_yhdangright").val()=="true"){$("#AdjustSheduleNo_yhdang").removeAttr("disabled");}				
				if($("#CallSheduleNo_yhdangright").val()=="true"){$("#CallSheduleNo_yhdang").removeAttr("disabled");}
				if($("#MokuaiJu_yhdangright").val()=="true"){$("#MokuaiJu_yhdang").removeAttr("disabled");}
				if($("#YwArea_yhdangright").val()=="true"){$("#YwArea_yhdang").removeAttr("disabled");$("#Bz3_yhdang").removeAttr("disabled");}
				if($("#CreditGrade_yhdangright").val()=="true"){$("#CreditGrade_yhdang").removeAttr("disabled");}
				if($("#CreditPoint_yhdangright").val()=="true"){$("#CreditPoint_yhdang").removeAttr("disabled");}
				if($("#UserType_yhdangright").val()=="true"){$("#UserType_yhdang").removeAttr("disabled");}
				if($("#CustType_yhdangright").val()=="true"){$("#CustType_yhdang").removeAttr("disabled");}
				if($("#statrtimeright").val()=="true"){$("#StartDate_yhdang").removeAttr("disabled");}
				if($("#stoptimeright").val()=="true"){$("#EndDate_yhdang").removeAttr("disabled");}
				if($("#zjtimeright").val()=="true"){$("#Reg_Date_yhdang").removeAttr("disabled");}
				if($("#Dhgn_yhdangright").val()=="true"){$("#Dhgn_yhdang").removeAttr("disabled");}
				if($("#Bz2right").val()=="true"){$("#Bz2_hthdang").removeAttr("disabled");}//是否代收
				if($("#Tjbzright").val()=="true"){$("#Tjbz_yhdang").removeAttr("disabled");}//停机标志
				if($("#setagenththright").val()=="true"){$("#setHth").removeAttr("disabled");}				
			}
	
    </script>
    <script language="javascript">
		function lodingpage(){
			$("#Messagevalues").text("<fmt:message key="phone.getinternet0069" />");
			var procparams;
			loadPopup();
			var status_succ = false;
			var result = new Array();
			var i = 0;
			var j = 0;
			var urll = tsd.buildParams({ packgname:'service',
						clsname:'Procedure',//类名
						method:'exequery',//方法名
						ds:'tsdBilling',
						tsdExeType:'query',//操作类型 
						datatype:'xml',//返回数据格式 
						tsdpname:''						
				});			
			$.ajax({
				url:"mainServlet.html?" + urll + procparams,
				async:true,
				cache:false,
				timeout:600000,
				type:'post',
				success:function(xml){
					$(xml).find("row").each(function(){
						result[i++] = new Array();
						$(this).find("cell").each(function(){
							result[i-1].push($(this).text());
						});
					});
					status_succ = true;
					internation();//字段名称国际化	
		    		zfangfa();//加载下拉数据
		    		gettjbz();
		    		disablePopup();
		    		$("#tablehthdang :text").attr("disabled","disabled");
		    		$("#tablehthdang select").attr("disabled","disabled");
		    		$("#tableyhdang :text").attr("disabled","disabled");
		    		$("#tableyhdang select").attr("disabled","disabled");
				},
				complete:function()
				{

				}
			});			
		}
		
		/**
		 * 显示等待
		 * @param 无参数
		 * @return 无返回值
		 */
		function showWait()
		{
			$("#loading").css("display","block");//loadPopup();
		}
		/**
		 * 隐藏等待
		 * @param 无参数
		 * @return 无返回值
		 */
		function hideWait()
		{
			$("#loading").css("display","none");//disablePopup();
		}
		/**
		 * 弹窗
		 * @param 无参数
		 * @return 无返回值
		 */
		var popupStatus = 0;
		function loadPopup(){
			centerPopup();
			//loads popup only if it is disabled
			if(popupStatus==0){
				$("#backgroundPopup").css({
					"opacity": "0.7"
				});
				$("#backgroundPopup").css("display","block");
				$("#loading").css("display","block");
				popupStatus = 1;
			}
		}
		/**
		 * disablePopup
		 * @param 无参数
		 * @return 无返回值
		 */
		function disablePopup(){
			//disables popup only if it is enabled
			if(popupStatus==1){
				$("#backgroundPopup").fadeOut("slow");
				$("#loading").fadeOut("slow");
				popupStatus = 0;
			}
		}
		/**
		 * centering popup
		 * @param 无参数
		 * @return 无返回值
		 */
		function centerPopup(){
			//request data for centering
			var windowWidth = document.documentElement.clientWidth;
			var windowHeight = document.documentElement.clientHeight;
			var popupHeight = $("#loading").height();
			var popupWidth = $("#loading").width();
			//centering
			$("#loading").css({
				"position": "absolute",
				"top": windowHeight/2-popupHeight/2,
				"left": windowWidth/2-popupWidth/2
			});
			$("#backgroundPopup").css({
				"height": windowHeight
			});		
			
		}	
		
		function changemodiftype(){
			var modiftype = $("#modiftype").val();
			if(modiftype=="dh"){
				$("#dkhhth").hide();
				$("#dkhtext").hide();
				$("#dhquerytype").show();
				$("#ghSearchBox").show();
				$("#djhthdiv").show();
				$("#hidendh").show();
				$("#ghSearchBox").select();
				$("#ghSearchBox").focus();
			}else if(modiftype=="hth"){
				$("#dhquerytype").hide();
				$("#ghSearchBox").hide();
				$("#djhthdiv").hide();
				$("#hidendh").hide();
				$("#dkhhth").show();
				$("#dkhtext").show();
				$("#dkhhth").val("");
				$("#dkhhth").select();
				$("#dkhhth").focus();
			}
			$("#djhthdiv").show();
			clernull();			
		}
		
		function getquerytype(){
			var modiftype = $("#modiftype").val();
			if(modiftype=="dh"){
				ghSearch();
			}else if(modiftype=="hth"){
				var dkhhth = $("#dkhhth").val();
				dkhhth=dkhhth.replace(/(^\s*)|(\s*$)/g,"");
				if(dkhhth.length==0){
					alert("<fmt:message key="phone.getinternet0041" />");
					return;
				}				
				pageselect();
				ghSerBasicInfoHth(dkhhth);
				getPowerfalse();	
				$("#Hth").attr("disabled","disabled");
				$("#Dh").attr("disabled","disabled");			
			}	
			
		}
		
		function getUserProper(){
				var select = document.getElementById("yhxz_hidden");
				var array;
				$("#UserType_yhdang").empty();
				$("#Yhxz_hthdang").empty();
				$("#UserType_yhdang").html($("#UserType_yhdang").html()+"<option value='' selected='true'>--<fmt:message key="phone.getinternet0280" />--</option>");
				$("#Yhxz_hthdang").html($("#Yhxz_hthdang").html()+"<option value='' selected='true'>--<fmt:message key="phone.getinternet0280" />--</option>");
				for(var i=1;i<=select.options.length;i++){
					var op=document.createElement("option");
					if(i<select.options.length){								
						if(select.options[i].lvalue==""||select.options[i].lvalue==undefined){
							select.options[i].lvalue="";
						}       
	  					op.value = select.options[i].lvalue;
	  					if(op.value=="undefined"||op.value==undefined||op.value==""){
	
	  					}else{
	  						array = op.value.split("|");					  						
	  						if(array[2]==$("#usertype").val()){
								$("#Yhxz_hthdang").html($("#Yhxz_hthdang").html()+"<option value="+array[0]+">"+array[0]+"</option>");
	  							$("#UserType_yhdang").html($("#UserType_yhdang").html()+"<option value="+array[1]+">"+array[0]+"</option>");
	  						}
	  					} 
	  				}	 					
				}
			}
		</script>
		<style type="text/css">
			label{float:right;text-align:left;margin-left:0px;}
			#loading{
				display:none;
				position:fixed;
				_position:absolute; /* hack for internet explorer 6*/
				height:200px;
				width:408px;
				text-align:center;
				background:#FFFFFF;
				border:2px solid #cecece;
				z-index:2;
				padding:12px;
				font-size:13px;
			}
			#backgroundPopup{
				display:none;
				position:fixed;
				_position:absolute; /* hack for internet explorer 6*/
				height:100%;
				width:100%;
				top:0;
				left:0;
				background:#ffffff;
				border:1px solid #cecece;
				z-index:1;
			}
		</style>
	</head>
	<body onunload="unLockDh()">		
		<div id="loading">
				<div style="height:80px"></div>
				<img src="style/images/public/loading.gif" />
				<br />
				<span id="Messagevalues"></span><!-- 加载提示信息 -->
		  		</div>
	  		<div id="backgroundPopup"></div>
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
				<div class="title" style="display: none;">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0178" /><!-- 输入查询条件 -->
				</div>
				<div id="inputtext">	
					<table id="kdBar" style="margin-left: 10px;" cellspacing="10px">
						<tr>
							<td><fmt:message key="phone.getinternet0240" /><!-- 修改类型 --></td>
							<td>
								<select id="modiftype" name="modiftype" style="width:130px;" onchange="changemodiftype();">
									<option value="dh"><fmt:message key="phone.getinternet0241" /><!-- 查询电话信息 --></option>
									<option value="hth">查询合同号信息</option>
								</select>
							</td>
							<td width="30"></td>
							<td id="dhquerytype">
								<fmt:message key="phone.getinternet0179" /><!-- 查询方式 -->
								<select id="ghSearchWay" style="width: 100px;" >
									<option value="0">
										<fmt:message key="phone.getinternet0103" /><!-- 电话 -->
									</option>
									<option value="1">
										<fmt:message key="phone.getinternet0180" /><!-- 用户名 -->
									</option>
									<option value="2">
										<fmt:message key="phone.getinternet0113" /><!-- 用户地址-->
									</option>
								</select>
							</td>
							<td>
								<input type="text" class="" id="ghSearchBox" name="ghSearchBox" />
							</td>
							<td id="dkhtext"><fmt:message key="phone.getinternet0239" /><!-- 大客户合同号--></td>
							<td><input type="text" class="" id="dkhhth" name="dkhhth" /></td>
							<td>
								<button class="tsdbutton" id="submitButton" onclick="getquerytype();" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
									<fmt:message key="phone.getinternet0466" /><!-- 查找 -->
								</button>
							</td>							
							
						</tr>
					</table>		
				</div>
				<div id="djhthdiv">
					<div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/65.gif" />
						<fmt:message key="phoneyewu.setdjhth" />
									<!-- 设置代缴合同号 -->
					</div>
					<div id="inputtext">
						<table id="djhth" style="margin-left: 10px;">
							<tr valign="bottom">
								<td>
									<input type="hidden" name="danweiHTH" id="danweiHTH" class="you1"
										disabled="disabled" />
									<input type="hidden" name="gfhth" id="gfhth" />
								</td>
								<td>
									<button class="tsdbutton" id="setHth" onclick="setDJHTH()" style="margin-left:60px;"
										style="height: 25px; margin-top: 3px; padding: 0px;" disabled="disabled">
										<fmt:message key="phoneyewu.setdjhth" />
									<!-- 设置代缴合同号 -->
									</button>
								</td>
								<td width=80></td>
								<!-- <td>付费类型</td>
								<td>
									<select id="Sflx_hthdang" style="width:150px;">
										<option value="cash">现金</option>
										<option value="prepayment">预付</option>
									</select>
								</td> -->
							</tr>
						</table>
					</div>
				</div>
				<div class="title" style="display:none;">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0243" /><!-- 部门修改 -->
				</div>
				<div id="inputtext">
					<table cellspacing="4" id="geththsbm">
						<tr>
						<td>&nbsp;&nbsp;<span id="spanBm1"></span></td>
						<td><input type="text" id="sBm1" style="width:180px;" disabled="disabled"/><font color="red"><span id="bixuantype"></span></font>
						<input type="hidden" id="sBm1code" style="width:150px;" disabled="disabled"/>
						</td>
						<td>
						<button class="tsdbutton" id="setHth1" 
						onclick="yijisBmhth();" style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
						<fmt:message key="phone.getinternet0075" /><!-- 选择 -->
						</button>
						</td>
						<td><span id="spanBm2"></span></td>
						<td><input type="text" id="sBm2" style="width:180px;" disabled="disabled"/>
						<input type="hidden" id="sBm2code" style="width:150px;" disabled="disabled"/>
						</td>
						<td>
						<button class="tsdbutton" id="setHth2" 
						onclick="addsBmerhth();" style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
						<fmt:message key="phone.getinternet0075" /><!-- 选择 -->
						</button>
						</td>
						</tr>
						<tr>
						<td>&nbsp;&nbsp;<span id="spanBm3"></span></td>
						<td><input type="text" id="sBm3" style="width:180px;" disabled="disabled"/>
						<input type="hidden" id="sBm3code" style="width:150px;" disabled="disabled"/>
						</td>
						<td>
						<button class="tsdbutton" id="setHth3" 
						onclick="addsBmsanhth();" style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
						<fmt:message key="phone.getinternet0075" /><!-- 选择 -->
						</button>
						</td>
						<td><span id="spanBm4"></span></td>
						<td><input type="text" id="sBm4" style="width:180px;" disabled="disabled"/>
						<input type="hidden" id="sBm4code" style="width:150px;" disabled="disabled"/>
						</td>
						<td>
						<button class="tsdbutton" id="setHth4" 
						onclick="addsBmsihth();" style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
						<fmt:message key="phone.getinternet0075" /><!-- 选择 -->
						</button>
						</td>
						<td><button class="tsdbutton" id="QKHth" 
							onclick="javascript:$('#geththsbm :text').val('');" style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
						<fmt:message key="phone.getinternet0244" /><!-- 清空部门 -->
						</button></td>
						</tr>
						</table>
				</div>		
				<form action="#" name="form1" id="form1">
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0245" /><!-- 话费及状态 -->
					</div>
				<div id="inputtext">
					<div class="midd">						
						<table>
							<tr>
								<td class="wenzi">
										<span id="spanyucunYE"></span>
										<!--出帐月余额/出帐月欠费 -->
									</td>
									<td>
										<input type="text" id="phoneBalance" name="phoneBalance"
											value="0" style="width:140px;" disabled="disabled" />
									</td>
									<td class="wenzi">
										<span id="spanxinyueHF"></span>
										<!-- 实施余额/实施欠费 -->
									</td>
									<td>
										<input type="text" id="mothshuafei" name="mothshuafei"
											value="0" style="width:150px;" disabled="disabled" />
									</td>
								<td class="wenzi">
									<fmt:message key="phone.getinternet0181" /><!-- 停机标志 -->
								</td>
								<td>
									<select  id="Tjbz_yhdang" name="Tjbz_yhdang" style="width:150px;" disabled="disabled"></select>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0080" /><!-- 合同号信息 -->
				</div>
				<div id="inputtext">
					<div class="midd">
						<table id="tablehthdang" style="width:780px;">											
						</table>
						<select name="usertype" id="usertype" style="display:none"></select>
					</div>
				</div>	
				<div id="hidendh">
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0081" /><!-- 固话信息 -->
				</div>
				<div id="inputtext">
					<div class="midd">					
						<table id="tableyhdang" style="width:780px;">						
						</table>
					</div>
				</div>								
				</form>
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0082" /><!-- 固定费 -->
				</div>
				 <table style="display:none">
					<tr>
						<td valign="top">
						  <table>
						  	<tr>
						  		<td class="wenzi" style="width:60px;line-height:30px;">
										<span id="spanFeeName"></span>
										<!-- 费用代号 -->
								</td>
								<td>
										<select name="phonefeetype" id="phonefeetype" style="width: 157px;"
											onchange="getfeename()"></select>										
								</td>
							</tr>
							<tr>
								<td colspan="2">
						  			<div style="width:210px; height: 160px; overflow-y: scroll; overflow-x: hidden;background-color:#f7f7f7;border:1px 1px solid #dddddd;">
											<table id="phonefeename" style="width:230px;"  border="1" cellpadding="0"></table>
									</div>
						  		</td>
							</tr>
						  </table>
					 	 </td>
				 	 	 <td class="wenzi" style="width:45px;">
				 	 		<table cellspacing="1">
				 	 			<tr>
				 	 				<td width=1% style="margin-left: 0px;"></td>
				 	 			</tr>				  				
				  				<tr>
				  					<td colspan="2"><center>
				  						<button class="tsdbutton" id="dhzfsave"
										onclick="insertphonefeename()"
										style="width:60px; height: 26px; margin-top: 3px; padding: 0px;">
										<fmt:message key="phone.getinternet0083" /><!-- 新增>> -->
										</button></center>
				  					</td>
				  				</tr>
				  				<tr>
				  					<td colspan="2"><center>
				  						<button class="tsdbutton" id="dhzfdel"
										onclick="deletephonefeename()"
										style="width:60px; height: 26px; margin-top: 3px; padding: 0px;">
										<fmt:message key="phone.getinternet0084" /><!-- 取消 -->
										</button></center>
				  					</td>
				  				</tr>
				 	 		</table>
				 	 	</td>
				 	 	<td valign="top">				 	 	    
				 	 		<table id="dzhthcontent"  style="width:490px;">
				 	 			<tr>
									<th width="10"><input type="checkbox" id="dhzftab_checkall" onclick="Dhzf_CheckAll()" style="width:15px;" /></th>
									<th width="200">
										<center>
											<h4>
												<span id="spanFeeType_table"></span>
											</h4>
										</center>
									</th>
									<th width="60">
										<center>
											<h4>
												<span id="spanPrice_table"></span>
												<!-- 费率 -->
											</h4>
										</center>
									</th>
									<th width="100">
										<center>
											<h4>
												<span><fmt:message key="phoneyewu.starttime" /></span>
												<!-- 起始时间 -->
											</h4>
										</center>
									</th>
									<th width="100">
										<center>
											<h4>
												<span><fmt:message key="phoneyewu.termination" /></span>
												<!-- 终止时间 -->
											</h4>
										</center>
									</th>
									<th width="140">
										<center>
											<h4>
												<span><fmt:message key="phone.getinternet0085" /><!-- 参数值 --></span>
											</h4>
										</center>
									</th>
								</tr>
				 	 		</table>
				 	 		<div style="width:500px; height: 165px; overflow-y: scroll; overflow-x: hidden;">
				 	 		<table id="dhzftab" style="width:490px;">
								
							</table>							
							</div>
				 	 	</td>
					 </tr>
					 <tr>
					 	<td>
					 	<div style="display:none;width: 420px; height: 20px; overflow-y: scroll; overflow-x: scroll; border-top: 1px solid gray; border-left: 1px solid gray;">
						<table border="1" cellpadding="0" bordercolor="#9AC0CD"
							id="addspeediFeetype">
							
						</table>
					    </div>
					  </td>
					 </tr>
				</table> 
				<table cellspacing="8" id="ghfeeinput">
				</table>
				<!-- 固话费用隐藏值放此处点击新增按钮将其添加到临时表显示出来 --> 	
				<table style="display:none">
					<tr>
						<td>
						<input type="hidden" id="feecode" name="feecode" style="width: 150px;" disabled="disabled" /><!-- 费用代号 -->
						<input type="hidden" id="phonefeenamecode" name="phonefeenamecode"/><!-- 子费用 -->
						<input type="hidden" id="feelv" name="feelv" style="width:150px" disabled="disabled" /><!-- 费率 -->
						<input type="hidden" id="TJfeelv" name="TJfeelv" style="width: 150px;" disabled="disabled" /><!-- 停机费率 -->
						<input type="hidden" id="ZFStartday" name="ZFStartday" style="width: 150px;" disabled="disabled" value="<%=Log.getSysTime() %>"/><!-- 起始时间 -->
						<input type="hidden" id="ZFEndday" name="ZFEndday" style="width: 150px;" disabled="disabled" value="2999-12-31"  /><!-- 终止时间 -->						
						</td>	
					</tr>	
				</table>
				<div class="title" style="display:none">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0185" /><!--优惠套餐信息显示-->
				</div>
				<table border="1" cellpadding="0" bordercolor="#9AC0CD" id="dhTCX" width="780" style="display:none">
				</table>
				<div class="title" style="display: none;">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0186" /><!--包月套餐信息显示-->
				</div>
				 <table border="1" cellpadding="0" bordercolor="#9AC0CD" id="dhBYTC" width="780">
				 </table>
				 <div id="inputtext">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <fmt:message key="phoneyewu.memo" /><!--备注-->：
					<textarea rows="6" style="border: 1px solid #999999;" " cols="98"
							id="remark" maxlength="60"  onpropertychange="TextUtil.NotMax(this)"></textarea>
				</div> 				
			</div>			
			<div id="buttons">
				<center>
					<button id="save" onclick="modifyProperties();"
						style="margin-left: 20px;">
						<!-- 确定 -->
						<fmt:message key="Revenue.Save" />
					</button>
					<button id="reset" onclick="clernull();" style="margin-left: 20px;">
						<!-- 重置 -->
						<fmt:message key="AddUser.Reset" />
					</button>
				</center>
			</div>
		</div>
		<div class="neirong" id="multiSearch"
			style="width:687px;display: none; overflow-x: hidden;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="phone.getinternet0246" /><!-- 电话修改属性业务用户信息查询 -->
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;"
							onclick="javascript:$('#kdMultiSearchClose').click();"><fmt:message key="phone.getinternet0189" /><!--关闭--></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd"
				style="width:688px;background-color: #FFFFFF; text-align: left;">
				<div id="grid" style="margin-top: 0px;"></div>
			</div>
			<div class="midd_butt" style="width:673px;">
				<button type="button" class="tsdbutton" id="kdMultiSearchClose">
					<fmt:message key="phone.getinternet0189" /><!--关闭-->
				</button>
			</div>
		</div>			

		<input type="hidden" id="userid" value="<%=userid%>" />
		<input type="hidden" id="area" value="<%=area%>" />
		<input type="hidden" id="depart" value="<%=depart%>" />
		<input type="hidden" id="userareaid" value="<%=userareaid%>" />
		<input type="hidden" id="imenuid" value="<%=imenuid%>" />
		<input type="hidden" id="zid" value="<%=zid%>" />
		<input type="hidden" id="languageType" value="<%=languageType%>" />
		<input type='hidden' id='userloginip'
			value='<%=Log.getIpAddr(request)%>' />
		<input type='hidden' id='userloginid'
			value='<%=session.getAttribute("userid")%>' />
		<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
		<input type="hidden" id="useridright" name="useridright" />
		<input type="hidden" id="feenameid" name="feenameid" />
		<input type="hidden" id="inputDWHTH" name="inputDWHTH" />
		<input type="hidden" id="Subtype" name="Subtype" />

		<input type="hidden" id="setdaijiao" />

		<input type="hidden" id="addright" />
		<input type="hidden" id="deleteright" />
		<input type="hidden" id="editright" />
		<input type="hidden" id="editfields" />
		<input type="hidden" id="delBright" />
		<input type="hidden" id="editBright" />
		<input type="hidden" id="exportright" />
		<input type="hidden" id="printright" />

		<!-- 权限使用 -->
		<input type="hidden" id="statrtimeright"/><!-- 计费起始 -->
		<input type="hidden" id="stoptimeright"/><!-- 计费终止 -->
		<input type="hidden" id="zjtimeright"/><!-- 装机日期 -->
		<input type="hidden" id="Yhmcright"/>
		<input type="hidden" id="Yhlbright"/>
		<input type="hidden" id="Yhxzright"/>
		<input type="hidden" id="CallPayTyperight"/>
		<input type="hidden" id="ZnjBzright"/>
		<input type="hidden" id="CustTyperight"/>
		<input type="hidden" id="CreditGraderight"/>
		<input type="hidden" id="CreditPointright"/>
		<input type="hidden" id="Boss_Nameright"/>
		<input type="hidden" id="linkTelright"/>
		<input type="hidden" id="FixCoderight"/>
		<input type="hidden" id="TradeTyperight"/>
		<input type="hidden" id="CompTyperight"/>
		<input type="hidden" id="HomePageright"/>
		<input type="hidden" id="Emailright"/>
		<input type="hidden" id="Manageidright"/>
		<input type="hidden" id="Arearight"/>
		<input type="hidden" id="HthMfjbright"/>
		<input type="hidden" id="IDCardright"/>
		<input type="hidden" id="sBmright"/>
		<input type="hidden" id="Yhmc_yhdangright"/>
		<input type="hidden" id="Yhdz_yhdangright"/>
		<input type="hidden" id="sBm_yhdangright"/>
		<input type="hidden" id="Mima_yhdangright"/>
		<input type="hidden" id="Bz8_yhdangright"/>
		<input type="hidden" id="Bz9_yhdangright"/>
		<input type="hidden" id="Bz6_yhdangright"/>
		<input type="hidden" id="Bz7_yhdangright"/>
		<input type="hidden" id="Hwjb1_yhdangright"/>
		<input type="hidden" id="Jflb_yhdangright"/>
		<input type="hidden" id="Mfjb_yhdangright"/>
		<input type="hidden" id="Mobile_yhdangright"/>
		<input type="hidden" id="AdjustSheduleNo_yhdangright"/>
		<input type="hidden" id="CallSheduleNo_yhdangright"/>
		<input type="hidden" id="MokuaiJu_yhdangright"/>
		<input type="hidden" id="YwArea_yhdangright"/>
		<input type="hidden" id="CreditGrade_yhdangright"/>
		<input type="hidden" id="CreditPoint_yhdangright"/>
		<input type="hidden" id="UserType_yhdangright"/>
		<input type="hidden" id="CustType_yhdangright"/>
		<input type="hidden" id="Dhgn_yhdangright"/>
		<input type="hidden" id="setagenththright"/>
		<input type="hidden" id="Bz2right"/>
		<input type="hidden" id="Tjbzright"/>
		<!-- 添加日志时使用 -->
		<input type="hidden" id="Yhlb1" />
		<input type="hidden" id="Yhdz1" />
		<input type="hidden" id="Yhmc1" />
		<input type="hidden" id="Bm11" />
		<input type="hidden" id="Bm21" />
		<input type="hidden" id="Bm31" />
		<input type="hidden" id="Bm41" />
		<input type="hidden" id="Mima1" />
		<input type="hidden" id="MokuaiJu1" />
		<input type="hidden" id="YwArea1" />
		<input type="hidden" id="Bz91" />
		<input type="hidden" id="Bz81" />
		<input type="hidden" id="StopBz1" />
		<input type="hidden" id="Tjbz1" />
		<input type="hidden" id="AdjustSheduleNo1" />
		<input type="hidden" id="CallSheduleNo1" />
		<input type="hidden" id="Jflb1" />
		<input type="hidden" id="Mfjb1" />
		<input type="hidden" id="TypeNum1" />
		<input type="hidden" id="dhgn1" />
		<input type="hidden" id="Jhj_ID1" />
		<input type="hidden" id="Mobile1" />
		<input type="hidden" id="Zyjb1" />
		<input type="hidden" id="Bz61" />
		<input type="hidden" id="Bz71" />
		<input type="hidden" id="Hwjb1" />
		<input type="hidden" id="Yhxz1" />
		<input type="hidden" id="CallPayType1" />
		<input type="hidden" id="Area1" />
		<input type="hidden" id="ZnjBz1" />
		<input type="hidden" id="Dhlx1" />
		<input type="hidden" id="Yhmc1" />
		<input type="hidden" id="Sflx1" />
		<input type="hidden" id="Pmemo1" />
		<input type="hidden" id="Jhj_ID_yhdang"/>
		<input type="hidden" id="startdate" value="<%=Log.getSysTime() %>"/><!-- 固定费用起始日期 -->
		<input type="hidden" id="addressinputright"/>
		<input type="hidden" id="bmtypekey"/><!-- 部门编号 -->		
		<input type="hidden" id="sbmcode"/><!-- 部门编号 -->
		<input type="hidden" id="sbmname"/><!-- 部门名称 -->
		<input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->	
		<input type="hidden" id="stiffbusinestype" value="phoneXGSX"/><!-- 电话工单打印类型 -->
		<input type="hidden" id="yhxzyhdanghidden"/>
		<input type="hidden" id="modifyattachfeeright"/>
		<select id="yhxz_hidden" style="display:none;"></select>
		<jsp:include page="phone_internet.jsp" flush="true"/>
		<input type="hidden" id="businesstype" value="p_editproperty"/><!-- 该页面的业务类型 -->	
	</body>

</html>
