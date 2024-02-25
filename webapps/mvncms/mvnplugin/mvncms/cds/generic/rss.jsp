<?xml version="1.0" encoding="utf-8" ?>
<%@ page contentType="text/xml;charset=utf-8" %>
<%@ page errorPage="fatalerror.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="net.myvietnam.mvncore.util.*" %>
<%@ page import="com.mvnforum.auth.*"%>
<%@ page import="com.mvnforum.MVNForumConfig"%>
<%@ page import="com.mvnsoft.mvncms.common.ContentUtil"%>
<%@ page import="com.mvnsoft.mvncms.*"%>
<%@ page import="com.mvnsoft.mvncms.db.*"%>
<%@ page import="com.mvnsoft.mvncms.cds.*"%>
<%@ page import="com.mvnsoft.mvncms.cds.standard.handler.WebHandlerManager"%>

<% request.setAttribute("contentType", "text/xml;charset=utf-8");%>

<%
CDSURLResolver cdsURLResolver = CDSURLResolverFactory.getCDSURLResolver();
WebHandlerManager webHandlerManager = (WebHandlerManager) request.getAttribute("WebHandlerManager");

OnlineUserManager onlineUserManager = OnlineUserManager.getInstance();
OnlineUser onlineUser = onlineUserManager.getOnlineUser(request);
String currentLocale = webHandlerManager.getProperty(CDSConstants.PROPERTY_LANGUAGE);
if (StringUtil.isNullOrEmpty(currentLocale)) {
    currentLocale = onlineUser.getLocaleName();
}
if (StringUtil.isNullOrEmpty(currentLocale)) {
    currentLocale = MVNForumConfig.getDefaultLocaleName();
}

Collection contents = (Collection) request.getAttribute("Contents");
ChannelBean channel = (ChannelBean) request.getAttribute("Channel");
int channelID = channel.getChannelID();
String root = ParamUtil.getServerPath();
String prefix = root + webHandlerManager.getProperty(CDSConstants.PROPERTY_URL_PATTERN);
String logoUrl = ParamUtil.getServerPath() + request.getContextPath() + "/mvnplugin/mvncms/cds/standard/" + webHandlerManager.getTemplate() + "/images/logo.gif";

CDSURL cdsURL = new CDSURL(channelID, 0, CDSURL.CDS_URL_PAGE_LIST, null);
String listURL = cdsURLResolver.encode(request, cdsURL, webHandlerManager);

String channelLink = listURL;
String channelTitle;
String channelDesc = channel.getChannelDesc();
// Channel specific RSS
String channelName = channel.getChannelName();
channelTitle = "Channel: " + channelName;
String tagLine = "ATOM Feed of " + channelTitle;
%>
<rss version="0.91">
<channel>
  <title><%=channelTitle%></title>
  <link><%=root + listURL%></link>
  <description><%=channelDesc%></description>
  <language>en-us</language>

  <image>
    <title>mvnCMS RSS</title>
    <url><%=logoUrl%></url>
    <link><%=logoUrl%></link>
    <width>141</width>
    <height>50</height>
    <description>mvnCMS - mvn Content Publishing</description>
  </image>

  <textInput>
    <title>Search</title>
    <description>Search Content</description>
    <name>Search Key</name>
    <link><%=prefix%>/search</link>
  </textInput>
<%
for (Iterator iter = contents.iterator(); iter.hasNext(); ) {
  ContentBean content = (ContentBean)iter.next();
  cdsURL = new CDSURL(channelID, content.getContentID(), CDSURL.CDS_URL_PAGE_VIEW, null);
  String viewURL = cdsURLResolver.encode(request, cdsURL, webHandlerManager);
%>
  <item>
    <title><%=ContentUtil.getContentTitle(content, currentLocale)%></title>
    <link><%=ParamUtil.getServerPath() + viewURL%></link>
    <description><%=ContentUtil.getContentSummary(request, content, currentLocale)%></description>
  </item>
<% }//for%>
</channel>
</rss>

