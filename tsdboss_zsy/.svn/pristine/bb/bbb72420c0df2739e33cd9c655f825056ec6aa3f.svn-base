<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String userid = (String) session.getAttribute("userid");
%>
var revenuetype = '';
function initData(pay_type)
{
	var revenueval = fetchSingleValue('charge_phone.revenuetype',6,'&feetype=phonefee');//是否配置收费类型
	if(revenueval!=undefined){
		revenuetype = revenueval;
	}else{
		//尚未配置系统收费类型，禁止收费
		alert('<fmt:message key="charge_phone_js.feetype"/>');
		return false;
	}
	initLoading();
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
						$("#defaultCheckComb").val('true');
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
		async:false,//异步
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
	//lvkui
	var userid = $('#userid').val();	
	var res=fetchMultiPValue('phone_paymode',6,'&userid='+userid+'&paymode='+$('#ghFFFs').val());
	if(res != undefined){
	  if (res[0][0]=='FAILED')
	  {
	      alert(res[0],[1]);
		  return;
	  }
	  else
	  {
	      if (res[0][1]!='no owe')
		  {
		     $("#ghInfo").data("byyecal",res[0][1]);
			 //$("#ghYJ").val(res[0][1]);
			 $("#ghSs,#ghDJ").val($("#ghYJ").val());
		  }
	  }
	}
	////end lvkui
	/*
	//取计算应缴费过程返回的应缴费，欠费时为正，有余额时为负,其余情况已处理为0	
	var yjff = $("#ghInfo").data("byyecal");
	yjff = parseFloat(yjff);	
	if(yjff>0)//欠费
	{
		var integerType = $("#integerType").val();//取整类型
			//根据付费方式来取整
			var charge_integerType = fetchSingleValue('dbsql_phone.querytsd_ini',6,'&tsection=charge_integerType&tident='+$('#ghFFFs').val());
			if(charge_integerType != undefined){
			   if(integerType=="floor"&&charge_integerType=='Y'){			   
			 		$("#ghSs,#ghDJ").val(Math.floor($("#ghYJ").val()));
					
				}else if(integerType=="ceil"&&charge_integerType=='Y'){
			  		$("#ghSs,#ghDJ").val(Math.floor($("#ghYJ").val()));
				}else{
					$("#ghSs,#ghDJ").val($("#ghYJ").val());
				}
			}
		
		//取大于欠费金额的最小整数
		//$("#ghSs").val(Math.floor(yjff));
	}
	*/
	$("#ghSs").select().focus();
	
	//切换显示
	//$(".config_bill").hide();
	//$(".config_bill[xid='" + $("#ghFFFs option:selected").attr("cval") + "']").show();

	//如果已经查询用户，则变更缴费方式时同步更新票据
	if($("#ghInfo").data("dh")!==undefined || pay_type=="groupcustomer")
	{
		phoneInfo();
	}
	$(".billdeflet[pjid='sflx']").html($("#ghFFFs option:selected").text());
	//通过支票进行付费的进行手动输入支票号，chenliang ，20120822
	$('#tsdSkvalText').val('');
	if(xcval.indexOf('cheque')!=-1||xcval.indexOf('inside')!=-1){
		$('#tsdSkvalSpan').show();$('#tsdSkvalText').show();
		var tsdWidth = '640';
		if(document.getElementById('ghDJ') != null && document.getElementById('ghDJ').style.display == 'none'){
				tsdWidth = '875';
		}
		$('#ghStatustb').css('width',tsdWidth);
		//$('#tsdSkval').focus();		 
		if($("#ghFFFs").val()=="inside"){
			$("#pjnumber").text("托收号：");
		}else if($("#ghFFFs").val()=="cheque"){
			$("#pjnumber").text("支票号：");
		}
	}else{
		$('#tsdSkvalSpan').hide();$('#tsdSkvalText').hide();$('#ghStatustb').css('width','660');
	}
	if($("#ghFFFs").val()=="prepayment"){
		$("#changeCash,#changeCashText,#xjycchange").show();
	}else{
		$("#changeCash,#changeCashText,#xjycchange").hide();
	}
	$("#ghSs").select();
	$("#ghSs").focus();
	$("#changeCash").removeAttr("checked");//清楚付费方式变更后要清楚预付转现金勾选框
}

function changeCashON(){
	if($("#ghInfo").data("hth")==""){
		alert("请先查询缴费用户。");
		$("#changeCash").removeAttr("checked");	
	}	
}

