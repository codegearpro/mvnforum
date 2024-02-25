<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/news_detail.jsp,v 1.7 2009/11/18 08:06:56 minhnn Exp $
 - $Author: minhnn $
 - $Revision: 1.7 $
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
<%@ page import="com.mvnsoft.mvncms.db.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mvnsoft.mvncms.cds.*"%>
<%@ page import="org.omg.PortableInterceptor.Interceptor"%>
<%@ include file="inc_common.jsp"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" type="text/css" media="all" href="<%=cdsTemplate%>/css/style.css" />
<script type="text/javascript" src="<%=cdsTemplate%>/js/addclasskillclass.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/attachevent.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/addcss.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/tabtastic.js"></script>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<%
ContentBean contentBean = (ContentBean) request.getAttribute("ContentBeanView");
ChannelBean channelBean = (ChannelBean) request.getAttribute("ChannelBean");
%>
<div class="nav center">
    <img src="<%=request.getContextPath()%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
    <a href="<%=urlResolver.encodeURL(request, response, "")%>">Tin tức</a>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="box_border" style="margin:0 auto">
  <tr>
    <td>
      <div class="title_poll"><div style=" float:left; width:60%;"><span style="color:#d1310f; font-weight:bold; font-size:13px;">Tin tức</span></div>
        <div style="float:right; width:35%; text-align:right; margin-right:1px;"></div>
      </div>
      <div class="margin_box">
        <div style="padding:0 0 10px 0"><a href="#" class="hotnews_link"><%=contentBean.getContentTitle()%></a>&nbsp;&nbsp;<span class="date">20/06/2009</span>
          <div align="right"><a href="<%=urlResolver.encodeURL(request, response, "")%>" style="color: blue;"><img src="<%=cdsTemplate%>/images/back_arrow.gif" alt="" border="0" />
            <fmt:message key="mvnforum.admin.success.return"/>
          </a></div>
        </div>
        <%if (contentBean.getContentDefaultImage().length() > 0) { %>
          <img src="<%=request.getContextPath() + contentBean.getContentDefaultImage_translated()%>" alt="" class="img_hostnews" width="300" height="200"/>
        <%} %>
        <div class="hotnews_content"><%=contentBean.getContentBody() %></div>   
        <div style="text-align:right; font-style:italic; font-size:11px; color:#0a60b3;"><%=contentBean.getContentByAuthor()%></div>
      </div> 
    </td>
  </tr>
</table>
<table width="930" border="0" cellspacing="0" cellpadding="0" style="margin:20px auto 0 auto;">
  <tr>
    <td>
        <div class="oldnews">Các tin đã đưa</div>
          <ul class="icon">
          <%
            for(Iterator iter = channelBean.getContentBeans().iterator(); iter.hasNext();) {
              ContentBean content = (ContentBean)iter.next();
              String viewURL = urlResolver.encodeURL(request, response, "viewcontent?contentID="
                      + content.getContentID());
              if (content.getContentID() != contentBean.getContentID()) {
          %>
            <li><a href="<%=viewURL%>" class="vb_link"><%=content.getContentTitle()%></a>&nbsp;<span class="date"><%=content.getContentCreationDate()%></span></li>
              <%} %>
          <%} %>
          </ul> 
    </td>
  </tr>
</table>
</fmt:bundle>