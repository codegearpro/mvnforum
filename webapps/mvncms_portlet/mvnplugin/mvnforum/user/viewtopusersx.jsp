<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/viewtopusersx.jsp,v 1.16 2010/06/22 03:12:47 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.16 $
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
<%@ page import="com.mvnforum.enterprise.db.MemberScoreBean" %>
<%@ page import="com.mvnforum.enterprise.db.VotePeriodBean" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name" /> - <fmt:message key="mvnforum.user.viewvoteresultx.title"/> - <fmt:message key="mvnforum.user.viewtopusersx.title" /></mvn:title>
  <%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
  <link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">
<%@ include file="header.jsp"%>
<br />
<%
Collection votePeriodBeans = (Collection) request.getAttribute("VotePeriodBeans");
Collection result = (Collection) request.getAttribute("Result");
%>
<script type="text/javascript">
//<![CDATA[
function onLoadTab() {
    document.getElementById('viewtopthreads').className='off';
    document.getElementById('viewtopposts').className='off';
    document.getElementById('viewtopusers').className='on';
    document.getElementById('viewmemberresult').className='off';
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
  <fmt:message key="mvnforum.user.viewtopusersx.title" />
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

<form action="<%=urlResolver.encodeURL(request, response, "viewtopusers")%>" name="submitform" onsubmit="return false;">
<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
<%=urlResolver.generateFormAction(request, response, "viewtopusers")%>
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
      <label for="numberOfMember"><fmt:message key="mvnforum.user.viewtopusersx.number_of_top_members" /></label>&nbsp;
      <select id="numberOfMember" name="numberofmember">
        <%
        String numberOfMemberStr = request.getParameter("numberofmember");
        int numberOfMember = 10;
        if (numberOfMemberStr != null && numberOfMemberStr.length() > 0) {
            try {
                numberOfMember = new Integer(numberOfMemberStr).intValue();
            } catch (NumberFormatException e) {
                // do nothing
            }
        }
        %>
        <option value="10"<%if (numberOfMember == 10) {%> selected="selected"<%}%>>10</option>
        <option value="20"<%if (numberOfMember == 20) {%> selected="selected"<%}%>>20</option>
        <option value="30"<%if (numberOfMember == 30) {%> selected="selected"<%}%>>30</option>
        <option value="50"<%if (numberOfMember == 50) {%> selected="selected"<%}%>>50</option>
        <option value="100"<%if (numberOfMember == 100) {%> selected="selected"<%}%>>100</option>
      </select>&nbsp;
      <input type="submit" value="<fmt:message key="mvnforum.user.viewvoteresultx.title" />" name="submitbutton" onclick="javascript:SubmitForm();" />
    </td>
  </tr>
</table>
</form>
<br />

<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td align="center"><fmt:message key="mvnforum.user.viewtopusersx.member_name" /></td>
    <td align="center"><fmt:message key="mvnforum.common.vote_period.vote_point" /></td>
    <td align="center"><fmt:message key="mvnforum.common.vote_period.vote_count" /></td>
  </tr>
<%
Collection memberScoreBeans = (Collection) request.getAttribute("TopUsers");
DecimalFormat df = new DecimalFormat("#.##");
for (Iterator iterator = memberScoreBeans.iterator(); iterator.hasNext(); ) {
    MemberScoreBean memberScoreBean = (MemberScoreBean) iterator.next(); 
%>
  <tr class="<mvn:cssrow/>">
    <td><a href="<%=urlResolver.encodeURL(request, response, "viewmember?member=" + memberScoreBean.getMemberName())%>" class="memberName"><%=memberScoreBean.getMemberName()%></a></td>
    <td align="center"><%=df.format(memberScoreBean.getVotePoint())%></td>
    <td align="center"><%=memberScoreBean.getVoteTimes()%></td>
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