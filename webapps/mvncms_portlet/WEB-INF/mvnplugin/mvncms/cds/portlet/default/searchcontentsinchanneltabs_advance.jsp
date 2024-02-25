<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/searchcontentsinchanneltabs_advance.jsp,v 1.16 2009/12/18 07:24:23 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.16 $
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

<%
String key = ParamUtil.getParameter(request, "key");
key = DisableHtmlTagFilter.filter(key);// always disable HTML
String highlightKey = ParamUtil.getParameter(request, "key", false);
CDSURLResolver cdsURLResolver = CDSURLResolverFactory.getCDSURLResolver();
Collection channelBeans = (Collection) request.getAttribute("channelBeans");
Collection<ContentPropDefinedValueBean> departments = (Collection) request.getAttribute("Departments");
Collection<ContentPropDefinedValueBean> categories = (Collection) request.getAttribute("Categories");
Collection<ContentPropDefinedValueBean> documentTypes = (Collection) request.getAttribute("DocumentTypes");
Collection<ContentPropDefinedValueBean> responsibleOffices = (Collection) request.getAttribute("ResponsibleOffices");
int currentChannel = ((Integer) request.getAttribute("channel")).intValue();
int categoryID = ((Integer) request.getAttribute("categoryID")).intValue();
int documentTypeID = ((Integer) request.getAttribute("documentTypeID")).intValue();
int departmentID = ((Integer) request.getAttribute("departmentID")).intValue();
int responsibleOffice = ((Integer) request.getAttribute("responsibleOffice")).intValue();
String documentCode = StringUtil.getEmptyStringIfNull((String) request.getAttribute("documentCode"));
String approver = StringUtil.getEmptyStringIfNull((String) request.getAttribute("approver"));
Collection ContentSearchBeans = (Collection) request.getAttribute("ContentSearchBeans");
int totalContents = ((Integer) request.getAttribute("TotalContents")).intValue();
int rowsToReturn = ((Integer) request.getAttribute("RowsToReturn")).intValue();
String fromdate1 = ParamUtil.getParameterFilter(request, "fromdate1");
String todate1 = ParamUtil.getParameterFilter(request, "todate1");
String fromdate2 = ParamUtil.getParameterFilter(request, "fromdate2");
String todate2 = ParamUtil.getParameterFilter(request, "todate2");
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
    document.submitFormSearch.submit();
  }
}
function ValidateFormSearch() {
  //if (isBlank(document.submitFormSearch.key, 'Từ khóa tìm kiếm chưa được nhập.')) return false;
  return true;
}

