<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/privateline/pl_new.jsp
    Function:   专线装机
    Author:     朱孟峰
    Date:       2016-06
    Description: 
    	p_setupchunk
    	p_deletechunk
    	p_movechunk
    Modify: 
     2016-06-14	Create；
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
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<!--  <base href="<%=basePath%>"> -->
		<title>My JSP 'pl_new.jsp' starting page</title>			
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
		<!-- 弹出面板需要导入javascript文件 -->
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
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
		<!--设置全局字体大小-->
		<link href="style/css/telephone/business/fontsize_all.css" rel="stylesheet" type="text/css"/>		
		<!-- 页面权限控制 -->
        <script type="text/javascript" src="script/public/tsdpower.js"></script>		        
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
		<script language="javascript">
		
		/*********
		* 初始加载
		* @param;
		* @return;
	    **********/
		jQuery(document).ready(function(){
			$("#navBar").append(genNavv());
			load_page();
		});	
		
		/********
		* 加载页面
		*********/
		function load_page() {
			var lt = $("#languageType").val();
	        $.ajax({
				url:"phone_querydate?func=query",
				async:true,//异步
				cache:false,
				timeout:20000,//1000表示1秒
				type:'post',
				success:function(xml,textStatus)
				{
					var yhlb_text = xml.substring(xml.indexOf("<yhlb_text=")+11,xml.indexOf("yhlb_text/>"));
					$("#Yhlb_hthdang").html(yhlb_text);
					
					var yhxz = xml.substring(xml.indexOf("<yhxz=")+6,xml.indexOf("yhxz/>"));
					$("#Yhxz_hthdang").html(yhxz);
										
					var CallPayType = xml.substring(xml.indexOf("<CallPayType=")+13,xml.indexOf("CallPayType/>"));
					$("#CallPayType_hthdang").html(CallPayType);
					
					var pl_type = xml.substring(xml.indexOf("<pl_type=")+9, xml.indexOf("pl_type/>"));
					$("#pl_type").html(pl_type);
					var pl_endpoint = xml.substring(xml.indexOf("<pl_endpoint=")+13, xml.indexOf("pl_endpoint/>"));
					$("#pl_endpoint").html(pl_endpoint);
					$("#pl_startpoint").html(pl_endpoint);	
				}
			});
			
			// 加载业务受理费
			load_fee_item();
			
			// 设置专线默认生效日期
			set_effective_date();
		}
		
        /********
        *设置专线默认生效日期为下月第一天
        *@param;
       	*@return;
        ********/
		function set_effective_date() {
			var d = new Date();
			var year = d.getFullYear();
			var month = d.getMonth() + 1;
			if (month >= 12) {
				year += 1;
				month = 1;
			} else {
				month += 1;
			}
			var sMonth = "";
			if (month < 10) {
				sMonth = "0" + month;
			} else {
				sMonth = "" + month;
			}
			var date = "" + year + "-" + sMonth + "-01";
			$("#pl_effective_date").val(date);
		}
		
        /********
        *点击选择合同号按钮，加载合同号并选择
        *@param;
       	*@return;
        ********/
        function show_hth_dlg() {
        	// 将查询条件传入对话框
        	$("#selecththvalue").val($("#cond_field").val());
        	$("#selecththcontent").val($("#cond_value").val());
        	// 显示对话框
        	autoBlockForm('selecthth',5,'close',"#ffffff",false);
        	// 查询
        	queryhthkey();
        }
        
        /********
        *点击选择合同号按钮，加载合同号并选择
        *@param;
       	*@return;
        ********/
        function queryhthkey() {
        	var cond_field = $("#selecththvalue").val();
        	var cond_value = $("#selecththcontent").val();
        	var sql_key = "";
        	var sql_param = "";
        	if (cond_value == "") {
        		sql_key = "hth.selecthth";
        		sql_param = "";
        	} else {
        		if (cond_field == "1") {
        			sql_key = "hth.selecththkey01dhparm";
        		} else if (cond_field == "2") {
        			sql_key = "hth.selecththkey02hthparm";
        		} else if (cond_field == "3") {
        			sql_key = "hth.selecththkey03mcparm";
        		}
        		sql_param = "&param=" + tsd.encodeURIComponent(cond_value);
        	}
        	var res = fetchMultiArrayValue(sql_key, 6, sql_param, "privateline");
        	
        	$("#selecththkey").empty();
        	if(res[0]==undefined || res[0][0]==undefined)
			{
				$("#selecththkey").append("<tr><td>"+$("#getinternet0366").val()+"</td></tr>");
				return false;
			}
            var ify="";
            for(var i=0;i<res.length;i++){
                ify +="<tbody>";
                ify += "<tr onClick=\"getHTHXZ('"+res[i][0]+"')\" onDblClick=\"getsavexzhth('"+res[i][0]+"')\" id=\""+res[i][0]+"\">";					
				ify += "<td style=\"width: 250px;height: 20px\"><center>";
				ify += res[i][0];
				ify += "</center></td>";
				ify += "<td width=\"250px;\"><center>";
				ify += res[i][1];
				ify += "</center></td>";
				ify += "<td width=\"500px;\"><center>";
				ify += res[i][2];
				ify += "</center></td>";
				ify +="</tr>";
				ify +="</tbody>";
            }
            $("#selecththkey").append(ify);
        }
        
        /********
       	*弹出选择合同好面板 点击信息时调用该方法
        *@param：key 合同号值;
       	*@return;
        *********/
        function getHTHXZ(key){
		      $("#selecththvaluekey").val(key);//把得到的单位合同号添加到隐藏域中点击确定的时候在从隐藏域中取
		      $("#selecththkey tr").css('background-color','#ffffff');
		      document.getElementById(key).style.background='#0080FF';        
        }

        /********
       	*弹出选择合同号面板后进行合同号选择
        *@param;
       	*@return;
        *********/
		function getsavexzhth(key){
			var hth = "";
			if(key=="djsave"){								
				hth = $("#selecththvaluekey").val();								
				if(hth == ""){
					//alert("请选择合同号！");
					alert($("#getinternet0047").val());
					return false;
				}
			} else {
				hth = key;
			}
			var res = fetchMultiArrayValue("Phoneinstalled.geththdangall", 6, "&Hth=" + hth);
			if(res[0]!=undefined||res[0][0]!=undefined){
				$("#Hth_hthdang").val(res[0][0]);
				$("#Dh_hthdang").val(res[0][1]);
				$("#Bm1_hthdang").val(res[0][6]);
				$("#Yhlb_hthdang").val(res[0][2]);
				$("#Yhxz_hthdang").val(res[0][3]);
				$("#CallPayType_hthdang").val(res[0][10]);
				$("#pl_contact").val(res[0][29]);
				$("#pl_phone").val(res[0][30]);
				
			} else {
				alert('Unknown error');
				return false;
			}
        	// 将查询条件传出对话框
        	$("#cond_field").val($("#selecththvalue").val());
        	$("#cond_value").val($("#selecththcontent").val());
        	// 关闭对话框
        	setTimeout($.unblockUI,15);
        	
        	load_old_pls(hth);
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
        		$("#label_old_pl").html("未安装任何专线");
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
        	//$("#div_old_pl").show();
        	$("#label_old_pl").html("");
        }
        
        /*************
        * pl_type_changed()
        * 专线类别改变时被调用
        * 	自动生成专线号
        *	重新载入专线租费
        *************/
        function pl_type_changed() {
        	generate_pl_id();
        	load_packages();
        }
        
        /*************
        * generate_pl_id()
        * 专线类别、起始端点和终止端点改变时被调用
        * 	自动生成专线号
        *************/
        function generate_pl_id() {
        	var pl_type = $("#pl_type").val();
        	var pl_startpoint = $("#pl_startpoint").val();
        	var pl_endpoint = $("#pl_endpoint").val();
        	if (pl_type == '' || pl_startpoint == '' || pl_endpoint == '') {
        		return;
        	}
        	var prefix = pl_type + pl_startpoint + pl_endpoint;
        	var params = "&prefix=" + prefix;
        	var res = fetchMultiPValue("PL.GetId", 6, params);
        	//alert(res);
        	$("#pl_id").val(res); 
        }
        
        /*************
        * load_packages
        * 加载可用的专线租费
        *************/
        function load_packages() {
        	$("#table_rental").empty();
			calc_pkg('', '', '', ''); // 清除已选资费
        	if ($("#pl_type").val() == '') {
				$("#table_rental").append("<tr><td><font color='red'>&nbsp;&nbsp;请选择专线类型以载入资费</font></td></tr>");
				return;
        	}
        	var service_type = "专线";
        	var sub_service_type = $("#pl_type").find("option:selected").text();
        	var params = "&service_type=" + tsd.encodeURIComponent(service_type) + 
        		"&sub_service_type=" + tsd.encodeURIComponent(sub_service_type);
        	var res = fetchMultiArrayValue("pl_getPackages", 6, params, "privateline");
        	if(res[0] == undefined || res[0][0] == undefined) {
				$("#table_rental").append("<tr><td><font color='red'>&nbsp;&nbsp;没有为" + sub_service_type + "类型的专线配置资费！</font></td></tr>");
				return;
        	}
            var ify = "";
            for(var i = 0; i < res.length; i++){
            	var pkg_type = (res[i][2] == '1' ? "年" : "月");
                ify +="<tbody>";
                ify += "<tr onClick=\"pkg_row_clicked('" 
                	+ res[i][0]+"','" 
                	+ res[i][1] + "','" 
                	+ pkg_type + "','" 
                	+ res[i][3] + "')\" id=\"pkg"+res[i][0]+"\">";
                ify += "<td style=\"width: 10px;height:20px\"></td>";					
				ify += "<td style=\"width: 190px;height: 20px\">" + res[i][1] + "</td>"; // 套餐名称
				ify += "<td style=\"width: 200px;height: 20px\">" + res[i][4] + "</td>"; // 套餐描述
				ify += "<td style=\"width: 100px;height: 20px\">" + sub_service_type + "</td>"; // 专线类型
				ify += "<td style=\"width: 100px;height: 20px\">" + pkg_type + "</td>"; // 专线类型
				ify += "<td style=\"width: 170px;height: 20px\" align=right>" + res[i][3] + "</td>"; // 资费
                ify += "<td style=\"width: 10px;height:20px\"></td>";					
				ify +="</tr>";
				ify +="</tbody>";
            }
            $("#table_rental").append(ify);
        }
        
        /*************
        * pkg_row_clicked()
        * 资费选择事件
        * 	重新计算资费
        *************/
        function pkg_row_clicked(pkg_id, pkg_name, pkg_type, pkg_price) {
		    $("#table_rental tr").css('background-color','#ffffff');
		    var key = "pkg" + pkg_id;
		    document.getElementById(key).style.background='#0080FF';
		    calc_pkg(pkg_id, pkg_name, pkg_type, pkg_price);        
        }
        
        /*************
        * discount_changed()
        * 折扣变化事件 - 重新计算资费
        *************/
        function discount_changed() {
        	var pp = parseFloat($("#pl_pkg_price").val());
        	var dr = 0;
        	if (!isNaN($("#pl_discount_rate").val())) {
        		dr = parseFloat($("#pl_discount_rate").val());
        		if (dr < 0 || dr > 100) {
        			dr = 0;
        		}
        	}
        	var dv = 0;
        	if (!isNaN($("#pl_discount_value").val())) {
        		dv = parseFloat($("#pl_discount_value").val());
        	}
        	var price = pp * (100 - dr) / 100 - dv;
        	//alert("dv=" + dv + ", dr=" + dr + ", pp=" + pp + ", price=" + price);
        	if (price < 0) {
        		price = pp;
        	}
        	
        	$("#pl_price").val(price);
        }
        
        /*************
        * calc_pkg(pkg_id, pkg_name, pkg_type, pkg_price)
        * 缓存已选套餐，并重新计算资费
        *************/
        function calc_pkg(pkg_id, pkg_name, pkg_type, pkg_price) {
		    $("#pl_pkg_id").val(pkg_id);
        	$("#pl_pkg_name").val(pkg_name);
        	$("#pl_pkg_type").val(pkg_type);
        	$("#pl_pkg_price").val(pkg_price);
        	$("#pl_price").val('0');
        	if (pkg_id == '' || pkg_price == '') {
        		return;
        	}
        	discount_changed();
        }
        
        /*************
        * load_fee_item()
        * 加载业务受理费
        *************/
        function load_fee_item() {
        	$("#table_bus_fee").empty();
        	$("#fi_item_count").val(0);
        	var sql = "pl.getFeeTypes";
        	var sql1 = "pl.getFeeItems";
        	var params = "&ywlx=p_setuptrunk";
        	var res = fetchSingleValue(sql, 6, params, "privateline");
        	if (res == undefined || res == '') {
        		$("#table_bus_fee").append("<tr><td><font color='red'>&nbsp;&nbsp;该项业务没有受理费用</font></td></tr>");
        		return;
        	} 
        	var feetypes = res.split("~");
        	
            var ify = "";
            var total = 0.00;
            $("#fi_item_count").val(feetypes.length);
            for(var i = 0; i < feetypes.length; i++){
            	var feetype = feetypes[i];
            	var parm = "&feetype=" + feetype;
            	var fee = fetchSingleValue(sql1, 6, parm, "privateline");
            	if (fee == undefined || fee == '') {
            		fee = 0;
            	}
            	var fi_id = "fi_" + i;
            	var fi_item_id = "fi_item_" + i;
            	var fi_fee_id = "fi_fee_" + i;
            	var fi_pay_id = "fi_pay_" + i;
            	var fi_remark_id = "remark_" + i;
            	var fi_discount_id = "fi_discount_" + i;
                ify +="<tbody>";
                ify += "<tr>";
                ify += "<td style=\"width: 10px;height:20px\"></td>";					
				ify += "<td style=\"width: 190px;height: 20px\">" + 
					"<input type='text' id='" + fi_item_id + "' style='width:185px' value='" + feetype + "' disabled='disabled'/>" + 
					"</td>"; // 收费项目
				ify += "<td style=\"width: 100px;height: 20px\">" + 
					"<input type='text' id='" + fi_fee_id + "' style='width:95px' value='" + fee + "' onchange='calc_bus_fee()'/>" + 
					"</td>"; // 应收费用
				ify += "<td style=\"width: 100px;height: 20px\">" + 
					"<input type='text' id='" + fi_discount_id + "' style='width:95px' value='" + fee + "' onchange='calc_bus_fee()'/>" + 
					"</td>"; // 减免
				ify += "<td style=\"width: 100px;height: 20px\">" + 
					"<input type='text' id='" + fi_pay_id + "' style='width:95px' value='0'  disabled='disabled'/>" + 
					"</td>"; // 实收费用
				ify += "<td style=\"width: 270px;height: 20px\" align=right>" + 
					"<input type='text' id='" + fi_remark_id + "' style='width:265px'/>" + 
					"</td>"; // 备注
                ify += "<td style=\"width: 10px;height:20px\"></td>";					
				ify +="</tr>";
				ify +="</tbody>";
				total += parseFloat(fee);
            }
            ify +="<tbody>";
            ify += "<tr>";
            ify += "<td style=\"width: 10px;height:20px\"></td>";					
			ify += "<td style=\"width: 190px;height: 20px\">合计</td>"; 
			ify += "<td style=\"width: 100px;height: 20px\"><font id='fi_fee_total' color='red'>" + total + "</font></td>"; // 应收合计
			ify += "<td style=\"width: 100px;height: 20px\"><font id='fi_discount_total' color='red'>" + total + "</font></td>"; // 减免合计
 			ify += "<td style=\"width: 100px;height: 20px\"><font id='fi_pay_total' color='red'>0</font></td>"; // 实收合计
			ify += "<td style=\"width: 270px;height: 20px\" align=right>" + "" + "</td>"; 
            ify += "<td style=\"width: 10px;height:20px\"></td>";					
			ify +="</tr>";
			ify +="</tbody>";
            $("#table_bus_fee").append(ify);
        }
        
        /*************
        * calc_bus_fee()
        * 应收和减免金额变化事件
        *	重新计算实收金额和合计
        *************/
       /*  function calc_bus_fee() {
        	var count = parseInt($("#fi_item_count").val());
        	//alert(count);
        	var fee_total = 0.0;
        	var pay_total = 0.0;
        	var discount_total = 0.0;
        	for (var i = 0; i < count; i++) {
        		//alert(isNaN($("#fi_fee_" + i).val()));
        		//alert(isNaN($("#fi_discount_" + i).val()));
        		if (isNaN($("#fi_fee_" + i).val())) {
        			alert('应收费用必须是数字，请重新输入');
        			$("#fi_fee_" + i).focus();
        			return;
        		}
        		if (isNaN($("#fi_pay_" + i).val())) {
        			alert('实收费用必须是数字，请重新输入');
        			$("#fi_pay_" + i).focus();
        			return;
        		}
        		var fee = parseFloat($("#fi_fee_" + i).val());
        		var pay = parseFloat($("#fi_pay_" + i).val());
        		var discount = fee - pay;
        		fee_total += fee;
        		discount_total += discount;
        		pay_total += pay;
        		$("#fi_discount_" + i).val(discount);
        	}
        	$("#fi_fee_total").html(fee_total);
        	$("#fi_discount_total").html(discount_total);
        	$("#fi_pay_total").html(pay_total);
        }
         */
        function calc_bus_fee() {
        	var count = parseInt($("#fi_item_count").val());
        	//alert(count);
        	var fee_total = 0.0;
        	var pay_total = 0.0;
        	var discount_total = 0.0;
        	for (var i = 0; i < count; i++) {
        		//alert(isNaN($("#fi_fee_" + i).val()));
        		//alert(isNaN($("#fi_discount_" + i).val()));
        		if (isNaN($("#fi_fee_" + i).val())) {
        			alert('应收费用必须是数字，请重新输入');
        			$("#fi_fee_" + i).focus();
        			return;
        		}
        		if (isNaN($("#fi_discount_" + i).val())) {
        			alert('减免费用必须是数字，请重新输入');
        			$("#fi_discount_" + i).focus();
        			return;
        		}
        		var fee = parseFloat($("#fi_fee_" + i).val());
        		var discount = parseFloat($("#fi_discount_" + i).val());
        		var pay = fee - discount;
        		fee_total += fee;
        		discount_total += discount;
        		pay_total += pay;
        		$("#fi_pay_" + i).val(pay);
        	}
        	$("#fi_fee_total").html(fee_total);
        	$("#fi_discount_total").html(discount_total);
        	$("#fi_pay_total").html(pay_total);
        }
         
         
         
         
         
        /*************
        * save_pl()
        * 保存
        *************/
        function save_pl() {
        	var hth = $("#Hth_hthdang").val();
        	if (hth == undefined || hth == '') {
        		alert("请选择合同号！");
        		return;
        	}
        	
        	var pl_type = $("#pl_type").val();
        	var pl_type_desc = $("#pl_type").find("option:selected").text();
        	if (pl_type == undefined || pl_type == '') {
        		alert("请选择专线类型");
        		return;
        	}
        	
        	var pl_startpoint = $("#pl_startpoint").val();
        	var pl_startpoint_desc = $("#pl_startpoint").find("option:selected").text();
        	if (pl_startpoint == undefined || pl_startpoint == '') {
        		alert("请选择起始端点");
        		return;
        	}
        	
        	var pl_endpoint = $("#pl_endpoint").val();
        	var pl_endpoint_desc = $("#pl_endpoint").find("option:selected").text();
        	if (pl_endpoint == undefined || pl_endpoint == '') {
        		alert("请选择终止端点");
        		return;
        	}
        	
        	var pl_id = $("#pl_id").val();
        	if (pl_id == undefined || pl_id == '') {
        		alert("请输入专线号");
        		return;
        	}
        	var pl_id_reg = /^(\w{3})(\d{4})$/;
        	if (pl_id.match(pl_id_reg) == null) {
        		alert("专线号的规则为3位字母加4位数字，如ELD0001");
        		return;
        	}
        	
        	var pl_effective_date = $("#pl_effective_date").val();
        	if (pl_effective_date == undefined || pl_effective_date == '') {
        		alert("请输入开通日期");
        		return;
        	}
        	var pl_ed_reg = /^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/;
        	if (pl_effective_date.match(pl_ed_reg) == null) {
        		alert("开通日期格式为YYYY-MM-DD，请重新输入");
        		return;
        	}
        	
        	var pl_pkg_id = $("#pl_pkg_id").val();
        	if (pl_pkg_id == undefined || pl_pkg_id == '') {
        		alert("请选择专线租费");
        		return;
        	}
        	
        	var pl_discount_rate = $("#pl_discount_rate").val();
        	var pl_discount_value = $("#pl_discount_value").val();
        	var pl_price = $("#pl_price").val();
        	if (isNaN(pl_price)) {
        		alert("专线资费输入错误，请重新输入");
        		return;
        	}
        	if (parseFloat(pl_price) < 0) {
        		alert("专线资费不允许为负值，请重新输入");
        		return;
        	}
        	
        	var fi_item_count = $("#fi_item_count").val();
        	var fi_pay_total = 0.0;
        	for (var i = 0; i < fi_item_count; i++) {
        		var fi_fee = $("#fi_fee_" + i).val();
        		var fi_discount = $("#fi_discount_" + i).val();
        		var fi_pay = $("#fi_pay_" + i).val();
        		if (isNaN(fi_fee) || isNaN(fi_discount) || isNaN(fi_pay)) {
        			alert("业务受理费必须是数字，请核对");
        			return;
        		}
        		fi_pay_total += fi_pay
        	}
        	if (fi_pay_total < 0) {
        		alert(fi_pay_total);
        		alert("业务受理费的实收合计不能为负数");
        		return;
        	}
        	
        	var params = "";
        	params += "&operator=" + tsd.encodeURIComponent($("#userid").val()) +
        			  "&hth=" + hth +
        			  "&dh=" + $("#Dh_hthdang").val() +
        			  "&pl_id=" + pl_id +
        			  "&pl_type=" + pl_type +
        			  "&pl_type_desc=" + tsd.encodeURIComponent(pl_type_desc) +
        			  "&startpoint=" + tsd.encodeURIComponent(pl_startpoint) +
        			  "&startpoint_desc=" + tsd.encodeURIComponent(pl_startpoint_desc) +
        			  "&endpoint=" + tsd.encodeURIComponent(pl_endpoint) +
        			  "&endpoint_desc=" + tsd.encodeURIComponent(pl_endpoint_desc) +
        			  "&contact=" + tsd.encodeURIComponent($("#pl_contact").val()) +
        			  "&phone=" + tsd.encodeURIComponent($("#pl_phone").val()) +
        			  "&address=" + tsd.encodeURIComponent($("#pl_address").val()) +
        			  "&remark=" + tsd.encodeURIComponent($("#pl_remark").val()) +
        			  "&effective_date=" + tsd.encodeURIComponent(pl_effective_date) +
        			  "&discount_rate=" + pl_discount_rate +
        			  "&discount_value=" + pl_discount_value +
        			  "&pl_desc=" + tsd.encodeURIComponent($("#pl_desc").val()) +
        			  "&pl_pkg_id=" + pl_pkg_id +
        			  "&pl_pkg_fee=" + pl_price;
        	var j = 0;
        	var fi_count = 0;
        	for (var i = 0; i < fi_item_count; i++) {
        		var fi_pay = $("#fi_pay_" + i).val();
        		if (parseFloat(fi_pay) > 0) {
        			params += "&fi_item_" + j + "=" + tsd.encodeURIComponent($("#fi_item_" + i).val());
        			params += "&fi_pay_" + j + "=" + fi_pay
        			j++;
        			fi_count++;
        		}
        	}
        	params += "&fi_item_count=" + fi_count;
        	var res = fetchMultiPValue("PL.Setup", 6, params);
        	if (res == "") {
        		alert("保存成功！");
        	} else {
        		alert(res);
        		return;
        	}
        	
        	reset_pl();
        }
        
        /*************
        * reset_pl()
        * 重置
        *************/
        function reset_pl() {
        	$("#Hth_hthdang").val("");
        	$("#Dh_hthdang").val("");
        	$("#Bm1_hthdang").val("");
        	$("#Yhlb_hthdang").val("");
        	$("#Yhxz_hthdang").val("");
        	$("#CallPayType_hthdang").val("");
        	$("#pl_type").val("");
        	$("#pl_startpoint").val("");
        	$("#pl_endpoint").val("");
        	$("#pl_id").val("");
        	$("#pl_desc").val("");
        	$("#pl_contact").val("");
        	$("#pl_phone").val("");
        	$("#pl_address").val("");
        	$("#pl_remark").val("");
        	set_effective_date();
        	$("#pl_pkg_id").val("");
        	$("#pl_pkg_name").val("");
        	$("#pl_pkg_type").val("");
        	$("#pl_pkg_price").val("");
        	$("#pl_discount_rate").val("0");
        	$("#pl_discount_value").val("0");
        	$("#pl_price").val("0");
        	pl_type_changed();
        	load_fee_item();
        }
        
		</script>
		
	<body>
	  	<!-- 导航栏 -->
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
				<!-- 查询条件 BEGIN -->		
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					合同号查询
				</div>
				<div id="inputtext">
					<table id="kdBar" style="margin-left: 10px;" cellspacing="10px">
						<tr>
							<td>
								查询方式
								<select id="cond_field" style="width:100px;">
									<option value="2">
										合同号
									</option>
									<option value="1">
										账单电话
									</option>
									<option value="3">
										部门名称
									</option>
								</select>
							</td>
							<td>
								<input type="text" class="" id="cond_value" name="cond_value" />
							</td>
							<td>
								<button class="tsdbutton" id="submitButton"
									onclick="show_hth_dlg()" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
									查找
								</button>
							</td>
							<td width="290"></td>
						</tr>
					</table>
				</div>
				<!-- 查询条件 END -->		
			
				<!-- 合同号信息 BEGIN -->
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					合同号信息
				</div>
				<div id="inputtext">
					<div class="midd">
						<table id="tablehthdang" style="width:780px;">
							<tr>
								<td class='wenzi'>合同号</td>
								<td class='wenzix'>
									<input type='text' name=Hth_hthdang id=Hth_hthdang  style='width: 130px;' disabled='disabled' />
								</td>
								<td class='wenzi'>账单电话</td>
								<td class='wenzix'>
									<input type='text' name=Dh_hthdang id=Dh_hthdang  style='width: 130px;' disabled='disabled' />
								</td>
								<td class='wenzi'>部门名称</td>
								<td class='wenzix'>
									<input type='text' name=Bm1_hthdang id=Bm1_hthdang  style='width: 130px;' disabled='disabled' />
								</td>
							</tr>
							<tr>
								<td class='wenzi'>用户类别</td>
								<td class='wenzix'>
									<select name=Yhlb_hthdang id=Yhlb_hthdang style='width: 130px;' disabled='disabled' />
								</td>
								<td class='wenzi'>用户性质</td>
								<td class='wenzix'>
									<select name=Yhxz_hthdang id=Yhxz_hthdang style='width: 130px;' disabled='disabled' />
								</td>
								<td class='wenzi'>付费策略</td>
								<td class='wenzix'>
									<select name=CallPayType_hthdang id=CallPayType_hthdang  style='width: 130px;' disabled='disabled' />
								</td>
							</tr>						
						</table>						
					</div>
				</div>
				<!-- 合同号信息 END -->

				<!-- 已建专线 BEGIN -->
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					已装专线
					<font color="red" id="label_old_pl">（未安装专线）</font>
				</div>
				<div id="inputtext" id="div_old_pl">
					<div class="midd">
						<table style="width:780px;background-color:#A9C8D9;border:#A9C8D9 solid 0px;">
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
						<div id="page" style="overflow-y:scroll;height:100px;">					
							<table border="0" cellpadding="0" id="table_old_pl" style="width: 780px;">
							</table>					
						</div>
					</div>
				</div>
				<!-- 已装专线 END -->
						
				<!-- 专线信息 BEGIN -->
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					新装专线
				</div>
				<div id="inputtext">
					<div class="midd">
						<table id="table_pl" style="width:780px;">
							<tr>
								<td class='wenzi'>专线类别</td>
								<td class='wenzix'>
									<select name=pl_type id=pl_type style='width: 130px;' onchange="pl_type_changed()"></select>
									<font color="red">*</font>
								</td>
								<td class='wenzi'>起始端点</td>
								<td class='wenzix'>
									<select name=pl_startpoint id=pl_startpoint style='width: 130px;' onchange='generate_pl_id()'></select>
									<font color="red">*</font>
								</td>
								<td class='wenzi'>终止端点</td>
								<td class='wenzix'>
									<select name=pl_endpoint id=pl_endpoint style='width: 130px;' onchange='generate_pl_id()'></select>
									<font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class='wenzi'>专线号</td>
								<td class='wenzix'>
									<input type='text' name='pl_id' id='pl_id'  style='width: 130px;'/>
									<font color="red">*</font>
								</td>
								<td class='wenzi'>专线描述</td>
								<td class='wenzix' colspan=3>
									<input type='text' name='pl_desc' id='pl_desc' style='width:390px;'/>
								</td>
							</tr>
							<tr>
								<td class='wenzi'>联系人</td>
								<td class='wenzix'>
									<input type='text' name='pl_contact' id='pl_contact' style='width: 130px;' />
								</td>
								<td class='wenzi'>联系电话</td>
								<td class='wenzix'>
									<input type='text' name='pl_phone' id='pl_phone' style='width: 130px;' />
								</td>
								<td class='wenzi'>联系地址</td>
								<td class='wenzix'>
									<input type='text' name='pl_address' id='pl_address'  style='width: 130px;' />
								</td>
							</tr>
							<tr>
								<td class='wenzi'>开通日期</td>
								<td class='wenzix'>
									<input type='text' name='pl_effective_date' id='pl_effective_date'  style='width: 130px;'/>
									<font color="red">*</font>
								</td>
								<td class='wenzi'>备注</td>
								<td class='wenzix' colspan="3">
									<input type='text' name='pl_remark' id='pl_remark' style='width:390px;'/>
								</td>
							</tr>
						</table>						
					</div>
				</div>
				<!-- 专线信息 END -->
				
				<!-- 租费 BEGIN -->
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					专线租费
				</div>
				<div id="inputtext">
					<div class="midd">
						<table style="width:780px;background-color:#A9C8D9;border:#A9C8D9 solid 0px;">
							<tr>
								<th width="10px"></th>
								<th width="190px">
									<h4>资费名称</h4>
								</th>
								<th width="200px">
									<h4>资费描述</h4>
								</th>
								<th width="100px">
									<h4>专线类型</h4>
								</th>
								<th width="100px">
									<h4>周期</h4>
								</th>
								<th width="170px" align="right">
									<h4>资费（元）</h4>
								</th>
								<th width="10px"></th>
							</tr>
						</table>					
						<div id="page" style="overflow-y:scroll;height:150px;">					
							<table border="0" cellpadding="0" id="table_rental" style="width: 780px;">
								<tr><td><font color='red'>&nbsp;&nbsp;请选择专线类型以载入资费</font></td></tr>												
							</table>					
						</div>
					</div>
				</div>
				<div id="inputtext">
					<div class="midd">
						<table id="table_pl" style="width:780px;">
							<tr>
								<td class='wenzi'>选定资费</td>
								<td class='wenzix'>
									<input type="hidden" name='pl_pkg_id' id='pl_pkg_id' value=''/>
									<input type="text" name='pl_pkg_name' id='pl_pkg_name' style='width: 150px;' disabled='disabled'/>
								</td>
								<td class='wenzi'>周期</td>
								<td class='wenzix'>
									<input type="text" name='pl_pkg_type' id='pl_pkg_type' style='width: 150px;' disabled='disabled'/>
								</td>
								<td class='wenzi'>资费（元）</td>
								<td class='wenzix'>
									<input type="text" name='pl_pkg_price' id='pl_pkg_price' style='width: 150px;' disabled='disabled'/>
								</td>
							</tr>
							<tr>
								<td class='wenzi'>减免率（%）</td>
								<td class='wenzix'>
									<input type='text' name='pl_discount_rate' id='pl_discount_rate' value='0' style='width: 150px;' onchange='discount_changed()'/>
								</td>
								<td class='wenzi'>减免额（元）</td>
								<td class='wenzix'>
									<input type='text' name='pl_discount_value' id='pl_discount_value' value='0' style='width: 150px;' onchange='discount_changed()'/>
								</td>
								<td class='wenzi'>实际资费（元）</td>
								<td class='wenzix'>
									<input type='text' name='pl_price' id='pl_price'  value='0' style='width: 150px;' disabled='disabled'/>
								</td>
							</tr>
						</table>						
					</div>
				</div>
				<!-- 租费 END -->
				
				<!-- 业务受理费 BEGIN -->
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					业务受理费
				</div>
				<div id="inputtext">
					<div class="midd">
						<table style="width:780px;background-color:#A9C8D9;border:#A9C8D9 solid 0px;">
							<tr>
								<th width="10px"></th>
								<th width="190px">
									<h4>收费项目</h4>
								</th>
								<th width="100px">
									<h4>应收（元）</h4>
								</th>
								<th width="100px">
									<h4>减免（元）</h4>
								</th>
								<th width="100px">
									<h4>实收（元）</h4>
								</th>
								<th width="270px">
									<h4>备注</h4>
								</th>
								<th width="10px"></th>
							</tr>
						</table>					
						<table border="0" cellpadding="0" id="table_bus_fee" style="width: 780px;">
							<tr><td><font color='red'>&nbsp;&nbsp;该项业务没有受理费用</font></td></tr>												
						</table>
						<input type="hidden" id="fi_item_count"/>					
					</div>
				</div>
				<!-- 业务受理费 END -->
				
			<div id="buttons">
				<center>
					<button id="save" onclick="save_pl()"
						style="margin-left: 20px;">
						<!-- 确定 -->
						<fmt:message key="Revenue.Save" />
					</button>
					<button id="reset" onclick="reset_pl()" style="margin-left: 20px;">
						<!-- 重置 -->
						<fmt:message key="AddUser.Reset" />
					</button>
				</center>
			</div>
				
			</div>
		</div>
		
		<!-- THESE HIDDEN FOR ALL PAGES -->
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
		
		<!-- DIALOG AND INTERNATIONAL -->
		<jsp:include page="phone_internet.jsp" flush="true"/>
		<input type="hidden" id="selecththvaluekey"/><!-- 选择合同号 单击时把值放到隐藏域 -->
				
	</body>
</html>