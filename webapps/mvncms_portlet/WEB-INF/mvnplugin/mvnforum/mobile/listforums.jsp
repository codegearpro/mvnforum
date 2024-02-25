<?xml version="1.0" encoding="UTF-8"?>
<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/WEB-INF/mvnplugin/mvnforum/mobile/listforums.jsp,v 1.21 2009/07/17 04:03:54 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.21 $
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
<%@ page import="net.myvietnam.mvncore.filter.EnableEmotionFilter" %>
<%@ page import="net.myvietnam.mvncore.security.Encoder" %>
<%@ page import="com.mvnforum.db.*" %>
<%@ page import="com.mvnforum.common.*" %>
<%@ page import="com.mvnforum.auth.OnlineUserAction" %>
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
Collection categoryBeans = (Collection)request.getAttribute("CategoryBeans");
Collection forumBeans = (Collection)request.getAttribute("ForumBeans");
boolean haveCategory = false;
%>
<div id="bullet">
<%
for (Iterator catIterator = categoryBeans.iterator(); catIterator.hasNext(); ) {
    CategoryBean categoryBean = (CategoryBean)catIterator.next();
    if (MyUtil.canViewAtLeastOneForumInCategory(categoryBean.getCategoryID(), permission) == false) continue;
%>
  <ul><span class="section_header"><%=categoryBean.getCategoryName()%></span>    
<%  
    for (Iterator forumIterator = forumBeans.iterator(); forumIterator.hasNext(); ) {
        ForumBean forumBean = (ForumBean)forumIterator.next();
        if ( (forumBean.getCategoryID() == categoryBean.getCategoryID()) &&
              permission.canReadPost(forumBean.getForumID()) &&
              (forumBean.getForumStatus() != ForumBean.FORUM_STATUS_DISABLED) ) {
            haveCategory = true;
%>
            <li>
              <a href="listthreads?forum=<%=forumBean.getForumID()%>" ><%=forumBean.getForumName()%></a>
              <%
              boolean checkCondition = (forumBean.getLastPostMemberName().length() == 0) || (forumBean.getForumThreadCount() == 0);
              if (checkCondition) {
              %>
              (<fmt:message key="mvnforum.common.thread_count"/>: <%=forumBean.getForumThreadCount()%>, <fmt:message key="mvnforum.common.post_count"/>: <%=forumBean.getForumPostCount()%>, <fmt:message key="mvnforum.mobile.lastpost"/>: <fmt:message key="mvnforum.user.listforums.table.no_post"/>)
              <%} else {
              PostBean lastPost = PostCache.getInstance().getLastEnablePost_inForum(forumBean.getForumID());
              int threadID = lastPost.getThreadID();
              %>
              (<fmt:message key="mvnforum.common.thread_count"/>: <%=forumBean.getForumThreadCount()%>, <fmt:message key="mvnforum.common.post_count"/>: <%=forumBean.getForumPostCount()%>, <a href="viewthread?thread=<%=threadID%>&amp;lastpage=yes#lastpost"><fmt:message key="mvnforum.mobile.lastpost"/></a>&nbsp;<fmt:message key="mvnforum.mobile.lastpost_by"/>&nbsp;<span class='log_name'><%= forumBean.getLastPostMemberName()%></span>&nbsp;<fmt:message key="mvnforum.mobile.lastpost_on"/>&nbsp;<%=onlineUser.getGMTTimestampFormat(forumBean.getForumLastPostDate())%>)
              <%}%>
            </li>      
<%}//if the forum is in the current category
} //for forumIndex%>
    </ul>
<%} //for catIndex%>
</div>
<%if (haveCategory == false) {%>
  <div><fmt:message key="mvnforum.user.listforums.table.no_category" /></div>
<%}// if no category %>

</mvn:body>
</mvn:html>
</fmt:bundle>