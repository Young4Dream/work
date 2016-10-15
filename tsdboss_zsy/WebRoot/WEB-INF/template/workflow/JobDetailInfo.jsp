<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String lanType = (String) session.getAttribute("languageType");

	String userid = (String) session.getAttribute("userid");
	String groupid = (String) session.getAttribute("groupid");
	String deptname = (String)session.getAttribute("departname");//当前工号所在部门
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>工单详细信息</title>
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="expires" content="0"/>
	
<style type="text/css">
#kddetailInfoform td{line-height:30px}
</style>  
<script type="text/javascript">
function getHxPower(){
	getHxPanel();
	var editabledevice = getLineFields();
	if($("#managepower").val()=='true'){
		//$('#Value1,#Value2,#Value3,#Value4,#Value5,#Value6,#Value7,#Value8,#Value9').removeAttr('disabled');										
		//$('#Value1clear,#Value2clear,#Value2clear,#Value3clear,#Value4clear,#Value5clear,#Value6clear,#Value7clear,#Value8clear,#Value9clear').show();
		$("input[hxdevicetype='text']").removeAttr("disabled");
		$("span[hxdevicetype='link']").show();
	}else{
		if(editabledevice!="")
		{
			editabledevice = editabledevice.replace(/,,/g,",");
			editabledevice = editabledevice.split(",");
			for(var ii=0;ii<editabledevice.length;ii++)
			{
				if(editabledevice[ii]!="")
				{
					$("#" + editabledevice[ii]).removeAttr('disabled');
					$("#"+editabledevice[ii]+"clear").show();
				}
			}
		}
	}
}
			
//获取部门可管理路由设备			
function getLineFields()
{
    var linefields = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'userLineManager.getLineFields'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    var departname = "<%=(String) session.getAttribute("departname")%>";
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&Bm=' + tsd.encodeURIComponent(departname), datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                linefields += $(this).attr("LineFields".toLowerCase());
            });
        }
    });
    var num = linefields.lastIndexOf(',');
    linefields = linefields.substring(0, num);
    return linefields;
}

/**
 * 获取以前备注的信息
 * @param id
 * @return String
 */
function getOldBz(id)
{
    var bz = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdReport', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'teljobmanager.gethxbz'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?id=' + id +'&'+ urlstr + '&tsdtemp=' + Math.random(), datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 5000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                //取不到部门时间则按默认时间计算工单超时时间
                var str = $(this).attr("bz");
                if (str != undefined) {
                    bz = str;
                }
            });
        }
    });
    return bz;
}
/**
 * 数据清空
 * @param ids
 * @return 无返回值
 */
function clearVal(ids){
	$('#'+ids).val('');
}		
/**********************************************************************
function name:    loadData
function:         loadData(tablename,language,index,OperationName),加载页面所需的表的别名信息

parameters:       tablename:表名
                  language:语言标志，英文时为en,中文为zh
                  index:grid所需操作列的位置,1为第一列为操作列，0为最后一列为操作列，2为无操作列
                  OperationName:Grid操作列标题，默认为操作，当OperationName不为空时显示为OperationName
                  
return:           返回一个对象，其中键FieldName为取得的字段名称的数组
                                      FieldAlias为字段别名的数组
                                      DataType为字段数据类型的数组
                                      colNames为操作列和字段别名的数组，用于jqGrid的列标头，即jqGrid的colNames
                                      colModels为操作列和字段的对象数组，用于jqGrid的列信息，即jqGrid的colModel
                                      getFieldAliasByFieldName(fname),根据列名取列别名，无别名时返回"无别名"
                                      setWidth(obj),设置列宽度，obj格式为{列名:宽度},如{id:120}
                                      setHidden(obj),设置隐藏列，obj格式为[列名,列名,列名],如[id1,id2,id3]

description:      加载页面所需的表的别名信息，通用，主要胜于jqGrid的colNames和colModel获取,例:PhoneHuafeiInformation.jsp
**********************************************************************/
function loadData(tablename,language,index,OperationName)
	{
		//语言参数
		if(language==null || language=="" || language!="en")
		{
			language = "zh";
		}
		//修改列位置参数
		if(index==null)
		{
			index = 1;
		}
		var gridData = new Object();
		//取数据集
		var res = fetchMultiArrayValue("main.fetchInfoLimit",6,"&table="+tablename);
		if(typeof res[0]=='undefined')
		{
			//取值失败，返回false;
			return false;
		}
		
		//第2维的长度
		var zidx = res.length;
		//第1维的升序
		var yidx = res[0].length;
		//列别名，用于jqGrid列头显示
		this.colNames = [];
		//列名，用于jqGrid列显示
		this.colModels = [];
		//列名
		this.FieldName = [];
		//列别名
		this.FieldAlias = [];
		//列数据类型
		this.DataType = [];

		this.ShowWidth = [];
		
		this.AliasKeyVal = fetchFieldAlias(tablename,language);
		
		var temp = "";
		
		for(var i=0;i<zidx;i++)
		{
			//列名
			FieldName.push(res[i][0]);
			
			//数据类型
			DataType.push(res[i][2]);

			ShowWidth.push(res[i][3]);

			//获取操作列名字段信息
			temp = getCaption(res[i][1],language,res[i][1]);
			//别名
			FieldAlias.push(temp);
			//
			colNames.push(temp);
			//生成操作列name,index信息
			temp = "{name:'"+ res[i][0] + "',index:'" + res[i][0] + "',width:" + (res[i][3]==undefined?"80":res[i][3]) + "}";
			colModels.push(eval("(" + temp + ")"));
		}		
		//操作列语言及位置设置
		if(language=="zh")
		{
			if(index==1)
			{
				colNames.unshift(OperationName==undefined?"操作":OperationName);
				//设置第一最后一列为操作列
				temp = "{name:'viewOperation',index:'viewOperation',width:100}";
				colModels.unshift(eval("(" + temp + ")"));
			}
			else if(index==0)
			{
				colNames.push(OperationName==undefined?"操作":OperationName);
				//设置最后一列为操作列
				temp = "{name:'viewOperation',index:'viewOperation',width:100}";
				colModels.push(eval("(" + temp + ")"));
			}
			else
			{}
		}
		else
		{
			if(index==1)
			{
				colNames.unshift(OperationName==undefined?"Operation":OperationName);
				//设置第一最后一列为操作列
				temp = "{name:'viewOperation',index:'viewOperation',width:100}";
				colModels.unshift(eval("(" + temp + ")"));
			}
			else if(index==0)
			{
				colNames.push(OperationName==undefined?"Operation":OperationName);
				//设置最后一列为操作列
				temp = "{name:'viewOperation',index:'viewOperation',width:100}";
				colModels.push(eval("(" + temp + ")"));
			}
			else
			{}
		}
		//alert(colNames.length+":"+colModels.length+":"+FieldName.length+":"+FieldAlias.length+":"+DataType.length);
		//alert(colModels.length);	
		gridData.FieldName = FieldName;	
		gridData.FieldAlias = FieldAlias;	
		gridData.DataType = DataType;	
		gridData.colNames = colNames;	
		gridData.colModels = colModels;	
		gridData.AliasKeyVal = AliasKeyVal;
		gridData.ShowWidth = ShowWidth;
		
		//根据字段名取别名
		gridData.getFieldAliasByFieldName=function(fname)
		{/*
			var idx = $.inArray(fname,gridData.FieldName);			
			if(idx==-1)
			{
				return "无列名";
			}
			else
			{
				return gridData.FieldAlias[idx];
			}*/
			return (AliasKeyVal==undefined || AliasKeyVal[fname]==undefined)?"无列名":AliasKeyVal[fname];
		}
		
		//根据字段名设置宽度
		/*gridData.setWidth=function(obj)
		{
			$.each(obj,function(i,n){
				
				var idx = $.inArray(i,gridData.FieldName);				
				
				if(idx!=-1)
				{
					if(index==1)
					{
						idx += 1;
					}
					gridData.colModels[idx].width = n;
				}
			});
		}*/
		
		gridData.setWidth=function(obj)
		{
			$.each(obj,function(i,n){
				
				if(i=="Operation")
				{
					if(index==1)
					{
						gridData.colModels[0].width = n;
					}
					else if(index==0)
					{
						gridData.colModels[zidx].width = n;
					}
					else
					{
						//just do it
					}
				}
				else
				{
					var idx = $.inArray(i,gridData.FieldName);				
					
					if(idx!=-1)
					{
						if(index==1)
						{
							idx += 1;
						}
						gridData.colModels[idx].width = n;
					}
				}
			});
		}
		
		/////设置隐藏
		gridData.setHidden=function(obj)
		{
			$.each(obj,function(i,n){
				
				var idx = $.inArray(n,gridData.FieldName);			
				
				if(idx!=-1)
				{
					if(index==1)
					{
						idx += 1;
					}
					gridData.colModels[idx].hidden = true;
				}
			});
		}
		
		return gridData;
	}
	
	
/**********************************************************************
function name:    fetchParsedFieldAlias
function:         fetchParsedFieldAlias(key,dss,param,key_val),通过SQL语句取回多个值，返回带键值的 N*1 数组

parameters:       key:要请求的的SQL语句在配置文件中的键值
                  dss:数据源编号,0为宽带的 mysql数据源，1-7为固话的sqlServer数据源，具体查看函数identifyDs
                  param为需要的参数,格式为"&param1=value1&param2=value2";
                  lan:语言参数
                  key_val:键值数组,第一列为键名，第二列为值名
                  
return:           能取到值时返回取到的值的多维数据，否则返回没有值的一维数据

description:      通过SQL语句取回多个值，返回带键值的数组，通用
**********************************************************************/
function fetchParsedFieldAlias(key,dss,param,lan,key_val)
{
	var result = new Array();
	var configFile = arguments[5];
	if(configFile==undefined)
	{
		configFile = dss?'mssql':'mysql';
	}
		
		var urlMm = tsd.buildParams({ packgname:'service',
					clsname:'ExecuteSql',//类名
					method:'exeSqlData',//方法名
					ds:identifyDs(dss),
					tsdcf:configFile,//指向配置文件名称
					tsdoper:'query',//操作类型 
					datatype:'xmlattr',//返回数据格式 
					tsdpk:key
					});
		//alert(urlMm +"_"+param);
		$.ajax({
			url:"mainServlet.html?" + urlMm + param,
			async:false,
			cache:false,
			timeout:1000,
			type:'post',
			success:function(xml){
				$(xml).find("row").each(function(){
					var arr_key = $(this).attr(key_val[0].toLowerCase());
					var arr_val = getCaption($(this).attr(key_val[1].toLowerCase()),lan,$(this).attr(key_val[1].toLowerCase()));
					result[arr_key] = arr_val;
					
				});
			}
		});			
		return result;
}


/**********************************************************************
function name:    fetchFieldAlias
function:         fetchFieldAlias(tablename,lan),通过表名和语言标志取别名，返回带键值的 N*1 数组

parameters:       tablename:要取别名的表
                  lan:语言标志
                  
return:           能取到值时返回取到的值的多维数据，否则返回没有值的一维数据

description:      通过表名取字段别名，返回带键值的数组，通用
**********************************************************************/
function fetchFieldAlias(tablename,lan)
{
	var res = fetchParsedFieldAlias("main.fetchInfo",6,"&table="+tablename,lan,["Field_Name","Field_Alias"]);	
	return res;
}
	
/**
 * 初始化显示详细信息的字段
 * @param 无参数
 * @return 无返回值
 */
