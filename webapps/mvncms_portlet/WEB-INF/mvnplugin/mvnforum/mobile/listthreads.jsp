<?xml version="1.0" encoding="UTF-8"?>
<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/WEB-INF/mvnplugin/mvnforum/mobile/listthreads.jsp,v 1.24 2009/07/17 04:03:54 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.24 $
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
<%@ page import="java.util.*" %>
<%@ page import="net.myvietnam.mvncore.util.*"%>
<%@ page import="net.myvietnam.mvncore.util.ParamUtil" %>
<%@ page import="net.myvietnam.mvncore.util.StringUtil" %>
<%@ page import="com.mvnforum.*" %>
<%@ page import="com.mvnforum.db.*" %>
<%@ page import="com.mvnforum.MVNForumGlobal" %>
<%@ page import="com.mvnforum.MVNForumConstant" %>
<%@ page import="com.mvnforum.auth.OnlineUserAction" %>

<%@ include file="inc_common.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>

<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/></mvn:title>
  <link href="<%=contextPath%>/mvnplugin/mvnforum/css/styleMobile.css" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<%
boolean hasAnAttachment = false;
boolean hasPoll = false;
int totalThreads = ((Integer)request.getAttribute("TotalThreads")).intValue();
int memberPostsPerPage = onlineUser.getPostsPerPage();
int forumID = ParamUtil.getParameterInt(request, "forum");
ForumBean currentForumBean = ForumCache.getInstance().getBean(forumID);
%>
<div class="topmenu"><a href="index"><fmt:message key="mvnforum.mobile.main_menu" /></a></div>
<fmt:message key="mvnforum.common.forum" />: <span class="section_header"><a href="listthreads?forum=<%=forumID%>"><%=currentForumBean.getForumName()%></a></span>
<div class="hightlighttitle">&nbsp;&nbsp;&nbsp;&nbsp;<a href="addpost?forum=<%=forumID%>"><fmt:message key="mvnforum.mobile.newthread"/></a></div>
<div id="bullet">
<pg:pager
  url="listthreads"
  items="<%= totalThreads %>"
  maxPageItems="<%= memberPostsPerPage %>"
  isOffset="true"
  export="offset,currentPageNumber=pageNumber"
  scope="request">
<% String rowsType = MVNForumResourceBundle.getString(onlineUser.getLocale(), "mvnforum.common.numberof.normal_threads"); %>
<%-- keep track of preference --%>
<pg:param name="sort"/>
<pg:param name="order"/>
<pg:param name="forum"/>

<div id="bullet">
<ul>
<%  
    Collection threadBeans = (Collection) request.getAttribute("ThreadBeans");
    if(threadBeans.isEmpty())
    {
%>
        <fmt:message key="mvnforum.user.listthreads.table.no_thread" />
<%         
    } else {
        int index = 0;
        for (Iterator iterator = threadBeans.iterator(); iterator.hasNext(); ) {
        ThreadBean threadBean = (ThreadBean)iterator.next();
        index++;
        int postCount = threadBean.getThreadReplyCount() + 1;
        int totalPages = (postCount / memberPostsPerPage) + ( (postCount % memberPostsPerPage) == 0 ? 0 : 1);
%>
<pg:item>
    <li>
      <a href='viewthread?thread=<%= threadBean.getThreadID()%>'><%=MyUtil.filter(threadBean.getThreadTopic(), false/*html*/, true/*emotion*/, true/*mvnCode*/, true/*newLine*/, true/*URL*/)%></a>
      <fmt:message key="mvnforum.common.by"/>&nbsp;<span class='log_name'><%= threadBean.getMemberName()%></span>
      (<a href="viewthread?thread=<%= threadBean.getThreadID()%>&amp;lastpage=yes#lastpost"><fmt:message key="mvnforum.mobile.lastpost"/></a>&nbsp;<fmt:message key="mvnforum.mobile.lastpost_by"/>&nbsp;<span class='log_name'><%= threadBean.getLastPostMemberName()%></span>&nbsp;<fmt:message key="mvnforum.mobile.lastpost_on"/>&nbsp;<%=onlineUser.getGMTTimestampFormat(threadBean.getThreadLastPostDate())%>) 
    </li>
</pg:item>
<%     }//end for 
    }//end else
%>
</ul>
</div>
</pg:pager>
</div>

</mvn:body>
</mvn:html>
</fmt:bundle>