<%----------------------------------------
	name: jobProcess.jsp
	author: chenliang
	version: 1.0, 2010-01-13
	description: 对处理工单权限的一个设置
	modify: 
		2010-01-13 chenliang 页面功能的实现
      	2010-07-21 chenliang 修改配置，对电话业务进行特殊处理，电话工单是一个闭环，谁受理的谁完工
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
		<title>工单流程定义</title>
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
		<script src="plug-in/jquery/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	  	<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script type="text/javascript" src="script/telephone/sysdataset/infotest.js"></script>
		<script src="script/public/datalength.js" type="text/javascript"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<!-- 时间插件 -->
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>		
		
<script type="text/javascript">
/**
 * 查看当前用户的扩展权限，对spower字段进行解析
 * @param 无参数
 * @return 无返回值
 */
function getUserPower()
{
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', clsname : 'Procedure', method : 'exequery', ds : 'tsdBilling', //数据源名称 对应的spring配置的数据源
        tsdpname : 'jobProcessManager.getPower', //存储过程的映射名称
        tsdExeType : 'query', datatype : 'xmlattr' 
    });
    /****************
    *   拼接权限参数 *
    **************/
    var addright = '';
    var deleteright = '';
    var editright = '';
    var editfields = '';
    var flag = false;
    //是否是系统管理员
    var spower = '';
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&userid=&groupid=<%=zid %>&menuid=<%=imenuid %>', 
        datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                spower += $(this).attr("spower") + '@';
            });
        }
    });
    var str = 'true';
    if (spower != '' && spower != 'all@')
    {
        var spowerarr = spower.split('@');
        for (var i = 0; i < spowerarr.length - 1; i++)
        {
            addright += getCaption(spower, 'add', '') + '|';
            deleteright += getCaption(spower, 'delete', '') + '|';
            editright += getCaption(spower, 'edit', '') + '|';
            editfields += getCaption(spower, 'editfields', '');
        }
    }
    else if (spower == 'all@')
    {
        $("#addright").val(str);
        $("#deleteright").val(str);
        $("#editright").val(str);
        flag = true;
    }
    var hasadd = addright.split('|');
    var hasdelete = deleteright.split('|');
    var hasedit = editright.split('|');
    if (flag == false)
    {
        for (var i = 0; i < hasadd.length; i++) {
            if (hasadd[i] == 'true') {
                $("#addright").val(str);
                break;
            }
        }
        for (var i = 0; i < hasdelete.length; i++) {
            if (hasdelete[i] == 'true') {
                $("#deleteright").val(str);
                break;
            }
        }
        for (var i = 0; i < hasedit.length; i++) {
            if (hasedit[i] == 'true') {
                $("#editright").val(str);
                break;
            }
        }
    }
    $("#editfields").val(editfields);
}
/**
 * 初始化
 * @param 无参数
 * @return 无返回值
 */
jQuery(document).ready(function () 
{
    /**********************
            **   获取当前导航菜单  *
            **********************/
    $("#navBar1").append(genNavv());
    /**********************
            **   取得当前用户的权限  *
            **********************/
    getUserPower();
    //取系统配置表数据
    getJobArea('jobarea');
	$('#grid2').hide();
	//JGrid展示
	viewGrid();
	completeGrid();
	queryList();
});

/**
 *时间格式
 */
function operInitialization()
{
		var today = new Date();
		
		var date_n_y = today.getFullYear();
		var date_n_m = today.getMonth();
		date_n_m += 1;
		
		if(date_n_m < 10)
		{
			date_n_m = "0" + date_n_m;
		}
				
		var date_n_s = today.getDate();
		
		if(date_n_s < 10)
		{
			date_n_s = "0" + date_n_s;
		}
		
		date_n = date_n_y + "-" + date_n_m + "-" + date_n_s;		
		
		var time_n = today.getHours()+":"+today.getMinutes()+":"+today.getSeconds();
		//默认起始时间
		$("#starttime").val(date_n + " 00:00:00");
		//默认结束时间
		$("#endtime").val(date_n + " " + "23:59:59");
		
		///统计起始  起始日
		//$("#tBegin").focus(function(){
		//	WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true,isShowClear:false,readOnly:true});
		//});
		
		///统计终止  起始日
		//$("#tEnd").focus(function(){
		//	WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true,isShowClear:false,readOnly:true});
		//});
	}
/**
 * 删除信息
 * @param key1
 * @param key2
 * @param key3
 * @param key4
 * @return 无返回值
 */
function deleteRow(key1, key2, key3 ,key4)
{
    var deleteright = $("#deleteright").val();
    /**************************
                     *    是否有执行删除的权限    *
                     *************************/
    if (deleteright == "true")
    {
        jConfirm('<fmt:message key="global.deleteinformation"/>?', '<fmt:message key="global.operationtips"/>', 
        function (x) 
        {
            if (x == true)
            {
                var urlstr = tsd.buildParams(
                {
                    packgname : 'service', //java包
                    clsname : 'ExecuteSql', //类名
                    method : 'exeSqlData', //方法名
                    ds : 'tsdReport', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
                    tsdcf : 'mssql', //指向配置文件名称
                    tsdoper : 'exe', //操作类型 
                    tsdpk : 'jobProcess.delete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
                });
                //var thedelinfo  = $('#thedelinfo').val();
                //writeLogInfo('','delete',tsd.encodeURIComponent("<fmt:message key='global.delete'/>")+tsd.encodeURIComponent("IP：")+key+tsd.encodeURIComponent("<fmt:message key='usermanager.info'/>：")+thedelinfo);
                $.ajax(
                {
                    url : 'mainServlet.html?' + urlstr, 
                    cache : false, //如果值变化可能性比较大 一定要将缓存设成false
                    timeout : 1000, async : false , //同步方式
                    success : function (msg)
                    {
                        if (msg == "true")
                        {
                            alert('<fmt:message key="global.successful"/>', '<fmt:message key="global.operationtips"/>');
                            setTimeout($.unblockUI, 15);
                        }
                    }
                });
                // }else{
                //  var operationtips = $("#operationtips").val();
                //  var deletefailed = $("#deletefailed").val();
                //  alert(deletefailed,operationtips);
                // }
            }
        });
    }
    else
    {
        alert('<fmt:message key="global.deleteright"/>', '<fmt:message key="global.operationtips"/>');
    }
}

/**
 * 获取可受理工单的区域
 * @param id
 * @return 无返回值
 */
function getJobArea(id)
{
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'jobProcess.getArea'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?ian=1' + urlstr , datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            var thevalue = "<form name='thejobareaform'>";
            var i = 1;
            $(xml).find('row').each(function ()
            {
                var ywarea = $(this).attr("ywarea");
                if (ywarea != undefined)
                {
                    var thebr = '';
                    if (i * 1 % 4 == 0) {
                        thebr = '<br/>';
                    }
                    thevalue += "<input type='checkbox' name='ywareas' value='" + ywarea + "' style='width:20px;height:20px;margin-top:5px;margin-left:5px;'><label style='text-align: left;width:100px;font-size:12px;margin-left:10px'>" + ywarea + "</label>" + thebr;
                    i++;
                }
                else {
                    thevalue = '对不起，该区域可配置!';
                }
            });
            $('#' + id).html(thevalue + '</form>');
        }
    });
}

