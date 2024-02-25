<%--
  - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/listcontents_mode_0_center.jsp,v 1.7 2009/12/24 02:49:40 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.7 $
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
<%
boolean hasNextPage = ((Boolean)request.getAttribute("HasNextPage")).booleanValue();
Collection contentBeans = (Collection)request.getAttribute("ContentBeans@TinCNTT");
if (contentBeans.size() == 0) { 
%>
  <div align="center" class="nocontents"><fmt:message key="mvncms.template1.channel.no_content"/></div>
<%
} else {
  int index = 0;
  Iterator iterator_content = contentBeans.iterator();
  // first loop
  ContentBean content = null;
  for(; iterator_content.hasNext() && index < 4; index++) {
    content = (ContentBean)iterator_content.next();
    cdsURL = new CDSURL(channelID, content.getContentID(), CDSURL.CDS_URL_PAGE_VIEW, null);
    String viewURL = cdsURLResolver.encode(request, cdsURL, webHandlerManager);
    if (index == 0) {
  %>
    <table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="nav_channel" style="line-height: 25px;">
          <%for (int i = countChannel; i > 0; i--) {%>
            <img alt="bullet" src="<%=cdsTemplate%>/images/arrow2.gif" border="0"/>
            <a class="nav_channel" href="<%=strURL[i-1]%>"><%=channel_Name[i-1]%></a>
          <%}%>
        </td>
      </tr>
      <tr>
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="title_column">
            <tr>
              <td class="title_column"><%=channelBean.getChannelName()%></td>
            </tr>
          </table>
          <table cellpadding="0" cellspacing="0" width="100%" border="0" class="hotnewsbg">
            <tr>
              <td valign="top">
                <%if (content.getContentDefaultImage().length() > 0) { %>
                  <a href="<%=viewURL%>"><img src="<%=request.getContextPath() + content.getContentDefaultImage_translated()%>" alt="<%=content.getContentDefaultImageTitle()%>" class="channelimg" border="0"/></a>
                <%}%>
                 <div class="date">
                   <a href="<%=viewURL%>" class="titlenews"><%=ContentUtil.getContentTitle(content, currentLocale)%></a>&nbsp;&nbsp;-
                   <%=onlineUser.getGMTDateFormat(content.getContentPublishStartDate())%>
                   <%if (permission.isAuthenticated()) {%>
                     - <fmt:message key="mvncms.template1.common.views"/>: <%=content.getContentViewCount()%> 
                   <%}%>
                </div>
                <div class="hotnews_content"><%=ContentUtil.getContentSummary(request, content, currentLocale)%></div>
              </td>
            </tr>
          <%if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CHANNEL_CENTER_POSITION_01) > 0) {%>
            <tr>
              <td valign="top">
                <div align="center"><%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CHANNEL_CENTER_POSITION_01))%></div>
              </td>
            </tr>
          <%}%>
          </table>
        </td>
      </tr>
    </table>
  <%} else {%>
    <table cellpadding="0" cellspacing="0" width="100%" border="0">
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td width="100%">
          <div class="date">
            <a href="<%=viewURL%>" class="listcontents_detail"><%=ContentUtil.getContentTitle(content, currentLocale)%></a>&nbsp;&nbsp;-
            <%=onlineUser.getGMTDateFormat(content.getContentPublishStartDate())%>
            <%if (permission.isAuthenticated()) {%>
              - <fmt:message key="mvncms.template1.common.views"/>: <%=content.getContentViewCount()%> 
            <%}%>
          </div>
          <%if (content.getContentDefaultImage().length() > 0) { %>
            <div class="padtop">
              <img width="160" src="<%=request.getContextPath() + content.getContentDefaultImage_translated()%>" alt="<%=content.getContentDefaultImageTitle()%>" class="channelimg" align="left" border="0"/>
          <%}%>
          <div class="hotnews_content"><%=ContentUtil.getContentSummary(request, content, currentLocale)%></div>
          <div align="right"><a class="listcontents_oldcontents" href="<%=viewURL%>"><fmt:message key="mvncms.template1.common.content.detail"/></a><span class="redbold">&nbsp;&raquo;</span></div>
          <%if (content.getContentDefaultImage().length() > 0) { %>
            </div>
          <%}%>
        </td>
      </tr>
    </table>
  <%} //else
  } // end of for
  if (index > 0 && configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CHANNEL_CENTER_POSITION_02) > 0) {%>
    <div align="center"><%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CHANNEL_CENTER_POSITION_02))%></div><br/>
<%}
  if (iterator_content.hasNext()) {%>
    <br/>                               
    <table width="100%" border="0" cellspacing="" cellpadding="5" class="hotnewsbg">
      <tr>
        <td valign="top" align="left">
          <div class="othernews"><fmt:message key="mvncms.template1.common.other_news"/>:</div>
      <%
        long beforeDate = 0;
        ContentBean otherContent = null;
        for( ; iterator_content.hasNext(); ) {
          otherContent = (ContentBean)iterator_content.next();
          cdsURL = new CDSURL(channelID, otherContent.getContentID(), CDSURL.CDS_URL_PAGE_VIEW, null);
          String viewURL = cdsURLResolver.encode(request, cdsURL, webHandlerManager);
          if (beforeDate < otherContent.getContentCreationDate().getTime()) {
            beforeDate = otherContent.getContentCreationDate().getTime();
          }
      %>
          <div class="listcontents_detail">
            <span><b>&#8226;</b></span>&nbsp;<a href="<%=viewURL%>" class="link-topcolumn"><%=ContentUtil.getContentTitle(otherContent, currentLocale)%></a>
            &nbsp;&nbsp;
            <span class="date">
              <%=onlineUser.getGMTDateFormat(otherContent.getContentPublishStartDate())%>
              <%if (permission.isAuthenticated()) {%>
                - <fmt:message key="mvncms.template1.common.views"/>: <%=otherContent.getContentViewCount()%> 
              <%}%>
            </span>
          </div>
      <%}
        if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CHANNEL_MORE_CONTENT) > 0) {%>
          <%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_CHANNEL_MORE_CONTENT))%>
      <%}%>
          <br/>
      <%if (hasNextPage && (content != null) && (otherContent != null)) {%>
          <table width="100%" border="0" cellspacing="1" cellpadding="1" align="center">
            <tr>
              <td align="right">
                <%
                cdsURL = new CDSURL(channelID, 0, CDSURL.CDS_URL_PAGE_LIST, null);
                String listURL = cdsURLResolver.encode(request, cdsURL, webHandlerManager);
                %>
                <script type="text/javascript">
                //<![CDATA[
                  function showNextPage() {
                    location.href='<%=listURL%>?time=<%=beforeDate%>';
                  }
                //]]>
                </script>
                <a href="javascript:showNextPage()" class="listcontents_others"><fmt:message key="mvnforum.common.next" bundle="${forum}"/></a>
              </td>
            </tr>
          </table>
      <%}%>
        </td>
      </tr>
    </table>
<%}
}%>