<?xml version="1.0" encoding="UTF-8"?>
<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/WEB-INF/mvnplugin/mvnforum/mobile/listonlineusers.jsp,v 1.13 2009/07/17 04:05:39 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.13 $
  - $Date: 2009/07/17 04:05:39 $
  -
  - ====================================================================
  -
  - Copyright (C) 2002-2007 by MyVietnam.net
  -
  - MyVietnam.net PROPRIETARY/CONFIDENTIAL PROPERTIES. Use is subject to license terms.
  - You CANNOT use this software unless you receive a written permission from MyVietnam.net
  -
  - @author: Nhan Luu Duy
  -
--%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.1//EN"
  "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile11.dtd">
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page errorPage="fatalerror.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="net.myvietnam.mvncore.util.DateUtil" %>
<%@ page import="net.myvietnam.mvncore.security.Encoder" %>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter"%>
<%@ page import="net.myvietnam.mvncore.web.impl.GenericRequestServletImpl" %>
<%@ page import="com.mvnforum.auth.OnlineUserAction" %>
<%@ page import="com.mvnforum.MVNForumConstant" %>
<%@ page import="com.mvnforum.MVNForumResourceBundle" %>
<%@ include file="inc_common.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.listonlineusers.title"/></mvn:title>
  <link href="<%=contextPath%>/mvnplugin/mvnforum/css/styleMobile.css" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<div class="topmenu"><a href="index"><fmt:message key="mvnforum.mobile.main_menu" /></a></div>
<%
Collection onlineUserActions = (Collection) request.getAttribute("OnlineUserActions");
int guestCount = 0;
int memberCount = 0;
int invisibleMemberCount = 0;
boolean enableInvisible = MVNForumConfig.getEnableInvisibleUsers();
for (Iterator countIterator = onlineUserActions.iterator(); countIterator.hasNext(); ) {
    OnlineUserAction onlineUserAction = (OnlineUserAction)countIterator.next();
    boolean invisible = onlineUserAction.isInvisibleMember();
    int mID = onlineUserAction.getMemberID();
    if ( (mID==0) || (mID==MVNForumConstant.MEMBER_ID_OF_GUEST) ) {
        guestCount++;
    } else if (enableInvisible) {
        if (invisible) {
           invisibleMemberCount++;
        } else {
           memberCount++;
        }
    } else { // disable invisible feature
        memberCount++;
    }  
} // end of for%> 

<div class="padding1px">
    <fmt:message key="mvnforum.common.there_are"/> <b><%=onlineUserActions.size()%></b> <fmt:message key="mvnforum.common.online_users"/>
    <%if (enableInvisible) {%> 
    (<b><%=guestCount%></b> <%if (guestCount>1) {%><fmt:message key="mvnforum.common.guests"/><%} else {%><fmt:message key="mvnforum.common.guest"/><%}%>, 
     <b><%=memberCount%></b> <%if (memberCount>1) {%><fmt:message key="mvnforum.common.members"/><%} else {%><fmt:message key="mvnforum.common.member"/><%}%>,
     <b><%=invisibleMemberCount%></b> <%if (invisibleMemberCount>1) {%><fmt:message key="mvnforum.common.member.online.invisible_members"/><%} else {%><fmt:message key="mvnforum.common.member.online.invisible_member"/><%}%>)
   <%} else {%>
    (<b><%=guestCount%></b> <%if (guestCount>1) {%><fmt:message key="mvnforum.common.guests"/><%} else {%><fmt:message key="mvnforum.common.guest"/><%}%>, 
     <b><%=memberCount%></b> <%if (memberCount>1) {%><fmt:message key="mvnforum.common.members"/><%} else {%><fmt:message key="mvnforum.common.member"/><%}%>)
   <%}%>
</div>
<%if (onlineUserActions.size() > 0) {%>
<div id="bullet">
  <ul>
<%
Timestamp now = DateUtil.getCurrentGMTTimestamp();
GenericRequest genericRequest = new GenericRequestServletImpl(request);
//boolean enableInvisible = MVNForumConfig.getEnableInvisibleUsers();
boolean canAdmin = permission.canAdminSystem();
for (Iterator iterator = onlineUserActions.iterator(); iterator.hasNext(); ) {
    OnlineUserAction onlineUserAction = (OnlineUserAction)iterator.next();
    boolean userInvisible = onlineUserAction.isInvisibleMember();

    int mID = onlineUserAction.getMemberID();
    String mName = onlineUserAction.getMemberName();
    %>
    <li>
    <%
    if ( ( mID == 0) || (mID==MVNForumConstant.MEMBER_ID_OF_GUEST) ) {
      if ( (mName == null) || (mName.length()==0) ) {
        mName = MVNForumConfig.getDefaultGuestName();
      } %>
        <span class="user_account"><%=mName%></span>
 <% } else {
      if (enableInvisible && userInvisible && !canAdmin) { %>
        <span class="user_account"><fmt:message key="mvnforum.common.member.online.invisible_member"/></span>
    <%} else {%>
        <span class="user_account"><%=mName%></span> 
        <%if (enableInvisible && userInvisible && canAdmin) { %>(<fmt:message key="mvnforum.common.member.online.invisible"/>)<%}%>
    <%}%>
    <%if (onlineUserAction.getSessionCount() > 1) { %>
        (<%=onlineUserAction.getSessionCount()%> <fmt:message key="mvnforum.common.member.online.sessions"/>)
    <%}
    } //else %>
    <%
    String desc = onlineUserAction.getDesc(genericRequest);
    String url = onlineUserAction.getUrl();
    if (desc == null) {
      desc = MVNForumResourceBundle.getString(onlineUser.getLocale(), "mvnforum.common.member.online.unknow_action");
    }
    if (url == null) {
      out.print("(");//add ( and , here to avoid spaces in html
      out.print(desc);
      out.print(",");
    } else {
    %>
    (<a href="<%=url%>"><%=desc%></a>,
    <% } %>
      <fmt:message key="mvnforum.mobile.listonlineusers">
          <fmt:param><%=onlineUserAction.getDurationSinceLastRequestDesc(now, onlineUser.getLocale())%></fmt:param>
          <fmt:param><%=onlineUserAction.getOnlineDurarionDesc(now, onlineUser.getLocale())%></fmt:param>
      </fmt:message>)
    </li>
<% }//for %>
  </ul>
</div>
<%}//end if %>
</mvn:body>
</mvn:html>
</fmt:bundle>
