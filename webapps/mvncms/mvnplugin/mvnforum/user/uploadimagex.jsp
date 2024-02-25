<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/uploadimagex.jsp,v 1.37 2010/06/22 10:15:24 minhnn Exp $
 - $Author: minhnn $
 - $Revision: 1.37 $
 - $Date: 2010/06/22 10:15:24 $
 -
 - ====================================================================
 -
 - Copyright (C) 2002-2007 by MyVietnam.net
 -
 - MyVietnam.net PROPRIETARY/CONFIDENTIAL PROPERTIES. Use is subject to license terms.
 - You CANNOT use this software unless you receive a written permission from MyVietnam.net
 -
 - @author: MyVietnam.net developers
 -
--%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="net.myvietnam.mvncore.util.ParamUtil"%>
<%@ page import="net.myvietnam.mvncore.util.DateUtil"%>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter"%>
<%@ page import="net.myvietnam.mvncore.MVNCoreConfig"%>
<%@ page import="net.myvietnam.mvncore.MVNCoreGlobal"%>
<%@ page import="net.myvietnam.mvncore.security.SecurityUtil"%>
<%@ page import="com.mvnforum.MVNForumConfig"%>
<%@ page import="com.mvnforum.db.*"%>
<%@ page import="com.mvnforum.user.*"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.uploadimagex.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<%
PostBean postBean = (PostBean) request.getAttribute("PostBean");
ThreadBean threadBean = (ThreadBean) request.getAttribute("ThreadBean");
ForumCache forumCache = ForumCache.getInstance();
int forumID = postBean.getForumID();
String forumName = forumCache.getBean(forumID).getForumName();
int threadID = threadBean.getThreadID();
String threadName = threadBean.getThreadTopic();
String offset = ParamUtil.getParameterFilter(request, "offset");// should get from request.getAttribute()
int postID = postBean.getPostID();
%>
<br />
<div class="nav center">
  <%= request.getAttribute("tree") %>
</div>
<br/>

<div class="pagedesc">
  <fmt:message key="mvnforum.user.uploadimagex.info"/>
</div>
<br/>

<center>
  <%
    String url = urlResolver.encodeURL(request, response, "uploadimageprocess", URLResolverService.ACTION_URL);
    String redirectUrl = urlResolver.encodeURL(request, response, "viewthread?thread=" + threadID + "&amp;offset=" + offset + "#" + postID);
    if (url != null && ((url.startsWith("http://") == false) && (url.startsWith("https://") == false))) {
        if (isPortlet) {
            url = ParamUtil.getServer(request) + url;
        } else { 
            url = ParamUtil.getServer(request) + contextPath + UserModuleConfig.getUrlPattern() + "/" + url;
        }
    }
    if (redirectUrl != null && ((redirectUrl.startsWith("http://") == false) && (redirectUrl.startsWith("https://") == false))) {
        if (isPortlet) {
            redirectUrl = ParamUtil.getServer(request) + redirectUrl;
        } else {
            redirectUrl = ParamUtil.getServer(request) + contextPath + UserModuleConfig.getUrlPattern() + "/" + redirectUrl;
        }
    }
  %>
  <%-- Not sure if we need log4j-1.2.15.jar or not --%>
  <applet codebase="<%=contextPath%>/mvnplugin/mvnforum/applet/"
          code="ClipboardImage"
          archive="<%=contextPath%>/mvnplugin/mvnforum/applet/image-upload.jar,
                   <%=contextPath%>/mvnplugin/mvnforum/applet/commons-httpclient-3.0.1.jar,
                   <%=contextPath%>/mvnplugin/mvnforum/applet/commons-logging-1.1.1.jar,
                   <%=contextPath%>/mvnplugin/mvnforum/applet/commons-codec-1.3.jar"
          width="750" height="500">
    <param name="<%=MVNCoreGlobal.MVNCORE_SECURITY_TOKEN%>" value="<%=SecurityUtil.getSessionToken(request)%>" />
    <param name="JSESSIONID" value="<%=session.getId()%>" />
    <param name="url" value="<%=url%>" />
    <param name="redirectUrl" value="<%=redirectUrl%>" />
    <param name="offset" value="<%=offset%>" />
    <param name="post" value="<%=postBean.getPostID()%>" />
    <param name="maxage" value="<%=session.getMaxInactiveInterval()%>" />
  </applet>
</center>
<br/>
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>