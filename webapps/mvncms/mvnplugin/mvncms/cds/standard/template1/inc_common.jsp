<%--
  - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/inc_common.jsp,v 1.17 2009/12/24 02:49:40 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.17 $
  - $Date: 2009/12/24 02:49:40 $
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
<%@ page import="net.myvietnam.mvncore.service.MvnCoreServiceFactory" %>
<%@ page import="net.myvietnam.mvncore.service.EnvironmentService" %>
<%@ page import="net.myvietnam.mvncore.service.URLResolverService" %>
<%@ page import="net.myvietnam.mvncore.util.StringUtil"%>
<%@ page import="com.mvnforum.MVNForumConfig"%>
<%@ page import="com.mvnforum.auth.*"%>
<%@ page import="com.mvnsoft.mvnad.delivery.AdGenerator"%>
<%@ page import="com.mvnsoft.mvncms.cds.*"%>
<%@ page import="com.mvnsoft.mvncms.common.ContentUtil"%>
<%@ page import="com.mvnsoft.mvncms.cds.standard.configlayout.tincntt.ConfigLayoutTinCNTT"%>
<%@ page import="com.mvnsoft.mvncms.cds.standard.handler.WebHandlerManager"%>
<%@ page import="com.mvnsoft.mvncms.service.MvnCmsInfoService"%>
<%@ page import="com.mvnsoft.mvncms.service.MVNCMSServiceFactory"%>

<%@ taglib uri="mvntaglib" prefix="mvn" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<%
  OnlineUserManager onlineUserManager = OnlineUserManager.getInstance();
  OnlineUser onlineUser = onlineUserManager.getOnlineUser(request);
  MVNForumPermission permission = onlineUser.getPermission();
  
  MvnCmsInfoService mvnCmsInfo = MVNCMSServiceFactory.getMVNCMSService().getMvnCmsInfoService();
  WebHandlerManager webHandlerManager = (WebHandlerManager) request.getAttribute("WebHandlerManager");
  
  String currentLocale = webHandlerManager.getProperty(CDSConstants.PROPERTY_LANGUAGE);
  if (StringUtil.isNullOrEmpty(currentLocale)) {
      currentLocale = onlineUser.getLocaleName();
  }
  if (StringUtil.isNullOrEmpty(currentLocale)) {
      currentLocale = MVNForumConfig.getDefaultLocaleName();
  }
  pageContext.setAttribute("currentLocale", currentLocale);

  CDSURLResolver cdsURLResolver = CDSURLResolverFactory.getCDSURLResolver();
  CDSURL cdsURL = null;
  

  //default cdsTemplate
  String cdsTemplate = request.getContextPath() + "/mvnplugin/mvncms/cds/standard/default";
  if (webHandlerManager.getTemplate().length() > 0) {
    cdsTemplate = request.getContextPath() + "/mvnplugin/mvncms/cds/standard/" + webHandlerManager.getTemplate();
  }
  ConfigLayoutTinCNTT configLayout = ConfigLayoutTinCNTT.getInstance();
  
  URLResolverService urlResolver = MvnCoreServiceFactory.getMvnCoreService().getURLResolverService();
  EnvironmentService environmentService = MvnCoreServiceFactory.getMvnCoreService().getEnvironmentService();
  boolean isServlet = (environmentService.isPortlet() == false || request.getAttribute("javax.portlet.request") == null);
  boolean isPortlet = !isServlet;
  boolean isNews = "true".equals(request.getAttribute("isNews"));
%>

<fmt:setLocale value="${currentLocale}" />
<fmt:setBundle basename="i18n/mvncms/cds/standard/template1/mvnCMS_i18n" />
<fmt:setBundle basename="i18n/mvnforum/mvnForum_i18n" var="forum"/>