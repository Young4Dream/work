<%----------------------------------------
	name: rad_busi_Move.jsp
	author: wangli
	version: 1.0 
	description: 移机 
	Date: 2011-09-08
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
			initBusiFee();
			setEastWidth();			
			setPower();			
			$("#navBar").append(genNavv());			
			  $.ajax({
				url:"phone_querydate?func=query",
				async:true,//异步
				cache:false,
				timeout:20000,//1000表示1秒
				type:'post',
				success:function(xml,textStatus)
				{					
				    if (InvalidSessionPro(xml)) {return false};
				    var radacc = xml.substring(xml.indexOf("<radacc=")+8,xml.indexOf("radacc/>"));				    
					$("#radacc").html(radacc);
				}		
			});	
			
			 $("#txtywareaarea").empty();
			 var ywres = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&cloum=xuhao,ywarea&tablename=area_ywsl&key=1=1 order by ywarea");
			 if(ywres!=undefined&&ywres!=""){
				var ywstr="<option value=''>--请选择--</option>";
				for(var i=0;i<ywres.length;i++){		 		
					ywstr+="<option value='"+ywres[i][0]+"'>"+ywres[i][1]+"</option>"
				}
				$("#txtywareaarea").html(ywstr);
				//$("#ywarea_dz").val($("#YwArea_yhdang").val());
				getchangeywarea();
			 }else{
				$("#txtywareaarea").html("<option value=''>--is null--</option>");
			 }															
		});
		
		/*
	   *根据业务区域得到营业区域
	   */
	   function getchangeywarea(){
	   		$("#txtuserarea").empty();
	   		var ywarea_dz="";
	   		var str = $("#txtywareaarea").val();
	   		if(str==""||str==undefined){
	   			ywarea_dz=-1;
	   		}else{
	   			ywarea_dz=str;
	   		}
	   		var res = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&cloum=area&tablename=asys_area&key=ywareaid="+ywarea_dz);
		 	if(res!=undefined&&res!=""){
		 		var str="<option value=''>--请选择--</option>";
			 	for(var j=0;j<res.length;j++){
			 		str+="<option value='"+res[j][0]+"'>"+res[j][0]+"</option>"
			 	}
			 	$("#txtuserarea").html(str);
			 	//$("#area_dz").val($("#Bz3_yhdang").val());
		 	}else{
		 		$("#txtuserarea").html("<option value=''>--is null--</option>");
		 	}
	   }

		//取出用户的扩展权限，进行相应的权限控制(目前仅有手续费)
		function setPower(){
			var sPower = getUserPower("<%=sUserId%>","<%=sGroupid%>","<%=sMenuid%>");			
			//若为管理员权限，则可以编辑手续费项目
			if(sPower=='all@'){
				setReadonly($("#txtBussFee"), true);				
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
		}		
		//初始化业务费选择表格
		function initBusiFee(){
			var s="";  
			var res = getBussFee('move');			
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
			$("#txtBussFee").val(0); 			
			$("#radpayitem").val("cash");	
			$("#queryvalue").focus();
			$("#input-Unit :text").attr("readonly", true);  //使所有input控件只读
			$("#txtuseraddrnew").attr("readonly", false);   //用户新址可写
			$("#txtuseraddrnew").val("");			
			$("#workmemo").attr("readonly", false);         //操作备注可写
			$("#workmemo").val(""); 				
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
					$("#radpayitem").html(payitem);
					$("#radpayitem").val("cash");
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
			if (acctCheck("#txtacct", "移机")) {return};			
			if (limitArea($("#IsLimitArea").val(),$("#txtarea").val(), "<%=sArea%>")) {return};
			if (NullCheck("#txtuseraddrnew", "用户新址")) {return};
			if (NullCheck("#radpayitem", "付费方式")) {return};		
			if($("#txtywareaarea").val()==""){
				alert("请选择业务区域");
				$("#txtywareaarea").select().focus();
				return;
			}
			if($("#txtuserarea").val()==""){
				alert("请选择用户区域");
				$("#txtuserarea").select();
				$("#txtuserarea").focus();
				return;
			}			
			if (!confirm("您确定要对“"+$("#txtacct").val()+"”帐号进行移机操作吗？")){
				return;
			}
			savedb();
			reset();	
			clear();	
		}
        //调用宽带开户的后台存储过程
        function savedb(){  
        	//取出所有项目的值，若有可能包含中文的，都做下编码转换		
        	var v_acct = tsd.encodeURIComponent($("#txtacct").val());
        	var v_busifee = $("#txtBussFee").val();
        	var v_paytype = $("#radpayitem").val();
        	var v_newaddr = tsd.encodeURIComponent($("#txtuseraddrnew").val());
        	var v_workmemo = tsd.encodeURIComponent($("#workmemo").val());			
			var txtywareaarea = tsd.encodeURIComponent($("#txtywareaarea option:selected").text());
        	var pubParam = getPubProcParam(); 
         	var param=pubParam+"&internetacct="+v_acct+"&paytype="+v_paytype+"&busifee="+v_busifee+"&workmemo="+v_workmemo+"&newaddr="+v_newaddr+"&newarea="+tsd.encodeURIComponent($("#txtuserarea").val())+"&newywarea="+txtywareaarea;

        	var res = fetchMultiPValue_rad("rad_busi",6,param);        	      
        	if(res[0][0]=="SUCCEED"){
        		if (parseFloat($("#txtBussFee").val()) > 0){
        			$("#jobid").val(res[0][1]);
        			setRepFileField();
        			printworkorder('move');//业务类型，取自于tsd_ini(tsection='radbusi_busifee' and tident='move' )        			
        		}
        		else{	
        			alert("移机成功！\r\n\n点击“确定”按钮办理下一笔移机业务。");
        		}
        		
        	}else if(res[0][0]=="FAILED"){
        		if(res[0][1]!=""){
        			alert(res[0][1]);
        		}else{
        			alert("移机失败！请与系统管理员联系。");
        		}	
        	}     	
        }	
        function getPubProcParam(){
        	var busitype = "move";
        	var userid = tsd.encodeURIComponent("<%=sUserId%>");
        	var department = tsd.encodeURIComponent("<%=sDepart%>");
        	var busiarea = tsd.encodeURIComponent("<%=sArea%>");
          var busiywarea = tsd.encodeURIComponent("<%=ywarea%>");
        	return "&userid="+userid+"&busitype="+busitype+"&department="+department+"&busiarea="+busiarea+"&BusiFeeNames="+BusiFeeNames+"&BusiFeeValues="+BusiFeeValues+"&busiywarea="+busiywarea;;
        }	
		//重填按钮调用的函数
		function reset(){									
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
				$("#txtBussFee").val(totalfee);				   
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
			var res = fetchMultiArrayValue_rad('dbsql_rad.queryRadUser_equal',6,"&fieldname="+fieldname+"&fieldvalue="+tsd.encodeURIComponent(fieldvalue),'business');
			if (res != undefined && res!="" && res.length>0){
				setValue(res);	
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
				queryRadUser_equalReal('internetacct',$("#returnUserAcct").val());
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
			//验证当前用户是否欠费
			var res = fetchMultiPValue("rad_busi_payfee.rad_busi_dhvalid",6,"&internetacct="+arr[0][0]+"&dh="+arr[0][20]);
			if(res[0][0] == '0'){
				alert("该后付费用户已欠费,需与【"+arr[0][20]+"】电话一起交费！");
				initValue();
				return;
			}else if(res[0][0] == '2'){
				alert("该后付费用户已欠费,请先在宽带窗口结清费用！");
				initValue();
				return;
			}else if(res[0][0] == '3'){
				alert("该预付费用户已欠停,请先进行续费！");
				initValue();
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
        	$("#pkgid").val(arr[0][13]);           	
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
        	inLock("move",arr[0][0]);	
		}
		//输出指定个数的空格
		function writespace(count){
			var s = "";
			for (var i=1; i<=count; i++){
				s+="&nbsp;";
			}
			document.write(s);			
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
				<option value="internetacct">宽带账号</option>
			</select>
			<input type="text" id="queryvalue" style="width:162px;"/>
			<input  class="tsdbutton_rad" type="button" value="精确查询" onclick="queryRadUser_equal();"/>
			<input  class="tsdbutton_rad" type="button" value="模糊查询" onclick="popupQueryPanel();"/>
		</div>
	</DIV> 
	<DIV class="ui-layout-south">		
		<div style="margin-top:-5px; margin-bottom:-7px">
			<button class="tsdbutton" id="btnSave" onclick="save();" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;" > 
				确认移机 
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
			宽带账号:<input type="text" id="txtacct" name="txtacct" style="width:162px;"/><script>writespace(22)</script> <br /><br />
			用户名称:<input type="text" id="txtusername" name="txtusername" style="width:162px;"/><script>writespace(22)</script> <br /><br />						
			用户类别:<input type="text" id="usertype" style="width:90px;"/> &nbsp
			用户性质:<input type="text" id="userattr" style="width:90px;"/> <br /><br />
			住宅电话:<input type="text" id="txtdh" name="txtdh" style="width:162px;"/><script>writespace(22)</script> <br /><br />										
			上网套餐:<input type="text" id="pkgid" style="width:254px;"/> <br /><br />
			<div style="background:#F5DEB3;">
				接入类型:<select id="radacc" style="width: 254px;"></select><br/><br/>
				用户原址:<input type="text" id="txtuseraddr" name="txtuseraddr" style="width:254px;"/> <br /><br />
				用户新址:<input type="text" id="txtuseraddrnew"  style="width:249px;"/><font color="red">*</font> <br /><br />
				操作备注:<input type="text" id="workmemo" style="width:254px;"/> <br /><br />
				付费方式:<select id="radpayitem" style="width: 90px;" ></select><font color="red">*</font> &nbsp		
				<font style="color:red;">业 务 费:</font><input type="text" id="txtBussFee" style="width:90px; background:silver;" readonly="true"
				onkeypress="numValid(this)"  
				onpaste="return !clipboardData.getData('text').match(/\D/)"/><input type="button" value="..." onclick="setbusifee();"/>				
			</div>											
		</div>								
	</DIV> 
	<DIV class="ui-layout-east">
		<div id="input-Unit" style="margin-top:-10px">
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
						<div style="background:#F5DEB3;">					
			业务区域:<select id="txtywareaarea" style="width:120px;" onchange="getchangeywarea()"/> &nbsp&nbsp	
			<!-- 
			用户区域:<input type="text" id="txtuserarea" style="width:120px;"/> <br /><br />
			 -->
			用户区域:<select id="txtuserarea" style="width:120px;"></select>		
			</div> <br /><br />
			备  注:&nbsp&nbsp&nbsp&nbsp<input type="text" id="txtmemo" name="txtmemo" style="width:317px;"/>			
		</div>		 
	</DIV>		
	<input type="hidden" id="returnUserAcct"/>
	<input type="hidden" id="IsLimitArea"/>
	<input type="hidden" id="jobid"/>
	<input type="hidden" id="repfile"/>
	<input type="hidden" id="ywarea" value="<%=ywarea %>"/>
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
	<!-- 弹出报表打印框 -->	
	<div id="businessreprint"></div><!-- 加载的文件在script/telephone/business/businessreprint.js -->  
	<iframe id="printReportDirect"  style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>	
</body>
</thml>