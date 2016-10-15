 /*****************************************************************
 * name: mnuControlSet.js
 * author: 尤红玉
 * version: 1.0,  2010-12-23
 * description: 通信设备控制接口设置
 * modify:
 			2011-1-5 youhongyu 添加日志写入、添加必填字段、修改弹出面板中下拉选择框默认值 *	
 			2011-1-13 youhongyu 分项卡数据更新 	
			2011-7-14 youhongyu 控制接口设置 页面显示
 *****************************************************************/ 

/**
 * 点击切换选项卡操作
 * @param id 当前被点击的选项卡表识，通过该表识打开相应选项卡
 * @return 
 */
function tabsChg(id)
{		
		$("#fusearchsql").val("");
		swithTabs(id);
		switch(id)
		{
			case 1:
				tabStatus=1;				
				ready1();
				break;
			case 2:
				tabStatus=2;				
				ready2();
				break;
			default:
				tabStatus=1;				
				ready1();
		}
}

/**
 * 加载第一个选项卡信息
 	表txkz_ctlset
 * @param 
 * @return 
 */
function ready1(){
	$("#editgrid").trigger("reloadGrid");//更新jqgrid
}
/**
 * 加载第一个选项卡信息
 	表attachprice
 * @param 
 * @return 
 */
function ready2(){
	//更新第二个分项卡的值
	setParamsVal();
}

/**
 * 加载第一个选项卡信息
 	表attachprice
 * @param id 分项卡标识
 * @return 
 */
