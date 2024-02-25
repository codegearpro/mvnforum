<%--
  - $Header: /home/cvsroot/portlet-mvnforum/srcweb/WEB-INF/mvnplugin/mvnforum/portlet/recentthreads.jsp,v 1.7 2010/08/20 05:16:09 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.7 $
  - $Date: 2010/08/20 05:16:09 $
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
<%@ page import="com.mvnforum.portlet.common.*" %>

<%@ include file="inc_common.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css">

<%
Collection recentThreads = (Collection)request.getAttribute("RecentThreads");
%>
  <table class="tborder" border="0" cellspacing="1" cellpadding="3" width="100%">
  <mvn:cssrows>
    <tr>
      <td align="center" nowrap class="portlet-section-header"><div align="center"><fmt:message key="mvnforum.user.header.recent_threads"/><div></td>
    </tr>
<% if ((recentThreads == null) || (recentThreads.size() == 0)) { %>
    <tr class="<mvn:cssrow/>">
      <td align="center"><fmt:message key="mvnforum.user.listrecentthreads.table.no_threads"/></td>
    </tr>
<% } else {
    for (Iterator iter = recentThreads.iterator(); iter.hasNext(); ) {
      LinkedThread recentThread = (LinkedThread)iter.next();
      ThreadBean thread = recentThread.getThread();%>
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
      <% if (thread.getThreadAttachCount() > 0) { %>
        <img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/attach.gif" title="<%=thread.getThreadAttachCount()%> <% if (thread.getThreadAttachCount() == 1) {%><fmt:message key="mvnforum.common.attachment"/><% } else {%><fmt:message key="mvnforum.common.attachments"/><%}%>"/>
      <% } %>
        <a href="<%=recentThread.getLink()%>"><%=thread.getThreadTopic()%></a>
      </td>
    </tr>
<%  } //for 
   } //else %>
  </mvn:cssrows>
  </table>
</fmt:bundle>