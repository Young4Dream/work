<%----------------------------------------
	name: subsidyPay.jsp
	author: youhongyu
	version: 1.0, 2010-10-11
	description: 定义补贴代缴类型
	modify: 
		2009-11-26 youhongyu 添加注释功能
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
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
%>
<%
	SimpleDateFormat format = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	Date now = new Date();
	String nowTime = format.format(now);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>The definition of subsidy payment of the type</title>
		
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
		<!-- 资费菜单样式 -->
		<link href="style/css/pubMode/tariff.css" rel="stylesheet" type="text/css" />
		<!-- 日期插件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>		
		
		<!-- 验证数据长度 -->
		<script src="script/public/datalength.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script  src="script/public/infotest.js" type="text/javascript"></script>
		<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>
		
		<!-- 分项卡 -->	
		<script src="plug-in/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>		
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen"/>
		
		
		<style type="text/css">
		<!--
		#multiple INPUT {
			text-align: left;
		}
		
		#multiple label {
			text-align: left;
		}
		
		#multiple {
			width: 100%;
			float: left;
			text-align: left;
			line-height: 18px;
		}
		-->
		</style>
		
<script type="text/javascript">

/**
* 查看当前用户的扩展权限，对spower字段进行解析
* @param 
* @return 
*/
function getUserPower(){
				 var urlstr=buildParamsPro('subsidyPay.getPower','query');
				 
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
				var exportright = '';
				var printright ='';
				var editBright = '';
				var deleteright = '';
				var editright = '';
				
				var queryright = '';				
				var queryMright = '';
				var saveQueryMright ='';
				
				var editfields = '';
				var editfields_son='';
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
							editfields_son += getCaption(spowerarr[i],'editfields2','');
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
						
						editfields = getFields('butieitem');
						editfields_son = getFields('free_grade');
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
				$("#editfields_son").val(editfields_son);
}

//用户存放页面字段
FeeFieldsA =[[],[]];

/**
 * 初始收费科目下拉列表看
 * @param 
 * @return 
 */
function getKemu(){
		var urlstr=buildParamsSql('query','xmlattr','ButieItem.getKemu','');
		
		$.ajax({
			url:'mainServlet.html?'+urlstr,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
					$(xml).find('row').each(function(){
                 				var area="<option value='"+$(this).attr("Kemu".toLowerCase())+"'>"+$(this).attr("Kemu".toLowerCase())+"</option>";
						$("#Kemu").html($("#Kemu").html()+area);
					 });
			}
		});
}
	
/**
 * 定义减免项目组选项卡，弹出面板中控制减免字段、减免结余清零月份组复选框选中值域的显示
 * @param 
 * @return 
 */		
function opendsss(){
	$("#dept").attr('style','display:block');	
	$("#thedept").attr('style','display:none');
	$("#deptm").attr('style','display:block');	
	$("#thedeptm").attr('style','display:none');
}
/**
 *  获取减免项目名称，显示减免字段可选值
 * @param 
 * @return 
 */
function getTheDept(){
	getDeptName();
	$("#dept").attr('style','display:none');
	$("#thedept").attr('style','display:block');
	//document.getElementById('dept').style.display = 'none';
	//document.getElementById('thedept').style.display = 'block';
}
/**
 *  初始化减免字段复选框可选值
 * @param 
 * @return 
 */
function getformInfo(){
	$('#thedeptform').remove();
	
		//将返回的结果集生成一个form出来
		var thevalue='<table width="500" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #dfe0e1; padding:5px; background:#f6f7f8; font-size:12px;margin:5px 0px; ">';
		thevalue +='<tr><td height="35" colspan="3">'+"<input type='button'  id='checkall' onclick=isCheckedAll('depts',true); value='全选' style='width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;line-height:25px;  margin-left:10px;'><input type='button'  id='uncheckall' onclick=isCheckedAll('depts',false); value='反选' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button'  onclick=getCheckValue('FeeFields','thedept','dept','depts','+') value='确定' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button' onclick=cancelTheOper('dept','thedept') value='取消' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'>"+'</td></tr>';
		//var thevalue = "<form name='thedeptform'><p><input type='button' id='checkall' onclick=isCheckedAll('depts',true); value='全选' style='width:45px;height:22px;text-align:center'><input type='button' id='uncheckall' onclick=isCheckedAll('depts',false); value='反选' style='width:45px;height:22px;text-align:center'><input type='button' onclick=getCheckValue('FeeFields','thedept','dept','depts','+') value='确定' style='width:45px;height:22px;text-align:center'><input type='button' onclick=cancelTheOper('dept','thedept') value='取消' style='width:45px;height:22px;text-align:center'></p>";
		 var i=0;		
		var languageType = $("#languageType").val();
		var urlstr=buildParamsSql('query','xmlattr','ButieItem.getFeeFields','');		
		
		$.ajax({
			url:'mainServlet.html?'+urlstr,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				//将返回的结果集生成一个form出来
				$(xml).find('row').each(function(){							
							var areaval = $(this).attr("Field_Name".toLowerCase());
							var area = $(this).attr("Field_Alias".toLowerCase());
							
							//字段国际化
							var arr = area.split("/}");
							if(arr.length==1){}
							else{
								area = getCaption(area,languageType,'');
							}									
                  				
							FeeFieldsA[0].push(areaval);
							FeeFieldsA[1].push(area);
								
							if(i%3==0){
								thevalue +='<tr ><td height="20" width="160px" color="#666666"> '+"<input type='checkbox' name='depts' value='"+areaval+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+area+"</label>"+'</td>';
							}else if(i%3==1){
								thevalue +='<td color="#666666" width="160px"> '+"<input type='checkbox' name='depts' value='"+areaval+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+area+"</label>"+'</td>';
							}									
							else if(i%3==2){
								thevalue +='<td color="#666666" width="160px"> '+"<input type='checkbox' name='depts' value='"+areaval+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+area+"</label>"+'</td></tr>';
							}
							i++;						
										
				});
			}
			
		});
		thevalue +='</table>';	
		$('#thedept').html(thevalue);	
}

/**
 *  在对用户信息进行修改的时候将用户以前的值默认为选中状态
 * @param 
 * @return 
 */
function getDeptName(){		
		//这个是在对用户信息进行修改的时候将用户以前的值默认为选中状态		
		var thestavalue = $('#FeeFields').val();
		forChecked('depts',thestavalue,'+');		
}	

 /**
 *  显示减免月份可选值
 * @param 
 * @return 
 */
function getTheDeptm(){
		getDeptNamem();
		$("#deptm").attr('style','display:none');
		$("#thedeptm").attr('style','display:block');
}
/**
 *  初始化减免结余清零月份组复选框可选值
 * @param 
 * @return 
 */
function getformInfom(){
	$('#thedeptformm').remove();
		
	//将返回的结果集生成一个form出来
	var thevalue='<table width="500" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #dfe0e1; padding:5px; background:#f6f7f8; font-size:12px;margin:5px 0px; ">';
	thevalue +='<tr><td height="35" colspan="6">'+"<input type='button'  id='checkall' onclick=isCheckedAll('deptsm',true); value='全选' style='width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;line-height:25px;  margin-left:10px;'><input type='button'  id='uncheckall' onclick=isCheckedAll('deptsm',false); value='反选' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button' onclick=getCheckValue('ZeroMonth','thedeptm','deptm','deptsm',',') value='确定' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button'  onclick=cancelTheOper('deptm','thedeptm') value='取消' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'>"+'</td></tr>';
	//var thevalue = "<form name='thedeptformm'><p><input type='button' id='checkall' onclick=isCheckedAll('deptsm',true); value='全选' style='width:45px;height:22px;text-align:center'><input type='button' id='uncheckall' onclick=isCheckedAll('deptsm',false); value='反选' style='width:45px;height:22px;text-align:center'><input type='button' onclick=getCheckValue('ZeroMonth','thedeptm','deptm','deptsm',',') value='确定' style='width:45px;height:22px;text-align:center'><input type='button' onclick=cancelTheOper('deptm','thedeptm') value='取消' style='width:45px;height:22px;text-align:center'></p>";
								for(var i=1;i<13;i++){	
								
									if(i%6==1){
										thevalue +='<tr ><td height="20" width="70px" color="#666666"> '+"<input type='checkbox' name='deptsm' value='"+i+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+i+"</label>"+'</td>';
									}									
									else if(i%6==0){
										thevalue +='<td color="#666666" width="70px"> '+"<input type='checkbox' name='deptsm' value='"+i+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+i+"</label>"+'</td></tr>';
									}
									else {
										thevalue +='<td color="#666666" width="70px"> '+"<input type='checkbox' name='deptsm' value='"+i+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+i+"</label>"+'</td>';
									}									
									//生成复选框
				 					//thevalue += "<div style='width:75px;float:left;'><input type='checkbox' name='deptsm' value='"+i+"' style='width:15px;height:15px;'><label style='text-align: left;line-height: 18px;width:12px'>"+i+"</label></div>";
								}
				//将form填充到那个span中
				//$('#thedeptm').html(thevalue+'</form>');		
				thevalue +='</table>';	
				$('#thedeptm').html(thevalue);		
}
/**
 *  在对用户信息进行修改的时候将用户以前的值默认为选中状态
 	减免月份
 * @param 
 * @return 
 */
function getDeptNamem(){
		var thestavalue = $('#ZeroMonth').val();
		forChecked('deptsm',thestavalue,',');
		
}	

/**
* 控制新增操作时在序号下拉选择框中显示信息，
	需要只能从1到20，被使用过的序号不允许在使用
* @param 
* @return 
*/
function getXuhao(){
			$("#Xuhao").empty();
			for(i=1;i<21;i++){							
					var area="<option value='"+i+"'>"+i+"</option>";								
					$("#Xuhao").html($("#Xuhao").html()+area);							
			}
			var urlstr=buildParamsSql('query','xmlattr','ButieItem.getXuhao','');
			$.ajax({
				url:'mainServlet.html?'+urlstr,
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
					$(xml).find('row').each(function(){
						var xuhao = $(this).attr("Xuhao".toLowerCase());
							$("#Xuhao option[value='"+xuhao+"']").remove();
					});
				}
			});
}