/**
 *打开操作面板
 */
function openPanl(key)
{
	if(key==1)
	{
		overGrid(2);
		clearText('queryform');
		operInitialization();
		autoBlockForm('query', 60, 'close', "#ffffff", false);
	}else if(key==2)
	{
		overGrid(2);
		//获取选中行
		var arr = $('#editgrid').getGridParam('selarrrow');
		
		//判断是否选择工单
		if(arr.length==0){
			alert('请先选择工单！');
			return false;
		}
		
		var id='';
		//判断选择的工单是否属于同一类型
		for(var i = 0 ; i < arr.length  ; i++){
			id+=','+$('#editgrid').getCell(arr[i],'ID');
			/**
			if(i>0)
			{
				var type1=$('#editgrid').getCell(arr[i],'Sgnr');
				var type2=$('#editgrid').getCell(arr[i-1],'Sgnr');
				if(type1 != type2)
				{
					alert('请选择同一类型的工单');
					return false;
				}		
			}
			*/
		}
		//判断是否有工单已指派人员操作
		id=id.substring(1);
		var res = fetchSingleValue("teljobmanager.queryorder",0,"&id="+id);
		var hth= fetchSingleValue("teljobmanager.queryhth",0,"&id="+id);
		
		var depts=fetchMultiValue("teljobmanager.querydepts",0,"&id="+id);
		var deptsqll=" where ";
		var deptsql="";
		if(depts!=undefined && depts[0]!=undefined && depts[0]!="全地区")
		{
			for(var i=0;i<depts.length;i++)
			{
				 deptsql+= "or  userarea like '%"+depts[i]+"%' ";
			}
			deptsql=deptsql.substring(2);
			deptsqll+=deptsql;
		}else{
			deptsqll="";
		}
		
		
		if(hth>1)
		{
			alert('请选择同一合同号进行操作！');
			return false;
		}
		getdeptbox(deptsqll);
    	if(res>1)
    	{
    		alert('工单已指派人员！');
    		//return false;
    		
    	}
    	if(res==1)
    	{
    		var res=getordermen(id);
    		if(res!='' && res != 'null')
    		{
    			alert('该工单已指派人员！');
    			var boxs=document.getElementsByName('thismenulist');
    			for(var i=0;i<boxs.length;i++)
    			{
    				if(res.indexOf(boxs[i].value)>=0)
    				{
    					boxs[i].checked=true;
    				}
    			}
    		}
    	}
		clearText('zhipaiform');
		//var res = fetchMultiArrayValue("phonelnstalled.queryZJtime",6,"");
		//var zjtime = res[0][0];
        $("#pgsj").val('<%=Log.getThisTime() %>');
		autoBlockForm('zhipai', 60, 'close', "#ffffff", false);
	}else if(key==3)
	{
		var arr = $('#editgrid').getGridParam('selarrrow');
		if(arr.length==0){
			alert('请勾选您要完工的记录!');
			return false;
		}
		var id='';
		for(var i = 0 ; i < arr.length  ; i++){
		
			id+=','+$('#editgrid').getCell(arr[i],'id');
		}
		id=id.substring(1);
		
		var res = fetchSingleValue("teljobmanager.queryorder",0,"&id="+id);
		if(res>0)
		{
			alert('工单未派工，不能完工！');
			return false;
		}
		clearText('theisok');
		autoBlockForm('theisok', 60, 'close', "#ffffff", false);
	}else
	{
		return false;
	}

}

/**
 *获取流转部门复选框
 */
function getdeptbox(deptsql)
{
	var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'teljobmanager.querydept'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
	$.ajax(
    {
        url : 'mainServlet.html?' + urlstr+'&deptsql='+tsd.encodeURIComponent(deptsql), 
        datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 2000, async : false , //同步方式
        success : function (xml)
        {
        	var menulist='';	//空间字符串
        	var i=2;			//自增变量
			var thebr='';		//换行符
            $(xml).find('row').each(function ()
            {
            	var bm=$(this).attr('bm');
                menulist += "<span class='spanstyle'><input type='checkbox' name='thismenulist' value='"+bm+"' style='width:15px;height:15px;margin-left:5px'><label style='text-align: left;margin-left:5px'>"+bm+"</label></span>"+thebr;
            	//每行显示四个部门
     			if(i*1%5==0){
					thebr = '<br/>';
				}else{
					thebr = '';
				}
				i++;
            });
             $('#dismenulist').html(menulist);
        }
    });
}

/**
 *关闭面板
 */
function  closethis(key)
{
	if(key=='query')
	{
		clearText('query');
		setTimeout($.unblockUI, 15);//关闭面板
	}else if(key=='order')
	{
		clearText('zhipai');
		setTimeout($.unblockUI, 15);//关闭面板
	}else if(key='over')
	{
		clearText('over');
		setTimeout($.unblockUI, 15);//关闭面板
	}else
	{
		return false;
	}
}

/**
 *jgrid展示样式
 */
function viewGrid()
{  var are='<%=session.getAttribute("managearea") %>';
	if(are=='全地区'){
	   viewGridall();
	}
	else{
	   viewGridcommon(); 
	}
}
/**
 *admin登录时  jgrid展示样式
 */
