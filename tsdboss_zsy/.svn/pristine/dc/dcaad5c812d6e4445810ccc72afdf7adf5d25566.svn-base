<%-- 
	File Name:  yiji.jsp
    Function:   宽带业务受理（移机）
    Author:     liwen
    Date:       2011-02-25
    Description: 宽带修改地址
    Modify:     
    	2011-3-1 LIWEN modify   增加杂费处理
 --%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
	String area = (String) session.getAttribute("chargearea");
	String userareaid = (String) session.getAttribute("userarea");
	String depart = (String) session.getAttribute("departname");

	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
	
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title><fmt:message key="gjh.yidongdizhi" />
		</title>
		<meta http-equiv="description" content="this is my page" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<!-- 导入的js文件 -->
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<script src="style/js/mainStyle.js" type="text/javascript"></script>
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript"
			src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js"
			type="text/javascript"></script>
		<!-- tab滑动门需要导入的包 *注意路径 -->
		<script src="plug-in/jquery/jquery.tabs/jquery.history_remote.pack.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jquery.tabs/jquery.tabs.pack.js"
			type="text/javascript"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<!-- tab滑动门 需要导入的样式表 *注意路径-->
		<script type="text/javascript" src="css/tree/dtree.js"></script>
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js"
			type="text/javascript"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<!-- 收费结账专用js -->
		<script src="script/public/revenue.js" type="text/javascript"
			language="javascript"></script>
		<!-- 页面国际化 -->
		<script type="text/javascript" src="script/broadband/usercat/Internationalization.js"></script>
		<script type="text/javascript"
			src="script/broadband/business/broadbandservice.js"></script>	
		<script type="text/javascript" src="script/broadband/business/querycorpinfo.js"></script>
		<!-- 导入js文件结束 -->
		<!-- 导入css文件开始 -->
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs.css"
			type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs-ie.css"
			type="text/css" media="projection, screen" />
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<link href="style/css/public/tsd-css.css" rel="stylesheet"
			type="text/css" />
		<link rel="stylesheet" type="text/css" href="css/tree/dtree.css" />

		<!-- 导入css文件结束 -->
		<style type="text/css">
#input-Unit .title {
	width: 100%;
	height: 32px;
	background: url(style/images/public/kuangbg.jpg);
	border-bottom: 1px solid #C8D8E5;
	text-align: left;
	color: #3C3C3C;
}
</style>
		<!-- 双导航栏异常处理 -->
		<style type="text/css">
#navBar1 {
	height: 26px;
	background: url(style/images/public/daohangbg.jpg);
	line-height: 28px;
}

#yjbaseinfo {
	margin-left: 10px;
}

#yjbaseinfo tr {
	height: 32px;
}

#yjrenzheng {
	margin-left: 10px;
}

#yjrenzheng tr {
	height: 32px;
}

.tsdbtn {
	line-height: 28px;
	padding: 2px 12px 2px 12px;
	height: 28px;
	margin-top: 4px;
	margin-left: 5px;
	background: url(style/images/public/buttonbg.jpg) repeat-x;
	border: #CCCCCC 1px solid;
	cursor: pointer;
}

cas {
	float: left;
	width: 100%;
	height: 26px;
	background: url(style/images/public/daohangbg.jpg) repeat-x;
	line-height: 28px;
}
</style>
		<style type="text/css">
.button {
	width: 50px;
	height: 25px;
	background: url(style/images/public/buttonbg.jpg) repeat-x;
	border: #CCCCCC 1px solid;
	cursor: pointer;
	float: left; *
	float: none;
	border-top: #CCCCCC 1px solid;
	border-bottom: #CCCCCC 1px solid;
}

body {
	text-align: left
}

.neirong .midd #grid table {
	line-height: 18px;
}

.neirong .midd #queryHTHdw tr {
	line-height: 18px;
}
#dzhthcontent{border-collapse:collapse;border:#A9C8D9 solid 1px;}
		#dzhthcontent tr th,#dzhthcontent tr td{line-height:26px;border:#A9C8D9 solid 1px;}
		#dzhthcontent tr th{background-color:#A9C8D9;border:#A9C8D9 solid 0px;}
