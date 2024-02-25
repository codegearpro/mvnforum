<%--
 - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/news_in_mvnforum_tab.jsp,v 1.6 2009/12/24 02:49:40 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.6 $
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

<%@ page import="net.myvietnam.mvncore.util.StringUtil"%>
<%@ page import="com.mvnsoft.mvncms.db.ChannelBean" %>
<%@ page import="com.mvnsoft.mvncms.db.ContentBean" %>
<%@ page import="com.mvnsoft.mvncms.cds.*"%>

<%
CDSURLResolver cdsURLResolver = CDSURLResolverFactory.getCDSURLResolver();
CDSURL cdsURL = null;

Collection<ChannelBean> channelBeans = (Collection<ChannelBean>) request.getAttribute("ChannelBeans");
String cdsTemplate = (String) request.getAttribute("CDSTemplate");

boolean shouldShowChannels = false;
int maxContentCount = 0;
for (ChannelBean channelBean :  channelBeans) {
  Collection<ContentBean> contentBeans = channelBean.getContentBeans();
  if (contentBeans.size() != 0) {
    shouldShowChannels = true;
    maxContentCount = (maxContentCount > contentBeans.size()) ? maxContentCount:contentBeans.size();
  }
}
%>
<%if (channelBeans.size() != 0 && shouldShowChannels) {%>
<script type="text/javascript" src="<%=cdsTemplate%>/js/yahoo-dom-event.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/element-beta.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/tabview.js"></script>
<link type="text/css" rel="stylesheet" href="<%=cdsTemplate%>/css/tabview.css" />
<!--there is no custom header content for this example-->

<div class="yui-skin-sam">
  <!--BEGIN SOURCE CODE FOR EXAMPLE =============================== -->

  <div id="content" class="yui-navset">
    <ul class="yui-nav">
    <%
    int channelIndex = 0;
    for (ChannelBean channelBean :  channelBeans) {
      Collection<ContentBean> contentBeans = channelBean.getContentBeans();
      if (contentBeans.size() != 0) {
        channelIndex++;
    %>
      <li<%if (channelIndex == 1) {%> class="selected"<%}%>><a href="#tab<%=channelIndex%>"><em><%=StringUtil.getShorterString(channelBean.getChannelName(), 30)%></em></a></li>
      <%}%>
    <%}%>
    </ul>            
    <div class="yui-content">
    <%
    for (ChannelBean channelBean :  channelBeans) {
      Collection<ContentBean> contentBeans = channelBean.getContentBeans();
      if (contentBeans.size() != 0) {
    %>
      <div class="pad1">
      <%
        int currentContentCount = 0;
        for (ContentBean contentBean : contentBeans) {
          cdsURL = new CDSURL(channelBean.getChannelID(), contentBean.getContentID(), CDSURL.CDS_URL_PAGE_VIEW, null);
          currentContentCount++;
      %>
        <div class="padlinktab">
        &#8226;&nbsp;<a href="<%=cdsURLResolver.encode(request, cdsURL, webHandlerManager)%>" class="linknewtab"><%=StringUtil.getShorterString(ContentUtil.getContentTitle(contentBean, currentLocale), 100)%></a>
        </div>
        <%}//end for%>
        <%
        int leftContentCount = maxContentCount - currentContentCount;
        if (leftContentCount > 0) {
          for (int i = 0; i < leftContentCount; i++) {%>              
        <br />
        <%
          }
        }%>
      </div>
      <%}//end if%>
    <%}//end for%>
    </div>
  </div>

<script type="text/javascript">
//<![CDATA[
(function() {
    var tabView = new YAHOO.widget.TabView('content');

})();
//]]>
</script>

<!--END SOURCE CODE FOR EXAMPLE =============================== -->

</div>

<%}%>
