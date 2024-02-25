<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/editalbumx.jsp,v 1.50 2009/10/22 09:54:19 hoanglt Exp $
  - $Author: hoanglt $
  - $Revision: 1.50 $
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
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="com.mvnforum.enterprise.db.AlbumBean"%>
<%@ page import="com.mvnforum.enterprise.MVNForumEnterpriseConfig"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.editalbumx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<script src="<%=contextPath%>/mvnplugin/mvnforum/js/vietuni.js" type="text/javascript"></script>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">

<script type="text/javascript">
//<![CDATA[
function SubmitForm() {
  if (ValidateForm() == true) {
    <mvn:servlet>
      document.submitform.submitbutton.disabled=true;
    </mvn:servlet>
    document.submitform.submit();
  }
}
function ValidateForm() {
  if (isBlank(document.submitform.AlbumTitle, "<fmt:message key="mvnforum.common.album.title"/>")) return false;
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
AlbumBean bean = (AlbumBean) request.getAttribute("AlbumBean");
%>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isAlbumPortlet == false) {%>
    <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}else{%>
    <a href="<%=urlResolver.encodeURL(request, response, "albumportlet", URLResolverService.ACTION_URL)%>"><fmt:message key="mvnforum.user.header.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "myalbums")%>"><fmt:message key="mvnforum.user.listalbumsx.my_albums"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.common.album"/>: <a href="<%=urlResolver.encodeURL(request, response, "viewalbum?albumid=" + bean.getAlbumID())%>"><%=bean.getAlbumTitle() %></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.editalbumx.title"/>
</div>
<br/>

<form action="<%=urlResolver.encodeURL(request, response, "editalbumprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "editalbumprocess")%>
<mvn:securitytoken />
<input value="<%=bean.getAlbumID() %>" name="AlbumID" type="hidden" />
<mvn:cssrows>
  <table class="tborder" align="center" cellpadding="3" cellspacing="0" width="95%">
    <tr class="portlet-section-header">
      <td colspan="2"><fmt:message key="mvnforum.user.editalbumx.title"/></td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td><fmt:message key="mvnforum.common.album.name"/></td>
      <td><b><%=bean.getAlbumName()%></b></td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td><label for="AlbumTitle"><fmt:message key="mvnforum.common.album.title"/><span class="requiredfield"> *</span></label></td>
      <td><input type="text" id="AlbumTitle" name="AlbumTitle" size="60" value="<%=bean.getAlbumTitle()%>" onkeyup="initTyper(this);" /></td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td><label for="AlbumDesc"><fmt:message key="mvnforum.common.album.desc"/></label></td>
      <td><textarea id="AlbumDesc" name="AlbumDesc" rows="5" cols="60" onkeyup="initTyper(this);"><%=bean.getAlbumDesc()%></textarea></td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td><label for="AlbumShareOption"><fmt:message key="mvnforum.common.album.shareoption"/></label></td>
      <td>
        <select id="AlbumShareOption" name="AlbumShareOption">
          <option value="<%=AlbumBean.ALBUM_SHARE_OPTION_PRIVATE %>" <%if (bean.getAlbumShareOption() == AlbumBean.ALBUM_SHARE_OPTION_PRIVATE) {%> selected="selected" <%} %>><fmt:message key="mvnforum.common.album.shareoption.private"/></option>
          <option value="<%=AlbumBean.ALBUM_SHARE_OPTION_PUBLIC %>" <%if (bean.getAlbumShareOption() == AlbumBean.ALBUM_SHARE_OPTION_PUBLIC) {%> selected="selected" <%} %>><fmt:message key="mvnforum.common.album.shareoption.public"/></option>
          <%-- option value="<%=AlbumBean.ALBUM_SHARE_OPTION_MYFRIENDS %>" <%if (bean.getAlbumShareOption() == AlbumBean.ALBUM_SHARE_OPTION_MYFRIENDS) {%> selected="selected" <%} %>><fmt:message key="mvnforum.common.album.shareoption.myfriends"/></option --%>
        </select>
      </td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td><label for="AlbumType"><fmt:message key="mvnforum.common.album.type"/></label></td>
      <td>
        <select id="AlbumType" name="AlbumType">
          <option value="<%=AlbumBean.ALBUM_TYPE_NORMAL%>" <%if (bean.getAlbumType() == AlbumBean.ALBUM_TYPE_NORMAL) {%> selected="selected" <%} %>><fmt:message key="mvnforum.common.album.type.normal"/></option>
          <% if (MVNForumEnterpriseConfig.getEnableAlbumTypeShopping()) { %>
          <option value="<%=AlbumBean.ALBUM_TYPE_SHOPPING%>" <%if (bean.getAlbumType() == AlbumBean.ALBUM_TYPE_SHOPPING) {%> selected="selected" <%} %>><fmt:message key="mvnforum.common.album.type.shopping"/></option>
          <% } %>
        </select>
      </td>
    </tr>
    <%if (currentLocale.equals("vi")) {/*vietnamese here*/%>
    <tr class="<mvn:cssrow/>">
      <td valign="top" nowrap="nowrap"><fmt:message key="mvnforum.common.vietnamese_type"/>:</td>
      <td>
        <input type="radio" name="vnselector" id="TELEX" value="TELEX" onclick="setTypingMode(1);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.telex"/>&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="radio" name="vnselector" id="VNI" value="VNI" onclick="setTypingMode(2);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.vni"/>&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="radio" name="vnselector" id="VIQR" value="VIQR" onclick="setTypingMode(3);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.VIQR"/><br/>
        <input type="radio" name="vnselector" id="NOVN" value="NOVN" onclick="setTypingMode(0);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.not_use"/>
        <script type="text/javascript">
        //<![CDATA[
        initVNTyperMode();
        //]]>
        </script>
      </td>
    </tr>
    <%}// end if vietnamese%>
    <tr class="portlet-section-footer">
      <td colspan="2" align="center">
        <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.common.action.save"/>" class="portlet-form-button" onclick="javascipt:SubmitForm()" />&nbsp;
        <input type="reset" value="<fmt:message key="mvnforum.common.action.reset"/>" class="liteoption" />
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
