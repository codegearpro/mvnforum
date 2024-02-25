<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/organizephotosx.jsp,v 1.37 2009/12/17 03:10:40 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.37 $
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
<%@ page import="com.mvnforum.enterprise.db.AlbumItemBean"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<%@ include file="reload_page_when_back_button_clicked.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.organizephotosx.title"/></mvn:title>
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
AlbumBean albumBean = (AlbumBean) request.getAttribute("AlbumBean");
Collection albumItemBeans = (Collection) request.getAttribute("AlbumItemBeans");
String videoMineType = "video";
String mediaType = (String) request.getAttribute("MediaType");
%>

<script type="text/javascript">
//<![CDATA[
function confirmDelete(albumid, itemid) {
  var msg;
  msg= "<fmt:message key="mvnforum.common.albumitem.question.question_delete"/>";
  var agree = confirm(msg);
  if (agree) {
    document.location.href='<%=urlResolver.encodeURL(request, response, "deletealbumitem?key=organize&itemid=")%>'+itemid+'&albumid='+albumid;
  } else {
    document.location.href='#';
  }
}
//]]>
</script>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isAlbumPortlet == false) {%>
    <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}else{%>
    <a href="<%=urlResolver.encodeURL(request, response, "albumportlet", URLResolverService.ACTION_URL)%>"><fmt:message key="mvnforum.user.header.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "myalbums")%>"><fmt:message key="mvnforum.user.listalbumsx.my_albums"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.common.album"/>: <a href="<%=urlResolver.encodeURL(request, response, "viewalbum?albumid=" + albumBean.getAlbumID())%>"><%=albumBean.getAlbumTitle() %></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.organizephotosx.title"/>
</div>
<br/>

<% String requestURI = "organizephotos"; %>
<%@ include file="inc_album_bar.jsp"%>
<br />

<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td align="center"><fmt:message key="mvnforum.common.albumitem"/></td>
    <td align="center"><fmt:message key="mvnforum.common.albumitem.title"/></td>
    <td align="center"><fmt:message key="mvnforum.common.order"/></td>
    <td align="center"><fmt:message key="mvnforum.common.albumitem.creation_date"/></td>
    <td align="center"><fmt:message key="mvnforum.common.albumitem.modified_date"/></td>
    <td align="center"><fmt:message key="mvnforum.common.action"/></td>
  </tr>
<%if (albumBean.getAlbumItemCount() == 0) {%>
  <tr class="<mvn:cssrow/>">
    <td colspan="6" align="center"><fmt:message key="mvnforum.common.albumitem.info.no_photos"/></td>
  </tr>
<%} else {
    for (Iterator iterator = albumItemBeans.iterator(); iterator.hasNext(); ) {
        AlbumItemBean albumItemBean = (AlbumItemBean) iterator.next(); %>
  <tr class="<mvn:cssrow/>">
    <td align="left">   
    <%if (albumItemBean.getItemMimeType().indexOf(videoMineType) != -1) {%>                 
    <object type="video/x-ms-wmv" 
        data="<%=urlResolver.encodeURL(request, response, "getalbumitem?itemid=" + albumItemBean.getAlbumItemID(), URLResolverService.ACTION_URL)%>" 
        width="144" height="108">
        <param name="src" 
          value="<%=urlResolver.encodeURL(request, response, "getalbumitem?itemid=" + albumItemBean.getAlbumItemID(), URLResolverService.ACTION_URL)%>" />
        <param name="autostart" value="false" />
        <param name="controller" value="true" />
        <PARAM NAME="showcontrols" VALUE="true">                        
      </object>
    <%}else{%>
      <a href="<%=urlResolver.encodeURL(request, response, "viewalbumitem?itemid=" + albumItemBean.getAlbumItemID())%>">
        <img src="<%=urlResolver.encodeURL(request, response, "getalbumitem?itemid=" + albumItemBean.getAlbumItemID(), URLResolverService.ACTION_URL)%>" alt="<%=albumItemBean.getItemTitle()%>" border="0"<%if (albumItemBean.getItemWidth() == 0) {%> width="144" height="108"<%} else {%> width="<%=(albumItemBean.getItemWidth() > 144) ? 144 : albumItemBean.getItemWidth()%>"<%if (albumItemBean.getItemWidth() > 144 && albumItemBean.getItemHeight()*144/albumItemBean.getItemWidth() > 108) {%> height="108"<%}}%> />
      </a>
    <%}%>
    </td>
    <td align="left">
      <a href="<%=urlResolver.encodeURL(request, response, "viewalbumitem?itemid=" + albumItemBean.getAlbumItemID())%>">
        <%=albumItemBean.getItemTitle()%>
      </a>
    </td>
    <td align="center">
      <table width="100%" class="noborder">
        <tr>
          <td width="30%" align="center">
            <% if (albumItemBean.getItemOrder() > 0) { %>
            <a href="<%=urlResolver.encodeURL(request, response, "updatephotoorder?itemid=" + albumItemBean.getAlbumItemID() + "&amp;action=up&amp;albumid=" + albumBean.getAlbumID(), URLResolverService.ACTION_URL)%>"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/up.gif" border="0" alt="<fmt:message key="mvnforum.common.order.move_up"/>" title="<fmt:message key="mvnforum.common.order.move_up"/>" /></a>
            <% } %>
          </td>
          <td width="40%" align="center"><b><%=albumItemBean.getItemOrder()%></b></td>
          <td width="30%" align="center"><a href="<%=urlResolver.encodeURL(request, response, "updatephotoorder?itemid=" + albumItemBean.getAlbumItemID() + "&amp;action=down&amp;albumid=" + albumBean.getAlbumID(), URLResolverService.ACTION_URL)%>"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/down.gif" border="0" alt="<fmt:message key="mvnforum.common.order.move_down"/>" title="<fmt:message key="mvnforum.common.order.move_down"/>" /></a></td>
        </tr>
      </table>
    </td>
    <td align="center">
      <%=onlineUser.getGMTTimestampFormat(albumItemBean.getItemCreationDate())%>
    </td>
    <td align="center">
      <%=onlineUser.getGMTTimestampFormat(albumItemBean.getItemModifiedDate())%>
    </td>
    <td align="center">
      <a class="command" onclick="confirmDelete(<%=albumBean.getAlbumID() %>, <%=albumItemBean.getAlbumItemID() %>)" href="#"><fmt:message key="mvnforum.common.action.delete"/></a>
    </td>
  </tr>
  <%} //end for%>
<%} //end else %>
</mvn:cssrows>
</table>

<br/>
<%if (isAlbumPortlet == false) {%>
    <%@ include file="footer.jsp"%>
<%}%>
</mvn:body>
</mvn:html>
</fmt:bundle>
