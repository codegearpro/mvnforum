<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/myprivateforumsx.jsp,v 1.25 2009/07/16 03:28:22 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.25 $
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
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="java.util.*"%>
<%@ page import="com.mvnforum.LocaleMessageUtil"%>
<%@ page import="com.mvnforum.db.*"%>
<%@ page import="com.mvnforum.common.*"%>
<%@ page import="com.mvnforum.auth.OnlineUserAction"%>
<%@ page import="com.mvnforum.common.ForumIconLegend"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.myprivateforumsx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<br/>
<%ForumIconLegend forumIconLegend = new ForumIconLegend(); %>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <a href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "myprofile")%>"><fmt:message key="mvnforum.user.myprofile.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.myprivateforumsx.title"/>
</div>
<br/>

<div class="pagedesc">
  <fmt:message key="mvnforum.user.myprivateforumsx.info"/><br/>
  <a class="command" href="<%=urlResolver.encodeURL(request, response, "requestforum")%>"><fmt:message key="mvnforum.user.requestforumx.title"/></a>
</div>
<br/>

<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.common.forum.name_desc"/></td>
    <td align="center"><fmt:message key="mvnforum.common.forum.create_date"/></td>
    <td align="center"><fmt:message key="mvnforum.common.forum.moderation_mode"/></td>
    <td align="center"><fmt:message key="mvnforum.common.permission.member_permission"/></td>
    <td align="center"><fmt:message key="mvnforum.common.action.edit"/></td>
    <td align="center"><fmt:message key="mvnforum.common.action.delete"/></td>
  </tr>
<%
  Collection privateForums = (Collection)request.getAttribute("PrivateForums");
  for (Iterator iter = privateForums.iterator(); iter.hasNext(); ) {
    ForumBean forum = (ForumBean)iter.next();
    String forumIcon = MyUtil.getForumIconName(onlineUser.getLastLogonTimestamp().getTime(), forum.getForumLastPostDate().getTime(), forum.getForumStatus(), forum.getForumThreadCount());
    forumIconLegend.updateIconLegend(forumIcon);
%>
  <tr class="<mvn:cssrow/>">
    <td width="1%" align="center" nowrap="nowrap"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/<%=forumIcon%>" border="0" alt="" /></td>
    <td width="30%">
      <b <%if (forum.getForumStatus() == ForumBean.FORUM_STATUS_DISABLED) { %> class="disabledItem" <%}%> > <%=forum.getForumName()%></b><br/>
      <%=MyUtil.filter(forum.getForumDesc(), false/*html*/, true/*emotion*/, true/*mvnCode*/, true/*newLine*/, true/*URL*/)%>
    </td>
    <td align="center"><%=onlineUser.getGMTTimestampFormat(forum.getForumCreationDate())%></td>
    <td align="center"><%=LocaleMessageUtil.getForumModeDescFromInt(onlineUser.getLocale(), forum.getForumModerationMode())%></td>
    <td align="center">
  <%if ( permission.canAssignToForum(forum.getForumID()) ) {%>
      <a href="<%=urlResolver.encodeURL(request, response, "assignmembertoforum?forum=" + forum.getForumID())%>"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/user.gif" border="0" alt="Edit Member Permissions for forum : <%=forum.getForumName()%>" /></a>
  <%}%>
    </td>
    <td align="center">
  <%if ( permission.canEditForum(forum.getForumID()) ) {%>
      <a href="<%=urlResolver.encodeURL(request, response, "editforum?forum=" + forum.getForumID())%>"><img src="<%=imagePath%>/button_edit.gif" border="0" alt="Edit forum: <%=forum.getForumName()%>" /></a>
  <%}%>
    </td>
    <td align="center">
  <%if ( permission.canDeleteForum(forum.getForumID()) ) {%>
      <a class="command" href="<%=urlResolver.encodeURL(request, response, "deleteforum?forum=" + forum.getForumID())%>"><fmt:message key="mvnforum.common.action.delete"/></a>
  <%}%>
    </td>
  </tr>
<%} //for private forums %>
<%if (privateForums.size() == 0) {%>
  <tr class="<mvn:cssrow/>">
    <td colspan="11" align="center"><fmt:message key="mvnforum.user.myprivateforumsx.no_private_forums"/></td>
  </tr>
<%}%>
</mvn:cssrows>
</table>

<%if (forumIconLegend.isHasIconLegend()) {%>
<table width="95%" class="noborder" align="center">
  <% if (forumIconLegend.isHasReadActiveForum()) {%>
  <tr class="portlet-font">
    <td width="16"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/<%=ForumIconLegend.FORUM_ICON_READ_ACTIVE %>" border="0" alt="" /></td>
    <td><fmt:message key="mvnforum.common.legend.forum.read_active"/></td>
  </tr>
  <%}%>
  <% if (forumIconLegend.isHasReadClosedForum()) {%>
  <tr class="portlet-font">
    <td width="16"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/<%=ForumIconLegend.FORUM_ICON_READ_CLOSED %>" border="0" alt="" /></td>
    <td><fmt:message key="mvnforum.common.legend.forum.read_closed"/></td>
  </tr>
  <%}%>
  <% if (forumIconLegend.isHasReadLockedForum()) {%>
  <tr class="portlet-font">
    <td width="16"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/<%=ForumIconLegend.FORUM_ICON_READ_LOCKED %>" border="0" alt="" /></td>
    <td><fmt:message key="mvnforum.common.legend.forum.read_locked"/></td>
  </tr>
  <%}%>
  <% if (forumIconLegend.isHasReadDisabledForum()) { %>
  <tr class="portlet-font">
    <td width="16"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/<%=ForumIconLegend.FORUM_ICON_READ_DISABLED %>" border="0" alt="" /></td>
    <td><fmt:message key="mvnforum.common.legend.forum.read_disabled"/></td>
  </tr>
  <%}%>
  <% if (forumIconLegend.isHasUnreadActiveForum()) {%>
  <tr class="portlet-font">
    <td width="16"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/<%=ForumIconLegend.FORUM_ICON_UNREAD_ACTIVE %>" border="0" alt="" /></td>
    <td><fmt:message key="mvnforum.common.legend.forum.unread_active"/></td>
  </tr>
  <%}%>
  <% if (forumIconLegend.isHasUnreadClosedForum()) {%>
  <tr class="portlet-font">
    <td width="16"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/<%=ForumIconLegend.FORUM_ICON_UNREAD_CLOSED %>" border="0" alt="" /></td>
    <td><fmt:message key="mvnforum.common.legend.forum.unread_closed"/></td>
  </tr>
  <%}%>
  <% if (forumIconLegend.isHasUnreadLockedForum()) { %>
  <tr class="portlet-font">
    <td width="16"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/<%=ForumIconLegend.FORUM_ICON_UNREAD_LOCKED %>" border="0" alt="" /></td>
    <td><fmt:message key="mvnforum.common.legend.forum.unread_locked"/></td>
  </tr>
  <%}%>
  <% if (forumIconLegend.isHasUnreadDisabledForum()) { %>
  <tr class="portlet-font">
    <td width="16"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/<%=ForumIconLegend.FORUM_ICON_UNREAD_DISABLED %>" border="0" alt="" /></td>
    <td><fmt:message key="mvnforum.common.legend.forum.unread_disabled"/></td>
  </tr>
  <%}%>
</table>
<%}%>
<br/>

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>