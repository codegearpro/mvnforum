<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/search.jsp,v 1.7 2009/10/13 04:58:38 hoanglt Exp $
 - $Author: hoanglt $
 - $Revision: 1.7 $
 - $Date: 2009/10/13 04:58:38 $
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

<table width="240" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
     <div class="search_box"><img src="<%=cdsTemplate%>/images/search_icon.gif" alt="" class="icon_box" />Tìm kiếm</div>
     <div class="border_search_box">
       <div class="border_search_box_inner">
         <div class="search_box_inner"><input name="" type="text" class="inp_search_box" /><input name="" type="button" class="btn" value="Tìm" /></div>
       </div>
     </div>
    </td>
  </tr>
</table>