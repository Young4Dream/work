/*****************************************************************
 * name: script/telephone/linemanagement/LineDocumentM.js
 * author: 尤红玉
 * version: 1.0, 2012-3-9
 * description: 专网文档上传
 * modify: 
 *		
 *****************************************************************/
  
 
/**
* 打开文档管理面板
* @param 
* @return 
*/
function openDocumentM(Dh,key2,MoKuaiJu,DhType)
{
	//设置并机标识，用于判断是否并机；isParallel=0：非并机 ；isParallel=1：并机
	$('#isParallel').val(0);
    $('#grid_user').setSelection(key2, true);	
            
	//上传文档权限控制
	var isUploadDoc = checkUploadDoc();
	if(isUploadDoc == false){  
		alert("您无文档上传权限。");
	}
	
	$("#Docdh").val(Dh);
	$("#DocDhType").val(DhType);
	showDocument(Dh,DhType);
	autoBlockForm('documentMForm', 5, 'documentMclose', "#ffffff", false);
}

/*****************************
* 上传文档权限控制
*uploadDoc:上传文件权限（0：上传word、excel权限；1：上传word权限；2：上传excel权限；其它：无上传权限）	
* date 2012-8-28 yhy
******************************/
function checkUploadDoc(){
	var flag = true ;
	var isUploadDoc = $('#uploadDocRight').val();
	if(isUploadDoc == '0'){
		$("#docType").removeAttr("disabled");
	}
	//只能上传word
	else if(isUploadDoc == '1'){
		$("#docType").val(1);
		$("#docType").attr("disabled" , "disabled");
	}
	//只能上传excel
	else if(isUploadDoc == '2'){
		$("#docType").val(2);
		$("#docType").attr("disabled" , "disabled");
	}
	//其他人员允许上传word 和excel文档
	else{
		$("#upLoadPan").attr("disabled" , "disabled");
		flag = false ;
	}
	return flag;
}

//上传参数获取
function AirBuildParams(){
		//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
		
		var params = '';
		var docType = '';//文件类型
		var operator = '';//操作人员
		var dhtype ='';//系统类型
		var dh ='';//电话信息
		docName = $("#docName").val();
		docType = $("#docType").val();
		operator = $("#userloginid").val();
		dhtype = $("#DocDhType").val();
		dh = $("#Docdh").val();
		var upFlag = $('#upFlag').val();
		
		if(docType==1&&upFlag!=1){
			alert("请选择正确word文件进行上传。支持文件格式为：*.doc，*.docx，*.wps！");
			return false;
		}
		if(docType==2 && upFlag!=2){
			alert("请选择正确excel文件进行上传。支持文件格式为：*.xls，*.xlsx，*.csv，*.et！");
			return false;
		}
		/*
		var docName ='';//文件名
		if(docName==undefined || docName==''){
			alert("请输入文件名！");
			return false;
		}
		params += '&docName='+tsd.encodeURIComponent(docName);
		*/
		params += '&docType='+tsd.encodeURIComponent(docType);
		params += '&operator='+tsd.encodeURIComponent(operator);
		params += '&dhtype='+dhtype;
		params += '&dh='+dh;
		//每次拼接参数必须添加此判断
		if(tsd.Qualified()==false){return false;}
		return params;	
}

