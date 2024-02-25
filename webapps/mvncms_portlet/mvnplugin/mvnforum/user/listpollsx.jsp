<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/listpollsx.jsp,v 1.51 2009/12/01 04:39:34 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.51 $
  - $Date: 2009/12/01 04:39:34 $
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

<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.util.*"%>
<%@ page import="net.myvietnam.mvncore.util.DateUtil"%>
<%@ page import="com.mvnforum.db.*"%>
<%@ page import="com.mvnforum.LocaleMessageUtil"%>
<%@ page import="com.mvnforum.MVNForumResourceBundle"%>
<%@ page import="com.mvnforum.enterprise.MVNForumEnterpriseConfig"%>

<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<%
Collection pollBeans = (Collection)request.getAttribute("PollBeans");
int numOfPoll = ((Integer)request.getAttribute("NumOfPoll")).intValue();
Map threadMap = (HashMap) request.getAttribute("ThreadMap");
Map albumItemMap = (HashMap) request.getAttribute("AlbumItemMap");
Map votesMap = (HashMap) request.getAttribute("VotesMap");
Map canDeletePollMap = (HashMap) request.getAttribute("CanDeletePollMap");
Map canEditPollMap = (HashMap) request.getAttribute("CanEditPollMap");
int memberPostsPerPage = onlineUser.getPostsPerPage();
%>

<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.listpollsx.title"/></mvn:title>
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
    <fmt:message key="mvnforum.user.listpollsx.title"/>
  </div>
<%} else {%>
  <%@ include file="header_poll.jsp"%>
<br/>
  <div class="nav center">
    <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
    <a href="<%=urlResolver.encodeURL(request, response, "", URLResolverService.ACTION_URL)%>"><fmt:message key="mvnforum.user.header.index"/></a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.user.listpollsx.title"/>
  </div>
<script type="text/JavaScript">
//<![CDATA[
function onSetPollDefault(url) {
  var msg = "<fmt:message key="mvnforum.user.listpollsx.confirm_set_to_default_poll"/>";
  var agree = confirm(msg);
  if (agree) {
    document.location.href=url;
  } else {
    document.location.href='#';
  }
}
//]]>
</script>
<%} %>
<br/>

<%if (permission.canManageOrphanPoll()) { %>
<div class="pagedesc" <%if (isPollPortlet) {%>style="margin: 0pt auto; width: 100%;"<%} %>>
  <a href="<%=urlResolver.encodeURL(request, response, "addorphanpoll")%>" class="command"><fmt:message key="mvnforum.common.poll.command.add_orphan_poll"/></a>
</div>
<br/>
<%} %>

<pg:pager
  url="listpolls"
  items="<%=numOfPoll%>"
  maxPageItems="<%=memberPostsPerPage%>"
  isOffset="true"
  export="offset,currentPageNumber=pageNumber"
  scope="request">
<% String rowsType = MVNForumResourceBundle.getString(onlineUser.getLocale(), "mvnforum.common.numberof.polls"); %>

<table <%if (isPollPortlet == false) {%>width="95%" <%} else { %>style="margin: 0pt auto; width: 100%;"<%} %> align="center">
  <tr>
    <td>
      <%@ include file="inc_pager.jsp"%>
    </td>
  </tr>
</table>