function viewGridall(){
     var urlstr=tsd.buildParams({ 	
								packgname:'service',//java包
			 					clsname:'ExecuteSql',//类名
			 					method:'exeSqlData',//方法名
			 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
			 					tsdcf:'mssql',//指向配置文件名称
			 					tsdoper:'query',//操作类型 
			 					datatype:'xml',//返回数据格式 
			 					tsdpk:'teljobzsy.queryall',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
			 					tsdpkpagesql:'teljobzsy.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
			 				});

	//var languageType = $("#languageType").val();
	//var corp_num = $("#corp_num_hidden").val();
   	//var col=[[],[]];
   	//  	  getRb_Field('txkz_ctlset','JhjID',"修改|删除|详细",'97','ziduansF1','CtlPort','YwID');//得到jqGrid要显示的字段
   	var col = getRb_Field('teljob','ID','工单编号','70','thecolumn','ywlx');
	var column = $('#thecolumn').val();
	//alert($("#managearea").val());
	var are='<%=session.getAttribute("managearea") %>';
	jQuery("#editgrid").jqGrid({
		url:'mainServlet.html?'+urlstr+'&column='+column+'&area='+tsd.encodeURIComponent(are),
		datatype: 'xml', 
		colNames: col[0], 
		colModel:col[1], 
		rowNum:10, //默认分页行数
		rowList:[10,15,20], //可选分页行数
		imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
		pager: jQuery('#pagered'), 
		sortname: 'Sgrq', //默认排序字段
	    viewrecords: true,
	    sortorder: 'desc',//默认排序方式 
	    caption:'电话工单管理', 
	    height:document.documentElement.clientHeight-162,
	    //height:270, //高
	    //width:950,
	    multiselect: true,
		multiselectWidth: 20,
	    loadComplete:function(){
			//$("#editgrid").setSelection('0', true);
			//$("#editgrid").focus();
			//addRowOperBtnimage('editgrid','showprint','Hth','click',1,"style/images/public/print-view.png",'打印预览',"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'Sgnr');//修改
			//executeAddBtn('editgrid',1);
			//addRowOperBtn('getjobinfo','<img src="style/images/public/ltubiao_03.gif" alt="查看"/>','viewInfo','ID','click',1);
			//executeAddBtn('editgrid',1);
		},
		onSelectRow:function(ids){
		 	var id = $("#editgrid").getCell(ids, "ID");
		 	var ywlx=$("#editgrid").getCell(ids, "ywlx");
		 	$('#id').val(id);
		 	$('#ywlx').val(ywlx);
			getjobinfo(id);
			/**
			var value8=$("#editgrid").getCell(ids, "value8");
		 	//alert(value8);
		 	$('#thisvalue8').val(value8);
		 	*/
		},
		ondblClickRow: function(ids)
		{
			//$('#hth').val($("#editgrid").getCell(ids, "Hth"));
			//$('#ywlx').val($("#editgrid").getCell(ids, "ywlx"));
			//theviewprint();
		}
		}).navGrid('#pagered',  {edit: false, add: false, add: false, del: false, search: false}, //options 
			{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
			{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
			{reloadAfterSubmit:false}, // del options 
			{} // search options 
		); 
}

/**
 *普通用户登录时  jgrid展示样式
 */
function viewGridcommon(){
     var urlstr=tsd.buildParams({ 	
								packgname:'service',//java包
			 					clsname:'ExecuteSql',//类名
			 					method:'exeSqlData',//方法名
			 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
			 					tsdcf:'mssql',//指向配置文件名称
			 					tsdoper:'query',//操作类型 
			 					datatype:'xml',//返回数据格式 
			 					tsdpk:'teljobzsy.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
			 					tsdpkpagesql:'teljobzsy.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
			 				});

	//var languageType = $("#languageType").val();
	//var corp_num = $("#corp_num_hidden").val();
   	//var col=[[],[]];
   	//  	  getRb_Field('txkz_ctlset','JhjID',"修改|删除|详细",'97','ziduansF1','CtlPort','YwID');//得到jqGrid要显示的字段
   	var col = getRb_Field('teljob','ID','工单编号','70','thecolumn','ywlx');
	var column = $('#thecolumn').val();
	//alert($("#managearea").val());
	var are='<%=session.getAttribute("managearea") %>';
	jQuery("#editgrid").jqGrid({
		url:'mainServlet.html?'+urlstr+'&column='+column+'&area='+tsd.encodeURIComponent(are),
		datatype: 'xml', 
		colNames: col[0], 
		colModel:col[1], 
		rowNum:10, //默认分页行数
		rowList:[10,15,20], //可选分页行数
		imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
		pager: jQuery('#pagered'), 
		sortname: 'Sgrq', //默认排序字段
	    viewrecords: true,
	    sortorder: 'desc',//默认排序方式 
	    caption:'电话工单管理', 
	    height:document.documentElement.clientHeight-162,
	    //height:270, //高
	    //width:950,
	    multiselect: true,
		multiselectWidth: 20,
	    loadComplete:function(){
			//$("#editgrid").setSelection('0', true);
			//$("#editgrid").focus();
			//addRowOperBtnimage('editgrid','showprint','Hth','click',1,"style/images/public/print-view.png",'打印预览',"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'Sgnr');//修改
			//executeAddBtn('editgrid',1);
			//addRowOperBtn('getjobinfo','<img src="style/images/public/ltubiao_03.gif" alt="查看"/>','viewInfo','ID','click',1);
			//executeAddBtn('editgrid',1);
		},
		onSelectRow:function(ids){
		 	var id = $("#editgrid").getCell(ids, "ID");
		 	var ywlx=$("#editgrid").getCell(ids, "ywlx");
		 	$('#id').val(id);
		 	$('#ywlx').val(ywlx);
			getjobinfo(id);
			/**
			var value8=$("#editgrid").getCell(ids, "value8");
		 	//alert(value8);
		 	$('#thisvalue8').val(value8);
		 	*/
		},
		ondblClickRow: function(ids)
		{
			//$('#hth').val($("#editgrid").getCell(ids, "Hth"));
			//$('#ywlx').val($("#editgrid").getCell(ids, "ywlx"));
			//theviewprint();
		}
		}).navGrid('#pagered',  {edit: false, add: false, add: false, del: false, search: false}, //options 
			{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
			{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
			{reloadAfterSubmit:false}, // del options 
			{} // search options 
		); 
}

/** 
 *查找工单
 */
function queryInfo()
{
	var starttime=$('#starttime').val();
	var endtime=$('#endtime').val();
	var hth=$('#xhth').val();
	var phone=$('#phoneno').val();
	var queryjd='';
	var column=$('#thecolumn').val();
	if(endtime <= starttime)
	{
		alert('截止时间不能小于起始时间！');
		return false;
	}
	if(starttime != '' && starttime != 'undefined' && starttime != 'null')
	{
		queryjd+=" and sgrq >= to_date('"+starttime+"','yyyy-mm-dd hh24:mi:ss')";
	}
	if(endtime != '' && endtime != 'undefined' && endtime != 'null')
	{
		queryjd+=" and sgrq <= to_date('"+endtime+"','yyyy-mm-dd hh24:mi:ss')";
	}
	 
	if(hth != '' && hth != 'undefined' && hth != 'null')
	{
		queryjd+=" and hth='"+hth+"'";
	}
	
	if(phone != '' && phone != 'undefined' && phone != 'null')
	{
		queryjd+=" and xdh="+phone;
	}
	var userid=$('#userid').val();
	var area=queryarea();
	var sql='zsjob.queryinfo';
	var sqlpage='zsjob.queryinfopage';
	if(userid != "admin")
	{
		sql='zsjob.queryinfo2';
		sqlpage='zsjob.queryinfopage2';
	}
	var urlstr=tsd.buildParams({
		packgname:'service',//java包
		clsname:'ExecuteSql',//类名
		method:'exeSqlData',//方法名
		datatype:'xml',//返回数据格式 
		ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
		tsdcf:'mssql',//指向配置文件名称
		tsdoper:'query',//操作类型 
		tsdpk:sql,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		tsdpkpagesql:sqlpage //依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
	});
	$('#queryjd').val(queryjd);
	$('#queryerea').val(area);
	if(userid != "admin")
	{
		$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&column='+tsd.encodeURIComponent(column)+'&area='+tsd.encodeURIComponent(area)+'&queryjd='+queryjd}).trigger("reloadGrid");
		clearText('query');
		setTimeout($.unblockUI, 15);//关闭面板
	}else
	{
		$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&column='+tsd.encodeURIComponent(column)+'&queryjd='+queryjd}).trigger("reloadGrid");
		clearText('query');
		setTimeout($.unblockUI, 15);//关闭面板
	}
}

/**
 * 指派工单
 */
function ordermen()
{
	var j=0;
    var l=0;
    var s;

	//获取指派人员并判断
	var boxs=document.getElementsByName('thismenulist');
    var todept='';
    for(var i=0;i<boxs.length;i++)
    {
    	if(boxs[i].checked && boxs[i].value!='[object]')
    	{
    		todept+=boxs[i].value+';';
    		j++;
    	}
    }
    if(j<=0)
    {
    	alert('请指派人员！');
    	return false;
    }
    
    var arr = $('#editgrid').getGridParam('selarrrow');
    var id='';
    for(var i = 0; i < arr.length; i++){
    	id = id+",'"+$('#editgrid').getCell(arr[i],'ID')+"'";
	}
	for(var i = 0; i < arr.length; i++){
	    s = $('#editgrid').getCell(arr[i],'Sgnr');
        if (s.indexOf("专线") > 0)
        {
           s = "trunk";
           break;
        }
        else
        {
            s = "";
        }
    }
    
	id=id.substring(1);
	var res=checkMkj();
	if(res>1)
	{
		alert('所选电话属于多个模块局，无法派工！');
		return false;
	}
	var tikNo=getNo(s);
	if(tikNo=='')
	{
		alert('批处理失败！');
		return false;
	}
	var pgsj=$('#pgsj').val();	//派工日期
	if(pgsj == '' || pgsj == 'undefined' || pgsj == null)
	{
		alert('请选择派工时间！');
		return false;
	}
	var params = '&pch='+tsd.encodeURIComponent(tikNo)+'&dept='
				+tsd.encodeURIComponent(todept)+'&id='+id+'&pgsj='+tsd.encodeURIComponent(pgsj);
	var res = executeNoQuery('zsjob.ordermen',6,params);
	if(res=='true'){
		alert('派送成功');
       	//setTimeout($.unblockUI, 6);
		autoBlockForm('thedisplayprint', 150, 'printclose', "#ffffff", false);
	}
}

function reloadPsData(){
    var are='<%=session.getAttribute("managearea") %>';
	if(are=='全地区'){
	reloadadmin();
	}	
	else{
	reloadpt();
	}
}

/**
 *admin登录时  jgrid重新载入展示样式
 */
  function reloadadmin(){
     setTimeout($.unblockUI, 6);
	var urlstr=tsd.buildParams({ 	
		 					packgname:'service',//java包
		 					clsname:'ExecuteSql',//类名
		 					method:'exeSqlData',//方法名
		 					datatype:'xml',//返回数据格式 
		 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
		 					tsdcf:'mssql',//指向配置文件名称
		 					tsdoper:'query',//操作类型 
		 					tsdpk:'teljobzsy.queryall',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		 					tsdpkpagesql:'teljobzsy.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
		 				});
		 				
		var are='<%=session.getAttribute("managearea") %>';
	var thecolumn = $('#thecolumn').val();
 	$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&column='+thecolumn
 		+'&area='+tsd.encodeURIComponent(are)}).trigger("reloadGrid");
 }
 
/**
 *普通用户登录时  jgrid重新载入展示样式
 */
 function reloadpt(){
     setTimeout($.unblockUI, 6);
	var urlstr=tsd.buildParams({ 	
		 					packgname:'service',//java包
		 					clsname:'ExecuteSql',//类名
		 					method:'exeSqlData',//方法名
		 					datatype:'xml',//返回数据格式 
		 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
		 					tsdcf:'mssql',//指向配置文件名称
		 					tsdoper:'query',//操作类型 
		 					tsdpk:'teljobzsy.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		 					tsdpkpagesql:'teljobzsy.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
		 				});
		 				
		var are='<%=session.getAttribute("managearea") %>';
	var thecolumn = $('#thecolumn').val();
 	$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&column='+thecolumn
 		+'&area='+tsd.encodeURIComponent(are)}).trigger("reloadGrid");
 }
 
