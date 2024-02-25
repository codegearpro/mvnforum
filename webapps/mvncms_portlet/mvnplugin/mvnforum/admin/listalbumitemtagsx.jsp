<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/listalbumitemtagsx.jsp,v 1.39 2009/08/13 10:31:09 thonh Exp $
  - $Author: thonh $
  - $Revision: 1.39 $
  - $Date: 2009/08/13 10:31:09 $
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

<%@ page import="java.util.*" %>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter"%>
<%@ page import="net.myvietnam.mvncore.security.SecurityUtil" %>
<%@ page import="com.mvnforum.enterprise.db.AlbumItemTagBean"%>
<%@ page import="com.mvnforum.MVNForumResourceBundle" %>
<%@ page import="com.mvnforum.enterprise.MVNForumEnterpriseConfig"%>

<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name" /> - <fmt:message key="mvnforum.admin.listalbumitemtagsx.title"/></mvn:title>
  <%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
  <script src="<%=contextPath%>/mvnplugin/mvnforum/js/vietuni.js" type="text/javascript"></script>
  <link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css" />
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">
<%@ include file="header.jsp"%>
<br />
<%
Collection albumItemTags = (Collection) request.getAttribute("AlbumItemTags");
String sort = (String) request.getAttribute("Sort");
String order = (String) request.getAttribute("Order");
int totalAlbumItemTagBeans = ((Integer)request.getAttribute("TotalAlbumItemTags")).intValue();
int albumItemTagPerPage = onlineUser.getPostsPerPage();
Map map = (Map) request.getAttribute("ChannelMap");
%>
<script type="text/javascript">
//<![CDATA[
function ValidateForm() {
  if (isBlank(document.submitform.AlbumItemTagValue, "<fmt:message key="mvnforum.common.album_item_tag.tagvalue"/>")) return false;
  if (isBlank(document.submitform.AlbumItemTagDisplayName, "<fmt:message key="mvnforum.common.album_item_tag.displayname"/>")) return false;
  return true;
}
function SubmitFormAddTag() {
  if (ValidateForm() == true) {
    <mvn:servlet>
      document.submitform.submitbutton.disabled=true;
    </mvn:servlet>
      document.submitform.submit();
  }
}
function confirmDelete(deleteLink) {
  var msg;
  msg= "<fmt:message key="mvnforum.admin.listalbumitemtagsx.js.confirm_delete"/>";
  var agree = confirm(msg);
  if (agree) {
    document.location.href=deleteLink;
  } else {
    document.location.href='#';
  }
}
//]]>
</script>
<pg:pager
  url="listalbumitemtags"
  items="<%=totalAlbumItemTagBeans%>"
  maxPageItems="<%=albumItemTagPerPage%>"
  isOffset="true"
  export="offset,currentPageNumber=pageNumber"
  scope="request">
  <pg:param name="sort"/>
  <pg:param name="order"/>

<% String rowsType = MVNForumResourceBundle.getString(onlineUser.getLocale(), "mvnforum.common.numberof.tags"); %>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isServlet) {%>
  <a href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "misctasks")%>"><fmt:message key="mvnforum.admin.misctasks.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.admin.listalbumitemtagsx.title" />
</div>
<br />

<div class="pagedesc">
  <fmt:message key="mvnforum.admin.listalbumitemtagsx.info"/>
</div>
<br />

<form action="<%=urlResolver.encodeURL(request, response, "addalbumitemtagprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "addalbumitemtagprocess")%>
<mvn:securitytoken />
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.listalbumitemtagsx.add_tag" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="tagvalue"><fmt:message key="mvnforum.common.album_item_tag.tagvalue" /><span class="requiredfield"> *</span></label> </td>
    <td>
      <input type="text" name="AlbumItemTagValue" id="tagvalue" size="60" maxlength="60" />&nbsp;&nbsp;&nbsp;
      <fmt:message key="mvnforum.common.album_item_tag.tagvalue.rule" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="displayname"><fmt:message key="mvnforum.common.album_item_tag.displayname" /><span class="requiredfield"> *</span></label> </td>
    <td>
      <input type="text" name="AlbumItemTagDisplayName" id="displayname" size="60" maxlength="60" onkeyup="initTyper(this);" />&nbsp;&nbsp;&nbsp;
      <fmt:message key="mvnforum.common.album_item_tag.displayname.rule" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="AlbumItemTagType"><fmt:message key="mvnforum.common.album_item_tag.tagtype" /><span class="requiredfield"> *</span></label> </td>
    <td>
      <select id="AlbumItemTagType" name="AlbumItemTagType">
        <option value="<%=AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_NORMAL%>"><%=map.get(new Integer(AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_NORMAL))%></option>
        <% if (MVNForumEnterpriseConfig.getEnableAlbumTypeShopping()) { %>
        <option value="<%=AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_MAIN%>"><%=map.get(new Integer(AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_MAIN))%></option>
        <option value="<%=AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_CNMS%>"><%=map.get(new Integer(AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_CNMS))%></option>
        <option value="<%=AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_BEAUTY%>"><%=map.get(new Integer(AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_BEAUTY))%></option>
        <option value="<%=AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_KGS%>"><%=map.get(new Integer(AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_KGS))%></option>
        <% } %>
      </select>
    </td>
  </tr>
