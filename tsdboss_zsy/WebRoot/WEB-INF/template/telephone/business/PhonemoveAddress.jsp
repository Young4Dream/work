<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/PhonemoveAddress.jsp
    Function:   电话移机
    Author:     wenxuming
    Date:       2010-10
    Description: 
    Modify: 
     2010-10月份： 对该页面进行移植，并对版式进行修改；
     2010-11-03： 把公用的CSS提取出来放到style/css/telephone/business/businesspublic.css；
     2010-11-04： 1.问题：修改地址选择时，没有下一级地址时还提示选择下一级地址；
     			  修改函数：c_p_address_fun_to()，问题已解决；
     			 2.包月套餐不显示进行了添加getdhBYTC(Dh)函数方法；
     2010-11-05: 修改了新地址不可输入，notecheck()函数；
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
	String username = (String) session.getAttribute("username");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>电话移机业务</title>
		<meta http-equiv="description" content="this is my page" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
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
		<script src="script/public/phoneservicenew.js" type="text/javascript" language="javascript"></script>		
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
		<script src="script/telephone/business/businesspublic.js" type="text/javascript" language="javascript"></script>	
		<!-- 打印报表弹出窗口 -->
		<script src="script/telephone/business/businessreprint.js" type="text/javascript" language="javascript"></script>
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
		<!--设置全局字体大小-->
		<link href="style/css/telephone/business/fontsize_all.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript">
		 $(function(){
		  $("tbody>tr:odd").addClass("odd"); //先排除第一行,然后给奇数行添加样式
		  $("tbody>tr:even").addClass("even"); //先排除第一行,然后给偶数行添加样式
		 });
		 
		 /*********
				* 权限设置			
				* @param;
				* @return;
		    	**********/
				function getUserPower(){
				 var urlstr=tsd.buildParams({packgname:'service',
							 					  clsname:'Procedure',
												  method:'exequery',
							 					  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
							 					  tsdpname:'prodistorys.xuanxian',//存储过程的映射名称
							 					  tsdExeType:'query',
							 					  datatype:'xmlattr'
						 					});
				/************************
				*   调用存储过程需要的参数 *
				**********************/
				var userid = $('#userid').val();	
				var groupid = $('#zid').val();
				var imenuid = $('#imenuid').val();
				/****************
				*   拼接权限参数 *
				**************/
				var useridright='';
				var konghaoarearight='';
				var selecththright='';
				var addressinputright='';
				var flag = false;
				var spower = '';				
				$.ajax({
						url:'mainServlet.html?'+urlstr+'&userid='+userid+'&groupid='+groupid+'&menuid='+imenuid,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							$(xml).find('row').each(function(){
									spower += $(this).attr("spower")+'@';
							});
						}
				});
				if(spower=='all@'){
						addressinputright='true';
						flag = true;
				}else if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');
						for(var i = 0;i<spowerarr.length-1;i++){
							addressinputright +=getCaption(spowerarr[i],'addressinput','')+'|';					
						}
				}
				var hasaddressinput = addressinputright.split('|');
				var str = 'true';				
				if(flag==true){
					$("#addressinputright").val(addressinputright);
				}else{
					for(var i = 0;i<hasaddressinput.length;i++){
							$("#addressinputright").val(hasaddressinput[i]);
							break;
						}		
					}				    
			}
		</script>
    	<script type="text/javascript">
       jQuery(document).ready(function()
	   {	    	    
	    $("#navBar").append(genNavv());
	    getUserPower();	    
		  $("#dhzfform td:even").attr("align","right");
		  $("#bytcform td:even").attr("align","right");
    	$("#ghBasicInfo :text").css("margin-left","5px"); 
	    getinternation();	//businesspublic.js中  自动加载显示框  
	    PageInitial();
	    ghPayMoney('p_movephone');//通过移机标识查询一次性费用
	    $("#ghSearchBox").select();
	    $("#ghSearchBox").focus();
	    $("#tablehthdang select").attr("disabled","disabled");
			$("#tablehthdang :text").attr("disabled","disabled");
			$("#tableyhdang select").attr("disabled","disabled");
			$("#tableyhdang :text").attr("disabled","disabled");
			$("#sAddressold").attr("disabled","disabled");//默认加载新地址无法编辑，必须查询用户电话才可编辑
			if(getaddressEditer()=="NO"){
				$("#sAddressold").focus(function(){c_p_address_fun_to();});
				$("#sAddressold").keyup(function(){notecheck();});
			}
			getfufeitype();//付费类型	
			gethide("p_movephone");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数
			 $("#newywarea").empty();
			 var ywres = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&cloum=xuhao,ywarea&tablename=area_ywsl&key=1=1 order by ywarea");
			 if(ywres!=undefined&&ywres!=""){
			 	var ywstr="<option value=''>--<fmt:message key="phone.getinternet0280" />--</option>";
			 	for(var i=0;i<ywres.length;i++){		 		
			 		ywstr+="<option value='"+ywres[i][1]+"'>"+ywres[i][1]+"</option>"
			 	}
			 	$("#newywarea").html(ywstr);
			 	
			 }else{
			 	$("#newywarea").html("<option value=''>--无数据--</option>");
			 }
			 
			 $("#newmokuaiju").empty();
			 var mokuaiju = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&cloum=id,mokuaiju&tablename=mokuaiju&key=1=1 order by mokuaiju");
			 if(mokuaiju!=undefined&&mokuaiju!=""){
			 	var mokuaijutr="<option value=''>--<fmt:message key="phone.getinternet0280" />--</option>";
			 	for(var i=0;i<mokuaiju.length;i++){		 		
			 		mokuaijutr+="<option value='"+mokuaiju[i][1]+"'>"+mokuaiju[i][1]+"</option>";
			 	}
			 	$("#newmokuaiju").html(mokuaijutr);
			 	$("#newmokuaiju2").html(mokuaijutr);
			 	$("#newmokuaiju3").html(mokuaijutr);
			 	$("#newmokuaiju4").html(mokuaijutr);
			 	
			 }else{
			 	$("#newmokuaiju").html("<option value=''>--无数据--</option>");
			 	$("#newmokuaiju2").html("<option value=''>--无数据--</option>");
			 	$("#newmokuaiju3").html("<option value=''>--无数据--</option>");
			 	$("#newmokuaiju4").html("<option value=''>--无数据--</option>");
			 }
	   }); 
	   
	   /*
	   *根据业务区域得到营业区域
	   */
	   function getchangeywarea(){
	   		$("#area_dz").empty();
	   		var ywarea_dz="";
	   		var str = $("#ywarea_dz").val();
	   		if(str==""||str==undefined){
	   			ywarea_dz=-1;
	   		}else{
	   			ywarea_dz=str;
	   		}
	   		var res = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&cloum=area&tablename=asys_area&key=ywareaid="+ywarea_dz);
		 	if(res!=undefined&&res!=""){
		 		var str="<option value=''>--<fmt:message key="phone.getinternet0280" />--</option>";
			 	for(var j=0;j<res.length;j++){
			 		str+="<option value='"+res[j][0]+"'>"+res[j][0]+"</option>"
			 	}
			 	$("#area_dz").html(str);
			 	//$("#area_dz").val($("#Bz3_yhdang").val());
		 	}else{
		 		$("#area_dz").html("<option value=''>--无数据--</option>");
		 	}
	   }
	   	   
	   /*******
       *清除被锁定账号
       *@param;
       *@return;
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
			var result = fetchMultiPValue("PhoneDH.ifCanSouLi",6,"&OperID=" + tsd.encodeURIComponent($("#userid").val()) + "&Ywlx="+tsd.encodeURIComponent("p_movephone")+"&NowYwArea="+tsd.encodeURIComponent($("#area").val())+"&Dh="+Dh);
			if(result[0]!=undefined && result[0][0]!="")
			{
				alert(result[0][1]);
				return;
			}	
			
			//判断是否完工
			var res = fetchSingleValue("dbsql_phone.getteljobwgrq",6,"&dh="+Dh);
			if(res>0){
				//alert("对不起，该电话未完工！！！");
				alert("<fmt:message key="phone.getinternet0163" />");
				return;
			}
			
			//判断是否有宽带
			var rad = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=username&tablename=tsd.radcheck&key=sdh='"+Dh+"'");
			if(rad!=undefined&&rad!=""){
				//alert("请注意，该电话有宽带！");
				alert("<fmt:message key="phone.getinternet0170" />");
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
			$("#sAddress").val(Yhdz);			
			$("#Plinkman,#Plinkphone").removeAttr("disabled");		
			$("#sAddressold").removeAttr("disabled");
			getServiceArea();
			getYhdangInfo(Dh);
			ghSerBasicInfo(Dh);
			$("#sAddressold").select();
			$("#sAddressold").focus();
			ghZF(Dh);
			//gethTC(Dh);
			getdhBYTC(Dh);
			setTimeout($.unblockUI,1);
		}
		
		function getYhdangInfo(dh){
			var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xmlattr',//返回数据格式 
									tsdpk:'PhonemoveAddress.dhBasicInfo'
									});
			var params = "&Dh=" + dh;		
			$.ajax({
				url:"mainServlet.html?"+urlstr+params,
				cache:false,
				success:function(xml){
					$(xml).find("row").each(function(){		
					
						$("#oldywarea").val($(this).attr("ywarea")==undefined?"":$(this).attr("ywarea"));
						$("#oldmokuaiju").val($(this).attr("mokuaiju")==undefined?"":$(this).attr("mokuaiju"));
						$("#oldmokuaiju2").val($(this).attr("mkj2")==undefined?"":$(this).attr("mkj2"));
						$("#oldmokuaiju3").val($(this).attr("mkj3")==undefined?"":$(this).attr("mkj2"));
						$("#oldmokuaiju4").val($(this).attr("mkj4")==undefined?"":$(this).attr("mkj2"));
						if($("#oldmokuaiju2").val() != ""){
							$("#oldmokuaiju2").parent().parent().show();
						}
						if($("#oldmokuaiju3").val() != ""){
							$("#oldmokuaiju3").parent().parent().show();
						}
						if($("#oldmokuaiju4").val() != ""){
							$("#oldmokuaiju4").parent().parent().show();
						}
						
					});
				}
			});
			
		}
		//加载所属区域
		function getServiceArea(){
	   		var res = fetchMultiArrayValue("rad_busi_new.getservicearea",6,"","business");
		 	if(res!=undefined&&res!=""){
		 		var str="<option value=''>--请选择--</option>";
			 	for(var j=0;j<res.length;j++){
			 		str+="<option value='"+res[j][0]+"'>"+res[j][1]+"</option>"
			 	}
			 	$("#oldservicearea").html(str);
			 	$("#oldservicearea").attr("disabled","disabled");
			 	$("#newservicearea").html(str);
		 	}else{
		 		$("#oldservicearea").html("<option value=''>--请选择--</option>");
		 		$("#newservicearea").html("<option value=''>--请选择--</option>");
		 	}
		}

		/*******
        *移机保存时调用过程处理
        *@param;
        *@return;
        ********/
		function updateAddress()
		{
			//每次拼接参数必须初始化此参数
			tsd.QualifiedVal=true;				
		 	var params='';
		 	/*
				area	depart userid phone qjtkj  
				ableTo cIsPay cPayType cYingJiao cShiShou  
				cPayItem  cLianXiRen  cLianXiDianHua danweiHTHbox   danweiHTH  
				phonepkBz
			*/
			//获取参数
			//区域
			var area = $("#area").val();
			var userareaid = $("#userareaid").val();
			//部门
			var depart = $("#depart").val();
			//工号
			var userid = $("#userid").val();
			//电话
			var phone = $("#Dh_yhdang").val();
			
			if(phone=="")
			{
				//alert("请先查询要办理移机的用户");
				alert("<fmt:message key="phone.getinternet0201" />");
				$("#ghSearchBox").select();
				$("#ghSearchBox").focus();
				return false;
			}
			
			//可办理业务和当前状态不可以一样
			//当前状态
			var sdz = $("#sAddress").val();	
			//可办理业务	
			var xdz = $("#sAddressold").val();
			/*
			if($("#ywarea_dz").val()==""){
				alert("请选择业务区域！");
				$("#ywarea_dz").select();
				$("#ywarea_dz").focus();
				return;
			}
			if($("#area_dz").val()==""){
				alert("请选营业区域！");
				$("#area_dz").select();
				$("#area_dz").focus();
				return;
			}
			*/
			if($.trim(xdz)=="")
			{
				//alert("请输入新地址");
				alert("<fmt:message key="phone.getinternet0202" />");
				$("#sAddressold").select();
				$("#sAddressold").focus();
				return false;
			}
			/*
			if(xdz==sdz)
			{
				//alert("新地址和原地址不能一样");
				alert("<fmt:message key="phone.getinternet0203" />");
				$("#sAddressold").select();
				$("#sAddressold").focus();
				return false;
			} */
			
			var plinkman = $("#Bz8_yhdang").val();
			/*
			if($.trim(plinkman)=="")
			{
				alert("请输入联系人姓名");
				$("#Bz8_yhdang").select();
				$("#Bz8_yhdang").focus();
				return false;
			}*/
			var plinkphone = $("#Bz9_yhdang").val();
			/*
			if($.trim(plinkphone)=="")
			{
				alert("请输入联系电话");
				$("#Bz9_yhdang").select();
				$("#Bz9_yhdang").focus();
				return false;
			}*/
			
			//付费方式
			var cPayType = $("#cPayType").val();		
			//应缴费
			var cYingJiao = $("#cYingJiao").val().replace(/(^\s*)|(\s*$)/g,"");
			if(cYingJiao==""){cYingJiao=0;}
			//实缴费
			/*
			var cShiShou = $("#cShiShou").val().replace(/(^\s*)|(\s*$)/g,"");
			if(cShiShou==""){cShiShou=0;}
			*/
			//费用项目
			var cPayItem = $("#cPayItem").val();
			cYingJiao = parseFloat(cYingJiao,10);
			//cShiShou = parseFloat(cShiShou,10);	
			if(cYingJiao==0){cPayItem="";}
			//if(cYingJiao!=0&&cShiShou==0){alert("请输入实缴费用！");$("#cShiShou").select();$("#cShiShou").focus();return false;}
			//var danweiHTHbox = $("#danweiHTHbox").val();
			//代缴合同号
			var danweiHTH = $("#danweiHTH").val();			
			//备注
			var phonepkBz = $("#phonepkBz").val().replace(/(^\s*)|(\s*$)/g,"");
			//新旧业务区域
			var newywarea = $("#newywarea").val();
			var oldywarea = $("#oldywarea").val();
			//新旧模块局
			var newmokuaiju = $("#newmokuaiju").val();
			var oldmokuaiju = $("#oldmokuaiju").val();
			//新旧模块局2
			var newmokuaiju2 = $("#newmokuaiju2").val();
			var oldmokuaiju2 = $("#oldmokuaiju2").val();
			//新旧模块局3
			var newmokuaiju3 = $("#newmokuaiju3").val();
			var oldmokuaiju3 = $("#oldmokuaiju3").val();
			//新旧模块局4
			var newmokuaiju4 = $("#newmokuaiju4").val();
			var oldmokuaiju4 = $("#oldmokuaiju4").val();
			
			if(newywarea !=''){
				params+="&newywarea="+tsd.encodeURIComponent(newywarea);
				params+="&oldywarea="+tsd.encodeURIComponent(oldywarea);
			}
			if(newmokuaiju !=''){
				params+="&newmokuaiju="+tsd.encodeURIComponent(newmokuaiju);
				params+="&oldmokuaiju="+tsd.encodeURIComponent(oldmokuaiju);
			}
			if(newmokuaiju2 !=''){
				params+="&newmokuaiju2="+tsd.encodeURIComponent(newmokuaiju2);
				params+="&oldmokuaiju2="+tsd.encodeURIComponent(oldmokuaiju2);
			}
			if(newmokuaiju3 !=''){
				params+="&newmokuaiju3="+tsd.encodeURIComponent(newmokuaiju3);
				params+="&oldmokuaiju3="+tsd.encodeURIComponent(oldmokuaiju3);
			}
			if(newmokuaiju4 !=''){
				params+="&newmokuaiju4="+tsd.encodeURIComponent(newmokuaiju4);
				params+="&oldmokuaiju4="+tsd.encodeURIComponent(oldmokuaiju4);
			}
			params+="&Area="+tsd.encodeURIComponent(area);
			params+="&userarea="+tsd.encodeURIComponent(userareaid);
			params+="&username="+tsd.encodeURIComponent('<%=username%>');
			params+="&Depart="+tsd.encodeURIComponent(depart);
			params+="&UserID="+tsd.encodeURIComponent(userid);
			params+="&Dhh="+tsd.encodeURIComponent(phone);
			params+="&sdz="+tsd.encodeURIComponent(sdz);			
			params+="&xdz="+tsd.encodeURIComponent(xdz);
			params+="&ispay="+tsd.encodeURIComponent(cPayType);
			params+="&yjfee="+tsd.encodeURIComponent(cYingJiao);			
			//params+="&sjfee="+tsd.encodeURIComponent(cShiShou);
			params+="&feename="+tsd.encodeURIComponent(cPayItem);
			params+="&linkman="+tsd.encodeURIComponent(plinkman);
			params+="&linkphone="+tsd.encodeURIComponent(plinkphone);
			params+="&HTH="+tsd.encodeURIComponent(danweiHTH);
			params+="&zwbz="+tsd.encodeURIComponent(phonepkBz);
			params+="&Hthhth="+tsd.encodeURIComponent($("#Hth").val());
			params+="&IDCard="+tsd.encodeURIComponent($("#IDCard").val());	
			params+="&Yhxz="+tsd.encodeURIComponent($("#Yhxz").val());
			params+="&Yhlb="+tsd.encodeURIComponent($("#Yhlb").val());
			//params+="&ywarea_dzto="+tsd.encodeURIComponent($("#ywarea_dz option:selected").text());
			//params+="&area_dz="+tsd.encodeURIComponent($("#area_dz").val());
			var bz1new_yhdang=$("#bz1new_yhdang").val();
			if(bz1new_yhdang!="" && bz1new_yhdang!=undefined){
				bz1new_yhdang.replace(/(^\s*)|(\s*$)/g,"");
			}
			params+="&bz1new_yhdang="+tsd.encodeURIComponent(bz1new_yhdang);	

			params+="&bz5new_yhdang="+tsd.encodeURIComponent($("#bz5new_yhdang").val());		
			
			params+="&oldservicearea="+tsd.encodeURIComponent($("#oldservicearea").val());
			params+="&newservicearea="+tsd.encodeURIComponent($("#newservicearea").val());			
			/************
			//测试获取到的数据是否正确数据
			alert("区域: "+area);
			alert("部门: "+depart);
			alert(" 工号:"+userid);
			alert("电话: "+phone);
			alert("当前状态 :"+qjtkj);	
			alert("更改状态:"+ableTo);
			alert("是否付费："+cIsPay);
			alert($("#cIsPay")[0].checked);
			alert("付费方式:"+cPayType);
			alert("应缴费:"+cYingJiao);
			alert("实缴费："+cShiShou);
			alert("费用项:"+cPayItem);
			alert("联系人："+cLianXiRen);
			alert("联系电话："+cLianXiDianHua);
			alert("是否单位代缴"+danweiHTHbox);
			alert("代缴合同号"+danweiHTH);
			alert("备注："+phonepkBz);
			*********/
			var loginfo = "<fmt:message key="phone.getinternet0425" />:";//电话移机
			loginfo += "(<fmt:message key="phone.getinternet0103" />:";
			loginfo += phone;
			loginfo += ")(<fmt:message key="phone.getinternet0204" />:";
			loginfo += sdz;
			loginfo += ")(<fmt:message key="phone.getinternet0205" />:";
			loginfo += xdz;
			loginfo += ")(<fmt:message key="phone.getinternet0381" />:";
			loginfo += area;
			loginfo += ")(<fmt:message key="phone.getinternet0396" />:";
			
			loginfo += ")(原业务区域:";
			loginfo += $("#oldywarea").val();
			loginfo += ")(现业务区域:";
			loginfo += newywarea;
			
			loginfo += ")(原模块局:";
			loginfo += $("#oldmokuaiju").val();
			loginfo += ")(先模块局:";
			loginfo += newmokuaiju;
			
			loginfo += userid+")";
			loginfo = tsd.encodeURIComponent(loginfo);
		 	params+="&ywbz="+loginfo;
	 		//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
			
			var fee=fetchMultiArrayValue("select.fee",6,"");	
		      if(fee==""){
		        alert("请选择一次性费用");
		        return;
		      }
			
			var result = fetchMultiPValue("PhoneService.YJ",6,params);
			if(result[0]==undefined || result[0][0]==undefined || result[0][0]=='-1')
			{
				//alert("业务失败");
				alert("<fmt:message key="phone.getinternet0193" />");
			}
			else
			{
				$("#jobidid").val(result[0][0]);
				$("#ppaytype").val(cPayType);
				$("#fee").val(cYingJiao);		
				$("#ghSearchBox").select();
				$("#ghSearchBox").focus();						
				//判断是否打印工单，从tsd_ini表中配置Y为打印
				printworkorder('p_movephone');//script/telephone/business/businessreprint.js中
				writeLogInfo("","modify",loginfo);				
				pageReset();
				
				if(confirm("是否跳转到号线管理系统")){
                    openMenu('4114','route/RouteManage.jsp','6','');
                }
			}
		}
		
		/*******
        *页面重置
        *@param;
        *@return;
        ********/
		function pageReset()
		{
			$(":text").val("");
			$("#tablehthdang :text").val("");
        	$("#tablehthdang select").val("");
        	$("#tableyhdang :text").val("");
        	$("#tableyhdang select").val("");
        	$("#staff_bm").val("").trigger("change");
        	$("#cPayType").val("cash").trigger("change");
			//业务备注框
			$("#phonepkBz").val("");
			//杂费项
			$("#dhZFX").empty();
			//套餐项
			$("#dhTCX").empty();		
			$("#dhBYTC").empty();	
			$("#cPayType").val("cash");
			$("#danweiHTHbox").removeAttr("checked");
			$("#sAddressold").attr("disabled","disabled");	
			refreshbusinessfee();
			ghPayMoney('p_movephone');//通过移机标识查询一次性费用		
			gethide("p_movephone");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数	
			$("#ywarea_dz").val("");
			$("#area_dz").val("");	
			$("#bz1new_yhdang").val("");
			$("#bz5new_yhdang").val("");
			unLockDh();
		}				
       	
    </script>
    <script language="javascript">
       /*******
        *加载选择用户所在区域
        *@param;
        *@return;
        ********/       
        function getuserareato(){
          var uareato="";
            var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'adduser.getuserarea'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});										
			                $.ajax({
					              url:'mainServlet.html?'+urlstr,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){	
					              uareato="";
					              $("#seluserarea").empty();			       
					                $(xml).find('row').each(function(){	
					                  var xuhao = $(this).attr("xuhao");
					                  var ywarea = $(this).attr("ywarea");
					                  if(ywarea!=undefined){
							            var ee="<option value='"+xuhao+"'>"+ywarea+"</option>";
							            uareato=uareato+ee;								       
								      }
							        });	
							        uareato +="<option value='' selected=true><fmt:message key="gjh.select"/></option>";				       						        
							        $("#c_p_address_seluserarea").html(uareato);							       
							      }
							});							        				       						        				       						        
        }
        
	    /*******
	    *点击添加地址按钮，弹出添加地址框  
	    *@param;
	    *@return;
	    ********/
		function addnewinfo()
		{
			var groupid = $('#zid').val();
			window.showModalDialog('mainServlet.html?pagename=telephone/linemanagement/addressManage.jsp&imenuid=1085&pmenuname=号线管理 &imenuname=地址库管理 &groupid='+groupid,window,"dialogWidth:820px; dialogHeight:650px; center:yes; scroll:yes");
		}    
	        
	    /*******
	    *地址选择
	    *@param;
	    *@return;
	    ********/ 
		function c_p_address()
		{
			var ctrr = $("#sAddressold");
			$(ctrr).focus(function(){c_p_address_fun_to();});		
		}
		
		/*******
	    *弹出新地址选择器
	    *@param;
	    *@return;
	    ********/
		function c_p_address_fun_to()
		{		 	     
			if($("#c_p_address").size()<1)
			{
				$("#sAddressold").after("<div id=\"c_p_address\"></div>");
			}
			var left = 30;
			var top = $("#sAddressold").offset().top + 20;
			//alert($("#sAddressold").parent().offset().left);
			$("#c_p_address").css({'position':'absolute','left':left,'top':top,'background-color':'#FFFFFF','border':'#99ccff 1px solid','height':'112px','width':'760px'});
			$("#c_p_address").empty();		
			var address_tab="<table id=\"address_tab\" style=\"\">";
			address_tab += "<tr><td colspan=\"6\"><h4><fmt:message key="phone.getinternet0374" /></h4></td></tr>";
			address_tab += "<tr><td align=\"right\"><fmt:message key="phone.getinternet0381" /></td><td><select id=\"c_p_address_seluserarea\" disabled></select></td><td><fmt:message key="phone.getinternet0375" /></td><td><select id=\"c_p_address_xq\"><option value=\"\">--"+$("#getinternet0365").val()+"--</option></select></td><td><fmt:message key="phone.getinternet0376" /></td><td><select id=\"c_p_address_ld\"><option value=\"\">--"+$("#getinternet0365").val()+"--</option></select></td><td><fmt:message key="phone.getinternet0377" /></td><td><select id=\"c_p_address_dy\"><option value=\"\">--"+$("#getinternet0365").val()+"--</option></select></td><td><fmt:message key="phone.getinternet0378" /></td><td><select id=\"c_p_address_mp\"><option value=\"\">--"+$("#getinternet0365").val()+"--</option></select></td></tr>";
			address_tab += "<tr><td><button id=\"c_p_address_bnok\" class=\"tsdbutton\"><fmt:message key="Revenue.Save" /></button></td><td colspan='2'><button id=\"c_p_address_add\" onclick=\"addnewinfo()\" class=\"tsdbutton\"><fmt:message key="phone.getinternet0379" /></button></td><td><button id=\"c_p_address_bncancel\" class=\"tsdbutton\"><fmt:message key="phone.getinternet0084" /></button></td><td></td><td></td><td></td><td></td></tr>";
			address_tab += "</table>";
			$("#c_p_address").append(address_tab);
			getuserareato();
			$("#c_p_address_seluserarea").val($("#userareaid").val());
			var addr = $("select[id='c_p_address_seluserarea'] :selected").html();
			/////////////从内存得到一级地址/////////////////////
			c_p_bindToAddr(1,"c_p_address_xq","&addrarea=" + tsd.encodeURIComponent(addr));						
			var cpad = $("#c_p_address_addright").val();
			if(cpad=="true"){
			  $("#c_p_address_add").removeAttr("disabled");		  		  	  
			}
			$("select[id^='c_p_address_']").css("width","100px");		
			//c_p_bindToAddr(1,"c_p_address_xq","");
			//var sua = $("select[id='c_p_address_seluserarea'] :selected").html();
			//c_p_bindToAddr(1,"c_p_address_xq","&addrarea=" + tsd.encodeURIComponent(sua));
			//隐藏证件类型下拉框
			$("#UserName1").css("display","none");
			
			//获得焦点时显示
			$("#c_p_address").show('slow');		
			$(document).one("click",function(event){
				//$("#c_p_address").hide('slow');
				//event.stopPropagation();
			});
			
			$("#c_p_address_seluserarea").change(function(){
				//alert($("#c_p_address_xq").val()); 
				var addr = $("select[id='c_p_address_seluserarea'] :selected").html();
				if(addr!="")
				{
					/////////////从内存得到一级地址/////////////////////			
					c_p_bindToAddr(1,"c_p_address_xq","&addrarea=" + tsd.encodeURIComponent(addr));
						/////////////////////////////////////
						//c_p_bindToAddr(1,"c_p_address_xq","&addrarea=" + tsd.encodeURIComponent(addr));
				}
			});
				    
			$("#c_p_address_xq").change(function(){
				//alert($("#c_p_address_xq").val()); 
				var addr = $("#c_p_address_xq").val();
				if(addr!="")
				{
					//////////////从内存得到二级地址////////////////////					
					c_p_bindToAddr(2,"c_p_address_ld","&addr=" + $("#c_p_address_xq").val());
							/////////////////////////////////////
							//c_p_bindToAddr(2,"c_p_address_ld","&addr=" + $("#c_p_address_xq").val());	
				}
			});
			
			$("#c_p_address_ld").change(function(){
				//alert($("#c_p_address_xq").val()); 
				var addr = $("#c_p_address_ld").val();
				if(addr!="")
				{
					//////////////从内存得到三级地址////////////////////					
					c_p_bindToAddr(3,"c_p_address_dy","&addr=" + $("#c_p_address_ld").val());
							/////////////////////////////////////
							//c_p_bindToAddr(3,"c_p_address_dy","&addr=" + $("#c_p_address_ld").val());	
				}
			});
			
			$("#c_p_address_dy").change(function(){
				//alert($("#c_p_address_xq").val()); 
				var addr = $("#c_p_address_dy").val();
				if(addr!="")
				{
					//////////////从内存得到四级地址////////////////////					
					c_p_bindToAddr(4,"c_p_address_mp","&addr=" + addr);
							//c_p_bindToAddr(4,"c_p_address_mp","&addr=" + addr);
				}
			});
			
			$("#c_p_address_bnok").click(function(){
				
				var info = "";
				var errinfo = "";
				
				var elems = ['xq','ld','dy','mp'];
				var infoo = ["<fmt:message key="phone.getinternet0375" />","<fmt:message key="phone.getinternet0376" />","<fmt:message key="phone.getinternet0377" />","<fmt:message key="phone.getinternet0378" />"];
				
				for(var j=0;j<4;j++)
				{
					if($("#c_p_address_"+elems[j]).val() != "")
					{
						info += $("select[id='c_p_address_"+elems[j]+"'] :selected").html();
						info += ",";
					}else if(resto!=undefined){
					    errinfo += infoo[j];
						errinfo += ",";
					}	
				}
				if(errinfo.length!=0&&$('#c_p_address_xq option').size()>1&&$("#c_p_address_xq").val()=="")
						{
							alert("<fmt:message key="phone.getinternet0380" />");
							
						}else if(errinfo.length!=0&&$('#c_p_address_ld option').size()>1&&$("#c_p_address_ld").val()==""){
							alert("<fmt:message key="phone.getinternet0380" />");
							
						}else if(errinfo.length!=0&&$('#c_p_address_dy option').size()>1&&$("#c_p_address_dy").val()==""){
						
							alert("<fmt:message key="phone.getinternet0380" />");
							
						}else if(errinfo.length!=0&&$('#c_p_address_mp option').size()>1&&$("#c_p_address_mp").val()==""){
						
							alert("<fmt:message key="phone.getinternet0380" />");
							
						}
				else
				{
					info = info.replace(new RegExp(",","g"),"");
					if(checkAddress(info))
					{
						alert("<fmt:message key="phone.getinternet0341" /> " + info + " <fmt:message key="phone.getinternet0014" />");
						return false;
					}
					$("#sAddressold").val(info);
					$("#c_p_address").hide('slow');
					//恢复显示
					$("#UserName1").css("display","block");
				}
				//alert($("select[id^='c_p_address']").size());
			});
			
			$("#c_p_address_bncancel").click(function(){
				$("#c_p_address").hide('slow');
				//恢复显示
				$("#UserName1").css("display","block");
			});
		}
		
		var resto="";
		function c_p_bindToAddr(idx,selid,param)
		{		     
			var res = fetchMultiArrayValue("AddressBox.query"+idx,6,param);
			var elems = ['xq','ld','dy','mp'];
			//alert(res[0] == undefined + ":" + res[0][0] == undefined);
			resto=res[0][0];
			if(res[0] == undefined || res[0][0] == undefined || res[0] == "")
			{
				for(var j=idx;j<=4;j++)
				{
					$("#c_p_address_"+elems[j-1]).empty();
					$("#c_p_address_"+elems[j-1]).append("<option value=\"\">--"+$("#getinternet0365").val()+"--</option>");
				}
				
				return false;
			}
			$("#"+selid).empty();
			$("#"+selid).append("<option value=\"\">--"+$("#getinternet0365").val()+"--</option>");
			var quanju="";
			for(var i=0;i<res.length;i++)
			{
			    var ee="<option value='"+res[i][0]+"'>"+res[i][1]+"</option>";	
			    quanju+=ee					
			}
			 $("#"+selid).html($("#"+selid).html()+quanju);
			//重置索引  > idx + 1 的下拉框
			for(var j=idx + 1;j<=4;j++)
			{
				$("#c_p_address_"+elems[j-1]).empty();
				$("#c_p_address_"+elems[j-1]).append("<option value=\"\">--"+$("#getinternet0365").val()+"--</option>");
			}
		  }
		
		function checkAddress(addr)
	    {
			var addrto = $("#c_p_address_mp").val();
	      	if(addrto!=null&&addrto!="")
	      	{
				var res = fetchSingleValue("Address.Check",6,"&Yhdz="+tsd.encodeURIComponent(addr)+"&YwArea=" + tsd.encodeURIComponent($("#userareaid").val()));
				if(res==undefined||res=='0')
				{
					return false;
				}
				else
				{
					return true;
				}
			}				
	    }
	    
	    /*******
	    *限制地址不能手动输入只能选择 地址输入框keyup
	    *@param;
	    *@return;
	    ********/
	    function notecheck()
	    {
				var notecheck = $("#sAddressold").val();
					if(notecheck.length>0){
					$("#sAddressold").val(notecheck.substr(0,0));
				}
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
					<div class="title" style="display: none;">
						&nbsp;&nbsp;
						<img src="style/icon/65.gif" />
						<fmt:message key="phone.getinternet0178" /><!-- 输入查询条件 -->
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
								</select>
							</td>
							<td>
								<input type="text" class="" id="ghSearchBox" name="ghSearchBox" />
							</td>
							<td>
								<button class="tsdbutton" id="submitButton"
									onclick="ghSearch()" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
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
						<fmt:message key="phone.getinternet0195" /><!-- 变更内容 -->
					</div>
					<div id="inputtext">
					    <table cellspacing="10px">
					    	<!--
					       <tr>
					         <td height="32">业务区域</td>
				             <td >
				              <select id="ywarea_dz" name="ywarea" onChange="getchangeywarea();" style="width:200px"></select>
				             </td>
				             <td height="32">营业区域</td>
				             <td >
				              <select id="area_dz" name="area" style="width:200px" ></select>
				             </td>
					       </tr>
					       <tr>
					         <td height="32">专（光）线路</td>
				             <td >
				              <input id="bz1new_yhdang" name="bz1_yhdang" style="width:200px"/>
				             </td>
				             <td height="32">区域端点</td>
				             <td >
				              <select id="Bz5new_yhdang" name="bz5_yhdang" style="width:200px" ></select>
				             </td>
					       </tr>
                                              -->
                          
					       <tr>
					         <td height="32"><fmt:message key="phone.getinternet0204" /><!-- 原用户地址 --></td>
				           <td >
				              <input type="text" id="sAddress" name="sAddress"  disabled="disabled" style="width:200px"/>
				           </td>
				           <td height="32"><fmt:message key="phone.getinternet0205" /><!-- 新用户地址 --></td>
				           <td>
				           <input type="text" id="sAddressold" name="sAddressold" style="width:200px" maxlength="25"  onpropertychange="TextUtil.NotMax(this)"/>
				              <font color="red">*</font>
				           </td>
					       </tr>
					       <%-- <tr>
					       	<td><fmt:message key="phone.getinternet0206" /><!-- 联系人 --></td>
					       	<td><input type="text" id="linkman" style="width:200px;" maxlength="25"  onpropertychange="TextUtil.NotMax(this)"/></td>
					       	<td><fmt:message key="phone.getinternet0207" /><!-- 联系电话 --></td>
					       	<td><input type="text" id="linktel" style="width:200px;" maxlength="16"  onpropertychange="TextUtil.NotMax(this)"/></td>
					       </tr> --%>
					       
					       <tr>
						         <td height="25">原业务区域</td>
					             <td >
					             	<input id="oldywarea" style="width:200px;" readonly="readonly"/>
					             </td>
					             <td>新业务区域</td>
					             <td >
					              <select id="newywarea" name="newywarea" style="width:200px" ></select>
					             </td>
					       </tr>
					       <tr>
						         <td height="25">原一级号线区域</td>
					             <td >
					             	<input id="oldmokuaiju" style="width:200px;" readonly="readonly"/>
					             </td>
					             <td>新一级号线区域</td>
					             <td >
					              <select id="newmokuaiju" name="newmokuaiju" style="width:200px" ></select>
					             </td>
					       </tr>
					       <tr style="display: none">
						         <td height="25">原二级号线区域</td>
					             <td >
					             	<input id="oldmokuaiju2" style="width:200px;" readonly="readonly"/>
					             </td>
					             <td>新二级号线区域</td>
					             <td >
					              <select id="newmokuaiju2" name="newmokuaiju2" style="width:200px" ></select>
					             </td>
					       </tr>
					       <tr style="display: none">
						         <td height="25">原三级号线区域</td>
					             <td >
					             	<input id="oldmokuaiju3" style="width:200px;" readonly="readonly"/>
					             </td>
					             <td>新三级号线区域</td>
					             <td >
					              <select id="newmokuaiju3" name="newmokuaiju3" style="width:200px" ></select>
					             </td>
					       </tr>
					       <tr style="display: none">
						         <td height="25">原四级号线区域</td>
					             <td >
					             	<input id="oldmokuaiju4" style="width:200px;" readonly="readonly"/>
					             </td>
					             <td>新四级号线区域</td>
					             <td >
					              <select id="newmokuaiju4" name="newmokuaiju4" style="width:200px" ></select>
					             </td>
					       </tr>
					    </table>
					</div>
				<!-- Removed by zhumengfeng at 2016/06/08 -->
				<!--出帐月余额/出帐月欠费 -->
				<!-- 	实施余额/实施欠费 -->
				<!-- 	电话功能 -->
				<!-- 	交换机编号 -->
				<!-- 	停机标志 -->
				<!-- 	
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<span id="feetdhypetext"></span>
				</div>
				<div id="inputtext">
						<div class="midd">
							<table>
								<tr>
									<td class="wenzi">
										<span id="spanyucunYE"></span>
									</td>
									<td class="wenzix">
										<input type="text" id="phoneBalance" name="phoneBalance"
											value="0" style="width: 150" disabled="disabled" />
									</td>
									<td class="wenzi">
										<span id="spanxinyueHF"></span>
									</td>
									<td class="wenzix">
										<input type="text" id="mothshuafei" name="mothshuafei"
											value="0" style="width: 150" disabled="disabled" />
									</td>
									<td class="wenzi">
										<span id="yhdang_tjbz"></span>
									</td>
									<td class="wenzix">
										<input type="text" id="Tjbz_yhdang" name="Tjbz_yhdang" style="width: 150"
											disabled="disabled" />
									</td>
								</tr>							
								<tr style="display:none">
									<td class="wenzi">
										<span id="spanDhgn"></span>
									</td>
									<td>
										&nbsp;<select name="Dhgn" id="Dhgn"
											style="width: 150"></select>
									</td>
									<td>
										<span id="spanJhj_IDx"></span>
									</td>
									<td>
										<input type="text" name="SwitchNumber" id="SwitchNumber"
											style="width: 150;display:none;" disabled="disabled" />
									</td>
									<td>
										<fmt:message key="phone.getinternet0181" />
									</td>
									<td>
										<select id="Tjbz_yhdang" name="Tjbz_yhdang"></select>							
									</td>
								</tr>
								<tr></tr>
							</table>
						</div>
					</div>
					-->
					<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0182" /><!-- 合同号信息显示-->&nbsp;
					<input type="checkbox" id="hthshowcheck" checked="checked" onClick="getshow()" style="width:15px;" />
					</div>
					<div id="inputtext">
						<div class="midd">
							<table id="tablehthdang" style="width:780px;">
							</table>
						</div>
					</div>	
					<div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/65.gif" />
						<fmt:message key="phone.getinternet0183" /><!--固话信息显示-->&nbsp;
						<input type="checkbox" id="yhdangshowcheck" checked="checked" onClick="getshow()" style="width:15px;" />
					</div>
					<div id="inputtext">
						<div class="midd">
							<table id="tableyhdang" style="width:780px;"></table>
						</div>
					</div>
				 <div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/65.gif" />
						<fmt:message key="phone.getinternet0184" /><!--固定费信息显示-->&nbsp;<input type="checkbox" id="gdfeeshowcheck" onClick="getshow()" style="width:15px;" /><span id="gdfeeTips" style="color:red"></span>
				  </div>
				  <table border="1" cellpadding="0" bordercolor="#9AC0CD" id="dhZFX" width="780">				          
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
					<fmt:message key="phone.getinternet0186" /><!--包月套餐信息显示-->&nbsp;<input type="checkbox" id="byfeeshowcheck" onClick="getshow()" style="width:15px;" /><span id="byfeeTips" style="color:red"></span>
					</div>
				 <table border="1" cellpadding="0" bordercolor="#9AC0CD" id="dhBYTC" width="780">
				 </table> 			  
				  <div class="title">
						&nbsp;&nbsp;						
						<img src="style/icon/65.gif" />
						<fmt:message key="phoneyewu.yewuggnmqr" /><!--业务更改内容确认--><span id="businesschangecontent" style="color:red;"></span>
				  </div>
				 <div id="inputtext2">
				 	<table cellspacing="0" width="760" id="businesschange">
				 		<tr>
				 			<td style="width:460px;">
				 				<table id="ffltab" style="width:460px;">
								<tr>
									 <td class="wenzi" style="width:100px;" type="hidden">
										<%-- <fmt:message key="phone.getinternet0090" /><!-- 付费方式 --> --%>
									</td>
									<td class="wenzix">
										<select name="cPayType" id="cPayType" style="visibility:hidden" class="you1" onChange="payWayChange(this)"></select>
									</td> 
									<td class="wenzi">
										<fmt:message key="phone.getinternet0091" /><!-- 应交合计 -->
									</td>
									<td class="wenzix">
										<input type="text" name="cYingJiao" id="cYingJiao" style="width: 130px;" disabled="disabled"  class="you1" onKeyPress="numValid(this)"
										onpaste="return !clipboardData.getData('text').match(/D/)" ondragenter="return   false"/>
								   </td>
								   <td>
								     <table id="dzhthcontent" style="width:320px;" border="1" cellpadding="0" bordercolor="#9AC0CD">
									   <tr>
											<th width="200">
										    	<center>
											    <h4>
											     <fmt:message key="phone.getinternet0092" /><!-- 业务受理费 -->
											    </h4>
											    </center>
											</th>
											<th width="100">
											    <center>
												<h4>
												<fmt:message key="phone.getinternet0093" /><!-- 费用金额 -->
												</h4>
												</center>
											</th>
										</tr>
									 </table>
									</td>	
								</tr>
								<tr>
									<td colspan="4" id="ywslfeename">
									<fmt:message key="phone.getinternet0094" /><!-- 一次性费用 -->：
									<div
									style="width:440px; height: 105px; overflow-y: scroll; overflow-x: hidden; border-top: 1px solid gray; border-left: 1px solid gray;border-bottom: 1px solid gray;">
									<div id="feeItem_s" style="width: 100%; float: left;">
									</div>
									</div>
									</td>
									<td valign="top">
									<table id="businessfee" style="width:320px;" border="1" cellpadding="0" bordercolor="#9AC0CD">
									
									</table>
									</td>
								</tr>	
								<tr>
									<td class="wenzi" style="display:none;">
										<fmt:message key="phone.getinternet0095" /><!-- 缴费款项 -->
									</td>
									<td colspan="3" class="wenzix" style="display:none;">
										<input type="text" name="cPayItem" id="cPayItem"
											style="width:260px" disabled="disabled" class="you1" />
									</td>
								</tr>
							</table>
						</td>
					</tr>
					</table>			    				    
				    <hr style="border: 1px dotted #CCCCCC;" />
				    <table style="background-color:#f7f7f7">
				       <tr>
				         <td>
						    <table cellspacing="5" style="display:none;">
								<tr>
									<td>
										<input type='checkbox' name="danweiHTHbox" id="danweiHTHbox"
											style="width: 22px; padding: 0px;" disabled="disabled" onClick="isnotdanwei()" />
									</td>
									<td>
										&nbsp;&nbsp;&nbsp;&nbsp;
										<font color="red"><fmt:message key="phoneyewu.isnotdwff" /><!-- 是否单位付费 --></font>
									</td>
									<td>
										<fmt:message key="phoneyewu.dwHTH" /><!-- 单位合同号 -->
									</td>
									<td>
										<input type="text" name="danweiHTH" id="danweiHTH"
											style="width: 150" disabled="disabled" />
									</td>
								</tr>
							</table>
				         </td>				        
				         <td>
				           <table cellspacing="8" style="background-color: white;">
				              <tr>
				                <!-- <td valign="top"> -->
				                <td valign="bottom">
				                   &nbsp;&nbsp;<fmt:message key="phone.getinternet0187" /><!--业务备注-->
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
				  <div class="title" style="display:none;">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif"  />
					设置工单发送部门
				</div>
				<table cellspacing="5" style="display:none;">
					<tr>
						<td>
							发送部门
						</td>
						<td>
							<select id="fsbm" style="width:150px;"></select>
						</td>
				    </tr>
				</table>
			</div>
	       <div id="buttons">
			<center>				
				<button id="save" onClick="updateAddress()"
					style="margin-left: 20px;">
					<!-- 确定 -->
					<fmt:message key="Revenue.Save"/>
				</button>
				<button id="reset" onClick="pageReset()" style="margin-left: 20px;">
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
						<fmt:message key="phone.getinternet0188" /><!--单位合同号查询-->
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onClick="javascript:$('#operformClose').click();"><fmt:message key="phone.getinternet0189" /><!--关闭--></a>
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
				<fmt:message key="phone.getinternet0189" /><!--关闭-->
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
						<fmt:message key="phone.getinternet0208" /><!--电话移机业务用户信息查询-->
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onClick="javascript:$('#kdMultiSearchClose').click();"><fmt:message key="phone.getinternet0189" /><!--关闭--></a>
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
				<fmt:message key="phone.getinternet0189" /><!--关闭-->
			</button>
		</div>
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
	<input type="hidden" id="useridright" name="useridright"/>
	<input type="hidden" id="feenameid" name="feenameid"/>	
	<input type="hidden" id="inputDWHTH" name="inputDWHTH"/>	
	<input type="hidden" id="Subtype" name="Subtype"/>
	<input type="hidden" id="reportparam" />
	<input type="hidden" id="jobidid" />
	<input type="hidden" id="ppaytype" />
	<input type="hidden" id="fee" />
	<input type="hidden" id="addressinputright"/>
	<input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->
	<input type="hidden" id="yjfeehidden"/><!-- 页面获取应缴费存入隐藏于中 -->
	<input type="hidden" id="fufeitypepath"/>
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->	
	<input type="hidden" id="stiffbusinestype" value="phoneDZ"/><!-- 电话工单打印类型 -->
	<input type="hidden" id="Prefeeval"/><!-- 预测金额打印票据时判断 -->
	<input type="hidden" id="businesstype" value="p_movephone"/><!-- 该页面的业务类型 -->		
	<jsp:include page="phone_internet.jsp" flush="true"/>
	</body>
</html>
