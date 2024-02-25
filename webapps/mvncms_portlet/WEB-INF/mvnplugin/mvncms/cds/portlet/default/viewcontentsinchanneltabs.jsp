<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/viewcontentsinchanneltabs.jsp,v 1.25 2009/12/14 07:42:42 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.25 $
 - $Date: 2009/12/14 07:42:42 $
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
<%@ page import="com.mvnsoft.mvncms.db.*"%>
<%@ page import="com.mvnsoft.mvncms.cds.*"%>
<%@include file="inc_common.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<link rel="stylesheet" type="text/css" media="all" href="<%=cdsTemplate%>/css/style.css" />
<script type="text/javascript" src="<%=cdsTemplate%>/js/addclasskillclass.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/attachevent.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/addcss.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/tabtastic.js"></script>
<%
CDSURLResolver cdsURLResolver = CDSURLResolverFactory.getCDSURLResolver();
Collection channelBeans = (Collection) request.getAttribute("channelBeans");
int channelID = ((Integer) request.getAttribute("channel")).intValue();
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <ul class="tabset_tabs">
        <%
          for (Iterator iterator = channelBeans.iterator(); iterator.hasNext();) {
              ChannelBean channel = (ChannelBean) iterator.next();
              String tabURL = urlResolver.encodeURL(request, response, "morecontentsinchanneltabs?channel="
                      + channel.getChannelID());
        %>
          <% if (channel.getChannelID() == channelID) { %>
            <li class="firstchild">
               <a href="#" class="preActive <%if (channel.getChannelID() == channelID) {%>active<%} else {%>postActive<%}%>"><%=channel.getChannelName()%></a>
            </li>
          <%}%>
        <%}%>
      </ul>

      <div class="tabset_content tabset_content_active">
        <%
        int contentIndex = 0;
        int tabIndex = 0;
         for (Iterator iterator = channelBeans.iterator(); iterator.hasNext(); tabIndex++) {
             ChannelBean channel = (ChannelBean) iterator.next();
             if (channel.getChannelID() == channelID) {
                 contentIndex = tabIndex;
        %>
            <div class="title_search">Xem chi tiết <%=channel.getChannelName()%></div>
        <%
             }
         }
        %>
        <%
           String homeURL = urlResolver.encodeURL(request, response, "contentsinchanneltabs", URLResolverService.ACTION_URL);
        %>
        <div style="text-align:right; padding:5px 0 5px 0; font-weight:bold;">&nbsp;<a href="<%=homeURL%>" class="next_link"><fmt:message key="mvnforum.common.member.homepage"/></a></div>
        <%
          ContentBean contentBean = (ContentBean) request.getAttribute("ContentBeanView");
          Map<String, String> contentProperty = (Map<String, String>) request.getAttribute("ContentProperty");
          String contenDocumentCode = "";
          String contenDepartment = "";
          String contenCategory = "";
          String contenDocumentType = "";
          String contenIssueDate = "";
          String contenApplyDate = "";
          String contenApprover = "";
          String contentResponsibleOffice = "";
          if (contentProperty.containsKey(ContentPropertyBean.CONTENT_PROPERTY_CODE_DOCUMENT_CODE)) {
              contenDocumentCode = contentProperty.get(ContentPropertyBean.CONTENT_PROPERTY_CODE_DOCUMENT_CODE);
          }
          if (contentProperty.containsKey(ContentPropertyBean.CONTENT_PROPERTY_CODE_DEPARTMENT)) {
              contenDepartment = contentProperty.get(ContentPropertyBean.CONTENT_PROPERTY_CODE_DEPARTMENT);
          }
          if (contentProperty.containsKey(ContentPropertyBean.CONTENT_PROPERTY_CODE_CATEGORY)) {
              contenCategory = contentProperty.get(ContentPropertyBean.CONTENT_PROPERTY_CODE_CATEGORY);
          }
          if (contentProperty.containsKey(ContentPropertyBean.CONTENT_PROPERTY_CODE_DOCUMENT_TYPE)) {
              contenDocumentType = contentProperty.get(ContentPropertyBean.CONTENT_PROPERTY_CODE_DOCUMENT_TYPE);
          }
          if (contentProperty.containsKey(ContentPropertyBean.CONTENT_PROPERTY_CODE_ISSUE_DATE)) {
              contenIssueDate = contentProperty.get(ContentPropertyBean.CONTENT_PROPERTY_CODE_ISSUE_DATE);
          }
          if (contentProperty.containsKey(ContentPropertyBean.CONTENT_PROPERTY_CODE_APPLY_DATE)) {
              contenApplyDate = contentProperty.get(ContentPropertyBean.CONTENT_PROPERTY_CODE_APPLY_DATE);
          }
          if (contentProperty.containsKey(ContentPropertyBean.CONTENT_PROPERTY_CODE_APPROVER)) {
              contenApprover = contentProperty.get(ContentPropertyBean.CONTENT_PROPERTY_CODE_APPROVER);
          }
          if (contentProperty.containsKey(ContentPropertyBean.CONTENT_PROPERTY_CODE_RESPONSIBLE_OFFICE)) {
              contentResponsibleOffice = contentProperty.get(ContentPropertyBean.CONTENT_PROPERTY_CODE_RESPONSIBLE_OFFICE);
          }
        %> 
        <%if (contentBean.getContentType() == ContentBean.CONTENT_TYPE_LEGAL_DOCUMENT) {%>
          <table style="text-indent:3px; line-height:30px; vertical-align:top; border-collapse: collapse;" width="100%" cellspacing="0" cellpadding="3" align="center">
            <tr>
              <td width="20%" style="font-weight: bold; border:1px solid #bbb; vertical-align:top;">Số hiệu</td>
              <td style="border:1px solid #bbb; vertical-align:top;"><%=contenDocumentCode%></td>
            </tr>
            <tr>
              <td style="font-weight: bold; border:1px solid #bbb; vertical-align:top;">Trích yếu nội dung</td>
              <td style="border:1px solid #bbb; vertical-align:top;"><%=contentBean.getContentTitle()%></td>
            </tr>
            <tr>
              <td style="font-weight: bold; border:1px solid #bbb; vertical-align:top;">Ngày ban hành</td>
              <td style="border:1px solid #bbb; vertical-align:top;"><%=contenIssueDate%></td>
            </tr>
            <tr>
              <td style="font-weight: bold; border:1px solid #bbb; vertical-align:top;">Ngày có hiệu lực</td>
              <td style="border:1px solid #bbb; vertical-align:top;"><%=contenApplyDate%></td>
            </tr>
            <tr>
              <td style="font-weight: bold; border:1px solid #bbb; vertical-align:top;">Hình thức văn bản</td>
              <td style="border:1px solid #bbb; vertical-align:top;"><%=contenDocumentType%></td>
            </tr>
            <tr >
              <td style="font-weight: bold; border:1px solid #bbb; vertical-align:top;">Lĩnh vực</td>
              <td style="border:1px solid #bbb; vertical-align:top;"><%=contenCategory%></td>
            </tr>
            <tr>
              <td style="font-weight: bold; border:1px solid #bbb; vertical-align:top;">Cơ quan ban hành</td>
              <td style="border:1px solid #bbb; vertical-align:top;"><%=contenDepartment%></td>
            </tr>
            <tr>
              <td style="font-weight: bold; border:1px solid #bbb; vertical-align:top;">Người ký duyệt</td>
              <td style="border:1px solid #bbb; vertical-align:top;"><%=contenApprover%></td>
            </tr>
            <tr>
              <td style="font-weight: bold; border:1px solid #bbb; vertical-align:top;">Chi tiết</td>
              <td style="border:1px solid #bbb; vertical-align:top;"><%=contentBean.getContentBody()%></td>
            </tr>
          </table>
        <%}%>
        <%if (contentBean.getContentType() == ContentBean.CONTENT_TYPE_OFFICAL_PROCEDURE) {%>
          <table style="text-indent:3px; line-height:30px; vertical-align:top; border-collapse: collapse;" width="100%" cellspacing="0" cellpadding="3" align="center">
            <tr>
              <td style="font-weight: bold; vertical-align:top;" width="150px">Tên thủ tục:</td>
              <td style="vertical-align:top;"><%=contentBean.getContentTitle()%></td>
            </tr>
            <tr>
              <td style="font-weight: bold; vertical-align:top;">Cơ quan thực hiện:</td>
              <td style="vertical-align:top;"><%=contentResponsibleOffice%></td>
            </tr>
            <tr>
              <td style="font-weight: bold; vertical-align:top;">Nội dung:</td>
              <td></td>
            </tr>
          </table>
          <table style="text-indent:3px; line-height:30px; vertical-align:top; border-collapse: collapse;" width="100%" cellspacing="0" cellpadding="3" align="center">
            <tr>
              <td style="vertical-align:top;"><%=contentBean.getContentBody()%></td>
            </tr>
          </table>
        <%}%>
        
         <%
            String searchType = request.getParameter("searchtype");
            String key = request.getParameter("key");
            if (key == null) {
                key = "";
            }
            int offset = ((Integer) request.getAttribute("offset")).intValue();
            String backURL = "";
            if ("advance".equals(searchType)) {
                int categoryID = ((Integer) request.getAttribute("categoryID")).intValue();
                int documentTypeID = ((Integer) request.getAttribute("documentTypeID")).intValue();
                int departmentID = ((Integer) request.getAttribute("departmentID")).intValue();
                int responsibleOffice = ((Integer) request.getAttribute("responsibleOffice")).intValue();
                String documentCode = (String) request.getAttribute("documentCode");
                String approver = (String) request.getAttribute("approver");
                backURL = urlResolver.encodeURL(request, response, "searchcontentsinchanneltabs_advance?channel=" + channelID
                    + "&amp;key=" + key + "&amp;offset=" + offset + "&amp;categoryID=" + categoryID +
                    "&amp;documentTypeID=" + documentTypeID + "&amp;departmentID=" + departmentID +
                    "&amp;documentCode=" + documentCode + "&amp;approver=" + approver +
                    "&amp;responsibleOffice=" + responsibleOffice, URLResolverService.ACTION_URL);
            } else if ("normal".equals(searchType)) {
                backURL = urlResolver.encodeURL(request, response, "searchcontentsinchanneltabs?channel=" + channelID
                    + "&amp;key=" + key + "&amp;offset=" + offset, URLResolverService.ACTION_URL);
            } else {
                backURL = urlResolver.encodeURL(request, response, "morecontentsinchanneltabs?channel=" + channelID
                    + "&amp;offset=" + offset);
            }
        %>
        <div style="text-align:right; padding:5px 0 5px 0; font-weight:bold;">
          <a href="<%=backURL%>"><img src="<%=cdsTemplate%>/images/back_arrow.gif" alt="" border="0" /></a>&nbsp;
          <a href="<%=backURL%>" class="next_link"><fmt:message key="mvnforum.admin.success.return"/></a>
        </div>
      </div>
    </td>
  </tr>
</table>
</fmt:bundle>
