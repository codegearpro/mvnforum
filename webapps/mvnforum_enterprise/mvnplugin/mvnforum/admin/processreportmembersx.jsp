<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/processreportmembersx.jsp,v 1.42 2009/07/16 03:28:23 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.42 $
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
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="java.util.*"%>
<%@ page import="net.myvietnam.mvncore.util.ParamUtil"%>
<%@ page import="com.mvnforum.LocaleMessageUtil"%>
<%@ page import="com.mvnforum.db.MemberBean"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.admin.processreportmembersx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css" />
</mvn:head>
<mvn:body onunload="document.form.go.disabled=false;">
<%@ include file="header.jsp"%>
<br/>
<script type="text/javascript">
//<![CDATA[
function SubmitFormGo() {
  <mvn:servlet>
    document.form.go.disabled=true;
  </mvn:servlet>  
  document.form.submit();
}
//]]>
</script>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isServlet) {%>
  <a href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "misctasks")%>"><fmt:message key="mvnforum.admin.misctasks.title"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "reportstatistics")%>"><fmt:message key="mvnforum.admin.reportstatisticsx.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.admin.processreportmembersx.title"/>
</div>
<br/>

<div class="pagedesc">
  <fmt:message key="mvnforum.admin.processreportmembersx.info"/><br />
  <fmt:message key="mvnforum.admin.reportstatisticsx.info_export"/>
</div>
<br/>

