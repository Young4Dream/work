<%----------------------------------------
	name: KemuDef.jsp
	author: youhongyu
	version: 1.0, 2009-11-26
	description: 定义收费科目
	modify: 
		2010-01-18 更改导出模块 
		2010-01-20 grid字段可控 验证方法
     	2010-01-26 更改grid样式  调整方法顺序
		2009-11-13 youhongyu 移植页面	oracle平台
		2009-11-17 youhongyu 汇总字段可新增 可修改字段 显示方式修改
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="com.tsd.service.util.Log" %>
<%@page import="java.text.SimpleDateFormat"%>
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
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><!-- 定义收费科目 --></title>    
    
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
		
		
<script type="text/javascript">
/**
 * 查看当前用户的扩展权限，对spower字段进行解析
 * @param 
 * @return 
 */
function getUserPower(){
		var urlstr=buildParamsPro('KemuDef.getPower','query');
		 
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
		
		var deleteright = '';
		var editright = '';
		var editfields = '';
		
		var exportright = '';
		var printright ='';
		
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
				
				$("#deleteright").val(str);
				$("#editright").val(str);						
				$("#exportright").val(str);
				$("#printright").val(str);
				
				$("#queryright").val(str);						
				$("#queryMright").val(str);
				$("#saveQueryMright").val(str);
				
				editfields = getFields('kemudef');
				
				flag = true;
		}
		
		if(flag==false){
			var hasadd = addright.split('|');
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



/**
 * 获取被选中的值 
 * @param name ：该复选框的name值
 * @param key  ：个值之间的链接符 ~，+ ，,等
 * @return 返回复选框控件 获取被选中的值 ；其中key为各值之间的链接符，
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
 * 将选中的值赋给指定输入区 
 * @param id 	：该复选框textarea的 id值
 * @param id2	：存放复选框的span的id值
 * @param id3	: 存放textarea的span标签的id值
 * @param name 	:该复选框的name值
 * @param oper 	:各值之间的链接符 ~，+ ，,等
 * @return 
 */
function getCheckValue(id,id2,id3,name,oper){
		$('#'+id).val('');
		$('#'+id).val(getTheChecked(name,oper));
		document.getElementById(id2).style.display = 'none';
		document.getElementById(id3).style.display = '';			
}
/**
 * 汇总字段选项卡，弹出面板中控制汇总字段复选框选中值域的显示
 * @param 
 * @return 
 */			
function opendsss(){
		$("#deptm").attr('style','display:block');	
		$("#thedeptm").attr('style','display:none');
}
/**
 *  显示汇总字段可选值
 * @param 
 * @return 
 */
function getTheDeptm(){
		getDeptNamem();
		$("#deptm").attr('style','display:none');
		$("#thedeptm").attr('style','display:block');
}
/**
 *  初始化汇总字段复选框可选值
 * @param  type ： 1显示全部  2只显示未变使用汇总字段用于新增显示
 * @param  KemuNo :KemuNo
 * @return 
 */
function getformInfom(type,KemuNo){
		$('#thedeptformm').remove();
		
		//将返回的结果集生成一个form出来
		var thevalue='<table width="500" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #dfe0e1; padding:5px; background:#f6f7f8; font-size:12px;margin:5px 0px; ">';
		thevalue +='<tr><td height="35" colspan="3">'+"<input type='button'  id='checkall' onclick=isCheckedAll('deptsm',true); value='<fmt:message key="KemuDef.selectall" />' style='width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;line-height:25px;  margin-left:10px;'><input type='button'  id='uncheckall' onclick=isCheckedAll('deptsm',false); value='<fmt:message key="KemuDef.selectopposite" />' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button'  onclick=getCheckValue('HzFields','thedeptm','deptm','deptsm',',') value='<fmt:message key="KemuDef.sure" />' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button'  onclick=cancelTheOper('deptm','thedeptm') value='<fmt:message key="KemuDef.cancel" />' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'>"+'</td></tr>';
								
		var languageType = $("#languageType").val();
		var urlstr='';
		if(type==1){			
			urlstr=buildParamsSql('query','xmlattr','KemuHzFields.queryByKey','');
		}else if(type==2){
			urlstr=buildParamsSql('query','xmlattr','KemuHzFields.querynotUse','');
		}
		else if(type==3){
			urlstr=buildParamsSql('query','xmlattr','KemuHzFields.BykeyNotUse','');
			urlstr+='&KemuNo='+KemuNo;
		}
		
		$.ajax({
		
			url:'mainServlet.html?'+urlstr,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				/////////////////////////////
				//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
				
				var i=0;
				$(xml).find('row').each(function(){
						//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
						///如果sql语句中指定列名 则按指定名称给参数
						var Field_Name = $(this).attr("Field_Name".toLowerCase());	
						var Field_Alias = $(this).attr("Field_Alias".toLowerCase());
						if(Field_Name!=undefined){										
							//字段国际化							
							var arr = Field_Alias.split("/}");
							if(arr.length==1){}
							else{
								Field_Alias = getCaption(Field_Alias,languageType,'');
							}						
							
							if(i%3==0){
								thevalue +='<tr ><td height="20" width="160px" color="#666666"> '+"<input type='checkbox' name='deptsm' value='"+Field_Name+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+Field_Alias+"</label>"+'</td>';
							}else if(i%3==1){
								thevalue +='<td color="#666666" width="160px"> '+"<input type='checkbox' name='deptsm' value='"+Field_Name+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+Field_Alias+"</label>"+'</td>';
							}									
							else if(i%3==2){
								thevalue +='<td color="#666666" width="160px"> '+"<input type='checkbox' name='deptsm' value='"+Field_Name+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+Field_Alias+"</label>"+'</td></tr>';
							}
							i++;
							//thevalue += "<div style='width:165px;float:left;'><input type='checkbox' name='deptsm' value='"+Field_Name+"' style='width:15px;height:15px;'><label style='text-align: left;line-height: 18px;width:100px'>"+Field_Alias+"</label></div>";
						}
				});//将form填充到那个span中
				
			}			
		});		
		thevalue +='</table>';	
		$('#thedeptm').html(thevalue);	
}


