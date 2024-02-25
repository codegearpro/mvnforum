<%--
 - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/confighome.jsp,v 1.4 2009/05/06 03:50:54 trungth Exp $
 - $Author: trungth $
 - $Revision: 1.4 $
 - $Date: 2009/05/06 03:50:54 $
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
<%@ page session="false" errorPage="fatalerror.jsp"%>

<%@ page import="com.mvnsoft.mvnad.db.ZoneBean"%>
<%@ page import="com.mvnsoft.mvncms.cds.standard.*"%>
<%@ page import="java.util.*"%>
<%@ page import="net.myvietnam.mvncore.util.StringUtil"%>

<%@ include file="inc_common.jsp"%>
<%
List<ZoneBean> zoneBeans = (List) request.getAttribute("ZoneBeans");

int[] zoneIDs = new int[zoneBeans.size()+1];
String[] zoneNames = new String[zoneBeans.size()+1];
zoneIDs[0] = 0;
zoneNames[0] = "";
for (int i = 0; i<zoneBeans.size(); i++) {
  ZoneBean zoneBean = zoneBeans.get(i);
  zoneIDs[i+1] = zoneBean.getZoneID();
  zoneNames[i+1] = zoneBean.getZoneName();
}

boolean flag = ((Boolean) request.getAttribute("ConfigHomeSuccess")).booleanValue();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Edit Home Layout</title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/mvnplugin/mvnforum/css/style.css" />
    <link type="text/css" rel="stylesheet" href="<%=cdsTemplate%>/css/cds.css" />
  </head>
  <body>
<div><img src="<%=cdsTemplate%>/images/logo.gif" alt="" /></div>
<%@include file="configheader.jsp"%>
<%if (flag) {%>
 
    <br />
  <div class="pagedesc center">
     <span class="portlet-msg-success">Edit home layout successfully.</span>
  </div> 
    
  <%}%>
  <br />    
      <form action="" name="editLayoutForm" method="post">
      <mvn:securitytoken />
        <input type="hidden" name="reload" value="true" />
        <table align="center" cellpadding="0" cellspacing="10" border="0" width="95%">
          <tr>
            <td align="right" valign="top" width="150">
            <table cellpadding="2" cellspacing="1" class="tborder" width="140">
              <tr class="topmenu">
                <td>Ad home left 1</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeLeft1", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_01))%></td>
              </tr>
            </table>
            <br />
  
            <table cellpadding="2" cellspacing="1" class="tborder" width="140">
              <tr class="topmenu">
                <td>Ad home left 2</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeLeft2", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_02))%></td>
              </tr>
            </table>
            <br />
            
            <table cellpadding="2" cellspacing="1" class="tborder" width="140">
              <tr class="topmenu">
                <td>Ad home left 3</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeLeft3", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_03))%></td>
              </tr>
            </table>
            <br />
            
            <table cellpadding="2" cellspacing="1" class="tborder" width="140">
              <tr class="topmenu">
                <td>Ad home left 4</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeLeft4", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_04))%></td>
              </tr>
            </table>
            <br />
            
            <table cellpadding="2" cellspacing="1" class="tborder" width="140">
              <tr class="topmenu">
                <td>Ad home left 5</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeLeft5", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_05))%></td>
              </tr>
            </table>
            <br />
<%--
            <table cellpadding="2" cellspacing="1" class="tborder" width="140">
              <tr class="topmenu">
                <td>Ad home left</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeLeft6", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_06))%></td>
              </tr>
            </table>
            <br />
            
            <table cellpadding="2" cellspacing="1" class="tborder" width="140">
              <tr class="topmenu">
                <td>Ad home left</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeLeft7", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_07))%></td>
              </tr>
            </table>
            <br />
            
            <table cellpadding="2" cellspacing="1" class="tborder" width="140">
              <tr class="topmenu">
                <td>Ad home left</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeLeft8", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_08))%></td>
              </tr>
            </table>
            <br />
            
            <table cellpadding="2" cellspacing="1" class="tborder" width="140">
              <tr class="topmenu">
                <td>Ad home left</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeLeft9", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_09))%></td>
              </tr>
            </table>
            <br />
            
            <table cellpadding="2" cellspacing="1" class="tborder" width="140">
              <tr class="topmenu">
                <td>Ad home left</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeLeft10", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_LEFT_POSITION_10))%></td>
              </tr>
            </table>
