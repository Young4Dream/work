		
		/*****************************************************************
 		* name: phoneInstalled.js
		* author: wenxuming
 		* version: 1.0, 2010-11-05
 		* description: 开户跟修改属性专用js
 		* modify:   
 		*****************************************************************/
 		/////////////////////////////////////////////////////////////////////////////////////////////////////////////// 						  		  
			//页面加载设置；在phoneinstalled.jsp中调用
			function lodingset(){
				$("#getphone").select();
				$("#getphone").focus();
				var userareaid = $("#userareaid").val();
				$("#seluserarea").val(userareaid);
				$("#getphone").keydown(function(event){
					if(event.keyCode==13)
					{
						$("#getKonghao").click();
					}
				});
				c_p_initial_dateType();//加载日期控件
				il18nDWDJ();
				$("#ghBasicInfo td:even").attr("align","right");
				$("#tablehthdang td:even").attr("align","right");
				$("#tableyhdang td:even").attr("align","right");
				$("#dhzfform td:even").attr("align","right");
				$("#bytcform td:even").attr("align","right");
    	        $("#ghBasicInfo :text").css("margin-left","5px");
    	        $("#tablehthdang :text").attr("disabled","disabled");
    	        $("#tablehthdang select").attr("disabled","disabled");
    	        $("#tableyhdang :text").attr("disabled","disabled");
    	        $("#tableyhdang select").attr("disabled","disabled");
	    	    if(getaddressEditer()=="NO"){
				    $("#Yhdz_yhdang").focus(function(){c_p_address_fun();});
					$("#Yhdz_yhdang").keyup(function(){notecheck();});
				}
				//权限控制选择合同号是否可选
				if($("#selecththright").val()=='true'){
					$("#setselectHth").removeAttr("disabled");
				}else{
					$("#setselectHth").attr("disabled","disabled");
				}
				//$("#usertype").val("自费");
				//$("#Yhlb_hthdang").val("自费");
				$("#usertype").val($("#getinternet0383").val());
				$("#Yhlb_hthdang").val($("#getinternet0383").val());
				getyhxzstr('p_setup');
				getfufeitype();
				$("#Dhlx").change(function(){
					$("#Dh_yhdang,#getphone").val("");
				});
			}
			
			/********
			*选择开户类型为电话还是合同号
			********/
			function selectinserttype(){
				var str = $("#selectinserttype").val();
				ClearTmpData();//删除临时表数据
				if(str=='1'){
					//$("#phone_querynumber").show();
					$("#dhlxname").show();
					$("#Dhlx").show();
					$("#dhnumber").show();
					$("#getphone").show();
					$("#getKonghao").show();
					
					$("#setHthvalue").show();
					$("#div_content").show();
					$("#setselectHth").show();
					$("#setDJHth").show();
					//$("#Dhlx").val("固定电话");
					$("#Dhlx").val($("#getinternet0363").val());					
					//$("#usertype").val("自费");
					$("#usertype").val($("#getinternet0383").val());
					$("#Yhlb_hthdang").val($("#usertype").val()==""?"":$("#usertype option:selected").text());
				}else{
					$("#dhlxname").hide();
					$("#Dhlx").hide();
					$("#dhnumber").hide();
					$("#getphone").hide();
					$("#getKonghao").hide();
										
					$("#setHthvalue").hide();
					$("#div_content").hide();
					$("#setselectHth").hide();
					$("#setDJHth").hide();					
					//$("#Dhlx").val("固定电话");
					$("#Dhlx").val($("#getinternet0363").val());	
					//$("#usertype").val("自费");
					$("#usertype").val($("#getinternet0383").val());
					$("#Yhlb_hthdang").val($("#usertype").val()==""?"":$("#usertype option:selected").text());
				}
					$("#phone_querynumber select").val("");
					$("#phone_querynumber :text").val("");
					$("#setHthvalue select").val("");
					$("#setHthvalue :text").val("");
					$("#div_content select").val("");
					$("#div_content :text").val("");
					$("#inputtext select").val("");
					$("#inputtext :text").val("");
					$("#seththtitle select").val("");
					$("#seththtitle :text").val("");
					//$("#Dhlx").val("固定电话");
					$("#Dhlx").val($("#getinternet0363").val());					
					//$("#usertype").val("自费");
					$("#usertype").val($("#getinternet0383").val());
			}
			
			//选择用户类别时清空合同号信息包括解除只读
			function removenullhthcontent(){			 
				var dh = $("#Dh_yhdang").val();
				var str = $("#selectinserttype").val();		
				$("#Bz2").val('N');	//默认大客户代收为否
				$("#setHthvalue").removeAttr("disabled");
				$("#tablehthdang select").removeAttr("disabled");
				$("#tablehthdang :text").removeAttr("disabled");
				$("#geththsbm select").removeAttr("disabled");
				$("#Hth_hthdang").attr("disabled","disabled");
				$("#Dh_hthdang").attr("disabled","disabled");
				//if($("#usertype option:selected").text()!="公费"){
				if($("#usertype option:selected").text()!=$("#getinternet0384").val()){
					$("#sBm1").val("");
					$("#sBm2").val("");
					$("#sBm3").val("");
					$("#sBm4").val("");
					$("#Bm1_yhdang").val("");
					$("#Bm2_yhdang").val("");
        			$("#Bm3_yhdang").val("");
        			$("#Bm4_yhdang").val("");
				}
				$("#tablehthdang select").val("");
				$("#tablehthdang :text").val("");
				$("#Dh_hthdang").val($("#Dh_yhdang").val());
				$("#Yhlb_hthdang").val($("#usertype").val()==""?"":$("#usertype option:selected").text());
				$("#Yhlb_hthdang").attr("disabled","disabled");
				getyhxzstr('p_setup');
			}					

			/*******
			**点击输入合同号按钮事件
			********/
			function InputHth(){
				var usertype = $("#usertype").val();
				var key = $("#businesstype").val();
				if(key=='p_movewithoutarea'||key=='p_changeuser'){
	        		//电话号码
		        	var cphonenum = $("#Dh_yhdang").val();
		        	if(cphonenum==undefined || cphonenum=="")
		        	{
		        		//alert("请查询一个电话用户！");
		        		alert($("#getinternet0140").val());
		        		$("#ghSearchBox").select();
		        		$("#ghSearchBox").focus();
		        		return false;
		        	}
	        	}
	        	//电话号码
	        	var cphonenum = $("#Dh_yhdang").val();
	        	if(((cphonenum==undefined || cphonenum=="")&&($("#selectinserttype").val()=='1'&&key=="p_setup"))||(key=="p_movewithoutarea"&&$("#chooseKH").val().replace(/(^\s*)|(\s*$)/g,"")==""))
	        	{
	        		//alert("请先选择一个电话空号");
	        		alert($("#getnullphone").val());
	        		$("#getphone").select();
	        		$("#getphone").focus();
	        		return;
	        	} 	
	        	if(usertype==""){
	        		//alert("请选择用户类别");
	        		alert($("#getselectyhlb").val());
	        		return false;
	        	}
	        	//if($("#usertype option:selected").text()=="公费"&&$("#sBm1").val()==""){
	        	if($("#usertype option:selected").text()==$("#getinternet0384").val()&&$("#sBm1").val()==""){
	        		//alert("公费用户请选择一级部门！");
	        		alert($("#getinternet0001").val());
	        		$("#Bm1").select();
	        		$("#Bm1").focus();
	        		return false;
	        	}
	        	$("#bmhthvalue").val("");
	        	$("#inpuththvalue").val("");	        	
	        	if($("#sBm1").val()==""){
	        		$("#bmhthvalue").hide();
	        		$("#ztag").hide();	
	        	}else if($("#sBm2").val()!=""&&$("#sBm1").val()!=""){
	        		$("#bmhthvalue").show();
	        		$("#ztag").show();
	        		var res = fetchMultiArrayValue("dbsql_phone.addbmhth",6,"&bm1="+tsd.encodeURIComponent($("#sBm1").val()));
	        		if(res[0][0]!=undefined&&res[0][0]!=""){
	        			var yhlbkey = fetchSingleValue("dbsql_phone.getyhlbkey",6,"&yhlbid="+$("#usertype").val());
					   if(yhlbkey==undefined){yhlbkey='';}
	        			var v_zb = $("#area").val().substring(0,1);
	        			$("#bmhthvalue").val(res[0][0]);
	        			$("#ztag").val(v_zb+yhlbkey);
	        		}else{
	        			$("#bmhthvalue").val("");
	        		}
	        	}else{
	        		$("#bmhthvalue").val("");
	        		$("#bmhthvalue").hide();
	        		$("#ztag").hide();
	        	}
	        	$("#inpuththvalue").select();
	        	$("#inpuththvalue").focus();	        	
	        	//autoBlockForm('inputhth_mb',50,'close',"#ffffff",false);//弹出输入合同号面板
	        	autoBlockFormAndSetWH('inputhth_mb',150,250,'close',"#ffffff",false)
			}

			//输入合同号保存时调用函数
			function saveinputHTH(){
				var key = $("#businesstype").val();
				var iinputhth=""
				var bmhthvalueto=$("#bmhthvalue").val().replace(/(^\s*)|(\s*$)/g,"");
				if(bmhthvalueto==""){
					iinputhth = $("#inpuththvalue").val().replace(/(^\s*)|(\s*$)/g,"");
				}else{					
					iinputhth = $("#ztag").val().replace(/(^\s*)|(\s*$)/g,"")+$("#bmhthvalue").val().replace(/(^\s*)|(\s*$)/g,"")+$("#inpuththvalue").val().replace(/(^\s*)|(\s*$)/g,"");
				}
				if($("#inpuththvalue").val().replace(/(^\s*)|(\s*$)/g,"")==""){
					//alert("请输入合同号！");
					alert($("#getinternet0002").val());
					$("#inpuththvalue").select();
					$("#inpuththvalue").focus();
					return false;
				}
				var re=/^[A-Za-z0-9]*$/;   				
				 if(re.test(iinputhth)==false){
				    //alert("合同号只能输入字母和数字!");
				    alert($("#getinternet0003").val());
				    return false;
				 }
				 
				var res = fetchMultiArrayValue("dbsql_phone.queryhthdanghth",6,"&hth="+tsd.encodeURIComponent(iinputhth));
				if(res[0][0]!=0){
					//alert("对不起，合同号"+iinputhth+"已在合同号档案中存在，请重新输入！");
					alert($("#getinternet0004").val()+iinputhth+$("#getinternet0005").val());					
					$("#hth").val("");
					$("#Hth_hthdang").val("");
					$("#Hth_yhdang").val("");
					return false;
				}
				$("#tablehthdang select").val("");
				$("#tablehthdang :text").val("");
				var resultYZHTH = fetchMultiPValue("Phone.ywsl_check_hth",6,'&Hth='+iinputhth); 
        		if(resultYZHTH[0][0]!=undefined&&resultYZHTH!=""){
        				if(resultYZHTH[0][0]==1){
        						alert("合同号：["+iinputhth+"]在表["+resultYZHTH[0][1]+"]存在，请重新生成或输入!");
        						return;
        					}
        			}	
				if(key=="p_movewithoutarea"||key=='p_changeuser'||key=='p_hthchangename'||key=='p_acctsetup'){
					geththedite();//businesspublic.js中  自动加载显示框合同号可编辑的显示框
					getyhxzstr("p_movewithoutarea");
					getbusinessDefault('Y','N');//设置默认值
					//如果是其他业务输入合同号时将根据判断获取原来合同号已有信息，为了方便输入重复信息
	        		geththselect_sc($("#usertype option:selected").text(),$("#Yhlb_hthdang").val(),iinputhth);
				}else if(key=="p_setup"){
					$("#Hth_yhdang").val(iinputhth);
					getyhxzstr("p_setup");
					getbusinessDefault('Y','Y');//设置默认值
					getPowertrue();
					queryFeename();//加载一次性费用						
				}
				$("#tablehthdang select").removeAttr("disabled");
				$("#tablehthdang :text").removeAttr("disabled");
				$("#setHthvalue").removeAttr("disabled");
				$("#geththsbm").removeAttr("disabled");										
				$("#hth").val(iinputhth);
				$("#Hth_hthdang").val(iinputhth);				
				$("#Yhlb_hthdang").val($("#usertype option:selected").text());
				$("#Dh_hthdang").val($("#Dh_yhdang").val());									
				$("#Dh_hthdang").attr("disabled","disabled");
				$("#Hth_hthdang").attr("disabled","disabled");
				$("#Yhlb_hthdang").attr("disabled","disabled");	
				deleteHthYZ($("#userid").val(),iinputhth);					
				setTimeout($.unblockUI,15);
			}				
			
			/*******
        	*弹出空号查询框
        	*@param;
       	 	*@return;
        	********/
			function c_p_konghaoDialog()
			{				
				tsd.QualifiedVal=true;
				var param = "";
				param += "Dhlx=";
				param += tsd.encodeURIComponent($("#Dhlx").val());
				param += "&DhHead=";
				param += tsd.encodeURIComponent($("#getphone").val());
				param += "&imenuid=";
				param += tsd.encodeURIComponent($("#imenuid").val());
				if(tsd.Qualified()==false){return false;}
				window.showModalDialog("mainServlet.html?pagename=telephone/business/Two.jsp?"+param+"&getnullarea="+$('#konghaoarearight').val(),window,"dialogWidth:500px; dialogHeight:450px; center:yes; scroll:no");
			}

			/*******
        	*选取空号后回调函数
        	*@param;
       	 	*@return;
        	********/
			function c_p_feedBack(phoneNum,mokuaiju,jhj_id,ywarea,selbz)
			{
				var result = fetchMultiPValue("PhoneDH.ifCanSouLi",6,"&OperID=" + tsd.encodeURIComponent($("#userid").val()) + "&Ywlx="+tsd.encodeURIComponent("p_setup")+"&NowYwArea="+tsd.encodeURIComponent($("#area").val())+"&Dh="+phoneNum+"&Hth="+$("#Hth_hthdang").val());
				if(result[0]!=undefined && result[0][0]!="")
				{
					alert(result[0][1]);
					return false;
				}
				getphonefeename(jhj_id);//根据选取空号表中的交换机ID来查询电话杂费
				//$("#ghBasicInfo select").not(":disabled").val("");
				//顶部电话输入
				$("#getphone").val(phoneNum);
				//取空号时电话
				$("#Dh_yhdang").val(phoneNum);
				$("#Dh_hthdang").val(phoneNum);			
				$("#SwitchNumber").val(jhj_id);	//Jhj_ID_yhdang		
				var querypassword = phoneNum.substring(1,7);
				$("#Mima_yhdang").val(querypassword);
				$("#toMima_yhdang").val(querypassword);					
				//newadd selbz
				$("#selbz").val(selbz);//将电话通信站标识存入隐藏于
				$("#mokuaiju").val(mokuaiju);//将电话模块局存入隐藏于
				$("#MokuaiJu_yhdang").val(mokuaiju);
				$("#Mima_yhdang").val(querypassword); 
				if($("#userareaid").val()!="null"&&$("#userareaid").val()!=undefined){
					//根据系统表获取项目名称来处理不同的操作
					var ProjectType = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=tvalues&tablename=tsd_ini&key=tsection='system' and tident='customer'");
					if(ProjectType=="zhongyuanyoutian"){
						$("#YwArea_yhdang").val($("#userareaid").val());
					}else if(ProjectType=="yimei"){
						$("#YwArea_yhdang").val($("#area").val());
					}else{
						$("#YwArea_yhdang").val($("#userareaid").val());
					}
				}
				$("#Bz3_yhdang").val($("#area").val());
				$("#StartDate_yhdang").val('2999-12-31');
				$("#EndDate_yhdang").val('2999-12-31');
				var userid = $('#userid').val();
				$("#tablehthdang select").removeAttr("disabled");
				$("#tablehthdang :text").removeAttr("disabled");
				$("#tableyhdang select").removeAttr("disabled");
				$("#tableyhdang :text").removeAttr("disabled");		
				$("#Dh_yhdang").attr("disabled","disabled");
				$("#ZFEndday").removeAttr("disabled");
				$("#ZFStartday").removeAttr("disabled");
				$("#TCEndtime").removeAttr("disabled");
				$("#TCStarttime").removeAttr("disabled");
				$("#TCEndtimes").removeAttr("disabled");
				$("#TCStarttimes").removeAttr("disabled");
				$("#StartDate_yhdang").attr("disabled","disabled");	
				$("#EndDate_yhdang").attr("disabled","disabled");
				$("#Reg_Date").attr("disabled","disabled");
				$("#Hth_hthdang").attr("disabled","disabled");
				//$("#Dh_yhdang").attr("disabled","disabled");
				$("#Hth_yhdang").attr("disabled","disabled");
				$("#Dh_hthdang").attr("disabled","disabled");				
				//$("#MokuaiJu_yhdang").attr("disabled","disabled");
				$("#Yhlb_hthdang").attr("disabled","disabled");
				$("#Tjbz_yhdang").val('K');								
				gettable();
				$("#Tjbz_yhdang").attr("disabled","disabled");
				//$("#UserType_yhdang").attr("disabled","disabled");
				
				//根据配置权限时刻可以对计费起始，计费终止，装机日期进行可编辑
				if($("#statrtimeright").val()=="false"){
					$("#StartDate_yhdang").attr("disabled","disabled");
				}else{
					$("#StartDate_yhdang").removeAttr("disabled");
				}
				if($("#stoptimeright").val()=="false"){
					$("#EndDate_yhdang").attr("disabled","disabled");
				}else{
					$("#EndDate_yhdang").removeAttr("disabled");
				}
				if($("#zjtimeright").val()=="false"){
					$("#Reg_Date_yhdang").attr("disabled","disabled");
				}else{
					$("#Reg_Date_yhdang").removeAttr("disabled");
				}
				getPowertrue();//获取权限值进行判断
				getZJtime();
				//getdisabled();
				queryFeename();//加载一次性费用				
				getfeename();
			}
			
			/********
			**获取页面默认值；通过系统配置表别名表DefaultExpression字段来配置
			**********/
			function getbusinessDefault(hthkey,phonekey){
				var languageType = $("#languageType").val();
				var Dathth = loadData_phoneinstalled("Hthdang",languageType,2);
				var Datyhdang = loadData_phoneinstalled("Yhdang",languageType,2);
				//是否对合同号信息设置默认值				
				if(hthkey=="Y"){
					for(var i=0;i<Dathth.FieldName.length;i++){
						if(Dathth.DefaultExpression[i]==""||Dathth.DefaultExpression[i]=="null"){
						
						}else{
							$("#"+Dathth.FieldName[i]+"_hthdang").val(Dathth.DefaultExpression[i]);
						}	
					}
				}
				//是否对电话信息进行默认值
				if(phonekey=='Y'){
					for(var i=0;i<Datyhdang.FieldName.length;i++){
						if(Datyhdang.DefaultExpression[i]==""||Datyhdang.DefaultExpression[i]=="null"){
						
						}else{
							$("#"+Datyhdang.FieldName[i]+"_yhdang").val(Datyhdang.DefaultExpression[i]);
						}					
					}
				}
				if($("#sBm2").val()!=""){
					$("#Bz2_hthdang").val('Y');	//默认大客户代收为是
					$("#Bz2_hthdang").removeAttr("disabled");
				}else{
					$("#Bz2_hthdang").val('N');	//默认大客户代收为否
					$("#Bz2_hthdang").attr("disabled","disabled");
					var Bz2right = $("#Bz2right").val();
					if(Bz2right=='true'){
						$("#Bz2_hthdang").removeAttr("disabled");
					}
				}
			}
			

			/*******
        	*日期类型控件，添加编辑框的日期控件显示
        	*@param;
       	 	*@return;
        	********/
			function c_p_initial_dateType()
			{
				///电话杂费  起始月
				$("#ZFStartmonth").focus(function(){
					WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM',alwaysUseStartDate:true});
				});
				///电话杂费  起始日
				$("#ZFStartday").focus(function(){
					WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
				});
				///电话杂费  终止月
				$("#ZFEndmonth").focus(function(){
					WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM',alwaysUseStartDate:true});
				});
				///电话杂费  终止日
				$("#ZFEndday").focus(function(){
					WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
				});
				
				///包月套餐设置  起始月
				$("#TCStarttime").focus(function(){
					WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
				});
				///包月套餐设置   终止月
				$("#TCEndtime").focus(function(){
					WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
				});
				///合同号杂费表  起始月
				$("#c_p_hthzf_qsy").focus(function(){
					WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM',alwaysUseStartDate:true});
				});
				///合同号杂费表   终止月
				$("#c_p_hthzf_zzy").focus(function(){
					WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM',alwaysUseStartDate:true});
				});
				$("#TCStarttimes").focus(function(){
					WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
				});
				$("#TCEndtimes").focus(function(){
					WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
				});				
				$("#StartDate_yhdang").focus(function(){
					WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
				});
				$("#EndDate_yhdang").focus(function(){
					WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
				});
				$("#Reg_Date_yhdang").focus(function(){
					WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
				});
			}
		  	
	    /********
        *查询生成该电话固话费用项信息，以表格的形式显示
        *@param;
       	*@return;
      ********/
		  function addspeediFeeType(key)
		  {
		  	   var phone = $("#Dh_yhdang").val();
		  	   if(key!=""){
		  	   	  phone=key;
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
									ify += "<td  width=\"10\"><center>";
									ify += "<input type=\"checkbox\" id=\"v_dhzftab_check\"" + id +  "\"  />";
									ify += "</center></td>";
									ify += "<td width=\"90\"><center>";
									ify += feename;
									ify += "</center></td>";
									ify += "<td width=\"200\"><center>";
									ify += feetype;
									ify += "</center></td>";
									ify += "<td style='display:none;'><center>";
									ify += feecode;
									ify += "</center></td>";
									ify += "<td width=\"60\"><center>";
									ify += Price;
									ify += "</center></td>";
									ify += "<td width=\"100\"><center>";
									ify += StartDate;
									ify += "</center></td>";
									ify += "<td width=\"100\"><center>";
									ify += EndDate;
									ify += "</center></td>";
									ify += "<td width=\"73\" style=\"display:none;\"><center>";
									ify += devnum;
									ify += "</center></td>";
									ify += "<td width=\"73\" style=\"display:none;\"><center>";
									ify += devlength;
									ify += "</center></td>";
									ify += "<tr>";
									count += 1;
									}
								});
								/*
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
									ify += "<td width=\"73\"><center>";
									ify += "……";
									ify += "</center></td>";
									ify += "<td width=\"73\"><center>";
									ify += "……";
									ify += "</center></td>";
									ify += "<tr>";
								}*/
								count=0;
								$("#dhzftab").append(ify);
								$("#dhzftab tr:empty").remove();
							}
						});					
				$("#dhzftab_checkall").removeAttr("checked");
		   }
		   
		   /********
        *查询生成该电话合同号固话费用项信息，以表格的形式显示
        *@param;
       	*@return;
      ********/
		  function addspeediFeeType_hth(key)
		  {		 	
		  	 var hth = $("#Hth_yhdang").val();
		  	   if(key!=""){
		  	   	  hth=key;
		  	   }	   
			   if(hth=="")
			   {
					hth='0000000000';
			   }
			   var hthfy="";
			   var count=0;
		       var urlstr=tsd.buildParams({
		       							packgname:'service',//java包
							 					clsname:'ExecuteSql',//类名
							 					method:'exeSqlData',//方法名
							 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
							 					tsdcf:'business',//指向配置文件名称
							 					tsdoper:'query',//操作类型 
							 					datatype:'xmlattr',
							 					tsdpk:'phonelnstalled.queryphoneFYX_hth'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							 				});		 						
				$.ajax({
						url:'mainServlet.html?'+urlstr+"&hth="+hth,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
						      hthfy="";
						      $("#hthzftab tr:has('td')").remove();					           
									$(xml).find('row').each(function(){
									var id = $(this).attr("id");
									var feetype = $(this).attr("feetype");
									var feecode = $(this).attr("feecode");								
									var Price = $(this).attr("price");
									var StartDate = $(this).attr("startmonth");
									var EndDate = $(this).attr("endmonth");
									var feenum = $(this).attr("feenum");
									if(id!=undefined){	
									hthfy += "<tr>";
									hthfy += "<td><center>";
									hthfy += "<input type=\"checkbox\" id=\"v_hthzftab_check\"" + id +  "\"  />";
									hthfy += "</center></td>";
									hthfy += "<td width=\"200\"><center>";
									hthfy += $(this).attr("feetype");
									hthfy += "</center></td>";
									hthfy += "<td style='display:none;'><center>";
									hthfy += $(this).attr("feecode");
									hthfy += "</center></td>";
									hthfy += "<td width=\"60\"><center>";
									hthfy += $(this).attr("price");
									hthfy += "</center></td>";
									hthfy += "<td width=\"100\"><center>";
									hthfy += $(this).attr("startmonth");
									hthfy += "</center></td>";
									hthfy += "<td width=\"100\"><center>";
									hthfy += $(this).attr("endmonth");
									hthfy += "</center></td>";
									hthfy += "<td width=\"135\"><center>";
									hthfy += $(this).attr("feenum");
									hthfy += "</center></td>";
									hthfy += "<tr>";
									count += 1;
									}
								});
								for(var i=0;i<=5-count;i++){
									hthfy += "<tr>";
									hthfy += "<td width=\"20\"><center>";
									hthfy += ".";
									hthfy += "</center></td>";
									hthfy += "<td width=\"200\"><center>";
									hthfy += "……";
									hthfy += "</center></td>";								
									hthfy += "<td width=\"60\"><center>";
									hthfy += "……";
									hthfy += "</center></td>";
									hthfy += "<td width=\"110\"><center>";
									hthfy += "……";
									hthfy += "</center></td>";
									hthfy += "<td width=\"110\"><center>";
									hthfy += "……";
									hthfy += "</center></td>";
									hthfy += "<td width=\"135\"><center>";
									hthfy += "……";
									hthfy += "</center></td>";
									hthfy += "<tr>";
								}
								count=0;
								$("#hthzftab").append(hthfy);
								$("#hthzftab tr:empty").remove();
							}
						});					
				$("#hthzftab_checkall").removeAttr("checked");
		   }
		   
		/********
       	*默认加载固话杂费跟包月费显示框
        *@param;
       	*@return;
        *********/
        function gettable(){
        	var ify="";
        	var jfy="";
        	var nfy="";
        	var hfy="";
        	//包月费
        	$("#bytctabs").empty();
        	for(var n=0;n<=5;n++){
				ify += "<tr>";
				ify += "<td width=\"20\"><center>";
				ify += ".";
				ify += "</center></td>";
				ify += "<td width=\"280\"><center>";
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
			$("#bytctabs").append(ify);
			$("#bytctab_checkalls").removeAttr("checked");
			//固定费
			$("#dhzftab").empty();
			/*for(var i=0;i<=5;i++){
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
									jfy += "<td width=\"73\"><center>";
									jfy += "……";
									jfy += "</center></td>";
									jfy += "<td width=\"73\"><center>";
									jfy += "……";
									jfy += "</center></td>";
									jfy += "<tr>";
			}
			$("#dhzftab").append(jfy);
			$("#dhzftab tr:empty").remove();*/
	
			//合同号月租
			$("#hthzftab").empty();
			for(var i=0;i<=5;i++){
				hfy += "<tr>";
									hfy += "<td width=\"20\"><center>";
									hfy += ".";
									hfy += "</center></td>";
									hfy += "<td width=\"200\"><center>";
									hfy += "……";
									hfy += "</center></td>";								
									hfy += "<td width=\"60\"><center>";
									hfy += "……";
									hfy += "</center></td>";
									hfy += "<td width=\"100\"><center>";
									hfy += "……";
									hfy += "</center></td>";
									hfy += "<td width=\"100\"><center>";
									hfy += "……";
									hfy += "</center></td>";
									hfy += "<td width=\"135\"><center>";
									hfy += "……";
									hfy += "</center></td>";
									hfy += "<tr>";
			}
			$("#hthzftab").append(hfy);
			$("#hthzftab tr:empty").remove();
	
			//业务费用框
			$("#businessfee").empty();			
			for(var n=0;n<5;n++){
				nfy += "<tr>";
				nfy += "<td width=\"200\"><center>";
				nfy += "……";
				nfy += "</center></td>";
				nfy += "<td width=\"105\"><center>";
				nfy += "……";
				nfy += "</center></td>";
				nfy += "<tr>";
			}
			$("#businessfee").append(nfy);			
      }		   		  
		   		   
		   /********
           *添加电话费用杂费信息
           *@param;
       	   *@return;
           ********/
		   function insertphonefeename()
		   {
		      var phone = $("#Dh_yhdang").val();
		      if(phone=="")
		      {
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
		      var ress = JudgeISNOTStorage(phonefeename,phone,$("#Subtype").val());
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
		      }else if(cs3!=""&&cs2!=""&&cs1!=""){
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
		     var result = fetchMultiPValue("phonelnstalled.insertphonefeename",6,"&dh="+phone+"&feetype="+phonefeename+"&feecode="+feecode+"&feelv="+feelv+"&TJfeelv="+TJfeelv+"&StartMonth="+ZFStartmonth+"&EndMonth="+ZFEndmonth+"&StartDate="+ZFStartday+"&EndDate="+ZFEndday+"&feename="+feename+"&OperID="+tsd.encodeURIComponent($("#userid").val())+"&csstr="+tsd.encodeURIComponent(csstr)+"&ywlx=p_setup"+"&cztype=add"+"&DEVNUM="+DEVNUMstr+"&DEVLENGTH="+DEVLENGTHstr+"&CUNIT="+CUNIT);	
				 if(result[0][0]!=undefined && result[0][0]!=""&&result[0][0]=="SUCCEED")
				 {
				 	addspeediFeeType('');//重新加载数据
			        $("#feecode").val("");
			        $("#feelv").val("");
			        $("#TJfeelv").val("");
			        //$("#ZFStartday").val("");
			        //$("#ZFEndday").val("");
			        $("#Subtype").val("");
			        $("#feenameid").val("");
			        $("#Subtype").val("");
			        $("#phonefeename").val("");
			        $("#DEVNUM").val("1");
			        $("#DEVLENGTH").val("1");
			        $("#ZFEndday").val("2999-12-31");
			        phonefeechildtype
			        $("#phonefeechildtype").val("");
			        $("#phonefeeprice").val("");
				 }else{
				 	//alert("新增失败！");
				 	alert(result[0][1]);
				 }
			 
		     /*
		      var res = executeNoQuery("phonelnstalled.insertphonefeename",6,"&dh="+phone+"&feetype="+phonefeename+"&feecode="+feecode+"&feelv="+feelv+"&TJfeelv="+TJfeelv+"&StartMonth="+ZFStartmonth+"&EndMonth="+ZFEndmonth+"&StartDate="+ZFStartday+"&EndDate="+ZFEndday+"&feename="+feename+"&OperID="+tsd.encodeURIComponent($("#userid").val())+"&csstr="+tsd.encodeURIComponent(csstr));
		      if(res=="true")
		      {
		        addspeediFeeType();//重新加载数据
		        $("#feecode").val("");
		        $("#feelv").val("");
		        $("#TJfeelv").val("");
		        //$("#ZFStartday").val("");
		        //$("#ZFEndday").val("");
		        $("#Subtype").val("");
		        $("#feenameid").val("");
		        $("#Subtype").val("");
		        $("#phonefeename").val("");
		        $("#ZFEndday").val("2999-12-31");
		      }
		      else
		      {
		        alert("保存失败！");		        
		      }*/
		      //删除时把左边的点击显示颜色清空掉，然后把隐藏值也清空掉
		      $("#phonefeenamecode").val("");
        	  $("#phonefeename tr").css('background-color','#f7f7f7');
		    }
		    
		    /********
           *添加合同号费用杂费信息
           *@param;
       	   *@return;
           ********/
		   function insertphonefeename_hth()
		   {
		      var hth = $("#Hth_yhdang").val();
		      if(hth=="")
		      {
		      	alert("合同号不能为空");
		      	return false;
		      }
		      var phonefeename = $("#phonefeenamecode_hth").val();		      
		      if($("#phonefeetype_hth").val()=="")
		      {
		      	//alert("请选择要添加的费用名称");
		      	alert($("#getinternet0006").val());
		      	$("#phonefeetype_hth").focus();
		      	return false;
		      }
		      
		      if(phonefeename=="" || phonefeename==null)
		      {
		      	//alert("请选择要添加的费用子类型");
		      	alert($("#getinternet0007").val());
		      	$("#phonefeename_hth").focus();
		      	return false;
		      }
		      
		      phonefeename = tsd.encodeURIComponent(phonefeename);
		      executeNoQuery("phone.deleteAttachfee_hth_isCf",6,"&vfeename="+phonefeename+"&vhth="+hth,'business');
		      var ress = JudgeISNOTStorage_hth(phonefeename,hth);
		      if(ress!=0)
		      {
		      	//alert("该费用子类型已经存在不能重复添加！");
		      	alert($("#getinternet0008").val());
		      	return false;
		      }
		     
		      var feecode = $("#feecode_hth").val();
		      var feelv = $("#feelv_hth").val();
		      var ZFStartday = $("#ZFStartday_hth").val();
		      
		      if(!/^\d{4}-\d{2}-\d{2}$/.test(ZFStartday))
		      {
		      	$("#ZFStartday").focus();
		      	return false;
		      }
		      
		      var ZFEndday = $("#ZFEndday_hth").val();		      
		      if(!/^\d{4}-\d{2}-\d{2}$/.test(ZFEndday))
		      {
		      	$("#ZFEndday").focus();
		      	return false;
		      }		      
		      var ZFStartmonth = ZFStartday.substring(0,7);//起始月
		      ZFStartmonth = ZFStartmonth.replace('-',"");
		      
		      var ZFEndmonth = ZFEndday.substring(0,7);//终止月
		      ZFEndmonth = ZFEndmonth.replace('-',"");
		      
		      var feename = $("#Subtype_hth").val();
		      feename = tsd.encodeURIComponent(feename);
		      var FeeNum = $("#FeeNum").val().replace(/(^\s*)|(\s*$)/g,"");
		      if(FeeNum==""){
		      		alert("数量不能为空!");
		      		return;
		      	}
		      //alert("&hth="+hth+"&feetype="+phonefeename+"&feecode="+feecode+"&price="+feelv+"&startmonth="+ZFStartmonth+"&endmonth="+ZFEndmonth+"&feename="+feename+"&operid="+tsd.encodeURIComponent($("#userid").val())+"&feenum=1");		      		     
		      var res = executeNoQuery("phonelnstalled.insertphonefeename_hth",6,"&hth="+hth+"&feetype="+phonefeename+"&feecode="+feecode+"&price="+feelv+"&startmonth="+ZFStartmonth+"&endmonth="+ZFEndmonth+"&feename="+feename+"&operid="+tsd.encodeURIComponent($("#userid").val())+"&feenum="+$("#FeeNum").val(),'business');
		      if(res=="true")
		      {
		        addspeediFeeType_hth(hth);//重新加载数据
		        $("#feecode_hth").val("");
		        $("#feelv_hth").val("");
		        $("#phonefeename_hth").val("");
		        $("#ZFEndday_hth").val("2999-12-31");
		      }
		      else
		      {
		        	alert($("#getinternet0009").val());	        
		      }
		      //删除时把左边的点击显示颜色清空掉，然后把隐藏值也清空掉
		      $("#phonefeenamecode_hth").val("");
        	$("#phonefeename_hth tr").css('background-color','#f7f7f7');
		    }
		    
		    /********
           	*添加合同号新费用的时候判断该费用项是否已经在临时表里
           	*@param：（params电话，parm费用类型）;
       	  	*@return返回值是否等于零;
          	********/
		    function JudgeISNOTStorage_hth(params,parm)
		    {
		        var result;
		        var res = fetchMultiArrayValue("phonelnstalled.queryisnotfeename_hth",6,"&vhth="+parm+"&FeeType="+params,'business');	
		        result = res[0][0];
		        return result;	    
		    }
		    		    
		    /********
           	*添加新费用的时候判断该费用项是否已经在临时表里
           	*@param：（params电话，parm费用类型）;
       	  	*@return返回值是否等于零;
          	********/
		    function JudgeISNOTStorage(params,parm,feename)
		    {
		        var result;
		        var res = fetchMultiArrayValue("phonelnstalled.queryisnotfeename",6,"&Dh="+parm+"&FeeType="+params+"&vfeename="+tsd.encodeURIComponent(feename));	
		        result = res[0][0];
		        return result;	    
		    }
		    		    
		    /********
           	*查看是否存在新业务
           	*@param：（dh：电话）;
       	  	*@return返回值false存在新业务，true不存在新业务
			*feename=1 月租
          	********/
		    function isXinYeWuExists(dh)
		    {
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
           	*取新添加的“新业务” 返回数组
           	*@param;
       	  	*@return返回值数组       	  	
          	********/
		    function getAddedXyw()
		    {
		    	var zftab = new Array();
		    	$("#dhzftab tr:has('td')").each(function(){
		    		zftab.push($(this).find("td:eq(2)").text());
		    	});
		    	return zftab.length!=0?zftab.join("','"):"~";
		    }		    

		    /********
           	*判断起始时间是否大于截至时间;
           	*@param：parm起始时间、params截至时间;
       	  	*@return返回值是否为零
          	********/
		    function gettimeday(parm,params)
		    {
		       var result;
		       var res = fetchMultiArrayValue("phonelnstalled.getstartendtime",6,"&starttime="+parm+"&endtime="+params);
		       result = res[0][0];
		       return result;
		    }
		    
		    /********
           	*选中所有的电话杂费项
           	*@param;
       	  	*@return;
          	********/
		    function Dhzf_CheckAll()
		    {
		    	if($("#dhzftab_checkall").attr("checked"))
	        		$("input[id^='v_dhzftab_check']").attr("checked","checked");
	        	else
	        		$("input[id^='v_dhzftab_check']").removeAttr("checked");
		    }	
		    
		     /********
           	*选中所有的合同号月租杂费项
           	*@param;
       	  	*@return;
          	********/
		    function hthZf_CheckAll()
		    {
		    	if($("#hthzftab_checkall").attr("checked"))
	        		$("input[id^='v_hthzftab_check']").attr("checked","checked");
	        	else
	        		$("input[id^='v_hthzftab_check']").removeAttr("checked");
		    }	   
		    

		   /********
           	*删除列表中的电话费用杂费信息
           	*@param;
       	  	*@return;
          	********/
		    function deletephonefeename()
		    {	
				var checkedDhzf = $("input[id^='v_dhzftab_check'][checked]");
	        	var count = $(checkedDhzf).size();	 
	        	alert("count=="+count);       	
	        	if(count<1)
	        	{
	        		//alert("请选择要删除的杂费项信息");
	        		alert($("#getinternet0010").val());
	        		return false;
	        	}	        	
	        	var dh = $("#Dh_yhdang").val();
	        	var feetype = "";
	        	var feecode = "";       	
	        	var result = true;
	        	var resultTmp = false;	        	
	        	for(var i=0;i<count;i++)
	        	{
	        		feetype = $(checkedDhzf[i]).parent().parent().next().next().text();
	        		feecode = $(checkedDhzf[i]).parent().parent().next().next().next().text();//费用code是隐藏在表格中的
	        		
	        		/*
	        		resultTmp = executeNoQuery("phonelnstalled.deletephonefeename",6,"&FeeType="+tsd.encodeURIComponent(feetype)+"&Dh="+dh);	        		
	        		if(resultTmp=="false" || resultTmp==false)
	        		{
	        			result = false;
	        			alert("删除杂费失败");
	        		}*/
	        		var result = fetchMultiPValue("phonelnstalled.insertphonefeename",6,"&feetype="+tsd.encodeURIComponent(feetype)+"&feecode="+feecode+"&dh="+dh+"&ywlx=p_setup"+"&cztype=delete");
					 if(result[0]!=undefined && result[0][0]!="")
					 {					 	
	        			
					 }else{
					 	//alert("删除杂费失败");
					 	alert($("#getinternet0011").val());
					 }
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
	        	//删除时把左边的点击显示颜色清空掉，然后把隐藏值也清空掉
	        	$("#phonefeenamecode").val("");
        	    $("#phonefeename tr").css('background-color','#f7f7f7');
	        	//重新加载数据
	        	addspeediFeeType('');	        	
		    }
		    
		    /********
         *删除列表中的合同号费用杂费信息
         *@param;
       	 *@return;
        ********/
		    function deletephonefeename_hth()
		    {	
				var checkedDhzf = $("input[id^='v_hthzftab_check'][checked]");
	        	var count = $(checkedDhzf).size();	        	
	        	if(count<1)
	        	{
	        		//alert("请选择要删除的杂费项信息");
	        		alert($("#getinternet0010").val());
	        		return false;
	        	}	        	
	        	var hth = $("#Hth_yhdang").val();
	        	var feetype = "";
	        	var feecode = "";       	
	        	var result = true;
	        	var resultTmp = false;	        	
	        	for(var i=0;i<count;i++)
	        	{
	        		feetype = $(checkedDhzf[i]).parent().parent().next().text();
	        		feecode = $(checkedDhzf[i]).parent().parent().next().next().text();//费用code是隐藏在表格中的
	        		resultTmp = executeNoQuery("phonelnstalled.deletephonefeename_hth",6,"&vfeetype="+tsd.encodeURIComponent(feetype)+"&vhth="+hth,'business');	        		
	        	}	
	        	  //删除时把左边的点击显示颜色清空掉，然后把隐藏值也清空掉
	        	  $("#phonefeenamecode_hth").val("");
        	    $("#phonefeename_hth tr").css('background-color','#f7f7f7');
	        	//重新加载数据
	        	addspeediFeeType_hth('');	        	
		    }   

		///////////////////////////////////////////////////////////////////////////////
		// 功能：这个类使得被附加的表格可以支持行点击高亮
		// 参数：
		//            tbl:                要附加样式的 table.
		//            selectedRowIndex:    初始高亮的行的索引(从 0 开始). 此参数可省。
		//            hilightColor:        高亮颜色。可省（默认为绿色）
		///////////////////////////////////////////////////////////////////////////////
		function TableRowHilighter(tbl, selectedRowIndex, hilightColor) {
		    this.currentRow = null;
		    this.hilightColor = hilightColor ? hilightColor : 'green';   
		
		    if (selectedRowIndex != null 
		        && selectedRowIndex >= 0 
		        && selectedRowIndex < tbl.rows.length) 
		    {
		        this.currentRow = tbl.rows[selectedRowIndex];        
		        tbl.rows[selectedRowIndex].runtimeStyle.backgroundColor = this.hilightColor;
		    }
		
		    var _this = this;
		    tbl.attachEvent("onmouseover", table_onclick);   
		
		    function table_onclick(){
		        var e = event.srcElement;        
		        if (e.tagName == 'TD')
		            e = e.parentElement;            
		        if (e.tagName != 'TR') return;
		        if (e == _this.currentRow) return;
		        if (_this.currentRow)
		            _this.currentRow.runtimeStyle.backgroundColor = '';
		            
		        e.runtimeStyle.backgroundColor = _this.hilightColor;
		        _this.currentRow = e;
		    }
		}
   
        /********
        *付费方式改变引起的其他改变
        *@param;
       	*@return;
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
                
        /********
        *固话杂费  费用名称 下拉框change事件 并去除对应的费用项信息 
        *@param;
       	*@return;
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
              //$("#ZFStartday").val("");
              //$("#ZFEnday").val("");
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
           var CUNIT = res[0][5];
           $("#feecode").val(FeeCode);
           $("#Subtype").val(FeeName);
           $("#feelv").val(Price);
           $("#phonefeeprice").val(Price);
           $("#TJfeelv").val(TjPrice);
           $("#CUNIT").val(CUNIT);
        }
        
        /********
        *hth月租  费用名称 下拉框change事件 并去除对应的费用项信息 
        *@param;
       	*@return;
        ********/       
        function getfeenameall_hth()
        {           
           var phonefeename = $("#phonefeenamecode_hth").val();
           //alert(phonefeename);         
           if(phonefeename=="")
           {
           		$("#Subtype_hth").val("");
              $("#feecode_hth").val("");
              $("#Subtype_hth").val("");
              $("#feelv_hth").val("");              
              //$("#ZFStartday").val("");
              //$("#ZFEnday").val("");
              return false;
           }           
           //取费用项信息
           var res = fetchMultiArrayValue("phonelnstalled.queryfeenameall_hth",6,"&FeeType="+tsd.encodeURIComponent(phonefeename),'business');
           var FeeCode = res[0][0];
           var FeeName = res[0][1];
           var Price = res[0][3];
           $("#feecode_hth").val(FeeCode);
           $("#Subtype_hth").val(FeeName);
           $("#feelv_hth").val(Price);
        }
        
          
        /********
        *优惠套餐保存临时表 
        *@param;
       	*@return;
        ********/
        function Bytc_Save()
        {
        	var tctype = $("#Packagetype").val();
        	if(tctype=="" || tctype==undefined)
        	{
        		//alert("请选择优惠套餐类型");
        		alert($("#getinternet0012").val());
        		return false;
        	}
        	else
        	{        		
        		//alert(/^\d{4}-\d{2}-\d{2}$/.test($("#TCStarttime").val()));
        		var dh = $("#Dh_yhdang").val();
        		if(dh=="")
        		{
        			return false;
        		}
        		//验证所添加套餐类型是否已存在
        		var existedcheck=fetchSingleValue("phonelnstalled.checkbytcexisted",6,"&bytctype="+tsd.encodeURIComponent(tctype)+"&dh="+dh);
        		existedcheck = parseInt(existedcheck);
        		if(existedcheck!=0)
        		{
        			//alert("优惠套餐\"" + tctype + "\"已经存在，不能重复添加");
        			alert($("#getinternet0013").val() + tctype + $("#getinternet0014").val());
        			return false;
        		}
        		
        		if(!/^\d{4}-\d{2}-\d{2}$/.test($("#TCStarttime").val()))
        		{
        			$("#TCStarttime").focus();
        			return false;
        		}
        		if(!/^\d{4}-\d{2}-\d{2}$/.test($("#TCEndtime").val()))
        		{
        			$("#TCEndtime").focus();
        			return false;
        		}
        		
        		var startdate = $("#TCStarttime").val();
        		var enddate = $("#TCEndtime").val();
        		//检测时间
        		var timecheck=fetchSingleValue("phonelnstalled.getstartendtime",6,"&starttime="+startdate+"&endtime="+enddate);
        		timecheck = parseInt(timecheck);
        		if(isNaN(timecheck) || timecheck<=0)
        		{
        			//alert("终止月份必须大于起始月份");
        			alert($("#getinternet0015").val());
        			return false;
        		}        		
        		//取费用名称和月数
        		var res = fetchMultiArrayValue("phonelnstalled.queryPackagetypeByWhere",6,"&bytctype="+tsd.encodeURIComponent(tctype));
        		
        		if(res[0]==undefined || res[0][0]==undefined)
        		{
        			return false;
        		}
        		
        		var feename = res[0][0];
        		var ys = res[0][2];        		
        		
        		var startmonth=startdate.substr(0,7).replace("-","");
        		var endmonth=enddate.substr(0,7).replace("-","");
        		
        		
        		var userid = $("#userid").val();
        		
        		var params = "";
        		params += "&feename=";
        		params += tsd.encodeURIComponent(feename);
        		params += "&bytctype=";
        		params += tsd.encodeURIComponent(tctype);
        		params += "&dh=";
        		params += dh;
        		params += "&Openmonth=";
        		params += startmonth;
        		params += "&Opendate=";
        		params += startdate;
        		params += "&Startmonth=";
        		params += endmonth;
        		params += "&Startdate=";
        		params += enddate;
        		params += "&ys=";
        		params += ys;
        		params += "&OperID=";
        		params += userid;
        		
        		var insertRes = executeNoQuery("phonelnstalled.addbytc",6,params);
        		if(insertRes=="true" || insertRes==true)
        		{
        			//alert("添加数据成功");
        			alert($("#getinternet0016").val());
        			Bytc_Refresh();
        		}
        		else
        		{
        			//alert("添加数据失败");
        			alert($("#getinternet0017").val());
        		}
        		
        		$("#Packagetype").val("");
        		$("#TCStarttime").val("");
        		$("#TCEndtime").val("");
        		//'<feename>','<bytctype>','<dh>','<Openmonth>','<Opendate>','<Startmonth>','<Startdate>',<ys>,'<OperID>')
        	}
        }    

        /********
        *刷新优惠套餐数据 
        *@param;
       	*@return;
        ********/
        function Bytc_Refresh()
        {
			$("#bytctab tr:has('td')").remove();
			$("#bytctab tr:empty").remove();
			
			var phone = $("#Dh_yhdang").val();
			if(phone=="")
			{
				return false;
			}
			var res = fetchMultiArrayValue("phonelnstalled.queryPackagetypeXX",6,"&dh="+phone);	
			
			if(res[0]==undefined || res[0][0]==undefined)
			{
				return false;
			}
			
			var count = res.length;
			var ify = "";
			
			for(var i=0;i<count;i++)
			{
				ify += "<tr>";
				//<input type='checkbox' name='checkbox1' id='ck' onclick='javascript:iFeetypeSJ("+feecode+")' value='"+feecode+"' style='width:15px; height:15px; border:0px;float:rith; line-height:'/>
				
				ify += "<td><center>";
				ify += "<input type=\"checkbox\" id=\"v_bytctab_check\"" + i + " />";
				ify += "</center></td>";
				
				ify += "<td><center>";
				ify += res[i][0];
				ify += "</center></td>";
				ify += "<td><center>";
				ify += res[i][1];
				ify += "</center></td>";
				ify += "<td><center>";
				ify += res[i][2];
				ify += "</center></td>";
				ify += "<td><center>";
				ify += res[i][3];
				ify += "</center></td>";
				ify += "<td><center>";
				ify += res[i][4];
				ify += "</center></td>";
				ify += "<tr>";	
			}
			
			//alert(ify);
			$("#bytctab").append(ify);
			
			$("#bytctab_checkall").removeAttr("checked");
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
        *优惠套餐删除 
        *@param;
       	*@return;
        ********/
        function Bytc_Del()
        {
        	var checkedBytc = $("input[id^='v_bytctab_check'][checked]");
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
        		tclx = $(checkedBytc[i]).parent().parent().next().next().text();
        		resultTmp = executeNoQuery("phonelnstalled.delbytc",6,"&bytctype="+tsd.encodeURIComponent(tclx)+"&dh="+dh);
        		
        		if(resultTmp=="false" || resultTmp==false)
        		{
        			result = false;
        		}
        	}

        	if(result)
        	{
        		//alert("删除套餐成功");
        		alert($("#getinternet0019").val());
        	}
        	else
        	{
        		//alert("删除套餐失败");
        		alert($("#getinternet0020").val());
        	}
        	Bytc_Refresh();
        }

        /********
        *重置设置 
        *@param;
       	*@return;
        ********/
        function Dhzj_Reset()
        {
        	$("#tablehthdang :text").val("");
        	$("#tablehthdang select").not($("#ZnjBz")).val("");
        	$("#tablehthdang select").not(":disabled").val("");
        	$("#tablehthdang select").attr("disabled","disabled");
			$("#tablehthdang :text").attr("disabled","disabled");			
			$("#tableyhdang :text").val("");
        	$("#tableyhdang select").not($("#ZnjBz")).val("");
        	$("#tableyhdang select").not(":disabled").val("");
        	$("#tableyhdang select").attr("disabled","disabled");
			$("#tableyhdang :text").attr("disabled","disabled");				
			$("#dhzftab tr:has('td')").remove();
			$("#bytctab tr:has('td')").remove();
			$("#bytctabs tr:has('td')").remove();			
			$("#fufeitype").val("cash");
			$("#danweiHTHbox").removeAttr("checked");			
			$("#feelv,#TJfeelv,#tBz,#Packagetype,#danweiHTH,#getphone,#usertype,#hth").val("");
			$("#Bz6_yhdang").val(7);
			$("#phonefeetype,#staff_bm").val("").trigger("change");					
			$("#StartDate_yhdang").val('2999-12-31');
			$("#EndDate_yhdang").val('2999-12-31');
			$("#TCStarttime").val('2999-12-31');
			$("#TCEndtime").val('2999-12-31');
			$("#Yhxz option:gt(0)").remove();			
			queryFeename();			
        	getdisabled();
        	$("#getphone").select();
        	$("#getphone").focus();
        	$("#Paymoney").val("");
        	$("#Yhxz").val("");
        	//权限控制选择合同号是否可选
			if($("#selecththright").val()=='true'){
				$("#setselectHth").removeAttr("disabled");
			}else{
				$("#setselectHth").attr("disabled","disabled");
			}
			$("#sBm1").val("");
			$("#sBm2").val("");
			$("#sBm3").val("");
			$("#sBm4").val("");
			$("#Bm1_yhdang").val("");
			$("#Bm2_yhdang").val("");
			$("#Bm3_yhdang").val("");
			$("#Bm4_yhdang").val("");
			$("#Yhxz_hthdang").val("");
			$("#Prefee").val("");
			$("#confee").val("");
			$("#yjfee").val("");
			$("#Paymoney").val("");
			$("#selecththcontent").val("");
			$("#Packaggroupid").val("");
			$("#Packagetypes").val("");
			unLockDh();
			refreshbusinessfee();
			//$("#usertype").val("自费");
			$("#usertype").val($("#getinternet0383").val());
			$("#Yhlb_hthdang").val($("#usertype").val()==""?"":$("#usertype option:selected").text());
			$("#Packagetypes").empty();
			$("#Prefee").attr("disabled","disabled");
			$("#confee").attr("disabled","disabled");
			$("#precheck").removeAttr("checked");
			clearMultiSelect();
			$("#Hcqx_yhdang").val("");
			gettable();
        }
		
		/**
		 * 清空多选下拉框
		 * @param 
		 * @return  
		 */
		function clearMultiSelect(){
				$(".multiSelectOptions :checkbox:checked").attr("checked",false).parent().removeClass("checked");
				$(".multiSelectOptions :disabled").removeAttr("disabled");
				$(".multiSelect").attr("trueval","");
		}

        /********
        *生成新合同号
        *@param;
       	*@return;
        ********/
        var phonestr = $("#getnullphone").val();
        function GenerateHth()
        {
        	var key = $("#businesstype").val();
        	if(key=='p_movewithoutarea'||key=='p_changeuser'){
        		//电话号码
	        	var cphonenum = $("#Dh_yhdang").val();
	        	if(cphonenum==undefined || cphonenum=="")
	        	{
	        		//alert("请查询一个电话用户！");
	        		alert($("#getinternet0140").val());
	        		$("#ghSearchBox").select();
	        		$("#ghSearchBox").focus();
	        		return false;
	        	}
        	}
        	//电话号码
        	var cphonenum = $("#Dh_yhdang").val();
        	/*
        	if((cphonenum==undefined || cphonenum=="")&&$("#selectinserttype").val()=='1'&&key=="p_setup")
        	{
        		//alert("请先选择一个电话空号");
        		alert($("#getnullphone").val());
        		$("#getphone").select();
        		$("#getphone").focus();
        		return;
        	}else if(key=="p_movewithoutarea"&&$("#chooseKH").val().replace(/(^\s*)|(\s*$)/g,"")==""){
        		alert($("#getnullphone").val());
        		$("#chooseKH").select().focus();
        		return;
        	}
        	*/
        	//用户类别 	       
        	if($("#usertype").val()=="" || $("#usertype").val()==undefined || $("#usertype").val()=="")
        	{
        		//alert("请选择用户类别");
        		alert($("#getselectyhlb").val());
        		$("#hth").val("");
        		$("#Hth_hthdang").val("");
        		return false;
        	}
        	$("#geththsbm select").removeAttr("disabled");        	
        	//if($("#usertype option:selected").text()=="公费"){
        	/*
        	if($("#usertype option:selected").text()==$("#getinternet0384").val()){
	        	if($("#sBm1").val()=="")
	        	{
	        		//alert("请选择一级部门");
	        		alert($("#getinternet0021").val());
	        		$("#hth").val("");
	        		$("#Hth_hthdang").val("");
	        		if(key=='p_setup'){
	        			$("#Hth_yhdang").val("");
	        		}
	        		return false;
	        	}
        	}else{
        		$("#Bm1").val("");
        		$("#Bm2").val("");
            	$("#Bm3").val("");
        		$("#Bm4").val("");
        	}
        	*/
        	var res = fetchSingleValue("dbsql_phone.querytabledate",6,"&tablename=tsd_ini&cloum=tvalues&key=tident='getHth_yhxz_true' and tsection='phonebusiness'");	
			    if($("#Yhxz_hthdang").val()==""&&res=='Y'){
					  alert("请选择用户性质！");
					  $("#Yhxz_hthdang").select().focus();
					  return;
				  }
        	var hthBm1 = $("#sBm1").val();
        	var hthBm2 = $("#sBm2").val();
        	var hthBm3 = $("#sBm3").val();
        	var hthBm4 = $("#sBm4").val();
        	if($("#Bm1").val()==""){hthBm1="";}
        	if($("#Bm2").val()==""){hthBm2="";}
        	if($("#Bm3").val()==""){hthBm3="";}
        	if($("#Bm4").val()==""){hthBm4="";}
			var yhxz_hthdang = $("#Yhxz_hthdang").val();
        	var params = "&Ywlx=";
        	params += tsd.encodeURIComponent(key);
			params += "&yhxz=";
        	params += tsd.encodeURIComponent($("#Yhxz_hthdang").val());
        	params += "&YHLB=";
        	params += tsd.encodeURIComponent($("#usertype option:selected").text());
        	params += "&Dh=";
        	params += cphonenum;
        	//这是后来添加更改的，根据合同号部门来生成合同号；
        	params += "&Bm1=";
        	params += tsd.encodeURIComponent(hthBm1);
        	params += "&Bm2=";
        	params += tsd.encodeURIComponent(hthBm2);
        	params += "&Bm3=";
        	params += tsd.encodeURIComponent(hthBm3);
        	params += "&Bm4=";
        	params += tsd.encodeURIComponent(hthBm4);
        	params += "&area=";
        	params += tsd.encodeURIComponent($("#area").val());        	
        	var result = fetchMultiPValue("PhoneSetup.NewHth",6,params);        	
        	if(result[0]==undefined || result[0][0]==undefined)
        	{
        		//alert("生成合同号失败");
        		alert($("#getinternet0022").val());        		
        		$("#hth").val("");
        		$("#Hth_hthdang").val("");
        		if(key=='p_setup'){
        			$("#Hth_yhdang").val("");
        		}
        		return;
        	}
        	else
        	{
        		var resultYZHTH = fetchMultiPValue("Phone.ywsl_check_hth",6,'&Hth='+result[0][0]); 
        		if(resultYZHTH[0][0]!=undefined&&resultYZHTH!=""){
        				if(resultYZHTH[0][0]==1){
        						alert("合同号：["+result[0][0]+"]在表["+resultYZHTH[0][1]+"]存在，请重新生成或输入!");
        						return;
        					}
        			}
        		$("#tablehthdang select").val("");
						$("#tablehthdang :text").val("");
						if(key=='p_movewithoutarea'||key=='p_changeuser'||key=='p_acctsetup'||key=='p_hthchangename'){
	        		geththedite();//businesspublic.js中  自动加载显示框合同号可编辑的显示框
	        		getyhxzstr('p_movewithoutarea');//用户性质
	        		getbusinessDefault('Y','N');//设置默认值第一个参数是对合同号是否进行默认值，第二个参数是对用户档是否设置默认值，Y是，N不是
	        		//如果是其他业务生成合同号时将根据判断获取原来合同号已有信息，为了方便输入重复信息
	        		geththselect_sc($("#usertype option:selected").text(),$("#Yhlb_hthdang").val(),result[0][0]);
	        	}else if(key=='p_setup'){
	        		getPowertrue();
							getyhxzstr("p_setup");
							getbusinessDefault('Y','Y');//设置默认值第一个参数是对合同号是否进行默认值，第二个参数是对用户档是否设置默认值，Y是，N不是
							queryFeename();//加载一次性费用	
							$("#Hth_yhdang").val(result[0][0]);   
	        	}
        		$("#hth").val(result[0][0]);
        		$("#Hth_hthdang").val(result[0][0]);
        	}
        	$("#tablehthdang select").removeAttr("disabled");
        	$("#geththsbm select").removeAttr("disabled");
					$("#tablehthdang :text").removeAttr("disabled");
					$("#geththsbm").removeAttr("disabled");
					$("#Yhlb_hthdang").val($("#usertype option:selected").text());			
					$("#Dh_hthdang").val($("#Dh_yhdang").val());
					$("#Dh_hthdang").attr("disabled","disabled");
					$("#Hth_hthdang").attr("disabled","disabled");
					$("#Yhlb_hthdang").attr("disabled","disabled");
					$("#setHthvalue").removeAttr("disabled");	
					$("#Yhxz_hthdang").val(yhxz_hthdang);
					deleteHthYZ($("#userid").val(),result[0][0]);
        }     
        
        //生成新的合同号后将原来合同号月租表里的信息删除
        function deleteHthYZ(userid,hth){
        	 var res = executeNoQuery("phoneInstalled.deleteattachfee_hth_tmpnew",6,"&voperid="+userid,'business');
        	 //通过合同号查询到合同号月租
        	 var result = fetchMultiPValue("PhoneService.TranTmp",6,"&userid=" + tsd.encodeURIComponent($("#userid").val())+"&hth="+hth);
        	 //刷新合同号月租列表
        	 addspeediFeeType_hth(hth);        	 
        }     
        
        /********
        *电话验证装机保存调用过程ywsl_setup
        *@param;
       	*@return;
        ********/
        function Dhzj_Save()
        {
           //$("#Messagevalues").text("数据处理中，请稍等…………");
           $("#Messagevalues").text($("#getinternet0023").val());	           
           ///////////////////////////////////////////////////////////////////           
           tsd.QualifiedVal=true;
           var procparams = "";
           //选择开户类型为电话开户时所有信息都拼接参数，如果选择合同号开户str=2时 只拼接合同号信息 
		   var str = $("#selectinserttype").val();
		   //开户类型
		   var strkey='';
		   if(str=="1"){strkey='dhkh';}
		   procparams += "&cinstalledtype=";
		   procparams += tsd.encodeURIComponent(strkey);
		   if($("#Dhlx").val()==""&&str=='1'){
		   		//alert("请选择电话类型");
		   		alert($("#getinternet0024").val());
		   		$("#Dhlx").select();
		   		$("#Dhlx").focus();
		   		return false;
		   }
		   procparams += "&cdhlx=";
		   procparams += tsd.encodeURIComponent($("#Dhlx option:selected").text());
		   if($("#Bz4_yhdang").val()=="PBX连选"&&$("#Zlh_yhdang").val().replace(/(^\s*)|(\s*$)/g,"")==""){
				alert("请输入连选数量");   
				return;
			}
			if($("#Bz4_yhdang").val()=="PBX连选"&&$("#Zlh_yhdang").val().replace(/(^\s*)|(\s*$)/g,"")<=1){
						alert("选择连选号码时,连选数量必须大于1");
						return;
			}
           //电话合同号严重是否生成
           var cphonenum = $("#Dh_yhdang").val();
		    if(cphonenum!=undefined&&str=="1"){
				 cphonenum=cphonenum.replace(/(^\s*)|(\s*$)/g,"");
				 if(cphonenum==""){				 	
					$("#getphone").select();
					$("#getphone").focus();
					alert($("#getnullphone").val());
					return false;
				}
			}	
			//自身合同号
			var chth = $("#hth").val();
				if(chth=="")
				{
					$("#usertype").select();
					$("#usertype").focus();
					//alert("合同号不能为空,请生成或输入一个合同号");
					alert($("#getinternet0025").val());
					return false;
				}	
           
            var languageType = $("#languageType").val(); 
		    var Dat = loadData_phoneinstalled("Hthdang",languageType,2);		    
		    var reszh = fetchFieldAlias('Hthdang',languageType);			 
			 for(var i=0;i<Dat.FieldName.length;i++){
			 	var strhth = $("#"+Dat.FieldName[i]+"_hthdang").val();
			 	if(strhth!=undefined){
			 		strhth = strhth.replace(/(^\s*)|(\s*$)/g,"");
			        	if(strhth==""&&Judgefield_hthdang(Dat.FieldName[i]+"_hthdang")==true&&$("#"+Dat.FieldName[i]+"_hthdang").attr("disabled")!=true)
			        	{
			        		//alert("合同号信息中["+reszh[Dat.FieldName[i]]+"]不能为空!");
			        		alert($("#getinternet0026").val()+reszh[Dat.FieldName[i]]+$("#getinternet0027").val());
			        		$("#"+Dat.FieldName[i]+"_hthdang").select();
			        		$("#"+Dat.FieldName[i]+"_hthdang").focus();
			        		return false;
			        		break;
			        	}
		        	}
		        if(strhth==null){strhth="";}	
			 	procparams += "&"+Dat.FieldName[i]+"hth="+tsd.encodeURIComponent(strhth);
			 }
			 		/*
			 		var resgfhth = fetchSingleValue("dbsql_phone.queryhthdanghth",6,"&hth="+tsd.encodeURIComponent($("#Hth_hthdang").val()));
					if(resgfhth==undefined||resgfhth=='0')
					{
						//合同号一级部门
			        	//if($("#Yhlb_hthdang").val()=="公费"&&$("#sBm1").val()=="")
			        	if($("#Yhlb_hthdang").val()==$("#getinternet0384").val()&&$("#sBm1").val()=="")
			        	{
			        		//alert("当前用户类别为公费，必须选择一级部门");
			        		alert($("#getinternet0028").val());
			        		$("#sBm1").select();
			        		$("#sBm1").focus();
			        		return false;
			        	}
					}
					*/
		        	procparams += "&chthbm1=";
		        	procparams += tsd.encodeURIComponent($("#sBm1").val());
		        	//合同号二级部门
		        	var chthbm2 = $("#sBm2").val();
		        	procparams += "&chthbm2=";
					procparams += tsd.encodeURIComponent(chthbm2);
					//合同号三级部门        	
		        	var chthbm3 = $("#sBm3").val();
		        	procparams += "&chthbm3=";
					procparams += tsd.encodeURIComponent(chthbm3);
					//合同号二级部门        	
		        	var chthbm4 = $("#sBm4").val();
		        	procparams += "&chthbm4=";
					procparams += tsd.encodeURIComponent(chthbm4);
					var Email = $("#Email_hthdang").val();//邮件地址  
					if(Email!=undefined){
			        	Email=Email.replace(/(^\s*)|(\s*$)/g,"");	
						var emailRegExp = new RegExp("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
						if ((!emailRegExp.test(Email)||Email.indexOf('.')==-1)&&Email!=""&&$("#Email_hthdang").attr("disabled")!=true){
							//alert("合同号信息中邮件格式不正确！！！");
							alert($("#getinternet0029").val());
							$("#Email_hthdang").select();
							$("#Email_hthdang").focus();
							return false;
						}
					}	
					var IDCard = $("#IDCard_hthdang").val();		        	
		        	if(IDCard!=undefined){
			        	IDCard=IDCard.replace(/(^\s*)|(\s*$)/g,"");
			        	if($("#IDCard_hthdang").attr("disabled")!=true&&IDCard!=""&&!/((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65)[0-9]{4})(([1|2][0-9]{3}[0|1][0-9][0-3][0-9][0-9]{3}[X0-9])|([0-9]{2}[0|1][0-9][0-3][0-9][0-9]{3}))$/.test(IDCard)&&IDCard!=undefined)
		        		{
			        		//alert("合同号信息中请输入正确的身份证号码");
			        		alert($("#getinternet0030").val());
			        		$("#IDCard_hthdang").select();
			        		$("#IDCard_hthdang").focus();
			        		return false;
		        		}
		        	}		        				  
			 if(str=='1'){
				 var Dat = loadData_phoneinstalled("Yhdang",languageType,2);
				 var reszh = fetchFieldAlias('Yhdang',languageType);
				 for(var i=0;i<Dat.FieldName.length;i++){
				 	var stryhdang = $("#"+Dat.FieldName[i]+"_yhdang").val();
				 	if(stryhdang!=undefined){
				 		stryhdang = stryhdang.replace(/(^\s*)|(\s*$)/g,"");
				        	if(stryhdang==""&&Judgefield_yhdang(Dat.FieldName[i]+"_yhdang")==true&&$("#"+Dat.FieldName[i]+"_yhdang").attr("disabled")!=true)
				        	{
				        		//alert("用户档信息中["+reszh[Dat.FieldName[i]]+"]不能为空!");
				        		alert($("#getinternet0031").val()+reszh[Dat.FieldName[i]]+$("#getinternet0027").val());
				        		$("#"+Dat.FieldName[i]+"_yhdang").select();
				        		$("#"+Dat.FieldName[i]+"_yhdang").focus();
				        		return false;
				        		break;
				        	}
			        	}
			        if(stryhdang==null){stryhdang="";}		
				 	procparams += "&"+Dat.FieldName[i]+"yhdang="+tsd.encodeURIComponent(stryhdang);
				 }
				 var cDocumentsNumber = $("#Bz7_yhdang").val();
	        	 if(cDocumentsNumber!=undefined){
			        	cDocumentsNumber=cDocumentsNumber.replace(/(^\s*)|(\s*$)/g,"");
			        	if($("#Bz7_yhdang").attr("disabled")!=true&&$("#Bz6_yhdang").val()=='7' && cDocumentsNumber!="" && !/((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65)[0-9]{4})(([1|2][0-9]{3}[0|1][0-9][0-3][0-9][0-9]{3}[X0-9])|([0-9]{2}[0|1][0-9][0-3][0-9][0-9]{3}))$/.test(cDocumentsNumber))
			        	{
			        		//alert("固话信息中请输入正确的身份证号码");
			        		alert($("#getinternet0032").val());
			        		$("#Bz7_yhdang").select();
			        		$("#Bz7_yhdang").focus();
			        		return false;
			        	}
			     }
				

				//一级部门
				var csbm1=$("#sBm1").val();
	        	
				procparams += "&csbm1=";
	        	procparams += tsd.encodeURIComponent(csbm1);
	        	//二级部门        	
				var csbm2=$("#sBm2").val();
	        	procparams += "&csbm2=";
				procparams += tsd.encodeURIComponent(csbm2);						
	        	//三级部门        	
				var csbm3=$("#sBm3").val();
	        	procparams += "&csbm3=";
				procparams += tsd.encodeURIComponent(csbm3);
	
	        	//四级部门        	
				var csbm4=$("#sBm4").val();
	        	procparams += "&csbm4=";
				procparams += tsd.encodeURIComponent(csbm4);

		        //停机标志
		        var cTJLogo = $("#Tjbz_yhdang").val();
		        procparams += "&Tjbzyhdang=";
				procparams += tsd.encodeURIComponent('K');		        
		        //交换机编号
		        var cSwitchNumber = $("#SwitchNumber").val();
		        if(cSwitchNumber==""||cSwitchNumber==null||cSwitchNumber=="null"){cSwitchNumber='';}
		        procparams += "&Jhj_IDyhdang=";
				procparams += tsd.encodeURIComponent(cSwitchNumber);
				
				var resYZ = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&tablename=tsd_ini&cloum=tvalues&key=tsection='phonebusiness' and tident='selectMonthlyRent'"); 
				if(resYZ==""||resYZ==undefined||resYZ=="Y"){
					if(isXinYeWuExists(cphonenum)=="0")
					{
						//alert("至少应该添加一项月租费");
						alert($("#getinternet0034").val());
						$("#phonefeetype").select();
						$("#phonefeetype").focus();
						return false;
					}
				}

		       	//是否付费
		       	var jfufeicheckbox = $("#fufeicheckbox").attr("checked");        	        	
		       	//付费方式
		       	var jfufeitype = $("#fufeitype").val();
		       	procparams += "&jfufeitype=";
				procparams += tsd.encodeURIComponent(jfufeitype);
		       	//应缴费用
		       	var jyjfee = $("#yjfee").val();
		       	jyjfee=jyjfee.replace(/(^\s*)|(\s*$)/g,"");
		       	if(jyjfee==""){jyjfee=0;}
		       	procparams += "&jyjfee=";
				procparams += tsd.encodeURIComponent(jyjfee);
		       	//实收费用
		       	/*
		       	var jfflsjfy = $("#fflsjfy").val();
		       	jfflsjfy=jfflsjfy.replace(/(^\s*)|(\s*$)/g,"");
		       	if(jfflsjfy==""){jfflsjfy=0;}
		       	procparams += "&jfflsjfy=";
				procparams += tsd.encodeURIComponent(jfflsjfy);*/
		       	//缴费款项
		       	var jPaymoney = $("#Paymoney").val();
		       	procparams += "&jPaymoney=";
				procparams += tsd.encodeURIComponent(jPaymoney);
				jyjfee = parseFloat(jyjfee,10);
				//jfflsjfy = parseFloat(jfflsjfy,10);	
				if(jyjfee==0){jPaymoney="";}
				//if(jyjfee!=0&&jfflsjfy==0){alert("请输入实缴费用！");$("#fflsjfy").select();$("#fflsjfy").focus();return false;}	 			
		       	//联系人
		       	var jffllxh = $("#staff_ry").val();
		       	procparams += "&jffllxr=";
				procparams += tsd.encodeURIComponent(jffllxh);			
				//检测一次费用 (必填一项类)
				//if(!checkYCXFY()) return false;
		       	//联系电话
		       	var jffllxdh = $("#ffllxdh").val();
		       	procparams += "&jffllxdh=";        	
		       	//预存款
		       	var prechecked= $("#precheck").attr("checked");
			    if(prechecked){
			       	var Prefee = $("#Prefee").val();
			       	Prefee=Prefee.replace(/(^\s*)|(\s*$)/g,"");	        	
			       	var confee = $("#confee").val();
			       	confee=confee.replace(/(^\s*)|(\s*$)/g,"");	        	
			        if(Prefee.length==0){
			        	//alert("请输入预存金额");
			        	alert($("#getinternet0035").val());
			        	$("#Prefee").select();
			        	$("#Prefee").focus();
			        	return false;
			        }	        	
			        if(confee.length==0){
			        	//alert("请输入确认金额");
			        	alert($("#getinternet0036").val());
			        	$("#confee").select();
			        	$("#confee").focus();
			        	return false;
			        }
			        if(Prefee!=confee){
			        	//alert("预存金额与确认金额不一致！");
			        	alert($("#getinternet0037").val());
			        	$("#confee").select();
			        	$("#confee").focus();
			        	return false;
			        }
			        Prefee=parseFloat(Prefee,10);
			        confee=parseFloat(confee,10);
			        var patrn=/^-?\d+\.{0,}\d{0,}$/; 
					 if (!patrn.exec(Prefee)){
					 	//alert("请输入正确的金额！");
					 	alert($("#getinternet0038").val());
					 	$("#Prefee").select();
					 	$("#Prefee").focus();
					 	return false;
					 }
					procparams += "&ycfee=";
					procparams += tsd.encodeURIComponent(Prefee);
					procparams += "&sfyc=";
					procparams += tsd.encodeURIComponent('Y');  
		        	}
		        //备注
		        var tBZZZ = $("#tBz").val();
		        procparams += "&zwbz=";
				procparams += tsd.encodeURIComponent(tBZZZ);
			}
			//工号
			var uuserid = $("#userid").val();
			procparams += "&uuserid=";
			procparams += tsd.encodeURIComponent(uuserid);
			//部门
			var udepart = $("#depart").val();
			procparams += "&udepart=";
			procparams += tsd.encodeURIComponent(udepart);
			//营业区域
			var userareaid = $("#userareaid").val(); 			
			procparams += "&userarea=";
			procparams += tsd.encodeURIComponent(userareaid);
			//区域营业厅
			var uarea = $("#area").val();
			procparams += "&uarea=";
			procparams += tsd.encodeURIComponent(uarea);	
			procparams +="&fsbm="+$("#fsbm").val();	
			
			var loginfo = $("#getinternet0385").val();
			loginfo += $("#getinternet0103").val();
			loginfo += $("#Dh_yhdang").val();
			loginfo += $("#getinternet0100").val()+":";
			loginfo += $("#Hth_hthdang").val();
			loginfo += $("#getinternet0074").val()+":";
			loginfo += $("#Yhlb_hthdang").val();
			loginfo += $("#getinternet0112").val()+":";
			loginfo += $("#Yhmc_yhdang").val();
			loginfo += $("#getinternet0341").val()+":";
			loginfo += $("#Yhdz_yhdang").val();
			loginfo = tsd.encodeURIComponent(loginfo);
			
			procparams+="&ywbz="+loginfo;
			if(tsd.Qualified()==false){return false;}	
			$("#selectinserttype").select();
			$("#selectinserttype").focus();
			//var result = fetchMultiPValue("phoneInstall.setup",6,procparams);
			//$("#Messagevalues").text("数据处理中，请稍等…………");
			$("#Messagevalues").text($("#getinternet0023").val());
			loadPopup();
			var status_succ = false;
			var result = new Array();
			var i = 0;
			var j = 0;
			var urll = tsd.buildParams({ packgname:'service',
						clsname:'Procedure',//类名
						method:'exequery',//方法名
						ds:'tsdBilling',
						tsdExeType:'query',//操作类型 
						datatype:'xml',//返回数据格式 
						tsdpname:'phoneInstall.setup'						
				});
//alert("==="+procparams);
			//执行发布请求，成功之后调用initResultInfo()方法显示结果
			$.ajax({
				url:"mainServlet.html?" + urll + procparams,
				async:true,
				cache:false,
				timeout:600000,
				type:'post',
				success:function(xml){
					$(xml).find("row").each(function(){
						result[i++] = new Array();
						$(this).find("cell").each(function(){
							result[i-1].push($(this).text());
						});
					});
					status_succ = true;
					if(result[0]==undefined || result[0][0]==undefined || result[0][0]=="")
					{
						//alert("开户失败");
						alert($("#getinternet0039").val());
						disablePopup();
					}
					else
					{
						disablePopup();
						//从procreturn表中查询失败原因
						var returnStr = result[0][1];
						if(returnStr==""||returnStr==null||returnStr==undefined){returnStr="00000000";}
						var resto = fetchSingleValue("dbsql_phone.procreturn",6,"&pname=ywsl_setup&key="+tsd.encodeURIComponent(returnStr));
						var languageType = $("#languageType").val();
						var strreutrn = getCaption(resto,languageType,"");
						strreutrn = strreutrn.replace("?hth?",$("#Hth_hthdang").val());
						 if(str=="1"){
						 	if(result[0][0]=='FAILED'){
						 		if(strreutrn==""){
						 			alert(result[0][1]);
						 			return false;
						 		}else{
						 			alert(strreutrn);
						 			return false;
						 		}
						 	}
						 	if(result[0][1]!=""&&result[0][1]!="SUCCSESS"){
								alert(result[0][1]);
								loginfo+=tsd.encodeURIComponent(result[0][1]);
							}
							$("#jobidid").val(result[0][0]);
							$("#ppaytype").val($("#fufeitype").val());//将付费方式付给隐藏于，打印报表会使用很关键
							$("#fee").val($("#yjfee").val());
							$("#Prefeeval").val($("#Prefee").val());
							writeLogInfo("","add",loginfo);
							//判断是否打印工单，从tsd_ini表中配置Y为打印
							printworkorder('p_setup');//script/telephone/business/businessreprint.js中
						}else{
							if(result[0][0]=='FAILED'){
								if(strreutrn==""){
									alert(result[0][1]);
								}else{
									alert(strreutrn);
								}
						 		return false;
						 	}
						 	$("#jobidid").val(result[0][0]);
							autoBlockForm("choosePrintJob","150","close","#FFFFFF",false);
						}
					}
					unLockDh();
					$("#currentHthSaved").val("N");
					$("#currentHthFirstOpen").val("Y");
					$("#currentCheckedHthBox").val("shhth");
					$("#StartDate_yhdang").attr("disabled","disabled");
					$("#EndDate_yhdang").attr("disabled","disabled");
					$("#Reg_Date").attr("disabled","disabled");
					Dhzj_Reset();					
				},
				complete:function()
				{
					if(!status_succ)
					//alert("操作失败");
					alert($("#getinternet0040").val());
					unLockDh();
					$("#currentHthSaved").val("N");
					$("#currentHthFirstOpen").val("Y");
					$("#currentCheckedHthBox").val("shhth");
					$("#StartDate_yhdang").attr("disabled","disabled");
					$("#EndDate_yhdang").attr("disabled","disabled");
					$("#Reg_Date").attr("disabled","disabled");
					Dhzj_Reset();
					disablePopup();
				}
			});	
        }         

       /********
        *调用过程，清除被锁定账号
        *@param;
       	*@return;
        ********/ 
	   function unLockDh()
	   {
	   		var userid = tsd.encodeURIComponent($("#userid").val());
	   		executeNoQueryProc("PhoneDH.ifCanSouLi",6,"&OperID=" + userid + "&Func=1");
	   		ClearTmpData();
	   }        
	   
	   function ClearTmpData()
	   {
	   		var userid = tsd.encodeURIComponent($("#userid").val());	   		
	   		executeNoQueryProc("PhoneService.POPEN",6,"&userid=" + userid);
	   }
	   
        /********
        *查询装机日期
        *@param;
       	*@return;
        ********/   
        function getZJtime()
        {
           var res = fetchMultiArrayValue("phonelnstalled.queryZJtime",6,"");
           var zjtime = res[0][0];
           $("#Reg_Date").val(zjtime);
           $("#Reg_Date_yhdang").val(zjtime);
           $("#StartDate_yhdang").val(zjtime);
        }        
               
        /********
        *生成付费类型下拉框
        *@param;
       	*@return;
        ********/
        function getfufeitype()
        {
           $("#fufeitype").empty();
           var querysel='';
		   var res = fetchMultiArrayValue("dbsql_phone.queryphoneconfigkemu",6,"&kemu=pbusinessfee&tsection=payitem");
				if(res[0]==undefined || res[0][0]==undefined)
        		{
        			return false;
        		}
        	for(var i=0;i<res.length;i++){
        		querysel+="<option value="+res[i][0]+" flf='"+res[i][2]+"'>"+res[i][1]+"</option>";
        	}
		   $("#fufeitype").html(querysel);
		   $("#fufeitype").val("tuoshou");		   	  
        }
        
        
        /********
        *查看是否选择单位合同号，如果选择者弹出窗口显示单位同好和单位名称进行选择
        *@param;
       	*@return;
        ********/
        function isnotdanwei()
        {
            $("#setdaijiao").val("N");
            $("#danweiHTHbox").attr("checked","checked");
            var danweiHTHbox = $("#danweiHTHbox").attr("checked");//查看是否被选择
            if(danweiHTHbox==true){
            DisplayHthForm();
            }else{
               $("#danweiHTHbox").attr("checked","");
               $("#danweiHTH").val("");
               $("#inputDWHTH").val("");//将隐藏域中的清空	
            }
        }
        
        /********
        *检测一次性费用是否有未选项
        *@param;
       	*@return;
        ********/
        function checkYCXFY()
        {
        	var addedXYW = $("#dhzftab tr:has('td')");
        	
        	var zfx = new Array();
        	var hasChecked = false;
        	
        	var checkYCX = $("#zafeilist");
        	$(":checkbox[fftype='2']",checkYCX).each(function(){
        		zfx.push($(this).val());
        		if($(this).is(":checked"))
        			hasChecked = true;
        	});
        	if(zfx.length>0 && hasChecked==false)
        	{
        		//alert(zfx.join(",") + " 必选一项");
        		alert(zfx.join(",") + $("#getinternet0387").val());
        		return false;
        	}
        	return true;
        }
        /********
        *设置代缴合同号，加载合同号信息，可对对应的代缴合同号进行设置；
        *@param;
       	*@return;
        ********/
        function setDJHTH()
        {
        	var phone = $("#Dh_yhdang").val();
        	var key = $("#businesstype").val();
        		if((phone==""&&key=="p_setup"&&$("#selectinserttype").val()=="1")||(key=="p_movewithoutarea"&&$.trim($("#chooseKH").val())=="")){
	        		alert($("#getnullphone").val());
	        		$("#getphone").select();
	        		$("#getphone").focus();
	        		return false;
        		}else if(phone==""&&(key=="p_movewithoutarea"||key=="p_hthchangename"||key=="p_editproperty"||key=="p_insteatof"||key=="p_changeuser")){
        			alert($("#getinternet0140").val());
        			return;
        		}
        	var hth = $("#hth").val();
        	if(hth==""){
        		//alert("请生成或选择一个合同号！");
        		alert($("#getinternet0025").val());
        		return false;
        	}
        	//用户类别
        	var cusertype = $("#Yhlb_hthdang option:selected").text();
        	if($("#Yhlb_hthdang").val()==""||cusertype==undefined)
        	{
        		//alert("请选择用户类别");
        		alert($("#getselectyhlb").val());
        		$("#usertype").select();
        		$("#usertype").focus();
        		return false;
        	}
        	getPayment();//生成代缴费用信息
        	//合同号信息
        	setXDJ('');
        }
                
        /********
        *设置单位合同号
        *@param;
       	*@return;
        ********/
        function setDJ()
        {
        	$("#setdaijiao").val("Y");
        	DisplayHthForm();
        }
        
        /********
        *查询代缴合同号，表格显示出来
        *@param;
       	*@return;
        ********/
        function setXDJ(key)
        {        	       
        	$("#dqueryHTHdw").empty();//每次查询前将以前的数据清空        	
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
            $("#querydjhthdh").empty(); 
            //ify += "<thead><tr><th style='width:100px'><center><h4>合同号</h4></center></th><th style='width:100px;'><center><h4>用户电话</h4><th style='width:170px;'><center><h4>用户名称</h4><th style='width:230px;'><center><h4>用户地址</h4></center></th></tr></thead>";
            for(var i=0;i<res.length;i++){
                ify +="<tbody>";
                ify += "<tr id=\""+res[i][0]+"\">";
				ify += "<td style=\"width: 100px;\"><center>";
				ify += res[i][0];
				ify += "</center></td>";
				ify += "<td width=\"100\"><center>";
				ify += res[i][1];
				ify += "</center></td>";
				ify += "<td width=\"170\"><center>";
				ify += res[i][2];
				ify += "</center></td>";
				ify += "<td width=\"210\"><center>";
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
        	var res = fetchMultiArrayValue(querykey,6,"&param="+tsd.encodeURIComponent(selecththcontent)+"&hth="+tsd.encodeURIComponent($("#hth").val()));
        	if(res[0]==undefined || res[0][0]==undefined)
			{	
				$("#dqueryHTHdw").append("<tr><td>"+$("#getinternet0366").val()+"</td></tr>");
				return false;
			}
            var ify="";
            $("#querydjhthdh").empty(); 
            //ify += "<thead><tr><th width=\"100px;height: 20px\"><center><h4>合同号</h4></center></th><th width=\"100px;height: 20px\"><center><h4>用户电话</h4><th width=\"170px;height: 20px\"><center><h4>用户名称</h4><th width=\"230px;height: 20px\"><center><h4>用户地址</h4></center></th></tr></thead>";
            for(var i=0;i<res.length;i++){
                ify +="<tbody>";
                ify += "<tr id=\""+res[i][0]+"\">";
				ify += "<td style=\"width: 100px;height: 20px\"><center>";
				ify += res[i][0];
				ify += "</center></td>";
				ify += "<td width=\"95\"><center>";
				ify += res[i][1];
				ify += "</center></td>";
				ify += "<td width=\"165\"><center>";
				ify += res[i][2];
				ify += "</center></td>";
				ify += "<td width=\"225\"><center>";
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
       
       	/********
        *确认代缴合同号信息提示框；
        *@param;
       	*@return;
        ********/
        function getdaijiaotishi(){
        	var languageType = $("#languageType").val();        		
				var resname = fetchFieldAlias('daijiao',languageType); 
            	var phone = $("#Dh_yhdang").val();            	
            	var strdj = "";
            	//strdj +="确认代缴：\n\n";
            	strdj +=$("#getinternet0043").val();            	
            	//strdj +="电话["+phone+"]的用户由:\n\n";  
            	strdj +=$("#getinternet0044").val()+phone+$("#getinternet0045").val();
            	for(var i=0;i<arrraydaijiaohth.length;i++){
            		if($("#"+arrraydaijiaohth[i]+"").val()!=""){            			         		
            			//strdj +=resname[arrraydaijiaohth[i]]+"["+$("#"+arrraydaijiaohth[i]+"").val()+"]缴纳！\n";
            			strdj +=resname[arrraydaijiaohth[i]]+"["+$("#"+arrraydaijiaohth[i]+"").val()+$("#getinternet0046").val();
            		}
            	}
            	alert(strdj);
        }
        
       	/********
        *生成并显示合同号面板
        *@param;
       	*@return;
        ********/
        function DisplayHthForm()
        {
        	$("#queryHTHdw").empty();//每次查询前将以前的数据清空
        	autoBlockForm('hthChooseForm',5,'close',"#ffffff",false);//弹出查询框
            var res = fetchMultiArrayValue("phonelnstalled.isnotdanweiHTH",6,"");
            if(res[0]==undefined || res[0][0]==undefined)
			{
				return false;
			}
            var ify="";
            ify += "<thead><tr><th width=\"200\"><center><h4>"+$("#getinternet0356").val()+"</h4></center></th><th width=\"400\"><center><h4>"+$("#getinternet0357").val()+"</h4></center></th></tr></thead>";
            for(var i=0;i<res.length;i++){
                ify +="<tbody>";
                ify += "<tr onClick=\"getHTHdanwei('"+res[i][0]+"')\" onDblClick=\"getinputHTH('"+res[i][0]+"')\" id=\""+res[i][0]+"\">";					
				ify += "<td style=\"width: 200px;height: 20px\"><center>";
				ify += res[i][0];
				ify += "</center></td>";
				ify += "<td width=\"400\"><center>";
				ify += res[i][1];
				ify += "</center></td>";
				ify +="</tr>";
				ify +="</tbody>";
            }
            $("#queryHTHdw").append(ify);
            //jQuery.page("page",5);
        }
        
        
        /********
        *点击选择合同号按钮，加载合同号并选择
        *@param;
       	*@return;
        ********/
        function selecthth(){
        	$("#selecththcontent").val("");//每次查询前清空查询条件
        	$("#selecththvalue").val("2");//每次查询前查询类型还原
        	var key = $("#businesstype").val();
        	var phone = $("#Dh_yhdang").val();
        	if((phone==""&&key=="p_setup"&&$("#selectinserttype").val()=="1")||(key=="p_movewithoutarea"&&$.trim($("#chooseKH").val())=="")){
        		alert($("#getnullphone").val());
        		$("#getphone").select();
        		$("#getphone").focus();
        		return false;
        	}
        	if(key=='p_movewithoutarea'||key=='p_changeuser'){
        		//电话号码
	        	var cphonenum = $("#Dh_yhdang").val();
	        	if(cphonenum==undefined || cphonenum=="")
	        	{
	        		//alert("请查询一个电话用户！");
	        		alert($("#getinternet0140").val());
	        		$("#ghSearchBox").select();
	        		$("#ghSearchBox").focus();
	        		return false;
	        	}
	        }
        	autoBlockForm('selecthth',5,'close',"#ffffff",false);//弹出查询框
        	$("#selecththkey").empty();//每次查询前将以前的数据清空  
            if($("#selecththarearight").val()=="false"){   	
        		var res = fetchMultiArrayValue("dbsql_phonelnstalled.selecththkeyparm",6,"&area="+tsd.encodeURIComponent($("#area").val()));
        	}else{
        		var res = fetchMultiArrayValue("dbsql_phonelnstalled.selecththkey",6,"");
        	}
        	if(res[0]==undefined || res[0][0]==undefined)
			{
				$("#selecththkey").append("<tr><td>"+$("#getinternet0366").val()+"</td></tr>");
				return false;
			}
            var ify="";
            for(var i=0;i<res.length;i++){
                ify +="<tbody>";
                ify += "<tr onClick=\"getHTHXZ('"+res[i][0]+"')\" onDblClick=\"getsavexzhth('"+res[i][0]+"')\" id=\""+res[i][0]+"\">";					
				ify += "<td style=\"width: 250px;height: 20px\"><center>";
				ify += res[i][0];
				ify += "</center></td>";
				ify += "<td width=\"250px;\"><center>";
				ify += res[i][1];
				ify += "</center></td>";
				ify += "<td width=\"500px;\"><center>";
				ify += res[i][2];
				ify += "</center></td>";
				ify +="</tr>";
				ify +="</tbody>";
            }
            $("#selecththkey").append(ify);
        }
        

        /********
        *选择合同号面板查询模糊查询时调用该方法
        *1为电话查询，2为合同号查询，3为名称查询
        *@param;
       	*@return;
        *********/
        function queryhthkey(){
        	var selecththvalue = $("#selecththvalue").val();
        	var selecththcontent = $("#selecththcontent").val();
        	if(selecththcontent.length==0){
        		//alert("请输入查询条件！");
        		alert($("#getinternet0041").val());
        		$("#selecththcontent").select();
        		$("#selecththcontent").focus();
        		return false;
        	}
        	var querykey="";
        	if(selecththvalue==""){
        		//alert("请选择查询类别！");
        		alert($("#getinternet0042").val());
        		return false;
        	}else if(selecththvalue=="1"){
        		  if($("#selecththarearight").val()=="false"){   	
		        		querykey="dbsql_phonelnstalled.selecththkey01dhparm";
		          }else{
		        		querykey="dbsql_phonelnstalled.selecththkey01dh";
		          }        		
        	}else if(selecththvalue=="2"){
        		if($("#selecththarearight").val()=="false"){   	
		        		querykey="dbsql_phonelnstalled.selecththkey02hthparm";
		          }else{
		        		querykey="dbsql_phonelnstalled.selecththkey02hth";
		          }        		
        	}else if(selecththvalue=="3"){
        		if($("#selecththarearight").val()=="false"){   	
		        		querykey="dbsql_phonelnstalled.selecththkey03mcparm";
		          }else{
		        		querykey="dbsql_phonelnstalled.selecththkey03mc";
		          }        		
        	}
        	$("#selecththkey").empty();//每次查询前将以前的数据清空
        	var res = fetchMultiArrayValue(querykey,6,"&param="+tsd.encodeURIComponent(selecththcontent)+"&area="+tsd.encodeURIComponent($("#area").val()));
        	if(res[0]==undefined || res[0][0]==undefined)
			{	
				$("#selecththkey").append("<tr><td>"+$("#getinternet0366").val()+"</td></tr>");
				return false;
			}
            var ify="";
            for(var i=0;i<res.length;i++){
                ify +="<tbody>";
                ify += "<tr onClick=\"getHTHXZ('"+res[i][0]+"')\" onDblClick=\"getsavexzhth('"+res[i][0]+"')\" id=\""+res[i][0]+"\">";					
				ify += "<td style=\"width: 250px;height: 20px\"><center>";
				ify += res[i][0];
				ify += "</center></td>";
				ify += "<td width=\"250\"><center>";
				ify += res[i][1];
				ify += "</center></td>";
				ify += "<td width=\"500\"><center>";
				ify += res[i][2];
				ify += "</center></td>";
				ify +="</tr>";
				ify +="</tbody>";
            }
            $("#selecththkey").append(ify);
        }
        
        
        /********
       	*工单票据打印
        *@param：flag 是否预览打印;
       	*@return;
        *********/
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
       		setTimeout($.unblockUI,15);
       		/*****
       		*获取付费类型pay_item表中的prtmodename字段的报表路径名，空为不答应票据
       		*****/
       		var res = fetchSingleValue("dbsql_phone.queryprtmodename",6,"&kemu=pbusinessfee&pay_name="+tsd.encodeURIComponent($("#ppaytype").val()));
       		$("#fufeitypepath").val(res);
       		if(res==""||res==undefined||res=="undefined")
       		{
       			setTimeout($.unblockUI,1);
       		}
       		else
       		{
       			var feevalue=$("#fee").val().replace(/(^\s*)|(\s*$)/g,"");
       			var Prefeeval = $("#Prefeeval").val().replace(/(^\s*)|(\s*$)/g,"");
       			if(feevalue==""){feevalue='0';}
       			if(Prefeeval==""){Prefeeval='0';}
       			if((feevalue!='0'&&Prefeeval!='0')||(feevalue!='0'&&Prefeeval=='0')||(feevalue=='0'&&Prefeeval!='0')){
       				setTimeout('autoBlockForm("choosePrint","150","close","#FFFFFF",false)',1050);
				}else{
					setTimeout($.unblockUI,1);
				}
       		}
       		$("#ppaytype").val("");
       	}

       	/********
       	*收费票据打印
        *@param：flag 是否预览打印;
       	*@return;
        *********/
       	function lsPrint(flag)
       	{       
       		/*****
       		*获取付费类型pay_item表中的prtmodename字段的报表路径名，空为不答应票据
       		*****/
       		var res = fetchSingleValue("dbsql_phone.queryprtmodename",6,"&kemu=pbusinessfee&pay_name="+tsd.encodeURIComponent($("#ppaytype").val()));     
       		if(res==""||res==undefined||res=="undefined")
       		{
       			setTimeout($.unblockUI,1);        			       		
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
	       		setTimeout($.unblockUI,15);
	       		$("#fufeitypepath").val("");
       		}
       	}
        

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

        /********
       	*弹出选择合同好面板 点击信息时调用该方法
        *@param：key 合同号值;
       	*@return;
        *********/
        function getHTHXZ(key){
		      $("#selecththvaluekey").val(key);//把得到的单位合同号添加到隐藏域中点击确定的时候在从隐藏域中取
		      $("#selecththkey tr").css('background-color','#ffffff');
		      document.getElementById(key).style.background='#0080FF';        
        }

        /********
       	*弹出选择合同号面板后进行合同号选择
        *@param;
       	*@return;
        *********/
		function getsavexzhth(key){
			var str="";
			if(key=="djsave"){								
				str = $("#selecththvaluekey").val();								
				if(str==""){
					//alert("请选择合同号！");
					alert($("#getinternet0047").val());
					return false;
				}
			}else{
				str=key;
			}		
			if($("#Hth_hthdang").val()==str){alert($("#getinternet0048").val());return false;}
			$("#hth").val(str);
			$("#Hth_hthdang").val(str);			
			$("#selecththvaluekey").val("");
			$("#selecththkey tr").css('background-color','#ffffff');
			$("#tablehthdang select").val("");
		    $("#tablehthdang :text").val("");  
			if($("#businesstype").val()=="p_setup"){
				$("#Hth_yhdang").val(str);
			}else{
				geththedite();//businesspublic.js中  自动加载显示框合同号可编辑的显示框
			}
			//取htt号信息信息
			 var res = fetchMultiArrayValue("Phoneinstalled.geththdangall",6,"&Hth="+str);
			 if(res[0]!=undefined||res[0][0]!=undefined){
			 	$("#Hth_hthdang").val(res[0][0]);
			 	$("#Dh_hthdang").val(res[0][1]);
			 	$("#Yhlb_hthdang").val(res[0][2]);			 	
			 	$("#usertype").val(res[0][2]);	 				 
			 	$("#ZnjBz_hthdang").val(res[0][4]);
			 	$("#Area_hthdang").val(res[0][5]);
			 	$("#sBm1").val(res[0][6]);			 	
			 	$("#sBm2").val(res[0][7]);			 	
			 	$("#sBm3").val(res[0][8]);			 	
			 	$("#sBm4").val(res[0][9]);			 	
			 	$("#CallPayType_hthdang").val(res[0][10]);
			 	$("#HthMfjb_hthdang").val(res[0][11]==undefined?"":res[0][11]);			 	
			 	$("#IDCard_hthdang").val(res[0][12]);
			 	$("#Yhmc_hthdang").val(res[0][13]);
			 	$("#CustType_hthdang").val(res[0][14]);//客户类型
			 	$("#CreditGrade_hthdang").val(res[0][15]);//信誉等级
			 	$("#CreditPoint_hthdang").val(res[0][16]);//信誉积分
			 	$("#Boss_Name_hthdang").val(res[0][17]);//法人代表
			 	$("#linkTel_hthdang").val(res[0][18]);//联系电话
			 	$("#FixCode_hthdang").val(res[0][19]);//传真号码
			 	$("#TradeType_hthdang").val(res[0][20]);//行业类型 
			 	$("#CompType_hthdang").val(res[0][21]);//单位类型
			 	$("#HomePage_hthdang").val(res[0][22]);//主页
			 	$("#Email_hthdang").val(res[0][23]);//邮件地址
			 	$("#Manageid_hthdang").val(res[0][24]);//营业执照			 	
			 	$("#Yhdz_hthdang").val(res[0][25]);//用户地址
			 	$("#Bz2_hthdang").val(res[0][26]);//是否大客户代收		
				$("#Bz3_hthdang").val(res[0][27]);//
				$("#Bz4_hthdang").val(res[0][28]);//
			 	if($("#businesstype").val()=="p_setup"){
			 		getyhxzstr("p_setup");
			 		$("#Yhxz_hthdang").val(res[0][3]);
				 	$("#Bm4_yhdang").val(res[0][9]);
				 	$("#Bm3_yhdang").val(res[0][8]);
				 	$("#Bm2_yhdang").val(res[0][7]);
				 	$("#Bm1_yhdang").val(res[0][6]);
				 	$("#UserType_yhdang").val(res[0][3]);
			 		$("#CustType_yhdang").val(res[0][14]);//客户类型yhdang
					$("#CreditGrade_yhdang").val(res[0][15]);//信誉等级yhdang
				 	$("#CreditPoint_yhdang").val(res[0][16]);//信誉积分yhdang
				 	$("#UserType_yhdang").val(res[0][3]);//用户性质yhdang
				 	$("#Mfjb_yhdang").val(res[0][11]==undefined?"":res[0][11]);
				 	queryFeename();//一次性费用				 	
				}else if($("#businesstype").val()=="p_changeuser"){
					getyhxzstr("p_movewithoutarea");
			 		$("#Yhxz_hthdang").val(res[0][3]);
					$("#Bm4_yhdang").val(res[0][9]);
				 	$("#Bm3_yhdang").val(res[0][8]);
				 	$("#Bm2_yhdang").val(res[0][7]);
				 	$("#Bm1_yhdang").val(res[0][6]);	
				}else{
					getyhxzstr("p_movewithoutarea");
			 		$("#Yhxz_hthdang").val(res[0][3]);
				}
			 }
			$("#geththsbm select").attr("disabled","disabled");
			$("#tablehthdang select").attr("disabled","disabled");
			$("#tablehthdang :text").attr("disabled","disabled");
			$("#tablehthdang_new select").attr("disabled","disabled");
			$("#tablehthdang_new :text").attr("disabled","disabled");			
			$("#Prefee").val("");
		  	$("#confee").val("");
		  	$("input[id^='precheck']").removeAttr("checked");		 
		  deleteHthYZ($("#userid").val(),res[0][0]);
			setTimeout($.unblockUI,15);
		}
		
		//通过用户类别来加载用户性质
       function getyhxzstr(key){
				var select = document.getElementById("yhxz_hidden");
				var array;		
				if(key=="p_setup"){
					$("#Yhxz_hthdang").empty();
					$("#UserType_yhdang").empty();				
					$("#Yhxz_hthdang").html($("#Yhxz_hthdang").html()+"<option value='' selected='true'>--"+$("#getinternet0365").val()+"--</option>");
					$("#UserType_yhdang").html($("#UserType_yhdang").html()+"<option value='' selected='true'>--"+$("#getinternet0365").val()+"--</option>");
				}else if(key=="p_movewithoutarea"){
					$("#Yhxz_hthdang").empty();
					$("#UserTypeyhdang").empty();
					$("#Yhxz_hthdang").html($("#Yhxz_hthdang").html()+"<option value='' selected='true'>--"+$("#getinternet0365").val()+"--</option>");
					$("#UserTypeyhdang").html($("#UserTypeyhdang").html()+"<option value=''>--"+$("#getinternet0365").val()+"--</option>");
				}		
				for(var i=1;i<=select.options.length;i++){
					var op=document.createElement("option");
					if(i<select.options.length){
						if(select.options[i].lvalue==""||select.options[i].lvalue==undefined){
							select.options[i].lvalue="";
						}
	  					op.value = select.options[i].lvalue;
	  					if(op.value=="undefined"||op.value==undefined||op.value==""){
	  						
	  					}else{
	  						array = op.value.split("|"); 				
	  						if(array[2]==$("#usertype").val()){
	  							if(key=="p_setup"){	  								
	  								$("#Yhxz_hthdang").html($("#Yhxz_hthdang").html()+"<option value="+array[0]+">"+array[0]+"</option>");
	  								$("#UserType_yhdang").html($("#UserType_yhdang").html()+"<option value="+array[1]+">"+array[0]+"</option>");
									if($("#usertype").val()=="2"){
										$("#Yhxz_hthdang").val("住宅");
										$("#UserType_yhdang").val("2")
									}else if($("#usertype").val()=="1"){
										$("#Yhxz_hthdang").val("办公");
										$("#UserType_yhdang").val("1")										
									}else{
										$("#Yhxz_hthdang").val("");
										$("#UserType_yhdang").val("")
									}
									$("#Yhxz_hthdang").html()
	  							}else if(key=="p_movewithoutarea"){
									$("#Yhxz_hthdang").html($("#Yhxz_hthdang").html()+"<option value="+array[0]+">"+array[0]+"</option>");
	  								$("#UserTypeyhdang").html($("#UserTypeyhdang").html()+"<option value="+array[1]+"  selected='true'>"+array[0]+"</option>");
	  							}	  							
	  						}
	  					}
	  				}
				}
			}
    
        /********
       	*得到弹出单位合同号信息选择后的合同号
        *@param： params合同号值;
       	*@return;
        *********/
		function getHTHdanwei(params)
		{
		      var inputDWHTH = params; 
		      $("#inputDWHTH").val(inputDWHTH);//把得到的单位合同号添加到隐藏域中点击确定的时候在从隐藏域中取
		      $("#queryHTHdw tr").css('background-color','#ffffff');
		      document.getElementById(params).style.background='#00ffff';
		 }
		 
		/********
       	*点击弹出单位合同号狂窗口保存
        *@param： inputDWHTH合同号值;
       	*@return;
        *********/
		function getinputHTH(inputDWHTH)
		{
		     var inputDWHTH = $("#inputDWHTH").val();//从隐藏域中得到单位合同号付给页面显示
		     $("#queryHTHdw tr").css('background-color','#ffffff');
		     
		     if($("#setdaijiao").val()!="Y")
		     {//付费合同号
		     	$("#danweiHTH").val(inputDWHTH);
		     }
		     else
		     {//代缴合同号
		     	$("#gfhth").val(inputDWHTH);
		     }
		     $("#inputDWHTH").val("");//获取后将隐藏域中的清空		     
		     setTimeout($.unblockUI,15);
		}
		function closeGB()
		{
		   setTimeout($.unblockUI,15);
		   $("#queryHTHdw tr").css('background-color','#ffffff');
		   $("#danweiHTHbox").attr("checked","");
		   $("#inputDWHTH").val("");//将隐藏域中的清空	
		   
			if($("#setdaijiao").val()!="Y")
		    {//付费合同号
		    	$("#danweiHTH").val("");
		    }
		    else
		    {//代缴合同号
		    	$("#gfhth").val("");
		    }
		}
                
        /********
       	*查询一次性费用项信息
        *@param;
       	*@return;
        *********/
		function queryFeename()
		{
			var array="";
			var ids="";
			var idsto="";
			var ywsltype="";
			var dhlxywtype = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=typecode&tablename=dhlx&key=lxmc='"+tsd.encodeURIComponent($("#Dhlx").val())+"'"); 
			if(dhlxywtype=="zx_phone"){
				ywsltype="p_setuptrunk";//装专线
			}else if(dhlxywtype=="gq_phone"){
				ywsltype="p_setupfibre";//装光纤
			}else if(dhlxywtype=="2m_phone"){
				ywsltype="p_setup2m";//装2M
			}else{
				ywsltype="p_setup";//装普通电话
			}
			var urlstr=tsd.buildParams({packgname:'service',//java包
				 					clsname:'ExecuteSql',//类名
				 					method:'exeSqlData',//方法名
				 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
				 					tsdcf:'mssql',//指向配置文件名称
				 					tsdoper:'query',//操作类型 
				 					datatype:'xmlattr',
				 					tsdpk:'phonelnstalled.queryyicixinfeename',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
				 					tsdUserID:'ture'
				 				});
                 $.ajax({
	              url:'mainServlet.html?'+urlstr+'&ywlx='+tsd.encodeURIComponent(ywsltype)+"&typeid="+'50',
	              datatype:'xml',
	              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
	              timeout: 1000,
	              async: false ,//同步方式
	              success:function(xml)
	              {     
		              $("#zafeilist").empty();
		              //alert($("#zafeilist").html());					              
		              $(xml).find('row').each(function(){
						  var FeeType=$(this).attr("feetype");
						  if(FeeType!=undefined)
						  {						  	  	
							  array=FeeType.split("~");							  
							  var kldsmcstatus = 0;//状态
							  for(i=0;i<array.length;i++)
							  {	
							      var strs = array[i];							      
							      // alert(strs);
							      var areaa_a = $("#userareaid").val();
								  if(areaa_a==null || areaa_a=="") areaa_a="a";
								  //alert("feetype:"+strs+"area:"+areaa_a+"usertype:"+$("#usertype option:selected").text()+"zff:"+getAddedXyw()+"userP:"+$("#UserProper option:selected").text());
								  areaa_a = tsd.encodeURIComponent(areaa_a);
								  var result = fetchMultiArrayValue("phonelnstalled.queryjiaonafeenameFilter",6,"&feetype='"+tsd.encodeURIComponent(strs)+"'&area="+ areaa_a + "&usertype=" + tsd.encodeURIComponent($("#usertype option:selected").text()));								  
							      if(result[0]==undefined || result[0][0]==undefined)
							      {
							      	  continue;
							      }
							      kldsmcstatus++;
							      strs = result[0][0];
							      //费用类型
							      var tytypee = result[0][2];
							      if(strs!="")
							      {
							      	  $("#inputtext2").show();//项目为空时显示此列表
							      	  $("#yjfee").val("");
							      	  executeNoQuery("dbsql_phone.deletebusinessfee",6,"&feetype="+tsd.encodeURIComponent(strs)+"&userid="+tsd.encodeURIComponent($("#userloginid").val()));//加载杂费前先删除杂费临时表信息							      	  	
								      //var checkBox="<div style='width:50%;text-align:left; height:25px; float:left;'><input " + (tytypee=="2"?"":"checked='checked'") + " fftype='"+tytypee+"' type='checkbox' onClick='feecheck()' name='checkbox' value='"+strs+"' style='width:15px; height:15px; border:0px;float:left; line-height:'/><span style='line-height:25px; padding-left:5px; float:left;'>"+strs+"</span></div>";
								      var checkBox="<div style='width:50%;text-align:left; height:25px; float:left;'><input fftype='"+tytypee+"' type='checkbox'  onClick=\"getcheckfee('"+strs+"');\" id='"+strs+"' name='checkbox' value='"+strs+"' style='width:15px; height:15px; border:0px;float:left; line-height:'/><span style='line-height:25px; padding-left:5px; float:left;'>"+strs+"</span></div>";
				                      $("#zafeilist").html($("#zafeilist").html()+checkBox);
				                      refreshbusinessfee();
			                      }else{
			                      	  $("#inputtext2").css("display","none");//项目为空时隐藏此列表
			                      }
			                      if(tytypee=="2")
			                      {
			                      	continue;
			                      }
							      if(kldsmcstatus==1)
							      {
							      	ids += "'"+tsd.encodeURIComponent(strs)+"'";
							      }
							      else
							      {
							      	ids += ",'"+tsd.encodeURIComponent(strs)+"'";
							      }
							  }
							  //queryAllfeiy(ids);
						  }
						});
			      }
			});
		 }

		/********
       	*查询电话费用合计
        *@param;
       	*@return;
        *********/
		function queryAllfeiy(ids){
		  if(ids!=undefined){
		    zfxfeename=ids.replace(new RegExp("'","g"),"");
		    zfxfeename=zfxfeename.replace(new RegExp(",","g"),"~");
		    if(ids=="") ids="'~'";
		    if(ids==undefined){$("#yjfee").attr("value","");}
		      var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'phonelnstalled.queryphonefeezh',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdUserID:'ture'
						 				});				
						 		$.ajax({
					              url:'mainServlet.html?'+urlstr+'&feetype='+ids,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){
					              $(xml).find('row').each(function(){	
								  var sunfee=$(this).attr("sunfee");
								     if(sunfee!="null"){								     	
								     	$("#yjfee").val(sunfee);
									    $("#fflsjfy").val(sunfee);
								     }else{
								       $("#yjfee").val("0.0");
								       $("#Paymoney").val("");
								      }
							      });
							     }
							});
			queryFeeInfo(zfxfeename);
			}else{
			$("#yjfee").val("0.0");
			$("#Paymoney").val("");
		    }
	    }
		
		/********
       	*根据杂费复选框的选择情况来对费用合计进行总计
        *@param;
       	*@return;
        *********/
        function feecheck()
        {        
          var str=document.getElementsByName("checkbox");
          var objarray=str.length;
          var chestr="";
          var chestrto="";
          for (i=0;i<objarray;i++)
          {
              if(str[i].checked == true)
              {              
               chestr=str[i].value;               
			   chestrto += "'"+tsd.encodeURIComponent(chestr)+"',";
			   var a =chestrto.substr(0,chestrto.length-1);
		       }
           }
           var ids = a;
           queryAllfeiy(ids);
        } 
        

        /********
       	*解析一次性费用显示在缴费项目中
        *@param;
       	*@return;
        *********/
        function queryFeeInfo(zfxfeename)
        {  
			var param = zfxfeename;
			var feei = $("#yjfee").val();			
			if(param==undefined){	
			   param="";
			}
			var arr = param.split("~");
			var sqlparam = arr.join("','");
			sqlparam = "'" + sqlparam + "'";			
			$("#reportparam").val(sqlparam);			
			var areaa_a = $("#userareaid").val();
			if(areaa_a==null || areaa_a=="") areaa_a="a";
			areaa_a = tsd.encodeURIComponent(areaa_a);
			var res = fetchMultiArrayValue("phonelnstalled.queryjiaonafeenameFilter",6,"&feetype="+sqlparam+"&area="+ areaa_a + "&usertype=" + tsd.encodeURIComponent($("#usertype option:selected").text()));				
			if(res[0]==undefined||res[0][0]==undefined)
			{
			 return "";
			}
			else
			{
				var temp = "";
				for(var j=0;j<res.length;j++)
				{										
						temp += ",";
						temp += res[j][0];
						temp += "：";
						temp += $("#sjfeevalue").val();
						temp += "元";								 
				}
				temp = temp.replace(",","");
			    $("#Paymoney").val(temp);	
				return temp;
			}			 
        } 
        
        //保存业务受理非到临时表businessfee_tmpnew
        function savebusinessfee(){
        	var params='';
        	var sjfeevaluekey = $("#sjfeevalue").val();
        	sjfeevaluekey=sjfeevaluekey.replace(/(^\s*)|(\s*$)/g,"");
        	if(sjfeevaluekey==""){sjfeevaluekey=0;}
        	sjfeevaluekey=parseFloat(sjfeevaluekey,10); 
        	var feenumbervalue = $("#feenumbervalue").val();
        	if(sjfeevaluekey==""){
        		//alert("请输入实际金额！");
        		alert($("#getinternet0049").val());
        		$("#sjfeevalue").select();
        		$("#sjfeevalue").focus();
        		return false;
        	}          	    	
        	var feenamevaluekey = $("#feenamevalue").val();        	       
        	var bz = $("#businessbz").val();
        	bz=bz.replace(/(^\s*)|(\s*$)/g,"");
        	params += "&fee="+sjfeevaluekey;
			params += "&feetype="+tsd.encodeURIComponent(feenamevaluekey);         	
        	params += "&bz="+tsd.encodeURIComponent(bz);
        	params += "&userid="+tsd.encodeURIComponent($("#userloginid").val());
        	var insertRes = executeNoQuery("dbsql_phone.addbusinessfee",6,params);
        	if(insertRes=="true" || insertRes==true)
        		{
        			//alert("添加数据成功");
        			$("#businessfee").empty();
        			querybusinessfee();
        			$("#yjfeehidden").val(sjfeevaluekey);
        			$("#businessfeevalue :text").val("");
        			refreshbusinessfee();
        			//writeLogInfo("","addfeetype",tsd.encodeURIComponent("一次性费用添加日志:(费用类型："+feenamevaluekey+")(添加人员："+$("#userloginid").val()+")(业务类型：电话装机)"));
        			writeLogInfo("","addfeetype",tsd.encodeURIComponent($("#getinternet0388").val()+feenamevaluekey+")("+$("#getinternet0389").val()+"："+$("#userloginid").val()+")("+$("#getinternet0390").val()+")"));
        			closeGB();
        		}
        		else
        		{
        			//alert("添加数据失败");
        			alert($("#getinternet0017").val());
        			refreshbusinessfee();   
        			removecheckbusi();     			
        			closeGB();
        		}        		
        		$("#businessfeevalue :text").val("");
        }
        
        //删除临时表业务费
        function removecheckbusi(){
        	var fvalue = $("#feenamevalue").val();
        	if($("#"+fvalue+"").attr("checked")){
        		$("#"+fvalue+"").removeAttr("checked");
        	}
        	//feecheck();
        	closeGB();
        }
        
        //保存业务受理非到临时表businessfee_tmpnew
        function deletebusinessfee(feetype){
        	var params='';
			params += "&feetype="+tsd.encodeURIComponent(feetype); 
        	params += "&userid="+tsd.encodeURIComponent($("#userloginid").val());
        	var insertRes = executeNoQuery("dbsql_phone.deletebusinessfee",6,params);
        	if(insertRes=="true" || insertRes==true)
        		{
        			//alert("删除数据成功");
        			//alert($("#getinternet0050").val());
        			$("#businessfeevalue :text").val("");
        			$("#businessfee").empty();
        			refreshbusinessfee();
        			//writeLogInfo("","deletefeetype",tsd.encodeURIComponent("一次性费用删除日志:(费用类型："+feetype+")(删除人员："+$("#userloginid").val()+")(业务类型：电话装机)"));
        			writeLogInfo("","deletefeetype",tsd.encodeURIComponent($("#getinternet0391").val()+feetype+")("+$("#getinternet0392").val()+"："+$("#userloginid").val()+")("+$("#getinternet0390").val()+")"));
        		}
        		else
        		{
        			//alert("删除数据失败");
        			//alert($("#getinternet0051").val());
        			$("#"+feetype+"").attr("checked","checked");
        		}
        		$("#businessfeevalue :text").val(""); 
        	querybusinessfee();	       	
        }
        
        //从临时表获取金额合计
        function querybusinessfee(){
        	var res = fetchMultiArrayValue("phonelnstalled.querybusinesssumfee",6,"&userid="+tsd.encodeURIComponent($("#userloginid").val()));
        	if(res[0]==undefined||res[0][0]==undefined)
			{
				 return "";
			}
			else
			{
			 $("#yjfee").val(res[0][0]);
			}
        }
        
        function getcheckfee(key){
        	if($("#"+key+"").attr("checked")){
	        	var areaa_a = $("#userareaid").val();
				if(areaa_a==null || areaa_a=="") areaa_a="a";
				areaa_a = tsd.encodeURIComponent(areaa_a);
				var res = fetchMultiArrayValue("phonelnstalled.queryjiaonafeenameFilter",6,"&feetype="+tsd.encodeURIComponent("'"+key+"'")+"&area="+ areaa_a + "&usertype=" + tsd.encodeURIComponent($("#usertype option:selected").text()) + "&userproperty=" + tsd.encodeURIComponent($("#Yhxz option:selected").text()));			
				if(res[0]==undefined||res[0][0]==undefined)
				{
				 return "";
				}
				else
				{
					//是否可以更改应缴费项的金额，通过权限来实现	
					if($("#yjfeeright").val()=="true"){
						  $("#sjfeevalue").val("");
						  $("#feenamevalue").val(res[0][0]);
						  $("#feenumbervalue").val(res[0][1]);
						  autoBlockForm('editbusinessfee',5,'close',"#ffffff",false);//弹出查询框
					}else{
							if(res[0][1]==""||res[0][1]=="0"){
								//alert("该费用没有金额！");
								alert($("#getinternet0052").val());
								$("#"+res[0][0]+"").removeAttr("checked");
								return false;
							}
							var params='';
							params += "&fee="+res[0][1];
							params += "&feetype="+tsd.encodeURIComponent(res[0][0]);
							params += "&userid="+tsd.encodeURIComponent($("#userloginid").val());
							var insertRes = executeNoQuery("dbsql_phone.addbusinessfee",6,params);
							if(insertRes=="true" || insertRes==true)
							{
								//alert("添加数据成功");
								$("#businessfee").empty();
								$("#businessfeevalue :text").val("");								
								refreshbusinessfee();
								//writeLogInfo("","addfeetype",tsd.encodeURIComponent("一次性费用添加日志:(费用类型："+res[0][0]+")(添加人员："+$("#userloginid").val()+")(业务类型：电话装机)"));
								writeLogInfo("","addfeetype",tsd.encodeURIComponent($("#getinternet0388").val()+$("#feenamevalue").val()+")("+$("#getinternet0389").val()+"："+$("#userloginid").val()+")("+$("#getinternet0390").val()+")"));
								closeGB();
							}else{
								     	//alert("添加数据失败");
								     	alert($("#getinternet0017").val());
								     	refreshbusinessfee();
								     	removecheckbusi();
							}
							querybusinessfee();
					}										
				}
			}else{
				deletebusinessfee(key);
			}
        }
        
        
        
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
		       var ee="<option value='"+res[i][0]+"' flf='"+res[i][2]+"' title='"+res[i][1]+"'>"+res[i][1]+"</option>";	
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
           		//alert("请选择一个电话空号！");
           		alert($("#getnullphone").val());
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
		///////////////////////////////////////////上面都是后来添加的2010-11-08 星期一/////////////////////////////////////////////////////////////////
		
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
        		//alert("请选择代缴费用项！");
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
        		Paymentfee=parseFloat(Paymentfee,10);
        		Paymentrate=parseFloat(Paymentrate,10);
        		if(Paymentfee!=0&&Paymentrate>100){
        			//alert("代缴比例不能大于该金额的费用全部！");
        			alert($("#getinternet0062").val());
        			return false;
        		}
        		var cont=fetchSingleValue("dbsql_phone.queryPaymentinsteaditem",6,"&Paymentfeename="+tsd.encodeURIComponent($("#phonePaymentfeename").val())+"&dh="+dh);
        		cont = parseInt(cont);
        		if(cont!=0)
        		{
        			//alert("代缴费用\"" + $('#phonePaymentfeename option:selected').text() + "\"已经存在，不能重复添加");
        			alert($("#getinternet0063").val() + $('#phonePaymentfeename option:selected').text() + $("#getinternet0014").val());
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
				phone="0000000";
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
				ify += "<input type=\"checkbox\" id=\"v_Payment_checks" + i + "\"/>";
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
        	var checkedBytc = $("input[id^='v_Payment_checks']:checked");
        	var count = $(checkedBytc).size();
        	if(count<1)
        	{
        		//alert("请选择要代缴设置费用项");
        		alert($("#getinternet0058").val());
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
		//////////////////////////////////////////////////////////////////////////////////////////////
		
		/********
		* 加载下拉数据函数集		
		* @parme
 		* @return；   
 		*********/
		function zfangfa(){    
			gettable();//默认加载固定费跟包月费显示框  	            	   
		    getfufeitype();//付费类型				
		    queryFeename();
		    getZJtime();
		    Bytc_Refresh();
		    addspeediFeeType('');		
		    addspeediFeeType_hth('');		    
		    getPackaggroupid(); //包月套餐组		    		    	
			//-getPort();//传输介质
			//-getModual();//专线类型
        }                
		
		/**********************
		*开户和修改属性的合同号信息跟固话信息自动加载，并可对必选项进行配置
		*@arraybtfield全局变量@arrraydaijiaohth全局变量
		***********************/
		//全局变量arraybtfield 自动加载取出必选项放到该数组中，提交的时候判断哪些为必选；		
	    var arraybtfield = [];
	    //全局变量arrraydaijiaohth 在加载的时候把所有字段放到该数组，保存提示判断时用到
	    var arrraydaijiaohth = [];
        //字段名国际化
        function internation(){
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
					    sdhlx = sdhlx.substring(sdhlx.indexOf('</option>')+9,sdhlx.length);//huoshuai 2014-06-30 add ge bie chu li
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
					    $("#tablehthdang").html($("#tablehthdang").html()+tablehthdang);
					    $("#tableyhdang").html($("#tableyhdang").html()+tableyhdang);
					    $("#CallPayType_hthdang").html(CallPayType);
					    $("#usertype").html(syhlb);	
					    $("#Yhlb_hthdang").html(yhlb_text);
					    $("#Dhlx").html(sdhlx);	
					    $("#Dhlx").val($("#getinternet0363").val());
					    $("#CallPayType_hthdang").html(CallPayType);		
					    $("#ZnjBz_hthdang").html(ZnjBz);
					    //$("#Area_hthdang").html("<option value='1'>是</option>"+Area);
					    $("#Area_hthdang").html(Area);
					    $("#Bz3_yhdang").html(Area);
					    $("#CustType_yhdang").html(CustType);
						$("#CustType_hthdang").html(CustType);
						$("#Yhxz_hthdang").html(yhxz);
						$("#UserType_yhdang").html(yhxz);
						$("#yhxz_hidden").html(yhxz);
						$("#AdjustSheduleNo_yhdang").html(AdjustSheduleNo);
						$("#CallSheduleNo_yhdang").html(CallSheduleNo);
						//$("#Dhgn_yhdang").html(dhgn);						
						//根据系统表获取项目名称来处理不同的操作
						var ProjectType = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=tvalues&tablename=tsd_ini&key=tsection='system' and tident='customer'");
						if(ProjectType=="zhongyuanyoutian"){
							$("#YwArea_yhdang").html(ywarea);//ywarea中原油田区域为ywarea
						}else if(ProjectType=="yimei"){
							$("#YwArea_yhdang").html(Area);//areayima区域为area
						}else{
							$("#YwArea_yhdang").html(ywarea);//ywarea中原油田区域为ywarea
						}						
						$("#Bz6_yhdang").html(idtype);
						$("#Bz2_hthdang").html($("#Bz2_hthdang").html()+"<option value='N' selected='true'>"+$("#getinternet0355").val()+"</option>"+"<option value='Y'>"+$("#getinternet0354").val()+"</option>");
						$("#phonefeetype").html(ghfeetype);
						$("#Packaggroupid").html(bytcfeetype);
						var resDhgn = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&tablename=tsd_ini&cloum=tvalues&key=tsection='phonebusiness' and tident='dhgn_xgn'"); 
						$("#Hcqx_yhdang").html(dhgn);
						$("#newDhgn").html(dhgn);
						var reshthattach = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&tablename=attachprice_hth&cloum=feecode,feename&key=1=1"); 
						if(reshthattach!=undefined){
							attachprice_hth_text="<option value=''>--请选择--</option>";
							for(var i=0;i<reshthattach.length;i++){
									attachprice_hth_text+="<option value='"+reshthattach[i][0]+"'>"+reshthattach[i][1]+"</option>";
							}	
							$("#phonefeetype_hth").html(attachprice_hth_text);
						}						
						$("#Dhgn_yhdang").html(dhgn);
						/*
						$("#Dhgn_yhdang").focus(function(){
							autoBlockForm('querysTfDhgn',5,'close',"#ffffff",false);//弹出面板							
						});
						*/
						//专线线路信息
						/*
						var restrunkline = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&tablename=trunkline&cloum=linenode,linename&key=1=1"); 
						if(reshthattach!=undefined){
							truncstr="<option value=''>--请选择--</option>";
							for(var i=0;i<restrunkline.length;i++){
									truncstr+="<option value='"+restrunkline[i][1]+"'>"+restrunkline[i][1]+"</option>";
							}	
							$("#Bz1_yhdang").html(truncstr);
						}	
						*/	
						var resbutetype = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&tablename=dhbute&cloum=typename,typename&key=1=1"); 
						if(resbutetype!=undefined){
							butetype="<option value=''>--请选择--</option>";
							for(var i=0;i<resbutetype.length;i++){
									butetype+="<option value='"+resbutetype[i][1]+"'>"+resbutetype[i][1]+"</option>";
							}	
							$("#Bz4_yhdang").html(butetype);
						}
						$("#Bz5_yhdang").html("<option value='局端'>局端</option><option value='远端'>远端</option>");
						lodingset();//字段属性加载完执行该方法进行对编辑框操作
					}		
				});
             
          //固话信息
          var res = fetchFieldAlias('yhdang',languageType);                            
          $("#spanhth").text(res['Hth']);//合同号
          $("#spandh").text(res['Dh']);//电话
          $("#spangetdh").text(res['Dh']);//获取空号电话
          $("#spanBm1").text(res['Bm1']);//一级部门
          $("#spanBm2").text(res['Bm2']);//二级部门
          $("#spanBm3").text(res['Bm3']);//三级部门
          $("#spanBm4").text(res['Bm4']);//四级部门

          var rese = fetchFieldAlias('attachfee',languageType);
          $("#spanFeeCode").text(rese['FeeCode']);//费用代号
          $("#spanFeeName").text(rese['FeeName']);//费用名称
          $("#spanFeeType").text(rese['FeeType']);//子类型
          $("#spanPrice").text(rese['Price']);//价格
          $("#spanTjPrice").text(rese['TjPrice']);//停机价格
          $("#spanStartMonth").text(rese['StartMonth']);//起始有效月
          $("#spanEndMonth").text(rese['EndMonth']);//截至有效月
          $("#spanStartDate").text(rese['StartDate']);//起始极佳日
          $("#spanEndDate").text(rese['EndDate']);//截至计价日
          //显示表格标头的国际化
          $("#spanFeeCode_table").text(rese['FeeCode']);//费用代号 
          $("#spanFeeName_table").text(rese['FeeName']);//费用名称
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
        }  
        
        //有些是必须只读的
        function getdisabled()
        {
           $("#phone").attr("disabled","disabled");
           $("#phoneBalance").attr("disabled","disabled");
           $("#mothshuafei").attr("disabled","disabled");
           $("#TJLogo").attr("disabled","disabled");
           $("#qjtkj").attr("disabled","disabled");
           $("#StartDate_yhdang").attr("disabled","disabled");
           $("#EndDate_yhdang").attr("disabled","disabled");
           $("#Reg_Date").attr("disabled","disabled");
           $("#MokuaiJu_yhdang").attr("disabled","disabled");
           //$("#TrafficLevel").attr("disabled","disabled");
           $("#SwitchNumber").attr("disabled","disabled");           
           $("#Area").attr("disabled","disabled");
           $("#ZnjBz").attr("disabled","disabled");
           $("#Jflb_yhdang").attr("disabled","disabled");           
           $("#CallPayType").attr("disabled","disabled");
           $("#CallSheduleNo_yhdang").attr("disabled","disabled");
           $("#AdjustSheduleNo_yhdang").attr("disabled","disabled");
           $("#Mfjb").attr("disabled","disabled");
           $("#YwArea_yhdang").attr("disabled","disabled");
        }
        
        function il18nDWDJ()
        {
        	var languageType = $("#languageType").val();   
        	var i18n = fetchFieldAlias("daijiao",languageType);
        	$("#span_shhth").text(i18n["shhth"]);
        	$("#span_bdhth").text(i18n["bdhth"]);
        	$("#span_cthth").text(i18n["cthth"]);
        	$("#span_iphth").text(i18n["iphth"]);
        	$("#span_xxthth").text(i18n["xxthth"]);
        	$("#span_swhth").text(i18n["swhth"]);
        	$("#span_yzhth").text(i18n["yzhth"]);
        	$("#span_xywhth").text(i18n["xywhth"]);
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
        
        /**
        *提交yhdang数据时 判断必选项是否为空
        **/
        function Judgefield_yhdang(tjfield){
        	var boolean = false;
        	var arraybtfield = [];
        	var mustitem_yhdang = $("#mustitem_yhdang").val();
        	arraybtfield = mustitem_yhdang.split("|");
        	for(var i=0;i<arraybtfield.length;i++){        		
        		if(tjfield==arraybtfield[i]){
        			boolean = true;
        			break;
        		}
        	}
        	return boolean;
        }
       
       /**
       *相同字段值同上
       **/
       function getPublicfield(){
       		$("#Yhmc_yhdang").val($("#Yhmc_hthdang").val());
       		$("#Bm1_yhdang").val($("#sBm1").val());
       		$("#Bm2_yhdang").val($("#sBm2").val());
       		$("#Bm3_yhdang").val($("#sBm3").val());
       		$("#Bm4_yhdang").val($("#sBm4").val());
       		$("#Mfjb_yhdang").val($("#HthMfjb_hthdang").val());
       		$("#CustType_yhdang").val($("#CustType_hthdang").val());
       		$("#CreditGrade_yhdang").val($("#CreditGrade_hthdang").val());
       		$("#CreditPoint_yhdang").val($("#CreditPoint_hthdang").val());
       		$("#UserType_yhdang").val($("#Yhxz_hthdang option:selected").text());
       		$("#Bz9_yhdang").val($("#linkTel_hthdang").val());
       		$("#Yhdz_yhdang").val($("#Yhdz_hthdang").val());
       		$("#Bz7_yhdang").val($("#IDCard_hthdang").val());       		
       }
       
       
      /**
      *从内存取数据加载到页面中
      **/
      //部门加载
      function getDefaultHthByBm()
		{
			var sbm = $("#Bm1_yhdang").val();
			var cusertype = $("#usertype").val();
			if(cusertype=="1")
			{
				var hhth = fetchSingleValue("phonelnstalled.installhth",6,"&deptname=" + tsd.encodeURIComponent(sbm));
				if(hhth!=undefined && hhth!="")
				{
					$("#yzhth").val(hhth);
					return false;
				}
			}
			$("#yzhth").val("");
		}
		
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
			/*
            if($("#usertype option:selected").text()!=$("#getinternet0384").val()){
						//alert("只有公费用户可以选择一级部门！");
						alert($("#getinternet0065").val());
						$("#sBm1").val("");
						$("#sBm2").val("");
						$("#sBm3").val("");
						$("#sBm4").val("");
						$("#Bm1_yhdang").val("");
						$("#Bm2_yhdang").val("");
						$("#Bm3_yhdang").val("");
						$("#Bm4_yhdang").val("");
						return false;
			}
			*/
            //$("#querysBmtitle").text("选择一级部门");
            $("#querysBmtitle").text($("#getinternet0368").val());
	        $("#bmtypekey").val("Bm1");
	        autoBlockForm('querysBm',5,'close',"#ffffff",false);//弹出查询框	     	
			$("#querybmcontext").empty();
			var res = fetchMultiArrayValue("dbsql_phone.querysBm",6,"");
        	if(res[0]==undefined || res[0][0]==undefined)
			{
				$("#querybmcontext").append("<tr><td>"+$("#getinternet0366").val()+"</td></tr>");
				$("#sbmname").val("");
				return false;
			}
			$("#hth").val("");
            $("#Hth_hthdang").val("");
            //这里只正对装机来清空yhdang中的合同号，其他业务只操作合同号区域信息，所以不需要清空hthdang中的合同号；
			if($("#businesstype").val()=="p_setup"){
            	$("#Hth_yhdang").val("");
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
		      $("#querybmcontext tr").css('background-color','#ffffff');
		      document.getElementById(keycode).style.background='#0080FF';  
        }
        
        //点击保存部门按钮
        function savesBm(){
        	var sbmname = $("#sbmname").val();
        	var sbmtypekey = $("#bmtypekey").val();
        	if(sbmname==""){
        		//alert("请选择部门！");
        		alert($("#getinternet0367").val());
        		return false;
        	}
        	var sbmcode = $("#sbmcode").val();
        	if(sbmtypekey=="Bm1"){
        		$("#sBm1").val(sbmname);        		
        		$("#sBm1code").val(sbmcode);
        		$("#sBm2").val("");
        		$("#sBm3").val("");
        		$("#sBm4").val("");
        		if($("#businesstype").val()=="p_setup"){
        			$("#Bm1_yhdang").val(sbmname);
        			$("#Bm2_yhdang").val("");
        			$("#Bm3_yhdang").val("");
        			$("#Bm4_yhdang").val("");
        		}
        	}else if(sbmtypekey=="Bm2"){
        		$("#sBm2").val(sbmname);        		
        		$("#sBm2code").val(sbmcode);
        		$("#sBm3").val("");
        		$("#sBm4").val("");
        		if($("#businesstype").val()=="p_setup"){
        			$("#Bm2_yhdang").val(sbmname);
        			$("#Bm3_yhdang").val("");
        			$("#Bm4_yhdang").val("");
        		}
        	}else if(sbmtypekey=="Bm3"){
        		$("#sBm3").val(sbmname);         		
        		$("#sBm3code").val(sbmcode);       		
        		$("#sBm4").val("");
        		if($("#businesstype").val()=="p_setup"){
        			$("#Bm4_yhdang").val("");
        			$("#Bm3_yhdang").val(sbmname);
        		}
        	}else if(sbmtypekey=="Bm4"){
        		$("#sBm4").val(sbmname);
        		if($("#businesstype").val()=="p_setup"){
        			$("#Bm4_yhdang").val(sbmname);
        		}
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
           		alert($("#getinternet0368").val());
           		return false;
           	}
           $("#hth").val("");
           $("#Hth_hthdang").val("");
           if($("#businesstype").val()=="p_setup"){
           	  $("#Hth_yhdang").val("");
           }
           //$("#querysBmtitle").text("选择二级部门");           
           $("#querysBmtitle").text($("#getinternet0369").val());
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
			$("#hth").val("");
            $("#Hth_hthdang").val("");
            //这里只正对装机来清空yhdang中的合同号，其他业务只操作合同号区域信息，所以不需要清空hthdang中的合同号；
			if($("#businesstype").val()=="p_setup"){
            	$("#Hth_yhdang").val("");
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
        /*function addsBmsanhth(){
          var sBM='';
          if($("#sBm2").val()==""){
          	//alert("请选择二级部门");
          	alert($("#getinternet0370").val());
          	return false;
          }
          //$("#querysBmtitle").text("选择三级部门");
          $("#querysBmtitle").text($("#").val());
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
			$("#hth").val("");
            $("#Hth_hthdang").val("");
            //这里只正对装机来清空yhdang中的合同号，其他业务只操作合同号区域信息，所以不需要清空hthdang中的合同号；
			if($("#businesstype").val()=="p_setup"){
            	$("#Hth_yhdang").val("");
            }		
			for(var i=0;i<res.length;i++){
				sBM += "<tr onClick=\"getbmname('"+res[i][1]+"');getbmcode('"+res[i][0]+"');\" id=\""+res[i][0]+"\"><td><center>";
				sBM += res[i][1];
				sBM += "</center></td></tr>";
			}
			$("#querybmcontext").append(sBM);
			$("#querybmcontext tr").css("line-height","25");
			$("#sbmname").val("");
        }*/	 
        
        /****
		*得到部门库中的第四级部门
		****/
        function addsBmsihth(){          
          var sBM='';
          if($("#sBm3").val()==""){
          	//alert("请选择三级部门");
          	alert($("#getinternet0372").val());
          	return false;}
          //$("#querysBmtitle").text("选择四级部门");	
          $("#querysBmtitle").text($("#getinternet0373").val());
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
			$("#hth").val("");
            $("#Hth_hthdang").val("");
            //这里只正对装机来清空yhdang中的合同号，其他业务只操作合同号区域信息，所以不需要清空hthdang中的合同号；
			if($("#businesstype").val()=="p_setup"){
            	$("#Hth_yhdang").val("");
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
         
         /////地址选择
		 function c_p_address()
		 {
			var ctrr = $("#Yhdz_yhdang");
			$(ctrr).focus(function(){c_p_address_fun();});
		 }
	
		 /////地址选择
		 function c_p_address_fun()
		 {
			if($("#c_p_address").size()<1)
			{
				$("#Yhdz_yhdang").after("<div id=\"c_p_address\"></div>");
			}
			var left = $("#Yhdz_yhdang").offset().left-80;
			var top = $("#Yhdz_yhdang").offset().top + 25;
			//alert($("#sAddress").parent().offset().left);
			$("#c_p_address").css({'position':'absolute','left':left,'top':top,'background-color':'#FFFFFF','border':'#99ccff 1px solid','height':'112px','width':'750px'});
			$("#c_p_address").empty();		
			var address_tab="<table id=\"address_tab\" style=\"\">";
			address_tab += "<tr><td colspan=\"6\"><h4>"+$("#getinternet0374").val()+"</h4></td></tr>";
			address_tab += "<tr><td>"+$("#getinternet0375").val()+"</td><td><select id=\"c_p_address_xq\"><option value=\"\">--"+$("#getinternet0365").val()+"--</option></select></td><td>"+$("#getinternet0376").val()+"</td><td><select id=\"c_p_address_ld\"><option value=\"\">--"+$("#getinternet0365").val()+"--</option></select></td><td>"+$("#getinternet0377").val()+"</td><td><select id=\"c_p_address_dy\"><option value=\"\">--"+$("#getinternet0365").val()+"--</option></select></td><td>"+$("#phone.getinternet0378").val()+"</td><td><select id=\"c_p_address_mp\"><option value=\"\">--"+$("#getinternet0365").val()+"--</option></select></td></tr>";
			address_tab += "<tr><td><button id=\"c_p_address_bnok\" class=\"tsdbutton\" style=\"line-height:20px;\">"+$("#getinternetSave").val()+"</button></td><td colspan='2'><button id=\"c_p_address_add\" onclick=\"addnewinfo()\" class=\"tsdbutton\" style=\"line-height:20px;\">"+$("#getinternet0379").val()+"</button></td><td><button id=\"c_p_address_bncancel\" class=\"tsdbutton\" style=\"line-height:20px;\">"+$("#getinternet0084").val()+"</button></td><td></td><td></td><td></td><td></td></tr>";
			address_tab += "</table>";
			$("#c_p_address").append(address_tab);
			var userareaid = $("#YwArea_yhdang option:selected").text();	
			var addr = $("select[id='c_p_address_seluserarea'] :selected").html();
			c_p_bindToAddr(1,"c_p_address_xq","&addrarea=" + tsd.encodeURIComponent(userareaid));							
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
					c_p_bindToAddr(1,"c_p_address_xq","&addrarea=" + tsd.encodeURIComponent(addr));
				}
			});
				    
			$("#c_p_address_xq").change(function(){
				//alert($("#c_p_address_xq").val()); 
				var addr = $("#c_p_address_xq").val();
				if(addr!="")
				{
					c_p_bindToAddr(2,"c_p_address_ld","&addr=" + $("#c_p_address_xq").val());
				}
			});
			
			$("#c_p_address_ld").change(function(){
				//alert($("#c_p_address_xq").val()); 
				var addr = $("#c_p_address_ld").val();
				if(addr!="")
				{
					c_p_bindToAddr(3,"c_p_address_dy","&addr=" + $("#c_p_address_ld").val());
				}
			});
			
			$("#c_p_address_dy").change(function(){
				//alert($("#c_p_address_xq").val()); 
				var addr = $("#c_p_address_dy").val();
				if(addr!="")
				{
				 c_p_bindToAddr(4,"c_p_address_mp","&addr=" + addr);
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
							//alert("请继续选择下一级地址","操作提示");
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
					$("#Yhdz_yhdang").val(info);
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
			    var userarea = $("#userareaid").val();
				var res = fetchMultiArrayValue("AddressBox.query"+idx,6,param+"&addrarea="+tsd.encodeURIComponent(userarea));
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
        	    if(addrto!=null&&addrto!=""){
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
        	
           //限制地址不能手动输入只能选择 地址输入框keyup
           function notecheck()
           {
			 	var notecheck = $("#Yhdz_yhdang").val();
			    if(notecheck.length>0){
			    	 $("#Yhdz_yhdang").val(notecheck.substr(0,0));
			    }
		   }
		  //点击添加地址按钮，弹出添加地址框  
		  function addnewinfo()
		  {
				var groupid = $('#zid').val();
				window.showModalDialog('mainServlet.html?pagename=telephone/linemanagement/addressManage.jsp&imenuid=1085&pmenuname=号线管理 &imenuname=地址库管理&groupid='+groupid+'&returnhide=NO',window,"dialogWidth:820px; dialogHeight:650px; center:yes; scroll:yes");
		  }
		  
		 /************
		 *选择用户所在区域
		 *@params;
		 *@return;
		 ************/ 		 
         var uareato="";
         function getuserareato()
         {
         	uareato+="<option value='' selected=true>"+$("#getinternet0365").val()+"</option>";
            var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'adduser.getuserarea'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});										
			                $.ajax({
					              url:'mainServlet.html?'+urlstr,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){	
					              uareato="";
					              $("#seluserarea").empty();			       
					                $(xml).find('row').each(function(){	
					                  var xuhao = $(this).attr("xuhao");
					                  var ywarea = $(this).attr("ywarea");
					                  if(ywarea!=undefined){
							            var ee="<option value='"+xuhao+"'>"+ywarea+"</option>";
							            uareato=uareato+ee;								       
								      }
							        });				       						        
							        $("#seluserarea").html($("#seluserarea").html()+uareato);							       
							      }
							});
          }
          
        /*******
        *生成电话杂费feetype 
        *@param
        *@return
        ********/
       function getphonefeename(key)
       {			
		   var urlstr=tsd.buildParams({ 
    										packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',//返回数据格式 
						 					tsdpk:'dbsql_phone.attachprice'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					});	 						
				var ghzf='';
				$("#phonefeetype").empty();
				$("#phonefeetype").html("<option value='' selected=true>--"+$("#getinternet0365").val()+"--</option>");
				$.ajax({
					url:'mainServlet.html?'+urlstr+"&jhjid="+key+"&dhlx="+tsd.encodeURIComponent($("#Dhlx").val()),
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
							$(xml).find('row').each(function(){
								if($(this).attr("feecode")!=null&&$(this).attr("feecode")!=undefined){
		                 			ghzf +="<option value='"+$(this).attr("feecode")+"'>"+$(this).attr("feename")+"</option>";
		                 		}	
							});
							$("#phonefeetype").append(ghzf);
					}
				});
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
        /*******
        *生根据费用类型取子项目
        *@param：feename费用名称
        *@return
        ********/
        function getfeename()
        {
        	var feename = $("#phonefeetype").val();
        	//删除时把左边的点击显示颜色清空掉，然后把隐藏值也清空掉
	        $("#phonefeenamecode").val("");
	        getGHcsnum("");
        	$("#phonefeename tr").css('background-color','#f7f7f7');
        	if(feename==""){feename='-100';}
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
				$("#phonefeechildtype").empty();	
				$("#phonefeechildtype").html("<option value='' selected=true>--"+$("#getinternet0365").val()+"--</option>");
				$.ajax({
					url:'mainServlet.html?'+urlstr+"&feename="+tsd.encodeURIComponent(feename),					
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
							$(xml).find('row').each(function(){
								if($(this).attr("feetype")!=undefined){
		                 			/*ghzfzfx +="<tr onClick=\"getGHfeetr('"+$(this).attr("feetype")+"');getGHcsnum('"+$(this).attr("csnum")+"');\" id=\""+$(this).attr("feetype")+"\"><td>";
		                 			ghzfzfx +="☞"+$(this).attr("feetype");
		                 			ghzfzfx +="</td></tr>";*/

		                 			ghzfzfx +="<option value='"+$(this).attr('feetype')+"'>"+$(this).attr('feetype')+"</option>";
		                 			
		                 		}	
							});						
							$("#phonefeechildtype").append(ghzfzfx);
					}
				});
				$("#feelv").val("");
				$("#TJfeelv").val("");								
        }
        
        
        
        /*******
        *生根据费用类型取子项目（合同号月租）
        *@param：feename费用名称
        *@return
        ********/
        function getfeename_hth()
        {
        	var feename = $("#phonefeetype_hth").val();
        	//删除时把左边的点击显示颜色清空掉，然后把隐藏值也清空掉
	        $("#phonefeenamecode_hth").val("");
        	$("#phonefeename_hth tr").css('background-color','#f7f7f7');
        	if(feename==""){feename='-100';}
        	var urlstr=tsd.buildParams({ 
    										packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'business',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',//返回数据格式 
						 					tsdpk:'dbsql_phone.attachpricefeetype_hth'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					});	
				var ghzfzfx='';
				$("#phonefeename_hth").empty();	
				$.ajax({
					url:'mainServlet.html?'+urlstr+"&feename="+tsd.encodeURIComponent(feename),					
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
							$(xml).find('row').each(function(){
								if($(this).attr("feename")!=undefined){									
		                 			ghzfzfx +="<tr onClick=\"getGHfeetr_hth('"+$(this).attr("feename")+"');\" id=\""+$(this).attr("feename")+"\"><td>";
		                 			ghzfzfx +="☞"+$(this).attr("feename");
		                 			ghzfzfx +="</td></tr>";
		                 		}	
							});
							$("#phonefeename_hth").append(ghzfzfx);
					}
				});
				$("#price_hth").val("");								
        }
               
        /*******
        *单击选中一行固话杂费
        *@param：key子费用名称
        *@return
        ********/
        function getGHfeetr(key){        	
        	$("#phonefeenamecode").val(key);
        	getfeenameall();        	
        	//$("#phonefeename tr").css('background-color','#f7f7f7');
		    //  document.getElementById(key).style.background='#0080FF';  
        }
        
        /*******
        *单击选中一行hth月租
        *@param：key子费用名称
        *@return
        ********/
        function getGHfeetr_hth(key){        	
        	$("#phonefeenamecode_hth").val(key);
        	getfeenameall_hth();        	
        	$("#phonefeename_hth tr").css('background-color','#f7f7f7');
		      document.getElementById(key).style.background='#0080FF';  
		      var startdate = $("#startdate").val();   
		      var strtable="";     	
        	strtable +="<tr>";
        	strtable +="<td>"+$("#getinternetstarttime").val()+"</td>";
					strtable +="<td><input type='text' id='ZFStartday_hth' name='ZFStartday_hth' style='width: 100px;' disabled='disabled'/></td>";
					strtable +="<td>"+$("#getinternetermination").val()+"</td>";
					strtable +="<td><input type='text' id='ZFEndday_hth' name='ZFEndday_hth' style='width: 100px;' disabled='disabled' value='2999-12-31'  /></td>";
					strtable +="<td>数量</td>";
					strtable +="<td><input type='text' id='FeeNum' value='1' style='width:50px;' style='ime-mode: Disabled' onkeypress='var k=event.keyCode;return k>=48&&k<=57' maxlength='3' ondragenter='return false' onpaste='return false'/></td></tr>";
					$("#hthfeeinput").html(strtable);
					///电话杂费  终止月
					$("#ZFStartday_hth").focus(function(){
						WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
					});
					///电话杂费  终止日
					$("#ZFEndday_hth").focus(function(){
						WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
					});
					$("#ZFStartday_hth").val(startdate);
        }
        
        /*******
        *单击选中一行固话杂费表获取参数数量值来显示页面显示几个参数个数框
        *@param：key参数数量值csnum
        *@return
        ********/
        function getGHcsnum(key){
        	/*var strtable="";
        	if(key==undefined||key==""||key=="null"){
        		key=0;
        	}
        	$("#keyhidden").val(key);
        	$("#ghfeeinput").empty();
        	var startdate = $("#startdate").val();        	
        	strtable +="<tr>";
        	strtable +="<td class='wenzi' style='width:60px;line-height:30px;'>"+$("#getinternetstarttime").val()+"</td>";
					strtable +="<td><input type='text' id='ZFStartday' name='ZFStartday' style='width: 157px;' disabled='disabled'/></td>";
					strtable +="<td class='wenzi' style='width:60px;line-height:30px;'>"+$("#getinternetermination").val()+"</td>";					
					strtable +="<td><input type='text' id='ZFEndday' name='ZFEndday' style='width: 157px;' disabled='disabled' value='2999-12-31'  /></td>";
					strtable +="<td class='wenzi' style='display:none;' >设备数量</td>";
					strtable +="<td><input type='text' id='DEVNUM' name='DEVNUM' style='width:70px;display:none;' value='1' onkeypress='return event.keyCode>=4&&event.keyCode<=57'/></td>";
					strtable +="<td class='wenzi' style='display:none;'>单位长度</td>";
					strtable +="<td><input type='text' id='DEVLENGTH' name='DEVLENGTH' style='width:70px;display:none;' value='1' onkeypress='return event.keyCode>=4&&event.keyCode<=57'/></td>";
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
        	$("#ghfeeinput").append(strtable); */
        	$("#ZFStartday").val($("#startdate").val());
        	
        	$("#ZFEndday").removeAttr("disabled");
					$("#ZFStartday").removeAttr("disabled"); 
					///电话杂费  终止月
					$("#ZFStartday").focus(function(){
						WdatePicker({startDate:'%y-%M-01 00:00:00',minDate:'#F{$dp.$D(\'startdate\')}',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
					});
					///电话杂费  终止日
					$("#ZFEndday").focus(function(){
						WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
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

			/***********************
			* 专线类型
			* @param;
			* @return;
		    *************************/
			function getModual(){
				$("#Modual_yhdang").empty();
				var strModual="<option value=\"\">--"+$("#getinternet0365").val()+"--</option>"; 
				var res = fetchMultiArrayValue("dbsql_phone.queryphoneconfig",6,"&configtype=specialtype");
				if(res[0]==undefined || res[0][0]==undefined)
        		{
        			return false;
        		}
        		for(var i=0;i<res.length;i++){
        			strModual+="<option value="+res[i][0]+">"+res[i][1]+"</option>";
        		}
				$("#Modual_yhdang").append(strModual);
			}
			
			/***********************
			* 传输介质
			* @param;
			* @return;
		    *************************/
			function getPort(){
				$("#Port_yhdang").empty();
				var strPort="<option value=\"\">--"+$("#getinternet0365").val()+"--</option>"; 
				var res = fetchMultiArrayValue("dbsql_phone.queryphoneconfig",6,"&configtype=transmode");
				if(res[0]==undefined || res[0][0]==undefined)
        		{
        			return false;
        		}
        		for(var i=0;i<res.length;i++){
        			strPort+="<option value="+res[i][0]+">"+res[i][1]+"</option>";
        		}
				$("#Port_yhdang").append(strPort);
			}
			
			/********************
			* 判断是否预存金额，来判断是否金额只读
			* @param;
			* @return;
			*********************/
			function getprecheck(){
		  		var prechecked= $("#precheck").attr("checked");
		  		var hthvalue = $("#hth").val();
		  		hthvalue=hthvalue.replace(/(^\s*)|(\s*$)/g,"");	
		  		if(hthvalue==""){
		  			//alert("请生成或输入一个合同号！");
		  			alert($("#getinternet0025").val());
		  			$("input[id^='precheck']").removeAttr("checked");
		  			return false;
		  		}
		  		var res = fetchSingleValue("dbsql_phone.queryhthdanghth",6,"&hth="+tsd.encodeURIComponent(hthvalue));		
		  		if(res!=0){
		  			//alert("只有新生成或输入的合同号才能进行话费预存，选择合同号不能预存话费！");
		  			alert($("#getinternet0067").val());
		  			$("input[id^='precheck']").removeAttr("checked");
		  			return false;
		  		}
		  		if($("#Yhlb_hthdang").val().replace(/(^\s*)|(\s*$)/g,"")=="公费"){
		  			$("input[id^='precheck']").removeAttr("checked");
		  			//alert("公费用户不能预存话费！");
		  			alert($("#getinternet0068").val());
		  			return false;
		  		}
		  		if(prechecked){
		  				$("#Prefee").removeAttr("disabled");
		  				$("#confee").removeAttr("disabled");
		  				$("#Prefee").select();
		  				$("#Prefee").focus();
		  		}else{
		  				$("#Prefee").attr("disabled","disabled");
		  				$("#confee").attr("disabled","disabled");
		  				$("#Prefee").val("");
		  				$("#confee").val("");
		  		}
		  }
		  
		  //办理其他业务时，生成合同号或输入合同号将合同号编辑区的原来信息重新加载处理
		  function geththselect_sc(cusertype,oldyhlb,hth){
        		$("#Yhlb_hthdang").val($("#usertype option:selected").text());	
				//if(cusertype!="公费"&&oldyhlb=="公费"){
				if(cusertype!=$("#getinternet0384").val()&&oldyhlb==$("#getinternet0384").val()){
				
					$("#Yhmc_hthdang").val($("#Yhmc_yhdang").val());
					$("#Yhdz_hthdang").val($("#Yhdz_yhdang").val());
					$("#IDCard_hthdang").val($("#Bz7_yhdang").val());
					$("#linkTel_hthdang").val($("#Bz9_yhdang").val());
					$("#CreditPoint_hthdang").val($("#CreditPoint_yhdang").val());
					
				}else{
					getphonehthvalue($("#Hth_yhdang").val());//获取合同号基本信息（不包含合同号，用户类别，电话）
				}
				$("#Area_hthdang").val($("#Area_hidden").val());
        		$("#Dh_hthdang").val($("#Dh_yhdang").val());//生成合同号同时将用户档中的电话赋值到合同号信息中的电话框中 
        		if($("#CustTyperight_hthdang").val()=="false"){$("#CustType").attr("disabled","disabled");}
        }	
        
        /*
		*取合同号档信息,这个获取合同号信息中不获取用户类别跟合同号还有电话，		
		*这个方法主要是针对个别业务生成合同号后将原来的基本信息保留而查询的
		*/
		function getphonehthvalue(Hth)
		{
			var urlstr=tsd.buildParams({ packgname:'service',//java包
										clsname:'ExecuteSql',//类名
										method:'exeSqlData',//方法名
										ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdcf:'mssql',//指向配置文件名称
										tsdoper:'query',//操作类型 
										datatype:'xmlattr',//返回数据格式 
										tsdpk:'PhonemoveAddress.dhBasicInfoHthdang'
										});
			if(Hth==""||Hth==null||Hth==undefined||Hth=='Hth'){Hth='000000';}
			var params = "&Hth=" + Hth;
				$.ajax({
				url:"mainServlet.html?"+urlstr+params,
				cache:false,
				success:function(xml){
					$(xml).find("row").each(function(){
						if($(this).attr("hth")==undefined||$(this).attr("hth")==""){
							getbusinessDefault('Y','N');//设置默认值第一个参数是对合同号是否进行默认值，第二个参数是对用户档是否设置默认值，Y是，N不是
							return;
						}
						$("#Yhmc_hthdang").val($(this).attr("yhmc")==undefined?"":$(this).attr("yhmc"));						
						//用户性质						
						$("#Yhxz_hthdang").val($(this).attr("yhxz")==undefined?"":$(this).attr("yhxz"));
						//付费策略
						$("#PayPolicy_hthdang").val($(this).attr("callpaytype")==undefined?"":$(this).attr("callpaytype"));						
						$("#CallPayType_hthdang").val($(this).attr("callpaytype")==undefined?"":$(this).attr("callpaytype"));
						$("#Area_hthdang").val($(this).attr("area")==undefined?"":$(this).attr("area"));
						$("#Area_hidden").val($(this).attr("area")==undefined?"":$(this).attr("area"));						
						//滞纳金标志						
						$("#ZnjBz_hthdang").val($(this).attr("znjbz")==undefined?"":$(this).attr("znjbz"));
						$("#IDCard_hthdang").val($(this).attr("idcard")==undefined?"":$(this).attr("idcard"));
						$("#Yhdz_hthdang").val($(this).attr("yhdz")==undefined?"":$(this).attr("yhdz"));//用户地址						
				 	    //$("#Bz2_hthdang").val($(this).attr("bz2")==undefined?"":$(this).attr("bz2")=="Y"?"是":"否");//是否大客户代收
				 	    $("#Bz2_hthdang").val($(this).attr("bz2")==undefined?"":$(this).attr("bz2")=="Y"?$("#getinternet0354").val():$("#getinternet0355").val());//是否大客户代收				 	    			 	    
						$("#CreditPoint_hthdang").val($(this).attr("creditpoint")==undefined?"":$(this).attr("creditpoint"));//信誉积分						
						$("#CustType_hthdang").val($(this).attr("custtype")==undefined?"":$(this).attr("custtype"));//客户类型
						$("#linkTel").val($(this).attr("linktel")==undefined?"":$(this).attr("linktel"));//联系电话
					});
				}
			});
		}		  		  

		  /********************
			* 回车事件
			* @param;
			* @return;
			*********************/
		  function preKey(event){
                    if(event.keyCode==13){
                        $("#confee").val($("#Prefee").val());
                        $("#confee").select();
                        $("#confee").focus();
                        return false;
                    }
                }
                
          		/*********
				* 权限设置			
				* @param;
				* @return;
		    	**********/
				function getUserPower(){
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
				var useridright='';
				var konghaoarearight='';
				var selecththright='';
				var addressinputright='';
				var statrtimeright='';
				var stoptimeright='';
				var zjtimeright='';
				var Yhmcright='';
				var Yhxzright='';
				var CallPayTyperight='';
				var ZnjBzright='';
				var CustTyperight='';
				var CreditGraderight='';
				var CreditPointright='';
				var Boss_Nameright='';
				var linkTelright='';
				var FixCoderight='';
				var TradeTyperight='';
				var CompTyperight='';
				var HomePageright='';
				var Emailright='';
				var Manageidright='';
				var Arearight='';
				var HthMfjbright='';
				var IDCardright='';
				var sBmright='';
				var Yhmc_yhdangright='';
				var Yhdz_yhdangright='';
				var sBm_yhdangright='';
				var Mima_yhdangright='';
				var Bz8_yhdangright='';
				var Bz9_yhdangright='';
				var Bz6_yhdangright='';
				var Bz7_yhdangright='';
				var Hwjb1_yhdangright='';
				var Jflb_yhdangright='';
				var Mfjb_yhdangright='';
				var Mobile_yhdangright='';
				var AdjustSheduleNo_yhdangright='';
				var CallSheduleNo_yhdangright='';
				var MokuaiJu_yhdangright='';
				var YwArea_yhdangright='';
				var CreditGrade_yhdangright='';
				var CreditPoint_yhdangright='';
				var UserType_yhdangright='';
				var CustType_yhdangright='';
				var Dhgn_yhdangright='';
				var yjfeeright='';
				var setagenththright='';
				var Bz2right='';//是否大客户代收
				var Tjbzright='';
				var selecththarearight='';
				var modifyattachfeeright='';
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
						useridright='true';
						konghaoarearight='true';
						selecththright='true';
						addressinputright='true';
						statrtimeright='true';
						stoptimeright='true';
						zjtimeright='true';
						Yhmcright='true';
						Yhxzright='true';
						CallPayTyperight='true';
						ZnjBzright='true';
						CustTyperight='true';
						CreditGraderight='true';
						CreditPointright='true';
						Boss_Nameright='true';
						linkTelright='true';
						FixCoderight='true';
						TradeTyperight='true';
						CompTyperight='true';
						HomePageright='true';
						Emailright='true';
						Manageidright='true';
						Arearight='true';
						HthMfjbright='true';
						IDCardright='true';
						sBmright='true';
						Yhmc_yhdangright='true';
						Yhdz_yhdangright='true';
						sBm_yhdangright='true';
						Mima_yhdangright='true';
						Bz8_yhdangright='true';
						Bz9_yhdangright='true';
						Bz6_yhdangright='true';
						Bz7_yhdangright='true';
						Hwjb1_yhdangright='true';
						Jflb_yhdangright='true';
						Mfjb_yhdangright='true';
						Mobile_yhdangright='true';
						AdjustSheduleNo_yhdangright='true';
						CallSheduleNo_yhdangright='true';
						MokuaiJu_yhdangright='true';
						YwArea_yhdangright='true';
						CreditGrade_yhdangright='true';
						CreditPoint_yhdangright='true';
						UserType_yhdangright='true';
						CustType_yhdangright='true';
						Dhgn_yhdangright='true'
						yjfeeright='true';
						setagenththright='true';
						Bz2right='true';//是否大客户代收
						Tjbzright='true';
						selecththarearight='true';
						modifyattachfeeright='true';
						flag = true;
				}else if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');
						for(var i = 0;i<spowerarr.length-1;i++){							
							useridright += getCaption(spowerarr[i],'RightsGroup','')+'|';
							konghaoarearight += getCaption(spowerarr[i],'getnullarea','')+'|';
							selecththright +=getCaption(spowerarr[i],'selecthth','')+'|';
							addressinputright +=getCaption(spowerarr[i],'addressinput','')+'|';	
							statrtimeright +=getCaption(spowerarr[i],'statrtime','')+'|';
							stoptimeright +=getCaption(spowerarr[i],'stoptime','')+'|';
							zjtimeright +=getCaption(spowerarr[i],'zjtime','')+'|';							
							Yhmcright +=getCaption(spowerarr[i],'Yhmc','')+'|';
							Yhxzright +=getCaption(spowerarr[i],'Yhxz','')+'|';	
							CallPayTyperight +=getCaption(spowerarr[i],'CallPayType','')+'|';
							ZnjBzright +=getCaption(spowerarr[i],'ZnjBz','')+'|';
							CustTyperight +=getCaption(spowerarr[i],'CustType','')+'|';
							CreditGraderight +=getCaption(spowerarr[i],'CreditGrade','')+'|';
							CreditPointright +=getCaption(spowerarr[i],'CreditPoint','')+'|';
							Boss_Nameright +=getCaption(spowerarr[i],'Boss_Name','')+'|';
							linkTelright +=getCaption(spowerarr[i],'linkTel','')+'|';
							FixCoderight +=getCaption(spowerarr[i],'FixCode','')+'|';
							TradeTyperight +=getCaption(spowerarr[i],'TradeType','')+'|'; 
							CompTyperight +=getCaption(spowerarr[i],'CompType','')+'|';
							HomePageright +=getCaption(spowerarr[i],'HomePage','')+'|';
							Emailright +=getCaption(spowerarr[i],'Email','')+'|';
							Manageidright +=getCaption(spowerarr[i],'Manageid','')+'|';
							Arearight +=getCaption(spowerarr[i],'Area','')+'|'; 
							HthMfjbright +=getCaption(spowerarr[i],'HthMfjb','')+'|'; 
							IDCardright +=getCaption(spowerarr[i],'IDCard','')+'|';
							sBmright +=getCaption(spowerarr[i],'sBm','')+'|';
							Yhmc_yhdangright +=getCaption(spowerarr[i],'Yhmc_yhdang','')+'|';
							Yhdz_yhdangright +=getCaption(spowerarr[i],'Yhdz_yhdang','')+'|';
							sBm_yhdangright +=getCaption(spowerarr[i],'sBm_yhdang','')+'|';
							Mima_yhdangright +=getCaption(spowerarr[i],'Mima_yhdang','')+'|';
							Bz8_yhdangright +=getCaption(spowerarr[i],'Bz8_yhdang','')+'|';
							Bz9_yhdangright +=getCaption(spowerarr[i],'Bz9_yhdang','')+'|';
							Bz6_yhdangright +=getCaption(spowerarr[i],'Bz6_yhdang','')+'|';
							Bz7_yhdangright +=getCaption(spowerarr[i],'Bz7_yhdang','')+'|';
							Hwjb1_yhdangright +=getCaption(spowerarr[i],'Hwjb1_yhdang','')+'|';
							Jflb_yhdangright +=getCaption(spowerarr[i],'Jflb_yhdang','')+'|';
							Mfjb_yhdangright +=getCaption(spowerarr[i],'Mfjb_yhdang','')+'|';
							Mobile_yhdangright+=getCaption(spowerarr[i],'Mobile_yhdang','')+'|';
							AdjustSheduleNo_yhdangright+=getCaption(spowerarr[i],'tjcl_yhdang','')+'|';
							CallSheduleNo_yhdangright +=getCaption(spowerarr[i],'cjcl_yhdang','')+'|';
							MokuaiJu_yhdangright +=getCaption(spowerarr[i],'MokuaiJu_yhdang','')+'|';
							YwArea_yhdangright +=getCaption(spowerarr[i],'YwArea_yhdang','')+'|';
							CreditGrade_yhdangright +=getCaption(spowerarr[i],'CreditG_yhdang','')+'|';
							CreditPoint_yhdangright +=getCaption(spowerarr[i],'CreditP_yhdang','')+'|';
							UserType_yhdangright +=getCaption(spowerarr[i],'UserType_yhdang','')+'|';
							CustType_yhdangright +=getCaption(spowerarr[i],'CustType_yhdang','')+'|';
							Dhgn_yhdangright +=getCaption(spowerarr[i],'Dhgn_yhdang','')+'|';
							yjfeeright +=getCaption(spowerarr[i],'Payablefee','')+'|';//一次性费用应缴费
							setagenththright +=getCaption(spowerarr[i],'setagenthth','')+'|';//设置代缴合同号按钮是否可用	
							Bz2right +=	getCaption(spowerarr[i],'Agent','')+'|';//修改属性中是否大客户代收
							Tjbzright += getCaption(spowerarr[i],'Tjbz','')+'|';//修改属性中的停机标志
							Tjbzright += getCaption(spowerarr[i],'Tjbz','')+'|';//
							selecththarearight+=getCaption(spowerarr[i],'selecththarea','')+'|';//
							modifyattachfeeright+=getCaption(spowerarr[i],'modifyattachfee','')+'|';//							
						}
				}
				var hasuserid = useridright.split('|');
				var haskonghaoarea = konghaoarearight.split('|');
				var hasselecthth = selecththright.split('|');
				var hasaddressinput = addressinputright.split('|');
				var hasstatrtime = statrtimeright.split('|');
				var hasstoptime = stoptimeright.split('|');
				var haszjtime = zjtimeright.split('|');
				var hasYhmc = Yhmcright.split('|');
				var hasYhxz = Yhxzright.split('|');
				var hasCallPayType = CallPayTyperight.split('|');
				var hasZnjBz = ZnjBzright.split('|');
				var hasCustType = CustTyperight.split('|');
				var hasCreditGrade = CreditGraderight.split('|');
				var hasCreditPoint = CreditPointright.split('|');
				var hasBoss_Name = Boss_Nameright.split('|');
				var haslinkTel = linkTelright.split('|');
				var hasFixCode = FixCoderight.split('|');
				var hasTradeType = TradeTyperight.split('|');
				var hasCompType = CompTyperight.split('|');
				var hasHomePage = HomePageright.split('|');
				var hasEmail = Emailright.split('|');
				var hasManageid = Manageidright.split('|');
				var hasArea = Arearight.split('|');
				var hasHthMfjb = HthMfjbright.split('|');
				var hasIDCard = IDCardright.split('|');
				var hassBm = sBmright.split('|');
				var hasYhmc_yhdang = Yhmc_yhdangright.split('|');
				var hasYhdz_yhdang = Yhdz_yhdangright.split('|');
				var hassBm_yhdang = sBm_yhdangright.split('|');
				var hasMima_yhdang = Mima_yhdangright.split('|');
				var hasBz8_yhdang = Bz8_yhdangright.split('|');
				var hasBz9_yhdang = Bz9_yhdangright.split('|');
				var hasBz6_yhdang = Bz6_yhdangright.split('|');
				var hasBz7_yhdang = Bz7_yhdangright.split('|');
				var hasHwjb1_yhdang = Hwjb1_yhdangright.split('|');
				var hasJflb_yhdang = Jflb_yhdangright.split('|');
				var hasMfjb_yhdang = Mfjb_yhdangright.split('|');
				var hasMobile_yhdang = Mobile_yhdangright.split('|');
				var hasAdjustSheduleNo_yhdang = AdjustSheduleNo_yhdangright.split('|');
				var hasCallSheduleNo_yhdang = CallSheduleNo_yhdangright.split('|');
				var hasMokuaiJu_yhdang = MokuaiJu_yhdangright.split('|');
				var hasYwArea_yhdang = YwArea_yhdangright.split('|');
				var hasCreditGrade_yhdang = CreditGrade_yhdangright.split('|'); 
				var hasCreditPoint_yhdang = CreditPoint_yhdangright.split('|');
				var hasUserType_yhdang = UserType_yhdangright.split('|');
				var hasCustType_yhdang = CustType_yhdangright.split('|');
				var hasyjfee = yjfeeright.split('|');
				var hasDhgn_yhdang = Dhgn_yhdangright.split('|');
				var hassetagenthth = setagenththright.split('|');
				var hasBz2 = Bz2right.split('|');//是否大客户代收
				var hasTjbz = Tjbzright.split('|');
				var hasselecththarea = selecththarearight.split('|');	
				var hasmodifyattachfee = modifyattachfeeright.split('|');			
				var str = 'true';
				if(flag==true){
					$("#Tjbzright").val(Tjbzright);
					$("#Bz2right").val(Bz2right);//是否大客户代收
					$("#setagenththright").val(setagenththright);
					$("#yjfeeright").val(yjfeeright);				
					$("#useridright").val(useridright);
					$("#konghaoarearight").val(konghaoarearight);
					$("#selecththright").val(selecththright);
					$("#addressinputright").val(addressinputright);
					$("#statrtimeright").val(statrtimeright);
					$("#stoptimeright").val(stoptimeright);
					$("#zjtimeright").val(zjtimeright);					
					$("#Yhmcright").val(Yhmcright);
					$("#Yhxzright").val(Yhxzright);
					$("#CallPayTyperight").val(CallPayTyperight);
					$("#ZnjBzright").val(ZnjBzright);
					$("#CustTyperight").val(CustTyperight);
					$("#CreditGraderight").val(CreditGraderight);
					$("#CreditPointright").val(CreditPointright);
					$("#Boss_Nameright").val(Boss_Nameright);
					$("#linkTelright").val(linkTelright);
					$("#FixCoderight").val(FixCoderight);
					$("#TradeTyperight").val(TradeTyperight);
					$("#CompTyperight").val(CompTyperight);
					$("#HomePageright").val(HomePageright);
					$("#Emailright").val(Emailright);
					$("#Manageidright").val(Manageidright);
					$("#Arearight").val(Arearight);
					$("#HthMfjbright").val(HthMfjbright);
					$("#IDCardright").val(IDCardright);					
					$("#sBmright").val(sBmright);
					$("#Yhmc_yhdangright").val(Yhmc_yhdangright);
					$("#Yhdz_yhdangright").val(Yhdz_yhdangright);
					$("#sBm_yhdangright").val(sBm_yhdangright);
					$("#Mima_yhdangright").val(Mima_yhdangright);
					$("#Bz8_yhdangright").val(Bz8_yhdangright);
					$("#Bz9_yhdangright").val(Bz9_yhdangright);
					$("#Bz6_yhdangright").val(Bz6_yhdangright);
					$("#Bz7_yhdangright").val(Bz7_yhdangright);
					$("#Hwjb1_yhdangright").val(Hwjb1_yhdangright);
					$("#Jflb_yhdangright").val(Jflb_yhdangright);
					$("#Mfjb_yhdangright").val(Mfjb_yhdangright);
					$("#Mobile_yhdangright").val(Mobile_yhdangright);
					$("#AdjustSheduleNo_yhdangright").val(AdjustSheduleNo_yhdangright);
					$("#CallSheduleNo_yhdangright").val(CallSheduleNo_yhdangright);
					$("#MokuaiJu_yhdangright").val(MokuaiJu_yhdangright);
					$("#YwArea_yhdangright").val(YwArea_yhdangright);
					$("#CreditGrade_yhdangright").val(CreditGrade_yhdangright);
					$("#CreditPoint_yhdangright").val(CreditPoint_yhdangright);
					$("#UserType_yhdangright").val(UserType_yhdangright);
					$("#CustType_yhdangright").val(CustType_yhdangright);
					$("#Dhgn_yhdangright").val(Dhgn_yhdangright);
					$("#selecththarearight").val(selecththarearight);
					$("#modifyattachfeeright").val(modifyattachfeeright);
				}else{
					for(var i = 0;i<hasmodifyattachfee.length;i++){
							$("#modifyattachfeeright").val(hasmodifyattachfee[i]);
							break;
						}
					for(var i = 0;i<hasselecththarea.length;i++){
							$("#selecththarearight").val(hasselecththarea[i]);
							break;
						}
					for(var i = 0;i<hasTjbz.length;i++){
							$("#Tjbzright").val(hasTjbz[i]);
							break;
						}
					for(var i = 0;i<hasBz2.length;i++){
							$("#Bz2right").val(hasBz2[i]);
							break;
						}
					for(var i = 0;i<hassetagenthth.length;i++){
							$("#setagenththright").val(hassetagenthth[i]);
							break;
						}
					for(var i = 0;i<hasDhgn_yhdang.length;i++){
							$("#Dhgn_yhdangright").val(hasDhgn_yhdang[i]);
							break;
						}
					for(var i = 0;i<hasyjfee.length;i++){
							$("#yjfeeright").val(hasyjfee[i]);
							break;
						}
					for(var i = 0;i<hasCustType_yhdang.length;i++){
							$("#CustType_yhdangright").val(hasCustType_yhdang[i]);
							break;
						}
					for(var i = 0;i<hasUserType_yhdang.length;i++){
							$("#UserType_yhdangright").val(hasUserType_yhdang[i]);
							break;
						}
					for(var i = 0;i<hasCreditPoint_yhdang.length;i++){
							$("#CreditPoint_yhdangright").val(hasCreditPoint_yhdang[i]);
							break;
						}	
					for(var i = 0;i<hasCreditGrade_yhdang.length;i++){
							$("#CreditGrade_yhdangright").val(hasCreditGrade_yhdang[i]);
							break;
						}
					for(var i = 0;i<hasYwArea_yhdang.length;i++){
							$("#YwArea_yhdangright").val(hasYwArea_yhdang[i]);
							break;
						}
					for(var i = 0;i<hasMokuaiJu_yhdang.length;i++){
							$("#MokuaiJu_yhdangright").val(hasMokuaiJu_yhdang[i]);
							break;
						}
					for(var i = 0;i<hasCallSheduleNo_yhdang.length;i++){
							$("#CallSheduleNo_yhdangright").val(hasCallSheduleNo_yhdang[i]);
							break;
						}
					for(var i = 0;i<hasAdjustSheduleNo_yhdang.length;i++){
							$("#AdjustSheduleNo_yhdangright").val(hasAdjustSheduleNo_yhdang[i]);
							break;
						}
					for(var i = 0;i<hasMobile_yhdang.length;i++){
							$("#Mobile_yhdangright").val(hasMobile_yhdang[i]);
							break;
						}
					for(var i = 0;i<hasMfjb_yhdang.length;i++){
							$("#Mfjb_yhdangright").val(hasMfjb_yhdang[i]);
							break;
						}
					for(var i = 0;i<hasJflb_yhdang.length;i++){
							$("#Jflb_yhdangright").val(hasJflb_yhdang[i]);
							break;
						}
					for(var i = 0;i<hasHwjb1_yhdang.length;i++){
							$("#Hwjb1_yhdangright").val(hasHwjb1_yhdang[i]);
							break;
						}
					for(var i = 0;i<hasBz7_yhdang.length;i++){
							$("#Bz7_yhdangright").val(hasBz7_yhdang[i]);
							break;
						}
					for(var i = 0;i<hasBz6_yhdang.length;i++){
							$("#Bz6_yhdangright").val(hasBz6_yhdang[i]);
							break;
						}	
					for(var i = 0;i<hasBz9_yhdang.length;i++){
							$("#Bz9_yhdangright").val(hasBz9_yhdang[i]);
							break;
						}
					for(var i = 0;i<hasBz8_yhdang.length;i++){
							$("#Bz8_yhdangright").val(hasBz8_yhdang[i]);
							break;
						}
					for(var i = 0;i<hasMima_yhdang.length;i++){
							$("#Mima_yhdangright").val(hasMima_yhdang[i]);
							break;
						}
					for(var i = 0;i<hassBm_yhdang.length;i++){
							$("#sBm_yhdangright").val(hassBm_yhdang[i]);
							break;
						}
					for(var i = 0;i<hasYhdz_yhdang.length;i++){
							$("#Yhdz_yhdangright").val(hasYhdz_yhdang[i]);
							break;
						}
					for(var i = 0;i<hasYhmc_yhdang.length;i++){
							$("#Yhmc_yhdangright").val(hasYhmc_yhdang[i]);
							break;
						}
					for(var i = 0;i<hassBm.length;i++){
							$("#sBmright").val(hassBm[i]);
							break;
						}
					for(var i = 0;i<hasIDCard.length;i++){
							$("#IDCardright").val(hasIDCard[i]);
							break;
						}
					for(var i = 0;i<hasHthMfjb.length;i++){
							$("#HthMfjbright").val(hasHthMfjb[i]);
							break;
						}
					for(var i = 0;i<hasArea.length;i++){
							$("#Arearight").val(hasArea[i]);
							break;
						}
					for(var i = 0;i<hasManageid.length;i++){
							$("#Manageidright").val(hasManageid[i]);
							break;
						}
					for(var i = 0;i<hasEmail.length;i++){
							$("#Emailright").val(hasEmail[i]);
							break;
						}
					for(var i = 0;i<hasHomePage.length;i++){
							$("#HomePageright").val(hasHomePage[i]);
							break;
						}
					for(var i = 0;i<hasCompType.length;i++){
							$("#CompTyperight").val(hasCompType[i]);
							break;
						}
					for(var i = 0;i<hasTradeType.length;i++){
							$("#TradeTyperight").val(hasTradeType[i]);
							break;
						}
					for(var i = 0;i<hasFixCode.length;i++){
							$("#FixCoderight").val(hasFixCode[i]);
							break;
						}
					for(var i = 0;i<haslinkTel.length;i++){
							$("#linkTelright").val(haslinkTel[i]);
							break;
						}
					for(var i = 0;i<hasBoss_Name.length;i++){
							$("#Boss_Nameright").val(hasBoss_Name[i]);
							break;
						}
					for(var i = 0;i<hasCreditPoint.length;i++){
							$("#CreditPointright").val(hasCreditPoint[i]);
							break;
						}
					for(var i = 0;i<hasCreditGrade.length;i++){
							$("#CreditGraderight").val(hasCreditGrade[i]);
							break;
						}
					for(var i = 0;i<hasCustType.length;i++){
							$("#CustTyperight").val(hasCustType[i]);
							break;
						}
					for(var i = 0;i<hasZnjBz.length;i++){
							$("#ZnjBzright").val(hasZnjBz[i]);
							break;
						}				
					for(var i = 0;i<hasuserid.length;i++){
							$("#useridright").val(hasuserid[i]);
							break;
						}
					for(var i = 0;i<haskonghaoarea.length;i++){
							$("#konghaoarearight").val(haskonghaoarea[i]);
							break;
						}	
				     }
				    for(var i = 0;i<hasselecthth.length;i++){
							$("#selecththright").val(hasselecthth[i]);
							break;
						}
					for(var i = 0;i<hasaddressinput.length;i++){
							$("#addressinputright").val(hasaddressinput[i]);
							break;
						}
					for(var i = 0;i<hasstatrtime.length;i++){
							$("#statrtimeright").val(hasstatrtime[i]);
							break;
						}	
					for(var i = 0;i<hasstoptime.length;i++){
							$("#stoptimeright").val(hasstoptime[i]);
							break;
						}
					for(var i = 0;i<haszjtime.length;i++){
							$("#zjtimeright").val(haszjtime[i]);
							break;
						}
					for(var i = 0;i<hasYhmc.length;i++){
							$("#Yhmcright").val(hasYhmc[i]);
							break;
						}	
					for(var i = 0;i<hasYhxz.length;i++){
							$("#Yhxzright").val(hasYhxz[i]);
							break;
						}	
					for(var i = 0;i<hasCallPayType.length;i++){
							$("#CallPayTyperight").val(hasCallPayType[i]);
							break;
						}	
			}   
			
			//判断数据权限是否可编辑
			function getPowertrue(){					
				if($("#Yhmcright").val()=="false"){$("#Yhmc_hthdang").attr("disabled","disabled");}
				if($("#Yhxzright").val()=="false"){$("#Yhxz_hthdang").attr("disabled","disabled");}
				if($("#CallPayTyperight").val()=="false"){$("#CallPayType_hthdang").attr("disabled","disabled");}
				if($("#ZnjBzright").val()=="false"){$("#ZnjBz_hthdang").attr("disabled","disabled");}
				if($("#CustTyperight").val()=="false"){$("#CustType_hthdang").attr("disabled","disabled");}
				if($("#CreditGraderight").val()=="false"){$("#CreditGrade_hthdang").attr("disabled","disabled");}
				if($("#CreditPointright").val()=="false"){$("#CreditPoint_hthdang").attr("disabled","disabled");}
				if($("#Boss_Nameright").val()=="false"){$("#Boss_Name_hthdang").attr("disabled","disabled");}
				if($("#linkTelright").val()=="false"){$("#linkTel_hthdang").attr("disabled","disabled");}				
				if($("#FixCoderight").val()=="false"){$("#FixCode_hthdang").attr("disabled","disabled");}
				if($("#TradeTyperight").val()=="false"){$("#TradeType_hthdang").attr("disabled","disabled");}
				if($("#CompTyperight").val()=="false"){$("#CompType_hthdang").attr("disabled","disabled");}
				if($("#HomePageright").val()=="false"){$("#HomePage_hthdang").attr("disabled","disabled");}
				if($("#Emailright").val()=="false"){$("#Email_hthdang").attr("disabled","disabled");}
				if($("#Manageidright").val()=="false"){$("#Manageid_hthdang").attr("disabled","disabled");}
				if($("#Arearight").val()=="false"){$("#Area_hthdang").attr("disabled","disabled");}
				if($("#HthMfjbright").val()=="false"){$("#HthMfjb").attr("disabled","disabled");}
				if($("#IDCardright").val()=="false"){$("#IDCard").attr("disabled","disabled");}
				if($("#sBmright").val()=="false"){$("#sBm1").attr("disabled","disabled");$("#sBm2").attr("disabled","disabled");$("#sBm3").attr("disabled","disabled");$("#sBm4").attr("disabled","disabled");}
				if($("#Yhmc_yhdangright").val()=="false"){$("#Yhmc_yhdang").attr("disabled","disabled");}
				if($("#Yhdz_yhdangright").val()=="false"){$("#Yhdz_yhdang").attr("disabled","disabled");}
				if($("#sBm_yhdangright").val()=="false"){$("#Bm1_yhdang").attr("disabled","disabled");$("#Bm2_yhdang").attr("disabled","disabled");$("#Bm3_yhdang").attr("disabled","disabled");$("#Bm4_yhdang").attr("disabled","disabled");}
				if($("#Mima_yhdangright").val()=="false"){$("#Mima_yhdang").attr("disabled","disabled");$("#toMima_yhdang").attr("disabled","disabled");}
				if($("#Bz8_yhdangright").val()=="false"){$("#Bz8_yhdang").attr("disabled","disabled");}
				if($("#Bz9_yhdangright").val()=="false"){$("#Bz9_yhdang").attr("disabled","disabled");}
				if($("#Bz6_yhdangright").val()=="false"){$("#Bz6_yhdang").attr("disabled","disabled");}
				if($("#Bz7_yhdangright").val()=="false"){$("#Bz7_yhdang").attr("disabled","disabled");}
				if($("#Hwjb1_yhdangright").val()=="false"){$("#Hwjb1_yhdang").attr("disabled","disabled");}
				if($("#Jflb_yhdangright").val()=="false"){$("#Jflb_yhdang").attr("disabled","disabled");}
				if($("#Mfjb_yhdangright").val()=="false"){$("#Mfjb_yhdang").attr("disabled","disabled");}
				if($("#Mobile_yhdangright").val()=="false"){$("#Mobile_yhdang").attr("disabled","disabled");}
				if($("#AdjustSheduleNo_yhdangright").val()=="false"){$("#AdjustSheduleNo_yhdang").attr("disabled","disabled");}				
				if($("#CallSheduleNo_yhdangright").val()=="false"){$("#CallSheduleNo_yhdang").attr("disabled","disabled");}
				if($("#MokuaiJu_yhdangright").val()=="false"){$("#MokuaiJu_yhdang").attr("disabled","disabled");}
				if($("#YwArea_yhdangright").val()=="false"){$("#YwArea_yhdang").attr("disabled","disabled");}
				if($("#CreditGrade_yhdangright").val()=="false"){$("#CreditGrade_yhdang").attr("disabled","disabled");}
				if($("#CreditPoint_yhdangright").val()=="false"){$("#CreditPoint_yhdang").attr("disabled","disabled");}
				if($("#UserType_yhdangright").val()=="false"){$("#UserType_yhdang").attr("disabled","disabled");}
				if($("#CustType_yhdangright").val()=="false"){$("#CustType_yhdang").attr("disabled","disabled");}
				if($("#Dhgn_yhdangright").val()=="false"){$("#Dhgn_yhdang").attr("disabled","disabled");}			
			}		
			
		/********
        *金额验证
        *@param;obj输入参数
       	*@return;
        ********/ 	
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
	
	
	/////////////////////////////本方法只属于本页调用////////////////////////////////////////
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
	
