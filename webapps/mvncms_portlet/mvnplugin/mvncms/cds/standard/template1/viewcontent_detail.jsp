<%--
  - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/viewcontent_detail.jsp,v 1.10 2009/12/24 02:49:40 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.10 $
  - $Date: 2009/12/24 02:49:40 $
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
<%@ page import="com.mvnsoft.mvncms.common.URLUtils"%>
<%@ page import="net.myvietnam.mvncore.util.StringUtil"%>
<%
String highlightKey = (String) request.getAttribute("HighlightKey");
%>
<script type="text/javascript" src="<%=request.getContextPath()%>/mvnplugin/mvnforum/js/searchhi.js"></script>

<table id="searcharea" width="100%" border="0" align="center">
  <tr>
    <td class="nav_channel">
      <%for (int i = countChannel; i > 0; i--) {%>
        <img alt="bullet" src="<%=cdsTemplate%>/images/arrow2.gif" border="0"/>
        <a class="nav_channel" href="<%=strURL[i-1]%>"><%=channel_Name[i-1]%></a>
      <%}%>
    </td>
  </tr>
  <tr>
    <td nowrap="nowrap" class="content_publishdate">
      <%=onlineUser.getGMTDateFormat(content.getContentPublishStartDate())%>
      <%if (permission.isAuthenticated()) {%>
      - <fmt:message key="mvncms.template1.common.views"/>: <%=content.getContentViewCount()%>
      <%}%>
    </td>
  </tr>
  <!-- ContentID: <%=content.getContentID()%> -->
  <tr>
    <td valign="top" class="content_title"><%=ContentUtil.getContentTitle(content, currentLocale)%></td>
  </tr>
  <tr>
    <td valign="top" class="content_summary" align="justify">
    <%if (content.getContentDefaultImage().length() > 0) {%>
      <img src="<%=request.getContextPath() + content.getContentDefaultImage_translated()%>" alt="<%=content.getContentDefaultImageTitle()%>" class="channelimg" align="left" border="0"/>
    <%}%>
      <span class="content_summary"><%=ContentUtil.getContentSummary(request, content, currentLocale)%></span>
    </td>
  </tr>
<%if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CONTENT_CENTER_POSITION_01A) > 0) {%>
  <tr>
    <td valign="top">
      <div align="center"><%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CONTENT_CENTER_POSITION_01A))%></div>
    </td>
  </tr>
<%}%>
  <tr>
    <td valign="top" class="content_body" align="justify">
  <%if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CONTENT_CENTER_POSITION_01B) > 0) {%>
      <table border="0" cellspacing="0" cellpadding="5" class="contentdetailadleft">
        <tr>
          <td><%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CONTENT_CENTER_POSITION_01B))%></td>
        </tr>
      </table>
  <%}
    if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CONTENT_CENTER_POSITION_01C) > 0) {%>
      <table border="0" cellspacing="0" cellpadding="5" class="contentdetailadright">
        <tr>
          <td><%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CONTENT_CENTER_POSITION_01C))%></td>
        </tr>
      </table>
    <%}%>
      <%=ContentUtil.getContentBody(request, content, currentLocale)%>
    </td>
  </tr>
<%if ((content.getContentSourceName().length() > 0) || (content.getContentByAuthor().length() > 0)) {%>
  <tr>
    <td align="right" class="content_source">
      <%=content.getContentByAuthor()%>
      <%if (content.getContentSourceName().length() > 0) {%>
        (<fmt:message key="mvncms.template1.content.source"/>: <i><%=content.getContentSourceName()%></i>)
      <%}%>
    </td>
  </tr>
<%}
  if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CONTENT_CENTER_POSITION_02) > 0) {%>
  <tr>
    <td valign="top">
      <div align="center"><%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CONTENT_CENTER_POSITION_02))%></div>
    </td>
  </tr>
<%}%>
</table>
  
<%if (contentBeans.size() > 0) {%>
  <br />
  <table width="100%" border="0" align="center" cellpadding="5" class="hotnewsbg">  
    <tr>
      <td valign="top" align="left">
        <div class="othernews"><fmt:message key="mvncms.template1.common.other_news"/>:</div>
    <%
      for (Iterator iterator = contentBeans.iterator(); iterator.hasNext(); ) {
        ContentBean moreContentBean = (ContentBean) iterator.next();
        cdsURL = new CDSURL(channelID, moreContentBean.getContentID(), CDSURL.CDS_URL_PAGE_VIEW, null);
        String viewURL = cdsURLResolver.encode(request, cdsURL, webHandlerManager);
    %>
        <div class="listcontents_detail"> <span><b>&#8226;</b></span>&nbsp;<a href="<%=viewURL%>" onmouseover="return overlib('<%=URLUtils.escapeQuote(ContentUtil.getContentSummary(request, moreContentBean, currentLocale))%>'); " onmouseout="return nd();" class="link-topcolumn"><%=ContentUtil.getContentTitle(moreContentBean, currentLocale)%></a>
          <span class="date">
            &nbsp;&nbsp;- <%=onlineUser.getGMTDateFormat(moreContentBean.getContentPublishStartDate())%>
            <%if (permission.isAuthenticated()) {%>
              - <fmt:message key="mvncms.template1.common.views"/>: <%=moreContentBean.getContentViewCount()%> 
            <%}%>
          </span>
        </div>
    <%}//for
      if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CONTENT_MORE_CONTENT) > 0) {%>
        <%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CONTENT_MORE_CONTENT))%>
      <%}%>
      </td>
    </tr>
  </table>
<%}%>
<%if (highlightKey.length() > 0) {%>
<script type="text/javascript">
//<![CDATA[
  searchhi.highlightWords(document.getElementById("searcharea"),"<%=StringUtil.escapeJavaScript(highlightKey)%>");
//]]>
</script>
<%}%>