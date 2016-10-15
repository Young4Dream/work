jQuery(document).ready(function(){
	//根据发送方式判定计划发送时间控件是否可用
	$("#txtPlandateForSend").val(show());
 	$("input[@type=radio][name='radSendTypeForSend']").click(function(){
		var sendType=$("input[@type=radio][name='radSendTypeForSend'][checked]").val();
		if(sendType==1){
			$("#txtPlandateForSend").removeAttr("disabled");
		}else{			
			$("#txtPlandateForSend").val(show());
			$("#txtPlandateForSend").attr("disabled","disabled");
		}
	});
	//loadList_ready_sent();
	

	
});
 	
 	
//初始化待发送grid
function loadList_ready_sent(){
	var json={
			sql:"sms.readySend.querySmsList",
			pagesql:"sms.readySend.querySmsListPage",
			gridid:"#editgrid_ready_send",
			pageid:"#pagered_ready_send",
			sortname:"id",
			colNames:['详细','序号','发件人','收件人','发送时间','内容'],
			colModel:[{name:'viewOperation', width:10},
						  {name:'id',hidden:true,width:20},
						  {name:'send_number',width:25},
						  {name:'receive_number',width:25},
						  {name:'send_time',width:45},
						  {name:'sms_content',width:130}
					 ]
		};
		//script/sms/comm.js
		loadGridComm(json,"loadComplete_ready_sent();");
}

function loadComplete_ready_sent(){
	//添加操作列
	var id=jQuery("#editgrid_ready_send").getRowData(1)['id'];
	if(id == undefined)
	{			
		$("#editgrid_ready_send tr.jqgrow[id='1']").html("");		
	    if($("#norecordspn1").html() == null)
	    {
		    $("#editgrid_ready_send").parent().append("</pre><center><div id='norecordspn1' style='font-size: 20px;color: red;'><b>未查询到相匹配的信息！</b></div></center><pre>");								
	    }
	    $("#norecordspn1").show();//如果不存在记录，则显示 提示信息
	    return false;
	}else{//如果存在记录，则隐藏提示信息
		$("#norecordspn1").hide();
	}

	$("#editgrid_ready_send").setSelection('0', true);
	$("#editgrid_ready_send").focus();
	addRowOperBtn('editgrid_ready_send','&nbsp;&nbsp;&nbsp;<img src="style/images/public/ltubiao_03.gif" title="详细"/>','queryDetailForReady','id','click',1);
	executeAddBtn('editgrid_ready_send',1);
}

function queryDetailForReady(id){
	
	var urlstr=tsd.buildParams({ 	
			packgname:'service',//java包
			clsname:'ExecuteSql',//类名
			method:'exeSqlData',//方法名
			ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
			tsdcf:'mssql',//指向配置文件名称
			tsdoper:'query',//操作类型 
			datatype:'xmlattr',//返回数据格式 
			tsdpk:'querySms.DetailForReadySent' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		});
		$.ajax({
			url:'mainServlet.html?'+urlstr+'&id='+id,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				$(xml).find('row').each(function(){
					//id,send_number,receive_number,received_time,sms_content,is_success
					    
					var send_number = $(this).attr("send_number");
					var receive_number= $(this).attr("receive_number");
					var send_time= $(this).attr("send_time");
					var sms_content= $(this).attr("sms_content");
					
					$("#txt_detail_ready_send_number").val(send_number);
					$("#txt_detail_ready_receive_number").val(receive_number);
					$("#txt_detail_ready_sent_time").val(send_time);
					$("#txt_detail_ready_content").val(sms_content);
					
					autoBlockForm('div_query_detail_ready_send',60,'close_detail_ready_send',"#ffffff",false);//弹出查询面板
					
				});
			}
		});
}

//删除待发送数据
function delete_ready_send(){
	var rowData = jQuery('#editgrid_ready_send').jqGrid('getGridParam','selarrrow');
	var ids="";
	var length=rowData.length;
	if(length<0){
		alert("请选择要删除的数据");
	}else{
		for(var i=0;i<length;i++){
			var id=jQuery('#editgrid_ready_send').jqGrid('getCell',rowData[i],'id');
			ids+=id+',';
		}
		if(window.confirm("确定要删除这些数据吗?")){
			var urlstr=tsd.buildParams({
				packgname:'service',//java包
		 		clsname:'ExecuteSql',//类名
		 		method:'exeSqlData',//方法名
				ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
		 		tsdcf:'postgresql',//指向配置文件名称
		 		tsdoper:'query',//操作类型 
		 		datatype:'xmlattr',//返回数据格式 
				tsdpk:'sendSms.delete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
			});
				
			$.ajax({
				url:'mainServlet.html?'+urlstr+'&params='+"ids="+ids+";tblType=readySend",
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式	
				success:function(xml){
					alert("删除成功");
					reloadDataForReady();
				}
			});
		}
		
	}
}


