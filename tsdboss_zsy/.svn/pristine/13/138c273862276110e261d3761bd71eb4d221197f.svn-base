<br>&gt;<%----------------------------------------
	name: PortBinding_Ptree.jsp
	author: youhy
	version: 1.0 
	description: 自动配线管理-配线上级端口选择页面
	Date: 2012-6-14
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
	<script type="text/javascript">
		$(document).ready(function () {
			
		});
		var zTreeObj_Pre;
		var setting_Pre = {					
			callback: {			
				onClick: nodeClick_pre,				
				onDblClick: nodeDblClick_pre											
			}
		};				
		var currNode = "";  //用来存放当前点击的树节点的id
		var objCount = 0;   //用来存放设备的对象级别数目
	
		//显示树控件
		function showtree(){
			$('#maxpanels').show();
			$('#divtree_pre').show();		
		}
		//隐藏树控件
		function hidetree(){
			$('#divtree_pre').hide();
			$('#maxpanels').hide();			
		}
			
		/***********
		* 初始化上级设备树形控件	
		* 参数 ：上级设备编号
		***********/
		function initTree_pre(devid, devname, mkj){			
			var devNodes = [];
			var devNode;
			var scond="&devid="+devid;
			if (mkj!=null && mkj!=""){
				scond += "&cond=and mokuaiju = '"+tsd.encodeURIComponent(mkj)+"'";
			}
			else{
				scond += "&cond=and 1=1";
			}
			var res = fetchMultiArrayValue('dbsql_route.PB.QueryDevice_Pre',6,scond,'route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					devNode = {"id":res[i][0],"name":res[i][1],"devicon":res[i][2]};
					devNodes.push(devNode);
				}
			};			
			//取出此设备的层次数目，并置于全局变量objCount中.同时取出其图标文件名并置于节点数据中			 
			var urlstr = '&devid='+tsd.encodeURIComponent(devid);
			res = fetchMultiArrayValue('dbsql_route.GetLevelCount',6,urlstr,'route');
			objCount = res[0][0];
			var devicon = res[0][1];
			var id = devid.substr(0, devid.length-1);//去掉后面的.号						
			var zTreeNodes = [			
				{"id":id, "name":devname, "devicon":devicon, open:true, childs: devNodes}
			];			
			zTreeObj_Pre = $.fn.zTree.init($("#tree_Pre"), setting_Pre, zTreeNodes);
			
			//选中根节点	
			var nodes = zTreeObj_Pre.getNodes();			
			zTreeObj_Pre.selectNode(nodes[0]);		
			//设置根节点的显示情况
			nodeClick_pre('', '', nodes[0], '');	
																
		}	
		//树节点单击事件
		function nodeClick_pre(event, treeId, treeNode, clickFlag) {		
			var devid = treeNode.id;			
			//如果已经单击过，则不再执行下面的代码。目的是为了避免 dbclick引发的两次click事件（因为在jQuery事件绑定中，dbclick可以触发两次click事件）					
			if (currNode == devid){
				return;
			}					
			//如果下级是端口级，则显示选中节点的端口信息			
			//如果节点的下一级是端口级，则不再添加							
			var urlstr = '&devid='+tsd.encodeURIComponent(devid);
			var levelcount = objCount;
			if (treeNode.level+2<levelcount){
				var devicon = treeNode.devicon;
				showOtherInfo(devid, levelcount, devicon);
			}
			else if (treeNode.level+2==levelcount){
				queryDevice_Port(devid,'');	
			}							
			currNode = devid;			
		}			
		//双击树节点，添加其子节点
		function nodeDblClick_pre(event, treeId, treeNode){	
			//如果节点已经展开过，就不再添加其子节点
			if (treeNode.isParent){					
				return;
			}
			var devid = treeNode.id;			
			//如果节点的下一级是端口级，则不再添加							
			var urlstr = '&devid='+tsd.encodeURIComponent(devid);
			var levelcount = objCount;									
			if (treeNode.level+2==levelcount){
				return;
			}				
			var urlstr = '&devid='+tsd.encodeURIComponent(devid)+'.';							
			var devNodes = [];
			var devNode;
			var res = fetchMultiArrayValue('dbsql_route.QueryDevice_DetailId',6,urlstr,'route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					devNode = {"id":res[i][0],"name":res[i][1]};
					devNodes.push(devNode);
				}					
				zTreeObj_Pre.addNodes(treeNode, devNodes);
			};														
		}		
		//选中的对象，其下级不是端口，则不显示端口表格。而显示其它信息		
		function showOtherInfo(devid, levelcount, devicon){			
			var iconpath = devicon;			
			var td;
			if (iconpath=="" ||iconpath==null ||iconpath==undefined){
				td = '<font color="#C3CED2">暂无图片</font>';
			}
			else{
				td = '<img src="'+iconpath+'" style="width:180px;height:150px" />'
			}
			var table = '<table border="1" cellpadding="0" bordercolor="#9AC0CD" style="height:50%; width:70%;margin-top:20%">'
			  +'<tr>'
			  +'<td style="width:50%;text-align:center;">'+td+'</td>'			   
			  +'</tr>'
			  +'</table>';						
			var s = "<div style='width:660px;line-height:390px'>"+table+"</div>";
			$('#pagered1').html(s);			
			var sHint = "若要显示并选择具体端口，请继续在设备结构树中选择其子对象！";
			$('#lblhint').text(sHint);
			
			checkNodeName('','');//将存放端口名称和编码的变量清空
		}
		//端子选择表格的选择代码
		function checkNodeName(value,DeviceNo){
			$('#thenodename').val(value);
			$('#thenodeno').val(DeviceNo);
		}		
		//显示对象的端子信息。动态在table中显示	
		//devid 上级设备编号
		//devname 端口名称	
		function queryDevice_Port(devid,devname){
			
			//$('#pagered1').empty();
			var urlstr = '&devid='+tsd.encodeURIComponent(devid)+'.';
			urlstr += '&devname='+tsd.encodeURIComponent(devname);
			var res = fetchMultiArrayValue('dbsql_route.PB.QueryDevice_Port',6,urlstr,'route');
			if (res != undefined && res!="" && res.length>0){				
				var table = "";
				
				table +="<div style='width:660px;line-height:38px;'><span>端口名称(包含)</span>" +
						"<input type='text' id='devnameText' style='width:150px;' />" +
						"<button id='devnameQbtn' onclick='selPortByName(\"" + devid + "\");' class='tsdbutton' " + 
						"style='width:70px;line-height:25px; margin-top: 3px; padding: 0px;'>确定</button>" +
						"</div>";
								
				table += "<table width='660px' align='center' border='1'>" + 
				"<caption border='2px' style='font-size: 14px;border-color: black'>选择端口</caption>" + 
				"<tr style='line-height:10px;'>";
				var DeviceNo;
				var NodeName;						
				var NodeState;
				var DeviceNoDH;			
				var j=1;
				for(var i=0;i<res.length;i++){					
					DeviceNo = res[i][0];
					NodeName = res[i][1];
					NodePdevno = res[i][2];
					if(j%4==0){
          				if(NodePdevno==""){
       						table = table + "<td width='12%'><input type='radio' name='NodeName' value='"+NodeName+"' onClick='checkNodeName(this.value,\""+DeviceNo+"\")'/><font color='green' style='font-size: 11px;'>"+NodeName+"</font></td></tr><tr style='line-height:10px;'>";
       					}else {
       						table = table + "<td width='12%'><font color='red'  style='font-size: 11px;'>"+NodeName+"("+DeviceNoDH+")</font></td></tr><tr style='line-height:10px;'>";
       					}
          			}else{
       					if(NodePdevno==""){
       						table = table + "<td width='12%'><input type='radio' name='NodeName' value='"+NodeName+"' onClick='checkNodeName(this.value,\""+DeviceNo+"\")'/><font color='green'  style='font-size: 11px;'>"+NodeName+"</font></td>";
       					}else {
       						table = table + "<td width='12%'><font color='red'  style='font-size: 11px;'>"+NodeName+"("+DeviceNoDH+")</font></td>";
						}
          			}
          			j++;
				}	
				//补全端口表格
				if(j%4!=1){
				 	while(j%4!=1){
				 		table = table + "<td width='12%'></td>";
				 		j++;
				 	}
				}
				table = table+"</tr></table>";								
				$('#pagered1').html(table);
				var sHint = "注：绿色代表未绑定上级端口，红色代表已绑定上级端口。";
				$('#lblhint').text(sHint);												
			}
			else{
				var s = "<div style='width:660px;line-height:390px'>无端口！</div>";
				$('#pagered1').html(s);	
				var sHint = "若要显示并选择具体端口，请继续在设备结构树中选择其子对象！"			
				$('#lblhint').text(sHint);	
			}
		}
		//根据端口名称查询端口 
		//devid 上级设备编号
		function selPortByName(devid){
			var devname = $("#devnameText").val();//端口名称
			queryDevice_Port(devid,devname);
			
		}
		//点击确定按钮；将相应路由表格中的记录的设备名称和端口名称设置所选节点
		function selectedport(){
			//取出选中的端子
			var NodeName = $('#thenodename').val();//端口名称
			var DeviceNo = $('#thenodeno').val();  //端口编码			
			if (DeviceNo == "" || DeviceNo == null || DeviceNo == undefined) 
			{
				alert("请选中某一端口！");
				return;
			}
			$("#PNode").val(DeviceNo);
			$("#PName").val(NodeName);
			hidetree();  
		}
		//返回节点的祖先节点，level参数表示第几层祖先。
		function getOwnerDev(node, level){
			if (node.level<=1){
				return node;
			}
			var parentnode = node.getParentNode();
			while (parentnode!=null){
				if (parentnode.level == level){
					return parentnode;
					break;
				}
				parentnode = parentnode.getParentNode();
			}
			return null;
		}
		//根据树中选择的节点，设置路由表格中的选中记录的相应字段
		function setRouteRec(name2,id3,name3){
			var rowid=$('#grid_newroute').getGridParam("selrow");
			if (rowid!=null){
				$('#grid_newroute').setRowData(rowid, {name2 : name2});
				$('#grid_newroute').setRowData(rowid, {id3 : id3});
				$('#grid_newroute').setRowData(rowid, {name3 : name3});				
			}
		}
		
	</script>
