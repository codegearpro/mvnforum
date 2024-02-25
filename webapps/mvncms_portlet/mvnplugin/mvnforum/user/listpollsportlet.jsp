<%--
  - $Header: /home/cvsroot/portlet-mvnforum/srcweb/mvnplugin/mvnforum/user/listpollsportlet.jsp,v 1.12 2010/08/20 05:16:09 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.12 $
  - $Date: 2010/08/20 05:16:09 $
  -
  - ====================================================================
  -
  - Copyright (C) 2002-2010 by MyVietnam.net
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

<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/js/myvietnam.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="<%=contextPath%>/mvnplugin/mvnforum/css/style.css" />
<link rel="stylesheet" type="text/css" media="all" href="<%=contextPath%>/mvnplugin/mvncms/cds/portlet/default/css/style.css" />
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<script type="text/javascript">
//<![CDATA[
function ViewResultForm(url) {
    window.location.href=url;
}
//]]>
</script>
<%
Collection pollBeans = (Collection)request.getAttribute("PollBeans");
int numOfPoll = ((Integer)request.getAttribute("NumOfPoll")).intValue();
Map threadMap = (HashMap) request.getAttribute("ThreadMap");
Map albumItemMap = (HashMap) request.getAttribute("AlbumItemMap");
Map votesMap = (HashMap) request.getAttribute("VotesMap");
Map canDeletePollMap = (HashMap) request.getAttribute("CanDeletePollMap");
Map canEditPollMap = (HashMap) request.getAttribute("CanEditPollMap");
int memberPostsPerPage = onlineUser.getPostsPerPage();
PollBean poll = (PollBean) request.getAttribute("PollBean");
%>

<pg:pager
  url="listpollsportlet"
  items="<%=numOfPoll%>"
  maxPageItems="<%=memberPostsPerPage%>"
  isOffset="true"
  export="offset,currentPageNumber=pageNumber"
  scope="request">
<% String rowsType = MVNForumResourceBundle.getString(onlineUser.getLocale(), "mvnforum.common.numberof.polls"); %>

<table width="240" class="left_box" cellspacing="0" cellpadding="3" align="center">
  <tr>
    <td><div class="title_poll"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/poll_icon.gif" alt="" class="icon_box" />Ý kiến bạn đọc</div></td>
  </tr>
<mvn:cssrows>
  <%
  if (pollBeans.size() != 0) {
    for (Iterator pollIter = pollBeans.iterator(); pollIter.hasNext(); ) {
       PollBean pollBean = (PollBean)pollIter.next();
  %>
    <pg:item>
      <tr valign="top">
        <td>
          <div class="margin_polllist">
            <ul class="icon">
              <li><a href="<%=urlResolver.encodeURL(request, response, "viewpollresult?pollid=" + pollBean.getPollID())%>"><%= pollBean.getPollQuestion() %></a></li>
            </ul>
          </div>
        </td>
      </tr>
    </pg:item>
    <%
    }//end for
  } else {%>
    <tr><td colspan="9" align="center"><fmt:message key="mvnforum.user.listpollsx.no_poll"/></td></tr>
<%}%>
    <tr>
      <td>
        <%@ include file="inc_pager_portlet.jsp"%>
      </td>
    </tr>
    <tr align="right">
      <td style="padding:0 10px 10px 0">
        <a href="<%=urlResolver.encodeURL(request, response, "viewpollresult?pollid=" + poll.getPollID())%>" class="next_link"><fmt:message key="mvnforum.admin.success.return"/></a>
      </td>
    </tr>
    <%if (permission.isAuthenticated()) {%>
    <tr align="right">
      <td style="padding:0 10px 10px 0">
        <a href="<%=urlResolver.encodeURL(request, response, "listpolls", URLResolverService.ACTION_URL)%>" class="next_link"><fmt:message key="mvnforum.common.poll.command.manage"/></a>
     </td>
    </tr>
    <%} %>
</mvn:cssrows>
</table>
</pg:pager>

</fmt:bundle>