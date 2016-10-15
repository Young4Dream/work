/*****************************************************************
 * name: script/telephone/linemanagement/ZWUserLineManager.js
 * author: 尤红玉
 * version: 001.0, 2011-6-8
 * description: 专网用户号线设备管理
 * modify:
 *****************************************************************/
/**
* 打开专网添加号线面板
* @param  numR :添加路由条数  ；
* @param  printType:打印类型  new：往孔面板添加路由个数  add：在原有的面板上追加个数
* @return 
*/ 
 function ZWprintRountPan(numR,printType){
 	var theinput="";
 	if(printType=='new'){
 		ZWRountNUM=numR;
 		for(var i=1;i<=numR;i++){ 		
 			var flags = "";//"disabled='disabled'";
	 		theinput += "<p style='margin-left:20px'><span class='tmpspanstyle'>路由" +i+"</span>";
	 		theinput += "<input class='ZWn_value' type='text' id='ZWrount_" + i + "' style='width: 320px;height:22px;' readonly='readonly' />";
	 		theinput +="<input type='hidden' class='ZWpar_noo' id='ZWrount_" + i + "_h' />";	 		
	 		theinput +="<input type='hidden' class='ZWself_noo' id='ZWrount_" + i + "_s' />";//记入当前端子编码	 		
	 		theinput +="<input  class='ZWsrc_value' id='ZWrount_" + i + "_y' />";//修改操作记录时记录更改前端子编码
	 		theinput +="<input type='hidden' id='ZWrount_" + i + "_p' />";//并机前端子编码
	 		theinput +="<button style='margin-left:10px' class='btn_2k3' "+flags+" id='ZW" + i + "b' onclick=ZWshowDeviceType('ZWrount_" + i + "')>变更设备</button>"
	 		theinput +="<button class='btn_2k3' style='margin-left:20px' "+flags+" id='ZW" + i + "c' onclick=clearTheValue('ZWrount_" + i + "')>清空数据</button>" ;
	 		theinput +="</p><hr/>";
    	}
    	$("#ZWaddRountinput").html(theinput);
 	}else if(printType=='add'){
 		/**
 		if(ZWZWRountNUM>=13){
 			alert("路由线路最多只支持13个节点，目前已经有13个节点，不能再添加！");
 			return false;
 		}
 		*/
 		for(var j=1;j<=numR;j++){
	 		ZWRountNUM++;
	 		var flags =""; //"disabled='disabled'";
	 		theinput += "<p style='margin-left:50px'><span class='tmpspanstyle'>路由" +ZWRountNUM+"</span>";
	 		theinput += "<input class='n_value' type='text' id='ZWrount_" + ZWRountNUM + "' style='width: 320px;height:22px;' readonly='readonly'/>";
	 		theinput +="<input type='hidden' class='ZWpar_noo' id='ZWrount_" + ZWRountNUM + "_h' />";
	 		theinput +="<input type='hidden' class='ZWself_noo' id='ZWrount_" + ZWRountNUM + "_s' />";//记入当前端子编码
	 		theinput +="<input type='hidden' class='ZWsrc_value' id='ZWrount_" + ZWRountNUM + "_y' />";//修改操作记录时记录更改前端子编码
	 		theinput +="<input type='hidden' id='ZWrount_" + ZWRountNUM + "_p' />";//并机前端子编码
	 		theinput +="<button style='margin-left:10px' class='btn_2k3' "+flags+" id='ZW" + ZWRountNUM + "b' onclick=ZWshowDeviceType('ZWrount_" + ZWRountNUM + "')>变更设备</button>"
	 		theinput +="<button class='btn_2k3' style='margin-left:20px' "+flags+" id='ZW" + ZWRountNUM + "c' onclick=clearTheValue('ZWrount_" + ZWRountNUM + "')>清空数据</button>" ;
	 		theinput +="</p><hr/>";
	 		$("#ZWaddRountinput").append(theinput);
 		}
 	} else if(printType=='Info'){ 		
 		ZWRountNUM=numR;
 		for(var i=1;i<=numR;i++){ 		
 			var flags = "";//"disabled='disabled'";
	 		theinput += "<p style='margin-left:20px'><span class='tmpspanstyle'>路由" +i+"</span>";
	 		theinput += "<input class='ZWn_value' type='text' id='ZWrount_" + i + "' readonly='readonly' style='width: 320px;height:22px;' />";
	 		theinput +="<input type='hidden' class='ZWpar_noo' id='ZWrount_" + i + "_h' />";	 		
	 		theinput +="<input type='hidden' class='ZWself_noo' id='ZWrount_" + i + "_s' />";//记入当前端子编码	 		
	 		theinput +="<input  class='ZWsrc_value' id='ZWrount_" + i + "_y' />";//修改操作记录时记录更改前端子编码
	 		theinput +="<input type='hidden' id='ZWrount_" + i + "_p' />";//并机前端子编码
	 		theinput +="</p><hr/>";
    	}
    	$("#ZWaddRountinput").html(theinput);
 	} 
 } 
 
 
