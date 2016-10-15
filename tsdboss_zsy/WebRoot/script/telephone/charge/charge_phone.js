/**********************************************************************************
**          *******         ******  *******     **       *****                   **  
**             *            *          *       ** **     *    *                  **
**             *   ******   ******     *      **   **    *****                   ** 
**             *                 *     *     ** *** **   *  *                    **
**             *            ******     *    **       **  *    *                  **
**                                                                               **               
** name:    "WebRoot/script/telephone/charge/charge_phone.js"                    **
** version: v10.1                                                                ** 
** author:  lvkui                                                                **
** date:    2011-7-22                                                            **
** desc:    收费结帐专用js脚本。                                                            **
**          只有"WebRoot/WEB-INF/template/telephone/charge/charge_phone.jsp"调用。 **
** modify:                                                                       ** 
**            2011-10-19    吕奎      增加同一帐期再次缴费时提示功能                       **
***********************************************************************************/

/**********************************************************************
function name:    initData
function:         页面显示时初始化数据。

parameters:       type: "normalcustomer" 普通客户  "groupcustomer" 大客户
                  
return:           

description:      
**********************************************************************/
function initData(pay_type)
{
	$.ajax({
		url:"charge_phone?func=init&groupid="+$("#zid").val()+"&imenuid="+$("#imenuid").val()+"&pay_type=" + pay_type,
		async:true,//异步
		cache:false,
		timeout:20000,//1000表示1秒
		type:'post',
		success:function(xml,textStatus)
		{
		    //取缴费方式 返回的是html格式
		    var spayitem = xml.substring(xml.indexOf("<payitem=")+9,xml.indexOf("payitem/>"));
		    var stsdinicfg = xml.substring(xml.indexOf("<tsdcfg=")+8,xml.indexOf("tsdcfg/>"));

		    $("#ghFFFs").html(spayitem);
		   
		    $("#ghInfo").data("tsdinicfg",eval("(" + stsdinicfg + ")"));
		
		    if("groupcustomer"==pay_type)
		    {
		       //移除普通客户缴费方式
		       $("#ghInfo").data("paytype",$("#ghFFFs option").not("option[cval^='d']").remove());
		    }
		    else if("normalcustomer"==pay_type)
		    {
		       //移除大客户缴费方式
		       $("#ghInfo").data("paytype",$("#ghFFFs option[cval^='d']").remove());
		       //result = xml;
			    //取权限
			    var spower = xml.substring(xml.indexOf("<power=")+7,xml.indexOf("power/>"));
			    //alert(spower);
			    //all或all||表示是管理员，拥有最高权限
			    if ((spower!="all")&&(spower!="all||"))
			    {
			    	//合并打印选择框默认是否选中 true:选中
			       	if (getCaption(spower,"defaultCheckComb","")=="true")
			       	{
						$("#defaultCheckComb").val('false');
					}
			    }
		    }		    
		}		
	});
}
/**********************************************************************
function name:    pageUnLoad
function:         页面退出进清空临时表数据。

parameters:       
                  
return:           

description:      
**********************************************************************/
function pageUnLoad()
{
	$.ajax({
		url:"charge_phone?func=unload",
		async:true,//异步
		cache:false,
		timeout:20000,//1000表示1秒
		type:'post',
		success:function(xml)
		{
		   
		}		
	});
}

/**********************************************************************
function name:    KeyDown_PhoneBox
function:         在电话输入框里回车后执行查找按钮的功能。

parameters:       event：按键事件参数。
                  
return:           

description:      
**********************************************************************/
function KeyDown_PhoneBox(event)
{
	if(event.keyCode==13)
	{
		$("#ghSearchByUserName").click();
	}
}

/**********************************************************************
function name:    payitem_change
function:         电话缴费页面缴费方式改变。

parameters:    
                  
return:           

description:      
**********************************************************************/
function payitem_change(pay_type)
{
	//取缴费方式名称：cash ...
	var xcval = $("#ghFFFs option:selected").attr("cval");
	if(xcval===undefined || xcval===null) {xcval = "";}

	//取计算应缴费过程返回的应缴费，欠费时为正，有余额时为负,其余情况已处理为0	
	var yjff = $("#ghInfo").data("byyecal");
	yjff = parseFloat(yjff);	
	if(yjff>0)//欠费
	{
		/*
		if($("#ghFFFs").val()=="cash")//现金
		{
		    //取大于欠费金额的最小整数
			$("#ghSs").val(Math.ceil(yjff));
		}
		else
		{
			$("#ghSs").val(yjff);
		}
		*/
		//取大于欠费金额的最小整数
		$("#ghSs").val(Math.ceil(yjff));
	}
	$("#ghSs").select().focus();
	
	//切换显示
	$(".config_bill").hide();
	$(".config_bill[xid='" + $("#ghFFFs option:selected").attr("cval") + "']").show();

	//如果已经查询用户，则变更缴费方式时同步更新票据
	if($("#ghInfo").data("dh")!==undefined || pay_type=="groupcustomer")
	{
		phoneInfo();
	}
	$(".billdeflet[pjid='sflx']").html($("#ghFFFs option:selected").text());
}

