<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/uploadalbumavatarx.jsp,v 1.14 2009/10/16 09:46:26 hoanglt Exp $
  - $Author: hoanglt $
  - $Revision: 1.14 $
  - $Date: 2009/10/16 09:46:26 $
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

<%@ page import="com.mvnforum.enterprise.db.AlbumBean"%>
<%@ page import="com.mvnforum.enterprise.MVNForumEnterpriseConfig"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.uploadalbumavatarx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body onunload="document.submitform.upload.disabled=false;" onload="validateFile(document.submitform.photo);">

<%if (isAlbumPortlet == false) {%>
  <%@ include file="header.jsp"%>
<%}else{%>
  <%@ include file="header_album.jsp"%>
<%}%>
<br/>

<script type="text/javascript">
//<![CDATA[
function validateFile(field) {
  var notwhitespace = field.value.search(/\S+/g);
  if (notwhitespace >= 0) {
    if (verify(field.value)) {
      clearDisplayErrors(field);
      document.getElementById("upload").disabled=false;
    } else {
      invalidFileError(field);
    }
  } else {
    if (document.getElementById("msg_photo").innerHTML != "") {
      clearDisplayErrors(field);
    }
  }
}
function invalidFileError(field) {
  field.style.color = "#FF0000";
  document.getElementById("msg_photo").innerHTML = "&nbsp;* <fmt:message key="mvnforum.common.js.prompt.not_image_file"/>";
  document.getElementById("upload").disabled=true;
}
function clearDisplayErrors(field) {
  if (field) {
    document.getElementById("msg_photo").innerHTML = "";
    field.style.color = "#000000";
  }
}
function verify(str) {
  if (str.search(/\S+/g) >= 0) {
    var ext = str.toLowerCase().match(/\.[^.]+$/); // Match file extension.
    if ((ext) && (ext.length > 0)) {
      ext = ext.toString().slice(1); // Strip the "." character.
      var extensions = ["jpe", "jpg", "jpeg", "gif", "png", "bmp"];
      for (var i = 0; i < extensions.length; i++) {
        if (ext == extensions[i]) {
          return true;
        }
      }
    }
  }
  return false;
}
function validateForm(form) {
  if (verify(form.photo.value) == false) {
    alert("<fmt:message key="mvnforum.user.uploadphotosx.js.not_valid_images"/>");
  } else {
  <mvn:servlet>
    document.getElementById("upload").disabled=true;
    document.getElementById("cancel").disabled=true;
  </mvn:servlet>
    return true;
  }
  return false;
}
//]]>
</script>

<%
AlbumBean albumBean = (AlbumBean) request.getAttribute("AlbumBean");
long currentAlbumDiskSize = ((Long) request.getAttribute("CurrentAlbumDiskSize")).longValue();
%>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isAlbumPortlet == false) {%>
    <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}else{%>
    <a href="<%=urlResolver.encodeURL(request, response, "albumportlet", URLResolverService.ACTION_URL)%>"><fmt:message key="mvnforum.user.header.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "myalbums")%>"><fmt:message key="mvnforum.user.listalbumsx.my_albums"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.common.album"/>: <a href="<%=urlResolver.encodeURL(request, response, "viewalbum?albumid=" + albumBean.getAlbumID())%>"><%=albumBean.getAlbumTitle() %></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.uploadalbumavatarx.title"/>
</div>
<br/>

<form action="<%=urlResolver.encodeURL(request, response, "uploadalbumavatarprocess", URLResolverService.ACTION_URL)%>"
      method="post" name="submitform" enctype="multipart/form-data" onsubmit="return validateForm(this);">
<%=urlResolver.generateFormAction(request, response, "uploadalbumavatarprocess")%>
<mvn:securitytoken />
<input type="hidden" name="albumid" value="<%=albumBean.getAlbumID()%>" />
<mvn:cssrows>
<table class="tborder" align="center" cellpadding="3" cellspacing="0" width="95%">
  <tr class="portlet-section-header">
    <td><fmt:message key="mvnforum.user.uploadalbumavatarx.guide"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>
      <table width="100%" cellspacing="0" cellpadding="1" class="noborder">
        <tr>
          <td align="left">
            <input id="photo" type="file" name="photo" size="60" onchange="validateFile(this);" />
            <span id="msg_photo" class="portlet-msg-error"></span>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr class="portlet-section-footer">
    <td align="center">
      <input type="submit" id="upload" name="upload" value="<fmt:message key="mvnforum.common.action.upload"/>" class="portlet-form-button" />
      <input type="button" id="cancel" name="cancel" value="<fmt:message key="mvnforum.common.action.cancel"/>" class="liteoption" onclick="document.location.href='<%=urlResolver.encodeURL(request, response, "viewalbum?albumid=" + albumBean.getAlbumID())%>'" />
    </td>
  </tr>
</table>
</mvn:cssrows>
</form>

<br/>
<%if (isAlbumPortlet == false) {%>
    <%@ include file="footer.jsp"%>
<%}%>
</mvn:body>
</mvn:html>
</fmt:bundle>
