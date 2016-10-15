<%----------------------------------------
	name: attribute.jsp
	author: fulingqiao
	version: 1.0, 2009-11-20
	description: 对宽带档案管理进行操作
	modify: 
		2009-11-24 youhongyu 
		2010-12-21 youhongyu   修改本查询为模板功能，使其能区分本次要保存的查询内容是来自哪个表
		2012-02-09 youhongyu   调整第一个分项卡和第二个分项卡位置
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
	
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>rates management</title>
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
				 var urlstr=buildParamsPro("attribute.getPower","query");
				
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
				var editfield5 = '';
				var editfield6 = '';
				
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
							editfield5 += getCaption(spowerarr[i],'editfields5','');
							editfield6 += getCaption(spowerarr[i],'editfields6','');
							
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
						
						editfield1 = getFields('yhxz');
						editfield2 = getFields('zlh');
						editfield3 = getFields('dhlx');
						editfield4 = getFields('dhgn');
						editfield5 = getFields('teltype');
						editfield6 = getFields('jhjid');
						
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
				$("#editfield5").val(editfield5);
				$("#editfield6").val(editfield6);
			}
		</script>
		<script type="text/javascript">
			var tabStatus=2;
	/**
	 * 向页面中写jgride标签
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
			case 5:
				tabStatus=5;
				break;
			case 6:
				tabStatus=6;
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
			/**********************
			**   取得当前用户的权限  *
			**********************/
		getUserPower();	
		var add = $("#addright").val();
		if(add=="true"){
				$("#openadd").removeAttr("disabled");	$("#openaddf").removeAttr("disabled");
			}
		 var exportright = $("#exportright").val();
		if(exportright=="true"){
				$("#export").removeAttr("disabled");	$("#exportf").removeAttr("disabled");
			}
		
			var queryright = $("#queryright").val();
			var saveQueryMright = $("#saveQueryMright").val();
			if(queryright=="true"){
					$("#gjquery1").removeAttr("disabled");	$("#gjquery2").removeAttr("disabled");
			}
			if(saveQueryMright=="true"){
				document.getElementById("savequery1").disabled=false;
				document.getElementById("savequery2").disabled=false;
			}
	
		$("#navBar1").append(genNavv());
		
		$("#tabs").tabs();
		setLable();
		fenyeUtil();
		
		
		getSelectVal('yhlb','yhlb',false);//获取下拉框的选项值
		getSelectVal('userfeetype','feetype',true);//获取下拉框的选项值
	});
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
											  tsdpk:'attribute'+tabStatus+'.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'attribute'+tabStatus+'.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
											});
		var col=[[],[]];
		//当分项卡为电话类型时只有删除和详细信息功能
		if(tabStatus == 3){
			col=getRb_Field(getTable(),getId(),"<fmt:message key='attribute.deletedetail' />",'97','ziduans'+tabStatus);;//得到jqGrid要显示的字段
		}else{
			col=getRb_Field(getTable(),getId(),"<fmt:message key='attribute.modifydeletedetail' />",'97','ziduans'+tabStatus);;//得到jqGrid要显示的字段
		}
	
		if(tabStatus=='6'){
		var ziduan=$("#ziduans"+tabStatus).val();
			ziduan = ziduan.replace(new RegExp('JhjName',"g"),"replace(JhjName,'&','&#38;') as JhjName");		
		  
		  tsd.QualifiedVal=true;
		  if(tsd.Qualified()==false){return false;}
		  ziduan=tsd.encodeURIComponent(ziduan);
		$("#ziduans"+tabStatus).val(ziduan);
		}
		
		var ziduan = $("#ziduans"+tabStatus).val();
		ziduan = ziduan.replace(/yhlb_id/,'yhlb');
		$("#ziduans"+tabStatus).val(ziduan);
		
		jQuery("#editgrid").jqGrid({	
				
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
				       	sortorder: 'desc',//默认排序方式 
				       	caption:getTitle(""), 
				       	shrinkToFit: false,
				       	height:document.documentElement.clientHeight-230, //高
				    	width:document.documentElement.clientWidth-45,
				       	loadComplete:function(){
										$("#editgrid").setSelection('0', true);
										$("#editgrid").focus();
										var editinfo = $("#editinfo").val();
										var deleteinfo = $("#deleteinfo").val();
										//当分项卡为电话类型时只有删除和详细信息功能
										if(tabStatus == 3){
												addRowOperBtnimage('editgrid','openDel',getId(),'click',1,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
												addRowOperBtnimage('editgrid','openInfo',getId(),'click',2,'style/images/public/ltubiao_03.gif',"<fmt:message key='attribute.detail' />","&nbsp;&nbsp;&nbsp;");//生成号码库
												executeAddBtn('editgrid',2);
										}else{
												addRowOperBtnimage('editgrid','openModify',getId(),'click',1,"style/images/public/ltubiao_01.gif",editinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
												addRowOperBtnimage('editgrid','openDel',getId(),'click',2,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
												addRowOperBtnimage('editgrid','openInfo',getId(),'click',3,'style/images/public/ltubiao_03.gif','<fmt:message key="attribute.detail" />',"&nbsp;&nbsp;&nbsp;");//生成号码库
												executeAddBtn('editgrid',3);
										}
										//var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered"+tabStatus).height()+$("#buttons").height()+$("#buttons").height()+$("#buttons").height();
										//setAutoGridHeight("editgrid",reduceHeight);
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
 * 拼接参数
 * @param 无参数
 * @return String(操作成功)/false(验证失败)
 */
function buildParam(){
	var operationtips = $("#operationtips").val();
	 //每次拼接参数必须添加此判断
	if(tsd.Qualified()==false){return false;}
    switch(tabStatus){
   		case 1:
           		tsd.QualifiedVal=true;  	
				var str="";	
		  		var Yhxz=$("#iYhxz1").val();		  		
		  		if(Yhxz!=null&&Yhxz!=""){
		  		str=str+"&Yhxz="+tsd.encodeURIComponent(strtrim(Yhxz));
		  		}else{
		  		str=str+"&Yhxz="+strtrim(Yhxz);
		  		}
		  		var Bz=$("#iBz1").val();
		  		if(Bz!=null&&Bz!=""){
		  		str=str+"&Bz="+tsd.encodeURIComponent(Bz);
		  		}else{	  		
		  		str=str+"&Bz="+Bz;
		  		}
		  		
		  		
		  		if(Yhxz==""){  	
		  			alert($("#Yhxz").val()+"<fmt:message key="global.notNull"/>");
		  			$("#iYhxz1").focus();	
		  			return false;
		  		}
		  		
		  		var yhlb = $('#yhlb').val();
				if(yhlb==''){
					alert('<fmt:message key="attribute.selectuserstyle" />!');
					$('#yhlb').focus();
					return false;
				}
		  		
		  		var userfeetype = $('#userfeetype').val();
				if(userfeetype==''){
					alert('<fmt:message key="attribute.selectuserfee" />!');
					$('#userfeetype').focus();
					return false;
				}
				
				str+="&yhlb="+tsd.encodeURIComponent(yhlb);
				str+="&userfeetype="+tsd.encodeURIComponent(userfeetype);
				
		  		//tsd.encodeURIComponent()
		  		
		  		//验证
		  		if(Yhxz!=""&&subStrsql(Yhxz,20)==1){	alert("\""+$("#Yhxz").val()+"\"<fmt:message key='attribute.charslittle' />"+20+",\n<fmt:message key='attribute.chinese' />,\n<fmt:message key='attribute.english' />"); return false; 	}
		  		if(Bz!=""&&subStrsql(Bz,20)==1){	alert("\""+$("#Bz1").html()+"\"<fmt:message key='attribute.charslittle' />"+20+",\n<fmt:message key='attribute.chinese' />,\n<fmt:message key='attribute.english' />"); return false; 	}
		  		///日志
		  		var info=$("#Yhxz").val()+":"+Yhxz+",";
		  		var info1=$("#Yhxz").val()+":"+$("#Yhxzoh").val()+" >>> "+Yhxz+",";
		  		info=info+$("#Bz1").html()+":"+Bz+" ";				
				info1=info1+$("#Bz1").html()+":"+$("#Bzoh").val()+" >>> "+Bz+" ";
				$("#addh").val(info);											
				$("#edith").val(info1);	
		  		return str;	
				break;
		case 2:
				tsd.QualifiedVal=true;  	
				var str="";	
		  		var Zlh=$("#iZlh2").val();		  		
		  		if(Zlh!=null&&Zlh!=""){
		  		str=str+"&yhlb="+tsd.encodeURIComponent(strtrim(Zlh));
		  		}else{
		  		str=str+"&yhlb="+strtrim(Zlh);
		  		}
		  		var ihthhead2=$("#iHthHead2").val();
		  		str=str+"&HthHead="+ihthhead2;
		  		var Bz=$("#iBz2").val();	
		  		if(Bz!=null&&Bz!=""){
		  		str=str+"&Bz="+tsd.encodeURIComponent(Bz);
		  		}else{	  		
		  		str=str+"&Bz="+Bz;
		  		}
		  		////验证
		  		if(Zlh==""){  	
		  			alert($("#Zlh").val()+"<fmt:message key="global.notNull"/>");
		  			return false;
		  		} 
		  		if(Zlh!=""&&subStrsql(Zlh,16)==1){	alert("\""+$("#Zlh").val()+"\"<fmt:message key='attribute.charslittle' />"+16+",\n<fmt:message key='attribute.chinese' />,\n<fmt:message key='attribute.english' />"); return false; 	}
		  		if(Bz!=""&&subStrsql(Bz,50)==1){	alert("\""+$("#Bz2").html()+"\"<fmt:message key='attribute.charslittle' />"+50+",\n<fmt:message key='attribute.chinese' />,\n<fmt:message key='attribute.english' />"); return false; 	}
		  		///日志
		  		var info=$("#Zlh").val()+":"+Zlh+",";
		  		var info1=$("#Zlh").val()+":"+$("#Zlhoh").val()+" >>> "+Zlh+",";
		  		info=info+$("#Bz2").html()+":"+Bz+" ";				
				info1=info1+$("#Bz2").html()+":"+$("#Bzoh").val()+" >>> "+Bz+" ";
				$("#addh").val(info);											
				$("#edith").val(info1);	
		  		return str;	
				break;
		case 3: 
				tsd.QualifiedVal=true;  	
				var str="";	
		  		var Bz=$("#ilxmc3").val();	
		  		if(Bz!=null&&Bz!=""){
		  		str=str+"&lxmc="+tsd.encodeURIComponent(Bz);
		  		}else{	  		
		  		str=str+"&lxmc="+Bz;
		  		}
		  		
		  		////验证
		  		if(Bz==""){  	
		  			alert($("#lxmc").val()+"<fmt:message key="global.notNull"/>");
		  			return false;
		  		}  
		  		if(Bz!=""&&subStrsql(Bz,50)==1){	alert("\""+$("#Bz3").html()+"\"<fmt:message key='attribute.charslittle' />"+50+",\n<fmt:message key='attribute.chinese' />,\n<fmt:message key='attribute.english' />"); return false; 	}
		  		///日志
		  		info=$("#lxmc").val()+":"+Bz+" ";				
				info1=$("#lxmc").val()+":"+$("#lxmcoh").val()+" >>> "+Bz+" ";
				$("#addh").val(info);											
				$("#edith").val(info1);	
		  		return str;	
				break;
case 4:				
				tsd.QualifiedVal=true;  	
				var str="";	
		  		var sCode=$("#isCode4").val();		  		
		  		if(sCode!=null&&sCode!=""){
		  		str=str+"&sCode="+tsd.encodeURIComponent(strtrim(sCode));
		  		}else{
		  		str=str+"&sCode="+strtrim(sCode);
		  		}
		  		var sName=$("#isName4").val();	
		  		if(sName!=null&&sName!=""){
		  		str=str+"&sName="+tsd.encodeURIComponent(sName);
		  		}else{	  		
		  		str=str+"&sName="+sName;
		  		}
		  		var YqCallType=$("#iYqCallType4").val();	
		  		if(YqCallType!=null&&YqCallType!=""){
		  		str=str+"&YqCallType="+tsd.encodeURIComponent(YqCallType);
		  		}else{	  		
		  		str=str+"&YqCallType="+YqCallType;
		  		}
		  		var Hwjb=$("#iHwjb4").val();	
		  		if(Hwjb!=null&&Hwjb!=""){
		  		str=str+"&Hwjb="+tsd.encodeURIComponent(Hwjb);
		  		}else{	  		
		  		str=str+"&Hwjb="+Hwjb;
		  		}
		  		////验证
		  		if(sCode==""){  	
		  			alert($("#sCode4").val()+"<fmt:message key="global.notNull"/>");
		  			return false;
		  		}  
		  		if(sCode!=""&&subStrsql(sCode,16)==1){	alert("\""+$("#sCode4").val()+"\"<fmt:message key='attribute.charslittle' />"+16+",\n<fmt:message key='attribute.chinese' />,\n<fmt:message key='attribute.english' />"); return false; 	}
		  		if(sName!=""&&subStrsql(sName,32)==1){	alert("\""+$("#sName4").html()+"\"<fmt:message key='attribute.charslittle' />"+32+",\n<fmt:message key='attribute.chinese' />,\n<fmt:message key='attribute.english' />"); return false; 	}
		  		if(YqCallType!=""&&subStrsql(YqCallType,200)==1){	alert("\""+$("#YqCallType4").html()+"\"<fmt:message key='attribute.charslittle' />"+200+",\n<fmt:message key='attribute.chinese' />,\n<fmt:message key='attribute.english' />"); return false; 	}
		  		if(Hwjb!=""&&subStrsql(Hwjb,10)==1){	alert("\""+$("#Hwjb4").html()+"\"<fmt:message key='attribute.charslittle' />"+10+",\n<fmt:message key='attribute.chinese' />,\n<fmt:message key='attribute.english' />"); return false; 	}
		  		///日志
		  		var info=$("#sCode4").val()+":"+sCode+" ";
		  		var info1=$("#sCode4").val()+":"+$("#sCodeoh").val()+"=>"+sCode+" ";
		  		info=info+$("#sName4").html()+":"+sName+" ";				
				info1=info1+$("#sName4").html()+":"+$("#sNameoh").val()+"=>"+sName+" ";
				info=info+$("#YqCallType4").html()+":"+YqCallType+" ";				
				info1=info1+$("#YqCallType4").html()+":"+$("#YqCallTypeoh").val()+"=>"+YqCallType+" ";
				info=info+$("#Hwjb4").html()+":"+Hwjb+" ";				
				info1=info1+$("#Hwjb4").html()+":"+$("#Hwjboh").val()+"=>"+Hwjb+" ";
				$("#addh").val(info);											
				$("#edith").val(info1);	
		  		return str;	
				break;
case 5:
				tsd.QualifiedVal=true;  	
				var str="";	
		  		var TypeNum=$("#iTypeNum5").val();		  		
		  		if(TypeNum!=null&&TypeNum!=""){
		  		str=str+"&TypeNum="+tsd.encodeURIComponent(strtrim(TypeNum));
		  		}else{
		  		str=str+"&TypeNum="+strtrim(TypeNum);
		  		}
		  		var TypeName=$("#iTypeName5").val();	
		  		if(TypeName!=null&&TypeName!=""){
		  		str=str+"&TypeName="+tsd.encodeURIComponent(TypeName);
		  		}else{	  		
		  		str=str+"&TypeName="+TypeName;
		  		}
		  		var Xuhao=$("#iXuhao5").val();	
		  		if(Xuhao!=null&&Xuhao!=""){
		  		str=str+"&Xuhao="+tsd.encodeURIComponent(Xuhao);
		  		}else{	  		
		  		str=str+"&Xuhao="+0;
		  		}
		  		var bz=$("#ibz5").val();	
		  		if(bz!=null&&bz!=""){
		  		str=str+"&bz="+tsd.encodeURIComponent(bz);
		  		}else{	  		
		  		str=str+"&bz="+bz;
		  		}
				
		  		////验证
		  		if(TypeNum==""){  	
		  			alert($("#TypeNum5").val()+"<fmt:message key="global.notNull"/>");
		  			return false;
		  		}
		  		if(TypeNum!=""&&subStrsql(TypeNum,10)==1){	alert("\""+$("#TypeNum5").val()+"\"<fmt:message key='attribute.charslittle' />"+10+",\n<fmt:message key='attribute.chinese' />,\n<fmt:message key='attribute.english' />"); return false; 	}
		  		if(TypeName!=""&&subStrsql(TypeName,50)==1){	alert("\""+$("#TypeName5").html()+"\"<fmt:message key='attribute.charslittle' />"+50+",\n<fmt:message key='attribute.chinese' />,\n<fmt:message key='attribute.english' />"); return false; 	}
		  		//if(subSmallint!=""&&subSmallint(Hm_Level)==0){ alert("\""+$("#Hm_Level13").html()+"\"<fmt:message key='attribute.notnumber' />");return false;}
	 		 	else if(Xuhao!=""&&subSmallint(Xuhao)==1){alert("\""+$("#Xuhao5").html()+"\"<fmt:message key='attribute.length' />[-32767,32768]<fmt:message key='attribute.range' />");return false;}
		
		  		///日志
		  		var info=$("#TypeNum5").val()+":"+TypeNum+" ";
		  		var info1=$("#TypeNum5").val()+":"+$("#TypeNumoh").val()+"=>"+TypeNum+" ";
		  		info=info+$("#TypeName5").html()+":"+TypeName+" ";				
				info1=info1+$("#TypeName5").html()+":"+$("#TypeNameoh").val()+"=>"+TypeName+" ";
				info=info+$("#Xuhao5").html()+":"+Xuhao+" ";				
				info1=info1+$("#Xuhao5").html()+":"+$("#Xuhaooh").val()+"=>"+Xuhao+" ";
				info=info+$("#bz5").html()+":"+bz+" ";				
				info1=info1+$("#bz5").html()+":"+$("#bzoh").val()+"=>"+bz+" ";
				$("#addh").val(info);											
				$("#edith").val(info1);	
		  		return str;	
				break;
case 6: 
				tsd.QualifiedVal=true;  	
				var str="";	
		  		var JhjID=$("#iJhjID6").val();	
		  		var info=$("#JhjID6").val()+":"+JhjID+" ";
		  		var info1=$("#JhjID6").val()+":"+$("#JhjIDoh").val()+"=>"+JhjID+" ";	  		
		  		if(JhjID!=null&&JhjID!=""){
		  		str=str+"&JhjID="+tsd.encodeURIComponent(strtrim(JhjID));
		  		}else{
		  		str=str+"&JhjID="+strtrim(JhjID);
		  		}
		  		var JhjName=$("#iJhjName6").val();
		  		info=info+$("#JhjName6").html()+":"+JhjName+" ";				
				info1=info1+$("#JhjName6").html()+":"+$("#JhjNameoh").val()+"=>"+JhjName+" ";	
		  		if(JhjName!=null&&JhjName!=""){
		  		str=str+"&JhjName="+tsd.encodeURIComponent(JhjName);
		  		}else{	  		
		  		str=str+"&JhjName="+JhjName;
		  		}
		  		var JhjArea=$("#iJhjArea6").val();	
		  		
				info=info+$("#JhjArea6").html()+":"+JhjArea+" ";				
				info1=info1+$("#JhjArea6").html()+":"+$("#JhjAreaoh").val()+"=>"+JhjArea+" ";
		  		if(JhjArea!=null&&JhjArea!=""){
		  		str=str+"&JhjArea="+tsd.encodeURIComponent(JhjArea);
		  		}else{	  		
		  		str=str+"&JhjArea="+JhjArea;
		  		}
		  		var Bz=$("#iBz6").val();
				info=info+$("#Bz6").html()+":"+Bz+" ";				
				info1=info1+$("#Bz6").html()+":"+$("#Bzoh").val()+"=>"+Bz+" ";
		  		if(Bz!=null&&Bz!=""){
		  		str=str+"&Bz="+tsd.encodeURIComponent(Bz);
		  		}else{	  		
		  		str=str+"&Bz="+Bz;
		  		}
		  		
		  		if(JhjID==""){  	
		  			alert($("#JhjID6").val()+"<fmt:message key="global.notNull"/>");
		  			return false;
		  		}
		  		if(subInt!=""&&subInt(JhjID)==0){ alert("\""+$("#JhjID6").val()+"\"<fmt:message key='attribute.notnumber' />");return false;}
	 		 	else if(JhjID!=""&&subInt(JhjID)==1){alert("\""+$("#JhjID6").val()+"\"<fmt:message key='attribute.length' />[-2147483648,2147483647]<fmt:message key='attribute.range' />");return false;}
				if(JhjName!=""&&subStrsql(JhjName,50)==1){	alert("\""+$("#JhjName6").html()+"\"<fmt:message key='attribute.charslittle' />"+50+",\n<fmt:message key='attribute.chinese' />,\n<fmt:message key='attribute.english' />"); return false; 	}
				if(JhjArea!=""&&subStrsql(JhjArea,50)==1){	alert("\""+$("#JhjArea6").html()+"\"<fmt:message key='attribute.charslittle' />"+50+",\n<fmt:message key='attribute.chinese' />,\n<fmt:message key='attribute.english' />"); return false; 	}
				if(Bz!=""&&subStrsql(Bz,50)==1){	alert("\""+$("#Bz6").html()+"\"<fmt:message key='attribute.charslittle' />"+50+",\n<fmt:message key='attribute.chinese' />,\n<fmt:message key='attribute.english' />"); return false; 	}
				
		  		$("#addh").val(info);											
				$("#edith").val(info1);	
		  		return str;	
				break;
	
	}////switch end	
	 //每次拼接参数必须添加此判断 
	if(tsd.Qualified()==false){return false;}	  		
}
/**
 * 重新加载jQuery
 * @param 无参数
 * @return 无返回值
 */
function querylist(){
				 var urlstr=tsd.buildParams({ packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'attribute'+tabStatus+'.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'attribute'+tabStatus+'.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
											});
			 	
			$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+"&ziduans="+$("#ziduans"+tabStatus).val()}).trigger("reloadGrid");
			 setTimeout($.unblockUI, 15);//关闭面板
			
}
/**
 * onblur事件，添加面板判断是否重复的。
 * @param 无参数
 * @return 无返回值
 */
function acblur(){ 
           		var name="";
           		var nasname="";
           		var flag=true;
				switch(tabStatus){
						case 1: 
							name=$("#Yhxz").val();
							nasname=$("#iYhxz1").val();
							break;
						case 2:
							name=$("#Zlh").val();
							nasname=$("#iZlh2").val();	
							break;
						case 3: 
							name=$("#lxmc").val();
							nasname=$("#ilxmc3").val();
							break;
						case 4:
							name=$("#sCode4").val();
							nasname=$("#isCode4").val();	
							break;
						case 5:
							name=$("#TypeNum5").val();
							nasname=$("#iTypeNum5").val();
							break;
						case 6:
							name=$("#JhjID6").val();
							nasname=$("#iJhjID6").val();	
							break;
				}////switch end		 
				         	            
	           	if(nasname!=null&&nasname!=""&&!isExistByA(strtrim(nasname))){
	           		var operationtips = $("#operationtips").val();
					alert(name+":"+nasname+" "+"<fmt:message key='accountM.alert.userExist'/>");
	           	 	flag=false;
	           	}
	            return flag;
}
/**
 * 判断一个模块局数据是否已经存在
 * @param ac
 * @return 无返回值
 */
function isExistByA(ac){

  		var flag=true;
  		tsd.QualifiedVal=true; 
  		if(ac!=null&&ac!=""){
  			ac=tsd.encodeURIComponent(ac);
  		}
  		if(tsd.Qualified()==false){return false;} 
  		var nasname="";
  		var urlstr=tsd.buildParams({        packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'tsdBilling',
						 					tsdcf:'mssql',
						 					tsdoper:'query',
						 					datatype:'xmlattr',				 	
											tsdpk:'attribute'+tabStatus+'.notin'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});	
					switch(tabStatus){
						case 1: 
								urlstr=urlstr+"&Yhxz="+ac;
								break;
						case 2:
								urlstr=urlstr+"&Zlh="+ac;
								break;
						case 3: 
								urlstr=urlstr+"&lxmc="+ac;
								break;
						case 4:
								urlstr=urlstr+"&sCode="+ac;
								break;
						case 5:
								urlstr=urlstr+"&TypeNum="+ac;
								break;
						case 6:
								urlstr=urlstr+"&JhjID="+ac;
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
								nasname=$(this).attr("idd");	
								break;
							case 3: 
								nasname=$(this).attr("id");
								break;
							case 4:
								nasname=$(this).attr("sname");	
								break;
							case 5:
								nasname=$(this).attr("typename");
								break;
							case 6:
								nasname=$(this).attr("jhjname");	
								break;
					}////switch end							
					if(nasname!=undefined) {
						flag=false;	
						return false;
					}																			
				});		
				
			}});	
			 //alert("isExistByA:flag="+flag);			
			return flag;
}
/**
 * 新增弹出的对话框
 * @param 无参数
 * @return 无返回值
 */