/**
 *  在对用户信息进行修改的时候将用户以前的值默认为选中状态
 	汇总字段
 * @param 
 * @return 
 */
function getDeptNamem(){
		
		//这个是在对用户信息进行修改的时候将用户以前的值默认为选中状态		
			var thestavalue = $('#HzFields').val();
			forChecked('deptsm',thestavalue,',');			
}	
/**
 * 初始化汇总字段复选框
 * @param 
 * @return 
 */
function getHzFields(){

		var fnameA=[];
		var faliasA=[];
		var languageType = $("#languageType").val();
		var urlstr=buildParamsSql('query','xmlattr','KemuHzFields.queryByKey','');
		$.ajax({
		
			url:'mainServlet.html?'+urlstr,
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
					var Field_Name = $(this).attr("Field_Name".toLowerCase());
					fnameA.push(Field_Name);	
					
					var Field_Alias = $(this).attr("Field_Alias".toLowerCase());
					//字段国际化
					
					var arr = Field_Alias.split("/}");
					if(arr.length==1){}
					else{
						Field_Alias = getCaption(Field_Alias,languageType,'');
					}
						faliasA.push(Field_Alias);	
					
				});
			}
		});
		
		var fnameASize = fnameA.length;
		for(j=0;j<fnameASize;j++)
		{
			$("#HzFields").append("<p><input  style=\"width:20px;height:20px;\" type=\"checkbox\" name=\"checkbox"+j+ "\" id=\"checkbox"+j+"\" value=\"" + fnameA[j] + "\" /><span id=\"span"+j+"\"> "+ faliasA[j]+"</span></p>");
		}
}
</script>
<script type="text/javascript">

var closeflash = false;//用于判断添加操作是保存新增，或保存退出。保存新增closeflash=true ；保存退出=false

