<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/listnormalperiodx.jsp,v 1.5 2009/05/05 10:32:30 trungth Exp $
  - $Author: trungth $
  - $Revision: 1.5 $
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
<%@ page import="java.sql.Timestamp"%>

<%@page import="net.myvietnam.mvncore.util.DateUtil"%>

<div class="pagedesc">
  <fmt:message key="mvnforum.admin.listperiodx.normal.info"/><br />
  <a href="<%=urlResolver.encodeURL(request, response, "addvoteperiod")%>" class="command"><fmt:message key="mvnforum.admin.addvoteperiodx.title"/></a><br/>
</div>
<br />

<%
 Collection periodBeans = (Collection) request.getAttribute("VotePeriodBeans");
%>
<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
  <tr class="portlet-section-header" align="center">
    <td><fmt:message key="mvnforum.common.vote_period.name"/></td>
    <td><fmt:message key="mvnforum.common.vote_period.status"/></td>
    <td><fmt:message key="mvnforum.common.vote_period.option"/></td>
    <td><fmt:message key="mvnforum.common.vote_period.start_date"/></td>
    <td><fmt:message key="mvnforum.common.vote_period.end_date"/></td>
    <td><fmt:message key="mvnforum.common.vote_period.group_level"/></td>
    <td><fmt:message key="mvnforum.common.vote_period.forum_level"/></td>
    <td colspan="2"></td>
  </tr>
<mvn:cssrows>
<%
Timestamp now = DateUtil.getCurrentGMTTimestamp();
for (Iterator iterator = periodBeans.iterator(); iterator.hasNext(); ) {
    VotePeriodBean votePeriodBean = (VotePeriodBean) iterator.next();
%>
  <tr class="<mvn:cssrow/>">
    <td>
      <b><%=votePeriodBean.getVotePeriodName()%></b><br />
      <%=votePeriodBean.getVotePeriodDesc()%>
    </td>
    <td align="center">
    <%if (votePeriodBean.getVotePeriodEndDate().before(now)) {%>
      <fmt:message key="mvnforum.common.status.expired" />
    <%} else {%>
      <%if (votePeriodBean.getVotePeriodStatus() == VotePeriodBean.PERIOD_STATUS_ACTIVE) {%>
        <font color="green"><fmt:message key="mvnforum.common.vote_period.status.active" /></font>
      <%} else {%>
        <font color="red"><fmt:message key="mvnforum.common.vote_period.status.inactive" /></font>
      <%}%>
    <%}%>
    </td>
    <td align="center">
      <%if (votePeriodBean.getVotePeriodOption() == VotePeriodBean.PERIOD_OPTION_BOTH_THREAD_POST) {%>
        <fmt:message key="mvnforum.common.vote_period.option.both_thread_post" />
      <%} else if (votePeriodBean.getVotePeriodOption() == VotePeriodBean.PERIOD_OPTION_THREAD_ONLY) {%>
        <fmt:message key="mvnforum.common.vote_period.option.thread_only" />
      <%} else if (votePeriodBean.getVotePeriodOption() == VotePeriodBean.PERIOD_OPTION_POST_ONLY) {%>
        <fmt:message key="mvnforum.common.vote_period.option.post_only" />
      <%}%>
    </td>
    <td align="center"><%=onlineUser.getGMTDateFormat(votePeriodBean.getVotePeriodStartDate())%></td>
    <td align="center"><%=onlineUser.getGMTDateFormat(votePeriodBean.getVotePeriodEndDate())%></td>
    <td align="center"><a href="<%=urlResolver.encodeURL(request, response, "editperiodgroup?period="+votePeriodBean.getVotePeriodID(), URLResolverService.RENDER_URL)%>" class="command"><fmt:message key="mvnforum.common.action.edit" /></a></td>
    <td align="center"><a href="<%=urlResolver.encodeURL(request, response, "editperiodforum?period="+votePeriodBean.getVotePeriodID(), URLResolverService.RENDER_URL)%>" class="command"><fmt:message key="mvnforum.common.action.edit" /></a></td>
    <td align="center"><a href="<%=urlResolver.encodeURL(request, response, "editvoteperiod?period="+votePeriodBean.getVotePeriodID(), URLResolverService.RENDER_URL)%>" class="command"><fmt:message key="mvnforum.common.action.edit" /></a></td>
    <td align="center"><a href="<%=urlResolver.encodeURL(request, response, "deletevoteperiod?period="+votePeriodBean.getVotePeriodID(), URLResolverService.RENDER_URL)%>" class="command"><fmt:message key="mvnforum.common.action.delete" /></a></td>
  </tr>
<%}//end for loop
if (periodBeans.size() == 0) {%>
  <tr class="<mvn:cssrow/>" align="center">
    <td colspan="9"><fmt:message key="mvnforum.admin.listperiodx.no_period" /></td>
  </tr>
<%}%>
</mvn:cssrows>
</table>
