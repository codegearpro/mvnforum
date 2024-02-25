<%--
  - $Header: /home/cvsroot/mvnad-portlet/srcweb/mvnplugin/mvnad/user/displayad.jsp,v 1.3 2010/08/18 11:05:38 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.3 $
  - $Date: 2010/08/18 11:05:38 $
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
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page session="false" errorPage="fatalerror.jsp"%>

<%@ page import="java.util.*"%>
<%@ page import="com.mvnsoft.mvnad.delivery.AdGenerator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
Collection zones   = (Collection)request.getAttribute("zones");
String vertical    = (String)request.getAttribute("vertical");
boolean isVertical = ("true".equals(vertical));
if (zones.size() > 0) {
%>

<%if (isVertical) {%>
<table cellpadding="2" cellspacing="2" border="0">
  <%for (Iterator iter = zones.iterator(); iter.hasNext(); ) {%>
    <tr>
      <td>
      <%=AdGenerator.getZone(((Integer)iter.next()).intValue())%>
      </td>
    </tr>
  <%}%>
</table>
<%} else {%>
<table cellpadding="2" cellspacing="2" border="0">
  <tr>
  <%for (Iterator iter = zones.iterator(); iter.hasNext(); ) {%>
    <td>
      <%=AdGenerator.getZone(((Integer)iter.next()).intValue())%>
    </td>
  <%}%>
  </tr>
</table>
<%}%>

<%}//end if zones.size() %>