/**********************************************************************
function name:    btnFindClick
function:         电话缴费页面，在用户输入收费电话后点击查找按钮。

parameters:       pay_type : "normalcustomer" 普通客户  "groupcustomer" 大客户 
                  		payMonth：‘payment’：立即结算  ；或付费月份
return:           

description:      
**********************************************************************/
function btnFindClick(pay_type,payMonth,cashmode)
{
	
	//收费方式，包括：普通缴费 ：normal；立即结算：real ； 多合同号缴费 ：multi ；退费：back；大客户缴费：group
	$("#ghInfo").data("cashmode",cashmode);
	//控制头部多合同号显示区域的隐藏和显示
	multiHtsPandShow(cashmode);
	//根据当前缴费方式，限制某一种或几种缴费方式不可用
	//showPayType(cashmode);
	
	var dhNum = $.trim($("#ghSearchBox").val());

	var DKHFlag ="N";//缴费标识：N：普通缴费 Y:大客户缴费 M：多合同号缴费	
	if( cashmode=='multi' ){
		dhNum = $("#ghInfo").data("hthlist");
		DKHFlag="M";
	}else if (cashmode == 'multiOne'){
		dhNum = $("#multihthsel").val();		
		DKHFlag="MQ";
	}
	
	//是否为大客户缴费
	if("groupcustomer" == pay_type){
		dhNum = $("#ghInfo").data("hthlist");
		DKHFlag="Y";
	}

	if( dhNum=='')
  	{
		//清空上次查询内容
		ghClearInfo();
		alert("请输入查询电话");
		$("#ghSearchBox").select().focus();
		return false;
	}
   //立即结账	
	var paymentPrompt ="1、"+ $("#paymentPrompt1").val() +"\n2、"+  $("#paymentPrompt2").val()+"\n3、立即结账完成后，请立即拆机。\n4、立即结账后交费金额是您（当前收费月代收宽带费+当月话费）*1.2倍。\n5、立即结算后，用户将转成预付用户，请确认后在操作。";	
	if( payMonth=='payment' ){
		if(!confirm(paymentPrompt)){
			return false ;
		}
		$("#ghFFFs").attr("disabled","disabled");
	}else{
		$("#ghFFFs").removeAttr("disabled");
	}
	
	//加载信息提示框 chenliang 2012-01-08
	autoBlockForm('submitloading',30,'submitloadingclose',"#FFFFFF",false);
	ghClearInfoWithoutSearchBox();
	//var payMonth = $('#ghPayMonth').val() == undefined ? '' : $('#ghPayMonth').val();
	payMonth = payMonth == undefined ? '':payMonth;
	var array=[];
	array=dhNum.split(',');
	var strdhNum="";
	for(var i=0;i<=array.length;i++){		
		var reshth = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=count(1)&tablename=hthdang&key=hth='"+array[i]+"'");
		if(reshth==0){
			var resyhdang = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=hth&tablename=yhdang&key=dh='"+array[i]+"' and rownum<=1");
			if(resyhdang!=undefined&&resyhdang!=""){
				strdhNum=resyhdang.toString()+","+strdhNum.toString();
			}
		}else{
			strdhNum=array[i].toString()+","+strdhNum.toString();
		}
	}
	strdhNum=strdhNum.substring(0,strdhNum.length-1);
	var params = "&dh="+strdhNum+"&Sj_SfMonth="+payMonth;
	params += "&sSkfs="+encodeURIComponent($("#ghFFFs").val())+"&Kemu=" + encodeURIComponent(revenuetype);
	params += "&DKHFlag=" +DKHFlag ;
	$.ajax({
	url:"charge_phone?func=find" + params,
	async:true,//异步
	cache:false,
	timeout:60000,//1000表示1秒
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
	   		$("#submitloadingclose").click();
	   		return false;
	   	}
	   	//缓存合并打印发票数据 根据发票要求从表hfys_hthhf_out里取出的一条数据
		$("#ghInfo").data("payitem_data", xml);
		
		//解析数据 生成发票
		phoneInfo(pay_type);
		//保存按钮可用
		$("#ghsave").removeAttr("disabled");
		//2012-11-21 yhy 未收费打印票据
		$("#ghUnpaymentPrint").removeAttr("disabled");
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
		afterfind(xml,cashmode);
		//是否可少收，sffs：0：不能少收和多收，1：不能少收 可以多收，2：可以少收 可以多收
		$("row:first",xml).attr('sffs') == '2' ?$('#lessFeeBtn').show():$('#lessFeeBtn').hide();
		$('#ghPayMonth').val('');
		$('#addfreefee').val('');
		$('#feepaytypelist').html('');

		/* 
		* 目前不允许修改实收费用的地方有 少收、立即结算、多合同号缴费
		* payMonth == '' ? $('#ghSs').removeAttr('disabled'):$('#ghSs').attr('disabled','disabled');
		*/		
		//$('#ghSs').removeAttr('disabled');		
		$('#submitloadingclose').click();
	},
	error:function(XMLHttpRequest, textStatus, errorThrown)
	{
		alert("Error："+textStatus);
		$("#ghSearchBox").select().focus();
		$("#submitloadingclose").click();
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
				var rptConfig = '';
				/****************
				*   拼接权限参数 *
				**************/
				var tfbuttenright='';
				var printtype = '';
				var flag = false;				
				var UnpaymentRigth = 'false';	
				var UnpaymentRigthStr ='';
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
				var rptDiv = '';
				if(spower=='all@'){
						tfbuttenright='true';
						UnpaymentRigth ='true';
						rptConfig = 'all';
						printtype = 'combined';
						rptDiv += '<span class="spanstylept"><input type="checkbox" id="printTypephoneInvoice" name="printTypeChk" value="phoneInvoice" onclick=$("#ghSs").select().focus() />打印发票</span>';
						/** 默认只能先打一种 chenliang 2012-07-12 
						rptDiv += '<span class="spanstylept"><input type="checkbox" id="printTypephoneReceipt" name="printTypeChk" value="phoneReceipt" onclick=$("#ghSs").select().focus() />打印收据</span>';
						*/
						flag = true;
				}else if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');
						for(var i = 0;i<spowerarr.length-1;i++){
							tfbuttenright +=getCaption(spowerarr[i],'tfbutten','')+'|';//退费按钮是否可用
						}
						for(var i = 0;i<spowerarr.length-1;i++){
							rptConfig +=getCaption(spowerarr[i],'chargeprintreport','')+'|';//打印发票配置
						}
						for(var i = 0;i<spowerarr.length-1;i++){
							printtype +=getCaption(spowerarr[i],'printtype','')+'|';//打印类型配置
						}
						for(var i = 0;i<spowerarr.length-1;i++){
							UnpaymentRigthStr +=getCaption(spowerarr[i],'unpaymentRigth','')+'|';//未收费打印
						}
				}
				var hastfbutten = tfbuttenright.split('|');
				var hasprinttype = printtype.split('|');
				
				var str = 'true';
				if(flag==true){
					$("#tfbuttenright").val(tfbuttenright);
					$("#printtyperight").val(printtype);
				}else{
					for(var i = 0;i<hastfbutten.length;i++){
						$("#tfbuttenright").val(hastfbutten[i]);
						break;
					}
					for(var i = 0;i<hasprinttype.length;i++){
						if('undefined' != hasprinttype[i]){
							$("#printtyperight").val(hasprinttype[i]);
							break;
						}
						
					}
				}
				//2012-11-21 yhy start
				//未收费打印票据权限控制
				var hasUnpaymentRigth = UnpaymentRigthStr.split('|');				
				for(var i = 0;i<hasUnpaymentRigth.length;i++){
					if( hasUnpaymentRigth[i]=="true" ){
						UnpaymentRigth = 'true';
						break;
					}
				}
				
				if(UnpaymentRigth=="true"){
					$("#ghUnpaymentPrint").show();
				}
				//2012-11-21 yhy start
				if(rptConfig==''){
					rptDiv = '<span class="spanstylept"><input type="checkbox" name="printTypeChk" checked="checked" onclick=$("#ghSs").select().focus() />打印发票</span>';
				}else if(rptConfig!='all'){
					var rptArr = [];
					var rptConfigArr = rptConfig.split('|');
					for(var i = 0;i<rptConfigArr.length;i++){
						if(rptConfigArr[i]!=''){
							var rptval = rptConfigArr[i].split('|');
							for(var m = 0 ; m < rptval.length;m++){
								rptArr.push(rptval[m]);
							}
						}
					}
					var rptList = rptArr.join(',');
					rptArr = uniqueData_(rptList.split(','));
					for(var i in  rptArr){
						var rptField = rptArr[i] == 'phoneInvoice' ? '打印发票' :'打印收据';
						rptDiv += '<span class="spanstylept"><input type="checkbox" id="printType'+rptArr[i]+'" name="printTypeChk" value="'+rptArr[i]+'" onclick=$("#ghSs").select().focus() />'+rptField+'</span>';
					}
				}
				$('#printType').html(rptDiv);
				$('#ghPayNotPrint').click( function(){
						$(':radio[name="ghPayReport"]').attr('disabled',!$('#ghPayNotPrint').attr('checked'));
						//$(':checkbox[name="printTypeChk"]').attr('disabled',!$('#ghPayNotPrint').attr('checked'));
						var phoneInvoiceIsabled = $('#phoneInvoiceIsabled').val();
						var phoneReceiptIsabled = $('#phoneReceiptIsabled').val();
						
						if(phoneInvoiceIsabled == 'Y'){
							$('#printTypephoneInvoice').attr('disabled',!$('#ghPayNotPrint').attr('checked'));
						}
						if(phoneReceiptIsabled == 'Y'){
							$('#printTypephoneReceipt').attr('disabled',!$('#ghPayNotPrint').attr('checked'));
						}
				});
				//加载报表打印限制
				initPrintLimit();
			}

