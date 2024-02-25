<%--
  - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/menu.jsp,v 1.5 2009/12/11 03:14:49 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.5 $
  - $Date: 2009/12/11 03:14:49 $
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
<table cellpadding="0" cellspacing="0" align="left" border="0">
  <tr>
    <td align="left" width="170">
      <script type="text/javascript">
      //<![CDATA[
        var rootChannelId = <%=webHandlerManager.getPropertyInt(CDSConstants.PROPERTY_ROOT_CHANNEL_ID)%>;
        buildMenu(Menu, <%=webHandlerManager.getPropertyInt(CDSConstants.PROPERTY_ROOT_CHANNEL_ID)%> /* root */, <%=channelID%> /* current */);
      //]]>
      </script>
    </td>
  </tr>
</table> 