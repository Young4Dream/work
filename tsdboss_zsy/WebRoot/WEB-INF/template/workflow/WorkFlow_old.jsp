<%--*******************************************************************************
**          *******         ******  *******     **       *****                   **  
**             *            *          *       ** **     *    *                  **
**             *   ******   ******     *      **   **    *****                   ** 
**             *                 *     *     ** *** **   *  *                    **
**             *            ******     *    **       **  *    *                  **
**                                                                               **               
** name:    "WebRoot/WEB-INF/template/workflow/WorkFlow.jsp"                     **
** version: v10.1                                                                ** 
** author:  chenliang                                                            **
** date:    2011-11-01                                                           **
** desc:    通用工单管理，根据配置参数进行显示宽带工单管理数据和电话工单管理数据           **
** modify:  																	 **
** 			2012-03-7	增加新工单提示，并同步播放声音	chenliang                    ** 
*******************************************************************************--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	String imenuid = request.getParameter("imenuid");//菜单ID
	String groupid = (String)session.getAttribute("groupid");//所在权限组
	String userid = (String)session.getAttribute("userid");//当前登陆工号
	String deptname = (String)session.getAttribute("departname");//当前工号所在部门
	String userarea = (String)session.getAttribute("userarea");//当前登陆工号所在业务区域
	String chargearea = (String)session.getAttribute("chargearea");//当前登陆工号所在业务区域
	String username = (String)session.getAttribute("username");//当前登陆工号的人员名称
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>工单管理</title>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" /> 
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<!-- 平台导入脚本 -->
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<!-- 导航专用 -->
		<script src="script/public/navigationbar.js" type="text/javascript"></script>
		<!-- 字符串处理专用 -->
		<script src="script/public/tsdstring.js" type="text/javascript"></script>
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
		<!-- JQUERY拖动的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<!-- 分项卡 -->	
		<script src="plug-in/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
		<script src="plug-in/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>
		<script src="plug-in/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen"/>
		<script src="plug-in/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
		<!-- 工单管理导航样式 -->
		<link rel="stylesheet" href="style/css/workflow/workflownav.css" type="text/css" />
		<link rel="stylesheet" href="style/css/workflow/workflow.css" type="text/css" />
		<!-- 通用取值Js文件 -->
		<script src="script/workflow/fetchval.js" type="text/javascript" language="javascript"></script>
		<!-- 工单管理Js文件-->
		<script src="script/workflow/workflow.js" type="text/javascript" language="javascript"></script>
		<script src="plug-in/jquery/messager/jquery.messager.js" type="text/javascript"></script>
		<!-- 把下拉框变成可复合多选 -->
		<script src="plug-in/MultiSelect/jquery.bgiframe.min.js" type="text/javascript"></script>
		<script src="plug-in/MultiSelect/jquery.multiSelect.js" type="text/javascript"></script>			
		<link href="plug-in/MultiSelect/jquery.multiSelect.css" rel="stylesheet" type="text/css" />
		<style type="text/css">
		#deptname1{
			width:150xpx;
			height:14px; 
		}
		
		
		/*这个是借鉴一个论坛的样式*/
		table.t1{
		    border:1px solid #cad9ea;
		    color:#666;
		    text-align:center;
		}
		table.t1 th {
		    background-image: url(style/images/public/table-title-bg.png);
		    background-repeat:repeat-x;
		    height:30px;
		}
		table.t1 td,table.t1 th{
		    border:1px solid #cad9ea;
		    padding:0 1px; 0 1px;
		}
		table.t1 tr.a1{
		    background-color:#f5fafe;
		}
		
		</style>
