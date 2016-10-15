<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/hthchangehousehold.jsp
    Function:   合同号过户
    Author:     wenxuming
    Date:       2011-02-27
    Description: 
    Modify: 
    2011.02.27：创建此页面，进行开发
-----------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
	/////////////////Java取当前时间
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
	SimpleDateFormat formatto = new SimpleDateFormat("yyyy-MM-dd");
	Date now = new Date();
	String nowTime = format.format(now);
	String nowTimeto = formatto.format(now);
%>
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
		<title>合同号过户</title>
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
		<script src="script/public/phoneservice.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservicenew.js" type="text/javascript" language="javascript"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->		
		<script src="script/telephone/business/businesspublic.js" type="text/javascript" language="javascript"></script>
		<!-- 打印报表弹出窗口 -->
		<script src="script/telephone/business/businessreprint.js" type="text/javascript" language="javascript"></script>	
		<!-- 获取数据 -->
		<script src="script/telephone/business/phone_kjbq_gh.js" type="text/javascript" language="javascript"></script>		
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
		<script src="script/telephone/business/phoneInstalled.js" type="text/javascript"></script>	
		<!--设置全局字体大小-->
		<link href="style/css/telephone/business/fontsize_all.css" rel="stylesheet" type="text/css"/>
   	  <script type="text/javascript">
       jQuery(document).ready(function()
	   {	    
		    $("#navBar").append(genNavv());
		    geththediteold();//加载显示框
		    ghPayMoney('p_hthchangename');//根据hth过户标识查询一次性费用		
		    gethide("p_hthchangename");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数       
		    $("#hthkey").select();
		    $("#hthkey").focus();
		    $("#tablehthdang_old select").attr("disabled","disabled");
			$("#tablehthdang_old :text").attr("disabled","disabled");
			$("#tablehthdang_new select").attr("disabled","disabled");
			$("#tablehthdang_new :text").attr("disabled","disabled");
			getfufeitype();//付费类型script/telephone/business/phone_kjbq_gh.js
		    getinternetedit('p_hthchangename');//加载页面下拉框			    
			$("#usertype").change(function(){
				if($("#usertype").val()!=""){
				 	$('#Yhlb_hthdang').val($('#usertype option:selected').text());
				}else{
					 $('#Yhlb_hthdang').val("");
					 $("#Yhxz_hthdang").empty();
				}
				
				var res = fetchSingleValue("dbsql_phone.querytabledate",6,"&tablename=tsd_ini&cloum=tvalues&key=tident='setShows' and tsection='phonebusiness'"); 										
				var arrayRes="";
				var arrayShow="";
				if(res!=""&&res!=undefined){
					arrayRes=res.split('|');
					for(var i=0;i<arrayRes.length;i++){
						arrayShow=arrayRes[i].split(':');
						if(arrayShow[1]=="false"){
							$("#"+arrayShow[0]+"").hide();
						}else{
							$("#"+arrayShow[0]+"").show();
						}
						
					}				
				}

			});
			var res = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=TVALUES&tablename=tsd_ini&key=to_number(to_char(sysdate,'DD'))<=TVALUES and tsection='phonebusiness' and TIDENT='czytime'");
			if(res!=""&&res!=undefined){
				res = parseInt(res,10)+1;
				//alert("未出帐月不能办理该业务，请等到本月"+res+"号之后在来办理！");
				alert("<fmt:message key="phone.getinternet0265" />"+res+"<fmt:message key="phone.getinternet0266" />");
			}
	   });
	   
	   /********
        *生成付费类型下拉框
        *@param;
       	*@return;
        ********/
        function getfufeitype()
        {
           $("#cPayType").empty();
           var querysel='';
		   var res = fetchMultiArrayValue("dbsql_phone.queryphoneconfigkemu",6,"&kemu=pbusinessfee&tsection=payitem");
				if(res[0]==undefined || res[0][0]==undefined)
        		{
        			return false;
        		}
        	for(var i=0;i<res.length;i++){
        		querysel+="<option value="+res[i][0]+">"+res[i][1]+"</option>";
        	}
		   $("#cPayType").html(querysel);
		   $("#cPayType").val("tuoshou");
        }
	   	  
		/*******
	   	* 点击保存拼接参数执行过程合同号过户操作
	   	* @param;
	   	* @return;
	  	********/
		function updateGH()
		{
			//每次拼接参数必须初始化此参数
			tsd.QualifiedVal=true;
		 	var params='';
		 	var hthold = $("#Hth_hth").val();//旧合同号
		 	if(hthold==""){
		 		//alert("请查询一个合同号账户！");
		 		alert("<fmt:message key="phone.getinternet0267" />");
		 		$("#hthkey").select();
		 		$("#hthkey").focus();
		 		return false;
		 	}
		 	var languageType = $("#languageType").val(); 
		    var Dat = loadData_phoneinstalled("Hthdang",languageType,2);
		    var reszh = fetchFieldAlias('Hthdang',languageType);			 
			 for(var i=0;i<Dat.FieldName.length;i++){
			 	var strhth = $("#"+Dat.FieldName[i]+"_hthdang").val();
			 	if(strhth!=undefined){
			 		strhth = strhth.replace(/(^\s*)|(\s*$)/g,"");
			        	if(strhth==""&&Judgefield_hthdang(Dat.FieldName[i]+"_hthdang")==true&&$("#"+Dat.FieldName[i]+"_hthdang").attr("disabled")!=true)
			        	{
			        		alert("<fmt:message key="phone.getinternet0026" />"+reszh[Dat.FieldName[i]]+"<fmt:message key="phone.getinternet0027" />");
			        		$("#"+Dat.FieldName[i]+"_hthdang").select();
			        		$("#"+Dat.FieldName[i]+"_hthdang").focus();
			        		return false;
			        		break;
			        	}
		        	}
		        if(strhth==null){strhth="";}
			 	params += "&"+Dat.FieldName[i]+"hth="+tsd.encodeURIComponent(strhth);
			 }
			     var Email = $("#Email_hthdang").val();//邮件地址  
					if(Email!=undefined){
			        	Email=Email.replace(/(^\s*)|(\s*$)/g,"");	
						var emailRegExp = new RegExp("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
						if ((!emailRegExp.test(Email)||Email.indexOf('.')==-1)&&Email!=""&&$("#Email_hthdang").attr("disabled")!=true){
							alert("<fmt:message key="phone.getinternet0029" />");
							$("#Email_hthdang").select();
							$("#Email_hthdang").focus();
							return false;
						}
					}	
					var IDCard = $("#IDCard_hthdang").val();		        	
		        	if(IDCard!=undefined){
			        	IDCard=IDCard.replace(/(^\s*)|(\s*$)/g,"");
			        	if($("#IDCard_hthdang").attr("disabled")!=true&&IDCard!=""&&!/((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65)[0-9]{4})(([1|2][0-9]{3}[0|1][0-9][0-3][0-9][0-9]{3}[X0-9])|([0-9]{2}[0|1][0-9][0-3][0-9][0-9]{3}))$/.test(IDCard))
		        		{
			        		alert("<fmt:message key="phone.getinternet0030" />");
			        		$("#IDCard_hthdang").select();
			        		$("#IDCard_hthdang").focus();
			        		return false;
		        		}
		        	}
		        	
		        	//合同号一级部门
		        	var chthbm1 = $("#sBm1").val();
		        	/*
		        	var resgfhth = fetchSingleValue("dbsql_phone.queryhthdanghth",6,"&hth="+tsd.encodeURIComponent($("#Hth_hthdang").val()));
							if(resgfhth==undefined||resgfhth=='0')
							{
					        	//if($("#usertype option:selected").text()=="公费"&&$("#sBm1").val()=="")
					        	if($("#usertype option:selected").text()=="<fmt:message key="phone.getinternet0384" />"&&$("#sBm1").val()=="")
					        	{
					        		alert("<fmt:message key="phone.getinternet0028" />");
					        		$("#sBm1").select();
					        		$("#sBm1").focus();
					        		return false;
					        	}
				      }
		        	*/
		        	params += "&chthbm1=";
		        	params += tsd.encodeURIComponent(chthbm1);
		        	//合同号二级部门        	
		        	var chthbm2 = $("#sBm2").val();
		        	params += "&chthbm2=";
					params += tsd.encodeURIComponent(chthbm2);
					//合同号三级部门        	
		        	var chthbm3 = $("#sBm3").val();
		        	params += "&chthbm3=";
					params += tsd.encodeURIComponent(chthbm3);
					//合同号二级部门        	
		        	var chthbm4 = $("#sBm4").val();
		        	params += "&chthbm4=";
					params += tsd.encodeURIComponent(chthbm4);
			//获取参数			
			//区域
			var area = $("#area").val();
			var userareaid = $("#userareaid").val();
			//部门
			var depart = $("#depart").val();
			//工号
			var userid = $("#userid").val();
			//付费方式
			var cPayType = $("#cPayType").val();				
			//应缴费
			var cYingJiao = $("#cYingJiao").val().replace(/(^\s*)|(\s*$)/g,"");
			if(cYingJiao==""){cYingJiao=0;}
			//实缴费
			/*
			var cShiShou = $("#cShiShou").val().replace(/(^\s*)|(\s*$)/g,"");
			if(cShiShou==""){cShiShou=0;}*/
			//费用项目
			var cPayItem = $("#cPayItem").val();
			cYingJiao = parseFloat(cYingJiao,10);
			//cShiShou = parseFloat(cShiShou,10);	
			if(cYingJiao==0){cPayItem="";}
			//if(cYingJiao!=0&&cShiShou==0){alert("请输入实缴费用！");$("#cShiShou").select();$("#cShiShou").focus();return false;}		
			//备注
			var phonepkBz = $("#phonepkBz").val().replace(/(^\s*)|(\s*$)/g,"");
			params+="&hthold="+tsd.encodeURIComponent(hthold);
			params+="&Area="+tsd.encodeURIComponent(area);
			params+="&userarea="+tsd.encodeURIComponent(userareaid);
			params+="&Depart="+tsd.encodeURIComponent(depart);
			params+="&UserID="+tsd.encodeURIComponent(userid);
			params+="&ispay="+tsd.encodeURIComponent(cPayType);
			params+="&yjfee="+tsd.encodeURIComponent(cYingJiao);			
			//params+="&sjfee="+tsd.encodeURIComponent(cShiShou);
			params+="&feename="+tsd.encodeURIComponent(cPayItem);
			params+="&zwbz="+tsd.encodeURIComponent(phonepkBz);
		 	
		 	var loginfo = "<fmt:message key="phone.getinternet0397" />:";//"合同号过户:";
			loginfo += "<fmt:message key="phone.getinternet0398" />:";//"原合同号:";
			loginfo += $("#Hth_hth").val();
			loginfo += "<fmt:message key="phone.getinternet0399" />:";//";新合同号:";
			loginfo += $("#Hth_hthdang").val();
			loginfo += "<fmt:message key="phone.getinternet0381" />:";//";业务区域:";			
			loginfo += area;
			loginfo += ";<fmt:message key="phone.getinternet0396" />:"; //受理人
			loginfo += userid;
			loginfo = tsd.encodeURIComponent(loginfo);
			params+="&ywbz="+loginfo;
	 		//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}						
			var result = fetchMultiPValue("PhoneService.hthgh",6,params);
			if(result[0]==undefined || result[0][0]==undefined || result[0][0]=='-1')
			{
				//alert("办理合同号过户业务失败");
				alert("<fmt:message key="phone.getinternet0268" />");
			}
			else
			{
				$("#jobidid").val(result[0][0]);
				$("#ppaytype").val(cPayType);
				$("#fee").val(cYingJiao);
				writeLogInfo("","modify",loginfo);
				$("#hthkey").select();
			    $("#hthkey").focus();
				//判断是否打印工单，从tsd_ini表中配置Y为打印
				printworkorder('p_hthchangename');//script/telephone/business/businessreprint.js中
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
			$("#tablehthdang_old :text").val("");
        	$("#tablehthdang_old select").val("");
        	$("#tablehthdang_new :text").val("");
        	$("#tablehthdang_new select").val("");
			//业务备注框
			$("#phonepkBz").val("");
			$("#cPayType").val("cash");	
			unLockDh();//清除锁定
			//yijisBm();
			$("#hth").val("");
			$("#usertype").val("");
			refreshbusinessfee();
			ghPayMoney('p_hthchangename');//根据hth过户标识查询一次性费用		
		    gethide("p_hthchangename");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数 
			$("#tablehthdang_new select").attr("disabled","disabled");
			$("#tablehthdang_new :text").attr("disabled","disabled");
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
	   }
        
		function setBz2(){
			if($("#sBm2").val()!=""){
					$("#Bz2_hthdang").val('Y');	//默认大客户代收为是
					$("#Bz2_hthdang").removeAttr("disabled");
				}else{
					$("#Bz2_hthdang").val('N');	//默认大客户代收为否
					$("#Bz2_hthdang").attr("disabled","disabled");
				}
				var Bz2right = $("#Bz2right").val();
					if(Bz2right=='true'){
						$("#Bz2_hthdang").removeAttr("disabled");
					}	
		}
		
		
		/**********
       *合同号可编辑情况       
       ***********/
       //全局变量arraybtfield 自动加载取出必选项放到该数组中，提交的时候判断哪些为必选；
       var arraybtfield = [];
       function geththediteold(){
       	//合同号信息       	  
       	  var languageType = $("#languageType").val();
          var resg = fetchFieldAlias('Hthdang',languageType);                   
          var str = getFields("Hthdang");
          var Dat = loadData_phoneinstalled("Hthdang","zh",2);
          //合同号信息      
	        $.ajax({
					url:"phone_querydate?func=query",
					async:true,//异步
					cache:false,
					timeout:20000,//1000表示1秒
					type:'post',
					success:function(xml,textStatus)
					{  
						//取缴费方式 返回的是html格式
					    var syhlb = xml.substring(xml.indexOf("<yhlb=")+6,xml.indexOf("yhlb/>"));
					    var sdhlx = xml.substring(xml.indexOf("<dhlx=")+6,xml.indexOf("dhlx/>"));
					    var CallPayType = xml.substring(xml.indexOf("<CallPayType=")+13,xml.indexOf("CallPayType/>"));
					    var ZnjBz = xml.substring(xml.indexOf("<znjbz=")+7,xml.indexOf("znjbz/>"));
					    var Area = xml.substring(xml.indexOf("<asys_area=")+11,xml.indexOf("asys_area/>"));
					    var CustType = xml.substring(xml.indexOf("<custtype=")+10,xml.indexOf("custtype/>"));
					    var yhxz = xml.substring(xml.indexOf("<yhxz=")+6,xml.indexOf("yhxz/>"));
					    var tablehthdang = xml.substring(xml.indexOf("<hthdang=")+9,xml.indexOf("hthdang/>"));
					    var tableyhdang = xml.substring(xml.indexOf("<yhdang=")+8,xml.indexOf("yhdang/>"));
					    var AdjustSheduleNo = xml.substring(xml.indexOf("<AdjustSheduleNo=")+17,xml.indexOf("AdjustSheduleNo/>"));
					    var CallSheduleNo = xml.substring(xml.indexOf("<CallSheduleNo=")+15,xml.indexOf("CallSheduleNo/>"));
					    var dhgn = xml.substring(xml.indexOf("<dhgn=")+6,xml.indexOf("dhgn/>"));
					    var ywarea = xml.substring(xml.indexOf("<ywarea=")+8,xml.indexOf("ywarea/>"));
					    var idtype = xml.substring(xml.indexOf("<idtype=")+8,xml.indexOf("idtype/>"));
					    var ghfeetype = xml.substring(xml.indexOf("<gdfeetype=")+11,xml.indexOf("gdfeetype/>"));
					    var bytcfeetype = xml.substring(xml.indexOf("<bytcfeetype=")+13,xml.indexOf("bytcfeetype/>"));
					    var yhlb_text = xml.substring(xml.indexOf("<yhlb_text=")+11,xml.indexOf("yhlb_text/>"));
					    $("#tablehthdang_new").html(tablehthdang);
					    //$("#tableyhdang").html(tableyhdang);
					    $("#CallPayType_hthdang").html(CallPayType);
					    $("#CallPayType_hthdang").html(CallPayType);		
					    $("#ZnjBz_hthdang").html(ZnjBz);
					    $("#Area_hthdang").html(Area);
						$("#CustType_hthdang").html(CustType);
						$("#Yhxz_hthdang").html(yhxz);
						$("#yhxz_hidden").html(yhxz);
						$("#Yhlb_hthdang").html(yhlb_text);
						//$("#Bz2_hthdang").html($("#Bz2_hthdang").html()+"<option value='N' selected='true'>否</option>"+"<option value='Y'>是</option>");
						$("#Bz2_hthdang").html($("#Bz2_hthdang").html()+"<option value='N' selected='true'><fmt:message key="phone.getinternet0355" /></option>"+"<option value='Y'><fmt:message key="phone.getinternet0354" /></option>");
					}
				});   	        
        	var languageType = $("#languageType").val(); 
			 //合同号信息   
	          var tablehthdang="<tr>";
	        		var j=0;
	        		for(var i=0;i<Dat.FieldName.length;i++){
	        			var str = resg[Dat.FieldName[i]];    				
	        					tablehthdang +="<td class='wenzi'>"+str+"</td>";
	        					tablehthdang +="<td class='wenzix'><input name="+Dat.FieldName[i]+"_hth"+" id="+Dat.FieldName[i]+"_hth"+"  style='width: 150px;'/></td>";        					
	        				j++;
	        			if(j==3){
	        				tablehthdang +="</tr><tr>";
	        				j=0;
	        			}
	        		}
	        	tablehthdang+="</tr>";
	        	$("#tablehthdang_old").append(tablehthdang);
	      var res = fetchFieldAlias('Hthdang',languageType);
	      $("#spanhth").text(res['Hth']);//合同号
		  $("#spanBm1").text(res['Bm1']);//一级部门
		  $("#spanBm2").text(res['Bm2']);//二级部门
		  $("#spanBm3").text(res['Bm3']);//三级部门
		  $("#spanBm4").text(res['Bm4']);//四级部门 
		  var reshfadd = fetchFieldAlias('Hthhfadd',languageType);
          $("#spanxinyueHF").text(reshfadd['HfAdd']);//新月话费
          $("#spanyucunYE").text(reshfadd['HfMax']);//预存余额 
       }  
       
       function getUserProper_kjbq_gh(key){
       		$("#Yhlb_hthdang").attr("disabled","disabled");
       		var select = document.getElementById("yhxz_hidden");
				var array;
				$("#Yhxz_hthdang").empty();
				$("#Yhxz_hthdang").html($("#Yhxz_hthdang").html()+"<option value='' selected='true'>--<fmt:message key="phone.getinternet0365" />--</option>");			
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
	  						if(array[2]==key){
	  							$("#Yhxz_hthdang").html($("#Yhxz_hthdang").html()+"<option value="+array[0]+">"+array[0]+"</option>");	  							
	  						}
	  					}
	  				}
				}
       }
        
        /*****
        *合同号帐号查询
        ******/
        function queryhth(){
        	var res = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=TVALUES&tablename=tsd_ini&key=to_number(to_char(sysdate,'DD'))<=TVALUES and tsection='phonebusiness' and TIDENT='czytime'");
			if(res!=""&&res!=undefined){
				res = parseInt(res,10)+1;
				//alert("未出帐月不能办理该业务，请等到本月"+res+"号之后在来办理！");
				alert("<fmt:message key="phone.getinternet0265" />"+res+"<fmt:message key="phone.getinternet0266" />");
				return;
			}
        	var Hth = $("#hthkey").val().replace(/(^\s*)|(\s*$)/g,"");
        	if(Hth==""){
        		$("#hthkey").select();
        		$("#hthkey").focus();
        		//alert("请输入查询合同号帐号！");
        		alert("<fmt:message key="phone.getinternet0270" />");        		
        		return false;
        	}
        	var result = fetchMultiPValue("PhoneDH.ifCanSouLi",6,"&OperID=" + tsd.encodeURIComponent($("#userid").val()) + "&Ywlx="+tsd.encodeURIComponent("p_hthchangename")+"&NowYwArea="+tsd.encodeURIComponent($("#area").val())+"&Hth="+Hth);
			if(result[0]!=undefined && result[0][0]!="")
			{
				alert(result[0][1]);
				return;
			}
        	var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xmlattr',//返回数据格式 
									tsdpk:'PhonemoveAddress.dhBasicInfoHthdang'
									});
			var params = "&Hth=" + Hth;
				$.ajax({
				url:"mainServlet.html?"+urlstr+params,
				cache:false,
				success:function(xml){
					$(xml).find("row").each(function(){
						if($(this).attr("hth")==""||$(this).attr("hth")==undefined){
							//alert("没有查询结果！");
							alert("<fmt:message key="phone.getinternet0271" />");
							return false;
						}
						$("#Hth_hth").val($(this).attr("hth")==undefined?"":$(this).attr("hth"));
						ghSerBasicInfoHthHf($(this).attr("hth"));
						$("#Dh_hth").val($(this).attr("dh")==undefined?"":$(this).attr("dh"));
						$("#Yhmc_hth").val($(this).attr("yhmc")==undefined?"":$(this).attr("yhmc"));
						//用户类型
						$("#Yhlb_hth").val($(this).attr("yhlb")==undefined?"":$(this).attr("yhlb"));
						//用户性质
						$("#Yhxz_hth").val($(this).attr("yhxz")==undefined?"":$(this).attr("yhxz"));
						//付费策略						
						$("#CallPayType_hth").val($(this).attr("callpaytype")==undefined?"":getdatevalue("&cloum=typename&tablename=CallPayType&key=callpaytype="+$(this).attr('callpaytype')));
						//收费地点
						$("#Area_hth").val($(this).attr("area")==undefined?"":$(this).attr("area"));
						//滞纳金标志
						$("#ZnjBz_hth").val($(this).attr("znjbz")==undefined?"":getdatevalue("&cloum=bz&tablename=znjbz&key=znjbz="+$(this).attr("znjbz")));
						$("#Bz2_hth").val($(this).attr("bz2")==undefined?"":$(this).attr("bz2")=="Y"?"<fmt:message key="phone.getinternet0354" />":"<fmt:message key="phone.getinternet0355" />");//是否大客户代收
						//补贴类别
						//$("#HthMfjb_hth").val(geththvalue($(this).attr("hthmfjb"))==undefined?"":geththvalue($(this).attr("hthmfjb")));					
						$("#Bm1_hth").val($(this).attr("bm1")==undefined?"":$(this).attr("bm1"));
						$("#Bm2_hth").val($(this).attr("bm2")==undefined?"":$(this).attr("bm2"));
						$("#Bm3_hth").val($(this).attr("bm3")==undefined?"":$(this).attr("bm3"));
						$("#Bm4_hth").val($(this).attr("bm4")==undefined?"":$(this).attr("bm4"));
						$("#IDCard_hth").val($(this).attr("idcard")==undefined?"":$(this).attr("idcard"));					
						//$("#Boss_Name_hth").val($(this).attr("boss_name")==undefined?"":$(this).attr("boss_name"));//法人代表		
						//$("#CompType_hth").val(getcomptypevalue($(this).attr("comptype"))==undefined?"":getcomptypevalue($(this).attr("comptype")));//单位类型
						//$("#CreditGrade_hth").val($(this).attr("creditgrade")==undefined?"":$(this).attr("creditgrade"));//信誉等级	
						$("#CreditPoint_hth").val($(this).attr("creditpoint")==undefined?"":$(this).attr("creditpoint"));//信誉积分
						$("#CustType_hth").val($(this).attr("custtype")==undefined?"":getdatevalue("&cloum=custtype&tablename=custtype&key=custid=2"));//客户类型
						//$("#Email_hth").val($(this).attr("email")==undefined?"":$(this).attr("email"));//邮件地址	
						//$("#FixCode_hth").val($(this).attr("fixcode")==undefined?"":$(this).attr("fixcode"));//传真	
						//$("#HomePage_hth").val($(this).attr("homepage")==undefined?"":$(this).attr("homepage"));//主页
						//$("#linkTel_hth").val($(this).attr("linktel")==undefined?"":$(this).attr("linktel"));//联系电话			
						//$("#Manageid_hth").val($(this).attr("manageid")==undefined?"":$(this).attr("manageid"));//营业执照
						//$("#TradeType_hth").val(gettradetypevalue($(this).attr("tradetype"))==undefined?"":gettradetypevalue($(this).attr("tradetype")));//行业类型
						$("#Yhdz_hth").val($(this).attr("yhdz")==undefined?"":$(this).attr("yhdz"));//用户地址
			 	        //$("#Bz2").val($(this).attr("bz2")==undefined?"":$(this).attr("bz2")=="Y"?"是":"否");//是否大客户代收
			 	        setTimeout("gethffee()",500);
						$("#tablehthdang_new :text").val("");
			        	$("#tablehthdang_new select").val("");
						$("#tablehthdang_new select").attr("disabled","disabled");
						$("#tablehthdang_new :text").attr("disabled","disabled");
					});
				  }
			  });
        }
        
        //判断用户费用
		function gethffee(){
			var hffee = $("#phoneBalance").val().replace(/(^\s*)|(\s*$)/g,"");				
			hffee = parseFloat(hffee,10);
			var czyfee = $("#czyfee").val();
			if(czyfee=="NO"){
				//alert("该账号已欠费"+hffee+"元，请结清费用！");
				alert("<fmt:message key="phone.getinternet0272" />"+hffee+"<fmt:message key="phone.getinternet0273" />");
			}else if(czyfee=="YES"){
				var yefeevalue = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=count(1) as cont&tablename=yhdang&key=hth='"+$("#Hth_hth").val()+"'");
				if(yefeevalue=="1"&&$("#Yhlb_hth").val()!="<fmt:message key="phone.getinternet0384" />"){
					//alert("该账号有余额"+hffee+"元，请退费处理！");
					alert("<fmt:message key="phone.getinternet0274" />"+hffee+"<fmt:message key="phone.getinternet0275" />");
				}
			}
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
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0178" /><!-- 输入查询条件 -->
				</div>
				<div id="inputtext">
					<table id="kdBar" style="margin-left: 10px;" cellspacing="10px">
						<tr>
							<td>
								<fmt:message key="phone.getinternet0276" /><!-- 合同号账户 -->
							</td>
							<td>
								<input type="text" class="" id="hthkey" name="hthkey" />
							</td>
							<td>
								<button class="tsdbutton" id="submitButton" onClick="queryhth()" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
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
					 <div id="changehouse">
					   <table cellspacing="4" id="geththsbm" style="display:none;">
						<tr>
						<td>&nbsp;&nbsp;<span id="spanBm1"></span></td>
						<td><input type="text" id="sBm1" style="width:180px;" disabled="disabled"/><font color="red"><span id="bixuantype"></span></font>
						<input type="hidden" id="sBm1code" style="width:150px;" disabled="disabled"/>
						</td>
						<td>
						<button class="tsdbutton" id="setHth" 
						onclick="yijisBmhth();" style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
						<fmt:message key="phone.getinternet0075" /><!-- 选择 -->
						</button>
						</td>
						<td><span id="spanBm2"></span></td>
						<td><input type="text" id="sBm2" style="width:180px;" disabled="disabled"/>
						<input type="hidden" id="sBm2code" style="width:150px;" disabled="disabled"/>
						</td>
						<td>
						<button class="tsdbutton" id="setHth" 
						onclick="addsBmerhth();" style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
						<fmt:message key="phone.getinternet0075" /><!-- 选择 -->
						</button>
						</td>
						</tr>
						<tr>
						<td>&nbsp;&nbsp;<span id="spanBm3"></span></td>
						<td><input type="text" id="sBm3" style="width:180px;" disabled="disabled"/>
						<input type="hidden" id="sBm3code" style="width:150px;" disabled="disabled"/>
						</td>
						<td>
						<button class="tsdbutton" id="setHth" 
						onclick="addsBmsanhth();" style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
						<fmt:message key="phone.getinternet0075" /><!-- 选择 -->
						</button>
						</td>
						<td><span id="spanBm4"></span></td>
						<td><input type="text" id="sBm4" style="width:180px;" disabled="disabled"/>
						<input type="hidden" id="sBm4code" style="width:150px;" disabled="disabled"/>
						</td>
						<td>
						<button class="tsdbutton" id="setHth" 
						onclick="addsBmsihth();" style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
						<fmt:message key="phone.getinternet0075" /><!-- 选择 -->
						</button>
						</td>
						</tr>
						</table>
					<table cellspacing="4">
						<tr>
							<td>&nbsp;
								<fmt:message key="phone.getinternet0074" /><!-- 用户类别 -->&nbsp;&nbsp;
							</td>							
							<td><select id="usertype" style="width:130px;" onChange="javascript:$('#hth').val('');$('#Hth').val('');getUserProper_kjbq_gh($('#usertype').val());$('#geththsbm select').removeAttr('disabled');$('#sBm1').val('');$('#sBm2').val('');$('#sBm3').val('');$('#sBm4').val('');"></select></td>
							<td>
								<fmt:message key="phone.getinternet0277" /><!-- 新 --><span id="spanhth"></span>
								<!-- 合同号 -->
							</td>
							<td>
								<input type="text" name="hth" id="hth" style="width: 150"
									disabled="disabled" />
								<input type="hidden" name="gfhth" id="gfhth" />
							</td>
							<td>
								<button class="tsdbutton" id="setHth" 
									onclick="GenerateHth('p_hthchangename');" 
									style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
									<fmt:message key="phone.getinternet0077" /><!-- 生成合同号 -->
								</button>
							</td>
							<td>
								<button class="tsdbutton" id="setHth" 
									onclick="InputHth();" 
									style="height: 28px;width:70px; margin-top: 3px; padding: 0px;display:none;">
									<fmt:message key="phone.getinternet0078" /><!-- 输入合同号 -->
								</button>
							</td>
							<td>
								<button class="tsdbutton" id="setselectHth" 
									onclick="selecthth('1')" 
									style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
									<fmt:message key="phone.getinternet0079" /><!-- 选择合同号 -->	
								</button>
							</td>						
						</tr>	
					</table>
				  </div>	
				</div>
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0278" /><!-- 话费信息 -->	
				</div>
				<div id="inputtext">
				<br>
				<table>
					<tr>
						<td class="wenzi">
							<span id="spanyucunYE"></span>
							<!--出帐月余额/出帐月欠费 -->
							</td>
							<td>
							<input type="text" id="phoneBalance" name="phoneBalance"
								value="0" style="width: 150" disabled="disabled" />
							</td>
							<td class="wenzi">
							<span id="spanxinyueHF"></span>
							<!-- 实施余额/实施欠费 -->
							</td>
							<td>
								<input type="text" id="mothshuafei" name="mothshuafei"
									value="0" style="width: 150" disabled="disabled" />
							</td>
					</tr>	
				</table>
				</div>
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0277" /><!-- 新--><fmt:message key="phone.getinternet0182" /><!-- 合同号信息显示-->&nbsp;<input type="checkbox" id="hthshowcheck_new" checked="checked" onClick="getshow()" style="width:15px;" />
				</div>
				<div id="inputtext">
						<div class="midd">
							<table id="tablehthdang_new" style="width:780px;">
							</table>
						</div>
				</div>
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0279" /><!-- 原合同号信息显示-->&nbsp;<input type="checkbox" id="hthshowcheck_old" checked="checked" onClick="getshow()" style="width:15px;" />
					</div>
					<div id="inputtext">
						<div class="midd">
							<table id="tablehthdang_old" style="width:780px;">								
							</table>
						</div>
					</div>						
				<div class="title">
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
									<div style="width:440px; height: 105px; overflow-y: scroll; overflow-x: hidden; border-top: 1px solid gray; border-left: 1px solid gray;">
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
		<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
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
		<input type="hidden" id="TrafficLevel_to"/>
		<input type="hidden" id="yjfeehidden"/><!-- 页面获取应缴费存入隐藏于中 -->
		<input type="hidden" id="bmtypekey"/><!-- 部门编号 -->		
		<input type="hidden" id="sbmcode"/><!-- 部门编号 -->
		<input type="hidden" id="sbmname"/><!-- 部门名称 -->
		<input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->
		<input type="hidden" id="fufeitypepath"/>
		<input type="hidden" id='selbz'/><!-- 电话站标识 -->
		<input type="hidden" id="mokuaiju"/><!-- 电话模块局 -->
		<input type="hidden" id="selecththvaluekey"/><!-- 单击得到选择合同号信息放到隐藏域等待获取 -->
		<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->	
		<input type="hidden" id="stiffbusinestype" value="phoneXGGN"/><!-- 电话工单打印类型 -->
		<input type="hidden" id="Prefeeval"/><!-- 预测金额打印票据时判断 -->
		<input type="hidden" id="Bz2right"/><!-- 一级部门是否代收 -->
		<input type="hidden" id="czyfee"/><!-- 判断是否欠费 -->
		<input type="hidden" id="selecththarearight"/>
		<select id="yhxz_hidden" style="display:none;"></select>
		<jsp:include page="phone_internet.jsp" flush="true"/>
		<input type="hidden" id="businesstype" value="p_hthchangename"/><!-- 该页面的业务类型 -->	
	</body>
</html>
