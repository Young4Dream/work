<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
            <%-- 
    File Name:  112jobmanager.jsp
    Function:   112障碍工单管理
    Author:     chenliang
    Date:       2010-09-01
    Description: 对112障碍工单管理的一个管理
    Modify:     
        2011-6-22   youhongyu   详细信息中号线信息显示
        2012-02-27  chenliang   完工工单时，处理人员可单选或多选
 --%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
    String iconpath = basePath + "style/icon/";
    String languageType = (String) session.getAttribute("languageType");
    String groupid = request.getParameter("groupid");
    //String path = request.getContextPath();
    //String basePath = request.getScheme() + "://"
    //      + request.getServerName() + ":" + request.getServerPort()
    //      + path + "/";
    //String iconpath = basePath + "style/icon/";
    
    String userid = (String) session.getAttribute("userid");
    String imenuid = request.getParameter("imenuid");
    String zid = request.getParameter("groupid");
    String pmenuname = request.getParameter("pmenuname");
    String imenuname = request.getParameter("imenuname");
    String departname = (String)session.getAttribute("departname");
    //String languageType = (String) session.getAttribute("languageType");
    if (!languageType.equals("en")) {
            languageType = "zh";
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>112故障工单管理</title>
    <link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
    <script src="css/jqgrid/jquery.js" type="text/javascript"></script>
    <script src="css/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
    <script src="css/jqgrid/js/jqModal.js" type="text/javascript"></script>
    <script src="css/jqgrid/js/jqDnR.js" type="text/javascript"></script>
    <link href="style/css/tsd-css.css" rel="stylesheet" type="text/css" />
    <script src="style/js/mainStyle.js" type="text/javascript"></script>
    <!-- 验证框架需要导入的js文件 -->
    <script src="js/validate/jquery.validate.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" media="screen" href="../../js/validate/css/screen.css" />
    <!-- 弹出面板需要导入js文件 -->
    <script src="js/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/ui/jquery.ui.draggable.js"></script>
    <script type="text/javascript" src="js/split/main.js"></script>
    <script type="text/javascript" src="js/split/transfer.js"></script>
    <script src="js/revenue/revenue.js" type="text/javascript" language="javascript"></script>
    <!-- 新的面板样式 -->
    <link href="style/xin.css" rel="stylesheet" type="text/css" />
    <!-- 导入的js文件 -->
    <script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
    <script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
    <script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
    <script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
    <script src="script/public/mainStyle.js" type="text/javascript"></script>
    <script src="style/js/mainStyle.js" type="text/javascript"></script>
    <!-- 弹出对话框需要导入的js文件 -->
    <script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
    <script type="text/javascript" src="script/public/transfer.js"></script>
    <!-- 弹出面板需要导入js文件 -->
    <script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
    <!-- 关于字符串需要用到的js -->
    <script type="text/javascript" src="script/public/main.js"></script>
    <!-- 收费结账专用js -->
    <script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
    <!-- 页面国际化 -->
    <script type="text/javascript" src="script/broadband/usercat/Internationalization.js"></script>
    <!-- 时间插件 -->
    <script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
    <!-- 导入js文件结束 -->
    <!-- 导入css文件开始 -->
    <link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
    <link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
    <link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="css/tree/dtree.css" />
    <script type="text/javascript">
    $(document).ready(function() {
        //获取导航菜单
        $("#navBar1").append(genNavv());
        getpxry();
        getUseMokuaijus();
        getUserPower(); //获取用户权限
        getJobList(); //112故障工单
        getSelectGzList(); //故障信息显示工单
        thisDetailField(); //要显示明细的字段
        getHxPower(); //获取可修改号线信息的权限
        var endjobsright = $('#endjobsright').val();
        if (endjobsright == 'true') {
            $('#endjobs').removeAttr('disabled');
        }
    });
    //获取工单列表
    function getUseMokuaijus() {
        $("#usermokuaijus").val('<%=session.getAttribute("managerarea") %>');
        /**
        var params = '&userid=' ;
        $.ajax({
                        url:"mainServlet.html?packgname=service&clsname=ExecuteSql&method=exeSqlData&ds=tsdBilling&tsdcf=enterprisedb&tsdoper=query&datatype=xmlattr&tsdpk=112jobmanager.getUserMokuaijus"+params,
                        datatype:'xml',
                        cache:false,
                        timeout:1000,
                        async:false,
                        success:function(xml){
                            $(xml).find("row").each(function(){
                                var modimokuaijus=$(this).attr("modimokuaijus");
                                if(modimokuaijus!=undefined){
                                    $("#usermokuaijus").val(modimokuaijus);//登入员工的模块局
                                }
                            });
                        }
                    });
        */
    }
    //获取工单列表
    function getJobList() {
        var str = '';
        //权限是否限制部门
        var userright = $('#islimitdeptright').val();
        var modimokuaijus = $("#usermokuaijus").val();
        var paramsstr = '&area=' + tsd.encodeURIComponent(modimokuaijus);
        str = '0';
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xml', //返回数据格式 
            tsdpk: '112jobmanager.queryjoblist0', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
            tsdpkpagesql: '112jobmanager.queryjoblistpage0' //依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
        });
        var column = '';
        var thisdata = loadData('T112_Pxsg', '<%=languageType%>', 2);
        column = thisdata.FieldName.join(',');
        var ywqy='<%=session.getAttribute("managearea") %>';
        if(ywqy=="全地区"){
          urlstr= urlstr.replace("112jobmanager.queryjoblist0", "112job.select");
        }
        
        var url = 'mainServlet.html?cloumn=' + column + '&' + urlstr + '&userid=<%=session.getAttribute("userid") %>&mqbm=' + tsd.encodeURIComponent('<%=session.getAttribute("departname") %>') + '&area=' + tsd.encodeURIComponent(ywqy) + paramsstr;
        $('#thecolumn').val(column);
        //jqgrid隐藏某一列的值
        //thisdata.colModels[0].hidden = true;
        thisdata.setWidth({
            Operation: 20
        });
        jQuery("#editgrid").jqGrid({
            url: url,
            datatype: 'xml',
            colNames: thisdata.colNames,
            colModel: thisdata.colModels,
            rowNum: 30, //默认分页行数
            rowList: [30, 50, 100], //可选分页行数
            imgpath: 'plug-in/jquery/jqgrid/themes/basic/images/',
            pager: jQuery('#pagered'),
            sortname: 'ID', //默认排序字段
            viewrecords: true,
            //hidegrid: false, 
            sortorder: 'desc', //默认排序方式 
            caption: '112故障工单列表',
            multiselect: true,
            multiselectWidth: 20,
            height: document.documentElement.clientHeight - 155, //高
            width: document.documentElement.clientWidth - 82,
            loadComplete: function() {
                //$("#editgrid").setSelection('0', true);
                //$("#editgrid").focus();
                ///自动适应 工作空间
                //var reduceHeight=$("#navBar1").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
                //setAutoGridHeight("editgrid",reduceHeight);
                //addRowOperBtn('editgrid','<img src="style/images/publics/ltubiao_02.gif" alt="删除"/>','deleteRow','lid','click',1);
                //executeAddBtn('editgrid',1);
                showpxryName('editgrid', 1);
            },
            ondblClickRow: function(ids) {

                if (ids != null) {
                    //alert($('#editgrid').getCell(ids,'ID'));
                    var dh = $('#editgrid').getCell(ids, 'Dh');
                    var mqbm = $('#editgrid').getCell(ids, 'Mqbm');
                    var id = $('#editgrid').getCell(ids, 'ID');
                    var lxdh = $('#editgrid').getCell(ids, 'Lxdh');
                    $("#gzlxdh").val(lxdh);
                    $("#gzid").val(id);
                    thisInfo(dh, mqbm, 2); //显示详细信息
                }
            }
        }).navGrid('#pagered', {
                edit: false,
                add: false,
                add: false,
                del: false,
                search: false
            }, //options 
            {
                height: 280,
                reloadAfterSubmit: true,
                closeAfterEdit: true
            }, // edit options 
            {
                height: 280,
                reloadAfterSubmit: true,
                closeAfterAdd: true
            }, // add options 
            {
                reloadAfterSubmit: false
            }, // del options 
            {} // search options 
        );


    }


    //将派修人员的名字显示为中文
    //替换jqgrid表中Pxry列的派修人员名称
    function showpxryName(gridId, count) {
        var menuTblRow = document.getElementById(gridId).rows;
        var len = menuTblRow.length;

        for (var j = 0; j < len; j++) {
            var Pxryid = $('#editgrid').getCell(j, 'Pxry');
            if (Pxryid != '' && pxryNameF[Pxryid] != undefined) {
                jQuery("#" + gridId).setRowData(j, {
                    Pxry: pxryNameF[Pxryid][0]
                });
            }
            /**
            var Wxryid = $('#editgrid').getCell(j,'Wxry');              
            if(Wxryid!=''&&pxryNameF[Wxryid]!=undefined){
                    jQuery("#"+gridId).setRowData(j,{Wxry:pxryNameF[Wxryid][0]});
            }
            */
        }
    }

    //获取系统管理员配置权限
    function getUserPower() {
        var urlstr = tsd.buildParams({
            packgname: 'service',
            clsname: 'Procedure',
            method: 'exequery',
            ds: 'tsdBilling', //数据源名称 对应的spring配置的数据源
            tsdpname: 'teljobmanager.getPower', //存储过程的映射名称
            tsdExeType: 'query',
            datatype: 'xmlattr'
        });
        /************************
         *   调用存储过程需要的参数 *
         **********************/
        var userid = '<%=session.getAttribute("userid") %>';
        var groupid = '<%=groupid %>';
        var imenuid = '<%=request.getParameter("imenuid") %>';

        /****************
         *   拼接权限参数 *
         **************/

        /**
        var receright = '';//接收的权限
        var deleteright = '';//删除的权限
        var printright = '';//打印的权限
        var submitright = '';
        var pauseright = '';//挂起权限
        var aliveright = '';//激活权限
        var editvalue1right = '';//编辑交换机端口的权限
        var editvalue2right = '';//编辑内配的权限
        var editvalue3right = '';//编辑外配的权限
        var editvalue4right = '';//编辑主干电缆的权限
        var editvalue5right = '';//编辑分电缆的权限
        var editvalue6right = '';//编辑二级交接箱的权限
        var editvalue7right = '';//编辑配线架的权限
        var editvalue8right = '';//编辑分线盒的权限
        var editvalue9right = '';//编辑用户电缆的权限
        */
        var islimitdeptright = ''; //是否限制部门处理业务
        var endjobsright = ''; //是否可以进行确认完工

        var flag = false;
        var spower = '';

        $.ajax({
            url: 'mainServlet.html?' + urlstr + '&userid=' + userid + '&groupid=' + groupid + '&menuid=' + imenuid,
            datatype: 'xml',
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 1000,
            async: false, //同步方式
            success: function(xml) {
                $(xml).find('row').each(function() {
                    spower += $(this).attr("spower") + '@';
                });
            }
        });
        var str = 'true';
        if (spower != '' && spower != 'all@') {
            $('#pauseli').hide();
            $('#aliveli').hide();
            var spowerarr = spower.split('@');
            for (var i = 0; i < spowerarr.length; i++) {
                islimitdeptright += getCaption(spower, 'islimitdept', '') + '|';
                endjobsright += getCaption(spower, 'endjobs', '') + '|';
                /**
                receright += getCaption(spower,'receive','')+'|';
                            
                deleteright += getCaption(spower,'delete','')+'|';
                            
                printright += getCaption(spower,'print','')+'|';
        
                submitright += getCaption(spower,'submitjob','')+'|';   
        
                pauseright += getCaption(spower,'pausejob','')+'|'; 
        
                aliveright += getCaption(spower,'alivejob','')+'|';     
        
                editvalue1right += getCaption(spower,'editvalue1','')+'|';      
                editvalue2right += getCaption(spower,'editvalue2','')+'|';      
                editvalue3right += getCaption(spower,'editvalue3','')+'|';      
                editvalue4right += getCaption(spower,'editvalue4','')+'|';      
                editvalue5right += getCaption(spower,'editvalue5','')+'|';      
                editvalue6right += getCaption(spower,'editvalue6','')+'|';      
                editvalue7right += getCaption(spower,'editvalue7','')+'|';      
                editvalue8right += getCaption(spower,'editvalue8','')+'|';      
                editvalue9right += getCaption(spower,'editvalue9','')+'|';      
                */
            }
        } else if (spower == 'all@') {
            $("#islimitdeptright").val('false');
            $("#endjobsright").val('true');

            /**
            $("#pauseright").val(str);
            $("#aliveright").val(str);
            $("#receright").val(str);
            $("#deleteright").val(str);
            $("#printright").val(str);
            $("#submitright").val(str);
    
            //用户编辑号线的权限
            $("#editvalue1right").val(str);
            $("#editvalue2right").val(str);
            $("#editvalue3right").val(str);
            $("#editvalue4right").val(str);
            $("#editvalue5right").val(str);
            $("#editvalue6right").val(str);
            $("#editvalue7right").val(str);
            $("#editvalue8right").val(str);
            $("#editvalue9right").val(str);
            */
            flag = true;
        }
        /**
        var hasrece = receright.split('|');
        var hasdelete = deleteright.split('|');
        var hasprint = printright.split('|');
        var hassubmit = submitright.split('|');
        var haspause = pauseright.split('|');
        var hasalive = aliveright.split('|');
        var haseditvalue1right = editvalue1right.split('|');
        var haseditvalue2right = editvalue2right.split('|');
        var haseditvalue3right = editvalue3right.split('|');
        var haseditvalue4right = editvalue4right.split('|');
        var haseditvalue5right = editvalue5right.split('|');
        var haseditvalue6right = editvalue6right.split('|');
        var haseditvalue7right = editvalue7right.split('|');
        var haseditvalue8right = editvalue8right.split('|');
        var haseditvalue9right = editvalue9right.split('|');
        */
        var hasislimitdeptright = islimitdeptright.split('|');
        var hasendjobsright = endjobsright.split('|');

        if (flag == false) {
            for (var i = 0; i < hasislimitdeptright.length; i++) {
                if (hasislimitdeptright[i] == 'true') {
                    $("#islimitdeptright").val(str);
                    break;
                }
            }

            for (var i = 0; i < hasendjobsright.length; i++) {
                if (hasendjobsright[i] == 'true') {
                    $("#endjobsright").val(str);
                    break;
                }
            }
            /**
            for(var i = 0;i<haseditvalue2right.length;i++){
                if(haseditvalue2right[i]=='true'){
                    $("#editvalue2right").val(str);
                    break;
                }
            }
            for(var i = 0;i<haseditvalue3right.length;i++){
                if(haseditvalue3right[i]=='true'){
                    $("#editvalue3right").val(str);
                    break;
                }
            }
            for(var i = 0;i<haseditvalue4right.length;i++){
                if(haseditvalue4right[i]=='true'){
                    $("#editvalue4right").val(str);
                    break;
                }
            }
            for(var i = 0;i<haseditvalue5right.length;i++){
                if(haseditvalue5right[i]=='true'){
                    $("#editvalue5right").val(str);
                    break;
                }
            }
            for(var i = 0;i<haseditvalue6right.length;i++){
                if(haseditvalue6right[i]=='true'){
                    $("#editvalue6right").val(str);
                    break;
                }
            }
            for(var i = 0;i<haseditvalue7right.length;i++){
                if(haseditvalue7right[i]=='true'){
                    $("#editvalue7right").val(str);
                    break;
                }
            }
            for(var i = 0;i<haseditvalue8right.length;i++){
                if(haseditvalue8right[i]=='true'){
                    $("#editvalue8right").val(str);
                    break;
                }
            }
            for(var i = 0;i<haseditvalue9right.length;i++){
                if(haseditvalue9right[i]=='true'){
                    $("#editvalue9right").val(str);
                    break;
                }
            }


            for(var i = 0;i<hasrece.length;i++){
                if(hasrece[i]=='true'){
                    $("#receright").val(str);
                    break;
                }
            }

            for(var i = 0;i<hasdelete.length;i++){
                if(hasdelete[i]=='true'){
                    $("#deleteright").val(str);
                    break;
                }
            }
            for(var i = 0;i<hasprint.length;i++){
                if(hasprint[i]=='true'){
                    $("#printright").val(str);
                    break;
                }
            }
            for(var i = 0;i<hassubmit.length;i++){
                if(hassubmit[i]=='true'){
                    $("#submitright").val(str);
                    break;
                }
            }
            for(var i = 0;i<haspause.length;i++){
                if(haspause[i]=='true'){
                    $("#pauseright").val(str);
                    break;
                }
            }   
            for(var i = 0;i<hasalive.length;i++){
                if(hasalive[i]=='true'){
                    $("#aliveright").val(str);
                    break;
                }
            }   
            */
        }
    }
    //初始化显示详细信息的字段
    function thisDetailField() {
        var column = '';
        var thisdata = loadData('TelJob', '<%=languageType %>', 1);
        column = thisdata.FieldName.join(',');
        //ID,Sgnr,Mqbm,IfCancel,Ydh,Xdh,Nxm,Xm,Sgrq,Jlry,Area,Slbm,Dhlx,IDD,IsPay,Dhgn,BeginYwArea,Bm1,Bm2,Bm3,Bm4,Ydz,Xdz,Wgbm,Yhxz,Ywarea,CardID,IsComplete,jobstatus,Lsh,Lxdh,LinkMan,value1,value2,value3,value4,value5,value6,value7,value8,value9,Bz,Zwbz,YHth,Pgrq,Hth
        $("#thisJobID").html(thisdata.getFieldAliasByFieldName('ID'));
        $("#thisJobType").html(thisdata.getFieldAliasByFieldName('Sgnr'));
        $("#thismqbm").html(thisdata.getFieldAliasByFieldName('Mqbm'));
        $("#thisIfCancel").html(thisdata.getFieldAliasByFieldName('IfCancel'));
        $("#thisjobstatus").html(thisdata.getFieldAliasByFieldName('Ydh'));
        $("#thisUserName").html(thisdata.getFieldAliasByFieldName('Xdh'));
        $("#thisoldsRealName").html(thisdata.getFieldAliasByFieldName('Nxm'));
        $("#thissRealName").html(thisdata.getFieldAliasByFieldName('Xm'));
        $("#thisJobRecTime").html(thisdata.getFieldAliasByFieldName('Sgrq'));
        $("#thisUserID").html(thisdata.getFieldAliasByFieldName('Jlry'));
        $("#thisArea").html(thisdata.getFieldAliasByFieldName('Area'));
        $("#thisDepart").html(thisdata.getFieldAliasByFieldName('Slbm'));
        //$("#thisValue").html(thisdata.getFieldAliasByFieldName('Dhlx'));
        //$("#thisvlanid").html(thisdata.getFieldAliasByFieldName('IDD'));
        $("#thisPayType").html(thisdata.getFieldAliasByFieldName('IsPay'));
        $("#thisiFeeType").html(thisdata.getFieldAliasByFieldName('Dhgn'));
        //$("#thissDh").html(thisdata.getFieldAliasByFieldName('BeginYwArea'));
        //$("#thisValue").html(thisdata.getFieldAliasByFieldName('Dhgn'));
        $("#thissRegDate").html(thisdata.getFieldAliasByFieldName('Bm1'));
        $("#thisfeedendtime").html(thisdata.getFieldAliasByFieldName('Bm2'));
        $("#thisiFeeTypeTime").html(thisdata.getFieldAliasByFieldName('Bm3'));
        $("#thisoldsAddress").html(thisdata.getFieldAliasByFieldName('Bm4'));
        $("#thissAddress").html(thisdata.getFieldAliasByFieldName('Ydz'));
        $("#thisiStatus").html(thisdata.getFieldAliasByFieldName('Xdz'));
        $("#thissDh1").html(thisdata.getFieldAliasByFieldName('Wgbm'));
        $("#thissDh2").html(thisdata.getFieldAliasByFieldName('Yhxz'));
        $("#thisiSimultaneous").html(thisdata.getFieldAliasByFieldName('Ywarea'));
        $("#thisUserName1").html(thisdata.getFieldAliasByFieldName('CardID'));
        $("#thisidtype").html(thisdata.getFieldAliasByFieldName('IsComplete'));
        $("#thisidcard").html(thisdata.getFieldAliasByFieldName('jobstatus'));
        $("#thisoldspeed").html(thisdata.getFieldAliasByFieldName('Lxdh'));
        $("#thisspeed").html(thisdata.getFieldAliasByFieldName('LinkMan'));
        //号线配置信息
        $("#thismobile").html(thisdata.getFieldAliasByFieldName('value1'));
        $("#thislinkphone").html(thisdata.getFieldAliasByFieldName('value2'));
        $("#thislinkman").html(thisdata.getFieldAliasByFieldName('value3'));
        $("#thisFee").html(thisdata.getFieldAliasByFieldName('value4'));
        $("#thisFeeName").html(thisdata.getFieldAliasByFieldName('value5'));
        $("#thissBm").html(thisdata.getFieldAliasByFieldName('value6'));
        $("#thissBm2").html(thisdata.getFieldAliasByFieldName('value7'));
        $("#thissBm3").html(thisdata.getFieldAliasByFieldName('value8'));
        $("#thissBm4").html(thisdata.getFieldAliasByFieldName('value9'));
        $("#thisifurgent").html(thisdata.getFieldAliasByFieldName('Bz'));
        $("#thismemo").html(thisdata.getFieldAliasByFieldName('Zwbz'));
        $("#thisPayMode").html(thisdata.getFieldAliasByFieldName('Hth'));
        $("#thisisPay").html(thisdata.getFieldAliasByFieldName('Pgrq'));
        $("#thisHth").html(thisdata.getFieldAliasByFieldName('value15'));
        $("#thisdevno").html(thisdata.getFieldAliasByFieldName('Lsh'));
        $("#thisjobstate").html(thisdata.getFieldAliasByFieldName('dJhwcsj'));
    }

    //编辑号线的权限
    function getHxPower() {
        var editvalue1right = $('#editvalue1right').val();
        var editvalue2right = $('#editvalue2right').val();
        var editvalue3right = $('#editvalue3right').val();
        var editvalue4right = $('#editvalue4right').val();
        var editvalue5right = $('#editvalue5right').val();
        var editvalue6right = $('#editvalue6right').val();
        var editvalue7right = $('#editvalue7right').val();
        var editvalue8right = $('#editvalue8right').val();
        var editvalue9right = $('#editvalue9right').val();

        if ('<%=session.getAttribute("userid") %>' == 'admin') {
            $('#Value1').removeAttr('disabled');
            $('#Value2').removeAttr('disabled');
            $('#Value3').removeAttr('disabled');
            $('#Value4').removeAttr('disabled');
            $('#Value5').removeAttr('disabled');
            $('#Value6').removeAttr('disabled');
            $('#Value7').removeAttr('disabled');
            $('#Value8').removeAttr('disabled');
            $('#Value9').removeAttr('disabled');

            $('#Value1clear').show();
            $('#Value2clear').show();
            $('#Value3clear').show();
            $('#Value4clear').show();
            $('#Value5clear').show();
            $('#Value6clear').show();
            $('#Value7clear').show();
            $('#Value8clear').show();
            $('#Value9clear').show();

            /**
            $('#Value1').attr('readonly','readonly');
            $('#Value2').attr('readonly','readonly');
            $('#Value3').attr('readonly','readonly');
            $('#Value4').attr('readonly','readonly');
            $('#Value5').attr('readonly','readonly');
            $('#Value6').attr('readonly','readonly');
            $('#Value7').attr('readonly','readonly');
            $('#Value8').attr('readonly','readonly');
            $('#Value9').attr('readonly','readonly');
            */
        } else {
            if (editvalue1right == 'true') {
                $('#Value1').removeAttr('disabled');
                $('#Value1clear').show();
                //$('#Value1').attr('readonly','readonly');
            }
            if (editvalue2right == 'true') {
                $('#Value2').removeAttr('disabled');
                $('#Value2clear').show();
                //$('#Value2').attr('readonly','readonly');
            }
            if (editvalue3right == 'true') {
                $('#Value3').removeAttr('disabled');
                $('#Value3clear').show();
                //$('#Value3').attr('readonly','readonly');
            }
            if (editvalue4right == 'true') {
                $('#Value4').removeAttr('disabled');
                $('#Value4clear').show();
                //$('#Value4').attr('readonly','readonly');
            }
            if (editvalue5right == 'true') {
                $('#Value5').removeAttr('disabled');
                $('#Value5clear').show();
                //$('#Value5').attr('readonly','readonly');
            }
            if (editvalue6right == 'true') {
                $('#Value6').removeAttr('disabled');
                $('#Value6clear').show();
                //$('#Value6').attr('readonly','readonly');
            }
            if (editvalue7right == 'true') {
                $('#Value7').removeAttr('disabled');
                $('#Value7clear').show();
                //$('#Value7').attr('readonly','readonly');
            }
            if (editvalue8right == 'true') {
                $('#Value8').removeAttr('disabled');
                $('#Value8clear').show();
                //$('#Value8').attr('readonly','readonly');
            }
            if (editvalue9right == 'true') {
                $('#Value9').removeAttr('disabled');
                $('#Value9clear').show();
                //$('#Value9').attr('readonly','readonly');
            }
        }
    }

    //显示故障信息显示列表
    function getSelectGzList() {
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xmlattr', //返回数据格式 
            tsdpk: '112jobmanager.getselectgzlist' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax({
            url: 'mainServlet.html?' + urlstr,
            datatype: 'xml',
            cache: false,
            //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 1000,
            async: false, //同步方式
            success: function(xml) {
                var listinfo = '<option value="">请选择</option>';
                $(xml).find('row').each(function() {
                    var str = $(this).attr("strgzxx");
                    if (str != undefined) {
                        listinfo += '<option value="' + str + '">' + str + '</option>';
                    }
                });
                if (listinfo != '') {
                    $('#gzxx').html(listinfo);
                    $('#fhgzxx').html(listinfo);
                }
            }
        });
    }

    //获取工单流转的第一个部门
    function getFirstDepart() {
        var　 deptname = '';
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdReport', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'enterprisedb', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xmlattr', //返回数据格式 
            tsdpk: '112jobmanager.getfirstname' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax({
            url: 'mainServlet.html?' + urlstr + '&area=' + tsd.encodeURIComponent('<%=session.getAttribute("userarea") %>'),
            datatype: 'xml',
            cache: false,

            //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 3000,
            async: false, //同步方式
            success: function(xml) {
                $(xml).find('row').each(function() {
                    var str = $(this).attr("department");
                    if (str != undefined) {
                        deptname = str;
                    }
                });
            }
        });
        return deptname;
    }

    //保存人工受理故障信息
    function saveRgsl() {
        var sldh = $('#sldh').val();
        if (sldh == '') {
            alert('请输入受理电话!');
            $('#sldh').focus();
            return false;
        }
        var gzxx = $('#gzxx').val();
        if (gzxx == '') {
            alert('请选择故障信息!');
            $('#gzxx').focus();
            return false;
        }
        var lxdh = $('#lxdh').val();
        if (lxdh == '') {
            alert('请输入联系电话!');
            $('#lxdh').focus();
            return false;
        }
        var gzbz = $('#gzbz').val();

        var params = '';
        params += '&thiskey=' + sldh;
        params += '&gzxx=' + tsd.encodeURIComponent(gzxx);
        params += '&lxdh=' + lxdh;
        params += '&jlry=<%=session.getAttribute("userid") %>';
        params += '&sgbz=' + tsd.encodeURIComponent(gzbz);
        params += '&slbm=' + tsd.encodeURIComponent('<%=session.getAttribute("departname") %>');
        params += '&ywarea=' + tsd.encodeURIComponent('<%=session.getAttribute("userarea") %>');

        //var mqbm = getFirstDepart();
        var mqbm = '<%=session.getAttribute("departname") %>';
        if (mqbm == '') {
            alert('当前登陆工号个人信息配置不全，请完善个人配置信息!');
            $('#sldh').focus();
            return;
        } else {
            params += '&mqbm=' + tsd.encodeURIComponent(mqbm);
        }

        var urlstr = tsd.buildParams({
            packgname: 'service',
            clsname: 'Procedure',
            method: 'exequery',
            ds: 'tsdBilling', //数据源名称 对应的spring配置的数据源
            tsdpname: '112jobmanager.faultjob112_rgsl', //存储过程的映射名称
            tsdExeType: 'query',
            datatype: 'xmlattr'
        });
        urlstr += params;
        $.ajax({
            url: 'mainServlet.html?' + urlstr,
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 3000,
            async: false, //同步方式
            success: function(xml) {
                $(xml).find('row').each(function() {
                    var res = $(this).attr("res");
                    if (res == 'ok') {
                        alert('操作成功!');
                        //$('#fault112close').click();
                        reloadData();
                    }
                });
            }
        });
    }
    //数据重载
    function reloadData() {
        var str = '';
        var userright = $('#islimitdeptright').val();
        var modimokuaijus = $("#usermokuaijus").val();
        var paramsstr = '&area=' + tsd.encodeURIComponent(modimokuaijus);
        str = '0';

        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            datatype: 'xml', //返回数据格式 
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            tsdpk: '112jobmanager.queryjoblist0', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
            tsdpkpagesql: '112jobmanager.queryjoblistpage0' //依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
        });
        var thecolumn = $('#thecolumn').val();
        var ywqy='<%=session.getAttribute("managearea") %>';
        if(ywqy=="全地区"){
          urlstr= urlstr.replace("112jobmanager.queryjoblist0", "112job.select");
        }
        $("#editgrid").setGridParam({
            url: 'mainServlet.html?' + urlstr + '&cloumn=' + thecolumn + '&mqbm=' + tsd.encodeURIComponent('<%=session.getAttribute("departname") %>') + '&area=' + tsd.encodeURIComponent(ywqy) + paramsstr
        }).trigger("reloadGrid");
        setTimeout($.unblockUI, 15);
    }

    //显示人工受理面板
    function openRgsl() {
        clearText('fault112form');
        autoBlockForm('fault112', 60, 'fault112close', "#ffffff", false);
    }

    //删除记录
    function deleteRows() {
        var arr = $('#editgrid').getGridParam('selarrrow');
        if (arr.length == 0) {
            alert('请勾选要删除的记录!');
            return false;
        }
        var str = '';
        if (arr.length > 1) {
            str = '这些';
        } else {
            str = '这条';
        }
        if (confirm('确定要撤销' + str + '工单吗?')) {
            var idarr = new Array();
            for (var i = 0; i < arr.length; i++) {
                idarr.push($('#editgrid').getCell(arr[i], 'ID'));
                writeDelLog($('#editgrid').getCell(arr[i], 'ID'));
            }
            deleteRow(idarr);
        }
    }
    //执行删除
    function deleteRow(key) {
        //var deleteright = $("#deleteright").val();
        var deleteright = 'true';

        if (deleteright == "true") {
            //jConfirm('您确定要删除', operationtips, function(x) { if(x==true){ 
            var urlstr = tsd.buildParams({
                packgname: 'service', //java包
                clsname: 'ExecuteSql', //类名
                method: 'exeSqlData', //方法名
                ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
                tsdcf: 'mssql', //指向配置文件名称
                tsdoper: 'exe', //操作类型 
                tsdpk: '112jobmanager.delete112' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
            });
            $.ajax({
                url: 'mainServlet.html?' + urlstr + '&id=' + key,
                cache: false, //如果值变化可能性比较大 一定要将缓存设成false
                timeout: 3000,
                async: false, //同步方式
                success: function(msg) {
                    if (msg == "true") {
                        alert('撤销成功');
                        tbDeleteRow(key);
                        reloadData();
                    }
                }
            });
            //}});
        } else {
            alert('无删除权限');
        }
    }
    //删除时添加日志
    function writeDelLog(key) {
        //1111
        var res = fetchSingleValue("112jobmanager.writeDelLog", 0, "&id=" + key);
        writeLogInfo('', 'delete', tsd.encodeURIComponent(res));

    }

    //同步删除流程表里的工单信息
    function tbDeleteRow(key) {
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'exe', //操作类型 
            tsdpk: '112jobmanager.tbdelete112pglc' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax({
            url: 'mainServlet.html?' + urlstr + '&id=' + key,
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 3000,
            async: false, //同步方式
            success: function(msg) {
                if (msg == "true") {}
            }
        });
    }

    //发送工单
    function sendJobs(flag) {
        var arr = $('#editgrid').getGridParam('selarrrow');
        if (arr.length == 0) {
            alert('请勾选要发送的工单!');
            return false;
        }

        var idarr = new Array();
        var pglcidarr = new Array();

        for (var i = 0; i < arr.length; i++) {
            idarr.push($('#editgrid').getCell(arr[i], 'Mqbm'));
            pglcidarr.push($('#editgrid').getCell(arr[i], 'ID'));
        }
        //只能批量提交同一部门的相同工单
        var disbm = uniqueData_(idarr);
        if (disbm.length > 1) {
            alert('只能批量提交相同部门的工单!');
            return false;
        }
        if (disbm == '故障部') {
            var pgids = fetchMultiArrayValue('112jobmanager.isMultiVlues', 6, '&jobid=' + tsd.encodeURIComponent(pglcidarr.join(',')));
            var v_pgid = uniqueData_(pgids);
            if (v_pgid.length > 1) {
                alert('批量提交过程中存在已回到故障部的工单，确认完工即可');
                return false;
            } else {
                if (v_pgid[0] != 1) {
                    alert('工单已回到故障部，确认完工即可');
                    return false;
                }
            }
            /**
            var disbm = uniqueData_(pgids);
            if(disbm.length>1){
                alert('只能批量提交相同部门的工单!');
                return false;
            }
            */
        }
        var disnextbm = getNextDepart(disbm); //工单流转的下一个部门
        //alert(disnextbm[0][0]);

        if (flag == 'send') {
            var str = '';
            if (arr.length > 1) {
                str = '这些';
            } else {
                str = '这条';
            }

            if (confirm('确定要发送' + str + '工单吗?')) {
                setTimeout($.unblockUI, 15); //关闭面板
                var idarrs = new Array();
                for (var i = 0; i < arr.length; i++) {
                    idarrs.push($('#editgrid').getCell(arr[i], 'ID'));
                }
                if (idarrs.length > 0) {
                    if (disnextbm[0][0].indexOf('~') != -1) {
                        var bmarr = disnextbm[0][0].split('~');
                        for (var i = 0; i < bmarr.length; i++) {
                            if ($('#slxbm' + i).attr('checked') == true) {
                                disnextbm = $('#lxbm' + i).text();
                                break;
                            }
                        }
                    }
                    send112Jobs(idarrs, disnextbm);
                    var pgbz = $('#pgbz').val();
                    for (var i = 0; i < idarrs.length; i++) {
                        var pgid = getNextBmPgid(idarrs[i]);
                        savePglc(idarrs[i], pgid, disnextbm, pgbz);
                    }
                } else {
                    alert('返回数据格式错误，请联系系统管理员!');
                }
            }
        } else {

            if (disnextbm == '') {
                alert('所在的区域流程信息配置不全，请通知系统管理员完善区域配置信息!');
                //alert('现在所处的是流程所在的最后一个部门，确认完工即可');
            } else {
                var displayinfo = '';
                if (disnextbm[0][0].indexOf('~') != -1) {
                    var bmarr = disnextbm[0][0].split('~');
                    for (var i = 0; i < bmarr.length; i++) {
                        displayinfo += '<input type="radio" id="slxbm' + i + '" name="astr" /><span id="lxbm' + i + '">' + bmarr[i] + '</span>';
                    }
                } else {
                    displayinfo += '<input type="radio" id="slxbm0" name="astr" checked="checked"/><span id="lxbm0">' + disnextbm[0][0] + '</span>';
                }
                $('#displaybms').html(displayinfo);
                //$('#slxbm0').attr('checked','checked');
                clearText('fault112sendform');
                autoBlockForm('fault112send', 60, 'fault112sendclose', "#ffffff", false);
            }
        }
    }

    //开始发送工单
    function send112Jobs(key, nextbm) {
        //var sendright = 'true';
        //if(sendright=="true"){//发送工单的权限
        //jConfirm('您确定要删除', operationtips, function(x) { if(x==true){ 
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'exe', //操作类型 
            tsdpk: '112jobmanager.send112jobs' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax({
            url: 'mainServlet.html?' + urlstr + '&mqbm=' + tsd.encodeURIComponent(nextbm) + '&id=' + key,
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 3000,
            async: false, //同步方式1
            success: function(msg) {
                if (msg == "true") {
                    alert('发送工单成功');
                    //$('#fault112sendclose').click();
                    reloadData();
                }
            }
        });
        //}});
        //}else{
        //  alert('您暂无发送工单的权限!');
        //}
    }

    //获取工单流转的下一个部门
    function getNextDepart(key) {
        var deptname = '';
        var nextDept = fetchMultiPValue('112jobmanager.Pro_getNextDepart', 6, '&operflag=1&mqbm=' + tsd.encodeURIComponent(key));
        if (nextDept == '') {
            alert('流程信息配置不全，无法找到下一级流程部门');
            return;
        } else {
            return nextDept;
        }
    }

    //获取工单流转的下一个部门流程ID
    function getNextBmPgid(key) {
        var　 pgid = '';
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xmlattr', //返回数据格式 
            tsdpk: '112jobmanager.send112jobs_nextdeptpgid' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });

        $.ajax({
            url: 'mainServlet.html?id=' + key + urlstr,
            datatype: 'xml',
            cache: false,
            //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 3000,
            async: false, //同步方式
            success: function(xml) {
                $(xml).find('row').each(function() {
                    var str = $(this).attr("pgid");
                    if (str != undefined) {
                        pgid = str;
                    } else {
                        pgid = 10;
                    }
                });
            }
        });

        return pgid;
    }
    //往工单流程表里插入数据
    function savePglc(ID, PgID, nextbm, pgbz) {
        //ID,PgID,Fsbm,Fsry,Fsrq,Bm,Bz
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'exe', //操作类型 
            tsdpk: '112jobmanager.savepglc' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        var params = '';

        params += '&ID=' + tsd.encodeURIComponent(ID);
        params += '&PgID=' + tsd.encodeURIComponent(PgID);
        params += '&Fsbm=' + tsd.encodeURIComponent('<%=session.getAttribute("departname") %>');
        params += '&Fsry=' + tsd.encodeURIComponent('<%=session.getAttribute("userid") %>');
        params += '&Bm=' + tsd.encodeURIComponent(nextbm);
        params += '&Bz=' + tsd.encodeURIComponent(pgbz);

        $.ajax({
            url: 'mainServlet.html?' + urlstr + params,
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 3000,
            async: false, //同步方式
            success: function(msg) {
                if (msg == "true") {}
            }
        });
    }

    //鼠标移动、改变背景颜色
    function colorchange(obj, flag, trid) {
        var beforeThisClick = $('#thisRowIndex').val();
        var isThisClick = obj.rowIndex;

        if (flag == 1) {
            if (obj.style.backgroundColor != '#66ffcc') {
                obj.style.backgroundColor = '#87CEFA';
            }
        } else if (flag == 2) {
            if (isThisClick != beforeThisClick) {
                obj.style.backgroundColor = '';
            }
        } else if (flag == 3) {
            if (isThisClick != beforeThisClick) {
                if (beforeThisClick != '') {
                    var isThisNum = beforeThisClick * 1 - 1;
                    $("#" + trid + isThisNum).css({
                        background: ''
                    });
                }
                obj.style.backgroundColor = '#66FFCC';
                obj.style.cursor = 'hand';
                $('#thisRowIndex').val(isThisClick);
            }
        }
    }

    //故障复核
    function fhJobs(flag) {
        var arr = $('#editgrid').getGridParam('selarrrow');
        if (arr.length == 0) {
            alert('请勾选要复核的工单!');
            return false;
        } else if (arr.length > 1) {
            alert('一次只能复核一条故障工单!');
            return false;
        }
        var fhdh = $('#editgrid').getCell(arr[0], 'Dh');
        var fhgzxx = $('#editgrid').getCell(arr[0], 'Gzxx');

        if (flag == 'fh') {
            var fhgzxx = $('#fhgzxx').val();
            if (fhgzxx == '') {
                alert('请选择要复核的故障信息!');
                $('#fhgzxx').focus();
                return false;
            }
            if (confirm('确定要提交吗?')) {
                setTimeout($.unblockUI, 15); //关闭面板
                var ID = $('#editgrid').getCell(arr[0], 'ID');
                saveFhjg(ID, fhgzxx);
            }
        } else {
            $('#confirmdh').html(fhdh);
            $('#confirmgzxx').html(fhgzxx);
            var fhgzxx = $('#editgrid').getCell(arr[0], 'Jcjg');
            $('#fhgzxx').val(fhgzxx);
            autoBlockForm('fault112fh', 60, 'fault112fhclose', "#ffffff", false);
        }
    }

    //复核工单
    function saveFhjg(ID, fcjg) {
        //ID,PgID,Fsbm,Fsry,Fsrq,Bm,Bz
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'exe', //操作类型 
            tsdpk: '112jobmanager.fhgzxx' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        var params = '';

        params += '&id=' + ID;
        params += '&jcry=' + tsd.encodeURIComponent('<%=session.getAttribute("userid") %>');
        params += '&jcjg=' + tsd.encodeURIComponent(fcjg);

        $.ajax({
            url: 'mainServlet.html?' + urlstr + params,
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 3000,
            async: false, //同步方式
            success: function(msg) {
                if (msg == "true") {
                    alert('操作成功');
                    //$('#fault112sendclose').click();
                    reloadData();
                }
            }
        });
    }

    //获取所有员工号 用于设置派修人员名
    pxryNameF = new Array();

    function getpxry() {
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xmlattr', //返回数据格式 
            tsdpk: '112jobmanager.getpxry' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax({
            url: 'mainServlet.html?' + urlstr,
            datatype: 'xml',
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 3000,
            async: false, //同步方式
            success: function(xml) {
                $(xml).find('row').each(function() {
                    var struserid = $(this).attr("userid");

                    if (struserid != undefined) {
                        var strusername = $(this).attr("username");
                        pxryNameF[struserid] = new Array();
                        pxryNameF[struserid].push(strusername);
                    }

                });
            }
        });
    }

    //维修人员
    function pxUserList(userarea) {
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xmlattr', //返回数据格式 
            tsdpk: '112jobmanager.getpxuserlist' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax({
            url: 'mainServlet.html?' + urlstr + '&ywuserarea=' + tsd.encodeURIComponent(userarea),
            datatype: 'xml',
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 3000,
            async: false, //同步方式
            success: function(xml) {
                $(xml).find('row').each(function() {
                    var thevalue = '<option value="">请选择</option>';
                    var distm = false;
                    $(xml).find('row').each(function() {
                        var struserid = $(this).attr("userid");
                        if (struserid != undefined) {
                            var strusername = $(this).attr("username");
                            //thevalue += '<option value="'+struserid+'">'+strusername+'</option>'
                            thevalue += '<option value="' + strusername + '">' + strusername + '</option>';
                        } else {
                            distm = true;
                        }
                    });
                    if (distm == true) {
                        thevalue = '你所在的区域暂未分配外线班工号，请及时联系系统管理员!';
                        $('#isareauserid').hide();
                    }
                    $('#pxuseridlist').html(thevalue);
                });
            }
        });
    }

    //故障派修
    function pxJobs(flag) {
        var arr = $('#editgrid').getGridParam('selarrrow');
        if (arr.length == 0) {
            alert('请勾选要派修的工单!');
            return false;
        } else if (arr.length > 1) {
            alert('一次只能派修一条故障工单!');
            return false;
        }
        var pxid = $('#editgrid').getCell(arr[0], 'ID');
        var pxarea = $('#editgrid').getCell(arr[0], 'Ywarea');

        if (flag == 'px') {
            var pxuserid = $('#pxuseridlist').val();
            if (pxuserid == '') {
                alert('请选择要派修的人员!');
                $('#pxuseridlist').focus();
                return false;
            }
            var pxbz = $('#pxbz').val();
            /*
            if(pxbz==''){
                alert('派修备注不允许为空，请填写派修备注!');
                $('#pxbz').focus();
                return false;
            }*/

            /*var disbm = $('#editgrid').getCell(arr[0],'Mqbm');
            var disbm = fetchMultiPValue('112jobmanager.Pro_getNextDepart',6,'&operflag=2');
            if(disbm==''){
                alert('未配置故障处理部门，工单无法进行流转');
                return;
            }*/
            savePxjg(pxid, pxbz, pxuserid, pxarea); //故障派修
        } else {
            var ispx = $('#editgrid').getCell(arr[0], 'Pxry');
            var ispxflag = false;
            if (ispx != '') {
                if (confirm('此条112障碍工单已派给【' + ispx + '】，您确定要重新派修吗?')) {
                    ispxflag = true;
                }
            } else {
                ispxflag = true;
            }
            if (ispxflag == true) {

                pxUserList(pxarea); //所属区域下可配置显示外线班数据列表
                autoBlockForm('fault112px', 60, 'fault112pxclose', "#ffffff", false);
            }
        }
    }

    //往工单流程表里插入数据
    function savePxjg(ID, Pxrz, wxry, ywarea) {
        //ID,PgID,Fsbm,Fsry,Fsrq,Bm,Bz
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'exe', //操作类型 
            tsdpk: '112jobmanager.pxjobs' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        var params = '';

        var disPxrz = getPxrz(ID);

        disPxrz = disPxrz + ';' + Pxrz;

        params += '&id=' + ID;
        params += '&Pxry=' + tsd.encodeURIComponent($('#pxuseridlist').val());
        params += '&Pgrz=' + tsd.encodeURIComponent(disPxrz);
        params += '&Wxbz=' + tsd.encodeURIComponent(ywarea);
        params += '&Wxry=' + tsd.encodeURIComponent(wxry);

        //var dismqbm = getNextDepart(disbm);

        //params += '&Mqbm=' + tsd.encodeURIComponent(disbm);

        $.ajax({
            url: 'mainServlet.html?' + urlstr + params,
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 3000,
            async: false, //同步方式
            success: function(msg) {
                if (msg == "true") {

                    if (confirm('操作成功，是否打印？')) {
                        printDisplay();
                    } else {
                        reloadData();
                    }
                    //alert('操作成功');
                    //$('#fault112sendclose').click();

                }
            }
        });
    }

    //获取派修日志
    function getPxrz(key) {
        var thevalue = '';
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xmlattr', //返回数据格式 
            tsdpk: '112jobmanager.getpxrz' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax({
            url: 'mainServlet.html?id=' + key + urlstr,
            datatype: 'xml',
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 3000,
            async: false, //同步方式
            success: function(xml) {
                $(xml).find('row').each(function() {
                    var pgrz = $(this).attr("pgrz");
                    if (pgrz != undefined) {
                        thevalue = pgrz;
                    }
                });
            }
        });
        return thevalue;
    }
    //故障派修
    function endJobs(flag) {
        var arr = $('#editgrid').getGridParam('selarrrow');
        if (arr.length == 0) {
            alert('请勾选要完工的工单!');
            return false;
        } else if (arr.length > 1) {
            alert('一次只能完工一条故障工单!');
            return false;
        }
        if (flag == 'end') {
            var idarrs = new Array();
            for (var i = 0; i < arr.length; i++) {
                idarrs.push($('#editgrid').getCell(arr[i], 'ID'));
            }
            if (idarrs.length > 0) {
                //完工录入信息
                var ConfirmFault = $('#sjgz').val();
                //var clr=$('#clr').val();
                var clr = '';
                var chkuserid = document.getElementsByName('thisuseridlist');
                for (var i = 0; i < chkuserid.length; i++) {
                    if (chkuserid[i].checked == true) {
                        clr += chkuserid[i].value + ',';
                    }
                }
                clr = clr.substring(0, clr.lastIndexOf(','));
                var jg = $('#cljg').val();
                var clsj = $('#clsj').val();
                var myd = $("input[id=isok]:checked").val();
                if (myd == 'undefined' || myd == '' || myd == 'null') {
                    alert('请录入用户满意度！');
                    return false;
                }

                saveEnd(idarrs, ConfirmFault, clr, jg, clsj, myd); //故障完工
                clearOver();
                //更新工单历时时间
                for (var i = 0; i < idarrs.length; i++) {
                    changeJobWxls(idarrs[i]); //变更维修历时
                }
            } else {
                alert('返回数据格式错误，请联系系统管理员!');
            }
        } else {
            var ywarea = '';
            var jlry = '';
            for (var i = 0; i < arr.length; i++) {
                ywarea = $('#editgrid').getCell(arr[i], 'Ywarea');
                jlry = $('#editgrid').getCell(arr[i], 'Jlry');
            }
            get112Userid(ywarea, jlry);
            autoBlockForm('fault112end', 60, 'fault112endclose', "#ffffff", false);
        }
    }

    //往工单流程表里插入数据
    function saveEnd(ID, ConfirmFault, clr, jg, clsj, myd) {
        //ID,PgID,Fsbm,Fsry,Fsrq,Bm,Bz
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'exe', //操作类型 
            tsdpk: '112jobmanager.endjobs' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        var params = '';

        //var disWxls = getWxls(ID);
        params += '&id=' + ID;
        params += '&wxjg=' + tsd.encodeURIComponent(ConfirmFault); //实际故障 后来叫处理过程
        params += '&advice=' + tsd.encodeURIComponent(jg); //结果
        params += '&djhwcsj=' + tsd.encodeURIComponent(clsj); //处理人
        //params += '&jlry=' + tsd.encodeURIComponent(clr);//处理人
        params += '&pgrz=' + tsd.encodeURIComponent(myd); //处理人
        //params += '&wgry=' + tsd.encodeURIComponent('<%=session.getAttribute("userid") %>');//完工人员
        params += '&wgry=' + tsd.encodeURIComponent(clr); //处理人员
        params += '&wgbm=' + tsd.encodeURIComponent('<%=session.getAttribute("departname") %>'); //完工部门

        $.ajax({
            url: 'mainServlet.html?' + urlstr + params,
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 3000,
            async: false, //同步方式
            success: function(msg) {
                if (msg == "true") {
                    alert('操作成功');
                    //$('#fault112sendclose').click();
                    reloadData();
                }
            }
        });
    }

    //往工单流程表里插入数据
    function changeJobWxls(key) {
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'exe', //操作类型 
            tsdpk: '112jobmanager.upwxlsinjobs' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax({
            url: 'mainServlet.html?id=' + key + urlstr,
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 3000,
            async: false, //同步方式
            success: function(msg) {
                if (msg == "true") {}
            }
        });
    }

    //查看流程信息
    function readJobs() {
        var arr = $('#editgrid').getGridParam('selarrrow');
        if (arr.length == 0) {
            alert('请勾选要查看详细信息的工单!');
            return false;
        } else if (arr.length > 1) {
            alert('一次只能查看一条工单的流程信息!');
            return false;
        } else {
            var urlstr = tsd.buildParams({
                packgname: 'service', //java包
                clsname: 'ExecuteSql', //类名
                method: 'exeSqlData', //方法名
                ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
                tsdcf: 'enterprisedb', //指向配置文件名称
                tsdoper: 'query', //操作类型 
                datatype: 'xmlattr', //返回数据格式 
                tsdpk: '112jobmanager.querypglc' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
            });

            $.ajax({

                url: 'mainServlet.html?id=' + $('#editgrid').getCell(arr[0], 'ID') + urlstr + '&tsdtemp=' + Math.random(),
                datatype: 'xml',
                cache: false, //如果值变化可能性比较大 一定要将缓存设成false
                timeout: 5000,
                async: false, //同步方式
                success: function(xml) {
                    var info = '';
                    info += '<table class="sortable" id="table11" width="100%"style="border: 1px; border-style: solid; border-color: #87CEFA;line-height:20px; text-align:center" cellpadding="1px" cellspacing="1px"><tr style="background-color: #c0c0c0">';
                    info += '<th onclick="return false;"  height="20px"style="border: 1px; border-style: solid; border-color: #87CEFA;">流程序号</th>';
                    info += '<th height="20px"style="border: 1px; border-style: solid; border-color: #87CEFA;">发送部门</th>';
                    info += '<th height="20px"style="border: 1px; border-style: solid; border-color: #87CEFA;">发送人员</th>';
                    info += '<th height="20px"style="border: 1px; border-style: solid; border-color: #87CEFA;">发送时间</th>';
                    info += '<th height="20px"style="border: 1px; border-style: solid; border-color: #87CEFA;">目前部门</th>';
                    info += '<th height="20px"style="border: 1px; border-style: solid; border-color: #87CEFA;">详细备注</th>';

                    info += '</tr>';

                    var i = 1;

                    $(xml).find('row').each(function() {
                        if ($(this).attr("id") != undefined) {
                            info += '<tr height="20px" id="trd' + i + '" onmouseover=colorchange(this,1,"trd") onmouseout=colorchange(this,2,"trd") onclick=colorchange(this,3,"trd") >';

                            var Fsbm = $(this).attr("fsbm");
                            if (Fsbm == undefined) {
                                Fsbm = '';
                            }
                            var Fsry = $(this).attr("fsry");
                            if (Fsry == undefined) {
                                Fsry = '';
                            } else if (Fsry != '' && Fsry != '自动') {
                                Fsry = getTrueValue('tsdBilling', 'sys_user', 'username', 'userid', Fsry, '1', '1');
                            }
                            var Fsrq = $(this).attr("fsrq");
                            var Bm = $(this).attr("bm");
                            var Bz = $(this).attr("bz");
                            if (Bz == 'null') {
                                Bz = '';
                            }
                            info += '<td style="border: 1px; border-style: solid; border-color: #87CEFA">' + i + '</td>';
                            info += '<td style="border: 1px; border-style: solid; border-color: #87CEFA">' + Fsbm + '</td>';
                            info += '<td style="border: 1px; border-style: solid; border-color: #87CEFA">' + Fsry + '</td>';
                            info += '<td style="border: 1px; border-style: solid; border-color: #87CEFA">' + Fsrq + '</td>';
                            info += '<td style="border: 1px; border-style: solid; border-color: #87CEFA">' + Bm + '</td>';
                            info += '<td style="border: 1px; border-style: solid; border-color: #87CEFA">' + Bz + '</td>';
                            info += '</tr>';
                            i++;

                        }
                    });
                    //显示第三格的内容


                    $('#displayreadinfos').html(info);
                    autoBlockForm('displayjobinfos', 60, 'infoclose', "#ffffff", false); //弹出查询面板
                }
            });
        }
    }

    //获取选择值的真实值
    function getTrueValue(ds, tablename, code, thelimit, limitvalue, theif, theend) {
        var realvalue = '';
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: ds, //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mysql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xmlattr', //返回数据格式 
            tsdpk: 'broadbandjob.querytruevalue' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        if (limitvalue == '' || null == limitvalue) {
            limitvalue = 1;
            thelimit = 1;
        }
        $.ajax({
            url: 'mainServlet.html?' + urlstr + '&tablename=' + tablename + '&code=' + code + '&thelimit=' + thelimit + '&theif=' + theif + '&theend=' + theend + '&limitvalue=' + limitvalue + '&tsdtemp=' + Math.random(),
            datatype: 'xml',
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 1000,
            async: false, //同步方式
            success: function(xml) {
                $(xml).find('row').each(function() {
                    if (realvalue != undefined) {
                        realvalue = $(this).attr(code); //是否已接收     
                        if (realvalue == undefined) {
                            realvalue = limitvalue;
                        }
                    }
                });
            }
        });
        return realvalue;
    }

    //得到故障类型
    function faultType() {
        //获取故障现象
        $("#gztype").html("");
        var res = fetchSingleValue("112jobmanager.getgzxx", 0, "&id=" + $("#gzid").val());
        $.ajax({
            url: "mainServlet.html?packgname=service&clsname=ExecuteSql&method=exeSqlData&ds=tsdBilling&tsdcf=oracle&tsdoper=query&datatype=xmlattr&tsdpk=phoneSeats.queryPxgzinfo",
            datatype: 'xml',
            cache: false,
            timeout: 1000,
            async: false,
            success: function(xml) {
                $(xml).find("row").each(function() {
                    var lngid = $(this).attr("lngid");
                    var strgzxx = $(this).attr("strgzxx");
                    if (lngid != undefined) {

                        $("#gztype").append("<option value='" + strgzxx + "'>" + strgzxx + "</option>");
                        /*
                        if(res==strgzxx){
                        alert(strgzxx);
                            $("#gztype").append("<option value='"+strgzxx+"' selected='selected'>"+strgzxx+"</option>");
                        }else{
                            $("#gztype").append("<option value='"+strgzxx+"'>"+strgzxx+"</option>");
                        }
                        */
                    }
                });
            }

        });
        $("#gztype").append("<option value=''>其它</option>");
        $("#gztype").val(res);
    }
    //双击显示详细信息
    function thisInfo(ids, mqbm, key) {
        clearText('detailInfoform');
        faultType();
        var lxrdh = $("#gzlxdh").val();
        $("#gzlinkphone").val(lxrdh);
        ///设置命令参数
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xmlattr', //返回数据格式 
            tsdpk: '112jobmanager.queryuserdetail' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        //提交之后才可处理
        if (key == 1) {
            $('#hx1').hide();
            $('#hx2').hide();
            $('#hx3').hide();
            $('#hx4').hide();
            $('#hx5').hide();
            $('#submithxinfo').hide();
        } else if (key == 2) {
            $('#hx1').show();
            $('#hx2').show();
            $('#hx3').show();
            $('#hx4').show();
            $('#hx5').show();
            $('#submithxinfo').show();
        } else if (key == 3) {
            $('#hx1').show();
            $('#hx2').show();
            $('#hx3').show();
            $('#hx4').show();
            $('#hx5').show();
            $('#submithxinfo').hide();
        }
        $.ajax({
            url: 'mainServlet.html?dh=' + ids + urlstr + '&tsdtemp=' + Math.random(),
            datatype: 'xml',
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 5000,
            async: false, //同步方式
            success: function(xml) {
                $(xml).find('row').each(function() {
                    var tmp_id = $(this).attr('dh');
                    if (tmp_id != undefined) {


                        //$("#thisJobIDvalue").html(tmp_id);
                        //var tmp_Sgnr = $(this).attr('Sgnr');
                        //if (tmp_Sgnr == null || tmp_Sgnr == undefined) {
                        //    tmp_Sgnr = '';
                        //}
                        //$("#thisJobTypevalue").html(tmp_Sgnr);
                        //var tmp_Mqbm = $(this).attr('Mqbm');
                        //if(tmp_Mqbm=='null'||tmp_Mqbm==undefined){
                        // tmp_Mqbm = '';
                        //}
                        //$("#thismqbmvalue").html(mqbm);
                        if (mqbm == '112班') {
                            $("#thismobile").css("color", "red");
                            $("#thislinkphone").css("color", "red");
                            $("#thislinkman").css("color", "red");
                            $("#thisFee").css("color", "black");
                            $("#thisFeeName").css("color", "black");
                            $("#thissBm").css("color", "black");
                            $("#thissBm2").css("color", "black");
                            $("#thissBm3").css("color", "black");
                            $("#thissBm4").css("color", "black");
                        } else if (mqbm == '外线班') {
                            $("#thismobile").css("color", "black");
                            $("#thislinkphone").css("color", "black");
                            $("#thislinkman").css("color", "black");
                            $("#thisFee").css("color", "red");
                            $("#thisFeeName").css("color", "red");
                            $("#thissBm").css("color", "red");
                            $("#thissBm2").css("color", "red");
                            $("#thissBm3").css("color", "red");
                            $("#thissBm4").css("color", "red");
                        } else {
                            $("#thismobile").css("color", "black");
                            $("#thislinkphone").css("color", "black");
                            $("#thislinkman").css("color", "black");
                            $("#thisFee").css("color", "black");
                            $("#thisFeeName").css("color", "black");
                            $("#thissBm").css("color", "black");
                            $("#thissBm2").css("color", "black");
                            $("#thissBm3").css("color", "black");
                            $("#thissBm4").css("color", "black");
                            <% if (!session.getAttribute("userid").equals("admin")) {
         %>
                            $('#submithxinfo').hide();
                            <% 
    }
    else {
         %>
                            if (mqbm != '112班' || mqbm != '外线班') {
                                $('#submithxinfo').hide();
                            }
                            <% 
    }
     %>
                        }

                        var thissRealNamevalue = $(this).attr('yhmc');
                        $('#thissRealNamevalue').html(thissRealNamevalue);

                        var thissDh2value = $(this).attr('yhxz');
                        $('#thissDh2value').html(thissDh2value);

                        var thissRegDatevalue = $(this).attr('bm1');
                        $('#thissRegDatevalue').html(thissRegDatevalue);
                        var thisfeedendtimevalue = $(this).attr('bm2');
                        $('#thisfeedendtimevalue').html(thisfeedendtimevalue);
                        var thisiFeeTypeTimevalue = $(this).attr('bm3');
                        $('#thisiFeeTypeTimevalue').html(thisiFeeTypeTimevalue);
                        var thisoldsAddressvalue = $(this).attr('bm4');
                        $('#thisoldsAddressvalue').html(thisoldsAddressvalue);

                        var thisoldspeedvalue = $(this).attr('bz8');
                        $('#thisoldspeedvalue').html(thisoldspeedvalue);

                        var thisspeedvalue = $(this).attr('bz9');
                        $('#thisspeedvalue').html(thisspeedvalue);

                        var thisUserNamevalue = $(this).attr('dh');
                        $('#thisUserNamevalue').html(thisUserNamevalue);
                        var thisUserName1value = $(this).attr('idcard');
                        $('#thisUserName1value').html(thisUserName1value);

                        var thisiStatusvalue = $(this).attr('yhdz');
                        $('#thisiStatusvalue').html(thisiStatusvalue);

                        //用户电缆
                        //$("#thisiFeeTypevalue").html(tmp_Dhgn);//thisnewyw
                        //alert(tmp_Xdh);

                        //$('#thisiFeeTypevalue').html(getDhgn(tmp_Xdh));
                        $('#thisiFeeTypevalue').html($(this).attr('dhgn'));
                        $('#thisnewyw').html(getNewYw(thisUserNamevalue));
                        getUserLine(ids); //获取用户号线信息
                        var arr = $('#editgrid').getGridParam('selarrrow');
                        var ids_ = $('#editgrid').getCell(arr[0], 'ID')
                        var oldbz = getOldBz(ids_);
                        $('#thismemovalue').html(oldbz);
                        autoBlockForm('detailInfo', 20, 'detailinfoclose', "#ffffff", false); //弹出查询面板  
                    } else {
                        alert('电话号码不存在');
                    }
                });
            }
        });
    }

    //查看显示信息
    function detailInfo() {
        var arr = $('#editgrid').getGridParam('selarrrow');
        if (arr.length == 0) {
            alert('请勾选要查看的工单!');
            return false;
        } else if (arr.length > 1) {
            alert('一次只能查看一条故障工单!');
            return false;
        } else {
            var ids = $('#editgrid').getCell(arr[0], 'Dh');
            var mqbm = $('#editgrid').getCell(arr[0], 'Mqbm');
            var id = $('#editgrid').getCell(arr[0], 'ID');
            var lxdh = $('#editgrid').getCell(arr[0], 'Lxdh');
            $("#gzlxdh").val(lxdh);
            $("#gzid").val(id);
            thisInfo(ids, mqbm, 2); //显示详细信息
        }
    }

    //获取用户的电话号线信息
    function getUserLine(ids) {
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xmlattr', //返回数据格式 
            tsdpk: '112jobmanager.querylinedetail' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax({
            url: 'mainServlet.html?dh=' + ids + urlstr + '&tsdtemp=' + Math.random(),
            datatype: 'xml',
            cache: false,
            //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 5000,
            async: false, //同步方式
            success: function(xml) {
                var i = 0;
                var $str = '';
                $str += '<table width="100%" border="0"';
                $str += ' style="border: 1px; border-style: solid; border-color: #87CEFA;"';
                $str += ' cellspacing="0" cellpadding="0">';
                $(xml).find('row').each(function() {
                    //账号路由
                    var memo = $(this).attr('value30');
                    if (memo == 'null' || memo == undefined || memo == '') {
                        memo = '';
                    } else {
                        //账号路由id
                        var lineid = $(this).attr('lineid');
                        if (lineid == 'null' || lineid == undefined) {
                            lineid = '';
                        }
                        i++;
                        $str += '<tr id="hx4' + i + '">';
                        $str += '<td class="labelclass" style="width:106px;">号线信息' + i + '</td>';
                        $str += '<td class="tdstyle" colspan="5" >';
                        $str += '<textarea rows="3" cols="115" style="margin-top: 2px"  id="lineRount' + i + '">' + memo + '</textarea>';
                        $str += '<input type="hidden" id="lineRount_old' + i + '" value="' + memo + '"/>';
                        $str += '<input type="hidden" id="line' + i + '" value="' + lineid + '"/>';
                        $str += '</td>';
                        $str += '</tr>';
                    }


                    /**
var tmp_value1 = $(this).attr('value1');
if (tmp_value1 == 'null' || tmp_value1 == undefined) {
tmp_value1 = '';
}
var tmp_value2 = $(this).attr('value2');
if (tmp_value2 == 'null' || tmp_value2 == undefined) {
tmp_value2 = '';
}
var tmp_value3 = $(this).attr('value3');
if (tmp_value3 == 'null' || tmp_value3 == undefined) {
tmp_value3 = '';
}
var tmp_value4 = $(this).attr('value4');
if (tmp_value4 == 'null' || tmp_value4 == undefined) {
tmp_value4 = '';
}
var tmp_value5 = $(this).attr('value5');
if (tmp_value5 == 'null' || tmp_value5 == undefined) {
tmp_value5 = '';
}
var tmp_value6 = $(this).attr('value6');
if (tmp_value6 == 'null' || tmp_value6 == undefined) {
tmp_value6 = '';
}
var tmp_value7 = $(this).attr('value7');
if (tmp_value7 == 'null' || tmp_value7 == undefined) {
tmp_value7 = '';
}
var tmp_value8 = $(this).attr('value8');
if (tmp_value8 == 'null' || tmp_value8 == undefined) {
tmp_value8 = '';
}
var tmp_value9 = $(this).attr('value9');
if (tmp_value9 == 'null' || tmp_value1 == undefined) {
tmp_value9 = '';
}

var tmp_YHth = $(this).attr('value15');
if (tmp_YHth == 'null' || tmp_YHth == undefined) {
tmp_YHth = '';
}

//号线配置相关信息 --2010-08-09
$("#Value1").val(tmp_value1);
//交换机
$("#Value2").val(tmp_value2);
//内配
$("#Value3").val(tmp_value3);
//外配
$("#Value4").val(tmp_value4);
//主干电缆
$("#Value5").val(tmp_value5);
//分电缆
$("#Value6").val(tmp_value6);
//二级交接箱
$("#Value7").val(tmp_value7);
//配线架
$("#Value8").val(tmp_value8);
//分线盒
$("#Value9").val(tmp_value9);

//日志处理使用
$("#Value1s").val(tmp_value1);
$("#Value2s").val(tmp_value2);
$("#Value3s").val(tmp_value3);
$("#Value4s").val(tmp_value4);
$("#Value5s").val(tmp_value5);
$("#Value6s").val(tmp_value6);
$("#Value7s").val(tmp_value7);
$("#Value8s").val(tmp_value8);
$("#Value9s").val(tmp_value9);
*/
                });

                $str += '</table>';
                $("#hx8").html($str);
                $("#hx8").show();
            }
        });
    }

    //获取用户的电话功能信息
    function getDhgn(dh) {
        var res = '';
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xmlattr', //返回数据格式 
            tsdpk: 'teljobmanager.getuserdhgn' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax({
            url: 'mainServlet.html?dh=' + dh + urlstr + '&tsdtemp=' + Math.random(),
            datatype: 'xml',
            cache: false,
            //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 5000,
            async: false, //同步方式
            success: function(xml) {
                $(xml).find('row').each(function() {
                    //取不到部门时间则按默认时间计算工单超时时间
                    var str = $(this).attr("bz");
                    if (str != undefined) {
                        res = str;
                    }
                });
            }
        });
        return res;
    }
    //获取用户新业务信息
    function getNewYw(dh) {
        var res = '';
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xmlattr', //返回数据格式 
            tsdpk: 'teljobmanager.getusernewyw' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax({
            url: 'mainServlet.html?dh=' + dh + urlstr + '&tsdtemp=' + Math.random(),
            datatype: 'xml',
            cache: false,
            //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 5000,
            async: false, //同步方式
            success: function(xml) {
                var infos = '';
                $(xml).find('row').each(function() {
                    //取不到部门时间则按默认时间计算工单超时时间
                    var str = $(this).attr("FeeType");
                    if (str != undefined) {
                        infos += str + ',';
                    }
                });
                infos = infos.substring(0, infos.lastIndexOf(','));
                res = infos;
            }
        });
        return res;
    }


    //获取设备类型和端口号
    function getDeviceType(NodeField) {
        //电话号码
        var xdh = $('#thisUserNamevalue').text();
        var mkj = getMkjs(xdh);
        if (mkj == '') {
            alert('用户【' + xdh + '】的用户档数据不完整，请填写完整用户基本信息!');
            //注：此处判断的依据是MoKuaiju字段的数据
            return;
        }
        window.showModalDialog('mainServlet.html?pagename=line/theDeviceType.jsp&NodeField=' + NodeField + '&mkj=' + tsd.encodeURIComponent(mkj),
            window, "dialogWidth:820px; dialogHeight:450px; center:yes; scroll:yes");
    }
    //方法回调
    function getTheVlaue(thei, str) {
        $('#' + thei).val(str);
    }
    //填写备注，空格处理
    function bzFocus() {
        var bz = $('#hxbz').val();
        $('#hxbz').val($.trim(bz));
        $('#hxbz').focus();
    }
    //添加用户号线信息
    function addLineInfo() {
        //电话号码，需进行数据验证
        var xdh = $('#thisUserNamevalue').text();
        var arr = $('#editgrid').getGridParam('selarrrow');
        var mqbm = $('#editgrid').getCell(arr[0], 'Mqbm')
        var params = '&Dh=' + xdh;
        //用户电话
        var count = getHxCount(xdh);
        //是否已填号线信息
        var sql = '';
        //号线表
        var sql2 = '';
        //工单表
        var hxbz = $('#hxbz').val();
        var ids = $('#thisJobIDvalue').text();
        var ids_ = $('#editgrid').getCell(arr[0], 'ID')
        var oldbz = getOldBz(ids_);
        hxbz = hxbz + ';' + oldbz;
        if (mqbm == '112班') {
            var value1 = $('#Value1').val();
            var value2 = $('#Value2').val();
            var value3 = $('#Value3').val();
            if (value1 == '') {
                alert('交换机信息不允许为空，请填写交换机信息!');
                $('#Value1').focus();
                return;
            } else if (value2 == '') {
                alert('配线架内侧信息不允许为空，请填写配线架内侧信息!');
                $('#Value2').focus();
                return;
            } else if (value3 == '') {
                alert('配线架外侧信息不允许为空，请填写配线架外侧信息!');
                $('#Value3').focus();
                return;
            }
            params += "&Value1=" + tsd.encodeURIComponent(value1);
            params += "&Value2=" + tsd.encodeURIComponent(value2);
            params += "&Value3=" + tsd.encodeURIComponent(value3);
            if (count > 0) {
                //更新数据
                sql = 'teljobmanager.updateuserlineinfo';
            } else {
                //添加数据
                sql = 'teljobmanager.addlineinfo';
            }
            sql2 = 'teljobmanager.updatehxlineinfo';
        } else if (mqbm == '外线班') {
            if (count > 0) {
                var value4 = $('#Value4').val();
                var value5 = $('#Value5').val();
                var value6 = $('#Value6').val();
                var value7 = $('#Value7').val();
                var value8 = $('#Value8').val();
                var value9 = $('#Value9').val();
                sql = 'teljobmanager.updateuserlineinfo2';
                params += "&Value4=" + tsd.encodeURIComponent(value4);
                params += "&Value5=" + tsd.encodeURIComponent(value5);
                params += "&Value6=" + tsd.encodeURIComponent(value6);
                params += "&Value7=" + tsd.encodeURIComponent(value7);
                params += "&Value8=" + tsd.encodeURIComponent(value8);
                params += "&Value9=" + tsd.encodeURIComponent(value9);
                //var oldbz = getOldBz(xdh);
                //hxbz += tsd.encodeURIComponent(oldbz);
                //params += "&bz="+tsd.encodeURIComponent(hxbz);
                sql2 = 'teljobmanager.updatehxlineinfo2';
            } else {
                alert('用户号线资料信息不完整，请填写完整数据!');
                return;
            }
        }
        if (sql != '') {
            params += "&id=" + tsd.encodeURIComponent(ids);
            params += "&Zwbz=" + tsd.encodeURIComponent(hxbz);
            exeSql(params, sql, sql2);
            exeUp112bz(ids_, hxbz, xdh);
        } else {
            alert('数据格式返回错误，请联系系统管理员!');
        }
    }
    //执行sql语句，更新号线表数据
    function exeSql(params, sql, sql2) {
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'exe', //操作类型 
            tsdpk: sql //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        urlstr += params;
        $.ajax({
            url: 'mainServlet.html?ian=1' + urlstr,
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 3000,
            async: false, //同步方式
            success: function(msg) {
                if (msg == "true") {
                    updateTelJobLineinfo(params, sql2);
                    //同步更新电话工单的号线
                    alert('操作成功!');
                    $('#detailinfoclose').click();
                }
            }
        });
    }

    //更新112障碍表里的数据
    function exeUp112bz(id, bz, dh) {
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'exe', //操作类型 
            tsdpk: '112jobmanager.up112hxbz' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax({
            url: 'mainServlet.html?bz=' + tsd.encodeURIComponent(bz) + '&id=' + id + urlstr,
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 3000,
            async: false, //同步方式
            success: function(msg) {
                if (msg == "true") {
                    disWriteLog(dh);
                }
            }
        });
    }

    //记录日志信息
    function disWriteLog(dh) {
        var loginfo = tsd.encodeURIComponent('修改用户【' + dh + '】的号线信息：');
        /*
var value1 = $('#Value1').val();
var value2 = $('#Value2').val();
var value3 = $('#Value3').val();
var value4 = $('#Value4').val();
var value5 = $('#Value5').val();
var value6 = $('#Value6').val();
var value7 = $('#Value7').val();
var value8 = $('#Value8').val();
var value9 = $('#Value9').val();

var value1s = $('#Value1s').val();
var value2s = $('#Value2s').val();
var value3s = $('#Value3s').val();
var value4s = $('#Value4s').val();
var value5s = $('#Value5s').val();
var value6s = $('#Value6s').val();
var value7s = $('#Value7s').val();
var value8s = $('#Value8s').val();
var value9s = $('#Value9s').val();

var v1text = $('#thismobile').text();
var v2text = $('#thislinkphone').text();
var v3text = $('#thislinkman').text();
var v4text = $('#thisFee').text();
var v5text = $('#thisFeeName').text();
var v6text = $('#thissBm').text();
var v7text = $('#thissBm2').text();
var v8text = $('#thissBm3').text();
var v9text = $('#thissBm4').text();

if(value1!=value1s){
loginfo += tsd.encodeURIComponent(v1text) + ':[' + tsd.encodeURIComponent(value1s) + ']>>>[' + tsd.encodeURIComponent(value1) + '];';       
}
if(value2!=value2s){
loginfo += tsd.encodeURIComponent(v2text) + ':[' + tsd.encodeURIComponent(value2s) + ']>>>[' + tsd.encodeURIComponent(value2) + '];'; 
}
if(value3!=value3s){
loginfo += tsd.encodeURIComponent(v3text) + ':[' + tsd.encodeURIComponent(value3s) + ']>>>[' + tsd.encodeURIComponent(value3) + '];'; 
}
if(value4!=value4s){
loginfo += tsd.encodeURIComponent(v4text) + ':[' + tsd.encodeURIComponent(value4s) + ']>>>[' + tsd.encodeURIComponent(value4) + '];'; 
}
if(value5!=value5s){
loginfo += tsd.encodeURIComponent(v5text) + ':[' + tsd.encodeURIComponent(value5s) + ']>>>[' + tsd.encodeURIComponent(value5) + '];'; 
}
if(value6!=value6s){
loginfo += tsd.encodeURIComponent(v6text) + ':[' + tsd.encodeURIComponent(value6s) + ']>>>[' + tsd.encodeURIComponent(value6) + '];'; 
}
if(value7!=value7s){
loginfo += tsd.encodeURIComponent(v7text) + ':[' + tsd.encodeURIComponent(value7s) + ']>>>[' + tsd.encodeURIComponent(value7) + '];'; 
}
if(value8!=value8s){
loginfo += tsd.encodeURIComponent(v8text) + ':[' + tsd.encodeURIComponent(value8s) + ']>>>[' + tsd.encodeURIComponent(value8) + '];'; 
}
if(value9!=value9s){
loginfo += tsd.encodeURIComponent(v9text) + ':[' + tsd.encodeURIComponent(value9s) + ']>>>[' + tsd.encodeURIComponent(value9) + '];'; 
}
*/
        writeLogInfo('', 'modify', loginfo);
    }

    //更新工单表号线信息
    function updateTelJobLineinfo(params, sql) {
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdReport', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'exe', //操作类型 
            tsdpk: sql //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        urlstr += params;
        $.ajax({
            url: 'mainServlet.html?ian=1' + urlstr,
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 3000,
            async: false, //同步方式
            success: function(msg) {
                if (msg == "true") {}
            }
        });
    }
    //获取用户的模块局
    function getHxCount(xdh) {
        var count = 0;
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xmlattr', //返回数据格式 
            tsdpk: 'teljobmanager.gethxcount' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax({
            url: 'mainServlet.html?dh=' + xdh + urlstr + '&tsdtemp=' + Math.random(),
            datatype: 'xml',
            cache: false,
            //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 5000,
            async: false, //同步方式
            success: function(xml) {
                $(xml).find('row').each(function() {
                    //取不到部门时间则按默认时间计算工单超时时间
                    var res = $(this).attr("res");
                    if (res != undefined) {
                        count = res;
                    }
                });
            }
        });
        return count;
    }

    //获取以前备注的信息
    function getDhs(jobids) {
        var dhs = new Array();
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdReport', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xmlattr', //返回数据格式 
            tsdpk: 'teljobmanager.getdhs' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax({
            url: 'mainServlet.html?id=' + jobids + urlstr + '&tsdtemp=' + Math.random(),
            datatype: 'xml',
            cache: false,
            //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 5000,
            async: false, //同步方式
            success: function(xml) {
                $(xml).find('row').each(function() {
                    //取不到部门时间则按默认时间计算工单超时时间
                    var str = $(this).attr("xdh");
                    if (str != undefined) {
                        dhs.push(str);
                    }
                });
            }
        });
        return dhs;
    }

    //获取以前备注的信息
    function getOldBz(id) {
        var bz = '';
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xmlattr', //返回数据格式 
            tsdpk: '112jobmanager.gethxbz' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax({
            url: 'mainServlet.html?id=' + id + urlstr + '&tsdtemp=' + Math.random(),
            datatype: 'xml',
            cache: false,
            //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 5000,
            async: false, //同步方式
            success: function(xml) {
                $(xml).find('row').each(function() {
                    //取不到部门时间则按默认时间计算工单超时时间
                    var str = $(this).attr("bz");
                    if (str != undefined) {
                        bz = str;
                    }
                });
            }
        });
        return bz;
    }

    //获取用户的模块局
    function getMkjs(xdh) {
        var mkj = '';
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xmlattr', //返回数据格式 
            tsdpk: 'teljobmanager.getusermkjs' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax({
            url: 'mainServlet.html?dh=' + xdh + urlstr + '&tsdtemp=' + Math.random(),
            datatype: 'xml',
            cache: false,
            //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 5000,
            async: false, //同步方式
            success: function(xml) {
                $(xml).find('row').each(function() {
                    //取不到部门时间则按默认时间计算工单超时时间
                    var str = $(this).attr("MokuaiJu");
                    if (str != undefined) {
                        mkj = str;
                    }
                });
            }
        });
        return mkj;
    }
    //数据清空
    function clearVal(ids) {
        $('#' + ids).val('');
    }

    //弹出打印面板
    function printDisplay() {
        var arr = $('#editgrid').getGridParam('selarrrow');
        if (arr.length == 0) {
            alert('请选择要打印的工单!');
            return false;
        } else {
            autoBlockForm("choosePrint", "150", "close", "#FFFFFF", false);
        }
    }

    function jobPrint(flag) {
        var arr = $('#editgrid').getGridParam('selarrrow');
        var idarr = new Array();
        var dharr = new Array();
        for (var i = 0; i < arr.length; i++) {
            idarr.push($('#editgrid').getCell(arr[i], 'ID'));
            dharr.push($('#editgrid').getCell(arr[i], 'Dh'));
        }
        
        var params = "&ID=" + idarr;
        params += "&Dh=" + dharr;
        var paramss = "ID_" + idarr;
        paramss += "_Dh_" + dharr;
        var url = "";
        
        //add by wcy 2016-09-06，中石油电话、宽带故障使用不同的打印模板打印
        if ($('#editgrid').getCell(arr[0], 'Sgnr') == '112fault')
        {
	        url = "<%=basePath %>/ReportServer?reportlet=/com/tsdreport/commonreport/dh_112job.cpt" + params;
	        //alert(lsz);
	        if (flag == "1") {
	            printWithoutPreview("commonreport/dh_112job", paramss);
	        } else {
	            window.open(url);
	            //window.showModalDialog(urll,window,"dialogWidth:720px; dialogHeight:350px; center:yes; scroll:no");
	        }
        }
        else if ($('#editgrid').getCell(arr[0], 'Sgnr') == 'radfault')
        {
            url = "<%=basePath %>/ReportServer?reportlet=/com/tsdreport/commonreport/rad_112job.cpt" + params;
            //alert(lsz);
            if (flag == "1") {
                printWithoutPreview("commonreport/rad_112job", paramss);
            } else {
                window.open(url);
                //window.showModalDialog(urll,window,"dialogWidth:720px; dialogHeight:350px; center:yes; scroll:no");
            }
        }
        
        setTimeout($.unblockUI, 15);
        reloadData();
    }

    /**
     *清除完工录入面板
     */
    function clearOver() {
        $('#sjgz').val('');
        $('#cljg').val('');
        $('#clsj').val('');
        $('#clr').val('');

        //$(":radio[name='isok']:checked").attr("checked",false)
    }

    /**
     *获取模块局
     */
    function getMkj() {
        var arr = $('#editgrid').getGridParam('selarrrow');
        var xdh = '';
        for (var i = 0; i < arr.length; i++) {
            //字段标识
            xdh += ',' + $('#editgrid').getCell(arr[i], 'Xdh');
        }
        xdh = xdh.substring(1);
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xmlattr', //返回数据格式 
            tsdpk: 'zsjob.getmkj' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });

        $.ajax({
            url: 'mainServlet.html?' + urlstr + '&dh=' + xdh,
            datatype: 'xml',
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 1000,
            async: false, //同步方式
            success: function(xml) {
                $(xml).find('row').each(function() {
                    res = $(this).attr('mokuaiju');
                });
            }
        });
        return res;
    }

    /**
     *获取批次号
     */
    function getNo() {
        var area = getMkj();
        var hth = $('#hth').val();
        var res = '';
        //调用存储过程
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'Procedure', //类名
            method: 'exequery', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdpname: 'teljob.teljob_getpjh', //执行存储过程         
            datatype: 'xmlattr',
            tsdExeType: 'query'
        });
        $.ajax({
            url: 'mainServlet.html?' + urlstr + '&hth=' + hth + ';area=' + tsd.encodeURIComponent(area),
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 1000,
            async: false, //同步方式
            success: function(xml) {
                $(xml).find('row').each(function() {
                    res = $(this).attr('res');
                });
            }
        });
        return res;
    }

    /**
     *打开查询面板
     */
    function openQuery() {
        autoBlockForm('query', 60, 'exitquery', "#ffffff", false);
    }



    /** 
     *查找故障
     */
    function queryInfo() {
        var starttime = $('#starttime').val();
        var endtime = $('#endtime').val();
        var hth = $('#queryhth').val();
        var phone = $('#phoneno').val();
        var queryjd = '';
        var column = $('#thecolumn').val();
        var modimokuaijus = $("#usermokuaijus").val();
        if (endtime <= starttime) {
            alert('截止时间不能小于起始时间！');
            return false;
        }
        if (starttime != '' && starttime != 'undefined' && starttime != 'null') {
            queryjd += " and sgrq >= to_date('" + starttime + "','yyyy-mm-dd hh24:mi:ss')";
        }
        if (endtime != '' && endtime != 'undefined' && endtime != 'null') {
            queryjd += " and sgrq <= to_date('" + endtime + "','yyyy-mm-dd hh24:mi:ss')";
        }
        /* 
        if(hth != '' && hth != 'undefined' && hth != 'null')
        {
            queryjd+=" and lxr="+tsd.encodeURIComponent(hth);
        }*/

        if (phone != '' && phone != 'undefined' && phone != 'null') {
            queryjd += " and dh=" + phone;
        }
        var userid = $('#userloginid').val();
        var area = queryarea();
        var sql = '112jobmanager.queryinfo2';
        var sqlpage = '112jobmanager.queryinfopage2';
        /**
        if(userid != "admin")
        {
            sql='112jobmanager.queryinfo2';
            sqlpage='112jobmanager.queryinfopage2';
        }
        */
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            datatype: 'xml', //返回数据格式 
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            tsdpk: sql, //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
            tsdpkpagesql: sqlpage //依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
        });
        $('#queryjd').val(queryjd);
        $('#queryerea').val(area);
        /**
        if(userid != "admin")
        {
        */

        $("#editgrid").setGridParam({
            url: 'mainServlet.html?' + urlstr + '&column=' + tsd.encodeURIComponent(column) + '&area=' + tsd.encodeURIComponent('<%=session.getAttribute("managearea") %>') + '&queryjd=' + queryjd
        }).trigger("reloadGrid");
        clearText('query');
        setTimeout($.unblockUI, 15); //关闭面板
        /** 
        }else
        {
            $("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&column='+tsd.encodeURIComponent(column)+'&queryjd='+queryjd}).trigger("reloadGrid");
            clearText('query');
            setTimeout($.unblockUI, 15);//关闭面板
        }
        */
    }

    /**
     *获取用户区域
     */
    function queryarea() {
        var res = '';
        var str = '';
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xmlattr', //返回数据格式 
            tsdpk: 'zsjob.querarea' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax({
            url: 'mainServlet.html?' + urlstr + '&userid=<%=userid%>',
            datatype: 'xml',
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 1000,
            async: false, //同步方式
            success: function(xml) {
                $(xml).find('row').each(function() {
                    res = $(this).attr('userarea');
                });
            }
        });
        if (res.indexOf('~') > 0) {
            str = res.replace(/~/g, "','");
            str = "'" + str + "'";
            return str;
        }
        res = "'" + res + "'";
        return res;
    }


    function get112Userid(userarea, userid) {
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'query', //操作类型 
            datatype: 'xmlattr', //返回数据格式 
            tsdpk: '112jobmanager.get112userid' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        //alert(userarea);
        $.ajax({
            url: 'mainServlet.html?' + urlstr + '&userarea=' + tsd.encodeURIComponent(userarea),
            datatype: 'xml',
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 2000,
            async: false, //同步方式
            success: function(xml) {
                var usernamelist = ''; //空间字符串
                var i = 2; //自增变量
                var thebr = ''; //换行符
                $(xml).find('row').each(function() {
                    var username = $(this).attr('username');
                    if (username == undefined) {
                        usernamelist = '<span style="margin-left:5px">【' + userarea + '】下暂无管理工号<span>';
                    } else {
                        var valchk = '';
                        if (userid.indexOf(username) != -1) {
                            valchk = 'checked="checked"';
                        }
                        usernamelist += "<span class='spanstyle'><input type='checkbox' " + valchk + " name='thisuseridlist' value='" + username + "' style='width:15px;height:15px;margin-left:5px'><label style='text-align: left;margin-left:5px'>" + username + "</label></span>" + thebr;
                        //每行显示四个部门
                        if (i * 1 % 4 == 0) {
                            thebr = '<br/>';
                        } else {
                            thebr = '';
                        }
                        i++;
                    }
                });
                $('#112userlist').html(usernamelist);
            }
        });
    }

    function updateGzInfo() {
        var gztype = $("#gztype").val();
        var gzlinkphone = $("#gzlinkphone").val();
        var gzid = $("#gzid").val();
        var urlstr = tsd.buildParams({
            packgname: 'service', //java包
            clsname: 'ExecuteSql', //类名
            method: 'exeSqlData', //方法名
            ds: 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
            tsdcf: 'mssql', //指向配置文件名称
            tsdoper: 'exe', //操作类型 
            tsdpk: '112jobmanager.updategzxx' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
        });
        $.ajax({
            url: 'mainServlet.html?id=' + gzid + urlstr + '&gztype=' + tsd.encodeURIComponent(gztype) + '&gzlinkphone=' + tsd.encodeURIComponent(gzlinkphone),
            cache: false, //如果值变化可能性比较大 一定要将缓存设成false
            timeout: 3000,
            async: false, //同步方式
            success: function(msg) {
                if (msg == "true") {
                    alert("修改成功！");
                    //关闭界面
                    $('#detailinfoclose').click();
                    //重载
                    reloadData();
                }
            }
        });



    }
    </script>
    <style type="text/css">
    .spanstyle {
        display: -moz-inline-box;
        display: inline-block;
        width: 115px
    }
    
    hr {
        margin: 2px 0 2px 0;
        border: 0;
        border-top: 1px dashed #CCCCCC;
        height: 0;
    }
    
    .btn_2k3 {
        height: 30px;
        BORDER-RIGHT: #87CEFA 1px solid;
        PADDING-RIGHT: 5px;
        BORDER-TOP: #87CEFA 1px solid;
        PADDING-LEFT: 5px;
        FONT-SIZE: 12px;
        FILTER: progid: DXstyle/images/publicTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#FFFFFF, EndColorStr=#87CEFA);
        BORDER-LEFT: #87CEFA 1px solid;
        CURSOR: hand;
        COLOR: black;
        PADDING-TOP: 2px;
        BORDER-BOTTOM: #87CEFA 1px solid
    }
    </style>
