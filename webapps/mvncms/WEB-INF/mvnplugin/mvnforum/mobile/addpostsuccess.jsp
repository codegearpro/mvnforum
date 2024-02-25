<?xml version="1.0" encoding="UTF-8"?>
<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/WEB-INF/mvnplugin/mvnforum/mobile/addpostsuccess.jsp,v 1.12 2009/07/17 04:03:54 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.12 $
  - $Date: 2009/07/17 04:03:54 $
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
<%@ page import="net.myvietnam.mvncore.util.ParamUtil" %>
<%@ page import="com.mvnforum.MVNForumResourceBundle" %>
<%@page import="com.mvnforum.db.PostBean"%>
<%@ include file="inc_common.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
    <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/></mvn:title>
    <link href="<%=contextPath%>/mvnplugin/mvnforum/css/styleMobile.css" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<div class="topmenu"><a href="index"><fmt:message key="mvnforum.mobile.main_menu"/></a></div>
<br/>

<%
PostBean postBean = (PostBean)request.getAttribute("PostBean");
int postID = postBean.getPostID();
String threadID = ParamUtil.getAttribute(request, "ThreadID");
%>
    <div class="padding1px"><a href="viewthread?thread=<%=threadID%>&amp;lastpage=yes#<%=postID%>"><fmt:message key="mvnforum.user.success.go_current_thread"/></a></div>
    <div class="padding1px"><a href="listthreads?forum=<%=request.getAttribute("ForumID")%>"><fmt:message key="mvnforum.user.success.go_current_forum"/></a></div>
</mvn:body>
</mvn:html>
</fmt:bundle>
