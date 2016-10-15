<%----------------------------------------
	name: menuManager.jsp
	author: luoyulong
	version: 1.0, 2010-8-10
	description: 实现菜单增删改，以及三级菜单和菜单的位置调整
	modify: 
		2010-10-8 youhongyu 单表编辑面板修改；   
		2011-01-22chenze    增加对单表编辑初始化条件处理
		2011-02-17chenze    增加单表编辑显示字段配置 修正一些逻辑性错误
		2011-5-16 youhongyu 增加单表编辑设置默认排序规则
		2011-7-12 youhongyu 添加单表编辑时往数据库添加初始化排序值
		2011-7-12  youhongyu    通过读取配置表来判断初始化的时候是否显示数据
		2011-7-18 youhongyu  单表编辑添加一个功能 页面刚被打开时条件，只在页面刚被打开起作用，进行增删改查操作后不起作用。
						 
---------------------------------------------%>
<%@ page language="java" import="java.util.*,java.io.File" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
	String imenuid = request.getParameter("imenuid");
	String groupid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>T-STAR BOSS Menu Manager</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
				
		<script type="text/javascript" src="plug-in/extjs/ext-base.js"></script>
		<script type="text/javascript" src="plug-in/extjs/ext-all.js"></script>
		
		<!-- jquery -->
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<script type="text/javascript" src="script/public/main.js"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		
		<link rel="stylesheet" type="text/css" href="style/css/system/menuManager.css" />
		<link rel="stylesheet" type="text/css" href="style/css/system/tsdtree.css" />
		<script type="text/javascript" src="script/system/tsdtree.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		
		<style type="text/css">
		.tsd-button{padding:2px;}
		#gridDisplayFieldTab{width:92%;margin-left:auto;margin-right:auto;}
		#gridDisplayFieldTab td{line-height:26px;border:0px solid #CDD;}
		
		
		
		.cont p{
    text-align: justify;
    line-height: 30px;
}
/* 设置滚动条的样式 */
::-webkit-scrollbar {
    width: 12px;
}

/* 滚动槽 */
::-webkit-scrollbar-track {
    box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
    border-radius: 10px;
}
 
