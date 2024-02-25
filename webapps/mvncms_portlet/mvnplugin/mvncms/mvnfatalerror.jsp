<%--
 - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/mvnfatalerror.jsp,v 1.1 2010/02/26 11:10:51 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.1 $
 - $Date: 2010/02/26 11:10:51 $
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

<%@ page import="net.myvietnam.mvncore.util.MailUtil" %>
<%@ page import="com.mvnforum.MVNForumConfig" %>

<%@ taglib uri="mvntaglib" prefix="mvn" %>

<mvn:html locale="en">
<mvn:head>
  <mvn:title>mvnForum Fatal Error !!!</mvn:title>
<script type="text/javascript" src="<%=request.getContextPath()%>/mvnplugin/mvnforum/js/myvietnam.js"></script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/mvnplugin/mvnforum/css/style.css" />
</mvn:head>
<mvn:body>

<h2 align="center" style="color: blue">mvnPublish Fatal Error Message : <%=request.getAttribute("fatal_error_message")%></h2>
<h3 align="center" style="color: black">If you believe this is a bug, click to:
    <script type="text/javascript">
    //<![CDATA[
      var emailtitle = "<%=MailUtil.getEmailUsername(MVNForumConfig.getWebMasterEmail())%>";
      var emaildomain= "<%=MailUtil.getEmailDomain(MVNForumConfig.getWebMasterEmail())%>";
      writeEmail(emailtitle, emaildomain, "Report fatal error when runing mvnForum", "", "report this error to Website administrator", "command");
    //]]>
    </script>
 </h3>

</mvn:body>
</mvn:html>
