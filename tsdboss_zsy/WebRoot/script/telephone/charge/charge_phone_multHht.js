/**********************************************************************************
**          *******         ******  *******     **       *****                   **  
**             *            *          *       ** **     *    *                  **
**             *   ******   ******     *      **   **    *****                   ** 
**             *                 *     *     ** *** **   *  *                    **
**             *            ******     *    **       **  *    *                  **
**                                                                               **               
** name:    "WebRoot/script/telephone/charge/charge_phone_multHht.js"                    **
** version: v10.1                                                                ** 
** author:  yhy                                                             **
** date:    2012-11-22                                                          **
** desc:    收费结帐专用js脚本。                                                            **
**          只有"WebRoot/WEB-INF/template/telephone/charge/charge_phone.jsp"调用。 **
** modify:                                                                       ** 
**                        **
***********************************************************************************/

	
/**********************************************************************
function name:    ghOpenMultiHthForm
function:         弹出多合同号输入面板

parameters:       
                  
return:           

description:      
**********************************************************************/	
	function ghOpenMultiHthForm()
	{
		//清空页面信息
		ghClearInfo();		
		autoBlockForm('ghMultiHthJf',20,'ghMultiHthJfclose',"#FFFFFF",false);
		//如果 是第一次打开面板，获取用户性质
		/*
		if($("#ghInfo").data("multiPayYhxzInit")!="true")
			ghMultiPayYhxz();
		*/
	}
	


	/**********************************************************************
	function name:    ghMultiHthJfPay
	function:         多合同号缴费确认面板
	
	parameters:       
	                  
	return:           
	
	description:      
	**********************************************************************/	
	function ghMultiHthJfPay(cashmode)
	{		
		var hths = [];
		var multihths ="";
		var hthvalue;
		/*
		//存放合同号的元素由select框改为text。
		var hthfist = $("#ghMultiHths option:first").attr("value");
		
		$("#ghMultiHths option").each(function(){
			hthvalue =$(this).attr("value") ;
			hths.push(hthvalue);
			multihths +='<span type="text" class="multiHthSpan_sel" onclick="javascript:getSelHthInfo(\'' + hthvalue + '\');" title="'+hthvalue+'">'+hthvalue +'</span>';
		});
		*/
		//获取输入的合同号
		var hthl = $("#ghSearchBox").val();
		if($.trim(hthl)!="")
		{
			hths = hthl.replace(/\n+/g,",").replace(/\s/g,'').split(",");
		}
		for(var i=0 ;i< hths.length;i++){
			hthvalue = hths[i];
			multihths +='<span type="text" class="multiHthSpan_sel" onclick="javascript:getSelHthInfo(\'' + hthvalue + '\');" title="'+hthvalue+'">'+hthvalue +'</span>';
		}
			
		$("#multiHths").html(multihths);	
		//设置第一个合同号为选中状态
		//多合同号缴费：只支持至少2个合同号，最多10个合同号以内的多合同号缴费
		var hthlen = hths.length;
		if(hthlen>10 || hthlen<=1){
			alert("您提交的合同号的个数为" + hthlen+ "个。多合同号缴费只支持至少\n2个合同号，最多10个合同号以内的多合同号缴费。");
			return false;
		}
		hths = hths.join(",");
		if(hths=="" || hths==undefined)
		{
			alert("请设置要缴费的合同号");
			return false;
		}
		var hthd = hths;
		
		//检测输入的合同号的正确性
		var ress = fetchMultiPValue("revenue.multihthcheck",6,"&pnums=" + tsd.encodeURIComponent(hthd));
		
		if(ress[0]!=undefined && ress[0][0]!=undefined)
		{
			if(ress[0][0]=="ERROR")
			{
				if(ress[0][1]=="No nums input")
					alert("请输入合同号");
				else
					alert(ress[0][1] + " 为无效合同号,请确认输入正确的合同号");
				return false;
			}
		}
		$("#ghInfo").data("hthlist",hthd);
		$("#ghInfo").data("hthlistpay","Y");
		//$("#ghSearchBox").val(hthd);
		$("#ghSearchBox").val("");	
		//调用查询方法，传入多合同号查询标识
		btnFindClick('multiHth','',cashmode);
		//进行多合同号查询时返回回来的hth 字体演示突出显示,由于ajax调用的时间有延迟，此处需要延迟才能拿到返回的合同号。
		setTimeout('setCssforSel($("#multihthsel").val())',300);	
		//setTimeout('getSelHthInfo("'+hthfist+'")',300);	
		setTimeout($.unblockUI,100);	
	}
	/**
		获取单个合同号的信息
	*/
	function getSelHthInfo(hth){
		$("#multihthsel").val(hth);
		setCssforSel(hth);
		var multihthyjf =$("#multihthyjf").val(); //多合同号本次总合计
		btnFindClick('multiHth',multihthyjf,'multiOne');
	}
	/**
	function getSelHthInfo(hth){
		$("#multihthsel").val(hth);
		setCssforSel(hth);
		var urlstr=tsd.buildParams({ 
							  packgname:'service',//java包
							  clsname:'ExecuteSql',//类名
							  method:'exeSqlData',//方法名
							  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
							  tsdcf:'mssql',//指向配置文件名称
							  tsdoper:'query',//操作类型
							  datatype:'xmlattr',//返回数据格式
							  tsdpk:'charge_phone.getHthInfoalone'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		});
		urlstr = urlstr+'&hth='+hth+'&skrid='+$("#skrid").val();				
		$.ajax({
			url:'mainServlet.html?'+urlstr,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
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
							}
							$(this).html(dataval);
						}
					});
					//结算方式
					$(".billdeflet[pjid='sflx']").html($("#ghFFFs option:selected").text());
					
					
				});	
			},
			error:function(){
				alert("无法获取该用户的费用信息。");
			}
		});	
		
	}
	*/
	/**
		切换选中合同号的样式
	*/
	function setCssforSel(hth){
	   $("#multiHths span").attr("class","multiHthSpan");
	   $("#multiHths span[title='"+hth+"']").attr("class","multiHthSpan_sel");		
	}
	
	/**
		添加单个合同号
		param:querytype：查询方式 ;目前支持两种查询方式，一种是精确查询一种是模糊查询
		      querytype=accurate；--精确查询
		      querytype=fuzzy；--模糊查询
	*/
	function ghSingleAddToHths(querytype)
	{
		var hthinput = $.trim($("#ghSingleAddInput").val());
		if(hthinput==""){
			alert("请输入要添加的合同号");
			$("#ghSingleAddInput").select().focus();
			return false;
		}
		var sqlstr='';
		if( querytype=='accurate' ){
			sqlstr='charge_phone_multi.getHthsA';
		}else if( querytype=='fuzzy' ){
			sqlstr='charge_phone_multi.getHthsF';
		}
		var res = fetchMultiArrayValue(sqlstr,6,"&hthh="+tsd.encodeURIComponent(hthinput));
		if(res[0]!=undefined && res[0][0]!=undefined)
		{
			var yhmc = res[0][3];
			var hth = res[0][0];
			//alert(typeof $("#ghInfo").data("hthlist"));
			/*
			if($("#ghInfo").data("hthlist")!=undefined)
				$("#ghInfo").data("hthlist")[hth]=hth;
			else
			{
				var obj = new Object();
				obj[hth]=hth+"("+yhmc+")";
				$("#ghInfo").data("hthlist",obj);
			}
			
			ghDisMultiHthToArea();
			*/
			/*
			if($("#ghMultiHths").find("option[value='" + hth + "']").size()==0)
				$("#ghMultiHths").append("<option value='"+hth+"'>"+hth+"</option>");
			else
			{
				alert("你所添加的号码已经存在");
				$("#ghMultiHths").val(hth);
				$("#ghSingleAddInput").select().focus();
			}
			
			*/
			/*
			2012-11-26 yhy start
			//如果输入的是大客户号，则查询二级合同号
			if(res[0][2]=="1"){
				res = fetchMultiArrayValue("revenue.getthreehth",6,"&hthh="+tsd.encodeURIComponent(hthinput));
			}
			2012-11-26 yhy end
			*/
			ghDrawHths(res);
			// 精确查询 将查询出来的结果全部设置为选中
			if(querytype =='accurate'){
				$('#ghMultiHthDetTab :checkbox').not(':checked').click();
			}	
		}
		else
		{
			alert("你所输入的合同号不存在");
			$("#ghSingleAddInput").select().focus();
		}
	}
	
	function ghDrawHths(hths)
	{
		if(hths[0]!=undefined && hths[0][0]!=undefined)
		{
			var tabHtml = "";
			var ii = 0;
			for(ii ;ii<hths.length;ii++)
			{
				
				tabHtml += "<tr>";	
				tabHtml += "<td>";
				tabHtml += "<input type=\"checkbox\" id=\"gmh_" + hths[ii][0] + "\" value=\"" + hths[ii][0] + "\" usertype=\""+hths[ii][2]+"\" />";
				tabHtml += "<span  title=\"合同号：" +hths[ii][0]+ ";用户姓名："+hths[ii][1]+"\" for=\"gmh_" + hths[ii][0] + "\">" ;
				tabHtml += "合同号：" + hths[ii][0] + "   电话号码：" + hths[ii][1];
				tabHtml += "   电话状态：" + hths[ii][2] + "   用户名称：" + hths[ii][3];
				tabHtml += "   用户地址：" + hths[ii][4];
				tabHtml += " </span>";
				tabHtml += "</td>";	
				tabHtml += "</tr>";	
			}			
			if(hths.length>0){
				tabHtml = "<tr><td style=\"text-align:center;\" ><button class=\"tsdbutton\" style=\"margin-bottom: 0px;line-height:22px\" onclick=\"$('#ghMultiHthDetTab :checkbox').not(':checked').click()\">全选</button><button class=\"tsdbutton\" style=\"margin-bottom: 0px;line-height:22px\" onclick=\"$('#ghMultiHthDetTab :checkbox').click()\">反选</button></td></tr>" + tabHtml;
			}
			//alert(tabHtml);
			$("#ghMultiHthDetTab").html(tabHtml);
		}
		else{
			$("#ghMultiHthDetTab").html("");
		}

		$("#ghMultiHths option").each(function(){
			//hths.push($(this).attr("value"));
			$("#ghMultiHthDetTab :checkbox[value='"+$(this).attr("value")+"']").attr("checked",true);
		});
	}
	
	//多合同号缴费面板
	function ghLoadDept()
	{
		var res = fetchMultiArrayValue("revenue.bm1list",6,"");
		var optHtml = "<option value=\"\">请选择</option>";
		if(res[0]!=undefined && res[0][0]!=undefined)
		{
			for(var ii=0;ii<res.length;ii++)
			{
				optHtml += "<option value=\"" + res[ii][0] + "\">" + res[ii][0] + "</option>";
			}
		}
		$("#ghmhdept1").html(optHtml);
		//二级地址
		$("#ghmhdept1").bind("change",function(){
			var tval = $("#ghmhdept1").val();
			if(tval=="") tval="~";
			res = fetchMultiArrayValue("revenue.bm2list",6,"&bm1=" + tsd.encodeURIComponent(tval));
			optHtml = "<option value=\"\">请选择</option>";
			if(res[0]!=undefined && res[0][0]!=undefined)
			{
				for(var ii=0;ii<res.length;ii++)
				{
					optHtml += "<option value=\"" + res[ii][0] + "\">" + res[ii][0] + "</option>";
				}
			}
			$("#ghmhdept2").html(optHtml).trigger("change");
			//ghLoadHthList();
			$("#ghMultiHths option").remove();
		});
		//三级地址
		$("#ghmhdept2").bind("change",function(){
			var tval = $("#ghmhdept2").val();
			var bm1 = $("#ghmhdept1").val();
			if(tval=="") tval="~";
			if(bm1=="") bm1="~";
			res = fetchMultiArrayValue("revenue.bm3list",6,"&bm1=" + tsd.encodeURIComponent(bm1) + "&bm2=" + tsd.encodeURIComponent(tval));
			optHtml = "<option value=\"\">请选择</option>";
			if(res[0]!=undefined && res[0][0]!=undefined)
			{
				for(var ii=0;ii<res.length;ii++)
				{
					optHtml += "<option value=\"" + res[ii][0] + "\">" + res[ii][0] + "</option>";
				}
			}
			$("#ghmhdept3").html(optHtml).trigger("change");
			//ghLoadHthList();
		});
		//四级地址
		$("#ghmhdept3").bind("change",function(){
			var tval = $("#ghmhdept3").val();
			var bm1 = $("#ghmhdept1").val();
			var bm2 = $("#ghmhdept2").val();
			if(tval=="") tval="~";
			if(bm1=="") bm1="~";
			if(bm2=="") bm2="~";
			res = fetchMultiArrayValue("revenue.bm4list",6,"&bm1=" + tsd.encodeURIComponent(bm1) + "&bm2=" + tsd.encodeURIComponent(bm2) + "&bm3=" + tsd.encodeURIComponent(tval));
			optHtml = "<option value=\"\">请选择</option>";
			if(res[0]!=undefined && res[0][0]!=undefined)
			{
				for(var ii=0;ii<res.length;ii++)
				{
					optHtml += "<option value=\"" + res[ii][0] + "\">" + res[ii][0] + "</option>";
				}
			}
			$("#ghmhdept4").html(optHtml).trigger("change");			
		});
		
		$("#ghmhdept4").bind("change",function(){
			ghLoadHthList();
		});
		
		res=fetchMultiArrayValue("revenue.yhlblist",6,"");
		optHtml = "<option value=\"\">请选择</option>";
		if(res[0]!=undefined && res[0][0]!=undefined)
		{
			for(var ii=0;ii<res.length;ii++)
			{
				optHtml += "<option value=\"" + res[ii][1] + "\">" + res[ii][1] + "</option>";
			}
		}
		
		$("#ghmhyhlb").html(optHtml).change(function(){
			ghLoadHthList();
		});
		
		//合同号列表选择触发
		$("#ghMultiHthDetTab td :checkbox").live("click",function(){
			/*  更换显示方式 
			var hths = "";
			var hthsdis = "";
			$("#ghMultiHthDetTab td :checkbox:checked").each(function(){
				hths += "," + $(this).val();
				hthsdis += "," + $(this).parent().text();
			});
			$("#ghMultiHths").val(hthsdis.replace(",","").replace(/,/g,"\n"));
			*/
			var hths = $(this).val();
			var hthsdis = $(this).parent().text();
			/*
			if($("#ghInfo").data("hthlist")!=undefined)
			{
				var obj = $("#ghInfo").data("hthlist");
				alert($("#" + $(this).attr("id") + ":checked").size());
				if($("#" + $(this).attr("id") + ":checked").size()==0)
					delete obj[hths];
				else
					obj[hths]=hthsdis;
				
				$("#ghInfo").data("hthlist",obj);
			}
			else
			{
				var obj = new Object();
				obj[hths]=hthsdis;
				$("#ghInfo").data("hthlist",new Object());
				
			}
			//触发textarea显示事件	
			ghDisMultiHthToArea();
			*/
			if($("#" + $(this).attr("id") + ":checked").size()>0)
			{
				//if($.inArray(hths,$("#ghMultiHths").val().split("\n"))==-1)
					//$("#ghMultiHths").val($.trim($("#ghMultiHths").val()+"\n"+hths));
				if($("#ghMultiHths").find("option[value='" + hths + "']").size()==0)
					$("#ghMultiHths").append("<option value='"+hths+"'>"+hths+"</option>");
			}
			else
			{
				/*var cval = $("#ghMultiHths").val();
				$("#ghMultiHths").val("");
				if(cval!="")
				{
					var hthsss = cval.split("\n");
					for(var ik=0;ik<hthsss.length;ik++)
						if(hthsss[ik]!=hths)
							$("#ghMultiHths").val($.trim($("#ghMultiHths").val()+"\n"+hthsss[ik]));
				}*/
				$("#ghMultiHths").find("option[value='" + hths + "']").remove();
			}
		});
		$("#ghMultiHthDetTab td span").live("click",function(){
			$(this).parent().find(":checkbox:first").click();
		});
	}
	
	function ghLoadHthList()
	{
		var bm1 = $("#ghmhdept1").val();
		var bm2 = $("#ghmhdept2").val();
		var bm3 = $("#ghmhdept3").val();
		var bm4 = $("#ghmhdept4").val();
		var yhlb = $("#ghmhyhlb").val();
		
		if($("#ghmhdept1").val()=="") bm1="'~'"; else bm1="'" + bm1 + "'";
		if($("#ghmhdept2").val()=="") bm2="bm2 or bm2 is null"; else bm2="'" + bm2 + "'";
		if($("#ghmhdept3").val()=="") bm3="bm3 or bm3 is null"; else bm3="'" + bm3 + "'";
		if($("#ghmhdept4").val()=="") bm4="bm4 or bm4 is null"; else bm4="'" + bm4 + "'";
		if($("#ghmhyhlb").val()=="") yhlb="yhlb or yhlb is null"; else yhlb="'" + yhlb + "'";
		
		var res = fetchMultiArrayValue("revenue.hthlist",6,"&bm1=" + tsd.encodeURIComponent(bm1) + "&bm2=" + tsd.encodeURIComponent(bm2) + "&bm3=" + tsd.encodeURIComponent(bm3) + "&bm4=" + tsd.encodeURIComponent(bm4) + "&yhlb=" + tsd.encodeURIComponent(yhlb));
		ghDrawHths(res);
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////				电话缴费
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	var PrintConfig = "";
	function bindEventToGh()
	{
		PrintConfig = fetchMultiKVValue("Revenue.NConfig",6,"",["tident","tvalues"]);
				
		//查询输入框回车事件
		$("#ghSearchBox").keydown(function(event){
			if(event.keyCode==13)
			{
				$("#ghSearchByUserName").click();
			}
			else
			{
				//多合同号缴费查询条件使用一次后失效
				$("#ghInfo").removeData("hthlist");
				$("#ghInfo").removeData("hthlistpay");
				if($("#ghFFFs option[cval^='d']").size()>0)
				{
					var tmpPayType = $("#ghInfo").data("paytype");
					$("#ghInfo").data("paytype",$("#ghFFFs option[cval^='d']").remove());
					$("#ghFFFs").append(tmpPayType);
				}
			}
		});
		
		//多合同号缴费面板删除事件
		$("#ghMultiHths").keydown(function(event){
			if(event.keyCode==46)
			{
				var vval = $("#ghMultiHths").val();
				if(vval != null && vval != undefined)
				{
					for(var ii=0;ii<vval.length;ii++)
					{
						$("#ghMultiHths").find("option[value='"+vval[ii]+"']").remove();
					}
					$("#ghMultiHthDetTab :checkbox:checked").attr("checked",false);
					$("#ghMultiHths option").each(function(){
						//hths.push($(this).attr("value"));
						$("#ghMultiHthDetTab :checkbox[value='"+$(this).attr("value")+"']").attr("checked",true);
					});
				}
				else
					alert("请选择要删除的合同号");
			}
		});
		
		
		//加载多合同号缴费面板
		ghLoadDept();
		//业务、缴费切换
		$("#ghuiJf").click(function(){
			$("#ghuserInfoPanelTabJOB").hide();
			$("#ghuserInfoPanelTabTC").hide();
			$("#ghuserInfoPanelTabJF").show();
			$("#ghuserInfoPanelTabKF,#ghuserInfoPanelTabCTC,#ghuserInfoPanelTabLTC,#ghuserInfoPanelTabGDF").hide();
			$("#ghuserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#ghuiJf").addClass("bolder");
		});
		$("#ghuiJob").click(function(){			
			$("#ghuserInfoPanelTabJF").hide();
			$("#ghuserInfoPanelTabTC").hide();
			$("#ghuserInfoPanelTabJOB").show();
			$("#ghuserInfoPanelTabKF,#ghuserInfoPanelTabCTC,#ghuserInfoPanelTabLTC,#ghuserInfoPanelTabGDF").hide();
			$("#ghuserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#ghuiJob").addClass("bolder");
		});
		$("#ghuiGNB").click(function(){			
			$("#ghuserInfoPanelTabJF").hide();
			$("#ghuserInfoPanelTabTC").show();
			$("#ghuserInfoPanelTabJOB").hide();
			$("#ghuserInfoPanelTabKF,#ghuserInfoPanelTabCTC,#ghuserInfoPanelTabLTC,#ghuserInfoPanelTabGDF").hide();
			$("#ghuserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#ghuiGNB").addClass("bolder");
		});
		$("#ghuiKF").click(function(){			
			$("#ghuserInfoPanelTabJF").hide();
			$("#ghuserInfoPanelTabKF").show();
			$("#ghuserInfoPanelTabJOB").hide();
			$("#ghuserInfoPanelTabTC,#ghuserInfoPanelTabCTC,#ghuserInfoPanelTabLTC,#ghuserInfoPanelTabGDF").hide();
			$("#ghuserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#ghuiKF").addClass("bolder");
		});
		$("#ghuiGDF").click(function(){			
			$("#ghuserInfoPanelTabJF,#ghuserInfoPanelTabKF,#ghuserInfoPanelTabJOB").hide();
			$("#ghuserInfoPanelTabTC,#ghuserInfoPanelTabCTC,#ghuserInfoPanelTabLTC").hide();
			$("#ghuserInfoPanelTabGDF").show();
			$("#ghuserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#ghuiGDF").addClass("bolder");
		});
		$("#ghuiLTC").click(function(){			
			$("#ghuserInfoPanelTabJF,#ghuserInfoPanelTabKF,#ghuserInfoPanelTabJOB").hide();
			$("#ghuserInfoPanelTabTC,#ghuserInfoPanelTabCTC,#ghuserInfoPanelTabGDF").hide();
			$("#ghuserInfoPanelTabLTC").show();
			$("#ghuserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#ghuiLTC").addClass("bolder");
		});
		$("#ghuiCTC").click(function(){			
			$("#ghuserInfoPanelTabJF,#ghuserInfoPanelTabKF,#ghuserInfoPanelTabJOB").hide();
			$("#ghuserInfoPanelTabTC,#ghuserInfoPanelTabGDF,#ghuserInfoPanelTabLTC").hide();
			$("#ghuserInfoPanelTabCTC").show();
			$("#ghuserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#ghuiCTC").addClass("bolder");
		});
		//电话缴费用户信息面板配置项
		if(PrintConfig["PayUserInfoJF"]=="N")
			$("#ghuiJf").remove();
		if(PrintConfig["PayUserInfoJob"]=="N")
			$("#ghuiJob").remove();
		if(PrintConfig["PayUserInfoKF"]=="N")
			$("#ghuiKF").remove();
		if(PrintConfig["PayUserInfoGDF"]=="N")
			$("#ghuiGDF").remove();
		if(PrintConfig["PayUserInfoLTC"]=="N")
			$("#ghuiLTC").remove();
		if(PrintConfig["PayUserInfoCTC"]=="N")
			$("#ghuiCTC").remove();
		$(".ghuserInfoTitle:first:visible").click();
		
			
		
		ghexecuteDelete();
		$("#ghHfDistributionForm").draggable({handle:"#thisdrag"});
		$(window).unload(function(){
			ghexecuteDelete();
		});
	}
	/////删除当前登录用户的**信息
	function ghexecuteDelete()
	{
		executeNoQuery('revenue.del1',1,"&skrid=" + $("#skrid").val());
		executeNoQuery('revenue.del2',1,"&skrid=" + $("#skrid").val());
		executeNoQuery('revenue.del3',1,"&skrid=" + $("#skrid").val());
	}


	/////多合同号缴费
	function ghMulHthCustomer(pay_type)	{
		
		var dhNum = $.trim($("#ghSearchBox").val());
		if(dhNum=="")
	  	{
			$("#ghSearchBox").select().focus();
			return false;
		}
		
		if("mulHthCustomer" == pay_type){
			dhNum = $("#ghInfo").data("hthlist");
		}
		/*
		//判断是否为多合同号缴费
		if($("#ghInfo").data("hthlistpay")=="Y")
		{
			dhNum = $("#ghInfo").data("hthlist");
		}
		*/
		//加载信息提示框 chenliang 2012-01-08
		autoBlockForm('submitloading',30,'submitloadingclose',"#FFFFFF",false);
		ghClearInfoWithoutSearchBox();
		
		if($('#ghSearchWay').val()==3)
		{
			var username=$('#ghSearchBox').val();
			if(username=="")
			{
				alert("请输入要查询的电话号码");
				$("#ghSearchBox").select();
				$("#ghSearchBox").focus();
				return false;
			}
			ghMultiUser(username);//显示查询用户面板
			//ghClearInfoWithoutSearchBox();//清空面板
		}else{
			
			ghClearInfoWithoutSearchBox();//清空面板
			var dhNum = $.trim($("#ghSearchBox").val());
			
			if(dhNum=="")
			{
				alert("请输入要查询的电话号码");
				$("#ghSearchBox").select();
				$("#ghSearchBox").focus();
			}
			else
			{
				tsd.QualifiedVal=true;
				dhNum = tsd.encodeURIComponent(dhNum);
				if(tsd.Qualified()==false){
					$("#ghSearchBox").select();
					$("#ghSearchBox").focus();
					return false;
				}
				//alert(dhNum);
				//判断是否拥有受理办公用户缴费权限 true：为有权限 false为无权限  dhyhlbpub
				var dhyhlbpub = $("#dhyhlbpub").val();
				if(dhyhlbpub=="false")
				{
					var res = fetchMultiValue("Revenue.ifbangong",6,"&UN="+dhNum);
					if(res[0]!=undefined && res[0]>=1)
					{
						alert('该电话为办公用户，不能受理收费。');
						$("#ghSearchBox").select();
						$("#ghSearchBox").focus();
						return ;
					}				
				}				

				if(ghCheckHth()&&ghCalYjf())
				{
					ghMonthFee();	//取欠费月份
					//var ye=fetchSingleValue("Revenue.fetchFee5",0,"&UserName="+UserName);
					//恢复保存按钮为可用状态
					$("#ghsave").removeAttr("disabled");
					//可打印未收费票据
					$("#ghUnpaymentPrint").removeAttr("disabled");
					
					//恢复用户信息查询面板可用
					if($("#ghInfo").data("hthlistpay")!="Y")
					{
						$("#ghUserInfo,#ghTuiFeiBtn").removeAttr("disabled");
						//ghZyjb(dhNum); //2012-03-12注释的
						//电话用户基本信息
						ghBasicInfoo($.trim($("#ghInfo").data("dh")));
						ghRefreshStatus($.trim($("#ghInfo").data("dh")));
					}
					else
					{
						$("#ghUserInfo").attr("disabled","disabled");
					}
					//2012-11-5 yhy start
					//去用户当月的话费和本月余额
					var hth = $("#ghInfo").data("hth");
					var redata = fetchMultiArrayValue("Revenue.getghbyxx",6,"&hth=" + hth);
					//当多合同号查询的时候，不显示该区域
					if(redata.length=1){						
						$("#ghbyxx").show();
					}else{
						$("#ghbyxx").hide();
					}
					if(redata[0] !=undefined && redata[0][0]!=undefined){
						$("#ghbyxxByhf").text(redata[0][0]);
						$("#ghbyxxByye").text(redata[0][1]);
					}
					//2012-11-5 yhy end
				}
			}		
		}
		
		//多合同号缴费查询条件使用一次后失效
		//$("#ghInfo").removeData("hthlist");
		//$("#ghInfo").removeData("hthlistpay");
	}
	
	//隐藏页面头部多合同号显示区域
	function multiHtsPandShow(querytype){
		if(querytype=='multi' || querytype=='multiOne'){
			$("#multiHths").show();
		}else{
			$("#multiHths").hide();
		}		
	}
	
	/**********************************************************************
	function name:    showPayType
	function:         根据当前缴费方式，限制某一种或几种缴费方式不可用
	
	parameters:       cashmode : 收费方式，包括：普通缴费 ：normal；立即结算：real ； 多合同号缴费 ：multi ；退费：back；大客户缴费：group
	return:           
	
	description:      1.立即结算:多合同号缴费不可用，大客户缴费不可用、少收不可用
					  2.多合同号缴费：立即结算不可用 、大客户缴费不可用、少收不可用
	**********************************************************************/
	function showPayType(cashmode){
		
		if( cashmode=="real" ){
			//多合同号缴费不可用
			//$("#ghMultiHth").attr("disabled","disabled");
		}else if( cashmode=="multi" ){
			//立即结算不可用
			//$("#ghSearchByUserName").attr("disabled","disabled");
		}
	}