<%----------------------------------------
	name: JobFlowDefine.jsp
	author: chenliang
	version: 1.0, 2011-10-31
	description: 		定义工单流程
	modify: 
	
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
    <title><fmt:message key="jobflowdefine.jobflowdefine" /></title>
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
	<!-- 收费结账专用js -->
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<!-- 导入css文件开始 -->
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<!-- 把下拉框变成可复合多选 -->
	<script src="plug-in/MultiSelect/jquery.bgiframe.min.js" type="text/javascript"></script>
	<script src="plug-in/MultiSelect/jquery.multiSelect.js" type="text/javascript"></script>			
	<link href="plug-in/MultiSelect/jquery.multiSelect.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.spanstyle {display: -moz-inline-box;display: inline-block;width: 205px;}
.tdstyle{border-bottom:1px solid #A9C8D9;line-height:32px;}
#deptname1{
			width:150xpx;
			height:14px; 
		}
	
</style>
<script type="text/javascript">

$(function(){
	$('#navBar1').append(genNavv());//获取导航	
	getUserPower();//获取当前登陆工号业务操作权限
	initGrid();//初始化表格数据
	dateEvent();//初始化页面事件
});
function clearList(){
	var list = document.getElementById("cirMode");
	for(var i = list.options.length; i >= 0; i--){
	list.remove(i);
	}
}
function getDeptname(){

		//fieldvalue = $('#check'+prefix+fieldname+suffixW).val();
		var multistr='';
		var mulselectoper = ',';
		$("[name='multiDeptname'][checked]").each(function(){
			multistr +=$(this).val()+mulselectoper;				
		}) ; 
		var len = multistr.lastIndexOf(mulselectoper);
		if(len>0){multistr = multistr.substr(0,len);}
		fieldvalue = multistr;
		return fieldvalue;
}
function initDeptname(param){
		//加载部门
		
		$("#dept").css('display','none');
		$("#deptname").empty();
		//$("#multiDeptname").empty();
		var arealist = fetchMultiArrayValue("JobFlowDefine.queryBm",6,param);
		if(arealist[0]!=undefined && arealist[0][0]!=undefined)
		{
			optHtml = "";
			optHtml += '<select id="multiDeptname" name="multiDeptname" class="textclass" style="width: 150px;">';
			optHtml +="<option value=''>请选择</option>"
			for(var i=0;i<arealist.length;i++)
			{
				optHtml += "<option align=\"center\" areaid=\"" + arealist[i][1] + "\" tval=\"" + arealist[i][1] + "\" value=\"" + arealist[i][0] + "\">" + arealist[i][1] + "</option>";
				
			}
			optHtml +='</select><font style="color:red;">*</font>';
			//$("#multiDeptname").html(optHtml);
			$("#multiDept").html(optHtml);
			$("#multiDept").css('display','block');
			
			$("#multiDeptname").multiSelect({ oneOrMoreSelected: '*'},'','deptname1',',');
			$("#multiDeptname").next(".multiSelectOptions").find(":checkbox:checked").attr("checked","false");
			$("#multiDeptname").next(".multiSelectOptions").find(".selectAll:first").hide();
			//alert($("#deptname").next(".multiSelectOptions").find(":checkbox:checked").size());
		}
} 

