<%----------------------------------------
	name: BusinessCosts.jsp
	author: youhongyu
	version: 1.0,  2009-11-26
	description: 业务及费用设置 Business and costs of setting
	modify: 
		2010-01-18: youhongyu 更改导出模块 
		2010-01-20: youhongyu 更改grid样式 grid字段可控 验证方法
		2010-03-08: youhongyu 面板的弹出方式
		2010-07-21: youhongyu 添加字段，费用有效起始时间，费用有效结束时间，用户类型，用户性质，费用有效区域 --eidt by chenliang
		2010-12-10: liwen     修改新增，修改面板用户性质无显示问题
		2011-01-04: youhongyu 业务设置新增面板添加一个字段
		2011-01-14  chenze    修正显示详细时部分字段可修改的问题  修正业务配置时无法显示详细的问题 增加查询
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
	String languageType = (String) session.getAttribute("languageType");
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Business and costs of setting</title>
    <link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<!-- 分项卡 -->
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css"
			type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css"
			type="text/css" media="projection, screen" />		
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
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
		<!-- 时间选择器 -->
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	<style type="text/css">
	#V1,#V2,#V3,#V4{height:0px;}
	#editgrid a{font-weight:bold;}
	</style>
	
<script type="text/javascript">
/**
 * 查看当前用户的扩展权限，对spower字段进行解析
 * @param 无参数
 * @return 无返回值
 */
function getUserPower(){
			 var urlstr=buildParamsPro('BusinessCosts.getPower','query');
			 
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
						
					}
			}else if(spower=='all@'){
					$("#addright").val(str);
					$("#delBright").val(str);
					$("#editBright").val(str);
					
					$("#deleteright").val(str);
					$("#editright").val(str);
					
					$("#exportright").val(str);
					$("#printright").val(str);
					
					editfields = getFields('ywsl_feetype');					
					editfields_son = getFields('ywsl_code');
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

/**
 * 查看当前用户的扩展权限，对spower字段进行解析
 * @param 无参数
 * @return 无返回值
 */
function getfeetype(){	 
		var feetypeA=[];
		var languageType = $("#languageType").val();
		var urlstr=buildParamsSql('query','xmlattr','ywslCode.getFeeType','');
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
					var FeeType = $(this).attr("feetype");
					feetypeA.push(FeeType);	
				});
			}
		});
		
		var fnameASize = feetypeA.length;
		for(j=0;j<fnameASize;j++)
		{
			$("#FeeType_s").append("<p><input  style=\"width:20px;height:20px;\" type=\"checkbox\" name=\"checkbox"+j+ "\" id=\"checkbox"+j+"\" value=\"" + feetypeA[j] + "\" /><span id=\"span"+j+"\"> "+ feetypeA[j]+"</span></p>");
		}
		//alert($("#HzFields").html());
}	
/**
 * 复选框
 * @param 无参数
 * @return 无返回值
 */		
function opendsss(){
		$("#dept").attr('style','display:block');	
		$("#thedept").attr('style','display:none');	
}
/**
 * 页面初始化时加载组信息，供用户进行选择 , 获取减免项目名称      
 * @param 无参数
 * @return 无返回值
 */	
function getTheDept(){
		getDeptName();
		$("#dept").attr('style','display:none');
		$("#thedept").attr('style','display:block');
}
/**
 * 将返回的结果集生成一个form出来      
 * @param 无参数
 * @return 无返回值
 */	
function getformInfo(){
	$('#thedeptform').remove();		
		//将返回的结果集生成一个form出来
		var thevalue='<table width="500" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #dfe0e1; padding:5px; background:#f6f7f8; font-size:12px;margin:5px 0px; ">';
		thevalue +='<tr><td height="35" colspan="3">'+"<input type='button'  id='checkall' onclick=isCheckedAll('depts',true); value='<fmt:message key="BusinessCosts.selectall" />' style='width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;line-height:25px;  margin-left:10px;'><input type='button'  id='uncheckall' onclick=isCheckedAll('depts',false); value='<fmt:message key="BusinessCosts.slectopposite" />' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button'  onclick=getCheckValue('FeeType_s','thedept','dept','depts','~') value='<fmt:message key="BusinessCosts.sure" />' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'><input type='button' onclick=cancelTheOper('dept','thedept') value='<fmt:message key="BusinessCosts.cancel" />' style='line-height:25px;width:51px;height:25px;text-align:center;border:1px solid #b5b5b5; background:#f9f9f9;  margin-left:10px;'>"+'</td></tr>';
		var i=0;	
		var urlstr=buildParamsSql('query','xmlattr','ywslCode.getFeeType','');
		$.ajax({
			url:'mainServlet.html?'+urlstr,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				//将返回的结果集生成一个form出来
				//var thevalue = "<form name='thedeptform'><p><input type='button' id='checkall' onclick=isCheckedAll('depts',true); value='<fmt:message key="BusinessCosts.selectall" />' style='width:45px;height:22px;text-align:center'><input type='button' id='uncheckall' onclick=isCheckedAll('depts',false); value='<fmt:message key="BusinessCosts.slectopposite" />' style='width:45px;height:22px;text-align:center'><input type='button' onclick=getCheckValue('FeeType_s','thedept','dept','depts','~') value='<fmt:message key="BusinessCosts.sure" />' style='width:45px;height:22px;text-align:center'><input type='button' onclick=cancelTheOper('dept','thedept') value='<fmt:message key="BusinessCosts.cancel" />' style='width:45px;height:22px;text-align:center'></p>";
				if($(xml).find('row').text()=='false')
				{
					return false;
				}
				else
				{					
					$(xml).find('row').each(function(){
							var FeeType = $(this).attr("feetype");								
																						
							//生成复选框
			 				//thevalue += "<div style='width:245px;float:left;'><input type='checkbox' name='depts' value='"+FeeType+"' style='width:15px;height:15px;'><label style='text-align: left;line-height: 18px;width:190px'>"+FeeType+"</label></div>";
				
							if(i%3==0){
									thevalue +='<tr ><td height="20" width="160px" color="#666666"> '+"<input type='checkbox' name='depts' value='"+FeeType+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+FeeType+"</label>"+'</td>';
							}else if(i%3==1){
									thevalue +='<td color="#666666" width="160px"> '+"<input type='checkbox' name='depts' value='"+FeeType+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+FeeType+"</label>"+'</td>';
							}									
							else if(i%3==2){
									thevalue +='<td color="#666666" width="160px"> '+"<input type='checkbox' name='depts' value='"+FeeType+"' style='width:15px;height:15px;border:0px;'><label style='text-align: left;'>"+FeeType+"</label>"+'</td></tr>';
							}
							i++;
					});
				}
				
				//将form填充到那个span中
				//$('#thedept').html(thevalue+'</form>');
			}
		});
		thevalue +='</table>';	
		$('#thedept').html(thevalue);		
}
/**
 * 这个是在对用户信息进行修改的时候将用户以前的值默认为选中状态     
 * @param 无参数
 * @return 无返回值
 */	
function getDeptName(){
		
		//这个是在对用户信息进行修改的时候将用户以前的值默认为选中状态
		//var thestate = $('#thestate').val();
		//if(thestate==1){
			var thestavalue = $('#FeeType_s').val();
			forChecked('depts',thestavalue,'~');
		//}
}	


/**
 * 初始化getusertype 获取    
 * @param 无参数
 * @return 无返回值
 */	
function getusertype(){					
				$.ajax({
					url:'mainServlet.html?packgname=service&clsname=ExecuteSql&method=exeSqlData&ds=tsdBilling&tsdcf=mssql&tsdoper=query&datatype=xmlattr&tsdpk=jobdef.queryYwlxtype',
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){								
								//var TypeId=$(this).attr("typeid");
								//var TypeName=$(this).attr("typename");		
								var area="<option value='"+$(this).attr("typeid")+"'>"+$(this).attr("typename")+"</option>";								
								//document.getElementById("izhonglei").options.add(new Option(TypeName,TypeId));
								$("#TypeID_s").html($("#TypeID_s").html()+area);
						});
					}});
}
</script>
<script type="text/javascript">

