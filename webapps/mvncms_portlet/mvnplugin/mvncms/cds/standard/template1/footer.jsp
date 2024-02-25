<%--
  - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/footer.jsp,v 1.7 2009/03/30 07:19:32 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.7 $
  - $Date: 2009/03/30 07:19:32 $
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
<%@ page contentType="text/html;charset=utf-8"%>

<%if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_BANNER_FOOTER) > 0) {%>
<div align="center"><%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_BANNER_FOOTER))%></div>
<div align="center"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="100%" height="5"/></div>
<%}%>
<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td class="bgfooter">
      <div align="center" class="link_copyright">
        Powered by <a href="<%= mvnCmsInfo.getProductHomepage()%>" target="_blank" class="footerlink"><%= mvnCmsInfo.getProductDesc() %></a> (Build: <%= mvnCmsInfo.getProductReleaseDate()%>)<br/>
        Copyright &copy; 2002-2009 by <a href="http://www.MyVietnam.net" target="_blank" class="footerlink">MyVietnam.net</a>
      </div>
    </td>
  </tr>
</table>