/**********************************************************************
function name:    btnFindClick
function:         电话缴费页面，在用户输入收费电话后点击查找按钮。

parameters:       pay_type : "normalcustomer" 普通客户  "groupcustomer" 大客户 
                  
return:           

description:      
**********************************************************************/
function btnFindClick(pay_type)
{
	var dhNum = $.trim($("#ghSearchBox").val());
	if(dhNum=="")
  	{
		$("#ghSearchBox").select().focus();
		return false;
	}
	if("groupcustomer" == pay_type){
		dhNum = $("#ghInfo").data("hthlist");
	}

	ghClearInfoWithoutSearchBox();
	$("#loading").show();
	$.ajax({
	url:"charge_phone?func=find&dh="+dhNum+"&sSkfs="+encodeURIComponent($("#ghFFFs").val())+"&Kemu=" + encodeURIComponent("电话费") + (pay_type=="groupcustomer"?"&DKHFlag=Y":""),
	async:true,//异步
	cache:false,
	timeout:50000,//1000表示1秒
	type:'post',
	success:function(xml, textStatus)
	{	
	    //session过期处理
	    if (typeof(xml)=="string")
	    {
		    if (xml == "session invalid")
		    {
		      	location.href="login.jsp";
		      	return false;
		    }
	    }
	    //过程执行结果
	   	var res = $("row:first",xml).attr("res");
	   	if (res == "FAILED")
	   	{
	   	    //过程执行失败，提示过程返回的失败原因
	   		alert($("row:first",xml).attr("tag"));
	   		$("#ghSearchBox").select().focus();
	   		$("#loading").hide();
	   		return false;
	   	}
	   	
	   	//缓存合并打印发票数据 根据发票要求从表hfys_hthhf_out里取出的一条数据
		$("#ghInfo").data("payitem_data", xml);
		//解析数据 生成发票
		phoneInfo(pay_type);
		//保存按钮可用
		$("#ghsave").removeAttr("disabled");
		if(pay_type!="groupcustomer"){
			//用户信息和退费按钮可用
			$("#ghUserInfo").removeAttr("disabled");	
			if($("#tfbuttenright").val()=="true"){
				$("#ghTuiFeiBtn").removeAttr("disabled");
			}else{
				$("#ghTuiFeiBtn").attr("disabled","disabled");
			}
		}
		//获取用户应缴费成功后执行的一些操作
		afterfind(xml,pay_type);
		$("#loading").hide();
	},
	error:function(XMLHttpRequest, textStatus, errorThrown)
	{
		alert("错误："+textStatus);
		$("#ghSearchBox").select().focus();
		$("#loading").hide();
	}		
	});	
}

				/*********
				* 权限			
				* @param;
				* @return;
		    	**********/
				function getywslUserPower(){
				 var urlstr=tsd.buildParams({ 	  packgname:'service',
							 					  clsname:'Procedure',
												  method:'exequery',
							 					  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
							 					  tsdpname:'prodistorys.xuanxian',//存储过程的映射名称
							 					  tsdExeType:'query',
							 					  datatype:'xmlattr'
						 					});
				/************************
				*   调用存储过程需要的参数 *
				**********************/
				var userid = $('#userid').val();	
				var groupid = $('#zid').val();
				var imenuid = $('#imenuid').val();
				
				/****************
				*   拼接权限参数 *
				**************/
				var tfbuttenright='';
				var flag = false;				
				var spower = '';				
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
				if(spower=='all@'){
						tfbuttenright='true';
						flag = true;
				}else if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');
						for(var i = 0;i<spowerarr.length-1;i++){
							tfbuttenright +=getCaption(spowerarr[i],'tfbutten','')+'|';//退费按钮是否可用
						}
				}
				var hastfbutten = tfbuttenright.split('|');
				var str = 'true';
				if(flag==true){
					$("#tfbuttenright").val(tfbuttenright);
				}else{
					for(var i = 0;i<hastfbutten.length;i++){
							$("#tfbuttenright").val(hastfbutten[i]);
							break;
						}
				}		
			}

/**********************************************************************
function name:    ghClearInfoWithoutSearchBox
function:         电话缴费查询时清空页面信息  不清除查询框。

parameters:    
                  
return:           

description:      
**********************************************************************/
function ghClearInfoWithoutSearchBox()
{
	//欠费月份清空
	$("#ghPayMonth").empty();
	$("#ghUserInfo,#ghTuiFeiBtn").attr("disabled","disabled");
	//电话缴费信息栏 输入框清空
	$("#ghStatus :text").val("");
	//将递交金额输入框，实收金额输入框置为可用
	$("#ghSs").removeAttr("disabled");
	//清空票据
	$(".config_bill span").empty();
	
	$("#ghInfo").removeData("dh");
	$("#ghInfo").removeData("hth");
	$("#ghInfo").removeData("yhmc");
	//清空 实时余额
	$("#ghInfo").removeData("ssye");
	//清空 应缴费
	$("#ghInfo").removeData("byyecal");
	//清空合并打印发票数据 缓存的根据发票要求从表hfys_hthhf_out里取出的一条数据
	$("#ghInfo").removeData("payitem_data");
			
	//将保存按钮置为不可用
	$("#ghsave").attr("disabled","disabled");
	//清空用户余额
	$("#ghYHYE").attr("tip2","当前月费用： 元");
	$("#ghYHYE").attr("tip1","实时余额： 元");
	$("#ghYHYE .tip").html("实时余额：元, 当前月费用：元");
	$("#ghYHYE .jfed").html("");
	$(".jflastjf,.jfkdstoptime,.jfqfys,.jfghuiDelDate,.jfsuccessflag").html("");
	
	$("#ghFFFs").val($("#ghFFFs option:first").val());
	$("#ghFFFs").trigger("change");
	
	$("#multiHthDetail,#commonHthYfDetail").hide();
	$("#multiHthDetailTab,#commonHthYfDetailTab").html("");
	$("#ghmhdept1").val("").trigger("change");
	$("#ghMultiHths option").remove();
	

	if($("#defaultCheckComb").val()!="true"){
		$("#ghPayReport").attr("checked",false);
	}
	else{
		$("#ghPayReport").attr("checked",true);
	}
	
	$("#ghPayNotPrint").attr("checked",true);
	
	$("#ghInfo").removeData("ghlsz");
	$("#ghInfo").removeData("ghprepay");
	
}

