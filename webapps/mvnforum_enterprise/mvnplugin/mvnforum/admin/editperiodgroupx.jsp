<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/editperiodgroupx.jsp,v 1.27 2009/09/15 03:18:00 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.27 $
  - $Date: 2009/09/15 03:18:00 $
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

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="net.myvietnam.mvncore.util.ParamUtil" %>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter"%>
<%@ page import="com.mvnforum.db.*" %>
<%@ page import="com.mvnforum.enterprise.db.*" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
<mvn:title><fmt:message key="mvnforum.common.forum.title_name" /> - <fmt:message key="mvnforum.admin.editperiodgroupx.title" /></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body onunload="document.submitform.Submit.disabled=false;">
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/js/md5.js"></script>
<%@ include file="header.jsp"%>
<%
int periodid = ((Integer) request.getAttribute("PeriodID")).intValue();
VotePeriodBean voteperiodbean = (VotePeriodBean) request.getAttribute("VotePeriodBean");
Map periodGroupMap = (TreeMap) request.getAttribute("PeriodGroupMap");
Collection groupBeans = (Collection) request.getAttribute("GroupBeans");
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
  for (Iterator iterator = groupBeans.iterator(); iterator.hasNext(); ) {
      GroupsBean groupBean = (GroupsBean)iterator.next();
      if (periodGroupMap.containsKey(new Integer(groupBean.getGroupID())) == false) {
  %>
      if (!isUnsignedInteger(document.getElementById('Group_<%=groupBean.getGroupID()%>'), "<%=groupBean.getGroupName()%>")) return false;
    <%}%>
  <%}%>
  <%
  for (Iterator iterator = groupBeans.iterator(); iterator.hasNext(); ) {
      GroupsBean groupBean = (GroupsBean)iterator.next();
      if (periodGroupMap.containsKey(new Integer(groupBean.getGroupID()))) {
  %>
      if (!isUnsignedInteger(document.getElementById('Group_<%=groupBean.getGroupID()%>'), "<%=groupBean.getGroupName()%>")) return false;
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
  <a href="<%=urlResolver.encodeURL(request, response, "listperiod")%>"><fmt:message key="mvnforum.admin.listperiodx.title" /></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.admin.editperiodgroupx.title" />
</div>
<br />

<form action="<%=urlResolver.encodeURL(request, response, "editperiodgroupprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform" onsubmit="return false;">
<%=urlResolver.generateFormAction(request, response, "editperiodgroupprocess")%>
<mvn:securitytoken />
<input type="hidden" name="md5pw" value="" />
<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.editperiodgroupx.title" /></td>
  </tr>
  <tr class="portlet-section-body">
    <td width="40%"><fmt:message key="mvnforum.common.vote_period.name" /></td>
    <td><input type="hidden" name="periodid" value="<%=periodid %>" /> <%=voteperiodbean.getVotePeriodName()%></td>
  </tr>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.editperiodgroupx.default_group_level" /></td>
  </tr>
<mvn:cssrows>
<%
boolean isExistDefault = false;
for (Iterator iterator = groupBeans.iterator(); iterator.hasNext(); ) {
    GroupsBean groupBean = (GroupsBean)iterator.next();
    if (periodGroupMap.containsKey(new Integer(groupBean.getGroupID())) == false) {
        isExistDefault = true;
%>
  <tr>
    <td>
      <label for="Group_<%=groupBean.getGroupID()%>"><%=groupBean.getGroupName()%></label>
    </td>
    <td><input type="text" id="Group_<%=groupBean.getGroupID() %>" name="<%=groupBean.getGroupID()%>" size="3" value="<%=voteperiodbean.getPeriodGroupLevel()%>" /></td>
  </tr>
   <%}%>
<%}%>
<%if (isExistDefault == false) {%>
  <tr class="portlet-section-body">
    <td colspan="2" align="center"><fmt:message key="mvnforum.admin.editperiodgroupx.no_group" /></td>
  </tr>
<%}%>
</mvn:cssrows>
  <tr class="portlet-section-header">
    <td><fmt:message key="mvnforum.admin.editperiodgroupx.modified_group_level" /></td>
    <td></td>
  </tr>
<mvn:cssrows>
<%
boolean isExistModified = false;
for (Iterator iterator = groupBeans.iterator(); iterator.hasNext(); ) {
    GroupsBean groupBean = (GroupsBean)iterator.next();
    if (periodGroupMap.containsKey(new Integer(groupBean.getGroupID()))) {
        int level = ((Integer) periodGroupMap.get(new Integer(groupBean.getGroupID()))).intValue();
        isExistModified = true;
%>
  <tr>
    <td>
      <label for="Group_<%=groupBean.getGroupID()%>"><%=groupBean.getGroupName()%></label>
    </td>
    <td><input type="text" id="Group_<%=groupBean.getGroupID() %>" name="<%=groupBean.getGroupID() %>" size="3" value="<%=level%>" /></td>
  </tr>
<%}//end if
}%>
<%if (isExistModified == false) {%>
  <tr class="portlet-section-body">
    <td colspan="2" align="center"><fmt:message key="mvnforum.admin.editperiodgroupx.no_group" /></td>
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