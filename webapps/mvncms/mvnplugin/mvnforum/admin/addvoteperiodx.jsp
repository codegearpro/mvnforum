<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/addvoteperiodx.jsp,v 1.30 2009/07/16 03:28:23 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.30 $
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

<%@page import="com.mvnforum.enterprise.db.VotePeriodBean"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
<mvn:title><fmt:message key="mvnforum.common.forum.title_name" /> - <fmt:message key="mvnforum.admin.addvoteperiodx.title" /></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="<%=contextPath%>/mvnplugin/mvnforum/calendar/bluexp.css" />
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/calendar/zapatec.js"></script>
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/calendar/calendar.js"></script>
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/calendar/calendar-vi.js"></script>
<script type="text/javascript">
//<![CDATA[
function SubmitForm() {
  if (ValidateForm()) {
  <mvn:servlet>
    document.submitform.submitbutton.disabled=true;
  </mvn:servlet>
    document.submitform.submit();
  }
}
function ValidateForm() {
  if (isBlank(document.submitform.VotePeriodName, "<fmt:message key="mvnforum.common.vote_period.name" />")) return false;
  if (!isUnsignedInteger(document.submitform.PeriodDefaultForumLevel, "<fmt:message key="mvnforum.common.vote_period.forum_level" />")) return false;
  if (!isUnsignedInteger(document.submitform.PeriodDefaultGroupLevel, "<fmt:message key="mvnforum.common.vote_period.group_level" />")) return false;
  if (isBlank(document.submitform.VotePeriodStartDate, "<fmt:message key="mvnforum.common.vote_period.start_date" />")) return false;
  if (isBlank(document.submitform.VotePeriodEndDate, "<fmt:message key="mvnforum.common.vote_period.end_date" />")) return false;
  return true;
}
//]]>
</script>
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">
<%@ include file="header.jsp"%>
<br />

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isServlet) {%>
  <a  href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "listperiod")%>"><fmt:message key="mvnforum.admin.listperiodx.title" /></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.admin.addvoteperiodx.title" />
</div>
<br />

<div class="pagedesc">
  <fmt:message key="mvnforum.admin.addvoteperiodx.info" />
</div>
<br />

<form action="<%=urlResolver.encodeURL(request, response, "addvoteperiodprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "addvoteperiodprocess")%>
<mvn:securitytoken />
<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.addvoteperiodx.title" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="25%"><label for="voteperiodname"><fmt:message key="mvnforum.common.vote_period.name" /></label> <span class="requiredfield">*</span></td>
    <td><input id="voteperiodname" name="VotePeriodName" type="text" size="50" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td valign="top"><label for="voteperioddesc"><fmt:message key="mvnforum.common.vote_period.desc" /></label> </td>
    <td><textarea id="voteperioddesc" name="VotePeriodDesc" cols="47" rows="3"></textarea></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="perioddefaultforumlevel"><fmt:message key="mvnforum.common.vote_period.forum_level" /></label> <span class="requiredfield">*</span></td>
    <td><input id="perioddefaultforumlevel" name="PeriodDefaultForumLevel" type="text" size="50" value="<%=VotePeriodBean.PERIOD_DEFAULT_FORUM_LEVEL %>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="perioddefaultgrouplevel"><fmt:message key="mvnforum.common.vote_period.group_level" /></label> <span class="requiredfield">*</span></td>
    <td><input id="perioddefaultgrouplevel" name="PeriodDefaultGroupLevel" type="text" size="50" value="<%=VotePeriodBean.PERIOD_DEFAULT_GROUP_LEVEL %>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="voteperiodstartdate"><fmt:message key="mvnforum.common.vote_period.start_date" /> (dd/MM/yyyy)</label> <span class="requiredfield">*</span></td>
    <td> 
      <input name="VotePeriodStartDate" id="voteperiodstartdate" type="text" size="50" />
      <input type="button" name="startdate" id="startdate" value="<fmt:message key="mvnforum.common.action.select_date" />" class="portlet-form-button" /> 
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="voteperiodenddate"><fmt:message key="mvnforum.common.vote_period.end_date" /> (dd/MM/yyyy)</label> <span class="requiredfield">*</span></td>
    <td>
      <input name="VotePeriodEndDate" id="voteperiodenddate" type="text" size="50" />
      <input type="button" name="enddate" id="enddate" value="<fmt:message key="mvnforum.common.action.select_date" />" class="portlet-form-button" />
    </td>
  </tr>  
  <tr class="<mvn:cssrow/>">
    <td><label for="voteperiodstatus"><fmt:message key="mvnforum.common.vote_period.status" /></label> <span class="requiredfield">*</span></td>
    <td>
      <select id="voteperiodstatus" name="VotePeriodStatus">
        <option value="<%=VotePeriodBean.PERIOD_STATUS_ACTIVE%>"><fmt:message key="mvnforum.common.vote_period.status.active" /></option>
        <option value="<%=VotePeriodBean.PERIOD_STATUS_INACTIVE%>"><fmt:message key="mvnforum.common.vote_period.status.inactive" /></option>
      </select>    
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="voteperiodoption"><fmt:message key="mvnforum.common.vote_period.option" /></label> <span class="requiredfield">*</span></td>
    <td>
      <select id="voteperiodoption" name="VotePeriodOption">
        <option value="<%=VotePeriodBean.PERIOD_OPTION_BOTH_THREAD_POST%>"><fmt:message key="mvnforum.common.vote_period.option.both_thread_post" /></option>
        <option value="<%=VotePeriodBean.PERIOD_OPTION_THREAD_ONLY%>"><fmt:message key="mvnforum.common.vote_period.option.thread_only" /></option>
        <option value="<%=VotePeriodBean.PERIOD_OPTION_POST_ONLY%>"><fmt:message key="mvnforum.common.vote_period.option.post_only" /></option>
      </select>    
    </td>
  </tr>
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.common.action.add" />" class="portlet-form-button" onclick="javascript:SubmitForm();" />
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