<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/addstatisticalperiodx.jsp,v 1.10 2009/07/16 03:28:23 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.10 $
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
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="java.util.*" %>
<%@ page import="net.myvietnam.mvncore.util.ParamUtil" %>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter"%>
<%@ page import="com.mvnforum.db.*" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
<mvn:title><fmt:message key="mvnforum.common.forum.title_name" /> - <fmt:message key="mvnforum.admin.addstatisticalperiodx.title" /></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="<%=contextPath%>/mvnplugin/mvnforum/calendar/bluexp.css" />
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/calendar/zapatec.js"></script>
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/calendar/calendar.js"></script>
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/calendar/calendar-vi.js"></script>
</mvn:head>

<mvn:body onunload="document.submitform.Submit.disabled=false;">
<script type="text/javascript">
//<![CDATA[
function SubmitForm() {
  if (ValidateForm()) {
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
    <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
    <a href="<%=urlResolver.encodeURL(request, response, "listperiod")%>"><fmt:message key="mvnforum.admin.listperiodx.title"/></a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.admin.addstatisticalperiodx.title" />
</div>
<br />

<div class="pagedesc">
  <fmt:message key="mvnforum.admin.addstatisticalperiodx.info" />
</div>

<br />

<form action="<%=urlResolver.encodeURL(request, response, "addstatisticalperiodprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "addstatisticalperiodprocess")%>
<mvn:securitytoken />
<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.addstatisticalperiodx.title" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="25%"><label for="voteperiodname"><fmt:message key="mvnforum.common.vote_period.name" /></label> <span class="requiredfield">*</span></td>
    <td><input id="voteperiodname" name="VotePeriodName" type="text" size="50" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td valign="top"><label for="voteperioddesc"><fmt:message key="mvnforum.common.vote_period.desc" /></label></td>
    <td><textarea id="voteperioddesc" name="VotePeriodDesc" cols="47" rows="3"></textarea></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="voteperiodstartdate"><fmt:message key="mvnforum.common.vote_period.start_date" /> (dd/MM/yyyy)</label> <span class="requiredfield">*</span></td>
    <td>
      <input name="VotePeriodStartDate" id="voteperiodstartdate" type="text" size="50" />
      <input type="button" name="startdate" id="startdate" value="Select date" class="portlet-form-button" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="voteperiodenddate"><fmt:message key="mvnforum.common.vote_period.end_date" /> (dd/MM/yyyy)</label> <span class="requiredfield">*</span></td>
    <td>
      <input name="VotePeriodEndDate" id="voteperiodenddate" type="text" size="50" />
      <input type="button" name="enddate" id="enddate" value="Select date" class="portlet-form-button" />
    </td>
  </tr>
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <input type="button" name="Submit" value="<fmt:message key="mvnforum.common.action.add" />" class="portlet-form-button" onclick="javascript:SubmitForm();" />
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