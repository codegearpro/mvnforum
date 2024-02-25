<?xml version="1.0" encoding="UTF-8"?>
<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/WEB-INF/mvnplugin/mvnforum/mobile/viewpost.jsp,v 1.1 2009/07/17 02:33:04 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.1 $
  - $Date: 2009/07/17 02:33:04 $
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

<%@ page import="java.util.*" %>
<%@ page import="com.mvnforum.db.*" %>
<%@ page import="com.mvnforum.common.*" %>
<%@ page import="com.mvnforum.MyUtil" %>
<%@ page import="com.mvnforum.*" %>

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

<%
ThreadBean threadBean = (ThreadBean)request.getAttribute("ThreadBean");
PostBean postBean = (PostBean)request.getAttribute("PostBean");
int forumID = threadBean.getForumID();
ForumBean currentForumBean = ForumCache.getInstance().getBean(forumID);
%>

<fmt:message key="mvnforum.common.forum" />: <span class="section_header"><a href="listthreads?forum=<%=forumID%>"><%=currentForumBean.getForumName()%></a></span><br />
<fmt:message key="mvnforum.common.thread" />: <span class="section_header"><a href='viewthread?thread=<%= threadBean.getThreadID()%>'><%=MyUtil.filter(threadBean.getThreadTopic() , false/*html*/, true/*emotion*/, true/*mvnCode*/, true/*newLine*/, true/*URL*/ )%></a></span>
<div class="section_title"><fmt:message key="mvnforum.mobile.lastpost_by"/>&nbsp;<span class="log_name"><%=postBean.getMemberName()%></span>&nbsp;<fmt:message key="mvnforum.mobile.lastpost_on"/>&nbsp;<%=onlineUser.getGMTTimestampFormat(postBean.getPostLastEditDate())%>,
<a href="addpost?parent=<%=postBean.getPostID()%>"><fmt:message key="mvnforum.mobile.replypost"/></a></div>
<span><%=MyUtil.filter(postBean.getPostBody(), false/*html*/, true/*emotion*/, true/*mvnCode*/, true/*newLine*/, true/*URL*/)%></span>
</mvn:body>
</mvn:html>
</fmt:bundle>