/**********************************************************************
function name:    ghClearInfo
function:         电话缴费清空页面信息,按钮“重置”调用。

parameters:    
                  
return:           

description:      
**********************************************************************/
function ghClearInfo()
{
	ghClearInfoWithoutSearchBox();
	$("#ghSearchBox").val("");
	$("#ghSearchBox").select();
	$("#ghSearchBox").focus();
}

/**********************************************************************
function name:    phoneInfo
function:         电话缴费查询后显示数据。

parameters:    
                  
return:           

description:      
**********************************************************************/
function phoneInfo(pay_type)
{
	var xml = $("#ghInfo").data("payitem_data");
	$(xml).find("row:first").each(function()
	{
		var datarow = $(this);
		var dataval = undefined;
		$(".config_bill[xid='"+$.trim($("#ghFFFs option:selected").attr("cval"))+"'] span.billdeflet").each(function(){
			var dataid = $(this).attr("pjid");
			if(dataid!=undefined && $.trim(dataid)!="")
			{
				dataval = $(datarow).attr(dataid);
				if(dataval==null || dataval==undefined)
					dataval = "<font color=\"red\">E</font>";
				$(this).html(dataval);
			}
		});
		//结算方式
		$(".billdeflet[pjid='sflx']").html($("#ghFFFs option:selected").text());
		
		if(pay_type=="groupcustomer"){
			//ghBigHth();
			$("#multiHthDetail").show();
		}
		else
		{
			//如果用户欠费月数小于等于1，则不显示明细
			if (parseInt($("row:first",xml).attr("qfys"))>1)
			{			
				$("#commonHthYfDetail").show();
			}		
			else
			{
				$("#commonHthYfDetail").hide();
			}
		}
	});	
}	

/**********************************************************************
function name:    afterfind
function:         获取用户应缴费成功后执行的一些操作。

parameters:    
                  
return:           

description:      
**********************************************************************/
function afterfind(xml,pay_type)
{
	//获取应缴费
	var yjff = parseFloat($("row:first",xml).attr("yjf"));
	//同一帐期再次缴费时提示	
	var stip = $("row:first",xml).attr("tip");
	//普通客户被大客户代收后，在单独缴费时是否提示并停止缴费，
	//格式为：“Y/N提示信息”，Y表示提示就停止缴费 N表示只提示
	var sdstip = $("row:first",xml).attr("dsts");
	
	if(isNaN(yjff)) yjff = 0;
	$("#ghYJ").val(yjff<0?'0':yjff.toFixed(2));//合计应缴
	//如果有缴费，默认递交金额和实收金额
	if(yjff>0)
	{
		/*
		if($("#ghFFFs").val()=="cash")
			$("#ghSs").val(Math.ceil(yjff));
		else
			$("#ghSs").val(yjff);
		*/
		$("#ghSs").val(Math.ceil(yjff));
	}
	$("#ghSs").select().focus();
	
	//余额提示
	var ssye = parseFloat($("row:first",xml).attr("yhye"),10);
	if(isNaN(ssye)) ssye = "0.00";
	else ssye = ssye.toFixed(2);
	//实时余额
	$("#ghInfo").data("ssye",ssye);
	$("#ghInfo").data("byyecal",yjff);
	
	$("#ghInfo").data("dh",$("row:first",xml).attr("dh"));
	$("#ghInfo").data("hth",$("row:first",xml).attr("hth"));
	$("#ghInfo").data("yhmc",$("row:first",xml).attr("yhmc"));
	
	//获取预存标志 当前收费月已经打过票据 0：预存
	var ghprepay = $("row:first",xml).attr("prepay");
	if(isNaN(parseInt(ghprepay)))
		ghprepay = "0";
	$("#ghInfo").data("ghprepay",ghprepay);
		
	//是否可少收
	$("#ghInfo").data("PayLevel",$("row:first",xml).attr("sffs"));
	
	var out_bz9 = $("row:first",xml).attr("out_bz9");
	$("#ghYHYE").attr("tip2",$("row:first",xml).attr("curmonth")+"月费用：" + (isNaN(parseFloat(out_bz9))?"0.00":parseFloat(out_bz9).toFixed(2)) + " 元");
	if(ssye>=0)
		$("#ghYHYE").attr("tip1","实时余额：" + (ssye) + " 元");
	else
		$("#ghYHYE").attr("tip1","实时欠费：" + (ssye*(-1)) + " 元");
	$("#ghYHYE .tip").html($("#ghYHYE").attr("tip2") +", "+ $("#ghYHYE").attr("tip1"));
		
	//查询成功，清空输入账号
	$("#ghSearchBox").val("");
	//如果是大客户缴费，查询至此结束
	if(pay_type=="groupcustomer"){
		if(yjff<=0){
			$("#ghsave").attr("disabled","disabled");			
		}else{
			$("#ghsave").removeAttr("disabled");
		}
		return;
	}	
		
	if(yjff<=0)
		$("#ghYHYE span.jfed").html("，当前账期已缴费");		
	else
		$("#ghYHYE span.jfed").html("");	
		
	//取拆机日期
	var sinfo = $("row:first",xml).attr("state");
	if(sinfo==undefined)
		sinfo = "";
	if(sinfo!="")
	{
		if (sinfo=="拆机")
		{
			$(".jfghuiDelDate").html("，拆机：" + $("row:first",xml).attr("deldate"));
		}
		else
		{
			$(".jfghuiDelDate").html("，状态：" + sinfo);
		}
	}
	else
	{
		$(".jfghuiDelDate").html("");
	}
	//取欠费月数
	var qfys = $("row:first",xml).attr("qfys");
	if(qfys!="0"&&qfys!="")
		$(".jfqfys").html("欠费月数：" + qfys);
	else
		$(".jfqfys").html("");
	
	//取宽带到期时间
	var kdstoptime = $("row:first",xml).attr("kdend");
	if(kdstoptime!="" && kdstoptime!=undefined)
	{
		$(".jfkdstoptime").html("，宽带到期：" + kdstoptime);
	}
	else
		$(".jfkdstoptime").html("");
			
	
	$(".jflastjf").html("上次缴费 "+$("row:first",xml).attr("lastpay"));
	
	if(stip!="" && stip!=undefined)
	{
	    alert(stip.replace('\\n\\n','\n\n').replace('\\n','\n'));
	}
    
    //普通客户被大客户代收后，在单独缴费时是否提示并停止缴费，
	//格式为：“Y/N提示信息”，Y表示提示就停止缴费 N表示只提示
	if (sdstip!="" && sdstip!=undefined && pay_type!="groupcustomer")
	{
	   alert(sdstip.substring(1,256));
	   if (sdstip.substring(0,1)=="Y")
	   {
	     $("#ghsave").attr("disabled","disabled"); 
	     setTimeout("$('#ghSearchBox').select().focus()",200); 
	   }	  	 
	}
}

