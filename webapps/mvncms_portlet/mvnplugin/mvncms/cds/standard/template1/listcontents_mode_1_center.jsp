<%--
  - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/listcontents_mode_1_center.jsp,v 1.7 2009/12/24 02:49:40 xuantl Exp $
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
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.mvnsoft.mvncms.common.URLUtils"%>
<link href="<%=request.getContextPath()%>/mvnplugin/mvncms/cms/jscripts/tiny_mce2/plugins/template/css/template.css" rel="stylesheet" type="text/css" />
<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">

<%
  Collection<ContentBean> hotNews = (Collection<ContentBean>)request.getAttribute("Contents@Home");
  if (hotNews != null && hotNews.size() > 0) {
    for(Iterator<ContentBean> hotNewsIter = hotNews.iterator(); hotNewsIter.hasNext(); ) {
      ContentBean contentBeanHot = hotNewsIter.next();%>
  <tr align="left">
    <td valign="top" class="hotnewsbg" width="100%">
      <div class="date">
        <%      
        cdsURL = new CDSURL(channelID, contentBeanHot.getContentID(), CDSURL.CDS_URL_PAGE_VIEW, null);
        String viewURL = cdsURLResolver.encode(request, cdsURL, webHandlerManager);
        if (permission.isAuthenticated()) {
          out.print("<div class='date'>");
        }  
        %>    
        <%=onlineUser.getGMTDateFormat(contentBeanHot.getContentPublishStartDate())%>
        <%  
        if (permission.isAuthenticated()) {
        %>    
          - <fmt:message key="mvncms.template1.common.views"/>: <%=contentBeanHot.getContentViewCount()%>
      </div>
        <%  
        }
        %>
      </div>
      <div>
      <%if (contentBeanHot.getContentDefaultImage().length() > 0) {%>
        <img src="<%=request.getContextPath() + contentBeanHot.getContentDefaultImage_translated()%>" alt="<%=contentBeanHot.getContentDefaultImageTitle()%>" align="left" class="channelimg" border="0" />
      <%}%>
        <a href="<%=viewURL%>" class="titlenews"><%=ContentUtil.getContentTitle(contentBeanHot, currentLocale)%></a>
        <div class="hotnews_content"><%=ContentUtil.getContentSummary(request, contentBeanHot, currentLocale)%></div>
      </div>
    </td>
  </tr>
  <%} // for
    if (configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_CENTER_POSITION_01) > 0) {%>  
  <tr>
    <td width="100%">
      <div align="center"><%=AdGenerator.getZone(configLayout.getZoneID(ConfigLayoutTinCNTT.TINCNTT_ZONE_NAME_CMS_ADS_HOME_CENTER_POSITION_01))%></div>
    </td>
  </tr>
  <%}%>
  <tr>
    <td width="100%"><img src="<%=cdsTemplate%>/images/spacer.gif" height="10" width="100%" alt="" /></td>
  </tr>
<%} //if%>

  <tr valign="top">
    <td valign="top" width="100%">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <% if (channelBeans.size() == 0) { %>
        <tr>
          <td colspan="3" width="100%">
            <div align="center" class="nocontents"><fmt:message key="mvncms.template1.channel.no_content"/></div>
          </td>
        </tr>
      <% } else {
           int count = 0;
           for (Iterator iterator = channelBeans.iterator(); iterator.hasNext(); ) {
             ChannelBean channel = (ChannelBean)iterator.next();
             Collection contentBeans = channel.getContentBeans();
             cdsURL = new CDSURL(channel.getChannelID(), 0, CDSURL.CDS_URL_PAGE_LIST, null);
             String listURL = cdsURLResolver.encode(request, cdsURL, webHandlerManager);
             
             count++;
             if ((count % 2) == 1) {
      %>
        <tr valign="top">
          <% } %>
          <td width="48%">
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr>
                <td width="100%" class="title_column"><a href="<%=listURL%>" class="title_column"><%=channel.getChannelName()%></a></td>
              </tr>
              <tr>
                <td align="left" class="channelbg" width="100%">
                 <%
                   int index = 0;
                   for(Iterator iter = contentBeans.iterator(); iter.hasNext() && index < 6;) {
                     ContentBean content = (ContentBean)iter.next();
                     cdsURL = new CDSURL(content.getDefaultChannelID(), content.getContentID(), CDSURL.CDS_URL_PAGE_VIEW, null);
                     String viewURL = cdsURLResolver.encode(request, cdsURL, webHandlerManager);
                                      
                     if (index == 0) {
                       if (content.getContentDefaultImage().length() > 0) { %>
                    <div class="padbottom">
                      <a href="<%=viewURL%>" class="link-topcolumn"><img width="60" class="channelimg" src="<%=request.getContextPath() + content.getContentDefaultImage_translated()%>" alt="<%=content.getContentDefaultImageTitle()%>" align="left" border="0" /></a>
                    </div>  
                     <% } %>
                    <div class="header_column">
                      <a href="<%=viewURL%>" class="header_column"><%=ContentUtil.getContentTitle(content, currentLocale)%></a>
                      <span class="date">
                        <%=onlineUser.getGMTDateFormat(content.getContentPublishStartDate())%>
                        <% if (permission.isAuthenticated()) {%>- <fmt:message key="mvncms.template1.common.views"/>: <%=content.getContentViewCount()%> <% } %>
                      </span>
                    </div>
                    <div align="justify" class="header_column1"><%=ContentUtil.getContentSummary(request, content, currentLocale)%></div>
                   <%} else { // older news %>
                    <div>
                      <img src="<%=cdsTemplate%>/images/bullet.gif" alt=""/>
                      <a class="link-topcolumn" href="<%=viewURL%>" onmouseover="return overlib('<%=URLUtils.escapeQuote(ContentUtil.getContentSummary(request, content, currentLocale))%>');" onmouseout="return nd();">
                        <span class="link-topcolumn"><%=ContentUtil.getContentTitle(content, currentLocale)%></span>
                      </a>
                      <span class="date">
                        <%=onlineUser.getGMTDateFormat(content.getContentPublishStartDate())%>
                        <% if (permission.isAuthenticated()) {%>- <fmt:message key="mvncms.template1.common.views"/>: <%=content.getContentViewCount()%> <% } %>
                      </span>
                    </div>                                   
                   <%}// else if (index == 0))
                       index++;
                     %>
                 <%}//for %>                            
                </td>
              </tr>
            </table>
          </td>
          <%if ((count % 2) == 1) {%>
          <td valign="top" width="10">
            <img src="<%=cdsTemplate%>/images/spacer.gif" height="100%" width="10" alt=""/>
          </td>
           <%} else {%>
        </tr>
        <%@include file="listcontents_mode_1_center_ad.jsp"%>
           <%} //else
           }//for
           if ((count % 2) == 1) {
           %>
        </tr>
        <%@include file="listcontents_mode_1_center_ad.jsp"%>
           <%  
           }
         }//else
       %>
      </table>
    </td>
  </tr>
</table>
