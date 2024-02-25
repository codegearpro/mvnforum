<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/searchcontentsinchanneltabs.jsp,v 1.31 2009/12/18 07:24:23 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.31 $
 - $Date: 2009/12/18 07:24:23 $
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
key = DisableHtmlTagFilter.filter(key);// always disable HTML

String highlightKey = ParamUtil.getParameter(request, "key", false);
CDSURLResolver cdsURLResolver = CDSURLResolverFactory.getCDSURLResolver();
Collection channelBeans = (Collection) request.getAttribute("channelBeans");
int currentChannel = ((Integer) request.getAttribute("channel")).intValue();
int rowsToReturn = ((Integer) request.getAttribute("RowsToReturn")).intValue();
Collection contentSearchBeans = (Collection) request.getAttribute("ContentSearchBeans");
int totalContents = ((Integer) request.getAttribute("TotalContents")).intValue();
%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <ul class="tabset_tabs">
      <%
        for (Iterator iterator = channelBeans.iterator(); iterator.hasNext();) {
            ChannelBean channel = (ChannelBean) iterator.next();
            String tabURL = urlResolver.encodeURL(request, response, "morecontentsinchanneltabs?channel=" + channel.getChannelID());
      %>
        <li class="firstchild">
          <a href="<%=tabURL%>" class="preActive <%if (channel.getChannelID() == currentChannel) {%>active<%} else {%>postActive<%}%>"><%=channel.getChannelName()%></a>
        </li>               
      <%}//end for%>
      </ul>

      <div id="tab1" class="tabset_content tabset_content_active">
        <%
        int contentIndex = 0;
        int tabIndex = 0;
         for (Iterator iterator = channelBeans.iterator(); iterator.hasNext(); tabIndex++) {
             ChannelBean channel = (ChannelBean) iterator.next();
             if (channel.getChannelID() == currentChannel) {
                 contentIndex = tabIndex;
        %>
            <div class="title_search"><fmt:message key="mvnforum.common.action.search"/> <%=channel.getChannelName()%></div>
        <%   }
         }
        %> 
  
        <div style="padding:15px 5px 30px 10px;">
          <form action="<%=urlResolver.encodeURL(request, response, "searchcontentsinchanneltabs", URLResolverService.ACTION_URL)%>" name="submitFormSearch" method="post">
            <%=urlResolver.generateFormAction(request, response, "searchcontentsinchanneltabs")%>
            <input type="hidden" name="channel" value="<%=currentChannel%>"/>
            <table width="100%" cellspacing="2" cellpadding="3" border="0">
              <tr>
                <td>
                  N&#7897;i dung t&#236;m ki&#7871;m
                  <input type="text" id="key" name="key" value="<%=key%>" class="textfield" />
                  <input type="button" id="timkiem" class="btn" value="<fmt:message key="mvnforum.common.action.search"/>" onclick="javascript:clickFormSearch();"/>
                  &nbsp;&nbsp;<a href="<%=urlResolver.encodeURL(request, response, "searchcontentsinchanneltabs_advance?channel=" + currentChannel, URLResolverService.ACTION_URL)%>" class="vb_link">T&#236;m ki&#7871;m n&#226;ng cao</a>
                </td>
              </tr>
            </table>
          </form>
        </div>
        <div class="kqtk"><fmt:message key="mvnforum.user.searchresult.title"/></div>
        <div style="padding:5px 0 10px 0">

        <pg:pager
          url="searchcontentsinchanneltabs"
          items="<%= totalContents %>"
          maxPageItems="<%=rowsToReturn%>"
          isOffset="true"
          export="offset,currentPageNumber=pageNumber"
          scope="request">
          <pg:param name="key"/>
          <pg:param name="channel" />
          <pg:param name="rows"/>
         <%
          if (contentSearchBeans.size() > 0) {
              String _highlightKey = "";
              if (highlightKey.length() > 0) {
                _highlightKey = "?hl=" + Encoder.encodeURL(highlightKey);
              }
            %>
            <table style="margin: 0px auto; border-collapse: collapse; line-height: 22px; text-indent: 3px;"  width="100%" cellspacing="0" cellpadding="3" align="center">
            <tr style="background: #d6e9f8; font-size: 12px; font-weight: bold; color: #666;">
                <td style="font-weight: bold; border:1px solid #bbb; text-align:center">Thứ tự</td>
                <%if (contentIndex == 0) {%>
                <td style="font-weight: bold; border:1px solid #bbb; text-align:center">Số hiệu</td>
                <td style="font-weight: bold; border:1px solid #bbb; text-align:center">Cơ quan ban hành</td>
                <td style="font-weight: bold; border:1px solid #bbb; text-align:center">Lĩnh vực</td>
                <td style="font-weight: bold; border:1px solid #bbb; text-align:center">Hình thức văn bản</td>
                <%}%>
                <td style="font-weight: bold; border:1px solid #bbb; text-align:center" <%if (contentIndex == 0) {%>width="30%"<%}%>>Trích yếu nội dung</td>
                <%if (contentIndex == 0) {%>
                <td style="font-weight: bold; border:1px solid #bbb; text-align:center">Ngày ban hành</td>
                <%}%>
                <%if (contentIndex == 1) {%>
                <td style="font-weight: bold; border:1px solid #bbb; text-align:center">Cơ quan thực hiện</td>
                <%}%>
              </tr>
              <%
                Map<Integer, Map<String, String>> contentProperties = (Map<Integer, Map<String, String>>) request.getAttribute("ContentProperties");
              
                int index = offset;
                for (Iterator iterator = contentSearchBeans.iterator(); iterator.hasNext(); ) {
                  ContentBean moreContentBean = (ContentBean) iterator.next();
                  String viewURL = urlResolver.encodeURL(request, response, "viewcontent?contentID="
                          + moreContentBean.getContentID() + "&amp;channel=" + currentChannel + "&amp;searchtype=normal&amp;key=" + key + "&amp;offset=" + offset, URLResolverService.ACTION_URL);
                  
                  int contentID = moreContentBean.getContentID();
                  Map<String, String> contentProperty = new HashMap<String, String>();
                  if (contentProperties.containsKey(contentID)) {
                      contentProperty = contentProperties.get(contentID);
                  }
                  String contentDocumentCode = "";
                  String contentDepartment = "";
                  String contentCategory = "";
                  String contentDocumentType = "";
                  String contentIssueDate = "";
                  String contentResponsibleOffice = "";
                  if (contentProperty.containsKey(ContentPropertyBean.CONTENT_PROPERTY_CODE_DOCUMENT_CODE)) {
                      contentDocumentCode = contentProperty.get(ContentPropertyBean.CONTENT_PROPERTY_CODE_DOCUMENT_CODE);
                  }
                  if (contentProperty.containsKey(ContentPropertyBean.CONTENT_PROPERTY_CODE_DEPARTMENT)) {
                      contentDepartment = contentProperty.get(ContentPropertyBean.CONTENT_PROPERTY_CODE_DEPARTMENT);
                  }
                  if (contentProperty.containsKey(ContentPropertyBean.CONTENT_PROPERTY_CODE_CATEGORY)) {
                      contentCategory = contentProperty.get(ContentPropertyBean.CONTENT_PROPERTY_CODE_CATEGORY);
                  }
                  if (contentProperty.containsKey(ContentPropertyBean.CONTENT_PROPERTY_CODE_DOCUMENT_TYPE)) {
                      contentDocumentType = contentProperty.get(ContentPropertyBean.CONTENT_PROPERTY_CODE_DOCUMENT_TYPE);
                  }
                  if (contentProperty.containsKey(ContentPropertyBean.CONTENT_PROPERTY_CODE_ISSUE_DATE)) {
                      contentIssueDate = contentProperty.get(ContentPropertyBean.CONTENT_PROPERTY_CODE_ISSUE_DATE);
                  }
                  if (contentProperty.containsKey(ContentPropertyBean.CONTENT_PROPERTY_CODE_RESPONSIBLE_OFFICE)) {
                      contentResponsibleOffice = contentProperty.get(ContentPropertyBean.CONTENT_PROPERTY_CODE_RESPONSIBLE_OFFICE);
                  }
                %>
                  <pg:item>
                    <tr>
                      <td style="border:1px solid #bbb; vertical-align:top; text-align:center;"><%=++index%></td>
                      <%if (contentIndex == 0) {%>
                      <td style="border:1px solid #bbb; vertical-align:top;"><%=contentDocumentCode%></td>
                      <td style="border:1px solid #bbb; vertical-align:top;"><%=contentDepartment%></td>
                      <td style="border:1px solid #bbb; vertical-align:top;"><%=contentCategory%></td>
                      <td style="border:1px solid #bbb; vertical-align:top;"><%=contentDocumentType%></td>
                      <%}%>
                      <td style="border:1px solid #bbb; vertical-align:top; padding-left:3px; padding-right:3px; text-indent:0;"><a href="<%=viewURL%>" class="vb_link"><%=moreContentBean.getContentTitle()%></a></td>
                      <%if (contentIndex == 0) {%>
                      <td style="border:1px solid #bbb; vertical-align:top; text-align:center;" nowrap="nowrap"><%=contentIssueDate%></td>
                      <%}%>
                      <%if (contentIndex == 1) {%>
                      <td style="border:1px solid #bbb; vertical-align:top;"><%=contentResponsibleOffice%></td>
                      <%}%>
                    </tr>
                  </pg:item>
                <%} //for %>
            </table>
          <%} else {
            if (key.length() > 0) {%>
                <div align="center"><font color="Red">Kh&#244;ng t&#236;m th&#7845;y k&#7871;t qu&#7843; n&#224;o!</font></div>        
         <% }
          }%>
              
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
             <tr>
              <%
                if (contentSearchBeans.size() > 0) {
              %> 
                <td><fmt:message key="mvnforum.user.searchresult.title"/>: <span style="font-weight:bold; color:#b93b19; font-size:13px;"><%=totalContents%></span></td>
                <td><%@ include file="inc_pager.jsp"%></td>
              <%}%>
              <%
               String backURL = urlResolver.encodeURL(request, response, "morecontentsinchanneltabs?channel=" + currentChannel + "&amp;offset=" + offset);
              %>
             <td style="text-align:right; padding:5px 0 5px 0; font-weight:bold;"><a href="<%=backURL%>"><img src="<%=cdsTemplate%>/images/back_arrow.gif" alt="" border="0" /></a>&nbsp;<a href="<%=backURL%>" class="next_link"><fmt:message key="mvnforum.admin.success.return"/></a></td>
            </tr>
          </table>
        </pg:pager>  
  
      </div>
    </td>
  </tr>
</table>
</fmt:bundle>