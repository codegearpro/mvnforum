<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/viewalbumitemx.jsp,v 1.113 2009/12/17 05:00:40 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.113 $
  - $Date: 2009/12/17 05:00:40 $
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

<%@ page import="java.util.*"%>
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
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/js/vietuni.js"></script>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
<%if (MVNForumEnterpriseConfig.getEnableAlbumItemRate()) {%>
<style type="text/css">
.star-rating li.current-rating{
  background: url(<%=contextPath%>/mvnplugin/mvnforum/images/album/star.gif) left center repeat-x;
  position: absolute;
  height: 25px;
  display: block;
  text-indent: -1000em;
  z-index: 1;
  left: 0px;
}
.star-rating{
  background: url(<%=contextPath%>/mvnplugin/mvnforum/images/album/star.gif) left top repeat-x;
  position:relative;
  width: 125px;
  height: 25px;
  overflow: hidden;
  list-style: none;
  margin: 0px;
  padding: 0px;
}
</style>
<%} %>
</mvn:head>
<mvn:body onunload="document.submitform.editbutton.disabled=false;">

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
float currentRate = 0;
if (itemBean.getItemVoteCount() != 0) {
    currentRate = (float) itemBean.getItemVoteTotalStars() / itemBean.getItemVoteCount()* 20;
}

int maxIndex = albumBean.getAlbumItemCount() - 1;
int minIndex = 0;
int itemID = itemBean.getAlbumItemID();
int nextItemID = ((Integer) request.getAttribute("NextItemID")).intValue();
int backItemID = ((Integer) request.getAttribute("BackItemID")).intValue();
int index = ((Integer) request.getAttribute("Index")).intValue();
%>

