<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/contentsinchanneltabs.jsp,v 1.26 2009/12/18 07:24:23 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.26 $
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
<%@ page import="com.mvnsoft.mvncms.cds.*"%>
<%@ page import="com.mvnsoft.mvncms.db.*"%>
<%@ include file="inc_common.jsp"%>
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
CDSURLResolver cdsURLResolver = CDSURLResolverFactory.getCDSURLResolver();
Collection channelBeans = (Collection) request.getAttribute("channelBeans");
ChannelBean currentChannelBean = (ChannelBean) request.getAttribute("currentChannelBean");
int currentChannel = ((Integer) request.getAttribute("channel")).intValue();
int numberOfSpecifiedContents = ((Integer) request.getAttribute("numberOfSpecifiedContents")).intValue();
CDSURL cdsURL = null;
%>

<%if (channelBeans.size() == 0) {%>
  <div>Khong co noi dung</div>
<%} else {%>
      <ul class="tabset_tabs">
      <%
        int count = 0;
        int contentIndex = 0;
        int tabIndex = 0;
        for (Iterator iterator = channelBeans.iterator(); iterator.hasNext(); tabIndex++) {
            ChannelBean channel = (ChannelBean) iterator.next();
            count++;
            String tabURL = urlResolver.encodeURL(request, response, "contentsinchanneltabs?channel=" + channel.getChannelID());
            if (channel.getChannelID() == currentChannel) {
                contentIndex = tabIndex;
            }
      %>
        <li class="firstchild">
          <a href="<%=tabURL%>" class="preActive <%if (channel.getChannelID() == currentChannel) {%>active<%} else {%>postActive<%}%>"><%=channel.getChannelName()%> </a>
        </li>
      <%}//end for%>
      </ul>
      
      <div class="tabset_content tabset_content_active">
          <form action="<%=urlResolver.encodeURL(request, response, "searchcontentsinchanneltabs", URLResolverService.ACTION_URL)%>" name="submitFormSearch" method="post">
          <%=urlResolver.generateFormAction(request, response, "searchcontentsinchanneltabs")%>
            <input type="hidden" name="channel" value="<%=currentChannel%>"/>
            <div style="padding:5px 5px 5px 5px;">
              <input type="text" id="key" name="key" class="textfield" />&nbsp;&nbsp;<input style="vertical-align:top" type="button" id="timkiem" class="btn" value="<fmt:message key="mvnforum.common.action.search"/>" onclick="javascript:clickFormSearch();" />&nbsp;&nbsp;<a href="<%=urlResolver.encodeURL(request, response, "searchcontentsinchanneltabs_advance?channel=" + currentChannel, URLResolverService.ACTION_URL)%>" class="next_link">T&#236;m ki&#7871;m n&#226;ng cao</a>
            </div>
          </form><br />
          <table style="margin: 0px auto; border-collapse: collapse; line-height: 22px; text-indent: 3px;"  width="100%" cellspacing="0" cellpadding="3" align="center">
            <tr style="background: #d6e9f8; font-size: 12px; font-weight: bold; color: #666;">
              <td style="font-weight: bold; border:1px solid #bbb; text-align:center">Thứ tự</td>
              <%if (contentIndex == 0) {%>
              <td style="font-weight: bold; border:1px solid #bbb; text-align:center">Số hiệu</td>
              <%}%>
              <td style="font-weight: bold; border:1px solid #bbb; text-align:center">Trích yếu nội dung</td>
              <%if (contentIndex == 0) {%>
              <td style="font-weight: bold; border:1px solid #bbb; text-align:center">Ngày ban hành</td>
              <%}%>
              <%if (contentIndex == 1) {%>
              <td style="font-weight: bold; border:1px solid #bbb; text-align:center">Cơ quan thực hiện</td>
              <%}%>
            </tr>
            <%
              Map<Integer, Map<String, String>> contentProperties = (Map<Integer, Map<String, String>>) request.getAttribute("ContentProperties");
            
              int index = 0;
              for (Iterator iterator = currentChannelBean.getContentBeans().iterator(); iterator.hasNext(); ) {
                ContentBean content = (ContentBean) iterator.next();
                String viewURL = urlResolver.encodeURL(request, response, "viewcontent?contentID=" + 
                        content.getContentID() + "&amp;channel=" + currentChannel + "&amp;offset=" + 0, URLResolverService.ACTION_URL);
                
                int contentID = content.getContentID();
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
              
                <tr>
                  <td style="border:1px solid #bbb; vertical-align:top; text-align:center;"><%=++index%></td>
                  <%if (contentIndex == 0) {%>
                  <td style="border:1px solid #bbb; vertical-align:top;" nowrap="nowrap"><%=contentDocumentCode%></td>
                  <%}%>
                  <td style="border:1px solid #bbb; vertical-align:top; padding-left:3px; padding-right:3px; text-indent:0;"><a href="<%=viewURL%>" class="vb_link"><%=content.getContentTitle()%></a></td>
                  <%if (contentIndex == 0) {%>
                  <td style="border:1px solid #bbb; vertical-align:top; text-align:center;" nowrap="nowrap"><%=contentIssueDate%></td>
                  <%}%>
                  <%if (contentIndex == 1) {%>
                  <td style="border:1px solid #bbb; vertical-align:top;"><%=contentResponsibleOffice%></td>
                  <%}%>
                </tr>
              <%} //for %>
          </table>
        <%
          String viewMoreURL = urlResolver.encodeURL(request, response, "morecontentsinchanneltabs?channel=" + currentChannel, URLResolverService.ACTION_URL);
        %>
        <div style="text-align:right; padding:5px 0 5px 0; font-weight:bold;"><a href="<%=viewMoreURL%>" class="next_link">Xem thêm</a>&nbsp;<a href="<%=viewMoreURL%>"><img src="<%=cdsTemplate%>/images/next_arrow.gif" alt="" border="0" /></a></div>
      </div>
<%}//end if%>
</fmt:bundle>