<br>
&gt;
<%----------------------------------------
	name: RouteAddrUpdate.jsp
	author: yhy
	version: 1.0 
	description: 号线路由管理-修改用户地址
	Date: 2012-6-25
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
	<script type="text/javascript">
		/*
		*修该用户地址
		*dh ：
		*rowid ：
		*MoKuaiJu ：
		*/
		function openUserAddr(dh,rowid,MoKuaiJu){
			//将该行设置为选中
			$('#grid_user').setSelection(rowid, true);
			
			//是否有操作权限验证
			var isModMKJJRigth = '' ;
			//admin和数据管理员、管理员权限组拥有全部权限，其他权限组的工号
				//根据scddbm表中配置的信息进行权限控制
			if(useridd != 'admin' && userGroupId ==1 && userGroupId == 2){
				var isRight = isModMKJ.charAt(MoKuaiJu);
				if(isRight == '' ){
					alert("您没有该模块配线权限。");
					return ;
				}
			}
						
			queryAddress(dh);
			autoBlockFormAndSetWH('divRouteAddress',30,'100px','RouteAddressclose',"#ffffff",false,'', '');			
		}
		
		//更新用户地址
		function updateUserAddr(){
			var userAddr = $("#ghSearchBox").val();
			//2012-8-27 yhy start			
			//允许地址清空
			/*
			if (userAddr == '') {
				alert("请输入修改地址。");
				$("#ghSearchBox").focus();
				return false;
			}
			*/
			//2012-8-27 yhy end
			var dhAddr = $("#dhAddr").val();
			var params = '&useraddr='+tsd.encodeURIComponent(userAddr) + '&dh='+tsd.encodeURIComponent(dhAddr);
			
			var res = executeNoQuery("dbsql_route.RM.UpdateUserAddr",6,params,"route");
			if(res=="true"||res==true)
			{
				alert("地址修改成功。");				
				//writeLogInfo("","modify",loginfo);
			}
			setTimeout($.unblockUI, 15);//关闭面板
			//清空用户地址、修改地址账号
			$("#ghSearchBox").val("");
			$("#dhAddr").val("");
			$("#grid_user").trigger("reloadGrid");//重新加载数据			
		}
		//查询地址
		function queryAddress(dh){
			var urlstr = '&dh='+dh;
			var res = fetchMultiArrayValue('dbsql_route.RM.getUserAddr',6,urlstr,'route');			
			//当地址为空时，res为空
			if (res != undefined && res!="" && res.length>0){
				$("#ghSearchBox").val(res[0][0]);
				$("#dhAddr").val(dh);
			}else{
				$("#ghSearchBox").val('');
				$("#dhAddr").val(dh);
			}
		}
	
		
	/////地址选择
	 function c_p_address()
	 {
		var ctrr = $("#ghSearchBox");
		//判断是否有直接输入地址的权限
		if(getaddressEditer()=="NO"){
			c_p_address_fun();
		}			
	 }
		
	</script>
</head>

	
<!-- 地址修改 start -->
<div class="neirong" id="divRouteAddress"
	style="margin-left: 150px; margin-top: 100px; width: 400px; display: none; z-index: 2001;">
	<div class="top">
		<div class="top_01" id="thisdrag">
			<div class="top_01left">
				<div class="top_02">
					<img src="style/images/public/neibut01.gif" />
				</div>
				<div class="top_03" id="titlediv">
					<span>页面操作说明</span>
				</div>
				<div class="top_04">
					<img src="style/images/public/neibut03.gif" />
				</div>
			</div>
			<div class="top_01right">
				<a href="javascript:;" onclick="javascript:setTimeout($.unblockUI,15);">
				 <fmt:message key="global.close" />
					<!-- 关闭 --> 
				</a>
			</div>
		</div>
		<div class="top02right">
			<img src="style/images/public/toptiaoright.gif" />
		</div>
	</div>
	<div class="midd"
		style="background-color: #FFFFFF; text-align: left; height: 150px;overflow-y:auto;overflow-x:hidden; ">
			<div id="devname_d_D" class="midd_div" >
				<span class="midd_span" >用户地址:</span>
				<input type="text" id="ghSearchBox" style="width:300px;" onfocus="c_p_address();"/>
				<input type="hidden" id="dhAddr">
			</div>
	</div>	
	<div class="midd_butt" style="height:38px;">  
			<button onclick="updateUserAddr();" class="tsdbutton" 
				style="margin-left: 20px;">
				保存
			</button>
			<button onclick="javascript:setTimeout($.unblockUI,15);" class="tsdbutton"  style="margin-left: 20px;">
				取消				
			</button>			
		</div>
</div>
<!-- 地址修改 end -->

<input type="hidden" id="" />