--%>
          </td>
          <td valign="top">
            <table align="center" cellpadding="2" cellspacing="1" class="tborder" width="640">
              <tr class="topmenu">
                <td>Ad Home</td>
                <td>Ad Content</td>
              </tr>
              <tr class="portlet-section-body">
                <td valign="top">
                  <table align="center" cellpadding="2" cellspacing="1" class="tborder">
                    <tr class="portlet-section-alternate">
                      <td>Ad home center 1: <%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeCenter1", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_CENTER_POSITION_01))%></td>
                    </tr>
                  </table>
                  <br />
      
                  <table align="center" cellpadding="2" cellspacing="1" class="tborder">
                    <tr class="portlet-section-alternate">
                      <td>Ad home center 2: <%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeCenter2", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_CENTER_POSITION_02))%></td>
                    </tr>
                  </table>
                  <br />
      
                  <table align="center" cellpadding="2" cellspacing="1" class="tborder">
                    <tr class="portlet-section-alternate">
                      <td>Ad home center 3: <%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeCenter3", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_CENTER_POSITION_03))%></td>
                    </tr>
                  </table>
                  <br />
      
                  <table align="center" cellpadding="2" cellspacing="1" class="tborder">
                    <tr class="portlet-section-alternate">
                      <td>Ad home center 4: <%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeCenter4", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_CENTER_POSITION_04))%></td>
                    </tr>
                  </table>
                  <br />
      
                  <table align="center" cellpadding="2" cellspacing="1" class="tborder">
                    <tr class="portlet-section-alternate">
                      <td>Ad home center 5: <%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeCenter5", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_CENTER_POSITION_05))%></td>
                    </tr>
                  </table>
                </td>
                
                <td valign="top">
                  <table align="center" cellpadding="2" cellspacing="1" class="tborder">
                    <tr class="portlet-section-alternate">
                      <td>Ad content 1A: <%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adContentCenter1a", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CONTENT_CENTER_POSITION_01A))%></td>
                    </tr>
                  </table>
                  <br />
      
                  <table align="center" cellpadding="2" cellspacing="1" class="tborder">
                    <tr class="portlet-section-alternate">
                      <td>Ad content 1B: <%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adContentCenter1b", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CONTENT_CENTER_POSITION_01B))%></td>
                    </tr>
                  </table>
                  <br />
      
                  <table align="center" cellpadding="2" cellspacing="1" class="tborder">
                    <tr class="portlet-section-alternate">
                      <td>Ad content 1C: <%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adContentCenter1c", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CONTENT_CENTER_POSITION_01C))%></td>
                    </tr>
                  </table>
                  <br />
      
                  <table align="center" cellpadding="2" cellspacing="1" class="tborder">
                    <tr class="portlet-section-alternate">
                      <td>Ad content: <%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adContentCenter2", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CONTENT_CENTER_POSITION_02))%></td>
                    </tr>
                  </table>
                  <br />
      
                  <table align="center" cellpadding="2" cellspacing="1" class="tborder">
                    <tr class="portlet-section-alternate">
                      <td>Ad content more: <%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adContentMoreContent", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CONTENT_MORE_CONTENT))%></td>
                    </tr>
                  </table>
                  
                </td>
              </tr>
            </table>
            <br />

            <table align="center" cellpadding="2" cellspacing="1" class="tborder" width="640">
              <tr class="topmenu">
                <td>Ad Channel</td>
              </tr>
              <tr>
                <td width="30%" align="left">
                  <table align="center" cellpadding="2" cellspacing="1" class="tborder">
                    <tr class="portlet-section-alternate">
                      <td>Ad channel center 1: <%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adChannelCenter1", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CHANNEL_CENTER_POSITION_01))%></td>
                    </tr>
                  </table>
                  <br />
      
                  <table align="center" cellpadding="2" cellspacing="1" class="tborder">
                    <tr class="portlet-section-alternate">
                      <td>Ad channel center 2: <%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adChannelCenter2", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CHANNEL_CENTER_POSITION_02))%></td>
                    </tr>
                  </table>
                  <br />
      
                  <table align="center" cellpadding="2" cellspacing="1" class="tborder">
                    <tr class="portlet-section-alternate">
                      <td>Ad channel more: <%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adChannelMoreContent", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CHANNEL_MORE_CONTENT))%></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            <br />

            <table align="center" cellpadding="2" cellspacing="1" class="tborder" width="640">
              <tr>
                <td width="30%" class="topmenu">Banner header</td>
                <td class="portlet-section-body"><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adBannerHeader", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_BANNER_HEADER))%></td>
              </tr>
            </table>
            <br />
            
            <table align="center" cellpadding="2" cellspacing="1" class="tborder" width="640">
              <tr>
                <td width="30%" class="topmenu">Banner footer</td>
                <td class="portlet-section-body"><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adBannerFooter", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_BANNER_FOOTER))%></td>
              </tr>
            </table>
            <br />
            
            <table align="center" cellpadding="2" cellspacing="1" class="tborder" width="640">
              <tr>
                <td width="30%" class="topmenu">Ad Link Unit</td>
                <td class="portlet-section-body"><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adLinkUnit", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_LINK_UNIT))%></td>
              </tr>
            </table>
                
          </td>
          <td valign="top" width="200">
            <table cellpadding="2" cellspacing="1" class="tborder" width="170">
              <tr class="topmenu">
                <td>Ad right 1</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeRight1", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_01))%></td>
              </tr>
            </table>
            <br />
            
            <table cellpadding="2" cellspacing="1" class="tborder" width="170">
              <tr class="topmenu">
                <td>Ad right 2</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeRight2", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_02))%></td>
              </tr>
            </table>
            <br />
            
            <table cellpadding="2" cellspacing="1" class="tborder" width="170">
              <tr class="topmenu">
                <td>Ad right 3</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeRight3", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_03))%></td>
              </tr>
            </table>
            <br />
            
            <table cellpadding="2" cellspacing="1" class="tborder" width="170">
              <tr class="topmenu">
                <td>Ad right 4</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeRight4", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_04))%></td>
              </tr>
            </table>
            <br />
            
            <table cellpadding="2" cellspacing="1" class="tborder" width="170">
              <tr class="topmenu">
                <td>Ad right 5</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeRight5", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_05))%></td>
              </tr>
            </table>
            <br />