//初始化页面事件
function dateEvent(){
 	//业务类别，关联业务类别加载业务类型
	$('#busiclass').change( function(){
		var busiclass = $('#busiclass').val();
		if(busiclass!=''){
			initOption('#busitype','initOption.ywsl_type','&typeid='+busiclass);//业务类型
		}
 	});
 	//业务类别说明
	$('#busiclass').focus( function(){
		//$('#fieldmemo').text($('#sbusiclass').text()+'，流程所属的业务类别，例如是电话还是宽带。');
		$('#fieldmemo').text($('#sbusiclass').text()+"<fmt:message key='jobflowdefine.busitype' />");
 	});
 	//业务类型，重新业务类型时选择业务流转区域和部门
 	$('#busitype').change( function(){
 		$('#flowarea,#deptname,#flowno,#multiDeptname').val('');
 	});
 	//业务类型说明
	$('#busitype').focus( function(){
		//$('#fieldmemo').text($('#sbusitype').text()+'，流程所属的业务类型，与业务类别相关，例如是定义固话业务的装机流程。');
		$('#fieldmemo').text($('#sbusitype').text()+"<fmt:message key='jobflowdefine.busitypeExplain' />");
 	});
 	//显示业务区域可选列表
 	$('#ywarea').focus( function(){
 		$('#ywarealistdiv').show();
 		//$('#fieldmemo').text($('#sywarea').text()+'，整条流程所属的业务区域，可进行多选和全选。');
 		$('#fieldmemo').text($('#sywarea').text()+"<fmt:message key='jobflowdefine.areaChooseandselectall' />");
 	});
	//关联流转区域加载节点部门
 	$('#flowarea').change( function(){
		var flowarea = $('#flowarea').val();
		if(flowarea!=''){
			initOption('#cirMode','JobFlowDefine.queryMode','');//流转方式	
		}
 	});
 	//流转区域字段说明
 	$('#flowarea').focus( function(){
 		//$('#fieldmemo').text($('#sflowarea').text()+'，当前节点流转的业务区域，可进行跨区域流转。');
 		$('#fieldmemo').text($('#sflowarea').text()+"<fmt:message key='jobflowdefine.areaCrossregionaltransfer' />");
 		
 	});
 	//关联流转方式加载节点部门
 	$('#cirMode').change( function(){
		var flowarea = $('#flowarea').val();
		var cirMode  = $('#cirMode').val();
		if(cirMode=='single'){
			$("#multiDept").css('display','none');
			$("#dept").css('display','block');  
			$("#condDiv").css('display','none');
			if(flowarea!=''){
				initOption('#deptname','JobFlowDefine.queryBm','&ywarea='+
					tsd.encodeURIComponent($("#flowarea option[selected]").text()));//当前流转部门	
			}
		}else if(cirMode=='condition'){
			$("#multiDept").css('display','block');
			$('#condDiv').css('display','block');
			initDeptname('&ywarea='+
					tsd.encodeURIComponent($("#flowarea option[selected]").text()));
		}else{
			$("#multiDept").css('display','block');
			$("#condDiv").css('display','none');
			initDeptname('&ywarea='+
					tsd.encodeURIComponent($("#flowarea option[selected]").text()));
		}
 	});
 	$('#cirMode').focus( function(){
 		//$('#fieldmemo').text($('#sflowarea').text()+'，当前节点流转的业务区域，可进行跨区域流转。');
 		$('#fieldmemo').text($('#sCirMode').text()+'，当前节点流转的业务区域，可进行跨区域流转。');
 		
 	});
 	//选择完部门加载整条工单超时时间
 	$('#deptname').change( function(){
		var deptname = $('#deptname').val();	//节点业务处理部门
		var busiclass = $('#busiclass').val();	//业务类别
		var ywarea = $('#ywarea').val();		//所属区域
		var busitype = $('#busitype').val();	//业务类型
		var flowarea = $('#flowarea').val();	//流转区域
		if(deptname!='' && busiclass!='' && ywarea!='' && busitype!='' && flowarea!=''){
			//var dateparams = busiclass+ywarea+busitype+flowarea+deptname;
			var dateparams = busiclass+ywarea+busitype;
			var res = fetchSingleValue('JobFlowDefine.datavail',6,'&params='+tsd.encodeURIComponent(dateparams));				
			if(res == undefined || res==''){
				$('#flowno').val(1);
				$('#t_timeout').removeAttr('disabled');
			}else{
				//$('#flowno').val(parseInt(res)+1);
				$('#t_timeout').attr('disabled','disabled');
			}
		}
 	});
 	//流转区域字段说明
 	$('#deptname').focus( function(){
 		//$('#fieldmemo').text($('#sdeptname').text()+'，当前节点流转的部门，与流转区域相关。');
 		$('#fieldmemo').text($('#sdeptname').text()+"<fmt:message key='jobflowdefine.deptareacorrelation' />");
 	});
 	$('#multiDeptname').focus( function(){
 		//$('#fieldmemo').text($('#sdeptname').text()+'，当前节点流转的部门，与流转区域相关。');
 		$('#fieldmemo').text($('#sdeptname').text()+"<fmt:message key='jobflowdefine.deptareacorrelation' />");
 	});
	//流程节点
	$('#flowno').change( function(){
		var deptname = $('#deptname').val();	//节点业务处理部门
		var multiDeptname =$('#multiDeptname').val();
		var dept='';
		if(deptname!='' ||multiDeptname!=''){
			var dept='1';
		}
		var busiclass = $('#busiclass').val();	//业务类别
		var ywarea = $('#ywarea').val();		//所属区域
		var busitype = $('#busitype').val();	//业务类型
		var flowarea = $('#flowarea').val();	//流转区域
		if(dept!='' && busiclass!='' && ywarea!='' && busitype!='' && flowarea!=''){
			var dateparams = busiclass+ywarea+busitype;
			var res = fetchSingleValue('JobFlowDefine.datavail',6,'&params='+tsd.encodeURIComponent(dateparams));				
			if(res == undefined || res==''){
				//alert('当前配置的流程，暂无初始节点，请从1开始配置');
				alert("<fmt:message key='jobflowdefine.Fromthestart' />");
				$('#flowno').val(1);
				$('#t_timeout').removeAttr('disabled');
			}else{
				var flowno = $('#flowno').val();
				if(flowno==res){
					//alert('当前流程已配置该节点的流转信息，请重新配置');
					alert("<fmt:message key='jobflowdefine.Theconfigured' />");
					$('#flowno').focus();
				}
			}
		}
		$('#flowno').val()!=1?$('#st_timeout,#t_timeout').hide():$('#st_timeout,#t_timeout').show();
 	});
 	//流转区域字段说明
 	$('#flowno').focus( function(){
 		//$('#fieldmemo').text($('#sflowno').text()+'，当前流程所属的节点，必须按顺序进行定义，否则工单将无法正常进行流转。');
 		$('#fieldmemo').text($('#sflowno').text()+"<fmt:message key='jobflowdefine.Circulationareafielddescription' />");
 	});
 	//能否撤销
	$('#cancancel').focus( function(){
		//$('#fieldmemo').text($('#scancancel').text()+'，当前所属流程节点部门是否可对正在进行流转的工单发起撤销申请。');
		$('#fieldmemo').text($('#scancancel').text()+"<fmt:message key='jobflowdefine.checkRevoke' />");
 	});
 	//能否完工
	$('#cancomplete').focus( function(){
		//$('#fieldmemo').text($('#scancomplete').text()+'，当前所属流程节点部门是否可对正在进行流转的工单进行完工操作。');
		$('#fieldmemo').text($('#scancomplete').text()+"<fmt:message key='jobflowdefine.checkTobefinished' />");
 	});
 	//部门预警
	$('#d_waring').focus( function(){
 		//$('#fieldmemo').text($('#sd_waring').text()+'，当工单流转到当前流转部门，工单所在部门快要超时时提前进行工单预警，提示管理人员尽快处理。');
 		$('#fieldmemo').text($('#sd_waring').text()+"<fmt:message key='jobflowdefine.checkThejobEarlywarning' />");
 	});
 	//部门超时
	$('#d_timeout').focus( function(){
 		//$('#fieldmemo').text($('#sd_timeout').text()+'，当工单流转到当前流转部门，部门超时时间。');
 		$('#fieldmemo').text($('#sd_timeout').text()+"<fmt:message key='jobflowdefine.checkThedepttimeout' />");
 	});
 	//工单超时
	$('#t_timeout').focus( function(){
 		//显示字段说明
 		//$('#fieldmemo').text($('#st_timeout').text()+'，当前配置流程的整条工单超时时间，当流程节点为1时才可进行编辑。');
 		$('#fieldmemo').text($('#st_timeout').text()+"<fmt:message key='jobflowdefine.checkThejobtimeout' />");
 	});
 	//业务类别，流程所属的业务类别，例如是电话还是宽带。
 	$('#fieldmemo').text("<fmt:message key='jobflowdefine.businesstype' />");
 	//点击保存添加，保存退出，修改按钮时触发的事件
 	$("#saveadd").click( function(){saveInfo(1);});
 	$("#saveexit").click( function(){saveInfo(2);});
 	$("#modify").click( function(){saveInfo(3);});
 	$("#close").click( function(){$('#dateparams').val('')});
 	$("#condSqlBtn").click( function(){$("#condDiv").hide();$("#hidMode").val($("#condSql").val());$("#condSql").val("")});
}
//获取用户权限
function getUserPower()
{
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', clsname : 'Procedure', method : 'exequery', ds : 'tsdBilling', 
        tsdpname : 'jobProcessManager.getPower',tsdExeType : 'query', datatype : 'xmlattr' 
    });
    //添加，修改，删除权限
    var addright = '';
    var deleteright = '';
    var editright = '';
    var flag = false;
    var spower = '';
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&userid=<%=userid %>&groupid=<%=groupid %>&menuid=<%=imenuid %>', 
        datatype : 'xml', cache : false,timeout : 2000, async : false , 
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
        }
    }else if (spower == 'all@')
    {
        $('#openadd1').removeAttr('disabled');
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
                $('#openadd1').removeAttr('disabled');
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
}
//初始化表格数据
function initGrid(){
	var urlstr = tsd.buildParams(
    {
        packgname : 'service',clsname : 'ExecuteSql',method : 'exeSqlData', 
        ds : 'tsdBilling',tsdcf : 'mssql',tsdoper : 'query',datatype : 'xml',  
        tsdpk : 'JobFlowDefine.query',tsdpkpagesql : 'JobFlowDefine.querypage'
    });
    var column = '';
    var thisdata = loadData('v_jobflowdefine', '<%=lanType  %>', 1 , "<fmt:message key='jobflowdefine.editdeletedetails' />");
    column = thisdata.FieldName.join(',');
    $('#column').val(column);
    thisdata.setWidth({Operation : 108});
    //设置值隐藏，不显示
    thisdata.colModels[1].hidden=true;
    thisdata.colModels[10].hidden=true;
    thisdata.colModels[11].hidden=true;
    thisdata.colModels[12].hidden=true;
    //thisdata.colModels[13].hidden=true;
    jQuery("#editgrid").jqGrid(
    {
        url : 'mainServlet.html?' + urlstr + '&cloumn=' + column, datatype : 'xml', colNames : thisdata.colNames, 
        colModel : thisdata.colModels, rowNum : 15,rowList : [10, 15, 20],
        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images/', pager : jQuery('#pagered'),
        sortname : 'busiclass desc,busitype,flowno',viewrecords : true,sortorder : 'asc',caption : '工单流程定义',
        height : document.documentElement.clientHeight - 152,
        //width : document.documentElement.clientWidth - 42,
        loadComplete : function ()
        {
    	  	if ($("#editgrid tr.jqgrow[id='1']").html() == "") { return false;}
            addRowOperBtn('editgrid', '<img src="style/images/public/ltubiao_01.gif" alt="'+'<fmt:message key="jobflowdefine.edit" />'+'"/>', 'openRowModify','ID', 'click', 1);
            addRowOperBtn('editgrid', '<img src="style/images/public/ltubiao_02.gif" alt="'+'<fmt:message key="jobflowdefine.delete" />'+'"/>', 'deleteRow','ID','click', 2);
            addRowOperBtn('editgrid', '<img src="style/images/public/ltubiao_03.gif" alt="'+'<fmt:message key="jobflowdefine.details" />'+'"/>', 'detailRow','ID','click', 3);
            executeAddBtn('editgrid', 3);
        }
	}).navGrid('#pagered', {edit : false, add : false, add : false, del : false, search : false});	
}