var tabStatus = 1;
var primaryKeys = [
	["Fee_ID"],
	["TypeID","IDD"]
];
var prikeyIdx=[[1],[1,2]];
var tables = ["ywsl_feetype","ywsl_code"];
var pkeys = ["ywslFeeType","ywslCode"];
var fuheM = false;
var colNamess = [["<fmt:message key='global.operation' />"],["<fmt:message key='global.operation' />"]];
var colModels = [[],[]];
var firstLoad = [true,true];
var mNames = ["<fmt:message key='BusinessCosts.ywslFeeType' />","<fmt:message key='BusinessCosts.ywslCode' />"];

/**
 * 标题修改   
 * @param 无参数
 * @return 无返回值
 */
$(function(){
		//生成头部菜单
		$("#navBar").append(genNavv());
		getusertype();
		//初始化 添加面板
		
		$("#tabs").tabs();
		
		//权限的获取
		getUserPower();
		
		getDisVal('userType','yhlb',2);//显示用户类别
		getDisVal('sarea','yharea',1);//显示用户区域
		getDisVal('userProperty','yhxz',1);
		
		var addright = $("#addright").val();
		var exportright = $("#exportright").val();
		var printright = $("#printright").val();
		
		if(addright=="true"){
			document.getElementById("openadd1").disabled=false;
			document.getElementById("openadd2").disabled=false;
		}
		if(exportright=="true"){
			document.getElementById("export1").disabled=false;
			document.getElementById("export2").disabled=false;
		}
		ready1();
});
/**
 * 获取下拉选项值 -- edit by chenliang  
 * @param ids
 * @param flag
 * @param key
 * @return 无返回值
 */
function getDisVal(ids,flag,key){

	 var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'MonthPrice.getdisval'+flag//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    var tips = '';
    var disclick = '';
    
    if(key==3){
    	tips = '&yhlb='+getYhxzFlag(ids);
    }else if(key==2){
    	disclick = "onclick=getDisVal('userProperty','yhxz',3)";
    }
    
    $.ajax(
    {
        url : 'mainServlet.html?ian=1&' + urlstr + tips, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            var thevalue = "";
            var i = 1;
            var disx = 2;
            var disstyle = 'spanstyle';
            
            //var distype = 'checkbox';
            if(flag=='yhxz'){
               	disx = 3;
               	disstyle = 'spanstyle_yhxz';
            }
            //if(flag=='yhlb'){
            //	distype = 'radio';
            //}
            $(xml).find('row').each(function ()
            {
                if($(this).attr("res")!=undefined){
					var thebr = '';
	                if (i * 1 % disx*1 == 0) {
	                    thebr = '<br/>';
	                }
	                thevalue += "<span class='"+disstyle+"'><input type='checkbox' "+disclick+" name='disval"+ids+"' value='" + $(this).attr("res") + "' style='width:15px;height:15px;'><label style='text-align: left;margin-left:5px'>" + $(this).attr("res") + "</label></span>" + thebr;
	                i++;                
                }
            });
          	//<button type='button' id='ischeckalldepts' class='tsdbutton' onclick=isCheckedAll('depts','ischeckalldepts') style='margin-top: 0px;padding:0px 8px 0px 8px;line-height: 20px'><fmt:message key="BusinessCosts.selectall" /></button>
            //var disbutton = "<div style='text-align:center'><button type='button' class='tsdbutton' id='deptclick' onclick=operFlag('dept',2);checkedOK('depts','thedept','dept','departname') style='margin-top: 0px;padding:0px 8px 0px 8px;line-height: 20px'><fmt:message key="BusinessCosts.sure" /></button></div>";
            $('#'+ids).html(thevalue);
        }
    });
} 
/**
 * 区分用户类别显示用户性质 
 * @param ids(唯一标识)
 * @return String
 */
function getYhxzFlag(ids){
	var tagname = document.getElementsByName('disvaluserType');
    var val = '';
    //获取name的所有的值
    for (var i = 0 ; i < tagname.length; i++)
    {
        if (tagname[i].checked == true) {
            //val += "'" + tsd.encodeURIComponent(tagname[i].value) + "'" + ','; 
            val += "'"+tsd.encodeURIComponent(tagname[i].value) + "',";
        }
    }
    val = val.substring(0,val.lastIndexOf(","));
    if(val==''){
    	val = "'tsd'";
    }
    return val;
}
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
		$("#editgrid").empty();
		$("#fusearchsql").val("")
		switch(id)
		{
			case 1:
				tabStatus=1;
				//电话档案日志表
				ready1();
				//$("#editgrid").trigger("reloadGrid");
				break;
			case 2:
				tabStatus=2;
				//合同号档案日志表
				ready2();
				//$("#editgrid").trigger("reloadGrid");
				break;
			default:
				tabStatus=1;
				//电话档案日志表
				ready1();
		}		
}
/**
 * ready1  电话档案日志表
 * @param 无参数
 * @return 无返回值
 */
