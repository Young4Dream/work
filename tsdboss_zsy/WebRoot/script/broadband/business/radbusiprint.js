/*****************************************************************
 		* name: radbusiprint.js
		* author: wangli
 		* version: 1.0, 2011-09-04
 		* description: 业务受理弹出票据打印窗口js 		  
*****************************************************************/
	jQuery(document).ready(function(){
		getbusinessprint();
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
			alert("请配置默认打印项！");			
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
		strprint+="工单票据打印选择";
		strprint+="</div>";
		strprint+="</div>";
		strprint+="</div>";
		strprint+="<div class='top02right'>";
		strprint+="<img src='style/images/public/toptiaoright.gif' />";
		strprint+="</div>";
		strprint+="</div>";
		strprint+="<div class='midd' style='background-color:#FFFFFF;text-align:center;'>";
		strprint+="<div id='printradio'>";
		strprint+="选择打印票据类型：";
		//strprint+="<input type='radio' name='radioname' id='jobid_key' value='job' onclick='getprintradio();'><span style='color:red' id='jobtext'>派工单</span></input>&nbsp;&nbsp;&nbsp;&nbsp;";
		strprint+="<input type='radio' name='radioname' id='sfid_key' value='sfee' onclick='getprintradio();'><span style='color:red' id='sftext'>收费票据</span></input>";
		strprint+="</div>";
		strprint+="<hr style='border: 3px dotted #CCCCCC;' />";
		strprint+="<table cellspacing='5' style='margin-right:120px;'>";
		strprint+="<tr id='print_job'>";
		strprint+="<td align='left'><h3>打印派工单>>></h3></td>";
		strprint+="<td>&nbsp;&nbsp;&nbsp;&nbsp;";
		strprint+="<button id='printDirect' class='tsdbutton' onclick='jobPrint(1)' style='line-height:27px; margin-top: 1px; padding: 0px;'>直接打印</button>";	
		strprint+="</td>";
		strprint+="<td>";
		strprint+="<button id='printInDirect' class='tsdbutton' onclick='jobPrint(2)' style='line-height:27px; margin-top: 1px; padding: 0px;'>预览打印</button>";
		strprint+="</td>";
		strprint+="</tr>";
		strprint+="<tr>";
		strprint+="</tr>";
		strprint+="<tr id='print_sf'>";
		strprint+="<td align='left'><h3>打印收费票据>>></h3></td>";
		strprint+="<td>&nbsp;&nbsp;&nbsp;&nbsp;";
		strprint+="<button id='printDirect' class='tsdbutton' onclick='lsPrint(1)' style='line-height:27px; margin-top: 1px; padding: 0px;'>直接打印</button>";
		strprint+="</td>";
		strprint+="<td>";
		strprint+="<button id='printInDirect' class='tsdbutton' onclick='lsPrint(0)' style='line-height:27px; margin-top: 1px; padding: 0px;'>预览打印</button>";
		strprint+="</td>";
		strprint+="</tr>";
		strprint+="</table>";
		strprint+="</div>";
		strprint+="<div class='midd_butt' style='width:645px'><button id='printInDirect' class='tsdbutton' onclick='setTimeout($.unblockUI,1);'>关闭</button></div>"; 
		strprint+="</div>";
		$("#businessreprint").html(strprint);
	}
	
	/**************************************打印除装机跟修改属性意外其他业务的工单票据*********************************************/
        	       	
       	/**********
		* 收费打印
		* @param：flag为1时直接打印，为2时预览打印;
		* @return;
	    **********/
       	function lsPrint(flag)
       	{
       			
       		/*****
       		*获取付费类型pay_item表中的prtmodename字段的报表路径名，空为不打印票据
       		*****/       		
       		//var res = $("#repfile").val();       		
       		/*
       		if(res==""||res==undefined||res=="undefined")
       		{
       			//setTimeout($.unblockUI,1);
       			alert("对不起，该付费方式没有对应的票据，请先配置票据！");
       			return;
       		}else{       			
       				
	       }*/
	       var params = "&jobid="+$("#jobid").val();
	       		var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/commonreport/rad_jobworkorder.cpt"+params;
	       		if(flag=="1")
	       		{
	       			printWithoutPreview("commonreport/rad_jobworkorder","jobid_"+$("#jobid").val());
	       		}
	       		else
	       		{
	       			window.showModalDialog(urll,window,"dialogWidth:720px; dialogHeight:350px; center:yes; scroll:no");
	       		}
       	}	
       	
       	/**********
		* 票据是否打印
		* @businesstype：业务类型;
		* @return：Y为打印票据，N为不打印;
	    **********/
       	function printworkorder(businesstype){
       		//判断是否打印工单，从tsd_ini表中配置Y为打印
			var res = fetchSingleValue_rad("dbsql_phone.querytsd_ini",6,"&tsection="+tsd.encodeURIComponent('radbusi_busifee')+"&tident="+tsd.encodeURIComponent(businesstype));			          
			if(res=="Y"){
				$("#sfid_key").show();
				$("#sftext").show();
				//如果该业务配置了收费打印时，默认为票据打印
				$("#printradio input[name=radioname][value=sfee]").attr("checked",true);
				//默认时查看选中的值，根据选中的值来显示信息
				getprintradio();
    			autoBlockForm("choosePrintjobsf","150","close","#FFFFFF",false);		    		
			}else{
				alert("业务办理成功！");
			}
       	}