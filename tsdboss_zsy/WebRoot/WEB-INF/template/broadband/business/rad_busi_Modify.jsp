<%----------------------------------------
	name: rad_busi_Modify.jsp
	author: wangli
	version: 1.0 
	description: 修改属性 
	Date: 2011-09-09
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String sUserId = (String) session.getAttribute("userid");
	String sArea = (String) session.getAttribute("chargearea");
	String sDepart = (String) session.getAttribute("departname");
	String sMenuid = request.getParameter("imenuid");
	String sGroupid = request.getParameter("groupid");
	String ywarea = (String) session.getAttribute("userarea");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/ui/jquery.layout.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/ui/jquery-ui-1.7.1.custom.js"
			type="text/javascript"></script>
		<script src="script/broadband/business/broadbandservice.js"
			type="text/javascript"></script>
		<script src="script/broadband/business/radbusiprint.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js"
			type="text/javascript"></script>
		<!-- 弹出面板需要导入js文件 -->
		<script type="text/javascript" src="script/public/tsdpower.js"></script>
		<!-- 页面权限控制 -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/mainStyle.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script type="text/javascript" src="script/public/revenue.js"></script>
		<!-- 时间选择器需要导入的js文件 -->
		<script type="text/javascript"
			src="plug-in/My97DatePicker/WdatePicker.js"></script>

		<link href="style/css/public/tsd-css.css" rel="stylesheet"
			type="text/css" />
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<!-- 新的面板样式 -->
		<link href="style/css/telephone/business/businesspublic.css"
			rel="stylesheet" type="text/css" />
		<style type="text/css">
#input-Unit {
	float: left;
	width: 100%;
	text-align: center;
}

#input-Unit .title_rad {
	width: 100%;
	height: 22px;
	border-bottom: 1px solid #C8D8E5;
	text-align: center;
	color: #3C3C3C;
	line-height: 22px;
	font-weight: bold;
	background: #CCCCFF;
}