//动态加载面板下拉和可选值
function initPanel(){
	initFields('v_jobflowdefine','<%=lanType %>');//初始化字段
	//初始化流程节点可选序号
	$('#flowno').empty();
	var res = fetchSingleValue('initOption.tsdini',6,'&tsection=MaxFlowNo');
	//$('#flowno').append('<option value="">请选择</option>');
	$('#flowno').append('<option value=""><fmt:message key="jobflowdefine.choose" /></option>');
	for(var i = 1 ; i <= res;i++){ 
		$('#flowno').append('<option value=' + i + '>' + i + '</option>');
	}
	initOption('#busiclass','initOption.ywsl_code','');//初始化业务类别下拉列表
	initCheckboxs('#ywarealist','initOption.ywarea','','chkywarea',4,'');//初始化业务区域列表
	initOption('#flowarea','initOption.ywarea','');//初始化流程区域下拉列表
	initOption('#cancancel,#cancomplete','initOption.tsdini','&tsection=IfCan');//初始化能否撤销下拉列表
	//initOption('#cancomplete','initOption.tsdini','&tsection=IfCan');//初始化能否完工下拉列表
}

//初始化字段
function initFields(tbname,languageType){
	var tbFields = fetchFieldAlias(tbname, languageType);
    var thisdata = loadData(tbname, languageType, 2, '');
    var column = thisdata.FieldName.join(',');
    var arr = column.split(',');
    for(var i = 0 ; i < arr.length;i++){
    	if(document.getElementById('s'+arr[i].toLowerCase())!=null){
    		$('#s'+arr[i].toLowerCase()).text(tbFields[arr[i]]);
    	}
    }
}
//打开面板
function openText()
{ 
	clearList();
	$("#addOrEdit").val(1);
	initPanel();
	clearText('operform');//清空已填写数据
	isEnabled(1);//是否可编辑
	$('#st_timeout,#t_timeout').show();
	//$('input:checkbox').removeAttr('disabled');//移除复选框不可用状态
	//$('input:checkbox').removeAttr('checked');//清空已选值
	$('#t_timeout').removeAttr('disabled');//整条工单超时时间可编辑
	$('#ywarealistdiv').hide();//隐藏业务区域列表
    //$('#titlediv').html('添加');
    $('#titlediv').html("<fmt:message key='jobflowdefine.add' />");
    $("#saveadd").show();
    $("#saveexit").show();
    $("#modify").hide();
    autoBlockForm('add', 10, 'close', "#ffffff", false);
}
//设置是否可编辑状态
function isEnabled(key){
    var column = $('#column').val();
    var arr = column.split(',');
    for(var i = 0 ; i < arr.length;i++){
    	if(document.getElementById('s'+arr[i].toLowerCase())!=null){
    		if(key==1){
    			$('#'+arr[i].toLowerCase()).removeAttr("disabled");
    		}else{
    			$('#'+arr[i].toLowerCase()).attr("disabled","disabled");
    		}
    	}
    }
}
//初始化下拉框
function initOption(ids,tsdsql,params)
{
	var months = fetchMultiArrayValue(tsdsql,6,params);
	if(months[0]!=undefined){
		if(months[0].length<1)
			return false;
		$(ids).empty();
		//var tips = '请选择';
		var tips = "<fmt:message key='jobflowdefine.choose' />";
		if(ids=='flowarea'){
			//tips = '不限制';
			tips = "<fmt:message key='jobflowdefine.Notrestricted' />";
		}
		$(ids).append("<option value=''>"+tips+"</option>");
		$.each(months,function(i,n){
			$(ids).append("<option value=\"" + n[0] + "\">" + n[1] + "</option>");
		});
	}
}
//打开修改面板
function openRowModify(key){
	$("#addOrEdit").val(2);
	$("#multiDeptname").css('display','none'); 
	$("#deptname").css('display','block');
	var editRight = $('#editright').val();
	if(editRight=='true'){
		//$('input:checkbox').removeAttr('disabled');//复选框可用
		//$('input:checkbox').removeAttr('checked');//清空已选值
		initPanel();
		isEnabled(1);//可编辑
		clearText('operform');
	    //$('#titlediv').html("修改");
	    $('#titlediv').html("<fmt:message key='jobflowdefine.edit' />");
	    $("#saveadd").hide();
	    $("#saveexit").hide();
	    $("#modify").show();
		//FlowNo,BusiClass,YwArea,BusiType,DeptName,Cancancel,Cancomplete,D_waring,D_timeout,T_timeout,PictureName
		var res = fetchMultiArrayValue('JobFlowDefine.querybykey',6,'&id='+key);//查询流程信息，进行数据回显
		var sendMode=fetchSingleValue('hponeDAM.setTValues',6,'&TSection=workflowMode'+'&TIdent='+res[0][11]);
		$("#cirMode").append("<option value=''>"+sendMode+"</option>");
		initOption('#busitype','initOption.ywsl_type','&typeid='+res[0][1]);//业务类型		
		$('#flowno').val(res[0][0]);$('#busiclass').val(res[0][1]);
		$('#ywarea').val(res[0][2]);forChecked('chkywarea',res[0][2]);
		$('#busitype').val(res[0][3]);
		//FlowNo,BusiClass,YwArea,BusiType,DeptName,Cancancel,Cancomplete,D_waring,D_timeout,T_timeout,PictureName
		var bmres = fetchMultiArrayValue('JobFlowDefine.queryFlowBm',6,'&id='+res[0][4]);//查询流程信息，进行数据回显
		$('#flowarea').val(bmres[0][1]);
		initOption('#deptname','JobFlowDefine.queryBm','&ywarea='+tsd.encodeURIComponent($("#flowarea option[selected]").text()));
		$('#deptname').val(bmres[0][0]);
		$('#cancancel').val(res[0][5]);$('#cancomplete').val(res[0][6]);$('#d_waring').val(res[0][7]);
		if(res[0][0]!=1){
			$('#t_timeout').attr('disabled','disabled');
		}else{
			$('#t_timeout').removeAttr('disabled');
		}
		$('#d_timeout').val(res[0][8]);$('#t_timeout').val(res[0][9]);$('#picturename').val(res[0][10]);
		$('#keyid').val(key);
		$('#ywarealistdiv').show();
		//$('#flowno').val()+$('#busiclass').val()+$('#ywarea').val()+$('#busitype').val()
		$('#dateparams').val(res[0][0]+res[0][1]+res[0][2]+res[0][3]+res[0][4]);
		
		//显示修改面板
	    autoBlockForm('add', 10, 'close', "#ffffff", false);
	}else{
		//alert('当前工号所在的权限组无修改权限');
		alert("<fmt:message key='jobflowdefine.checkeditJurisdiction' />");
		
	}
}
//查看详细
function detailRow(key){
	$("#addOrEdit").val(2);
	$("#multiDeptname").css('display','none'); 
	$("#deptname").css('display','block');
	clearText('operform');
	//$('input:checkbox').removeAttr('checked');//清空已选值
    initPanel();
    $('input:checkbox').attr('disabled','disabled');
     //$('#titlediv').html('详细信息');
     $('#titlediv').html("<fmt:message key='jobflowdefine.message' />");
    
    $("#saveadd").hide();
    $("#saveexit").hide();
    $("#modify").hide();
	//返回字段：FlowNo,BusiClass,YwArea,BusiType,FlowArea,DeptName,Cancancel,Cancomplete,D_waring,D_timeout,T_timeout,PictureName
	var res = fetchMultiArrayValue('JobFlowDefine.querybykey',6,'&id='+key);//查询流程信息，进行数据回显
	initOption('#busitype','initOption.ywsl_type','&typeid='+res[0][1]);//业务类型		
	$('#flowno').val(res[0][0]);$('#busiclass').val(res[0][1]);
	$('#ywarea').val(res[0][2]);forChecked('chkywarea',res[0][2]);
	$('#busitype').val(res[0][3]);
	//返回字段：BM,AREA
	var ress = fetchMultiArrayValue('JobFlowDefine.queryFlowBm',6,'&id='+res[0][4]);//查询流程信息，进行数据回显
	$('#flowarea').val(ress[0][1]);
	initOption('#deptname','JobFlowDefine.queryBm','&ywarea='+tsd.encodeURIComponent($("#flowarea option[selected]").text()));
	$('#deptname').val(ress[0][0]);
	$('#cancancel').val(res[0][5]);$('#cancomplete').val(res[0][6]);$('#d_waring').val(res[0][7]);
	$('#d_timeout').val(res[0][8]);$('#t_timeout').val(res[0][9]);$('#picturename').val(res[0][10]);
	$('#keyid').val(key);
	isEnabled(2);//不可编辑，只读
	$('#ywarealistdiv').show();
    autoBlockForm('add', 10, 'close', "#ffffff", false);
}