/** 
 *工单完工
 */
function overorder()
{
	
	var isok=$("input[id=isok]:checked").val();
	if(isok==undefined || isok=='' || isok=='null')
	{
		alert('请录入用户满意度');
		return false;
	}else{
		$('#theisok').hide();
		setTimeout($.unblockUI, 10);
	}
	
	//可进行批量提交完工
	var arr = $('#editgrid3').getGridParam('selarrrow');
	//判断是否选择工单
	if(arr.length==0){
		alert('请先选择要完工的工单');
		return false;
	}
	var thisvl = '';
	for(var i = 0 ; i < arr.length  ; i++){
		var value8str = $('#editgrid3').getCell(arr[i],'value8');
		if(value8str!=''){
			thisvl += ",'" +tsd.encodeURIComponent(value8str)+"'";
		}
	}
	var val = thisvl.substring(1,thisvl.length);
	if(val==''){
		alert('请选择要完工的工单');
		return false;
	}
	
	if(confirm('确认要完工工单吗？')){
		//var key=$('#lsh').val();
		var bm=$('#department').val();
		//value8='','','',''
		executeNoQuery('zsjob.overjob',6,'&isok='+isok+'&bm='+tsd.encodeURIComponent(bm)+'&key='+val);
		//teljobmanager.JobAfterComplete
		//var sCommitAfter = fetchMultiPValue('teljobmanager.JobAfterComplete',6,'&jobid='+);
		fetchMultiPValue('teljobmanager.JobAfterComplete',6,'&jobid='+$('#idstr').text());
		reloadPsData();
		alert('确认完工成功');
	    //reloadGrid2();
		//overGrid(2);
	}else{
		reloadPsData();
	}
}

/** 
 *查看工单是否完工
 */
 function queryStatus(key)
 {
 	var iscomplete='';
 	var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'zsjob.querystatus'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
     });

    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&hth=' + key,
        datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, 
        async : false , //同步方式
        success : function (xml)
        {
        	     		
        	$(xml).find('row').each(function(){
            	iscomplete=$(this).attr('iscomplete');
            });
        }
    });
    return iscomplete;
 }
 
 /**
  *判断登陆人员是否是派线人员
  */
function getPower()
{

    var hth = $('#hth').val();
    var xdh = $('#xdh').val();
	//登陆帐号
	var userid=<%=userid%>;
	var res=0;
	var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'zsjob.queryorder'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });       
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&hth=' + hth + '&xdh=' + xdh + '&dept=' + tsd.encodeURIComponent(userid), datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
         	res=$(this).attr('res');
        }
    });
    if(res<1)
    {
    	alert('对不起，派线人员不能指派工单!');
    	return false;
    }
    return true;
}

