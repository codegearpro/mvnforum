<%--
 - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/listcontents_mode_1_center_ad.jsp,v 1.1 2008/05/30 02:35:07 trungtb Exp $
 - $Author: trungtb $
 - $Revision: 1.1 $
 - $Date: 2008/05/30 02:35:07 $
 -
 - ====================================================================
 -
 - Copyright (C) 2005 by MyVietnam.net
 -
 - MyVietnam.net PROPRIETARY/CONFIDENTIAL PROPERTIES. Use is subject to license terms.
 - You CANNOT use this software unless you receive a written permission from MyVietnam.net
 -
 - @author: MyVietnam.net developers
 -
 --%>
<%@ page contentType="text/html;charset=utf-8" %>
<%if ((count == 1 || count == 2) && configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_CENTER_POSITION_02) > 0) {%>  
        <tr>
          <td width="640" colspan="3">
            <div align="center"><%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_CENTER_POSITION_02))%></div>
          </td>
        </tr>
        <tr>
          <td width="640" colspan="3"><img src="<%=cdsTemplate%>/images/spacer.gif" height="10" width="640" alt="" /></td>
        </tr>
<%}
  if ((count == 3 || count == 4) && configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_CENTER_POSITION_03) > 0) {%>  
        <tr>
          <td width="640" colspan="3">
            <div align="center"><%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_CENTER_POSITION_03))%></div>
          </td>
        </tr>
        <tr>
          <td width="640" colspan="3"><img src="<%=cdsTemplate%>/images/spacer.gif" height="10" width="640" alt="" /></td>
        </tr>
<%}
  if ((count == 5 || count == 6) && configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_CENTER_POSITION_04) > 0) {%>  
        <tr>
          <td width="640" colspan="3">
           <div align="center"><%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_CENTER_POSITION_04))%></div>
          </td>
        </tr>
        <tr>
          <td width="640" colspan="3"><img src="<%=cdsTemplate%>/images/spacer.gif" height="10" width="640" alt="" /></td>
        </tr>
<%}
  if ((count == 7 || count == 8) && configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_CENTER_POSITION_05) > 0) {%>  
        <tr>
          <td width="640" colspan="3">
            <div align="center"><%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_CENTER_POSITION_05))%></div>
          </td>
        </tr>
        <tr>
          <td width="640" colspan="3"><img src="<%=cdsTemplate%>/images/spacer.gif" height="10" width="640" alt="" /></td>
        </tr>
<%}%>