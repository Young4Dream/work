<%----------------------------------------
	name: phoneListQ.jsp
	author: youhongyu
	version: 1.0, 2010-10-12
	description: 查询明细话单
	modify: 
		2010-11-5 youhongyu 添加注释功能
		2010-12-15 liwen     样式修改
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
		<title>Call Detail details</title>
		
		
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
		
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		
		<!-- 日期插件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>		
		
		<!-- 验证数据长度 -->
		<script src="script/public/datalength.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script  src="script/public/infotest.js" type="text/javascript"></script>
		<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>
				
		<link rel="stylesheet" href="style/css/telephone/business/businesspublic.css" type="text/css"></link>
		<script type="text/javascript">	
			/**
			 * 页面初始化
			 * @param 
			 * @return 
			 */		
			jQuery(document).ready(function () {
				$("#navBar").append(genNavv());	//设置当前位置				
				getGD_Head();//初始化话单类型				
				getformInfom3();//初始化计费网名				
				getformInfom2();//初始化收费科目
				loadGrid1();//加载 查询jqgrid
				loadGrid2();//加载 汇总查询jqgrid
				readyMingxi();//加载 汇总查询明细jqgrid
				
				// 用户权限判定，初始化用户可操作权限 			
				getUserPower();
				//获取个操作权限
				var exportright = $("#exportright").val();
				var printright = $("#printright").val();
				
				var queryright = $("#queryright").val();
				var saveQueryMright = $("#saveQueryMright").val();
				
				//获取个操作按钮可用性
				if(exportright=="true"){
					document.getElementById("export1").disabled=false;
					document.getElementById("export2").disabled=false;
					document.getElementById("export3").disabled=false;
					document.getElementById("export4").disabled=false;
					document.getElementById("export5").disabled=false;
					document.getElementById("export6").disabled=false;
				}
				if(printright=="true"){
					document.getElementById("print1").disabled=false;
					document.getElementById("print2").disabled=false;
					document.getElementById("print3").disabled=false;
					document.getElementById("print4").disabled=false;
					document.getElementById("print5").disabled=false;
					document.getElementById("print6").disabled=false;
				}
				
				if(queryright=="true"){
					document.getElementById("gjquery1").disabled=false;
					document.getElementById("gjquery2").disabled=false;
					document.getElementById("gjquery3").disabled=false;
					document.getElementById("gjquery4").disabled=false;
					document.getElementById("gjquery5").disabled=false;
					document.getElementById("gjquery6").disabled=false;
				}
				getFieldLan();	//获取查看字段标签别名
				
			});
			
			/**--------------------------------复选框--------------------------------**/
		
			/**
			 * 将复选框选中的选项的值拼接成字符串
			 * @param  name 复选框的name值
			 * @param  key  复选框值与值之间的分隔符
			 * @return 字符串，复选框被选中选项的值，
			 */
			function getTheChecked(name,key){
					var thename=document.getElementsByName(name);  
				    var spanA =[];
				    var thevalue = '';
				    for(var i=0;i<thename.length;i++){
				    	if(thename[i].checked==true){
				    		thevalue += thename[i].value + key;
				    		spanA.push($(thename[i]).next("label").text());				    		
				    	}
				    }
				    var num = thevalue.lastIndexOf(key);
					thevalue = thevalue.substring(0,num);	
					
					//$('#thecheckedvalue').val(thevalue);
					if(thevalue.indexOf(key)==0){
						thevalue = thevalue.substring(1,thevalue.length);
					}	
					$("#spanA").val(spanA);  
				    return thevalue;
			}
			/**
			 * 打开多选框面板
			 * @param key key来判断打开的是那个面板；key=1 ：呼叫类型；key=2 ：收费科目； key=3:计费网名
			 * @return 
			 */
			function openTb(key){	
				//通过key来判断打开的是那个面板			
				switch(key){
					case 1:
						$("#thlx_a").show();
						$("#Kemu_a").hide();
						$("#Netname_a").hide();
						break;
					case 2:
						$("#thlx_a").hide();
						$("#Kemu_a").show();
						$("#Netname_a").hide();
						break;
					case 3:
						$("#thlx_a").hide();
						$("#Kemu_a").hide();
						$("#Netname_a").show();
						break;					
				}//end
				$("#xiala").show();
			}
			
			
			/**
			 * 呼叫类型、收费科目、计费网名弹出的复选框面板上的取消按钮操作
			 * @param key备用
			 * @return 
			 */
			function closeTb(key){
				$("#xiala").hide();
			};
			
			/**
			 * 呼叫类型、收费科目、计费网名弹出的复选框面板上确定按钮操作，
			 * @param key key来判断打开的是那个面板；key=1 ：呼叫类型；key=2 ：收费科目； key=3:计费网名
			 * @return 
			 */
			function submitTb(key){
				$("#xiala").hide();
				//通过key来判断打开的是那个面板		
				switch(key){
					case 1:
						$("#thlx").val($("#HzFields1").val());
						break;
					case 2:
						$("#Kemu").val($("#HzFields2").val());
						break;
					case 3:
						$("#Netname").val($("#HzFields3").val());
						break;					
				}//end
								 
			};
			
		
			/**
			 * 将选中的值赋给指定输入区 
			 * @param	id ：该复选框textarea的 id值
			 * @param	id2	 ：存放复选框的span的id值
			 * @param	id3	 : 存放textarea的span标签的id值
			 * @param	name :	该复选框的name值
			 * @param	oper :	各值之间的链接符 ~，+ ，,等
			 * @return 
			 */
			function getCheckValue(id,id2,id3,name,oper){
					$('#'+id).val('');
					$('#'+id).val(getTheChecked(name,oper));
					document.getElementById(id2).style.display = 'none';
					document.getElementById(id3).style.display = '';			
			}
			
			
			/**
			 *  opendsss
			 * @param 
			 * @return 
			 */		
			function opendsss(){
					$("#deptm3").attr('style','display:block');	
					$("#thedeptm3").attr('style','display:none');
					$("#deptm2").attr('style','display:block');	
					$("#thedeptm2").attr('style','display:none');
			}
			
			/**
			 * 计费网名输入框获取鼠标焦点触发的事件
			 	打开复选框面板
			 * @param	
			 * @return 
			 */
			function getTheDeptm3(){
					openTb(3);
					getDeptNamem3();
					$("#deptm3").attr('style','display:none');
					$("#thedeptm3").attr('style','display:block');
			}
			
			 /**
			 *  初始化计费网名复选框可选值
			 * @param 
			 * @return 
			 */
			function getformInfom3(){
					//$('#thedeptformm').remove();
					
					//将返回的结果集生成一个form出来
					var thevalue='<table width="500" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #dfe0e1; padding:5px; background:#f6f7f8; font-size:12px;margin:5px 0px; ">';
					thevalue +='<tr><td height="35" colspan="3">'+"<input type='button'  id='checkall' onclick=isCheckedAll('deptsm3',true); value='全选' style='width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;line-height:25px;  margin-left:10px;'><input type='button'  id='uncheckall' onclick=isCheckedAll('deptsm3',false); value='反选' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button'  onclick=\"getCheckValue('HzFields3','thedeptm3','deptm3','deptsm3',',');submitTb(3);\" value='确定' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button'  onclick=\"cancelTheOper('deptm3','thedeptm3');closeTb(3);\" value='取消' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'>"+'</td></tr>';
										
					var urlstr=buildParamsSqlByS('tsdCDR','query','xmlattr','CallType.getNetName','');
						
						$.ajax({
							url:'mainServlet.html?'+urlstr,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){									
									//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
							
									var i=0;
									$(xml).find('row').each(function(){
											//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
											///如果sql语句中指定列名 则按指定名称给参数
											var NetName =$(this).attr("NetName".toLowerCase());
											
											if(i%3==0){
												thevalue +='<tr ><td height="20" width="160px" color="#666666"> '+"<input type='checkbox' name='deptsm3' value='"+NetName+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+NetName+"</label>"+'</td>';
											}else if(i%3==1){
												thevalue +='<td color="#666666" width="160px"> '+"<input type='checkbox' name='deptsm3' value='"+NetName+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+NetName+"</label>"+'</td>';
											}									
											else if(i%3==2){
												thevalue +='<td color="#666666" width="160px"> '+"<input type='checkbox' name='deptsm3' value='"+NetName+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+NetName+"</label>"+'</td></tr>';
											}
											i++;
											//thevalue += "<div style='width:165px;float:left;'><input type='checkbox' name='deptsm' value='"+Field_Name+"' style='width:15px;height:15px;'><label style='text-align: left;line-height: 18px;width:100px'>"+Field_Alias+"</label></div>";
										
									});//将form填充到那个span中
							}
						});
					
					thevalue +='</table>';	
					$('#thedeptm3').html(thevalue);	
			}
			 /**
			 * 在对信息进行修改时,弹出计费网名复选框面板,将用户以前的值默认为选中状态，
			 * @param 
			 * @return 
			 */
			function getDeptNamem3(){					
					//这个是在对用户信息进行修改的时候将用户以前的值默认为选中状态		
					var thestavalue = $('#HzFields3').val();
					forChecked('deptsm3',thestavalue,',');			
			}
		</script>
		<script type="text/javascript">
			/**
			 * 呼叫类型输入框获取鼠标焦点触发的事件
			 	打开复选框面板
			 * @param	
			 * @return 
			 */
			function getTheDeptm1(){
					openTb(1);
					getDeptNamem1();
					$("#deptm1").attr('style','display:none');
					$("#thedeptm1").attr('style','display:block');
			}
			
			/**
			 *  初始化呼叫类型复选框可选值
			 * @param 
			 * @return 
			 */
			function getformInfom1(){
				//	$('#thedeptformm').remove();
					
					//获取话单类型
					var GDHead = $("#GDHead").val();
					if(GDHead==''){
						return ;
					}
					//将返回的结果集生成一个form出来
					var thevalue='<table width="500" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #dfe0e1; padding:5px; background:#f6f7f8; font-size:12px;margin:5px 0px; ">';
					thevalue +='<tr><td height="35" colspan="3">'+"<input type='button'  id='checkall' onclick=isCheckedAll('deptsm1',true); value='全选' style='width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;line-height:25px;  margin-left:10px;'><input type='button'  id='uncheckall' onclick=isCheckedAll('deptsm1',false); value='反选' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button'  onclick=\"getCheckValue('HzFields1','thedeptm1','deptm1','deptsm1',',');submitTb(1);\" value='确定' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button'  onclick=\"cancelTheOper('deptm1','thedeptm1');closeTb(1);\" value='取消' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'>"+'</td></tr>';
					
					var urlstr=buildParamsSqlByS('tsdCDR','query','xmlattr','phoneListQ.getCalltype','');
						
						$.ajax({
							url:'mainServlet.html?'+urlstr+"&GDHead="+tsd.encodeURIComponent(GDHead),
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){									
									//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
							
									var i=0;
									$(xml).find('row').each(function(){
											//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
											///如果sql语句中指定列名 则按指定名称给参数
											var call_type =$(this).attr("call_type");
											if(i%3==0){
												thevalue +='<tr ><td height="20" width="160px" color="#666666"> '+"<input type='checkbox' name='deptsm1' value='"+call_type+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+call_type+"</label>"+'</td>';
											}else if(i%3==1){
												thevalue +='<td color="#666666" width="160px"> '+"<input type='checkbox' name='deptsm1' value='"+call_type+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+call_type+"</label>"+'</td>';
											}									
											else if(i%3==2){
												thevalue +='<td color="#666666" width="160px"> '+"<input type='checkbox' name='deptsm1' value='"+call_type+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+call_type+"</label>"+'</td></tr>';
											}
											i++;
											//thevalue += "<div style='width:165px;float:left;'><input type='checkbox' name='deptsm' value='"+Field_Name+"' style='width:15px;height:15px;'><label style='text-align: left;line-height: 18px;width:100px'>"+Field_Alias+"</label></div>";
										
									});//将form填充到那个span中
							}
						});
					
					thevalue +='</table>';	
					$('#thedeptm1').html(thevalue);	
			}
			
			/**
			 * 在对信息进行修改时,弹出呼叫类型复选框面板,将用户以前的值默认为选中状态，
			 * @param 
			 * @return 
			 */
			function getDeptNamem1(){					
					//这个是在对用户信息进行修改的时候将用户以前的值默认为选中状态		
					var thestavalue = $('#HzFields1').val();
					forChecked('deptsm1',thestavalue,',');			
			}
		</script>
		<script type="text/javascript">
			/**
			 * 收费科目输入框获取鼠标焦点触发的事件
			 	打开复选框面板
			 * @param	
			 * @return 
			 */
			function getTheDeptm2(){
					openTb(2);
					getDeptNamem2();
					$("#deptm2").attr('style','display:none');
					$("#thedeptm2").attr('style','display:block');
			}
			/**
			 *  初始化收费科目复选框可选值
			 * @param 
			 * @return 
			 */
			function getformInfom2(){
								
					//将返回的结果集生成一个form出来
					var thevalue='<table width="500" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #dfe0e1; padding:5px; background:#f6f7f8; font-size:12px;margin:5px 0px; ">';
					thevalue +='<tr><td height="35" colspan="3">'+"<input type='button'  id='checkall' onclick=isCheckedAll('deptsm2',true); value='全选' style='width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;line-height:25px;  margin-left:10px;'><input type='button'  id='uncheckall' onclick=isCheckedAll('deptsm2',false); value='反选' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button'  onclick=\"getCheckValue('HzFields2','thedeptm2','deptm2','deptsm2',',');submitTb(2);\" value='确定' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button'  onclick=\"cancelTheOper('deptm2','thedeptm2');closeTb(2);\" value='取消' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'>"+'</td></tr>';											
					var languageType = $("#languageType").val();					
					var urlstr=buildParamsSql('query','xmlattr','ButieItem.getKemu','');
						
						$.ajax({
							url:'mainServlet.html?'+urlstr,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){									
									//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
							
									var i=0;
									$(xml).find('row').each(function(){
											//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
											///如果sql语句中指定列名 则按指定名称给参数
											var Kemu =$(this).attr("Kemu".toLowerCase());
											if(i%3==0){
												thevalue +='<tr ><td height="20" width="160px" color="#666666"> '+"<input type='checkbox' name='deptsm2' value='"+Kemu+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+Kemu+"</label>"+'</td>';
											}else if(i%3==1){
												thevalue +='<td color="#666666" width="160px"> '+"<input type='checkbox' name='deptsm2' value='"+Kemu+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+Kemu+"</label>"+'</td>';
											}									
											else if(i%3==2){
												thevalue +='<td color="#666666" width="160px"> '+"<input type='checkbox' name='deptsm2' value='"+Kemu+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+Kemu+"</label>"+'</td></tr>';
											}
											i++;
											
										
									});//将form填充到那个span中
							}
						});
					
					thevalue +='</table>';	
					$('#thedeptm2').html(thevalue);	
			}
			
			/**
			 * 在对信息进行修改时,弹出收费科目复选框面板,将用户以前的值默认为选中状态，
			 * @param 
			 * @return 
			 */
			function getDeptNamem2(){					
					//这个是在对用户信息进行修改的时候将用户以前的值默认为选中状态		
					var thestavalue = $('#HzFields2').val();
					forChecked('deptsm2',thestavalue,',');			
			}
		</script>
		<script type="text/javascript">
			
			/**
			 * 初始化话单类型前缀下拉列表框
			 * @param 
			 * @return 
			 */	
		 	function getGD_Head(){
					var urlstr=buildParamsSqlByS('tsdBilling','query','xmlattr','CallTypeNum.getGD_Head','');
					
					$.ajax({
						url:'mainServlet.html?'+urlstr,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
								$(xml).find('row').each(function(){
	                   				var area="<option value='"+$(this).attr("GDHead".toLowerCase())+"'>"+$(this).attr("GDHead".toLowerCase())+"  "+$(this).attr("HDType".toLowerCase())+"</option>";
									$("#GDHead").html($("#GDHead").html()+area);
								});
						}
					});
			}
		</script>
		<script type="text/javascript">
		
		/**
		* 查看当前用户的扩展权限，对spower字段进行解析
		* @param 
		* @return 
		*/
		function getUserPower(){
				 var urlstr=tsd.buildParams({ 	  packgname:'service',
							 					  clsname:'Procedure',
												  method:'exequery',
							 					  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
							 					  tsdpname:'phoneListQ.getPower',//存储过程的映射名称
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
						//editfields = getFields('JhjID');
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
			 * 给页面上标签做国际化
			 * @param 
			 * @return 
			 */
			function getFieldLan(){
				//获取数据表对应字段国际化信息					
					var thisdata = loadData('tmp_hdmx_uid','<%=languageType %>',1);	
					//Dh,Hssj,Thsc,Thlx,Bjhm,Jbhf,Tfhf,Bjdm,Hfhj,Fuf,Zjjx
					var Dhg = thisdata.getFieldAliasByFieldName('Dh');
					var Hssjg = thisdata.getFieldAliasByFieldName('Hssj');
					var Thscg = thisdata.getFieldAliasByFieldName('Thsc');
					var Thlxg = thisdata.getFieldAliasByFieldName('Thlx');
					
					var Bjhmg = thisdata.getFieldAliasByFieldName('Bjhm');
					var Jbhfg = thisdata.getFieldAliasByFieldName('Jbhf');
					var Tfhfg = thisdata.getFieldAliasByFieldName('Tfhf');
					var Bjdmg = thisdata.getFieldAliasByFieldName('Bjdm');
					
					var Hfhjg = thisdata.getFieldAliasByFieldName('Hfhj');
					var Fufg = thisdata.getFieldAliasByFieldName('Fuf');
					var Zjjxg = thisdata.getFieldAliasByFieldName('Zjjx');
					
					//给页面中存储字段的隐藏标签赋值			
					$("#Dhgx").html(Dhg);
					$("#Dhg_a").html(Dhg);
					$("#Hssjgx").html(Hssjg);
					$("#Thscgx").html(Thscg);
					$("#Thlxgx").html(Thlxg);
					
					$("#Bjhmgx").html(Bjhmg);
					$("#Jbhfgx").html(Jbhfg);
					$("#Tfhfgx").html(Tfhfg);
					$("#Bjdmgx").html(Bjdmg);	
					
					$("#Hfhjgx").html(Hfhjg);
					$("#Fufgx").html(Fufg);
					$("#Zjjxgx").html(Zjjxg);	
			}
			/**
			 * 添加、修改面板，通过表单值构造数据操作参数 请根据业务参数的多少和属性进行修改			 	
			 	@oper 操作类型 modify|save 	
			 * @param 
			 * @return 
			 */
			 function buildParams(key){
				 	//每次拼接参数必须初始化此参数
					tsd.QualifiedVal=true;				
				 	var params='';
					/*
					'Func=4;User=005;GDHead=HDMX;time1=2009-11-01 00:00:00;time2=2009-12-01 
					00:00:00;Dh=8921772;Bjhm=1;Hth=1;Zjjx=1;thlx= ''公网本地'' 
					;Kemu=''v'';Netname='''';Hf1=1;Hf2=2;Sc1=06:10:00;Sc2=06:20:00;Sd1=08:00:00;Sd2=09:00:0
					0;Zjx=2;'
							
							time1 time2 GDHead
					thlx Kemu  Netname 
					Dh Bjhm  Hth 
					Zjjx Hf1 Hf2
					Zjx  Sc1 Sc2
					Sd1 Sd2
					*/
					//通过关键字key判断进行的查询 是查询 查询汇总
					if(key==1){
						params +="&FUNC=4";
					}
					else if(key==2){
						params +="&FUNC=3";
					}
					var user = $("#useridd").val();
					//var user = '005';
				 	var time1 = $("#time1").val();
				 	var time2 = $("#time2").val();
				 	if(time1==''){				 		
				 		alert("请输入话单查询起始时间");
				 		$("#time1").focus();
				 		return false;
				 	}
				 	
				 	if(time2==''){
				 		alert("请输入话单查询截止时间");
				 		$("#time2").focus();
				 		return false;
				 	}
					//检测时间
	        		var timecheck=fetchSingleValue("phoneListQ.getstartendDay",6,"&starttime="+time1+"&endtime="+time2);
	        		timecheck = parseInt(timecheck);
	        		if(isNaN(timecheck) || timecheck<=0)
	        		{
	        			alert("终止月份必须大于起始月份");
	        			$("#time2").focus();
	        			return false;
	        		}
        		
        		
				 	var GDHead = $("#GDHead").val();
				 	var Hf1 = delTrim($("#Hf1").val());
				 	var Hf2 = delTrim($("#Hf2").val());
				 	params +="&USER="+user;
				 	
				 	params +="&GDHEAD="+tsd.encodeURIComponent(GDHead);
				 	params +="&TIME1="+time1;
				 	params +="&TIME2="+time2;
				 	params +="&HF1="+Hf1;
				 	params +="&HF2="+Hf2;
				 	
				 	var thlx = $("#thlx").val();
				 	if(thlx!=""){
				 		params +="&Thlx="+tsd.encodeURIComponent(thlx);
				 	}
				 	var Kemu = $("#Kemu").val();
				 	if(Kemu!=""){
				 		params +="&Kemu="+tsd.encodeURIComponent(Kemu);
				 	}
				 	var Netname = $("#Netname").val();
				 	if(Netname!=""){
				 		params +="&NetName="+tsd.encodeURIComponent(Netname);
				 	}
				 	
				 	var Dh = delTrim($("#Dh").val());
				 	if(Dh!=""){
				 		params +="&DH="+Dh;
				 	}
				 	var Bjhm = delTrim($("#Bjhm").val());
				 	if(Bjhm!=""){
				 		params +="&Bjhm="+tsd.encodeURIComponent(Bjhm);
				 	}
				 	var Hth = delTrim($("#Hth").val());
				 	if(Hth!=""){
				 		params +="&Hth="+Hth;
				 	}
				 	var Zjjx = delTrim($("#Zjjx").val());
				 	if(Zjjx!=""){
				 		params +="&Zjjx="+tsd.encodeURIComponent(Zjjx);
				 	}
				 	var Zjx = delTrim($("#Zjx").val());
				 	if(Zjx!=""){
				 		params +="&Zjx="+tsd.encodeURIComponent(Zjx);
				 	}
				 	
				 	//判断是否要按时长查询
				 	var items = $("#ScCheck[checked]");				 	
				 	if(items.length>0){
				 		var Sc1 = $("#Sc1").val();
				 		var Sc2 = $("#Sc2").val();					 		
				 		//检测时间
		        		var timecheck=fetchSingleValue("phoneListQ.getstartendSecond",6,"&starttime="+Sc1+"&endtime="+Sc2);
		        		timecheck = parseInt(timecheck);
		        		if(isNaN(timecheck) || timecheck<=0)
		        		{
		        			alert("时长终止时间必须大于起始时间");
		        			$("#Sc2").focus();
		        			return false;
		        		}
		        		
		        		params +="&SC1="+Sc1;
				 		params +="&SC2="+Sc2;
				 	}
					
				 	//判断是否要按时段查询
				 	var items = $("#SdCheck[checked]");				 	
				 	if(items.length>0){
				 		var Sd1 = $("#Sd1").val();
				 		var Sd2 = $("#Sd2").val();
				 		
				 		//检测时间
		        		var timecheck=fetchSingleValue("phoneListQ.getstartendSecond",6,"&starttime="+Sd1+"&endtime="+Sd2);
		        		timecheck = parseInt(timecheck);
		        		if(isNaN(timecheck) || timecheck<=0)
		        		{
		        			alert("时段终止时间必须大于时间月份");
		        			$("#Sd2").focus();
		        			return false;
		        		}
		        		
				 		params +="&SD1="+Sd1;
				 		params +="&SD1="+Sd2;
				 	}				 	
				 										
					//每次拼接参数必须添加此判断
					if(tsd.Qualified()==false){return false;}
					return params;
			 }
			 
			 /**
			 * 如果查询条件不为空，则把添加加到提交参数中
			 * @param  
			 * @return 
			 */	
			 function isemptyParams(key,str){
			 	var params ='';
			 	if(str!=""){
				 		params +=";"+key+"="+str;
				 }
				 return params;
			 }
		
			 /**
			 * 页面提交查询
			 * @param   key 标识 key=1：显示查询面板;key=2 ：显示查询明细并汇总面板
			 * @return 
			 */	
			function submitQuery(key){
				var params=buildParams(key);
				if(params==false){return false;}
				/////设置命令参数
				var urlstr=tsd.buildParams({ 	  packgname:'service',
							 					  clsname:'Procedure',
												  method:'exequery',
							 					  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
							 					  tsdpname:'phoneListQ.Query_Mxh',//存储过程的映射名称
							 					  tsdExeType:'query',
							 					  datatype:'xmlattr'
						 					});
																		
					
					$.ajax({
							url:'mainServlet.html?'+urlstr+params,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
							
								$(xml).find('row').each(function(){
									//获取存储过程返回值。
									var	Res ='';
									Res = $(this).attr("MxhdTable".toLowerCase());
									//alert(Res);
									
									$("#mxTable").val(Res);
									if(Res==''||Res==null){
										//失败提示
										alert(" 查询失败！");	
										return false;								
									}
									else{	
										//alert(Res);
										if(key==2){
											var HzhdTable = $(this).attr("HzhdTable".toLowerCase());
											$("#HzhdTable").val(HzhdTable);									
										}
										querylist(key);//刷新表									
										showC(key);
									}
									
								});
							}
					});					
			}
			
			/**
			 * 实现在“查询”和“查询明细并汇总”面板之间进行切换
			 * @param  key 标识 key=1：显示查询面板;key=2 ：显示查询明细并汇总面板
			 * @return 
			 */	
			function showC(key){
				if(key==1){
					$("#QCeng").show();
					$("#QHCeng").hide();
				}
				else if(key==2){
					$("#QHCeng").show();
					$("#QCeng").hide();
				}
			}
			
			/**
			 * 通用查询面板确定按钮操作 ，执行高级查询出提交过来的相应操作；
			 * @param 
			 * @return 
			 */ 
			function fuheExe()
			{
					fuheQuery();		
			}
			
			
			/**
			 * 重新加载jQgrid数据
			 * @param  key 标识 key=1：显示查询面板;key=2 ：显示查询明细并汇总面板
			 * @return 
			 */
			function querylist(key){
					//在调用此方法是清空符合查询的查询条件，避免导出或打印时显示信息有误
					$("#fusearchsql").val("");
					if(key==1){
						var urlstr=buildParamsSqlByS('tsdBilling','query','xml','phoneListQ.mxquery','phoneListQ.mxquerypage');
						var column = $("#ziduansF").val();
						var mxTable = $("#mxTable").val();
						$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&column='+column+'&tablename='+mxTable}).trigger("reloadGrid");
					}
					else if(key==2){
						var urlstr=buildParamsSqlByS('tsdBilling','query','xml','phoneListQ.hz.query','phoneListQ.hz.querypage');
						var column = $("#ziduansF2").val();
						var HzhdTable = $("#HzhdTable").val();
						$("#editgrid_b").setGridParam({url:'mainServlet.html?'+urlstr+'&column='+column+'&tablename='+HzhdTable}).trigger("reloadGrid");
					}					
			}
			
			/**
			 * 高级查询操作，通过高级查询面板生成查询条件，查询和刷新jqgrid面板中的信息
			 * @param 
			 * @return 
			 */
			function fuheQuery()
			{
					var params = fuheQbuildParams();			
					if(params=='&fusearchsql='){
						params +='1=1';
					}		
				 	var pageStatus = $("#pageStatus").val();
					if(pageStatus=='1'){
						var column = $("#ziduansF").val();	
						var mxTable = $("#mxTable").val();
					 	params+="&cloum="+column;
					 	params+="&tablename=hdmx_query";
					 	params+="&key=userid='"+$("#userid").val()+"' and "+$("#fusearchsql").val();
						var urlstr=buildParamsSqlByS('tsdBilling','query','xml','dbsql_phone.queryFYtabledate','dbsql_phone.querypageFYtabledate');
						var link = urlstr + params;	
					 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
				 	}
					else if(pageStatus=='2'){
						var column = $("#ziduansF2").val();	
						var HzhdTable = $("#HzhdTable").val();
					 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)				
						var urlstr=buildParamsSqlByS('tsdBilling','query','xml','phoneListQ.hz.fuheQueryByWhere','phoneListQ.hz.fuheQueryByWherepage');
						var link = urlstr + params;						
					 	$("#editgrid_b").setGridParam({url:'mainServlet.html?'+link+'&column='+column+'&tablename='+HzhdTable}).trigger("reloadGrid");
				 	
					}
					else if(pageStatus=='3'){
						var column = $("#ziduansF3").val();	
						var mxTable = $("#mxTable").val();
					 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)				
						var urlstr=buildParamsSqlByS('tsdBilling','query','xml','phoneListQ.hz.mxfuheQueryByWhere','phoneListQ.hz.mxfuheQueryByWherepage');
						var link = urlstr + params;			
					 	$("#editgrid_c").setGridParam({url:'mainServlet.html?'+link+'&column='+column+'&tablename='+mxTable}).trigger("reloadGrid");
				 	
					}
					setTimeout($.unblockUI, 15);		 	
			}
 			
 			/**
			 * 组合排序 
			 * @param sqlstr 进行组合排序的排序sql子语句
			 * @return 
			 */
			function zhOrderExe(sqlstr){
					//获取参数
					var params = fuheQbuildParams();			
					if(params=='&fusearchsql='){
						params +='1=1';
					}
					params =params+'&orderby='+sqlstr;
					
					
					var pageStatus = $("#pageStatus").val();
					//alert(pageStatus);
					if(pageStatus=='1'){
						var column = $("#ziduansF").val();	
						var mxTable = $("#mxTable").val();
					 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)				
						var urlstr=buildParamsSqlByS('tsdBilling','query','xml','phoneListQ.mxqueryByOrder','phoneListQ.mxqueryByOrderpage');
						var link = urlstr + params;						
					 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column+'&tablename='+mxTable}).trigger("reloadGrid");
				 	}
					else if(pageStatus=='2'){
						var column = $("#ziduansF2").val();	
						var HzhdTable = $("#HzhdTable").val();
					 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)				
						var urlstr=buildParamsSqlByS('tsdBilling','query','xml','phoneListQ.hz.queryByOrder','phoneListQ.hz.queryByOrderpage');
						var link = urlstr + params;						
					 	$("#editgrid_b").setGridParam({url:'mainServlet.html?'+link+'&column='+column+'&tablename='+HzhdTable}).trigger("reloadGrid");
				 	
					}
					else if(pageStatus=='3'){
						var column = $("#ziduansF3").val();	
						var mxTable = $("#mxTable").val();
					 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)				
						var urlstr=buildParamsSqlByS('tsdBilling','query','xml','phoneListQ.hz.mxqueryByOrder','phoneListQ.hz.mxqueryByOrderpage');
						var link = urlstr + params;			
					 	$("#editgrid_c").setGridParam({url:'mainServlet.html?'+link+'&column='+column+'&tablename='+mxTable}).trigger("reloadGrid");
				 	
					}	
					//jAlert("操作成功","操作提示");
					setTimeout($.unblockUI, 15);				
					
			}  	
			
			/**
			 * 初始化加载查询情况下 话单明细信息到jqgrid表
			 * @param 
			 * @return 
			 */
			function loadGrid1(){
					
					//获取文档 URL中“?”后面的信息 **设置jqgrid标题
					var navv = document.location.search;
					//获取url中变量为imenuname的属性值
					var infoo = decodeURIComponent(parseUrl(navv,"imenuname",""));					
					//设置jqgrid的头部参数
					var col=[[],[]];
					col=getRb_Field('tmp_hdmx_uid','Dh','','60','ziduansF','Hssj');//得到jqGrid要显示的字段			
					jQuery("#editgrid").jqGrid({
						//url:'mainServlet.html?'+urlstr+'&column='+column+'&tablename='+mxTable,
						datatype: 'xml', 
						colNames:col[0], 
						colModel:col[1],
						       	rowNum:10, //默认分页行数
						       	rowList:[10,15,20], //可选分页行数
						       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						       	pager: jQuery('#pagered'), 
						       	//sortname: 'Dh', //默认排序字段
						       	viewrecords: true, 
						       	//hidegrid: false, 
						       	sortorder: 'asc',//默认排序方式 
						       	caption:infoo,				       	
						       	height:document.documentElement.clientHeight-340, //高
						        width:document.documentElement.clientWidth-50,
						       	loadComplete:function(){
						       						var count=fetchSingleValue("dbsql_phone.querytabledate",6,"&tablename=hdmx_query&cloum=count(*) as cont&key=userid='"+tsd.encodeURIComponent($("#userid").val())+"'");
													if(count=="0"){
														alert("没有该条件要查询的数据！");
													}				       						
													$("#editgrid").setSelection('0', true);
													$("#editgrid").focus();
													///自动适应 工作空间
													var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
													setAutoGridHeight("editgrid",reduceHeight);																			
													//executeAddBtn('editgrid',1);
													$("#sumJbhf").text("");//基本话费合计
									        		$("#sumTfhf").text("");//特服话费合计
									        		$("#sumHfhj").text("");//总计											
													var res = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&tablename=hdmx_query&cloum=sum(Jbhf) as sumjbhf,sum(Tfhf) as sumtfhf,sum(Hfhj) as sumhfhj&key=userid='"+$("#userid").val()+"'");
												 	if(res[0]==undefined || res[0][0]==undefined)
									        		{
									        			return false;
									        		}else{
									        			$("#sumJbhf").text(res[0][0]);//基本话费合计
									        			$("#sumTfhf").text(res[0][1]);//特服话费合计
									        			$("#sumHfhj").text(res[0][2]);//总计
									        			
									        		}		
									        		$("#querybuttonid").removeAttr("disabled");				
												}
						}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false}, //options 
							{height:260,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
							{height:260,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
							{reloadAfterSubmit:false}, // del options 
							{} // search options 
							); 
			}
			

			/**
			 * 页面初始化加载话单明细信息 到jqgrid表
			 * @param 
			 * @return 
			 */
			function loadGrid2(){														
					
					//设置jqgrid的头部参数
					var col=[[],[]];
					col=getRb_Field('tmp_huizong_uid','Dh','','60','ziduansF2','Hth');//得到jqGrid要显示的字段					
					
					jQuery("#editgrid_b").jqGrid({
						//url:'mainServlet.html?'+urlstr+'&column='+column+'&tablename='+mxTable,
						datatype: 'xml', 
						colNames:col[0], 
						colModel:col[1],
						       	rowNum:10, //默认分页行数
						       	rowList:[10,15,20], //可选分页行数
						       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						       	pager: jQuery('#pagered_b'), 
						       	sortname: 'Dh', //默认排序字段
						       	viewrecords: true, 
						       	//hidegrid: false, 
						       	sortorder: 'asc',//默认排序方式 
						       	caption:"话单汇总表",				       	
						       	height:260, //高
						       //	width:document.documentElement.clientWidth-27,
						       	loadComplete:function(){
										var Hth=$("#editgrid_b").getCell(1,"Hth");
										$("#meetid").val(Hth);										
										reLoadMingxi(Hth);
										
								},
								//选择grid种的一列触发方法，根据这列种的Call_Type的值来查询加载editgrid_son表
								onSelectRow: function(ids) {
									//ids是返回的rowid,然后根据它再返回meetid	  
									var Hth=$("#editgrid_b").getCell(ids,"Hth");									
									$("#meetid").val(Hth);
									reLoadMingxi(Hth);
								}
						}).navGrid('#pagered_b',{edit: false, add: false, add: false, del: false, search: false}, //options 
							{height:260,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
							{height:260,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
							{reloadAfterSubmit:false}, // del options 
							{} // search options 
							); 
			}
			//加载明细表
			function reLoadMingxi(Hth){
					if(Hth != null) {				
							var str =" 1=1 and Hth='"+Hth+"' ";
							$("#querysql_son").val(str);	
							
							var mxTable = $("#mxTable").val();
							var urlstr=buildParamsSqlByS('tsdBilling','query','xml','phoneListQ.hz.mxquery','phoneListQ.hz.mxquerypage');
							var column = $("#ziduansF3").val();
							
							$("#editgrid_c").setGridParam({url:'mainServlet.html?'+urlstr+'&column='+column+'&tablename='+mxTable+'&Hth='+Hth}).trigger("reloadGrid");
					}
			}
			
			
			/**
			 * 加载 汇总查询明细jqgrid
			 * @param 
			 * @return 
			 */
			function readyMingxi(){
						
				var col=[[],[]];
				col=getRb_Field('tmp_hdmx_uid','Dh',"",'97','ziduansF3','Hssj');//得到jqGrid要显示的字段			
						
				jQuery("#editgrid_c").jqGrid({
					/*执行存储过程---------------- 
					tsdpname：可以调用其他存储过程，
					注意：tsdpname不是真正对应存储过程名称 而是通过系统进行映射，查看映射名请参照 存储过程维护页
					ds：对应applicationContent.xml里配置的数据源 
					*/   
					//url:'mainServlet.html?'+urlstr_son+"&Call_Type="+params,//,
					height:250, //高
					datatype: 'xml', 
					colNames:col[0], 
					colModel:col[1], 
					       	rowNum:10, //默认分页行数
					       	rowList:[10,15,20], //可选分页行数
					       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
					       	pager: jQuery('#pagered_c'), 
					       	sortname: 'Dh', //默认排序字段
					       	viewrecords: true, 
					       	//hidegrid: false, 
					       	sortorder: 'asc',//默认排序方式 
					       	caption:'话单<fmt:message key="tariff.sublist"/>', 
					       // width:document.documentElement.clientWidth-127,
					       	loadComplete:function(){
					       					
							}
					}); 
			}	
						

			/**
			 * 对jqgrid面板查看明细按钮，可查看详细信息			 	
			 * @param key 查询该条记录的参数
			 * @return 
			 */
			function openRowInfo(key){
					markTable(1);//显示红色*号	
					//设置编辑框的标题
					$(".top_03").html("详细信息");//标题
				 	//将修改面板的输入框全部	置为不可用	
					isDisabledN('tmp_hdmx_uid','','x');
					clearText('operformT1');
					queryByID(key);
					openpan();
			}	
			/**
			 * 从数据库中查找出该记录的详细信息，显示在详细面板中
			 * @param key 查询该条记录的参数,Hssj值
			 * @return 
			 */
			function queryByID(key){  
			 		$("#Hssj").val(key);
			 		var mxTable = $("#mxTable").val();
					var urlstr=tsd.buildParams({  
										  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xmlattr',//返回数据格式 
										  tsdpk:'phoneListQ.mxqueryByKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										});	
					$.ajax({
						url:'mainServlet.html?'+urlstr+'&Hssj='+tsd.encodeURIComponent(key)+'&tablename='+mxTable,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值
							$(xml).find('row').each(function(){
							
								//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
								///如果sql语句中指定列名 则按指定名称给参数
								
								//Dh,Hssj,Thsc,Thlx,Bjhm,Jbhf,Tfhf,Bjdm,Hfhj,Fuf,Zjjx	
								$("#Dhx").val($(this).attr("Dh".toLowerCase()));
								$("#Hssjx").val($(this).attr("Hssj".toLowerCase()));
								$("#Thscx").val($(this).attr("Thsc".toLowerCase()));
								$("#Thlxx").val($(this).attr("Thlx".toLowerCase()));
								$("#Bjhmx").val($(this).attr("Bjhm".toLowerCase()));
								
								$("#Jbhfx").val($(this).attr("Jbhf".toLowerCase()));
								$("#Tfhfx").val($(this).attr("Tfhf".toLowerCase()));
								$("#Bjdmx").val($(this).attr("Bjdm".toLowerCase()));
								$("#Hfhjx").val($(this).attr("Hfhj".toLowerCase()));
								$("#Fufx").val($(this).attr("Fuf".toLowerCase()));								
								$("#Zjjxx").val($(this).attr("Zjjx".toLowerCase()));				
								
							});
						}
					});
			}
			
		
			
			/**
			 *导出数据面板的导出按钮操作，
			 * @param 
			 * @return 
			 */
			function exportDate(){
				var pageStatus = $("#pageStatus").val();				
				if(pageStatus==2){
					var mxTable = $("#HzhdTable").val();
					getTheCheckedFieldstwo('tsdBilling','mssql','tmp_huizong_uid',mxTable);
				}
				else{
					var mxTable = $("#mxTable").val();
					$("#fusearchsql").val("userid='"+$("#userid").val()+"'");
					getTheCheckedFields('tsdBilling','mssql','hdmx_query','hdmx_query');
				}				
			}
			
			/**********************************************************
				function name:    getTheCheckedFields(ds,tsdcf,table)
				function:		   获取选中的数据列
				parameters:        ds：数据源
								   tsdcf：数据源配置
								   table: 表名,要显示数据的表的名称
								   table2: 别名表中的table_name的值
								   flag：外加附带限制条件
				return:			   
				description:      
				********************************************************/
				function getTheCheckedFields(ds,tsdcf,table,table2,flagfield){
					var thename=document.getElementsByName('thefields');  				
					var thevalue = '';
					var theclos = '';
					var atable = table;
					if(table2!=undefined){
						atable = table2;
					}
					var arr = displayFields(atable);
					var limitarr = thename.length;
					//如果字段较多则只取前20个
					var limitflag = false;
					var disi = 0;
					for(var i = 0 ; i < limitarr;i++){
						if(thename[i].checked==true){
					    	disi++;
					    }
					}
					if(disi>20){
						limitarr = 20;
						limitflag = true;
					}					
					for(var i=0;i<limitarr;i++){
						if(thename[i].checked==true){
							theclos += arr[i] + ',';
						}
					}
					theclos = theclos.substring(0,theclos.lastIndexOf(','));	
					theclos=theclos.replace(',undefined','');	
					var dataflag = thisDataDownload(ds,tsdcf,theclos,table,flagfield,limitflag,atable);									
					//将面板关闭
					if(dataflag!=false){
						setTimeout($.unblockUI, 15);
					}
					
				}
				
			
						
			 /**
			 * 打开简单查询面板
			 * @param 
			 * @return 
			 */
			 function openQuery(){			
					$(".top_03").html('<fmt:message key="global.query" />');//标题
					autoBlockFormAndSetWH('queryT',60,5,'closeoT',"#ffffff",true,1000,'');//弹出查询面板
					clearText('queryform');
			 }
			 /**
			 * 关闭查询面板
			 * @param 
			 * @return 
			 */
			function closeoQuery(){			
					setTimeout($.unblockUI, 15);//关闭面板
			}
		 
		
			/**
			 * 根据简单查询输入条件进行简单查询
			 * @param  
			 * @return 
			 */	
			function QbuildParams(){
					 	var Dh = delTrim($("#Dh_a").val());	 	
					 				 	
					 	var paramsStr='1=1 ';
					 	if(Dh!=''){
					 	 	paramsStr+="and Dh like '%"+Dh+"%' ";
					 	}
					 	$("#fusearchsql").val(paramsStr);
					 	fuheQuery();		
			}
			function setPS(key){
				$("#pageStatus").val(key);
			}
		</script>
		<script type="text/javascript">
		
			/**
			 * 关闭表格面板
			 * @param  
			 * @return 
			 */	
			function closeo(){				
					clearText('operformT1');
					setTimeout($.unblockUI, 15);//关闭面板						
			}
			
			
			/**
			 * 打开表格面板
			 * @param  
			 * @return 
			 */	
			function openpan(){				
					autoBlockFormAndSetWH('pan',60,5,'closeo',"#ffffff",true,1000,'');//弹出查询面板	
			}
		</script>
		<script type="text/javascript">		
			 /**
			 * 高级查询、批量修改、批量删除打开查询窗口
			 	通过tabStatus，来判断是在哪个选项卡进行的操作
			 * @param str str打开窗口方法，query modify delete存放在隐藏域queryName
			 * @return 
			 */		
			function openBQ(type,tablename){
					$("#queryStr").val("1");
					openDiaQueryG(type,tablename);					
			}			
		</script>	
		<script type="text/javascript">
			jQuery(document).ready(function()
			{
				setMaxMonth();
				getformInfom1();				
				$("#checkedall").click(function(){
          			$("[name='deptsm1']").attr("checked",'true');//全选  
	       		});
	       		$("#checkedrem").click(function(){
          			$("[name='deptsm1']").removeAttr("checked");//反选  
	       		});
	       		
	       		var stoptime=fetchSingleValue("dbsql_phone.querytabledate",6,"&tablename=dual&key=1=1&cloum=add_months(trunc(to_date('"+$("#zhangQi1 option:selected").text()+"','YYYY-MM'),'mm'),1)-trunc(to_date('"+$("#zhangQi1 option:selected").text()+"','YYYY-MM'),'mm')");
	       		$("#time2").val(stoptime+" 23:59:59");	       			       		
			});
			
			function zqchange(){
				var stoptime=fetchSingleValue("dbsql_phone.querytabledate",6,"&tablename=dual&key=1=1&cloum=add_months(trunc(to_date('"+$("#zhangQi1 option:selected").text()+"','YYYY-MM'),'mm'),1)-trunc(to_date('"+$("#zhangQi1 option:selected").text()+"','YYYY-MM'),'mm')");
	       		$("#time2").val(stoptime+" 23:59:59");	
			}
			
			function setMaxMonth(){
  				zuiDa();
  			 	var nowtime=$("#nowtime").val();//系统时间
  			 	var maxmonth=$("#maxcount").val();//  			 	
  			    var res=fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&tablename=dual&key=1=1&cloum=to_char(sysdate,'YYYYMM'),(select tvalues from tsd_ini where tsection='querybill' and tident='maxmonth')");
				var resstr="";	
				var monthstr = res[0][0].substr(4,2);
				var yearstr = res[0][0].substr(0,4);
				var str = yearstr+monthstr;
				resstr="<option value='"+str+"'>"+str+"</option>";	
				for(var i=1;i<res[0][1];i++){
					monthstr = parseInt(monthstr,10)-1;
					if(monthstr==0){
						yearstr=yearstr-1;
						monthstr="12"
					}
					if(parseInt(monthstr,10)<10){
						monthstr="0"+monthstr.toString();
					}
					var nums=yearstr.toString()+monthstr.toString();
					resstr+="<option value='"+nums+"'>"+nums+"</option>";													
				}		
				$("#zhangQi1").html(resstr);
  			}

  			///最大查询月数
          	function zuiDa(){           			
				var urlstr=buildParamsSqlByS('tsdBilling','query','xmlattr','phoneListQ.queryconfig','');
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
								$(xml).find('row').each(function(){
								$("#maxcount").val($(this).attr("tvalues"));
							});
					}
				});	
					
  			 }
  			 
  			 /**
			 *  初始化呼叫类型复选框可选值
			 * @param 
			 * @return 
			 */
			function getformInfom1(){				
					var urlstr=buildParamsSqlByS('tsdCDR','query','xmlattr','phoneListQ.getCalltype','');
					var thevalue="";
						$.ajax({
							url:'mainServlet.html?'+urlstr,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){									
									//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
									var i=0;
									$(xml).find('row').each(function(){
											//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
											///如果sql语句中指定列名 则按指定名称给参数
											var call_type =$(this).attr("call_type");	
											var feename =$(this).attr("feename"); 										
											if(i%3==0){
												thevalue +="<input type='checkbox' name='deptsm1' checked value='"+call_type+"' style='width:15px;height:15px;border:0px;'/><label style='text-align: left;'>"+call_type+"</label>&nbsp;&nbsp;";
											}else if(i%3==1){
												thevalue +="<input type='checkbox' name='deptsm1' checked value='"+call_type+"' style='width:15px;height:15px;border:0px;'/><label style='text-align: left;'>"+call_type+"</label>&nbsp;&nbsp;";
											}									
											else if(i%3==2){
												thevalue +="<input type='checkbox' name='deptsm1' checked value='"+call_type+"' style='width:15px;height:15px;border:0px;'/><label style='text-align: left;'>"+call_type+"</label>&nbsp;&nbsp;";
											}
											i++;
									});//将form填充到那个span中
							}
						});
					$('#thedeptm1').html(thevalue);	
			}
			
			
			function getPriParams(){
				var params='';
				params+="&userid="+encodeURIComponent($("#userid").val());
				params+="&Zhmc="+encodeURIComponent($("#hthyhmc").val());
				params+="&Yhmc="+encodeURIComponent($("#yhdangyhmc").val());
				if(tsd.Qualified()==false){return false;}	
				return params;	
			}

			function getPriParams_query(){
				var params='';
				$("#hthyhmc").val("");
        		$("#yhdangyhmc").val("");
			 	//如果有可能值是汉字 请使用encodeURI()函数转码
			 	params+='&fusearchsql=';
			 	if(params=='&fusearchsql='){
					params +='1=1';
				}
					
				var user = $("#userid").val();
				var zhangQi1 = $("#zhangQi1").val();
				if(zhangQi1==''){
					alert("请输入话单查询帐期");
					$("#zhangQi1").focus();
			 		return false;
				}
				
				params +="&billmonth="+zhangQi1;
			 	var time1 = $("#time1").val();
			 	var time2 = $("#time2").val();
			 	if(time1==''){
			 		alert("请输入话单查询起始时间");
			 		$("#time1").focus();
			 		return false;
			 	}
			 	
			 	if(time2==''){
			 		alert("请输入话单查询截止时间");
			 		$("#time2").focus();
			 		return false;
			 	}
			 	time1=zhangQi1+time1;
			 	time2=zhangQi1+time2;
				 	
				//检测时间
        		var timecheck=fetchSingleValue("phoneListQ.getstartendDay",6,"&starttime="+time1+"&endtime="+time2);
        		timecheck = parseInt(timecheck);
        		if(isNaN(timecheck) || timecheck<=0)
        		{
        			alert("终止月份必须大于起始月份");
        			$("#time2").focus();
        			return false;
        		}
        	
			 	params +="&userid="+user;
			 	params +="&bdate="+time1;
			 	params +="&edate="+time2;
			 	var thlx = $("#HzFields1").val();
			 	var str=document.getElementsByName("deptsm1");
		        var objarray=str.length;
		        var chestr="";
		        var chestrto="";
		        for (i=0;i<objarray;i++)
		        {
		            if(str[i].checked == true)
		            {              
		             chestr=str[i].value;               
				     chestrto += chestr+",";
					 var a =chestrto.substr(0,chestrto.length-1);
				     }
		         }
		         
			 	if(thlx!=""){
			 		params +="&thlx="+tsd.encodeURIComponent(a);
			 	}
			 	if(Dh==''){				 		
			 		alert("请输入话单查询起始时间");
			 		$("#time1").focus();
			 		return false;
			 	}
			
			 	//查询方式：电话或合同号		
			 	/*	 
			 	var querytype = $("#htdh").val();
			 	if(Dh!=""){
			 		if(querytype =="dhh"){
						params +="&dh="+Dh;
			 		}else{
			 			params +="&hth="+Dh;
			 		}		 	
			 	}else{
			 		alert("请输入话单查询"+htdh+"码");
			 		$("#Dh").focus();
			 		return false;
			 	}*/
			 	var Dhhm=$("#Dhhm").val();
				var Hthm=$("#Hthm").val();
				
			 	var Dh="";
			 	if(Dhhm == ""){
			 		Dh=Hthm;
			 	}else{
			 		Dh=Dhhm;
			 	}
			 	
			 	var par="";
			 	  if(Dhhm == "" && Hthm == ""){
			 		par="&tablename=yhdang y,hthdang h&cloum=h.hth,h.yhmc,y.yhmc&key=y.hth=h.hth";
			 	}else{
			 	    par="&tablename=yhdang y,hthdang h&cloum=h.hth,h.yhmc,y.yhmc&key=y.hth=h.hth and y.dh='"+Dh+"'";
			 	}
				
			 	if(Dhhm != "" && Hthm != ""){
			 		alert("请选择一种想要的查询类型!!!");
			 		return false;
			 	}
			 	
			 	var Bjhm = delTrim($("#Bjhm").val());
			 	if(Bjhm!=""){
			 		params +="&bjhm="+tsd.encodeURIComponent(Bjhm);
			 	}
			 	params +="&dh="+Dhhm;
			 	params +="&Hth="+Hthm;
			 	//yhy 打印功能处理
			 	//查询数据将dh基本信息存入隐藏于中等待打印是传入值
			 	var res = fetchMultiArrayValue("dbsql_phone.querytabledate",6,par);
			 	if(res[0]==undefined || res[0][0]==undefined)
        		{  
					
        		}else{
        			 $("#hthyhmc").val(res[0][1]);
        			$("#yhdangyhmc").val(res[0][2]); 
        		}
				/*
        		//2012-9-25 yhy start
        		//查看电话号码可打印详单报表
        		if(querytype =="dhh"){        			
        			$("#print1").removeAttr("disabled");
        			$("#print2").removeAttr("disabled");
        		}else{
        			//根据合同号查询详单，不能打印相当报表
        			$("#print1").attr("disabled","disabled");
        			$("#print2").attr("disabled","disabled");
        		}
        		*/
        		
				//每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}	
				//合同号查询 调用存储过程p_rpthth_querybill ；电话查询调用存储过程p_rpt_querybill
				var result ;
				/*
				if(querytype =="dhh"){
					result = fetchMultiPValue("phoneListQ.p_rpt_querybill",6,params);
			 	}else{
			 		result = fetchMultiPValue("phoneListQ.p_rpthth_querybill",6,params);
			 	}
				*/
			 	//2012-9-25 yhy end	
			 	result = fetchMultiPValue("phoneListQ.p_rpt_querybill",6,params);
			 	var count = checkHdmxQuery();
				if(count>0){
					$("#resortId").removeAttr("disabled");
				}else{
					$("#resortId").attr("disabled","disabled");
				}
			 	
				if(result[0][0]=='FAILED'){
					$("#gridd").empty();
					alert(result[0][1]);
				}else{
					$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
					$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
					var urlstr=tsd.buildParams({
								packgname:'service',//java包
								clsname:'ExecuteSql',//类名
								method:'exeSqlData',//方法名
								ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
								tsdcf:'mssql',//指向配置文件名称
								tsdoper:'query',//操作类型 
								datatype:'xml',//返回数据格式 
								tsdpk:'phonelistq.queryhdmxquery',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								tsdpkpagesql:'phonelistq.queryhdmxquerypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
					});
					//$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+"&cloum=Hth,Dh,Bjhm,Hssj,Thsc,Thlx,Jbhf,Tfhf,Hfhj&userid='"+$("#userid").val()+"'&tablename=hdmx_query",}).trigger("reloadGrid");
					
					$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+"&userid="+$("#userid").val()}).trigger("reloadGrid");
					$("#querybuttonid").attr("disabled","disabled");		
				}
			}
	
	function checkHdmxQuery(){
		var count = '';
		var urlstr=tsd.buildParams({
					packgname:'service',//java包
					clsname:'ExecuteSql',//类名
					method:'exeSqlData',//方法名
					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
					tsdcf:'mssql',//指向配置文件名称
					tsdoper:'query',//操作类型 
					datatype:'xmlattr',//返回数据格式 
					tsdpk:'phoneListQ.checkHdmxQuery'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
			});
		$.ajax({
				url:'mainServlet.html?'+urlstr,
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
					$(xml).find('row').each(function(){						
						count=$(this).attr("count");
					});
				}
		}); 
		return count;
	}
	
	
	function resortBill(){
		if(confirm("确定要对当前记录进行重新分拣吗？")){
			var urlstr=tsd.buildParams({ 
 							packgname:'service',//java包
					 		clsname:'ExecuteSql',//类名
					 		method:'exeSqlData',//方法名
					 		ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
					 		tsdcf:'mssql',//指向配置文件名称
					 		tsdoper:'exe',//操作类型 
					 		tsdpk:'phoneListQ.insertResortTemp'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
			 });
			 $.ajax({
			 	url:'mainServlet.html?'+urlstr,
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(msg){
					if(msg=="true"){
						alert("命令执行成功！");
					}	
				}
			});
		}
	}
	</script>
	<style type="text/css">		
		#navBar1 {
			height: 26px;
			background: url(style/images/public/daohangbg.jpg);
			line-height: 28px;
		}
		cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
		#listQtb {
			margin-top: 10px;
		}
		#listQtb tr td input{
			 width: 140px;
			 height: 20px;
			 margin-bottom: 3px;
		}
