/*****************************************************************
 		* name: businessreprint.js
		* author: wenxuming
 		* version: 1.0, 2011-04-06
 		* description: 业务受理弹出票据打印窗口js
 		* modify:   
 		*****************************************************************/
	jQuery(document).ready(function(){
		getbusinessprint();
		getFsbm();		
	})
	
	//选择打印方式，是打印工单还是收费票据
	function getprintradio(){
		var va = $("#printradio input[name='radioname']:checked").val();
		if(va=="job"){
			$("#print_job").show();
			$("#print_sf").hide();
		}else if(va=="sfee"){
			$("#print_job").hide();
			$("#print_sf").show();
		}else{
			$("#print_job").hide();
			$("#print_sf").hide();
			//alert("请配置默认打印项！");			
			alert($("#getinternet0121").val());
		}
	}

	function getbusinessprint(){
		$("#ppaytype").val("");
       	$("#cPayTypey").val("");
       	$("#fee").val("");
       	$("#businessreprint").empty();
		var strprint='';
		strprint+="<div class='neirong' id='choosePrintjobsf' style='display:none;width:660px'>";
		strprint+="<div class='top'>";
		strprint+="<div class='top_01' id='thisdrag'>";
		strprint+="<div class='top_01left'>";
		strprint+="<div class='top_02'>";
		strprint+="<img src='style/images/public/neibut01.gif'/>";
		strprint+="</div>";
		strprint+="<div class='top_03' id='titlediv'>";
		//strprint+="工单票据打印选择";
		strprint+=$("#getinternet0122").val()
		strprint+="</div>";
		strprint+="</div>";
		strprint+="</div>";
		strprint+="<div class='top02right'>";
		strprint+="<img src='style/images/public/toptiaoright.gif' />";
		strprint+="</div>";
		strprint+="</div>";
		strprint+="<div class='midd' style='background-color:#FFFFFF;text-align:center;'>";
		strprint+="<div id='printradio'>";
		//strprint+="选择打印票据类型：";
		strprint+=$("#getinternet0123").val()
		strprint+="<input type='radio' name='radioname' id='jobid_key' value='job' onclick='getprintradio();'><span style='color:red' id='jobtext'>"+$("#getinternet0128").val()+"</span></input>&nbsp;&nbsp;&nbsp;&nbsp;";
		strprint+="<input type='radio' name='radioname' id='sfid_key' value='sfee' onclick='getprintradio();'><span style='color:red' id='sftext'>"+$("#getinternet0129").val()+"</span></input>";
		strprint+="</div>";
		strprint+="<hr style='border: 3px dotted #CCCCCC;' />";
		strprint+="<table cellspacing='5' style='margin-right:120px;'>";
		strprint+="<tr id='print_job'>";
		//strprint+="<td align='left'><h3>打印派工单>>></h3></td>";
		strprint+="<td align='left'><h3>"+$("#getinternet0124").val()+">>></h3></td>";		
		strprint+="<td>&nbsp;&nbsp;&nbsp;&nbsp;";
		strprint+="<button id='printDirect' class='tsdbutton' onclick='jobPrint(1)' style='line-height:27px; margin-top: 1px; padding: 0px;'>"+$("#getinternet0130").val()+"</button>";	
		strprint+="</td>";
		strprint+="<td>";
		strprint+="<button id='printInDirect' class='tsdbutton' onclick='jobPrint(2)' style='line-height:27px; margin-top: 1px; padding: 0px;'>"+$("#getinternet0131").val()+"</button>";
		strprint+="</td>";
		strprint+="</tr>";
		strprint+="<tr>";
		strprint+="</tr>";
		strprint+="<tr id='print_sf'>";
		//strprint+="<td align='left'><h3>打印收费票据>>></h3></td>";
		strprint+="<td align='left'><h3>"+$("#getinternet0125").val()+">>></h3></td>";
		strprint+="<td>&nbsp;&nbsp;&nbsp;&nbsp;";
		strprint+="<button id='printDirect' class='tsdbutton' onclick='lsPrint(1)' style='line-height:27px; margin-top: 1px; padding: 0px;'>"+$("#getinternet0130").val()+"</button>";
		strprint+="</td>";
		strprint+="<td>";
		strprint+="<button id='printInDirect' class='tsdbutton' onclick='lsPrint(0)' style='line-height:27px; margin-top: 1px; padding: 0px;'>"+$("#getinternet0131").val()+"</button>";
		strprint+="</td>";
		strprint+="</tr>";
		strprint+="</table>";
		strprint+="</div>";
		strprint+="<div class='midd_butt' style='width:645px'><button id='printInDirect' class='tsdbutton' onclick='setTimeout($.unblockUI,1);'>"+$("#getinternetclose").val()+"</button></div>"; 
		strprint+="</div>";
		$("#businessreprint").html(strprint);
	}
	
	/**************************************打印除装机跟修改属性意外其他业务的工单票据*********************************************/
		 
		/**********
		* 工单打印
		* @param：flag为1时直接打印，为2时预览打印;
		* @return;
	    **********/
       	function jobPrint(flag)
       	{
       		var jobid= $("#jobidid").val();
			var params = "&JobID="+jobid;
       		var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/commonreport/dh_jobworkorder.cpt"+params;
       		if(flag=="1")
       		{
       			printWithoutPreview("commonreport/dh_jobworkorder","JobID_"+jobid);
       		}
       		else if(flag=="2")
       		{
       			window.showModalDialog(urll,window,"dialogWidth:800px; dialogHeight:530px; center:yes; scroll:no");
       		}
       		else
       		{

       		}      		
       	}
        	       	
       	/**********
		* 收费打印
		* @param：flag为1时直接打印，为2时预览打印;
		* @return;
	    **********/
       	function lsPrint(flag)
       	{
       		/*****
       		*获取付费类型pay_item表中的prtmodename字段的报表路径名，空为不答应票据
       		*****/
       		var res = fetchSingleValue("dbsql_phone.queryprtmodename",6,"&kemu=pbusinessfee&pay_name="+tsd.encodeURIComponent($("#ppaytype").val()));
       		if(res==""||res==undefined||res=="undefined")
       		{
       			//setTimeout($.unblockUI,1);
       			//alert("对不起，该付费方式没有对应的票据，请先配置票据！");
       			alert($("#getinternet0126").val());
       			return;
       		}else{       			
       				var params = "&JobID="+$("#jobidid").val();
		       		var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/"+res+".cpt"+params;
		       		if(flag=="1")
		       		{
		       			printWithoutPreview(res,params);
		       		}
		       		else
		       		{
		       			window.showModalDialog(urll,window,"dialogWidth:720px; dialogHeight:350px; center:yes; scroll:no");
		       		}
	       }
       	}	
       	
       	/**********
		* 处装机外其他业务受理中工单票据是否打印
		* @businesstype：业务类型;
		* @return：Y为打印工单票据，N为不打印;
	    **********/
       	function printworkorder(businesstype){
       		$("#print_job").hide();//初始化隐藏工单打印
			$("#print_sf").hide();//初始化隐藏收费打印
       		$("#printradio input[name=radioname]").attr("checked",false);//初始化取消选中项
       		//设置默认选项，从数据库tsd_ini中获取默认选项
       		var resDefault = fetchSingleValue("dbsql_phone.querytsd_ini",6,"&tsection="+tsd.encodeURIComponent('phonebusiness')+"&tident="+tsd.encodeURIComponent('PrintDefaultKey'));
       		if(resDefault!=""&&resDefault!=undefined){
    			$("#printradio input[name=radioname][value="+resDefault+"]").attr("checked",true);//设置默认选项为选中状态
    		}
       		//判断是否打印工单，从tsd_ini表中配置Y为打印
			var res = fetchSingleValue("dbsql_phone.querytsd_ini",6,"&tsection="+tsd.encodeURIComponent('phonebusiness_workorder')+"&tident="+tsd.encodeURIComponent(businesstype));
			if(res==undefined){res="";}
			if(res=="Y"){
				$("#jobid_key").show();
				$("#jobtext").show();
				var feevalue=$("#fee").val().replace(/(^\s*)|(\s*$)/g,"");
       			var Prefeeval = $("#Prefeeval").val().replace(/(^\s*)|(\s*$)/g,"");
			       	if(feevalue==""){feevalue='0';}
       				if(Prefeeval==""){Prefeeval='0';}
		    	if((feevalue!='0'&&Prefeeval!='0')||(feevalue!='0'&&Prefeeval=='0')||(feevalue=='0'&&Prefeeval!='0')){
		    		//判断是否打印收费票据，从tsd_ini表中配置Y为打印
					var sfres = fetchSingleValue("dbsql_phone.querytsd_ini",6,"&tsection="+tsd.encodeURIComponent('phonebusiness_printsfee')+"&tident="+tsd.encodeURIComponent(businesstype));
					if(sfres==undefined){res="";}
					if(sfres=="Y"){
       					$("#sfid_key").show();
       					$("#sftext").show();
       				}else{
       					$("#sfid_key").hide();
       					$("#sftext").hide();
       					//如果该业务没有配置打印收费票据时，默认为工单打印
       					$("#printradio input[name=radioname][value=job]").attr("checked",true);
       				}
		    	}else{
       				$("#sfid_key").hide();
       				$("#sftext").hide();
       				//如果该业务没有费用时，默认为工单打印
       				$("#printradio input[name=radioname][value=job]").attr("checked",true);
		    	}
		    	//默认时查看选中的值，根据选中的值来显示信息
       			getprintradio();
				autoBlockForm("choosePrintjobsf","150","close","#FFFFFF",false);
	       	}else{
	       		$("#jobid_key").hide();
	       		$("#jobtext").hide();
	       		var feevalue=$("#fee").val().replace(/(^\s*)|(\s*$)/g,"");
	       		var Prefeeval = $("#Prefeeval").val().replace(/(^\s*)|(\s*$)/g,"");
			       	if(feevalue==""){feevalue='0';}
       				if(Prefeeval==""){Prefeeval='0';}
		    	if((feevalue!='0'&&Prefeeval!='0')||(feevalue!='0'&&Prefeeval=='0')||(feevalue=='0'&&Prefeeval!='0')){
		    		//判断是否打印收费票据，从tsd_ini表中配置Y为打印
					var sfres = fetchSingleValue("dbsql_phone.querytsd_ini",6,"&tsection="+tsd.encodeURIComponent('phonebusiness_printsfee')+"&tident="+tsd.encodeURIComponent(businesstype));
					if(sfres==undefined){res="";}
					if(sfres=="Y"){
       					$("#sfid_key").show();
       					$("#sftext").show();
       					//如果该业务配置了收费打印时，默认为票据打印
       					$("#printradio input[name=radioname][value=sfee]").attr("checked",true);
       					//默认时查看选中的值，根据选中的值来显示信息
       					getprintradio();
		    			autoBlockForm("choosePrintjobsf","150","close","#FFFFFF",false);
       				}else{
       					$("#sfid_key").hide();
       					$("#sftext").hide();
       					//alert("业务办理成功！");
       					alert($("#getinternet0127").val());
       				}		    		
				}else{
					//alert("业务办理成功！");
					alert($("#getinternet0127").val());
				}	       		
	       	}
       	}
       	
       	/*
       		装机、移机、拆机时如果需要选择流向固定的部门时选择
       	*/
       	function getFsbm(){
			   		var res = fetchMultiArrayValue("dbsql_phone.getFsbm",6,"&busitype="+$("#businesstype").val(),'business');
				 	if(res!=undefined&&res!=""){
				 		var str="<option value=''>--请选择--</option>";
					 	for(var j=0;j<res.length;j++){					 		
					 			str+="<option value='"+res[j][0]+"'>"+res[j][1]+"</option>";					 		
					 	}
					 	$("#fsbm").html(str);
				 	}else{
				 		$("#fsbm").html("<option value=''>--is null--</option>");
				 	}
				}