<script type="text/javascript">
function killErrors(){ return true;}
window.onerror = killErrors;
$(document).ready(function(){
	$('#navBar1').append(genNavv());//获取导航
	var flag = chkUserDept();//当前登陆工号部门数据校验
	if(flag==false){
		//initHtml();		
		var busiVal = fetchSingleValue('WorkFlow.queryFlowconfig',6,'&imenuid=<%=imenuid %>');//显示业务类型
		if(busiVal!=undefined){
			$('#busiclass').text(busiVal);//标识业务业务类别，值为业务类别编码
			getUserPower('<%=userid %>','<%=imenuid %>','<%=groupid %>');//获取当前登陆工号业务操作权限
			getJobMenu('');//获取可处理工单类型和同步加载新工单和未处理工单信息
			//initJobBtn();//初始化操作按钮
			initIconDiv();//初始化显示图标
			$('#jobnav').tabs();//加载叶签
			dateEvent();//初始化事件
			//获取循环周期
			var getCircle = fetchSingleValue('WorkFlow.getCircle',6,'');
			if(undefined == getCircle){
				getCircle = 5;
			}
			//window.setInterval('isGetNewjob('+busiVal+')', getCircle * 60 * 1000);//默认是5分钟一个周期						
			//获取回退权限
			var thisYwlxto = $('#thisYwlx').text();
			if(thisYwlxto==""||thisYwlxto==undefined){
				thisYwlxto='-1';
			}
			var cencelvalue = fetchSingleValue('WorkFlow.querycancel',6,"&busiclassnum="+$('#busiclass').text()+"&busitypetext="+thisYwlxto+"&deptname="+tsd.encodeURIComponent('<%=deptname %>')+"&ywarea="+tsd.encodeURIComponent('<%=userarea %>'));
			if(cencelvalue!=undefined&&cencelvalue!=""&&cencelvalue==1){
					$("#canceljob").show();
					$("#submitcanceljob").show();
			}else{
					$("#canceljob").hide();
					$("#submitcanceljob").hide();
			}			
		}else{
			alert('页面参数配置有误，请检查工作流数据配置');
			$('#jobtb').hide();
	    	$('#jobimg').show();
		}
	}
	//$(":checkbox[name='thchecked']").click( function(){$(":checkbox[name='thchecked']").attr("checked");});
	//$(":checkbox[name='thchecked").attr("checked",$("#"+checkmainname).attr("checked"));
});
//当前登陆工号部门数据校验
function chkUserDept(){
	var flag = false;
	//判断发送部门是否有效
	var valParams =	'';
	valParams += '&bm='+tsd.encodeURIComponent('<%=deptname %>');	//当前登陆工号所在部门
	valParams += '&area='+tsd.encodeURIComponent('<%=userarea %>');	//所属业务区域
	var isEffect = fetchSingleValue('WorkFlow.queryIsEffect',6,valParams);
	if(isEffect!=undefined && isEffect!=0){
		$('#sChkbm').text(isEffect);
 	}else{
 		flag = true;
 		$('#jobtb').hide();
	    $('#jobimg').show();
		//说明：除受理收费外，部门必须和业务区域进行关联，一对一的关系
		alert('当前登陆工号所在的生成调度部门数据配置不完整，工单将无法正常流转，请先完善部门信息');
	}
	return flag;
}
//初始化工单业务数据，参数：业务类型
function getJobMenu(ywlx){
	var params = '';
	var RightGroup = $("#RightGroup").val()==undefined?'0':$("#RightGroup").val();
	params += '&imenu=<%=imenuid %>';//菜单id
	params += '&operflag='+RightGroup;//用户权限
	params += '&ywlx='+ywlx;//业务类型
	params += '&busitype='+$('#busiclass').text();//业务类别
	$("#hidywlx").val(ywlx);
	$.ajax(
    {
		url : 'workflow?' + params + '&opertype=1&tsdtemp=' + Math.random(), 
      cache : false,timeout : 3000, async : false , //同步方式
    success : function (xml){
				if(xml!=''){
					//alert(xml);
					$('#menudiv').empty();
					$('#disnewjobs').empty();
					$('#disuntreatedjobs').empty();
					$('body').append(xml);
					if($('#iComplete').text()=='2'){//当前业务类型的工单是否全部提交完毕
						//计算工单导航显示宽度和高度，避免对操作按钮进行覆盖，导航宽度和高度：120*50
						var ywlxCount = $('#ywlxCount').text();
						if(ywlxCount!=''){
							bgColorChange($('#thisYwlx').text());//选中工单菜单显示样式
							var sWidth = window.screen.width-270;//260为左边菜单和中间显示层之和
							$('#menu').css('width',sWidth+'px');
							var sLines = Math.ceil((parseInt(ywlxCount)*120)/sWidth);
							$('#menudiv').css('height','0px'); // Modified by zhumengfeng
						}
						//动态生成的html每次都需要重新进行事件监听
						$("#thchecked1").click( function(){$(":checkbox[name='jobchk1']").attr("checked",$("#thchecked1").attr("checked"));});
						$("#thchecked2").click( function(){$(":checkbox[name='jobchk2']").attr("checked",$("#thchecked2").attr("checked"));});					
					}else{//重新刷新工单数据
						getJobMenu('');
					}
					//激活鼠标移动到行时的变色
					tabChangeColor();	
				}else{//无可管理工单数据
					$('#jobtb').hide();
	      			$('#jobimg').show();
				}
           	  }
	});
}
//初始化事件
function dateEvent(){
	$("#receivejob").click(function(){WorkFlowManager(1);});//接收工单时触发的事件
	$("#submitjob").click(function(){WorkFlowManager(2);$("#submitcanceljob").hide();});//提交工单，显示面板时触发的事件
	$("#submitthejob").click(function(){WorkFlowManager(3);});//工单正式往下一级部门流转时触发的事件
	$("#endthejob").click(function(){WorkFlowManager(4);});//工单完工时触发的事件
	$("#printjob").click(function(){WorkFlowManager(5);});//打印工单时触发的事件
	$("#readflow").click(function(){WorkFlowManager(6);});//查看工单流程时触发的事件
	$("#jobdivclose").click(function(){$('input[name=jobchk2]').removeAttr("checked");$('input[name=thchecked]').removeAttr("checked");});//关闭工单提交面板时将已选中复选框置为不选状态
	$("#infoclose,#printclose").click(function(){$('input:checkbox').removeAttr("checked");});//关闭工单信息和打印工单时调用
	$('#newjob').click(function(){$('#sChkTab').text('1');});//标识选中的叶签，新工单
	$('#untreated').click(function(){$('#sChkTab').text('2');});//标识选中的叶签，未处理工单
	$("#printReport").click(function(){WorkFlowManager(7);});//查看工单流程时触发的事件
	$("#canceljob").click(function(){WorkFlowManager(8);$("#submitcanceljob").show();$("#submitthejob").hide();});//工单回退
	$("#submitcanceljob").click(function(){WorkFlowManager(9);});//工单回退
	$("#lctPath").click(function(){WorkFlowManager(10);});//查看流程图(通过页面展现图片的形式体现)
	//挂起和激活操作，保留接口
	//$("#pausejob").click( function(){pauseJob();});
	//$("#alivejob").click( function(){aliveJob();});
	//查看新工单
    $("#newjob").click( function(){
  		$('#receivejob').removeAttr('disabled');
  		//$('#submitjob,#printjob,#pausejob,#alivejob').attr('disabled','disabled');
  		$('#submitjob,#printjob,#canceljob').attr('disabled','disabled');
 	});
 	//查看未处理工单
 	$("#untreated").click( function(){
 		//$('#receivejob,#alivejob').attr('disabled','disabled');
 		//$('#submitjob,#printjob,#pausejob').removeAttr('disabled');
 		$('#receivejob').attr('disabled','disabled');
 		$('#submitjob,#printjob,#canceljob').removeAttr('disabled');
  	});
  	$('#deptname').change( function(){
  		$('#scddbmid').text($('#deptname').val());
  		var nextdept=fetchSingleValue('WorkFlow.getBM',6,'&id='+$('#deptname').val());
  		$('#displayTips').html(nextdept+'('+$('#nextarea').val()+')');
  		
  		
  	});
	
  	/**
  	//挂起和激活操作，保留
 	$("#pause").click( function(){
  		$('#receivejob,#submitjob,#printjob,#pausejob').attr('disabled','disabled');
  		$('#alivejob').removeAttr('disabled');
 	});
 	*/
}

