<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/processchatx.jsp,v 1.19 2009/07/16 03:28:22 xuantl Exp $
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
<%-- not localized yet --%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page errorPage="fatalerror.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Collection"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="org.jivesoftware.smack.XMPPConnection"%>
<%@ page import="org.jivesoftware.smack.Roster"%>
<%@ page import="org.jivesoftware.smack.RosterEntry"%>
<%@ page import="org.jivesoftware.smack.RosterGroup"%>
<%@ page import="org.jivesoftware.smack.packet.Presence"%>
<%@ page import="org.jivesoftware.smack.XMPPConnection"%>
<%@ page import="com.mvnforum.user.MemberWebHandler"%>
<%@ page import="com.mvnforum.auth.OnlineUser"%>
<%@ page import="com.mvnforum.auth.OnlineUser"%>
<%@ page import="com.mvnforum.auth.OnlineUserManager"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - MVN Instant Message</mvn:title>
  <style type="text/css"> body { margin: 50px; } </style>
  <script type="text/javascript">
  //<![CDATA[
    var djConfig = { isDebug: true };
  //]]>
  </script>
<!-- <script type="text/javascript" src="../../dojo.js"></script> -->
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<br/>
<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  MVN Instant Message
</div>
<br/>

<script type="text/javascript">
//<![CDATA[
  function Buddies() {
  <%

    XMPPConnection con = (XMPPConnection)onlineUserManager.getOnlineUser(request).getXMPPConnection();
    Roster roster = con.getRoster();
    Iterator rosterEntries = roster.getEntries();

        while(rosterEntries.hasNext()) {
            RosterEntry entry = (RosterEntry)rosterEntries.next();
            Presence presence = roster.getPresence(entry.getUser());
            if (presence != null) {
                Presence.Mode mode = presence.getMode();
                %>
                  document.getElementById('content').innerHTML = entry.getUser() + ": " + mode;
                <%
                System.out.println(entry.getName() + ": " + mode);
            } else {
                %>
                  document.getElementById('content').innerHTML = entry.getUser() + ": OFFLINE";
                <%
                System.out.println(entry.getName() + ": OFFLINE");
            }
        }
  %>
  }

  window.onload = function() {
    Buddies();
  }
//]]>
</script>

<div resizable="true" caption="Buddy List" id="buddylistwin" align="center">

  <table width="100%" height="100%" align="center" cellpadding="0" cellspacing="0" class="noborder">
    <tr>
      <td>
        <table width="278" class="noborder" cellspacing="0" cellpadding="0">
          <tr>
            <td width="6" height="31"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/chat/navleft.gif" width="6" height="31" alt="" />
            </td>
            <td background="<%=contextPath%>/mvnplugin/mvnforum/images/chat/bgnav.gif">
              <table width="100%" class="noborder" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="5%" align="left">
                    <a href="<%=urlResolver.encodeURL(request, response, "pre_add_buddy")%>"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/chat/addBuddy.gif" alt="Add Buddy" title="Add Buddy" width="25" height="25" hspace="1" /></a>
                    <a href="<%=urlResolver.encodeURL(request, response, "pre_remove_buddy")%>"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/chat/removeBuddy.gif" alt="Remove Buddy" title="Remove Buddy" width="25" height="25" hspace="1" /></a>
                       <!--  <a href="<%=urlResolver.encodeURL(request, response, "group_chat")%>"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/chat/groupchat.gif" alt="Join a group chat" title="Join a group chat" width="25" height="25" hspace="1" /></a> -->
                  </td>

                  <td width="31%" align="right">
                    <img src="<%=contextPath%>/mvnplugin/mvnforum/images/chat/max.gif" width="25" height="25" hspace="1" />
                    <img src="<%=contextPath%>/mvnplugin/mvnforum/images/chat/min.gif" width="25" height="25" hspace="1" />
                    <a onclick="window.document.close();"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/chat/close.gif" width="25" height="25" hspace="1" onclick="window.close()" /></a>
                  </td>
                </tr>
              </table>
            </td>
            <td width="5" height="31"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/chat/navright.gif" width="5" height="31" />
            </td>
          </tr>

          <tr>
            <td width="6" height="5"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/chat/leftb.gif" width="6" height="5" /></td>
            <td background="/mvnplugin/mvnforum/images/bga.gif"></td>
            <td width="5" height="5"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/chat/righta.gif" width="5" height="5" /></td>
         </tr>
         <div id="content">
        <tr>
              <td width="6" height="108"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/chat/leftb.gif" width="6" height="278" /></td>
              <td valign="top"></td>
              <td width="5" height="5"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/chat/rightb.gif" width="5" height="278" /></td>
          </tr>
        </div>
      <tr>
            <td width="6" height="33"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/chat/leftd.gif" width="6" height="33" /></td>
            <td background="<%=contextPath%>/mvnplugin/mvnforum/images/chat/bgd.gif" />
            <table width="100%" class="noborder" cellspacing="0" cellpadding="0">
                <tr>
                  <td align="right">
                    <a href="<%=urlResolver.encodeURL(request, response, "logout_chat")%>" onclick="return window.confirm('Do you want to sign off ?');"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/chat/logoff.gif" alt="<fmt:message key="mvnforum.common.action.logout"/>" title="<fmt:message key="mvnforum.common.action.logout"/>" width="20" height="20" /></a>

                  </td>

                </tr>
              </table>
            <td width="5" height="33"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/chat/rightd.gif" width="5" height="33" /></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>

</div>

<br/>
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>