<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/listalbumsx.jsp,v 1.56 2009/12/17 03:10:40 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.56 $
  - $Date: 2009/12/17 03:10:40 $
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
<%@ page import="com.mvnforum.enterprise.db.AlbumBean"%>
<%@ page import="com.mvnforum.MVNForumResourceBundle"%>

<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<%@ include file="reload_page_when_back_button_clicked.jsp"%>

<%
String title = MVNForumResourceBundle.getString(onlineUser.getLocale(), "mvnforum.user.listalbumsx.my_albums");
if ("mypublicalbums".equals((String) request.getAttribute("RootURI"))) {
    title = MVNForumResourceBundle.getString(onlineUser.getLocale(), "mvnforum.user.listalbumsx.my_public_albums");
}
%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <%=title%></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>
<%
if (isAlbumPortlet == false) {%>
  <%@ include file="header.jsp"%>
<%}else{%>
  <%@ include file="header_album.jsp"%>      
<%}%>
<br/>

<div class="nav center">
  
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <% if (isAlbumPortlet == false) {%>
    <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}else{%>
    <a href="<%=urlResolver.encodeURL(request, response, "albumportlet", URLResolverService.ACTION_URL)%>"><fmt:message key="mvnforum.user.header.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <%=title%>
</div>

<br/>

<%@ include file="inc_album_bar.jsp"%>

<%
String sort  = (String) request.getAttribute("Sort");
String order = (String) request.getAttribute("Order");
%>
<form action="<%=urlResolver.encodeURL(request, response, rootURI, URLResolverService.ACTION_URL)%>">
<%=urlResolver.generateFormAction(request, response, rootURI)%>
<table width="95%" align="center" cellpadding="3" cellspacing="0">
  <tr>
    <td>
      <label for="sort"><fmt:message key="mvnforum.common.sort_by"/></label>
      <select id="sort" name="sort">
        <option value="AlbumCreationDate" <%if ("AlbumCreationDate".equals(sort)) {%> selected="selected" <%}%>><fmt:message key="mvnforum.common.album.creation_date"/></option>
        <option value="AlbumModifiedDate" <%if ("AlbumModifiedDate".equals(sort)) {%> selected="selected" <%}%>><fmt:message key="mvnforum.common.album.modified_date"/></option>
      </select>
      <label for="order"><fmt:message key="mvnforum.common.order"/></label>
      <select id="order" name="order">
        <option value="ASC" <%if ("ASC".equals(order)) {%> selected="selected" <%}%>><fmt:message key="mvnforum.common.ascending"/></option>
        <option value="DESC" <%if ("DESC".equals(order)) {%> selected="selected" <%}%>><fmt:message key="mvnforum.common.descending"/></option>
      </select>
      <input value="<fmt:message key="mvnforum.common.go"/>" class="liteoption" type="submit" />
    </td>
  </tr>
</table>
</form>

<%
Collection albumBeans = (Collection) request.getAttribute("AlbumBeans");
int totalAlbumBeans = ((Integer)request.getAttribute("TotalAlbums")).intValue();
int albumPerPage = ((Integer)request.getAttribute("AlbumPerPage")).intValue();
%>
<pg:pager
  url="<%=rootURI%>"
  items="<%=totalAlbumBeans%>"
  maxPageItems="<%=albumPerPage%>"
  isOffset="true"
  export="offset,currentPageNumber=pageNumber"
  scope="request">
<% String rowsType = MVNForumResourceBundle.getString(onlineUser.getLocale(), "mvnforum.common.numberof.albums"); %>
<%-- keep track of preference --%>
  <pg:param name="sort"/>
  <pg:param name="order"/>

<table width="95%" align="center">
  <tr>
    <td>
      <%@ include file="inc_pager.jsp"%>
    </td>
  </tr>
</table>
<mvn:cssrows>
<table class="tborder" align="center" cellpadding="3" cellspacing="0" width="95%">
  <tr class="portlet-section-header">
    <td><%=title%></td>
  </tr>
<%if (albumBeans.size() != 0) {%>
  <tr class="<mvn:cssrow/>">
    <td width="100%">
      <table width="100%" class="noborder">
      <%
      int i = -1;
      int ALBUMS_PER_ROW = 4;
      for (Iterator iterator = albumBeans.iterator(); iterator.hasNext(); ) {
          AlbumBean albumBean = (AlbumBean)iterator.next();
          i++;
      %>
      <pg:item>
      <%if ((i % ALBUMS_PER_ROW) == 0) { %>
        <tr>
      <%} %>
          <td width="<%=100/ALBUMS_PER_ROW%>%" align="center">
            <table class="noborder">
              <tr>
                <td align="center" width="160" height="160">
                  <a href="<%=urlResolver.encodeURL(request, response, "viewalbum?albumid=" + albumBean.getAlbumID())%>">
                    <%if ("".equals(albumBean.getAlbumAvatar())) {%>
                      <img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/photoleft.gif" alt="" width="160" height="160" border="0" />
                    <%} else { %>
                      <img src="<%=urlResolver.encodeURL(request, response, "getalbumavatar?albumid=" + albumBean.getAlbumID(), URLResolverService.ACTION_URL)%>" alt="" border="0" />
                    <%} %>
                  </a>
                </td>
              </tr>
              <tr>
                <td align="center">
                  <a href="<%=urlResolver.encodeURL(request, response, "viewalbum?albumid=" + albumBean.getAlbumID())%>"><%=albumBean.getAlbumTitle() %></a>                  
                </td>
              </tr>
              <tr>
                <td align="center" style="color:#808080;">
                  <fmt:message key="mvnforum.common.numberof.photos"/>: <%=albumBean.getAlbumItemCount()%> - 
                  <fmt:message key="mvnforum.common.album.viewcount"/>: <%=albumBean.getAlbumViewCount()%>
                </td>
              </tr>
              <tr>
                <td align="center">
                  <span style="color:#808080;"><%=onlineUser.getGMTDateFormat(albumBean.getAlbumCreationDate())%><%if (isPortlet && permission.isAuthenticated()) { %>(id: <%=albumBean.getAlbumID() %>)<%} %></span>&nbsp;
                  <%if (albumBean.getAlbumShareOption() == AlbumBean.ALBUM_SHARE_OPTION_PRIVATE)   {%><font color="#FF0000"><fmt:message key="mvnforum.common.album.shareoption.private"/></font><%}%>
                  <%if (albumBean.getAlbumShareOption() == AlbumBean.ALBUM_SHARE_OPTION_MYFRIENDS) {%><font color="#006600"><fmt:message key="mvnforum.common.album.shareoption.myfriends"/></font><%}%>
                </td>
              </tr>
            </table>
          </td>
      <%if ( ( ((i+1) % ALBUMS_PER_ROW) == 0) || (iterator.hasNext() == false) ) { %>
        </tr>
      <%}%>
      </pg:item>
    <%} //end for%>
      </table>
    </td>
  </tr>
<%} else {%>
  <tr class="<mvn:cssrow/>">
    <td align="center"><fmt:message key="mvnforum.common.album.info.no_albums"/></td>
  </tr>
<%}%>
</table>
</mvn:cssrows>

<table width="95%" align="center">
  <tr>
    <td>
      <%@ include file="inc_pager.jsp"%>
    </td>
  </tr>
</table>
</pg:pager>

<br/>

<%if (isAlbumPortlet == false) {%>
<%@ include file="footer.jsp"%>
<%}%>
</mvn:body>
</mvn:html>
</fmt:bundle>