function ready1()
{
			
			var column  = '';
			var thisdata = loadData('ywsl_feetype','<%=languageType %>',1);
			column = thisdata.FieldName.join(',');
						 					
			var col=[[],[]];
			col=getRb_Field('ywsl_feetype','Fee_ID',"<fmt:message key='BusinessCosts.modifydeletedetail' />",'100','ziduansF');//得到jqGrid要显示的字段
			var column = $("#ziduansF").val();
			
			
			var FeeTypeg = thisdata.getFieldAliasByFieldName('FeeType');
			var Feeg = thisdata.getFieldAliasByFieldName('Fee');
			var Bzg = thisdata.getFieldAliasByFieldName('Bz');
			var Fee_IDg = thisdata.getFieldAliasByFieldName('Fee_ID');
			var startTimeg = thisdata.getFieldAliasByFieldName('startTime');
			var suendTimeg = thisdata.getFieldAliasByFieldName('suendTime');
			var sareag = thisdata.getFieldAliasByFieldName('sarea');
			var userTypeg = thisdata.getFieldAliasByFieldName('userType');
			var userPropertyg = thisdata.getFieldAliasByFieldName('userProperty');
			
			$('#thecolumn').val(column);
			$("#FeeTypeg").html(FeeTypeg);
			$("#Feeg").html(Feeg);
			$("#Bzg").html(Bzg);
			$("#Fee_IDg").html(Fee_IDg);
			$("#startTimeg").html(startTimeg);
			$("#suendTimeg").html(suendTimeg);
			$("#sareag").html(sareag);
			$("#userTypeg").html(userTypeg);
			$("#userPropertyg").html(userPropertyg);
			
			var urlstr=buildParamsSql('query','xml','ywslFeeType.query','ywslFeeType.querypage');
		
			$("#editgrid").jqGrid({
				//url:'mainServlet.html?'+urlstr+ "&cols="+colsStr,
				url:'mainServlet.html?'+urlstr+'&column='+column,
				datatype: 'xml',
				colNames:col[0],
				colModel:col[1],				
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'Fee_ID', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:"<fmt:message key='BusinessCosts.ywslFeeType' />", 
				       	height:document.documentElement.clientHeight-230, //高
				    	width:document.documentElement.clientWidth-65,
				       	loadComplete:function(){
				       					/***************
										////@1  表格的id
										////@2  链接名称
										////@3  链接地址或者函数名称
										////@4  行主键列的名称 可以是隐藏列
										////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
										////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	
										addRowOperBtn('editgrid',"<fmt:message key='global.edit' />",'openRowModify1','Fee_ID','click',1);
										addRowOperBtn('editgrid',"<fmt:message key='global.delete' />",'deleteRow1','Fee_ID','click',2);
									   */
										addRowOperBtnimage('editgrid','openRowModify','Fee_ID','click',1,"style/images/public/ltubiao_01.gif","<fmt:message key='global.edit' />","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'');//修改
										addRowOperBtnimage('editgrid','deleteRow1','Fee_ID','click',2,"style/images/public/ltubiao_02.gif","<fmt:message key='global.delete' />","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
										addRowOperBtnimage('editgrid','openRowInfo','Fee_ID','click',3,'style/images/public/ltubiao_03.gif',"<fmt:message key='BusinessCosts.detail' />","&nbsp;&nbsp;&nbsp;",'');//详细
										/****执行行按钮添加********
										*@1 表格ID
										*@2 操作按钮数量 等于定义数量
										*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
										executeAddBtn('editgrid',3);
									
										},
										ondblClickRow: function(ids) {
												if(ids != null) {
													var Fee_ID =$("#editgrid").getCell(ids,"Fee_ID");
													openRowInfo(Fee_ID,'');
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
 * loadHthdangold  loadJcFeilu 计次费率 合同号档案日志表
 * @param 无参数
 * @return 无返回值
 */
function ready2()
{			
			var column  = '';
			var thisdata = loadData('ywsl_code','<%=languageType %>',1);				 					
			var col=[[],[]];
			col=getRb_Field('ywsl_code','TypeID',"<fmt:message key='BusinessCosts.modifydeletedetail' />",'100','ziduansF','IDD');//得到jqGrid要显示的字段
			
			var column = $("#ziduansF").val();
			
			column = column.replace("TypeID,FeeType","getMultiValues(TypeID,'Ywsl_Type','TypeId','TypeName',',') TypeID,FeeType");
			var IDDg = thisdata.getFieldAliasByFieldName('IDD');
			var TypeIDg = thisdata.getFieldAliasByFieldName('TypeID');
			var Ywlxg = thisdata.getFieldAliasByFieldName('Ywlx');
			//var shownameg = thisdata.getFieldAliasByFieldName('showname');
			var shownameg = thisdata.getFieldAliasByFieldName('SHOWNAME');
			var FeeTypeg = thisdata.getFieldAliasByFieldName('FeeType');
			$('#thecolumn').val(column);
			$("#IDDg_s").html(IDDg);
			$("#TypeIDg_s").html(TypeIDg);
			$("#Ywlxg_s").html(Ywlxg);
			$("#shownameg_s").html(shownameg);
			$("#FeeTypeg_s").html(FeeTypeg);
		
			var urlstr=buildParamsSql('query','xml','ywslCode.query','ywslCode.querypage');
				
			$("#editgrid").jqGrid({
				//url:'mainServlet.html?'+urlstr+ "&cols="+colsStr,
				url:'mainServlet.html?'+urlstr+'&column='+column,
				datatype: 'xml', 
				colNames:col[0],
				colModel:col[1],
						rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'IDD', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:"<fmt:message key='BusinessCosts.ywslCode' />", 
				       	shrinkToFit: false,
				       	height:document.documentElement.clientHeight-230, //高
				    	width:document.documentElement.clientWidth-40,
				       	loadComplete:function(){
										/********************
										////@1  表格的id
										////@2  链接名称
										////@3  链接地址或者函数名称
										////@4  行主键列的名称 可以是隐藏列
										////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
										////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	
										addRowOperBtn('editgrid',"<fmt:message key='global.edit' />",'openRowModify2','TypeID','click',1,'IDD');
										addRowOperBtn('editgrid',"<fmt:message key='global.delete' />",'deleteRow2','TypeID','click',2,'IDD');
										*/
									   	addRowOperBtnimage('editgrid','openRowModify','TypeID','click',1,"style/images/public/ltubiao_01.gif","<fmt:message key='global.edit' />","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'IDD');//修改
										addRowOperBtnimage('editgrid','deleteRow2','TypeID','click',2,"style/images/public/ltubiao_02.gif","<fmt:message key='global.delete' />","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'IDD');//删除
										addRowOperBtnimage('editgrid','openRowInfo','TypeID','click',3,'style/images/public/ltubiao_03.gif',"<fmt:message key='BusinessCosts.detail' />","&nbsp;&nbsp;&nbsp;",'IDD');//详细
										/****执行行按钮添加********
										*@1 表格ID
										*@2 操作按钮数量 等于定义数量
										*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
										executeAddBtn('editgrid',3);
										},
										ondblClickRow: function(ids) {
											if(ids != null) {
												var TypeID =$("#editgrid").getCell(ids,"TypeID");
												var IDD =$("#editgrid").getCell(ids,"IDD");
												
												openRowInfo(TypeID,IDD);
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
 * 详细信息操作
 * @param key
 * @param key1
 * @return 无返回值
 */
function openRowInfo(key,key1){
		switch(tabStatus){
				case 1:
					markTable(1);//显示红色*号	
					//设置编辑框的标题
					$(".top_03").html("<fmt:message key='BusinessCosts.detailmessage' />");//标题	
				 	//将修改面板的输入框全部	置为不可用		
					isDisabledN('ywsl_feetype','',''); 
					clearText('operformT1');
					queryByID1(key);//取出数据库中改条记录，并放到修改面板中			
					var logoldstr = $("#logoldstr").val();
					var oldstr = logoldstr.split(',');							
					$("#FeeType").val(oldstr[0]);
					$("#Fee").val(oldstr[1]);
					$("#Bz").val(oldstr[2]);
					$("#Fee_ID").val(oldstr[3]);	
					
					openpan();
					break;
				case 2:
					opendsss();
					markTable(1);//显示红色*号	
					//设置编辑框的标题
					$(".top_03").html("<fmt:message key='BusinessCosts.detailmessage' />");//标题	
				 	//将修改面板的输入框全部	置为不可用		
					isDisabledN('ywsl_code','','_s'); 
					clearText('operformT2');
					queryByID2(key,key1);
												
					var logoldstr = $("#logoldstr").val();
					var oldstr = logoldstr.split(',');						
					//$("#FeeTypehidden").val(oldstr[2]);
					$("#IDD_s").val(oldstr[0]);
					$("#Ywlx_s").val(oldstr[1]);
					$("#showname_s").val(oldstr[2]);
					$("#FeeType_s").val(oldstr[3]);
										
					$("#TypeID_s").val(oldstr[4]);	
					openpan();
					getformInfo();
					break;
		}
}
/**
 * 取出一条数据显示在addform面板中
 * @param key(唯一标识)
 * @return 无返回值
 */
function queryByID1(key){
 		var urlstr=buildParamsSql('query','xmlattr','ywslFeeType.existed','');
		$("#Fee_ID").val(key);				 
			 					
		//key=$("#ID").val();
		$.ajax({
			url:'mainServlet.html?'+urlstr+'&Fee_ID='+key,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				/////////////////////////////
				//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
				$(xml).find('row').each(function(){
				//FeeType,Fee,Bz,
					//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
					///如果sql语句中指定列名 则按指定名称给参数
					var oldstr=[];
					var FeeType = $(this).attr("feetype");
					oldstr.push(FeeType);					
					//$("#FeeType").val(FeeType);
					var Fee = $(this).attr("fee");
					oldstr.push(Fee);
					//$("#Fee").val(Fee);
					var Bz = $(this).attr("bz");
					oldstr.push(Bz);	
					
					var startTime = $(this).attr("starttime");
					$('#startTime').val(startTime);
					var suendTime = $(this).attr("suendtime");
					$('#suendTime').val(suendTime);
					var sarea = $(this).attr("sarea");
					forChecked('disvalsarea',sarea);
					
					var userType = $(this).attr("usertype");
					forChecked('disvaluserType',userType);
					
					var userProperty = $(this).attr("userproperty");
					forChecked('disvaluserProperty',userProperty);
					
					var Fee_ID = $(this).attr("fee_id");
					oldstr.push(Fee_ID);
					//$("#Bz").val(Bz);
					$("#logoldstr").val(oldstr);
				});
			}
		});
}
/**
 * 取出一条数据显示在addform面板中
 * @param key
 * @param key1
 * @return 无返回值
 */
function queryByID2(key,key1){		 
 		var urlstr=buildParamsSql('query','xmlattr','ywslCode.existed','');
		$("#IDD_s").val(key);	
		$("#TypeID_s").val(key1);				 
			 					
		//key=$("#ID").val();
		$.ajax({
			url:'mainServlet.html?'+urlstr+'&TypeID='+key+'&IDD='+key1,
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
					var IDD = $(this).attr("idd");	
					oldstr.push(IDD);						
					//$("#FeeType").val(FeeType);
					var Ywlx = $(this).attr("ywlx");
					oldstr.push(Ywlx);	
					//$("#Fee").val(Fee);
					var showname = $(this).attr("showname");
					oldstr.push(showname);
					var FeeType = $(this).attr("feetype");
					oldstr.push(FeeType);	
					var TypeID = $(this).attr("typeid");
					oldstr.push(TypeID);
					//$("#Bz").val(Bz);
					
					$("#logoldstr").val(oldstr);
					
				});
			}
		});
} 
 
var closeflash = false;		
/**
 *  添加数据
 * @param saves
 * @return 无返回值
 */
function saveObj1(saves){
		//验证关键字是否重复
		var FeeType=delTrim($("#FeeType").val());
		if(FeeType==""||FeeType==null){
			alert("<fmt:message key='tariff.input'/>"+$("#FeeTypeg").html());
		  	$("#FeeType").focus();
		  	return false;
		 }
		var falg="true";
		var urlstr=tsd.buildParams({  
					  packgname:'service',//java包
					  clsname:'ExecuteSql',//类名
					  method:'exeSqlData',//方法名
					  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
					  tsdcf:'mssql',//指向配置文件名称
					  tsdoper:'query',//操作类型 
					  datatype:'xmlattr',//返回数据格式 
					  tsdpk:'ywslFeeType.queryByFeeType'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
					});		 					
		$.ajax({//hth	bm
			url:'mainServlet.html?FeeType='+tsd.encodeURIComponent(strtrim(FeeType))+urlstr,
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
					var FeeTypedb = $(this).attr("feetype");	
					if(FeeTypedb!=undefined){
						var str=$("#FeeTypeg").html();
						var operationtips = $("#operationtips").val();
						//已存在请重新输入！
						//jAlert(str+"<fmt:message key='tariff.isExist'/>",operationtips);
						alert(str+"<fmt:message key='tariff.isExist'/>");
						$("#FeeType").focus();
						falg="false";
						return false;
					}
				});
			}
		});
		if(falg=="false"){return false;}		
		var params=buildParams1();
		if(params==false){return false;}
		var urlstr=buildParamsSql('exe','xml','ywslFeeType.save','');
		
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
					alert(successful,operationtips);
					//setTimeout($.unblockUI, 15);
					
					//写入日志操作 
					var str ="(ywsl_feetype)<fmt:message key='BusinessCosts.ywslFeeType'/><fmt:message key='global.add'/>。"+$("#FeeTypeg").html()+": "+$("#FeeType").val()+";"+$("#Feeg").html()+": "+$("#Fee").val()+";"+$("#Bzg").html()+": "+strtrim($("#Bz").val());
					writeLogInfo("","add",tsd.encodeURIComponent(str));	
					
					if(saves==2){
						//fuheQuery();
						querylist();
						setTimeout($.unblockUI, 15);
					}else{
						closeflash=true;//表示关闭时需要刷新
						clearText('operformT1');
					}						
				}
			}
		});
}
/**
 *  关闭操作
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
 * 添加数据
 * @param saves
 * @return 无返回值(操作成功)/false(验证失败)
 */
function saveObj2(saves){

		//判断关键字是否已经存在
		var Ywlx = delTrim($("#Ywlx_s").val());
		if(Ywlx==""){
  			//jAlert("<fmt:message key='tariff.input'/>"+$("#Ywlxg").html(),operationtips);
  			alert("<fmt:message key='tariff.input'/>"+$("#Ywlxg_s").html());
  			$("#Ywlx_s").focus();
  			return false;
  		}
		var falg = '';
		var urlstr1=buildParamsSql('query','xmlattr','ywslCode.queryByYwlx','');
		//urlstr1 += params;
		$.ajax({
			url:'mainServlet.html?'+urlstr1+'&Ywlx='+tsd.encodeURIComponent(strtrim(Ywlx)),
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
					var Ywlxdb = $(this).attr("ywlx");
					if(Ywlxdb!=undefined){
						var operationtips = $("#operationtips").text();
						//套餐类型和费用名称的组合已经存在，请重新输入！
						var Ywlxg = $("#Ywlxg_s").text();
						
						//jAlert(Ywlxg+"<fmt:message key='tariff.isExist'/>",operationtips);
						alert(Ywlxg+"<fmt:message key='tariff.isExist'/>");
						$("#Ywlx_s").focus();
						falg="false";
						return false;
					}
				});
			}
		});
		if(falg=="false"){return false;}
		
		var params=buildParams2();
		if(params==false){return false;}
		var urlstr=buildParamsSql('exe','xml','ywslCode.save','');
		
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
					//setTimeout($.unblockUI, 15);
					
					//写入日志操作
					//IDD,Ywlx,FeeType,TypeID
					var str ="(ywsl_code)<fmt:message key='BusinessCosts.ywslCode'/><fmt:message key='global.add'/>。"
							+$("#IDDg_s").html()+": "+$("#IDD_s").val()+";"
							+$("#Ywlxg_s").html()+": "+$("#Ywlx_s").val()+";"
							+$("#shownameg_s").html()+": "+$("#showname_s").val()+";"
							+$("#TypeIDg_s").html()+": "+$("#TypeID_s").val()+";"
							+$("#FeeTypeg_s").html()+": "+$("#FeeType_s").val();
					writeLogInfo("","add",tsd.encodeURIComponent(str));	
				
					if(saves==2){
						//fuheQuery();
						querylist();
						setTimeout($.unblockUI, 15);
					}else{
						closeflash=true;//表示关闭时需要刷新
						clearText('operformT2');
					}
				}
			}
		});
}

