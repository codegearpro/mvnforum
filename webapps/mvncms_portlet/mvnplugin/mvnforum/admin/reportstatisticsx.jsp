<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/reportstatisticsx.jsp,v 1.12 2009/07/16 03:28:23 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.12 $
  - $Date: 2009/07/16 03:28:23 $
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
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page errorPage="fatalerror.jsp"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.admin.reportstatisticsx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css" />
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<br/>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isServlet) {%>
  <a href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "misctasks")%>"><fmt:message key="mvnforum.admin.misctasks.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.admin.reportstatisticsx.title"/>
</div>
<br/>

<div class="pagedesc">
  <fmt:message key="mvnforum.admin.reportstatisticsx.info"/><br />
  <fmt:message key="mvnforum.admin.reportstatisticsx.info_export"/><br /><br/>
  <fmt:message key="mvnforum.common.prompt.choose_tasks"/><br/>
  <a href="<%=urlResolver.encodeURL(request, response, "processreportimpressions")%>" class="command"><fmt:message key="mvnforum.admin.processreportimpressionsx.title"/></a><br />
  <a href="<%=urlResolver.encodeURL(request, response, "processreportforums")%>" class="command"><fmt:message key="mvnforum.admin.processreportforumsx.title"/></a><br />
  <% if (memberDAO.isSupportGetMembers_withSortSupport_limit()) { %>
    <a href="<%=urlResolver.encodeURL(request, response, "processreportmembers")%>" class="command"><fmt:message key="mvnforum.admin.processreportmembersx.title"/></a><br />
  <% } %>
  <a href="<%=urlResolver.encodeURL(request, response, "processreportthreads")%>" class="command"><fmt:message key="mvnforum.admin.processreportthreadsx.title"/></a><br />
  <a href="<%=urlResolver.encodeURL(request, response, "processreportpolls")%>" class="command"><fmt:message key="mvnforum.admin.processreportpollsx.title"/></a><br />
</div>
<br/>

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>