/**********************************************************************
function name:    showDetialofHth
function:         当用户欠费月数大于1时，取用户欠费明细。

parameters:    
                  
return:           

description:      
**********************************************************************/
function showDetialofHth()
{
	if($("#commonHthYfDetailTab tr").size()>2)	
	{
		return false;
	}
	$.ajax({
	url:"charge_phone?func=detail",
	async:true,//异步
	cache:false,
	timeout:50000,//1000表示1秒
	type:'post',
	success:function(xml, textStatus)
	{	
	    //session过期处理
	    if (typeof(xml)=="string")
	    {
		    if (xml == "session invalid")
		    {
		      	location.href="login.jsp";
		      	return false;
		    }
	    }
	    $("#commonHthYfDetailTab").html(xml);
	    $("#commonHthYfDetail").show();
	},
	error:function(XMLHttpRequest, textStatus, errorThrown)
	{

	}		
	});	
}
/**********************************************************************
function name:    numValid
function:         实收金额里限制输入两位小数。

parameters:    
                  
return:           

description:      
**********************************************************************/
function numValid(obj)
{		
	if($.browser.msie)
	{
		var dotPos = obj.value.indexOf(".");
		var lenAfterDot;
		
		if(dotPos==-1)
		{
			lenAfterDot = 0;
		}
		else
		{
			lenAfterDot = obj.value.length - dotPos -1;
		}
		
		var evt = window.event;
		if (evt.keyCode < 48 || evt.keyCode > 57)
		{
			if(evt.keyCode==46)
			{
				if(dotPos==-1)
					lenAfterDot=0;
				else
					evt.returnValue = false;
			}
			else
			{
				evt.returnValue = false;
			}
		}
		else
		{
			if(dotPos!=-1)
			{
				if(lenAfterDot>=2)
				{
					evt.returnValue = false;
				}
			}
		}
	}
	else
	{
		obj.value=obj.value.replace(/[^0-9]/g,'');
	}
}

/**********************************************************************
function name:    KeyDown_SsjeBox
function:         实收金额里回车事件。

parameters:    
                  
return:           

description:      
**********************************************************************/
function KeyDown_SsjeBox(event)
{
	if(event.keyCode==13)
	{
		if (document.getElementById("ghsave").disabled==false)
		{
			//执行保存
			$("#ghsave").click();
		}
	}
}

