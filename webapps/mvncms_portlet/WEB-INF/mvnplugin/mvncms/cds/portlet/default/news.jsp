<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/news.jsp,v 1.12 2009/11/18 08:06:56 minhnn Exp $
 - $Author: minhnn $
 - $Revision: 1.12 $
 - $Date: 2009/11/18 08:06:56 $
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page session="false" errorPage="fatalerror.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mvnsoft.mvncms.db.*"%>
<%@ page import="com.mvnsoft.mvncms.cds.*"%>
<%@ page import="org.omg.PortableInterceptor.Interceptor"%>
<%@ include file="inc_common.jsp"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" media="all" href="<%=cdsTemplate%>/css/style.css" />
<script type="text/javascript" src="<%=cdsTemplate%>/js/addclasskillclass.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/attachevent.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/addcss.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/tabtastic.js"></script>
<%
//Collection contentBeans = (Collection) request.getAttribute("ContentBeans");
ChannelBean channelBean = (ChannelBean) request.getAttribute("ChannelBean");
int numberOfSpecifiedContents = ((Integer) request.getAttribute("NumberOfSpecifiedContents")).intValue();
int numberRows = ((Integer) request.getAttribute("NumberRows")).intValue();
%>
<div class="nav center">
    <img src="<%=request.getContextPath()%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
    Tin tức
</div>
<pg:pager url="" items="<%=numberOfSpecifiedContents%>" maxPageItems="<%=numberRows%>" isOffset="true"
      export="offset,currentPageNumber=pageNumber">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="box_border" style="margin:0 auto">
    <tr>
      <td>
          <div class="title_poll">
            <div style=" float:left; width:60%;"><span style="color:#d1310f; font-weight:bold; font-size:13px;">Tin tức</span>
            </div>
            <div style="float:right; width:35%; text-align:right; margin-right:1px;">
            </div>
          </div>
          <div class="margin_box">
            <%
              int count = 0;
              //for (Iterator iter = contentBeans.iterator();iter.hasNext();) {
                for (Iterator iter = channelBean.getContentBeans().iterator(); iter.hasNext();) {
                  ContentBean contentBean = (ContentBean)iter.next();
                  count ++;
                  String viewURL = urlResolver.encodeURL(request, response, "viewcontent?contentID=" + contentBean.getContentID());
                if (count == 1) {
            %>
          <div>
              <%if (contentBean.getContentDefaultImage().length() > 0) { %>
                <img src="<%=request.getContextPath() + contentBean.getContentDefaultImage_translated()%>" alt="<%=contentBean.getContentDefaultImageTitle() %>" class="img_hostnews" width="300" height="200"/>
              <%} %>
              <a href="<%=viewURL%>" class="hotnews_link"><%=contentBean.getContentTitle() %></a>
              <div class="date"><%=contentBean.getContentCreationDate()%></div>
              <div class="hotnews_content"><%=contentBean.getContentSummary()%></div>  
            </div>
            <div class="right"><a href="<%=viewURL%>" class="next_link">xem ti&#7871;p</a>&nbsp;<a href="<%=viewURL%>"><img src="<%=cdsTemplate%>/images/next_arrow.gif" alt="" border="0"/></a></div>
              <%} else {%>
            <div style="clear:both; line-height:10px;">&nbsp;</div>
            <div><%if (contentBean.getContentDefaultImage().length() > 0) { %>
              <img src="<%=request.getContextPath() + contentBean.getContentDefaultImage_translated()%>" alt="<%=contentBean.getContentDefaultImageTitle() %>" class="img_category" width="110" height="80"/>
              <%} %>
            <a href="<%=viewURL%>" class="hotnews_link_title"><%=contentBean.getContentTitle() %></a>&nbsp;&nbsp;<span class="date"><%=contentBean.getContentCreationDate()%></span>
            <div class="hotnews_content"><%=contentBean.getContentSummary()%></div>  
          </div>
          <div class="right"><a href="<%=viewURL%>" class="next_link">xem ti&#7871;p</a>&nbsp;<a href="<%=viewURL%>"><img src="<%=cdsTemplate%>/images/next_arrow.gif" alt="" border="0" /></a></div>
              <%} %>    <%--close else --%>
            <%} %>  <%--close for --%>
          </div> 
      </td>
    </tr><br />
    <tr><td align="right"><%@ include file="inc_pager.jsp"%></td></tr>
  </table>
</pg:pager>
</fmt:bundle>