</head>	
<div id="maxpanels" class="maxpanel" style="display: none">
</div>	
<div class="neirong" id="divtree_pre" style="margin-left:50px;margin-top:20px;width:880px;display: none;z-index: 2001;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<span>请选择设备端口</span>
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="hidetree();"><fmt:message key="global.close" /><!-- 关闭 --></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>
		
	<div class="midd" style="background-color:#FFFFFF;text-align:left;height:360px;">
		<div id="input-Unit" >
			<div style="float: left;height: 360px;overflow-y: auto; overflow-x: hidden;width: 200px;">
				<ul id="tree_Pre" class="ztree" style="overflow:auto;"></ul>
			</div>
			<div style="float: left;height: 360px;overflow-y: auto; overflow-x: hidden;width: 3px;background-color: gray">
			</div>
			<div id="pagered1" style="float: left;height: 340px;overflow-y: auto; overflow-x: hidden;">				
				<div style='width:660px;' >请选择模块对象，以显示其中的端子。</div>
			</div>
			<div id="porticon" style="margin-top: 5px;font-weight: bold;">
				<label id="lblhint" style="width:520px;"></label>
			</div>
		</div>
		
	</div>
	<div class="midd_butt" style="height:38px;">  
		<button id="hthChooseFormSave" onclick="selectedport();" class="tsdbutton" 
			style="margin-left: 20px;">
			确定
		</button>
		<button onclick="hidetree();" class="tsdbutton"  style="margin-left: 20px;">
			取消				
		</button>
	</div>
	</div>	
	
	<input type="hidden" id="thenodename" />
	<input type="hidden" id="thenodeno" />				
	
	