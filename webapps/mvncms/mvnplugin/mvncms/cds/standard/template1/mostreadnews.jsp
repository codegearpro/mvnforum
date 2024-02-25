<%--
  - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/mostreadnews.jsp,v 1.9 2009/12/24 03:35:49 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.9 $
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

<table border="0" class="border_tsbd" width="170" cellspacing="0" cellpadding="0">
  <tr>
    <td class="border_newsleft" height="21"><fmt:message key="mvncms.template1.mostreadnews.title"/></td>                              
  </tr>
  <tr>                        
    <%
    Collection<ContentBean> mostReadContents = (Collection<ContentBean>) request.getAttribute("ContentBeans@MostViewTinCNTT");
    if ((mostReadContents != null) && (mostReadContents.size() != 0 )) {
    %>
      <td class="content_newsleft" width="170" align="left">
    <%    
      CDSURL cdsURLHeader = null;
      for (ContentBean mostReadContent : mostReadContents) {
        cdsURLHeader = new CDSURL(mostReadContent.getDefaultChannelID(), mostReadContent.getContentID(), CDSURL.CDS_URL_PAGE_VIEW, null);
        String viewURL = cdsURLResolver.encode(request, cdsURLHeader, webHandlerManager);
    %>
        <div class="paddingleft">
          <img alt="bullet" src="<%=cdsTemplate%>/images/bullet.gif" border="0" />
          <a class="content_news" href="<%=viewURL%>" onmouseover="return overlib('<%=URLUtils.escapeQuote(ContentUtil.getContentSummary(request, mostReadContent, currentLocale))%>');" onmouseout="return nd();"><%=ContentUtil.getContentTitle(mostReadContent, currentLocale)%></a>
          <%if (permission.isAuthenticated()) {%><span class="date">(<fmt:message key="mvncms.template1.common.views"/>: <%=mostReadContent.getContentViewCount()%>)</span><% } %>
        </div>
    <%} //for
    } else { // if %>
      <td class="content_newsleft" width="170" align="center">
        <fmt:message key="mvncms.template1.channel.no_content"/>
    <%}%>
    </td>                             
  </tr>                            
</table>