<%--
  - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/rss_news.jsp,v 1.3 2009/03/27 07:11:29 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.3 $
  - $Date: 2009/03/27 07:11:29 $
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
<%@ page import="com.mvnsoft.mvncms.common.feed.FeedItem"%>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter"%>
<%if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_02) > 0) {%>
  <tr align="center">
    <td valign="top" width="170">
      <%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_02))%>
    </td>
  </tr>
  <tr align="center">
    <td height="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="170" height="5"/></td>
  </tr>
<%}%>
  <tr align="center">
    <td valign="top" width="170"><%@include file="rss_javavietnam.jsp"%></td>
  </tr>
<%if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_03) > 0) {%>
  <tr align="center">
    <td height="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="170" height="5"/></td>
  </tr>
  <tr align="center">
    <td valign="top" width="170">
      <%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_03))%>
    </td>
  </tr>
<%}%>
  <tr align="center">
    <td height="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="170" height="5"/></td>
  </tr>
  <tr align="center">
    <td valign="top" width="170"><%@include file="rss_rssnews.jsp"%></td>
  </tr>