<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/phonestopopenpay.jsp
    Function:   电话申请停复机
    Author:     wenxuming
    Date:       2010-10
    Description: 
    Modify: 
     2010-10月份 对该页面进行移植，并对版式进行修改；
     2010-11-03 把公用的CSS提取出来放到style/css/telephone/business/businesspublic.css；
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
	String username = (String) session.getAttribute("username");
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
	//项目名称
	String  custom = (String) session.getAttribute("custom");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>My JSP 'PhonemoveAddress.jsp' starting page</title>
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
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />	
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>		
		<script src="script/public/phoneservicenew.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservice.js" type="text/javascript" language="javascript"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->			
		<!-- 辅助js you -->
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/telephone/business/businesspublic.js" type="text/javascript" language="javascript"></script>
		<!-- 打印报表弹出窗口 -->
		<script src="script/telephone/business/businessreprint.js" type="text/javascript" language="javascript"></script>
		<script src="script/telephone/business/phone_kjbq_gh.js" type="text/javascript"></script>		
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
		<!--设置全局字体大小-->
		<link href="style/css/telephone/business/fontsize_all.css" rel="stylesheet" type="text/css"/>
		<script type="text/javascript">
		/***************
		加载页面
		***************/
       jQuery(document).ready(function()
	   {
    	   //中石油定制处理合计金额 modify 2015-12-11
    	   $("#cYingJiao").click(function(){
	    		var PauseMonth = $("#PauseMonth").val();//停机月份数
	    		var cYingJiao = $("#cYingJiao").val();//应缴费
	    		if(cYingJiao==0){
	    			$("#cYingJiaoHJ").val(0 );
	    		}else{
	    			PauseMonth = parseFloat(PauseMonth,10);//  		 
	    			cYingJiao = parseFloat(cYingJiao,10);//
	    			$("#cYingJiao").val(cYingJiao * PauseMonth );
	    		}	    		
	    	});	
    	   
    	   $("#navBar").append(genNavv());	//生产目前所在位置
		    getinternation();	//businesspublic.js中  自动加载显示框	    
		    PageInitial();					//页面初始化 
		    ghPayMoney('p_reservephone');//通过申请停服机标识来查询一次性费用
		    gethide("p_reservephone");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数
		    addspeediFeeType('');
		    getfufeitype();//付费类型		    
			//getTJLogo(); 	    
		    $("#ghSearchBox").select();		//设置该控件选中
		    $("#ghSearchBox").focus();		//设置该控件获焦点		
		    $("#tablehthdang select").attr("disabled","disabled");
			$("#tablehthdang :text").attr("disabled","disabled");
			$("#tableyhdang select").attr("disabled","disabled");
			$("#tableyhdang :text").attr("disabled","disabled");
		   //打开加载页面时执行次存储过程
	    	var userid = $("#userid").val(); //获取session中的工号	    
	    	userid ="&userid="+encodeURIComponent(userid);
	    	var tsdpkstr = 'phoneTk.openPage';
	    	//openPage(userid,tsdpkstr);
	    	isDisableBut();//月杂费 包月套餐保存 删除按钮不可用	   	
			
			$("#yytime").focus(function(){
				WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
			});
			$("#yytime,#yytext").hide();
			$("#isnotyy").click(function(){
				if($("#Dh_yhdang").val()==""){			
					alert("请查询一个电话用户！");
					$("#ghSearchBox").select().focus();
					$("#isnotyy").removeAttr("checked");
					return;
				}
				if($("#isnotyy").attr("checked")){
					$("#yytime,#yytext").show();
				}else{
					$("#yytime,#yytext").hide();
				}	
				$("#yytime").val("");
			});				
			$("#yjfeeright").val("false"); // 中石油项目定制设置为false modify2015-12-11
	   }); 
		
     	//判断该用户是否已经结清话费  modify 2015-12-09 中石油增加判断费用是否结清
		function isCanStop(Dh)
		{
			var res = fetchMultiArrayValue("phonestopopenpay.qianfei",6,"&Dh="+Dh+"&dhfee="+tsd.encodeURIComponent("电话费"));
			if(res[0][0] != 0)
			{
				alert("请到营收管理页面结清话费");
				return false;
			}
		}
	   	   
	   /*******
	   	* 从真实姓名对应的多个账户中选择要查询的账户
	   	* @param:Yhmc用户名称，Dh用户电话，Yhdz用户地址;
	   	* @return;
	  	********/
		function userChoose(Yhmc,Dh,Yhdz)
		{	
		    alert("请到营收管理结清费用后，再进行停机操作！");
			var result = fetchMultiPValue("PhoneDH.ifCanSouLi",6,"&OperID=" + tsd.encodeURIComponent($("#userid").val()) + "&Ywlx="+tsd.encodeURIComponent("p_reservephone")+"&NowYwArea="+tsd.encodeURIComponent($("#area").val())+"&Dh="+Dh+"&Func=0"+"&Hth="+$("#Hth").val());
			if(result[0] != undefined && result[0][0] != "")
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
			$("#sAddress").val(Yhdz);	
			ghSerBasicInfo(Dh);
			getPauseTime(Dh);//得到负机时间	
			addspeediFeeType(Dh);
			ghZF(Dh);
			////gethTC(Dh);
			////getdhBYTC(Dh);
		setTimeout("getPauseStatus()",100);//根据停机标志来显示页面可办理业务类型
			setTimeout("getfeename('')",200);//根据可办理业务类型类显示可选择的包月套餐
		getphonefeenameTF();//生成固话月杂费中费用名称的下来选框 
			//getPackagetypeTF();//生成包月套餐费的套餐类型下来选框
		removeDisableBut();//月杂费 包月套餐费保存 删除按钮可用
			setStartTime();
			//$("#PauseEndTimenew").val("2999-12-31 00:00:00");
			
			/**********
			用于将固话杂费，包月套餐保存到临时表中
			业务受理选择了电话号之后调用一下过程
			参数: afterDhSelect 'userid=工号;dh=电话'
			phone  hth  userid
			*************/
			//var hth = $("#hth").val();
			var phone = $("#Dh_yhdang").val();			
			var userid = $("#userid").val();			
			var paramsN = "&params="+ encodeURIComponent("userid="+userid+";dh="+ phone);
			//var tsdpkstr = 'phonestopopenpay.afterDhSelect';
			//openPage(paramsN,tsdpkstr);							
			//存储过程执行
			var params = endbuildParams();
			//params += ";Ywlx=申请停复机;Func=0";			
			params += ";Ywlx=<fmt:message key="phone.getinternet0426" />;Func=0";
			//exeYwslIfCanSouliTF(params);
			//根据权限来设置是否可以修改月租信息
			if($("#selFixedFeeright").val()=="true"){
				
			}else{
				$("#phonefeenamecontent").empty();
				$("#dhzftab").attr("disabled","disabled");
				$("#dzhthcontent").attr("disabled","disabled");
			}
			setTimeout($.unblockUI,1);				
		

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
	   	* 拼接参数
	   	* @param;
	   	* @return;
	  	********/
		function endbuildParams(){
			//每次拼接参数必须初始化此参数
			tsd.QualifiedVal=true;				
		 	var params='';		 	
		 	var phone = $("#Dh_yhdang").val();
			var hth = $("#Hth").val();
			var userid = $("#userid").val();			
			params = "Hth="+hth+";dh="+phone+";OperID="+userid;						
		 	//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
			return params;
		}	
				
		/*******
	   	* 给起始日期如初始值
	   	* @param;
	   	* @return;
	  	********/
		function setStartTime(){
			$("#ZFStartday").val("<%=nowTimeto %>");
			$("#TCStarttime").val("<%=nowTimeto %>");
		}
				
		/*******
	   	* 月杂费 套餐费用保存 删除按钮可用性设置
	   	* @param;
	   	* @return;
	  	********/
		function isDisableBut(){
			$("#dhzfsave").attr("disabled","disabled");
			$("#dhzfdel").attr("disabled","disabled");
			$("#bytcadd").attr("disabled","disabled");
			$("#bytcdel").attr("disabled","disabled");
		}
		function removeDisableBut(){
			//dhzfsave  dhzfdel
			//bytcadd  bytcdel
			$("#dhzfsave").removeAttr("disabled");
			$("#dhzfdel").removeAttr("disabled");
			$("#bytcadd").removeAttr("disabled");
			$("#bytcdel").removeAttr("disabled");			
		}
				
		/*******
	   	* 限制地址不能手动输入只能选择
	   	* @param;
	   	* @return;
	  	********/
        function notecheck(){
			 	var notecheck = $("#sAddress").val();
			    if(notecheck.length>0){
			    	 $("#sAddress").val(notecheck.substr(0,0));
			    }
		}
		
		/*******
	   	* 更具获取的用户停复机状态来判断用户所能办理状态，同时显示对应信息
	   	* @param;
	   	* @return;
	  	********/
		function showStatusf(){
			var tfjstatus = $("#tfjstatus").val();
			if(tfjstatus==''||tfjstatus==undefined||tfjstatus=='K'){
				
			}
			else if(tfjstatus=='T'){
				
			}
		}
    </script>
    
    <script type="text/javascript">
    	/*******
	   	* 取出用户信息显示对应的可编辑框
	   	* @param:Dh电话，tfjstatus停机标志;
	   	* @return;
	  	********/
    	function getPauseStatus(){
    		var str='';
    		var tfjstatus = $("#tfjstatus").val();
    		$("#tfjstatusnew").empty();
    		if(tfjstatus=="K"||tfjstatus=="QK"||tfjstatus=="QDT"||tfjstatus=="QT"||tfjstatus=="QDK"||tfjstatus=="YK"){ 
    			
    			str+="<option value='p_reservephone'><fmt:message key="phone.getinternet0247" /></option>";  //停机保号  
    			//根据权限来得到是否可以办理限呼保号业务
    			if($("#hasLimitright").val()=="true"){
    				//str+="<option value='p_limitphone'>限呼保号</option>";
    				//str+="<option value='p_limitphone'><fmt:message key="phone.getinternet0248" /></option>";
    			}
    			$("#tfjstatusnew").append(str);
    			$("#fuji1").hide();
    			$("#tingji2").show();			
    		}else if(tfjstatus=="T"||tfjstatus=="DT"){
    			
    			str+="<option value='p_openphone'><fmt:message key="phone.getinternet0470" /></option>"; //复机
    			str+="<option value='continue'><fmt:message key="phone.getinternet0250" /></option>"; //继续保号
    			$("#tfjstatusnew").append(str);
    			getPauseTime(Dh);//显示已经处于停机状态的电话的停复机时间
    			$("#fuji1").show();
    			$("#fuji11").hide();
    			$("#fuji12").show();
    			$("#tingji2").hide(); 
    			$("#feeItem_s").hide(); // 增加复机业务时自动把停机保号一次性费用隐藏 201512 modify by zxy
    		}
    		else{
    			$("#fuji1").hide();
    			$("#tingji2").hide();
    			$("#feeItem_s").hide(); //增加查询后如果没有业务类型一次费用不显示 201512 modify by zxy
    		}
			defPauseStopTime();
    		
    	}
	  	
    	function statusChange(){    	
    			var tfjstatusnew = $("#tfjstatusnew").val();
    			if(tfjstatusnew=="p_openphone"){
    				$("#fuji1").show();
	    			$("#fuji11").hide();
	    			$("#fuji12").show();
	    			$("#tingji2").hide();
	    			
	    			$("#feeItem_s").hide();  // 增加复机业务把停机保号一次性费用隐藏 201512 modify by zxy
	    			$("#feeItem_s input[type=checkbox]:checked").each(function(index) { 
	    				
	    				alert($(this).attr("id")); 
	    				var key = $(this).attr("id");
	    				deletebusinessfee(key);
	    				$(this).attr("checked",false);
	    				
	    			});
	    			
    			}else if(tfjstatusnew=="continue"){
    				$("#fuji1").show();
	    			$("#fuji11").show();
	    			$("#fuji12").show();
	    			$("#tingji2").show();
	    			$("#feeItem_s").show(); // 增加停机业务时把停机保号一次性费用显示 201512 modify by zxy
    			}else if(tfjstatusnew=="p_reservephone"){
					getPauseStatus();	
				}
    			getfeename($("#tfjstatusnew option:selected").text());
    			/*
    			else{
	    			$("#fuji1").hide();
	    			$("#tingji2").hide(); 
    			} */					
    	}
    	
    	function getPauseTime(Dh){
    			var urlstr=tsd.buildParams({  
							  packgname:'service',//java包
							  clsname:'ExecuteSql',//类名
							  method:'exeSqlData',//方法名
							  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
							  tsdcf:'mssql',//指向配置文件名称
							  tsdoper:'query',//操作类型 
							  datatype:'xmlattr',//返回数据格式 
							  tsdpk:'phonestopopenpay.gettjDate'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							});	
					$.ajax({
						url:'mainServlet.html?'+urlstr+"&Dh="+Dh,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值
							$(xml).find('row').each(function(){							
								//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
								///如果sql语句中指定列名 则按指定名称给参数								
								var PauseStartTime = $(this).attr("pausestarttime");							
								$("#PauseStartTime").val(PauseStartTime);			
								var PauseEndTime = $(this).attr("pauseendtime");
								$("#PauseEndTime").val(PauseEndTime);								
							});
						}
					});
    			
    	}
    	
    	/*******
	   	* 设置最新复机日期，因为月份天数可能有31 30 28 29 几种方式，不能用单纯的月份数增加来计算最新复机日期。
	   	* @param;
	   	* @return;
	  	********/
    	function getPauseStopTime()
		{
			var pime = $("#PauseMonth").val();
			if(pime=="0"){
			   $("#PauseEndTimenew").val("2999-12-31 00:00:00");
			   return ;
			}
			var tfjstatus = $("#tfjstatus").val();
			var res = "";
			if(tfjstatus=="K"||tfjstatus=="QK"||tfjstatus=="QDT"||tfjstatus=="QT"||tfjstatus=="QDK")
			{
				res = fetchSingleValue("phonestopopenpay.getDate",6,"&mon="+$("#PauseMonth").val());
			}
			else
			{
				res = fetchSingleValue("phonestopopenpay.addDate",6,"&mon="+$("#PauseMonth").val()+"&Dh="+$("#Dh_yhdang").val());
			}
			if(res==""||res==undefined)
			{
				return "";
			}
			else
			{
				$("#PauseEndTimenew").val(res);
				return res;
			}
		}
		//默认停机月为三个月
    	function defPauseStopTime()
		{
			var pime = $("#PauseMonth").val();
			if(pime=="0"){
			   $("#PauseEndTimenew").val("2999-12-31 00:00:00");
			   return ;
			}
			var tfjstatus = $("#tfjstatus").val();
			var res = "";
			if(tfjstatus=="K"||tfjstatus=="QK"||tfjstatus=="QDT"||tfjstatus=="QT"||tfjstatus=="QDK")
			{
				res = fetchSingleValue("phonestopopenpay.getDate",6,"&mon="+$("#PauseMonth").val());
			}
			else
			{
				res = fetchSingleValue("phonestopopenpay.addDate",6,"&mon="+$("#PauseMonth").val()+"&Dh="+$("#Dh_yhdang").val());
			}
			if(res==""||res==undefined)
			{
				return "";
			}
			else
			{
				$("#PauseEndTimenew").val(res);
				return res;
			}
		}

		/*******
	   	* 获取参数
	   	* @param;
	   	* @return;
	  	********/
		function SbuildParams(){
			//每次拼接参数必须初始化此参数
			tsd.QualifiedVal=true;				
		 	var params='';
		 	/*
				area	depart userid phone qjtkj ableTo cIsPay cPayType cYingJiao cShiShou  
				cPayItem  cLianXiRen  cLianXiDianHua danweiHTHbox   danweiHTH  
				phonepkBz
			*/			
			
			var phone = $("#Dh_yhdang").val();//电话
			if(phone==""||phone==null){
		 		//alert("请选择要办理该项业务的电话号码");
				alert("<fmt:message key="phone.getinternet0176" />");
		 		$("#ghSearchBox").focus();
		 		return false;
		 	}
			var area = $("#area").val();//区域			
			var depart = $("#depart").val();//部门			
			var userid = $("#userid").val();//工号	
			var ywarea = $("#YwArea_yhdang").val();//业务区域  中石油定制 2015-12-17
			
			//当前状态 tfjstatus	
			var tfjstatus = $("#tfjstatus").val();			
			
			//可办理业务	tfjstatusnew
			var tfjstatusnew = $("#tfjstatusnew").val();
			if(tfjstatusnew==""){
				//alert("请选择可办理业务。");
				alert("<fmt:message key="phone.getinternet0251" />");
				$("#tfjstatusnew").focus();
				return false;				
			}		
			var PauseMonth = $("#PauseMonth").val();//停机月份数
			/*
			if(PauseMonth==''&&tfjstatusnew=='T'){
				alert("请选择停机月份数");
				$("#PauseMonth").focus();
				return false;
			}*/
			
			var cPayType = $("#cPayType").val();//付费方式					
		 	
		 	//至少选择一个一次性费用项目
		 	var items = $("#feeItem_s table input[type='checkbox'][checked]");
		 	/*
		 	if(items.length<=0&&ywlx=='tj'){
		 		alert("请选择一次性费用项目。");
		 		$("#feeItem_s table input[type='checkbox']").focus();
		 		return false;
		 	}*/
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
			//联系人
			var cLianXiRen = $("#Bz8_yhdang").val().replace(/(^\s*)|(\s*$)/g,"");			
			//联系电话
			var cLianXiDianHua = $("#Bz9_yhdang").val().replace(/(^\s*)|(\s*$)/g,"");
			//备注
			var phonepkBz = $("#phonepkBz").val().replace(/(^\s*)|(\s*$)/g,"");
			//月租是否提示必选
			/* var resYZ = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&tablename=tsd_ini&cloum=tvalues&key=tsection='phonebusiness' and tident='selectMonthlyRent'"); 
			if(resYZ==""||resYZ==undefined||resYZ=="Y"){
				if(isXinYeWuExists(phone)=="0"&&resYZ!='Y')
				{
					//alert("至少应该添加一项月租费");
					alert("<fmt:message key="phone.getinternet0034" />");
			   		return false;
				}
			}	 */
			/* if($("#isnotyy").attr("checked")==true&&$("#yytime").val()==""){
				$("#yytime").select().focus();
				alert("请输入预约时间");
				return false;
			} */
			
			
			var userareaid = $("#userareaid").val();
			//params+="&lxr_tj="+tsd.encodeURIComponent($("#lxr_tj").val().replace(/(^\s*)|(\s*$)/g,""));
			//params+="&lxdh_tj="+tsd.encodeURIComponent($("#lxdh_tj").val().replace(/(^\s*)|(\s*$)/g,""));
			//params+="&yytime="+tsd.encodeURIComponent($("#yytime").val());
			params+="&yytype="+tsd.encodeURIComponent($("#isnotyy").attr("checked"));
			params+="&Area="+encodeURIComponent(area);
			params+="&ywarea="+encodeURIComponent(ywarea); //业务区域 中石油定制 2015-12-17
			params+="&userarea="+encodeURIComponent(ywarea);
			//params+="&userarea="+encodeURIComponent(userareaid);
			params+="&Depart="+encodeURIComponent(depart);
			params+="&UserID="+encodeURIComponent(userid);
			params+="&username="+encodeURIComponent('<%=username%>');
			params+="&Dhh="+phone;
			params+="&ispay="+encodeURIComponent(cPayType);
			params+="&yjfee="+encodeURIComponent(cYingJiao);
			params+="&sjfee="+encodeURIComponent(cYingJiao);
			//params+=";sjfee="+cShiShou;
			params+="&feename="+encodeURIComponent(cPayItem);
			params+="&lxr="+encodeURIComponent(cLianXiRen);
			params+="&lxdh="+cLianXiDianHua;	
			params+="&zwbz="+encodeURIComponent(phonepkBz);	
			//params+="&zwbz=encodeURIComponent((业务类型："+tfjstatusnew+")(原状态："+$("#tfjstatus_zh").val()+"))";
			params+="&zwbz=encodeURIComponent((<fmt:message key="phone.getinternet0252" />："+tfjstatusnew+")(<fmt:message key="phone.getinternet0253" />："+$("#tfjstatus_zh").val()+"))";
			params+="&ywlx="+tfjstatusnew;
			params+="&mons="+encodeURIComponent(PauseMonth);								 	
	 		//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
			return params;
		}
		
		/*******
	   	* 点击保存调用过程办理该业务
	   	* @param;
	   	* @return;
	  	********/
		function isValiableddd(){
			var params = SbuildParams();
			
			if(params==false){return false;}
			
/* 				//urlstr+="&params="+encodeURIComponent(params);
				//每次拼接参数必须添加此判断
				var queryStopYZ=fetchSingleValue("dbsql_phone.attachfee_queryStopYZ",6,"");
				var res = fetchSingleValue("dbsql_phone.attachfee_tmpnewtjxh",6,"&dh="+$("#Dh_yhdang").val()+"&feetype="+encodeURIComponent($("#tfjstatusnew option:selected").text()));
				if(queryStopYZ=="Y"&&res=="0"&&$("#tfjstatusnew option:selected").text()=="<fmt:message key="phone.getinternet0247" />"){
					//alert("请选择停机保号月租");
					alert("<fmt:message key="phone.getinternet0254" />");
					return;
				}else if(res=="0"&&$("#tfjstatusnew option:selected").text()=="<fmt:message key="phone.getinternet0248" />"){
					//alert("请选择限呼保号月租");
					alert("<fmt:message key="phone.getinternet0255" />");
					return;	
				}
				var resYZ = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&tablename=tsd_ini&cloum=tvalues&key=tsection='phonebusiness' and tident='selectMonthlyRent'"); 
				if(resYZ==""||resYZ==undefined||resYZ=="Y"){
					if(isXinYeWuExists($("#Dh_yhdang").val())==0)
					{
						//alert("至少应该添加一项月租费");
						alert("<fmt:message key="phone.getinternet0034" />");
						$("#phonefeetype").select();
						$("#phonefeetype").focus();
				   		return false;
					}
				}	 
				
				if($("#isnotyy").attr("checked")==true&&$("#yytime").val()==""){
					$("#yytime").select().focus();
					alert("请输入预约时间");
					return;
				}*/
				
				if(tsd.Qualified()==false){return false;}
				//调用申请停复机过程
				var result = fetchMultiPValue("phonestopopenpay.ywslst",6,params);
				if(result[0]==undefined || result[0][0]==undefined || result[0][0]=='-1')
				{
					//alert("办理申请停复机业务失败");
					alert("<fmt:message key="phone.getinternet0256" />");
				}
				else
				{
					var tifee = 0; //提前复机产生的复机费余额
					if(result[0][0]=="yyscsess"){
						alert("预约受理成功！");						
					}else{
						//保存用于打印账单的信息
						$("#jobidid").val(result[0][0]);
						tifee = (result[0][1]);
						
						$("#fee").val($("#cYingJiao").val());
						$("#cPayItemy").val($("#cPayItem").val());
						$("#cPayTypey").val($("#cPayType").val());
						//判断是否打印工单，从tsd_ini表中配置Y为打印
						printworkorder('p_reservephone');//script/telephone/business/businessreprint.js中
						var paramsstr = '';
					}
					$("#kdSearchBox").select();
					$("#kdSearchBox").focus();					
					//paramsstr = "&params="+ encodeURIComponent(params+";Ywlx=申请停复机;Func=1");
					paramsstr = "&params="+ encodeURIComponent(params+";Ywlx=<fmt:message key="phone.getinternet0426" />;Func=1");					
					openPage(paramsstr,'phoneTk.YwslIfCanSouli');
					clernull();
					//重置页面信息	
					//写入日志操作 JhjID	JhjName	JhjArea	Bz
					//var str ="过程：ywsl_st"+"<fmt:message key='global.conditions'/> : "+params;
					var str ="<fmt:message key="phone.getinternet0427"/>：ywsl_st"+"<fmt:message key="global.conditions"/> : "+params;
					str = transferApos(str);
					$("#yytime").val("");
					$("#yytime,#yytext").hide();
					$("#isnotyy").removeAttr("checked");
					writeLogInfo("","modify",encodeURIComponent(str));
					
					/* if (tifee > 0) {
						if (confirm("当前用户为提前复机需退费 "+tifee+" 元,是否立即进行营收.")) {
							parent.Ext.app.tsd.clickNodeById(4089);
						}
					} */
					
					//阻止默认行为执行
					return false;
			
				}
		}

		/*******
	   	* 重置页面信息
	   	* @param;
	   	* @return;
	  	********/
		function clernull(){
			$(":text").val("");
			$("#tablehthdang :text").val("");
        	$("#tablehthdang select").val("");
        	$("#tableyhdang :text").val("");
        	$("#tableyhdang select").val("");             	        
        	getfeename('');
			//业务备注框
			$("#phonepkBz").val("");
			//杂费项
			$("#dhZFX").empty();
			//套餐项
			$("#dhTCX").empty();
			$("#dhBYTC").empty();
			$("#fuji1").hide();
			$("#tingji2").hide();
			$("#new").hide();
			$("#PauseMonth").val("");
			$("#danweiHTHbox").removeAttr("checked");			
			$("#ghSearchBox").val("");
			var dd = $("#dhzftab tr:gt(0)");		
			dd.remove();
			var dd = $("#bytctab tr:gt(0)");		
			dd.remove();
			//PageInitial();
			ghPayMoney('p_reservephone');//通过申请停服机标识来查询一次性费用			
			$("#fuji1").hide();
   			$("#tingji2").hide();
   			//选择合同号
   			$("#danweiHTHbox").attr("disabled","disabled");			
   			//清空费用名称下拉列表   			
   			$("#phonefeename").html("");
   			//清空套餐类型下拉列表
   			//$("#Packagetype").html("");
   			$("#tfjstatusnew").empty();
   			isDisableBut();//月杂费 包月套餐保存 删除按钮不可用
   			$("#staff_bm").val("").trigger("change");   			
   			$("#phonefeenamecontent").empty();
   			gettable();//默认加载固定费表格现实phone_kibq_gh.js函数中		
   			gethide("p_reservephone");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数
			$("#lxr_tj").val("");
			$("#lxdh_tj").val("");
   			unLockDh();   			
		}				
        	
        	function cjkEncode(text) {   
        	    if (text == null) {   
        	        return "";   
        	    }   
        	 var newText = "";   
        	    for (var i = 0; i < text.length; i++) {   
        	        var code = text.charCodeAt (i);    
        	        if (code >= 128 || code == 91 || code == 93) {//91 is "[", 93 is "]".   
        	            newText += "[" + code.toString(16) + "]";   
        	        } else {   
        	            newText += text.charAt(i);   
        	        }   
        	    }   
        	 return newText;   
        	}
        
        /*******
		 * 根据费用类型取子项目
		 * @param;
		 * @return;
	     ********/
        function getfeename(tfjstatusnewkey)
        {
        	if(tfjstatusnewkey==""){
        		tfjstatusnewkey = $("#tfjstatusnew option:selected").text();
        	}
        	
        	var urlstr=tsd.buildParams({ 
    										packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',//返回数据格式 
						 					tsdpk:'dbsql_phone.queryattachpricetjfeetype'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					});	
				var ghzfzfx='';
				//if(tfjstatusnewkey=="恢复保号"){
				if(tfjstatusnewkey=="取消保号"){				
					tfjstatusnewkey='';    
				}
				//if(tfjstatusnewkey=="继续保号"){
				if(tfjstatusnewkey=="<fmt:message key="phone.getinternet0258" />"){
					//tfjstatusnewkey='停机保号';
					tfjstatusnewkey="<fmt:message key="phone.getinternet0247" />";
				}
				// 增加对没有业务类型时月租全部查出的处理，更改完成后没有月租配置的业务类型将不会只有月租类型显示 20151218 modify 
				if(tfjstatusnewkey==""){				
					tfjstatusnewkey='-';    
				}
				
				$("#phonefeenamecontent").empty();
				
				$.ajax({
					url:'mainServlet.html?'+urlstr+"&feetype="+tsd.encodeURIComponent(tfjstatusnewkey),					
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
							$(xml).find('row').each(function(){
								if($(this).attr("feetype")!=undefined){
		                 			ghzfzfx +="<tr onClick=\"getGHfeetr('"+$(this).attr("feetype")+"');getGHcsnum('"+$(this).attr("csnum")+"');\" id=\""+$(this).attr("feetype")+"\"><td>";
		                 			ghzfzfx +="☞"+$(this).attr("feetype");
		                 			ghzfzfx +="</td></tr>";
		                 		}
							});
							if (ghzfzfx != ""){
								$("#phonefeenamecontent").append(ghzfzfx);
								$("#attachfee").show();
							}else{
								$("#attachfee").hide();
								}
							
					}
				});
				$("#feelv").val("");
				$("#TJfeelv").val("");	
        }
        
        /*******
        *单击选中一行固话杂费
        *@param：key子费用名称
        *@return
        ********/
        function getGHfeetr(key){        	
        	$("#phonefeenamecode").val(key);
        	getfeenameall();        	
        	$("#phonefeenamecontent tr").css('background-color','#ffffff');
		      document.getElementById(key).style.background='#0080FF';  
        }
        
        /*******
		 * 选择费用名称
		 * @param;
		 * @return;
	     ********/
	    function getfeenameall()
        {
           var phonefeename = $("#phonefeenamecode").val();
           //alert(phonefeename);         
           if(phonefeename=="")
           {
              $("#feecode").val("");
              $("#Subtype").val("");
              $("#feelv").val("");
              $("#TJfeelv").val("");
              $("#ZFStartday").val("");
              $("#ZFEnday").val("");
              return false;
           }
            var feename = $("#phonefeetype option:selected").text();
            if($("#phonefeetype").val()==""){
           		feename="";
           	}
           //取费用项信息           
           var res = fetchMultiArrayValue("phonelnstalled.queryfeenameall",6,"&FeeType="+tsd.encodeURIComponent(phonefeename)+"&vfeename="+tsd.encodeURIComponent('月租'));
           var FeeCode = res[0][0];
           var FeeName = res[0][1];
           var Price = res[0][3];
           var TjPrice = res[0][4];
		   var CUNIT = res[0][5];
           $("#feecode").val(FeeCode);
           $("#Subtype").val(FeeName);
           $("#feelv").val(Price);
           $("#TJfeelv").val(TjPrice);
		   $("#CUNIT").val(CUNIT);
        }  
        
        /*******
		  	* 选中所有的电话杂费项
		  	* @param;
		  	* @return;
	      	********/
		    function Dhzf_CheckAll()
		    {
		    	if($("#dhzftab_checkall").attr("checked"))
	        		$("input[id^='v_dhzftab_check']").attr("checked","checked");
	        	else
	        		$("input[id^='v_dhzftab_check']").removeAttr("checked");
		    }
		    		    
		    /*******
		  	* 删除列表中的电话费用杂费信息
		  	* @param;
		  	* @return;
	      	********/
		    function deletephonefeename()
		    {	
				var checkedDhzf = $("input[id^='v_dhzftab_check'][checked]");
	        	var count = $(checkedDhzf).size();	        	
	        	if(count<1)
	        	{
	        		//alert("请选择要删除的杂费项信息");
	        		alert("<fmt:message key="phone.getinternet0138" />");
	        		return false;
	        	}	        	
	        	var dh = $("#Dh_yhdang").val();
	        	var feetype = "";	        	
	        	var result = true;
	        	var resultTmp = false;	        	
	        	for(var i=0;i<count;i++)
	        	{
	        		feetype = $(checkedDhzf[i]).parent().parent().next().text();
	        		//alert(feetype);
	        		resultTmp = executeNoQuery("phonelnstalled.deletephonefeename",6,"&FeeType="+tsd.encodeURIComponent(feetype)+"&Dh="+dh);
	        		
	        		if(resultTmp=="false" || resultTmp==false)
	        		{
	        			//alert("删除杂费失败");
	        			alert("<fmt:message key="phone.getinternet0139" />");
	        			result = false;
	        		}
	        	}
	        	/*
	        	if(result)
	        	{
	        		alert("删除杂费成功");
	        	}
	        	else
	        	{
	        		alert("删除杂费失败");
	        	}*/
	        	$("#phonefeenamecode").val("");
        	    $("#phonefeenamecontent tr").css('background-color','#ffffff');
	        	//重新加载数据
	        	addspeediFeeType(dh);
		    }
        
        /*******
        *单击选中一行固话杂费表获取参数数量值来显示页面显示几个参数个数框
        *@param：key参数数量值csnum
        *@return
        ********/
        function getGHcsnum(key){
        	var strtable="";
        	if(key==undefined||key==""||key=="null"){
        		key=0;
        	}
        	$("#keyhidden").val(key);
        	$("#ghfeeinput").empty();
        	var startdate = $("#startdate").val();        	
        	strtable +="<tr>";
        	strtable +="<td>"+$("#getinternetstarttime").val()+"</td>";
					strtable +="<td><input type='text' id='ZFStartday' name='ZFStartday' style='width: 100px;' disabled='disabled'/></td>";
					strtable +="<td>"+$("#getinternetermination").val()+"</td>";					
					strtable +="<td><input type='text' id='ZFEndday' name='ZFEndday' style='width: 100px;' disabled='disabled' value='2999-12-31'  /></td>";
					strtable +="<td>设备数量</td>";
					strtable +="<td><input type='text' id='DEVNUM' name='DEVNUM' style='width:70px;' value='1' onkeypress='return event.keyCode>=4&&event.keyCode<=57'/></td>";
					strtable +="<td>单位长度</td>";
					strtable +="<td><input type='text' id='DEVLENGTH' name='DEVLENGTH' style='width:70px;' value='1' onkeypress='return event.keyCode>=4&&event.keyCode<=57'/></td>";
					strtable +="<td></td>"
					key=parseInt(key,10);
        	for(var i=1;i<key+1;i++){        		
        		strtable +="<td>";
        		//strtable +="参数"+i;
        		strtable +=$("#getinternet0382").val()+i;        		
        		strtable +="</td><td>";
        		strtable +="<input type='text' id='cs"+i+"' style='width:100px;'/>";
        		strtable +="</td>";
        	}
        	strtable +="</tr>";
        	$("#ghfeeinput").append(strtable);
        	$("#ZFStartday").val(startdate);
        	$("#ZFEndday").removeAttr("disabled");
					$("#ZFStartday").removeAttr("disabled");  
					///电话杂费  终止月
					$("#ZFStartday").focus(function(){
						WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
					});
					///电话杂费  终止日
					$("#ZFEndday").focus(function(){
						WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
					});
					$("#cs1").val("");
					$("#cs2").val("");
					$("#cs3").val("");   	
					$("#DEVNUM,#DEVLENGTH input[value='1']").blur(function(){
						if($(this).val()==""){
							$(this).val('1');
						}
					});							
					$("#DEVNUM,#DEVLENGTH input[value='1']").focus(function(){
						if($(this).val()==1){
							$(this).val('')
						}
					});
					$("#DEVNUM,#DEVLENGTH input[value='1']").keydown(function(){			
						var k=event.keyCode;
						return k>=48&&k<=57||k==190&&this.value!=""&&this.value.indexOf(".")==-1||k==8||k==37||k==39;
					});					
					$("#DEVNUM,#DEVLENGTH input[value='1']").bind("copy paste",function(){
						return false;
					});
        }
        
        
        /********
          *查询生成该电话固话费用项信息，以表格的形式显示
          *@param;
       	  *@return;
          ********/
		  function addspeediFeeType(Dh)
		  {
		    var phone="";
		  	   if(Dh!=""){
		  	   		phone=Dh;
		  	   }else{		
			   		phone = $("#Dh_yhdang").val();
			   }
			   if(phone=="")
			   {
					phone='0000000'
			   }
			   var ify="";
			   var count=0;
		       var urlstr=tsd.buildParams({ 	packgname:'service',//java包
							 					clsname:'ExecuteSql',//类名
							 					method:'exeSqlData',//方法名
							 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
							 					tsdcf:'mssql',//指向配置文件名称
							 					tsdoper:'query',//操作类型 
							 					datatype:'xmlattr',
							 					tsdpk:'dbsql_phone.queryphoneTJBHFYX'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							 				});			 							
				$.ajax({
						url:'mainServlet.html?'+urlstr+"&dh="+phone,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
						            ify="";
						            $("#dhzftab tr:has('td')").remove();					           
									$(xml).find('row').each(function(){
									var id = $(this).attr("id");
									var feetype = $(this).attr("feetype");
									var feecode = $(this).attr("feecode");								
									var Price = $(this).attr("price");		
									var TjPrice = $(this).attr("tjprice");	
									var StartDate = $(this).attr("startdate");
									var EndDate = $(this).attr("enddate");
									var csvalue = $(this).attr("csvalue");
									if(id!=undefined){	
									ify += "<tr>";
									ify += "<td><center>";
									ify += "<input type=\"checkbox\" id=\"v_dhzftab_check\"" + id +  "\"  />";
									ify += "</center></td>";
									ify += "<td width=\"200\"><center>";
									ify += $(this).attr("feetype");
									ify += "</center></td>";								
									ify += "<td width=\"60\"><center>";
									ify += $(this).attr("price");
									ify += "</center></td>";
									ify += "<td width=\"100\"><center>";
									ify += $(this).attr("startdate");
									ify += "</center></td>";
									ify += "<td width=\"100\"><center>";
									ify += $(this).attr("enddate");
									ify += "</center></td>";
									ify += "<td width=\"135\"><center>";
									ify += csvalue;
									ify += "</center></td>";
									ify += "<tr>";
									count += 1;
									}
								});
								for(var i=0;i<=5-count;i++){
									ify += "<tr>";
									ify += "<td width=\"20\"><center>";
									ify += ".";
									ify += "</center></td>";
									ify += "<td width=\"200\"><center>";
									ify += "……";
									ify += "</center></td>";								
									ify += "<td width=\"60\"><center>";
									ify += "……";
									ify += "</center></td>";
									ify += "<td width=\"110\"><center>";
									ify += "……";
									ify += "</center></td>";
									ify += "<td width=\"110\"><center>";
									ify += "……";
									ify += "</center></td>";
									ify += "<td width=\"135\"><center>";
									ify += "……";
									ify += "</center></td>";
									ify += "<tr>";
								}
								count=0;
								$("#dhzftab").append(ify);
								$("#dhzftab tr:empty").remove();
							}
						});					
				$("#dhzftab_checkall").removeAttr("checked");
		   } 
		   
		   
		   /*******
		  	* 添加电话费用杂费信息
		  	* @param;
		  	* @return;
	      	********/
		   function insertphonefeename()
		   {
		      var phone = $("#Dh_yhdang").val();
		      if(phone=="")
		      {
		      	//alert("请选择要办理该项业务的电话号码");
				alert("<fmt:message key="phone.getinternet0176" />");
		      	return false;
		      }
		      var phonefeename = $("#phonefeenamecode").val();
		      
		      if($("#phonefeetype").val()=="")
		      {
		      	//alert("请选择要添加的费用名称");
		      	alert("<fmt:message key="phone.getinternet0006" />");
		      	$("#phonefeetype").focus();
		      	return false;
		      }
		      
		      if(phonefeename=="" || phonefeename==null)
		      {
		      	//alert("请选择要添加的费用子类型");
		      	alert("<fmt:message key="phone.getinternet0007" />");
		      	$("#phonefeename").focus();
		      	return false;
		      }
		      
		      phonefeename = tsd.encodeURIComponent(phonefeename);
		      var ress = JudgeISNOTStorage(phonefeename,phone,$("#Subtype").val());
		      if(ress!=0)
		      {
		      	//alert("该费用子类型已经存在不能重复添加！");
		      	alert("<fmt:message key="phone.getinternet0008" />");
		      	return false;
		      }
		     
		      var feecode = $("#feecode").val();
		      var feelv = $("#feelv").val();
		      var TJfeelv = $("#TJfeelv").val();
		      var ZFStartday = $("#ZFStartday").val();
		      
		      if(!/^\d{4}-\d{2}-\d{2}$/.test(ZFStartday))
		      {
		      	$("#ZFStartday").focus();
		      	return false;
		      }
		      
		      var ZFEndday = $("#ZFEndday").val();
		      
		      if(!/^\d{4}-\d{2}-\d{2}$/.test(ZFEndday))
		      {
		      	$("#ZFEndday").focus();
		      	return false;
		      }
		      
		      var ZFStartmonth = ZFStartday.substring(0,7);//起始月
		      ZFStartmonth = ZFStartmonth.replace('-',"");
		      
		      var ZFEndmonth = ZFEndday.substring(0,7);//终止月
		      ZFEndmonth = ZFEndmonth.replace('-',"");
		      
		      var feename = $("#Subtype").val();	
		      if(isXinYeWuExists(phone)==1)
			  {
			      	//alert("已经存在一项月租费，不能多次添加");
			      	alert("<fmt:message key="phone.getinternet0227" />");
			      	return false;
			   }	      
		      /*
		      if(feename=="月租" && isXinYeWuExists(phone)!="0")
		      {
		      	alert("已经存在一项月租费，不能多次添加");
		      	return false;
		      }*/
		      feename = tsd.encodeURIComponent(feename);
		      
		      //检测终止时间是否大于起始时间
		      /*
		      var resg = gettimeday(ZFStartday,ZFEndday);
		      resg = parseInt(resg,10);
		      if(resg<=0)
		      {
					alert("终止时间必须大于起始时间！");
					$("#ZFEndday").select();
		      		$("#ZFEndday").focus();
		      		return false;
		      }
		      */
		      var cs1 = $("#cs1").val();
		      if(cs1==undefined||cs1=="undefined"){cs1=""}
		      cs1=cs1.replace(/(^\s*)|(\s*$)/g,"");
		      var cs2 = $("#cs2").val();
		      if(cs2==undefined||cs2=="undefined"){cs2=""}
		      cs2=cs2.replace(/(^\s*)|(\s*$)/g,"");
		      var cs3 = $("#cs3").val();
		      if(cs2==undefined||cs3=="undefined"){cs3=""}
		      cs2=cs2.replace(/(^\s*)|(\s*$)/g,"");
		      var csstr;
		      if(cs1!=""&&cs2==""){
		      	 csstr = cs1;		      	 
		      }else if(cs1!=""&&cs2!=""&&cs3==""){
		      	 csstr = cs1+"~"+cs2;
		      }else if(cs2!=""&&cs1!=""&&cs3!=""){
		      	 csstr = cs1+"~"+cs2+"~"+cs3;
		      }		      
		      if(cs1==""&&cs2==""&&cs3==""){
		      	csstr="";
		      }
		      if(csstr==undefined){csstr="";}
		      csstr=csstr.replace('~undefined',"");
		      csstr=csstr.replace('undefined',"");
		      var DEVNUMstr = $("#DEVNUM").val().replace(/(^\s*)|(\s*$)/g,"");
		      var DEVLENGTHstr = $("#DEVLENGTH").val().replace(/(^\s*)|(\s*$)/g,"");
		      var CUNIT = $("#CUNIT").val();
		      if ($("#Bz4_yhdang").val()=="PBX连选"&&DEVNUMstr<=1){
		      		alert("选择连选号码时，设备数量必须大于1");
		      		return;
		      }
		      var res = executeNoQuery("phonelnstalled.insertphonefeename",6,"&dh="+phone+"&feetype="+phonefeename+"&feecode="+feecode+"&feelv="+feelv+"&TJfeelv="+TJfeelv+"&StartMonth="+ZFStartmonth+"&EndMonth="+ZFEndmonth+"&StartDate="+ZFStartday+"&EndDate="+ZFEndday+"&feename="+feename+"&OperID="+tsd.encodeURIComponent($("#userid").val())+"&csstr="+tsd.encodeURIComponent(csstr)+"&DEVNUM="+DEVNUMstr+"&DEVLENGTH="+DEVLENGTHstr+"&CUNIT="+CUNIT);
		      if(res=="true")
		      {
		        addspeediFeeType(phone);//重新加载数据
		        getGHcsnum("");
		        $("#feecode").val("");
		        $("#feelv").val("");
		        $("#TJfeelv").val("");
		        //$("#ZFStartday").val("");
		        //$("#ZFEndday").val("");
		        $("#Subtype").val("");
		        $("#feenameid").val("");
		        $("#Subtype").val("");
		        $("#phonefeename").val("");
		        $("#phonefeenamecode").val("");
        	    $("#phonefeenamecontent tr").css('background-color','#ffffff');
		      }
		      else
		      {
		        //alert("保存失败！");
		        alert("<fmt:message key="phone.getinternet0017" />");		        
		      }
		    }
		    		    
		    /*******
		  	* 添加新费用的时候判断该费用项是否已经在临时表里
		  	* @param:params费用类型，parm用户电话;
		  	* @return;
	      	********/
		    function JudgeISNOTStorage(params,parm,feename)
		    {
		        var result;
		        var res = fetchMultiArrayValue("phonelnstalled.queryisnotfeename",6,"&Dh="+parm+"&FeeType="+params+"&vfeename="+tsd.encodeURIComponent(feename));	
		        result = res[0][0];
		        return result;	    
		    }
		    
		    /*******
		  	* false存在新业务，true不存在新业务
		  	* @param:dh电话;
		  	* @return;
			* feename=1 月租
	      	********/
		    function isXinYeWuExists(dh)
		    {
		    	//var result = fetchSingleValue("phonelnstalled.xinyewualreadyexists",6,"&Dh=" + dh+"&feename="+tsd.encodeURIComponent('月租'));
		    	var result = fetchSingleValue("phonelnstalled.xinyewualreadyexists",6,"&Dh=" + dh+"&feename=1");
		    	if(result=="0")
		    	{
		    		return "0";
		    	}
		    	else if(result=="1")
		    	{
		    		return "1";
		    	}
		    	else
		    	{
		    		return "2";
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
				<table id="kdBar" style="margin-left: 10px;" cellspacing="10px">
						<tr>
							<td>
								<fmt:message key="phone.getinternet0179" /><!-- 查询方式 -->
								<select id="ghSearchWay" style="width: 100px;">
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
								<div id="inputtext">
									<input type="text" class="" id="ghSearchBox" name="ghSearchBox" />
								</div>
							</td>
							<td>
								<button class="tsdbutton" id="submitButton" onClick="ghSearch()" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
									<fmt:message key="phone.getinternet0466" /><!-- 查找 -->
								</button>
							</td>
<!-- 						
							<td>
								是否预约<input type="checkbox" id="isnotyy" style="width:30px;"/>
							</td> 
							<td>
								<span id="yytext">预约时间</span>
							</td>
							<td>
								<input type="text" id="yytime" style="width:150px;"/>
							</td>
-->								
						</tr>
					</table>	
				<div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/65.gif" />
						<fmt:message key="phone.getinternet0195" /><!-- 变更内容 -->
				</div>
				<div id="inputtext" style="height:auto; float:left;">
					<form action="" id="Ywform2">
					<!-- class="required" 自动验证表单 具体其他参数请参照 -->
					<div id="" style="float: left; width:700px;margin-top:10px;">				
						<label>
							<span><fmt:message key="phone.getinternet0260" /><!-- 用户状态 --></span>
						</label>						
						<input type="hidden" name="tfjstatus" id="tfjstatus" disabled="disabled"/>
						<input type="text" name="tfjstatus_zh" id="tfjstatus_zh" disabled="disabled" style="margin-left: 15px;"/>
						<label for="FeeCode">
							<span id="FeeCodeg">业务类型</span>
						</label>
						<select id="tfjstatusnew" name="tfjstatusnew" onChange="statusChange();" style="margin-left: 15px;">
						</select>
					</div>
					<div id="fuji1" style="float: left; width:700px;display:none;">
						<div id="fuji11">						
						<!-- 申请停机时间 -->
						<label for="PauseStartTime">
							<span><fmt:message key="broadband.sqtjtime" /></span>
						</label>
						<input type="text" id="PauseStartTime" disabled="disabled" style="margin-left: 15px;" />
						</div>
						<div id="fuji12">
						<!-- 自动复机时间 -->
						<label for="">
							<span><fmt:message key="broadband.zdfjtiime" /></span>
						</label>
						<input type="text" id="PauseEndTime" disabled="disabled" style="margin-left: 15px;"/>
						</div>
					</div>
					<div id="tingji2" style="float: left; width:700px;display:none;">
						<!-- 追加停机月份数 -->
						<label for="PauseMonth" style="width: 120px;">
							<span>停机月数</span>
						</label>
						<select  id="PauseMonth" onChange="getPauseStopTime()" style="width:180px;position:absolute;left:145px;margin-left: 0px;">
							<%-- <option value="0">--<fmt:message key="phone.getinternet0261" />--</option><!-- 无限期 --> --%>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>				
						</select>

						<!--  新自动复机时间 -->
						<label for="new" style="width:180px;position:absolute;left:265px;">
							<span>复机时间</span>
						</label>
						<!-- <input type="text" name="PauseEndTimenew" id="PauseEndTimenew" style="width:180px;position:absolute;left:470px;" onFocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/> -->
						<input type="text" name="PauseEndTimenew" id="PauseEndTimenew" style="width:180px;position:absolute;left:470px;" />
					</div>
					</form>						
				</div>		
				<div id="input-Unit">
<!-- 				<table>
					<tr>
						<td width=70></td>
						<td>联系人：</td>
						<td>
							<input type="text" id="lxr_tj" style="width:180px;margin-left: 15px;"/> 
						</td>
						<td width=70></td>
						<td>联系电话：</td>
						<td>
							<input type="text" id="lxdh_tj" style="width:180px;"/>
						</td>
					</tr>
				</table> -->

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
						<input type="hidden" id="CUNIT" name="CUNIT"/><!--最小计费单位-->			
						</td>	
					</tr>	
				</table>	
				
										<!--出帐月余额/出帐月欠费 -->
										<!-- 实施余额/实施欠费 -->
										<!-- 电话功能 -->
										<!-- 交换机编号 -->
										<!-- 停机标志 -->
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
					<fmt:message key="phone.getinternet0182" /><!-- 合同号信息显示-->&nbsp;<input type="checkbox" id="hthshowcheck" onClick="getshow()" style="width:15px;" />
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
						<fmt:message key="phone.getinternet0183" /><!--固话信息显示-->&nbsp;<input type="checkbox" id="yhdangshowcheck" checked="checked" onClick="getshow()" style="width:15px;" />
					</div>
					<div id="inputtext">
						<div class="midd">
							<table id="tableyhdang" style="width:780px;">							
							</table>
						</div>
					</div>
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
					<fmt:message key="phone.getinternet0186" /><!--包月套餐信息显示-->&nbsp;<input type="checkbox" id="byfeeshowcheck" onClick="getshow()" style="width:15px;" />
  					<span id="byfeeTips" style="color:red"></span>
					</div>
				 <table border="1" cellpadding="0" bordercolor="#9AC0CD" id="dhBYTC" width="780">
				 </table>
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0082" /><!-- 固定费 -->
				</div>
				<table id="attachfee" style="display:none">
					<tr>
						<td valign="top">
						  <table>
							<tr>
								<td colspan="2">
						  			<div style="width:210px; height: 190px; overflow-y: scroll; overflow-x: hidden;background-color:#f7f7f7;border:1px 1px solid #dddddd;">
											<table id="phonefeenamecontent" style="width:230px;" border="1" cellpadding="0"></table>
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
									<th width="10"><input type="checkbox" id="dhzftab_checkall" onClick="Dhzf_CheckAll()" style="width:15px;" /></th>
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
				<div class="title" id="busifeetemplate">
						&nbsp;&nbsp;						
						<img src="style/icon/65.gif" />
						<fmt:message key="phoneyewu.yewuggnmqr" /><!--业务更改内容确认--><span id="businesschangecontent" style="color:red;"></span>
				  </div>
				 <div id="">
				 	<table cellspacing="0" width="760" id="businesschange">
				 		<tr>
				 			<td style="width:460px;">				 				
				 				<table id="ffltab" style="width:460px;">
								<tr>
									<td class="wenzi" style="width:70px;display:none;">
										<fmt:message key="phone.getinternet0090" /><!-- 付费方式 -->
									</td>
									<td class="wenzix" style="display:none;">
										<select name="cPayType" id="cPayType" style="width: 150px;" class="you1" onChange="payWayChange(this)"></select>
									</td>
									<td class="wenzi" colspan="2" align="right">
										<fmt:message key="phone.getinternet0091" /><!-- 应交合计 -->
									</td>
									<td class="wenzix" width="230px">
										<input type="text" name="cYingJiao" id="cYingJiao" style="width: 230px;" disabled="disabled"  class="you1" onKeyPress="numValid(this)"
										onpaste="return !clipboardData.getData('text').match(/D/)" ondragenter="return   false"/>
								   </td>
								   <td>
								     <table id="dzhthcontent" style="width:330px;" border="1" cellpadding="0" bordercolor="#9AC0CD">
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
									<td colspan="3">
									<fmt:message key="phone.getinternet0094" /><!-- 一次性费用 -->：
									<div
									style="width:440px; height: 105px; overflow-y: scroll; overflow-x: hidden; border-top: 1px solid gray; border-left: 1px solid gray;">
									<div id="feeItem_s" style="width: 100%; float: left;">
									</div>
									</div>
									</td>
									<td valign="top">
									<table id="businessfee" style="width:330px;" border="1" cellpadding="0" bordercolor="#9AC0CD">
									
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
				    <form action="" id="HTHform6">
				    <table cellspacing="3" style="background-color:#f7f7f7">
				       <tr>
				         <td>
						    <table cellspacing="10" style="display:none;">				    
						       <tr>
						         <td>
						           <input type='checkbox' name="danweiHTHbox" id="danweiHTHbox" style="width:22px;padding:0px;border: 0px;" onClick="isnotdanwei()" disabled="disabled"/>
						         </td>
						         <td>&nbsp;&nbsp;&nbsp;&nbsp;<font color="red"><fmt:message key="phoneyewu.isnotdwff" /><!-- 是否单位付费 --></font></td>
						       </tr>
						       <tr>
						         <td><fmt:message key="phoneyewu.dwHTH" /><!-- 单位合同号 -->：</td>
						         <td>						         
						         <input type="text" name="danweiHTH" id="danweiHTH" style="width:150" disabled="disabled"/></td>
						       </tr>
						    </table>
				         </td>
				         <td>
				           <table cellspacing="8">
				              <tr>
				                <!-- <td valign="top"> -->
				                <td>
				                  &nbsp;&nbsp;<fmt:message key="phone.getinternet0187" /><!--业务备注-->
				                </td>
				                <td>
				                  <textarea name="phonepkBz" id="phonepkBz" rows="4" cols="110" style="border:1px solid #999;" maxlength="60"  onpropertychange="TextUtil.NotMax(this)"></textarea><font style="color: red;">*</font>
				                </td>
				              </tr>
				           </table>
				         </td>
				      </tr>				      
				    </table>
				    </form>
				 </div> 
			</div>
	       <div id="buttons">
			<center>				
				<button id="save" onClick="isValiableddd()"
					style="margin-left: 20px;">
					<!-- 确定 -->
					<fmt:message key="Revenue.Save"/>
				</button>
				<button id="reset" onClick="clernull()" style="margin-left: 20px;">
					<!-- 重置 -->
					<fmt:message key="AddUser.Reset" />
				</button>
			</center>
		 </div>
	</div>
	<!-- 单位合同号查询(点击页面最新方合同号复选框弹出窗口) 开始-->	

<div class="neirong" id="operform" style="display: none;width:538px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="phone.dwHTHquery" /><!-- 单位合同号查询 -->
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" /> 
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;" onClick="closeGB();"><fmt:message key="global.close" /><!-- 关闭 --></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;text-align:left;">
			<div id="inputtext">
			<div style="width: 525px; height: 250px; overflow-y: scroll;  border-top: 1px solid gray; border-left: 1px solid gray;">			   						
						<table border="1" cellpadding="0" bordercolor="#9AC0CD"
							id="queryHTHdw" style="width: 507px;">
						</table>
			</div>
				<div id="buttons">
				<center>
					<button id="save" onClick="getinputHTH()"
						style="margin-left: 20px;">
						<!-- 确定 -->
						<fmt:message key="Revenue.Save" />
					</button>
					<button id="reset" onClick="closeGB();" style="margin-left: 20px;">
						<fmt:message key="global.close" />
						<!-- 关闭 -->
					</button>
				</center>
				</div>
			  </div>
			</div>
			<input type="hidden" id="inputDWHTH" />
		</div>
		
<!-- 单位合同号查询(点击页面最新方合同号复选框弹出窗口) 结束-->
	
	
<!-- 电话更名业务用户信息查询(点击查询时弹出窗口) 开始-->
	<div class="neirong" id="multiSearch" style="display: none;overflow-x:hidden">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<fmt:message key="phone.getinternet0262" /><!--电话申请停开机业务用户信息查询-->
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
			<div id="grid"></div>
		</div>

		<div class="midd_butt" style="width:100%;">
			<button type="button" class="tsdbutton" id="kdMultiSearchClose">
				<fmt:message key="phone.getinternet0189" /><!--关闭-->
			</button>
		</div>
	</div>
				
<!-- 电话更名业务用户信息查询(点击查询时弹出窗口) 结束-->		
	<!-- 弹出报表打印框 -->	
	<div id="businessreprint"></div><!-- 加载的文件在script/telephone/business/businessreprint.js -->  
		<iframe id="printReportDirect"  style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>
	    <script>		
		var hilighter2 = new TableRowHilighter(document.getElementById('queryHTHdw'), 0, 'lightsteelblue');
	  </script>
	<!-- 打印表报 end -->
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
	<!-- 打印报表 -->
	<input type="hidden" id="jobidid" name="jobidid"/>
	<input type="hidden" id="fee" name="fee"/>
	<input type="hidden" id="cPayItemy" name="cPayItemy"/>
	<!-- -->
	<input type="hidden" id="starttimeinfo" value='<fmt:message key="phoneyewu.starttime" />'/> 
	<input type="hidden" id="terminationinfo" value='<fmt:message key="phoneyewu.termination" />'/>
	<input type="hidden" id="addinfo" value="<fmt:message key="global.add"/>" />
	<input type="hidden" id=""/>
	<input type="hidden" id="deleteinfo" value="<fmt:message key="global.delete"/>" />
	<input type="hidden" id="cPayTypey"/>
	<input type="hidden" id="startdate" value="<%=Log.getSysTime() %>"/><!-- 固定费用起始日期 -->	
	<!-- 存储停开机参数 -->
	<input type="hidden" id = 'ywlx'>
	<input type="hidden" id="yjfeehidden"/><!-- 页面获取应缴费存入隐藏于中 -->
	<input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->	
	<input type="hidden" id="fufeitypepath"/>
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->
	<input type="hidden" id="stiffbusinestype" value="phoneTFJ"/><!-- 电话工单打印类型 -->
	<input type="hidden" id="hasLimitright"/><!-- 是否可办理限呼保号 -->
	<input type="hidden" id="selFixedFeeright"/><!-- 是否需要选择/取消月租 -->
	<input type="hidden" id="Prefeeval"/><!-- 预测金额打印票据时判断 -->
	<jsp:include page="phone_internet.jsp" flush="true"/>
	</body>
</html>
