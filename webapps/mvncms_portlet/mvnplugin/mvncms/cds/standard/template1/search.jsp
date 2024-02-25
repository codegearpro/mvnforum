<%--
 - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/search.jsp,v 1.14 2009/12/14 05:57:31 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.14 $
 - $Date: 2009/12/14 05:57:31 $
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

<%@ page import="java.util.*"%>

<%@ page import="net.myvietnam.mvncore.util.*"%>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter"%>

<%@ page import="com.mvnsoft.mvncms.db.*"%>
<%@ page import="com.mvnsoft.mvncms.cds.standard.*"%>
<%@ page import="com.mvnsoft.mvncms.common.*"%>
<%@ page import="com.mvnforum.common.*"%>
<%@ page import="com.mvnforum.*"%>
<%@ page import="com.mvnforum.db.*"%>
<%@ page import="com.mvnforum.user.*"%>
<%@ page import="com.mvnsoft.mvncms.search.content.ContentSearchQuery"%>

<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>

<%@ include file="inc_common.jsp"%>

<%
// used for init params
String key = ParamUtil.getParameterFilter(request, "key");
String highlightKey = ParamUtil.getParameter(request, "key", false);

ContentSearchQuery searchQuery = (ContentSearchQuery) request.getAttribute("SearchQuery");
//int mode = ((Integer) request.getAttribute("SearchQueryOption")).intValue();
int channel = ((Integer) request.getAttribute("channel")).intValue();
int scope = searchQuery.getScopeInContent();
int sort = searchQuery.getSort();
String fromdate = ParamUtil.getParameterFilter(request, "fromdate");
String todate = ParamUtil.getParameterFilter(request, "todate");

int channelID = webHandlerManager.getPropertyInt(CDSConstants.PROPERTY_ROOT_CHANNEL_ID);// DONT REMOVE ME : current channel when draw js menu

Collection contentBeans = (Collection) request.getAttribute("ContentBeans");
int totalContents = ((Integer) request.getAttribute("TotalContents")).intValue();
int resultPerPage = ParamUtil.getParameterUnsignedInt(request, "rows", 10);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="meta.jsp"%>
<link type="text/css" rel="stylesheet" href="<%=cdsTemplate%>/css/cds.css"/>
<%=StandardCDSUtil.initJSMenu(request, webHandlerManager)%>
<title><fmt:message key="mvncms.template1.common.title"/> - <fmt:message key="mvnforum.user.searchresult.title" bundle="${forum}"/></title>
<script src="<%=cdsTemplate%>/js/avim.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/mvnplugin/mvnforum/js/searchhi.js"></script>
<script type="text/javascript">
//<![CDATA[
function InitParam() {
  <%--
  document.submitFormSearch.mode[0].checked = true;
  <%if ( mode > 0 ) {%>
    for (var i = 0; i<document.submitFormSearch.mode.length; i++) {
      if (document.submitFormSearch.mode[i].value == '<%=mode%>') {
        document.submitFormSearch.mode[i].checked = true;
        break;
      }
    }
  <%}%>
  --%>
  <%if ( channel > 0 ) {%>
    document.submitform.channel.value ='<%=channel%>';
  <%}%>
  <%if ( scope > 0 ) {%>
    document.submitform.scope.value ='<%=scope%>';
  <%}%>
  <%if ( sort > 0 ) {%>
    document.submitform.sort.value ='<%=sort%>';
  <%}%>
  <%if ( fromdate.length() > 0 ) {%>
    document.submitform.fromdate.value ='<%=fromdate%>';
  <%}%>
  <%if ( todate.length() > 0 ) {%>
    document.submitform.todate.value ='<%=todate%>';
  <%}%>
}
//]]>
</script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/menu.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/mvnplugin/mvncms/cms/jscripts/overlib/overlib.js"></script>

<!-- calendar stylesheet -->
<link rel="stylesheet" type="text/css" media="all" href="<%=cdsTemplate%>/jscalendar/calendar-win2k-cold-1.css" title="win2k-cold-1" />

<!-- main calendar program -->
<script type="text/javascript" src="<%=cdsTemplate%>/jscalendar/calendar.js"></script>

<!-- the following script defines the Calendar.setup helper function, which makes
     adding a calendar a matter of 1 or 2 lines of code. -->
<script type="text/javascript" src="<%=cdsTemplate%>/jscalendar/calendar-setup.js"></script>
  
</head>
<body>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
  <table border="0" cellpadding="0" cellspacing="0" width="930" align="center">
    <tr>
      <td colspan="5" width="100%"><%@include file="header.jsp"%></td>
    </tr>
    <tr>
      <td height="5" colspan="5" width="100%"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="100%" height="5"/></td>
    </tr>       
    <tr>
      <%if (isNews == false) { %>
        <td valign="top" width="170" align="left"><%@include file="column_left.jsp"%></td>
        <td valign="top" width="10"><img src="<%=cdsTemplate%>/images/spacer.gif" height="100%" width="10" alt=""/></td>
        <td valign="top" width="750"><%@include file="search_inner.jsp"%></td>
        <td valign="top" width="10"><img src="<%=cdsTemplate%>/images/spacer.gif" height="100%" width="10" alt=""/></td>
        <td valign="top" width="170" align="right"><%@include file="column_right.jsp"%>             
        </td>
      <%} else { %>
        <td valign="top" width="170" align="left"><%@include file="column_left.jsp"%><%@include file="column_right.jsp"%></td>
        <td valign="top" width="10"><img src="<%=cdsTemplate%>/images/spacer.gif" height="100%" width="10" alt=""/></td>
        <td valign="top" width="750"><%@include file="search_inner.jsp"%></td>
      <%} %>
    </tr>
    <tr>
      <td height="5" colspan="5"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="100%" height="5"/></td>
    </tr>
    <%if (isNews == false) { %>
      <tr>
        <td valign="top" colspan="5" width="100%" height="48"><%@include file="footer.jsp"%></td>
      </tr>
    <%} %>
  </table> 
</body>
</html>