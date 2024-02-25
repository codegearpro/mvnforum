<%--
  - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/fatalerror.jsp,v 1.7 2009/12/11 03:14:49 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.7 $
  - $Date: 2009/12/11 03:14:49 $
  -
  - ====================================================================
  -
  - Copyright (C) 2005-2008 by MyVietnam.net
  -
  - MyVietnam.net PROPRIETARY/CONFIDENTIAL PROPERTIES. Use is subject to license terms.
  - You CANNOT use this software unless you receive a written permission from MyVietnam.net
  -
  - @author: MyVietnam.net developers
  -
--%>
<%@ page session="false" isErrorPage="true"%>

<%@ page import="org.slf4j.Logger" %>
<%@ page import="org.slf4j.LoggerFactory" %>
<%@ page import="com.mvnsoft.mvncms.cds.CDSConstants"%>
<%@ page import="com.mvnsoft.mvncms.cds.standard.handler.WebHandlerManager"%>

<%
log.error("Assertion in user.fatalerror.jsp", exception);

WebHandlerManager webHandlerManagerInFatalPage = (WebHandlerManager) request.getAttribute("WebHandlerManager");
int channelID = webHandlerManagerInFatalPage.getPropertyInt(CDSConstants.PROPERTY_ROOT_CHANNEL_ID);
%>
<%@ include file="inc_common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>Serious Error</title>
  <link href="<%=cdsTemplate%>/css/cds.css" rel="stylesheet" type="text/css" />
</head>
<body>
<%@include file="header.jsp"%>
<table cellpadding="0" cellspacing="0" width="770" border="0" align="center" class="bgwhite">
  <tr>
    <td>
      <div align="center" class="pageTitle">This is a serious error!!!</div>
      <br />
      <div align="center" class="messageTextBold">Please report this bug to <a href="mailto:abc@abc.com?subject=Report serious error">Web site Administrator</a> by providing detailed steps to reproduce this error. Thanks you.</div>
    </td>
  </tr>
  <%if (isNews == false) { %>
  <tr>
    <td valign="top"><%@include file="footer.jsp"%></td>
  </tr>
  <%} %>
</table>

</body>
</html>
<%!
private static final Logger log = LoggerFactory.getLogger("com.mvnsoft.mvncms.fatalerror.jsp");
%>