function swithTabs(id){
		switch(id)
		{
			case 1:
				$("#tabsone").show();
				$("#tabstwo").hide();
				ready1();
				break;
			case 2:
				$("#tabsone").hide();				
				$("#tabstwo").show();
				ready2();
				break;
		}	
}
/**
 * 加载第一个选项卡的jqgrid；初始化的时候使用
 	表txkz_ctlset
 * @param 
 * @return 
 
 */
 function loadJQgrid(){
 		var col=[[],[]];
		col=getRb_Field('txkz_ctlset','JhjID',"修改|删除|详细",'97','ziduansF1','CtlPort','YwID');//得到jqGrid要显示的字段
		var column = $("#ziduansF1").val();
		//设置命令参数
		var urlstr=buildParamsSql('query','xml','mnuControlSet.query','mnuControlSet.querypage');
		
		jQuery("#editgrid").jqGrid({
				/*执行存储过程---------------- 
				tsdpname：可以调用其他存储过程，
				注意：tsdpname不是真正对应存储过程名称 而是通过系统进行映射，查看映射名请参照 存储过程维护页
				ds：对应applicationContent.xml里配置的数据源 
				*/					
				url:'mainServlet.html?'+urlstr+'&column='+column,
				datatype: 'xml', 
				colNames:col[0], 
				colModel:col[1],				      
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'JhjID', //默认排序字段
				       	viewrecords: true, 
				       	//hidegrid: false, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:'控制接口设置', 
				       	height:300, //高
				       // width:document.documentElement.clientWidth-27,
				       	loadComplete:function(){
										$("#editgrid").setSelection('0', true);
										$("#editgrid").focus();
										///自动适应 工作空间
										 var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
										setAutoGridHeight("editgrid",reduceHeight);
										
										var editinfo = $("#editinfo").val();
										var deleteinfo = $("#deleteinfo").val();										
										addRowOperBtnimage('editgrid','openRowModify','JhjID','click',1,"style/images/public/ltubiao_01.gif",editinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'CtlPort','YwID');//修改
										addRowOperBtnimage('editgrid','deleteRow','JhjID','click',2,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'CtlPort','YwID');//删除
										addRowOperBtnimage('editgrid','openRowInfo','JhjID','click',3,'style/images/public/ltubiao_03.gif',"详细","&nbsp;&nbsp;&nbsp;",'CtlPort','YwID');//详细
																				
										executeAddBtn('editgrid',3);
										},
										ondblClickRow: function(ids) {
											if(ids != null) {
												var JhjID =$("#editgrid").getCell(ids,"JhjID");
												var CtlPort =$("#editgrid").getCell(ids,"CtlPort");
												var YwID =$("#editgrid").getCell(ids,"YwID");
												
												openRowInfo(JhjID,CtlPort,YwID);
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
 * 第一个选项卡上lable标签国际化
 	表txkz_ctlset
 * @param 
 * @return 
 */
function langLable(){
		//获取数据表对应字段国际化信息
		var languageType = $("#languageType").val();	
		var thisdata = loadData('txkz_ctlset',languageType,1);
		
		var jhjidg = thisdata.getFieldAliasByFieldName('JhjID');
		var jhjxg = thisdata.getFieldAliasByFieldName('Jhjx');
		var jhjareag = thisdata.getFieldAliasByFieldName('JhjArea');
		var ywlxg = thisdata.getFieldAliasByFieldName('Ywlx');
		var dllnameg = thisdata.getFieldAliasByFieldName('DllName');
		
		var ctlportg = thisdata.getFieldAliasByFieldName('CtlPort');
		var ywidg = thisdata.getFieldAliasByFieldName('YwID');
		var protocolg = thisdata.getFieldAliasByFieldName('Protocol');
		var ctlsysnameg = thisdata.getFieldAliasByFieldName('CtlSysName');
		var paramsg = thisdata.getFieldAliasByFieldName('Params');
					
		//给页面中存储字段的隐藏标签赋值			
		$("#jhjidg").html(jhjidg);
		$("#jhjxg").html(jhjxg);
		$("#jhjareag").html(jhjareag);
		$("#ywlxg").html(ywlxg);
		$("#dllnameg").html(dllnameg);
		
		$("#ctlportg").html(ctlportg);
		$("#ywidg").html(ywidg);
		$("#protocolg").html(protocolg);
		$("#ctlsysnameg").html(ctlsysnameg);
		$("#paramsg").html(paramsg);
		
		var thisdataParam = loadData('dllparam',languageType,1);
		var pnameg = thisdata.getFieldAliasByFieldName('PName');
		var pdislabelg = thisdata.getFieldAliasByFieldName('PDisLabel');
		var pvalueg = thisdata.getFieldAliasByFieldName('PValue');
		var bzg = thisdata.getFieldAliasByFieldName('Bz');

		//给页面中存储字段的隐藏标签赋值			
		$("#pnameg").html(pnameg);
		$("#pdislabelg").html(pdislabelg);
		$("#pvalueg").html(pvalueg);
		$("#bzg").html(bzg);
		
		$("#pnameg_s").html(pnameg);
		$("#pdislabelg_s").html(pdislabelg);
		$("#pvalueg_s").html(pvalueg);
		$("#bzg_s").html(bzg);
}

/*****************************************  第一分项卡 ****************************************************/
/**
* 初始化设备编号
* @param 
* @return 
*/
function getJhjId(){
		var fieltext='';			
		var urlstr=buildParamsSql('query','xmlattr','mnuControlSet.getjhjid','');
		$.ajax({
			url:'mainServlet.html?'+urlstr,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				$(xml).find('row').each(function(){
					var jhjid = $(this).attr("jhjid");
					fieltext+="<option value='"+jhjid+"'>"+jhjid+"</option>";
				});
			}
		});
		fieltext ="<option value=''>--请选择--</option>"+fieltext;
		$("#jhjid").html(fieltext).trigger("change");
}
/**
* 设备编号改变触发事件
* @param 
* @return 
*/
function getValbyJhjid(val){			
		var urlstr=buildParamsSql('query','xmlattr','mnuControlSet.getValByJhjid','');		
		$.ajax({
			url:'mainServlet.html?'+urlstr+"&JhjID="+val,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				$(xml).find('row').each(function(){
					var jhjname = $(this).attr("jhjname");
					var jhjarea = $(this).attr("jhjarea");
					$("#jhjx").val(jhjname);
					$("#jhjarea").val(jhjarea);
					getValbyJhjname(jhjname);
				});
			}
		});	
}
/**
* 业务类型获取 设备型号改变触发事件
* @param 
* @return 
*/
function getValbyJhjname(val){

		var fieltext='';//存放
		var urlstr=buildParamsSql('query','xmlattr','mnuControlSet.getValByArae','');
		$.ajax({
			url:'mainServlet.html?'+urlstr+"&Jhjx="+tsd.encodeURIComponent(val),
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				
				$(xml).find('row').each(function(){
					var ywlx = $(this).attr("ywlx");
					var dllname = $(this).attr("dllname");
					if(ywlx!=undefined){
						fieltext+="<option value='"+ywlx+"' dllnameval='"+dllname+"'>"+ywlx+"</option>";
					}
				});
			}
		});
		$("#ywlx").html("");
		fieltext ="<option value=''>--请选择--</option>" +fieltext;
		$("#ywlx").html(fieltext).trigger("change");
}

/**
* 控制脚本库获取 ，根据业务类型改变触发事件 
* @param val 业务类型值
* @return 
*/
function getDllname(val){	
	var dllnameval = $("#ywlx option[value="+val+"]").attr("dllnameval");
	$("#dllname").val(dllnameval);
}

/**
* 初始化协议类型
* @param 
* @return 
*/
function getProType(){	
		var fieltext='';		
		var urlstr=buildParamsSql('query','xmlattr','mnuControlSet.getProType','');		
		$.ajax({
			url:'mainServlet.html?'+urlstr,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				$(xml).find('row').each(function(){
					var dllname = $(this).attr("dllname");
					fieltext+="<option value='"+dllname+"'>"+dllname+"</option>";	
				});
			}
		});
		fieltext ="<option value=''>--请选择--</option>" +fieltext;
		$("#protocol").html(fieltext).trigger("change");			
}
/**
* 根据协议类型获取协议参数信息
* @param val 协议类型
* @return 
*/
function getParamsByPro(val){
		//清空协议参数信息
		$("#paramTab").html("");
		//如果没有选择协议参数，隐藏协议参数信息面板
		if(val==''){
			$("#paramTable").hide();		
			return false;
		}
		else{
			$("#paramTable").show();	
		}
		var fieltext='';
		var urlstr=buildParamsSql('query','xmlattr','mnuControlSet.getParams','');		
		$.ajax({
			url:'mainServlet.html?'+urlstr+'&DllName='+val,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				$(xml).find('row').each(function(){
					var pname = $(this).attr("pname");
					var pdislabel = $(this).attr("pdislabel");
					var pvalue = $(this).attr("pvalue");
					var bz = $(this).attr("bz");
					
					var str='<tr>';
					str +='<td class="labelclass" width="12%">';
					str +='<label id="pname_1">'+pname+'</label>';
					str +='</td>';
					str +='<td class="labelclass" width="12%">';
					str +='<label id="pdislabel_1">'+pdislabel+'</label>';
					str +='</td>';
					str +='<td width="38%">';
					str +='<input type="text" id="pvalue_1" name="pvalue_1" class="textclass" value="'+pvalue+'"/>';
					str +='</td>';			
					str +='<td width="38%">';
					str +='<input type="text" id="bz_1" class="textclass2" value="'+bz+'" readonly="readonly"/>';
					str +='</td>';		
					str +='</tr>';
					fieltext+=str;
					
				});
			}
		});
		$("#paramTab").append(fieltext);
}

