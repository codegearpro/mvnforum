<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/viewsearchportlet.jsp,v 1.9 2009/12/18 06:55:12 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.9 $
 - $Date: 2009/12/18 06:55:12 $
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
<%@ page import="net.myvietnam.mvncore.util.ParamUtil"%>
<%@ page import="com.mvnsoft.mvncms.db.*"%>
<%@ page import="com.mvnsoft.mvncms.cds.*"%>

<%@ include file="inc_common.jsp"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>

<link rel="stylesheet" type="text/css" media="all" href="<%=cdsTemplate%>/css/style.css" />
<script type="text/javascript" src="<%=cdsTemplate%>/js/addclasskillclass.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/attachevent.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/addcss.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/tabtastic.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="tabset_content tabset_content_active">
        <%
          String homeURL = urlResolver.encodeURL(request, response, "searchportlet", URLResolverService.ACTION_URL);
          ContentBean contentBean = (ContentBean) request.getAttribute("contentBeanView");
        %>
        <div style="text-align:right; padding:5px 0 5px 0; font-weight:bold;">
          <a href="<%=homeURL%>" class="next_link">Tr&#7903; v&#7873; Trang ch&#7911;</a>
        </div>
        <div style=" width:660px; padding:0px 0 10px 0px; font-weight:bold;" class="content_title"><%=contentBean.getContentTitle()%></div>
        <div class="content_publishdate"><%=onlineUser.getGMTDateFormat(contentBean.getContentCreationDate())%></div>
        <div class="content_summary">
          <%if (contentBean.getContentDefaultImage().length() > 0) {%>
            <img src="<%=request.getContextPath() + contentBean.getContentDefaultImage_translated()%>" alt="<%=contentBean.getContentDefaultImageTitle()%>" class="channelimg" align="left" border="0"/>
          <%}%>
          <%=contentBean.getContentSummary()%>
        </div>
        <div border="0" cellspacing="0" cellpadding="0" class="content_body"><%=contentBean.getContentBody()%></div>
         <%
            String searchtype = request.getParameter("searchtype");
            String key = request.getParameter("key");
            String offset = request.getParameter("offset");
            String backURL = urlResolver.encodeURL(request, response, "searchportletresult?key=" + key + "&amp;offset=" + offset);
            if ("advance".equals(searchtype)) {
                int channel = ParamUtil.getParameterInt(request, "channel");
                int scope = ParamUtil.getParameterInt(request, "scope");
                int sort = ParamUtil.getParameterInt(request, "sort");
                String fromdate = ParamUtil.getParameterFilter(request, "fromdate");
                String todate = ParamUtil.getParameterFilter(request, "todate");
                backURL = urlResolver.encodeURL(request, response, "searchportletadvance?key=" + key + "&amp;offset=" + offset +
                        "&amp;channel=" + channel + "&amp;scope=" + scope + "&amp;sort=" + sort +
                        "&amp;fromdate=" + fromdate + "&amp;todate=" + todate + "&amp;searchtype=advance");
            }
          %>
        <div style="text-align:right; padding:5px 0 5px 0; font-weight:bold;"><a href="<%=backURL%>"><img src="<%=cdsTemplate%>/images/back_arrow.gif" alt="" border="0" /></a>&nbsp;<a href="<%=backURL%>" class="next_link">Quay l&#7841;i</a></div>
      </div>
    </td>
  </tr>
</table>