/**
 * 切换到专网号线设置面板
 * @param 
 * @return 
 */
function switchZWPan(){
		 $("#addRountform").hide();//隐藏普通号线面板
		//设置按钮的隐藏显示
		$("#ZWOrder").removeAttr("disabled");
		$('#ZWmodifyRount').hide();
		$('#ZWsaveRount').show();	
		$('#ZWParallelRount').hide();			
		$("#changeToPT").show();
		ZWprintRountPan(3,'new');
		clearText('ZWaddRountforms',3);	
		//设置默认选中模块局
		$("#ZWOrder option:first").attr('selected','selected');
		setMkj();
		//设置号线设备类型默认为 ：普通路由
		$("#ZWtype").val(0);
 		autoBlockForm('ZWaddRountform', 5, 'ZWaddRountclose', "#ffffff", false);
}


/**
 * 切换到普通号线设置面板
 * @param 
 * @return 
 */
function switchPTPan(){
		 $("#ZWaddRountform").hide();//隐藏专网号线面板
		//设置按钮的隐藏显示
		$('#modifyRount').hide();
		$('#saveRount').show();		
		$("#ParallelRount").hide();
		$("#changeToZW").show();
		clearText('addRountforms',3);
 		autoBlockForm('addRountform', 5, 'addRountclose', "#ffffff", false);
}

 /**
* 打开二级设备管理窗口
* @param NodeField：设备别名
* @return 
*/
function ZWshowDeviceType(NodeField,deviceno)
{ 
    var ZWmkj = $('#ZWmokuaiju').val();
    window.showModalDialog('mainServlet.html?pagename=telephone/linemanagement/selDeviceType.jsp&NodeField=' + NodeField + '&mkj=' + tsd.encodeURIComponent(ZWmkj)+'&deviceno=0', 
    window, "dialogWidth:710px; dialogHeight:420px; center:yes; scroll:no");
}


/**
 * 打开专网号线修改路由面板
 * @param lineid： lineid
 * @param typeid： 类型：1：电话 2：宽带
 * @param linetype： 类型：0：普通	 1：专网
 * @return 
 */
function ZWopenModifyPan(lineid,typeid){
		//设置按钮的隐藏显示
		$("#ZWOrder").attr("disabled","disabled");
		$('#ZWmodifyRount').show();
		$('#ZWsaveRount').hide();
		$('#ZWParallelRount').hide();
		$("#changeToPT").hide();
		clearText('ZWaddRountforms',3);
		
		AddMkjUsed(lineid);
		ZWqueryByID(lineid,'modify');
		
		
		//将头部路由类型设为相应的选中状态
		$('[name="Rounttype"]:radio').each(function() {
		       if (this.value == typeid)
		       {
		         this.checked = true;
		       } 
	    });
		$("#Rounttype_hide").val(typeid);
 		autoBlockForm('ZWaddRountform', 5, 'ZWaddRountclose', "#ffffff", false);
}

  /**
 * 打开跨模块局并机路由信息面板
 * @param lineid： lineid
 * @param typeid： 类型：1：电话 2：宽带
 * @return 
 */
 function ZWOpenBJPan(lineid,typeid){
 		//设置按钮的隐藏显示
		$("#ZWOrder").attr("disabled","disabled");
		$('#ZWmodifyRount').hide();
		$('#ZWsaveRount').hide();
		$('#ZWParallelRount').show();
		$("#changeToPT").hide();
		clearText('ZWaddRountforms',3);
		//AddMkjUsed(lineid);
		var BJ_userid = $("#BJ_userid").val();
		setZWMkjBJ(BJ_userid);
		ZWqueryByID(lineid,'Parallel');
		
		//将头部路由类型设为相应的选中状态
		$('[name="Rounttype"]:radio').each(function() {
		       if (this.value == typeid)
		       {
		         this.checked = true;
		       } 
	    });
		$("#Rounttype_hide").val(typeid);
 		autoBlockForm('ZWaddRountform', 5, 'ZWaddRountclose', "#ffffff", false);
 }
/**
 * 从air_line，取出一条数据显示在addform面板
 * @param key lineid
 * @param type  操作类型：delete：删除操作  modify：修改操作  Parallel:并机操作
 删除操作不需要把记录写入面板
 修改操作需要把记录写入面板
 * @return 
 */
