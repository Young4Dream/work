<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/PhoneBJ.jsp
    Function:   电话并机
    Author:     wenxuming
    Date:       2010-10
    Description: 
    Modify: 
     201206
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
		<title>电话移机业务</title>
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
		<script src="script/public/phoneservicenew.js" type="text/javascript" language="javascript"></script>		
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
		<script src="script/telephone/business/businesspublic.js" type="text/javascript" language="javascript"></script>	
		<!-- 打印报表弹出窗口 -->
		<script src="script/telephone/business/businessreprint.js" type="text/javascript" language="javascript"></script>
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
		<!--设置全局字体大小-->
		<link href="style/css/telephone/business/fontsize_all.css" rel="stylesheet" type="text/css"/>
		<script src="script/telephone/business/phoneInstalled.js" type="text/javascript"></script>
		<script src="script/telephone/business/phone_kjbq_gh.js" type="text/javascript"></script> 
        <script type="text/javascript">
		 $(function(){
		  $("tbody>tr:odd").addClass("odd"); //先排除第一行,然后给奇数行添加样式
		  $("tbody>tr:even").addClass("even"); //先排除第一行,然后给偶数行添加样式
		 })
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
				var useridright='';
				var konghaoarearight='';
				var selecththright='';
				var addressinputright='';
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
						addressinputright='true';
						flag = true;
				}else if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');
						for(var i = 0;i<spowerarr.length-1;i++){
							addressinputright +=getCaption(spowerarr[i],'addressinput','')+'|';					
						}
				}
				var hasaddressinput = addressinputright.split('|');
				var str = 'true';				
				if(flag==true){
					$("#addressinputright").val(addressinputright);
				}else{
					for(var i = 0;i<hasaddressinput.length;i++){
							$("#addressinputright").val(hasaddressinput[i]);
							break;
						}		
					}				    
			}
		</script>
    	<script type="text/javascript">
       jQuery(document).ready(function()
	   {	   ygdf(); //加载月固定费
	    $("#navBar").append(genNavv());
	    getUserPower();	    
		$("#dhzfform td:even").attr("align","right");
		$("#bytcform td:even").attr("align","right");
    	$("#ghBasicInfo :text").css("margin-left","5px"); 
	    getinternation();	//businesspublic.js中  自动加载显示框  
	    PageInitial();
	    ghPayMoney('p_splitphone');//通过移机标识查询一次性费用
	    $("#ghSearchBox").select();
	    $("#ghSearchBox").focus();
	    $("#tablehthdang select").attr("disabled","disabled");
		$("#tablehthdang :text").attr("disabled","disabled");
		$("#tableyhdang select").attr("disabled","disabled");
		$("#tableyhdang :text").attr("disabled","disabled");
		$("#BjAdress").attr("disabled","disabled");//默认加载新地址无法编辑，必须查询用户电话才可编辑
		if(getaddressEditer()=="NO"){
			$("#BjAdress").focus(function(){c_p_address_fun_to();});
			$("#BjAdress").keyup(function(){notecheck();});
		}
		getfufeitype();//付费类型	
		gethide("p_movephone");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数
	   }); 
	   	   
	   /*******
       *清除被锁定账号
       *@param;
       *@return;
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
			var result = fetchMultiPValue("PhoneDH.ifCanSouLi",6,"&OperID=" + tsd.encodeURIComponent($("#userid").val()) + "&Ywlx="+tsd.encodeURIComponent("p_splitphone")+"&NowYwArea="+tsd.encodeURIComponent($("#area").val())+"&Dh="+Dh);
			if(result[0]!=undefined && result[0][0]!="")
			{
				alert(result[0][1]);
				return;
			}	
			
			//判断是否完工
			var res = fetchSingleValue("dbsql_phone.getteljobwgrq",6,"&dh="+Dh);
			if(res>0){
				//alert("对不起，该电话未完工！！！");
				alert("<fmt:message key="phone.getinternet0163" />");
				return;
			}
			
			/* commented by wcy 2016-09-09
			//判断是否有宽带
			var rad = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=INTERNETACCT&tablename=RADUSERINFO&key=dh='"+Dh+"'");
			if(rad!=undefined&&rad!=""){
				//alert("请注意，该电话有宽带！");
				alert("<fmt:message key="phone.getinternet0170" />");
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
			$("#sAddress").val(Yhdz);			
			$("#Plinkman,#Plinkphone").removeAttr("disabled");		
			$("#BjAdress").removeAttr("disabled");
			ghSerBasicInfo(Dh);
			addspeediFeeType(Dh);
			getAirUsersBJ(Dh);
			$("#BjAdress").select();
			$("#BjAdress").focus();
			//ghZF(Dh);
			//gethTC(Dh);
			//getdhBYTC(Dh);
			setTimeout($.unblockUI,1);
		}
		
		function getAirUsersBJ(Dh){
			$("#BjAdressTable").empty();	
			var strbjadress="<tr><td height='32' align='right'>并机地址新增</td><td><input type='text' id='BjAdress' name='BjAdress' style='width:270px' maxlength='25' onpropertychange='TextUtil.NotMax(this)'/><font color='red'>*</font></td></tr>";
			var rad = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&cloum=dh,linenum,useraddr&tablename=air_usersbj&key=dh='"+Dh+"'");			
			if(rad[0][0]!=undefined&&rad[0][0]!=""){				
			    for(var i=0;i<rad.length;i++){
					strbjadress+="<tr><td>并机地址"+(i+1)+"</td><td><input type='text' id='"+rad[i][0]+"|"+rad[i][1]+"' value='"+rad[i][2]+"' style='width:270px' disabled/></td></tr>";
				}				
			}
			$("#BjAdressTable").html(strbjadress);
		}

		/*******
        *并机保存时调用过程处理
        *@param;
        *@return;
        ********/
		function updateAddress()
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
			
			if(phone=="")
			{
				//alert("请先查询要办理移机的用户");
				alert("<fmt:message key="phone.getinternet0201" />");
				$("#ghSearchBox").select();
				$("#ghSearchBox").focus();
				return false;
			}
			//可办理业务	
			var bjAdress = $("#BjAdress").val().replace(/(^\s*)|(\s*$)/g,"");
			/*
			if($.trim(bjAdress)=="")
			{
				//alert("请输入新地址");
				alert("<fmt:message key="phone.getinternet0202" />");
				$("#sAddressold").select();
				$("#sAddressold").focus();
				return false;
			}
			*/
			var plinkman = $("#linkman").val();
			var plinkphone = $("#linktel").val();
			//付费方式
			var cPayType = $("#cPayType").val();		
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
			//业务联系人
			var cLianXiRen = $("#staff_ry").val();
			//var danweiHTHbox = $("#danweiHTHbox").val();
			//代缴合同号
			var danweiHTH = $("#danweiHTH").val();			
			//备注
			var phonepkBz = $("#phonepkBz").val().replace(/(^\s*)|(\s*$)/g,"");
			
			//跨模块局
			var isk=$('#isk').attr('checked');
			if(isk==true)
			{
				var mkj2=$('#mkj2').val();
				var mkj3=$('#mkj3').val();
				var mkj4=$('#mkj4').val();
					
				params+='&mkjacross=1';
				params+='&mkj2='+tsd.encodeURIComponent(mkj2);
				params+='&mkj3='+tsd.encodeURIComponent(mkj3);
				params+='&mkj4='+tsd.encodeURIComponent(mkj4);
			}else
			{
				params+='&mkjacross=0';
			}
			
			params+="&Area="+tsd.encodeURIComponent(area);
			var YwArea=$("#YwArea_yhdang").val();
			params+="&userarea="+tsd.encodeURIComponent(YwArea);
			//params+="&userarea="+tsd.encodeURIComponent(userareaid);
			params+="&Depart="+tsd.encodeURIComponent(depart);
			params+="&UserID="+tsd.encodeURIComponent(userid);
			params+="&Dhh="+tsd.encodeURIComponent(phone);			
			params+="&bjdz="+tsd.encodeURIComponent(bjAdress);
			params+="&ispay="+tsd.encodeURIComponent(cPayType);
			params+="&yjfee="+tsd.encodeURIComponent(cYingJiao);			
			//params+="&sjfee="+tsd.encodeURIComponent(cShiShou);
			params+="&feename="+tsd.encodeURIComponent(cPayItem);		
			params+="&linkman="+tsd.encodeURIComponent(plinkman);
			params+="&linkphone="+tsd.encodeURIComponent(plinkphone);
			params+="&HTH="+tsd.encodeURIComponent(danweiHTH);
			params+="&zwbz="+tsd.encodeURIComponent(phonepkBz);
			params+="&Hthhth="+tsd.encodeURIComponent($("#Hth").val());
			params+="&IDCard="+tsd.encodeURIComponent($("#IDCard").val());	
			params+="&Yhxz="+tsd.encodeURIComponent($("#Yhxz").val());
			params+="&Yhlb="+tsd.encodeURIComponent($("#Yhlb").val());
			var loginfo = "电话并机:";//电话移机
			loginfo += "(<fmt:message key="phone.getinternet0103" />:";
			loginfo += phone;
			loginfo += ")(并机地址:";			
			loginfo += bjAdress;
			loginfo += ")(<fmt:message key="phone.getinternet0381" />:";			
			loginfo += area;
			loginfo += ")(<fmt:message key="phone.getinternet0396" />:";			
			loginfo += userid+")";
			loginfo = tsd.encodeURIComponent(loginfo);
		 	params+="&ywbz="+loginfo;
	 		//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}			
			var result = fetchMultiPValue("PhoneService.BJ",6,params);
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
				printworkorder('p_splitphone');//script/telephone/business/businessreprint.js中
				writeLogInfo("","modify",loginfo);				
				pageReset();
				
				if(confirm("是否跳转到号线管理系统")){
                    openMenu('4114','route/RouteManage.jsp','6','');
                }
			}
		}
		
		/*******
        *页面重置
        *@param;
        *@return;
        ********/
		function pageReset()
		{
			$(":text").val("");
			$("#tablehthdang :text").val("");
        	$("#tablehthdang select").val("");
        	$("#tableyhdang :text").val("");
        	$("#tableyhdang select").val("");
        	$("#staff_bm").val("").trigger("change");
        	$("#cPayType").val("cash").trigger("change");
			//业务备注框
			$("#phonepkBz").val("");
			//杂费项
			$("#dhZFX").empty();
			//套餐项
			$("#dhTCX").empty();		
			$("#dhBYTC").empty();	
			$("#cPayType").val("cash");
			$("#danweiHTHbox").removeAttr("checked");
			$("#sAddressold").attr("disabled","disabled");	
			refreshbusinessfee();
			ghPayMoney('p_splitphone');//通过移机标识查询一次性费用		
			gethide("p_movephone");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数	
			unLockDh();
		}
        
        
        // 一下内容为2016-03-08移植自中石油原系统 
        /**
         * 是否跨模块局处理
         */
        function choiceMokuaiju()
        {
        	var isk=$('#isk').attr('checked');
        	if(isk==true)
        	{
        		loadmokuaiju();
        		autoBlockForm('mokuaiju', 60, 'exitmkj', "#ffffff", false);
        	}else
        	{
        		$('#mkj2').val('');
        		$('#mkj3').val('');
        		$('#mkj4').val('');
        	}
        }
        
        //退出模块局选择弹出框
        function exitmkj(){
        	$('#isk').attr('checked',false);
        	setTimeout($.unblockUI, 15);
        }

        //设置部门职称下拉选项
        function loadmokuaiju(){
            $("#leveltwo").empty();
            $("#levelthree").empty();
            $("#levelfour").empty();
            var res = fetchMultiArrayValue("nums21.query2",6,"");
            var queryBASsel="";
            
            if(res[0][0]!=undefined){
        		for(var i=0;i<res.length;i++)
        		{
        			var ee="<option value='"+res[i][0]+"'>"+res[i][0]+"</option>";	
        			queryBASsel+=ee	;				
        		}
        		$("#leveltwo").append("<option value=\"\">--请选择--</option>");
        		$("#levelthree").append("<option value=\"\">--请选择--</option>");
        		$("#levelfour").append("<option value=\"\">--请选择--</option>");
        		
        		$("#leveltwo").html($("#leveltwo").html()+queryBASsel);
        		$("#levelthree").html($("#levelthree").html()+queryBASsel);
        		$("#levelfour").html($("#levelfour").html()+queryBASsel);
        		
        		$("#leveltwo").val("");
        		$("#levelthree").val("");
        		$("#levelfour").val("");
        	}			   
        }
        
        /**
         *检查模块局
         */
        function checkmokuaiju(key)
        {
        	if(key==2)
        	{
        		var mkj2=$('#leveltwo').val();
        		if(mkj2==''||mkj2==null)
        		{
        			alert('请选择二级模块局！');
        			return false;
        		}
        	}
        	if(key==3)
        	{
        		var mkj2=$('#leveltwo').val();
        		var mkj3=$('#levelthree').val();
        		
        		if(mkj2==''||mkj2==null)
        		{
        			alert('请选择二级模块局！');
        			$('#levelthree').val("");
        			return false;
        		}
        		
        		if(mkj2==mkj3)
        		{
        			alert('与二级模块局重复！');
        			$('#levelthree').val("");
        			return false;
        		} 
        	}
        	
        	if(key==4)
        	{
        		var mkj3=$('#levelthree').val();
        		var mkj4=$('#levelfour').val();
        		
        		if(mkj3==''||mkj3==null)
        		{
        			alert('请选择三级模块局！');
        			$('#levelfour').val("");
        			return false;
        		}
        		if(mkj3==mkj4)
        		{
        			alert('与三级模块局重复！');
        			$('#levelfour').val("");
        			return false;
        		} 
        	}
        }


        /**
         *保存模块局
         */
        function savemokuaiju()
        {
        	var mkj2=$('#leveltwo').val();
        	var mkj3=$('#levelthree').val();
        	var mkj4=$('#levelfour').val();
        	
        	$('#mkj2').val(mkj2);
        	$('#mkj3').val(mkj3);
        	$('#mkj4').val(mkj4);
        	
        	setTimeout($.unblockUI, 15);
        }	
        
        //加载月固定费
          function ygdf(){
           var info="";
           $("#phonefeetype").empty();
           var res=fetchMultiArrayValue("select.ygdf",6,"");
             info+="<option value=''>--请选择--</option>";
		     info+="<option value="+res[0][1]+">"+res[0][0]+"</option>";
		     info+="<option value="+res[1][1]+">"+res[1][0]+"</option>";
		     info+="<option value="+res[2][1]+">"+res[2][0]+"</option>";
		     info+="<option value="+res[3][1]+">"+res[3][0]+"</option>";
		     info+="<option value="+res[4][1]+">"+res[4][0]+"</option>";
		     info+="<option value="+res[5][1]+">"+res[5][0]+"</option>";
		     info+="<option value="+res[6][1]+">"+res[6][0]+"</option>";
		     info+="<option value="+res[7][1]+">"+res[7][0]+"</option>";
             info+="<option value="+res[8][1]+">"+res[8][0]+"</option>";
          $("#phonefeetype").append(info);
        } 
        
        //月固定费下拉框改变事件
         function getfeename()
        {
        	 var feename = $("#phonefeetype").val();
        	var res=fetchMultiArrayValue("dbsql_phone.attachpricefeetype",6,"&feename="+tsd.encodeURIComponent(feename));
				var ghzfzfx='';
				$("#phonefeename").empty();	
				  for(var i=0;i<res.length;i++){
		                 ghzfzfx +="<tr onClick=\"getGHfeetr('"+res[i][0]+"');getGHcsnum('"+res[i][1]+"');\" id=\""+res[i][0]+"\"><td>";
		                 ghzfzfx +="☞"+res[i][0];
		                 ghzfzfx +="</td></tr>";
		          }       					
							$("#phonefeename").append(ghzfzfx);
				$("#feelv").val("");
				$("#TJfeelv").val("");
				$("#ZFEndday").attr("disabled","disabled");
        }
        
        /*******
        *单击选中一行固话杂费
        *@param：key子费用名称
        *@return
        ********/
        function getGHfeetr(key){        	
        	$("#phonefeenamecode").val(key);
        	getfeenameall();        	
        	$("#phonefeename tr").css('background-color','#f7f7f7');
		      document.getElementById(key).style.background='#0080FF';  
        }
          /********
        *固话杂费  费用名称 下拉框change事件 并去除对应的费用项信息 
        *@param;
       	*@return;
        ********/       
        function getfeenameall()
        {           
           var phonefeename = $("#phonefeenamecode").val();
           //alert(phonefeename);         
           if(phonefeename=="")
           {
              $("#feecode").val("");
              $("#Subtype").val("");
              $("#feelv").val("");
              $("#TJfeelv").val("");
              return false;
           }           
           var feename = $("#phonefeetype option:selected").text();
           if($("#phonefeetype").val()==""){
           		feename="";
           	}         
           //取费用项信息
           var res = fetchMultiArrayValue("phonelnstalled.queryfeenameall",6,"&FeeType="+tsd.encodeURIComponent(phonefeename)+"&vfeename="+tsd.encodeURIComponent(feename));
           var FeeCode = res[0][0];
           var FeeName = res[0][1];
           var Price = res[0][3];
           var TjPrice = res[0][4];
           var CUNIT = res[0][5];
           var stype = res[0][6];
           $("#feecode").val(FeeCode);
           $("#Subtype").val(FeeName);
           $("#feelv").val(Price);
           $("#TJfeelv").val(TjPrice);
           $("#CUNIT").val(CUNIT);
           $("#stype").val(stype);
        }
       /*******
        *单击选中一行固话杂费表获取参数数量值来显示页面显示几个参数个数框
        *@param：key参数数量值csnum
        *@return
        ********/
        function getGHcsnum(key){
        	var strtable="";
        	if(key==undefined||key==""||key=="null"){
        		key=0;
        	}
        	$("#keyhidden").val(key);
        	$("#ghfeeinput").empty();
        	var startdate = $("#startdate").val();
        	strtable +="<tr>";
        	strtable +="<td>"+$("#getinternetstarttime").val()+"</td>";
					strtable +="<td><input type='text' id='ZFStartday' name='ZFStartday' style='width: 100px;' disabled='disabled'/></td>";
					strtable +="<td>"+$("#getinternetermination").val()+"</td>";					
					strtable +="<td><input type='text' id='ZFEndday' name='ZFEndday' style='width: 100px;' disabled='disabled' value='2999-12-31'  /></td>";
					strtable +="<td>收费月份</td>";					
					strtable +="<td><input type='text' id='sfmonth' name='sfmonth' style='width: 100px;'/></td>";
					
					//strtable +="<td>设备数量</td>";
					strtable +="<td><input type='hidden' id='DEVNUM' name='DEVNUM' style='width:70px;' value='1' onkeypress='return event.keyCode>=4&&event.keyCode<=57'/></td>";
					//strtable +="<td>单位长度</td>";
					strtable +="<td><input type='hidden' id='DEVLENGTH' name='DEVLENGTH' style='width:70px;' value='1' onkeypress='return event.keyCode>=4&&event.keyCode<=57'/></td>";
					
					strtable +="<td></td>"
					key=parseInt(key,10);
        	for(var i=1;i<key+1;i++){        		
        		strtable +="<td>";
        		//strtable +="参数"+i;
        		strtable +=$("#getinternet0382").val()+i;        		
        		strtable +="</td><td>";
        		strtable +="<input type='text' id='cs"+i+"' style='width:100px;'/>";
        		strtable +="</td>";
        	}
        	strtable +="</tr>";
        	$("#ghfeeinput").append(strtable);
        	$("#ZFStartday").val(startdate);
        	$("#sfmonth").val(startdate.replace('-','').substring(0,6));
        	//$("#ZFEndday").removeAttr("disabled");
					$("#ZFStartday").removeAttr("disabled");  
					///电话杂费  终止月
					$("#ZFStartday").focus(function(){
						WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
					});
					///电话杂费  终止日
					$("#ZFEndday").focus(function(){
						WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
					});
					///电话杂费  终止日
					$("#sfmonth").focus(function(){
						WdatePicker({startDate:'yyyyMM',readOnly:'true',dateFmt:'yyyyMM',alwaysUseStartDate:true});
					});
					$("#cs1").val("");
					$("#cs2").val("");
					$("#cs3").val("");   	
					$("#DEVNUM,#DEVLENGTH input[value='1']").blur(function(){
						if($(this).val()==""){
							$(this).val('1');
						}
					});							
					$("#DEVNUM,#DEVLENGTH input[value='1']").focus(function(){
						if($(this).val()==1){
							$(this).val('')
						}
					});
					$("#DEVNUM,#DEVLENGTH input[value='1']").keydown(function(){			
						var k=event.keyCode;
						return k>=48&&k<=57||k==190&&this.value!=""&&this.value.indexOf(".")==-1||k==8||k==37||k==39;
					});					
					$("#DEVNUM,#DEVLENGTH input[value='1']").bind("copy paste",function(){
						return false;
					});
        }
         /********
           	*添加新费用的时候判断该费用项是否已经在临时表里
           	*@param：（params电话，parm费用类型）;
       	  	*@return返回值是否等于零;
          	********/
		    function JudgeISNOTStorage(params,parm,feename)
		    {
		        var result;
		        var res = fetchMultiArrayValue("phonelnstalled.queryisnotfeename",6,"&Dh="+parm+"&FeeType="+params+"&vfeename="+tsd.encodeURIComponent(feename));	
		        result = res[0][0];
		        return result;	    
		    }
        function insertphonefeename()
		   {
		      var phone = $("#Dh_yhdang").val();
		      if(phone=="" || phone==null){
		       alert("请先查询一个账户");
		      	return false;
		      }
		      var phonefeename = $("#phonefeenamecode").val();		      
		      if($("#phonefeetype").val()=="")
		      {
		      	//alert("请选择要添加的费用名称");
		      	alert($("#getinternet0006").val());
		      	$("#phonefeetype").focus();
		      	return false;
		      }
		      
		      if(phonefeename=="" || phonefeename==null)
		      {
		      	//alert("请选择要添加的费用子类型");
		      	alert($("#getinternet0007").val());
		      	$("#phonefeename").focus();
		      	return false;
		      }
		      
		      phonefeename = tsd.encodeURIComponent(phonefeename);
		      var ress = JudgeISNOTStorage(phonefeename,phone,$("#Subtype").val());
		      if(ress!=0)
		      {
		      	//alert("该费用子类型已经存在不能重复添加！");
		      	alert($("#getinternet0008").val());
		      	return false;
		      }
		     
		      var feecode = $("#feecode").val();
		      var feelv = $("#feelv").val();
		      var TJfeelv = $("#TJfeelv").val();
		      var ZFStartday = $("#ZFStartday").val();
		      
		      if(!/^\d{4}-\d{2}-\d{2}$/.test(ZFStartday))
		      {
		      	$("#ZFStartday").focus();
		      	return false;
		      }
		      
		      var ZFEndday = $("#ZFEndday").val();
		      
		      if(!/^\d{4}-\d{2}-\d{2}$/.test(ZFEndday))
		      {
		      	$("#ZFEndday").focus();
		      	return false;
		      }
		      
		      var ZFStartmonth = ZFStartday.substring(0,7);//起始月
		      ZFStartmonth = ZFStartmonth.replace('-',"");
		      
		      var ZFEndmonth = ZFEndday.substring(0,7);//终止月
		      ZFEndmonth = ZFEndmonth.replace('-',"");
		      
		      var feename = $("#Subtype").val();
		      
		      feename = tsd.encodeURIComponent(feename);
		      
		      var cs1 = $("#cs1").val();
		      if(cs1==undefined||cs1=="undefined"){cs1=""}
		      cs1=cs1.replace(/(^\s*)|(\s*$)/g,"");
		      var cs2 = $("#cs2").val();
		      if(cs2==undefined||cs2=="undefined"){cs2=""}
		      cs2=cs2.replace(/(^\s*)|(\s*$)/g,"");
		      var cs3 = $("#cs3").val();
		      if(cs2==undefined||cs3=="undefined"){cs3=""}
		      cs2=cs2.replace(/(^\s*)|(\s*$)/g,"");
		      var csstr;
		      if(cs1!=""&&cs2==""){
		      	 csstr = cs1;		      	 
		      }else if(cs1!=""&&cs2!=""&&cs3==""){
		      	 csstr = cs1+"~"+cs2;
		      }else if(cs3!=""&&cs2!=""&&cs1!=""){
		      	 csstr = cs1+"~"+cs2+"~"+cs3;
		      }		      
		      if(cs1==""&&cs2==""&&cs3==""){
		      	csstr="";
		      }
		      if(csstr==undefined){csstr="";}
		      csstr=csstr.replace('~undefined',"");
		      csstr=csstr.replace('undefined',"");
		      
		      var DEVNUMstr = $("#DEVNUM").val().replace(/(^\s*)|(\s*$)/g,"");
		      var DEVLENGTHstr = $("#DEVLENGTH").val().replace(/(^\s*)|(\s*$)/g,"");
		      var CUNIT = $("#CUNIT").val();		
		      
		      var sfmonth=$("#sfmonth").val();
		      var stype=$("#stype").val();
		      if (stype == undefined || stype == 'undefined' || stype == '') {
		      	stype = '0';
		      }
		         
		     var result = fetchMultiPValue("phonelnstalled.insertphonefeename",6,"&dh="+phone+"&feetype="+phonefeename+"&feecode="+feecode+"&feelv="+feelv+"&TJfeelv="+TJfeelv+"&StartMonth="+ZFStartmonth+"&EndMonth="+ZFEndmonth+"&StartDate="+ZFStartday+"&EndDate="+ZFEndday+"&feename="+feename+"&OperID="+tsd.encodeURIComponent($("#userid").val())+"&csstr="+tsd.encodeURIComponent(csstr)+"&ywlx=p_setup"+"&cztype=add"+"&DEVNUM="+DEVNUMstr+"&DEVLENGTH="+DEVLENGTHstr+"&CUNIT="+CUNIT+"&sfmonth="+sfmonth+"&stype="+stype);	
				 if(result[0][0]!=undefined && result[0][0]!=""&&result[0][0]=="SUCCEED")
				 {
				 	addspeediFeeType('');//重新加载数据
			        $("#feecode").val("");
			        $("#feelv").val("");
			        $("#TJfeelv").val("");
			        //$("#ZFStartday").val("");
			        //$("#ZFEndday").val("");
			        $("#Subtype").val("");
			        $("#feenameid").val("");
			        $("#Subtype").val("");
			        $("#phonefeename").val("");
			        $("#DEVNUM").val("1");
			        $("#DEVLENGTH").val("1");
			        $("#ZFEndday").val("2999-12-31");
				 }else{
				 	//alert("新增失败！");
				 	alert(result[0][1]);
				 }
		
		      $("#phonefeenamecode").val("");
        	  $("#phonefeename tr").css('background-color','#f7f7f7');
		    }
		    /********
           	*删除列表中的电话费用杂费信息
           	*@param;
       	  	*@return;
          	********/
		    function deletephonefeename()
		    {	
				var checkedDhzf = $("input[id^='v_dhzftab_check'][checked]");
	        	var count = $(checkedDhzf).size();	        	
	        	if(count<1)
	        	{
	        		//alert("请选择要删除的杂费项信息");
	        		alert($("#getinternet0010").val()+"777");
	        		return false;
	        	}	        	
	        	var dh = $("#Dh_yhdang").val();
	        	var feetype = "";
	        	var feecode = "";       	
	        	var result = true;
	        	var resultTmp = false;	        	
	        	for(var i=0;i<count;i++)
	        	{
	        		feetype = $(checkedDhzf[i]).parent().parent().next().text();
	        		feecode = $(checkedDhzf[i]).parent().parent().next().next().text();//费用code是隐藏在表格中的
	        		
	        		var result = fetchMultiPValue("phonelnstalled.insertphonefeename",6,"&feetype="+tsd.encodeURIComponent(feetype)+"&feecode="+feecode+"&dh="+dh+"&ywlx=p_setup"+"&cztype=delete");	   	
					 if(result[0]!=undefined && result[0][0]!="")
					 {					 	
	        			
					 }else{
					 	//alert("删除杂费失败");
					 	alert($("#getinternet0011").val());
					 }
	        	}
	        	//删除时把左边的点击显示颜色清空掉，然后把隐藏值也清空掉
	        	$("#phonefeenamecode").val("");
        	    $("#phonefeename tr").css('background-color','#f7f7f7');
	        	//重新加载数据
	        	addspeediFeeType('');	        	
		    }
    </script>  
	</head>       
	<body onUnload="unLockDh()">      
		<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
		<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
		<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
		
		<!-- 固话费用隐藏值放此处点击新增按钮将其添加到临时表显示出来 --> 	
				<table style="display:none">
					<tr>
						<td>
						<input type="hidden" id="feecode" name="feecode" style="width: 150px;" disabled="disabled" /><!-- 费用代号 -->
						<input type="hidden" id="phonefeenamecode" name="phonefeename"/><!-- 子费用 -->
						<input type="hidden" id="feelv" name="feelv" style="width:150px" disabled="disabled" /><!-- 费率 -->
						<input type="hidden" id="TJfeelv" name="TJfeelv" style="width: 150px;" disabled="disabled" /><!-- 停机费率 -->
						<input type="hidden" id="ZFStartday" name="ZFStartday" style="width: 150px;" disabled="disabled" value="<%=Log.getSysTime() %>"/><!-- 起始时间 -->
						<input type="hidden" id="ZFEndday" name="ZFEndday" style="width: 150px;" disabled="disabled" value="2999-12-31"  /><!-- 终止时间 -->						
						<input type="hidden" id="CUNIT" name="CUNIT"/><!--最小计费单位-->
						<input type="hidden" id="stype" name="stype"/><!-- 0 - 按月； 1 - 按年 -->
						</td>	
					</tr>	
				</table>
		
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
							<td  width="15%" align="right" style="display:none;">
								是否跨区域
							</td>
							<td style="display:none;">
								<input type="checkbox" name="isk" id="isk" style="width:30px"" onClick="choiceMokuaiju()"/>
							</td>
						</tr>
					</table>
				</div>
				<div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/65.gif" />
						<fmt:message key="phone.getinternet0195" /><!-- 变更内容 -->
					</div>
					<div id="inputtext">
					    <table cellspacing="10px" id="BjAdressTable">
					       					       
					    </table>
					</div>
					
					
										<!--出帐月余额/出帐月欠费 -->
										<!-- 实施余额/实施欠费 -->
										<!-- 电话功能 -->
										<!-- 交换机编号 -->
										<!-- 停机标志 -->
				<!-- 	
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<span id="feetdhypetext"></span>
				</div>
				<div id="inputtext">
						<div class="midd">
							<br>
							<table>
								<tr>
									<td class="wenzi">
										<span id="spanyucunYE"></span>
									</td>
									<td>
										<input type="text" id="phoneBalance" name="phoneBalance"
											value="0" style="width: 150" disabled="disabled" />
									</td>
									<td class="wenzi">
										<span id="spanxinyueHF"></span>
									</td>
									<td>
										<input type="text" id="mothshuafei" name="mothshuafei"
											value="0" style="width: 150" disabled="disabled" />
									</td>
									<td class="wenzi">
										<span id="yhdang_tjbz"></span>
									</td>
									<td>
										<input type="text" id="Tjbz_yhdang" name="Tjbz_yhdang" style="width: 150"
											disabled="disabled" />
									</td>
								</tr>							
								<tr style="display:none">
									<td class="wenzi">
										<span id="spanDhgn"></span>
									</td>
									<td>
										&nbsp;<select name="Dhgn" id="Dhgn"
											style="width: 150"></select>
									</td>
									<td>
										<span id="spanJhj_IDx"></span>
									</td>
									<td>
										<input type="text" name="SwitchNumber" id="SwitchNumber"
											style="width: 150;display:none;" disabled="disabled" />
									</td>
									<td>
										<fmt:message key="phone.getinternet0181" />
									</td>
									<td>
										<select id="Tjbz_yhdang" name="Tjbz_yhdang"></select>							
									</td>
								</tr>
								<tr></tr>
							</table>
						</div>
					</div>
					
					 -->
					 
					<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0182" /><!-- 合同号信息显示-->&nbsp;<input type="checkbox" id="hthshowcheck" onClick="getshow()" style="width:15px;" />
					</div><br>
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
					</div><br>
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
				   
				   <div class="title">
                    &nbsp;&nbsp;
                    <img src="style/icon/65.gif" />
                    <fmt:message key="phone.getinternet0082" /><!-- 固定费 -->
                   </div>
                   <table>
                    <tr>
                        <td valign="top">
                          <table>
                            <tr>
                                <td class="wenzi" style="width:60px;line-height:30px;">
                                        <span id="spanFeeName"></span>
                                        <!-- 费用代号 -->
                                </td>
                                <td>
                                        <select name="phonefeetype" id="phonefeetype" style="width: 157px;"
                                            onchange="getfeename()"></select>                                       
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div style="width:220px; height: 160px; overflow-y: scroll; overflow-x: hidden;background-color:#f7f7f7;border:1px 1px solid #dddddd;">
                                            <table id="phonefeename" style="width:230px;" border="1" cellpadding="0"></table>
                                    </div>
                                </td>
                            </tr>
                          </table>
                         </td>
                         <td class="wenzi" style="width:45px;">
                            <table cellspacing="1">
                                <tr>
                                    <td width=1% style="margin-left: 0px;"></td>
                                </tr>                               
                                <tr>
                                    <td colspan="2"><center>
                                        <button class="tsdbutton" id="dhzfsave"
                                        onclick="insertphonefeename()"
                                        style="width:60px; height: 26px; margin-top: 3px; padding: 0px;">
                                        <fmt:message key="phone.getinternet0083" /><!-- 新增>> -->
                                        </button></center>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2"><center>
                                        <button class="tsdbutton" id="dhzfdel"
                                        onclick="deletephonefeename()"
                                        style="width:60px; height: 26px; margin-top: 3px; padding: 0px;">
                                        <fmt:message key="phone.getinternet0084" /><!-- 取消 -->
                                        </button></center>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top">                           
                            <table id="dzhthcontent"  style="width:490px;">
                                <tr>
                                    <th width="10"><input type="checkbox" id="dhzftab_checkall" onClick="Dhzf_CheckAll()" style="width:15px;" /></th>
                                    <th width="200">
                                        <center>
                                            <h4>
                                                <span id="spanFeeType_table"></span>
                                            </h4>
                                        </center>
                                    </th>
                                    <th width="60">
                                        <center>
                                            <h4>
                                                <span id="spanPrice_table"></span>
                                                <!-- 费率 -->
                                            </h4>
                                        </center>
                                    </th>
                                    <th width="100">
                                        <center>
                                            <h4>
                                                <span><fmt:message key="phoneyewu.starttime" /></span>
                                                <!-- 起始时间 -->
                                            </h4>
                                        </center>
                                    </th>
                                    <th width="100">
                                        <center>
                                            <h4>
                                                <span><fmt:message key="phoneyewu.termination" /></span>
                                                <!-- 终止时间 -->
                                            </h4>
                                        </center>
                                    </th>
                                    <%-- <th width="75">
                                        <center>
                                            <h4>
                                                数量
                                            </h4>
                                        </center>
                                    </th>
                                    <th width="75">
                                        <center>
                                            <h4>
                                                长度
                                            </h4>
                                        </center>
                                    </th> --%>
                                </tr>
                            </table>
                            <div style="width:500px; height: 165px; overflow-y: scroll; overflow-x: hidden;">
                            <table id="dhzftab" style="width:490px;">
                                
                            </table>                            
                            </div>
                        </td>
                     </tr>
                     <tr>
                        <td>
                        <div style="display:none;width: 420px; height: 20px; overflow-y: scroll; overflow-x: scroll; border-top: 1px solid gray; border-left: 1px solid gray;">
                        <table border="1" cellpadding="0" bordercolor="#9AC0CD"
                            id="addspeediFeetype">
                            
                        </table>
                        </div>
                      </td>
                     </tr>
                </table>
                <table cellspacing="8" id="ghfeeinput">
				</table>
                
                
                
				  <%-- <div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0186" /><!--包月套餐信息显示-->&nbsp;<input type="checkbox" id="byfeeshowcheck" onClick="getshow()" style="width:15px;" /><span id="byfeeTips" style="color:red"></span>
					</div>
				 <table border="1" cellpadding="0" bordercolor="#9AC0CD" id="dhBYTC" width="780">
				 </table> --%> 			  
				  <div class="title">
						&nbsp;&nbsp;						
						<img src="style/icon/65.gif" />
						<fmt:message key="phoneyewu.yewuggnmqr" /><!--业务更改内容确认--><span id="businesschangecontent" style="color:red;"></span>
				  </div>
				 <div id="inputtext2">
				 	<table cellspacing="0" width="760" id="businesschange">
				 		<tr>
				 			<td style="width:460px;">
				 				<table id="ffltab" style="width:460px;">
								<tr>
									<td class="wenzi" style="width:70px;">
										<%-- <fmt:message key="phone.getinternet0090" /> --%><!-- 付费方式 -->
									</td>
									<td class="wenzix">
										<select name="cPayType" id="cPayType" style="display:none;width: 150px" class="you1" onChange="payWayChange(this)"></select>
									</td>
									<td class="wenzi">
										<fmt:message key="phone.getinternet0091" /><!-- 应交合计 -->
									</td>
									<td class="wenzix">
										<input type="text" name="cYingJiao" id="cYingJiao" style="width: 130px;" disabled="disabled"  class="you1" onKeyPress="numValid(this)"
										onpaste="return !clipboardData.getData('text').match(/D/)" ondragenter="return   false"/>
								   </td>
								   <td>
								     <table id="dzhthcontent" style="width:320px;" border="1" cellpadding="0" bordercolor="#9AC0CD">
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
									<td colspan="4" id="ywslfeename">
									<fmt:message key="phone.getinternet0094" /><!-- 一次性费用 -->：
									<div
									style="width:440px; height: 105px; overflow-y: scroll; overflow-x: hidden; border-top: 1px solid gray; border-left: 1px solid gray;">
									<div id="feeItem_s" style="width: 100%; float: left;">
									</div>
									</div>
									</td>
									<td valign="top">
									<table id="businessfee" style="width:320px;" border="1" cellpadding="0" bordercolor="#9AC0CD">
									
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
		
		<!-- 2、3、4模块局 -->
		<div class="neirong" id="mokuaiju" style="display: none;width:850px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">项目名称</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right">
						<a href="javascript:;"
							onclick="javascript:exitmkj();">关闭</a>
					</div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
			
					<div class="midd" >
					   <form action="#" name="queryform" id="queryform" onSubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td  width="15%" align="right">
									同振2
								</td>
								<td>
									<select name='leveltwo' id="leveltwo" style="width: 120px;" onChange="checkmokuaiju(2)"></select>
								</td>
								<td  width="15%" align="right">
									同振3
								</td>
								<td>
									<select name='levelthree' id="levelthree" style="width: 120px;" onChange="checkmokuaiju(3)"></select>
								</td>
								<!-- 
								<td  width="15%" align="right">
									四级区域
								</td>
								<td>
									<select name='levelfour' id="levelfour" style="width: 120px;" onChange="checkmokuaiju(4)"></select>
								</td>
								-->
							</tr>
						</table>
						</form>
					</div>	
				
					<div class="midd_butt" style="width:830px">
							<button type="submit" class="tsdbutton" id="querythis" onClick="savemokuaiju()">
								确定
							</button>
							<button type="submit" class="tsdbutton" id="exitmkj" onClick="exitmkj()">
								关闭
							</button>
					</div>
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
						<fmt:message key="phone.getinternet0208" /><!--电话移机业务用户信息查询-->
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
	<input type="hidden" id="addressinputright"/>
	<input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->
	<input type="hidden" id="yjfeehidden"/><!-- 页面获取应缴费存入隐藏于中 -->
	<input type="hidden" id="fufeitypepath"/>
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->	
	<input type="hidden" id="stiffbusinestype" value="phoneDZ"/><!-- 电话工单打印类型 -->
	<input type="hidden" id="Prefeeval"/><!-- 预测金额打印票据时判断 -->
	<jsp:include page="phone_internet.jsp" flush="true"/>
	
	<!-- 后级模块局 -->
		<input type="hidden" id="mkj2"/>
		<input type="hidden" id="mkj3"/>
		<input type="hidden" id="mkj4"/>
	</body>
</html>