/** 
 *获取选中工单的信息
 */
function getjobinfo(key)
{
	var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'zsjob.getjobinfo'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&id=' + key,
        datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, 
        async : false , //同步方式
        success : function (xml)
        {
        	$(xml).find('row').each(function(){
        	
         		var hth=$(this).attr('hth');
         		var xdh=$(this).attr('xdh');
         		var area=$(this).attr('area');
         		var lsh=$(this).attr('lsh');
         		var date=$(this).attr('sgrq');
         		var name=$(this).attr('xm');
         		var lsh=$(this).attr('lsh');
         		//var sgnr=$(this).attr('sgnr');
         		$('#name').val(name);
         		$('#date').val(date);
         		$('#lsh').val(lsh);
         		$('#area').val(area);
         		$('#hth').val(hth);
         		$('#xdh').val(xdh);
         		$('#lsh').val(lsh);
       		});
        }
    });
} 

/**
 *获取用户区域
 */
function queryarea()
{
	var res='';
	var str='';
	var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'zsjob.querarea'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&userid=<%=userid%>', 
        datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, 
        async : false , //同步方式
        success : function (xml)
        {
        	$(xml).find('row').each(function(){
         		res=$(this).attr('userarea');
         	 });
        }
    });
    if(res.indexOf('~')>0)
    {
    	str=res.replace(/~/g,"','");
    	str="'"+str+"'";
    	return str;
    }
    res="'"+res+"'";
    return res;
}


/**
 * 直接打印工单
 * @param 无参数
 * @return 无返回值
 */
function theprint()
{
    var arr = $('#editgrid').getGridParam('selarrrow');
	var id='';
	for(var i = 0 ; i < arr.length  ; i++){
		//字段标识
		id+=','+$('#editgrid').getCell(arr[i],'ID');
	}
	id=id.substring(1);

    thiswillhide();
    if (id != 'undefined')
    {
    	if(arr.length%6==0){
			var printfile = "usercat/teljob6";
		}else{
			var printfile = "usercat/teljob";
		}
        printWithoutPreview(printfile,"id_"+id);
        $('#printclose').click();
    }
    else {
        alert('无工单可打印!');
    }
    reloadPsData();
}
/**
 * 关闭面板
 * @param 无参数
 * @return 无返回值
 */
function thiswillhide()
{
    var ywlx = $('#ywlx').val();
    var key = ywlx;
    
    $('#thedisplayprint').hide();
}

/**
 * 打印预览
 * @param 无参数
 * @return 无返回值
 */
function theviewprint()
{
	var arr = $('#editgrid').getGridParam('selarrrow');
	var id='';
	for(var i = 0 ; i < arr.length  ; i++){
		//字段标识
		id+=','+$('#editgrid').getCell(arr[i],'ID');
	}
	id=id.substring(1);
	if(arr.length%6==0){
		var printfile = "usercat/teljob6";
	}else{
		var printfile = "usercat/teljob";
	}	
    if (id != 'undefined' && id!='')
    {
        var theurl = "<%=basePath %>/ReportServer?reportlet=/com/tsdreport/" + printfile + ".cpt&id=" + id;
        window.open(theurl);
        /*printThisReport1('< %=request.getParameter("imenuid")%>',
					"teljob","&JobID=" + key,
					'< %=(String)session.getAttribute("userid")%>',
					'< %=request.getParameter("groupid").replaceAll("~", ",")%>',
					'< %=(String)session.getAttribute("departname")%>',1);*/
        $('#printclose').click();
    }
    else {
        alert('无工单可预览!');
    }
    reloadPsData();
}

function theviewprint2()
{
	var arr = $('#editgrid').getGridParam('selarrrow');
	var id='';
	for(var i = 0 ; i < arr.length  ; i++){
		//字段标识
		id+=','+$('#editgrid').getCell(arr[i],'ID');
		var disvalue8 = $('#editgrid').getCell(arr[i],'value8');
		if(disvalue8==''){
			alert('工单编号为【'+$('#editgrid').getCell(arr[i],'ID')+'】尚未派工，请先派发工单之后再进行打印');
			return false;
		}
	}
	id=id.substring(1);
	var hth= fetchSingleValue("teljobmanager.queryhth",0,"&id="+id);
		if(hth>1)
		{
			alert('请选择同一合同号进行操作！');
			return false;
		} 
	if(arr.length%6==0){
		var printfile = "usercat/teljob6";
	}else{
	var printfile = "usercat/teljob";
	}	
    if (id != 'undefined' && id!='')
    {
        var theurl = "<%=basePath %>/ReportServer?reportlet=/com/tsdreport/" + printfile + ".cpt&id=" + id;
    
        window.open(theurl);
        /*printThisReport1('< %=request.getParameter("imenuid")%>',
					"teljob","&JobID=" + key,
					'< %=(String)session.getAttribute("userid")%>',
					'< %=request.getParameter("groupid").replaceAll("~", ",")%>',
					'< %=(String)session.getAttribute("departname")%>',1);*/
        $('#printclose').click();
    }
    else {
        alert('无工单可预览!');
    }
    reloadPsData();
}

/**
 * 打印预览
 * @param 无参数
 * @return 无返回值
 */
function showprint(key,ywlx)
{
    //var key = $('#hth').val();
    //var ywlx = $('#ywlx').val();
    var printfile = "usercat/teljob";
    if (key != 'undefined')
    {
        var theurl = "<%=basePath %>/ReportServer?reportlet=/com/tsdreport/" + printfile + ".cpt&hth=" + key+"&sgnr="+ywlx;
        window.open(theurl);
        /***
        printThisReport1('< %=request.getParameter("imenuid")%>',
					"teljob","&JobID=" + key,
					'< %=(String)session.getAttribute("userid")%>',
					'< %=request.getParameter("groupid").replaceAll("~", ",")%>',
					'< %=(String)session.getAttribute("departname")%>',1);
        $('#printclose').click();
        */
        
    }
    else {
        alert('无工单可预览!');
    }
}
/**
 *判断是否已派工
 */
function getordermen(key)
{
	var res='';
	var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'zsjob.queryordermen'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&id='+key, 
        datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, 
        async : false , //同步方式
        success : function (xml)
        {
        	$(xml).find('row').each(function(){
         		res=$(this).attr('value10');
         	 });
        }
    });
    return res;
}



/**
 *重载数据
 */
function reloadData()
{
	var area=$('#queryerea').val();
	var queryjd=$('#queryjd').val();
	var column=$('#thecolumn').val();
	var urlstr=tsd.buildParams({
		packgname:'service',//java包
		clsname:'ExecuteSql',//类名
		method:'exeSqlData',//方法名
		datatype:'xml',//返回数据格式 
		ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
		tsdcf:'mssql',//指向配置文件名称
		tsdoper:'query',//操作类型 
		tsdpk:'zsjob.queryinfo',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		tsdpkpagesql:'zsjob.queryinfopage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
	});
   	$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&column='+tsd.encodeURIComponent(column)+'&area='+tsd.encodeURIComponent(area)+'&queryjd='+queryjd}).trigger("reloadGrid");
}

