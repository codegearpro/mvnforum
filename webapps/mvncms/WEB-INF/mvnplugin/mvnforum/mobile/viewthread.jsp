<?xml version="1.0" encoding="UTF-8"?>
<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/WEB-INF/mvnplugin/mvnforum/mobile/viewthread.jsp,v 1.22 2009/07/17 04:03:54 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.22 $
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
<%@ page import="net.myvietnam.mvncore.util.AssertionUtil" %>
<%@ page import="net.myvietnam.mvncore.util.ImageUtil"%>
<%@ page import="net.myvietnam.mvncore.util.StringUtil" %>
<%@ page import="com.mvnforum.db.*" %>
<%@ page import="com.mvnforum.common.*" %>
<%@ page import="com.mvnforum.MyUtil" %>
<%@ page import="com.mvnforum.auth.OnlineUserAction" %>
<%@ page import="com.mvnforum.MVNForumConstant" %>
<%@ page import="com.mvnforum.*" %>

<%@ include file="inc_common.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name" /></mvn:title>
  <link href="<%=contextPath%>/mvnplugin/mvnforum/css/styleMobile.css" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<div class="topmenu"><a href="index"><fmt:message key="mvnforum.mobile.main_menu" /></a></div>
<div id="bullet">

<%
ThreadBean threadBean = (ThreadBean)request.getAttribute("ThreadBean");
Collection postBeans = (Collection)request.getAttribute("PostBeans");
int numberOfPosts = ((Integer)request.getAttribute("NumberOfPosts")).intValue();
int memberPostsPerPage = onlineUser.getPostsPerPage();

int threadID = ((Integer)request.getAttribute("thread")).intValue();
AssertionUtil.doAssert(threadID == threadBean.getThreadID(), "2 threadID are not the same.");
String rowsType = MVNForumResourceBundle.getString(onlineUser.getLocale(), "mvnforum.common.numberof.posts");
int forumID = threadBean.getForumID();
ForumBean currentForumBean = ForumCache.getInstance().getBean(forumID);
%>

<pg:pager
  url="viewthread"
  items="<%= numberOfPosts %>"
  maxPageItems="<%= memberPostsPerPage %>"
  isOffset="true"
  export="offset,currentPageNumber=pageNumber"
  scope="request">

<pg:param name="thread" value="<%=String.valueOf(threadID)%>"/>

<div id="bullet">
<ul>
<fmt:message key="mvnforum.common.forum" />: <span class="section_header"><a href="listthreads?forum=<%=forumID%>"><%=currentForumBean.getForumName()%></a></span><br />
<fmt:message key="mvnforum.common.thread" />: <span class="section_header"><%=MyUtil.filter(threadBean.getThreadTopic() , false/*html*/, true/*emotion*/, true/*mvnCode*/, true/*newLine*/, true/*URL*/ )%></span>
<div class="hightlighttitle">&nbsp;&nbsp;&nbsp;&nbsp;<a href="addpost?forum=<%=forumID%>"><fmt:message key="mvnforum.mobile.newthread"/></a></div>
<%
    int lastPostCount = 1;
    for(Iterator iterator = postBeans.iterator(); iterator.hasNext(); lastPostCount++) {
        PostBean postBean = (PostBean) iterator.next();
        String postBody = ImageUtil.removeImageFromText(postBean.getPostBody());
%>
        <pg:item>
            <a name="<%=postBean.getPostID()%>"></a>
            <%if (lastPostCount == postBeans.size()) {%>
              <a name="lastpost"></a>
            <%}%>
            <div class="section_title"><fmt:message key="mvnforum.mobile.lastpost_by"/>&nbsp;<span class="log_name"><%=postBean.getMemberName()%></span>&nbsp;<fmt:message key="mvnforum.mobile.lastpost_on"/>&nbsp;<%=onlineUser.getGMTTimestampFormat(postBean.getPostLastEditDate())%>,
            <a href="addpost?parent=<%=postBean.getPostID()%>"><fmt:message key="mvnforum.mobile.replypost"/></a></div>
            <span><%=MyUtil.filter(StringUtil.getShorterString(postBody, 300), false/*html*/, true/*emotion*/, true/*mvnCode*/, true/*newLine*/, true/*URL*/)%></span>
            <%if (postBody.length() > 300) {%>
            <div align="right"><a href="viewpost?post=<%=postBean.getPostID()%>"><fmt:message key="mvnforum.mobile.viewpost"/></a></div>
            <%}%>
        </pg:item>
 <%
    }
 %>       
</ul>
<br />
</div>
<span>
  <fmt:message key="mvnforum.user.viewthread.total_posts"/>: <%=numberOfPosts%>
</span>
        
<%@ include file="inc_pager.jsp"%>
</pg:pager>
</div>
</mvn:body>
</mvn:html>
</fmt:bundle>