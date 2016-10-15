<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/PhonechangeUserName.jsp
    Function:   电话更名
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
		<title>故障受理</title>
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
		    $("#ghSearchBox").select();
		    $("#ghSearchBox").focus();
		    $("#tablehthdang select").attr("disabled","disabled");
			$("#tablehthdang :text").attr("disabled","disabled");
			$("#tableyhdang select").attr("disabled","disabled");
			$("#tableyhdang :text").attr("disabled","disabled");
			
			
			/*  $("#gzxx").empty();  */
		    var info="";
		    var sysid="";
		   var gzlx= $("#faulttype").val();
		   
		   sysid="50";
		   var res=fetchMultiArrayValue("select.gzxx",6,"&sysid="+sysid);
		     info+="<option value=''>--请选择--</option>";
		     info+="<option value="+res[0]+">"+res[0]+"</option>";
		     info+="<option value="+res[1]+">"+res[1]+"</option>";
		     info+="<option value="+res[2]+">"+res[2]+"</option>";
		     info+="<option value="+res[3]+">"+res[3]+"</option>";
		     info+="<option value="+res[4]+">"+res[4]+"</option>";
		     info+="<option value="+res[5]+">"+res[5]+"</option>";
		     info+="<option value="+res[6]+">"+res[6]+"</option>";
		     info+="<option value="+res[7]+">"+res[7]+"</option>";
		     info+="<option value="+res[8]+">"+res[8]+"</option>";
		     info+="<option value="+res[9]+">"+res[9]+"</option>";
		     info+="<option value="+res[10]+">"+res[10]+"</option>";
		     info+="<option value="+res[11]+">"+res[11]+"</option>";
	    	$("#gzxx").append(info);
	        
		  $("#faulttype").change(function(){
			 $("#gzxx").empty(); 
		    var info="";
		    var sysid="";
		   var gzlx= $("#faulttype").val();
		   if(gzlx=="112fault"){
		   sysid="50";
		   var res=fetchMultiArrayValue("select.gzxx",6,"&sysid="+sysid);
		     info+="<option value=''>--请选择--</option>";
		     info+="<option value="+res[0]+">"+res[0]+"</option>";
		     info+="<option value="+res[1]+">"+res[1]+"</option>";
		     info+="<option value="+res[2]+">"+res[2]+"</option>";
		     info+="<option value="+res[3]+">"+res[3]+"</option>";
		     info+="<option value="+res[4]+">"+res[4]+"</option>";
		     info+="<option value="+res[5]+">"+res[5]+"</option>";
		     info+="<option value="+res[6]+">"+res[6]+"</option>";
		     info+="<option value="+res[7]+">"+res[7]+"</option>";
		     info+="<option value="+res[8]+">"+res[8]+"</option>";
		     info+="<option value="+res[9]+">"+res[9]+"</option>";
		     info+="<option value="+res[10]+">"+res[10]+"</option>";
		     info+="<option value="+res[11]+">"+res[11]+"</option>";
		     
		   }
		    else if(gzlx=="radfault"){
		     sysid="53";
		     var res=fetchMultiArrayValue("select.gzxx",6,"&sysid="+sysid);
		     info+="<option value=''>--请选择--</option>";
		     info+="<option value="+res[0]+">"+res[0]+"</option>";
		     info+="<option value="+res[1]+">"+res[1]+"</option>";
		     info+="<option value="+res[2]+">"+res[2]+"</option>";
		     info+="<option value="+res[3]+">"+res[3]+"</option>";
		     info+="<option value="+res[4]+">"+res[4]+"</option>";
		     info+="<option value="+res[5]+">"+res[5]+"</option>";
		     info+="<option value="+res[6]+">"+res[6]+"</option>";
		     info+="<option value="+res[7]+">"+res[7]+"</option>";
		     info+="<option value="+res[8]+">"+res[8]+"</option>";
		     
		   }
	    	$("#gzxx").append(info);
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
	   	* @param: Yhmc用户名称、Dh电话、Yhdz用户地址;
	   	* @return;
	  	********/
		function userChoose(Yhmc,Dh,Yhdz)
		{
			/*
			var result = fetchMultiPValue("PhoneDH.ifCanSouLi",6,"&OperID=" + tsd.encodeURIComponent($("#userid").val()) + "&Ywlx="+tsd.encodeURIComponent("p_changename")+"&NowYwArea="+tsd.encodeURIComponent($("#area").val())+"&Dh="+Dh);
			if(result[0]!=undefined && result[0][0]!="")
			{
				return;
			}
			*/
			 
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
			
			$("#slinkman").val(Yhmc);
			$("#slinkaddr").val(Yhdz);
			$("#hidfaultdh").val(Dh);
			
			setTimeout($.unblockUI,1);
			var res = fetchMultiArrayValue("select.pddh",6,"&Dh="+Dh);
            if(res!=""&&res!=null&&res!=undefined){
              //alert(res[0][0]);
              $("#Dh_yhdang").val(res[0][0]);
              $("#Hth_yhdang").val(res[0][1]);
              $("#Yhmc_yhdang").val(res[0][2]);
              $("#Bm1_yhdang").val(res[0][3]);
              $("#Bm2_yhdang").val(res[0][4]);
              $("#Bm3_yhdang").val(res[0][5]);
              $("#Bm4_yhdang").val(res[0][6]);
              $("#Yhdz_yhdang").val(res[0][7]);
              $("#Bz8_yhdang").val(res[0][8]);
              $("#Bz9_yhdang").val(res[0][9]);
              $("#Bz6_yhdang").val(res[0][10]);
              $("#Bz7_yhdang").val(res[0][11]);
              $("#YwArea_yhdang").val(res[0][12]);
            }
            else
            {
                ghSerBasicInfo(Dh);
            }
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
			//区域
			var area = $("#YwArea_yhdang").val();
			var userareaid = $("#userareaid").val();
			//部门
			var depart = $("#depart").val();
			//工号
			var userid = $("#userid").val();
			var faulttype=$("#faulttype").val();
			
			params += '&jobtype='+faulttype;
			params += '&thiskey='+$("#hidfaultdh").val();
			params += '&gzxx='+tsd.encodeURIComponent($("#gzxx").val());
			params += '&linkman='+tsd.encodeURIComponent($("#slinkman").val());
			params += '&linkphone='+$("#slinkphone").val();
			params += '&ywarea='+tsd.encodeURIComponent(area);
			params += '&username='+tsd.encodeURIComponent($("#slinkman").val());
			params += '&address='+tsd.encodeURIComponent($("#slinkaddr").val());
			params += '&usertype=';
			params += '&callerid=';
			params += '&bz='+tsd.encodeURIComponent($("#faultremark").val());
			params += '&userid='+userid;
			params += '&sSlbm=6';		
			params += '&jlry=';					
			
			
	 		//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}			
			var result = fetchMultiPValue("112fault.interface_faultjob",6,params);
			if(result[0]==undefined || result[0][0]==undefined || result[0][0]=='-1')
			{
				//alert("业务失败");
				alert("<fmt:message key="phone.getinternet0193" />");
			}
			else
			{
				alert("受理成功！");	
				if(confirm("是否跳转到故障工单管理系统")){
                        openMenu('4306','112jobmanager.jsp','6','');
                    }			
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
			$("#sBm1,#sBm1code,#sBm2,#sBm2code,#sBm3,#sBm3code,#sBm4,#sBm4code").val("");
			unLockDh();
		}
		
		function onchagefault(param){
			
			$("#faultremark").val(param);
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
					<fmt:message key="phone.getinternet0183" /><!--固话信息显示-->&nbsp;<input type="checkbox" id="yhdangshowcheck" checked="checked" onClick="getshow()" style="width:15px;" />
				</div>
				<div id="inputtext">
					<div class="midd">
						<table id="tableyhdang" style="width:780px;"></table>
					</div>
				</div>

				  <div class="title" id="busifeetemplate">
						&nbsp;&nbsp;						
						<img src="style/icon/65.gif" />
						故障信息填写
				  </div>
				 <div id="inputtext1">
				 	<table cellspacing="0" style="width:780px;" id="businesschange">
				 		<tr>
							<td class="wenzi" style="width:100px;">
								故障类型
							</td>
							<td class="wenzix">
								<select name="faulttype" id="faulttype" style="width: 150px" class="you1">
									<!-- <option value="">--请选择--</option> -->
<!--									<option value="tvfault">电视故障</option>-->
                                    <option value="112fault">电话故障</option>
									<option value="radfault">宽带故障</option>
								</select>
							</td>
							<td class="wenzi" style="width:100px;">
								故障现象
							</td>
							<td class="wenzix">
								<select name="gzxx" id="gzxx" style="width: 150px" onchange="onchagefault(this.value);" class="you1">
									<option value="请选择">--请选择--</option>
									
								</select>
							</td>
							<td class="wenzi" style="width:100px;">
								联系电话
							</td>
							<td class="wenzix">
								<input type="text" name="slinkphone" id="slinkphone" style="width: 150px;"  class="you1"/>
						   </td>
						</tr>
						<tr>
							<td class="wenzi" style="width:100px;">
								联系人
							</td>
							<td class="wenzix">
								<input type="text" name="slinkman" id="slinkman" style="width: 150px;"  class="you1"/>
							</td>
							<td class="wenzi" style="width:100px;">
								联系地址
							</td>
							<td class="wenzix" colspan="3">
								<input type="text" name="slinkaddr" id="slinkaddr" style="width: 430px;"  class="you1"/>
							</td>
						</tr>
						<tr>
							<td class="wenzi" style="width:100px;">
								故障描述
							</td>
							<td class="wenzix" colspan="5" style="width:650px;">
								<textarea style="width: 680px;" rows="5" id="faultremark"></textarea>
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
	<input type="hidden" id="hidfaultdh"/>
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
	<jsp:include page="../business/phone_internet.jsp" flush="true" />
	
	</body>
</html>
