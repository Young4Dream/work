<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	String imenuid = request.getParameter("imenuid");
	String groupid = (String)session.getAttribute("groupid");
	String userid = (String)session.getAttribute("userid");
	String lanType = (String) session.getAttribute("languageType");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>综合业务-改号通知</title>
    
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />
	
	<!-- 导入的js文件 -->
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<!-- jQgrid 引用的JS -->
	<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
	<!-- 平台封装的JS -->
	<script src="script/public/mainStyle.js" type="text/javascript"></script>
	<script src="style/js/mainStyle.js" type="text/javascript"></script>
	<!-- 拖动模板需要引用的JS -->
	<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
	<!-- 弹出面板需要导入js文件 -->
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
	<!-- 关于字符串需要用到的js -->
	<script type="text/javascript" src="script/public/main.js"></script>
	<!-- 日期控件 -->
	<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
	<!-- 上传文件需要引用的js -->
	<script src="script/system/ajaxfileupload.js" type="text/javascript"></script>
	<!-- 收费结账专用js -->
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<!-- 导入css文件开始 -->
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
	.file-box {
		position: relative;
		width: 340px
	}
	
	.file {
		position: absolute;
		top: 0;
		right: 80px;
		height: 24px;
		filter: alpha(opacity :     0);
		opacity: 0;
		width: 260px
	}
	
	.file-box {
		position: relative;
		width: 340px
	}
	</style>
	<script type="text/javascript">
	$(function(){
		$('#navBar1').append(genNavv());//获取导航
		loadList();	
	});
	
	function loadList(){
		var urlstr=tsd.buildParams({ 	packgname:'service',//java包
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
				tsdcf:'mssql',//指向配置文件名称
				tsdoper:'query',//操作类型 
				datatype:'xml',//返回数据格式 
				tsdpk:'changeNum.list',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
				tsdpkpagesql:'changeNum.listPage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
		});
		jQuery("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr, 
				datatype: 'xml', 
				colNames:['操作','序号','原号码','新号码','开始通知日期','结束通知日期','创建人','创建日期','修改人','修改日期','备注'], 
				colModel:[{name:'viewOperation',index:'viewOperation',width:10},
						  {name:'id',index:'id',hidden:true,width:20},
						  {name:'oldnumber',index:'oldnumber',width:20},
						  {name:'newnumber',index:'newnumber',width:20},
						  {name:'starttime',index:'starttime',width:30},
						  {name:'stoptime',index:'stoptime',width:30},
						  {name:'crusr',index:'crusr',width:20},
						  {name:'crdt',index:'crdt',width:30},
						  {name:'mdusr',index:'mdusr',hidden:true,width:20},
						  {name:'mddt',index:'mddt',hidden:true,width:30},
						  {name:'note',index:'note',width:50},
						],
				rowNum:15, //默认分页行数
				rowList:[10,15,20], //可选分页行数
				imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				pager: jQuery("#pagered"), 
				sortname: "crdt", //默认排序字段
				viewrecords: true, 
				multiselect: true,
				multiboxonly:true,
				sortorder: 'desc',//默认排序方式
				caption:'信息列表',
				height:document.documentElement.clientHeight-140,
				width:document.documentElement.clientWidth-50,
				loadComplete:function(){
					var id=jQuery("#editgrid").getRowData(1)['id'];
					if(id == undefined){			
						$("#editgrid tr.jqgrow[id='1']").html("");		
						if($("#norecordspn").html() == null)
						{
							$("#editgrid").parent().append("</pre><center><div id='norecordspn' style='font-size: 30px;color: red;'><b>未查询到相匹配的信息！</b></div></center><pre>");								
						}
						$("#norecordspn").show();//如果不存在记录，则显示 提示信息
						return false;
					}else{//如果存在记录，则隐藏提示信息
						$("#norecordspn").hide();
					}
					addRowOperBtn('editgrid','<img src="style/images/public/ltubiao_01.gif" title="修改"/>','openUpdateFormForChangeNum','id','click',1,'oldnumber','newnumber','starttime','stoptime','crusr','crdt','mdusr','mddt','note');
					executeAddBtn('editgrid',1);
				}
		}).navGrid("#pagered", {edit: false, add: false, add: false, del: false, search: false}, //options 
			{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
			{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
			{reloadAfterSubmit:false}
		);
	}
	//弹出修改面板
	function openUpdateFormForChangeNum(id,oldnumber,newnumber,starttime,stoptime,crusr,crdt,mdusr,mddt,note){
		clearmodinfo();
		$("#titledivs").text("信息修改");
		//$("#createInfo").hide();
		//$("#modifyInfo").show();
		$("#hideSaveType").val(1);
		$("#hideSaveId").val(id);
		$("#txtAddOldNumForChangeNum").val(oldnumber);
		$("#txtAddNewNumForChangeNum").val(newnumber);
		$("#txtStarttimeForChangeNum").val(starttime);
		$("#txtStoptimeForChangeNum").val(stoptime);
		
		$("#txtCrusrForChangeNum").val(crusr);
		$("#txtCrdtForChangeNum").val(crdt);
		
		$("#txtMdusrForChangeNum").val(mdusr);
		$("#txtMddtForChangeNum").val(mddt);
		$("#txtAddNoteForChangeNum").val(note);
		
		$("#saveadd").hide();
		$("#modify").show();
		autoBlockForm('divAddOrUpdateForChangeNum',60,'closeForAddOrUpdateChangeNum',"#ffffff",false);//弹出新增或修改面板
	}
	//提交修改请求
	function modifyInfo(){
		if(checkOldNum()=='0'){
				var params=buildParam();
				if(params==false){return false;}
				var urlstr=tsd.buildParams({ 	
						packgname:'service',//java包
						clsname:'ExecuteSql',//类名
						method:'exeSqlData',//方法名
						ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						tsdcf:'mssql',//指向配置文件名称
						tsdoper:'exe',//操作类型 
						tsdpk:'changeNum.update'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
				});
				urlstr+=params;
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(msg){
						if(msg=="true"){
							alert("修改成功!");
							
							setTimeout($.unblockUI, 15);
							$("#editgrid").trigger("reloadGrid");
						}	
					}
				});
		}else{
			alert("该号码已经存在,请重新填写!");
			$('#txtAddOldNumForChangeNum').focus();
			return false;
		}
	}
	
	//弹出新增面板
	function openAddFormForChangeNum(){
		clearmodinfo();
		$("#titledivs").text("新增");
		//$("#createInfo").show();
		//$("#modifyInfo").hide();
		
		$("#txtCrusrForChangeNum").val($("#userid").val());
		
		$("#saveadd").show();
		$("#modify").hide();
		autoBlockForm('divAddOrUpdateForChangeNum',60,'closeForAddOrUpdateChangeNum',"#ffffff",false);//弹出新增或修改面板
	}
	//提交新增请求
	function saveInfo(){
		if(checkOldNum()=='0'){
				var params=buildParam();
				if(params==false){return false;}
				var urlstr=tsd.buildParams({ 	
						packgname:'service',//java包
						clsname:'ExecuteSql',//类名
						method:'exeSqlData',//方法名
						ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						tsdcf:'mssql',//指向配置文件名称
						tsdoper:'exe',//操作类型 
						tsdpk:'changeNum.insert'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
				});
				urlstr+=params;
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(msg){
						if(msg=="true"){
							alert("新增成功!");
							
							setTimeout($.unblockUI, 15);
							$("#editgrid").trigger("reloadGrid");
						}	
					}
				});
		}else{
			alert("该号码已经存在,请重新填写!");
			$('#txtAddOldNumForChangeNum').focus();
			return false;
		}
	}
	
	function delSelItems(){
	 		var rowid = $("#editgrid").getGridParam("selarrrow");
	 		if(rowid.length<=0){
	 			alert("请选择要删除的记录!");
	 			return;
	 		}
	 		if(confirm('确定要删除这['+rowid.length+']条记录吗?')){
	 				var values="";
	 				for(var i=0; i<rowid.length; i++){
	 					var key = $('#editgrid').getCell(rowid[i],'id');//工号
	 					values+=key;
	 					if(i<rowid.length-1){
	 						values+=",";
	 					}
					}
					var urlstr=tsd.buildParams({ 	packgname:'service',//java包
		 					clsname:'ExecuteSql',//类名
		 					method:'exeSqlData',//方法名
		 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
		 					tsdcf:'mssql',//指向配置文件名称
		 					tsdoper:'exe',//操作类型 
		 					tsdpk:'changeNum.delete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
					});
						
					$.ajax({
						url:'mainServlet.html?'+urlstr+'&id='+values,
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(msg){
							if(msg=="true"){
								alert("删除成功!");
								setTimeout($.unblockUI, 15);
								$("#editgrid").trigger("reloadGrid");
							}	
						}
					});
					
			}
	 	}
	
	
	//查询旧账号是否存在
	function checkOldNum(){
		var oldNum=$("#txtAddOldNumForChangeNum").val();
		var param="&oldnumber="+oldNum;
	 	if(param==false){return false;}
	 	var num=0;
		var urlstr=tsd.buildParams({ 	
			packgname:'service',//java包
			clsname:'ExecuteSql',//类名
			method:'exeSqlData',//方法名
			ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
			tsdcf:'mssql',//指向配置文件名称
			tsdoper:'query',//操作类型 
			datatype:'xmlattr',//返回数据格式 
			tsdpk:'changeNum.checkOldNum'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		});
		$.ajax({
			url:'mainServlet.html?'+urlstr+param,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				var flag = false;
				$(xml).find('row').each(function(){
					num = $(this).attr("value");
				});
			}
		});
		return num;
	 	
	}
	//参数拼接
	function buildParam(){
		
		var id=$("#hideSaveId").val();
		var oldNum =$("#txtAddOldNumForChangeNum").val();
		var newNum =$("#txtAddNewNumForChangeNum").val();
		var starttime=$("#txtStarttimeForChangeNum").val();
		var stoptime=$("#txtStoptimeForChangeNum").val();
		var crusr=$("#txtCrusrForChangeNum").val();
		var crdt=$("#txtCrdtForChangeNum").val();
		var mdusr=$("#txtMdusrForChangeNum").val();
		var mddt=$("#txtMddtForChangeNum").val();
		var note =$("#txtAddNoteForChangeNum").val();
		
		var param="&oldnumber="+oldNum;
		param+="&newnumber="+newNum;
		if(starttime==""||starttime==undefined){
			param+="&starttime=1990-01-01";
		}else{
			param+="&starttime="+starttime;
		}
		if(stoptime==""||stoptime==undefined){
			param+="&stoptime=2999-12-31";
		}else{
			param+="&stoptime="+stoptime;
		}
		
		param+="&crusr="+crusr;
		param+="&mdusr="+$("#userid").val();
		param+="&note="+tsd.encodeURIComponent(note);
		param+="&id="+id;
		return param;
	}
	
	
	function clearmodinfo(){
		$("#hideSaveId").val("");
		$("#txtAddOldNumForChangeNum").val("");
		$("#txtAddNewNumForChangeNum").val("");
		
		$("#txtStarttimeForChangeNum").val("");
		$("#txtStoptimeForChangeNum").val("");
		
		$("#txtCrusrForChangeNum").val("");
		$("#txtCrdtForChangeNum").val("");
		
		$("#txtMdusrForChangeNum").val("");
		$("#txtMddtForChangeNum").val("");
		$("#txtAddNoteForChangeNum").val("");
	}
	
	
	//弹出数据导入面板
	function openImportForChangeNum(){
		clearmodinfo();
		$("#imptitledivs").text("信息导入");
		
		$("#textfield").val('');
		
		autoBlockForm('divImportChangeNum',60,'closeImportChangeNum',"#ffffff",false);//弹出新增或修改面板
	}
	
	//导入数据，上传文件
	function uploadDisFile(){
		var random=Math.random()*100;
		//var params=$("#column_hidden").val();
		var params="OLDNUMBER,NEWNUMBER,STARTTIME,STOPTIME,CRUSR,CRDT,NOTE";
		var filename = $('#upfile').val();
		if(filename==null || filename==""){
			alert("请先选择要上传的文件！");
			return false;
		}
		filename = filename.substring(filename.lastIndexOf('\\')+1);
		filename = filename.substring(0,filename.lastIndexOf('.'))+random+filename.substring(filename.lastIndexOf('.'),filename.length);
		var expandName = filename.substring(filename.lastIndexOf('.')+1,filename.length);
		if(expandName!="xls" && expandName!="xlsx"){
			alert("文件类型不符合！");
			return false;
		}
		
		var urlstr = 'upfiles?tsdcf=oracle&upDirKey=changeNum.path&ufilename='+tsd.encodeURIComponent(filename);
		$("#disstart").ajaxStart(function ()
		{
			$('#textinfo').text('文件正在上传...');
		    $('#disstart').show();
		});
		$.ajaxFileUpload({
		    url : urlstr, //servlet路径 可携带参数
		    secureuri : false, 
		    fileElementId : 'upfile',
		    success : function (data, status){
		    	
				$('#textinfo').text('文件上传成功！');
		       	exeImportval('tsdboss', filename, 't_173_temp',params);
		    },
		    error : function (data, status, e){
		    	$('#textinfo').text('文件上传失败！');
		    }
		});
	}
	
	
	//开始导入数据
	function exeImportval(cdatasource,importfile,ctablename,columns){
		var disparams = '';
		disparams += '&cdatasource='+cdatasource;
		disparams += '&tablename='+ctablename;
		disparams += '&columns='+columns;
		
		$.ajax(
	            {
	                url : 'import?importfile=' + tsd.encodeURIComponent(importfile) + disparams + '&tsdtemp=' + Math.random(), 
	                cache : false, //如果值变化可能性比较大 一定要将缓存设成false
	                timeout : 2000, 
	                async : false , //同步方式
	                success : function (msg)
	                {
	                	//$('#disstart').hide();
	                	$('#textinfo').text("文件上传成功，开始导入数据...");
	                	//alert("文件上传成功，共"+msg+"条数据！");
	                	if(msg>0){
	                		importData();
	                	}
	                	
	                	deleteData();
	                }
	    });
	    //重新加载临时表数据
	    //reloadData();
	}
		
		
		/*****************
		* 清空临时表
		******************/
		function deleteData(){
			var urlstr=tsd.buildParams({ 	
						packgname:'service',//java包
	 					clsname:'ExecuteSql',//类名
	 					method:'exeSqlData',//方法名
	 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
	 					tsdcf:'mysql',//指向配置文件名称
	 					tsdoper:'exe',//操作类型
	 					tsdpk: 'changeNum.delete173temp'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
	 				});	
	 		$.ajax({
				url:'mainServlet.html?'+urlstr+"&userid="+$("#userid").val(),
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(msg){
					if(msg=="true"){
					}
				}
			});	
		}
		
		//把临时表中的数据导入系统中
		function importData(){
			var userid=$("#userid").val();
			var urlstr=tsd.buildParams({packgname:'service',
				 clsname:'Procedure',
				 ds:'broadband',
				 method:'exequery',
				 tsdpname:'changeNumberNotice.importCompanyInfo',
				 tsdExeType:'query',
				 datatype:'xmlattr',
	 	     	 tsdUserId:'true'
			});
			$.ajax({
				url:'mainServlet.html?'+urlstr+'&userid='+userid,
				datatype:'xml',
			    cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			    timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
				    $(xml).find('row').each(function(){
				    	var result = $(this).attr("result");
				    	
				    	if(result=="error"){
				    		var result2 = $(this).attr("result2");//导致插入失败的电话号码
				    		alert("导入失败,出现重复号码！\t\n以下电话号码已经存在于改号通知表中：\t\n"+result2);
				    		return;
				    	}else{
				    		var count = $(this).attr("count2");//成功导入的数据总条数
				    		alert("导入成功，共导入"+count+"条数据！");
				    		setTimeout($.unblockUI, 15);
				    		$("#editgrid").trigger("reloadGrid");
				    		$('#textinfo').text('');
				    	}
				    	
					});
				}
			});			
		}
	
	</script>
  </head>
  
  <body>
    <jsp:include page="../workflow/Nav.jsp"  flush="true" />
	<div id="buttons" style="margin-top: 0px">
			<button type="button" id="openadd1" onclick="openAddFormForChangeNum();">
				新增
			</button>
			<button type="button" onclick="delSelItems();">
				删除选中项
			</button>
			<button type="button" onclick="" style="display: none;">
				查询
			</button>
			<button type="button" id="imp" onclick="openImportForChangeNum();" >
				导入
			</button>
	</div>
	<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
	<div id="pagered" class="scroll" style="text-align: left;"></div>
	
	
	<div class="neirong" id="divAddOrUpdateForChangeNum" style="display: none; width: 700px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titledivs"></div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form id="formAddOrUpdateForChangeNum">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td class="labelclass" style="width: 16%;">
								<label for="memo" style="width: 90px; font-size: 14px;">
									原号码
								</label>
							</td>
							<td class="tdstyle" style="width: 34%;">
								<input type="hidden" id="hideSaveId" />
								<input type="text" class="textclass"
									style="width: 150px; font-size: 14px;"
									id="txtAddOldNumForChangeNum" />
							</td>
							<td class="labelclass" style="width: 16%;">
								<label for="memo" style="width: 90px; font-size: 14px;">
									新号码
								</label>
							</td>
							<td class="tdstyle" style="width: 34%;">
								<input type="text" class="textclass"
									style="width: 150px; font-size: 14px;"
									id="txtAddNewNumForChangeNum" />
							</td>
						</tr>
						<tr>
							<td class="labelclass" style="width: 16%;">
								<label for="memo" style="width: 90px; font-size: 14px;">
									开始时间
								</label>
							</td>
							<td class="tdstyle" style="width: 34%;">
								<input type="text" class="textclass" style="width: 150px; font-size: 14px;" class="Wdate"
									onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',isShowClear:false,alwaysUseStartDate:true})"
									id="txtStarttimeForChangeNum" />
							</td>
							<td class="labelclass" style="width: 16%;">
								<label for="memo" style="width: 90px; font-size: 14px;">
									结束时间
								</label>
							</td>
							<td class="tdstyle" style="width: 34%;">
								<input type="text" class="textclass" class="Wdate"
									onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',isShowClear:false,alwaysUseStartDate:true})"
									style="width: 150px; font-size: 14px;"
									id="txtStoptimeForChangeNum" />
							</td>
						</tr>
						<tr id="createInfo">
							<td class="labelclass" style="width: 16%;">
								<label for="memo" style="width: 90px; font-size: 14px;"
									 id="lblCrusrForChangeNum">
									创建人
								</label>
							</td>
							<td class="tdstyle" style="width: 34%;">
								<input type="text" class="textclass" disabled="disabled"
									style="width: 150px; font-size: 14px;"
									id="txtCrusrForChangeNum" />
							</td>
							<td class="labelclass" style="width: 16%;">
								<label for="memo" style="width: 90px; font-size: 14px;"
									id="lblCrdtForChangeNum">
									创建时间
								</label>
							</td>
							<td class="tdstyle" style="width: 34%;">
								<input type="text" class="textclass" disabled="disabled"
									style="width: 150px; font-size: 14px;"
									id="txtCrdtForChangeNum" />
							</td>
						</tr>
						
						<tr id="modifyInfo">
							<td class="labelclass" style="width: 16%;">
								<label for="memo" style="width: 90px; font-size: 14px;" id="lblMdusrForChangeNum">
									维护人
								</label>
							</td>
							<td class="tdstyle" style="width: 34%;">
								<input type="text" class="textclass" disabled="disabled"
									style="width: 150px; font-size: 14px;"
									id="txtMdusrForChangeNum" />
							</td>
							<td class="labelclass" style="width: 16%;">
								<label for="memo" style="width: 90px; font-size: 14px;"
									id="lblMddtForChangeNum">
									维护时间
								</label>
							</td>
							<td class="tdstyle" style="width: 34%;">
								<input type="text" class="textclass" disabled="disabled"
									style="width: 150px; font-size: 14px;"
									id="txtMddtForChangeNum" />
							</td>
						</tr>
						<tr>
							<td class="labelclass" style="width: 16%;">
								<label for="memo" style="width: 90px; font-size: 14px;">
									备注
								</label>
							</td>
							<td class="tdstyle" colspan="3">
								<input type="text" class="textclass"
									style="width: 85%; font-size: 14px;"
									id="txtAddNoteForChangeNum" />
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" id="saveadd" style="display: none;" onclick="saveInfo();">
					<!-- 保存添加 -->
					<fmt:message key="jobflowdefine.saveadd"/>
				</button>
				<button type="submit" class="tsdbutton" id="modify" style="display: none;" onclick="modifyInfo();">
					<!-- 修改 -->
					<fmt:message key="global.edit" />
				</button>
				<button type="submit" class="tsdbutton" id="closeForAddOrUpdateChangeNum" onclick="clearmodinfo();$('#editgrid').trigger('reloadGrid');"> 
					<!-- 关闭 -->
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>
		
		<!-- 导入 -->
		<div class="neirong" id="divImportChangeNum" style="display: none; width: 498px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="imptitledivs"></div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;text-align:left;width:498px;height:150px;font-size:14px;padding-top: 30px;">
				<form action="upfile" method="post"	enctype="multipart/form-data">
					<table id="reportFileUploadTab" width="80%" border="0" bordercolor="#eeeeee" cellspacing="0" cellpadding="1" align="center" style="font-size:14px;">
						<tr>
							<td style="text-align: 25px;">浏览文件：</td>
							<td><input name="upfile" type="file" id="upfile" onkeydown="return false" size="30" style="height: 25px;line-height: 22px;"/></td>
						</tr>				
					</table>
				</form>
				<center>
				<div id="textinfo" style="margin-top: 20px;">
				</div>
				<div id="disstart" style="margin-top: 30px;">
					数据要求：旧号码、新号码不能为空。<br/>
							其中旧号码、新号码不能重复！<br/>
					<a href="javascript:location.href='download/ChangeNumberTemplate.xls'" style="color: blue">Excel模板下载</a>
				</div>
			</center>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" id="btnimport" onclick="uploadDisFile()">
					导入
				</button>
				<button type="submit" class="tsdbutton" id="closeImportChangeNum" onclick="$('#editgrid').trigger('reloadGrid');"> 
					<!-- 关闭 -->
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>
		
		<!-- 隐藏域 -->
		<input type="hidden" id="userid" value="<%=userid%>" />
  </body>
</html>
