<%----------------------------------------
	name: rad_busi_Payfee.jsp
	author: wangli
	version: 1.0 
	description: 宽带缴费 
	Date: 2011-09-10
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.tsd.service.util.Log"%>
<%
	String sUserId = (String) session.getAttribute("userid");
	String sArea = (String) session.getAttribute("chargearea");
	String sDepart = (String) session.getAttribute("departname");	
	String sMenuid = request.getParameter("imenuid");
	String sGroupid = request.getParameter("groupid");	
	String ywarea = (String) session.getAttribute("userarea");	
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	String iconpath = basePath + "style/icon/";	
	String theTime=Log.getThisTime();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="plug-in/jquery/ui/jquery.layout.js" type="text/javascript"></script>
	<script src="plug-in/jquery/ui/jquery-ui-1.7.1.custom.js" type="text/javascript"></script>
	<script src="script/broadband/business/broadbandservice.js" type="text/javascript"></script>
	<script src="script/broadband/business/radbusiprint.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script> <!-- 弹出面板需要导入js文件 -->	
    <script type="text/javascript" src="script/public/tsdpower.js"></script><!-- 页面权限控制 -->
    <script type="text/javascript" src="script/public/main.js"></script>
    <script type="text/javascript" src="script/public/mainStyle.js"></script>
    <script type="text/javascript" src="script/public/transfer.js"></script>	    
    <script type="text/javascript" src="script/public/revenue.js" ></script>
    <script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    	
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
	<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
	<style type="text/css">
		#input-Unit{ float:left; width:100%; text-align:center;}
		#input-Unit .title_rad{ width:100%; height:22px; border-bottom:1px solid #C8D8E5;  text-align:center; color:#3C3C3C; line-height: 22px; font-weight:bold; background:#CCCCFF;}		
		.tsdbutton_rad{width:70px; height:22px;background: url(style/images/public/buttonsbg.jpg) repeat-x; border: #CCCCCC 1px solid; cursor: pointer;}		 
	</style>	
	<script type="text/javascript">
		var mylayout;	
		var BusiFeeNames = "";
		var BusiFeeValues = "";							
		$(document).ready(function () {
			//利用布局控件设置布局			
			mylayout = $('body').layout({ 
				applyDefaultStyles: true,
				east__size:416,
				center__resizable:false,
				north__resizable:false,
				south__resizable:false,
				north__closable:false,
				east__closable:false,
				south__closable:false,
				center__closable:false,									
				spacing_open:1										
			});	
			getDict();
			initValue();
			setEastWidth();					
			$("#navBar").append(genNavv());	
			getidtype();
			
			//实收输入框的回车事件
		  $("#kdss").keydown(function(event){
			  
				if(event.keyCode==13)
				{
					if($("#txtacct")==undefined || $("#txtacct").val()=="" )
					{
						alert("请先查询用户");
						$("#queryvalue").focus();
						return false;
					}
					
					if($.browser.mozilla)
					{
						if(!/^[0-9]+(.[0-9]{0,2})?$/.test($("#kdss").val()))
						{
							alert("请输入正确的实收金额,至多两位小数");0
							$("#kdss").select();
							$("#kdss").focus();
							return false;
						}
					}
/* 					var paytypee = parseInt($("#kdInfo").data("paytype"),10);
					var usertypee = parseInt($("#kdInfo").data("usertype"),10);
					var basefee = parseFloat($("#kdInfo").data("basefee"),10);
					var ye = parseFloat($("#kdye").val(),10); */
					var dj = parseFloat($("#kddj").val(),10);
					var ss = parseFloat($("#kdss").val(),10);
	/* 				var newbusinessfee = parseFloat($("#kdInfo").data("newbusinessfee"),10); */
					
					if($.trim($("#kddj").val())=="")
					{
						alert("请输入递交金额");
						$("#kddj").focus();
						return false;
					}
					if($.trim($("#kdss").val())=="" || isNaN(parseFloat($.trim($("#kdss").val()),10)))
					{
						alert("请输入实收金额");
						$("#kdss").focus();
						return false;
					}
					
					if(ss<=0)
					{
						alert("实收金额不能为0");
						$("#kdss").focus();
						return false;
					}
					
					if(ss>dj)
					{
						alert("实收金额不能大于递交金额");
						$("#kdss").focus();
						return false;
					}
					
					/* if(usertypee!=2 && usertypee!=4)
					{//非公费用户
						if(paytypee>=10)
						{
							if((ss * 1.0) % (basefee+newbusinessfee) != 0)
							{
								var altinfo = "用户";
								altinfo += $("#kdInfo").data("username");
								altinfo += "为外部用户,"						
								altinfo += "缴费金额必须为基本费用加新业务费的整数倍,基本费用为";
								altinfo += $("#kdInfo").data("basefee");
								altinfo += "新业务费为";
								altinfo += $("#kdInfo").data("newbusinessfee");
								alert(altinfo);
								$("#kdSs").select();
								$("#kdSs").focus();
								return false;
							}
						}
						else
						{				
							if(ss<basefee+newbusinessfee-ye)
							{
								var alertinfo = "用户";
								alertinfo += $("#kdInfo").data("username");
								alertinfo += "基本费为:";
								alertinfo += $("#kdInfo").data("basefee");
								alertinfo += ",新业务费为:";
								alertinfo += $("#kdInfo").data("newbusinessfee");
								alertinfo += ",现有余额:";
								alertinfo += $("#kdInfo").data("kdye");
								alertinfo += ",至少应该续费：";
								alertinfo += (basefee+newbusinessfee-ye);
								alert(alertinfo);
								$("#kdSs").select();
								$("#kdSs").focus();
								return false;
							}
						}
					}
					else
					{//公费用户
						if(paytypee>=10)
						{
							if((ss * 1.0) % (newbusinessfee) != 0)
							{
								var altinfo = "用户";
								altinfo += $("#kdInfo").data("username");
								altinfo += "为外部公费用户,"						
								altinfo += "缴费金额必须为新业务费的整数倍,";
								altinfo += "新业务费为：";
								altinfo += $("#kdInfo").data("newbusinessfee");
								alert(altinfo);
								$("#kdSs").select();
								$("#kdSs").focus();
								return false;
							}
						}
						else
						{				
							if(ss<newbusinessfee)
							{
								var alertinfo = "用户";
								alertinfo += $("#kdInfo").data("username");
								alertinfo += "为公费用户,新业务费为:";
								alertinfo += $("#kdInfo").data("newbusinessfee");
								alertinfo += ",至少应该续费：";
								alertinfo += (newbusinessfee);
								alert(alertinfo);
								$("#kdSs").select();
								$("#kdSs").focus();
								return false;
							}
						}
					} */
					$("#kdyz").val(dj-ss);
					$("#kdsave").click();
				}
			  
			  
			  
			  }).keyup(function(){
				  
				  if($.trim($("#kdss").val())=="")
					{
						$("#kdyz").val("");
					}
					else
					{
						var dj = parseFloat($("#kddj").val(),10).toFixed(2);
						var ss = parseFloat($("#kdss").val(),10).toFixed(2);
						var yj = parseFloat($("#txtmoney").val(),10).toFixed(2);
						dj = parseFloat(dj,10);
						ss = parseFloat(ss,10);
						yj = parseFloat(yj,10);
						
						if(isNaN(dj)) dj = 0;
						if(isNaN(ss)) ss = 0;
						if(isNaN(yj)) yj = 0;
						
						if(ss>dj)
						{
							alert("实收金额不能大于递交金额");
							var ssv = $("#kdss").val();
							$("#kdss").val(ssv.substring(0,ssv.length-1));
							$("#kdss").select();
							$("#kdss").focus();
							return false;
						}
						$("#kdyz").val((dj-ss).toFixed(2));
					}

			  }).blur(function(){
				        //中石油定制 宽带实收金额必须等于宽带套餐费用不可以多收和少收 
						var ss = parseFloat($("#kdss").val(),10).toFixed(2);
						var yj = parseFloat($("#txtmoney").val(),10).toFixed(2);
						var dj = parseFloat($("#kddj").val(),10).toFixed(2);
						dj = parseFloat(dj,10);
						ss = parseFloat(ss,10);
						yj = parseFloat(yj,10);
						
						if(ss <= dj && ss != yj){
							alert("实收金额应等于应缴金额");
							$("#kdss").val("");
							$("#kdss").select();
							$("#kdss").focus();
							$("#kdyz").val("");
							return false;
						}
			  });
		});
		//清空用户资料显示框
		function clear(){
			$("#input-Unit :text").val("");
			$("#input-Unit select").val("");
			$("#lastpay").html("");
			$("#lastpay").attr("disabled","disabled");
		}		
		//已知值控件赋初值
		function initValue(){				 									 			
			$("#radpayitem").val("cash");	
			$("#queryvalue").focus();
			$("#kdYz").val("");
			$("#input-Unit :text").attr("readonly", true);  //使所有input控件只读
			$("#input-Unit :text").val('');  //清空所有text元素
			$("#txtchecknum").attr("readonly",false);
			$("#txtchecknum").val("");
			$("#months").text('');
			$("#cycle").text('');
			$("#description").hide();
			$("#proid").show();
			$("#workmemo").attr("readonly", false);         //操作备注可写
			$("#workmemo").val(""); 				
			$("#kdss").attr("readonly", false);         
			$("#kdss").val("");
			$("#kddj").attr("readonly", false);         
			$("#kddj").val("");
			$("#divzp").hide();		
		}
		//填充下拉框内容
		function getDict(){			         
	        $.ajax({
				url:"phone_querydate?func=query",
				async:true,//异步
				cache:false,
				timeout:20000,//1000表示1秒
				type:'post',
				success:function(xml,textStatus)
				{					
				    if (InvalidSessionPro(xml)) {return false};
				    //取缴费方式 返回的是html格式				    
				    var payitem = xml.substring(xml.indexOf("<radpayitem=")+12,xml.indexOf("radpayitem/>"));
				   // var radtype = xml.substring(xml.indexOf("<radpkg=")+8,xml.indexOf("radpkg/>"));		
				    var sCallPayType = xml.substring(xml.indexOf("<CallPayType=")+13,xml.indexOf("CallPayType/>"));		    
				  //  $("#pkgid").html(radtype);
					$("#radpayitem").html(payitem);
					$("#radpayitem").val("cash");
					$("#callpaytype").html(sCallPayType);
				}		
			});
		}
		//控件是否为空的检测
		function NullCheck(CtlName, value){
			if ($(CtlName).val() == ""){
				alert(value+"不能为空，请重新填写！");
				$(CtlName).focus();
				return true;
			}
			return false;
		}
		//是否查询出账号记录的检测
		function acctCheck(CtlName, value){
			if ($(CtlName).val() == ""){
				alert('请先查找出准备办理“'+value+'”业务的用户，再执行此操作！');
				$("#queryvalue").select();
				$("#queryvalue").focus();
				return true;
			}
			return false;
		}
		//开户按钮调用的函数
		function save(){						
			if (acctCheck("#txtacct", "缴费")) {return};						
			if (NullCheck("#radpayitem", "付费方式")) {return};
			if (NullCheck("#kdss", "实收金额")) {return};
			
			var info = "确认缴费\n\n";
			info += "账号:\t\t";
			info += $("#txtacct").val();
			info += "\n用户姓名:\t\t";
			info += $("#txtusername").val();
			info += "\n本次递交金额:\t";
			info += $("#kddj").val();
			info += "\n本次实收金额:\t";
			info += $("#kdss").val();
			info += "\n应找金额:\t";
			info += $("#kdyz").val();
			if(!confirm(info))
			{
				return;
			}			
			var v_pkgid = $("#pkgid").val();    	
			if(v_pkgid==""){
				alert("请选择上网套餐！");
				$("#pkgid").select().focus();    	
				return;
			}
			savedb();			
			clear();
			reset();		
		}
        //调用宽带开户的后台存储过程
        function savedb(){  
        	//取出所有项目的值，若有可能包含中文的，都做下编码转换		
        	var v_acct = tsd.encodeURIComponent($("#txtacct").val());    
        	var v_pkgid = $("#pkgid").val();    	
        	var v_pkgfee = $("#txtmoney").val();
        	var v_paytype = $("#radpayitem").val();
        	var v_callpaytype=$("#callpaytype").val();
        	var v_user = tsd.encodeURIComponent($("#txtusername").val());
        	var v_addr = tsd.encodeURIComponent($("#txtuseraddr").val());
        	var v_yhxz = tsd.encodeURIComponent($("#userattr").val());
        	var v_workmemo = tsd.encodeURIComponent($("#workmemo").val());
        	var newstartdate = $("#newstartdate").val();
        	var newenddate = $("#newenddate").val();
        	/* var bz1 = tsd.encodeURIComponent($("#bz1").val()); //代办人名称
        	var bz2 = tsd.encodeURIComponent($("#bz2").val()); //与户主关系
        	var bz3 = tsd.encodeURIComponent($("#bz3").val()); //代办联系电话
        	var bz4 = tsd.encodeURIComponent($("#bz4").val()); //代办证件类型
        	var bz5 = tsd.encodeURIComponent($("#bz5").val()); //代办证号码
        	var bz6 = tsd.encodeURIComponent($("#bz5").val()); //代办单位名称
        	var paydate = $("#AcctPayTime").val();				//缴费时间 */
        	
        	var pubParam = getPubProcParam(); 
         	var param=pubParam+"&internetacct="+v_acct+"&callpaytype="+v_callpaytype+"&paytype="+v_paytype+"&pkgid="+v_pkgid
         	  +"&username="+v_user+"&useraddr="+v_addr+"&userattr="+v_yhxz+"&months="+$("#months").text()+"&cycle="+tsd.encodeURIComponent($("#cycle").text()) 
         	  +"&pkgfee="+v_pkgfee+"&workmemo="+v_workmemo+"&newstartdate="+newstartdate+"&newenddate="+newenddate+"&speed="+$("#hidnewspeed").val()+"&cheque="+$("#txtchecknum").val();
         	  //+"&bz1="+bz1+"&bz2="+bz2+"&bz3="+bz3+"&bz4="+bz4+"&bz5="+bz5+"&bz6="+bz6+"&paydate="+paydate;
			
       		/*中石油暂时没有启用认证服务
         	var flag = fetchMultiPValue_rad("data_sync",8,param);
			if(flag == '-1'){
       			alert("向认证数据库同步失败【该账号已经存在】！请联系管理员。");
       			return;
       		}else if(flag=='0'){
       			alert("向认证数据库同步失败【系统不识别的业务类型】！请联系管理员。");
       			return;
       		}else{    */
	        	var res = fetchMultiPValue_rad("rad_busi",6,param);        	      
	        	if(res[0][0]=="SUCCEED"){
	        		if (parseFloat($("#txtmoney").val()) > 0){
	        			$("#jobid").val(res[0][1]);
	        			//setRepFileField();
	        			//printworkorder('payfee');//业务类型，取自于tsd_ini(tsection='radbusi_busifee' and tident='payfee' )
	        			feePrint(res[0][1]);
	        			initValue();        			
	        		}else{	
						autoBlockForm("choosePrintsf","150","close","#FFFFFF",false);
	        			alert("缴费成功！\r\n\n点击“确定”按钮办理下一笔缴费业务。");
	        			initValue();
	        		}
	        	}else if(res[0][0]=="FAILED"){
	        		if(res[0][1]!=""){
	        			alert(res[0][1]);
	        		}else{
	        			alert("缴费失败！请与系统管理员联系。");
	        		}	
	        	} 
        	//}       	
        }
        	
        function getPubProcParam(){
        	var busitype = "payfee";
        	var userid = tsd.encodeURIComponent("<%=sUserId%>");
        	var department = tsd.encodeURIComponent("<%=sDepart%>");
        	var busiarea = tsd.encodeURIComponent("<%=sArea%>");
        	var busiywarea = tsd.encodeURIComponent("<%=ywarea%>");
        	return "&userid="+userid+"&busitype="+busitype+"&department="+department+"&busiarea="+busiarea+"&BusiFeeNames="+BusiFeeNames+"&BusiFeeValues="+BusiFeeValues+"&busiywarea="+busiywarea;
        }	
		//重填按钮调用的函数
		function reset(){	
			//套餐恢复原值
			/*if ($("#txtacct").val()!=""){
				$("#pkgid").val($("#oldpkgid").val());
				setPkgFee(); 
			}	*/							
			//初始化已知值
			initValue();			
		}
		//设置east布局为整个body宽度的一半，这样center布局的宽度也是body宽度的一半
		function setEastWidth(){
			var w=document.body.clientWidth/2;
			if (w<416){
				w = 416;
			}
			mylayout.sizePane('east', w);
		} 
		//根据选取的套餐，设置套餐金额输入框
		function setPkgFee(){	
			var pubParam = getPubProcParam(); 
         	var param="&a_pkgid="+$("#pkgid").val()+"&a_internetacct="+tsd.encodeURIComponent($("#txtacct").val());
			var res = fetchMultiPValue("rad_busi_payfee.rad_getaccountcharges",6,param);
			var paytype=$("#callpaytype").val();
			if (paytype=='2'){		
				$("#proid").show();
				$("#description").hide();
				if(res!=undefined){
					$("#newstartdate").val(res[0][1]);
					$("#newenddate").val(res[0][2]);
					$("#txtmoney").val(res[0][0]);
					//$("#kdss").val(res[0][0]);		
					$("#hidnewspeed").val(res[0][3]);		
				}else{
					$("#newstartdate").val("");
					$("#newenddate").val("");
					$("#txtmoney").val("0");
					$("#kdss").val("0");
					$("#hidnewspeed").val('');
				}
				$("#pkgid").attr("disabled","disabled");
			}else if(paytype=='1'){
				if(res!=undefined){
					
					if (res[0][6]=='true'){
						$("#proid").hide();
						$("#description").show();	
						$("#newstartdate").val(res[0][1]);
						$("#newenddate").val(res[0][2]);	
						$("#months").text(res[0][4]);
						if(res[0][5]!=undefined){
							if (res[0][5].indexOf(',')==-1){
								$("#cycle").text(res[0][5].substring(0,4)+"年"+res[0][5].substring(4,7)+'月');
							}else{
								var arr=res[0][5].split(',');
								var len=arr.length;
								var str="";
								str=arr[0].substring(0,4)+"年"+arr[0].substring(4,7)+'月';
								str+="—";
								str+=arr[len-1].substring(0,4)+"年"+arr[len-1].substring(4,7)+'月';
								$("#cycle").text(str);
							}
						}				
						$("#txtmoney").val(res[0][0]);
						//$("#kdss").val(res[0][0]);		
						$("#hidnewspeed").val(res[0][3]);	
					}else{
						alert("该后付费用户暂时没有欠费！");
						$("#proid").show();
						$("#description").hide();
						$("#newstartdate").val("");
						$("#newenddate").val("");
						$("#months").text('0');
						$("#cycle").text('—');
						$("#txtmoney").val("0");
						$("#kdss").val("0");
						$("#hidnewspeed").val('');
						reset();
						return false;
					}
				}
				$("#pkgid").attr("disabled","disabled");
			}
			
			var res = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=count(1)&tablename=rad_busi_dport&key=ZINTERNETACCT='"+tsd.encodeURIComponent($("#txtacct").val())+"' and nvl(delbz,'tsd')<>'destroy'");				
			if(res>0&&res!=undefined){				
				$("#kdss").val(parseFloat($("#txtmoney").val())+parseFloat(res)*100);
			}
		}			
		//根据选取的付费方式，设置对应的报表文件隐藏域
		function setRepFileField(){
			var ctl = document.getElementById("radpayitem");			
			var s = ctl.options[ctl.options.selectedIndex].lvalue;					
			if (s!=undefined){
				var array = s.split("|");	
				$("#repfile").val(array[2]);				
			}
			else{
				$("#repfile").val("");
			} 	
		}		
		//根据字段名和字段值查询raduserinfo表. 精确查找
		function queryRadUser_equal(){
			var fieldname = $("#queryfield").val(); 
			var fieldvalue = $("#queryvalue").val();
			queryRadUser_equalReal(fieldname,fieldvalue);			
		}
		function queryRadUser_equalReal(fieldname,fieldvalue){
			var res = fetchMultiArrayValue_rad('dbsql_rad.queryRadUser_equal',6,"&fieldname="+fieldname+"&fieldvalue="+tsd.encodeURIComponent(fieldvalue),'business');
			if (res != undefined && res!="" && res.length>0){
				
				setValue(res);
				
				var t = new Date();
				var tvalue=t.getFullYear()+"-"+(t.getMonth()+1)+"-"+t.getDate()+" "+t.getHours()+":"+t.getMinutes()+":"+t.getSeconds();
				$("#AcctPayTime").val(tvalue);
				   
				//保存套餐原值，供重置使用
				$("#oldpkgid").val($("#pkgid").val()); 
			}
			else{
				alert("没有符合条件的用户，请确认您的输入是否正确！");
				clear();
				initValue();
				$("#queryvalue").select();
				$("#queryvalue").focus();
			}
		}	
		function popupQueryPanel(){
			queryRadUser_like();			
		}
		//根据字段名和字段值查询raduserinfo表. 模糊查找
		function queryRadUser_like(){
			var fieldname = $("#queryfield").val(); 
			var fieldvalue = $("#queryvalue").val();
			var s="";
			$("#tabqueryres").empty();
			s="<tr style='line-height: 22px; font-weight:bold; text-align:center;'>";
			s +="	<td width='80px'>用户账户</td>"
			s +="	<td width='100px'>用户名称</td>"
			s +="	<td>用户地址</td>"
			s +="	<td width='70px'>住宅电话</td>"
			s +="	<td width='90px'>移动电话</td>"
			s +="	</tr>";
			var res = fetchMultiArrayValue_rad('dbsql_rad.queryRadUser_like',6,"&fieldname="+fieldname+"&fieldvalue="+tsd.encodeURIComponent(fieldvalue),'business');			
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					if (res[i][0]==undefined || res[i][1]==undefined) {continue;}				
					s += "<tr style='line-height: 22px;' id='"+res[i][0]+"' onclick=\"selectRow('"+res[i][0]+"',1)\"; ondblclick=\"dbclickRow('"+res[i][0]+"');\">";					   				 
					s += "<td style='text-align:center'>"+res[i][0]+"</td>";
					s += "<td style='text-align:center'>"+res[i][1]+"</td>";
					s += "<td style='text-align:center'>"+res[i][2]+"</td>";
					s += "<td style='text-align:center'>"+res[i][3]+"</td>";
					s += "<td style='text-align:center'>"+res[i][4]+"</td>";
					s += "</tr>";
				}
				if (s != ""){
					$("#tabqueryres").append(s);
				}
				autoBlockFormAndSetWH('divquery',70,'','close',"#ffffff",false,'', '');	
			}else{
				alert("没有符合条件的用户，请确认您的输入是否正确！");
				clear();
				initValue();
				$("#queryvalue").select();
				$("#queryvalue").focus();
			}
		}
		//模糊查询面板选中一条记录，变底色
		function selectRow(rowid,op){			
			if (op==1){
				var oldrow=$("#returnUserAcct").val();
				if(oldrow == "" || oldrow=="undefined" ){
					document.getElementById(rowid).style.background='#0080FF';
					$("#returnUserAcct").val(rowid);
				}else{
					document.getElementById(oldrow).style.background='#FFFFFF';
				}
			}
			
			document.getElementById(rowid).style.background='#0080FF';
			$("#returnUserAcct").val(rowid);
			
		}
		//模糊查询面板点确定时调用
		function setuserinfo(){
			var rows=document.getElementById('tabqueryres').getElementsByTagName('tr');		
			if (rows.length>1){
				if ($("#returnUserAcct").val()==""){
				 	alert("请先选中一条记录！");
					return;
				}
				if(kdLock($("#returnUserAcct").val(),$("#userid").val())==true){
					queryRadUser_equalReal('internetacct',$("#returnUserAcct").val());
				}
			}
			$("#returnUserAcct").val('');
			
			setTimeout($.unblockUI,15);//关闭模糊查询面板
		}
		//双击查询面板中的记录行时调用
		function dbclickRow(rowid){
			selectRow(rowid);
			setuserinfo();
		}
		//根据查询结果数组，给控件赋值
		function setValue(arr){
			
			//delflag字段为Y 为拆除宽带标志
			if (arr[0][27] == "Y" ){
				alert("当前 "+arr[0][0]+" 用户宽带已经拆除请重新查询");
				clear();
				initValue();
				$("#queryvalue").focus();
				return false;
			}
			//判断宽带账号电话对应的合同号档是否为公费，公费用户宽带不用缴费（中石油定制）
			if (arr[0][8] == "办公用户"){
				alert("当前 "+arr[0][0]+" 用户为办公用户无需缴费");
				clear();
				initValue();
				$("#queryvalue").focus();
				return false;
			} 
			
			if(arr[0][25] == '0'){
				alert("该用户为免费用户无需交费！");
				initValue();
				return;
			}   	
			if(arr[0][20] != "" && arr[0][25] == '1'){
				//缴费时验证后付费用户绑定的电话是否存在于yhdang表中，如果不存在，则视为未做绑定
				var res = fetchMultiPValue("rad_busi_payfee.rad_busi_dhvalid",6,"&internetacct="+arr[0][0]+"&dh="+arr[0][20]);
				if(res[0][0] == '0'){
					alert("该后付费用户已欠费,需与【"+arr[0][20]+"】电话一起交费！");
					initValue();
					return;
				}
			}
			
			//获取余额/月
			//getssye(arr[0][0]);
						
			//wcy 2016-09-06，只有通过验证的能缴费，这里返回false的就退出，不再进行后续缴费操作
			if (getssye(arr[0][0]) == false)
			{
			    return;
			}
			
        	$("#txtacct").val(arr[0][0]);
        	$("#txtusername").val(arr[0][1]);
        	$("#txtuseraddr").val(arr[0][2]);
        	$("#sBm1").val(arr[0][3]);
        	$("#sBm2").val(arr[0][4]);
        	$("#sBm3").val(arr[0][5]);
        	$("#sBm4").val(arr[0][6]);
        	$("#txtarea").val(arr[0][7]);
        	$("#usertype").val(arr[0][8]);
        	$("#userattr").val(arr[0][9]);
        	$("#txtregdate").val(arr[0][10]);        	
        	
        	$("#startdate").val(arr[0][11]);
        	$("#enddate").val(arr[0][12]);
        	$("#txtstatus").val(arr[0][14]);
        	
        	$("#cardtype").val(arr[0][15]);
        	$("#txtcardid").val(arr[0][16]);
        	$("#txtmobile").val(arr[0][17]);
        	$("#txtlinkphone").val(arr[0][18]);
        	$("#txtlinkman").val(arr[0][19]);         	
        	$("#txtdh").val(arr[0][20]);
        	$("#radacc").val(arr[0][21]);
        	$("#txtmemo").val(arr[0][22]);  
        	$("#txtuserarea").val(arr[0][24]);
			$("#callpaytype").val(arr[0][25]);
			loadpkgbytype(arr[0][25]);
        	$("#pkgid").val(arr[0][13]);    
        	inLock("payfee",arr[0][0]);
			$("#bzlist :text").val(""); 
			$("#bzlist :text").attr("readonly",false ); 
			var res = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=count(1)&tablename=rad_busi_dport&key=ZINTERNETACCT='"+tsd.encodeURIComponent($("#txtacct").val())+"' and nvl(delbz,'tsd')<>'destroy'");				
			if(res>0&&res!=undefined){
				alert("帐号【"+arr[0][0]+"】下绑定附属帐号"+res+"个，每一个附属帐号将多收取100元钱。");
			}
			setPkgFee(); 
			
		}
		function loadpkgbytype(val){
			$("#pkgid").empty();
			var urlMm = tsd.buildParams({ packgname:'service',
				clsname:'ExecuteSql',
				method:'exeSqlData',
				ds:identifyDs(6),
				tsdcf:'oracle_business',
				tsdoper:'query', 
				datatype:'xmlattr', 
				tsdpk:'dbsql_rad_new.loadpkgbytype'
				});
			$.ajax({
				url:"mainServlet.html?" + urlMm +"&paytype="+val,
				async:false,
				cache:false,
				timeout:1000,
				type:'post',
				success:function(xml){
					var str="<option value='' selected='selected'>--请选择--</option>";
					$(xml).find("row").each(function(){
						var pkgid= $(this).attr("pkgid");
						var pkgname=$(this).attr("pkgname");
						
						if (pkgid != "undefined" && pkgid != null && pkgid != ""){
							str+="<option value='"+pkgid+"'>"+pkgname+"</option>"
						}
					});
					$("#pkgid").html(str);
				}
			});
		}
		function getCheckNum(values){
			if (values == 'cheque' ){
				$("#divzp").show();
				$("#txtchecknum").attr("disabled","");
				$("#txtchecknum").focus();
				$("#txtchecknum").val('');
			}else{
				$("#divzp").hide();
				$("#txtchecknum").attr("disabled","disabled");
				$("#txtchecknum").val('');
			}
		}
		//输出指定个数的空格
		function writespace(count){
			var s = "";
			for (var i=1; i<=count; i++){
				s+="&nbsp;";
			}
			document.write(s);			
		}
		
		/**********
		* 票据打印
		* @param：flag为1时直接打印，为2时预览打印;
		* @return;
	    **********/
       	function feePrint(jobid)
       	{			
			var params="";
			params+= "&jobid="+jobid;
       		//var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/charge/rad_busiCharge.cpt"+params;
       		var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/broadband_revenue.cpt"+params;
       		
       		//调打印预览窗口
			window.showModalDialog(urll,window,"dialogWidth:800px; dialogHeight:530px; center:yes; scroll:no");
       	}
		/***********************
		* 设置代办证件类型
		* @param;
		* @return;
	    *************************/
		function getidtype(){
			$("#bz4").empty();
			var strbz6="<option value=\"\">--请选择--</option>"; 
			var res = fetchMultiArrayValue("dbsql_phone.queryphoneconfig",6,"&configtype=idtype");
			if(res[0]==undefined || res[0][0]==undefined)
    		{
    			return false;
    		}
    		for(var i=0;i<res.length;i++){
    			strbz6+="<option value="+res[i][1]+">"+res[i][1]+"</option>";
    		}
			$("#bz4").append(strbz6);
			$("#bz4").val('身份证');
		}
	    //获取根据用户宽带到期日获取实时余额/月
	    function getssye(username){
	    	
	    	var res = fetchMultiPValue("rad_busi.getssye",6,"&internetacct="+username);
	    	if(res[0][0] == "SUCCEED"){
	    	    
	    	    //commented by wcy 2016-09-06，中石油，没必要显示余额，算的不对，反而引起麻烦
	    		//$("#ssmoney").val(res[0][1]);
	    		
	    		var fee = parseFloat(res[0][3]);
				if(isNaN(fee)) fee = 0;
				
				//commented by wcy 2016-09-06
				/*
	    		if(fee > 0){
	    			$("#lastpay").removeAttr("disabled");
	    			$("#lastpay").html("上次缴费时间 "+res[0][2]+" 缴费金额 "+fee+" 元");
	    		}else{
		    		alert("当前用户宽带已经过期，不能办理续费业务");
		    		$("#ssmoney").val('0');
		    		return false;
	    		}
	    		*/
	    		
	    		//add by wcy 2016-09-06，判断用户是否未到期，未到期可以续费，否则不能续费
	    		var payFlag = parseInt(res[0][4]);
	    		if (payFlag == 1)
	    		{
	    		    if(fee > 0){
	                    $("#lastpay").removeAttr("disabled");
	                    $("#lastpay").html("上次缴费时间 "+res[0][2]+" 缴费金额 "+fee+" 元");
                    }
	    		}
	    		else if (payFlag == 0)
	    		{
	    		    alert("当前用户宽带已经过期，不能办理续费业务");
                    $("#ssmoney").val('0');
                    return false;
	    		}
	    	}else{
	    		$("#ssmoney").val('0');
	    		return false;
	    	}
	    }
	</SCRIPT> 
