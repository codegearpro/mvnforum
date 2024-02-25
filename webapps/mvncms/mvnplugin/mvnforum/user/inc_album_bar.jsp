<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/inc_album_bar.jsp,v 1.13 2009/01/12 11:17:09 trungth Exp $
  - $Author: trungth $
  - $Revision: 1.13 $
  - $Date: 2009/01/12 11:17:09 $
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
<%String rootURI = (String) request.getAttribute("RootURI");%>
<form action="<%=urlResolver.encodeURL(request, response, "searchalbumitem", URLResolverService.ACTION_URL)%>" name="searchform" <mvn:method/>>
<%=urlResolver.generateFormAction(request, response, "searchalbumitem")%>
<table align="center" width="95%" class="tborder" cellpadding="2" cellspacing="0">
  <tr class="topmenu">
    <td width="100%">
      <table width="100%" cellspacing="0" cellpadding="1" class="noborder">
        <tr>
          <td>
            <a href="<%=urlResolver.encodeURL(request, response, "addalbum?check1=0")%>" class="linktop"><fmt:message key="mvnforum.user.addalbumx.title"/></a>&nbsp;&nbsp;&nbsp;
          <% if ("mypublicalbums".equals(rootURI)) { %>
            <a href="<%=urlResolver.encodeURL(request, response, "myalbums")%>" class="linktop"><fmt:message key="mvnforum.user.listalbumsx.my_albums"/></a>&nbsp;&nbsp;&nbsp;
            <fmt:message key="mvnforum.user.listalbumsx.my_public_albums"/>&nbsp;&nbsp;&nbsp;
          <% } else {%>
            <fmt:message key="mvnforum.user.listalbumsx.my_albums"/>&nbsp;&nbsp;&nbsp;
            <a href="<%=urlResolver.encodeURL(request, response, "mypublicalbums")%>" class="linktop"><fmt:message key="mvnforum.user.listalbumsx.my_public_albums"/></a>&nbsp;&nbsp;&nbsp;
          <% }%>
            <%-- <a href="#" class="linktop"><fmt:message key="mvnforum.user.listalbumsx.my_favorites"/></a>&nbsp;&nbsp;&nbsp;--%>
          </td>
          <td align="right">
            <select name="searchScope">
            <%if (MVNForumConfig.getEnablePrivateAlbum()) { %>
              <option value="MyAlbums" selected="selected"><fmt:message key="mvnforum.user.listalbumsx.my_albums"/></option>
            <%}%>
            <%if (MVNForumConfig.getEnablePublicAlbum()) { %>
              <option value="PublicAlbums"><fmt:message key="mvnforum.user.listalbumsx.public_albums"/></option>
            <%}%>
            </select>
            <input type="text" name="searchString" />
            <input type="submit" value="<fmt:message key="mvnforum.common.action.search_photos"/>" class="portlet-form-button" />
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</form>
