<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/viewpolldetailx.jsp,v 1.20 2009/10/22 06:49:25 trungth Exp $
  - $Author: trungth $
  - $Revision: 1.20 $
  - $Date: 2009/10/22 06:49:25 $
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
<%@ page import="com.mvnforum.db.*"%>
<%@ page import="com.mvnforum.LocaleMessageUtil"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
<mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.viewpolldetailx.title"/></mvn:title>

<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>

<mvn:body>

<%if (isPollPortlet == false) {%>
  <%@ include file="header.jsp"%>
 
  <br/>
  
  <div class="nav center">
    <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
    <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
    <a href="<%=urlResolver.encodeURL(request, response, "listpolls")%>"><fmt:message key="mvnforum.user.listpollsx.title"/></a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.user.viewpolldetailx.title"/>
  </div>
<%} else {%>
  <%@ include file="header_poll.jsp"%>
<br/>
  
  <div class="nav center">
    <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
    <a href="<%=urlResolver.encodeURL(request, response, "", URLResolverService.ACTION_URL)%>"><fmt:message key="mvnforum.user.header.index"/></a>&nbsp;&raquo;&nbsp;
    <a href="<%=urlResolver.encodeURL(request, response, "listpolls")%>"><fmt:message key="mvnforum.user.listpollsx.title"/></a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.user.viewpolldetailx.title"/>
  </div>
<%} %> 
<br />
<%
PollBean pollBean = (PollBean)request.getAttribute("PollBean");
Collection pollAnswerBeans = (Collection)request.getAttribute("PollAnswerBeans");
Map map = (Map) request.getAttribute("Votes");
%>

<mvn:cssrows>
<table class="tborder" width="95%" cellspacing="0" cellpadding="5" align="center">
  <tbody>
  <tr class="portlet-section-header">
    <td align="left" colspan="2">
      <a onclick= "showhide('pollinfo');return false;" href="javascript:void(0)"><img border="0" height="13" width="14" src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/arrow-subnav-down.gif" alt="" /></a> <fmt:message key="mvnforum.user.viewpolldetailx.title"/>
    </td>
  </tr>
  </tbody>
  <tbody id="pollinfo">
  <tr class="<mvn:cssrow/>">
    <td align="center" width="20%"><fmt:message key="mvnforum.common.poll.poll_id"/></td>
    <td><%=pollBean.getPollID()%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td align="center"><fmt:message key="mvnforum.common.poll.poll_question"/></td>
    <td><%=pollBean.getPollQuestion()%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td align="center"><fmt:message key="mvnforum.common.poll.status"/></td>
    <td><%= LocaleMessageUtil.getPollStatusDescFromInt(onlineUser.getLocale(), pollBean.getPollStatus()) %></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td align="center"><fmt:message key="mvnforum.user.addpollx.multi_without_explanation"/></td>
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/<%=(pollBean.getPollMultiple() == PollBean.POLL_MULTIPLE_YES) ? "yes" : "no"%>.gif" alt=""/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td align="center"><fmt:message key="mvnforum.user.addpollx.change_vote_without_explanation"/></td>
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/<%=(pollBean.getPollVoteChange() == PollBean.POLL_VOTE_CHANGE) ? "yes" : "no"%>.gif" alt=""/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td align="center"><fmt:message key="mvnforum.user.addpollx.is_anonymous_without_explanation"/></td>
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/<%=(pollBean.getPollType() == PollBean.POLL_TYPE_ANONYMOUS) ? "yes" : "no"%>.gif" alt=""/></td>
  </tr>
  </tbody>
</table>
</mvn:cssrows>
<br />

<mvn:cssrows>
<table class="tborder" width="95%" cellspacing="0" cellpadding="5" align="center">
  <tbody>
  <tr class="portlet-section-header">
    <td colspan="4">
      <a onclick= "showhide('pollanswerinfo');return false;" href="javascript:void(0)"><img border="0" height="13" width="14" src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/arrow-subnav-down.gif" alt="" /></a> <fmt:message key="mvnforum.user.viewpollanswerdetailx.poll_answer_info"/>
    </td>
  </tr>
  </tbody>
  <tbody id="pollanswerinfo">
  <tr class="portlet-section-subheader">
    <td align="center" width="20%"><fmt:message key="mvnforum.common.pollanswer.id"/></td>
    <td align="center"><fmt:message key="mvnforum.common.pollanswer.answer"/></td>
    <td align="center" width="20%"><fmt:message key="mvnforum.common.pollanswer.type"/></td>
    <td align="center" width="10%"><fmt:message key="mvnforum.common.pollanswer.numberof.votes"/></td>
  </tr>
  <%
  for (Iterator iter = pollAnswerBeans.iterator(); iter.hasNext(); ) {
    PollAnswerBean pollAnswerBean = (PollAnswerBean)iter.next();
    int votes = ((Integer)map.get(new Integer(pollAnswerBean.getPollAnswerID()))).intValue();
  %>
    <tr class="<mvn:cssrow/>">
      <td align="center"><%=pollAnswerBean.getPollAnswerID() %></td>
      <td><%=pollAnswerBean.getPollAnswerText()%></td>
      <td align="center"><%=LocaleMessageUtil.getPollAnswerTypeDescFromInt(onlineUser.getLocale(), pollAnswerBean.getPollAnswerType())%></td>
      <td align="center">
        <%if ((votes > 0) && permission.canAdminSystem() ) {%>
          <a class="command" href="<%=urlResolver.encodeURL(request, response, "viewpollanswerdetail?pollanswer=" + pollAnswerBean.getPollAnswerID())%>"><b><%=votes%></b> <fmt:message key="mvnforum.common.pollanswer.votes"/></a>
        <%} else {%>
          <b><%=votes%></b> <fmt:message key="mvnforum.common.pollanswer.votes"/>
        <%}%>
      </td>
    </tr>
  <%
  }
  if (pollAnswerBeans.size() == 0) {%>
    <tr class="<mvn:cssrow/>"><td colspan="4" align="center"><fmt:message key="mvnforum.user.viewpolldetailx.no_pollanswer"/></td></tr>
<%}%>
  </tbody>
</table>
</mvn:cssrows>

<br />
<%if (isPollPortlet == false) {%>
  <%@ include file="footer.jsp"%>
<%} %>
</mvn:body>
</mvn:html>
</fmt:bundle>