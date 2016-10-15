<%----------------------------------------
	name: nums.jsp
	author: fulingqiao
	version: 1.0, fulingqiao
	description: 号码资源 Number of resources
	modify: 
		2010-10-26 sunlin oracle移植
		2010-11-5 sunlin 添加注释功能	
		2010-11-16 youhongyu 修改生产号码，批量生产号码实现方式	
		2010-12-10 号码资料设置下的第二选项卡的详细查询面板按钮错误
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@page import="com.tsd.service.util.Log" %>
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
    <title>rates management</title><!--定义中继局向组-->
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
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css"
			type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css"
			type="text/css" media="projection, screen" />
		
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
		<style type="text/css">
			#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
			cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
		</style>
		<style type="text/css"> 
		 .style1 {
			background-color:#A9C3E8;
			padding: 4px;		
			}
		</style>
		
		
		
		<!-- 二级分析卡 样式-->
		<style type="text/css"> 
		.twosclass {
		font-size:15px; font-weight:bolder; margin-left:3px; font-family:黑体;
		}
		</style>
			
	<style type="text/css">
		hr {border:1px #A9C8D9 dotted;}
		.tdstyle{border-bottom:1px solid #A9C8D9;}
	</style>
		<script type="text/javascript">
			/**
			 * 查看当前用户的扩展权限，对spower字段进行解析
			 * @param 无参数
			 * @return 无返回值
			 */
			function getUserPower(){
				 var urlstr=buildParamsPro("nums.getPower","query");
				
				/************************
				*   调用存储过程需要的参数 *
				**********************/
				var userid = $('#userid').val();	
				var groupid = $('#zid').val();
				var imenuid = $('#imenuid').val();
				
				/****************
				*   拼接权限参数 *
				**************/
				
				var addright = '';
				var delBright = '';
				var editBright = '';
				var addBright='';
				var deleteright = '';
				var editright = '';
				var editfield1 = '';
				var editfield2 = '';
				var editfield3 = '';
				var editfield4 = '';
				var editfield5 = '';
				
				var exportright = '';
				var printright ='';
				var allnumsright='';
				var numsright='';
				
				var queryright = '';	
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
							addBright += getCaption(spowerarr[i],'addB','')+'|';
							
							delBright += getCaption(spowerarr[i],'delB','')+'|';
							
							editBright += getCaption(spowerarr[i],'editB','')+'|';	
														
							deleteright += getCaption(spowerarr[i],'delete','')+'|';
							
							editright += getCaption(spowerarr[i],'edit','')+'|';	
							
							editfield1 += getCaption(spowerarr[i],'editfields','');
							editfield2 += getCaption(spowerarr[i],'editfields2','');
							editfield3 += getCaption(spowerarr[i],'editfields3','');
							editfield4 += getCaption(spowerarr[i],'editfields4','');
							editfield5 += getCaption(spowerarr[i],'editfields5','');
							
							exportright += getCaption(spowerarr[i],'export','')+'|';
							
							printright += getCaption(spowerarr[i],'print','')+'|';
							allnumsright += getCaption(spowerarr[i],'yieldAllnums','')+'|';	
							
							numsright += getCaption(spowerarr[i],'yieldnums','')+'|';	
							queryright += getCaption(spowerarr[i],'query','')+'|';
							
							saveQueryMright += getCaption(spowerarr[i],'saveQueryM','')+'|';
						}
				}else if(spower=='all@'){
					
						$("#addright").val(str);
						$("#delBright").val(str);
						$("#editBright").val(str);
						$("#addBright").val(str);
						$("#deleteright").val(str);
						$("#editright").val(str);
						
						$("#exportright").val(str);
						$("#printright").val(str);
						$("#allnumsright").val(str);
						$("#numsright").val(str);
						$("#queryright").val(str);	
						$("#saveQueryMright").val(str);
						editfield1 = getFields('hmzy');
						editfield2 = getFields('hmzy_detail');
						editfield3 = getFields('ywsl_hmlevel');
						editfield4 = getFields('hmzy_detail');
						editfield5 = getFields('mokuaiju2');
						
						flag = true;
				}
				
				if(flag==false){
					var hasadd = addright.split('|');
					var hasaddB = addBright.split('|');
					var hasdelB = delBright.split('|');
					var haseditB = editBright.split('|');
					var hasdelete = deleteright.split('|');
					var hasedit = editright.split('|');
					var hasexport = exportright.split('|');
					var hasprint = printright.split('|');
					var allnumsrights = allnumsright.split('|');
					var numsrights = numsright.split('|');
					
					var hasquery = queryright.split('|');
					var hassaveQueryM = saveQueryMright.split('|');
					for(var i = 0;i<hasquery.length;i++){
						if(hasquery[i]=='true'){
							$("#queryright").val(str);
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
					for(var i = 0;i<hasaddB.length;i++){
						if(hasaddB[i]=='true'){
							$("#addBright").val(str);
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
					for(var i = 0;i<allnumsrights.length;i++){
						if(allnumsrights[i]=='true'){
							$("#allnumsright").val(str);
							break;
						}
					}
					for(var i = 0;i<numsrights.length;i++){
						if(numsrights[i]=='true'){
							$("#numsright").val(str);
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
				$("#editfield1").val(editfield1);
				$("#editfield2").val(editfield2);
				$("#editfield3").val(editfield3);
				$("#editfield4").val(editfield4);
				$("#editfield5").val(editfield5);
			}
		</script>
		<script type="text/javascript">
			
			 var tabStatus=11;//选项卡的状态
			 var closeflash=false;//关闭时是否刷新的标志,false,不用刷新;
  						//true，需要刷新
			/**
			 * 分项卡触发的状态事件
			 * @param id
			 * @return 无返回值
			 */
			function tabsChg(id)
			{		
				$("#fusearchsql").val("");
				switch(id)
				{
					case 11://号码资源设置>>>号码分配
						tabStatus=11;
						break;
					case 12://号码资源设置>>>号码资源明细
						tabStatus=12;
						break;
					case 13://号码资源设置>>>号码资源设置
						tabStatus=13;
						break;
					case 21://号码资源>>>号码资源调整
						tabStatus=21;
						break;
					case 22://号码资源>>>号码资源二级模块域调整
						tabStatus=22;
						break;					
				}	
				generateGrid(id);
				buttonchange();
				fenyeUtil();	
			}
			
			
	/**
	 * 页面上高级查询、批量修改、批量删除按钮操作，打开查询窗口
	 * @param key key打开窗口方法，query modify delete存放在隐藏域queryName
	 * @param key1 标识操作的表，1主表，2明细表 存放在隐藏域gridinfo
	 * @return 
	 */		
	function openwinQ(key,key1)
	{
		
		//$("#gridinfo").val(key);
		if(key==1){
			openDiaQueryG(key1,'call_type_num','1');					
		}
		else if(key==2){
			alert('abc');
			openDiaQueryG(key1,'vw_Hmzy_Detail','2');
		}
		
	}

	/**
	 * 加载工号
	 * @param 无参数
	 * @return 无返回值
	 */
	function operid21()
	{
		var result = fetchMultiArrayValue("Duty.fetchUserId",6,"");
		$("#iUserID21").html("<option value=\"\">--<fmt:message key='global.select' />--</option>");
		if(result[0]==undefined || result[0][0]==undefined)
		{
			return false;
		}
		var nHtml = "";
		for(var nb=0;nb<result.length;nb++)
		{
			nHtml += "<option value=\"" + result[nb][0] + "\">" + result[nb][1] + "</option>";
		}
		$("#iUserID21").append(nHtml);
	}
	/**
	 * 写jGrid标签
	 * @param 无参数
	 * @return 无返回值
	 */
	function generateGrid(ids)
	{	
		var id=1;
		if(ids==11||ids==12||ids==13){
			id=1;			
		}else{
			id=2;
		}
			var gridds = "<table id=\"editgrid"+id+"\" class=\"scroll\" cellpadding=\"0\" cellspacing=\"0\"></table>";
			gridds += "<div id=\"pagered"+id+"\" class=\"scroll\" style=\"text-align: left;\"></div>"; 
			$("#e_g_"+id).empty();
			$("#e_g_"+id).append(gridds);	
		
	}
	/**
	 * 按钮改变
	 * @param 无参数
	 * @return 无返回值
	 */
	function buttonchange(){	 
			if(tabStatus==11){
				//document.getElementById("allhaoma").style.display="";//生成全部号码库
				//document.getElementById("allhaomaf").style.display ="";//生成全部号码库
				document.getElementById("openadd1f").style.display ="";
				document.getElementById("openadd1").style.display ="";
				//document.getElementById("print1").style.display="";
				//document.getElementById("print1f").style.display ="";	
				// 隐藏批量修改和批量删除按钮
				document.getElementById("batchDel").style.display="none";
				document.getElementById("batchMod").style.display="none";		
			}else if(tabStatus==12){
				//document.getElementById("allhaoma").style.display="none";//生成全部号码库
				//document.getElementById("allhaomaf").style.display ="none";//生成全部号码库
				document.getElementById("openadd1").style.display="none";
				document.getElementById("openadd1f").style.display = 'none';
				// 显示批量修改和批量删除按钮
				document.getElementById("batchDel").style.display="";
				document.getElementById("batchMod").style.display="";
				//document.getElementById("print1").style.display="";
				//document.getElementById("print1f").style.display = '';
		
			}else if(tabStatus==13){
				//document.getElementById("allhaoma").style.display="none";//生成全部号码库
				//document.getElementById("allhaomaf").style.display ="none";//生成全部号码库
				document.getElementById("openadd1f").style.display = '';
				document.getElementById("openadd1").style.display = '';
				//document.getElementById("print1").style.display="none";
				//document.getElementById("print1f").style.display = 'none';	
				// 隐藏批量修改和批量删除按钮
				document.getElementById("batchDel").style.display="none";
				document.getElementById("batchMod").style.display="none";		
			}
	}
	
	</script>
	<script type="text/javascript">	
	/**
	 * 通过调用配置文件中的sql查看对象
	 * @param 无参数
	 * @return 无返回值
	 */
	jQuery(document).ready(function () { 
		listfirst();		
		//页面表头当前位置显示
		$("#navBar1").append(genNavv());
		
		/***********权限控制*****************/
		getUserPower();	
		var stru=new Array('11','12','13','21','22');
		
		var addright = $("#addright").val();
		if(addright=="true"){	
			 	$("#openadd1").removeAttr("disabled");	$("#openadd1f").removeAttr("disabled");
				$("#openadd2").removeAttr("disabled");	$("#openadd2f").removeAttr("disabled");
		}
			
		var exportright = $("#exportright").val();
		if(exportright=="true"){
				$("#export1").removeAttr("disabled");	$("#export1f").removeAttr("disabled");
				$("#export2").removeAttr("disabled");	$("#export2f").removeAttr("disabled");
		}
		var printf11 = $("#printright").val();
		if(printf11=="true"){
				$("#print1f").removeAttr("disabled");	$("#print1").removeAttr("disabled");
				$("#print2f").removeAttr("disabled");	$("#print2").removeAttr("disabled");
		}	
		//生成全部号码库
		/*
		var all = $("#allnumsright").val();
		if(all=="true"){
			$("#allhaoma").removeAttr("disabled");
			$("#allhaomaf").removeAttr("disabled");
		}
		*/
		var editBright = $("#editBright").val();
		if(editBright=="true"){	
				$("#openmod2").removeAttr("disabled");	$("#openmod2f").removeAttr("disabled");
		}
		var delBright = $("#delBright").val();
		if(delBright=="true"){
				$("#opende2").removeAttr("disabled");	
				$("#opende2f").removeAttr("disabled");	
		}
		var queryright = $("#queryright").val();
		var saveQueryMright = $("#saveQueryMright").val();
		if(queryright=="true"){
				$("#gjquery1").removeAttr("disabled");	$("#gjquery2").removeAttr("disabled");
				$("#gjquery12").removeAttr("disabled");	$("#gjquery22").removeAttr("disabled");
		}
		if(saveQueryMright=="true"){
				document.getElementById("savequery1").disabled=false;
				document.getElementById("savequery2").disabled=false;
				document.getElementById("savequery12").disabled=false;
				document.getElementById("savequery22").disabled=false;
		}
	
	
		$("#tabs1").tabs();
		$("#tabs2").tabs();
		$("#zjcss").css("color","#FF9834");//装机背景 
        $("#zjcss").css("background","url(style/images/public/curled.png) no-repeat right top"); //背景图片
    		
		setLabel();//得到面板标签		
		fenyeUtil();		
		operid21();	
		
	});
	/**
	 * 分页工具
	 * @param 无参数
	 * @return 无返回值
	 */
	function fenyeUtil(){
		var ids=1;
		if(tabStatus==11||tabStatus==12||tabStatus==13){
			ids=1;			
		}else{
			ids=2;
		}
		/////设置命令参数
		var urlstr=tsd.buildParams({ packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'nums'+tabStatus+'.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'nums'+tabStatus+'.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
											});
		var col=[[],[]];
		if(tabStatus==11){//号码资源设置>>>号码分配
				 col=getRb_Field(getTable(),getId(),"<fmt:message key='nums.modifydeletenumbers' />",'155','ziduans'+tabStatus);;//得到jqGrid要显示的字段

		}else{

				 col=getRb_Field(getTable(),getId(),"<fmt:message key='nums.modifydeletedetail' />",'97','ziduans'+tabStatus);;//得到jqGrid要显示的字段
		}
		//处理参数ziduans
		if(tabStatus==22){
			var ziduan=$("#ziduans"+tabStatus).val();
			ziduan = ziduan.replace(new RegExp('IsUse',"g"),"case when IsUse='1' then '"+"<fmt:message key='nums.yes'/>"+"' when IsUse='0' then '"+"<fmt:message key='nums.no'/>"+"' else ' ' end  as IsUse");		
			tsd.QualifiedVal=true;
			ziduan=tsd.encodeURIComponent(ziduan);
			if(tsd.Qualified()==false){return false;}
		  
			$("#ziduans"+tabStatus).val(ziduan);
		
		}else if(tabStatus==21){
			var ziduan=$("#ziduans"+tabStatus).val();
			/*
			ziduan = ziduan.replace(new RegExp('Jhj_ID',"g"),"replace(Jhj_ID,'&','&#38;')");
			*/		
			//tsd.QualifiedVal=true;
			ziduan=encodeURIComponent(ziduan);
			//  if(tsd.Qualified()==false){return false;}
			  
			$("#ziduans"+tabStatus).val(ziduan);
		
		}else if(tabStatus==12){
			var ziduan=$("#ziduans"+tabStatus).val();
			/*
			ziduan = ziduan.replace(new RegExp('Jhj_ID',"g"),"replace(Jhj_ID,'&','&#38;')");	
			*/	
			//tsd.QualifiedVal=true;
		  	ziduan=encodeURIComponent(ziduan);
		 	//  if(tsd.Qualified()==false){return false;}
		  
			$("#ziduans"+tabStatus).val(ziduan);
		
		}else if(tabStatus==11){
			var ziduan=$("#ziduans"+tabStatus).val();
			/*
			ziduan = ziduan.replace(new RegExp('Jhj_ID',"g"),"replace(b.JhjName,'&','&#38;') as Jhj_ID");
			ziduan = ziduan.replace(new RegExp('HMStart',"g"),"a.HMStart");
			ziduan = ziduan.replace(new RegExp('HMEnd',"g"),"a.HMEnd");
			ziduan = ziduan.replace(new RegExp('YwArea',"g"),"a.YwArea");
			ziduan = ziduan.replace(new RegExp('MokuaiJu',"g"),"a.MokuaiJu");
			ziduan = ziduan.replace(new RegExp('Bz',"g"),"a.Bz");
			ziduan = ziduan.replace(new RegExp('Dhlx',"g"),"a.Dhlx");
			ziduan = ziduan.replace(new RegExp('PreHth',"g"),"a.PreHth");
			*/
			 ziduan=encodeURIComponent(ziduan);		  
			$("#ziduans"+tabStatus).val(ziduan);
		
		}
		jQuery("#editgrid"+ids).jqGrid({		
				/*执行存储过程---------------- 
				tsdpname：可以调用其他存储过程，
				注意：tsdpname不是真正对应存储过程名称 而是通过系统进行映射，查看映射名请参照 存储过程维护页
				ds：对应applicationContent.xml里配置的数据源 
				*/
				
				url:'mainServlet.html?'+urlstr+"&ziduans="+$("#ziduans"+tabStatus).val(),
				datatype: 'xml', 
				colNames:col[0], 
				colModel:col[1], 
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'+ids), 
				       	sortname: getId(), //默认排序字段
				       	viewrecords: true, 
				       	//hidegrid: false, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:getTitle(), 
				        shrinkToFit: false,
				       	height:document.documentElement.clientHeight-240, //高
				       	width:document.documentElement.clientWidth-57,
				       	loadComplete:function(){
										$("#editgrid"+tabStatus).setSelection('0', true);
										$("#editgrid"+tabStatus).focus();
										var editinfo = $("#editinfo").val();
										var deleteinfo = $("#deleteinfo").val();
										if(tabStatus=='11'){
											addRowOperBtnimage('editgrid'+ids,'openModify',getId(),'click',1,"style/images/public/ltubiao_01.gif",editinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
											addRowOperBtnimage('editgrid'+ids,'openDel',getId(),'click',2,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
											addRowOperBtnimage('editgrid'+ids,'openInfo',getId(),'click',3,'style/images/public/ltubiao_03.gif',"<fmt:message key='nums.detail' />","&nbsp;&nbsp;&nbsp;");
											addRowOperBtnimage('editgrid'+ids,'generate',getId(),'click',4,'style/images/public/ltubiao_04.gif',"<fmt:message key='numsyield'/>","&nbsp;&nbsp;&nbsp;");//生成号码库
											
											executeAddBtn('editgrid'+ids,4);
										}else{
											addRowOperBtnimage('editgrid'+ids,'openModify',getId(),'click',1,"style/images/public/ltubiao_01.gif",editinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
											addRowOperBtnimage('editgrid'+ids,'openDel',getId(),'click',2,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
											addRowOperBtnimage('editgrid'+ids,'openInfo',getId(),'click',3,'style/images/public/ltubiao_03.gif',"<fmt:message key='nums.detail' />","&nbsp;&nbsp;&nbsp;");
											executeAddBtn('editgrid'+ids,3);
										}
									
										
										 //var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered"+ids).height();
										 //setAutoGridHeight("editgrid"+ids,reduceHeight);
										},
									ondblClickRow:function(rowid){
									var id=$("#editgrid"+ids).getCell(rowid,getId());
									openInfo(id);//详细
									}
				}).navGrid('#pagered'+ids,  {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
			); 
		}
         /**
		 * 拼接参数
		 * @param 无参数
		 * @return String
		 */
         function buildParam(){
				switch(tabStatus){
				  	case 11:		

						var d=document.getElementById('thedept').style.display;
						if(d!="none"){
								$("#iywlx").val(getTheChecked('depts'));
						}
						var d=document.getElementById('thedeptm').style.display;
						if(d!="none"){
							$("#imokuaiju").val(getTheChecked('deptsm'));
						}
           				tsd.QualifiedVal=true;  	
						var str="";	
				  		var HMStart=$("#iHMStart11").val();		  		
				  		if(HMStart!=null&&HMStart!=""){
				  			str=str+"&HMStart="+tsd.encodeURIComponent(strtrim(HMStart));
				  		}else{
				  			str=str+"&HMStart="+strtrim(HMStart);
				  		}
				  		var HMEnd=$("#iHMEnd11").val();	
				  		if(HMEnd!=null&&HMEnd!=""){
				  			str=str+"&HMEnd="+tsd.encodeURIComponent(HMEnd);
				  		}else{	  		
				  			str=str+"&HMEnd="+strtrim(HMEnd);
				  		}		  		
		  				var YwArea=$("#iywlx").val();			  			
				  		if(YwArea!=null&&YwArea!=""){
				  			str=str+"&YwArea="+tsd.encodeURIComponent(strtrim(YwArea));
				  		}else{
				  			str=str+"&YwArea="+strtrim(YwArea);
				  		}
		  				var MokuaiJu=$("#imokuaiju").val();	
		  	
				  		if(MokuaiJu!=null&&MokuaiJu!=""){
				  			str=str+"&MokuaiJu="+tsd.encodeURIComponent(MokuaiJu);
				  		}else{	  		
				  			str=str+"&MokuaiJu="+strtrim(MokuaiJu);
				  		}
		  	
		  				var Bz=$("#iBz11").val();		  		
				  		if(Bz!=null&&Bz!=""){
				  			str=str+"&Bz="+tsd.encodeURIComponent(strtrim(Bz));
				  		}else{
				  			str=str+"&Bz="+strtrim(Bz);
				  		}
				  		var Dhlx=$("#iDhlx11").val();			  		
				  		if(Dhlx!=null&&Dhlx!=""){
				  			str=str+"&Dhlx="+tsd.encodeURIComponent(Dhlx);
				  		}else{	  		
				  			str=str+"&Dhlx="+strtrim(Dhlx);
				  		}
				  		var Jhj_ID=$("#iJhj_ID11").val();		  		 		
				  		if(Jhj_ID!=null&&Jhj_ID!=""){
				  			str=str+"&Jhj_ID="+tsd.encodeURIComponent(strtrim(Jhj_ID));
				  		}else{
				  			str=str+"&Jhj_ID="+"0";
				  		}
		  		
		  				var PreHth=$("#iPreHth11").val();		  		
				  		if(PreHth!=null&&PreHth!=""){
				  			str=str+"&PreHth="+tsd.encodeURIComponent(strtrim(PreHth));
				  		}else{
				  			str=str+"&PreHth="+strtrim(PreHth);
				  		}
						if(tsd.Qualified()==false){return false;}
		  		
				  		//验证
				  		if(ismodify==0){
		  		  			if(PreHth!=""&&subStrsql(PreHth,2)==1){
		  		  				 $("#iPreHth11").focus();
		  		  				 alert("\""+$("#PreHth11").html()+"\"<fmt:message key='nums.charscanotmore'/>"+2+"<fmt:message key='nums.chinesetwoenglishone' />"); 
		  		  				 return false; 	
		  		  			}
		  					if(Bz!=""&&subStrsql(Bz,50)==1){
		  						$("#iBz11").focus();
		  						 alert("\""+$("#Bz11").html()+"\"<fmt:message key='nums.charscanotmore'/>"+50+"<fmt:message key='nums.chinesetwoenglishone' />"); 
		  						 return false; 	
		  					}
		  		
				  		}else{
				  		if(HMStart==""){  	
				  			jAlert($("#HMStart11").html()+"<fmt:message key="global.notNull"/>");
				  			return false;
				  		}  
				  		if(HMEnd==""){
				  			jAlert($("#HMEnd11").html()+"<fmt:message key="global.notNull"/>");
				  			return false;
				  		}		
			  			if(!tonglen(HMStart,HMEnd)){return false;}	
			  			if(PreHth!=""&&subStrsql(PreHth,2)==1){	
			  				$("#iPreHth11").focus();
			  				alert("\""+$("#PreHth11").html()+"\"<fmt:message key='nums.charscanotmore'/>"+2+"<fmt:message key='nums.chinesetwoenglishone' />");
			  				return false; 	
			  			}
		   				if(Bz!=""&&subStrsql(Bz,50)==1){	
		   					$("#iBz11").focus(); 
		   					alert("\""+$("#Bz11").html()+"\"<fmt:message key='nums.charscanotmore'/>"+50+"<fmt:message key='nums.chinesetwoenglishone' />");
		   					return false; 	
		   				}
					  	if(YwArea==""){
					  		jAlert($("#sdepartname").html()+"<fmt:message key="global.notNull"/>");
					  		return false;
					  	}
		  	
		  				if(YwArea!=""&&subStrsql(YwArea,50)==1){
		  						alert("\""+$("#sdepartname").html()+"\"<fmt:message key='nums.charscanotmore'/>"+50+"<fmt:message key='nums.chinesetwoenglishone' />");  
		  						return false; 	
		  				}
					  	if(MokuaiJu==""){
					  		jAlert($("#sdepartnamem").html()+"<fmt:message key="global.notNull"/>");
					  		return false;
					  	}
		  		
		  		}
		  		
		  		if(MokuaiJu!=""&&subStrsql(MokuaiJu,50)==1){
		  			alert("\""+$("#sdepartnamem").html()+"\"<fmt:message key='nums.charscanotmore'/>"+50+"<fmt:message key='nums.chinesetwoenglishone' />"); 
		  			return false; 	}
		  		//日志
		  	
		  		var info=$("#HMStart11").html()+":"+HMStart+",";
		  		var info1=$("#HMStart11").html()+":"+$("#HMStartoh").val()+" >>> "+HMStart+",";		  		
		  		info=info+$("#HMEnd11").html()+":"+HMEnd+",";				
				info1=info1+$("#HMEnd11").html()+":"+$("#HMEndoh").val()+" >>> "+HMEnd+",";			
		  	    info=info+$("#sdepartname").html()+":"+YwArea+",";			
		  		info=info+$("#sdepartnamem").html()+":"+MokuaiJu+",";			
		  		info=info+$("#Jhj_ID11").html()+":"+Jhj_ID+",";					
		  		info=info+$("#Bz11").html()+":"+Bz+",";				
				info1=info1+$("#Bz11").html()+":"+$("#Bzoh").val()+" >>> "+Bz+",";
		  		info=info+$("#Dhlx11").val()+":"+Dhlx+",";				
				info=info+$("#PreHth11").html()+":"+PreHth+"";				
				info1=info1+$("#PreHth11").html()+":"+$("#PreHthoh").val()+" >>> "+PreHth+" ";
				
				$("#addh").val(info);											
				$("#edith").val(info1);		
					
			break;
	case 12:
				tsd.QualifiedVal=true;  	
				var str="";	
				var mkj = $("#iMokuaiJu12").val();
				if( mkj != null && mkj != "" )
				{
					str = str + "&mkj="+tsd.encodeURIComponent(strtrim(mkj));
				}
		  		var Dh_Level=$("#iDh_Level12").val();		  		
		  		if(Dh_Level!=null&&Dh_Level!=""){
		  			str=str+"&Dh_Level="+tsd.encodeURIComponent(strtrim(Dh_Level));
		  		}else{
		  			str=str+"&Dh_Level="+"-1";
		  		}
		  		var IsKeep=$("#iIsKeep12").val();	
		  		if(IsKeep!=null&&IsKeep!=""){
		  			str=str+"&IsKeep="+tsd.encodeURIComponent(IsKeep);
		  		}else{	  		
		  			str=str+"&IsKeep="+"-1";
		  		}		  		
		  		var Bz=$("#iBz12").val();		  		
		  		if(Bz!=null&&Bz!=""){
		  			str=str+"&Bz="+tsd.encodeURIComponent(strtrim(Bz));
		  		}else{
		  			str=str+"&Bz="+Bz;
		  		}
		  		if(Bz!=""&&subStrsql(Bz,50)==1){	
		  			$("#iBz12").focus(); 
		  			alert("\""+$("#Bz12").html()+"\"<fmt:message key='nums.charscanotmore'/>"+50+"<fmt:message key='nums.chinesetwoenglishone' />");
		  			return false; 	
		  		}
		  		 //每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}
		  	
		  		var info1=$("#Dh12").html()+":"+$("#iDh12").val()+" ";	
		  		var info1=info1+$("#Dh_Level12").html()+":"+$("#Dh_Leveloh").val()+" >>> "+Dh_Level+" ";	
		  		var info1=info1+$("#IsKeep12").html()+":"+$("#IsKeepoh").val()+" >>> "+IsKeep+" ";		 
		  		var info1=info1+$("#Bz12").html()+":"+$("#Bzoh").val()+" >>> "+Bz+" ";		
													
				$("#edith").val(info1);			  		
				break;
	case 13:
				tsd.QualifiedVal=true;  	
				var str="";	
		  		var Hm_Level=$("#iHm_Level13").val();		  		  		
		  		if(Hm_Level!=null&&Hm_Level!=""){
		  		str=str+"&Hm_Level="+tsd.encodeURIComponent(strtrim(Hm_Level));
		  		}else{
		  		str=str+"&Hm_Level="+"";
		  		}
		  		var Bz=$("#iBz13").val();	
		  		if(Bz!=null&&Bz!=""){		  	
		  		str=str+"&Bz="+tsd.encodeURIComponent(Bz);
		  		}else{		  	
		  		str=str+"&Bz="+"";
		  		}		  		
		  			var SelectFee=$("#iSelectFee13").val();		  		
		  		if(SelectFee!=null&&SelectFee!=""){
		  		str=str+"&SelectFee="+tsd.encodeURIComponent(strtrim(SelectFee));
		  		}else{
		  		str=str+"&SelectFee="+"";
		  		}		  		
		  		 //每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}
		  		////验证
		  		if(Hm_Level==""){  	
		  			alert($("#Hm_Level13").html()+"<fmt:message key='global.notNull'/>");
		  			return false;
		  		} 
		  		if(subInt!=""&&subInt(Hm_Level)==0){ alert("\""+$("#Hm_Level13").html()+"\"<fmt:message key='nums.notnumber' />");return false;}
	 		 	else if(Hm_Level!=""&&subInt(Hm_Level)==1){alert("\""+$("#Hm_Level13").html()+"\"<fmt:message key='nums.lengthexist' />[-2147483648,2147483647]<fmt:message key='nums.range' />");return false;}
		
		  		if(Bz!=""&&subStrsql(Bz,20)==1){	$("#iBz13").focus(); alert("\""+$("#Bz13").html()+"\"<fmt:message key='nums.charscanotmore' />"+20+"<fmt:message key='nums.chinesetwoenglishone' />"); return false; 	}
		  		if(SelectFee!=""&&subMoney(SelectFee)==0){ alert("\""+$("#SelectFee13").html()+"\"<fmt:message key='nums.notnumber' />");return false;}
	 		 	else if(SelectFee!=""&&subMoney(SelectFee)==1){alert("\""+$("#SelectFee13").html()+"\"<fmt:message key='nums.lengthexist' />[-922337203685477.5808,922337203685477.5808]<fmt:message key='nums.range' />");return false;}
		
		  		///日志
		  	
		  		var info=$("#Hm_Level13").html()+":"+Hm_Level+" ";
		  		var info1=$("#Hm_Level13").html()+":"+$("#Hm_Leveloh").val()+" >>> "+Hm_Level+" ";		  		
		  		info=info+$("#Bz13").html()+":"+Bz+" ";				
				info1=info1+$("#Bz13").html()+":"+$("#Bzoh").val()+" >>> "+Bz+" ";			
		  		info=info+$("#SelectFee13").html()+":"+SelectFee+" ";				
				info1=info1+$("#SelectFee13").html()+":"+$("#SelectFeeoh").val()+" >>> "+SelectFee+" ";			  		
				$("#addh").val(info);											
				$("#edith").val(info1);		
					  		
	break;
	case 21:
			tsd.QualifiedVal=true;  	
				var str="";	
				var Dh=$("#iDh21").val();		  		
		  		if(Dh!=null&&Dh!=""){
		  		str=str+"&Dh="+tsd.encodeURIComponent(strtrim(Dh));
		  		}else{
		  		str=str+"&Dh="+Dh;
		  		}
		  	
		  		var Dh_Level=$("#iDh_Level21").val();		  		
		  		if(Dh_Level!=null&&Dh_Level!=""){
		  		str=str+"&Dh_Level="+tsd.encodeURIComponent(strtrim(Dh_Level));
		  		}else{
		  		str=str+"&Dh_Level="+'-1';
		  		}
		  		var IsKeep=$("#iIsKeep21").val();	
		  		if(IsKeep!=null&&IsKeep!=""){
		  		str=str+"&IsKeep="+tsd.encodeURIComponent(IsKeep);
		  		}else{	  		
		  		str=str+"&IsKeep="+'-1';
		  		}		  	
		  		var MokuaiJu=$("#iMokuaiJu21").val();		  		
		  		if(MokuaiJu!=null&&MokuaiJu!=""){
		  		str=str+"&MokuaiJu="+tsd.encodeURIComponent(strtrim(MokuaiJu));
		  		}else{
		  		str=str+"&MokuaiJu="+MokuaiJu;
		  		}
		  		var Dhlx=$("#iDhlx21").val();		  		
		  		if(Dhlx!=null&&Dhlx!=""){
		  		str=str+"&Dhlx="+tsd.encodeURIComponent(strtrim(Dhlx));
		  		}else{
		  		str=str+"&Dhlx="+Dhlx;
		  		}
		  		var Jhj_ID=$("#iJhj_ID21").val();		  		
		  		if(Jhj_ID!=null&&Jhj_ID!=""){
		  		str=str+"&Jhj_ID="+tsd.encodeURIComponent(strtrim(Jhj_ID));
		  		}else{
		  		str=str+"&Jhj_ID="+'-1';
		  		}
		  		var YwArea=$("#iYwArea21").val();		  		
		  		if(YwArea!=null&&YwArea!=""){
		  		str=str+"&YwArea="+tsd.encodeURIComponent(strtrim(YwArea));
		  		}else{
		  		str=str+"&YwArea="+YwArea;
		  		}	
		  		var Bz=$("#iBz21").val();		  		
		  		if(Bz!=null&&Bz!=""){
		  		str=str+"&Bz="+tsd.encodeURIComponent(strtrim(Bz));
		  		}else{
		  		str=str+"&Bz="+Bz;
		  		}
		  		
		  		var uuid=$("#iUserID21").val();		  		
		  		if(uuid!=null&&uuid!=""){
		  		str=str+"&UserID="+tsd.encodeURIComponent(strtrim(uuid));
		  		}else{
		  		str=str+"&UserID="+uuid;
		  		}
		  		
		  		if(Dh==""){  	
		  			alert($("#Dh12").html()+"<fmt:message key="global.notNull"/>");
		  			return false;
			  	}
			  	if(subTel(Dh,16)==0){
			  	alert($("#Dh12").html()+"<fmt:message key="global.invalid"/>");
		  			return false;
			  	}
			  	if(subTel(Dh,16)==1){
			  	alert($("#Dh12").html()+"<fmt:message key="global.tooLong"/>");
		  			return false;
			  	}
			  	
		  		
		  		 //每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}
		  	
		  		var info1=$("#Dh21").html()+":"+Dh+">>>"+Dh+",";	
		  		var info1=info1+$("#Dh_Level21").html()+":"+$("#Dh_Leveloh").val()+" >>> "+Dh_Level+",";	
		  		var info1=info1+$("#IsKeep21").html()+":"+$("#IsKeepoh").val()+" >>> "+IsKeep+",";		 
		  		var info1=info1+$("#Bz21").html()+":"+$("#Bzoh").val()+" >>> "+Bz;		 	  		
		  		
													
				$("#edith").val(info1);
					  	
	break;
	case 22:
		tsd.QualifiedVal=true;  	
				var str="";	
		  		var Dh_Level=$("#iMokuaiJu22").val();		  		
		  		if(Dh_Level!=null&&Dh_Level!=""){
		  		str=str+"&MokuaiJu="+tsd.encodeURIComponent(strtrim(Dh_Level));
		  		}else{
		  		str=str+"&MokuaiJu="+Dh_Level;
		  		}
		  		var MokuaiJu2=$("#iMokuaiJu222").val();	
		  		if(MokuaiJu2!=null&&MokuaiJu2!=""){
		  		str=str+"&MokuaiJu2="+tsd.encodeURIComponent(MokuaiJu2);
		  		}else{	  		
		  		str=str+"&MokuaiJu2="+MokuaiJu2;
		  		}		  	
		  		var MokuaiJu=$("#iIsUse22").val();		  		
		  		if(MokuaiJu!=null&&MokuaiJu!=""){
		  		str=str+"&IsUse="+tsd.encodeURIComponent(strtrim(MokuaiJu));
		  		}else{
		  		str=str+"&IsUse="+MokuaiJu;
		  		}
		  		var Dhlx=$("#iBz22").val();		  		
		  		if(Dhlx!=null&&Dhlx!=""){
		  		str=str+"&Bz="+tsd.encodeURIComponent(strtrim(Dhlx));
		  		}else{
		  		str=str+"&Bz="+Dhlx;
		  		}
		  		if(IsKeep==""){  	
		  			jAlert($("#MokuaiJu222").html()+"<fmt:message key="global.notNull"/>");
		  			return false;
		  		} 
		  	
		  		if(MokuaiJu2!=""&&subStrsql(MokuaiJu2,50)==1){	alert("\""+$("#MokuaiJu222").html()+"\"<fmt:message key='nums.charscanotmore'/>"+50+"<fmt:message key='nums.chinesetwoenglishone' />"); return false; 	}
		  		//每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}
		  		var info1=$("#MokuaiJu222").html()+":"+$("#MokuaiJu2oh").val()+" >>> "+IsKeep+",";	
		  		var info1=info1+$("#MokuaiJu22").html()+":"+$("#MokuaiJuoh").val()+" >>> "+Dh_Level+",";	 
		  		var info1=info1+$("#IsUse22").html()+":"+$("#IsUseoh").val()+" >>> "+strtrim(MokuaiJu)+" ";
				$("#edith").val(info1);	
				var info=$("#MokuaiJu222").html()+":"+IsKeep+","+$("#MokuaiJu22").html()+":"+Dh_Level+","+$("#IsUse22").html()+":"+strtrim(MokuaiJu)+" ";
		  		$("#addh").val(info);	
		  		return str;
				break;			
		}  		
		return str;		  		
}  
			/**
			 *  新增弹出的对话框
			 * @param 无参数
			 * @return String
			 */
			function openadd(){ 
					$("#HMStart").attr("readonly","");
					markTable(0);//显示红色*号
					autoBlockFormAndSetWH('pan'+tabStatus,80,5,'close'+tabStatus,"#ffffff",true,1000,'');//弹出查询面板 
					clear();
		             $(".top_03").html('<fmt:message key="global.add" />');//标题
  					// openpan(2);  
  					$("#tdiv"+tabStatus+" input[type='text']").removeAttr("disabled");
  					$("#tdiv"+tabStatus+" select").removeAttr("disabled");	
  					$("#tdiv"+tabStatus+" textarea").removeAttr("disabled");			 
					$("#tdiv"+tabStatus+" input[type='text']").attr("readonly","");
  					$("#tdiv"+tabStatus+" input[type='text']").removeClass();	$("#tdiv"+tabStatus+" input[type='text']").addClass("textclass");
  					$("#tdiv"+tabStatus+" textarea").removeClass();	$("#tdiv"+tabStatus+" textarea").addClass("textclass");
					if(tabStatus==11){				
							$("#modify11").hide();	
							$("#save11").hide();	
							$("#save111").hide(); 	
							$("#reset11").hide();					
							document.getElementById("iDhlx11").style.display="";
							document.getElementById("iDhlx112").style.display="none";	
							$("#iJhj_ID112").attr("readonly","readonly");			
							$("#jhj11").css("display","none");
					}else if(tabStatus==13){
							$("#modify13").hide();	
							$("#save13").hide();	
							$("#save131").hide(); 	
							$("#reset13").hide();
					
					}else if(tabStatus==21){
		  					$("#iIsKeep21").html("<option value='0'><fmt:message key='numsno'/></option><option value='1'><fmt:message key='numsyes'/></option>");
		  					
		  					$("#iJhj_ID212").attr("readonly","readonly");
		  					$("#iDh_Level212").attr("readonly","readonly");					
		     	 			$("#jhj").css("display","none");
		  				    $("#level").css("display","none");
		  				   
		     	 			document.getElementById("iMokuaiJu21").style.display="";
							document.getElementById("iMokuaiJu212").style.display = 'none';
							document.getElementById("iDhlx21").style.display="";
							document.getElementById("iDhlx212").style.display = 'none';
							document.getElementById("iYwArea21").style.display="";
							document.getElementById("iYwArea212").style.display = 'none';
							document.getElementById("iIsKeep21").style.display="";
							document.getElementById("iIsKeep212").style.display = 'none';
							document.getElementById("iUserID21").style.display="";
							document.getElementById("iUserID212").style.display = 'none';
							document.getElementById("iBz21").style.display="";
							document.getElementById("iBz212").style.display = 'none';
							$("#modify21").hide(); 
							$("#modifyB21").hide();	
							$("#save21").hide();	
							$("#save211").hide(); 	
							$("#reset21").hide();		     	
		  					
		  			}else if(tabStatus==22){
						$("#iIsUse22").html("<option value='0'><fmt:message key='dangan.n'/></option><option value='1'><fmt:message key='dangan.y'/></option>");
				
						$("#iMokuaiJu22").css("display","");
						$("#iMokuaiJu22i2").css("display","none");
						$("#iIsUse22").css("display","");
						$("#iIsUse222").css("display","none");
						$("#iBz22").css("display","");
						$("#iBz222").css("display","none");
						$("#modify22").hide(); 
						$("#modifyB22").hide();	
						$("#save22").hide();	
						$("#save221").hide(); 	
						$("#reset22").hide();
								
					}	
		  			$("#save"+tabStatus).show();
					$("#save"+tabStatus+"1").show();
  			
			}
	
           	/**
			 *  重新加载jQuery
			 * @param 无参数
			 * @return String
			 */
			 function querylist(){	
			 var ids=1;
				if(tabStatus==11||tabStatus==12||tabStatus==13){
					ids=1;			
				}else{
					ids=2;
				}
				var params = fuheQbuildParams();						
				if(params=='&fusearchsql='){
					params +='1=1';
				}			
			  var urlstr=tsd.buildParams({ packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'nums'+tabStatus+'.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'nums'+tabStatus+'.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
											});	
				$("#editgrid"+ids).setGridParam({url:'mainServlet.html?'+urlstr+"&ziduans="+$("#ziduans"+tabStatus).val()}).trigger("reloadGrid");
			setTimeout($.unblockUI, 15);//关闭面板
			closeo();	
			 }
		
  		/**
		  *   新增操作
		  * @param 无参数
		  * @return String
		  */
  		function save(saves){
  		//验证
  		if(tabStatus=='11'){
  			ismodify=1;
  			var HMStart=$("#iHMStart11").val();	  		
		  	var HMEnd=$("#iHMEnd11").val();
		  	if(!Chong(HMStart,HMEnd)){return false;}
		  }else if(tabStatus=='13'){
		  	var Hm_Level=$("#iHm_Level13").val();
  		 	if(Hm_Level!=""&&Hm_Level!=null&&!ischong(Hm_Level,'')){
           	 alert($("#Hm_Level13").html()+":"+Hm_Level+" "+"<fmt:message key="accountM.alert.userExist"/>");
           	 $("#iHm_Level13").focus();
           	 return false;
           	 }
          }else if(tabStatus=='21'){
          var Dh=$("#iDh21").val();
  			tsd.QualifiedVal=true; 
  			if(Dh!=""&&Dh!=null){
  				Dh=tsd.encodeURIComponent(Dh);
  			}
  			if(tsd.Qualified()==false){return false;}
  		 	if(Dh!=null&&Dh!=""&&!ischong(Dh,'')){
           	 alert($("#Dh21").html()+":"+Dh+" "+"<fmt:message key="accountM.alert.userExist"/>");
           	 $("#iDh21").focus();
           	 return false;
           	 }
          } else if(tabStatus=='22'){
          var Dh=$("#iMokuaiJu222").val();
  			tsd.QualifiedVal=true; 
  			if(Dh!=""&&Dh!=null){
  				Dh=tsd.encodeURIComponent(Dh);
  			}
  			if(tsd.Qualified()==false){return false;}
			if(Dh!=null&&Dh!=""&&!ischong(Dh,'')){
           	 alert($("#MokuaiJu222").html()+":"+$("#iMokuaiJu222").val()+" "+"<fmt:message key="accountM.alert.userExist"/>");
           	 return false;
           	 }	 
           }
  			var str=buildParam();	  	
  			if(str==false) return false;
			var urlstr=tsd.buildParams({packgname:'service',
								 		clsname:'ExecuteSql',
								 		method:'exeSqlData',
								 		ds:'tsdBilling',
								 		tsdcf:'mssql',
								 		tsdoper:'exe',				 	
										tsdpk:'nums'+tabStatus+'.save'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						});
				
					urlstr=urlstr+str;
				
						$.ajax({
							url:'mainServlet.html?'+urlstr,
							type:'post',
							datatype:'exe',
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
									
									var info=$("#addh").val();	
									logwrite(1,info);
									if(saves==2){
										querylist();										
									}else{
									closeflash=true;//表示关闭时需要刷新
									clear();
									
									}			
							}
							
							}});
  		}
  			
	
		 /**
		  *  删除的权限 
		  * @param 无参数
		  * @return String
		  */
  		  function openDel(bname){   		 	
  			var deleteright = $("#deleteright").val();
  	
		if(deleteright=="true"){	
			$("#id").val(bname);				
  		    queryByAccount();
  		 if(confirm("<fmt:message key="global.alert.del"/>?")){  		
  		 var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'tsdBilling',
						 					tsdcf:'mssql',
						 					tsdoper:'exe',				 	
											tsdpk:'nums'+tabStatus+'.delByAccount'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});
		
			urlstr=urlstr+"&"+getId()+"="+bname;
		
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(msg){
					if(msg=="true"){					
							//操作提示国际化
							var operationtips = $("#operationtips").val();
							//操作成功
							var successful = $("#successful").val();
							alert(successful,operationtips);						
					
								
					var info=$("#addh").val();	
					logwrite(2,info);
					querylist();								
					}
					
					}});
		}
					}else{
						var operationtips = $("#operationtips").val();
						var deletepower = $("#deletepower").val();	
									
						jAlert(deletepower,operationtips);
					}
		
  		 }
  		/**
		 * 查询列表
		 * @param 无参数
		 * @return String
		 */
  		function queryByAccount(){   
  		var info="";	
  		var bname=$("#id").val(); 
  		if(tabStatus==21){
  		 var urlstr=tsd.buildParams({packgname:'service',
						 				clsname:'ExecuteSql',
						 				method:'exeSqlData',
						 				ds:'tsdBilling',
						 				tsdcf:'mssql',
						 				tsdoper:'query',
						 				datatype:'xmlattr',				 	
										tsdpk:'nums21.queryvwhmzy'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});
			urlstr=urlstr+"&"+getId()+"="+bname;
		
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){	
						var Jhj_ID=$(this).attr("jhj_id");
						var Dh_Level=$(this).attr("dh_level");	
						if(Dh_Level==null) Dh_Level="";	
						if(Jhj_ID==null) Jhj_ID="";
						$("#iJhj_ID212").val(Jhj_ID);
						$("#iDh_Level212").val(Dh_Level);															
								
						});						
				
					}});
					
  		
  		
  		}		 	   		 	
  		
  		 var urlstr=tsd.buildParams({packgname:'service',
						 				clsname:'ExecuteSql',
						 			method:'exeSqlData',
						 				ds:'tsdBilling',
						 				tsdcf:'mssql',
						 				tsdoper:'query',
						 				datatype:'xmlattr',				 	
										tsdpk:'nums'+tabStatus+'.queryById'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});
			urlstr=urlstr+"&"+getId()+"="+bname;
		
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){	
					switch(tabStatus){	
					case 11:												
								var HMEnd=$(this).attr("hmend");
								var YwArea=$(this).attr("ywarea");
								var MokuaiJu=$(this).attr("mokuaiju");
								var Bz=$(this).attr("bz");
								var Dhlx=$(this).attr("dhlx");
								var Jhj_ID=$(this).attr("jhj_id");
								var PreHth=$(this).attr("prehth");	
								
								$("#iHMEnd11").val(HMEnd);
								$("#iHMStart11").val(bname);		
								$("#iywlx").val(YwArea);
								$("#imokuaiju").val(MokuaiJu);	
								$("#iBz11").val(Bz);
								$("#iDhlx11").val(Dhlx);
								$("#iJhj_ID11").val(Jhj_ID);
								$("#iJhj_ID112").val(getjiaohuan(Jhj_ID));
								$("#iPreHth11").val(PreHth);					
								////修改操作记录日志时，保存旧数据
								$("#HMEndoh").val(HMEnd);
								$("#HMStartoh").val(bname);
								$("#YwAreaoh").val(YwArea);
								$("#MokuaiJuoh").val(MokuaiJu);
								$("#Bzoh").val(Bz);
								$("#Dhlxoh").val(Dhlx);
								$("#Jhj_IDoh").val(Jhj_ID);
								$("#PreHthoh").val(PreHth);						
								var info=$("#HMStart11").html()+":"+bname+" "+$("#HMEnd11").html()+":"+HMEnd;								
								info+=" "+$("#Bz11").html()+":"+Bz+" "+$("#Dhlx11").html()+":"+Dhlx;
								info+=" "+$("#Jhj_ID11").html()+":"+Jhj_ID;+$("#PreHth11").html()+":"+PreHth;
								$("#addh").val(info);
								
							break;	
					case 12:
								var MokuaiJu=$(this).attr("mokuaiju");
								var Dhlx=$(this).attr("dhlx");
								var Jhj_ID=$(this).attr("jhj_id");
								var YwArea=$(this).attr("ywarea");
								var Dh_Level=$(this).attr("dh_level");
								var IsKeep=$(this).attr("iskeep");								
								var Bz=$(this).attr("bz");	
								$("#iMokuaiJu12").val(MokuaiJu);	
								$("#iMokuaiJu1").val(MokuaiJu);
								$("#iDhlx12").val(Dhlx);	
								$("#iJhj_ID12").val(getjiaohuan(Jhj_ID));
								$("#iYwArea12").val(YwArea);
								
								$("#iDh12").val(bname);
													
								$("#iDh_Level12").val(Dh_Level);
								$("#iDh_Level122").val(getlevel(Dh_Level));									
								$("#iIsKeep12").val(IsKeep);								
								$("#iBz12").val(Bz);					
								 
								$("#Dh_Leveloh").val(Dh_Level);
								$("#IsKeepoh").val(IsKeep);								
								$("#Bzoh").val(Bz);
								info=$("#Dh_Level12").html()+":"+Dh_Level+" ";
								info=info+$("#IsKeep12").html()+":"+IsKeep+" ";
								info=info+$("#Bz12").html()+":"+Bz+" ";
								
						break;
					case 13:
								var Bz=$(this).attr("bz");
								var SelectFee=$(this).attr("selectfee");													
								$("#iHm_Level13").val(bname);
								$("#iBz13").val(Bz);		
								$("#iSelectFee13").val(SelectFee);
												
								//修改操作记录日志时，保存旧数据
								$("#SelectFeeoh").val(SelectFee);
								$("#Bzoh").val(Bz);
								$("#Hm_Leveloh").val(bname);
								var info=$("#Hm_Level13").html()+":"+bname+" ";						
								info+=" "+$("#Bz13").html()+":"+Bz+" ";
								info+=" "+$("#SelectFee13").html()+":"+SelectFee+" ";
								
						break;
					case 21:
					
								var Dh_Level=$(this).attr("dh_level");
								var IsKeep=$(this).attr("iskeep");
								var MokuaiJu=$(this).attr("mokuaiju");
								var Dhlx=$(this).attr("dhlx");
								var Jhj_ID=$(this).attr("jhj_id");
								var YwArea=$(this).attr("ywarea");
								var Bz=$(this).attr("bz");
								$("#iDh21").val(bname);	
								
								$("#iDh_Level21").val(Dh_Level);
								$("#iIsKeep21").val(IsKeep);	
								$("#iMokuaiJu21").val(MokuaiJu);
								$("#iDhlx21").val(Dhlx);	
								
								$("#iYwArea21").val(YwArea);
								
								$("#iJhj_ID21").val(Jhj_ID);
								$("#iBz21").val(Bz);					
								////修改操作记录日志时，保存旧数据
								 
								$("#Dh_Leveloh").val(Dh_Level);
								$("#IsKeepoh").val(IsKeep);
								$("#MokuaiJuoh").val(MokuaiJu);
								$("#Dhlxoh").val(Dhlx);							
								$("#Jhj_IDoh").val(Jhj_ID);
								$("#YwAreaoh").val(YwArea);
								$("#Bzoh").val(Bz);
								info=$("#Dh21").html()+":"+bname+" ";
								info=info+$("#Dh_Level21").html()+":"+Dh_Level+" ";
								info=info+$("#IsKeep21").html()+":"+IsKeep+" ";
								info=info+$("#MokuaiJu21").html()+":"+MokuaiJu+" ";
								info=info+$("#Dhlx21").html()+":"+Dhlx+" ";
								info=info+$("#Jhj_ID21").html()+":"+Jhj_ID+" ";
								info=info+$("#YwArea21").html()+":"+YwArea+" ";
								info=info+$("#Bz21").html()+":"+Bz+" ";
						break;
					case 22:
								var MokuaiJu=$(this).attr("mokuaiju");
								var MokuaiJu2=$(this).attr("mokuaiju2");
								var IsUse=$(this).attr("isuse");
								var Bz=$(this).attr("bz");
								$("#iMokuaiJu22").val(MokuaiJu);						
								$("#iMokuaiJu222").val(MokuaiJu2);
								if(IsUse==1||IsUse=='1'){
								$("#iIsUse22").val('1');
								}else if(IsUse==0||IsUse=='0'){
								$("#iIsUse22").val('0');
								}								
								$("#iBz22").val(Bz);
								$("#MokuaiJuoh").val(MokuaiJu);
								$("#MokuaiJu2oh").val(MokuaiJu2);
								$("#IsUseoh").val(IsUse);
								$("#Bzoh").val(Bz);	
								info=$("#MokuaiJu222").html()+":"+MokuaiJu2+" ";
								info=info+$("#MokuaiJu22").html()+":"+MokuaiJu+" ";
								info=info+$("#IsUse22").html()+":"+strtrim(IsUse)+" ";
								info=info+$("#Bz22").html()+":"+Bz+" ";
						break;			
						}																			
								
						});						
				
					}});
					
					$("#addh").val(info);
  		 }
  		/**
		 * 获取level
		 * @param 无参数
		 * @return String
		 */
  		 function getlevel(hm_level){
  		 var name="";
  		 if(hm_level=='-1'){name="";}else{
  		 		 var urlstr=tsd.buildParams({packgname:'service',
						 				clsname:'ExecuteSql',
						 				method:'exeSqlData',
						 				ds:'tsdBilling',
						 				tsdcf:'mssql',
						 				tsdoper:'query',
						 				datatype:'xmlattr',				 	
										tsdpk:'nums12.querylevel'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});
			urlstr=urlstr+"&hm_level="+hm_level;
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){																	
								var bz=$(this).attr("bz");	
								name=bz;
						});						
				
					}});
		}
  		 
  		 return name;
  		 }
  		/**
		 * 获取交换id
		 * @param JhjID
		 * @return String
		 */
  		 function getjiaohuan(JhjID){
  		 var name="";
  		 if(JhjID=='-1'){name="";}else{
  		 		 var urlstr=tsd.buildParams({packgname:'service',
						 				clsname:'ExecuteSql',
						 				method:'exeSqlData',
						 				ds:'tsdBilling',
						 				tsdcf:'mssql',
						 				tsdoper:'query',
						 				datatype:'xmlattr',				 	
										tsdpk:'nums12.queryjiao'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});
			urlstr=urlstr+"&JhjID="+JhjID;
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){																	
								var JhjName=$(this).attr("jhjname");								
								var JhjArea=$(this).attr("jhjarea");
								name=JhjName;
						});						
				
					}});
		}
  		 
  		 return name;
  		 }
  		/**
		 * 获取详情
		 * @param bname
		 * @return 无返回值
		 */
  		function openInfo(bname){
  		  markTable(1);
  		 $("#id").val(bname);
  		 $(".top_03").html("<fmt:message key='nums.detail'/>");//标题
  		
  		$("#tdiv"+tabStatus+" input[type='text']").removeClass();	$("#tdiv"+tabStatus+" input[type='text']").addClass("textclass2");
  		$("#tdiv"+tabStatus+" textarea").removeClass();	$("#tdiv"+tabStatus+" textarea").addClass("textclass2");
		 autoBlockFormAndSetWH('pan'+tabStatus,80,5,'close'+tabStatus,"#ffffff",true,1000,'');//弹出查询面板 
		 clear();	
  		 queryByAccount();		 
  	if(tabStatus==11){		  	
  		 //置所有字段为不可读
  	 	$("#tdiv"+tabStatus+" input[type='text']").attr("disabled","disabled");
  		 $("#tdiv"+tabStatus+" textarea").attr("disabled","disabled");
		if($("#iDhlx11").val()==""){
				$("#iDhlx112").val("");
		}else{
				$("#iDhlx112").val($("#iDhlx11 option[selected]").text());
		}
		$("#iDhlx11").css("display","none");
		$("#iDhlx112").css("display","");
		$("#modify11").hide();	$("#save11").hide();	$("#save111").hide(); 	$("#reset11").hide();
		cancelTheOper('deptm','thedeptm');
		cancelTheOper('dept','thedept');	
		$("#jhj11").css("display","none");
	}else if(tabStatus==12){
  		 //置所有字段为不可读
		 $("#tdiv"+tabStatus+" input[type='text']").attr("disabled","disabled");
		 $("#modify12").hide();	$("#reset12").hide();
		 $("#iIsKeep21").html("<option value='0'><fmt:message key='numsno'/></option><option value='1'><fmt:message key='numsyes'/></option>");
		
		document.getElementById("iIsKeep12").style.display="none";
		document.getElementById("iIsKeep122").style.display = '';
		$("#iIsKeep122").val($("#iIsKeep12 option[selected]").text());
			
		$("#level12").css("display","none");	
		$("#modify21").hide(); $("#modifyB21").hide();	$("#save21").hide();	$("#save211").hide(); 	$("#reset21").hide();
	}else if(tabStatus==13){
  		 //置所有字段为不可读
		 $("#tdiv"+tabStatus+" input[type='text']").attr("disabled","disabled");
		$("#modify13").hide();	$("#save13").hide();	$("#save131").hide(); 	$("#reset13").hide();
	}else if(tabStatus==21){
  		 //置所有字段为不可读
	 $("#tdiv"+tabStatus+" input[type='text']").attr("disabled","disabled");
		 $("#jhj").css("display","none");
	  	 $("#level").css("display","none");  
	  	
  	 	$("#iIsKeep21").html("<option value='0'><fmt:message key='numsno'/></option><option value='1'><fmt:message key='numsyes'/></option>");
  			document.getElementById("iMokuaiJu21").style.display="none";
			document.getElementById("iMokuaiJu212").style.display = '';
			document.getElementById("iDhlx21").style.display="none";
			document.getElementById("iDhlx212").style.display = '';
			document.getElementById("iYwArea21").style.display="none";
			document.getElementById("iYwArea212").style.display = '';
			document.getElementById("iIsKeep21").style.display="none";
			document.getElementById("iIsKeep212").style.display = '';
			document.getElementById("iUserID21").style.display="none";
			document.getElementById("iUserID212").style.display = '';
			document.getElementById("iBz21").style.display="none";
			document.getElementById("iBz212").style.display = '';
			if($("#iMokuaiJu21").val()==""){
				$("#iMokuaiJu212").val("");
			}else{
				$("#iMokuaiJu212").val($("#iMokuaiJu21 option[selected]").text());
			}
		
			if($("#iDhlx21").val()==""){
				$("#iDhlx212").val("");
			}else{
				$("#iDhlx212").val($("#iDhlx21 option[selected]").text());
			}
		
			if($("#iYwArea21").val()==""){
				$("#iYwArea212").val("");
			}else{
				$("#iYwArea212").val($("#iYwArea21 option[selected]").text());
			}
		
			if($("#iIsKeep21").val()==""){
				$("#iIsKeep212").val("");
			}else{
				$("#iIsKeep212").val($("#iIsKeep21 option[selected]").text());
			}
			if($("#iUserID21").val()==""){
				$("#iUserID212").val("");
			}else{
				$("#iUserID212").val($("#iUserID21 option[selected]").text());
			}
			if($("#iBz21").val()==""){
				$("#iBz212").val("");
			}else{
				$("#iBz212").val($("#iBz21 option[selected]").text());
			}
		
			
			$("#modify21").hide(); $("#modifyB21").hide();	$("#save21").hide();	$("#save211").hide(); 	$("#reset21").hide();
     	
	
	}else if(tabStatus==22){
  		 //置所有字段为不可读
		 $("#tdiv"+tabStatus+" input[type='text']").attr("disabled","disabled");
	
			$("#iIsUse22").html("<option value='0'><fmt:message key='dangan.n'/></option><option value='1'><fmt:message key='dangan.y'/></option>");
			
			$("#iMokuaiJu22").css("display","none");
			$("#iMokuaiJu22i2").css("display","");
			$("#iIsUse22").css("display","none");
			$("#iIsUse222").css("display","");
			$("#iBz22").css("display","none");
			$("#iBz222").css("display","");
			
			if($("#iMokuaiJu22").val()==""){
				$("#iMokuaiJu22i2").val("");
			}else{
				$("#iMokuaiJu22i2").val($("#iMokuaiJu22 option[selected]").text());
			}
		if($("#iIsUse22").val()==""){
				$("#iIsUse222").val("");
			}else{
				$("#iIsUse222").val($("#iIsUse22 option[selected]").text());
			}
			if($("#iBz22").val()==""){
				$("#iBz222").val("");
			}else{
				$("#iBz222").val($("#iBz22 option[selected]").text());
			}		
		$("#modify22").hide(); $("#modifyB22").hide();	$("#save22").hide();	$("#save221").hide(); 	$("#reset22").hide();					
	}
		//把每个面板的第一个字段置为readonly
  			$("#iHMStart11").removeAttr("disabled");$("#iHMStart11").attr("readonly","readonly");
  			$("#iDh12").removeAttr("disabled");$("#iDh12").attr("readonly","readonly");
  			$("#iHm_Level13").removeAttr("disabled");$("#iHm_Level13").attr("readonly","readonly");
  			$("#iDh21").removeAttr("disabled");$("#iDh21").attr("readonly","readonly");
  			$("#iMokuaiJu222").removeAttr("disabled");$("#iMokuaiJu222").attr("readonly","readonly");
	
     	  	
     	 
  		
  		 }
  		 var ismodify=0;//第一个分析卡。0时是修改操作，1时是添加操作。
		/**
		 * 弹出修改面板
		 * @param bname
		 * @return 无返回值
		 */
		function openModify(bname)
		{
			$("#id").val(bname);
			var editright = $("#editright").val();
			if(editright=="true"){
						
				$(".top_03").html('<fmt:message key="global.edit" />');//标题	
				autoBlockFormAndSetWH('pan'+tabStatus,80,5,'close'+tabStatus,"#ffffff",true,1000,'');//弹出查询面板			 
				// ziduanControl();	 
					
			if(tabStatus==11){
							ismodify=0;
							 markTable(1);
							  
							clear();
							$("#modify11").hide();	$("#save11").hide();	$("#save111").hide(); 	$("#reset11").hide();
							cancelTheOper('deptm','thedeptm');
							cancelTheOper('dept','thedept');
						
						//所有字段置为不可修改
							 $("#tdiv"+tabStatus+" input[type='text']").attr("disabled","disabled");
							  $("#tdiv"+tabStatus+" textarea").attr("disabled","disabled");
	  						$("#tdiv"+tabStatus+" input[type='text']").removeClass();	$("#tdiv"+tabStatus+" input[type='text']").addClass("textclass2");
							$("#tdiv"+tabStatus+" textarea").removeClass();	$("#tdiv"+tabStatus+" textarea").addClass("textclass2");
							
							document.getElementById("iDhlx11").style.display="none";
							document.getElementById("iDhlx112").style.display="";
							$("#iDhlx112").val($("#iDhlx11 option[selected]").text());
							$("#jhj11").css("display","none");
							
							
							var editfields = $("#editfield1").val(); 
							var fields = getFields(getTable());					
							var fieldarr = fields.split(",");
							var spower = editfields.split(",");
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
											if(arr[i]=='PreHth'){
												$("#iPreHth11").removeAttr("disabled");
												$("#iPreHth11").removeClass();$("#iPreHth11").addClass("textclass");
											}else if(arr[i]=='Bz'){
												$("#iBz11").removeAttr("disabled");
												$("#iBz11").removeClass();$("#iBz11").addClass("textclass");
											}	
																						
											break;
									}
								}
							}
						}
		}else if(tabStatus==12){
				$("#iIsKeep21").html("<option value='0'><fmt:message key='numsno'/></option><option value='1'><fmt:message key='numsyes'/></option>");
					//置所有字段为disabled	
						 $("#tdiv"+tabStatus+" input[type='text']").attr("disabled","disabled");
	  					$("#tdiv"+tabStatus+" input[type='text']").removeClass();	$("#tdiv"+tabStatus+" input[type='text']").addClass("textclass2");
						
						$("#iIsKeep12").css("display","");
						$("#iIsKeep122").css("display","none");
						
						$("#level12").css("display","none");
							//权限控制
							var editfields = $("#editfield2").val(); 
							var fields = getFields(getTable());					
							var fieldarr = fields.split(",");
							var spower = editfields.split(",");
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
											if(arr[i]=='Dh_Level'){
												 $("#iDh_Level122").removeAttr("disabled");
												 //$("#iDh_Level122").attr("readonly","readonly");
												$("#iDh_Level122").removeClass();
												$("#iDh_Level122").addClass("textclass");
											}else if(arr[i]=='IsKeep'){
												 document.getElementById("iIsKeep12").style.display="";
												document.getElementById("iIsKeep122").style.display = 'none';
											}else if(arr[i]=='Bz'){
												$("#iBz12").removeAttr("disabled");
												$("#iBz12").removeClass();$("#iBz12").addClass("textclass");
											}	
																						
											break;
									}
								}
							}
						}
						
						$("#iMokuaiJu12").removeClass();
						$("#iMokuaiJu12").addClass("textclass");
						$("#iMokuaiJu12").removeAttr("disabled");
						$("#iMokuaiJu12").removeAttr("readonly");
						
					
						$("#modify21").hide(); $("#modifyB21").hide();	$("#save21").hide();	$("#save211").hide(); 	$("#reset21").hide();
						
						// 隐藏批量修改按钮
						$("#batchModify").hide();
						$("#modifyt22").show();
						
		}else if(tabStatus==13){
				markTable(1);
				//置所有字段为不可修改
				$("#tdiv"+tabStatus+" input[type='text']").attr("disabled","disabled");
	  			$("#tdiv"+tabStatus+" input[type='text']").removeClass();	$("#tdiv"+tabStatus+" input[type='text']").addClass("textclass");
			  				
			  				var editfields = $("#editfield3").val(); 
							var fields = getFields(getTable());					
							var fieldarr = fields.split(",");
							var spower = editfields.split(",");
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
											$('#i'+arr[i]+"13").removeAttr("disabled");	
											$('#i'+arr[i]+"13").removeClass();$('#i'+arr[i]+"13").addClass("textclass");
											if(arr[i]=='Hm_Level'){											
												 $("#iHm_Level13").attr("readonly","readonly");
											}	
																						
											break;
									}
								}
							}
						}
			  
				$("#modify13").hide();	$("#save13").hide();	$("#save131").hide(); 	$("#reset13").hide();
							
		}else if(tabStatus==21){
				markTable(1);
				$("#iIsKeep21").html("<option value='0'><fmt:message key='numsno'/></option><option value='1'><fmt:message key='numsyes'/></option>");
	  			
	     		 $("#jhj").css("display","none");
	  			 $("#level").css("display","none");
						
	     	 	document.getElementById("iMokuaiJu21").style.display="";
				document.getElementById("iMokuaiJu212").style.display = 'none';
				document.getElementById("iDhlx21").style.display="";
				document.getElementById("iDhlx212").style.display = 'none';
				document.getElementById("iYwArea21").style.display="";
				document.getElementById("iYwArea212").style.display = 'none';
				document.getElementById("iIsKeep21").style.display="";
				document.getElementById("iIsKeep212").style.display = 'none';
				document.getElementById("iUserID21").style.display="";
				document.getElementById("iUserID212").style.display = 'none';
				document.getElementById("iBz21").style.display="";
				document.getElementById("iBz212").style.display = 'none';
				
				$("#modify21").hide(); $("#modifyB21").hide();	$("#save21").hide();	$("#save211").hide(); 	$("#reset21").hide();
	     		//置所有字段为disabled
				$("#tdiv"+tabStatus+" input[type='text']").attr("disabled","disabled");
				$("#tdiv"+tabStatus+" select").attr("disabled","disabled");
	  			$("#tdiv"+tabStatus+" input[type='text']").removeClass();	$("#tdiv"+tabStatus+" input[type='text']").addClass("textclass");
			  	
			  			var editfields = $("#editfield4").val(); 
							var fields = getFields(getTable());					
							var fieldarr = fields.split(",");
							var spower = editfields.split(",");
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
											
											if(arr[i]=='Jhj_ID'){
												$("#iJhj_ID212").removeAttr("disabled");
									  			$("#iJhj_ID212").attr("readonly","readonly");
									  			$("#iJhj_ID212").removeClass();$("#iJhj_ID212").addClass("textclass");
											}else if(arr[i]=='Dh_Level'){
												$("#iDh_Level212").removeAttr("disabled");
									  			$("#iDh_Level212").attr("readonly","readonly");
									  			$("#iDh_Level212").removeClass();$("#iDh_Level212").addClass("textclass");
											}else{
												$('#i'+arr[i]+"21").removeAttr("disabled");	
												$('#i'+arr[i]+"21").removeClass();$('#i'+arr[i]+"21").addClass("textclass");
											}	
																						
											break;
									}
								}
							}
						}
						
							
		}else if(tabStatus==22){
				$("#iIsUse22").html("<option value='0'><fmt:message key='dangan.n'/></option><option value='1'><fmt:message key='dangan.y'/></option>");
				markTable(1);			
				$("#iMokuaiJu22").css("display","");
				$("#iMokuaiJu22i2").css("display","none");
				$("#iIsUse22").css("display","");
				$("#iIsUse222").css("display","none");
				$("#iBz22").css("display","");
				$("#iBz222").css("display","none");
				//置所有字段为不可修改
				$("#tdiv"+tabStatus+" select").attr("disabled","disabled");
					var editfields = $("#editfield5").val(); 
							var fields = getFields(getTable());					
							var fieldarr = fields.split(",");
							var spower = editfields.split(",");
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
											$('#i'+arr[i]+"22").removeAttr("disabled");										
											break;
									}
								}
							}
						}
						
				
				$("#modify22").hide(); $("#modifyB22").hide();	$("#save22").hide();	$("#save221").hide(); 	$("#reset22").hide();
							
		}	
							
				$("#modify"+tabStatus).show();$("#reset"+tabStatus).show();				
				queryByAccount(); //显示数据	
				
				//把每个面板的第一个字段置为readonly
	  			$("#iHMStart11").removeAttr("disabled");$("#iHMStart11").attr("readonly","readonly");
	  			$("#iDh12").removeAttr("disabled");$("#iDh12").attr("readonly","readonly");
	  			$("#iHm_Level13").removeAttr("disabled");$("#iHm_Level13").attr("readonly","readonly");
	  			$("#iDh21").removeAttr("disabled");$("#iDh21").attr("readonly","readonly");
	  			$("#iMokuaiJu222").removeAttr("disabled");$("#iMokuaiJu222").attr("readonly","readonly");
	  			$("#iHMStart11").removeClass();$("#iHMStart11").addClass("textclass2");
	  			$("#iDh12").removeClass();$("#iDh12").addClass("textclass2");
	  			$("#iHm_Level13").removeClass();$("#iHm_Level13").addClass("textclass2");
	  			$("#iDh21").removeClass();$("#iDh21").addClass("textclass2");
	  			$("#iMokuaiJu222").removeClass();$("#iMokuaiJu222").addClass("textclass2");
						
	  			}else{
							var operationtips = $("#operationtips").val();
							var editpower = $("#editpower").val();
							jAlert(editpower,operationtips);
				}
			
	}
  		 /**
		  * 修改操作
		  * @param 无参数
		  * @return 无返回值
		  */
  		 function modify(){  
  		 $("#isBatch").val("modify");
  		 var id=$("#id").val();	  		
  			var str=buildParam();
  			if(str==false) return false;
					var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'tsdBilling',
						 					tsdcf:'mssql',
						 					tsdoper:'exe',				 	
											tsdpk:'nums'+tabStatus+'.updateByAccount'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});
			urlstr=urlstr+str+"&"+getId()+"="+id;
		
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					type:'post',
					datatype:'exe',
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
							var log=$("#edith").val();	
							logwrite(3,log);
							querylist();								
					
					}
					
					}});
  		 }
               /***********************************集成操作**********************
               **********************************************************************************/               
          
				/**
				 * 执行复合查询出提交过来的相应操作
				 * @param 无参数
				 * @return 无返回值
				 */
				function fuheExe()
				{
					var queryName= document.getElementById("queryName").value;
					// 号码明细批量修改通道,须隐藏单独修改按钮,显示批量修改按钮
					$("#modifyt22").hide();
					$("#batchModify").show();
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
               
               /*****************************************************************************************************
               *****************组合排序
               **************************************************************************************************/
			/**
			 * 组合排序
			 * @param 无参数
			 * @return 无返回值
			 */
			function zhOrderExe(sqlstr){
			 		tsd.QualifiedVal=true; 
					if(tabStatus==22){
					sqlstr = sqlstr.replace(new RegExp('IsUse',"g"),"case when IsUse='1' then '"+"<fmt:message key='nums.yes' />"+"' when IsUse='0' then '"+"<fmt:message key='nums.no' />"+"' else ' ' end  ");		
					
					sqlstr = encodeURIComponent(sqlstr);
					if(tsd.Qualified()==false){return false;}
					}else if(tabStatus==21){
					sqlstr = sqlstr.replace(new RegExp('Jhj_ID',"g"),"replace(Jhj_ID,'&','&#38;')");		
					sqlstr = encodeURIComponent(sqlstr);
					
					}else if(tabStatus==12){
					sqlstr = sqlstr.replace(new RegExp('Jhj_ID',"g"),"replace(Jhj_ID,'&','&#38;')");
					sqlstr = encodeURIComponent(sqlstr);
					}else if(tabStatus==11){
					sqlstr = sqlstr.replace(new RegExp('Bz',"g"),"a.Bz");
					sqlstr = sqlstr.replace(new RegExp('Jhj_ID',"g"),"replace(b.JhjName,'&','&#38;')");
					sqlstr = sqlstr.replace(new RegExp('HMStart',"g"),"a.HMStart");
					sqlstr = sqlstr.replace(new RegExp('HMEnd',"g"),"a.HMEnd");
					sqlstr = sqlstr.replace(new RegExp('YwArea',"g"),"a.YwArea");
					sqlstr = sqlstr.replace(new RegExp('MokuaiJu',"g"),"a.MokuaiJu");					
					sqlstr = sqlstr.replace(new RegExp('Dhlx',"g"),"a.Dhlx");
					sqlstr = sqlstr.replace(new RegExp('PreHth',"g"),"a.PreHth");
					
					sqlstr = encodeURIComponent(sqlstr);
					
					}else{
					sqlstr = encodeURIComponent(sqlstr);
					}
		
		
				 var ids=1;
				if(tabStatus==11||tabStatus==12||tabStatus==13){
					ids=1;			
				}else{
					ids=2;
				}
				
				var params = fuheQbuildParams();			
				if(params=='&fusearchsql='){
							params +='1=1';
				}
		
				 params =params+'&orderby='+sqlstr;				    
							 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
							 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
															  clsname:'ExecuteSql',//类名
															  method:'exeSqlData',//方法名
															  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
															  tsdcf:'mssql',//指向配置文件名称
															  tsdoper:'query',//操作类型 
															  datatype:'xml',//返回数据格式 
															  tsdpk:'nums'+tabStatus+'.queryByOrder',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
															  tsdpkpagesql:'nums'+tabStatus+'.queryByOrderpage'
															});
								var link = urlstr1 + params;						
							 	$("#editgrid"+ids).setGridParam({url:'mainServlet.html?'+link+"&ziduans="+$("#ziduans"+tabStatus).val()}).trigger("reloadGrid");
							 	//setTimeout($.unblockUI, 15);//关闭面板
					 	
			}
		
			/**
			 * 复合查询操作
			 * @param 无参数
			 * @return 无返回值
			 */
			function fuheQuery()
			{	
				var ids=1;
				if(tabStatus==11||tabStatus==12||tabStatus==13){
					ids=1;			
				}else{
					ids=2;
				}
				var params = fuheQbuildParams();						
				if(params=='&fusearchsql='){
					params +='1=1';
				}	
				
				
			 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
			 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'nums'+tabStatus+'.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'nums'+tabStatus+'.fuheQueryByWherepage'
											});
				var link = urlstr1 + params;	
			 	$("#editgrid"+ids).setGridParam({url:'mainServlet.html?'+link+"&ziduans="+$("#ziduans"+tabStatus).val()}).trigger("reloadGrid");
			 	closeo();
			 	
			 			
			}
		
						 /*****************************************************************************************************
               *****************导出
               **************************************************************************************************/
           	 /**
			  * 复合查询参数获取
			  * @param 无参数
			  * @return 无返回值
			  */
			 function fuheQbuildParams(){
			 	//每次拼接参数必须初始化此参数
				tsd.QualifiedVal=true;
			 	var params='';
			 	var ss=$("#fusearchsql").val();
			 	
			 		if(tabStatus==22){
					//ss = ss.replace(new RegExp('IsUse',"g"),"case when IsUse='1' then '是' when IsUse='0' then '否' else ' ' end  ");		
					
					var fusearchsql = encodeURIComponent(ss);
					if(tsd.Qualified()==false){return false;}
					}else if(tabStatus==21){
					ss = ss.replace(new RegExp('Jhj_ID',"g"),"replace(Jhj_ID,'&','&#38;')");		
					var fusearchsql = encodeURIComponent(ss);
					
					}else if(tabStatus==12){
					ss = ss.replace(new RegExp('Jhj_ID',"g"),"replace(Jhj_ID,'&','&#38;')");
					var fusearchsql = encodeURIComponent(ss);
					}else if(tabStatus==11){
					ss = ss.replace(new RegExp('Bz',"g"),"a.Bz");
					ss = ss.replace(new RegExp('Jhj_ID',"g"),"replace(b.JhjName,'&','&#38;')");
					ss = ss.replace(new RegExp('HMStart',"g"),"a.HMStart");
					ss = ss.replace(new RegExp('HMEnd',"g"),"a.HMEnd");
					ss = ss.replace(new RegExp('YwArea',"g"),"a.YwArea");
					ss = ss.replace(new RegExp('MokuaiJu',"g"),"a.MokuaiJu");					
					ss = ss.replace(new RegExp('Dhlx',"g"),"a.Dhlx");
					ss = ss.replace(new RegExp('PreHth',"g"),"a.PreHth");
					var fusearchsql = encodeURIComponent(ss);
					
					}else{
					var fusearchsql = encodeURIComponent(ss);
					}
		
		
			 	
			 	//如果有可能值是汉字 请使用encodeURI()函数转码
			 	params+='&fusearchsql='+fusearchsql;			 	
			 	//注意：不要在此做空的判断 即使为空 也必须放入请求中			 	
			 	//每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}
				return params;
			 }	
		/**
		 * 导出
		 * @param 无参数
		 * @return 无返回值
		 */
		function print(){	
			printThisReport1('<%=request.getParameter("imenuid")%>',getTable_s(),getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');			
		}
	
	
	
/**
 * 生成号码库
 * @param 无参数
 * @return 无返回值
 */
function generate(HMStart){

	var exportright = $("#numsright").val();
	if(exportright=="true"){
			var result='';
			//调用存储过程生产号码资源
			//----存储过程调用方式  ：batchaddhmzy('HmStart=110;Func=addsome',cursor variable);
			var urlstr=tsd.buildParams({ 	 
				 	packgname:'service',
				  	clsname:'Procedure',
			 		method:'exequery',
				  	ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
				  	tsdpname:'nums.batchaddhmzy',//存储过程的映射名称
				  	tsdExeType:'query',
				  	datatype:'xmlattr'
			});
			
			$.ajax({
						url:'mainServlet.html?'+urlstr+'&HmStart='+HMStart+'&Func=addsome',
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							$(xml).find('row').each(function(){
								result = $(this).attr("result");									
							});
							if(result==1){							
								///生成号码库完成
								alert("<fmt:message key='numssu'/>");	
								//写入日志
								logForGenNum(HMStart);				
								setTimeout($.unblockUI, 15);//关闭面板					
							}
							else if(result==-1){
								alert("<fmt:message key='numgenfail'/>");
							}
						}
			});		
		}else{
  			var operationtips = $("#operationtips").val();						
			////jAlert("对不起，您没有生成号码库的权限",operationtips);
			jAlert("<fmt:message key='numsright'/>",operationtips);
  		}	
}
/**
 * 写入日志 
 	如果根据某一起始号码生产号码库成功，把相关信息写入日志表
 * @param HMStart： 起始号码
 * @return 无返回值
 */
