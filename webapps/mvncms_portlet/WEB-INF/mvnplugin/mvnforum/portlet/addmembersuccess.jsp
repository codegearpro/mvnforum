<%--
  - $Header: /home/cvsroot/portlet-mvnforum/srcweb/WEB-INF/mvnplugin/mvnforum/portlet/addmembersuccess.jsp,v 1.12 2010/08/20 05:16:10 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.12 $
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

<br/>

<mvn:cssrows>
<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
  <tr class="<mvn:cssrow/>" align="center">
    <td>
      <b><fmt:message key="mvnforum.user.addmembersuccess.title"/></b><br/>
       <a class="command" href="<%=urlResolver.encodeURL(request, response, "addmember")%>"><b>Register More Member</b></a>
    </td>
  </tr>
</table>
</mvn:cssrows>

<br/>

<%@ include file="footer.jsp"%>
</fmt:bundle>
