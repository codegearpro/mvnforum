<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/addperiodgroupx.jsp,v 1.9 2009/09/16 04:05:03 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.9 $
  - $Date: 2009/09/16 04:05:03 $
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
<mvn:title><fmt:message key="mvnforum.common.forum.title_name" /> - Add vote Period Group</mvn:title>
<!-- todo: add language -->
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<script type="text/javascript"> 
function SubmitForm() {
  if (ValidateForm()) {
    document.submitform.Submit.disabled=true;
    document.submitform.submit();
  }
}
function ValidateForm() {
  //if (isBlank(document.submitform.CategoryName, "Category Name")) return false;
  return true;
}
</script>
<!-- Start add voteperiodgroup main content -->
<br/>
<%
int rowIndex = 1;
Collection votePeriodBeans = (Collection) request.getAttribute("voteperiodbeans");
int beanID = 0;
String beanName = null;
for (Iterator iterator = votePeriodBeans.iterator(); iterator.hasNext(); ) {
    VotePeriodBean votePeriodBean = (VotePeriodBean)iterator.next();
    if (beanID < votePeriodBean.getVotePeriodID()) {
        beanID = votePeriodBean.getVotePeriodID();
        beanName = votePeriodBean.getVotePeriodName();
    }
}%>
<form action="<%=urlResolver.encodeURL(request, response, "addperiodgroupprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "addperiodgroupprocess")%>
<mvn:securitytoken />
<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td colspan="4">Create new period </td>
  </tr>
  <tr class="trow<%=(rowIndex++) % 2%>">
    <td width="25%"><label for="periodid">Period Name</label> </td>
    <td colspan="3">
      <select id="periodid" name="periodid">
<%
for (Iterator iterator = votePeriodBeans.iterator(); iterator.hasNext(); ) {
    VotePeriodBean votePeriodBean = (VotePeriodBean)iterator.next();
%>
      <option <%if (votePeriodBean.getVotePeriodID()==beanID) {out.println("selected=\"selected\""); }  %> value="<%=votePeriodBean.getVotePeriodID() %>" ><%=votePeriodBean.getVotePeriodName() %></option>
<%
}//end for loop%>
      </select> 
    </td>
  </tr>
  <tr class="trow<%=(rowIndex++) % 2%>">
    <td>Group Level</td>
    <td colspan="3">
<%
Collection groupBeans = (Collection) request.getAttribute("GroupsBeans");
for (Iterator iterator = groupBeans.iterator(); iterator.hasNext(); ) {
    GroupsBean groupBean = (GroupsBean)iterator.next();
%>
      <lable for="<%=groupBean.getGroupID()%>level"><%=groupBean.getGroupName()%></label>
      <input type="text" value="1" id="<%=groupBean.getGroupID()%>level" name="<%=groupBean.getGroupID()%>level" size="3" />
<%}%>
    </td>
  </tr>
  <tr class="trow<%=(rowIndex++) % 2%>">
    <td colspan="4" align="center">
      <input value="Reset" class="liteoption" type="reset" />
      <input type="button" name="Submit" value="Create" class="portlet-form-button" onclick="javascript:SubmitForm();" />
    </td>
  </tr>
</table>
</form>            
<br/>
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>