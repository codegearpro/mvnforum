<%--
  - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/inc_pager.jsp,v 1.2 2009/12/15 11:04:53 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.2 $
  - $Date: 2009/12/15 11:04:53 $
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
<%--@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" --%>
<pg:index export="pages, items">
<table cellspacing="0" cellpadding="0">
  <tr class="pager">
    <td align="right" nowrap="nowrap">
      <fmt:message key="mvnforum.common.numberof.pages" bundle="${forum}"/>: <%= pages %>&nbsp;&nbsp;&nbsp;[
      <pg:prev export="pageUrl"><a href="<%=urlResolver.encodeURL(request, response, pageUrl)%>" class="pager"><fmt:message key="mvnforum.common.previous" bundle="${forum}"/></a> |</pg:prev>
      <pg:pages>
        <% if (pageNumber == currentPageNumber) { %>
          <span class="pagerCurrent"><%= pageNumber %></span>
        <% } else { %>
          <a href="<%=urlResolver.encodeURL(request, response, pageUrl)%>" class="pager"><%= pageNumber%></a>
        <% } %>
      </pg:pages>
      <pg:next export="pageUrl">| <a href="<%=urlResolver.encodeURL(request, response, pageUrl)%>" class="pager"><fmt:message key="mvnforum.common.next" bundle="${forum}"/></a></pg:next> ]
    </td>
  </tr>
</table>
</pg:index>