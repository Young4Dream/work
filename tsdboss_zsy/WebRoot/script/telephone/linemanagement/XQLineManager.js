/*****************************************************************
 * name: script/telephone/linemanagement/XQLineManager.js
 * author: 尤红玉
 * version: 1.0, 2011-9-26
 * description: 小区号线设备管理
 * modify: 
 *		
 *****************************************************************/
	//用于生产面板路由设置
	RountNUM=4;
	RountD = new Array();
	RountD[0]=new Array();
	RountD[0].push('01');
	RountD[0].push('分光器');
	RountD[0].push('fgq');
	
	RountD[1]=new Array();
	RountD[1].push('02');
	RountD[1].push('托盘');
	RountD[1].push('tp');
	
	RountD[2]=new Array();
	RountD[2].push('03');
	RountD[2].push('ONU');
	RountD[2].push('onu');
	
	RountD[3]=new Array();
	RountD[3].push('04');
	RountD[3].push('地址');
	RountD[3].push('dz');
	 
 /**
* 打开二级设备管理窗口
* @param NodeField：设备别名
* @return 
*/
function showDeviceType(NodeField,deviceField,deviceName)
{	
    var mkj = $('#limitroute').val();
    window.showModalDialog('mainServlet.html?pagename=telephone/linemanagement/XQselDeviceType.jsp&NodeField=' 
    + NodeField + '&mkj=' + tsd.encodeURIComponent(mkj)+'&deviceField='+deviceField+'&deviceName='+tsd.encodeURIComponent(deviceName), 
    window, "dialogWidth:710px; dialogHeight:420px; center:yes; scroll:no");
}

/**
 * 回调函数，用于设置设备时自动设置相同段中的其它设备
 * @param xqlineid 号线id
 * @return 
 */
function getTheVlaueR(xqlineid)
{   
   getAssociate(xqlineid); //获取关联端口信息     
}


/**
 * 获取关联端口信息
 * @param xqlineid ：号线id
 * @return 无返回值
 */
 function getAssociate(xqlineid){
 			var params ='&xqlineid='+xqlineid;		
			var urlstr=tsd.buildParams({ 
							packgname : 'service', //java包
					        clsname : 'ExecuteSql', //类名
					        method : 'exeSqlData', //方法名
					        ds : 'tsdBilling', //数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
					        tsdcf : 'mssql', //指向配置文件名称
					        tsdoper : 'query', //操作类型 
					        datatype : 'xmlattr', //返回数据格式 
					        tsdpk :'XQLineManager.getAssociate' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
  				});
			$.ajax({
					url:'mainServlet.html?'+urlstr+params,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 3000,
					async: false ,//同步方式
					success:function(xml){
						var deviceno ='';
						var devicename ='';
						var nodename ='';
						$(xml).find('row').each(function(){
							//deviceno ,devicename,nodename 
							var fgq = $(this).attr("fgq");
							var tp = $(this).attr("tp");
							var onu = $(this).attr("onu");
							var dz = $(this).attr("dz");
							if(fgq !=''&& tp!=undefined){
								$('#rount_1').val(RountD[0][1]+":"+fgq);//路由文本域写入值
   								$('#rount_1').attr("title",RountD[0][1]+":"+fgq);//写入title
   								
   								$('#rount_2').val(RountD[1][1]+":"+tp);//路由文本域写入值
   								$('#rount_2').attr("title",RountD[1][1]+":"+tp);//写入title
   								
   								$('#rount_3').val(RountD[2][1]+":"+onu);//路由文本域写入值
   								$('#rount_3').attr("title",RountD[2][1]+":"+onu);//写入title
   								
   								$('#rount_4').val(RountD[3][1]+":"+dz);//路由文本域写入值
   								$('#rount_4').attr("title",RountD[3][1]+":"+dz);//写入title
   								$("#xqlineid").val(xqlineid);
							}											
						});						
					}
			});
 }


