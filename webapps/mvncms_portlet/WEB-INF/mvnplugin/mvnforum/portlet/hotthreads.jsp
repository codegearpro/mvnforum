<%--
  - $Header: /home/cvsroot/portlet-mvnforum/srcweb/WEB-INF/mvnplugin/mvnforum/portlet/hotthreads.jsp,v 1.9 2010/08/20 05:16:10 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.9 $
  - $Date: 2010/08/20 05:16:10 $
  -
  - ====================================================================
  -
  - Copyright (C) 2002-2010 by MyVietnam.net
  -
  - MyVietnam.net PROPRIETARY/CONFIDENTIAL PROPERTIES. Use is subject to license terms.
  - You CANNOT use this software unless you receive a written permission from MyVietnam.net
  -
  - @author: MyVietnam.net developers
  -
--%>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="java.util.*" %>
<%@ page import="com.mvnforum.db.*" %>
<%@ page import="com.mvnforum.common.*" %>
<%@ page import="com.mvnforum.portlet.common.*" %>

<%@ include file="inc_common.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css">

<%
if (MVNForumConfig.getEnableMostActiveThreads()) {
  Collection activeThreads = (Collection)request.getAttribute("ActiveThreads");
%>
  <table class="tborder" border="0" cellspacing="1" cellpadding="3" width="100%">
  <mvn:cssrows>
    <tr>
      <td nowrap class="portlet-section-header"><div align="center"><fmt:message key="mvnforum.common.most_active_threads_since_last_week"/></div></td>
    </tr>
<% if ((activeThreads == null) || (activeThreads.size() == 0)) { %>
    <tr class="<mvn:cssrow/>">
      <td align="center"><fmt:message key="mvnforum.common.no_active_threads"/></td>
    </tr>
<% } else {
    for (Iterator iter = activeThreads.iterator(); iter.hasNext(); ) {
      LinkedActiveThread activeThread = (LinkedActiveThread)iter.next();
      ActiveThread thread = activeThread.getThread();
      int postCount = thread.getLastPostCount(); %>
    <tr class="<mvn:cssrow/>">
      <td class="portlet-font">
        <img src="<%=contextPath%>/mvnplugin/mvnforum/images/bullet.gif" title="bullet" alt="bullet">
     <% String typeImage = "";
        switch (thread.getThreadType()) {
          case ThreadBean.THREAD_TYPE_STICKY: typeImage = "sticky.gif"; break;
          case ThreadBean.THREAD_TYPE_FORUM_ANNOUNCEMENT: typeImage = "announce.gif"; break;
          case ThreadBean.THREAD_TYPE_GLOBAL_ANNOUNCEMENT: typeImage = "global_announce.gif"; break;
          default: break;
        } 
        if (thread.getThreadType() != ThreadBean.THREAD_TYPE_DEFAULT) { %>
        <img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/<%=typeImage%>"/>
     <% } %>
     <% if (thread.getAttachCount() > 0) {%>
        <img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/attach.gif" title="<%=thread.getAttachCount()%> <% if (thread.getAttachCount() == 1) {%><fmt:message key="mvnforum.common.attachment"/><% } else {%><fmt:message key="mvnforum.common.attachments"/><%}%>"/>
     <% } %>
     
        <a href="<%=activeThread.getLink()%>"><%=thread.getThreadTopic()%></a>
        (<b><%=postCount%></b> <% if (postCount == 1) {%><fmt:message key="mvnforum.common.new_post"/><% } else { %><fmt:message key="mvnforum.common.new_posts"/><% } %>)
      </td>
    </tr>
<% } //for 
  } //else %>
  </mvn:cssrows>
  </table>
<%
} // if enable active threads
%>
</fmt:bundle>