<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/processreportimpressionsx.jsp,v 1.38 2009/07/16 03:28:23 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.38 $
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
<%@ page import="com.mvnforum.db.ForumBean"%>
<%@ page import="com.mvnforum.LocaleMessageUtil"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.admin.processreportimpressionsx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css" />
<script src="<%=contextPath%>/mvnplugin/mvnforum/js/category.js" type="text/javascript"></script>
</mvn:head>
<mvn:body onunload="document.form.go.disabled=false;">
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
  <a href="<%=urlResolver.encodeURL(request, response, "reportstatistics")%>"><fmt:message key="mvnforum.admin.reportstatisticsx.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.admin.processreportimpressionsx.title"/>
</div>

<br/>
<div class="pagedesc">
  <fmt:message key="mvnforum.admin.processreportimpressionsx.info"/><br />
  <fmt:message key="mvnforum.admin.reportstatisticsx.info_export"/>
</div>
<br/>
<%
String sort  = ParamUtil.getParameterFilter(request, "sort");
String order = ParamUtil.getParameterFilter(request, "order");
if (sort.length() == 0) sort = "ForumLastPostDate";
if (order.length() == 0) order = "DESC";
%>
<table width="95%" align="center">
  <tr>
    <td nowrap="nowrap" class="portlet-font">
    <form name="form" action="<%=urlResolver.encodeURL(request, response, "processreportimpressions", URLResolverService.ACTION_URL)%>" <mvn:method/>>
      <%=urlResolver.generateFormAction(request, response, "processreportimpressions") %>
      <label for="sort"><fmt:message key="mvnforum.common.sort_by"/></label>
      <select id="sort" name="sort">
      <option value="ForumLastPostDate" <%if (sort.equals("ForumLastPostDate")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.forum.last_post_date"/></option>
      <option value="ForumCreationDate" <%if (sort.equals("ForumCreationDate")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.forum.create_date"/></option>
      <option value="ForumName" <%if (sort.equals("ForumName")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.forum.forum_name"/></option>
      <option value="ForumPostCount" <%if (sort.equals("ForumPostCount")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.forum.post_count"/></option>
      <option value="ForumThreadCount" <%if (sort.equals("ForumThreadCount")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.forum.thread_count"/></option>
      <option value="ViewCount" <%if (sort.equals("ViewCount")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.forum.view_count"/></option>
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
<br />
<%
%>
<form name="formexport" action="<%=urlResolver.encodeURL(request, response, "processexportfile", URLResolverService.ACTION_URL)%>" <mvn:method/>>
<%=urlResolver.generateFormAction(request, response, "processexportfile") %>
<mvn:securitytoken />
<input type="hidden" name="sort" value="<%=sort%>" />
<input type="hidden" name="order" value="<%=order%>" />
<input type="hidden" name="type" value="impressions" />
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
    <td align="center"><fmt:message key="mvnforum.common.forum.forum_name"/></td>
    <td align="center"><fmt:message key="mvnforum.common.forum.forum_description"/></td>
    <td align="center"><fmt:message key="mvnforum.admin.processreportimpressionsx.clicks_thread"/></td>
    <td align="center"><fmt:message key="mvnforum.admin.processreportimpressionsx.clicks_banner"/></td>
    <td align="center"><fmt:message key="mvnforum.common.forum.forum_owner_name"/></td>
    <td align="center"><fmt:message key="mvnforum.common.forum.create_date"/></td>
    <td align="center"><fmt:message key="mvnforum.common.forum.modified_date"/></td>
    <td align="center"><fmt:message key="mvnforum.common.forum.last_post_date"/></td>
    <td align="center"><fmt:message key="mvnforum.common.forum.last_post_member"/></td>
    <td align="center"><fmt:message key="mvnforum.common.forum.type"/></td>
    <td align="center"><fmt:message key="mvnforum.common.forum.post_count"/></td>
    <td align="center"><fmt:message key="mvnforum.common.forum.thread_count"/></td>
    <td align="center"><fmt:message key="mvnforum.common.forum.status"/></td>
  </tr>
<mvn:cssrows>
<%
List listForums = (List)request.getAttribute("listforums");
if (listForums != null) {
  for (int i= 0; i < listForums.size(); i++) {
    ForumBean forumBean = (ForumBean)listForums.get(i);
%>
  <tr class="<mvn:cssrow/>">
    <td align="center"><%=forumBean.getForumName()%></td>
    <td align="center"><%=forumBean.getForumDesc()%></td>
    <td align="center"><%=forumBean.getViewCount()%></td>
    <td align="center">0</td>
    <td align="center"><%=forumBean.getForumOwnerName()%></td>
    <td align="center"><%=onlineUser.getGMTTimestampFormat(forumBean.getForumCreationDate())%></td>
    <td align="center"><%=onlineUser.getGMTTimestampFormat(forumBean.getForumModifiedDate())%></td>
    <td align="center"><%=onlineUser.getGMTTimestampFormat(forumBean.getForumLastPostDate())%></td>
    <td align="center"><%=forumBean.getLastPostMemberName()%></td>
    <td align="center"><%=LocaleMessageUtil.getForumTypeDescFromInt(onlineUser.getLocale(), forumBean.getForumType())%></td>
    <td align="center"><%=forumBean.getForumPostCount()%></td>
    <td align="center"><%=forumBean.getForumThreadCount()%></td>
    <td align="center"><%=LocaleMessageUtil.getForumStatusDescFromInt(onlineUser.getLocale(), forumBean.getForumStatus())%></td>
  </tr>
<%  }
  }
%>
</mvn:cssrows>
</table>

<br/>

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>