/* 滚动条滑块 */
::-webkit-scrollbar-thumb {
    border-radius: 10px;
    background: rgba(0,0,0,0.1); 
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5); 
}
::-webkit-scrollbar-thumb:window-inactive {
    background: rgba(255,0,0,0.4); 
}
		
		
		
		</style>

	<!--  
		<script type="text/javascript" src="js/split/main.js"></script>
		<link href="style/xin.css" rel="stylesheet" type="text/css" />
	-->	
		
		<script type="text/javascript">
			/**
			 * 页面初始化
			 * @param 无参数
			 * @return 无返回值
			 */
			
			window.onload = function(){
				var bodypanel = document.getElementById('body-panel');
				var iconpanel = document.getElementById('icon-panel');
				var operpanel = document.getElementById('oper-T');
				var thedeptm = document.getElementById('thedeptm');
				var deptm = document.getElementById('deptm');
				var iconform =  document.forms.iconForm;
				var manformtitle = document.getElementById('mmf-title');
				var manform = document.forms.menuManageForm;
				var smenuurl2 = null;	//装载判断单表编辑修改时是存储数据还是修改数据的依据
				manform.nowNode=null;
				$("#loading").show();
				//加载菜单
				Ext.app.tsd.treeRender('menu-panel','update');
					
				setTimeout("$('#loading').hide();",3000)
				

				//调用存储过程来删除、增加、移动菜单
				updateMenu = function(p_start,p_end,p_moveto,p_func){
					Ext.Ajax.request({
						url:'mainServlet.html',
						params:{
							packgname:'service',clsname:'Procedure',
							ds:'tsdBilling',tsdExeType:'exe',method:'exequery',
							tsdpname:'menuManager.menuMoveposition',
							start:p_start,
							end:p_end,
							moveto:p_moveto,
							func:p_func
						},success: function(response, options){
							if(p_func=='del'){
								//alert('删除成功！');
								alert("<fmt:message key='menuManager.deleteSuccess' />");
								manform.nowNode.remove();
							}else if(p_func=='add'){
								//alert('添加成功！');
								alert("<fmt:message key='menuManager.addSuccess' />");
								btnMmfReset_click();
								Ext.app.tsd.removeInsertFlag();//移除占位线
							}else if(p_func=='move'){
								//alert('移动成功！');
								alert("<fmt:message key='menuManager.moveSuccess' />");
							}
							//数据库中移动成功后，修正页面菜单树的序号
							Ext.app.tsd.reloadIndex();
							manform.nowNode=null;
						}
					});
					//将单表编辑进行初始化	--- 孙琳
					document.getElementById("mmf-menuurl2").checked=false;
					document.getElementById("tableName").value="";
					document.getElementById("printName").value="";
					document.getElementById("dataSource").value="";
					document.getElementById("tablealiasName").value="";
					document.getElementById("rights").value="";
					
					document.getElementById("whereinfos").value="";//条件
					document.getElementById("displayconditions").value="";//显示条件
					
					//document.getElementById("configName").value="";					
					//document.getElementById("powerName").value="";
					
					operpanel.style.visibility='hidden';
					thedeptm.style.visibility='hidden';
				};
				
				/**
				 * 菜单移动后会调用此方法更新数据库
				 * @param 无参数
				 * @return 无返回值
				 */
				moveMenu=function(param,node){
					//1.取得涉及到更新节点的级别
					//1.1取得当前节点下所有子节点的ID和级别
					var nodeList = ['['];
					Ext.app.tsd.traversingNode(node,function(n){
						nodeList.push(['{id:',n.id,',level:',n.getDepth(),'}'].join(''));
						nodeList.push(',');
					});
					nodeList.pop();//移除最后一个逗号
					nodeList.push(']');
					//console.log('nodeList',param,nodeList.join(''));
					//1.2修改级别信息
					Ext.Ajax.request({
						method:'POST',
						url:'mainServlet.html',
						params:{
							packgname:'service',clsname:'SysMenuService',
							ds:'tsdBilling',method:'service',tsdcf: 'mssql',
							operate:'updateNodeLevelById',
							nodes:nodeList.join('')
						},success: function(response, options){
							//2.修正位置
							updateMenu(param.start,param.end,param.moveto,'move');
						}
					});
					
				};
				
				/**
				 * 选择图标，显示面板
				 * @param 无参数
				 * @return 无返回值
				 */
				iconPanel_show =function(){
					var now = manform.simgico.value;
					for(var i=0;i<iconform.icons.length;i++){
						if (iconform.icons[i].value == now) {						
							iconform.icons[i].checked = "checked";
							break;
						}
					}
					iconpanel.style.visibility='visible';
					bodypanel.onclick=btnIconpCancel_click;
				};
				/**
				 * 选择图标，确定按钮点击事件
				 * @param 无参数
				 * @return 无返回值
				 */
				btnIconpOk_click = function(){
					for(var i=0;i<iconform.icons.length;i++){
						if (iconform.icons[i].checked) {
							manform.simgico.value = iconform.icons[i].value;
							break;
						}
					}
					btnIconpCancel_click();
				};
				/**
				 * 选择图标，取消按钮点击事件
				 * @param 无参数
				 * @return 无返回值
				 */
				btnIconpCancel_click = function(){
					bodypanel.onclick=null;
					iconpanel.style.visibility='hidden';
				};
				/**
				 * 修改菜单项面板确定按钮点击事件
				 * @param 无参数
				 * @return 无返回值
				 */
				btnMmfSave_click = function(){
					var flag = manformtitle.innerHTML;
					var sql = null;
					var smenuurl = null;
					var tableName1 = document.getElementById('tableName').value;
					var printName1 = document.getElementById('printName').value;
					var dataSource1 = document.getElementById('dataSource').value;
					var tablealiasName1 = document.getElementById('tablealiasName').value;
					var orderbykey1 = document.getElementById('orderbykey').value;
					var isshowdata1 = document.getElementById('isshowdata').value;
					
					
					var gridfieldsctrarr = $('#gridDisplayFieldTab :checkbox:checked');
					var gridfields = "";
					$(gridfieldsctrarr).each(function(){
						gridfields += ",";
						gridfields += $(this).val();
					});
					gridfields = gridfields.replace(",","");
					
					var rights1 = document.getElementById('rights').value;
					
					var whereinfos1 = document.getElementById('whereinfos').value;
					whereinfos1 = transferApos(whereinfos1);
					var displayconditions1 = document.getElementById('displayconditions').value;
					displayconditions1 = transferApos(displayconditions1) ;
					
					//var powerName1 = document.getElementById('powerName').value;
					//var configName1 = document.getElementById('configName').value;
					// 判断打印报表名字段是否为空
					if(printName1 == null || printName1 == ""){
						printName1 = "";
					}
					//if (manformtitle.innerHTML=='修改菜单项') {
					if (manformtitle.innerHTML=="<fmt:message key='menuManager.updateMenu' />") {
						//判断是否点击单表编辑按钮		---孙琳
						if(document.getElementById("mmf-menuurl2").checked){
							if($.trim(tableName1)==""){
								//alert("当前菜单设置为单表编辑，必须输入表名");
								alert("<fmt:message key='menuManager.besinglemustentername' />");
								operpanel.style.visibility='visible';
								$("#tableName").select().focus();
								return;
							}
							if($.trim(dataSource1)==""){
								//alert("当前菜单设置为单表编辑，必须输入数据源");
								alert("<fmt:message key='menuManager.besinglemustenterdata' />");
								operpanel.style.visibility='visible';
								$("#dataSource").select().focus();
								return;
							}
							//根据单表编辑值判断是进行增加还是修改数据
							if(smenuurl2 != 'pubMode/SingleTabE.jsp'){
								//alert();
								sql = 'sysmenu.updatemenu3';
								smenuurl = document.getElementById("mmf-menuurl2").name;
							}else{
								sql = 'sysmenu.updatemenu2';
								smenuurl = document.getElementById("mmf-menuurl2").name;
							}
						}else{
							if(smenuurl2 != 'pubMode/SingleTabE.jsp'){
								sql = 'sysmenu.updatemenu';
								smenuurl = document.getElementById("mmf-menuurl").value;								
							}else{//从单表编辑改成非单表编辑
								sql = 'sysmenu.updatemenu4';
								smenuurl = document.getElementById("mmf-menuurl").value;
							}
							
						}
						//根据ID修改菜单内容
						Ext.Ajax.request({
							url: 'mainServlet.html',
							params: {
								packgname: 'service',clsname: 'ExecuteSql',ds: 'tsdBilling',
								tsdcf: 'mssql',tsdoper: 'exe',method: 'exeSqlData',
								tsdpk: sql,
								imenuid: manform.imenuid.value,
								smenuname: ['{zh=', manform.chname.value, '/}{en=', manform.enname.value, '/}'].join(''),
								smenuurl: smenuurl,
								tableName:tableName1,
								printName:printName1,								
								dataSource:dataSource1,
								tablealiasName:tablealiasName1,
								orderbykey:orderbykey1,
								isshowdata:isshowdata1,
								gridfields:gridfields,
								rights:rights1,
								whereinfos:whereinfos1,
								displayconditions:displayconditions1,
								//powerName:powerName1,
								//configName:configName1,
								simgico: manform.simgico.value,
								isvisible: manform.isvisible.value
								
							},
							success: function(response, options){
								var n = manform.nowNode;
								n.setText(menuManageForm.chname.value);
								n.getUI().iconNode.src = n.getUI().icon = manform.simgico.value;
								//将单表编辑进行初始化	--- 孙琳
								document.getElementById("mmf-menuurl2").checked=false;
								document.getElementById("tableName").value="";
								document.getElementById("printName").value="";
								document.getElementById("dataSource").value="";
								document.getElementById("tablealiasName").value="";
								document.getElementById("orderbykey").value="";//默认排序
								document.getElementById("isshowdata").value="0";//默认排序
								
								$("#gridDisplayFieldTab").html("");
								document.getElementById("rights").value="";
								$("#whereinfos").val("");
								$("#displayconditions").val("");
								var right = document.getElementsByName('right');
								for(i=0;i<right.length;i++){
									right[i].checked = false;
								}
								operpanel.style.visibility='hidden';
								//alert('修改成功！');
								alert("<fmt:message key='menuManager.updateSuccess' />");
								btnMmfReset_click();
							}
						});
					}
					//新增菜单项
					else if(manformtitle.innerHTML=="<fmt:message key='menuManager.addMenu' />"){
						//1.从数据库查询得到新菜单ID
						Ext.Ajax.request({
							url: 'mainServlet.html',
							params: {
								packgname: 'service',
								clsname: 'ExecuteSql',
								ds: 'tsdBilling',
								tsdcf: 'mssql',
								tsdoper: 'query',
								method: 'exeSqlData',
								datatype:'xmlattr',
								tsdpk: 'sysmenu.getmaxid'
							},
							//2.成功的话将菜单呈现到页面上
							success: function(response, options){
								var _q = Ext.DomQuery;
								var node = _q.selectNode('row',response.responseXML.documentElement);
								var maximenuid = _q.selectNumber('@imenuid',node,0);
								var tableName1 = document.getElementById('tableName').value;
								var printName1 = document.getElementById('printName').value;								
								var dataSource1 = document.getElementById('dataSource').value;
								var tablealiasName1 = document.getElementById('tablealiasName').value;
								var rights1 = document.getElementById('rights').value;
								
								
								var whereinfos1 = $("#whereinfos").val();
								whereinfos1 = transferApos(whereinfos1);
								var displayconditions1 = $("#displayconditions").val();
								displayconditions1 = transferApos(displayconditions1) ;
					
								//var powerName1 = document.getElementById('powerName').value;
								//var configName1 = document.getElementById('configName').value;
								var smenuurl = null;
								var sql = null;
								//判断是否点击单表编辑按钮		---孙琳
								if(!document.getElementById("mmf-menuurl2").checked){
									sql = 'sysmenu.savemenu';
									smenuurl = manform.menuurl.value;
								}else{
									sql = 'sysmenu.savemenu2';
									smenuurl = document.getElementById("mmf-menuurl2").name;
								}
								// 判断打印报表名字段是否为空
								if(printName1 == null || printName1 == ""){
									printName1 = "";
								}
								if(maximenuid!=0){
									var nextid = maximenuid+1;
									var newnode = new Ext.tree.TreeNode({
										cls:Ext.app.tsd.TREE_DEFAULT_STYLE[manform.nowNode.getDepth()],
								        text: manform.chname.value,
										href: null,
										icon: manform.simgico.value,
										hidden: false,
								        id:nextid
								    });
									//manform.isvisible.value
									//将新节点插入到选择节点上面
									newnode = manform.nowNode.parentNode.insertBefore(newnode,manform.nowNode);
									//3.将新节点插入到数据库
									Ext.Ajax.request({
										url: 'mainServlet.html',
										params: {
											packgname: 'service',
											clsname: 'ExecuteSql',
											ds: 'tsdBilling',
											tsdcf: 'mssql',
											tsdoper: 'exe',
											method: 'exeSqlData',
											tsdpk: sql,
											smenuname:['{zh=', manform.chname.value, '/}{en=', manform.enname.value, '/}'].join(''),
											smenuurl:smenuurl,
											iparentid:0,
											simgico:manform.simgico.value,
											isvisible:manform.isvisible.value,
											ilevel:newnode.getDepth(),//获得新菜单的级别
											imenuid:nextid,//新菜单的ID
											tableName:tableName1,
											printName:printName1,											
											dataSource:dataSource1,											
											tablealiasName:tablealiasName1,
											gridfields:gridfields,
											rights:rights1,
											whereinfos:whereinfos1,
											displayconditions:displayconditions1,
											orderbykey:orderbykey1,
											isshowdata:isshowdata1,
											//powerName:powerName1,
											//configName:configName1,
											
											iorder:0
										},
										//4.如果成功插入数据，则调用存储来修正序号
										success: function(response, options){
											//4.1查询新菜单的位置
											var index = Ext.app.tsd.nodeIndexOf(newnode);
											newnode.attributes.iorder=index;
											//4.2调用存储修正位置
											updateMenu(index,0,nextid,'add');
										}
									});
								}
							}
						});
					}
					
				};
				/**
				 * 修改菜单项面板取消按钮点击事件
				 * @param 无参数
				 * @return 无返回值
				 */
				btnMmfReset_click = function(){
					manform.nowNode=null;
					for(var i=0;i<8;i++){
						manform[i].disabled=true;
						if(manform[i].name!='btnsave'&&manform[i].name!='btnreset')
							manform[i].value='';
					}
					//管理菜单项
					manformtitle.innerHTML="<fmt:message key='menuManager.manageMenu' />";
				};
				
				/**
				 * 根据ID获得菜单数据
				 * @param p_menuid(ID)
				 * @return 无返回值
				 */
				getMenuInfo = function(p_menuid){
					btnMmfReset_click();
					//根据ID查询菜单信息
					Ext.Ajax.request({
						url:'mainServlet.html',
						params:{
							packgname:'service',clsname:'ExecuteSql',
							ds:'tsdBilling',tsdcf:'mssql',tsdoper:'query',
		 					datatype:'xmlattr',tsdpk:'sysmenu.getmenuinfo',
							method:'exeSqlData',imenuid:p_menuid
						},
						success:function(response,options){
							//取值
							var doc = response.responseXML.documentElement;
							var _q = Ext.DomQuery;
							var node = _q.selectNode('row',doc);
							//填充表单
							manform.imenuid.value=_q.selectValue('@imenuid',node,"");
							var smenuname = _q.selectValue('@smenuname',node,"");
							var cname=getCaption(smenuname,'zh');
							manform.chname.value=(cname==undefined?'':cname);
							var ename=getCaption(smenuname,'en');
							manform.enname.value=(ename==undefined?'':ename);
							manform.isvisible.selectedIndex=(_q.selectValue('@isvisible',node,"")=='true'?1:2);
							manform.simgico.value=_q.selectValue('@simgico',node,"");
							manform.menuurl.value=_q.selectValue('@smenuurl',node,"");
							if("pubMode/SingleTabE.jsp" == manform.menuurl.value)
							{
								document.getElementById("mmf-menuurl2").checked=true;
							}
							else
							{
								document.getElementById("mmf-menuurl2").checked=false;
							}
						}
					})
				};
				
				/**
				 * 根据ID删除菜单
				 * @param p_menuid(ID)
				 * @param p_node(节点)
				 * @return 无返回值
				 */
				delMenu = function(p_menuid,p_node){
					btnMmfReset_click();
					var n = manform.nowNode = p_node;
					//计算出删除菜单的开始和结束序号
					var o = Ext.app.tsd.getBeginEnd(n);
					//console.log(o,p_node);
                    if (n.parentNode) {
                    	//if (confirm(['您确定要删除 [',n.text,'] ',n.hasChildNodes()?'以及它下面的所有子菜单':'','吗？'].join(''))) {
                        if (confirm(['<fmt:message key="menuManager.suretodelete" />',n.text,'] ',n.hasChildNodes()?'<fmt:message key="menuManager.AndUnderneathItAllSubmenu" />':'','<fmt:message key="menuManager.what" />'].join(''))) {
							updateMenu(o.begin,o.end,0,'del');
                        }
                    }
				};
				/**
				 * 在当前选择的菜单上面添加新菜单
				 * @param p_node(节点)
				 * @return 无返回值
				 */
				addMenu = function(p_node){
					btnMmfReset_click();
					//初始化面板
					manform.nowNode=p_node;
					manformtitle.innerHTML='新增菜单项';
					manform.isvisible.selectedIndex=1;//默认选择
					//将单表编辑进行初始化	--- 孙琳
					document.getElementById("mmf-menuurl2").checked=false;
					document.getElementById("tableName").value="";
					document.getElementById("printName").value="";
					document.getElementById("dataSource").value="";
					document.getElementById("tablealiasName").value="";
					document.getElementById("rights").value="";
					$("#whereinfos").val("");
					$("#displayconditions").val("");
					document.getElementById("orderbykey").value="";
					document.getElementById("isshowdata").value="0";
					var right = document.getElementsByName('right');								
					for(i=0;i<right.length;i++){
						right[i].checked = false;
					}
					$("#gridDisplayFieldTab").html("");
					operpanel.style.visibility='hidden';
					//启用表单
					for(var i=0;i<8;i++){
						manform[i].disabled=false;
					}
				};
				//加载要修改的菜单的信息
				loadUpdateMenu = function(p_menuid,p_node){
				
					//manformtitle.innerHTML='修改菜单项';
					manformtitle.innerHTML="<fmt:message key='menuManager.updateMenu' />";
					
					//将单表编辑进行初始化	--- 孙琳
					document.getElementById("mmf-menuurl2").checked=false;
					document.getElementById("tableName").value="";
					document.getElementById("printName").value="";
					document.getElementById("dataSource").value="";
					document.getElementById("tablealiasName").value="";
					document.getElementById("rights").value="";
					document.getElementById("orderbykey").value="";
					document.getElementById("isshowdata").value="0";
					
					$("#whereinfos").val('');
					$("#displayconditions").val("");
					var right = document.getElementsByName('right');
					for(i=0;i<right.length;i++){
						right[i].checked = false;
					}
					operpanel.style.visibility='hidden';
					//根据ID查询菜单信息
					Ext.Ajax.request({
						url:'mainServlet.html',
						params:{
							packgname:'service',clsname:'ExecuteSql',
							ds:'tsdBilling',tsdcf:'mssql',tsdoper:'query',
		 					datatype:'xmlattr',tsdpk:'sysmenu.getmenuinfo',
							method:'exeSqlData',imenuid:p_menuid
						},
						success:function(response,options){
							//取值
							var doc = response.responseXML.documentElement;
							var _q = Ext.DomQuery;
							var node = _q.selectNode('row',doc);
							//填充表单
							manform.imenuid.value=_q.selectValue('@imenuid',node,"");
							var smenuname = _q.selectValue('@smenuname',node,"");
							var cname=getCaption(smenuname,'zh');
							manform.chname.value=(cname==undefined?'':cname);
							var ename=getCaption(smenuname,'en');
							manform.enname.value=(ename==undefined?'':ename);
							manform.isvisible.selectedIndex=(_q.selectValue('@isvisible',node,"")=='true'?1:2);
							manform.simgico.value=_q.selectValue('@simgico',node,"");
							$("#gridDisplayFieldTab").html("");
							//判断是否使用单表管理		--- 孙琳
							smenuurl2 = _q.selectValue('@smenuurl',node,"");
							if(_q.selectValue('@smenuurl',node,"") == 'pubMode/SingleTabE.jsp'){
								document.getElementById("tableName").value = _q.selectValue('@tableName'.toLowerCase(),node,"");
								document.getElementById("printName").value = _q.selectValue('@printName'.toLowerCase(),node,"");
								document.getElementById("dataSource").value = _q.selectValue('@dataSource'.toLowerCase(),node,"");	
								document.getElementById("tablealiasName").value = _q.selectValue('@tablealiasName'.toLowerCase(),node,"");
								document.getElementById("orderbykey").value = _q.selectValue('@orderby_key'.toLowerCase(),node,"");
								document.getElementById("isshowdata").value = _q.selectValue('@isshowdata'.toLowerCase(),node,"");
								showGridFileds(true);
								var gridfields = _q.selectValue('@showfields'.toLowerCase(),node,"");
								if($.trim(gridfields)!="")
								{
									var gridfieldsarr = gridfields.split(",");
									$.each(gridfieldsarr,function(i,n){
										$("#gridDisplayFieldTab :checkbox[value='" + n + "']").attr("checked","true");
									});
								}
								document.getElementById("rights").value = _q.selectValue('@rights'.toLowerCase(),node,"");
								$("#whereinfos").val(_q.selectValue('@whereinfo'.toLowerCase(),node,""));
								$("#displayconditions").val(_q.selectValue('@displayconditions'.toLowerCase(),node,""));
								deptm.style.visibility='visible';
								thedeptm.style.visibility='visible';
								$('#oper-T').draggable(); 
								//document.getElementById("configName").value = _q.selectValue('@configName'.toLowerCase(),node,"");
								//document.getElementById("powerName").value = _q.selectValue('@powerName'.toLowerCase(),node,"");
								forChecked('right',document.getElementById("rights").value,'~');
								//使单表管理多选按钮选中		--- 孙琳
								document.getElementById("mmf-menuurl2").checked=true;
								//如果使用单表管理则在文本框中不显示地址	--- 孙琳	
								//manform.menuurl.value = "";  // 恢复显示地址  cz
								setTimeout('$("#mmf-menuurl").attr("disabled","disabled")',100);
								//使单表管理面板显示	--- 孙琳
								operpanel.style.visibility='visible';
							}else{
								//如果没使用单表管理则在文本框中显示地址	--- 孙琳	
								manform.menuurl.value=_q.selectValue('@smenuurl',node,"");
								//$("#mmf-menuurl").removeAttr("disabled");
								//使单表管理多选按钮未被选中		--- 孙琳
								document.getElementById("mmf-menuurl2").checked=false;
								//使单表管理面板不显示	--- 孙琳
								operpanel.style.visibility='hidden';
							}
							//启用表单
							for(var i=0;i<8;i++){
								manform[i].disabled=false;
							}
							manform.nowNode=p_node;
						}
					});
				};
/************************************** 孙琳 **************************************************/
				/**
				 * 单表编辑单选按钮操作
				 * @param c(单选按钮对象)
				 * @return 无返回值
				 */
 				isCheck = function(c){
 					$('#oper-T').draggable(); 
					if(c.checked == true){
						document.getElementById("mmf-menuurl").disabled = true;
						$("#mmf-menuurl").val("pubMode/SingleTabE.jsp");
						operpanel.style.visibility='visible';
						thedeptm.style.visibility='hidden';	
						deptm.style.visibility='visible';				
					}else{
						document.getElementById("mmf-menuurl").disabled = false;
						$("#mmf-menuurl").val("");
						thedeptm.style.visibility='hidden';
						deptm.style.visibility='hidden';
					}
				}
				/**
				 * 模块功能文本框获得焦点时，显示多选按钮
				 * @param 无参数
				 * @return 无返回值
				 */
				getTheDeptm = function(){
					thedeptm.style.visibility='visible';
					deptm.style.visibility='hidden';
				}
				/**
				 * 点击多选文本框面板确定按钮时所做的处理
				 * @param 无参数
				 * @return boolean
				 */
				checkOk = function(){
					//获得多选文本框对象
					var right = document.getElementsByName('right');
					//拼接选中文本框value值
					var rights = '';
					for(i=0;i<right.length;i++){
						if(right[i].checked==true){
							rights += right[i].value+'~';
						}
					}
					//判断是否有选择模块功能
					if(rights.length==0){
						//alert('请选取模块功能！');
						alert("<fmt:message key='menuManager.checkfunc' />");
						return false;
					}else{
						//对字符串进行处理
						rights = rights.substring(0,rights.length-1);
						//将字符串赋值给文本框
						document.getElementById('rights').value = rights;
						thedeptm.style.visibility='hidden';
						deptm.style.visibility='visible';
						return true;
					}
				}
				/**
				 * 点击多选文本框面板取消按钮时所做的处理
				 * @param 无参数
				 * @return 无返回值
				 */
				checkCancel = function(){
					thedeptm.style.visibility='hidden';
					deptm.style.visibility='visible';
				}
				/**
				 * 点击确定按钮做的事情/验证单表编辑面板的文本框
				 * @param 无参数
				 * @return boolean
				 */
				close_oper = function(){
					var sum = 0;
					var tableName = document.getElementById("tableName").value;				    
				    var dataSource = document.getElementById("dataSource").value;
    
				    if(tableName == null || tableName == ""){
						//alert("表名不允许为空");
						alert("<fmt:message key='menuManager.notnullname' />");
						tableName.fouse();
						return false;
					}else if(dataSource == null || dataSource == ""){
						//alert("数据源不允许为空");
						alert("<fmt:message key='menuManager.notnulldata' />");
						dataSource.fouse();
						return false;
					}else{
						//将多选按钮的值写到模块功能文本框上,并且判断是否选择模块功能
						if(checkOk()){
							thedeptm.style.visibility='hidden';	
							operpanel.style.visibility='hidden';
							deptm.style.visibility='hidden';
						}else{
							return false;
						}						
					}
				}
			};
			
