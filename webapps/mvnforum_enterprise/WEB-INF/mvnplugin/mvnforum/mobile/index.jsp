<?xml version="1.0" encoding="UTF-8"?>
<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/WEB-INF/mvnplugin/mvnforum/mobile/index.jsp,v 1.17 2009/05/11 02:21:54 xuantl Exp $
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
<%@ include file="inc_common.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name" /></mvn:title>
  <link href="<%=contextPath%>/mvnplugin/mvnforum/css/styleMobile.css" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<hr class="hrfooter" />
<div id="bullet">
  <ul>
    <li><a href="listforums"><fmt:message key="mvnforum.user.listforums.title" /></a></li>
    <li><a href="listrecentthreads"><fmt:message key="mvnforum.user.header.recent_threads" /></a></li>
    <li><a href="listonlineusers"><fmt:message key="mvnforum.user.header.who_online" /></a></li>
  </ul>
</div>
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>