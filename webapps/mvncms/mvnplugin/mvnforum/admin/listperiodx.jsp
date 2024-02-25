<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/listperiodx.jsp,v 1.30 2009/07/16 03:28:23 xuantl Exp $
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
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="java.util.*"%>
<%@ page import="net.myvietnam.mvncore.util.ParamUtil"%>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter"%>
<%@ page import="com.mvnforum.db.*"%>
<%@ page import="com.mvnforum.MVNForumConstant"%>
<%@ page import="com.mvnforum.enterprise.db.VotePeriodBean"%>
<%@ page import="com.mvnforum.enterprise.db.DAOFactoryEnterprise"%>

<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name" /> - <fmt:message key="mvnforum.admin.listperiodx.title"/></mvn:title>
  <%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
  <link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<br />
<%
String typeStr = (String) request.getAttribute("type");
int type = VotePeriodBean.PERIOD_TYPE_GLOBAL;
if (typeStr != null && typeStr.length() > 0) {
  type = new Integer(typeStr).intValue();
}
%>
<script type="text/javascript">
//<![CDATA[
function onLoadTab(tabname) {
  if (tabname == 'global') {
      document.getElementById('global').className='on';
      document.getElementById('normal').className='off';
      document.getElementById('statistical').className='off';
  } else if (tabname == 'normal') {
      document.getElementById('global').className='off';
      document.getElementById('normal').className='on';
      document.getElementById('statistical').className='off';
  } else if (tabname == 'statistical') {
      document.getElementById('global').className='off';
      document.getElementById('normal').className='off';
      document.getElementById('statistical').className='on';
  }
}
//]]>
</script>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isServlet) {%>
  <a href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.admin.listperiodx.title"/>
</div>
<br />

<table width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr>
    <td>
      <div class="tab_panel">
        <ul class="tab" style="background: url(<%=contextPath%>/mvnplugin/mvnforum/images/icon/tab-line.gif) repeat-x left bottom;">
          <li><a id="global" href="<%=urlResolver.encodeURL(request, response, "listperiod?type="+VotePeriodBean.PERIOD_TYPE_GLOBAL)%>" title="<fmt:message key="mvnforum.common.vote_period.type.global" />"><fmt:message key="mvnforum.common.vote_period.type.global" /></a></li>
          <li><a id="normal" href="<%=urlResolver.encodeURL(request, response, "listperiod?type="+VotePeriodBean.PERIOD_TYPE_NORMAL)%>" title="<fmt:message key="mvnforum.common.vote_period.type.normal" />"><fmt:message key="mvnforum.common.vote_period.type.normal" /></a></li>
          <li><a id="statistical" href="<%=urlResolver.encodeURL(request, response, "listperiod?type="+VotePeriodBean.PERIOD_TYPE_STATISTICAL)%>" title="<fmt:message key="mvnforum.common.vote_period.type.statistical" />"><fmt:message key="mvnforum.common.vote_period.type.statistical" /></a></li>
          <!-- li><a id="voteresult" href="<%=urlResolver.encodeURL(request, response, "viewvoteresult")%>" title="<fmt:message key="mvnforum.user.viewvoteresultx.title" />"><fmt:message key="mvnforum.user.viewvoteresultx.title"/></a></li-->
        </ul>
      </div>
    </td>
  </tr>
</table>
<br />

<%if (type == VotePeriodBean.PERIOD_TYPE_GLOBAL) {%>
  <%@ include file="listglobalperiodx.jsp"%>
<%} else if (type == VotePeriodBean.PERIOD_TYPE_NORMAL) {%>
  <%@ include file="listnormalperiodx.jsp"%>
<%} else if (type == VotePeriodBean.PERIOD_TYPE_STATISTICAL) {%>
  <%@ include file="liststatisticalperiodx.jsp"%>
<%}%>

<script type="text/javascript">
//<![CDATA[
<%if (type == VotePeriodBean.PERIOD_TYPE_GLOBAL) {%>
  onLoadTab('global');
<%} else if (type == VotePeriodBean.PERIOD_TYPE_NORMAL) {%>
  onLoadTab('normal');
<%} else if (type == VotePeriodBean.PERIOD_TYPE_STATISTICAL) {%>
  onLoadTab('statistical');
<%}%>
//]]>
</script>         
<br />
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>