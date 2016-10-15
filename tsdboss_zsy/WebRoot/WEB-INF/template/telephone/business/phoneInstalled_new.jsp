<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/phoneInstalled.jsp
    Function:   电话装机
    Author:     wenxuming
    Date:       2010-10
    Description: 
    Modify: 
     2010-10月份 对该页面进行移植，并对版式进行修改；
     2010-11-03 把公用的CSS提取出来放到style/css/telephone/business/businesspublic.css；
     2010-11-05 添加“选择合同号”按钮权限，权限关键字“selecthth”；
     2010-11-08 提取js代码放到phoneinstalled.js文件中
-----------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
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
	/////////////////Java取当前时间
	String nowTime = Log.getSysTime("yyyy-MM");
	String nowTimeto = Log.getSysTime("yyyy-MM-dd");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>电话装机</title>			
		<meta http-equiv="description" content="this is my page" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css"/>
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<!--<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>-->
		<!--<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />-->
		<!-- dtree需要导入文件 -->
		<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css"/>	
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservice.js" type="text/javascript" language="javascript"></script>		
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
		<!--设置全局字体大小-->
		<link href="style/css/telephone/business/fontsize_all.css" rel="stylesheet" type="text/css"/>		
		<!-- 页面权限控制 -->
        <script type="text/javascript" src="script/public/tsdpower.js"></script>		        
		<script src="script/telephone/business/phoneInstalled_new_huos.js" type="text/javascript"></script>
		
		<!-- 打印报表弹出窗口 -->
		<script src="script/telephone/business/businessreprint.js" type="text/javascript" language="javascript"></script>	
		<script src="script/telephone/business/pkgPriceDiscount.js" type="text/javascript" language="javascript"></script>			
		<script src="plug-in/MultiSelect/jquery.bgiframe.min.js" type="text/javascript"></script>
		<script src="plug-in/MultiSelect/jquery.multiSelect.js" type="text/javascript"></script>			
		<link href="plug-in/MultiSelect/jquery.multiSelect.css" rel="stylesheet" type="text/css" />				
		<script src="script/telephone/business/jquery.jfontsize-1.0.js" type="text/javascript" language="javascript"></script>	
		<style type="text/css">
		#dqueryHTHdw tr td{line-height:22px;}
		#dqueryHTHdw tr th{line-height:25px;}
		#Paymenttable tr td{line-height:22px;}
		#selecththkey tr td{line-height:27px;};
		#querybmcontext tr td{line-height:25px;}
		#businessfee tr td{line-height:27px;}
		#bytctabs tr td{line-height:26px;}
		#dhzftab tr td{line-height:26px;}
		#hthzftab tr td{line-height:26px;}
		#querydjhthdh tr td{line-height:25px;}
		.wenzixtcz {width:125px;} 
		</style>
		<style type="text/css">
		#checkroutetype{
			width:400px;
			height:20px; 
		}
		</style>
		<!--
		<style>form,p,li,ul,ol,div,span,h1,h2,h3,h4,h5,td,input,select{ font-size:18px;font-weight:900;}</style>
		-->
		<script language="javascript">
		/*********
		* 初始加载
		* @param;
		* @return;
	    **********/
		 jQuery(document).ready(function(){		 		
		 		$("#navBar").append(genNavv());		    	
		    	lodingpage();//异步获取加载页面提示，其中包括加载数据等在此方法中完成phoneInstalled.jsp中
		    	getUserPower();//权限
		    	gettable();//默认加载固定费跟包月费显示框				
				getTFGN();
				$("#Tfgn_yhdang").multiSelect({ oneOrMoreSelected: '*'},'','checkroutetype','~');		
				getisnotZK();	
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
				//判断权限是否可以输入部门
				if($("#setNewBmright").val()=="true"){
						$("#setNewBm").removeAttr("disabled");
				}else{
						$("#setNewBm").attr("disabled","disabled");						
				}

				$('#hthYZcontext').jfontsize({
		              btnPlusClasseId: '#setHthvalue'
		        });
		        //根据电话类型获取固定费
		        $("#Dhlx").change(function(){
		        		getphonefeename($("#SwitchNumber").val());
		        		getfeename();
		        });
		       /* $("#usertype").change(function(){
		        	//根据用户类别如果为个人自动生成合同号
							if($("#usertype").val()=="2"){
								GenerateHth();
							}
		        });*/
		});	
			
		function lodingpage(){
			//$("#Messagevalues").text("页面加载中，请稍等…………");
			$("#Messagevalues").text($("#getinternet0069").val());
			var procparams;
			loadPopup();
			var status_succ = false;
			var result = new Array();
			var i = 0;
			var j = 0;
			$.ajax({
				url:"mainServlet.html?",
				async:true,
				cache:false,
				timeout:600000,
				type:'post',
				success:function(xml){
					$(xml).find("row").each(function(){
						result[i++] = new Array();
						$(this).find("cell").each(function(){
							result[i-1].push($(this).text());
						});
					});
					status_succ = true;
					internation();//字段名称国际化						
		    		disablePopup();
				},
				complete:function()
				{

				}
			});			
		}
		
		
		/**
		 * 显示等待
		 * @param 无参数
		 * @return 无返回值
		 */
		function showWait()
		{
			$("#loading").css("display","block");//loadPopup();
		}
		/**
		 * 隐藏等待
		 * @param 无参数
		 * @return 无返回值
		 */
		function hideWait()
		{
			$("#loading").css("display","none");//disablePopup();
		}
		/****
                *得到部门库中的第三级部门
                ****/
        function addsBmsanhth(){
          var sBM='';
          if($("#sBm2").val()==""){
                //alert("请选择二级部门");
                alert($("#getinternet0370").val());
                return false;
          }
          //$("#querysBmtitle").text("选择三级部门");
       //   $("#querysBmtitle").text($("#").val());
          autoBlockForm('querysBm',5,'close',"#ffffff",false);//弹出查询框
              $("#bmtypekey").val("Bm3");
              $("#querybmcontext").empty();
          var res = fetchMultiArrayValue("dbsql_phone.querysBm_code",6,"&code="+$("#sBm2code").val());
                if(res[0]==undefined || res[0][0]==undefined)
                        {
                                $("#querybmcontext").append("<tr><td>"+$("#getinternet0366").val()+"</td></tr>");
                                $("#sBm2code").val("");
                                $("#sbmname").val("");
                                return false;
                        }
                        $("#hth").val("");
            $("#Hth_hthdang").val("");
            //这里只正对装机来清空yhdang中的合同号，其他业务只操作合同号区域信息，所以不需要清空hthdang中的合同号；
                        if($("#businesstype").val()=="p_setup"){
                $("#Hth_yhdang").val("");
            }
                        for(var i=0;i<res.length;i++){
                                sBM += "<tr onClick=\"getbmname('"+res[i][1]+"');getbmcode('"+res[i][0]+"');\" id=\""+res[i][0]+"\"><td><center>";
                                sBM += res[i][1];
                                sBM += "</center></td></tr>";
                        }
                        $("#querybmcontext").append(sBM);
                        $("#querybmcontext tr").css("line-height","25");
                        $("#sbmname").val("");
        }
		/**
		 * 弹窗
		 * @param 无参数
		 * @return 无返回值
		 */
		var popupStatus = 0;
		function loadPopup(){
			centerPopup();
			//loads popup only if it is disabled
			if(popupStatus==0){
				$("#backgroundPopup").css({
					"opacity": "0.7"
				});
				$("#backgroundPopup").css("display","block");
				$("#loading").css("display","block");			
				popupStatus = 1;
			}
		}
		/**
		 * disablePopup
		 * @param 无参数
		 * @return 无返回值
		 */
		function disablePopup(){
			//disables popup only if it is enabled
			if(popupStatus==1){
				$("#backgroundPopup").fadeOut("slow");
				$("#loading").fadeOut("slow");
				popupStatus = 0;
			}
		}
		/**
		 * centering popup
		 * @param 无参数
		 * @return 无返回值
		 */
		function centerPopup(){
			//request data for centering
			var windowWidth = document.documentElement.clientWidth;
			var windowHeight = document.documentElement.clientHeight;
			var popupHeight = $("#loading").height();
			var popupWidth = $("#loading").width();
			//centering
			$("#loading").css({
				"position": "absolute",
				"top": windowHeight/2-popupHeight/2,
				"left": windowWidth/2-popupWidth/2
			});
			$("#backgroundPopup").css({
				"height": windowHeight
			});		
			
		}	
		
		/*
		function disclose(){
			var getphone = $("#getphone").val().replace(/(^\s*)|(\s*$)/g,"");
			var res = fetchMultiPValue("phonebatchinstall.check",6,"&pnums=" + getphone + "&uuserid=" + $("#userid").val() + "&uarea=" + encodeURIComponent($("#area").val()));
			<button class="tsdbutton" id="" style="height:28px; margin-top:3px; padding:0px;">检测</button>
		}*/					
		
		function getTFGN(){
	   		//clearMultiSelect_AABC();//清空多选下拉框
	   		var res = fetchMultiArrayValue("dbsql_phone.attachpriceTFGN",6,"",'business');
		 	if(res!=undefined&&res!=""){
		 		var str="<option value=''>--<fmt:message key="phone.getinternet0280" />--</option>";
			 	for(var j=0;j<res.length;j++){
			 		str+="<option value='"+res[j][0]+"'>"+res[j][0]+"</option>"
			 	}
			 	$("#Tfgn_yhdang").html(str);
		 	}else{
		 		$("#Tfgn_yhdang").html("<option value=''>--is null--</option>");
		 	}
		}				
		
		function getDhgcparam(){
			if($("#newDhgn").val()==""){
				alert("请选择呼出权限！");
				$("#newDhgn").select().focus();
				return;
			}
			var multistr='';
			//var mulselectoper = obj.rows[i].mulselectoper;
			$("[name='Tfgn_yhdang'][checked]").each(function(){
				multistr +=$(this).val()+",";			
			}) ; 
			//$("#Tfgn_yhdang").remove();
			//var len = multistr.lastIndexOf(mulselectoper);
			//if(len>0){multistr = multistr.substr(0,len);}
			$("#Dhgn_yhdang").val(multistr+$("#newDhgn").val());
			$("#newDhgn").val("");
			$("#tfgn_div").empty();
			$("#tfgn_div").append('<select id="Tfgn_yhdang" name="Tfgn_yhdang" style="width:400px;"></select>');	
			getTFGN();		
			$("#Tfgn_yhdang").multiSelect({ oneOrMoreSelected: '*'},'','checkroutetype','~');
			clearMultiSelect_AABC();			
		}
		
		//刷新查询费用项
        function refreshbusinessfee(){	
           $("#businessfee").empty();
           var temp='';
           var querysel="";
           var n=0;
           var res = fetchMultiArrayValue("dbsql_phone.querybusinessfee",6,"&userid="+tsd.encodeURIComponent($("#userloginid").val()));
           if(res[0]==undefined || res[0][0]==undefined)
           {
           		$("#Paymoney").val("");
           		for(var j=0;j<5-n;j++){
			   	   querysel+="<tr><th style='width:200px;'><center>";
			       querysel+="……";
			       querysel+="</center></th><th style='width:105px;'><center>"
			       querysel+="……";
			       querysel+="</center></th></tr>";	
			    }
			    $("#businessfee").append(querysel);
           		return false;
           }           
		   for(var i=0;i<res.length;i++)
		   {
		   	   temp += ",";
			   temp += res[i][0];
			   temp += "：";
			   temp += res[i][1];
			   temp += "元";
			   
		       querysel+="<tr><th style='width:200px;'><center>";
		       querysel+=res[i][0];
		       querysel+="</center></th><th style='width:105px;'><center>"
		       querysel+=res[i][1];
		       querysel+="</center></th></tr>";	
		       n++;				
		   }
		   for(var j=0;j<5-n;j++){
		   	   querysel+="<tr><th style='width:200px;'><center>";
		       querysel+="……";
		       querysel+="</center></th><th style='width:105px;'><center>"
		       querysel+="……";
		       querysel+="</center></th></tr>";	
		   }
		   temp = temp.replace(",","");
		   $("#Paymoney").val(temp);	
		   
		   $("#businessfee").append(querysel);
        }
        
        //月固定费生效方式
        function changeActivated(key){
        	if(key=="0"){
        		$("#ZFStartday").val($("#startdate").val());
        	}else{
        		$("#ZFStartday").val($("#startdatenextmonth").val());
        	}
        }
        
        function showBroadbandinfo(){
        
        	var phone=$("#getphone").val();
        	
        	if(phone!=undefined && phone!=""){
        		if(true == $("#broadbandinfo").attr("checked")){
	        		$("#tabbroadinfo").show();
	        		$("#baccount").val(phone);
	        		getDict();
	        		initBusiFee();
	        	}else{
	        		$("#tabbroadinfo").hide();
	        	}
        	}else{
        		alert("请先选择电话号码！");
        		$("#broadbandinfo").attr("checked","");
        		return;
        	}
        	
        }
        
        //加载接入类型、付费类型
		function getDict(){			         
	        $.ajax({
				url:"phone_querydate?func=query",
				async:true,//异步
				cache:false,
				timeout:20000,//1000表示1秒
				type:'post',
				success:function(xml,textStatus)
				{					
				    //取缴费方式 返回的是html格式
				    var radacc = xml.substring(xml.indexOf("<radacc=")+8,xml.indexOf("radacc/>"));				    
				    var sCallPayType = xml.substring(xml.indexOf("<CallPayType=")+13,xml.indexOf("CallPayType/>"));
				    
					$("#baccesstype").html(radacc);
					$("#bpaytype").html(sCallPayType);
				}		
			});
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
		 
		//根据选取的套餐，设置套餐金额输入框
		function setPkgFee(){	
			var sql="";
			var pkgid=$("#pkgid").val();
			if(pkgid!="" && pkgid!=undefined){
				var paytype=$("#bpaytype").val();
				if(paytype=='0' || paytype=='1'){
					sql="dbsql_rad.radpkgsetenddate_new2";
				}else{
					sql="dbsql_rad.radpkgsetenddate_new";
				}			
				var res = fetchMultiArrayValue(sql,6,"&pkgid="+pkgid+"","business");
				if(res!=undefined){
					if(res[0][2]!=0){
						$("#enddate").val(res[0][0].substring(0,10));
					}else{
						$("#enddate").val("2999-12-31");
					}					
				}else{
					$("#enddate").val("2999-12-31");
				}
				$("#txtregdate").val(res[0][1].substring(0,10));
				/*if ($("#chkpkgfee").attr("checked")){ 				
					if (res[0][5]!=undefined){
						$("#txtmoney").val(res[0][5]);
					}
					else{
						$("#txtmoney").val("0");
					} 	
				}
				else{
					$("#txtmoney").val("0");
				}*/
				if(paytype!=2){
					$("#txtmoney").val("0");
				}else{
					$("#txtmoney").val(res[0][5]);
					
					if(res[0][5]>0){
						var params='';
						params += "&fee="+res[0][5];
						params += "&feetype="+tsd.encodeURIComponent("宽带套餐费");
						params += "&userid="+tsd.encodeURIComponent($("#userloginid").val());
						var insertRes = executeNoQuery("dbsql_phone.addbusinessfee",6,params);
						if(insertRes=="true" || insertRes==true)
						{
							$("#businessfee").empty();
							$("#businessfeevalue :text").val("");								
							refreshbusinessfee();
						}else{
					     	//alert("添加数据失败");
					     	alert($("#getinternet0017").val());
					     	refreshbusinessfee();
					     	removecheckbusi();
						}
						querybusinessfee();
					}else{
						deletebusinessfee("宽带套餐费");
					
					}
					
					
				}
				$("#hiduints").val(res[0][2]);
				$("#hidfeerule").val(res[0][3]);
				$("#hidspeed").val(res[0][4]);
				$("#hidfirbilldate").val(res[0][6]);
				
				
				
			}else{
				$("#txtmoney").val("0");
				$("#txtBussFee").val('0');
				$("#txtregdate").val("");
				$("#enddate").val("");
				$("#hiduints").val("");
				$("#hidfeerule").val("");
				$("#hidspeed").val("");
				$("#hidfirbilldate").val("");
				
				
				deletebusinessfee("宽带套餐费");
				
			}
		}	
		//弹出业务费用选择面板，并根据选择项目返回相应费用
		function setbusifee(){ 					
			autoBlockFormAndSetWH('divbusifee',250,'345px','close',"#ffffff",false,'', '');
		}	
		
		var BusiFeeNames;
		var BusiFeeValues;
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
				//caclHJFee();   
			}
			setTimeout($.unblockUI,15);//关闭费用选择面板
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
		//取出宽带业务费 ywlx(业务类型)-如开户：r_setup
		function getBussFee(ywlx){
			var res = fetchMultiArrayValue('dbsql_rad.BussFee_New',6,"&ywlx="+ywlx,'business');		
			return res;
		}
		/********
        *电话验证装机保存调用过程ywsl_setup
        *@param;
       	*@return;
        ********/
        function Dhzj_Save()
        {
           //$("#Messagevalues").text("数据处理中，请稍等…………");
           $("#Messagevalues").text($("#getinternet0023").val());	           
           ///////////////////////////////////////////////////////////////////           
           tsd.QualifiedVal=true;
           var procparams = "";
           //选择开户类型为电话开户时所有信息都拼接参数，如果选择合同号开户str=2时 只拼接合同号信息 
		   var str = $("#selectinserttype").val();
		   //开户类型
		   var strkey='';
		   if(str=="1"){strkey='dhkh';}
		   procparams += "&cinstalledtype=";
		   procparams += tsd.encodeURIComponent(strkey);
		   if($("#Dhlx").val()==""&&str=='1'){
		   		//alert("请选择电话类型");
		   		alert($("#getinternet0024").val());
		   		$("#Dhlx").select();
		   		$("#Dhlx").focus();
		   		return false;
		   }
		   procparams += "&cdhlx=";
		   procparams += tsd.encodeURIComponent($("#Dhlx option:selected").text());
		   if($("#Bz4_yhdang").val()=="PBX连选"&&$("#Zlh_yhdang").val().replace(/(^\s*)|(\s*$)/g,"")==""){
				alert("请输入连选数量");   
				return;
			}
			if($("#Bz4_yhdang").val()=="PBX连选"&&$("#Zlh_yhdang").val().replace(/(^\s*)|(\s*$)/g,"")<=1){
						alert("选择连选号码时,连选数量必须大于1");
						return;
			}
           //电话合同号严重是否生成
           var cphonenum = $("#Dh_yhdang").val();
		    if(cphonenum!=undefined&&str=="1"){
				 cphonenum=cphonenum.replace(/(^\s*)|(\s*$)/g,"");
				 if(cphonenum==""){				 	
					$("#getphone").select();
					$("#getphone").focus();
					alert($("#getnullphone").val());
					return false;
				}
			}	
			//自身合同号
			var chth = $("#hth").val();
				if(chth=="")
				{
					$("#usertype").select();
					$("#usertype").focus();
					//alert("合同号不能为空,请生成或输入一个合同号");
					alert($("#getinternet0025").val());
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
			        		//alert("合同号信息中["+reszh[Dat.FieldName[i]]+"]不能为空!");
			        		alert($("#getinternet0026").val()+reszh[Dat.FieldName[i]]+$("#getinternet0027").val());
			        		$("#"+Dat.FieldName[i]+"_hthdang").select();
			        		$("#"+Dat.FieldName[i]+"_hthdang").focus();
			        		return false;
			        		break;
			        	}
		        	}
		        if(strhth==null){strhth="";}	
			 	procparams += "&"+Dat.FieldName[i]+"hth="+tsd.encodeURIComponent(strhth);
			 }
			 		/*
			 		var resgfhth = fetchSingleValue("dbsql_phone.queryhthdanghth",6,"&hth="+tsd.encodeURIComponent($("#Hth_hthdang").val()));
					if(resgfhth==undefined||resgfhth=='0')
					{
						//合同号一级部门
			        	//if($("#Yhlb_hthdang").val()=="公费"&&$("#sBm1").val()=="")
			        	if($("#Yhlb_hthdang").val()==$("#getinternet0384").val()&&$("#sBm1").val()=="")
			        	{
			        		//alert("当前用户类别为公费，必须选择一级部门");
			        		alert($("#getinternet0028").val());
			        		$("#sBm1").select();
			        		$("#sBm1").focus();
			        		return false;
			        	}
					}
					*/
		        	procparams += "&chthbm1=";
		        	procparams += tsd.encodeURIComponent($("#sBm1").val());
		        	//合同号二级部门
		        	var chthbm2 = $("#sBm2").val();
		        	procparams += "&chthbm2=";
					procparams += tsd.encodeURIComponent(chthbm2);
					//合同号三级部门        	
		        	var chthbm3 = $("#sBm3").val();
		        	procparams += "&chthbm3=";
					procparams += tsd.encodeURIComponent(chthbm3);
					//合同号二级部门        	
		        	var chthbm4 = $("#sBm4").val();
		        	procparams += "&chthbm4=";
					procparams += tsd.encodeURIComponent(chthbm4);
					var Email = $("#Email_hthdang").val();//邮件地址  
					if(Email!=undefined){
			        	Email=Email.replace(/(^\s*)|(\s*$)/g,"");	
						var emailRegExp = new RegExp("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
						if ((!emailRegExp.test(Email)||Email.indexOf('.')==-1)&&Email!=""&&$("#Email_hthdang").attr("disabled")!=true){
							//alert("合同号信息中邮件格式不正确！！！");
							alert($("#getinternet0029").val());
							$("#Email_hthdang").select();
							$("#Email_hthdang").focus();
							return false;
						}
					}	
					var IDCard = $("#IDCard_hthdang").val();		        	
		        	if(IDCard!=undefined){
			        	IDCard=IDCard.replace(/(^\s*)|(\s*$)/g,"");
			        	if($("#IDCard_hthdang").attr("disabled")!=true&&IDCard!=""&&!/((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65)[0-9]{4})(([1|2][0-9]{3}[0|1][0-9][0-3][0-9][0-9]{3}[X0-9])|([0-9]{2}[0|1][0-9][0-3][0-9][0-9]{3}))$/.test(IDCard)&&IDCard!=undefined)
		        		{
			        		//alert("合同号信息中请输入正确的身份证号码");
			        		alert($("#getinternet0030").val());
			        		$("#IDCard_hthdang").select();
			        		$("#IDCard_hthdang").focus();
			        		return false;
		        		}
		        	}		        				  
			 if(str=='1'){
				 var Dat = loadData_phoneinstalled("Yhdang",languageType,2);
				 var reszh = fetchFieldAlias('Yhdang',languageType);
				 for(var i=0;i<Dat.FieldName.length;i++){
				 	var stryhdang = $("#"+Dat.FieldName[i]+"_yhdang").val();
				 	if(stryhdang!=undefined){
				 		stryhdang = stryhdang.replace(/(^\s*)|(\s*$)/g,"");
				        	if(stryhdang==""&&Judgefield_yhdang(Dat.FieldName[i]+"_yhdang")==true&&$("#"+Dat.FieldName[i]+"_yhdang").attr("disabled")!=true)
				        	{
				        		//alert("用户档信息中["+reszh[Dat.FieldName[i]]+"]不能为空!");
				        		alert($("#getinternet0031").val()+reszh[Dat.FieldName[i]]+$("#getinternet0027").val());
				        		$("#"+Dat.FieldName[i]+"_yhdang").select();
				        		$("#"+Dat.FieldName[i]+"_yhdang").focus();
				        		return false;
				        		break;
				        	}
			        	}
			        if(stryhdang==null){stryhdang="";}		
				 	procparams += "&"+Dat.FieldName[i]+"yhdang="+tsd.encodeURIComponent(stryhdang);
				 }
				 var cDocumentsNumber = $("#Bz7_yhdang").val();
	        	 if(cDocumentsNumber!=undefined){
			        	cDocumentsNumber=cDocumentsNumber.replace(/(^\s*)|(\s*$)/g,"");
			        	if($("#Bz7_yhdang").attr("disabled")!=true&&$("#Bz6_yhdang").val()=='7' && cDocumentsNumber!="" && !/((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65)[0-9]{4})(([1|2][0-9]{3}[0|1][0-9][0-3][0-9][0-9]{3}[X0-9])|([0-9]{2}[0|1][0-9][0-3][0-9][0-9]{3}))$/.test(cDocumentsNumber))
			        	{
			        		//alert("固话信息中请输入正确的身份证号码");
			        		alert($("#getinternet0032").val());
			        		$("#Bz7_yhdang").select();
			        		$("#Bz7_yhdang").focus();
			        		return false;
			        	}
			     }
				

				//一级部门
				var csbm1=$("#sBm1").val();
	        	
				procparams += "&csbm1=";
	        	procparams += tsd.encodeURIComponent(csbm1);
	        	//二级部门        	
				var csbm2=$("#sBm2").val();
	        	procparams += "&csbm2=";
				procparams += tsd.encodeURIComponent(csbm2);						
	        	//三级部门        	
				var csbm3=$("#sBm3").val();
	        	procparams += "&csbm3=";
				procparams += tsd.encodeURIComponent(csbm3);
	
	        	//四级部门        	
				var csbm4=$("#sBm4").val();
	        	procparams += "&csbm4=";
				procparams += tsd.encodeURIComponent(csbm4);

		        //停机标志
		        var cTJLogo = $("#Tjbz_yhdang").val();
		        procparams += "&Tjbzyhdang=";
				procparams += tsd.encodeURIComponent('K');		        
		        //交换机编号
		        var cSwitchNumber = $("#SwitchNumber").val();
		        if(cSwitchNumber==""||cSwitchNumber==null||cSwitchNumber=="null"){cSwitchNumber='';}
		        procparams += "&Jhj_IDyhdang=";
				procparams += tsd.encodeURIComponent(cSwitchNumber);
				
				var resYZ = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&tablename=tsd_ini&cloum=tvalues&key=tsection='phonebusiness' and tident='selectMonthlyRent'"); 
				if(resYZ==""||resYZ==undefined||resYZ=="Y"){
					if(isXinYeWuExists(cphonenum)=="0")
					{
						//alert("至少应该添加一项月租费");
						alert($("#getinternet0034").val());
						$("#phonefeetype").select();
						$("#phonefeetype").focus();
						return false;
					}
				}

		       	//是否付费
		       	var jfufeicheckbox = $("#fufeicheckbox").attr("checked");        	        	
		       	//付费方式
		       	var jfufeitype = $("#fufeitype").val();
		       	procparams += "&jfufeitype=";
				procparams += tsd.encodeURIComponent(jfufeitype);
		       	//应缴费用
		       	var jyjfee = $("#yjfee").val();
		       	jyjfee=jyjfee.replace(/(^\s*)|(\s*$)/g,"");
		       	if(jyjfee==""){jyjfee=0;}
		       	procparams += "&jyjfee=";
				procparams += tsd.encodeURIComponent(jyjfee);
		       	//实收费用
		       	/*
		       	var jfflsjfy = $("#fflsjfy").val();
		       	jfflsjfy=jfflsjfy.replace(/(^\s*)|(\s*$)/g,"");
		       	if(jfflsjfy==""){jfflsjfy=0;}
		       	procparams += "&jfflsjfy=";
				procparams += tsd.encodeURIComponent(jfflsjfy);*/
		       	//缴费款项
		       	var jPaymoney = $("#Paymoney").val();
		       	procparams += "&jPaymoney=";
				procparams += tsd.encodeURIComponent(jPaymoney);
				jyjfee = parseFloat(jyjfee,10);
				//jfflsjfy = parseFloat(jfflsjfy,10);	
				if(jyjfee==0){jPaymoney="";}
				//if(jyjfee!=0&&jfflsjfy==0){alert("请输入实缴费用！");$("#fflsjfy").select();$("#fflsjfy").focus();return false;}	 			
		       	//联系人
		       	var jffllxh = $("#staff_ry").val();
		       	procparams += "&jffllxr=";
				procparams += tsd.encodeURIComponent(jffllxh);			
				//检测一次费用 (必填一项类)
				//if(!checkYCXFY()) return false;
		       	//联系电话
		       	var jffllxdh = $("#ffllxdh").val();
		       	procparams += "&jffllxdh=";        	
		       	//预存款
		       	var prechecked= $("#precheck").attr("checked");
			    if(prechecked){
			       	var Prefee = $("#Prefee").val();
			       	Prefee=Prefee.replace(/(^\s*)|(\s*$)/g,"");	        	
			       	var confee = $("#confee").val();
			       	confee=confee.replace(/(^\s*)|(\s*$)/g,"");	        	
			        if(Prefee.length==0){
			        	//alert("请输入预存金额");
			        	alert($("#getinternet0035").val());
			        	$("#Prefee").select();
			        	$("#Prefee").focus();
			        	return false;
			        }	        	
			        if(confee.length==0){
			        	//alert("请输入确认金额");
			        	alert($("#getinternet0036").val());
			        	$("#confee").select();
			        	$("#confee").focus();
			        	return false;
			        }
			        if(Prefee!=confee){
			        	//alert("预存金额与确认金额不一致！");
			        	alert($("#getinternet0037").val());
			        	$("#confee").select();
			        	$("#confee").focus();
			        	return false;
			        }
			        Prefee=parseFloat(Prefee,10);
			        confee=parseFloat(confee,10);
			        var patrn=/^-?\d+\.{0,}\d{0,}$/; 
					 if (!patrn.exec(Prefee)){
					 	//alert("请输入正确的金额！");
					 	alert($("#getinternet0038").val());
					 	$("#Prefee").select();
					 	$("#Prefee").focus();
					 	return false;
					 }
					procparams += "&ycfee=";
					procparams += tsd.encodeURIComponent(Prefee);
					procparams += "&sfyc=";
					procparams += tsd.encodeURIComponent('Y');  
		        	}
		        //备注
		        var tBZZZ = $("#tBz").val();
		        procparams += "&zwbz=";
				procparams += tsd.encodeURIComponent(tBZZZ);
			}
			
			
			//取出所有项目的值，若有可能包含中文的，都做下编码转换		
			var v_acct = $("#baccount").val();//宽带账号  
			if(v_acct=="" || v_acct==undefined){
				alert("请填写宽带账号！");
				$("#baccount").focus();
				return;			
			}
			var v_pwd = $("#bpasswd").val();//密码
			if(v_pwd=="" || v_pwd==undefined){
				alert("请填写上网密码！");
				$("#bpasswd").focus();
				return;			
			}
			var v_cpwd = $("#bcpasswd").val();//确认密码
			if(v_cpwd=="" || v_cpwd==undefined){
				alert("请填写确认密码！");
				$("#bcpasswd").focus();
				return;			
			}
			if(v_pwd!=v_cpwd){
				alert("确认密码与密码输入不一致，请重新填写！");
				$("#baccount").focus();
				$("#bcpasswd").focus();
				return;					
			}
			
			var v_callpaytype=$("#bpaytype").val();//付费类型
			if(v_callpaytype=="" || v_callpaytype==undefined || v_callpaytype=="-1" || v_callpaytype=="0"){
				alert("请选择付费类型！");
				$("#bpaytype").focus();
				return;			
			}
			var v_acc = $("#baccesstype").val();//接入类型
			if(v_acc=="" || v_acc==undefined || v_acc=="-1" || v_acc=="0"){
				alert("请选择接入类型！");
				$("#baccesstype").focus();
				return;			
			}
			var v_pkgid = $("#pkgid").val();//套餐编号
			if(v_pkgid=="" || v_pkgid==undefined || v_pkgid=="-1" || v_pkgid=="0"){
				alert("请选择上网套餐!");
				$("#pkgid").focus();
				return;			
			}
			
			
			//工号
			var uuserid = $("#userid").val();
			procparams += "&uuserid=";
			procparams += tsd.encodeURIComponent(uuserid);
			//部门
			var udepart = $("#depart").val();
			procparams += "&udepart=";
			procparams += tsd.encodeURIComponent(udepart);
			//营业区域
			var userareaid = $("#userareaid").val(); 			
			procparams += "&userarea=";
			procparams += tsd.encodeURIComponent(userareaid);
			//区域营业厅
			var uarea = $("#area").val();
			procparams += "&uarea=";
			procparams += tsd.encodeURIComponent(uarea);	
			procparams +="&fsbm="+$("#fsbm").val();	
			
			var loginfo = $("#getinternet0385").val();
			loginfo += $("#getinternet0103").val();
			loginfo += $("#Dh_yhdang").val();
			loginfo += $("#getinternet0100").val()+":";
			loginfo += $("#Hth_hthdang").val();
			loginfo += $("#getinternet0074").val()+":";
			loginfo += $("#Yhlb_hthdang").val();
			loginfo += $("#getinternet0112").val()+":";
			loginfo += $("#Yhmc_yhdang").val();
			loginfo += $("#getinternet0341").val()+":";
			loginfo += $("#Yhdz_yhdang").val();
			loginfo = tsd.encodeURIComponent(loginfo);
			
			procparams+="&ywbz="+loginfo;
			if(tsd.Qualified()==false){return false;}	
			$("#selectinserttype").select();
			$("#selectinserttype").focus();
			//var result = fetchMultiPValue("phoneInstall.setup",6,procparams);
			//$("#Messagevalues").text("数据处理中，请稍等…………");
			$("#Messagevalues").text($("#getinternet0023").val());
			loadPopup();
			var status_succ = false;
			var result = new Array();
			var i = 0;
			var j = 0;
			var urll = tsd.buildParams({ packgname:'service',
						clsname:'Procedure',//类名
						method:'exequery',//方法名
						ds:'tsdBilling',
						tsdExeType:'query',//操作类型 
						datatype:'xml',//返回数据格式 
						tsdpname:'phoneInstall.setup'						
				});
//alert("==="+procparams);
			//执行发布请求，成功之后调用initResultInfo()方法显示结果
			$.ajax({
				url:"mainServlet.html?" + urll + procparams,
				async:true,
				cache:false,
				timeout:600000,
				type:'post',
				success:function(xml){
					$(xml).find("row").each(function(){
						result[i++] = new Array();
						$(this).find("cell").each(function(){
							result[i-1].push($(this).text());
						});
					});
					status_succ = true;
					if(result[0]==undefined || result[0][0]==undefined || result[0][0]=="")
					{
						//alert("开户失败");
						alert($("#getinternet0039").val());
						disablePopup();
					}
					else
					{
						//从procreturn表中查询失败原因
						var returnStr = result[0][1];
						if(returnStr==""||returnStr==null||returnStr==undefined){returnStr="00000000";}
						var resto = fetchSingleValue("dbsql_phone.procreturn",6,"&pname=ywsl_setup&key="+tsd.encodeURIComponent(returnStr));
						var languageType = $("#languageType").val();
						var strreutrn = getCaption(resto,languageType,"");
						strreutrn = strreutrn.replace("?hth?",$("#Hth_hthdang").val());
						 if(str=="1"){
						 	if(result[0][0]=='FAILED'){
						 		if(strreutrn==""){
						 			alert(result[0][1]);
						 			return false;
						 		}else{
						 			alert(strreutrn);
						 			return false;
						 		}
						 	}
						 	if(result[0][1]!=""&&result[0][1]!="SUCCSESS"){
						 		//alert(result[0][1]);
								loginfo+=tsd.encodeURIComponent(result[0][1]);
							}
							$("#jobidid").val(result[0][0]);
							//宽带装机操作
							if($("#broadbandinfo").attr("checked")){
					 			savedb();
					 		}else{
					 			alert(result[0][1]);
					 		}
					 		disablePopup();
							$("#ppaytype").val($("#fufeitype").val());//将付费方式付给隐藏于，打印报表会使用很关键
							$("#fee").val($("#yjfee").val());
							$("#Prefeeval").val($("#Prefee").val());
							writeLogInfo("","add",loginfo);
							//判断是否打印工单，从tsd_ini表中配置Y为打印
							printworkorder('p_setup');//script/telephone/business/businessreprint.js中
						}else{
							disablePopup();
							if(result[0][0]=='FAILED'){
								if(strreutrn==""){
									alert(result[0][1]);
								}else{
									alert(strreutrn);
								}
						 		return false;
						 	}
						 	$("#jobidid").val(result[0][0]);
							autoBlockForm("choosePrintJob","150","close","#FFFFFF",false);
						}
					}
					unLockDh();
					$("#currentHthSaved").val("N");
					$("#currentHthFirstOpen").val("Y");
					$("#currentCheckedHthBox").val("shhth");
					$("#StartDate_yhdang").attr("disabled","disabled");
					$("#EndDate_yhdang").attr("disabled","disabled");
					$("#Reg_Date").attr("disabled","disabled");
					Dhzj_Reset();					
				},
				complete:function()
				{
					if(!status_succ)
					//alert("操作失败");
					alert($("#getinternet0040").val());
					unLockDh();
					$("#currentHthSaved").val("N");
					$("#currentHthFirstOpen").val("Y");
					$("#currentCheckedHthBox").val("shhth");
					$("#StartDate_yhdang").attr("disabled","disabled");
					$("#EndDate_yhdang").attr("disabled","disabled");
					$("#Reg_Date").attr("disabled","disabled");
					Dhzj_Reset();
					$("#broadbandinfo").attr("checked","");
					$("#tabbroadinfo").hide();
					disablePopup();
				}
			});	
        }   
		
		//调用宽带开户的后台存储过程
		function savedb(){  
			//取出所有项目的值，若有可能包含中文的，都做下编码转换		
			var v_acct = tsd.encodeURIComponent($("#baccount").val());//宽带账号        	
			var v_pwd = tsd.encodeURIComponent($("#bpasswd").val());//密码
			var v_callpaytype=$("#bpaytype").val();//付费类型
			var v_acc = tsd.encodeURIComponent($("#baccesstype").val());//接入类型
			var v_pkgid = $("#pkgid").val();//套餐编号
			var v_pkgfee = $("#txtmoney").val();//套餐费用
			var v_busifee = $("#txtBussFee").val();//业务费
			
			var v_dh = $("#getphone").val();//绑定电话
			var v_user = tsd.encodeURIComponent($("#Yhmc_yhdang").val());//用户名称
			var v_yhlb = tsd.encodeURIComponent($("#usertype :selected").text());//用户类别
			var v_yhxz = tsd.encodeURIComponent($("#Yhxz_hthdang :selected").text());//用户性质
			var v_addr = tsd.encodeURIComponent($("#Yhdz_yhdang").val());//用户地址
		
			var v_bm1 = tsd.encodeURIComponent($("#sBm1").val());//一级部门
			var v_bm2 = tsd.encodeURIComponent($("#sBm2").val());//二级部门
			var v_bm3 = tsd.encodeURIComponent($("#sBm3").val());//三级部门
			var v_bm4 = tsd.encodeURIComponent($("#sBm4").val());//四级部门
			var v_cardtype="";//证件类型
			if($("#Bz6_yhdang").val()!=""){
				v_cardtype = tsd.encodeURIComponent($("#Bz6_yhdang option:selected").text());	
			}        	
			var v_cardid = tsd.encodeURIComponent($("#Bz7_yhdang").val());//证件编号
			var v_lxr = tsd.encodeURIComponent($("#Bz8_yhdang").val());//联系人
			var v_lxdh = $("#Bz8_yhdang").val();//联系电话
			var v_yddh ="";//移动电话
			var v_userarea = tsd.encodeURIComponent($("#txtuserarea").val());//用户区域     	
			var v_bz = tsd.encodeURIComponent($("#txtmemo").val());//资料备注
			var v_paytype = $("#bpaytype").val();//付费类型
			var v_workmemo = tsd.encodeURIComponent($("#workmemo").val());//操作备注 
			var busiywarea = tsd.encodeURIComponent($("#area").val());//业务区域
			var enddate = $("#enddate").val();//到期日期
		
			var busitype = "setup";//业务类型
			var userid = tsd.encodeURIComponent($("#userloginid").val());//操作工号
			var department = tsd.encodeURIComponent($("#depart").val());//部门
			var busiarea = tsd.encodeURIComponent($("#area").val());//受理区域 
		
		
			var param="&userid="+userid+"&busitype="+busitype+"&department="+department+"&busiarea="+busiarea+"&BusiFeeNames="+BusiFeeNames+"&BusiFeeValues="+BusiFeeValues+"&internetacct="+v_acct+"&pwd="+v_pwd+"&username="+v_user+"&useraddr="+v_addr+"&bm1="+v_bm1+"&bm2="+v_bm2+"&bm3="+v_bm3+"&bm4="+v_bm4
			+"&usertype="+v_yhlb+"&userattr="+v_yhxz+"&pkgid="+v_pkgid+"&paytype="+v_paytype+"&callpaytype="+v_callpaytype
			+"&cardtype="+v_cardtype+"&cardid="+v_cardid+"&mobile="+v_yddh+"&linkphone="+v_lxdh+"&userarea="+v_userarea
			+"&linkman="+v_lxr+"&dh="+v_dh+"&accesstype="+v_acc+"&usermemo="+v_bz+"&pkgfee="+v_pkgfee+"&busifee="+v_busifee+"&workmemo="+v_workmemo+"&busiywarea="+busiywarea+"&newenddate="+enddate+"&firbilldate="+$("#hidfirbilldate").val();
		
			param=param+"&acctstarttime="+$("#txtregdate").val()+"&acctstarttime="+$("#txtregdate").val()+"&speed="+$("#hidspeed").val()+"&autoband="+$("#autobandtype").val();
			var authparam="&busitype=setup&username="+v_acct+"&pwd="+v_pwd+"&acctstarttime="+$("#txtregdate").val()+"&acctstoptime="+$("#enddate").val()+"&speed="+$("#hidspeed").val()+"&autoband="+$("#autobandtype").val();
			
			var res = fetchMultiPValue("rad_busi",6,param);
			if(res[0][0]=="SUCCEED"){
				alert("开户成功！");			
				$("#broadbandinfo").attr("checked","");
				$("#tabbroadinfo").hide();
			}else if(res[0][0]=="FAILED"){
				if(res[0][1]!=""){
					alert(res[0][1]);
					return;
				}else{
					alert("宽带开户失败！请与系统管理员联系。");
					return;
				}
			}
			
		}
		
		</script>
		<style type="text/css">
			label{float:right;text-align:left;margin-left:0px;}
			#loading{
				display:none;
				position:fixed;
				_position:absolute; /* hack for internet explorer 6*/
				height:200px;
				width:408px;
				text-align:center;
				background:#FFFFFF;
				border:2px solid #cecece;
				z-index:2;
				padding:12px;
				font-size:13px;
			}
			#backgroundPopup{
				display:none;
				position:fixed;
				_position:absolute; /* hack for internet explorer 6*/
				height:100%;
				width:100%;
				top:0;
				left:0;
				background:#ffffff;
				border:1px solid #cecece;
				z-index:1;
			}
		</style>
	</head>	
	<body onunload="unLockDh()">
			<div id="loading">
				<div style="height:80px"></div>
				<img src="style/images/public/loading.gif" />
				<br />
				<span id="Messagevalues"></span><!-- 加载提示信息 -->
		  		</div>
	  		<div id="backgroundPopup"></div>	
		<div id="navBar1">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar" style="float: left">
							<img src="<%=iconpath %>dot11.gif" style="margin-left: 10px" />
							<fmt:message key="global.location" />
							：
						</div>
					</td>
					<td width="20%" align="right" valign="top">
						<div id="d2back">
							<a href="javascript:void(0);"
								onclick="parent.history.back(); return false;"><fmt:message key="gjh.houtuei" /> </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
					<fmt:message key="phoneyewu.ghhdatx" />
					<!-- 固话号档案填写 -->
				</div>
				<div id="inputtext">
				  <table>
				  	<tr>
				  	<td>
					<table cellspacing="5">
						<tr>
						   <td>&nbsp;<fmt:message key="phone.getinternet0070" /><!-- 开户类型 --></td>
						   <td><select id="selectinserttype" style="width:100px;" onchange="selectinserttype()">
						   		<option value="1"><fmt:message key="phone.getinternet0071" /><!-- 电话开户 --></option>
						   		<option value="2"><fmt:message key="phone.getinternet0072" /><!-- 合同号开户 --></option>
						   		</select>
						   	</td>
						</tr>
					</table>
					</td>
					<td>
					<table cellspacing="3" id="phone_querynumber">
						<tr>
							<td id="dhlxname"><fmt:message key="phone.getinternet0073" /><!-- 电话类型 --></td>
						   	<td><select id="Dhlx" style="width:100px;"></select></td>
							<td id="usertypetdid">
								<fmt:message key="phone.getinternet0074" /><!-- 用户类别 -->
							</td>
							<td>
								<select name="usertype" id="usertype" style="width: 110px;" onchange="javascript:$('#hth').val('');$('#Hth').val('');$('#UserType_yhdang').val('');$('#Yhxz').val('');$('#Hth_yhdang').val('');removenullhthcontent();"></select>								
							</td>
							<td id="dhnumber">
								<span id="spangetdh"></span>
								<!-- 电话号码 -->
							</td>
							<td align="left">
								<input type="text" name="getphone" id="getphone" style="width: 100px;" />
							</td>
							<td>
								<button class="tsdbutton" id="getKonghao"
									onclick="c_p_konghaoDialog()"
									style="width:60px;height: 28px; margin-top: 3px; padding: 0px;">
									<fmt:message key="phoneyewu.getkonghao" />
									<!-- 获取空号 -->
								</button>
							</td>
						</tr>
					</table>
					</td>
					</tr>
					</table>
						<table cellspacing="4" id="geththsbm" style="display: none;">
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
						<hr style="border: 1px dotted #CCCCCC;" />
					<table cellspacing="3" id="seththtitle">
						<tr>							
							<td>
								&nbsp;&nbsp;<fmt:message key="phone.getinternet0076" /><!-- 合&nbsp;同&nbsp;号 -->&nbsp;
							</td>
							<td>
								<input type="text" name="hth" id="hth" style="width: 180px;"
									disabled="disabled" />
								<input type="hidden" name="gfhth" id="gfhth" />
							</td>
							<td>
								<button class="tsdbutton" id="setHth" 
									onclick="GenerateHth();" 
									style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
									<fmt:message key="phone.getinternet0077" /><!-- 生成合同号 -->
								</button>
							</td>
							<td>
								<button class="tsdbutton" id="inputHth" 
									onclick="InputHth();" 
									style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
									<fmt:message key="phone.getinternet0078" /><!-- 输入合同号 -->
								</button>
							</td>
							<td>
								<button class="tsdbutton" id="setselectHth" 
									onclick="selecthth()" 
									style="height: 28px;width:70px; margin-top: 3px; padding: 0px;" disabled="disabled">
									<fmt:message key="phone.getinternet0079" /><!-- 选择合同号 -->									
								</button>
							</td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<button class="tsdbutton" id="setHth" 
									onclick="GenerateHth()"
									style="height: 28px; margin-top: 3px; padding: 0px;display:none;">
									生成新合同号
									<!-- 设置单位合同号 -->
								</button>
								<button class="tsdbutton" id="setDJHth" 
									onclick="setDJHTH()" 
									style="height: 28px; margin-top: 3px; padding: 0px;">
									<fmt:message key="phoneyewu.setdjhth" />
									<!-- 设置代缴合同号 -->
								</button>
							</td>
						</tr>	
					</table>
				</div>				
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0080" /><!-- 合同号信息 -->
				</div>
				<div id="inputtext">
					<div class="midd">
						<table id="tablehthdang"  style="border:1px solid #dddddd;width: 780px;">
						</table>						
					</div>
				</div>
				<div id="div_content">
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0081" /><!-- 固话信息 -->
					<button class='tsdbutton' id='setHthvalue' onclick='getPublicfield();' style='height: 28px; margin-top: 3px; padding: 0px;'><fmt:message key="phone.getinternet0364" /><!-- 同步到固话信息 --></button>	
				</div>
				<div id="inputtext">
					<div class="midd">
						<table id="tableyhdang"  style="border:1px solid #dddddd;width: 780px;">
							<tr style="display:none">
								<td class="wenzi">
									<span id="spanyucunYE"></span>
									<!-- 话费余额 -->
								</td>
								<td>
									<input type="text" id="phoneBalance" name="phoneBalance"
										value="0" style="width: 150" disabled="disabled" />
								</td>
								<td class="wenzi">
									<span id="spanxinyueHF"></span>
									<!-- 当前月话费 -->
								</td>
								<td>
									<input type="text" id="mothshuafei" name="mothshuafei"
										value="0" style="width: 150" disabled="disabled" />
								</td>
								<td class="wenzi">
									<span id="spanTjbz"></span>
									<!-- 停机标志 -->
								</td>
								<td>
									<input type="text" id="TJLogo" name="TJLogo" style="width: 150"
										disabled="disabled" />
								</td>
							</tr>
							<tr style="display:none">
								<td class="wenzi">
									<span id="spanDhgn"></span>
									<!-- 电话功能 -->
								</td>
								<td>
									&nbsp;<select name="Dhgn" id="Dhgn"
										style="width: 150px;"></select>
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
						</table>
					</div>
				</div>
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0082" /><!-- 固定费 -->
				</div>
				<table style="border:1px solid #A9C8D9;">
					<tr>
				 	 	<td valign="top">				 	 	    
				 	 		<table id="dzhthcontent"  style="width:780px;">
				 	 			<tr>
									<th width="10"><input type="checkbox" id="dhzftab_checkall" onclick="Dhzf_CheckAll()" style="width:15px;" /></th>
									<th width="90">
										<center>
											<h4>
												<span id="spanFeeName1">费用名称</span>
											</h4>
										</center>
									</th>
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
									<th width="75" style="display: none;">
										<center>
											<h4>
												数量
											</h4>
										</center>
									</th>
									<th width="75" style="display: none;">
										<center>
											<h4>
												长度
											</h4>
										</center>
									</th>
								</tr>
				 	 		</table>
				 	 		<div style="width:780px; overflow-y: scroll; overflow-x: hidden;">
				 	 		<table id="dhzftab" style="width:770px;">

							</table>							
							</div>
				 	 	</td>
					</tr>
					<tr>
						<td valign="top">
						  <table style="width:780px;border-top: 1px solid #A9C8D9;">
						  	<tr>
						  		<td class="wenzi" style="width:90px;line-height:30px;">
									<span id="spanFeeName"></span>
										<!-- 费用代号 -->
								</td>
								<td class="wenzi" style="width:170px;line-height:30px;">
									<select name="phonefeetype" id="phonefeetype" style="width: 157px;"
											onchange="getfeename()"></select>										
								</td>
								<td class="wenzi" style="width:90px;line-height:30px;">
									<span id="spanFeeChild">子类型</span>
										<!-- 费用代号 -->
								</td>
								<td class="wenzi" style="width:170px;line-height:30px;">
									<select name="phonefeechildtype" id="phonefeechildtype" style="width: 157px;"
											onchange="getGHfeetr(this.value);"></select>									
								</td>
								<td class="wenzi" style="width:90px;line-height:30px;">
									<span id="spanPrice"></span>
										<!-- 费用代号 -->
								</td>
								<td class="wenzi">
									<input name="phonefeeprice" id="phonefeeprice" disabled="disabled" style="width: 157px;"></input>										
								</td>
							</tr>
							<tr>
								<td class="wenzi" style="width:90px;line-height:30px;">
									启用日期
								</td>
								<td class="wenzi" style="width:170px;line-height:30px;">
									<input type='text' id='ZFStartday' name='ZFStartday' style='width: 153px;' disabled='disabled'/>
								</td>
						  		<td class="wenzi" style="width:170px;line-height:30px;">截止日期</td>
								<td class="wenzi" style="width:170px;line-height:30px;">
									<input type='text' id='ZFEndday' name='ZFEndday' style='width: 153px;' disabled='disabled' value='2999-12-31'  />										
								</td>
								<td class="wenzi" style="width:170px;line-height:30px;"></td>
								<td class="wenzi">
																		
								</td>
							</tr>
							<tr style="border: 1px solid #fff;">
								<td style="width:70px;">
										<button class="tsdbutton" id="dhzfsave"
										onclick="insertphonefeename()"
										style="width:60px; height: 26px; padding: 0px;">
										<fmt:message key="phone.getinternet0083" /><!-- 新增>> -->
										</button>
								</td>
								<td style="width:70px;">
										<button class="tsdbutton" id="dhzfdel"
										onclick="deletephonefeename()"
										style="width:60px; height: 26px; padding: 0px;">
										<fmt:message key="global.delete" /><!-- 删除 -->
										</button>										
								</td>
								<td colspan="3"></td>
							</tr>
							
						  </table>
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
						<input type="hidden" id="DEVNUM" name="DEVNUM"/><!--最小计费单位-->
						<input type="hidden" id="DEVLENGTH" name="DEVLENGTH"/><!--最小计费单位-->
						</td>	
					</tr>	
				</table>
								
				<!--合同号月租-->
				<table id="hthYZcontext">
					<tr>
						<td valign="top">
						  <table>
						  	<tr>
						  		<td class="wenzi" style="width:60px;line-height:30px;">
										合同号月租
								</td>
								<td>
									<select name="phonefeetype_hth" id="phonefeetype_hth" style="width: 150px;" onchange="getfeename_hth()"></select>
								</td>
							</tr>
							<tr>
								<td colspan="2">
						  			<div style="width:210px; height: 130px; overflow-y: scroll; overflow-x: hidden;background-color:#f7f7f7;border:1px 1px solid #dddddd;">
											<table id="phonefeename_hth" style="width:230px;" border="1" cellpadding="0"></table>
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
										onclick="insertphonefeename_hth()"
										style="width:60px; height: 26px; margin-top: 3px; padding: 0px;">
										<fmt:message key="phone.getinternet0083" /><!-- 新增>> -->
										</button></center>
				  					</td>
				  				</tr>
				  				<tr>
				  					<td colspan="2"><center>
				  						<button class="tsdbutton" id="dhzfdel"
										onclick="deletephonefeename_hth()"
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
									<th width="10"><input type="checkbox" id="hthzftab_checkall" onclick="hthZf_CheckAll()" style="width:15px;" /></th>
									<th width="200">
										<center>
											<h4>
												子类型
											</h4>
										</center>
									</th>
									<th width="60">
										<center>
											<h4>
												价格
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
									<th width="140">
										<center>
											<h4>
												数量
											</h4>
										</center>
									</th>
								</tr>
				 	 		</table>
				 	 		<div style="width:500px; height: 135px; overflow-y: scroll; overflow-x: hidden;">
				 	 		<table id="hthzftab" style="width:490px;">

							</table>							
							</div>
				 	 	</td>
					 </tr>
					 <tr>
					 	<td>
					 	<div style="display:none;width: 420px; height: 20px; overflow-y: scroll; overflow-x: scroll; border-top: 1px solid gray; border-left: 1px solid gray;">
						<table border="1" cellpadding="0" bordercolor="#9AC0CD"
							id="addspeediFeetype_hth">
							
						</table>
					    </div>
					  </td>
					 </tr>
				</table>
				<table cellspacing="8" id="hthfeeinput">
				</table>
				<!-- 固话费用隐藏值放此处点击新增按钮将其添加到临时表显示出来 --> 	
				<table style="display:none">
					<tr>
						<td>
						<input type="hidden" id="feecode_hth" name="feecode" style="width: 150px;" disabled="disabled" /><!-- 费用代号 -->
						<input type="hidden" id="phonefeenamecode_hth" name="phonefeename"/><!-- 子费用 -->
						<input type="hidden" id="feelv_hth" name="feelv_hth" style="width:150px" disabled="disabled" /><!-- 费率 -->
						<input type="hidden" id="Subtype_hth" name="Subtype_hth" />
						<input type="hidden" id="ZFStartday_hth" name="ZFStartday" style="width: 150px;" disabled="disabled" value="<%=Log.getSysTime() %>"/><!-- 起始时间 -->
						<input type="hidden" id="ZFEndday_hth" name="ZFEndday" style="width: 150px;" disabled="disabled" value="2999-12-31"  /><!-- 终止时间 -->						
						</td>	
					</tr>	
				</table>
				
				
				<!-- 				
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					优惠套餐				
				</div> -->
				<div id="inputtext1" style="display:none">
					<table id="bytctab" style="width:760px;">
						<tr>
							<th width="10"><input type="checkbox" id="bytctab_checkall" onclick="Bytc_CheckALL()" style="width:15px;" /></th>
							<th width="170">
								<center>
									<h4>
										<span id="spanTCFN_table">费用名称</span>
										<!-- 费用名称 -->
									</h4>
								</center>
							</th>
							<th width="240">
								<center>
									<h4>
										<span id="spanTCLX_table">套餐类型</span>
										<!-- 套餐类型 -->
									</h4>
								</center>
							</th>
							<th width="140">
								<center>
									<h4>
										<span id="spanTCQSY_table">起始时间</span>
										<!-- 起始月 -->
									</h4>
								</center>
							</th>
							<th width="140">
								<center>
									<h4>
										<span id="spanTCZZY_table">终止时间</span>
										<!-- 终止月 -->
									</h4>
								</center>
							</th>
							<th width="140">
								<center>
									<h4>
										<span id="spanTCYS_table">月数</span>
										<!-- 月数 -->
									</h4>
								</center>
							</th>
						</tr>
					</table>
					<div
						style="display:none;width: 610px; height: 130px; overflow-y: scroll; overflow-x: scroll; border-top: 1px solid gray; border-left: 1px solid gray;">
						<table border="1" cellpadding="0" bordercolor="#9AC0CD"
							id="addspeediFeetype">
						</table>
					</div>
					
					<table id="bytcform" cellspacing="0" style="width:760px;">
						<tr>
							<td class="wenzi" style="line-height:30px;">
								优惠套餐
							</td>
							<td class="wenzix">
								<select name="Packagetype" id="Packagetype" style="width: 150px;"></select>
							</td>
							<td class="wenzi">
								起始时间
							</td>
							<td class="wenzix">
								<input type="text" name="TCStarttime" id="TCStarttime" disabled="disabled" 
									style="width: 150px;"  value="2999-12-31" />
							</td>
							<td class="wenzi">
								终止时间
							</td>
							<td class="wenzix">
								<input type="text" name="TCEndtime" id="TCEndtime" disabled="disabled" 
									style="width: 150px;" value="2999-12-31" />
							</td>
						</tr>						
					</table>
					<table>
						<tr>							
							<td colspan="6">
								<button class="tsdbutton" id="bytcadd" 
									onclick="Bytc_Save()"
									style="width:80px; height: 26px; margin-top: 3px; padding: 0px;">
									新增>>
								</button>
							
								<button class="tsdbutton" id="bytcdel" 
									onclick="Bytc_Del()"
									style="width:80px; height: 26px; margin-top: 3px; padding: 0px;">
									取消
								</button>
							</td>
						</tr>
					</table>
					<br />
				</div>
				
				
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<input type="checkbox" id="broadbandinfo" name="broadbandinfo" onclick="showBroadbandinfo();" />
					办理宽带
				</div>
				<table id="tabbroadinfo" style="border:1px solid #A9C8D9;width: 780px;">
				  	<tr>
				  		<td class="wenzi" style="width:90px;line-height:30px;">上网账号</td>
						<td class="wenzi" style="width:170px;line-height:30px;">
							<input type='text' id='baccount' name='baccount' style='width: 150px;' disabled='disabled'/><font color="red">*</font>
						</td>
				  		<td class="wenzi" style="width:90px;line-height:30px;">接入类型</td>
						<td class="wenzi" style="width:170px;line-height:30px;">
							<select style="width: 153px;" id="baccesstype" name="baccesstype">
								<option>--请选择--</option>
							</select><font color="red">*</font>
						</td>
						<td class="wenzi" style="width:90px;line-height:30px;">付费类型</td>
						<td class="wenzi" style="width:170px;line-height:30px;">
							<select style="width: 153px;" id="bpaytype" name="bpaytype" onchange="loadpkgbytype(this.value);">
								<option>--请选择--</option>
							</select><font color="red">*</font>
						</td>
						
					</tr>
					
					<tr>
						<td class="wenzi" style="width:90px;line-height:30px;">绑定类型</td>
						<td class="wenzi" style="width:170px;line-height:30px;">
							<select id="autobandtype" style="width:153px;">
								<option value="0">无绑定</option>
								<option value="1">IP绑定</option>
								<option value="2">MAC绑定</option>
								<option value="3">VLAN绑定</option>
								<option value="4">IP+MAC绑定</option>
								<option value="5">IP+VLAN绑定</option>
								<option value="6">MAC+VLAN绑定</option>
								<option value="7">IP+MAC+VLAN绑定</option>
							</select>
						</td>
				  		<td class="wenzi" style="width:90px;line-height:30px;">
				  			上网密码
						</td>
						<td class="wenzi" style="width:170px;line-height:30px;">
							<input type="password" style='width: 150px;' id="bpasswd" name="bpasswd"/><font color="red">*</font>
						</td>
						<td class="wenzi" style="width:90px;line-height:30px;">
							密码确认
						</td>
						<td class="wenzi" style="width:170px;line-height:30px;">
							<input type="password" style='width: 150px;' id="bcpasswd" name="bcpasswd"/><font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="wenzi" style="width:90px;line-height:30px;">
							上网套餐
						</td>
						<td colspan="3" class="wenzi" style="width:350px;line-height:30px;">
							<select id="pkgid" style="width: 335px;" onchange="setPkgFee();">
							</select><font color="red">*</font>
						</td>
						<td class="wenzi" style="width:90px;line-height:30px;">套餐金额</td>
						<td class="wenzi" style="width:170px;line-height:30px;">
							<input type="text" id="txtmoney" style="width: 150px;" value="0" disabled="disabled"/><font color="red">*</font>
						</td>
					</tr>
					<tr>
				  		<td class="wenzi" style="width:90px;line-height:30px;">
				  			一次性费
						</td>
						<td class="wenzi" style="width:170px;line-height:30px;">
							<input type="text" id="txtBussFee" style='width: 135px;' value="0" disabled="disabled"/><input type="button" value="..." onclick="setbusifee();"/>
						</td>
						<td class="wenzi" style="width:90px;line-height:30px;">
				  			开始日期
						</td>
						<td class="wenzi" style="width:170px;line-height:30px;">
							<input type="text" id="txtregdate" name="txtregdate" style="width:150px;" disabled="disabled"/>
						</td>
						<td class="wenzi" style="width:90px;line-height:30px;">
				  			到期日期
						</td>
						<td class="wenzi" style="width:170px;line-height:30px;">
							<input type="text" id="enddate"  name="enddate" style="width:150px;" disabled="disabled"/>
						</td>
					</tr>
				</table>
				
				
			   <div id='setBYPkg_frame'>
			    <div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phoneyewu.bytcsz" />
					<!-- 包月套餐设置 -->
				</div>
				<table>
					<tr>
						<td>
						  <table>
						  	<tr>
						  		<td class="wenzi" align="right" style="width:65px;line-height:30px;">
										<fmt:message key="phone.getinternet0086" /><!-- 套餐组 -->
								</td>
								<td>
									<select name="Packaggroupid" id="Packaggroupid" style="width: 153px;" onchange="getPackagetypes()"></select>
								</td>
							</tr>
							<tr>
								<td colspan="2">
						  			<div style="width:220px; height: 158px; overflow-y: scroll; overflow-x: hidden;background-color:#f7f7f7; border:1px 1px solid #dddddd;">
											<table id="Packagetypes" style="width:225px;" border="1" cellpadding="0">
											</table>											
									</div>
						  		</td>
						  		<td>
						  			<input type="hidden" id="Packagetypeshidden"/><!-- 包月套餐费用项值提交到临时时取该值进行保存 -->
						  		</td>
							</tr>
						  </table>
					 	 </td>
				 	 	 <td class="wenzi">				 	 	 
				 	 		<table cellspacing="1">
				 	 			<tr>
				 	 				<td width=5% style="margin-left: 0px;"></td>
				 	 			</tr>				 	 							  				
				  				<tr>
				  					<td colspan="2"><center>
				  						<button class="tsdbutton" id="bytcadd" 
											onclick="Bytc_Saves()"
											style="width:80px; height: 26px; margin-top: 3px; padding: 0px;">
											<fmt:message key="phone.getinternet0083" /><!-- 新增>> -->
										</button></center>
				  					</td>
				  				</tr>
				  				<tr>
				  					<td colspan="2"><center>
				  						<button class="tsdbutton" id="bytcdels" 
											onclick="Bytc_Dels()"
											style="width:80px; height: 26px; margin-top: 3px; padding: 0px;">
											<fmt:message key="phone.getinternet0084" /><!-- 取消 -->
										</button></center>
				  					</td>
				  				</tr>
				 	 		</table>
				 	 	</td>
				 	 	<td valign="top">				 	 		
				 	 		<table id="dzhthcontent"  style="width:453px;">
				 	 			<tr>
									<th width="20"><input type="checkbox" id="bytctab_checkalls" onclick="Bytc_CheckALL('tc')" style="width:15px;" /></th>
									<th width="280">
										<center>
											<h4>
												<span id="spanTCLX_tables"><fmt:message key="phone.getinternet0087" /><!-- 套餐类型 --></span>
												<!-- 套餐类型 -->
											</h4>
										</center>
									</th>
									<th width="140">
										<center>
											<h4>
												<span id="spanTCQSY_tables"><fmt:message key="phone.getinternet0088" /><!-- 起始时间 --></span>
												<!-- 起始月 -->
											</h4>
										</center>
									</th>
									<th width="140">
										<center>
											<h4>
												<span id="spanTCZZY_tables"><fmt:message key="phone.getinternet0089" /><!-- 终止时间 --></span>
												<!-- 终止月 -->
											</h4>
										</center>
									</th>
								</tr>
				 	 		</table>
				 	 		<div style="width:460px; height: 170px; overflow-y: scroll; overflow-x: hidden;">
					 	 		<table id="bytctabs" style="width:455px;" >
									
								</table>
							</div>
				 	 	</td>
					 </tr>
					 <tr>
					 	<td>
					 	<div style="display:none;width: 420px; height: 20px; overflow-y: scroll; overflow-x: scroll; border-top: 1px solid gray; border-left: 1px solid gray;">
						<table border="1" cellpadding="0" bordercolor="#9AC0CD"
							id="addspeediFeetypes">
						</table>
					    </div>
					  </td>
					 </tr>
				</table>
				<table cellspacing="8" >
					<tr>
				  		<td><fmt:message key="phone.getinternet0088" /><!-- 起始时间 --></td>
				  		<td><input type="text" name="TCStarttimes" id="TCStarttimes" disabled="disabled" 
							style="width: 100px;"  value="<%=Log.getSysTime() %>"/></td>
				  		<td><fmt:message key="phone.getinternet0089" /><!-- 终止时间 --></td>
				  		<td><input type="text" name="TCEndtimes" id="TCEndtimes" disabled="disabled" 
									style="width: 100px;" value="2999-12-31" /></td>
						<td>
							<button id="dzpkg" onclick="getDZblock()"  class="tsdbutton"  style="margin-left: 20px;">打折</button>
						</td>	
						<td>
							<input type="text" id="pkg_rateStr" disabled="disabled"/>
						</td>		
				    </tr>					
				</table>
			 </div>
			 <div id="setBusinesContext_frame">	
			  <div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phoneyewu.yewuggnmqr" />
					<!-- 业务更改内容确认 -->
				</div>
				<div id="inputtext2">
					<table cellspacing="0" style="width:760px;">
					<tr>
						<td style="width:460px;">
							<table id="ffltab" style="width:460px;">
								<tr>
									<td class="wenzi" style="width:100px;">
										<fmt:message key="phone.getinternet0090" /><!-- 付费方式 -->
									</td>
									<td class="wenzix">
										<select name="fufeitype" id="fufeitype" style="width: 150px" class="you1" onchange="payWayChange(this)"></select>
									</td>
									<td class="wenzi">
										<fmt:message key="phone.getinternet0091" /><!-- 应交合计 -->
									</td>
									<td class="wenzix">
										<input type="text" name="yjfee" id="yjfee" style="width: 130px;" disabled="disabled"  class="you1" onkeypress="numValid(this)"
										onpaste="return !clipboardData.getData('text').match(/D/)" ondragenter="return   false"/>
								   </td>
								   <td>
								     <table id="bytctabs" style="width:330px;" border="1" cellpadding="0" bordercolor="#9AC0CD">
									   <tr>
											<th width="200">
										    	<center>
											    <h4>
											     <fmt:message key="phone.getinternet0092" /><!-- 业务受理费 -->
											    </h4>
											    </center>
											</th>
											<th width="120">
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
									<div id="ywslfeename"
									style="width:440px; height: 110px; overflow-y: scroll; overflow-x: hidden; border-top: 1px solid gray; border-left: 1px solid gray;">
									<div id="zafeilist" style="width: 100%; float: left;">
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
										<input type="text" name="Paymoney" id="Paymoney"
											style="width:260px" disabled="disabled" class="you1" />
									</td>
								</tr>
							</table>
						</td>
					</tr>
					</table>
					</div>					
				  </div>
				 </div>
				 <div id="setYCFee_frame"> 
					<hr style="border: 1px dotted #CCCCCC;" />
					<table cellspacing="5" id="ycfeetable" style="background-color:#f7f7f7">
						<tr>
							<td>
								<table cellspacing="0" style="display:none">
									<tr>
										<td>
											<input type='checkbox' name="danweiHTHbox" id="danweiHTHbox"
												style="width: 22px; padding: 0px;" disabled="disabled" onclick="isnotdanwei()" />
										</td>
										<td>
											<font color="red"><fmt:message key="phoneyewu.isnotdwff" /><!-- 是否单位付费 --></font>
										</td>
										<td>&nbsp;&nbsp;&nbsp;&nbsp;
											<fmt:message key="phoneyewu.dwHTH" /><!-- 单位合同号 -->
										</td>
										<td>
											<input type="text" name="danweiHTH" id="danweiHTH"
												style="width: 150px;" disabled="disabled" />
										</td>
									</tr>
								</table>
								<table cellspacing="5">
									<tr>
										<td>&nbsp;&nbsp;<font color='red'><fmt:message key="phone.getinternet0096" /><!-- 是否预存款 --></font></td>
										<td colspan=2><input type="checkbox" id="precheck" name="precheck" onclick="getprecheck();"/></td>
									</tr>	
									<tr>	
										<td>&nbsp;&nbsp;<fmt:message key="phone.getinternet0097" /><!-- 预存金额 -->&nbsp;&nbsp;</td>
										<td><input type="text" name="Prefee" id="Prefee" style="width:130px" disabled="disabled" onkeydown="return preKey(event)" onkeypress="numValid(this)"
											onpaste="return !clipboardData.getData('text').match(/\D/)"
											ondragenter="return   false"/>￥</td>
										<td>&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message key="phone.getinternet0098" /><!-- 确认金额 -->&nbsp;&nbsp;</td>
										<td><input type="text" name="confee" id="confee" style="width:130px" disabled="disabled" onkeypress="numValid(this)"
											onpaste="return !clipboardData.getData('text').match(/\D/)"
											ondragenter="return   false"/>￥</td>
									</tr>
								</table>
								</td>
								<td>
									<table>
										<tr>
										    <td valign="top">
												<fmt:message key="phoneyewu.memo" />：
												<!-- 备注 -->												
											</td>
										</tr>
										<tr>
											<td><textarea name="tBz" id="tBz" rows="4" cols="60" style="width:300px;" maxlength="60"  onpropertychange="TextUtil.NotMax(this)"></textarea></td>	
										</tr>
									</table>
								</td>
							</tr>
					</table>	
			  </div>								
			</div>			
			<div id="buttons">
				<center>
					<button id="save" onclick="Dhzj_Save()"
						style="margin-left: 20px;">
						<!-- 确定 -->
						<fmt:message key="Revenue.Save" />
					</button>
					<button id="reset" onclick="Dhzj_Reset()" style="margin-left: 20px;">
						<!-- 重置 -->
						<fmt:message key="AddUser.Reset" />
					</button>
				</center>
			</div>
		</div>
		
		
		<!-- 勾选宽带业务费div  -->
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
		
		
		<!-- 弹出报表打印框 -->	
		<div id="businessreprint"></div><!-- 加载的文件在script/telephone/business/businessreprint.js -->  		
        <iframe id="printReportDirect" style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>
		<input type="hidden" id="userid" value="<%=userid%>" />
		<input type="hidden" id="area" value="<%=area%>" />
		<input type="hidden" id="depart" value="<%=depart%>" />
		<input type="hidden" id="userareaid" value="<%=userareaid%>" />
		<input type="hidden" id="imenuid" value="<%=imenuid%>" />
		<input type="hidden" id="zid" value="<%=zid%>" />
		<input type="hidden" id="languageType" value="<%=languageType%>" />
		<input type='hidden' id='userloginip'
			value='<%=Log.getIpAddr(request)%>' />
		<input type='hidden' id='userloginid'
			value='<%=session.getAttribute("userid")%>' />
		<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
		<input type="hidden" id="useridright" name="useridright" />
		<input type="hidden" id="feenameid" name="feenameid" />
		<input type="hidden" id="inputDWHTH" name="inputDWHTH" />
		<input type="hidden" id="Subtype" name="Subtype" />
		<input type="hidden" id="setdaijiao" />
		<input type="hidden" id="reportparam" />
		<input type="hidden" id="jobidid" /><!-- 电话工单编号 -->
		<input type="hidden" id="jobid" /><!-- 宽带工单编号 -->
		<input type="hidden" id="ppaytype" />
		<input type="hidden" id="fee" />
		<input type="hidden" id="selecththvaluekey"/><!-- 选择合同号 单击时把值放到隐藏域 -->
		<input type="hidden" id="konghaoarearight"/><!-- 去空号的区域权限值 -->	
		<input type="hidden" id="selecththright"/><!-- 选择合同号权限 -->	
		<input type="hidden" id="addressinputright"/><!-- 地址是否可输入权限 -->
		<input type="hidden" id="statrtimeright"/><!-- 计费起始 -->
		<input type="hidden" id="stoptimeright"/><!-- 计费终止 -->
		<input type="hidden" id="zjtimeright"/><!-- 装机日期 -->
		<input type="hidden" id="Yhmcright"/>
		<input type="hidden" id="Yhlbright"/>
		<input type="hidden" id="Yhxzright"/>
		<input type="hidden" id="CallPayTyperight"/>
		<input type="hidden" id="ZnjBzright"/>
		<input type="hidden" id="CustTyperight"/>
		<input type="hidden" id="CreditGraderight"/>
		<input type="hidden" id="CreditPointright"/>
		<input type="hidden" id="Boss_Nameright"/>
		<input type="hidden" id="linkTelright"/>
		<input type="hidden" id="FixCoderight"/>
		<input type="hidden" id="TradeTyperight"/>
		<input type="hidden" id="CompTyperight"/>
		<input type="hidden" id="HomePageright"/>
		<input type="hidden" id="Emailright"/>
		<input type="hidden" id="Manageidright"/>
		<input type="hidden" id="Arearight"/>
		<input type="hidden" id="HthMfjbright"/>
		<input type="hidden" id="IDCardright"/>
		<input type="hidden" id="sBmright"/>
		<input type="hidden" id="Yhmc_yhdangright"/>
		<input type="hidden" id="Yhdz_yhdangright"/>
		<input type="hidden" id="sBm_yhdangright"/>
		<input type="hidden" id="Mima_yhdangright"/>
		<input type="hidden" id="Bz8_yhdangright"/>
		<input type="hidden" id="Bz9_yhdangright"/>
		<input type="hidden" id="Bz6_yhdangright"/>
		<input type="hidden" id="Bz7_yhdangright"/>
		<input type="hidden" id="Hwjb1_yhdangright"/>
		<input type="hidden" id="Jflb_yhdangright"/>
		<input type="hidden" id="Mfjb_yhdangright"/>
		<input type="hidden" id="Mobile_yhdangright"/>
		<input type="hidden" id="AdjustSheduleNo_yhdangright"/>
		<input type="hidden" id="CallSheduleNo_yhdangright"/>
		<input type="hidden" id="MokuaiJu_yhdangright"/>
		<input type="hidden" id="YwArea_yhdangright"/>
		<input type="hidden" id="CreditGrade_yhdangright"/>
		<input type="hidden" id="CreditPoint_yhdangright"/>
		<input type="hidden" id="UserType_yhdangright"/>
		<input type="hidden" id="CustType_yhdangright"/>	
		<input type="hidden" id="Dhgn_yhdangright"/>
		<input type="hidden" id="checkPayment"/>
		<input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->	
		<input type="hidden" id="fufeitypepath"/>		
		<input type="hidden" id="keyhidden"/><!-- 固话费参数个数 -->
		<input type="hidden" id="startdate" value="<%=nowTimeto %>"/><!-- 固定费用起始日期 -->
		<input type="hidden" id="yjfeehidden"/><!-- 页面获取应缴费存入隐藏于中 -->
		<input type="hidden" id="bmtypekey"/><!-- 部门编号 -->		
		<input type="hidden" id="sbmcode"/><!-- 部门编号 -->
		<input type="hidden" id="sbmname"/><!-- 部门名称 -->
		<input type="hidden" id='selbz'/><!-- 电话站标识 -->
		<input type="hidden" id="mokuaiju"/><!-- 电话模块局 -->
		<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->
		<input type="hidden" id="stiffbusinestype" value="phoneZJ"/><!-- 电话工单打印类型 -->
		<input type="hidden" id="bytctimedisabeld"/><!-- 包月套餐时间变更标志 -->
		<input type="hidden" id="areatype" value="ysarea"/><!-- 区域类型 -->
		<input type="hidden" id="Prefeeval"/><!-- 预测金额打印票据时判断 -->
		<input type="hidden" id="Bz2right"/><!-- 一级部门是否代收 -->
		<input type="hidden" id="selecththarearight"/>
		<input type="hidden" id="cycle"/><!-- 获取是一次性套餐或是连续套餐 -->
		<select id="yhxz_hidden" style="display:none;"></select>
		<jsp:include page="phone_internet.jsp" flush="true"/>		
		<input type="hidden" id="businesstype" value="p_setup"/><!-- 该页面的业务类型 -->
		
		<!-- 宽带 -->
		<input type="hidden" id="hiduints"/>
		<input type="hidden" id="hidfeerule"/>
		<input type="hidden" id="hidspeed"/>	
		<input type="hidden" id="hidfirbilldate"/>			
	</body>
	<script>
	var hilighter2 = new TableRowHilighter(document.getElementById('addspeediFeetype'), 0, 'lightsteelblue');
	var hilighter3 = new TableRowHilighter(document.getElementById('queryHTHdw'), 0, 'lightsteelblue');
  </script>
</html>
