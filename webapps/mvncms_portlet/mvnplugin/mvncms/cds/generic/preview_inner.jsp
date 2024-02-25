<%--
 - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/generic/preview_inner.jsp,v 1.4 2010/02/24 08:32:31 trungth Exp $
 - $Author: trungth $
 - $Revision: 1.4 $
 - $Date: 2010/02/24 08:32:31 $
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
<%@ page contentType="text/html;charset=utf-8" %>
<style type="text/css">
.content_title {
    color: Black;
    font-size: 16px;
    font-weight: bold;
    line-height: 20px;
    text-decoration : none;
}
.content_summary {
    color: #5F5F5F;
    font-size: 11px;
    font-weight: bold;
    line-height: 20px;
    text-decoration : none;
}
.content_body {
    color: Black;
    font-size: 12px;
    font-weight: normal;
    line-height: 20px;
    text-decoration : none;
}
.content_source {
    color: Black;
    font-size: 10px;
    font-weight: normal;
    line-height: 20px;
    text-decoration : none;
}
</style>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td valign="top" class="content_title"><%=content.getContentTitle()%></td>
  </tr>
  <tr>
    <td valign="top" class="content_summary" align="justify">
      <%if (content.getContentDefaultImage().length() > 0) {%>
        <img src="<%=request.getContextPath() + content.getContentDefaultImage_translated()%>" alt="<%=content.getContentDefaultImageTitle()%>" class="channelimg" align="left" border="0"/>
      <%}%>
      <span class="content_summary"><%=content.getContentSummary()%></span>
    </td>
  </tr>
  <tr>
    <td valign="top" class="content_body" align="justify">&nbsp;&nbsp;&nbsp;<%=content.getContentBody()%></td>
  </tr>
  <%if ((content.getContentSourceName().length() > 0) || (content.getContentByAuthor().length() > 0)) {%>
    <tr>
      <td align="right" class="content_source">
        <%=content.getContentByAuthor()%>
        <%if (content.getContentSourceName().length() > 0) {%>
          (<fmt:message key="mvncms.preview.content_source"/>:<i><%=content.getContentSourceName()%></i>)
        <%}%>
      </td>
    </tr>
  <%}%>
  <tr>   
    <td><br /></td>
  </tr>
</table>