function ZWqueryByID(key,type){ 
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
					var ZWtype = $(this).attr("value25");	//RC路由标识
					var ordernum = $(this).attr("value27");	//路由序号
					var rountnum = $(this).attr("value28");	//路由长度
					var mokuaiju = $(this).attr("mokuaiju");//模块局
					var bz = $(this).attr("bz");//备注
					$("#ZWAddRouteBz").val(bz);
					//并机时
					if(type=='Parallel')
					{
						$("#ZWOrder option[mkjvalue="+mokuaiju+"]").attr('selected','selected');
					}else
					{
						$("#ZWOrder").val(ordernum);						
					}
					$("#ZWmokuaiju").val(mokuaiju);
					$("#ZWtype").val(ZWtype);
					
					var rounttype = $(this).attr("value29");
					$("#Rrounttype").val(rounttype);
					var memo = $(this).attr("value30");	
					$("#Rmemo").val(memo);
					var memoArray = memo.split('-->');
					
					ZWprintRountPan(rountnum,'new');//打印号线面板
					//对删除 修改不同操作处理不一样
					for(var i=1;i<=rountnum;i++){
						var k1 =i+1;
						var nodeNo = $(this).attr("value"+k1);
						if(nodeNo!=''){
							nodeInfo += "'"+nodeNo+"',";							
						}
						//往路由节点中写入节点信息
						if(memoArray.length>=i-1){
							$("#ZWrount_" +i).val(memoArray[i-1]);//路由文本域写入值		
		 					$("#ZWrount_" +i).attr("title",memoArray[i-1]);		
		 				}	
						//var deviceno_p = nodeNo.substring(0,3);
	 					//var nodenum = $("#ZWrount_"+deviceno_p+"_no").attr("attrval");
	 					if(type=='modify'){	
					    	$('#ZWrount_' +i + "_y").val(nodeNo);//写入更改前四级端子编号
					    	$('#ZWrount_' +i + "_s").val(nodeNo);//写入当前四级端子编号
					    }else if(type=='delete'){
					    	$('#ZWrount_' +i + "_y").val(nodeNo);//写入更改前四级端子编
					    }else if(type=='Parallel'){					    	
					    	$('#ZWrount_' +i + "_s").val(nodeNo);//写入当前四级端子编号
					    	$('#ZWrount_' +i + "_p").val(nodeNo);//写入并机前四级端子编号	
					    }
					    
					}
					
		 		});		 		 		
			}
		});
}