/**
* 打开添加号线面板
* @param  numR :添加路由条数  ；numR为空或不传参数时，默认显示五个路由信息
* @param  printType:打印类型  new：往孔面板添加路由个数  add：在原有的面板上追加个数
* @return 
*/
function printRountPan(numR,printType){
	 	var theinput="";
	 	if(printType=='new'){
	 		var len = RountD.length;
	 		RountNUM=numR;
	 		for(var i=1;i<=len;i++){
	 			var flags = "";//"disabled='disabled'";
		 		theinput += "<p style='margin-left:80px'><span class='tmpspanstyle'>" +RountD[i-1][1]+"</span>";
		 		theinput += "<input class='n_value' type='text' id='rount_" + i + "' disabled='disabled' style='width: 210px;' title='' />";
		 		theinput +="<input type='hidden' class='par_noo' id='rount_" + i + "_h' />";
		 		theinput +="<input type='hidden' id='rount_" + RountD[i-1][0] + "_no' attrval='"+i+"'/>";//设备编码	 		
		 		theinput +="<input type='hidden' class='self_noo' id='rount_" + i + "_s' />";//记入当前端子编码	 		
		 		theinput +="<input type='hidden' class='src_value' id='rount_" + i + "_y' />";//修改操作记录时记录更改前端子编码
		 		theinput +="<input type='hidden' id='rount_" + i + "_p' />";//并机前端子编码
		 		theinput +="<button style='margin-left:10px' class='btn_2k3' "+flags+" id='" + i + "b' onclick=showDeviceType('rount_" + i + "','"+RountD[i-1][2]+"','"+RountD[i-1][1]+"')>变更设备</button>"
		 		theinput +="<button class='btn_2k3' style='margin-left:20px' "+flags+" id='" + i + "c' onclick=clearTheValue('" + i + "')>清空数据</button>" ;
		 		theinput +="</p><hr/>";
	    	}
	    	$("#addRountinput").html(theinput);
	 	}else if(printType=='add'){
	 		for(var j=1;j<=numR;j++){
		 		RountNUM++;
		 		var flags =""; //"disabled='disabled'";
		 		theinput += "<p style='margin-left:80px'><span class='tmpspanstyle'>路由" +RountNUM+"</span>";
		 		theinput += "<input class='n_value' type='text' id='rount_" + RountNUM + "' disabled='disabled' style='width: 210px;'/>";
		 		theinput +="<input type='hidden' class='par_noo' id='rount_" + RountNUM + "_h' />";
		 		theinput +="<input type='hidden' class='self_noo' id='rount_" + RountNUM + "_s' />";//记入当前端子编码
		 		theinput +="<input type='hidden' class='src_value' id='rount_" + RountNUM + "_y' />";//修改操作记录时记录更改前端子编码
		 		theinput +="<input type='hidden' id='rount_" + RountNUM + "_p' />";//并机前端子编码
		 		theinput +="<button style='margin-left:10px' class='btn_2k3' "+flags+" id='" + RountNUM + "b' onclick=showDeviceType('rount_" + RountNUM + "')>变更设备</button>"
		 		theinput +="<button class='btn_2k3' style='margin-left:20px' "+flags+" id='" + RountNUM + "c' onclick=clearTheValue('rount_" + RountNUM + "')>清空数据</button>" ;
		 		theinput +="</p><hr/>";
		 		$("#addRountinput").append(theinput);
	 		}
	 	}
 } 
 
 
 /**
* 清空元素value值
* @param str：元素id
* @return 
*/
function clearTheValue(str)
{
    $('#rount_' + str).val('');
    $('#rount_' + str+'_s').val('');
}

 
 /**
 * 打开修改路由面板
 * @param lineid： lineid
 * @param typeid： 类型：1：电话 2：宽带
 * @return 
 */
function openRowModify(lineid,info,userid){
		//设置按钮的隐藏显示
		$('#modifyRount').show();
		$('#saveRount').hide();
		$("#ParallelRount").hide();
		clearText('addRountforms',3);
		queryByID(lineid,userid,'modify');
		
 		autoBlockForm('addRountform', 5, 'addRountclose', "#ffffff", false);
}
/**
* 打开添加号线面板
* @param 
* @return 
*/
 function openaddRount(){
 		var selectedIds = $("#editgrid").getGridParam("selrow");
 		if(selectedIds==null){
 			alert("请选择要添加路由的电话号码！");
 			return;
 		}
 		//设置按钮的隐藏显示
 		$('#modifyRount').hide();
		$('#saveRount').show();
		$("#ParallelRount").hide();
		//将头部路由类型设为相应的选中状态
		//$("input[id^='User_']") 
		$('input[id^="rount_"]:text').each(function() {
		 	$(this).attr("title","");
	    });
		//往修改面板中添加
 		//printRountPan(4,'new');
 		clearText('addRountforms',3);
 		autoBlockForm('addRountform', 5, 'addRountclose', "#ffffff", false);
 }