//拼接参数
function buildParams(){
	tsd.QualifiedVal = true;
	var params = '';
	//flowno,busiclass,ywarea,busitype,flowarea,deptname,cancancel,cancomplete,d_waring,d_timeout,t_timeout,picturename
	var arr = new Array('flowno','busiclass','busitype','flowarea','deptname','cancancel','cancomplete');
	for(var i = 0 ; i < arr.length;i++){
		var sval = $('#'+arr[i]).val();
		if(sval==''){
			//alert($('#s'+arr[i]).text()+'不允许为空');
			alert($('#s'+arr[i]).text()+"<fmt:message key='jobflowdefine.Notnull' />");
			
			sbool = true;
			$('#'+arr[i]).focus();
			return false;
		}else{
			if(arr[i]=='deptname'){
				//sval = $("#deptname option[selected]").text()
				sval = $("#deptname").val();
			}
			params += '&'+arr[i]+'='+tsd.encodeURIComponent(sval);
		}
	}
	//数据完整性校验，参数格式：
	//flowno||busiclass||ywarea||busitype||flowarea||deptname
	var dateparams = $('#flowno').val()+$('#busiclass').val()+$('#ywarea').val()+$('#busitype').val();
	var newdateparams = dateparams+$('#deptname').val();
	var olddateparams = $('#dateparams').val();
	//alert(newdateparams+'@'+olddateparams);
	//是添加还是修改，待解决问题：判断序号是否按顺序增加
	if(newdateparams!=olddateparams){
		var valChecked = fetchMultiArrayValue('JobFlowDefine.datacheck',6,'&params='+tsd.encodeURIComponent(dateparams)
				   + '&flowarea='+tsd.encodeURIComponent($('#flowarea').val()) + '&deptname='+$('#deptname').val());
		//alert(valChecked);   
		if(valChecked[0][0]!=0){
			//alert('要添加的流程数据已存在，不可重复添加');
			alert("<fmt:message key='jobflowdefine.Dataalreadyexists' />");
			return false;
		}
	}
	if (tsd.Qualified() == false) {
        return false;
    }
    //部门告警时间，部门超时时间，工单超时时间，流程图文件，业务区域(可不选，'*'表示不限制流程区域)
    var d_waring = $('#d_waring').val()==''?'12':$('#d_waring').val();
    var d_timeout = $('#d_timeout').val()==''?'24':$('#d_timeout').val();
    var t_timeout = $('#t_timeout').val()==''?'72':$('#t_timeout').val();
    var pname = $('#picturename').val()==''?'*':$('#picturename').val();
    var ywarea = $('#ywarea').val() ==''?'*':$('#ywarea').val();
    var condsql=$("#hidMode").val()==''?'':$("#hidMode").val();
    params += '&d_waring='+d_waring;
    params += '&d_timeout='+d_timeout;
    params += '&t_timeout='+t_timeout;
    params += '&pname='+tsd.encodeURIComponent(pname);
    params += '&ywarea='+tsd.encodeURIComponent(ywarea);
    params += '&sendmode='+tsd.encodeURIComponent($('#cirMode').val());
    params += '&cond_choose='+tsd.encodeURIComponent(condsql);
    return params;
}