/************************************** 孙琳 **************************************************/
/************************************** 尤红玉 **************************************************/
		/**
		 * 关闭单表编辑参数面板
		 * @param 无参数
		 * @return 无返回值
		 */
		function closeTab(){
				//如果选中了单表编辑，则设置连接地址输入框为不可用状态  cz
				if($("#mmf-menuurl2:checked").size()>0)
					document.getElementById("mmf-menuurl").disabled = true;
				else
					document.getElementById("mmf-menuurl").disabled = false;
					
				var operpanel = document.getElementById('oper-T');
				thedeptm.style.visibility='hidden';	
				operpanel.style.visibility='hidden';
				deptm.style.visibility='hidden';	
				//document.getElementById("mmf-menuurl2").checked = false;
				return false;						
		}
		
		
		function showGridFileds(flagg)
		{
			var tablealiasname = $("#tablealiasName").val();
			//var tablealiasname = $("#tableName").val();
			if(tablealiasname==undefined || $.trim(tablealiasname)=="")
			{
				//if(flagg){
					//alert("请输入表别名");
					//alert("<fmt:message key='menuManager.entertablealias' />");
					//表名不允许为空
					alert("<fmt:message key='menuManager.notnullname' />");
				//}
				$("#tablealiasName").select().focus();
				return;
			}
			var aliases = fetchMultiArrayValue("main.fetchInfo",6,"&table="+$.trim(tablealiasname));
			if(aliases[0]!=undefined && aliases[0][0]!=undefined)
			{
				var tabHtml = "";
				var ii = 0;
				for(ii = 0;ii<aliases.length;ii++)
				{
					if((ii+1)%5==1)
						tabHtml += "</tr><tr>";
						
					tabHtml += "<td><input type=\"checkbox\" id=\"chk_" + aliases[ii][0] + "\" value=\"" + aliases[ii][0] + "\" /><label for=\"chk_" + aliases[ii][0] + "\">" + getCaption(aliases[ii][1],"zh",aliases[ii][1]) + "<label></td>";				
				}
				if(ii%5!=0)
				{
					var kk = ii%5;
					while(kk<5)
					{
						tabHtml += "<td></td>";
						kk++;
					}
					tabHtml += "</tr>";
				}
				tabHtml = tabHtml.replace("</tr>","");
				tabHtml = "<tr><td colspan=\"5\"><button class=\"tsd-button\" onclick=\"javascript:$('#gridDisplayFieldTab :checkbox').attr('checked','checked');\">"+"<fmt:message key='menuManager.checkAll' />"+"</button><button class=\"tsd-button\" onclick=\"javascript:$('#gridDisplayFieldTab :checkbox:checked').attr('checkflag','checkflag');$('#gridDisplayFieldTab :checkbox').attr('checked','true');$('#gridDisplayFieldTab :checkbox[checkflag]').removeAttr('checked').removeAttr('checkflag');\">"+"<fmt:message key='menuManager.uncheck' />"+"</button><button class=\"tsd-button\" onclick=\"javascript:$('#gridDisplayFieldTab :checkbox:checked').removeAttr('checked');\"><fmt:message key='menuManager.feelingempty' /></button></td></tr>" + tabHtml;
				
				
							
				$("#gridDisplayFieldTab").html(tabHtml);
				/*
				if(ipsss!="")
				{
					var ipsa = [];
					if(ipsss.indexOf("~")>0)
						ipsa = ipsss.split("~");
					else
						ipsa = ipsa.push(ipsss);
					
					for(var ki=0;ki<ipsa.length;ki++)
					{
						$("#chk_" + ipsa[ki].replace(/\./g,"_")).attr("checked","checked");
					}
				}*/
			}
			else
			{
				//alert("你所输入的表别名不可用");
				alert("<fmt:message key='menuManager.AliasUnavailable' />");
				
			}
		}
		
