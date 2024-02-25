<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/viewalbumx.jsp,v 1.87 2009/12/17 03:10:40 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.87 $
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
<%@ page import="com.mvnforum.MyUtil"%>
<%@ page import="com.mvnforum.db.MemberBean"%>
<%@ page import="com.mvnforum.enterprise.db.*"%>
<%@ page import="com.mvnforum.enterprise.MVNForumEnterpriseConfig"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<%@ include file="reload_page_when_back_button_clicked.jsp"%>

<%
AlbumBean albumBean = (AlbumBean) request.getAttribute("AlbumBean");
Collection albumItemBeans = (Collection) request.getAttribute("AlbumItemBeans");
MemberBean memberBean = (MemberBean) request.getAttribute("MemberBean");
int albumViewCount = ((Integer) request.getAttribute("AlbumViewCount")).intValue();
String videoMineType = "video";
%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.viewalbumx.title"/> - <%=albumBean.getAlbumTitle()%></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
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

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isAlbumPortlet == false) {%>
    <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}else{%>
    <a href="<%=urlResolver.encodeURL(request, response, "albumportlet", URLResolverService.ACTION_URL)%>"><fmt:message key="mvnforum.user.header.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "myalbums")%>"><fmt:message key="mvnforum.user.listalbumsx.my_albums"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.viewalbumx.title"/>: <%=albumBean.getAlbumTitle()%>
</div>
<br/>

<%@ include file="inc_album_bar.jsp"%>
<br />

<table align="center" width="95%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <!-- Left section -->
    <td valign="top" width="20%">
      <!-- Top Left section -->
      <table class="tborder" align="center" cellpadding="8" cellspacing="0" width="100%">
        <tr class="portlet-section-body">
          <td width="100%">
            <table width="100%" class="noborder">
              <tr>
                <td align="center">
                  <a href="<%=urlResolver.encodeURL(request, response, "uploadalbumavatar?albumid=" + albumBean.getAlbumID())%>">
                  <%if (albumBean.getAlbumAvatar().equals("")) {%>
                    <img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/photoleft.gif" width="160" height="160" border="0" alt="" />
                  <%} else { %>
                    <img src="<%=urlResolver.encodeURL(request, response, "getalbumavatar?albumid=" + albumBean.getAlbumID(), URLResolverService.ACTION_URL)%>" alt="" border="0" />
                  <%} %>
                  </a>
                </td>
              </tr>
              <tr>
                <td align="left">
                  <b><%=albumBean.getAlbumTitle()%></b><br />
                  <fmt:message key="mvnforum.common.numberof.photos"/>: <%=albumBean.getAlbumItemCount()%><br />
                  <fmt:message key="mvnforum.common.album.viewcount"/>: <%=albumViewCount%><br />
                  <%=onlineUser.getGMTDateFormat(albumBean.getAlbumCreationDate())%><br />
                  <fmt:message key="mvnforum.common.album.shareoption"/>:&nbsp;
                  <%if (albumBean.getAlbumShareOption() == AlbumBean.ALBUM_SHARE_OPTION_PRIVATE)   {%><font color="#FF0000"><fmt:message key="mvnforum.common.album.shareoption.private"/></font><%}%>
                  <%if (albumBean.getAlbumShareOption() == AlbumBean.ALBUM_SHARE_OPTION_PUBLIC)    {%><font color="#0000FF"><fmt:message key="mvnforum.common.album.shareoption.public"/></font><%}%>
                  <%if (albumBean.getAlbumShareOption() == AlbumBean.ALBUM_SHARE_OPTION_MYFRIENDS) {%><font color="#006600"><fmt:message key="mvnforum.common.album.shareoption.myfriends"/></font><%}%>
                </td>
              </tr>
              <tr>
                <td><hr/></td>
              </tr>
              <tr>
                <td>
                  <a href="<%=urlResolver.encodeURL(request, response, "editalbum?albumid=" + albumBean.getAlbumID())%>"><fmt:message key="mvnforum.user.editalbumx.title"/></a>
                  <br />
                  <a href="<%=urlResolver.encodeURL(request, response, "uploadalbumavatar?albumid=" + albumBean.getAlbumID())%>"><fmt:message key="mvnforum.user.uploadalbumavatarx.title"/></a>
                  <br />
                  <%--<%if (albumBean.getAlbumItemCount() != 0) {%>
                    <a href="#">Choose Album Cover</a>
                    <br />
                  <%} %>--%>
                  <a href="<%=urlResolver.encodeURL(request, response, "uploadphotos?albumid=" + albumBean.getAlbumID())%>"><fmt:message key="mvnforum.user.uploadphotosx.title"/></a>
                  <%if (albumBean.getAlbumID() != MVNForumEnterpriseConfig.getDefaultAlbumID()) {%>
                    <br />
                    <a href="<%=urlResolver.encodeURL(request, response, "deletealbum?albumid=" + albumBean.getAlbumID())%>"><fmt:message key="mvnforum.user.deletealbumx.title"/></a>
                  <%}%>
                </td>
              </tr>
              <%if (albumBean.getAlbumDesc().length() > 0) {%>
              <tr>
                <td><hr/></td>
              </tr>
              <tr>
                <td><%=albumBean.getAlbumDesc() %></td>
              </tr>
              <%}%>
            </table>
          </td>
        </tr>
      </table>
      <!-- end of Top Left section -->
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
                    <a class="command" href="<%=urlResolver.encodeURL(request, response, "changeavatar")%>">
                    <img height="60" src="<%=contextPath%>/mvnplugin/mvnforum/images/user/no_picture.gif" border="0" alt="<fmt:message key="mvnforum.user.myprofile.no_avatar"/>" title="<fmt:message key="mvnforum.user.myprofile.no_avatar"/>" />
                    </a>
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
      <table align="center" width="100%" class="tborder" cellpadding="2" cellspacing="0">
      <%if (albumItemBeans.size() == 0) {%>
        <tr class="portlet-section-body">
          <td>
            <a href="<%=urlResolver.encodeURL(request, response, "uploadphotos?albumid=" + albumBean.getAlbumID())%>">
            <img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/photoright.gif" width="168" height="126" border="0" alt="" /></a>
          </td>
        </tr>
      <%} else { %>
        <tr class="topmenu">
          <td width="100%">
            <input value="<fmt:message key="mvnforum.user.slideshowx.title"/>" class="portlet-form-button" type="button" onclick="javascript: window.open('<%=urlResolver.encodeURL(request, response, "slideshow?albumid=" + albumBean.getAlbumID() + "&amp;albumitemid=0", URLResolverService.ACTION_URL)%>', 'album', 'width=500,height=620');" />
            <input value="<fmt:message key="mvnforum.user.organizephotosx.title"/>" class="portlet-form-button" type="button" onclick="document.location.href='<%=urlResolver.encodeURL(request, response, "organizephotos?albumid=" + albumBean.getAlbumID())%>'" />
            <input value="<fmt:message key="mvnforum.user.editcaptionsx.title"/>" class="portlet-form-button" type="button" onclick="document.location.href='<%=urlResolver.encodeURL(request, response, "editcaptions?albumid=" + albumBean.getAlbumID())%>'" />
          </td>
        </tr>
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
                        <a href="<%=urlResolver.encodeURL(request, response, "viewalbumitem?itemid=" + albumItemBean.getAlbumItemID())%>">
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
                        <a href="<%=urlResolver.encodeURL(request, response, "viewalbumitem?itemid=" + albumItemBean.getAlbumItemID())%>">
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