//执行工单操作是调用的方法，参数：操作类别
function WorkFlowManager(operflag){
	//alert(operflag);
	var params = '';
	var thisYwlx = $('#thisYwlx').text();
	var sChkName = '';
	if($('#sChkTab').text()=='1'){//新工单页签
		sChkName = 'jobchk1';
	}else if($('#sChkTab').text()=='2'){//未处理工单页签
		sChkName = 'jobchk2';
	}
	var res = getTheChecked(sChkName);
	if(res == '' || undefined == res || null == res){
		alert('请勾选要提交的工单');
		getJobMenu(thisYwlx);
		return false;
	}
	
	var busiclass = $('#busiclass').text();
	params += '&jobid='+res;
	params += '&sender=<%=userid %>';
	params += '&jobtype='+thisYwlx;
	params += '&busitype='+busiclass;
	params += '&bm='+tsd.encodeURIComponent($('#sChkbm').text());
	
	var param = '&username='+tsd.encodeURIComponent('<%=username %>');
		param += '&jobid='+res;
	
	if(operflag==1){//接收工单
		if($("#userid").val()=="admin"){
			alert("超级管理员[admin]无法处理工单，请根据流程定义的部门工号来处理！");
			getJobMenu(thisYwlx);
			return;
		}
		var canReceive=0;
		var ifcancel;
		var WwcJobid = res.split(',');
		var WwcSigns='';
		var WwcDh;
		var showWord;
		for(var i = 0 ; i < WwcJobid.length;i++){
			ifcancel= fetchSingleValue('WorkFlow.queryIfCancel'+busiclass,6,'&jobid='+WwcJobid[i]);
			if(ifcancel==0){
				canReceive=fetchSingleValue('WorkFlow.getWcqkIsN'+busiclass,6,'&flag=\>&state=cancel&jobid='+WwcJobid[i]+'&bm='+tsd.encodeURIComponent($('#sChkbm').text()));
			}else{
				canReceive=fetchSingleValue('WorkFlow.getWcqkIsN'+busiclass,6,'&flag=\<&state=normal&jobid='+WwcJobid[i]+'&bm='+tsd.encodeURIComponent($('#sChkbm').text()));
			}
			if(canReceive!=0){
				WwcDh=fetchSingleValue('WorkFlow.getPhone'+busiclass,6,'&jobid='+WwcJobid[i]);
				WwcSigns +='账号'+":'"+WwcDh+"'的上一级流转部门尚未完工;"+"\n";
				canReceive=0;
			}
		}
		if(WwcSigns!=''){
			WwcSigns='';
			return false;
		}
		if(res==''){
			alert('请勾选要接收的工单');
			return false;
		}else{
			if(confirm('确定要接收工单吗？')){
				var ress = executeNoQuery('WorkFlow.JobReceived'+busiclass,6,params);
				if(ress=='true'){
					alert('接收成功');
					getJobMenu(thisYwlx);
					//中石油定制 在工单value10字段加入最后处理工单的人员信息 20151217 add by zxy
					executeNoQuery('WorkFlow.value10',6,param);
				}
				
			}else{
				$('input[name=jobchk1]').removeAttr("checked");
			}
		}		
	}else if(operflag==2){//提交工单，显示提交面板
		if($("#userid").val()=="admin"){
			alert("超级管理员[admin]无法处理工单，请根据流程定义的部门工号来处理！");
			getJobMenu(thisYwlx);
			return;
		}
		//清空下拉框
		clearMultiSelect();
		$('#deptname').val("");	//节点业务处理部门
		$('#multiDeptname').val("");
		if(res==''){
			alert('请勾选要提交的工单');
			getJobMenu(thisYwlx);
			return false;
		}else{
		
			$('#Memo').val("["+'<%=deptname%>'+':完成]');
			var isUnion = fetchSingleValue('WorkFlow.queryIsUnion'+busiclass,6,'&jobid='+res+'&bm='+tsd.encodeURIComponent($('#sChkbm').text()));
			if(isUnion!=1){
				alert('只能批量提交同一区域下相同部门的同种类型的工单');
				getJobMenu(thisYwlx);
				return false;
			}else{
				var iscancelstatus=fetchSingleValue('WorkFlow.queryCancelStatus'+busiclass,6,'&jobid='+res);
				if(iscancelstatus>1&&iscancelstatus!=undefined&&iscancelstatus!=""){
					alert("批量提交工单中存在不同状态的工单，不能同时提交！");
					getJobMenu(thisYwlx);
					return;	
				}
				
				autoBlockForm('jobmanagerdiv', 120, 'jobdivclose', "#ffffff", false);
				//thisText = '流程现在所在的部门是工单流向的最后一个部门，确认完工工单即可！';
				if(res.indexOf(',')!=-1){res=res.substring(0,res.indexOf(','));}//查询下一级流转部门时，默认取值第一个
				$('#sMemo').text('备注');
				$('#sJobFlow').text('流转部门');
				//是否为撤销工单
				var ifcancel = fetchSingleValue('WorkFlow.queryIfCancel'+busiclass,6,'&jobid='+res);
				var sVal = '+'; 	//正常工单
				var bflag = false;
				$('#ifcancel').val(1);
				var ifcancels='';
				if(ifcancel==0){
					sVal = '-';		//撤销工单
					bflag = true;
					$('#ifcancel').val(0);
					ifcancels='0';
				}
				//50p_setup90,flowparam,'<ywarea>','&jobid='+res
				var busiclass = $('#busiclass').text();//业务类型
				var flowparams = $('#flowparam'+res).text();//查询下一级部门查询参数：业务类型+部门id@业务区域
				var flowarr = flowparams.split('@');
				var queryparam = '';
				queryparam += '&queryparam='+tsd.encodeURIComponent(busiclass+flowarr[0]);
				queryparam += '&ywarea='+tsd.encodeURIComponent(flowarr[1]);
				queryparam += '&flowno='+tsd.encodeURIComponent(flowarr[2]);				
				$('#flowno').val(flowarr[2]);
				var jobstatus = fetchSingleValue('WorkFlow.queryJobstatus'+busiclass,6,'&jobid='+res);//获取当前工单是否是回退工单
				if(jobstatus=="rollback"){
				    if(busiclass=='50'){
						var tablename="teljob_pglc";
					}else if(busiclass=='53'){
					    var tablename="radjobflow";
					}
					var sNextDept = fetchMultiArrayValue('WorkFlow.cancelfsbm',6,'&busitype='+tsd.encodeURIComponent(busiclass)+'&jobtype='+thisYwlx+'&area='+tsd.encodeURIComponent(flowarr[1])+"&flownovalue=(select max(pgid) from "+tablename+" where jobid="+res+")");
				}else{
					var sNextDept = fetchMultiArrayValue('WorkFlow.queryFlowDept'+ifcancels,6,queryparam+'&flag='+tsd.encodeURIComponent(sVal)+'&busi='+busiclass);
				}						
				var flowinfo = '';
				var titleinfo = '';
				if(sNextDept[0][0]!=undefined){
					flowinfo = sNextDept[0][0]+'('+sNextDept[0][5]+')';
					$('#nextarea').val(sNextDept[0][5]);
					$('#scddbmid').text(sNextDept[0][1]);
					if(ifcancels=='0'){
						var deptCancel=fetchSingleValue('WorkFlow.queryFlowDeptCancel'+busiclass,6,'&jobid='+res+'&flowno'+flowarr[2]);
						$('#scddbmid').text(deptCancel);	
					}
					$('#sendmode').val(sNextDept[0][3]);
					var sHour = sNextDept[0][2].split('@');//返回的在此节点的部门预警时间和超时时间					
					if(ifcancels!='0'){
						if(sNextDept[0][3]=='choose'){
							$("#deptname").removeAttr("disabled");
							var deptParam='&flowno='+flowarr[2]+'&busiclass='+busiclass+'&busitype='+thisYwlx+'&ywarea='+tsd.encodeURIComponent(flowarr[1]);
							initOption('#deptname','JobFlowDefine.queryComBm',deptParam);
						}else if(sNextDept[0][3]=='multichoose'){
							$("#deptname").removeAttr("disabled");
							var deptParam='&flowno='+flowarr[2]+'&busiclass='+busiclass+'&busitype='+thisYwlx+'&ywarea='+tsd.encodeURIComponent(flowarr[1]);
							initDeptname(deptParam);
						}else if (sNextDept[0][3]=='condition'){
							$("#deptname").removeAttr("disabled");
							var deptParam='&flowno='+flowarr[2]+'&busiclass='+busiclass+'&busitype='+thisYwlx+'&ywarea='+tsd.encodeURIComponent(flowarr[1]);
							var getParams=tsd.encodeURIComponent(sNextDept[0][4])+res+tsd.encodeURIComponent("))||'%'");
							var getParam=fetchMultiArrayValue('JobFlowDefine.queryConBm',6,'&params='+getParams+deptParam);
							$('#scddbmid').text(getParam[0][0]);
							$("#deptname").attr("disabled","disabled");
							$("#deptname").append("<option value=''>请选择</option>");
							flowinfo = getParam[0][1]+'('+sNextDept[0][5]+')';
						}else{
							$("#deptname").attr("disabled","disabled");
							$("#deptname").append("<option value=''>请选择</option>");
						}
					}
					
					$('#sd_waring').text(sHour[0]);
					$('#sd_timeout').text(sHour[1]);
					if(bflag==true){
						clearMultiSelect();
						$("#deptname").attr("disabled","disabled");
						$("#deptname").append("<option value=''>请选择</option>");
						$("#multiDeptname").attr("disabled","disabled");
						$("#multiDeptname").append("<option value=''>请选择</option>");
						titleinfo = '回退工单';
						flowinfo +='<font color="red" style="font-size:14px">(注意：该工单为回退工单，请相关人员手工处理已做数据的清理工作)</font>';
					}else{
						titleinfo = '提交工单';				
					}					
					$('#submitthejob').show();
					$('#endthejob').hide();
					$("#submitcanceljob").hide();
					
					//清空下拉框
					clearMultiSelect();
					InitialDropdownList("revicor",sNextDept[0][0]);
					
				}else{
					//是否确认完工，提示完工信息
					if(bflag==true){
						titleinfo = '回退结束';
						flowinfo = '工单已回退到发起部门，确认完工即可';
					}else{
						titleinfo = '完工工单';	
						flowinfo = '流程现在所在的部门是工单流向的最后一个部门，确认完工工单即可！';	
						// Added by zhumengfeng at 2016/06/11
						// 宽带工单最后一步，需要填写宽带账号和密码
						if (busiclass == '53' && thisYwlx == 'setup') {
							$("#radinfo").show();
						}	
					}
					$("#endthejob").show();
					$("#submitthejob").hide();
					$("#submitcanceljob").hide();					
					$("#deptname").attr("disabled","disabled");
					$("#deptname").append("<option value=''>请选择</option>");
				}				
				$('#jobdivtitle').text(titleinfo);
				$('#displayTips').html(flowinfo);	
			}		
		}
	}else if(operflag==3 || operflag==4){//提交或完工工单，执行提交操作
		var sMemo = $('#Memo').val();
		
		if(sMemo==''){
			alert('请填写备注');
			$('#Memo').focus();
			return false;
		}
		var sTips = '';//信息提示
		var sCommitType = '';//提交类型
		var sCompPro = '';//完工时调用的接口过程
		if(operflag==3){
			sTips = '提交';
			sCommitType = 1;
			sCompPro = 'WorkFlow.JobAfterSend';
		}else if(operflag==4){
			sTips = '完工';
			sCommitType = 2;
			sCompPro = 'WorkFlow.JobAfterCompletes';
			if(busiclass!='57'){
				var wgyz=fetchSingleValue('WorkFlow.querybusifee'+busiclass,6,'&jobid='+res);
				if(wgyz!=undefined&&wgyz!=""&&wgyz>0){
					alert("请结清一次性费用后在完工！");
					return;
				}
			}
			//判断号线资料
			if(busiclass!='57'){
				
				var route_tablename="";
				var querysql="";
				if(busiclass=='50'){
					route_tablename="air_route_phone";
					querysql="WorkFlow.getPhoneDH";
				}else if(busiclass=='53'){
				    route_tablename="air_route_broadband";
				    querysql="WorkFlow.getPhoneKD";
				}
				/*判断当前账号号线信息是否完整
				//获取账号：宽带Or电话
				var jobinfos=fetchMultiArrayValue(querysql,6,"&jobid="+res);
				//var phoneNum=fetchSingleValue('WorkFlow.getPhoneDH',6,"&jobid="+res);
				if(jobinfos[0][0]!=undefined && jobinfos[0][1] != 'p_delete' && jobinfos[0][1] != 'p_editfunction'){
					var res = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=count(1)&tablename="+route_tablename+"&key=dh="+jobinfos[0][0]);
					if(parseInt(res)<=1){
						if(confirm('该用户号码号线资料不完整，无法进行完工操作！\r\n是否立即进行配线操作？')){
							$('#jobidHX').val(res);
							$("#username").val(jobinfos[0][0]);
							equipRoute();
						}
						return false;
					}
				}*/
				
			}else{
				//故障工单判断号线资料是否完整
				var hidywlx=$('#thisYwlx').text();
				var route_tablename="";
				var querysql="";
				if(hidywlx=='112fault'){
					route_tablename="air_route_phone";
					querysql="WorkFlow.getPhoneDH";
				}else if(hidywlx=='radfault'){
				    route_tablename="air_route_broadband";
				    querysql="WorkFlow.getPhoneKD";
				}else if(hidywlx=='tvfault'){
				    route_tablename="air_route_broadband";
				    querysql="WorkFlow.getPhoneKD";
				}
				/*判断当前账号号线信息是否完整
				//获取账号：宽带Or电话
				var jobinfos=fetchMultiArrayValue(querysql,6,"&jobid="+res);
				//var phoneNum=fetchSingleValue('WorkFlow.getPhoneDH',6,"&jobid="+res);
				if(jobinfos[0][0]!=undefined && jobinfos[0][1] != 'p_delete'){
					var res = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=count(1)&tablename="+route_tablename+"&key=dh="+jobinfos[0][0]);
					if(parseInt(res)<=1){
						if(confirm('该用户号码号线资料不完整，无法进行完工操作！\r\n是否立即进行配线操作？')){
							$('#jobidHX').val(res);
							$("#username").val(jobinfos[0][0]);
							equipRoute();
						}
						return false;
					}
				} */	
		}
		}else{
			alert('参数格式有误');
			return false;
		}
		//alert(params);
		
		// Added by zhumengfeng
		var radacc = $("#radacc").val();
		var radpwd = $("#radpwd").val();
		if (busiclass == '53' && thisYwlx == 'setup') {
			if (radacc == undefined || radacc == '') {
				alert('请输入宽带账号！');
				return false;
			}
			if (radpwd == undefined || radpwd == '') {
				alert('请输入宽带密码！');
				return false;
			}
		}
				
		if(confirm('确定要'+sTips+'工单吗？')){
			//params += '&receivedepart=';
			var canCommit = fetchMultiPValue('WorkFlow.JobBeforeSend',6,params);
			if(canCommit[0][0]==0){
				params += '&committype='+sCommitType;
				params += '&waring='+$('#sd_waring').text();
				params += '&timeout='+$('#sd_timeout').text();
				params += '&revdepart='+$('#scddbmid').text();
				params += '&memo='+tsd.encodeURIComponent(sMemo);
				params += '&senddepart='+tsd.encodeURIComponent($('#sChkbm').text());
				if(getDeptname('multiDeptname')!=''||getDeptname('multiDeptname')!=undefined){
					var getdept=getDeptname('multiDeptname');
					params += '&otherDept='+tsd.encodeURIComponent(getdept);
				}
				params += '&sendmode='+tsd.encodeURIComponent($('#sendmode').val());
				params += '&flowno='+tsd.encodeURIComponent($('#flowno').val());
				params += '&revicor='+tsd.encodeURIComponent(getDeptname('revicor'));	
				
				if($('#ifcancel').val()!=0){
					if($('#sendmode').val()=='choose'&&$('#deptname').val()==''){
						alert("请选择流转部门");
						return false;
					}
					if($('#sendmode').val()=='multichoose'&&($("[name='multiDeptname'][checked]").length==0)){
						alert("请选择流转部门");
						return false;
					}
				}

				var ress = fetchMultiPValue('WorkFlow.JobCommit',6,params);
				//alert('完工成功');
				if(ress[0][0]=='0'){
					var sCommitAfter = fetchMultiPValue(sCompPro,6,params);
					if(sCommitAfter[0][0]==0){
						alert('操作成功');
						//中石油定制 在工单value10字段加入最后处理工单的人员信息 20151217 add by zxy
						executeNoQuery('WorkFlow.value10',6,param);						
						$('#jobdivclose').click();
						getJobMenu(thisYwlx);
					}else{
						alert(sCommitAfter[0][1]);
					}
				}else{
					alert(sTips+'失败');
					$('#jobdivclose').click();
					getJobMenu(thisYwlx);
					return false;
				}
			}else{
				alert(canCommit[0][1]);
			}
		}else{
			$('input[name=jobchk2]').removeAttr("checked");
		}
	}else if(operflag==5){//打印工单	    
		if(res==''){
			alert('请勾选要打印的工单');
			getJobMenu(thisYwlx);
		}else{
			if(res.split(',').length>1){
				alert("只能选择单项工单！");
				getJobMenu(thisYwlx);
				return;
			}
			$('#thejobid').val(res);
			var res = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=value20&tablename=teljob&key=id="+res);
			if(res=="Y"){
				$("#allPrintDh").show();
			}else{
				$("#allPrintDh").hide();
			}
        	//$('#thedisplayprint').show();			
        	autoBlockForm('thedisplayprint', 150, 'printclose', "#ffffff", false);
		}
	}else if(operflag==6){//查看流程\
		if(res==''){
			alert('请勾选要查看的工单');
			getJobMenu(thisYwlx);
		}else{
			if(res.split(',').length>1){
				alert("只能选择单项工单查看流程！");
				getJobMenu(thisYwlx);
				return;
			}
			if(res.indexOf(',')!=-1){res=res.substring(0,res.indexOf(','));}//同时只能查看一条工单的详细流程信息
			//alert(res);
			readThisJob(res);		
		}
	}else if(operflag==7){
		if(res==''){
			alert('请勾选要查看的工单');
			getJobMenu(thisYwlx);
		}else{
			if(res.split(',').length>1){
				alert("只能选择单项工单查看流程！");
				getJobMenu(thisYwlx);
				return;
			}
			if(res.indexOf(',')!=-1){res=res.substring(0,res.indexOf(','));}//同时只能查看一条工单的详细流程信息
			//alert(res);
			//printReport
			var busiclass = $('#busiclass').text();//业务类型
			var flowparams = $('#flowparam'+res).text();//查询下一级部门查询参数：业务类型+部门id@业务区域
			var flowarr = flowparams.split('@');
			var restbl =fetchSingleValue('WorkFlow.PrintReport',6,'&busi='+busiclass+'&flowno='+flowarr[2]+'&ywarea='+tsd.encodeURIComponent(flowarr[1])+'&bm='+$('#sChkbm').text()+'&sgnr='+tsd.encodeURIComponent($('#thisYwlx').text()));
			if(restbl==undefined || restbl == null){
				alert('该工单流程节点未配置派工单');
			}else{
				printThisReport1('<%=request.getParameter("imenuid")%>',
				restbl,
				'&jobid='+res,
				'<%=(String)session.getAttribute("userid")%>',
				'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
				'<%=(String)session.getAttribute("departname")%>');
			}
		}
	}else if(operflag==8){//回退工单
		if($("#userid").val()=="admin"){
			alert("超级管理员[admin]无法处理工单，请根据流程定义的部门工号来处理！");
			getJobMenu(thisYwlx);
			return;
		}
		//清空下拉框
		clearMultiSelect();
		$('#deptname').val("");	//节点业务处理部门
		$('#multiDeptname').val("");
		if(res==''){
			alert('请勾选要提交的工单');
			getJobMenu(thisYwlx);
			return false;
		}else{
			$('#Memo').val('请按时完成');
			var isUnion = fetchSingleValue('WorkFlow.queryIsUnion'+busiclass,6,'&jobid='+res+'&bm='+tsd.encodeURIComponent($('#sChkbm').text()));
			if(isUnion!=1){
				alert('只能批量提交同一区域下相同部门的同种类型的工单');
				return false;
			}else{
				 //single												
				//thisText = '流程现在所在的部门是工单流向的最后一个部门，确认完工工单即可！';
				if(res.indexOf(',')!=-1){res=res.substring(0,res.indexOf(','));}//查询下一级流转部门时，默认取值第一个
				$('#sMemo').text('备注');
				$('#sJobFlow').text('流转部门');
				var sVal = '+'; 	//正常工单
				var bflag = false;
				$('#ifcancel').val(1);
				var ifcancels='';
				var busiclass = $('#busiclass').text();//业务类型
				var flowparams = $('#flowparam'+res).text();//查询下一级部门查询参数：业务类型+部门id@业务区域
				var flowarr = flowparams.split('@');
				var queryparam = '';
				queryparam += '&queryparam='+tsd.encodeURIComponent(busiclass+flowarr[0]);
				queryparam += '&ywarea='+tsd.encodeURIComponent(flowarr[1]);
				queryparam += '&flowno='+tsd.encodeURIComponent(flowarr[2]);
				$('#flowno').val(flowarr[2]);
				//根据类型条件获取当前部门是否可以撤退流程
				var isnotcancel = fetchSingleValue('WorkFlow.isnotcancel',6,'&busitype='+busiclass+"&jobtype="+thisYwlx+'&bm='+tsd.encodeURIComponent($('#sChkbm').text())+'&flownoto='+tsd.encodeURIComponent($('#flowno').val())+'&area='+tsd.encodeURIComponent(flowarr[1]));
				if(isnotcancel!="single"&&isnotcancel!='choose'&&isnotcancel!=""&&isnotcancel!=undefined){
					alert('当前工单部门不属于单一部门发送，无法回退该工单！');
					return;
				}
				//判断当前工单已经是回退工单不能再次回退
				var canceljsbm = fetchSingleValue('WorkFlow.canceljsbm'+busiclass,6,'&id='+res+"&pid="+flowarr[2]+'&deptname='+tsd.encodeURIComponent($('#sChkbm').text())+"&busitype="+busiclass+"&jobtype="+thisYwlx+'&area='+tsd.encodeURIComponent(flowarr[1])); 
				if(canceljsbm>0){
					alert('该工单已经回退到当前部门，不能再次回退！');
					return;
				}				
				//判断当前工单已经是回退工单不能再次回退
				var ifcancel = fetchSingleValue('WorkFlow.queryteljobcancel'+busiclass,6,'&jobid='+res); 
				if(ifcancel>0){
					alert('该工单已撤销，无法回退该工单！');
					return;
				}
				autoBlockForm('jobmanagerdiv', 120, 'jobdivclose', "#ffffff", false);					
				
				var sNextDept = fetchMultiArrayValue('WorkFlow.cancelfsbm',6,'&busitype='+tsd.encodeURIComponent(busiclass)+'&jobtype='+thisYwlx+'&area='+tsd.encodeURIComponent(flowarr[1])+"&flownovalue=1");
				var flowinfo = '';
				var titleinfo = '';
				if(sNextDept[0][0]!=undefined){					
					flowinfo = sNextDept[0][0]+'('+sNextDept[0][5]+')';
					$('#nextarea').val(sNextDept[0][5]);
					$('#scddbmid').text(sNextDept[0][1]);
					if(ifcancels=='0'){
						var deptCancel=fetchSingleValue('WorkFlow.queryFlowDeptCancel'+busiclass,6,'&jobid='+res+'&flowno'+flowarr[2]);
						$('#scddbmid').text(deptCancel);	
					}
					$('#sendmode').val(sNextDept[0][3]);
					var sHour = sNextDept[0][2].split('@');//返回的在此节点的部门预警时间和超时时时间
					if(ifcancels!='0'){
						$("#deptname").attr("disabled","disabled");
						$("#deptname").append("<option value=''>请选择</option>");
					}
					$('#sd_waring').text(sHour[0]);
					$('#sd_timeout').text(sHour[1]);
					clearMultiSelect();
					$("#deptname").attr("disabled","disabled");
					$("#deptname").append("<option value=''>请选择</option>");
					$("#multiDeptname").attr("disabled","disabled");
					$("#multiDeptname").append("<option value=''>请选择</option>");
					$('#submitthejob').show();
					$('#jobdivtitle').text("回撤工单");
				    $('#displayTips').html(flowinfo+'<font color="red" style="font-size:14px">(注意：该工单为回撤工单，工单将流转到发起人员进行信息核实！)</font>');
					$('#endthejob').hide();
				}	
			}				
		}
	}else if(operflag==9){//回撤工单，执行提交操作		
		var sMemo = $('#Memo').val();
		if(sMemo==''){
			alert('请填写备注');
			$('#Memo').focus();
			return false;
		}
		var sTips = '';//信息提示
		var sCommitType = '';//提交类型
		sTips = '提交';
		sCommitType = 1;
		if(confirm('确定要'+sTips+'工单吗？')){
				params += '&committype='+sCommitType;
				params += '&waring='+$('#sd_waring').text();
				params += '&timeout='+$('#sd_timeout').text();
				params += '&revdepart='+$('#scddbmid').text();
				params += '&memo='+tsd.encodeURIComponent(sMemo);
				params += '&senddepart='+tsd.encodeURIComponent($('#sChkbm').text());
				if(getDeptname('multiDeptname')!=''||getDeptname('multiDeptname')!=undefined){
					var getdept=getDeptname('multiDeptname');
					params += '&otherDept='+tsd.encodeURIComponent(getdept);
				}
				params += '&sendmode='+tsd.encodeURIComponent($('#sendmode').val());
				params += '&flowno='+tsd.encodeURIComponent($('#flowno').val());				
				var ress = fetchMultiPValue('WorkFlow.JobCommit_Cancel',6,params);
				//alert('完工成功');
				if(ress[0][0]=='0'){
					alert('操作成功');
					//中石油定制 在工单value10字段加入最后处理工单的人员信息 20151217 add by zxy
					executeNoQuery('WorkFlow.value10',6,param);					
					$('#jobdivclose').click();
					getJobMenu(thisYwlx);
				}else{
					alert(sTips+'失败');
					$('#jobdivclose').click();
					getJobMenu(thisYwlx);
					return false;
				}
		}else{
			$('input[name=jobchk2]').removeAttr("checked");
		}
		
	}else if(operflag==10){//查看流程图
		var pglcid=fetchSingleValue('WorkFlow.querypglc_id',6,'&job_id='+res+'&deptname='+tsd.encodeURIComponent('<%=deptname %>'));
		alert("请配置流程图！");
		//window.open($("#thisbasePath").val()+"mainServlet.html?pagename=workflow/lctpath/right.jsp");
		//window.showModedalDialog("login.jsp","","");
		//window.showModelessDialog($("#thisbasePath").val()+"login.jsp","")
	}	
}

