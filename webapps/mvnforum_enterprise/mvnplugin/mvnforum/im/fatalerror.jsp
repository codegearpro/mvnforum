<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/im/fatalerror.jsp,v 1.17 2009/07/16 03:28:22 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.17 $
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
<%@ page session="false" isErrorPage="true"%>

<%@ page import="net.myvietnam.mvncore.util.MailUtil" %>
<%@ page import="com.mvnforum.MVNForumConfig" %>
<%@ page import="org.slf4j.Logger" %>
<%@ page import="org.slf4j.LoggerFactory" %>

<%
log.error("Assertion in user.fatalerror.jsp", exception);
%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.fatalerror.title"/></mvn:title>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css">
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<br/>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.fatalerror.title"/>
</div>
<br/>

<div class="pagedesc">
  <span class="warning"><fmt:message key="mvnforum.user.fatalerror.error_info"/></span><br/><br/>
  <b>&raquo;&nbsp;</b>
  <script type="text/javascript">
    var emailtitle = "<%=MailUtil.getEmailUsername(MVNForumConfig.getWebMasterEmail())%>";
    var emaildomain= "<%=MailUtil.getEmailDomain(MVNForumConfig.getWebMasterEmail())%>";
    writeEmail(emailtitle, emaildomain, "Report serious bug in mvnForum", "", "<fmt:message key="mvnforum.user.fatalerror.report_bug"/>", "command");
  </script>
</div>

<br/>
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>
<%!
    private static final Logger log = LoggerFactory.getLogger("com.mvnforum.user.fatalerror.jsp");
%>