/**
* 新增参数拼接
* @param line_userid :air_users的id ；air_line和air_usersd 的关联表
* @param type 操作类型 : add:新增操作  
* @return
*/
function ZWsavebuildParams(line_userid){
	 	//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
		
		//进行合法性验证
		//选择路由类型
		var Rounttype = $("#Rounttype_hide").val();//路由类型 1:电话 2：号线
		if(Rounttype==''){
			alert("请选择路由类型");
			return false;
		}		
	    var params ='';
		var thevalue = '';
		var thesql = '';
   		var theloginfo = '';
	   	var RountNUMis=1;
	   	var line_userid = line_userid;//被选中电话在air_users的id	   	
	    var thisDh = $('#dh_rount').val();
	    var mkj = $("#ZWmokuaiju").val();
	    var orderNum = $("#ZWOrder").val();
	    var ZWtype = $("#ZWtype").val();//号线设备类型 0：普通 1：RC
	    if(ZWtype != '1'){
	    	ZWtype='0';
	    }
	    
	   	var j=0;//存放变更个数
	   	var k=0;//存放添加端子个数
	   	var valarr = new Array();
	    //设置插入路由的sql语句 片段
	    for(var i = 1 ;i<=ZWRountNUM;i++){     	
	      	var nodestr = $("#ZWrount_"+i).val();
	      	var nodeNo = $("#ZWrount_"+i+"_s").val();
	      	var nodeNoP = $('#ZWrount_' +i + "_p").val();//写入并机前四级端子编号
	      	
	      	//变更个数
	      	if(nodeNo!=nodeNoP){
	      		j++;
	      	}
	      		      	
	      	if(nodestr!=''){
	      		valarr.push(nodeNo);
	      		RountNUMis++;
	      		thesql += 'value'+RountNUMis+',';
	      		thevalue += "'" + tsd.encodeURIComponent(nodeNo) + "',";
	      		k++;
	      		theloginfo += tsd.encodeURIComponent(nodestr) + "-->";
	      	}
	    }
	    
	    //数据检测，chenliang，2011-11-07
	    var lenold =valarr.length;
	    var chkArr = uniqueDataCheck(valarr);
	    var lennew = chkArr.length;
	    if(lennew!=lenold){
	    	alert('路由中节点不能重复添加');
	    	return false;
	    }
	    
	    //没有设置任何端子，无须保存
	    if(k==0){
	    	alert("请至少选中一个路由信息，再保存。");
	    	return false;	    	
	    }
	    /**
	    //没有更改任何内容不需要保存修改
	    if(j==0){
	    	alert("该路由和原来路由一直，不需要进行并机。");
	    	return false;	    	
	    }	   
	    */
	    
	    //添加备注字段	    
	    var ZWAddRouteBz = $("#ZWAddRouteBz").val();
	    
	    //路由类型 1：电话 2：宽带
	    thesql +='VALUE29,' ;
	    thevalue += "'" + Rounttype + "',";
	    
	    //号线路由信息描述
	    var num = theloginfo.lastIndexOf('-->');
	    theloginfo = theloginfo.substring(0, num);        
	    thesql += 'VALUE30,';
	    thevalue += "'" + theloginfo + "',";
	    //存储路由电话
	    thesql += 'Dh,';
	    thevalue += "'" + thisDh + "',";  
	    thesql += 'mokuaiju,';
	    thevalue += "'" + tsd.encodeURIComponent(mkj) + "',";
	    //被选中电话在air_users的id
	    thesql += 'line_userid,';
	    thevalue += "'" + tsd.encodeURIComponent(line_userid) + "',";
	     //存放号线添加的设备个数
	    thesql += 'VALUE28,';
	    thevalue += "'" + k + "',";
	    //存放号线序号
	    thesql += 'VALUE27,';
	    thevalue += "'" + orderNum + "',";
	    //存放号线类型 0：普通  1：专网
	    thesql += 'VALUE26 ,';
	    thevalue += "'1' ,";	
	    //存放号线设备类型：0：普通路由 1：RC 
	    thesql += 'VALUE25 ,';
	    thevalue += "'" + ZWtype + "', ";
	 	//存放号线备注 
	    thesql += 'bz ';
	    thevalue += "'" + tsd.encodeURIComponent(ZWAddRouteBz) + "' ";
	 	
		params = '&str=' + thesql + '&thevalue=' + thevalue;
 		$("#theloginfo").val(theloginfo);//存放日志信息
		//每次拼接参数必须添加此判断
		if(tsd.Qualified()==false){return false;}
		return params;
}

