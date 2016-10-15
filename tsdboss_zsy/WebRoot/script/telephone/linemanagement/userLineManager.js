﻿﻿/*****************************************************************
 * name: script/telephone/linemanagement/userLineManager.js
 * author: 尤红玉
 * version: 1.0, 2011-6-8
 * description: 用户号线设备管理
 * modify: 
 		2011-6-17 youhongyu 1)进行修改操作未账号模块局信息传到设备选择面板上，导致设备显示不出来，问题修改
							2)添加路由时，允许有空行，对出现空行情况进行处理。
		2011-6-28 youhongyu 更新端子使用状态的时候同步更新占用端子电话或账号
		2011-8-26 youhongyu 鼠标放到路由节点上，浮动显示节点信息。
 *		
 *****************************************************************/
//用于生产面板路由设置
RountNUM=5;
ZWRountNUM=3;
RountD = new Array();
RountD[0]=new Array();
RountD[0].push('005');
RountD[0].push('内配线序');
RountD[1]=new Array();
RountD[1].push('001');
RountD[1].push('外配线序');
RountD[2]=new Array();
RountD[2].push('002');
RountD[2].push('配线箱');
RountD[3]=new Array();
RountD[3].push('003');
RountD[3].push('层箱');
RountD[4]=new Array();
RountD[4].push('004');
RountD[4].push('分线箱');
 
 /**
* 打开二级设备管理窗口
* @param NodeField：设备别名
* @return 
*/
function showDeviceType(NodeField,deviceno)
{
 	var Rounttype=$("#Rounttype_hide").val();
    if(Rounttype==''){
    	alert("请先选择路由类型！");
    	return false;
    }
    var mkj = $('#limitroute').val();
    window.showModalDialog('mainServlet.html?pagename=telephone/linemanagement/selDeviceType.jsp&NodeField=' + NodeField + '&mkj=' + tsd.encodeURIComponent(mkj)+'&deviceno='+deviceno, 
    window, "dialogWidth:710px; dialogHeight:420px; center:yes; scroll:no");
}

/**
 * 回调函数，用于设置设备时自动设置相同段中的其它设备
 * @param thei 字段名
 * @param typename 设备类型
 * @param nodename  端子名称
 * @param pdvno 三级设备编号 
 * @param DeviceNo 四级设备编号 即端子编号
 * @return 
 */
function getTheVlaueR(thei,typename, nodename, pdvno,DeviceNo)
{   
   var params ='';
   var devicetypeNO = DeviceNo.substring(0,3);  
   if(devicetypeNO=='001'){//根据外配线序关联层箱
   		params ='&cx=&wpxx='+DeviceNo;   		
   }else if(devicetypeNO=='003'){//根据层箱关联外配线序
   		params ='&wpxx=&cx='+DeviceNo;   		
   }
   getAssociate(params,DeviceNo); //获取关联端口信息
   $('#' + thei).val(typename+":"+nodename);//路由文本域写入值
   $('#' + thei).attr("title",typename+":"+nodename);//写入title
   $('#' + thei + "_h").val(pdvno);//写入三级设备编号
   $('#' + thei + "_s").val(DeviceNo);//写入四级端子编号	    
     
}


/**
 * 获取关联端口信息
 * @param params ：查询条件
 * @param DeviceNo_self :四级设备编号 即端子编号
 * @return 无返回值
 */
 function getAssociate(params,DeviceNo_self){
			var urlstr=tsd.buildParams({ 
							packgname : 'service', //java包
					        clsname : 'ExecuteSql', //类名
					        method : 'exeSqlData', //方法名
					        ds : 'tsdBilling', //数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
					        tsdcf : 'mssql', //指向配置文件名称
					        tsdoper : 'query', //操作类型 
					        datatype : 'xmlattr', //返回数据格式 
					        tsdpk :'userLineManager.getAssociate' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
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
							deviceno = $(this).attr("deviceno");
							devicename = $(this).attr("devicename");
							nodename = $(this).attr("nodename");
							if(deviceno !=''&& deviceno!=null && deviceno!='undefined'&& deviceno!=DeviceNo_self){
								devicetypeId(deviceno,devicename,nodename);	//设置路由面板的节点信息	
							}											
						});						
					}
			});
 }