</style> 	
</head>	 
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
		<!-- 话单明细查询开始 -->		
				
		<div>
		<fieldset style="margin-left:20px;margin-right:20px;">
		<legend>
			<img src="style/icon/65.gif" />
			<fmt:message key="BillingBG.query" />
		</legend>
		<table>
  			<tr style="line-height: 30px;">
  				<td width="9%" align="right" >
					<label id="time1g">帐期</label>
				</td>
				<td  align="left" >
					<select id="zhangQi1"  style="width: 150px;" onchange="zqchange()"></select><font style="color:red;">*</font>
				</td>
				<td width="10%" align="right" >
					<label id="time1g">通话时间</label>
				</td>
				<td  align="left" >
					<input type="text" name="time1"    id="time1" style="width: 150px;" value="01 00:00:00"
									onfocus="WdatePicker({startDate:'01 00:00:00',dateFmt:'dd HH:mm:ss',alwaysUseStartDate:false})" ></input><font style="color:red;">*</font>								
				</td>
				<td  align="center" >
					<label id="time2g">至</label>
				</td>
				<td  align="left" >
					<input type="text" name="time2" id="time2" style="width: 150px;"
								onfocus="WdatePicker({startDate:'01 00:00:00',dateFmt:'dd HH:mm:ss',alwaysUseStartDate:false})" ></input><font style="color:red;">*</font>								
				</td>
  			</tr>
  			<tr style="line-height: 30px;">
  				<td width="9%" align="right" >
					<label id="DHHM">电话号码</label>	
				</td>
				<td  align="left" >
					<input type="text" id="Dhhm" style="width: 150px;"/>
				</td>
				<td width="10%" align="right" >
					<label id="HTHM">合同号码</label>
				</td>
				<td  align="left" >
					<input type="text" id="Hthm" style="width: 150px;"/>								
				</td>
				<td  align="right" >
					<label id="Bjhmg">被叫号码</label>
				</td>
				<td  align="left" >
					<input type="text" style="width: 150px;" name="Bjhm" id="Bjhm" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=48&&k<=57" maxlength="8" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false"></input>								
				</td>
  			</tr>
  			<tr style="padding-top: 10px;">
  				<td width="9%" align="right" >
					呼叫类型
				</td>
				<td  align="left" colspan="5" >
					<div id="thedeptm1" style="width:100%; height: 50px;background-color: #F8F8FF;overflow-y: scroll; overflow-x: hidden; border-top: 1px solid gray; border-left: 1px solid gray;"></div>
					<button type="button"  id="checkedall" class="tsdbutton">					
						全选
					</button>
					<button type="button" class="tsdbutton" id="checkedrem">					
						反选
					</button>	
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" class="tsdbutton" onclick="getPriParams_query();" id="querybuttonid" style="width:70px;">					
						<fmt:message key="global.query"/>
					</button>
				</td>
  			</tr>
  		</table>
		  		
		</fieldset>
					
		</div>
		<!-- 话单明细查结束 -->
		<div id='QCeng' >
			<!-- 用户操作标题以及放一些快捷setPS(1);按钮 头部-->
			<div id="buttons">
				<!-- 组合排序 -->
				<button type="button" id="order1" onclick="setPS(1);openDiaO('tmp_hdmx_uid');">					
					<fmt:message key="order.title" />
				</button>
				<!--高级查询-->
				<button type="button" id='gjquery1'
					onclick="setPS(1);openBQ('query','hdmx_query');" disabled="disabled">					
					<fmt:message key="oper.queryA" />
				</button>				
				<!--导出-->
				<button type="button" id="export1"
					onclick="setPS(1);thisDownLoad('tsdBilling','mssql','tmp_hdmx_uid','<%=languageType%>')"
					disabled="disabled">					
					<fmt:message key="global.exportdata" />
				</button>
				<!--打印-->
				<button type="button" id="print1" onclick="setPS(1);printThisReport1('<%=request.getParameter("imenuid")%>','tmp_hdmx_uid',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>','1')"	disabled="disabled">					
					<fmt:message key="tariff.printer" />
				</button>
				<button type="button" id="resortId" onclick="resortBill()" disabled="disabled" style="display: none;">					
					重新分拣
				</button>
			</div>
			<div id="gridd">
			<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
			</div>
			<table cellspacing="3">
				<tr>
					<td>基本话费合计<span id="sumJbhf" style="color:red;"></span>|</td>
					<td>特服话费合计<span id="sumTfhf" style="color:red;"></span>|</td>
					<td>总计<span id="sumHfhj" style="color:red;"></span></td>
				</tr>
			</table>
			
			<!-- 用户操作标题以及放一些快捷按钮  底部-->
			<div id="buttons" style="display: none;">
				<!--组合排序-->
				<button type="button" id="order2" onclick="setPS(1);openDiaO('tmp_hdmx_uid');">					
					<fmt:message key="order.title" />
				</button>				
				<!--高级查询-->
				<button type="button" id='gjquery2' 
					onclick="setPS(1);openBQ('query','hdmx_query');" disabled="disabled">					
					<fmt:message key="oper.queryA" />
				</button>				
				<!--导出-->
				<button type="button" id="export2"
					onclick="setPS(1);thisDownLoad('tsdBilling','mssql','tmp_hdmx_uid','<%=languageType%>')"
					disabled="disabled">					
					<fmt:message key="global.exportdata" />
				</button>
				<!--打印-->
				<button type="button" id="print2" onclick="setPS(1);printThisReport1('<%=request.getParameter("imenuid")%>','tmp_hdmx_uid',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>','1')"	disabled="disabled">					
					<fmt:message key="tariff.printer" />
				</button>
			</div>
		</div>
		
		<!--汇总查询 -->
		<div id='QHCeng' style="display: none;">
			<!-- 用户操作标题以及放一些快捷按钮-->		
		<div id="buttons">
			<button type="button" id="order3" onclick="setPS(2);openDiaO('tmp_huizong_uid');">
				<!--组合排序--><fmt:message key="order.title" />
			</button>			
			<button type="button" id='gjquery3' onclick="setPS(2);openBQ('query','hdmx_query');"  disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>			
			<button type="button" id="export3" onclick="setPS(2);thisDownLoad('tsdBilling','mssql','tmp_huizong_uid','<%=languageType %>');" 
			disabled="disabled"> <!--  disabled="disabled" -->
				<!--导出--><fmt:message key="global.exportdata" />
			</button>					
			<button type="button" id="print3"  onclick="setPS(2);printThisReport('phonemesQ/phoneListQ',getPriParams())"  disabled="disabled">
				<!--打印--><fmt:message key="tariff.printer" />
			</button>
		</div>	
    <table id="editgrid_b" class="scroll" cellpadding="0" cellspacing="0"></table>
	<div id="pagered_b" class="scroll" style="text-align: left;"></div>
	<!-- 用户操作标题以及放一些快捷按钮-->		
		<div id="buttons">
			<button type="button" id="order4" onclick="setPS(2);openDiaO('tmp_huizong_uid');">
				<!--组合排序--><fmt:message key="order.title" />
			</button>
			
			<button type="button" id='gjquery4' onclick="setPS(2);openBQ('query','tmp_huizong_uid');" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			
			<button type="button" id="export4" onclick="setPS(2);thisDownLoad('tsdBilling','mssql','tmp_huizong_uid','<%=languageType %>');"  
			disabled="disabled"> <!--  disabled="disabled" -->
				<!--导出--><fmt:message key="global.exportdata"/>
			</button>					
			<button type="button" id="print4"  onclick="setPS(2);printThisReport('phonemesQ/phoneListQ',getPriParams())" disabled="disabled">
				<!--打印--><fmt:message key="tariff.printer" />
			</button>
		</div>	
	
	<!-- 用户操作标题以及放一些快捷按钮-->		
		<div id="buttons">
			<button type="button" id="order5" onclick="setPS(3);openDiaO('tmp_hdmx_uid');">
				<!--组合排序--><fmt:message key="order.title" />
			</button>			
			<button type="button" id='gjquery5' onclick="setPS(3);openBQ('query','tmp_hdmx_uid');" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>			
			<button type="button" id="export5" onclick="setPS(3);thisDownLoad('tsdBilling','mssql','tmp_hdmx_uid','<%=languageType %>');" 
			disabled="disabled"> 
				<!--导出--><fmt:message key="global.exportdata" />
			</button>					
			<button type="button" id="print5" onclick="setPS(3);printThisReport1('<%=request.getParameter("imenuid")%>','tmp_hdmx_uid',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>')"  disabled="disabled">
				<!--打印--><fmt:message key="tariff.printer" />
			</button>
	</div>	
	<table id="editgrid_c" class="scroll" cellpadding="0" cellspacing="0"></table>
	<div id="pagered_c" class="scroll" style="text-align: left;"></div>
	<!-- 用户操作标题以及放一些快捷按钮-->		
		<div id="buttons">
			<button type="button" id="order6" onclick="setPS(3);openDiaO('tmp_hdmx_uid');">
				<!--组合排序--><fmt:message key="order.title" />
			</button>			
			<button type="button" id='gjquery6' onclick="setPS(3);openBQ('query','tmp_hdmx_uid');" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>			
			<button type="button" id="export6"  onclick="setPS(3);thisDownLoad('tsdBilling','mssql','tmp_hdmx_uid','<%=languageType %>');" 
			disabled="disabled"> 
				<!--导出--><fmt:message key="global.exportdata" />
			</button>					
			<button type="button" id="print6"  onclick="setPS(3);printThisReport1('<%=request.getParameter("imenuid")%>','tmp_hdmx_uid',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');"  disabled="disabled">
				<!--打印--><fmt:message key="tariff.printer" />
			</button>
	  </div>
	</div>