function thisDetailField()
{
    var column = '';
    var thisdata = loadData('TelJob', '<%=lanType%>', 1);
    column = thisdata.FieldName.join(',');
    //ID,Sgnr,Mqbm,IfCancel,Ydh,Xdh,Nxm,Xm,Sgrq,Jlry,Area,Slbm,Dhlx,IDD,IsPay,Dhgn,BeginYwArea,Bm1,
    //Bm2,Bm3,Bm4,Ydz,Xdz,Wgbm,Yhxz,Ywarea,CardID,IsComplete,jobstatus,Lsh,Lxdh,LinkMan,value1,
    //value2,value3,value4,value5,value6,value7,value8,value9,Bz,Zwbz,YHth,Pgrq,Hth
    $("#thisJobID").html(thisdata.getFieldAliasByFieldName('ID'));
    $("#thisJobType").html(thisdata.getFieldAliasByFieldName('Sgnr'));
    $("#thismqbm").html(thisdata.getFieldAliasByFieldName('Mqbm'));
    $("#thisIfCancel").html(thisdata.getFieldAliasByFieldName('IfCancel'));
    $("#thisjobstatus").html(thisdata.getFieldAliasByFieldName('Ydh'));
    $("#thisUserName").html(thisdata.getFieldAliasByFieldName('Xdh'));
    $("#thisoldsRealName").html(thisdata.getFieldAliasByFieldName('Nxm'));
    $("#thissRealName").html(thisdata.getFieldAliasByFieldName('Xm'));
    $("#thisJobRecTime").html(thisdata.getFieldAliasByFieldName('Sgrq'));
    $("#thisUserID").html(thisdata.getFieldAliasByFieldName('Jlry'));
    $("#thisArea").html(thisdata.getFieldAliasByFieldName('Area'));
    $("#thisDepart").html(thisdata.getFieldAliasByFieldName('Slbm'));
    //$("#thisValue").html(thisdata.getFieldAliasByFieldName('Dhlx'));
    //$("#thisvlanid").html(thisdata.getFieldAliasByFieldName('IDD'));
    $("#thisPayType").html(thisdata.getFieldAliasByFieldName('IsPay'));
    $("#thisiFeeType").html(thisdata.getFieldAliasByFieldName('Dhgn'));
    //$("#thissDh").html(thisdata.getFieldAliasByFieldName('BeginYwArea'));
    //$("#thisValue").html(thisdata.getFieldAliasByFieldName('Dhgn'));
    $("#thissRegDate").html(thisdata.getFieldAliasByFieldName('Bm1'));
    $("#thisfeedendtime").html(thisdata.getFieldAliasByFieldName('Bm2'));
    $("#thisiFeeTypeTime").html(thisdata.getFieldAliasByFieldName('Bm3'));
    $("#thisoldsAddress").html(thisdata.getFieldAliasByFieldName('Bm4'));
    $("#thissAddress").html(thisdata.getFieldAliasByFieldName('Ydz'));
    $("#thisiStatus").html(thisdata.getFieldAliasByFieldName('Xdz'));
    $("#thissDh1").html(thisdata.getFieldAliasByFieldName('Wgbm'));
    $("#thissDh2").html(thisdata.getFieldAliasByFieldName('Yhxz'));
    $("#thisiSimultaneous").html(thisdata.getFieldAliasByFieldName('Ywarea'));
    $("#thisUserName1").html(thisdata.getFieldAliasByFieldName('CardID'));
    $("#thisidtype").html(thisdata.getFieldAliasByFieldName('IsComplete'));
    $("#thisidcard").html(thisdata.getFieldAliasByFieldName('jobstatus'));
    $("#thisoldspeed").html(thisdata.getFieldAliasByFieldName('Lxdh'));
    $("#thisspeed").html(thisdata.getFieldAliasByFieldName('LinkMan'));
    //号线配置信息
    $("#thismobile").html(thisdata.getFieldAliasByFieldName('value1'));
    $("#thislinkphone").html(thisdata.getFieldAliasByFieldName('value2'));
    $("#thislinkman").html(thisdata.getFieldAliasByFieldName('value3'));
    $("#thisFee").html(thisdata.getFieldAliasByFieldName('value4'));
    $("#thisFeeName").html(thisdata.getFieldAliasByFieldName('value5'));
    $("#thissBm").html(thisdata.getFieldAliasByFieldName('value6'));
    $("#thissBm2").html(thisdata.getFieldAliasByFieldName('value7'));
    $("#thissBm3").html(thisdata.getFieldAliasByFieldName('value8'));
    $("#thissBm4").html(thisdata.getFieldAliasByFieldName('value9'));
    $("#thisifurgent").html(thisdata.getFieldAliasByFieldName('Bz'));
    $("#thismemo").html(thisdata.getFieldAliasByFieldName('Zwbz'));
    $("#thisPayMode").html(thisdata.getFieldAliasByFieldName('Hth'));
    $("#thisisPay").html(thisdata.getFieldAliasByFieldName('Pgrq'));
    $("#thisHth").html(thisdata.getFieldAliasByFieldName('value15'));
    $("#thisdevno").html(thisdata.getFieldAliasByFieldName('Lsh'));
    $("#thisjobstate").html(thisdata.getFieldAliasByFieldName('dJhwcsj'));
    $("#thisValue4").html(thisdata.getFieldAliasByFieldName('value4'));//电话属性
    $("#thisValue5").html(thisdata.getFieldAliasByFieldName('value5'));//专（光）线路
    $("#thisValue3").html(thisdata.getFieldAliasByFieldName('value3'));//区域端点
    $("#thisValue6").html(thisdata.getFieldAliasByFieldName('value6'));//设备数量
    $("#thisValue7").html(thisdata.getFieldAliasByFieldName('value7'));//公里数
}
/**
 * 双击显示详细信息
 * @param jobid
 * @param mqbm
 * @param key
 * @return 无返回值
 */
