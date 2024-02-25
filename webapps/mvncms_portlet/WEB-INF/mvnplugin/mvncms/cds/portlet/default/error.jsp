<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/error.jsp,v 1.5 2009/10/30 08:23:28 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.5 $
 - $Date: 2009/10/30 08:23:28 $
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
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page session="true" isErrorPage="false"%>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter" %>
<%@ include file="inc_common.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<fmt:bundle basename="i18n/mvncms/mvncms_i18n">
<html>
<head>
<title><fmt:message key="mvncms.common.cds.error"/></title>
<link href="<%=cdsTemplate%>/css/cds.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin=0 topmargin=0>

<h1 align="center"><fmt:message key="mvncms.common.cds.error"/>:</h1>
<div align="center"><font color="red"><%=DisableHtmlTagFilter.filter((String)session.getAttribute("ErrorMessage"))%></font></div>
<br/>&nbsp;
<br/>&nbsp;
<br/>&nbsp;
<br/>&nbsp;
<br/>&nbsp;

</body>
</html>
</fmt:bundle>