//检测重复元素
function uniqueDataCheck(data){   
    data = data || [];   
        var a = {};   
    for (var i=0; i<data.length; i++) {   
        var v = data[i];   
        if (typeof(a[v]) == 'undefined'){   
            a[v] = 1;   
        }   
    };   
    data.length=0;   
    for (var i in a){   
        data[data.length] = i;   
    }   
    return data;   
}
//2012-10-31 yhy start 号线并机问题解决 
/**
* 新增参数拼接
* @param line_userid :air_users的id ；air_line和air_usersd 的关联表
* @param type 操作类型 : add:新增操作  
* @return
*/
function ZWParalleluildParams(line_userid){
	 	//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
		
		//进行合法性验证
		//选择路由类型
		var Rounttype = $("#Rounttype_hide").val();//路由类型 1:电话 2：号线
		if(Rounttype==''){
			alert("请选择路由类型");
			return false;
		}
		//该号线的ai_line的id
		var lineid = $("#BJ_EndLineid").val();
			
	    var params ='';
		var thevalue = '';
		var thesql = '';
   		var theloginfo = '';
	   	var RountNUMis=1;
	   	var line_userid = line_userid;//被选中电话在air_users的id	   	
	    var thisDh = $('#dh_rount').val();
	    var mkj = $("#ZWmokuaiju").val();
	    var orderNum = $("#ZWOrder").val();
	    var ZWtype = $("#ZWtype").val();//号线设备类型 0：普通 1：RC
	    if(ZWtype != '1'){
	    	ZWtype='0';
	    }	       
	    
	   	var j=0;//存放变更个数
	   	var k=0;//存放添加端子个数
	   	var valarr = new Array();
	    //设置插入路由的sql语句 片段
	    for(var i = 1 ;i<=ZWRountNUM;i++){     	
	      	var nodestr = $("#ZWrount_"+i).val();
	      	var nodeNo = $("#ZWrount_"+i+"_s").val();
	      	var nodeNoP = $('#ZWrount_' +i + "_p").val();//写入并机前四级端子编号
	      	
	      	//变更个数
	      	if(nodeNo!=nodeNoP){
	      		j++;
	      	}
	      		      	
	      	if(nodestr!=''){
	      		valarr.push(nodeNo);
	      		RountNUMis++;
	      		thesql += "value"+RountNUMis + "= '" + tsd.encodeURIComponent(nodeNo) + "',";
	      		k++;
	      		theloginfo += tsd.encodeURIComponent(nodestr) + "-->";
	      	}
	    }
	    
	    //清空不用节点
	    var RountC = RountNUMis+1;
	    for(RountC;RountC<=ZWRountNUM;RountC++ ){
	    	thesql += "value"+RountC + "= '',";
	    }   
	    
	    //数据检测，chenliang，2011-11-07
	    var lenold =valarr.length;
	    var chkArr = uniqueDataCheck(valarr);
	    var lennew = chkArr.length;
	    if(lennew!=lenold){
	    	alert('路由中节点不能重复添加');
	    	return false;
	    }
	    
	    //没有设置任何端子，无须保存
	    if(k==0){
	    	alert("请至少选中一个路由信息，再保存。");
	    	return false;	    	
	    }
	    /**
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
	    thesql += "VALUE30 = '"+ theloginfo + "',";
	    //存储路由电话
	    thesql += "Dh = '"+ thisDh + "' ,";
	    //存放号线模块局
	    thesql += "mokuaiju='"+tsd.encodeURIComponent(mkj)+"',";
	    //存放号线添加的设备个数
	    thesql += "VALUE28='" + k + "',";
	    //存放号线序号
	    thesql += "VALUE27='"+ orderNum + "' ,"; 
	    //存放号线设备类型
	    thesql += "VALUE25='"+ ZWtype + "' ,"; 
	    //添加备注字段	    
	    var ZWAddRouteBz = $("#ZWAddRouteBz").val();
	   	thesql += "bz='"+ tsd.encodeURIComponent( ZWAddRouteBz ) + "' "; 

	  	/*
	    //被选中电话在air_users的id
	    thesql += 'line_userid,';
	    thevalue += "'" + tsd.encodeURIComponent(line_userid) + "',";
	    */	 	
				
		$("#theloginfo").val(theloginfo);//存放日志信息
		params = '&str=' + thesql +'&lineid='+lineid;
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
function ZWmodifybuildParams(){
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
	   	 var mkj = $("#ZWmokuaiju").val();
	    var orderNum = $("#ZWOrder").val();
	    var ZWtype = $("#ZWtype").val();//号线设备类型 0：普通 1：RC
	    if(ZWtype != '1'){
	    	ZWtype='0';
	    }
	   	var j=0;//存放变更个数
	   	var k=0;//存放添加端子个数
	   	var valarr = new Array();
	    //设置插入路由的sql语句 片段
	    for(var i = 1 ;i<=ZWRountNUM;i++){     	
	      	var nodestr = $("#ZWrount_"+i).val();
	      	var nodeNoNew = $("#ZWrount_"+i+"_s").val();
	      	var nodeNoOld = $("#ZWrount_"+i+"_y").val();
	      	if(nodeNoNew!=nodeNoOld){
	      		j++;
	      	}
	      	
	      	if(nodestr!=''){
	      		valarr.push(nodeNoNew);
	      		RountNUMis++;
	      		thesql += "value"+RountNUMis + "= '" + tsd.encodeURIComponent(nodeNoNew) + "',";
	      		k++;	      		
	      		theloginfo += tsd.encodeURIComponent(nodestr) + "-->";
	      	}
	    }
	    //清空不用节点
	    var RountC =  parseInt(RountNUMis ,10 ) + 1;
	    var rounteCount = parseInt(ZWRountNUM ,10) +1;
	    for(RountC ; RountC<=rounteCount ; RountC++ ){
	    	thesql += "value"+RountC + "= '',";
	    }
	    
	     //数据检测，chenliang，2011-11-07
	    var lenold =valarr.length;
	    var chkArr = uniqueDataCheck(valarr);
	    var lennew = chkArr.length;
		//alert(chkArr+"--------------"+valarr);
	    if(lennew!=lenold){
	    	//alert('路由中节点不能重复添加');
	    	//return false;
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
	    thesql += "VALUE30 = '"+ theloginfo + "',";
	    //存储路由电话
	    thesql += "Dh = '"+ thisDh + "' ,";
	    //存放号线模块局
	    thesql += "mokuaiju='"+tsd.encodeURIComponent(mkj)+"',";
	     //存放号线添加的设备个数
	    thesql += "VALUE28='" + k + "',";
	    //存放号线序号
	    thesql += "VALUE27='"+ orderNum + "' ,"; 
	    //存放号线设备类型
	    thesql += "VALUE25='"+ ZWtype + "' ,"; 
	   	//存放备注
	   	var ZWAddRouteBz = $("#ZWAddRouteBz").val();
	   	thesql += "bz='"+ tsd.encodeURIComponent( ZWAddRouteBz ) + "' "; 
	   		
	 	
 		$("#theloginfo").val(theloginfo);//存放日志信息
		params = '&str=' + thesql +'&lineid='+lineid;
		//每次拼接参数必须添加此判断
		if(tsd.Qualified()==false){return false;}
		return params;
}

/**
* 验证手动输入的号线端子是否可用
* @param type 操作类型 : add:新增操作   modify ：修改操作  Parallel:并机操作
* @param linetype 号线类型： 0：普通号线   1：专网号线
* @return
*/
function checkNodeUsing(opertype,linetype)
{	
	if(linetype==1)
	{
		//
	}else{
		//遍历所有端子，如果端子名称不为空 根据端子类别 端子名称 模块局名称搜索端口详细信息
			//端子存在且未被占用，将端子信息写入隐藏域，
			//端子存在且被占用，提示“端口已经被占用，请重新输入！”
			//端子不存在，提示“端口名称错误请确定！”
		//端子名称为空 将存放端子编码的隐藏域置空。
		for(var i=1 ;i<=RountNUM;i++)
		{
			//2012-11-5 yhy start
			//当前端口编码
			var deviceno = $("#rount_"+i+"_s").val();
			//当前端口名称
			var nodename = $("#rount_"+i).val();			
			var parmas = "";
			var sqlkey ="";
			//当端口是通过“更新设备”按钮获取的，则可以根据端口编码查询端口的使用情况
			//当端口是通过手动输入端口名称获取的，则需要根据“端子类别” “端子名称” “模块局名称”搜索端口详细信息
			if(nodename !=''){
				var nodetype = RountD[i-1][1];
				var mkj = $("#limitroute").val();
				var dh = $('#dh_rount').val();
				
				if(deviceno!='' ){
					parmas = "&deviceno="+tsd.encodeURIComponent(deviceno);
					sqlkey = "userLineManager.getNodeUsingByCode";
				}else {
					var nodenamelen = nodename.lastIndexOf(':');				
					nodename = nodename.substring(nodenamelen+1,nodename.length);					
					
					parmas = "&devicename="+tsd.encodeURIComponent(nodetype);
					parmas += "&mokuaiju="+tsd.encodeURIComponent(mkj);
					parmas += "&nodename="+tsd.encodeURIComponent(nodename);				
					//parmas += "&dh="+tsd.encodeURIComponent(dh);
					sqlkey = "userLineManager.getNodeUsingByName";
				}			
				
				var res = fetchMultiArrayValue(sqlkey,6,parmas);
				if(res[0]!=undefined && res[0][0]!=undefined)
			  	{
			  		if(res[0][0]=='using'&&res[0][5]!=dh)
			  		{
			  			alert(nodetype+"端口已经被"+res[0][5]+"占用，请重新输入！");
			  			$("#rount_"+i).val("");
			  			//$("#rount_"+i).fouse();.select();.focus();
			  			return false;
			  		}else
			  		{
			  			var deviceno_p = res[0][1]
			  			var len =deviceno_p.lastIndexOf('.');
			  			deviceno_p = deviceno_p.substring(0,len);
			  			$("#rount_"+i).val(res[0][2]+":"+ res[0][3]);
			  			$("#rount_"+i).attr("title", res[0][2]+":"+ res[0][3]);//写入title
   						$("#rount_"+i+ "_h").val(deviceno_p);//写入三级设备编号
   						$("#rount_"+i+ "_s").val( res[0][1]);//写入四级端子编号		
			  		}
			  	}else
			  	{
			  		alert(nodetype+"端口名称错误请确定！");
			  		$("#rount_"+i).val("");
			  		//$("#rount_"+i).fouse();
			  		return false;
			  	}
			 }else
			 {
			 	 $("#rount_"+i+'_s').val('');
			 }
			 //2012-11-5 yhy start
		}
	}
}

/**
* 设置跨模块局号线设置面板的序号下来选框
* @param userid air_users表中的id
* @return
*/
function setZWMkjBJ(userid)
{
	$("#ZWOrder").empty();
	var strbz6='';
	var res = fetchMultiArrayValue("userLineManager.ZW.getDHMKJ",6,"&userid="+userid);
	if(res[0]==undefined || res[0][0]==undefined)
  	{
  		return false;
  	}  	
  	
  	for(var i=0;i<res[0].length;i++){
  		var k=i+1;
  		strbz6+="<option value='"+k+"' mkjvalue='"+res[0][i]+"'>"+k+"</option>";		  		
  	} 	
  		
	$("#ZWOrder").append(strbz6);
	//var limitroute = $("#limitroute").val();
	//$("#ZWOrder option[mkjvalue="+limitroute+"]").attr('selected','selected');
}
/**
* 设置跨模块局号线设置面板的序号下来选框
* @param userid air_users表中的id
* @return
*/
function setZWMkjAdd(userid)
{
	
	$("#ZWOrder").empty();
	//$("#ZWmokuaiju").empty();
	var strbz6='';
	//"<option value=\"\">--请选择--</option>"; 
	var res = fetchMultiArrayValue("userLineManager.ZW.getDHMKJ",6,"&userid="+userid);
	if(res[0]==undefined || res[0][0]==undefined)
  	{
  		return false;
  	}
  	
  	//当前工号可管理模块局，
	var thismkj = $('#thismkj').val();
	var mkjtemp ='';
	if (thismkj != '' && thismkj != null)
    {
    		var mkj =  ","+thismkj.replace(new RegExp("'","g"),"")+",";
    		for(var i=0;i<res[0].length;i++){
		  		var k=i+1;
		  		mkjtemp = ","+res[0][i] + ","; 
		  		if(mkj.indexOf(mkjtemp)!=-1){
		  			strbz6+="<option value='"+k+"' mkjvalue='"+res[0][i]+"'>"+k+"</option>";
		  		}
		  	}
    }
  	
  	//var limitroute = $("#limitroute").val();
	//$("#ZWOrder option[mkjvalue="+limitroute+"]").attr('selected','selected');	
	$("#ZWOrder").append(strbz6);	
	removeMkjUsed(userid);	
}


/**
* 新增面板 移除跨模块局中已经定义过的路由序号
* @param userid air_users表中的id
*   --@param type :used 使序号下来选框中显示为已被使用序号，unused 使序号下来选框中展示的为未被使用的序号
		used在修改号线信息时被调用，unused在新增号线时被调用。
* @return
*/
function removeMkjUsed(userid,type)
{
	var res = fetchMultiArrayValue("userLineManager.ZW.getMKJUsedUid",6,"&userid="+userid);
	if(res[0]==undefined || res[0][0]==undefined)
  	{
  		return ;
  	}
  	for(var i=0;i<res.length;i++){
  		$("#ZWOrder option[value="+res[i][0]+"]").remove();
  	}
}

/**
* 修改面板 显示修改面板路由序号
* @param lineid 
* @return
*/
function AddMkjUsed(lineid)
{
	var res = fetchMultiArrayValue("userLineManager.ZW.getMKJUsedID",6,"&lineid="+lineid);
	if(res[0]==undefined || res[0][0]==undefined)
  	{
  		return ;
  	}
 	$("#ZWOrder").empty();
	var strbz6="";
	//"<option value=\"\">--请选择--</option>"; 	
  	for(var i=0;i<res.length;i++){
  		strbz6+="<option value='"+res[i][0]+"' mkjvalue='"+res[i][1]+"'>"+res[i][0]+"</option>";
  	}
	$("#ZWOrder").append(strbz6);  	 	
}

/**
* 设置跨模块局号线设置面板的模块局
* @param
* @return
*/
function setMkj(){
	var mkjvalue = $("#ZWOrder option:selected").attr("mkjvalue");
	$("#ZWmokuaiju").val(mkjvalue);
}

/*****************************
* 设置模块局下拉框
* @param;
* @return;
******************************/
function ZWprintMokuaiju(){
	$("#ZWmokuaiju").empty();
	var strbz6="<option value=\"\">--请选择--</option>"; 
	var res = fetchMultiArrayValue("userLineManager.ZW.getMKJ",6,"");
	if(res[0]==undefined || res[0][0]==undefined)
  	{
  		return false;
  	}
  	for(var i=0;i<res.length;i++){
  		strbz6+="<option value="+res[i][1]+">"+res[i][1]+"</option>";
  	}
	$("#ZWmokuaiju").append(strbz6);
}

/////////////////////////////////////////////////////////////////////////////////
//////////////////////      ********  并机 ********  /////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/*****************************
* 确定该路由是否允许并机
* @param userid
* @param dh
* @param mokuaiju
* @return;
******************************/
function getBJRight(userid,dh,mokuaiju){

	var params = "&userid="+userid +"&dh="+dh+"&mokuaiju="+tsd.encodeURIComponent(mokuaiju);
	/***
	var res = fetchMultiArrayValue("userLineManager.BJ.getRight",6,params);
	if(res[0]==undefined || res[0][0]==undefined)
  	{
  		alert("该路由无须并机");
  		return false;
  	}
  	*/  	
  	 var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        datatype : 'xml', //返回数据格式 
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        tsdpk : 'userLineManager.BJ.queryBJDH' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        //tsdpkpagesql : tsdpksql//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
    });
    $("#editgrid_BJ" ).setGridParam({
        url : 'mainServlet.html?' + urlstr + params
    }).trigger("reloadGrid");
}


