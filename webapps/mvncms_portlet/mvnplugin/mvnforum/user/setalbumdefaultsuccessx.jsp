<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/setalbumdefaultsuccessx.jsp,v 1.2 2009/11/19 11:16:07 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.2 $
 - $Date: 2009/11/19 11:16:07 $
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
<%@ page import="com.mvnforum.db.PollBean"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.setalbumdefaultsuccess.title"/></mvn:title>
  <%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
  <meta http-equiv="refresh" content="3; url=<%=urlResolver.encodeURL(request, response, "listpublicalbums")%>"/>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>

<%if (isAlbumPortlet == false) {%>
  <%@ include file="header.jsp"%>
 
  <br/>
  <div class="nav center">
    <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
    <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
    <a href="<%=urlResolver.encodeURL(request, response, "listpublicalbums")%>"><fmt:message key="mvnforum.user.listalbumsx.public_albums"/></a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.user.setalbumdefaultsuccess.title"/>
  </div>
<%} else {%>
  <%@ include file="header_album.jsp"%>
<br/>
  <div class="nav center">
    <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
    <a href="<%=urlResolver.encodeURL(request, response, "", URLResolverService.ACTION_URL)%>"><fmt:message key="mvnforum.user.header.index"/></a>&nbsp;&raquo;&nbsp;
    <a href="<%=urlResolver.encodeURL(request, response, "listpublicalbums")%>"><fmt:message key="mvnforum.user.listalbumsx.public_albums"/></a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.user.setalbumdefaultsuccess.title"/>
  </div>
<%}%> 

  <br/>
<mvn:cssrows>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td><fmt:message key="mvnforum.common.success.prompt"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><b>&raquo;&nbsp;</b><a class="command" href="<%=urlResolver.encodeURL(request, response, "listpublicalbums")%>"><fmt:message key="mvnforum.user.success.go_listpublicalbums"/></a> (<fmt:message key="mvnforum.common.success.automatic"/>)</td>
  </tr>
  <%if (isAlbumPortlet == false) {%>
    <tr class="<mvn:cssrow/>">
      <td><b>&raquo;&nbsp;</b><a class="command" href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.user.success.go_index"/></a></td>
    </tr>
  <%} else {%>
    <tr class="<mvn:cssrow/>">
      <td><b>&raquo;&nbsp;</b><a class="command" href="<%=urlResolver.encodeURL(request, response, "", URLResolverService.ACTION_URL)%>"><fmt:message key="mvnforum.user.success.go_index"/></a></td>
    </tr>
  <%}%> 
</table>
</mvn:cssrows>
<br/>

<%if (isPollPortlet == false) {%>
  <%@ include file="footer.jsp"%>
<%} %>
</mvn:body>
</mvn:html>
</fmt:bundle>