/**
 * 设置路由面板的节点信息
 * @param 端口编码
 * @param 设备类型
 * @param 端口名称
 * @return 无返回值
 */
 function devicetypeId(deviceno,devicename,nodename){
 			//alert("getAssociate--------deviceno:"+deviceno+"----------devicename:"+devicename+"----nodename:"+nodename);		
		 	var devicetypeId = deviceno.substring(0,3);
		 	var thei ='';
		 	//取得存放设备信息的元素id
		 	if(devicetypeId=='001'){
		 		thei = 'rount_2';
		 	}else if(devicetypeId=='003'){
		 		thei = 'rount_4';
		 	}
		 	$('#' + thei).val(devicename+":"+nodename);//路由文本域写入值
			$('#' + thei).attr("title",devicename+":"+nodename);//写入title
			$('#' + thei + "_h").val(deviceno.substring(0,13));//写入三级设备编号
			$('#' + thei + "_s").val(deviceno);//写入四级端子编号
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
	 		theinput += "<input class='n_value' type='text' id='rount_" + i + "' style='width: 210px;' title='' />";
	 		theinput +="<input type='hidden' class='par_noo' id='rount_" + i + "_h' />";
	 		theinput +="<input type='hidden' id='rount_" + RountD[i-1][0] + "_no' attrval='"+i+"'/>";//设备编码	 		
	 		theinput +="<input type='hidden' class='self_noo' id='rount_" + i + "_s' />";//记入当前端子编码	 		
	 		theinput +="<input type='hidden' class='src_value' id='rount_" + i + "_y' />";//修改操作记录时记录更改前端子编码
	 		theinput +="<input type='hidden' id='rount_" + i + "_p' />";//并机前端子编码
	 		theinput +="<button style='margin-left:10px' class='btn_2k3' "+flags+" id='" + i + "b' onclick=showDeviceType('rount_" + i + "','"+RountD[i-1][0]+"')>变更设备</button>"
	 		theinput +="<button class='btn_2k3' style='margin-left:20px' "+flags+" id='" + i + "c' onclick=clearTheValue('rount_" + i + "')>清空数据</button>" ;
	 		theinput +="</p><hr/>";
    	}
    	$("#addRountinput").html(theinput);
 	}else if(printType=='add'){
 		for(var j=1;j<=numR;j++){
	 		RountNUM++;
	 		var flags =""; //"disabled='disabled'";
	 		theinput += "<p style='margin-left:80px'><span class='tmpspanstyle'>路由" +RountNUM+"</span>";
	 		theinput += "<input class='n_value' type='text' id='rount_" + RountNUM + "' style='width: 210px;'/>";
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
var nodedata;
var valarr = new Array();
function clearTheValue(str)
{
    $('#' + str).val('');
    $('#' + str+'_s').val('');

       var tmp = $('#' + str+'_y').val(); 
	
	if (tmp != '')
	{
	  valarr.push("'"+tmp+"'"); 
	}
    nodedata=valarr.join(",");
alert(nodedata);
}

 /**
 * 打开并机路由信息面板
 * @param lineid： lineid
 * @param typeid： 类型：1：电话 2：宽带
 * @param linetype： 类型：0：普通	 1：专网
 * @param mokuaiju 模块局
 * @param dh 电话
 * @param line_userid air_users的id
 * @return 
 */
function openParallelOper(lineid,typeid,linetype,mokuaiju,dh,line_userid){
		//	号线模块局权限判断
		var thismkj = $('#thismkj').val();
		var mkj =  ","+thismkj.replace(new RegExp("'","g"),"")+",";			
		var mkjtemp = ","+mokuaiju + ","; 
	  	if(mkj.indexOf(mkjtemp)!=-1){
	  		getBJRight(line_userid,dh,mokuaiju);	  		  		
	  	}else{
	  		alert("您没有修改该模块局号线管理权限！");
	  		return;
	  	}
	  	$("#BJ_lineid").val(lineid);
	  	$("#BJ_typeid").val(typeid);
	  	
}
  /**
 * 打开非跨模块局并机路由信息面板
 * @param lineid： lineid
 * @param typeid： 类型：1：电话 2：宽带
 * @param linetype： 类型：0：普通	 1：专网
 * @param mokuaiju 模块局
 * @param dh 电话
 * @param line_userid air_users的id
 * @return 
 */
 function OpenBJPan(lineid,typeid){
 		//设置按钮的隐藏显示
		$('#modifyRount').hide();
		$('#saveRount').hide();
		$("#ParallelRount").show();
		$("#changeToZW").hide();
		clearText('addRountforms',3);
		queryByID(lineid,'Parallel');
		//将头部路由类型设为相应的选中状态
		$('[name="Rounttype"]:radio').each(function() {
		       if (this.value == typeid)
		       {
		         this.checked = true;
		       } 
	    });
		$("#Rounttype_hide").val(typeid);
 		autoBlockForm('addRountform', 5, 'addRountclose', "#ffffff", false);
 }
 /**
 * 打开修改路由面板
 * @param lineid： lineid
 * @param typeid： 类型：1：电话 2：宽带
 * @param linetype： 类型：0：普通	 1：专网
 * @param mokuaiju 
 * @return 
 */
function openRowModify(lineid,typeid,linetype,mokuaiju){	
		if(linetype==1){
			//	号线模块局权限判断
			var thismkj = $('#thismkj').val();
			var mkj =  ","+thismkj.replace(new RegExp("'","g"),"")+",";			
			var mkjtemp = ","+mokuaiju + ","; 
		  	if(mkj.indexOf(mkjtemp)!=-1){
		  		ZWopenModifyPan(lineid,typeid);
		  	}else{
		  		alert("您没有修改该模块局号线管理权限！");
		  		return;
		  	}			
		}else{
			openModifyPan(lineid,typeid);
		}
}

 /**
 * 打开普通号线修改路由面板
 * @param lineid： lineid
 * @param typeid： 类型：1：电话 2：宽带
 * @param linetype： 类型：0：普通	 1：专网
 * @return 
 */
function openModifyPan(lineid,typeid){
		//设置按钮的隐藏显示
		$('#modifyRount').show();
		$('#saveRount').hide();
		$("#ParallelRount").hide();
		$("#changeToZW").hide();
		clearText('addRountforms',3);
		queryByID(lineid,'modify');
		
		//将头部路由类型设为相应的选中状态
		$('[name="Rounttype"]:radio').each(function() {
		       if (this.value == typeid)
		       {
		         this.checked = true;
		       } 
	    });
		$("#Rounttype_hide").val(typeid);
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
 		//mkjacross:0 不跨模块局  mkjacross:1跨模块局
 		var mkjacross = $("#editgrid").getCell(selectedIds, "mkjacross"); 
 		if(mkjacross==0){
 			switchPTPan();
 		}else if(mkjacross==1){
 			var userid = $("#editgrid").getCell(selectedIds, "userid"); 
 			setZWMkjAdd(userid);//设置可用下拉框选择 	
 			switchZWPan();
 		}
 		
 		/*
 		else{
 			var Dh = $("#editgrid").getCell(selectedIds, "Dh");
            $("#dh_rount").val(Dh);
            var MoKuaiJu = $("#editgrid").getCell(selectedIds, "MoKuaiJu");
            alert(MoKuaiJu);
            $('#limitroute').val(MoKuaiJu);
            //alert(Dh);
 		}
 		*/
 		/*
 		//设置按钮的隐藏显示
 		$('#modifyRount').hide();
		$('#saveRount').show();
		$("#changeToZW").show();
		$("#ParallelRount").hide();
		//将头部路由类型设为相应的选中状态
		//$("input[id^='User_']")
		$('input[id^="rount_"]:text').each(function() {
		 	$(this).attr("title","");
	    });
		//往修改面板中添加
 		//printRountPan(5,'new');
 		clearText('addRountforms',3);
 		autoBlockForm('addRountform', 5, 'addRountclose', "#ffffff", false);
 		*/
 }



/**
* 新增参数拼接
* @param line_userid :air_users的id ；air_line和air_usersd 的关联表
* @param type 操作类型 : add:新增操作  
* @return
*/
function savebuildParams(line_userid){
	 	//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
		
		//进行合法性验证
		//选择路由类型
		var Rounttype = $("#Rounttype_hide").val();//路由类型 1:电话 2：号线
		if(Rounttype==''){
			alert("请选择路由类型");
			return false;
		}
		if($("#rount_1").val()=='' && $("#rount_2").val()=='' && $("#rount_3").val()=='' && $("#rount_4").val()=='' && $("#rount_5").val()==''){
			alert("请至少选中一个路由信息，再保存。");
			return false;
		}
		
	    var params ='';
		var thevalue = '';
		var thesql = '';
   		var theloginfo = '';
	   	var RountNUMis=1;
	   	var line_userid = line_userid;//被选中电话在air_users的id
	    var thisDh = $('#dh_rount').val();
	    var mkj = $("#limitroute").val();
	    var addRouteBz = $("#addRouteBz").val();
	    //该条配线的设备个数	  
	    var devNum = 0;
	    
	   	var j=0;//存放变更个数
	    //设置插入路由的sql语句 片段
	    for(var i = 1 ;i<=RountNUM;i++){     	
	      	var nodestr = $("#rount_"+i).val();
	      	var nodeNo = $("#rount_"+i+"_s").val();
	      	var nodeNoP = $('#rount_'+i + "_p").val();//写入并机前四级端子编号
	      	
	      	//变更个数
	      	if(nodeNo!=nodeNoP){
	      		j++;
	      	}
	      	//该条配线的设备个数
		    if(nodeNo!=''){
		      	devNum++;
		    }
	      	RountNUMis++;
	      	thesql += 'value'+RountNUMis+',';
	      	thevalue += "'" + tsd.encodeURIComponent(nodeNo) + "',";
	      	if(nodestr!=''){
	      		theloginfo += tsd.encodeURIComponent(nodestr) + "-->";
	      	}
	    }
	    /*
	    //没有更改任何内容不需要保存修改
	    if(j==0){
	    	alert("该路由和原来路由一直，不需要进行并机。");
	    	return false;	    	
	    }
	    */ 
	    
	    //路由类型 1：电话 2：宽带
	    thesql +='VALUE29,' ;   
	    thevalue += "'" + Rounttype + "',";
	    //该配线的设备个数
	    thesql +='VALUE28,' ;   
	    thevalue += "'" + devNum + "',";
	    //号线路由信息描述
	    var num = theloginfo.lastIndexOf('-->');
	    theloginfo = theloginfo.substring(0, num);        
	    thesql += 'VALUE30 , ';
	    thevalue += "'" + theloginfo + "',";
	    //存储路由电话
	    thesql += 'Dh , ';
	    thevalue += "'" + thisDh + "',";  
	    thesql += 'mokuaiju , ';
	    thevalue += "'" + tsd.encodeURIComponent(mkj) + "',";  
	    thesql += 'line_userid, ';
	    thevalue += "'" + tsd.encodeURIComponent(line_userid) + "',";
	    //备注
	    thesql += 'bz ';
	    thevalue += "'" + tsd.encodeURIComponent(addRouteBz) + "' ";	     		
	 	
		params = '&str=' + thesql + '&thevalue=' + thevalue;
 		$("#theloginfo").val(theloginfo);//存放日志信息
		//每次拼接参数必须添加此判断
		if(tsd.Qualified()==false){return false;}
		return params;
}
//2012-10-31 yhy start 号线并机问题解决 
/**
* 新增参数拼接
* @param line_userid :air_users的id ；air_line和air_usersd 的关联表
* @param type 操作类型 : add:新增操作  
* @return
*/
function parallelBuildParams(line_userid){
	 	//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
		
		//进行合法性验证
		//选择路由类型
		var Rounttype = $("#Rounttype_hide").val();//路由类型 1:电话 2：号线
		if(Rounttype==''){
			alert("请选择路由类型");
			return false;
		}
		if($("#rount_1").val()=='' && $("#rount_2").val()=='' && $("#rount_3").val()=='' && $("#rount_4").val()=='' && $("#rount_5").val()==''){
			alert("请至少选中一个路由信息，再保存。");
			return false;
		}
		
	    var params ='';
		var thevalue = '';
		var thesql = '';
   		var theloginfo = '';
	   	var RountNUMis=1;
	   	var line_userid = line_userid;//被选中电话在air_users的id
	    var thisDh = $('#dh_rount').val();
	    var mkj = $("#limitroute").val();
	    var addRouteBz = $("#addRouteBz").val();
	    var lineid = $("#BJ_EndLineid").val();
	    //该条配线的设备个数	  
	    var devNum = 0;
	   	var j=0;//存放变更个数
	    //设置插入路由的sql语句 片段
	    for(var i = 1 ;i<=RountNUM;i++){     	
	      	var nodestr = $("#rount_"+i).val();
	      	var nodeNo = $("#rount_"+i+"_s").val();
	      	var nodeNoP = $('#rount_'+i + "_p").val();//写入并机前四级端子编号
	      	
	      	//变更个数
	      	if(nodeNo!=nodeNoP){
	      		j++;
	      	}
	      	//该条配线的设备个数
	      	if(nodeNo!=''){
	      		devNum++;
	      	}
	      	RountNUMis++;
	      	thesql += "value"+RountNUMis + "= '" + tsd.encodeURIComponent(nodeNo) + "',";	      	
	     
	      	if(nodestr!=''){
	      		theloginfo += tsd.encodeURIComponent(nodestr) + "-->";
	      	}	            	
	    }
	    /*
	    //没有更改任何内容不需要保存修改
	    if(j==0){
	    	alert("该路由和原来路由一直，不需要进行并机。");
	    	return false;	    	
	    }
	    */ 
	    //号线路由信息描述
	    var num = theloginfo.lastIndexOf('-->');
	    theloginfo = theloginfo.substring(0, num); 
	    	   
	    //路由类型 1：电话 2：宽带
	    thesql +="VALUE29 = '"+ Rounttype + "',";
	    thesql +="VALUE28 = '"+ devNum + "',";
	    thesql += "VALUE30 = '"+ theloginfo + "',";
	    //存储路由电话
	    thesql += "Dh = '"+ thisDh + "' , ";      
	    thesql += "mokuaiju ='" + tsd.encodeURIComponent(mkj) + "',"; 
	    //存放备注
	   	var addRouteBz = $("#addRouteBz").val();
	   	thesql += "bz='"+ tsd.encodeURIComponent( addRouteBz ) + "' "; 
	   	
		$("#theloginfo").val(theloginfo);//存放日志信息
		params = '&str=' + thesql +'&lineid='+lineid;
		/*
	    thesql += 'mokuaiju , ';
	    thevalue += "'" + tsd.encodeURIComponent(mkj) + "',";  
	    thesql += 'line_userid, ';
	    thevalue += "'" + tsd.encodeURIComponent(line_userid) + "',";
	    params = '&str=' + thesql + '&thevalue=' + thevalue;
	    */
 		
		//每次拼接参数必须添加此判断
		if(tsd.Qualified()==false){return false;}
		return params;
}

//2012-10-31 yhy end 号线并机问题解决 
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
	   	//该条配线的设备个数	  
	    var devNum = 0;
	    
	   	var j=0;//存放变更个数
	    //设置插入路由的sql语句 片段
	    for(var i = 1 ;i<=RountNUM;i++){     	
	      	var nodestr = $("#rount_"+i).val();
	      	var nodeNoNew = $("#rount_"+i+"_s").val();
	      	var nodeNoOld = $("#rount_"+i+"_y").val();
	      	if(nodeNoNew!=nodeNoOld){
	      		j++;
	      	}
	      	//该条配线的设备个数
	      	if(nodeNoNew!=''){
	      		devNum++;
	      	}
	      	
	      	RountNUMis++;
	      	thesql += "value"+RountNUMis + "= '" + tsd.encodeURIComponent(nodeNoNew) + "',";
	      	if(nodestr!=''){	      		
	      		theloginfo += tsd.encodeURIComponent(nodestr) + "-->";
	      	}
	    }
	/**
	    //没有更改任何内容不需要保存修改
	    if(j==0){
	    	alert("您没有对号线内容进行变更。");
	    	return false;	    	
	    }
	*/    
	    //号线路由信息描述
	    var num = theloginfo.lastIndexOf('-->');
	    theloginfo = theloginfo.substring(0, num); 
	    	   
	    //路由类型 1：电话 2：宽带
	    thesql +="VALUE29 = '"+ Rounttype + "',";
	    thesql +="VALUE28 = '"+ devNum + "',";
	    thesql += "VALUE30 = '"+ theloginfo + "',";
	    //存储路由电话
	    thesql += "Dh = '"+ thisDh + "' , ";           
	   			
	 	//存放备注
	   	var addRouteBz = $("#addRouteBz").val();
	   	thesql += "bz='"+ tsd.encodeURIComponent( addRouteBz ) + "' "; 
	   	
 		$("#theloginfo").val(theloginfo);//存放日志信息
		params = '&str=' + thesql +'&lineid='+lineid;
		//每次拼接参数必须添加此判断
		if(tsd.Qualified()==false){return false;}
		return params;
}

/**
* 新增、修改的路由信息
* @param type 操作类型 : add:新增操作   modify ：修改操作  Parallel:并机操作
* @param linetype 号线类型： 0：普通号线   1：跨模块局号线
* @return
*/
function saveRouteInfo(opertype,linetype)
{	
	var Rounttype = $("#Rounttype_hide").val();//路由类型 1:电话 2：宽带	
    //isThisHidden('block');
    var thisDh = $('#dh_rount').val();
    var thepk = '';
    var theparam = '';
    var checkNode='';
	var line_userid ='';  
	var BJFlag = 0 ;
	if(opertype=='add'){
		line_userid = $("#line_userid").val();
	}
	else if(opertype=='Parallel'){
		line_userid = $("#BJ_userid").val();
	}
	//2012-10-31 yhy start 号线并机问题解决
	//当前需要设置的配线的air_line.lineid
	var EndLineid = $("#BJ_EndLineid").val(); 
	//如果“当前需要设置的配线的air_line.lineid”等于空，则在air_line表中没有该记录，需要新增该记录
	if(EndLineid == ''){
		BJFlag = 1;
	}
	
	if(opertype=='add' || (opertype=='Parallel' && BJFlag == 1)){
		//如果在号线表中存在当前电话记录，执行添加语句
	   thepk = 'userLineManager.addRouteInfo';	   
	   if(linetype==1){	   		
	    	//拼接惨数
	    	theparam = ZWsavebuildParams(line_userid);
	    } else {
	    	checkNode = checkNodeUsing(opertype,linetype);
	    	if(checkNode==false){return false;}
	    	//拼接惨数
	    	theparam = savebuildParams(line_userid);
	    }
	    if(theparam==false){return false;} 
	    
	}else if(opertype=='Parallel'){
		//如果在号线表中存在当前电话记录，执行添加语句
	   thepk = 'userLineManager.updateRouteInfo';	   
	   if(linetype==1){	   		
	    	//拼接惨数
	    	theparam = ZWParalleluildParams(line_userid);
	    } else {
	    	checkNode = checkNodeUsing(opertype,linetype);
	    	if(checkNode==false){return false;}
	    	//拼接惨数
	    	theparam = parallelBuildParams(line_userid);
	    }
	    if(theparam==false){return false;} 
	}else if(opertype=='modify'){
		//如果在号线表中不存在当前电话记录，执行添加语句
	    thepk = 'userLineManager.updateRouteInfo';   
	    if(linetype==1){
	    	//拼接惨数 
	    	theparam= ZWmodifybuildParams(); 
	    }else {
	    	checkNode = checkNodeUsing(opertype,linetype);
	    	if(checkNode==false){return false;} 
	    	//拼接惨数 
	    	theparam= modifybuildParams(); 
	    }
	    if(theparam==false){return false;} 
	}  
   //2012-10-31 yhy end 号线并机问题解决 
    
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
        url : 'mainServlet.html?' + urlstr + theparam +'&dh='+thisDh, 
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
      /*  
                var urlstr = tsd.buildParams(
                {
		packgname : 'service', 
		clsname : 'ExecuteSql',
		method : 'exeSqlData',
		ds : 'tsdBilling',
		tsdcf : 'mssql',
		tsdoper : 'exe',
		tsdpk : 'userLineManager.deletedevicemx'
                });
                $.ajax({
                url : 'mainServlet.html?' + urlstr + '&nodedata='+nodedata,
                cache : false,
                timeout : 1000, 
                async : false , //ͬ²½·½ʽ
                success : function (msg)
               {
                  alert("delete msg is "+msg);
                 	if (msg == "true")
	               {
	                 alert("delete success");
	               }
               }
                });          
*/
                /*************
                 ** 释放资源 **
                 ************/                
                setTimeout($.unblockUI, 15);
                
                //更新端子使用状态
                if(linetype==1){
			    	updateNodeStatus(opertype,'ZW');
			    }else {
			    	updateNodeStatus(opertype,'');
			    }
                
                ///////////////////////////////////////////////////////////
			    //根据操作类型 写入日志字符串设置
			    var opertypelog ='' ;
			    if(opertype =='add'){
			    	opertypelog='添加用户';
			    }else if(opertype =='modify'){
			    	opertypelog='修改用户';
			    }else if(opertype == 'Parallel'){
			    	opertypelog='并机用户';
			    }
			    
			    var theloginfo = $("#theloginfo").val();//存放日志信息
			    //判断不同路由类型
			    if(Rounttype == 1){
			    	writeLineInfo('',tsd.encodeURIComponent('电话号线'), tsd.encodeURIComponent(opertypelog+' [' + thisDh + ']的电话号线资料信息：') + theloginfo);
			    	
			    	//更新电话路由jqgrid
                    var column = $('#ziduansF_info').val();
                    var line_userid = $("#line_userid").val();
	                reloadRouteData('userLineManager.querylineinfo', 'userLineManager.querylineinfopage', 
	                'editgrid_info', line_userid, column,'1') ;
	                changeMenu('phone') ;//跳转到生成调度页面
			    }else if(Rounttype == 2){
			    	changeMenu('broadband') ;//跳转到生成调度页面
			    /*
			    	writeLineInfo('', tsd.encodeURIComponent('宽带号线'), tsd.encodeURIComponent(opertypelog+' [' + thisDh + ']的宽带号线资料信息：') + theloginfo);
			    	
			    	//更新宽带路由jqgrid                
	                var column = $('#ziduansF_broad').val();
	                reloadRouteData('userLineManager.querylineinfo', 'userLineManager.querylineinfopage', 
	                'editgrid_broad', thisDh, column,'2') ; 
	            */
	            
			    } 
			    
			    
            }
        }
    }); 
}