//执行保存调用的方法
function saveInfo(key){
	var params = buildParams();
	var oneOrMore='one';
	if($("#deptname").val()==null){
		params = params.replace("&deptname=null","");
		oneOrMore='More';
	}
	if (params == false) {
        return false;
    }
    var res = '';
	if(key==1 || key==2){//保存添加或保存退出
		if(oneOrMore=='More'){
			var getDept =getDeptname();
			var getDepts = getDept.split(',');
			for(var i = 0 ; i < getDepts.length;i++){
				res = executeNoQuery("JobFlowDefine.insert",6,params+'&deptname='+getDepts[i]);
				if(res=='false'){
					return false;
				}
			}
		}else{
			res = executeNoQuery("JobFlowDefine.insert",6,params);
		}
	}else if(key==3){//修改
		var keyid = $('#keyid').val();
		if(oneOrMore=='More'){
			var getDept =getDeptname();
			var getDepts = getDept.split(',');
			for(var i = 0 ; i < getDepts.length;i++){
				res = executeNoQuery("JobFlowDefine.update",6,params+'&id='+keyid+'&deptname='+getDepts[i]);
				if(res=='false'){
					return false;
				}
			}
		}else{
			res = executeNoQuery("JobFlowDefine.update",6,params+'&id='+keyid);
		}

	}
	if(res=='true'){
		//alert('操作成功');
		alert("<fmt:message key='jobflowdefine.operationSuccess' />");
		if(key!=1){//保存退出，刷新数据
			reloadData();		
		}else{//保存添加，保存数据成功，清空已填写数据
			$('#fieldmemo').text('');
			$('input:checkbox').removeAttr('checked');
			clearText('operform');
			$("#editgrid").trigger("reloadGrid");
		}
	}else{
		//alert('流程配置有误，请检查配置');
		alert("<fmt:message key='jobflowdefine.Processconfigurationerror' />");
	}
}

