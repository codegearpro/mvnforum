<%--
  - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/listcontents_mode_1.jsp,v 1.11 2009/12/14 04:42:42 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.11 $
  - $Date: 2009/12/14 04:42:42 $
  -
  - ====================================================================
  -
  - Copyright (C) 2005-2008 by MyVietnam.net
  -
  - MyVietnam.net PROPRIETARY/CONFIDENTIAL PROPERTIES. Use is subject to license terms.
  - You CANNOT use this software unless you receive a written permission from MyVietnam.net
  -
  - @author: MyVietnam.net developers
  -
--%>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page session="false" errorPage="fatalerror.jsp"%>

<%@ page import="java.util.*" %>
<%@ page import="com.mvnsoft.mvncms.db.*" %>
<%@ page import="com.mvnsoft.mvncms.cds.standard.StandardCDSUtil" %>

<%@ include file="inc_common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
Collection channelBeans    = (Collection)request.getAttribute("ChannelBeans@TinCNTT");
ChannelBean channelBean    = (ChannelBean)request.getAttribute("ChannelBean");
int channelID              = channelBean.getChannelID();
%>

<mvn:html locale="${currentLocale}">
<mvn:head>
<mvn:title><fmt:message key="mvncms.template1.common.title"/> - <fmt:message key="mvncms.template1.common.homepage"/></mvn:title>
<%@ include file="meta.jsp"%>
<link href="<%=request.getContextPath()%>/mvnplugin/mvncms/cms/jscripts/tiny_mce2/plugins/template/css/template.css" rel="stylesheet" type="text/css" />
<link href="<%=cdsTemplate%>/css/cds.css" rel="stylesheet" type="text/css" />
<%=StandardCDSUtil.initJSMenu(request, webHandlerManager)%>
<script type="text/javascript" src="<%=request.getContextPath()%>/mvnplugin/mvncms/cms/jscripts/overlib/overlib.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/menu.js"></script>

</mvn:head>
<mvn:body>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<table border="0" cellpadding="0" cellspacing="0" width="930" align="center">
  <tr>
    <td colspan="5"><%@include file="header.jsp"%></td>
  </tr>
  <tr>
    <td height="5" colspan="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="100%" height="5"/></td>
  </tr>                
  <tr>
    <%if (isNews == false) { %>
      <td valign="top" width="170" align="left">
        <%@include file="column_left.jsp"%>
      </td>
      <td valign="top" width="10"><img src="<%=cdsTemplate%>/images/spacer.gif" height="100%" width="10" alt=""/></td>
      <td valign="top"><%@include file="listcontents_mode_1_center.jsp"%></td>
      <td valign="top" width="10"><img src="<%=cdsTemplate%>/images/spacer.gif" height="100%" width="10" alt=""/></td>
      <td valign="top"><%@include file="column_right.jsp"%></td>
    <%} else { %>
      <td valign="top" width="170" align="left">
        <%@include file="column_left.jsp"%>
        <%@include file="column_right.jsp"%>
      </td>
      <td valign="top" width="10"><img src="<%=cdsTemplate%>/images/spacer.gif" height="100%" width="10" alt=""/></td>
      <td valign="top"><%@include file="listcontents_mode_1_center.jsp"%></td>
    <%} %>
  </tr>
  <tr>
    <td height="5" colspan="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="100%" height="5"/></td>
  </tr>
  <%if (isNews == false) { %>
    <tr>
      <td valign="top" colspan="5" width="100%" height="48"><%@include file="footer.jsp"%></td>
    </tr>
  <%} %>
</table> 

</mvn:body>
</mvn:html>