function thisInfo(jobid, mqbm, key)
{
	getHxPower();
	thisDetailField();
    clearText('detailInfoform');
    
    ///设置命令参数
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdReport', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'teljob.querydetail' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    //提交之后才可处理
    if (key == 1)
    {
        $(".hx_tr").hide();
        $('#submithxinfo').hide();
    }
    else if (key == 2)
    {
        $(".hx_tr").show();
        $('#submithxinfo').show();
    }
    else if (key == 3)
    {
        $(".hx_tr").show();
        $('#submithxinfo').hide();
    }
    $.ajax(
    {
        url : 'mainServlet.html?jobid=' + jobid +'&'+ urlstr + '&tsdtemp=' + Math.random(), datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 5000, async : false , //同步方式
        error:function(x){alert(x);},
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var tmp_id = $(this).attr('id'.toLowerCase());
                if (tmp_id != undefined)
                {
                    $("#thisJobIDvalue").html(tmp_id);
                    var tmp_Sgnr = $(this).attr('sgnr'.toLowerCase());
                    if (tmp_Sgnr == null || tmp_Sgnr == undefined) {
                        tmp_Sgnr = '';
                    }
                    if (tmp_Sgnr != '' && tmp_Sgnr != undefined)
                    {
                        tmp_Sgnr = getTrueValue('tsdBilling', 'ywsl_code', 'showname', 'ywlx', tmp_Sgnr, 
                        '1', '1');
                    }
                    $("#thisJobTypevalue").html(tmp_Sgnr);
                    //var tmp_Mqbm = $(this).attr('Mqbm');
                    //if(tmp_Mqbm=='null'||tmp_Mqbm==undefined){
                    // tmp_Mqbm = '';
                    //}
                    $("#thismqbmvalue").html(mqbm);
                    $("span[id^='hd_cell_']").removeClass("necessarydevice");
                    var exenext =  execJob('JobBeforeSend',"&jobid=" + jobid  + "&senddepart=" + encodeURIComponent(mqbm)+ "&func=getfield&sender=<%=session.getAttribute("userid")%>"+ "&jobtype=" + tsd.encodeURIComponent($("#ywlx").val()));
                    if(exenext[1]!="" && exenext[1]!=undefined && exenext[1]!="")
                    {
                    	var fields = exenext[1].split(",");
                    	for(var ki=0;ki<fields.length;ki++)
                    	{
                    		$("#hd_cell_" + fields[ki]).addClass("necessarydevice");
                    	}
                    	/*
                    	if(fields.length>0)
                    		$('#submithxinfo').show();
                    	else
                    		$('#submithxinfo').hide();
                    		*/
                    	if(key==2)	
                    		$('#submithxinfo').show();
                    }
                    else
                    {
                    	// $('#submithxinfo').hide();
                    	if(key==2)
                    		$('#submithxinfo').show();
                    }


                    var tmp_IfCancel = $(this).attr('IfCancel'.toLowerCase());
                    //是否撤销
                    if (tmp_IfCancel == 'null' || tmp_IfCancel == undefined) {
                        tmp_IfCancel = '';
                    }
                    else if (tmp_IfCancel == 0) {
                        tmp_IfCancel = '否';
                    }
                    else if (tmp_IfCancel == 1) {
                        tmp_IfCancel = '是';
                    }
                    $("#thisIfCancelvalue").html(tmp_IfCancel);
                    var tmp_Ydh = $(this).attr('Ydh'.toLowerCase());
                    if (tmp_Ydh == 'null' || tmp_Ydh == undefined) {
                        tmp_Ydh = '';
                    }
                    $("#thisjobstatusvalue").html(tmp_Ydh);
                    var tmp_Xdh = $(this).attr('Xdh'.toLowerCase());
                    if (tmp_Xdh == 'null' || tmp_Xdh == undefined) {
                        tmp_Xdh = '';
                    }
                    $("#thisUserNamevalue").html(tmp_Xdh);
                    var tmp_Nxm = $(this).attr('Nxm'.toLowerCase());
                    if (tmp_Nxm == 'null' || tmp_Nxm == undefined) {
                        tmp_Nxm = '';
                    }
                    $("#thisoldsRealNamevalue").html(tmp_Nxm);
                    var tmp_xm = $(this).attr('Xm'.toLowerCase());
                    if (tmp_xm == 'null' || tmp_xm == undefined) {
                        tmp_xm = '';
                    }
                    $("#thissRealNamevalue").html(tmp_xm);
                    var sgrq = $(this).attr('Sgrq'.toLowerCase());
                    if (sgrq == 'null' || sgrq == undefined) {
                        sgrq = '';
                    }
                    else {
                        sgrq = sgrq.substring(0, 19);
                    }
                    $("#thisJobRecTimevalue").html(sgrq);
                    var theuserid = $(this).attr('Jlry'.toLowerCase());
                    var xuseriddd = theuserid;
                    if (theuserid != '' && theuserid != undefined)
                    {
                        theuserid = getTrueValue('tsdBilling', 'sys_user', 'username', 'userid', theuserid, 
                        '1', '1');
                    }
                    else {
                        theuserid = '';
                    }
                    $("#thisUserIDvalue").html(theuserid + "(" + xuseriddd + ")");
                    var tmp_Area = $(this).attr('Area'.toLowerCase());
                    if (tmp_Area == 'null' || tmp_Area == undefined) {
                        tmp_Area = '';
                    }
                    $("#thisAreavalue").html(tmp_Area);
                    var tmp_Slbm = $(this).attr('Slbm'.toLowerCase());
                    if (tmp_Slbm == 'null' || tmp_Slbm == undefined) {
                        tmp_Slbm = '';
                    }
                    $("#thisDepartvalue").html(tmp_Slbm);
                    //var tmp_Dhlx = $(this).attr('Dhlx');
                    //if(tmp_Dhlx=='null'||tmp_Dhlx==undefined){
                    // tmp_Dhlx = '';
                    //}
                    //$("#thisValuevalue").html(tmp_Dhlx);
                    //var tmp_IDD = $(this).attr('IDD');
                    //if(tmp_IDD=='null'||tmp_IDD==undefined){
                    // tmp_IDD = '';
                    //}
                    //$("#thisvlanidvalue").html(tmp_IDD);
                    var ispay = $(this).attr('ispay'.toLowerCase());
                    if (ispay == 'cash') {
                        ispay = '现金';
                         
                    }
                    else if (ispay == 'transfer') {
                        ispay = '转账';
                    }
                    else {
                        ispay = '';
                    }
                    $("#thisPayTypevalue").html(ispay);
                    //var tmp_Dhgn = $(this).attr('Dhgn');
                    //if(tmp_Dhgn=='null'||tmp_Dhgn==undefined){
                    // tmp_Dhgn = '';
                    //}
                    //$("#thisiFeeTypevalue").html(tmp_Dhgn);
                    //var tmp_BeginYwArea = $(this).attr('BeginYwArea');
                    //if(tmp_BeginYwArea=='null'||tmp_BeginYwArea==undefined){
                    // tmp_BeginYwArea = '';
                    //}
                    //$("#thissDhvalue").html(tmp_BeginYwArea);
                    //$("#thisValue").html($(this).attr('Dhgn'));
                    var tmp_Bm1 = $(this).attr('Bm1'.toLowerCase());
                    if (tmp_Bm1 == 'null' || tmp_Bm1 == undefined) {
                        tmp_Bm1 = '';
                    }
                    var tmp_Bm2 = $(this).attr('Bm2'.toLowerCase());
                    if (tmp_Bm2 == 'null' || tmp_Bm2 == undefined) {
                        tmp_Bm2 = '';
                    }
                    var tmp_Bm3 = $(this).attr('Bm3'.toLowerCase());
                    if (tmp_Bm3 == 'null' || tmp_Bm3 == undefined) {
                        tmp_Bm3 = '';
                    }
                    var tmp_Bm4 = $(this).attr('Bm4'.toLowerCase());
                    if (tmp_Bm4 == 'null' || tmp_Bm4 == undefined) {
                        tmp_Bm4 = '';
                    }
                    $("#thissRegDatevalue").html(tmp_Bm1);
                    $("#thisfeedendtimevalue").html(tmp_Bm2);
                    $("#thisiFeeTypeTimevalue").html(tmp_Bm3);
                    $("#thisoldsAddressvalue").html(tmp_Bm4);
                    var tmp_Ydz = $(this).attr('Ydz'.toLowerCase());
                    if (tmp_Ydz == 'null' || tmp_Ydz == undefined) {
                        tmp_Ydz = '';
                    }
                    $("#thissAddressvalue").html(tmp_Ydz);
                    var tmp_Xdz = $(this).attr('Xdz'.toLowerCase());
                    if (tmp_Xdz == 'null' || tmp_Xdz == undefined) {
                        tmp_Xdz = '';
                    }
                    $("#thisiStatusvalue").html(tmp_Xdz);
                    var tmp_Wgbm = $(this).attr('Wgbm'.toLowerCase());
                    if (tmp_Wgbm == 'null' || tmp_Wgbm == undefined) {
                        tmp_Wgbm = '';
                    }
                    $("#thissDh1value").html(tmp_Wgbm);
                    var tmp_Yhxz = $(this).attr('Yhxz'.toLowerCase());
                    if (tmp_Yhxz == 'null' || tmp_Yhxz == undefined) {
                        tmp_Yhxz = '';
                    }
                    $("#thissDh2value").html(tmp_Yhxz);
                    var tmp_Ywarea = $(this).attr('Ywarea'.toLowerCase());
                    if (tmp_Ywarea == 'null' || tmp_Ywarea == undefined) {
                        tmp_Ywarea = '';
                    }
                    $("#thisiSimultaneousvalue").html(tmp_Ywarea);
                    var tmp_CardID = $(this).attr('CardID'.toLowerCase());
                    if (tmp_CardID == 'null' || tmp_CardID == undefined) {
                        tmp_CardID = '';
                    }
                    $("#thisUserName1value").html(tmp_CardID);
                    var tmp_Value5 = $(this).attr('value5'.toLowerCase());
                    if (tmp_Value5 == 'null' || tmp_Value5 == undefined) {
                        tmp_Value5 = '';
                    }
                    $("#thisValue5value").html(tmp_Value5);
                    var tmp_Value4 = $(this).attr('value4'.toLowerCase());
                    if (tmp_Value4 == 'null' || tmp_Value4 == undefined) {
                        tmp_Value4 = '';
                    }
                    $("#thisValue4value").html(tmp_Value4);
                    var tmp_Value3 = $(this).attr('value3'.toLowerCase());
                    if (tmp_Value3 == 'null' || tmp_Value3 == undefined) {
                        tmp_Value3 = '';
                    }
                    $("#thisValue3value").html(tmp_Value3);
                    var tmp_Value6 = $(this).attr('value6'.toLowerCase());
                    if (tmp_Value6 == 'null' || tmp_Value6 == undefined) {
                        tmp_Value6 = '';
                    }
                    $("#thisValue6value").html(tmp_Value6);
                    var tmp_Value7 = $(this).attr('value7'.toLowerCase());
                    if (tmp_Value7 == 'null' || tmp_Value7 == undefined) {
                        tmp_Value7 = '';
                    }
                    $("#thisValue7value").html(tmp_Value7);
                    var tmp_IsComplete = $(this).attr('IsComplete'.toLowerCase());
                    if (tmp_IsComplete == 'null' || tmp_IsComplete == undefined) {
                        tmp_IsComplete = '';
                    }
                    if(tmp_IsComplete=="Y")
                    	tmp_IsComplete = "是";
                    else if(tmp_IsComplete=="N")
                    	tmp_IsComplete = "否";
                    	
                    $("#thisidtypevalue").html(tmp_IsComplete);
                    var thejobstatus = $(this).attr('jobstatus');
                    if (thejobstatus != '' && thejobstatus != undefined)
                    {
                        thejobstatus = getTrueValue('tsdBilling', 'tsd_Ini', 'TIDent', 'TValues', thejobstatus, 
                        'TSection', 'canacceptjobtype');
                    }
                    if (thejobstatus == undefined) {
                        thejobstatus = '';
                    }
                    $("#thisidcardvalue").html(thejobstatus);
                    var tmp_Lsh = $(this).attr('Lsh'.toLowerCase());
                    if (tmp_Lsh == 'null' || tmp_Lsh == undefined) {
                        tmp_Lsh = '';
                    }
                    $("#thisdevnovalue").html(tmp_Lsh);
                    var tmp_Lxdh = $(this).attr('Lxdh'.toLowerCase());
                    if (tmp_Lxdh == 'null' || tmp_Lxdh == undefined) {
                        tmp_Lxdh = '';
                    }
                    $("#thisoldspeedvalue").html(tmp_Lxdh);
                    var tmp_LinkMan = $(this).attr('LinkMan'.toLowerCase());
                    if (tmp_LinkMan == 'null' || tmp_LinkMan == undefined) {
                        tmp_LinkMan = '';
                    }
                    $("#thisspeedvalue").html(tmp_LinkMan);
                    
                    //获取号线资料信息
                    var datatmp = $(this);
                    $("span[id^='hd_cell_']").each(function(){
                    	var idd = $(this).attr("id");
                    	idd = idd.replace("hd_cell_","");
                    	var tmpp = $(datatmp).attr(idd.toLowerCase());
                    	if(tmpp=="null" || tmpp==undefined)
                    		tmpp = "";
                    	$("#" + idd).val(tmpp);
                    });
                    datatmp = null;
                    
                    var tmp_Bz = $(this).attr('Bz'.toLowerCase());
                    if (tmp_Bz == 'null' || tmp_Bz == undefined) {
                        tmp_Bz = '';
                    }
                    //alert(tmp_Bz);
                    $("#thisifurgentvalue").html(tmp_Bz);
                    var tmp_Zwbz = $(this).attr('Zwbz'.toLowerCase());
                    if (tmp_Zwbz == 'null' || tmp_Zwbz == undefined) {
                        tmp_Zwbz = '';
                    }
                    $("#thismemovalue").html(tmp_Zwbz);
                    var tmp_YHth = $(this).attr('hth');
                    if (tmp_YHth == 'null' || tmp_YHth == undefined) {
                        tmp_YHth = '';
                    }
                    $("#thisPayModevalue").html(tmp_YHth);
                    var tmp_Pgrq = $(this).attr('Pgrq'.toLowerCase());
                    if (tmp_Pgrq == 'null' || tmp_Pgrq == undefined) {
                        tmp_Pgrq = '';
                    }
                    else {
                        tmp_Pgrq = tmp_Pgrq.substring(0, 19);
                    }
                    $("#thisisPayvalue").html(tmp_Pgrq);
                    var tmp_Hth = $(this).attr('Hth'.toLowerCase());
                    if (tmp_Hth == 'null' || tmp_Hth == undefined) {
                        tmp_Hth = '';
                    }
                    $("#thisHthvalue").html(tmp_Hth);
                    var tmp_JobState = $(this).attr('dJhwcsj'.toLowerCase());
                    if (tmp_JobState == 'null' || tmp_JobState == undefined) {
                        tmp_JobState = '';
                    }
                    else {
                        tmp_JobState = tmp_JobState.substring(0, 19);
                    }
                    $("#thisjobstatevalue").html(tmp_JobState);
                    
                    //用户电缆
                    //$("#thisiFeeTypevalue").html(tmp_Dhgn);//thisnewyw
                    //alert(tmp_Xdh);
                    //$('#thisiFeeTypevalue').html(getDhgn(tmp_Xdh));
                    $('#thisiFeeTypevalue').html($(this).attr('Dhgn'.toLowerCase()));
					var value19 = $(this).attr('value19');
					var array=[];
					if(value19!=undefined&&value19!=""){
						array=value19.split('|');
						$('#thisnewyw').html(array[1]);
					    $("#thisyz").html(array[0]);
					}					                    
                }
            });
        }
    });
    
    
    var urlstr1 = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdReport', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'teljobmanager.getlineinfo' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });

    $.ajax(
    {
        url : 'mainServlet.html?id=' + jobid +'&'+ urlstr1 + '&tsdtemp=' + Math.random(), datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 5000, async : false , //同步方式
        error:function(x){alert(x);},
        success : function (xml)
        {
            $(xml).find('row:first').each(function()
            {
            	var xmldata = $(this);
            	$("span[id^='hd_cell_']").each(function(){
            		var idd = $(this).attr("id").replace("hd_cell_","");
            		$("#" + idd).val($(xmldata).attr(idd.toLowerCase()));
            		$("#" + idd).attr("predata",$(xmldata).attr(idd.toLowerCase()));
            	});
            	$('#hxbz').val($(xmldata).attr("Bz".toLowerCase()));
            	xmldata = null;
            });
        }
    });
    autoBlockForm('detailInfo', 20, 'detailinfoclose', "#ffffff", false);
    //弹出查询面板  
}
/**
 * 获取选择值的真实值
 * @param ds
 * @param tablename
 * @param code
 * @param thelimit
 * @param limitvalue
 * @param theif
 * @param theend
 * @return String
 */
