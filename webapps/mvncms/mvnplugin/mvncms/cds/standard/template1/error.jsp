<%--
  - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/error.jsp,v 1.5 2009/12/14 04:42:42 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.5 $
  - $Date: 2009/12/14 04:42:42 $
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
<%@ page session="true" isErrorPage="false"%>

<%@ page import="net.myvietnam.mvncore.util.*" %>

<%@ include file="inc_common.jsp"%>
<%
int channelID = webHandlerManager.getPropertyInt(CDSConstants.PROPERTY_ROOT_CHANNEL_ID);// DONT REMOVE ME : current channel when draw js menu
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <title><fmt:message key="mvncms.template1.error.title"/></title>
  <link href="<%=cdsTemplate%>/css/cds.css" rel="stylesheet" type="text/css">
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="1000" align="center">
  <tr>
    <td colspan="5" width="1000"><%@include file="header.jsp"%></td>
  </tr>
  <tr>
    <td height="5" colspan="5" width="1000"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="1000" height="5"/></td>
  </tr>   
  <tr>
    <td>
      <h1 align="center"><fmt:message key="mvncms.template1.error.title"/>:</h1>
      <div align="center"><font color="red"><%=session.getAttribute("ErrorMessage")%></font></div>
      <br/>&nbsp;
      <br/>&nbsp;
      <br/>&nbsp;
      <br/>&nbsp;
      <br/>&nbsp;
      <script type="text/javascript">
      //<![CDATA[
        window.setInterval("history.go(-1)", 5000);
      //]]>
      </script>
    </td>
  </tr>
  <tr>
    <td height="5" colspan="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="1000" height="5"/></td>
  </tr> 
  <%if (isNews == false) { %> 
    <tr>
      <td valign="top" colspan="5" width="1000" height="48"><%@include file="footer.jsp"%></td>
    </tr>
  <%} %>
</table>

</body>
</html>