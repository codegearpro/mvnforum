<%--
  - $Header: /home/cvsroot/portlet-mvnforum/srcweb/WEB-INF/mvnplugin/mvnforum/portlet/errorportlet.jsp,v 1.16 2010/08/20 05:16:10 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.16 $
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
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter" %>
<%@ page import="net.myvietnam.mvncore.util.MailUtil" %>
<%@ page import="com.mvnforum.MVNForumConfig" %>
<%@ include file="inc_common.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/js/myvietnam.js"></script>

<br/>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.error.title"/>
</div>
<br/>

<div class="pagedesc">
  <fmt:message key="mvnforum.user.error.prompt"/>:<br/>
  <b><i><span class="portlet-msg-error"><%=DisableHtmlTagFilter.filter((String)session.getAttribute("ErrorMessage"))%></span></i></b>
  <br/><br/>
  <b>&raquo;&nbsp;</b><a class="command" href="javascript:history.back(1)"><fmt:message key="mvnforum.user.error.go_back"/></a><br/>
  <b>&raquo;&nbsp;</b><fmt:message key="mvnforum.user.error.it_is_an_error"/> 
  <script type="text/javascript">
  //<![CDATA[
    var emailtitle = "<%=MailUtil.getEmailUsername(MVNForumConfig.getWebMasterEmail())%>";
    var emaildomain= "<%=MailUtil.getEmailDomain(MVNForumConfig.getWebMasterEmail())%>";
    writeEmail(emailtitle, emaildomain, "Report bug in mvnForum", "", "<fmt:message key="mvnforum.user.error.report_bug"/>", "command");
  //]]>
  </script>
</div>

<br/>
<%@ include file="footer.jsp"%>
</fmt:bundle>
