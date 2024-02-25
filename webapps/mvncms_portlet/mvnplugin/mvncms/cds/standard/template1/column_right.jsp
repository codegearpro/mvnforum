<%--
  - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/column_right.jsp,v 1.2 2008/07/03 01:48:15 trungtb Exp $
  - $Author: trungtb $
  - $Revision: 1.2 $
  - $Date: 2008/07/03 01:48:15 $
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
<%if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_01) > 0) {%>
  <tr align="center">
    <td valign="top" width="170">
      <%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_01))%>
    </td>
  </tr>
  <tr>
    <td height="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="100%" height="5"/></td>
  </tr>
<%}%>
  <tr align="center">
    <td valign="top" width="170"><%@include file="lastnews.jsp"%></td>
  </tr>
<%if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_02) > 0) {%>
  <tr>
    <td height="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="100%" height="5"/></td>
  </tr>
  <tr align="center">
    <td valign="top" width="170">
      <%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_02))%>
    </td>
  </tr>
<%}%>
  <tr>
    <td height="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="100%" height="5"/></td>
  </tr>
  <tr align="center">
    <td width="170"><%@include file="mostreadnews.jsp"%></td>
  </tr>
<%if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_03) > 0) {%>
  <tr>
    <td height="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="100%" height="5"/></td>
  </tr>
  <tr align="center">
    <td valign="top" width="170">
      <%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_03))%>
    </td>
  </tr>
<%}
  if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_04) > 0) {%>
  <tr>
    <td height="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="100%" height="5"/></td>
  </tr>
  <tr align="center">
    <td valign="top" width="170">
      <%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_04))%>
    </td>
  </tr>
<%}
  if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_05) > 0) {%>
  <tr>
    <td height="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="100%" height="5"/></td>
  </tr>
  <tr align="center">
    <td valign="top" width="170">
      <%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_05))%>
    </td>
  </tr>
<%}%>
  <tr>
    <td valign="top"></td>
  </tr>
</table>