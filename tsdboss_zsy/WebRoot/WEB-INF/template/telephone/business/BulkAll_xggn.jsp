<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/BulkAll_xggn.jsp
    Function:   电话批量功能及月租
    Author:     wenxuming
    Date:       2012-06-26
    Description: 
    Modify: 
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
		<title>电话业务</title>
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
		<script src="script/public/phoneservicenew.js" type="text/javascript" language="javascript"></script>		
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
		<script src="script/telephone/business/businesspublic.js" type="text/javascript" language="javascript"></script>	
		<!-- 打印报表弹出窗口 -->
		<script src="script/telephone/business/businessreprint.js" type="text/javascript" language="javascript"></script>
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
		<!--设置全局字体大小-->
		<link href="style/css/telephone/business/fontsize_all.css" rel="stylesheet" type="text/css"/>
		<style type="text/css">
			#qftrid{background-color:#A9C8D9;border:#A9C8D9 solid 0px;}
			#qftrid{border-collapse:collapse;border:#A9C8D9 solid 1px;}
			#qfuser tr td{line-height:26px;border:#A9C8D9 solid 1px;TEXT-OVERFLOW: ellipsis;}
		</style>
		<style type="text/css">  
		.mytable{		   
		   table-layout:fixed;
		   border:0px;   
		   margin:0px; 
		   }      
		.mytable tr td{   
		   text-overflow:ellipsis; /* for IE */    
		   -moz-text-overflow: ellipsis; /* for Firefox,mozilla */    
		    overflow:hidden;   
		    white-space: nowrap;   
		    border:0px;   
		    text-align:left;      
		   }
		   .mytable tr th{   
		    white-space: nowrap;   
		   border:0px;  
		   background-color:#A9C8D9; 
		    text-align:left 
		   }   
		</style>  		
		
		<style type="text/css">
		#input-Unit .title{text-align:left;}
		.inputbox{{margin-left:20px; background:url(style/imgs/inputText_bg.jpg) repeat-x ; width:180px; border:#999999 solid 1px;  text-align:left; color:#000000; font-size:12px; font-weight:bold; height:22px; line-height: 23px; }}
		hr {border:1px #A9C8D9 dotted;}
		.tdstyle{border-bottom:1px solid #A9C8D9;}
		#tdiv td{line-height:26px;}
		</style>		
		<script type="text/javascript">
		jQuery(document).ready(function()
		{	    
		    $("#navBar").append(genNavv());
		    gettabletitle();
		    setquerytype();
			getywslUserPower();
			getfufeitype();//付费类型	
			getinternation();	//businesspublic.js中  自动加载显示框  
			getJGgrid();
			
			var str="<option value=''>--请选择--</option>";
			$("#feename").empty();
			var resattachfee = fetchMultiArrayValue("FINAL.attachprice",6,'','business');
			if(resattachfee[0][0]!=undefined||resattachfee[0][0]!=""){
				for(var i=0;i<resattachfee.length;i++){
					str+="<option value='"+resattachfee[i][1]+"'>"+resattachfee[i][0]+"</option>";
				}
				$("#feename").html(str);
			}
			
			$("#feename").change(function(){
				var strto="<option value=''>--请选择--</option>";
				$("#opertype").val("");
				$("#feetype").empty();
				var resattachfee = fetchMultiArrayValue("dbsql_phone.attachpricefeetype",6,'&feename='+$("#feename").val(),'business');
				if(resattachfee[0][0]!=undefined||resattachfee[0][0]!=""){
					for(var i=0;i<resattachfee.length;i++){
						strto+="<option value='"+resattachfee[i][0]+"'>"+resattachfee[i][0]+"</option>";
					}
					$("#feetype").html(strto);
				}
			});
		}); 
		
		function getywslUserPower(){
			 var urlstr=tsd.buildParams({
			 									packgname:'service',
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
			var allcjqueryright='';
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
					allcjqueryright='true';
					flag = true;
			}else if(spower!=''&&spower!='all@'){
					var spowerarr = spower.split('@');
					for(var i = 0;i<spowerarr.length-1;i++){
						allcjqueryright +=getCaption(spowerarr[i],'allcjquery','')+'|';//一次性费用应缴费
					}
			}
			var hasallcjquery = allcjqueryright.split('|');
			var str = 'true';
			if(flag==true){
				$("#allcjqueryright").val(allcjqueryright);
			}else{
				for(var i = 0;i<hasallcjquery.length;i++){
						$("#allcjqueryright").val(hasallcjquery[i]);
						break;
					}
			}		
		}   
		
		/*********
		* 加载table的title
		* @param;
		* @return;
		**********/		
		function gettabletitle(){
			var param=""
			param += "<tr id='dyh'>";
			param += "<th style='width:40px;'><center>";
			param+= "<input type='checkbox' id='v_bytctab' onclick='Dhzf_CheckAll()'>";			
			param += "</center></th>";
			param += "<th style='width:150px;'>";
			param += "电话";
			param += "</th>";			
			param += "<th style='width:250px;'>";
			param += "用户名称";
			param += "</th>";
			param += "<th style='width:250px;'>";
			param += "用户地址";
			param += "</th>";
			param += "<th style='width:140px;'>";
			param += "联系电话";
			param += "</th>";
			param += "<th style='width:160px;'>";
			param += "装机日期";
			param += "</th>";
				
			param += "</tr>";
			$("#qfusertitle").html(param);
		}
		
		/*********
		* 点击保存拼接参数调用过程执行撤单操作
		* @param;
		* @return;
		**********/
		function cxJob()
		{
			if($.trim($("#memo").val())=="")
			{
				//alert("必须填写业务撤销备注信息");
				alert("<fmt:message key="phone.getinternet0310" />");
				$("#memo").focus();
				$("#memo").select();
				return false;
			}
			var area = $("#area").val();
			var userareaid = $("#userareaid").val();
			//部门
			var depart = $("#depart").val();
			//工号
			var userid = $("#userid").val();	
			var cPayType = $("#cPayType").val();
			var cYingJiao = $("#cYingJiao").val();
			//选中的电话的key
			var Dhmc = $("#checkvalue").val();
			var checkedDhzf = $("input[id^='v_bytctab_check'][checked]");
	        var count = $(checkedDhzf).size();
	        if(count<1){
		        		alert("请选择要批量修改的电话号码！");
		        		return;
	         }
			if($("#feetype").val()==""){
				alert("请选择一项费用项");
				$("#feetype").select().focus();
				return;
			}
			if($("#opertype").val()==""){
				alert("请选择操作类型");
				$("#opertype").select().focus();
				return;
			}
			var params = "";
			params += "&HTH=";
			params += tsd.encodeURIComponent($("#this_hth").text());
			params += "&UserID=";
			params += tsd.encodeURIComponent($("#userid").val());
			params+="&Area="+tsd.encodeURIComponent(area);
			params+="&userarea="+tsd.encodeURIComponent(userareaid);		
			params+="&Depart="+tsd.encodeURIComponent(depart);	
			params += "&zwbz=";
			params += tsd.encodeURIComponent($("#memo").val());
			params += "&feetype=";
			params += tsd.encodeURIComponent($("#feetype").val());
			params += "&opertype=";
			params += tsd.encodeURIComponent($("#opertype").val());
			params += "&feecode=";
			params += tsd.encodeURIComponent($("#feename").val());
			params += "&lxr=";
			params += tsd.encodeURIComponent($("#newLxr").val().replace(/(^\s*)|(\s*$)/g,""));
			params += "&lxdh=";
			params += tsd.encodeURIComponent($("#newLxdh").val().replace(/(^\s*)|(\s*$)/g,""));
			tsd.QualifiedVal=true;
			if(tsd.Qualified()==false){$("#addBzText").focus();$("#addBzText").select();return false;}			
			var loginfo = "电话批量变更月租及新功能业务：(";
			loginfo += "合同号:";
			loginfo += $("#this_hth").text();
			loginfo += ")(";
			loginfo += "受理人员:";
			loginfo += $("#userid").val();
			loginfo += ")(营业区域:";
			loginfo += area;
			loginfo += ")";
			loginfo = tsd.encodeURIComponent(loginfo);
			params += "&ywbz="+loginfo;
			params+="&Dhmc="+Dhmc;
			if(confirm("你确定对合同号["+$("#this_hth").text()+"]帐户下的电话进行批量拆机么？"))
			{
				var res = fetchMultiPValue("PhoneService.Bulkall_xggn",6,params);							
				if(res[0]==undefined || res[0][0]==undefined || res[0][0]=='-1')
				{
					respage();
					alert("批量拆机失败！");
					getdhcountvalue();
				}
				else
				{
					if(res[0][0]=='Error'){
						alert(res[0][1]);
						return;
					}
					$("#jobidid").val(res[0][0]);
					$("#ppaytype").val(cPayType);
					$("#fee").val(cYingJiao);	
					//判断是否打印工单，从tsd_ini表中配置Y为打印
					printworkorder('p_delete');//script/telephone/business/businessreprint.js中
					writeLogInfo("","modify",loginfo);
					$("#thismemovalue").empty();					
					$("#kdSearchBox").val("");
					$("#kdSearchBox").select();
					$("#kdSearchBox").focus();
					respage();
					getdhcountvalue();
				}
			}			
		}		
				
		
		/**********
		* 工单打印
		* @param：flag为1时直接打印，为2时预览打印;
		* @return;
	    **********/
       	function jobPrint(flag)
       	{
       		var jobid= $("#jobidid").val();
			var params = "&JobID="+jobid;
       		var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/commonreport/dh_jobworkorder_all_zcy.cpt"+params;
       		if(flag=="1")
       		{
       			printWithoutPreview("commonreport/dh_jobworkorder_all_zcy","JobID_"+jobid);
       		}
       		else if(flag=="2")
       		{
       			window.showModalDialog(urll,window,"dialogWidth:800px; dialogHeight:530px; center:yes; scroll:no");
       		}
       		else
       		{

       		}      		
       	}
		
		/*********
		* 点击重置清空所有数据
		* @param;
		* @return;
		**********/
		function respage(){	
			$("#feename").val("");
			$("#feetype").val("");		
			$("#opertype").val("");
			$("#kdSearchBox").val("");
			$("#this_hth").html("");
			$("#this_yhmc").html("");
			$("#this_bm1").html("");
			$("#this_dh").html("");
			$("#this_yhlb").html("");
			$("#this_yhxz").html("");
			$("#this_callpaytype").html("");
			$("#this_linktel").html("");
			$("#this_area").html("");
			$("#this_yhdz").html("");
			$("#this_dhsl").html("");
			$("#phone_dh").html("");				
			$("#phone_yhmc").html("");
			$("#phone_bm1").html("");
			$("#phone_reg_date").html("");
			$("#phone_tjbz").html("");
			$("#phone_usertype").html("");
			$("#phone_bz8").html("");
			$("#phone_bz9").html("");
			$("#phone_dhgn").html("");
			$("#phone_yhdz").html("");
			$("#phone_bz3").html("");
			$("#phonevalue").empty();
			$("#qfuser").empty();	
			$("#checkvalue").val("all");
			$("#memo").empty();
			$("#kdcx").attr("disabled","disabled");
			$("#v_bytctab").removeAttr("checked");
			ghPayMoney('p_delete');//通过移机标识查询一次性费用			
			getdhcountvalue();			
		}				
		
		function userChoose(Yhmc,Dh,Yhdz,key){
			thisInfo(key);
			setTimeout($.unblockUI,1);
		}
		
		function ClearTmpData()
	   {
	   		var userid = tsd.encodeURIComponent($("#userid").val());	   		
	   		executeNoQueryProc("PhoneService.POPEN",6,"&userid=" + userid);
	   }
		
		/*********
		* 根据合同号查询合同号信息
		* @param：hth;
		* @return;
		**********/
		function thisInfo(key){
			     if(key==""||key==undefined){
            	///设置命令参数
            	var hthto=$("#kdSearchBox").val().replace(/(^\s*)|(\s*$)/g,"");//把空格替换为空
            	if(hthto==""){
            		alert("请输入查询合同号");
            		return;
            	}
            }else{
             var hthto = key;	
            }
		ClearTmpData();
         var rescjkey = fetchMultiArrayValue("BulkAllCj.checkCj",6,"&hth=" + hthto,'business');
				if(rescjkey[0][0]>0)
				{
					//alert("该用户已经进行了拆机，无法再次办理！");
					alert("<fmt:message key="phone.getinternet0162" />");
					return;
				}
				var resqf = fetchMultiArrayValue("BulkAllCj.isnotQFee",6,"&hth=" + hthto,'business');	
				/*		
				if(resqf[0][0]=='N'&&$("#allcjqueryright")!="true")
				{
					alert("该电话已欠费,请结清费用后在办理此业务！");
					return;
				}
				*/				
							 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
									 					clsname:'ExecuteSql',//类名
									 					method:'exeSqlData',//方法名
									 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
									 					tsdcf:'business',//指向配置文件名称
									 					tsdoper:'query',//操作类型 
									 					datatype:'xmlattr',//返回数据格式 
									 					tsdpk:'dbsql_phone.bulkallcj_queryhthdang' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									 					});
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&hthvalue='+hthto,
							/*
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式*/
							cache:false,					
							success:function(xml){
								$(xml).find('row').each(function(){
									var tmp_hth = $(this).attr('hth');
									if(tmp_hth!=undefined){
										checkstr="";
										$("#this_hth").html(tmp_hth);
										ghSerBasicInfoHthHf(tmp_hth);
										var tmp_yhmc = $(this).attr('yhmc');
										var tmp_bm1 = $(this).attr('bm1');
										var tmp_dh = $(this).attr('dh');
										var tmp_yhlb = $(this).attr('yhlb');
										var tmp_yhxz = $(this).attr('yhxz');
										var tmp_callpaytype = $(this).attr('callpaytype');
										var tmp_linktel = $(this).attr('linktel');
										var tmp_area = $(this).attr('area');
										var tmp_yhdz = $(this).attr('yhdz');
										var tmp_dhsl = $(this).attr('dhsl');
										$("#this_yhmc").html(tmp_yhmc);
										$("#this_bm1").html(tmp_bm1);
										$("#this_dh").html(tmp_dh);
										$("#this_yhlb").html(tmp_yhlb);
										$("#this_yhxz").html(tmp_yhxz);
										$("#this_callpaytype").html(tmp_callpaytype);
										$("#this_linktel").html(tmp_linktel);
										$("#this_area").html(tmp_area);
										$("#this_yhdz").html(tmp_yhdz);
										$("#this_dhsl").html(tmp_dhsl);
										query_hone(hthto);
										gettabledate(hthto);										
										$("#kdcx").removeAttr("disabled");
										//$("input[id^='v_bytctab']").attr("checked","checked");
									}else{
										alert("没有可查询的数据，请核对是否输入正确");
										$("#kdcx").attr("disabled","disabled");
									}
								});								
							}
						});
            }
            
       /*********
		* 向table中添加数据
		* @param;
		* @return;
		**********/    
       
		function gettabledate(key){
			$("#qfuser").empty();	
			$("#checkvalue").val("all");
			var querystr = "";
			//var hth=$("#kdSearchBox").val().replace(/(^\s*)|(\s*$)/g,"");//把空格替换为空
			//var res = fetchMultiArrayValue("dbsql_phone.plcjij",6,"&hth="+key,'business');
			var res = fetchMultiPValue("dbsql_phone.plcjij",6,"&hth="+key+"&userid="+$("#userid").val(),'business');			
			if(res[0][0]==undefined||res[0][0]=='undefined'){
				querystr="<tr><td>没有可批量修改功能及月租的电话！</td></tr>";
			}else{						 														
				for(var i=0;i<res.length;i++){			
					querystr += "<tr onClick=\"getselect('"+res[i][0]+"');\" id=\""+res[i][0]+"\">";				
					querystr += "<td  style='width:40;'><center>";				
					querystr += "<input type=\"checkbox\" id='v_bytctab_check"+res[i][0]+"' onClick=\"getcheckboxfalse('"+res[i][0]+"');BZclear()\" style='width:20px;'/>";								
					querystr += "</center></td>";
					querystr+="<td title='"+res[i][0]+"' style='width:150px;'>"+res[i][0]+"</td>";
					querystr+="<td title='"+res[i][1]+"' style='width:250px;'>"+res[i][1]+"</td>";   
					querystr+="<td title='"+res[i][2]+"' style='width:250px;'>"+res[i][2]+"</td>";
					querystr+="<td title='"+res[i][3]+"' style='width:140px;'>"+res[i][3]+"</td>";
					querystr+="<td title='"+res[i][4]+"' style='width:160px;'>"+res[i][4]+"</td>";					
					querystr += "</tr>";				
				}		
			}	
			$("#qfuser").html(querystr);
			getdhcountvalue();
		}
		
		/*********
		* 点击改变颜色
		* @param;
		* @return;
		**********/
			function getselect(key){
			$("#qfuserhidden").val(key);
        	$("#qfuser tr ").css('background-color','#ffffff');
        	$("#qftrid").css('background-color','#A9C8D9');
		    document.getElementById(key).style.background='#00FFFF';
		}
		
		/*********
		* 把选中的放入隐藏域	
		* @param;
		* @return;
		**********/
		var checkstr="";			
		function getcheckboxfalse(key){
			if($("#v_bytctab_check"+key+"").attr("checked")==false){
				checkstr+=""+key+",";
				var resfalse = executeNoQuery("dbsql_phone.updatequerydh_false",6,"&dhto="+key+"&useridto="+$("#userid").val(),'business');
				if(resfalse!="true"){
					$("#v_bytctab_check"+key+"").attr("checked","checked");
				}
			}else{
				checkstr=checkstr.replace(key+',','');
				var restrue = executeNoQuery("dbsql_phone.updatequerydh_true",6,"&dhto="+key+"&useridto="+$("#userid").val(),'business');
				if(restrue!="true"){
					$("#v_bytctab_check"+key+"").removeAttr("checked");
				}
			}
			$("#checkvalue").val(checkstr);
			if($("#checkvalue").val()==""){
				$("#checkvalue").val('all');
			}
			getdhcountvalue();
		}
		 /********
           	*全选全不选
           	*@param;
       	  	*@return;
          	********/
		var checkstr="";	
		  function Dhzf_CheckAll()
		    {
		    	if($("#v_bytctab").attr("checked")){
	        		$("input[id^='v_bytctab']").attr("checked","checked");
	        			 checkstr="All";	        			
					var res = executeNoQuery("dbsql_phone.updatequerydh_all_true",6,"&hthto="+$("#this_hth").text()+"&useridto="+$("#userid").val(),'business');
					if(res!="true"){
						$("input[id^='v_bytctab']").removeAttr("checked");
					}	 
	        	}else{
	        		$("input[id^='v_bytctab']").removeAttr("checked");	        		
	        			 checkstr="";	
					$("#checkvalue").val(checkstr);
					var res = executeNoQuery("dbsql_phone.updatequerydh_all_false",6,"&hthto="+$("#this_hth").text()+"&useridto="+$("#userid").val(),'business');
					if(res!="true"){
						$("input[id^='v_bytctab']").attr("checked","checked");	
					}	 
	        	}	        						
				getdhcountvalue();				
		    }	
		    /********
           	*点击改变清空业务备注
           	*@param;
       	  	*@return;
          	********/
		   function BZclear(){
		 		 $("#memo").empty();
		   }
		   
		  /********
           	*全选后删除列表中的电话不拆号码的信息
           	*@param;
       	  	*@return;
          	********/
          function deletephonenumber(){
          	var checkedDhzf = $("input[id^='v_bytctab_check'][checked]");
	        var count = $(checkedDhzf).size();
	        var dhstr="";
	        if(count<1){
		        		alert("请选择要删除的电话号码信息");
		        		return false;
	         }
	         for(var i=0;i<count;i++){
	        		dhstr += $(checkedDhzf[i]).parent().parent().next().text()+",";
	        			   	  
	        }    
	       $("#checkvalue").val(dhstr);
          }	 
     	/*********
		* 通过合同号把电话查询出来	
		* @param;
		* @return;
		**********/
            function query_hone(hth){
				var res = fetchMultiArrayValue("dbsql_phone.bulkallcj_queryphone",6,"&hthvalue="+hth,'business');
				if(res!=undefined&&res!=""){				
				var parstr="<tr>"
				var num=0;
					for(var i=0;i<res.length;i++){
						parstr+="<td>";
						parstr+="<a href='javascript:void(0)' title='"+res[i][1]+"' style='font-size: 15pt;' onclick='getphonevalue("+res[i][0]+");'>"+res[i][0]+"</a>";
						parstr+="</td>";
						num++;
						if(num==7){
							parstr+="</tr><tr>";
							num=0;
						}
					}
				
				parstr+="</tr>";
				}
		 } 
	
	  function setquerytype(){
	  	 if($("#ghSearchWay").val()=="3"){
	  	 		$("#ghSearchBox,#submitButton").hide();
	  	 		$("#kdSearchBox,#queryhth").show();
	  	 }else{
	  	 		$("#ghSearchBox,#submitButton").show();
	  	 		$("#kdSearchBox,#queryhth").hide();
	  	 	}
	  	 $("#ghSearchBox,#kdSearchBox").val("");	
	  }
	  
	  function getdhcountvalue(){		
			$("#dhcountvalue").empty();	
			var res = fetchMultiArrayValue("dbsql_phone.queryselectdh",6,"&useridto="+$("#userid").val()+"&hthto="+$("#this_hth").text(),'business');
			getJGgrid();
			if(res[0]==undefined || res[0][0]==undefined)
			{				
				$("#selectbuttonid").hide();
				$("#dhcount").empty();
				$("#dhcountvalue").empty();
				return;
			}
			if(res[0][0]==""||res[0][0]==undefined){$("#selectbuttonid").hide();return;}
			$("#selectbuttonid").show();
			var dhify="<tr>";	
			var count=0;		
			for(var i=0;i<res.length;i++){
				dhify += "<td id='"+res[i][0]+"' style='width:110px;height:30px;'>";
				//dhify +="<a href=\"javascript:void(0)\" onClick=\"getcheckphonecontent('"+res[i][0]+"');\" title='"+res[i][1]+"'><h4>";						
				dhify +="<a href=\"javascript:void(0)\" title='"+res[i][0]+"'><h4>";						
				dhify += res[i][0];
				dhify += "</h4></a>";
				dhify += "</td>";
				count++;
				if(count==8){
					dhify += "</tr><tr>";
					count=0;
				}
			}
			dhify +="</tr>";
			dhify +="<tr><td colspan=10><span id='dhcount' style='color:red;'></span></td></tr>";
			$("#dhcountvalue").append(dhify);
			var rescount=fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=count(1)&tablename=querydhall&key=userid='"+tsd.encodeURIComponent($("#userid").val())+"' and  hth='"+$("#this_hth").text()+"' and dhtype='true'");	
			$("#dhcount").text("当前修改功能及月租电话数量："+rescount+"个");
			getJGgrid();
		}
		
		function getJGgrid(){			
			Dat = loadData("attachfee","zh",2);		
			$("#gridd").empty();
			$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
			$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');		
			var urlstr=tsd.buildParams({
								packgname:'service',//java包
								clsname:'ExecuteSql',//类名
								method:'exeSqlData',//方法名
								ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
								tsdcf:'mssql',//指向配置文件名称
								tsdoper:'query',//操作类型 
								datatype:'xml',//返回数据格式 
								tsdpk:'BULKALL_XGGN.QUERYSELECT',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								tsdpkpagesql:'BULKALL_XGGN.QUERYSELECTPAGE'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
					});
			jQuery("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr+"&column="+Dat.FieldName.join(",")+"&slrid="+$("#userid").val(),
				datatype: 'xml', 
				colNames:Dat.colNames, 
				colModel:Dat.colModels, 
				rowNum:10, //默认分页行数
				rowList:[10,15,20], //可选分页行数
				imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				pager: jQuery('#pagered'), 
				sortname: 'Dh', //默认排序字段
				viewrecords: true, 
				//hidegrid: false, 
				sortorder: 'asc',//默认排序方式 
				caption:'当前用户月租及功能',				       	
				height:260, //高
				//width:document.documentElement.clientWidth-27,
				loadComplete:function(){														
								}
				}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:260,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:260,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
		}
	</script>
	</head>
	<body>
		<div id="navBar">
			<img src="style/icon/dot11.gif" />
			<fmt:message key="global.location" />:
		</div>	
		<div id="inputtext">
			<table id="kdBar" style="margin-left: 10px;" cellspacing="10px">
				<tr>
					<td>
						<fmt:message key="phone.getinternet0179" /><!-- 查询方式 -->
						<select id="ghSearchWay" style="width: 100px;" onChange="setquerytype()";>
							<option value="0">
								<fmt:message key="phone.getinternet0103" /><!-- 电话 -->
							</option>
							<option value="1">
								<fmt:message key="phone.getinternet0180" /><!-- 用户名 -->
							</option>
							<option value="2">
								<fmt:message key="phone.getinternet0113" /><!-- 用户地址-->
							</option>
							<option value="3">
								合同号	
							</option>
						</select>
					</td>
					<td>
						<input type="text" class="" id="ghSearchBox" name="ghSearchBox" />
					</td>
					<td>
						<button class="tsdbutton" id="submitButton" onClick="ghSearch()" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
							<fmt:message key="phone.getinternet0466" /><!-- 查找 -->
						</button>
					</td>
					<td><input type="text" class="inputbox" id="kdSearchBox" name="kdSearchBox" /></td>
					<td>
						<button class="tsdbutton" id="queryhth" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;" onClick="thisInfo()"><fmt:message key="phone.getinternet0466" /><!-- 查找 --></button>	
					</td>
					<td width="290"></td>
				</tr>
			</table>
		</div>	
	   <div id="input-Unit" style="margin-bottom:0px;">			
		<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/45.gif" />
					合同号基本信息
		</div>		
		<table id="tdiv" border="0"
			style="border: 1px; border-style: solid; border-color: #87CEFA;width:90%;min-width:780px;"
			cellspacing="0" cellpadding="0">
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">合同号</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="this_hth" style="color:red;"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="">用户名称</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="this_yhmc" style="color:red;"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">部门名称</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="this_bm1" style="color:red;"></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">账单电话</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="this_dh" style="color:red;"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">用户类别</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">					
					<div id="this_yhlb" style="color:red;"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="">用户性质</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="this_yhxz" style="color:red;"></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">付费策略</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="this_callpaytype" style="color:red;"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">联系电话</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id=this_linktel style="color:red;"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">收费地点</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="this_area" style="color:red;"></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">用户地址</span>
					</label>
				</td>
				<td width="20%" class="tdstyle" colspan=3>
					<div id="this_yhdz" style="color:red;"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">电话数量</span>
					</label>
				</td>
				<td width="20%" class="tdstyle" colspan=5>
					<div id="this_dhsl" style="color:red;"></div>
				</td>
			</tr>			
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">联系人</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<input type="text" id="newLxr" style="width:150px;"/> 
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">联系电话</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<input id="newLxdh" name="newLxdh" style="width:150px"/>
				</td>
			</tr>
		</table>
	   <div class="title">
			&nbsp;&nbsp;
			<img src="style/icon/65.gif" />
			电话数量查询结果&nbsp;<input type="hidden" id="phoneshowcheck" onClick="getshow()" style="width:15px;" /><span id="gdfeeTips" style="color:red"></span>
		</div>
		<table id="qfusertitle" style="width:990px;height:25px;" class='mytable'></table>
	<div id="page" style="width:990px; height:230px; overflow-y: scroll; overflow-x: scroll; border-top: 1px solid gray; border-left: 1px solid gray;">
		<table id="qfuser" class='mytable'></table>
	</div>				
	<div id="inputtext">
		<table id="phonevalue" cellspacing="12" border="5" cellspacing="1" style="background-color:#f7f7f7"></table>			
	</div>	
	<table id="dhcountvalue"  cellspacing="12" border="0" cellspacing="1" style="background-color:#f7f7f7"></table>	
	<div id="gridd">
		<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>
	</div>
	<table>
		<tr>
			<td>
				费用类型：		
			</td>
			<TD>
				<select id="feename" style="width:150px;"></select>			
			</TD>
			<td>
				费用项：		
			</td>
			<TD>
				<select id="feetype" style="width:200px;"></select>			
			</TD>
			<TD>
				<select id="opertype" style="width:100px;">
					<option value="">--请选择--</option>
					<option value="add">新增</option>
					<option value="delete">删除</option>
				</select>			
			</TD>
		</tr>	
	</table>
	</div>
		<div id="inputtext2">
		    <table style="background-color:#f7f7f7">
		       <tr>
		         <td>
				    <table cellspacing="5" style="display:none;">
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
		                  <textarea name="memo" id="memo" rows="4" cols="110" maxlength="60"  onpropertychange="TextUtil.NotMax(this)"></textarea>
		                </td>
		              </tr>
		           </table>
		         </td>
		      </tr>				      
		    </table>
	</div>
	
	<div id="buttons" style="text-align:center">
		<button id="kdcx" style="width:120px;" onClick="cxJob()" disabled>批量变更</button><button id="kdback" style="width:120px;" onClick="respage()"><fmt:message key="AddUser.Reset" /></button>
	</div>		
	<div class="neirong" id="queryphonefrom" style="width:785px;display: none">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							号码选择
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;" onClick="closeGB()"><fmt:message key="global.close" /><!-- 关闭 --></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;height:70px;">
				<table id="tdiv" border="0"
					style="border: 1px; border-style: solid; border-color: #87CEFA;width:100%;min-width:780px;"
					cellspacing="0" cellpadding="0">
					<tr>
						<td class="labelclass">
							<label for="sarea">
								<span id="">电话号码</span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="phone_dh"></div>
						</td>
		
						<td class="labelclass">
							<label for="sarea">
								<span id="">用户名称</span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="phone_yhmc"></div>
						</td>
						<td class="labelclass">
							<label for="sarea">
								<span id="">部门名称</span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="phone_bm1"></div>
						</td>
					</tr>
					<tr>
						<td class="labelclass">
							<label for="sarea">
								<span id="">装机日期</span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="phone_reg_date"></div>
						</td>
						<td class="labelclass">
							<label for="sarea">
								<span id="">当前状态</span>
							</label>
						</td>
						<td width="20%" class="tdstyle">					
							<div id="phone_tjbz"></div>
						</td>
		
						<td class="labelclass">
							<label for="sarea">
								<span id="">用户性质</span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="phone_usertype"></div>
						</td>
					</tr>
					<tr>
						<td class="labelclass">
							<label for="sarea">
								<span id="Bz8">联系人</span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="phone_bz8"></div>
						</td>
						<td class="labelclass">
							<label for="sarea">
								<span id="Bz9">联系电话</span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id=phone_bz9></div>
						</td>
						<td class="labelclass">
							<label for="sarea">
								<span id="Dhgn">电话功能</span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="phone_dhgn"></div>
						</td>
					</tr>
					<tr>
						<td class="labelclass">
							<label for="sarea">
								<span id="">用户地址</span>
							</label>
						</td>
						<td width="20%" class="tdstyle" colspan=3>
							<div id="phone_yhdz"></div>
						</td>
						<td class="labelclass">
							<label for="sarea">
								<span id="">所属区域</span>
							</label>
						</td>
						<td width="20%" class="tdstyle" colspan=5>
							<div id="phone_bz3"></div>
						</td>
					</tr>
				</table>
			</div>
			<div class="midd_butt" style="width:771px;height:30px;">  
				<button id="hthChooseFormReset" onClick="closeGB()" class="tsdbutton"  style="margin-left: 20px;">
					关闭
				</button>
			</div>
	</div>
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>' />	
	<input type="hidden" id="depart" value="<%=depart%>" />
	<input type="hidden" id="userareaid" value="<%=userareaid%>" />
	<input type="hidden" id="Interregional" />	
	<input type="hidden" id="department" name="department" value='<%=session.getAttribute("departname") %>' />	
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea") %>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea") %>' />
	<input type="hidden" id="userid" name="userid" value='<%=session.getAttribute("userid") %>' />	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 	
	<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 
	<input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->	
	<input type="hidden" id="fufeitypepath"/>
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->	
	<input type="hidden" id="checkvalue" style="width:300px;" value="all"/>
	<input type="hidden" id="jobidid" />
	<input type="hidden" id="ppaytype" />
	<input type="hidden" id="fee" />
	<input type="hidden" id="yjfeehidden"/><!-- 页面获取应缴费存入隐藏于中 -->
	<input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->		
	<input type="hidden" id="fufeitypepath"/>
	<input type="hidden" id="enforceCJright"/><!-- 是否强制拆机权限 -->
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->
	<input type="hidden" id="stiffbusinestype" value="phoneCJ"/><!-- 电话工单打印类型 -->
	<input type="hidden" id="Prefeeval"/><!-- 预测金额打印票据时判断 -->
	<input type="hidden" id="businesstype" value="p_delete"/><!-- 该页面的业务类型 -->
	<!-- 弹出报表打印框 -->	
		<div id="businessreprint"></div><!-- 加载的文件在script/telephone/business/businessreprint.js -->  
	<div class="neirong" id="multiSearch"
			style="display: none; overflow-x: hidden;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							批量修改功能月租用户查询
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
	<jsp:include page="phone_internet.jsp" flush="true"/>
	<input type="text" id="allcjqueryright"/>
	</body>
</html>
