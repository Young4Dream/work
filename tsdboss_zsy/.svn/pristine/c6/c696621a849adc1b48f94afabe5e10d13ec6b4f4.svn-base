﻿/*****************************************************************
 * name: script/telephone/linemanagement/XQselDeviceType.js
 * author: 尤红玉
 * version: 001.0, 2011-9-28
 * description: 小区号线设备管理-->选择设备面板
 * modify:
 *****************************************************************/

/**
* 显示树结构
* @param 
* @return 
*/
 function showDeviceTree(type){

 	var mokuaiju = $("#mokuaiju").val();
 	
 	//获取设备数信息
 	var jsonstr = $("#jsoninfo").val();
 	var obj = eval('(' + jsonstr + ')');
			
 	var setting = {
		showLine: true,
		async : true,		
		callback : {
      		click: zTreeOnClick
    	}		
	};	
	
	var setting1 = clone(setting);
	setting1.isSimpleData=true;	
	setting1.treeNodeKey = "id";
	setting1.treeNodeParentKey = "pid";			
	var zNodes1 = clone(obj.rows);		
	setting1.nameCol = "name";
	setting1.expandSpeed = "";
	zTree1 = $("#tree").zTree(setting1, zNodes1);	
	
 }
 /**
* 树节点单击事件
* @param 
* @return 
*/
 function zTreeOnClick(){ 	
 	var selectedNode = zTree1.getSelectedNode();
 	var id =selectedNode.id;
 	var name = selectedNode.name;
 	var pname= selectedNode.pname;
 	//var pid = selectedNode.pid ;
 	//var name = selectedNode.name;
 	
 	//判断改节点是否为二级设备节点
 	var fieldarr = id.split(".");
 	if(fieldarr.length==2){
 		//$("#TwoDeviceName").val(name);
 		$("#TwoDeviceName").attr("nodeid",id);
 		$("#TwoDeviceName").attr("nodename",name);
 		$("#TwoDeviceName").attr("pnodename",pname);
 		
 		//显示jqgrid数据 
 		reloadJQgrid(1,id); 		
 	}
 }
 /////////////////////////////////////////////////////////////////////////
 ////////////////////////////////////////////////////////////////////////
 /**
* 显示jqgridm面板
* @param 
* @return 
*/
function showJQgrid(){

		var tsdpkstr = 'XQselDeviceMx.querybyno';
		var tsdpkpagestr ='XQselDeviceMx.querybynopage';
		var mokuaiju= $("#mokuaiju").val();
		var deviceField= $("#deviceField").val();
		var pamars ='';
		pamars +='&deviceField='+deviceField;
		pamars +='&mokuaiju='+tsd.encodeURIComponent(mokuaiju);
		
		//设置命令参数		
		var urlstr = tsd.buildParams({
						        packgname : 'service', //java包
						        clsname : 'ExecuteSql', //类名
						        method : 'exeSqlData', //方法名
						        ds : 'tsdBilling', //数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
						        tsdcf : 'mssql', //指向配置文件名称
						        tsdoper : 'query', //操作类型 
						        datatype : 'xml', //返回数据格式 
						        tsdpk : tsdpkstr, //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						        tsdpkpagesql : tsdpkpagestr//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
		});
		$("#editgrid").jqGrid({					
			url:'mainServlet.html?'+urlstr+pamars,
			datatype: 'xml', 
			colNames : ['序号', '设备名称','模块局','电话数','宽带数'], 
        	colModel : [ 
		        //如果有操作列 请勿更改或者删除
		        {
		            name : 'xqlineid', index : 'xqlineid', width : 100
		        },
		        {
		            name : deviceField, index : deviceField, width : 250
		        },
		        {
		            name : 'mokuaiju', index : 'mokuaiju', width : 180
		        },
		        {
		            name : 'phonenums', index : 'phonenums', width : 110
		        },
		        {
		            name : 'broadbandnums', index : 'broadbandnums', width : 110 
		        }], 				      
			       	rowNum:10, //默认分页行数
			       	rowList:[10,15,20], //可选分页行数
			       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
			       	pager: jQuery('#pagered'), 
			       	sortname: 'xqlineid', //默认排序字段
			       	viewrecords: true, 
			       	//hidegrid: false, 
			       	sortorder: 'asc',//默认排序方式 
			       	caption:'设备模块信息', 
			       	height:260, //高
			       	width:400,
			       	//width:document.documentElement.clientWidth-27,
			       	loadComplete:function(){
			       		
							if ($("#editgrid tr.jqgrow[id='1']").html() == "") {
				                return false;
				            }
				            			
					},
					ondblClickRow: function(ids) {
						if(ids != null) {
							var xqlineid =$("#editgrid").getCell(ids,"xqlineid");
							window.dialogArguments.getTheVlaueR(xqlineid);
							window.close();
							//$("#DeviceType_line").val(Deviceinfo);
							//openTheDeviceMx(DeviceNo);
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
* 更新jqgrid数据
* @param type :1： 初始化，2：根据设备名称进行模糊查询
* @param deviceno:设备名称
* @return 
*/
function reloadJQgrid(type,deviceno){
	var tsdpkstr='';
	var tsdpkpagestr='';
	var pamars ='';
	var mokuaiju= $("#mokuaiju").val();
	var deviceField= $("#deviceField").val();
	pamars +='&deviceField='+deviceField;
	pamars +='&mokuaiju='+tsd.encodeURIComponent(mokuaiju);
	if(type==1){//初始化查询
		var tsdpkstr = 'XQselDeviceMx.querybyno';
		var tsdpkpagestr ='XQselDeviceMx.querybynopage';		
	}else if(type==2){//通过设备名称模糊查询
		tsdpkstr = 'XQselDeviceMx.querybyname';
		tsdpkpagestr ='XQselDeviceMx.querybynamepage';
		var deviceName = $("#deviceNameQ").val();
		pamars +='&deviceName='+tsd.encodeURIComponent(deviceName);
	}
	//设置命令参数		
	var urlstr = tsd.buildParams({
					        packgname : 'service', //java包
					        clsname : 'ExecuteSql', //类名
					        method : 'exeSqlData', //方法名
					        ds : 'tsdBilling', //数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
					        tsdcf : 'mssql', //指向配置文件名称
					        tsdoper : 'query', //操作类型 
					        datatype : 'xml', //返回数据格式 
					        tsdpk : tsdpkstr, //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
					        tsdpkpagesql : tsdpkpagestr//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
	});
	
	 $("#editgrid").setGridParam(
     {
         url : "mainServlet.html?" + urlstr +pamars
     }).trigger('reloadGrid');		
}
 /**********************************************************
				function name:   getTreeJson()
				function:		 
				parameters:      type:      
				return:			 
				description:     获取设备树节点json串
				Date:			2011-6-8 22:08:38
********************************************************/
function getTreeJson(){
	var falg='F';
	var tsdpkstr ='selDeviceMx.querythedevice';
	//nodesects
	var nodesects = window.dialogArguments.document.getElementById("Rounttype_hide").value;
	var urlstr=tsd.buildParams({ 	      packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'jsonattr',//返回数据格式 
										  tsdpk:tsdpkstr
							   });
	var mokuaiju = $("#mokuaiju").val();
	var deviceno = $("#deviceno_P").val();
	urlstr = urlstr+"&mokuaiju='"+tsd.encodeURIComponent(mokuaiju)+"'"+"&nodesects="+nodesects;
	urlstr +="&deviceno="+deviceno;
	var jsonstr ='';
	$.ajax({
		url:"mainServlet.html?"+urlstr,
		datatype:'json',
		cache:false,//如果值变化可能性比较大 一定要将缓存设成false
		timeout: 1000,
		async: false ,//同步方式
		success:function(json){	
			/******************			
			如果别名表没有相应的信息，
			提示：别名表中无符合条件信息！
			
			//json.xml 是将json变量中存放的json字符串直接转化成xml格式
			*******************/
			
			if(json.xml==undefined){
				jsonstr = translateHtml(json);
				$("#jsoninfo").val(jsonstr);
				falg='T';					
			}		
			else if($(json.xml).find('row').length==0){
				alert("无设备信息！");
				falg='F';						
			}else{
				falg='T';
			}
		}
	});		
	return falg;
}

///////////////////////////////////////////////////////////////////
/**
* 显可用设备
* @param DeviceNo：设备
* @return 
*/
function openTheDeviceMx(DeviceNo){
	//获取可用端口个数
	var num= fetchSingleValue("userLineManager.querythemxNUM",6,"&DeviceNo="+tsd.encodeURIComponent(DeviceNo)+"&NodeState=free");
	//无可用端口不打开端口面板
	if(num>0){
		window.showModalDialog('mainServlet.html?pagename=telephone/linemanagement/theDeviceMx.jsp&DeviceNo='+DeviceNo,window,"dialogWidth:880px; dialogHeight:400px; center:yes; scroll:yes");
	}else{
		alert("该模块下没有可用端口！");
	}
}

/**
* 获取被选中设备  2010-11-24传递父节点编号 
* @param str：端子名称
* @param DeviceNo：端口编号
* @param pdvno：父节点编码
* @return 
*/
function getTheSelected(str,DeviceNo,pdvno){
	var thei = $('#NodeField').val();//路由面板上的路由信息框
	var pnodename = $("#TwoDeviceName").attr("pnodename");//设备类型
	var nodename = $("#TwoDeviceName").attr("nodename");//设备名称
	var subname=$("#DeviceType_line").val();
	//nodename = pnodename+""+nodename+"】"+subname;
	//nodename = pnodename+"【"+nodename+"】";//2011-8-26 改
	nodename = pnodename;//设备类型
	window.dialogArguments.getTheVlaueR(thei,nodename,str,pdvno,DeviceNo);
	window.close();
}

//关闭本模块窗口
function closeDialog(){
	window.close();
}