function reloadDataForReady(){
	var urlstr=tsd.buildParams({
			packgname:'service',//java包
			clsname:'ExecuteSql',//类名
			method:'exeSqlData',//方法名
			ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
			tsdcf:'mssql',//指向配置文件名称
			tsdoper:'query',//操作类型 
			datatype:'xml',//返回数据格式 
			tsdpk:'sms.readySend.querySmsList',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
			tsdpkpagesql:'sms.readySend.querySmsListPage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
	});
	$("#editgrid_ready_send").setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");
	setTimeout($.unblockUI, 15);//关闭面板
}

//查询未发送
function query_ready_send(){
	autoBlockForm('div_query_ready_send',60,'close_ready_send',"#ffffff",false);//弹出查询面板
}

function check_ready_sent(){
	var fromNumber=$("#txt_ready_sent_number").val();
		var checkFromNumber = /^\d*$/;
		if(fromNumber!=""){
			if(!checkFromNumber.test(fromNumber)){
				alert("号码必须是数字");
				return false;
			}
		}
		
		var toNumber=$("#txt_ready_received_number").val();
		if(toNumber!=""){
			if(!checkFromNumber.test(toNumber)){
				alert("号码必须是数字");
				return false;
			}
		}
		
		var sendTimeStart=$("#txt_ready_sent_time_start").val();
		var sendTimeEnd=$("#txt_ready_sent_time_end").val();
		if(!duibi(sendTimeStart,sendTimeEnd)){
			alert('开始时间大于结束时间，请检查');
			return false;
		}
		return true;
}
function build_params_ready_sent(){
	var fromNumber=$("#txt_ready_sent_number").val();
	var toNumber=$("#txt_ready_received_number").val();
	var content=$("#txt_ready_sent_content").val();
	var sendTimeStart=$("#txt_ready_sent_time_start").val();
	var sendTimeEnd=$("#txt_ready_sent_time_end").val();
		
	if(sendTimeStart==""&&sendTimeEnd==""){
		sendTimeStart="1990-01-01";
		sendTimeEnd="2999-12-30";
	}else{
		if(sendTimeEnd==""){
			sendTimeEnd="2999-12-30";
		}
		if(sendTimeStart==""){
			sendTimeStart="1990-01-01";
		}
	}
		
	var params="&send_number="+fromNumber;
		params+="&receive_number="+toNumber;
		params+="&sms_content="+tsd.encodeURIComponent(content);
		params+="&sendTimeStart="+sendTimeStart;
		params+="&sendTimeEnd="+sendTimeEnd;
	return params;
}

function do_query_ready_sent(){
	if(check_ready_sent()){
		var params=build_params_ready_sent();
		var urlstrForQuery=tsd.buildParams({
			packgname:'service',//java包
			clsname:'ExecuteSql',//类名
			method:'exeSqlData',//方法名
			ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
			tsdcf:'mssql',//指向配置文件名称
			tsdoper:'query',//操作类型 
			datatype:'xml',//返回数据格式 
			tsdpk:'sms.readySend.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
			tsdpkpagesql:'sms.readySend.queryPage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
		});
		
		$("#editgrid_ready_send").setGridParam({url:'mainServlet.html?'+urlstrForQuery+params}).trigger("reloadGrid");
		setTimeout($.unblockUI, 15);//关闭面板
	}else{
		return false;
	}
}

