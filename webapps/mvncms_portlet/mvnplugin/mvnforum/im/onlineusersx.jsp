<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/im/onlineusersx.jsp,v 1.19 2009/07/16 03:28:22 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.19 $
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

<%@ page import="java.util.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="org.jivesoftware.smack.XMPPConnection" %>
<%@ page import="com.mvnforum.user.MemberWebHandler" %>
<%@ page import="com.mvnforum.auth.OnlineUser" %>
<%@ page import="com.mvnforum.enterprise.im.MyOnlineUser" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - Online Users</mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css">
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<br/>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  Online Users
</div>
<br/>

<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td><fmt:message key="mvnforum.common.user"/></td>
  </tr>
  <%
  boolean duplicateUsers = MVNForumConfig.getEnableDuplicateOnlineUsers();
  MyOnlineUser myOnlineUser = MyOnlineUser.getInstance();
  Collection list = myOnlineUser.getOnlineUserChat(0, duplicateUsers);
  for (Iterator  it = list.iterator(); it.hasNext(); ) {
        XMPPConnection con = (XMPPConnection)it.next();
       String user = con.getUser();
     if (user != null) {%>
  <tr class="<mvn:cssrow/>">
    <td>
      <%= user %>
   </td>
  </tr>
    <%} else {%>
  <tr class="<mvn:cssrow/>">
   <td colspan="8" align="center">
     <fmt:message key="mvnforum.user.listmembers.table.no_member"/>
   </td>
  </tr>
   <%} %> <!-- end else -->
  <% } %> <!-- end for -->
</mvn:cssrows>
</table>

<br/>
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>