<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/votethreadsuccessx.jsp,v 1.8 2009/07/16 03:28:22 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.8 $
 - $Date: 2009/07/16 03:28:22 $
 -
 - ====================================================================
 -
 - Copyright (C) 2002-2007 by MyVietnam.net
 -
 - MyVietnam.net PROPRIETARY/CONFIDENTIAL PROPERTIES. Use is subject to license terms.
 - You CANNOT use this software unless you receive a written permission from MyVietnam.net
 -
 - @author: MyVietnam.net developers
 -
--%>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="net.myvietnam.mvncore.util.ParamUtil" %>
<%@ page import="com.mvnforum.MVNForumResourceBundle" %>
<%@ page import="com.mvnforum.db.PostBean" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<%
String forumID  = ParamUtil.getAttribute(request, "ForumID");
String threadID = ParamUtil.getAttribute(request, "ThreadID");
String offset   = ParamUtil.getAttribute(request, "offset");;// we cannot know the offset, so set it to 0 (first page)

String defaultLink = "viewthread?thread=" + threadID + "&amp;offset=" + offset;
%>
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.votethreadsuccessx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<meta http-equiv="refresh" content="3; url=<%=urlResolver.encodeURL(request, response, defaultLink)%>"/>

<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<br/>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.votethreadsuccessx.title"/>
</div>
<br/>

<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td><fmt:message key="mvnforum.common.success.prompt"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><b>&raquo;&nbsp;</b><a class="command" href="<%=urlResolver.encodeURL(request, response, defaultLink)%>"><fmt:message key="mvnforum.user.success.go_current_thread"/> (<fmt:message key="mvnforum.common.success.automatic"/>)</td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><b>&raquo;&nbsp;</b><a class="command" href="<%=urlResolver.encodeURL(request, response, "listthreads?forum=" + request.getAttribute("ForumID"))%>"><fmt:message key="mvnforum.user.success.go_current_forum"/></a></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><b>&raquo;&nbsp;</b><a class="command" href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.user.success.go_index"/></a></td>
  </tr>
</mvn:cssrows>
</table>

<br/>
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>