//导入数据前先上传
function upFile(){	

	//判断浏览器 
	var Sys = {}; 
	var ua = navigator.userAgent.toLowerCase(); 
	var s; 
	(s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] : 
	(s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] : 
	(s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] : 
	(s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] : 
	(s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0; 
	var file_url=""; 
	if(Sys.ie<="6.0"){ 
		//ie5.5,ie6.0 
		file_url = document.getElementById("filePath").value; 
	}else if(Sys.ie>="7.0"){ 
		//ie7,ie8 
		var file = document.getElementById("filePath"); 
		file.select(); 
		file_url = document.selection.createRange().text; 
	}else if(Sys.firefox){ 
		//fx 
		file_url = readFileFirefox(document.getElementById("filePath")); 
	} 

	username=$("#skrid").val();
//alert(file_url.lastIndexOf("\\"));
//alert("file_url==="+file_url.substring(file_url.lastIndexOf("\\")+1,file_url.length));
	
	filename=file_url.substring(file_url.lastIndexOf("\\")+1,file_url.length);
	if(filename.substring(filename.lastIndexOf("."))==".xls"){
		var urlstr = 'upfiles?tsdcf=oracle&upDirKey=importXls.path&ufilename='+tsd.encodeURIComponent(filename)+"&username="+username+"_";
		$.ajaxFileUpload(
		{
		    url : urlstr, //servlet路径 可携带参数
		    secureuri : false, 
		    fileElementId : 'filePath',
		    success : function (xml){
		    	var filenameNew="";
		    	$(xml).find('row').each(function(){
		    		filenameNew=$(this).attr("filename");
		    	});
		       	importXls(filenameNew);
		       	$("#textfield").val("");
		       	$("#filePath").val("");
		       	
		    },
		    error : function (data, status, e){
		    	alert("导入失败");
		    }
		});
	}else{
		alert("文件格式不正确,导入失败");
	}
	
}

function importXls(filename){
	$.ajax({
			url:"ImportXls.html?filename="+tsd.encodeURIComponent(filename)+"&tsdcf=oracle&upDirKey=importXls.path",
			datatype:'xml',
			cache:false,
			async:false,
			success:function(xml){
				var i=0;
				var total=0;
				var errorPhone="";
				var succPhone="";
				$(xml).find('row').each(function(){
					total++;
				 	var phone=$(this).attr("phone");
				 	var type =$(this).attr("type");
				 	if(type=="String"){
				 		i++;
				 		errorPhone+=phone+",";
				 	}else{
				 		succPhone+=phone+",";
				 	} 	
				});
				
				
				var result="xls文件导入完成,导入总条数:"+total+",失败条数:"+i+";\n";
				if(errorPhone!=""){
					 result+="失败号码:"+errorPhone.substring(0,errorPhone.length-1);
				}
				$("#txtToNumberForSend").val(succPhone);
				alert(result);
			},
			error:function(){
				alert("导入失败");
			}
		});
}


//发送短信 	
function sendSms(){
	//验证元素格式是否正确
	if(checkSms()){
		var params=buildSendSmsParams();
		var res=fetchMultiPValue('msgService.sendmsg',6,"&params="+params);
		if(res == "succ"){
			clearContent();
			alert("发送成功！");
		}else{
			alert("发送失败！");
		}
		
	}
}

function clearContent(){
	$("#txtToNumberForSend").val("");
	$("#textContentForSend").val("");
	$("#txtPlandateForSend").val(show());
}

//拼接参数 		
function buildSendSmsParams(){
	var toNumber=$("#txtToNumberForSend").val();
	//正则验证格式 必须为   123,123,123或者123 不能为123,,123 
	if(toNumber.indexOf(",")==-1){
		toNumber+=",";
	}else{	
		if(toNumber.lastIndexOf(',')!=toNumber.length-1){
			toNumber+=",";
		}
	}
	var sendType=$("input[@type=radio][name='radSendTypeForSend'][checked]").val();
	var params =";fromNumber="+$("#selFromNumberForSend").val();
		params+=";toNumber="+toNumber;
		params+=";content="+$("#textContentForSend").val();
		params+=";sendType="+sendType;
		params+=";plandate="+$("#txtPlandateForSend").val();
		
		
	return tsd.encodeURIComponent(params);
}
 		
//验证元素格式是否正确
function checkSms(){
	
	if($("#txtToNumberForSend").val()==null||$("#txtToNumberForSend").val()==""){
		alert("发送号码不能为空");
		return false;
	}
	if($("#textContentForSend").val()==null||$("#textContentForSend").val()==""){
		alert("短信内容不能为空");
		return false;
	}
	if($("#textContentForSend").val().length>600){
		alert("短信内容不能超过600个字符");
		return false;
	}
	if(!checkzz($("#textContentForSend").val())){
			alert("不能存在特殊符号$")
			return false;
	}
	
	//正则验证发送号码格式
	var toNumber=$("#txtToNumberForSend").val(); 			
	var zz=/^(\d+\,?)*$/;
	if(zz.test(toNumber)){
		return true;
	}
	alert("号码必须是数字，多个号码应以','隔开");
	return false; 
}

//获取当前时间 		
function show(){
	var date = new Date(); //日期对象
	var month=date.getMonth()+1+"";
	if(month.length==1){
		month="0"+month;
	}
	var day=date.getDate()+"";
	if(day.length==1){
		day="0"+day;
	}
	var hours=date.getHours()+"";
	if(hours.length==1){
		hours="0"+hours;
	}
	var minutes=date.getMinutes()+"";
	if(minutes.length==1){
		minutes="0"+minutes;
	}
	var seconds=date.getSeconds()+"";
	if(seconds.length==1){
		seconds="0"+seconds;
	}
	
	var now = "";
	now = date.getFullYear()+"-"; //读英文就行了
	now = now + month+"-";//取月的时候取的是当前月-1如果想取当前月+1就可以了
	now = now + day +" ";
	now = now + hours +":";
	now = now + minutes +":";
	now = now + seconds +"";
	return now;
}

//导入数据前先上传

/**
function importExcel(){
	autoBlockFormAndSetWH('importExcel',60,5,'closeo',"#ffffff",true,1000,'');//导入面板	
}
**/




function checkzz(val){
	var res=true;
	if(val.indexOf("--")!=-1){
		res=false;
	}
	
	if(val.indexOf("$")!=-1){
		res=false;
	}
	
	return res;
}





/**
		 * 加载待发送短信
		 * @param
		 * @return
		 */
		function loadsendinginfo(key,tablename)
		{
			var thisdata = loadData(tablename,'<%=languageType%>',1,'详细');
			column = thisdata.FieldName.join(',');
			$('#thecolumns'+key).val(column);
			
			thisdata.colModels[1].hidden=true;	
			
			jQuery("#editgrid"+key).jqGrid({				
				url:'mainServlet.html?',
				datatype: 'xml', 
				colNames:thisdata.colNames, 
				colModel:thisdata.colModels, 
				      	rowNum:15, //默认分页行数
				       	rowList:[30,50,100], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'+key), 
				       	sortname: ' ', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'desc',//默认排序方式 
				       	caption:' ', 
				       	height:document.documentElement.clientHeight-150, //高
				        width:document.documentElement.clientWidth-40,
				       	loadComplete:function(){
		       					if($("#editgrid1 tr.jqgrow[id='1']").html()=="")
								{	return false; 			}
		       					$("#editgrid"+key).setSelection('0', true);
								$("#editgrid1"+key).focus();
							 	addRowOperBtn('editgrid'+key,"<img src=\"style/images/public/ltubiao_03.gif\" title=\"详细\" />",'detailRow','SMSINDEX','click',1,'PHONENUMBER','SMSCONTENT');
								executeAddBtn('editgrid'+key,1);
						}
				}).navGrid('#pagered'+key,  {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
			}
			
			function reloadData(key,tablename){
				
				var urlstr=tsd.buildParams({     packgname:'service',//java包
					  clsname:'ExecuteSql',//类名
					  method:'exeSqlData',//方法名
					  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
					  tsdcf:'',//指向配置文件名称
					  tsdoper:'query',//操作类型 
					  datatype:'xml',//返回数据格式 
					  tsdpk:'sendingmsg.loadinfo',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
					  tsdpkpagesql:'sendingmsg.loadinfopage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
				});
				var thecolumn = $('#thecolumns'+key).val();
				if(key=='1'){
					thecolumn = thecolumn.replace(",NEWFLAG,",",case NEWFLAG when 1 then '等待发送' else '未处理' end NEWFLAG,");
				}else if(key=='2'){
					thecolumn = thecolumn.replace(",STATUS,",",case STATUS when 1 then '成功' else '失败' end STATUS,");
				}
				
				
				$("#editgrid"+key).setGridParam({url:'mainServlet.html?'+urlstr+'&tablename='+tablename+'&cols='+tsd.encodeURIComponent(thecolumn)}).trigger("reloadGrid");
 				setTimeout($.unblockUI, 15);//关闭面板
			}
			/**
			 * 查看详细信息
			 * @param key(唯一标识)
			 * @return 无返回值
			 */
			function detailRow(key){
				clearText('operform'); 
				$("#txt_detail_ready_receive_number").val(arguments[1]);
				$("#txt_detail_ready_content").val(arguments[2]);
				
				autoBlockForm('div_query_detail_ready_send',0.5,'closethisinfo',"#ffffff",false);//弹出查询面板
			}
			
			/**
			 * 查看详细信息
			 * @param key(唯一标识)
			 * @return 无返回值
			 */
			function detailRow(key){
				clearText('operform'); 
				$("#txt_detail_ready_receive_number").val(arguments[1]);
				$("#txt_detail_ready_content").val(arguments[2]);
				$("#titledivs").html("详细");
				autoBlockForm('div_query_detail_ready_send',0.5,'closethisinfo',"#ffffff",false);//弹出查询面板
			}
			
			/**
			 * 简单查询
			 * @param key(唯一标识)
			 * @return 无返回值
			 */
			function queryinfo(key){
				clearText('queryform');
				if(key=='3'){
					$("#rec").hide();
					$("#send").show();
					$("#newflag").hide();
				}else if(key=="2"){
					$("#send").hide();
					$("#rec").show();
					$("#newflag").show();
				}else if(key=="1"){
					$("#send").hide();
					$("#rec").show();
					$("#newflag").hide();
				} 
				
				$("#titledivs").html("查询");
				autoBlockForm('smsquery',0.5,'closethisinfo1',"#ffffff",false);//弹出查询面板
			}
			
			/**
			 * 执行总查询
			 * @param 无参数
			 * @return 无返回值
			 */
			function queryGroup(){
				var key=$("#queryflag").val();
				var tablename='';
				if(key=="1"){
					tablename='sendingsmstable';
				}else if(key=="2"){
					tablename='SentSmsTable';
				}else if(key=="3"){
					tablename='recvsmstable';
				} 
				var fuheparams="1=1";
			 	var recphone = $("#recphone").val();
			 	var sendphone = $("#sendphone").val();
			 	var startime = $("#startime").val();
			 	var stoptime = $("#stoptime").val();
			 	var smscontent = $("#smscontent").val();
			 	var sendres = $("#sendres").val();
			 	if(recphone!=null&&recphone!=""){
			 		fuheparams+=" and phonenumber='"+tsd.encodeURIComponent(recphone)+"'";
			 	}
			 	if(sendphone!=null&&sendphone!=""){
			 		fuheparams+=" and sendnumber='"+tsd.encodeURIComponent(sendphone)+"'";
			 	}
				if(startime!=null&&startime!=""){
			 		fuheparams+=" and smstime >= to_date('"+tsd.encodeURIComponent(startime)+"','yyyy-mm-dd')";
			 	}
				if(stoptime!=null&&stoptime!=""){
			 		fuheparams+=" and smstime<=to_date('"+ tsd.encodeURIComponent("%") +tsd.encodeURIComponent(stoptime)+tsd.encodeURIComponent("%") +"','yyyy-mm-dd')";
			 	}
				if(smscontent!=null && smscontent!=""){
					fuheparams+=" and smscontent like '"+tsd.encodeURIComponent("%") +tsd.encodeURIComponent(smscontent)+tsd.encodeURIComponent("%") +"'";
				}
				
			 	if(sendres!=null && sendres!="" && sendres=="1"){
					fuheparams+=" and status="+tsd.encodeURIComponent(sendres);
				}else if(sendres!=null && sendres!="" && sendres=="0"){
					fuheparams+=" and (status<>1 or status is null)";
				}
				var urlstr=tsd.buildParams({     packgname:'service',//java包
					  clsname:'ExecuteSql',//类名
					  method:'exeSqlData',//方法名
					  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
					  tsdcf:'oracle',//指向配置文件名称
					  tsdoper:'query',//操作类型 
					  datatype:'xml',//返回数据格式 
					  tsdpk:'sendingmsg.queryinfo',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
					  tsdpkpagesql:'sendingmsg.queryinfopage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
				});
				var thecolumn = $('#thecolumns'+key).val();
				if(key=='1'){
					thecolumn = thecolumn.replace(",NEWFLAG,",",case NEWFLAG when 1 then '等待发送' else '未处理' end NEWFLAG,");
				}else if(key=='2'){
					thecolumn = thecolumn.replace(",STATUS,",",case STATUS when 1 then '成功' else '失败' end STATUS,");
				}
				
				$("#editgrid"+key).setGridParam({url:'mainServlet.html?'+urlstr+'&tablename='+tablename+'&cols='+tsd.encodeURIComponent(thecolumn)+"&fusearchsql="+fuheparams}).trigger("reloadGrid");
 				setTimeout($.unblockUI, 15);//关闭面板
			}