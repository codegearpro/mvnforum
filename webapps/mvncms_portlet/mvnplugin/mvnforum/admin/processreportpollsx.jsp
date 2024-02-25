<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/processreportpollsx.jsp,v 1.37 2009/07/16 03:28:23 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.37 $
  - $Date: 2009/07/16 03:28:23 $
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
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="com.mvnforum.db.*"%>
<%@ page import="com.mvnforum.LocaleMessageUtil"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.admin.processreportpollsx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css" />
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<br/>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isServlet) {%>
  <a href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "misctasks")%>"><fmt:message key="mvnforum.admin.misctasks.title"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "reportstatistics")%>"><fmt:message key="mvnforum.admin.reportstatisticsx.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.admin.processreportpollsx.title"/>
</div>
<br/>

<div class="pagedesc">
  <fmt:message key="mvnforum.admin.processreportpollsx.info"/><br />
  <fmt:message key="mvnforum.admin.reportstatisticsx.info_export"/>
</div>
<br/>

<form name="formexport" action="<%=urlResolver.encodeURL(request, response, "processexportfile", URLResolverService.ACTION_URL)%>" <mvn:method/>>
<%=urlResolver.generateFormAction(request, response, "processexportfile") %>
<mvn:securitytoken />
<input type="hidden" name="type" value="polls" />
<table width="95%" align="center">
  <tr class="nav">
    <td align="right">
      <input type="submit" value="<fmt:message key="mvnforum.common.action.export_file"/>" class="liteoption" />
    </td>
   </tr>
</table>
</form>

<%
Collection pollBeans = (Collection) request.getAttribute("PollBeans");
Map pollAnswersMap = (Map) request.getAttribute("PollAnswersMap");
Map pollVotesMap = (Map) request.getAttribute("PollVotesMap");
Map pollAnswerVotesMap = (Map) request.getAttribute("PollAnswerVotesMap");

if (pollBeans.size() == 0) {
%>
<div class="pagedesc center">
  <fmt:message key="mvnforum.admin.processreportpollsx.no_poll"/>
</div>
  <br/>
<%
} else {
  int ONE_HUNDRES_PERCENT_IN_PIXEL = 300;
  int NUMBER_COLORS = 6;

  DecimalFormat format = new DecimalFormat("##.##");

  for (Iterator pollBeanIter = pollBeans.iterator(); pollBeanIter.hasNext(); ) {
    PollBean pollBean = (PollBean) pollBeanIter.next();
    Integer pollID = new Integer(pollBean.getPollID());

    int pollVotes = ((Integer)pollVotesMap.get(pollID)).intValue();
    Collection pollAnswerBeans = (Collection) pollAnswersMap.get(pollID);
%>

<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="3"><fmt:message key="mvnforum.common.poll.show_results"/>: <%=pollBean.getPollQuestion()%></td>
  </tr>
  <%
  int i = 0;
  for (Iterator pollAnswerIter = pollAnswerBeans.iterator(); pollAnswerIter.hasNext(); i++) {
      PollAnswerBean pollAnswerBean = (PollAnswerBean) pollAnswerIter.next();
      Integer pollAnswerID = new Integer(pollAnswerBean.getPollAnswerID());
      int pollAnswerVotes = ((Integer)pollAnswerVotesMap.get(pollAnswerID)).intValue();
  %>
  <tr class="<mvn:cssrow/>">
    <td width="25%"><%=pollAnswerBean.getPollAnswerText()%></td>
    <td width="65%">
      <%if (pollVotes > 0) {%>
      <img src="<%=contextPath%>/mvnplugin/mvnforum/images/bars/bar<%=(i%NUMBER_COLORS)+1%>-l.gif" width="3" alt="*" /><img src="<%=contextPath%>/mvnplugin/mvnforum/images/bars/bar<%=(i%NUMBER_COLORS)+1%>.gif" alt="*" width="<%=(int)((float)pollAnswerVotes/pollVotes*ONE_HUNDRES_PERCENT_IN_PIXEL)%>" height="9" /><img src="<%=contextPath%>/mvnplugin/mvnforum/images/bars/bar<%=(i%NUMBER_COLORS)+1%>-r.gif" alt="*" />
      &nbsp;[<%=format.format(pollAnswerVotes*100.0/pollVotes)%>%]
      <%} else {%>
      <img src="<%=contextPath%>/mvnplugin/mvnforum/images/bars/bar<%=(i%NUMBER_COLORS)+1%>-l.gif" width="3" alt="*" /><img src="<%=contextPath%>/mvnplugin/mvnforum/images/bars/bar<%=(i%NUMBER_COLORS)+1%>-r.gif" alt="*" />
      &nbsp;[0%]
      <%}%>
    </td>
    <td width="10%"><b><%=pollAnswerVotes%></b></td>
  </tr>
  <%}%>
  <tr class="portlet-section-footer">
    <td colspan="3" align="center">
      <fmt:message key="mvnforum.common.poll.numberof.voters"/>:&nbsp;<b><%=pollVotes%></b>.&nbsp;
      <%=LocaleMessageUtil.getPollMultipleDescFromInt(onlineUser.getLocale(), pollBean.getPollMultiple())%>
    </td>
  </tr>
</mvn:cssrows>
</table>
<br />
<%}//for
}%>

<br/>
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>