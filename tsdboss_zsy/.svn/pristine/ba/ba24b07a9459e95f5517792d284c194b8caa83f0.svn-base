<%----------------------------------------
	name: areas.jsp
	author: fulingqiao
	version: 1.0, 2009-11-26
	description: 区域设置 Locale
	modify: 
			2010-11-15 sunlin 修改营收区域中业务区域下拉选初始化以及相关功能
			2010-12-21 youhongyu   修改本查询为模板功能，使其能区分本次要保存的查询内容是来自哪个表
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		<script type="text/javascript" src="script/public/transfer.js"></script>
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
		<script type="text/javascript">
			/**
			 * 查看当前用户的扩展权限，对spower字段进行解析
			 * @param 无参数
			 * @return 无返回值
			 */
			function getUserPower(){
				 var urlstr=buildParamsPro("areas.getPower","query");
				
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
				
				var deleteright = '';
				var editright = '';
				var editfield1 = '';
				var editfield2 = '';
				var editfield3 = '';
				var editfield4 = '';
				
				var exportright = '';
				var printright ='';
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
							
							delBright += getCaption(spowerarr[i],'delB','')+'|';
							
							editBright += getCaption(spowerarr[i],'editB','')+'|';	
														
							deleteright += getCaption(spowerarr[i],'delete','')+'|';
							
							editright += getCaption(spowerarr[i],'edit','')+'|';	
							
							editfield1 += getCaption(spowerarr[i],'editfields','');
							editfield2 += getCaption(spowerarr[i],'editfields2','');
							editfield3 += getCaption(spowerarr[i],'editfields3','');
							editfield4 += getCaption(spowerarr[i],'editfields4','');
							
							exportright += getCaption(spowerarr[i],'export','')+'|';
							
							printright += getCaption(spowerarr[i],'print','')+'|';
							queryright += getCaption(spowerarr[i],'query','')+'|';
							
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
						$("#saveQueryMright").val(str);
						
						editfield1 = getFields('MokuaiJu');
						editfield2 = getFields('mokuaiju2');
						editfield3 = getFields('Area_Ywsl');
						editfield4 = getFields('Asys_Area');
						
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
				$("#editfield1").val(editfield1);
				$("#editfield2").val(editfield2);
				$("#editfield3").val(editfield3);
				$("#editfield4").val(editfield4);
			}
		</script>
		<script type="text/javascript">
		
		/******************************************
			**  查看当前用户的扩展权限，对spower字段进行解析 *
			*****************************************/
			var tabStatus=1;
			
			
		/**
		 * 向页面中jgride标签
		 * @param id(唯一标识)
		 * @return 无返回值
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
				break;
			case 2:
				tabStatus=2;				
				break;
			case 3:
				tabStatus=3;				
				break;
			case 4:
				tabStatus=4;				
				break;
		}		
		fenyeUtil();
	}
	 /**
	 * 通过调用配置文件中的sql查看对象
 	 * @param 无参数
	 * @return 无返回值
	 */	
	jQuery(document).ready(function () {
		//页面表头当前位置显示
		$("#navBar1").append(genNavv());
		
		listAreaMokuaiJu();
		getUserPower();	
		
		var add = $("#addright").val();
		if(add=="true"){
				$("#openadd").removeAttr("disabled");	
				$("#openaddf").removeAttr("disabled");
		}
		var exportright = $("#exportright").val();
		if(exportright=="true"){
				$("#export").removeAttr("disabled");	
				$("#exportf").removeAttr("disabled");
		}
		var queryright = $("#queryright").val();
		var saveQueryMright = $("#saveQueryMright").val();
		if(queryright=="true"){
				$("#gjquery1").removeAttr("disabled");	
				$("#gjquery2").removeAttr("disabled");
		}
		if(saveQueryMright=="true"){
				document.getElementById("savequery1").disabled=false;
				document.getElementById("savequery2").disabled=false;
		}
		$("#tabs").tabs();
		fenyeUtil();
		setLabel();
		setywarea();
	});
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
							document.getElementById("iMokuaiJu22").options.add(new Option(MokuaiJu,MokuaiJu));															
						});		
				
					}});
				
				}
				
			/**
			 * 分页工具
			 * @param 无参数
			 * @return 无返回值
			 */
			function fenyeUtil(){
			/////设置命令参数
			 var urlstr=tsd.buildParams({ packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'areas'+tabStatus+'.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'areas'+tabStatus+'.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
											});
		var col=[[],[]];
		//当分项卡为业务区域设置时，只有删除和详细功能
		if(tabStatus == 3){
			col=getRb_Field(getTable(),getId(),"删除|详细",'97','ziduans'+tabStatus);;//得到jqGrid要显示的字段		
		}else{
			col=getRb_Field(getTable(),getId(),"修改|删除|详细",'97','ziduans'+tabStatus);;//得到jqGrid要显示的字段
		}
	   if(tabStatus==2){
		var ziduan=$("#ziduans"+tabStatus).val();
		ziduan = ziduan.replace(new RegExp('IsUse',"g"),"case when IsUse='1' then '是' when IsUse='0' then '否' else ' ' end  as IsUse");		
		tsd.QualifiedVal=true;
		  ziduan=tsd.encodeURIComponent(ziduan);
		   if(tsd.Qualified()==false){return false;}
		  
		$("#ziduans"+tabStatus).val(ziduan);
		
		}
		jQuery("#editgrid").jqGrid({		
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
				       	pager: jQuery('#pagered'), 
				       	sortname: getId(), //默认排序字段
				       	viewrecords: true, 
				       	//hidegrid: false, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:getTitle(""), 
				       	height:300, //高
				     	//width:document.documentElement.clientWidth-27,
				       	loadComplete:function(){
				       		//业务区域下拉选初始化
										$("#editgrid").setSelection('0', true);
										$("#editgrid").focus();
										var editinfo = $("#editinfo").val();
										var deleteinfo = $("#deleteinfo").val();
										if(tabStatus == 3){
											addRowOperBtnimage('editgrid','openDel',getId(),'click',1,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
											addRowOperBtnimage('editgrid','openInfo',getId(),'click',2,'style/images/public/ltubiao_03.gif',"<fmt:message key='numsyield'/>","&nbsp;&nbsp;&nbsp;");//生成号码库
											executeAddBtn('editgrid',2);
										}else{
											addRowOperBtnimage('editgrid','openModify',getId(),'click',1,"style/images/public/ltubiao_01.gif",editinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
											addRowOperBtnimage('editgrid','openDel',getId(),'click',2,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
											addRowOperBtnimage('editgrid','openInfo',getId(),'click',3,'style/images/public/ltubiao_03.gif',"<fmt:message key='numsyield'/>","&nbsp;&nbsp;&nbsp;");//生成号码库
											executeAddBtn('editgrid',3);
										}
									
										
										 var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered"+tabStatus).height();
										 setAutoGridHeight("editgrid",reduceHeight);
										},
										ondblClickRow:function(rowid){
										var id=$("#editgrid").getCell(rowid,getId());
										openInfo(id);//详细
										}
				}).navGrid('#pagered',  {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
		}
	/**
	 * 向label中写数据
	 * @param 无参数
	 * @return 无返回值
	 */
	function setLabel(){
			var thisdata = loadData('MokuaiJu','<%=languageType %>',1);	
			var Bz=thisdata.getFieldAliasByFieldName('Bz');
			var ID=thisdata.getFieldAliasByFieldName('ID');
			var MokuaiJu=thisdata.getFieldAliasByFieldName('MokuaiJu');
			//获取数据表对应字段国际化信息
			var languageType = $("#languageType").val();
			//隐藏域,给页面中存储字段的标签赋值	
			$("#MokuaiJu").val(MokuaiJu);
			$("#lMokuaiJu").html(MokuaiJu);
			$("#Bz").html(Bz);
			
			
			var thisdata = loadData('mokuaiju2','<%=languageType %>',1);	
				
			var MokuaiJu=thisdata.getFieldAliasByFieldName('MokuaiJu');
			var IsUse=thisdata.getFieldAliasByFieldName('IsUse');
			var Bz=thisdata.getFieldAliasByFieldName('Bz');
			var ID=thisdata.getFieldAliasByFieldName('ID');
			var MokuaiJu2=thisdata.getFieldAliasByFieldName('MokuaiJu2');
			//隐藏域,给页面中存储字段的标签赋值
			$("#MokuaiJu22").html(MokuaiJu);
			$("#lMokuaiJu222").html(MokuaiJu2);
			$("#MokuaiJu222").val(MokuaiJu2);
			$("#IsUse22").html(IsUse);
			$("#Bz22").html(Bz);
			
			
			var thisdata = loadData('Area_Ywsl','<%=languageType %>',1);	
			
			var Xuhao=thisdata.getFieldAliasByFieldName('Xuhao');
			var YwArea=thisdata.getFieldAliasByFieldName('YwArea');
			//隐藏域,给页面中存储字段的标签赋值	
			$("#lYwArea").html(YwArea);
			$("#YwArea").val(YwArea);
			
			var thisdata = loadData('Asys_Area','<%=languageType %>',1);	
				var area=thisdata.getFieldAliasByFieldName('Area');
				var xuhao=thisdata.getFieldAliasByFieldName('Xuhao');
				var ywarea=thisdata.getFieldAliasByFieldName('ywareaid');
			//隐藏域,给页面中存储字段的标签赋值	
			
			$("#lArea").html(area);
			$("#YWAREA").html(ywarea);
			$("#Area").val(area);
			$("#YArea").val(ywarea);
			
	
	}
           	/**
			 * 拼接参数
			 * @param 无参数
			 * @return 无返回值
			 */
           		function buildParam(){
    switch(tabStatus){
    case 1:
           			tsd.QualifiedVal=true;  	
				var str="";	
		  		var MokuaiJu=$("#iMokuaiJu").val();		  		
		  		if(MokuaiJu!=null&&MokuaiJu!=""){
		  		str=str+"&MokuaiJu="+tsd.encodeURIComponent(strtrim(MokuaiJu));
		  		}else{
		  		str=str+"&MokuaiJu="+strtrim(MokuaiJu);
		  		}
		  		var Bz=$("#iBz").val();	
		  		if(Bz!=null&&Bz!=""){
		  		str=str+"&Bz="+tsd.encodeURIComponent(Bz);
		  		}else{	  		
		  		str=str+"&Bz="+Bz;
		  		}
		  		
		  		 //每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}
		  		
		  		if(MokuaiJu==""){  	
		  			alert($("#MokuaiJu").val()+"<fmt:message key="global.notNull"/>");
		  			return false;
		  		} 
		  		
		  		////验证
		  		 if(subStrsql(MokuaiJu,50)==1){
		  			//alert($("#MokuaiJu").val()+"<fmt:message key="global.tooLong"/>");
		  			alert("\""+$("#MokuaiJu").val()+"\"字符串的字节数不能大于"+50+",\n注：汉字表示两个字节,\n其他的如英文表示一个字节");
		  			return false;
		  		}
		  		if(subStrsql(Bz,50)==1){
		  			//alert($("#Bz").html()+"<fmt:message key="global.tooLong"/>");
		  			alert("\""+$("#Bz").html()+"\"字符串的字节数不能大于"+50+",\n注：汉字表示两个字节,\n其他的如英文表示一个字节");
		  			return false;
		  		}
		  	
		  		///日志
		  		var info=$("#MokuaiJu").val()+":"+MokuaiJu+",";
		  		var info1=$("#MokuaiJu").val()+":"+$("#MokuaiJuoh").val()+" >>> "+MokuaiJu+" ";
		  		if(Bz!=null&&Bz!=""){
		  		info=info+$("#Bz").html()+":"+Bz+",";				
				info1=info1+$("#Bz").html()+":"+$("#Bzoh").val()+" >>> "+Bz+" ";
				}
				
				$("#addh").val(info);											
				$("#edith").val(info1);		
					  		
		  		return str;
				break;
case 2:
					tsd.QualifiedVal=true;  	
				var str="";	
		  		var Dh_Level=$("#iMokuaiJu22").val();		  		
		  		if(Dh_Level!=null&&Dh_Level!=""){
		  		str=str+"&MokuaiJu="+tsd.encodeURIComponent(strtrim(Dh_Level));
		  		}else{
		  		str=str+"&MokuaiJu="+Dh_Level;
		  		}
		  		var IsKeep=$("#iMokuaiJu222").val();	
		  		if(IsKeep!=null&&IsKeep!=""){
		  		str=str+"&MokuaiJu2="+tsd.encodeURIComponent(IsKeep);
		  		}else{	  		
		  		str=str+"&MokuaiJu2="+IsKeep;
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
		  		if(IsKeep==""||IsKeep==null){  	
		  			alert($("#MokuaiJu222").val()+"<fmt:message key="global.notNull"/>");
		  			return false;
		  		} 
		  		if(IsKeep!=""&&subStrsql(IsKeep,50)==1){	 alert("\""+$("#MokuaiJu222").val()+"\"字符串的字节数不能大于"+50+",\n注：汉字表示两个字节,\n其他的如英文表示一个字节"); return false; 	}
		  		if(Dhlx!=""&&subStrsql(Dhlx,50)==1){	 alert("\""+$("#Bz22").html()+"\"字符串的字节数不能大于"+50+",\n注：汉字表示两个字节,\n其他的如英文表示一个字节"); return false; 	}
		  		 //每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}
		  		var info1=$("#MokuaiJu22").val()+":"+$("#MokuaiJu22oh").val()+" >>> "+Dh_Level+",";	
		  		var info1=info1+$("#MokuaiJu222").val()+":"+$("#MokuaiJu222oh").val()+" >>> "+IsKeep+",";
				var info1=info1+$("#Bz22").html()+":"+$("#Bz22oh").val()+" >>> "+Dhlx+",";	 
		  		var info1=info1+$("#IsUse22").html()+":"+$("#IsUse22oh").val()+" >>> "+MokuaiJu+" ";
				$("#edith").val(info1);		
		  		return str;
				break;
case 3: 
					tsd.QualifiedVal=true;  	
				var str="";	
		  		var MokuaiJu=$("#iYwArea").val();		  		
		  		if(MokuaiJu!=null&&MokuaiJu!=""){
		  		str=str+"&YwArea="+tsd.encodeURIComponent(strtrim(MokuaiJu));
		  		}else{
		  		str=str+"&YwArea="+strtrim(MokuaiJu);
		  		}
		  		
		  		 //每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}
		  	  	///验证
		  	  		if(MokuaiJu==""){  	
					  			alert($("#YwArea").val()+": <fmt:message key="global.notNull"/>");
					  			return false;
					  		}  
			  		if(MokuaiJu!=""&&subStrsql(MokuaiJu,20)==1){	 alert("\""+$("#YwArea").val()+"\"字符串的字节数不能大于"+20+",\n注：汉字表示两个字节,\n其他的如英文表示一个字节"); return false; 	}
				  	
		  		///日志
		  		var info=$("#YwArea").val()+":"+MokuaiJu+" ";
		  		var info1=$("#YwArea").val()+":"+$("#YwAreaoh").val()+" >>> "+MokuaiJu+" ";
				$("#addh").val(info);											
				$("#edith").val(info1);		
					  		
		  		return str;
		  		break;
case 4:				
				tsd.QualifiedVal=true;  	
				var str="";	
		  		var area=$("#iArea").val();	
		  		var yw_area=$("#yw_area").val();	
		  		if(area!=null&&area!=""){
		  		str=str+"&Area="+tsd.encodeURIComponent(area);
		  		}else{	  		
		  		str=str+"&Area="+area;
		  		}
		  		if(yw_area!=null&&yw_area!=""){
		  		str=str+"&ywareaid="+tsd.encodeURIComponent(yw_area);
		  		}else{	  		
		  		str=str+"&ywareaid="+yw_area;
		  		}
		  		
		  		 //每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}
		  		////验证
		  		if(area==""||area==null){  	
					  			alert($("#Area").val()+": <fmt:message key="global.notNull"/>");
					  			return false;
					  		} 
				if(area!=""&&subStrsql(area,50)==1){	 alert("\""+$("#Area").val()+"\"字符串的字节数不能大于"+50+",\n注：汉字表示两个字节,\n其他的如英文表示一个字节"); return false; 	}
		  		///日志
		  		var info=$("#Area").val()+":"+area+" ";
		  		var info1=$("#Area").val()+":"+$("#Areaoh").val()+" >>> "+area+" ";
				$("#addh").val(info);											
				$("#edith").val(info1);	
		  		return str;	
				break;

}////switch end		  		
		  	
           		}       
           	/**
			 * 重新加载jQuery
			 * @param 无参数
			 * @return 无返回值
			 */
			 function querylist(){
			  $("#fusearchsql").val("");
			  var urlstr=tsd.buildParams({ packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'areas'+tabStatus+'.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'areas'+tabStatus+'.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
											});
			 	
			$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+"&ziduans="+$("#ziduans"+tabStatus).val()}).trigger("reloadGrid");
			 setTimeout($.unblockUI, 15);//关闭面板
			closeo();
			 }
			/**
			 * onblur事件，添加面板判断是否重复的。
			 * @param 无参数
			 * @return boolean
			 */
           	function acblur(){ 
           		var name="";
           		var nasname="";
           		var flag=true;
					switch(tabStatus){
							case 1: 
							name=$("#MokuaiJu").val();
							nasname=$("#iMokuaiJu").val();
							break;
							case 2:
							name=$("#MokuaiJu222").val();
							nasname=$("#iMokuaiJu222").val();	
							break;
							case 3:
							name=$("#YwArea").val();
							nasname=$("#iYwArea").val();
							break;
							case 4:
							name=$("#Area").val();
							 nasname=$("#iArea").val();
							break;
							
						
					}////switch end		     
			tsd.QualifiedVal=true; 
			var nasnamee=nasname;
			if(nasname!=null&&nasname!="")   		
  		      nasnamee=tsd.encodeURIComponent(strtrim(nasname));
  		if(tsd.Qualified()==false){return false;}     	            
           	if(!isExistByA(nasname!=null&&nasname!=""&&strtrim(nasnamee))){
           	 alert(name+":"+nasname+" "+"<fmt:message key="accountM.alert.userExist"/>");
           	 flag=false;
           	 }
           	 return flag;
           	}
           	/**
			 * 判断一个模块局数据是否已经存在
			 * @param ac
			 * @return boolean
			 */
  		 function isExistByA(ac){
  		 var flag=true;
  		var nasname="";
  		  var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'tsdBilling',
						 					tsdcf:'mssql',
						 					tsdoper:'query',
						 					datatype:'xmlattr',				 	
											tsdpk:'areas'+tabStatus+'.notin'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});	
						switch(tabStatus){
					
							case 1: 
							urlstr=urlstr+"&MokuaiJu="+ac;	
							break;
							case 2:
							urlstr=urlstr+"&MokuaiJu2="+ac;		
							break;
							case 3:
							urlstr=urlstr+"&YwArea="+ac;	
							break;
							case 4:
							urlstr=urlstr+"&Area="+ac;		
							break;
							
						
					}////switch end		
				
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
					
							case 1: 
							nasname=$(this).attr("id");
							break;
							case 2:
							nasname=$(this).attr("mokuaiju");	
							break;
							case 3:
							nasname=$(this).attr("xuhao");
							break;
							case 4:
							 nasname=$(this).attr("xuhao");	
							break;
							
						
					}////switch end							
													
							if(nasname!=undefined) {
									flag=false;	
									return false;
							}																			
						});		
				
					}});				
					return flag;
					
  		 }
           
			/**
			 * 新增弹出的对话框
			 * @param 无参数
			 * @return 无返回值
			 */
			function openadd(){
			//清空表单数据
			$("#iMokuaiJu").val("");$("#iBz").val("");$("#iMokuaiJu22").val("");$("#iMokuaiJu222").val("");
			$("#iIsUse22").val("");$("#iBz22").val("");	$("#iArea").val("");$("#iYwArea").val("");
			markTable(0);	
		    $(".top_03").html('<fmt:message key="global.add" />');//标题
  			openpan();
			$("#save"+tabStatus).show();
			$("#save"+tabStatus+"1").show();
			
			$("#tdiv"+tabStatus+" select").removeAttr("disabled"); 
  		 	$("#tdiv"+tabStatus+" input[type='text']").removeAttr("disabled"); 
  		 	$("#tdiv"+tabStatus+" input[type='text']").attr("readonly","");;
  		 	$("#tdiv"+tabStatus+" input[type='text']").removeClass();	$("#tdiv"+tabStatus+" input[type='text']").addClass("textclass");
  			
			}
			var closeflash=false;//关闭时是否刷新的标志,false,不用刷新;
  						//true，需要刷新
  		 	/**
			 * 关闭操作
			 * @param 无参数
			 * @return 无返回值
			 */
  		 function closefun(){
  		 if(closeflash){
  		 	closeflash=false;
  		 	querylist(); 
  		 	}  		 	
  		 	setTimeout($.unblockUI, 15);
  		 }
  		 	/**
			 * 新增操作
			 * @param savestatus(savestatus=1新增保存;savestatus=2新增退出)
			 * @return 无返回值
			 */
  		 function save(savestatus){ 			
					var str=buildParam();
					if(str==false) return false;
          			if(!acblur()){return false;} //验证唯一性 
										var urlstr=tsd.buildParams({packgname:'service',
								 					clsname:'ExecuteSql',
								 					method:'exeSqlData',
								 					ds:'tsdBilling',
								 					tsdcf:'mssql',
								 					tsdoper:'exe',				 	
													tsdpk:'areas'+tabStatus+'.save'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
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
									alert(successful,operationtips);
										
									var info=$("#addh").val();
									logwrite(1,info);
									if(savestatus==2){
										querylist();	
									}else{
										closeflash=true;//表示关闭时需要刷新
										////清空表单数据
									    $("#iMokuaiJu").val("");$("#iBz").val("");$("#iMokuaiJu22").val("");$("#iMokuaiJu222").val("");
										$("#iIsUse22").val("");$("#iBz22").val("");	$("#iArea").val("");$("#iYwArea").val("");
									}		
							}
							
							}});
}
  		 	/**
			 * 删除
			 * @param ID(唯一标识)
			 * @return 无返回值
			 */
  		  function openDel(ID){  
  			var deleteright=$("#deleteright").val();
		if(deleteright=="true"){
		$("#id").val(ID);
  		  var info=queryByAccount();
  		  var info="";
  		 if(confirm("<fmt:message key="global.alert.del"/>?")){  		
  		 var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'tsdBilling',
						 					tsdcf:'mssql',
						 					tsdoper:'exe',				 	
											tsdpk:'areas'+tabStatus+'.delByAccount'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});
		switch(tabStatus){
 		case 1:
			urlstr=urlstr+"&ID="+ID;
			break;
		case 2:
			urlstr=urlstr+"&ID="+ID;
			break;
		case 3: 
			urlstr=urlstr+"&Xuhao="+ID;
			break;
		case 4:
			urlstr=urlstr+"&Xuhao="+ID;
			break;
			
		}////switch end	
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
			 * 显示某条数据的日志，弹出修改面板显示的数据
			 * @param 无参数
			 * @return String
			 */
  		 	 function queryByAccount(){
  		 	 var ID=$("#id").val();    		 	   		 	
  		var info="";
  		 var urlstr=tsd.buildParams({packgname:'service',
						 				clsname:'ExecuteSql',
						 				method:'exeSqlData',
						 				ds:'tsdBilling',
						 				tsdcf:'mssql',
						 				tsdoper:'query',
						 				datatype:'xmlattr',				 	
										tsdpk:'areas'+tabStatus+'.queryById'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});
			switch(tabStatus){
	 		case 1:
				urlstr=urlstr+"&ID="+ID;
				break;
			case 2:
				urlstr=urlstr+"&ID="+ID;
				break;
			case 3: 
				urlstr=urlstr+"&Xuhao="+ID;
				break;
			case 4:
				urlstr=urlstr+"&Xuhao="+ID;
				break;
			
				
			}////switch end	
		
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
					    	case 1:			
									var MokuaiJu=$(this).attr("mokuaiju");								
									$("#iMokuaiJu").val(MokuaiJu);
									var Bz=$(this).attr("bz");								
									$("#iBz").val(Bz);
									////修改操作记录日志时，保存旧数据
									$("#MokuaiJuoh").val(MokuaiJu);
									$("#Bzoh").val(Bz);
								    var info=$("#MokuaiJu").val()+":"+MokuaiJu+" "+$("#Bz").html()+":"+Bz;
									$("#addh").val(info);				
									break;
							case 2:
					 				var MokuaiJu=$(this).attr("mokuaiju");
									var MokuaiJu2=$(this).attr("mokuaiju2");
									var IsUse=$(this).attr("isuse");
									var Bz=$(this).attr("bz");
									$("#iMokuaiJu22").val(MokuaiJu);						
									$("#iMokuaiJu222").val(MokuaiJu2);
									$("#iIsUse22").val(IsUse);
									$("#iBz22").val(Bz);
									////修改操作记录日志时，保存旧数据
									$("#MokuaiJu22oh").val(MokuaiJu);
									$("#MokuaiJu222oh").val(MokuaiJu2);
									$("#IsUse22oh").val(IsUse);
									$("#Bz22oh").val(Bz);	
									var info="";
									info=$("#MokuaiJu222").val()+":"+MokuaiJu2+","+$("#MokuaiJu22").html()+":"+MokuaiJu+",";
									info=info+$("#IsUse22").html()+":"+strtrim(IsUse)+",";
									info=info+$("#Bz22").html()+":"+Bz+" ";	
									$("#addh").val(info);
									break;
									
							case 3: 		
									var Bz=$(this).attr("ywarea");								
									$("#iYwArea").val(Bz);
									////修改操作记录日志时，保存旧数据
									$("#YwAreaoh").val(Bz);
									var info=$("#YwArea").val()+":"+Bz;
									$("#addh").val(info);		
									break;
							case 4:				
										
									var area=$(this).attr("area");								
									$("#iArea").val(area);
									var ywareaid=$(this).attr("ywareaid");	
									$("#yw_area").val(ywareaid);
									////修改操作记录日志时，保存旧数据
									$("#Areaoh").val(area);
									var info=$("#Area").val()+":"+area;								
									$("#addh").val(info);			
									break;
								
						}////switch end	
						});						
				
					}});
					
					return info;
  		 }
  		 	/**
			 * 显示详细信息
			 * @param bname(唯一标识)
			 * @return 无返回值
			 */
  		  function openInfo(bname){
  		  $("#id").val(bname);
  		  $(".top_03").html('详细');//标题
  		 	markTable(1);
  			queryByAccount();
  		 	openpan();
  		 	//下拉列表隐藏
  		 	$("#imokuaiju").css("display","");
  		 	$("#iMokuaiJu22").css("display","none");
  		 	$("#imokuaiju").val($("#iMokuaiJu22 option[selected]").text());
  		 	$("#iIsUse222").css("display","");
  		 	$("#iIsUse22").css("display","none");
  		 	$("#iIsUse22").val($("#iIsUse222 option[selected]").text());
  		 	//所有字段置为disabled
  		 	$("#tdiv"+tabStatus+" select").attr("disabled","disabled"); 
  		 	$("#tdiv"+tabStatus+" input[type='text']").removeAttr("disabled"); 
  		 	$("#tdiv"+tabStatus+" input[type='text']").attr("disabled","disabled"); 		 	
			$("#tdiv"+tabStatus+" input[type='text']").removeClass();	$("#tdiv"+tabStatus+" input[type='text']").addClass("textclass2");
  			//把每个面板的第一个字段置为readonly
  			$("#iMokuaiJu").removeAttr("disabled");$("#iMokuaiJu").attr("readonly","readonly");
  			$("#iMokuaiJu222").removeAttr("disabled");$("#iMokuaiJu222").attr("readonly","readonly");
  			$("#iYwArea").removeAttr("disabled");$("#iYwArea").attr("readonly","readonly");
  			$("#iArea").removeAttr("disabled");$("#iArea").attr("readonly","readonly");
			
  		
  		  }
  		 
		/**
		 * 修改弹出的对话框
		 * @param bname(唯一标识)
		 * @return 无返回值
		 */
		function openModify(bname){
			$("#id").val(bname);
			var editright=$("#editright").val();
			if(editright=="true"){				 					
			$(".top_03").html('<fmt:message key="global.edit" />');//标题
			openpan();
			markTable(0);
			var log=queryByAccount();
			$("#modify"+tabStatus).show();
			$("#reset"+tabStatus).show();
			$("#oldh").val(log);
  					
			/***字段权限控制***/
			//所有字段置为不可修改
			$("#tdiv"+tabStatus+" input[type='text']").removeClass();	$("#tdiv"+tabStatus+" input[type='text']").addClass("textclass2");
			$("#tdiv"+tabStatus+" select").removeClass();	$("#tdiv"+tabStatus+" select").addClass("textclass2");
			$("#tdiv"+tabStatus+" input[type='text']").attr("disabled","disabled");
			$("#tdiv"+tabStatus+" select").attr("disabled","disabled");
			var editfield1 = $("#editfield1").val(); 
			var editfield2 = $("#editfield2").val(); 
			var editfield3 = $("#editfield3").val(); 
			var editfield4 = $("#editfield4").val(); 
			var fields = "";
			var fieldarr = "";
			var spower = "";
			switch(tabStatus){
							
					case 1: 				
						fields = getFields("MokuaiJu");
						fieldarr = fields.split(",");
						spower = editfield1.split(",");
						break;
					case 2:				
						fields = getFields("mokuaiju2");
						fieldarr = fields.split(",");
						spower = editfield2.split(",");						
						break;
					case 3:				
						fields = getFields("Area_Ywsl");
						fieldarr = fields.split(",");
						spower = editfield3.split(",");					
						break;
					case 4:				
						fields = getFields("Asys_Area");
						fieldarr = fields.split(",");
						spower = editfield4.split(",");						
						break;									
								
			}////switch end																						
			
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
											if(tabStatus!="2"){	
												$('#i'+arr[i]).removeAttr("disabled");
												$('#i'+arr[i]).removeClass();$('#i'+arr[i]).addClass("textclass");		
											}if(tabStatus == "4"){
												if(arr[i] == "ywareaid"){
													$('#yw_area').removeAttr("disabled");
													$('#yw_area').removeClass();
													$('#yw_area').addClass("textclass");	
												}	
												$('#i'+arr[i]+"22").removeAttr("disabled");	
											}else{
												$('#i'+arr[i]+"22").removeAttr("disabled");
											}												
											break;
									}
							}
					}
			}
			//把每个面板的第一个字段置为readonly
			if($("#iMokuaiJu").attr("disabled")){
  			$("#iMokuaiJu").removeAttr("disabled");$("#iMokuaiJu").attr("readonly","readonly");
  			}
  			if($("#iMokuaiJu222").attr("disabled")){
  			$("#iMokuaiJu222").removeAttr("disabled");$("#iMokuaiJu222").attr("readonly","readonly");
  				}
  			if($("#iYwArea").attr("disabled")){
  			$("#iYwArea").removeAttr("disabled");$("#iYwArea").attr("readonly","readonly");
  				}
  			if($("#iArea").attr("disabled")){
  			$("#iArea").removeAttr("disabled");$("#iArea").attr("readonly","readonly");
  			}
  			
  			
  				}else{
						var operationtips = $("#operationtips").val();
						var editpower = $("#editpower").val();
						jAlert(editpower,operationtips);
					}
			
			}
  		 	/**
			 * 修改操作
			 * @param 无参数
			 * @return 无返回值(操作成功)/false(验证失败)
			 */
  		 function modify(){ 
			var ID=$("#id").val();
			var ischange;//关键字是否有改变,false为没有改变，true为有改变。
			switch(tabStatus){
			 case 1:
			  	if($("#iMokuaiJu").val()==$("#MokuaiJuoh").val()) ischange=false;
			  	break;
			  case 2:
			  	if($("#iMokuaiJu222").val()==$("#MokuaiJu222oh").val()) ischange=false;
			  	break;
			   case 3:
			  	if($("#iYwArea").val()==$("#YwAreaoh").val()) ischange=false;
			  	break;
			  case 4:
			  	if($("#iArea").val()==$("#Areaoh").val()) ischange=false;
			  	break;
			  
			} 		
			if((ischange!=false)&&!acblur()){return false;} //当关键字有改变时，验证唯一性 	
			var str=buildParam();
			if(str==false) return false;
			  		
								var urlstr=tsd.buildParams({packgname:'service',
									 					clsname:'ExecuteSql',
									 					method:'exeSqlData',
									 					ds:'tsdBilling',
									 					tsdcf:'mssql',
									 					tsdoper:'exe',				 	
														tsdpk:'areas'+tabStatus+'.updateByAccount'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											});
							switch(tabStatus){
					 		case 1:
								urlstr=urlstr+"&ID="+ID+str;
								break;
							case 2:
								urlstr=urlstr+"&ID="+ID+str;
								break;
							case 3: 
								urlstr=urlstr+"&Xuhao="+ID+str;
								break;
							case 4:
								urlstr=urlstr+"&Xuhao="+ID+str;
								break;
						
								
							}////switch end	
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
			 * 打开组合排序面板	
			 * @param 无参数
			 * @return 无返回值
			 */
			function openwinO()
			{
			switch(tabStatus){
 			case 1:
 					openDiaO('mokuaiju');
			
			break;
			case 2:
					openDiaO('mokuaiju2');
			break;
			case 3: 
					openDiaO('area_ywsl');
			break;
			case 4:
					openDiaO('asys_area');
			break;
			}////switch end					
			}
			/**
			 * 组合排序	
			 * @param sqlstr(组合排序条件)
			 * @return 无返回值(操作成功)/false(操作失败)
			 */
			function zhOrderExe(sqlstr){
					if(tabStatus==2){
					sqlstr = sqlstr.replace(new RegExp('IsUse',"g"),"case when IsUse='1' then '是' when IsUse='0' then '否' else ' ' end  ");		
					
					sqlstr = encodeURIComponent(sqlstr);
					if(tsd.Qualified()==false){return false;}
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
													  tsdpk:'areas'+tabStatus+'.queryByOrder',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
													  tsdpkpagesql:'areas'+tabStatus+'.queryByOrderpage'
													});
						var link = urlstr1 + params;						
					 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+"&ziduans="+$("#ziduans"+tabStatus).val()}).trigger("reloadGrid");
					 	//setTimeout($.unblockUI, 15);//关闭面板
				 	
			}
			/**
			 * 复合查询操作
			 * @param 无参数
			 * @return 无返回值
			 */
			function fuheQuery()
			{	
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
													  tsdpk:'areas'+tabStatus+'.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
													  tsdpkpagesql:'areas'+tabStatus+'.fuheQueryByWherepage'
													});
						var link = urlstr1 + params;	
					 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+"&ziduans="+$("#ziduans"+tabStatus).val()}).trigger("reloadGrid");
					 	setTimeout($.unblockUI, 15);//关闭面板	
			 
			}
			
            /**
			 * 打开复合查询面板	
			 * @param 无参数
			 * @return 无返回值
			 */	
			function openwinQ()
			{
				openfuh("query");
				
			}
		
            /**
			 * 复合查询参数获取	
			 * @param 无参数
			 * @return String
			 */
			 function fuheQbuildParams(){
			 	//每次拼接参数必须初始化此参数
				tsd.QualifiedVal=true;
			 	var params='';
			 	
			 	/***日志需要的***/
			 	var ss=$("#fusearchsql").val();	
			 	if(tabStatus==2){
					ss = ss.replace(new RegExp('IsUse',"g"),"case when IsUse='1' then '是' when IsUse='0' then '否' else ' ' end  ");		
					
					var fusearchsql = encodeURIComponent(ss);
					if(tsd.Qualified()==false){return false;}
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
	 * 打开面板	
	 * @param 无参数
	 * @return 无返回值
	 */
	function openpan(){
	$("#imokuaiju").css("display","none");
  	$("#iMokuaiJu22").css("display","");
  	$("#iIsUse222").css("display","none");
  	$("#iIsUse22").css("display","");
	autoBlockFormAndSetWH('pan'+tabStatus,60,5,'close'+tabStatus,"#ffffff",true,1000,'');//弹出查询面板	
	$("#modify"+tabStatus).hide();	$("#save"+tabStatus).hide();	$("#save"+tabStatus+"1").hide(); 	$("#reset"+tabStatus).hide();
	$("#jdquery"+tabStatus).hide();
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
	 * 获取table名字
	 * @param 无参数
	 * @return String
	 */
  	function getTable(){
  		 var table="";
			 switch(tabStatus){
			 case 1:
						table="mokuaiju";
						break;
			case 2:
						table="mokuaiju2";
						break;
			case 3:
						table="area_ywsl";
						break;
			case 4:
						table="asys_area";
						break;
			 }
			return table;
  	}
  		/**
		 * 获取标题
		 * @param str
		 * @return String
		 */
  		function getTitle(str){
				var h="";
				switch(tabStatus){
					case 1: h="<fmt:message key='areass1.title'/>"+str; break;
					case 2: h="<fmt:message key='areass2.title'/>"+str; break;
					case 3: h="<fmt:message key='areass3.title'/>"+str; break;
					case 4: h="<fmt:message key='areass4.title'/>"+str; break;
					
				}	
				
				return h;
			}
		/**
		 * 获取id
		 * @param 无参数
		 * @return String
		 */
		function getId(){
			var id="";
				switch(tabStatus)
		{
			case 1:
				id="ID";
				break;
			case 2:
				id="ID";
				break;
			case 3:
				id="Xuhao";
				break;
			case 4:
				id="Xuhao";
				break;
			
			
		}		
		return id;
	}
			/**
			 * 写日志
			 * @param status(状态)
			 * @param content(内容)
			 * @return 无返回值
			 */
			function logwrite(status,content){
					var table="";
					switch(tabStatus){
					case 1:
						table="(MokuaiJu)";
						break;
					case 2:
						table="(mokuaiju2)";
						break;
					case 3:
						table="(Area_Ywsl)";
						break;
					case 4:
						table="(Asys_Area)";
						break;
					
					}
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
			}
			//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
			}
			
		      //下载excel		 
			 function exportdata(){			 
			 var table=getTable();
			 thisDownLoad('tsdBilling','mssql',table,$("#languageType").val());
			 $("#query2").click(function(){
			 	getTheCheckedFields('tsdBilling','mssql',table);
			 });
			
  			
			 }
		</script>
						 <script type="text/javascript">    
				/**
				 * 拼接要显示的数据列main.js中有关导出数据的函数是  thisDataDownload,checkedAllFields,getTheCheckedFields,
				 * @param tablename(表名)
				 * @return String
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
											var disvalue = thefieldname + ' as ' + tsd.encodeURIComponent(thefieldalias);
											 if(tabStatus==2){
												disvalue = disvalue.replace(new RegExp('IsUse',"g"),"case when IsUse='1' then '是' when IsUse='0' then '否' else ' ' end  ");		
												
												}
											thearr.push(disvalue);
										}
								 });
							 }
						 });
					return thearr;
				}
				
				
	</script>
		<script>
	/**
	 * 打开简单查询面板
	 * @param 无参数
	 * @return 无返回值
	 */
	function openQuery(){
		 	$(".top_03").html('<fmt:message key="global.query" />');//标题	//清空表单数据
			$("#iMokuaiJu").val("");$("#iBz").val("");$("#iMokuaiJu22").val("");$("#iMokuaiJu222").val("");
			$("#iIsUse22").val("");$("#iBz22").val("");	$("#iArea").val("");$("#iYwArea").val("");
			markTable(1);	
  			openpan();
  			$("#jdquery"+tabStatus).show();
			$("#tdiv"+tabStatus+" select").removeAttr("disabled"); 
  		 	$("#tdiv"+tabStatus+" input[type='text']").removeAttr("disabled"); 
  		 	$("#tdiv"+tabStatus+" input[type='text']").removeClass();	$("#tdiv"+tabStatus+" input[type='text']").addClass("textclass");
  			
	}
/**
 * 通过表单值构造数据操作参数 请根据业务参数的多少和属性进行修改  @oper 操作类型 modify|save
 * @param 无参数
 * @return 无返回值
 */
function QbuildParams(){
	var paramsStr='1=1 ';
	 	 switch(tabStatus){
    case 1:
		  		var MokuaiJu=$("#iMokuaiJu").val();		  		
		  		if(MokuaiJu!=null&&MokuaiJu!=""){
		  			paramsStr+="and MokuaiJu like '%"+MokuaiJu+"%' ";
		  		}
		  		var Bz=$("#iBz").val();	
		  		if(Bz!=null&&Bz!=""){
		  			paramsStr+="and Bz like '%"+Bz+"%' ";
		  		}
				break;
case 2: 	
		  		var MokuaiJu2=$("#iMokuaiJu22").val();		  		
		  		if(MokuaiJu2!=null&&MokuaiJu2!=""){
		  		paramsStr+="and MokuaiJu like '%"+MokuaiJu2+"%' ";
		  		}
		  		var MokuaiJu=$("#iMokuaiJu222").val();	
		  		if(MokuaiJu!=null&&MokuaiJu!=""){
		  		paramsStr+="and MokuaiJu2 like '%"+MokuaiJu+"%' ";
		  		}		  	
		  		var IsUse=$("#iIsUse22 option[selected]").text();		  		
		  		if(IsUse!=null&&IsUse!=""){
		  		paramsStr+="and IsUse like '%"+IsUse+"%' ";
		  		}
		  		var Bz=$("#iBz22").val();		  		
		  		if(Bz!=null&&Bz!=""){
		  		paramsStr+="and Bz like '%"+Bz+"%' ";
		  		}
		  		if(MokuaiJu2!=""&&subStrsql(MokuaiJu2,50)==1){	 alert("\""+$("#MokuaiJu222").val()+"\"字符串的字节数不能大于"+50+",\n注：汉字表示两个字节,\n其他的如英文表示一个字节"); return false; 	}
		  		if(Bz!=""&&subStrsql(Bz,50)==1){	 alert("\""+$("#Bz22").html()+"\"字符串的字节数不能大于"+50+",\n注：汉字表示两个字节,\n其他的如英文表示一个字节"); return false; 	}
		  		 
				break;
case 3: 
				
		  		var YwArea=$("#iYwArea").val();		  		
		  		if(YwArea!=null&&YwArea!=""){
		  		paramsStr+="and YwArea like '%"+YwArea+"%' ";
		  		}
		  		break;
case 4:					
		  		var Area=$("#iArea").val();	
		  		if(Area!=null&&Area!=""){
		  		paramsStr+="and Area like '%"+Area+"%' ";
		  		}
				break;

}////switch end	
	 		 	
	 	$("#fusearchsql").val(paramsStr);
	 	fuheQuery();		
}

/**
 * 初始化业务区域下拉选
 * @param 无参数
 * @return 无返回值
 */
function setywarea(){

		var urlstr=tsd.buildParams({ 	
	 		 		packgname:'service',
				 	clsname:'ExecuteSql',
				 	method:'exeSqlData',
				 	ds:'tsdBilling',
				 	tsdoper:'query',
				 	datatype:'xmlattr',
				 	tsdpk:'areas4.query_ywarea'
		});		
		$.ajax({
					url:'mainServlet.html?'+urlstr,
					datatype:'xml',
					cache:false,
					timeout: 3000,
					async: false ,
					success:function(xml){
						$(xml).find('row').each(function(){
							var xuhao = $(this).attr("xuhao");
							var ywarea = $(this).attr("ywarea");
							document.getElementById('yw_area').options.add( new Option( ywarea, xuhao) );
						});
					}
		});
}


 /**
 * 打开保存本次查询面板
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @return 
 */	
function openSaveModPan(){
		openModT(getTable());					
}
	
	</script>
		 </head>
<style type="text/css"> 
 .style1 {
	background-color:#A9C3E8;
	padding: 4px;		
	}
</style>
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
  	
  		
		
		
		
		
	<div id="zong">
		<!-- 用户操作标题以及放一些快捷按钮-->		
		<div id="buttons" style="text-align:left;">
			<button type="button" id="order" onclick="openwinO();" style="20%; float:left;">
				<!--组合排序--><fmt:message key="order.title" />
			</button>	
			<button type="button" id="openadd" onclick="openadd();"  disabled="disabled" >
				<!-- 新增 --><fmt:message key="global.add" />
		    </button>
		    <button type="button" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>	   
			<button onclick='openQueryM(getTable());' ><fmt:message key="oper.mod"/></button>
		   <button type="button" id='gjquery1' onclick="openDiaQueryG('query',getTable());" disabled="disabled">
				<!--高级查询-->	<fmt:message key="oper.queryA"/>
			</button>		
			<button type="button" id='savequery1' onclick="openSaveModPan();"  disabled="disabled">
				<!-- 将本查询保存为模板  --> <fmt:message key="oper.modSave"/>
			</button>		   
			
			<button type="button" id="export" onclick="exportdata();" disabled="disabled"> 
				<!--导出--><fmt:message key="global.exportdata" />
			</button>
	</div>	
   <!-- Tabs -->
	<div id="tabs" style="text-align:left;">	
		<ul>
			<li><a href="#gridd" onclick="tabsChg(1)"><span><fmt:message key='areass1.title' /></span></a></li>
			<li><a href="#gridd" onclick="tabsChg(2)"><span><fmt:message key='areass2.title' /></span></a></li>
			<li><a href="#gridd" onclick="tabsChg(3)"><span><fmt:message key='areass3.title' /></span></a></li>
			<li><a href="#gridd" onclick="tabsChg(4)"><span><fmt:message key='areass4.title' /></span></a></li>
			
			
		</ul>
		<div id="gridd" style="text-align:left;">
		    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
		</div>		
	</div>
	
	<!-- 用户操作标题以及放一些快捷按钮-->		
		<div id="buttons" style="text-align:left;">
			<button type="button" id="order" onclick="openwinO();" style="20%; float:left;">
				<!--组合排序--><fmt:message key="order.title" />
			</button>		
			<button type="button" id="openaddf" onclick="openadd();"  disabled="disabled">
				<!-- 新增 --><fmt:message key="global.add" />
		    </button>	   
		    <button type="button" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>
			<button onclick='openQueryM(getTable());'><fmt:message key="oper.mod"/></button>
		   <button type="button" id='gjquery2' onclick="openDiaQueryG('query',getTable());" disabled="disabled">
				<!--高级查询-->	<fmt:message key="oper.queryA"/>
			</button>	
			<button type="button" id='savequery2' onclick="openSaveModPan();"  disabled="disabled">
				<!-- 将本查询保存为模板  --> <fmt:message key="oper.modSave"/>
			</button>		   
						
			<button type="button" id="exportf" onclick="exportdata();" disabled="disabled"> 
			<!--导出--><fmt:message key="global.exportdata" />
			</button>
	</div>	
</div>
		<!--第一页为模块局设置 -->
		<div class="neirong" id="pan1" style="display: none">
<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" >项目名称</div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;">关闭</span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>

		<div class="midd" >
			<table width="100%"  border="0" id="tdiv1" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
		  <tr>
		    <td width="12%" align="right" class="labelclass"><label id="lMokuaiJu" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iMokuaiJu" class="textclass" maxlength="50"  /><label class="addred" ></label></td>
		    <td width="12%" align="right"  class="labelclass"><label id="Bz" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iBz"    class="textclass" maxlength="50"  /></td>
		    <td width="12%" align="right"  class="labelclass"></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		   
		    </td>
		  </tr>
		
		
		</table>
		
		 <div class="midd_butt">
		 	<!-- 查询     --><button class="tsdbutton" id="jdquery1" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
			<!-- 保存新增 --><button class="tsdbutton" id="save1" style="width:80px;heigth:27px;" onclick="save(1)" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
		 	 <!-- 保存退出 --><button class="tsdbutton" id="save11" style="width:80px;heigth:27px;" onclick="save(2)" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
			<!-- 修改 --><button class="tsdbutton" id="modify1" style="width:63px;heigth:27px;" onclick="modify()" ><fmt:message key="global.edit" /></button>		    
		      <!-- 取消--><button class="tsdbutton" id="reset1" style="width:63px;heigth:27px;" onclick="resett()" >取消</button>
		   <!-- 关闭 --><button class="tsdbutton"  id="close1" style="width:63px;heigth:27px;" onclick="closeo()" ><fmt:message key="global.close" /></button>
			</div>	
		  </div>
		</div>
		
		
		<!-- 第二页模块局地区设置 -->
			<div class="neirong" id="pan2" style="display: none">
<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" >项目名称</div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;">关闭</span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>

		<div class="midd" >
			<table width="100%" border="0" id="tdiv2" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
		  <tr>
		    <td width="12%" align="right" class="labelclass"><label id="lMokuaiJu222" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iMokuaiJu222" class="textclass" maxlength="50"  /><label class="addred" ></label></td>
		    <td width="12%" align="right"  class="labelclass"><label id="MokuaiJu22" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    <select  name="iMokuaiJu22" id="iMokuaiJu22" class="textclass">
							<option value="">--<fmt:message key='global.select'/>--</option>
			</select><input type="text" id="imokuaiju"/>
							</td>
		    <td width="12%" align="right"  class="labelclass"><label id="IsUse22" ></label></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		   <select name="iIsUse22" id="iIsUse22" class="textclass">
							<option value="0"><fmt:message key='dangan.n'/></option>
							<option value="1"><fmt:message key='dangan.y'/></option>
							</select><input type="text" id="iIsUse222"/>
		    </td>
		  </tr>
		    <tr>
		    <td width="12%" align="right" class="labelclass"><label id="Bz22" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iBz22" class="textclass" maxlength="50"  /></td>
		    <td width="12%" align="right"  class="labelclass"></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
							</td>
		    <td width="12%" align="right"  class="labelclass"></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		  
		    </td>
		  </tr>
		
		
		</table>
		
		 <div class="midd_butt">
		 	<!-- 查询     --><button class="tsdbutton" id="jdquery2" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
			<!-- 保存新增 --><button class="tsdbutton" id="save2" style="width:80px;heigth:27px;" onclick="save(1)" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
		 	 <!-- 保存退出 --><button class="tsdbutton" id="save21" style="width:80px;heigth:27px;" onclick="save(2)" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
			<!-- 修改 --><button class="tsdbutton" id="modify2" style="width:63px;heigth:27px;" onclick="modify()" ><fmt:message key="global.edit" /></button>		    
		      <!-- 取消--><button class="tsdbutton" id="reset2" style="width:63px;heigth:27px;" onclick="resett()" >取消</button>
		   <!-- 关闭 --><button class="tsdbutton"  id="close2" style="width:63px;heigth:27px;" onclick="closeo()" ><fmt:message key="global.close" /></button>
			</div>	
		  </div>
		</div>
		
		
		
			<!-- 第三页为业务区域设置-->
				<div class="neirong" id="pan3" style="display: none">
<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" >项目名称</div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;">关闭</span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>

		<div class="midd" >
			<table width="100%"  id="tdiv3" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
		  <tr>
		    <td width="12%" align="right" class="labelclass"><label id="lYwArea" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iYwArea" class="textclass" maxlength="20"  /><label class="addred" ></label></td>
		    <td width="12%" align="right"  class="labelclass"></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
		    <td width="12%" align="right"  class="labelclass"></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    </td>
		  </tr>
		</table>
		
		 <div class="midd_butt">
		 	<!-- 查询     --><button class="tsdbutton" id="jdquery3" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
			<!-- 保存新增 --><button class="tsdbutton" id="save3" style="width:80px;heigth:27px;" onclick="save(1)" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
		 	 <!-- 保存退出 --><button class="tsdbutton" id="save31" style="width:80px;heigth:27px;" onclick="save(2)" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
			<!-- 修改 --><button class="tsdbutton" id="modify3" style="width:63px;heigth:27px;" onclick="modify()" ><fmt:message key="global.edit" /></button>		    
		      <!-- 取消--><button class="tsdbutton" id="reset3" style="width:63px;heigth:27px;" onclick="resett()" >取消</button>
		   <!-- 关闭 --><button class="tsdbutton"  id="close3" style="width:63px;heigth:27px;" onclick="closeo()" ><fmt:message key="global.close" /></button>
			</div>	
		  </div>
		</div>
		
		
	
	<!--第四页为营收区域设置。  -->
			<div class="neirong" id="pan4" style="display: none">
<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" >项目名称</div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;">关闭</span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>

		<div class="midd" >
			<table width="100%" id="tdiv4" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
		  <tr>
		    <td width="12%" align="right" class="labelclass"><label id="lArea" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iArea" class="textclass" maxlength="50"  /><label class="addred" ></label></td>
		    <td width="12%" align="right"  class="labelclass"><label id="YWAREA" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><select id='yw_area' class="textclass"></select><label class="addred" ></label></td>
		    <td width="12%" align="right"  class="labelclass"></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    </td>
		  </tr>
		</table>
		
		 <div class="midd_butt">
		 	<!-- 查询     --><button class="tsdbutton" id="jdquery4" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
			<!-- 保存新增 --><button class="tsdbutton" id="save4" style="width:80px;heigth:27px;" onclick="save(1)" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
		 	 <!-- 保存退出 --><button class="tsdbutton" id="save41" style="width:80px;heigth:27px;" onclick="save(2)" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
			<!-- 修改 --><button class="tsdbutton" id="modify4" style="width:63px;heigth:27px;" onclick="modify()" ><fmt:message key="global.edit" /></button>		    
		      <!-- 取消--><button class="tsdbutton" id="reset4" style="width:63px;heigth:27px;" onclick="resett()" >取消</button>
		   <!-- 关闭 --><button class="tsdbutton" id="close4" style="width:63px;heigth:27px;" onclick="closeo()" ><fmt:message key="global.close" /></button>
			</div>	
		  </div>
		</div>
		
	
			<!-- 可编辑字段的列表 -->	
			<div class="neirong" id="thefieldsform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img 

src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">选择您要导出的数据字段

</div>
								<div class="top_04"><img 

src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" 

onclick="javascript:$('#closethisinfo').click();">关闭</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd" >
					   <form action="#" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<div id="thelistform" style="margin-left: 10px;max-height: 200px;overflow-y: auto;overflow-x: hidden;">
								
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
					<button type="submit" class="tsdbutton" id="query2" >
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
		<!-- 保存 --><button class="tsdbutton" id="saveModB" style="width:80px;heigth:27px;" onclick="saveModQuery(getTable());" ><fmt:message key="global.save" /></button>
	 	<!-- 关闭 --><button class="tsdbutton" id="closeModB" style="width:63px;heigth:27px;" onclick="closeoMod();" ><fmt:message key="global.close" /></button>
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
				
					<input type="hidden" id="userid" value="<%=userid %>"/>
					<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 
					<!-- 权限 -->
					<input type="hidden" id="addright"/>	
					<input type="hidden" id="addBright"/>			
					<input type="hidden" id="deleteright"/>
					<input type="hidden" id="delBright"/>
					<input type="hidden" id="editright"/>								
					<input type="hidden" id="exportright" />
					<input type="hidden" id="printright" />	
					<input type="hidden" id="editfield1"/>	
					<input type="hidden" id="editfield2"/>	
					<input type="hidden" id="editfield3"/>	
					<input type="hidden" id="editfield4"/>		
										
					
					<!-- 国际化保存表字段名 -->	
					<input type="hidden" id="id" />					
					<input type="hidden" id="MokuaiJu"/>	
					<input type="hidden" id="MokuaiJu222"/>
					<input type="hidden" id="YwArea"/>	
					<input type="hidden" id="Area"/>	
					<input type="hidden" id="YArea"/>	
					
						<!-- /****日志*** -->	
					<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>'/> 
				   <input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
				   <input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 			  
				    <input type='hidden' id='oldh'  /> 				   	
				    <input type='hidden' id='areah'  />
				    <input type="hidden" id="addh"/>
				    <input type="hidden" id="edith"/>
				    <!-- 日志修改操作时，保存旧数据 -->	
				   	<!-- 模块局数据 -->						
					<input type="hidden" id="YwAreaoh"/>	
					<input type="hidden" id="Xuhaooh"/>	
					<input type="hidden" id="MokuaiJuoh"/>
					<input type="hidden" id="Bzoh"/>
					<!--模块局地区设置  -->
					<input type="hidden" id="Dh"/>	
					<input type="hidden" id="Dhoh"/>
					<!-- 第二页为模块局地区设置 -->
					<input type="hidden" id="MokuaiJu222oh"/>
					<input type="hidden" id="IsUse22oh"/>
					<input type="hidden" id="MokuaiJu22oh"/>
					<input type="hidden" id="Bz22oh"/>
					<!--  第四页为营收区域设置。-->
					<input type="hidden" id="Areaoh"/>
					<input type="hidden" id="whickOper"/>
					<input type="hidden" id="ziduans1"/>	
					<input type="hidden" id="ziduans2"/>	
					<input type="hidden" id="ziduans3"/>	
					<input type="hidden" id="ziduans4"/>
					
					
				   		 
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