</head>

<body>
    <!-- 用户操作导航-->
    <div id="navBar">
        <table width="100%" height="26px">
            <tr>
                <td width="80%" valign="middle">
                    <div id="navBar1" style="float: left">
                        <img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
                        <fmt:message key="global.location" /> :
                    </div>
                </td>
                <td width="20%" align="right" valign="top">
                    <div id="d2back">
                        <a href="javascript:void(0);" onclick="parent.history.back(); return false;">
                            <fmt:message key="gjh.houtuei" /> </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <!-- 用户操作标题以及放一些快捷按钮-->
    <div id="buttons">
        <button type="button" id="queryButton" onclick="openQuery()">
            查找
        </button>
        <button type="button" id="deloper" onclick="deleteRows()">
            撤销工单
        </button>
        <button type="button" id="sendjobs" onclick="sendJobs()" style="display:none">
            发送工单
        </button>
        <button type="button" id="sendjobs" onclick="printDisplay()">
            工单打印
        </button>
        <button type="button" id="fhjobs" onclick="fhJobs()">
            故障复核
        </button>
        <button type="button" id="pxjobs" onclick="pxJobs()">
            故障派修
        </button>
        <button type="button" id="endjobs" onclick="endJobs()">
            确认完工
        </button>
        <button type="button" id="readjobs" onclick="readJobs()" style="display:none">
            查看流程
        </button>
        <button type="button" id="detialjobs" onclick="detailInfo()" style="display:none">
            详细信息
        </button>
    </div>
    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
    <div id="pagered" class="scroll" style="text-align: left;"></div>
    <div id="buttons" style="display: none">
        <button type="button" id="">
            人工受理
        </button>
        <button type="button" id="">
            删除
        </button>
        <button type="button" id="">
            发送工单
        </button>
        <button type="button" id="">
            故障复核
        </button>
        <button type="button" id="">
            故障派修
        </button>
        <button type="button" id="">
            确认完工
        </button>
    </div>
    <!-- 人工受理112障碍工单 -->
    <div class="neirong" id="fault112" style="display: none;width: 720px">
        <div class="top">
            <div class="top_01" id="thisdrag">
                <div class="top_01left">
                    <div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
                    <div class="top_03" id="fault112div">人工受理电话障碍申告</div>
                    <div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
                </div>
                <div class="top_01right"><a href="#" onclick="javascript:$('#fault112close').click()">关闭</a></div>
            </div>
            <div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>
        </div>
        <div class="midd">
            <form action="#" name="fault112form" id="fault112form" onsubmit="return false;">
                <table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="labelclass">
                            <label>
                                受理电话
                            </label>
                        </td>
                        <td width="20%" class="tdstyle">
                            <input type="text" name="sldh" id="sldh" class="textclass" onkeyup="value=value.replace(/[^\d]/g,'')" style="width: 130px" />
                        </td>
                        <td class="labelclass">
                            故障现象
                        </td>
                        <td width="20%" class="tdstyle">
                            <select id="gzxx" class="textclass"></select>
                        </td>
                        <td class="labelclass">
                            联系电话
                        </td>
                        <td width="20%" class="tdstyle">
                            <input type="text" name="lxdh" id="lxdh" class="textclass" style="width: 130px" onkeyup="value=value.replace(/[^\d]/g,'')" />
                        </td>
                    </tr>
                    <tr>
                        <td class="dflabelclass">
                            备注
                        </td>
                        <td colspan="5">
                            <textarea rows="6" id="gzbz" cols="82" style="margin-left: 5px"></textarea>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="midd_butt">
            <button type="submit" class="tsdbutton" id="saveinfo" onclick="saveRgsl()">
                保存
            </button>
            <button type="submit" class="tsdbutton" id="fault112close" style="margin-left: 10px">
                关闭
            </button>
        </div>
    </div>
    <!-- 发送112障碍工单 -->
    <div class="neirong" id="fault112send" style="display: none;width: 680px">
        <div class="top">
            <div class="top_01" id="thisdrag">
                <div class="top_01left">
                    <div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
                    <div class="top_03" id="fault112div">发送工单</div>
                    <div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
                </div>
                <div class="top_01right"><a href="#" onclick="javascript:$('#fault112sendclose').click()">关闭</a></div>
            </div>
            <div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>
        </div>
        <div class="midd">
            <form action="#" name="fault112sendform" id="fault112sendform" onsubmit="return false;">
                <table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
                    <tr height="90px">
                        <td class="dflabelclass">
                            派工备注
                        </td>
                        <td width="20%">
                            <textarea rows="6" id="pgbz" cols="42" style="margin: 2px 5px 2px 5px"></textarea>
                        </td>
                        <td class="dflabelclass">
                            流向部门
                        </td>
                        <td width="30%">
                            <div id="displaybms"></div>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="midd_butt">
            <button type="submit" class="tsdbutton" onclick="sendJobs('send')">
                发送
            </button>
            <button type="submit" class="tsdbutton" id="fault112sendclose" style="margin-left: 10px">
                关闭
            </button>
        </div>
    </div>
    <!-- 112障碍复核 -->
    <div class="neirong" id="fault112fh" style="display: none;width: 680px">
        <div class="top">
            <div class="top_01" id="thisdrag">
                <div class="top_01left">
                    <div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
                    <div class="top_03" id="fault112div">故障复核</div>
                    <div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
                </div>
                <div class="top_01right"><a href="#" onclick="javascript:$('#fault112fhclose').click()">关闭</a></div>
            </div>
            <div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>
        </div>
        <div class="midd">
            <form action="#" name="fault112fhform" id="fault112fhform" onsubmit="return false;">
                <table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="dflabelclass">
                            用户电话
                        </td>
                        <td width="200px">
                            <label id="confirmdh"></label>
                        </td>
                        <td class="dflabelclass">
                            故障信息
                        </td>
                        <td width="200px">
                            <label id="confirmgzxx"></label>
                        </td>
                        <td class="dflabelclass">
                            复核结果
                        </td>
                        <td width="200px">
                            <select id="fhgzxx" class="textclass"></select>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="midd_butt">
            <button type="submit" class="tsdbutton" onclick="fhJobs('fh')">
                确认
            </button>
            <button type="submit" class="tsdbutton" id="fault112fhclose" style="margin-left: 10px">
                关闭
            </button>
        </div>
    </div>
    <!-- 112障碍故障派修 -->
    <div class="neirong" id="fault112px" style="display: none;width: 580px">
        <div class="top">
            <div class="top_01" id="thisdrag">
                <div class="top_01left">
                    <div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
                    <div class="top_03" id="fault112div">故障派修</div>
                    <div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
                </div>
                <div class="top_01right"><a href="#" onclick="javascript:$('#fault112pxclose').click()">关闭</a></div>
            </div>
            <div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>
        </div>
        <div class="midd">
            <form action="#" name="fault112pxform" id="fault112pxform" onsubmit="return false;">
                <table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="labelclass" width="20%">
                            维修人员
                        </td>
                        <td class="tdstyle">
                            <select id="pxuseridlist" class="textclass" style="width: 180px"></select>
                            <font style="color: red">*</font>
                        </td>
                    </tr>
                    <tr>
                        <td class="dflabelclass" width="20%">
                            派修备注
                        </td>
                        <td>
                            <textarea rows="6" id="pxbz" cols="72" style="margin-left: 5px"></textarea>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="midd_butt">
            <button type="submit" id="isareauserid" class="tsdbutton" onclick="pxJobs('px')">
                确认
            </button>
            <button type="submit" class="tsdbutton" id="fault112pxclose" style="margin-left: 10px">
                关闭
            </button>
        </div>
    </div>
    <!-- 完工录入面板 -->
    <div class="neirong" id="fault112end" style="display: none;width: 680px">
        <div class="top">
            <div class="top_01" id="thisdrag">
                <div class="top_01left">
                    <div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
                    <div class="top_03" id="titlediv">用户故障录入单</div>
                    <div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
                </div>
                <div class="top_01right"><a href="#" onclick="javascript:$('#fault112endclose').click();">关闭</a></div>
            </div>
            <div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>
        </div>
        <div class="midd">
            <form action="#" onsubmit="return false;">
                <table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="labelclass">
                            <label for="vzh">
                                处理过程
                                <!-- 实际故障  处理过程-->
                            </label>
                        </td>
                        <td width="20%" colspan="3" class="tdstyle">
                            <textarea rows="5" cols="86" id="sjgz" name="sjgz" style="margin-left: 5px;margin-top: 5px"></textarea>
                        </td>
                    </tr>
                    <tr style="height: 25px">
                        <td class="labelclass">
                            <label for="vcomplete">
                                处理时间
                            </label>
                        </td>
                        <td width="20%" class="tdstyle">
                            <input type="text" id="clsj" class="textclass" name="clsj" onFocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
                        </td>
                        <td class="labelclass" width="10%" align="left">
                            处理结果
                        </td>
                        <td width="20%" class="tdstyle">
                            <input type="text" class="textclass" id="cljg" name="cljg" />
                        </td>
                    </tr>
                    <tr height="35px">
                        <td class="labelclass">
                            <label for="ufault">
                                处理人
                            </label>
                        </td>
                        <td width="20%" class="tdstyle" colspan="3">
                            <!-- <input type="text" class="textclass" id="clr" name="clr"/> -->
                            <div id="112userlist" style="max-height:200px;overflow-y: auto;overflow-x: hidden;"></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="dflabelclass">
                            <label for="vcomfault">
                                用户满意度
                            </label>
                        </td>
                        <td width="20%">
                            <input type="radio" name="isok" id="isok" checked="checked" value="1" style="margin-left: 3px" />满意
                        </td>
                        <td width="10%" align="left">
                            <input type="radio" name="isok" id="isok" value="2" />基本满意
                        </td>
                        <td width="20%" align="center">
                            <input type="radio" name="isok" id="isok" value="3" />不满意
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="midd_butt">
            <button type="button" class="tsdbutton" id="tijiaomodify" onclick="endJobs('end')" style="margin-left: 5%">
                提交
            </button>
            <button type="button" class="tsdbutton" id="fault112endclose">
                关闭
            </button>
        </div>
    </div>
    <!-- 查看流程的面板 -->
    <div class="neirong" id="displayjobinfos" style="display: none;width:750px">
        <div class="top">
            <div class="top_01" id="thisdrag">
                <div class="top_01left">
                    <div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
                    <div class="top_03" id="titlediv">查看工单流程</div>
                    <div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
                </div>
                <div class="top_01right"><a href="#" onclick="javascript:$('#infoclose').click();">关闭</a></div>
            </div>
            <div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>
        </div>
        <div class="midd">
            <form action="#" name="operform" id="operform" onsubmit="return false;">
                <div id="displayreadinfos" style="overflow-y: auto;overflow-x: hidden;max-height:300px;background-color: #ffffff">
                </div>
            </form>
        </div>
        <div class="midd_butt">
            <button type="button" class=btn_2k3 id="infoclose" style="width: 70px;margin-left: 10px">
                <fmt:message key="global.close" />
            </button>
        </div>
    </div>
    <!-- 显示工单详细信息的面板 -->
    <div class="neirong" id="detailInfo" style="display: none; width: 850px;">
        <div class="top">
            <div class="top_01">
                <div class="top_01left">
                    <div class="top_02">
                        <img src="style/images/public/neibut01.gif" />
                    </div>
                    <div class="top_03" id="titlediv">
                        112障碍工单详细信息
                    </div>
                    <div class="top_04">
                        <img src="style/images/public/neibut03.gif" />
                    </div>
                </div>
                <div class="top_01right">
                    <a href="#" onclick="javascritp:$('#detailinfoclose').click();">关闭</a>
                </div>
            </div>
            <div class="top02right">
                <img src="style/images/public/toptiaoright.gif" />
            </div>
        </div>
        <div class="midd" style="height:350px;overflow-y: auto;overflow-x: hidden;">
            <form action="#" name="detailInfoform" id="detailInfoform" onsubmit="return false;">
                <table width="100%" id="tdiv" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;" cellspacing="0" cellpadding="0">
                    <tr>
                        <td colspan="6" style="text-align: left" class="labelclass">
                            <b>用户基本信息</b>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelclass">
                            <label for="sarea">
                                <span id="thissRealName"></span>
                                <input type="text" style="width: 0px; height: 0px; margin-left: -1000px" id="ian-tsd" />
                                <!-- 转移焦点用的 -->
                                <span id="thisJobID"></span>
                            </label>
                        </td>
                        <td width="20%" class="tdstyle">
                            <div id="thissRealNamevalue"></div>
                        </td>
                        <td class="labelclass">
                            <label for="sarea">
                                <span id="thissDh2"></span>
                            </label>
                        </td>
                        <td width="20%" class="tdstyle">
                            <div id="thissDh2value"></div>
                        </td>
                        <td class="labelclass">
                            <label for="sarea">
                                <span id="thissRegDate"></span>
                            </label>
                        </td>
                        <td width="20%" class="tdstyle">
                            <div id="thissRegDatevalue"></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelclass">
                            <label for="sarea">
                                <span id="thisfeedendtime"></span>
                            </label>
                        </td>
                        <td width="20%" class="tdstyle">
                            <div id="thisfeedendtimevalue"></div>
                        </td>
                        <td class="labelclass">
                            <label for="sarea">
                                <span id="thisiFeeTypeTime"></span>
                            </label>
                        </td>
                        <td width="20%" class="tdstyle">
                            <div id="thisiFeeTypeTimevalue"></div>
                        </td>
                        <td class="labelclass">
                            <label for="sarea">
                                <span id="thisoldsAddress"></span>
                            </label>
                        </td>
                        <td width="20%" class="tdstyle">
                            <div id="thisoldsAddressvalue"></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelclass">
                            <label for="sarea">
                                <span id="thisoldspeed"></span>
                            </label>
                        </td>
                        <td width="20%" class="tdstyle">
                            <div id="thisoldspeedvalue"></div>
                        </td>
                        <td class="labelclass">
                            <label for="sarea">
                                <span id="thisspeed"></span>
                            </label>
                        </td>
                        <td width="20%" class="tdstyle">
                            <div id="thisspeedvalue"></div>
                        </td>
                        <td class="labelclass">
                            <label for="sarea">
                                <span id="thisUserName"></span>
                            </label>
                        </td>
                        <td width="20%" class="tdstyle">
                            <div id="thisUserNamevalue"></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelclass">
                            <label for="sarea">
                                <span id="thisUserName1"></span>
                            </label>
                        </td>
                        <td width="20%" class="tdstyle">
                            <div id="thisUserName1value"></div>
                        </td>
                        <td class="labelclass">
                            <label for="sarea">
                                <span id="thisiStatus"></span>
                            </label>
                        </td>
                        <td width="20%" class="tdstyle" colspan="3">
                            <div id="thisiStatusvalue"></div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" style="text-align: left" class="labelclass">
                            <b>电话业务基本信息</b>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelclass">
                            <label for="sarea">
                                <span id="thisiFeeType"></span>
                            </label>
                        </td>
                        <td class="tdstyle" colspan="5">
                            <div id="thisiFeeTypevalue"></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelclass">
                            <label for="sarea">
                                <span>新业务</span>
                            </label>
                        </td>
                        <td class="tdstyle" colspan="5">
                            <div id="thisnewyw"></div>
                        </td>
                    </tr>
                    <tr id='hx1'>
                        <td colspan="6" style="text-align: left" class="labelclass">
                            <b>号线基本信息</b>
                        </td>
                    </tr>
                    <tr id='hx4'>
                        <td colspan="6" id='hx8'>
                        </td>
                    </tr>
                    <tr id='hx5'>
                        <td class="labelclass">
                            备注信息
                        </td>
                        <td class="tdstyle" colspan="5">
                            <textarea rows="3" cols="115" style="margin-top: 2px;" onfocus="bzFocus()" id="hxbz"></textarea>
                        </td>
                    </tr>
                    <tr id='gz1'>
                        <td colspan="6" style="text-align: left" class="labelclass">
                            <b>故障基本信息</b>
                        </td>
                    </tr>
                    <tr id='hx5'>
                        <td class="labelclass" id='lxr'>
                            联系电话
                        </td>
                        <td class="tdstyle" colspan="1">
                            <input type='text' id='gzlinkphone' />
                        </td>
                        <td class="labelclass" id='lxr'>
                            故障现象
                        </td>
                        <td class="tdstyle" colspan="1">
                            <select id="gztype" class="wenben_6">
                            </select>
                        </td>
                        <td class="labelclass" colspan="2">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" style="text-align: left" class="labelclass">
                            <b>其他</b>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelclass">
                            <label for="sarea">
                                <span id="thisifurgent"></span>
                            </label>
                        </td>
                        <td width="20%" class="tdstyle">
                            <div id="thisifurgentvalue"></div>
                        </td>
                        <td class="labelclass">
                            <label for="sarea">
                                <span id="thismemo"></span>
                            </label>
                        </td>
                        <td width="20%" class="tdstyle" colspan="5">
                            <textarea disabled="disabled" rows="5" cols="70" style="margin-top: 2px" id="thismemovalue"></textarea>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="midd_butt">
            <button type="button" class=btn_2k3 id="submithxinfo" onclick="addLineInfo()" style="width: 70px; margin-left: 10px">
                提交
            </button>
            <button type="button" class=btn_2k3 id="updateGZ" onclick="updateGzInfo()" style="width: 70px; margin-left: 10px">
                提交
            </button>
            <button type="button" class=btn_2k3 id="detailinfoclose" style="width: 70px; margin-left: 10px">
                <fmt:message key="global.close" />
            </button>
        </div>
    </div>
    <input type="hidden" id="thecolumn" />
    <input type="hidden" id="gzid" />
    <input type="hidden" id="gzlxdh" />
    <input type="hidden" id="editvalue1right" />
    <input type="hidden" id="editvalue2right" />
    <input type="hidden" id="editvalue3right" />
    <input type="hidden" id="editvalue4right" />
    <input type="hidden" id="editvalue5right" />
    <input type="hidden" id="editvalue6right" />
    <input type="hidden" id="editvalue7right" />
    <input type="hidden" id="editvalue8right" />
    <input type="hidden" id="editvalue9right" />
    <input type="hidden" id="Value1s" />
    <input type="hidden" id="Value2s" />
    <input type="hidden" id="Value3s" />
    <input type="hidden" id="Value4s" />
    <input type="hidden" id="Value5s" />
    <input type="hidden" id="Value6s" />
    <input type="hidden" id="Value7s" />
    <input type="hidden" id="Value8s" />
    <input type="hidden" id="Value9s" />
    <input type="hidden" id="islimitdeptright" />
    <input type="hidden" id="endjobsright" />
    <input type="hidden" id="departname" value="<%=session.getAttribute(" departname ") %>" />
    <input type="hidden" id="userloginid" value="<%=session.getAttribute(" userid ") %>" />
    <input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' />
    <iframe id="printReportDirect" style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>
    <div class="neirong" id="choosePrint" style="display: none;width:650px">
        <div class="top">
            <div class="top_01" id="thisdrag">
                <div class="top_01left">
                    <div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
                    <div class="top_03" id="titlediv">工单打印</div>
                    <div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
                </div>
                <div class="top_01right"></div>
            </div>
            <div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>
        </div>
        <div class="midd" style="background-color: #FFFFFF;height: 60px">
            <br />
            <button id="printDirect" class="tsdbutton" onclick="jobPrint(1)">
                <fmt:message key="broadband.zhijiePrint" />
            </button>
            <button id="printInDirect" class="tsdbutton" onclick="jobPrint(0)">
                <fmt:message key="broadband.yulanPrint" />
            </button>
            <br/>
        </div>
        <div class="midd_butt">
        </div>
    </div>
    <!-- 查询工单面板 -->
    <div class="neirong" id="query" style="display: none;width:800px">
        <div class="top">
            <div class="top_01" id="thisdrag">
                <div class="top_01left">
                    <div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
                    <div class="top_03" id="titlediv">项目名称</div>
                    <div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
                </div>
                <div class="top_01right"><a href="#" onclick="javascript:$('exitquery').click();">关闭</a></div>
            </div>
            <div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>
        </div>
        <div class="midd">
            <form action="#" name="queryform" id="queryform" onsubmit="return false;">
                <table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="labelclass">
                            <label for="sarea">
                                <span id="bt">起始时间：</span>
                            </label>
                            <br />
                        </td>
                        <td class="tdstyle" width="20%">
                            <input type="text" name="starttime" id="starttime" class="textclass" onFocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
                            <br />
                        </td>
                        <td class="labelclass">
                            <label for="sarea">
                                <span id="et">截止时间：</span>
                            </label>
                            <br />
                        </td>
                        <td class="tdstyle" width="20%">
                            <input type="text" name="endtime" id="endtime" class="textclass" onFocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <!-- <td class="labelclass">
                <label for="sarea">
                    <span id="heth">合同号：</span>
                </label>
            </td>
            <td>
                <input type="text" name="queryhth" id="queryhth" class="textclass" />
            </td> -->
                        <td class="labelclass">
                            <label for="sarea">
                                <span id="phone">电话号    ：</span>
                            </label>
                            <br />
                        </td>
                        <td>
                            <input type="text" name="phoneno" id="phoneno" class="textclass" style="colspan:3;" />
                            <br />
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="midd_butt">
            <button type="submit" class="tsdbutton" id="querythis" onclick="queryInfo()">
                查找
            </button>
            <button type="submit" class="tsdbutton" id="exitquery" style="margin-left: 10px">
                退出
            </button>
        </div>
    </div>
    <input type="hidden" id="usermokuaijus" />
</body>

</html>
