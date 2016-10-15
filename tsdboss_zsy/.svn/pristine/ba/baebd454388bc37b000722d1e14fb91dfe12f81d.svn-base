<%@ page language="java" import="java.util.*,java.text.*" pageEncoding="UTF-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat hzdf = new SimpleDateFormat("yyyyMM");
	Calendar cld = Calendar.getInstance(); 
	cld.setTime(new Date());
	cld.add(Calendar.MONTH,-1);
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
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
	<!-- 分项卡 -->
	<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
	<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen" />
	
	<script src="plug-in/jquery/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
	<!-- 弹出对话框需要导入的js文件 -->
	<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
	<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
	<!-- dtree需要导入文件 -->
	<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
	<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />
	<!-- 关于字符串需要用到的js -->
	<script type="text/javascript" src="script/public/main.js"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<!-- 新的面板样式 -->
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<!-- 验证框架需要导入的js文件 -->
	<script src="plug-in/jquery/validate/jquery.validate.js" type="text/javascript"></script>
  	<!-- 操作列样式 -->
	<script src="script/public/public.js" type="text/javascript"></script>
	<!-- 验证数据长度附 -->
	<script type="text/javascript" src="script/telephone/sysdataset/infotest.js"></script>
	<script src="script/public/datalength.js" type="text/javascript"></script>
	<!-- 菜单样式 -->
	<link rel="stylesheet" href="style/css/telephone/usermanagement/single_thirteen.css" type="text/css" />
	<!-- 时间插件 -->
	<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
	<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
	<style type="text/css">
	.tsdbutton{margin-bottom:-2px;margin-top:2px;}
	div,span{font-size:14px;}
	</style>
	<script>
	$(function(){
		$("#navBar").append(genNavv());
		gobackInNavbar("navBar");
		
		var res = fetchMultiArrayValue("VirtualNatwork.queryarea",6,"");
		if(res[0]!=undefined && res[0][0]!=undefined)
		{
			var optHtml = "<option value=\"\">请选择</option>";
			for(var ii=0;ii<res.length;ii++)
			{
				optHtml = optHtml + "<option value=\"" + res[ii][0] + "\">" + res[ii][0] + "</option>";
			}
			$("#xnwarea").html(optHtml);
		}
	});
	
	function changearea(){
		var area = $("#xnwarea").val();

		$("#VirtualNatworkNumber").empty();
		var devices = fetchMultiArrayValue("VirtualNatwork.queryyhdang",6,"&bz2=" + tsd.encodeURIComponent(area));
		if(typeof devices[0]=='undefined' || typeof devices[0][0]=='undefined')
			return false;
		var linesss = "";
		for(var i=0;i<devices.length;i++)
		{
			linesss += "<tr><td><input type='checkbox' id=\"v_xnw_changecheck\"" + devices[i][0] +  "\" style='width:30px;'/><span style='display:none;'>"+ devices[i][0]+"</span></td><td><a href='javascript:void(0)' onClick=changexddhkey('"+devices[i][0]+"'); id="+devices[i][0]+">"+devices[i][0]+"__("+devices[i][1]+")</a></td></tr>";
		}
		$("#VirtualNatworkNumber").append(linesss);
	}
	
	function queryyhdangdh(){
		var iphone = $("#iphone").val().replace(/(^\s*)|(\s*$)/g,"");
		if(iphone==""){
			alert("请输入查询条件");return;
			$("#iphone").select().focus();
		}
		$("#allDevice").empty();
		var res = fetchMultiArrayValue("VirtualNatwork.queryyhdangarray",6,"&dh="+iphone);
		if(typeof res[0]=='undefined' || typeof res[0][0]=='undefined')
			return false;
		var linesss = "";
		for(var i=0;i<res.length;i++)
		{
			linesss += "<tr><td><input type='checkbox' style='width:30px;' id=\"v_changecheck\"" + res[i][0] +  "\" /><span style='display:none'>"+res[i][0]+"</span></td><td><a href='javascript:void(0)' onClick=changedhkey('"+res[i][0]+"'); id="+res[i][0]+">"+res[i][0]+"__("+res[i][1]+")</a></td></tr>";
		}
		$("#allDevice").append(linesss);
		if(iphone.length!=7){
			$("#yhmc").val(res[0][1]);
			$("#yhdz").val(res[0][3]);
			$("#Bm1").val(res[0][4]);
			$("#Bm2").val(res[0][5]);
			$("#Bm3").val(res[0][6]);
			$("#Bm4").val(res[0][7]);
			$("#ywarea").val(res[0][8]);
		}else{
			$("#yhmc").val("");
			$("#yhdz").val("");
			$("#Bm1").val("");
			$("#Bm2").val("");
			$("#Bm3").val("");
			$("#Bm4").val("");
			$("#ywarea").val("");
		}
	}
	
	/********
     *选中所有的电话
     *@param;
     *@return;
     ********/
   function Dhzf_CheckAll()
   {
		if($("#changecheck").attr("checked")){
			if(confirm("确定将所有电话都选中为要添加的电话中吗？")){
	        	$("input[id^='v_changecheck']").attr("checked","checked");
	        }else{
	        	$("#changecheck").removeAttr("checked");
	        }
	    }else{
	        $("input[id^='v_changecheck']").removeAttr("checked");
	    }    
	 }
	
	function changecheckadd(){
		var checkedDhzf = $("input[id^='v_changecheck'][checked]");
	     var count = $(checkedDhzf).size();	        	
	        if(count<1)
	        {
	        	alert("请选择要添加的电话号码");
	        	return false;
	        }
	    if($("#xnwarea").val()==""){
	    	alert("请选择虚拟网类型！");
	    	$("#xnwarea").select().focus();
	    	return;
	    }    
	    var str="";   
	    for(var i=0;i<count;i++)
	    {
	        checkdh = $(checkedDhzf[i]).parent().text();
	        str +="'"+checkdh+"',";
	    }    	
	    str = str.substr(str,str.length-1);
	    if(confirm("你确定将选中的电话添加到虚拟网中吗？")){
	    	//VirtualNatwork.OperatingYhdangBz2
		    var resultTmp = fetchMultiPValue("VirtualNatwork.OperatingYhdangBz2",6,"&dh="+str+"&xnwarea="+tsd.encodeURIComponent($("#xnwarea").val())+"&opentype=add");     		
		    if(resultTmp[0][0]==undefined||resultTmp[0][0]=="")
		    {
		      	result = false;
		      	alert("电话"+str+"添加失败！");
		     }else{
		     	alert("电话"+str+"已成功添加到虚拟网中！");
		     	$("#valuecontext text").val("");
		     	changearea();
		     	queryyhdangdh();
		     }
		 }
	}
	
	function queryyhdangdh_xnw(){
		var iphone = $("#iphone_xn").val().replace(/(^\s*)|(\s*$)/g,"");
		if(iphone==""){
			alert("请输入查询条件");return;
			$("#iphone").select().focus();
		}
		$("#VirtualNatworkNumber").empty();
		var res = fetchMultiArrayValue("VirtualNatwork.queryyhdangarray_xnw",6,"&dh="+iphone+"&bz2="+tsd.encodeURIComponent($("#xnwarea").val()));
		if(typeof res[0]=='undefined' || typeof res[0][0]=='undefined')
			return false;
		var linesss = "";
		for(var i=0;i<res.length;i++)
		{
			linesss += "<tr><td><input type='checkbox' id=\"v_xnw_changecheck\"" + res[i][0] +  "\" style='width:30px;'/><span style='display:none;'>"+res[i][0]+"<span></td><td><a href='javascript:void(0)' onClick=changexddhkey('"+res[i][0]+"'); id="+res[i][0]+">"+res[i][0]+"__("+res[i][1]+")</a></td></tr>";
		}
		$("#VirtualNatworkNumber").append(linesss);
		if(iphone.length!=7){
			$("#yhmc_xn").val(res[0][1]);
			$("#bz2_xn").val(res[0][2]);
			$("#bz3_xn").val(res[0][3]);
			$("#yhdz_xn").val(res[0][3]);
			$("#Bm1_xn").val(res[0][4]);
			$("#Bm2_xn").val(res[0][5]);
			$("#Bm3_xn").val(res[0][6]);
			$("#Bm4_xn").val(res[0][7]);
			$("#ywarea_xn").val(res[0][8]);
		}else{
			$("#yhmc_xn").val("");
			$("#bz2_xn").val("");
			$("#bz3_xn").val("");
			$("#yhdz_xn").val("");
			$("#Bm1_xn").val("");
			$("#Bm2_xn").val("");
			$("#Bm3_xn").val("");
			$("#Bm4_xn").val("");
			$("#ywarea_xn").val("");
		}
	}

	/********
     *选中所有的虚拟网电话
     *@param;
     *@return;
     ********/
   function Dhzf_CheckAll_xnw()
   {
		if($("#xnw_changecheck").attr("checked")){
			if(confirm("确定将所有电话都选中为要添加的电话中吗？")){
	        	$("input[id^='v_xnw_changecheck']").attr("checked","checked");
	        }else{
	        	$("#xnw_changecheck").removeAttr("checked");
	        }
	    }else{
	        $("input[id^='v_xnw_changecheck']").removeAttr("checked");
	    }    
	 }
	
	function changecheckdelete(){
		var str="";
		var checkedDhzf = $("input[id^='v_xnw_changecheck'][checked]");
	     var count = $(checkedDhzf).size();	        	
	        if(count<1)
	        {
	        	alert("请选择要移除的虚拟网电话号码");
	        	return false;
	        }	
	    for(var i=0;i<count;i++)
	    {
	        checkdh = $(checkedDhzf[i]).parent().text();
	        str +="'"+checkdh+"',"	       
	    }    	
	    str = str.substr(str,str.length-1);   
	    alert(str); 	
	    if(confirm("你确定将选中的电话从虚拟网中取消吗？")){
	    	//VirtualNatwork.OperatingYhdangBz2
		    var resultTmp = fetchMultiPValue("VirtualNatwork.OperatingYhdangBz2",6,"&dh="+str+"&xnwarea="+tsd.encodeURIComponent($("#xnwarea").val())+"&opentype=delete");     		
		    if(resultTmp[0][0]==undefined||resultTmp[0][0]=="")
		    {
		      	result = false;
		      	alert("电话"+str+"取消失败！");
		     }else{
		     	alert("电话"+str+"已成功从虚拟网中取消！");
		     	$("#valuecontext text").val("");
		     	changearea();
		     	queryyhdangdh();
		     }
		 }	    
	}
	
	function changedhkey(key){
		$("#allDevice a").css('background-color','#ffffff');			
		document.getElementById(key).style.background='#bbbbbb';
		var res = fetchMultiArrayValue("VirtualNatwork.queryyhdangarray",6,"&dh="+key);
		if(typeof res[0]=='undefined' || typeof res[0][0]=='undefined')
			return false;
			$("#yhmc").val(res[0][1]);
			$("#yhdz").val(res[0][3]);
			$("#Bm1").val(res[0][4]);
			$("#Bm2").val(res[0][5]);
			$("#Bm3").val(res[0][6]);
			$("#Bm4").val(res[0][7]);
			$("#ywarea").val(res[0][8]);
	}
	
	function changexddhkey(key){
		$("#VirtualNatworkNumber a").css('background-color','#ffffff');			
		document.getElementById(key).style.background='#bbbbbb';		
		var res = fetchMultiArrayValue("VirtualNatwork.queryyhdangarray_xnw",6,"&dh="+key+"&bz2="+tsd.encodeURIComponent($("#xnwarea").val()));
		if(typeof res[0]=='undefined' || typeof res[0][0]=='undefined')
			return false;
			$("#yhmc_xn").val(res[0][1]);
			$("#yhdz_xn").val(res[0][3]);
			$("#bz2_xn").val(res[0][2]);
			$("#Bm1_xn").val(res[0][4]);
			$("#Bm2_xn").val(res[0][5]);
			$("#Bm3_xn").val(res[0][6]);
			$("#Bm4_xn").val(res[0][7]);
			$("#ywarea_xn").val(res[0][8]);
	}
	</script>
  </head>
  <body>
    <div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:
	</div>
	<div align=left>
		<table id="valuecontext">
			<tr>
				<td style="background:#f7f7f7;">
					<center>
					<p>查询电话号码</p>
					<p><input type="text" id="iphone" style="width:130px;"/><button onClick="queryyhdangdh();">查询</button></p></br>
					</center>
					<p>用户名称：<input type="text" id="yhmc" style="width:160px;" disabled/></p></br>
					<p>用户地址：<input type="text" id="yhdz" style="width:160px;" disabled/></p></br>
					<p>一级部门：<input type="text" id="Bm1" style="width:160px;" disabled/></p></br>
					<p>二级部门：<input type="text" id="Bm2" style="width:160px;" disabled/></p></br>
					<p>三级部门：<input type="text" id="Bm3" style="width:160px;" disabled/></p></br>
					<p>四级部门：<input type="text" id="Bm4" style="width:160px;" disabled/></p></br>
					<p>所属区域：<input type="text" id="ywarea" style="width:160px;" disabled/></p></br>
				</td>
				<td>
					<table id="containerr" align="center" border="1" bordercolor="#999999" style="margin-top:5px;border-collapse:separate">
						<tr>
							<td width="220" align="left" valign="top" style="border-width:0px;font-weight:bold;"><input type="checkbox" id="changecheck" onClick="Dhzf_CheckAll()"/><!-- 所有路由设备 -->待添加电话</td><td width="60" style="border-width:0px;"></td>
							<td width="220" align="left" style="border-width:0px;font-weight:bold;"><input type="checkbox" id="xnw_changecheck" onClick="Dhzf_CheckAll_xnw()"/><!-- 已选路由设备 -->虚拟网电话--<select id="xnwarea" style="width:120px;" onChange="changearea();"></select></td>
						</tr>
						<tr>
							<td width="220" align="left" valign="top">
								<div id="allDevicediv" style="height:400px;overflow-y:scroll;padding-left:20px;">
									<table id="allDevice"></table>
								</div>
							</td>
							<td align="center" style="height:320px;border-width:0px;">
								<p><button id="add" class="tsdbutton" onClick="changecheckadd();">添加&gt;&gt;</button></p><br />
								<p><button id="delete" class="tsdbutton" onClick="changecheckdelete();">&lt;&lt;删除</button></p><br />
							</td>
							<td width="220" align="left" valign="top">
								<div id="VirtualNatworkNumberdiv" style="height:400px;overflow-y:scroll;padding-left:20px;">
									<table id="VirtualNatworkNumber"></table>
								</div>
							</td>
						</tr>
					</table>
				</td>
				<td style="background:#f7f7f7;">
					<center>
					<p>查询虚拟网号码</p>
					<p><input type="text" id="iphone_xn" style="width:130px;"/><button onClick="queryyhdangdh_xnw();">查询</button></p></br>
					</center>
					<p>所属虚拟网：<input type="text" id="bz2_xn" style="width:147px;" disabled/></p></br>
					<p>用户名称：<input type="text" id="yhmc_xn" style="width:160px;" disabled/></p></br>
					<p>用户地址：<input type="text" id="yhdz_xn" style="width:160px;" disabled/></p></br>
					<p>一级部门：<input type="text" id="Bm1_xn" style="width:160px;" disabled/></p></br>
					<p>二级部门：<input type="text" id="Bm2_xn" style="width:160px;" disabled/></p></br>
					<p>三级部门：<input type="text" id="Bm3_xn" style="width:160px;" disabled/></p></br>
					<p>四级部门：<input type="text" id="Bm4_xn" style="width:160px;" disabled/></p></br>
					<p>所属区域：<input type="text" id="ywarea_xn" style="width:160px;" disabled/></p></br>
				</td>
			</tr>	
		</table>		
			</div>
			<div id="buttons" style="text-align:center;margin-top:12px;">				
			</div>

	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid%>' />
	<input type="hidden" id="zid" name="zid" value='<%=zid%>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType%>' />
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea")%>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea")%>' />
	<input type="hidden" id="skrid" name="skrid" value='<%=session.getAttribute("userid")%>' />
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />	
	<input type="hidden" id="ableForOtherArea" name="ableForOtherArea" value="false" />
	<input type="hidden" id="ableJfDetail" name="ableJfDetail" />
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
  </body>
</html>
