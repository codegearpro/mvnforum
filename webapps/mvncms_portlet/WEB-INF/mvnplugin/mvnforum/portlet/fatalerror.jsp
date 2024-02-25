<%--
  - $Header: /home/cvsroot/portlet-mvnforum/srcweb/WEB-INF/mvnplugin/mvnforum/portlet/fatalerror.jsp,v 1.9 2010/08/20 05:16:10 minhnn Exp $
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
<%@ page session="false" isErrorPage="true"%>

<%@ page import="org.slf4j.Logger" %>
<%@ page import="org.slf4j.LoggerFactory" %>
<%@ page import="net.myvietnam.mvncore.util.MailUtil" %>
<%@ page import="com.mvnforum.MVNForumConfig" %>

<%
log.error("Assertion in portlet.fatalerror.jsp", exception);
%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">

<link href="<%=request.getContextPath()%>/mvnplugin/mvnforum/css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/mvnplugin/mvnforum/js/myvietnam.js"></script>

<div class="pagedesc">
  <span class="warning"><fmt:message key="mvnforum.user.fatalerror.error_info"/></span>
  <br/><br/>
  <b>&raquo;&nbsp;</b>
  <script type="text/javascript">
  //<![CDATA[
    var emailtitle = "<%=MailUtil.getEmailUsername(MVNForumConfig.getWebMasterEmail())%>";
    var emaildomain= "<%=MailUtil.getEmailDomain(MVNForumConfig.getWebMasterEmail())%>";
    writeEmail(emailtitle, emaildomain, "Report serious bug in mvnForum", "", "<fmt:message key="mvnforum.user.fatalerror.report_bug"/>", "command");
  //]]>
  </script>
</div>
</fmt:bundle>

<%!
    private static final Logger log = LoggerFactory.getLogger("com.mvnforum.portlet.fatalerror.jsp");
%>