/**
* 新增参数拼接
* @param type 操作类型 : add:新增操作  
* @return
*/
function savebuildParams(){
	 	//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
		
		
	    var params ='';
		var thevalue = '';
		var thesql = '';
   		var theloginfo = '';
	   	var RountNUMis=1;
	   	
	   	var xqlineid = $("#xqlineid").val();
	   	var xqlineid_old = $("#xqlineid_old").val();
		var dh= $("#Dh_shareSel").val();
		var DhType = $("#DhType_shareSel").val();
	    if(xqlineid==''){
	    	alert("请选择号线信息");
	    	return false;
	    }
	   	
	   	
	    //没有更改任何内容不需要保存修改
	    if(xqlineid==xqlineid_old){
	    	alert("该路由和原来路由一直，不需要进行修改。");
	    	return false;	    	
	    }
	    //写入日志字符串拼接
	    if(xqlineid_old==''){
	    	theloginfo = '号线id：'+xqlineid; 
	    }else{
	    	theloginfo ='旧号线id：'+xqlineid_old+'-->新号线id：'+xqlineid
	    }	    
	  	
	    
		params = '&userid=' + dh + '&dhtype=' + DhType+'&lineid='+xqlineid;
 		$("#theloginfo").val(theloginfo);//存放日志信息
		//每次拼接参数必须添加此判断
		if(tsd.Qualified()==false){return false;}
		return params;
}

/**
* 修改参数拼接
* @param
* @return
*/
function modifybuildParams(){
	 	//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
		
	    var params ='';
		var thevalue = '';
		var thesql = '';
   		var theloginfo = '';
	   	var RountNUMis=1;
	   	var Rounttype = $("#Rounttype_hide").val();//路由类型 1:电话 2：号线	
	    var thisDh = $('#dh_rount').val();
	   	var lineid = $("#lineid").val();
	   	
	   	var j=0;//存放变更个数
	    //设置插入路由的sql语句 片段
	    for(var i = 1 ;i<=RountNUM;i++){     	
	      	var nodestr = $("#rount_"+i).val();
	      	var nodeNoNew = $("#rount_"+i+"_s").val();
	      	var nodeNoOld = $("#rount_"+i+"_y").val();
	      	if(nodeNoNew!=nodeNoOld){
	      		j++;
	      	}
	      	RountNUMis++;
	      	thesql += "value"+RountNUMis + "= '" + tsd.encodeURIComponent(nodeNoNew) + "',";
	      	if(nodestr!=''){	      		
	      		theloginfo += tsd.encodeURIComponent(nodestr) + "-->";
	      	}
	    }

	    //没有更改任何内容不需要保存修改
	    if(j==0){
	    	alert("您没有对号线内容进行变更。");
	    	return false;	    	
	    }
	    
	    //号线路由信息描述
	    var num = theloginfo.lastIndexOf('-->');
	    theloginfo = theloginfo.substring(0, num); 
	    	   
	    //路由类型 1：电话 2：宽带
	    thesql +="VALUE29 = '"+ Rounttype + "',";
	    thesql += "VALUE30 = '"+ theloginfo + "',";
	    //存储路由电话
	    thesql += "Dh = '"+ thisDh + "' ";           
	   			
	 	
 		$("#theloginfo").val(theloginfo);//存放日志信息
		params = '&str=' + thesql +'&lineid='+lineid;
		//每次拼接参数必须添加此判断
		if(tsd.Qualified()==false){return false;}
		return params;
}


