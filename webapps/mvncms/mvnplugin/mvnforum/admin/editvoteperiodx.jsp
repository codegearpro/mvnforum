<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/editvoteperiodx.jsp,v 1.11 2009/08/13 10:31:09 thonh Exp $
  - $Author: thonh $
  - $Revision: 1.11 $
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
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter"%>
<%@ page import="com.mvnforum.enterprise.db.VotePeriodBean" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
<mvn:title><fmt:message key="mvnforum.common.forum.title_name" /> - <fmt:message key="mvnforum.admin.editvoteperiodx.title" /></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="<%=contextPath%>/mvnplugin/mvnforum/calendar/bluexp.css" />
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/calendar/zapatec.js"></script>
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/calendar/calendar.js"></script>
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/calendar/calendar-vi.js"></script>
</mvn:head>

<mvn:body onunload="document.submitform.Submit.disabled=false;">
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
    document.submitform.Submit.disabled=true;
  </mvn:servlet>
    document.submitform.submit();
  }
}
function ValidateForm() {
  if (isBlank(document.submitform.VotePeriodName, "<fmt:message key="mvnforum.common.vote_period.name" />")) return false;
  if (isBlank(document.submitform.VotePeriodStartDate, "<fmt:message key="mvnforum.common.vote_period.start_date" />")) return false;
  if (isBlank(document.submitform.VotePeriodEndDate, "<fmt:message key="mvnforum.common.vote_period.end_date" />")) return false;
  if (!isUnsignedInteger(document.submitform.PeriodDefaultForumLevel, "<fmt:message key="mvnforum.common.vote_period.forum_level" />")) return false;
  if (!isUnsignedInteger(document.submitform.PeriodDefaultGroupLevel, "<fmt:message key="mvnforum.common.vote_period.group_level" />")) return false;
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
<%
VotePeriodBean bean = (VotePeriodBean) request.getAttribute("VotePeriodBean");
SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
%>

<br />
<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isServlet) {%>
  <a href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title" /></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "listperiod")%>"><fmt:message key="mvnforum.admin.listperiodx.title" /></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.admin.editvoteperiodx.title" />: <%=bean.getVotePeriodName()%> 
</div>
<br />

<form action="<%=urlResolver.encodeURL(request, response, "editvoteperiodprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform" onsubmit="return false;">
<%=urlResolver.generateFormAction(request, response, "editvoteperiodprocess")%>
<mvn:securitytoken />
<input type="hidden" name="PeriodID" value="<%=bean.getVotePeriodID()%>" />
<input type="hidden" name="md5pw" value="" />
<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.editvoteperiodx.title" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="25%"><label for="voteperiodname"><fmt:message key="mvnforum.common.vote_period.name" /></label><span class="requiredfield"> *</span></td>
    <td><input id="voteperiodname" name="VotePeriodName" type="text" size="50" value="<%=DisableHtmlTagFilter.filter(bean.getVotePeriodName())%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td valign="top"><label for="voteperioddesc"><fmt:message key="mvnforum.common.vote_period.desc" /></label></td>
    <td><textarea id="voteperioddesc" name="VotePeriodDesc" cols="47" rows="3" ><%=DisableHtmlTagFilter.filter(bean.getVotePeriodDesc())%></textarea></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="perioddefaultforumlevel"><fmt:message key="mvnforum.common.vote_period.forum_level" /></label> <span class="requiredfield"> *</span></td>
    <td><input id="perioddefaultforumlevel" name="PeriodDefaultForumLevel" type="text" size="50" value="<%=bean.getPeriodForumLevel()%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="perioddefaultgrouplevel"><fmt:message key="mvnforum.common.vote_period.group_level" /></label> <span class="requiredfield"> *</span></td>
    <td><input id="perioddefaultgrouplevel" name="PeriodDefaultGroupLevel" type="text" size="50" value="<%=bean.getPeriodGroupLevel()%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="voteperiodstartdate"><fmt:message key="mvnforum.common.vote_period.start_date" /> (dd/MM/yyyy)</label> <span class="requiredfield"> *</span></td>
    <td>
      <input id="voteperiodstartdate" name="VotePeriodStartDate" type="text" size="50" value="<%=df.format(bean.getVotePeriodStartDate())%>" />
      <input type="button" name="startdate" id="startdate" value="<fmt:message key="mvnforum.common.action.select_date" />" class="portlet-form-button" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="voteperiodenddate"><fmt:message key="mvnforum.common.vote_period.end_date" /> (dd/MM/yyyy)</label> <span class="requiredfield"> *</span></td>
    <td>
      <input name="VotePeriodEndDate" id="voteperiodenddate" value="<%=df.format(bean.getVotePeriodEndDate())%>" type="text" size="50" />
      <input type="button" name="enddate" id="enddate" value="<fmt:message key="mvnforum.common.action.select_date" />" class="portlet-form-button" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="voteperiodstatus"><fmt:message key="mvnforum.common.vote_period.status" /></label></td>
    <td>
      <select id="voteperiodstatus" name="VotePeriodStatus">
        <option value="<%=VotePeriodBean.PERIOD_STATUS_ACTIVE%>"<%if (bean.getVotePeriodStatus() == VotePeriodBean.PERIOD_STATUS_ACTIVE) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.vote_period.status.active" /></option>
        <option value="<%=VotePeriodBean.PERIOD_STATUS_INACTIVE%>"<%if (bean.getVotePeriodStatus() == VotePeriodBean.PERIOD_STATUS_INACTIVE) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.vote_period.status.inactive" /></option>
      </select>    
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="voteperiodoption"><fmt:message key="mvnforum.common.vote_period.type" /></label></td>
    <td>
      <select id="voteperiodoption" name="VotePeriodOption">
        <option value="<%=VotePeriodBean.PERIOD_OPTION_BOTH_THREAD_POST%>"<%if (bean.getVotePeriodOption() == VotePeriodBean.PERIOD_OPTION_BOTH_THREAD_POST) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.vote_period.option.both_thread_post" /></option>
        <option value="<%=VotePeriodBean.PERIOD_OPTION_THREAD_ONLY%>"<%if (bean.getVotePeriodOption() == VotePeriodBean.PERIOD_OPTION_THREAD_ONLY) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.vote_period.option.thread_only" /></option>
        <option value="<%=VotePeriodBean.PERIOD_OPTION_POST_ONLY%>"<%if (bean.getVotePeriodOption() == VotePeriodBean.PERIOD_OPTION_POST_ONLY) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.vote_period.option.post_only" /></option>
      </select>    
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="30%"><label for="MemberCurrentMatkhau"><fmt:message key="mvnforum.common.prompt.current_password"/><span class="requiredfield"> *</span></label></td>
    <td><input type="password" id="MemberCurrentMatkhau" name="MemberCurrentMatkhau" onkeypress="checkEnter(event);" /></td>
  </tr>
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <input type="button" name="Submit" value="<fmt:message key="mvnforum.common.action.update" />" class="portlet-form-button" onclick="javascript:SubmitForm();" />
      <input value="<fmt:message key="mvnforum.common.action.reset" />" class="liteoption" type="reset" />
    </td>
  </tr>
</mvn:cssrows>
</table>
</form>

<script type="text/javascript">
//<![CDATA[
Zapatec.Calendar.setup({
  firstDay          : 1,
  weekNumbers       : false,
  electric          : false,
  inputField        : "voteperiodstartdate",
  button            : "startdate",
  ifFormat          : "%d/%m/%Y",
  daFormat          : "%Y/%m/%d"
});
Zapatec.Calendar.setup({
  firstDay          : 1,
  weekNumbers       : false,
  electric          : false,
  inputField        : "voteperiodenddate",
  button            : "enddate",
  ifFormat          : "%d/%m/%Y",
  daFormat          : "%Y/%m/%d"
});
//]]>
</script>

<br />
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>