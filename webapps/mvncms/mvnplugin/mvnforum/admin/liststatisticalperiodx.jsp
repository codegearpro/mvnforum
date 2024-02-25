<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/liststatisticalperiodx.jsp,v 1.3 2009/05/05 10:32:30 trungth Exp $
  - $Author: trungth $
  - $Revision: 1.3 $
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

<div class="pagedesc">
  <fmt:message key="mvnforum.admin.listperiodx.statistical.info"/><br />
  <a href="<%=urlResolver.encodeURL(request, response, "addstatisticalperiod")%>" class="command"><fmt:message key="mvnforum.admin.addstatisticalperiodx.title"/></a><br/>
</div>
<br />

<%
 Collection periodBeans = (Collection) request.getAttribute("VotePeriodBeans");
%>
<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
  <tr class="portlet-section-header" align="center">
    <td><fmt:message key="mvnforum.common.vote_period.name"/></td>
    <td><fmt:message key="mvnforum.common.vote_period.start_date"/></td>
    <td><fmt:message key="mvnforum.common.vote_period.end_date"/></td>
    <td colspan="2"></td>
  </tr>
<mvn:cssrows>
<%
for (Iterator iterator = periodBeans.iterator(); iterator.hasNext(); ) {
    VotePeriodBean votePeriodBean = (VotePeriodBean) iterator.next();
%>
  <tr class="<mvn:cssrow/>">
    <td>
      <b><%=votePeriodBean.getVotePeriodName()%></b><br />
      <%=votePeriodBean.getVotePeriodDesc()%>
    </td>
    <td align="center">
      <%=onlineUser.getGMTDateFormat(votePeriodBean.getVotePeriodStartDate())%>
    </td>
    <td align="center">
      <%=onlineUser.getGMTDateFormat(votePeriodBean.getVotePeriodEndDate())%>
    </td>
    <td align="center"><a href="<%=urlResolver.encodeURL(request, response, "editstatisticalperiod?period="+votePeriodBean.getVotePeriodID(), URLResolverService.RENDER_URL)%>" class="command"><fmt:message key="mvnforum.common.action.edit" /></a></td>
    <td align="center"><a href="<%=urlResolver.encodeURL(request, response, "deletestatisticalperiod?period="+votePeriodBean.getVotePeriodID(), URLResolverService.RENDER_URL)%>" class="command"><fmt:message key="mvnforum.common.action.delete" /></a></td>
  </tr>
<%}//end for loop
if (periodBeans.size() == 0) {%>
  <tr class="<mvn:cssrow/>" align="center">
    <td colspan="5"><fmt:message key="mvnforum.admin.listperiodx.no_period" /></td>
  </tr>
<%}%>
</mvn:cssrows>
</table>