function getTrueValue(ds, tablename, code, thelimit, limitvalue, theif, theend)
{
    var realvalue = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : ds, //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mysql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'broadbandjob.querytruevalue' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    if (limitvalue == '' || null == limitvalue) {
        limitvalue = 1;
        thelimit = 1;
    }
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + '&tablename=' + tablename + '&code=' + code + '&thelimit=' + thelimit + '&theif=' + theif + '&theend=' + theend + '&limitvalue=' + limitvalue + '&tsdtemp=' + Math.random(), 
        datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                if (realvalue != undefined) {
                    realvalue = $(this).attr(code.toLowerCase());
                    //是否已接收          
                }
            });
        }
    });
    return realvalue;
}

function addLineInfo()
{
    //电话号码，需进行数据验证
    var xdh = $('#thisUserNamevalue').text();
    var mqbm = $("#thismqbmvalue").text();
    var params = '&Dh=' + xdh;
    var params_cols = "";
    var params_vals = "";
    var params_colsvals = "";
    //用户电话
    var count = getHxCount(xdh);
    //是否已填号线信息
    var sql = '';
    //号线表
    var sql2 = '';
    //工单表
    var hxbz = $('#hxbz').val();
    var ids = $('#thisJobIDvalue').text();
    var oldbz = getOldBz(ids);
    hxbz = hxbz;// + ';' + oldbz;
    
    var hxctrl = $("span[id^='hd_cell_'].necessarydevice");
    var flag__ = true;
    $(hxctrl).each(function(){
    	if(flag__)
    	{
	    	var did = $(this).attr("id").replace("hd_cell_","");
	    	var dval = $.trim($("#" + did).val());
	    	if(dval=="")
	    	{
	    		alert($(this).text() + '信息不允许为空，请填写'+$(this).text()+'信息!');
	    		flag__ = false;
	    		return;
	    	}else
	    	{
	    		params += "&"+did+"=" + tsd.encodeURIComponent(dval);
	    		params_cols += "," + encodeURIComponent(did);
	    		params_vals += ",'" + encodeURIComponent(dval) + "'";
	    		params_colsvals += "," + encodeURIComponent(did + "='" + dval + "'");
	    	}
    	}
    });
    hxctrl = $("span[id^='hd_cell_']").not($("span[id^='hd_cell_'].necessarydevice"));
    
    $(hxctrl).each(function(){
    	if(flag__)
    	{
	    	var did = $(this).attr("id").replace("hd_cell_","");
	    	var dval = $.trim($("#" + did).val());
	    	
    		params += "&"+did+"=" + tsd.encodeURIComponent(dval);
    		params_cols += "," + encodeURIComponent(did);
    		params_vals += ",'" + encodeURIComponent(dval) + "'";
    		params_colsvals += "," + encodeURIComponent(did + "='" + dval + "'");
	    	
    	}
    });
	if(!flag__) return;
	
    if(count>0)
    {
    	if(params_colsvals.replace(",","")=="")
    	{
    		$('#detailinfoclose').click();
    		return;
    	}
    	sql = "teljobmanager.updatehxinfo";
    	var res = executeNoQuery(sql,6,"&colsvals=" + params_colsvals.replace(",","") + ",Bz='" + tsd.encodeURIComponent(hxbz) + "'&dh=" + xdh);
    	if(res=="true" || res==true)
    	{
    		updateHxDeviceState(xdh);
    		//去除更新teljob表号线备注 2011-04-18
    		//updateTelJobLineinfo("&colsvals=" + params_colsvals.replace(",","") + "&id=" + ids + "&Zwbz=" + tsd.encodeURIComponent(hxbz), "teljobmanager.updateteljobhxinfo");
			//同步更新电话工单的号线
            alert("成功保存号线资料");
            $('#detailinfoclose').click();
    	}
    	else
    	{
    		alert("未知原因的系统错误");
    	}
    }
    else
    {
    	if(params_cols.replace(",","")=="")
    	{
    		$('#detailinfoclose').click();
    		return;
    	}
    	sql = "teljobmanager.addhxinfo";
    	var res = executeNoQuery(sql,6,"&cols=" + params_cols.replace(",","")+",Bz" + "&vals=" + params_vals.replace(",","")+",'" + tsd.encodeURIComponent(hxbz) + "'&dh=" + xdh);
    	if(res=="true" || res==true)
    	{
    		updateHxDeviceState(xdh);
    		//去除更新teljob表号线备注 2011-04-18
    		//updateTelJobLineinfo("&colsvals=" + params_colsvals.replace(",","") + "&id=" + ids + "&Zwbz=" + tsd.encodeURIComponent(hxbz), "teljobmanager.updateteljobhxinfo");
			//同步更新电话工单的号线
            alert("成功保存号线资料");
            $('#detailinfoclose').click();
    	}
    	else
    	{
    		alert("未知原因的系统错误");
    	}
    }
}
//更新号线状态
function updateHxDeviceState(Dh)
{
	var hxctrl = $("span[id^='hd_cell_']");
	var statefreectl = "";
	var stateusingctl = "";
	$(hxctrl).each(function(){
		var did = $(this).attr("id").replace("hd_cell_","");
	    var dval = $.trim($("#" + did).val());
	    var dpre = $("#" + did).attr("predata");
	    if(dval!=dpre)
	    {
	    	if(dpre!="")
	    		statefreectl += ",'" + dpre + "'";
	    	if(dval!="")
	    		stateusingctl += ",'" + dval + "'";
	    }
	});
	statefreectl = statefreectl.replace(",","");
	stateusingctl = stateusingctl.replace(",","");
	if(statefreectl!=''){
		executeNoQuery("userLineManager.gxnodtstate",6,"&nodestate=free&nodenamelist=" + encodeURIComponent(statefreectl) + "&dh=" + encodeURIComponent(Dh));	
	}
	if(stateusingctl!=''){
		executeNoQuery("userLineManager.gxnodtstate",6,"&nodestate=using&nodenamelist=" + encodeURIComponent(stateusingctl) + "&dh=" + encodeURIComponent(Dh));
	}
}

/**
 * 执行sql语句，更新号线表数据
 * @param params
 * @param sql
 * @param sql2
 * @return 无返回值
 */
function exeSql(params, sql, sql2)
{
    var urlstr = tsd.buildParams( 
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : sql//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    urlstr += params;
    $.ajax( 
    {
        url : 'mainServlet.html?ian=1' +'&'+ urlstr, cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (msg) 
        {
            if (msg == "true") 
            {
                updateTelJobLineinfo(params, sql2);
                //同步更新电话工单的号线
                alert('操作成功!');
                $('#detailinfoclose').click();
            }
        }
    });
}
/**
 * 更新工单表号线信息
 * @param params
 * @param sql
 * @return 无返回值
 */
function updateTelJobLineinfo(params, sql)
{
    var urlstr = tsd.buildParams( 
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdReport', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'exe', //操作类型 
        tsdpk : sql//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    urlstr += params;
    $.ajax( 
    {
        url : 'mainServlet.html?ian=1' +'&'+ urlstr, cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (msg) 
        {
            if (msg == "true") {}
        }
    });
}
/**
 * 获取用户的模块局
 * @param xdh
 * @return int
 */
function getHxCount(xdh)
{
    var count = 0;
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'teljobmanager.gethxcount'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?dh=' + xdh +'&'+ urlstr + '&tsdtemp=' + Math.random(), datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 5000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                //取不到部门时间则按默认时间计算工单超时时间
                var res = $(this).attr("res");
                if (res != undefined) {
                    count = res;
                }
            });
        }
    });
    return count;
}

function execJob(ids,param){
			var params = '';
			if(param!=undefined) params = param;
			
			var flag = ["0",""];
			var urlstr=tsd.buildParams({ 	  packgname:'service',
							 				  clsname:'Procedure',
											  method:'exequery',
							 				  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
							 				  tsdpname:'teljobmanager.'+ids,//存储过程的映射名称
							 				  tsdExeType:'query',
							 				  datatype:'xmlattr'
						 			 	});
			
			$.ajax({
				url:'mainServlet.html?ian=1&'+urlstr+params,
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 2000,
				async: false ,//同步方式
				success:function(xml){
					$(xml).find('row').each(function(){
						var res = $(this).attr("res");
						var resmeg = $(this).attr("resmsg");
						flag = [res,resmeg];
					});
				}
			});
			return flag;
		}
/**
 * 获取用户的电话功能信息
 * @param dh
 * @return String
 */
function getDhgn(dh)
{
    var res = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'teljobmanager.getuserdhgn'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?dh=' + dh +'&'+ urlstr + '&tsdtemp=' + Math.random(), datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 5000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                //取不到部门时间则按默认时间计算工单超时时间
                var str = $(this).attr("bz");
                if (str != undefined) {
                    res = str;
                }
            });
        }
    });
    return res;
}

/**
 * 获取用户新业务信息
 * @param dh
 * @return String
 */
function getNewYw(dh)
{
    var res = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'teljobmanager.getusernewyw'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?dh=' + dh +'&'+ urlstr + '&tsdtemp=' + Math.random(), datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 5000, async : false , //同步方式
        success : function (xml)
        {
            var infos = '';
            $(xml).find('row').each(function ()
            {
                //取不到部门时间则按默认时间计算工单超时时间
                var str = $(this).attr("FeeType".toLowerCase());
                if (str != undefined) {
                    infos += str + ',';
                }
            });
            infos = infos.substring(0, infos.lastIndexOf(','));
            res = infos;
        }
    });
    return res;
}

function getTelJobYwlx()
{
	var res = fetchMultiArrayValue("teljobmanager.getywlx",6,"");
	var tabHtml = "";
	var ywlxlet = '<li><a href="#" id="teljob_tab_{类型}" onclick="isLoading(\'teljob_tab_{类型}\',\'{类型}\',\'{类型}\');" title="{类型}"><b>电话{类型显示}(<span id=\'teljob_tab_span_{类型}\'></span>)</b></a></li>';
	for(var ii=0;ii<res.length;ii++)
	{
		tabHtml += ywlxlet.replace(/{类型}/g,res[ii][0]).replace(/{类型显示}/g,res[ii][1]);
	}
	$("#menu").html(tabHtml);
	if(res[0]!=undefined && res[0][0]!=undefined)
	{
		$("#menu").data("ywlx",res);
	}
}

function getHxPanel()
{
	var allhx = fetchMultiArrayValue("teljobmanager.gethx",6,"");
	var ii = 0;
	var tabCellHtml = "<td class=\"labelclass\"><label for=\"hd_cell_{FieldName}\">" + 
									"<span id=\"hd_cell_{FieldName}\">{DeviceName}</span>" + 
								"</label>" + 
							"</td>" + 
							"<td width=\"20%\" class=\"tdstyle\">" + 
								"<input type=\"text\" id=\"{FieldName}\" onfocus=\"getDeviceType('{FieldName}')\" " + 
									"style=\"width: 125px\" hxdevicetype=\"text\" class=\"textclass\" disabled=\"disabled\" />" + 
								"<span style=\"display:none\" hxdevicetype=\"link\" id=\"{FieldName}clear\"><a href=\"javascript:clearVal('{FieldName}')\">清空</a></span>" + 
							"</td>";
	var tabHtml = "";
	for(ii = 0;ii<allhx.length;ii++)
	{
		if((ii+1)%3==1)
			tabHtml += "</tr><tr class=\"hx_tr ahref\">";
			
		tabHtml += 	tabCellHtml.replace(/{FieldName}/g,allhx[ii][1]).replace(/{DeviceName}/g,allhx[ii][0]);
	}
	if(ii%3!=0)
	{
		var kk = ii%3;
		while(kk<3)
		{
			tabHtml += "<td class=\"labelclass\"></td><td width=\"20%\" class=\"tdstyle\"></td>";
			kk++;
		}
		tabHtml += "</tr>";
	}
	tabHtml = tabHtml.replace("</tr>","");
	//alert(tabHtml);
	$(".ahref:gt(0)").remove();
	$(".ahref").replaceWith(tabHtml);
}