function logForGenNum(HMStart){
	//根据起始电话，获取写入日志信息
				var HMEnd="";
				var YwArea="";
				var MokuaiJu="";
				var Bz="";
				var Dhlx="";
				var Jhj_ID=0;
				var PreHth="";
				var urlstr=tsd.buildParams({packgname:'service',
							 				clsname:'ExecuteSql',
							 				method:'exeSqlData',
							 				ds:'tsdBilling',
							 				tsdcf:'mssql',
							 				tsdoper:'query',
							 				datatype:'xmlattr',		 	
											tsdpk:'nums11.queryById'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									});	
				urlstr=urlstr+"&HMStart="+HMStart;
				
				$.ajax({
						url:'mainServlet.html?'+urlstr,
						type:'post',
						datatype:'exe',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式			
						success:function(xml){
						$(xml).find('row').each(function(){										
							HMEnd=$(this).attr("hmend");
							YwArea=$(this).attr("ywarea");
							MokuaiJu=$(this).attr("mokuaiju");
							Bz=$(this).attr("bz");
							Dhlx=$(this).attr("dhlx");
							Jhj_ID=$(this).attr("jhj_id");	
							///日志信息
							var log=$("#HMStart11").text()+":"+HMStart+";";
							log += $("#HMEnd11").text()+":"+HMEnd+";";
							log += $("#sdepartname").text()+":"+YwArea+";";
							log += $("#sdepartnamem").text()+":"+MokuaiJu+";";
							log += $("#Jhj_ID11").text()+":"+Jhj_ID+";";
							log += $("#Bz11").html()+":"+Bz+";";
							log += $("#Dhlx11").text()+":"+Dhlx+";";
							$("#loghaoma").val(log);						
						});				
					}});
					
					//写入日志		
					writeLogInfo("","yield nums",tsd.encodeURIComponent('(Hmzy_Detail)'.toLowerCase()+"<fmt:message key='numsyield'/>： "+$("#loghaoma").val()));
				
}
				
		/**
		 * 生成全部号码库
		 * @param 无参数
		 * @return 无返回值
		 */
		function generateAll(){	
				var result='';
				//调用存储过程生产全部号码资源
				//----存储过程调用方式  ：batchaddhmzy('Func=addall',cursor variable);
				var urlstr=tsd.buildParams({ 	 
					 	packgname:'service',
					  	clsname:'Procedure',
				 		method:'exequery',
					  	ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
					  	tsdpname:'nums.batchaddhmzy',//存储过程的映射名称
					  	tsdExeType:'query',
					  	datatype:'xmlattr'
				});
				
				$.ajax({
							url:'mainServlet.html?'+urlstr+'&Func=addall',
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 20000,
							async: false ,//同步方式
							success:function(xml){
								$(xml).find('row').each(function(){
									result = $(this).attr("result");									
								});
								if(result==1){							
									///生成号码库完成
									alert("<fmt:message key='numsyieldAll'/>");										
									//写入日志		
									writeLogInfo("","all nums",tsd.encodeURIComponent("(Hmzy_Detail)".toLowerCase()+"<fmt:message key='numsyieldAll'/>"));	
									//setTimeout($.unblockUI, 15);//关闭面板						
								}
								else if(result==-1){
									alert("<fmt:message key='numgenfail'/>");
								}
							}
				});				
									
							
			}
				
				
				
				
		

	
			 /*****************************************************************************************************
               *****************批量删除
               **************************************************************************************************/
			/**
			 * 打开复合删除面板	
			 * @param 无参数
			 * @return 无返回值
			 */
			function openwinD()
			{
						document.getElementById("queryName").value="delete";
						if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){  
							window.showModalDialog("/tsd2009/queryServlet?tablename="+getTable_s()+"&url=/search.jsp",window,"dialogWidth:700px; dialogHeight:500px; center:yes; scroll:no");
					    }
					    else{
							window.showModalDialog("/tsd2009/queryServlet?tablename="+getTable_s()+"&url=/search.jsp",window,"dialogWidth:690px; dialogHeight:600px; center:yes; scroll:no");
						}
			}
			/**
			 * 复合查询的批量删除操作	
			 * @param 无参数
			 * @return 无返回值
			 */
			function fuheDel(){
				var deleteinformation = $("#deleteinformation").val();
				var operationtips = $("#operationtips").val();	
				//jConfirm("确认要删除?",'提示对话框',function(x)
				jConfirm(deleteinformation,operationtips,function(x){
			 		if(x==true)
			 		{	
			 		var params = fuheQbuildParams();							    
			 		//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
				 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
												  clsname:'ExecuteSql',//类名
												  method:'exeSqlData',//方法名
												  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												  tsdcf:'mssql',//指向配置文件名称
												  tsdoper:'exe',//操作类型 
												  datatype:'xml',//返回数据格式 
												  tsdpk:'nums'+tabStatus+'.fuheDeleteBy'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												  
												});
					var link='mainServlet.html?'+urlstr1+params; 					
				 	$.ajax({
							url:link,
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(msg){
								if(msg=="true"){
									var operationtips = $("#operationtips").val();
									var successful = $("#successful").val();									
									jAlert(successful,operationtips);	
									logwrite(4,"<fmt:message key="oper.condition"/>:"+$("#areah").val());	
									querylist();		
								}	
							}
						});
					}
				});		
			}
		/*****************************************
		批量修改
		**********************************************************************************************************/
			/**
			 * 打开批修改面板		
			 * @param 无参数
			 * @return 无返回值
			 */
			function openwinM()
			{  
						document.getElementById("queryName").value="modify";
						if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){  
							window.showModalDialog("/tsd2009/queryServlet?tablename="+getTable_s()+"&url=/search.jsp",window,"dialogWidth:700px; dialogHeight:500px; center:yes; scroll:no");
					    }
					    else{
							window.showModalDialog("/tsd2009/queryServlet?tablename="+getTable_s()+"&url=/search.jsp",window,"dialogWidth:690px; dialogHeight:600px; center:yes; scroll:no");
						}	
						
			}
			/**
			 * 打开复合批量修改面板	
			 * @param 无参数
			 * @return 无返回值
			 */
			function fuheOpenModify()
			{	
					$(".top_03").html('<fmt:message key="tariff.modifyb" />');//标题
  					// openpan(2);
  					autoBlockFormAndSetWH('pan'+tabStatus,80,5,'close'+tabStatus,"#ffffff",true,1000,'');//弹出查询面板
  					 clear();
  					 markTable(1);
  			 if(tabStatus=='21'){
  					 	$("#iJhj_ID212").val("");
						$("#iDh_Level212").val("");
						$("#iJhj_ID21").val("");
						$("#iDh_Level21").val("");
						$("#iIsKeep21").html("<option value=''>--<fmt:message key='global.select'/>--</option><option value='0'><fmt:message key='numsno'/></option><option value='1'><fmt:message key='numsyes'/></option>");
			  			
			     		 $("#jhj").css("display","none");
  				   		 $("#level").css("display","none");  				   		 
								
			     	 	document.getElementById("iMokuaiJu21").style.display="";
						document.getElementById("iMokuaiJu212").style.display = 'none';
						document.getElementById("iDhlx21").style.display="";
						document.getElementById("iDhlx212").style.display = 'none';
						document.getElementById("iYwArea21").style.display="";
						document.getElementById("iYwArea212").style.display = 'none';
						document.getElementById("iIsKeep21").style.display="";
						document.getElementById("iIsKeep212").style.display = 'none';
						document.getElementById("iUserID21").style.display="";
						document.getElementById("iUserID212").style.display = 'none';
						document.getElementById("iBz21").style.display="";
						document.getElementById("iBz212").style.display = 'none';
						$("#modify21").hide(); $("#modifyB21").show();	$("#save21").hide();	$("#save211").hide(); 	$("#reset21").hide();
			     		
			     		//置所有字段为disabled
						$("#tdiv"+tabStatus+" input[type='text']").attr("disabled","disabled");
						$("#tdiv"+tabStatus+" select").attr("disabled","disabled");
			  			$("#tdiv"+tabStatus+" input[type='text']").removeClass();	$("#tdiv"+tabStatus+" input[type='text']").addClass("textclass");
		  	
						var editfields = $("#editfield4").val(); 
						var fields = getFields(getTable());					
						var fieldarr = fields.split(",");
						var spower = editfields.split(",");
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
										
										if(arr[i]=='Jhj_ID'){
											$("#iJhj_ID212").removeAttr("disabled");
								  			$("#iJhj_ID212").attr("readonly","readonly");
								  			$("#iJhj_ID212").removeClass();$("#iJhj_ID212").addClass("textclass");
										}else if(arr[i]=='Dh_Level'){
											$("#iDh_Level212").removeAttr("disabled");
								  			$("#iDh_Level212").attr("readonly","readonly");
								  			$("#iDh_Level212").removeClass();$("#iDh_Level212").addClass("textclass");
										}else{
											$('#i'+arr[i]+"21").removeAttr("disabled");	
											$('#i'+arr[i]+"21").removeClass();$('#i'+arr[i]+"21").addClass("textclass");
										}	
																					
										break;
								}
							}
						}
					}
						$("#iDh21").removeAttr("disabled");$("#iDh21").attr("readonly","readonly");
						$("#iDh21").removeClass();$("#iDh21").addClass("textclass2");
			}else if(tabStatus==22){
							$("#iIsUse22").html("<option value=''>--<fmt:message key='global.select'/>--</option><option value='0'><fmt:message key='dangan.n'/></option><option value='1'><fmt:message key='dangan.y'/></option>");
							markTable(1);							
							$("#iMokuaiJu22").css("display","");
							$("#iMokuaiJu22i2").css("display","none");
							$("#iIsUse22").css("display","");
							$("#iIsUse222").css("display","none");
							$("#iBz22").css("display","");
							$("#iBz222").css("display","none");
							$("#modify22").hide(); $("#modifyB22").show();	$("#save22").hide();	$("#save221").hide(); 	$("#reset22").hide();
										
							//置所有字段为不可修改
						$("#tdiv"+tabStatus+" select").attr("disabled","disabled");
							var editfields = $("#editfield5").val(); 
									var fields = getFields(getTable());					
									var fieldarr = fields.split(",");
									var spower = editfields.split(",");
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
													$('#i'+arr[i]+"22").removeAttr("disabled");										
													break;
											}
										}
									}
								}
								
						$("#iMokuaiJu222").removeAttr("disabled");$("#iMokuaiJu222").attr("readonly","readonly");
						$("#iMokuaiJu222").removeClass();$("#iMokuaiJu222").addClass("textclass2");
				}	
  					
  		}
  		/**
		 * 修改操作
		 * @param 无参数
		 * @return 无返回值
		 */
  		function fuheModify()
		{
			var m = fuheQbuildParams();	
			if(m=='&fusearchsql='){
				m +='1=1';
			}
			var p = MbuildParams();
			if(p==false)
			{
				return false;
			}
			var params="";
			params=params+p+m;	
			//alert(m+"----"+p);
			
			var urlstr=tsd.buildParams({  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'exe',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:'nums'+tabStatus+'.fuheModifyBy'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										});
		 	urlstr+=params;
		 	alert(urlstr);
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
						var str ="("+getTable()+")(<fmt:message key='tariff.modifyb'/>)。"+"<fmt:message key='global.newVal'/>: "+$("#logoldstr").val()+"<fmt:message key='global.conditions'/> ："+$("#fusearchsql").val();
						str = transferApos(str);
						writeLogInfo("","Batch Edit",tsd.encodeURIComponent(str));
						fuheQuery();
					}	
				}
			});
			
		}
		/**
		 * 构造参数
		 * @param 无参数
		 * @return 无返回值
		 */
  		function MbuildParams(){
  		var params = "";
  		alert("tabStatus:"+tabStatus);
  		// 号码资源明细修改
  		if( tabStatus=='12' )
  		{
  			var modifySet="set";
  			// 是否保留
  			var isKeep = $("#iIsKeep12").val();
  			if( isKeep != "" )
  			{
  				modifySet = modifySet + ' ISKEEP=\''+isKeep+'\'';
  			}
  			// 模块局
  			var mkj = $("#iMokuaiJu12").val();
  			if( mkj != "" )
  			{
  				modifySet = modifySet + ',MokuaiJu=\''+tsd.encodeURIComponent(mkj)+'\'';
  			}
  			// 号码级别
  			var level = $("#iDh_Level12").val();
  			if( level != "" )
  			{
  				modifySet = modifySet + ',DH_LEVEL=\''+level+'\'';
  			}
  			params+="&modifySet=" + modifySet;
  		}
  		if(tabStatus=='21'){
  				params="";	
           	tsd.QualifiedVal=true;  
           	var modifyStr="set";
			var modifySet='set';				  
			var iFeeStopType=$("#iDh_Level21").val();
			if($("#iDh_Level212").val()==""){iFeeStopType="";}
			if(iFeeStopType!="-1"&&iFeeStopType!=""&&modifySet=="set"){
			modifySet=modifySet+' Dh_Level='+iFeeStopType;
			modifyStr=modifyStr+' Dh_Level=\''+iFeeStopType+'\'';
			}	
			var FeeType=$("#iIsKeep21").val();
			if(FeeType!='-1'&&FeeType!=""&&modifySet=="set"){
			modifySet=modifySet+" IsKeep="+FeeType;	
			modifyStr=modifyStr+" IsKeep=\'"+FeeType+'\'';	
			}else if(FeeType!='-1'&&FeeType!=""&&modifySet!="set"){
			modifySet=modifySet+", IsKeep="+FeeType;	
			modifyStr=modifyStr+" IsKeep=\'"+FeeType+'\'';	
			}	
			var Value=$("#iMokuaiJu21").val();
			if(Value!=""&&modifySet=="set"){
			modifySet=modifySet+' MokuaiJu=\''+tsd.encodeURIComponent(Value)+'\'';
			modifyStr=modifyStr+' MokuaiJu=\''+Value+'\'';
			}else if(Value!=""&&modifySet!="set"){
			modifySet=modifySet+', MokuaiJu=\''+tsd.encodeURIComponent(Value)+'\'';
			modifyStr=modifyStr+' MokuaiJu=\''+Value+'\'';
			}	
			var Value=$("#iDhlx21").val();
			if(Value!=""&&modifySet=="set"){
			modifySet=modifySet+' Dhlx=\''+tsd.encodeURIComponent(Value)+'\'';
			modifyStr=modifyStr+' Dhlx=\''+Value+'\'';
			}else if(Value!=""&&modifySet!="set"){
			modifySet=modifySet+', Dhlx=\''+tsd.encodeURIComponent(Value)+'\'';
			modifyStr=modifyStr+' Dhlx=\''+Value+'\'';
			}	
			var FeeType=$("#iJhj_ID21").val();
			if($("#iJhj_ID212").val()==""){FeeType="";}
			if(FeeType!=""&&modifySet=="set"){
			modifySet=modifySet+" Jhj_ID="+FeeType;	
			modifyStr=modifyStr+" Jhj_ID=\'"+FeeType+'\'';	
			}else if(FeeType!=""&&modifySet!="set"){
			modifySet=modifySet+", Jhj_ID="+FeeType;	
			modifyStr=modifyStr+" Jhj_ID=\'"+FeeType+'\'';	
			}		
			var Value=$("#iYwArea21").val();
			if(Value!=""&&modifySet=="set"){			
			modifySet=modifySet+' YwArea=\''+tsd.encodeURIComponent(Value)+'\'';
			modifyStr=modifyStr+' YwArea=\''+Value+'\'';
			}else if(Value!=""&&modifySet!="set"){			
			modifySet=modifySet+', YwArea=\''+tsd.encodeURIComponent(Value)+'\'';
			modifyStr=modifyStr+' YwArea=\''+Value+'\'';
			}	
			var Value=$("#iBz21").val();
			if(Value!=""&&modifySet=="set"){
			modifySet=modifySet+' Bz=\''+tsd.encodeURIComponent(Value)+'\'';
			modifyStr=modifyStr+' Bz=\''+Value+'\'';
			}else if(Value!=""&&modifySet!="set"){
			modifySet=modifySet+', Bz=\''+tsd.encodeURIComponent(Value)+'\'';
			modifyStr=modifyStr+' Bz=\''+Value+'\'';
			}	
			if(modifySet=="set"){			 		
			 			var operationtips = $("#operationtips").val();
						//jAlert("请输入修改内容!","操作提示")	
			 			jAlert('<fmt:message key="tariff.modifyinfo"/>','<fmt:message key="global.operationtips"/>');
			 			return false;
			 	}	
				$("#logoldstr").val(modifyStr);		  		
			 	params+="&modifySet="+modifySet;			
				if(tsd.Qualified()==false){return false;}
		}else if(tabStatus=='22'){
			var params="";	
           	tsd.QualifiedVal=true;  
           	var modifyStr="set";
			var modifySet='set';				  
			var iFeeStopType=$("#iMokuaiJu22").val();
			if(iFeeStopType!=""&&modifySet=="set"){
			modifySet=modifySet+' MokuaiJu=\''+tsd.encodeURIComponent(iFeeStopType)+'\'';
			modifyStr=modifyStr+' MokuaiJu=\''+iFeeStopType+'\'';
			}
			var FeeType=$("#iMokuaiJu222").val();
			if(FeeType!=""&&modifySet=="set"){
			modifySet=modifySet+" MokuaiJu2=\'"+tsd.encodeURIComponent(FeeType)+'\'';	
			modifyStr=modifyStr+" MokuaiJu2=\'"+FeeType+'\'';	
			}else if(FeeType!=""&&modifySet!="set"){
			modifySet=modifySet+", MokuaiJu2=\'"+tsd.encodeURIComponent(FeeType)+'\'';	
			modifyStr=modifyStr+" MokuaiJu2=\'"+FeeType+'\'';	
			}	
			var Value=$("#iIsUse22").val();
			if(Value!=""&&modifySet=="set"){
			modifySet=modifySet+' IsUse=\''+tsd.encodeURIComponent(Value)+'\'';
			modifyStr=modifyStr+' IsUse=\''+Value+'\'';
			}else if(Value!=""&&modifySet!="set"){
			modifySet=modifySet+', IsUse=\''+tsd.encodeURIComponent(Value)+'\'';
			modifyStr=modifyStr+' IsUse=\''+Value+'\'';
			}	
			var Value=$("#iBz22").val();
			if(Value!=""&&modifySet=="set"){
			modifySet=modifySet+' Bz=\''+tsd.encodeURIComponent(Value)+'\'';
			modifyStr=modifyStr+' Bz=\''+Value+'\'';
			}else if(Value!=""&&modifySet!="set"){
			modifySet=modifySet+', Bz=\''+tsd.encodeURIComponent(Value)+'\'';
			modifyStr=modifyStr+' Bz=\''+Value+'\'';
			}
			if(modifySet=="set"){			 		
			 			jAlert('<fmt:message key="tariff.modifyinfo"/>');
			 			return false;
			 	}	
				$("#logoldstr").val(modifyStr);		  		
			 	params+="&modifySet="+modifySet;				
				if(tsd.Qualified()==false){return false;}
		
		}
		return params;
  		}
  		 
		</script>
		 <script type="text/javascript">  	 
			 /**
			  * 下载excel
			  * @param 无参数
			  * @return 无返回值
			  */
			 function exportdata(){				 	
				 thisDownLoad('tsdBilling','mssql',getTable(),$("#languageType").val());		
			 } 
