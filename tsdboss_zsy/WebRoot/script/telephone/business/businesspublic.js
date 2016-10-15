/*****************************************************************
 * name: businesspublic.js
 * author: wenxuming
 * version: 1.0, 2010-11-05
 * description: 除开户跟修改属性外，其他页面的合同号信息跟固话信息自动加载
 * modify:   
 *****************************************************************/
	function getinternation(){
		var languageType = $("#languageType").val();
		 //合同号信息
		  $("#tablehthdang").empty();
          var resg = fetchFieldAlias('Hthdang',languageType);
          var str = getFields("Hthdang");
          var Dat = loadData_phoneinstalled("Hthdang","zh",2);
          var tablehthdang="<tr>";
        		var j=0;
        		for(var i=0;i<Dat.FieldName.length;i++){
        			var str = resg[Dat.FieldName[i]];
        					tablehthdang +="<td class='wenzi'>"+str+"</td>";
        					tablehthdang +="<td class='wenzix'><input name="+Dat.FieldName[i]+" id="+Dat.FieldName[i]+"  style='width: 150px;'/></td>";        					
        				j++;
        			if(j==3){
        				tablehthdang +="</tr><tr>";
        				j=0;
        			}
        		}
        	tablehthdang+="</tr>";
        	$("#tablehthdang").append(tablehthdang);

          //固话信息
          var res = fetchFieldAlias('yhdang',languageType);
          var str = getFields("yhdang");
          var Dat = loadData_phoneinstalled("yhdang","zh",2);
          var tableyhdang="<tr>";
        		var j=0;
        		for(var i=0;i<Dat.FieldName.length;i++){
        			var str = res[Dat.FieldName[i]];
		        				if(Dat.FieldName[i]=="Mima"&&j<2){
					        			tableyhdang +="<td class='wenzi'>"+res[Dat.FieldName[i]]+"</td>";
					        			tableyhdang +="<td class='wenzix'><input type='text' name="+Dat.FieldName[i]+'_yhdang'+" id="+Dat.FieldName[i]+'_yhdang'+"  style='width: 150px;'/></td>";
					        			//tableyhdang +="<td class='wenzi'>确认密码</td>";
					        			tableyhdang +="<td class='wenzi'>"+$("#getinternet0120").val()+"</td>";
					        			tableyhdang +="<td class='wenzix'><input type='text' name='toMima_yhdang' id='toMima_yhdang'  style='width: 150px;'/></td>";
					        			j++;
					        	}else if(Dat.FieldName[i]=="Mima"&&j==2){ 						
					        			tableyhdang +="<td class='wenzi'>"+res[Dat.FieldName[i]]+"</td>";
					        			tableyhdang +="<td class='wenzix'><input type='text' name="+Dat.FieldName[i]+'_yhdang'+" id="+Dat.FieldName[i]+'_yhdang'+"  style='width: 150px;'/></td>";
					        			tableyhdang +="</tr><tr>";
					        			tableyhdang +="<td class='wenzi'>"+$("#getinternet0120").val()+"</td>";
					        			tableyhdang +="<td class='wenzix'><input type='text' name='toMima_yhdang' id='toMima_yhdang'  style='width: 150px;'/></td>";
					        			j=0;
					        	}else{			        		
					        			tableyhdang +="<td class='wenzi'>"+res[Dat.FieldName[i]]+"</td>";
					        			tableyhdang +="<td class='wenzix'><input type='text' name="+Dat.FieldName[i]+'_yhdang'+" id="+Dat.FieldName[i]+'_yhdang'+"  style='width: 150px;'/></td>";			        		
					        	}        			
        				j++;
        			if(j==3){
        				tableyhdang +="</tr><tr>";
        				j=0;
        			}
        		}
           tableyhdang+="</tr>";  
          $("#tableyhdang").append(tableyhdang);
          $("#spanhth").text(res['Hth']);//合同号
          $("#spandh").text(res['Dh']);//电话
          $("#spangetdh").text(res['Dh']);//获取空号电话
          $("#spanBm1").text(res['Bm1']);//一级部门
          $("#spanBm2").text(res['Bm2']);//二级部门
          $("#spanBm3").text(res['Bm3']);//三级部门
          $("#spanBm4").text(res['Bm4']);//四级部门
          var rese = fetchFieldAlias('AttachFee',languageType);    
          $("#spanFeeCode").text(rese['FeeType']);//费用代号 
          $("#spanFeeName").text(rese['FeeName']);//费用名称
          $("#spanFeeType").text(rese['FeeType']);//子类型
          $("#spanPrice").text(rese['Price']);//价格
          $("#spanTjPrice").text(rese['TjPrice']);//停机价格
          $("#spanStartMonth").text(rese['StartMonth']);//起始有效月
          $("#spanEndMonth").text(rese['EndMonth']);//截至有效月
          $("#spanStartDate").text(rese['StartDate']);//起始极佳日
          $("#spanEndDate").text(rese['EndDate']);//截至计价日
          //显示表格标头的国际化
          $("#spanFeeCode_table").text(rese['FeeName']);//费用代号 
          $("#spanFeeName_table").text(rese['FeeType']);//费用名称
          $("#spanFeeType_table").text(rese['FeeType']);//子类型
          $("#spanPrice_table").text(rese['Price']);//价格
          $("#spanTjPrice_table").text(rese['TjPrice']);//停机价格
          $("#spanStartMonth_table").text(rese['StartMonth']);//起始有效月
          $("#spanEndMonth_table").text(rese['EndMonth']);//截至有效月
          $("#spanStartDate_table").text(rese['StartDate']);//起始极佳日
          $("#spanEndDate_table").text(rese['EndDate']);//截至计价日
          var reshfadd = fetchFieldAlias('Hthhfadd',languageType);
          $("#spanxinyueHF").text(reshfadd['MaxHf']);//实施话费
          $("#spanyucunYE").text(reshfadd['HfMax']);//出帐月余额 
          $("#yhdang_tjbz").text(res['Tjbz']);
          //$("#feetdhypetext").text("话费及状态");
          $("#feetdhypetext").text($("#getinternet0362").val());
          $("#tablehthdang :text").attr("disabled","disabled");
          $("#tablehthdang select").attr("disabled","disabled");
          $("#tableyhdang :text").attr("disabled","disabled");
          $("#tableyhdang select").attr("disabled","disabled");
		  
		  var res = fetchSingleValue("dbsql_phone.querytabledate",6,"&tablename=tsd_ini&cloum=tvalues&key=tident='setShows' and tsection='phonebusiness'"); 										
			var arrayRes="";
			var arrayShow="";
			if(res!=""&&res!=undefined){
				arrayRes=res.split('|');
				for(var i=0;i<arrayRes.length;i++){
					arrayShow=arrayRes[i].split(':');
					if(arrayShow[1]=="false"){
						$("#"+arrayShow[0]+"").hide();
					}else{
						$("#"+arrayShow[0]+"").show();
					}
					
				}				
			}

       }

       function getinternetedit(keytype){
       		var languageType = $("#languageType").val();
	        $.ajax({
					url:"phone_querydate?func=query",
					async:true,//异步
					cache:false,
					timeout:20000,//1000表示1秒
					type:'post',
					success:function(xml,textStatus)
					{
					    //取缴费方式 返回的是html格式
					    var syhlb = xml.substring(xml.indexOf("<yhlb=")+6,xml.indexOf("yhlb/>"));
					    var sdhlx = xml.substring(xml.indexOf("<dhlx=")+6,xml.indexOf("dhlx/>"));
					    var CallPayType = xml.substring(xml.indexOf("<CallPayType=")+13,xml.indexOf("CallPayType/>"));
					    var ZnjBz = xml.substring(xml.indexOf("<znjbz=")+7,xml.indexOf("znjbz/>"));
					    var Area = xml.substring(xml.indexOf("<asys_area=")+11,xml.indexOf("asys_area/>"));
					    var CustType = xml.substring(xml.indexOf("<custtype=")+10,xml.indexOf("custtype/>"));
					    var yhxz = xml.substring(xml.indexOf("<yhxz=")+6,xml.indexOf("yhxz/>"));
					    var tablehthdang = xml.substring(xml.indexOf("<hthdang=")+9,xml.indexOf("hthdang/>"));
					    var tableyhdang = xml.substring(xml.indexOf("<yhdang=")+8,xml.indexOf("yhdang/>"));
					    var AdjustSheduleNo = xml.substring(xml.indexOf("<AdjustSheduleNo=")+17,xml.indexOf("AdjustSheduleNo/>"));
					    var CallSheduleNo = xml.substring(xml.indexOf("<CallSheduleNo=")+15,xml.indexOf("CallSheduleNo/>"));
					    var dhgn = xml.substring(xml.indexOf("<dhgn=")+6,xml.indexOf("dhgn/>"));
					    var ywarea = xml.substring(xml.indexOf("<ywarea=")+8,xml.indexOf("ywarea/>"));
					    var idtype = xml.substring(xml.indexOf("<idtype=")+8,xml.indexOf("idtype/>"));
					    var ghfeetype = xml.substring(xml.indexOf("<gdfeetype=")+11,xml.indexOf("gdfeetype/>"));
					    var bytcfeetype = xml.substring(xml.indexOf("<bytcfeetype=")+13,xml.indexOf("bytcfeetype/>"));
					    var yhlb_text = xml.substring(xml.indexOf("<yhlb_text=")+11,xml.indexOf("yhlb_text/>"));
					    var attachprice_hth_text = xml.substring(xml.indexOf("<attachprice_hth=")+17,xml.indexOf("attachprice_hth/>"));
					    if(keytype=="p_movewithoutarea"){
						    $("#Dhlx").html(sdhlx);
						    //$("#Dhlx").val("固定电话");
						    $("#Dhlx").val($("#getinternet0363").val());
						    $("#usertype").html(syhlb);
						    $("#CallSheduleNo_new").html(CallSheduleNo);
						    $("#newDhgn").html(dhgn);
						    $("#yhxz_hidden").html(yhxz);
						    $("#phonefeetype").html(ghfeetype);
						    $("#Packaggroupid").html(bytcfeetype);
					    }else if(keytype=="p_changephone"){
							$("#Dhlx").html(sdhlx);
						    //$("#Dhlx").val("固定电话");
						     $("#Dhlx").val($("#getinternet0363").val());						     
					    }else if(keytype=="p_editfunction"){
					    	$("#newDhgn").html(dhgn);
					    	$("#phonefeetype").html(ghfeetype);
					    	$("#phonefeetype_hth").html(attachprice_hth_text);
					    }else if(keytype=="p_package"){
					    	 $("#Packaggroupid").html(bytcfeetype);
					    }else if(keytype=="p_hthchangename"){
					    	$("#usertype").html(syhlb);
					    }
					}		
				});
       }
       
       /**********
       *合同号可编辑情况       
       ***********/
       //全局变量arraybtfield 自动加载取出必选项放到该数组中，提交的时候判断哪些为必选；
       var arraybtfield = [];
       function geththedite(){
       	//合同号信息
       	  var languageType = $("#languageType").val();           
	        $.ajax({
					url:"phone_querydate?func=query",
					async:false,//异步
					cache:false,
					timeout:20000,//1000表示1秒
					type:'post',
					success:function(xml,textStatus)
					{
					    //取缴费方式 返回的是html格式
					    var syhlb = xml.substring(xml.indexOf("<yhlb=")+6,xml.indexOf("yhlb/>"));
					    var sdhlx = xml.substring(xml.indexOf("<dhlx=")+6,xml.indexOf("dhlx/>"));
					    var CallPayType = xml.substring(xml.indexOf("<CallPayType=")+13,xml.indexOf("CallPayType/>"));
					    var ZnjBz = xml.substring(xml.indexOf("<znjbz=")+7,xml.indexOf("znjbz/>"));
					    var Area = xml.substring(xml.indexOf("<asys_area=")+11,xml.indexOf("asys_area/>"));
					    var CustType = xml.substring(xml.indexOf("<custtype=")+10,xml.indexOf("custtype/>"));
					    var yhxz = xml.substring(xml.indexOf("<yhxz=")+6,xml.indexOf("yhxz/>"));
					    var tablehthdang = xml.substring(xml.indexOf("<hthdang=")+9,xml.indexOf("hthdang/>"));
					    var tableyhdang = xml.substring(xml.indexOf("<yhdang=")+8,xml.indexOf("yhdang/>"));
					    var AdjustSheduleNo = xml.substring(xml.indexOf("<AdjustSheduleNo=")+17,xml.indexOf("AdjustSheduleNo/>"));
					    var CallSheduleNo = xml.substring(xml.indexOf("<CallSheduleNo=")+15,xml.indexOf("CallSheduleNo/>"));
					    var dhgn = xml.substring(xml.indexOf("<dhgn=")+6,xml.indexOf("dhgn/>"));
					    var ywarea = xml.substring(xml.indexOf("<ywarea=")+8,xml.indexOf("ywarea/>"));
					    var idtype = xml.substring(xml.indexOf("<idtype=")+8,xml.indexOf("idtype/>"));
					    var ghfeetype = xml.substring(xml.indexOf("<gdfeetype=")+11,xml.indexOf("gdfeetype/>"));
					    var bytcfeetype = xml.substring(xml.indexOf("<bytcfeetype=")+13,xml.indexOf("bytcfeetype/>"));
					    var yhlb_text = xml.substring(xml.indexOf("<yhlb_text=")+11,xml.indexOf("yhlb_text/>"));
					    $("#tablehthdang").html(tablehthdang);
					    //$("#tableyhdang").html(tableyhdang);
					    $("#CallPayType_hthdang").html(CallPayType);
					    $("#Yhlb_hthdang").html(yhlb_text);
					    $("#CallPayType_hthdang").html(CallPayType);
					    $("#ZnjBz_hthdang").html(ZnjBz);
					    $("#Area_hthdang").html(Area);
						$("#CustType_hthdang").html(CustType);
						$("#Yhxz_hthdang").html(yhxz);
						$("#yhxz_hidden").html(yhxz);
						//$("#Bz2_hthdang").html($("#Bz2_hthdang").html()+"<option value='N' selected='true'>否</option>"+"<option value='Y'>是</option>");
						$("#Bz2_hthdang").html($("#Bz2_hthdang").html()+"<option value='N' selected='true'>"+$("#getinternet0355").val()+"</option>"+"<option value='Y'>"+$("#getinternet0354").val()+"</option>");
						//$("#phonefeetype").html(ghfeetype);
						//$("#Packaggroupid").html(bytcfeetype);
					}
				});
       }

       /**
        *提交hthdang数据时 判断必选项是否为空
        **/
        function Judgefield_hthdang(tjfield){
        	var boolean = false;
        	var arraybtfield = [];
        	var mustitem_hthdang = $("#mustitem_hthdang").val();
        	arraybtfield = mustitem_hthdang.split("|");
        	for(var i=0;i<arraybtfield.length;i++){        		
        		if(tjfield==arraybtfield[i]){
        			boolean = true;
        			break;
        		}
        	}
        	return boolean;
        }
       
       //值得到合同号显示框
       function geththtable(){       
       	  var languageType = $("#languageType").val(); 
		  //合同号信息
		  $("#tablehthdang").empty();
          var resg = fetchFieldAlias('Hthdang',languageType);                   
          var str = getFields("Hthdang");
          var Dat = loadData_phoneinstalled("Hthdang","zh",2);        
          var tablehthdang="<tr>";
        		var j=0;
        		for(var i=0;i<Dat.FieldName.length;i++){
        			var str = resg[Dat.FieldName[i]];    				
        					tablehthdang +="<td class='wenzi'>"+str+"</td>";
        					tablehthdang +="<td class='wenzix'><input name="+Dat.FieldName[i]+" id="+Dat.FieldName[i]+"  style='width: 150px;'/></td>";        					
        				j++;
        			if(j==3){
        				tablehthdang +="</tr><tr>";
        				j=0;
        			}
        		}
        	tablehthdang+="</tr>";
        	$("#tablehthdang").append(tablehthdang);
       }
       
       /********
        *生成付费类型下拉框
        *@param;
       	*@return;
        ********/
        function getfufeitype()
        {
           $("#cPayType").empty();
           var querysel='';
		   var res = fetchMultiArrayValue("dbsql_phone.queryphoneconfigkemu",6,"&kemu=pbusinessfee&tsection=payitem");
				if(res[0]==undefined || res[0][0]==undefined)
        		{
        			return false;
        		}
        	for(var i=0;i<res.length;i++){
        		querysel+="<option value="+res[i][0]+">"+res[i][1]+"</option>";
        	}	
		   $("#cPayType").html(querysel);
		   $("#cPayType").val("tuoshou");
        }
        
        /*******
	    *地址选择
	    *@param;
	    *@return;
	    ********/ 
		function c_p_address()
		{
			var ctrr = $("#sAddressold");
			$(ctrr).focus(function(){c_p_address_fun_to();});		
		}
		
		/*******
	    *弹出新地址选择器
	    *@param;
	    *@return;
	    ********/
		function c_p_address_fun_to()
		{		 	     
			if($("#c_p_address").size()<1)
			{
				$("#sAddressold").after("<div id=\"c_p_address\"></div>");
			}
			var left = 30;
			var top = $("#sAddressold").offset().top + 20;
			//alert($("#sAddressold").parent().offset().left);
			$("#c_p_address").css({'position':'absolute','left':left,'top':top,'background-color':'#FFFFFF','border':'#99ccff 1px solid','height':'112px','width':'760px'});
			$("#c_p_address").empty();		
			var address_tab="<table id=\"address_tab\" style=\"\">";
			address_tab += "<tr><td colspan=\"6\"><h4>"+$("#getinternet0374").val()+"</h4></td></tr>";
			address_tab += "<tr><td align=\"right\">"+$("#getinternet0381").val()+"</td><td><select id=\"c_p_address_seluserarea\" disabled></select></td><td>"+$("#getinternet0375").val()+"</td><td><select id=\"c_p_address_xq\"><option value=\"\">--"+$("#getinternet0365").val()+"--</option></select></td><td>"+$("#getinternet0376").val()+"</td><td><select id=\"c_p_address_ld\"><option value=\"\">--"+$("#getinternet0365").val()+"--</option></select></td><td>"+$("#getinternet0377").val()+"</td><td><select id=\"c_p_address_dy\"><option value=\"\">--"+$("#getinternet0365").val()+"--</option></select></td><td>"+$("#phone.getinternet0378").val()+"</td><td><select id=\"c_p_address_mp\"><option value=\"\">--"+$("#getinternet0365").val()+"--</option></select></td></tr>";
			address_tab += "<tr><td><button id=\"c_p_address_bnok\" class=\"tsdbutton\">"+$("#getinternetSave").val()+"</button></td><td colspan='2'><button id=\"c_p_address_add\" onclick=\"addnewinfo()\" class=\"tsdbutton\">"+$("#getinternet0379").val()+"</button></td><td><button id=\"c_p_address_bncancel\" class=\"tsdbutton\">"+$("#getinternet0084").val()+"</button></td><td></td><td></td><td></td><td></td></tr>";
			address_tab += "</table>";
			$("#c_p_address").append(address_tab);
			getuserareato();
			$("#c_p_address_seluserarea").val($("#userareaid").val());
			var addr = $("select[id='c_p_address_seluserarea'] :selected").html();
			/////////////从内存得到一级地址/////////////////////
			c_p_bindToAddr(1,"c_p_address_xq","&addrarea=" + tsd.encodeURIComponent(addr));						
			var cpad = $("#c_p_address_addright").val();
			if(cpad=="true"){
			  $("#c_p_address_add").removeAttr("disabled");		  		  	  
			}
			$("select[id^='c_p_address_']").css("width","100px");		
			//c_p_bindToAddr(1,"c_p_address_xq","");
			//var sua = $("select[id='c_p_address_seluserarea'] :selected").html();
			//c_p_bindToAddr(1,"c_p_address_xq","&addrarea=" + tsd.encodeURIComponent(sua));
			//隐藏证件类型下拉框
			$("#UserName1").css("display","none");
			
			//获得焦点时显示
			$("#c_p_address").show('slow');		
			$(document).one("click",function(event){
				//$("#c_p_address").hide('slow');
				//event.stopPropagation();
			});
			
			$("#c_p_address_seluserarea").change(function(){
				//alert($("#c_p_address_xq").val()); 
				var addr = $("select[id='c_p_address_seluserarea'] :selected").html();
				if(addr!="")
				{
					/////////////从内存得到一级地址/////////////////////			
					c_p_bindToAddr(1,"c_p_address_xq","&addrarea=" + tsd.encodeURIComponent(addr));
						/////////////////////////////////////
						//c_p_bindToAddr(1,"c_p_address_xq","&addrarea=" + tsd.encodeURIComponent(addr));
				}
			});
				    
			$("#c_p_address_xq").change(function(){
				//alert($("#c_p_address_xq").val()); 
				var addr = $("#c_p_address_xq").val();
				if(addr!="")
				{
					//////////////从内存得到二级地址////////////////////					
					c_p_bindToAddr(2,"c_p_address_ld","&addr=" + $("#c_p_address_xq").val());
							/////////////////////////////////////
							//c_p_bindToAddr(2,"c_p_address_ld","&addr=" + $("#c_p_address_xq").val());	
				}
			});
			
			$("#c_p_address_ld").change(function(){
				//alert($("#c_p_address_xq").val()); 
				var addr = $("#c_p_address_ld").val();
				if(addr!="")
				{
					//////////////从内存得到三级地址////////////////////					
					c_p_bindToAddr(3,"c_p_address_dy","&addr=" + $("#c_p_address_ld").val());
							/////////////////////////////////////
							//c_p_bindToAddr(3,"c_p_address_dy","&addr=" + $("#c_p_address_ld").val());	
				}
			});
			
			$("#c_p_address_dy").change(function(){
				//alert($("#c_p_address_xq").val()); 
				var addr = $("#c_p_address_dy").val();
				if(addr!="")
				{
					//////////////从内存得到四级地址////////////////////					
					c_p_bindToAddr(4,"c_p_address_mp","&addr=" + addr);
							//c_p_bindToAddr(4,"c_p_address_mp","&addr=" + addr);
				}
			});
			
			$("#c_p_address_bnok").click(function(){
				
				var info = "";
				var errinfo = "";
				
				var elems = ['xq','ld','dy','mp'];
				//var infoo = ['小区号','楼栋号','单元号','门牌号'];
				var infoo = [$("#getinternet0375").val(),$("#getinternet0376").val(),$("#getinternet0377").val(),$("#getinternet0378").val()];
				for(var j=0;j<4;j++)
				{
					if($("#c_p_address_"+elems[j]).val() != "")
					{
						info += $("select[id='c_p_address_"+elems[j]+"'] :selected").html();
						info += ",";
					}else if(resto!=undefined){
					    errinfo += infoo[j];
						errinfo += ",";
					}	
				}
				if(errinfo.length!=0&&$('#c_p_address_xq option').size()>1&&$("#c_p_address_xq").val()=="")
						{
							alert($("#getinternet0380").val());
							
						}else if(errinfo.length!=0&&$('#c_p_address_ld option').size()>1&&$("#c_p_address_ld").val()==""){
							//alert("请继续选择下一级地址","操作提示");
							alert($("#getinternet0380").val());
							
						}else if(errinfo.length!=0&&$('#c_p_address_dy option').size()>1&&$("#c_p_address_dy").val()==""){
						
							//alert("请继续选择下一级地址","操作提示");
							alert($("#getinternet0380").val());
							
						}else if(errinfo.length!=0&&$('#c_p_address_mp option').size()>1&&$("#c_p_address_mp").val()==""){
						
							//alert("请继续选择下一级地址","操作提示");
							alert($("#getinternet0380").val());
							
						}
				else
				{
					info = info.replace(new RegExp(",","g"),"");
					if(checkAddress(info))
					{
						//alert("地址 " + info + " 已经存在，不能重复添加");
						alert($("#getinternet0341").val() + info + $("#getinternet0014").val());
						return false;
					}
					$("#sAddressold").val(info);
					$("#c_p_address").hide('slow');
					//恢复显示
					$("#UserName1").css("display","block");
				}
				//alert($("select[id^='c_p_address']").size());
			});
			
			$("#c_p_address_bncancel").click(function(){
				$("#c_p_address").hide('slow');
				//恢复显示
				$("#UserName1").css("display","block");
			});
		}
		
		var resto="";
		function c_p_bindToAddr(idx,selid,param)
		{		     
			var res = fetchMultiArrayValue("AddressBox.query"+idx,6,param);
			var elems = ['xq','ld','dy','mp'];
			//alert(res[0] == undefined + ":" + res[0][0] == undefined);
			resto=res[0][0];
			if(res[0] == undefined || res[0][0] == undefined || res[0] == "")
			{
				for(var j=idx;j<=4;j++)
				{
					$("#c_p_address_"+elems[j-1]).empty();
					$("#c_p_address_"+elems[j-1]).append("<option value=\"\">--"+$("#getinternet0365").val()+"--</option>");
				}
				return false;
			}
			$("#"+selid).empty();
			$("#"+selid).append("<option value=\"\">--"+$("#getinternet0365").val()+"--</option>");
			var quanju="";
			for(var i=0;i<res.length;i++)
			{
			    var ee="<option value='"+res[i][0]+"'>"+res[i][1]+"</option>";	
			    quanju+=ee					
			}
			 $("#"+selid).html($("#"+selid).html()+quanju);
			//重置索引  > idx + 1 的下拉框
			for(var j=idx + 1;j<=4;j++)
			{
				$("#c_p_address_"+elems[j-1]).empty();
				$("#c_p_address_"+elems[j-1]).append("<option value=\"\">--"+$("#getinternet0365").val()+"--</option>");
			}
		  }
		
		function checkAddress(addr)
	    {
			var addrto = $("#c_p_address_mp").val();
	      	if(addrto!=null&&addrto!="")
	      	{
				var res = fetchSingleValue("Address.Check",6,"&Yhdz="+tsd.encodeURIComponent(addr)+"&YwArea=" + tsd.encodeURIComponent($("#userareaid").val()));
				if(res==undefined||res=='0')
				{
					return false;
				}
				else
				{
					return true;
				}
			}				
	    }
	    
	    /*******
	    *限制地址不能手动输入只能选择 地址输入框keyup
	    *@param;
	    *@return;
	    ********/
	    function notecheck()
	    {
				var notecheck = $("#sAddressold").val();
					if(notecheck.length>0){
					$("#sAddressold").val(notecheck.substr(0,0));
				}
	    }
	    
	    ////////////////////////////////代缴信息设置//////////////////////////////////////////////////////////	    	    
        
        /********
        *查询代缴合同号，表格显示出来
        *@param;
       	*@return;
        ********/
        function setXDJ(key)
        {        	       
        	$("#dqueryHTHdw").empty();//每次查询前将以前的数据清空   
        	$("#querydjhthdh").empty();      	
        	if(key==""){ 
	        	$("#Paymenthth").val("");
	        	$("#Paymentfee").val("");
	        	$("#Paymentrate").val(""); 
	        	$("#Paymentdh").val("");        	
	        	//第一次打开面板时清空输入框
	        	if($("#currentHthFirstOpen").val()=="Y")
	        	{
	        		$("#daijiaoinput input").val("");
	        		$("#currentHthFirstOpen").val("N");
	        	}
	        	
	        	$("#daijiaoinput input").click(function(){
	        		//记录选中的合同号输入框的ID
	        		//alert($(this).attr("id"));
	        		$("#currentCheckedHthBox").val($(this).attr("id"));
	        	});  
	        		Packaget_Refreshs('');      	        	        	       	        	        
	        		autoBlockForm('dhthChooseForm',5,'dhthChooseFormReset',"#ffffff",false);//弹出查询框
        	}
            //var res = fetchMultiArrayValue("phonelnstalled.isnotdanweiHTH",6,"");
            var res = fetchMultiArrayValue("dbsql_phonelnstalled.selectPaymenththkey",6,"&hth="+tsd.encodeURIComponent($("#hth").val()));
            if(res[0]==undefined || res[0][0]==undefined)
			{
				return false;
			}
            var ify="";            
            //ify += "<thead><tr><th width=\"100px;height: 20px\"><center><h4>单位合同号</h4></center></th><th width=\"100px;height: 20px\"><center><h4>用户电话</h4><th width=\"170px;height: 20px\"><center><h4>用户名称</h4><th width=\"230px;height: 20px\"><center><h4>用户地址</h4></center></th></tr></thead>";
            for(var i=0;i<res.length;i++){
                ify +="<tbody>";
                ify += "<tr id=\""+res[i][0]+"\">";
				ify += "<td style=\"width: 100px;height: 20px\"><center>";
				ify += res[i][0];
				ify += "</center></td>";
				ify += "<td width=\"100;height: 20px\"><center>";
				ify += res[i][1];
				ify += "</center></td>";
				ify += "<td width=\"170;height: 20px\"><center>";
				ify += res[i][2];
				ify += "</center></td>";
				ify += "<td width=\"230;height: 20px\"><center>";
				ify += res[i][3];
				ify += "</center></td>";
				ify +="</tr>";
				ify +="</tbody>";
            }
            $("#dqueryHTHdw").append(ify);
            //jQuery.page("page1",5);
            
            $("#dqueryHTHdw tr").click(function(){
            	if($(this).html().toLowerCase().indexOf("<th")>-1)
            	{
            		return false;
            	}
            	$("#dqueryHTHdw tr").removeClass("selected");
            	
            	var did = $("#currentCheckedHthBox").val();       	
        		if(did!="")
        		{
        			$("#"+did).val($(this).attr("id"));
        			$("#Paymenthth").val($(this).attr("id"));
        			onclicdjkhth($(this).attr("id"));
        			$("#Paymentdh").val("");//代缴电话
        		}
        		$(this).addClass("selected");
            });
            
            $("#dhthChooseFormSave").click(function(){
            	$("#currentHthSaved").val("Y")
            	setTimeout($.unblockUI,10);            	           
            });
            
            $("#dhthChooseFormReset").click(function(){
            	$("#currentHthSaved").val("N")
            });
        }
        
        /********
        *代缴合同号面板查询模糊查询时调用该方法
        *1为电话查询，2为合同号查询，3为名称查询
        *@param;
       	*@return;
        *********/
        function queryPaymenththkey(){
        	var selecththvalue = $("#selectPaymenththvalue").val();
        	var selecththcontent = $("#selectPaymenththcontent").val();
        	if(selecththcontent.length==0){
        		//alert("请输入查询条件！");
        		alert($("#getinternet0041").val());
        		$("#selectPaymenththcontent").select();
        		$("#selectPaymenththcontent").focus();
        		return false;
        	}
        	var querykey="";
        	if(selecththvalue==""){
        		//alert("请选择查询类别！");
        		alert($("#getinternet0042").val());
        		return false;
        	}else if(selecththvalue=="1"){
        		querykey="dbsql_phonelnstalled.selectPaymenththkey01dh";
        	}else if(selecththvalue=="2"){
        		querykey="dbsql_phonelnstalled.selectPaymenththkey02hth";
        	}else if(selecththvalue=="3"){
        		querykey="dbsql_phonelnstalled.selectPaymenththkey03mc";
        	}
        	$("#dqueryHTHdw").empty();//每次查询前将以前的数据清空
        	 $("#querydjhthdh").empty(); 
        	var res = fetchMultiArrayValue(querykey,6,"&param="+tsd.encodeURIComponent(selecththcontent)+"&hth="+tsd.encodeURIComponent($("#hth").val()));
        	if(res[0]==undefined || res[0][0]==undefined)
			{	
				$("#dqueryHTHdw").append("<tr><td>"+$("#getinternet0366").val()+"</td></tr>");
				return false;
			}
            var ify="";           
            //ify += "<thead><tr><th width=\"100px;height: 20px\"><center><h4>单位合同号</h4></center></th><th width=\"100px;height: 20px\"><center><h4>用户电话</h4><th width=\"170px;height: 20px\"><center><h4>用户姓名</h4><th width=\"230px;height: 20px\"><center><h4>用户地址</h4></center></th></tr></thead>";
            for(var i=0;i<res.length;i++){
                ify +="<tbody>";
                ify += "<tr id=\""+res[i][0]+"\">";
				ify += "<td style=\"width: 100px;height: 20px\"><center>";
				ify += res[i][0];
				ify += "</center></td>";
				ify += "<td width=\"100;height: 20px\"><center>";
				ify += res[i][1];
				ify += "</center></td>";
				ify += "<td width=\"170;height: 20px\"><center>";
				ify += res[i][2];
				ify += "</center></td>";
				ify += "<td width=\"230;height: 20px\"><center>";
				ify += res[i][3];
				ify += "</center></td>";
				ify +="</tr>";
				ify +="</tbody>";
            }
            $("#dqueryHTHdw").append(ify);
            
             $("#dqueryHTHdw tr").click(function(){
            	if($(this).html().toLowerCase().indexOf("<th")>-1)
            	{
            		return false;
            	}
            	$("#dqueryHTHdw tr").removeClass("selected");
            	
            	var did = $("#currentCheckedHthBox").val();       	
        		if(did!="")
        		{
        			$("#"+did).val($(this).attr("id"));
        			$("#Paymenthth").val($(this).attr("id"));
        			onclicdjkhth($(this).attr("id"));
        			$("#Paymentdh").val("");//代缴电话
        		}
        		$(this).addClass("selected");
            });
            
            $("#dhthChooseFormSave").click(function(){
            	$("#currentHthSaved").val("Y")
            	setTimeout($.unblockUI,10);            	           
            });
            
            $("#dhthChooseFormReset").click(function(){
            	$("#currentHthSaved").val("N")
            });
        }
        
         //根据代缴查询合同号来取出该合同号下的所有电话
        function onclicdjkhth(key){
        	$("#querydjhthdh").empty(); 
        	var res = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&tablename=yhdang&cloum=dh,yhmc,yhdz&key=hth='"+key+"'");
            if(res[0]==undefined || res[0][0]==undefined)
			{
				return false;
			}
            var ify="";                       
            for(var i=0;i<res.length;i++){
                ify +="<tbody>";
                ify += "<tr id=\""+res[i][0]+"\" onclick='getdjdhcolor("+res[i][0]+")'>";
				ify += "<td style=\"width: 130px;\"><center>";
				ify += res[i][0];
				ify += "</center></td>";
				ify += "<td width=\"180\"><center>";
				ify += res[i][1];
				ify += "</center></td>";
				ify += "<td width=\"200\"><center>";
				ify += res[i][2];
				ify += "</center></td>";
				ify +="</tr>";
				ify +="</tbody>";
            }
            $("#querydjhthdh").append(ify);
        }
        
        /********
       	*设置选中电话时颜色
        *@param：key 电话号;
       	*@return;
        *********/
        function getdjdhcolor(key){
        	  $("#Paymentdh").val(key);//代缴电话
		      $("#querydjhthdh tr").css('background-color','#ffffff');
		      document.getElementById(key).style.background='#00ffff';
        }
        
        ///////////////////////////////////////////添加代缴配置//////////////////////////////////////////
		/********
       	*添加代缴配置保存临时表
        *@param;
       	*@return;
        *********/ 
        function addPaymentnew()
        {
        	var Paymentfeetype = $("#phonePaymentfeename").val();
        	if(Paymentfeetype=="" || Paymentfeetype==undefined)
        	{
        		//alert("请选择代缴费用项目");
        		alert($("#getinternet0057").val());
        		return false;
        	}
        	else
        	{
        		var dh = $("#Dh_yhdang").val();
        		if(dh=="")
        		{
        			//alert('请先获取空号!'); //add by chenlang
        			alert($("#getnullphone").val());
        			$("#phonePaymentfeename").val('');
        			$("#Dh_yhdang").focus();
        			return false;
        		}
        		var Paymenthth = $("#Paymenthth").val();
        		Paymenthth=Paymenthth.replace(/(^\s*)|(\s*$)/g,"");
        		if($("#phonePaymentfeename").val()==""){
        			//alert("请选择代缴名称！");
        			alert($("#getinternet0058").val());
        			$("#phonePaymentfeename").select();
        			$("#phonePaymentfeename").focus();
        			return false;
        		}
        		if(Paymenthth==""){
        			//alert("代缴合同号不能为空！");
        			alert($("#getinternet0059").val());
        			$("#Paymenthth").select();
        			$("#Paymenthth").focus();
        			return false;
        		}
        		var Paymentdh = $("#Paymentdh").val();
        		Paymentdh=Paymentdh.replace(/(^\s*)|(\s*$)/g,"");
        		//if(Paymentdh==""){alert("代缴电话不能为空！");$("#Paymentdh").select();$("#Paymentdh").focus();return false;}
        		var Paymentfee = $("#Paymentfee").val();
        		Paymentfee=Paymentfee.replace(/(^\s*)|(\s*$)/g,"");
        		if(Paymentfee==""){
        			//alert("代缴金额不能为空！");
        			alert($("#getinternet0060").val());
        			$("#Paymentfee").select();
        			$("#Paymentfee").focus();
        			return false;
        		}
        		var Paymentrate = $("#Paymentrate").val();
        		Paymentrate=Paymentrate.replace(/(^\s*)|(\s*$)/g,"");
        		if(Paymentrate==""){
        			//alert("代缴比例不能为空！");
        			alert($("#getinternet0061").val());
        			$("#Paymentrate").select();
        			$("#Paymentrate").focus();
        			return false;
        		}
        		var cont=fetchSingleValue("dbsql_phone.queryPaymentinsteaditem",6,"&Paymentfeename="+tsd.encodeURIComponent($("#phonePaymentfeename").val())+"&dh="+dh);
        		cont = parseInt(cont);
        		if(cont!=0)
        		{
        			//alert("代缴费用\"" + $('#phonePaymentfeename option[selected]').text() + "\"已经存在，不能重复添加");
        			alert($("#getinternet0063").val() + $('#phonePaymentfeename option[selected]').text() + $("#getinternet0014").val());
        			return false;
        		}
        		var conthth=fetchSingleValue("dbsql_phone.queryhthdanghth",6,"&hth="+tsd.encodeURIComponent($("#Paymenthth").val()));
        		if(conthth==0){
        			//alert("代缴合同号不存在，请重新选择或填写！");
        			alert($("#getinternet0064").val());
        			$("#Paymenthth").select();
        			$("#Paymenthth").focus();
        			return false;
        		}
        		var params = "";
        		params += "&Dh="+dh;
        		params += "&HTH=" + tsd.encodeURIComponent($("#Hth").val());
        		params += "&INSTEADHTH="+tsd.encodeURIComponent($("#Paymenthth").val());
        		params += "&ITEMID="+tsd.encodeURIComponent($("#phonePaymentfeename").val());
        		params += "&FEE="+tsd.encodeURIComponent($("#Paymentfee").val()); 
        		params += "&RATE="+tsd.encodeURIComponent($("#Paymentrate").val());
        		params += "&OperID="+tsd.encodeURIComponent($("#userloginid").val());
        		params += "&INSTEADDH="+Paymentdh;
        		var insertRes = executeNoQuery("dbsql_phone.addPayment",6,params);
        		if(insertRes=="true" || insertRes==true)
        		{
        			//alert("添加数据成功");
        			$("#phonePaymentfeename").val('');
        			$("#Paymentfee").val("");
        			$("#Paymentrate").val("");
        			Packaget_Refreshs('');
        		}
        		else
        		{
        			//alert("添加数据失败");
        			alert($("#getinternet0017").val());
        		}
        		
        		$("#Packagetypes").val("");
        	}
        }
        
         /********
       	*刷新代缴设置临时表
        *@param;
       	*@return;
        *********/ 
        function Packaget_Refreshs(key)
        {
			$("#Paymenttable tr:has('td')").remove();
			$("#Paymenttable tr:empty").remove();			
			var phone = '';
			if(key!=''){
				phone = key;
			}else{
				phone = $("#Dh_yhdang").val();
			}			
			if(phone=="")
			{
				//alert('获取数据失败，请联系系统管理员!');
				alert($("#getinternet0056").val());
				return false;
			}
			var res = fetchMultiArrayValue("dbsql_phone.queryinsteaditemnewall",6,"&dh="+phone);	
			if(res[0]==undefined || res[0][0]==undefined)
			{
				return false;
			}			
			var count = res.length;
			var ify = "";
			for(var i=0;i<count;i++)
			{
				ify += "<tr>";
				ify += "<td width='20' height='16'><center>";
				ify += "<input type=\"checkbox\" id=\"v_Payment_checks\"" + i + " onclick=\"getpaymentstr("+res[i][0]+")\"/>";
				ify += "</center></td>";
				ify += "<td style='display:none'><center>";
				ify += res[i][0];
				ify += "</center></td>";
				ify += "<td width='120' height='16'><center>";
				ify += res[i][1];
				ify += "</center></td>";
				ify += "<td width='120' height='16'><center>";
				ify += res[i][2]+"￥";
				ify += "</center></td>";
				ify += "<td width='115' height='16'><center>";
				ify += res[i][3]+"%";
				ify += "</center></td>";
				ify += "<td width='125' height='16'><center>";
				ify += res[i][4];
				ify += "</center></td>";
				ify += "<td width='125' height='16'><center>";
				ify += res[i][5];
				ify += "</center></td>";
				ify += "<tr>";	
			}			
			$("#Paymenttable").append(ify);
			$("input[id^='Paymenttable_checkalls']").removeAttr("checked");
        }
        
        function getpaymentstr(key){        
        	var cstr = $('#checkPayment').val()
        	var strto = key+","+cstr;
        	$('#checkPayment').val(strto)
        }
        
        /********
       	*代缴费用设置删除
        *@param;
       	*@return;
        *********/ 
        function Payment_Dels()
        {
        	var checkedBytc = $("input[id^='v_Payment_checks'][checked]");
        	var count = $(checkedBytc).size();
        	if(count<1)
        	{
        		//alert("请选择要代缴设置费用项");
        		alert($("#getinternet0057").val());
        		return false;
        	}
        	var dh = $("#Dh_yhdang").val();
        	var tclx = "";        	
        	var result = true;
        	var resultTmp = false;        	
        	for(var i=0;i<count;i++)
        	{
        		tclx = $(checkedBytc[i]).parent().parent().next().text();   
        		//resultTmp = executeNoQuery("dbsql_phone.deletePayment",6,"&Paymentfeename="+tsd.encodeURIComponent($("#checkPayment").val())+"&dh="+dh);      		
        		resultTmp = executeNoQuery("dbsql_phone.deletePayment",6,"&Paymentfeename="+tsd.encodeURIComponent(tclx)+"&dh="+dh);
        		if(resultTmp=="false" || resultTmp==false)
        		{
        			result = false;
        		}
        	}        	
        	if(result)
        	{
        		//alert("删除套餐成功");
        		alert($("#getinternet0019").val());
        		Packaget_Refreshs('');
        		$("#phonePaymentfeename").val('');
        		$("#Paymentfee").val("");
        		$("#Paymentrate").val("");
        		$("#checkPayment").val("");
        	}
        	else
        	{
        		//alert("删除套餐失败");
        		alert($("#getinternet0020").val());
        	}
        	Packaget_Refreshs('');
        }
        
        
        /*******
        *获取代缴费用
        *@param：feename费用名称
        *@return
        ********/
        function getPayment()
        {        	
        	var urlstr=tsd.buildParams({ 
    										packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',//返回数据格式 
						 					tsdpk:'dbsql_phone.queryPaymentfeename'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					});	
				var ghzfzfx='';
				$("#phonePaymentfeename").empty();
				ghzfzfx +="<option value='' selected=true>--"+$("#getinternet0365").val()+"--</option>";	
				$.ajax({
					url:'mainServlet.html?'+urlstr,					
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
							$(xml).find('row').each(function(){
		                 			ghzfzfx +="<option value='"+$(this).attr("itemid")+"'>"+$(this).attr("itemname")+"</option>";
							});
							$("#phonePaymentfeename").append(ghzfzfx);
					}
				});
        }
        
        /********
        *代缴费用  费用名称 下拉框change事件 并去除对应的费用项信息 
        *@param;
       	*@return;
        ********/       
        function getPaymentall()
        {
           var phonePaymentfeename = $("#phonePaymentfeename").val();    
           if(phonePaymentfeename=="")
           {
              $("#Paymentfee").val("");
              $("#Paymentrate").val("");
              return false;
           }           
           //取费用项信息
           var res = fetchMultiArrayValue("dbsql_phone.queryPaymentall",6,"&feename="+tsd.encodeURIComponent(phonePaymentfeename));
           var fee = res[0][0];
           var rate = res[0][1];
           $("#Paymentfee").val(fee);
           $("#Paymentrate").val(rate);
        }
		//////////////////////////////////////////////////////////////////////////////////////////////
		
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
	
	
	/********
        *选中所有后悔套餐 
        *@param;
       	*@return;
        ********/
        function Bytc_CheckALL(key)
        {        	
        	if($("#bytctab_checkall").attr("checked"))
        	{
        		if(key=='tc'){
        			$("input[id^='v_bytctab_checks']").attr("checked","checked");        		
        		}else{
					$("input[id^='v_bytctab_check']").attr("checked","checked");    		
        		}
        	}else{
        		if(key=='tc'){
        			$("input[id^='v_bytctab_checks']").removeAttr("checked");
        		}else{
					$("input[id^='v_bytctab_check']").removeAttr("checked");  		
        		}
        	}
        	if($("#Paymenttable_checkalls").attr("checked")){
        		$("input[id^='v_Payment_checks']").attr("checked","checked");
        	}else{
        		$("input[id^='v_Payment_checks']").removeAttr("checked");
        	}	
        }
        
        
        /*********
				* 业务受理除装机跟也修改属性以外的其他业务权限			
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
				var yjfeeright='';
				var	hasLimitright='';
				var selFixedFeeright='';
				var Bz2right='';//是否大客户代收
				var CustTyperight='';
				var selecththarearight='';
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
						yjfeeright='true';
						hasLimitright='true';
						selFixedFeeright='true';
						Bz2right='true';//是否大客户代收
						CustTyperight='true';
						selecththarearight='true';
						flag = true;
				}else if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');
						for(var i = 0;i<spowerarr.length-1;i++){
							yjfeeright +=getCaption(spowerarr[i],'Payablefee','')+'|';//一次性费用应缴费
							hasLimitright +=getCaption(spowerarr[i],'hasLimit','')+'|';//申请停复机是否可以办理限呼业务
							selFixedFeeright +=getCaption(spowerarr[i],'selFixedFee','')+'|';//是否需要选择/取消月租
							Bz2right +=	getCaption(spowerarr[i],'Agent','')+'|';//修改属性中是否大客户代收
							CustTyperight +=getCaption(spowerarr[i],'CustType','')+'|';
							selecththarearight+=getCaption(spowerarr[i],'selecththarea','')+'|';//
						}
				}
				var hasyjfee = yjfeeright.split('|');
				var hashasLimit = hasLimitright.split('|');
				var hasselFixedFee = selFixedFeeright.split('|');
				var hasBz2 = Bz2right.split('|');//是否大客户代收
				var hasCustType = CustTyperight.split('|');
				var hasselecththarea = selecththarearight.split('|');
				var str = 'true';
				if(flag==true){
					$("#yjfeeright").val(yjfeeright);
					$("#hasLimitright").val(hasLimitright);
					$("#selFixedFeeright").val(selFixedFeeright);	
					$("#Bz2right").val(Bz2right);//是否大客户代收		
					$("#CustTyperight").val(CustTyperight);	
					$("#selecththarearight").val(selecththarearight);
				}else{
					for(var i = 0;i<hasselecththarea.length;i++){
							$("#selecththarearight").val(hasselecththarea[i]);
							break;
						}
					for(var i = 0;i<hasBz2.length;i++){
							$("#Bz2right").val(hasBz2[i]);
							break;
						}
					for(var i = 0;i<hasyjfee.length;i++){
							$("#yjfeeright").val(hasyjfee[i]);
							break;
					}
					for(var i = 0;i<hashasLimit.length;i++){
							$("#hasLimitright").val(hashasLimit[i]);
							break;
					}
					for(var i = 0;i<hasselFixedFee.length;i++){
							$("#selFixedFeeright").val(hasselFixedFee[i]);
							break;
					}	
					for(var i = 0;i<hasCustType.length;i++){
							$("#CustTyperight").val(hasCustType[i]);
							break;
						}
				}		
			}   
			
			//判断数据权限是否可编辑
			function getywslPowertrue(){									
				if($("#yjfeeright").val()=="true"){$("#yjfee").removeAttr("disabled");$("#cYingJiao").removeAttr("disabled");}				
			}
			
		/*********
		* 初始加载业务权限应缴费
		* @param;
		* @return;
	    **********/
		 jQuery(document).ready(function(){
		 		getywslUserPower();
		 		//getywslPowertrue();
		 		$("#cYingJiao").val("");
		 });
		 
		 
		 
		 /**********************************************************
				function name:    printThisReport(reportname,param)
				function:		  打印报表的通用函数(旧)
				parameters:       reportname：要打印的报表名称，即后缀为.cpt的文件
								  param: 报表需要传递的参数 格式：&id=···&username=···
				return:			  
				description:      报表文件统一放在WEB-INF/reportlets/com/tsdreport/下。
								  页面需添加的相关信息：
								  <%
									String path = request.getContextPath();
									String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
								  %>
								  <input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 	
				********************************************************/ 
				function printThisReportbusines(reportnamePath,param){
					var basepath = $('#thisbasePath').val();
					location.href = basepath + 'ReportServer?reportlet=/'+reportnamePath+'.cpt'+param;
				}
		
				
		/*******
	   	* 付费方式改变
	  	* @param;
	   	* @return;
	  	********/
        function payWayChange(obj)
        {
        	/*
        	if(obj.value=="transfer")
        	{
        		$("#danweiHTHbox").removeAttr("disabled");
        		$("#danweiHTHbox").click();
        	}
        	else
        	{
        		$("#danweiHTHbox").attr("disabled","disabled");
        		$("#danweiHTHbox").removeAttr("checked");
        		$("#danweiHTH").val("");
        	}
        	*/
        }
        
       	/****************
       	*备注限制函数
       	*oTextArea:内容
       	*******************/
       	var TextUtil = new Object(); 
            TextUtil.NotMax = function(oTextArea){ 
                var maxText = oTextArea.getAttribute("maxlength"); 
                if(oTextArea.value.length > maxText){ 
                        oTextArea.value = oTextArea.value.substring(0,maxText); 
                        //alert("输入超出限制！");
                  		alert($("#getinternet0066").val()); 
                } 
            } 
			
		///////////////////////////////页面显示隐藏某模块调/////////////////////////////////
        function gethide(key){
        	var nfy="";
			$("#businessfee").empty();
			//业务费用框
			for(var n=0;n<5;n++){
				nfy += "<tr>";
				nfy += "<td width=\"200\"><center>";
				nfy += "……";
				nfy += "</center></td>";
				nfy += "<td width=\"115\"><center>";
				nfy += "……";
				nfy += "</center></td>";
				nfy += "<tr>";
			}
			$("#businessfee").append(nfy);    
			    	
			$("#tablehthdang").hide();
			$("#tableyhdang").hide();
			$("#dhZFX").hide();
			$("#dhBYTC").hide();
			if(key=="p_changeuser"){
				$("#tablehthdang").show();
			}else if(key=="p_movephone"){
				$("#tablehthdang").show();	// Added by zhumengfeng at 2016/06/08
				$("#tableyhdang").show();				
			}else if(key=="p_changephone"){
				$("#tableyhdang").show();
			}else if(key=="p_changename"){
				$("#tableyhdang").show();
			}else if(key=="p_editfunction"){
				$("#tableyhdang").show();
			}else if(key=="p_delete"){
				$("#tablehthdang").show();	// Added by zhumengfeng at 2016/06/08
				$("#tableyhdang").show();
				$("#gdfeeshowcheck").show(); // Added by zhumengfeng at 2016/06/08
			}else if(key=="p_reservephone"){
				$("#tableyhdang").show();
			}else if(key=="p_package"){
				$("#tableyhdang").show();
			}else if(key=="p_insteatof"){
				$("#tableyhdang").show();
			}else if(key=="p_replyphone"){
				$("#tableyhdang").show();
			}else if(key=="p_movewithoutarea"){
				$("#tableyhdang").show();
			}else if(key=="p_purchase"){
				$("#tableyhdang").show();
			}
		}
		
		function getshow(){
			if($("#hthshowcheck").attr("checked")){
				$("#tablehthdang").show();
			}else if($("#hthshowcheck").attr("checked")==false){
				$("#tablehthdang").hide();
			}
			if($("#yhdangshowcheck").attr("checked")){
				$("#tableyhdang").show();
			}else if($("#yhdangshowcheck").attr("checked")==false){
				$("#tableyhdang").hide();
			}
			if($("#gdfeeshowcheck").attr("checked")){
				$("#dhZFX").show();
			}else if($("#gdfeeshowcheck").attr("checked")==false){
				$("#dhZFX").hide();
			}
			if($("#byfeeshowcheck").attr("checked")){
				$("#dhBYTC").show();
			}else if($("#byfeeshowcheck").attr("checked")==false){
				$("#dhBYTC").hide();
			}
			
			if($("#hthshowcheck_new").attr("checked")){
				$("#tablehthdang_new").show();
			}else if($("#hthshowcheck_new").attr("checked")==false){
				$("#tablehthdang_new").hide();
			}
			if($("#hthshowcheck_old").attr("checked")){
				$("#tablehthdang_old").show();
			}else if($("#hthshowcheck_old").attr("checked")==false){
				$("#tablehthdang_old").hide();
			}
		}	