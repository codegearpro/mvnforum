<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/viewpublicalbumitemx.jsp,v 1.81 2009/12/17 03:10:40 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.81 $
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
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="com.mvnforum.MyUtil"%>
<%@ page import="com.mvnforum.db.*"%>
<%@ page import="com.mvnforum.enterprise.MVNForumEnterpriseConfig"%>
<%@ page import="com.mvnforum.enterprise.db.*"%>
<%@ page import="com.mvnforum.user.UserModuleConfig"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<%@ include file="reload_page_when_back_button_clicked.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.viewalbumitemx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
<%if (MVNForumEnterpriseConfig.getEnableAlbumItemRate()) {%>
<style type="text/css">
.star-rating,
.star-rating a:hover,
.star-rating a:active,
.star-rating a:focus,
.star-rating .current-rating{
  background: url(<%=contextPath%>/mvnplugin/mvnforum/images/album/star.gif) left -1000px repeat-x;
}
.star-rating{
  position:relative;
  width:122px;
  height:25px;
  overflow:hidden;
  list-style:none;
  margin:0;
  padding:0;
  background-position: left top;
}
.star-rating li{
  display: inline;
}
.star-rating a,
.star-rating .current-rating{
  position:absolute;
  top:0;
  left:0;
  text-indent:-1000em;
  height:25px;
  line-height:25px;
  outline:none;
  overflow:hidden;
  border: none;
}
.star-rating a:hover,
.star-rating a:active,
.star-rating a:focus{
  background-position: left bottom;
}
.star-rating a.one-star{
  width:20%;
  z-index:6;
}
.star-rating a.two-stars{
  width:40%;
  z-index:5;
}
.star-rating a.three-stars{
  width:60%;
  z-index:4;
}
.star-rating a.four-stars{
  width:80%;
  z-index:3;
}
.star-rating a.five-stars{
  width:100%;
  z-index:2;
}
.star-rating .current-rating{
  z-index:1;
  background-position: left center;
}
/* smaller star */
.small-star{
  width:122px;
  height:20px;
}
.small-star,
.small-star a:hover,
.small-star a:active,
.small-star a:focus,
.small-star .current-rating{
  background-image: url(<%=contextPath%>/mvnplugin/mvnforum/images/album/star.gif);
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
AlbumItemBean itemBean = (AlbumItemBean) request.getAttribute("AlbumItemBean");
AlbumBean albumBean = (AlbumBean) request.getAttribute("AlbumBean");
MemberBean memberBean = (MemberBean)request.getAttribute("MemberBean");
int itemViewCount = ((Integer) request.getAttribute("ItemViewCount")).intValue();

int maxIndex = albumBean.getAlbumItemCount() - 1;
int minIndex = 0;
int itemID = itemBean.getAlbumItemID();
int nextItemID = ((Integer) request.getAttribute("NextItemID")).intValue();
int backItemID = ((Integer) request.getAttribute("BackItemID")).intValue();
int index = ((Integer) request.getAttribute("Index")).intValue();
float currentRate = 0;
if (itemBean.getItemVoteCount() != 0) {
    currentRate = (float) itemBean.getItemVoteTotalStars() / itemBean.getItemVoteCount()* 20;
}
%>
<div style="display:none">
  <span id="currentRate_this"><%=currentRate%>%</span>
  <span id="voteCount_this"><%=itemBean.getItemVoteCount()%></span>
  <span id="voteTotalStars_this"><%=itemBean.getItemVoteTotalStars()%></span>
</div>
<script type="text/javascript">
//<![CDATA[
var currentRate;
function updateVote(the_vote_chosen) {
<% if (isPortlet) { %>
   document.location.href = the_vote_chosen;
<%} else { %>           
   showDialog(the_vote_chosen, 450, 300);
  //document.location.href = '<%=urlResolver.encodeURL(request, response, "viewpublicalbumitem?itemid=" + itemBean.getAlbumItemID())%>';
<%} %>
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
  <a href="<%=urlResolver.encodeURL(request, response, "listpublicalbums")%>"><fmt:message key="mvnforum.user.listalbumsx.public_albums"/></a>&nbsp;&raquo;&nbsp;
  <%if (MVNForumEnterpriseConfig.getEnableShowAlbumMember()) {%> 
    <a href="<%=urlResolver.encodeURL(request, response, "listpublicalbums?membername=" + memberBean.getMemberName())%>"><%=memberBean.getMemberName()%></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <fmt:message key="mvnforum.common.album"/>: <a href="<%=urlResolver.encodeURL(request, response, "viewpublicalbum?albumid=" + albumBean.getAlbumID())%>"><%=albumBean.getAlbumTitle() %></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.viewalbumitemx.title"/>
</div>
<br/>

<table align="center" border="0" cellpadding="0" cellspacing="0" width="95%">
  <tr>
    <!-- Left section -->
    <td valign="top" width="80%">
        <table class="tborder" cellpadding="4" cellspacing="0" width="100%">
          <tr class="topmenu">
            <td>
              <form action="<%=urlResolver.encodeURL(request, response, "searchalbumitem", URLResolverService.ACTION_URL)%>" name="searchform" <mvn:method/>>
              <%=urlResolver.generateFormAction(request, response, "searchalbumitem")%>
                <table class="noborder" cellpadding="0" cellspacing="0" width="100%">
                  <tr class="topmenu">
                    <td align="left">
                      <input type="button" value="&lt;&lt; <fmt:message key="mvnforum.user.slideshowx.previous"/>" class="portlet-form-button"
                        <%if (index == minIndex) {%> disabled="disabled" <%} %>
                        onclick="document.location.href='<%=urlResolver.encodeURL(request, response, "viewpublicalbumitem?itemid=" + backItemID)%>'" />
                      <input type="button" value="<fmt:message key="mvnforum.user.slideshowx.next"/> &gt;&gt;" class="portlet-form-button"
                        <%if (index == maxIndex) {%> disabled="disabled" <%} %>
                        onclick="document.location.href='<%=urlResolver.encodeURL(request, response, "viewpublicalbumitem?itemid=" + nextItemID)%>'" />
                    </td>
                    <td align="right">
                      <input type="hidden" name="searchScope" value="PublicAlbums" />
                      <input type="hidden" name="page" value="PublicAlbums" />
                      <input type="text" name="searchString" />
                      <input value="<fmt:message key="mvnforum.common.action.search_photos"/>" class="portlet-form-button" type="submit" />
                    </td>
                  </tr>
                </table>
            </form>
          </td>
        </tr>

        <tr class="portlet-section-body">
          <td>
            <table width="100%" class="noborder" cellspacing="0" cellpadding="0">
              <tr>
                <td align="center">
                  <%if (itemBean.getItemMimeType().equals(AlbumItemBean.ALBUMITEM_MEDIA_MIMETYPE_FLV)) {%>   
                    <object type="application/x-shockwave-flash" data="<%=contextPath%>/mvnplugin/mvnforum/images/album/player.swf" width="500" height="450">
                      <param name="movie" value="<%=contextPath%>/mvnplugin/mvnforum/images/album/player.swf" />
                      <param name="FlashVars" value="flv=<%=MyUtil.filterForFlashPlayer(urlResolver.encodeURL(request, response, "getalbumitem?itemid=" + itemBean.getAlbumItemID(), URLResolverService.ACTION_URL))%>&amp;width=500&amp;height=450" />
                    </object>
                  <%}else if (itemBean.getItemMimeType().equals(AlbumItemBean.ALBUMITEM_MEDIA_MIMETYPE_WMV)) {%>
                    <embed src="<%=urlResolver.encodeURL(request, response, "getalbumitem?itemid=" + itemBean.getAlbumItemID(), URLResolverService.ACTION_URL)%>" width="500" height="450" EnableContextMenu="0" AutoStart="0" loop="1" ShowStatusBar="1" ShowControls="1"></embed>
                  <%}else{%>
                    <img src="<%=urlResolver.encodeURL(request, response, "getalbumitem?itemid=" + itemBean.getAlbumItemID(), URLResolverService.ACTION_URL)%>" alt="<%=itemBean.getItemTitle()%>" border="0" width="<%=((itemBean.getItemWidth() > 640) || (itemBean.getItemWidth() == 0)) ? 640 : itemBean.getItemWidth()%>" />
                  <%}%>
                </td>
              </tr>
              <tr>
                <td align="center">
                  <b><%=itemBean.getItemTitle()%></b><br />
                  <%if (itemBean.getItemDesc().length() > 0) {%>
                    <%=itemBean.getItemDesc()%>
                  <%}%>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
    <!-- End of left section -->

    <td style="width: 5px;">&nbsp;&nbsp;</td>

    <!-- Right section -->
    <td valign="top" width="20%">
    <%if (MVNForumEnterpriseConfig.getEnableShowAlbumMember()) {%>
      <table class="tborder" cellpadding="4" cellspacing="0" width="100%">
        <tr class="portlet-section-body">
          <td>
            <table width="100%" cellspacing="0" cellpadding="0" class="noborder">
              <tr>
                <% if (MVNForumConfig.getEnableAvatar()) { %>
                <td width="50" align="center" valign="middle">
                  <% if (memberBean.getMemberAvatar().length() > 0) { %>
                  <img height="60" src="<%=memberBean.getMemberAvatar_processed(request, response)%>" border="0" alt="<fmt:message key="mvnforum.user.myprofile.has_avatar"/>" title="<fmt:message key="mvnforum.user.myprofile.has_avatar"/>" />
                  <% } else { %>
                  <img height="60" src="<%=contextPath%>/mvnplugin/mvnforum/images/user/no_picture.gif" border="0" alt="<fmt:message key="mvnforum.user.myprofile.no_avatar"/>" title="<fmt:message key="mvnforum.user.myprofile.no_avatar"/>" />
                  <% } %>
                </td>
                <% } //enable avatar%>
                <td>&nbsp;<b><%=albumBean.getMemberName()%></b></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <br/>
    <%}%>

      <table class="tborder" cellpadding="4" cellspacing="0" width="100%">
        <tr class="portlet-section-header">
          <td align="left"><fmt:message key="mvnforum.user.viewalbumitemx.photo_info"/></td>
        </tr>
        <tr class="portlet-section-body">
          <td>
            <table width="100%" class="noborder" cellspacing="0" cellpadding="1" align="center">
              <tr>
                <td>
                  <fmt:message key="mvnforum.common.albumitem"/> <%=index + 1 %> <fmt:message key="mvnforum.common.of"/> <%=albumBean.getAlbumItemCount() %><br />
                  <fmt:message key="mvnforum.common.album"/>: <%=albumBean.getAlbumTitle()%><br />
                <%if (itemBean.getItemDesc().length() > 0) {%>
                  <%=itemBean.getItemDesc()%><br />
                <%}%>
                <% if (albumBean.getAlbumType() == AlbumBean.ALBUM_TYPE_SHOPPING) {
                    DecimalFormat format = new DecimalFormat("##,###");
                %>
                  <fmt:message key="mvnforum.common.albumitem.price"/>: <%=format.format(itemBean.getItemPrice())%> VN&#272;<br />
                  <% if (itemBean.getItemPriceUnit().length() > 0) { %>
                  <fmt:message key="mvnforum.common.albumitem.price_unit"/>: <%=itemBean.getItemPriceUnit()%><br />
                  <% } %>
                  <fmt:message key="mvnforum.common.albumitem.address"/>: <%=itemBean.getItemShopAddress() %>, <%=itemBean.getItemShopDistrict() %>, <%=itemBean.getItemShopCity() %><br />
                <%}%>
                  <fmt:message key="mvnforum.common.date.create_date"/>: <%=onlineUser.getGMTDateFormat(itemBean.getItemCreationDate())%><br />
                  <%if ( (itemBean.getItemMimeType().equals(AlbumItemBean.ALBUMITEM_MEDIA_MIMETYPE_FLV) == false) &&
                         (itemBean.getItemMimeType().equals(AlbumItemBean.ALBUMITEM_MEDIA_MIMETYPE_WMV) == false) ) {%>
                    <%=itemBean.getItemWidth()%>x<%=itemBean.getItemHeight()%> pixels - 
                  <%}%>
                  <%=itemBean.getItemFileSize()/1024 %>KB<br />
                  <fmt:message key="mvnforum.common.albumitem.viewcount"/>: <%=itemViewCount%><br />
                  <fmt:message key="mvnforum.common.albumitem.downloadcount"/>: <%=itemBean.getItemDownloadCount()%><br />
                <% if (MVNForumEnterpriseConfig.getEnableAlbumItemRate()) { %>
                  <fmt:message key="mvnforum.common.albumitem.votecount"/>: <%=itemBean.getItemVoteCount()%>
                <% } %>
                </td>
              </tr>
              <tr>
                <td><hr/></td>
              </tr>
              <tr>
                <td>
                  <a href="<%=urlResolver.encodeURL(request, response, "downloadalbumitem?itemid=" + itemBean.getAlbumItemID(), URLResolverService.ACTION_URL)%>"><fmt:message key="mvnforum.common.albumitem.command.download_photo"/></a>
                  <br />
                  <a href="#" onclick="window.open('<%=urlResolver.encodeURL(request, response, "slideshow?albumid=" + albumBean.getAlbumID() + "&amp;albumitemid=" + itemBean.getAlbumItemID(), URLResolverService.ACTION_URL)%>', 'album', 'width=500,height=620');"><fmt:message key="mvnforum.user.slideshowx.title"/></a>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <br/>
    
      <%if (request.getAttribute("pollID") != null) { %>
      <table class="tborder" cellpadding="4" cellspacing="0" width="100%">
        <tr class="portlet-section-header">
          <td align="left"><fmt:message key="mvnforum.common.poll"/></td>
        </tr>
        <tr class="portlet-section-body">
          <td>
            <%if (isServlet) { %>
              <jsp:include page="<%=UserModuleConfig.getUrlPattern()%>">
                <jsp:param name="nameOfURI" value="/votealbumitempoll_" />
                <jsp:param name="itemid" value="<%=itemID%>" />
              </jsp:include>
            <%} else { %>
              <jsp:include page="preparevotealbumitempoll.jsp"/>
            <%} %>
          </td>
        </tr>
      </table>
      <br />
      <%}%>
          
      <table class="tborder" cellpadding="4" cellspacing="0" width="100%">
        <tr class="portlet-section-header">
          <td align="left"><fmt:message key="mvnforum.common.album_item_tag.info.current_tag"/></td>
        </tr>
        <tr class="portlet-section-body">
          <td>
            <%if (itemBean.getItemTag().length() > 0) {%>
              <b><%=itemBean.getItemTag()%></b>
            <%} else {%>
              <center>
              <fmt:message key="mvnforum.common.album_item_tag.info.no_tag"/>
              </center>
            <%}%>
          </td>
        </tr>
      </table>
      <br/>
      
      <%if (MVNForumEnterpriseConfig.getEnableAlbumItemRate()) {%>
      <form action="<%=urlResolver.encodeURL(request, response, "ratealbumitemprocess?itemid=" + itemBean.getAlbumItemID(), URLResolverService.ACTION_URL)%>" method="post" name="voteform">
      <%=urlResolver.generateFormAction(request, response, "ratealbumitemprocess")%>
        <table class="tborder" cellpadding="4" cellspacing="0" width="100%">
          <tr class="portlet-section-header">
            <td><fmt:message key="mvnforum.common.albumitem.rate.photo_rate"/></td>
          </tr>
          <tr class="portlet-section-body">
            <td align="center">
              <mvn:securitytoken />
                <ul class="star-rating small-star">
                  <li id="currentRate" class="current-rating"></li>
                  <li><a href="#" onclick="updateVote('<%=urlResolver.encodeURL(request, response, "ratealbumitemprocess?itemid=" + itemBean.getAlbumItemID() + "&amp;votepoint=1", URLResolverService.ACTION_URL)%>');return false;" title="1 star out of 5" class="one-star"></a></li>
                  <li><a href="#" onclick="updateVote('<%=urlResolver.encodeURL(request, response, "ratealbumitemprocess?itemid=" + itemBean.getAlbumItemID() + "&amp;votepoint=2", URLResolverService.ACTION_URL)%>');return false;" title="2 stars out of 5" class="two-stars"></a></li>
                  <li><a href="#" onclick="updateVote('<%=urlResolver.encodeURL(request, response, "ratealbumitemprocess?itemid=" + itemBean.getAlbumItemID() + "&amp;votepoint=3", URLResolverService.ACTION_URL)%>');return false;" title="3 stars out of 5" class="three-stars"></a></li>
                  <li><a href="#" onclick="updateVote('<%=urlResolver.encodeURL(request, response, "ratealbumitemprocess?itemid=" + itemBean.getAlbumItemID() + "&amp;votepoint=4", URLResolverService.ACTION_URL)%>');return false;" title="4 stars out of 5" class="four-stars"></a></li>
                  <li><a href="#" onclick="updateVote('<%=urlResolver.encodeURL(request, response, "ratealbumitemprocess?itemid=" + itemBean.getAlbumItemID() + "&amp;votepoint=5", URLResolverService.ACTION_URL)%>');return false;" title="5 stars out of 5" class="five-stars"></a></li>
                </ul>
                <input type="hidden" name="itemid" value="" />
                <input type="hidden" name="votepoint" value="" />
            </td>
          </tr>
        </table>
      </form>
      <%}%>
    </td>
    <!-- End of Right section -->
  </tr>
</table>
<br/>

<%if (MVNForumEnterpriseConfig.getEnableAlbumItemRate()) {%>
<script type="text/JavaScript">
//<![CDATA[
  currentRate = document.getElementById('currentRate');
  currentRate.style.width = document.getElementById('currentRate_this').innerHTML;
//]]>
</script>
<%} %>

<%if (isAlbumPortlet == false) {%>
<%@ include file="footer.jsp"%>
<%}%>
</mvn:body>
</mvn:html>
</fmt:bundle>