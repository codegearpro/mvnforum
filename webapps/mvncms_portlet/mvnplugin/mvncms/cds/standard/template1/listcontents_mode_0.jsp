<%--
  - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/listcontents_mode_0.jsp,v 1.13 2009/12/17 02:41:20 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.13 $
  - $Date: 2009/12/17 02:41:20 $
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
ChannelBean channelBean = (ChannelBean)request.getAttribute("ChannelBean");
int channelID = channelBean.getChannelID();

int countChannel = 1;
int id = channelID;
while(id != 0 && id != webHandlerManager.getPropertyInt(CDSConstants.PROPERTY_ROOT_CHANNEL_ID)) {    
  countChannel++;
  ChannelBean parent = ChannelCache.getInstance().getChannel(id);
  id = parent.getChannelParentID(); 
}
  
id = channelID;
String []strURL = new String[countChannel];
String []channel_Name = new String[countChannel];
int idx = 0;
CDSURL cdsURLChannel = null;  
while(id != 0 && id != webHandlerManager.getPropertyInt(CDSConstants.PROPERTY_ROOT_CHANNEL_ID)) { 
  ChannelBean parent = ChannelCache.getInstance().getChannel(id);
  cdsURLChannel = new CDSURL(parent.getChannelID(), -1, CDSURL.CDS_URL_PAGE_LIST, null);
  String channelViewURL = cdsURLResolver.encode(request, cdsURLChannel, webHandlerManager);
  strURL[idx] = channelViewURL;
  channel_Name[idx++] = parent.getChannelName();
  id = parent.getChannelParentID();    
}
ChannelBean parent = ChannelCache.getInstance().getChannel(id);
cdsURLChannel = new CDSURL(parent.getChannelID(), -1, CDSURL.CDS_URL_PAGE_LIST, null);
String channelViewURL = cdsURLResolver.encode(request, cdsURLChannel, webHandlerManager);
strURL[idx] = channelViewURL;
channel_Name[idx++] = parent.getChannelName();
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title><fmt:message key="mvncms.template1.common.title"/> - <%=channelBean.getChannelName() %></title>
  <%@ include file="meta.jsp"%>
  <link href="<%=request.getContextPath()%>/mvnplugin/mvncms/cms/jscripts/tiny_mce2/plugins/template/css/template.css" rel="stylesheet" type="text/css" />
  <link href="<%=cdsTemplate%>/css/cds.css" rel="stylesheet" type="text/css"/>
  <%=StandardCDSUtil.initJSMenu(request, webHandlerManager)%>
  <script type="text/javascript" src="<%=request.getContextPath()%>/mvnplugin/mvncms/cms/jscripts/overlib/overlib.js"></script>
  <script type="text/javascript" src="<%=cdsTemplate%>/js/menu.js"></script>
</head>
<body>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<table border="0" cellpadding="0" cellspacing="0" width="930" align="center">
  <tr>     
    <td valign="top"><%@include file="header.jsp"%></td>
  </tr>
  <tr>
    <td height="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="100%" height="5"/></td>
  </tr>
  <tr>
    <td>
      <table cellpadding="0" cellspacing="0" width="100%" border="0">
        <tr>
          <%if (isNews == false) { %>
            <td valign="top" width="170" align="left"><%@include file="column_left.jsp"%></td>
            <td valign="top" width="10"><img src="<%=cdsTemplate%>/images/spacer.gif" height="100%" width="10" alt=""/></td>
            <td valign="top"><%@include file="listcontents_mode_0_center.jsp"%></td>
            <td valign="top" width="10"><img src="<%=cdsTemplate%>/images/spacer.gif" height="100%" width="10" alt="" /></td>
            <td valign="top" width="170"><%@include file="column_right.jsp"%></td>
          <%} else {%>
            <td valign="top" width="170" align="left"><%@include file="column_left.jsp"%><%@include file="column_right.jsp"%></td>
            <td valign="top" width="10"><img src="<%=cdsTemplate%>/images/spacer.gif" height="100%" width="10" alt=""/></td>
            <td valign="top"><%@include file="listcontents_mode_0_center.jsp"%></td>
          <%} %>
        </tr>
      </table>      
    </td>
  </tr>
  <tr>
    <td height="5" colspan="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="100%" height="5"/></td>
  </tr>
  <%if (isNews == false) { %>
    <tr>
      <td valign="top" width="100%" height="48"><%@include file="footer.jsp"%></td>
    </tr>
  <%} %>
</table>

</body>
</html>