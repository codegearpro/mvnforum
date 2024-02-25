<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/listpublicalbumsx.jsp,v 1.53 2009/12/17 03:10:40 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.53 $
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
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>

<%@ page import="net.myvietnam.mvncore.util.DateUtil" %>
<%@ page import="com.mvnforum.MVNForumResourceBundle" %>
<%@ page import="com.mvnforum.enterprise.db.AlbumBean" %>
<%@ page import="com.mvnforum.enterprise.db.AlbumItemTagBean" %>
<%@ page import="com.mvnforum.enterprise.MVNForumEnterpriseConfig"%>

<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<%@ include file="reload_page_when_back_button_clicked.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">

<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.listalbumsx.public_albums"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>

<style type="text/css">
.taglink:hover { color: #FFFFFF; text-decoration: none; background: #0063DC; }
.taglink:link { color: #3886E6; text-decoration: none;}
.taglink:visited { color: #3886E6; text-decoration: none;}
.taglink:hover { color: #FFFFFF; text-decoration: none; background: #0063DC; }
.taglink:active { color: #FFFFFF; text-decoration: none; background: #0259C4; }
</style>

</mvn:head>

<mvn:body>

<%if (isAlbumPortlet == false) {%>
    <%@ include file="header.jsp"%>
<%}else{%>
    <%@ include file="header_album.jsp"%>
<script type="text/JavaScript">
//<![CDATA[
function onSetAlbumDefault(url) {
  var msg = "<fmt:message key="mvnforum.user.listalbumsx.confirm_set_to_default_album"/>";
  var agree = confirm(msg);
  if (agree) {
    document.location.href=url;
  } else {
    document.location.href='#';
  }
}
//]]>
</script>
<%}%>
<br/>

<%
Collection albumBeans = (Collection) request.getAttribute("AlbumBeans");
String sort = (String) request.getAttribute("Sort");
String order = (String) request.getAttribute("Order");
String albumMemberName = (String) request.getAttribute("MemberName");
int totalAlbumBeans = ((Integer)request.getAttribute("TotalAlbums")).intValue();
int albumPerPage = AlbumBean.ALBUM_MAX_ROWS_TO_RETURN;
Collection albumItemTagBeans = (Collection) request.getAttribute("AlbumItemTags");
int minTagCount = ((Integer)request.getAttribute("MinTagCount")).intValue();
int maxTagCount = ((Integer)request.getAttribute("MaxTagCount")).intValue();
%>

<pg:pager
  url="listpublicalbums"
  items="<%=totalAlbumBeans%>"
  maxPageItems="<%=albumPerPage%>"
  isOffset="true"
  export="offset,currentPageNumber=pageNumber"
  scope="request">
  <pg:param name="sort"/>
  <pg:param name="order"/>

<%  try {
    //offset = ((Integer)request.getAttribute("offset")).intValue();
    offset = new Integer((String)request.getAttribute("offset"));
} catch (Exception e) {
    // do nothing
}
%>

<% String rowsType = MVNForumResourceBundle.getString(onlineUser.getLocale(), "mvnforum.common.numberof.albums"); %>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isAlbumPortlet == false) {%>
    <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
   <%}else{%>
    <a href="<%=urlResolver.encodeURL(request, response, "albumportlet", URLResolverService.ACTION_URL)%>"><fmt:message key="mvnforum.user.header.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <fmt:message key="mvnforum.user.listalbumsx.public_albums"/>
</div>
<br/>

<table width="95%" align="center" cellpadding="3" cellspacing="0">
  <tr>
    <td>
      <form action="<%=urlResolver.encodeURL(request, response, "listpublicalbums", URLResolverService.ACTION_URL)%>" <mvn:method/> >
      <%=urlResolver.generateFormAction(request, response, "listpublicalbums")%>
        <label for="sort"><fmt:message key="mvnforum.common.sort_by"/></label>
        <select id="sort" name="sort">
          <option value="AlbumCreationDate" <%if ("AlbumCreationDate".equals(sort)) {%> selected="selected" <%} %>><fmt:message key="mvnforum.common.album.creation_date"/></option>
          <option value="AlbumModifiedDate" <%if ("AlbumModifiedDate".equals(sort)) {%> selected="selected" <%} %>><fmt:message key="mvnforum.common.album.modified_date"/></option>
        </select>
        <label for="order"><fmt:message key="mvnforum.common.order"/></label>
        <select id="order" name="order">
          <option value="ASC" <%if ("ASC".equals(order)) {%> selected="selected" <%} %>><fmt:message key="mvnforum.common.ascending"/></option>
          <option value="DESC" <%if ("DESC".equals(order)) {%> selected="selected" <%} %>><fmt:message key="mvnforum.common.descending"/></option>
        </select>
        <input value="<fmt:message key="mvnforum.common.go"/>" class="liteoption" type="submit" />
        <input value="<%=albumMemberName%>" name="membername" type="hidden" />
        <input value="<%=offset%>" name="offset" type="hidden" />
    </form>
    </td>
  </tr>
</table>
<br />

<%
if(isAlbumPortlet == false){
if (albumItemTagBeans.size() != 0) {%>
<table width="95%" align="center" cellpadding="3" cellspacing="0">
  <tr class="portlet-section-body">
    <td width="100%" style="padding: 15px; border: solid 1px #eee; background: #f5f5f5;">
      <%
      int min_font = 12;
      int max_font = 37;
      float rate = 0;
      if ((maxTagCount - minTagCount) != 0) {
          rate = (max_font - min_font) / (maxTagCount - minTagCount);
      }
      System.out.println("-------maxTagCount " + maxTagCount);
      System.out.println("-------minTagCount " + minTagCount);
      System.out.println("-------rate " + rate);
      for (Iterator iter = albumItemTagBeans.iterator(); iter.hasNext(); ) {
          AlbumItemTagBean albumItemTagBean = (AlbumItemTagBean) iter.next();
          int albumItemTagCount = albumItemTagBean.getAlbumItemTagCount();
          float this_font = rate * (albumItemTagCount - minTagCount) + min_font;
          System.out.println("-------albumItemTagCount " + albumItemTagCount);
          System.out.println("-------this_font " + this_font);
      %>
      &nbsp;<a href="<%=urlResolver.encodeURL(request, response, "searchalbumitem?tagvalue=" + albumItemTagBean.getAlbumItemTagValue(), URLResolverService.ACTION_URL)%>" style="font-size: <%=this_font%>px;" class="taglink"><%=albumItemTagBean.getAlbumItemTagValue()%></a>&nbsp;
      <%} %>
      
      <div align="right"><a href="<%=urlResolver.encodeURL(request, response, "exploretags")%>" class="command"><fmt:message key="mvnforum.user.exploretagsx.title"/></a></div>
      
    </td>
  </tr>
</table>
<br />
<%}} %>

<table width="95%" align="center">
  <tr>
    <td>
      <%@ include file="inc_pager.jsp"%>
    </td>
  </tr>
</table>

<table class="tborder" align="center" cellpadding="3" cellspacing="0" width="95%">
  <tr class="topmenu">
    <td>
    <form action="<%=urlResolver.encodeURL(request, response, "searchalbumitem", URLResolverService.ACTION_URL)%>" name="searchform" id="searchform" <mvn:method/>>
    <%=urlResolver.generateFormAction(request, response, "searchalbumitem")%>
    <table align="center" cellpadding="3" cellspacing="0" width="100%" class="noborder">
      <tr>
        <td><fmt:message key="mvnforum.user.listalbumsx.public_albums"/></td>
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
  <tr class="portlet-section-body" style="font-family: Arial, Helvetica, sans-serif;
    background: #FFFFFF;
    font-size: 12px;
    line-height: 20px;">
    <td>
      <table width="100%" cellspacing="0" cellpadding="0" align="center" class="noborder">
        <%if (albumBeans.size() == 0) {%>
        <tr class="portlet-section-body">
          <td align="center"><fmt:message key="mvnforum.common.album.info.no_albums"/></td>
        </tr>
        <%} else { %>
        <tr class="portlet-section-body">
          <td width="100%">
          <%
          if (albumBeans != null) {
            int i = -1;
            int size= albumBeans.size();
            for (Iterator iterator = albumBeans.iterator(); iterator.hasNext(); ) {
                AlbumBean albumBean = (AlbumBean) iterator.next();
                i++; size--;
            %>
            <pg:item>
            <%if ((i%3) == 0) { %>
              <table width="100%" class="noborder">
                  <tr>
                    <td width="33%" align="center">
            <%} else { %>
                    <td width="33%" align="center">
            <%} %>
                  <table class="noborder">
                    <tr>
                      <td align="center" width="160" height="160">
                        <a href="<%=urlResolver.encodeURL(request, response, "viewpublicalbum?albumid=" + albumBean.getAlbumID())%>">
                          <%if (albumBean.getAlbumAvatar().equals("")) {%>
                            <img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/photoleft.gif" width="160" height="160" border="0" alt="" />
                          <%} else { %>
                            <img src="<%=urlResolver.encodeURL(request, response, "getalbumavatar?albumid=" + albumBean.getAlbumID(), URLResolverService.ACTION_URL)%>" alt="" border="0"/>
                          <%} %>
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td align="center">
                        <a style="color:#4D4D4D;font-weight:bold;text-decoration:none" href="<%=urlResolver.encodeURL(request, response, "viewpublicalbum?albumid=" + albumBean.getAlbumID())%>">
                          <%=albumBean.getAlbumTitle() %>
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td align="center" style="color:#808080;">
                        <fmt:message key="mvnforum.common.numberof.photos"/>: <%=albumBean.getAlbumItemCount()%> - 
                        <fmt:message key="mvnforum.common.album.viewcount"/>: <%=albumBean.getAlbumViewCount()%>
                      </td>
                    </tr>
                    <tr>
                      <td align="center" style="color:#808080">
                        <%=onlineUser.getGMTDateFormat(albumBean.getAlbumCreationDate())%>
                      </td>
                    </tr>
                    <%if (isPortlet && permission.canAdminSystem()) {%>
                      <tr>
                        <td align="center" style="color:#808080">
                          ID: <%=albumBean.getAlbumID() %> -
                          <%if (albumBean.getAlbumID() == MVNForumEnterpriseConfig.getDefaultAlbumID()) {%>
                            (<fmt:message key="mvnforum.user.listalbumsx.is_default_album"/>)
                          <%} else {%>
                            <a href="javascript:onSetAlbumDefault('<%=urlResolver.encodeURL(request, response, "setalbumdefaultprocess?albumid=" + albumBean.getAlbumID(), URLResolverService.ACTION_URL)%>');"><fmt:message key="mvnforum.user.listalbumsx.set_to_default_album"/></a>
                          <%}%>
                        </td>
                      </tr>
                    <%}%>
                  </table>
            <%if (((i%3) == 2) || (size == 0)) { %>
                  </td>
                 </tr>
               </table>
            <%} else { %>
               </td>
            <%}%>
          </pg:item>
          <%} //end for%>
        <%} %>
            </td>
          </tr>
        <%}//end else %>
       </table>
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
