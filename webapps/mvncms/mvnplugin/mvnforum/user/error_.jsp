<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/error_.jsp,v 1.13 2009/05/05 10:32:30 trungth Exp $
  - $Author: trungth $
  - $Revision: 1.13 $
  - $Date: 2009/05/05 10:32:30 $
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
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">

<div class="pagedesc">
  <fmt:message key="mvnforum.user.error.prompt"/>:<br/>
  <b><i><span class="portlet-msg-error"><%=DisableHtmlTagFilter.filter((String) session.getAttribute("ErrorMessage"))%></span></i></b>
  <br />
</div>
</fmt:bundle>
