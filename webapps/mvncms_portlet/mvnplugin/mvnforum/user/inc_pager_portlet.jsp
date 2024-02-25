<%--
  - $Header: /home/cvsroot/portlet-mvnforum/srcweb/mvnplugin/mvnforum/user/inc_pager_portlet.jsp,v 1.2 2010/08/20 05:16:09 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.2 $
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
<%--@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" --%>
<pg:index export="pages, items">
<table cellspacing="0" cellpadding="0">
  <tr class="pager">
    <td align="right" nowrap="nowrap">
      [
      <pg:prev export="pageUrl"><a href="<%=urlResolver.encodeURL(request, response, pageUrl)%>" class="pager"><fmt:message key="mvnforum.common.previous"/></a> |</pg:prev>
      <pg:pages>
        <% if (pageNumber == currentPageNumber) { %>
          <span class="pagerCurrent"><%= pageNumber %></span>
        <% } else { %>
          <a href="<%=urlResolver.encodeURL(request, response, pageUrl)%>" class="pager"><%= pageNumber%></a>
        <% } %>
      </pg:pages>
      <pg:next export="pageUrl">| <a href="<%=urlResolver.encodeURL(request, response, pageUrl)%>" class="pager"><fmt:message key="mvnforum.common.next"/></a></pg:next> ]
    </td>
  </tr>
</table>
</pg:index>
