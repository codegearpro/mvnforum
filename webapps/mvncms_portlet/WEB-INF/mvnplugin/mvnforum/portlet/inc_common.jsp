<%--
  - $Header: /home/cvsroot/portlet-mvnforum/srcweb/WEB-INF/mvnplugin/mvnforum/portlet/inc_common.jsp,v 1.9 2010/08/20 05:16:10 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.9 $
  - $Date: 2010/08/20 05:16:10 $
  -
  - ====================================================================
  -
  - Copyright (C) 2002-2010 by MyVietnam.net
  -
  - MyVietnam.net PROPRIETARY/CONFIDENTIAL PROPERTIES. Use is subject to license terms.
  - You CANNOT use this software unless you receive a written permission from MyVietnam.net
  -
  - @author: MyVietnam.net developers
  -
--%>
<%@ page import="net.myvietnam.mvncore.web.*" %>

<%@ page import="net.myvietnam.mvncore.service.MvnCoreServiceFactory" %>
<%@ page import="net.myvietnam.mvncore.service.URLResolverService" %>
<%@ page import="net.myvietnam.mvncore.service.EnvironmentService" %>

<%@ page import="com.mvnforum.auth.OnlineUser" %>
<%@ page import="com.mvnforum.auth.OnlineUserManager" %>
<%@ page import="com.mvnforum.auth.MVNForumPermission" %>
<%@ page import="com.mvnforum.db.DAOFactory"%>
<%@ page import="com.mvnforum.db.MemberDAO"%>
<%@ page import="com.mvnforum.MVNForumConfig" %>
<%@ page import="com.mvnforum.MyUtil" %>
<%@ page import="com.mvnforum.service.MvnForumInfoService" %>
<%@ page import="com.mvnforum.service.MvnForumServiceFactory" %>
<%@ page import="com.mvnforum.service.MvnForumAdService" %>

<%@ taglib uri="mvntaglib" prefix="mvn" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<%
// I have to comment these below line because when back a page,
// the page is reload, so user have to type data again
//response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
//response.setHeader("Pragma","no-cache"); //HTTP 1.0
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
MvnForumAdService mvnForumAdService = MvnForumServiceFactory.getMvnForumService().getMvnForumAdService();
MemberDAO memberDAO = DAOFactory.getMemberDAO();
%>
<fmt:setLocale value="${currentLocale}" />
<%
response.setContentType("text/html; charset=utf-8");
%>