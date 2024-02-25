<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/myopenidx.jsp,v 1.20 2009/11/18 08:12:07 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.20 $
  - $Date: 2009/11/18 08:12:07 $
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

<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.mvnforum.enterprise.db.OpenIDBean" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name" /> - <fmt:message key="mvnforum.user.myopenidx.title" /></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="<%=contextPath%>/mvnplugin/mvnforum/css/openid.css" />
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/js/md5.js"></script>
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/js/jquery/jquery.js"></script>
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/js/openid-jquery.js"></script>
<script type="text/javascript">
jQuery(document).ready(function($) {
    $.openid.init('add', 'openid_identifier', '<fmt:message key="mvnforum.common.action.add"/>', '<fmt:message key="mvnforum.common.openid.enter_username"/>', '<%=contextPath%>/mvnplugin/mvnforum/images/openid/');
});
</script>
<script type="text/javascript">
//<![CDATA[
function checkEnter(event) {
  var agt=navigator.userAgent.toLowerCase();

  // Maybe, Opera make an onclick event when user press enter key
  // on the text field of the form
  if (agt.indexOf('opera') >= 0) return;

  // enter key is pressed
  if (getKeyCode(event) == 13)
    SubmitForm();
}
function SubmitForm() {
  if (ValidateForm() == true) {
    var enableEncrypted = <%=MVNForumConfig.getEnableEncryptPasswordOnBrowser()%>;
    if (enableEncrypted) {
      pw2md5(document.submitform.MemberCurrentMatkhau, document.submitform.md5pw);
    }
    <mvn:servlet>
      document.submitform.submitbutton.disabled=true;
    </mvn:servlet>
    jQuery('#openid_form').submit();
  }
}

function ValidateForm() {
  if (jQuery.openid.provider_label) {
    if (isBlank(document.submitform.openid_username, "<fmt:message key="mvnforum.common.prompt.openid"/>")) {
      return false;
    }
  }
  if (isBlank(document.submitform.MemberCurrentMatkhau, "<fmt:message key="mvnforum.user.myopenidx.prompt.current_mvnforum_password"/>")) {
    return false;
  }
  if (document.submitform.MemberCurrentMatkhau.value.length < 3) {
    alert("<fmt:message key="mvnforum.common.js.prompt.invalidlongpassword"/>");
    document.submitform.MemberCurrentMatkhau.focus();
    return false;
  }
  return true;
}
//]]>
</script>

</mvn:head>

<mvn:body onunload="document.submitform.submitbutton.disabled=false;">

<%@ include file="header.jsp"%>
<br/>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index" /></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "myprofile")%>"><fmt:message key="mvnforum.user.header.my_profile" /></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.myopenidx.title" />
</div>
<br/>

<div class="pagedesc">
  <fmt:message key="mvnforum.user.myopenidx.guide">
    <fmt:param><a href="http://openid.net/what/" target="_blank"></fmt:param>
    <fmt:param></a></fmt:param>
    <fmt:param><a href="http://openid.net/get/" target="_blank"></fmt:param>
    <fmt:param></a></fmt:param>
  </fmt:message>
</div>
<br />

<form action="<%=urlResolver.encodeURL(request, response, "openidlogin", URLResolverService.ACTION_URL)%>" method="post" id="openid_form" name="submitform" onsubmit="return false;">
<%=urlResolver.generateFormAction(request, response, "openidlogin")%>
<mvn:securitytoken />
<input type="hidden" name="associate" value="true" />
<input type="hidden" name="md5pw" value="" />
<mvn:cssrows>
<table class="tborder" width="95%" align="center" cellpadding="3" cellspacing="0">
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.common.openid.choose_provider" /></td>
  </tr>
  <tr>
    <td><fmt:message key="mvnforum.common.prompt.openid"/><span class="requiredfield"> *</span></td>
    <td>
      <div id="openid_choice">
        <div id="openid_btns"></div>
      </div>
      
      <div id="openid_input_area">
        <input id="openid_identifier" name="openid_identifier" type="text" value="http://" />
      </div>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="MemberCurrentMatkhau"><fmt:message key="mvnforum.user.myopenidx.prompt.current_mvnforum_password"/><span class="requiredfield"> *</span></label></td>
    <td><input type="password" id="MemberCurrentMatkhau" name="MemberCurrentMatkhau" size="30" onkeypress="checkEnter(event);" /></td>
  </tr>
  <tr class="portlet-section-header">
    <td colspan="2" align="center">
      <input type="button" id="submitbutton" name="submitbutton" value="<fmt:message key="mvnforum.common.action.add"/>" onclick="javascript:SubmitForm();" class="portlet-form-button" />
    </td>
  </tr>
</table>
</mvn:cssrows>
</form>
<br />

<%
Collection openIDBeans = (Collection) request.getAttribute("OpenIDBeans");
%>
<table class="tborder" width="95%" align="center" cellpadding="3" cellspacing="0">
  <tr class="portlet-section-header">
    <td><fmt:message key="mvnforum.common.openid.open_identity" /></td>
    <td><fmt:message key="mvnforum.common.openid.open_desc" /></td>
    <td align="center"><fmt:message key="mvnforum.common.date.create_date" /></td>
    <td align="center"><fmt:message key="mvnforum.common.date.modified_date" /></td>
    <td align="center"><fmt:message key="mvnforum.common.action.edit" /></td>
    <td align="center"><fmt:message key="mvnforum.common.action.delete" /></td>
  </tr>
  <% for (Iterator iter = openIDBeans.iterator(); iter.hasNext(); ) {
      OpenIDBean openIDBean = (OpenIDBean) iter.next();
  %>
  <tr>
    <td><%=openIDBean.getOpenIdentity()%></td>
    <td><%=openIDBean.getOpenDesc()%></td>
    <td align="center"><%=onlineUser.getGMTTimestampFormat(openIDBean.getOpenCreationDate())%></td>
    <td align="center"><%=onlineUser.getGMTTimestampFormat(openIDBean.getOpenModifiedDate())%></td>
    <td align="center"><a class="command" href="<%=urlResolver.encodeURL(request, response, "editmyopenid?openid=" + openIDBean.getOpenID())%>"><fmt:message key="mvnforum.common.action.edit" /></a></td>
    <td align="center"><a class="command" href="<%=urlResolver.encodeURL(request, response, "deletemyopenid?openid=" + openIDBean.getOpenID())%>"><fmt:message key="mvnforum.common.action.delete" /></a></td>
  </tr>
  <% } //end for %>
  <% if (openIDBeans.size() == 0) { %>
  <tr>
    <td colspan="6" align="center"><fmt:message key="mvnforum.user.myopenidx.no_openids" /></td>
  </tr>
  <% } %>
</table>
<br />

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>