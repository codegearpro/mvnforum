<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/im/header.jsp,v 1.28 2009/05/05 10:32:30 trungth Exp $
 - $Author: trungth $
 - $Revision: 1.28 $
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
<%@ page pageEncoding="utf-8"%>

<%@ include file="inc_js_checkvalid_myvietnamlib.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<script type="text/javascript">
function SubmitFormSearch() {
  if (ValidateFormSearch() == true) {
    // uncomment when we find a way to enable the button
    //document.submitformsearch.submitbutton.disabled = true;
    document.submitformsearch.submit();
  }
}

function ValidateFormSearch() {
  if (isBlank(document.submitformsearch.key, "<fmt:message key="mvnforum.common.action.search"/>")) return false;
  return true;
}
</script>
<table width="95%" class="noborder" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="60">
      <table width="100%" class="noborder" cellpadding="0" cellspacing="0">
        <tr>
          <td rowspan="2">
            <a href="<%=MVNForumConfig.getLogoUrl()%>"><img src="<%=onlineUser.getLogoPath()%>" height="50" border="0" alt="<fmt:message key="mvnforum.common.forum.homepage"/>" title="<fmt:message key="mvnforum.common.forum.homepage"/>"></a>
          </td>
          <td rowspan="2">
            <!-- Put your banner here if you want -->
          </td>
          <td width="100%" height="25" align="right" valign="top" nowrap="nowrap" class="portlet-font"">
            <span class="welcomeHeader"><fmt:message key="mvnforum.user.header.welcome"/></span>
            <%if (onlineUser.isMember()) {%>
              <font color="#FF0000"><%=memberName%></font>
              <%int newMessageCount = onlineUser.getNewMessageCount();
                if (newMessageCount > 0) { %>
                (<a href="<%=urlResolver.encodeURL(request, response, "mymessage")%>"><%=onlineUser.getNewMessageCount()%> <fmt:message key="mvnforum.common.message.header.new_private_message"/></a>)
              <%}%>
              <% if (onlineUser.getAuthenticationType() == OnlineUser.AUTHENTICATION_TYPE_COOKIE) { %>(<fmt:message key="mvnforum.user.header.we_remember_you"/>)<% } %>
              <%if (MVNForumConfig.getEnableLogin()) {%>
              &nbsp;|&nbsp;<a class="command" href="<%=urlResolver.encodeURL(request, response, "logout")%>"><fmt:message key="mvnforum.common.action.logout"/></a>
              <%}%>
              <br/>
              <% if (MVNForumConfig.getEnableShowLastLogin()) {%>
                <fmt:message key="mvnforum.common.member.last_login"/>:&nbsp;<%=onlineUser.getGMTTimestampFormat(onlineUser.getLastLogonTimestamp())%>
                <fmt:message key="mvnforum.common.from_ip"/>&nbsp;<%=onlineUser.getLastLogonIP()%>
              <%}%>
            <%} else if ((memberName!=null) && (memberName.length()>0)) {%>
               <%=memberName%>
              <%if (MVNForumConfig.getEnableLogin()) {%>
              &nbsp;&nbsp;|&nbsp;<a class="command" href="<%=urlResolver.encodeURL(request, response, "login")%>" class="portlet-section-header"><fmt:message key="mvnforum.common.action.login"/></a>
              <% } %>
            <%} else {%>
               <%=MVNForumConfig.getDefaultGuestName()%>
              <%if (MVNForumConfig.getEnableLogin()) {%>
              &nbsp;&nbsp;|&nbsp;<a class="command" href="<%=urlResolver.encodeURL(request, response, "login")%>" class="portlet-section-header"><fmt:message key="mvnforum.common.action.login"/></a>
              <% } %>
            <%}%>
          </td>
        </tr>
        <tr>
          <td height="35" valign="top">
          <% if (environmentService.isPortlet()) { %>
            <form action="<%=urlResolver.encodeURL(request, response, "search")%>" name="submitformsearch" method="post">
          <% } else { %>  
            <form action="<%=urlResolver.encodeURL(request, response, "search")%>" name="submitformsearch">
          <% } %>
          <%=urlResolver.generateFormAction(request, response, "search")%>
            <table class="tborder" cellspacing="0" cellpadding="2" align="right">
              <tr class="topmenu">
                <td align="left" valign="top" nowrap="nowrap">&nbsp;
                  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/search.gif" alt="<fmt:message key="mvnforum.common.action.search"/>" title="<fmt:message key="mvnforum.common.action.search"/>" hspace="0" vspace="0" border="0" align="bottom">
                  <input type="text" size="10" name="key">
                  <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.common.action.search"/>" onclick="javascript:SubmitFormSearch();" class="portlet-form-button">&nbsp;
                </td>
              </tr>
            </table>
          </form>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<div class="topmenu">
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>" class="topmenu"><fmt:message key="mvnforum.user.header.index"/></a>
  <%--
  <a href="<%=urlResolver.encodeURL(request, response, "listforums")%>" class="topmenu"><fmt:message key="mvnforum.user.header.all_forums"/></a>&nbsp;|&nbsp;
  --%>
  &nbsp;|&nbsp;<a href="<%=urlResolver.encodeURL(request, response, "listrecentthreads")%>" class="topmenu"><fmt:message key="mvnforum.user.header.recent_threads"/></a>
  <%if (MVNForumConfig.getEnableListUnansweredThreads()) {%>
  &nbsp;|&nbsp;<a href="<%=urlResolver.encodeURL(request, response, "listunansweredthreads")%>" class="topmenu"><fmt:message key="mvnforum.user.header.listunansweredthreads"/></a>
  <% } %>
  <%if (MVNForumConfig.getEnableOnlineUsers()) {%>
  &nbsp;|&nbsp;<a href="<%=urlResolver.encodeURL(request, response, "listonlineusers")%>" class="topmenu"><fmt:message key="mvnforum.user.header.who_online"/></a>
  <% } // if enable online users%>
  <%if (MVNForumConfig.getEnableListMembers()) {%>
  &nbsp;|&nbsp;<a href="<%=urlResolver.encodeURL(request, response, "listmembers")%>" class="topmenu"><fmt:message key="mvnforum.user.header.user_list"/></a>
  <% } %>
  <%if (MVNForumConfig.getEnableNewMember() && onlineUser.isGuest()) {%>
  &nbsp;|&nbsp;<a href="<%=urlResolver.encodeURL(request, response, "registermember")%>" class="topmenu"><fmt:message key="mvnforum.user.header.new_user"/></a>
  <% } %>
  <%if (onlineUser.isMember()) {%>
  &nbsp;|&nbsp;<a href="<%=urlResolver.encodeURL(request, response, "myprofile")%>" class="topmenu"><fmt:message key="mvnforum.user.header.my_profile"/></a>
  <% } %>
  <%if (MVNForumConfig.getEnableSearch()) {%>
  &nbsp;|&nbsp;<a href="<%=urlResolver.encodeURL(request, response, "search")%>" class="topmenu"><fmt:message key="mvnforum.common.action.search"/></a>
  <%}%>
  &nbsp;|&nbsp;<a href="<%=urlResolver.encodeURL(request, response, "help")%>" class="topmenu"><fmt:message key="mvnforum.user.header.help"/></a>
  <%if (MVNForumConfig.getEnableRSS()) {%>
  &nbsp;|&nbsp;<a href="<%=urlResolver.encodeURL(request, response, "rsssummary")%>" class="topmenu"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/xml.gif" alt="<fmt:message key="mvnforum.user.rss.title"/>" title="<fmt:message key="mvnforum.user.rss.title"/>" hspace="0" vspace="0" border="0" align="bottom"></a>
  <% } %>
  <%if (permission.canModerateThreadInAtLeastOneForum()) {%>
  &nbsp;|&nbsp;<a href="<%=urlResolver.encodeURL(request, response, "modcp")%>" class="topmenu"><fmt:message key="mvnforum.user.header.moderation"/></a>
  <% } %>
  
  <% if (MVNForumConfig.getEnableChat()) {%>
    &nbsp;|&nbsp;<a class="topmenu" href="#" onclick="window.open ('<%=urlResolver.encodeURL(request, response, "pre_lobbymessages")%>', 'alllobbychat','location=1,status=1,scrollbars=1, width=400,height=400 resizable=yes');">Lobby Messages</a>
      <% if (onlineUser.isMember()) { %>
      &nbsp;|&nbsp;<a href="<%=urlResolver.encodeURL(request, response, "messenger")%>" class="topmenu">Messenger</a>
      <% } %>
  <% } %>
</div>

<%if (MVNForumConfig.getShouldShowUserArea() == false) {%>
<br/>
<div class="pagedesc center warning">
  <fmt:message key="mvnforum.user.header.turn_off"/>
</div>

<%}%>
</fmt:bundle>
<%@ include file="ad.jsp"%>
<%@ include file="news.jsp"%>
