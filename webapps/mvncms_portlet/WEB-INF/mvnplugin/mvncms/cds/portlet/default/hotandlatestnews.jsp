<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/hotandlatestnews.jsp,v 1.15 2009/11/25 04:36:08 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.15 $
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
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page session="false" errorPage="fatalerror.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mvnsoft.mvncms.cds.portlet.common.HotNewsPortletCollection"%>
<%@ page import="com.mvnsoft.mvncms.cds.portlet.common.LatestNewsPortletCollection"%>
<%@ page import="com.mvnsoft.mvncms.cds.portlet.common.MostImpressvieContent"%>
<%@ page import="com.mvnsoft.mvncms.db.*"%>
<%@ include file="inc_common.jsp"%>

<link type="text/css" media="all" href="css/tabtastic.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" media="all" href="<%=cdsTemplate%>/css/style.css" />
<script type="text/javascript" src="<%=cdsTemplate%>/js/addclasskillclass.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/attachevent.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/addcss.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/tabtastic.js"></script>

<table width="680" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <ul class="tabset_tabs">
        <li class="firstchild"><a href="#tab1" class="preActive active">Tin tức, sự kiện nổi bật</a></li>
        <li><a class="preActive postActive" href="#tab2">Tin tức sự kiện đọc nhiều nhất</a></li>
      </ul>

      <div id="tab1" class="tabset_content tabset_content_active">
        <%
        MostImpressvieContent mostImpressvieContent = MostImpressvieContent.getMostImpressvieContent();
        if (mostImpressvieContent != null) {
          ContentBean featureContentBean = mostImpressvieContent.getContentBean();
          String viewURL = mostImpressvieContent.getViewURL();
        %>
          <div id="left_col_hotnews">
            <%if (featureContentBean.getContentDefaultImage().length() > 0) {%>
              <img src="<%=request.getContextPath() + featureContentBean.getContentDefaultImage_translated()%>" alt="<%=featureContentBean.getContentDefaultImageTitle()%>" class="img_idnews" width="300" height="200"/>
            <%}%>
            <a href="<%=viewURL%>" class="hotnews_link"><%=featureContentBean.getContentTitle()%></a>
            <div class="date"><%=onlineUser.getGMTDateFormat(featureContentBean.getContentCreationDate())%></div>
            <div class="hotnews_content"><%=featureContentBean.getContentSummary()%></div>
            <div class="right"><a href="<%=viewURL%>" class="next_link">xem ti&#7871;p</a>&nbsp;<a href="<%=viewURL%>"><img src="<%=cdsTemplate%>/images/next_arrow.gif" alt="" border="0" /></a></div>  
          </div>
        <%}//end featureContentBeans%>
        <%
          java.util.Collection latestNews = LatestNewsPortletCollection.getLatestNews();
          if (latestNews != null || latestNews.size() > 0) {
        %>
          <div id="right_col_hotnews">    
          <% 
            for (Iterator iterator = latestNews.iterator(); iterator.hasNext();) {
                LatestNewsPortletCollection latestNewsPortletCollection = (LatestNewsPortletCollection) iterator.next();
                ChannelBean channel = latestNewsPortletCollection.getChannelBean();
                String channelURL = latestNewsPortletCollection.getViewURL();
                Collection contentBeans = latestNewsPortletCollection.getContents();
          %>
          <div>
            <div><a href="<%=channelURL%>" class="channel_name"><%=channel.getChannelName()%></a></div>
            <ul class="listchanel">
              <%
                for (Iterator iter = contentBeans.iterator(); iter.hasNext();) {
                    List content = (List) iter.next(); 
                    ContentBean contentBean = (ContentBean) content.get(0); 
                    String contentURL = (String) content.get(1); 
              %>
                  <li><a href="<%=contentURL%>" class="link_channel"><%=contentBean.getContentTitle() %></a>&nbsp;<span class="date"><%=onlineUser.getGMTDateFormat(contentBean.getContentCreationDate())%></span></li>
              <%} %>
            </ul>
          </div>
          <div style="border-bottom:1px solid #cacccb; margin:6px 0;"></div>
          <%} %>
        </div>    
      <%}//end if (latestNews != null || latestNews.size() > 0) {%>
      <div style="clear:both"></div>
    </div>
    <%
     java.util.Collection hotNews = HotNewsPortletCollection.getHotNews();
     if (hotNews != null) {
    %>
      <div id="tab2" class="tabset_content">
      <%
        java.util.Iterator hotIter = hotNews.iterator();
        if (hotIter.hasNext()) {
            HotNewsPortletCollection hotNewsCollection = (HotNewsPortletCollection) hotIter.next();
            ContentBean firstHotContent = hotNewsCollection.getContentBean();
      %>
        <div>
        <%if (firstHotContent.getContentDefaultImage().length() > 0) {%>
         <img src="<%=request.getContextPath() + firstHotContent.getContentDefaultImage_translated()%>" alt="<%=firstHotContent.getContentDefaultImageTitle()%>" class="img_hostnews" width=298 height=198 />
        <%}%>
          <a class="hotnews_link" href="<%=hotNewsCollection.getViewURL()%>" class="hotnews_link"><%=firstHotContent.getContentTitle()%></a>
          <div class="date"><%=onlineUser.getGMTDateFormat(firstHotContent.getContentPublishStartDate())%></div>
          <div class="hotnews_content"><%=firstHotContent.getContentSummary()%></div>
        </div>
        <div class="right">
          <a href="<%=hotNewsCollection.getViewURL()%>" class="next_link">xem ti&#7871;p</a>&nbsp;
          <a href="<%=hotNewsCollection.getViewURL()%>"><img src="<%=cdsTemplate%>/images/next_arrow.gif" alt="" border="0" /></a>
        </div>
      <%}%>
      <div style="clear: both; line-height: 10px;">&nbsp;</div>
  
      <div>
        <div id="left_col_hotnews">
        <%
          if (hotIter.hasNext()) {
              HotNewsPortletCollection hotestNewsCollection = (HotNewsPortletCollection) hotIter.next();
              ContentBean hotestNewsContent = hotestNewsCollection.getContentBean();
        %> 
          <img src="<%=request.getContextPath() + hotestNewsContent.getContentDefaultImage_translated()%>" alt="" class="img_small_hostnews" width=81 height=54 />
          <a href="<%=hotestNewsCollection.getViewURL()%>" class="hotnews_link_title"><%=hotestNewsContent.getContentTitle()%></a>
          <div class="date"><%=onlineUser.getGMTDateFormat(hotestNewsContent.getContentPublishStartDate())%></div>
        <%}%>
        </div>
        <div id="right_col_hotnews">
        <%
          if (hotIter.hasNext()) {
              HotNewsPortletCollection hotestNewsCollection = (HotNewsPortletCollection) hotIter.next();
              ContentBean hotestNewsContent = hotestNewsCollection.getContentBean();
        %>
          <img src="<%=request.getContextPath() + hotestNewsContent.getContentDefaultImage_translated()%>" alt="" class="img_small_hostnews" width=81 height=54 />
          <a href="<%=hotestNewsCollection.getViewURL()%>" class="hotnews_link_title"><%=hotestNewsContent.getContentTitle()%></a>
          <div class="date"><%=onlineUser.getGMTDateFormat(hotestNewsContent.getContentPublishStartDate())%></div>
        <%}%>
        </div>
      </div>
      <div style="clear: both; line-height: 5px;">&nbsp;</div>
      <div>
        <div id="left_col_hotnews">
        <%
          if (hotIter.hasNext()) {
              HotNewsPortletCollection hotestNewsCollection = (HotNewsPortletCollection) hotIter.next();
              ContentBean hotestNewsContent = hotestNewsCollection.getContentBean();
        %>
          <img src="<%=request.getContextPath() + hotestNewsContent.getContentDefaultImage_translated()%>" alt="" class="img_small_hostnews" width=81 height=54 />
          <a href="<%=hotestNewsCollection.getViewURL()%>" class="hotnews_link_title"><%=hotestNewsContent.getContentTitle()%></a>
          <div class="date"><%=onlineUser.getGMTDateFormat(hotestNewsContent.getContentPublishStartDate())%></div>
        <%}%>
        </div>
        <div id="right_col_hotnews">
        <%
          if (hotIter.hasNext()) {
              HotNewsPortletCollection hotestNewsCollection = (HotNewsPortletCollection) hotIter.next();
              ContentBean hotestNewsContent = hotestNewsCollection.getContentBean();
        %>
          <img src="<%=request.getContextPath() + hotestNewsContent.getContentDefaultImage_translated()%>" alt="" class="img_small_hostnews" width=81 height=54 />
          <a href="<%=hotestNewsCollection.getViewURL()%>" class="hotnews_link_title"><%=hotestNewsContent.getContentTitle()%></a>
          <div class="date"><%=onlineUser.getGMTDateFormat(hotestNewsContent.getContentPublishStartDate())%></div>
        <%}%>
        </div>
      </div>
      <div style="clear: both"></div>
      </div>
    <%}//end if (hotNews != null) {%>
    </td>
  </tr>
</table>
