<%--
 - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/configheader.jsp,v 1.3 2009/12/14 04:42:42 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.3 $
 - $Date: 2009/12/14 04:42:42 $
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
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.mvnforum.MVNForumConfig"%>
<%@ page import="com.mvnforum.user.UserModuleConfig"%>

<table class="tborder" width="95%" cellspacing="1" cellpadding="2" align="center">
  <tr class="topmenu">
    <td nowrap="nowrap">&nbsp;
      <span class="welcomeHeader">Welcome </span>
      <%if (onlineUser.isMember()) {%>
        <font color="#FF0000"><%=onlineUser.getMemberName()%></font>
      <%}%>
      &nbsp;|&nbsp;<a href="<%=request.getContextPath() + webHandlerManager.getProperty(CDSConstants.PROPERTY_URL_PATTERN)%>" class="topmenu"> Home</a>
      &nbsp;|&nbsp;<a href="<%=request.getContextPath() + webHandlerManager.getProperty(CDSConstants.PROPERTY_URL_PATTERN)%>/confighome" class="topmenu"> Config CMS Layout</a>
    <%if (MVNForumConfig.getEnableLogin()) {%>
      &nbsp;|&nbsp;<a class="command" href="<%=request.getContextPath() + UserModuleConfig.getUrlPattern()%>/logout"> Log out</a>
    <%}%>
    </td>
  </tr>
</table>