//删除记录
function deleteRow(keyid){
	var deleteRight = $('#deleteright').val();
	if(deleteRight=='true'){
		//if(confirm('确认要删除此条信息吗？')){
		if(confirm("<fmt:message key='jobflowdefine.Whetherdelete' />")){
			var res = executeNoQuery("JobFlowDefine.delete",6,'&id='+keyid);
			if(res=='true'){
				//alert('操作成功');
				alert("<fmt:message key='jobflowdefine.operationSuccess' />");
				reloadData();
			}else{
				//alert('操作失败');
				alert("<fmt:message key='jobflowdefine.operationfailed' />");
			}
		}
	}else{
		//alert('当前工号所在的权限组无删除权限');
		alert("<fmt:message key='jobflowdefine.checkdeleteJurisdiction' />");
	}
}
//执行复合查询出提交过来的相应操作
function fuheExe()
{
    var queryName = $('#queryName').val();
    if (queryName == "query") {
        fuheQuery('JobFlowDefine.querybywhere', 'JobFlowDefine.querybywherepage');
    }
}
//数据查询
function fuheQuery(querysql,querypagesql)
{
	var params = fuheQbuildParams();			
	if(params=='&fusearchsql='){
		params +='1=1';
	}
	var urlstr1=tsd.buildParams({  packgname:'service',//java包
								  clsname:'ExecuteSql',//类名
								  method:'exeSqlData',//方法名
								  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
								  tsdcf:'mssql',//指向配置文件名称
								  tsdoper:'query',//操作类型 
								  datatype:'xml',//返回数据格式 
								  tsdpk:querysql,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								  tsdpkpagesql:querypagesql
								});
	var link = urlstr1 + params+'&lang=<%=lanType %>';	
	var thecolumn = $('#column').val();
 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&cloumn='+thecolumn}).trigger("reloadGrid");
 	setTimeout($.unblockUI, 15);//关闭面板			
}

