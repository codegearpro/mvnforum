<%--
  - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/column_left.jsp,v 1.4 2009/11/04 09:15:02 trungth Exp $
  - $Author: trungth $
  - $Revision: 1.4 $
  - $Date: 2009/11/04 09:15:02 $
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
<table cellpadding="0" cellspacing="0" border="0">
<%if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_01) > 0) {%>
  <tr align="center">
    <td valign="top" width="170">
      <%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_01))%>
    </td>
  </tr>
  <tr align="center">
    <td height="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="170" height="5"/></td>
  </tr>
<%}%>
  <tr align="center">
    <td valign="top" width="170"><%@include file="menu.jsp"%></td>
  </tr>
  <tr align="center">
    <td height="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="170" height="5"/></td>
  </tr>
  <%if (isNews == false) { %>
    <%@include file="rss_news.jsp"%>
  <%} %>
<%if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_04) > 0) {%>
  <tr align="center">
    <td height="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="170" height="5"/></td>
  </tr>
  <tr align="center">
    <td valign="top" width="170">
      <%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_04))%>
    </td>
  </tr>
<%}
  if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_05) > 0) {%>
  <tr align="center">
    <td height="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="170" height="5"/></td>
  </tr>
  <tr align="center">
    <td valign="top" width="170">
      <%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_05))%>
    </td>
  </tr>
<%}%>
  
</table>