<%--            
            <table cellpadding="2" cellspacing="1" class="tborder" width="170">
              <tr class="topmenu">
                <td>Ad right</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeRight6", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_06))%></td>
              </tr>
            </table>
            <br />
            
            <table cellpadding="2" cellspacing="1" class="tborder" width="170">
              <tr class="topmenu">
                <td>Ad right</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeRight7", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_07))%></td>
              </tr>
            </table>
            <br />
            
            <table cellpadding="2" cellspacing="1" class="tborder" width="170">
              <tr class="topmenu">
                <td>Ad right</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeRight8", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_08))%></td>
              </tr>
            </table>
            <br />
            
            <table cellpadding="2" cellspacing="1" class="tborder" width="170">
              <tr class="topmenu">
                <td>Ad right</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeRight9", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_09))%></td>
              </tr>
            </table>
            <br />
            
            <table cellpadding="2" cellspacing="1" class="tborder" width="170">
              <tr class="topmenu">
                <td>Ad right</td>
              </tr>
              <tr class="portlet-section-body">
                <td><%=StringUtil.getSelectionModel(zoneIDs, zoneNames, "adHomeRight10", configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_RIGHT_POSITION_10))%></td>
              </tr>
            </table>
--%>            
          </td>
        </tr>
        <tr align="center">
          <td colspan="3">
            <div align="center">
              <input type="submit" value="Save Home Page" class="portlet-form-button" />
            </div>
          </td>
        </tr>
      </table>
    </form>
  </body>
</html>
