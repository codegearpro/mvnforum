<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/inc_common.jsp,v 1.6 2009/12/05 05:42:18 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.6 $
 - $Date: 2009/12/05 05:42:18 $
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
<%@ page import="com.mvnforum.auth.*"%>
<%@ page import="com.mvnforum.MVNForumConfig"%>
<%@ page import="com.mvnsoft.mvncms.MVNCmsConfig"%>
<%@ page import="com.mvnsoft.mvncms.service.MvnCmsInfoService"%>
<%@ page import="com.mvnsoft.mvncms.service.MVNCMSServiceFactory"%>
<%@ page import="net.myvietnam.mvncore.service.URLResolverService" %>
<%@ page import="net.myvietnam.mvncore.service.MvnCoreServiceFactory" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
URLResolverService urlResolver = MvnCoreServiceFactory.getMvnCoreService().getURLResolverService();
MvnCmsInfoService mvnCmsInfo = MVNCMSServiceFactory.getMVNCMSService().getMvnCmsInfoService();
//default cdsTemplate
OnlineUserManager onlineUserManager = OnlineUserManager.getInstance();
OnlineUser onlineUser = onlineUserManager.getOnlineUser(request);
MVNForumPermission permission = onlineUser.getPermission();
String currentLocale = onlineUser.getLocaleName();
if (currentLocale.equals("")) currentLocale = MVNForumConfig.getDefaultLocaleName();
pageContext.setAttribute("currentLocale", currentLocale);

String contextPath = request.getContextPath();
String cdsTemplate = request.getContextPath() + "/mvnplugin/mvncms/cds/portlet/default";
%>
<fmt:setLocale value="${currentLocale}" />
<fmt:setBundle basename="i18n/mvncms/mvncms_i18n" />