/**
* 该条号线对应该类型用户已满员
* 即只能允许有2个电话 2个宽带挂载在改号线上。
* @param type 操作类型 : add:新增操作   modify ：修改操作  Parallel:并机操作
* @return
*/
function saveRouteInfo(type)
{	
	
	var xqlineid = $("#xqlineid").val();	
	var DhType = $("#DhType_shareSel").val();
	var dh= $("#Dh_shareSel").val();
	
	//该条号线挂载的相应类型账号已满
	var isfullI = isFullNums(xqlineid,DhType);
	if(isfullI=='true'){		
		alert("该条号线能挂载两个"+getDhName(DhType)+"，请您重新选择号线");
		return false;
	}
	
	
    var thepk = '';
    var theparam = '';
    //拼接惨数
    theparam = savebuildParams();
    if(theparam==false){return false;}
	if(type=='add'||type=='Parallel'){
		//如果在号线表中不存在当前电话记录，执行添加语句
	    thepk = 'XQLineManager.saveShare'; 
	     
	}else if(type=='modify'){
		//如果在号线表中不存在当前电话记录，执行添加语句
	    thepk = 'XQLineManager.updateRouteInfo';
	}  
    
    
    ///设置命令参数
    var urlstr = tsd.buildParams(
    {
	        packgname : 'service', //java包
	        clsname : 'ExecuteSql', //类名
	        method : 'exeSqlData', //方法名
	        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
	        tsdcf : 'mssql', //指向配置文件名称
	        tsdoper : 'exe', //操作类型 
	        tsdpk : thepk//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax({
        url : 'mainServlet.html?' + urlstr + theparam , 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, 
        async : false , //同步方式
        success : function (msg)
        {
            if (msg == "true")
            {
                var operationtips = $("#operationtips").val();
                var successful = $("#successful").val();
                alert(successful, operationtips);
                
                //更新电话路由jqgrid
                var column = $('#ziduansF_info').val();
                reloadRouteData('XQLineManager.querylineinfo', 'XQLineManager.querylineinfopage', 
                'editgrid_info', dh, column,'2') ;
                
                /*************
                 ** 释放资源 **
                 ************/                
                setTimeout($.unblockUI, 15);
                
                ///////////////////////////////////////////////////////////
			    //根据操作类型 写入日志字符串设置
			    var opertypelog ='' ;
			    if(type =='add'){
			    	opertypelog='号线添加';
			    }else if(type =='modify'){
			    	opertypelog='号线修改';
			    	$("#xqlineid_old").val("");
			    }else if(type == 'Parallel'){
			    	opertypelog='并机用户';
			    }
						    
			    var thisDh ='用户'+dh;						    
			    var theloginfo = $("#theloginfo").val();//存放日志信息
			    writeLineInfo('', tsd.encodeURIComponent('小区号线'), tsd.encodeURIComponent(opertypelog+' [' + thisDh + ']的小区号线资料信息：') + tsd.encodeURIComponent(theloginfo));
			    queryOtherinfo(xqlineid);//根据选中号线id 展示共享该号线的所有电话信息
			    changeMenu('broadband') ;//跳转到生成调度页面
				       
            }
        }
    });
}


//设置路由类型选中状态
function checkradioval(value){
	$("#Rounttype_hide").val(value);
}


 ////////////////////////////////////////////////电话jqgrid////////////////////////////////////////////////////////
/**
* 显示电话jqgrid
* @param
* @return
*/
function showTelJQgrid(){
	 var col=[[],[]];
	 col=getRb_Field('vw_air_xqline','xqlineid','修改|删除|共享','97','ziduansF_info','userid');//得到jqGrid要显示的字段	
	 
	   jQuery("#editgrid_info").jqGrid({
	        //datatype : 'xml', 
	        colNames : col[0], 
	        colModel : col[1], 
	        //rowNum : 1, //默认分页行数
	        //rowList : [1, 10, 20], //可选分页行数
	        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images/', 
	        pager : jQuery('#pagered_info'), 
	        sortname : 'xqlineid', 
	        //默认排序字段
	        viewrecords : true, 
	        sortorder : 'desc', //默认排序方式 
	        caption : '用户电话号线资料详细信息',
	        height : 55, //高 
	        width : document.documentElement.clientWidth - 63,
	        //width : 1600,
	        loadComplete : function ()
	        {
	            
				if ($("#editgrid_info tr.jqgrow[id='1']").html() == "") {
	                return false;
	            }
				addRowOperBtnimage('editgrid_info','openRowModify','xqlineid','click',1,"style/images/public/ltubiao_01.gif",'修改',"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'info','userid');//修改
				addRowOperBtnimage('editgrid_info','deleteRow','xqlineid','click',2,"style/images/public/ltubiao_02.gif",'删除',"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'info','userid');//删除
				addRowOperBtnimage('editgrid_info','openParallelOper','xqlineid','click',3,'style/images/public/ltubiao_03.gif',"共享","&nbsp;&nbsp;&nbsp;",'info','userid');//详细
				executeAddBtn('editgrid_info',3);
				
				var lineid = getGridSelRowData('editgrid_info',1,1);
				queryOtherinfo(lineid);//根据选中号线id 展示共享该号线的所有电话信息				
	        },
	        ondblClickRow : function (ids) 
	        {
	        	if(ids!=null){
	        		var lineid = $("#editgrid_info").getCell(ids, "xqlineid");
	        		queryOtherinfo(lineid);//根据选中号线id 展示共享该号线的所有电话信息
	        	}
	        }
	    });
 }
 /**
 * 获取指定jqgrid 指定行指定列的值
 * @param 
 * @return 
 */
 function getGridSelRowData(gridid,rowid,cellid){
			var rowData ='';
			if($.browser.mozilla)
			{
				rowData = document.getElementById(gridid).rows[rowid].cells[cellid].textContent;
			}
			if($.browser.msie)
			{
				rowData = document.getElementById(gridid).rows[rowid].cells[cellid].innerText;
			}						
			return rowData;						
}
 /**
 * 根据选中号线id 展示共享该号线的所有电话信息
 * @param 
 * @return 
 */
 function queryOtherinfo(lineid){
		 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
		 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:'XQLineManager.queryOther',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										  tsdpkpagesql:'XQLineManager.queryOtherpage'
										});
			var link = urlstr1 + '&lineid='+lineid;
		 	$("#editgrid_other").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
				 	
 }
 /**
 * 重载指定用户路由信息
 * @param 
 * @return 
 */