/**
* 页面初始化
* @param 
* @return 
*/
jQuery(document).ready(function () {

			//页面头部 用于显示当前所在位置
			//getNavit();
			$("#navBar").append(genNavv());
			
			// 取得当前用户的权限  
			getUserPower();
			
			var addright = $("#addright").val();
			var delBright = $("#delBright").val();
			var editBright = $("#editBright").val();
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
			
			//getHzFields();
			//getformInfom(1);
			//对jgGrid的操作符进行国际化
			var opr = $("#operation").val();
			//获取数据表对应字段国际化信息			

			var column  = '';
			var thisdata = loadData('kemudef','<%=languageType %>',1);
			column = thisdata.FieldName.join(',');			 					
			$('#thecolumn').val(column);
			
			var Bzg = thisdata.getFieldAliasByFieldName('Bz');
			var HzFieldsg = thisdata.getFieldAliasByFieldName('HzFields');
			var Kemug = thisdata.getFieldAliasByFieldName('Kemu');
			var KemuNog = thisdata.getFieldAliasByFieldName('KemuNo');
			
			var col=[[],[]];
			col=getRb_Field('kemudef','KemuNo',"<fmt:message key='KemuDef.modifydeletedetail' />",'97','ziduansF');//得到jqGrid要显示的字段
			var column = $("#ziduansF").val();
			
			//给页面中存储字段的隐藏标签赋值			
			$("#Bzg").html(Bzg);
			$("#HzFieldsg").html(HzFieldsg);
			$("#Kemug").html(Kemug);
			$("#KemuNog").html(KemuNog);
			
			var navv = document.location.search;
			var infoo = decodeURIComponent(parseUrl(navv,"imenuname",""));
			
			//设置命令参数			
			var urlstr=buildParamsSql('query','xml','KemuDef.query','KemuDef.querypage');
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
				       	sortname: 'KemuNo', //默认排序字段
				       	viewrecords: true, 
				       	//hidegrid: false, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:infoo, 
				       	shrinkToFit: false,
		       			width:document.documentElement.clientWidth-30,
		       			height:document.documentElement.clientHeight-185, //高
				       	loadComplete:function(){
										$("#editgrid").setSelection('0', true);
										$("#editgrid").focus();
										///自动适应 工作空间
										//var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
										//setAutoGridHeight("editgrid",reduceHeight);
										//setAutoGridWidth("editgrid",'0');
								
										var editinfo = $("#editinfo").val();
										var deleteinfo = $("#deleteinfo").val();
										addRowOperBtnimage('editgrid','openRowModify','KemuNo','click',1,"style/images/public/ltubiao_01.gif",editinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
										addRowOperBtnimage('editgrid','deleteRow','KemuNo','click',2,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
										addRowOperBtnimage('editgrid','openRowInfo','KemuNo','click',3,'style/images/public/ltubiao_03.gif',"<fmt:message key='KemuDef.detail' />","&nbsp;&nbsp;&nbsp;");//详细
											
										/*********定义需要的行链接按钮************
										////@1  表格的id
										////@2  链接名称
										////@3  链接地址或者函数名称
										////@4  行主键列的名称 可以是隐藏列
										////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
										////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	
										
										addRowOperBtn('editgrid',editinfo,'openRowModify','KemuNo','click',1);
										addRowOperBtn('editgrid',deleteinfo,'deleteRow','KemuNo','click',2);
										*/
									   /****执行行按钮添加********
										*@1 表格ID
										*@2 操作按钮数量 等于定义数量
										*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
										executeAddBtn('editgrid',3);
										},
										ondblClickRow: function(ids) {
												if(ids != null) {
													var KemuNo =$("#editgrid").getCell(ids,"KemuNo");
													openRowInfo(KemuNo);
												}
										}										
				}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
});


/**
 * 对jqgrid面板查看明细按钮，可查看详细信息
 * @param key 查询该条记录的参数
 * @return 
 */
function openRowInfo(key){
		opendsss();	//关闭复选框面板
		markTable(1);//显示红色*号	
		//设置编辑框的标题
		$(".top_03").html("<fmt:message key='KemuDef.detailmessage' />");//标题	
	 	//将修改面板的输入框全部	置为不可用		
		isDisabledN('kemudef','',''); 
		clearText('operformT1');
		queryByID(key);//设置修改面板中的值
		openpan(0);				
}

/**
 * 判断科目是否已经存在
 * @param Kemu 收费科目
  * @param KemuNo 收费科目id
 * @return 
 */
function queryByKemu(Kemu,KemuNo){
		var flag = true;
				var Kemuh =Kemu;
				//$("#Kemu").val();
				var urlstr=buildParamsSql('query','xmlattr','KemuDef.queryBykemu','');
		
		$.ajax({				
			url:'mainServlet.html?'+urlstr+'&Kemu='+tsd.encodeURIComponent(Kemu)+'&KemuNo='+tsd.encodeURIComponent(KemuNo),
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
					var Kemu = $(this).attr("Kemu".toLowerCase());	
						if(Kemuh==Kemu){
							flag=false;
						}
				});
			}
		});
		return flag;
}
		

/**
 * 从数据库中查找出该记录的详细信息，显示在详细面板中
 * @param key 收费科目id 
 * @return 
 */
function queryByID(key){
  		 	$("#KemuNo").val(key)
			var flag = true;
			//var KemuNoh =$("#KemuNo").val()
			var urlstr=buildParamsSql('query','xmlattr','KemuDef.queryByKey','');
			$.ajax({				
					url:'mainServlet.html?'+urlstr+'&KemuNo='+key,
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
							
								var KemuNo = $(this).attr("KemuNo".toLowerCase());	
								if(key==KemuNo){
									flag=false;
								}
								oldstr.push(KemuNo);						
								$("#KemuNo").val(KemuNo);
								
								var Kemu = $(this).attr("Kemu".toLowerCase());
								oldstr.push(Kemu);	
								$("#Kemu").val(Kemu);
								
								var HzFields = $(this).attr("HzFields".toLowerCase());
								$("#HzFieldsNO").val(HzFields);
								$("#HzFields").val(HzFields);
								
								var Bz = $(this).attr("Bz".toLowerCase());
								oldstr.push(Bz);	
								$("#Bz").val(Bz);
								
								$("#logoldstr").val(oldstr);
						});
					}
			});	
			return flag;
}
/**
 * 添加面板中保存新增、保存退出按钮操作
 * @param saves 判断保存类型 1：保存新增 ；2保存退出
 * @return 
 */