<%
if (currentLocale.equals("vi")) {/*vietnamese here*/
%>
  <tr class="<mvn:cssrow/>">
    <td valign="top" nowrap="nowrap"><fmt:message key="mvnforum.common.vietnamese_type"/>:</td>
    <td>
      <input type="radio" name="vnselector" id="TELEX" value="TELEX" onclick="setTypingMode(1);" class="noborder" /> <fmt:message key="mvnforum.common.vietnamese_type.telex"/>&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" name="vnselector" id="VNI" value="VNI" onclick="setTypingMode(2);" class="noborder" /> <fmt:message key="mvnforum.common.vietnamese_type.vni"/>&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" name="vnselector" id="VIQR" value="VIQR" onclick="setTypingMode(3);" class="noborder" /> <fmt:message key="mvnforum.common.vietnamese_type.VIQR"/><br/>
      <input type="radio" name="vnselector" id="NOVN" value="NOVN" onclick="setTypingMode(0);" class="noborder" /> <fmt:message key="mvnforum.common.vietnamese_type.not_use"/>
      <script type="text/javascript">
      //<![CDATA[
      initVNTyperMode();
      //]]>
      </script>
    </td>
  </tr>
<%
}// end if vietnamese
%>
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <input type="button" name="submitbutton" onclick="javascript: SubmitFormAddTag();" value="<fmt:message key="mvnforum.common.action.add" />" class="portlet-form-button" /> 
      <input type="reset" value="<fmt:message key="mvnforum.common.action.reset" />" class="liteoption" />
    </td>
  </tr>
</mvn:cssrows>
</table>
</form>
<br />

<table width="95%" align="center">
  <tr>
    <td>
      <%@ include file="inc_pager.jsp"%>
    </td>
  </tr>
</table>

<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td align="center"><fmt:message key="mvnforum.common.album_item_tag.tagvalue" /></td>
    <td align="center"><fmt:message key="mvnforum.common.album_item_tag.displayname" /></td>
    <% if (MVNForumEnterpriseConfig.getEnableAlbumTypeShopping()) { %>
    <td align="center"><fmt:message key="mvnforum.common.album_item_tag.tagtype" /></td>
    <% } %>
    <td align="center"><fmt:message key="mvnforum.common.album_item_tag.tagcount" /></td>
    <td align="center"><fmt:message key="mvnforum.common.album_item_tag.creationdate" /></td>
    <td align="center"><fmt:message key="mvnforum.common.album_item_tag.modifieddate" /></td>
    <td align="center"><fmt:message key="mvnforum.common.action.edit" /></td>
    <td align="center"><fmt:message key="mvnforum.common.action.delete" /></td>
  </tr>
<%
    for (Iterator iter = albumItemTags.iterator(); iter.hasNext(); ) {
        AlbumItemTagBean albumItemTag = (AlbumItemTagBean)iter.next();
%>
  <pg:item>
  <tr class="<mvn:cssrow/>">
    <td align="center"><%= DisableHtmlTagFilter.filter(albumItemTag.getAlbumItemTagValue()) %></td>
    <td align="center"><%= DisableHtmlTagFilter.filter(albumItemTag.getAlbumItemTagDisplayName()) %></td>
    <% if (MVNForumEnterpriseConfig.getEnableAlbumTypeShopping()) { %>
    <td align="center"><%= map.get(new Integer(albumItemTag.getAlbumItemTagType()))%></td>
    <% } %>
    <td align="center"><%= albumItemTag.getAlbumItemTagCount()%></td>
    <td align="center"><%= onlineUser.getGMTTimestampFormat(albumItemTag.getAlbumItemTagCreationDate())%></td>
    <td align="center"><%= onlineUser.getGMTTimestampFormat(albumItemTag.getAlbumItemTagModifiedDate())%></td>
    <td align="center">
      <a class="command" href="<%=urlResolver.encodeURL(request, response, "editalbumitemtag?tagID=" + albumItemTag.getAlbumItemTagID())%>"><fmt:message key="mvnforum.common.action.edit" /></a>
    </td>
    <td align="center">
      <%if (albumItemTag.getAlbumItemTagCount() == 0) {%>
        <a class="command" onclick="confirmDelete('<%=urlResolver.encodeURL(request, response, "deletealbumitemtagprocess?tagID=" + albumItemTag.getAlbumItemTagID() + "&amp;mvncoreSecurityToken=" + SecurityUtil.getSessionToken(request), URLResolverService.ACTION_URL)%>');return false;" href="#"><fmt:message key="mvnforum.common.action.delete" /></a>
      <%} %>
    </td>
  </tr>
  </pg:item>
<%
}//for
if (albumItemTags.size() == 0) {
%>
  <tr class="<mvn:cssrow/>"><td colspan="<%if (MVNForumEnterpriseConfig.getEnableAlbumTypeShopping()) {%>8<%}else{%>7<%}%>" align="center"><fmt:message key="mvnforum.admin.listalbumitemtagsx.no_tags" /></td></tr>
<% } %>
</mvn:cssrows>
</table>

<table width="95%" align="center">
  <tr>
    <td>
      <%@ include file="inc_pager.jsp"%>
    </td>
  </tr>
</table>

</pg:pager>
<br />

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>
