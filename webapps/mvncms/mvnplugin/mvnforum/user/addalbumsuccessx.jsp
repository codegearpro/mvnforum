<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/addalbumsuccessx.jsp,v 1.18 2009/10/22 09:54:19 hoanglt Exp $
  - $Author: hoanglt $
  - $Revision: 1.18 $
  - $Date: 2009/10/22 09:54:19 $
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

<%@ page import="com.mvnforum.enterprise.db.*"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<% 
AlbumBean albumBean = (AlbumBean) request.getAttribute("AlbumBean");
%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.addalbumsuccessx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<meta http-equiv="refresh" content="3; url=<%=urlResolver.encodeURL(request, response, "uploadphotos?albumid=" + albumBean.getAlbumID())%>" />
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css" />
</mvn:head>
<mvn:body>
<%if (isAlbumPortlet == false) {%>
  <%@ include file="header.jsp"%>
<%}else{%>
  <%@ include file="header_album.jsp"%>
<%}%>
<br/>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isAlbumPortlet == false) {%>
    <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}else{%>
    <a href="<%=urlResolver.encodeURL(request, response, "albumportlet", URLResolverService.ACTION_URL)%>"><fmt:message key="mvnforum.user.header.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "myalbums")%>"><fmt:message key="mvnforum.user.listalbumsx.my_albums"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.addalbumsuccessx.title"/>
</div>
<br/>

<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td><fmt:message key="mvnforum.common.success.prompt"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>
      <b>&raquo;&nbsp;</b><a class="command" href="<%=urlResolver.encodeURL(request, response, "uploadphotos?albumid=" + albumBean.getAlbumID())%>"><fmt:message key="mvnforum.user.success.go_uploadphotos"/></a>
      (<fmt:message key="mvnforum.common.success.automatic"/>)
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><b>&raquo;&nbsp;</b><a class="command" href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.user.success.go_index"/></a></td>
  </tr>
</mvn:cssrows>
</table>

<br/>
<%if (isAlbumPortlet == false) {%>
    <%@ include file="footer.jsp"%>
<%}%>
</mvn:body>
</mvn:html>
</fmt:bundle>