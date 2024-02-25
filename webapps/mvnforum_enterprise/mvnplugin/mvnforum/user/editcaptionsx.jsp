<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/editcaptionsx.jsp,v 1.46 2009/12/17 05:00:40 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.46 $
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
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="java.util.*"%>
<%@ page import="com.mvnforum.enterprise.db.AlbumBean"%>
<%@ page import="com.mvnforum.enterprise.db.AlbumItemBean"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<%@ include file="reload_page_when_back_button_clicked.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.editcaptionsx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<script src="<%=contextPath%>/mvnplugin/mvnforum/js/vietuni.js" type="text/javascript"></script>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton1.disabled=false; document.submitform.submitbutton2.disabled=false;">
<script type="text/javascript">
//<![CDATA[
function SubmitForm() {
<mvn:servlet>
  document.submitform.submitbutton1.disabled=true;
  document.submitform.submitbutton2.disabled=true;
</mvn:servlet>
  document.submitform.submit();
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
  <fmt:message key="mvnforum.user.editcaptionsx.title"/>
</div>
<br/>

<form action="<%=urlResolver.encodeURL(request, response, "editcaptionsprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "editcaptionsprocess")%>
<mvn:securitytoken />
<input name="AlbumID" value="<%=bean.getAlbumID() %>" type="hidden" />
<mvn:cssrows>
<table width="95%" border="0" cellspacing="0" cellpadding="5" align="center" class="tborder">
  <tr class="portlet-section-footer">
    <td align="center">
      <input type="submit" name="submitbutton1" value="<fmt:message key="mvnforum.common.action.save"/>" class="portlet-form-button" onclick="javascipt:SubmitForm()" />
      <input type="reset" value="<fmt:message key="mvnforum.common.action.reset"/>" class="liteoption" />
    </td>
  </tr>
  <%
  Collection albumItemBeans = (Collection) request.getAttribute("AlbumItemBeans");
  AlbumItemBean albumItemBean;
  for (Iterator iterator = albumItemBeans.iterator(); iterator.hasNext(); ) {
      albumItemBean = (AlbumItemBean) iterator.next();
  %>
  <tr class="<mvn:cssrow/>">
    <td>
      <table class="noborder">
        <tr>
          <td width="200">
            <img src="<%=urlResolver.encodeURL(request, response, "getalbumitem?itemid=" + albumItemBean.getAlbumItemID(), URLResolverService.ACTION_URL)%>" alt="<%=albumItemBean.getItemTitle()%>" border="0"<%if (albumItemBean.getItemWidth() == 0) {%> width="144" height="108"<%} else {%> width="<%=(albumItemBean.getItemWidth() > 144) ? 144 : albumItemBean.getItemWidth()%>"<%if (albumItemBean.getItemWidth() > 144 && albumItemBean.getItemHeight()*144/albumItemBean.getItemWidth() > 108) {%> height="108"<%}}%> />
          </td>
          <td>&nbsp;</td>
          <td>
            <textarea name="item_<%=albumItemBean.getAlbumItemID()%>" cols="120" rows="5" onkeyup="initTyper(this);"><%=albumItemBean.getItemTitle()%></textarea>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <%}%>
  <%if (currentLocale.equals("vi")) {/*vietnamese here*/%>
    <tr class="<mvn:cssrow/>">
      <td>
        <fmt:message key="mvnforum.common.vietnamese_type"/>:<br/>
        <input type="radio" name="vnselector" id="TELEX" value="TELEX" onclick="setTypingMode(1);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.telex"/>&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="radio" name="vnselector" id="VNI" value="VNI" onclick="setTypingMode(2);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.vni"/>&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="radio" name="vnselector" id="VIQR" value="VIQR" onclick="setTypingMode(3);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.VIQR"/>
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
    <td align="center">
      <input type="button" name="submitbutton2" value="<fmt:message key="mvnforum.common.action.save"/>" class="portlet-form-button" onclick="javascipt:SubmitForm()" />
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
