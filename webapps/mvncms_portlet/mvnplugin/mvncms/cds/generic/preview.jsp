<%--
 - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/generic/preview.jsp,v 1.6 2010/02/24 08:32:31 trungth Exp $
 - $Author: trungth $
 - $Revision: 1.6 $
 - $Date: 2010/02/24 08:32:31 $
 -
 - ====================================================================
 -
 - Copyright (C) 2005 by MyVietnam.net
 -
 - MyVietnam.net PROPRIETARY/CONFIDENTIAL PROPERTIES. Use is subject to license terms.
 - You CANNOT use this software unless you receive a written permission from MyVietnam.net
 -
 - @author: MyVietnam.net developers
 -
 --%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page session="false" errorPage="fatalerror.jsp"%>

<%@ page import="com.mvnforum.auth.*"%>
<%@ page import="com.mvnsoft.mvncms.db.*"%>
<%@ page import="com.mvnsoft.mvncms.cds.standard.handler.WebHandlerManager"%>

<%@ taglib uri="mvntaglib" prefix="mvn" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
OnlineUserManager onlineUserManager = OnlineUserManager.getInstance();
OnlineUser onlineUser = onlineUserManager.getOnlineUser(request);
String currentLocale = onlineUser.getLocaleName();

ContentBean content = (ContentBean) request.getAttribute("ContentBean");
ChannelBean channelBean = (ChannelBean) request.getAttribute("ChannelBean");
%>
<fmt:setLocale value="${currentLocale}" />
<fmt:setBundle basename="i18n/mvncms/mvncms_i18n" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><fmt:message key="mvncms.common.mvncmsadmin.title" /> - <fmt:message key="mvncms.preview.title" /></title>
<link href="<%=request.getContextPath()%>/mvnplugin/mvncms/cms/jscripts/tiny_mce2/plugins/template/css/template.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/mvnplugin/mvncms/css/prettify.css" rel="stylesheet" type="text/css"/>
<script src="<%=request.getContextPath()%>/mvnplugin/mvnforum/js/prettify/prettify.js" type="text/javascript"></script>
</head>
<body onload="prettyPrint()">

<table border="0" cellpadding="0" cellspacing="0" width="98%" align="center">
  <tr>
    <td><br /></td>
  </tr>                
  <tr>
    <td width="100%" align="left">
      <%@include file="preview_inner.jsp"%>
    </td>
  </tr>
  <tr>
    <td><br /></td>
  </tr>
</table>

</body>
</html>