/**
 * 全选
 * @param str
 * @param key
 * @return 无返回值
 */
function isSelect(str)
{
    if (str == 1)
    {
        var tagname = document.getElementsByName('jobids');
        //获取name的所有的值
        for (var i = 0 ; i < tagname.length; i++)
        {
            if ($("#thischecked").attr("checked") == true) {
                tagname[i].checked = true 
            }
            else {
                tagname[i].checked = false;
            }
        }
    }
    else if (str == 2)
    {
        var tagname = document.getElementsByName('untreatedjobids_');
        //获取name的所有的值
        for (var i = 0 ; i < tagname.length; i++)
        {
            if ($("#thatchecked").attr("checked") == true) {
                tagname[i].checked = true 
            }
            else {
                tagname[i].checked = false;
            }
        }
    }
    else if (str == 3)
    {
        var tagname = document.getElementsByName('pause_');
        //获取name的所有的值
        for (var i = 0 ; i < tagname.length; i++)
        {
            if ($("#pusechecked_").attr("checked") == true) {
                tagname[i].checked = true 
            }
            else {
                tagname[i].checked = false;
            }
        }
    }
}

/**
 *获取批次号
 */
function getNo(s)
{
	var area=getMkj();
    var hth=$('#hth').val();
    var res='';
    //调用存储过程
	var urlstr = tsd.buildParams(
    {   
         packgname : 'service', //java包
         clsname : 'Procedure', //类名
         method : 'exequery', //方法名
         ds : 'tsdBilling', //数据源名称对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
         tsdpname:'teljob.teljob_getpjh',	//执行存储过程         
         datatype:'xmlattr',
         tsdExeType:'query'
    });
    $.ajax({
            url : 'mainServlet.html?' + urlstr+'&HTH='+hth+'&AREA='+tsd.encodeURIComponent(area) + '&TRUNK=' + s, 
            cache : false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout : 1000, 
            async : false , //同步方式
            success : function (xml)
            {
                $(xml).find('row').each(function(){
       	 			res = $(this).attr('res');
       	 		});
            }
     }); 
     return res;    
}

/**
 *获取模块局
 */
function getMkj()
{
	var arr = $('#editgrid').getGridParam('selarrrow');
	var xdh='';
	for(var i = 0 ; i < arr.length  ; i++){
		//字段标识
		xdh+=','+$('#editgrid').getCell(arr[i],'Xdh');
	}
	xdh=xdh.substring(1);
	var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'zsjob.getmkj'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
	
	$.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&dh='+xdh, 
        datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, 
        async : false , //同步方式
        success : function (xml)
        {
        	$(xml).find('row').each(function(){
         		res=$(this).attr('mokuaiju');
         	 });
        }
    });
    return res;
}

/**
 *检查电话是否属于同一模块局
 */
function checkMkj()
{
	var arr = $('#editgrid').getGridParam('selarrrow');
	var xdh='';
	for(var i = 0 ; i < arr.length  ; i++){
		//字段标识
		xdh+=",'"+$('#editgrid').getCell(arr[i],'Xdh') + "'";
	}
	xdh=xdh.substring(1);
	var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'zsjob.checkmkj'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
	
	$.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&dh='+xdh, 
        datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, 
        async : false , //同步方式
        success : function (xml)
        {
        	$(xml).find('row').each(function(){
         		res=$(this).attr('res');
         	 });
        }
    });
    return res;
}


/**
 *检查是否有拆机
 */
function checkChai()
{
	var res=0;
	var ywlx='';
	var arr = $('#editgrid').getGridParam('selarrrow');
	for(var i = 0 ; i < arr.length  ; i++){
		//字段标识
		ywlx=$('#editgrid').getCell(arr[i],'Sgnr');
		if(ywlx=='拆机')
		{
			res=1;		
		}
	}
	return res;
}

/**
 *检查是否全是拆机
 */
function checkAllChai()
{
	var id='';
	for(var i = 0 ; i < arr.length  ; i++){
		//字段标识
		id+=','+$('#editgrid').getCell(arr[i],'ID');
	}
	id=id.substring(1);
	var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'zsjob.checCj'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
	
	$.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&id='+id, 
        datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, 
        async : false , //同步方式
        success : function (xml)
        {
        	$(xml).find('row').each(function(){
         		res=$(this).attr('res');
         	 });
        }
    });
    return res;
}

/**
 *显示隐藏JGrid
 */
function overGrid(key)
{
	if(key==1)
	{
		$('#grid1').hide();
		$('#grid2').show();	
	}else
	{
		$('#grid2').hide();
		$('#grid1').show();	
	}
	
}

/**
 *显示完工编号
 */
function completeGrid()
{
	jQuery("#editgrid2").jqGrid({
		//url:'mainServlet.html?'+urlstr, 
		datatype: 'xml', 
		colNames: ['编号'], 
		colModel:[
				{name:'value8',index:'value8',width:90}
				],
		rowNum:10, //默认分页行数
		rowList:[10,15,20], //可选分页行数
		imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
		pager: jQuery('#pagered2'), 
		sortname: 'value8', //默认排序字段
	    viewrecords: true,
	    sortorder: 'desc',//默认排序方式 
	    caption:'待完工工单管理', 
	    height:document.documentElement.clientHeight-162,
	    width:document.documentElement.clientWidth-162,
		loadComplete:function(){
				 
		},
		ondblClickRow: function(keys)
		{
			var value8= $("#editgrid2").getCell(keys, "value8");
			$('#thisvalue8').val(value8);
			reloadGrid(value8);
			autoBlockForm('overlist', 10, 'theclose', "#ffffff", false);
		}
		})
}

/**
 *查询出一批次下边的所有工单
 */
function queryList()
{
	jQuery("#editgrid3").jqGrid({
		//url:'mainServlet.html?'+urlstr+'&key='+tsd.encodeURIComponent(key), 
		datatype: 'xml', 
		colNames: ['编号','电话','类型','合同号','单位','工单号'], 
		colModel:[{name:'id',index:'id',width:90},{name:'dh',index:'dh',width:90},{name:'sgnr',index:'sgnr',width:90},{name:'hth',index:'hth',width:90},{name:'bm1',index:'bm1',width:90},{name:'value8',index:'value8',hidden:true}],  
		rowNum:10, //默认分页行数
		rowList:[10,15,20], //可选分页行数
		imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
		pager: jQuery('#pagered3'), 
		sortname: 'value8', //默认排序字段
	    viewrecords: true,
	    sortorder: 'desc',//默认排序方式 
	    caption:'工单列表', 
	    height:270, //高
	    //width:document.documentElement.clientWidth-252,
	    width:768,
	    multiselect: true,
		multiselectWidth: 20,
			loadComplete:function(){
				 
			},
			onSelectRow:function(keys){
		 		var id = $("#editgrid3").getCell(keys, "id");		 		
		 		$('#number').val(id);
			}
		}); 	
}

