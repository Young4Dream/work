<br>&gt;<%----------------------------------------
	name: Detail_BatchAdd.jsp
	author: wangli
	version: 1.0 
	description: 号线设备管理-明细表批量新增页面 
	Date: 2011-11-01
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
	<script type="text/javascript">
		//批量保存air_Device_Detail表.flag=1:新增;flag=2:编辑;
		function batchSaveDetail(flag){		
			
			//如果是新增，则要求输入设备名称前缀、起始编码、结束编码，编辑则不需要
			if (flag==1){
				if (NullCheck("#prefix1", "设备名称前缀")) {return};			
				if (NullCheck("#beginid1", "起始编码")) {return};
				if (NullCheck("#endid1", "结束编码")) {return};
				if (parseInt($("#endid1").val(),10) < parseInt($("#beginid1").val(),10)){
					alert("结束编码不能小于起始编码，请重新输入！");
					$("#endid1").focus();
					return;
				}
				//编码长度控制
				var v_lpad = 0;
				if ($("#check1").attr("checked")==true){				
					if (NullCheck("#idlen1", "前缀1的编码长度")) {return};
					v_lpad = 1;
				}
				
				//如果二级以上的设备名称前缀、起始编码、结束编码，有一个不为空，则同一层的设备名称前缀、起始编码、结束编码都不能为空
				for(var i=2;i<5;i++){					
					if ($("#prefix"+i).val() != "" || $("#beginid"+i).val() != "" || $("#endid"+i).val() != "" ) {
						if (NullCheck("#prefix"+i, "设备名称前缀"+i)) {
							return;
						};
						if (NullCheck("#beginid"+i, "起始编码"+i)) {
							return;
						};
						if (NullCheck("#endid"+i, "结束编码"+i)) {
							return;
						};
						if (v_lpad == 1 ){
							if (NullCheck("#idlen"+i, "前缀" + i + "的编码长度")) {return};
						}
						
						if (parseInt($("#endid"+i).val(),10) < parseInt($("#beginid"+i).val(),10)){
							alert("第"+i+"层的结束编码不能小于起始编码，请重新输入！");
							$("#endid"+i).focus();
							return;
						}
					}
				}	//end for				
				
			}
			var devid =$("#devid_level").val();
			var levelFlag =getThelevel(devid);					
			if(levelFlag){	
				if (NullCheck("#portype_b", "业务类型")) {return};
			}else{
				if (NullCheck("#ywarea_b", "业务区域")) {return};
			}
			if (!confirm("您确定要进行保存操作吗？")){
				return;
			}						
        	var v_prefix1 = tsd.encodeURIComponent($("#prefix1").val());
        	var v_beginid1 = $("#beginid1").val();
        	var v_endid1 = $("#endid1").val()  ;
        	
        	var v_prefix2 = tsd.encodeURIComponent($("#prefix2").val());
        	var v_beginid2 = $("#beginid2").val();
        	var v_endid2 = $("#endid2").val();    
        	
        	var v_prefix3 = tsd.encodeURIComponent($("#prefix3").val());
        	var v_beginid3 = $("#beginid3").val();
        	var v_endid3 = $("#endid3").val();    
        	
        	var v_prefix4 = tsd.encodeURIComponent($("#prefix4").val());
        	var v_beginid4 = $("#beginid4").val();
        	var v_endid4 = $("#endid4").val();    
        	      	
        	var v_idlen1 = $("#idlen1").val();
        	var v_idlen2 = $("#idlen2").val();
        	var v_idlen3 = $("#idlen3").val();
        	var v_idlen4 = $("#idlen4").val();
        	var v_devnolist;
        	var v_memo = "";
        	var v_dh = $("#dh_b").val();
        	var v_addr = tsd.encodeURIComponent($("#addr_b").val());
        	var v_ywarea = tsd.encodeURIComponent($("#ywarea_b").val());
        	var v_portype = tsd.encodeURIComponent($("#portype_b").val());
        	var v_mokuaiju = tsd.encodeURIComponent($("#mokuaiju_b").val());
        	var v_devicon = tsd.encodeURIComponent($("#devicon_b").val());
        	//var v_memo = tsd.encodeURIComponent($("#memo_d").val());         	
        	var v_pdevno = tsd.encodeURIComponent($("#pdevno_b").val());
        	var v_state = tsd.encodeURIComponent($("#state_b").val());
        	var pubParam = getPubProcParam_b(flag);   
        	var param=pubParam+"&devnolist="+v_devnolist
        		+"&prefix1="+v_prefix1+"&beginid1="+v_beginid1+"&endid1="+v_endid1
        		+"&prefix2="+v_prefix2+"&beginid2="+v_beginid2+"&endid2="+v_endid2
        		+"&prefix3="+v_prefix3+"&beginid3="+v_beginid3+"&endid3="+v_endid3
        		+"&prefix4="+v_prefix4+"&beginid4="+v_beginid4+"&endid4="+v_endid4
        		+"&lpad="+v_lpad
        		+"&idlen1="+v_idlen1
        		+"&idlen2="+v_idlen2
        		+"&idlen3="+v_idlen3
        		+"&idlen4="+v_idlen4
        	  	+"&dh="+v_dh+"&addr="+v_addr+"&mokuaiju="+v_mokuaiju+"&ywarea="+v_ywarea+"&portype="+v_portype
        	  	+"&devicon="+v_devicon+"&memo="+v_memo+"&state="+v_state+"&pdevno="+v_pdevno;
        	//如果是新增，则传入父设备编码这个参数parentno       	
			if (flag==1){				
				var nodes=zTreeObj.getSelectedNodes();
	        	if (nodes.length>0){
	        		param+="&parentno="+nodes[0].id;	        		        			        		
	        	}
	        	else{
	        		alert("保存失败！请确认是否正确选中父设备！");
	        		return;
	        	}	        	
			}
			else{
			 	//如果是批量编辑，则传入选中的记录的devno字段列表
				param+="&idlist="+getselobj();
			}
        	var res = fetchMultiPValue("air_device_manage",6,param);        	      
        	if(res[0][0]=="SUCCEED"){        	     
        		//保存新增的话，提示是否继续新增
				if (flag == 1)
				{
					//新增成功后，在编号输入框中显示刚刚插入的设备编号
					$("#devno_d").val(res[0][1]);
					if (confirm("保存成功！\r\n\n点击“确定”按钮继续新增设备，点击“取消”按钮返回主页面。")){						
						insertRefresh_b();
						return;
					}		
					insertRefresh_b();			
		        	//关闭本页面
		        	setTimeout($.unblockUI,15);					
				}
				else{
					alert("保存成功！\r\n\n点击“确定”按钮返回主页面。");	
					updateRefresh_b();	
					setTimeout("refreshTree();",15);				
				}
        	}
        	else if(res[0][0]=="FAILED"){ 
        		alert(res[0][1]);
        	}
        	else{
        		alert("保存失败！请仔细检查填写的数据是否正确。\r\n\n错误消息："+res[0][1]);
        	} 											
		}	
		//重置函数
		//清空面板信息，将设备端口状态置为空闲，模块局设置为上级设备模块局
		function reset_B(){						
			$("#divBatchAdd :text").val("");
			$("#divBatchAdd select").val("");
			
			//状态设置为 空闲
			$("#state_b").val("free");
			//模块局设置为上级设备模块局
			var devid =$("#devid_level").val();	
			var mokuaiju= getTheMKJ(devid);
			$("#mokuaiju_b").val(mokuaiju);
			
			$("#prepix").focus();		
		}
		/********************************
		获取操作类型
		********************************/
        function getPubProcParam_b(flag){
        	var optype;
       	 	if (flag == 1)
			{
				optype = 'batchinsert';
			}
			else{
				optype = 'batchupdate';
			};
			var optag = 2;
        	return "&optype="+optype+"&optag="+optag;
        }		
        //新增后返回主页面的刷新
        function insertRefresh_b(){        	
        	//树中添加新节点 是否添加 todo       	     
        	var nodes=zTreeObj.getSelectedNodes();
        	if (nodes.length>0){
        		//刷新明细表格
        		queryObj(nodes[0].id);    		
        	}        	                           	                
        }
        //修改后返回主页面的刷新
        function updateRefresh_b(){
        	//1.刷新明细表格的记录(即刷新选中节点的明细记录)    
        	var nodes=zTreeObj.getSelectedNodes();
        	if (nodes.length>0){        	    	
        		queryObj(nodes[0].id);
        	}
        	//2.关闭本页面
        	setTimeout($.unblockUI,15);        	
        }
        //获取子设备信息表格中选中的所有记得设备编码	
        function getselobj(){
       		var v_devno = "";
       		var ids=jQuery("#devDetail").getGridParam("selarrrow");       		
			ids = ids.sort(sortNumber);
			for(var i=0;i<ids.length;i++){				
				v_devno += jQuery("#devDetail").getCell(ids[i],'devno')+",";
			}						
			//去掉最后一项的逗号
			if (v_devno != ""){
				v_devno = v_devno.substr(0, v_devno.length-1);
			}			
			return v_devno;			
        }
        //刷新明细表格的记录(即刷新选中节点的明细记录) 
        function refreshTree(){
        	//1.刷新明细表格的记录(即刷新选中节点的明细记录)    
        	var nodes=zTreeObj.getSelectedNodes();
        	if (nodes.length>0){        	    	        		
        		if (nodes[0].open){
        			var id="";
        			var name="";	
        			//返回更新记录对应的树节点
        			var curTbl = document.getElementById("devDetail");
        			var Lenr = curTbl.rows.length;//取得表格行数
        			for (i = 1; i < Lenr; i++){
        			    id = curTbl.rows(i).cells(1).innerText;
        			    name = curTbl.rows(i).cells(2).innerText;        			               			         			    
		        		var node = zTreeObj.getNodeByParam("id", id, nodes[0]);		        
		        		if (name != node.name){
			        		node.name=name;   	
			        		zTreeObj.updateNode(node);
		        		}
	        		}
        		}
        	}        	
        }	
        
        
        /**********************************************************
				function name:    fuheExe()
				function:		  公共查询模块接口，判断当前的查询方式
				parameters:      
				return:			 
				description:      
				Date:				2010-9-7 
		********************************************************/
		function fuheExe()
		{
				var queryName= document.getElementById("queryName").value;
				if(queryName=="delete")
				{
					fuheDel();
				}
		}

        /**********************************************************
				function name:    fuheQbuildParams()
				function:		  复合查询参数获取
				parameters:       
				return:			  
				description:      
				Date:				2010-9-7 
		********************************************************/
		function fuheQbuildParams(){
			 	//每次拼接参数必须初始化此参数
				tsd.QualifiedVal=true;
			 	var params='';
			 	
			 	//如果有可能值是汉字 请使用encodeURI()函数转码
			 	var fusearchsql = $("#fusearchsql").val();		 	
			 	
			 	var nodes=zTreeObj.getSelectedNodes();
	        	if (nodes.length>0){
	        		fusearchsql +=" and devno like '" + nodes[0].id + ".%'";	        		        			        		
	        	}
	        	else{
	        		alert("保存失败！请确认是否正确选中父设备！");
	        		return;
	        	}			 	
			 	params+='&fusearchsql='+encodeURIComponent(fusearchsql);
			 		 	
			 	//注意：不要在此做空的判断 即使为空 也必须放入请求中			 	
			 	//每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}
				return params;
		}

        //批量删除
        function fuheDel(){
        			var params = fuheQbuildParams();//删除条件
		 									    
			 		//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
				 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
												  clsname:'ExecuteSql',//类名
												  method:'exeSqlData',//方法名
												  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												  tsdcf:'',//指向配置文件名称
												  tsdoper:'exe',//操作类型 
												  datatype:'xml',//返回数据格式 
												  tsdpk:'publicmode.fuheDeleteBy'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												});
					var link='mainServlet.html?'+urlstr1+params+'&tablename= air_device_detail &initialization= 1=1'; 
				 	$.ajax({
							url:link,
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(msg){
								if(msg=="true"){								
									var successful = $("#successful").val();									
									alert(successful);											
									setTimeout($.unblockUI, 0);								
									
									//刷新jqgrid	 显示表中所有数据
									insertRefresh_b();	
									
									//如果有可能值是汉字 请使用encodeURI()函数转码
								 	var fusearchsqlstr = $("#fusearchsql").val();		 	
								 	
								 	var nodes=zTreeObj.getSelectedNodes();
						        	if (nodes.length>0){
						        		fusearchsqlstr +=" and devno like '" + nodes[0].id + ".%'";	        		        			        		
						        	}
									//写入日志操作
									var conttext = 'DELETE FROM air_device_detail where '+transferApos(fusearchsqlstr);
									logwrite(4,"air_device_detail","",conttext);															
								}	
							}
					});
					
        }
        
        /**********************************************************
				function name:   logwrite()
				function:		 写日志
				parameters:      status ：状态 ：1添加 2删除 3修改 4批量删除 5批量修改
								 content ：写入日志的内容
				return:			 
				description:     写日志
				Date:			2010-9-13 
		********************************************************/
		function logwrite(status,tablename,content,condition){	
			tsd.QualifiedVal=true; 	
			switch(status){
				case 1:
				///增加		
						writeLogInfo("","add",tsd.encodeURIComponent("("+tablename+")"+$("#addinfo").val()+" : "+content));				
						break;
				case 2:
				///删除
						writeLogInfo("","delete",tsd.encodeURIComponent("("+tablename+")"+$("#deleteinfo").val()+" : "+condition));
						break;			
				case 3:
				///修改
						writeLogInfo("","edit",tsd.encodeURIComponent("("+tablename+")"+$("#editinfo").val()+" : "+content+"。"+$("#conditions").val()+" : "+condition));			
						break;			
				case 4:
				///批量删除		
						writeLogInfo("","Bulk Delete",tsd.encodeURIComponent("("+tablename+")"+$("#deletebinfo").val()+" :"+condition));	
						break;
				case 5:
				///批量修改		
						writeLogInfo("","Batch Edit",tsd.encodeURIComponent("("+tablename+")"+$("#modifybinfo").val()+" : "+condition));	
						break;			
			}
				
			//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
		}

        //控制编码长度输入框的显示隐藏
       	function fixedLen(){
        	if ($("#check1").attr("checked")==true){
        		$("div[name^='idlenD']").show();
        	}else{        		
        		$("div[name^='idlenD']").hide(); 
        	}
        }        
	</script>