//刷新数据
function reloadData()
{
	setTimeout($.unblockUI, 15);
    var urlstr = tsd.buildParams(
    {
        packgname : 'service',clsname : 'ExecuteSql',method : 'exeSqlData', 
        datatype : 'xml',ds : 'tsdBilling',tsdcf : 'mssql', 
        tsdoper : 'query',tsdpk : 'JobFlowDefine.query',tsdpkpagesql : 'JobFlowDefine.querypage'
    });
    var column = $('#column').val();
    $("#editgrid").setGridParam({url : 'mainServlet.html?' + urlstr + '&cloumn=' + 
    										tsd.encodeURIComponent(column)}).trigger("reloadGrid");
}

//初始化CheckBox
function initCheckboxs(ids,tsdsql,params,checkboxname,num,operflag)
{
	var months = fetchMultiArrayValue(tsdsql,6,params);
	if(months[0].length<1)
		return false;
	$(ids).empty();
	var x = 1;
	$.each(months,function(i,n){
		var thebr = '';
        if (x * 1 % num == 0) {
        	thebr = '<br/>';
        }
		$(ids).append("<span class='spanstyle'><input type='checkbox' onclick=initOnClick("+operflag+") name='"+checkboxname+"' value='" 
								+ n[0] + "' style='width:15px;height:15px;'><label style='text-align: left;margin-left:5px'>" 
								+ n[1] + "</label></span>" + thebr);
		x++;
	});
	//var str = x * 1 % num == 0?'<br/>':'';
	//alert(str);
	//不限制区域
	var chtml = "<span class='spanstyle'><input type='checkbox' name='chklimit' id='noarealimit' onclick=initOnClick('*') value='*' style='width:15px;height:15px;'>"
				+"<label style='text-align: left;margin-left:5px'><fmt:message key='jobflowdefine.Notrestrictedarea' /></label></span>";
	$(ids).append(chtml);
}
//默认选择值
function forChecked(name, thisvalue)
{
    if ('' != thisvalue && null != thisvalue)
    {
    	var tagname = document.getElementsByName(name);
    	if(thisvalue.indexOf('~')!=-1){
    		var thearr = thisvalue.split('~');
	        for(var i = 0 ; i < thearr.length;i++){
	        	for(var j = 0 ; j < tagname.length;j++){
	        		if (tagname[j].value == thearr[i]) {
	                    tagname[j].checked = true;
	                    break;
	                }
	        	}
	        }
    	}else{
    		for(var j = 0 ; j < tagname.length;j++){
	       		if (tagname[j].value == thisvalue) {
	                    tagname[j].checked = true;
	                    break;
	            }
	        }
    	}    
    }
}
//获取被选中的值
function getTheChecked(name)
{
    var thename = document.getElementsByName(name);
    var thevalue = '';
    for (var i = 0; i < thename.length; i++) {
        if (thename[i].checked == true) {
            thevalue += thename[i].value + '~';
        }
    }
    var num = thevalue.lastIndexOf('~');
    thevalue = thevalue.substring(0, num);
    if (thevalue.indexOf('~') == 0) {
        thevalue = thevalue.substring(1, thevalue.length);
    }
    return thevalue;
}
//点击复选框触发的事件
function initOnClick(operflag){
	if(operflag=='' || operflag==undefined){
		var res = getTheChecked('chkywarea');
		$('#ywarea').val(res);
		$('#flowarea,#deptname,#flowno').val('');	
	}else{
		if($('#noarealimit').attr('checked')){
			$("input[name='chkywarea']").attr("checked","checked");
			$("input[name='chkywarea']").attr("disabled","disabled");
			$('#ywarea').val('*');		
		}else{
			$("input[name='chkywarea']").removeAttr("checked");
			$("input[name='chkywarea']").removeAttr("disabled");
			$('#ywarea').val('');
		}
	}
}

</script>
</head>
 