</style>
		<script language="javascript">
		function printReportV(reportName,params)
			{
				$("#p_i_f").attr("src","print.jsp"+"?report="+reportName+"&params="+params);				
			}
        </script>
		<script type="text/javascript">
    
  	/////////////////////////////////////////////////////////////////
	//     下拉-杂费类型获取值填入杂费项
	/////////////////////////////////////////////////////////////////	  
	   jQuery(document).ready(function()
	   {
		   //页面表头当前位置显示
	       $("#navBar").append(genNavv());
	
			$("#delete_fee").click(function() {
           		if($("#delete_fee").attr("checked") == true) {
           			$("#yingjiao").val("0");
           			$("#fjremark").attr("disabled","");                			
           		} else {
           			$("#yingjiao").val('100');
           			$("#fjremark").val('');
           			$("#fjremark").attr("disabled","");
           		}
           	});
            $("#delete_fee").attr("checked",false);
	    	   
		});
		
		function searchInfo(){
		
			var key=$("#kdSearchBox").val();
			if(key.indexOf('张三')>-1 || key.indexOf("10001")>-1 || key.indexOf('通信管理处')>-1){
				if($("#kdSearchWay").val()==0){
					$("#custno").val(key);
					$("#custname").val("张三");
					$("#bm1").val("通信管理处");
				}else if($("#kdSearchWay").val()==1){
					$("#custname").val(key);
					$("#custno").val("10001");
					$("#bm1").val("通信管理处");
				}else if($("#kdSearchWay").val()==2){
					$("#custname").val("张三");
					$("#custno").val("10001");
					$("#bm1").val(key);
				}
			
				$("#custaddr").val("通信管理处");
				$("#bm2").val("机务科");
				$("#bm3").val("");
				$("#custtype").val("办公");
				$("#linkman").val("张先生");
				$("#linkphone").val("62960775");
				
				
				var ify="";
		    	ify += "<tr>";
				ify += "<td  width=\"10\"><center>";
				ify += "<input type=\"checkbox\" id=\"v_dhzftab_check\"" + $("#busitype").val() +  "\" style=\"width:15px;\" />";
				ify += "</center></td>";
				ify += "<td width=\"90\"><center>";
				ify += "集群业务";
				ify += "</center></td>";
				ify += "<td width=\"60\"><center>";
				ify += "100";
				ify += "</center></td>";
				ify += "<td width=\"100\"><center>";
				ify += "2015-05-01";
				ify += "</center></td>";
				ify += "<td width=\"100\"><center>";
				ify += "2999-12-31";
				ify += "</center></td>";
				ify += "<td width=\"73\"><center>";
				ify += "1";
				ify += "</center></td>";
				ify += "<td width=\"73\"><center>";
				ify += "1";
				ify += "</center></td>";
				ify += "<tr>";
		    
		    	$("#dzhthcontent").append(ify);
				
				
				
			}else{
				alert("您查询的客户信息不存在！");
				return;
			}
			
			
		}
	     
	    
	    
	    function showBusiDetail(vals){
	    	if (vals==1){
	    		$("#starttime").val($("#curtime").val());
	    		$("#stoptime").val('2999-12-31');
	    		$("#price").val('100');
	    		$("#unit").val('1');
	    		$("#amount").val('1');
	    	}else if (vals=='2'){
	    		$("#starttime").val($("#curtime").val());
	    		$("#stoptime").val('2999-12-31');
	    		$("#price").val('200');
	    		$("#unit").val('1');
	    		$("#amount").val('1');
	    	}else if (vals=='3'){
	    		$("#starttime").val($("#curtime").val());
	    		$("#stoptime").val('2999-12-31');
	    		$("#price").val('300');
	    		$("#unit").val('1');
	    		$("#amount").val('1');
	    	}else if (vals=='4'){
	    		$("#starttime").val($("#curtime").val());
	    		$("#stoptime").val('2999-12-31');
	    		$("#price").val('400');
	    		$("#unit").val('1');
	    		$("#amount").val('1');
	    	}else if (vals=='5'){
	    		$("#starttime").val($("#curtime").val());
	    		$("#stoptime").val('2999-12-31');
	    		$("#price").val('500');
	    		$("#unit").val('1');
	    		$("#amount").val('1');
	    	}else{
	    		$("#starttime").val('');
	    		$("#stoptime").val('');
	    		$("#price").val('');
	    		$("#unit").val('');
	    		$("#amount").val('');
	    	}
	    	
	    }
	    
	    function addbusiinfo(){
	    	
	    	if($("#custno").val()=="" || $("#custno").val()==undefined){
	    		alert("请先查询客户信息！");
	    		return ;
	    	}
	    	
	    	if($("#busitype").val()=="-1"){
	    	
	    		alert("请选择订购业务！");
	    		return;
	    		
	    	}
	    	
	    	var ify="";
	    	ify += "<tr  align=\"center\">";
			ify += "<td  width=\"10\">";
			ify += "<input type=\"checkbox\" id=\"v_dhzftab_check\"" + $("#busitype").val() +  "\" style=\"width:15px;\" />";
			ify += "</td>";
			ify += "<td width=\"90\">";
			ify += $("#busitype").find("option:selected").text();
			ify += "</td>";
			ify += "<td width=\"60\">";
			ify += $("#price").val();
			ify += "</td>";
			ify += "<td width=\"100\">";
			ify += $("#starttime").val();
			ify += "</td>";
			ify += "<td width=\"100\">";
			ify += $("#stoptime").val();
			ify += "</td>";
			ify += "<td width=\"73\">";
			ify += $("#unit").val();
			ify += "</td>";
			ify += "<td width=\"73\">";
			ify += $("#amount").val();
			ify += "</td>";
			ify += "<tr>";
	    
	    	$("#dzhthcontent").append(ify);
	    }   		   
		
		function deletebusirow(){
			 
			 $("#dzhthcontent tr").each(function(i){
		       var chk=$(this).find("input[type='checkbox']");
		       if(chk.attr("id")!="dhzftab_checkall")//不能删除标题行
		       {
			       if(chk.attr("checked"))
			       {
			          $(this).remove();
			       }
		       }
		    });
			
		}
		
		/********
         	*选中所有的电话杂费项
         	*@param;
     	  	*@return;
        	********/
	    function Dhzf_CheckAll()
	    {
	    	if($("#dhzftab_checkall").attr("checked"))
        		$("input[id^='v_dhzftab_check']").attr("checked","checked");
        	else
        		$("input[id^='v_dhzftab_check']").removeAttr("checked");
	    }	
		    
		    
 		function onSave(){

 			alert("操作成功！");
 			clearall();
 		}		    
 		
 		
 		function clearall(){
 			
 				$("#custname").val("");
				$("#custno").val("");
				$("#bm1").val("");
			
				$("#custaddr").val("");
				$("#bm2").val("");
				$("#bm3").val("");
				$("#custtype").val("");
				$("#linkman").val("");
				$("#linkphone").val("");
				
				$("#busitype").val('-1');
				$("#starttime").val('');
	    		$("#stoptime").val('');
	    		$("#price").val('');
	    		$("#unit").val('');
	    		$("#amount").val('');
 		
 		}
 		
       </script>
	</head>
	<body>

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
									key="gjh.houtuei" />
							</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div id="broadband_frame">
			<div id="input-Unit">				
				<div id="inputtext">
					<table id="kdBar" style="margin-left: 35px;margin-top: 5px;">
						<tr>
							<td width="65">
								<fmt:message key="broadband.querytype" />
							</td>
							<td width="80">
								<!-- 查询方式 -->
								<select id="kdSearchWay" onchange="closequery()">
									<option value="0">客户号 </option>
									<option value="1">用户名</option>
									<option value="2">部门</option>
								</select>
							</td>
							<td width="80">
								<input type="text" class="" id="kdSearchBox" name="kdSearchBox" />
							</td>
							<td width="160">
								<button class="tsdbutton" id="kdSearchByUserName" style="margin-top: 0px;" onclick="searchInfo();">
									<fmt:message key="Revenue.bSearch" />
									<!-- 查找 -->
								</button>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<form action="#" onsubmit="return false;" name="form1" id="form1"
				method="post">
				<div id="input-Unit">
						<div class="title">
							&nbsp;&nbsp;
							<img src="style/icon/65.gif" />基本信息						
						</div>
						<div id="inputtext">
						<p>
							<label style="width: 70px">客户号  </label>
						    <input type="text" name="custno" id="custno" disabled="disabled" style="width: 130px" />
							<label style="width: 70px">客户名称 </label>
							<input type="text" name="custname" id="custname" disabled="disabled" style="width: 130px"></input>
							<label style="width: 70px">客户地址 </label>
							<input type="text" name="custaddr" id="custaddr" disabled="disabled" style="width: 130px" />
						</p>
						<p>
						    <label  style="width: 70px">一级部门 </label>
						    <input type="text"  id="bm1" disabled="disabled" style="width: 130px" />
						    <label style="width: 70px">二级部门 </label>
							<input type="text"  id="bm2" disabled="disabled" style="width: 130px"/>
							<label style="width: 70px">三级部门 </label>
							<input type="text"  id="bm3" disabled="disabled" style="width: 130px" />
					   </p>
						<p>	
							<label style="width: 70px">客户性质 </label>		
							<input type="text" id="custtype" disabled="disabled" style="width: 130px" />
							
							<label style="width: 70px">联系人</label>
							<input type="text"  id="linkman"
								class="required date"
								onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								disabled="disabled" style="width: 130px" />
							
							<label style="width: 70px">联系电话</label>
							<input type="text"  id="linkphone"
								class="required date"
								onfocus="WdatePicker({startDate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
					   			disabled="disabled" style="width: 130px" />
					   </p>				
					</div>
					
					<div class="title" >
							&nbsp;&nbsp;
							<img src="style/icon/45.gif" />业务信息
					</div>
					<div id="inputtext" >
						<p>
						   <table id="dzhthcontent"  style="width:700px;">
				 	 			<tr>
									<th width="10"><input type="checkbox" id="dhzftab_checkall" onclick="Dhzf_CheckAll()" style="width:15px;" /></th>
									<th width="150">
										<center>
											<h4>
												<span id="spanFeeName1">业务名称</span>
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
												起始时间
											</h4>
										</center>
									</th>
									<th width="100">
										<center>
											<h4>
												终止时间
											</h4>
										</center>
									</th>
									<th width="75">
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
									</th>
								</tr>
				 	 		</table>
				 	   </p>
					   <p>
						   <label  style="width: 70px">业务类型 </label>
						    <select id="busitype" style="width: 130px" onchange="showBusiDetail(this.value);">
						    	<option value="-1">--请选择--</option>
						    	<option value="1">集群业务</option>
						    	<option value="2">光缆业务</option>
						    	<option value="3">数字链路业务</option>
						    	<option value="4">VPN</option>
						    	<option value="5">无线数据虚拟网业务</option>
						    </select>
						    <label style="width: 70px">起始日期 </label>
							<input type="text"  id="starttime" disabled="disabled" style="width: 130px"/>
							<label style="width: 70px">截止日期 </label>
							<input type="text"  id="stoptime" disabled="disabled" style="width: 130px" />
						</p>  						
						<p>
							<label  style="width: 70px">价格 </label>
						    <input type="text"  id="price" disabled="disabled" style="width: 130px" />
						    <label style="width: 70px">单位 </label>
							<input type="text"  id="unit" disabled="disabled" style="width: 130px"/>
							<label style="width: 70px">数量 </label>
							<input type="text"  id="amount" disabled="disabled" style="width: 130px" />
						</p>
						<p>
							<button class="tsdbutton" id="dhzfsave"
										onclick="addbusiinfo()"
										style="width:60px; height: 26px; padding: 0px;">
										新增
										</button>
						    <button class="tsdbutton" id="dhzfdel"
										onclick="deletebusirow();"
										style="width:60px; height: 26px; padding: 0px;">
										删除
										</button>							
						</p>
					</div>
					
					<div class="title" >
							&nbsp;&nbsp;
							<img src="style/icon/45.gif" />费用信息
					</div>
					<div id="inputtext" >	
						 <p>
						 	<label  style="width: 70px">一次性费</label>
						   	<input type="text" name="yingjiao" id="yingjiao" disabled="disabled" style="width: 130px" value="100"/>
						    
						    <label  style="width: 70px">费用合计</label>
						   	<input type="text" name="yingjiao" id="yingjiao" disabled="disabled" style="width: 130px" value="100"/>
						    
						    <label style="width: 64px;display: none;"></label>
						    <input type="checkbox" id="delete_fee" disabled="disabled" style='width:18px;height:18px;display: none;'/>
						    <label  style="width: 120px;text-align:left;display: none;">免除一次性费</label>
						  </p>  						
						<p>
							<label  style="width: 70px">备注</label>&nbsp;&nbsp;&nbsp;&nbsp;
						    <textarea name="fjremark" id="fjremark" disabled="disabled" title="备注长度不能超过250个字符！" cols="90" rows="3" onkeydown="if(this.value.length>500){alert('备注信息最大长度为250个字符');this.value=this.value.substring(0,100);event.returnValue=false;}"></textarea>
						    <font color="red">*</font>
						</p>
					</div>
					
					</div>

					<div id="buttons">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button id="closesave" onclick="onSave()">
							确定
						</button>
						<button id="closequxiao" onclick="clearall()">
							<!-- 取消 -->
							<fmt:message key="Revenue.Cancel" />
						</button>
					</div>
				</div>
				
				<input type="hidden" id="curtime" value="<%=Log.getSysTime() %>" />

	</body>
</html>