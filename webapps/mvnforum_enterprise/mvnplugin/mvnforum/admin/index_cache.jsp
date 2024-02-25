<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/index_cache.jsp,v 1.1 2009/05/14 11:14:13 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.1 $
  - $Date: 2009/05/14 11:14:13 $
  -
  - ====================================================================
  -
  - Copyright (C) 2002-2007 by MyVietnam.net
  -
  - MyVietnam.net PROPRIETARY/CONFIDENTIAL PROPERTIES. Use is subject to license terms.
  - You CANNOT use this software unless you receive a written permission from MyVietnam.net
  -
  - @author: MyVietnam.net developers
  -
--%>
<%@ page import="com.mvnforum.enterprise.db.*" %>

  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.index.cache_report_voteperiod"/> - <a href="<%=urlResolver.encodeURL(request, response, "clearcache?target=voteperiod&amp;mvncoreSecurityToken=" + SecurityUtil.getSessionToken(request), URLResolverService.ACTION_URL)%>" class="command"><fmt:message key="mvnforum.common.action.clear_cache"/></a></td>
    <td><%=VotePeriodCache.getInstance().getEfficiencyReport()%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.index.cache_report_album"/> - <a href="<%=urlResolver.encodeURL(request, response, "clearcache?target=album&amp;mvncoreSecurityToken=" + SecurityUtil.getSessionToken(request), URLResolverService.ACTION_URL)%>" class="command"><fmt:message key="mvnforum.common.action.clear_cache"/></a></td>
    <td><%=AlbumCache.getInstance().getEfficiencyReport()%></td>
  </tr>