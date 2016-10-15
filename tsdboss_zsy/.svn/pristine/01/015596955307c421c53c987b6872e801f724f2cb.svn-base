<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/PhonechangeUserName.jsp
    Function:   电话购机
    Author:     wenxuming
    Date:       2010-10
    Description: 
    Modify: 
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
		<title>电话购机</title>
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
		    gethide("p_purchase");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数
		    getfufeitype();//付费方式    
		    $("#ghSearchBox").select();
		    $("#ghSearchBox").focus();
		    $("#tablehthdang select").attr("disabled","disabled");
			$("#tablehthdang :text").attr("disabled","disabled");
			$("#tableyhdang select").attr("disabled","disabled");
			$("#tableyhdang :text").attr("disabled","disabled");
			
			
	   }); 
	   function getHeji(){
			var acount = $('#phonecount').val();  //数量 
			var price = $("#phoneprice").val();
			acount = parseFloat(acount,10);
			price = parseFloat(price,10);		
			if(isNaN(acount)) acount = 0;
			if(isNaN(price)) price = 0;
			
			$("#cYingJiao").val(acount*price);
			
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
			ghZF(Dh);
			getPhonetype("p_purchase");
			$('#phonecount').val(1);  // 设定值
			setTimeout($.unblockUI,1);
		}						
		
		/*******
	   	* 点击保存拼接参数调用过程处理更名修改
	  	* @param;
	   	* @return;
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
			var dh=$("#Dh_yhdang").val();
			var hth=$("#Hth_yhdang").val();
			var phonetype = $("#phonetype").find("option:selected").text();
			var phoneprice = $("#phoneprice").val();
			var phonecount = $("#phonecount").val();
			var paytype = $("#cPayType").val();
			var heji = $("#cYingJiao").val();
			var bz = $("#phonepkBz").val();
			
			if(phonetype=='-1'||phonecount==""||phonecount=="undefined"){
				alert("请选择话机类型！");
				$("#phonetype").focus();
				return false;
			}
			
			if(phonecount=='0'||phonecount==""||phonecount=="undefined"){
				alert("请填写话机数量！");
				$("#phonecount").focus();
				return false;
			}
			
			params+="&Area="+tsd.encodeURIComponent(area);
			params+="&userarea="+tsd.encodeURIComponent(userareaid);			
			params+="&Depart="+tsd.encodeURIComponent(depart);
			params+="&UserID="+tsd.encodeURIComponent(userid);
			
			params+="&dh="+tsd.encodeURIComponent(dh);
			params+="&hth="+tsd.encodeURIComponent(hth);
			params+="&phonetype="+tsd.encodeURIComponent(phonetype);
			params+="&phoneprice="+tsd.encodeURIComponent(phoneprice);
			params+="&phonecount="+tsd.encodeURIComponent(phonecount);
			params+="&paytype="+tsd.encodeURIComponent(paytype);
			params+="&heji="+tsd.encodeURIComponent(heji);
			params+="&zwbz="+tsd.encodeURIComponent(bz);
			
			
			var loginfo = "电话购机:";
			loginfo += "(电话:";
			loginfo += dh;
			loginfo += ")(话机类型:";
			loginfo += phonetype;
			loginfo += ")(数量:";
			loginfo += phonecount;
			loginfo += ")";
			loginfo = tsd.encodeURIComponent(loginfo);	
			params+="&ywbz="+loginfo;	 	
			
	 		//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}			
			var result = fetchMultiPValue("PhoneService.GJ",6,params);
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
				printworkorder('p_changename');//script/telephone/business/businessreprint.js中
				writeLogInfo("","modify",loginfo);				
				pageReset();
			}
		}
		
		function getPhonetype(feeType){
			
			var res = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&tablename=phoneprice&cloum=id||'|'||price,phonetype&key=1=1");
			var querysel="<option value='-1'>--请选择--</option>";
			if(res[0]!="undefined" && res[0][0]!="undefined")
       		{
       			for(var i=0;i<res.length;i++){
	        		querysel+="<option value="+res[i][0]+">"+res[i][1]+"</option>";
	        	}	
       		}
       		$("#phonetype").html(querysel);
		}
		
		function getPhoneprice(value){
		
			if(value=="-1"){
				$("#phoneprice").val('0.00');
			}else{
				$("#phoneprice").val(value.substring(value.indexOf('|')+1,value.length));
				getHeji();
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
        	$("#staff_bm").val("").trigger("change");        	
			//业务备注框
			$("#phonepkBz").val("");
			//杂费项
			$("#dhZFX").empty();
			//套餐项
			$("#dhTCX").empty();	
			//包月套餐	
			$("#dhBYTC").empty();				
			$("#cPayType").val("cash").trigger("change");
			$("#danweiHTHbox").removeAttr("checked");	
			$("#newYhxm").attr("disabled","disabled");
			$("#newhthYhxm").attr("disabled","disabled");				
			ghPayMoney('p_changename');	//通过更名标识来查询一次性费用		
			refreshbusinessfee();		
			gethide("p_changename");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数
			 
			unLockDh();
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
					<span id="feetdhypetext"></span>
					</div>
				<div id="inputtext">
						<div class="midd">
							<table>
								<tr style="line-height: 30px;">
									<td class="wenzi">
										话机类型
									</td>
									<td class="wenzix">
										<select style="width: 150px;" id="phonetype" onchange="getPhoneprice(this.value);"></select>
									</td>
									<td class="wenzi">
										单价
									</td>
									<td class="wenzix">
										<input type="text" name="phoneprice" id="phoneprice" style="width: 150px;" disabled="disabled" />
									</td>
									<td class="wenzi">
										数量
									</td>
									<td class="wenzix">
										<input id="phonecount" onkeyup="getHeji();" value="1" style="width:150px;"/>
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
				  <div class="title" id="busifeetemplate">
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
									<td class="wenzi" style="width:100px;">
										<fmt:message key="phone.getinternet0090" /><!-- 付费方式 -->
									</td>
									<td class="wenzix">
										<select name="cPayType" id="cPayType" style="width: 150px" class="you1" onChange="payWayChange(this)"></select>
									</td>
									<td class="wenzi">
										<fmt:message key="phone.getinternet0091" /><!-- 应交合计 -->
									</td>
									<td class="wenzix">
										<input type="text" name="cYingJiao" id="cYingJiao" style="width: 130px;" disabled="disabled"  class="you1"
										onpaste="return !clipboardData.getData('text').match(/D/)" ondragenter="return   false"/>
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
						<fmt:message key="phone.getinternet0217" /><!--电话更名业务用户信息查询-->
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
	<input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->
	<input type="hidden" id="yjfeehidden"/><!-- 页面获取应缴费存入隐藏于中 -->
	<input type="hidden" id="fufeitypepath"/>
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->	
	<input type="hidden" id="stiffbusinestype" value="phoneGM"/><!-- 电话工单打印类型 -->
	<input type="hidden" id="Prefeeval"/><!-- 预测金额打印票据时判断 -->
	<input type="hidden" id="bmtypekey"/><!-- 部门编号 -->		
	<input type="hidden" id="sbmcode"/><!-- 部门编号 -->
	<input type="hidden" id="sbmname"/><!-- 部门名称 -->
	<jsp:include page="phone_internet.jsp" flush="true"/>
	</body>
</html>