//查看流程，参数：工单ID
function readThisJob(jobid)
{
	var initDiv = '';
    initDiv += '<table id="jobflowtab" width="100%" style="text-align:center;line-height:25px" border="1" class="t1">';
    initDiv += '<tr>';
    initDiv += '<th style="width:40px;">序号</th><th style="width:40px;">类型</th><th style="width:60px;">发送部门</th>';
    initDiv += '<th style="width:60px;">发送人员</th><th style="width:100px;">发送时间</th><th style="width:60px;">目前部门</th>';
    initDiv += '<th style="width:60px;">处理人员</th><th style="width:100px;">处理时间</th><th style="width:100px;">详细备注</th>';
    initDiv += '</tr>';
	var res = fetchMultiArrayValue("WorkFlow.queryFlowinfo"+$('#busiclass').text(),6,'&jobid='+jobid);
	var xint = 1;
	if(res != '' && res!=undefined){
		var innerTr = '';
		for(var i = 0 ; i < res.length;i++){
			innerTr += '<tr class="trclass" style="line-height:30px">';
			innerTr += '<td class="jobtabclass">'+xint+'</td>';
			innerTr += '<td class="jobtabclass"><img src="style/images/public/'+res[i][1]+'.gif" alt="工单类型"/></td>';
			innerTr += '<td class="jobtabclass" style="width:130px">'+res[i][2]+'</td><td class="jobtabclass">'+res[i][3]+'</td>';
			innerTr += '<td class="jobtabclass">'+res[i][4]+'</td><td class="jobtabclass" style="width:130px">'+res[i][5]+'</td>';
			innerTr += '<td class="jobtabclass">'+res[i][6]+'</td><td class="jobtabclass">'+res[i][7]+'</td>';
			innerTr += '<td class="jobtabclass" style="width:150px">'+res[i][8]+'</td>';
			innerTr += '</tr>';
			xint ++;
		}
		//显示第三格的内容
   		$('#displayreadflow').html(initDiv+innerTr+'</table>');
   		//tabChangeColor();
    	autoBlockForm('displayjobflowinfo', 60, 'infoclose', "#ffffff", false);
    	//$('input:checkbox').removeAttr("checked");
	}else{
		alert('查询数据参数格式有误');
	}
}
//工单打印，参数：打印类别
function jobPrint(flag){
	var key = $('#thejobid').val();	
	var busiclass=$("#busiclass").text()
	
	if(key!=undefined){					
		var respash = fetchSingleValue("cReport.reportname",6,"&menuid="+$("#imenuid").val()+"&reportflag=dh_jobworkorder");
		
		if(busiclass=="57"){
			//判断号码是本局号还是电信号，获取不同报表
			var ress = fetchMultiPValue('workflow.get112jobreport',6,"&jobid="+key);
			if(ress[0][0]=='0'){
				respash="commonreport/workpg_T112_out.cpt"
			}
		}
		
		if(respash!=undefined&&respash!=""){
			if(flag==1){//直接打印
				printWithoutPreview(respash.replace('.cpt',''),"JobID_"+key+"_bm_"+tsd.encodeURIComponent('<%=deptname %>'));
			}else if(flag==2){//预览打印
				var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/"+respash+"&JobID="+key+"&bm="+tsd.encodeURIComponent('<%=deptname %>');		
				window.showModalDialog(urll,window,"dialogWidth:760px; dialogHeight:580px; center:yes; scroll:no");
			}else if(flag==3){
				var respashsan = fetchSingleValue("cReport.reportname",6,"&menuid="+$("#imenuid").val()+"&reportflag=dh_jobworkorder_all");
				if(respashsan!=undefined&&respashsan!=""){
					var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/"+respashsan+"&JobID="+key+"&bm="+tsd.encodeURIComponent('<%=deptname %>');		
					window.showModalDialog(urll,window,"dialogWidth:760px; dialogHeight:580px; center:yes; scroll:no");
				}
			}else{
				alert('打印参数有误');
			}
		}else{
			alert("对不起，找不到报表模板！");
		}
	}
	//$('#printclose').click();
}

