<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/deletealbumx.jsp,v 1.40 2009/10/22 09:54:19 hoanglt Exp $
  - $Author: hoanglt $
  - $Revision: 1.40 $
  - $Date: 2009/10/22 09:54:19 $
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

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.deletealbumx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/js/md5.js"></script>
<script type="text/javascript">
//<![CDATA[
function checkEnter(event) {
  var agt=navigator.userAgent.toLowerCase();

  // Maybe, Opera make an onclick event when user press enter key
  // on the text field of the form
  if (agt.indexOf('opera') >= 0) return;

  // enter key is pressed
  if (getKeyCode(event) == 13)
    SubmitForm();
}

function SubmitForm() {
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

function ValidateForm() {
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
//]]>
</script>

<%if (isAlbumPortlet == false) {%>
  <%@ include file="header.jsp"%>
<%}else{%>
  <%@ include file="header_album.jsp"%>
<%}%>
<br/>

<%
AlbumBean albumBean = (AlbumBean) request.getAttribute("AlbumBean");
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
  <fmt:message key="mvnforum.user.deletealbumx.title"/>
</div>
<br/>

<form action="<%=urlResolver.encodeURL(request, response, "deletealbumprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform" id="submitform" onsubmit="return false;">
<%=urlResolver.generateFormAction(request, response, "deletealbumprocess")%>
<mvn:securitytoken />
<input value="<%=albumBean.getAlbumID()%>" name="AlbumID" type="hidden" />
<input type="hidden" name="md5pw" value="" />
<mvn:cssrows>
  <table class="tborder" align="center" cellpadding="3" cellspacing="0" width="95%">
    <tr class="portlet-section-header">
      <td colspan="2"><fmt:message key="mvnforum.user.deletealbumx.prompt"/></td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td><fmt:message key="mvnforum.common.album.title"/></td>
      <td><%=albumBean.getAlbumTitle()%></td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td><fmt:message key="mvnforum.common.album.desc"/></td>
      <td><%=albumBean.getAlbumDesc()%></td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td><fmt:message key="mvnforum.common.album.shareoption"/></td>
      <td>
        <%if (albumBean.getAlbumShareOption() == AlbumBean.ALBUM_SHARE_OPTION_PRIVATE)   {%><font color="#FF0000"><fmt:message key="mvnforum.common.album.shareoption.private"/></font><%} %>
        <%if (albumBean.getAlbumShareOption() == AlbumBean.ALBUM_SHARE_OPTION_PUBLIC)    {%><font color="#0000FF"><fmt:message key="mvnforum.common.album.shareoption.public"/></font><%} %>
        <%if (albumBean.getAlbumShareOption() == AlbumBean.ALBUM_SHARE_OPTION_MYFRIENDS) {%><font color="#FFFF00"><fmt:message key="mvnforum.common.album.shareoption.myfriends"/></font><%} %>
      </td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td><fmt:message key="mvnforum.common.numberof.photos"/></td>
      <td><b><%=albumBean.getAlbumItemCount()%></b></td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td width="30%"><label for="MemberCurrentMatkhau"><fmt:message key="mvnforum.common.prompt.current_password"/><span class="requiredfield"> *</span></label></td>
      <td><input type="password" id="MemberCurrentMatkhau" name="MemberCurrentMatkhau" onkeypress="checkEnter(event);" /></td>
    </tr>
    <tr class="portlet-section-footer">
      <td colspan="2" align="center">
        <input name="submitbutton" class="portlet-form-button" type="button" value="<fmt:message key="mvnforum.common.action.delete"/>" onclick="javascript:SubmitForm();" />&nbsp;
        <input name="Cancel" value="<fmt:message key="mvnforum.common.action.cancel"/>" class="liteoption" type="reset" onclick="document.location.href='<%=urlResolver.encodeURL(request, response, "viewalbum?albumid=" + albumBean.getAlbumID())%>'" />
      </td>
    </tr>
  </table>
</mvn:cssrows>
</form>

<br />
<%if (isAlbumPortlet == false) {%>
    <%@ include file="footer.jsp"%>
<%}%>
</mvn:body>
</mvn:html>
</fmt:bundle>