<%
String sort  = ParamUtil.getParameterFilter(request, "sort");
String order = ParamUtil.getParameterFilter(request, "order");
if (sort.length() == 0) sort = "MemberCreationDate";
if (order.length() == 0) order = "DESC";
%>
<form name="form" action="<%=urlResolver.encodeURL(request, response, "processreportmembers", URLResolverService.ACTION_URL)%>" <mvn:method/>>
<%=urlResolver.generateFormAction(request, response, "processreportmembers") %>
<table width="95%" align="center">
  <tr class="portlet-font">
    <td nowrap="nowrap">
      <label for="sort"><fmt:message key="mvnforum.common.sort_by"/></label>
      <select id="sort" name="sort">
      <option value="MemberID" <%if (sort.equals("MemberID")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.member.id"/></option>
      <option value="MemberName" <%if (sort.equals("MemberName")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.member.login_name"/></option>
      <option value="MemberFirstname" <%if (sort.equals("MemberFirstname")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.member.first_name"/></option>
      <option value="MemberLastname" <%if (sort.equals("MemberLastname")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.member.last_name"/></option>
      <option value="MemberGender" <%if (sort.equals("MemberGender")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.member.gender"/></option>
      <option value="MemberBirthday" <%if (sort.equals("MemberBirthday")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.member.birthday"/></option>
      <option value="MemberCreationDate" <%if (sort.equals("MemberCreationDate")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.member.join_date"/></option>
      <option value="MemberLastLogon" <%if (sort.equals("MemberLastLogon")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.member.last_login"/></option>
      <option value="MemberViewCount" <%if (sort.equals("MemberViewCount")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.view_count"/></option>
      <option value="MemberPostCount" <%if (sort.equals("MemberPostCount")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.member.post_count"/></option>
      <option value="MemberCountry" <%if (sort.equals("MemberCountry")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.member.country"/></option>
      <option value="MemberEmail" <%if (sort.equals("MemberEmail")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.member.email"/></option>
      </select>
      <label for="order"><fmt:message key="mvnforum.common.order"/></label>
      <select id="order" name="order">
      <option value="ASC" <%if (order.equals("ASC")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.ascending"/></option>
      <option value="DESC" <%if (order.equals("DESC")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.descending"/></option>
      </select>
      <input type="button" name="go" value="<fmt:message key="mvnforum.common.go"/>" onclick="SubmitFormGo()" class="liteoption" />
    </td>
  </tr>
</table>
</form>

<form name="formexport" action="<%=urlResolver.encodeURL(request, response, "processexportfile", URLResolverService.ACTION_URL)%>" <mvn:method/>>
<%=urlResolver.generateFormAction(request, response, "processexportfile") %>
<mvn:securitytoken />
<input type="hidden" name="sort" value="<%=sort%>" />
<input type="hidden" name="order" value="<%=order%>" />
<input type="hidden" name="type" value="members" />
<table width="95%" align="center">
   <tr class="nav">
     <td align="right">
       <input type="submit" value="<fmt:message key="mvnforum.common.action.export_file"/>" class="liteoption" />
     </td>
   </tr>
</table>
</form>

<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td><fmt:message key="mvnforum.common.member.id"/></td>
    <td><fmt:message key="mvnforum.common.member.login_name"/></td>
    <td><fmt:message key="mvnforum.common.member.first_name"/></td>
    <td><fmt:message key="mvnforum.common.member.last_name"/></td>
    <td><fmt:message key="mvnforum.common.member.first_email"/></td>
    <td><fmt:message key="mvnforum.common.member.current_email"/></td>
    <td><fmt:message key="mvnforum.common.member.first_ip"/></td>
    <td><fmt:message key="mvnforum.common.member.last_ip"/></td>
    <td><fmt:message key="mvnforum.common.member.post_count"/></td>
    <td><fmt:message key="mvnforum.common.member.join_date"/></td>
    <td><fmt:message key="mvnforum.common.member.last_profile_update"/></td>
    <%--
    <td><fmt:message key="mvnforum.common.date.expire_date"/></td>
    --%>
    <td><fmt:message key="mvnforum.common.member.last_login"/></td>
    <td><fmt:message key="mvnforum.common.member.online_status"/></td>
    <%--
    <td><fmt:message key="mvnforum.common.member.warn_count"/></td>
    <td><fmt:message key="mvnforum.common.member.vote_count"/></td>
    --%>
    <td><fmt:message key="mvnforum.common.member.language"/></td>
    <td><fmt:message key="mvnforum.common.member.country"/></td>
  </tr>

<mvn:cssrows>
<%
Collection memberBeans = (Collection) request.getAttribute("MemberBeans");
for (Iterator iterator = memberBeans.iterator(); iterator.hasNext(); ) {
    MemberBean memberBean = (MemberBean)iterator.next();
%>
  <tr class="<mvn:cssrow/>">
    <td align="center"><%=memberBean.getMemberID() %></td>
    <td><%=memberBean.getMemberName() %></td>
    <td><%=memberBean.getMemberFirstname() %></td>
    <td><%=memberBean.getMemberLastname() %></td>
    <td><%=memberBean.getMemberFirstEmail() %></td>
    <td><%=memberBean.getMemberEmail() %></td>
    <td><%=memberBean.getMemberFirstIP() %></td>
    <td><%=memberBean.getMemberLastIP() %></td>
    <td align="center"><%=memberBean.getMemberPostCount() %></td>
    <td><%=onlineUser.getGMTTimestampFormat(memberBean.getMemberCreationDate()) %></td>
    <td><%=onlineUser.getGMTTimestampFormat(memberBean.getMemberModifiedDate()) %></td>
    <%--
    <td><%=onlineUser.getGMTTimestampFormat(memberBean.getMemberExpireDate()) %></td>
    --%>
    <td><%=onlineUser.getGMTTimestampFormat(memberBean.getMemberLastLogon()) %></td>
    <td><%=LocaleMessageUtil.getMemberStatusDescFromInt(onlineUser.getLocale(), memberBean.getMemberStatus())%></td>
    <%--
    <td><%=memberBean.getMemberWarnCount() %></td>
    <td><%=memberBean.getMemberVoteCount() %></td>
    --%>
    <td align="center"><%=memberBean.getMemberLanguage() %></td>
    <td><%=memberBean.getMemberCountry() %></td>
  </tr>
<%} %>
</mvn:cssrows>
</table>

<br />
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>