/**********************************************************************
function name:    printWithoutPreview
function:         printWithoutPreview(reportname,paramvalue)

parameters:       reportname:报表文件的文件名
                  paramvalue:报表文件中定义的参数，如报表文件中定义了参数param1,param2,需传参数为value1,value2,则paramvalue为:param1_value1_param2_value2
                  页面需添加一个iframe,不应该被包含有其它隐藏的元素中
                  <iframe id="printReportDirect"  style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>
                  
return:           成功时返回true,失败时返回"false"或false;

description:      通过SQL语句执行删除和修改操作，执行key查询，通用
**********************************************************************/
function printWithoutPreview(reportname,paramvalue)
{
	document.getElementById('printReportDirect').contentWindow.RepPri(reportname,paramvalue);
}

//阅读工单详细，参数：工单ID，目前部门
function readJobDetail(jobid,mqbm){
	var val = fetchSingleValue('WorkFlow.queryCustomer',6,'');
	if(val!=undefined){
		var busiclass = $('#busiclass').text();
		if(busiclass==50){//电话
			thisInfo(jobid, mqbm, $('#sChkTab').text());
			//获取电话
			var phoneNum=fetchSingleValue('WorkFlow.getPhoneDH',6,"&jobid="+jobid);
			if(phoneNum!=undefined){
				//面板中的号线信息
				var type1='dh';
				getRouteMX(phoneNum,jobid,type1);
			}
			if(val=='zhongyuanyoutian'){
				$('#hx6').show();
			}else{
				$('#hx6').hide();
			}		
		}else if(busiclass==53){//宽带
			thisKdInfo(jobid,mqbm);
			//获取是否回退
			var cancel=fetchSingleValue('WorkFlow.getCancel',6,"&jobid="+jobid);
			if(cancel=='Y'){
				alert("该工单为撤销工单，不要往认证系统录入数据，请回退工单");
			}
			//获取宽带帐号
			var phoneNum=fetchSingleValue('WorkFlow.getPhone',6,"&jobid="+jobid);
			if(phoneNum!=undefined){
				var type2='kd';
				getRouteMX(phoneNum,jobid,type2);
			}
			autoBlockForm('kddetailInfo', 20, 'kddetailinfoclose', "#ffffff", false);
		}else if(busiclass==57){//增值
			thisFaInfo(jobid);
			autoBlockForm('faultDetailInfo', 20, 'faultDetailinfoclose', "#ffffff", false);
		}
	}else{
		alert('查询客户信息失败，请检查配置');
	}
}