/**
 * 通过调用存储过程修改对象
 * @param 无参数
 * @return 无返回值
 */
function modifyObj1(){
		var params = buildParams1();
		if(params==false){return false;}			
		var urlstr=buildParamsSql('exe','xml','ywslFeeType.modify','');
	 	urlstr+=params;
	 	//var	key=$("#ID").val();
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
					//写入日志 FeeType,Fee,Bz,
					var str ="(ywsl_feetype)<fmt:message key='BusinessCosts.ywslFeeType'/><fmt:message key='global.edit'/>。"+$("#FeeTypeg").html()+": "+oldstr[0]+">>>"+$("#FeeType").val()+";"+$("#Feeg").html()+": "+oldstr[1]+">>>"+$("#Fee").val()+";"+$("#Bzg").html()+": "+oldstr[2]+">>>"+strtrim($("#Bz").val());
					//str = transfer(str);
					writeLogInfo("","modify",tsd.encodeURIComponent(str));		
								
					//fuheQuery();
					querylist();
				}	
			}
		});
}
/**
 * 通过调用存储过程修改对象
 * @param 无参数
 * @return 无返回值
 */
function modifyObj2(){
		var params = buildParams2();
		if(params==false){return false;}			
			var urlstr=buildParamsSql('exe','xml','ywslCode.modify','');
		 	urlstr+=params;
		 	//var	key=$("#ID").val();
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
								//IDD,Ywlx,FeeType,TypeID
							
						//var FeeTypeform =$("#FeeTypeform").val();
						var logoldstr = $("#logoldstr").val();	
						var oldstr = logoldstr.split(',');
						//写入日志
						var str ="(ywsl_code)<fmt:message key='BusinessCosts.ywslCode'/><fmt:message key='global.edit'/>。"
						+$("#IDDg_s").html()+": "+$("#IDD_s").val()+";"
						+$("#TypeIDg_s").html()+": "+$("#TypeID_s").val()+";"
						+$("#Ywlxg_s").html()+": "+oldstr[1]+">>>"+$("#Ywlx_s").val()+";"
						+$("#shownameg_s").html()+": "+oldstr[2]+">>>"+$("#showname_s").val()+";"
						+$("#FeeTypeg_s").html()+": "+oldstr[3]+">>>"+$("#FeeType_s").val();
						//str = transfer(str);
						writeLogInfo("","modify",tsd.encodeURIComponent(str));		
						
						//fuheQuery();
						querylist();
					}	
				}
		});
}