<table class="tborder" <%if (isPollPortlet == false) {%>width="95%" <%} else { %>style="margin: 0pt auto; width: 100%;"<%} %> cellspacing="0" cellpadding="5" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td align="center"><fmt:message key="mvnforum.common.poll.poll_id"/></td>
    <td align="center"><fmt:message key="mvnforum.common.poll.poll_question"/></td>
    <td align="center"><fmt:message key="mvnforum.common.status.expired"/></td>
    <td align="center"><fmt:message key="mvnforum.common.poll.status"/></td>
    <td align="center"><fmt:message key="mvnforum.common.thread"/></td>
    <td align="center"><fmt:message key="mvnforum.common.pollanswer.numberof.votes"/></td>
    <td align="center"><fmt:message key="mvnforum.user.viewpolldetailx.title"/></td>
    <td align="center"><fmt:message key="mvnforum.common.action.edit"/></td>
    <td align="center"><fmt:message key="mvnforum.common.action.delete"/></td>
  </tr>
  <%
  if (pollBeans.size() != 0) {
    for (Iterator pollIter = pollBeans.iterator(); pollIter.hasNext(); ) {
       PollBean pollBean = (PollBean)pollIter.next();
       int pollID = pollBean.getPollID();
       ThreadBean threadBean = (ThreadBean)threadMap.get(new Integer(pollID));
  %>
    <pg:item>
      <tr class="<mvn:cssrow/>" valign="top">
        <td align="center"><%= pollBean.getPollID() %></td>
        <td>
        <%if (threadBean != null) {%>
          <a href="<%=urlResolver.encodeURL(request, response, "viewthread?thread=" + threadBean.getThreadID())%>" class="messageTopic"><%= pollBean.getPollQuestion() %></a>
        <%} else {%>
          <%= pollBean.getPollQuestion() %>
          <%if (isPollPortlet) {%>
            <br />
            <%if (pollID == MVNForumEnterpriseConfig.getDefaultPollID()) {%>
              (<fmt:message key="mvnforum.user.listpollsx.is_default_poll"/>)
            <%} else {%>
              <a href="javascript:onSetPollDefault('<%=urlResolver.encodeURL(request, response, "setpolldefaultprocess?pollid=" + pollBean.getPollID(), URLResolverService.ACTION_URL)%>');"><fmt:message key="mvnforum.user.listpollsx.set_to_default_poll"/></a>
            <%}%>
          <%}%>
        <%}%>
        </td>
        <td align="center">
        <%
        Timestamp now = DateUtil.getCurrentGMTTimestamp();
        Timestamp endDate = pollBean.getPollEndDate();
        Timestamp startDate = pollBean.getPollStartDate();
        boolean hasExpired = false;
        if ((endDate.compareTo(startDate) > 0) && (endDate.compareTo(now) <= 0)) {
          hasExpired = true;
        }        
        %>
        <%if (hasExpired) {%><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/yes.gif" alt=""/><%}%>
        </td>
        <td align="center"><%= LocaleMessageUtil.getPollStatusDescFromInt(onlineUser.getLocale(), pollBean.getPollStatus()) %></td>
        <td align="center">
        <%if (threadBean != null) {%>
          <%= threadBean.getThreadID() %>
        <%}%>
        </td>
        <td align="center">
          <%= votesMap.get(new Integer(pollID)) %>
        </td>
        <td align="center">
          <a class="command" href="<%=urlResolver.encodeURL(request, response, "viewpolldetail?poll=" + pollBean.getPollID())%>"><fmt:message key="mvnforum.user.viewpolldetailx.title"/></a>
        </td>
        <td align="center">
        <%
          boolean canEditPoll = ((Boolean)canEditPollMap.get(new Integer(pollID))).booleanValue();
          if (canEditPoll) {
            if (threadMap.get(new Integer(pollID)) != null) { %>  
              <a class="command" href="<%=urlResolver.encodeURL(request, response, "editthreadpoll?poll=" + pollBean.getPollID())%>"><fmt:message key="mvnforum.common.action.edit"/></a>
          <%} else if (albumItemMap.get(new Integer(pollID)) != null) {%>             
              <a class="command" href="<%=urlResolver.encodeURL(request, response, "editalbumitempoll?poll=" + pollBean.getPollID())%>"><fmt:message key="mvnforum.common.action.edit"/></a>
          <%} else {%>
              <a class="command" href="<%=urlResolver.encodeURL(request, response, "editorphanpoll?poll=" + pollBean.getPollID())%>"><fmt:message key="mvnforum.common.action.edit"/></a>
          <%} 
          }%>
        </td>
        <td align="center">
        <%
          boolean canDeletePoll = ((Boolean)canDeletePollMap.get(new Integer(pollID))).booleanValue();
          if (canDeletePoll && (pollID != MVNForumEnterpriseConfig.getDefaultPollID())) {
            if (threadMap.get(new Integer(pollID)) != null) { %>  
            <a class="command" href="<%=urlResolver.encodeURL(request, response, "deletethreadpoll?poll=" + pollBean.getPollID())%>"><fmt:message key="mvnforum.common.action.delete"/></a>
          <%} else if (albumItemMap.get(new Integer(pollID)) != null) {%>             
            <a class="command" href="<%=urlResolver.encodeURL(request, response, "deletealbumitempoll?poll=" + pollBean.getPollID())%>"><fmt:message key="mvnforum.common.action.delete"/></a>
          <%} else {%>
            <a class="command" href="<%=urlResolver.encodeURL(request, response, "deleteorphanpoll?poll=" + pollBean.getPollID())%>"><fmt:message key="mvnforum.common.action.delete"/></a>
          <%}
          }%>        
        </td>
      </tr>
      </pg:item>
    <%
    }//end for
  } else {%>
    <tr class="<mvn:cssrow/>"><td colspan="9" align="center"><fmt:message key="mvnforum.user.listpollsx.no_poll"/></td></tr>
<%}%>
</mvn:cssrows>
</table>
</pg:pager>

<br/>
<%if (isPollPortlet == false) {%>
  <%@ include file="footer.jsp"%>
<%} %>

</mvn:body>
</mvn:html>
</fmt:bundle>