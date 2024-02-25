<%--
  - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/rss_javavietnam.jsp,v 1.4 2009/03/26 11:03:32 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.4 $
  - $Date: 2009/03/26 11:03:32 $
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
<%@ page contentType="text/html;charset=utf-8" %>

<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter"%>
<%@ page import="net.myvietnam.mvncore.util.StringUtil" %>
<%@ page import="com.mvnsoft.mvncms.common.feed.FeedItem"%>

<table width="170" border="0" cellspacing="0" cellpadding="0" class="border_tsbd">
  <tr>   
    <td class="border_newsleft" height="21" align="left"><fmt:message key="mvncms.template1.latestforumthreads.title"/></td>
  </tr>
  <% 
  String JVN_ERROR = "Error@Jvn";
  String JVN_FEED_ITEMS = "FeedItems@Jvn";
  if (request.getAttribute(JVN_ERROR) != null) {
  %>
    <tr>
      <td class="content_newsleft" align="left"><%=request.getAttribute(JVN_ERROR)%></td>
    </tr>
  <%} else { 
    Collection feedItems = (Collection) request.getAttribute(JVN_FEED_ITEMS);
    if (feedItems != null) {
      for ( Iterator iter = feedItems.iterator() ; iter.hasNext() ; ) {
        FeedItem feedItem = (FeedItem) iter.next(); %>
        <tr>   
          <td class="content_newsleft" align="left">
            <img alt="" src="<%=cdsTemplate%>/images/bullet.gif" border="0"/>
            <a class="content_news" href="<%=feedItem.getLink() %>" title="<%=feedItem.getTitle()%>"><%=StringUtil.getShorterString(feedItem.getTitle(), 25) %></a>
          </td>
        </tr>   
    <%} // End For  
    } 
  }
  %>  
</table>