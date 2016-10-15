<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String sCSS= "login1";
int irandomnum= (int)Math.ceil(Math.random()*8);

if (irandomnum == 1)
{
	sCSS = "login3";
}
else if (irandomnum == 2)
{
	sCSS = "login4";
}else if (irandomnum == 3)
{
	sCSS = "login3";
}else if (irandomnum == 4)
{
	sCSS = "login4";
}else if (irandomnum == 5)
{
	sCSS = "login6";
}else if (irandomnum == 6)
{
	sCSS = "login6";
}
else if (irandomnum == 7)
{
	sCSS = "login3";
}else if (irandomnum >= 8)
{
	sCSS = "login4";
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<c:if test="${param.languageType!=null}">
		<fmt:setLocale value="${param.languageType}" scope="session" />
	</c:if>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="x-ua-compatible" content="ie=7" />
	<title><fmt:message key="main.thetitle"/></title>
	<link rel="Shortcut icon" href="style/images/public/favicon.ico"/>
    <link rel="stylesheet" type="text/css" href="style/css/login/login_header.css" />
	<link type="text/css" rel="stylesheet" href="style/css/login/<%=sCSS %>.css" />
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="script/public/mainStyle.js" type="text/javascript"></script>                        
	<script src="script/system/login.js" type="text/javascript"></script>
	<script type="text/javascript">
	var i = 0;//提示输入密码

	//连续回车
	function fnEntClick(){
		var susername = $('#susername').val();
 		var spassword = $('#spassword').val();
		if(susername != '' && spassword != ''){
			$('#fnLogin').click();
		}else if(susername == ''){
			alert('<fmt:message key="login.useridnotnull"/>');//工号不允许为空
			$('#susername').focus();
		}else if(spassword == '' && susername != ''){
			if(i>1){
				alert('<fmt:message key="login.passwordnotnull"/>');//密码不允许为空
			}
			i++;
			$('#spassword').focus();
		}
	}
	//系统登陆
	function login(){
			var params=buildParams('<fmt:message key="login.useridnotnull"/>','<fmt:message key="login.passwordnotnull"/>');
			if(params==false){return false;}
			var urlstr="mainServlet.html?ds=tsdBilling&login=true&logintype=1"+params;
			$.ajax({
				url:urlstr,
				datatype:'xml',
				type:'post',
				cache:false,
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
					var sreturnres = $(xml).find("row").text();//返回结果
				    if (sreturnres == "success") //登录验证成功
				    {
				    	<%
				    	String languageType = request.getParameter("languageType");
				    	if(null == languageType || "".equals(languageType)){
				    		languageType = "zh_CN";
				    	}
				    	%>
						window.location="mainServlet.html?pagename=system/main.jsp&languageType=<%=languageType %>";
				    } else if(sreturnres == "notexists"){//用户不存在
				    	alert('<fmt:message key="login.notexist"/>');
						$('#susername').focus();
					}else if(sreturnres == "passworderror"){//密码错误
						alert('<fmt:message key="login.passworderror"/>');
						$('#spassword').val('');
						$('#spassword').focus();
					}else if(sreturnres == "limited"){//限制登陆
						alert('<fmt:message key="login.loginlimit"/>');
						$('#susername').focus();
					}else if(sreturnres == "iplimit"){//当前用户登陆ip被限制
						alert('<fmt:message key="login.iplimit"/>');
						$('#susername').focus();
					}else if(sreturnres == "logined"){ //工号已经登陆
					    alert('<fmt:message key="login.haslogined"/>');
					    $('#susername').focus();
					}
				}
			});
		}			
	</script>
</head>

<body>
<!--header部分-->
<div class="header_bk">
<div class="header">
  <div class="logo"></div>
  <div class="header_word"><fmt:message key="main.thetitle"/></div>
  <div class="header_right_word">
  	<ul>
    	<li><a href="<%=basePath %>help/help.doc" ><fmt:message key="main.help"/><!--设为主页--></a></li>
        <li>|</li>
        <li><a href="#" onclick="fnSetHome(this)"><fmt:message key="main.homepage"/><!--帮助中心--></a></li>
    </ul>
  </div>
</div>
</div>

<!--main 部分-->
<div class="main_out">

	<div class="main-inner">
    	<div class="main">
        	<div class="top_out">
            	<!--语言选择部分-->
                <div class="top_line">
                  <select name="select" size="1">
                    <option value="zh_CN"><fmt:message key="login.chinese"/>(Chinese)</option>
                	<!--<option value="en"><fmt:message key="login.english"/>(English)</option> -->
                  </select>
                </div>
                
            </div>
            <div class="input_div"></div>
            <div class="input_div">
            	<fmt:message key="login.susername" /><!--工号：-->:<input type="text" id="susername" />
            </div>
            <div class="input_div2">
            	<fmt:message key="login.spassword" /><!--密码：-->:<input type="password" id="spassword" style="line-height:23px;" />
            </div>
            <div class="anniu">
            	<div class="kong"></div>
            	<div class="aniu"><a href="javascript:void(0)" id='fnLogin' onclick="login()"><fmt:message key="main.thelogin" /><!-- 登录--></a></div>
                <div class="aniu"><a href="javascript:void(0)" onclick="dataReset()">
									<fmt:message key="main.thereset" /><!-- 重置 -->
								</a></div>
            </div>
      </div>
    </div>

</div>

<!--footer部分-->
<div class="footer">
	<div class="footer-inner">
    	<!--电信业务综合管理系统V10.0--版权所有 北京泰思达网络通信技术有限公司-->
    	<!-- 
			<fmt:message key="login.warninfo4"/>
			 -->
    </div>
</div>
</body>
</html>