//设置路由类型选中状态
function checkradioval(value){
	$("#Rounttype_hide").val(value);
}

/**
* 获取变更的端子，并更新状态
	将被使用的端子值为using 状态，将移除使用的端子值为free状态
	新增或并机操作时，把所有当前都置为正在使用，
	修改或删除时：需要告诉到改账号是否进行了并机，所以目前的做法是，先把原来使用，当前不用的节点置为“free状态”，再将改账号所使用的所有端子置为“using”状态
* @param type add:新增   modify：修改  delete： 删除
* @param fieldPre :存放端口编号的标签id的前缀。
* @return
*/
function updateNodeStatus(type,fieldPre){
	var thisDh = $('#dh_rount').val();
	var conts = $("#"+fieldPre+"addRountinput p");
	var freestr = "";
	var usingstr = "";
	
	//端子使用状态
	$(conts).each(function(i,n){
			//var nval = $(":text.n_value",n).val();
			//var pno = $("input.par_noo",n).val();
			var newno = $("input."+fieldPre+"self_noo",n).val();//本次端子编码			
			var oldno = $("input."+fieldPre+"src_value",n).val();//更改前端子编码
			
			if(oldno=="" && newno!=oldno){
				usingstr += " or (DeviceNo = '" + newno + "' )";
			}else if(oldno!="")
			{
				if(newno=="")
				{
					freestr += " or (DeviceNo like '" + oldno+ "')";
				}
				else if(newno!=oldno)
				{
					usingstr += " or (DeviceNo like '" + newno + "')";
					freestr += " or (DeviceNo like '" + oldno + "')";
				}
			}
	});	
	//去掉字符串中第一个or
	usingstr = usingstr.replace("or","");
	freestr = freestr.replace("or","");		
		
	if($.trim(freestr)!=""){
		executeNoQuery("userLineManager.updatestate",6,"&dh="+"&nstate=free&fuhesql=" + encodeURIComponent(freestr));
	}
	
	
	//如果修改的话，要考虑有并机情况下，修改其中一条路由共同端子时，该端子的使用情况，应该任务被使用。
	if(type=="modify"||type=="delete"){
		var isusing = setNodeUsing();
		isusing = isusing.replace("or","");
		//更新端子使用状态
		executeNoQuery("userLineManager.updatestate",6,"&dh="+thisDh+"&nstate=using&fuhesql=" + encodeURIComponent(isusing));
	}else {
		//获取变更的端子，并更新状态
		if($.trim(usingstr)!=""){
			executeNoQuery("userLineManager.updatestate",6,"&dh="+thisDh+"&nstate=using&fuhesql=" + encodeURIComponent(usingstr));
		}
	}
}


