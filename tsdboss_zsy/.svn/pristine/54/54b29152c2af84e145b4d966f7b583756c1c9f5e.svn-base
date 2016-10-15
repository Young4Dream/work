
/***********************************************************
		        file name:       RouteManage.js
				author:          youhongyu 
				create date:     2012-3-23         
				description:
				modify:			
********************************************************/

/**********************************************************
				function name:   queryUser()
				function:		 根据工单传过来的参数查询用户信息
				parameters:       
				return:			 
				description:     生产调用中访问用户号线资料修改页面
********************************************************/
function queryUserByJob(){
	//lws0001  broadband MDF
	var route_ywlx = $("#route_ywlx").val(); // 用户类型
	var route_accesstype = $("#route_accesstype").val();//接入方式	
	var linemode ='';//配线方式
	var route_username = $("#route_username").val();//用户账号	
	var route_jobid = $("#route_jobid").val(); // 工单id
	if(route_jobid!='null'){
	//route_ywlx!=undefined && route_accesstype!=undefined &&route_username!=undefined
		/**
		$("#routetype").val('broadband');
		$("#linemode").val('MDF');
		$("#queryvalue").val('lws0001');	
		*/
		if(route_accesstype=='ADSL')
		{
			linemode='MDF';
		}else if(route_accesstype=='WLAN')
		{
			linemode='ODF';
		}
		$("#routetype").val(route_ywlx);
		$("#linemode").val(linemode);
		$("#queryvalue").val(route_username);	
		
		//setTimeout(query_user(2),3000);		
		query_user(0);
		$("#btnclose").show();
	}
	else
	{
		$("#btnclose").hide();
	}
}
/**********************************************************
				function name:   closeDialog()
				function:		 关闭本模块窗口
				parameters:       
				return:			 
				description:     生产调用中访问用户号线资料修改页面
********************************************************/
function closeDialog(){
	//window.close();
	var dh = $("#route_username").val();
	var jobid = $("#route_jobid").val();
	window.dialogArguments.getRouteMX(dh,jobid);
	window.close();
}

/**********************************************************
				function name:   onbeforeunload()
				function:		 关闭模态窗口调用事件
				parameters:       
				return:			 
				description:     生产调用中访问用户号线资料修改号线，当修改完毕之后通过窗口右上角的关闭按钮关闭窗口调用事件
********************************************************/
<!--        
   window.onbeforeunload = onbeforeunload_handler;      
    function onbeforeunload_handler(){ 
    	//判断是否为
    	var route_jobid = $("#route_jobid").val(); // 工单id
		if(route_jobid!='null'){     
	       closeDialog();   
	     }
    }       
// -->   

