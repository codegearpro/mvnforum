<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/WEB-INF/mvnplugin/mvnforum/mobile/inc_pager.jsp,v 1.8 2009/05/11 02:21:54 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.8 $
  - $Date: 2009/05/11 02:21:54 $
  -
  - ====================================================================
  -
  - Copyright (C) 2002-2007 by MyVietnam.net
  -
  - MyVietnam.net PROPRIETARY/CONFIDENTIAL PROPERTIES. Use is subject to license terms.
  - You CANNOT use this software unless you receive a written permission from MyVietnam.net
  -
  - @author: Nhan Luu Duy
  -
--%>
<%--@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" --%>
<pg:index export="pages, items">  
  <div class="padding1px">
    [ <pg:prev export="pageUrl"><a href="<%=pageUrl%>"><fmt:message key="mvnforum.mobile.previous"/></a> |</pg:prev>
      <pg:pages>
        <% if (pageNumber == currentPageNumber) { %>
          <span class="pagerCurrent"><%= pageNumber %></span>
        <% } else { %>
          <a href="<%=pageUrl%>" class="pager"><%= pageNumber%></a>
        <% } %>
      </pg:pages>
      <pg:next export="pageUrl">| <a href="<%=pageUrl%>"><fmt:message key="mvnforum.mobile.next"/></a></pg:next> ]
  </div>
  <div><%= rowsType %>: <%= items %></div>
  <div><fmt:message key="mvnforum.common.numberof.pages"/>: <%= pages %></div>
</pg:index>