/**************************************  添加默认组合排序 start **************************************************/

		/**********************************************************
				function name:   openDiaOrder()
				function:		 打开组合排序窗口
				parameters:      
				return:			 
				description:     打开组合排序窗口，表名不同，可排序的字段不同
				Date:			 2011-5-16
		********************************************************/
		function openDiaOrder(){
			//	需要根据表别名来获取排序字段
			var tablealiasname = $("#tablealiasName").val();
			if(tablealiasname==undefined || $.trim(tablealiasname)=="")
			{	
				//alert("请输入表别名");
				alert("<fmt:message key='menuManager.enteralias' />");
				$("#tablealiasName").select().focus();
				return;
			}
			openDiaO(tablealiasname);
		}
		
		/**********************************************************
				function name:   zhOrderExe(sqlstr)
				function:		 执行组合排序
				parameters:      sqlstr：排序sql子字符串
				return:			 
				description:     公用模块的组合排序
				Date:			 2011-5-16
		********************************************************/
		function zhOrderExe(sqlstr){
			$("#orderbykey").val(sqlstr);
		}
/************************************** 添加默认组合排序 end **************************************************/
/************************************** 尤红玉 **************************************************/
		</script>
	</head>
	<body>
		<div id="body-panel"  style="border:0px solid #000">
			<div id="menu-panel" style="border:1px solid #99ccff;position:absolute;overflow:auto"></div>
			<div id="loading" style="font-size:13px;line-height: 300px;text-align: center;margin:10px 0 10px 380px;width: 250px;height:90%;padding: 10px;background-color:#F5FCFE;border:1px solid #99ccff;position:absolute;overflow:auto">
				数据加载中......
			</div>
		</div>
		<div id="float-panel">
			<div id="nav-bar">
				<!-- 返回 -->
				<a onclick="parent.history.back(); return false;" href="javascript:void(0);"><fmt:message key="menuManager.return" /></a><img src="<%=iconpath%>dot11.gif"/><fmt:message key="global.location" /> : <%=request.getParameter("pmenuname")%> &gt;&gt;&gt; <%=request.getParameter("imenuname")%>
			</div>
			<!--div id="nav-buttons">
				<button id="btn-save" onclick="{
					var url1 = 'mainServlet.html?ds=tsdBilling&tsdpk=sysmenu.show&tsdcf=mssql&datatype=map&tsdoper=query&packgname=service&clsname=SysMenuService&method=service&operate=show';
					Ext.Ajax.request({
						url: url1,
						success: function(response, options){
							alert(response.responseText);
						}
					});
				}">保存修改</button>
				<button id="btn-reset" onclick="{if(confirm('您确定要重新加载菜单吗？之前做过的修改将不会被保存。')){Ext.app.tsd.TREE_IS_UPDATE=false;window.location.reload();}}">重置</button>
			</div-->
			<div id="menu-manage-panel">
				<form id="menu-manage-form" name="menuManageForm" onsubmit="return false;">
					<!-- 管理菜单项 -->
					<h4 id="mmf-title"><fmt:message key="menuManager.manageMenu" /></h4>
					<table>
					<tr>
						<th><label for="mmf-chname"><fmt:message key="menu.chname" /></label></th>
						<td><input type="text" name="chname" id="mmf-chname" disabled="true" /><span class="nes">*</span></td>
					</tr>
					<tr>
						<th><label for="mmf-enname"><fmt:message key="menu.enname" /></label></th>
						<td><input type="text" name="enname" id="mmf-enname" disabled="true"/><span class="nes">*</span></td>
					</tr>
					<tr>
						<th><label for="mmf-menuurl">
						<!-- 链接地址 -->
						<fmt:message key="menuManager.url" />
						</label></th>
						<td><div style="width:175px;_width:145px;"><textarea name="menuurl" id="mmf-menuurl" rows="2" cols="5" style="width:100%;" disabled="true" ></textarea></div></td>
					</tr>
					<tr>
						<th><label for="mmf-menuurl2">
						<!-- 单表编辑 -->
						<fmt:message key="menuManager.editorSingleTable" />
						</label></th>
						<td><input type="checkbox" name="pubMode/SingleTabE.jsp" id="mmf-menuurl2" disabled="true"  onClick="isCheck(this)" nochecked/></td>
					</tr>
					<tr>
						<th><label for="mmf-isvisible">
						<!-- 是否可见 -->
				        <fmt:message key="menuManager.IsVisible" />
						</label></th>
						<td><select name="isvisible" id="mmf-isvisible"  disabled="true">
							<option value="" selected="selected" disabled="disabled"></option>
							<!-- 是 否 -->
							<option value="true"><fmt:message key="menuManager.yes" /></option>
							<option value="false"><fmt:message key="menuManager.no" /></option>
						</select><span class="nes">*</span></td>
					</tr>
					<tr>
						<!-- 菜单图标 -->
						<th><label for="mmf-simgico"><fmt:message key="menuManager.MenuIcon" /></label></th>
						<td><input type="text" name="simgico" id="mmf-simgico" disabled="true" onclick="iconPanel_show();"/></td>
					</tr>
					</table>
					<div>
						<!-- 确定 取消 -->
						<input id="btn-mmf-save" name="btnsave" type="button" class="tsd-button" value='<fmt:message key="menuManager.sure" />' disabled="true" onclick="btnMmfSave_click();"/>
						<input id="btn-mmf-reset" name="btnreset" type="reset" class="tsd-button" value='<fmt:message key="menuManager.cancel" />'  disabled="true" onclick="btnMmfReset_click();Ext.app.tsd.removeInsertFlag();"/>
					</div>
					<input id="mmf-imenuid" type="hidden" name="imenuid"/>
				</form>
				<div id="help-info">
                    <dl>
                        <!-- 
                        <dt>说明：</dt>
                        <dd>您需要使用鼠标右键点击右侧的菜单项对菜单进行编辑。</dd>
						<dd>您可以使用鼠标左键拖动菜单项来调整菜单项的位置。</dd>
						 -->
						<dt><fmt:message key="menuManager.Explain" /></dt>
                        <dd><fmt:message key="menuManager.Rightedit" /></dd>
						<dd><fmt:message key="menuManager.leftadjust" /></dd>
                    </dl>
				</div>
			</div>
