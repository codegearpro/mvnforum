<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/viewmemberresultx.jsp,v 1.20 2010/06/22 03:12:47 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.20 $
  - $Date: 2010/06/22 03:12:47 $
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

<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.mvnforum.MyUtil" %>
<%@ page import="com.mvnforum.db.*" %>
<%@ page import="com.mvnforum.enterprise.db.*" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name" /> - <fmt:message key="mvnforum.user.viewvoteresultx.title"/> - <fmt:message key="mvnforum.user.viewmemberresultx.title" /></mvn:title>
  <%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
  <link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">
<%@ include file="header.jsp"%>
<br />
<%
Collection votePeriodBeans = (Collection) request.getAttribute("VotePeriodBeans");
%>
<script type="text/javascript">
//<![CDATA[
function onLoadTab() {
    document.getElementById('viewtopthreads').className='off';
    document.getElementById('viewtopposts').className='off';
    document.getElementById('viewtopusers').className='off';
    document.getElementById('viewmemberresult').className='on';
}
function SubmitForm() {
  if (ValidateForm()) {
  <mvn:servlet>
    document.submitform.submitbutton.disabled=true;
  </mvn:servlet>
    document.submitform.submit();
  }
}
function ValidateForm() {
  if (isBlank(document.submitform.periodid, "<fmt:message key="mvnforum.common.vote_period.name" />")) return false;
  if (isBlank(document.submitform.membername, "<fmt:message key="mvnforum.user.viewmemberresultx.member_name" />")) return false;
  return true;
}
//]]>
</script>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isServlet) {%>
  <a href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "viewvoteresult")%>"><fmt:message key="mvnforum.user.viewvoteresultx.title" /></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.viewmemberresultx.title" />
</div>
<br />

<table width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr>
    <td>
      <div class="tab_panel">
        <ul class="tab" style="background: url(<%=contextPath%>/mvnplugin/mvnforum/images/icon/tab-line.gif) repeat-x left bottom;">
          <li><a id="viewtopthreads" href="<%=urlResolver.encodeURL(request, response, "viewtopthreads")%>" title="<fmt:message key="mvnforum.user.viewtopthreadsx.title" />"><fmt:message key="mvnforum.user.viewtopthreadsx.title" /></a></li>
          <li><a id="viewtopposts" href="<%=urlResolver.encodeURL(request, response, "viewtopposts")%>" title="<fmt:message key="mvnforum.user.viewtoppostsx.title" />"><fmt:message key="mvnforum.user.viewtoppostsx.title" /></a></li>
          <li><a id="viewtopusers" href="<%=urlResolver.encodeURL(request, response, "viewtopusers")%>" title="<fmt:message key="mvnforum.user.viewtopusersx.title" />"><fmt:message key="mvnforum.user.viewtopusersx.title" /></a></li>
          <li><a id="viewmemberresult" href="<%=urlResolver.encodeURL(request, response, "viewmemberresult")%>" title="<fmt:message key="mvnforum.user.viewmemberresultx.title" />"><fmt:message key="mvnforum.user.viewmemberresultx.title" /></a></li>
        </ul>
      </div>
    </td>
  </tr>
</table>
<br />

<form action="<%=urlResolver.encodeURL(request, response, "viewmemberresult")%>" name="submitform" onsubmit="return false;">
<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
<%=urlResolver.generateFormAction(request, response, "viewmemberresult")%>
  <tr class="portlet-section-body">
    <td>
      <label for="periodID"><fmt:message key="mvnforum.common.vote_period.name"/></label>&nbsp;
      <select id="periodID" name="periodid">
        <option value=""><fmt:message key="mvnforum.user.viewvoteresultx.choose_vote_period" /></option>
        <%
        String periodIDStr = request.getParameter("periodid");
        int periodID = 0;
        if (periodIDStr != null && periodIDStr.length() > 0) {
            try {
                periodID = new Integer(periodIDStr).intValue();
            } catch (NumberFormatException e) {
                // do nothing
            }
        }
        for (Iterator iterator = votePeriodBeans.iterator(); iterator.hasNext();) {
            VotePeriodBean periodBean = (VotePeriodBean) iterator.next();
        %>
            <option value="<%=periodBean.getVotePeriodID()%>"<%if (periodID == periodBean.getVotePeriodID()) {%> selected="selected"<%}%>><%=periodBean.getVotePeriodName() %></option>
        <%}%>   
      </select>&nbsp;
      <label for="memberName"><fmt:message key="mvnforum.user.viewmemberresultx.member_name" /></label>&nbsp;
      <%String membername = request.getParameter("membername");%>
      <input type="text" id="memberName" name="membername"<%if (membername != null) {%> value="<%=membername%>"<%}%> />&nbsp;
      <input type="submit" value="<fmt:message key="mvnforum.user.viewvoteresultx.title" />" name="submitbutton" onclick="javascript:SubmitForm();" />
    </td>
  </tr>
</table>
</form>
<br />

<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td align="center"><fmt:message key="mvnforum.common.post.topic" /></td>
    <td align="center"><fmt:message key="mvnforum.common.forum"/></td>
    <td align="center"><fmt:message key="mvnforum.common.vote_period.vote_point" /></td>
    <td align="center"><fmt:message key="mvnforum.common.vote_period.vote_count" /></td>
  </tr>
<%
Collection result = (Collection) request.getAttribute("Result");
DecimalFormat df = new DecimalFormat("#.##");
for (Iterator iterator = result.iterator(); iterator.hasNext();) {
    VotePostResultBean bean = (VotePostResultBean) iterator.next();
    int postID = bean.getPostID();
    PostBean post = PostCache.getInstance().getPost(postID);
%>
    <tr class="<mvn:cssrow/>">
      <td>
        <a href="<%=urlResolver.encodeURL(request, response, "viewthread?thread=" + bean.getThreadID() + "#" + postID)%>" ><%=MyUtil.filter(post.getPostTopic(), false/*html*/, true/*emotion*/, false/*mvnCode*/, false/*newLine*/, false/*URL*/)%></a><br />
        <%=onlineUser.getGMTTimestampFormat(post.getPostLastEditDate())%>&nbsp;
        <a href="<%=urlResolver.encodeURL(request, response, "viewthread?thread=" + bean.getThreadID())%>" class="messageTopic"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/right.gif" border="0" alt="<fmt:message key="mvnforum.user.viewthread.title"/>" title="<fmt:message key="mvnforum.user.viewthread.title"/>"/></a>
      </td>
      <td>
        <a href="<%=urlResolver.encodeURL(request, response, "listthreads?forum=" + post.getForumID())%>" class="messageTopic"><%=ForumCache.getInstance().getBean(post.getForumID()).getForumName()%></a>
      </td>
      <td align="center"><%=df.format(bean.getVotePostPoint())%></td>
      <td align="center"><%=bean.getVotePostCount()%></td>
    </tr>
<%}%>
</mvn:cssrows>
</table>
<br />

<script type="text/javascript">
//<![CDATA[
  onLoadTab();
//]]>
</script>
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>