.tsdbutton_rad {
	width: 70px;
	height: 22px;
	background: url(style/images/public/buttonsbg.jpg) repeat-x;
	border: #CCCCCC 1px solid;
	cursor: pointer;
}
</style>
		<script type="text/javascript">
		var mylayout;		
		var recarr;	
		var BusiFeeNames = "";
		var BusiFeeValues = "";		
		var _user_modify_ = false;				
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
			initBusiFee();
			setEastWidth();			
			setPower();			
			$("#navBar").append(genNavv());		
			getywslUserPower();
			
			//modify by wcy 2016-09-18，宽带接入类型可修改
			//$("#txtacct,#txtusername,#usertype,#userattr,#txtdh,#txtuseraddr,#radacc,#pkgid,#txtmoney,#radpayitem,#txtregdate,#enddate,#sBm1b,#sBm2b,#sBm3b,#sBm4b,#cardtype,#txtcardid,#txtlinkman,#txtlinkphone,#txtmobile,#txtarea,#txtuserarea,#txtmemo,#workmemo,#portbutten").attr("disabled","disabled");
			$("#txtacct,#txtusername,#usertype,#userattr,#txtdh,#txtuseraddr,#pkgid,#txtmoney,#radpayitem,#txtregdate,#enddate,#sBm1b,#sBm2b,#sBm3b,#sBm4b,#cardtype,#txtcardid,#txtlinkman,#txtlinkphone,#txtmobile,#txtarea,#txtuserarea,#txtmemo,#workmemo,#portbutten").attr("disabled","disabled");
			
			if($("#modifyright").val()=="true"){
			$("#txtacct,#txtusername,#usertype,#userattr,#txtdh,#txtuseraddr,#txtmoney,#radpayitem,#txtregdate,#enddate,#sBm1b,#sBm2b,#sBm3b,#sBm4b,#cardtype,#txtcardid,#txtlinkman,#txtlinkphone,#txtmobile,#txtarea,#txtuserarea,#txtmemo,#workmemo,#portbutten").removeAttr("disabled");	
			}else{
$("#txtusername,#usertype,#userattr,#txtdh,#txtuseraddr,#txtmoney,#radpayitem,#sBm1b,#sBm2b,#sBm3b,#sBm4b,#cardtype,#txtcardid,#txtlinkman,#txtlinkphone,#txtmobile,#txtarea,#txtuserarea,#txtmemo,#workmemo").removeAttr("disabled");					
			}																		
		});
		//取出用户的扩展权限，进行相应的权限控制(目前仅有手续费)
		function setPower(){
			var sPower = getUserPower("<%=sUserId%>","<%=sGroupid%>","<%=sMenuid%>");			
			//若为管理员权限，则可以编辑手续费项目
			if(sPower=='all@'){
				//setReadonly($("#txtBussFee"), true);				
			}
			else if(sPower!=''&&sPower!='all@'){  //若为普通权限，则根据具体权限控制
				var spowerarr = sPower.split('@');
				var temp;
				for(var i = 0;i<spowerarr.length-1;i++){				
					if (spowerarr[i].indexOf("radBusiFee")>0){
						temp = getCaption(spowerarr[i],'radBusiFee','');
						if (temp.toLowerCase() == 'true'){
							//setReadonly($("#txtBussFee"), false);
						}
						else{
							//setReadonly($("#txtBussFee"), true);
						}
						if (spowerarr[i].indexOf("radBusiLimitArea")>0){
							temp = getCaption(spowerarr[i],'radBusiLimitArea','');							
							$("#IsLimitArea").val(temp);							
						}
						else{
							$("#IsLimitArea").val("false"); 
						}						
					}
				}
			}
			else{ //若没有设置权限，默认不能操作
				//setReadonly($("#txtBussFee"), true);
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
		//根据权限限制是否能跨区域办理
		function limitArea(limit, userArea, thisArea){
			if (limit=="true"){
				if (userArea!=thisArea){	
					alert("该用户的开户所在地是“"+userArea+"”，请到此营业点办理本项业务！");						
					return true;
				}
			}
			return false;
		}
		//清空用户资料显示框
		function clear(){
			$("#input-Unit :text").val("");			
			$("#input-Unit :password").val("");
			$("#input-Unit select").val("");						
		}		
		//初始化业务费选择表格
		function initBusiFee(){
			var s="";  
			var res = getBussFee('modify');			
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
			//$("#txtBussFee").val(0); 			
			$("#radpayitem").val("cash");	
			$("#queryvalue").focus()
			$("#workmemo").val("");
			$("#txtacct").attr("readonly", true);  //用户账号不可修改 				
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
				    var radtype = xml.substring(xml.indexOf("<radpkg=")+8,xml.indexOf("radpkg/>"));				    
				    var radacc = xml.substring(xml.indexOf("<radacc=")+8,xml.indexOf("radacc/>"));				    
				    var payitem = xml.substring(xml.indexOf("<radpayitem=")+12,xml.indexOf("radpayitem/>"));
				    
					$("#usertype").html(syhlb);
					$("#userattr").html("<option value='' selected='true'>--请选择--</option>");
					$("#yhxz_hidden").html(yhxz);
					$("#cardtype").html(idtype);
					$("#pkgid").html(radtype);
					$("#radacc").html(radacc);
					$("#radpayitem").html(payitem);
					$("#radpayitem").val("cash");
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
			if (acctCheck("#txtacct", "修改资料")) {return};			
			if (limitArea($("#IsLimitArea").val(),$("#txtarea").val(), "<%=sArea%>")) {return};
			if (NullCheck("#txtusername", "用户名称")) {return};
			if (NullCheck("#txtpwd", "用户密码")) {return};
			if (NullCheck("#txtpwd1", "确认密码")) {return};
			if (pwdCheck_Same($("#txtpwd").val(), $("#txtpwd1").val())) {return};												
			if (NullCheck("#usertype", "用户类别")) {return};
			//if (NullCheck("#userattr", "用户性质")) {return};
			//if (dhNotExist($("#txtdh").val())) {return};
			if (NullCheck("#txtuseraddr", "用户地址")) {return};
			if (NullCheck("#radacc", "接入类型")) {return};
			if (NullCheck("#pkgid", "上网套餐")) {return};			
			if (NullCheck("#enddate", "到期日期")) {return};
			if (NullCheck("#radpayitem", "付费方式")) {return};									
			if (!confirm("您确定要对“"+$("#txtacct").val()+"”帐号进行修改操作吗？")){
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
        	//var v_busifee = $("#txtBussFee").val();
        	var v_busifee = '';
        	var v_paytype = $("#radpayitem").val();      	
        	var v_workmemo = tsd.encodeURIComponent($("#workmemo").val());
        	var pubParam = getPubProcParam(); 
        	var modifyField = getModifyField(recarr); 
         	var param=pubParam+modifyField+"&internetacct="+v_acct+"&paytype="+v_paytype+"&busifee="+v_busifee+"&workmemo="+v_workmemo+"&autoband="+$("#autobandtype").val();
			
        	var res = fetchMultiPValue_rad("rad_busi",6,param);        	      
        	if(res[0][0]=="SUCCEED"){
        	/*
        		if (parseFloat($("#txtBussFee").val()) > 0){
        			$("#jobid").val(res[0][1]);
        			setRepFileField();
        			printworkorder('modify');//业务类型，取自于tsd_ini(tsection='radbusi_busifee' and tident='r_modify' )        			
        		}
        		else{	
        			alert("修改资料成功！\r\n\n点击“确定”按钮办理下一笔修改资料业务。");
        		}*/
        			alert("修改资料成功！\r\n\n点击“确定”按钮办理下一笔修改资料业务。");
        		/*var flag = fetchMultiPValue_rad("data_sync",8,param);
        		if(flag == '-1'){
        			alert("向认证数据库同步失败【该账号已经存在】！请联系管理员。");
        			return;
        		}else if(flag=='0'){
        			alert("向认证数据库同步失败【系统不识别的业务类型】！请联系管理员。");
        			return;
        		}*/
        	}else{
        		alert(res[0][1]);
        	}        	
        }	
        function getPubProcParam(){
        	var busitype = "modify";
        	var userid = tsd.encodeURIComponent("<%=sUserId%>");
        	var department = tsd.encodeURIComponent("<%=sDepart%>");
        	var busiarea = tsd.encodeURIComponent("<%=sArea%>");
        	var busiywarea = tsd.encodeURIComponent("<%=ywarea%>");
        	return "&userid="+userid+"&busitype="+busitype+"&department="+department+"&busiarea="+busiarea+"&BusiFeeNames="+BusiFeeNames+"&BusiFeeValues="+BusiFeeValues+"&busiywarea="+busiywarea;
        }
        //返回修改了值的字段及修改值
        function getModifyField(arr){
        	var s = "";
        	var v_user = tsd.encodeURIComponent($("#txtusername").val());
        	var v_pwd = tsd.encodeURIComponent($("#txtpwd").val());
        	var v_dh = $("#txtdh").val();
        	var v_yhlb = tsd.encodeURIComponent($("#usertype :selected").text());
        	var v_yhxz = tsd.encodeURIComponent($("#userattr :selected").text());        	
        	var v_addr = tsd.encodeURIComponent($("#txtuseraddr").val());
        	var v_acc = tsd.encodeURIComponent($("#radacc").val());
        	var v_pkgid = $("#pkgid").val();
        	var v_bm1 = tsd.encodeURIComponent($("#sBm1").val());
        	var v_bm2 = tsd.encodeURIComponent($("#sBm2").val());
        	var v_bm3 = tsd.encodeURIComponent($("#sBm3").val());
        	var v_bm4 = tsd.encodeURIComponent($("#sBm4").val());
			if($("#cardtype").val()!=""){
				var v_cardtype = tsd.encodeURIComponent($("#cardtype option:selected").text());
			}          	
        	var v_cardid = tsd.encodeURIComponent($("#txtcardid").val());
        	var v_lxr = tsd.encodeURIComponent($("#txtlinkman").val());
        	var v_lxdh = $("#txtlinkphone").val();
        	var v_yddh = $("#txtmobile").val();
        	var v_area = tsd.encodeURIComponent($("#txtarea").val());
        	var v_bz = tsd.encodeURIComponent($("#txtmemo").val());
        	var v_userarea = tsd.encodeURIComponent($("#txtuserarea").val());         	
        	var v_enddate = tsd.encodeURIComponent($("#enddate").val());
        	var v_radspeed = tsd.encodeURIComponent($("#radspeed").val());
			//日志处理
			var loginfo="";
			if(v_pwd!=tsd.encodeURIComponent(_user_modify_["txtpwd"])){loginfo += tsd.encodeURIComponent("【用户密码:"+_user_modify_["txtpwd"]+">>")+v_pwd+tsd.encodeURIComponent("】<br/>");}	
			if(v_user!=tsd.encodeURIComponent(_user_modify_["txtusername"])){loginfo += tsd.encodeURIComponent("【用户名称:"+_user_modify_["txtusername"]+">>")+v_user+tsd.encodeURIComponent("】<br/>");}	
			if(v_addr!=tsd.encodeURIComponent(_user_modify_["txtuseraddr"])){loginfo += tsd.encodeURIComponent("【用户地址:"+_user_modify_["txtuseraddr"]+">>")+v_addr+tsd.encodeURIComponent("】<br/>");}	
			if(v_area!=tsd.encodeURIComponent(_user_modify_["txtarea"])){loginfo += tsd.encodeURIComponent("【营业区域:"+_user_modify_["txtarea"]+">>")+v_area+tsd.encodeURIComponent("】<br/>");}	
			if(v_yhlb!=tsd.encodeURIComponent(_user_modify_["usertype"])){loginfo += tsd.encodeURIComponent("【用户类别:"+_user_modify_["usertype"]+">>")+v_yhlb+tsd.encodeURIComponent("】<br/>");}	
			if(v_yhxz!=tsd.encodeURIComponent(_user_modify_["userattr"])){loginfo += tsd.encodeURIComponent("【用户性质:"+_user_modify_["userattr"]+">>")+v_yhxz+tsd.encodeURIComponent("】<br/>");}	
			if(v_pkgid!=tsd.encodeURIComponent(_user_modify_["pkgid"])){loginfo += tsd.encodeURIComponent("【用户上网套餐:"+_user_modify_["pkgid"]+">>")+v_pkgid+tsd.encodeURIComponent("】<br/>");}	
			if(v_acc!=tsd.encodeURIComponent(_user_modify_["radacc"])){loginfo += tsd.encodeURIComponent("【接入类型:"+_user_modify_["radacc"]+">>")+v_acc+tsd.encodeURIComponent("】<br/>");}
			if(v_radspeed!=tsd.encodeURIComponent(_user_modify_["radspeed"])){loginfo += tsd.encodeURIComponent("【带宽:"+_user_modify_["radspeed"]+">>")+v_enddate+tsd.encodeURIComponent("】<br/>");}	
			if(v_bm1!=tsd.encodeURIComponent(_user_modify_["sBm1"])){loginfo += tsd.encodeURIComponent("【一级部门:"+_user_modify_["sBm1"]+">>")+v_bm1+tsd.encodeURIComponent("】<br/>");}	
			if(v_bm2!=tsd.encodeURIComponent(_user_modify_["sBm2"])){loginfo += tsd.encodeURIComponent("【二级部门:"+_user_modify_["sBm2"]+">>")+v_bm2+tsd.encodeURIComponent("】<br/>");}	
			if(v_bm3!=tsd.encodeURIComponent(_user_modify_["sBm3"])){loginfo += tsd.encodeURIComponent("【三级部门:"+_user_modify_["sBm3"]+">>")+v_bm3+tsd.encodeURIComponent("】<br/>");}	
			if(v_bm4!=tsd.encodeURIComponent(_user_modify_["sBm4"])){loginfo += tsd.encodeURIComponent("【四级部门:"+_user_modify_["sBm4"]+">>")+v_bm4+tsd.encodeURIComponent("】<br/>");}	
			if(v_cardtype!=tsd.encodeURIComponent(_user_modify_["cardtype"])){loginfo += tsd.encodeURIComponent("【证件名称:"+_user_modify_["cardtype"]+">>")+v_cardtype+tsd.encodeURIComponent("】<br/>");}	
			if(v_cardid!=tsd.encodeURIComponent(_user_modify_["txtcardid"])){loginfo += tsd.encodeURIComponent("【证件号码:"+_user_modify_["txtcardid"]+">>")+v_cardid+tsd.encodeURIComponent("】<br/>");}	
			if(v_lxr!=tsd.encodeURIComponent(_user_modify_["txtlinkman"])){loginfo += tsd.encodeURIComponent("【联 系 人:"+_user_modify_["txtlinkman"]+">>")+v_lxr+tsd.encodeURIComponent("】<br/>");}	
			if(v_lxdh!=tsd.encodeURIComponent(_user_modify_["txtlinkphone"])){loginfo += tsd.encodeURIComponent("【联系电话:"+_user_modify_["txtlinkphone"]+">>")+v_lxdh+tsd.encodeURIComponent("】<br/>");}			
			if(v_userarea!=tsd.encodeURIComponent(_user_modify_["txtuserarea"])){loginfo += tsd.encodeURIComponent("【用户区域:"+_user_modify_["txtuserarea"]+">>")+v_userarea+tsd.encodeURIComponent("】<br/>");}
			if(v_enddate!=tsd.encodeURIComponent(_user_modify_["enddate"])){loginfo += tsd.encodeURIComponent("【到期日期:"+_user_modify_["enddate"]+">>")+v_enddate+tsd.encodeURIComponent("】<br/>");}
        	s+="&pwd="+v_pwd;
        	s+="&username="+v_user;
        	s+="&useraddr="+v_addr;
        	s+="&area="+v_area;
        	s+="&usertype="+v_yhlb;
        	s+="&userattr="+v_yhxz;
        	s+="&pkgid="+v_pkgid;
        	s+="&accesstype="+v_acc;
        	s+="&speed="+v_radspeed;
        	s+="&dh="+v_dh;
        	s+="&bm1="+v_bm1;
        	s+="&bm2="+v_bm2;
        	s+="&bm3="+v_bm3;
        	s+="&bm4="+v_bm4;
        	s+="&cardtype="+v_cardtype;
        	s+="&cardid="+v_cardid;
        	s+="&linkman="+v_lxr;
        	s+="&linkphone="+v_lxdh;
        	s+="&mobile="+v_yddh;
        	s+="&userarea="+v_userarea;
        	s+="&enddate="+v_enddate;
        	s+="&usermemo="+loginfo;        	
        	return s;     
        }	
		//重填按钮调用的函数
		function reset(){	
			if ($("#txtacct").val()!=""){
				setValue(recarr);
			}								
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
			var ctlpkg = document.getElementById("pkgid");			
			//var radfee = ctlpkg.options[ctlpkg.options.selectedIndex].lvalue;		
			var radfee	=undefined;
			if (radfee!=undefined){
				var array = radfee.split("|");	
				$("#txtmoney").val(array[2]);
			}
			else{
				$("#txtmoney").val("0");
			};
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
		//弹出因为费用选择面板，并根据选择项目返回相应费用
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
				//$("#txtBussFee").val(totalfee);				   
			}
			setTimeout($.unblockUI,15);//关闭费用选择面板
		}
		//根据字段名和字段值查询raduserinfo表. 精确查找
		function queryRadUser_equal(){
			var fieldname = $("#queryfield").val(); 
			var fieldvalue = $("#queryvalue").val();
			queryRadUser_equalReal(fieldname,fieldvalue);			
		}
		function queryRadUser_equalReal(fieldname,fieldvalue){
			var res = fetchMultiArrayValue_rad('dbsql_rad.queryRadUser_equal1',6,"&fieldname="+fieldname+"&fieldvalue="+tsd.encodeURIComponent(fieldvalue),'business');
			if (res != undefined && res!="" && res.length>0){
				setValue(res);
				recarr = res;								
			}
			else{
				alert("没有符合条件的用户，请确认您的输入是否正确！");
				clear();
				initValue();
				$("#queryvalue").select();
				$("#queryvalue").focus();
				recarr = undefined;
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
					s += "<tr style='line-height: 22px;' id='"+res[i][0]+"' onclick=\"selectRow('"+res[i][0]+"')\"; ondblclick=\"dbclickRow('"+res[i][0]+"');\">";					   				 
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
				recarr = undefined;
				return;
			}
		}
		//模糊查询面板选中一条记录，变底色		
		function selectRow(rowid){			
			$("#returnUserAcct").val(rowid);
			document.getElementById(rowid).style.background='#0080FF';
		}
		//模糊查询面板点确定时调用
		function setuserinfo(){
			var rows=document.getElementById('tabqueryres').getElementsByTagName('tr');		
			if (rows.length>1){
				if ($("#returnUserAcct").val()==""){
				 	alert("请先选中一条记录！");
					return;
				}				
				queryRadUser_equalReal('internetacct',$("#returnUserAcct").val());
			}
			setTimeout($.unblockUI,15);//关闭模糊查询面板
		}
		//双击查询面板中的记录行时调用
		function dbclickRow(rowid){					
			selectRow(rowid);
			setuserinfo(); 
		}
		//根据查询结果数组，给控件赋值
		function setValue(arr){     
			var tmp = new Object(); 	
        	$("#txtacct").val(arr[0][0]);
        	tmp["txtacct"]=arr[0][0];
        	$("#txtusername").val(arr[0][1]);
        	tmp["txtusername"]=arr[0][1];
        	$("#txtuseraddr").val(arr[0][2]);
        	tmp["txtuseraddr"]=arr[0][2];
        	$("#sBm1").val(arr[0][3]);
        	tmp["sBm1"]=arr[0][3];
        	$("#sBm2").val(arr[0][4]);
        	tmp["sBm2"]=arr[0][4];
        	$("#sBm3").val(arr[0][5]);
        	tmp["sBm3"]=arr[0][5];
        	$("#sBm4").val(arr[0][6]);
        	tmp["sBm4"]=arr[0][6];
        	$("#txtarea").val(arr[0][7]);
        	tmp["txtarea"]=arr[0][7];
        	$("#usertype").val(arr[0][8]);
        	tmp["usertype"]=arr[0][8]; 
        	getYhxz();       	
        	$("#userattr").val(arr[0][9]);
        	tmp["userattr"]=arr[0][9]; 
        	$("#txtregdate").val(arr[0][10]);
        	tmp["txtregdate"]=arr[0][10];         	        	
        	$("#startdate").val(arr[0][11]);
        	tmp["startdate"]=arr[0][11]; 
        	$("#enddate").val(arr[0][12]);
        	tmp["enddate"]=arr[0][12]; 
        	$("#pkgid").val(arr[0][13]); 
        	tmp["pkgid"]=arr[0][13];          	       	
        	$("#txtstatus").val(arr[0][14]);
        	tmp["txtstatus"]=arr[0][14];
        	$("#cardtype").val(arr[0][15]);
        	tmp["cardtype"]=arr[0][15];
        	$("#txtcardid").val(arr[0][16]);
        	tmp["txtcardid"]=arr[0][16];
        	$("#txtmobile").val(arr[0][17]);
        	tmp["txtmobile"]=arr[0][17];
        	$("#txtlinkphone").val(arr[0][18]);
        	tmp["txtlinkphone"]=arr[0][18];
        	$("#txtlinkman").val(arr[0][19]);
        	tmp["txtlinkman"]=arr[0][19];         	
        	$("#txtdh").val(arr[0][20]);
        	tmp["txtdh"]=arr[0][20];
        	$("#radacc").val(arr[0][21]);
        	tmp["radacc"]=arr[0][21];
        	$("#txtmemo").val(arr[0][22]);
        	tmp["txtmemo"]=arr[0][22];
        	$("#txtpwd").val(arr[0][23]);
        	tmp["txtpwd"]=arr[0][23];
        	$("#txtpwd1").val(arr[0][23]);
        	tmp["txtpwd1"]=arr[0][23];
        	$("#txtuserarea").val(arr[0][24]);
        	tmp["txtuserarea"]=arr[0][24];
        	$("#autobandtype").val(arr[0][25]);
        	tmp["autobandtype"]=arr[0][25];
        	
        	$("#radspeed").val(arr[0][27]);
        	tmp["radspeed"]=arr[0][27];
        	_user_modify_=tmp;
        	inLock("modify",arr[0][1]);
        	setPkgFee();  
        	getRouteMX(arr[0][0],0);   	      	
		}
		//输出指定个数的空格
		function writespace(count){
			var s = "";
			for (var i=1; i<=count; i++){
				s+="&nbsp;";
			}
			document.write(s);			
		}
		
		function getywslUserPower(){
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
				var modifyright='';
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
						modifyright='true';
						flag = true;
				}else if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');
						for(var i = 0;i<spowerarr.length-1;i++){
							modifyright +=getCaption(spowerarr[i],'modify','')+'|';//
						}
				}
				var hasmodify = modifyright.split('|');
				var str = 'true';
				if(flag==true){
					$("#modifyright").val(modifyright);
				}else{
					for(var i = 0;i<hasmodify.length;i++){
							$("#modifyright").val(hasmodify[i]);
							break;
						}
				}		
			}
	// add by zhangpeng
	function equipRoute(){
	   var ywlx='broadband';
	   var username=$("#txtacct").val();
	  var acct='ADSL';
	  var jobid=0;
	  window.showModalDialog('mainServlet.html?pagename=route/RouteManage.jsp&ywlx=' + ywlx+'&username='+username+'&accesstype='+acct+'&jobid='+jobid, window, 'dialogWidth:900px; dialogHeight:500px; center:yes; scroll:no');
	
}		
    function getRouteMX(dh,jobid){
	   var table_name='air_route_broadband';
	    var urlstr = tsd.buildParams({
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'WorkFlow.getRouteMX'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax({
        url : 'mainServlet.html?dh=' + dh +'&'+ urlstr+'&tablename='+table_name + '&tsdtemp=' + Math.random(), 
        datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 5000, async : false , //同步方式
        success : function (xml)
        {
        	$(xml).find('row').each(function(){
        	   var route = $(this).attr("route");
	        	if(route==undefined){
	        		route='未配置号线信息';
	        		
	        	}
	        	$("#route1").val(route); 
	        	
	        	
        	})
        	}
        })
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
			$("#txtuseraddr").val(res[0][4]);			
			$("#sBm1").val(res[0][5]);
			$("#sBm2").val(res[0][6]);
			$("#sBm3").val(res[0][7]);
			$("#sBm4").val(res[0][8]);
			$("#cardtype").val(res[0][9]);
			$("#txtcardid").val(res[0][10]);
			$("#txtlinkman").val(res[0][11]);
			$("#txtlinkphone").val(res[0][12]);
		}	
	</SCRIPT>
	</head>
	<body onunload="unLock()">
		<DIV class="ui-layout-north">
			<div id="navBar1" style="margin: -10px">
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
									onclick="parent.history.back(); return false;"> 返回 </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div
				style="width: 100%; height: 30px; text-align: left; font-weight: bold; margin-top: 25px;">
				&nbsp;&nbsp;
				<img src="style/icon/65.gif" />
				&nbsp;&nbsp;&nbsp;&nbsp; 查询方式:
				<select id="queryfield" style="width: 90px;">
				<option value="dh">住宅电话</option>
				<option value="username">用户名称</option>
				<option value="useraddr">用户地址</option>
				<option value="internetacct">宽带账号</option>
				</select>
				<input type="text" id="queryvalue" style="width: 162px;" />
				<input class="tsdbutton_rad" type="button" value="精确查询"
					onclick="queryRadUser_equal();" />
				<input class="tsdbutton_rad" type="button" value="模糊查询"
					onclick="popupQueryPanel();" />
			</div>
		</DIV>
		<DIV class="ui-layout-south">
			<div style="margin-top: -5px; margin-bottom: -7px">
				<button class="tsdbutton" id="btnSave" onclick="save();"
					style="width: 70px; line-height: 25px; margin-top: 1px; padding: 0px;">
					确认修改
				</button>
				<button class="tsdbutton" id="btnClear" onclick="reset();"
					style="width: 70px; line-height: 25px; margin-top: 1px; padding: 0px;">
					重新填写
				</button>
			</div>
		</DIV>
		<DIV class="ui-layout-center">
			<div id="input-Unit" style="margin-top: -10px">
				<div class="title_rad">
					重要资料
				</div>
				宽带账号:
				<input type="text" id="txtacct" name="txtacct"
					style="width: 162px; background: silver;" />
				<font color="red">*</font>
				<script>writespace(21)</script>
				<br />
				<br />
				用户名称:
				<input type="text" id="txtusername" name="txtusername"
					style="width: 162px;" />
				<font color="red">*</font>
				<script>writespace(21)</script>
				<br />
				<br />
				用户密码:
				<input type="text" id="txtpwd" name="txtpwd"
					style="width: 86px;" />
				<font color="red">*</font> &nbsp 确认密码:
				<input type="text" id="txtpwd1" name="txtpwd1"
					style="width: 86px;" />
				<font color="red">*</font>
				<br />
				<br />
				用户类别:
				<select id="usertype" style="width: 90px;" onchange="getYhxz();"></select>
				<font color="red">*</font> &nbsp 用户性质:
				<select id="userattr" style="width: 90px;"></select>
				<font color="red">*</font>
				<br />
				<br />
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
				</select><font color="red">*</font><script>writespace(21)</script>&nbsp;&nbsp;&nbsp;  <br /><br />	
				住宅电话:
				<input type="text" id="txtdh" name="txtdh" style="width: 152px;" />
				<input id="btnSave" type="button" value="同步电话信息" onclick="getDhinfo();"/>
				<br />
				<br />
				用户地址:
				<input type="text" id="txtuseraddr" name="txtuseraddr"
					style="width: 250px;" />
				<font color="red">*</font>
				<br />
				<br />
				接入类型:
				<select id="radacc" style="width: 130px;"></select>
				<font color="red">*</font>
				带宽:
				<select id="radspeed" style="width: 80px;">
					<option value="">请选择</option>
					<option value="1024">1M</option>
					<option value="2048">2M</option>
					<option value="4096">4M</option>
					<option value="6144">6M</option>
					<option value="8192">8M</option>
					<option value="10240">10M</option>
				</select>
				<font color="red">*</font>
				<br />
				<br />
				上网套餐:
				<select id="pkgid" style="width: 190px;" onchange="setPkgFee();"></select>
				<font color="red">*</font> &nbsp&nbsp
				<input type="text" id="txtmoney"
					style="width: 35px; background: silver;" readonly="true" />
				￥
				<br />
				<br />
				付费方式:
				<select id="radpayitem" style="width: 90px;"></select>
				<font color="red">*</font> &nbsp
				<!-- 
				<font style="color: red;">业 务 费:</font>
				<input type="text" id="txtBussFee"
					style="width: 90px; background: silver;" readonly="true"
					onkeypress="numValid(this)"
					onpaste="return !clipboardData.getData('text').match(/\D/)" />
				<input type="button" value="..." onclick="setbusifee();" />
				 -->
			</div>
		</DIV>
		<DIV class="ui-layout-east">
			<div id="input-Unit" style="margin-top: -10px">
				<div class="title_rad">
					基本资料
				</div>
				开户日期:
				<input type="text" id="txtregdate" name="txtregdate"
					style="width: 120px; background: silver;" readonly="true" ;/>
				&nbsp&nbsp 到期日期:
				<input type="text" id="enddate" style="width: 120px;"
					onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" />
				<br />
				<br />
				一级部门:
				<input type="text" id="sBm1" style="width: 110px;"
					disabled="disabled" />
				<input type="button" id="sBm1b" value="..." onclick="yijisBmhth();" />
				&nbsp&nbsp 二级部门:
				<input type="text" id="sBm2" style="width: 108px;"
					disabled="disabled" />
				<input type="button" id="sBm2b" value="..." onclick="addsBmerhth();" />
				<br />
				<br />
				三级部门:
				<input type="text" id="sBm3" style="width: 110px;"
					disabled="disabled" />
				<input type="button" id="sBm3b" value="..."
					onclick="addsBmsanhth();" />
				&nbsp&nbsp 四级部门:
				<input type="text" id="sBm4" style="width: 108px;"
					disabled="disabled" />
				<input type="button" id="sBm4b" value="..." onclick="addsBmsihth();" />
				<br />
				<br />
				证件名称:
				<select id="cardtype" style="width: 124px;"></select>
				&nbsp&nbsp&nbsp 证件号码:
				<input type="text" id="txtcardid" name="txtcardid"
					style="width: 120px;" />
				<br />
				<br />
				联 系 人:
				<input type="text" id="txtlinkman" name="txtlinkman"
					style="width: 120px;" />
				&nbsp&nbsp&nbsp 联系电话:
				<input type="text" id="txtlinkphone" name="txtlinkphone"
					style="width: 120px;" />
				<br />
				<br />
			    端口信息:<input  class="textclass" id="route1" style="width: 120px;background: silver" type="text" jQuery1336556982046="116" readonly="true" value="未配置号线信息"/>
				<script>writespace(22)</script>
				<input onclick="equipRoute()" type="button" id="portbutten" value="修改号线信息" />
				<br />
				<br />
				营业区域:
				<input type="text" id="txtarea" name="txtarea"
					style="width: 320px; background: silver;" readonly="true" />
				<!-- &nbsp&nbsp&nbsp 用户区域: -->
				<input type="hidden" id="txtuserarea" style="width: 120px;" />
				<br />
				<br />
				资料备注:
				<input type="text" id="txtmemo" name="txtmemo" style="width: 320px;" />
				<br />
				<br />
				操作备注:
				<input type="text" id="workmemo" style="width: 320px;" />
			</div>
		</DIV>
		<input type="hidden" id="returnUserAcct" />
		<input type="hidden" id="IsLimitArea" />
		<select id="yhxz_hidden" style="display: none"></select>
		<input type="hidden" id="sbmcode" />
		<input type="hidden" id="sBm1code" />
		<input type="hidden" id="sBm2code" />
		<input type="hidden" id="sBm3code" />
		<input type="hidden" id="sBm4code" />
		<input type="hidden" id="bmtypekey" />
		<input type="hidden" id="sbmname" />
		<input type="hidden" id="jobid" />
		<input type="hidden" id="repfile" />
		<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
		<!-- 获得打印项目路径 -->
		<input type="hidden" id="userid" value="<%=sUserId%>" />
		<input type="hidden" id="imenuid" value="<%=imenuid%>" />
		<input type="hidden" id="zid" value="<%=zid%>" />
		<input type="hidden" id="languageType" value="<%=languageType%>" />
		<input type="hidden" id="modifyright" />
		<!-- 模糊查询结果div  -->
		<div class="neirong" id="divquery" style="width: 550px; display: none">
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
						<a href="javascript:;" onclick="setTimeout($.unblockUI,15);"><fmt:message
								key="global.close" />
							<!-- 关闭 -->
						</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd"
				style="background-color: #FFFFFF; text-align: left; height: 240px;">
				<div id="page"
					style="overflow-y: scroll; height: 100%; width: 100%;">
					<table border="1" cellpadding="0" bordercolor="#9AC0CD"
						id="tabqueryres" style="width: 530px;">
					</table>
				</div>
			</div>
			<div class="midd_butt" style="width: 540px; height: 38px;">
				<button id="hthChooseFormSave" onclick="setuserinfo();"
					class="tsdbutton" style="margin-left: 20px;">
					确定
				</button>
				<button id="hthChooseFormReset"
					onclick="javascript:setTimeout($.unblockUI,15);$('selectsbmkey').val('');"
					class="tsdbutton" style="margin-left: 20px;">
					取消
				</button>
				<button id="hthChooseFormsx"
					onclick="javascript:queryRadUser_like()" class="tsdbutton"
					style="margin-left: 20px;">
					刷新
				</button>
			</div>
		</div>
		<!-- 勾选业务费div  -->
		<div class="neirong" id="divbusifee"
			style="width: 300px; display: none">
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
						<a href="javascript:;" onclick="setTimeout($.unblockUI,15);"><fmt:message
								key="global.close" />
							<!-- 关闭 -->
						</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd"
				style="background-color: #FFFFFF; text-align: left; height: 130px;">
				<div id="page"
					style="overflow-y: scroll; height: 100%; width: 100%;">
					<table border="1" cellpadding="0" bordercolor="#9AC0CD"
						id="tabbusifee" style="width: 280px;">
						<tr
							style="line-height: 22px; font-weight: bold; text-align: center;">
							<td width='30px'>
								选择
							</td>
							<td>
								业务费名称
							</td>
							<td width='80px'>
								业务费金额
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="midd_butt" style="width: 290px; height: 38px;">
				<button id="hthChooseFormSave" onclick="caclbusifee();"
					class="tsdbutton" style="margin-left: 20px;">
					确定
				</button>
				<button id="hthChooseFormReset"
					onclick="javascript:setTimeout($.unblockUI,15);$('selectsbmkey').val('');"
					class="tsdbutton" style="margin-left: 20px;">
					取消
				</button>
			</div>
		</div>
		<!-- 选择部门div  -->
		<div class="neirong" id="querysBm" style="width: 450px; display: none">
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
						<a href="javascript:;" onclick="setTimeout($.unblockUI,15);"><fmt:message
								key="global.close" />
							<!-- 关闭 -->
						</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd"
				style="background-color: #FFFFFF; text-align: left; height: 260px;">
				<div id="broadband_frame">
					<div id="inputtext">
						<table id="xzhthselect" cellspacing="4">
							<tr>
								<td>
									查询类型
								</td>
								<td>
									<select id="querykeybm">
										<option value="1">
											条件查询
										</option>
										<option value="2">
											部门名称
										</option>
									</select>
								</td>
								<td>
									<input type="text" id="selectsbmkey" name="selecththcontent"
										style="width: 150px;" />
								</td>
								<td>
									<button class="tsdbutton" id="submitButton"
										style="line-height: 20px;" onclick="querykeysBm()">
										查找
									</button>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<table id="bytctabs" style="width: 433px;" border="1"
					cellpadding="0" bordercolor="#9AC0CD">
					<tr>
						<td>
							<center>
								部门名称
							</center>
						</td>
					</tr>
				</table>
				<div id="page" style="overflow-y: scroll; height: 200px;">
					<table border="1" cellpadding="0" bordercolor="#9AC0CD"
						id="querybmcontext" style="width: 433px;">
					</table>
				</div>
			</div>
			<div class="midd_butt" style="width: 440px; height: 38px;">
				<button id="hthChooseFormSave" onclick="savesBm();"
					class="tsdbutton" style="margin-left: 20px;">
					<!-- 确定 -->
					确定
				</button>
				<button id="hthChooseFormReset"
					onclick="javascript:setTimeout($.unblockUI,15);$('selectsbmkey').val('');"
					class="tsdbutton" style="margin-left: 20px;">
					关闭
					<!-- 关闭 -->
				</button>
			</div>
		</div>
		<!-- 弹出报表打印框 -->
		<div id="businessreprint"></div>
		<!-- 加载的文件在script/telephone/business/businessreprint.js -->
		<iframe id="printReportDirect"
			style="width: 120px; height: 0px; visibility: visible"
			src="print.jsp"></iframe>
	</body>
	</thml>