/**
* 显示否允许并机电话信息 jqgrid
* @param
* @return
*/
function showBJJQgrid(){	
	jQuery("#editgrid_BJ").jqGrid({
	        //datatype : 'xml',
	        colNames : ['电话', '用户地址', '模块局','跨模块局','userID','配线设备个数','配线信息','配线序号'],  
	        colModel : [         
	        {
	            name : 'Dh', index : 'Dh', width : 110
	        },	    
	        {
	            name : 'userAddr', index : 'userAddr', width : 160
	        },	        
	        {
	            name : 'MoKuaiJu', index : 'MoKuaiJu'
	        },
	        {
	            name : 'mkjacross', index : 'mkjacross',hidden:true
	        },
	        {
	            name : 'userid', index : 'userid',hidden:true
	        },
	        {
	            name : 'value28', index : 'value28',hidden:true
	        },
	        {
	            name : 'value30', index : 'value30'
	        },
	        {
	            name : 'lineid', index : 'lineid',hidden:true
	        } ],
	        //rowNum : 1, //默认分页行数
	        //rowList : [1, 10, 20], //可选分页行数
	        imgpath : 'plug-in/jquery/jqgrid/themes/basic/images/', 
	        pager : jQuery('#pagered_broad'), 
	        sortname : 'Dh', 
	        //默认排序字段
	        viewrecords : true, 
	        sortorder : 'desc', //默认排序方式 
	        caption : '允许并机电话信息', 
	        //height : 60, //高 
	       // width : document.documentElement.clientWidth - 63,
	       	width : 780,
	        loadComplete : function ()
	        {
	            if ($("#editgrid_BJ tr.jqgrow[id='1']").html() == "") {
	            	alert("该路由无须并机");
	                return false;
	            }
	            autoBlockForm('BJRountform', 5, 'BJRountclose', "#ffffff", false);
	        },
	        onSelectRow: function (ids){
	        	if (ids != null) 
	            {
					//2012-10-31 yhy start 号线并机问题解决 
	                var mkjacross = $("#editgrid_BJ").getCell(ids, "mkjacross");
	                var userid = $("#editgrid_BJ").getCell(ids, "userid"); 
	                var lineid = $("#editgrid_BJ").getCell(ids, "lineid"); 
	                //当前配线的设备个数
	                var devNum = $("#editgrid_BJ").getCell(ids, "value28"); 
	                $("#BJ_mkjacross").val(mkjacross);
	                $("#BJ_userid").val(userid);
	                $("#BJ_EndLineid").val(lineid);	 
	                $("#BJ_DevNum").val(devNum); 
					//2012-10-31 yhy end 号线并机问题解决 
	           }
	        }
	        
	    });	 
 }
