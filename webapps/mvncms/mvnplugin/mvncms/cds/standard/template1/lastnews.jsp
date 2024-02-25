<%--
  - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/lastnews.jsp,v 1.8 2009/12/24 03:35:49 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.8 $
  - $Date: 2009/12/24 03:35:49 $
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

<table class="border_tsbd" width="170" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="border_newsleft" height="21"><fmt:message key="mvncms.template1.latestnews.title"/></td>
  </tr>
  <tr>
    <%
    Collection<ContentBean> latestContents_news = (Collection<ContentBean>) request.getAttribute("ContentBeans@HotNewsTinCNTT");
    if ((latestContents_news != null) && (latestContents_news.size() != 0)) {
    %>
      <td class="content_newsleft" width="170" align="left">
    <%    
      CDSURL cdsURLHeader = null;
      for (Iterator<ContentBean> iterator = latestContents_news.iterator(); iterator.hasNext(); ) {
        ContentBean headerContent = iterator.next();
        cdsURLHeader = new CDSURL(headerContent.getDefaultChannelID(), headerContent.getContentID(), CDSURL.CDS_URL_PAGE_VIEW, null);
        String viewURL = cdsURLResolver.encode(request, cdsURLHeader, webHandlerManager);
    %>
        <div class="paddingleft">
          <img alt="" src="<%=cdsTemplate%>/images/bullet.gif" border="0"/>
          <a class="content_news" href="<%=viewURL%>" onmouseover="return overlib('<%=URLUtils.escapeQuote(ContentUtil.getContentSummary(request, headerContent, currentLocale))%>');" onmouseout="return nd();"><%=ContentUtil.getContentTitle(headerContent, currentLocale)%></a>
          <%if (permission.isAuthenticated()) {%><span class="date">(<fmt:message key="mvncms.template1.common.views"/>: <%=headerContent.getContentViewCount()%>)</span><% } %>
        </div>
    <%}//for
    } else { %>
      <td class="content_newsleft" width="170" align="center">
        <fmt:message key="mvncms.template1.channel.no_content"/>
    <%}%>
    </td>
  </tr>
</table>
