<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/votepollsuccessx.jsp,v 1.40 2009/11/25 05:36:18 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.40 $
  - $Date: 2009/11/25 05:36:18 $
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

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<%
  int ONE_HUNDRES_PERCENT_IN_PIXEL = 135;
  int NUMBER_COLORS = 6;

  DecimalFormat format = new DecimalFormat("##.##");

  PollBean pollBean = (PollBean) request.getAttribute("PollBean");
  Collection pollAnswerBeans = (Collection) request.getAttribute("PollAnswerBeans");

  int totalVotes = ((Integer) request.getAttribute("TotalVotes")).intValue();
  Map resultMap = (HashMap) request.getAttribute("ResultMap");
  boolean checkVotePoll = "true".equals(request.getAttribute("VotePoll"));
%>
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.votepollsuccessx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>

<br />
<table class="bordervote" cellspacing="0" cellpadding="3" align="center" width="240">
<mvn:cssrows>
  <tr class="headervote">
    <td colspan="3" style="padding-left: 5px;"><fmt:message key="mvnforum.common.poll.show_results"/>:&nbsp;<%=pollBean.getPollQuestion()%></td>
  </tr>
  <%
  int i = 0;
  for (Iterator iterator = pollAnswerBeans.iterator(); iterator.hasNext();) {
      PollAnswerBean pollAnswerBean = (PollAnswerBean) iterator.next();
  %>
  <tr class="<mvn:cssrow/>">
    <td width="25%" style="padding-left: 5px;"><%=pollAnswerBean.getPollAnswerText()%></td>
    <td width="65%" nowrap="nowrap">
      <%if (totalVotes > 0) { %>
        <img src="<%=contextPath%>/mvnplugin/mvnforum/images/bars/bar<%=(i%NUMBER_COLORS)+1%>-l.gif" width="3" alt="*" /><img src="<%=contextPath%>/mvnplugin/mvnforum/images/bars/bar<%=(i%NUMBER_COLORS)+1%>.gif" alt="*" width="<%=(int)((float)(((Integer)resultMap.get(new Integer(pollAnswerBean.getPollAnswerID()))).intValue()) /totalVotes*ONE_HUNDRES_PERCENT_IN_PIXEL)%>" height="9" /><img src="<%=contextPath%>/mvnplugin/mvnforum/images/bars/bar<%=(i%NUMBER_COLORS)+1%>-r.gif" alt="*" />
        &nbsp;[<%=format.format((((Integer)resultMap.get(new Integer(pollAnswerBean.getPollAnswerID()))).intValue())*100.0/totalVotes)%>%]
      <%} else { %>
         <img src="<%=contextPath%>/mvnplugin/mvnforum/images/bars/bar<%=(i%NUMBER_COLORS)+1%>-l.gif" width="3" alt="*" /><img src="<%=contextPath%>/mvnplugin/mvnforum/images/bars/bar<%=(i%NUMBER_COLORS)+1%>-r.gif" alt="*" />
      <%}%>
    </td>
    <td width="10%"><b><%=((Integer)resultMap.get(new Integer(pollAnswerBean.getPollAnswerID()))).intValue()%></b></td>
  </tr>
  <%i++; %>
  <%}%>
  <tr class="footervote">
    <td colspan="3" style="padding:3px 0; text-align:center;">
      <fmt:message key="mvnforum.common.poll.numberof.voters"/>&nbsp;<b><%=totalVotes%></b>
      <%if (isPortlet) { %>
        <%if ((request.getAttribute("VoteAlbumItemPoll") != null) && 
              (request.getAttribute("AlbumItemID") != null)){ %>
          <a href="<%=urlResolver.encodeURL(request, response, "viewpublicalbumitem?itemid=" + request.getAttribute("AlbumItemID"), URLResolverService.RENDER_URL)%>"><br/> <fmt:message key="mvnforum.common.previous"/> </a>        
        <%}%>
        <%if (checkVotePoll == false) {%> 
          <div style="padding:0 10px 10px 0; text-align:right"><a href="<%=urlResolver.encodeURL(request, response, "")%>" class="next_link"><fmt:message key="mvnforum.admin.success.return"/></a></div>
        <%} else { %>
          <div style="padding:0 10px 3px 0; text-align:right"><a href="<%=urlResolver.encodeURL(request, response, "listpollsportlet")%>" class="next_link"><fmt:message key="mvnforum.common.poll.command.otherpoll"/></a></div>
        <%} %>
      <%}%>
      <div style="padding:0 10px 10px 0; text-align:right">
        <%if(permission.isAuthenticated()) {%>
          <a href="<%=urlResolver.encodeURL(request, response, "listpolls", URLResolverService.ACTION_URL)%>" class="next_link"><fmt:message key="mvnforum.common.poll.command.manage"/></a>
        <%} %>
      </div>
    </td>
  </tr>
</mvn:cssrows>
</table>

</mvn:body>
</mvn:html>
</fmt:bundle>