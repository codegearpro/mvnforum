<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/searchalbumitemx.jsp,v 1.26 2009/12/17 03:10:40 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.26 $
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
<%-- not localized yet --%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="java.util.*"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.mvnforum.db.*"%>
<%@ page import="com.mvnforum.enterprise.db.*"%>
<%@ page import="com.mvnforum.enterprise.db.AlbumBean"%>
<%@ page import="com.mvnforum.MVNForumResourceBundle"%>
<%@ page import="com.mvnforum.auth.MVNForumPermission"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<%@ include file="reload_page_when_back_button_clicked.jsp"%>

<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.searchalbumitemx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>

<%if (isAlbumPortlet == false) {%>
  <%@ include file="header.jsp"%>
<%}else{%>
  <%@ include file="header_album.jsp"%>
<%}%>
<br/>

<%
Collection albumItemBeans = (Collection) request.getAttribute("AlbumItemBeans");
String searchString = (String) request.getAttribute("SearchString");
String searchScope = (String) request.getAttribute("SearchScope");
int totalResult = ((Integer) request.getAttribute("TotalItemAlbums")).intValue();
int albumItemPerPage = 20;
String sort = (String) request.getAttribute("Sort");
String order = (String) request.getAttribute("Order");
int albumItemSize = albumItemBeans.size();
String tagvalue = (String) request.getAttribute("TagValue");
String searchField = (String) request.getAttribute("SearchField");
%>
<pg:pager
  url="searchalbumitem"
  items="<%=totalResult%>"
  maxPageItems="<%=albumItemPerPage%>"
  isOffset="true"
  export="offset,currentPageNumber=pageNumber"
  scope="request">
  <pg:param name="searchString"/>
  <pg:param name="searchScope"/>


<%
/*
try {
    offset = ((Integer)request.getAttribute("offset")).intValue();
   // offset = new Integer((String)request.getAttribute("offset"));
} catch (Exception e) {
    // do nothing
}
*/
%>
<% String rowsType = MVNForumResourceBundle.getString(onlineUser.getLocale(), "mvnforum.common.numberof.photos"); %>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isAlbumPortlet == false) {%>
    <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}else{%>
    <a href="<%=urlResolver.encodeURL(request, response, "albumportlet", URLResolverService.ACTION_URL)%>"><fmt:message key="mvnforum.user.header.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <%if ("Tag".equalsIgnoreCase(searchField)) {%>
    <a href="<%=urlResolver.encodeURL(request, response, "exploretags")%>"><fmt:message key="mvnforum.user.exploretagsx.title"/></a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.common.album_item_tag.tagvalue"/>: <%=tagvalue%>
  <%} else {%>
    <fmt:message key="mvnforum.user.searchalbumitemx.title"/>
    <%if (searchString.length() > 0) {%>
      &nbsp;&raquo;&nbsp;<%=searchString%>
  <%  } 
    }%>
</div>
<br/>
<mvn:cssrows>
<table width="95%" align="center">
  <tr class="<mvn:cssrow/>">
    <td align="left">
      <%@ include file="inc_pager.jsp"%>
    </td>
  </tr>
</table>