function openadd(){
		$("#tdiv"+tabStatus+" input[type='text']").attr("readonly","");
		$("#tdiv"+tabStatus+" input[type='text']").removeAttr("disabled");
		$("#tdiv"+tabStatus+" input[type='text']").removeClass();	
		$("#tdiv"+tabStatus+" input[type='text']").addClass("textclass");//所有input[type:text]类型的都去掉边框
		
	  	markTable(0);					
		clear();
		$(".top_03").html('<fmt:message key="global.add" />');//标题
  	    openpan();
		$("#save"+tabStatus).show();
		$("#save"+tabStatus+"1").show();
		$("#yhlb").removeAttr("disabled");
		$("#userfeetype").removeAttr("disabled","disabled");
		  		
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
			 * @param savestatus
			 * @return 无返回值
			 */
  		 function save(savestatus){
  		 	if(acblur()==false){return false;}
			var str=buildParam();
		  	if(str==false) return false;
										var urlstr=tsd.buildParams({packgname:'service',
								 					clsname:'ExecuteSql',
								 					method:'exeSqlData',
								 					ds:'tsdBilling',
								 					tsdcf:'mssql',
								 					tsdoper:'exe',				 	
													tsdpk:'attribute'+tabStatus+'.save'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
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
										
										alert(successful);
										var info=$("#addh").val();
										logwrite(1,info);
										if(savestatus==2){
											querylist();	
										}else{
										closeflash=true;//表示关闭时需要刷新
										////清空表单数据
										$("#iYhxz1").val("");$("#iBz1").val("");
										$("#iZlh2").val("");$("#iBz2").val("");
										$("#iid3").val("");$("#ilxmc3").val("");
										$("#isCode4").val("");$("#isName4").val("");$("#iYqCallType4").val("");$("#iHwjb4").val("");
										$("#iTypeNum5").val("");$("#iTypeName5").val("");$("#iXuhao5").val("");$("#ibz5").val("");
										$("#iJhjID6").val("");$("#iJhjName6").val("");$("#iJhjArea6").val("");$("#iBz6").val("");
										}		
								}
							}
						});
			}