/**
 * 获取用户的模块局
 * @param xdh
 * @return String
 */
function getMkjs(xdh)
{
    var mkj = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'teljobmanager.getusermkjs'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?dh=' + xdh +'&'+ urlstr + '&tsdtemp=' + Math.random(), datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 5000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                //取不到部门时间则按默认时间计算工单超时时间
                var str = $(this).attr("MokuaiJu".toLowerCase());
                if (str != undefined) {
                    mkj = str;
                }
            });
        }
    });
    return mkj;
}
/**
 * 获取设备类型和端口号
 * @param NodeField
 * @return 无返回值
 */
function getDeviceType(NodeField)
{
    //电话号码
    var xdh = $('#thisUserNamevalue').text();
    var mkj = getMkjs(xdh);
    if (mkj == '') {
        alert('用户【' + xdh + '】的用户档数据不完整，请填写完整用户基本信息!');
        $("#hxbz").focus();
        //注：此处判断的依据是MoKuaiju字段的数据
        return;
    }else{
    	window.showModalDialog('mainServlet.html?pagename=telephone/linemanagement/theDeviceType.jsp&NodeField=' + NodeField + '&mkj=' + tsd.encodeURIComponent(mkj), 
    		window, "dialogWidth:820px; dialogHeight:450px; center:yes; scroll:yes");
    }
}
/**
 * 方法回调
 * @param thei
 * @param str
 * @return 无返回值
 */
function getTheVlaue(thei, str)
{
    $('#' + thei).val(str);
}
//查询故障详细信息

function thisFaInfo(jobid){
	var jobtype=fetchSingleValue('WorkFlow.queryjobtype',6,'&jobid='+jobid);
	var res;
	var lineinfo='n';
	if(jobtype='112fault'){
		$("#div_112fault").css('display','block');
		$("#div_radfault").css('display','none');
		res=fetchMultiArrayValue('WorkFlow.queryFa112DetailInfo',6,'&jobid='+jobid);
		if(res=="undefined" || res=="" || res[0][0]=="undefined"|| res[0][0]==""){
			res=fetchMultiArrayValue('WorkFlow.queryOutFa112DetailInfo',6,'&jobid='+jobid);
		}else{
			getRouteMX(res[0][0],jobid,'dh','y');
			lineinfo='y';
		}
		$("#112fault1").text(res[0][0]);
		$("#112fault2").text(res[0][1]);
		$("#112fault3").text(res[0][2]);
		$("#112fault4").text(res[0][3]);
		$("#112fault5").text(res[0][4]);
		$("#112fault6").text(res[0][5]);
		$("#112fault7").text(res[0][6]);
		$("#112fault8").text(res[0][7]);
		$("#112fault9").text(res[0][8]);
		$("#112fault10").text(res[0][9]);
		$("#112fault11").text(res[0][10]);
		$("#112fault12").text(res[0][11]);
	}else if(jobtype='radfault'){
		$("#div_radfault").css('display','block');
		$("#div_112fault").css('display','none');
		res=fetchMultiArrayValue('WorkFlow.queryFaRadDetailInfo',6,'&jobid='+jobid);
		if(res=="undefined" || res=="" || res[0][0]=="undefined"|| res[0][0]==""){
			res=fetchMultiArrayValue('WorkFlow.queryOutFaRadDetailInfo',6,'&jobid='+jobid);
		}else{
			getRouteMX(res[0][0],jobid,'kd','y');
			lineinfo='y';
		}
		$("#radfault1").text(res[0][1]);
		$("#radfault2").text(res[0][2]);
		$("#radfault3").text(res[0][3]);
		$("#radfault4").text(res[0][4]);
		$("#radfault5").text(res[0][5]);
		$("#radfault6").text(res[0][6]);
		$("#radfault7").text(res[0][7]);
		$("#radfault8").text(res[0][8]);
		$("#radfault9").text(res[0][9]);
		$("#radfault10").text(res[0][10]);
		$("#radfault11").text(res[0][11]);
		$("#radfault12").text(res[0][12]);
		$("#radfault13").text(res[0][13]);
	}else if(jobtype='tvfault'){
		$("#div_radfault").css('display','none');
		$("#div_112fault").css('display','none');
		$("#div_tvfault").css('display','block');
		res=fetchMultiArrayValue('WorkFlow.queryOutFaTvDetailInfo',6,'&jobid='+jobid);
		$("#tvfault1").text(res[0][1]);
		$("#tvfault2").text(res[0][2]);
		$("#tvfault3").text(res[0][3]);
		$("#tvfault4").text(res[0][4]);
		$("#tvfault5").text(res[0][5]);
		$("#tvfault6").text(res[0][6]);
		$("#tvfault7").text(res[0][7]);
		$("#tvfault8").text(res[0][8]);
		$("#tvfault9").text(res[0][9]);
		$("#tvfault10").text(res[0][10]);
		$("#tvfault11").text(res[0][11]);
		$("#tvfault12").text(res[0][12]);
		$("#tvfault13").text(res[0][13]);
	}
	alert(lineinfo);
	if(lineinfo=='n'){
		//号线信息
		$("#div_lineinfo").css('display','block');
		$("#div_lineinfo1").css('display','none');
		$("#lineinfo1").text(res[0][14]);
		$("#lineinfo2").text(res[0][15]);
		$("#lineinfo3").text(res[0][16]);
		$("#lineinfo4").text(res[0][17]);
		$("#lineinfo5").text(res[0][18]);
		$("#lineinfo6").text(res[0][19]);
		$("#lineinfo7").text(res[0][20]);
		$("#lineinfo8").text(res[0][21]);
		$("#lineinfo9").text(res[0][22]);
		$("#lineinfo10").text(res[0][23]);
		$("#lineinfo11").text(res[0][24]);
		$("#lineinfo12").text(res[0][25]);
		$("#lineinfo13").text(res[0][26]);
	}else{
		//号线信息
		$("#div_lineinfo").css('display','none');
		$("#div_lineinfo1").css('display','block');
	}
	
	res=fetchMultiArrayValue('WorkFlow.queryfaultDetail',6,'&jobid='+jobid);
	$("#Jcjg_value #Jcry_value #Wxjg_value #Wxry_value").text("");
	$("#fault1").text(res[0][0]);
	$("#fault2").text(res[0][1]);
	$("#fault3").text(res[0][2]);
	$("#fault4").text(res[0][3]);
	$("#fault5").text(res[0][4]);
	$("#fault6").text(res[0][5]);
	$("#fault7").text(res[0][6]);
	$("#Jcjg_value").val(res[0][7]);
	$("#Jcry_value").val(res[0][8]);
	$("#Wxjg_value").val(res[0][9]);
	$("#Wxry_value").val(res[0][10]);
}			
//查询宽带详细信息
function thisKdInfo(jobid,mqbm){
	$.ajax(
    {
		url : 'workflow?jobid=' + jobid + '&opertype=2&tsdtemp=' + Math.random(), 
      cache : false,timeout : 3000, async : false , //同步方式
    success : function (msg){
				//kdsetup
				if(msg!='' ){
					var valarr = msg.split('~');
					if(valarr[0]!='FAILED'){
						$('#kdmqbm').text(mqbm);
						var thisYwlx = $('#thisYwlx').text();
						var kdinfoarr = valarr[0].split('@');
						var kdbusiarr = valarr[1].split('@');
						for(var i = 0 ; i < kdinfoarr.length;i++){
							$('#kdjobinfo'+i).text('null'==kdinfoarr[i]?'':kdinfoarr[i]);
						}
						for(var i = 0 ; i < kdbusiarr.length;i++){
							$('#kd'+thisYwlx+''+i).html('null'==kdbusiarr[i]?'':kdbusiarr[i]);
						}
						if($('#thisshowywlx').text()!=''){
							$('#tdiv_'+$('#thisshowywlx').text()).hide();
						}
						$('#tdiv_'+thisYwlx+'').show();
						$('#thisshowywlx').text(thisYwlx);
						if(thisYwlx=='setup'){
							$('#kdsetup221').val($('#kdsetup22').text());
							$('#kdsetup232').val($('#kdsetup23').text());
						}
					}else{
						alert(valarr[1]);
					}
				}
           	  }
	});
	if('<%=deptname %>'=='宽带机房' || '<%=deptname %>'=='宽带归档' || '<%=deptname %>'=='系统管理员'){
		$('#editfeedate').show();
	}else{
		$('#editfeedate').hide();
	}
}
//跳转配置页面
function equipRoute(types){
	if(types==""||types==undefined){
		types=$("#typeshidden").val();
	}
	var ywlx='';
	var username=$("#username").val();
	var acct='';
	if(types=='kd'){
		ywlx='broadband';
		//获取业务类型
		var Busitypes=fetchSingleValue('WorkFlow.getBusitype',6,'&jobid='+$('#jobidHX').val());
		//获取宽带类型
		if(Busitypes=='setup'){
			acct = fetchSingleValue('WorkFlow.getAcct',6,'&jobid='+$('#jobidHX').val());
		}else{
			acct = fetchSingleValue('WorkFlow.getAcct1',6,'&jobid='+$('#jobidHX').val());
		}
		if(acct==undefined){
			acct='';
		}
	}else{
		ywlx='phone';
		acct='MDF';
	}
	window.showModalDialog('mainServlet.html?pagename=route/RouteManage.jsp&ywlx=' + ywlx+'&username='+username+'&accesstype='+acct+'&jobid='+$('#jobidHX').val(), window, 'dialogWidth:900px; dialogHeight:500px; center:yes; scroll:no');
		
}