/**********************************************************************
function name:    onSave
function:         保存收费。

parameters:    
                  
return:           

description:      
**********************************************************************/
function onSave(pay_type)
{
	//取应交金额的值
	var yj = $("#ghYJ").val();
	yj=parseFloat(yj,10);

	//取实收金额的值
	var ss = $("#ghSs").val();
	ss=parseFloat(ss,10);
	if(isNaN(ss)) ss=0;
	
	//检测是否已进行用户查询
	if($("#ghInfo").data("dh")==undefined)
	{
		alert("请先进行用户查询");
		$("#ghSearchBox").select().focus();
		return false;
	}
	var resbz2 = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&cloum=bz2&tablename=hthdang&key=hth='"+$("#ghInfo").data("hth")+"'");
	if(resbz2[0][0]=="Y"&&pay_type!="groupcustomer"){
		alert("该电话已被大客户代收，不能单独缴费！");return;
	}
	
	if($.trim($("#ghSs").val())=="")
	{
		alert("请输入实收金额");
		$("#ghSs").select().focus();
		return false;
	}
	
	var ghYJ = $("#ghYJ").val();
	var ghss = $("#ghSs").val();
	ghYJ = parseFloat(ghYJ,10);
	ghss = parseFloat(ghss,10);	
	var numb = ghss-ghYJ;
	if(numb>1000000){alert("实收金额大于应交金额太大，请注意输入是否正确！");$("#ghSs").select().focus();return;}	
	
	//判断是否允许少收
	var sfss =  $("#ghInfo").data("PayLevel");

	if($("#ghInfo").data("tuifei")!="T")
	{
		if(sfss=="1" && ss<yj)
		{
			alert("当前应缴" + yj + "元，实收金额不能小于应缴金额");
			$("#ghSs").select().focus();
			return false;
		}
		//判断是否允许多收
		if(sfss=="2" && ss<yj)
		{
			alert("当前应缴" + yj + "元，实收金额不能大于应缴金额");
			$("#ghSs").select().focus();
			return false;
		}
		/*
		//判断是否必须与实收金额相同
		if(sfss =="3" && ss!=yj)
		{
			alert("当前应缴" + yj + "元，实收金额必须与应缴金额相同");
			$("#ghSs").select().focus();
			return false;
		}*/
	}
	//电话缴费 确认面板
	var info = "确认缴费\n\n";
	info += "合同号:\t\t";
	info += $("#ghInfo").data("hth");
	info += "\t\t\t";
	if($.browser.mozilla)
	{
		info += "\n电话号码:\t\t";
	}
	else
	{
		info += "\n电话号码:\t";
	}	
	info += $("#ghInfo").data("dh");
	info += "\t\t\t";
	
	info += "\n用户名:\t\t";
	info += $("#ghInfo").data("yhmc");
	if($.browser.mozilla)
	{
	  	info += "\n\n实收金额:\t\t";
	}
	else
	{
		info += "\n\n实收金额:\t";
	}
	info += $("#ghSs").val()+" 元";
	
	//AmountInWords 页面显示票据金额
	$("span[xjid='bcssd']").html(AmountInWords($("#ghSs").val(),2));
	$("span[xjid='bcsss']").html($("#ghSs").val());
	
	if($("#ghInfo").data("tuifei")!="T")//正常缴费
	{
		if(confirm(info))
		{
			/*if(JiaoFei())
			{
				$(".jfsuccessflag").html("本次缴费成功：缴费合同号" + $("#ghInfo").data("hth") + "，缴费电话：" + $("#ghInfo").data("dh") + "，缴费金额 ：" + $("#ghSs").val());
				//如果没有选择打印发票，则不打印
				if($("#ghPayNotPrint:checked").size()>0)
				{
					ghPrint(1);
				}
				setTimeout("$('#ghSearchBox').select().focus()",1000);
			}*/
			$("#ghsave").attr("disabled","disabled");
			$("#loading").show();
			JiaoFei(pay_type);
			
		}
	}
	else//退费
	{
		/*if(JiaoFei())
		{
			$(".jfsuccessflag").html("本次缴费成功：缴费合同号" + $("#ghInfo").data("hth") + "，缴费电话：" + $("#ghInfo").data("dh") + "，缴费金额 ：" + $("#ghSs").val());
			//如果没有选择打印发票，则不打印
			if($("#ghPayNotPrint:checked").size()>0)
			{
				ghPrint(1);
			}
			setTimeout("$('#ghSearchBox').select().focus()",1000);
		}*/
		$("#ghsave").attr("disabled","disabled");
		JiaoFei(pay_type);
	}
}

/**********************************************************************
function name:    JiaoFei
function:         调用电话缴费过程。

parameters:    
                  
return:           true: 缴费成功  false:失败  

description:      
**********************************************************************/
function JiaoFei(pay_type)
{
	//电话缴费实收金额
	var ghss = $("#ghSs").val();	
	var hbdy="0"; //是否合并打印 1：是 0：不是 合并打印时缴费后要更新jiaofei表里的票据张数
	ghss = parseFloat(ghss,10);
	var res="", stag="";
	var loginfo = encodeURIComponent("电话 缴费");
	loginfo += ";";
	loginfo += encodeURIComponent("电话号码");
	loginfo += ":";
	loginfo += $("#ghInfo").data("dh");
	loginfo += ";";
	loginfo += encodeURIComponent("合同号");
	loginfo += ":";
	loginfo += $("#ghInfo").data("hth");
	loginfo += ";";
	loginfo += encodeURIComponent("收款方式");
	loginfo += ":";
	loginfo += encodeURIComponent($.trim($("#ghFFFs").val()));
	loginfo += ";";
	loginfo += encodeURIComponent("金额");
	loginfo += ":";
	loginfo += ghss;
	
	if($("#ghPayReport:checked").size()>0)
	{
		loginfo += ";";
		loginfo += encodeURIComponent("合并打票");
		hbdy = "1";//合并打印
	}
	var prepay = $("#ghInfo").data("ghprepay");//是否预付费发票，0：预付费 其他	
	
	var dkhjfparam = "";
	var strbcss="";
	if(pay_type=="groupcustomer"){
		/*
		var ghYJ = $("#ghYJ").val();
		ghYJ = parseFloat(ghYJ,10);				
		var ssye = ghss-ghYJ;
		strbcss="&Bcss="+ghYJ+"&ssye="+ssye;
		*/
		dkhjfparam = "&inputdata=" + $("#ghInfo").data("hth")+"&groupcustid="+$("#ghInfo").data("hth");		
	}
	var successflag = false;
	//缴费
	$.ajax({
		url:"charge_phone?func=save&Version=200404&Kemu="+encodeURIComponent("电话费") + dkhjfparam +"&Bcss=" + ghss+ "&SkrID="+$("#skrid").val() + "&Skfs=" + encodeURIComponent($.trim($("#ghFFFs").val()))+"&loginfo="+loginfo+"&hbdy="+hbdy+"&prepay="+prepay,
		async:true,//异步
		cache:false,
		timeout:120000,//1000表示1秒
		type:'post',
		success:function(xml, textStatus)
		{	
		    //session过期处理
		    if (typeof(xml)=="string")
		    {
			    if (xml == "session invalid")
			    {
			      	location.href="login.jsp";
			      	return false;
			    }
		    }
		    res = $("row:first",xml).attr("res");//取结果标识
		    stag = $("row:first",xml).attr("tag");//取失败原因或成功后的流水号
		    if (res=="" || res=="SUCCEED")
		    {
		        //缴费成功
		        $("#ghInfo").data("ghlsz",stag);	
		        //alert(stag);
				successflag = true;
				$("#loading").hide();
				$(".jfsuccessflag").html("本次缴费成功：缴费合同号" + $("#ghInfo").data("hth") + "，缴费电话：" + $("#ghInfo").data("dh") + "，缴费金额 ：" + $("#ghSs").val());
				//如果没有选择打印发票，则不打印
				if($("#ghPayNotPrint:checked").size()>0)
				{
					ghPrint(1);
				}
				setTimeout("$('#ghSearchBox').select().focus()",1000);
				
				$("#ghUserInfo,#ghTuiFeiBtn").attr("disabled","disabled");	
		    }
		},
		error:function(XMLHttpRequest, textStatus, errorThrown)
		{
	       stag = textStatus+":"+errorThrown;
	       alert("缴费失败: "+stag);
	       $("#loading").hide();
		}
	});	
	
	return successflag;
}