/**
 *重载
 */
function reloadGrid(key)
{
		var urlstr=tsd.buildParams({
		packgname:'service',//java包
		clsname:'ExecuteSql',//类名
		method:'exeSqlData',//方法名
		datatype:'xml',//返回数据格式 
		ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
		tsdcf:'mssql',//指向配置文件名称
		tsdoper:'query',//操作类型 
		tsdpk:'teljob.querylist',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		tsdpkpagesql:'teljob.querylistpage' //依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
	});
	$("#editgrid3").setGridParam({url:'mainServlet.html?'+urlstr+'&key='+tsd.encodeURIComponent(key)}).trigger("reloadGrid");
}
/**
 *处理工单
 */
function reductionOrder(key)
{
	//还原工单
	if(key==1)
	{
		var id=$('#number').val();
		if(id==''){
			alert('请选择要驳回的工单');
			return false;
		}
		if(confirm('确认要驳回工单吗？')){
			//执行驳回
			var res = executeNoQuery("teljob.reductionOrder",6,"&id="+id);
			if(res=='true'){
				alert('驳回成功');
			}
			$('#number').val('');
			setTimeout($.unblockUI, 15);
			reloadPsData();
		}else{
			reloadPsData();
		}
		
		//重载数据
		//reloadGrid2();
		//reloadGrid3();
		/**
		var lsh=$('#lsh').val();
		var res = fetchSingleValue("teljob.checklsit",6,"&lsh="+tsd.encodeURIComponent(lsh));
		if(res<1)
		{
			setTimeout($.unblockUI, 15);
		}*/
	}
	//工单完工录入
	if(key==2)
	{
		var arr = $('#editgrid3').getGridParam('selarrrow');
		var idarr = new Array();
		for(var i = 0 ; i < arr.length  ; i++){
			idarr.push($('#editgrid3').getCell(arr[i],'id'));
		}
		var idstr = idarr.join(',');
		if(idstr!=''){
			$('#idstr').text(idstr);
			//var lsh=$('#lsh').val();
			//var res = fetchSingleValue("teljob.checklsit",6,"&lsh="+tsd.encodeURIComponent(lsh));
			autoBlockForm('theisok', 60, 'close', "#ffffff", false);
		}else{
			alert('请选择要完工的工单');		
		}
	}
}

function reloadGrid3()
{
	var key=$('#lsh').val();
	var urlstr=tsd.buildParams({
		packgname:'service',//java包
		clsname:'ExecuteSql',//类名
		method:'exeSqlData',//方法名
		datatype:'xml',//返回数据格式 
		ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
		tsdcf:'mssql',//指向配置文件名称
		tsdoper:'query',//操作类型 
		tsdpk:'teljob.querylist',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		tsdpkpagesql:'teljob.querylistpage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
	});
   	$("#editgrid3").setGridParam({url:'mainServlet.html?'+urlstr+'&key='+tsd.encodeURIComponent(key)}).trigger("reloadGrid");
}

/**
 *重新加载Grid2
 */
function reloadGrid2()
{
	/**
	overGrid(1);
	// 完工工单jqgrid显示，除admin外，根据用户管理区域控制用户可完工工单
	var userid=$('#userid').val();
	var area = queryarea();
	var sql='teljob.querylsh';
	var sqlpage='teljob.querylshpage';
	if(userid != "admin")
	{
		sql='teljob.querylsh2';
	 	sqlpage='teljob.querylshpage2';
	}
	var urlstr=tsd.buildParams({
		packgname:'service',//java包
		clsname:'ExecuteSql',//类名
		method:'exeSqlData',//方法名
		datatype:'xml',//返回数据格式 
		ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
		tsdcf:'mssql',//指向配置文件名称
		tsdoper:'query',//操作类型 
		tsdpk:sql,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		tsdpkpagesql:sqlpage//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
	});
	$("#editgrid2").setGridParam({url:'mainServlet.html?'+urlstr+'&area='+tsd.encodeURIComponent(area)}).trigger("reloadGrid");
	*/
	//var value8= $("#editgrid2").getCell(keys, "value8");
	//$('#lsh').val(value8);
	
	//可进行批量完工，cl 2012-01-05
	//获取选中行
	var arr = $('#editgrid').getGridParam('selarrrow');
	//判断是否选择工单
	if(arr.length==0){
		alert('请先选择要完工的工单');
		return false;
	}
	//判断选择的工单是否属于同一类型
	var thisvl = '';
	for(var i = 0 ; i < arr.length  ; i++){
		var value8str = $('#editgrid').getCell(arr[i],'value8');
		var gdid=$('#editgrid').getCell(arr[i],'ID');
		if(value8str!=''){
			thisvl += ",'" +gdid+"'";
		}else{
			alert('编号为【'+$('#editgrid').getCell(arr[i],'ID')+'】的工单尚未派工，请先派工');
			return false;
		}
	}
	var val = thisvl.substring(1,thisvl.length);
	if(val!=''){
		reloadGrid(val);
		autoBlockForm('overlist', 10, 'theclose', "#ffffff", false);	
	}else{
		alert('工单尚未派工，请先派工');
	}
}
</script>
			
