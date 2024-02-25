<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/searchportletresult.jsp,v 1.13 2009/12/08 03:13:20 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.13 $
 - $Date: 2009/12/08 03:13:20 $
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
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page session="false" errorPage="fatalerror.jsp"%>

<%@ page import="java.util.*"%>
<%@ page import="net.myvietnam.mvncore.filter.*"%>
<%@ page import="net.myvietnam.mvncore.security.*"%>
<%@ page import="net.myvietnam.mvncore.util.*"%>
<%@ page import="com.mvnsoft.mvncms.cds.*"%>
<%@ page import="com.mvnsoft.mvncms.db.*"%>
<%@ page import="com.mvnsoft.mvncms.search.content.*"%>

<%@ include file="inc_common.jsp"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>

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
function clickFormSearch() {
  if (ValidateFormSearch() == true ) {
    document.submitFormSearch.submit();
  }
}
function ValidateFormSearch() {
  if (isBlank(document.submitFormSearch.key, 'Từ khóa tìm kiếm chưa được nhập.')) return false;
  return true;
}
//]]>
</script>

<%
String key = ParamUtil.getParameter(request, "key");
String highlightKey = ParamUtil.getParameter(request, "key", false);
CDSURLResolver cdsURLResolver = CDSURLResolverFactory.getCDSURLResolver();
Collection ContentSearchBeans = (Collection) request.getAttribute("ContentBeans");
int totalContents = ((Integer) request.getAttribute("TotalContents")).intValue();
int resultPerPage = ParamUtil.getParameterUnsignedInt(request, "rows", 10);
%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>    
      <div id="tab1" class="tabset_content tabset_content_active">
        <div class="title_search"><fmt:message key="mvnforum.common.action.search"/></div>
    
        <form action="<%=urlResolver.encodeURL(request, response, "searchportletresult", URLResolverService.ACTION_URL)%>" name="submitFormSearch" method="post">
          <%=urlResolver.generateFormAction(request, response, "searchportletresult")%>     
          <div style="padding:15px 5px 30px 10px;">
             <input type="text" id="key" name="key" class="textfield" value="<%=key%>" />&nbsp;&nbsp;<input type="button" id="timkiem" class="btn" value="<fmt:message key="mvnforum.common.action.search_btn"/>" onclick="clickFormSearch();"/>
             &nbsp;&nbsp;<a href="<%=urlResolver.encodeURL(request, response, "searchportletadvance", URLResolverService.ACTION_URL)%>" ><fmt:message key="mvnforum.common.action.advanced_search"/></a>
          </div>
        </form> 
  
        <div class="kqtk"><fmt:message key="mvnforum.user.searchresult.title"/></div>
        <div style="padding:5px 0 10px 0">
  
        <pg:pager
          url="searchportletresult"
          items="<%=totalContents%>"
          maxPageItems="<%=resultPerPage%>"
          isOffset="true"
          export="offset,currentPageNumber=pageNumber"
          scope="request">
          <pg:param name="key"/>
          <pg:param name="rows"/>
          <%
            if (ContentSearchBeans.size() > 0) {
                String _highlightKey = "";
                if (highlightKey.length() > 0) {
                  _highlightKey = "?hl=" + Encoder.encodeURL(highlightKey);
                }
                for (Iterator iterator = ContentSearchBeans.iterator(); iterator.hasNext(); ) {
                  ContentBean moreContentBean = (ContentBean) iterator.next();
                  String viewURL = urlResolver.encodeURL(request, response, "viewcontent?contentID="
                          + moreContentBean.getContentID() + "&amp;key=" + key + "&amp;offset=" + offset + "&amp;searchtype=normal");
                %>
                  <pg:item>
                     <ul class="icon">
                       <li>
                          <a href="<%=viewURL%>" class="vb_link"><%= moreContentBean.getContentTitle()%></a>
                          <span class="content_publishdate">(<%=onlineUser.getGMTDateFormat(moreContentBean.getContentPublishStartDate())%>)</span>
                          <div class="content_body"><%=moreContentBean.getContentSummary()%></div>
                       </li>
                     </ul>
                  </pg:item>
                <%} //for %>
            <%} else {
              if (key.length() > 0) {%>                  
                  <div align="center"><font color="Red">Kh&#244;ng t&#236;m th&#7845;y k&#7871;t qu&#7843; n&#224;o!</font></div>        
               <%}
            }%>
                    
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
               <%if (ContentSearchBeans.size() > 0) {%> 
                  <td><fmt:message key="mvnforum.user.searchresult.title"/>: <span style="font-weight:bold; color:#b93b19; font-size:13px;"><%=totalContents%></span></td>
                  <td><%@ include file="inc_pager.jsp"%></td>
               <%}%>
               <%
                 String backURL = urlResolver.encodeURL(request, response, "searchportlet", URLResolverService.ACTION_URL);
               %>
                <td style="text-align:right; padding:5px 0 5px 0; font-weight:bold;"><a href="<%=backURL%>"><img src="<%=cdsTemplate%>/images/back_arrow.gif" alt="" border="0" /></a>&nbsp;<a href="<%=backURL%>" class="next_link">Tr&#7903; v&#7873; trang ch&#7911;</a></td>
              </tr>
            </table>
        </pg:pager>  
      </div>
    </td>
  </tr>
</table>
</fmt:bundle>