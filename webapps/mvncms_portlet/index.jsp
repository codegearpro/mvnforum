<%--
  - $Header: /home/cvsroot/mvncms/srcweb/index.jsp,v 1.6 2010/02/22 09:49:51 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.6 $
  - $Date: 2010/02/22 09:49:51 $
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
<%@ page import="com.mvnsoft.mvncms.MVNCmsConfig" %>
<%@ page import="net.myvietnam.mvncore.service.EnvironmentService" %>
<%@ page import="net.myvietnam.mvncore.service.MvnCoreServiceFactory" %>
<%
StringBuffer buffer = new StringBuffer();
buffer.append(request.getContextPath());
EnvironmentService environmentService = MvnCoreServiceFactory.getMvnCoreService().getEnvironmentService();
if ("Datanium".equalsIgnoreCase(environmentService.customizeFor())) {
    buffer.append("/en/ta/home/index.html");
} else {
    buffer.append(MVNCmsConfig.getDefaultURLPattern());
}
response.sendRedirect(buffer.toString());
%>