</head>
	<div class="neirong" id="divBatchAdd" style="width:450px;display: none">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<span id="Batch_Title"></span>
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="setTimeout($.unblockUI,15);"><fmt:message key="global.close" /><!-- 关闭 --></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>
		<div class="midd" style="background-color:#FFFFFF;">
			<fieldset style="text-align: left;float: none;margin-top: 5px;margin-bottom: 5px;width: 408px;" id="deviceNamePan">
				<legend>设备名称</legend>	
				<div style="float: left;width: 100%;">
					<input type="checkbox" id="check1" onclick="fixedLen();"/><label for="check1">编码左补0</label> 
				</div>	
				<div id="deviceName1" style="clear: both;">
					<div style="float: left;">		 
						前缀1<input type="text" id="prefix1" style="width:74px;"/>
						<input type="text" id="beginid1" style="width:28px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>
						至
						<input type="text" id="endid1" style="width:28px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>	
						<font style="color: red;">*</font> 
					</div>
					<div style="float: left;display: none;margin-left:4px;" name="idlenD1">
						编码长度
						<input type="text" id="idlen1"  style="width:30px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>
					</div>
				</div>	
				<div id="deviceName2" style="clear: both;">
					<div style="float: left;">
						前缀2<input type="text" id="prefix2" style="width:74px;"/>
						<input type="text" id="beginid2" style="width:28px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>
						至
						<input type="text" id="endid2" style="width:28px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>			 
					</div>
					<div style="float: left;display: none;margin-left:4px;" name="idlenD2">
						编码长度
						<input type="text" id="idlen2" style="width:30px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>
					</div>
				</div>	
				<div id="deviceName3" style="clear: both;">	
					<div style="float: left;">
						前缀3<input type="text" id="prefix3" style="width:74px;"/>
						<input type="text" id="beginid3" style="width:28px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>
						至
						<input type="text" id="endid3" style="width:28px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>			 
					</div>
					<div style="float: left;display: none;margin-left:4px;" name="idlenD3">
						编码长度
						<input type="text" id="idlen3" style="width:30px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>
					</div>
				</div>	
				<div id="deviceName4" style="clear: both;" >
					<div style="float: left;">
						前缀4<input type="text" id="prefix4" style="width:74px;"/>
						<input type="text" id="beginid4" style="width:28px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>
						至
						<input type="text" id="endid4" style="width:28px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>			 
					</div>
					<div style="float: left;display: none;margin-left:4px; " name="idlenD4">
						编码长度
						<input type="text" id="idlen4" name="idlen4" style="width:30px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>
					</div>
				</div>	
				
			</fieldset>
			<div id="dh_b_D" class="midd_div" >
				<span class="midd_span" >绑定电话:</span>
				<input type="text" id="dh_b" style="width:242px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>(起始号码)
			</div>
			
			<div id="addr_b_D" class="midd_div" >
				<span class="midd_span" >设备地址:</span>
				<input type="text" id="addr_b" style="width:300px;"/>
			</div>
			
			<div id="mokuaiju_b_D" class="midd_div" >
				<span class="midd_span" >模块局:</span>
				<select id="mokuaiju_b"  style="width:302px;"></select>
			</div>
			<div id="ywarea_b_D" class="midd_div" style="border:1px;">
				<span class="midd_span">所属区域:</span>
				<select id="ywarea_b"  style="width:302px;"></select>							
			</div>
			<div id="portype_b_D" class="midd_div" style="border:1px;">
				<span class="midd_span">业务类型:</span>
				<select id="portype_b"  style="width:302px;"></select>							
			</div>
			<div id="pdevno_b_D" class="midd_div" style="display: none;">
				<span class="midd_span" >上级端口:</span>
				<input type="text" id="pdevno_b" style="width:300px;"/>
			</div>
			<div id="state_b_D" class="midd_div" >
				<span class="midd_span" >状态:</span>
				<select id="state_b" style="width:302px;"> </select>
			</div>
			<div id="devicon_b_D" class="midd_div" >
				<span class="midd_span" >图标:</span>
				<input type="text" id="devicon_b" style="width:300px;" 
				onfocus="disListIcon('twoiconlist_b','trhide_b','devicon_b')"/>
			</div>
			<!-- 展示图标可选择图片面板 -->
			<div id='trhide_b' class="midd_div" style="display: none;">
				<div id="twoiconlist_b" style="height: 100px;overflow-y: auto;overflow-x: hidden;">
				</div>
			</div>			
		</div>
		<div class="midd" style="background-color:#FFFFFF;height:135px; font-size:12px; width:433px;text-align:left; line-height:140%; padding-left:8px; padding-right:8px;">				
			<label style="font-weight:bold; color:red;">&nbsp&nbsp&nbsp&nbsp说明：</label> 
			1.设备名称生成规则:前缀+编码流水号(范围即上边的设定值；若勾选“编码左补0”
           选项，则流水号会按“编码长度”来补齐位数)。可生产四层循环设备名称，如A1
            -B1-C1-D1。填写设备名称前缀需从上往下填写，第一层为必填，第二层包括
            以下可选填，但是同一层的前缀、起始编号、截止编号必须为都填、或都不填。           
			2.绑定电话生成规则:按照起始号码顺序生成(每次加1)，也可以为空。 
			3.其余属性生成规则:所有批量新增的设备，都将一样。
			<label id='batchNodeExplain'> 4.在同一个设备下设备端口的名称不能重名；设备端口名称命名：建议端口名称用有含义前缀来标识该设备路径信息。</label>	
		</div>									 
		<div class="midd_butt" style="height:38px;">  
			<button onclick="batchSaveDetail($('#batchFlag').val());" class="tsdbutton" 
				style="margin-left: 20px;">
				保存
			</button>
			<button onclick="javascript:setTimeout($.unblockUI,15);" class="tsdbutton"  style="margin-left: 20px;">
				取消				
			</button>
		</div>
	</div>

    <input type="hidden" id="batchFlag"/>
    <!-- 高级查询 -->		
	<input type="hidden" id="queryName" name="queryName" value=""  />
	<input type="hidden" id="fusearchsql" name="fusearchsql"  />
	<!-- 查询树信息存放 保存模板查询 -->
	<input type="hidden" id='treepid' />	
	<input type="hidden" id='treecid' />	
	<input type="hidden" id='treestr' />	
	<input type="hidden" id='treepic' />
	<input type="hidden" id="successful" value="<fmt:message key="global.successful"/>" />
	<input type="hidden" id="addinfo" value="<fmt:message key="global.add"/>" /><!-- 添加 -->
	<input type="hidden" id="deleteinfo" value="<fmt:message key="global.delete"/>" /><!-- 删除 -->
	<input type="hidden" id="editinfo" value="<fmt:message key="global.edit"/>" /><!-- 修改 -->
	<input type="hidden" id="deletebinfo" value="<fmt:message key="tariff.deleteb"/>" /><!-- 批量删除 -->
	<input type="hidden" id="modifybinfo" value="<fmt:message key="tariff.modifyb"/>" /><!-- 批量修改 -->
