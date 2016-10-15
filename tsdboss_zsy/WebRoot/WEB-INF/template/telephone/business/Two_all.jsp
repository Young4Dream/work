<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/Tow.jsp
    Function:   电话获取空号
    Author:     wenxuming
    Date:       2010-10
    Description: 
    Modify: 
     2010-10月份： 对该页面进行移植，并对版式进行修改；
     2010-11-04：修改函数getRefresh(key)，因为刷新多次数据取不出来修改后没问题；
-----------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String languageType = (String) session.getAttribute("languageType");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = (String)session.getAttribute("groupid");//request.getParameter("groupid");
	String lanType = (String) session.getAttribute("languageType");
	String userareaid = (String) session.getAttribute("userarea");
	String changearea = (String)session.getAttribute("chargearea");
	String getnullarea = request.getParameter("getnullarea");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>    
	<title>查询空号</title>
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>	
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<!-- dtree需要导入文件 -->
		<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />	
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->	
	
		<!-- 收费结账专用js -->
		<script src="js/revenue/revenue.js" type="text/javascript" language="javascript"></script>	
		<link rel="stylesheet" type="text/css" href="css/themes/base/ui.all.css" />
		<script src="js/ui/ui.core.js" type="text/javascript"></script>
		<script src="js/ui/ui.accordion.js" type="text/javascript"></script>
		<script src="script/public/phoneservice.js" type="text/javascript"></script>
		
	<style type="text/css">
		#navBar1{  height:26px;background:url(style/imgs/daohangbg.jpg); line-height:28px;}
		cas{float:left; width:100%; height:26px;background:url(../imgs/daohangbg.jpg) repeat-x; line-height:28px;}
		#grid1 a,#grid2 a,#grid3 a,#grid4 a{font-weight:bold;}
		
		#wrapper{width:700px;border-width:0px;}
		
		#top_k{width:500px;height:35px;background-color:#07AFAF;color:#ffffff;font-size:20px;font-weight:bold;letter-spacing:1em;text-align:center;vertical-align:middle;line-height:35px;border:1px solid #99ccff;float:left;}
		
		#left_k{width:155px;height:330px;float:left;clear:both;overflow-x:scroll;border:1px solid #99ccff;}	
		#right_k{width:535px;height:330px;overflow-x:hidden;border:1px solid #99ccff;}
		
		#bottom_k{float:left;clear:both;width:500px;}
		#bottom_k ul li{display:inline;margin-left:70px;}
		#bottom_t{float:left;clear:both;width:500px;height:40px;}
		#bottom_t ul li{display:inline;margin-right:10px;}		
		#dj_d,#dj_g{width:80px;}
		#choose,#back{width:60px;}
		#accordion h2 a{font-size:14px;}
		#accordion ul li{margin-left:8px;margin-bottom:8px;border-bottom:#CCC 1px dashed;}
		.areahref {color:#333333;}
	</style>
	<script language="JavaScript"> 
	/*
	*屏蔽脚本错误信息
	
		function killErrors() { 
		return true; 
		} 
		window.onerror = killErrors; 
	*/	
	</script>
	<script language="javascript" type="text/javascript">
	//树
	var d = new dTree('d');
	//信息
	var Dat = null;	
	var treeD = {};
	
	$(function(){
		//见装机页面填写的标头放到空号选好权限中		
		var startDH = parseUrl(document.location.search,"startDH","");
		var endDh = parseUrl(document.location.search,"endDh","");
		$("#dj_d").val(startDH);
		$("#dj_g").val(endDh);		
		Dat = loadData("Hmzy_Detail","zh",2);		
		//Dat.colNames.length = Dat.colNames.length -1;
		//Dat.colModels.length = Dat.colModels.length -1;
		//alert(parseUrl("http://localhost:8080/tsd2009/mainServlet.html?pagename=busManagement/yiji.jsp&imenuid=1507&pmenuname=%E4%B8%9A%E5%8A%A1%E5%8F%97%E7%90%86&imenuname=%E7%A7%BB%E6%9C%BA&groupid=1~2~3&tsdtemp=0.22816731958748038#javascript:Ck(%27%E6%95%A6%E7%85%8C%E5%B1%80%27,%27%E5%B0%8F%E7%81%B5%E9%80%9A%27)","tsdtemp",""));
		Dat.setHidden(['Bz','MokuaiJu','YwArea','IsKeep','UserID','Jhj_ID','Dhlx']);
		//Dat.setHidden(['Bz','MokuaiJu','YwArea','UserID','Jhj_ID']);
		Dat.setWidth({Dh:153,Dh_Level:142});
		setUserRight();
		//loadNullGrid("","");
		getData();
		$("#back").click(function(){window.close();});
		//刷新空号信息
		$("#Refresh").click(function(){			
			getRefresh('nextpage');
		});
		$("#choose").click(function(){
			//window.dialogArguments.c_p_konghao.value = "konghao";
			var selidx = $("#editgrid").getGridParam("selrow");
			if(selidx!=null)
			{
				var selval = $("#editgrid").getCell(selidx,"Dh");
				var selmkj = $("#editgrid").getCell(selidx,"MokuaiJu");
				var seljid = $("#editgrid").getCell(selidx,"Jhj_ID");
				var selywarea = $("#editgrid").getCell(selidx,"YwArea");
				var selbz = $("#editgrid").getCell(selidx,"Bz");
				var res = fetchSingleValue("dbsql_phone.querytsd_ini",6,"&tsection="+tsd.encodeURIComponent('phonebusiness')+"&tident="+tsd.encodeURIComponent('mokuaiju'));
				var mokuaiju;
				if(res=="ywmokuaiju"){
					mokuaiju = fetchSingleValue("PhoneKaiHu.queryasys_areaywmokuaiju",6,"&area="+tsd.encodeURIComponent($("#area").val()));	
				}else{
					mokuaiju=selmkj;
				}
				
				var selidxarray = $("#editgrid").getGridParam("selarrrow");
				if(selidxarray.length==0)
				{
					alert("请选择要批装的电话");
					return;
				}
				var tval = [];
				for(var ii=0;ii<selidxarray.length;ii++)
				{
					var tmp_Dh = $("#editgrid").getCell(selidxarray[ii],"Dh");
					var tmp_Jhj_ID = $("#editgrid").getCell(selidxarray[ii],"Jhj_ID");
					var tmp_Dhlx = $("#editgrid").getCell(selidxarray[ii],"Dhlx");
					var tmp_MokuaiJu = $("#editgrid").getCell(selidxarray[ii],"MokuaiJu");
					if(null==tmp_Dh)
					{
						alert("没有批装的电话");
						return;
					}
					executeNoQuery("Two_all.deleteYhdang_tmp",6,"&Dh="+tmp_Dh+"&userid="+tsd.encodeURIComponent($("#skrid").val()));
					executeNoQuery("Two_all.insertYhdang_tmp",6,"&Dh="+tmp_Dh+"&Jhj_ID="+tmp_Jhj_ID+"&Dhlx="+tsd.encodeURIComponent(tmp_Dhlx)+"&MokuaiJu="+tsd.encodeURIComponent(tmp_MokuaiJu)+"&userid="+tsd.encodeURIComponent($("#skrid").val())+"&hth="+tsd.encodeURIComponent(parseUrl(document.location.search,"hth","")));
					//tval.push(tmp);
				}		
				//$.trim(tval.join(","));
				/*
				//重庆机场方面需要提示改电话模块局下还有多少端口可绑定
				var res = fetchMultiValue("Two.kygetPortnumber",6,"&mokuaiju="+tsd.encodeURIComponent(selmkj))
				if(res==undefined&&res==null&&re==""){
					res="无结果";
				}
				alert("该电话模块局下可绑定端口号数量为："+res+"个");
				/////////////////////////////////////////////////////
				*/				
				//autoBlockForm('dh_tmpts',5,'close',"#ffffff",false);//弹出查询框				
				window.dialogArguments.c_p_feedBack(selval,mokuaiju,seljid,selywarea,selbz);				
				window.close();
			}
			else
			{
				//alert("请选择你想要选取的号码");
				alert("<fmt:message key="phone.getinternet0438" />");
			}
		});
	});
		/*********
		* 根据刷新或级别查询数据
		* @param;
		* @return;
		**********/
		function getRefresh(key){
			var params = $("#params").val();		
				var str_d_to = "&Dh_Level_Min=" + $("#dj_d_to").val()+"&";			
				var str_d = "&Dh_Level_Min=" + $("#dj_d").val()+"&";				
				params=params.replace(str_d_to,str_d);
				
				//把当前的级别段放到隐藏渝中
				$("#dj_d_to").val($("#dj_d").val());
				var str_g_to = "&Dh_Level_Max=" + $("#dj_g_to").val()+"&";
				var str_g = "&Dh_Level_Max=" + $("#dj_g").val()+"&";
				params=params.replace(str_g_to,str_g);
				
				//把当前的级别段放到隐藏渝中
				$("#dj_g_to").val($("#dj_g").val());
				var khquerynew = "DhHead="+$("#kgquery").val()+"&";
				var khqueryold = "DhHead="+$("#kgqueryold").val()+"&";
				$("#kgqueryold").val($("#kgquery").val());
				params=params.replace(khqueryold,khquerynew);
				
				/*
				if($("#kgquery").val()!=""){
					$("#accordion a").css('color','#000000');	
					$("#hiddenmokuaiju").val("")
				}*/				
				var mokuaijunew = "mokuaiju="+$("#hiddenmokuaiju").val()+"&";
				var mokuaijuold = "mokuaiju="+$("#mokuaijuold").val()+"&";
				$("#mokuaijuold").val($("#hiddenmokuaiju").val());
				params=params.replace(mokuaijuold,mokuaijunew);
				
			$("#params").val(params);
			var urlstrto=tsd.buildParams({ packgname:'service',//java包
									clsname:'Procedure',//类名
									method:'exequery',//方法名
									ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdExeType:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpname:'GetNullDh_all'
									});
			if(key != 'query'){
				$("#number").val(parseInt($("#number").val(),10)+50);
			}									
													
			$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstrto+params+"&number="+$("#number").val()}).trigger("reloadGrid");			
		}
	
		function generatrLevel(level,pos)
		{
			var kHtml = "";
			var ll = parseInt(level);
			for(var kl=0;kl<=ll;kl++)
			{
				kHtml += "<option value=\"" + kl + "\"" + (pos==2?(kl==ll?" selected=\"selected\" ":""):"") + ">" + kl + "</option>";
			}
			
			return kHtml;
		}
		
		function setUserRight()
		{
			var allRi = fetchMultiPValue("Duty.getPower",6,"&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
			if(typeof allRi == 'undefined' || allRi.length == 0)
			{
				//$("#dj_d").html(generatrLevel(0));
				//$("#dj_g").html(generatrLevel(0));				
				//$("#dj_d").html(getphoneLevel());
				//$("#dj_g").html(getphoneLevel());
				return false;
			}
			if(allRi[0][0]=="all")
			{
				$("#getnullarea").val("true");
				//getJiBie();
				//$("#dj_d").html(getphoneLevel());
				//$("#dj_g").html(getphoneLevel());				
				return true;
			}
			var hmjb = '0';
			
			for(var i = 0;i<allRi.length;i++){
				if(getCaption(allRi[i][0],'RightsGroup','')=="10")
				{
					hmjb = '10';
				}
				else if(hmjb!='10' && getCaption(allRi[i][0],'RightsGroup','')=="3")
				{
					hmjb = '3';
				}
				else if(hmjb!='10' && hmjb!='3' && getCaption(allRi[i][0],'RightsGroup','')=="0")
				{
					hmjb = '0';
				}
			}
			
			if(hmjb=='0')
			{
				//$("#dj_d").html(getphoneLevel());
				//$("#dj_g").html(getphoneLevel());
			}
			else if(hmjb=='3')
			{
				//$("#dj_d").html(getphoneLevel());
				//$("#dj_g").html(getphoneLevel());
			}
			else if(hmjb=='10')
			{
				//getJiBie();
				//$("#dj_d").html(getphoneLevel());
				//$("#dj_g").html(getphoneLevel());
			}
			/*
			$("#ableTuiFeiEJ").val(Interregional);			
			$("#dj_d").val(res[0][0]);		
			$("#dj_g").val(res[0][1]);
			*/
		}
		
		//获取号码等级
		function getphoneLevel(){	
			var res = fetchMultiArrayValue("teljob.getphoneLevel",6,"");
			if(res[0][0]==undefined||res[0]==undefined){
				return;
			}
			var hmjb='';
			for(var i=0;i<res.length;i++){
				hmjb+= "<option value=\"" + res[i][0] + "\">" + res[i][0] + "</option>";
			}
			return hmjb;
		}
		
		function parseFunFromUrl(url)
		{
			var tag = "#javascript:";
			//alert(url.lastIndexOf(tag));
			return url.substring(url.lastIndexOf(tag)+tag.length);
		}
		
		function generateTree(p,q)
		{
		/*
			d = new dTree('d');
			var k = 1;
			d.add(0,-1,"N 0","#");
			for(var i=1;i<=p.length;i++)
			{
				k = p.length + 1;
				d.add(i,0,p[i-1],"");
				
				for(var j=1;j<=q[i-1].length;j++)
				{
					d.add(k++,i,q[i-1][j-1],"#javascript:Ck('" + p[i-1] + "','" + q[i-1][j-1] + "')");
				}
			}
			
			$("#left_k").html(d.toString());
			
			$.each($(".dTreeNode a[href*='#javascript:Ck']"),function(i,n){			
				$(n).click(function(){
					//alert("K");
					eval(parseFunFromUrl($(n).attr("href")));			
				});
			});
		*/	
			if(p==""||p==undefined||p==undefined+","){
				//alert("请在业务区域中配置空号模块局！");
				alert("<fmt:message key="phone.getinternet0439" />");
				window.close();
				return;
			}	
			var str=new Array();
			str=p.split(",");
			if($("#kgquery").val()==""){
				loadNullGrid(str[0],"");
				$("#hiddenmokuaiju").val(str[0]);
			}else{
				loadNullGrid(p,"");
			}
			
			var inerHtm = "";
			inerHtm += "<div id=\"accordion\">";		
			for(var i=1;i<=str.length;i++)
			{
					inerHtm += "<h2><a href=\"#\" id='"+str[i-1]+"' onclick=\"Ck('"+str[i-1]+"')\">" + str[i-1] + "</a></h2>";				
					inerHtm += "<div>";
					inerHtm += "<p>";
					inerHtm += "<ul>";
					/*			
					for(var j=1;j<=q[i-1].length;j++)
					{
							inerHtm += "<li>";
							inerHtm += j;
							inerHtm += "、<a href=\"#\" id='"+q[i-1][j-1]+"' class=\"areahref\" onclick=\"Ck('";
							inerHtm += str[i-1]
							inerHtm += "','"
							inerHtm += q[i-1][j-1]
							inerHtm += "')\">";
							inerHtm += q[i-1][j-1];
							inerHtm += "</a>";
							inerHtm += "</li>";					
					}*/
					inerHtm += "</ul>";				
					inerHtm += "</div>";
					inerHtm += "</p>";					
			}				
			inerHtm += "</div>";		
			$("#left_k").html(inerHtm);
			//默认电话标头为空时加载第一个模块局信息，将超链接变色
			if($("#kgquery").val()==""){
				$("#accordion a").css('color','#000000');
				$("#"+str[0]+"").css("color","red");
			}
		}
			
		/*********
		* 查询模块局信息
		* @param;
		* @return;
		**********/
		function getData()
		{
			var userareaid = $("#userareaid").val();
			var mokuaiju="";
			/****
			if(getnullarea!='true'||getnullarea==undefined||getnullarea=='undefined'){		
				mokuaiju = fetchMultiValue("PhoneKaiHu.fetchMoKuaiJu_toarea",6,"&area="+tsd.encodeURIComponent(userareaid));				
			}else{				
				mokuaiju = fetchMultiValue("PhoneKaiHu.fetchMoKuaiJu",6,"");						
			}****/
			//var mokuaiju = fetchMultiValue("PhoneKaiHu.queryasys_areaywmokuaiju",6,"&area="+tsd.encodeURIComponent($("#area").val()));
			var key="";
			var allarea = $("#getnullarea").val();
			if(allarea=="true"){
				key="lineDeviceManager.getMoKuaiJu";
			}else{
				key="PhoneKaiHu.queryasys_areaywmokuaiju";			
			}			
			var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mysql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					//tsdpk:"PhoneKaiHu.queryasys_areaywmokuaiju",//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdpk:key,
						 					tsdUserID:'ture'
						 				});	
		                   $.ajax({
					              url:'mainServlet.html?'+urlstr+'&area='+tsd.encodeURIComponent($("#area").val()),
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){					              
					              $(xml).find('row').each(function(){					              	
					              	if(allarea=="true"){
										mokuaiju+=$(this).attr("mokuaiju")+',';
									}else{
										mokuaiju=$(this).attr("ywmokuaiju");		
									}
					              });
					              }
					       });       
			var mokuaijudq = [];
			/*
			for(var i=0;i<mokuaiju.length;i++)
			{
				mokuaijudq[i]=fetchMultiValue("PhoneKaiHu.fetchMoKuaiDiQu",6,"&MokuaiJu="+tsd.encodeURIComponent(mokuaiju[i]));	
			}*/
			generateTree(mokuaiju,mokuaijudq);
		}
		
		function getJiBie()
		{
			var res = fetchMultiArrayValue("PhoneKaiHu.fetchJiBie",6,"");
			if(res[0] == undefined)
			{
				return false;
			}
			
			$("#dj_d").html(generatrLevel(res[0][0],1));	//.val(res[0][0]);			
			$("#dj_g").html(generatrLevel(res[0][1],2));	//.val(res[0][1]);
			
		}
				
		/*********
		* 树单击事件
		* @param;
		* @return;
		**********/
		function Ck(p,q)
		{
			$("#accordion a").css('color','#000000');
			$("#"+q+"").css("color","red");
			$("#"+p+"").css("color","red");
			loadNullGrid(p,q);
		}
				
		/*********
		* 加载 空号
		* @param;
		* @return;
		**********/	
		function loadNullGrid(mokuaiju,mokuaijudq)
		{	
			$("#mokuaijuhidden").val(mokuaiju);
			$("#ri_grid").empty();
			$("#ri_grid").append("<table id=\"editgrid\" class=\"scroll\"></table><div id=\"pagered\" class=\"scroll\" style=\"text-align:left\"></div>");			
			//var nhead = parseUrl(document.location.search,"DhHead","");旧的获取装机页面电话开头数据
			var nhead = $("#kgquery").val();
			$("#kgqueryold").val(nhead);
			var dhlx = parseUrl(document.location.search,"Dhlx","");			
			dhlx = decodeURIComponent(dhlx);
			var key = "PhoneKaiHu.QuKongHaoSql2";
			if(nhead=="" || nhead==undefined)
			{
				key = "PhoneKaiHu.QuKongHaoSql2";
			}
			else
			{
				key = "PhoneKaiHu.QuKongHaoSql";
			}
			
			var urlstr=tsd.buildParams({ packgname:'service',//java包
										clsname:'Procedure',//类名
										method:'exequery',//方法名
										ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdExeType:'query',//操作类型 
										datatype:'xml',//返回数据格式 
										tsdpname:'GetNullDh_all'
										});								
			//每次拼接参数必须初始化此参数
			tsd.QualifiedVal=true;			
			var params = "";
			params = params + "&DhHead=" + nhead;
			params = params + "&Dh_Level_Min=" + $("#dj_d").val().replace(/(^\s*)|(\s*$)/g,"");
			params = params + "&Dh_Level_Max=" + $("#dj_g").val().replace(/(^\s*)|(\s*$)/g,"");
			params = params + "&mokuaiju=" + tsd.encodeURIComponent(mokuaiju);
			$("#mokuaijuold").val(mokuaiju);
			if(mokuaijudq==undefined||mokuaijudq=="undefined"){mokuaijudq="";}
			params = params + "&mokuaiju2=" + tsd.encodeURIComponent(mokuaijudq);
			//params = params + "&mokuaiju2=" + mokuaijudq;			
			var userareaid = $("#userareaid").val();
			var charea = $("#area").val();							
			params = params + "&Area=" + tsd.encodeURIComponent(charea);
			//tsd.encodeURIComponent(userareaid)
			params = params + "&Dhlx=" + tsd.encodeURIComponent(dhlx);
			//params = params + "&Dhlx=" + dhlx;
			params = params + "&Uidd=" + tsd.encodeURIComponent($("#skrid").val());
			//params = params + "&Uidd=" + $("#skrid").val();
			params = params + "&userid=" + $("#skrid").val();		
			$("#params").val(params);
			//把当前的级别段放到隐藏渝中
			$("#dj_d_to").val($("#dj_d").val());
			$("#dj_g_to").val($("#dj_g").val());
			//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
			$("#editgrid").jqGrid({
					url:'mainServlet.html?'+urlstr + params,
					datatype: 'xml', 
					colNames:Dat.colNames, 
					colModel:Dat.colModels, 
					       	rowNum:50, //默认分页行数
					       	imgpath:'css/jqgrid/themes/basic/images/', 
					       	//pager: jQuery('#pagered'), 
					       	viewrecords: true, 
					       	height:290, //高
							multiselect:true,
					       	//width:500,
					       	//width:document.documentElement.clientWidth-27,
					       	loadComplete:function(){
								/*
								//执行选择按钮事件
								$("#editgrid tr").dblclick(function(){
									$("#choose").click();
								});
								
								var hmlevel = fetchMultiKVValue("nums21.query1",6,"",["hm_level","bz"]);
								var idss = $("#editgrid").getDataIDs();
								
								for(var kl=0;kl<idss.length;kl++)
								{
									var vall = $("#editgrid").getRowData(idss[kl])["Dh_Level"];
									$("#editgrid").setRowData(idss[kl],{"Dh_Level":hmlevel[vall]});
								}*/
							}
					}).navGrid('#pagered1', {edit: false, add: false, add: false, del: false, search: false}, //options 
						{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
						{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
						{reloadAfterSubmit:false}, // del options 
						{} // search options 
						);			 
		}
	</script>
	<script  language="javascript" type="text/javascript">
		//开户取空号标头别名专用方法
		function loadData(tablename,language,index,OperationName)
		{
		//语言参数
		if(language==null || language=="" || language!="en")
		{
			language = "zh";
		}
		//修改列位置参数
		if(index==null)
		{
			index = 1;
		}
		var gridData = new Object();
		//取数据集
		var res = fetchMultiArrayValue("main.fetchInfoLimit_phone",6,"&table="+tablename);
		if(typeof res[0]=='undefined')
		{
			//取值失败，返回false;
			return false;
		}
		
		//第2维的长度
		var zidx = res.length;
		//第1维的升序
		var yidx = res[0].length;
		//列别名，用于jqGrid列头显示
		this.colNames = [];
		//列名，用于jqGrid列显示
		this.colModels = [];
		//列名
		this.FieldName = [];
		//列别名
		this.FieldAlias = [];
		//列数据类型
		this.DataType = [];
		
		this.AliasKeyVal = fetchFieldAlias(tablename,language);
		
		var temp = "";
		
		for(var i=0;i<zidx;i++)
		{
			//列名
			FieldName.push(res[i][0]);
			
			//数据类型
			DataType.push(res[i][2]);
			//获取操作列名字段信息
			temp = getCaption(res[i][1],language,res[i][1]);
			//别名
			FieldAlias.push(temp);
			//
			colNames.push(temp);
			//生成操作列name,index信息
			temp = "{name:'"+ res[i][0] + "',index:'" + res[i][0] + "',width:" + (res[i][3]==undefined?"80":res[i][3]) + "}";
			colModels.push(eval("(" + temp + ")"));
		}		
		//操作列语言及位置设置
		if(language=="zh")
		{
			if(index==1)
			{
				colNames.unshift(OperationName==undefined?"<fmt:message key="phone.getinternet0342" />":OperationName);
				//设置第一最后一列为操作列
				temp = "{name:'viewOperation',index:'viewOperation',width:100}";
				colModels.unshift(eval("(" + temp + ")"));
			}
			else if(index==0)
			{
				colNames.push(OperationName==undefined?"<fmt:message key="phone.getinternet0342" />":OperationName);
				//设置最后一列为操作列
				temp = "{name:'viewOperation',index:'viewOperation',width:100}";
				colModels.push(eval("(" + temp + ")"));
			}
			else
			{}
		}
		else
		{
			if(index==1)
			{
				colNames.unshift(OperationName==undefined?"Operation":OperationName);
				//设置第一最后一列为操作列
				temp = "{name:'viewOperation',index:'viewOperation',width:100}";
				colModels.unshift(eval("(" + temp + ")"));
			}
			else if(index==0)
			{
				colNames.push(OperationName==undefined?"Operation":OperationName);
				//设置最后一列为操作列
				temp = "{name:'viewOperation',index:'viewOperation',width:100}";
				colModels.push(eval("(" + temp + ")"));
			}
			else
			{}
		}
		//alert(colNames.length+":"+colModels.length+":"+FieldName.length+":"+FieldAlias.length+":"+DataType.length);
		//alert(colModels.length);	
		gridData.FieldName = FieldName;	
		gridData.FieldAlias = FieldAlias;	
		gridData.DataType = DataType;	
		gridData.colNames = colNames;	
		gridData.colModels = colModels;	
		gridData.AliasKeyVal = AliasKeyVal;
		
		//根据字段名取别名
		gridData.getFieldAliasByFieldName=function(fname)
		{/*
			var idx = $.inArray(fname,gridData.FieldName);			
			if(idx==-1)
			{
				return "无列名";
			}
			else
			{
				return gridData.FieldAlias[idx];
			}*/
			return (AliasKeyVal==undefined || AliasKeyVal[fname]==undefined)?"<fmt:message key="phone.getinternet0361" />":AliasKeyVal[fname];
		}
		
		//根据字段名设置宽度
		/*gridData.setWidth=function(obj)
		{
			$.each(obj,function(i,n){
				
				var idx = $.inArray(i,gridData.FieldName);				
				
				if(idx!=-1)
				{
					if(index==1)
					{
						idx += 1;
					}
					gridData.colModels[idx].width = n;
				}
			});
		}*/
		
		gridData.setWidth=function(obj)
		{
			$.each(obj,function(i,n){
				
				if(i=="Operation")
				{
					if(index==1)
					{
						gridData.colModels[0].width = n;
					}
					else if(index==0)
					{
						gridData.colModels[zidx].width = n;
					}
					else
					{
						//just do it
					}
				}
				else
				{
					var idx = $.inArray(i,gridData.FieldName);				
					
					if(idx!=-1)
					{
						if(index==1)
						{
							idx += 1;
						}
						gridData.colModels[idx].width = n;
					}
				}
			});
		}
		
		/////设置隐藏
		gridData.setHidden=function(obj)
		{
			$.each(obj,function(i,n){
				
				var idx = $.inArray(n,gridData.FieldName);			
				
				if(idx!=-1)
				{
					if(index==1)
					{
						idx += 1;
					}
					gridData.colModels[idx].hidden = true;
				}
			});
		}
		
		return gridData;
	}
	</script>
  </head>  
  <body>
		<div id="wrapper">
			<div id="top_k"><fmt:message key="phone.getinternet0440" /><!-- 查询空号 --></div>
			<div id="bottom_t">
			  <ul>
				<li>
						电话区间
						<!-- <select name="dj_d" id="dj_d" onchange="getRefresh('1')"></select> -->
						<input type="text" id="dj_d" />
					</li>
					<li>
						--
					</li>
					<li>
						<!-- <select name="dj_g" id="dj_g" onchange="getRefresh('2')"></select> -->
						<input type="text" id="dj_g" />
					</li>
					<li>
						<input type="text" style="width:100px;display:none;" id="kgquery"/>
					</li>					
					<li>
						<button class="tsdbutton" id="querykonghao"
									onclick="getRefresh('query')"
									style="width:45px;height: 22px; margin-top: 3px; padding: 0px;"><fmt:message key="phone.getinternet0466" /><!-- 查找 --></button>
					</li>
				</ul>				
			</div>			
			<div id="left_k">
			</div>
			<div id="right_k">
				<div id="ri_grid"></div>
			</div>
			<div id="bottom_k">
				<ul>					
					<li>
						<button id="choose" name="choose" class="tsdbutton">
							<fmt:message key="phone.getinternet0075" /><!-- 选择 -->
						</button>
					</li>				
					<li>
						<button id="back" name="back" class="tsdbutton">
							<fmt:message key="phone.getinternet0443" /><!-- 返回 -->
						</button>
					</li>
					<li>
						<button id="Refresh" name="Refresh" class="tsdbutton">
							<fmt:message key="phone.getinternet0444" /><!-- 翻页-->
						</button>
					</li>					
				</ul>				
			</div>
		</div>
		
		<!-- 菜单ID -->
		<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
		<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
		<!-- 语言 -->
		<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>' />		
		<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea") %>' />
		<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea") %>' />
		<input type="hidden" id="skrid" name="skrid" value='<%=session.getAttribute("userid") %>' />		
		<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
		<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
		<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 		
		<input type="hidden" id="userareaid" value="<%=userareaid %>"/>
		<input type="hidden" id="dj_d_to" name="dj_d_to"/>
		<input type="hidden" id="dj_g_to" name="dj_g_to"/>
		<input type="hidden" id="mokuaijuhidden" name="mokuaijuhidden"/><!-- 模块局隐藏 -->
		<!--刷新空号数据时条件从这里取 -->
		<input type="hidden" id="params" name="params" style="width:500px;"/>
		<!-- 获取空号权限 -->
		<input type="hidden" id="getnullarea" name="getnullarea" value="<%=getnullarea %>"/>
		<input type="hidden" id="kgqueryold"/><!-- 得到旧电话标头 -->
		<input type="hidden" id="hiddenmokuaiju"/><!-- 空号模块中的选好限制为空时传左边模块局中最上面的模块局进去 -->
		<input type="hidden" id="mokuaijuold"/><!-- 得到旧的模块局信息以备替换只用 -->
		<input type="hidden" id="number" value='0'/>
		<div class="neirong" id="dh_tmpts"	style="width:600px;display: none">
			<span id="tsvalues">数据处理中……</span>
		</div>
		<jsp:include page="phone_internet.jsp" flush="true"/>
	</body>
</html>