<!-- 导出数据 开始-->
			<div class="neirong" id="thefieldsform"
				style="display: none; width: 800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
						<div class="top_01left">
							<div class="top_02">
								<img src="style/images/public/neibut01.gif" />
							</div>
							<div class="top_03" id="titlediv">
								选择您要导出的数据字段
							</div>
							<div class="top_04">
								<img src="style/images/public/neibut03.gif" />
							</div>
						</div>
						<div class="top_01right">
							<a href="#" onclick="javascript:$('#closethisinfo').click();">关闭</a>
						</div>
					</div>
					<div class="top02right">
						<img src="style/images/public/toptiaoright.gif" />
					</div>
				</div>
				<div class="midd">
					<form action="#" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<td>
									<div id="thelistform"
										style="margin-left: 10px; max-height: 200px">

									</div>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" id="query"
						onclick="checkedAllFields()">
						全选
					</button>
					<button type="submit" class="tsdbutton" id="query"
						onclick="exportDate();">
						<fmt:message key="global.ok" />
					</button>
					<button type="button" class="tsdbutton" id="closethisinfo">
						<fmt:message key="global.close" />
					</button>

				</div>
			</div>

			<input type="hidden" id="whickOper" />
<!-- 导出数据 结束-->


<!-- 页面通用隐藏域 开始-->
		<div style="display: none">
			<form name="childform" id="childform">
				<input type="text" id="queryName" name="queryName" value=""
					style="display: none" />
				<input type="text" id="fusearchsql" name="fusearchsql"
					style="display: none" />
				<!-- 存放主表的复合查询条件 -->
			  	<input type="text" id="querysql" name="querysql" style="display: none"/>
			   	<!-- 存放子表的复合查询条件 -->
			  	<input type="text" id="querysql_son" name="querysql_son" style="display: none"/>
				   
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
			<input type="hidden" id="userid" value="<%=userid%>" />

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
			<input type="hidden" id='ziduansF2' />
			<input type="hidden" id='ziduansF3' />
			<input type='hidden' id='thecolumn' />
			<input type="hidden" id="meetid"/>
			
			<!-- 存放当前查看话单临时表名 -->
			<input type="hidden" id="mxTable"/>
			<input type="hidden" id="HzhdTable"/>
			<input type="hidden" id="pageStatus"/>
			<input type="hidden" id="queryStr"/>
			<input type="hidden" id='maxcount' />
			<input type='hidden' id='nowtime' value='<%=new SimpleDateFormat("yyyy-MM").format(new Date())%>'/>
			<input type="hidden" id="yhdangyhmc"/>
			<input type="hidden" id="hthyhmc"/>
<!-- 页面通用隐藏域 结束-->			
	</body>
</html>