/**
* 控制查询面板、修改面板、显示详细面板序号下拉选择框中显示信息，	
* @param 
* @return 
*/
function getXuhaoQuery(){
		$("#Xuhao").empty();
		$("#Xuhao").html("<option value=''>--请选择--</option>");
		var urlstr=buildParamsSql('query','xmlattr','ButieItem.getXuhao','');
		$.ajax({
			url:'mainServlet.html?'+urlstr,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				$(xml).find('row').each(function(){
					var xuhao = $(this).attr("Xuhao".toLowerCase());
					var area="<option value='"+xuhao+"'>"+xuhao+"</option>";
					$("#Xuhao").html($("#Xuhao").html()+area);
				});
			}
		});
}


</script>
<script type="text/javascript">
//用于表识当前选项卡
var tabStatus=1;
//存放各选项卡对应表名
var tables = ["butieitem","free_grade"];
//存放各选项卡对sql语句的开始部分
var pkeys = ["ButieItem","FreeGrade"];
var firstLoad = [true,true];
//存放各选项卡对应jqgrid的标题
var mNames = ["<fmt:message key='subsidyPay.ButieItem' />","<fmt:message key='subsidyPay.FreeGrade' />"];

/**
* 页面初始化
* @param 
* @return 
*/
jQuery(document).ready(function () {
			/**********************
			**   取得当前用户的权限  *
			**********************/
			getUserPower();	
			var addright = $("#addright").val();
			var exportright = $("#exportright").val();
			var printright = $("#printright").val();
			
			var queryright = $("#queryright").val();			
			var saveQueryMright = $("#saveQueryMright").val();
			
			if(queryright=="true"){
				document.getElementById("gjquery1").disabled=false;
				document.getElementById("gjquery2").disabled=false;
			}		
			if(saveQueryMright=="true"){
				document.getElementById("savequery1").disabled=false;
				document.getElementById("savequery2").disabled=false;
			}
			
			if(addright=="true"){
				document.getElementById("openadd1").disabled=false;
				document.getElementById("openadd2").disabled=false;
			}
			if(exportright=="true"){
				document.getElementById("export1").disabled=false;
				document.getElementById("export2").disabled=false;
			}
		//导航栏	
		//getNavit();
		
		$("#navBar").append(genNavv());
		//第一个分项卡的初始化			
		getformInfo();
		getformInfom();
		getKemu();
		ready1();
		$("#tabs").tabs();
});
/**
 * 点击切换选项卡操作
 * @param id 当前被点击的选项卡表识，通过该表识打开相应选项卡
 * @return 
 */		
function tabsChg(id)
{
		$("#gridd").empty();
		$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
		$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
		$("#fusearchsql").val("");
		
		switch(id)
		{
			case 1:
				tabStatus=1;					
				ready1();
				break;
			case 2:
				tabStatus=2;			
				ready2();
				break;
		}		
}
			
/**
 * 第一个选项卡对应的jqgrid的数据加载，和其对应的弹出面板中标签的国际化 	
 * @param 
 * @return 
 */
