<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/listglobalperiodx.jsp,v 1.6 2009/05/05 10:32:30 trungth Exp $
  - $Author: trungth $
  - $Revision: 1.6 $
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
<%
VotePeriodBean votePeriodBean = (VotePeriodBean) request.getAttribute("VotePeriodBean");
%>

<div class="pagedesc">
  <fmt:message key="mvnforum.admin.listperiodx.global.info"/><br />
  <a href="<%=urlResolver.encodeURL(request, response, "editglobalperiod?period="+votePeriodBean.getVotePeriodID(), URLResolverService.RENDER_URL)%>" class="command"><fmt:message key="mvnforum.admin.editglobalperiodx.title" /></a><br />
  <a href="<%=urlResolver.encodeURL(request, response, "editperiodgroup?period="+votePeriodBean.getVotePeriodID(), URLResolverService.RENDER_URL)%>" class="command"><fmt:message key="mvnforum.admin.editperiodgroupx.title" /></a><br />
  <a href="<%=urlResolver.encodeURL(request, response, "editperiodforum?period="+votePeriodBean.getVotePeriodID(), URLResolverService.RENDER_URL)%>" class="command"><fmt:message key="mvnforum.admin.editperiodforumx.title" /></a>
</div>
<br />

<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.listperiodx.global.global_info"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="30%"><fmt:message key="mvnforum.common.vote_period.name"/></td>
    <td><%=votePeriodBean.getVotePeriodName()%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.vote_period.desc"/></td>
    <td><%=votePeriodBean.getVotePeriodDesc()%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.vote_period.status"/></td>
    <td>
    <%if (votePeriodBean.getVotePeriodStatus() == VotePeriodBean.PERIOD_STATUS_ACTIVE) {%>
      <font color="green"><fmt:message key="mvnforum.common.vote_period.status.active" /></font>
    <%} else {%>
      <font color="red"><fmt:message key="mvnforum.common.vote_period.status.inactive" /></font>
    <%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.vote_period.option"/></td>
    <td>
      <%if (votePeriodBean.getVotePeriodOption() == VotePeriodBean.PERIOD_OPTION_BOTH_THREAD_POST) {%>
        <fmt:message key="mvnforum.common.vote_period.option.both_thread_post" />
      <%} else if (votePeriodBean.getVotePeriodOption() == VotePeriodBean.PERIOD_OPTION_THREAD_ONLY) {%>
        <fmt:message key="mvnforum.common.vote_period.option.thread_only" />
      <%} else if (votePeriodBean.getVotePeriodOption() == VotePeriodBean.PERIOD_OPTION_POST_ONLY) {%>
        <fmt:message key="mvnforum.common.vote_period.option.post_only" />
      <%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.vote_period.min_value"/></td>
    <td><%=votePeriodBean.getVotePeriodMinValue()%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.vote_period.max_value"/></td>
    <td><%=votePeriodBean.getVotePeriodMaxValue()%></td>
  </tr>
</mvn:cssrows>
</table>