<style type="text/css">
.titlemargin{margin-left:73px !important;margin-left:38px;}
.tdstyle{border-bottom:1px solid #A9C8D9;}
.spanstyle{display:-moz-inline-box; display:inline-block; width:125px}
.btn_2k3 {
	BORDER-RIGHT: #87CEFA 1px solid; line-height:25px;PADDING-RIGHT: 2px; BORDER-TOP: #87CEFA 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr=#FFFFFF, EndColorStr=#87CEFA); BORDER-LEFT: #87CEFA 1px solid; CURSOR: hand;COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #87CEFA 1px solid
}
</style>
			
  </head>
  
  <body>
  		<form name="childform" id="childform">
			<input type="text" id="queryName" name="queryName" value=""
				style="display: none" />
			<input type="text" id="querysql" name="querysql" 
				style="display: none"/>
			<input type="text" id="fusearchsql" name="fusearchsql"
				style="display: none" />
		</form>
   		<!-- 用户操作导航-->
		<div id="navBar">
			<table width="100%" height="26px" id="navContor">
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
		<div id="displayinfo" style="text-align: left" class="thisunder">
			<!-- 用户操作标题以及放一些快捷按钮-->
			<div id="buttons" style="width: 100%">
				<button type="button" id="queryButton" onclick="openPanl('1')">
					查询工单
				</button>
				<button type="button" id="orderbyfieldButton" onclick="openPanl('2')">
					派发工单
				</button>
				<button type="button" id="overButton" onclick="reloadGrid2()">
					工单完工
				</button>
				<button type="button" id="overButton" onclick="theviewprint2()">
					打印工单
				</button>
			</div>
			<div id="grid1">
				<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0" ></table>
				<div id="pagered" class="scroll" style="text-align: left;"></div>
			</div>
			<div id="grid2">
			<table id="editgrid2" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered2" class="scroll" style="text-align: left;"></div> 
			</div>
		</div>
		<input type="hidden" id="addright" />
		<input type="hidden" id="deleteright" />
		<input type="hidden" id="editright" />
		<input type="hidden" id="editfields" />
		
	
		<input id="key1" type="hidden"/>
		<input id="key2" type="hidden"/>
		<input id="key3" type="hidden"/>
		<input id="key4" type="hidden"/>
		
		<!-- 查询工单面板 -->
		<div class="neirong" id="query" style="display: none;width:720px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">查询工单</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="closethis('query');">关闭</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
					<div class="midd" >
					   <form action="#" name="queryform" id="queryform" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="labelclass">起始时间
								</td>
								<td class="tdstyle" width="20%">
									<input type="text" name="starttime" id="starttime" class="textclass" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss'})"/>
								</td>
								<td class="labelclass">截止时间</td>
								<td class="tdstyle" width="20%">
									<input type="text" name="endtime" id="endtime" class="textclass" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss'})"/>
								</td>
							</tr>
							<tr>
								<td class="dflabelclass">合同号</td>
								<td>
									<input type="text" name="xhth" id="xhth" class="textclass" />
								</td>
									<td class="dflabelclass">电话号码
								</td>
								<td>
									<input type="text" name="phoneno" id="phoneno" class="textclass" />
								</td>
							</tr>
						</table>
						</form>
					</div>	
				
					<div class="midd_butt">
							<button type="submit" class="tsdbutton" id="querythis" onclick="queryInfo()">
								查找
							</button>
							<button type="submit" class="tsdbutton" id="exitquery" onclick="closethis('query')" style="margin-left: 10px">
								退出
							</button>
					</div>
			</div>
			
			
		<!-- 派发工单面板 -->
		<div class="neirong" id="zhipai" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">派发工单</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="closethis('order');">关闭</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
			
					<div class="midd" >
					   <form action="#" name="zhipaiform" id="zhipaiform" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="labelclass">
									处理人员
								</td>
								<td class="tdstyle">
									<div id="dismenulist" style="max-height:200px;overflow-y: auto;overflow-x: hidden;"></div>
								</td>
							</tr>
							<tr>
								<td class="dflabelclass">派工时间</td>
								<td>
									<input type="text" name="pgsj" id="pgsj" class="textclass" style="width:200px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
								</td>
							</tr>
						</table>
						</form>
					</div>
					<div class="midd_butt">
							<button type="submit" class="tsdbutton" id="orderthis" onclick="ordermen()">
								确认
							</button>
							<button type="submit" class="tsdbutton" id="exitorder" onclick="closethis('order')" style="margin-left: 10px">
								退出
							</button>
					</div>
			</div>
		<!-- 打印派工单 -->
		<div class="neirong" id="thedisplayprint"
			style="display: none; width: 100%; margin-left: 50px;width: 640px">
			<div class="top">
				<div class="top_01">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							打印派工单
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#printclose').click();" style="display: none">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color: #FFFFFF;height: 80px">
				<button id="theprint" onclick="theprint()"
					style="margin-left: 10px; margin-top: 20px" class="btn_2k3">
					直接打印
				</button>
				<button id="viewprint" onclick="theviewprint()"
					style="margin-left: 10px;margin-top: 20px" class="btn_2k3">
					打印预览
				</button>
				<button id="printclose"
					style="width: 75px; margin-left: 10px;margin-top: 20px" class="btn_2k3" onclick="reloadPsData()">
					不打印
				</button>
			</div>
			<div class="midd_butt">
			</div>
		<!-- 完工满意度 -->
		<div class="neirong" id="theisok" style="display: none;width:720px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">填写完工满意度</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="closethis('theisok');">关闭</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd" >
					   <form action="#" name="queryform" id="queryform" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr style="line-height: 85px">
								<td class="dflabelclass">
									完工满意度
								</td>
								<td style="width: 120px">
									<input type="radio" name="isok" id="isok" value="1" checked="checked"/>满意
								</td>
								<td style="width: 150px">
									<input type="radio" name="isok" id="isok" value="2"/>基本满意
								</td>
								<td style="width: 150px">
									<input type="radio" name="isok" id="isok" value="3"/>不满意
								</td>
							</tr>
						</table>
						</form>
					</div>	
					<div class="midd_butt">
							<button type="submit" class="tsdbutton" id="querythis" onclick="overorder()">
								确定
							</button>
							<button type="submit" class="tsdbutton" id="exitquery" onclick="closethis('theisok')" style="margin-left: 10px">
								退出
							</button>
					</div>
			</div>
		</div>
		
		<!-- 完工详细信息面板 -->
		<div class="neirong" id="overlist" style="display: none;width:800px;">
		
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
						<div class="top_03" id="titlediv">完工工单</div>
						<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
					</div>
					<div class="top_01right"><a href="#" onclick="closethis('theclose');">关闭</a></div>
				</div>
				<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
			</div>
			<div id="displayinfo3" style="text-align: left;background-color: white;" class="thisunder">
				<table id="editgrid3" class="scroll" cellpadding="0" cellspacing="0" style="" ></table>
				<div id="pagered3" class="scroll" style="text-align: left;"></div>
			</div>
			<div id="buttons" style="width: 100%;margin-top: 0px">
				<button type="button" id="queryButton" onclick="reductionOrder(1)">
					驳回工单
				</button>
				<button type="button" id="orderbyfieldButton" onclick="reductionOrder(2)">
					完工工单
				</button>
				<button type="button" id="theclose">
					关闭
				</button>
			</div>
		</div>
			
		
		<!-- 隐藏域 -->	
		<input type="hidden" id="hidehth"/>
		<input type="hidden" id="thecolumn"/>							
		<input type="hidden" id="theflowno"/>
		<input type="hidden" id="date"/>
		<input type="hidden" id="area"/>
		<input type="hidden" id="hth"/>
		<input type="hidden" id="xdh"/>
		<input type="hidden" id="name"/>
		<input type="hidden" id="lsh"/>
		<input type="hidden" id="id"/>
		<input type="hidden" id="ywlx"/>
		<input type="hidden" id="queryjd"/>
		<input type="hidden" id="queryerea"/>
		<input type="hidden" id="sgnr"/>
		<input type="hidden" id="lsh"/>
		<input type="hidden" id="number"/>
		<input type="hidden" id="thisvalue8"/>
		
		<label id="idstr" style="display: none"></label>
		
		<input type="hidden" id="userid" value="<%=(String)session.getAttribute("userid")%>"/>
		<input type="hidden" id="department" name="department" value='<%=session.getAttribute("departname") %>' />
		<input type="hidden" id="managearea" name="managearea" value='<%=session.getAttribute("managearea") %>'/>
		<iframe id="printReportDirect"  style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>
  </body>
</html>