function reloadRouteData(tsdpk, tsdpksql, gridid, Dh, column,rounttype)
{
	    var urlstr = tsd.buildParams(
	    {
	        packgname : 'service', //java包
	        clsname : 'ExecuteSql', //类名
	        method : 'exeSqlData', //方法名
	        datatype : 'xml', //返回数据格式
	        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
	        tsdcf : 'mssql', //指向配置文件名称
	        tsdoper : 'query', //操作类型
	        tsdpk : tsdpk, //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
	        tsdpkpagesql : tsdpksql//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
	    });
	    $("#" + gridid).setGridParam({
	        url : 'mainServlet.html?' + urlstr + '&Dh=' + Dh + '&rounttype=' + rounttype + '&cloumn=' + column
	    }).trigger("reloadGrid");
	    //setTimeout($.unblockUI, 15);
	    //关闭面板
}

 /**
 * 删除路由信息
 * @param lineid： lineid
 * @param typeid： 类型：1：电话 2：宽带
 * @param info 号线详细信息
 * @return 
 */
function deleteRow(lineid,info,userid){
		//alert(typeid);
		//是否有执行删除的权限
		/**
		var deleteright = $("#deleteright").val();
		if(deleteright=="true"){	
		*/		
			 	var deleteinformation = $("#deleteinformation").val();
				var operationtips = $("#operationtips").val();
			 	jConfirm(deleteinformation,operationtips,function(x){
			 		 if(x==true){			 		 
				 		 	//从air_line查询出本条记录的详细信息，用于写入日志和更新端子使用状态
				 		 	//clearText('addRountforms',3);
				 		 	//queryByID(lineid,userid,'delete'); 		 	
				 		 	
				 		 	var urlstr=tsd.buildParams({  packgname:'service',//java包
														  clsname:'ExecuteSql',//类名
														  method:'exeSqlData',//方法名
														  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
														  tsdcf:'mssql',//指向配置文件名称
														  tsdoper:'exe',//操作类型 
														  datatype:'xml',//返回数据格式 
														  tsdpk:'XQLineManager.deleteRow'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
														});
							var urlstr='mainServlet.html?'+urlstr+'&lineid='+lineid+'&userid='+userid; 
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
																						
											////////////////////////写入日志																					
											$("#editgrid_info").trigger("reloadGrid");
											queryOtherinfo(0);//根据选中号线id 展示共享该号线的所有电话信息
											//$("#editgrid_other").trigger("reloadGrid");
											//写入日志操作
											writeLineInfo('',tsd.encodeURIComponent('小区号线'), tsd.encodeURIComponent('删除用户[' + userid + ']的号线资料信息：号线id：') + lineid );
											changeMenu('broadband') ;//跳转到生成调度页面
									}	
								}
							});	
					
					}			 	
				});
				/**	
		}
		else{					
			var operationtips = $("#operationtips").val();
			var deletepower = $("#deletepower").val();
			jAlert(deletepower,operationtips);
		}
		*/
}

/**
 * 从air_line，取出一条数据显示在addform面板
 * @param lineid xqlineid
 * @param userid userid
 * @param type  操作类型：delete：删除操作  modify：修改操作  Parallel:并机操作
 删除操作不需要把记录写入面板
 修改操作需要把记录写入面板
 * @return 
 */
