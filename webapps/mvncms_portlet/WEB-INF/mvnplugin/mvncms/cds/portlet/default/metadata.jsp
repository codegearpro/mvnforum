<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/metadata.jsp,v 1.2 2009/10/19 10:48:38 trungth Exp $
 - $Author: trungth $
 - $Revision: 1.2 $
 - $Date: 2009/10/19 10:48:38 $
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
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page session="false" errorPage="fatalerror.jsp"%>
<%@ page import="com.mvnsoft.mvncms.cds.portlet.common.HotNewsCollection" %>
<%@ page import="com.mvnsoft.mvncms.cds.portlet.common.LatestNewsCollection" %>
<%@ page import="com.mvnsoft.mvncms.db.*"%>
<%@include file="inc_common.jsp"%>

<link type="text/css" media="all" href="css/tabtastic.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" media="all" href="<%=cdsTemplate%>/css/style.css" />
<script type="text/javascript" src="<%=cdsTemplate%>/js/addclasskillclass.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/attachevent.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/addcss.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/tabtastic.js"></script>

<table width="240" class="left_box" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="title_poll" ><img src="<%=cdsTemplate%>/images/metadata_icon.gif" alt="" class="icon_box"/><span>Các metadata thay đổi mới</span><span style="background:url(<%=cdsTemplate%>/images/rss_icon.gif) no-repeat 100% 50%"><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></span></div>
      <div class="margin_box">
         <ul class="icon">
          <li><a href="#" class="vb_link">Công ty Vật tư KTTV</a></li>
          <li><a href="#" class="vb_link">Trung tâm Dự báo KTTV</a></li>
          <li><a href="#" class="vb_link">Công ty Vật tư KTTV</a></li>
          <li><a href="#" class="vb_link">Trung tâm Dự báo KTTV</a></li>
          <li><a href="#" class="vb_link">Công ty Vật tư KTTV</a></li>
          <li><a href="#" class="vb_link">Trung tâm Dự báo KTTV</a></li>
         </ul>
      </div>
    </td>
  </tr>
</table>
