<%--
  - $Header: /home/cvsroot/portlet-mvnforum/srcweb/mvnplugin/mvnforum/user/error_album.jsp,v 1.4 2010/08/20 05:16:09 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.4 $
  - $Date: 2010/08/20 05:16:09 $
  -
  - ====================================================================
  -
  - Copyright (C) 2002-2010 by MyVietnam.net
  -
  - MyVietnam.net PROPRIETARY/CONFIDENTIAL PROPERTIES. Use is subject to license terms.
  - You CANNOT use this software unless you receive a written permission from MyVietnam.net
  -
  - @author: MyVietnam.net developers
  -
--%>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="inc_common.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<table width="240" class="left_box" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div>
        <fmt:message key="java.lang.IllegalStateException.default_album_hasnot_been_set"/>
      </div>
      <%if(permission.isAuthenticated()) {%>
        <a href="<%=urlResolver.encodeURL(request, response, "listpublicalbums", URLResolverService.ACTION_URL)%>" style="color: blue;"><fmt:message key="mvnforum.common.album.command.manage"/></a>
      <%} %>
    </td>
  </tr>
</table>
</fmt:bundle>
