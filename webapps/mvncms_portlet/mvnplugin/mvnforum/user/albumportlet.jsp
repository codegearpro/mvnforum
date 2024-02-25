<%--
  - $Header: /home/cvsroot/portlet-mvnforum/srcweb/mvnplugin/mvnforum/user/albumportlet.jsp,v 1.11 2010/08/20 05:16:09 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.11 $
  - $Date: 2010/08/20 05:16:09 $
  -
  - ====================================================================
  -
  - Copyright (C) 2002-2010 by MyVietnam.net
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
<%@ include file="reload_page_when_back_button_clicked.jsp"%>

<link rel="stylesheet" type="text/css" media="all" href="<%=contextPath%>/mvnplugin/mvnforum/css/album.css" />

<%
  AlbumBean albumBean = (AlbumBean) request.getAttribute("AlbumBean");
%>

<table width="240" class="left_box" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="title_poll"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/album_icon.gif" alt=""  class="icon_box" />Thư viện hình ảnh</div>
      <div class="margin_box_album">    
        <div style="padding:0 0 8px 0; font-weight:bold;"><a href="#" onclick="javascript: window.open('<%=urlResolver.encodeURL(request, response, "slideshow?albumid=" + albumBean.getAlbumID() + "&amp;albumitemid=0", URLResolverService.ACTION_URL)%>', 'album', 'width=500,height=620');"><%=albumBean.getAlbumTitle() %></a></div>
        <a href="#" onclick="javascript: window.open('<%=urlResolver.encodeURL(request, response, "slideshow?albumid=" + albumBean.getAlbumID() + "&amp;albumitemid=0", URLResolverService.ACTION_URL)%>', 'album', 'width=500,height=620');">
        <%if ("".equals(albumBean.getAlbumAvatar())) {%>
           <img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/photoleft.gif" class="album_img"/>
        <%} else {%>
           <img src="<%=urlResolver.encodeURL(request, response, "getalbumavatar?albumid=" + albumBean.getAlbumID(), URLResolverService.ACTION_URL)%>" alt="" border="0" class="album_img"/>
        <%}%> 
        </a>
        <div style="text-align:right; padding-top:7px;"><a href="<%=urlResolver.encodeURL(request, response, "listpublicalbums", URLResolverService.ACTION_URL)%>" class="next_link">Xem các album ảnh khác </a>&nbsp;<a href="#"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/next_arrow.gif" alt="" border="0" /></a></div>
      </div>
    </td>
  </tr>
</table>