function saveObj(saves){

		/***************************
		*     判断完成，进行保存操作   *
		***************************/
		//用于存放数据库取出的汇总字段信息
			
		var params=buildParams();
		if(params==false){return false;}
	
		var KemuNo= $("#KemuNo").val();
		var Kemu= delTrim($("#Kemu").val());
				
		//判断科目名称是否已经存在
		var flagKemu = queryByKemu(Kemu,KemuNo);
		if(flagKemu==false){
			var Kemug=$("#Kemug").text();
			alert(Kemug+"<fmt:message key='tariff.isExist'/>");
			$("#Kemu").focus();
			return false;
		}
				
		var urlstr=buildParamsSql('exe','xml','KemuDef.save','');
		
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
				//var imenuname =$("#imenuname").val();
				var HFform =$("#HzFields").val();
				var str ="(KemuDef)<fmt:message key='global.add'/>。"+$("#KemuNog").html()+": "+$("#KemuNo").val()+";"+$("#Kemug").html()+": "+$("#Kemu").val()+";"+$("#HzFieldsg").html()+": "+HFform+";"+$("#Bzg").html()+": "+$("#Bz").val();
				writeLogInfo("","add",tsd.encodeURIComponent(str));	
				
					if(saves==2){
						fuheQuery();
						//querylist();
						setTimeout($.unblockUI, 15);
					}else{
						closeflash=true;//表示关闭时需要刷新
						clearText('operformT1');
						$('#KemuNo').val('00');
					}	
				}
			}
		});	
}


 /**
 * 修改面板中，修改按钮操作
 * @param
 * @return 
 */
function modifyObj(){
		 var params = buildParams();
		 if(params==false){return false;}		
		 
		 //判断科目名称是否已经存在
		 var Kemu = delTrim($("#Kemu").val());
		 var KemuNo = $("#KemuNo").val();
	
		/*************************
					 var flagKemu = queryByKemu(Kemu,KemuNo);
						if(flagKemu==false){
							var operationtips = $("#operationtips").val();
							//套餐类型和费用名称的组合已经存在，请重新输入！
							var Kemug=$("#Kemug").text();
							jAlert(Kemug+"<fmt:message key='tariff.isExist'/>",operationtips);
							
							$("#Kemu").focus();
							return false;
						}
		*******************************/
				
	 	var urlstr=buildParamsSql('exe','xml','KemuDef.modify','');
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
					var logoldstr = $("#logoldstr").val();	
					var oldstr = logoldstr.split(',');
					//写入日志
					var HFform =$("#HzFields").val();
					var HFno =$("#HzFieldsNO").val();
					var str ="(KemuDef)<fmt:message key='global.edit'/>。"+$("#KemuNog").html()+": "+oldstr[0]+";"+$("#Kemug").html()+": "+oldstr[1]+";"+$("#HzFieldsg").html()+": "+HFno+">>>"+HFform+";"+$("#Bzg").html()+": "+oldstr[2]+">>>"+$("#Bz").val();
					writeLogInfo("","modify",tsd.encodeURIComponent(str));				
					fuheQuery();
				}	
			}
		});
} 
			


/**
 * jqgrid面板中，删除按钮操作
 * @param key 收费科目id
 * @return 
 */