function ready1(){
		//获取数据表对应字段国际化信息					
		var column  = '';
		var thisdata = loadData('butieitem','<%=languageType %>',1);
		column = thisdata.FieldName.join(',');			 					
		$('#thecolumn').val(column);
		var col=[[],[]];
		col=getRb_Field('butieitem','Xuhao',"修改|删除|详细",'97','ziduansF1');//得到jqGrid要显示的字段
		var column = $("#ziduansF1").val();
		
		var ButieNameg = thisdata.getFieldAliasByFieldName('ButieName');
		var FeeFieldsg = thisdata.getFieldAliasByFieldName('FeeFields');
		var Kemug = thisdata.getFieldAliasByFieldName('Kemu');
		var Xuhaog = thisdata.getFieldAliasByFieldName('Xuhao');
		var ZeroMonthg = thisdata.getFieldAliasByFieldName('ZeroMonth');
					
		//给页面中存储字段的隐藏标签赋值			
		$("#ButieNameg").html(ButieNameg);
		$("#FeeFieldsg").html(FeeFieldsg);
		$("#Kemug").html(Kemug);
		$("#Xuhaog").html(Xuhaog);
		$("#ZeroMonthg").html(ZeroMonthg);
		
		
		//设置命令参数
		var urlstr=buildParamsSql('query','xml','ButieItem.query','ButieItem.querypage');
		
		jQuery("#editgrid").jqGrid({
				/*执行存储过程---------------- 
				tsdpname：可以调用其他存储过程，
				注意：tsdpname不是真正对应存储过程名称 而是通过系统进行映射，查看映射名请参照 存储过程维护页
				ds：对应applicationContent.xml里配置的数据源 
				*/					
				url:'mainServlet.html?'+urlstr+'&column='+column,
				datatype: 'xml', 
				colNames:col[0], 
				colModel:col[1],				      
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'Xuhao', //默认排序字段
				       	viewrecords: true, 
				       	//hidegrid: false, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:'<fmt:message key="subsidyPay.ButieItem"/>', 
				       	height:300, //高
				       // width:document.documentElement.clientWidth-27,
				       	loadComplete:function(){
										$("#editgrid").setSelection('0', true);
										$("#editgrid").focus();
										///自动适应 工作空间
										 var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
										setAutoGridHeight("editgrid",reduceHeight);
										//setAutoGridWidth("editgrid",'0');
										
										var editinfo = $("#editinfo").val();
										var deleteinfo = $("#deleteinfo").val();
										addRowOperBtnimage('editgrid','openRowModify','Xuhao','click',1,"style/images/public/ltubiao_01.gif",editinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
										addRowOperBtnimage('editgrid','deleteRow','Xuhao','click',2,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
										addRowOperBtnimage('editgrid','openRowInfo','Xuhao','click',3,'style/images/public/ltubiao_03.gif',"详细","&nbsp;&nbsp;&nbsp;",'');//详细
										
										/*********定义需要的行链接按钮************
										////@1  表格的id
										////@2  链接名称
										////@3  链接地址或者函数名称
										////@4  行主键列的名称 可以是隐藏列
										////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
										////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+
										addRowOperBtn('editgrid',editinfo,'openRowModify','Xuhao','click',1);
										addRowOperBtn('editgrid',deleteinfo,'deleteRow','Xuhao','click',2);
											*/
									   /****执行行按钮添加********
										*@1 表格ID
										*@2 操作按钮数量 等于定义数量
										*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
										executeAddBtn('editgrid',3);
										},
										ondblClickRow: function(ids) {
											if(ids != null) {
												var Xuhao =$("#editgrid").getCell(ids,"Xuhao");
												openRowInfo(Xuhao,'');
											}
										}
										
				}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
			
}

/**
 * 第二个选项卡对应的jqgrid的数据加载，和其对应的弹出面板中标签的国际化
 	表attachprice
 * @param 
 * @return 
 */
function ready2(){
		
		var column  = '';
		var thisdata = loadData('free_grade','<%=languageType %>',1);
		column = thisdata.FieldName.join(',');			 					
		$('#thecolumn').val(column);
		var Free_Codeg = thisdata.getFieldAliasByFieldName('Free_Code');
		var CNameg = thisdata.getFieldAliasByFieldName('CName');
		var MfTypeg = thisdata.getFieldAliasByFieldName('MfType');
				
		var Butie1g = thisdata.getFieldAliasByFieldName('Butie1');
		var BlButie1g = thisdata.getFieldAliasByFieldName('BlButie1');
		
		var Butie2g = thisdata.getFieldAliasByFieldName('Butie2');
		var BlButie2g = thisdata.getFieldAliasByFieldName('BlButie2');
		
		var Butie3g = thisdata.getFieldAliasByFieldName('Butie3');
		var BlButie3g = thisdata.getFieldAliasByFieldName('BlButie3');
		
		var Butie4g = thisdata.getFieldAliasByFieldName('Butie4');
		var BlButie4g = thisdata.getFieldAliasByFieldName('BlButie4');
		
		var Butie6g = thisdata.getFieldAliasByFieldName('Butie6');
		var BlButie6g = thisdata.getFieldAliasByFieldName('BlButie6');		
		
		var Butie7g = thisdata.getFieldAliasByFieldName('Butie7');
		var BlButie7g = thisdata.getFieldAliasByFieldName('BlButie7');
		
		var Butie8g = thisdata.getFieldAliasByFieldName('Butie8');
		var BlButie8g = thisdata.getFieldAliasByFieldName('BlButie8');
		
		var Butie9g = thisdata.getFieldAliasByFieldName('Butie9');
		var BlButie9g = thisdata.getFieldAliasByFieldName('BlButie9');
		
		$("#Free_Codeg").html(Free_Codeg);	
		$("#CNameg").html(CNameg);
		$("#MfTypeg").html(MfTypeg);
		
		$("#Butie1g").html(Butie1g);
		$("#BlButie1g").html(BlButie1g);
		
		$("#Butie2g").html(Butie2g);
		$("#BlButie2g").html(BlButie2g);
		
		$("#Butie3g").html(Butie3g);
		$("#BlButie3g").html(BlButie3g);
		
		$("#Butie4g").html(Butie4g);
		$("#BlButie4g").html(BlButie4g);
		
		$("#Butie6g").html(Butie6g);
		$("#BlButie6g").html(BlButie6g);
		
		$("#Butie7g").html(Butie7g);
		$("#BlButie7g").html(BlButie7g);
		
		$("#Butie8g").html(Butie8g);
		$("#BlButie8g").html(BlButie8g);
		
		$("#Butie9g").html(Butie9g);
		$("#BlButie9g").html(BlButie9g);

		//给页面中存储字段的隐藏标签赋值			
		$("#Free_Codeg_a").html(Free_Codeg);	
		$("#CNameg_a").html(CNameg);
		$("#MfTypeg_a").html(MfTypeg);
		 	
		var col=[[],[]];
		col=getRb_Field('free_grade','Free_Code',"修改|删除|详细",'97','ziduansF2');;//得到jqGrid要显示的字段
		var column = $("#ziduansF2").val();		
	
		//设置命令参数
		var urlstr=buildParamsSql('query','xml','FreeGrade.query','FreeGrade.querypage');
		jQuery("#editgrid").jqGrid({
			/*执行存储过程---------------- 
			tsdpname：可以调用其他存储过程，
			注意：tsdpname不是真正对应存储过程名称 而是通过系统进行映射，查看映射名请参照 存储过程维护页
			ds：对应applicationContent.xml里配置的数据源 
			*/   
				//bytc_type feename ys
			url:'mainServlet.html?'+urlstr+'&column='+column,
			datatype: 'xml', 
			
			colNames:col[0],
			colModel:col[1], 
			       	rowNum:10, //默认分页行数
			       	rowList:[10,15,20], //可选分页行数
			       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
			       	pager: jQuery('#pagered'), 
			       	sortname: 'Free_Code', //默认排序字段
			       	viewrecords: true, 
			       	//hidegrid: false, 
			       	sortorder: 'asc',//默认排序方式 
			       	caption:'<fmt:message key="subsidyPay.FreeGrade"/>', 
			       	height:300, //高
			       	//width:document.documentElement.clientWidth-27,
			       	loadComplete:function(){
									$("#editgrid").setSelection('0', true);
									$("#editgrid").focus();
									///自动适应 工作空间
									 var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
									setAutoGridHeight("editgrid",reduceHeight);
									//setAutoGridWidth("editgrid",'0');
								
									var editinfo = $("#editinfo").val();
									var deleteinfo = $("#deleteinfo").val();
									addRowOperBtnimage('editgrid','openRowModify','Free_Code','click',1,"style/images/public/ltubiao_01.gif",editinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
									addRowOperBtnimage('editgrid','deleteRow','Free_Code','click',2,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
									addRowOperBtnimage('editgrid','openRowInfo','Free_Code','click',3,'style/images/public/ltubiao_03.gif',"详细","&nbsp;&nbsp;&nbsp;",'');//详细
									
									/*********定义需要的行链接按钮************
									////@1  表格的id
									////@2  链接名称
									////@3  链接地址或者函数名称
									////@4  行主键列的名称 可以是隐藏列
									////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
									////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+
									
									addRowOperBtn('editgrid',editinfo,'openRowModify','Free_Code','click',1);
									addRowOperBtn('editgrid',deleteinfo,'deleteRow','Free_Code','click',2);
										*/
								   /****执行行按钮添加********
									*@1 表格ID
									*@2 操作按钮数量 等于定义数量
									*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
									executeAddBtn('editgrid',3);
									},
									ondblClickRow: function(ids) {
											if(ids != null) {
												var Free_Code =$("#editgrid").getCell(ids,"Free_Code");
												openRowInfo(Free_Code,'');
											}
									}
			}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
				{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
				{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
				{reloadAfterSubmit:false}, // del options 
				{} // search options 
				); 
}	

/**
 * 对jqgrid面板查看明细按钮，可查看详细信息
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param key 查询该条记录的第一个参数
 * @param key1  查询该条记录的第二个参数
 * @return 
 */
function openRowInfo(key,key1){
		switch(tabStatus){
				case 1:
					opendsss();
					markTable(1);//显示红色*号	
					//设置编辑框的标题
					$(".top_03").html("详细信息");//标题	
				 	//将修改面板的输入框全部	置为不可用		
					isDisabledN('butieitem','',''); 
					clearText('operformT1');
					queryByID1(key);
					openpan();
					break;
				case 2:
					markTable(1);//显示红色*号	
					//设置编辑框的标题
					$(".top_03").html("详细信息");//标题	
				 	//将修改面板的输入框全部	置为不可用		
					isDisabledN('free_grade','',''); 
					clearText('operformT2');
					queryByID2(key,key1);
					openpan();
					break;
		}
}

/**
 * 第一个选项卡，从数据库中查找出该记录的详细信息，显示在详细面板中 	
 * @param key Xuhao值
 * @return 
 */
function queryByID1(key){
		 	$("#Xuhao").val(key);
			var flag = true;
			var urlstr=buildParamsSql('query','xmlattr','ButieItem.queryByKey','');
			$.ajax({
			
				url:'mainServlet.html?'+urlstr+'&Xuhao='+tsd.encodeURIComponent(key),
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
					/////////////////////////////
					//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
					$(xml).find('row').each(function(){
						//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
						///如果sql语句中指定列名 则按指定名称给参数
						var oldstr=[];
						
						var Xuhao = $(this).attr("Xuhao".toLowerCase());	
						oldstr.push(Xuhao);						
						
						var ButieName = $(this).attr("ButieName".toLowerCase());
						oldstr.push(ButieName);	
						
						var Kemu = $(this).attr("Kemu".toLowerCase());
						oldstr.push(Kemu);	
						
						var FeeFields = $(this).attr("FeeFields".toLowerCase());
						oldstr.push(FeeFields);	
						
						var ZeroMonth = $(this).attr("ZeroMonth".toLowerCase());
						$("#ZeroMonthold").val(ZeroMonth);
						
							$("#Xuhao").val(Xuhao);							
							$("#ButieName").val(ButieName);
							$("#Kemu").val(Kemu);
							$("#FeeFields").val(FeeFields);
							$("#ZeroMonth").val(ZeroMonth);	
							document.getElementById("Xuhao").options.add(new Option(Xuhao,Xuhao));
							$("#Xuhao").val(key);
					/************************************************
						var logoldstr = $("#logoldstr").val();
							var oldstr = logoldstr.split(',');							
												
							//给序号添加上现在的序号值
							//var area="<option value='"+oldstr[0]+"'>"+oldstr[0]+"</option>";
							//$("#Xuhao").html($("#Xuhao").html()+area);
							
							
							$("#Xuhao").val(oldstr[0]);							
							$("#ButieName").val(oldstr[1]);
							$("#Kemu").val(oldstr[2]);
							$("#FeeFields").val(oldstr[3]);
							$("#ZeroMonth").val($("#ZeroMonthold").val());	
				*********************************************/			
						$("#logoldstr").val(oldstr);
					});
				}
			});
			return flag;
} 
/**
 * 第二个选项卡，从数据库中查找出该记录的详细信息，
 	通过index字段判断，如果非添加操作把查处信息显示在详细面板中、是添加操作不做处理 	
 * @param key Free_Code值
 * @param index 判断是否为添加操作，add：添加操作
 * @return flag true：表识数据中用没有该条记录，可进行添加操作； false：表识数据中有操作不能进行添加
 */  
function queryByID2(key,index){

 		var flag = true;
		var Free_Codeh =delTrim($("#Free_Code").val());
		var urlstr=buildParamsSql('query','xmlattr','FreeGrade.queryByKey','');
		
		$.ajax({
		
			url:'mainServlet.html?'+urlstr+'&Free_Code='+tsd.encodeURIComponent(key),
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				/////////////////////////////
				//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
				$(xml).find('row').each(function(){
					//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
					///如果sql语句中指定列名 则按指定名称给参数
					var oldstr=[];
				
					var Free_Code = $(this).attr("Free_Code".toLowerCase());	
					if(Free_Code!='undefined'&&Free_Code!=undefined){
						Free_Code=Free_Code.toLowerCase();
						Free_Codeh=Free_Codeh.toLowerCase();
						if(Free_Codeh==Free_Code){
							flag=false;
						}
					}
					
					oldstr.push(Free_Code);						
					
					var CName = $(this).attr("CName".toLowerCase());
					oldstr.push(CName);	
					
					var MfType = $(this).attr("MfType".toLowerCase());
					oldstr.push(MfType);	
					
					var butie='';
					var blbutie='';
					for(i=1;i<11;i++){
						butie='Butie'+i;
						blbutie='BlButie'+i;
						var Butie = $(this).attr(butie.toLowerCase());
						oldstr.push(Butie);	
						var BlButie = $(this).attr(blbutie.toLowerCase());
						oldstr.push(BlButie);	
					}
					$("#logoldstr").val(oldstr);
					if( index=='add'){}
					else{
						$("#Free_Code").val(Free_Code);
						$("#CName").val(CName);
						$("#MfType").val(MfType);
						for(i=1;i<11;i++){
							butie='Butie'+i;
							blbutie='BlButie'+i;
							var Butie = $(this).attr(butie.toLowerCase());
							$("#"+butie).val(Butie);
							var BlButie = $(this).attr(blbutie.toLowerCase());
							$("#"+blbutie).val(BlButie);
						}
					}
				});
			}
		});
		return flag;
}	



var closeflash = false;//用于判断添加操作是保存新增，或保存退出。保存新增closeflash=true ；保存退出=false
/**
 * 添加面板中保存新增、保存退出按钮操作
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param saves 判断保存类型 1：保存新增 ；2保存退出
 * @return 
 */
 function saveObj(saves){
  	switch(tabStatus){
		case 1:
  		 			var params=buildParams();
					if(params==false){return false;}
					
					var urlstr=buildParamsSql('exe','xml','ButieItem.save','');
					urlstr+=params;
							
							//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)
							$.ajax({
							url:'mainServlet.html?'+urlstr,
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
								success:function(msg){
									if(msg=="true"){
									var operationtips = $("#operationtips").val();
									var successful = $("#successful").val();
									jAlert(successful,operationtips);
									
									//移除序号值
									var xuhao = $("#Xuhao").val();
									$("#Xuhao option[value='"+xuhao+"']").remove();
									
									//写入日志操作									
									var str ="(butieitem)<fmt:message key='subsidyPay.ButieItem'/><fmt:message key='global.add'/>。"+$("#Xuhaog").html()+": "+$("#Xuhao").val()+";"+$("#ButieNameg").html()+": "+$("#ButieName").val()+";"+$("#Kemug").html()+": "+$("#Kemu").val()+";"+$("#FeeFieldsg").html()+": "+$("#FeeFields").val()+";"+$("#ZeroMonthg").html()+": "+$("#ZeroMonth").val();
									writeLogInfo("","add",tsd.encodeURIComponent(str));		
									}
								}
							});	
				 break;
		case 2:	
				/***************************
				*     判断完成，进行保存操作   *
				***************************/
							
							
							var Free_Code= delTrim($("#Free_Code").val());	
							if(Free_Code==null||Free_Code==""){						 
					 			var Free_Codeg = $("#Free_Codeg").html();
					 			alert("<fmt:message key='tariff.input'/>"+Free_Codeg);
					 			$("#Free_Code").focus();
					 			return false;
					 		} 						
							var flag =queryByID2(Free_Code,'add');
							
							if(flag==false){
								var operationtips = $("#operationtips").val();
								//套餐类型和费用名称的组合已经存在，请重新输入！
								var str = $("#Free_Codeg").text();
								//jAlert(str+' <fmt:message key="tariff.isExist"/>',operationtips);
								alert(str+' <fmt:message key="tariff.isExist"/>');
								$("#Free_Code").focus();
								return false;
							}
							
							var params=buildParams();
							if(params==false){return false;}
							var urlstr=buildParamsSql('exe','xml','FreeGrade.save','');
							
							urlstr+=params;
							//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)
							$.ajax({
							url:'mainServlet.html?'+urlstr,
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
								success:function(msg){
									if(msg=="true"){
									var operationtips = $("#operationtips").val();
									var successful = $("#successful").val();
									jAlert(successful,operationtips);
									
									//写入日志操作
									var str ='';
									var Free_Code = delTrim($("#Free_Code").val());
									var CName = delTrim($("#CName").val());
									var MfType = delTrim($("#MfType").val());
									str+="(free_grade)<fmt:message key='subsidyPay.FreeGrade'/><fmt:message key='global.add'/>。"+$("#Free_Codeg").html()+": "+Free_Code+";"+$("#CNameg").html()+": "+CName+";"+$("#MfTypeg").html()+": "+MfType+";";
									
									for(i=1;i<5;i++){
										str+=$("#Butie"+i+"g").html()+": "+$("#Butie"+i).val()+";";
										str+=$("#BlButie"+i+"g").html()+": "+$("#BlButie"+i).val()+";";
									}
									
									for(i=6;i<10;i++){
										str+=$("#Butie"+i+"g").html()+": "+$("#Butie"+i).val()+";";
										str+=$("#BlButie"+i+"g").html()+": "+$("#BlButie"+i).val()+";";
									}
									
									//var imenuname =$("#imenuname").val();
									//var str =$("#dhg").html()+": "+$("#dh").val()+$("#bdhthg").html()+": "+$("#bdhth").val()+$("#cththg").html()+": "+$("#cthth").val()+$("#iphthg").html()+": "+$("#iphth").val()+$("#shhthg").html()+": "+$("#shhth").val()+$("#swhthg").html()+": "+$("#swhth").val()+$("#xxththg").html()+": "+$("#xxthth").val()+$("#xywhthg").html()+": "+$("#xywhth").val()+$("#yzhthg").html()+": "+$("#yzhth").val();
									writeLogInfo("","add",tsd.encodeURIComponent(str));	
										
									}
								}
							});
				
				break;
	}
	if(saves==2){
		fuheQuery();
		//querylist();
		setTimeout($.unblockUI, 15);
	}else{
		closeflash=true;//表示关闭时需要刷新
		clearText('operformT'+tabStatus);
	}			
}

 

 /**
 * 修改面板中，修改按钮操作
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param
 * @return 
 */
function modifyObj(){ 
		  	switch(tabStatus){
				 case 1:
					var params = buildParams();
					 if(params==false){return false;}		
					
					 var urlstr=buildParamsSql('exe','xml','ButieItem.modify','');
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
									//移除序号值
									var xuhao = $("#Xuhao").val();
									$("#Xuhao option[value='"+xuhao+"']").remove();
									
									//写入日志
									var logoldstr = $("#logoldstr").val();	
									var oldstr = logoldstr.split(',');
									var imenuname =$("#imenuname").val();							
									var ZeroMonthold =$("#ZeroMonthold").val();
									var str ="(butieitem)<fmt:message key='subsidyPay.ButieItem'/><fmt:message key='global.edit'/>。"+$("#Xuhaog").html()+": "+oldstr[0]+";"+$("#ButieNameg").html()+": "+oldstr[1]+">>>"+$("#ButieName").val()+";"+$("#Kemug").html()+": "+oldstr[2]+">>>"+$("#Kemu").val()+";"+$("#FeeFieldsg").html()+": "+oldstr[3]+">>>"+$("#FeeFields").val()+";"+$("#ZeroMonthg").html()+": "+ZeroMonthold+">>>"+$("#ZeroMonth").val();
									//str = transfer(str);
									writeLogInfo("","modify",tsd.encodeURIComponent(str));		
									
									fuheQuery();
								}	
							}
						});
					break;
				case 2:
					var params = buildParams();
					if(params==false){return false;}		
					 
					 var urlstr=buildParamsSql('exe','xml','FreeGrade.modify','');
					
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
								var str ='';
								var logoldstr = $("#logoldstr").val();	
								var oldstr = logoldstr.split(',');
								var Free_Code = delTrim($("#Free_Code").val());
								var CName = delTrim($("#CName").val());
								var MfType = delTrim($("#MfType").val());
								str+="(free_grade)<fmt:message key='subsidyPay.FreeGrade'/><fmt:message key='global.edit'/>。"+$("#Free_Codeg").html()+": "+Free_Code+";"+$("#CNameg").html()+": "+oldstr[1]+">>>"+CName+";"+$("#MfTypeg").html()+": "+oldstr[2]+">>>"+MfType+";";
								for(i=1;i<5;i++){
									str+=$("#Butie"+i+"g").html()+": " +oldstr[2+(i*2)-1]+">>>"+$("#Butie"+i).val()+";";
									str+=$("#BlButie"+i+"g").html()+": "+oldstr[2+(i*2)]+">>>"+$("#BlButie"+i).val()+";";
								}
								
								for(i=6;i<10;i++){
									str+=$("#Butie"+i+"g").html()+": "+oldstr[2+(i*2)-1]+">>>"+$("#Butie"+i).val()+";";
									str+=$("#BlButie"+i+"g").html()+": "+oldstr[2+(i*2)]+">>>"+$("#BlButie"+i).val()+";";
								}
								writeLogInfo("","modify",tsd.encodeURIComponent(str));	
									//写入日志
									/*************
									var logoldstr = $("#logoldstr").val();	
									var oldstr = logoldstr.split(',');
									
									var imenuname =$("#imenuname").val();
									var str =$("#dhg").html()+": "+oldstr[0]+$("#bdhthg").html()+": "+oldstr[1]+"=>"+$("#bdhth").val()+$("#cththg").html()+": "+oldstr[2]+"=>"+$("#cthth").val()+$("#iphthg").html()+": "+oldstr[3]+"=>"+$("#iphth").val()+$("#shhthg").html()+": "+oldstr[4]+"=>"+$("#shhth").val()+$("#swhthg").html()+": "+oldstr[5]+"=>"+$("#swhth").val()+$("#xxththg").html()+": "+oldstr[6]+"=>"+$("#xxthth").val()+$("#xywhthg").html()+": "+oldstr[7]+"=>"+$("#xywhth").val()+$("#yzhthg").html()+": "+oldstr[8]+"=>"+$("#yzhth").val();
									str = transfer(str);
									writeLogInfo("<fmt:message key='subsidyPay.FreeGrade'/>","<fmt:message key='global.edit'/>",str);	
									*******************/			
									fuheQuery();
								}	
							}
						});
							
					break;
			}							
}
  		 

/**
 * jqgrid面板中，删除按钮操作
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param key 查询该条记录的参数
 * @return 
 */
function deleteRow(key){   		 	
  	//var deleteright=document.getElementById("delattributes"+tabStatus).value;
  	//是否有执行删除的权限  
	var deleteright = $("#deleteright").val();
	if(deleteright=="true"){
		switch(tabStatus){
		 	case 1:		 			
					queryByID1(key);	
				 	var deleteinformation = $("#deleteinformation").val();
					var operationtips = $("#operationtips").val();
				 	jConfirm(deleteinformation,operationtips,function(x){
				 		 if(x==true){
				 		 	 
							var urlstr1=buildParamsSql('exe','xml','ButieItem.delete','');
							var urlstr='mainServlet.html?'+urlstr1+'&Xuhao='+key; 
							$.ajax({
								url:urlstr,
								cache:false,//如果值变化可能性比较大 一定要将缓存设成false
								timeout: 1000,
								async: false ,//同步方式
								success:function(msg){
									if(msg=="true"){
										var operationtips = $("#operationtips").val();
										var successful = $("#successful").val();
										jAlert(successful,operationtips);
										setTimeout($.unblockUI, 15);
										
										//querylist();
										//写入日志操作
										
										var logoldstr = $("#logoldstr").val();	
										var oldstr = logoldstr.split(',');
										
										var str ="(butieitem)<fmt:message key='subsidyPay.ButieItem'/><fmt:message key='global.delete'/>。"+$("#Xuhaog").html()+": "+oldstr[0]+";"+$("#ButieNameg").html()+": "+oldstr[1]+";"+$("#Kemug").html()+": "+oldstr[2]+";"+$("#FeeFieldsg").html()+": "+oldstr[3]+";"+$("#ZeroMonthg").html()+": "+$("#ZeroMonthold").val();
										///str = transfer(str);
										//var imenuname =$("#imenuname").val();
										writeLogInfo("","delete",tsd.encodeURIComponent(str));	
										
										/*****************
										//往序号列中添加序号
										var area="<option value='"+oldstr[0]+"'>"+oldstr[0]+"</option>";
										$("#Xuhao").html($("#Xuhao").html()+area);
										*******************/
										fuheQuery();
									}	
								}
							});
						}
					});
					break;
			case 2:	
					queryByID2(key,'');	
				 	var deleteinformation = $("#deleteinformation").val();
					var operationtips = $("#operationtips").val();
				 	jConfirm(deleteinformation,operationtips,function(x){
				 		 if(x==true){
				 		 	
							var urlstr1=buildParamsSql('exe','xml','FreeGrade.delete','');
							var urlstr='mainServlet.html?'+urlstr1+'&Free_Code='+tsd.encodeURIComponent(key); 
							$.ajax({
								url:urlstr,
								cache:false,//如果值变化可能性比较大 一定要将缓存设成false
								timeout: 1000,
								async: false ,//同步方式
								success:function(msg){
									if(msg=="true"){
										var operationtips = $("#operationtips").val();
										var successful = $("#successful").val();
										jAlert(successful,operationtips);
										setTimeout($.unblockUI, 15);
										
										//写入日志操作
										var str ='';
										//var Free_Code = strtrimB($("#Free_Code").val());
										//var CName = strtrimB($("#CName").val());
										//var MfType = strtrimB($("#MfType").val());
										var logoldstr = $("#logoldstr").val();	
										var oldstr = logoldstr.split(',');
										str+="(free_grade)<fmt:message key='subsidyPay.FreeGrade'/><fmt:message key='global.delete'/>。"+$("#Free_Codeg").html()+": "+oldstr[0]+";"+$("#CNameg").html()+": "+oldstr[1]+";"+$("#MfTypeg").html()+": "+oldstr[2]+";";
										for(i=1;i<5;i++){
											str+=$("#Butie"+i+"g").html()+": "+oldstr[2+(i*2)-1]+";";
											str+=$("#BlButie"+i+"g").html()+": "+oldstr[2+(i*2)]+";";
										}
										
										for(i=6;i<10;i++){
											str+=$("#Butie"+i+"g").html()+": "+oldstr[2+(i*2)-1]+";";
											str+=$("#BlButie"+i+"g").html()+": "+oldstr[2+(i*2)]+";";
										}
									
										writeLogInfo("","delete",tsd.encodeURIComponent(str));	
										fuheQuery();	
										/***********
										//写入日志操作
										var logoldstr = $("#logoldstr").val();	
										var oldstr = logoldstr.split(',');
										var str =$("#dhg").html()+": "+oldstr[0]+$("#bdhthg").html()+": "+oldstr[1]+$("#cththg").html()+": "+oldstr[2]+$("#iphthg").html()+": "+oldstr[3]+$("#shhthg").html()+": "+oldstr[4]+$("#swhthg").html()+": "+oldstr[5]+$("#xxththg").html()+": "+oldstr[6]+$("#xywhthg").html()+": "+oldstr[7]+$("#yzhthg").html()+": "+oldstr[8];
										str = transfer(str);
										var imenuname =$("#imenuname").val();
										writeLogInfo("<fmt:message key='subsidyPay.FreeGrade'/>","<fmt:message key='global.delete'/>",str);		
										***********/		
									}	
								}
							});
						}
					});
					break;
		}			
		
	}else{
		var operationtips = $("#operationtips").val();
		var deletepower = $("#deletepower").val();	
		jAlert(deletepower,operationtips);
	}
}

   
/**
 * 进行通用查询 批量删除 批量修改入口；
 	根据隐藏域queryName 判断是何种操作 delete：批量删除 ；modify：批量修改；其他：高级查询
 * @param 
 * @return 
 */            
function fuheExe()
{
		var queryName= document.getElementById("queryName").value;
		if(queryName=="delete")
		{
			fuheDel();
		}
		else if(queryName=="modify")
		{
			fuheOpenModify();
		}
		else
		{
			fuheQuery();
		}
}

/**
 * 重新加载jQgrid数据
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param key备用参数
 * @return 
 */
function querylist(key){
			//在调用此方法是清空符合查询的查询条件，避免导出或打印时显示信息有误
			$("#fusearchsql").val("");
			var column='';
			var link='';
			switch(tabStatus){
  					case 1:   						
					column = $("#ziduansF1").val();
  						var urlstr1=buildParamsSql('query','xml','ButieItem.query','ButieItem.querypage');
  						link=urlstr1;
  						break;
  					case 2:   						
					column = $("#ziduansF2").val();
  						var urlstr1=buildParamsSql('query','xml','FreeGrade.query','FreeGrade.querypage');
  						link=urlstr1;
  						break;
  				}				
		 	setTimeout($.unblockUI, 15);//关闭面板
			$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
			closeo();
}

/**
 * 高级查询操作，通过高级查询面板生成查询条件，查询和刷新jqgrid面板中的信息
 通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function fuheQuery()
{	
			//var colsStr = $("#cols").val();
			var params = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
			if(params=='&fusearchsql='){
				params +='1=1';
			}				
		 	var column='';
			switch(tabStatus){
		 			case 1:
							column = $("#ziduansF1").val();
							break;
					case 2:
							column = $("#ziduansF2").val();
							break;
				}////switch end	
		 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:pkeys[tabStatus-1]+'.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										  tsdpkpagesql:pkeys[tabStatus-1]+'.fuheQueryByWherepage'
										});
			
			var link = urlstr1 + params;			
		 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
		 	setTimeout($.unblockUI, 15);//关闭面板
		 	closeo();			
}

/**
 * 组合排序 
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param sqlstr 进行组合排序的排序sql子语句
 * @return 
 */
function zhOrderExe(sqlstr){
		var params = fuheQbuildParams();			
		if(params=='&fusearchsql='){
			params +='1=1';
		}
		params =params+'&orderby='+sqlstr;			
		////var params ='&orderby='+sqlstr;			    
	 	//var colsStr = $("#cols").val();		 	
	 	var urlstr1=tsd.buildParams({ packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:pkeys[tabStatus-1]+'.queryByOrder',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  tsdpkpagesql:pkeys[tabStatus-1]+'.queryByOrderpage'
									});
		//var link = urlstr1 + params+ "&cols="+colsStr;	
		var link = urlstr1 + params;
		var column='';
		switch(tabStatus){
	 			case 1:
						column = $("#ziduansF1").val();
						break;
				case 2:
						column = $("#ziduansF2").val();
						break;
		}////switch end			
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
	 	//setTimeout($.unblockUI, 15);//关闭面板		 	
}

/**
 * 打开简单查询面板  
 	通过tabStatus，来判断是在哪个选项卡进行的操作	
 * @param 
 * @return 
 */
function openQuery(){ 	
		
		markTable(1);//隐藏红色*号
		$(".top_03").html('<fmt:message key="global.query" />');//标题		
		switch(tabStatus){
			case 1:	
				opendsss();
				removeDisabledN('butieitem','','');			
				openpan();
				//序号初始化
			 	getXuhaoQuery();
				$('#jdquery1').show();
				clearText('operformT1');			
				break;
			case 2:	
				removeDisabledN('free_grade','','');
				openpan();				
				
				$('#jdquery2').show();
				clearText('operformT2');
				document.getElementById("unquery").style.display="none";		
				$('#unquery').attr('style','display:none');	
				break;	
			}
 }
 
 
/**
 * jqgrid上新增按钮操作 ，弹出新增面板	
 	通过tabStatus，来判断是在哪个选项卡进行的操作	
 * @param
 * @return
 */
function openadd(){

		markTable(0);//显示红色*号
		$(".top_03").html('<fmt:message key="global.add" />');//标题	
		switch(tabStatus){			
			case 1:	
				opendsss();	
				//初始化序号
				getXuhao();	
				removeDisabledN('butieitem','','');
				openpan();
				$("#save1").show();
	 			$("#readd1").show();
				clearText('operformT1');				
				break;
			case 2:					
				removeDisabledN('free_grade','','');
				openpan();
				$("#save2").show();
	 			$("#readd2").show();
	 			clearText('operformT2');
				break;	
			}
}

 /**
 * jqgrid上修改按钮操作 ，打开修改面板并加载将要修改的数据
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param key 查询该条记录的参数
 * @return 
 */
function openRowModify(key){
	var editright = $("#editright").val();
			if(editright=="true"){	
				switch(tabStatus){
					case 1:
							opendsss();
							markTable(0);//显示红色*号
							var editinfo = $("#editinfo").val();
						 	$(".top_03").html(editinfo);//设置编辑框的标题
							
							isDisabledN('butieitem','',''); //将修改面板的输入框全部	置为不可用	
							openpan();//显示修改面板							
							$("#modify1").show();$("#reset1").show();
							clearText('operformT1');//清空修改面板								
							
							queryByID1(key);//取出数据库中改条记录，并放到修改面板中	
															
							setTableFields();	
									
							$('#Xuhao').attr("disabled","disabled");
							$("#Xuhao").removeClass();
							$("#Xuhao").addClass("textclass2");				
							break;			
				case 2:
					
						markTable(0);//显示红色*号
						var editinfo = $("#editinfo").val();
					 	$(".top_03").html(editinfo);//设置编辑框的标题				
					 		
						isDisabledN('free_grade','','');//将修改面板的输入框全部	置为不可用
						openpan();//显示修改面板
						$("#modify2").show();$("#reset2").show();
						clearText('operformT2');//清空修改面板	
						queryByID2(key,'');			
						setTableFields();			
						
						$('#Free_Code').attr("disabled","disabled");
						$("#Free_Code").removeClass();
						$("#Free_Code").addClass("textclass2");	
					
					break;			
			}
		}
		else{
			var operationtips = $("#operationtips").val();
			var editpower = $("#editpower").val();
			jAlert(editpower,operationtips);
		}
}


 /**
 * 根据简单查询输入条件进行简单查询
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param  
 * @return 
 */	
 function QbuildParams(){
    switch(tabStatus){
   		case 1:
			 	var Xuhao = $("#Xuhao").val();
			 	var ButieName = delTrim($("#ButieName").val());
			 	var Kemu = $("#Kemu").val();
			 	var FeeFields=$("#FeeFields").val();
			 	var ZeroMonth = $("#ZeroMonth").val();				 	
			 	
			 	var paramsStr='1=1 ';
			 	if(Xuhao!=''){
			 	 	paramsStr+="and Xuhao like '%"+Xuhao+"%' ";
			 	}
			 	if(ButieName!=''){
			 		paramsStr+="and ButieName like '%"+ButieName+"%' " ;
			 	}
			 	if(Kemu!=''){
			 		paramsStr+="and Kemu like '%"+Kemu+"%' " ;
			 	}
			 	if(FeeFields!=''){
			 		paramsStr+="and FeeFields like '%"+FeeFields+"%' " ;
			 	}
			 	if(ZeroMonth!=''){
			 		paramsStr+="and ZeroMonth like '%"+ZeroMonth+"%' " ;
			 	}
			 	
			 	$("#fusearchsql").val(paramsStr);
			 	fuheQuery();
				break;
		case 2:				
				var Free_Code = delTrim($("#Free_Code").val());
			 	var CName = delTrim($("#CName").val());
			 	var MfType = delTrim($("#MfType").val());
			 	
			 	var paramsStr='1=1 ';
			 	if(Free_Code!=''){
			 	 	paramsStr+="and Free_Code like '%"+Free_Code+"%' ";
			 	}
			 	if(CName!=''){
			 		paramsStr+="and CName like '%"+CName+"%' " ;
			 	}
			 	if(MfType!=''){
			 		paramsStr+="and MfType like '%"+MfType+"%' " ;
			 	}
			 	
			 	$("#fusearchsql").val(paramsStr);
			 	fuheQuery();
				break;
	}////switch end	
 }

 /**
 * 添加、修改面板，通过表单值构造数据操作参数 请根据业务参数的多少和属性进行修改
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 	@oper 操作类型 modify|save 	
 * @param 
 * @return 
 */
function buildParams(){
	var operationtips = $("#operationtips").val();
    switch(tabStatus){
   		case 1:
   				//每次拼接参数必须初始化此参数
				tsd.QualifiedVal=true;				
			 	var params='';
				
			 	var Xuhao = $("#Xuhao").val();
			 	var ButieName = delTrim($("#ButieName").val());
			 	var Kemu = $("#Kemu").val();
			 	var FeeFields=$("#FeeFields").val();
			 	var ZeroMonth = $("#ZeroMonth").val();			 	
				
				if(Xuhao==''){
					$("#Xuhao option").eq(0).attr('selected','selected'); 
					Xuhao = $("#Xuhao").val();
				}
				//必填 字符串
				if(ButieName==null|ButieName==''){
					var str=$("#ButieNameg").html();
					alert("<fmt:message key='tariff.input'/>"+str);
					$("#ButieName").focus();
					return false;
				}
			 	//如果有可能值是汉字 请使用encodeURI()函数转码
			 	params+="&Xuhao="+Xuhao;
			 	params+="&ButieName="+tsd.encodeURIComponent(ButieName);
			 	params+="&Kemu="+tsd.encodeURIComponent(Kemu);
			 	params+="&FeeFields="+tsd.encodeURIComponent(FeeFields);
			 	params+="&ZeroMonth="+tsd.encodeURIComponent(ZeroMonth);
			 	//每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}
				return params;
				break;
		case 2:
				//每次拼接参数必须初始化此参数
				tsd.QualifiedVal=true;				
			 	var params='';
			 	var operationtips = $("#operationtips").val(); 					
				var Free_Code = delTrim($("#Free_Code").val());
			 	var CName = delTrim($("#CName").val());
			 	var MfType = delTrim($("#MfType").val());
			 	var Butie=[];
			 	var BlButie=[];
			 	for(i=1;i<=10;i++){
			 		Butie.push($("#Butie"+i).val());			 		
			 		BlButie.push($("#BlButie"+i).val());
			 	}
			 	
			 	if(Free_Code!=null&&Free_Code!=""){
					params+="&Free_Code="+tsd.encodeURIComponent(Free_Code);
			 	}	
		 		else{
		 			var Free_Codeg = $("#Free_Codeg").html();			 			
		 			//jAlert("<fmt:message key='tariff.input'/>"+Free_Codeg,operationtips);
		 			alert("<fmt:message key='tariff.input'/>"+Free_Codeg);
		 			$("#Free_Code").focus();
		 			return false;
		 		} 
		 		params+="&CName="+tsd.encodeURIComponent(CName);
		 		params+="&MfType="+tsd.encodeURIComponent(MfType);
		 		for(i=1;i<11;i++){
		 			if(Butie[i-1]==""||Butie[i-1]==null){		 			    
		 				params+="&Butie"+i+"=0";
		 			}
		 			else{		 				
		 				if(isMoney(Butie[i-1])){
		 					params+="&Butie"+i+"="+Butie[i-1];
		 				}else{
		 					alert($("#Butie"+i+"g").text()+"请输入小数位不超过四的数字。");
		 					return false;
		 				}
		 			}
					if(BlButie[i-1]==""||BlButie[i-1]==null){
		 				params+="&BlButie"+i+"=0";
		 			}
		 			else{
		 				if(isNumericY(BlButie[i-1])){
		 					params+="&BlButie"+i+"="+BlButie[i-1];
		 				}else{
		 					alert($("#BlButie"+i+"g").text()+"请输入整数位不超过3位，小数位不超过2的数字。");
		 					return false;
		 				}		 				
		 			}
		 		}				
				 //如果有可能值是汉字 请使用encodeURI()函数转码		 		
		 		//每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}
				return params;
				break;
	}////switch end		  		
}
           	
 /**
 * 高级查询参数获取
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function fuheQbuildParams(){
	 	//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
	 	var params='';
	 	
	 	/***日志需要的***/
	 	var ss=$("#fusearchsql").val();	
	 	var sss=ss.substr(9,ss.length-11);			 	
	 	var ssss=sss.replace("'","");
	 	var sssss=ssss.replace("' "," ");
	 	var ssssss=sssss.replace(" '"," ");			 		 	
	 	$("#areah").val(ssssss);	
	 		 	
	 	var fusearchsql = encodeURIComponent($("#fusearchsql").val());
	 	//如果有可能值是汉字 请使用encodeURI()函数转码
	 	params+='&fusearchsql='+fusearchsql;			 	
	 	//注意：不要在此做空的判断 即使为空 也必须放入请求中			 	
	 	//每次拼接参数必须添加此判断
		if(tsd.Qualified()==false){return false;}
		return params;
}
 /**
 * 设弹出面板可编辑域
 	根据管理员在配置页面配置的信息解析
 * @param 
 * @return 
 */
function setTableFields(){
		switch(tabStatus){
				case 1:
					var editfields = $("#editfields").val();
									
					/*************************************
					**   将当前表的所有字段取出来，分割字符串 ***
					*************************************/						
					var fields = getFields("butieitem");																			
					var fieldarr = fields.split(",");
					
					/**********************************
					**   将当前表中的spower字段取出来 *****
					**********************************/
					var spower = editfields.split(",");
					
					/***************************
					**  考虑字段大小写问题   *****
					*************************/							
					var atr = '';
					for(var i = 0 ; i <spower.length;i++){
						atr+=spower[i]+'@';	
					}
					var atrarr = atr.split('@');
					var arr = atrarr.sort();
					
					if(arr.length>0){
						for(var i=1;i<arr.length;i++){
							for(var j = 0 ; j <fieldarr.length-1;j++){
								if(arr[i]==fieldarr[j]){	
									$('#'+arr[i]).removeAttr("disabled");						
									$('#'+arr[i]).removeClass();
									$('#'+arr[i]).addClass("textclass");											
									break;
								}
							}
							
						}
					}	
					break;
				case 2:
					
					var editfields = $("#editfields_son").val();
											
					/*************************************
					**   将当前表的所有字段取出来，分割字符串 ***
					*************************************/
					
					var fields = getFields("free_grade");
																	
					var fieldarr = fields.split(",");
					/**********************************
					**   将当前表中的spower字段取出来 *****
					**********************************/
					var spower = editfields.split(",");
					/************************
					**  考虑字段大小写问题   ****
					*************************/
					
					var atr = '';
					for(var i = 0 ; i <spower.length;i++){
						atr+=spower[i]+'@';	
					}
					var atrarr = atr.split('@');
					var arr = atrarr.sort();
					
					if(arr.length>0){
						for(var i=1;i<arr.length;i++){
							for(var j = 0 ; j <fieldarr.length-1;j++){
								if(arr[i]==fieldarr[j]){
									$('#'+arr[i]).removeAttr("disabled");						
									$('#'+arr[i]).removeClass();
									$('#'+arr[i]).addClass("textclass");											
									break;
								}
							}
							
						}
					}
					break;		
		}
			
}

 
</script>
<script type="text/javascript">
 /**
 * 关闭表格面板
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function closeo(){
		if(closeflash){
		 		 closeflash=false;
		 		 querylist(0);	
		 }
		 switch(tabStatus){
			case 1:
				clearText('operformT1');
				break;
			case 2:
				clearText('operformT2');				
				break;
		}		
			
		setTimeout($.unblockUI, 15);//关闭面板		
}

 /**
 * 打开表格面板
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function openpan(){
	switch(tabStatus){
			case 1:				
				autoBlockFormAndSetWH('panTab1',60,5,'closeo1',"#ffffff",true,1000,'');//弹出查询面板				
				$("#jdquery1").hide();$("#readd1").hide();$("#save1").hide();$("#modify1").hide();$("#reset1").hide();$("#clearB1").hide();
				break;
				
			case 2:							
				autoBlockFormAndSetWH('panTab2',60,5,'closeo2',"#ffffff",true,1000,'');//弹出查询面板
				document.getElementById("unquery").style.display="";
				$("#jdquery2").hide();$("#readd2").hide();$("#save2").hide();$("#modify2").hide();$("#reset2").hide();$("#clearB2").hide();
				break;
	}		
}

 /**
 * 修改面板的取消按钮操作
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function resett(){		
		switch(tabStatus){
			case 1:
				var key=$("#Xuhao").val();
				queryByID1(key);
				break;
			case 2:
				var key=delTrim($("#Free_Code").val());
				queryByID2(key,'');
				break;
		}
}	
</script>
<script type="text/javascript">

/**
 * 页面上组合排序按钮操作，打开组合排序窗口
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */     
function openwinO(){
	switch(tabStatus){
			case 1:
			openDiaO('butieitem');
			break;
		case 2:
			openDiaO('free_grade');
			break;
	}////switch end		
				
}
			 
 /**
 * 页面上高级查询按钮操作，打开查询窗口
 * @param 
 * @return 
 */	
function openwinQ()
{
		openfuh("query");				
}
			
 /**
 * 高级查询、批量修改、批量删除打开查询窗口
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param str str打开窗口方法，query modify delete存放在隐藏域queryName
 * @return 
 */	
function openfuh(str){
			
		switch(tabStatus){
			case 1:
				openDiaQueryG(str,'butieitem','1');
				break;
			case 2:
				openDiaQueryG(str,'free_grade','2');
				break;
		}////switch end	
}

 /**
 * 打开保存本次查询面板
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @return 
 */	
function openSaveModPan(){
		switch(tabStatus){
			case 1:
				openModT('butieitem','1');
				break;
			case 2:
				openModT('free_grade','2');
				break;
		}////switch end	
}
 /**
 * 页面上批量删除按钮操作，打开查询窗口
 * @param 
 * @return 
 */	
function openwinD()
{
		var delBright=document.getElementById("delBattributes"+tabStatus).value;
		delBright="true";
		if(delBright=="true"){
			openfuh("delete");
		}else{
 			var operationtips = $("#operationtips").val();						
			jAlert("<fmt:message key="global.deleteBright"/>",operationtips);
 		}
}


/**
 * 查询模板保存面板中的保存按钮操作，用于保存本次查询为模板
	 通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function addQuery(){
	saveModQuery(tabStatus);
}
 /**
 * 模板查询按钮操作，弹出查询模板信息窗口，用户可根据该查看信息，选择已有查询模板进行查询
	 通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function modQuery(){	
	 openQueryM(tabStatus);
}
 /**
 *导出数据面板的导出按钮操作，
	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function saveExoprt(){
		switch(tabStatus){
			case 1:			
					getTheCheckedFields('tsdBilling','mssql','butieitem');				
					break;
			case 2:			
					getTheCheckedFields('tsdBilling','mssql','free_grade');
					break;			
		}
 }
 /**
 *页面上导出按钮操作
	  通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param
 * @return 
 */
 function openExport(){
 		switch(tabStatus){
			case 1:			
					thisDownLoad('tsdBilling','mssql','butieitem','<%=languageType %>');				
					break;
			case 2:			
					thisDownLoad('tsdBilling','mssql','free_grade','<%=languageType %>');	
					break;			
		}
 }
</script>
<style type="text/css"> 
 .style1 {
	background-color:#A9C3E8;
	padding: 4px;		
	}
	
.a{margin-right:10%;margin-left: 100px;border:1px solid #ccc;width:500px;overflow:left;text-overflow:ellipsis;}

</style>
<style type="text/css">
			#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
			cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
</style>
</head>

  <body>  
   <form name="childform" id="childform">
  <input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
  <input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
  </form>
  		<!-- 用户操作导航-->
		<div id="navBar1">
			<table width="100%" style="height:26px; ">
			<tr>
				<td width="80%" valign="middle">
			  <div id="navBar" style="float:left">
			  <img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
			  <fmt:message key="global.location" />
					:
			  </div>
			  </td>
			  <td width="20%" align="right" valign="top">
			  <div id="d2back"><a href="javascript:void(0);" onclick="parent.history.back(); return false;"><fmt:message key="gjh.houtuei" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			  </td>
			  </tr>
		  </table>
		</div>
		
	<div id="zong" >
		<!-- 用户操作标题以及放一些快捷按钮-->		
		<div id="buttons" style="100%; float:left;">
			<button type="button" id="order" onclick="openwinO();" style="20%; float:left;">
				<!--组合排序--><fmt:message key="order.title" />
			</button>			
			<button type="button" id="openadd1" onclick="openadd();" style="20%; float:left;" disabled="disabled">
				<!-- 新增 --><fmt:message key="global.add" />
		    </button>	
		    <button type="button" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>
			<button  id='mbquery1' onclick='modQuery();'>
				<fmt:message key="oper.mod"/>
			</button>
			<button id='gjquery1' onclick="openwinQ();" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button  id='savequery1' onclick="openSaveModPan();" disabled="disabled">
				<!--保存本次查询--><fmt:message key="oper.modSave"/>
			</button>		   
			<button type="button" id="export1" onclick="openExport();" disabled="disabled"> 
				<!--导出--><fmt:message key="global.exportdata" />
			</button>			
	</div>	
   <!-- Tabs -->
	<div id="tabs">	
		<ul>
			<li><a href="#gridd" onclick="tabsChg(1)"><span><fmt:message key='subsidyPay.ButieItem' /></span></a></li>
			<li><a href="#gridd" onclick="tabsChg(2)"><span><fmt:message key='subsidyPay.FreeGrade' /></span></a></li>
		</ul>
		<div id="gridd">
		    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
		</div>		
	</div>
	<!-- 用户操作标题以及放一些快捷按钮-->		
		<div id="buttons" style="100%; float:left;">
			<button type="button" id="order" onclick="openwinO();" style="20%; float:left;">
				<!--组合排序--><fmt:message key="order.title" />
			</button>				
			<button type="button" id="openadd2" onclick="openadd();" style="20%; float:left;" disabled="disabled">
				<!-- 新增 --><fmt:message key="global.add" />
		    </button>		    
			<button type="button" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>
			<button onclick='modQuery();' id='mbquery2'>
				<fmt:message key="oper.mod"/>
			</button>
			<button type="button" id='gjquery2' onclick="openwinQ();" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button type="button" id='savequery2' onclick="openSaveModPan();" disabled="disabled">
				<!--保存本次查询--><fmt:message key="oper.modSave"/>
			</button>
			<button type="button" id="export2" onclick="openExport();" disabled="disabled"> 
			<!--导出--><fmt:message key="global.exportdata" />
			</button>			
	</div>	
</div>


<!-- 添加模板面板 -->
<div id="modT" style="display: none"  class="neirong">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" >功能名称</div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeoMod()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='addquery' name="addquery" onsubmit="return false;" action="#" >
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			
			  	<tr >
				    <td width="12%" align="right" class="labelclass"><label id="nameg_mod"><fmt:message key="oper.modName"/></label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="name_mod" id="name_mod" onpropertychange="TextUtil.NotMax(this)" maxlength="50" class="textclass"/>
				    	<font style="color: #ff0000;">*</font></td>
				    
				    <td width="12%" align="right"  class="labelclass"><label id=''></label></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
					
				     <td width="12%" align="right"  class="labelclass"></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
			 	 </tr>
			</table>
		</form>
		<div class="midd_butt">
		<!-- 保存 --><button class="tsdbutton" id="saveModB" style="width:80px;heigth:27px;" onclick="addQuery();" ><fmt:message key="global.save" /></button>
	 	<!-- 关闭 --><button class="tsdbutton" id="closeModB" style="width:63px;heigth:27px;" onclick="closeoMod();" ><fmt:message key="global.close" /></button>
		</div>
	</div>
</div>

<!-- 添加修改面板 read1 -->
<div class="neirong" id="panTab1" style="display: none">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" >功能名称</div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>
	</div>
		<div class="midd" >
		<form id='operformT1' name="operformT1" onsubmit="return false;" action="#" >
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			
			  <tr>
			    <td width="12%" align="right" class="labelclass"><label id="Xuhaog" ></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<select id="Xuhao"></select>
					<label class="addred" ></label></td>
			   
			    <td width="12%" align="right"  class="labelclass"><label  id="ButieNameg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="ButieName" id="ButieName" onpropertychange="TextUtil.NotMax(this)" maxlength="50" class="textclass"></input>
			    	<label class="addred" ></label></td>
			
			    <td width="12%" align="right"  class="labelclass"><label id="Kemug"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
				  	<select name="Kemu" id="Kemu"  class="textclass">
						<option value="" ><fmt:message key="global.select"/></option>
					</select></td>
			</tr>		  
		  	<tr>
			    <td colspan="6" align="left" bgcolor="#FFFFFF">
			    <!-- 减免字段 -->
			    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
			       		<tr>
			       			<td width="12%" align="right" style="background:#F0F7FB; border-bottom:1px solid #A9C8D9; padding-right:1%;">
			       			<label id="FeeFieldsg" ></label></td>
			        		
			       			<td width="58%" style=" border-bottom:1px solid #A9C8D9;">
				       			<div style="width:550px;height: 150px;overflow-y: scroll;">
					         		<span id="dept">
										<textarea rows="10" cols="40" id='FeeFields' onfocus="getTheDept(); " style="min-height:50px;height:auto;overflow: hidden;"></textarea>	
									</span>
									<span id="thedept" style="display: none;"></span>
								</div>
				   			</td>
			       			<td width="30%" style=" border-bottom:1px solid #A9C8D9;">&nbsp;</td>
			     		</tr>
			    	</table>
			    </td>			  
	    	</tr>
		 	<tr>
			    <td colspan="6" align="left" bgcolor="#FFFFFF">
			    
			    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
			       		<tr>
			       			<td width="12%" align="right" style="background:#F0F7FB; border-bottom:1px solid #A9C8D9; padding-right:1%;">
			       			<label id="ZeroMonthg" ></label></td>
			        
			       			<td width="58%" style=" border-bottom:1px solid #A9C8D9;">
			         		<span id="deptm">
								<textarea rows="6" cols="30" id='ZeroMonth' onfocus="getTheDeptm();" style="min-height:50px;height:auto;overflow: hidden;"></textarea>	
							</span>
							<span id="thedeptm" style="display: none;"></span>
				   			</td>
			       			<td width="30%" style=" border-bottom:1px solid #A9C8D9;">&nbsp;</td>
			     		</tr>
			    	</table>		    	
			    	
			    </td>			  
	    	</tr>
		  
		</table>
		</form>	
		<div class="midd_butt">
		<!-- 查询     --><button class="tsdbutton" id="jdquery1" onclick="QbuildParams();"><fmt:message key="global.query" /></button>		
		<!-- 保存新增 --><button class="tsdbutton" id="readd1" style="width:80px;heigth:27px;" onclick="saveObj(1);" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
	 	<!-- 保存退出 --><button class="tsdbutton" id="save1" style="width:80px;heigth:27px;" onclick="saveObj(2);" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
		<!-- 修改     --><button class="tsdbutton" id="modify1" style="width:63px;heigth:27px;" onclick="modifyObj();"><fmt:message key="global.edit" /></button>		    
	    <!-- 清空     --><button class="tsdbutton" id="clearB1" style="width:63px;heigth:27px;" onclick="clearText('operformT1');" ><fmt:message key="global.clear" /></button>
	    <!-- 取消     --><button class="tsdbutton" id="reset1" style="width:63px;heigth:27px;" onclick="resett();" >取消</button>
		<!-- 关闭 	 --><button class="tsdbutton" id ='closeo1' style="width:63px;heigth:27px;" onclick="closeo();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>


<!-- 添加修改面板  ready2-->
<div class="neirong" id="panTab2" style="display: none">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" >功能名称</div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='operformT2' name="operformT2" onsubmit="return false;" action="#" >
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
							
			  <tr>			   
			    <td width="12%" align="right" class="labelclass"><label id="Free_Codeg" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="Free_Code" id="Free_Code" class="textclass" onpropertychange="TextUtil.NotMax(this)" maxlength="4"></input>							
					<label class="addred" ></label></td>
			   
			    <td width="12%" align="right"  class="labelclass"><label  id="CNameg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="CName" id="CName" class="textclass" onpropertychange="TextUtil.NotMax(this)" maxlength="32"></input>
			    	</td>			
			
			    <td width="12%" align="right"  class="labelclass"><label id="MfTypeg"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
				  	<input type="text" name="MfType" id="MfType" class="textclass" onpropertychange="TextUtil.NotMax(this)" maxlength="10"/>
				  	</td>		  	
				  
			</tr>
			</table>
			<table id='unquery' width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
		  	<tr>		  	
			    <td width="12%" align="right" class="labelclass"><label id="Butie1g"></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="Butie1" id="Butie1" class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="8" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false" /></td>
			   
			    <td width="12%" align="right"  class="labelclass"><label id="BlButie1g"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
					<input type="text" name="BlButie1" id="BlButie1" class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="6" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false"/></td>
								    
			    <td width="12%" align="right"  class="labelclass"><label id="Butie2g"></label></td>
		    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    		<input type="text" name="Butie2" id="Butie2" class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="8" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false" /></td> 		    	
		 	</tr>	
		 	<tr>
			    <td width="12%" align="right" class="labelclass"><label id="BlButie2g"></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="BlButie2" id="BlButie2" class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="6" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false"/></td>
			   
				 <td width="12%" align="right" class="labelclass"><label id="Butie8g"></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="Butie8" id="Butie8" class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="8" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false"/></td>
			   
			    <td width="12%" align="right"  class="labelclass"><label id="BlButie8g"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
					<input type="text" name="BlButie8" id="BlButie8" class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="6" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false"/></td>
							
			</tr>	
		 	<tr>
			    <td width="12%" align="right" class="labelclass"><label id="Butie4g"></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="Butie4" id="Butie4" class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="8" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false" /></td>
			   
			    <td width="12%" align="right"  class="labelclass"><label id="BlButie4g"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
					<input type="text" name="BlButie4" id="BlButie4" class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="6" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false"/></td>
								    
			    <td width="12%" align="right"  class="labelclass"><label id="Butie6g"></label></td>
		    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    		<input type="text" name="Butie6" id="Butie6" class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="8" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false"/></td> 		    	
		 	</tr>
		 	
		 	<tr>
			    <td width="12%" align="right" class="labelclass"><label id="BlButie6g"></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="BlButie6" id="BlButie6" class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="6" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false"/></td>
			   
			    <td width="12%" align="right"  class="labelclass"><label id="Butie7g"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
					<input type="text" name="Butie7" id="Butie7" class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="8" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false"/></td>
								    
			    <td width="12%" align="right"  class="labelclass"><label id="BlButie7g"></label></td>
		    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    		<input type="text" name="BlButie7" id="BlButie7" class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="6" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false"/></td> 		    	
		 	 </tr>
		 	<tr style="display: none;">
		 		<td width="12%" align="right"  class="labelclass"><label id="Butie9g"></label></td>
		    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    		<input type="text" name="Butie9" id="Butie9" class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="8" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false"/>
		    	</td> 		    	
		 	
			    <td width="12%" align="right" class="labelclass"><label id="BlButie9g"></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="BlButie9" id="BlButie9" class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="6" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false"/>
			    </td>
			   
			    <td width="12%" align="right"  class="labelclass"><label id="Butie3g"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
					<input type="text" name="Butie3" id="Butie3" class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="8" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false" />
				</td>
								    
			    <td width="12%" align="right"  class="labelclass"><label id="BlButie3g"></label></td>
		    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    		<input type="text" name="BlButie3" id="BlButie3" class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="6" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false"/>
		    	</td> 		    	
		 		    	
		 	 </tr>
		 
		</table>
		</form>	
		<div class="midd_butt">
		<!-- 查询     --><button class="tsdbutton" id="jdquery2" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
		<!-- 保存新增 --><button class="tsdbutton" id="readd2" style="width:80px;heigth:27px;" onclick="saveObj(1);" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
	 	<!-- 保存退出 --><button class="tsdbutton" id="save2" style="width:80px;heigth:27px;" onclick="saveObj(2);" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
		<!-- 修改     --><button class="tsdbutton" id="modify2" style="width:63px;heigth:27px;" onclick="modifyObj();"><fmt:message key="global.edit" /></button>		    
	    <!-- 清空     --><button class="tsdbutton" id="clearB2" style="width:63px;heigth:27px;" onclick="clearText('operformT1');" ><fmt:message key="global.clear" /></button>
	    <!-- 取消     --><button class="tsdbutton" id="reset2" style="width:63px;heigth:27px;" onclick="resett();" >取消</button>
		<!-- 关闭 	 --><button class="tsdbutton" id='closeo2' style="width:63px;heigth:27px;" onclick="closeo();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>


	<!-- 不动的部分 -->
	<div style="display: none">					
					<input type="hidden" id="addinfo" value="<fmt:message key="global.add"/>" />
					<input type="hidden" id="deleteinfo" value="<fmt:message key="global.delete"/>" />
					<input type="hidden" id="editinfo" value="<fmt:message key="global.edit"/>" />
					<input type="hidden" id="queryinfo" value="<fmt:message key="global.query"/>" />

					<input type="hidden" id="operation" value="<fmt:message key="global.operation"/>" />
					<input type="hidden" id="operationtips" value="<fmt:message key="global.operationtips"/>" />
					<input type="hidden" id="successful" value="<fmt:message key="global.successful"/>" />
					<input type="hidden" id="deleteinformation" value="<fmt:message key="global.deleteinformation"/>" />
					<input type="hidden" id="management" value="<fmt:message key="ip.management"/>" />
					<input type="hidden" id="worninfo" value="<fmt:message key="ip.worn"/>" />
					<input type="hidden" id="worntips" value="<fmt:message key="ip.worntips"/>" />
					<input type="hidden" id="deletepower" value="<fmt:message key="global.deleteright"/>" />
					<input type="hidden" id="editpower" value="<fmt:message key="global.editright"/>" />
					
					<input type="hidden" id="deletefailed" value="<fmt:message key="ip.deletefailed"/>" />
					<input type="hidden" id="selectarea" value="<fmt:message key="ip.select"/>" />
					<input type="hidden" id="inputip" value="<fmt:message key="ip.inputip"/>" />
					<input type="hidden" id="selectarea" value="<fmt:message key="ip.selectarea"/>" />
					<input type="hidden" id="addmemo" value="<fmt:message key="ip.addmemo"/>" />
				
					<input type="hidden" id="userid" value="<%=userid%>"/>
					<input type='hidden' id='thisbasePath' value='<%=basePath%>' /> 
					<!-- 权限 -->
					
					<input type="hidden" id="addright"/>					
					<input type="hidden" id="deleteright"/>
					<input type="hidden" id="editright"/>
					<input type="hidden" id="editfields"/>
					<input type="hidden" id="editfields_son"/>
					<input type="hidden" id="delBright"/>
					<input type="hidden" id="editBright"/>
					<input type="hidden" id="exportright" />
					<input type="hidden" id="printright" />
					
					<!-- 用于写入日志 -->
				   <input type="hidden" id="userloginip" value="<%=Log.getIpAddr(request) %>"/> 
				   <input type="hidden" id="userloginid" value="<%=session.getAttribute("userid") %>"/> 
				   <input type="hidden" id="thislogtime" value="<%=Log.getThisTime() %>" />
				   <!-- 修改时保存原来数据的隐藏域 --> 	
				   <input type="hidden" id="logoldstr" />		
				   <input type="hidden" id="useridd" value="<%=userid %>"/>	
				   	
					<!-- 汇总字段的存放 -->
					<input type="hidden" id="ZeroMonthold" />						
					
					<!-- 国际化保存表字段名 -->	
					<input type="hidden" id="ID1" />					
					<input type="hidden" id="IDD2"/>
					<input type="hidden" id="id3" />					
					<input type="hidden" id="sCode4"/>	
					<input type="hidden" id="TypeNum5"/>	
					<input type="hidden" id="JhjID6"/>
					<input type="hidden" id="id"/>
					<!-- ****日志*** -->	
					<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>'/> 
				   	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' /> 
				  	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' /> 			  
				    <input type='hidden' id='oldh'  /> 				   	
				    <input type='hidden' id='areah'  />
				    <input type="hidden" id="addh"/>
				    <input type="hidden" id="edith"/>
				    <!-- 日志修改操作时，保存旧数据 -->	
				   
				   	<!-- 导航栏 -->	 
				   	<input type='hidden' id='theusergroupid'/> 
				   	<!-- 查询树信息存放 -->
					<input type="hidden" id='treepid' />	
					<input type="hidden" id='treecid' />	
					<input type="hidden" id='treestr' />	
					<input type="hidden" id='treepic' />	
					
					<!-- 高级查询 模板隐藏域 -->
					<input type="hidden" id="queryright"/>
					<input type="hidden" id="queryMright"/>
					<input type="hidden" id="saveQueryMright"/>
					<!-- grid自动 -->
					<input type="hidden" id='ziduansF1' />
					<input type="hidden" id='ziduansF2' />
					<input type='hidden' id='thecolumn'/>	
											
	</div>

		
		

		<!-- 导出数据 -->
			<div class="neirong" id="thefieldsform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">选择您要导出的数据字段</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();">关闭</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd" >
					   <form action="#" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<div id="thelistform" style="margin-left: 10px;max-height: 200px">
								
									</div>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" id="query" onclick="checkedAllFields()">
						全选
					</button>
					<button type="submit" class="tsdbutton" id="query" onclick="saveExoprt();">
						<fmt:message key="global.ok" />
					</button>
					<button type="button" class="tsdbutton" id="closethisinfo" >
						<fmt:message key="global.close" />
					</button>
					
				</div>
		</div>	
		
		
		<input type="hidden" id="whickOper"/>
		<input type="hidden" id="imenuid" value="<%=imenuid%>" />
		<input type="hidden" id="zid" value="<%=zid%>" />
		<%
			if (!languageType.equals("en")) {
				languageType = "zh";
			}
		%>
		<input type="hidden" id="languageType" value="<%=languageType%>" />
</body>
</html>