/**
* 变更的端子为使用状态
	将被使用的端子值为using 状态，
* @param
* @return
*/
//如果是修改号线，在有并机的情况下，可能导致某一条路线的共同设备端口变更，该设置即被设为可用，而实际上在另一条路由上改端口正在被使用，
//为防止次状况出现，将air_line表中该电话所用端子全部置为using状态
function setNodeUsing(){
	var dh =$("#dh_rount").val();
	var usingstr='';
	var urlstr=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型
									  datatype:'xmlattr',//返回数据格式 
									  tsdpk:'userLineManager.selectUsingByDh'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									});	
		$.ajax({
			url:'mainServlet.html?'+urlstr+'&Dh='+dh,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				/////////////////////////////
				//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
				$(xml).find('row').each(function(){
						
						//获取被使用端子
 						for(var i=2;i<=16;i++){
							var k1 =i;						
							var nodeNo = $(this).attr("value"+k1);
							if(nodeNo!=''){
								usingstr += " or (DeviceNo = '" + nodeNo + "' )";								
							}							
						}
		 		});
			}
		});		
		return usingstr;
}

 ////////////////////////////////////////////////电话jqgrid////////////////////////////////////////////////////////
/**
* 显示电话jqgrid
* @param
* @return
*/
function showTelJQgrid(){
	 var col=[[],[]];
	 col=getRb_Field('air_line_rount','dh','修改|删除|并机','86','ziduansF_info','lineid','Value29','Value26','line_userid');//得到jqGrid要显示的字段	
	 
	   jQuery("#editgrid_info").jqGrid({
	        //datatype : 'xml', 
	        colNames : col[0], 
	        colModel : col[1], 
	        //rowNum : 1, //默认分页行数
	        //rowList : [1, 10, 20], //可选分页行数
	        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images/', 
	        pager : jQuery('#pagered_info'), 
	        sortname : 'value27', 
	        //默认排序字段
	        viewrecords : true, 
	        sortorder : 'asc', //默认排序方式 
	        caption : '用户电话号线资料详细信息',
	        height : 55, //高 
	        width : document.documentElement.clientWidth - 63,
	        //width : 1600,
	        loadComplete : function ()
	        {
	            
				if ($("#editgrid_info tr.jqgrow[id='1']").html() == "") {
	                return false;
	            }
				addRowOperBtnimage('editgrid_info','openRowModify','lineid','click',1,"style/images/public/ltubiao_01.gif",'修改',"&nbsp;&nbsp;&nbsp;&nbsp;",'Value29','Value26','MoKuaiJu');//修改
				addRowOperBtnimage('editgrid_info','deleteRow','lineid','click',2,"style/images/public/ltubiao_02.gif",'删除',"&nbsp;&nbsp;&nbsp;&nbsp;",'Value29','Value26','MoKuaiJu');//删除
				addRowOperBtnimage('editgrid_info','openParallelOper','lineid','click',3,'style/images/public/ltubiao_03.gif',"并机","&nbsp;&nbsp;&nbsp;",'Value29','Value26','MoKuaiJu','dh','line_userid');//并机
				
				executeAddBtn('editgrid_info',3);
				/***								
	            addRowOperBtn('editgrid_info', '&nbsp;&nbsp;&nbsp;&nbsp;<img src="style/images/public/ltubiao_0' + theviewoperations + '.gif" alt="修改"/>', 
	            'queryRouteInfo', 'Dh', 'click', 1);
	            addRowOperBtn('editgrid_info', '', '', '', 'click', 2);
	            executeAddBtn('editgrid_info', 2);
	            */
	        },
	        ondblClickRow : function (ids) 
	        {
	        	if(ids!=null){
	        		//displayDetailInfos('phone');
	        	}
	        }
	    });
 }
 
 ////////////////////////////////////////////////宽带jqgrid////////////////////////////////////////////////////////