/**
 * 显示详细信息 
 * @param jhjid	，ywid， ctlport 三个关键字的值
 * @return
 */
function openRowInfo(jhjid,ctlport,ywid){		
		markTable(1);//显示红色*号		
		$(".top_03").html($("#mesall").val());//设置编辑框的标题
		clearText('operformT1');		
		
		var whereinfo ="&jhjid="+jhjid+"&ywid="+ywid+"&ctlport="+tsd.encodeURIComponent(ctlport);
		queryByID(whereinfo);
				
		openpan();
		isFieldDisabled('txkz_ctlset','','','lower');//将修改面板的输入框全部置为不可用
		isParamDisabled();//将协议参数值标签置为不可用	
}
/**
 * 将协议参数值标签置为不可用
 * @param 
 * @return
 */
function isParamDisabled(){
		$("input[name='pvalue_1']").attr("disabled","disabled");		
		$("input[name='pvalue_1']").removeClass("textclass");
		$("input[name='pvalue_1']").addClass("textclass2");
}

/**
 * 将协议参数值标签置为可用
 * @param 
 * @return
 */
function removeParamDisabled(){
		$("input[name='pvalue_1']").removeAttr("disabled");
		$("input[name='pvalue_1']").removeClass("textclass2");
		$("input[name='pvalue_1']").addClass("textclass");
		
}
var closeflash = false;//用于判断添加操作是保存新增，或保存退出。保存新增closeflash=true ；保存退出=false
/**
 * 添加操作 
 * @param saves: 0保存新增 1保存退出
 * @return
 */
function saveObj(saves){
			
		//判断关键字是否为空 、判断关键字是否已经存在		
		var falg = keyIsExits();
		if(falg==false){return false;}
		
		//获取参数
		var params=addBuildParams();
		if(params==false){return false;}
		
		var urlstr=buildParamsSql('exe','xml','mnuControlSet.add','');
		urlstr+=params;
					
		//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)
		$.ajax({
		url:'mainServlet.html?'+urlstr,
		cache:false,//如果值变化可能性比较大 一定要将缓存设成false
		timeout: 1000,
		async: false ,//同步方式
			success:function(msg){
				if(msg=="true"){				
					var successful = $("#successful").val();
					alert(successful);						
					
					//写入日志操作	
					var logcontent = $("#logcontent").val();					
					logwritePub('txkz_ctlset',1,transferApos(logcontent));
					
					//判断是保存新增 或是保存退出
					if(saves==2){
						$("#editgrid").trigger("reloadGrid");
						setTimeout($.unblockUI, 0);//关闭面板	
					}else{
						closeflash=true;//表示关闭时需要刷新									
						clearText('operformT1');
					}
				
				}
			}
		});	
		closeo();	
}


 /**
 * 打开修改面板
 * @param
 * @return 
 */
function openRowModify(key1,key2,key3){
		//判断是否有删除权限						
		var editright = $("#editright").val();
		if(editright=="true"){				
				markTable(0);//显示红色*号
				var editinfo = $("#editinfo").val();
			 	$(".top_03").html(editinfo);//设置编辑框的标题			 	
				openpan();//打开面板
				$("#modify1").show();
				$("#reset1").show();
				clearText('operformT1');
				
				var whereinfo = "&jhjid="+key1 +"&ctlport="+tsd.encodeURIComponent(key2) +"&ywid="+tsd.encodeURIComponent(key3);
				queryByID(whereinfo);//设置修改面板的初始值
				$("#modifyreset").val(whereinfo);	//将查询该条记录的条件写入隐藏域，作为面板的取消按钮条件
				
				isFieldDisabled('txkz_ctlset','','','lower');//将修改面板的输入框全部置为不可用			
				setTableFieldsAble('txkz_ctlset','editfields','','','lower');//根据配置设置可编辑文本框
				//alert($("#protocol").attr("disabled"));
				if($("#protocol").attr("disabled")==false){
					removeParamDisabled();//将协议参数值标签置为可用
				}
				else if($("#protocol").attr("disabled")==true){
					isParamDisabled();//将协议参数值标签置为可用
				}
				
				keyWordDisabled('jhjid,ywid,ctlport','','');//设置主键为不可编辑						
		}
		else{
				alert($("#editpower").val());//提示没有修改权限
		}
}


