<br>&gt;<%----------------------------------------
	name: Detail_Query.jsp
	author: wangli
	version: 1.0 
	description: 号线设备管理-明细表查询 
	Date: 2011-11-11
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
	<script type="text/javascript">
		//根据字段名和字段值查询raduserinfo表. 精确查找
		//该功能展示无用
		function query(){
			var fieldname; 
			var fieldvalue = $("#queryvalue").val();
			if ($("#queryfield").val()=="devname_q"){
				fieldname = "devname";
			}
			else{
				fieldname = "dh";
			}						
			//先清掉之前的选中记录状态
			$("#devDetail").resetSelection();			
	        var tab = document.getElementById("devDetail");
   			var Lenr = tab.rows.length;//取得表格行数
   			var s= "";
   			var cnt = 0;
   			for (i = 1; i < Lenr; i++){   			       			      			   
   			    //如果表格中的值等于查找值，则将该行选中   
   			    var s=$("#devDetail").getCell(i,fieldname);			    
   			    if (s == fieldvalue){
   			    	jQuery("#devDetail").setSelection(i, true);
   			    	cnt++;
   			    }
       		}
       		if (cnt >0){
				setTimeout($.unblockUI,15);
			}
			else{
				alert("没有符合条件的设备，请确认您的输入是否正确！");
				$("#queryvalue").select();
				$("#queryvalue").focus();
			}
		}
		//页面查询功能
		function queryNodeFuzzy(){
			var fieldname = ''; 
			var fieldvalue = $("#queryvalue").val();
			if ($("#queryfield").val()=="devname_q"){
				fieldname = "devname";
			}
			else{
				fieldname = "dh";
			}						
			var cond = "&cond= " +  encodeURIComponent(fieldname + " like '%" +fieldvalue + "%' ");
			
			//存放上级节点的编码方便获取该节点所在设备子树的层次数目
			var devid = $("#devid_level").val();	
			 
			var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.FuzzyQueryDevDetail','dbsql_route.GetFuzzyDevCount', 'route');
			urlstr += '&devid='+tsd.encodeURIComponent(devid)+'.' + cond;
			jQuery("#devDetail").setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");
			setTimeout($.unblockUI,15);														
		}
	</script>
</head>
	<div class="neirong" id="divQuery" style="width:450px;display: none">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<span id="Master_Title">设备查询</span>
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
		<div class="midd" style="background-color:#FFFFFF;align:center;height:100px;">			
			<div style="margin-top:50px;">	
				查询方式:<select id="queryfield" style="width: 90px;">
					<option value="devname_q">设备名称</option>
					<option value="dh_q">绑定电话</option>				
				</select>
			<!-- 	<span>等于</span>  -->
				<span>包含</span>
				<input type="text" id="queryvalue" style="width:200px;"/>
			</div>
		</div>			
		<div class="midd_butt" style="height:38px;">  
			<button onclick="queryNodeFuzzy();" class="tsdbutton" 
				style="margin-left: 20px;">
				查找
			</button>
			<button onclick="javascript:setTimeout($.unblockUI,15);" class="tsdbutton"  style="margin-left: 20px;">
				取消				
			</button>
		</div>
	</div>

    <input type="hidden" id="masterFlag"/>
    <input type="hidden" id="devno_m" style="width:300px;background:silver;ime-mode: disabled;display:none;" readonly="true";/>  <br /><br />