/**
* 显示宽带jqgrid
* @param
* @return
*/
function showbBroadJQgrid(){
	 var col=[[],[]];
	 col=getRb_Field('air_line_rount','dh','修改|删除|并机','97','ziduansF_broad','lineid','Value29');//得到jqGrid要显示的字段	
	 
	jQuery("#editgrid_broad").jqGrid({
	        //datatype : 'xml', 
	        colNames : col[0], 
	        colModel : col[1], 
	        //rowNum : 1, //默认分页行数
	        //rowList : [1, 10, 20], //可选分页行数
	        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images/', 
	        pager : jQuery('#pagered_broad'), 
	        sortname : 'Dh', 
	        //默认排序字段
	        viewrecords : true, 
	        sortorder : 'desc', //默认排序方式 
	        caption : '用户宽带号线资料详细信息', 
	        height : 60, //高 
	        width : document.documentElement.clientWidth - 63,
	       //width : 1600,
	         loadComplete : function ()
	        {
	            if ($("#editgrid_broad tr.jqgrow[id='1']").html() == "") {
	                return false;
	            }
	            
	            addRowOperBtnimage('editgrid_broad','openRowModify','lineid','click',1,"style/images/public/ltubiao_01.gif",'修改',"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'Value29');//修改
				addRowOperBtnimage('editgrid_broad','deleteRow','lineid','click',2,"style/images/public/ltubiao_02.gif",'删除',"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'Value29');//删除
				addRowOperBtnimage('editgrid_broad','openParallelOper','lineid','click',3,'style/images/public/ltubiao_03.gif',"并机","&nbsp;&nbsp;&nbsp;",'Value29');//详细
				
				executeAddBtn('editgrid_broad',3);
	           /**
	            addRowOperBtn('editgrid_broad', '&nbsp;&nbsp;&nbsp;&nbsp;<img src="style/images/public/ltubiao_0' + theviewoperations + '.gif" alt="添加"/>', 
	            'queryBandInfo', '', 'click', 1);
	            addRowOperBtn('editgrid_broad', '', '', '', 'click', 2);
	            executeAddBtn('editgrid_broad', 2);
	           **/
	        },
	        ondblClickRow : function (ids) 
	        {
	        	if(ids!=null){
	        		//displayDetailInfos('broadband');
	        	}
	        }
	    });	 
 }
 
 /**
 * 重载路由信息
 * @param 
 * @return 
 */
function reloadRouteData(tsdpk, tsdpksql, gridid, line_userid, column,rounttype)
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
        url : 'mainServlet.html?' + urlstr + '&line_userid=' + line_userid + '&rounttype=' + rounttype + '&cloumn=' + column
    }).trigger("reloadGrid");
    //setTimeout($.unblockUI, 15);
    //关闭面板
}

	
/**
 * 删除电话路由信息
 * @param lineid： lineid
 * @param typeid： 类型：1：电话 2：宽带
 * @param linetype： 类型：0：普通	 1：专网
 * @mokuaiju mokuaiju
 * @return 
 */