/**
 *  根据关键字取出一条信息，详细记录
 * @param  whereinfo：条件
 * @return 
 */
function queryByID(whereinfo){  
		 		
 		var urlstr=tsd.buildParams({ 
							  packgname:'service',//java包
							  clsname:'ExecuteSql',//类名
							  method:'exeSqlData',//方法名
							  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
							  tsdoper:'query',//操作类型
							  datatype:'xmlattr',//返回数据格式
							  tsdpk:'mnuControlSet.queryByKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		});
									
		$.ajax({
			url:'mainServlet.html?'+urlstr+whereinfo,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				
					//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值
					//读取row里面的属性的个数
					if(xml.getElementsByTagName("row").length==1){
						var attrA = xml.getElementsByTagName("row")[0].attributes;
						for(var i=0;i<attrA.length;i++){						
							var keyname = attrA[i].nodeName;
							var keyval = attrA[i].nodeValue;
							//由于业务类型中的下拉框中的值，是根据设备型号从数据表中取得的，此处需要根据设备型号从数据表中读取当前可下来选择值。
							if(keyname=="jhjx"){
								$("#"+keyname).val(keyval);						
								getValbyJhjname($("#jhjx").val());	
							}
							else if(keyname=="protocol"){
								$("#"+keyname).val(keyval).trigger("change");						
							}
							else if(keyname=="params"){							
								$("#paramTab tr").each(function(){
						      			var pnameval = $(this).children("td:eq(0)").children("#pname_1").text();					      			
						      			var pvalueval = getCaption(keyval,pnameval,'');					      			
						      			$(this).children("td:eq(2)").children("#pvalue_1").val(pvalueval);					      			
						      	});
							}else{
								$("#"+keyname).val(keyval);
							}
							result[keyname]= keyval;
						}
					}
									
			}
		});
}


 /**
 * 修改面板中，修改按钮操作
 * @param
 * @return 
 */
function modifyObj(){
		 var params = modifyBuildParams();
		 if(params==false){return false;}
					
		 var urlstr=tsd.buildParams({     packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'',//指向配置文件名称
										  tsdoper:'exe',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:'mnuControlSet.modify'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		});
	
		$.ajax({
			url:'mainServlet.html?'+urlstr +params ,
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(msg){
				if(msg=="true"){
					//操作提示国际化 操作成功
					var successful = $("#successful").val();
					alert(successful);								
										
					setTimeout($.unblockUI, 0);//释放资源 
					$("#editgrid").trigger("reloadGrid");//更新jqgrid
					
					//写入日志操作
					var logcontent = $("#logcontent").val();
					var logcondition = $("#logcondition").val();
					logwritePub('txkz_ctlset',3,transferApos(logcontent),transferApos(logcondition));
				}	
			}
		});
}

/**
 * 判断关键字是否已经存在 
 * @param 
 * @return
 */
function keyIsExits(){	
		
		//获取关键字的值，同时判断该关键字是否为空，为空弹出提示退出保存
		var keymesg='';
		var keyname='';
		for(var i=0;i<keys[0].length;i++){
			var keyval = $("#"+keys[0][i]).val();
			if(keyval==''||keyval==undefined){				
				alert($("#inputinfo").val()+$("#"+keys[0][i]+"g").text());
				$("#"+keys[0][i]).focus();
				return false;
			}else{
				keymesg +="&"+keys[0][i]+"="+tsd.encodeURIComponent(keyval);
				keyname +=" "+$("#"+keys[0][i]+"g").text();				
			}			
		}
		
		//判断关键字是否已经存在
		var falg = true;
		var urlstr1=buildParamsSql('query','xmlattr','mnuControlSet.existed','');
		$.ajax({
				url:'mainServlet.html?'+urlstr1+keymesg,
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
					/////////////////////////////
					//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
					$(xml).find('row').each(function(){
						//获取该关键字组合存在的记录数
						var keynum = $(this).attr("keynum");
						if(keynum > 0){	
								alert(keyname+"的组合已经被使用，请重新输入！");	
								$("#jhjid").focus();		
								falg = false;						
						}
					});
				}
		});
		return falg;
}


 /**
 * 删除指定的记录
 * @param
 * @return 
 */