//查询号线详细信息
function getRouteMX(dh,jobid,types,flag){
	//要查询的表
	var ifShow=fetchSingleValue('WorkFlow.showRouteMX',6,"");
	if(ifShow=='Y'){
		var table_name='';
		//工单id
		$('#jobidHX').val("");
		$('#jobidHX').val(jobid);
		//宽带帐号或电话号码
		$("#username").val("");
		$("#username").val(dh);
		//号线条数
		var routeCount = 0;
		//加载的html
		var routeHTML='';
		//获取业务类型 
		if(types=='kd'){
			var Busitypes=fetchSingleValue('WorkFlow.getBusitype',6,"&jobid="+jobid);
			table_name='air_route_broadband';
		}else{
			table_name='air_route_phone';
		}
		
	    var urlstr = tsd.buildParams(
	    {
	        packgname : 'service', //java包
	        clsname : 'ExecuteSql', //类名
	        method : 'exeSqlData', //方法名
	        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
	        tsdcf : 'mssql', //指向配置文件名称
	        tsdoper : 'query', //操作类型 
	        datatype : 'xmlattr', //返回数据格式 
	        tsdpk : 'WorkFlow.getRouteMX'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
	    });
	    $.ajax(
	    {
	        url : 'mainServlet.html?dh=' + dh +'&'+ urlstr+'&tablename='+table_name + '&tsdtemp=' + Math.random(), 
	        datatype : 'xml', cache : false, 
	        //如果值变化可能性比较大 一定要将缓存设成false
	        timeout : 5000, async : false , //同步方式
	        success : function (xml)
	        {
	        	$("#tdiv_kdhx").html("");
	        	$("#tdiv_dhhx").html("");
	        	routeHTML="";
	        	routeCount = 0;
	        	routeHTML+='<tr id="KDHX"><td colspan="6" style="text-align: left" class="labelclass"><b>号线基本信息</b></td></tr>';
	        	$(xml).find('row').each(function(){
		        	routeCount++;
		        	var devname = $(this).attr("devname");
		        	if(devname==undefined){
		        		devname='提示：';
		        	}
					var route = $(this).attr("route");
		        	if(route==undefined){
		        		route='未配置号线信息';
		        	}
		    		if(routeCount%3==1){
		    			routeHTML+= '<tr id="KDHX_tr'+routeCount+'" class="ahref">';
		    		}
		    		routeHTML+='<td class="labelclass">';
					routeHTML+='<label for="sarea">';
					routeHTML+='<span id="lbl'+routeCount+'">'+devname+'</span>';
					routeHTML+='</label>';
					routeHTML+='</td>';
					routeHTML+='<td width="20%" class="tdstyle">';
					routeHTML+='<input type="text" id="route'+routeCount+'" style="width: 125px" class="textclass" disabled="disabled" value="'+route+'"/></td>';
		    		if(routeCount%3==0){
		    			routeHTML+= '</tr>';
		    		}
	    		});
	    		//填充
	    		if(routeCount%3==1){
	    			routeHTML+='<td class="labelclass">';
					routeHTML+='<label for="sarea">';
					routeHTML+='<span ></span>';
					routeHTML+='</label>';
					routeHTML+='</td>';
					routeHTML+='<td width="20%" class="tdstyle">';
					routeHTML+='<input type="text"  style="width: 125px" class="textclass" disabled="disabled" /></td>';
					routeHTML+='<td class="labelclass">';
					routeHTML+='<label for="sarea">';
					routeHTML+='<span ></span>';
					routeHTML+='</label>';
					routeHTML+='</td>';
					routeHTML+='<td width="20%" class="tdstyle">';
					routeHTML+='<input type="text"  style="width: 125px" class="textclass" disabled="disabled" /></td>';
		    		routeHTML+= '</tr>';
	    		}
	    		if(routeCount%3==2){
	    			routeHTML+='<td class="labelclass">';
					routeHTML+='<label for="sarea">';
					routeHTML+='<span ></span>';
					routeHTML+='</label>';
					routeHTML+='</td>';
					routeHTML+='<td width="20%" class="tdstyle">';
					routeHTML+='<input type="text"  style="width: 125px" class="textclass" disabled="disabled" /></td>';
		    		routeHTML+= '</tr>';
		    	
		    	}
				$("#typeshidden").val(types);
		    	routeHTML+="<tr id='KDHX' height='35px'><td colspan='6' style='text-align: center' class='labelclass'><button type='button' class='tsdbtn' onclick='equipRoute()' style='width: 100px; margin-left: 10px'>配置号线信息</button></td></tr>";
		    	if(flag!='y'){					
					if(types=='kd'){
						$("#tdiv_kdhx").html(routeHTML);
					}
					if(types=='dh'){
						$("#tdiv_dhhx").html(routeHTML);
					}
				}else{
					$("#div_lineinfo1").html(routeHTML);					
				}
	        }
	    });
	}
    
}


//装机修改用户计费起始日期和截止日期
function kdTimeSave(){
	var startDate = $('#kdsetup221').val();
	var endDate = $('#kdsetup232').val();
	if(startDate == '' ){
		alert('请选择计费开始日期');
		$('#kdsetup221').focus();
		return false;
	}
	if(endDate == '' ){
		alert('请选择计费截止日期');
		$('#kdsetup232').focus();
		return false;
	}
	sDate = startDate.substring(0,10);
	eDate = endDate.substring(0,10);
	sDate = sDate.split("-");
	eDate = eDate.split("-");
	var tDate1 = new Date(sDate[0], sDate[1], sDate[2]);
	var tDate2 = new Date(eDate[0], eDate[1], eDate[2]);
    if (tDate1 > tDate2)
    {
    	alert("开始日期不能大于截止日期，请重新选择！");
    	$('#kdsetup221').focus();
    	return false;
    }
	if(confirm('确定要修改该用户的计费日期吗？')){
		var params = '';
		params += '&startdate='+startDate;
		params += '&enddate='+endDate;
		params += '&username='+$('#kdjobinfo0').text();
		var ress = executeNoQuery('JobDetail.feetimeUpdate',6,params);
		if(ress=='true'){
			alert('修改成功');
		}
	}
}

function saveT112update(){
	var Jcjg = $("#Jcjg_value").val();
	var Jcry = $("#Jcry_value").val();
	var Wxjg = $("#Wxjg_value").val();
	var Wxry	= $("#Wxry_value").val();
	var fault1 = $("#fault1").text();	
	var params="";
	params+="&Jcjg_v="+tsd.encodeURIComponent(Jcjg);
	params+="&Jcry_v="+tsd.encodeURIComponent(Jcry);
	params+="&Wxjg_v="+tsd.encodeURIComponent(Wxjg);
	params+="&Wxry_v="+tsd.encodeURIComponent(Wxry);
	params+="&jobid="+tsd.encodeURIComponent(fault1);
	var res = executeNoQuery("JobDetailInfo.updateT112_pxsg",6,params);	
	if(res==true||res=="true"){
		alert("提交成功！");
	}else{
		alert("提交失败！");
		}
	setTimeout($.unblockUI,15);
}