/**
 * 下载excel
 * @param 无参数
 * @return 无返回值
 */			 
function saveExoprt(){
		var table="";
		switch(tabStatus)
					{
						case 11:
							table="Hmzy a LEFT OUTER JOIN JhjID b ON a.Jhj_ID = b.JhjID";
							break;
						case 12:
							table="vw_Hmzy_Detail";
							break;
						case 13:
							table="Ywsl_HmLevel";
							break;
						case 21:
							table="vw_Hmzy_Detail";
							break;
						case 22:
							table="mokuaiju2";
							break;
		}	
		
		if(tabStatus==11){
			 	getTheCheckedFieldstwo('tsdBilling','mssql','Hmzy'.toLowerCase(),table)
	 	}else if(tabStatus==12){
	 			getTheCheckedFieldstwo('tsdBilling','mssql','Hmzy_Detail'.toLowerCase(),'vw_Hmzy_Detail')
	 	}else if(tabStatus==21){
	 			getTheCheckedFieldstwo('tsdBilling','mssql','Hmzy_Detail'.toLowerCase(),'vw_Hmzy_Detail')
	 	}else{
	 			getTheCheckedFields('tsdBilling','mssql',getTable());
	 	}			
 } 
				/**
				 * 拼接要显示的数据列main.js中有关导出数据的函数是  thisDataDownload,checkedAllFields,getTheCheckedFields,
				 * @param 无参数
				 * @return 无返回值
				 */	
				function displayFields(tablename){
					
					var thearr = new Array();
						 var urlstr=tsd.buildParams({ 
    										packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',//返回数据格式 
						 					tsdpk:'roleManager.gettheeditfields'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					});
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&tablename='+tablename,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								$(xml).find('row').each(function(){
										var thefieldname = $(this).attr("field_name") ;
										var thefieldalias = getCaption($(this).attr("field_alias"),'<%=languageType %>','');
										if(thefieldalias!=''){
										if(tabStatus==22){
											thefieldname = thefieldname.replace(new RegExp('IsUse',"g"),"case when IsUse='1' then '"+"<fmt:message key='nums.yes' />"+"' when IsUse='0' then '"+"<fmt:message key='nums.no' />"+"' else ' ' end  ");		
											}else if(tabStatus==11){											
											thefieldname = thefieldname.replace(new RegExp('Jhj_ID',"g"),"b.JhjName");
											thefieldname = thefieldname.replace(new RegExp('HMStart',"g"),"a.HMStart");
											thefieldname = thefieldname.replace(new RegExp('HMEnd',"g"),"a.HMEnd");
											thefieldname = thefieldname.replace(new RegExp('YwArea',"g"),"a.YwArea");
											thefieldname = thefieldname.replace(new RegExp('MokuaiJu',"g"),"a.MokuaiJu");
											thefieldname = thefieldname.replace(new RegExp('Bz',"g"),"a.Bz");
											thefieldname = thefieldname.replace(new RegExp('Dhlx',"g"),"a.Dhlx");
											thefieldname = thefieldname.replace(new RegExp('PreHth',"g"),"a.PreHth");
											
											}
										var disvalue = tsd.encodeURIComponent(thefieldname) + ' as ' + tsd.encodeURIComponent(thefieldalias);
											
										thearr.push(disvalue);
										}
								 });
							 }
						 });
					return thearr;
				}
				
				
	</script>
		<script type="text/javascript">
				/**
				 * 遍历list之前
				 * @param 无参数
				 * @return 无返回值
				 */	
		function listfirst(){
		//号码分配-号码级别的下拉表
		Dhlx();		
		//号码资源>>>号码资源二级模块域调整---号码资源调整		
		listAreaHmLevel();//级别号		
		listAreaMokuaiJu();//模块局		
		listAreaTel();//电话类型	
		
		listAreaJhjID();//交换机编号		
		listAreaYwsl();//业务区域  受理点		
		listAreaMokuaiJu2();//二级模块局
		
		}
				/**
				 * 获取电话联系下拉列表
				 * @param 无参数
				 * @return 无返回值
				 */
			 function Dhlx(){  
			 $("#iDhlx11").empty();														
  		  var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'tsdBilling',
						 					tsdcf:'mssql',
						 					tsdoper:'query',
						 					datatype:'xmlattr',				 	
											tsdpk:'nums11.tel'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});		
			urlstr=urlstr;		
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){															
							var lxmc=$(this).attr("lxmc");																										
							document.getElementById("iDhlx11").options.add(new Option(lxmc,lxmc));															
						});		
				
					}});
				
				}
				
	/**
	 * 级别号
	 * @param 无参数
	 * @return 无返回值
	 */
	 function listAreaHmLevel(){  	
	 var  ss='<tr bgcolor="#E0EEF5"><td width="26%"><fmt:message key="nums.numbergrade" /></td><td width="38%"><fmt:message key="nums.remark" /></td></tr>';													
  		  var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'tsdBilling',
						 					tsdcf:'mssql',
						 					tsdoper:'query',
						 					datatype:'xmlattr',				 	
											tsdpk:'nums21.query1'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});		
			urlstr=urlstr;		
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){															
							var hm_level=$(this).attr("hm_level");
							var bz=$(this).attr("bz");
							var d=hm_level+" "+bz;																				
							//document.getElementById("iDh_Level21").options.add(new Option(d,hm_level));	
							ss+="<tr><td>"+hm_level+"</td><td>"+bz+"</td><tr>";
																						
						});		
				
					}});
				$("#tabb").html(ss);
				$("#tabl").html(ss);
				}
			/**
			 * 模块局
			 * @param 无参数
			 * @return 无返回值
			 */
			 function listAreaMokuaiJu(){  														
  		  var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'tsdBilling',
						 					tsdcf:'mssql',
						 					tsdoper:'query',
						 					datatype:'xmlattr',				 	
											tsdpk:'nums21.query2'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});		
			urlstr=urlstr;		
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){															
							var MokuaiJu=$(this).attr("mokuaiju");															
							document.getElementById("iMokuaiJu21").options.add(new Option(MokuaiJu,MokuaiJu));	
							document.getElementById("iMokuaiJu22").options.add(new Option(MokuaiJu,MokuaiJu));	
							
							//号码资源明显的查询功能
							document.getElementById("iiMokuaiJu12").options.add(new Option(MokuaiJu,MokuaiJu));	
							
							document.getElementById("iiMokuaiJu22").options.add(new Option(MokuaiJu,MokuaiJu));															
						});		
				
					}});
				
				}
					/**
					 * 电话类型
					 * @param 无参数
					 * @return 无返回值
					 */
					 function listAreaTel(){  														
  		  var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'tsdBilling',
						 					tsdcf:'mssql',
						 					tsdoper:'query',
						 					datatype:'xmlattr',				 	
											tsdpk:'nums21.query3'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});		
			urlstr=urlstr;		
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){															
							var MokuaiJu=$(this).attr("lxmc");															
							document.getElementById("iDhlx21").options.add(new Option(MokuaiJu,MokuaiJu));															
						});		
				
					}});
				
				}
				/**
				 * 交换机编号
				 * @param 无参数
				 * @return 无返回值
				 */
				function listAreaJhjID(){
				var  ss='<tr bgcolor="#E0EEF5"><td width="26%"><fmt:message key="nums.switchnumber" /></td><td width="38%"><fmt:message key="nums.switchstyle" /></td><td width="36%"><fmt:message key="nums.switchplace" /></td></tr>';
										
  		  var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'tsdBilling',
						 					tsdcf:'mssql',
						 					tsdoper:'query',
						 					datatype:'xmlattr',				 	
											tsdpk:'nums21.query4'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					
					$(xml).find('row').each(function(){	
																			
							var JhjID=$(this).attr("jhjid");////程控机编号
							var JhjName=$(this).attr("jhjname");////程控机名称
							var JhjArea=$(this).attr("jhjarea");///程控机站点				
							ss+="<tr><td>"+JhjID+"</td><td>"+JhjName+"</td><td>"+JhjArea+"</td></tr>";	
																					
						});		
				
					}});
					
 					$("#tabjj").html(ss);
 					$("#tabjhj").html(ss);
				
				}
		/**
		 * 业务区域  受理点
		 * @param 无参数
		 * @return 无返回值
		 */
		 function listAreaYwsl(){  														
  		  var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'tsdBilling',
						 					tsdcf:'mssql',
						 					tsdoper:'query',
						 					datatype:'xmlattr',				 	
											tsdpk:'nums21.query5'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});		
			urlstr=urlstr;		
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){															
							var YwArea=$(this).attr("ywarea");	
							document.getElementById("iYwArea21").options.add(new Option(YwArea,YwArea));
							//号码资源明显的查询功能
							document.getElementById("iiYwArea12").options.add(new Option(YwArea,YwArea));															
						});		
				
					}});
				
				}
		/**
		 * 二级模块局
		 * @param 无参数
		 * @return 无返回值
		 */
		 function listAreaMokuaiJu2(){  														
  		  var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'tsdBilling',
						 					tsdcf:'mssql',
						 					tsdoper:'query',
						 					datatype:'xmlattr',				 	
											tsdpk:'nums21.query6'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});		
			urlstr=urlstr;		
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){															
							var MokuaiJu2=$(this).attr("mokuaiju2");			
							document.getElementById("iBz21").options.add(new Option(MokuaiJu2,MokuaiJu2));	
							document.getElementById("iBz22").options.add(new Option(MokuaiJu2,MokuaiJu2));
							//查询功能
							document.getElementById("iiBz22").options.add(new Option(MokuaiJu2,MokuaiJu2));															
						});		
				
					}});
				
				}
					/***********************号码资源设置>>>号码分配*****************下拉多选开始***************************/
				
					/**
					 * 模块局
					 * @param 无参数
					 * @return 无返回值
					 */
					function isDeptm(){$('#thestate').val(1);}
		function getTheDeptm(){
				getDeptNamem();
				document.getElementById('deptm').style.display = 'none';
				document.getElementById('thedeptm').style.display = 'block';
			}
			function getDeptNamem(){
					$('#thedeptformm').remove();
						    var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'tsdBilling',
						 					tsdcf:'mssql',
						 					tsdoper:'query',
						 					datatype:'xmlattr',				 	
											tsdpk:'nums11.mokuai'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});	
						$.ajax({
							url:'mainServlet.html?'+urlstr,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){//将返回的结果集生成一个form出来
									var thevalue='<table width="400" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #dfe0e1; padding:5px; background:#f6f7f8; font-size:12px;margin:5px 0px; ">';
									thevalue +='<tr><td height="35" colspan="2">'+"<input type='button'  id='checkall' onclick=isCheckedAll('deptsm',true); value='"+"<fmt:message key='nums.selectall' />"+"' style='width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;line-height:25px;  margin-left:10px;'><input type='button'  id='uncheckall' onclick=isCheckedAll('deptsm',false); value='"+"<fmt:message key='nums.selectopposite' />"+"' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button'  onclick=getCheckValue('imokuaiju','thedeptm','deptm','deptsm') value='"+"<fmt:message key='nums.sure' />"+"' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button'  onclick=cancelTheOper('deptm','thedeptm') value='"+"<fmt:message key='nums.cancel' />"+"' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'>"+'</td></tr>';
									var i=0;
										$(xml).find('row').each(function(){//生成复选框
										i++;
										if(i==1){
										thevalue +='<tr ><td height="20" color="#666666"> '+"<input type='checkbox' name='deptsm' value='"+$(this).attr("mokuaiju")+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+$(this).attr("mokuaiju")+"</label>"+'</td>';
										}else if(i==2){
										thevalue +='<td color="#666666"> '+"<input type='checkbox' name='deptsm' value='"+$(this).attr("mokuaiju")+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+$(this).attr("mokuaiju")+"</label>"+'</td></tr>';
										}									
										if(i==2){i=0;}
										 	
										});//将form填充到那个span中
									thevalue +='</table>';	
										$('#thedeptm').html(thevalue);
							}
						});
						//这个是在对用户信息进行修改的时候将用户以前的值默认为选中状态
						var thestate = $('#thestate').val();
						if(thestate==1){
							var thestavalue = $('#imokuaiju').val();
							forChecked('deptsm',thestavalue);
						}
						
				}
				
			// 电话号码资源修改模块局列表添加
			function addMkj()
			{
				var sLen = $("#mkj option").size();
				// 获取当前模块局信息
				var cMokuaiju = $("#iMokuaiJu12").val();
				// 判定当前 option 是否已有值
				if( sLen <= 1 )
				{
				    var urlstr=tsd.buildParams({packgname:'service',
				 					clsname:'ExecuteSql',
				 					method:'exeSqlData',
				 					ds:'tsdBilling',
				 					tsdcf:'mssql',
				 					tsdoper:'query',
				 					datatype:'xmlattr',				 	
									tsdpk:'nums11.mokuai'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						});	
						
						$.ajax({
							url:'mainServlet.html?'+urlstr,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								$("#mkj").find("option").remove();
								$("#mkj").addClass("textclass");
								// 遍历模块局信息添加至下拉列表控件
								$(xml).find('row').each(function(){
									var tmp = $(this).attr("mokuaiju");
									// 将当前值选中
									if( tmp == cMokuaiju )
										$("#mkj").append("<option value='"+tmp+"' selected>"+tmp+"</option>");
									else
										$("#mkj").append("<option value='"+tmp+"'>"+tmp+"</option>");
								});
							}
						});
				}
				// 选中当前模块局
				else
				{
					$("#mkj").val(cMokuaiju);
				}
				
			}
			
			// 修改号码资源信息时选中模块局后赋值到隐藏域
			function setMkj()
			{
				var mkj = $("#mkj option:selected").text();
				$("#iMokuaiJu12").val(mkj);
			}
			
			/**
			 * 已选择部门
			 * @param 无参数
			 * @return 无返回值
			 */
			function isDept(){$('#thestate').val(1);//$('#isdept').val(1)
			}
			function getTheDept(){
				getDeptName();
				document.getElementById('dept').style.display = 'none';
				document.getElementById('thedept').style.display = 'block';
			}
			function getDeptName(){
					$('#thedeptform').remove();
						  var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'tsdBilling',
						 					tsdcf:'mssql',
						 					tsdoper:'query',
						 					datatype:'xmlattr',				 	
											tsdpk:'nums11.yewu'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});
						$.ajax({
							url:'mainServlet.html?'+urlstr,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){//将返回的结果集生成一个form出来
							
									var thevalue='<table width="400" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #dfe0e1; padding:5px; background:#f6f7f8; font-size:12px;margin:5px 0px; ">';
									thevalue +='<tr><td height="35" colspan="2">'+"<input type='button' id='checkall' onclick=isCheckedAll('depts',true); value='"+"<fmt:message key='nums.selectall' />"+"' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button' id='uncheckall' onclick=isCheckedAll('depts',false); value='"+"<fmt:message key='nums.selectopposite' />"+"' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button' onclick=getCheckValue('iywlx','thedept','dept','depts') value='"+"<fmt:message key='nums.sure' />"+"' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button' onclick=cancelTheOper('dept','thedept') value='"+"<fmt:message key="nums.cancel" />"+"' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'>"+'</td></tr>';
									var i=0;
										$(xml).find('row').each(function(){//生成复选框
										i++;
										if(i==1){
										thevalue +='<tr ><td height="20" color="#666666"> '+"<input type='checkbox' name='depts' value='"+$(this).attr("ywarea")+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+$(this).attr("ywarea")+"</label>"+'</td>';
										}else if(i==2){
										thevalue +='<td color="#666666"> '+"<input type='checkbox' name='depts' value='"+$(this).attr("ywarea")+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+$(this).attr("ywarea")+"</label>"+'</td></tr>';
										}									
										if(i==2){i=0;}
										 	
										});//将form填充到那个span中
									thevalue +='</table>';	
										$('#thedept').html(thevalue);
							}
						});
						//这个是在对用户信息进行修改的时候将用户以前的值默认为选中状态
						var thestate = $('#thestate').val();
						if(thestate==1){
							var thestavalue = $('#iywlx').val();
							forChecked('depts',thestavalue);
						}
						
				}
			/**
			 * 公用的
			 * @param 无参数
			 * @return 无返回值
			 */
			function isCheckedAll(name,state){
			var tagname=document.getElementsByName(name);  
			if(state==true){
				for(var i=0;i<tagname.length;i++){
		        	tagname[i].checked = state;
		    	} 
			}
			else{
				for(var i=0;i<tagname.length;i++){
		        	if(tagname[i].checked ==true) {
		        		tagname[i].checked =false
		        	}else{
		        		tagname[i].checked =true
		        	}        	
		    	}
			}        
		}
			/**
			 * 更新是添加还是修改
			 * @param str
			 * @return 无返回值
			 */
			function theState(str){
				$('#thestate').val(str);
			}
			//获取已经选中的值
			function forChecked(name,thisvalue){
				if(''!=thisvalue&&null!=thisvalue){
					var thenum = thisvalue.lastIndexOf('~');
					var m = 0;
					if(thenum==-1){
					thisvalue += '~';
					m = 1;
					}
					var thearr = thisvalue.split('~');
					var tagname=document.getElementsByName(name);
				  
				//获取name的所有的值
					for(var i = 0 ; i < tagname.length;i++){
					//获取以前的记录选中值
						for(var j = 0;j<thearr.length-m;j++){
						if(tagname[i].value==thearr[j]){
						        tagname[i].checked = true;
						        break;
						    }
						}
					}
				}
			}			
				
				/**
				 * 获取被选中的值
				 * @param name
				 * @return String
				 */
				function getTheChecked(name){
					var thename=document.getElementsByName(name);  
				    
				    var thevalue = '';
				    for(var i=0;i<thename.length;i++){
				    	if(thename[i].checked==true){
				    		thevalue += thename[i].value + '~';
				    	}
				    }
				    var num = thevalue.lastIndexOf('~');
					thevalue = thevalue.substring(0,num);	
					
					$('#thecheckedvalue').val(thevalue);
					if(thevalue.indexOf('~')==0){
						thevalue = thevalue.substring(1,thevalue.length);
					}
					
				    return thevalue;
				}
				
				/**
				 * 将选中的值赋给指定输入区
				 * @param id
				 * @param id2
				 * @param id3
				 * @param name
				 * @return 无返回值
				 */
				function getCheckValue(id,id2,id3,name){
					$('#'+id).val('');
					$('#'+id).val(getTheChecked(name));
					document.getElementById(id2).style.display = 'none';
					document.getElementById(id3).style.display = '';
					var thestate = $('#thestate').val();
					if(id=='sarea'&&thestate!=1){
						$('#canloginip').val(getTheChecked('canloginip'));
						document.getElementById('thecanloginip').style.display = 'none';
						document.getElementById('canloginipp').style.display = '';
					}					
				}
					function cancelTheOper(str,thestr){
					document.getElementById(str).style.display='block';
					document.getElementById(thestr).style.display='none';
					
				}
				
				
		</script>
		<script type="text/javascript">
			///验证
		
		/**
		 * 验证号码资源是否有重复
		 * @param a
		 * @param b
		 * @return boolean
		 */
		function ischong(a,b){
		var flag=true;
	var ids="";
	if(tabStatus==21){
	ids="Dh";
	}else if(tabStatus==22){
	ids="MokuaiJu2";	
	}else{
	ids="Hm_Level";	
	}
		  var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'tsdBilling',
						 					tsdcf:'mssql',
						 					tsdoper:'query',
						 					datatype:'xmlattr',				 	
											tsdpk:'nums'+tabStatus+'.notin'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});		
			
				$.ajax({
					url:'mainServlet.html?'+urlstr+"&"+ids+"="+a,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){	
					switch(tabStatus){	
					case 11:
							var begin=parseInt(a);
							var end=parseInt(b);
							var HMStart=parseInt($(this).attr("hmstart"));
							var HMEnd=parseInt($(this).attr("hmend"));						
							if(begin>=HMStart&&begin<=HMEnd) flag=false;
							if(end>=HMStart&&end<=HMEnd) flag=false;							
							break;
					case 13:													
							var Hm_Level=$(this).attr("bz");																
							if(Hm_Level!=undefined){
								flag=false;
								return false;
							}		
						break;
					case 21:
					    var Dh=$(this).attr("dh_level");								
							if(Dh!=undefined){
								flag=false;
								return false;
							}	
					case 22:
							var Dh=$(this).attr("mokuaiju");
							if(Dh!=undefined){
								flag=false;
								return false;
							}	
							break;	
							
							
					}	//switch end									
						});		
				
					}});
			
		return flag;
	
		}
		/**
		 * 起始号和结束号长度应该一样
		 * @param a
		 * @param b
		 * @return boolean
		 */
		function tonglen(a,b){
		if(a.length==b.length) {return true;}
		else {
		////alert("号段起始号码和号段结束号码长度必须相等");		
		alert($("#HMStart11").html()+"<fmt:message key='numsEqual'/>"+$("#HMEnd11").html());		
		return false;}
		if(a>b){
		///alert("号段起始号码不能大于号段结束号码");
		alert($("#HMStart11").html()+"<fmt:message key='numsLE'/>"+$("#HMEnd11").html());
		return false;}
		}
		/**
		 * 号码资源设置>>>号码分配 验证号码资源是否有重复
		 * @param a
		 * @param b
		 * @return boolean
		 */
		function Chong(a,b){	
		var flag=true;
		var begin=parseInt(a);
		var end=parseInt(b);
		
		  var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'tsdBilling',
						 					tsdcf:'mssql',
						 					tsdoper:'query',
						 					datatype:'xmlattr',				 	
											tsdpk:'nums11.queryAll'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});		
			urlstr=urlstr;		
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){															
							var HMStart=parseInt($(this).attr("hmstart"));
							var HMEnd=parseInt($(this).attr("hmend"));						
							if(begin>=HMStart&&begin<=HMEnd) flag=false;
							if(end>=HMStart&&end<=HMEnd) flag=false;
							if(flag==false) return false;														
						});		
				
					}});
		if(flag==false){
		///alert("号码资源有重复，请重新输入");
		alert("<fmt:message key='numsReInput'/>");
		}
		return flag;
		}
		
			
		/**
		 * 写日志
		 * @param status(状态)
		 * @param content(内容)
		 * @return boolean
		 */
		function logwrite(status,content){
					var table="("+getTable()+")";
			tsd.QualifiedVal=true; 	
			switch(status){
			case 1:
			///增加
					writeLogInfo("","add",tsd.encodeURIComponent(table+"<fmt:message key="global.add" />"+":"+content));				
					break;
			case 2:
			///删除
					writeLogInfo("","delete",tsd.encodeURIComponent(table+"<fmt:message key="global.delete" />"+":"+content));
					break;			
			case 3:
			///修改
					writeLogInfo("","edit",tsd.encodeURIComponent(table+"<fmt:message key="global.edit" />"+":"+content));
					break;
				
			case 4:
			///批量删除
			writeLogInfo("","deleteBatch",tsd.encodeURIComponent(table+"<fmt:message key="tariff.deleteb" />"+":"+content));
		
					break;
			
			case 5:
			writeLogInfo("","editBatch",tsd.encodeURIComponent(table+"<fmt:message key="tariff.modifyb" />"+":"+content));
			
					break;
			case 6:
			////生成号码库
			writeLogInfo("","yield nums",tsd.encodeURIComponent(table+"<fmt:message key='numsyield'/>"+":"+content));
					break;
			}
			//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
			}
		/**
		 * 符合查询窗口
		 * @param 无参数
		 * @return String
		 */
		function getTable_s(){
			var table="";
			switch(tabStatus){
				case 11:
					table="_Hmzy".toLowerCase();
					break;
				case 12:
					table="vw_Hmzy_Detail".toLowerCase();
					break;
				case 13:
					table="Ywsl_HmLevel".toLowerCase();
					break;
				case 21:
					table="vw_Hmzy_Detail".toLowerCase();
					break;
				case 22:
					table="mokuaiju2".toLowerCase();
					break;
						
			}
			return table;
		}
			
	/**
	 * 得到表名
	 * @param 无参数
	 * @return String
	 */
	function getTable(){
		var table="";
		switch(tabStatus){
			case 11:
				table="Hmzy".toLowerCase();
				break;
			case 12:
				table="Hmzy_Detail".toLowerCase();
				break;
			case 13:
				table="Ywsl_HmLevel".toLowerCase();
				break;
			case 21:
				table="Hmzy_Detail".toLowerCase();
				break;
			case 22:
				table="mokuaiju2".toLowerCase();
				break;
					
		}
		return table;
	}

	/**
	 * 得到主键
	 * @param 无参数
	 * @return String
	 */
	function getId(){
		var id="";
		switch(tabStatus){
			case 11:
				id="HMStart";
				break;
			case 12:
				id="Dh";
				break;
			case 13:
				id="Hm_Level";
				break;
			case 21:
				id="Dh";
				break;
			case 22:
				id="ID";
				break;
					
		}
		return id;
	
	
	}
	/**
	 * 得到标题
	 * @param 无参数
	 * @return String
	 */
	function getTitle(){
		var title="";
		switch(tabStatus){
			case 11:
				title="<fmt:message key='nums.she1'/>";
				break;
			case 12:
				title="<fmt:message key='nums.she2'/>";
				break;
			case 13:
				title="<fmt:message key='nums.she3'/>";
				break;
			case 21:
				title="<fmt:message key='nums.tiao'/>";
				break;
			case 22:
				title="<fmt:message key='nums.tiao1'/>";
				break;
					
		}
		return title;
	
	
	}
	
	/**
	 * 得到面板标签
	 * @param 无参数
	 * @return 无返回值
	 */
	function setLabel(){
		//号码分配
			var thisdata = loadData('Hmzy'.toLowerCase(),'<%=languageType %>',1);
			var HMStart=thisdata.getFieldAliasByFieldName('HMStart');
			var HMEnd=thisdata.getFieldAliasByFieldName('HMEnd');
			var YwArea=thisdata.getFieldAliasByFieldName('YwArea');	
			var MokuaiJu=thisdata.getFieldAliasByFieldName('MokuaiJu');
			var Bz=thisdata.getFieldAliasByFieldName('Bz');
			var Dhlx=thisdata.getFieldAliasByFieldName('Dhlx');
			var Jhj_ID=thisdata.getFieldAliasByFieldName('Jhj_ID');
			var PreHth=thisdata.getFieldAliasByFieldName('PreHth');
			
			$("#HMStart11").html( HMStart);
			$("#HMEnd11").html( HMEnd);
			$("#Dhlx11").html( Dhlx);
			$("#Jhj_ID11").html( Jhj_ID);
			//$("#YwArea").val(YwArea);
			//$("#MokuaiJu").val(MokuaiJu);
			$("#sdepartname").html( YwArea);
			$("#sdepartnamem").html( MokuaiJu);
			$("#Bz11").html(Bz);
			$("#PreHth11").html(PreHth);	
			
			
			$("#lHMStart11").html( HMStart);
			$("#lHMEnd11").html( HMEnd);
	
	
		//号码资源明细
			var thisdata = loadData('Hmzy_Detail'.toLowerCase(),'<%=languageType %>',1);	
			
			var Dhlx=thisdata.getFieldAliasByFieldName('Dhlx');			
			var YwArea=thisdata.getFieldAliasByFieldName('YwArea');	
			var Jhj_ID=thisdata.getFieldAliasByFieldName('Jhj_ID');			
			var Dh=thisdata.getFieldAliasByFieldName('Dh');		
			var MokuaiJu=thisdata.getFieldAliasByFieldName('MokuaiJu');			
		   var Dh_Level=thisdata.getFieldAliasByFieldName('Dh_Level');
		   	var IsKeep=thisdata.getFieldAliasByFieldName('IsKeep');
		   	var Bz=thisdata.getFieldAliasByFieldName('Bz');
			$("#Dhlx12").html(Dhlx);
			$("#YwArea12").html(YwArea);
			$("#Jhj_ID12").html(Jhj_ID);
			$("#Dh12").html(Dh);
			$("#MokuaiJu12").html(MokuaiJu);			
			$("#Dh_Level12").html(Dh_Level);
			$("#IsKeep12").html(IsKeep);
			$("#Bz12").html(Bz);
			
			$("#lDh12").html(Dh);
			$("#lMokuaiJu12").html(MokuaiJu);
			$("#lYwArea12").html(YwArea);
			
			
													
			//号码级别设置
			var thisdata = loadData('Ywsl_HmLevel','<%=languageType %>',1);			
			var Bz=thisdata.getFieldAliasByFieldName('Bz');
			var Hm_Level=thisdata.getFieldAliasByFieldName('Hm_Level');
			var SelectFee=thisdata.getFieldAliasByFieldName('SelectFee');			
			$("#Hm_Level13").html( Hm_Level);			
			$("#SelectFee13").html(SelectFee);
			$("#Bz13").html(Bz);
			
			$("#lHm_Level13").html( Hm_Level);	
			$("#lBz13").html(Bz);
			
			
													
			//号码资源调整
			var thisdata = loadData('Hmzy_Detail'.toLowerCase(),'<%=languageType %>',1);
			var Dhlx=thisdata.getFieldAliasByFieldName('Dhlx');
			var Dh_Level=thisdata.getFieldAliasByFieldName('Dh_Level');
			var YwArea=thisdata.getFieldAliasByFieldName('YwArea');
			var Jhj_ID=thisdata.getFieldAliasByFieldName('Jhj_ID');
			var Bz=thisdata.getFieldAliasByFieldName('Bz');
			var uuid=thisdata.getFieldAliasByFieldName('UserID');
			var Dh=thisdata.getFieldAliasByFieldName('Dh');
			var IsKeep=thisdata.getFieldAliasByFieldName('IsKeep');
			var MokuaiJu=thisdata.getFieldAliasByFieldName('MokuaiJu');
			//隐藏域,给页面中存储字段的标签赋值	
			$("#Dh21").html( Dh);
			$("#Dh_Level21").html(Dh_Level);
			$("#IsKeep21").html(IsKeep);
			$("#MokuaiJu21").html(MokuaiJu);
			$("#Dhlx21").html(Dhlx);
			$("#Jhj_ID21").html(Jhj_ID);
			$("#YwArea21").html(YwArea);
			$("#Bz21").html(Bz);
			$("#UserID21").html(uuid);
			
				//号码资源二级模块局设置
			var opr = $("#operation").val();
			var thisdata = loadData('mokuaiju2','<%=languageType %>',1);
			var MokuaiJu=thisdata.getFieldAliasByFieldName('MokuaiJu');
			var IsUse=thisdata.getFieldAliasByFieldName('IsUse');
			var Bz=thisdata.getFieldAliasByFieldName('Bz');
			var ID=thisdata.getFieldAliasByFieldName('ID');
			var MokuaiJu2=thisdata.getFieldAliasByFieldName('MokuaiJu2');
		
			//隐藏域,给页面中存储字段的标签赋值
			$("#MokuaiJu22").html(MokuaiJu);
			$("#MokuaiJu222").html( MokuaiJu2);
			$("#IsUse22").html(IsUse);
			$("#Bz22").html(Bz);
			
			$("#lMokuaiJu22").html(MokuaiJu);
			$("#lMokuaiJu222").html( MokuaiJu2);
			$("#lIsUse22").html(IsUse);
			$("#lBz22").html(Bz);
	
	
	}
	/**
	 * 关闭
	 * @param 无参数
	 * @return 无返回值
	 */
	function closeo(){
	if(closeflash){
  		 closeflash=false;
  		 querylist();	
  	}
  	
	setTimeout($.unblockUI, 15);//关闭面板
	
	}
	/**
	 * 重置
	 * @param 无参数
	 * @return 无返回值
	 */
	function resett(){
  		 	queryByAccount();	
  	}
  	
  	/**
	 * 清除
	 * @param 无参数
	 * @return 无返回值
	 */
  	function clear(){
  	switch(tabStatus){
			case 11:
				$("#iHMStart11").val("");$("#iHMEnd11").val("");$("#iDhlx11").val("");$("#iJhj_ID11").val("");$("#iBz11").val("");$("#iPreHth11").val("");
				
				 isCheckedAll('depts',true);//全选
				isCheckedAll('depts',false);//反选
				getCheckValue('iywlx','thedept','dept','depts');//确定
				isCheckedAll('deptsm',true);//全选
				isCheckedAll('deptsm',false);//反选
				getCheckValue('imokuaiju','thedeptm','deptm','deptsm');//确定
				
				$("#iJhj_ID112").val("");
				break;
			case 12:
				$("#iDh_Level122").val("");
				break;
			case 13:
				$("#iHm_Level13").val("");$("#iBz13").val("");$("#iSelectFee13").val("");
				break;
			case 21:
				$("#iDh21").val("");$("#iDh_Level21").val("");
				$("#iIsKeep21").val("");
				$("#iMokuaiJu21").val("");
				$("#iDhlx21").val("");
				$("#iJhj_ID21").val("");
				$("#iYwArea21").val("");
				$("#iBz21").val("");
				
				$("#iDh_Level212").val("");
  				$("#iJhj_ID212").val("");
				break;
			case 22:
				$("#iMokuaiJu22").val("");
				$("#iMokuaiJu222").val("");
				$("#iIsUse22").val("");
				$("#iBz22").val("");
				break;
					
		}
  	
  	}
  	
  	 	 /**
		  * 点击添加样式
		  * @param str
		  * @return 无返回值
		  */
          function addStyle(str){
          		if(str=='zjcss'){
          			$("#zjcss").css("color","#FF9834"); 
          			$("#yjcss").css("color","#4D4D4D"); 
          			$("#cjcss").css("color","#4D4D4D"); 
          			$("#zjcss").css("background","url(style/images/public/curled.png) no-repeat right top"); 
          			$("#yjcss").css("background","url(style/images/public/flat.gif) no-repeat right top"); 
          			$("#cjcss").css("background","url(style/images/public/flat.gif) no-repeat right top"); 
          			document.getElementById("td2").style.display="none";
          			document.getElementById("td1").style.display="";
          			$("#hmsz").click();
          			
          		}
          		if(str=='yjcss'){
          			$("#zjcss").css("color","#4D4D4D"); 
          			$("#yjcss").css("color","#FF9834"); 
          			$("#cjcss").css("color","#4D4D4D"); 
          			
          			$("#yjcss").css("background","url(style/images/public/curled.png) no-repeat right top"); 
          			$("#zjcss").css("background","url(style/images/public/flat.gif) no-repeat right top"); 
          			$("#cjcss").css("background","url(style/images/public/flat.gif) no-repeat right top"); 
          			document.getElementById("td1").style.display="none";
          			document.getElementById("td2").style.display="";
          			$("#hmtz").click();
          		}
          		
          }
		</script>
		
		<!-- 下来框 -->
		<style type="text/css">
	body{margin:0; padding:0px;font-family:"宋体",Arial, Helvetica, sans-serif; font-size:12px}
	div,form,img,ul,ol,li,dl,dt,dd,p {margin: 0; padding: 0; border: 0}
	ul,li{list-style-type:none}
	h1,h2,h3,h4,h5,h6 { margin:0; padding:0;font-size:12px;}
	h1{font-size:12px; text-align:left}
	table,td,tr,th{font-size:12px;padding:0; margin:0;}
	input,select{font-size:12px; margin:0; padding:0; vertical-align:middle}
	.clear{clear:both; margin:0; padding:0; font-size:1px; height:1px; visibility:hidden}
	.blank{clear:both; margin:0; padding:0; font-size:1px; height:10px}
	/*示例*/
	.tt{border:1px solid #ccc; background:#eee; padding:10px}
	.aa{border:2px solid #000}
	#tab{border-collapse:collapse}
	#tab td{height:20px; padding:0 2px;border:1px #6FB0D0 solid}
	.bg{background:#eee}
	.over{ background:#E0EEF5}
	</style>
	
<script>
/**
 * 交换机编码
 * @param 无参数
 * @return 无返回值
 */
$(function(){
/****交换机编码**/
$("#iJhj_ID212").focus(function(){
$("#jhj").css("display","");

}
);

 	/**
	 * 单击选中每一行
	 * @param 无参数
	 * @return 无返回值
	 */
   $("#tabjj tr").click(function(){
     	$("#tabjj tr").removeClass("bg");
         $(this).addClass("bg");
         var te="";
         var size=$(this).children("td").size();
         var count=0;
         var JhjID="";var JhjName=""; var JhjArea="";
         $(this).children("td").each(function() { 
                    if(count==0) JhjID=$(this).text();
                    else if(count==1) JhjName=$(this).text();
                    else  JhjArea=$(this).text();
                    count++;
                   
                });
       
         if(JhjID=="<fmt:message key='nums.switchnumber' />"){
         }else{
         $("#iJhj_ID212").val(JhjName);
         $("#iJhj_ID21").val(JhjID);
          $("#jhj").css("display","none");
        
         }
   });
   
   
  	/**
	 * 滑过表格
	 * @param 无参数
	 * @return 无返回值
	 */
   $("#tabjj tr").hover(function(){
       $(this).addClass("over")
     },function(){
       $(this).removeClass("over")
   })
   
   
/**
 * 21号码级别
 * @param 无参数
 * @return 无返回值
 */     
$("#iDh_Level212").focus(function(){
$("#level").css("display","");

}
);


   
    /**
	 * 单击选中每一行
	 * @param 无参数
	 * @return 无返回值
	 */   
   $("#tabb tr").click(function(){
   
     	$("#tabb tr").removeClass("bg");
         $(this).addClass("bg");
         var te="";
         var size=$(this).children("td").size();
         var count=0;
         var level="";var bz="";
         $(this).children("td").each(function() { 
                    if(count==0) level=$(this).text();
                    else if(count==1) bz=$(this).text();
                    count++;
                   
                });
       
         if(level=="<fmt:message key='nums.numbergrade' />"){
         }else{
         $("#iDh_Level212").val(bz);
         $("#iDh_Level21").val(level);
          $("#level").css("display","none");
        
         }
   });
   /**
	 * 滑过表格
	 * @param 无参数
	 * @return 无返回值
	 */   
   $("#tabb tr").hover(function(){
       $(this).addClass("over")
     },function(){
       $(this).removeClass("over")
   })
/**
 * 12号码级
 * @param 无参数
 * @return 无返回值
 */  
$("#iDh_Level122").focus(function(){
$("#level12").css("display","");

}
);


   	/**
	 * 单击选中每一行
	 * @param 无参数
	 * @return 无返回值
	 */ 
   $("#tabl tr").click(function(){
   
     	$("#tabl tr").removeClass("bg");
         $(this).addClass("bg");
         var te="";
         var size=$(this).children("td").size();
         var count=0;
         var level="";var bz="";
         $(this).children("td").each(function() { 
                    if(count==0) level=$(this).text();
                    else if(count==1) bz=$(this).text();
                    count++;
                   
                });
       
         if(level=="<fmt:message key='nums.numbergrade' />"){
         }else{
         $("#iDh_Level122").val(bz);
         $("#iDh_Level12").val(level);
          $("#level12").css("display","none");
        
         }
   });
        
    /**
	 * 滑过表格
	 * @param 无参数
	 * @return 无返回值
	 */ 
   $("#tabl tr").hover(function(){
       $(this).addClass("over")
     },function(){
       $(this).removeClass("over")
   })
  
/**
 * 11交换机编码
 * @param 无参数
 * @return 无返回值
 */ 
$("#iJhj_ID112").focus(function(){
$("#jhj11").css("display","");

}
);

 
 	/**
	 * 单击选中每一行
	 * @param 无参数
	 * @return 无返回值
	 */ 
   $("#tabjhj tr").click(function(){
     	$("#tabjhj tr").removeClass("bg");
         $(this).addClass("bg");
         var te="";
         var size=$(this).children("td").size();
         var count=0;
         var JhjID="";var JhjName=""; var JhjArea="";
         $(this).children("td").each(function() { 
                    if(count==0) JhjID=$(this).text();
                    else if(count==1) JhjName=$(this).text();
                    else  JhjArea=$(this).text();
                    count++;
                   
                });
       
         if(JhjID=="<fmt:message key='nums.switchnumber' />"){
         }else{
         $("#iJhj_ID112").val(JhjName);
         $("#iJhj_ID11").val(JhjID);
          $("#jhj11").css("display","none");
        
         }
   });
   
   
   
   	/**
	 * 滑过表格
	 * @param 无参数
	 * @return 无返回值
	 */ 
   $("#tabjhj tr").hover(function(){
       $(this).addClass("over")
     },function(){
       $(this).removeClass("over")
   })
   
   
    /**
	 * 各种事件
	 * @param 无参数
	 * @return 无返回值
	 */  
   $("#pan21 select").focus(function(){
          $("#jhj").css("display","none");
           $("#level").css("display","none");
   });
   $("#iDh212").focus(function(){
          $("#jhj").css("display","none");
           $("#level").css("display","none");
   });
   $("#iDh_Level212").focus(function(){
          $("#jhj").css("display","none");
   });
   $("#iJhj_ID212").focus(function(){
           $("#level").css("display","none");
   });
   
    $("#iBz12").focus(function(){
           $("#level12").css("display","none");
   });
     $("#iIsKeep12").focus(function(){
           $("#level12").css("display","none");
   });

	$("#pan11 select").focus(function(){
          $("#jhj11").css("display","none");
   });
    $("#pan11 textarea").focus(function(){
          $("#jhj11").css("display","none");
   });
     $("#iHMStart11").focus(function(){
          $("#jhj11").css("display","none");
   });
     $("#iHMEnd11").focus(function(){
          $("#jhj11").css("display","none");
   });
     $("#iPreHth11").focus(function(){
          $("#jhj11").css("display","none");
   });
      $("#iBz11").focus(function(){
          $("#jhj11").css("display","none");
   });
   
})
</script>

	<script>
	/**
	 * 打开简单查询面板
	 * @param 无参数
	 * @return 无返回值
	 */  
	function openQuery(){
		 	$(".top_03").html('<fmt:message key="global.query" />');//标题	
		 
		 		switch(tabStatus)
		{
			case 11:
				autoBlockFormAndSetWH('pan112',60,5,'closeo11',"#ffffff",true,1000,'');//弹出查询面板
				$("#iiHMStart11").val("");$("#iiHMEnd11").val("");
				break;
			case 12:
				autoBlockFormAndSetWH('pan122',60,5,'closeo12',"#ffffff",true,1000,'');//弹出查询面板
				$("#iiDh12").val("");$("#iiMokuaiJu12").val("");$("#iiYwArea12").val("");
				break;
			case 13:
			 	$("#iiHm_Level13").val("");$("#iiBz13").val("");
				autoBlockFormAndSetWH('pan132',60,5,'closeo13',"#ffffff",true,1000,'');//弹出查询面板
				break;
			case 21:
				autoBlockFormAndSetWH('pan122',60,5,'closeo12',"#ffffff",true,1000,'');//弹出查询面板
				$("#iiDh12").val("");$("#iiMokuaiJu12").val("");$("#iiYwArea12").val("");
				break;
			case 22:
			 	$("#iiMokuaiJu22").val("");
				$("#iiMokuaiJu222").val("");
				$("#iiIsUse22").val("");
				$("#iiBz22").val("");
				autoBlockFormAndSetWH('pan222',60,5,'closeo22',"#ffffff",true,1000,'');//弹出查询面板
				break;
			
			
		}	
		 	
		 	
	}
 /**
  * 通过表单值构造数据操作参数 请根据业务参数的多少和属性进行修改，@oper 操作类型 modify|save
  * @param 无参数
  * @return 无返回值
  */  
function QbuildParams(){
	 	var paramsStr='1=1 ';
	 	if(tabStatus==11){
  			var HMStart=$("#iiHMStart11").val();	
  			var HMEnd=$("#iiHMEnd11").val();	
		  		if(HMStart!=null&&HMStart!=""){
		  		paramsStr+="and HMStart like '%"+HMStart+"%' ";
		  		}
		  		
		  		if(HMEnd!=null&&HMEnd!=""){
		  		paramsStr+="and HMEnd like '%"+HMEnd+"%' ";
		  		}
	}else if(tabStatus==12||tabStatus==21){
				var Dh=$("#iiDh12").val();		
				var MokuaiJu=$("#iiMokuaiJu12").val();	
				var YwArea=$("#iiYwArea12").val();
		  		if(Dh!=null&&Dh!=""){
		  		paramsStr+="and Dh like '%"+Dh+"%' ";
		  		}		  			  		
		  		if(MokuaiJu!=null&&MokuaiJu!=""){
		  		paramsStr+="and MokuaiJu like '%"+MokuaiJu+"%' ";
		  		}		  			  		
		  		if(YwArea!=null&&YwArea!=""){
		  		paramsStr+="and YwArea like '%"+YwArea+"%' ";
		  		}
	}else if(tabStatus==13){
	
		  		var Hm_Level=$("#iiHm_Level13").val();	
		  		var Bz=$("#iiBz13").val();	
		  		if(Hm_Level!=null&&Hm_Level!=""){
		  		paramsStr+="and Hm_Level like '%"+Hm_Level+"%' ";
		  		}
		  		
		  		if(Bz!=null&&Bz!=""){		  	
		  		paramsStr+="and Bz like '%"+Bz+"%' ";
		  		}		  		
	}else if(tabStatus==22){
		  		var MokuaiJu=$("#iiMokuaiJu22").val();	
		  		var MokuaiJu2=$("#iiMokuaiJu222").val();		 
		  		//var IsUse=$("#iiIsUse22 option[selected]").text();	
		  		var  IsUse=$("#iiIsUse22").val();	
		  		var Bz=$("#iiBz22").val();
		  		if(MokuaiJu!=null&&MokuaiJu!=""){
		  		paramsStr+="and MokuaiJu like '%"+MokuaiJu+"%' ";
		  		}
		  		if(MokuaiJu2!=null&&MokuaiJu2!=""){
		  		paramsStr+="and MokuaiJu2 like '%"+MokuaiJu2+"%' ";
		  		}		  		
		  		if(IsUse!=null&&IsUse!=""){
		  		paramsStr+="and IsUse like '%"+IsUse+"%' ";
		  		}		  			  		
		  		if(Bz!=null&&Bz!=""){
		  		paramsStr+="and Bz like '%"+Bz+"%' ";
		  		}
	}
	 	$("#fusearchsql").val(paramsStr);
	 	fuheQuery();		
}
	
	</script>
	
<style type="text/css">
.spanstyle{display:-moz-inline-box; display:inline-block; width:115px}
</style>
</head>

  <body>   
   <form name="childform" id="childform">
  <input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
  <input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
  </form>
  			
		<!-- 用户操作导航-->
		<div id="navBar">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar1" style="float: left">
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
		<table width="100%">
			<!-- <tr>
				<td align="left">
  					<div>
						<ul id="menu">
							<!-- 默认点击、 -->
			<!--				<li><a href="#" id="zjcss" onclick="addStyle('zjcss');" title="<fmt:message key='nums.she' />"><b><fmt:message key='nums.she' /></b></a></li>
							<li><a href="#" id="yjcss" onclick="addStyle('yjcss');" title="<fmt:message key='nums.tiao' />"><b><fmt:message key='nums.tiao' /></b></a></li>
							
						</ul>					
					</div>
				</td>
			</tr> -->
		<tr style="display: none;">
			<td>
				<hr size="1" noshade="noshade"/>				
			</td>
		</tr>
	
			
		<tr id="td1">
			<td>
		<div id="buttons">	
								<button type="button"  class="tsdbutton" onclick="openDiaO(getTable_s());">
								<!--组合排序--><fmt:message key="order.title" />
								</button>	
								<button type="button" class="tsdbutton" id="openadd1" onclick="openadd();" disabled="disabled">
											<!-- 新增 --><fmt:message key="global.add" />
								</button>	
							    <button type="button"   onclick="openQuery();">
									<!--查询-->
									<fmt:message key="global.query" />
								</button>	   
								<button onclick='openQueryM(getTable_s());' ><fmt:message key="oper.mod"/></button>
							   <button type="button" id='gjquery1' onclick="openDiaQ('query',getTable_s());" disabled="disabled">
									<!--高级查询-->	<fmt:message key="oper.queryA"/>
								</button>		
								<button type="button" id='savequery1' onclick="openModT();"  disabled="disabled">
									<!-- 将本查询保存为模板  --> <fmt:message key="oper.modSave"/>
								</button>
								
								
								<!-- 2014-11-25 添加 for 西飞  start -->
				 					<button type="button" id="batchMod" onclick="openDiaQueryG('modify',getTable_s());" style="display:none;">
									<!--批量修改--><fmt:message key="tariff.modifyb" />
									</button>
									
									<button type="button" class="tsdbutton" id="batchDel" onclick="openDiaQueryG('delete',getTable_s());" style="display:none;">
										<!--批量删除--><fmt:message key="tariff.deleteb" />
									</button>
								<!-- end -->
								
																	   			
								<button type="button" class="tsdbutton" id="export1" onclick="thisDownLoad('tsdBilling','mssql',getTable_s(),'<%=languageType%>');" disabled="disabled"> 
											<!--导出--><fmt:message key="global.exportdata" />
								</button>
								<!--打印	
								<button type="button" class="tsdbutton" id="print1" onclick="print()" disabled="disabled">
											<fmt:message key="tariff.printer" />
								</button>	
								
								<!-- 生成全部号码库				
								<button type="button" class="tsdbutton" id="allhaoma" onclick="generateAll();" disabled="disabled"> 
											<fmt:message key='numsyieldAll'/>
								</button>
								-->			
		</div>									   
				<hr size="1" noshade="noshade" style="display: none;"/>
				<div id="tabs1" >	
			
					<ul>
						<!-- 号码分配 --><li><a href="#gridd1" id="hmsz" onclick="tabsChg(11)" ><span><fmt:message key='nums.she1' /></span></a></li>
						<!-- 号码资源明细 --><li><a href="#gridd1" onclick="tabsChg(12)"><span><fmt:message key='nums.she2' /></span></a></li>
						<!--  号码级别设置--><li><a href="#gridd1" onclick="tabsChg(13)"><span><fmt:message key='nums.she3' /></span></a></li>
						
					</ul>						
					<div id="gridd1">
					  <div id="e_g_1">
						<table id="editgrid1" class="scroll" cellpadding="0" cellspacing="0"></table>
						<div id="pagered1" class="scroll" style="text-align: left;"></div>
					  </div>
								
					</div>
				</div>
					
			<div id="buttons">		
							<button type="button" class="tsdbutton" onclick="openDiaO(getTable_s());">
											<!--组合排序--><fmt:message key="order.title" />
							</button>	
							<button type="button" class="tsdbutton" id="openadd1f" onclick="openadd();" disabled="disabled">
											<!-- 新增 --><fmt:message key="global.add" />
							</button>	   
						    <button type="button" onclick="openQuery();">
								<!--查询-->
								<fmt:message key="global.query" />
							</button>
							<button onclick='openQueryM(getTable_s());'><fmt:message key="oper.mod"/></button>
						   <button type="button" id='gjquery2' onclick="openDiaQ('query',getTable_s());" disabled="disabled">
								<!--高级查询-->	<fmt:message key="oper.queryA"/>
							</button>	
							<button type="button" id='savequery2' onclick="openModT();"  disabled="disabled">
								<!-- 将本查询保存为模板  --> <fmt:message key="oper.modSave"/>
							</button>									   			
							<button type="button" class="tsdbutton" id="export1f" onclick="thisDownLoad('tsdBilling','mssql',getTable_s(),'<%=languageType%>');" disabled="disabled"> 
											<!--导出--><fmt:message key="global.exportdata" />
							</button>
							<!--打印	
							<button type="button" class="tsdbutton" id="print1f" onclick="print()" disabled="disabled">
											<fmt:message key="tariff.printer" />
							</button>
							-->				
							<!--生成全部号码库				
							<button type="button"  id="allhaomaf" onclick="generateAll();" disabled="disabled" class="tsdbutton"> 
											<fmt:message key='numsyieldAll'/>
							</button>		
							-->		
											   
			</div>	
			</td>		
	</tr>
	<tr id="td2" style="display:none">
	<td>
				<div id="buttons">				    
				
						<button type="button" class="tsdbutton" id="order21" onclick="openDiaO(getTable_s());">
													<!--组合排序--><fmt:message key="order.title" />
						</button>
						<button type="button" class="tsdbutton" id="openadd2" onclick="openadd();" disabled="disabled">
													<!-- 新增 --><fmt:message key="global.add" />
						</button>	
					    <button type="button" onclick="openQuery();">
							<!--查询-->
							<fmt:message key="global.query" />
						</button>	   
						<button onclick='openQueryM(getTable_s());' ><fmt:message key="oper.mod"/></button>
					   <button type="button" id='gjquery12' onclick="openDiaQ('query',getTable_s());" disabled="disabled">
							<!--高级查询-->	<fmt:message key="oper.queryA"/>
						</button>		
						<button type="button" id='savequery12' onclick="openModT();"  disabled="disabled">
							<!-- 将本查询保存为模板  --> <fmt:message key="oper.modSave"/>
						</button>			
						<button type="button" class="tsdbutton" id="opende2" onclick="openDiaQueryG('delete',getTable_s());" disabled="disabled">
													<!--批量删除--><fmt:message key="tariff.deleteb" />
						</button>
						<button type="button" class="tsdbutton" id="openmod2" onclick="openDiaQueryG('modify',getTable_s());" disabled="disabled">
													<!--批量修改--><fmt:message key="tariff.modifyb" />
						</button>	
						<button type="button" class="tsdbutton" id="export2" onclick="thisDownLoad('tsdBilling','mssql',getTable_s(),'<%=languageType%>');" disabled="disabled"> 
													<!--导出--><fmt:message key="global.exportdata" />
						</button>	
						<button type="button" class="tsdbutton" id="print2" onclick="print()" disabled="disabled">
													<!--打印--><fmt:message key="tariff.printer" />
						</button>
			</div>											
			<hr size="1" noshade="noshade"/>
			<div id="tabs2" >	
					<ul>
						<!-- 号码资源调整 --><li><a href="#gridd2" onclick="tabsChg(21)" id="hmtz"><span><fmt:message key='nums.tiao' /></span></a></li>
						<!-- 号码资源二级模块局设置 --><li><a href="#gridd2" onclick="tabsChg(22)"><span><fmt:message key='nums.tiao1'/></span></a></li>
						
						
					</ul>
					
					<div id="gridd2">
									
					    <div id="e_g_2">
					    <table id="editgrid2" class="scroll" cellpadding="0" cellspacing="0"></table>
						<div id="pagered2" class="scroll" style="text-align: left;"></div>
					    </div>
									
					</div>
			</div>
					<div id="buttons">			
												<button type="button" class="tsdbutton" id="order21" onclick="openDiaO(getTable_s());">
													<!--组合排序--><fmt:message key="order.title" />
												</button>
														  		
												<button type="button" class="tsdbutton" id="openadd2f" onclick="openadd();" disabled="disabled">
													<!-- 新增 --><fmt:message key="global.add" />
											    </button>	   
											    <button type="button" onclick="openQuery();">
													<!--查询-->
													<fmt:message key="global.query" />
												</button>
												<button onclick='openQueryM(getTable_s());'><fmt:message key="oper.mod"/></button>
											   <button type="button" id='gjquery22' onclick="openDiaQ('query',getTable_s());" disabled="disabled">
													<!--高级查询-->	<fmt:message key="oper.queryA"/>
												</button>	
												<button type="button" id='savequery22' onclick="openModT();"  disabled="disabled">
													<!-- 将本查询保存为模板  --> <fmt:message key="oper.modSave"/>
												</button>	
												<button type="button" class="tsdbutton" id="opende2f" onclick="openDiaQueryG('delete',getTable_s());" disabled="disabled">
													<!--批量删除--><fmt:message key="tariff.deleteb" />
												</button>
												 <button type="button" class="tsdbutton" id="openmod2f" onclick="openDiaQueryG('modify',getTable_s());" disabled="disabled">
													<!--批量修改--><fmt:message key="tariff.modifyb" />
												</button>	
												<button type="button" class="tsdbutton" id="export2f" onclick="thisDownLoad('tsdBilling','mssql',getTable_s(),'<%=languageType%>');" disabled="disabled"> 
													<!--导出--><fmt:message key="global.exportdata" />
												</button>	
												<button type="button" class="tsdbutton" id="print2f" onclick="print()" disabled="disabled">
													<!--打印--><fmt:message key="tariff.printer" />
												</button>
														
				</div>
			</td>
		</tr>
	</table>
					

<!-- 号码分配 -->
	<div class="neirong" id="pan11" style="display: none">
<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="nums.projectname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="nums.close" /></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>

		<div class="midd" >
			<table width="100%"  border="0" id="tdiv11" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			  <tr>
			    <td width="12%" align="right" class="labelclass"><label id="HMStart11" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iHMStart11"   class="textclass" maxlength="20"  onkeypress="var   k=event.keyCode;   return   k>=48&&k<=57" style="ime-mode:Disabled"/><label class="addred" ></label></td>
			    <td width="12%" align="right"  class="labelclass"><label id="HMEnd11" ></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iHMEnd11"    class="textclass" maxlength="20"  onkeypress="var   k=event.keyCode;   return   k>=48&&k<=57" style="ime-mode:Disabled"/><label class="addred"></label></td>
			    <td width="12%" align="right"  class="labelclass"><label  id="Jhj_ID11" ></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    <input type="text"  id="iJhj_ID112"  />
			     <input type="hidden"  id="iJhj_ID11"  />
			    </td>
			  </tr>
			  	<tr  id="jhj11" style="display:none">
					<td align="center" colspan="6" >
				 		<table  width="30%" border="0" cellspacing="0" cellpadding="0" id="tabjhj" >
						</table>
					<td>
				</tr>
			<tr>
		     <td width="12%" align="right"  class="labelclass"><label  id="Dhlx11" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    <select  id="iDhlx11"  class="textclass" >				
				<option value="">--<fmt:message key="global.select"/>--&nbsp;</option>								
			</select> 
			<input type="text" id="iDhlx112"  />
		    </td>
		    <td width="12%" align="right"  class="labelclass"><label   id="PreHth11" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iPreHth11"  onkeypress="var k=event.keyCode;  return k!=32;" maxlength="2"  class="textclass" /></td>
		 
		    <td width="12%" align="right" class="labelclass"><label  id="Bz11" ></label></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iBz11"  maxlength="50" class="textclass" /></td>
		    </tr>
		    
		    
		    <tr>		    
		    	<td colspan="6" align="left" bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
		       <tr>
		       <td width="12%" align="right" style="background:#F0F7FB; border-bottom:1px solid #A9C8D9; padding-right:1%;"><label   id="sdepartname"  ></label>：</td>
		        
		        <td width="42%" style=" border-bottom:1px solid #A9C8D9;">
				  <span id="dept">
						<textarea rows="6" cols="40" id='iywlx' onfocus="isDept();getTheDept()" style="min-height:50px;height:auto;"></textarea><label class="addred" ></label>
					</span>
				
				<span id="thedept"  style="display: none;"></span>
				
	           </td>
		        <td width="46%" style=" border-bottom:1px solid #A9C8D9;">&nbsp;</td>
		      </tr>
		    </table></td>
	    </tr>
	  
	    
	    <tr>
		    <td colspan="6" align="left" bgcolor="#FFFFFF">
		    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		       <tr>
		       <td width="12%" align="right" style="background:#F0F7FB; border-bottom:1px solid #A9C8D9; padding-right:1%;"><label   id="sdepartnamem"  ></label></td>
		        
		        <td width="42%" style=" border-bottom:1px solid #A9C8D9;">
		         <span id="deptm">
				<textarea rows="6" cols="40" id='imokuaiju' onfocus="isDeptm();getTheDeptm()" style="min-height:50px;height:auto;"></textarea><label class="addred" ></label>
				</span>
				<span id="thedeptm"  style="display: none;">
				</span>
			   	</td>
		        <td width="46%" style=" border-bottom:1px solid #A9C8D9;">&nbsp;</td>
		      </tr>
		    </table>
		    </td>
	    </tr>
	    <tr>
		    <td colspan="6" align="left" bgcolor="#FFFFFF">
		    <label style="color: red;padding-left: 40px;">
		    	为避免生成重复号码，请确定号码起始值和号码终止值之间的号码在当前号码资源库中不存在。
		    </label>
		    </td>
	    </tr>
	    
		
		
		</table>
		
		 <div class="midd_butt">
		 
			<!-- 保存新增 --><button class="tsdbutton" id="save11" style="width:80px;heigth:27px;" onclick="save(1)" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
		 	 <!-- 保存退出 --><button class="tsdbutton" id="save111" style="width:80px;heigth:27px;" onclick="save(2)" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
			<!-- 号码资源段批量修改 --><button class="tsdbutton" id="modify11" style="width:63px;heigth:27px;" onclick="modify()"><fmt:message key="global.edit" /></button>
		     <!-- 批量修改 <button class="tsdbutton" id="modifyB11" style="width:79px;heigth:33px;" onclick="fuheModify()" ><fmt:message key="tariff.modifyb" /></button>&nbsp;-->
		      <!-- 取消--><button class="tsdbutton" id="reset11" style="width:63px;heigth:27px;" onclick="resett()" ><fmt:message key="nums.cancel"/></button>
		   <!-- 关闭 --><button class="tsdbutton"  id="close11" style="width:63px;heigth:27px;" onclick="closeo()" ><fmt:message key="global.close" /></button>
			</div>			
			
	
			
			 
		  </div>
		</div>
		
		<!-- 号码资源明细 -->
	<div class="neirong" id="pan12" style="display: none">
<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="nums.projectname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="nums.close" /></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		
		<div class="midd" >
			<table width="100%"  border="0" id="tdiv12" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
		    <tr>
		    <td width="12%" align="right" class="labelclass"><label id="Dh12" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iDh12" class="textclass2" readonly/></td>
		    <td width="12%" align="right"  class="labelclass"><label id="MokuaiJu12" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    
		    <input type="hidden" id="iMokuaiJu12" class="textclass"/>
		    
		    <select id="mkj" onfocus="addMkj()" onchange="setMkj()" class="textclass"><option value=""></option></select>
		    
		    </td>
		    <td width="12%" align="right"  class="labelclass"><label  id="Dhlx12" ></label></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iDhlx12"    class="textclass2" readonly/></td>
		  </tr>
		    <tr>
		    <td width="12%" align="right" class="labelclass"><label id="Jhj_ID12" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iJhj_ID12" class="textclass2"  readonly/></td>
		    <td width="12%" align="right"  class="labelclass"><label id="YwArea12" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iYwArea12"    class="textclass2" readonly/></td>
		   
		    <td width="12%" align="right" class="labelclass"><label id="Dh_Level12" ></label></td>							
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iDh_Level122" class="textclass" readonly/>
		    <input type="hidden" id="iDh_Level12" />		   
		    </td>
		     </tr>
		     
		    <tr  id="level12" style="display:none">
				<td align="center" colspan="6" >
			 		<table  width="20%" border="0" cellspacing="0" cellpadding="0" id="tabl" >
					</table>
				<td>
			</tr>
		  
		  <tr>
		    <td width="12%" align="right"  class="labelclass"><label id="IsKeep12" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    <select name="iIsKeep12" id="iIsKeep12" class="textclass">	
	  <!-- 不保留 --><option value="0"><fmt:message key='numsno'/></option>	  	    
		<!-- 保留 --><option value="1"><fmt:message key='numsyes'/></option>
			</select>
			<input type="hidden" id="iIsKeep122"/>
		    </td>
		    <td width="12%" align="right"  class="labelclass"><fmt:message key="nums.remark"/></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    <input type="text" id="iBz12"  maxlength="50"  class="textclass" />
		    </td>
		     <td width="12%" align="right"  class="labelclass"></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
		 
		  </tr>
		
		</table>
		
		 <div class="midd_butt">
		  <!-- 号码资源明细批量修改 --><button class="tsdbutton"  id="modifyt22" style="width:63px;heigth:27px;" onclick="modify()" ><fmt:message key="global.edit" /></button>
		  <button class="tsdbutton" id="batchModify" style="width:63px;heigth:27px;" onclick="fuheModify()" ><fmt:message key="tariff.modifyb" /></button>
		   <!-- 取消--><button class="tsdbutton"  id="reset12" style="width:63px;heigth:27px;" onclick="resett()" ><fmt:message key="nums.cancel"/></button>
		   <!-- 关闭 --><button class="tsdbutton" id="close12"  style="width:63px;heigth:27px;" onclick="closeo()" ><fmt:message key="global.close" /></button>
			</div>			
			
	
			
			 
		  </div>
		</div>
		
	<!-- 号码级别设置 -->
	<div class="neirong" id="pan13" style="display: none">
<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="nums.projectname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="nums.close" /></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		
		<div class="midd" >
			<table width="100%"  border="0" id="tdiv13" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
		    <tr>
		    <td width="12%" align="right" class="labelclass"><label id="Hm_Level13" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iHm_Level13" maxlength="10" onkeypress="var k=event.keyCode;   return  k>=48&&k<=57" class="textclass" style="ime-mode:Disabled"/><label class="addred" ></label></td>
		    <td width="12%" align="right"  class="labelclass"><label  id="SelectFee13" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iSelectFee13"  maxlength="20"  onkeypress="var k=event.keyCode;   return  (k==46)||(k>=48&&k<=57)"  class="textclass"  style="ime-mode:Disabled"/></td>
		  
		    <td width="12%" align="right"  class="labelclass"><label id="Bz13" ></label></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iBz13" maxlength="20" class="textclass" /></td>
		    </tr>
		  
		
		</table>
		
		 <div class="midd_butt">
		 <!-- 保存新增 --><button class="tsdbutton" id="save13" style="width:80px;heigth:27px;" onclick="save(1)" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
		 	 <!-- 保存退出 --><button class="tsdbutton" id="save131" style="width:80px;heigth:27px;" onclick="save(2)" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>			
		  <!-- 修改 --><button class="tsdbutton" id="modify13" style="width:63px;heigth:27px;" onclick="modify()" ><fmt:message key="global.edit" /></button>
		   <!-- 取消--><button class="tsdbutton" id="reset13" style="width:63px;heigth:27px;" onclick="resett()" ><fmt:message key="nums.cancel"/></button>
		   <!-- 关闭 --><button class="tsdbutton"  id="close13" style="width:63px;heigth:27px;" onclick="closeo()" ><fmt:message key="global.close" /></button>
			</div>			
			
	
			
			 
		  </div>
		</div>
		
		
			<!-- 号码资源调整 -->
		<div class="neirong" id="pan21" style="display: none">
			<br />
			<div class="top">
				<div class="top_01">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03">
							<fmt:message key="nums.projectname" />
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="closeo()"><span style="margin-left: 5px;"><fmt:message key="nums.close" /></span>
						</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>

			<div class="midd">
				<table width="100%" id="tdiv21" border="0" cellspacing="0"
					cellpadding="0" style="line-height: 33px; font-size: 12px;">
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="Dh21"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iDh21" class="textclass" maxlength="16"
								onkeypress="var k=event.keyCode;   return  (k==45)||(k>=48&&k<=57)"
								style="ime-mode: Disabled" />
							<label class="addred"></label>
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="MokuaiJu21"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<select id="iMokuaiJu21" class="textclass">
								<option value="">
									--
									<fmt:message key='global.select' />
									--
								</option>
							</select>
							<input type="text" id="iMokuaiJu212" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="Dhlx21"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<select id="iDhlx21" class="textclass">
								<option value="">
									--
									<fmt:message key='global.select' />
									--
								</option>
							</select>
							<input type="text" id="iDhlx212" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="Jhj_ID21"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iJhj_ID212" />
							<input type="hidden" id="iJhj_ID21" />
						</td>


						<td width="12%" align="right" class="labelclass">
							<label id="YwArea21"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<select id="iYwArea21" class="textclass">
								<option value="" selected="selected">
									--
									<fmt:message key='global.select' />
									--
								</option>
							</select>
							<input type="text" id="iYwArea212" />
						</td>

						<td width="12%" align="right" class="labelclass">
							<label id="Dh_Level21"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iDh_Level212" />
							<input type="hidden" id="iDh_Level21" />
						</td>
					</tr>
					<tr id="jhj" style="display: none">
						<td align="center" colspan="6">
							<table width="30%" border="0" cellspacing="0" cellpadding="0"
								id="tabjj">
							</table>
						<td>
					</tr>

					<tr id="level" style="display: none">
						<td align="center" colspan="6">
							<table width="20%" border="0" cellspacing="0" cellpadding="0"
								id="tabb">
							</table>
						<td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="IsKeep21"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<select id="iIsKeep21" class="textclass">
								<option value="-1">
									--
									<fmt:message key='global.select' />
									--
								</option>
								<!-- 不保留 -->
								<option value="0">
									<fmt:message key='numsno' />
								</option>
								<!-- 保留 -->
								<option value="1">
									<fmt:message key='numsyes' />
								</option>
							</select>
							<input type="text" id="iIsKeep212" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="Bz21"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">

							<select name="iBz21" id="iBz21" class="textclass">
								<option value="">
									--
									<fmt:message key='global.select' />
									--
								</option>
							</select>
							<input type="text" id="iBz212" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="UserID21"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<select name="iUserID21" id="iUserID21" class="textclass">
								<option value="">
									--
									<fmt:message key='global.select' />
									--
								</option>
							</select>
							<input type="text" id="iUserID212" />
						</td>

					</tr>

				</table>

				<div class="midd_butt">
					<!-- 保存新增 -->
					<button class="tsdbutton" id="save21"
						style="width: 80px; heigth: 27px;" onclick="save(1)">
						<fmt:message key="global.save" />
						<fmt:message key="global.add" />
					</button>
					<!-- 保存退出 -->
					<button class="tsdbutton" id="save211"
						style="width: 80px; heigth: 27px;" onclick="save(2)">
						<fmt:message key="global.save" />
						<fmt:message key="main.quit" />
					</button>
					<!-- 修改 -->
					<button class="tsdbutton" id="modify21"
						style="width: 63px; heigth: 27px;" onclick="modify()">
						<fmt:message key="global.edit" />
					</button>
					<!-- 取消-->
					<button class="tsdbutton" id="reset21"
						style="width: 63px; heigth: 27px;" onclick="resett()">
						<fmt:message key="nums.cancel"/>
					</button>
					<!-- 批量修改 &nbsp;-->
					<button class="tsdbutton" id="modifyB21"
						style="width: 79px; heigth: 33px;" onclick="fuheModify()">
						<fmt:message key="tariff.modifyb" />
					</button>
					<!-- 关闭 -->
					<button class="tsdbutton" id="close21"
						style="width: 63px; heigth: 27px;" onclick="closeo()">
						<fmt:message key="global.close" />
					</button>
				</div>




			</div>
		</div>


		<!-- 号码资源二级模块局设置 -->
	<div class="neirong" id="pan22" style="display: none">
<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="nums.projectname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="nums.close" /></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		
		<div class="midd" >
			<table width="100%"  id="tdiv22" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
		    <tr>
		    <td width="12%" align="right" class="labelclass"><label id="MokuaiJu222" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iMokuaiJu222" class="textclass" maxlength="50"/><label class="addred" ></label></td>
		    <td width="12%" align="right"  class="labelclass"><label id="MokuaiJu22" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><select  name="iMokuaiJu22" id="iMokuaiJu22" class="textclass">
							<option value="">--<fmt:message key='global.select'/>--</option>
							</select>
							<input type="text" id="iMokuaiJu22i2"/></td>
		    <td width="12%" align="right"  class="labelclass"><label  id="IsUse22" ></label></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    <select name="iIsUse22" id="iIsUse22" class="textclass">
							<option value="">--<fmt:message key='global.select'/>--</option>
							<option value="0"><fmt:message key='dangan.n'/></option>
							<option value="1"><fmt:message key='dangan.y'/></option>
							</select>
							<input type="text" id="iIsUse222"/>
							</td>
		  </tr>
		   <tr>
		    <td width="12%" align="right" class="labelclass"><label id="Bz22" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    <select  name="iBz22" id="iBz22" class="textclass">
							<option value="">--<fmt:message key='global.select'/>--</option>
							</select>
							<input type="text" id="iBz222"/></td>
		    <td width="12%" align="right"  class="labelclass"></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
		    <td width="12%" align="right"  class="labelclass"></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
		  </tr>
		  
		
		</table>
		
		 <div class="midd_butt">
		 <!-- 保存新增 --><button class="tsdbutton" id="save22" style="width:80px;heigth:27px;" onclick="save(1)" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
		 	 <!-- 保存退出 --><button class="tsdbutton" id="save221" style="width:80px;heigth:27px;" onclick="save(2)" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>			
		  <!-- 修改 --><button class="tsdbutton" id="modify22" style="width:63px;heigth:27px;" onclick="modify()" ><fmt:message key="global.edit" /></button>
		   <!-- 批量修改&nbsp;--> <button class="tsdbutton" id="modifyB22" style="width:79px;heigth:33px;" onclick="fuheModify()" ><fmt:message key="tariff.modifyb" /></button>
		   <!-- 取消--><button class="tsdbutton" id="reset22" style="width:63px;heigth:27px;" onclick="resett()" ><fmt:message key="nums.cancel"/></button>
		   <!-- 关闭 --><button class="tsdbutton"  id="close22" style="width:63px;heigth:27px;" onclick="closeo()" ><fmt:message key="global.close" /></button>
			</div>			
			
	
			
			 
		  </div>
		</div>
		<!-- 导出数据 -->
			<div class="neirong" id="thefieldsform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv"><fmt:message key="nums.chooseexportdata" /></div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();"><fmt:message key="nums.close" /></a></div>
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
						<fmt:message key="nums.selectall"/>
					</button>
					<button type="submit" class="tsdbutton" id="query2" onclick="saveExoprt();">
						<fmt:message key="global.ok" />
					</button>
					<button type="button" class="tsdbutton" id="closethisinfo" >
						<fmt:message key="global.close" />
					</button>
					
				</div>
		</div>	
		
			
		
		
			<!-- 添加模板面板 -->
<div id="modT" name='modT' style="display: none"  class="neirong">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="nums.functionname" /></div>
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
				    	<input type="text" name="name_mod" id="name_mod" onkeyup="this.value=replaceStrsql(this.value,80)" class="textclass"/>
				    	<font style="color: #ff0000;">*</font></td>
				    
				    <td width="12%" align="right"  class="labelclass"><label id=''></label></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
					
				    <td width="12%" align="right"  class="labelclass"></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
			 	 </tr>	  
			</table>
		</form>
		<div class="midd_butt">
		<!-- 保存 --><button class="tsdbutton" id="saveModB" style="width:80px;heigth:27px;" onclick="saveModQuery(getTable_s());" ><fmt:message key="global.save" /></button>
	 	<!-- 关闭 --><button class="tsdbutton" id="closeModB" style="width:63px;heigth:27px;" onclick="closeoMod();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>			
		
		<!-- -查询面板 -->
		<div class="neirong" id="pan112" style="display: none">
<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="nums.projectname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="$('#closeo11').close()"><span style="margin-left:5px;"><fmt:message key="nums.close" /></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>

		<div class="midd" >
			<table width="100%"  border="0"  cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
		  <tr>
		    <td width="12%" align="right" class="labelclass"><label id="lHMStart11" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iiHMStart11"   class="textclass" maxlength="20"  onkeypress="var   k=event.keyCode;   return   k>=48&&k<=57" style="ime-mode:Disabled"/></td>
		    <td width="12%" align="right"  class="labelclass"><label id="lHMEnd11" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iiHMEnd11"    class="textclass" maxlength="20"  onkeypress="var   k=event.keyCode;   return   k>=48&&k<=57" style="ime-mode:Disabled"/></td>
		    <td width="12%" align="right"  class="labelclass"></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">		   
		    </td>
		  </tr>
		 
		
		</table>
		
		 <div class="midd_butt">
		 	<!-- 查询     --><button class="tsdbutton" id="jdquery" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
			<!-- 关闭 --><button class="tsdbutton"  id="closeo11" style="width:63px;heigth:27px;" onclick="closeo()" ><fmt:message key="global.close" /></button>
			</div>			
			
	
			
			 
		  </div>
		</div>
		
		<!-- 号码资源明细 -->
	<div class="neirong" id="pan122" style="display: none">
<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="nums.projectname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="$('#closeo12').click()"><span style="margin-left:5px;"><fmt:message key="nums.close" /></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		
		<div class="midd" >
			<table width="100%"  border="0"  cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
		    <tr>
		    <td width="12%" align="right" class="labelclass"><label id="lDh12" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iiDh12" class="textclass" /></td>
		    <td width="12%" align="right"  class="labelclass"><label id="lMokuaiJu12" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    <select   id="iiMokuaiJu12"  class="textclass" ><option value="">--<fmt:message key='global.select'/>--</option></select></td>
		   <td width="12%" align="right"  class="labelclass"><label id="lYwArea12" ></label></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    <select id="iiYwArea12"    class="textclass" ><option value="">--<fmt:message key='global.select'/>--</option></select></td>
		   
		   </tr>
		   
		</table>
		
		 <div class="midd_butt">
		 <!-- 查询     --><button class="tsdbutton" id="jdquery" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
		   <!-- 关闭 --><button class="tsdbutton" id="closeo12"  style="width:63px;heigth:27px;" onclick="closeo()" ><fmt:message key="global.close" /></button>
			</div>			
			
	
			
			 
		  </div>
		</div>
	<!-- 号码级别设置 -->
	<div class="neirong" id="pan132" style="display: none">
<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="nums.projectname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="$('#closeo13').click()"><span style="margin-left:5px;"><fmt:message key="nums.close" /></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		
		<div class="midd" >
			<table width="100%"  border="0"  cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
		    <tr>
		    <td width="12%" align="right" class="labelclass"><label id="lHm_Level13" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iiHm_Level13" maxlength="10" onkeypress="var k=event.keyCode;   return  k>=48&&k<=57" class="textclass" style="ime-mode:Disabled"/></td>
		    
		    <td width="12%" align="right"  class="labelclass"><label id="lBz13" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iiBz13" maxlength="20" class="textclass" /></td>
		   <td width="12%" align="right"  class="labelclass"></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
		   
		    </tr>
		  
		
		</table>
		
		 <div class="midd_butt">
		  <!-- 查询     --><button class="tsdbutton" id="jdquery" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
		 <!-- 关闭 --><button class="tsdbutton"  id="closeo13" style="width:63px;heigth:27px;" onclick="closeo()" ><fmt:message key="global.close" /></button>
			</div>			
			
	
			
			 
		  </div>
		</div>
		
		
			<!-- 号码资源二级模块局设置 -->
	<div class="neirong" id="pan222" style="display: none">
<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="nums.projectname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="$('#closeo22').click()"><span style="margin-left:5px;"><fmt:message key="nums.close" /></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		
		<div class="midd" >
			<table width="100%"   border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
		    <tr>
		    <td width="12%" align="right" class="labelclass"><label id="lMokuaiJu222" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iiMokuaiJu222" class="textclass" maxlength="50"/></td>
		    <td width="12%" align="right"  class="labelclass"><label id="lMokuaiJu22" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><select  name="iMokuaiJu22" id="iiMokuaiJu22" class="textclass">
							<option value="">--<fmt:message key='global.select'/>--</option>
							</select></td>
		    <td width="12%" align="right"  class="labelclass"><label  id="lIsUse22" ></label></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    <select name="iIsUse22" id="iiIsUse22" class="textclass">
							<option value="">--<fmt:message key='global.select'/>--</option>
							<option value="0"><fmt:message key='dangan.n'/></option>
							<option value="1"><fmt:message key='dangan.y'/></option>
							</select>
							</td>
		  </tr>
		   <tr>
		    <td width="12%" align="right" class="labelclass"><label id="lBz22" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    <select  name="iBz22" id="iiBz22" class="textclass">
							<option value="">--<fmt:message key='global.select'/>--</option>
			</select></td>
		    <td width="12%" align="right"  class="labelclass"></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
		    <td width="12%" align="right"  class="labelclass"></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
		  </tr>
		  
		
		</table>
		
		 <div class="midd_butt"> 
		 <!-- 查询     --><button class="tsdbutton" id="jdquery" onclick="QbuildParams();"><fmt:message key="global.query" /></button> 
		 <!-- 关闭 --><button class="tsdbutton"  id="closeo22" style="width:63px;heigth:27px;" onclick="closeo()" ><fmt:message key="global.close" /></button>
			</div>			
			
	
			
			 
		  </div>
		</div>
		
			<!-- 不动的部分 -->
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
					<input type="hidden" id="management"
						value="<fmt:message key="ip.management"/>" />
					<input type="hidden" id="worninfo"
						value="<fmt:message key="ip.worn"/>" />
					<input type="hidden" id="worntips"
						value="<fmt:message key="ip.worntips"/>" />
					<input type="hidden" id="deletepower"
						value="<fmt:message key="global.deleteright"/>" />
					<input type="hidden" id="editpower"
						value="<fmt:message key="global.editright"/>" />
					
					<input type="hidden" id="deletefailed"
						value="<fmt:message key="ip.deletefailed"/>" />
					<input type="hidden" id="selectarea"
						value="<fmt:message key="ip.select"/>" />
					<input type="hidden" id="inputip"
						value="<fmt:message key="ip.inputip"/>" />
					<input type="hidden" id="selectarea"
						value="<fmt:message key="ip.selectarea"/>" />
					<input type="hidden" id="addmemo"
						value="<fmt:message key="ip.addmemo"/>" />
						
					
				<!-- 权限 -->
					<input type="hidden" id="addright"/>	
					<input type="hidden" id="addBright"/>			
					<input type="hidden" id="deleteright"/>
					<input type="hidden" id="delBright"/>
					<input type="hidden" id="editright"/>	
					<input type="hidden" id="editBright"/>								
					<input type="hidden" id="exportright" />
					<input type="hidden" id="printright" />	
					<input type="hidden" id="allnumsright" />
					<input type="hidden" id="numsright" />	
					<input type="hidden" id="editfield1"/>	
					<input type="hidden" id="editfield2"/>	
					<input type="hidden" id="editfield3"/>	
					<input type="hidden" id="editfield4"/>	
					<input type="hidden" id="editfield5"/>	
						
						
					<input type="hidden" id="userid" value="<%=userid %>"/>
					<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 	
					<input type="hidden" id="logoldstr"/>
					
					<input type="hidden" id="ziduans11"/>	
					<input type="hidden" id="ziduans12"/>	
					<input type="hidden" id="ziduans13"/>	
					<input type="hidden" id="ziduans21"/>	
					<input type="hidden" id="ziduans22"/>	
					
					<!-- 国际化保存表字段名 -->	
					
					<input type="hidden" id="id" />					
					 
					
						<!-- /****日志*** -->	
					<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>'/> 
				   <input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
				   <input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 			  
				    <input type='hidden' id='oldh'  /> 				   	
				    <input type='hidden' id='areah'  />
				    <input type="hidden" id="addh"/>
				    <input type="hidden" id="edith"/>
				    <!-- 控制生成号码停止 -->
				    <input type="hidden" id="stop" value="1"/>
				    <!-- 日志修改操作时，保存旧数据 -->
					<!-- 号码分配 -->					
					<input type="hidden" id="HMStartoh"/>	
					<input type="hidden" id="HMEndoh"/>	
					<input type="hidden" id="YwAreaoh"/>	
					<input type="hidden" id="Bzoh"/>	
					<input type="hidden" id="MokuaiJuoh"/>	
					<input type="hidden" id="Dhlxoh"/>	
					<input type="hidden" id="Jhj_IDoh"/>	
					<input type="hidden" id="PreHthoh"/>
					<input type="hidden" id="loghaoma"/>
					
					<!-- 号码资源明细 -->					
				   	 <input type="hidden" id="Dh_Leveloh"/>	
					<input type="hidden" id="IsKeepoh"/>						
					<input type="hidden" id="Dhlxoh"/>	
					<input type="hidden" id="YwAreaoh"/>	
					<!-- 号码级别设置 -->
					<input type="hidden" id="Hm_Leveloh"/>						
					<input type="hidden" id="Bzoh"/>	
					<input type="hidden" id="SelectFeeoh"/>	
					<!-- 号码资源调整 -->
					<input type="hidden" id="Dhoh"/>
					<!-- 号码资源二级模块局设置 -->
					<input type="hidden" id="IDoh"/>
					<input type="hidden" id="MokuaiJu2oh"/>
					<input type="hidden" id="IsUseoh"/>
					
					<!-- 下拉多选	 -->
					<input type='hidden' id='thestate'/> 
					<input type='hidden' id='isdept'/> 
				   <input type='hidden' id='isdeptm'/>
					
					
				   		 
				   		 
				<!-- 高级查询 模板隐藏域 -->
				<input type="hidden" id="queryright"/>
				<input type="hidden" id="saveQueryMright"/>	
				<!-- 查询树信息存放 -->
				<input type="hidden" id='treepid' />	
				<input type="hidden" id='treecid' />	
				<input type="hidden" id='treestr' />	
				<input type="hidden" id='treepic' />	
				<input type="hidden" id="useridd" value="<%=userid %>"/>	
				</div>
	
  </body>
</html>