function queryByID(lineid,userid,type){ 
		$("#xqlineid_old").val(lineid);
		getAssociate(lineid);		
}

///////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/**
 * 根据电话或宽带账号进行信息查询--<模块局加以限定>
 * @param 
 * @return 
 */
function queryTheInfo()
{
    var theinput = $('#thisinputvalue').val();
    if (theinput != '' && theinput != null)
    {
        var column = $('#thiscolumn').val();
        var thismkj = $('#thismkj').val();
        //alert("column="+column+";"+"Dh="+theinput+";"+"str="+thismkj);
        reloadQueryData('XQLineManager.querytheinfo', 'XQLineManager.querytheinfopage', 'editgrid', 
        theinput, thismkj, column);
    }
    else
    {
        var operationtips = $("#operationtips").val();
        var pleaseinput = $("#pleaseinput").val();
        alert(pleaseinput+'!', operationtips);
        $('#thisinputvalue').focus();
        return false;
    }
    $("#Dh").val("");
}

/**
 * 重载查询设备的信息
 * @param tsdpk：执行的主Sql语句的配置名
 * @param tsdpksql：依赖tsdpk 用于计算分页的sql配置名称
 * @param gridid：jqgrid名称
 * @param Dh：电话
 * @param str：参数字符串
 * @param column：sql语句查询字段
 * @return 
 */
function reloadQueryData(tsdpk, tsdpksql, gridid, Dh, str, column)
{
	
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        datatype : 'xml', //返回数据格式 
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        tsdpk : tsdpk, //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        tsdpkpagesql : tsdpksql//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    $("#" + gridid).setGridParam({
        url : 'mainServlet.html?' + urlstr + '&Dh=' + Dh + '&str=' + tsd.encodeURIComponent(str) + '&cloumn=' + column
    }).trigger("reloadGrid");
    setTimeout($.unblockUI, 15);
    //关闭面板
}

//////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
/**
 * 打开共享路由信息面板
 * @param lineid： lineid
 * @param typeid： 类型：1：电话 2：宽带
 * @return 
 */
