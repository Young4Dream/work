<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/telReprint.jsp
    Function:   电话票据重打
    Author:     wenxuming
    Date:       2010-10
    Description: 
    Modify: 
     2010-10月份 对该页面进行移植，并对版式进行修改；
     2010-11-03 把公用的CSS提取出来放到style/css/telephone/business/businesspublic.css；
-----------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
	String languageType = (String) session.getAttribute("languageType");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>telReprint</title>
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
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<!-- dtree需要导入文件 -->
		<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />	
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservice.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservicenew.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/public.js" type=text/javascript language="javascript"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->	
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
		<script language="javascript" type="text/javascript">
			/*********
			*  设置权限
			* @param;
			* @return;
		    **********/
			function setUserRight()
			{//alert("&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
				//获取权限信息
				var allRi = fetchMultiPValue("telReprint.getPower",6,"&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
				//解析从数据库得到的权限信息
				if(typeof allRi == 'undefined' || allRi.length == 0)
				{
					//alert("取权限失败");
					return false;
				}
				//admin登入权限设置
				if(allRi[0][0]=="all")
				{
					//打印隐藏域
					$("#printt").val("true");
					$("#RightGroup").val("10");
					return true;
				}				
				var printt = false;
				var rightgroup = 0;
				for(var i = 0;i<allRi.length;i++){
					var rg = getCaption(allRi[i][0],'RightsGroup','');
					if(parseInt(rg,10)>rightgroup)
					{
						rightgroup = parseInt(rg,10);
					}
					if(getCaption(allRi[i][0],'print','')=="true")
						printt = true;
				}
				//打印隐藏域	
				$("#printt").val(printt);
				//权限组信息设置
				$("#RightGroup").val(rightgroup);
			}
			//页面初始化
			$(function(){
				//页面所在位置
				$("#navBar").append(genNavv());
				//gobackInNavbar("navBar1");
				setUserRight();	//权限设置	
				loadJqgrid();//加载jqgrid				
				getTDName();//从别名表中获取该表别名用去显示显示信息处显示字段名
				//jqgrid 加载信息初始化，获取显示字段
				kdDat = loadData("v_jobflow_radjob",$("#lanType").val(),1,"<fmt:message key="phone.getinternet0320" />&nbsp;|&nbsp;<fmt:message key="phone.getinternet0321" />&nbsp;|&nbsp;<fmt:message key="phone.getinternet0320" />|&nbsp;<fmt:message key="phone.getinternet0321" />&nbsp;|&nbsp;<fmt:message key="phone.getinternet0322" />");
				//kdDat.setWidth({'Operation':'180'});
				kdDat.colModels[0].width=185;
				kdDat.setHidden(['JobID']);			
				//loadKdTab();//加载jqgrid
				//thisDetailField();						
			});

			/*********
			* 加载jqgrid
			* @param;
			* @return;
		    **********/
			function loadJqgrid(){
					//判断权限 RightGroup权限组 
					var keyEnd = "";
					
					if($("#RightGroup").val()=="3")
					{
						keyEnd = "Monitor";
					}
					else if($("#RightGroup").val()=="10")
					{
						keyEnd = "Operator";
					}else if($("#RightGroup").val()=="0"){
						keyEnd = "useridto";
					}				
					/////设置命令参数 用于初始化jqgrid
					var urlstr=tsd.buildParams({ 	  
												packgname:'service',//java包
												clsname:'ExecuteSql',//类名
												method:'exeSqlData',//方法名
												ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												tsdcf:'mssql',//指向配置文件名称
												tsdoper:'query',//操作类型 
												datatype:'xml',//返回数据格式 
												tsdpk:'telReprint.query'+keyEnd,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												tsdpkpagesql:'telReprint.querypage'+keyEnd//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
					});
					//操作人id
					urlstr += "&skrid=";
					urlstr += $("#skrid").val();
					//操作人所在区域
					urlstr += "&area=";
					urlstr += tsd.encodeURIComponent($("#area").val());
					//alert($("#area").val());
					//alert($("#area").val());
					
					//设置jqgrid的头部参数
					var col=[[],[]];
					col=getRb_Field('vw_TelJob','ID',"&nbsp;打印&nbsp;|&nbsp;预览&nbsp;|&nbsp;打印&nbsp;|&nbsp;预览&nbsp;|&nbsp;套打&nbsp;",'200','ziduansF','Sgnr','Yjkx');//得到jqGrid要显示的字段
					//alert(col[0]);					
					//var column = $("#ziduansF").val();
					var column = "ID,ID,Sgnr,Yjkx,Xdh,Sgrq,Hth,Area,Value18,Jlry,Xm,Ywarea,Dhlx,Lsh,IsPay";
					//获取文档 URL中“?”后面的信息 **设置jqgrid标题
					var navv = document.location.search;
					//获取url中变量为imenuname的属性值
					var infoo = decodeURIComponent(parseUrl(navv,"imenuname",""));	
					jQuery("#editgrid").jqGrid({
						url:'mainServlet.html?'+urlstr+'&column='+column,
						datatype: 'xml', 
						//colNames:col[0],
						colNames:['id','&nbsp;<fmt:message key="phone.getinternet0320" />&nbsp;|&nbsp;<fmt:message key="phone.getinternet0321" />&nbsp;|&nbsp;<fmt:message key="phone.getinternet0320" />&nbsp;|&nbsp;<fmt:message key="phone.getinternet0321" />&nbsp;',
									'<fmt:message key="phone.getinternet0323" />',//业务类型
									'<fmt:message key="phone.getinternet0324" />',//应缴款项
									'<fmt:message key="phone.getinternet0325" />',//现电话
									'<fmt:message key="phone.getinternet0326" />',//受理日期
									'<fmt:message key="phone.getinternet0100" />',//合同号
									'<fmt:message key="phone.getinternet0327" />',//营业点
									'<fmt:message key="phone.getinternet0097" />',//预存金额
									'<fmt:message key="phone.getinternet0328" />',//受理人员
									'<fmt:message key="phone.getinternet0280" />',//用户名称
									'<fmt:message key="phone.getinternet0329" />',//业务所在区域
									'<fmt:message key="phone.getinternet0330" />',//电话类型
									'<fmt:message key="phone.getinternet0331" />',//票据号
									'<fmt:message key="phone.getinternet0090" />'], //付费方式
						//colModel:col[1],
						//ID,Sgnr,Yjkx,Xdh,Sgrq,Hth,Area,Value18,Jlry,Xm,Ywarea,Dhlx,Lsh,IsPay
						colModel:[{name:'ID',index:'ID',hidden:true,width:0},
									{name:'viewOperation',index:'viewOperation',width:170},
			    		   			{name:'Sgnr',index:'Sgnr',width:100}, 
				           			{name:'Yjkx',index:'Yjkx',width:150},
				           			{name:'Xdh',index:'Xdh',width:100},
				           			{name:'Sgrq',index:'Sgrq',width:150},
				           			{name:'Hth',index:'Hth',width:100},
				           			{name:'Area',index:'Area',width:150},
				           			{name:'Value18',index:'Value18',width:150},
				           			{name:'Jlry',index:'Jlry',width:100},
				           			{name:'Xm',index:'Xm',width:150},
				           			{name:'Ywarea',index:'Ywarea',width:100},
				           			{name:'Dhlx',index:'Dhlx',width:100},
				           			{name:'Lsh',index:'Lsh',width:150},
				           			{name:'IsPay',index:'IsPay',width:100},
				           		],
						       	rowNum:10, //默认分页行数
						       	rowList:[10,15,20], //可选分页行数
						       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						       	pager: jQuery('#pagered'), 
						       	sortname: 'Sgrq', //默认排序字段
						       	viewrecords: true, 
						       	//hidegrid: false, 
						       	sortorder: 'desc',//默认排序方式 
						       	caption:infoo,				       	
						       	height:300, //高
						       //	width:document.documentElement.clientWidth-27,
						       	loadComplete:function(){
													//$("#editgrid").setSelection('0', true);
													//$("#editgrid").focus();
													///自动适应 工作空间
													//var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
													//setAutoGridHeight("editgrid",reduceHeight);
													//setAutoGridWidth("editgrid",'0');
													/*********定义需要的行链接按钮************
													////@1  表格的id
													////@2  链接名称
													////@3  链接地址或者函数名称
													////@4  行主键列的名称 可以是隐藏列
													////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
													////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	
													*/
																										
													/**addRowOperBtnimage('editgrid','printKDJob','ID','click',1,"images/printreport.png","打印业务受理单","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'Sgnr');//
													addRowOperBtnimage('editgrid','kdPrintPrewJob','ID','click',2,"images/print-view.png","预览业务受理单","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'Sgnr');//
													addRowOperBtnimage('editgrid','printKDSF','ID','click',3,'images/printreport.png',"打印收费单","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'Yjkx');//
													addRowOperBtnimage('editgrid','kdPrintPrewSF','ID','click',4,"images/print-view.png","预览收费单","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'Yjkx');//
													addRowOperBtnimage('editgrid','printKDJobTD','ID','click',5,'images/printreport.png',"套打","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'Sgnr');//
																	        										
												   	/  ****执行行按钮添加********
													*@1 表格ID
													*@2 操作按钮数量 等于定义数量
													*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换
													* /																				
													executeAddBtn('editgrid',5);
													*/
													//if($("#editgrid tr.jqgrow[id='1']").html()=="")
													//return false;
													addRowOperBtn('editgrid','<img src="style/images/public/printreport.png" title="<fmt:message key="phone.getinternet0332" />" />','printKDJob','ID','click',1,'Sgnr');					        	
										        	addRowOperBtn('editgrid','<img src="style/images/public/print-view.png" title="<fmt:message key="phone.getinternet0333" />" />','kdPrintPrewJob','ID','click',2,'Sgnr');					        	
										        	addRowOperBtn('editgrid','<img src="style/images/public/printreport.png" title="<fmt:message key="phone.getinternet0334" />" />','printKDSF','ID','click',3,'Yjkx','IsPay','Value18');					        	
										        	addRowOperBtn('editgrid','<img src="style/images/public/print-view.png" title="<fmt:message key="phone.getinternet0335" />" />','kdPrintPrewSF','ID','click',4,'Yjkx','IsPay','Value18');
										        	//addRowOperBtn('editgrid','<img src="style/images/public/printreport.png" title="套打" />','printKDJobTD','ID','click',5,'Sgnr');										        	
										        	executeAddBtn('editgrid',4);	
												},
												ondblClickRow: function(ids) {
														if(ids != null) {
															var ID =$("#editgrid").getCell(ids,"ID");
															openRowInfo(ID);
														}
												}
						}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false}, //options 
							{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
							{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
							{reloadAfterSubmit:false}, // del options 
							{} // search options 
							); 
					
			}
			
			/*********
			* 打印工单票据
			* @param：ID工单ID，Sgnr业务类型;
			* @return;
		    **********/
			function printKDJob(ID,Sgnr)
			{
				if($("#printt").val()=="false")
				{
					//alert("你没有打印权限");
					alert("<fmt:message key="phone.getinternet0336" />");
				}
				else
				{
					var printfile ='dh_feeorder';
					printWithoutPreview("commonreport/dh_jobworkorder","JobID_"+ID);					
					//printThisReport1('<%=request.getParameter("imenuid")%>',printfile,'&JobID='+ID,'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');				
					//增加重打次数
					refreshPrinttimes(2,ID);
				}
			}
			
			/*********
			* 预览工单报表
			* @param：ID工单ID，Sgnr业务类型;
			* @return;
		    **********/
			function kdPrintPrewJob(ID,Sgnr)
			{
				
				var printfile ='commonreport/dh_jobworkorder';
				var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/"+printfile+".cpt&JobID="+ID;		
				window.showModalDialog(urll,window,"dialogWidth:760px; dialogHeight:580px; center:yes; scroll:no");
			}
			
			/*********
			* 套打
			* @param：ID工单ID，Sgnr业务类型;
			* @return;
		    **********/
			function printKDJobTD(ID,Sgnr)
			{
				/************
				if($("#printt").val()=="false")
				{
					alert("你没有打印权限");
				}
				else
				{
					var printfile = "broadband_jobadduser_td";
					//增加重打次数
					refreshPrinttimes(2,jobid);
					
					printWithoutPreview(printfile,"JobID_"+jobid);
				}
				************/
			}
						
			/*********
			* 打印收费票据
			* @param：ID工单ID，Yjkx费用;
			* @return;
		    **********/
			function printKDSF(ID,Yjkx,IsPay,Value18)
			{
				if($("#printt").val()=="false")
				{
					//alert("你没有打印权限");
					alert("<fmt:message key="phone.getinternet0336" />");
				}
				if(Value18==""){Value18="0";}
				else if(Yjkx==""&&Value18=="0")
				{
					//alert("费用为空，不能打印");					
					alert("<fmt:message key="phone.getinternet0337" />");
				}
				else				
				{
					/*****
       				*获取付费类型pay_item表中的prtmodename字段的报表路径名，空为不答应票据
       				*****/
       				var res = fetchSingleValue("dbsql_phone.queryprtmodename",6,"&kemu=pbusinessfee&pay_name="+tsd.encodeURIComponent(IsPay));
       				if(res==""||res==undefined||res=="undefined"){
       					//alert("没有配置报表路径！");
       					alert("<fmt:message key="phone.getinternet0338" />");
       					return;
       				}else{
						//var printfile = "commonreport/dh_sf_reprint";
						printWithoutPreview('charge/busiCharge',"jobid_"+ID);
						//var fees = analizeFeeName(Yjkx);
						//var param = "";					
						//printThisReport1('<%=request.getParameter("imenuid")%>',printfile,'&JobID='+ID,'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');
						//增加重打次数
						refreshPrinttimes(1,ID);
					}
				}
			}

			/*********
			* 打印工单或是票据之后，在数据表中添加打印次数
			* @param：ID，类型type;
			* @return;
		    **********/
			function refreshPrinttimes(type,id)
			{
				if(type==1){
					executeNoQuery("telReprint.reprintsf",7,"&ID="+id);
				}
				else if(type==2){
					executeNoQuery("telReprint.reprintjob",7,"&ID="+id);
				}
			}
									
			/*********
			* 中文转码
			* @param：text转码内容;
			* @return;
		    **********/
			function cjkEncode(text) {   
        	    if (text == null) {   
        	        return "";   
        	    }   
        		var newText = "";   
        	    for (var i = 0; i < text.length; i++) {   
        	        var code = text.charCodeAt (i);    
        	        if (code >= 128 || code == 91 || code == 93) {//91 is "[", 93 is "]".   
        	            newText += "[" + code.toString(16) + "]";   
        	        } else {   
        	            newText += text.charAt(i);   
        	        }   
        	    }   
        	 return newText;   
        	}  
			
			/*********
			* 预览收费票据
			* @param：ID工单id，Yjkx费用值;
			* @return;
		    **********/
			function kdPrintPrewSF(ID,Yjkx,IsPay,Value18)
			{
				if(Value18==""){Value18="0";}				
				if(Yjkx==""&&Value18=="0")
				{
					//alert("费用为空，不能打印");					
					alert("<fmt:message key="phone.getinternet0337" />");
				}
				else
				{
					/*****
       				*获取付费类型pay_item表中的prtmodename字段的报表路径名，空为不答应票据
       				*****/
       				var res = fetchSingleValue("dbsql_phone.queryprtmodename",6,"&kemu=pbusinessfee&pay_name="+tsd.encodeURIComponent(IsPay));
       				if(res==""||res==undefined||res=="undefined"){
       					//alert("没有配置报表路径！");
       					alert("<fmt:message key="phone.getinternet0338" />");
       					return;
       				}else{
						var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/charge/busiCharge.cpt&jobid="+ID;
						window.showModalDialog(urll,window,"dialogWidth:760px; dialogHeight:380px; center:yes; scroll:no");
					}					
				}
			}
			
			/*********
			* 解析杂费项
			* @param：feename杂费项;
			* @return:feens返回字符串;
		    **********/
			function analizeFeeName(feename)
			{				
				var feenames = feename.split(",");
				var feens = [];
				var temp = [];
				
				for(var i=0;i<feenames.length;i++)
				{
					temp = feenames[i].split("：");
					feens.push(temp[0]);
					feens.push(temp[1].replace("<fmt:message key="phone.getinternet0161" />",""));//元
				}
				return feens;
			}		
			
						
			/*********
			* 方法 显示详细信息
			* @param:key;
			* @return;
		    **********/
			function openRowInfo(key){
					//设置编辑框的标题
					//$(".top_03").html("详细信息");//标题
					$(".top_03").html("<fmt:message key="phone.getinternet0339" />");//标题
				 	//将修改面板的输入框全部	置为不可用	
					isDisabledN('vw_TelJob','','');
					clearText('operformT1');
					queryByID(key);
					//openpan();
					autoBlockFormAndSetWH('pan',60,5,'closeo',"#ffffff",false,1000,'');//弹出查询面板	
			}
			
			/*********
			* 取出一条数据显示在修改面板中
			* @param:key;
			* @return;
		    **********/
			function queryByID(key){  
			 		$("#ID").val(key);	 		
					var urlstr=tsd.buildParams({  
										  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xmlattr',//返回数据格式 
										  tsdpk:'teljob.querydetail'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										});	
					$.ajax({
						url:'mainServlet.html?'+urlstr+'&jobid='+key+'&tsdtemp='+Math.random(),
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值
							$(xml).find('row').each(function(){
							
								//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
								///如果sql语句中指定列名 则按指定名称给参数		
								$("#Area").val($(this).attr("area"));
								$("#BeginYwArea").val($(this).attr("beginywArea"));
								$("#Bm1").val($(this).attr("bm1"));
								$("#Bm2").val($(this).attr("bm2"));
								$("#Bm3").val($(this).attr("bm3"));
																
								$("#Bm4").val($(this).attr("bm4"));
								$("#Bz").val($(this).attr("zwbz"));
								$("#CardID").val($(this).attr("cardid"));
								$("#Dhgn").val($(this).attr("dhgn"));
								$("#Dhlx").val($(this).attr("dhlx"));
																
								$("#dJhwcsj").val($(this).attr("djhwcsj"));
								$("#Hth").val($(this).attr("hth"));
								$("#IDD").val($(this).attr("idd"));
								$("#IfCancel").val($(this).attr("ifcancel"));
								$("#IsComplete").val($(this).attr("iscomplete"));
								
								$("#isJudge").val($(this).attr("isjudge"));
								$("#IsPay").val($(this).attr("ispay"));
								$("#Jlry").val($(this).attr("jlry"));
								$("#JobState").val($(this).attr("jobstate"));
								$("#Jsbm").val($(this).attr("jsbm"));
																
								$("#LinkMan").val($(this).attr("linkman"));
								$("#Lsh").val($(this).attr("lsh"));
								$("#Lxdh").val($(this).attr("lxdh"));
								$("#Mqbm").val($(this).attr("mqbm"));
								$("#Nxm").val($(this).attr("nxm"));
								
								$("#Pgrq").val($(this).attr("pgrq"));
								$("#Pgrz").val($(this).attr("pgrz"));
								$("#Sgnr").val($(this).attr("sgnr"));
								$("#Sgrq").val($(this).attr("sgrq"));
								$("#Sjje").val($(this).attr("sjje"));
								
								$("#Slbm").val($(this).attr("slbm"));
								$("#TypeID").val($(this).attr("typeid"));
								$("#Wgbm").val($(this).attr("wgbm"));
								$("#Wgrq").val($(this).attr("wgrq"));
								$("#Xdh").val($(this).attr("xdh"));
								
								$("#Xdz").val($(this).attr("xdz"));
								$("#Xm").val($(this).attr("xm"));
								$("#Ydh").val($(this).attr("ydh"));
								$("#Ydz").val($(this).attr("ydz"));
								$("#YHth").val($(this).attr("yhth"));
								
								$("#Yhxz").val($(this).attr("yhxz"));
								$("#Yjje").val($(this).attr("yjje"));
								$("#Yjkx").val($(this).attr("yjkx"));
								$("#Ywarea").val($(this).attr("ywarea"));
								isNullValue();
							});
						}
					});
			}
			
			/*********
			* 替换查看详细面板input 类型text中的value为null=空
			* @param;
			* @return;
		    **********/			
			function isNullValue(){
				//var items = $("#operformT1 input");
				//alert(items.length);
				//得到id=operformT1的表单中的所有input控件，对他们进行遍历，如果他们的value值为null则替换为空
				$("#operformT1 input").each(function(i){
					if(this.value == null||this.value=="null"){
						this.value ="";
					}
				 });
			}
						
			/*********
			* 从别名表中获取该表别名用去显示显示信息处显示字段名
			* @param;
			* @return;
		    **********/	
			function getTDName(){
					//获取数据表对应字段国际化信息					
					var thisdata = loadData('vw_TelJob','<%=languageType %>',6);									
					var Areag = thisdata.getFieldAliasByFieldName('Area');
					var BeginYwAreag = thisdata.getFieldAliasByFieldName('BeginYwArea');
					var Bm1g = thisdata.getFieldAliasByFieldName('Bm1');
					var Bm2g = thisdata.getFieldAliasByFieldName('Bm2');
					var Bm3g = thisdata.getFieldAliasByFieldName('Bm3');
					
					//给页面中存储字段的隐藏标签赋值			
					$("#Areag").html(Areag);
					$("#BeginYwAreag").html(BeginYwAreag);
					$("#Bm1g").html(Bm1g);
					$("#Bm2g").html(Bm2g);	
					$("#Bm3g").html(Bm3g);	
					
					var Bm4g = thisdata.getFieldAliasByFieldName('Bm4');
					var Bzg = thisdata.getFieldAliasByFieldName('Bz');
					var CardIDg = thisdata.getFieldAliasByFieldName('CardID');
					var Dhgng = thisdata.getFieldAliasByFieldName('Dhgn');
					var Dhlxg = thisdata.getFieldAliasByFieldName('Dhlx');
					
					//给页面中存储字段的隐藏标签赋值			
					$("#Bm4g").html(Bm4g);
					$("#Bzg").html(Bzg);
					$("#CardIDg").html(CardIDg);
					$("#Dhgng").html(Dhgng);	
					$("#Dhlxg").html(Dhlxg);	
					
					var dJhwcsjg = thisdata.getFieldAliasByFieldName('dJhwcsj');
					var Hthg = thisdata.getFieldAliasByFieldName('Hth');
					var IDDg = thisdata.getFieldAliasByFieldName('IDD');
					var IfCancelg = thisdata.getFieldAliasByFieldName('IfCancel');
					var IsCompleteg = thisdata.getFieldAliasByFieldName('IsComplete');
					
					//给页面中存储字段的隐藏标签赋值			
					$("#dJhwcsjg").html(dJhwcsjg);
					$("#Hthg").html(Hthg);
					$("#IDDg").html(IDDg);
					$("#IfCancelg").html(IfCancelg);	
					$("#IsCompleteg").html(IsCompleteg);	
					
					var isJudgeg = thisdata.getFieldAliasByFieldName('isJudge');
					var IsPayg = thisdata.getFieldAliasByFieldName('IsPay');
					var Jlryg = thisdata.getFieldAliasByFieldName('Jlry');
					var JobStateg = thisdata.getFieldAliasByFieldName('JobState');
					var Jsbmg = thisdata.getFieldAliasByFieldName('Jsbm');
							
					$("#isJudgeg").html(isJudgeg);
					$("#IsPayg").html(IsPayg);
					$("#Jlryg").html(Jlryg);
					$("#JobStateg").html(JobStateg);	
					$("#Jsbmg").html(Jsbmg);
										
					var LinkMang = thisdata.getFieldAliasByFieldName('LinkMan');
					var Lshg = thisdata.getFieldAliasByFieldName('Lsh');
					var Lxdhg = thisdata.getFieldAliasByFieldName('Lxdh');
					var Mqbmg = thisdata.getFieldAliasByFieldName('Mqbm');
					var Nxmg = thisdata.getFieldAliasByFieldName('Nxm');
						
					$("#LinkMang").html(LinkMang);
					$("#Lshg").html(Lshg);
					$("#Lxdhg").html(Lxdhg);
					$("#Mqbmg").html(Mqbmg);	
					$("#Nxmg").html(Nxmg);	
										
					var Pgrqg = thisdata.getFieldAliasByFieldName('Pgrq');
					var Pgrzg = thisdata.getFieldAliasByFieldName('Pgrz');
					var Sgnrg = thisdata.getFieldAliasByFieldName('Sgnr');
					var Sgrqg = thisdata.getFieldAliasByFieldName('Sgrq');
					var Sjjeg = thisdata.getFieldAliasByFieldName('Sjje');
						
					$("#Pgrqg").html(Pgrqg);
					$("#Pgrzg").html(Pgrzg);
					$("#Sgnrg").html(Sgnrg);
					$("#Sgrqg").html(Sgrqg);	
					$("#Sjjeg").html(Sjjeg);	
										
					var Slbmg = thisdata.getFieldAliasByFieldName('Slbm');
					var TypeIDg = thisdata.getFieldAliasByFieldName('TypeID');
					var Wgbmg = thisdata.getFieldAliasByFieldName('Wgbm');
					var Wgrqg = thisdata.getFieldAliasByFieldName('Wgrq');
					var Xdhg = thisdata.getFieldAliasByFieldName('Xdh');
						
					$("#Slbmg").html(Slbmg);
					$("#TypeIDg").html(TypeIDg);
					$("#Wgbmg").html(Wgbmg);
					$("#Wgrqg").html(Wgrqg);	
					$("#Xdhg").html(Xdhg);	
										
					var Xdzg = thisdata.getFieldAliasByFieldName('Xdz');
					var Xmg = thisdata.getFieldAliasByFieldName('Xm');
					var Ydhg = thisdata.getFieldAliasByFieldName('Ydh');
					var Ydzg = thisdata.getFieldAliasByFieldName('Ydz');
					var YHthg = thisdata.getFieldAliasByFieldName('YHth');
						
					$("#Xdzg").html(Xdzg);
					$("#Xmg").html(Xmg);
					$("#Ydhg").html(Ydhg);
					$("#Ydzg").html(Ydzg);	
					$("#YHthg").html(YHthg);	
											
					var Yhxzg = thisdata.getFieldAliasByFieldName('Yhxz');
					var Yjjeg = thisdata.getFieldAliasByFieldName('Yjje');
					var Yjkxg = thisdata.getFieldAliasByFieldName('Yjkx');
					var Ywareag = thisdata.getFieldAliasByFieldName('Ywarea');
					//数据库中没有概述
						
					$("#Yhxzg").html(Yhxzg);
					$("#Yjjeg").html(Yjjeg);
					$("#Yjkxg").html(Yjkxg);
					$("#Ywareag").html(Ywareag);	
			}
			
						
			/*********
			* 执行复合查询出提交过来的相应操作
			* @param;
			* @return;
		    **********/
			function fuheExe()
			{
					fuheQuery();					
			}
			
			/*********
			* 复合查询操作
			* @param;
			* @return;
		    **********/
			function fuheQuery()
			{
					var params = fuheQbuildParams();			
					if(params=='&fusearchsql='){
						params +='1=1';
					}	
					//判断权限 RightGroup权限组 
					var keyEnd = "";
					if($("#RightGroup").val()=="3")
					{
						keyEnd = "Monitor";					
					}
					else if($("#RightGroup").val()=="10")
					{
						keyEnd = "Operator";						
					}else if($("#RightGroup").val()=="0"){
						keyEnd = "useridto";	
					}
				 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
				 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
												  clsname:'ExecuteSql',//类名
												  method:'exeSqlData',//方法名
												  ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												  tsdcf:'mssql',//指向配置文件名称
												  tsdoper:'query',//操作类型 
												  datatype:'xml',//返回数据格式 
												  tsdpk:'telReprint.fuheQueryByWhere'+keyEnd,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												  tsdpkpagesql:'telReprint.fuheQueryByWherepage'+keyEnd
												});
					//操作人id
					urlstr1 += "&skrid=";
					urlstr1 += $("#skrid").val();
					//操作人所在区域
					urlstr1 += "&area=";
					urlstr1 += tsd.encodeURIComponent($("#area").val());					
					var link = urlstr1 + params;
					//查询字段隐藏域
					//var column = $("#ziduansF").val();	
					var column = "ID,ID,Sgnr,Yjkx,Xdh,Sgrq,Hth,Area,Value18,Jlry,Xm,Ywarea,Dhlx,Lsh,IsPay";
				 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
				 	setTimeout($.unblockUI, 15);//关闭面板
			}
			
			/*********
			* 组合排序
			* @param:sqlstr拼接的SQL参数;
			* @return;
		    **********/
			function zhOrderExe(sqlstr){
					//排序参数获取
					var params = fuheQbuildParams();			
					if(params=='&fusearchsql='){
						params +='1=1';
					}
					params =params+'&orderby='+sqlstr;	
					
					//判断权限 RightGroup权限组 
					var keyEnd = "";
					if($("#RightGroup").val()=="3")
					{
						keyEnd = "Monitor";
					}
					else if($("#RightGroup").val()=="10")
					{
						keyEnd = "Operator";
					}else if($("#RightGroup").val()=="0"){
						keyEnd = "useridto";	
					}
							    
				 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
				 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
												  clsname:'ExecuteSql',//类名
												  method:'exeSqlData',//方法名
												  ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												  tsdcf:'mssql',//指向配置文件名称
												  tsdoper:'query',//操作类型 
												  datatype:'xml',//返回数据格式 
												  tsdpk:'telReprint.queryByOrder'+keyEnd,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												  tsdpkpagesql:'telReprint.queryByOrderpage'+keyEnd
												});
					//操作人id
					urlstr1 += "&skrid=";
					urlstr1 += $("#skrid").val();
					//操作人所在区域
					urlstr1 += "&area=";
					urlstr1 += tsd.encodeURIComponent($("#area").val());
					
					var link = urlstr1 + params;	
					//查询字段隐藏域				
					//var column = $("#ziduansF").val();	
					var column = "ID,ID,Sgnr,Yjkx,Xdh,Sgrq,Hth,Area,Value18,Jlry,Xm,Ywarea,Dhlx,Lsh,IsPay";				
				 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
				 	//jAlert("操作成功","操作提示");
					setTimeout($.unblockUI, 15);
			} 
			
			/********************************
			 **复合查询参数获取
			 **@oper 操作类型 fuhe 
			************************************/	
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
					
		/*********
		* 关闭表格面板
		* @param:sqlstr拼接的SQL参数;
		* @return;
		**********/
		function closeo(){
				clearText('operformT1');
				setTimeout($.unblockUI, 15);//关闭面板	
				return false;					
		}				
		</script>	
  	</head>
	<body >
		<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
		<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
		<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
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
									key="gjh.houtuei" /> </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
			<!-- 用户操作标题以及放一些快捷按钮 头部-->
			<div id="buttons">
				<!-- 组合排序 -->
				<button type="button" id="order1" onclick="openDiaO('vw_TelJob');">					
					<fmt:message key="order.title" />
				</button>				
				<!--高级查询-->
				<button type="button" id='gjquery1'
					onclick="openDiaQueryG('query','vw_TelJob');" >					
					<fmt:message key="oper.queryA" />
				</button>
			</div>

			<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
			
			<!-- 用户操作标题以及放一些快捷按钮  底部-->
			<div id="buttons">
				<!--组合排序-->
				<button type="button" id="order1" onclick="openDiaO('vw_TelJob');">					
					<fmt:message key="order.title" />
				</button>				
				<!--高级查询-->
				<button type="button" id='gjquery2'
					onclick="openDiaQueryG('query','vw_TelJob');" >					
					<fmt:message key="oper.queryA" />
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
							<fmt:message key="phone.getinternet0340" /><!-- 功能名称 -->
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
				<div style="max-height:315px;overflow-y: auto;overflow-x: hidden;">
				<form id='operformT1' name="operformT1" onsubmit="return false;"
					action="#">
					<input type="hidden"></input>
					<table width="99%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0" style="line-height: 33px; font-size: 12px;">

						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Areag"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Area" id="Area" class="textclass"></input>
								
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="BeginYwAreag"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="BeginYwArea" id="BeginYwArea" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Bm1g"></label>
							</td>
							<td width="20%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Bm1" id="Bm1" class="textclass" />
							</td>
						</tr>
						
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Bm2g"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Bm2" id="Bm2" class="textclass"></input>
								
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Bm3g"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Bm3" id="Bm3" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Bm4g"></label>
							</td>
							<td width="20%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Bm4" id="Bm4" class="textclass" />
							</td>
						</tr>
						
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Bzg"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Bz" id="Bz" class="textclass"></input>								
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="CardIDg"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="CardID" id="CardID" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Dhgng"></label>
							</td>
							<td width="20%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Dhgn" id="Dhgn" class="textclass" />
							</td>
						</tr>	

						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Dhlxg"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Dhlx" id="Dhlx" class="textclass"></input>								
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="dJhwcsjg"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="dJhwcsj" id="dJhwcsj" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Hthg"></label>
							</td>
							<td width="20%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Hth" id="Hth" class="textclass" />
							</td>
						</tr>	
						
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="IDDg"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="IDD" id="IDD" class="textclass"></input>								
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="IfCancelg"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="IfCancel" id="IfCancel" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="IsCompleteg"></label>
							</td>
							<td width="20%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="IsComplete" id="IsComplete" class="textclass" />
							</td>
						</tr>							
					
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="isJudgeg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="isJudge" id="isJudge" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="IsPayg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="IsPay" id="IsPay" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Jlryg"></label>
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Jlry" id="Jlry" class="textclass" />
							</td>
						</tr>		
						
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="JobStateg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="JobState" id="JobState" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="Jsbmg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Jsbm" id="Jsbm" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="LinkMang"></label>
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="LinkMan" id="LinkMan" class="textclass" />
							</td>
						</tr>
						
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Lshg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Lsh" id="Lsh" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="Lxdhg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Lxdh" id="Lxdh" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Mqbmg"></label>
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Mqbm" id="Mqbm" class="textclass" />
							</td>
						</tr>	
						
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Nxmg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Nxm" id="Nxm" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="Pgrqg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Pgrq" id="Pgrq" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Pgrzg"></label>
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Pgrz" id="Pgrz" class="textclass" />
							</td>
						</tr>		
						
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Sgnrg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Sgnr" id="Sgnr" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="Sgrqg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Sgrq" id="Sgrq" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Sjjeg"></label>
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Sjje" id="Sjje" class="textclass" />
							</td>
						</tr>
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Slbmg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Slbm" id="Slbm" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="TypeIDg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="TypeID" id="TypeID" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Wgbmg"></label>
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Wgbm" id="Wgbm" class="textclass" />
							</td>
						</tr>
						
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Wgrqg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Wgrq" id="Wgrq" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="Xdhg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Xdh" id="Xdh" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Xdzg"></label>
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Xdz" id="Xdz" class="textclass" />
							</td>
						</tr>
						
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Xmg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Xm" id="Xm" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="Ydhg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Ydh" id="Ydh" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Ydzg"></label>
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Ydz" id="Ydz" class="textclass" />
							</td>
						</tr>
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="YHthg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="YHth" id="YHth" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="Yhxzg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Yhxz" id="Yhxz" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Yjjeg"></label>
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Yjje" id="Yjje" class="textclass" />
							</td>
						</tr>
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Yjkxg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Yjkx" id="Yjkx" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="Ywareag"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Ywarea" id="Ywarea" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">							
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								
								<input type="hidden" id="ID"/>
							</td>
						</tr>				
					</table>
				</form>
				</div>
				<div class="midd_butt">					
					<!-- 关闭 	 -->
					<button class="tsdbutton" id="closeo"
						style="width: 63px; heigth: 27px;" onclick="closeo();">
						<fmt:message key="global.close" />
					</button>
				</div>
			</div>
		</div>


<!-- 添加修改面板 结束-->


<!-- 添加模板面板 开始-->		
<!-- 添加模板面板 开始-->

<!-- 导出数据 开始-->			
<!-- 导出数据 结束-->
<iframe id="printReportDirect"  style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>

<!-- 页面通用隐藏域 开始-->
		<div style="display: none">			
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
			
	
	<form name="childform" id="childform">
	  <input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
	  <input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
	</form>
  
	<input type="hidden" id="skrid" name="skrid" value='<%=request.getSession().getAttribute("userid") %>' />
  	<input type="hidden" id="area" name="area" value='<%=request.getSession().getAttribute("chargearea") %>' />
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>' />
	
	<!-- 权限组 -->
	<input type="hidden" id="RightGroup" name="RightGroup" />
	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
	<!-- 页面通用隐藏域 结束-->			
	<input type="hidden" name="printt" id="printt" />
	<jsp:include page="phone_internet.jsp" flush="true"/>
	
	</body>
</html>
