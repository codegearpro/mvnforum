<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/uploadphotosx.jsp,v 1.45 2009/10/28 06:58:42 hoanglt Exp $
  - $Author: hoanglt $
  - $Revision: 1.45 $
  - $Date: 2009/10/28 06:58:42 $
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
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.uploadphotosx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body onunload="document.submitform.upload.disabled=false;" onload="onloadForm(document.submitform);">

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
      document.getElementById("upload").disabled = false;
    } else {
      invalidFileError(field);
    }
  } else {
    if (document.getElementById("msg_" + field.name).innerHTML != "") {
      clearDisplayErrors(field);
    }
  }
}
function invalidFileError(field) {
  if (document.getElementById("clearall").disabled) {
    document.getElementById("clearall").disabled = false;
  }
  field.style.color = "#FF0000";
  document.getElementById("msg_" + field.name).innerHTML = "&nbsp;* <fmt:message key="mvnforum.common.js.prompt.not_image_file"/>";
  document.getElementById("upload").disabled = true;
}
function clearDisplayErrors(field) {
  if (field) {
    document.getElementById("msg_" + field.name).innerHTML = "";
    field.style.color = "#000000";
  } else {
    var f = document.getElementById("addalbumform");
    for (var i = 0; i < f.elements.length; i++) {
      var field = f.elements[i];
      if (field.type != 'file') continue;
      if (document.getElementById("msg_" + field.name).innerHTML != "") {
        document.getElementById("msg_" + field.name).innerHTML = "";
        field.style.color = "#000000";
      }
    }
  }
}
function verify(str) {
  if (str.search(/\S+/g) >= 0) {
    var ext = str.toLowerCase().match(/\.[^.]+$/); // Match file extension.
    if ((ext) && (ext.length > 0)) {
      ext = ext.toString().slice(1); // Strip the "." character.
      var extensions = ["jpe", "jpg", "jpeg", "gif", "png", "bmp", "wmv", "flv"];
      for (var i = 0; i < extensions.length; i++) {
        if (ext == extensions[i]) {
          return true;
        }
      }
    }
  }
  return false;
}
function resetForm() {
  var f = document.getElementById("addalbumform");
  f.reset();
  for (var i = 0; i < f.elements.length; i++) {
    e = f.elements[i];
    e.disabled = false;
    if (e.type == 'file' && e.value != '') {
      location.reload(true);
    }
  }
  clearDisplayErrors();
  document.getElementById("upload").disabled = false;
  document.getElementById("clearall").disabled = false;
}
function validateForm(form) {
  var badfilecount = 0;
  for (var i = 0; i < form.elements.length; i++) {
    var field = form.elements[i];
    if (field.type != 'file' || field.value.match(/^\s*$/)) continue;
    if (verify(field.value)) {
      continue;
    } else {
      badfilecount++;
    }
  }
  if (badfilecount) {
    alert("<fmt:message key="mvnforum.user.uploadphotosx.js.not_valid_images"/>");
  } else {
  <mvn:servlet>
    document.getElementById("upload").disabled = true;
    document.getElementById("clearall").disabled = true;
    document.getElementById("cancel").disabled = true;
  </mvn:servlet>
    return true;
  }
  return false;
}
function onloadForm(form) {
  for (var i = 0; i < form.elements.length; i++) {
    var field = form.elements[i];
    if (field.type != 'file' || field.value.match(/^\s*$/)) continue;
    if (verify(field.value)) {
      clearDisplayErrors(field);
      document.getElementById("upload").disabled = false;
    } else {
      invalidFileError(field);
    }
  }
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
    <fmt:message key="mvnforum.user.uploadphotosx.title"/>
  </div>
<br/>

<div class="pagedesc">
  <b><fmt:message key="mvnforum.user.uploadphotosx.guide.title"/>:</b><br />
  <fmt:message key="mvnforum.user.uploadphotosx.guide.file_type"/><br />
  <fmt:message key="mvnforum.user.uploadphotosx.guide.max_album_size"/>: <% if (MVNForumEnterpriseConfig.getMaxAlbumDiskSize() > 0) {%><%=((MVNForumEnterpriseConfig.getMaxAlbumDiskSize()/1024) > 0 ? ((MVNForumEnterpriseConfig.getMaxAlbumDiskSize()/1024) + "KB") : (MVNForumEnterpriseConfig.getMaxAlbumDiskSize() + " bytes"))%><%}else{%><fmt:message key="mvnforum.user.uploadphotosx.guide.unlimited"/><%}%><br />
  <fmt:message key="mvnforum.user.uploadphotosx.guide.max_albumitem_size"/>: <% if (MVNForumEnterpriseConfig.getMaxAlbumItemAttachmentSize() >= 0) {%><%=((MVNForumEnterpriseConfig.getMaxAlbumItemAttachmentSize()/1024) > 0 ? ((MVNForumEnterpriseConfig.getMaxAlbumItemAttachmentSize()/1024) + "KB") : (MVNForumEnterpriseConfig.getMaxAlbumItemAttachmentSize() + " bytes"))%><%}else{%><fmt:message key="mvnforum.user.uploadphotosx.guide.unlimited"/><%}%><br />
  <fmt:message key="mvnforum.user.uploadphotosx.guide.max_width"/>: <% if (MVNForumEnterpriseConfig.getMaxAlbumItemWidth() > 0) {%><%=MVNForumEnterpriseConfig.getMaxAlbumItemWidth()%> pixels<%}else{%><fmt:message key="mvnforum.user.uploadphotosx.guide.unlimited"/><%}%><br />
  <fmt:message key="mvnforum.user.uploadphotosx.guide.max_height"/>: <% if (MVNForumEnterpriseConfig.getMaxAlbumItemHeight() > 0) {%><%=MVNForumEnterpriseConfig.getMaxAlbumItemHeight()%> pixels<%}else{%><fmt:message key="mvnforum.user.uploadphotosx.guide.unlimited"/><%}%><br />
  <% if (MVNForumEnterpriseConfig.getMaxAlbumDiskSize() > 0) {%>
  <b><fmt:message key="mvnforum.user.uploadphotosx.info.current_album_disk_size"/>:</b> <%=((currentAlbumDiskSize/1024) > 0 ? ((currentAlbumDiskSize/1024) + "KB") : (currentAlbumDiskSize + " bytes"))%>
  <% } %>
</div>
<br/>

<form action="<%=urlResolver.encodeURL(request, response, "uploadphotosprocess", URLResolverService.ACTION_URL)%>"
      method="post" name="submitform" id="addalbumform" enctype="multipart/form-data" onsubmit="return validateForm(this);">
<%=urlResolver.generateFormAction(request, response, "uploadphotosprocess")%>
<mvn:securitytoken />
<input type="hidden" name="albumid" value="<%=albumBean.getAlbumID()%>" />
<mvn:cssrows>
<table class="tborder" align="center" cellpadding="3" cellspacing="0" width="95%">
  <tr class="portlet-section-header">
    <td><fmt:message key="mvnforum.user.uploadphotosx.select_photos_to_upload"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>
      <table width="100%" cellspacing="0" cellpadding="1" class="noborder">
        <tr>
          <td align="left">
            <input id="photo1" type="file" name="photo1" size="60" onchange="validateFile(this);" />
            <span id="msg_photo1" class="portlet-msg-error"></span>
          </td>
        </tr>
        <tr>
          <td align="left">
            <input id="photo2" type="file" name="photo2" size="60" onchange="validateFile(this);" />
            <span id="msg_photo2" class="portlet-msg-error"></span>
          </td>
        </tr>
        <tr>
          <td align="left">
            <input id="photo3" type="file" name="photo3" size="60" onchange="validateFile(this);" />
            <span id="msg_photo3" class="portlet-msg-error"></span>
          </td>
        </tr>
        <tr>
          <td align="left">
            <input id="photo4" type="file" name="photo4" size="60" onchange="validateFile(this);" />
            <span id="msg_photo4" class="portlet-msg-error"></span>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr class="portlet-section-footer">
    <td align="center">
      <input type="submit" id="upload" name="upload" value="<fmt:message key="mvnforum.common.action.upload"/>" class="portlet-form-button" />
      <input type="reset" id="clearall" name="clearall" value="<fmt:message key="mvnforum.common.action.reset"/>" class="liteoption" onclick="resetForm();" />
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
