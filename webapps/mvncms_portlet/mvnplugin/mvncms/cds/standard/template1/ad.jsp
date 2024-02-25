<%--
 - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/ad.jsp,v 1.2 2009/03/30 07:14:29 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.2 $
 - $Date: 2009/03/30 07:14:29 $
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
<%@ page session="false" errorPage="fatalerror.jsp"%>

<%@ include file="inc_common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><fmt:message key="mvncms.template1.common.title"/> - <fmt:message key="mvncms.template1.ad.title"/></title>
<link type="text/css" rel="stylesheet" href="<%=cdsTemplate%>/css/cds.css" />
</head>
<body>

<table border="0" cellpadding="0" cellspacing="0" width="98%" align="center">
  <tr>
    <td width="100%"><%@include file="header.jsp"%></td>
  </tr>
  <tr>
    <td height="5" colspan="5" width="100%"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="100%" height="5"/></td>
  </tr>
  <tr>
    <td align="center">
      <img src="<%=cdsTemplate%>/images/ad.jpg" alt=""/>
    </td>
  </tr>
  <tr>
    <td valign="top" width="100%" height="48"><%@include file="footer.jsp"%></td>
  </tr>
  
</table>

</body>
</html>