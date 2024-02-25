<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/im/inc_common.jsp,v 1.16 2009/03/30 08:23:38 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.16 $
 - $Date: 2009/03/30 08:23:38 $
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
<%@ page import="net.myvietnam.mvncore.web.*" %>
<%@ page import="net.myvietnam.mvncore.service.EnvironmentService" %>
<%@ page import="net.myvietnam.mvncore.service.URLResolverService" %>
<%@ page import="net.myvietnam.mvncore.service.MvnCoreServiceFactory" %>

<%@ page import="com.mvnforum.auth.OnlineUser" %>
<%@ page import="com.mvnforum.auth.OnlineUserManager" %>
<%@ page import="com.mvnforum.auth.MVNForumPermission" %>
<%@ page import="com.mvnforum.MVNForumConfig" %>
<%@ page import="com.mvnforum.MyUtil" %>
<%@ page import="com.mvnforum.service.MvnForumServiceFactory" %>
<%@ page import="com.mvnforum.service.MvnForumInfoService" %>

<%@ taglib uri="mvntaglib" prefix="mvn" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<%
// I have to comment these below line because when back a page,
// the page is reload, so user have to type data again
//response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
//response.setHeader("Pragma", "no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server

String contextPath = request.getContextPath();

//String currentLocale = "[mvnforum.common.i18n.locale]";

URLResolverService urlResolver = MvnCoreServiceFactory.getMvnCoreService().getURLResolverService();
EnvironmentService environmentService = MvnCoreServiceFactory.getMvnCoreService().getEnvironmentService();

OnlineUserManager onlineUserManager = OnlineUserManager.getInstance();
OnlineUser onlineUser = onlineUserManager.getOnlineUser(request);
MVNForumPermission permission = onlineUser.getPermission();
String memberName = onlineUser.getMemberName();
int memberID = onlineUser.getMemberID();

String currentLocale = onlineUser.getLocaleName();
if (currentLocale.equals("")) currentLocale = MVNForumConfig.getDefaultLocaleName();
pageContext.setAttribute("currentLocale", currentLocale);
boolean isServlet = (environmentService.isPortlet() == false || request.getAttribute("javax.portlet.request") == null);
boolean isPortlet = !isServlet;
boolean externalUserDatabase = MVNForumConfig.getEnableExternalUserDatabase();
boolean internalUserDatabase = !externalUserDatabase;
MvnForumInfoService mvnForumInfo = MvnForumServiceFactory.getMvnForumService().getMvnForumInfoService();
%>
<fmt:setLocale value="${currentLocale}" />
<%
response.setContentType("text/html; charset=utf-8");
%>
