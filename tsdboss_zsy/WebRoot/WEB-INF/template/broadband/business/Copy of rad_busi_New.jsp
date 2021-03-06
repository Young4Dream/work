<%----------------------------------------
	name: rad_busi_New.jsp
	author: wangli
	version: 1.0 
	description: 装机(宽带账号开户) 
	Date: 2011-08-31
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String sUserId = (String) session.getAttribute("userid");
	String sArea = (String) session.getAttribute("chargearea");
	String sDepart = (String) session.getAttribute("departname");
	String ywarea = (String) session.getAttribute("userarea");
	String sMenuid = request.getParameter("imenuid");
	String sGroupid = request.getParameter("groupid");	
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	String iconpath = basePath + "style/icon/";	
	//Java取当前时间

	SimpleDateFormat formatto = new SimpleDateFormat("yyyy-MM-dd");
	Date now = new Date();
	String sDate = formatto.format(now);	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="plug-in/jquery/ui/jquery.layout.js" type="text/javascript"></script>
	<script src="plug-in/jquery/ui/jquery-ui-1.7.1.custom.js" type="text/javascript"></script>	
	<script src="script/broadband/business/radbusiprint.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script> <!-- 弹出面板需要导入js文件 -->	
    <script type="text/javascript" src="script/public/tsdpower.js"></script><!-- 页面权限控制 -->
    <script type="text/javascript" src="script/public/main.js"></script>
    <script type="text/javascript" src="script/public/mainStyle.js"></script>
    <script type="text/javascript" src="script/public/transfer.js"></script>	    
    <script type="text/javascript" src="script/public/revenue.js" ></script>    
    <script src="script/broadband/business/broadbandservice.js" type="text/javascript"></script>	
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
	<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
	<!-- 时间选择器需要导入的js文件 -->	
	<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js" ></script>   
	<style type="text/css">
		#input-Unit{ float:left; width:100%; text-align:center;}
		#input-Unit .title_rad{ width:100%; height:22px; border-bottom:1px solid #C8D8E5;  text-align:center; color:#3C3C3C; line-height: 22px; font-weight:bold; background:#CCCCFF;} 
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
			jiesuo();
			getDict();
			initValue();
			initBusiFee();
			setEastWidth();			
			setPower();
			$("#navBar").append(genNavv());				
			$("#radacc").change(function(){
				$("#txtusername").removeAttr("disabled");			
				$("#usertype").removeAttr("disabled");
				$("#userattr").removeAttr("disabled");
				$("#txtuseraddr").removeAttr("disabled");
				$("#txtpwd").removeAttr("disabled");
				$("#txtpwd1").removeAttr("disabled");
				$("#sBm1").removeAttr("disabled");	
				$("#sBm2").removeAttr("disabled");	
				$("#sBm3").removeAttr("disabled");	
				$("#sBm4").removeAttr("disabled");
				$("#cardtype").removeAttr("disabled");	
				$("#txtcardid").removeAttr("disabled");
				$("#txtlinkman").removeAttr("disabled");	
				$("#txtlinkphone").removeAttr("disabled");	
				$("#txtusername").val("");			
				$("#usertype").val("");
				$("#userattr").val("");
				$("#txtuseraddr").val("");
				//$("#txtpwd").val("");
				//$("#txtpwd1").val("");
				$("#sBm1").val("");
				$("#sBm2").val("");
				$("#sBm3").val("");
				$("#sBm4").val("");
				$("#cardtype").val("");
				$("#txtcardid").val("");
				$("#txtlinkman").val("");
				$("#txtlinkphone").val("");
			});			
			$("#keys").keypress(function(e){
				if(e.keyCode==13){
					$("#btnaccnull").click();
				}
			});		
		});
		//取出用户的扩展权限，进行相应的权限控制(目前仅有手续费)
		function setPower(){
			var sPower = getUserPower("<%=sUserId%>","<%=sGroupid%>","<%=sMenuid%>");
			//若为管理员权限，则可以编辑手续费项目
			if(sPower=='all@'){
				setReadonly($("#txtBussFee"), false);
				setpkgfeeEnable($("#chkpkgfee"), "");
			}
			else if(sPower!=''&&sPower!='all@'){  //若为普通权限，则根据具体权限控制
				var spowerarr = sPower.split('@');
				var temp;
				for(var i = 0;i<spowerarr.length-1;i++){				
					if (spowerarr[i].indexOf("radBusiFee")>0){
						temp = getCaption(spowerarr[i],'radBusiFee','');
						if (temp.toLowerCase() == 'true'){
							setReadonly($("#txtBussFee"), false);
						}
						else{
							setReadonly($("#txtBussFee"), true);
						}
					}
					if (spowerarr[i].indexOf("radBusiPkgFee")>0){
						temp = getCaption(spowerarr[i],'radBusiPkgFee','');
						if (temp.toLowerCase() == 'true'){							
							setpkgfeeEnable($("#chkpkgfee"), "");
						}
						else{							
							setpkgfeeEnable($("#chkpkgfee"), "disabled");
						}
					}
				}
			}
			else{ //若没有设置权限，默认不能操作
				setReadonly($("#txtBussFee"), true);
			};			
		}
		//设置业务费只读属性和底色
		function setReadonly(ctl,value){
			ctl.attr('readonly',value);
			if (value){
				ctl.attr('style','width:70px; background:silver;ime-mode: disabled');	
			}
			else{
				ctl.attr('style','width:70px;ime-mode: disabled');
			}
		}
		//设置套餐费enable属性和底色
		function setpkgfeeEnable(ctl,value){
			ctl.attr('disabled',value);
		}		
		//初始化业务费选择表格
		function initBusiFee(){
			var s="";  
			var res = getBussFee('setup');//取出宽带装机开户费			
			for(var i=0;i<res.length;i++){
				if (res[i][0]==undefined || res[i][1]==undefined) {continue;}				
				s += "<tr style='line-height: 22px;'><td><input type='checkbox'/></td>";  
				s += "<td>"+res[i][0]+"</td>";
				s += "<td style='text-align:center'>"+res[i][1]+"</td>";
				s += "</tr>";
			}
			if (s != ""){
				$("#tabbusifee").append(s);
			}	
		}
		//已知值控件赋初值
		function initValue(){			
			$("#txtregdate").val("<%=sDate%>");
			$("#txtarea").val("<%=sArea%>");
			$("#txtmoney").val("0");            //套餐费默认为0 

			$("#txtBussFee").val(0); 		
 			$("#txthj").val(0);           //合计默认为业务费
			$("#radpayitem").val("cash");
			$("#txtacct").focus();	
			$("#pkgid").empty();
			$("#hiduints").val(0);
			$("#hidfeerule").val('');
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
				    var syhlb = xml.substring(xml.indexOf("<yhlb=")+6,xml.indexOf("yhlb/>"));
				    var yhxz = xml.substring(xml.indexOf("<yhxz=")+6,xml.indexOf("yhxz/>"));
				    var idtype = xml.substring(xml.indexOf("<idtype=")+8,xml.indexOf("idtype/>"));
				    //var radtype = xml.substring(xml.indexOf("<radpkg=")+8,xml.indexOf("radpkg/>"));
				    var radacc = xml.substring(xml.indexOf("<radacc=")+8,xml.indexOf("radacc/>"));				    
				    var payitem = xml.substring(xml.indexOf("<radpayitem=")+12,xml.indexOf("radpayitem/>"));
				    var sCallPayType = xml.substring(xml.indexOf("<CallPayType=")+13,xml.indexOf("CallPayType/>"));
				    
					$("#usertype").html(syhlb);
					$("#userattr").html("<option value='' selected='true'>--请选择--</option>");
					$("#yhxz_hidden").html(yhxz);
					$("#cardtype").html(idtype);
					//$("#pkgid").html(radtype);
					$("#radacc").html(radacc);
					$("#radpayitem").html(payitem);
					$("#radpayitem").val("cash");
					$("#callpaytype").html(sCallPayType);
					//$("#pkgid option[value='11']").remove(); 
				}		
			});
		}
		//根据选择的用户类别填充相应的用户性质
		function getYhxz(){
				var select = document.getElementById("yhxz_hidden");
				var array;
				$("#userattr").empty();
				$("#userattr").html($("#userattr").html()+"<option value='' selected='true'>--请选择--</option>");				
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
	  							$("#userattr").html($("#userattr").html()+"<option value="+array[1]+">"+array[0]+"</option>");	  								  							
	  						}
	  					}
	  				}
				}			
		}		
		
		//校验用户账号
		function isExists(){
			var radacc=$('#txtacct').val();
			if(radacc==""||radacc==undefined){
				alert("请先填写用户账号！");
				$('#txtacct').focus();
				return;
			}else{
				if(acctRepeat(radacc)==false){
					alert("账号未被使用，可以办理开户业务！");
				}
			}
		}
		
		//用户帐号是否重复的检测		
		function acctRepeat(value){
			var res = fetchSingleValue_rad('dbsql_rad.radUserExist',6,"&user="+tsd.encodeURIComponent(value),'business');			
			if (res > 0){
				alert(value+"已存在，请重新填写！");
				$("#txtacct").select();
				$("#txtacct").focus();
				return true;
			}
			return false;
		}
		//控件是否为空的检测
		function NullCheck(CtlName, value){
			if ($(CtlName).val() == ""&&$(CtlName).attr("disabled")!=true){
				alert(value+"不能为空，请重新填写！");
				$(CtlName).focus();
				return true;
			}
			return false;
		}
		//用户密码是否和确认密码一致的检测 
		function pwdCheck_Same(pwd1, pwd2){
			if (pwd1 != pwd2){
				alert("密码输入不一致，请重新输入确认密码！");
				$("#txtpwd1").select();
				$("#txtpwd1").focus();				
				return true;
			}
			return false;
		}
		//电话有效性(必须存在于yhdang)检测
		function dhNotExist(value){
			if (value != ""){
				var res = fetchSingleValue_rad('dbsql_rad.dhUserExist',6,"&dh="+tsd.encodeURIComponent(value),'business');		
				if (res == 0){
					alert(value+"是无效电话，请重新填写！");
					$("#txtdh").select();
					$("#txtdh").focus();
					return true;
				}
			}
			return false;
		}
		//开户按钮调用的函数
		function save(){
			if (NullCheck("#txtacct", "用户帐号")) {return};
			if (acctRepeat($("#txtacct").val())) {return};
			if (NullCheck("#txtusername", "用户名称")) {return};
			if (NullCheck("#txtpwd", "用户密码")) {return};
			if (NullCheck("#txtpwd1", "确认密码")) {return};
			if (pwdCheck_Same($("#txtpwd").val(), $("#txtpwd1").val())) {return};												
			if (NullCheck("#usertype", "用户类别")) {return};
			if (NullCheck("#userattr", "用户性质")) {return};
			if (dhNotExist($("#txtdh").val())) {return};
			if (NullCheck("#txtuseraddr", "用户地址")) {return};
			if (NullCheck("#radacc", "接入类型")) {return};
			if (NullCheck("#pkgid", "上网套餐")) {return};			
			if (NullCheck("#radpayitem", "付费方式")) {return};			
			var pwdReg = /^\w+$/;					 
		    if(!pwdReg.test($("#txtacct").val())){
		    alert("用户账号不能输入汉字！");
		    $("#txtacct").focus();
		    return false;
		    }
			if (!confirm("您确定要对“"+$("#txtacct").val()+"”帐号进行开户操作吗？")){
				return;
			}					
			savedb();
			reset();		
		}
        //调用宽带开户的后台存储过程
        function savedb(){  
        	//取出所有项目的值，若有可能包含中文的，都做下编码转换		
        	var v_acct = tsd.encodeURIComponent($("#txtacct").val().replace(/(^\s*)|(\s*$)/g,""));
        	var v_user = tsd.encodeURIComponent($("#txtusername").val().replace(/(^\s*)|(\s*$)/g,""));
        	var v_pwd = tsd.encodeURIComponent($("#txtpwd").val().replace(/(^\s*)|(\s*$)/g,""));
        	var v_callpaytype=$("#callpaytype").val();
        	var v_dh = $("#txtdh").val().replace(/(^\s*)|(\s*$)/g,"");
        	var v_yhlb = tsd.encodeURIComponent($("#usertype :selected").text());
        	var v_yhxz = tsd.encodeURIComponent($("#userattr :selected").text());
        	var v_addr = tsd.encodeURIComponent($("#txtuseraddr").val().replace(/(^\s*)|(\s*$)/g,""));
        	var v_acc = tsd.encodeURIComponent($("#radacc").val().replace(/(^\s*)|(\s*$)/g,""));
        	var v_pkgid = $("#pkgid").val().replace(/(^\s*)|(\s*$)/g,"");
        	var v_pkgfee = $("#txtmoney").val().replace(/(^\s*)|(\s*$)/g,"");
        	var v_busifee = $("#txtBussFee").val().replace(/(^\s*)|(\s*$)/g,"");
        	var v_bm1 = tsd.encodeURIComponent($("#sBm1").val().replace(/(^\s*)|(\s*$)/g,""));
        	var v_bm2 = tsd.encodeURIComponent($("#sBm2").val().replace(/(^\s*)|(\s*$)/g,""));
        	var v_bm3 = tsd.encodeURIComponent($("#sBm3").val().replace(/(^\s*)|(\s*$)/g,""));
        	var v_bm4 = tsd.encodeURIComponent($("#sBm4").val().replace(/(^\s*)|(\s*$)/g,""));
        	var v_cardtype="";
			if($("#cardtype").val()!=""){
				v_cardtype = tsd.encodeURIComponent($("#cardtype option:selected").text().replace(/(^\s*)|(\s*$)/g,""));	
			}        	
        	var v_cardid = tsd.encodeURIComponent($("#txtcardid").val().replace(/(^\s*)|(\s*$)/g,""));
        	var v_lxr = tsd.encodeURIComponent($("#txtlinkman").val().replace(/(^\s*)|(\s*$)/g,""));
        	var v_lxdh = $("#txtlinkphone").val().replace(/(^\s*)|(\s*$)/g,"");
        	var v_yddh = $("#txtmobile").val().replace(/(^\s*)|(\s*$)/g,"");  
        	var v_userarea = tsd.encodeURIComponent($("#txtuserarea").val().replace(/(^\s*)|(\s*$)/g,""));      	
        	var v_bz = tsd.encodeURIComponent($("#txtmemo").val().replace(/(^\s*)|(\s*$)/g,""));
        	//var v_paytype = $("#radpayitem").val().replace(/(^\s*)|(\s*$)/g,"");
        	var v_paytype = $("#callpaytype").val().replace(/(^\s*)|(\s*$)/g,"");
        	var v_workmemo = tsd.encodeURIComponent($("#workmemo").val().replace(/(^\s*)|(\s*$)/g,"")); 
        	var pubParam = getPubProcParam(); //加上两个金额参数
        	var busiywarea = tsd.encodeURIComponent($("#ywarea").val().replace(/(^\s*)|(\s*$)/g,""));//业务区域
        	var enddate = $("#enddate").val().replace(/(^\s*)|(\s*$)/g,"");
         	var param=pubParam+"&internetacct="+v_acct+"&pwd="+v_pwd+"&username="+v_user+"&useraddr="+v_addr
        		+"&bm1="+v_bm1+"&bm2="+v_bm2+"&bm3="+v_bm3+"&bm4="+v_bm4
        		+"&usertype="+v_yhlb+"&userattr="+v_yhxz+"&pkgid="+v_pkgid+"&paytype="+v_paytype+"&callpaytype="+v_callpaytype
        		+"&cardtype="+v_cardtype+"&cardid="+v_cardid+"&mobile="+v_yddh+"&linkphone="+v_lxdh+"&userarea="+v_userarea
        		+"&linkman="+v_lxr+"&dh="+v_dh+"&accesstype="+v_acc+"&usermemo="+v_bz+"&pkgfee="+v_pkgfee+"&busifee="+v_busifee+"&workmemo="+v_workmemo+"&busiywarea="+busiywarea+"&newenddate="+enddate+"&firbilldate="+$("#hidfirbilldate").val();
        	
        	param=param+"&acctstarttime="+$("#txtregdate").val()+"&acctstarttime="+$("#txtregdate").val()+"&speed="+$("#hidspeed").val()+"&autoband="+$("#autobandtype").val()+"&cheque="+$("#txtchequenum").val();
        	var authparam="&busitype=setup&username="+v_acct+"&pwd="+v_pwd+"&acctstarttime="+$("#txtregdate").val()+"&acctstoptime="+$("#enddate").val()+"&speed="+$("#hidspeed").val()+"&autoband="+$("#autobandtype").val();
        	
       		var flag='succ';//fetchMultiPValue_rad("data_sync",8,authparam);				
       		if(flag == '-1'){
       			alert("向认证数据库同步失败【该账号已经存在】！请联系管理员。");
       			return;
       		}else if(flag=='0'){
       			alert("向认证数据库同步失败【系统不识别的业务类型】！请联系管理员。");
       			return;
       		}else{
       			var res = fetchMultiPValue_rad("rad_busi",6,param);
	        	if(res[0][0]=="SUCCEED"){
	        		if (parseFloat($("#txthj").val()) > 0){
	        			$("#jobid").val(res[0][1]);
	        			//setRepFileField();//由于付费方式加载失败先注释掉        
	        			//printworkorder('setup');//业务类型，取自于tsd_ini(tsection='radbusi_busifee' and tident='setup' )
	        			alert("开户成功！");
						jobPrint(res[0][1]);
	        			kdunLock();        			
	        		}else{
	        			alert("开户成功！");
	        			jobPrint(res[0][1]);
	        			kdunLock();
	        		}
	        	}else if(res[0][0]=="FAILED"){
	        		if(res[0][1]!=""){
	        			alert(res[0][1]);
	        		}else{
	        			alert("开户失败！请与系统管理员联系。");
	        		}
	        	}
       		}
        }
        
        /**********
		* 票据打印
		* @param：
		* @return;
	    **********/
       	function jobPrint(jobid)
       	{			
			var params="";
			params+= "&jobid="+jobid;
       		var urll = $("#thisbasePath").val()+"ReportServer?reportlet=/com/tsdreport/broadband/rad_busi_adduser.cpt"+params;
       		
       		//调打印预览窗口
			window.showModalDialog(urll,window,"dialogWidth:800px; dialogHeight:530px; center:yes; scroll:no");
       	}
        
        function getPubProcParam(){
        	var busitype = "setup";
        	var userid = tsd.encodeURIComponent("<%=sUserId%>");
        	var department = tsd.encodeURIComponent("<%=sDepart%>");
        	var busiarea = tsd.encodeURIComponent("<%=sArea%>");        	 
        	return "&userid="+userid+"&busitype="+busitype+"&department="+department+"&busiarea="+busiarea+"&BusiFeeNames="+BusiFeeNames+"&BusiFeeValues="+BusiFeeValues;
        }	
		//重填按钮调用的函数
		function reset(){						
			$("#input-Unit :text").val("");
			$("#input-Unit :password").val("");
			$("#input-Unit select").val("");
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
			var sql="";
			var paytype=$("#callpaytype").val();
			if(paytype=='0' || paytype=='1'){
				sql="dbsql_rad.radpkgsetenddate_new2";
			}else{
				sql="dbsql_rad.radpkgsetenddate_new";
			}			
			var res = fetchMultiArrayValue(sql,6,"&pkgid="+$("#pkgid").val()+"","business");
			if(res!=undefined){
				if(res[0][2]!=0){
					$("#enddate").val(res[0][0]);
				}else{
					$("#enddate").val("2999-12-31");
				}					
			}else{
				$("#enddate").val("2999-12-31");
			}
			$("#txtregdate").val(res[0][1]);
			if ($("#chkpkgfee").attr("checked")){ 				
				if (res[0][5]!=undefined){
					$("#txtmoney").val(res[0][5]);
				}
				else{
					$("#txtmoney").val("0");
				} 	
			}
			else{
				$("#txtmoney").val("0");
			}
			if(paytype!=2){
				$("#txtmoney").val("0");
			}
			$("#hiduints").val(res[0][2]);
			$("#hidfeerule").val(res[0][3]);
			$("#hidspeed").val(res[0][4]);
			$("#hidfirbilldate").val(res[0][6]);
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
		//计算合计金额
		function caclHJFee(){
			var pkgFee = $("#txtmoney").val();
			var BussFee = $("#txtBussFee").val();
			if (pkgFee == ''){
				pkgFee = "0"
			};
			if (BussFee == ''){
				BussFee = "0"
			};				
			$("#txthj").val(parseFloat(pkgFee)+parseFloat(BussFee));				
		}
		//手续费输入框的回车事件
		function KeyDown_BussFee(event)
		{
			if(event.keyCode==13)
			{
				caclHJFee();
			}
		}
		//弹出业务费用选择面板，并根据选择项目返回相应费用
		function setbusifee(){ 					
			autoBlockFormAndSetWH('divbusifee',250,'345px','close',"#ffffff",false,'', '');
		}
		//根据选择的费用，算出业务费的合计
		function caclbusifee(){			
			BusiFeeNames = "";
			BusiFeeValues = "";
			var rows=document.getElementById('tabbusifee').getElementsByTagName('tr');		
			if (rows.length>1){
				var totalfee = 0;				
				for(i = 1; i < rows.length; i++){
					var arrChk = rows[i].getElementsByTagName( "input");								 
					if (arrChk[0].checked){
						totalfee += parseFloat(rows[i].cells[2].innerText);	
						BusiFeeNames += tsd.encodeURIComponent(rows[i].cells[1].innerText) + ",";
						BusiFeeValues += rows[i].cells[2].innerText + ",";
					}
				}
				$("#txtBussFee").val(totalfee);
				caclHJFee();   
			}
			setTimeout($.unblockUI,15);//关闭费用选择面板
		}
		//输出指定个数的空格
		function writespace(count){
			var s = "";
			for (var i=1; i<=count; i++){
				s+="&nbsp;";
			}
			document.write(s);			
		}
		
		function loadpkgbytype(val){
			$("#pkgid").empty();
			$("#enddate").val('');
			$("#txtmoney").val('0');
			$("#txtBusFee").val('0');
			$("#txthj").val('0');
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
		//获取空账号
		function getEmptyAcc(){
			var result = new Array();
			var i = 0;
			var j = 0;
			var urlstr=tsd.buildParams({ packgname:'service',
				  clsname:'Procedure',
				  method:'exequery',
				  ds:'broadband',//数据源名称 对应的spring配置的数据源
				  tsdpname:'rad_busi.getNullAcc',//存储过程的映射名称
				  tsdExeType:'query',
				  datatype:'xmlattr'
			});						 			                        							 
			$.ajax({
				url:'mainServlet.html?'+urlstr+'&UserName='+uInputValue,
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
					/////////////////////////////
					///////只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
					////////////////////////////
					if (InvalidSessionPro(xml)) {return false};			
					$(xml).find("row").each(function(){				
						result[i++] = new Array();
						$(this).find("cell").each(function(){
							result[i-1].push($(this).text());
						});
					});
				 }
			 });
			return result;
		}
		//获取空账号
		function showAccInfo(){
			var s="";
			$("#keys").val('');
			$("#tabqueryres").empty();
			s="<tr style='line-height: 22px; font-weight:bold; text-align:center;'>";
			s+="<td>上网账号</td>";
			s+="<td>标识</td>";
			s+="<td>归属</td>";
			s+="<td>密码</td>";
			s+="</tr>";
			$("#tabqueryres").append(s);
			autoBlockFormAndSetWH('divquery',70,'','close',"#ffffff",false,'', '');
		}
		
		function getNullAcc(){
			$("#tabqueryres").empty();
			var s="";
			s="<tr style='line-height: 22px; font-weight:bold; text-align:center;'>";
			s+="<td>上网账号</td>";
			s+="<td>标识</td>";
			s+="<td>归属</td>";
			s+="<td>密码</td>";
			s+="</tr>";
			var res = fetchMultiPValue('rad_busi.getNullAcc',6,'&kdHead='+$("#keys").val());	
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					if (res[i][0]==undefined || res[i][1]==undefined){
						continue;
					}				
					s += "<tr style='line-height: 22px;text-align:center' id='"+res[i][0]+"' onclick=\"selectRow('"+res[i][0]+"',1)\"; ondblclick=\"dbclickRow('"+res[i][0]+"','"+res[0][3]+"');\">";					   				 
					s += "<td>"+res[i][0]+"</td>";
					s += "<td>"+res[i][1]+"</td>";
					if(res[i][2]=='0'){
						s += "<td>空闲</td>";
					}else{
						s += "<td>"+res[i][2]+"</td>";
					}
					s += "<td>"+res[i][3]+"</td>";
					s += "</tr>";
				}
				if (s != ""){
					$("#tabqueryres").append(s);
				}
			}else{
				$("#tabqueryres").empty();
				s="<tr style='line-height: 22px; font-weight:bold; text-align:center;'>";
				s+="<td>上网账号</td>";
				s+="<td>标识</td>";
				s+="<td>归属</td>";
				s+="<td>密码</td>";
				s+="</tr>";
				$("#tabqueryres").append(s);
				alert("没有找到匹配的空账号！");
				return;
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
		
		//双击查询面板中的记录行时调用
		function dbclickRow(rowid,pwd){	
			selectRow(rowid,1);
			setuserinfo(pwd); 
		}
		
		function setSave(){
			var rowid=$("#returnUserAcct").val();
			var pwd=$("#"+rowid+" td:eq(3)").text();
			setuserinfo(pwd);
		}
		//模糊查询面板点确定时调用
		function setuserinfo(param){
			var rows=document.getElementById('tabqueryres').getElementsByTagName('tr');		
			if (rows.length>1){
				if ($("#returnUserAcct").val()==""){
				 	alert("请先选中一条记录！");
					return;
				}
				if(kdLock($("#returnUserAcct").val(),$("#userid").val())==true){
					var res = fetchMultiPValue('rad_busi_new.getvlidateacc',6,'&internetacct='+$("#returnUserAcct").val());	
					if (res[0][0] ==  '0'){
						$("#txtacct").val($("#returnUserAcct").val());
						$("#txtpwd").val(param);
						$("#txtpwd1").val(param);
					}else{
						showAccInfo();
						$("#returnUserAcct").val('');
						setTimeout($.unblockUI,15);//关闭模糊查询面板
					}
				}
			}
			$("#returnUserAcct").val('');
			setTimeout($.unblockUI,15);//关闭模糊查询面板
		}
		function showChequeNum(val){
			if (val=='cheque'){
				$("#txtchequenum").attr("disabled","");
				$("#txtchequenum").val('');
				$("#txtchequenum").focus();
			}else{
				$("#txtchequenum").val('');
				$("#txtchequenum").attr("disabled","disabled");
			}
		}
		//同步电话信息
		function getDhinfo(){
			var txtdh = $("#txtdh").val();
			if(txtdh==""){
				alert("请输入住宅电话");
				$("#txtdh").select().focus();
				return;
			}
			var res = fetchMultiArrayValue("dbsql_rad.getqueryDhinfo",6,"&dh="+txtdh+"","business");
			if(res==undefined||res==""){
				$("#txtusername").removeAttr("disabled");			
				$("#usertype").removeAttr("disabled");
				$("#userattr").removeAttr("disabled");
				$("#txtuseraddr").removeAttr("disabled");
				$("#txtpwd").removeAttr("disabled");
				$("#txtpwd1").removeAttr("disabled");
				$("#sBm1").removeAttr("disabled");	
				$("#sBm2").removeAttr("disabled");	
				$("#sBm3").removeAttr("disabled");	
				$("#sBm4").removeAttr("disabled");
				$("#cardtype").removeAttr("disabled");	
				$("#txtcardid").removeAttr("disabled");
				$("#txtlinkman").removeAttr("disabled");	
				$("#txtlinkphone").removeAttr("disabled");	
				return false;
			}
			$("#txtusername").val(res[0][0]);			
			$("#usertype").val(res[0][1]);
			getYhxz();
			$("#userattr").val(res[0][2]);			
			//$("#txtpwd").val(res[0][3]);
			//$("#txtpwd1").val(res[0][3]);
			$("#txtuseraddr").val(res[0][4]);			
			$("#sBm1").val(res[0][5]);
			$("#sBm2").val(res[0][6]);
			$("#sBm3").val(res[0][7]);
			$("#sBm4").val(res[0][8]);
			$("#cardtype").val(res[0][9]);
			$("#txtcardid").val(res[0][10]);
			$("#txtlinkman").val(res[0][11]);
			$("#txtlinkphone").val(res[0][12]);
			/*
			$("#txtusername").attr("disabled","disabled");			
			$("#usertype").attr("disabled","disabled");	
			$("#userattr").attr("disabled","disabled");	
			$("#txtuseraddr").attr("disabled","disabled");	
			$("#txtpwd").attr("disabled","disabled");	
			$("#txtpwd1").attr("disabled","disabled");
			$("#sBm1").attr("disabled","disabled");	
			$("#sBm2").attr("disabled","disabled");	
			$("#sBm3").attr("disabled","disabled");	
			$("#sBm4").attr("disabled","disabled");	
			$("#cardtype").attr("disabled","disabled");	
			$("#txtcardid").attr("disabled","disabled");
			$("#txtlinkman").attr("disabled","disabled");	
			$("#txtlinkphone").attr("disabled","disabled");				
      */ 
		}	  
	</SCRIPT> 
</head>
<body onunload="unIfLock();">
	<DIV class="ui-layout-north" style="overflow-y:hidden">
		<div id="navBar1"  style="margin:-10px;"  scroll="no">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
							您当前所在的位置 ： 														
						</div>
					</td>
					<td width="20%" align="right" valign="top">
						<div id="d2back">
							<a href="javascript:void(0);"
								onclick="parent.history.back(); return false;">返回 </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
	</DIV> 
	<DIV class="ui-layout-south">		
		<div style="margin-top:-5px; margin-bottom:-7px">
			<button class="tsdbutton" id="btnSave" onclick="save();" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;" > 
				确认开户 
			</button>	
			<button class="tsdbutton" id="btnClear" onclick="reset();" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;" >
				重新填写
			</button>						
		</div>
	</DIV> 	
	<DIV class="ui-layout-center">	
		<div id="input-Unit" style="margin-top:-10px">
			<div class="title_rad">				
				重要资料
			</div>
			用户帐号:<input type="text" id="txtacct" name="txtacct" style="width:162px;"/> 
			<input id="btngetAcc" type="button" value="账号检测" onclick="isExists();"/>
			<input id="btngetAcc" style="display: none;" type="button" value="获取空账号" onclick="showAccInfo();"/><br /><br />
			接入类型:<select id="radacc" style="width: 90px;" ></select><font color="red">*</font>&nbsp
			付费类型:<select id="callpaytype" style="width: 90px;" onchange="loadpkgbytype(this.value);" ></select><font color="red">*</font> <br /><br />
			用户名称:<input type="text" id="txtusername" name="txtusername" style="width:162px;"/><font color="red">*</font> <script>writespace(21)</script> <br /><br />
			用户密码:<input type="text" id="txtpwd" name="txtpwd" style="width:86px;"/><font color="red">*</font> &nbsp
			确认密码:<input type="text" id="txtpwd1" name="txtpwd1" style="width:86px;"/><font color="red">*</font> <br /><br />						
			用户类别:<select id="usertype" style="width: 90px;" onchange="getYhxz();"></select><font color="red">*</font> &nbsp
			用户性质:<select id="userattr" style="width: 90px;" ></select><font color="red">*</font>  <br /><br />
			绑定类型:
			<select id="autobandtype" style="width:162px;">
				<option value="0">无绑定</option>
				<option value="1">IP绑定</option>
				<option value="2">MAC绑定</option>
				<option value="3">VLAN绑定</option>
				<option value="4">IP+MAC绑定</option>
				<option value="5">IP+VLAN绑定</option>
				<option value="6">MAC+VLAN绑定</option>
				<option value="7">IP+MAC+VLAN绑定</option>
			</select><font color="red">*</font><script>writespace(23)</script> <br /><br />	
			住宅电话:<input type="text" id="txtdh" name="txtdh" style="width:152px;"/><input id="btnSave" type="button" value="同步电话信息" onclick="getDhinfo();"/>
			<br /><br />	
			用户地址:<input type="text" id="txtuseraddr" name="txtuseraddr" style="width:250px;"/><font color="red">*</font> <br /><br />							
			上网套餐:<select id="pkgid" style="width: 190px;" onchange="setPkgFee();"></select><font color="red">*</font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<br /><br />
			<font style="color:red;">套餐金额:</font><input type="text" id="txtmoney" style="width:90px;font-weight:bold; background:silver;" readonly="true" onpropertychange="caclHJFee();"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<font style="color:red;">业务费:</font><input type="text" id="txtBussFee" style="width:90px; background:silver;" readonly="true"
			onkeypress="numValid(this)" onkeydown="KeyDown_BussFee(event);" 
			onpaste="return !clipboardData.getData('text').match(/\D/)"/><input type="button" value="..." onclick="setbusifee();"/> <br /><br />								
			<font style="color:red;">费用合计:</font><input type="text" id="txthj" style="width:90px;font-weight:bold; background:silver;" readonly="true"/><font color="red">*</font>
			&nbsp;&nbsp;&nbsp;<span style="display: none;">收取</span><input style="display: none;" type="checkbox" id="chkpkgfee" checked="true" onclick="setPkgFee();" />
			<span style="display: none;">付款方式:</span><select id="radpayitem" style="width: 90px;display: none;" onchange="showChequeNum(this.value);" ></select><script>writespace(35)</script><br /><br />
			<span style="display: none;">支票号:</span><input type="text" id="txtchequenum" name="txtchequenum" disabled="disabled" style="width:152px;display: none;"/><script>writespace(24)</script>			
		</div>								
	</DIV> 
	<DIV class="ui-layout-east">
		<div id="input-Unit" style="margin-top:-10px">
			<div class="title_rad">				
				基本资料
			</div>
			开户日期:<input type="text" id="txtregdate" name="txtregdate" style="width:120px; background:silver;" readonly="true";/>&nbsp;&nbsp;&nbsp;&nbsp;
			到期日期:<input type="text" id="enddate"  name="enddate" style="width:120px; background:silver;" readonly="true";/> <br /><br /> 			  			
			一级部门:<input type="text" id="sBm1" style="width:110px;" disabled="disabled"/><input type="button" value="..." onclick="yijisBmhth();"/> &nbsp&nbsp			
			二级部门:<input type="text" id="sBm2" style="width:108px;" disabled="disabled"/><input type="button" value="..." onclick="addsBmerhth();"/><br /><br />
			三级部门:<input type="text" id="sBm3" style="width:110px;" disabled="disabled"/><input type="button" value="..." onclick="addsBmsanhth();"/> &nbsp&nbsp
			四级部门:<input type="text" id="sBm4" style="width:108px;" disabled="disabled"/><input type="button" value="..." onclick="addsBmsihth();"/><br /><br />								 					
			证件名称:<select id="cardtype" style="width: 124px;" ></select> &nbsp&nbsp&nbsp
			证件号码:<input type="text" id="txtcardid" name="txtcardid" style="width:120px;"/> <br /><br />					
			联 系 人:<input type="text" id="txtlinkman" name="txtlinkman" style="width:120px;"/> &nbsp&nbsp&nbsp
			联系电话:<input type="text" id="txtlinkphone" name="txtlinkphone" style="width:120px;"/> <br /><br />
			移动电话:<input type="text" id="txtmobile" name="txtmobile" style="width:120px;"/><script>writespace(50)</script> <br /><br />
			营业区域:<input type="text" id="txtarea" name="txtarea" style="width:120px;background:silver;" readonly="true" /> &nbsp&nbsp&nbsp
			用户区域:<input type="text" id="txtuserarea" style="width:120px;"/> <br /><br />
			资料备注:<input type="text" id="txtmemo" name="txtmemo" style="width:320px;"/> <br /><br />	
			操作备注:<input type="text" id="workmemo" style="width:320px;"/>	
		</div>		 
	</DIV>	
	<select id="yhxz_hidden" style="display:none"></select>
	<input type="hidden" id="sbmcode" />
	<input type="hidden" id="sBm1code" />
	<input type="hidden" id="sBm2code" />
	<input type="hidden" id="sBm3code" /> 
	<input type="hidden" id="sBm4code" />
	<input type="hidden" id="bmtypekey"/>
	<input type="hidden" id="sbmname"/>
	<input type="hidden" id="jobid"/>		
	<input type="hidden" id="repfile"/>
	<input type="hidden" id="hiduints"/>
	<input type="hidden" id="hidfeerule"/>
	<input type="hidden" id="hidspeed"/>
	<input type="hidden" id="ywarea" value="<%=ywarea %>"/>
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->
	<input type="hidden" id="userid" value="<%=sUserId%>"/>
	<input type="hidden" id="returnUserAcct"/>
	<input type="hidden" id="hidfirbilldate"/>
	<!-- 获取空账号  -->
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
				<table border="1" cellpadding="0" bordercolor="#9AC0CD" id="tabtitle" style="width: 530px;">
				<tr style='line-height: 22px; font-weight:bold; text-align:center;'>
				<td colspan='4'>值：<input type='text' id='keys' /><button onclick='getNullAcc();' id="btnaccnull" style='height:23px;width:60px;'>查询</button></td>
				</tr>
				</table>	
				<table border="1" cellpadding="0" bordercolor="#9AC0CD" id="tabqueryres" style="width: 530px;">												
				</table>
			</div>
		</div>
		<div class="midd_butt" style="width:540px;height:38px;">  
			<button id="hthChooseFormSave" onclick="setSave();" class="tsdbutton" 
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
	
	<table id="tabtest">
		<tr id="test1">
			<td>0</td>
			<td>1</td>
			<td>2</td>
		</tr>
	</table>
	
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
					<td width='30px'></td>
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
	<!-- 选择部门div  -->
	<div class="neirong" id="querysBm"	style="width:450px;display: none">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<span id="querysBmtitle"></span>
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
		<div class="midd" style="background-color:#FFFFFF;text-align:left;height:260px;;">
		<div id="broadband_frame">
		   <div id="inputtext">
			<table id="xzhthselect" cellspacing="4">
				<tr>
					<td>查询类型</td>
					<td>
						<select id="querykeybm">
							<option value="1">条件查询</option>
							<option value="2">部门名称</option>								
						</select>
					</td>
					<td>
						<input type="text" id="selectsbmkey" name="selecththcontent" style="width:150px;"/>
					</td>
					<td>
						<button class="tsdbutton" id="submitButton" style="line-height:20px;"
								onclick="querykeysBm()">
								查找
							</button>
					</td>
					</tr>
			</table>
			</div>
			</div>					
				<table id="bytctabs" style="width: 433px;" border="1" cellpadding="0" bordercolor="#9AC0CD">
					<tr><td><center>部门名称</center></td></tr>
				</table>
			<div id="page" style="overflow-y:scroll;height:200px;">					
				<table border="1" cellpadding="0" bordercolor="#9AC0CD"
					id="querybmcontext" style="width: 433px;">												
				</table>
			</div>
		</div>				
		<div class="midd_butt" style="width:440px;height:38px;">  
			<button id="hthChooseFormSave" onclick="savesBm();" class="tsdbutton" 
				style="margin-left: 20px;">
				<!-- 确定 -->
				确定
			</button>
			<button id="hthChooseFormReset" onclick="javascript:setTimeout($.unblockUI,15);$('selectsbmkey').val('');" class="tsdbutton"  style="margin-left: 20px;">
				关闭
				<!-- 关闭 -->
			</button>
		</div>				
	</div>
	<!-- 弹出报表打印框 -->	
	<div id="businessreprint"></div><!-- 加载的文件在script/telephone/business/businessreprint.js -->  
	<iframe id="printReportDirect"  style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>	
</body>
</thml>