<script type="text/javascript">
//<![CDATA[
var currentRate;
function confirmDelete() {
  var msg;
  msg= "<fmt:message key="mvnforum.common.albumitem.question.question_delete"/>";
  var agree = confirm(msg);
  if (agree) {
    document.deleteform.submit();
  }
  return false;
}
var check = 0;
function show_hide() {
  if (check == 0) {
    document.getElementById('EditCaption').style.display = "";
    document.getElementById('EditCaptionLink').style.display = "none";
    check = 1;
  } else {
    document.getElementById('EditCaption').style.display = "none";
    document.getElementById('EditCaptionLink').style.display = "";
    check = 0;
  }
}
function submit() {
<mvn:servlet>
  document.submitform.editbutton.disabled=true;
</mvn:servlet>
  show_hide();
  document.submitform.submit();
}
var checkedittag = 0;
function show_hide_edittag() {
  if (checkedittag == 0) {
    document.getElementById('EditTag').style.display = "";
    document.getElementById('EditTagLink').style.display = "none";
    checkedittag = 1;
  } else {
    document.getElementById('EditTag').style.display = "none";
    document.getElementById('EditTagLink').style.display = "";
    checkedittag = 0;
  }
}
function submitedittag() {
  show_hide_edittag();
  document.edittagform.submit();
}
function updateVote(the_vote_chosen) {
    showDialog(the_vote_chosen, 450, 300);
    document.location.href = '<%=urlResolver.encodeURL(request, response, "viewalbumitem?itemid=" + itemBean.getAlbumItemID())%>';
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
  <fmt:message key="mvnforum.user.viewalbumitemx.title"/>
</div>
<br/>

<% String requestURI = "viewalbumitem"; %>
<%@ include file="inc_album_bar.jsp"%>
<br/>

<table align="center" border="0" cellpadding="0" cellspacing="0" width="95%">
  <tr>
    <!-- Left section -->
    <td valign="top" width="80%">
      <table class="tborder" cellpadding="4" cellspacing="0" width="100%">
        <tr class="topmenu">
          <td align="center">
            <input type="button" value="&lt;&lt; <fmt:message key="mvnforum.user.slideshowx.previous"/>" class="portlet-form-button"
                   <%if (index == minIndex) {%> disabled="disabled" <%}%>
                   onclick="document.location.href='<%=urlResolver.encodeURL(request, response, "viewalbumitem?itemid=" + backItemID)%>'" />
            <input type="button" value="<fmt:message key="mvnforum.user.slideshowx.next"/> &gt;&gt;" class="portlet-form-button"
                   <%if (index == maxIndex) {%> disabled="disabled" <%}%>
                   onclick="document.location.href='<%=urlResolver.encodeURL(request, response, "viewalbumitem?itemid=" + nextItemID)%>'" />
          </td>
        </tr>
        <tr class="portlet-section-body">
          <td>
            <table width="100%" cellspacing="0" cellpadding="0" class="noborder">
              <tr>
                <td align="center">
                <%if (itemBean.getItemMimeType().equals(AlbumItemBean.ALBUMITEM_MEDIA_MIMETYPE_FLV)) {%>   
                  <object type="application/x-shockwave-flash" data="<%=contextPath%>/mvnplugin/mvnforum/images/album/player.swf" width="500" height="450">
                    <param name="movie" value="<%=contextPath%>/mvnplugin/mvnforum/images/album/player.swf" />
                    <param name="FlashVars" value="flv=<%=MyUtil.filterForFlashPlayer(urlResolver.encodeURL(request, response, "getalbumitem?itemid=" + itemBean.getAlbumItemID(), URLResolverService.ACTION_URL))%>&amp;width=500&amp;height=450" />
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
                  <span id="EditCaptionLink">
                  <%if (itemBean.getItemTitle().equals("")) {%>
                    <a href="#" onclick="show_hide(); return false;"><fmt:message key="mvnforum.common.albumitem.command.add_caption"/></a>
                  <%} else {%>
                    <b><%=itemBean.getItemTitle()%></b> -
                    <a href="#" onclick="show_hide(); return false;"><fmt:message key="mvnforum.common.albumitem.command.edit_caption"/></a>
                  <%} %><br />
                  <%if (itemBean.getItemDesc().length() > 0) {%>
                    <%=itemBean.getItemDesc()%>
                  <%}%>
                  </span>
                  <form action="<%=urlResolver.encodeURL(request, response, "editcaption", URLResolverService.ACTION_URL)%>" method="post" name="submitform" id="submitform">
                    <%=urlResolver.generateFormAction(request, response, "editcaption")%>
                    <mvn:securitytoken />
                    <input name="AlbumID" value="<%=albumBean.getAlbumID()%>" type="hidden" />
                    <input name="ItemID" value="<%=itemBean.getAlbumItemID()%>" type="hidden" />
                    <table id="EditCaption" style="display: none">
                      <tr>
                        <td>
                          <textarea id="caption" name="caption" cols="50" rows="3" onkeyup="initTyper(this);"><%=itemBean.getItemTitle()%></textarea>
                        </td>
                      </tr>
                      <%if (currentLocale.equals("vi")) {/*vietnamese here*/%>
                      <tr>
                        <td>
                          <input type="radio" name="vnselector" id="TELEX" value="TELEX" onclick="setTypingMode(1);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.telex"/>&nbsp;&nbsp;&nbsp;&nbsp;
                          <input type="radio" name="vnselector" id="VNI" value="VNI" onclick="setTypingMode(2);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.vni"/>&nbsp;&nbsp;&nbsp;&nbsp;
                          <input type="radio" name="vnselector" id="VIQR" value="VIQR" onclick="setTypingMode(3);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.VIQR"/>&nbsp;&nbsp;&nbsp;&nbsp;
                          <input type="radio" name="vnselector" id="NOVN" value="NOVN" onclick="setTypingMode(0);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.not_use"/>
                          <script type="text/javascript">
                          //<![CDATA[
                          initVNTyperMode();
                          //]]>
                          </script>
                        </td>
                      </tr>
                      <%}// end if vietnamese%>
                      <tr>
                        <td align="center">
                          <input type="button" name="editbutton" value="<fmt:message key="mvnforum.common.action.save"/>" class="portlet-form-button" onclick="submit();" />
                          <input type="button" name="cancelbutton" value="<fmt:message key="mvnforum.common.action.cancel"/>" onclick="document.location.href='<%=urlResolver.encodeURL(request, response, "viewalbumitem?itemid=" + itemBean.getAlbumItemID())%>'" />
                        </td>
                      </tr>
                    </table>
                  </form>
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
                  <a class="command" href="<%=urlResolver.encodeURL(request, response, "changeavatar")%>">
                  <img height="60" src="<%=contextPath%>/mvnplugin/mvnforum/images/user/no_picture.gif" border="0" alt="<fmt:message key="mvnforum.user.myprofile.no_avatar"/>" title="<fmt:message key="mvnforum.user.myprofile.no_avatar"/>" />
                  </a>
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
          <td><fmt:message key="mvnforum.user.viewalbumitemx.photo_info"/></td>
        </tr>
        <tr class="portlet-section-body">
          <td>
            <table width="100%" cellspacing="0" cellpadding="1" align="center" class="noborder">
              <tr>
                <td>
                  <fmt:message key="mvnforum.common.albumitem"/> <%=index + 1%> <fmt:message key="mvnforum.common.of"/> <%=albumBean.getAlbumItemCount()%><br />
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
                  <br />
                  <a href="<%=urlResolver.encodeURL(request, response, "editalbumitem?itemid=" + itemBean.getAlbumItemID())%>"><fmt:message key="mvnforum.user.editalbumitemx.title"/></a>
                  <br />
                  <a href="<%=urlResolver.encodeURL(request, response, "setalbumcover?itemid=" + itemBean.getAlbumItemID() + "&amp;albumid=" + albumBean.getAlbumID(), URLResolverService.ACTION_URL)%>"><fmt:message key="mvnforum.common.albumitem.command.set_cover"/></a>
                  <br />
                  <%if (isAlbumPortlet == false) {%>
                  <%if (MVNForumEnterpriseConfig.getEnableAlbumItemPoll()) {%>
                    <% if (request.getAttribute("pollID") != null) {%>
                        <% if (permission.canManageAlbumItemPoll()) {%>
                          <a class="command" href="<%=urlResolver.encodeURL(request, response, "editalbumitempoll?poll=" + ((Integer)(request.getAttribute("pollID"))).intValue(), URLResolverService.RENDER_URL)%>"><img src="<%=imagePath%>/button_edit_poll.gif" border="0" alt="<fmt:message key="mvnforum.common.poll.command.edit_poll"/>" title="<fmt:message key="mvnforum.common.poll.command.edit_poll"/>" /></a>&nbsp;
                        <% } %>
                        <% if (permission.canManageAlbumItemPoll()) {%>
                          <a class="command" href="<%=urlResolver.encodeURL(request, response, "deletealbumitempoll?poll=" + ((Integer)(request.getAttribute("pollID"))).intValue(), URLResolverService.RENDER_URL)%>"><img src="<%=imagePath%>/button_delete_poll.gif" border="0" alt="<fmt:message key="mvnforum.user.deletepollx.title"/>" title="<fmt:message key="mvnforum.user.deletepollx.title"/>" /></a>
                        <% } %>
                    <% } else { %>
                        <% if (MVNForumConfig.getEnablePoll() && (permission.canManageAlbumItemPoll())) {  %>
                          <a href="<%=urlResolver.encodeURL(request, response, "addalbumitempoll?itemid=" + itemBean.getAlbumItemID())%>"><fmt:message key="mvnforum.common.albumitem.command.create_poll"/></a>
                        <% } %>
                    <% } %>
                  <br />
                  <%}}%>
                  
                  <form action="<%=urlResolver.encodeURL(request, response, "deletealbumitem", URLResolverService.ACTION_URL)%>" method="post" name="deleteform">
                    <%=urlResolver.generateFormAction(request, response, "deletealbumitem")%>
                    <mvn:securitytoken />
                    <input name="itemid" value="<%=itemBean.getAlbumItemID()%>" type="hidden" />
                    <input name="albumid" value="<%=itemBean.getAlbumID()%>" type="hidden" />
                  </form>
                  <a onclick="confirmDelete()" href="#"><fmt:message key="mvnforum.common.albumitem.command.delete_photo"/></a>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <br/>

      <table class="tborder" cellpadding="4" cellspacing="0" width="100%">
        <tr class="portlet-section-header">
          <td><fmt:message key="mvnforum.common.album_item_tag.info.current_tag"/></td>
        </tr>
        <tr class="portlet-section-body">
          <td align="center">
            <span id="EditTagLink">
            <%if (itemBean.getItemTag().equals("")) {%>
              <a href="#" onclick="javascript: show_hide_edittag(); return false;"><fmt:message key="mvnforum.common.album_item_tag.command.add_tag"/></a>
            <%} else {%>
              <b><%=itemBean.getItemTag()%></b><br />
              <a href="#" onclick="javascript: show_hide_edittag(); return false;"><fmt:message key="mvnforum.common.album_item_tag.command.edit_tag"/></a>
            <%} %>
            </span>
            <form action="<%=urlResolver.encodeURL(request, response, "editalbumitemtag", URLResolverService.ACTION_URL)%>" method="post" name="edittagform">
              <%=urlResolver.generateFormAction(request, response, "editalbumitemtag")%>
              <mvn:securitytoken />
              <input type="hidden" name="AlbumID" value="<%=albumBean.getAlbumID()%>" />
              <input type="hidden" name="ItemID" value="<%=itemBean.getAlbumItemID()%>" />
              <input type="hidden" name="ItemTag" value="<%=itemBean.getItemTag()%>" />
              <table id="EditTag" style="display: none" class="noborder">
                <tr>
                  <td>
                    <%Collection albumItemTagBeans = (Collection) request.getAttribute("AlbumItemTagBeans"); %>
                    <select name="tag">
                      <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                      <%for (Iterator iterator = albumItemTagBeans.iterator(); iterator.hasNext(); ) {
                          AlbumItemTagBean albumItemTagBean = (AlbumItemTagBean) iterator.next(); %>
                        <option value="<%=albumItemTagBean.getAlbumItemTagValue()%>" <%if (itemBean.getItemTag().equals(albumItemTagBean.getAlbumItemTagValue())) {%> selected="selected" <%}%>><%=albumItemTagBean.getAlbumItemTagDisplayName()%> - <%=albumItemTagBean.getAlbumItemTagChannelName()%></option>
                      <%}%>
                    </select>
                  </td>
                </tr>
                <tr>
                  <td>
                    <input type="button" name="editbutton" value="<fmt:message key="mvnforum.common.action.save"/>" class="portlet-form-button" onclick="javascript: submitedittag();" />
                    <input type="button" name="cancelbutton" value="<fmt:message key="mvnforum.common.action.cancel"/>" onclick="document.location.href='<%=urlResolver.encodeURL(request, response, "viewalbumitem?itemid=" + itemBean.getAlbumItemID())%>'" />
                  </td>
                </tr>
              </table>
            </form>
          </td>
        </tr>
      </table>
      <br/>
      
      <%if (MVNForumEnterpriseConfig.getEnableAlbumItemRate()) {%>
      <table class="tborder" cellpadding="4" cellspacing="0" width="100%">
        <tr class="portlet-section-header">
          <td><fmt:message key="mvnforum.common.albumitem.rate.photo_rate"/></td>
        </tr>
        <tr class="portlet-section-body">
          <td align="center">
            <ul class="star-rating">
              <li class="current-rating" style="width: <%=currentRate%>%"></li>
              <li><img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/blank.gif" alt="" /></li>
              <li><img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/blank.gif" alt="" /></li>
              <li><img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/blank.gif" alt="" /></li>
              <li><img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/blank.gif" alt="" /></li>
              <li><img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/blank.gif" alt="" /></li>
            </ul>
          </td>
        </tr>
      </table>
      <%}%>
    </td>
    <!-- End of Right section -->
  </tr>
</table>

<br/>
<%if (isAlbumPortlet == false) {%>
    <%@ include file="footer.jsp"%>
<%}%>

</mvn:body>
</mvn:html>
</fmt:bundle>