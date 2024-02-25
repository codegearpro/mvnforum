<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/editalbumitemx.jsp,v 1.47 2009/10/22 09:54:19 hoanglt Exp $
  - $Author: hoanglt $
  - $Revision: 1.47 $
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

<%@ page import="java.text.DecimalFormat"%>
<%@ page import="com.mvnforum.enterprise.db.AlbumBean"%>
<%@ page import="com.mvnforum.enterprise.db.AlbumItemBean"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<%
AlbumItemBean bean = (AlbumItemBean) request.getAttribute("AlbumItemBean");
AlbumBean albumBean = (AlbumBean) request.getAttribute("AlbumBean");
String tphcm = "TP Ho Chi Minh";// in cnms, should be tieng viet co dau
%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.editalbumitemx.title"/></mvn:title>
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
  return true;
}
<%if (albumBean.getAlbumType() == AlbumBean.ALBUM_TYPE_SHOPPING) {%>
function chooseCity(type) {
  if (type == 1) {
    document.submitform.City.value = '<%=tphcm%>';
    document.getElementById('_district').innerHTML = document.getElementById('_district1').innerHTML;  
  } else {
    document.submitform.City.value = '';
    document.getElementById('_district').innerHTML = document.getElementById('_district2').innerHTML;
    document.submitform.District.value = '';
  }
}
<%}%>
//]]>
</script>
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
  <fmt:message key="mvnforum.common.album"/>: <a href="<%=urlResolver.encodeURL(request, response, "viewalbum?albumid=" + albumBean.getAlbumID())%>"><%=albumBean.getAlbumTitle() %></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.common.albumitem"/>: <a href="<%=urlResolver.encodeURL(request, response, "viewalbumitem?itemid=" + bean.getAlbumItemID())%>">
    <% if (bean.getItemTitle().length() > 0) {%>
      <%=bean.getItemTitle() %></a>&nbsp;&raquo;&nbsp;
    <%} else {%>
      <fmt:message key="mvnforum.common.albumitem.untitled"/></a>&nbsp;&raquo;&nbsp;
    <%}%>
  <fmt:message key="mvnforum.user.editalbumitemx.title"/>
 </div>

<br />
<%if (albumBean.getAlbumType() == AlbumBean.ALBUM_TYPE_SHOPPING) {%>
<div id="_district1" style="display: none">
<%-- @ include file="district.jsp" --%>
</div>
<div id="_district2" style="display: none">
<input type="text" name="District" size="60" value="<%=bean.getItemShopDistrict()%>" onkeyup="initTyper(this);" />
</div>
<%}%>

<form action="<%=urlResolver.encodeURL(request, response, "editalbumitemprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "editalbumitemprocess")%>
<mvn:securitytoken />
<input type="hidden" name="ItemID" value="<%=bean.getAlbumItemID()%>" />
<mvn:cssrows>
<table width="95%" border="0" cellspacing="0" cellpadding="5" align="center" class="tborder">
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.user.editalbumitemx.title"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="Title"><fmt:message key="mvnforum.common.albumitem.title"/></label></td>
    <td><input type="text" id="Title" name="Title" size="60" value="<%=bean.getItemTitle()%>" onkeyup="initTyper(this);" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="Desc"><fmt:message key="mvnforum.common.albumitem.desc"/></label></td>
    <td><textarea id="Desc" name="Desc" rows="5" cols="60" onkeyup="initTyper(this);"><%=bean.getItemDesc()%></textarea></td>
  </tr>
  <%if (albumBean.getAlbumType() == AlbumBean.ALBUM_TYPE_SHOPPING) {%>
  <tr class="<mvn:cssrow/>">
    <td><label for="Address"><fmt:message key="mvnforum.common.albumitem.address"/></label></td>
    <td><input type="text" id="Address" name="Address" size="60" value="<%=bean.getItemShopAddress()%>" onkeyup="initTyper(this);" /></td>
  </tr>
<% boolean cityflag = tphcm.equals(bean.getItemShopCity()); %>
  <tr class="<mvn:cssrow/>">
    <td><label for="District"><fmt:message key="mvnforum.common.albumitem.district"/></label></td>
    <td>
      <div id="_district">
      <%if (cityflag && false) {%>
        <%-- @ include file="district.jsp" --%>
      <%} else {%>
        <input type="text" id="District" name="District" size="60" value="<%=bean.getItemShopDistrict()%>" onkeyup="initTyper(this);" />
      <%}%>
      </div>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="City"><fmt:message key="mvnforum.common.albumitem.city"/></label></td>
    <td>
      <input name="cityname" id="cityname" class="noborder" type="radio" onclick="chooseCity(1);"<%if (cityflag) {%> checked="checked"<%}%> />TP H&#7891; Ch&#237; Minh
      &nbsp;&nbsp;&nbsp; <input name="cityname" id="cityname" class="noborder" type="radio" onclick="chooseCity(2);"<%if (!cityflag) {%> checked="checked"<%}%> /> T&#7881;nh th&#224;nh kh&#225;c <br />
      <input type="text" id="City" name="City" size="60" value="<%=bean.getItemShopCity()%>" onkeyup="initTyper(this);"/>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="URL"><fmt:message key="mvnforum.common.albumitem.url"/></label></td>
    <td><input type="text" id="URL" name="URL" size="60" value="<%=bean.getItemURL()%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="Price"><fmt:message key="mvnforum.common.albumitem.price"/></label></td>
    <td>
      <%DecimalFormat format = new DecimalFormat("##,###");%>
      <input type="text" id="Price" name="Price" size="60" value="<%=format.format(bean.getItemPrice())%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="PriceUnit"><fmt:message key="mvnforum.common.albumitem.price_unit"/></label></td>
    <td>
      <input type="text" id="PriceUnit" name="PriceUnit" size="60" value="<%=bean.getItemPriceUnit()%>" onkeyup="initTyper(this);" />
    </td>
  </tr>
  <%}%>
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
    <td align="center" colspan="2">
      <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.common.action.save"/>" class="portlet-form-button" onclick="javascipt:SubmitForm()" />
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