function deleteRow(key){
 	 	/**************************
	 	*    是否有执行删除的权限    *
	 	*************************/
		var deleteright = $("#deleteright").val();
		if(deleteright=="true"){
				queryByID(key);	
			 	var deleteinformation = $("#deleteinformation").val();
				var operationtips = $("#operationtips").val();
			 	jConfirm(deleteinformation,operationtips,function(x){
			 		if(x==true){				 		 	 
							var urlstr1=buildParamsSql('exe','xml','KemuDef.delete','');
							var urlstr='mainServlet.html?'+urlstr1+'&KemuNo='+key; 
							$.ajax({
									url:urlstr,
									cache:false,//如果值变化可能性比较大 一定要将缓存设成false
									timeout: 1000,
									async: false ,//同步方式
									success:function(msg){
										if(msg=="true"){
											var operationtips = $("#operationtips").val();
											var successful = $("#successful").val();
											alert(successful);
											
											
											//写入日志操作
											var logoldstr = $("#logoldstr").val();	
											var oldstr = logoldstr.split(',');
											var HFno=$("#HzFieldsNO").val();
											var str ="(KemuDef)<fmt:message key='global.delete'/>。"+$("#KemuNog").html()+": "+oldstr[0]+";"+$("#Kemug").html()+": "+oldstr[1]+";"+$("#HzFieldsg").html()+": "+HFno+";"+$("#Bzg").html()+": "+oldstr[2];
											writeLogInfo("","delete",tsd.encodeURIComponent(str));
											fuheQuery();				
										}	
									}
							});
					}
				});
		}
		else{					
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
		fuheQuery();
}

/**
 * 重新加载jqgrid
 * @param 
 * @return 
 */
function querylist(key)
{
		$("#fusearchsql").val("");
			
		//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
	 	var urlstr1=buildParamsSql('query','xml','KemuDef.query','KemuDef.querypage');	
	 	var link = urlstr1;	
	 	var column = $("#ziduansF").val();
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
	 	setTimeout($.unblockUI, 15);//关闭面板
	 	closeo();			
}



/**
 * 复合查询操作
 * @param 
 * @return 
 */
function fuheQuery()
{
		var params = fuheQbuildParams();			
		if(params=='&fusearchsql='){
			params +='1=1';
		}	
		
		//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
	 	var urlstr1=buildParamsSql('query','xml','KemuDef.fuheQueryByWhere','KemuDef.fuheQueryByWherepage');	
	 	var link = urlstr1 + params;	
	 	var column = $("#ziduansF").val();
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
		setTimeout($.unblockUI, 15);
		closeo();
}


/**
 * 组合排序
 * @param 
 * @return 
 */
function zhOrderExe(sqlstr){
		var params = fuheQbuildParams();			
		if(params=='&fusearchsql='){
			params +='1=1';
		}
		params =params+'&orderby='+sqlstr;	
		
		//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
	 	var urlstr1=buildParamsSql('query','xml','KemuDef.queryByOrder','KemuDef.queryByOrderpage');
	 	var link = urlstr1 + params;
	 	var column = $("#ziduansF").val();	
		$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
}


/**
 * 打开简单查询面板  
 * @param 
 * @return 
 */
function openQuery(){
		opendsss();//关闭汇总字段面板
		markTable(1);	//隐藏红色*号	 	
	 	removeDisabledN('kemudef','','');
	 	$(".top_03").html('<fmt:message key="global.query" />');//标题		
	 	openpan(1);
		$('#jdquery').show();
		clearText('operformT1');
		$('#KemuNo').val('00');
}
 

 /**
 * 打开添加面板  
 * @param 
 * @return 
 */
function openadd(){
		opendsss();
	 	markTable(0);//显示红色*号
	 	$(".top_03").html('<fmt:message key="global.add" />');//标题		 	
	 	removeDisabledN('kemudef','','');		 				
		openpan(2);
		$("#save").show();
	 	$("#readd").show();
		clearText('operformT1');
		$('#KemuNo').val('00');
}	

 /**
 * jqgrid上修改按钮操作 ，打开修改面板并加载将要修改的数据
 * @param key 查询该条记录的参数
 * @return 
 */
function openRowModify(key){			
		var editright = $("#editright").val();
		if(editright=="true"){
				opendsss();	
				markTable(0);//显示红色*号
				var editinfo = $("#editinfo").val();
			 	$(".top_03").html(editinfo);//设置编辑框的标题
			 	isDisabledN('kemudef','',''); 
				openpan(3,key);
				$("#modify").show();$("#reset").show();
				clearText('operformT1');	
						
				queryByID(key);//设置修改面板中的值
				setTableFields();
				/**************
				var logoldstr = $("#logoldstr").val();
				var oldstr = logoldstr.split(',');
				
				$("#KemuNo").val(oldstr[0]);
				$("#Kemu").val(oldstr[1]);
				$("#HzFields").val($("#HzFieldsNO").val());
				$("#Bz").val(oldstr[2]);
				******************/
				//设置不可修改字段的样式
				//$("#KemuNo").attr("disabled","disabled");				
				$('#Kemu').attr("disabled","disabled");
				$("#Kemu").removeClass();
				$("#Kemu").addClass("textclass2");			
				
				getTheChecked('deptsm',',');
				//var ss =$("#HzFieldsNO").val();
				//markCheckBox(ss);
		}
		else{
				var operationtips = $("#operationtips").val();
				var editpower = $("#editpower").val();
				jAlert(editpower,operationtips);
		}		
}


 /**
 * 根据简单查询输入条件进行简单查询
 * @param  
 * @return 
 */
 function QbuildParams(){
 
	 	//var KemuNo = strtrimB($("#KemuNo").val());
	 	var Kemu = delTrim($("#Kemu").val());
	 	var HzFields = delTrim($("#HzFields").val());
	 	var Bz = delTrim($("#Bz").val());	
	 	
		var paramsStr='';
	 	if(Kemu!=''){
	 	 	paramsStr+=" Kemu like '%"+Kemu+"%' ";
	 	}
	 	if(HzFields!=''&&paramsStr!=''){
	 		paramsStr+="and HzFields like '%"+HzFields+"%' " ;
	 	}
	 	else if(HzFields!=''&&paramsStr==''){
	 		paramsStr+=" HzFields like '%"+HzFields+"%' " ;
	 	}
	 	if(Bz!=''&&paramsStr!=''){
	 		paramsStr+="and Bz like '%"+Bz+"%' " ;
	 	}
	 	else if(Bz!=''&&paramsStr==''){
	 		paramsStr+=" Bz like '%"+Bz+"%' " ;
	 	}		 	
	 	$("#fusearchsql").val(paramsStr);
	 	fuheQuery();			
 }


  
 /**
 * 添加、修改面板，通过表单值构造数据操作参数 请根据业务参数的多少和属性进行修改
 * @param 
 * @return 
 */
 function buildParams(){
	 	//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;				
	 	var params='';
		
	 	var KemuNo = delTrim($("#KemuNo").val());
	 	var Kemu = delTrim($("#Kemu").val());
	 	var HzFields = delTrim($("#HzFields").val());
	 	var Bz = delTrim($("#Bz").val());
	 	var operationtips = $("#operationtips").val(); 	
	 	params+="&KemuNo="+KemuNo;
		/*****************
		if(KemuNo!=null&&KemuNo!=""){
	 		if(checkNum(KemuNo)){
	 			params+="&KemuNo="+KemuNo;
	 		}
	 		else{
	 			//科目序号请输入整数！
	 			
	 			jAlert($("#KemuNog").text()+"<fmt:message key='tariff.input'/><fmt:message key='tariff.int'/>",operationtips);
	 			$("#KemuNo").focus();
	 			return false;
	 		}
	 	}	
			else{	
				//请输入科目序号!
				var KemuNog=$("#KemuNog").text();
				var str = "<fmt:message key='tariff.input'/>" + KemuNog;
				
				jAlert(str,operationtips);
				$("#KemuNo").focus();
				return false;
			} 
		******************/	
		 //如果有可能值是汉字 请使用encodeURI()函数转码
		 
		if(Kemu!=null&&Kemu!=""){
				params+="&Kemu="+tsd.encodeURIComponent(Kemu);
		}
	 	else{	
	 			// 请输入费用名称! 
				//jAlert("<fmt:message key='tariff.input'/>"+$("#Kemug").text(),operationtips);
				alert("<fmt:message key='tariff.input'/>"+$("#Kemug").text());
				$("#Kemu").focus();
				return false;
		}			
		params+="&HzFields="+HzFields;
		params+="&Bz="+tsd.encodeURIComponent(Bz);
			
		//每次拼接参数必须添加此判断
		if(tsd.Qualified()==false){return false;}
		return params;
 }
  /**
 * 高级查询参数获取
 * @param 
 * @return 
 */
function fuheQbuildParams(){
	 	//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
	 	var params='';
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
		var editfields = $("#editfields").val();
									
		// 将当前表的所有字段取出来，分割字符串
		var fields = getFields("kemudef");														
		var fieldarr = fields.split(",");
		
		// 将当前表中的spower字段取出来 
		var spower = editfields.split(",");
		
		//考虑字段大小写问题	
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
						$("#"+arr[i]).removeClass();
						$("#"+arr[i]).addClass("textclass");												
						break;
					}
				}
				
			}
		}	
}
</script>

