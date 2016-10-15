<%----------------------------------------
	name: PhoneQuery/userpwdM.jsp
	author: 吴长龙 
	version: 1.0, 2010-11-12
	description: 用户密码查询管理  User Password Management
	modify: 
		2010-11-12 吴长龙 添加注释
		2010-11-12 吴长龙 移植
		
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.tsd.service.util.Log"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	
	String userid = (String) session.getAttribute("userid");
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
	String languageType = (String) session.getAttribute("languageType");
	
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date now = new Date();
	String nowTime = format.format(now);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>User Password Management</title>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<!-- 验证框架需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/validate/jquery.validate.js" ></script>
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
		
		<!-- 弹出对话框需要导入的js文件 -->			
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<!-- dtree需要导入文件 -->
		<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />

		<!-- 本项目引入 -->
		<script type="text/javascript" src="script/usercat/main.js"></script>
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<!-- 验证数据长度 -->
		<script src="script/public/datalength.js" type="text/javascript"></script>
		<!-- 导航 -->
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/public.js" type="text/javascript"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->



		<script type="text/javascript">
		
		/**
		 * 查看当前用户的扩展权限，对spower字段进行解析
		 * @param 无参数
		 * @return 无返回值
		 */
		function getUserPower(){
				 var urlstr=tsd.buildParams({ 	  packgname:'service',
							 					  clsname:'Procedure',
												  method:'exequery',
							 					  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
							 					  tsdpname:'userpwdM.getPower',//存储过程的映射名称
							 					  tsdExeType:'query',
							 					  datatype:'xmlattr'
						 					});
				/************************
				*   调用存储过程需要的参数 *
				**********************/
				var userid = $('#useridd').val();	
				var groupid = $('#zid').val();
				var imenuid = $('#imenuid').val();
				
				/****************
				*   拼接权限参数 *
				**************/
				
				var addright = '';
				var delBright = '';
				var editBright = '';				
				var deleteright = '';
				var editright = '';
				var editfields = '';				
				var exportright = '';
				var printright ='';
				
				/**
				添加模板查询
				queryright queryMright saveQueryMright
				hasquery hasqueryM hassaveQueryM 
				**/
				var queryright = '';				
				var queryMright = '';
				var saveQueryMright ='';
				
				var flag = false;				
				var spower = '';				
				var str = 'true';
				
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
				if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');
						
						for(var i = 0;i<spowerarr.length-1;i++){
							addright += getCaption(spowerarr[i],'add','')+'|';
							
							delBright += getCaption(spowerarr[i],'delB','')+'|';
							
							editBright += getCaption(spowerarr[i],'editB','')+'|';	
														
							deleteright += getCaption(spowerarr[i],'delete','')+'|';
							
							editright += getCaption(spowerarr[i],'edit','')+'|';	
							
							editfields += getCaption(spowerarr[i],'editfields','');
							
							exportright += getCaption(spowerarr[i],'export','')+'|';
							
							printright += getCaption(spowerarr[i],'print','')+'|';
							
							queryright += getCaption(spowerarr[i],'query','')+'|';
							
							queryMright += getCaption(spowerarr[i],'queryM','')+'|';
							
							saveQueryMright += getCaption(spowerarr[i],'saveQueryM','')+'|';
							
						}
				}else if(spower=='all@'){
						$("#addright").val(str);
						$("#delBright").val(str);
						$("#editBright").val(str);
						
						$("#deleteright").val(str);
						$("#editright").val(str);						
						$("#exportright").val(str);
						$("#printright").val(str);
						
						$("#queryright").val(str);						
						$("#queryMright").val(str);
						$("#saveQueryMright").val(str);
						
						//var languageType = $("#languageType").val();
						editfields = getFields('vw_yhdang_pwd');
						flag = true;
				}				
				if(flag==false){
					var hasadd = addright.split('|');
					var hasdelB = delBright.split('|');
					var haseditB = editBright.split('|');
					var hasdelete = deleteright.split('|');
					var hasedit = editright.split('|');
					var hasexport = exportright.split('|');
					var hasprint = printright.split('|');
					
					var hasquery = queryright.split('|');
					var hasqueryM = queryMright.split('|');
					var hassaveQueryM = saveQueryMright.split('|');
					
					for(var i = 0;i<hasquery.length;i++){
						if(hasquery[i]=='true'){
							$("#queryright").val(str);
							break;
						}
					}					
					for(var i = 0;i<hasqueryM.length;i++){
						if(hasqueryM[i]=='true'){
							$("#queryMright").val(str);
							break;
						}
					}
					
					for(var i = 0;i<hassaveQueryM.length;i++){
						if(hassaveQueryM[i]=='true'){
							$("#saveQueryMright").val(str);
							break;
						}
					}			
					for(var i = 0;i<hasadd.length;i++){
						if(hasadd[i]=='true'){
							$("#addright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasdelB.length;i++){
						if(hasdelB[i]=='true'){
							$("#delBright").val(str);
							break;
						}
					}
					for(var i = 0;i<haseditB.length;i++){
						if(haseditB[i]=='true'){
							$("#editBright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasdelete.length;i++){
						if(hasdelete[i]=='true'){
							$("#deleteright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasedit.length;i++){
						if(hasedit[i]=='true'){
							$("#editright").val(str);
							break;
						}
					}					
					for(var i = 0;i<hasexport.length;i++){
						if(hasexport[i]=='true'){
							$("#exportright").val(str);
							break;
						}
					}					
					for(var i = 0;i<hasprint.length;i++){
						if(hasprint[i]=='true'){
							$("#printright").val(str);
							break;
						}
					}					
				}
				$("#editfields").val(editfields);
		}
		</script>
		<script type="text/javascript">
			/**
			 * jquery 加载页面后运行
			 * @param 无参数
			 * @return 无返回值
			 */		
			jQuery(document).ready(function(){
					//设置当前位置
					$("#navBar").append(genNavv());		
					
					// 用户权限判定，初始化用户可操作权限 			
					getUserPower();
					//获取个操作权限
										
					var queryright = $("#queryright").val();
					
					//获取个操作按钮可用性									
					if(queryright=="true"){
						document.getElementById("gjquery1").disabled=false;
						document.getElementById("gjquery2").disabled=false;
					}	
					loadGrid();//初始化加载jqgrid表
					setLabelN('vw_yhdang_pwd','','g');//设置添加修改面板中lable字段别名
					
			});	
			
			/**
			 * 初始化加载jqgrid表
			 * @param 无参数
			 * @return 无返回值
			 */	
			function loadGrid(){
					//获取文档 URL中“?”后面的信息 **设置jqgrid标题
					var navv = document.location.search;
					//获取url中变量为imenuname的属性值
					var infoo = decodeURIComponent(parseUrl(navv,"imenuname",""));				
					
					/////设置命令参数 用于初始化jqgrid					
					var urlstr = buildParamsSqlByS('tsdBilling','query','xml','userpwdM.query','userpwdM.querypage');
					//设置jqgrid的头部参数
					var col=[[],[]];
					col=getRb_Field('vw_yhdang_pwd','Dh',"修改",'50','ziduansF','Mima');//得到jqGrid要显示的字段					
					var column = $("#ziduansF").val();	
					
					jQuery("#editgrid").jqGrid({
						url:'mainServlet.html?'+urlstr+'&column='+column,
						datatype: 'xml', 
						colNames:col[0], 
						colModel:col[1],
						       	rowNum:10, //默认分页行数
						       	rowList:[10,15,20], //可选分页行数
						       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						       	pager: jQuery('#pagered'), 
						       	sortname: 'Dh', //默认排序字段
						       	viewrecords: true, 
						       	//hidegrid: false, 
						       	sortorder: 'asc',//默认排序方式 
						       	caption:infoo,				       	
						       	height:300, //高
						       //	width:document.documentElement.clientWidth-27,
						       	loadComplete:function(){
													$("#editgrid").setSelection('0', true);
													$("#editgrid").focus();
													///自动适应 工作空间
													var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
													setAutoGridHeight("editgrid",reduceHeight);
													//setAutoGridWidth("editgrid",'0');
													/*********定义需要的行链接按钮************
													////@1  表格的id
													////@2  链接名称
													////@3  链接地址或者函数名称
													////@4  行主键列的名称 可以是隐藏列
													////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
													////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	
													*/
													var editinfo = $("#editinfo").val();
													var deleteinfo = $("#deleteinfo").val();
													addRowOperBtnimage('editgrid','openRowModify','Dh','click',1,"style/images/public/ltubiao_01.gif",editinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'Mima');//修改
													//addRowOperBtnimage('editgrid','deleteRow','JhjID','click',2,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
													//addRowOperBtnimage('editgrid','openRowInfo','JhjID','click',3,'style/images/public/ltubiao_03.gif',"详细","&nbsp;&nbsp;&nbsp;");//详细
																						
												   	/****执行行按钮添加********
													*@1 表格ID
													*@2 操作按钮数量 等于定义数量
													*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换
													*/																				
													executeAddBtn('editgrid',1);
												}
						}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false}, //options 
							{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
							{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
							{reloadAfterSubmit:false}, // del options 
							{} // search options 
							); 
			}				
			
/**
 * 打开修改面板并加载将要修改的数据
 * @param key(唯一标识)
 * @param Mima(密码)
 * @return 无返回值
 */	
function openRowModify(key,Mima){
		//判断是否有权限
		var editright = $("#editright").val();
		if(editright=="true"){	
			markTable(0);//显示红色*号	
			var editinfo = $("#editinfo").val();
		 	$(".top_03").html(editinfo);//设置编辑框的标题
			isDisabledN('vw_yhdang_pwd','',''); //将修改面板的输入框全部	置为不可用
			setTableFields('vw_yhdang_pwd','','');//根据系统配置，把可修改字段对应标签设为可用
			openpan();//显示修改面板
			$("#modify").show();
			clearText('operformT1');//清空修改面板
			//关键字无论什么情况下都不能修改	
			$('#Dh').attr("disabled","disabled");
			$("#Dh").removeClass();
			$("#Dh").addClass("textclass2");
			$("#Dh").val(key);
			$("#Mima").val(Mima);
			$("#Mima2").val(Mima);
			$("#Mimaold").val(Mima);
		}
		else{
			var operationtips = $("#operationtips").val();
			var editpower = $("#editpower").val();
			jAlert(editpower,operationtips);
		}
		
}
	
/**
 * 修改
 * @param 无参数
 * @return 无返回值
 */	
function modifyObj(){
	
			 var params = buildParams();
			 if(params==false){return false;}	
			 	var urlstr=buildParamsSqlByS('tsdBilling','exe','xml','userpwdM.modifyPwd','');
			 	urlstr+=params;
			 	
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(msg){
						if(msg=="true"){
							//操作提示国际化
							var operationtips = $("#operationtips").val();
							//操作成功
							var successful = $("#successful").val();
							jAlert(successful,operationtips);
							/*************
							** 释放资源 **
							************/							
							setTimeout($.unblockUI, 15);
							
							//写入日志操作							
							var str ="(yhdang)<fmt:message key='global.edit'/>。";	
							//关键字信息							
							str += $("#Dhg").html()+": "+$("#Dh").val()+";";
							str += $("#Mimag").html()+": "+$("#Mimaold").val()+">>>"+$("#Mima").val()+";";						 			
							writeLogInfo("","modify",tsd.encodeURIComponent(str));	
							$("#editgrid").trigger("reloadGrid");
						}	
					}
				});	
}

/**
 * 添加修改参数获取
 * @param 无参数
 * @return String
 */	
function buildParams(){	
   
			//每次拼接参数必须初始化此参数
			tsd.QualifiedVal=true;				
		 	var params='';
			//Dh Mima Yhdz Yhmc Mima2
		 	var Dh = $("#Dh").val();
		 	var Mima = $("#Mima").val().replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
		 	var Mima2 = $("#Mima2").val().replace(/(^\s*)|(\s*$)/g,"");		 	
		  	
	 		if(Mima!=Mima2){
	 			alert("两次密码不一致，请重新输入密码！");
	 			$("#Mima").focus();
	 			return false;	 			
	 		}
		  	params=params+"&Dh="+Dh;
		  	params=params+"&Mima="+tsd.encodeURIComponent(Mima);  		
		  	
		 	//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
			return params;
			
}

	
			/**
			 * 执行复合查询出提交过来的相应操作
			 * @param 无参数
			 * @return 无返回值
			 */	
			function fuheExe()
			{
					fuheQuery();	//只有复合查询操作				
			
			}
			
			/**
			 * 复合查询操作
			 * @param 无参数
			 * @return 无返回值
			 */	
			function fuheQuery()
			{
					//获取查询sql where字符串
					var params = fuheQbuildParams();			
					if(params=='&fusearchsql='){
						params +='1=1';
					}
					//获取查询 字段 字符串	
					var column = $("#ziduansF").val();			
				 	
					/////设置命令参数 用于初始化jqgrid					
					var urlstr = buildParamsSqlByS('tsdBilling','query','xml','userpwdM.fuheQueryByWhere','userpwdM.fuheQueryByWherepage');
					var link = urlstr + params;
				 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");				 	
			}
			
			/**
			 * 组合排序
			 * @param sqlstr(组合排序条件)
			 * @return 无返回值
			 */	
			function zhOrderExe(sqlstr){
					//获取查询sql where字符串
					var params = fuheQbuildParams();			
					if(params=='&fusearchsql='){
						params +='1=1';
					}
					//获取查询 order by 字符串
					params =params+'&tsdOrderBy='+sqlstr;	
					//获取查询 字段 字符串
					var column = $("#ziduansF").val();					
					/////设置命令参数 用于初始化jqgrid					
					var urlstr = buildParamsSqlByS('tsdBilling','query','xml','userpwdM.queryByOrder','userpwdM.queryByOrderpage');
					
					var link = urlstr + params;						
				 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
			}  
			
			/**
			 * 复合查询参数获取，@oper 操作类型 fuhe 
			 * @param 无参数
			 * @return String
			 */		
			function fuheQbuildParams(){
				 	//每次拼接参数必须初始化此参数
					tsd.QualifiedVal=true;
				 	var params='';
				 	
				 	//如果有可能值是汉字 请使用encodeURI()函数转码
				 	var fusearchsql = encodeURIComponent($("#fusearchsql").val());			 	
				 	params+='&fusearchsql='+fusearchsql;
				 			 	
				 	//注意：不要在此做空的判断 即使为空 也必须放入请求中			 	
				 	//每次拼接参数必须添加此判断
					if(tsd.Qualified()==false){return false;}
					return params;
			}								
		</script>
		<script type="text/javascript">
		
		</script>
		<script type="text/javascript">
/**
 * 关闭表格面板
 * @param 无参数
 * @return 无返回值
 */	
function closeo(){		
		clearText('operformT1');	
		setTimeout($.unblockUI, 15);//关闭面板				
}

/**
 * 打开表格面板
 * @param 无参数
 * @return 无返回值
 */	
function openpan(){	
	autoBlockFormAndSetWH('pan',60,5,'closeo',"#ffffff",true,1000,'');//弹出查询面板
	$("#modify").hide();
}

/**
 * 清空输入密码信息
 * @param 无参数
 * @return 无返回值
 */	
function clearPwd(){
	$("#Mima").val("");
	$("#Mima2").val("");
}
</script>
  </head>
  




<style type="text/css">
		.style1 {
			background-color: #A9C3E8;
			padding: 4px;
		}
		#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
		cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
</style>  
<body >
		<div id="navBar1">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
							<fmt:message key="global.location" />
							:
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
		

			<!-- 用户操作标题以及放一些快捷按钮 头部-->
			<div id="buttons">
					
				<button type="button" id="order1" onclick="openDiaO('vw_yhdang_pwd');">
				<!--组合排序--><fmt:message key="order.title" />
			</button>			
				<button type="button" id='gjquery1' onclick="openDiaQueryG('query','vw_yhdang_pwd');" disabled="disabled">
				<!--高级查询-->	<fmt:message key="oper.queryA"/>
			</button>				
			</div>

			<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
			
			<!-- 用户操作标题以及放一些快捷按钮  底部-->
			<div id="buttons">
				<button type="button" id="order2" onclick="openDiaO('vw_yhdang_pwd');">
				<!--组合排序--><fmt:message key="order.title" />
			</button>			
				<button type="button" id='gjquery2' onclick="openDiaQueryG('query','vw_yhdang_pwd');" disabled="disabled">
				<!--高级查询-->	<fmt:message key="oper.queryA"/>
			</button>	
			</div>
		
		

<!-- 添加修改面板 开始-->
		<div class="neirong" id="pan" style="display: none">
			<br />
			<div class="top">
				<div class="top_01">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03">
							功能名称
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="closeo()"><span style="margin-left: 5px;"><fmt:message
									key="global.close" />
						</span>
						</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form id='operformT1' name="operformT1" onsubmit="return false;"
					action="#">
					<input type="hidden"></input>
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0" style="line-height: 33px; font-size: 12px;">

						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Dhg"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Dh" id="Dh" 									
									class="textclass"></input>
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Mimag"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="password" name="Mima" id="Mima" 
									style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=48&&k<=57" maxlength="16" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false"
									class="textclass"></input>
									<label class="addred">							
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Mima2g"></label>
							</td>
							<td width="20%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="password" name="Mima2" id="Mima2" 
									style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=48&&k<=57" maxlength="16" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false"
									class="textclass"/>
									<label class="addred">
							</td>
						</tr>						
					</table>
				</form>
				<div class="midd_butt">
					<!-- 修改     -->
					<button class="tsdbutton" id="modify"
						style="width: 63px; heigth: 27px;" onclick="modifyObj();">
						<fmt:message key="global.edit" />
					</button>
					 <!-- 清空     -->
					 <button class="tsdbutton" id="clearB" style="width:63px;heigth:27px;" onclick="clearPwd();" >
					 	<fmt:message key="global.clear" /></button>			
					<!-- 关闭 	 -->
					<button class="tsdbutton" id="closeo"
						style="width: 63px; heigth: 27px;" onclick="closeo();">
						<fmt:message key="global.close" />
					</button>
				</div>
			</div>
		</div>


<!-- 添加修改面板 结束-->


<!-- 页面通用隐藏域 开始-->
		<div style="display: none">
			<form name="childform" id="childform">
				<input type="text" id="queryName" name="queryName" value=""
					style="display: none" />
				<input type="text" id="fusearchsql" name="fusearchsql"
					style="display: none" />
			</form>
			<input type="hidden" id="imenuid" value="<%=imenuid%>" />
			<input type="hidden" id="zid" value="<%=zid%>" />
			<%
				if (!languageType.equals("en")) {
					languageType = "zh";
				}
			%>
			<input type="hidden" id="languageType" value="<%=languageType%>" />

			<input type="hidden" id="addinfo"
				value="<fmt:message key="global.add"/>" />
			<input type="hidden" id="deleteinfo"
				value="<fmt:message key="global.delete"/>" />
			<input type="hidden" id="editinfo"
				value="<fmt:message key="global.edit"/>" />
			<input type="hidden" id="queryinfo"
				value="<fmt:message key="global.query"/>" />

			<input type="hidden" id="operation"
				value="<fmt:message key="global.operation"/>" />
			<input type="hidden" id="operationtips"
				value="<fmt:message key="global.operationtips"/>" />
			<input type="hidden" id="successful"
				value="<fmt:message key="global.successful"/>" />
			<input type="hidden" id="deleteinformation"
				value="<fmt:message key="global.deleteinformation"/>" />

			<input type="hidden" id="worninfo"
				value="<fmt:message key="zhji.zjjxonly"/>" />
			<input type="hidden" id="worntips"
				value="<fmt:message key="powergroup.worntips"/>" />

			<input type="hidden" id="deletepower"
				value="<fmt:message key="global.deleteright"/>" />
			<input type="hidden" id="editpower"
				value="<fmt:message key="global.editright"/>" />

			<input type="hidden" id="zhjititle"
				value="<fmt:message key="tariff.zhji" />" />

			<input type="hidden" id="addright" />
			<input type="hidden" id="deleteright" />
			<input type="hidden" id="editright" />
			<input type="hidden" id="editfields" />
			<input type="hidden" id="delBright" />
			<input type="hidden" id="editBright" />
			<input type="hidden" id="exportright" />
			<input type="hidden" id="printright" />


			<!-- 用于写入日志 -->
			<input type="hidden" id="userloginip"
				value="<%=Log.getIpAddr(request)%>" />
			<input type="hidden" id="userloginid"
				value="<%=session.getAttribute("userid")%>" />
			<input type="hidden" id="thislogtime" value="<%=Log.getThisTime()%>" />
			<!-- 修改时保存原来数据的隐藏域 -->
			<input type="hidden" id="logoldstr" />
			<input type="hidden" id="useridd" value="<%=userid%>" />

			<!-- 打印报表 -->
			<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
			<!-- 高级查询 模板隐藏域 -->
			<input type="hidden" id="queryright" />
			<input type="hidden" id="queryMright" />
			<input type="hidden" id="saveQueryMright" />
			<!-- 查询树信息存放 -->
			<input type="hidden" id='treepid' />
			<input type="hidden" id='treecid' />
			<input type="hidden" id='treestr' />
			<input type="hidden" id='treepic' />

			<!-- grid自动 -->
			<input type="hidden" id='ziduansF' />
			<input type='hidden' id='thecolumn' />
			
			<input type="text" id="Mimaold"/>
<!-- 页面通用隐藏域 结束-->			
	</body>
</html>