<table align="center" width="95%" class="tborder" cellpadding="2" cellspacing="0">
  <%if ("Tag".equalsIgnoreCase(searchField) == false) {%>
  <tr class="topmenu">
    <td width="100%">
      <form action="<%=urlResolver.encodeURL(request, response, "searchalbumitem", URLResolverService.ACTION_URL)%>" name="searchform" id="searchform" <mvn:method/>>
      <%=urlResolver.generateFormAction(request, response, "searchalbumitem")%>
      <table width="100%" cellspacing="0" cellpadding="1" class="noborder">
        <tr>
          <td>
          <%if (onlineUser.isMember() && onlineUser.getPermission().canUseAlbum() && MVNForumConfig.getEnablePrivateAlbum()) {%>
            <a href="<%=urlResolver.encodeURL(request, response, "addalbum?check1=0")%>" class="linktop"><fmt:message key="mvnforum.user.addalbumx.title"/></a>&nbsp;&nbsp;&nbsp;
            <a href="<%=urlResolver.encodeURL(request, response, "myalbums")%>" class="linktop"><fmt:message key="mvnforum.user.listalbumsx.my_albums"/></a>&nbsp;&nbsp;&nbsp;
            <%-- <a href="#" class="linktop"><fmt:message key="mvnforum.user.listalbumsx.my_favorites"/></a>&nbsp;&nbsp;&nbsp;--%>
            <a href="<%=urlResolver.encodeURL(request, response, "mypublicalbums")%>" class="linktop"><fmt:message key="mvnforum.user.listalbumsx.my_public_albums"/></a>&nbsp;&nbsp;&nbsp;
          <%} else if (MVNForumConfig.getEnablePublicAlbum()) {%>
            <fmt:message key="mvnforum.user.listalbumsx.public_albums"/>
            <%}%>
          </td>
          <td align="right">
            <%if (onlineUser.isMember() && onlineUser.getPermission().canUseAlbum()){%>
              <select name="searchScope">
                <%if (MVNForumConfig.getEnablePrivateAlbum()) {%>
                <option value="MyAlbums"<%if ("MyAlbums".equals(searchScope)) {%> selected="selected" <%}%>><fmt:message key="mvnforum.user.listalbumsx.my_albums"/></option>
                <%}%>
                <%if (MVNForumConfig.getEnablePublicAlbum()) {%>
                <option value="PublicAlbums"<%if ("PublicAlbums".equals(searchScope)) {%> selected="selected" <%}%>><fmt:message key="mvnforum.user.listalbumsx.public_albums"/></option>
                <%}%>
              </select>            
            <%}%>
              <input type="text" name="searchString" value="<%=searchString%>" />
              <input value="<fmt:message key="mvnforum.common.action.search_photos"/>" class="portlet-form-button" type="submit" />
          </td>
        </tr>
      </table>
      </form>
    </td>
  </tr>
  <%} %>
  <%if (albumItemBeans.size() == 0) {%>
    <tr class="<mvn:cssrow/>">
      <td align="center">
        <fmt:message key="mvnforum.common.albumitem.info.no_photos"/>
      </td>
    </tr>
  <%} else { %>
    <tr class="<mvn:cssrow/>">
      <td width="100%">
        <table cellspacing="1" cellpadding="0" width="100%" bgcolor="#FFFFFF" class="noborder">
      <%
      int i = -1;
      for (Iterator iterator = albumItemBeans.iterator(); iterator.hasNext(); ) {
          AlbumItemBean albumItemBean = (AlbumItemBean) iterator.next();
          AlbumBean albumBean = DAOFactoryEnterprise.getAlbumDAO().getBean(albumItemBean.getAlbumID());
          i++;
      %>
      <pg:item>
      <% if ( i % 4  == 0 ) { %>
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
      <% } %>
      <td width="235">
        <table width="235" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF" class="noborder">
          <tr>
            <td align="center" width="160" height="160">
              <a onclick="javascript:__Open('<%=urlResolver.encodeURL(request, response, "slideshow?albumid=" + albumBean.getAlbumID() + "&amp;albumitemid=0", URLResolverService.ACTION_URL)%>', 500, 620);" href="#">
                <img src="<%=urlResolver.encodeURL(request, response, "getalbumitem?itemid=" + albumItemBean.getAlbumItemID(), URLResolverService.ACTION_URL)%>" alt="<%=albumItemBean.getItemTitle()%>" border="0"<%if (albumItemBean.getItemWidth() == 0) {%> width="144" height="108"<%} else {%> width="<%=(albumItemBean.getItemWidth() > 144) ? 144 : albumItemBean.getItemWidth()%>"<%if (albumItemBean.getItemWidth() > 144 && albumItemBean.getItemHeight()*144/albumItemBean.getItemWidth() > 108) {%> height="108"<%}}%> />
              </a>
            </td>
          </tr>
          <tr>
            <td align="center">&nbsp;
              <a style="color: rgb(77, 77, 77); font-weight: bold; text-decoration: none;" onclick="javascript:__Open('<%=urlResolver.encodeURL(request, response, "slideshow?albumid=" + albumBean.getAlbumID() + "&amp;albumitemid=0", URLResolverService.ACTION_URL)%>', 385, 451);" href="#">
                <%=albumItemBean.getItemTitle()%></a><br />
                By&nbsp;<span style="color: rgb(0, 73, 147);"><%=albumBean.getMemberName()%></span><br />
                <span style="color: rgb(128, 128, 128);"><%=albumBean.getAlbumTitle()%></span>
            </td>
          </tr>
        </table>
      </td>
      <% if ( i % 4  == 3 && i != albumItemSize ) { %>
        </tr>
      <%} //end if %>
          </pg:item>
    <%} //end for%>
        <% if (albumItemSize % 4 != 0) {%>
           <td colspan="<%=4 - albumItemSize % 4 %>" bgcolor="white">&nbsp;</td>
        </tr>
        <%} // end if%>
        </table>
        </td>
      </tr>
  <%} // end else%>
</table>

<table width="95%" align="center">
  <tr class="<mvn:cssrow/>">
    <td align="left">
      <%@ include file="inc_pager.jsp"%>
    </td>
  </tr>
</table>
</mvn:cssrows>
</pg:pager>

<br/>
<%if (isAlbumPortlet == false) {%>
    <%@ include file="footer.jsp"%>
<%}%>

</mvn:body>
</mvn:html>
</fmt:bundle>