<script type="text/javascript">
 /**
 * 关闭表格面板
 * @param 
 * @return 
 */
function closeo(){
		if(closeflash){
		 		 closeflash=false;
		 		 querylist(0);	
		 }
		clearText('operformT1');
		setTimeout($.unblockUI, 15);//关闭面板
		/*
		**弹出样式改变
		document.getElementById("zong").style.display="";//按钮和grid显示
		document.getElementById("d2back").style.display="";//返回按纽显示	
		document.getElementById("pan").style.display="none";//隐藏字段添加表单	
		*/
}



 /**
 * 打开表格面板
 * @param type: 控制打开面板 汇总字段的显示信息
 * @param KemuNo:KemuNo
 * @return 
 */
function openpan(type,KemuNo){
		/*
		**弹出样式改变
		document.getElementById("d2back").style.display="none";//返回按纽隐藏	
		document.getElementById("zong").style.display="none";//按钮和grid隐藏
		document.getElementById("pan").style.display="";//显示字段添加表单	
		*/
		if(type==1||type==2){
			getformInfom(type);
		}else if(type==3){
			getformInfom(type,KemuNo);
		}
		
		autoBlockFormAndSetWH('pan',60,5,'closeo',"#ffffff",true,1000,'');//弹出查询面板	
		$("#jdquery").hide();$("#modifyB").hide();$("#readd").hide();$("#save").hide();$("#modify").hide();$("#reset").hide();$("#clearB").hide();
}



 /**
 * 修改面板的取消按钮操作
 * @param 
 * @return 
 */
