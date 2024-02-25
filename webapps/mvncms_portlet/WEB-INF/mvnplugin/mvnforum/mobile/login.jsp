<?xml version="1.0" encoding="UTF-8"?>
<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/WEB-INF/mvnplugin/mvnforum/mobile/login.jsp,v 1.17 2009/05/11 02:21:54 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.17 $
  - $Date: 2009/05/11 02:21:54 $
  -
  - ====================================================================
  -
  - Copyright (C) 2002-2007 by MyVietnam.net
  -
  - MyVietnam.net PROPRIETARY/CONFIDENTIAL PROPERTIES. Use is subject to license terms.
  - You CANNOT use this software unless you receive a written permission from MyVietnam.net
  -
  - @author: Nhan Luu Duy
  -
--%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.1//EN"
  "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile11.dtd">
<%@ page errorPage="fatalerror.jsp"%>
<%@ page import="net.myvietnam.mvncore.util.*" %>
<%@ include file="inc_common.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name" /></mvn:title>
  <link href="<%=contextPath%>/mvnplugin/mvnforum/css/styleMobile.css" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<div class="topmenu"><a href="index"><fmt:message key="mvnforum.mobile.main_menu" /></a></div>
<br />
<form action="loginprocess" method="post">
  <div class="padding1px"><label for="MemberName"><fmt:message key="mvnforum.common.member.login_name" /></label></div>
  <div class="padding1px"><input type="text" id="MemberName" name="MemberName" value="<%=ParamUtil.getAttribute(request, "MemberName")%>" class="login" /></div>
  <div class="padding1px"><label for="MemberMatkhau"><fmt:message key="mvnforum.common.member.password" /></label></div>
  <div class="padding1px"><input type="password" id="MemberMatkhau" name="MemberMatkhau" class="login" /></div>
  <div><input type="submit" name="submit" value="<fmt:message key="mvnforum.common.action.login" />" class="but_log" /></div>
</form>
</mvn:body>
</mvn:html>
</fmt:bundle>