/**
* 选择要进行并机的用户信息，进行并机
* @param
* @return
*/
function SelTheBJ(){
	//2012-10-31 yhy start 号线并机问题解决 
	var mkjacross = $("#BJ_mkjacross").val();
	var userid = $("#BJ_userid").val();
	//被复制的号线air_line.lineid
	var lineid = $("#BJ_lineid").val();
	var typeid = $("#BJ_typeid").val();
	var devNum = $("#BJ_DevNum").val(); 
		
	/*
	//1该地址下已有配线信息，是否要用其他地址的配线进行覆盖。
		//1.1.不覆盖需要重新选
		//1.2.覆盖弹出配线面板
	//2.覆盖弹出配线面板
	*/
	//1 |1.1
	if( devNum > 0 ){
		jConfirm("该地址下已有配线信息，是否要用其他地址的配线进行覆盖","确定并线",function(x){
			if( x == true ){
				// 1.2 
				//	mkjacross:1该条路由跨模块局 mkjacross：0该条路由不跨模块局
			 	if(mkjacross==1){
			 			ZWOpenBJPan(lineid,typeid);
				}else{
						OpenBJPan(lineid,typeid);
				}
			}
		});
	}else{
		//2
		if(mkjacross==1){
	 			ZWOpenBJPan(lineid,typeid);
		}else{
				OpenBJPan(lineid,typeid);
		}
	}
	//2012-10-31 yhy end 号线并机问题解决 		
}



