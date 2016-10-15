<%-- *******************************************************************************
**          *******         ******  *******     **       *****                   **  
**             *            *          *       ** **     *    *                  **
**             *   ******   ******     *      **   **    *****                   ** 
**             *                 *     *     ** *** **   *  *                    **
**             *            ******     *    **       **  *    *                  **
**                                                                               **               
** name:    "WebRoot/WEB-INF/template/telephone/charge/charge_phone.jsp"         **
** version: v10.1                                                                ** 
** author:  lvkui                                                                **
** date:    2011-7-22                                                            **
** desc:    电话收费结帐                                                         			 **
** modify:                                
**			将页面信息进行国际化 chenliang 2012-01-09                                ** 
**			增加营收少收功能     chenliang 2012-07-02							     **
******************************************************************************** --%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String imenuid = request.getParameter("imenuid");
	String groupid = request.getParameter("groupid");
	String userid = (String) session.getAttribute("userid");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
		<fmt:message key="Revenue.chargeCheckout" /><!-- 收费结帐 -->
	</title>
    <!-- jquery的js文件 -->
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="script/public/mainStyle.js" type="text/javascript"></script>
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<!-- blockUI弹出面板 -->
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
	<!-- jquery拖动插件 -->
	<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
	<!-- 导航专用 -->
	<script src="script/public/navigationbar.js" type="text/javascript"></script>
	<!-- 字符串处理、解析专用 -->
	<script src="script/public/tsdstring.js" type="text/javascript"></script>
	<!-- 收费结账专用js -->
	<script src="script/telephone/charge/charge_phone.jsp" type="text/javascript"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<!-- 导入css文件开始 -->
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<link href="style/css/telephone/charge/charge_phone.css" rel="stylesheet" type="text/css" />
	<script src="script/telephone/charge/charge_phone_multHht.js" type="text/javascript"></script>
	<script type="text/javascript" language="javascript">
		var GOLAB_FEEPAY_paytype ='2';
		var GOLAB_FEEPAY_payval = 0;
	    //页面加载
		function pageLoad()
		{
		    initialBar();
		    $("#ghSearchBox").select().focus();
			getywslUserPower();
		    initData("normalcustomer");
		    //电话明细数据显示和隐藏交替
		    $("#commonHthYfDetail h6").toggle(function(){
				$("#commonHthYfDetailTab").show();
			},function(){
				$("#commonHthYfDetailTab").hide();
			});
			//用户信息查询tab切换
			$("#ghuiJf,#ghuiJob,#ghuiCTC,#ghuiLTC,#ghuiGDF,#ghuiKF").click(function(){
				$("#ghuserInfoPanelTabRight .bolder").removeClass("bolder");
				$("#ghuserInfoPanelTabRight table[id^='ghuserInfoPanelTab']").hide();
				$("#" + $(this).attr("dst")).show();
				$(this).addClass("bolder");
			});
			
			$("#ghuserInfoPanel td[title]").live("click",function(){
				if($(this).parent("tr").next().attr("clickreturntr")=="clickreturntr"){
					$(this).parent("tr").next().remove();
				}
				else
				{
					var tdsize = $(this).parent("tr").find("td").size();
					$(this).parent("tr").after("<tr clickreturntr=\"clickreturntr\"><td colspan=\""+tdsize+"\" style=\"color:#F00;\">"+$(this).attr("title")+"</td></tr>");
				}
			});
			initOptions();//初始化少收方式列表
			//多合同号缴费初始化
			bindEventToGh();
		}
		/**********************************************************************
		function name:    printRep
		function:         设置发票参数。
		parameters:       reportname:票据名 params：票据参数  flag: 1:直接打印 其他:预览打印
		return:             
		description:      
		**********************************************************************/		
		function printRep(reportname,params,flag)
		{
			var urll = params+"&"+new Date().getTime();
			if(flag==1)
			{
				params = params.replace(new RegExp("&","g"),"");
				params = params.replace(new RegExp("=","g"),"_");
				//printWithoutPreview("charge/" + reportname,params);
				printWithoutPreview(reportname,params);
			}else
			{
				printThisReport1('<%=request.getParameter("imenuid")%>',
						reportname,urll,
						'<%=(String)session.getAttribute("userid")%>',
						'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
						'<%=(String)session.getAttribute("departname")%>',2);
			}	
		}
		
		/**********************************************************************
		function name:    printWithoutPreview
		function:         直接打印票据。
		
		parameters:       reportname:票据名 paramvalue：票据参数
		                  
		return:             
		
		description:      
		**********************************************************************/
		function printWithoutPreview(reportname,paramvalue)
		{
			document.getElementById('printReportDirect').contentWindow.RepPri(reportname,paramvalue);
		}
		/**********************************************************
		function name:    printThisReport1(menuid,tablename,param,userid,groupid,userdept)
		function:		  打印报表的通用函数(新)
		parameters:       menuid：菜单id
						  tablename：打印报表的标识(用来区分同一页面多个报表)	
						  param: 报表需要传递的参数 格式：&id=···&username=···
						  userid:用户id
						  groupid:所在权限组
						  userdept:所在区域
						  reportfalg:打开报表样式  1为模块页面打开  0或为undefined 在原页面窗口打开
		author：			  孙琳
		return:			  
		description:      报表文件统一放在WEB-INF/reportlets/com/tsdreport/下。
						  页面需添加的相关信息：
						  
							String path = request.getContextPath();
							String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
						  
						  <input type='hidden' id='thisbasePath' value='=basePath ' /> 	
		********************************************************/ 
		function printThisReport1(menuid,tablename,param,userid,groupid,userdept,reportfalg){
				//存放报表名称								
        		var ReportName=getReportName(menuid,tablename);
        		
        		var basepath = $('#thisbasePath').val();
        		//判断数据库中是否有此条记录
        		if(ReportName == undefined||ReportName == 'undefined'||ReportName == ''){
        			alert('<fmt:message key="charge_phone.addJournaling"/>'); //请添加报表配置！
        			return false;
        		}else{
        			if(reportfalg == undefined||reportfalg == 'undefined'||reportfalg == ''){
        				//进行打印操作
        				location.href = basepath + 'ReportServer?reportlet=/com/tsdreport/'+ReportName+param+'&userid='+userid+'&groupid='+groupid+'&userdept='+userdept+"&______" + new Date();
        			
        			}else if(reportfalg==1){
        				//进行打印操作		        				
        				basepath = basepath + 'ReportServer?reportlet=/com/tsdreport/'+ReportName+param+'&userid='+userid+'&groupid='+groupid+'&userdept='+userdept+"&______" + new Date();
        				//window.showModalDialog(basepath,window,"dialogWidth:760px; dialogHeight:580px; center:yes; scroll:no");
        				window.open(basepath);
        			}
        			
        		}					 
		}		
		
		//清空收费临时表
		function chargeClear(){
			fetchMultiPValue('chargephone.chargeclear',6,'&userid=<%=session.getAttribute("userid") %>');
		}
		/** chenliang 2012-07-02
		*  费用少收功能，弹出选择少收方式面板前要做的一些处理
		*  隐藏自由少收，按月少收方式少收显示内容，清空按费用类型显示数据
		*/
		function onLessFee(){
			var isAutoCalculate = $('#isAutoCalculate').val();
			if(isAutoCalculate == 'Y'){
				var ghDJ = $('#ghDJ').val();
				if(ghDJ == '' ){
					alert('请输入递交金额');
					$('#ghDJ').focus();
					return false;
				}else if(ghDJ == 0 || ghDJ < 0){
					alert('递交金额金额必须大于0');
					$('#ghDJ').focus();
					return false;
				}
			}
			//$('#feepaytr').hide();
			$('#freenesspay,#monthpay,#feetypepay').hide();
			$('#addfreefee,#feetypelist').val('');
			$('#feepaytypelist').html('');
			autoBlockForm('feetypediv', 120, 'feetypedivclose', "#ffffff", false);
		}
		//初始化少收方式列表
		function initOptions(){
			var sOptions = fetchMultiArrayValue('charge_phone.optionlist',6,'&tsection=fewtype');
			if(sOptions[0][0] != undefined){
				var optionDiv = '<option value="">请选择</option>';
				var nLen = sOptions.length;
				for(var i=0;i<nLen;i++){
					optionDiv += '<option value="'+sOptions[i][0]+'">'+getCaption(sOptions[i][2],'<%=languageType %>','')+'</option>';
				}
				$('#feetypelist').html(optionDiv);
			}
			//收费是否自动取整
			var isCeilCharge = fetchSingleValue('dbsql_phone.querytsd_ini',6,'&tsection=charge&tident=isCeilCharge');
			if(isCeilCharge != undefined){
				$('#isCeilCharge').val(isCeilCharge);
			}
			//是否向上取整或向下取整
			var integerType = fetchSingleValue('dbsql_phone.querytsd_ini',6,'&tsection=charge&tident=integerType');
			if(integerType != undefined){
				$('#integerType').val(integerType);
			}else{
				$('#integerType').val("");
			}			
			//收费是否自动通过递交计算应找
			var isAutoCalculate = fetchSingleValue('dbsql_phone.querytsd_ini',6,'&tsection=charge&tident=isAutoCalculate');
			if(isAutoCalculate != undefined){
				if(isAutoCalculate == 'Y'){
					$('#ghDJLbl,#ghDJ,#ghYzLbl,#ghYz').show();
					$('#isAutoCalculate').val(isAutoCalculate);
				}else{
					$('#ghDJLbl,#ghDJ,#ghYzLbl,#ghYz').hide();
				}
			}
		}
		
		//选择少收方式时触发的事件
		function sChangeOption(){
			var selectVal = $('#feetypelist').val();
			//freenesspay,monthpay,feetypepay
			if(selectVal == 'freenesspay'){//自由少收
				GOLAB_FEEPAY_paytype = '2';
				$('#monthpay,#feetypepay').hide();
				$('#freenesspay').show();
				$('#addfreefee').focus();
			}else if(selectVal == 'monthpay'){//按月少收
				GOLAB_FEEPAY_paytype = '1';
				$("#ghPayMonth").empty();
				var sOptions = fetchMultiArrayValue('revenue.fetchMonthFee',6,'&skrID=<%=userid %>');
				if(sOptions[0][0] != undefined){
					var payMonth = '<option value="">请选择</option>';
					for(var i = 0 ; i<sOptions.length;i++){
						payMonth += '<option value="'+sOptions[i][0]+'">'+sOptions[i][0]+'</option>';
					}
					$('#ghPayMonth').html(payMonth);
				}
				$('#freenesspay,#feetypepay').hide();
				$('#monthpay').show();
				$('#ghPayMonth').focus();
			}if(selectVal == 'feetypepay'){//按费用类型少收
				$('#freenesspay,#monthpay').hide();
				$('#feetypepay').show();
				//$('#feetypepay').focus();
				initBoxList();
				//$('#feepaytr').show();
			}
		}
		
		//选择少收类型之后触发事件
		function fewTypeSave(){			
			var fee;
			var selectVal = $('#feetypelist').val();//选择方式下拉列表
			//全局存放少收方式
			
			
			if (selectVal == 'freenesspay'){//自由少收
				var sFreeVal = $('#addfreefee').val();
				if (undefined != sFreeVal){
					if (sFreeVal == ''){
						alert('实收金额不允许为空');
						$('#addfreefee').focus();
					}else if(parseInt(sFreeVal,10) == 0){
						alert('实收金额不能为0');
						$('#addfreefee').focus();
					}else if(parseInt(sFreeVal,10) < 0){
						alert('实收金额不能小于0');
						$('#addfreefee').focus();
					}else{
						$('#ghSs').attr('disabled','disabled');
						$('#feetypedivclose').click();
						fee = parseFloat(sFreeVal,10).toFixed(2);
						$('#ghSs').val(fee);																
					}
				}
			}else if(selectVal == 'monthpay'){//按月少收
				var payMonth = $('#ghPayMonth').val() == undefined ? '' : $('#ghPayMonth').val();				
				btnFindClick('',payMonth);
				//$('#ghSs').attr('disabled','disabled');
			}else if(selectVal == 'feetypepay'){//按费用类型缴费
				var tagname = document.getElementsByName('thefields');
				var feelist = '';
		        for (var i = 0 ; i < tagname.length; i++){
		        	if (tagname[i].checked == true) {
		            	feelist += tagname[i].value + '+';
		            }
		        }
		       
		        
		        if(feelist!=''){
					//各分项费用组合相加
		            feelist = feelist.substring(0,feelist.lastIndexOf('+'));
		            GOLAB_FEEPAY_paytype = feelist;
			        fee = 0;
			        fee = fetchMultiArrayValue('charge_phone.feetypepay',6,'&feelist='+tsd.encodeURIComponent(feelist)+'&userid=<%=userid %>');
					GOLAB_FEEPAY_payval = feelist;	
					//去掉少收项之后需要缴的费用
					fee = $("#ghYJ").val() - fee;
					fee = parseFloat(fee,10).toFixed(2);
					$('#ghSs,#ghDJ').val(fee);
					setTimeout("$('#ghYz').val(0)",10);
					$('#ghSs').attr('disabled','disabled');
					
					GOLAB_FEEPAY_payval = fee;					
					$('#feetypedivclose').click();		        
		        }else{
		        	alert('请选择费用类型');
		        }
			}else{//其他
				alert('请选择少收方式');
				$('#feetypelist').focus();
			}
			//是否自动计算应找
			var isAutoCalculate = $('#isAutoCalculate').val();
			if(isAutoCalculate == 'Y'){
				var iFee = $('#ghDJ').val() - $('#addfreefee').val();
				$('#ghYz').val(parseFloat(iFee,10).toFixed(2));
			}
		}
		
		//加载复选费用列表
		function initBoxList(){
			var sOptions = fetchMultiArrayValue('charge_phone.optionlist',6,'&tsection=feetypepay');
			if(sOptions[0][0] != undefined){
				$('#listDiv').empty();
				var listDiv = '';
				var nLen = sOptions.length;
				var hfarr = [];//保存话费字段
				var fieldarr = [];//保存话费字段别名
				//存储值
				for(var i = 0 ; i<nLen ;i++){
					hfarr.push(sOptions[i][1]);
					fieldarr.push(getCaption(sOptions[i][2],'<%=languageType %>', ''));
					//listDiv += "<span class='spanstyle'><input type='checkbox' onclick='eidtClickForVal()' name='thefields' value='"+ sOptions[i][1] + "' style='width:16px;height:16px;'>"+ getCaption(sOptions[i][2],'<%=languageType %>', '') + "</span>";
				}
				//返回的是一条计算好的费用结果
				var fee = fetchMultiArrayValue('charge_phone.feetypepay',6,'&feelist='+tsd.encodeURIComponent(hfarr.join(','))+'&userid=<%=userid %>');
				var fLen = fieldarr.length;
				for(var i = 0 ; i< fLen; i++){
					listDiv += "<span class='spanstyle'><input type='checkbox' name='thefields' value='"+ sOptions[i][1] + "' style='width:16px;height:16px;'>"+ fieldarr[i] + "(￥"+fee[0][i]+")</span>";
				}
				$('#feepaytypelist').html(listDiv);
			}
		}

