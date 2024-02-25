<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/associateopenidtoforumx.jsp,v 1.9 2009/09/17 07:51:05 thonh Exp $
  - $Author: thonh $
  - $Revision: 1.9 $
  - $Date: 2009/09/17 07:51:05 $
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
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="net.myvietnam.mvncore.util.*" %>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter" %>
<%@ page import="com.mvnforum.auth.OnlineUserManager" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.associateopenidtoforumx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/js/md5.js"></script>
<%@ include file="header.jsp"%>

<script type="text/javascript">
//<![CDATA[
function checkEnter(event) {
  var agt=navigator.userAgent.toLowerCase();
  
  // Maybe, Opera make an onClick event when user press enter key 
  // on the text field of the form
  if (agt.indexOf('opera') >= 0) return;

  // enter key is pressed
  if (getKeyCode(event) == 13)
    SubmitForm();
}

function SubmitForm() {
  if (ValidateForm()) {
    var enableEncrypted = <%=MVNForumConfig.getEnableEncryptPasswordOnBrowser()%>;
    if (enableEncrypted) {
      pw2md5(document.submitform.MemberMatkhau, document.submitform.md5pw);
    }
    <mvn:servlet>
    document.submitform.submitbutton.disabled=true;
    </mvn:servlet>
    return document.submitform.submit();
  }
  return false;
}

function ValidateForm() {
  if (isBlank(document.submitform.MemberName, "<fmt:message key="mvnforum.common.member.login_name"/>")) return false;
  if (isBlank(document.submitform.MemberMatkhau, "<fmt:message key="mvnforum.common.member.password"/>")) return false;
  //Check Password's length
  if (document.submitform.MemberMatkhau.value.length < 3) {
    alert("<fmt:message key="mvnforum.common.js.prompt.invalidlongpassword"/>");
    document.submitform.MemberMatkhau.focus();
    return false;
  }
  return true;
}
//]]>
</script>
<br />
<%
String openid_identifier = (String) request.getSession().getAttribute(OnlineUserManager.MVNFORUM_SESSION_OPENID_IDENTITY);
%>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.associateopenidtoforumx.title" />
</div>
<br />

<%
String errorMessage = ParamUtil.getAttribute(request, "Reason");
%>
<% if (errorMessage.length() > 0) { %>
<div class="pagedesc">
  <fmt:message key="mvnforum.user.login.message"/>: <span class="warning"><%=errorMessage%></span>
</div>
<br />
<% } %>

<% if (internalUserDatabase) {%>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td><fmt:message key="mvnforum.user.associateopenidtoforumx.guide.title"/></td>
  </tr>
  <tr class="pagedesc">
    <td>
      <fmt:message key="mvnforum.user.associateopenidtoforumx.guide">
        <fmt:param><%=openid_identifier%></fmt:param>
        <fmt:param><a href="<%=urlResolver.encodeURL(request, response, "registermember")%>" class="command"></fmt:param>
        <fmt:param></a></fmt:param>
      </fmt:message>
    </td>
  </tr>
</table>
<br />
<%}%>

<%if (MVNForumConfig.getEnableLogin()) {%>
<table width="95%" align="center" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top">
      <form action="<%=urlResolver.encodeURL(request, response, "associateopenidtoforumprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform" onsubmit="return false;">
        <%=urlResolver.generateFormAction(request, response, "associateopenidtoforumprocess")%>
        <mvn:securitytoken />
        <input type="hidden" name="FromLoginPage" value="true" />
        <input type="hidden" name="md5pw" value="" />
        <input type="hidden" name="url" value="<%=DisableHtmlTagFilter.filter(ParamUtil.getParameter(request, "url"))%>" />
        <input type="hidden" name="referer" value="<%=StringUtil.getReferer(request)%>" />
        <div align="left">
          <table class="tborder" width="100%" cellspacing="0" cellpadding="3">
            <mvn:cssrows>
              <tr class="portlet-section-header">
                <td colspan="2"><fmt:message key="mvnforum.user.login.mvnforum_account"/></td>
              </tr>
              <tr class="<mvn:cssrow/>">
                <td width="40%"><label for="Name"><fmt:message key="mvnforum.common.member.login_name"/><span class="requiredfield"> *</span></label></td>
                <td><input type="text" id="Name" name="MemberName" value="<%=ParamUtil.getAttribute(request, "MemberName")%>" /></td>
              </tr>
              <tr class="<mvn:cssrow/>">
                <td><label for="Matkhau"><fmt:message key="mvnforum.common.member.password"/><span class="requiredfield"> *</span></label></td>
                <td><input type="password" id="Matkhau" name="MemberMatkhau" onkeypress="checkEnter(event);" /></td>
              </tr>
              <tr class="<mvn:cssrow/>">
                <td colspan="2">
                  <fmt:message key="mvnforum.user.associateopenidtoforumx.guide.short_guide">
                    <fmt:param><%=openid_identifier%></fmt:param>
                  </fmt:message>
              </td>
              </tr>
              <tr class="portlet-section-footer">
                <td colspan="2" align="center">
                <%if (MVNForumConfig.getEnableLogin()) {%>
                  <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.common.action.login"/>" onclick="javascript:SubmitForm();" class="portlet-form-button" />
                <%} else {%>
                  <span class="warning"><b><fmt:message key="mvnforum.user.login.login_disabled"/></b><span>
                <%}%>
                </td>
              </tr>
            </mvn:cssrows>
          </table>
        </div>
      </form>
      <script type="text/javascript">
      //<![CDATA[
        document.submitform.MemberName.focus();
      //]]>
      </script>
    </td>
  </tr>
</table>
<br />
<% } %>

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>