function deleteRow(lineid,typeid,linetype,mokuaiju){
		//alert(typeid);
		//是否有执行删除的权限
		/**
		var deleteright = $("#deleteright").val();
		if(deleteright=="true"){	
		*/
				if(linetype==1){//跨模块局
			 		//	号线模块局权限判断
					var thismkj = $('#thismkj').val();
					var mkj =  ","+thismkj.replace(new RegExp("'","g"),"")+",";			
					var mkjtemp = ","+mokuaiju + ","; 
				  	if(mkj.indexOf(mkjtemp)==-1){
				  		alert("您没有修改该模块局号线管理权限！");
				  		return;
				  	}
				 }
					
			 	var deleteinformation = $("#deleteinformation").val();
				var operationtips = $("#operationtips").val();
			 	jConfirm(deleteinformation,operationtips,function(x){
			 		 if(x==true){
			 		 		//从air_line查询出本条记录的详细信息，用于写入日志和更新端子使用状态
			 		 		if(linetype==1){//跨模块局
								
				 		 		clearText('ZWaddRountforms',3);
				 		 		ZWqueryByID(lineid,'delete');
			 		 		}else{
				 		 		clearText('addRountforms',3);
				 		 		queryByID(lineid,'delete');
			 		 		}	 		 	
				 		 	
				 		 	var urlstr=tsd.buildParams({  packgname:'service',//java包
														  clsname:'ExecuteSql',//类名
														  method:'exeSqlData',//方法名
														  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
														  tsdcf:'mssql',//指向配置文件名称
														  tsdoper:'exe',//操作类型 
														  datatype:'xml',//返回数据格式 
														  tsdpk:'userLineManager.deleteRow'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
														});
							var urlstr='mainServlet.html?'+urlstr+'&lineid='+lineid; 
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
											
											//更新端子使用状态
											if(linetype==1){//专网
								 		 		updateNodeStatus('delete','ZW');
							 		 		}else{
								 		 		updateNodeStatus('delete','');
							 		 		}
											
											////////////////////////写入日志
											var dh = $("#Rdh").val();
											var rounttype = $("#Rrounttype").val(rounttype);
											var memo = $("#Rmemo").val(memo);
											//更新jqgrid数据
											if(typeid=='1'){																				
												$("#editgrid_info").trigger("reloadGrid");
												//写入日志操作
												writeLineInfo('',tsd.encodeURIComponent('电话号线'), tsd.encodeURIComponent('删除用户[' + dh + ']的电话号线资料信息：') + tsd.encodeURIComponent(memo));
												changeMenu('phone') ;//跳转到生成调度页面
											}else if(typeid=='2'){
												changeMenu('broadband') ;//跳转到生成调度页面
											/*		
												$("#editgrid_broad").trigger("reloadGrid");
												//写入日志操作
												writeLineInfo('', tsd.encodeURIComponent('宽带号线'), tsd.encodeURIComponent('删除用户[' + dh + ']的宽带号线资料信息：') + tsd.encodeURIComponent(memo));
											*/
											}					
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
 * @param key lineid
 * @param type  操作类型：delete：删除操作  modify：修改操作  Parallel:并机操作
 删除操作不需要把记录写入面板
 修改操作需要把记录写入面板
 * @return 
 */
function queryByID(key,type){ 
		$("#lineid").val(key);
		
		var urlstr=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型
									  datatype:'xmlattr',//返回数据格式 
									  tsdpk:'userLineManager.queryByKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									});	
		$.ajax({
			url:'mainServlet.html?'+urlstr+'&lineid='+key,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				var nodeInfo ='';//存放改路由所有端子编码用于查找当前路由端子名称

				//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
				$(xml).find('row').each(function(){					
					
					//var rountnum = $(this).attr("value28");	//路由长度
					var dh = $(this).attr("dh");
					$("#Rdh").val(dh);
					var rounttype = $(this).attr("value29");
					$("#Rrounttype").val(rounttype);
					var memo = $(this).attr("value30");	
					$("#Rmemo").val(memo);
					var bz = $(this).attr("bz");//备注
					$("#addRouteBz").val(bz);
					
					//对删除 修改不同操作处理不一样
					for(var i=1;i<=RountNUM;i++){
						var k1 =i+1;
						var nodeNo = $(this).attr("value"+k1);
						if(nodeNo!=''){
							nodeInfo += "'"+nodeNo+"',";							
						}
						var deviceno_p = nodeNo.substring(0,3);
	 					var nodenum = $("#rount_"+deviceno_p+"_no").attr("attrval");
	 					if(type=='modify'){	
					    	$('#rount_' +nodenum + "_y").val(nodeNo);//写入更改前四级端子编号
					    	$('#rount_' +nodenum + "_s").val(nodeNo);//写入当前四级端子编号
					    }else if(type=='delete'){
					    	$('#rount_' +nodenum + "_y").val(nodeNo);//写入更改前四级端子编
					    }else if(type=='Parallel'){
					    	$('#rount_' +nodenum + "_s").val(nodeNo);//写入当前四级端子编号
					    	$('#rount_' +nodenum + "_p").val(nodeNo);//写入并机前四级端子编号	
					    }
					    
					}
					
		 		});	
		 		
		 		//往路由节点中写入节点信息
		 		if(nodeInfo!=''){
		 			//去掉最后的逗号 		
			 		var len1 = nodeInfo.lastIndexOf(',');
			 		nodeInfo = nodeInfo.substring(0,len1);
			 		//alert(nodeInfo);
			 		getNodeStr(nodeInfo);
		 		}		 		
			}
		});
}

/**
 * 获取路由节点的显示信息
 	从air_deviceMX表中读取
 * @param  idprev：写入域id前缀
 * @return 
 */
function getNodeStr(nodeInfo){
	var urlstr=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型
									  datatype:'xmlattr',//返回数据格式 
									  tsdpk:'userLineManager.getNodestr'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									});	
		$.ajax({
			url:'mainServlet.html?'+urlstr+'&nodestr='+nodeInfo,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				var nodeInfo ='';//存放改路由所有端子编码用于查找当前路由端子名称

				//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
				$(xml).find('row').each(function(){				
					var deviceno = $(this).attr("deviceno");
					var devicename = $(this).attr("devicename");
					var devicetype = $(this).attr("devicetype");
					var nodename = $(this).attr("nodename");
					//拼接显示在路由节点上的信息，信息拼接方式为：设备类型【设备名称】：设备端口名 
					//var str = devicename+"【"+devicetype+"】:"+nodename;
					var str = devicename+":"+nodename;
					//端口编码的前三位设备类型的编码，取其用于确定当前记录时属于那个节点
		 			var deviceno_p = deviceno.substring(0,3);
		 			var nodenum = $("#rount_"+deviceno_p+"_no").attr("attrval");
		 			$("#rount_" +nodenum).val(str);//路由文本域写入值		
		 			$("#rount_" +nodenum).attr("title",str);			
		 		});		 		
		 		
			}
		});
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
        reloadQueryData('userLineManager.querytheinfo', 'userLineManager.querytheinfopage', 'editgrid', 
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


