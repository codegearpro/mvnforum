<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/searchportlet_advance.jsp,v 1.7 2009/12/14 04:34:39 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.7 $
 - $Date: 2009/12/14 04:34:39 $
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
<%@ page import="com.mvnsoft.mvncms.db.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mvnsoft.mvncms.cds.*"%>
<%@ page import="com.mvnsoft.mvncms.search.content.*"%>
<%@ page import="net.myvietnam.mvncore.util.*"%>
<%@ page import="net.myvietnam.mvncore.filter.*"%>
<%@ page import="net.myvietnam.mvncore.security.*"%>

<%@ include file="inc_common.jsp"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">

<%
    String key = ParamUtil.getParameter(request, "key");
    key = DisableHtmlTagFilter.filter(key);// always disable HTML
    
    CDSURLResolver cdsURLResolver = CDSURLResolverFactory.getCDSURLResolver();
    Collection ContentSearchBeans = (Collection) request.getAttribute("ContentBeans");
    int totalContents = ((Integer) request.getAttribute("TotalContents")).intValue();
    int resultPerPage = ParamUtil.getParameterUnsignedInt(request, "rows", 10);
    Collection<String[]> channels = (Collection<String[]>) request.getAttribute("Channels");
    ContentSearchQuery searchQuery = (ContentSearchQuery) request.getAttribute("SearchQuery");
    //int mode = ((Integer) request.getAttribute("SearchQueryOption")).intValue();
    int channel = ((Integer) request.getAttribute("channel")).intValue();
    int scope = searchQuery.getScopeInContent();
    int sort = searchQuery.getSort();
    String fromdate = ParamUtil.getParameterFilter(request, "fromdate");
    String todate = ParamUtil.getParameterFilter(request, "todate");
%>

<link type="text/css" media="all" href="css/tabtastic.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" media="all" href="<%=cdsTemplate%>/css/style.css" />
<link rel="stylesheet" href="<%=cdsTemplate%>/calendar/bluexp.css" />
<script type="text/javascript" src="<%=cdsTemplate%>/js/addclasskillclass.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/attachevent.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/addcss.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/tabtastic.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/calendar/zapatec.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/calendar/calendar.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/calendar/calendar-vi.js"></script>
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
    document.submitFormSearchPortlet.submit();
  }
}
function ValidateFormSearch() {
  if (isBlank(document.submitFormSearchPortlet.key, 'Từ khóa tìm kiếm chưa được nhập.')) return false;
  return true;
}

