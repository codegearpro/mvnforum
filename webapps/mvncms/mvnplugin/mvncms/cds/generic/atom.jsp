<?xml version="1.0" encoding="utf-8" ?>
<%@ page contentType="text/xml;charset=utf-8" %>
<%@ page errorPage="fatalerror.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="net.myvietnam.mvncore.util.*" %>
<%@ page import="com.mvnsoft.mvncms.*"%>
<%@ page import="com.mvnsoft.mvncms.db.*"%>
<%@ page import="com.mvnsoft.mvncms.cds.*"%>
<%@ page import="com.mvnsoft.mvncms.cds.standard.handler.WebHandlerManager"%>
<% request.setAttribute("contentType", "text/xml;charset=utf-8");%>
<% response.setContentType("text/xml;charset=utf-8");%>
<%
CDSURLResolver cdsURLResolver = CDSURLResolverFactory.getCDSURLResolver();
WebHandlerManager webHandlerManager = (WebHandlerManager) request.getAttribute("WebHandlerManager");

Collection contents = (Collection) request.getAttribute("Contents");
ChannelBean channel = (ChannelBean)request.getAttribute("Channel");
int channelID = channel.getChannelID();
String root = ParamUtil.getServerPath();
String prefix = root + webHandlerManager.getProperty(CDSConstants.PROPERTY_URL_PATTERN);
String logoUrl = ParamUtil.getServerPath() + request.getContextPath() + "/mvnplugin/mvncms/cds/standard/" + webHandlerManager.getTemplate() + "/images/logo.gif";

Timestamp now = DateUtil.getCurrentGMTTimestamp();
String modified = DateUtil.getDateISO8601(now);

CDSURL cdsURL = new CDSURL(channelID, 0, CDSURL.CDS_URL_PAGE_LIST, null);
String listURL = cdsURLResolver.encode(request, cdsURL, webHandlerManager);

String link = listURL;
String channelTitle = "What title ??";
String tagLine;
String copyRight = "Copyright by this site owner";
String authorName = channelTitle + " Editor";
String authorEmail = ""; //please consider spam when putting email here
String generator = "mvnForum Feed Generator";

// Channel specific RSS
String channelName = channel.getChannelName();
channelTitle = "Channel: " + channelName;
tagLine = "ATOM Feed of " + channelTitle;
%>
<feed version="0.3" xmlns="http://purl.org/atom/ns#" xmlns:dc="http://purl.org/dc/elements/1.1/" xml:lang="en">
  <title><%=channelTitle%></title>
  <link rel="alternate" type="text/html" href="<%=root + listURL%>" />
  <modified><%=modified%></modified>
  <tagline><%-- Description --%><%=tagLine%></tagline>
  <copyright><%=copyRight%></copyright>
  <author>
    <name><%=authorName%></name>
    <email></email>
  </author>
  <id><%=channelID%></id>
  <generator><%=generator%></generator>
<%
for (Iterator iter = contents.iterator(); iter.hasNext(); ) {
  ContentBean content = (ContentBean)iter.next();
  cdsURL = new CDSURL(channelID, content.getContentID(), CDSURL.CDS_URL_PAGE_VIEW, null);
  String viewURL = cdsURLResolver.encode(request, cdsURL, webHandlerManager);
%>
  <entry>
    <title><%=content.getContentTitle()%></title>
    <link rel="alternate" type="text/html" href="<%=root + viewURL%>" />
    <id><%=content.getContentID()%></id>
    <issued><%=DateUtil.getDateISO8601(content.getContentCreationDate())%></issued>
    <modified><%=DateUtil.getDateISO8601(content.getContentModifiedDate())%></modified>
    <content><%=content.getContentSummary()%></content>
    <author><name><%=content.getContentByAuthor()%></name></author>
  </entry>
<%}//for%>
</feed>