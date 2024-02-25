<%--
 - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/max_http_request.jsp,v 1.1 2010/02/26 11:10:51 xuantl Exp $
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

<%@ taglib uri="mvntaglib" prefix="mvn" %>

<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title>Max HTTP Request Error</mvn:title>
</mvn:head>
<mvn:body>
<table width="100%" height="100%">
  <tr>
    <td>
      <table width="80%" border="5" cellspacing="0" align="center" cellspadding="3">
        <tr>
          <td align="center">
            <font size="+1">
            &nbsp;<br/>
            <%=(String) request.getAttribute("FloodMessage")%>
            <br/>
            <br/>
            &nbsp;<br/>
            </font>
            Powered by <a href="http://www.mvnforum.com" target="_blank">mvnForum</a>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</mvn:body>
</mvn:html>
