/*****************************************************************
 * name: script/telephone/linemanagement/linePublic.js
 * author: 尤红玉
 * version: 001.0, 2012-2-19
 * description: 用户号线资料管理 公共方法
 * modify:
 *****************************************************************/
/**********************************************************
				function name:    changeMenu
				function:		  
				parameters:       type：用户类型：broadband：宽带；phone：电话
				return:			  
				description:    直接跳转到生产调度页面
********************************************************/
function changeMenu(type){
		//获取组信息
		var groupid = $('#zid').val();		
		if(type=="phone"){//电话
				if(confirm("是否跳转到生产调度系统")){
						openMenu('4016','telephone/workflow/zsjob.jsp',groupid,'');
				}
		}else if(type=="broadband"){//宽带
				if(confirm("是否跳转到生产调度系统")){
						openMenu('4034','telephone/workflow/zsradjob.jsp',groupid,'');
				}
		}
}	