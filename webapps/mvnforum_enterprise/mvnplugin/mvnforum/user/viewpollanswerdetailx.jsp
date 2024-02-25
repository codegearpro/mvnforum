<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/viewpollanswerdetailx.jsp,v 1.8 2009/10/23 05:50:13 trungth Exp $
  - $Author: trungth $
  - $Revision: 1.8 $
  - $Date: 2009/10/23 05:50:13 $
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
<%@ page import="net.myvietnam.mvncore.security.Encoder" %>
<%@ page import="com.mvnforum.LocaleMessageUtil"%>
<%@ page import="com.mvnforum.db.*"%>
<%@ page import="com.mvnforum.MVNForumConstant"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.viewpollanswerdetailx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>

<mvn:body>

<%
PollBean pollBean = (PollBean)request.getAttribute("PollBean");
PollAnswerBean pollAnswerBean = (PollAnswerBean)request.getAttribute("PollAnswerBean");
Collection pollVoteBeans = (Collection)request.getAttribute("PollVoteBeans");
%>
<%if (isPollPortlet == false) {%>
<%@ include file="header.jsp"%>
<br/>
<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "listpolls")%>"><fmt:message key="mvnforum.user.listpollsx.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.common.poll"/>: <a href="<%=urlResolver.encodeURL(request, response, "viewpolldetail?poll=" + pollBean.getPollID())%>"><%=pollBean.getPollQuestion()%></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.viewpollanswerdetailx.title"/>
</div>
<%} else {%>
  <%@ include file="header_poll.jsp"%>
<br/>
<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <a href="<%=urlResolver.encodeURL(request, response, "", URLResolverService.ACTION_URL)%>"><fmt:message key="mvnforum.user.header.index"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "listpolls")%>"><fmt:message key="mvnforum.user.listpollsx.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.common.poll"/>: <a href="<%=urlResolver.encodeURL(request, response, "viewpolldetail?poll=" + pollBean.getPollID())%>"><%=pollBean.getPollQuestion()%></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.viewpollanswerdetailx.title"/>
</div>
<%} %>
<br />

<table class="tborder" width="95%" cellspacing="0" cellpadding="5" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td align="left" colspan="2"><fmt:message key="mvnforum.user.viewpollanswerdetailx.poll_answer_info"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td align="center" width="15%"><fmt:message key="mvnforum.common.pollanswer.id"/></td>
    <td><%=pollAnswerBean.getPollAnswerID()%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td align="center"><fmt:message key="mvnforum.common.pollanswer.answer"/></td>
    <td><%=pollAnswerBean.getPollAnswerText()%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td align="center"><fmt:message key="mvnforum.common.pollanswer.type"/></td>
    <td><%=LocaleMessageUtil.getPollAnswerTypeDescFromInt(onlineUser.getLocale(), pollAnswerBean.getPollAnswerType())%></td>
  </tr>
</mvn:cssrows>
</table>
<br />

<table class="tborder" width="95%" cellspacing="0" cellpadding="5" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td><fmt:message key="mvnforum.common.pollvote.voter_opinion"/></td>
    <td align="center"><fmt:message key="mvnforum.common.pollvote.creation_date"/></td>
    <td align="center"><fmt:message key="mvnforum.common.pollvote.voter"/></td>
    <td align="center"><fmt:message key="mvnforum.common.pollvote.ip"/></td>
  </tr>
<%for (Iterator iter = pollVoteBeans.iterator(); iter.hasNext(); ) {
    PollVoteBean pollVoteBean = (PollVoteBean)iter.next(); %>
    <tr class="<mvn:cssrow/>">
      <td align="left"><%=pollVoteBean.getPollVoteOpinion()%></td>
      <td align="center"><%=onlineUser.getGMTTimestampFormat(pollVoteBean.getPollVoteCreationDate())%></td>
      <td align="center">
      <% if ((pollBean.getPollType() == PollBean.POLL_TYPE_ANONYMOUS) && (MVNForumConstant.MEMBER_NAME_OF_GUEST.equals(pollVoteBean.getMemberName()))) { %>
        <%=MVNForumConfig.getDefaultGuestName()%>
      <% } else if (pollVoteBean.getMemberName().indexOf('.') != pollVoteBean.getMemberName().lastIndexOf('.')) { %>
        <%--  old mvnForum store IP instead of MemberName if anonymous poll and logined user vote --%> 
        <%=pollVoteBean.getMemberName()%>
      <% } else { %>
        <a href="<%=urlResolver.encodeURL(request, response, "viewmember?member=" + Encoder.encodeURL(pollVoteBean.getMemberName()))%>" class="memberName"><%=pollVoteBean.getMemberName()%></a>
      <% } %>
      </td>
      <td align="center">
      <% if (permission.canAdminSystem()) { %>
        <%=pollVoteBean.getPollVoteIP()%>
      <% } %>
      </td>
    </tr>
<%}%>
</mvn:cssrows>
</table>

<br />
<%@ include file="footer.jsp"%>

</mvn:body>
</mvn:html>
</fmt:bundle>