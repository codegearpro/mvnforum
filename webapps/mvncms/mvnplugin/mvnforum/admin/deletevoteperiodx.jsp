<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/deletevoteperiodx.jsp,v 1.6 2009/08/13 10:31:09 thonh Exp $
  - $Author: thonh $
  - $Revision: 1.6 $
  - $Date: 2009/08/13 10:31:09 $
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
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.mvnforum.enterprise.db.VotePeriodBean" %>

<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
<mvn:title><fmt:message key="mvnforum.common.forum.title_name" /> - <fmt:message key="mvnforum.admin.deletevoteperiodx.title" /></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/js/md5.js"></script>
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
      document.submitform.submitbutton.disabled=true;
    </mvn:servlet>  
    document.submitform.submit();
  }
}
function ValidateForm() {
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
<%@ include file="header.jsp"%>
<br />

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isServlet) {%>
  <a href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title" /></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "listperiod")%>"><fmt:message key="mvnforum.admin.listperiodx.title" /></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.admin.deletevoteperiodx.title" />
</div>

<br />
<%
VotePeriodBean bean = (VotePeriodBean) request.getAttribute("VotePeriodBean");
SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
%>
<form action="<%=urlResolver.encodeURL(request, response, "deletevoteperiodprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform" onsubmit="return false;">
<%=urlResolver.generateFormAction(request, response, "deletevoteperiodprocess")%>
<mvn:securitytoken />
<input type="hidden" name="period" value="<%=bean.getVotePeriodID()%>"/>
<input type="hidden" name="md5pw" value="" />
<mvn:cssrows>  
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td colspan="2">
      <fmt:message key="mvnforum.admin.deletevoteperiodx.review_before_delete" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="25%"><fmt:message key="mvnforum.common.vote_period.name" /></td>
    <td><%=bean.getVotePeriodName()%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.vote_period.desc" /></td>
    <td><%=bean.getVotePeriodDesc()%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.vote_period.forum_level" /></td>
    <td><%=bean.getPeriodForumLevel()%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.vote_period.group_level" /></td>
    <td><%=bean.getPeriodGroupLevel()%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.vote_period.start_date" /></td>
    <td><%=df.format(bean.getVotePeriodStartDate())%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.vote_period.end_date" /></td>
    <td><%=df.format(bean.getVotePeriodEndDate())%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.vote_period.min_value" /></td>
    <td><%=bean.getVotePeriodMinValue()%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.vote_period.max_value" /></td>
    <td><%=bean.getVotePeriodMaxValue()%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.vote_period.status" /></td>
    <td>
    <%if (bean.getVotePeriodStatus() == VotePeriodBean.PERIOD_STATUS_ACTIVE) {%>
        <fmt:message key="mvnforum.common.vote_period.status.active" />
    <%} else if (bean.getVotePeriodStatus() == VotePeriodBean.PERIOD_STATUS_INACTIVE) {%>
        <fmt:message key="mvnforum.common.vote_period.status.inactive" />
    <%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.vote_period.type" /></td>
    <td>
    <%if (bean.getVotePeriodOption() == VotePeriodBean.PERIOD_OPTION_NONE_THREAD_POST) {%>
      <fmt:message key="mvnforum.common.vote_period.option.none_thread_post" />
    <%} else if (bean.getVotePeriodOption() == VotePeriodBean.PERIOD_OPTION_THREAD_ONLY) {%>
      <fmt:message key="mvnforum.common.vote_period.option.thread_only" />
    <%} else if (bean.getVotePeriodOption() == VotePeriodBean.PERIOD_OPTION_POST_ONLY) {%>
      <fmt:message key="mvnforum.common.vote_period.option.post_only" />
    <%} else if (bean.getVotePeriodOption() == VotePeriodBean.PERIOD_OPTION_BOTH_THREAD_POST) {%>
      <fmt:message key="mvnforum.common.vote_period.option.both_thread_post" />
    <%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="30%"><label for="MemberCurrentMatkhau"><fmt:message key="mvnforum.common.prompt.current_password"/><span class="requiredfield"> *</span></label></td>
    <td><input type="password" id="MemberCurrentMatkhau" name="MemberCurrentMatkhau" onkeypress="checkEnter(event);" /></td>
  </tr>
  <tr class="portlet-section-footer" align="center">
    <td colspan="2" align="center">
      <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.admin.deletevoteperiodx.button.confirm_delete"/>" onclick="javascript:SubmitForm();" class="portlet-form-button" />
      <input type="reset" value="<fmt:message key="mvnforum.common.action.go_back"/>" onclick="javascript:history.back(1)" class="liteoption" />
    </td>
  </tr>
</table>
</mvn:cssrows>
</form>

<br />
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>