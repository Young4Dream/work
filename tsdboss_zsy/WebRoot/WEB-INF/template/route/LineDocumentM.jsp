<br>
<%----------------------------------------
	name: LineDocumentM.jsp
	author: youhongyu
	version: 1.0 
	description: 号线用户资料管理-文档管理 
	Date: 2012-2-21
	modifydate： 2012-8-24
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
%>
<head>
	<!-- 文档上传、下载 -->
    <script type="text/javascript" src="script/route/LineDocumentM.js"></script>
    <script src="script/system/ajaxfileupload.js" type="text/javascript"></script>
	<script type="text/javascript">
	</script>
</head>
	<!-- 路由设置面板 -->
		<div class="neirong" id="documentMForm" style="display: none; width: 800px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							专线用户号线资料
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#documentMclose').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form action="#" name="documentMforms" id="documentMforms"
					onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td>
								<div>
									<div>
										<div style="margin-left: 5px;" id="upLoadPan">												
											<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">							
											  <tr style="border-top:1px solid #A9C8D9;">
											  <!--  
											    <td width="20%" align="right" class="labelclass"><label id="" >文档名称</label></td>							
											    <td width="30%" align="left" style="border-bottom:1px solid #A9C8D9;">
											    	<input type="text" name="docName" id="docName" class="textclass" maxlength="100" 
											    		/>						
												</td>
											 -->  
											    <td width="15%" align="right"  class="labelclass"><label id="">文件类型</label></td>
											    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
											    	<select name="docType" id="docType" class="textclass">
														<option value="1" >word文档</option>
														<option value="2" >excel文档</option>						
													</select>
											    </td> 
											    <td width="15%" align="right"  class="labelclass"><label id="">上传文件</label></td>
											    <td width="40%" align="left" style="border-bottom:1px solid #A9C8D9;" >
											    	<input type="file" id="Ctrl_Up_File_Line" name="Ctrl_Up_File_Line"  class="textclass" style="width:385px"/>
											    </td>												
											    <td width="10%" align="left"  style="border-bottom:1px solid #A9C8D9;">
											    	<button class='btn_2k3' style='margin-left:5px;width:60px' onclick="AiruploadFile()">上传</button>
											    </td>										    			  
											</tr>		
											</table>							
											
										</div>
										<iframe id="idownload" frameborder="0" name="weidu" scrolling="no" width="1px" height="1px"></iframe>
									</div> 
									<hr />
									<div id='HasDocument' style="max-height:100px;overflow-y: auto;overflow-x: hidden;width: 600px;margin-left: 105px;line-height: 20px;">
									</div>	
									<!-- 
									<div style="color: red;" align="center" >
										为了防止文件重名，建议文件以[电话]+[说明]命名，请您确定上传的文件没有重名
									</div>
									 -->									
								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">				
				<button type="button" class="tsdbutton" id="documentMclose"
					onclick="">
					关闭
				</button>
			</div>
		</div>
		
		<input type='hidden'  id="deleteinformation" value="您确定要删除该文档吗？"/>
		<!-- 删除文档权限 -->
		<input type='hidden'  id="deletefileright" />
		<!-- 上传文档权限 -->
		<input type='hidden'  id="uploadDocRight" />
		<input type='hidden'  id="upFlag" />
		<input type='hidden'  id="uptype" />
		<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
		<input type='hidden' id='DocDhType' />
		<input type='hidden' id='Docdh' />
		<input type="hidden" id="operationtips"
			value='<fmt:message key="global.operationtips"/>' />
		<input type="hidden" id="successful"
			value='<fmt:message key="global.successful"/>' />