//获取新工单信息
function isGetNewjob(busiclass){
	var RightGroup = $('#RightGroup').val();
	var sChkbm = $('#sChkbm').text();
	var params = '';
	params += '&area='+tsd.encodeURIComponent('<%=chargearea %>');
	params += '&bm='+sChkbm;
	var res = fetchMultiArrayValue("WorkFlow.queryNewJobCount"+busiclass+RightGroup,6,params);
	var divtips = '';
	if(res != '' && res!=undefined){
		for(var i = 0 ; i < res.length;i++){
			divtips += res[i][1] + '条' + res[i][0] + '新工单' + '，'		
		}
	}
	if(divtips != ''){
		setTimeout($.unblockUI, 15);
		divtips = divtips.substring(0,divtips.lastIndexOf('，'));
		divtips = divtips + '达到，等待处理...<embed src="sound.wav" autoplay="true" playcount="3" hidden="true"/>';
		getJobMenu($('#thisYwlx').text());
		$.messager.show('您有新工单到达', divtips, 10000);
	}
}
//加载多选部门
function initDeptname(param){
		$("#multiDept").css('display','block');
		$("#dept").css('display','none');
		$("#deptname").empty();
		$("#multiDeptname").empty();
		var arealist = fetchMultiArrayValue("JobFlowDefine.queryComBm",6,param);
		if(arealist[0]!=undefined && arealist[0][0]!=undefined)
		{
			optHtml = "";
			optHtml +="<option value=''>请选择</option>"
			for(var i=0;i<arealist.length;i++)
			{
				optHtml += "<option  align=\"center\"  areaid=\"" + arealist[i][1] + "\" tval=\"" + arealist[i][1] + "\" value=\"" + arealist[i][0] + "\">" + arealist[i][1] + "</option>";
				
			}
			$("#multiDeptname").html(optHtml);
			$("#multiDeptname").multiSelect({ oneOrMoreSelected: '*'},'','deptname1',',');
			$("#multiDeptname").next(".multiSelectOptions").find(":checkbox:checked").attr("checked","false");
			$("#multiDeptname").next(".multiSelectOptions").find(".selectAll:first").hide();
			//alert($("#deptname").next(".multiSelectOptions").find(":checkbox:checked").size());
		}
} 
//加载单选部门
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
function getDeptname(id){

		//fieldvalue = $('#check'+prefix+fieldname+suffixW).val();
		var multistr='';
		var mulselectoper = ',';
		$("[name='"+id+"'][checked]").each(function(){
			multistr +=$(this).val()+mulselectoper;				
		}) ; 
		var len = multistr.lastIndexOf(mulselectoper);
		if(len>0){multistr = multistr.substr(0,len);}
		fieldvalue = multistr;
		return fieldvalue;
}
function clearMultiSelect(){
		$(".multiSelectOptions :checkbox:checked").attr("checked",false).parent().removeClass("checked");
		$(".multiSelectOptions :disabled").removeAttr("disabled");
		$(".multiSelect").attr("trueval","");
}