//初始化打印配置权限数据
function initPrintLimit(){
	//加载打印设置权限控制
	var res = fetchMultiArrayValue('charge_phone.optionlist',6,'&tsection=chargeprint');
	if(res[0][0] != undefined){
		var resLen = res.length;
		for(var i = 0 ; i < resLen;i++){
			_chargePrintLimit(res[i][0],res[i][1]);	
		}
	}
}

//打印限制
function _chargePrintLimit(tkey,tval){
	switch(tkey){
		case 'islimitprint'://打印复选框是否可选
			tval == 'Y' ? $('#ghPayNotPrint').removeAttr('disabled') : $('#ghPayNotPrint').attr('disabled','disabled') ;
     		break;
   		case 'defaultlimitprint'://默认打印复选框是否选中
   			tval == 'Y' ? $('#ghPayNotPrint').attr('checked','checked') : $('#ghPayNotPrint').removeAttr('checked');
     		break;
     	case 'isfreeselect'://是否可以自由选择打印方式
     		tval == 'Y' ? $('#prePayReport,#comPayReport').removeAttr('disabled') : $('#prePayReport,#comPayReport').attr('disabled','disabled');
     		break;
     	case 'defaultprint'://默认打印方式
     		//如果分配可扩展权限则扩展权限优先，负责按系统默认的打印方式
     		var printtype = $('#printtyperight').val();
     		tval = printtype == '' ? tval : printtype;
   			$(':radio[name=ghPayReport][value='+tval+']').attr('checked','checked');
     		break;
     	case 'phoneInvoice'://打印发票是否默认选中
     		tval == 'Y' ? $('#printTypephoneInvoice').attr('checked','checked') : $('#printTypephoneInvoice').removeAttr('checked');
     		break;
     	case 'phoneReceipt'://打印收据是否默认选中
   			tval == 'Y' ? $('#printTypephoneReceipt').attr('checked','checked') : $('#printTypephoneReceipt').removeAttr('checked');
     		break;
     	case 'phoneInvoiceIsabled'://打印发票是否可选
     		tval == 'Y' ? $('#printTypephoneInvoice').removeAttr('disabled') : $('#printTypephoneInvoice').attr('disabled','disabled');
     		$('#phoneInvoiceIsabled').val(tval);
     		break;
     	case 'phoneReceiptIsabled'://打印收据是否可选
   			tval == 'Y' ? $('#printTypephoneReceipt').removeAttr('disabled') : $('#printTypephoneReceipt').attr('disabled','disabled');
   			$('#phoneReceiptIsabled').val(tval);
     		break;
     	case 'displaySumFee':
     		tval == 'Y' ? sumSkrFee() : '';
     		$('#displaySumFee').val(tval);
     		break;
   		default:
   			alert('数据结果无效');
   }
}


