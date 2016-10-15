        
		 jQuery(document).ready(function(){
		 		getisnotZK();						 										
			});
		/**
		*查询是否折扣
		**/
		function getisnotZK(){
			var isZK = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=tvalues&tablename=tsd_ini&key=tsection='pkg_rate' and tident='phone'");
			if(isZK!=undefined&&isZK!=""&&isZK!='Y'){
				$("#dzpkg,#pkg_rateStr").hide();				
			}else{
				$("#dzpkg,#pkg_rateStr").show();
			}
		}
		function getDZblock(){	
			if($("#Dh_yhdang").val()==""){
				alert("请选择一个电话空号！");
				return;
			}else if($("#Packagetypeshidden").val()==""){
				alert("请选一个套餐！");
				return;
			}
			var languageType = $("#languageType").val();	
			var resg = fetchFieldAlias('monthfee',languageType);
			var res = fetchMultiArrayValue("dbsql_phone.monthfee_feetype",6,"&feetypestr="+tsd.encodeURIComponent($("#Packagetypeshidden").val()),'business');
				if(res[0]==undefined || res[0][0]==undefined)
				{
					return false;
				}
				var ify="";
				$("#pkgtypevalue").text($("#Packagetypeshidden").val());
				$("#PriceDiscountValue").empty();
				ify+="<tr><td width=20%><center>递度</center></td><td width=20%><center>"+resg['Sec0']+"</center></td><td width=30%><center>"+resg['Sec1']+"</center></td><td width=20%><center>"+resg['BaseHf']+"</center></td><td width=20%><center>折扣比例</center></td></tr>";
				for(var i=0;i<res.length;i++){
					ify+="<tr><td>递度"+(i+1)+"</td><td>"+res[i][0]+"</td><td>"+res[i][1]+"</td><td>"+res[i][2]+"</td><td><input type='checkbox' id='Discountcheck'"+i+" name='Discountcheck'"+i+" onclick='getDiscountcheck("+res[i][0]+","+res[i][3]+")'/><span style='display:none;'>"+res[i][0]+":</span>"+res[i][3]+"%</td></tr>";	
				}
				$("#PriceDiscountValue").html(ify);
			autoBlockForm('pkgPriceDiscount_blockfrom',50,'close',"#ffffff",false);//弹出查询框		   
		}
		
		function getDiscountcheck(){		
			var Sec0Value="";
			var paramsDiscount="";			
			var Discountcheckarray = $("input[id^='Discountcheck'][checked]");
        	var count = $(Discountcheckarray).size();						
			for(var i=0;i<count;i++)
        	{			
        		paramsDiscount += $(Discountcheckarray[i]).parent().text();				
				paramsDiscount=paramsDiscount.replace("%","")+";";								
				
			}
			$("#pkg_rateStr").val(paramsDiscount);
		}