//加载维护区域
function InitialDropdownList(id1,params)
{

	//$(".multiSelect").attr("trueval","");
	//$("#"+id1).html("<option value='-1'>请选择...</option>");
	$("#tdrevicor").html("");
	var str='<select id="revicor" name="revicor" class="textclass" style="width: 200px;">';
	
	var optHtml = "";	
	//取区域 
	var arealist = fetchMultiArrayValue("WorkFlow.loadnextpartuserid",6,"&departname="+tsd.encodeURIComponent(params));
	if(arealist[0]!=undefined && arealist[0][0]!=undefined)
	{
		optHtml = "";
		for(var i=0;i<arealist.length;i++)
		{
			optHtml += "<option  align=\"center\" tval=\"" + arealist[i][0] + "\" value=\"" + arealist[i][0] + "\">" + arealist[i][1] + "</option>";
		}			
		str+=optHtml;
	}
	
	str+="</select>";
	
	$("#tdrevicor").html(str);
	
	//$("#"+id1).html(optHtml);
	$("#"+id1).multiSelect({ oneOrMoreSelected: '*'},'','deptname1',',');
	$("#"+id1).next(".multiSelectOptions").find(":checkbox:checked").attr("checked","false");
	$("#"+id1).next(".multiSelectOptions").find(".selectAll:first").hide();
	
}

