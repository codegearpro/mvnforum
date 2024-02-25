<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/listeventlogsx.jsp,v 1.26 2009/07/16 03:28:23 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.26 $
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
<%@ page import="net.myvietnam.enterprise.db.EventLogBean" %>
<%@ page import="net.myvietnam.mvncore.service.EventLogService"%>
<%@ page import="net.myvietnam.mvncore.service.MvnCoreServiceFactory"%>
<%@ page import="com.mvnforum.MVNForumResourceBundle" %>

<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.admin.listeventlogsx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css" />
</mvn:head>
<mvn:body>
<script type="text/javascript">
//<![CDATA[
function handleGo() {
  <mvn:servlet>
  document.form.go.disabled=true;
  </mvn:servlet>
  document.form.submit();
}
//]]>
</script>
<%@ include file="header.jsp"%>
<br/>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isServlet) {%>
  <a href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "misctasks")%>"><fmt:message key="mvnforum.admin.misctasks.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.admin.listeventlogsx.title"/>
</div>
<br/>
<%
int memberPostsPerPage = onlineUser.getPostsPerPage();
int totalEventLogs = ((Integer)request.getAttribute("TotalEventLogs")).intValue();

String sort  = ParamUtil.getParameterFilter(request, "sort");
String order = ParamUtil.getParameterFilter(request, "order");
Collection eventLogsBeans = (Collection) request.getAttribute("EventLogs");
EventLogService eventLogService = MvnCoreServiceFactory.getMvnCoreService().getEventLogService();
%>
<table width="95%" align="center">
  <tr>
    <td nowrap="nowrap" class="portlet-font">
    <form name="form" action="<%=urlResolver.encodeURL(request, response, "listeventlogs", URLResolverService.ACTION_URL)%>" <mvn:method/> >
      <%=urlResolver.generateFormAction(request, response, "listeventlogs")%>
      <label for="sort"><fmt:message key="mvnforum.common.sort_by"/></label>
      <select id="sort" name="sort">
      <option value="EventLogCreationDate" <%if (sort.equals("EventLogCreationDate")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.eventlog.creation_date"/></option>
      <option value="MemberName" <%if (sort.equals("MemberName")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.member.login_name"/></option>
      <option value="EventLogLevel" <%if (sort.equals("EventLogLevel")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.eventlog.level"/></option>
      <option value="EventLogModule" <%if (sort.equals("EventLogModule")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.eventlog.module"/></option>
      <option value="EventLogSubModule" <%if (sort.equals("EventLogSubModule")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.eventlog.submodule"/></option>
      <option value="EventLogName" <%if (sort.equals("EventLogName")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.eventlog.name"/></option>
      <option value="EventLogDesc" <%if (sort.equals("EventLogDesc")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.eventlog.desc"/></option>
      <option value="EventLogIP" <%if (sort.equals("EventLogIP")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.eventlog.from_ip"/></option>
      </select>
      <label for="order"><fmt:message key="mvnforum.common.order"/></label>
      <select id="order" name="order">
      <option value="ASC" <%if (order.equals("ASC")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.ascending"/></option>
      <option value="DESC" <%if (order.equals("DESC")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.descending"/></option>
      </select>

      <input type="button" name="go" value="<fmt:message key="mvnforum.common.go"/>" onclick="javascript:handleGo();" class="liteoption" />
    </form>
    </td>
  </tr>
</table>
<pg:pager
  url="listeventlogs"
  items="<%= totalEventLogs %>"
  maxPageItems="<%= memberPostsPerPage %>"
  isOffset="true"
  export="offset,currentPageNumber=pageNumber"
  scope="request">
  <% String rowsType = MVNForumResourceBundle.getString(onlineUser.getLocale(), "mvnforum.common.numberof.event_logs"); %>
  <pg:param name="sort"/>
  <pg:param name="order"/>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td nowrap="nowrap" align="center"><fmt:message key="mvnforum.common.eventlog.id"/></td>
    <td nowrap="nowrap" align="center"><fmt:message key="mvnforum.common.member.login_name"/></td>
    <td nowrap="nowrap" align="center"><fmt:message key="mvnforum.common.eventlog.module"/></td>
    <td nowrap="nowrap" align="center"><fmt:message key="mvnforum.common.eventlog.submodule"/></td>
    <td nowrap="nowrap" align="center"><fmt:message key="mvnforum.common.eventlog.name"/></td>
    <td nowrap="nowrap" align="center"><fmt:message key="mvnforum.common.eventlog.desc"/></td>
    <td nowrap="nowrap" align="center"><fmt:message key="mvnforum.common.eventlog.level"/></td>
    <td nowrap="nowrap" align="center"><fmt:message key="mvnforum.common.eventlog.from_ip"/></td>
    <td nowrap="nowrap" align="center"><fmt:message key="mvnforum.common.eventlog.creation_date"/></td>
  </tr>

<%
for (Iterator iterator = eventLogsBeans.iterator(); iterator.hasNext(); ) {
    EventLogBean eventLogsBean = (EventLogBean)iterator.next();
%>
<pg:item>
  <tr class="<mvn:cssrow/>">
    <td align="center"><%=eventLogsBean.getEventLogID() %></td>
    <td><%=eventLogsBean.getMemberName()%></td>
    <td nowrap="nowrap" align="center"><%=eventLogsBean.getEventLogModule()%></td>
    <td nowrap="nowrap" align="center"><%=eventLogsBean.getEventLogSubModule()%></td>
    <td><%=eventLogsBean.getEventLogName() %></td>
    <td><%=eventLogsBean.getEventLogDesc() %></td>
    <td nowrap="nowrap" align="center"><%=eventLogService.getLogLevelDesc(eventLogsBean.getEventLogLevel(), onlineUser.getLocale())%></td>
    <td nowrap="nowrap" align="center"><%=eventLogsBean.getEventLogIP()%></td>
    <td nowrap="nowrap" align="center"><%=onlineUser.getGMTTimestampFormat(eventLogsBean.getEventLogCreationDate())%></td>
  </tr>
</pg:item>
<%
}//for
if (eventLogsBeans.size() == 0) {
%>
  <tr class="<mvn:cssrow/>"><td colspan="9" align="center"><fmt:message key="mvnforum.admin.listeventlogsx.no_eventlogs"/></td></tr>
<% }//if %>
</mvn:cssrows>
</table>

<table width="95%" align="center">
  <tr>
    <td>
      <%@ include file="inc_pager.jsp"%>
    </td>
  </tr>
</table>
</pg:pager>

<br/>
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>