/**
 * 删除操作
 * @param key(唯一标识)
 * @return 无返回值
 */
function deleteRow1(key){
 	 	/**************************
	 	*    是否有执行删除的权限    *
	 	*************************/		 
		var deleteright = $("#deleteright").val();
		if(deleteright=="true"){
			queryByID1(key);	
		 	var deleteinformation = $("#deleteinformation").val();
			var operationtips = $("#operationtips").val();
		 	jConfirm(deleteinformation,operationtips,function(x){
		 		 if(x==true){
		 		 	 
					var urlstr1=buildParamsSql('exe','xml','ywslFeeType.delete','');
					var urlstr='mainServlet.html?'+urlstr1+'&Fee_ID='+key; 
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
								var logoldstr = $("#logoldstr").val();	
								var oldstr = logoldstr.split(',');
								var str ="(ywsl_feetype)<fmt:message key='BusinessCosts.ywslFeeType'/><fmt:message key='global.delete'/>。"+$("#FeeTypeg").html()+": "+oldstr[0]+";"+$("#Feeg").html()+": "+oldstr[1]+";"+$("#Bzg").html()+": "+oldstr[2];
								//str = transfer(str);
								writeLogInfo("","delete",tsd.encodeURIComponent(str));
								//fuheQuery();	
								querylist();	
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
 * 删除操作2
 * @param key
 * @param key1
 * @return 无返回值
 */
function deleteRow2(key,key1){
		  		/**************************
			 	*    是否有执行删除的权限    *
			 	*************************/
				var deleteright = $("#deleteright").val();
				if(deleteright=="true"){
					queryByID2(key,key1);	
				 	var deleteinformation = $("#deleteinformation").val();
					var operationtips = $("#operationtips").val();
				 	jConfirm(deleteinformation,operationtips,function(x){
				 		 if(x==true){
				 		 	 
							var urlstr1=buildParamsSql('exe','xml','ywslCode.delete','');
							var urlstr='mainServlet.html?'+urlstr1+'&TypeID='+key+'&IDD='+key1;  	
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
																	
										var logoldstr = $("#logoldstr").val();	
										var oldstr = logoldstr.split(',');
										//写入日志
										var str ="(ywsl_code)<fmt:message key='BusinessCosts.ywslCode'/><fmt:message key='global.delete'/>。"
										+$("#IDDg_s").html()+": "+oldstr[0]+";"
										+$("#TypeIDg_s").html()+": "+oldstr[4]+";"
										+$("#Ywlxg_s").html()+": "+oldstr[1]+";"
										+$("#shownameg_s").html()+": "+oldstr[2]+";"
										+$("#FeeTypeg_s").html()+": "+oldstr[3];
										//str = transfer(str);
										writeLogInfo("","delete",tsd.encodeURIComponent(str));		
										//fuheQuery();	
										querylist();	
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
 * 批操作
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
			//fuheOpenModify();
			fuheM = true;//复合修改标志
			toggleBtn(0);
			disablePrimary(1);
			openAddForm();
		}
		else
		{
			fuheQuery();
		}
}
/**
 * 重新加载jQuery
 * @param 无参数
 * @return 无返回值
 */
function querylist(){
		//在调用此方法是清空符合查询的查询条件，避免导出或打印时显示信息有误
		$("#fusearchsql").val("");	
		switch(tabStatus){
			case 1:
				/////设置命令参数
				var urlstr=buildParamsSql('query','xml','ywslFeeType.query','ywslFeeType.querypage');	
				break;
			case 2:
				/////设置命令参数
				var urlstr=buildParamsSql('query','xml','ywslCode.query','ywslCode.querypage');
				break;
		}
		var column = $("#ziduansF").val();
		setTimeout($.unblockUI, 15);//关闭面板
		$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&column='+column}).trigger("reloadGrid");			
}
/**
 * 复合查询
 * @param 无参数
 * @return 无返回值
 */
function fuheQuery()
{
		//var colsStr = $("#cols").val();
		var params = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
		if(params=='&fusearchsql='){
			params +='1=1';
		}				
	 	//alert(params);
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
		//alert(pkeys[tabStatus-1]+'.fuheQueryByWhere');
		//var link = urlstr1 + params+ "&cols="+colsStr;
		var link = urlstr1 + params;
		var column = $("#ziduansF").val();
		//alert(link);	
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
	 	setTimeout($.unblockUI, 15);//关闭面板			
}

/**
 * 条件排序
 * @param sqlstr(组合排序条件)
 * @return 无返回值
 */
function zhOrderExe(sqlstr){
		var params = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
		if(params=='&fusearchsql='){
			params +='1=1';
		}
		params =params+'&orderby='+sqlstr;		
		/////var params ='&orderby='+sqlstr;			    
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
		var column = $("#ziduansF").val();
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
	 	//setTimeout($.unblockUI, 15);//关闭面板		 	
}
/**
 * 新增弹出的对话框
 * @param 无参数
 * @return 无返回值
 */
function openadd(){		
		markTable(0);//显示红色*号
		$(".top_03").html('<fmt:message key="global.add" />');//标题	
		switch(tabStatus){			
			case 1:	
				//opendsss();				
				removeDisabledN('ywsl_feetype','','');
				openpan();
				$("#save1").show();
	 			$("#readd1").show();
				clearText('operformT1');				
				break;
			case 2:		
				opendsss();			
				removeDisabledN('ywsl_code','','_s');
				openpan();
				$("#save2").show();
	 			$("#readd2").show();
	 			clearText('operformT2');
	 			getformInfo();
				break;	
			}
}
/**
 * 打开修改面板并加载将要修改的数据
 * @param key
 * @param key1
 * @return 无返回值
 */
function openRowModify(key,key1){
	var editright = $("#editright").val();
			if(editright=="true"){	
				switch(tabStatus){
					case 1:							
							markTable(0);//显示红色*号
							var editinfo = $("#editinfo").val();
						 	$(".top_03").html(editinfo);//设置编辑框的标题
							
							isDisabledN('ywsl_feetype','',''); //将修改面板的输入框全部	置为不可用	
							openpan();//显示修改面板							
							$("#modify1").show();$("#reset1").show();
							clearText('operformT1');//清空修改面板								
							
							queryByID1(key);//取出数据库中改条记录，并放到修改面板中	
		
							var logoldstr = $("#logoldstr").val();
							var oldstr = logoldstr.split(',');							
							$("#FeeType").val(oldstr[0]);
							$("#Fee").val(oldstr[1]);
							$("#Bz").val(oldstr[2]);
							$("#Fee_ID").val(oldstr[3]);							
															
							setTableFields();
							$('#FeeType').attr("disabled","disabled");
							$("#FeeType").removeClass();
							$("#FeeType").addClass("textclass2");			
							break;			
				case 2:
						opendsss();
						markTable(0);//显示红色*号
						var editinfo = $("#editinfo").val();
					 	$(".top_03").html(editinfo);//设置编辑框的标题				
					 		
						isDisabledN('ywsl_code','','_s');//将修改面板的输入框全部	置为不可用
						openpan();//显示修改面板
						$("#modify2").show();$("#reset2").show();
						clearText('operformT2');//清空修改面板	
						//queryByID2(key,'');	
						queryByID2(key,key1);
												
						var logoldstr = $("#logoldstr").val();
						var oldstr = logoldstr.split(',');						
						//$("#FeeTypehidden").val(oldstr[2]);
						
						$("#IDD_s").val(oldstr[0]);
						$("#Ywlx_s").val(oldstr[1]);
						$("#showname_s").val(oldstr[2]);
						$("#FeeType_s").val(oldstr[3]);			
						$("#TypeID_s").val(oldstr[4]);	
						
						setTableFields();					
						$('#Ywlx_s').attr("disabled","disabled");
						$("#Ywlx_s").removeClass();
						$("#Ywlx_s").addClass("textclass2");
						getformInfo();
					
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
 * 获取换号参数
 * @param 无参数
 * @return String
 */
function buildParams1(){
	 	//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;				
	 	var params='';			 	
	 	var FeeType = delTrim($("#FeeType").val());
	 	var Fee = delTrim($("#Fee").val());
	 	var userProperty = '';
		 	var userType = '';
		 	var userArea = '';
		 	
		 	var startTime = $('#startTime').val();
		 	if(''==startTime){
		 		alert('<fmt:message key="BusinessCosts.enterstarttime" />!');
		 		$('#startTime').focus();
		 		return;
		 	}
		 	var suendTime = $('#suendTime').val();
		 	if(''==suendTime){
		 		alert('<fmt:message key="BusinessCosts.enterstarttime" />!');
		 		$('#suendTime').focus();
		 		return;
		 	}
		 	
		 	var disArea = getTheChecked('disvalsarea');
		 	if(''==disArea){
		 		alert('<fmt:message key="BusinessCosts.effectivearea" />!');
		 		return;
		 	}
		 	var disType = getTheChecked('disvaluserType');
		 	if(''==disType){
		 		alert('<fmt:message key="BusinessCosts.userstyle" />!');
		 		return;
		 	}
		 	var disProperty = getTheChecked('disvaluserProperty');
		 	if(''==disProperty){
		 		alert('<fmt:message key="BusinessCosts.userproperties" />!');
		 		return;
		 	}
	 	var Bz = delTrim($("#Bz").val());
	 	var Fee_ID = delTrim($("#Fee_ID").val());		 
	 	
	 	var operationtips = $("#operationtips").val();
	 	
  		if(Fee==""){
  			Fee=0;
  		}	 	
	  	 	/***********************/
		 	//如果有可能值是汉字 请使用encodeURI()函数转码
		 	params+="&FeeType="+tsd.encodeURIComponent(strtrim(FeeType));			 		
	 	 	//如果有可能值是汉字 请使用encodeURI()函数转码
	 		params+="&Fee="+Fee;	
	 	 	//如果有可能值是汉字 请使用encodeURI()函数转码
	 		params+="&Bz="+tsd.encodeURIComponent(strtrim(Bz));
	 		params+="&Fee_ID="+Fee_ID;
	 		params=params+"&startTime="+tsd.encodeURIComponent(startTime);	
		  	params=params+"&suendTime="+tsd.encodeURIComponent(suendTime);	
		  	params=params+"&sarea="+tsd.encodeURIComponent(disArea);	
		  	params=params+"&userType="+tsd.encodeURIComponent(disType);	
		  	params=params+"&userProperty="+tsd.encodeURIComponent(disProperty);	
	 	 	
		//每次拼接参数必须添加此判断
		if(tsd.Qualified()==false){return false;}
		return params;
}		
/**
 * 获取已经选中的值 -- eidt by chenliang
 * @param name(进行操作文本框name)
 * @param thisvalue(进行操作文本框value)
 * @return 无返回值
 */
function forChecked(name, thisvalue)
{
    if ('' != thisvalue && null != thisvalue)
    {
        var thenum = thisvalue.lastIndexOf('~');
        var m = 0;
        if (thenum ==- 1) {
            thisvalue += '~';
            m = 1;
        }
        var thearr = thisvalue.split('~');
        var tagname = document.getElementsByName(name);
        //获取name的所有的值
        for (var i = 0 ; i < tagname.length; i++)
        {
            //获取以前的记录选中值
            for (var j = 0; j < thearr.length - m; j++) {
                if (tagname[i].value == thearr[j]) {
                    
                    
                    if($(tagname[i]).attr("name")=="disvaluserType")
                    {
                    	//alert(tagname[i].onclick);
                    	tagname[i].checked = true;
                    	tagname[i].onclick();
                    	//$(tagname[i]).click();
                    }
                    else
                    	tagname[i].checked = true;
                    break;
                }
            }
        }
    }
}
/**
 * 获取被选中的值 -- eidt by chenliang
 * @param name(进行操作文本框name)
 * @return String
 */
function getTheChecked(name)
{
    var thename = document.getElementsByName(name);
    var thevalue = '';
    for (var i = 0; i < thename.length; i++) {
        if (thename[i].checked == true) {
            thevalue += thename[i].value + '~';
        }
    }
    if(thevalue!=''){
    	thevalue = thevalue.substring(0,thevalue.lastIndexOf('~'));
    }
    return thevalue;
}
/**
 * 获取换号参数 Ywlx,FeeType,TypeID
 * @param 无参数
 * @return String
 */
function buildParams2(){
	 	//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;				
	 	var params='';
	 	
	 	var Ywlx = delTrim($("#Ywlx_s").val());
	 	var TypeID = delTrim($("#TypeID_s").val());
	 	var showname = delTrim($("#showname_s").val());
	 	var IDD = $("#IDD_s").val();
	 	
	 	var operationtips = $("#operationtips").val();
	 					
	 	if(TypeID!=""&&!isDigit(TypeID)){		  			
  		}
  		else if(TypeID==""){
  			alert("<fmt:message key='tariff.input'/>"+$("#TypeIDg_s").html());
  			$("#TypeID_s").focus();
  			return false;
  		}
  		if(Ywlx==""){
  			alert("<fmt:message key='tariff.input'/>"+$("#Ywlxg_s").html());
  			$("#Ywlx_s").focus();
  			return false;
  		}
  		
  		var FeeType =$("#FeeType_s").val();		 
  		
	  	 $("#FeeTypeform").val(FeeType);	
	 	//如果有可能值是汉字 请使用encodeURI()函数转码
	 	params+="&Ywlx="+tsd.encodeURIComponent(strtrim(Ywlx));
	 	params+="&showname="+tsd.encodeURIComponent(strtrim(showname));	
 		params+="&TypeID="+TypeID;	
 		params+="&IDD="+IDD;
 		params+="&FeeType="+tsd.encodeURIComponent(strtrim(FeeType));
	 	 	
		//每次拼接参数必须添加此判断
		if(tsd.Qualified()==false){return false;}
		return params;
}
/**
 * 字段权限控制
 * @param 无参数
 * @return 无返回值
 */
function setTableFields(){
		switch(tabStatus){
				case 1:
					var editfields = $("#editfields").val();
								
					/*************************************
					**   将当前表的所有字段取出来，分割字符串 ***
					*************************************/
				
					var fields = getFields("ywsl_feetype");
																	
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
				
					var fields = getFields("ywsl_code");
																	
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
									$('#'+arr[i]+'_s').removeAttr("disabled");						
									$('#'+arr[i]+'_s').removeClass();
									$('#'+arr[i]+'_s').addClass("textclass");												
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
 * @param 无参数
 * @return 无返回值
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
 * @param 无参数
 * @return 无返回值
 */
function openpan(){
	switch(tabStatus){
			case 1:				
				autoBlockFormAndSetWH('panTab1',60,5,'closeo1',"#ffffff",false,1000,'');//弹出查询面板				
				$("#readd1").hide();$("#save1").hide();$("#modify1").hide();$("#reset1").hide();$("#clearB1").hide();
				break;
				
			case 2:							
				autoBlockFormAndSetWH('panTab2',60,5,'closeo2',"#ffffff",false,1000,'');//弹出查询面板				
				$("#readd2").hide();$("#save2").hide();$("#modify2").hide();$("#reset2").hide();$("#clearB2").hide();
				break;
	}		
}
/**
 * 修改单挑记录时的信息重置方法
 * @param 无参数
 * @return 无返回值
 */
function resett(){		
		switch(tabStatus){
			case 1:
				var key=delTrim($("#Fee_ID").val());
				//取消修改，给表单覆数据初值
				queryByID1(key);
				
				var logoldstr = $("#logoldstr").val();
				var oldstr = logoldstr.split(',');							
				$("#FeeType").val(oldstr[0]);
				$("#Fee").val(oldstr[1]);
				$("#Bz").val(oldstr[2]);
				$("#Fee_ID").val(oldstr[3]);	
				break;
			case 2:
				var key=delTrim($("#IDD_s").val());
				var key1=delTrim($("#TypeID_s").val());
				queryByID2(key1,key);
												
				var logoldstr = $("#logoldstr").val();
				var oldstr = logoldstr.split(',');						
				//$("#FeeTypehidden").val(oldstr[2]);
				
				$("#IDD_s").val(oldstr[0]);
				$("#Ywlx_s").val(oldstr[1]);
				$("#showname_s").val(oldstr[2]);
				$("#FeeType_s").val(oldstr[3]);		
				$("#TypeID_s").val(oldstr[4]);	
				break;
		}
}	
</script>
<script type="text/javascript">
/**
 * 打开对话框
 * @param oper
 * @return 无返回值
 */
function showDialog(oper)
{
		var t_name = "";
		if(tabStatus==1)
			t_name = "ywsl_feetype";
		else 
			t_name = "ywsl_code";
					
		//通过oper判断是插叙还是排序，控制打开窗口的方式
		if(oper==0)openDiaO(t_name);
		else openDiaQ('query',t_name);
		//alert(t_name);
		//alert(oper);
		
		/**********************
		oper = oper==0?"order.jsp":"search.jsp";
		if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){  
			window.showModalDialog("/tsd2009/queryServlet?tablename="+t_name+"&url=/"+oper,window,"dialogWidth:700px; dialogHeight:500px; center:yes; scroll:no");
	    }
	    else{
			window.showModalDialog("/tsd2009/queryServlet?tablename="+t_name+"&url=/"+oper,window,"dialogWidth:620px; dialogHeight:600px; center:yes; scroll:no");
		}
		*************************/
}

/**
 * 打开查询面板
 * @param 无参数
 * @return 无返回值
 */
function openSearch()
{
		$("#queryName").val("query");
		//showDialog(1);
		openDiaQueryG("query",tabStatus==1?"ywsl_feetype":"ywsl_code",'1');
}
/**
 * 打开批量删除面板
 * @param 无参数
 * @return 无返回值
 */
function openBatchDelete()
{
		$("#queryName").val("delete");
		showDialog(1);
}
/**
 * 打开批量修改面板
 * @param 无参数
 * @return 无返回值
 */
function openBatchEdit()
{
		opendsss();
		$("#queryName").val("modify");
		showDialog(1);
}
/**
 * 打印报表
 * @param 无参数
 * @return 无返回值
 */
function printBB(){
		
		if(tabStatus==1)
			printThisReport('userManagement/Yhdangold',getPriParams());
		else if(tabStatus==2)
			printThisReport('userManagement/Hthdangold',getPriParams());
		else if(tabStatus==3)
			printThisReport('userManagement/AttachFeeold',getPriParams());
		else
			printThisReport('userManagement/bytcdetailoldcpt',getPriParams());
}
/**
 * 导出操作
 * @param 无参数
 * @return 无返回值
 */
function saveExoprt(){
		switch(tabStatus){
			case 1:			
					getTheCheckedFields('tsdBilling','mssql','ywsl_feetype');				
					break;
			case 2:			
					getTheCheckedFields('tsdBilling','mssql','ywsl_code');
					break;			
		}
 }
/**
 * 打开导出操作面板
 * @param 无参数
 * @return 无返回值
 */
function openExport(){
 		switch(tabStatus){
			case 1:			
					thisDownLoad('tsdBilling','mssql','ywsl_feetype','<%=languageType %>');				
					break;
			case 2:			
					thisDownLoad('tsdBilling','mssql','ywsl_code','<%=languageType %>');	
					break;			
		}
 }
</script>
<style type="text/css">
	.spanstyle{display:-moz-inline-box; display:inline-block; width:135px;}
	.spanstyle_yhxz{display:-moz-inline-box; display:inline-block; width:140px;}
			#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
			cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
			.a{border:1px solid #ccc;width:500px;overflow:left;text-overflow:ellipsis;margin-left: 130px;}
</style>
</head>

<body> 
	<!-- 用户操作导航-->
		<div id="navBar1">
			<table width="100%" height="26">
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
  
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="openadd1" onclick="openadd();"  disabled="disabled">
				<!-- 新增 --><fmt:message key="global.add" />
		</button>
		<button type="button" onclick="openSearch()">
			<fmt:message key="BusinessCosts.advanced" /><fmt:message key="global.query" />
		</button>	
		<button type="button" id="export1" onclick="openExport();" disabled="disabled"> 
			<!--导出--><fmt:message key="global.exportdata" />
		</button>
		<!-- 
			<button type="button" id="openorder1" onclick="showDialog(0)">
				排序<fmt:message key="order.title" />
			</button>
		-->
		
		
	</div>
	<!-- Tabs -->
	<div id="tabs">	
		<ul>
			<li><a href="#gridd" onclick="tabsChg(1)"><span><fmt:message key='BusinessCosts.ywslFeeType' /></span></a></li>
			<li><a href="#gridd" onclick="tabsChg(2)"><span><fmt:message key='BusinessCosts.ywslCode' /></span></a></li>
		</ul>
		<div id="gridd">
		    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
		</div>		
	</div>
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
			
		<button type="button" id="openadd2" onclick="openadd();" disabled="disabled">
			<!-- 新增 --><fmt:message key="global.add" />
		</button>	
		<button type="button" onclick="openSearch()">
			 <fmt:message key="BusinessCosts.advanced" /> <fmt:message key="global.query" />
		</button>
		<button type="button" id="export2" onclick="openExport();" disabled="disabled"> 
			<!--导出--><fmt:message key="global.exportdata" />
		</button>
		<!-- 
			<button type="button" id="openorder2" onclick="showDialog(0)">
				 排序 <fmt:message key="order.title" />
			</button>
			
		-->
		
	</div>
	
	
	
<!-- 添加修改面板 read1 -->
<div class="neirong" id="panTab1" style="display: none">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="BusinessCosts.functionname" /></div>
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
			    <td width="12%" align="right" class="labelclass"><label id="FeeTypeg" ></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="FeeType" id="FeeType" onpropertychange="TextUtil.NotMax(this)" maxlength="30" class="textclass"></input>
			    	<label class="addred" ></label></td>
			   
			    <td width="12%" align="right"  class="labelclass"><label id="Feeg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="Fee" id="Fee" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="10" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false" class="textclass"></input>
				</td>
			
			    <td width="12%" align="right"  class="labelclass"><label id="Fee_IDg" style="display: none;"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="hidden" id='Fee_ID' name='Fee_ID'/></td>
			</tr>
			<tr>			   
			    <td width="12%" align="right" class="labelclass"><label id="startTimeg" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="startTime" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" id="startTime"  class="textclass"></input>							
					<label class="addred" ></label></td>
			    <td width="12%" align="right" class="labelclass"><label id="suendTimeg" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="suendTime" id="suendTime" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" class="textclass"></input>							
					<label class="addred" ></label></td>
			    <td width="12%" align="right" class="labelclass"><label id="sareag" ></label></td>							
			    <td width="22%" style="border-bottom:1px solid #A9C8D9;" height="20px">
			    	<table>
			    		<tr>
			    			<td>
			    				<div id="sarea" style="height: 45px;width:195px;overflow-y: auto;overflow-x: hidden;background-color: #FFFFFF;border: 1;margin-bottom: 2px"></div>
			    			</td>
			    			<td>
			    				<label class="addred" ></label>
			    			</td>
			    		</tr>
			    	</table>
				</td>
			</tr>
		    
		    <tr>			   
			    <td width="12%" align="right" class="labelclass"><label id="userTypeg" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<table>
			    		<tr>
			    			<td>
			    				<div id="userType" style="height: 100px;width:195px;overflow-y: auto;overflow-x: hidden;background-color: #FFFFFF;border: 1"></div>
			    			</td>
			    			<td>
			    				<label class="addred" ></label>
			    			</td>
			    		</tr>
			    	</table>
				</td>
			    <td width="12%" align="right" class="labelclass"><label id="userPropertyg" ></label></td>							
			    
			    <td width="22%" align="left" colspan="3" style="border-bottom:1px solid #A9C8D9;">
			    	<table>
			    		<tr>
			    			<td>
			    				<div id="userProperty" style="height: 100px;width:510px;overflow-y: auto;overflow-x: hidden;background-color: #FFFFFF;border: 1;margin-bottom: 2px"></div>
			    			</td>
			    			<td>
			    				<label class="addred" ></label>
			    			</td>
			    		</tr>
			    	</table>
					
				</td>
			</tr>
			 <tr>
			    <td width="12%" align="right" class="labelclass"><label id="Bzg" ></label></td>
			    <td width="56%" colspan="3" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<textarea name="Bz" id="Bz"  class="textclass" onpropertychange="TextUtil.NotMax(this)" maxlength="50" ></textarea>
			    	</td>
			    <td width="12%" align="right"  class="labelclass"></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
			</tr>	  	
		  
		</table>
		</form>	
		<div class="midd_butt">
		<!-- 保存新增 --><button class="tsdbutton" id="readd1" style="width:80px;heigth:27px;" onclick="saveObj1(1);" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
	 	<!-- 保存退出 --><button class="tsdbutton" id="save1" style="width:80px;heigth:27px;" onclick="saveObj1(2);" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
		<!-- 修改     --><button class="tsdbutton" id="modify1" style="width:63px;heigth:27px;" onclick="modifyObj1();"><fmt:message key="global.edit" /></button>		    
	    <!-- 清空     --><button class="tsdbutton" id="clearB1" style="width:63px;heigth:27px;" onclick="clearText('operformT1');" ><fmt:message key="global.clear" /></button>
	    <!-- 取消     --><button class="tsdbutton" id="reset1" style="width:63px;heigth:27px;" onclick="resett();" ><fmt:message key="BusinessCosts.cancel" /></button>
		<!-- 关闭 	 --><button class="tsdbutton" id ='closeo1' style="width:63px;heigth:27px;" onclick="closeo();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>	


<!-- 添加修改面板 read2 -->
<div class="neirong" id="panTab2" style="display: none">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="BusinessCosts.functionname" /></div>
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
			    <td width="12%" align="right" class="labelclass"><label id="Ywlxg_s" ></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="Ywlx_s" id="Ywlx_s" class="textclass" onpropertychange="TextUtil.NotMax(this)" maxlength="20"></input>
			    	<label class="addred" ></label></td>
			   			   
			    <td width="12%" align="right"  class="labelclass"><label id="shownameg_s"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="showname_s" id="showname_s" class="textclass"  maxlength="20"></input>			    
			    	<input type="hidden" id='IDD_s' name='IDD_s'/>
			    	<label id="IDDg_s" style="display: none;"></label></td>
			    	
			    <td width="12%" align="right"  class="labelclass"><label id="TypeIDg_s"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<select name="TypeID_s" id="TypeID_s" class="textclass" >
						<option value="" ><fmt:message key="global.select"/></option>
					</select>
					<label class="addred" ></label></td>			   
			</tr>			
			<tr>
			    <td colspan="6" align="left" bgcolor="#FFFFFF">
			    <!-- 减免字段 -->
			    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
			       		<tr>
			       			<td width="12%" align="right" style="background:#F0F7FB; border-bottom:1px solid #A9C8D9; padding-right:1%;">
			       			<label id="FeeTypeg_s" ></label></td>
			        		
			       			<td width="58%" style=" border-bottom:1px solid #A9C8D9;">
			       			<div style="width:550px;height: 116px;overflow-y: scroll;">
			         		<span id="dept">
								<textarea rows="12" cols="40" id='FeeType_s' onfocus="getTheDept();" style="min-height:50px;height:auto;overflow: hidden;" maxlength="128"></textarea>	
							</span>
							<span id="thedept" style="display: none;"></span>
							</div>
				   			</td>
			       			<td width="30%" style=" border-bottom:1px solid #A9C8D9;">&nbsp;</td>
			     		</tr>
			    	</table>
			    </td>			  
	    	</tr>
		 		  	
		  
		</table>
		</form>	
		<div class="midd_butt">
		<!-- 保存新增 --><button class="tsdbutton" id="readd2" style="width:80px;heigth:27px;" onclick="saveObj2(1);" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
	 	<!-- 保存退出 --><button class="tsdbutton" id="save2" style="width:80px;heigth:27px;" onclick="saveObj2(2);" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
		<!-- 修改     --><button class="tsdbutton" id="modify2" style="width:63px;heigth:27px;" onclick="modifyObj2();"><fmt:message key="global.edit" /></button>		    
	    <!-- 清空     --><button class="tsdbutton" id="clearB2" style="width:63px;heigth:27px;" onclick="clearText('operformT2');" ><fmt:message key="global.clear" /></button>
	    <!-- 取消     --><button class="tsdbutton" id="reset2" style="width:63px;heigth:27px;" onclick="resett();" ><fmt:message key="BusinessCosts.cancel" /></button>
		<!-- 关闭 	 --><button class="tsdbutton" id ='closeo2' style="width:63px;heigth:27px;" onclick="closeo();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>		
	
	

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
					<input type="hidden" id="editfields_son"/>
					<input type="hidden" id="delBright"/>
					<input type="hidden" id="editBright"/>
					<input type="hidden" id="exportright" />
					<input type="hidden" id="printright" />
					
					<input type="hidden" id="ordertable" />
					<input type="hidden" id="meetid" />	
					<!-- 用于写入日志 -->
				   <input type="hidden" id="userloginip" value="<%=Log.getIpAddr(request) %>"/> 
				   <input type="hidden" id="userloginid" value="<%=session.getAttribute("userid") %>"/> 
				   <input type="hidden" id="thislogtime" value="<%=Log.getThisTime() %>" />
				   <!-- 修改时保存原来数据的隐藏域 --> 	
				   <input type="hidden" id="logoldstr" />		
				   <input type="hidden" id="useridd" value="<%=userid %>"/>		
				   <!-- grid自动 -->
					<input type="hidden" id='ziduansF' />
					<input type='hidden' id='thecolumn'/>	
				   					
				</div>	
	
	<form name="childform" id="childform">
		<input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
		<input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
	</form>

	<input type="hidden" id="skrid" name="skrid" value='<%=request.getSession().getAttribute("userid") %>' />
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
	<input type="hidden" name="languageType" id="languageType" value='<%=languageType %>' />

	<!-- mssql 语句中 查询列表记录 -->
	<input type="hidden" id="cols"/>
	<!-- 添加隐藏域：用于获取项目的绝对路径 -->
					<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 	
	<!-- mssql 语句中 查询列表记录 用于下载 -->
	<input type="hidden" id="121"/>
	<input type="hidden" id="122"/>
	
	<input type="hidden" id="FeeTypeform"/>
	<input type="hidden" id="FeeTypehidden"/>
	
		
		
		<!-- 导出数据 -->
			<div class="neirong" id="thefieldsform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv"><fmt:message key="BusinessCosts.chooseexportdata" /></div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();"><fmt:message key="BusinessCosts.close" /></a></div>
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
						<fmt:message key="BusinessCosts.selectall" />
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
