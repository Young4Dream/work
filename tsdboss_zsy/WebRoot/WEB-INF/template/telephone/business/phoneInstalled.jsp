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
	String username = (String) session.getAttribute("username");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
	/////////////////Java取当前时间
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
	SimpleDateFormat formatto = new SimpleDateFormat("yyyy-MM-dd");
	Date now = new Date();
	String nowTime = format.format(now);
	String nowTimeto = formatto.format(now);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<!--  <base href="<%=basePath%>"> -->
		<title>My JSP 'phoneInstalled.jsp' starting page</title>			
		<meta http-equiv="description" content="this is my page" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<!-- <link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />-->
		<!-- <link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />-->
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<!--<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>-->
		<!--<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>-->
		<!--<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>-->
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
		<script src="script/telephone/business/phoneInstalled.js" type="text/javascript"></script>
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
	       $("#usertype").change(function(){
	    	   queryFeename();// 获取一次性费用
	    	   $('#hth').val('');
	    	   $('#Hth').val('');
	    	   $('#UserType_yhdang').val('');
	    	   $('#Yhxz').val('');
	    	   $('#Hth_yhdang').val('');
	    	   removenullhthcontent();
	    	   //alert($('#usertype').find('option:selected').text());
	    	   /* load_yhdang($('#usertype').find('option:selected').text()); */
	        });
	        
	        getPackages();//20160316 获取套餐，yyl add
	        
	        $("#table_old_pl_title").hide();
	        $("#table_old_pl").hide();
	        $("#selectHth").removeAttr("disabled");
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
		
        /********
       	*显示指定合同号下已安装专线
        *@param：hth 合同号;
       	*@return;
        *********/
        function load_old_pls(hth) {
        	$("#table_old_pl").empty();
        	var sql_key = "pl.getOldPLs";
        	var sql_params = "&hth=" + hth;
        	var res = fetchMultiArrayValue(sql_key, 6, sql_params, "privateline");
        	if (res[0] == undefined || res[0][0] == undefined) {
        		//$("#div_old_pl").hide();
        		$("#table_old_pl_title").hide();
        		$("#table_old_pl").hide();
        		$("#label_old_pl").html("（未安装专线）");
        		return false;
        	}
            var ify = "";
            for(var i = 0;i < res.length; i++){
                ify += "<tbody>" +
					   "		<tr>" +
					   "			<th width=\"30px\" align=center>" + (i+1) +
					   "			</th>" +
					   "			<th width=\"70px\">" + res[i][0] +
					   "			</th>" +
					   "			<th width=\"60px\">" + res[i][1] +
					   "			</th>" +
					   "			<th width=\"60px\">" + res[i][2] +
					   "			</th>" +
					   "			<th width=\"60px\">" + res[i][3] +
					   "			</th>" +
					   "			<th width=\"100px\">" + res[i][4] + "元/" + (res[i][5] == "1" ? "年" : "月") +
					   "			</th>" +
					   "			<th width=\"90px\">" + res[i][6] +
					   "			</th>" +
					   "			<th width=\"90px\">" + (res[i][7].substr(0, 4) == "2999" ? "" : res[i][7]) +
					   "			</th>" +
					   "			<th width=\"180px\">" + res[i][8] +
					   "			</th>" +
					   "			<th width=\"40px\">" + (res[i][9] == "1" ? "在用" : "拆除") +
					   "			</th>" +
					   "		</tr>" +
					   "</tbody>";
            }
            $("#table_old_pl").append(ify);
        	$("#table_old_pl_title").show();
        	$("#table_old_pl").show();
        	$("#label_old_pl").html("");
        }
        
        /***
        * 根据用户性质载入电话属性
        ***/
		/* function load_yhdang(usertype) {
		var table_content = "";
		if (usertype == '个人用户' || usertype == '住宅') {
			table_content += 
							'<tbody><tr style="display:none">'+
								'<td class="wenzi" align="right">'+
									'<span id="spanyucunYE">出帐月余额</span>'+
									/* 话费余额 -
								'</td>'+
								'<td>'+
									'<input id="phoneBalance" name="phoneBalance" value="0" style="width: 150" disabled="" type="text">'+
								'</td>'+
								'<td class="wenzi" align="right">'+
									'<span id="spanxinyueHF">实时余额</span>'+
								 /* 当前月话费 
								'<span id="spanxinyueHF">实时余额</span>'+
								'<span id="spanxinyueHF">实时余额</span>'+
									'<input id="mothshuafei" name="mothshuafei" value="0" style="width: 150" disabled="" type="text">'+
								'</td>'+
								'<td class="wenzi" align="right">'+
									'<span id="spanTjbz"></span>'+
									/*  停机标志 
								'</td>'+
								'<td>'+
									'<input id="TJLogo" name="TJLogo" style="width: 150" disabled="" type="text">'+
								'</td>'+
							'</tr>'+
							'<tr style="display:none">'+
								'<td class="wenzi" align="right">'+
									'<span id="spanDhgn"></span>'+
									/*  电话功能  
								'</td>'+
								'<td>'+
									'&nbsp;<select disabled="" name="Dhgn" id="Dhgn" style="width: 150px;"></select>'+
								'</td>'+
								'<td align="right">'+
									'<span id="spanJhj_IDx"></span>'+
									/* 交换机编号 
								'</td>'+
								'<td>'+
									'<input name="SwitchNumber" id="SwitchNumber" style="width: 150;display:none;" disabled="" type="text">'+
								'</td>'+
								'<td align="right">'+
									/*停机标志<!-- 停机标志 -->
								'</td>'+
								'<td>'+
									'<select disabled="" id="Tjbz_yhdang" name="Tjbz_yhdang"></select>'+							
								'</td>'+
		 					'</tr>'+
		                   '<tbody>'+
                      '<tr>'+
                      '<td class="wenzi" align="right">电话</td>' +
                      '<td class="wenzix"><input disabled="" name="Dh_yhdang" id="Dh_yhdang" style="width: 150px;" onkeypress="var k=event.keyCode;return k>=48&amp;&amp;k<=57" maxlength="16" ondragenter="return false" onpaste="return false" type="text"></td>'+
                      '<td class="wenzi" align="right">合同号</td>'+
                      '<td class="wenzix"><input disabled="" name="Hth_yhdang" id="Hth_yhdang" style="width: 150px;" maxlength="16" onpropertychange="TextUtil.NotMax(this)" type="text"><font color="red">*</font></td>'+
                      '<td class="wenzi" align="right">用户名称</td>'+
                      '<td class="wenzix"><input disabled="" name="Yhmc_yhdang" id="Yhmc_yhdang" style="width: 150px;" maxlength="50" onpropertychange="TextUtil.NotMax(this)" type="text"><font color="red">*</font></td>'+
                      '</tr>'+                      
                      '<tr>'+
                      '<td class="wenzi" align="right">用户地址</td>'+
                      '<td class="wenzix"><input disabled="" name="Yhdz_yhdang" id="Yhdz_yhdang" style="width: 150px;" maxlength="120" onpropertychange="TextUtil.NotMax(this)" type="text"><font color="red">*</font></td>'+
                      '<td class="wenzi" align="right">联系人</td>'+
                      '<td class="wenzix"><input disabled="" name="Bz8_yhdang" id="Bz8_yhdang" style="width: 150px;" maxlength="30" onpropertychange="TextUtil.NotMax(this)" type="text"><font color="red">*</font></td>' +
                      '<td class="wenzi" align="right">联系电话</td>'+
                      '<td class="wenzix"><input disabled="" name="Bz9_yhdang" id="Bz9_yhdang" style="width: 150px;" onkeypress="var k=event.keyCode;return k>=48&amp;&amp;k<=57" maxlength="30" ondragenter="return false" onpaste="return false" type="text"><font color="red">*</font></td>'+
                      '</tr>'+
                      '<tr>'+
                      '<td class="wenzi" align="right">证件类型</td>'+
                      '<td class="wenzix"><select disabled="" name="Bz6_yhdang" id="Bz6_yhdang" style="width: 150px;"></select></td>'+
                      '<td class="wenzi" align="right">催缴策略</td>'+
                      '<td class="wenzix"><select disabled="" name="CallSheduleNo_yhdang" id="CallSheduleNo_yhdang" style="width: 150px;"></select><font color="red">*</font></td>'+
                      '<td class="wenzi" align="right">电话功能</td>'+
                      '<td class="wenzix"><select disabled="" name="Dhgn_yhdang" id="Dhgn_yhdang" style="width: 150px;"></select><font color="red">*</font></td>'+
                      '</tr>'+
                      '<tr>'+
                      '<td class="wenzi" align="right">计费起始</td>'+
                      '<td class="wenzix"><input disabled="" name="StartDate_yhdang" id="StartDate_yhdang" style="width: 150px;" maxlength="50" onpropertychange="TextUtil.NotMax(this)" type="text"></td>'+
                      '<td class="wenzi" align="right">计费终止</td>'+
                      '<td class="wenzix"><input disabled="" name="EndDate_yhdang" id="EndDate_yhdang" style="width: 150px;" maxlength="50" onpropertychange="TextUtil.NotMax(this)" type="text"></td>'+
                      '<td class="wenzi" align="right">号线模块</td>'+
                      '<td class="wenzix"><select disabled="" name="Mokuaiju_yhdang" id="Mokuaiju_yhdang" style="width: 150px;"></select></td>'+
                      '</tr>'+
                      '<tr>'+
                      '<td class="wenzi" align="right">安装区域</td>'+
                      '<td class="wenzix"><select disabled="" name="YwArea_yhdang" id="YwArea_yhdang" style="width: 150px;"></select><font color="red">*</font></td>'+
                      '<td class="wenzi" align="right">代办人电话</td>'+
                      '<td class="wenzix"><select disabled="" name="Bz3_yhdang" id="Bz3_yhdang" style="width: 150px;"></select></td>'+
                      '<td class="wenzi" align="right">与户主关系</td>'+
                      '<td class="wenzix"><input disabled="" name="Bz2_yhdang" id="Bz2_yhdang" style="width: 150px;" maxlength="50" onpropertychange="TextUtil.NotMax(this)" type="text"></td>'+
                      '</tr>'+
                      '<tr>'+
                      '<td class="wenzi" align="right">查询密码</td>'+
                      '<td class="wenzix"><input disabled="" name="Mima_yhdang" id="Mima_yhdang" style="width: 150px;" maxlength="16" onpropertychange="TextUtil.NotMax(this)" type="text"></td>'+
                      '<td class="wenzi" align="right">代办证件类型</td>'+
                      '<td class="wenzix"><select disabled="" name="Bz4_yhdang" id="Bz4_yhdang" style="width: 150px;"></select></td>'+
                      '</tr>'+
                      '<input id="mustitem_yhdang" value="Hth_yhdang|Yhmc_yhdang|Yhdz_yhdang|Bz8_yhdang|Bz9_yhdang|AdjustSheduleNo_yhdang|Dhgn_yhdang|CallSheduleNo_yhdang|YwArea_yhdang|" type="hidden">'+
                      '<input id="def_Dh_yhdang" value="" type="hidden"><input id="def_Hth_yhdang" value="" type="hidden"><input id="def_Yhmc_yhdang" value="" type="hidden"><input id="def_Bm1_yhdang" value="" type="hidden">'+
                      '<input id="def_Bm2_yhdang" value="" type="hidden"><input id="def_Bm3_yhdang" value="" type="hidden"><input id="def_Bm4_yhdang" value="" type="hidden"><input id="def_Yhdz_yhdang" value="" type="hidden">'+
                      '<input id="def_Bz10_yhdang" value="" type="hidden"><input id="def_Bz8_yhdang" value="" type="hidden"><input id="def_Bz9_yhdang" value="" type="hidden"><input id="def_Bz6_yhdang" value="身份证" type="hidden">'+
                      '<input id="def_Bz7_yhdang" value="" type="hidden"><input id="def_AdjustSheduleNo_yhdang" value="禁停" type="hidden"><input id="def_Dhgn_yhdang" value="" type="hidden"><input id="def_CallSheduleNo_yhdang" value="禁催" type="hidden">'+
                      '<input id="def_StartDate_yhdang" value="" type="hidden"><input id="def_EndDate_yhdang" value="" type="hidden"><input id="def_Mokuaiju_yhdang" value="$(" #mokuaiju").val()"="" type="hidden"><input id="def_YwArea_yhdang" value="$(" #ywarea").val()"="" type="hidden">'+
                      '<input id="def_mkj2_yhdang" value="$(" #mokuaiju").val()"="" type="hidden"><input id="def_mkj3_yhdang" value="$(" #mokuaiju").val()"="" type="hidden"><input id="def_mkj4_yhdang" value="$(" #mokuaiju").val()"="" type="hidden"><input id="def_Bz3_yhdang" value="$(" #area").val()"="" type="hidden">'+
                      '<input id="def_Bz2_yhdang" value="" type="hidden"><input id="def_Bz1_yhdang" value="" type="hidden"><input id="def_Bz5_yhdang" value="局端" type="hidden"><input id="def_Mima_yhdang" value="" type="hidden"><input id="def_Bz4_yhdang" value="普通" type="hidden">'+
  		      '<input disabled="" name="Bm1_yhdang" id="Bm1_yhdang" style="width: 150px;" maxlength="50" onpropertychange="TextUtil.NotMax(this)" type="hidden">'+
                      '<input disabled="" name="Bm2_yhdang" id="Bm2_yhdang" style="width: 150px;" maxlength="50" onpropertychange="TextUtil.NotMax(this)" type="hidden">'+
                      '<input disabled="" name="Bm3_yhdang" id="Bm3_yhdang" style="width: 150px;" maxlength="50" onpropertychange="TextUtil.NotMax(this)" type="hidden">'+
                      '<select id="mkj2_yhdang" style="visibility:hidden"></select>'+
                      '<select  id="mkj3_yhdang" style="visibility:hidden"></select>'+
                      '<select id="mkj4_yhdang" style="visibility:hidden"></select>'+
                      '<input id="Bz1_yhdang" style="visibility:hidden" type="hidden">'+
                      '<select id="Bz5_yhdang" style="visibility:hidden"></select>'+
                      '<input " id="Bz7_yhdang" style="visibility:hidden" type="hidden">'+
                      '<input disabled="" name="Bm4_yhdang" id="Bm4_yhdang" style="width: 150px;" maxlength="50" onpropertychange="TextUtil.NotMax(this)" type="hidden"></tbody>';
			$("#tableyhdang").html(table_content);
		} else if (usertype == '办公用户' || usertype == '办公') {
			table_content += 
			'<tbody><tr style="display:none">'+
								'<td class="wenzi" align="right">'+
									'<span id="spanyucunYE">出帐月余额</span>'+
									/* 话费余额 -
								'</td>'+
								'<td>'+
									'<input id="phoneBalance" name="phoneBalance" value="0" style="width: 150" disabled="" type="text">'+
								'</td>'+
								'<td class="wenzi" align="right">'+
									'<span id="spanxinyueHF">实时余额</span>'+
								 /* 当前月话费 
								'<span id="spanxinyueHF">实时余额</span>'+
								'<span id="spanxinyueHF">实时余额</span>'+
									'<input id="mothshuafei" name="mothshuafei" value="0" style="width: 150" disabled="" type="text">'+
								'</td>'+
								'<td class="wenzi" align="right">'+
									'<span id="spanTjbz"></span>'+
									/*  停机标志 
								'</td>'+
								'<td>'+
									'<input id="TJLogo" name="TJLogo" style="width: 150" disabled="" type="text">'+
								'</td>'+
							'</tr>'+
							'<tr style="display:none">'+
								'<td class="wenzi" align="right">'+
									'<span id="spanDhgn"></span>'+
									/*  电话功能  
								'</td>'+
								'<td>'+
									'&nbsp;<select disabled="" name="Dhgn" id="Dhgn" style="width: 150px;"></select>'+
								'</td>'+
								'<td align="right">'+
									'<span id="spanJhj_IDx"></span>'+
									/* 交换机编号 
								'</td>'+
								'<td>'+
									'<input name="SwitchNumber" id="SwitchNumber" style="width: 150;display:none;" disabled="" type="text">'+
								'</td>'+
								'<td align="right">'+
									/*停机标志<!-- 停机标志 -->
								'</td>'+
								'<td>'+
									'<select disabled="" id="Tjbz_yhdang" name="Tjbz_yhdang"></select>'+							
								'</td>'+
							'</tr>'+
                                        '<tbody>'+
                      '<tr>'+
                      '<td class="wenzi" align="right">电话</td>'+
                      '<td class="wenzix"><input disabled="" name="Dh_yhdang" id="Dh_yhdang" style="width: 150px;" onkeypress="var k=event.keyCode;return k>=48&amp;&amp;k<=57" maxlength="16" ondragenter="return false" onpaste="return false" type="text"></td>'+
                      '<td class="wenzi" align="right">合同号</td>'+
                      '<td class="wenzix"><input disabled="" name="Hth_yhdang" id="Hth_yhdang" style="width: 150px;" maxlength="16" onpropertychange="TextUtil.NotMax(this)" type="text"><font color="red">*</font></td>'+
                      '<td class="wenzi" align="right">用户名称</td>'+
                      '<td class="wenzix"><input disabled="" name="Yhmc_yhdang" id="Yhmc_yhdang" style="width: 150px;" maxlength="50" onpropertychange="TextUtil.NotMax(this)" type="text"><font color="red">*</font></td>'+
                      '</tr>'+
                      '<tr>'+
                      '<td class="wenzi" align="right">用户地址</td>'+
                      '<td class="wenzix"><input disabled="" name="Yhdz_yhdang" id="Yhdz_yhdang" style="width: 150px;" maxlength="120" onpropertychange="TextUtil.NotMax(this)" type="text"><font color="red">*</font></td>'+
                      '<td class="wenzi" align="right">联系人</td>'+
                      '<td class="wenzix"><input disabled="" name="Bz8_yhdang" id="Bz8_yhdang" style="width: 150px;" maxlength="30" onpropertychange="TextUtil.NotMax(this)" type="text"><font color="red">*</font></td>'+
                      '<td class="wenzi" align="right">联系电话</td>'+
                      '<td class="wenzix"><input disabled="" name="Bz9_yhdang" id="Bz9_yhdang" style="width: 150px;" onkeypress="var k=event.keyCode;return k>=48&amp;&amp;k<=57" maxlength="30" ondragenter="return false" onpaste="return false" type="text"><font color="red">*</font></td>'+
                      '</tr>'+
                      '<tr>'+
                      '<td class="wenzi" align="right">证件类型</td>'+
                      '<td class="wenzix"><select disabled="" name="Bz6_yhdang" id="Bz6_yhdang" style="width: 150px;"></select></td>'+
                      '<td class="wenzi" align="right">电话功能</td>'+
                      '<td class="wenzix"><select disabled="" name="Dhgn_yhdang" id="Dhgn_yhdang" style="width: 150px;"></select><font color="red">*</font></td>'+
                      '<td class="wenzi" align="right">催缴策略</td>'+
                      '<td class="wenzix"><select disabled="" name="CallSheduleNo_yhdang" id="CallSheduleNo_yhdang" style="width: 150px;"></select><font color="red">*</font></td>'+
                      '</tr>'+
                      '<tr>'+
                      '<td class="wenzi" align="right">计费起始</td>'+
                      '<td class="wenzix"><input disabled="" name="StartDate_yhdang" id="StartDate_yhdang" style="width: 150px;" maxlength="50" onpropertychange="TextUtil.NotMax(this)" type="text"></td>'+
                      '<td class="wenzi" align="right">计费终止</td>'+
                      '<td class="wenzix"><input disabled="" name="EndDate_yhdang" id="EndDate_yhdang" style="width: 150px;" maxlength="50" onpropertychange="TextUtil.NotMax(this)" type="text"></td>'+
                      '<td class="wenzi" align="right">号线模块</td>'+
                      '<td class="wenzix"><select disabled="" name="Mokuaiju_yhdang" id="Mokuaiju_yhdang" style="width: 150px;"></select></td>'+
                      '</tr>'+
                      '<tr>'+
                      '<td class="wenzi" align="right">安装区域</td>'+
                      '<td class="wenzix"><select disabled="" name="YwArea_yhdang" id="YwArea_yhdang" style="width: 150px;"></select><font color="red">*</font></td>'+
                      '<td class="wenzi" align="right">代办人电话</td>'+
                      '<td class="wenzix"><select disabled="" name="Bz3_yhdang" id="Bz3_yhdang" style="width: 150px;"></select></td>'+
                      '<td class="wenzi" align="right">与户主关系</td>'+
                      '<td class="wenzix"><input disabled="" name="Bz2_yhdang" id="Bz2_yhdang" style="width: 150px;" maxlength="50" onpropertychange="TextUtil.NotMax(this)" type="text"></td>'+
                      '</tr>'+
                      '<tr>'+
                      '<td class="wenzi" align="right">查询密码</td>'+
                      '<td class="wenzix"><input disabled="" name="Mima_yhdang" id="Mima_yhdang" style="width: 150px;" maxlength="16" onpropertychange="TextUtil.NotMax(this)" type="text"></td>'+
                      '<td class="wenzi" align="right">代办证件类型</td>'+
                      '<td class="wenzix"><select disabled="" name="Bz4_yhdang" id="Bz4_yhdang" style="width: 150px;"></select></td>'+
                      '</tr>'+
                      '<input disabled="" name="Bm1_yhdang" id="Bm1_yhdang" style="width: 150px;" maxlength="50" onpropertychange="TextUtil.NotMax(this)" type="hidden">'+
                      '<input disabled="" name="Bm2_yhdang" id="Bm2_yhdang" style="width: 150px;" maxlength="50" onpropertychange="TextUtil.NotMax(this)" type="hidden">'+
                      '<input disabled="" name="Bm3_yhdang" id="Bm3_yhdang" style="width: 150px;" maxlength="50" onpropertychange="TextUtil.NotMax(this)" type="hidden">'+
                      '<input disabled="" name="Bm4_yhdang" id="Bm4_yhdang" style="width: 150px;" maxlength="50" onpropertychange="TextUtil.NotMax(this)" type="hidden">'+
                      '<select id="mkj2_yhdang" style="visibility:hidden"></select>'+
                      '<select  id="mkj3_yhdang" style="visibility:hidden"></select>'+
                      '<select id="mkj4_yhdang" style="visibility:hidden"></select>'+
                      '<input id="mustitem_yhdang" value="Hth_yhdang|Yhmc_yhdang|Yhdz_yhdang|Bz8_yhdang|Bz9_yhdang|AdjustSheduleNo_yhdang|Dhgn_yhdang|CallSheduleNo_yhdang|YwArea_yhdang|" type="hidden">'+
                      '<input id="def_Dh_yhdang" value="" type="hidden"><input id="def_Hth_yhdang" value="" type="hidden"><input id="def_Yhmc_yhdang" value="" type="hidden"><input id="def_Bm1_yhdang" value="" type="hidden">'+
                      '<input id="def_Bm2_yhdang" value="" type="hidden"><input id="def_Bm3_yhdang" value="" type="hidden"><input id="def_Bm4_yhdang" value="" type="hidden"><input id="def_Yhdz_yhdang" value="" type="hidden">'+
                      '<input id="def_Bz10_yhdang" value="" type="hidden"><input id="def_Bz8_yhdang" value="" type="hidden"><input id="def_Bz9_yhdang" value="" type="hidden"><input id="def_Bz6_yhdang" value="身份证" type="hidden">'+
                      '<input id="def_Bz7_yhdang" value="" type="hidden"><input id="def_AdjustSheduleNo_yhdang" value="禁停" type="hidden"><input id="def_Dhgn_yhdang" value="" type="hidden"><input id="def_CallSheduleNo_yhdang" value="禁催" type="hidden">'+
                      '<input id="def_StartDate_yhdang" value="" type="hidden"><input id="def_EndDate_yhdang" value="" type="hidden"><input id="def_Mokuaiju_yhdang" value="$(" #mokuaiju").val()"="" type="hidden"><input id="def_YwArea_yhdang" value="$(" #ywarea").val()"="" type="hidden">'+
                      '<input id="def_mkj2_yhdang" value="$(" #mokuaiju").val()"="" type="hidden"><input id="def_mkj3_yhdang" value="$(" #mokuaiju").val()"="" type="hidden"><input id="def_mkj4_yhdang" value="$(" #mokuaiju").val()"="" type="hidden"><input id="def_Bz3_yhdang" value="$(" #area").val()"="" type="hidden">'+
                      '<input id="def_Bz2_yhdang" value="" type="hidden"><input id="def_Bz1_yhdang" value="" type="hidden"><input id="def_Bz5_yhdang" value="局端" type="hidden"><input id="def_Mima_yhdang" value="" type="hidden"><input id="def_Bz4_yhdang" value="普通" type="hidden">'+
                      '<input " id="Bz7_yhdang" style="visibility:hidden" type="hidden">'+
                      '<input id="Bz1_yhdang" style="visibility:hidden" type="hidden">'+
                      '<select id="Bz5_yhdang" style="visibility:hidden"></select></tbody>';
				$("#tableyhdang").html(table_content);
			}
		}   */      
				
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
	<!-- 号码原信息div  -->
	<div class="neirong" id="divbusifee" style="width:300px;display: none">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<span>号码原信息</span>
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
				<table border="1" cellpadding="0" bordercolor="#9AC0CD" id="tabbusiyxx" style="width: 280px;">
					
														
				</table>
			</div>
		</div>
		<div class="midd_butt" style="width:290px;height:38px;">  
			<!-- <button id="hthChooseFormSave" onclick="caclbusifee();" class="tsdbutton" 
				style="margin-left: 20px;">
				确定
			</button> -->
			<button id="hthChooseFormReset" onclick="javascript:setTimeout($.unblockUI,15);$('selectsbmkey').val('');" class="tsdbutton"  style="margin-left: 20px;">
				关闭			
			</button>
		</div>
	</div>
	
	
	
	
	
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
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
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
						   		<!-- 
						   		<option value="2"><fmt:message key="phone.getinternet0072" /></option>
						   		 --> <!-- 合同号开户 -->
						   		</select>
						   	</td>
						</tr>
					</table>
					</td>
					<td>
					<table cellspacing="3" id="phone_querynumber">
						<tr>
							<td id="dhlxname"> <fmt:message key="phone.getinternet0073" /><!-- 电话类型 --></td>
						   	<td><select id="Dhlx" style="width:100px;"></select></td>
							<td id="usertypetdid">
								<fmt:message key="phone.getinternet0074" /><!-- 用户类别 -->
							</td>
							<td>
								<select name="usertype" id="usertype" style="width: 110px;"></select>								
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
							<td>
								<center>
								<input type="checkbox" name="isk" id="isk" style="width:30px;display:none;" onclick="choiceMokuaiju()"/>
								</center>
							</td>
							<!-- <td id="kuaquyu">
								<fmt:message key="phoneyewu.kuaquyu" />跨区域
							</td> -->
						</tr>
					</table>
					
					</td>
					</tr>
					</table>
					
					<!-- 合同号选择BEGIN -->	
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
								 &nbsp;&nbsp;
								 
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
					<!-- 合同号选择END -->	
				
					<!-- 部门选择BEGIN -->	
						<hr style="border: 1px dotted #CCCCCC;" />
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
					<!-- 部门选择BEGIN -->
				</div>				
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0080" /><!-- 合同号信息 -->
				</div>
				<div id="inputtext">
					<div class="midd">
						<table id="tablehthdang" style="width:780px;">
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
						<table id="tableyhdang" style="width:780px;">
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
					<img src="style/icon/65.gif" />月固定费
					<%--<fmt:message key="phone.getinternet0082" /> --%><!-- 固定费 -->
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
						  			<div style="width:210px; height: 160px; overflow-y: scroll; overflow-x: hidden;background-color:#f7f7f7;border:1px 1px solid #dddddd;">
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
				 	 		<table id="dzhthcontent"  style="width:500px;">
				 	 			<tr>
									<th width="10"><input type="checkbox" id="dhzftab_checkall" onclick="Dhzf_CheckAll()" style="width:15px;" /></th>
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
								 	<!-- <th width="75">
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
									</th>  -->
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
				
			   <div id='setBYPkg_frame2'>
			    <div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phoneyewu.bytcsz" /><font color="red">----IP资费的5折：合同号200以前所有电话、全部专网电话、小区私人用户；IP资费：合同号200以后的局内电话；联通资费：石油外部单位。</font>
					<!-- 包月套餐设置 -->
				</div>
				<table>
					<tr>
						<td>
						  <table>
							  <!--  	<tr>
							  		<td class="wenzi" align="right" style="width:65px;line-height:30px;">
										套餐
									</td>
									<td>
										<select name="Packaggroupid" id="Packaggroupid" style="width: 153px;" onchange="getPackagetypes()">
										</select>
									</td>
								</tr>
							-->	
							<tr>
								<td colspan="2">
						  			<div style="width:210px; height: 108px; overflow-y: scroll; overflow-x: hidden;background-color:#f7f7f7; border:1px 1px solid #dddddd;">
										<table id="Packagetypes" style="width:225px;" border="1" cellpadding="0">
										</table>
									</div>
						  		</td>
						  		<td>
						  			<input type="hidden" id="Packagetypeshidden"/><!-- 包月套餐费用项值提交到临时时取该值进行保存 -->
						  			<input type="hidden" id="hasSelectedPackageId"/><!-- 已选中套餐id拼接 -->
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
				  						<button class="tsdbutton" id="bytcadd" 
											onclick="Bytc_Saves()"
											style="width:60px; height: 26px; margin-top: 3px; padding: 0px;">
											<fmt:message key="phone.getinternet0083" /><!-- 新增>> -->
										</button></center>
				  					</td>
				  				</tr>
				  				<tr>
				  					<td colspan="2"><center>
				  						<button class="tsdbutton" id="bytcdels" 
											onclick="Bytc_Dels()"
											style="width:60px; height: 26px; margin-top: 3px; padding: 0px;">
											<fmt:message key="phone.getinternet0084" /><!-- 取消 -->
										</button></center>
				  					</td>
				  				</tr>
				 	 		</table>
				 	 	</td>
				 	 	<td valign="top">				 	 		
				 	 		<table id="dzhthcontent"  style="width:640px;">
				 	 			<tr>
									<th width="10"><input type="checkbox" id="bytctab_checkalls" onclick="Bytc_CheckALL('tc')" style="width:15px;" /></th>
									<th width="170">
										<center>
											<h4>
												<span id="spanTCLX_tables">套餐名称</span>
											</h4>
										</center>
									</th>
									<th width="635">
										<center>
											<h4>
												<span id="spanRemark_tables">套餐描述</span>
											</h4>
										</center>
									</th>
									<!-- 
									<th width="105">
										<center>
											<h4>
												<span id="spanTCLX_tables"><fmt:message key="phone.getinternet0087" /></span>
											</h4>
										</center>
									</th>
									<th width="100">
										<center>
											<h4>
												<span id="spanTCLX_tables">固定费</span>
											</h4>
										</center>
									</th>
									<th width="150">
										<center>
											<h4>
												<span id="spanTCLX_tables">包月费免费期数</span>
											</h4>
										</center>
									</th>
									<th width="140">
										<center>
											<h4>
												<span id="spanTCQSY_tables"><fmt:message key="phone.getinternet0088" /></span>
											</h4>
										</center>
									</th>
									<th width="140">
										<center>
											<h4>
												<span id="spanTCZZY_tables"><fmt:message key="phone.getinternet0089" /></span>
											</h4>
										</center>
									</th>
									 -->
								</tr>
				 	 		</table>
				 	 		<div style="width:640px; height: 120px; overflow-y: scroll; overflow-x: hidden;">
					 	 		<table id="bytctabs" style="width:640px;" >
									
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
				<!--  --><table cellspacing="8" >
					<tr>
				  		<td><fmt:message key="phone.getinternet0088" /><!-- 起始时间 --></td>
				  		<td><input type="text" name="TCStarttimes" id="TCStarttimes" 
							style="width: 100px;"  value="<%=Log.getSysTime() %>" disabled="disabled"/></td>
				  		<td><fmt:message key="phone.getinternet0089" /><!-- 终止时间 --></td>
				  		<td><input type="text" name="TCEndtimes" id="TCEndtimes" 
									style="width: 100px;" value="2999-12-31" disabled="disabled"/></td>
						<td>
							<!--<button id="dzpkg" onclick="getDZblock()"  class="tsdbutton"  style="margin-left: 20px;">打折</button>-->
						</td>	
						<td>
							<!--<input type="text" id="pkg_rateStr" disabled="disabled"/>-->
						</td>		
				    </tr>					
				</table>
			 </div>
			 
			 <!-- 专线信息BEGIN -->
					<div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/65.gif" />
						专线信息
						<font id="label_old_pl" color="red">（未安装专线）</font>
					</div>
					<div id="inputtext">
						<div class="midd">
						<table id="table_old_pl_title" style="width:780px;background-color:#A9C8D9;border:#A9C8D9 solid 0px;">
							<tr>
								<th width="30px" align="center">
									<h4>No.</h4>
								</th>
								<th width="70px">
									<h4>专线号</h4>
								</th>
								<th width="60px">
									<h4>专线类型</h4>
								</th>
								<th width="60px">
									<h4>起始端点</h4>
								</th>
								<th width="60px">
									<h4>终止端点</h4>
								</th>
								<th width="100px">
									<h4>租费</h4>
								</th>
								<th width="90px">
									<h4>开通日期</h4>
								</th>
								<th width="90px">
									<h4>失效日期</h4>
								</th>
								<th width="180px">
									<h4>专线描述</h4>
								</th>
								<th width="40px">
									<h4>状态</h4>
								</th>
							</tr>
						</table>					
						<table border="0" cellpadding="0" id="table_old_pl" style="width: 780px;">
						</table>					
						</div>
					</div>
			 <!-- 专线信息END -->
			 
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
									<td class="wenzi" style="visibility:hidden" >
										<fmt:message key="phone.getinternet0090" /><!-- 付费方式 -->
									</td>
									<td class="wenzix">
										<select name="fufeitype" id="fufeitype" style="visibility:hidden" class="you1" onchange="payWayChange(this)"></select>
									</td>
									<td class="wenzi">
										<fmt:message key="phone.getinternet0091" /><!-- 应交合计 -->
									</td>
									<td class="wenzix">
										<input type="text" name="yjfee" id="yjfee" style="width: 130px;" disabled="disabled"  class="you1" onkeypress="numValid(this)"
										onpaste="return !clipboardData.getData('text').match(/D/)" ondragenter="return   false"/>
								   </td>
								   <td>
								     <table id="bytctabs=======================" style="width:330px;background:#9AC0CD" border="1" cellpadding="0" bordercolor="#9AC0CD">
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
		
		<!-- 2、3、4模块局 -->
		<div class="neirong" id="mokuaijupanl" style="display: none;width:850px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">项目名称</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right">
						<a href="javascript:;"
							onclick="javascript:$('exitmkj').click();">关闭</a>
					</div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
			
				<div class="midd" >
				   <form action="#" name="queryform" id="queryform" onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td  width="15%" align="right">
								二级区域
							</td>
							<td>
								<select name='leveltwo' id="leveltwo" style="width: 120px;" onchange="checkmokuaiju(2)"></select>
							</td>
							<td  width="15%" align="right">
								三级区域
							</td>
							<td>
								<select name='levelthree' id="levelthree" style="width: 120px;" onchange="checkmokuaiju(3)"></select>
							</td>
							<td  width="15%" align="right">
								四级区域
							</td>
							<td>
								<select name='levelfour' id="levelfour" style="width: 120px;" onchange="checkmokuaiju(4)"></select>
							</td>
						</tr>
					</table>
					</form>
				</div>	
				
				<div class="midd_butt" style="width:830px">
						<button type="submit" class="tsdbutton" id="querythis" onclick="savemokuaiju()">
							确定
						</button>
						<button type="submit" class="tsdbutton" id="exitmkj">
							关闭
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
		<input type="hidden" id="jobidid" />
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
		<input type="hidden" id="startdate" value="<%=Log.getSysTime() %>"/><!-- 固定费用起始日期 -->
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
		
		<!-- 后级模块局 -->
		<input type="hidden" id="mkj2"/>
		<input type="hidden" id="mkj3"/>
		<input type="hidden" id="mkj4"/>
		
		<input type="hidden" id="username" value="<%=username%>"/>
		
		<select id="yhxz_hidden" style="display:none;"></select>
		<jsp:include page="phone_internet.jsp" flush="true"/>		
		<input type="hidden" id="businesstype" value="p_setup"/><!-- 该页面的业务类型 -->				
	</body>
	<script>
	var hilighter2 = new TableRowHilighter(document.getElementById('addspeediFeetype'), 0, 'lightsteelblue');
	var hilighter3 = new TableRowHilighter(document.getElementById('queryHTHdw'), 0, 'lightsteelblue');
  </script>
</html>