function AiruploadFile(){
	
	
	var fileName = $("#Ctrl_Up_File_Line").val();
	if(fileName==''){
		alert('请选择要上传的文件');
		$('#Ctrl_Up_File_Line').focus();
		return false;
	}
	
	if(checkFileT())
	{		
		//上传参数拼接
		var params = AirBuildParams();
		if(params==false){return false;}
		
		var urll = 'LineDocumentM?tsdcf=enterprisedb&opertype=1&'+params;
		/**
		if($("#Ctrl1_Attachment").val()!=""){
			//var tmp = $("#Ctrl1_Attachment").val();
			//tmp = tmp.replace(new RegExp("\\","g"),"\\\\");
			tmp = "&ufilename=tsd.doc";
			urll = urll + tmp;
		}else{
			var tmp = "&ufilename=notexists";
			urll = urll + tmp;
		}
		*/
		$("#start").ajaxStart(function(){
	     //文件上传中..."
	    });
	    //2.上传		    
	    $.ajaxFileUpload({
		    url: urll,//servlet路径 可携带参数
		    secureuri:false,
		    fileElementId:'Ctrl_Up_File_Line',
		    dataType:"xml",
		    success:function(xml, status)
		    {
	    	 			$(xml).find('row').each(function ()
	    	            {
	    	                var str= $(this).attr("filename");
	    	                //alert(str);
	    	                if(str!=undefined){
								//如果文件上传成功
								alert("文件上传成功");
								writeLogInfo('','modify',tsd.encodeURIComponent('上传专线用户号线资料：'+tsd.encodeURIComponent(str)));	
								//重新加载专网电弧对应文件列表
								var dhtype = $("#DocDhType").val();
								var Dh = $("#Docdh").val();
								showDocument(Dh,dhtype);				
							}
	    	            });
		     	//$("#Ctrl1_Attachment").val(data);
		     	//$("#up_from1Close").click();
		    },
		    error:function(xml, status, e)
		    {
		   		//文件上失败
		   		alert("文件上传失败");
		   		alert(e);
		   		alert(status);
		   		
		    }
		});
		//$('#maxpanels').hide();
	}
}

/**
*判断文件类型
*param type :doc  xls
*/
function checkFileT()
{
	var fileName = $("#Ctrl_Up_File_Line").val();
	if(fileName==''){
		alert('请选择要上传的文件');
		return false;
	}
	var str = fileName.substring(fileName.lastIndexOf('\.')+1,fileName.length);
	var upFlag = 0;
	if( str == 'doc' || str == 'docx' || str == 'wps' || str == 'xls' || str == 'xlsx' ||str == 'csv' || str=='et'){
		if(str == 'doc' || str == 'docx' || str == 'wps'){
			upFlag = 1;
		}else if(str == 'xls' || str == 'xlsx' ||str == 'csv' || str=='et'){
			upFlag = 2;
		}
		$('#upFlag').val(upFlag);
		$('#uptype').val(str);
		return true;			
	}else{
		alert("请选择正确的文件进行上传。支持文件格式为：*.doc，*.docx，*.wps，*.xls，*.xlsx，*.csv，*.et");
		return false; 
	}
}