function resett(){
		var key=$("#KemuNo").val();
		queryByID(key);
}	
</script>

<script type="text/javascript">
	/**
	 *初始化设置资费设置jqgrid头部导航条
	 * @param
	 * @return 
	 */
	jQuery(document).ready(function(){
			//获取系统语言标识
			var languageType = $("#languageType").val();
			//获取本菜单id
			var imenuid = $('#imenuid').val();
			//获取组信息
			var groupid = $('#zid').val();
			//获取菜单并解析
			//getTariffBar(languageType,imenuid,'NetName.getNavigator',groupid);
	});
	
</script>
</head>

<style type="text/css"> 
 	.style1 {
		background-color:#A9C3E8;
		padding: 4px;		
	}
	#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
	cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
	.a{border:1px solid #ccc;width:500px;overflow:left;text-overflow:ellipsis;}
</style> 
  <body>   
  <form name="childform" id="childform">
  <input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
  <input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>

  </form>
  		<!-- 用户操作导航-->
		<div id="navBar1">
			<table width="100%" height="26px">
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
		<div id="buttons">
			<button type="button" id="order1" onclick="openDiaO('kemudef');">
				<!--组合排序--><fmt:message key="order.title" />
			</button>
			<button type="button" id="openadd1" onclick="openadd();" disabled="disabled">
				<!-- 新增 --><fmt:message key="global.add" />
		    </button>		  
			 <button type="button" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>
			<button id='mbquery1' onclick='openQueryM(1);'>
				<!--模板查询--><fmt:message key="oper.mod"/>
			</button>
			<button id='gjquery1' onclick="openDiaQueryG('query','kemudef');" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button id='savequery1' onclick="openModT();" disabled="disabled">
				<!--保存本次查询--><fmt:message key="oper.modSave"/>
			</button>	
			<button type="button" id="export1" onclick="thisDownLoad('tsdBilling','mssql','kemudef','<%=languageType %>')"
			 disabled="disabled"> 
				<!--导出--><fmt:message key="global.exportdata" />
			</button>		
		</div>	
    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
	<div id="pagered" class="scroll" style="text-align: left;"></div>
	<!-- 用户操作标题以及放一些快捷按钮-->		
		<div id="buttons">
			<button type="button" id="order2" onclick="openDiaO('kemudef');">
				<!--组合排序--><fmt:message key="order.title" />
			</button>		
			<button type="button" id="openadd2" onclick="openadd();" disabled="disabled">
				<!-- 新增 --><fmt:message key="global.add" />
		    </button>
		    <button type="button" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>
			<button id='mbquery2' onclick='openQueryM(1);' >
				<!--模板查询--><fmt:message key="oper.mod"/>
			</button>
			<button id='gjquery2' onclick="openDiaQueryG('query','kemudef');" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button id='savequery2' onclick="openModT();" disabled="disabled">
				<!--保存本次查询--><fmt:message key="oper.modSave"/>
			</button>			
			<button type="button" id="export2" onclick="thisDownLoad('tsdBilling','mssql','kemudef','<%=languageType %>')"
			 disabled="disabled"> 
				<!--导出--><fmt:message key="global.exportdata" />
			</button>					
		</div>	
	</div>
	

<!-- 添加修改面板 -->
<div class="neirong" id="pan" style="display: none">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="KemuDef.functionname" /></div>
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
			    <td width="12%" align="right" class="labelclass"><label id="Kemug" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="Kemu" id="Kemu" onpropertychange="TextUtil.NotMax(this)" maxlength="20" class="textclass"></input>	
			    	<label class="addred" ></label></td>						
					
			    <td width="12%" align="right" class="labelclass"><label id="Bzg"></label></td>
			    <td width="54%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="Bz" id="Bz" onpropertychange="TextUtil.NotMax(this)" maxlength="100" class="textclass "></input></td>			    
			</tr>
			<tr>
			    <td colspan="4" align="left" bgcolor="#FFFFFF">			    	
			    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
			       		<tr>
			       			<td width="12%" align="right" style="background:#F0F7FB; border-bottom:1px solid #A9C8D9; padding-right:1%;">
			       			<label id="HzFieldsg" ></label></td>
			        
			       			<td width="58%" align="left" style=" border-bottom:1px solid #A9C8D9;">
			       			<div style="width:550px;height: 150px;overflow-y: scroll;">
			         		<span id="deptm">
			         			<textarea rows="10" cols="20" id='HzFields' onfocus="getTheDeptm();" style="width: 490px;wmin-height:50px;height:auto;overflow: hidden;" ></textarea> 
							</span>
							<span id="thedeptm" style="display: none;" ></span>
							</div>
				   			</td>
			       			<td width="30%" style=" border-bottom:1px solid #A9C8D9;">&nbsp;</td>
			       			
			     		</tr>
			    	</table>
			    	
			    	
			    </td>			  
	    	</tr>		  		  
		</table>
				<span id="KemuNog" style="display: none"></span>
				<input type="text" name="KemuNo" id="KemuNo" style="display: none"/>
		</form>	
		<div class="midd_butt">
		<!-- 查询     --><button class="tsdbutton" id="jdquery" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
		<!-- 批量修改 --><button class="tsdbutton" id="modifyB" style="width:80px;heigth:27px;" onclick="fuheModify();"><fmt:message key="tariff.modifyb" /></button>
		<!-- 保存新增 --><button class="tsdbutton" id="readd" style="width:80px;heigth:27px;" onclick="saveObj(1);" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
	 	<!-- 保存退出 --><button class="tsdbutton" id="save" style="width:80px;heigth:27px;" onclick="saveObj(2);" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
		<!-- 修改     --><button class="tsdbutton" id="modify" style="width:63px;heigth:27px;" onclick="modifyObj();"><fmt:message key="global.edit" /></button>		    
	    <!-- 清空     --><button class="tsdbutton" id="clearB" style="width:63px;heigth:27px;" onclick="clearText('operformT1');" ><fmt:message key="global.clear" /></button>
	    <!-- 取消     --><button class="tsdbutton" id="reset" style="width:63px;heigth:27px;" onclick="resett();" ><fmt:message key="KemuDef.cancel" /></button>
		<!-- 关闭 	 --><button class="tsdbutton" id="closeo" style="width:63px;heigth:27px;" onclick="closeo();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>



<!-- 添加模板面板 -->
<div id="modT" style="display: none" class="neirong">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="KemuDef.functionname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeoMod()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='addquery' name="addquery" onsubmit="return false;" action="#" >
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
						
			  	<tr>
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
		<!-- 保存 --><button class="tsdbutton" id="saveModB" style="width:80px;heigth:27px;" onclick="saveModQuery(1);" ><fmt:message key="global.save" /></button>
	 	<!-- 关闭 --><button class="tsdbutton" id="closeModB" style="width:63px;heigth:27px;" onclick="closeoMod();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>				
	
		<div id="inputs">		
			<div style="display: none">					
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
					
					<input type="hidden" id="addright"/>
					<input type="hidden" id="deleteright"/>
					<input type="hidden" id="editright"/>
					<input type="hidden" id="editfields"/>
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
					<input type="hidden" id="imenuname" value="<%=imenuname %>"/>	
					<!-- 汇总字段的存放 -->
					<input type="hidden" id="HzFieldsform" />	
					<input type="hidden" id="HzFieldsNO" />	
					
					<input type="hidden" id="spanA" />	
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
					<input type="hidden" id='ziduansF' />
					<input type='hidden' id='thecolumn'/>					
				</div>	
	</div>



		
		<!-- 导出数据 -->
			<div class="neirong" id="thefieldsform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv"><fmt:message key="KemuDef.chooseexportdata" /></div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();"><fmt:message key="KemuDef.close" /></a></div>
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
					<button type="submit" class="tsdbutton" id="query" onclick="checkedAllFields();">
						<fmt:message key="KemuDef.selectall" />
					</button>
					<button type="submit" class="tsdbutton" id="query" onclick="getTheCheckedFields('tsdBilling','mssql','kemudef');">
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