<body>
	<jsp:include page="Nav.jsp"  flush="true" />
	<div id="buttons" style="margin-top: 0px">
			<button type="button" id="openadd1" onclick="openText()" disabled="disabled">
				<fmt:message key="global.add" />
			</button>
			<button type="button" onclick="openDiaQueryG('query','v_jobflowdefine')">
				<fmt:message key="global.query" />
			</button>
			<button type="button" id="exp1" style="display: none" onclick="thisDownLoad('tsdBilling','mssql','v_jobflowdefine','<%=lanType%>',6)" >
				<fmt:message key="global.exportdata" />
			</button>
	</div>
	<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
	<div id="pagered" class="scroll" style="text-align: left;"></div>
	
	<!-- 添加和修改面板 -->
	<div class="neirong" id="add" style="display: none;width:830px">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
					<div class="top_03" id="titlediv"></div>
					<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
				</div>
				<div class="top_01right"><a href="#" onclick="javascript:$('#close').click();">
				<!-- 关闭 -->
				<fmt:message key="jobflowdefine.close" />
				</a></div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
		</div>
		<div class="midd" >
			<form action="#" name="operform" id="operform" onsubmit="return false;">
				<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="labelclass" id="sbusiclass"></td>
						<td width="20%" class="tdstyle">
							<select id="busiclass" class="textclass" style="width: 150px"></select>
							<font style="color:red;">*</font>
						</td>	
						<td class="labelclass" id="sbusitype"></td>
						<td width="20%" class="tdstyle">
							<select id="busitype" class="textclass" style="width: 150px"></select><font style="color:red;">*</font>
						</td>		
						<td class="labelclass" id="sywarea"></td>
						<td width="20%" class="tdstyle">
							<input type="text" name="ywarea" id="ywarea" class="textclass" style="width: 145px" disabled="disabled" />
							<font style="color:red;">*</font>
						</td>
					</tr>
					<tr id="ywarealistdiv" style="display: none">
						<td colspan="6">
							<div id="ywarealist" style="max-height: 200px; overflow-y: auto; overflow-x: hidden; background-color: #ffffff;width: 100%">
							</div>
						</td>
					</tr>
					<tr>
						<td class="labelclass" id="sflowarea"></td>
						<td width="20%" class="tdstyle">
							<select id="flowarea" class="textclass" style="width: 150px"></select><font style="color:red;">*</font>
						</td>			
						<td class="labelclass" id="sCirMode">流转方式</td>
						<td width="20%" class="tdstyle">
							<select name="cirMode" id="cirMode"  class="textclass" style="width: 150px">
							</select><font style="color:red;">*</font>
						</td>
						<td class="labelclass" id="sdeptname"></td>
						<td width="20%" class="tdstyle">
							<div id='dept'>
							<select id="deptname" name="deptname" class="textclass" style="width: 150px"></select><font style="color:red;">*</font>
							</div>
							<div style="display:none" id='multiDept'>
							
							</div>
						</td>
					</tr>
					<tr id="condDiv" style="display: none;text-align:center;">
						<td colspan="6">
							<div id="condSqlDiv" style="max-height: 200px; overflow-y: auto; overflow-x: hidden; background-color: #ffffff;width: 100%;">
								<input type='text' id='condSql' style='width:400px;'/>&nbsp;&nbsp; <input type='button' id='condSqlBtn'  style='width:40px;' value='确&nbsp;定'/> 
							</div>
						</td>
					</tr>
					<tr>
						<!-- 
						<td class="labelclass" id="sjobtype"></td>
						<td width="20%" class="tdstyle">
							<input type="text" name="jobtype" id="jobtype" class="textclass" disabled="disabled" />
						</td>
						 -->
						<td class="labelclass" id="sflowno"></td>
						<td width="20%" class="tdstyle">
							<select id="flowno" class="textclass" style="width: 150px"></select><font style="color:red;">*</font>
						</td>
						<td class="labelclass" id="scancancel"></td>
						<td width="20%" class="tdstyle">
							<select id="cancancel" class="textclass" style="width: 150px;"></select><font style="color:red;">*</font>
						</td>			
						<td class="labelclass" id="scancomplete"></td>
						<td width="20%" class="tdstyle">
							<select id="cancomplete" class="textclass" style="width: 150px"></select><font style="color:red;">*</font>
						</td>
					</tr>
					<tr>
						<td class="labelclass" id="sd_waring"></td>
						<td width="20%" class="tdstyle">
							<input type="text" name="d_waring" id="d_waring" class="textclass" disabled="disabled" />
						</td>
						<td class="labelclass" id="sd_timeout"></td>
						<td width="20%" class="tdstyle">
							<input type="text" name="d_timeout" id="d_timeout" class="textclass" disabled="disabled" />
						</td>			
						<td class="labelclass"><span id="st_timeout"></span></td>
						<td width="20%" class="tdstyle">
							<input type="text" name="t_timeout" id="t_timeout" class="textclass" disabled="disabled" />
						</td>
						<!-- 
						<td class="labelclass" id="spicturename"></td>
						<td width="20%" class="tdstyle">
							<input type="text" name="picturename" id="picturename" class="textclass" style="display: none" disabled="disabled" />
						</td>
						 -->
						
					</tr>
					<tr>
						<td class="dflabelclass">
						<!-- 字段说明 -->
						<fmt:message key="jobflowdefine.Fielddescription"/>
						</td>
						<td width="20%" colspan="5"> 
							<div id="fieldmemo" style="max-height: 100px;overflow-y: auto; overflow-x: hidden;margin-left: 5px;font-size: 14px">
							</div>
						</td>			
					</tr>
				</table>
			</form>
		</div>
		<div class="midd_butt">
			<button type="submit" class="tsdbutton" id="saveadd">
				<!-- 保存添加 -->
				<fmt:message key="jobflowdefine.saveadd"/>
			</button>
			<button type="submit" class="tsdbutton" id="saveexit">
				<!-- 保存退出 -->
				<fmt:message key="jobflowdefine.saveexit"/>
			</button>
			<button type="submit" class="tsdbutton" id="modify">
				<fmt:message key="global.edit" />
			</button>
			<button type="button" class="tsdbutton" id="close">
				<fmt:message key="global.close" />
			</button>
		</div>
	</div>
	
	<div id="sdiv"></div>
	<input id="column" type="hidden"/><input id="keyid" type="hidden"/><input id="dateparams" type="hidden"/>
	<input id="addright" type="hidden"/><input id="deleteright" type="hidden"/><input id="editright" type="hidden"/>
	<input id="addOrEdit" type="hidden"/><input id="hidMode" type="hidden"/>
  </body>
</html>