function openParallelOper(lineid,typeid,dh,Value30){
		//queryByID(lineid,'Parallel');	
		$('#line_shareSel').val(lineid);//存放次吃lineid值
		$('#Dh_shareOld').val(dh);//存放次吃lineid值
		$('#lineinfo_sharSel').val(Value30);
		var MoKuaiJu = $('#limitroute').val();//该号线所属账号的模块局
		var whereinfo = '1=1';
		getShareJqgrid(MoKuaiJu,whereinfo);
 		autoBlockForm('shareRountform', 5, 'shareRountclose', "#ffffff", false);
}
 /**
 * 显示可共享该号线的账号信息
 * @param MoKuaiJu： 该号线所属账号的模块局
 * @param
 * @return 
 */
 function getShareJqgrid(MoKuaiJu,whereinfo){
			var params = '&fusearchsql='+encodeURIComponent(whereinfo);				
					
		 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
		 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk : 'XQLineManager.querySel', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
      									  tsdpkpagesql : 'XQLineManager.querySelpage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
										});
			var link = urlstr1 + params;	
			var languageType = $("#languageType").val();
		 	$("#editgrid_share").setGridParam({url:'mainServlet.html?'+link+'&str='+tsd.encodeURIComponent(MoKuaiJu)}).trigger("reloadGrid");
    
 }
  /**
 * 根据电话或账号进行模糊查询共享电话
 * @param
 * @return 
 */
 function querySelInfo(){
 	var dh_Sel = $("#dh_Sel").val();
 	var MoKuaiJu = $('#limitroute').val();
 	var whereinfo = "dh like '%"+dh_Sel+"%'";
 	getShareJqgrid(MoKuaiJu,whereinfo);
 }
 /**
 * 打印共享号线面板中的jqgrid
 * @param
 * @return 
 */
 function showShareJqgrid(){
 	
    var languageType = $('#languageType').val(); 	
 	var thefieldalias = fetchFieldAlias('air_users',languageType);
    var Dh = thefieldalias['DH'];
    var Jhj = thefieldalias['USERNAME'];
    var UserBM = thefieldalias['USERBM'];
    var userAddr = thefieldalias['USERADDR'];
    var Regdate = thefieldalias['REGDATE'];
    var linkMan = thefieldalias['LINKMAN'];
    var linkDh = thefieldalias['LINKDH'];
    var MoKuaiJu = thefieldalias['MOKUAIJU'];
    var DhType = thefieldalias['DHTYPE'];  
    
 	 jQuery("#editgrid_share").jqGrid({
       // url : 'mainServlet.html?' + urlstr + '&str=' + tsd.encodeURIComponent(MoKuaiJu) +'&fusearchsql=1=1', 
        datatype : 'xml', 
        colNames : [Dh, Jhj, UserBM, userAddr, Regdate, MoKuaiJu,DhType], 
        colModel : [ 
        //{
        //    name : 'viewOperation', index : 'viewOperation', width : 100
        //},
        //如果有操作列 请勿更改或者删除
        {
            name : 'Dh', index : 'Dh', width : 160
        },
        {
            name : 'UserName', index : 'UserName', width : 110
        },
        {
            name : 'UserBM', index : 'UserBM', width : 185,hidden:true
        },
        {
            name : 'userAddr', index : 'userAddr', width : 270
        },
        {
            name : 'Regdate', index : 'Regdate', width : 195,hidden:true
        },
        {
            name : 'MoKuaiJu', index : 'MoKuaiJu', width : 160
        },
        {
            name : 'DhType', index : 'DhType', width : 70
        } ], 
        rowNum : 10, //默认分页行数
        rowList : [10, 15, 20], //可选分页行数
        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images/',
        pager : jQuery('#pagered_share'), 
        sortname : 'Regdate', 
        //默认排序字段
        viewrecords : true, //hidegrid: false, 
        sortorder : 'desc', //默认排序方式 
        caption : '共享号线电话选择', 
        height : 200, //高
        //width : document.documentElement.clientWidth - 63,
        loadComplete : function ()
        {
            //$("#editgrid_share").setSelection('0');
            //$("#editgrid_share").focus();
        },
        onSelectRow: function (ids){
        	if (ids != null) 
            {
                var Dh = $("#editgrid_share").getCell(ids, "Dh"); 
                var DhType = $("#editgrid_share").getCell(ids, "DhType"); 
                $("#Dh_shareSel").val(Dh); 
                $("#DhType_shareSel").val(DhType); 
               // $('#limitroute').val(MoKuaiJu); 
           }
        },
        ondblClickRow : function (ids) 
        {
        	
        }
    }).navGrid('#pagered_share', {
        edit : false, add : false, add : false, del : false, search : false
    },
    //options 
    {
        height : 100, reloadAfterSubmit : true, closeAfterEdit : true
    },
    // edit options 
    {
        height : 100, reloadAfterSubmit : true, closeAfterAdd : true
    },
    // add options 
    {
        reloadAfterSubmit : false
    },
    // del options 
    {} // search options 
    );
    
    
    ///////////////////////////////////////////////////////////
    //共享一个号线的其它电话jqgrid显示
    jQuery("#editgrid_other").jqGrid({
	    datatype : 'xml', 
        colNames : [Dh, Jhj, UserBM, userAddr,'部门职称', Regdate, MoKuaiJu,DhType], 
        colModel : [ 
        //{
        //    name : 'viewOperation', index : 'viewOperation', width : 100
        //},
        //如果有操作列 请勿更改或者删除
        {
            name : 'Dh', index : 'Dh', width : 150
        },
        {
            name : 'UserName', index : 'UserName', width : 150
        },
        {
            name : 'UserBM', index : 'UserBM', width : 185
        },
        {
            name : 'userAddr', index : 'userAddr', width : 300
        },
        {
            name : 'bmzc', index : 'bmzc', width : 100
        },
        {
            name : 'Regdate', index : 'Regdate', width : 195
        },
        {
            name : 'MoKuaiJu', index : 'MoKuaiJu'
        },
        {
            name : 'DhType', index : 'DhType'
        } ],
        rowNum : 10, //默认分页行数
        rowList : [10, 15, 20], //可选分页行数
        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images/',
        pager : jQuery('#pagered_other'), 
        sortname : 'Regdate', 
        //默认排序字段
        viewrecords : true, //hidegrid: false, 
        sortorder : 'desc', //默认排序方式 
        caption : '共享该号线电话', 
        height : 150, //高
        width : document.documentElement.clientWidth - 63,
        loadComplete : function ()
        {
            //$("#editgrid_share").setSelection('0');
            //$("#editgrid_share").focus();
        }}).navGrid('#pagered_other', {
	        edit : false, add : false, add : false, del : false, search : false
	    },
	    //options 
	    {
	        height : 100, reloadAfterSubmit : true, closeAfterEdit : true
	    },
	    // edit options 
	    {
	        height : 100, reloadAfterSubmit : true, closeAfterAdd : true
	    },
	    // add options 
	    {
	        reloadAfterSubmit : false
	    },
	    // del options 
	    {} // search options 
	    );
 }
  /**
 * 共享号线给选中账号
 * @param
 * @return 
 */
 function saveShare(){ 	
	
		var dh = $("#Dh_shareSel").val();
	 	var DhType = $("#DhType_shareSel").val();
	 	var lineid = $("#line_shareSel").val();
	 	var Dh_shareOld = $("#Dh_shareOld").val();
		//该条号线挂载的相应类型账号已满
		var isfullI = isFullNums(lineid,DhType);
		if(isfullI=='true'){		
			alert("该条号线能挂载两个"+getDhName(DhType)+"，请您重新选择号线");
			return false;
		}	
	 	
	 	if(dh ==''){
	 		alert("请选择要共享该号线的电话。");
	 		return;
	 	}	 	
	 	
	 	var params = '';
	 	params += '&userid=' + dh;
	 	params += '&dhtype=' + DhType;
	 	params += '&lineid=' + lineid;
	 	var info = "您确定要进行号线共享吗?";
		var operationtips = $("#operationtips").val();
	 	jConfirm(info,operationtips,function(x){
	 		 if(x==true){
	 		 		
	 		 		///设置命令参数
				    var urlstr = tsd.buildParams({
					        packgname : 'service', //java包
					        clsname : 'ExecuteSql', //类名
					        method : 'exeSqlData', //方法名
					        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
					        tsdcf : 'mssql', //指向配置文件名称
					        tsdoper : 'exe', //操作类型 
					        tsdpk : 'XQLineManager.saveShare'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
				    });
				    $.ajax({
				        url : 'mainServlet.html?' + urlstr + params, 
				        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
				        timeout : 1000, 
				        async : false , //同步方式
				        success : function (msg)
				        {
				            if (msg == "true")
				            {
				                var operationtips = $("#operationtips").val();
				                var successful = $("#successful").val();
				                alert(successful, operationtips);
				                
				                /*************
				                 ** 释放资源 **
				                 ************/                
				                setTimeout($.unblockUI, 15);
				               
				                ///////////////////////////////////////////////////////////
							    //根据操作类型 写入日志字符串设置
							    var opertypelog ='号线共享' ;
							    var thisDh ='用户'+Dh_shareSel+'共享用户'+Dh_shareOld;
							    
							    var lineinfo = $("#lineinfo_sharSel").val();//存放日志信息
							    writeLineInfo('', tsd.encodeURIComponent('小区号线'), tsd.encodeURIComponent(opertypelog+' [' + thisDh + ']的小区号线资料信息：') + lineinfo);
							    $("#editgrid_other").trigger("reloadGrid");
							      
				            }
				        }
				    });
	 		 }
		});
 	
 }
 
