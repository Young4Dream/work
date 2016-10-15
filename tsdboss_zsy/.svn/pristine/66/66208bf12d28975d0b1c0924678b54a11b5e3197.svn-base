/**********************************************************************
function name:    fetchSingleValue
function:         fetchSingleValue(key,dss,param)

parameters:       key:要请求的SQL语句对应配置文件中键值
                  dss:数据源编号,0为宽带的 mysql数据源，1-7为固话的sqlServer数据源，具体查看函数identifyDs
                  param :
                  
return:           能取到值时返回取到的值，否则返回undefined
description:      从数据库中取单个值，通用
**********************************************************************/
function fetchSingleValue(key,dss,param)
{
	var result;
	var configFile = arguments[3];
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
				datatype:'xml',//返回数据格式 
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
			$(xml).find("row:first").each(function(){
				$(this).find("cell:first").each(function(){
					result = $(this).text();
				});
			});
		}
	});
	return result;
}

/**********************************************************************
function name:    fetchMultiPValue
function:         fetchMultiPValue(key,dss,param),通过存储过程取回多个值，返回值 N*M 数组

parameters:       key:要请求的存储过程的展现名
                  dss:数据源编号,0为宽带的 mysql数据源，1-7为固话的sqlServer数据源，具体查看函数identifyDs
                  param为需要的参数,格式为"&param1=value1&param2=value2";
                  
return:           能取到值时返回取到的值的多维数据，否则返回没有值的一维数据

description:      从数据库中取多值 N*M 数组，通用，主要用于取权限
**********************************************************************/
function fetchMultiPValue(key,dss,param)
{
	var result = new Array();
	var i = 0;
	var j = 0;
	
	var urlMm = tsd.buildParams({ packgname:'service',
				clsname:'Procedure',//类名
				method:'exequery',//方法名
				ds:identifyDs(dss),
				tsdExeType:'query',//操作类型 
				datatype:'xml',//返回数据格式 
				tsdpname:key
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
				result[i++] = new Array();
				$(this).find("cell").each(function(){
					result[i-1].push($(this).text());
				});
			});
		}
	});
	return result;
}


/**********************************************************************
function name:    fetchMultiValue
function:         fetchMultiValue(key,dss,param),通过SQL语句取回多个值，返回值 N*M 数组

parameters:       key:要请求的的SQL语句在配置文件中的键值
                  dss:数据源编号,0为宽带的 mysql数据源，1-7为固话的sqlServer数据源，具体查看函数identifyDs
                  param为需要的参数,格式为"&param1=value1&param2=value2";
                  
return:           能取到值时返回取到的值的 N*M 多维数据，否则返回没有值的一维 1*0 数据

description:      从数据库中取多值 N*M 数组，其值为key查询的结果集的所有数据，通用
**********************************************************************/
function fetchMultiArrayValue(key,dss,param)
{
	var result = new Array();
	var i = 0;
	var j = 0;
	var configFile = arguments[3];
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
				datatype:'xml',//返回数据格式 
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
				result[i++] = new Array();
				$(this).find("cell").each(function(){
					result[i-1].push($(this).text());
				});
			});
		}
	});
	
	return result;
}

/**********************************************************************
function name:    executeNoQuery
function:         executeNoQuery(key,dss,param),通过SQL语句执行删除和修改操作

parameters:       key:要请求的的SQL语句在配置文件中的键值
                  dss:数据源编号,0为宽带的 mysql数据源，1-7为固话的sqlServer数据源，具体查看函数identifyDs
                  param:为需要的参数,格式为"&param1=value1&param2=value2";
                  
return:           成功时返回true,失败时返回"false"或false;

description:      通过SQL语句执行删除和修改操作，执行key查询，通用
**********************************************************************/
function executeNoQuery(key,dss,param)
{
	var result = false;
	var configFile = arguments[3];
	if(configFile==undefined)
	{
		configFile = dss?'mssql':'mysql';
	}
	var urll = tsd.buildParams({ packgname:'service',
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:identifyDs(dss),
				tsdcf:configFile,//指向配置文件名称
				tsdoper:'exe',//操作类型 
				datatype:'xml',//返回数据格式 
				tsdpk:key
				});
	$.ajax({
		url:"mainServlet.html?" + urll + param,
		async:false,
		cache:false,
		timeout:1000,
		type:'post',
		success:function(xml){result = xml;}		
	});
	return result;
}

/**********************************************************************
function name:    identifyDs
function:         identifyDs(dss),解析数字为数据源名称

parameters:       dss:数据源编号,0为宽带的 mysql数据源，1-7为固话的sqlServer数据源
                             0   宽带认证服务器：broadband（MYSQL radius）
                             1   营收服务器：tsdCharge（MSSQL telcount2009）   
                             2   分拣服务器：tsdCDR（MSSQL telcount2009）   
                             3,4,5   详单服务器：tsdBill tsdLog tsdHis（MSSQL telcount2009 telcount2009log telcount2009his）    
                             6   计费服务器：tsdBilling（MSSQL telcount2009）
                             7   报表工单服务器：tsdReport（MSSQL telcount2009）
                  
return:           返回数据源名称

description:      解析数字为数据源名称，本js文件取值所需
**********************************************************************/
function identifyDs(dss)
{
	switch(dss)
	{
		case 0:
			return "broadband";
			break;
		case 1:
			return "tsdCharge";
			break;
		case 2:
			return "tsdCDR";
			break;
		case 3:
			return "tsdBill";
			break;
		case 4:
			return "tsdLog";
			break;
		case 5:
			return "tsdHis";
			break;
		case 6:
			return "tsdBilling";
			break;
		case 7:
			return "tsdReport";
			break;
		default:
			return "";
			break;		
	}
}