<!-- ********************************* 孙琳 ********************************* -->
		
			
			
<!-- 添加模板面板 -->
<div id="oper-T" name='oper-T' class="neirong" style="margin-top: -50px;margin-left: -100px">	
	<div class="top">
	<div class="top_01" >
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" >
				<!-- 单表管理 -->
				<fmt:message key="menuManager.managerSingleTable" />
				</div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="javascript:void(0)" onclick="closeTab();"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<div style="max-height:250px;overflow-y: auto;overflow-x: hidden;background-color: #fff" >
		<form id='operform' name="operform" onsubmit="return false;" action="#" >
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
				 <tr>			    
				 	<!-- 表别名 -->
				    <td width="20%" align="right"  class="labelclass"><label id=''>数据库表名</label></td>
			    	<td width="30%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    		<input type="text" name="tableName" id="tableName" maxlength="50" class="textclass"  />&nbsp;&nbsp;<span class="nes">*</span>			   
			    	</td>
					<!-- 数据源 -->
					<td width="20%" align="right"  class="labelclass"><label id=''><fmt:message key="menuManager.datasource" /></label></td>
				    <td width="30%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="dataSource" id="dataSource" maxlength='50' class="textclass"/>
					    <span class="nes">*</span>
				    </td>
			 	 </tr>
			 	
			 	 <tr>
			 	 	<!-- 表名 <fmt:message key="menuManager.tablename" />-->
				    <td width="20%" align="right"  class="labelclass"><label id=''>数据字典配置表名</label></td>
				    <td width="30%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="tablealiasName" id="tablealiasName" maxlength='50' class="textclass" style="width:166px"/>
				    	<!-- 设置显示字段 -->
			    		<button class="tsd-button" style="width: 88px;height: 24px;line-height: 20px;" onclick="showGridFileds()"><fmt:message key="menuManager.Setdisplayfields" /></button>	
					    <span class="nes">*</span>
				    </td>
			 	 	
			    	<!-- 默认排序 -->
			    	<td width="20%" align="right"  class="labelclass"><label id='orderbykeyg'><fmt:message key="menuManager.Defaultsort" /></label></td>
			    	<td width="30%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    		<input type="text" name="orderbykey" id="orderbykey" maxlength='20' class="textclass" style="width:166px" />
			    		<!-- 设置默认排序 -->
			    		<button class="tsd-button" style="width: 88px;height: 24px;line-height: 20px;" onclick="openDiaOrder()"><fmt:message key="menuManager.setDefaultsort" /></button>				   
			    	</td>					 
				    			    
			 	 </tr>
			 	 <tr>
			 	 	<td class="labelclass"><fmt:message key="menuManager.Displayfield" /></td>
			 	 	<td colspan="3"  style="border-bottom:1px solid #A9C8D9;">
			 	 		<div id="gridDisplayFieldContainer" style="width:96%;height:80px;border:0px solid #F00;overflow-y:auto">
			 	 			<table id="gridDisplayFieldTab"></table>
			 	 		</div>
			 	 	</td>
			 	 </tr>
			 	  <tr>			    
			 	  <!-- 初始化显示数据 -->
				    <td width="20%" align="right"  class="labelclass"><label id='isshowdatag'><fmt:message key="menuManager.Initdisplaydata" /></label></td>
			    	<td width="30%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    		<select id="isshowdata" name="isshowdata" style="width: 100px;margin-left: 5px;">
			    			<!-- 是 否 -->
			    			<option value="0" ><fmt:message key="menuManager.yes" /></option>
			    			<option value="1"><fmt:message key="menuManager.no" /></option>
			    		</select>			    		
			    	</td>
			    	
					<td width="20%" align="right" class="labelclass" style="border-bottom:1px solid #A9C8D9;border-top:1px solid #A9C8D9; "></td>
			    	<td width="30%" align="left" style="border-bottom:1px solid #A9C8D9;border-top:1px solid #A9C8D9; "></td>
				    			    
			 	 </tr>
			 	 <tr>			    
			 	 <!-- 条件 -->
				   <td width="20%" align="right"  class="labelclass"><label id=''><fmt:message key="menuManager.Condition" /></label></td>
			    	<td width="80%" align="left" colspan="3" style="border-bottom:1px solid #A9C8D9;">
			    		<input type="text" name="printName" id="printName" maxlength="128" class="textclass" style="display:none"></input>	
			    		<textarea name="whereinfos" id="whereinfos" style="height:28px" class="textclass"/></textarea>
			    	</td>			    
			 	 </tr>
			 	  <tr>			    
			 	  <!-- 显示条件 -->
				   <td width="20%" align="right"  class="labelclass"><label id=''><fmt:message key="menuManager.displayCondition" /></label></td>
			    	<td width="80%" align="left" colspan="3" style="border-bottom:1px solid #A9C8D9;">
			    		<textarea name="displayconditions" id="displayconditions" style="height:28px" class="textclass"/></textarea>
			    	</td>			    
			 	 </tr>
			 	  <tr>			    
			 	  <!-- 模块功能 -->
				    <td width="20%" align="right"  class="labelclass"><label id=''><fmt:message key="menuManager.Modulefunction" /></label></td>
			    	<td width="30%" align="left" style="border-bottom:1px solid #A9C8D9;"  colspan='3'>
			    		<div id="deptm" >
			    			<input type="text" name="rights" id="rights" readonly class="textclass" onfocus="getTheDeptm();"/>					   
			    		</div>
			    		<div id="thedeptm" >
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td height="35" colspan="5">
										<!-- 全选 反选 -->
										<input type='button' id='checkall' onclick=isCheckedAll('right',true); value='<fmt:message key="menuManager.checkAll" />' style='width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;line-height:25px;  margin-left:10px;'>
										<input type='button'  id='uncheckall' onclick=isCheckedAll('right',false); value='<fmt:message key="menuManager.uncheck" />' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'>
										<!-- 确定 取消 -->
										<input type='button' onclick=checkOk() value='<fmt:message key="menuManager.sure" />' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'>
										<input type='button'  onclick=checkCancel() value='<fmt:message key="menuManager.cancel" />' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'>
									</td>
								</tr>
								<tr>
									<td height="20" width="10%" color="#666666">
										<input type='checkbox' id='right' name='right' value='add' style='width:15px;height:15px;border:0px;'>
										<!-- 添加 -->
										<label style='text-align: left;'><fmt:message key="menuManager.add" /></label>
									</td>
									<td height="20" width="10%" color="#666666">
										<input type='checkbox' id='right' name='right' value='edit' style='width:15px;height:15px;border:0px;'>
										<!-- 修改 -->
										<label style='text-align: left;'><fmt:message key="menuManager.update" /></label>
									</td>
									<td height="20" width="10%" color="#666666">
										<input type='checkbox' id='right' name='right' value='delete' style='width:15px;height:15px;border:0px;'>
										<!-- 删除 -->
										<label style='text-align: left;'><fmt:message key="menuManager.delete" /></label>
									</td>
									<td height="20" width="10%" color="#666666">
										<input type='checkbox' id='right' name='right' value='delB' style='width:15px;height:15px;border:0px;'>
										<!-- 批量删除 -->
										<label style='text-align: left;'><fmt:message key="menuManager.Bulkdelete" /></label>
									</td>
									<td height="20" width="10%" color="#666666">
										<!-- 批量修改 -->
										<input type='checkbox' id='right' name='right' value='editB' style='width:15px;height:15px;border:0px;'>
										<label style='text-align: left;'><fmt:message key="menuManager.Bulkupdate" /></label>
									</td>
								</tr>
								<tr>
									<td height="20" width="10%" color="#666666">
										<input type='checkbox' id='right' name='right' value='query' style='width:15px;height:15px;border:0px;'>
										<!-- 高级查询 -->
										<label style='text-align: left;'><fmt:message key="menuManager.SeniorInquires" /></label>
									</td>
									<td height="20" width="10%" color="#666666">
										<input type='checkbox' id='right' name='right' value='showInfo' style='width:15px;height:15px;border:0px;'>
										<!-- 显示详细 -->
										<label style='text-align: left;'><fmt:message key="menuManager.Display" /></label>
									</td>
									<td height="20" width="10%" color="#666666">
										<input type='checkbox' id='right' name='right' value='orderBy' style='width:15px;height:15px;border:0px;'>
										<!-- 组合排序 -->
										<label style='text-align: left;'><fmt:message key="menuManager.Sortofportfolio" /></label>
									</td>
									<td height="20" width="10%" color="#666666">
										<input type='checkbox' id='right' name='right' value='jdQuery' style='width:15px;height:15px;border:0px;'>
										<!-- 简单查询 -->
										<label style='text-align: left;'><fmt:message key="menuManager.query" /></label>
									</td>
									<td height="20" width="10%" color="#666666">
										<input type='checkbox' id='right' name='right' value='export' style='width:15px;height:15px;border:0px;'>
										<!-- 导出数据 -->
										<label style='text-align: left;'><fmt:message key="menuManager.Deriveddata" /></label>
									</td>
								</tr>	
								<tr>	
									<td height="20" width="10%" color="#666666">
										<input type='checkbox' id='right' name='right' value='print' style='width:15px;height:15px;border:0px;'>
										<!-- 打印 -->
										<label style='text-align: left;'><fmt:message key="menuManager.print" /></label>
									</td>
									<td height="20" width="10%" color="#666666">
										<input type='checkbox' id='right' name='right' value='modQuery' style='width:15px;height:15px;border:0px;'>
										<!-- 模板查询 -->
										<label style='text-align: left;'><fmt:message key="menuManager.templatequery" /></label>
									</td>
									<td height="20" width="10%" color="#666666" colspan='2'>
										<input type='checkbox' id='right' name='right' value='saveQueryM' style='width:15px;height:15px;border:0px;'>
										<!-- 将查询保存为模板 -->
										<label style='text-align: left;'><fmt:message key="menuManager.Savequeryastemplate" /></label>
									</td>
									<td height="20" width="10%" color="#666666"></td>
									<td height="20" width="10%" color="#666666"></td>
								</tr>
							</table>	
					</div>
			    	</td>			    
			 	 </tr>			 	 
			</table>
		</form>
		</div>
		<div class="midd_butt">
			<!-- 确定 -->
			<button class="tsd-button" style="width:80px;heigth:27px;" onclick="close_oper();"><fmt:message key="menuManager.sure" /></button>				
			<button class="tsd-button" style="width:80px;heigth:27px;" onclick="closeTab();"><fmt:message key="global.close"/></button>
		</div>	
	</div>
