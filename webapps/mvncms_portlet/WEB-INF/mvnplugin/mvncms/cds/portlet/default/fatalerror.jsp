<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/fatalerror.jsp,v 1.6 2009/09/18 07:52:10 minhnn Exp $
 - $Author: minhnn $
 - $Revision: 1.6 $
 - $Date: 2009/09/18 07:52:10 $
 -
 - ====================================================================
 -
 - Copyright (C) 2005 by MyVietnam.net
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

<%
log.error("Assertion in admin.fatalerror.jsp", exception);
%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<fmt:bundle basename="i18n/mvncms/mvncms_i18n">

<html>
<head>
  <title><fmt:message key="mvncms.common.error.serious_error"/></title>
</head>
<link href="<%=request.getContextPath()%>/style.css" rel=stylesheet type=text/css>
<body>

<div align="center" class="pageTitle"><fmt:message key="mvncms.common.error.this_is_serious_error"/>!!!</div>
<p>
<div align="center" class="messageTextBold"><fmt:message key="mvncms.common.error.please_report_this_bug_to"/> <a href="mailto:webmaster@MyVietnam.net?subject=Report serious error"><fmt:message key="mvncms.common.error.website_admin"/></a>
<fmt:message key="mvncms.common.error.by_providing_detailed_steps_to_reproduce_this_error_thankyou"/></div>

</body>
</html>
<%!
    private static final Logger log = LoggerFactory.getLogger("com.mvnsoft.mvncms.portlet.fatalerror.jsp");
%>
</fmt:bundle>