//只允许录入数据字符 0-9 和小数点
function tsdNumCheck(objTR){
   var txtval = objTR.value;
   if(/.*[\u4e00-\u9fa5]+.*$/.test(txtval)){ 
     alert("金额不能含有汉字！");
     objTR.value = ''; 
   }else{
     var key = event.keyCode;
     if((key < 48||key > 57) && key != 46 ){
       event.keyCode = 0;
     }else{
       if(key == 46){
         if(txtval.indexOf(".") != -1 || txtval.length == 0){
       	   event.keyCode = 0;
         }
       }
     }
   }
}


		//递交金额输入框回事事件
		function KeyDown_DJBox(event){
			if(event.keyCode==13)
			{
				//取应交金额的值
				var yj = $("#ghSs").val();
				yj=parseFloat(yj,10);
				//取递交金额的值
				var dj = $("#ghDJ").val();
				dj=parseFloat(dj,10);
				if(isNaN(dj)) dj=0;
				/*
				//检测是否已进行用户查询
				if($('#ghSearchBox').val() == '')
				{
					alert("请先进行用户查询");
					$("#ghDJ").val('');
					$("#ghSearchBox").select().focus();
					return false;
				}
				*/
				if(dj==0)
				{					
					alert("递交金额不能等于0");
					$("#ghDJ").select().focus();
					return false;
				}
				//判断递交金额是否小于应缴金额
				if(dj-yj<0)
				{
					alert("递交金额不能小于实收金额");
					$("#ghDJ").select().focus();
					return false;
				}
				//判断是否有递交金额
				//$("#ghSs").val($("#ghDJ").val()).select().focus();
				var ifee = dj-yj;
				$('#ghYz').val(parseFloat(ifee,10).toFixed(2))
				$("#ghSs").select().focus();
			}
		}
		//2012-9-25 yhy start
		//jira上 HBKGJ-34
		//改变实缴金额时，同时修改递交金额
		$(function(){
			$("#ghSs").bind('change',function(){		
				var ghSs = $("#ghSs").val();	
				$('#ghDJ').val(parseInt(ghSs,10));
				$('#ghYz').val(0);
			});
		});
		//2012-9-25 yhy end
		
		function changeSflx(){
			if($("#ghInfo").data("hth")!=""&&$("#ghInfo").data("hth")!=undefined){
				/*
				var res = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=pay_flag&tablename=hthhf&key=hzyf in(select tvalues from tsd_ini where tsection='charge' and tident='current paymonth') and hth='"+$("#ghInfo").data("hth")+"'");
				if(res=="N"){
					alert("请结清当前用户费用后才可以转换！");
				}else{
					var sflxstr="";
					var sflxtext=""
					var ressflx = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=sflx&tablename=hthdang&key=hth='"+$("#ghInfo").data("hth")+"'");
					if(ressflx=="cash"){
						sflxstr="prepayment";
						sflxtext="预存";
					}else{
						sflxstr="cash";
						sflxtext="现金";
					}
				*/	
					if(confirm("确定将该用户当前收费类型改为【现金】吗？")) {
						var restype = executeNoQuery("changehthdang.sflx",6,"&hthstr="+$("#ghInfo").data("hth"),'business');					
						if(restype=="true"||restype=="true"){							
							executeNoQuery("changehthdang.sflx_log",6,"&hthstr="+$("#ghInfo").data("hth")+"&userid="+$("#skrid").val(),'business');
							alert("操作成功！");
						}else{
							alert("操作失败！");
						}
					}
				//}
			}else{
				alert("请先查询用户！");
			}
		}
	</script>
	<style type="text/css">
	.spanstyle{display:-moz-inline-box; display:inline-block; width:125px;margin-left:15px;line-height:20px;font-size:12px}
	.spanstylept{display:-moz-inline-box; display:inline-block; width:85px;margin-left:10px;line-height:20px;font-size:12px}
	#ghStatus table span,#ghStatus table input,#ghStatus table select{font-size:14px;height:22px;line-height:22px;}
	#ghStatus table input{height:20px}
	#ghStatus{background:#eee;}
	#ghStatustb span,input,select{font-size:14px;height:22px;line-height:22px;margin-left:5px}
	</style>
  </head>
  
  <body style="text-align: left;overflow: auto;" onload="pageLoad();" onunload="chargeClear()">
		<div id="navBar">&nbsp;&nbsp; 
			<img src="style/icon/dot11.gif"/>
			<fmt:message key="global.location" />:
		</div>
		
     	<div id="gh" align="left" >
			<div id="ghBar" style="margin-left: 10px;">
				<table style="margin-top: 5px">
					<tr valign="middle">
						<td>
							&nbsp;&nbsp;<span style="font-size: 14px;font-weight: bold;"><fmt:message key="charge_phone.telNumber"/></span><!-- 电话号码: -->
						</td>
						<td>
							<input type="text" class="inputbox" id="ghSearchBox" style="margin-left:2px;font-size: 16px;" 
								name="ghSearchBox" onpaste="javascript:$('#ghSearchBox').trigger('keydown');" 
								onkeydown="KeyDown_PhoneBox(event);"/>
						</td>
						<td>
							&nbsp;
							<button class="tsdbutton" id="ghSearchByUserName" style="margin-bottom: 0px;"
							    onclick="btnFindClick('','','normal');">
								<fmt:message key="charge_phone.telQuery"/><!-- 查找 -->					
							</button>
						</td>
						<td>
							&nbsp;
							<button class="tsdbutton" id="ghSearchByUserName" style="margin-bottom: 0px;"
							    onclick="btnFindClick('','payment','real');">
								<fmt:message key="charge_phone.checkout"/><!-- 立即结算 -->			
							</button>
						</td>
						<td>
							&nbsp;
							<button class="tsdbutton" id="ghMultiHth" onclick="ghMultiHthJfPay('multi')" style="margin-bottom: 0px;padding:2px;">
								多合同号
							</button>
						</td>
						<!-- 
						ghOpenMultiHthForm('multi')
						<button class="tsdbutton" id="ghMultiHth" onclick="ghOpenMultiHthForm()" style="margin-bottom: 0px;padding:2px;">
							多合同号
						</button>
						<button class="tsdbutton" id="ghTuiFei" style="margin-bottom: 0px;padding-left:2px;padding-right:2px;display:none">
							拆机结账
						</button>
						-->
						<td>
							&nbsp;&nbsp;
							<button class="tsdbutton" id="ghTuiFeiBtn" onclick="ghTFtsk();" style="margin-bottom: 0px;padding-left:11px;padding-right:11px;" disabled>
								<fmt:message key="charge_phone.tuifei"/><!-- 退费 -->
							</button>
						</td>
						<td>
							&nbsp;&nbsp;
							<button class="tsdbutton" id="ghUserInfo" onclick="openDhUserInfoPanel();" style="margin-bottom: 0px;padding-left:11px;padding-right:11px;" disabled>
								<fmt:message key="charge_phone.userMsg"/><!-- 用户信息 -->
							</button>
						</td>
					</tr>
				</table>
				<br />
				<!-- 缴费月份
				<span id="payMonthSpan" style="display:none">
					&nbsp;&nbsp;<span style="font-size: 14px;font-weight: bold;">缴费月份:</span>
					<select style="width: 120px;font-size: 14px;font-weight: bold;" id="ghPayMonth" onchange="btnFindClick();"></select>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</span>
				-->
			</div>
			<div id="ghFP">
				<!-- 多合同号缴费时，显示多合同号 -->
				<div id="multiHths"></div>
				<table id="ghInfo" style="display:none"></table>
				<jsp:include page="rev_bill_new.jsp"></jsp:include><!-- 实时余额：  元 -->
				<div id="ghYHYE" tip1="<fmt:message key="charge_phone.RealTimeBalance"/>" tip2="<fmt:message key="charge_phone.InTheCurrent"/>"><!-- 当前月费用：  元 -->
					<span class="tip" align="left"><fmt:message key="charge_phone.InTheCurrentCost"/><!-- 当前月份费用： 元 --></span>
					<span class="jfed"></span>
					<span class="jfghuiDelDate"></span>
					<span class="jfqfys"></span>
					<span class="jfkdstoptime"></span>
					<br />
					<span class="jflastjf" style="color:#00F"></span>
					<br />
					<span class="jfsuccessflag" style="color:#000;font-weight:bold;"></span>
				</div>
			</div>
				
			<div id="commonHthYfDetail">
				<h6 style="width: 60px"><a onclick="showDetialofHth();" href="#"><fmt:message key="charge_phone.HFMX"/><!-- 话费明细 --></a></h6>
				<table id="commonHthYfDetailTab" width="720" border="1" bordercolor="#eeeeee"
					cellspacing="0" cellpadding="1"
					style="background-color: #eeeeee; border-collapse: collapse;display:none"
					bgcolor="#eeeeee"></table>
			</div>
			<div id="ghStatus">
				<div id="ghStatustb" style="width: 660px;float: left">
					<span id="ghYJLbl"><fmt:message key="charge_phone.bcShouldPay"/><!-- 本次应缴 -->：</span>
					<input type="text" id="ghYJ" name="ghYJ" readonly="readonly"
								style="width: 120px;font-weight:bold;color:#000;" />
					<span id="ghDJLbl" style="display: none">递交金额<!-- 递交金额 -->：</span>
					<input type="text" id="ghDJ" name="ghDJ" onkeydown="KeyDown_DJBox(event);"
						style="width: 120px;font-weight:bold;color:#000;display: none" />
					<span id="ghSsLbl"><fmt:message key="charge_phone.PaidinAmount"/><!-- 实收金额 -->：</span>
					<input type="text" id="ghSs" name="ghSs"
								maxlength="10"
								style="ime-mode: disabled; width: 120px;ime-mode:disabled"
								onpaste="return !clipboardData.getData('text').match(/\D/)"
								ondragenter="return   false"
								onkeypress="javascript:tsdNumCheck(this)"
								onkeydown="KeyDown_SsjeBox(event);" onkeyup="KeyUp_SsjeBox()"/>
					<span id="ghYzLbl" style="display: none">应找金额<!-- 应找金额 -->：</span>
					<input type="text" id="ghYz" name="ghYz" readonly="readonly" style="width: 120px;font-weight:bold;color:#000;display: none" />
					<span><fmt:message key="charge_phone.PayMoneyWay"/><!-- 付费方式 -->：</span>
					<select id="ghFFFs" style="width: 120px;" onchange="payitem_change();"></select>
					<span id="tsdSkvalSpan" style="color: blue;margin-left: 23px;display: none"><span id="pjnumber"></span></span>
					<input id="tsdSkvalText" type="text" style="width: 120px;display: none"/>
					<span id="changeCashText" style="color:red;display:none;">预存结清转现金</span><input type="checkbox" id="changeCash" onclick="changeCashON()" style="display:none;"/>
					<!--<button id="xjycchange" class="tsdbutton" onclick="changeSflx();" style="display:none;">
					预存转现金
					</button>-->
				</div>
				<table  width="640px" cellpadding="5px" cellspacing="2px">
					<tr>
						<td colspan="8" align="center">
							<span class="spanstylept" style="margin-left: 70px;display:none;">
								<input type="checkbox" id="ghPayNotPrint" onclick="$('#ghSs').select().focus()" />
								打印
							</span>
							<span class="spanstylept" style="margin-left: 70px;display:none;">
								<input type="radio" id="prePayReport" name="ghPayReport" value="combined" onclick="$('#ghSs').select().focus()"/>
								分月打印
							</span>
							<span class="spanstylept" style="margin-left: 70px;display:none;">
								<input type="radio" id="comPayReport" name="ghPayReport" value="prepay" onclick="$('#ghSs').select().focus()"/>
								合并打印
							</span>
							<span id="printType"></span><!-- 打印发票或收据 -->
						</td>
					</tr>
				</table>
			</div>
			<div id="ghButtons">
				<!-- 当日累计收费：xxx元 -->
				<!--<span id="sumSkrFee" style="font-size: 14px;font-weight: bold;float: left;margin-top: 10px;display: none"></span>-->
				<div style="margin-left: 440px">
					<button class="tsdbtn" id="ghUnpaymentPrint" style="width: 100px;"  onclick="ghOpenUnpaymentDiv();" style="display:none;"
						 disabled="disabled">
						自动冲账打印<!-- 未收费打印 -->
					</button>
					<span id="lessFeeBtn" style="display: none">
						<button class="tsdbtn"  onclick="onLessFee();" style="width: 80px;">
							<fmt:message key="charge_phone.lessfee"/><!-- 少收 -->
						</button>
						<span style="visibility: hidden;">__</span>
					</span>
					<button class="tsdbtn" id="ghsave" style="width: 80px;" disabled="disabled" onclick="onSave();">
						<fmt:message key="charge_phone.save"/><!-- 保存 -->
					</button>
					<span style="visibility: hidden;">__</span>
					<button class="tsdbtn" style="width: 80px;" onclick="ghClearInfo();pageUnLoad();">
						<fmt:message key="charge_phone.reset"/><!-- 重置 -->
					</button>
				</div>
			</div>
		</div>
		
		<!-- 用户电话基本信息 -->
		<div class="neirong" id="ghuserInfoPanel" style="display: none;width: 743px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
						<div class="top_03" id="titlediv">
							<fmt:message key="charge_phone.user"/><!-- 用户 -->	<span style="font-size: 16px;" id="ghuisRealNameTitle"></span> <fmt:message key="charge_phone.BasicInformation"/><!-- 的基本信息 -->
						</div>
						<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
					</div>
					<div class="top_01right">
						<a href="javascript:;"	onclick="javascript:$('#ghuserInfoPanelclose').click();"><fmt:message key="charge_phone.close"/><!-- 关闭 --></a>
					</div>
				</div>
				<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>
			</div>

			<div class="midd" style="background-color: #FFFFFF; text-align: left; overflow: hidden; width: 758px;*width:742px;">
				<table>
					<tr>
						<td>
							<table id="ghuserInfoPanelTab" width="240" border="1" bordercolor="#eeeeee" cellspacing="0" cellpadding="1"
								style="background-color: #eeeeee; border-collapse: collapse; float: left;" bgcolor="#eeeeee">
								<tr>
									<td width="70">
										<fmt:message key="charge_phone.telphoneNnmber"/><!-- 电话号码 -->
									</td>
									<td width="170">
										<span id="ghuiDh"></span>
									</td>
								</tr>
								<tr>
									<td>
										<fmt:message key="charge_phone.hth"/><!-- 合同号 -->
									</td>
									<td>
										<span id="ghuiHth"></span>
									</td>
								</tr>
								<tr>
									<td>
										<fmt:message key="charge_phone.username"/><!-- 用户名 -->
									</td>
									<td>
										<span id="ghuiYhmc"></span>
									</td>
								</tr>
								<tr style="display:none">
									<td>
										<fmt:message key="charge_phone.TrafficLevels"/><!-- 话务级别 -->
									</td>
									<td>
										<span id="ghuiHwjb"></span>
									</td>
								</tr>
								<tr>
									<td>
										<fmt:message key="charge_phone.telfunction"/><!-- 电话功能 -->
									</td>
									<td>
										<span id="ghuiDhgn"></span>
									</td>
								</tr>
								<tr>
									<td>
										<fmt:message key="charge_phone.state"/><!-- 状态 -->
									</td>
									<td>
										<span id="ghuiStatus"></span>
									</td>
								</tr>
								<tr>
									<td>
										<fmt:message key="charge_phone.BillingDate"/><!-- 计费日期 -->
									</td>
									<td>
										<span id="ghuiStartDate"></span>
									</td>
								</tr>
								<tr>
									<td>
										<fmt:message key="charge_phone.address"/><!-- 地址 -->
									</td>
									<td>
										<span id="ghuiYhdz"></span>
									</td>
								</tr>
								<tr>
									<td>
										<fmt:message key="charge_phone.area"/><!-- 区域 -->
									</td>
									<td>
										<span id="ghuiYwArea"></span>
									</td>
								</tr>
								<tr>
									<td>
										<fmt:message key="charge_phone.userType"/><!-- 用户类别 -->
									</td>
									<td>
										<span id="ghuiYhlb"></span>
									</td>
								</tr>
								<tr>
									<td>
										<fmt:message key="charge_phone.password"/><!-- 密码 -->
									</td>
									<td>
										<span id="ghuiMima"></span>
									</td>
								</tr>
								<tr>
									<td>
										<fmt:message key="charge_phone.Level1Department"/><!-- 一级部门 -->
									</td>
									<td>
										<span id="ghuiBm1"></span>
									</td>
								</tr>
								<tr>
									<td>
										<fmt:message key="charge_phone.Level2Department"/><!-- 二级部门 -->
									</td>
									<td>
										<span id="ghuiBm2"></span>
									</td>
								</tr>
								<tr>
									<td>
										<fmt:message key="charge_phone.Level3Department"/><!-- 三级部门 -->
									</td>
									<td>
										<span id="ghuiBm3"></span>
									</td>
								</tr>
								<tr>
									<td>
										<fmt:message key="charge_phone.Level4Department"/><!-- 四级部门 -->
									</td>
									<td>
										<span id="ghuiBm4"></span>
									</td>
								</tr>
								<tr>
									<td>
										<fmt:message key="charge_phone.OpenMachineDate"/><!-- 拆机日期 -->
									</td>
									<td>
										<span id="ghuiDelDate"></span>
									</td>
								</tr>
								<tr><td colspan="2">&nbsp;</td></tr>
							</table>
						</td>
						<td valign="top">
							<table id="ghuserInfoPanelTabRight" width="516" border="1"
								bordercolor="#eeeeee" cellspacing="0" cellpadding="1"
								style="border-collapse: collapse; float: right;">
								<tr>
									<td width="516" colspan="3">
										<a id="ghuiJf" class="ghuserInfoTitle bolder" dst="ghuserInfoPanelTabJF"><fmt:message key="charge_phone.jiaofeiHistory"/><!-- 缴费历史 --></a>
										<a id="ghuiJob" class="ghuserInfoTitle" dst="ghuserInfoPanelTabJOB"><fmt:message key="charge_phone.ChangesInTheBusiness"/><!-- 业务变更情况 --></a>										
										<a id="ghuiCTC" class="ghuserInfoTitle" dst="ghuserInfoPanelTabCTC"><fmt:message key="charge_phone.FlatratePackage"/><!-- 包月套餐 --></a>
										<a id="ghuiLTC" style="display:none" class="ghuserInfoTitle" dst="ghuserInfoPanelTabLTC"><fmt:message key="charge_phone.DiscountPackage"/><!-- 优惠套餐 --></a>
										<a id="ghuiGDF" class="ghuserInfoTitle" dst="ghuserInfoPanelTabGDF"><fmt:message key="charge_phone.FixedCosts"/><!-- 固定费用 --></a>
										<a id="ghuiKF" class="ghuserInfoTitle" dst="ghuserInfoPanelTabKF"><fmt:message key="charge_phone.DebitsInformation"/><!-- 扣费信息 --></a>
									</td>
								</tr>
								<tr>
									<td colspan="3">
										<div style="height: 320px;">
											<table id="ghuserInfoPanelTabJOB" width="516" border="1"
												bordercolor="#eeeeee" cellspacing="0" cellpadding="1"
												style="display: none; background-color: #eeeeee; border-collapse: collapse"
												bgcolor="#eeeeee"></table>
											<table id="ghuserInfoPanelTabJF" width="516" border="1"
												bordercolor="#eeeeee" cellspacing="0" cellpadding="1"
												style="display: none; background-color: #eeeeee; border-collapse: collapse"
												bgcolor="#eeeeee"></table>											
											<table id="ghuserInfoPanelTabKF" width="506" border="1"
												bordercolor="#eeeeee" cellspacing="0" cellpadding="1"
												style="display: none; background-color: #eeeeee; border-collapse: collapse"
												bgcolor="#eeeeee"></table>
											<table id="ghuserInfoPanelTabGDF" width="516" border="1"
												bordercolor="#eeeeee" cellspacing="0" cellpadding="1"
												style="display: none; background-color: #eeeeee; border-collapse: collapse"
												bgcolor="#eeeeee"></table>
											<table id="ghuserInfoPanelTabCTC" width="516" border="1"
												bordercolor="#eeeeee" cellspacing="0" cellpadding="1"
												style="display: none; background-color: #eeeeee; border-collapse: collapse"
												bgcolor="#eeeeee"></table>
											<table id="ghuserInfoPanelTabLTC" width="516" border="1"
												bordercolor="#eeeeee" cellspacing="0" cellpadding="1"
												style="display: none; background-color: #eeeeee; border-collapse: collapse"
												bgcolor="#eeeeee"></table>

										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<div class="midd_butt" style="width:728px;">
				<button type="button" class="tsdbutton" id="ghuserInfoPanelclose">
					<fmt:message key="charge_phone.close"/><!-- 关闭 -->
				</button>
			</div>
		</div>
		<!-- 区域 -->
		<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea")%>' />
		<!-- 工号 -->
		<input type="hidden" id="skrid" name="skrid" value='<%=session.getAttribute("userid")%>' />
		<!-- basepath -->
		<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
		<!-- 菜单ID -->
		<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid%>' />
		<input type="hidden" id="zid" name="zid" value='<%=groupid%>' />
		<input type="hidden" id="userid" name="userid" value='<%=userid%>'/>
		<!-- 默认选中合并打票 -->
		<input type="hidden" id="defaultCheckComb" value="false" />	
		<input type="hidden" id="tfbuttenright"/>
		<!-- 打印票据 -->
		<iframe id="printReportDirect" style="width: 120px; height: 0px; visibility: visible" src="print.jsp"></iframe>
		
		<div class="neirong" id="choosePrintForDhJF" style="display:none;width:620px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02"><img src="style/images/neibut01.gif" /></div>
						<div class="top_03" id="titlediv">选择打印类型</div>
						<div class="top_04"><img src="style/images/neibut03.gif" /></div>
					</div>
				</div>
				<div class="top02right"><img src="style/images/toptiaoright.gif" /></div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;text-align:center;width:618px;">
				<div style="padding-top:20px;padding-bottom:20px;">
					<h3>缴费成功，请选择打印类型 :</h3>
					<br />
					<button id="ghprintDirectDh" class="tsdbutton" onclick="chargePrint('phoneInvoice')">打印发票</button>		
					<button id="ghprintInDirectDh" class="tsdbutton" onclick="chargePrint('phoneReceipt')">打印收据</button>
					<button id="ghNoPrint" class="tsdbutton" onclick="javascript:setTimeout($.unblockUI,1)">不打印</button>
				</div>
			</div>
			<div class="midd_butt"></div>
		</div>
	<input type="hidden" id="rptPrintLsz"/><input type="hidden" id="rptPrintReport"/>
	<input type="hidden" id="isCeilCharge"/>
	<input type="hidden" id="charge_integerType"/><!--是否根据业务类型来取整-->	
	<input type="hidden" id="integerType"/><!--取整类型，向上取整还是向下取整-->
	<input type="hidden" id="phoneInvoiceIsabled"/><input type="hidden" id="phoneReceiptIsabled"/><input type="hidden" id="printtyperight"/>
	<input type="hidden" id="displaySumFee"/><input type="hidden" id="isAutoCalculate"/>
	
	<div class="neirong" id="feetypediv" style="display: none; width: 620px">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
					<div class="top_03" id="feetypetitle">选择少收方式</div>
					<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
				</div>
				<div class="top_01right">
					<a href="#" onclick="javascript:$('#feetypedivclose').click();"><fmt:message key="global.close" /></a>
				</div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>
		</div>
		<div class="midd">
			<form action="#" name="feeform" id="feeform" onsubmit="return false;">
				<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="10">
					<tr style="height: 50px">
						<td class="labelclass" style="width: 200px;font-size: 14px;">少收方式</td>
						<td class="tdstyle" width="420px" style="font-size: 14px;">
							<select id="feetypelist" onchange="sChangeOption()" style="width: 180px;margin-left: 15px"></select>
						</td>
					</tr>
					<tr style="height: 50px;display: none" id="freenesspay">
						<td class="labelclass" style="width: 200px;font-size: 14px;">
							实收金额
						</td>
						<td class="tdstyle" width="420px" style="font-size: 14px;">
							<input type="text" class="textclass" id="addfreefee"
								maxlength="10"
								onpaste="return !clipboardData.getData('text').match(/\D/)"
								ondragenter="return   false"
								onkeypress="javascript:tsdNumCheck(this)"
								style="width: 180px;margin-left: 15px;ime-mode:disabled"/>
						</td>
					</tr>
					<tr style="height: 50px;display: none" id="monthpay">
						<td class="labelclass" style="width: 200px;font-size: 14px;">
							缴费月份
						</td>
						<td class="tdstyle" width="420px" style="font-size: 14px;">
							<select style="width: 180px;font-size: 14px;font-weight: bold;margin-left: 15px" id="ghPayMonth"></select>
						</td>
					</tr>
					<tr style="height: 50px;display: none" id="feetypepay">
						<td class="dflabelclass" style="width: 200px;font-size: 14px;">
							费用类型
						</td>
						<td width="420px" style="font-size: 14px;">
							<div id="feepaytypelist" style="width: 420px"></div>
						</td>
					</tr>
					
				</table>
			</form>
		</div>
		<div class="midd_butt">
			<button type="submit" class="tsdbtn" id="subBtn" onclick="javascript:fewTypeSave();"><fmt:message key="global.ok" /></button>
			<button type="button" class="tsdbtn" id="feetypedivclose" style="width: 60px"><fmt:message key="global.close" /></button>
		</div>
	</div>
	
	
	<!-- 电话未收费打印 -->
		<div class="neirong" id="unpaymentPrintDiv"
			style="display: none; width: 620px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							缴费打印方式
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>

			<div class="midd"
				style="background-color: #FFFFFF; text-align: center; width: 618px;">
				<div style="padding-top: 20px; padding-bottom: 20px;">
					<h3>
						请选择收据打印方式 :
					</h3>
					<br />
					<button id="ghUnpaymentPrintDirectRe" class="tsdbutton" onclick="unPaymentPrintDo(1)">
						直接打印
					</button>
					<button id="ghUnpaymentPrintInDirectRe" class="tsdbutton"
						onclick="unPaymentPrintDo(0)">
						预览打印
					</button>
					<button id="ghUnpaymentNoPrintRe" class="tsdbutton" onclick="unPaymentPrintDo(2)">
						不打印
					</button>
				</div>
			</div>
			<div class="midd_butt">

			</div>
		</div>
	<!-- 未收费打印 -->
	<input type="hidden" id="unpaymentHth" />
	<input type="hidden" id="unpaymentLsh" />
	<!-- 立即结账的确认信息 -->
	<input type="hidden" id="paymentPrompt1" value="<fmt:message key='charge_phone.paymentPrompt1'/>" />
	<input type="hidden" id="paymentPrompt2" value="<fmt:message key='charge_phone.paymentPrompt2'/>" />
	
	
	<!-- 多合同号缴费 start -->
		<div class="neirong" id="ghMultiHthJf" style="display:none; width: 720px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							电话多合同缴费
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;" onclick="javascript:$('#ghMultiHthJfclose').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>

			<div class="midd" style="background-color: #FFFFFF; text-align: left; width:718px; overflow-x: hidden;">
				<table>
					<tr>
						<td>
							<div style="line-height:22px;margin:0px;padding:0px;">
								<b>合同号列表</b>
								<span title="选中列表中要删除的合同号，按Delete键删除">(Delete键删除)</span>
							</div>
							<select id="ghMultiHths" style="width:160px;height:320px;overflow-y:auto;" multiple="multiple">
								
							</select>
						</td>
						<td style="vertical-align:top;">						
							<div style="line-height:22px;margin:0px;padding:0px;font-weight:bold;">手动输入</div>
							电话(合同号):
								<!-- 
								<select id="mulhthtype"> 
									<option value="dh">电话</option>
									<option value="hth">合同号</option>
								</select>
								 -->
							<input id="ghSingleAddInput" type="text" />
							<button class="tsdbutton" style="margin-bottom: 0px;line-height:22px;" onclick="ghSingleAddToHths('accurate')">精确查询</button>
							<button class="tsdbutton" style="margin-bottom: 0px;line-height:22px;" onclick="ghSingleAddToHths('fuzzy')">模糊查询</button>
							<table>
								<tr>
									<td colspan="8">
										<div id="ghMultiHthDetTab_Container" >
											<table id="ghMultiHthDetTab" ></table>
										</div>
									</td>									
								</tr>								
							</table>
							<div id="multiPayYhxz_Container"></div>
							<div style="position: absolute;top: 245px;width: 500px;background:#F6F6F6;margin-top:5px;" 
								class="multi_help_afont">
								<div style="height:25px; background:#FFF;">
									<span><img src="style/images/public/tishi.png"></span>
									<span style="color:#C00; line-height:25px;padding-left:5px; font-weight:bold;">
										温馨提示
									</span>
								</div>			
								<div style="border-bottom:1px dashed #B5B5B7;">1.多合同号缴费，限制缴费合同号个数在2~10个之间。</div>									
								<div style="margin-top:-5px;border-bottom:1px dashed #B5B5B7;">2.一次性查找多个合同号，请用逗号隔开，并使用【精确查询】查找。</div>							
								<div style="margin-top:-5px;border-bottom:1px dashed #B5B5B7;">3.多合同号缴费，缴费金额不允许多收或少收。</div>
							</div>
						</td>
					</tr>
				</table>
				
			</div>

			<div class="midd_butt">
				<button type="button" class="tsdbutton" id="ghMultiHthJfSure" onclick="ghMultiHthJfPay('multi')">
					确定
				</button>
				<button type="button" class="tsdbutton" id="ghMultiHthJfclose">
					关闭
				</button>
			</div>
		</div>				
		<!-- 多合同号缴费 end -->
		
		<!-- 退费提示 start -->
		<div class="neirong" id="ghTFfrom" style="display:none; width: 670px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							退费信息提示
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;" onclick="javascript:setTimeout($.unblockUI,15);">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color: #FFFFFF; text-align: left; width:668px; overflow-x: hidden;">
				<table>
					<tr>
						<td>备注说明</td>
						<td>
						  <textarea name="TFBz" id="TFBz" rows="4" cols="90" maxlength="50"  onpropertychange="TextUtil.NotMax(this)"></textarea>
						</td>
					</tr>					
				</table>				
			</div>
			<div class="midd_butt">
				<button type="button" class="tsdbutton" id="ghtfsave" onclick="ghTuiFeiCfm('back');">
					确定
				</button>
				<button type="button" class="tsdbutton" id="ghtclos" onclick="javascript:setTimeout($.unblockUI,15);">
					关闭
				</button>
			</div>
		</div>
		<input type="hidden" id="multihthsel"/>
		<input type="hidden" id="multihthyjf"/>
  </body>
</html>