function InitParam() {
<%if ( key.length() > 0 ) {%>
  document.submitFormSearchPortlet.key.value ='<%=key%>';
<%}%>
<%if ( channel > 0 ) {%>
  document.submitFormSearchPortlet.channel.value ='<%=channel%>';
<%}%>
<%if ( scope > 0 ) {%>
  document.submitFormSearchPortlet.scope.value ='<%=scope%>';
<%}%>
<%if ( sort > 0 ) {%>
  document.submitFormSearchPortlet.sort.value ='<%=sort%>';
<%}%>
<%if ( fromdate.length() > 0 ) {%>
  document.submitFormSearchPortlet.fromdate.value ='<%=fromdate%>';
<%}%>
<%if ( todate.length() > 0 ) {%>
  document.submitFormSearchPortlet.todate.value ='<%=todate%>';
<%}%>
}
//]]>
</script>
<table border="0" cellspacing="0" cellpadding="5" class="tblwidth">
  <tr>
    <td>    
      <div id="tab1" class="tabset_content tabset_content_active">
        <div class="title_search"><fmt:message key="mvnforum.common.action.advanced_search"/></div>
    
        <form action="<%=urlResolver.encodeURL(request, response, "searchportletadvance", URLResolverService.ACTION_URL)%>" name="submitFormSearchPortlet" method="post">
          <%=urlResolver.generateFormAction(request, response, "searchportletadvance")%>   
          <table width="100%" border="0" cellspacing="2" cellpadding="3">  
            <tr>
              <td valign="top" width="22%">Nội dung tìm kiếm</td>
              <td align="left"><input class="textfield" size="0" type="text" name="key" id="key" onkeydown="if(event.keyCode==13)clickFormSearch();" /></td>
            </tr>
            <tr>
              <td align="left"><label for="channel">Nhóm tin</label></td>
              <td align="left">
                <select class="textfield" id="channel" name="channel">
                  <option value="" selected="selected">Tất cả</option>
                  <% 
                  for (Iterator<String[]> channelsIter = channels.iterator(); channelsIter.hasNext(); ) { 
                    String[] channel1 = channelsIter.next();
                    String channelNames = channel1[0];
                    int channelIDs = Integer.parseInt(channel1[1]);
                  %>
                    <option value="<%=channelIDs%>"><%=channelNames%></option>
                  <%}%>
                </select>
              </td>
            </tr>
            <tr>
              <td align="left"><label for="scope">Phạm vi</label></td>
              <td align="left">
                <select name="scope" id="scope" class="textfield">
                  <option value="<%=ContentSearchQuery.SEARCH_BOTH%>">Tất cả</option>
                  <option value="<%=ContentSearchQuery.SEARCH_ONLY_TITLE%>">Tiêu đề</option>
                  <option value="<%=ContentSearchQuery.SEARCH_ONLY_BODY%>">Nội dung</option>
                </select>
              </td>
            </tr>
            <tr>
              <td align="left"><label for="sort">Sắp xếp theo</label></td>
              <td align="left">
                <select name="sort" id="sort" class="textfield">
                  <option value="<%=ContentSearchQuery.SEARCH_SORT_DEFAULT%>">Mức độ phù hợp</option>
                  <option value="<%=ContentSearchQuery.SEARCH_SORT_TIME_DESC%>">Thời gian giảm dần</option>
                  <option value="<%=ContentSearchQuery.SEARCH_SORT_TIME_ASC%>">Thời gian tăng dần</option>
                </select>
              </td>
            </tr>
            <tr>
              <td align="left">Từ ngày</td>
              <td align="left"><input class="textfield" type="text" id="fromdate" name="fromdate" readonly="readonly" size="13" />&nbsp;&nbsp;<input type="button" id="choosefromdate" value="Ch&#7885;n ng&#224;y" class="btn" /></td>
            </tr>
            <tr>
              <td align="left">Đến ngày</td>
              <td align="left"><input class="textfield" type="text" id="todate" name="todate" readonly="readonly" size="13" />&nbsp;&nbsp;<input type="button" id="choosetodate" value="Ch&#7885;n ng&#224;y" class="btn" /></td>
            </tr>
            <tr>
              <td></td>
              <td><input name="submitsearch" value="<fmt:message key="mvnforum.common.action.search_btn"/>" type="button" onclick="clickFormSearch();" class="btn" />
                <input name="Reset" type="reset" class="btn" value="Nhập lại" />
              </td>
            </tr>
          </table>
        </form> 
  
        <div class="kqtk"><fmt:message key="mvnforum.user.searchresult.title"/></div>
        <div style="padding:5px 0 10px 0">
  
        <pg:pager
          url="searchportletadvance"
          items="<%= totalContents %>"
          maxPageItems="<%= resultPerPage %>"
          isOffset="true"
          export="offset,currentPageNumber=pageNumber"
          scope="request">
          <pg:param name="key"/>
          <pg:param name="rows"/>
          <pg:param name="channel"/>
          <pg:param name="scope"/>
          <pg:param name="sort"/>
          <pg:param name="fromdate"/>
          <pg:param name="todate"/>
          <%
            if (ContentSearchBeans.size() > 0) {
                for (Iterator iterator = ContentSearchBeans.iterator(); iterator.hasNext(); ) {
                  ContentBean moreContentBean = (ContentBean) iterator.next();
                  String viewURL = urlResolver.encodeURL(request, response, "viewcontent?contentID="
                          + moreContentBean.getContentID() + "&amp;key=" + key + "&amp;offset=" + offset +
                          "&amp;channel=" + channel + "&amp;scope=" + scope + "&amp;sort=" + sort +
                          "&amp;fromdate=" + fromdate + "&amp;todate=" + todate + "&amp;searchtype=advance");
                %>
                  <pg:item>
                     <ul class="icon">
                       <li>
                          <a href="<%=viewURL%>" class="vb_link"><%= moreContentBean.getContentTitle()%></a>
                          <span class="content_publishdate">(<%=onlineUser.getGMTDateFormat(moreContentBean.getContentCreationDate())%>)</span>
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
                  <td>Kết quả tìm được: <span style="font-weight:bold; color:#b93b19; font-size:13px;"><%=totalContents%></span></td>
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

<script type="text/javascript">
//<![CDATA[
InitParam();
Zapatec.Calendar.setup({
  firstDay          : 1,
  weekNumbers       : false,
  electric          : false,
  inputField        : "fromdate",
  button            : "choosefromdate",
  ifFormat          : "%d/%m/%Y",
  daFormat          : "%Y/%m/%d"
});
Zapatec.Calendar.setup({
  firstDay          : 1,
  weekNumbers       : false,
  electric          : false,
  inputField        : "todate",
  button            : "choosetodate",
  ifFormat          : "%d/%m/%Y",
  daFormat          : "%Y/%m/%d"
});
//]]>
</script>
</fmt:bundle>