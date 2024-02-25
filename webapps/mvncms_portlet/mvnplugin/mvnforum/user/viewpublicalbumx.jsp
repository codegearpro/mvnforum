<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/viewpublicalbumx.jsp,v 1.71 2010/06/22 03:12:47 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.71 $
  - $Date: 2010/06/22 03:12:47 $
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
<%@ page import="java.sql.Timestamp"%>

<%@ page import="com.mvnforum.db.*"%>
<%@ page import="com.mvnforum.enterprise.db.*"%>
<%@ page import="com.mvnforum.enterprise.db.AlbumBean"%>
<%@ page import="com.mvnforum.enterprise.MVNForumEnterpriseConfig"%>
<%@ page import="com.mvnforum.MVNForumConfig"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<%@ include file="reload_page_when_back_button_clicked.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.viewalbumx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
<link type="text/css" media="all" href="<%=contextPath%>/mvnplugin/mvnforum/css/phrogz/tabtastic.css" rel="stylesheet" />
<%if (MVNForumEnterpriseConfig.getEnableAlbumItemRate()) {%>
<style type="text/css">
.star-rating li.current-rating{
  background: url(<%=contextPath%>/mvnplugin/mvnforum/images/album/small_star.gif) bottom left;
  position: absolute;
  height: 11px;
  z-index: 1;
  bottom: 0px;
  left: 0px;
  text-indent: -1000px;
}
.star-rating{
  background: url(<%=contextPath%>/mvnplugin/mvnforum/images/album/small_star.gif) top left repeat-x;
  position: relative;
  width: 55px;
  height: 11px;
  overflow: hidden;
  list-style: none;
  margin: 0px;
  padding: 0px;
}
</style>
<%} %>
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
MemberBean memberBean = (MemberBean) request.getAttribute("MemberBean");
int albumItemSize = albumItemBeans.size();
int albumViewCount = ((Integer) request.getAttribute("AlbumViewCount")).intValue();
String mediaType = (String) request.getAttribute("MediaType");
%>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isAlbumPortlet == false) {%>
     <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}else{%>
     <a href="<%=urlResolver.encodeURL(request, response, "albumportlet", URLResolverService.ACTION_URL)%>"><fmt:message key="mvnforum.user.header.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "listpublicalbums")%>"><fmt:message key="mvnforum.user.listalbumsx.public_albums"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.listalbumsx.album_of_user"/>
  <%if (MVNForumEnterpriseConfig.getEnableShowAlbumMember()) {%>
      <a href="<%=urlResolver.encodeURL(request, response, "listpublicalbums?membername=" + memberBean.getMemberName())%>"><%=memberBean.getMemberName()%></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <fmt:message key="mvnforum.common.album"/>: <%= albumBean.getAlbumTitle() %>
</div>
<br/>

<table align="center" width="95%" cellpadding="0" cellspacing="0">
  <tr>
    <!-- Left section -->
    <td valign="top" width="20%">
      <table align="center" width="100%" cellpadding="0" cellspacing="0" class="tborder">
        <tr class="portlet-section-body">
          <td align="left">
            <table cellpadding="4" cellspacing="0" width="100%" class="noborder">
              <tr>
                <td align="center">
                  <%if (albumBean.getAlbumAvatar().equals("")) {%>
                    <img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/photoleft.gif" width="180" height="180" border="0" alt="" />
                  <%} else { %>
                    <img src="<%=urlResolver.encodeURL(request, response, "getalbumavatar?albumid=" + albumBean.getAlbumID(), URLResolverService.ACTION_URL)%>" alt="" border="0" />
                  <%} %>
                </td>
              </tr>
              <tr>
                <td align="left">
                  <b><%=albumBean.getAlbumTitle()%></b><br />
                  <fmt:message key="mvnforum.common.numberof.photos"/>: <%=albumBean.getAlbumItemCount()%><br />
                  <fmt:message key="mvnforum.common.album.viewcount"/>: <%=albumViewCount%><br />
                  <%=onlineUser.getGMTDateFormat(albumBean.getAlbumCreationDate())%><br />
                </td>
              </tr>
              <%if (albumBean.getAlbumDesc().length() > 0) {%>
              <tr>
                <td><hr /></td>
              </tr>
              <tr>
                <td><%=albumBean.getAlbumDesc() %></td>
              </tr>
              <%} %>
            </table>
          </td>
        </tr>
      </table>
      <br />
    <% if (MVNForumEnterpriseConfig.getEnableShowAlbumMember()) {%>
      <table class="tborder" align="center" cellpadding="3" cellspacing="0" width="100%">
        <tr class="portlet-section-body">
          <td valign="middle">
            <table class="noborder">
              <tr>
                <% if (MVNForumConfig.getEnableAvatar()) { %>
                <td valign="middle">
                    <% if (memberBean.getMemberAvatar().length() > 0) { %>
                    <img height="60" src="<%=memberBean.getMemberAvatar_processed(request, response)%>" border="0" alt="<fmt:message key="mvnforum.user.myprofile.has_avatar"/>" title="<fmt:message key="mvnforum.user.myprofile.has_avatar"/>" />
                    <% } else { %>
                    <img height="60" src="<%=contextPath%>/mvnplugin/mvnforum/images/user/no_picture.gif" border="0" alt="<fmt:message key="mvnforum.user.myprofile.no_avatar"/>" title="<fmt:message key="mvnforum.user.myprofile.no_avatar"/>" />
                    <% } %>
                </td>
                <% } //enable avatar%>
                <td valign="middle">&nbsp;&nbsp;<b><%=albumBean.getMemberName()%></b></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    <%}%>     
    </td>
    <!-- End of left section -->

    <td style="width: 5px;">&nbsp;&nbsp;</td>

    <!-- Center section -->
    <td valign="top" width="80%">
       <ul class="tabset_tabs">            
        <li><a class="<%if (mediaType == null || "".equals(mediaType) || "all".equals(mediaType)) {%>preActive active<%} else {%>preActive postActive<%}%>" href="<%=urlResolver.encodeURL(request, response, "viewpublicalbum?albumid=" + albumBean.getAlbumID() + "&amp;mediatype=all")%>"><fmt:message key="mvnforum.common.albumitem.mediatype.all"/></a></li>
        <li><a class="<%if ("image".equals(mediaType)) {%>preActive active<%} else {%>preActive postActive<%}%>" href="<%=urlResolver.encodeURL(request, response, "viewpublicalbum?albumid=" + albumBean.getAlbumID() + "&amp;mediatype=image")%>"><fmt:message key="mvnforum.common.albumitem.mediatype.image"/></a></li>
        <li><a class="<%if ("video".equals(mediaType)) {%>preActive active<%} else {%>preActive postActive<%}%>" href="<%=urlResolver.encodeURL(request, response, "viewpublicalbum?albumid=" + albumBean.getAlbumID() + "&amp;mediatype=video")%>"><fmt:message key="mvnforum.common.albumitem.mediatype.video"/></a></li>
      </ul>
    <div class="tabset_content tabset_content_active">
      <table align="center" width="100%" class="tborder" cellpadding="2" cellspacing="0">
       
        
        <tr class="topmenu">
          <td width="100%">            
            <form action="<%=urlResolver.encodeURL(request, response, "searchalbumitem", URLResolverService.ACTION_URL)%>" name="searchform" id="searchform" <mvn:method/>>
              <table width="100%" cellspacing="0" cellpadding="1" class="noborder">
                <tbody>
                  <%=urlResolver.generateFormAction(request, response, "searchalbumitem")%>
                  <tr>
                    <td>
                      <%if ("image".equals(mediaType)){
                        if (albumItemBeans.size() != 0) {%>
                        <input type="button" value="<fmt:message key="mvnforum.user.slideshowx.title"/>" class="portlet-form-button" onclick="window.open('<%=urlResolver.encodeURL(request, response, "slideshow?albumid=" + albumBean.getAlbumID() + "&amp;albumitemid=0", URLResolverService.ACTION_URL)%>', 'album', 'width=500,height=620');" />
                      <%}} %>
                    </td>
                    <td align="right">
                      <input type="hidden" name="searchScope" value="PublicAlbums" />
                      <input type="hidden" name="page" value="PublicAlbums" />
                      <input type="text" name="searchString" />
                      <input value="<fmt:message key="mvnforum.common.action.search_photos"/>" class="portlet-form-button" type="submit" />
                    </td>
                  </tr>
                </tbody>
              </table>
            </form>
          </td>
        </tr>
      <%if (albumItemBeans.size() == 0) {%>
        <tr class="portlet-section-body">
          <td align="center">
            <fmt:message key="mvnforum.common.albumitem.info.no_photos"/>
          </td>
        </tr>
      <%} else { %>
          <tr class="portlet-section-body">
            <td width="100%">
            <table class="noborder" cellspacing="0" cellpadding="0" width="100%">
            <%
            int i = -1;
            int ALBUM_ITEMS_PER_ROW = 4;
            for (Iterator iterator = albumItemBeans.iterator(); iterator.hasNext(); ) {
              AlbumItemBean albumItemBean = (AlbumItemBean) iterator.next();
              float currentRate = 0;
              if (albumItemBean.getItemVoteCount() != 0) {
                  currentRate = (float) albumItemBean.getItemVoteTotalStars() / albumItemBean.getItemVoteCount()* 20;
              }
              i++;
              if ( (i % ALBUM_ITEMS_PER_ROW) == 0 ) { %>
              <tr>
                <%for (int j = 0; j < ALBUM_ITEMS_PER_ROW; j++) {%>
                <td width="<%=100/ALBUM_ITEMS_PER_ROW%>%">&nbsp;</td>
                <%}%>
              </tr>
              <tr>
            <%}%>
                <td align="center">
                  <table>
                    <tr>
                      <td align="center" width="144" height="108">
                        <a href="<%=urlResolver.encodeURL(request, response, "viewpublicalbumitem?itemid=" + albumItemBean.getAlbumItemID())%>">
                          <%if (albumItemBean.getItemMimeType().equals(AlbumItemBean.ALBUMITEM_MEDIA_MIMETYPE_FLV)) {%>   
                            <img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/flash_player.gif" alt="<%=albumItemBean.getItemTitle()%>" border="0" />
                          <%}else if (albumItemBean.getItemMimeType().equals(AlbumItemBean.ALBUMITEM_MEDIA_MIMETYPE_WMV)) {%>
                            <img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/window_media_player.gif" alt="<%=albumItemBean.getItemTitle()%>" border="0" />
                          <%}else{%>
                            <img src="<%=urlResolver.encodeURL(request, response, "getalbumitem?itemid=" + albumItemBean.getAlbumItemID(), URLResolverService.ACTION_URL)%>" alt="<%=albumItemBean.getItemTitle()%>" border="0"<%if (albumItemBean.getItemWidth() == 0) {%> width="144" height="108"<%} else {%> width="<%=(albumItemBean.getItemWidth() > 144) ? 144 : albumItemBean.getItemWidth()%>"<%if (albumItemBean.getItemWidth() > 144 && albumItemBean.getItemHeight()*144/albumItemBean.getItemWidth() > 108) {%> height="108"<%}}%> />                            
                          <%}%>
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td align="center">&nbsp;
                        <a href="<%=urlResolver.encodeURL(request, response, "viewpublicalbumitem?itemid=" + albumItemBean.getAlbumItemID())%>">
                          <%=albumItemBean.getItemTitle()%>
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td align="center">
                        <span style="color:#808080;"><fmt:message key="mvnforum.common.albumitem.viewcount"/>: <%=albumItemBean.getItemViewCount()%></span><br/>
                        <%if (MVNForumEnterpriseConfig.getEnableAlbumItemRate()) {%>
                        <span style="color:#808080;"><fmt:message key="mvnforum.common.albumitem.votecount"/>: <%=albumItemBean.getItemVoteCount()%></span>
                        <ul class="star-rating">
                          <li class="current-rating" style="width: <%=currentRate%>%"></li>
                          <li><img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/blank.gif" alt="" /></li>
                          <li><img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/blank.gif" alt="" /></li>
                          <li><img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/blank.gif" alt="" /></li>
                          <li><img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/blank.gif" alt="" /></li>
                          <li><img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/blank.gif" alt="" /></li>
                        </ul>
                        <%}%>
                      </td>
                    </tr>
                  </table>
                </td>
            <%if ( (((i+1) % ALBUM_ITEMS_PER_ROW) == 0) || (iterator.hasNext() == false) ) {%>
              </tr>
            <%} //end if %>
          <%} //end for%>
            </table>
          </td>
        </tr>
      <%} // end else%>
      </table>
      </div>
    </td>
    <!-- End of Center section -->
  </tr>
</table>

<br/>

<%if (isAlbumPortlet == false) {%>
<%@ include file="footer.jsp"%>
<%}%>

</mvn:body>
</mvn:html>
</fmt:bundle>