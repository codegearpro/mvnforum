<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/removebuddyx.jsp,v 1.18 2009/09/15 03:18:00 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.18 $
 - $Date: 2009/09/15 03:18:00 $
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
<%-- not localized yet --%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page errorPage="fatalerror.jsp"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">

  <mvn:html locale="${currentLocale}">
  <mvn:head>
    <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - Remove Buddy</mvn:title>
  <%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
  <link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
  </mvn:head>
  <mvn:body onunload="document.submitform.submitbutton.disabled=false;">

  <br/>
  <div class="nav center">
    <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
    <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
    Remove Buddy
  </div>

  <script type="text/javascript">
  //<![CDATA[
    var user;
    var name;

    function CheckInputForm() {

      user = document.submitform.user.value;
      name = document.submitform.name.value;

        if (user == "" ) {
          alert ("The parameter 'User' is not allowed to be empty! Please try again.");
          return false;
        } else if (name == "" ) {
          alert ("The parameter 'Name' is not allowed to be empty! Please try again.");
          return false;
        }
        return true;
    }

    function SubmitForm() {

      if (CheckInputForm() == true) {
        <mvn:servlet>
          document.submitform.submitbutton.disabled=true;
        </mvn:servlet>
        document.submitform.submit();
      }
    }
  //]]>
  </script>
  <form action="<%=urlResolver.encodeURL(request, response, "remove_buddy", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
  <%=urlResolver.generateFormAction(request, response, "remove_buddy")%>
  <mvn:securitytoken />
      <label for="user">User</label>  : <input type="text" name="user" id="user" /><p>
      <label for="name">Name</label>  : <input type="text" name="name" id="name" /><p>
      Group  : <select name="action">
        <option value="group">Friends </option>
      </select>

      <input align="right" type="button" name="submitbutton" value="<fmt:message key="mvnforum.common.action.remove"/>" onclick="SubmitForm();" />
  </form>

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>