</script>
</head>
<body>
	<jsp:include page="Nav.jsp"  flush="true" />
	<table width="100%" style="margin-top: 5px;font-size: 14px" id="jobtb">
		<tr><td align="left"><div id="menudiv" style="margin-top: 0px;"></div></td></tr>
		<tr><td><hr size="1" noshade="noshade" /></td></tr>
		<tr>
			<td id="jobbtn">
				<ul class="tabs-nav">
					<li><button id="receivejob" class="tsdbtn"><fmt:message key="workflow.receivejob" /></button></li>
					<li><button id="submitjob" class="tsdbtn" disabled="disabled"><fmt:message key="workflow.submitjob" /></button></li>							
					<li><button id="readflow" class="tsdbtn"><fmt:message key="workflow.readflow" /></button></li>
					<li><button id="printjob" class="tsdbtn" disabled="disabled"><fmt:message key="workflow.printjob" /></button></li>
					<li><button id="canceljob" class="tsdbtn" disabled="disabled" style="display:none;">回退工单</button></li>
				</ul>
			</td>
		</tr>
		<tr><td><hr size="1" noshade="noshade" /></td></tr>
		<tr>
			<td>
				<div id="jobnav">
					<ul class="tabs-nav">
						<li><a href="#fragment-new"><span id="newjob"><fmt:message key="workflow.newjobs" />(<label id="newjobs"></label>)</span></a></li>
						<li><a href="#fragment-untreated"><span id="untreated"><fmt:message key="workflow.untreatedjobs" />(<label id="untreatedjobs"></label>)</span></a></li>
						<!--  <li><a href="#fragment-pause"><span id="pause">挂起工单(<label id="pausejobs"></label>)</span></a></li> -->
						<li><div id="icondivli" style="text-align: left; margin-left: 30px;margin-top: 2px"><div></li>
					</ul>
					<div id="fragment-new">
						<div id="disnewjobs" style="overflow-y: auto; overflow-x: hidden;"></div>
					</div>
					<div id="fragment-untreated">
						<div id="disuntreatedjobs" style="overflow-y: auto; overflow-x: hidden;"></div>
					</div>
					<div id="fragment-pause">
						<div id="dispausejobs" style="overflow-y: auto; overflow-x: hidden;"></div>
					</div>
				</div>
				<div id="icondiv" style="text-align: left; margin-left: 30px;margin-top: 5px"><div>
			</td>
		</tr>
	</table>
	<center>
		<div id="jobimg" style="display: none;margin-top: 150px">
			<img src="style/images/public/dismenu.gif"/>
			<label style="font-size: 14px"><fmt:message key="workflow.noresult" /></label><!-- 暂无可管理的工单数据... -->
		</div>
	</center>
	<!-- 工单数据处理面板 -->
	<div class="neirong" id="jobmanagerdiv"
		style="display: none; width: 720px">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
					<div class="top_03" id="jobdivtitle"></div>
					<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
				</div>
				<div class="top_01right">
					<a href="#" onclick="javascript:$('#jobdivclose').click();"><fmt:message key="global.close" /></a>
				</div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>
		</div>
		<div class="midd">
			<form action="#" name="operform" id="operform"
				onsubmit="return false;">
				<table width="100%" id="tdiv" border="0" cellspacing="0"
					cellpadding="0">
					<tr>
						<td  class="labelclass">
						选择部门：
						</td>
						<td width="20%"  class="tdstyle">
							<div id='dept'  style="float:left;" >
							<select id="deptname" name="deptname" class="textclass" style="width: 150px"></select>
							</div>
							<div style="display:none" id='multiDept' style="width: 150px;float:left;" >
							<select id="multiDeptname" name="multiDeptname" class="textclass" style="width: 150px;"></select>
							</div>
						</td>
						<td class="labelclass" id="lblarea" style="width: 15%">接收人员：</td>
						<td class="tdstyle" width="20%" id="tdrevicor">
							
						</td>
					</tr>
					<tr>
						<td class="dflabelclass" id="sMemo" style="width: 10%"></td>
						<td width="20%">
							<textarea id="Memo" rows="6" cols="40" style="font-size: 14px"></textarea>
						</td>
						<td class="dflabelclass" id="sJobFlow" style="width: 10%"></td>
						<td width="30%">
							<input type="radio" checked="checked" name="nextDept" id="nextDept" />
							<span id="displayTips" style="line-height: 20px;font-size: 14px"></span>
							<label id="scddbmid" style="display: none"></label>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="midd_butt" id="radinfo" style="display: none">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="15%">宽带账号</td>
					<td width="85%" align="left">
						<input id="radacc" name="radacc" style="width:170px;" type="text"></input>
						&nbsp;<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td>宽带密码</td>
					<td align="left">
						<input id="radpwd" name="radpwd" style="width:170px;" type="text"></input>
						&nbsp;<font color="red">*</font>
					</td>
				</tr>
			</table>
		</div>
		<div class="midd_butt">
			<button type="submit" class="tsdbtn" id="submitthejob"><fmt:message key="workflow.submitjob" /></button>
			<button type="submit" class="tsdbtn" id="submitcanceljob" style="display:none;"><fmt:message key="workflow.submitjob" /></button>
			<button type="submit" class="tsdbtn" id="endthejob"><fmt:message key="workflow.completejob" /></button>
			<button type="button" class="tsdbtn" id="jobdivclose" style="width: 60px"><fmt:message key="global.close" /></button>
			<!-- 
			<button type="submit" class="tsdbtn" id="pausethejob"></button>
			<button type="submit" class="tsdbtn" id="alivethejob"></button> 
			-->
		</div>
	</div>
	<!-- 查看流程的面板 -->
	<div class="neirong" id="displayjobflowinfo"
		style="display: none; width: 840px">
		<div class="top">
			<div class="top_01" id="jobflowdrag">
				<div class="top_01left">
					<div class="top_02"><img src="style/images/public/neibut01.gif" /></div><!-- 查看流程 -->
					<div class="top_03" id="jobflowdiv"><fmt:message key="workflow.readflow" /></div>
					<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
				</div>
				<div class="top_01right">
					<a href="#" onclick="javascript:$('#infoclose').click();"><fmt:message key="global.close" /></a>
				</div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>
		</div>
		<div class="midd">
			<form action="#" name="jobflowform" id="jobflowform" onsubmit="return false;">
				<div id="displayreadflow" style="max-height: 300px; overflow-y: auto; overflow-x: hidden; background-color: #ffffff">
				</div>
			</form>
		</div>
		<div class="midd_butt">
			<button type="button" class="tsdbtn" id="infoclose" style="width: 80px;">
				<fmt:message key="global.close" />
			</button>
			<button type="button" class="tsdbtn" id="lctPath" style="width: 80px;">
				查看流程图
			</button>
		</div>
	</div>
	<!-- 打印派工单 -->
	<div class="neirong" id="thedisplayprint" style="display: none; width: 620px; margin-left: 50px">
		<div class="top">
			<div class="top_01" onmousedown="StartDrag(this)"
				onmouseup="StopDrag(this)" onmousemove="Drag(this)">
				<div class="top_01left">
					<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
					<div class="top_03" id="titlediv">打印派工单</div>
					<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
				</div>
				<div class="top_01right"><a href="#" onclick="javascript:$('#printclose').click();">关闭</a></div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>
		</div>
		<div class="midd" style="background-color: #FFFFFF;height: 50px">
			<button id="theprint" onclick="jobPrint(1)" class="tsdbtn" style="margin-left: 10px; margin-top: 10px;PADDING-RIGHT: 10px;" >直接打印</button>
			<button id="viewprint" onclick="jobPrint(2)" style="margin-left: 10px" class="tsdbtn">打印预览</button>
			<button id="allPrintDh" onclick="jobPrint(3)" style="margin-left: 10px;display:none;" class="tsdbtn">批量预览电话</button>
			<button id="printclose" style="width: 90px; margin-left: 10px" class="tsdbtn">不打印</button>
		</div>
		<iframe id="printReportDirect" style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>
		<div class="midd_butt"></div>
	</div>
	<jsp:include page="JobDetailInfo.jsp"  flush="true" />
	<input id="RightGroup" type="hidden"/>
	<input id="sendmode" type="hidden"/>
	<input id="nextarea" type="hidden"/>
	<input id="ifcancel" type="hidden"/>
	<input id="flowno" type="hidden"/>
	<input id="userid" type="hidden" value="<%=(String)session.getAttribute("userid")%>"/>
	<input type="hidden" id="thisbasePath" value="<%=basePath%>"/>
	<input type="hidden" id="imenuid" value="<%=imenuid%>"/>
	<input type="hidden" id="hidywlx"/>		
	<div style="display: none">
		<label id="iComplete"></label>
		<label id="thisYwlx"></label><label id="sd_waring"></label><label id="sd_timeout"></label><label id="ywlxCount"></label>
		<label id="sChkTab">1</label><label id="sChkbm"></label><label id="busiclass"></label><label id="thejobid"></label>
		<label id="normaljob"><fmt:message key="workflow.normaljob" /></label><label id="canceljob"><fmt:message key="workflow.canceljob" /></label>
		<label id="dwaring"><fmt:message key="workflow.dwaring" /></label><label id="dtimeout"><fmt:message key="workflow.dtimeout" /></label>
		<label id="ttimeout"><fmt:message key="workflow.ttimeout" /></label><label id="iconmemo"><fmt:message key="workflow.iconmemo" /></label>
	</div>	
  </body>
</html>
