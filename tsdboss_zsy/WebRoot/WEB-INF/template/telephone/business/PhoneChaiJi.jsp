<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/PhoneChaiJi.jsp
    Function:   电话拆机
    Author:     wenxuming
    Date:       2010-10
    Description: 
    Modify: 
     2010-10月份 对该页面进行移植，并对版式进行修改；
     2010-11-03 把公用的CSS提取出来放到style/css/telephone/business/businesspublic.css；
     2010-11-22 电话拆机后不可重复办理拆机业务，修改了函数userChoose(Yhmc,Dh,Yhdz)；
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>电话拆机业务</title>
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
<!-- 		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script> -->
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
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
       /*********
				* 权限设置			
				* @param;
				* @return;
		    	**********/
				function getUserPower(){
				 var urlstr=tsd.buildParams({ 	  packgname:'service',
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
				var enforceCJright='';
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
						enforceCJright='true';
						flag = true;
				}else if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');
						for(var i = 0;i<spowerarr.length-1;i++){							
							enforceCJright +=getCaption(spowerarr[i],'enforceCJ','')+'|';//设置代缴合同号按钮是否可用							
						}
				}
				var hasenforceCJ = enforceCJright.split('|');				
				var str = 'true';		
				if(flag==true){	
					$("#enforceCJright").val(enforceCJright);
				}else{
					for(var i = 0;i<hasenforceCJ.length;i++){
							$("#enforceCJright").val(hasenforceCJ[i]);
							break;
						}
				}		
			}   
	   /**************
	   *初始化加载
	   ***************/		
       jQuery(document).ready(function()
	   {	    
	    $("#navBar").append(genNavv());
	    getUserPower();
	    getinternation();	//businesspublic.js中  自动加载显示框
	    ghPayMoney('p_delete'); 	
	    gethide("p_delete");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数
	    getfufeitype();//付费类型	    
	    $("#ghSearchBox").select();
	    $("#ghSearchBox").focus();
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
	   }); 

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
	   	* @param:Yhmc用户名称，Dh电话，Yhdz用户地址;
	   	* @return;
	  	********/
		function userChoose(Yhmc,Dh,Yhdz)
		{
			var rescjkey = fetchMultiArrayValue("PhoneHFZJ.checkCj",6,"&Dh=" + Dh);
			if(rescjkey[0][0]=='delete')
			{
				//alert("该用户已经进行了拆机，无法再次办理！");
				alert("<fmt:message key="phone.getinternet0162" />");
				return;
			}
			$("#cjfeehth").val(rescjkey[0][2]);
			//alert($("#userid").val()+";"+$("#area").val()+";"+Dh);
			/*
			var result = fetchMultiPValue("PhoneDH.ifCanSouLi",6,"&OperID=" + tsd.encodeURIComponent($("#userid").val()) + "&Ywlx="+tsd.encodeURIComponent("p_delete")+"&NowYwArea="+tsd.encodeURIComponent($("#area").val())+"&Dh="+Dh);
			if(result[0]!=undefined && result[0][0]!="")
			{
					alert(result[0][1]);
					return;
			}
			*/		
			//判断是否完工
			var res = fetchSingleValue("dbsql_phone.getteljobwgrq",6,"&dh="+Dh);
			if(res>0){
				//alert("对不起，该电话未完工！！！");
				alert("<fmt:message key="phone.getinternet0163" />");
				return;
			}
			var hfhth = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&cloum=y.hth,h.yhlb&tablename=yhdang y,hthdang h&key=y.hth=h.hth and y.Dh='"+Dh+"'");			
			var MaxHf = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=MaxHf&tablename=hthhfadd&key=hth='"+hfhth[0][0]+"'");
			try {			
			var str = MaxHf.substr(0,1);
			} catch (e) {
				//MaxHf 是 undefined 抓异常使程序继续执行
				//alert(e.name + ":" + e.message);
			} 
			
			MaxHf = parseFloat(MaxHf,10);
			var yefeevalue = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=count(1) as cont&tablename=yhdang&key=hth='"+hfhth[0][0]+"' and nvl(delbz,'tsd')<>'delete'");			
			if(yefeevalue=="1"){				
				if(str=="-"){					
					if($("#enforceCJright").val()=="false"){
						//alert("该电话已欠费"+MaxHf+"元，请结清费用！");
						alert("<fmt:message key="phone.getinternet0164" />"+MaxHf+"<fmt:message key="phone.getinternet0165" />");
						return;
					}else{
						//if(confirm("是否强制对电话"+Dh+"进行拆机？")){
						if(confirm("<fmt:message key="phone.getinternet0166" />["+Dh+"]<fmt:message key="phone.getinternet0167" />")){

						}else{
							return;
						}
					}
				}else if(MaxHf>0&&hfhth[0][1]!="<fmt:message key="phone.getinternet0384" />"){
					//alert("该电话有余额"+MaxHf+"元，请退费处理！");
					alert("<fmt:message key="phone.getinternet0168" />"+MaxHf+"<fmt:message key="phone.getinternet0169" />");
				}
			}
			//判断是否有宽带
			var rad = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=username&tablename=radcheck&key=sdh='"+Dh+"'");
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
			ghSerBasicInfo(Dh);
			ghZF(Dh);
			//gethTC(Dh);
			getdhBYTC(Dh);			
			setTimeout($.unblockUI,1);
		}

		 function confirm(str) {
            var arrStr = str.split("\r");
            var strMsg = "";
            for (var i = 0; i < arrStr.length; i++) {
                if (i != arrStr.length - 1) {
                    strMsg += "'" + arrStr[i] + "'&Chr(10)&";
                }
                else {
                    strMsg += "'" + arrStr[i] + "'";
                }
            }
            execScript("n = msgbox(" + strMsg + ",257,'<fmt:message key="phone.getinternet0401" />')", "vbscript");
            //execScript("n = msgbox(" + strMsg + ",257,'消息提示')", "vbscript");
            return (n == 1);
        } 

		/*******
	   	* 取拆机必须保留的余额
	   	* @param:Yhmc用户名称，Dh电话，Yhdz用户地址;
	   	* @return;
	  	********/
		function fetchMYE()
		{	
			var key='';
			if($("#cjfeehth").val()!=""){
				key=$("#cjfeehth").val();
			}else{
				key=$("#Hth").val();
			}
			var reshth = fetchSingleValue("dbsql_phone.queryyhlbhth",6,"&hth="+key);			
			//var result = fetchSingleValue("dbsql_phone.querytsd_ini",6,"&tsection="+tsd.encodeURIComponent('业务受理拆机余额')+"&tident="+tsd.encodeURIComponent(reshth));					
			var result = fetchSingleValue("dbsql_phone.querytsd_ini",6,"&tsection="+tsd.encodeURIComponent("<fmt:message key="phone.getinternet0402" />")+"&tident="+tsd.encodeURIComponent(reshth));
			if(result==undefined || result=="")
			{
				//alert("请在系统配置表中配置用户类型拆机余额！");
				alert("<fmt:message key="phone.getinternet0171" />");
				return false;
			}
			var reshthdelete = fetchSingleValue("dbsql_phone.hthisnotdelete",6,"&hth="+key);
			if(reshthdelete==undefined || reshthdelete=="")
			{
				return "";
			}
			$("#cjfeehth").val("");
			//取拆机须有余额数据
			var ye = $("#phoneBalance").val();
			var spanyucunYE = $("#spanyucunYE").text();
			//if(spanyucunYE=="欠费余额"){
			if(spanyucunYE=="<fmt:message key="phone.getinternet0403" />"){
				ye = parseFloat("-"+ye);
			}else{
				ye = parseFloat(ye);	
			}					
			var mye = parseFloat(result);
			//判断该合同号下有多少电话，当只有一个电话时才提示余额拆机
			if(reshthdelete=='1'){
				if(ye<mye)
				{
					//alert("该用户类别为："+reshth+",拆机时账户余额必须大于或等于" + mye + "元,当前余额" + ye + "，不能办理拆机业务。");
					alert("<fmt:message key="phone.getinternet0172" />"+reshth+"<fmt:message key="phone.getinternet0173" />" + mye + "<fmt:message key="phone.getinternet0174" />" + ye + "<fmt:message key="phone.getinternet0175" />");
					return false;
				}
			}
			return true;
		}

		function updateGH(){
			//判断是否可以办理该业务
			if($("#enforceCJright").val()=="false"){			
				if(!fetchMYE())
				{
					return false;
				}
				exectut('');
			}else{				
					//查询强制请开机标志N为不强制,Y可强制拆机
					var key = fetchSingleValue("dbsql_phone.querytsd_ini",6,"&tsection="+tsd.encodeURIComponent('phonebusiness')+"&tident="+tsd.encodeURIComponent('isnotdelete'));
					exectut(key);
			}
		}
		
		
		/*******
	   	* 点击保存拼接参数调用过程执行拆机操作
	   	* @param;
	   	* @return;
	  	********/
		function exectut(key)
		{					
				//每次拼接参数必须初始化此参数
				tsd.QualifiedVal=true;				
			 	var params='';
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
				
				//如果phone为空，必查询一下
				if(phone=="")
				{
					//alert("请选择要办理该项业务的电话号码");
					alert("<fmt:message key="phone.getinternet0176" />");
					$("#ghSearchBox").select();
					$("#ghSearchBox").focus();
					return false;
				}
				
				//付费方式
				var cPayType = $("#cPayType").val();						
				//var cIsPay = $("#cIsPay").val();			
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
				var cLianXiRen = $("#Bz8_yhdang").val();
				var cLianXiDianHua = $("#Bz9_yhdang").val();
				//备注
				var phonepkBz = $("#phonepkBz").val().replace(/(^\s*)|(\s*$)/g,"");			
				if(phonepkBz==null||phonepkBz==""){
					//alert("请输入备注！");
					//alert("<fmt:message key="phone.getinternet0160" />");
					//$("#phonepkBz").focus();
					//return false;
					phonepkBz = "未填写备注强行拆机";
				}
				
				if($("#isnotyy").attr("checked")==true&&$("#yytime").val()==""){
					$("#yytime").select().focus();
					alert("请输入预约时间");
					return;
				}
				/*
				'Area=区域;Depart=部门;UserID=工号;Dh=电话号;sStatus=原状态;dStatus=办理状态;
				sfff=是否付费;danwei=是否单 位付费;feetype=付费方式;yjfee=应缴费;
				sjfee=实缴费;feename=费用项;lxr=缴费联系人;lxdh=缴费联系电话;HTH= 代缴合同号;bz=付费备注;'
				*/
				params+="&yytime="+tsd.encodeURIComponent($("#yytime").val());
				params+="&yytype="+tsd.encodeURIComponent($("#isnotyy").attr("checked"));
				params+="&DelType="+tsd.encodeURIComponent(key);//是否强制听开机标志
				params+="&Area="+tsd.encodeURIComponent(area);
				params+="&userarea="+tsd.encodeURIComponent(userareaid);
				params+="&Depart="+tsd.encodeURIComponent(depart);
				params+="&UserID="+tsd.encodeURIComponent(userid);
				params+="&Dhh="+tsd.encodeURIComponent(phone);
				params+="&ispay="+tsd.encodeURIComponent(cPayType);
				params+="&feetype="+tsd.encodeURIComponent(cPayType);
				params+="&yjfee="+tsd.encodeURIComponent(cYingJiao);			
				//params+="&sjfee="+tsd.encodeURIComponent(cShiShou);
				params+="&feename="+tsd.encodeURIComponent(cPayItem);
				params+="&lxr="+tsd.encodeURIComponent(cLianXiRen);
				params+="&lxdh="+tsd.encodeURIComponent(cLianXiDianHua);
				params+="&HTH="+tsd.encodeURIComponent($("#Hth").val());	
				params+="&fsbm="+$("#fsbm").val();		
				params+="&zwbz="+tsd.encodeURIComponent(phonepkBz);	
				
				var loginfo = "<fmt:message key="phone.getinternet0404" />:";//电话拆机
				loginfo += "<fmt:message key="phone.getinternet0103" />:";//"电话号码:";
				loginfo += phone;
				loginfo +=";<fmt:message key="phone.getinternet0405" />：";//账户剩余金额
				loginfo +=$("#phoneBalance").val();
				loginfo += ";<fmt:message key="phone.getinternet0381" />:";
				loginfo += area;
				loginfo += ";<fmt:message key="phone.getinternet0396" />:";
				loginfo += userid;
				loginfo = tsd.encodeURIComponent(loginfo);	
				params+="&ywbz="+loginfo;
			    params+="&YwArea="+$("#YwArea_yhdang").val();	
						 	
		 		//每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}	
				var result = fetchMultiPValue("PhoneService.XH",6,params);
				if(result[0]==undefined || result[0][0]==undefined || result[0][0]=='-1')
				{
					//alert("拆机业务失败");
					alert("<fmt:message key="phone.getinternet0177" />");
				}
				else
				{
					//alert("拆机业务办理成功");
					if(result[0][0]=="yyscsess"){
						alert("预约受理成功！");						
					}else{
						$("#jobidid").val(result[0][0]);
						$("#ppaytype").val(cPayType);
						$("#fee").val(cYingJiao);
						writeLogInfo("","modify",loginfo);
						//判断是否打印工单，从tsd_ini表中配置Y为打印
						printworkorder('p_delete');//script/telephone/business/businessreprint.js中
					}						
					$("#ghSearchBox").select();
				    $("#ghSearchBox").focus();							
					//页面还原
					pageReset();
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
			$("#tablehthdang :text").val("");
        	$("#tablehthdang select").val("");
        	$("#tableyhdang :text").val("");
        	$("#tableyhdang select").val("");		
			//业务备注框
			$("#phonepkBz").val("");
			//杂费项
			$("#dhZFX").empty();
			//套餐项
			$("#dhTCX").empty();	
			$("#dhBYTC").empty();		
			$("#cPayType").val("cash").trigger("change");
			$("#danweiHTHbox").removeAttr("checked");			
			ghPayMoney('p_delete');		
			refreshbusinessfee();
			gethide("p_delete");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数
			unLockDh();//清除锁定
			$("#yytime").val("");
			$("#yytime,#yytext").hide();
			$("#isnotyy").removeAttr("checked");
		}				
    </script>    
	</head>
       
	<body onUnload="unLockDh()">
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
							<td style="display: none;">
								是否预约<input type="checkbox" id="isnotyy" style="width:30px;"/>
							</td>
							<td style="display: none;">
								<span id="yytext">预约时间</span>
							</td>
							<td style="display: none;">
								<input type="text" id="yytime" style="width:150px;"/>
							</td>
						</tr>
					</table>				
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
										<!--出帐月余额/出帐月欠费 -->
									</td>
									<td class="wenzix">
										<input type="text" id="phoneBalance" name="phoneBalance"
											value="0" style="width: 150" disabled="disabled" />
									</td>
									<td class="wenzi">
										<span id="spanxinyueHF"></span>
										<!-- 实施余额/实施欠费 -->
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
										<!-- 电话功能 -->
									</td>
									<td>
										&nbsp;<select name="Dhgn" id="Dhgn"
											style="width: 150"></select>
									</td>
									<td>
										<span id="spanJhj_IDx"></span>
										<!-- 交换机编号 -->
									</td>
									<td>
										<input type="text" name="SwitchNumber" id="SwitchNumber"
											style="width: 150;display:none;" disabled="disabled" />
									</td>
									<td>
										<fmt:message key="phone.getinternet0181" /><!-- 停机标志 -->
									</td>
									<td>		
										<select id="Tjbz_yhdang" name="Tjbz_yhdang"></select>							
									</td>
								</tr>
								<tr></tr>
							</table>
						</div>
					</div>
				
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
					<fmt:message key="phone.getinternet0184" /><!--固定费信息显示-->&nbsp;
					<input type="checkbox" id="gdfeeshowcheck" checked="checked" onClick="getshow()" style="width:15px;" /><span id="gdfeeTips" style="color:red"></span>
				</div>
				<table border="1" cellpadding="0" bordercolor="#9AC0CD" id="dhZFX"
					width="780">

				</table>
				<div class="title"  style="display:none">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0185" /><!--优惠套餐信息显示-->
				</div>
				<table border="1" cellpadding="0" bordercolor="#9AC0CD" id="dhTCX"
					width="780"  style="display:none">
				</table>
				<div class="title" style="display: none;">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0186" /><!--包月套餐信息显示-->&nbsp;<input type="checkbox" id="byfeeshowcheck" onClick="getshow()" style="width:15px;" /><span id="byfeeTips" style="color:red"></span>
					</div>
				 <table border="1" cellpadding="0" bordercolor="#9AC0CD" id="dhBYTC" width="780">
				 </table>
				<div class="title"  id="busifeetemplate">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phoneyewu.yewuggnmqr" /><!--业务更改内容确认--><span id="businesschangecontent" style="color:red;"></span>
				</div>
				<div id="inputtext1">
					<table cellspacing="0" width="760" id="businesschange">
				 		<tr>
				 			<td style="width:460px;">
				 				<table id="ffltab" style="width:460px;">
								<tr>
									<td class="wenzi" style="width:70px;">
										<fmt:message key="phone.getinternet0090" /><!-- 付费方式 -->
									</td>
									<td class="wenzix">
										<select name="cPayType" id="cPayType" style="width: 150px" class="you1" onChange="payWayChange(this)"></select>
									</td>
									<td class="wenzi">
										<fmt:message key="phone.getinternet0091" /><!-- 应交合计 -->
									</td>
									<td class="wenzix">
										<input type="text" name="cYingJiao" id="cYingJiao" style="width: 130px;" disabled="disabled"  class="you1" onKeyPress="numValid(this)"
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
									<td colspan="4">
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
					<table cellspacing="3" style="background-color:#f7f7f7">
				       <tr>
				         <td>
						    <table cellspacing="0" style="display:none;">
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
				           <table cellspacing="8">
				              <tr>
				                <!-- <td valign="top"> -->
				                <td>
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
					<img src="style/icon/65.gif" />
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
					<button id="save" onClick="updateGH()" style="margin-left: 20px;">
						<!-- 确定 -->
						<fmt:message key="Revenue.Save" />
					</button>
					<button id="reset" onClick="pageReset()" style="margin-left: 20px;">
						<!-- 重置 -->
						<fmt:message key="AddUser.Reset" />
					</button>
				</center>
			</div>
		</div>

		<div class="neirong" id="operform"
			style="display: none; overflow-x: hidden; width: 600px;">
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
						<a href="javascript:;"
							onclick="javascript:$('#operformClose').click();"><fmt:message key="phone.getinternet0189" /><!--关闭--></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd"
				style="background-color: #FFFFFF; text-align: left; height: 260px; overflow-y: scroll;">
				<table border="1" cellpadding="0" bordercolor="#9AC0CD"
					id="queryHTHdw">

				</table>
			</div>
			<div class="midd_butt" style="width: 100%;">
				<button id="save" class="tsdbutton" onClick="getinputHTH()"
					style="margin-left: 20px;">
					<!-- 确定 -->
					<fmt:message key="Revenue.Save" />
				</button>
				<button type="button" class="tsdbutton" onClick="closeGB();"
					id="operformClose">
					<fmt:message key="phone.getinternet0189" /><!--关闭-->
				</button>
			</div>
		</div>
		<div class="neirong" id="multiSearch"
			style="display: none; overflow-x: hidden;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="phone.getinternet0190" /><!--电话拆机业务用户信息查询-->
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
				style="background-color: #FFFFFF; text-align: left;">
				<div id="grid" style="margin-top: 0px;"></div>
			</div>
			<div class="midd_butt" style="width: 100%;">
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
		<input type="hidden" id="reportparam" />
		<input type="hidden" id="jobidid" />
		<input type="hidden" id="ppaytype" />
		<input type="hidden" id="fee" />
		<input type="hidden" id="yjfeehidden"/><!-- 页面获取应缴费存入隐藏于中 -->
		<input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->		
		<input type="hidden" id="fufeitypepath"/>
		<input type="hidden" id="enforceCJright"/><!-- 是否强制拆机权限 -->
		<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->
		<input type="hidden" id="stiffbusinestype" value="phoneCJ"/><!-- 电话工单打印类型 -->
		<input type="hidden" id="cjfeehth"/><!-- 查询拆机合同号 -->
		<input type="hidden" id="Prefeeval"/><!-- 预测金额打印票据时判断 -->
		<input type="hidden" id="businesstype" value="p_delete"/><!-- 该页面的业务类型 -->
		<jsp:include page="phone_internet.jsp" flush="true"/>
	</body>
</html>