//电话退费
function ghTuiFeiCfm()
{
	if($("#ghInfo").data("hth")==undefined)
	{
		alert("请先对需退费用户执行查询操作");
		$("#ghSearchBox").select().focus();
		return;
	}
	
	$.ajax({
	url:"charge_phone?func=checkout&dh="+$("#ghInfo").data("dh"),
	async:true,//异步
	cache:false,
	timeout:50000,//1000表示1秒
	type:'post',
	success:function(xml, textStatus)
	{	
	    //session过期处理
	    if (typeof(xml)=="string")
	    {
		    if (xml == "session invalid")
		    {
		      	location.href="login.jsp";
		      	return false;
		    }
	    }
	    //过程执行结果
	   	var res = $("row:first",xml).attr("res");
	   	if (res == "FAILED")
	   	{
	   	    //过程执行失败，提示过程返回的失败原因
	   		alert($("row:first",xml).attr("tag"));
	   		$("#ghSearchBox").select().focus();
	   		return false;
	   	}
	   	var yj = $("#ghInfo").data("byyecal");
		yj = parseFloat(yj,10);
		if(isNaN(yj))
			yj = 0;
		if(yj<0)
		{
			if(confirm("确定要对 " + $("#ghInfo").data("hth") + " 执行退费操作吗？当前可退费金额 " + yj*(-1) + " 元，点击确定将完成退费"))
			{
				$("#ghInfo").data("tuifei","T");
				$("#ghFFFs").val("cash").trigger("change");
				$("#ghSs").attr("disabled",true).val(yj);
				
				onSave();
			}
		}
		else
		{
			alert("当前用户无可退费用");
		}
	},
	error:function(XMLHttpRequest, textStatus, errorThrown)
	{
		alert("错误："+textStatus);
		$("#ghSearchBox").select().focus();
		return false;
	}		
	});	
}

/**********************************************************************
function name:    ghPrint
function:         电话打印。

parameters:       flag: 1:直接打印 2:不打印
                  
return:             

description:      
**********************************************************************/	
function ghPrint(flag)
{
	if(flag==2)
	{
		setTimeout($.unblockUI,1);
		ghClearInfo();
		return false;
	}

	//取缴费方式
	var paytype = $.trim($("#ghFFFs").val());
	var reportfile = "fixedphone_leave";

	reportfile = $("#ghFFFs option:selected").attr("rptfile");

	if($("#ghPayReport:checked").size()>0)
	{
		reportfile = reportfile + "_combined";
		//合并打印更新票据张数
		//executeNoQuery("revenue.updatepjzs",6,"&skrid=" + $("#skrid").val());
	}
	else
	{
		var notprinted = $("#ghInfo").data("ghprepay");
		if(notprinted=="0")
		{
			reportfile = reportfile + "_prepay";
		}
	}
	
	//printRep(reportfile,"&lsz=" + ,flag);	
	var sGhlsz = $("#ghInfo").data("ghlsz");
	//setTimeout($.unblockUI,1);
	
	//ghClearInfo();
	$("#ghInfo").removeData("hth");
	$("#ghInfo").removeData("dh");
	$("#ghInfo").removeData("ghlsz");
	$("#ghInfo").removeData("ghprepay");
	$("#ghsave").attr("disabled","disabled");
	if($("#defaultCheckComb").val()!="true"){
		$("#ghPayReport").attr("checked",false);
	}
	setTimeout('$("#ghSearchBox").select().focus()',1000);
	//打印
	printRep(reportfile,"&lsz=" + sGhlsz,flag);
}

//打开电话用户信息面板
function openDhUserInfoPanel()
{		
	var Hth = $("#ghInfo").data("hth");	
	var Dh = $("#ghInfo").data("dh");
	//业务
	ghJobLS(Dh);
	//缴费
	ghJFLS(Hth);//缴费移至查询成功之后
	//套餐信息
	//ghGetTaoCan(Dh);
	//调账信息
	//ghTZ(Dh);
	//扣费金额
	ghKFLS(Hth);
	//当月扣费详细信息
	//ghXX(Dh);
	ghCTCLS(Dh);
	ghGDFLS(Dh);
	//ghLTCLS(Dh);
	
	ghBasicInfoo(Dh);
	
	$("#ghuiJf").click();
	autoBlockForm('ghuserInfoPanel',20,'ghuserInfoPanelclose',"#FFFFFF",false);
}

 //电话缴费历史查询