</div>	
<!-- ********************************* 孙琳 ********************************* -->
			<div id="icon-panel">
				<form id="icon-form" name="iconForm"><%
					String rootPath = request.getRealPath("/style/icon");
					//System.out.println(rootPath);
					File[] iconlist = new File(rootPath).listFiles();
					if (iconlist.length > 0) {
						for (int i = 50; i < iconlist.length; i++) {
							File icon = iconlist[i];
							if (icon.toString().endsWith(".gif")) {
				%>
					<label onclick="this.getElementsByTagName('input')[0].checked=true;" style="display:inline-block;cursor:pointer;">
						<input type="radio" name="icons" value="style/icon/<%=icon.getName()%>"/>
						<img src="style/icon/<%=icon.getName()%>" disabled="disabled"/>
					</label><%}}}%>
				</form>
				<div class="iconp-buttons">
					<!-- 确定 取消 -->
					<button class="tsd-button" onclick="btnIconpOk_click();"><fmt:message key="menuManager.sure" /></button>
					<button class="tsd-button" onclick="btnIconpCancel_click();"><fmt:message key="menuManager.cancel" /></button>
				</div>
			</div>
		</div>	
		
		<div id="hidden-panel">
			<input type="hidden" id="groupid" value="<%=groupid%>" />
		</div>
	</body>
</html>