//显示当前号线对应文件
function showDocument(Dh,DhType){
	$('#HasDocument').empty();	
	/*
	var urlstr = tsd.buildParams(
    {
            packgname : 'service', //java包
            clsname : 'ExecuteSql', //类名
            method : 'exeSqlData', //方法名
            ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf : 'mssql', //指向配置文件名称
            tsdoper : 'query', //操作类型 
            datatype : 'xmlattr', //返回数据格式 
            tsdpk : 'dbsql_route.RM.DgetDocument'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    */
    var urlstr = buildParamsSqlByS('tsdBilling','query','xmlattr','dbsql_route.RM.DgetDocument','', 'route');
    $.ajax(
    {
            url : 'mainServlet.html?' + urlstr +'&Dh='+Dh+ '&DhType=' + DhType ,
            datatype : 'xml', 
            cache : false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout : 1000, 
            async : false , //同步方式
            success : function (xml)
            {
            		var hrefhtml = '';
		        	var xint = 1;
		        	var rstyle = "style='display:none'";
		        	var dstyle = "style='display:none'";
		        	var renameright = $('#renameright').val();		       
		        	var deletefileright = $('#deletefileright').val();
		        	 // 是否有重命名
		        	if(renameright=='true'){
		        		rstyle = '';
			        }
			        // 是否有删除权限
		        	if(deletefileright=='true'){
		        		rstyle = '';
			        }
		            $(xml).find('row').each(function ()
		            {
		                var id = $(this).attr('id') ;
		                if(id!='' && id!=undefined){			               
		                	var docname = $(this).attr('docname') ;
		                	var btns = '';
				        	btns += "\t\t<a href='#' onclick=javascript:DocumentDownloadResponse('"+id+"') ><label class='alabel'>下载</label></a>";
				        	//btns += "<a href='#' "+rstyle+" onclick=javascript:renameDisplay('"+id+"')><label class='alabel'>重命名</label></a>";
				        	btns += "\t\t<a href='#' "+rstyle+" onclick=javascript:deleteDocument('"+id+"')><label class='alabel'>删除</label></a>";
							hrefhtml += '<span class="dowlabel">'+xint +'、<a href="#" onclick=javascript:DocumentDownloadResponse("'+id+'") >'+docname+'</a></span><span class="aspanstyle">'+btns+'</span><br/>';
							xint++;				            
					    }
		            });
		            if(hrefhtml!=''){
		            	$('#HasDocument').html(hrefhtml);
				        //$('#ilabel').hide();
				    	//$('#idisdown').show();
			        }           
            }
            ,
		    error:function(xml, status, e)
		    {
		   		//文件上失败
		   		alert("刷新文档列表失败.");
		   		alert(e);
		   		alert(status);
		   		
		    }
        });
}
/*************************************
*    删除已有文件
*    param:id  air_document唯一标识
**************************************/
function deleteDocument(id){
	//CQJCBS-84  2012-6-12 youhongyu begin
	//专线资料删除文档的时候给出提示框确认
	var deleteinformation = $("#deleteinformation").val();
	if (confirm(deleteinformation)) 
	{
	//CQJCBS-84  2012-6-12 youhongyu end
		$('#HasDocument').empty();	
		var urlstr = tsd.buildParams(
	    {
	            packgname : 'service', //java包
	            clsname : 'ExecuteSql', //类名
	            method : 'exeSqlData', //方法名
	            ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
	            tsdcf : 'route', //指向配置文件名称
	            tsdoper : 'exe', //操作类型 
	            tsdpk : 'dbsql_route.RM.DdelDocument'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
	    });
	    $.ajax(
	    {
	            url : 'mainServlet.html?' + urlstr + '&ID=' + id ,
	            cache : false, //如果值变化可能性比较大 一定要将缓存设成false
	            timeout : 1000, 
	            async : false , //同步方式
	            success : function (msg)
	            {            		
			        if (msg == "true")
	            	{	            		
	            		writeLogInfo('','delete',tsd.encodeURIComponent('删除专线用户号线资料。'));
	            		//刷新显示文档列表
			            var Dh= $("#Docdh").val();
			            var dhtype= $("#DocDhType").val();
						showDocument(Dh,dhtype);
						alert("删除成功！");
			        } 		                
	            }
	      });
	}
	
}

/*************************************
*    文档下载操作
*    param:id  air_document唯一标识
*************************************/
function DocumentDownload(id){
	var urll = 'LineDocumentM?tsdcf=enterprisedb&opertype=5&id='+id;		
	$.ajax(
    {
        url : urll, 
        datatype : 'xml', 
        cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, 
        async : false , //同步方式
        success : function (xml)
        {
        		$(xml).find('row').each(function ()
		        {
	        		var res = $(this).attr('result') ; //返回文件名	        		
	        		if(res!=undefined && res!="")
	        		{
	        			//alert($("#thisbasePath").val()+"UpFlies/"+res);
	        			$('#idownload').attr('src', $("#thisbasePath").val()+"UpFlies/"+res);
	        		}
	        	});          
        }
    });

}


/*************************************
*    文档下载操作
*    param:id  air_document唯一标识
*************************************/
function DocumentDownloadResponse(id){
/*
var urll = 'mainServlet.html?pagename=telephone/linemanagement/LineDocumentMServer.jsp&tsdtemp=' + Math.random()+'&id='+id;
	//var urll = '/tsdboss_cqjc5/script/LineDocumentMServer.jsp&id='+id;		
	$.ajax(
    {
        url : urll,
        cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 10000, 
        async : false, //同步方式
        success : function (xml)
        {
			alert(xml.responseText);        
        }
        
        
        
    });
*/    
     var urll = 'mainServlet.html?pagename=route/server/LineDocumentMServer.jsp&tsdtemp=' + Math.random()+'&id='+id;
     var form = $("<form>");
	 form.attr('style','display:none');
	 form.attr('target','');
	 form.attr('method','post');
	 form.attr('action',urll);
	 
	 var input1 = $('<input>');
	 input1.attr('type','hidden');
	 input1.attr('name','id');
	 input1.attr('value',id);
/**
	 var input2 = $('<input>');
	 input2.attr('type','hidden');
	 input2.attr('name','title');
	 input2.attr('value','222');
	*/ 
	 $('body').append(form);
	 form.append(input1);
	 
	 form.submit();
	 form.remove();

}