/**
 * 删除
 * @param ID(唯一标识)
 * @return 无返回值
 */
function openDel(ID){   		 	
	var deleteright=$("#deleteright").val();
	/**************************
	*    是否有执行删除的权限    *
	*************************/
	if(deleteright=="true"){
		$("#id").val(ID);				
		var info=queryByAccount();
		var deleteinformation = $("#deleteinformation").val();
		var operationtips = $("#operationtips").val();
		
		if(confirm(deleteinformation,operationtips)){
			var urlstr=tsd.buildParams({packgname:'service',
								 					clsname:'ExecuteSql',
								 					method:'exeSqlData',
								 					ds:'tsdBilling',
								 					tsdcf:'mssql',
								 					tsdoper:'exe',				 	
													tsdpk:'attribute'+tabStatus+'.delByAccount'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										});
			urlstr=urlstr+"&"+getId()+"="+ID;
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
								
								alert(successful);
								var info=$("#addh").val();	
								logwrite(2,info);
								querylist();								
						}
					}
				});
		}
	}else{
		var operationtips = $("#operationtips").val();
		var deletepower = $("#deletepower").val();	
		alert(deletepower,operationtips);
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
										tsdpk:'attribute'+tabStatus+'.queryById'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});
			urlstr=urlstr+"&"+getId()+"="+ID;
		
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
	   			 var Yhxz=$(this).attr("yhxz");								
				$("#iYhxz1").val(Yhxz);
				var Bz=$(this).attr("bz");								
				$("#iBz1").val(Bz);
				
				var yhlb=$(this).attr("yhlb");								
				$("#yhlb").val(yhlb);
				
				var userfeetype=$(this).attr("userfeetype");								
				$("#userfeetype").val(userfeetype);
				
				////修改操作记录日志时，保存旧数据
				$("#Yhxzoh").val(Yhxz);
				$("#Bzoh").val(Bz);
				var info=$("#Yhxz").val()+":"+Yhxz+" "+$("#Bz1").html()+":"+Bz;								
				$("#addh").val(info);			
				break;
		case 2:
 				var Yhxz=$(this).attr("yhlb");								
				$("#iZlh2").val(Yhxz);
				var Bz=$(this).attr("bz");								
				$("#iBz2").val(Bz);
				var hthhead=$(this).attr("hthhead");
				$("#iHthHead2").val(hthhead);
				////修改操作记录日志时，保存旧数据
				$("#Yhxzoh").val(Yhxz);
				$("#Bzoh").val(Bz);
				$("#hthhead").val(hthhead);
				var info=$("#Zlh").val()+":"+Yhxz+" "+$("#Bz2").html()+":"+Bz;								
				$("#addh").val(info);			
				break;
				
		case 3: 		
				var Bz=$(this).attr("lxmc");								
				$("#ilxmc3").val(Bz);
				////修改操作记录日志时，保存旧数据
				$("#lxmcoh").val(Bz);
				var info=$("#lxmc").val()+":"+Bz;								
				$("#addh").val(info);			
				break;
		case 4:									
				$("#isCode4").val(ID);
				var sName=$(this).attr("sname");								
				$("#isName4").val(sName);
				var YqCallType=$(this).attr("yqcalltype");								
				$("#iYqCallType4").val(YqCallType);
				var Hwjb=$(this).attr("hwjb");								
				$("#iHwjb4").val(Hwjb);
				////修改操作记录日志时，保存旧数据
				$("#sCodeoh").val(ID);
				$("#sNameoh").val(sName);
				$("#YqCallTypeoh").val(YqCallType);
				$("#Hwjboh").val(Hwjb);
				var info=$("#sCode4").val()+":"+ID+" "+$("#sName4").html()+":"+sName+$("#YqCallType4").html()+":"+YqCallType+" "+$("#Hwjb4").html()+":"+Hwjb;								
				$("#addh").val(info);			
				break;
				
		case 5:								
				$("#iTypeNum5").val(ID);
				var TypeName=$(this).attr("typename");	
				$("#iTypeName5").val(TypeName);
				var Xuhao=$(this).attr("xuhao");								
				$("#iXuhao5").val(Xuhao);
				var bz=$(this).attr("bz");								
				$("#ibz5").val(bz);
				////修改操作记录日志时，保存旧数据
				$("#TypeNumoh").val(ID);
				$("#TypeNameoh").val(TypeName);
				$("#Xuhaooh").val(Xuhao);
				$("#Hwjboh").val(Hwjb);
				var info=$("#TypeNum5").val()+":"+ID+" "+$("#TypeName5").html()+":"+TypeName+$("#Xuhao5").html()+":"+Xuhao+" "+$("#bz5").html()+":"+bz;								
				$("#addh").val(info);			
				break;
				
		case 6: 							
				$("#iJhjID6").val(ID);
				var JhjName=$(this).attr("jhjname");											
				$("#iJhjName6").val(JhjName);
				var JhjArea=$(this).attr("jhjarea");								
				$("#iJhjArea6").val(JhjArea);
				var Bz=$(this).attr("bz");							
				$("#iBz6").val(Bz);
				////修改操作记录日志时，保存旧数据
				$("#JhjIDoh").val(ID);
				$("#JhjNameoh").val(JhjName);
				$("#JhjAreaoh").val(JhjArea);
				$("#Hwjboh").val(Hwjb);
				var info=$("#JhjID6").val()+":"+ID+" "+$("#JhjName6").html()+":"+JhjName+$("#JhjArea6").html()+":"+JhjArea+" "+$("#Bz6").html()+":"+Bz;								
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
					$(".top_03").html('<fmt:message key="attribute.detail" />');//标题
					$("#tdiv"+tabStatus+" input[type='text']").attr("disabled","disabled");
					$("#tdiv"+tabStatus+" input[type='text']").attr("readonly","readonly");
					$("#tdiv"+tabStatus+" input[type='text']").removeClass();	
					$("#tdiv"+tabStatus+" input[type='text']").addClass("textclass2");//所有input[type:text]类型的都去掉边框
					
			//把每个面板的第一个字段置为readonly
  			$("#iYhxz1").removeAttr("disabled");$("#iYhxz1").attr("readonly","readonly");
  			$("#yhlb").attr("disabled","disabled");
  			$("#userfeetype").attr("disabled","disabled");
  			
  			$("#iZlh2").removeAttr("disabled");$("#iZlh2").attr("readonly","readonly");
  			$("#ilxmc3").removeAttr("disabled");$("#ilxmc3").attr("readonly","readonly");
  			$("#isCode4").removeAttr("disabled");$("#isCode4").attr("readonly","readonly");
  			$("#iTypeNum5").removeAttr("disabled");$("#iTypeNum5").attr("readonly","readonly");
  			$("#iJhjID6").removeAttr("disabled");$("#iJhjID6").attr("readonly","readonly");
  			
	  				markTable(1);//显示红色*号
					var log=queryByAccount();
  					 openpan();  					 
  					$("#oldh").val(log);
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
					if(tabStatus==1||tabStatus==2||tabStatus==3){
	  				markTable(0);
	  				}else{
	  				markTable(1);
	  				}
	  				
					$(".top_03").html('<fmt:message key="global.edit" />');//标题  					
  					 var log=queryByAccount();
  					  openpan();
  					 $("#modify"+tabStatus).show();$("#reset"+tabStatus).show();
  					$("#oldh").val(log);
				  	 //置所有字段为不可修改
					var table=getTable();
					$("#tdiv"+tabStatus+" input[type='text']").attr("disabled","disabled");
					$("#tdiv"+tabStatus+" input[type='text']").removeClass();	
					$("#tdiv"+tabStatus+" input[type='text']").addClass("textclass2");
					var editfields = $("#editfield"+tabStatus).val();
					var fields = getFields(table);
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
													$('#i'+arr[i]+tabStatus).removeAttr("disabled");
													$('#i'+arr[i]+tabStatus).removeClass();
													$('#i'+arr[i]+tabStatus).addClass("textclass");	
													break;
											}
									}
							}
					}
					//把每个面板的第一个字段置为readonly
					if($("#iYhxz1").attr("disabled")){
		  				$("#iYhxz1").removeAttr("disabled");$("#iYhxz1").attr("readonly","readonly");
		  			}
		  			$("#yhlb").removeAttr("disabled");
		  			$("#userfeetype").removeAttr("disabled","disabled");
		  			
		  			if($("#iZlh2").attr("disabled")){
		  				$("#iZlh2").removeAttr("disabled");$("#iZlh2").attr("readonly","readonly");
		  			}
		  			if($("#ilxmc3").attr("disabled")){
		  				$("#ilxmc3").removeAttr("disabled");$("#ilxmc3").attr("readonly","readonly");
		  			}
		  			$("#isCode4").removeAttr("disabled");
		  			$("#iTypeNum5").removeAttr("disabled");
		  			$("#iJhjID6").removeAttr("disabled");
				  	 $("#isCode4").attr("readonly","readonly");
					$("#iTypeNum5").attr("readonly","readonly");
					$("#iJhjID6").attr("readonly","readonly");					
				  	 $("#isCode4").removeClass();$("#isCode4").addClass("textclass2");
					 $("#iTypeNum5").removeClass();$("#iTypeNum5").addClass("textclass2");
					  $("#iJhjID6").removeClass();$("#iJhjID6").addClass("textclass2");
  				}else{
						var operationtips = $("#operationtips").val();
						var editpower = $("#editpower").val();
						alert(editpower,operationtips);
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
				 if($("#iYhxz1").val()==$("#Yhxzoh").val()) ischange=false;
				 if((ischange!=false)&&!acblur()){return false;} //当关键字有改变时，验证唯一性 	
				 break;
			 case 2:
			  	if($("#iZlh2").val()==$("#Zlhoh").val()) ischange=false;
			  	if((ischange!=false)&&!acblur()){return false;} //当关键字有改变时，验证唯一性 	
			  	break;
			 case 3:
			  	if($("#ilxmc3").val()==$("#lxmcoh").val()) ischange=false;
			  	if((ischange!=false)&&!acblur()){return false;} //当关键字有改变时，验证唯一性 	
			  	break;
			 
			 }
			  			var str=buildParam();
			  			if(str==false) return false;
								var urlstr=tsd.buildParams({packgname:'service',
									 					clsname:'ExecuteSql',
									 					method:'exeSqlData',
									 					ds:'tsdBilling',
									 					tsdcf:'mssql',
									 					tsdoper:'exe',				 	
														tsdpk:'attribute'+tabStatus+'.updateByAccount'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											});
							urlstr=urlstr+"&"+getId()+"="+ID+str;
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
										
										alert(successful);
										var log=$("#edith").val();	
										logwrite(3,log);
										querylist();							
								
								}
							}});
			
  		 }
  		
                        
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
			/**
			 * 组合排序
			 * @param sqlstr(组合排序条件)
			 * @return 无返回值
			 */
			function zhOrderExe(sqlstr){
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
													  tsdpk:'attribute'+tabStatus+'.queryByOrder',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
													  tsdpkpagesql:'attribute'+tabStatus+'.queryByOrderpage'
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
													  tsdpk:'attribute'+tabStatus+'.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
													  tsdpkpagesql:'attribute'+tabStatus+'.fuheQueryByWherepage'
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
				document.getElementById("queryName").value="query";
				if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){ 
					window.showModalDialog("/tsd2009/queryServlet?tablename="+getTable()+"&url=/search.jsp",window,"dialogWidth:700px; dialogHeight:500px; center:yes; scroll:no");
			    }
			    else{
					window.showModalDialog("/tsd2009/queryServlet?tablename="+getTable()+"&url=/search.jsp",window,"dialogWidth:690px; dialogHeight:600px; center:yes; scroll:no");
				}
				
			}
             /**
			 * 复合查询参数获取
			 * @param 无参数
			 * @return 无返回值
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
			 * 选取标题 str是添加的内容
			 * @param str
			 * @return String
			 */
			function getTitle(str){
				var h="";
				switch(tabStatus){
					case 1: h="<fmt:message key='attribute1.title'/>"+str; break;
					case 2: h="<fmt:message key='attribute2.title'/>"+str; break;
					case 3: h="<fmt:message key='attribute3.title'/>"+str; break;
					case 4: h="<fmt:message key='attribute4.title'/>"+str; break;
					case 5: h="<fmt:message key='attribute5.title'/>"+str; break;
					case 6: h="<fmt:message key='attribute6.title'/>"+str; break;
				}	
				
				return h;
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
						table="(Yhxz)";
						break;
					case 2:
						table="(zlh)";
						break;
					case 3:
						table="(Dhlx)";
						break;
					case 4:
						table="(Dhgn)";
						break;
					case 5:
						table="(Teltype)";
						break;
					case 6:
						table="(jhjid)";
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
        	/**
			 * 打印
			 * @param 无参数
			 * @return 无返回值
			 */
     	function print(){
			var exportright =document.getElementById("printattributes"+tabStatus).value;
			exportright="true";
			if(exportright=="true"){	
				printThisReport("userManagement/tsdattributes"+tabStatus,getPriParams());			
				
			}else{
  				var operationtips = $("#operationtips").val();						
				alert("<fmt:message key="global.printright"/>");
  			}
		}
        	/**
			 * 验证价格
			 * @param str
			 * @param max
			 * @return String
			 */
		 function reJiage(str,max){ 
			 str= str.replace(/[^\d\.]/g,'');  
			var l=str.length;
			if(l>max) str=str.substr(0,max);
			if(isNaN(str)){str='';}	        		
		    return str;
                }	
                
     		/**
			 * 获取id
			 * @param 无参数
			 * @return String
			 */
		function getId(){
	var table="";
	switch(tabStatus)
		{
			case 1:
				table="ID";
				break;
			case 2:
				table="ID";
				break;
			case 3:
				table="id";
				break;
			case 4:
				table="sCode";
				break;
			case 5:
				table="TypeNum";
				break;
			case 6:
				table="JhjID";
				break;
		}	
	return table;	
	
	}
			/**
			 * 获取表名
			 * @param 无参数
			 * @return String
			 */
	function getTable(){
	var table="";
	switch(tabStatus)
		{
			case 1:
				table="yhxz";
				break;
			case 2:
				table="yhlb";
				break;
			case 3:
				table="dhlx";
				break;
			case 4:
				table="dhgn";
				break;
			case 5:
				table="teltype";
				break;
			case 6:
				table="jhjid";
				break;
		}	
		return table;	
	
	}
			/**
			 * 向lable中写字
			 * @param 无参数
			 * @return 无返回值
			 */
	function setLable(){
			var thisdata = loadData('Yhxz','<%=languageType %>',1);				
			var Bz=thisdata.getFieldAliasByFieldName('Bz');
			var ID=thisdata.getFieldAliasByFieldName('ID');
			var Yhxz=thisdata.getFieldAliasByFieldName('Yhxz');
			var Yhlb=thisdata.getFieldAliasByFieldName('yhlb_id');
			var UserFeetypes=thisdata.getFieldAliasByFieldName('userfeetype');
			
			$("#Bz1").html(Bz);
			$("#Yhxz1").html(Yhxz);
			$("#Yhlbs").html(Yhlb); 
			$("#UserFeetypes").html(UserFeetypes);
			
			$("#Yhxz").val(Yhxz);
			
			var thisdata = loadData('yhlb','<%=languageType %>',1);	
			var Bz=thisdata.getFieldAliasByFieldName('Bz');
			//var IDD=thisdata.getFieldAliasByFieldName('IDD');
			var hthhead=thisdata.getFieldAliasByFieldName('HthHead');
			var Zlh=thisdata.getFieldAliasByFieldName('Yhlb');
			
			$("#Bz2").html(Bz);
			$("#Zlh2").html(Zlh);
			$("#hthhead2").html(hthhead);
			$("#Zlh").val(Zlh);

			var thisdata = loadData('Dhlx','<%=languageType %>',1);
			var id=thisdata.getFieldAliasByFieldName('id');
			var lxmc=thisdata.getFieldAliasByFieldName('lxmc');
			$("#lxmc3").html(lxmc);
			$("#lxmc").val(lxmc);

				var thisdata = loadData('Dhgn','<%=languageType %>',1);	
			
			var Hwjb=thisdata.getFieldAliasByFieldName('Hwjb');
			var sCode=thisdata.getFieldAliasByFieldName('sCode');
			var sName=thisdata.getFieldAliasByFieldName('sName');
			var YqCallType=thisdata.getFieldAliasByFieldName('YqCallType');
			$("#sCode4").val(sCode);
			$("#lsCode4").html(sCode);
			$("#Hwjb4").html(Hwjb);
			$("#sName4").html(sName);
			$("#YqCallType4").html(YqCallType);

				var thisdata = loadData('Teltype','<%=languageType %>',1);	
			
			var bz=thisdata.getFieldAliasByFieldName('bz');
			var TypeName=thisdata.getFieldAliasByFieldName('TypeName');
			var TypeNum=thisdata.getFieldAliasByFieldName('TypeNum');
			var Xuhao=thisdata.getFieldAliasByFieldName('Xuhao');
			$("#TypeNum5").val(TypeNum);
			$("#lTypeNum5").html(TypeNum);
			$("#bz5").html(bz);
			$("#TypeName5").html(TypeName);
			$("#Xuhao5").html(Xuhao);

				var thisdata = loadData('jhjid','<%=languageType %>',1);
			var Bz=thisdata.getFieldAliasByFieldName('Bz');
			var JhjArea=thisdata.getFieldAliasByFieldName('JhjArea');
			var JhjID=thisdata.getFieldAliasByFieldName('JhjID');
			var JhjName=thisdata.getFieldAliasByFieldName('JhjName');
			$("#JhjID6").val(JhjID);
			$("#lJhjID6").html(JhjID);
			$("#Bz6").html(Bz);
			$("#JhjArea6").html(JhjArea);
			$("#JhjName6").html(JhjName);
	
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
			 $("#query2").click(function(){
			 	getTheCheckedFields('tsdBilling','mssql',getTable());
			 });
			
  			
			 }  
			/**
			 * 拼接要显示的数据列main.js中有关导出数据的函数是 thisDataDownload,checkedAllFields,getTheCheckedFields,
			 * @param tablename(表名)
			 * @return 数组
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
											thearr.push(disvalue);
										}
								 });
							 }
						 });
					return thearr;
				}
	/**
	 * 打开面板
	 * @param 无参数
	 * @return 无返回值
	 */			
	function openpan(){
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
	 * 清空数据
	 * @param 无参数
	 * @return 无返回值
	 */
  	function clear(){  	
  	//清空表单数据
		$("#iYhxz1").val("");$("#iBz1").val("");$('#yhlb').val('');$('#userfeetype').val('');
		$("#iZlh2").val("");$("#iBz2").val("");
		$("#iHthHead2").val("");
		$("#iid3").val("");$("#ilxmc3").val("");
	$("#isCode4").val("");$("#isName4").val("");$("#iYqCallType4").val("");$("#iHwjb4").val("");
		$("#iTypeNum5").val("");$("#iTypeName5").val("");$("#iXuhao5").val("");$("#ibz5").val("");
		$("#iJhjID6").val("");$("#iJhjName6").val("");$("#iJhjArea6").val("");$("#iBz6").val("");
  	}
  	
	</script>
		<script>
	/**
	 * 打开简单查询面板
	 * @param 无参数
	 * @return 无返回值
	 */
	function openQuery(){
		 	$(".top_03").html('<fmt:message key="global.query" />');//标题	
		 	markTable(1);
  			openpan();
  			clear();
  			$("#jdquery"+tabStatus).show();
			$("#tdiv"+tabStatus+" input[type='text']").removeAttr("disabled");
			$("#tdiv"+tabStatus+" input[type='text']").attr("readonly","");
			$("#tdiv"+tabStatus+" input[type='text']").removeClass();	$("#tdiv"+tabStatus+" input[type='text']").addClass("textclass");//所有input[type:text]类型的都去掉边框
		
	}
/**
 *  通过表单值构造数据操作参数 请根据业务参数的多少和属性进行修改 @oper 操作类型 modify|save
 * @param 无参数
 * @return 无返回值
 */
function QbuildParams(){	
	 	var paramsStr='1=1 ';
	 
	  switch(tabStatus){
   		case 1:
		  		var Yhxz=$("#iYhxz1").val();		  		
		  		if(Yhxz!=null&&Yhxz!=""){
		  		paramsStr+="and Yhxz like '%"+Yhxz+"%' ";
		  		}
		  		var Bz=$("#iBz1").val();
		  		if(Bz!=null&&Bz!=""){
		  			paramsStr+="and Bz like '%"+Bz+"%' ";
		  		}
		  		var yhlb=$("#yhlb").val();
		  		if(yhlb!=null&&yhlb!=""){
		  			paramsStr+="and yhlb like '%"+yhlb+"%' ";
		  		}
		  		var userfeetype=$("#userfeetype").val();
		  		if(userfeetype!=null&&userfeetype!=""){
		  			paramsStr+="and userfeetype like '%"+userfeetype+"%' ";
		  		}
		  		
				break;
		case 2:
				
		  		var Zlh=$("#iZlh2").val();		  		
		  		if(Zlh!=null&&Zlh!=""){
		  		paramsStr+="and yhlb like '%"+Zlh+"%' ";
		  		}
		  		var Bz=$("#iBz2").val();
		  		if(Bz!=null&&Bz!=""){	
		  		paramsStr+="and Bz like '%"+Bz+"%' ";
		  		}
				break;
		case 3: 	
		  		var lxmc=$("#ilxmc3").val();	
		  		if(lxmc!=null&&lxmc!=""){
		  		paramsStr+="and lxmc like '%"+lxmc+"%' ";
		  		}
				break;
		case 4:				
		  		var sCode=$("#isCode4").val();		  		
		  		if(sCode!=null&&sCode!=""){
		  		paramsStr+="and sCode like '%"+sCode+"%' ";
		  		}
		  		var sName=$("#isName4").val();	
		  		if(sName!=null&&sName!=""){
		  		paramsStr+="and sName like '%"+sName+"%' ";
		  		}
		  		var YqCallType=$("#iYqCallType4").val();	
		  		if(YqCallType!=null&&YqCallType!=""){
		  		paramsStr+="and YqCallType like '%"+YqCallType+"%' ";
		  		}
		  		var Hwjb=$("#iHwjb4").val();	
		  		if(Hwjb!=null&&Hwjb!=""){
		  		paramsStr+="and Hwjb like '%"+Hwjb+"%' ";
		  		}
				break;
		case 5:
		  		var TypeNum=$("#iTypeNum5").val();		  		
		  		if(TypeNum!=null&&TypeNum!=""){
		  		paramsStr+="and TypeNum like '%"+TypeNum+"%' ";
		  		}
		  		var TypeName=$("#iTypeName5").val();	
		  		if(TypeName!=null&&TypeName!=""){
		  		paramsStr+="and TypeName like '%"+TypeName+"%' ";
		  		}
		  		var Xuhao=$("#iXuhao5").val();	
		  		if(Xuhao!=null&&Xuhao!=""){
		  		paramsStr+="and Xuhao like '%"+Xuhao+"%' ";
		  		}
		  		var bz=$("#ibz5").val();	
		  		if(bz!=null&&bz!=""){
		  		paramsStr+="and bz like '%"+bz+"%' ";
		  		}
				break;
		case 6: 
				
		  		var JhjID=$("#iJhjID6").val();	  		
		  		if(JhjID!=null&&JhjID!=""){
		  		paramsStr+="and JhjID like '%"+JhjID+"%' ";
		  		}
		  		var JhjName=$("#iJhjName6").val();
		  		
		  		if(JhjName!=null&&JhjName!=""){
		  		paramsStr+="and JhjName like '%"+JhjName+"%' ";
		  		}
		  		var JhjArea=$("#iJhjArea6").val();	
		  		
		  		if(JhjArea!=null&&JhjArea!=""){
		  		paramsStr+="and JhjArea like '%"+JhjArea+"%' ";
		  		}
		  		var Bz=$("#iBz6").val();
		  		if(Bz!=null&&Bz!=""){
		  		paramsStr+="and Bz like '%"+Bz+"%' ";
		  		}
				break;
	
	}////switch end	
	 	$("#fusearchsql").val(paramsStr);
	 	fuheQuery();		
}
/**
 *  获取交换机相关信息
 * @param id
 * @param field
 * @param flag
 * @return 无返回值
 */
function getSelectVal(id,field,flag)
{
	var sql = 'attribut.getyhlb';
	if(flag==true){
		sql = 'attribut.getyhfeetype';
	}
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : sql//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?ian=1&' + urlstr, datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
        	var infos = '<option value=""><fmt:message key="attribute.choose" /></option>';
            $(xml).find('row').each(function ()
            {	
                var str = $(this).attr(field.toLowerCase());
            	if(str!='undefined'){
            		infos+= '<option value="'+str+'">'+str+'</option>';
            	}
            });
            $('#'+id).html(infos);
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
		<div id="buttons" style="text-align:left">
			<button type="button" id="order" onclick="openDiaO(getTable());" style="20%; float:left;">
				<!--组合排序--><fmt:message key="order.title" />
			</button>			
			<button type="button" id="openadd" onclick="openadd();" style="20%; float:left;" disabled="disabled">
				<!-- 新增 --><fmt:message key="global.add" />
		    </button>	
		    <button type="button" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>	   
			<button onclick='openQueryM(getTable());' ><fmt:message key="oper.mod"/></button>
		   <button type="button" id='gjquery1' onclick="openDiaQ('query',getTable());" disabled="disabled">
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
	<div id="tabs" style="text-align:left">	
		<ul>
			<li><a href="#gridd" onclick="tabsChg(2)"><span><fmt:message key='attribute2.title' /></span></a></li>
			<li><a href="#gridd" onclick="tabsChg(1)"><span><fmt:message key='attribute1.title' /></span></a></li>			
			<li><a href="#gridd" onclick="tabsChg(3)"><span><fmt:message key='attribute3.title' /></span></a></li>
			<li><a href="#gridd" onclick="tabsChg(4)"><span><fmt:message key='attribute4.title' /></span></a></li>
			<li><a href="#gridd" onclick="tabsChg(5)"><span><fmt:message key='attribute5.title' /></span></a></li>
			<li><a href="#gridd" onclick="tabsChg(6)"><span><fmt:message key='attribute6.title' /></span></a></li>
		</ul>
		<div id="gridd">
		    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
		</div>		
	</div>
	<!-- 用户操作标题以及放一些快捷按钮-->		
		<div id="buttons" style="text-align:left">
			<button type="button" id="order" onclick="openDiaO(getTable());" style="20%; float:left;">
				<!--组合排序--><fmt:message key="order.title" />
			</button>	
			
			<button type="button" id="openaddf" onclick="openadd();" style="20%; float:left;" disabled="disabled">
				<!-- 新增 --><fmt:message key="global.add" />
		    </button>	   
		    <button type="button" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>
			<button onclick='openQueryM(getTable());'><fmt:message key="oper.mod"/></button>
		   <button type="button" id='gjquery2' onclick="openDiaQ('query',getTable());" disabled="disabled">
				<!--高级查询-->	<fmt:message key="oper.queryA"/>
			</button>	
			<button type="button" id='savequery2' onclick="openSaveModPan();"  disabled="disabled">
				<!-- 将本查询保存为模板  --> <fmt:message key="oper.modSave"/>
			</button>		   
			<!--
				<button type="button" id="opende" onclick="openwinD();" >
					批量删除<fmt:message key="tariff.deleteb" />
				</button>
				 <button type="button" id="openmod" onclick="openwinM();" >
				批量修改<fmt:message key="tariff.modifyb" />
				</button>	
				<button type="button" id="print" onclick="print()">
				打印<fmt:message key="tariff.printer" />
				</button>	
			 -->	
			<button type="button" id="exportf" onclick="exportdata();" disabled="disabled"> 
			<!--导出--><fmt:message key="global.exportdata" />
			</button>			
	</div>	
</div>
	<!-- 用户性质  -->
	<div class="neirong" id="pan1" style="display: none;width: 600px">
<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="attribute.projectname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="attribute.close" /></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>

		<div class="midd" >
			<table width="100%" id="tdiv1" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
		  <tr>
		    <td width="12%" align="right" class="labelclass"><label id="Yhxz1" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iYhxz1" class="textclass" maxlength="20"  />
		    	<label class="addred" ></label></td>
		    <td width="12%" align="right"  class="labelclass"><label id="Yhlbs" ></label></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		   		<select id="yhlb" class="textclass"></select><label class="addred" ></label>
		   	</td>
		  </tr>
		  <tr>
		  	
	 <!--  <td width="12%" align="right"  class="labelclass"><label id="UserFeetypes" ></label></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		   		<select id="userfeetype" class="textclass"></select><label class="addred" ></label>
		    </td> -->	
		 	<td width="12%" align="right"  class="labelclass"><label id="Bz1" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iBz1"    class="textclass" maxlength="20"  /></td>
		    
		  </tr>
		
		</table>
		
		 <div class="midd_butt">
		 	<!-- 查询     --><button class="tsdbutton" id="jdquery1" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
			<!-- 保存新增 --><button class="tsdbutton" id="save1" style="width:80px;heigth:27px;" onclick="save(1)" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
		 	 <!-- 保存退出 --><button class="tsdbutton" id="save11" style="width:80px;heigth:27px;" onclick="save(2)" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
			<!-- 修改 --><button class="tsdbutton" id="modify1" style="width:63px;heigth:27px;" onclick="modify()" ><fmt:message key="global.edit" /></button>		    
		      <!-- 取消--><button class="tsdbutton" id="reset1" style="width:63px;heigth:27px;" onclick="resett()" ><fmt:message key="attribute.cancel" /></button>
		   <!-- 关闭 --><button class="tsdbutton"  id="close1" style="width:63px;heigth:27px;" onclick="closeo()" ><fmt:message key="global.close" /></button>
			</div>	
		  </div>
		</div>
		
	
		<!--用户类别  -->
			<div class="neirong" id="pan2" style="display: none">
<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="attribute.projectname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="attribute.close" /></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>

		<div class="midd" >
			<table width="100%" id="tdiv2" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
		  <tr>
		    <td width="12%" align="right" class="labelclass"><label id="Zlh2" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iZlh2" class="textclass" maxlength="16"  /><label class="addred" ></label></td>
		    <td width="12%" align="right"  class="labelclass"><label id="hthhead2" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iHthHead2"    class="textclass" maxlength="50"  /></td>
		    <td width="12%" align="right"  class="labelclass"><label id="Bz2" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iBz2"    class="textclass" maxlength="50"  /></td>
		    
		  </tr>
		
		
		</table>
		
		 <div class="midd_butt">
		 	<!-- 查询     --><button class="tsdbutton" id="jdquery2" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
			<!-- 保存新增 --><button class="tsdbutton" id="save2" style="width:80px;heigth:27px;" onclick="save(1)" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
		 	 <!-- 保存退出 --><button class="tsdbutton" id="save21" style="width:80px;heigth:27px;" onclick="save(2)" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
			<!-- 修改 --><button class="tsdbutton" id="modify2" style="width:63px;heigth:27px;" onclick="modify()" ><fmt:message key="global.edit" /></button>		    
		      <!-- 取消--><button class="tsdbutton" id="reset2" style="width:63px;heigth:27px;" onclick="resett()" ><fmt:message key="attribute.cancel" /></button>
		   <!-- 关闭 --><button class="tsdbutton"  id="close2" style="width:63px;heigth:27px;" onclick="closeo()" ><fmt:message key="global.close" /></button>
			</div>	
		  </div>
		</div>
		
		
	<!--  电话类型-->
		<div class="neirong" id="pan3" style="display: none">
<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="attribute.projectname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="attribute.close" /></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>

		<div class="midd" >
			<table width="100%" id="tdiv3" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
		  <tr>
		    <td width="12%" align="right" class="labelclass"><label id="lxmc3" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="ilxmc3" class="textclass" maxlength="50"  /><label class="addred" ></label></td>
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
		      <!-- 取消--><button class="tsdbutton" id="reset3" style="width:63px;heigth:27px;" onclick="resett()" ><fmt:message key="attribute.cancel" /></button>
		   <!-- 关闭 --><button class="tsdbutton"  id="close3" style="width:63px;heigth:27px;" onclick="closeo()" ><fmt:message key="global.close" /></button>
			</div>	
		  </div>
		</div>
		
		
	<!-- 电话功能 -->
		<div class="neirong" id="pan4" style="display: none">
<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="attribute.projectname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="attribute.close" /></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>

		<div class="midd" >
			<table width="100%" id="tdiv4" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
		  <tr>
		    <td width="12%" align="right" class="labelclass"><label id="lsCode4" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="isCode4" class="textclass" maxlength="50"  /><label class="addred" ></label></td>
		    <td width="12%" align="right"  class="labelclass"><label id="sName4" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="isName4" class="textclass" maxlength="32"  /></td>
		    <td width="12%" align="right"  class="labelclass"><label id="Hwjb4" ></label></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		   <input type="text" id="iHwjb4" class="textclass" maxlength="10"  />
		    </td>
		  </tr>
		   <tr>
		    <td colspan="6" align="left" bgcolor="#FFFFFF">
		    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		       <tr>
		    <td width="12%" align="right" style="background:#F0F7FB; border-bottom:1px solid #A9C8D9; padding-right:1%;"><label id="YqCallType4" ></label></td>
		    <td colspan="88" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iYqCallType4" class="textclass" maxlength="200"  /></td>
		        
		    </tr>
		    </table>
		    </td>
		    </tr>
		   <tr>
   
   
		 
		
		
		</table>
		
		 <div class="midd_butt">
		 	<!-- 查询     --><button class="tsdbutton" id="jdquery4" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
			<!-- 保存新增 --><button class="tsdbutton" id="save4" style="width:80px;heigth:27px;" onclick="save(1)" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
		 	 <!-- 保存退出 --><button class="tsdbutton" id="save41" style="width:80px;heigth:27px;" onclick="save(2)" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
			<!-- 修改 --><button class="tsdbutton" id="modify4" style="width:63px;heigth:27px;" onclick="modify()" ><fmt:message key="global.edit" /></button>		    
		      <!-- 取消--><button class="tsdbutton" id="reset4" style="width:63px;heigth:27px;" onclick="resett()" ><fmt:message key="attribute.cancel" /></button>
		   <!-- 关闭 --><button class="tsdbutton" id="close4" style="width:63px;heigth:27px;" onclick="closeo()" ><fmt:message key="global.close" /></button>
			</div>	
		  </div>
		</div>
		
	
	<!-- 话机类型 -->
		<div class="neirong" id="pan5" style="display: none">
<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="attribute.projectname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="attribute.close" /></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>

		<div class="midd" >
			<table width="100%" id="tdiv5" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
		  <tr>
		    <td width="12%" align="right" class="labelclass"><label id="lTypeNum5" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iTypeNum5" class="textclass" maxlength="10"  /><label class="addred" ></label></td>
		    <td width="12%" align="right"  class="labelclass"><label id="TypeName5" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iTypeName5" class="textclass" maxlength="50"  /></td>
		    <td width="12%" align="right"  class="labelclass"><label id="Xuhao5" ></label></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		   <input type="text" id="iXuhao5" class="textclass" maxlength="5" onkeypress="var k=event.keyCode;   return  k>=48&&k<=57"  style="ime-mode:disabled"/>
		    </td>
		  </tr>
		   <tr>
		    <td width="12%" align="right" class="labelclass"><label id="bz5" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" onkeypress="var k=event.keyCode;   return  (k==46)||(k>=48&&k<=57)"  id="ibz5" class="textclass" maxlength="50"  style="ime-mode:disabled"/></td>
		    <td width="12%" align="right"  class="labelclass"></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
		    <td width="12%" align="right"  class="labelclass"></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">		   
		    </td>
		  </tr>
		
		
		</table>
		
		 <div class="midd_butt">
		 	<!-- 查询     --><button class="tsdbutton" id="jdquery5" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
			<!-- 保存新增 --><button class="tsdbutton" id="save5" style="width:80px;heigth:27px;" onclick="save(1)" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
		 	 <!-- 保存退出 --><button class="tsdbutton" id="save51" style="width:80px;heigth:27px;" onclick="save(2)" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
			<!-- 修改 --><button class="tsdbutton" id="modify5" style="width:63px;heigth:27px;" onclick="modify()" ><fmt:message key="global.edit" /></button>		    
		      <!-- 取消--><button class="tsdbutton" id="reset5" style="width:63px;heigth:27px;" onclick="resett()" ><fmt:message key="attribute.cancel" /></button>
		   <!-- 关闭 --><button class="tsdbutton"  id="close5" style="width:63px;heigth:27px;" onclick="closeo()" ><fmt:message key="global.close" /></button>
			</div>	
		  </div>
		</div>
		
		
			<!-- 交换机类型 -->
				<div class="neirong" id="pan6" style="display: none">
<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="attribute.projectname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="attribute.close" /></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>

		<div class="midd" >
			<table width="100%" id="tdiv6" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
		  <tr>
		    <td width="12%" align="right" class="labelclass"><label id="lJhjID6" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iJhjID6" class="textclass" maxlength="10" onkeypress="var k=event.keyCode;   return  k>=48&&k<=57"  style="ime-mode:disabled"/><label class="addred" ></label></td>
		    <td width="12%" align="right"  class="labelclass"><label id="JhjName6" ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text" id="iJhjName6" class="textclass" maxlength="50"  /></td>
		    <td width="12%" align="right"  class="labelclass"><label id="JhjArea6" ></label></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		   <input type="text" id="iJhjArea6" class="textclass" maxlength="50"   />
		    </td>
		  </tr>
		   <tr>
		    <td width="12%" align="right" class="labelclass"><label id="Bz6" ></label></td>							
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"><input type="text"   id="iBz6" class="textclass" maxlength="50"  /></td>
		    <td width="12%" align="right"  class="labelclass"></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
		    <td width="12%" align="right"  class="labelclass"></td>
		    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">		   
		    </td>
		  </tr>
		
		
		</table>
		
		 <div class="midd_butt">
		 	<!-- 查询     --><button class="tsdbutton" id="jdquery6" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
			<!-- 保存新增 --><button class="tsdbutton" id="save6" style="width:80px;heigth:27px;" onclick="save(1)" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
		 	 <!-- 保存退出 --><button class="tsdbutton" id="save61" style="width:80px;heigth:27px;" onclick="save(2)" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
			<!-- 修改 --><button class="tsdbutton" id="modify6" style="width:63px;heigth:27px;" onclick="modify()" ><fmt:message key="global.edit" /></button>		    
		      <!-- 取消--><button class="tsdbutton" id="reset6" style="width:63px;heigth:27px;" onclick="resett()" ><fmt:message key="attribute.cancel" /></button>
		   <!-- 关闭 --><button class="tsdbutton" id="close6" style="width:63px;heigth:27px;" onclick="closeo()" ><fmt:message key="global.close" /></button>
			</div>	
		  </div>
		</div>
		
			
	
			<!-- 可编辑字段的列表 -->	
			<div class="neirong" id="thefieldsform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv"><fmt:message key="attribute.chooseexportdata" /></div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();"><fmt:message key="attribute.close" /></a></div>
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
						<fmt:message key="attribute.selectall" />
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
				<div class="top_03" ><fmt:message key="attribute.functionname" /></div>
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
					<input type="hidden" id="editfield5"/>	
					<input type="hidden" id="editfield6"/>	
						
					<!-- 国际化保存表字段名 -->	
					<input type="hidden" id="Yhxz" />					
					<input type="hidden" id="Zlh"/>
					<input type="hidden" id="lxmc" />					
					<input type="hidden" id="sCode4"/>	
					<input type="hidden" id="TypeNum5"/>	
					<input type="hidden" id="JhjID6"/>
					<input type="hidden" id="id"/>
					<!-- /****日志*** -->	
					<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>'/> 
				   	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' /> 
				  	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' /> 			  
				    <input type='hidden' id='oldh'  /> 
				    <input type="hidden" id="addh"/>
				    <input type="hidden" id="edith"/>
				    <!-- 日志修改操作时，保存旧数据 -->	
				   							
					<!-- 用户性质 -->		
					<input type="hidden" id="IDoh"/>	
					<input type="hidden" id="Yhxzoh"/>	
					<input type="hidden" id="Bzoh"/>		
					<!-- 用户类别 -->
					<input type="hidden" id="IDDoh"/>	
					<input type="hidden" id="Zlhoh"/>
					<input type="hidden" id="ihthhead"/>	
					<!-- 电话类型 -->
					<input type="hidden" id="idoh"/>	
					<input type="hidden" id="lxmcoh"/>	
					<!-- 电话功能 -->
					<input type="hidden" id="sCodeoh"/>	
					<input type="hidden" id="sNameoh"/>	
					<input type="hidden" id="YqCallTypeoh"/>	
					<input type="hidden" id="Hwjboh"/>
					<!-- 话机类型 --> 
					<input type="hidden" id="TypeNumoh"/>	
					<input type="hidden" id="TypeNameoh"/>	
					<input type="hidden" id="Xuhaooh"/>	
					<input type="hidden" id="bzoh"/>
					<!-- 交换机类型 --> 
					<input type="hidden" id="JhjIDoh"/>	
					<input type="hidden" id="JhjNameoh"/>	
					<input type="hidden" id="JhjAreaoh"/>
				   	
				   	<!-- 导航栏 -->	 
				   	<input type='hidden' id='theusergroupid'/> 
				   	<input type="hidden" id="ziduans1"/>	
				   	<input type="hidden" id="ziduans2"/>	
				   	<input type="hidden" id="ziduans3"/>	
				   	<input type="hidden" id="ziduans4"/>	
				   	<input type="hidden" id="ziduans5"/>	
				   	<input type="hidden" id="ziduans6"/>	
				   	
				   	
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