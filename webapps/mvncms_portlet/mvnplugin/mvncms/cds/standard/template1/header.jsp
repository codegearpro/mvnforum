<%--
  - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/header.jsp,v 1.21 2009/12/22 09:43:35 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.21 $
  - $Date: 2009/12/22 09:43:35 $
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
<%@ page import="net.myvietnam.mvncore.util.DateUtil"%>
<%@ page import="net.myvietnam.mvncore.util.ParamUtil"%>
<%@ page import="com.mvnforum.user.UserModuleConfig"%>

<%@ include file="inc_js_common.jsp"%>

<script src="<%=request.getContextPath()%>/mvnplugin/mvnforum/js/myvietnam.js" type="text/javascript"></script>
<%if (currentLocale.equals("vi")) {%>
<script src="<%=cdsTemplate%>/js/avim.js" type="text/javascript"></script>
<%}%>
<script type="text/javascript">
//<![CDATA[
function SubmitFormSearch() {
  if (ValidateFormSearch() == true ) {
    document.submitformsearch.submit();
  }
}

function ValidateFormSearch() {
  if (isBlank(document.submitformsearch.key, "<fmt:message key="mvnforum.common.action.search" bundle="${forum}"/>")) return false;
  return true;
}
//]]>
</script>

<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td width="100%" height="120" class="servletmode">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="bgheader">
        <tr>
          <td height="120" rowspan="2" valign="middle" align="center" width="160">
            <a href="<%=mvnCmsInfo.getProductHomepage()%>" target="_self"><img src="<%=cdsTemplate%>/images/logo.gif" border="0" alt="" /></a>
          </td>
          <td valign="middle" align="center" height="94">
          <%if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_BANNER_HEADER) > 0) {%>
            <%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_BANNER_HEADER))%>
          <%}%>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td height="26">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="bgsearch" id="Table_05">
        <tr>
          <td align="center" nowrap="nowrap" class="yellowcolor" height="26">&nbsp;
          <%if (isServlet) {%>
            <a href="<%=request.getContextPath() + UserModuleConfig.getUrlPattern()%>" class="link_language"><img src="<%=cdsTemplate%>/images/forum_arrow.gif" border="0" alt="" />&nbsp;<fmt:message key="mvnforum.common.forum" bundle="${forum}"/></a> &nbsp;&nbsp;
          <%} %>
            <%=onlineUser.getGMTTimestampFormat(DateUtil.getCurrentGMTTimestamp())%>&nbsp;
          </td>
          <td width="100%" height="26">
            <%if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_LINK_UNIT) > 0) {%>
              <%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_LINK_UNIT))%>
            <%}%>
            <div align="right">
              <%if (isPortlet) { %>
              <a href="<%=urlResolver.encodeURL(request, response, "rss?channelid="+channelID, URLResolverService.ACTION_URL)%>"><img src="<%=cdsTemplate%>/images/rss.gif" border="0" alt="RSS" style="vertical-align:top"/></a>&nbsp;&nbsp;
              <%} else { %>
              <a href="<%=request.getContextPath() + webHandlerManager.getProperty(CDSConstants.PROPERTY_URL_PATTERN) + "/rss?channelid="+channelID%>"><img src="<%=cdsTemplate%>/images/rss.gif" border="0" alt="RSS" style="vertical-align:top"/></a>&nbsp;&nbsp;
              <%} %>
            </div>
          </td>
          <td nowrap="nowrap" class="yellowcolor" height="26">
            <%if (isPortlet) {%>
            <form onsubmit="javascript:SubmitFormSearch();return false; " action="<%=urlResolver.encodeURL(request, response, "search", URLResolverService.ACTION_URL)%>" method="get" name="submitformsearch">
            <%=urlResolver.generateFormAction(request, response, "search")%>
           <%} else { %>
            <form onsubmit="javascript:SubmitFormSearch();return false; " action="<%=request.getContextPath() +  webHandlerManager.getProperty(CDSConstants.PROPERTY_URL_PATTERN) + "/search"%>" method="get" name="submitformsearch">
            <%} %>
                <table align="right" cellpadding="0" cellspacing="0">
                  <tr>
                    <td nowrap="nowrap">
                      <label for="key"><fmt:message key="mvnforum.common.action.search" bundle="${forum}" /></label>&nbsp;<input class="search_border" type="text" id="key" name="key" size="15" value="<%=ParamUtil.getParameter(request, "key", false)%>" />
                    </td>
                    <td>  
                      <a onclick="javascript:SubmitFormSearch()"><img alt="<fmt:message key="mvnforum.user.searchresult.title" bundle="${forum}"/>" src="<%=cdsTemplate%>/images/search.gif" border="0"/></a>
                    </td>
                  </tr>
                </table>
            </form>  
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