/**
* 新增、修改的路由信息
* @param type 操作类型 : add:新增操作   modify ：修改操作  Parallel:并机操作
* @return true ：已满员 false ：未满员
*/
function isFullNums(xqlineid,DhType){
			var result ='';
			var urlstr=tsd.buildParams({ 	
		 		 						packgname:'service',//java包
					 					clsname:'ExecuteSql',//类名
					 					method:'exeSqlData',//方法名
					 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
					 					tsdcf:'mssql',//指向配置文件名称
					 					tsdoper:'query',//操作类型 
					 					datatype:'xmlattr',//返回数据格式 
					 					tsdpk:'XQLineManager.getlineNums'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
					 				});
			var params = "&dhtype="+DhType+"&lineid="+xqlineid;
			$.ajax({
				url:'mainServlet.html?'+urlstr+params,
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
						$(xml).find('row').each(function(){
                  				var nums=$(this).attr("nums");
                  				
                  				if (nums>=2){
                  					result = 'true';
                  				}else if(nums<2){
                  					result = 'false';
                  				}       				
						 });
				}
			});
			return result;
}


/**
* 根据电话类型返回中文名称
* @param DhType phone ： 电话  broadband：宽带
* @return 字符串：电话 宽带
*/
function getDhName(DhType){
		var dhname='';
		if(DhType=='phone'){
			dhname='电话';
		}else if(DhType=='broadband'){
			dhname='宽带';
		}
		return dhname;
}
