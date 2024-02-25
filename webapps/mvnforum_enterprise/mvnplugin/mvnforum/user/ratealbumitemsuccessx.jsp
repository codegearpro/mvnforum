<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/ratealbumitemsuccessx.jsp,v 1.21 2009/10/30 09:17:30 nhanld Exp $
 - $Author: nhanld $
 - $Revision: 1.21 $
 - $Date: 2009/10/30 09:17:30 $
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
<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<%@page import="com.mvnforum.enterprise.db.AlbumItemBean"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.ratealbumitemsuccessx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>

<%
  AlbumItemBean itemBean = (AlbumItemBean) request.getAttribute("AlbumItemBean");
%>

<table width="95%" align="center">
  <tr>
    <td align="center">
      <br />
      <br />
      <br />
      <fmt:message key="mvnforum.user.ratealbumitemsuccessx.thanks_for_votting"/><br /><br />
      <form action="">
        <% if (isPortlet) { %>
          <a href="<%=urlResolver.encodeURL(request, response, "viewpublicalbumitem?itemid=" + itemBean.getAlbumItemID())%>"><fmt:message key="mvnforum.common.action.go_back_btn"/></a>
        <% } else { %>
          <input type="button" value="<fmt:message key="mvnforum.common.action.close"/>" onclick="opener.location.reload(); window.close();" class="portlet-form-button" />
        <% } %>
      </form>
    </td>
  </tr>
</table>

</mvn:body>
</mvn:html>
</fmt:bundle>