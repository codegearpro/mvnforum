<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/exploretagsx.jsp,v 1.19 2009/07/16 03:28:22 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.19 $
  - $Date: 2009/07/16 03:28:22 $
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
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page errorPage="fatalerror.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="net.myvietnam.mvncore.util.DateUtil"%>
<%@ page import="com.mvnforum.enterprise.db.AlbumItemTagBean"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">

<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.exploretagsx.title"/></mvn:title>
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
<%@ include file="header.jsp"%>
<br/>
<%
Collection albumItemTagBeans = (Collection) request.getAttribute("AlbumItemTags");
int minTagCount = ((Integer)request.getAttribute("MinTagCount")).intValue();
int maxTagCount = ((Integer)request.getAttribute("MaxTagCount")).intValue();
%>
<script type="text/JavaScript">
//<![CDATA[
function submitForm() {
  if (isBlank(document.searchform.tagvalue, "<fmt:message key="mvnforum.common.album_item_tag.tagvalue"/>") == false) {
    document.searchform.submit();
  }
}
//]]>
</script>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.exploretagsx.title"/>
</div>
<br/>

<%if (albumItemTagBeans.size() != 0) {%>
<form action="<%=urlResolver.encodeURL(request, response, "searchalbumitem", URLResolverService.ACTION_URL)%>" name="searchform" <mvn:method/>>
 <%=urlResolver.generateFormAction(request, response, "searchalbumitem")%>
  <table width="95%" align="center" cellpadding="3" cellspacing="0">
    <tr class="portlet-section-body">
       <td width="100%" style="border: solid 1px #eee; background: #f5f5f5;">
       <table align="center" cellpadding="3" cellspacing="0" width="95%">
          <tr>
            <td>
              <label for="tagvalue"><fmt:message key="mvnforum.user.exploretagsx.jump_to_tag"/></label>
              <input type="text" id="tagvalue" name="tagvalue" value="" onkeydown="if (event.keyCode==13) submitForm();" />
              <input value="<fmt:message key="mvnforum.common.go"/>" class="portlet-form-button" type="button" onclick="javascript: submitForm();" />
            </td>
          </tr>
        </table>
        </td>
    </tr>
  </table>
</form>
<br />

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
    </td>
  </tr>
</table>
<br />
<%} %>

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>