</head>
<body onunload="unIfLock()">	
	<DIV class="ui-layout-north">
		<div id="navBar1" style="margin:-10px">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />您当前所在的位置 ：		 												 													
						</div>
					</td>
					<td width="20%" align="right" valign="top">
						<div id="d2back">
							<a href="javascript:void(0);" onclick="parent.history.back(); return false;">
								返回
							</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>					
		<div style="width:100%; height:30px; text-align:left;font-weight:bold; margin-top: 25px; ">
			&nbsp;&nbsp;<img src="style/icon/65.gif" />&nbsp;&nbsp;&nbsp;&nbsp;
			查询方式:<select id="queryfield" style="width: 90px;" >
				<option value="dh">住宅电话</option>
				<option value="username">用户名称</option>
				<option value="useraddr">用户地址</option>
				<option value="internetacct">用户帐号</option>
				<option value="mobile">联系电话</option>
				<option value="area">用户区域</option>
			</select>
			<input type="text" id="queryvalue" style="width:162px;"/>
			<input  class="tsdbutton_rad" type="button" value="精确查询" onclick="queryRadUser_equal();"/>
			<input  class="tsdbutton_rad" type="button" value="模糊查询" onclick="popupQueryPanel();"/>
		</div>
	</DIV> 
	<DIV class="ui-layout-south">		
		<div style="margin-top:-5px; margin-bottom:-7px">
			<button class="tsdbutton" id="btnSave" onclick="save();" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;" > 
				确认缴费 
			</button>	
			<button class="tsdbutton" id="btnClear" onclick="reset();" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;" >
				重新填写
			</button>	
		</div>					
	</DIV> 	
	<DIV class="ui-layout-center">	
		<div id="input-Unit" style="margin-top:-10px;">
			<div class="title_rad">用户资料</div>
			<table>
				<tr>
					<td>用户帐号:<input type="text" id="txtacct" name="txtacct" style="width:150px;"/><script>writespace(10)</script></td>
					<td>用户名称:<input type="text" id="txtusername" name="txtusername" style="width:150px;"/></td>
				</tr>
				<tr>
					<td>用户类别:<input type="text" id="usertype" style="width:150px;"/><script>writespace(10)</script></td>
					<td>用户性质:<input type="text" id="userattr" style="width:150px;"/></td>				
				</tr>
				<tr>
					<td>住宅电话:<input type="text" id="txtdh" name="txtdh" style="width:150px;"/><script>writespace(10)</script></td>
					<td>付费类型:<select id="callpaytype" style="width: 150px;" disabled="disabled" onchange="loadpkgbytype(this.value);" ></select></td>				
				</tr>
				
			</table>
			<table>
			    <tr>
                    <td style="text-align:left;">用户地址:<input type="text" id="txtuseraddr" name="txtuseraddr" style="width:400px;"/></td>
                </tr>
                <tr>
                    <td style="text-align:left;">接入类型:<input type="text" id="radacc" style="width:400px;"/></td>
                </tr>
			</table>
			<div style="background:#F5DEB3;"><br/>							
				上网套餐:<select id="pkgid" style="width: 250px;" onchange="setPkgFee();"></select><font color="red">*</font> <br /><br />
				<div id="proid">
				新计费日期:<input type="text" id="newstartdate" style="width:78px; background:silver;" readonly="true";/><script>writespace(5)</script>
				新到期日期:<input type="text" id="newenddate" style="width:78px; background:silver;" readonly="true";/><script>writespace(5)</script><br /><br />
				</div>
				<div id="description" style="display: none;">
					<font style="color:red;font-weight:bold;">
						<span>欠费月数：</span><span id="months">0</span><span>，费用周期：</span><span id="cycle"></span>
					</font>
					<br /><br />
				</div>
				<font style="color:red;font-weight:bold;">应缴金额:</font><input type="text" id="txtmoney" style="width:78px;font-weight:bold;background:silver;" readonly="true"/><script>writespace(8)</script>	
				宽带余额:<input type="text" id="ssmoney" style="width:78px;font-weight:bold;background:silver;" readonly="true"/><script>writespace(3)</script><br /><br />
				递交金额:<input type="text" id="kddj" maxlength="11" style="width:76px;font-weight:bold;" onkeypress="numValid(this)" onpaste="return !clipboardData.getData('text').match(/\D/)" readonly="true"/><script>writespace(8)</script>	
				付费方式:<select id="radpayitem" style="width: 80px;" onchange="getCheckNum(this.value);" ></select><font color="red">*</font> <br/><br />
				<div id="divzp" style="display: none;">支票号:<input type="text" id="txtchecknum"  style="width:244px;font-weight:bold;background:silver;" disabled="disabled"/> </div><br />			
				<font style="color:red;font-weight:bold;">实收金额:</font><input type="text" id="kdss" name="kdss" style="width:78px;" onkeypress="numValid(this)" 
					onpaste="return !clipboardData.getData('text').match(/\D/)" ondragenter="return false" readonly="true"/><script>writespace(7)</script>
				应找金额:<input type="text" id="kdyz" style="width:78px; background:silver;" readonly="true"/><script>writespace(3)</script>
				<br/><br/>
				操作备注:<input type="text" id="workmemo" style="width:254px;"/><script>writespace(3)</script>														
			<br/>&nbsp;
			</div>
		</DIV>
		<div >
			<span id="lastpay" style="disabled: none; color:blue;"></span><br/>
		</div>
			<%-- <div id="input-Unit" style="font-size:12px;margin-top:10px;text-align:center;" >
				<table id="bzlist">
					<tbody>
						<tr>															
							<td align="right">
								<span id="bz1g">代办人名称：</span>
							</td>
							<td>
								<input id="bz1" maxlength="50" style="width:150px;" type="text"/><script>writespace(5)</script> <!-- 代办人名称 -->
							</td>
							<td align="right">
								<span id="bz2g">与户主关系：</span>
							</td>
							<td align="left">
								<input id="bz2" maxlength="50" style="width:170px;" type="text"/> <!-- 与户主关系 -->						
							</td>
						</tr>
						<tr>
							<td align="right">
								<span id="bz4g">代办证件类型：</span>
							</td>
							<td align="left">
								<select id="bz4" style="width: 150px;"></select> <!-- 代办证件类型 -->	
							</td>
							<td align="right">
								<span id="bz5g">代办证件号码：</span>
							</td>
							<td align="left">
								<input id="bz5" maxlength="25" onkeypress="var k=event.keyCode; return k>=48&amp;&amp;k<=57 " style="width:170px;" type="text"/>    <!-- 代办证件号码-->	
							</td>						
						</tr>
						<tr>
							<td align="right">
								<span id="bz3g">代办联系电话：</span>
							</td>
							<td align="left">
								<input name="bz3" id="bz3" onkeypress="var k=event.keyCode; return k>=48&amp;&amp;k<=57 " style="width:150px;" maxlength="25" type="text"/>   <!-- 代办联系电话 -->
							</td>						
							<td align="right">
								<span id="bz10g">代办单位名称：</span>
							</td>
							<td>
								<input id="bz10" maxlength="50" style="width:170px;" type="text"/>  <!-- 代办单位名称 -->
							</td>
						</tr>
						<tr>
							<td align="right">
								<!-- 缴费时间： -->
								<span id="AcctPayTimeg">缴费时间：</span>
							</td>
							<td align="left">
								<input id="AcctPayTime" style="width:150px;" type="text" onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								/>
							</td>
						</tr>						
					</tbody>
				</table>
			</div>		 --%>
		</div>								
	
	<DIV class="ui-layout-east" >
		<div id="input-Unit" style="margin-top:-10px;margin-left:-50px;">
			<div class="title_rad">				
				基本资料
			</div>
			开户日期:<input type="text" id="txtregdate" name="txtregdate" style="width:120px;" readonly="true";/> &nbsp&nbsp 			
			当前状态:<input type="text" id="txtstatus" style="width:120px;"/> <br /><br /> 	
			计费日期:<input type="text" id="startdate" style="width:120px;" readonly="true";/>  &nbsp&nbsp
			到期日期:<input type="text" id="enddate" style="width:120px;"/> <br /><br />						
			一级部门:<input type="text" id="sBm1" style="width:120px;" /> &nbsp&nbsp			
			二级部门:<input type="text" id="sBm2" style="width:120px;" /><br /><br />
			三级部门:<input type="text" id="sBm3" style="width:120px;" /> &nbsp&nbsp
			四级部门:<input type="text" id="sBm4" style="width:120px;" /><br /><br />								 					
			证件名称:<input type="text" id="cardtype" style="width:120px;"/> &nbsp&nbsp
			证件号码:<input type="text" id="txtcardid" name="txtcardid" style="width:120px;"/> <br /><br />					
			联 系 人:<input type="text" id="txtlinkman" name="txtlinkman" style="width:120px;"/> &nbsp&nbsp
			联系电话:<input type="text" id="txtlinkphone" name="txtlinkphone" style="width:120px;"/> <br /><br />
			移动电话:<input type="text" id="txtmobile" name="txtmobile" style="width:120px;"/><script>writespace(48)</script> <br /><br />
			营业区域:<input type="text" id="txtarea" name="txtarea" style="width:120px;" readonly="true" /> &nbsp&nbsp
			用户区域:<input type="text" id="txtuserarea" style="width:120px;"/> <br /><br />						
			备  注:&nbsp&nbsp&nbsp&nbsp<input type="text" id="txtmemo" name="txtmemo" style="width:317px;"/>			
		</div>		 
	</DIV>		
	<input type="hidden" id="returnUserAcct"/>
	<input type="hidden" id="oldpkgid"/>	
	<input type="hidden" id="hidnewspeed"/>
	<input type="hidden" id="jobid"/>
	<input type="hidden" id="repfile"/>
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->
	<input type="hidden" id="userid" value="<%=sUserId%>"/>
	<!-- 模糊查询结果div  -->
	<div class="neirong" id="divquery" style="width:550px;display: none">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<span>请选择您需要的记录</span>
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="setTimeout($.unblockUI,15);"><fmt:message key="global.close" /><!-- 关闭 --></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>
		<div class="midd" style="background-color:#FFFFFF;text-align:left;height:240px;">		
			<div id="page" style="overflow-y:scroll;height:100%;width: 100%;">					
				<table border="1" cellpadding="0" bordercolor="#9AC0CD" id="tabqueryres" style="width: 530px;">												
				</table>
			</div>
		</div>
		<div class="midd_butt" style="width:540px;height:38px;">  
			<button id="hthChooseFormSave" onclick="setuserinfo();" class="tsdbutton" 
				style="margin-left: 20px;">
				确定
			</button>
			<button id="hthChooseFormReset" onclick="javascript:setTimeout($.unblockUI,15);$('selectsbmkey').val('');" class="tsdbutton"  style="margin-left: 20px;">
				取消				
			</button>
			<button id="hthChooseFormsx" onclick="javascript:queryRadUser_like()" class="tsdbutton"  style="margin-left: 20px;">
				刷新				
			</button>
		</div>
	</div>
	<!-- 勾选业务费div  -->
	<div class="neirong" id="divbusifee" style="width:300px;display: none">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<span>请选择费用</span>
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="setTimeout($.unblockUI,15);"><fmt:message key="global.close" /><!-- 关闭 --></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>
		<div class="midd" style="background-color:#FFFFFF;text-align:left;height:130px;">		
			<div id="page" style="overflow-y:scroll;height:100%;width: 100%;">					
				<table border="1" cellpadding="0" bordercolor="#9AC0CD" id="tabbusifee" style="width: 280px;">
				<tr style="line-height: 22px; font-weight:bold; text-align:center;">
					<td width='30px'>选择</td>
					<td >业务费名称</td>
					<td width='80px'>业务费金额</td>
				</tr>												
				</table>
			</div>
		</div>
		<div class="midd_butt" style="width:290px;height:38px;">  
			<button id="hthChooseFormSave" onclick="caclbusifee();" class="tsdbutton" 
				style="margin-left: 20px;">
				确定
			</button>
			<button id="hthChooseFormReset" onclick="javascript:setTimeout($.unblockUI,15);$('selectsbmkey').val('');" class="tsdbutton"  style="margin-left: 20px;">
				取消				
			</button>
		</div>
	</div>	
	<div class='neirong' id='choosePrintsf' style='display:none;width:660px'>
		<div class='top'>
		<div class='top_01' id='thisdrag'>
		<div class='top_01left'>
		<div class='top_02'>
		<img src='style/images/public/neibut01.gif'/>
		</div>
		<div class='top_03' id='titlediv'>
		票据打印
		</div>
		</div>
		</div>
		<div class='top02right'>
		<img src='style/images/public/toptiaoright.gif' />
		</div>
		</div>
		<div class='midd' style='background-color:#FFFFFF;text-align:center;'>
		<hr style='border: 3px dotted #CCCCCC;' />
		<table cellspacing='5' style='margin-right:120px;'>
		<tr id='print_sf'>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;
		<button id='printDirect' class='tsdbutton' onclick='lsPrint(1)' style='line-height:27px; margin-top: 1px; padding: 0px;'>直接打印</button>
		<br /></td>
		<td>#
		<button id='printInDirect' class='tsdbutton' onclick='lsPrint(0)' style='line-height:27px; margin-top: 1px; padding: 0px;'>预览打印</button>
		<br /></td>
		</tr>
		</table>
		</div>
		<div class='midd_butt' style='width:645px'><button id='printInDirect' class='tsdbutton' onclick='setTimeout($.unblockUI,1);'>关闭</button></div> 
	</div>	
	<!-- 弹出报表打印框 -->	
	<div id="businessreprint"></div><!-- 加载的文件在script/telephone/business/businessreprint.js -->  
	<iframe id="printReportDirect"  style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>	
</body>
</thml>