function ghJFLS(Hth)
{
	var res = fetchMultiArrayValue("revenue.jflist",1,"&Hth="+Hth);
	if(res[0]==undefined||res[0][0]==undefined)
	{
		var temp = "";
		$("#ghuserInfoPanelTabJF").empty();
		
		temp += "<tr>";
		temp += "<td width=\"180\">缴费时间</td><td width=\"100\">缴费金额</td><td width=\"110\">缴费方式</td><td width=\"100\">营业员</td>";
		temp += "</tr>";
		
		$("#ghuserInfoPanelTabJF").append(temp);
		//取最新一条缴费记录
		$(".jflastjf").html("");
		return false;
	}
	else
	{
		var temp = "";			
		$("#ghuserInfoPanelTabJF").empty();
		
		temp += "<tr>";
		temp += "<td width=\"180\">缴费时间</td><td width=\"100\">缴费金额</td><td width=\"110\">缴费方式</td><td width=\"100\">营业员</td>";
		temp += "</tr>";
		
		for(var j=0;j<res.length;j++)
		{
			temp += "<tr>"
			temp += "<td>";
			temp += res[j][0];
			temp += "</td>";
			
			temp += "<td>";
			temp += res[j][2];
			temp += "</td>";
			
			temp += "<td>";
			temp += res[j][4];
			temp += "</td>";
			
			temp += "<td>";
			
			//替换工号为用户姓名
			temp += res[j][3];
			//temp += Clerks[res[j][3]]==undefined?"":Clerks[res[j][3]] + "(" + res[j][3] + ")";
			
			temp += "</td>";
			temp += "</tr>";
		}
		$("#ghuserInfoPanelTabJF").append(temp);
		
	}
}

//电话用户业务变更历史查询
function ghJobLS(Hth)
{
	var res = fetchMultiArrayValue("revenue.joblist",7,"&Dh="+Hth);
	if(res[0]==undefined||res[0][0]==undefined)
	{
		var temp = "";
		$("#ghuserInfoPanelTabJOB").empty();
		
		temp += "<tr>";
		temp += "<td width=\"140\">业务类型</td><td width=\"220\">工单记录时间</td><td width=\"130\">营业员</td>";
		temp += "</tr>";
		
		$("#ghuserInfoPanelTabJOB").append(temp);
		
		return false;
	}
	else
	{
		var temp = "";
		$("#ghuserInfoPanelTabJOB").empty();
		
		temp += "<tr>";
		temp += "<td width=\"140\">业务类型</td><td width=\"220\">工单记录时间</td><td width=\"130\">营业员</td>";
		temp += "</tr>";
		
		for(var j=0;j<res.length;j++)
		{
			temp += "<tr>"
			temp += "<td";
			temp += " title=\"" + res[j][3] + "\" ";				
			temp += ">";
			temp += res[j][1];
			temp += "</td>";
			temp += "<td>";
			temp += res[j][0];
			temp += "</td>";
			temp += "<td>";
			
			//替换工号为用户姓名
			temp += res[j][2];
			//temp += Clerks[res[j][2]]==undefined?"":Clerks[res[j][2]] + "(" + res[j][2] + ")";
			
			temp += "</td>";
			temp += "</tr>";
		}
		$("#ghuserInfoPanelTabJOB").append(temp);
	}
}

//电话用户这包月套餐查询
function ghCTCLS(Dh)
{
	var res = fetchMultiArrayValue("revenue.hfintime",6,"&dhh="+Dh);
	if(res[0]==undefined||res[0][0]==undefined)
	{
		var temp = "";
		$("#ghuserInfoPanelTabCTC").empty();
		
		temp += "<tr>";
		temp += "<td width=\"140\">包月类型</td><td width=\"220\">起始有效月</td><td width=\"130\">截止有效月</td>";
		temp += "</tr>";
		
		$("#ghuserInfoPanelTabCTC").append(temp);
		
		return false;
	}
	else
	{
		var temp = "";
		$("#ghuserInfoPanelTabCTC").empty();
		
		temp += "<tr>";
		temp += "<td width=\"140\">包月类型</td><td width=\"220\">起始有效月</td><td width=\"130\">截止有效月</td>";
		temp += "</tr>";
		
		for(var j=0;j<res.length;j++)
		{
			temp += "<tr>"
			temp += "<td";				
			temp += ">";
			temp += res[j][0];
			temp += "</td>";
			temp += "<td>";
			temp += res[j][1];
			temp += "</td>";
			temp += "<td>";
			
			temp += res[j][2];
			
			temp += "</td>";
			temp += "</tr>";
		}
		$("#ghuserInfoPanelTabCTC").append(temp);
	}
}

//电话用户优惠套餐查询
function ghLTCLS(Dh)
{
	var res = fetchMultiArrayValue("revenue.bytc",6,"&dhh="+Dh);
	if(res[0]==undefined||res[0][0]==undefined)
	{
		var temp = "";
		$("#ghuserInfoPanelTabLTC").empty();
		
		temp += "<tr>";
		temp += "<td width=\"240\">套餐类型</td><td width=\"170\">开通日期</td><td width=\"80\">开始计费月</td>";
		temp += "</tr>";
		
		$("#ghuserInfoPanelTabLTC").append(temp);
		
		return false;
	}
	else
	{
		var temp = "";
		$("#ghuserInfoPanelTabLTC").empty();
		
		temp += "<tr>";
		temp += "<td width=\"240\">套餐类型</td><td width=\"170\">开通日期</td><td width=\"80\">开始计费月</td>";
		temp += "</tr>";
		
		for(var j=0;j<res.length;j++)
		{
			temp += "<tr>"
			temp += "<td";				
			temp += ">";
			temp += res[j][0];
			temp += "</td>";
			temp += "<td>";
			temp += res[j][1];
			temp += "</td>";
			temp += "<td>";
			
			temp += res[j][2];
			
			temp += "</td>";
			temp += "</tr>";
		}
		$("#ghuserInfoPanelTabLTC").append(temp);
	}
}

