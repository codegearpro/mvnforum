<%--
 - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/news_in_mvnforum_list.jsp,v 1.9 2009/12/24 02:49:40 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.9 $
 - $Date: 2009/12/24 02:49:40 $
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
<%@ page import="java.util.*"%>

<%@ page import="com.mvnsoft.mvncms.db.ChannelBean" %>
<%@ page import="com.mvnsoft.mvncms.db.ContentBean" %>
<%@ page import="com.mvnsoft.mvncms.cds.*"%>
<%@ page import="net.myvietnam.mvncore.util.StringUtil"%>

<%
CDSURLResolver cdsURLResolver = CDSURLResolverFactory.getCDSURLResolver();
CDSURL cdsURL = null;

Collection<ChannelBean> channelBeans = (Collection<ChannelBean>) request.getAttribute("ChannelBeans");
String cdsTemplate = (String) request.getAttribute("CDSTemplate");

boolean shouldShowChannels = false;
for (ChannelBean channelBean :  channelBeans) {
  Collection<ContentBean> contentBeans = channelBean.getContentBeans();
  if (contentBeans.size() != 0) {
    shouldShowChannels = true;
  }
}
%>
<%if (channelBeans.size() != 0 && shouldShowChannels) {%>
<link type="text/css" rel="stylesheet" href="<%=cdsTemplate%>/css/listview.css" />
<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" class="newstbl">
  <tr>
  <%
  for (ChannelBean channelBean :  channelBeans) {
    Collection<ContentBean> contentBeans = channelBean.getContentBeans();
    if (contentBeans.size() != 0) {
  %>
    <td class="col" width="<%=(channelBeans.size() == 0 ? 100 : (100/channelBeans.size()))%>%" valign="top">
      <div class="line"><a href="<%=cdsURLResolver.encode(request, new CDSURL(channelBean.getChannelID(), 0, CDSURL.CDS_URL_PAGE_LIST, null), webHandlerManager)%>" class="newstitle"><%=channelBean.getChannelName()%></a>
        <a href="#">
          <img src="<%=cdsTemplate%>/images/arrow_right.gif" alt="" height="7" width="4" border="0" />
        </a>
      </div>
      <ul class="news">
      <%
      for (ContentBean contentBean : contentBeans) {
        cdsURL = new CDSURL(channelBean.getChannelID(), contentBean.getContentID(), CDSURL.CDS_URL_PAGE_VIEW, null);
      %>
        <li>
          <span>&#8226;</span>&nbsp;<a href="<%=cdsURLResolver.encode(request, cdsURL, webHandlerManager)%>" class="itemlink"><%=StringUtil.getShorterString(ContentUtil.getContentTitle(contentBean, currentLocale), 40)%></a>
        </li>
      <%}%>
      </ul>
    </td>
   <%}// end if%> 
  <%}// end for%>  
  </tr>
</table>
<%}%>