function deleteRow(jhjid,ctlport,ywid){	 	 	
	 	//是否有执行删除的权限 			 
		var deleteright = $("#deleteright").val();
		if(deleteright=="true"){	
		 	var deleteinformation = $("#deleteinformation").val();			
			if(confirm(deleteinformation)){
			
					
					var whereinfo ="&jhjid="+jhjid+"&ywid="+ywid+"&ctlport="+tsd.encodeURIComponent(ctlport);					
						 		 	
					var urlstr=tsd.buildParams({  packgname:'service',//java包
												  clsname:'ExecuteSql',//类名
												  method:'exeSqlData',//方法名
												  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												  tsdcf:'',//指向配置文件名称
												  tsdoper:'exe',//操作类型 
												  datatype:'xml',//返回数据格式 
												  tsdpk:'mnuControlSet.delete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												});
					var urlstr='mainServlet.html?'+urlstr+whereinfo; 
					$.ajax({
						url:urlstr,
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(msg){
							if(msg=="true"){
								var successful = $("#successful").val();
								alert(successful);
								setTimeout($.unblockUI, 0);
								$("#editgrid").trigger("reloadGrid");
								
								//写入日志操作 
								var strcontent = $("#jhjidg").html()+":"+jhjid+";";
								strcontent += $("#ywidg").html()+":"+ywid+";";
								strcontent += $("#ctlportg").html()+":"+ctlport;
								logwritePub('txkz_ctlset',2,'',transferApos(strcontent));
							}
						}
					});	
			}
		}
		else{
			var deletepower = $("#deletepower").val();
			alert(deletepower);
		}
}		

/**
 * 修改面板，通过表单值构造数据操作参数 请根据业务参数的多少和属性进行修改
 * @param 
 * @return 
 */
function modifyBuildParams(){
		//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;				
	 	var params='';
										
	 	var jhjid = $("#jhjid").val();
	 	var protocol = $("#protocol").val();
	 	var jhjx = $("#jhjx").val().replace(/(^\s*)|(\s*$)/g,"");
	 	var jhjarea = $("#jhjarea").val().replace(/(^\s*)|(\s*$)/g,"");
	 	var ywlx=$("#ywlx").val();
	 	
	 	var dllname = $("#dllname").val().replace(/(^\s*)|(\s*$)/g,"");				 	
	 	var ctlport = $("#ctlport").val().replace(/(^\s*)|(\s*$)/g,"");
	 	var ywid = $("#ywid").val().replace(/(^\s*)|(\s*$)/g,"");
	 	var ctlsysname=$("#ctlsysname").val().replace(/(^\s*)|(\s*$)/g,"");
		
		var modifyfield = ' set '; //存放保存数据的前半部分
 		var modifykey = ' '; //存放保存数据的后半部分
 		
		///////////////////////////////必填项验证      	
    	//必填
		if(ywlx==''){
			var str=$("#ywlxg").text();
			alert($("#inputinfo").val()+str);
			$("#ywlx").focus();
			return false;
		}
		//必填 字符串
		if(ctlsysname==''){
			var str=$("#ctlsysnameg").text();
			alert($("#inputinfo").val()+str);
			$("#ctlsysname").focus();
			return false;
		}				
		//必填 字符串
		if(protocol==''){
			var str=$("#protocolg").text();
			alert($("#inputinfo").val()+str);
			$("#protocol").focus();
			return false;
		}				
		//协议参数
		var paramsval='';
		$("#paramTab tr").each(function(){
      			var pnameval = $(this).children("td:eq(0)").children("#pname_1").text();
      			var pvalueval = $(this).children("td:eq(2)").children("#pvalue_1").val();
      			if(pvalueval!='' && pvalueval!=undefined){
      				paramsval+="{"+pnameval+"="+tsd.encodeURIComponent(pvalueval)+"/}"
      			}
      	});
      	//协议参数为必填
      	if(paramsval==''){
      		alert("请输入协议参数值！");
      		$("#pvalue_1").focus();
			return false;
      	}
		
		//如果有可能值是汉字 请使用encodeURI()函数转码				
		//非关键字
		if(result["jhjx"]!=jhjx){
			modifyfield +="jhjx='"+tsd.encodeURIComponent(jhjx)+"',";
		}
		if(result["jhjarea"]!=jhjarea){
			modifyfield +="jhjarea='"+tsd.encodeURIComponent(jhjarea)+"',";
		}
		if(result["ywlx"]!=ywlx){
			modifyfield +="ywlx='"+tsd.encodeURIComponent(ywlx)+"',";
		}
		if(result["dllname"]!=dllname){
			dllname = dllname.replace(new RegExp("\\\\","g"),"\\\\\\");
			modifyfield +="dllname='"+tsd.encodeURIComponent(dllname)+"',";
		}			 	
		if(result["protocol"]!=protocol){
			modifyfield +="protocol='"+tsd.encodeURIComponent(protocol)+"',";
		}
		if(result["ctlsysname"]!=ctlsysname){
			modifyfield +="ctlsysname='"+tsd.encodeURIComponent(ctlsysname)+"',";
		}
		if(result["params"]!=paramsval){
			modifyfield +="params='"+paramsval+"',";
		}			 	
	 	
	 	//去掉最后的逗号
	 	modifyfield = modifyfield.substring(0,modifyfield.length-1);
	 	//如果没有修改任何字段则提示：请输入要修改的信息
	 	if(modifyfield==''){
	 		alert("请输入要修改的信息！");
	 		return false;
	 	}
	 	//关键字
		modifykey+="jhjid="+jhjid+" and ";
		modifykey+="ctlport='"+tsd.encodeURIComponent(ctlport)+"' and ";
		modifykey+="ywid="+ywid;
		
		params = "&modifySet="+modifyfield+"&whereinfo="+modifykey ;
		$("#logcontent").val(modifyfield);
		$("#logcondition").val(modifykey);
	 	//每次拼接参数必须添加此判断
		if(tsd.Qualified()==false){return false;}
		return params;
}
/**
 * 添加、修改面板，通过表单值构造数据操作参数 请根据业务参数的多少和属性进行修改
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 	@oper 操作类型 modify|save 	
 * @param 
 * @return 
 */
function addBuildParams(){
    switch(tabStatus){
   		case 1:
   				//每次拼接参数必须初始化此参数
				tsd.QualifiedVal=true;				
			 	var params='';
				
			 	var jhjid = $("#jhjid").val();
			 	var jhjx = $("#jhjx").val().replace(/(^\s*)|(\s*$)/g,"");
			 	var jhjarea = $("#jhjarea").val().replace(/(^\s*)|(\s*$)/g,"");
			 	var ywlx=$("#ywlx").val();
			 	var dllname = $("#dllname").val().replace(/(^\s*)|(\s*$)/g,"");	
			 	
			 	var ctlport = $("#ctlport").val().replace(/(^\s*)|(\s*$)/g,"");
			 	var ywid = $("#ywid").val().replace(/(^\s*)|(\s*$)/g,"");
			 	var protocol = $("#protocol").val();
			 	var ctlsysname=$("#ctlsysname").val().replace(/(^\s*)|(\s*$)/g,"");	 	
				
				//必填
				if(ywlx==''){
					var str=$("#ywlxg").text();
					alert($("#inputinfo").val()+str);
					$("#ywlx").focus();
					return false;
				}
				//必填 字符串
				if(ctlsysname==''){
					var str=$("#ctlsysnameg").text();
					alert($("#inputinfo").val()+str);
					$("#ctlsysname").focus();
					return false;
				}				
				//必填 字符串
				if(protocol==''){
					var str=$("#protocolg").text();
					alert($("#inputinfo").val()+str);
					$("#protocol").focus();
					return false;
				}				
				//协议参数
				var paramsval='';
				$("#paramTab tr").each(function(){
		      			var pnameval = $(this).children("td:eq(0)").children("#pname_1").text();
		      			var pvalueval = $(this).children("td:eq(2)").children("#pvalue_1").val();
		      			if(pvalueval!='' && pvalueval!=undefined){
		      				paramsval+="{"+pnameval+"="+tsd.encodeURIComponent(pvalueval)+"/}"
		      			}
		      	});
		      	//协议参数为必填
		      	if(paramsval==''){
		      		alert("请输入协议参数值！");
		      		$("#pvalue_1").focus();
					return false;
		      	}
		
			 	//如果有可能值是汉字 请使用encodeURI()函数转码
			 	params+="&jhjid="+jhjid;
			 	params+="&jhjx="+tsd.encodeURIComponent(jhjx);
			 	params+="&jhjarea="+tsd.encodeURIComponent(jhjarea);
			 	params+="&ywlx="+tsd.encodeURIComponent(ywlx);
			 	//替换特殊字符反斜杠 \替换成双斜杠\\
			 	dllname = dllname.replace(new RegExp("\\\\","g"),"\\\\\\");
			 	params+="&dllname="+tsd.encodeURIComponent(dllname);			 	
			 	
			 	params+="&ctlport="+tsd.encodeURIComponent(ctlport);
			 	params+="&ywid="+ywid;
			 	params+="&protocol="+tsd.encodeURIComponent(protocol);
			 	params+="&ctlsysname="+tsd.encodeURIComponent(ctlsysname);
			 	params+="&params="+paramsval;
			 	
			 	//存放日志
			 	var logstr='';
			 	logstr += $("#jhjxg").html()+" : "+jhjx+"; ";
			 	logstr += $("#jhjareag").html()+" : "+jhjarea+"; ";
			 	logstr += $("#ywlxg").html()+" : "+ywlx+"; ";
			 	logstr += $("#dllnameg").html()+" : "+dllname+"; ";
			 	logstr += $("#protocolg").html()+" : "+protocol+"; ";
			 	logstr += $("#ctlsysnameg").html()+" : "+ctlsysname+"; ";
			 	logstr += $("#paramsg").html()+" : "+paramsval;
			 	
			 	
			 	logstr += $("#jhjidg").html()+" : "+jhjid+"; ";
			 	logstr += $("#ywidg").html()+" : "+ywid+"; ";
			 	logstr += $("#ctlportg").html()+" : "+ctlport+"; ";
			 	$("#logcontent").val(logstr);
			 	
			 	//每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}
				return params;
				break;
		case 2:				
				break;
	}////switch end		  		
}
/**
 * jqgrid上新增按钮操作 ，弹出新增面板
 * @param
 * @return
 */
function openadd(){
		$(".top_03").html($("#addinfo").val());//标题
		markTable(0);//显示红色*号
		removeFieldDisabled('txkz_ctlset','','','lower');
		removeParamDisabled();//将协议参数值标签置为可用	
		openpan();
		$("#save1").show();
		$("#readd1").show();
		clearText('operformT1');
}
 /**
 * 打开表格面板
 * @param 
 * @return 
 */
function openpan(){
	switch(tabStatus){
			case 1:				
				autoBlockFormAndSetWH('panTab1',60,5,'closeo1',"#ffffff",false,1000,'');//弹出查询面板				
				$("#jdquery1").hide();
				$("#readd1").hide();
				$("#save1").hide();
				$("#modify1").hide();
				$("#reset1").hide();
				$("#clearB1").hide();
				break;
				
			case 2:
				break;
	}		
}
 /**
 * 关闭表格面板
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function closeo(){
		if(closeflash){
		 		 closeflash=false;
		 		 $("#editgrid").trigger("reloadGrid");
		 }
		 switch(tabStatus){
			case 1:
				clearText('operformT1');
				break;
			case 2:			
				break;
		}			
		setTimeout($.unblockUI, 0);//关闭面板		
}

 /**
 * 修改面板的取消按钮操作
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function resett(){		
		switch(tabStatus){
			case 1:
				clearText('operformT1');	
				var whereinfo = $("#modifyreset").val();			
				queryByID(whereinfo);
				break;
			case 2:
				break;
		}
}	
/*****************************************  通用部分 ****************************************************/
/**
 * 高级查询参数获取
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function fuheQbuildParams(){
	 	//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
	 	var params=''; 	
	 		 	
	 	var fusearchsql = encodeURIComponent($("#fusearchsql").val());
	 	//如果有可能值是汉字 请使用encodeURI()函数转码
	 	params+='&fusearchsql='+fusearchsql;
	 	if(params=='&fusearchsql='){
			params +='1=1';
		}		 	
	 	//注意：不要在此做空的判断 即使为空 也必须放入请求中			 	
	 	//每次拼接参数必须添加此判断
		if(tsd.Qualified()==false){return false;}
		return params;
}

/**
 * 进行通用查询 批量删除 批量修改入口；
 	根据隐藏域queryName 判断是何种操作 delete：批量删除 ；modify：批量修改；其他：高级查询
 * @param 
 * @return 
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
			fuheOpenModify();
		}
		else
		{
			fuheQuery();
		}
}


/**
 * 高级查询操作，通过高级查询面板生成查询条件，查询和刷新jqgrid面板中的信息
 通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function fuheQuery()
{	
			var params = fuheQbuildParams();				
		 	var column='';
		 	column = $("#ziduansF1").val();
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
			
			var link = urlstr1 + params;			
		 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
		 	setTimeout($.unblockUI, 15);//关闭面板
}

/**
 * 组合排序 
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param sqlstr 进行组合排序的排序sql子语句
 * @return 
 */
function zhOrderExe(sqlstr){
		var params = fuheQbuildParams();			
		
		params =params+'&orderby='+sqlstr;	 	
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
		var column='';
		column = $("#ziduansF1").val();
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");	 	 	
}
/**
 * 页面上组合排序按钮操作，打开组合排序窗口
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */     
function openwinO(){
	openDiaO('txkz_ctlset');	
}

/**
 * 页面上高级查询按钮操作，打开查询窗口
 * @param 
 * @return 
 */	
function openwinQ()
{
		openfuh("query");				
}
			
 /**
 * 高级查询、批量修改、批量删除打开查询窗口
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param str str打开窗口方法，query modify delete存放在隐藏域queryName
 * @return 
 */	
function openfuh(str){	
		openDiaQueryG(str,'txkz_ctlset','1');
}

 /**
 * 打开保存本次查询面板
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @return 
 */	
function openSaveModPan(){
		openModT('txkz_ctlset','1');
}

/**
 * 查询模板保存面板中的保存按钮操作，用于保存本次查询为模板
	 通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function addQuery(){
	saveModQuery(tabStatus);
}

 /**
 * 模板查询按钮操作，弹出查询模板信息窗口，用户可根据该查看信息，选择已有查询模板进行查询
 * @param 
 * @return 
 */
function modQuery(){	
	 openQueryM(tabStatus);
}

 /**
 *导出数据面板的导出按钮操作
 * @param 
 * @return 
 */
function saveExoprt(){
		getTheCheckedFields('tsdBilling','mssql','txkz_ctlset');
 }
 /**
 *页面上导出按钮操作
 * @param
 * @return 
 */
 function openExport(){
 		var languageType = $("#languageType").val();
 		thisDownLoad('tsdBilling','mssql','txkz_ctlset',languageType);
 }
 /************************************ 第二个分享卡   ********************************************/
 
 /**
* 初始化第二个分项卡的表格信息
* @param val 协议类型
* @return 
*/
function getParamsTwo(){	
		var fieltext='';
		var fieldval = '';
		$("#paramTabTwo").html("");	
		var urlstr=buildParamsSql('query','xmlattr','mnuControlSet.ParamsTwo','');		
		$.ajax({
			url:'mainServlet.html?'+urlstr,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				fieldnametow.length=0;
				$(xml).find('row').each(function(){
					var pname = $(this).attr("pname");
					var pdislabel = $(this).attr("pdislabel");
					var pvalue = $(this).attr("pvalue");
					var bz = $(this).attr("bz");
					var dispos = $(this).attr("dispos");
					if(dispos==1){
						fieldval = pvalue;
					}				
					var str='<tr>';
					str +='<td class="labelclass" width="12%">';
					str +='<label id="">'+pname+'</label>';
					str +='</td>';
					str +='<td class="labelclass" width="15%">';
					str +='<label id="">'+pdislabel+'</label>';
					str +='</td>';
					str +='<td width="35%">';
					str +='<input type="text" id="'+pname+'" class="textclass" value=""/>';
					str +='</td>';			
					str +='<td width="38%">';
					str +='<label >'+bz+'</label>';
					//'<textarea rows="3" cols="40" >'+bz+'</textarea>';
					str +='</td>';		
					str +='</tr>';
					fieltext+=str;
					fieldnametow.push(pname);		
				});			
			}			
		});
		$("#paramTabTwo").append(fieltext);			
		$("#oldparamsTwo").val(fieldval);
		setParamsVal();	
}

/**
* 初始化第二个分项卡的表格信息 设置输入域的值
* @param  表中DllParam条件为DllName='DllTestParamSet.dll' and DisPos=1的pvalue的值
* @return 
*/
function setParamsVal(){
	//alert("第二个页面！");
	var fieldval = $("#oldparamsTwo").val();
	for(var i=0; i<fieldnametow.length;i++){
		$("#"+fieldnametow[i]).val(getCaption(fieldval, fieldnametow[i], ''));		
	}
}

/**
* 第二个分项卡保存按钮事件
* @param 
* @return 
*/
function saveParams(){
		
		//获取参数
		var params=TwoBuildParams();
		if(params==false){return false;}
		
		var urlstr=buildParamsSql('exe','xml','mnuControlSet.updateParamsTwo','');
		urlstr+=params;
		
		//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)
		$.ajax({
		url:'mainServlet.html?'+urlstr,
		cache:false,//如果值变化可能性比较大 一定要将缓存设成false
		timeout: 1000,
		async: false ,//同步方式
			success:function(msg){
				if(msg=="true"){
					var successful = $("#successful").val();
					alert(successful);
					$("#oldparamsTwo").val(params.split("pvalue=")[1]);
					//写入日志操作
					logwritePub('DllParam',3,$("#pvalueg_s").text()+":"+transferApos(params.split("pvalue=")[1]),transferApos("DllName=''DllTestParamSet.dll'' and DisPos=1"));
					
				}
			}
		});	
}

/**
* 第二个分项卡保存按钮事件
* @param 
* @return 
*/
function TwoBuildParams(){
	
		//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;				
	 	var params='';
	 		
 		//协议参数
		var paramsval='';
		for(var i=0; i<fieldnametow.length;i++){
			var valstr = $("#"+fieldnametow[i]).val();
			if(valstr!=''){
				paramsval+="{"+fieldnametow[i]+"="+tsd.encodeURIComponent(valstr)+"/}";				
			}			
		}							
	 	
	 	params = "&pvalue="+paramsval ;
	 	/**** 是否有修改值			
		var oldparamsTwo = $("#oldparamsTwo").val();
		if(oldparamsTwo!=paramsval){
			
		}else{
			alert("请输入要修改的值再点击保存！");
			return false;
		}	
		****/	
	 	//每次拼接参数必须添加此判断
		if(tsd.Qualified()==false){return false;}
		return params;
}


/**
* 查看当前用户的扩展权限，对spower字段进行解析
* @param 
* @return 
*/
function getUserPower(){
				 var urlstr=buildParamsPro('subsidyPay.getPower','query');
				 
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
				
				var queryright = '';				
				var queryMright = '';
				var saveQueryMright ='';
				
				var saveParamsright = '';//第二个分项卡 保存按钮
				
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
							
							queryright += getCaption(spowerarr[i],'query','')+'|';
							queryMright += getCaption(spowerarr[i],'queryM','')+'|';
							saveQueryMright += getCaption(spowerarr[i],'saveQueryM','')+'|';
							saveParamsright += getCaption(spowerarr[i],'saveParams','')+'|';
						
						}
				}else if(spower=='all@'){
						$("#addright").val(str);
						$("#delBright").val(str);
						$("#editBright").val(str);
						$("#deleteright").val(str);
						$("#editright").val(str);
						$("#exportright").val(str);
						$("#printright").val(str);
						
						$("#queryright").val(str);						
						$("#queryMright").val(str);
						$("#saveQueryMright").val(str);
						$("#saveParamsright").val(str);
						
						editfields = getFields('txkz_ctlset');
						editfields_son = getFields('dllparam');
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
					
					var hasquery = queryright.split('|');
					var hasqueryM = queryMright.split('|');
					var hassaveQueryM = saveQueryMright.split('|');
					
					var hassaveParams = saveParamsright.split('|');
					for(var i = 0;i<hasquery.length;i++){
						if(hasquery[i]=='true'){
							$("#queryright").val(str);
							break;
						}
					}					
					for(var i = 0;i<hasqueryM.length;i++){
						if(hasqueryM[i]=='true'){
							$("#queryMright").val(str);
							break;
						}
					}
					
					for(var i = 0;i<hassaveQueryM.length;i++){
						if(hassaveQueryM[i]=='true'){
							$("#saveQueryMright").val(str);
							break;
						}
					}
					
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
					
					for(var i = 0;i<hassaveParams.length;i++){
						if(hassaveParams[i]=='true'){
							$("#saveParamsright").val(str);
							break;
						}
					}			
				}
				$("#editfields").val(editfields);
				$("#editfields_son").val(editfields_son);
}