function InitParam() {
<%if ( key.length() > 0 ) {%>
  document.submitFormSearch.key.value ='<%=EnableHtmlTagFilter.filter(key)%>';
<%}%>
<%if ( categoryID > 0 ) {%>
  document.submitFormSearch.categoryID.value ='<%=categoryID%>';
<%}%>
<%if ( documentTypeID > 0 ) {%>
  document.submitFormSearch.documentTypeID.value ='<%=documentTypeID%>';
<%}%>
<%if ( departmentID > 0 ) {%>
  document.submitFormSearch.departmentID.value ='<%=departmentID%>';
<%}%>
<%if ( responsibleOffice > 0 ) {%>
  document.submitFormSearch.responsibleOffice.value ='<%=responsibleOffice%>';
<%}%>
<%if ( documentCode != null && documentCode.length() > 0 ) {%>
  document.submitFormSearch.documentCode.value ='<%=documentCode%>';
<%}%>
<%if ( approver != null && approver.length() > 0 ) {%>
  document.submitFormSearch.approver.value ='<%=approver%>';
<%}%>
<%if ( fromdate1.length() > 0 ) {%>
  document.submitFormSearch.fromdate1.value ='<%=fromdate1%>';
<%}%>
<%if ( todate1.length() > 0 ) {%>
  document.submitFormSearch.todate1.value ='<%=todate1%>';
<%}%>
<%if ( fromdate2.length() > 0 ) {%>
  document.submitFormSearch.fromdate2.value ='<%=fromdate2%>';
<%}%>
<%if ( todate2.length() > 0 ) {%>
  document.submitFormSearch.todate2.value ='<%=todate2%>';
<%}%>
}
//]]>
</script>

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
            <div class="title_search"><fmt:message key="mvnforum.common.action.advanced_search"/> <%=channel.getChannelName()%></div>
        <%
             }
         }
        %>
  
        <div style="padding:15px 5px 30px 10px;">
          <form action="<%=urlResolver.encodeURL(request, response, "searchcontentsinchanneltabs_advance", URLResolverService.ACTION_URL)%>" name="submitFormSearch" method="post">
            <%=urlResolver.generateFormAction(request, response, "searchcontentsinchanneltabs_advance")%>
            <input type="hidden" name="channel" value="<%=currentChannel%>"/>
            <table width="100%" cellspacing="2" cellpadding="3" border="0">
              <tr>
                <td width="15%">N&#7897;i dung t&#236;m ki&#7871;m</td>
                <td>
                  <input type="text" id="key" name="key" value="" class="textfield" />
                </td>
              </tr>
              <tr<%if (contentIndex == 1) {%> style="display: none"<%}%>>
                <td>S&#7889; hi&#7879;u</td>
                <td>
                  <input type="text" id="documentCode" name="documentCode" value="" class="textfield" />
                </td>
              </tr>
              <tr<%if (contentIndex == 1) {%> style="display: none"<%}%>>
                <td>Ng&#432;&#7901;i k&#253; duy&#7879;t</td>
                <td>
                  <input type="text" id="approver" name="approver" value="" class="textfield" />
                </td>
              </tr>
              <tr<%if (contentIndex == 1) {%> style="display: none"<%}%>>
                <td>L&#297;nh v&#7921;c</td>
                <td>
                  <select name="categoryID" class="textfield">
                    <option value="0">...</option>
                    <%for (ContentPropDefinedValueBean contentPropDefinedValueBean : categories) {%>
                    <option value="<%=contentPropDefinedValueBean.getDefinedValueID()%>"><%=contentPropDefinedValueBean.getDefinedValueString()%></option>
                    <%}%>
                  </select>
                </td>
              </tr>
              <tr<%if (contentIndex == 1) {%> style="display: none"<%}%>>
                <td>Hình thức văn bản</td>
                <td>
                  <select name="documentTypeID" class="textfield">
                    <option value="0">...</option>
                    <%for (ContentPropDefinedValueBean contentPropDefinedValueBean : documentTypes) {%>
                    <option value="<%=contentPropDefinedValueBean.getDefinedValueID()%>"><%=contentPropDefinedValueBean.getDefinedValueString()%></option>
                    <%}%>
                  </select>
                </td>
              </tr>
              <tr<%if (contentIndex == 1) {%> style="display: none"<%}%>>
                <td>C&#417; quan ban h&#224;nh</td>
                <td>
                  <select name="departmentID" class="textfield">
                    <option value="0">...</option>
                    <%for (ContentPropDefinedValueBean contentPropDefinedValueBean : departments) {%>
                    <option value="<%=contentPropDefinedValueBean.getDefinedValueID()%>"><%=contentPropDefinedValueBean.getDefinedValueString()%></option>
                    <%}%>
                  </select>
                </td>
              </tr>
              <tr style="display: none">
                <td>Ngày ban hành</td>
                <td>
                  Từ ngày
                  <input class="textfield" type="text" id="fromdate1" name="fromdate1" readonly="readonly" size="13" />&nbsp;&nbsp;<input type="button" id="choosefromdate1" value="Ch&#7885;n ng&#224;y" class="btn" />
                  Đến ngày
                  <input class="textfield" type="text" id="todate1" name="todate1" readonly="readonly" size="13" />&nbsp;&nbsp;<input type="button" id="choosetodate1" value="Ch&#7885;n ng&#224;y" class="btn" />
                </td>
              </tr>
              <tr style="display: none">
                <td>Ngày có hiệu lực</td>
                <td>
                  Từ ngày
                  <input class="textfield" type="text" id="fromdate2" name="fromdate2" readonly="readonly" size="13" />&nbsp;&nbsp;<input type="button" id="choosefromdate2" value="Ch&#7885;n ng&#224;y" class="btn" />
                  Đến ngày
                  <input class="textfield" type="text" id="todate2" name="todate2" readonly="readonly" size="13" />&nbsp;&nbsp;<input type="button" id="choosetodate2" value="Ch&#7885;n ng&#224;y" class="btn" />
                </td>
              </tr>
              <tr<%if (contentIndex == 0) {%> style="display: none"<%}%>>
                <td>Cơ quan thực hiện</td>
                <td>
                  <select name="responsibleOffice" class="textfield">
                    <option value="0">...</option>
                    <%for (ContentPropDefinedValueBean contentPropDefinedValueBean : responsibleOffices) {%>
                    <option value="<%=contentPropDefinedValueBean.getDefinedValueID()%>"><%=contentPropDefinedValueBean.getDefinedValueString()%></option>
                    <%}%>
                  </select>
                </td>
              </tr>
              <tr>
                <td></td>
                <td>
                  <input type="button" id="timkiem" class="btn" value="<fmt:message key="mvnforum.common.action.search"/>" onclick="javascript:clickFormSearch();"/>
                  <input name="Reset" type="reset" class="btn" value="Nhập lại" />
                </td>
              </tr>
            </table>
          </form>
        </div>
        <div class="kqtk"><fmt:message key="mvnforum.user.searchresult.title"/></div>
        <div style="padding:5px 0 10px 0">

        <pg:pager
          url="searchcontentsinchanneltabs_advance"
          items="<%= totalContents %>"
          maxPageItems="<%=rowsToReturn%>"
          isOffset="true"
          export="offset,currentPageNumber=pageNumber"
          scope="request">
          <pg:param name="key"/>
          <pg:param name="channel" />
          <pg:param name="categoryID"/>
          <pg:param name="documentTypeID"/>
          <pg:param name="departmentID"/>
          <pg:param name="documentCode"/>
          <pg:param name="approver"/>
          <pg:param name="responsibleOffice"/>
         <%
          if (ContentSearchBeans.size() > 0) {
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
              for (Iterator iterator = ContentSearchBeans.iterator(); iterator.hasNext(); ) {
                ContentBean moreContentBean = (ContentBean) iterator.next();
                String viewURL = urlResolver.encodeURL(request, response, "viewcontent?contentID="
                        + moreContentBean.getContentID() + "&amp;channel=" + currentChannel + "&amp;key=" + key + "&amp;offset=" + offset + "&amp;searchtype=advance" + "&amp;categoryID=" + categoryID + "&amp;documentTypeID=" + documentTypeID +
                        "&amp;departmentID=" + departmentID + "&amp;documentCode=" + documentCode + "&amp;approver=" + approver +
                        "&amp;responsibleOffice=" + responsibleOffice, URLResolverService.ACTION_URL);
                
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
             <%}
          }%>
              
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
             <tr>
              <%
                if (ContentSearchBeans.size() > 0) {
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
<script type="text/javascript">
//<![CDATA[
InitParam()
Zapatec.Calendar.setup({
  firstDay          : 1,
  weekNumbers       : false,
  electric          : false,
  inputField        : "fromdate1",
  button            : "choosefromdate1",
  ifFormat          : "%d/%m/%Y",
  daFormat          : "%Y/%m/%d"
});
Zapatec.Calendar.setup({
  firstDay          : 1,
  weekNumbers       : false,
  electric          : false,
  inputField        : "todate1",
  button            : "choosetodate1",
  ifFormat          : "%d/%m/%Y",
  daFormat          : "%Y/%m/%d"
});
Zapatec.Calendar.setup({
  firstDay          : 1,
  weekNumbers       : false,
  electric          : false,
  inputField        : "fromdate2",
  button            : "choosefromdate2",
  ifFormat          : "%d/%m/%Y",
  daFormat          : "%Y/%m/%d"
});
Zapatec.Calendar.setup({
  firstDay          : 1,
  weekNumbers       : false,
  electric          : false,
  inputField        : "todate2",
  button            : "choosetodate2",
  ifFormat          : "%d/%m/%Y",
  daFormat          : "%Y/%m/%d"
});
//]]>
</script>
</fmt:bundle>