//去除重复数组元素
function uniqueData_(data){   
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
	$('#lessFeeBtn').hide();
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
	//2012-11-21 yhy 未收费打印票据
	$("#ghUnpaymentPrint").attr("disabled","disabled");
	//清空用户余额
	$("#ghYHYE").attr("tip2",'<fmt:message key="charge_phone_js.currmonthfee"/>');//当前月费用： 元
	$("#ghYHYE").attr("tip1",'<fmt:message key="charge_phone_js.remainfee"/>');//实时余额： 元
	$("#ghYHYE .tip").html('<fmt:message key="charge_phone_js.feetips"/>');//实时余额：元, 当前月费用：元
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
	$('#feetypelist').val('');
	$("#ghInfo").removeData("ghlsz");
	$("#ghInfo").removeData("ghprepay");
	$('#lessFeeBtn').hide();
	$('#ghYz,#ghDJ').removeData('');
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
    //清空多合同号缴费面板
	$("#ghMultiHthDetTab").html("");
	//隐藏页面头部多合同号显示区域
	$("#multiHths").hide();
	$("#ghYJ,#ghDJ,#ghSs,#ghYz,#tsdSkvalText").val("0");
	$("#commonHthYfDetail").empty();
	$("#ghFFFs").val('cash');
	$("#TFBz").val("");
	$("#changeCash").removeAttr("checked");//清楚付费方式变更后要清楚预付转现金勾选框
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
	//$("#ghYJ,#ghDJ,#ghSs,#ghYz,#tsdSkvalText").val("0");
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
				if(dataval==null || dataval==undefined){
					dataval = "<font color='red'>E</font>";
				}
				if(dataid == "out_bz4"){
					$("#unpaymentLsh").val(dataval);
				}
				if(dataid == "hth"){
					$("#unpaymentHth").val(dataval);
					//进行多合同号查询时返回回来的hth保存在隐藏域中，
					$("#multihthsel").val(dataval);
					//获取应缴费
					$("#multihthyjf").val(parseFloat($("row:first",xml).attr("yjf")));
				}
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
function afterfind(xml,cashmode)
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
			$("#ghSs").val(Math.floor(yjff));
		else
			$("#ghSs").val(yjff);
		*/
		//如果只缴前几个月的费用了，本身就已经少收了。所以不能再次少收。而且这种按月少收时，对往月费用只能按实收，不能多也不能少，也不能取整。chenliang 2012-07-04
		//多合同号缴费同立即结算一样，不能多缴也不能少缴
		var feetype = $('#feetypelist').val();
		if(cashmode == 'real' || cashmode =='multi' || cashmode =='multiOne'){
			$("#ghSs").val(yjff);
			//2012-9-25 yhy start
			//jira上 HBKGJ-34				
			$('#ghDJ').val(yjff);
			$('#ghYz').val(0);
			//2012-9-25 yhy end	
			$('#ghSs').attr('disabled','disabled');
		}else if(feetype !='monthpay'){
			var isCeilCharge = $('#isCeilCharge').val();
			var integerType = $("#integerType").val();//取整类型
			if(isCeilCharge == 'Y'){			
				if(integerType=="floor"){
					yjff = Math.floor(yjff);	
				}else{
					yjff = Math.ceil(yjff);
				}				
			}
			$("#ghSs").val(yjff);
			//2012-9-25 yhy start
			//jira上 HBKGJ-34				
			$('#ghDJ').val(yjff);
			$('#ghYz').val(0);
			//2012-9-25 yhy end	
			$('#ghSs').removeAttr('disabled');
		}else{
			$("#ghSs").val(yjff);
			//2012-9-25 yhy start
			//jira上 HBKGJ-34				
			$('#ghDJ').val(yjff);
			$('#ghYz').val(0);
			//2012-9-25 yhy end	
			$('#ghSs').attr('disabled','disabled');
		}
	}else{
		$("#ghDJ,#ghSs,#ghYz,#tsdSkvalText").val("");
	}
	if($('#isAutoCalculate').val() == 'Y'){
		$("#ghSs").select();
		$("#ghDJ").focus();
	}else{
		$("#ghSs").select().focus();
	}
	
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
	
	var out_bz9 = $("row:first",xml).attr("out_bz9");				//月费用：
	$("#ghYHYE").attr("tip2",$("row:first",xml).attr("curmonth")+'<fmt:message key="charge_phone_js.monthfee"/>'+ (isNaN(parseFloat(out_bz9))?"0.00":parseFloat(out_bz9).toFixed(2)) + '<fmt:message key="charge_phone_js.rmb"/>');// 元
	if(ssye>=0)
		$("#ghYHYE").attr("tip1",'<fmt:message key="charge_phone_js.thisfee"/>' + (ssye) + '<fmt:message key="charge_phone_js.rmb"/>');//"实时余额：" + (ssye) + " 元"
	else
		$("#ghYHYE").attr("tip1",'<fmt:message key="charge_phone_js.thisremainfee"/>' + (ssye*(-1)) + '<fmt:message key="charge_phone_js.rmb"/>');//"实时欠费：" + (ssye*(-1)) + " 元"
	$("#ghYHYE .tip").html($("#ghYHYE").attr("tip2") +", "+ $("#ghYHYE").attr("tip1"));
		
	//查询成功，清空输入账号
	//$("#ghSearchBox").val(""); //不清空输入帐号 chenliang 2012-07-03 
	//如果是大客户缴费，查询至此结束
	if(cashmode=="group"){
		if(yjff<=0){
			$("#ghsave").attr("disabled","disabled");			
			//2012-11-21 yhy 未收费打印票据
			$("#ghUnpaymentPrint").attr("disabled","disabled");
		}else{
			$("#ghsave").removeAttr("disabled");
			//2012-11-21 yhy 未收费打印票据
			$("#ghUnpaymentPrint").removeAttr("disabled");
		}
		return;
	}	
		
	if(yjff<=0)
		$("#ghYHYE span.jfed").html('<fmt:message key="charge_phone_js.ispay"/>');//，当前账期已缴费	
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
			$(".jfghuiDelDate").html('<fmt:message key="charge_phone_js.deletephone"/>'+ $("row:first",xml).attr("deldate"));//"，拆机：" 
		}
		else
		{
			$(".jfghuiDelDate").html('<fmt:message key="charge_phone_js.phonestatus"/>' + sinfo);//"，状态："
		}
	}
	else
	{
		$(".jfghuiDelDate").html("");
	}
	//取欠费月数
	var qfys = $("row:first",xml).attr("qfys");
	if(qfys!="0"&&qfys!="")
		$(".jfqfys").html('<fmt:message key="charge_phone_js.owemonths"/>' + qfys);//"欠费月数："
	else
		$(".jfqfys").html("");
	
	//取宽带到期时间
	var kdstoptime = $("row:first",xml).attr("kdend");
	if(kdstoptime!="" && kdstoptime!=undefined)
	{
		$(".jfkdstoptime").html('<fmt:message key="charge_phone_js.broadbandstoptime"/>'+ kdstoptime);//"，宽带到期：" 
	}
	else
		$(".jfkdstoptime").html("");
			
	
	$(".jflastjf").html('<fmt:message key="charge_phone_js.lastpay"/>'+$("row:first",xml).attr("lastpay"));//"上次缴费 "
	
	if(stip!="" && stip!=undefined)
	{
	    alert(stip.replace('\\n\\n','\n\n').replace('\\n','\n'));
	}
    
    //普通客户被大客户代收后，在单独缴费时是否提示并停止缴费，
	//格式为：“Y/N提示信息”，Y表示提示就停止缴费 N表示只提示
	if (sdstip!="" && sdstip!=undefined && cashmode!="group")
	{
	   alert(sdstip.substring(1,256));
	   if (sdstip.substring(0,1)=="Y")
	   {
	     $("#ghsave").attr("disabled","disabled"); 
		 //2012-11-21 yhy 未收费打印票据
		$("#ghUnpaymentPrint").attr("disabled","disabled");
	     setTimeout("$('#ghSearchBox').select().focus()",200); 
	   }	  	 
	}
	//alert($("row:first",xml).attr("sflx"));
	if($("row:first",xml).attr("sflxto")=="prepayment"){
		$("#ghFFFs").val("prepayment");			
		payitem_change();
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
	//多合同号缴费时，话费明细每次只显示当前用户的话费明细
	var params = "&hth="+$("#multihthsel").val();
	$.ajax({
	url:"charge_phone?func=detail" +params,
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
function KeyUp_SsjeBox(){
	var dj = $("#ghDJ").val();
	//var yj = $("#ghYJ").val();
	var ss = $("#ghSs").val();
	dj = parseFloat(dj,10);
	ss = parseFloat(ss,10);		
	if(isNaN(dj)) dj = 0;
	if(isNaN(ss)) ss = 0;
	//if(parseFloat(yj) > 0){
		/*
		if(document.getElementById('ghDJ') != null && document.getElementById('ghDJ').style.display == '' && ss > dj){
			$("#ghYz").val(0);
			alert("实收金额不能大于递交金额");
			var yjVal = $('#ghYJ').val();
			$("#ghSs").val(yjVal);
			$("#ghYz").val(dj-yjVal);
			
			//2012-9-25 yhy start
			//jira上 HBKGJ-34					
			$('#ghDJ').val(yjVal);
			$('#ghYz').val(0);
			//2012-9-25 yhy end	
				
			$("#ghSs").select().focus();
			return false;
		}
		*/
		if(dj-ss<0){
			$("#ghYz").val(0);
		}else{
			$("#ghYz").val(dj-ss);
		}
	//}
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
		alert('<fmt:message key="charge_phone_js.userquery"/>');//"请先进行用户查询"
		$("#ghSearchBox").select().focus();
		return false;
	}
		
	var resbz2 = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&cloum=bz2&tablename=hthdang&key=hth='"+$("#ghInfo").data("hth")+"'");
	if(resbz2[0][0]=="Y"&&pay_type!="groupcustomer"){
		alert('<fmt:message key="charge_phone_js.groupispay"/>');return;//"该电话已被大客户代收，不能单独缴费！"
	}
	
	if($.trim($("#ghSs").val())=="")
	{
		alert('<fmt:message key="charge_phone_js.paidinpay"/>');//"请输入实收金额"
		$("#ghSs").select().focus();
		return false;
	}
	
	var ghYJ = $("#ghYJ").val();
	var ghss = $("#ghSs").val();
	ghYJ = parseFloat(ghYJ,10);
	ghss = parseFloat(ghss,10);
	
	var numb = ghss-ghYJ;//"实收金额大于应交金额太大，请注意输入是否正确！"
	if(numb>1000000){alert('<fmt:message key="charge_phone_js.payisright"/>');$("#ghSs").select().focus();return;}	
	
	//判断是否允许少收
	var sfss =  $("#ghInfo").data("PayLevel");

	if($("#ghInfo").data("tuifei")!="T")
	{
		/* chenliang 2012-07-03
		收费方式说明：sfss
		0：不能少收 和 多收
		1：不能少收 和 可以多收
		2：可以少收 和 可以多收
		*/
		if(sfss=="1" && ss<yj)
		{
			alert('<fmt:message key="charge_phone_js.shouldpay"/>' + yj + '<fmt:message key="charge_phone_js.shouldpaya"/>');//"当前应缴" + yj + "元，实收金额不能小于应缴金额"
			$("#ghSs").select().focus();
			return false;
		}
		/** chenliang 2012-07-03 注释
		//判断是否允许多收
		if(sfss=="2" && ss<yj)
		{
			alert("当前应缴" + yj + "元，实收金额不能大于应缴金额");
			$("#ghSs").select().focus();
			return false;
		}
		*/
		//chenliang 2012-07-03 增加，可以少收和多少但是不能小于0
		if(sfss == '2' && ss < 0){
			//alert("当前应缴" + yj + "元，实收金额不能大于应缴金额");
			alert('实收金额必须大于0');
			$("#ghSs").select().focus();
			return false;
		}

		// chenliang 2012-07-04 注释
		//判断是否允许多收
		//var selectVal = $('#feetypelist').val();//自由少收 freenesspay
		if(sfss=="2" && ss<Math.floor(yj) && $('#ghSs').attr('disabled')==false)
		{
			alert('<fmt:message key="charge_phone_js.shouldpay"/>' + yj + '<fmt:message key="charge_phone_js.shouldpaya"/>');//"当前应缴" + yj + "元，实收金额不能小于应缴金额"
			$("#ghSs").select().focus();
			return false;
		}
		//确认输入支票号，chenliang，2012-08-22
		var tsdSkval = $('#tsdSkvalText').val();	
		var xcval = $("#ghFFFs option:selected").attr("cval");		
		if(document.getElementById('tsdSkval') != null && document.getElementById('tsdSkval').style.display == '' && tsdSkval == '' && xcval.indexOf('cheque')!=-1){
			alert('请输入支票号');
			$('#tsdSkvalText').focus();
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
	var info = '<fmt:message key="charge_phone_js.confirmpay"/>\n\n';//确认缴费
	info += '<fmt:message key="charge_phone_js.payhth"/>\t';//合同号:
	info += $("#ghInfo").data("hth");
	info += "\t\t\t";
	if($.browser.mozilla)
	{
		info += '\n<fmt:message key="charge_phone_js.paydh"/>\t\t';//电话号码:
	}
	else
	{
		info += '\n<fmt:message key="charge_phone_js.paydh"/>\t';//电话号码:
	}	
	info += $("#ghInfo").data("dh");
	info += "\t\t\t";
	
	info += '\n<fmt:message key="charge_phone_js.payusername"/>\t';//用户名:
	info += $("#ghInfo").data("yhmc");
	if($.browser.mozilla)
	{
	  	info += '\n\n<fmt:message key="charge_phone_js.paythisfee"/>\t\t';//实收金额:
	}
	else
	{
		info += '\n\n<fmt:message key="charge_phone_js.paythisfee"/>\t';//实收金额:
	}
	info += $("#ghSs").val()+'<fmt:message key="charge_phone_js.rmb"/>';//" 元"
	
	//AmountInWords 页面显示票据金额
	$("span[xjid='bcssd']").html(AmountInWords($("#ghSs").val(),2));
	$("span[xjid='bcsss']").html($("#ghSs").val());
	
	if($("#ghInfo").data("tuifei")!="T")//正常缴费
	{
		if(ss<=0){
			alert("实收金额不能小于等于0");
			$("#ghSs").select().focus();
			return;
		}
		/*		
		if($("#ghFFFs").val()!="prepayment"){
			var resto=fetchMultiPValue('phone_paymode',6,'&userid='+$("#userid").val()+'&paymode=prepayment');
			if(resto != undefined){
				if (resto[0][1]!='no owe'&&(parseFloat($("#ghSs").val(),10)>resto[0][1])){
					alert("现金用户实收金额不能大于欠费金额！");
					$("#ghSs").select().focus();
					return;
				}
			}
		}else{
			if($("#changeCash").attr("checked")==true){
				if (parseFloat($("#ghSs").val(),10)>parseFloat($("#ghYJ").val(),10)){
					alert("预存转现金用户，不能大于欠费金额！");
					$("#ghSs").select().focus();
					return;
				}
			}
		}
		*/
		
		var res = fetchMultiArrayValue("dbsql_phone.fflx_pay_flag",6,"&hthstr="+tsd.encodeURIComponent($("#ghInfo").data("hth")));
		if($("#ghFFFs").val()=="prepayment"&&res[0][1]!=$("#ghFFFs").val()&&res[0][0]=="N"){
			alert("当前用户为现金用户，如果转换预付请结清费用！");
			return;
		}						
		
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
			//2012-11-21 yhy 未收费打印票据
			$("#ghUnpaymentPrint").attr("disabled","disabled");
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
		//2012-11-21 yhy 未收费打印票据
		$("#ghUnpaymentPrint").attr("disabled","disabled");
		JiaoFei(pay_type);
	}
	//隐藏页面头部多合同号显示区域
	$("#multiHths").hide();
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

	autoBlockForm('submitloading',30,'submitloadingclose',"#FFFFFF",false);	
	
	//缴费方式:
	var cashmode = $("#ghInfo").data("cashmode");
	//电话缴费实收金额
	var ghss = $("#ghSs").val();
	var hbdy="0"; //是否合并打印 1：是 0：不是 合并打印时缴费后要更新jiaofei表里的票据张数
	ghss = parseFloat(ghss,10);
	GOLAB_FEEPAY_payval = ghss;
	var res="", stag="";
	var loginfo = encodeURIComponent('<fmt:message key="charge_phone_js.payphonefee"/>');//电话 缴费
	loginfo += ";";
	loginfo += encodeURIComponent('<fmt:message key="charge_phone_js.paydh2"/>');//"电话号码"
	loginfo += ":";
	loginfo += $("#ghInfo").data("dh");
	loginfo += ";";
	loginfo += encodeURIComponent('<fmt:message key="charge_phone_js.payhth2"/>');//"合同号"
	loginfo += ":";
	loginfo += $("#ghInfo").data("hth");
	loginfo += ";";
	loginfo += encodeURIComponent('<fmt:message key="charge_phone_js.paytypes"/>');//"收款方式"
	loginfo += ":";
	loginfo += encodeURIComponent($.trim($("#ghFFFs").val()));
	loginfo += ";";
	loginfo += encodeURIComponent('<fmt:message key="charge_phone_js.payfee"/>');//"金额"
	loginfo += ":";
	loginfo += ghss;
	if($("#ghPayReport:checked").size()>0)
	{
		loginfo += ";";
		loginfo += encodeURIComponent('<fmt:message key="charge_phone_js.mergerreport"/>');//"合并打票"
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
	var fewtype = $('#feetypelist').val() == undefined ? '' : $('#feetypelist').val();
	
	var feepaystr= "&feepaytype="+encodeURIComponent(GOLAB_FEEPAY_paytype) +"&feepayval="+GOLAB_FEEPAY_payval ;
   
    var params = "&Version=200404" + "&Kemu="+encodeURIComponent(revenuetype);
	params += dkhjfparam;
	params += "&Bcss=" + ghss + "&SkrID="+$("#skrid").val();
	params += "&Skfs=" + encodeURIComponent($.trim($("#ghFFFs").val())) + "&loginfo="+loginfo;
	params += "&hbdy=" + hbdy + "&prepay=" + prepay + '&fewtype=' + fewtype;
	params += '&Skval=' + $('#tsdSkvalText').val() +"&cashmode="+cashmode;
	params += '&tfbz='+encodeURIComponent($("#TFBz").val().replace(/(^\s*)|(\s*$)/g,""));
	var changeCash=$("#changeCash").attr("checked");
	//缴费
	$.ajax({
		url:"charge_phone?func=save" + params +feepaystr,
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
				var cashHth=$("#ghInfo").data("hth");
		        $("#ghInfo").data("ghlsz",stag);					
		        //alert(stag);
				successflag = true;
				$('#lessFeeBtn').hide();
				$("#submitloadingclose").click();								
				//"本次缴费成功：缴费合同号"														"，缴费电话："																"，缴费金额 ："
				$(".jfsuccessflag").html('<fmt:message key="charge_phone_js.feeok"/>' + $("#ghInfo").data("hth") + '<fmt:message key="charge_phone_js.feedh"/>' + $("#ghInfo").data("dh") + '<fmt:message key="charge_phone_js.fee"/>' + $("#ghSs").val());
				//如果没有选择打印发票，则不打印
				if($("#ghPayNotPrint:checked").size()>0)
				{
					ghPrint(1);
				}
				setTimeout("$('#ghSearchBox').select().focus()",1000);
				$('#displaySumFee').val() == 'Y' ? sumSkrFee() : '';//是否显示当天累计收费
				$("#ghUserInfo,#ghTuiFeiBtn").attr("disabled","disabled");	
				//如果选择预存转现金，进行对应操作
				if(changeCash==true||changeCash=="true"){
					var restype = executeNoQuery("changehthdang.sflx",6,"&hthstr="+cashHth,'business');
					if(restype=="true"||restype=="true"){							
						executeNoQuery("changehthdang.sflx_log",6,"&hthstr="+cashHth+"&userid="+$("#skrid").val()+"&opertype=success",'business');
					}else{
						executeNoQuery("changehthdang.sflx_log",6,"&hthstr="+cashHth+"&userid="+$("#skrid").val()+"&opertype=failure",'business');
					}
				}
				ghClearInfo();//wenxuming				
				setTimeout($.unblockUI,15);
		    }else if (res=="FAILED"){
		        //缴费失败
		        successflag = false;
				$("#loading").hide();
				$('#lessFeeBtn').hide();
				$("#submitloadingclose").click();
				alert("对不起，缴费失败,原因："+stag);
		    }
		},
		error:function(XMLHttpRequest, textStatus, errorThrown)
		{
	       stag = textStatus+":"+errorThrown;
	       alert('<fmt:message key="charge_phone_js.feefaild"/>'+stag);//"缴费失败："
	       $("#submitloadingclose").click();
		}
	});		
	return successflag;
}

function ghTFtsk(){
	autoBlockForm('ghTFfrom',30,'submitloadingclose',"#FFFFFF",false);	
}

//电话退费
function ghTuiFeiCfm(cashmode)
{	
	//收费方式，包括：普通缴费 ：normal；立即结算：real ； 多合同号缴费 ：multi ；退费：back；大客户缴费：group
	$("#ghInfo").data("cashmode",cashmode);
	if($("#ghInfo").data("hth")==undefined)
	{
		alert('<fmt:message key="charge_phone_js.feetuifei"/>');//请先对需退费用户执行查询操作
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
		//"确定要对 "																	//" 执行退费操作吗？当前可退费金额 "										" 元，点击确定将完成退费"
			if(confirm('<fmt:message key="charge_phone_js.confirmfee"/>' + $("#ghInfo").data("hth") + '<fmt:message key="charge_phone_js.confirmcancel"/>' + yj*(-1) + '<fmt:message key="charge_phone_js.confirmcomplete"/>'))
			{
				$("#ghInfo").data("tuifei","T");
				//$("#ghFFFs").val("cash").trigger("change");
				$("#ghSs").attr("disabled",true).val(yj);
				//2012-9-25 yhy start
				//jira上 HBKGJ-34					
				$('#ghDJ').val(yj);
				$('#ghYz').val(0);
				//2012-9-25 yhy end							
				onSave();
			}
		}
		else
		{
			alert('<fmt:message key="charge_phone_js.confirmnofee"/>');//"当前用户无可退费用"
		}
	},
	error:function(XMLHttpRequest, textStatus, errorThrown)
	{
		alert('<fmt:message key="charge_phone_js.errormsg"/>'+textStatus);//"错误："
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
	if(flag==2){
		setTimeout($.unblockUI,1);
		ghClearInfo();
		return false;
	}
	//取缴费方式
	var paytype = $.trim($("#ghFFFs").val());
	var reportfile = $("#ghFFFs option:selected").attr("rptfile");
	var rptTypeChk = $(":radio[name='ghPayReport']:checked").val();
	if(rptTypeChk == 'combined'){
		reportfile = reportfile + "_combined";
	}else{
		var notprinted = $("#ghInfo").data("ghprepay");//是否预存
		if(notprinted == "0"){
			reportfile = reportfile + "_prepay";//业务预存
		}else{
			reportfile = reportfile + "_prepay";//分月打印
		}
	}
	/** chenliang 2012-07-11
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
	*/
	//printRep(reportfile,"&lsz=" + ,flag);	
	var sGhlsz = $("#ghInfo").data("ghlsz");
	//setTimeout($.unblockUI,1);
	//ghClearInfo();
	$("#ghInfo").removeData("hth");
	$("#ghInfo").removeData("dh");
	$("#ghInfo").removeData("ghlsz");
	$("#ghInfo").removeData("ghprepay");
	$("#ghsave").attr("disabled","disabled");
	//2012-11-21 yhy 未收费打印票据
	$("#ghUnpaymentPrint").attr("disabled","disabled");
	
	/**
	if($("#defaultCheckComb").val()!="true"){
		$("#ghPayReport").attr("checked",false);
	}
	*/
	setTimeout('$("#ghSearchBox").select().focus()',1000);
	var tagname = document.getElementsByName('printTypeChk');
	var rptArr = [];
	for (var i = 0 ; i < tagname.length; i++){
		if (tagname[i].checked == true) {
			rptArr.push(tagname[i].value);
		}
	}
	//alert(reportfile+'_'+rptArr[0])
	if(rptArr.length>1){
		/**
		$('#rptPrintLsz').val(sGhlsz);
		$('#rptPrintReport').val(reportfile);
		setTimeout("autoBlockForm('choosePrintForDhJF','150','close','#FFFFFF',false)",25);
		*/
		alert('系统测试中');
	}else if(rptArr.length==1){
		reportfile = reportfile+'_'+rptArr[0];
		printRep(reportfile,"&lsz=" + sGhlsz,flag);
		executeNoQuery('charge_phone.saveprintrpt',6,'&lsz='+sGhlsz+'&rptname='+reportfile);
		if($("#TFBz").val().replace(/(^\s*)|(\s*$)/g,"")!=""){
			executeNoQuery('charge_phone.hfys_hthhf_out_his_out_bz4',6,'&lsz='+sGhlsz+'&TFBz='+encodeURIComponent("退费说明："+$("#TFBz").val().replace(/(^\s*)|(\s*$)/g,"")));
		}		
	}
}
function chargePrint(flag){
	var reportfile = $('#rptPrintReport').val();
	var sGhlsz = $('#rptPrintLsz').val();
	printRep(reportfile+'_'+flag,"&lsz=" + sGhlsz,1);
	//setTimeout("autoBlockForm('choosePrintForDhJF','150','close','#FFFFFF',false)",25);
	//setTimeout($.unblockUI,1);
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
	autoBlockForm('ghuserInfoPanel',10,'ghuserInfoPanelclose',"#FFFFFF",false);
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
		//temp += "<td width=\"180\">缴费时间</td><td width=\"100\">缴费金额</td><td width=\"110\">缴费方式</td><td width=\"100\">营业员</td>";
		temp += '<td width="180"><fmt:message key="charge_phone_js.jiaofeitime"/></td><td width="100"><fmt:message key="charge_phone_js.payfeelist"/></td><td width="110"><fmt:message key="charge_phone_js.payfeetype"/></td><td width="100"><fmt:message key="charge_phone_js.paystaff"/></td>';
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
		//temp += "<td width=\"180\">缴费时间</td><td width=\"100\">缴费金额</td><td width=\"110\">缴费方式</td><td width=\"100\">营业员</td>";
		temp += '<td width="180"><fmt:message key="charge_phone_js.jiaofeitime"/></td><td width="100"><fmt:message key="charge_phone_js.payfeelist"/></td><td width="110"><fmt:message key="charge_phone_js.payfeetype"/></td><td width="100"><fmt:message key="charge_phone_js.paystaff"/></td>';
		
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
		//temp += '<td width="140">业务类型</td><td width="220">工单记录时间</td><td width="130">营业员</td>';
		temp += '<td width="140"><fmt:message key="charge_phone_js.busitype"/></td><td width="220"><fmt:message key="charge_phone_js.jobrectime"/></td><td width="130"><fmt:message key="charge_phone_js.paystaff"/></td>';
		temp += "</tr>";
		
		$("#ghuserInfoPanelTabJOB").append(temp);
		
		return false;
	}
	else
	{
		var temp = "";
		$("#ghuserInfoPanelTabJOB").empty();
		
		temp += "<tr>";
		//temp += '<td width="140">业务类型</td><td width="220">工单记录时间</td><td width="130">营业员</td>';
		temp += '<td width="140"><fmt:message key="charge_phone_js.busitype"/></td><td width="220"><fmt:message key="charge_phone_js.jobrectime"/></td><td width="130"><fmt:message key="charge_phone_js.paystaff"/></td>';
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

//电话用户这套餐查询
function ghCTCLS(Dh)
{
	var res = fetchMultiArrayValue("revenue.hfintime",6,"&dhh="+Dh);
	if(res[0]==undefined||res[0][0]==undefined)
	{
		var temp = "";
		$("#ghuserInfoPanelTabCTC").empty();
		
		temp += "<tr>";
		//temp += '<td width="140">包月类型</td><td width="220">起始有效月</td><td width="130">截止有效月</td>';
		temp += '<td width="140"><fmt:message key="charge_phone_js.monthtype"/></td><td width="220"><fmt:message key="charge_phone_js.startmonth"/></td><td width="130"><fmt:message key="charge_phone_js.endmonth"/></td>';
		temp += "</tr>";
		
		$("#ghuserInfoPanelTabCTC").append(temp);
		
		return false;
	}
	else
	{
		var temp = "";
		$("#ghuserInfoPanelTabCTC").empty();
		
		temp += "<tr>";
		//temp += '<td width="140">包月类型</td><td width="220">起始有效月</td><td width="130">截止有效月</td>';
		temp += '<td width="140"><fmt:message key="charge_phone_js.monthtype"/></td><td width="220"><fmt:message key="charge_phone_js.startmonth"/></td><td width="130"><fmt:message key="charge_phone_js.endmonth"/></td>';
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
		//temp += '<td width="240">套餐类型</td><td width="170">开通日期</td><td width="80">开始计费月</td>';
		temp += '<td width="240"><fmt:message key="charge_phone_js.packagetype"/></td><td width="170"><fmt:message key="charge_phone_js.startdate"/></td><td width="80"><fmt:message key="charge_phone_js.startregmonth"/></td>';
		temp += "</tr>";
		
		$("#ghuserInfoPanelTabLTC").append(temp);
		
		return false;
	}
	else
	{
		var temp = "";
		$("#ghuserInfoPanelTabLTC").empty();
		
		temp += "<tr>";
		//temp += '<td width="240">套餐类型</td><td width="170">开通日期</td><td width="80">开始计费月</td>';
		temp += '<td width="240"><fmt:message key="charge_phone_js.packagetype"/></td><td width="170"><fmt:message key="charge_phone_js.startdate"/></td><td width="80"><fmt:message key="charge_phone_js.startregmonth"/></td>';
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
		//temp += "<td>费用类型</td><td>子类型</td><td>价格</td><td>停机价格</td><td>起始有效月</td><td>截止有效月</td>";
		temp += '<td><fmt:message key="charge_phone_js.feetypess"/></td><td><fmt:message key="charge_phone_js.feechildtype"/></td><td><fmt:message key="charge_phone_js.feeprice"/></td><td><fmt:message key="charge_phone_js.feestopprice"/></td><td><fmt:message key="charge_phone_js.startvalmonth"/></td><td><fmt:message key="charge_phone_js.endvalmonth"/></td>';
		temp += "</tr>";
		
		$("#ghuserInfoPanelTabGDF").append(temp);
		
		return false;
	}
	else
	{
		var temp = "";
		$("#ghuserInfoPanelTabGDF").empty();
		
		temp += "<tr>";
		//temp += "<td>费用类型</td><td>子类型</td><td>价格</td><td>停机价格</td><td>起始有效月</td><td>截止有效月</td>";
		temp += '<td><fmt:message key="charge_phone_js.feetypess"/></td><td><fmt:message key="charge_phone_js.feechildtype"/></td><td><fmt:message key="charge_phone_js.feeprice"/></td><td><fmt:message key="charge_phone_js.feestopprice"/></td><td><fmt:message key="charge_phone_js.startvalmonth"/></td><td><fmt:message key="charge_phone_js.endvalmonth"/></td>';
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
	var subjecttemp = "";	
	subjecttemp += "<tr>";
	//subjecttemp += "<td>话费月份</td><td>合计</td><td>滞纳金</td><td>通话费</td><td>月固定费</td><td>调整费</td><td>套餐费</td><td>本月余额</td><td>上月余额</td><td>收款人</td>";
	//subjecttemp +='<td>话费月份</td><td>合计</td><td>应交费</td><td>累计实收</td><td>月租</td><td>新功能</td>';
	//subjecttemp +='<td>中兴宽带费</td><td>代收宽带费</td><td>话费合计</td><td>上月余额</td><td>本月余额</td>';
	//subjecttemp +='<td>结清标志</td><td>收款人</td>';
	
	subjecttemp += '<td><fmt:message key="charge_phone_js.hfmonth"/></td>';
	subjecttemp += '<td><fmt:message key="charge_phone_js.feeheji"/></td>';
	
	subjecttemp += '<td><fmt:message key="charge_phone_js.thispayfee"/></td>';
	subjecttemp += '<td><fmt:message key="charge_phone_js.cumulativecharge"/></td>';
	subjecttemp += '<td><fmt:message key="charge_phone_js.monthfixfee"/></td>';
	subjecttemp += '<td><fmt:message key="charge_phone_js.newfunction"/></td>';
	subjecttemp += '<td><fmt:message key="charge_phone_js.broadbandfee"/></td>';
	subjecttemp += '<td><fmt:message key="charge_phone_js.colbroadbandfee"/></td>';
	subjecttemp += '<td><fmt:message key="charge_phone_js.totalfee"/></td>';
	
	subjecttemp += '<td><fmt:message key="charge_phone_js.lastmonthfee"/></td>';
	subjecttemp += '<td><fmt:message key="charge_phone_js.thismonthfee"/></td>';	
	subjecttemp += '<td><fmt:message key="charge_phone_js.payflag"/></td>';
	subjecttemp += '<td><fmt:message key="charge_phone_js.skr"/></td>';
	subjecttemp += "</tr>";
	
	temp = subjecttemp;
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
			
			temp += subjecttemp;
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
					temp += $(this).attr("yjf");
					temp += "</td>";
					temp += "<td>";				
					temp += $(this).attr("byss");				
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("yz");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("zfs2");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("zfs5");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("zfs6");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("hf");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("syye_ysk");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("byye_ysk");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("pay_flag");
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
//初始化加载数据页面 chenliang 2012-01-11
function initLoading(){
	var initDiv = '';
	initDiv +='<div class="neirong" id="submitloading" style="display: none;">';
	initDiv +=	'<table cellspacing="5" style="float:right;width: 60%;text-align:right">';
	initDiv +=		'<tr><td style="font-size: 14px;font-weight: bold;"><fmt:message key="charge_phone_js.loading"/></td></tr>';	
	initDiv +=		'<tr><td><img src="style/images/public/loading.gif" style="margin-right:5px"/></td></tr>';
	initDiv +=	'</table>';
	initDiv +=	'<a href="#" id="submitloadingclose" style="display: none"><fmt:message key="global.close"/></a>';
	initDiv +='</div>';
	$('body').append(initDiv);
}
//只允许录入数据字符 0-9 和小数点
function tsdNumCheck(objTR){
   var txtval = objTR.value; 
   var key = event.keyCode;
   if((key < 48||key > 57) && key != 46 ){
     event.keyCode = 0;
   }else{
     if(key == 46){
       if(txtval.indexOf(".") != -1 || txtval.length == 0){
       	 event.keyCode = 0;
       }
     }
   }
}

//查找当日累计收费
function sumSkrFee(){
	var res = fetchSingleValue('charge.querySumFee',6,'&userid=<%=userid %>');//收费员工号
	if(res != undefined){
		$('#sumSkrFee').text('当日累计收费：'+res+'元');
		$('#sumSkrFee').show();
	}
}

//////////////////////////////////////////////////////////////////
/////////////////////////未收费票据打印/////////////////////////
//////////////////////////////////////////////////////////////////
/**
 * 未收费打印
 * @param flag：打印方式
 * @return 无返回值
 */
function unPaymentPrintDo(flag)
{
	var printfile ='';
	var params = '';
	//合同号
	var hth= $("#unpaymentHth").val();
	var lsh= $("#unpaymentLsh").val();
	printfile = 'unPaymentReceipt';
	params += "&skrid=" + encodeURIComponent(cjkEncode($("#skrid").val()));	
	params += "&area=" + encodeURIComponent(cjkEncode($("#area").val())); 	
	params += "&hth=" + encodeURIComponent(cjkEncode(hth));
	params += "&lsh=" + encodeURIComponent(cjkEncode(lsh));
 	if(flag==0)
 	{
    	var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/"+printfile+".cpt"+params;
		window.showModalDialog(urll,window,"dialogWidth:800px; dialogHeight:530px; center:yes; scroll:no");
	} else if(flag==1) 	{
 		printRep(printfile,params,flag);
 	} else if(flag==2){		
 	}
 	ghClearInfo();
 	setTimeout($.unblockUI,1);
}
/**
 *点击未收费打印票据， 打开打印票据面板
 */
function ghOpenUnpaymentDiv(){
	setTimeout('autoBlockForm("unpaymentPrintDiv","150","ghUnpaymentNoPrintRe","#FFFFFF",false)',25);
}

