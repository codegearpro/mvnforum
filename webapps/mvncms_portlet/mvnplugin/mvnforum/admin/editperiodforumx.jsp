<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/editperiodforumx.jsp,v 1.25 2009/11/18 08:12:08 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.25 $
  - $Date: 2009/11/18 08:12:08 $
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
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page errorPage="fatalerror.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.mvnforum.db.*" %>
<%@ page import="com.mvnforum.enterprise.db.*" %>
<%@ page import="net.myvietnam.mvncore.util.ParamUtil" %>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter"%>
<%@ page import="java.sql.*" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
<mvn:title><fmt:message key="mvnforum.common.forum.title_name" /> - <fmt:message key="mvnforum.admin.editperiodforumx.title"/></mvn:title>
<!-- todo: add language -->
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/js/md5.js"></script>
</mvn:head>
<mvn:body onunload="document.submitform.Submit.disabled=false;">
<%@ include file="header.jsp"%>
<%
int periodid = ((Integer) request.getAttribute("PeriodID")).intValue();
VotePeriodBean voteperiodbean = (VotePeriodBean) request.getAttribute("VotePeriodBean");
Map periodForumMap = (TreeMap) request.getAttribute("PeriodForumMap");
Collection forumBeans = (Collection) request.getAttribute("ForumBeans");
%>
<script type="text/javascript">
//<![CDATA[
function checkEnter(event) {   
  var agt=navigator.userAgent.toLowerCase();
  
  // Maybe, Opera make an onClick event when user press enter key 
  // on the text field of the form
  if (agt.indexOf('opera') >= 0) return;

  // enter key is pressed
  if (getKeyCode(event) == 13)
    SubmitForm();
}
function SubmitForm() {
  if (ValidateForm()) {
    var enableEncrypted = <%=MVNForumConfig.getEnableEncryptPasswordOnBrowser()%>;
    if (enableEncrypted) {
      pw2md5(document.submitform.MemberCurrentMatkhau, document.submitform.md5pw);
    }
    <mvn:servlet>
      document.submitform.Submit.disabled=true;
    </mvn:servlet>
    document.submitform.submit();
  }
}
function ValidateForm() {
  <%
  for (Iterator iterator = forumBeans.iterator(); iterator.hasNext(); ) {
      ForumBean forumBean = (ForumBean) iterator.next();
      if (periodForumMap.containsKey(new Integer(forumBean.getForumID())) == false) {
  %>
        if (!isUnsignedInteger(document.getElementById('Forum_<%=forumBean.getForumID()%>'), "<%=forumBean.getForumName()%>")) return false;
    <%}%>
  <%}%>
  <%
  for (Iterator iterator = forumBeans.iterator(); iterator.hasNext(); ) {
      ForumBean forumBean = (ForumBean) iterator.next();
      if (periodForumMap.containsKey(new Integer(forumBean.getForumID()))) {
  %>
        if (!isUnsignedInteger(document.getElementById('Forum_<%=forumBean.getForumID()%>'), "<%=forumBean.getForumName()%>")) return false;
    <%}%>
  <%}%>
  if (isBlank(document.submitform.MemberCurrentMatkhau, "<fmt:message key="mvnforum.common.prompt.current_password"/>")) {
    return false;
  }
  if (document.submitform.MemberCurrentMatkhau.value.length < 3) {
    alert("<fmt:message key="mvnforum.common.js.prompt.invalidlongpassword"/>");
    document.submitform.MemberCurrentMatkhau.focus();
    return false;
  }
  return true;
}
//]]>
</script>

<br />
<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isServlet) {%>
  <a href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "listperiod")%>"><fmt:message key="mvnforum.admin.listperiodx.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.admin.editperiodforumx.title"/>
</div>
<br />

<form action="<%=urlResolver.encodeURL(request, response, "editperiodforumprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform" onsubmit="return false;">
<%=urlResolver.generateFormAction(request, response, "editperiodforumprocess")%>
<mvn:securitytoken />
<input type="hidden" name="md5pw" value="" />
<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.editperiodforumx.title" /></td>
  </tr>
  <tr class="portlet-section-body">
    <td width="40%"><fmt:message key="mvnforum.common.vote_period.name" /></td>
    <td><input type="hidden" name="periodid" value="<%=periodid %>" /> <%=voteperiodbean.getVotePeriodName()%></td>
  </tr>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.editperiodforumx.default_forum_level" /></td>
  </tr>
<mvn:cssrows>
<%
boolean isExistDefault = false;
for (Iterator iterator = forumBeans.iterator(); iterator.hasNext(); ) {
    ForumBean forumBean = (ForumBean) iterator.next();
    if (periodForumMap.containsKey(new Integer(forumBean.getForumID())) == false) {
        isExistDefault = true;
%>
  <tr>
    <td>
      <label for="Forum_<%=forumBean.getForumID()%>"><%=forumBean.getForumName()%></label>
    </td>
    <td><input type="text" id="Forum_<%=forumBean.getForumID()%>" name="<%=forumBean.getForumID()%>" size="3" value="<%=voteperiodbean.getPeriodForumLevel()%>" /></td>
  </tr>
   <%}%>
<%}%>
<%if (isExistDefault == false) {%>
  <tr class="portlet-section-body">
    <td colspan="2" align="center"><fmt:message key="mvnforum.admin.editperiodforumx.no_forum" /></td>
  </tr>
<%}%>
</mvn:cssrows>
  <tr class="portlet-section-header">
    <td><fmt:message key="mvnforum.admin.editperiodforumx.modified_forum_level" /></td>
    <td></td>
  </tr>
<mvn:cssrows>
<%
boolean isExistModified = false;
for (Iterator iterator = forumBeans.iterator(); iterator.hasNext(); ) {
    ForumBean forumBean = (ForumBean) iterator.next();
    if (periodForumMap.containsKey(new Integer(forumBean.getForumID()))) {
        int level = ((Integer) periodForumMap.get(new Integer(forumBean.getForumID()))).intValue();
        isExistModified = true;
%>
  <tr>
    <td>
      <label for="Forum_<%=forumBean.getForumID()%>"><%=forumBean.getForumName()%></label>
    </td>
    <td><input type="text" id="Forum_<%=forumBean.getForumID()%>" name="<%=forumBean.getForumID()%>" size="3" value="<%=level%>" /></td>
  </tr>
<%}//end if
}%>
<%if (isExistModified == false) {%>
  <tr class="portlet-section-body">
    <td colspan="2" align="center"><fmt:message key="mvnforum.admin.editperiodforumx.no_forum" /></td>
  </tr>
<%}%>
  <tr class="<mvn:cssrow/>">
    <td width="30%"><label for="MemberCurrentMatkhau"><fmt:message key="mvnforum.common.prompt.current_password"/><span class="requiredfield"> *</span></label></td>
    <td><input type="password" id="MemberCurrentMatkhau" name="MemberCurrentMatkhau" onkeypress="checkEnter(event);" /></td>
  </tr>
  <tr class="portlet-section-footer">
    <td colspan="4" align="center">
      <input type="button" name="Submit" value="<fmt:message key="mvnforum.common.action.update" />" class="portlet-form-button" onclick="javascript:SubmitForm();" />
      <input value="<fmt:message key="mvnforum.common.action.reset" />" class="liteoption" type="reset" />
    </td>
  </tr>
</mvn:cssrows>
</table>
</form>
<br />

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>