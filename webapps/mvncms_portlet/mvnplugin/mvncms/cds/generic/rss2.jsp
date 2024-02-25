<?xml version="1.0" encoding="utf-8" ?>
<%@ page contentType="text/xml;charset=utf-8" %>
<%@ page errorPage="fatalerror.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="net.myvietnam.mvncore.util.*" %>
<%@ page import="com.mvnsoft.mvncms.db.*"%>
<%@ page import="com.mvnsoft.mvncms.cds.*"%>
<%@ page import="com.mvnsoft.mvncms.*"%>
<%@ page import="com.mvnsoft.mvncms.cds.standard.handler.WebHandlerManager"%>
<%
CDSURLResolver cdsURLResolver = CDSURLResolverFactory.getCDSURLResolver();
WebHandlerManager webHandlerManager = (WebHandlerManager) request.getAttribute("WebHandlerManager");

Collection contents = (Collection) request.getAttribute("Contents");
ChannelBean channel = (ChannelBean)request.getAttribute("Channel");
String channelName = channel.getChannelName();
int channelID = channel.getChannelID();
String channelTitle = channel.getChannelName();
String channelDesc = channel.getChannelDesc();
String root = ParamUtil.getServerPath();
String prefix = root + webHandlerManager.getProperty(CDSConstants.PROPERTY_URL_PATTERN);
String logoUrl = ParamUtil.getServerPath() + request.getContextPath() + "/mvnplugin/mvncms/cds/standard/" + webHandlerManager.getTemplate() + "/images/logo.gif";

CDSURL cdsURL = new CDSURL(channelID, 0, CDSURL.CDS_URL_PAGE_LIST, null);
String listURL = cdsURLResolver.encode(request, cdsURL, webHandlerManager);

String channelLink = listURL;

Timestamp now = DateUtil.getCurrentGMTTimestamp();
String channelPubDate = DateUtil.getDateRFC822(now);
String channelLastBuildDate = channelPubDate;
String channelDocs = root + listURL;
String channelGenerator = "mvnCMS Feed Generator";
channelTitle = "Channel: " + channelName;
channelDesc  = "RSS Feed of " + channelTitle;
%>
<rss version="2.0">
<channel>
  <title><%=channelTitle%></title>
  <link><%=root + listURL%></link>
  <description><%=channelDesc%></description>
  <language>en-us</language>
<%--  <pubDate><%=channelPubDate%></pubDate> --%>
  <lastBuildDate><%=channelLastBuildDate%></lastBuildDate>
  <docs><%=channelDocs%></docs>
  <generator><%=channelGenerator%></generator>
  <image>
    <title><%=channel.getChannelImageTitle()%></title>
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
    <title><%=content.getContentTitle()%></title>
    <link><%=root + viewURL%></link>
    <description><%=content.getContentSummary()%></description>
    <%-- author><%=threadBean.getMemberName()%></author --%>
    <pubDate><%=DateUtil.getDateRFC822(content.getContentCreationDate())%></pubDate>
    <category><%=channelName%></category>
    <guid><%=root + viewURL%></guid>
  </item>
<% }//for%>
</channel>
</rss>