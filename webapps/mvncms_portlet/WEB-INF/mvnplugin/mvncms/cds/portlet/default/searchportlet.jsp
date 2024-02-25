<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/searchportlet.jsp,v 1.12 2009/11/25 04:36:08 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.12 $
 - $Date: 2009/11/25 04:36:08 $
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
<%-- including file --%>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page session="false" errorPage="fatalerror.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mvnsoft.mvncms.cds.portlet.common.HotNewsCollection" %>
<%@ page import="com.mvnsoft.mvncms.cds.portlet.common.LatestNewsCollection" %>
<%@ page import="com.mvnsoft.mvncms.db.*"%>
<%@ page import="com.mvnsoft.mvncms.cds.portlet.common.SearchNewsPortletCollection"%>
<%@include file="inc_common.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">

<link type="text/css" media="all" href="css/tabtastic.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" media="all" href="<%=cdsTemplate%>/css/style.css" />
<script type="text/javascript" src="<%=cdsTemplate%>/js/addclasskillclass.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/attachevent.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/addcss.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/tabtastic.js"></script>
<script type="text/javascript">
//<![CDATA[
function trim(str) {
  return str.replace(/(^\s+)([^\s]*)(\s+$)/, '$2');
}
function isBlank(field, strBodyHeader) {
  strTrimmed = trim(field.value);
  if (strTrimmed.length > 0) return false;
  alert(strBodyHeader);
  field.focus();
  return true;
}
function clickFormSearchPortlet() {
  if (ValidateFormSearchPortlet() == true ) {
    document.submitFormSearchPortlet.submit();
  }
}
function ValidateFormSearchPortlet() {
  if (isBlank(document.submitFormSearchPortlet.key, 'Từ khóa tìm kiếm chưa được nhập.')) return false;
  return true;
}
//]]>
</script>

<table width="240" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
     <div class="search_box"><img src="<%=cdsTemplate%>/images/search_icon.gif" alt="" class="icon_box" /><fmt:message key="mvnforum.common.action.search"/></div>
     <div class="border_search_box">
       <div class="border_search_box_inner">
         <form action="<%=urlResolver.encodeURL(request, response, "searchportletresult", URLResolverService.ACTION_URL)%>" name="submitFormSearchPortlet" method="post">
             <%=urlResolver.generateFormAction(request, response, "searchportletresult")%>
             <div class="search_box_inner">
                <input type="text" id="key" name="key" class="inp_search_box" /><input type="button" id="timkiem" class="btn" value="<fmt:message key="mvnforum.common.action.search_btn"/>" onclick="javascript:clickFormSearchPortlet();"/>
             </div>
          </form>
          <div style="padding:0 0 10px 5px;"><a class="next_link" href="<%=urlResolver.encodeURL(request, response, "searchportletadvance", URLResolverService.ACTION_URL)%>" ><fmt:message key="mvnforum.common.action.advanced_search"/></a></div>
        </div>
      </div>
    </td>
  </tr>
</table>
</fmt:bundle>