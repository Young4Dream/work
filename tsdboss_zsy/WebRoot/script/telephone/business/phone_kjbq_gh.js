/*****************************************************************
 * name: phone_kjbq_gh.js
 * author: wenxuming
 * version: 1.0, 2011-02-12
 * description: 此js只用于电话业务受理中的“跨级搬迁”跟“电话过户”俩个业务的获取合同号信息下拉框值；为了怕干扰其它方法，所以单独独立出来；
 * modify:   
 *****************************************************************/
        ///////合同号当部门信息///////////////////////////////////////////////////////////////////////////////////////////////////////////
        function querykeysBm(){
        	var key='';
        	var sBM='';
        	var code='';
        	var bmtypekey = $("#bmtypekey").val();
        	var querykeybm = $("#querykeybm").val();
        	var selectsbmkey = $("#selectsbmkey").val();
        	selectsbmkey=selectsbmkey.replace(/(^\s*)|(\s*$)/g,"");	
        	if(selectsbmkey==""){
        		//alert("请输入查询条件！");
        		alert($("#getinternet0041").val());
        		return false;
        	}
        	//通过部门名称查询
        	if(querykeybm=="1"){
        		if(bmtypekey=="Bm1"){
        			key="dbsql_phone.querysBm_keysbm";
        		}else if(bmtypekey=="Bm2"){
        			key="dbsql_phone.querysBm_codekey";
        			code=$("#sBm1code").val();
        		}else if(bmtypekey=="Bm3"){
        			key="dbsql_phone.querysBm_codekey";
        			code=$("#sBm2code").val();
        		}else if(bmtypekey=="Bm3"){
        			key="dbsql_phone.querysBm_codekey";
        			code=$("#sBm2code").val();
        		}
        	//通过索引键查询	
        	}else if(querykeybm=="2"){        		
        		if(bmtypekey=="Bm1"){
        			key="dbsql_phone.querysBm_keysbmname";
        		}else if(bmtypekey=="Bm2"){
        			key="dbsql_phone.querysBm_codenamekey";
        			code=$("#sBm1code").val();
        		}else if(bmtypekey=="Bm3"){
        			key="dbsql_phone.querysBm_codenamekey";
        			code=$("#sBm2code").val();
        		}else if(bmtypekey=="Bm3"){
        			key="dbsql_phone.querysBm_codenamekey";
        			code=$("#sBm2code").val();
        		}
        	}
        	$("#querybmcontext").empty();
			var res = fetchMultiArrayValue(key,6,"&key="+tsd.encodeURIComponent(selectsbmkey)+"&code="+code);
        	if(res[0]==undefined || res[0][0]==undefined)
			{
				$("#querybmcontext").append("<tr><td>"+$("#getinternet0366").val()+"</td></tr>");
				$("#sbmname").val("");
				return false;
			}
			for(var i=0;i<res.length;i++){
				sBM += "<tr onClick=\"getbmname('"+res[i][1]+"');getbmcode('"+res[i][0]+"');\" id=\""+res[i][0]+"\"><td><center>";
				sBM += res[i][1];
				sBM += "</center></td></tr>";
			}
			$("#querybmcontext").append(sBM);
			$("#sbmname").val("");
        }
         
         /****
		*得到部门库中的第一级部门
		****/
        function yijisBmhth(){        
            var sBM="";
            if($("#usertype option:selected").text()!="公费"){
						//alert("只有公费用户可以选择一级部门！");
						alert($("#getinternet0001").val());
						return false;
			}
            $("#querysBmtitle").text("选择一级部门");
	        $("#bmtypekey").val("Bm1");
	        autoBlockForm('querysBm',5,'close',"#ffffff",false);//弹出查询框	     	
			$("#querybmcontext").empty();
			var res = fetchMultiArrayValue("dbsql_phone.querysBm",6,"");
        	if(res[0]==undefined || res[0][0]==undefined)
			{
				$("#querybmcontext").append("<tr><td>没有信息！！！</td></tr>");
				$("#sbmname").val("");
				return false;
			}
			for(var i=0;i<res.length;i++){
				sBM += "<tr onClick=\"getbmname('"+res[i][1]+"');getbmcode('"+res[i][0]+"');\" id=\""+res[i][0]+"\"><td><center>";
				sBM += res[i][1];
				sBM += "</center></td></tr>";
			}
			$("#querybmcontext").append(sBM);
			$("#sbmname").val("");
        }
        
        /********
       	*弹出部门选择面板 点击信息时调用该方法
        *@param：key 合同号值;
       	*@return;
        *********/
        function getbmname(keyname){
		      $("#sbmname").val(keyname);//把得到的部门添加到隐藏域中点击确定的时候在从隐藏域中取		      		            
        }
        function getbmcode(keycode){
        	if(keycode!=""&&keycode!=undefined){
		      	$("#sbmcode").val(keycode);//把得到的部门添加到隐藏域中点击确定的时候在从隐藏域中取
		      }else{
		      	$("#sbmcode").val("");//把得到的部门添加到隐藏域中点击确定的时候在从隐藏域中取
		      }
		      $("#querybmcontext tr").css('background-color','#f7f7f7');
		      document.getElementById(keycode).style.background='#0080FF';  
        }
        
        //点击保存部门按钮
        function savesBm(){
        	var sbmname = $("#sbmname").val();
        	var sbmtypekey = $("#bmtypekey").val();
        	if(sbmname==""){alert("请选择部门！");return false;}
        	var sbmcode = $("#sbmcode").val();
        	if(sbmtypekey=="Bm1"){
        		$("#sBm1").val(sbmname);
        		$("#Bm1_yhdang").val(sbmname);
        		$("#sBm1code").val(sbmcode);
        		$("#sBm2").val("");
        		$("#sBm3").val("");
        		$("#sBm4").val("");
        		$("#Bm2_yhdang").val("");
        		$("#Bm3_yhdang").val("");
        		$("#Bm4_yhdang").val("");
        	}else if(sbmtypekey=="Bm2"){
        		$("#sBm2").val(sbmname);
        		$("#Bm2_yhdang").val(sbmname);
        		$("#sBm2code").val(sbmcode);
        		$("#sBm3").val("");
        		$("#sBm4").val("");
        		$("#Bm3_yhdang").val("");
        		$("#Bm4_yhdang").val("");
        	}else if(sbmtypekey=="Bm3"){
        		$("#sBm3").val(sbmname); 
        		$("#Bm3_yhdang").val(sbmname);
        		$("#sBm3code").val(sbmcode);       		
        		$("#sBm4").val("");
        		$("#Bm4_yhdang").val("");
        	}else if(sbmtypekey=="Bm4"){
        		$("#sBm4").val(sbmname);
        		$("#Bm4_yhdang").val(sbmname);
        	}
        	closeGB();
        }
        							
		/****
		*得到部门库中的第二级部门
		****/
        function addsBmerhth()
        {                  	
           sBM="";
           if($("#sBm1").val()==""){
           		//alert("请选择一级部门");
           		alert($("#getinternet0132").val());
           		return false;
           	}
           //$("#querysBmtitle").text("选择二级部门");          
           $("#querysBmtitle").text($("#getinternet0133").val());
	       autoBlockForm('querysBm',5,'close',"#ffffff",false);//弹出查询框
	       $("#bmtypekey").val("Bm2");	
           $("#querybmcontext").empty();
			var res = fetchMultiArrayValue("dbsql_phone.querysBm_code",6,"&code="+$("#sBm1code").val());
        	if(res[0]==undefined || res[0][0]==undefined)
			{
				$("#querybmcontext").append("<tr><td>"+$("#getinternet0366").val()+"</td></tr>");
				$("#sBm1code").val("");
				$("#sbmname").val("");
				return false;
			}
			for(var i=0;i<res.length;i++){
				sBM += "<tr onClick=\"getbmname('"+res[i][1]+"');getbmcode('"+res[i][0]+"');\" id=\""+res[i][0]+"\"><td><center>";
				sBM += res[i][1];
				sBM += "</center></td></tr>";
			}
			$("#querybmcontext").append(sBM);
			$("#querybmcontext tr").css("line-height","25px");
			$("#sbmname").val("");
        }	
         
        /****
		*得到部门库中的第三级部门
		****/
        function addsBmsanhth(){
          var sBM='';
          if($("#sBm2").val()==""){
          		//alert("请选择二级部门");
          		alert($("#getinternet0134").val());
          		return false;
          }
          //$("#querysBmtitle").text("选择三级部门");
          $("#querysBmtitle").text($("#getinternet0135").val());
	      autoBlockForm('querysBm',5,'close',"#ffffff",false);//弹出查询框
	      $("#bmtypekey").val("Bm3");
	      $("#querybmcontext").empty();
          var res = fetchMultiArrayValue("dbsql_phone.querysBm_code",6,"&code="+$("#sBm2code").val());
        	if(res[0]==undefined || res[0][0]==undefined)
			{
				$("#querybmcontext").append("<tr><td>"+$("#getinternet0366").val()+"</td></tr>");
				$("#sBm2code").val("");
				$("#sbmname").val("");
				return false;
			}
			for(var i=0;i<res.length;i++){
				sBM += "<tr onClick=\"getbmname('"+res[i][1]+"');getbmcode('"+res[i][0]+"');\" id=\""+res[i][0]+"\"><td><center>";
				sBM += res[i][1];
				sBM += "</center></td></tr>";
			}
			$("#querybmcontext").append(sBM);
			$("#querybmcontext tr").css("line-height","25");			
			$("#sbmname").val("");
        }	 
        
        /****
		*得到部门库中的第四级部门
		****/
        function addsBmsihth(){          
          var sBM='';
          if($("#sBm3").val()==""){
          		//alert("请选择三级部门");
          		alert($("#getinternet0136").val());
          		return false;
          }
         // $("#querysBmtitle").text("选择四级部门");
         $("#querysBmtitle").text($("#getinternet0137").val());
	      autoBlockForm('querysBm',5,'close',"#ffffff",false);//弹出查询框
	      $("#bmtypekey").val("Bm4");
	      $("#querybmcontext").empty();
          var res = fetchMultiArrayValue("dbsql_phone.querysBm_code",6,"&code="+$("#sBm3code").val());
        	if(res[0]==undefined || res[0][0]==undefined)
			{
				$("#querybmcontext").append("<tr><td>"+$("#getinternet0366").val()+"</td></tr>");
				$("#sBm3code").val("");
				$("#sbmname").val("");
				return false;
			}
			for(var i=0;i<res.length;i++){
				sBM += "<tr onClick=\"getbmname('"+res[i][1]+"');getbmcode('"+res[i][0]+"');\" id=\""+res[i][0]+"\"><td><center>";
				sBM += res[i][1];
				sBM += "</center></td></tr>";
			}
			$("#querybmcontext").append(sBM);
			$("#querybmcontext").css("line-height","25px");
			$("#sbmname").val("");
        	}
         /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         
         
         ///////////////////////////固话杂费编辑内容/////////////////////////////////////////////////////////////////////////////
          /*******
		  	* 选中所有的电话杂费项
		  	* @param;
		  	* @return;
	      	********/
		    function Dhzf_CheckAll()
		    {
		    	if($("#dhzftab_checkall").attr("checked"))
	        		$("input[id^='v_dhzftab_check']").attr("checked","checked");
	        	else
	        		$("input[id^='v_dhzftab_check']").removeAttr("checked");
		    }
		    		    
		    /*******
		  	* 删除列表中的电话费用杂费信息
		  	* @param;
		  	* @return;
	      	********/
		    function deletephonefeename()
		    {	
				var checkedDhzf = $("input[id^='v_dhzftab_check'][checked]");
	        	var count = $(checkedDhzf).size();	        	
	        	if(count<1)
	        	{
	        		//alert("请选择要删除的杂费项信息");
	        		alert($("#getinternet0138").val());
	        		return false;
	        	}	        	
	        	var dh = $("#Dh_yhdang").val();
	        	var feetype = "";	       
	        	var feecode = ""; 	
	        	var result = true;
	        	var resultTmp = false;	        	
	        	for(var i=0;i<count;i++)
	        	{
	        		feetype = $(checkedDhzf[i]).parent().parent().next().text();
	        		feecode = $(checkedDhzf[i]).parent().parent().next().next().text();//费用code是隐藏在表格中的
	        		var result = fetchMultiPValue("phonelnstalled.insertphonefeename",6,"&feetype="+tsd.encodeURIComponent(feetype)+"&feecode="+feecode+"&dh="+dh+"&ywlx="+"&cztype=delete");	   	
					 if(result[0]!=undefined && result[0][0]!="")
					 {					 	
	        			
					 }else{
					 	//alert("删除杂费失败");
					 	alert($("#getinternet0139").val());
					 }
	        		/*
	        		resultTmp = executeNoQuery("phonelnstalled.deletephonefeename",6,"&FeeType="+tsd.encodeURIComponent(feetype)+"&Dh="+dh);	        		
	        		if(resultTmp=="false" || resultTmp==false)
	        		{
	        			alert("删除杂费失败");
	        			result = false;
	        		}*/
	        	}
	        	/*
	        	if(result)
	        	{
	        		alert("删除杂费成功");
	        	}
	        	else
	        	{
	        		alert("删除杂费失败");
	        	}*/
	        	$("#phonefeenamecode").val("");
        	    $("#phonefeename tr").css('background-color','#f7f7f7');
	        	//重新加载数据
	        	addspeediFeeType(dh);
		    }
        
        	   
	   	/*******
		 * 选择费用名称
		 * @param;
		 * @return;
	     ********/
	    function getfeenameall()
        {
           var phonefeename = $("#phonefeenamecode").val();
           //alert(phonefeename);         
           if(phonefeename=="")
           {
              $("#feecode").val("");
              $("#Subtype").val("");
              $("#feelv").val("");
              $("#TJfeelv").val("");
              $("#ZFStartday").val("");
              $("#ZFEnday").val("");
              return false;
           }
           var feename = $("#phonefeetype option:selected").text();
           if($("#phonefeetype").val()==""){
           		feename="";
           	} 
           //取费用项信息           
           var res = fetchMultiArrayValue("phonelnstalled.queryfeenameall",6,"&FeeType="+tsd.encodeURIComponent(phonefeename)+"&vfeename="+tsd.encodeURIComponent(feename));
           var FeeCode = res[0][0];
           var FeeName = res[0][1];
           var Price = res[0][3];
           var TjPrice = res[0][4];
           var stype = res[0][6];
           $("#feecode").val(FeeCode);
           $("#Subtype").val(FeeName);
           $("#feelv").val(Price);
           $("#TJfeelv").val(TjPrice);
           $("#stype").val(stype);
        }  
                
        /*******
		 * 根据费用类型取子项目
		 * @param;
		 * @return;
	     ********/
        function getfeename()
        {
        	var feename = $("#phonefeetype").val();
        	//删除时把左边的点击显示颜色清空掉，然后把隐藏值也清空掉
	        $("#phonefeenamecode").val("");
	        getGHcsnum("");
        	$("#phonefeename tr").css('background-color','#f7f7f7');
        	if(feename==""){feename='000000';}
        	var urlstr=tsd.buildParams({ 
    										packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',//返回数据格式 
						 					tsdpk:'dbsql_phone.attachpricefeetype'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					});	
				var ghzfzfx='';
				$("#phonefeename").empty();	
				$.ajax({
					url:'mainServlet.html?'+urlstr+"&feename="+tsd.encodeURIComponent(feename),					
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
							$(xml).find('row').each(function(){
								if($(this).attr("feetype")!=undefined){
		                 			ghzfzfx +="<tr onClick=\"getGHfeetr('"+$(this).attr("feetype")+"');getGHcsnum('"+$(this).attr("csnum")+"');\" id=\""+$(this).attr("feetype")+"\"><td>";
		                 			ghzfzfx +="☞"+$(this).attr("feetype");
		                 			ghzfzfx +="</td></tr>";
		                 		}
							});
							$("#phonefeename").append(ghzfzfx);
					}
				});
				$("#feelv").val("");
				$("#TJfeelv").val("");	
        }
        
        /*******
        *单击选中一行固话杂费
        *@param：key子费用名称
        *@return
        ********/
        function getGHfeetr(key){
        	$("#phonefeenamecode").val(key);
        	getfeenameall();
        	$("#phonefeename tr").css('background-color','#f7f7f7');
		     document.getElementById(key).style.background='#0080FF';  
        }
        
        /*******
        *单击选中一行固话杂费表获取参数数量值来显示页面显示几个参数个数框
        *@param：key参数数量值csnum
        *@return
        ********/
        function getGHcsnum(key){
        	var strtable="";
        	if(key==undefined||key==""||key=="null"){
        		key=0;
        	}
        	$("#keyhidden").val(key);
        	$("#ghfeeinput").empty();
        	var startdate = $("#startdate").val();        	
        	strtable +="<tr>";
        	//strtable +="<td>起始时间</td>";
        	strtable +="<td>"+$("#getinternetstarttime").val()+"</td>";
					strtable +="<td><input type='text' id='ZFStartday' name='ZFStartday' style='width: 100px;' disabled='disabled'/></td>";
					//strtable +="<td>终止时间</td>";
					strtable +="<td>"+$("#getinternetermination").val()+"</td>";
					strtable +="<td><input type='text' id='ZFEndday' name='ZFEndday' style='width: 100px;' disabled='disabled' value='2999-12-31'  /></td>";
					strtable +="<td>收费月份</td>";					
					strtable +="<td><input type='text' id='sfmonth' name='sfmonth' style='width: 100px;'/></td>";
					strtable +="<td>设备数量</td>";
					strtable +="<td><input type='text' id='DEVNUM' name='DEVNUM' style='width:70px;' value='1' onkeypress='return event.keyCode>=4&&event.keyCode<=57'/></td>";
					strtable +="<td>单位长度</td>";
					strtable +="<td><input type='text' id='DEVLENGTH' name='DEVLENGTH' style='width:70px;' value='1' onkeypress='return event.keyCode>=4&&event.keyCode<=57'/></td>";
					strtable +="<td></td>"
					key=parseInt(key,10);
        	for(var i=1;i<key+1;i++){
        		strtable +="<td>";
        		//strtable +="参数"+i;
        		strtable +=$("#getinternet0382").val()+i;        		
        		strtable +="</td><td>";
        		strtable +="<input type='text' id='cs"+i+"' style='width:100px;'/>";
        		strtable +="</td>";
        	}
        	strtable +="</tr>";
        	$("#ghfeeinput").append(strtable);
        	$("#ZFStartday").val(startdate);
        	$("#sfmonth").val(startdate.replace('-','').substring(0,6));
        	$("#ZFEndday").removeAttr("disabled");
					$("#ZFStartday").removeAttr("disabled");  
					///电话杂费  终止月
					$("#ZFStartday").focus(function(){
						WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
					});
					///电话杂费  终止日
					$("#ZFEndday").focus(function(){
						WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
					});   
					///电话杂费  终止日
					$("#sfmonth").focus(function(){
						WdatePicker({startDate:'yyyyMM',readOnly:'true',dateFmt:'yyyyMM',alwaysUseStartDate:true});
					});
					$("#cs1").val("");
					$("#cs2").val("");
					$("#cs3").val("");   
					$("#DEVNUM,#DEVLENGTH input[value='1']").blur(function(){
						if($(this).val()==""){
							$(this).val('1');
						}
					});							
					$("#DEVNUM,#DEVLENGTH input[value='1']").focus(function(){
						if($(this).val()==1){
							$(this).val('')
						}
					});
					$("#DEVNUM,#DEVLENGTH input[value='1']").keydown(function(){			
						var k=event.keyCode;
						return k>=48&&k<=57||k==190&&this.value!=""&&this.value.indexOf(".")==-1||k==8||k==37||k==39;
					});					
					$("#DEVNUM,#DEVLENGTH input[value='1']").bind("copy paste",function(){
						return false;
					});	
        }
         
        /*******
		 * 生成电话杂费feetype
		 * @param;
		 * @return;
	     ********/ 
        function getphonefeename()
        {
           $("#phonefeetype").html("<option value=\"\">--"+$("#getinternet0365").val()+"--</option>");           
           var res = fetchMultiArrayValue("dbsql_phone.attachprice",6,"&jhjid="+$("#SwitchNumber").val()+"&dhlx="+tsd.encodeURIComponent($("#dhlx_yhdang").val()));           
           if(res[0]==undefined || res[0][0]==undefined)
           {
				return false;
           }
           
           var querysel="";
		   for(var i=0;i<res.length;i++)
		   {
		       var ee="<option value='"+res[i][1]+"'>"+res[i][0]+"</option>";	
		       querysel+=ee;					
		   }

		   $("#phonefeetype").append(querysel);
        }
        
         /*******
		  	* 添加电话费用杂费信息
		  	* @param;
		  	* @return;
	      	********/
		   function insertphonefeename()
		   {
		      var phone = $("#Dh_yhdang").val();
		      if(phone=="")
		      {
		      	//alert("请选择一个电话空号！");
		      	alert($("#getnullphone").val());
		      	return false;
		      }
		      var phonefeename = $("#phonefeenamecode").val();
		      
		      if($("#phonefeetype").val()=="")
		      {
		      	//alert("请选择要添加的费用名称");
		      	alert($("#getinternet0006").val());
		      	$("#phonefeetype").focus();
		      	return false;
		      }
		      
		      if(phonefeename=="" || phonefeename==null)
		      {
		      	//alert("请选择要添加的费用子类型");
		      	alert($("#getinternet0007").val());
		      	$("#phonefeename").focus();
		      	return false;
		      }
		      
		      phonefeename = tsd.encodeURIComponent(phonefeename);	
		      var ress = JudgeISNOTStorage(phonefeename,phone,$("#Subtype").val(),$("#phonefeetype").val());
		      if(ress!=0)
		      {
		      	//alert("该费用子类型已经存在不能重复添加！");
		      	alert($("#getinternet0008").val());
		      	return false;
		      }
		     
		      var feecode = $("#feecode").val();
		      var feelv = $("#feelv").val();
		      var TJfeelv = $("#TJfeelv").val();
		      var ZFStartday = $("#ZFStartday").val();
		      
		      if(!/^\d{4}-\d{2}-\d{2}$/.test(ZFStartday))
		      {
		      	$("#ZFStartday").focus();
		      	return false;
		      }
		      
		      var ZFEndday = $("#ZFEndday").val();
		      
		      if(!/^\d{4}-\d{2}-\d{2}$/.test(ZFEndday))
		      {
		      	$("#ZFEndday").focus();
		      	return false;
		      }
		      
		      var ZFStartmonth = ZFStartday.substring(0,7);//起始月
		      ZFStartmonth = ZFStartmonth.replace('-',"");
		      
		      var ZFEndmonth = ZFEndday.substring(0,7);//终止月
		      ZFEndmonth = ZFEndmonth.replace('-',"");
		      
		      var feename = $("#Subtype").val();
		      /*
		      if(feename=="月租" && isXinYeWuExists(phone)!="0")
		      {
		      	alert("已经存在一项月租费，不能多次添加");
		      	return false;
		      }*/
		      feename = tsd.encodeURIComponent(feename);
		      
		      //检测终止时间是否大于起始时间
		      /*
		      var resg = gettimeday(ZFStartday,ZFEndday);
		      resg = parseInt(resg,10);
		      if(resg<=0)
		      {
					alert("终止时间必须大于起始时间！");
					$("#ZFEndday").select();
		      		$("#ZFEndday").focus();
		      		return false;
		      }
		      */
		      var cs1 = $("#cs1").val();
		      if(cs1==undefined||cs1=="undefined"){cs1=""}
		      cs1=cs1.replace(/(^\s*)|(\s*$)/g,"");
		      var cs2 = $("#cs2").val();
		      if(cs2==undefined||cs2=="undefined"){cs2=""}
		      cs2=cs2.replace(/(^\s*)|(\s*$)/g,"");
		      var cs3 = $("#cs3").val();
		      if(cs2==undefined||cs3=="undefined"){cs3=""}
		      cs2=cs2.replace(/(^\s*)|(\s*$)/g,"");
		      var csstr;
		      if(cs1!=""&&cs2==""){
		      	 csstr = cs1;		      	 
		      }else if(cs1!=""&&cs2!=""&&cs3==""){
		      	 csstr = cs1+"~"+cs2;
		      }else if(cs2!=""&&cs1!=""&&cs3!=""){
		      	 csstr = cs1+"~"+cs2+"~"+cs3;
		      }		      
		      if(cs1==""&&cs2==""&&cs3==""){
		      	csstr="";
		      }
		      if(csstr==undefined){csstr="";}
		      csstr=csstr.replace('~undefined',"");
		      csstr=csstr.replace('undefined',"");
		      var DEVNUMstr = $("#DEVNUM").val().replace(/(^\s*)|(\s*$)/g,"");
		      var DEVLENGTHstr = $("#DEVLENGTH").val().replace(/(^\s*)|(\s*$)/g,"");
		      var CUNIT = $("#CUNIT").val();
		      if ($("#Bz4_yhdang").val()=="PBX连选"&&DEVNUMstr<=1){
		      		alert("选择连选号码时，设备数量必须大于1");
		      		return;
		      }
		      
		      var sfmonth=$("#sfmonth").val();
		      var stype=$("#stype").val();
		      
		      var result = fetchMultiPValue("phonelnstalled.insertphonefeename",6,"&dh="+phone+"&feetype="+phonefeename+"&feecode="+feecode+"&feelv="+feelv+"&TJfeelv="+TJfeelv+"&StartMonth="+ZFStartmonth+"&EndMonth="+ZFEndmonth+"&StartDate="+ZFStartday+"&EndDate="+ZFEndday+"&feename="+feename+"&OperID="+tsd.encodeURIComponent($("#userid").val())+"&csstr="+tsd.encodeURIComponent(csstr)+"&cztype=add"+"&DEVNUM="+DEVNUMstr+"&DEVLENGTH="+DEVLENGTHstr+"&CUNIT="+CUNIT+"&sfmonth="+sfmonth+"&stype="+stype);	   	
			 if(result[0]!=undefined && result[0][0]!=""&&result[0][0]=="SUCCEED")
			 {
			 	addspeediFeeType(phone);//重新加载数据
		        getGHcsnum("");
		        $("#feecode").val("");
		        $("#feelv").val("");
		        $("#TJfeelv").val("");
		        //$("#ZFStartday").val("");
		        //$("#ZFEndday").val("");
		        $("#Subtype").val("");
		        $("#feenameid").val("");
		        $("#Subtype").val("");
		        $("#phonefeename").val("");
			 }else{
			 	//alert("新增失败！");		
			 	alert(result[0][1]);        			
			 }
			 $("#phonefeenamecode").val("");
        	 $("#phonefeename tr").css('background-color','#f7f7f7');
		      /*
		      var res = executeNoQuery("phonelnstalled.insertphonefeename",6,"&dh="+phone+"&feetype="+phonefeename+"&feecode="+feecode+"&feelv="+feelv+"&TJfeelv="+TJfeelv+"&StartMonth="+ZFStartmonth+"&EndMonth="+ZFEndmonth+"&StartDate="+ZFStartday+"&EndDate="+ZFEndday+"&feename="+feename+"&OperID="+tsd.encodeURIComponent($("#userid").val())+"&csstr="+tsd.encodeURIComponent(csstr));
		      if(res=="true")
		      {
		        addspeediFeeType(phone);//重新加载数据
		        getGHcsnum("");
		        $("#feecode").val("");
		        $("#feelv").val("");
		        $("#TJfeelv").val("");
		        //$("#ZFStartday").val("");
		        //$("#ZFEndday").val("");
		        $("#Subtype").val("");
		        $("#feenameid").val("");
		        $("#Subtype").val("");
		        $("#phonefeename").val("");
		        $("#phonefeenamecode").val("");
        	    $("#phonefeename tr").css('background-color','#ffffff');
		      }
		      else
		      {
		        alert("保存失败！");		        
		      }*/
		    }
		    		    
		    /*******
		  	* 添加新费用的时候判断该费用项是否已经在临时表里
		  	* @param:params费用类型，parm用户电话;
		  	* @return;
	      	********/
		    function JudgeISNOTStorage(params,parm,feename)
		    {
		        var result;
		        var res = fetchMultiArrayValue("phonelnstalled.queryisnotfeename",6,"&Dh="+parm+"&FeeType="+params+"&vfeename="+tsd.encodeURIComponent(feename));	
		        result = res[0][0];
		        return result;	    
		    }
		    
		    /*******
		  	* false存在新业务，true不存在新业务
		  	* @param:dh电话;
		  	* @return;
			* feename=1 月租
	      	********/
		    function isXinYeWuExists(dh)
		    {
		    	//var result = fetchSingleValue("phonelnstalled.xinyewualreadyexists",6,"&Dh=" + dh+"&feename="+tsd.encodeURIComponent('月租'));
		    	var result = fetchSingleValue("phonelnstalled.xinyewualreadyexists",6,"&Dh=" + dh+"&feename=1");
		    	if(result=="0")
		    	{
		    		return "0";
		    	}
		    	else if(result=="1")
		    	{
		    		return "1";
		    	}
		    	else
		    	{
		    		return "2";
		    	}
		    }
		    
		  /********
          *查询生成该电话固话费用项信息，以表格的形式显示
          *@param;
       	  *@return;
          ********/
		  function addspeediFeeType(Dh)
		  {
		    var phone="";
		  	   if(Dh!=""){
		  	   		phone=Dh;
		  	   }else{		
			   		phone = $("#Dh_yhdang").val();
			   }
			   if(phone=="")
			   {
					return false;
			   }
			   var ify="";
			   var count=0;
		       var urlstr=tsd.buildParams({ 	packgname:'service',//java包
							 					clsname:'ExecuteSql',//类名
							 					method:'exeSqlData',//方法名
							 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
							 					tsdcf:'mssql',//指向配置文件名称
							 					tsdoper:'query',//操作类型 
							 					datatype:'xmlattr',
							 					tsdpk:'phonelnstalled.queryphoneFYX'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							 				});			 							
				$.ajax({
						url:'mainServlet.html?'+urlstr+"&dh="+phone,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
						            ify="";
						            $("#dhzftab tr:has('td')").remove();					           
									$(xml).find('row').each(function(){
									var id = $(this).attr("id");
									var feetype = $(this).attr("feetype");
									var feecode = $(this).attr("feecode");								
									var Price = $(this).attr("price");		
									var TjPrice = $(this).attr("tjprice");	
									var StartDate = $(this).attr("startdate");
									var EndDate = $(this).attr("enddate");
									var csvalue = $(this).attr("csvalue");
									var feename = $(this).attr("feename");
									var devlength = $(this).attr("devlength");//长度
									var devnum = $(this).attr("devnum");//设备数量
									if(id!=undefined){	
									ify += "<tr>";
									ify += "<td><center>";
									ify += "<input type=\"checkbox\" id=\"v_dhzftab_check\"" + id +  "\"  />";
									ify += "</center></td>";
									ify += "<td width=\"200\"><center>";
									ify += feename+"("+$(this).attr("feetype")+")";
									ify += "</center></td>";	
									ify += "<td style='display:none;'><center>";
									ify += $(this).attr("feecode");
									ify += "</center></td>";							
									ify += "<td width=\"60\"><center>";
									ify += $(this).attr("price");
									ify += "</center></td>";
									ify += "<td width=\"100\"><center>";
									ify += $(this).attr("startdate");
									ify += "</center></td>";
									ify += "<td width=\"100\"><center>";
									ify += $(this).attr("enddate");
									ify += "</center></td>";
									/*ify += "<td width=\"73\"><center>";
									ify += devnum;
									ify += "</center></td>";
									ify += "<td width=\"73\"><center>";
									ify += devlength;
									ify += "</center></td>";*/
									ify += "<tr>";
									count += 1;
									}
								});
								for(var i=0;i<=5-count;i++){
									ify += "<tr>";
									ify += "<td width=\"20\"><center>";
									ify += ".";
									ify += "</center></td>";
									ify += "<td width=\"200\"><center>";
									ify += "……";
									ify += "</center></td>";								
									ify += "<td width=\"60\"><center>";
									ify += "……";
									ify += "</center></td>";
									ify += "<td width=\"110\"><center>";
									ify += "……";
									ify += "</center></td>";
									ify += "<td width=\"110\"><center>";
									ify += "……";
									ify += "</center></td>";
								/*	ify += "<td width=\"73\"><center>";
									ify += "……";
									ify += "</center></td>";
									ify += "<td width=\"73\"><center>";
									ify += "……";
									ify += "</center></td>";*/
									ify += "<tr>";
								}
								count=0;
								$("#dhzftab").append(ify);
								$("#dhzftab tr:empty").remove();
							}
						});					
				$("#dhzftab_checkall").removeAttr("checked");
		   } 
		   
		 ////////////////////////////////////包月套餐编辑/////////////////////////////////////////////////////////////////////////////
		 /********
       	*生成电话包月套餐组下拉框
        *@param;
       	*@return;
        *********/  
        function getPackaggroupid()
        {
           $("#Packaggroupid").html("<option value=\"\">--"+$("#getinternet0365").val()+"--</option>");           
           var res = fetchMultiArrayValue("dbsql_phone.querymonthfee_group",6,"&area="+tsd.encodeURIComponent($("#area").val())+"&ywarea="+tsd.encodeURIComponent($("#userareaid").val()));           
           if(res[0]==undefined || res[0][0]==undefined)
           {
           		return false;
           }           
           var querysel="";
		   for(var i=0;i<res.length;i++)
		   {
		       var ee="<option value='"+res[i][0]+"' flf='"+res[i][2]+" 'title='"+res[i][1]+"'>"+res[i][1]+"</option>";	
		       querysel+=ee;					
		   }
		   $("#Packaggroupid").append(querysel);
        } 
         
        /********
       	*生成电话包月套餐下拉框
        *@param;
       	*@return;
        *********/  
        function getPackagetypes()
        {
           $("#Packagetypeshidden").val("");
           var Packaggroupid = $("#Packaggroupid").val();
           if(Packaggroupid==""){$("#Packagetypes").empty();return;}
           $("#Packagetypes tr").css('background-color','#f7f7f7');
           if($("#Dh_yhdang").val()==""){
           		//alert("请查询一个电话号码！");
           		alert($("#getinternet0140").val());
           		$("#Packaggroupid").val("");
           		return;
           }
           var restimtype = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&tablename=monthfee_group&cloum=GTYPE,CYCLE&key=gid="+Packaggroupid);
           if(restimtype[0][0]==undefined||restimtype[0][0]==""){return false;}
			var resno = getsysdate(restimtype[0][0]);//通过获取时间类型来得到对应的时间
			$("#TCStarttimes").val(resno);
			if(restimtype[0][0]=="1"||restimtype[0][0]=="0"||restimtype[0][0]==1||restimtype[0][0]==0){
				$("#TCStarttimes").attr("disabled","disabled");
			}else{
				$("#TCStarttimes").removeAttr("disabled");
			}
			$("#cycle").val(restimtype[0][1]);
           if(Packaggroupid==""){Packaggroupid=-1000;}
           var res = fetchMultiArrayValue("phonelnstalled.queryPackagetype_monthfee",6,"&gid="+Packaggroupid);
           $("#Packagetypes").empty();           
           if(res[0]==undefined || res[0][0]==undefined)
           {
           		return false;
           }           
           var querysel="";
		   for(var i=0;i<res.length;i++)
		   {
		       querysel +="<tr onClick=\"getBYfeetr('"+res[i][0]+"','"+res[i][1]+"','"+restimtype[0][1]+"','"+res[i][2]+"');\" id=\""+res[i][0]+"\"><td>";
         	   querysel +="☞"+res[i][0];
    		   querysel +="</td></tr>";
		   }
		   $("#Packagetypes").append(querysel);
        }  
        
        /********
       	*从数据库获取当前时间
        *@param;
       	*@return;
        *********/ 
        function getsysdate(key){
        	var res = fetchSingleValue("dbsql_phone.getsysdate",6,"&timetype="+key);
        	if(res==undefined){res="";}
        	return res;
        } 
        
        /*******
        *单击选中一行包月套餐
        *@param：key包月套餐
        *@return
        ********/
        function getBYfeetr(key,time,cycle,endtime){
			$("#pkg_rateStr").val("");	
        	$("#Packagetypeshidden").val(key);        	 
        	$("#TCEndtimes").val(time);
        	if(cycle=="1"){
        		$("#TCEndtimes").val(endtime);
        		$("#TCEndtimes,#TCStarttimes").attr("disabled","disabled");
        	}else{
        		$("#TCEndtimes,#TCStarttimes").removeAttr("disabled");
        	}
        	$("#Packagetypes tr").css('background-color','#f7f7f7');
		    document.getElementById(key).style.background='#0080FF';
        } 
        
        /********
       	*包月套餐保存临时表
        *@param;
       	*@return;
        *********/ 
        function Bytc_Saves()
        {
        	var Packaggroupid = $("#Packaggroupid").val();
        	if(Packaggroupid==""){
        		//alert("请选择套餐组！");
        		alert($("#getinternet0053").val());
        		$("#Packaggroupid").select();
        		$("#Packaggroupid").focus();
        		return false;
        	}
        	var tctype = $("#Packagetypeshidden").val();
        	if(tctype=="" || tctype==undefined)
        	{
        		//alert("请选择包月套餐类型");
        		alert($("#getinternet0054").val());
        		return false;
        	}
        	else
        	{
        		//alert(/^\d{4}-\d{2}-\d{2}$/.test($("#TCStarttime").val()));
        		var dh = $("#Dh_yhdang").val();
        		if(dh=="")
        		{
        			//alert('请先获取空号!'); //add by chenlang
        			alert($("#getnullphone").val());
        			$("#Packagetypes").val('');
        			$("#Dh_yhdang").focus();
        			return false;
        		}
        		
        		//验证所添加套餐类型是否已存在
        		
        		var existedcheck=fetchSingleValue("phonelnstalled.checkbytcexisteds",6,"&FeeType="+tsd.encodeURIComponent(tctype)+"&dh="+dh);
        		existedcheck = parseInt(existedcheck);
        		if(existedcheck!=0)
        		{
        			//alert("包月套餐\"" + tctype + "\"已经存在，不能重复添加");
        			alert($("#getinternet0055").val() + tctype + $("#getinternet0014").val());
        			return false;
        		}
        		var startdate = $("#TCStarttimes").val();
        		var enddate = $("#TCEndtimes").val();
        		
        		//检测时间
        		//var timecheck=fetchSingleValue("phonelnstalled.getstartendtime",6,"&starttime="+startdate+"&endtime="+enddate);
        		//timecheck = parseInt(timecheck);
        		//if(isNaN(timecheck) || timecheck<=0)
        		//{
        		//	alert("终止月份必须大于起始月份");
        		//	return false;
        		//}
        		
        		//取费用名称和月数
        		var res = fetchMultiArrayValue("phonelnstalled.queryPackagetypeByWheres",6,"&FeeType="+tsd.encodeURIComponent(tctype));
        		
        		if(res[0]==undefined || res[0][0]==undefined)
        		{
        			//alert('出现意外情况，请马上联系系统管理员!');
        			alert($("#getinternet0056").val());
        			return false;
        		}

        		var Fee_Types = res[0][0];
        		var resmonth = res[0][1];        	
        		var startmonth=startdate.substr(0,7).replace("-","");
        		var endmonth=enddate.substr(0,7).replace("-","");        		        		
        		var userid = $("#userid").val();      
				var pkg_rateStr=$("#pkg_rateStr").val()
        		var params = "";
        		params += "&Dh="+dh;
        		params += "&FeeType=" + tsd.encodeURIComponent(Fee_Types);
        		params += "&mon="+resmonth;
        		params += "&StartDate="+$("#TCStarttimes").val();
        		params += "&EndDate="+$("#TCEndtimes").val();        		
        		params += "&userid="+$("#userloginid").val();    
				params += "&Pkg_RateStr="+pkg_rateStr;
        		var insertRes = executeNoQuery("phonelnstalled.addbytcs",6,params);     
        		if(insertRes=="false" || insertRes==false){
        			//alert("添加数据失败");
        			alert($("#getinternet0017").val());
        		}
        		$("#TCEndtime").val("");
        		$("#Packagetypeshidden").val("");
				$("#pkg_rateStr").val("");
        	    $("#Packagetypes tr").css('background-color','#f7f7f7');
        		Bytc_Refreshs('');
        		$("#Packagetypes").val("2999-12-31");
        	}
        }   
        
        /********
       	*刷新包月套餐数据
        *@param;
       	*@return;
        *********/ 
        function Bytc_Refreshs(key)
        {
			$("#bytctabs tr:has('td')").remove();
			$("#bytctabs tr:empty").remove();			
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
			var res = fetchMultiArrayValue("phonelnstalled.queryPackagetypeXXs",6,"&dh="+phone);	
			if(res[0]==undefined || res[0][0]==undefined)
			{
				res.length=0;
			}			
			var count = res.length;
			var sum=0;
			var ify = "";			
			for(var i=0;i<count;i++)
			{
				ify += "<tr>";
				ify += "<td width=\"20\"><center>";
				ify += "<input type=\"checkbox\" id=\"v_bytctab_checks\"" + i + " />";
				ify += "</center></td>";
				ify += "<td width=\"250\"><center>";
				ify += res[i][1];
				ify += "</center></td>";
				ify += "<td width=\"130\"><center>";
				ify += res[i][2];
				ify += "</center></td>";
				ify += "<td width=\"130\"><center>";
				ify += res[i][3];
				ify += "</center></td>";
				ify += "<tr>";
				sum++;	
			}
			for(var n=0;n<=4-sum;n++){
				ify += "<tr>";
				ify += "<td width=\"20\"><center>";
				ify += ".";
				ify += "</center></td>";
				ify += "<td width=\"250\"><center>";
				ify += "……";
				ify += "</center></td>";
				ify += "<td width=\"130\"><center>";
				ify += "……";
				ify += "</center></td>";
				ify += "<td width=\"130\"><center>";
				ify += "……";
				ify += "</center></td>";
				ify += "<tr>";
			}
			sum=0;
			$("#bytctabs").append(ify);
			$("#bytctab_checkalls").removeAttr("checked");
        }               
        
        /********
       	*包月套餐删除
        *@param;
       	*@return;
        *********/ 
        function Bytc_Dels()
        {
        	var checkedBytc = $("input[id^='v_bytctab_checks'][checked]");
        	var count = $(checkedBytc).size();
        	
        	if(count<1)
        	{
        		//alert("请选择要删除和套餐项");
        		alert($("#getinternet0018").val());
        		return false;
        	}
        	var dh = $("#Dh_yhdang").val();
        	var tclx = "";
        	
        	var result = true;
        	var resultTmp = false;
        	
        	for(var i=0;i<count;i++)
        	{
        		tclx = $(checkedBytc[i]).parent().parent().next().text();
        	
        		resultTmp = executeNoQuery("phonelnstalled.delbytcs",6,"&FeeType="+tsd.encodeURIComponent(tclx)+"&dh="+dh);
        		
        		if(resultTmp=="false" || resultTmp==false)
        		{
        			//alert("删除套餐失败");
        			alert($("#getinternet0020").val());
        			result = false;
        		}
        	}
        	/*        	
        	if(result)
        	{
        		alert("删除套餐成功");
        	}
        	else
        	{
        		alert("删除套餐失败");
        	}*/
        	$("#Packagetypeshidden").val("");
        	$("#Packagetypes tr").css('background-color','#f7f7f7');
        	Bytc_Refreshs('');
        }        
        
        /********
        *选中所有后悔套餐 
        *@param;
       	*@return;
        ********/
        function Bytc_CheckALL(key)
        {        	
        	if($("#bytctab_checkalls").attr("checked"))
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
        
        /********
       	*默认加载固话杂费跟包月费显示框
        *@param;
       	*@return;
        *********/
        function gettable(){
        	var ify="";
        	var jfy="";        	
        	//包月费
        	$("#bytctabs").empty();
        	for(var n=0;n<4;n++){ify += "<tr>";
						ify += "<td width=\"10\"><center>";
						ify += ".";
						ify += "</center></td>";
						ify += "<td width=\"170\"><center>";
						ify += "……";
						ify += "</center></td>";
						ify += "<td width=\"105\"><center>";
						ify += "……";
						ify += "</center></td>";
						ify += "<td width=\"100\"><center>";
						ify += "……";
						ify += "</center></td>";
						ify += "<td width=\"150\"><center>";
						ify += "……";
						ify += "</center></td>";
						ify += "<td width=\"140\"><center>";
						ify += "……";
						ify += "</center></td>";
						ify += "<td width=\"140\"><center>";
						ify += "……";
						ify += "</center></td>";
						ify += "<tr>";
			}
			$("#bytctabs").append(ify);
			$("#bytctab_checkalls").removeAttr("checked");
			//固定费
			$("#dhzftab").empty();
			for(var i=0;i<=5;i++){
				jfy += "<tr>";
									jfy += "<td width=\"20\"><center>";
									jfy += ".";
									jfy += "</center></td>";
									jfy += "<td width=\"200\"><center>";
									jfy += "……";
									jfy += "</center></td>";								
									jfy += "<td width=\"60\"><center>";
									jfy += "……";
									jfy += "</center></td>";
									jfy += "<td width=\"100\"><center>";
									jfy += "……";
									jfy += "</center></td>";
									jfy += "<td width=\"100\"><center>";
									jfy += "……";
									jfy += "</center></td>";
									/*jfy += "<td width=\"135\"><center>";
									jfy += "……";
									jfy += "</center></td>";*/
									jfy += "<tr>";
			}
			$("#dhzftab").append(jfy);
			$("#dhzftab tr:empty").remove();					
        }  
        
        
        /***********************
			* 是否大客户代收,Y为是，N为否
			* @param;
			* @return;
		    *************************/
			function hthCollection(){				
				$("#Bz2").empty();
				var strbz2="<option value=\"\">--"+$("#getinternet0365").val()+"--</option>"; 
				var res = fetchMultiArrayValue("dbsql_phone.queryphoneconfig",6,"&configtype=hthCollection");
				if(res[0]==undefined || res[0][0]==undefined)
        		{
        			return false;
        		}
        		for(var i=0;i<res.length;i++){
        			strbz2+="<option value="+res[i][0]+">"+res[i][1]+"</option>";
        		}
				$("#Bz2").append(strbz2);
			} 
			
			
								           