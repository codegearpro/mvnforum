<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/editalbumitemtagx.jsp,v 1.38 2009/08/13 10:31:09 thonh Exp $
 - $Author: thonh $
 - $Revision: 1.38 $
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
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="java.util.*" %>
<%@ page import="com.mvnforum.enterprise.db.AlbumItemTagBean"%>
<%@ page import="com.mvnforum.enterprise.MVNForumEnterpriseConfig"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.admin.editalbumitemtagx.title" /></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<script src="<%=contextPath%>/mvnplugin/mvnforum/js/vietuni.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/js/md5.js"></script>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css" />
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">
<%@ include file="header.jsp"%>
<script type="text/javascript">
//<![CDATA[
function checkEnter(event) {
  var agt=navigator.userAgent.toLowerCase();

  // Maybe, Opera make an onclick event when user press enter key
  // on the text field of the form
  if (agt.indexOf('opera') >= 0) return;

  // enter key is pressed
  if (getKeyCode(event) == 13)
     SubmitFormEditTag();
}
function ValidateForm() {
  if (isBlank(document.submitform.AlbumItemTagDisplayName, "<fmt:message key="mvnforum.common.album_item_tag.displayname"/>")) return false;
  if (isBlank(document.submitform.MemberCurrentMatkhau, "<fmt:message key="mvnforum.common.prompt.current_password"/>")) {
      return false;
  }
  if (document.submitform.MemberCurrentMatkhau.value.length < 3) {
    alert("<fmt:message key="mvnforum.common.js.prompt.invalidlongpassword"/>");
    document.submitform.MemberCurrentMatkhau.focus();
    return false;
  }
  return true;
}
function SubmitFormEditTag() {
  if (ValidateForm() == true) {
    var enableEncrypted = <%=MVNForumConfig.getEnableEncryptPasswordOnBrowser()%>;
    if (enableEncrypted) {
      pw2md5(document.submitform.MemberCurrentMatkhau, document.submitform.md5pw);
    }
    <mvn:servlet>
      document.submitform.submitbutton.disabled=true;
    </mvn:servlet>
      document.submitform.submit();
  }
}
//]]>
</script>

<br />
<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isServlet) {%>
  <a href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "misctasks")%>"><fmt:message key="mvnforum.admin.misctasks.title"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "listalbumitemtags")%>"><fmt:message key="mvnforum.admin.listalbumitemtagsx.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.admin.editalbumitemtagx.title" />
</div>
<br/>

<%
AlbumItemTagBean albumItemTagBean = (AlbumItemTagBean) request.getAttribute("AlbumItemTagBean");
Map map = (Map) request.getAttribute("ChannelMap");
%>

<form action="<%=urlResolver.encodeURL(request, response, "editalbumitemtagprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform" onsubmit="return false;">
<%=urlResolver.generateFormAction(request, response, "editalbumitemtagprocess")%>
<mvn:securitytoken />
<input type="hidden" name="md5pw" value="" />
<input type="hidden" value="<%=albumItemTagBean.getAlbumItemTagID()%>" name="AlbumItemTagID" />
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.editalbumitemtagx.title" />:</td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td valign="top"><fmt:message key="mvnforum.common.album_item_tag.tagvalue" />:</td>
    <td nowrap="nowrap"><%=albumItemTagBean.getAlbumItemTagValue()%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td valign="top"><label for="AlbumItemTagDisplayName"><fmt:message key="mvnforum.common.album_item_tag.displayname" /><span class="requiredfield"> *</span></label></td>
    <td nowrap="nowrap"><input type="text" id="AlbumItemTagDisplayName" name="AlbumItemTagDisplayName" value="<%=albumItemTagBean.getAlbumItemTagDisplayName()%>" size="60" maxlength="60" onkeyup="initTyper(this);" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="AlbumItemTagType"><fmt:message key="mvnforum.common.album_item_tag.tagtype" /><span class="requiredfield"> *</span></label></td>
    <td>
      <select id="AlbumItemTagType" name="AlbumItemTagType">
        <option value="<%=AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_NORMAL%>" <%if (albumItemTagBean.getAlbumItemTagType() == AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_NORMAL){%> selected="selected"<%}%>><%=map.get(new Integer(AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_NORMAL))%></option>
        <% if (MVNForumEnterpriseConfig.getEnableAlbumTypeShopping()) { %>
        <option value="<%=AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_MAIN%>" <%if (albumItemTagBean.getAlbumItemTagType() == AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_MAIN){%> selected="selected"<%}%>><%=map.get(new Integer(AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_MAIN))%></option>
        <option value="<%=AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_CNMS%>" <%if (albumItemTagBean.getAlbumItemTagType() == AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_CNMS){%> selected="selected"<%}%>><%=map.get(new Integer(AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_CNMS))%></option>
        <option value="<%=AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_BEAUTY%>" <%if (albumItemTagBean.getAlbumItemTagType() == AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_BEAUTY){%> selected="selected"<%}%>><%=map.get(new Integer(AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_BEAUTY))%></option>
        <option value="<%=AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_KGS%>" <%if (albumItemTagBean.getAlbumItemTagType() == AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_KGS){%> selected="selected"<%}%>><%=map.get(new Integer(AlbumItemTagBean.ALBUM_ITEM_TAG_TYPE_KGS))%></option>
        <% } %>
      </select>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td valign="top"><fmt:message key="mvnforum.common.album_item_tag.tagcount" />:</td>
    <td nowrap="nowrap"><%=albumItemTagBean.getAlbumItemTagCount()%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="MemberCurrentMatkhau"><fmt:message key="mvnforum.common.prompt.current_password"/><span class="requiredfield"> *</span></label></td>
    <td><input type="password" id="MemberCurrentMatkhau" name="MemberCurrentMatkhau" size="30" onkeypress="checkEnter(event);" /></td>
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
      <input type="button" name="submitbutton" onclick="javascript: SubmitFormEditTag();" value="<fmt:message key="mvnforum.common.action.save"/>" class="portlet-form-button"/>
      <input type="reset" value="<fmt:message key="mvnforum.common.action.reset"/>" class="liteoption" />
    </td>
  </tr>
</mvn:cssrows>
</table>
</form>

<br/>
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>