$(document).ready(function(){
	getPxjg();
});
function getPxjg(){
		var str="";
		$("#Jcjg_value").empty();
		str+="<option value=''>--请选择--</option>";
		var res=fetchMultiArrayValue('dbsql_phone.querytabledate',6,"&cloum=tvalues&tablename=tsd_ini&key=tsection='T112_pxsg' order by tident");
		if(res[0][0]!=undefined&&res[0][0]!=""){
			for(var i=0;i<res.length;i++){					
					str+="<option value='"+res[i][0]+"'>"+res[i][0]+"</option>";
			}
			$("#Jcjg_value").html(str);
		}
}
</script>
  </head>

  <body>
    	<!-- 显示工单详细信息的面板 -->
		<div class="neirong" id="detailInfo"
			style="display: none; width: 850px;">
			<div class="top">
				<div class="top_01">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							电话详细信息
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascritp:$('#detailinfoclose').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>

			</div>

			<div class="midd"
				style="height: 350px; overflow-y: auto; overflow-x: hidden;">
				<form action="#" name="detailInfoform" id="detailInfoform"
					onsubmit="return false;">
					<table width="100%" id="tdiv" border="0"
						style="border: 1px; border-style: solid; border-color: #87CEFA;"
						cellspacing="0" cellpadding="0">
						<tr>
							<td colspan="6" style="text-align: left" class="labelclass">
								<b>工单基本信息</b>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<input type="text"
										style="width: 0px; height: 0px; margin-left: -1000px"
										id="ian-tsd" />
									<!-- 转移焦点用的 -->
									<span id="thisJobID"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<div id="thisJobIDvalue"></div>
							</td>

							<td class="labelclass">
								<label for="sarea">
									<span id="thisJobType"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisJobTypevalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thismqbm"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thismqbmvalue"></div>
							</td>
						</tr>

						<tr>

							<td class="labelclass">
								<label for="sarea">
									<span id="thisUserID"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisUserIDvalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisArea"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisAreavalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisDepart"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<div id="thisDepartvalue"></div>
							</td>
						</tr>						
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisIfCancel"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisIfCancelvalue"></div>
							</td>

							<td class="labelclass">
								<label for="sarea">
									<span id="thisisPay"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisisPayvalue"></div>
							</td>

							<td class="labelclass">
								<label for="sarea">
									<span id="thisPayMode"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisPayModevalue"></div>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thissDh1"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thissDh1value"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisiSimultaneous"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisiSimultaneousvalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisValue4"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisValue4value"></div>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisJobRecTime"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<div id="thisJobRecTimevalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisdevno"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisdevnovalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisPayType"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<div id="thisPayTypevalue"></div>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisValue5"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisValue5value"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisValue3"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisValue3value"></div>
							</td>	
							<td class="labelclass">
								<label for="sarea">
									<span id="thisValue7"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisValue7value"></div>
							</td>	
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisidtype"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisidtypevalue"></div>
							</td>

							<td class="labelclass">
								<label for="sarea">
									<span id="thisidcard"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisidcardvalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisValue6"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<div id="thisValue6value"></div>
							</td>
						</tr>
						<tr>
							<td colspan="6" style="text-align: left" class="labelclass">
								<b>用户基本信息</b>
							</td>
						</tr>
						<tr>
							<td class="labelclass" style="line-height: 30px">
								<label for="sarea">
									<span id="thisoldsRealName"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisoldsRealNamevalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thissRealName"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thissRealNamevalue"></div>
							</td>

							<td class="labelclass">
								<label for="sarea">
									<span id="thissDh2"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thissDh2value"></div>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisUserName1"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisUserName1value"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisoldspeed"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisoldspeedvalue"></div>
							</td>

							<td class="labelclass">
								<label for="sarea">
									<span id="thisspeed"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisspeedvalue"></div>
							</td>
						</tr>

						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisjobstatus"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisjobstatusvalue"></div>
							</td>

							<td class="labelclass">
								<label for="sarea">
									<span id="thisUserName"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<div id="thisUserNamevalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thissAddress"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thissAddressvalue"></div>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisiStatus"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle" colspan="7">
								<div id="thisiStatusvalue"></div>
							</td>
						</tr>
						<tr>
							<td colspan="6" style="text-align: left" class="labelclass">
								<b>业务基本信息</b>
							</td>
						</tr>
						<tr>
							<td class="labelclass" style="line-height: 30px">
								<label for="sarea">
									<span id="thisiFeeType"></span>
								</label>
							</td>

							<td class="tdstyle" colspan="5">
								<div id="thisiFeeTypevalue"></div>
							</td>
						</tr>
						<tr>

							<td class="labelclass">
								<label for="sarea">
									<span>新业务</span>
								</label>
							</td>

							<td class="tdstyle" colspan="5">
								<div id="thisnewyw"></div>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span>月租</span>
								</label>
							</td>
							<td colspan="7">
								<div id="thisyz"></div>
							</td>
						</tr>
						<tr id='hx1' style='display:none;'>
							<td colspan="6" style="text-align: left" class="labelclass">
								<b>号线基本信息</b>
							</td>
						</tr>
						

						<tr id='hx5' style='display:none;'>
							<td class="labelclass"style='display:none;'>
								备注信息
							</td>

							<td width="20%" class="tdstyle" colspan="5" style='display:none;'>
								<textarea rows="3" cols="115" style="margin-top: 2px;margin-left: 5px"
									onfocus="bzFocus()" id="hxbz"></textarea>
							</td>
						</tr>
						<tr>
							<td colspan="6" style="text-align: left" class="labelclass">
							<table width="100%" id="tdiv_dhhx" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;"
							cellspacing="0" cellpadding="0">
							</table>
							</td>
						</tr>

						<tr>
							<td colspan="6" style="text-align: left" class="labelclass">
								<b>其他</b>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisifurgent"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisifurgentvalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thismemo"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle" colspan="5">
								<textarea disabled="disabled" rows="5" cols="70"
									style="margin-top: 2px" id="thismemovalue"></textarea>
							</td>
						</tr>
					</table>
				</form>
			</div>

			<div class="midd_butt">
				<button type="button" class="tsdbtn" id="submithxinfo"
					onclick="addLineInfo()" style="width: 100px; margin-left: 10px;display: none;">
					保存
				</button>
				<!-- <button onclick="updateHxDeviceState('~')">测试</button> -->
				<button type="button" class="tsdbtn" id="detailinfoclose"
					style="width: 100px; margin-left: 10px">
					关闭
				</button>

			</div>
		</div>
		<input id="closethepause" type="hidden" />
		<input id="Busitype" type="hidden" />
		<input id="username" type="hidden" />
		<input id="jobidHX" type="hidden" />
		<input type="hidden" id="pauseright" />
		<input type="hidden" id="aliveright" />
    	<input type="hidden" id="editvalue1right" />
		<input type="hidden" id="editvalue2right" />
		<input type="hidden" id="editvalue3right" />
		<input type="hidden" id="editvalue4right" />
		<input type="hidden" id="editvalue5right" />
		<input type="hidden" id="editvalue6right" />
		<input type="hidden" id="editvalue7right" />
		<input type="hidden" id="editvalue8right" />
		<input type="hidden" id="editvalue9right" />
		<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
		<input type="hidden" id="managepower" value="false" />
		
		<!-- 显示宽带信息信息 -->
		<div class="neirong" id="kddetailInfo"
			style="display: none; width: 760px">
			<div class="top">
				<div class="top_01">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							宽带详细信息
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascritp:setTimeout($.unblockUI,15);">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="max-height: 320px; overflow-y: auto; overflow-x: hidden;">
				<form action="#" name="kddetailInfoform" id="kddetailInfoform" onsubmit="return false;">
					<table width="100%" id="tdiv_ywjb" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;"
						cellspacing="0" cellpadding="0">
						<tr>
							<td colspan="6" style="text-align: left" class="labelclass">
								<b>业务基本信息<input type="text" style="width: 1px;height: 1px;margin-left: -100px"/></b>
							</td>
						</tr>
					</table>
					
					<!-- 装机显示业务信息 -->
					<table width="100%" id="tdiv_setup" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;display: none"
						cellspacing="0" cellpadding="0">
						<tr height="35px" id="editfeedate">
							<td class="labelclass">计费开始日期</td>
							<td width="20%" class="tdstyle">
								<input type="text" class="textclass" id="kdsetup221" style="width: 145px;height: 22px;line-height: 22px;margin-left: 5px" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
								<label id="kdsetup22" style="display: none"></label>
							</td>
							<td class="labelclass">计费截止日期</td>
							<td width="20%" class="tdstyle">
								<input type="text" class="textclass" id="kdsetup232" style="width: 145px;height: 22px;line-height: 22px;margin-left: 5px" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
								<label id="kdsetup23" style="display: none"></label>
							</td>
							<td class="labelclass" colspan="2">
								<button type="button" class="tsdbtn" id="kdtimesave" onclick="kdTimeSave()" style="width: 60px; margin-left: 10px;float: left;height: 30px">
									修改
								</button>
							</td>
						</tr>
						<tr>
							<td class="labelclass">用户姓名</td>
							<td width="20%" class="tdstyle" id="kdsetup0"></td>
							<td class="labelclass">用户地址</td>
							<td width="20%" class="tdstyle" id="kdsetup1" colspan="3">123</td>
						</tr>
						<tr>
							<td class="labelclass">用户类型</td>
							<td width="20%" class="tdstyle" id="kdsetup2"></td>
							<td class="labelclass">用户性质</td>
							<td width="20%" class="tdstyle" id="kdsetup3"></td>
							<td class="labelclass">装机日期</td>
							<td width="20%" class="tdstyle" id="kdsetup4"></td>
						</tr>
						<tr>
							<td class="labelclass">用户套餐</td>
							<td width="20%" class="tdstyle" id="kdsetup5"></td>
							<td class="labelclass">用户部门</td>
							<td width="20%" class="tdstyle" id="kdsetup6"></td>
							<td class="labelclass">二级部门</td>
							<td width="20%" class="tdstyle" id="kdsetup7"></td>
						</tr>
						<tr>
							<td class="labelclass">三级部门</td>
							<td width="20%" class="tdstyle" id="kdsetup8"></td>
							<td class="labelclass">四级部门</td>
							<td width="20%" class="tdstyle" id="kdsetup9"></td>
							<td class="labelclass">接入类型</td>
							<td width="20%" class="tdstyle" id="kdsetup10"></td>
						</tr>
						<tr>
							<td class="labelclass">证件类型</td>
							<td width="20%" class="tdstyle" id="kdsetup11"></td>
							<td class="labelclass">证件号码</td>
							<td width="20%" class="tdstyle" id="kdsetup12"></td>
							<td class="labelclass">移动电话</td>
							<td width="20%" class="tdstyle" id="kdsetup13"></td>
						</tr>
						<tr>
							<td class="labelclass">联系人</td>
							<td width="20%" class="tdstyle" id="kdsetup14"></td>
							<td class="labelclass">联系电话</td>
							<td width="20%" class="tdstyle" id="kdsetup15"></td>
							<td class="labelclass">绑定电话</td>
							<td width="20%" class="tdstyle" id="kdsetup16"></td>
						</tr>
						<tr>
							<td class="labelclass">付费类型</td>
							<td width="20%" class="tdstyle" id="kdsetup17"></td>
							<td class="labelclass">合同号</td>
							<td width="20%" class="tdstyle" id="kdsetup18"></td>
							<td class="labelclass">密码</td>
							<td width="20%" class="tdstyle" id="kdsetup19"></td>
						</tr>
						<tr>
							<td class="labelclass">备注</td>
							<td width="20%" class="tdstyle" id="kdsetup20" colspan="5"></td>
						</tr>
					</table>
					
					<!-- 移机显示业务信息 -->
					<table width="100%" id="tdiv_move" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;display: none"
						cellspacing="0" cellpadding="0">
						<tr>
							<td class="labelclass">用户原地址</td>
							<td width="84%" class="tdstyle" id="kdmove0" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass">用户新地址</td>
							<td width="84%" class="tdstyle" id="kdmove1" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass">备注</td>
							<td width="84%" class="tdstyle" id="kdmove3" colspan="5"></td>
						</tr>
					</table>
					
					<!-- 拆机显示业务信息 -->
					<table width="100%" id="tdiv_delete" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;display: none"
						cellspacing="0" cellpadding="0">
						<tr>
							<td class="labelclass">拆机日期</td>
							<td width="84%" class="tdstyle" id="kddelete0" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass">绑定电话</td>
							<td width="84%" class="tdstyle" id="kddelete6" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass">备注</td>
							<td width="84%" class="tdstyle" id="kddelete1" colspan="5"></td>
						</tr>
					</table>
					<!-- 过户显示业务信息 -->
					<table width="100%" id="tdiv_transfer" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;display: none"
						cellspacing="0" cellpadding="0">
						<tr>
							<td class="labelclass">用户原名称</td>
							<td width="84%" class="tdstyle" id="kdtransfer0" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass">用户新名称</td>
							<td width="84%" class="tdstyle" id="kdtransfer1" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass">备注</td>
							<td width="84%" class="tdstyle" id="kdtransfer2" colspan="5"></td>
						</tr>
					</table>
					<!-- 暂停显示业务信息 -->
					<table width="100%" id="tdiv_pause" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;display: none"
						cellspacing="0" cellpadding="0">
						<tr>
							<td class="labelclass">用户原状态</td>
							<td width="84%" class="tdstyle" id="kdpause0" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass">用户新状态</td>
							<td width="84%" class="tdstyle" id="kdpause1" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass">备注</td>
							<td width="84%" class="tdstyle" id="kdpause2" colspan="5"></td>
						</tr>
					</table>
					
					<!-- 恢复显示业务信息 -->
					<table width="100%" id="tdiv_restore" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;display: none"
						cellspacing="0" cellpadding="0">
						<tr>
							<td class="labelclass">用户原状态</td>
							<td width="84%" class="tdstyle" id="kdrestore0" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass">用户新状态</td>
							<td width="84%" class="tdstyle" id="kdrestore1" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass">备注</td>
							<td width="84%" class="tdstyle" id="kdrestore2" colspan="5"></td>
						</tr>
					</table>
					<!-- 一端双口业务信息 -->
					<table width="100%" id="tdiv_addport" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;display: none"
						cellspacing="0" cellpadding="0">
						<tr>
							<td class="labelclass">主帐号到期日期</td>
							<td width="84%" class="tdstyle" id="kdaddport0" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass">绑定帐号密码修改</td>
							<td width="84%" class="tdstyle" id="kdaddport1" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass">开通绑定帐号</td>
							<td width="84%" class="tdstyle" id="kdaddport2" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass">拆除绑定帐号</td>
							<td width="84%" class="tdstyle" id="kdaddport3" colspan="5"></td>
						</tr>
					</table>
					<!-- 宽带返销账 -->
					<table width="100%" id="tdiv_crossfee" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;display: none"
						cellspacing="0" cellpadding="0">
						<tr>
							<td class="labelclass">原套餐信息</td>
							<td width="84%" class="tdstyle" id="kdcrossfee0" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass">返销账套餐信息</td>
							<td width="84%" class="tdstyle" id="kdcrossfee1" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass">绑定一端爽口信息</td>
							<td width="84%" class="tdstyle" id="kdcrossfee2" colspan="5"></td>
						</tr>
					</table>
					<!-- 宽带续费显示业务信息 -->
					<table width="100%" id="tdiv_payfee" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;display: none"
						cellspacing="0" cellpadding="0">
						<tr>
							<td class="labelclass">用户原套餐</td>
							<td width="84%" class="tdstyle" id="kdpayfee0" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass" >原套餐到期日期</td>
							<td class="tdstyle" id="kdpayfee1" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass">用户新套餐</td>
							<td width="84%" class="tdstyle" id="kdpayfee2" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass" >新套餐到期日期</td>
							<td class="tdstyle" id="kdpayfee3" colspan="5"></td>
						</tr>
						<tr>
							<td class="labelclass">备注</td>
							<td width="84%" class="tdstyle" id="kdpayfee4" colspan="5"></td>
						</tr>
					</table>
					<!-- 宽带修改属性显示业务信息 -->
					<table width="100%" id="tdiv_modify" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;display: none"
						cellspacing="0" cellpadding="0">
						<tr>
							<td class="labelclass">业务修改信息</td>
							<td width="84%" class="tdstyle" colspan="5">
								<div id="kdmodify0" style="max-height: 100px; overflow-y: auto; overflow-x: hidden;line-height: 25px"></div>
							</td>
						</tr>
					</table>
					<table width="100%" id="tdiv_kdhx" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;"
						cellspacing="0" cellpadding="0">
					</table>
					<table width="100%" id="tdiv" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;"
						cellspacing="0" cellpadding="0">
						<tr>
							<td colspan="6" style="text-align: left" class="labelclass">
								<b>工单基本信息</b>
							</td>
						</tr>
						<tr>
							<td class="labelclass">宽带账号</td>
							<td width="20%" class="tdstyle" id="kdjobinfo0"></td>
							<td class="labelclass">工单类型</td>
							<td width="20%" class="tdstyle" id="kdjobinfo1"></td>
							<td class="labelclass">目前部门</td>
							<td width="20%" class="tdstyle" id="kdmqbm"></td>
						</tr>
						<tr>
							<td class="labelclass">工单状态</td>
							<td width="20%" class="tdstyle" id="kdjobinfo2"></td>
							<td class="labelclass">受理日期</td>
							<td width="20%" class="tdstyle" id="kdjobinfo3"></td>
							<td class="labelclass">受理人员</td>
							<td width="20%" class="tdstyle" id="kdjobinfo4"></td>
						</tr>
						<tr>
							<td class="labelclass">受理区域</td>
							<td width="20%" class="tdstyle" id="kdjobinfo5"></td>
							<td class="labelclass">受理部门</td>
							<td width="20%" class="tdstyle" id="kdjobinfo6"></td>
							<td class="labelclass">受理费</td>
							<td width="20%" class="tdstyle" id="kdjobinfo7"></td>
						</tr>
						<tr >
							<td class="labelclass" style="line-height: 30px">备注</td>
							<td width="20%" class="tdstyle" id="kdjobinfo8" colspan="5"></td>
						</tr>
						
						
					</table>
				</form>
		</div>
		<div class="midd_butt">
			<button type="button" class="tsdbtn" id="kddetailinfoclose" style="width: 100px; margin-left: 10px">
					关闭
			</button>
		</div>
		<label id="thisshowywlx" style="display: none"></label>
		<input type="hidden" id="typeshidden"/>
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
		<!-- 显示故障信息信息 -->
		
  
  		<div class="neirong" id="faultDetailInfo"
			style="display: none; width: 760px">
			<div class="top">
				<div class="top_01">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							故障详细信息
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascritp:setTimeout($.unblockUI,15);">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			
			<div class="midd" style="max-height: 320px; overflow-y: auto; overflow-x: hidden;">
				<form action="#" name="faultDetailInfoform" id="faultDetailInfoform" onsubmit="return false;">
				<table width="100%" id="div_ywjb" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;"
						cellspacing="0" cellpadding="0">
						<tr>
							<td colspan="6" style="text-align: left" class="labelclass">
								<b>用户基本信息<input type="text" style="width: 1px;height: 1px;margin-left: -100px"/></b>
							</td>
						</tr>
					</table>
					
					<!-- 宽带故障信息 -->
					<table width="100%" id="div_radfault" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;"
						cellspacing="0" cellpadding="0">
						<tr>
							<td class="labelclass">账号</td>
							<td width="20%" class="tdstyle" id="radfault1"></td>
							<td class="labelclass">用户性质</td>
							<td width="20%" class="tdstyle" id="radfault2"></td>
							<td class="labelclass">装机日期</td>
							<td width="20%" class="tdstyle" id="radfault3"></td>
						</tr>
						<tr>
							<td class="labelclass">用户套餐</td>
							<td width="20%" class="tdstyle" id="radfault4"></td>
							<td class="labelclass">用户部门</td>
							<td width="20%" class="tdstyle" id="radfault5"></td>
							<td class="labelclass">二级部门</td>
							<td width="20%" class="tdstyle" id="radfault6"></td>
						</tr>
						<tr>
							<td class="labelclass">三级部门</td>
							<td width="20%" class="tdstyle" id="radfault7"></td>
							<td class="labelclass">四级部门</td>
							<td width="20%" class="tdstyle" id="radfault8"></td>
							<td class="labelclass">接入类型</td>
							<td width="20%" class="tdstyle" id="radfault9"></td>
						</tr>
						<tr>
							<td class="labelclass">证件类型</td>
							<td width="20%" class="tdstyle" id="radfault10"></td>
							<td class="labelclass">证件号码</td>
							<td width="20%" class="tdstyle" id="radfault11"></td>
							<td class="labelclass">移动电话</td>
							<td width="20%" class="tdstyle" id="radfault12"></td>
						</tr>
						<tr>
							<td class="labelclass">联系电话</td>
							<td width="20%" class="tdstyle" id="radfault13"></td>
							<td class="labelclass">联系人</td>
							<td width="20%" class="tdstyle" id="radfault14"></td>
							<td class="labelclass">绑定电话</td>
							<td width="20%" class="tdstyle" id="radfault15"></td>
						</tr>
					</table>
					<!-- 电话故障信息 -->
					<table width="100%" id="div_112fault" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;display:none;"
						cellspacing="0" cellpadding="0" >
						<tr>
							<td class="labelclass">电话</td>
							<td width="20%" class="tdstyle" id="112fault1"></td>
							<td class="labelclass">合同号</td>
							<td width="20%" class="tdstyle" id="112fault2"></td>
							<td class="labelclass">用户性质</td>
							<td width="20%" class="tdstyle" id="112fault3"></td>
						</tr>
						<tr>
							<td class="labelclass">起始时间</td>
							<td width="20%" class="tdstyle" id="112fault4"></td>
							<td class="labelclass">一级部门</td>
							<td width="22%" class="tdstyle" id="112fault5"></td>
							<td class="labelclass">二级部门</td>
							<td width="20%" class="tdstyle" id="112fault6"></td>
						</tr>
						<tr>
							<td class="labelclass">三级部门</td>
							<td width="20%" class="tdstyle" id="112fault7"></td>
							<td class="labelclass">四级部门</td>
							<td width="20%" class="tdstyle" id="112fault8"></td>
							<td class="labelclass">套餐</td>
							<td width="20%" class="tdstyle" id="112fault9"></td>
						</tr>
						<tr>
							<td class="labelclass">业务区域</td>
							<td width="20%" class="tdstyle" id="112fault10"></td>
							<td class="labelclass">用户地址</td>
							<td width="20%" class="tdstyle" id="112fault11"></td>
							<td class="labelclass">电话功能</td>
							<td width="20%" class="tdstyle" id="112fault12"></td>
						</tr>
					</table>
					<!-- 电视故障信息 -->
					<table width="100%" id="div_tvfault" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;display:none;"
						cellspacing="0" cellpadding="0" >
						<tr>
							<td class="labelclass">iptv账号</td>
							<td width="20%" class="tdstyle" id="tvfault1"></td>
							<td class="labelclass">合同号</td>
							<td width="20%" class="tdstyle" id="tvfault2"></td>
							<td class="labelclass">用户类型</td>
							<td width="20%" class="tdstyle" id="tvfault3"></td>
						</tr>
						<tr>
							<td class="labelclass">起始时间</td>
							<td width="20%" class="tdstyle" id="tvfault4"></td>
							<td class="labelclass">一级部门</td>
							<td width="22%" class="tdstyle" id="tvfault5"></td>
							<td class="labelclass">二级部门</td>
							<td width="20%" class="tdstyle" id="tvfault6"></td>
						</tr>
						<tr>
							<td class="labelclass">三级部门</td>
							<td width="20%" class="tdstyle" id="tvfault7"></td>
							<td class="labelclass">四级部门</td>
							<td width="20%" class="tdstyle" id="tvfault8"></td>
							<td class="labelclass">套餐</td>
							<td width="20%" class="tdstyle" id="tvfault9"></td>
						</tr>
						<tr>
							<td class="labelclass">业务区域</td>
							<td width="20%" class="tdstyle" id="tvfault10"></td>
							<td class="labelclass">用户地址</td>
							<td width="20%" class="tdstyle" id="tvfault11"></td>
							<td class="labelclass">电话功能</td>
							<td width="20%" class="tdstyle" id="tvfault12"></td>
						</tr>
					</table>
					<table width="100%" id="div_lineinfo1" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;"
						cellspacing="0" cellpadding="0">
					</table>
					<!-- 外部号码号线信息 -->
					<table width="100%" id="div_lineinfo" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;display:none;"
						cellspacing="0" cellpadding="0" >
						<tr>
							<td class="labelclass">设备IP</td>
							<td width="20%" class="tdstyle" id="lineinfo1"></td>
							<td class="labelclass">语音IP</td>
							<td width="20%" class="tdstyle" id="lineinfo2"></td>
							<td class="labelclass">数据IP</td>
							<td width="20%" class="tdstyle" id="lineinfo3"></td>
						</tr>
						<tr>
							<td class="labelclass">数据端口</td>
							<td width="20%" class="tdstyle" id="lineinfo4"></td>
							<td class="labelclass">语音端口</td>
							<td width="22%" class="tdstyle" id="lineinfo5"></td>
							<td class="labelclass">分光器地址</td>
							<td width="20%" class="tdstyle" id="lineinfo6"></td>
						</tr>
						<tr>
							<td class="labelclass">端口号</td>
							<td width="20%" class="tdstyle" id="lineinfo7"></td>
							<td class="labelclass">主干光缆</td>
							<td width="20%" class="tdstyle" id="lineinfo8"></td>
							<td class="labelclass">交接箱</td>
							<td width="20%" class="tdstyle" id="lineinfo9"></td>
						</tr>
						<tr>
							<td class="labelclass">分支电缆</td>
							<td width="20%" class="tdstyle" id="lineinfo10"></td>
							<td class="labelclass">分支线序</td>
							<td width="20%" class="tdstyle" id="lineinfo11"></td>
							<td class="labelclass">分线箱</td>
							<td width="20%" class="tdstyle" id="lineinfo12"></td>
						</tr>
					</table>
					
					<table width="100%" id="div_ywjb" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;"
						cellspacing="0" cellpadding="0">
						<tr>
							<td colspan="6" style="text-align: left" class="labelclass">
								<b>工单基本信息<input type="text" style="width: 1px;height: 1px;margin-left: -100px"/></b>
							</td>
						</tr>
					</table>
					<table width="100%" id="div_fault" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;"
						cellspacing="0" cellpadding="0">
						<tr>
							<td class="labelclass">工单编号</td>
							<td width="20%" class="tdstyle" id="fault1"></td>
							<td class="labelclass">受理部门</td>
							<td width="20%" class="tdstyle" id="fault2"></td>
							<td class="labelclass">受理人员</td>
							<td width="20%" class="tdstyle" id="fault3"></td>
						</tr>
						<tr>
							<td class="labelclass">受理日期</td>
							<td width="20%" class="tdstyle" id="fault4"></td>
							<td class="labelclass">故障信息</td>
							<td width="20%" class="tdstyle" id="fault5"></td>
							<td class="labelclass">联系电话</td>
							<td width="20%" class="tdstyle" id="fault6"></td>
						</tr>
						<tr>
							<td class="labelclass">复测结果</td>	
							<td class="tdstyle">								
								<select id="Jcjg_value" style="width:150px;"></select>
							</td>
							<td colspan="2"></td>
							<td class="labelclass">复测人员</td>
							<td width="20%" class="tdstyle">
								<input type="text" style="width:120px;height:25px;" id="Jcry_value"/>	
							</td>
						</tr>	
						<tr>
							<td class="labelclass">维修结果</td>
							<td  colspan="3" width="60%" class="tdstyle">
								<input type="text" style="width:300px;height:25px;" id="Wxjg_value"/>	
							</td>
							<td class="labelclass">维修人员</td>
							<td width="20%" class="tdstyle">
								<input type="text" style="width:120px;height:25px;" id="Wxry_value"/>	
							</td>
						</tr>
						<tr>
							<td class="labelclass">受理备注</td>
							<td width="20%" class="tdstyle" id="fault7" colspan="5"></td>
						</tr>						
					</table>					
				</form>
			</div>			
			<div class="midd_butt">
			<button type="button" class="tsdbtn" id="faultDetailinfoclose" style="width: 100px; margin-left: 10px">
					关闭
			</button>
			<button type="button" class="tsdbtn" id="save" onclick="javascript:saveT112update();" style="width: 100px; margin-left: 10px">
					提交
			</button>
		</div>
		</div>		
  </body>
</html>