<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/introduce.jsp,v 1.9 2009/12/17 02:05:00 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.9 $
 - $Date: 2009/12/17 02:05:00 $
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

<%@include file="inc_common.jsp"%>

<link rel="stylesheet" type="text/css" media="all" href="<%=cdsTemplate%>/css/style.css" />
<script type="text/javascript" src="<%=cdsTemplate%>/js/addclasskillclass.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/attachevent.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/addcss.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/tabtastic.js"></script>

<%
Collection channelBeans = (Collection) request.getAttribute("ChannelBeans");
ChannelBean currentChannelBean = (ChannelBean) request.getAttribute("CurrentChannelBean");
ContentBean currentContentBean = (ContentBean) request.getAttribute("CurrentContentBean");
int currentChannel = (Integer) request.getAttribute("ChannelID");
Collection contentBeans = (Collection) request.getAttribute("ContentBeans");
String rootURL = urlResolver.encodeURL(request, response, "introduce");
String currentChannelURL = urlResolver.encodeURL(request, response, "introduce?channelID=" + currentChannelBean.getChannelID());
%>
<table width="930" border="0" cellspacing="0" cellpadding="0" style="margin:0 auto">
  <tr>
    <td style="vertical-align:top">
      <table width="240" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <div class="search_box"><%=currentChannelBean.getChannelName() %></div>
            <div class="border_search_box">
              <div class="border_search_box_inner">
                <ul class="info_list">
                <%
                for (Iterator iterator = currentChannelBean.getContentBeans().iterator(); iterator.hasNext();) {
                    ContentBean contentBean = (ContentBean) iterator.next();
                    String viewURL = urlResolver.encodeURL(request, response, "introduce?contentID=" +
                            contentBean.getContentID() + "&amp;channelID=" + currentChannelBean.getChannelID());
                %>
                  <li><a href="<%=viewURL%>"><%=contentBean.getContentTitle()%></a></li>
                <%} %>        
                </ul>
              </div>
            </div>
          </td>
        </tr>
      </table>
    </td>
    <td style="width:10px"><img src="<%=cdsTemplate%>/images/spacer.gif" alt="" width="10" height="10" border="0"/>
    </td>
    <td style="vertical-align:top">
      <table width="680" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td style="font-weight: bold">
            <img alt="bullet" src="<%=cdsTemplate%>/images/arrow2.gif" border="0"/> <a href="<%=rootURL%>">Giới thiệu</a> 
            <img alt="bullet" src="<%=cdsTemplate%>/images/arrow2.gif" border="0"/> <a href="<%=currentChannelURL%>"><%=currentChannelBean.getChannelName()%></a>
            <img alt="bullet" src="<%=cdsTemplate%>/images/arrow2.gif" border="0"/> <a href="#"><%=currentContentBean.getContentTitle()%></a>
          </td>
        </tr>
      </table><br />
      <table width="680" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>
          <ul class="tabset_tabs">
            <%
                for (Iterator iterator = channelBeans.iterator(); iterator.hasNext();) {
                        ChannelBean channel = (ChannelBean) iterator.next();
                        String tabURL = urlResolver.encodeURL(request, response, "introduce?channelID="
                                + channel.getChannelID());
            %>
            <li class="firstchild"><a href="<%=tabURL%>"
              class="preActive <%if (channel.getChannelID() == currentChannel) {%>active<%} else {%>postActive<%}%>"><%=channel.getChannelName()%> </a></li>
            <%
                }
            %>
          </ul>
          <div class="tabset_content tabset_content_active">  
            <div style="font-size:16px; color:#009900; border-bottom:2px solid #009900; font-weight:bold;">
                <%=currentContentBean.getContentTitle()%>
            </div>
            <div style="font-weight:bold; color:#025cac; font-size:16px; margin:10px 0">
              <%=currentContentBean.getContentSummary()%>
            </div><%if (currentContentBean.getContentDefaultImage().length() > 0) { %>
              <img src="<%=request.getContextPath() + currentContentBean.getContentDefaultImage_translated()%>" alt="" class="img_hostnews" width="300" height="200"/>
            <%} %>
            <div class="hotnews_content">
              <%=currentContentBean.getContentBody()%> 
            </div>
          </div>
        </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
