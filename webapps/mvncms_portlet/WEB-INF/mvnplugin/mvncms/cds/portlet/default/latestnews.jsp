<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/latestnews.jsp,v 1.7 2009/04/08 10:39:15 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.7 $
 - $Date: 2009/04/08 10:39:15 $
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
<%@ page session="false" errorPage="fatalerror.jsp"%>
<%@ page import="com.mvnsoft.mvncms.cds.portlet.common.LatestNewsCollection" %>
<%@include file="inc_common.jsp"%>
<link href="<%=cdsTemplate%>/css/cds.css" rel="stylesheet" type="text/css">

<table cellspacing="0" border="0" cellpadding="0" width="155">
  <tr>
    <td>
      <table border="0" class="tborder" width="100%" cellspacing="1" cellpadding="2" align="left">
        <tr>
          <td valign="top" nowrap class="leftmenu"><div align="center"><fmt:message key="mvncms.common.cds.latest_news" /></div></td>
        </tr>
        <tr>
          <td valign="top" class="leftmenu2">          
          <%
          java.util.Collection latestNews = LatestNewsCollection.getLatestNews();
          for (java.util.Iterator iter = latestNews.iterator(); iter.hasNext(); ) {
              LatestNewsCollection latestNew = (LatestNewsCollection)iter.next();
          %>
              <img alt="bullet" src="<%=request.getContextPath()%>/mvnplugin/mvncms/cds/portlet/default/images/bullet.gif" border="0"/>
              <a class="leftmenu2" href="<%=latestNew.getViewURL()%>"><%=latestNew.getContentBean().getContentTitle()%></a>
              <br />
          <%  }  %>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