//电话用户固定费查询
function ghGDFLS(Dh)
{
	var res = fetchMultiArrayValue("revenue.attachfee",6,"&dhh="+Dh);
	if(res[0]==undefined||res[0][0]==undefined)
	{
		var temp = "";
		$("#ghuserInfoPanelTabGDF").empty();
		
		temp += "<tr>";
		temp += "<td>费用类型</td><td>子类型</td><td>价格</td><td>停机价格</td><td>起始有效月</td><td>截止有效月</td>";
		temp += "</tr>";
		
		$("#ghuserInfoPanelTabGDF").append(temp);
		
		return false;
	}
	else
	{
		var temp = "";
		$("#ghuserInfoPanelTabGDF").empty();
		
		temp += "<tr>";
		temp += "<td>费用类型</td><td>子类型</td><td>价格</td><td>停机价格</td><td>起始有效月</td><td>截止有效月</td>";
		temp += "</tr>";
		
		for(var j=0;j<res.length;j++)
		{
			temp += "<tr>"
			temp += "<td";				
			temp += ">";
			temp += res[j][0];
			temp += "</td>";
			temp += "<td>";
			temp += res[j][1];
			temp += "</td>";
			temp += "<td>";				
			temp += res[j][2];				
			temp += "</td>";
			temp += "<td>";
			temp += res[j][3];
			temp += "</td>";
			temp += "<td>";
			temp += res[j][4];
			temp += "</td>";
			temp += "<td>";
			temp += res[j][5];
			temp += "</td>";
			temp += "</tr>";
		}
		$("#ghuserInfoPanelTabGDF").append(temp);
	}
}

//电话用户扣费查询
function ghKFLS(Hth)
{
	var temp = "";
	$("#ghuserInfoPanelTabKF").empty();		
	temp += "<tr>";
	temp += "<td>话费月份</td><td>合计</td><td>滞纳金</td><td>通话费</td><td>月固定费</td><td>调整费</td><td>套餐费</td><td>本月余额</td><td>上月余额</td><td>收款人</td>";
	temp += "</tr>";
	$("#ghuserInfoPanelTabKF").append(temp);
	
	var urlMm = tsd.buildParams({ packgname:'service',
			clsname:'ExecuteSql',//类名
			method:'exeSqlData',//方法名
			ds:"tsdCharge",
			tsdcf:'mssql',//指向配置文件名称
			tsdoper:'query',//操作类型 
			datatype:'xmlattr',//返回数据格式 
			tsdpk:"revenue.koufei"
			});
	
	$.ajax({
		url:"mainServlet.html?" + urlMm + "&hthh="+Hth,
		async:true,
		cache:false,
		timeout:200000,
		type:'post',
		success:function(xml){
			temp = "";
			$("#ghuserInfoPanelTabKF").empty();
			
			temp += "<tr>";
			temp += "<td>话费月份</td><td>合计</td><td>滞纳金</td><td>通话费</td><td>月固定费</td><td>调整费</td><td>套餐费</td><td>本月余额</td><td>上月余额</td><td>收款人</td>";
			temp += "</tr>";
			$(xml).find("row").each(function(){
				if($(this).attr("hzyf")!=undefined)
				{
					temp += "<tr>"
					temp += "<td";				
					temp += ">";
					temp += $(this).attr("hzyf");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("btheji");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("znj");
					temp += "</td>";
					temp += "<td>";				
					temp += $(this).attr("hf");				
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("zfs");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("jmhf");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("tcf");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("byye_ysk");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("syye_ysk");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("skr");
					temp += "</td>";
					temp += "</tr>";
				}
			});
			
			$("#ghuserInfoPanelTabKF").append(temp);
		}
	});
}

//取电话用户基本信息
function ghBasicInfoo(Dh)
{
	var res = fetchMultiArrayValue("revenue.ghbasicinfo",6,"&Dh="+Dh);
	if(res[0]==undefined||res[0][0]==undefined)
	{
		return false;
	}
	else
	{
		$("#ghuiDh").text(Dh);
		//合同号
		var hth = res[0][0];			
		$("#ghuiHth").text(hth);
		
		var yhmc = res[0][1];
		$("#ghuiYhmc,#ghuisRealNameTitle").text(yhmc);
		
		var yhdz = res[0][6];
		$("#ghuiYhdz").text(yhdz);
		
		//var hwjb = res[0][7];
		//$("#ghuiHwjb").text(getGhHwjb(hwjb));
		
		var mima = res[0][8];
		$("#ghuiMima").text(mima);			
		
		//var regdate = res[0][9];
		// $("#ghuiRegDate").text(regdate);  装机日期，已取消
		
		var startdate = res[0][10];
		$("#ghuiStartDate").text(startdate);
		
		var dhzt = res[0][11];
		$("#ghuiStatus").text(dhzt);
		
		var dhgn = res[0][12];
		$("#ghuiDhgn").text(dhgn);
		//中原油田，取模块局
		var ywarea = res[0][14];
		$("#ghuiYwArea").text(ywarea);		
					
		var bm1 = res[0][2];
		$("#ghuiBm1").text(bm1);
		var bm2 = res[0][3];
		$("#ghuiBm2").text(bm2);
		var bm3 = res[0][4];
		$("#ghuiBm3").text(bm3);
		var bm4 = res[0][5];
		$("#ghuiBm4").text(bm4);
		
		var deldate = res[0][15];
		if(deldate!="" && deldate!=undefined){
			$("#ghuiDelDate").html(deldate);
			$("#ghuiDelDate").closest("tr").css("display","block");
		}else
			$("#ghuiDelDate").closest("tr").css("display","none");			
		
		var reshth = fetchMultiArrayValue("revenue.ghbasichthinfo",6,"&Hth="+hth);
		if(reshth[0]==undefined||reshth[0][0]==undefined)
		{
			$("#ghuiYhlb").text("");
			return false;
		}
		else
		{
			var yhlb = reshth[0][0];
			$("#ghuiYhlb").text(yhlb);
		}
	}
}
