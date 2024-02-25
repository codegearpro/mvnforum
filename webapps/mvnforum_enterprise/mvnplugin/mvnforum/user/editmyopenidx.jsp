<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/editmyopenidx.jsp,v 1.11 2009/08/13 10:31:09 thonh Exp $
  - $Author: thonh $
  - $Revision: 1.11 $
  - $Date: 2009/08/13 10:31:09 $
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

<%@ page import="com.mvnforum.enterprise.db.OpenIDBean" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.editmyopenidx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css" />
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/js/md5.js"></script>

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
      pw2md5(document.submitform.MemberCurrentMatkhau, document.submitform.md5pw);
    }
    <mvn:servlet>
      document.submitform.submitbutton.disabled=true;
    </mvn:servlet>  
    document.submitform.submit();
  }
}

function ValidateForm() {
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

<%@ include file="header.jsp"%>
<br/>
<%
OpenIDBean openIDBean = (OpenIDBean) request.getAttribute("OpenIDBean");
%>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <a href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "myprofile")%>"><fmt:message key="mvnforum.user.header.my_profile" /></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "myopenid")%>"><fmt:message key="mvnforum.user.myopenidx.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.editmyopenidx.title"/>
</div>
<br/>

<!-- the onSubmit event prevent from being submitted by pressing enter  -->
<form action="<%=urlResolver.encodeURL(request, response, "editmyopenidprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform" onsubmit="return false;">
<%=urlResolver.generateFormAction(request, response, "editmyopenidprocess")%>
<mvn:securitytoken />
<input type="hidden" name="openid" value="<%=openIDBean.getOpenID()%>" />
<input type="hidden" name="md5pw" value="" />
<mvn:cssrows>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.user.editmyopenidx.title"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="30%"><fmt:message key="mvnforum.common.openid.open_identity"/>:</td>
    <td><b><%=openIDBean.getOpenIdentity()%></b></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="30%"><label for="OpenDesc"><fmt:message key="mvnforum.common.openid.open_desc"/>:</label></td>
    <td><input type="text" id="OpenDesc" name="OpenDesc" value="<%=openIDBean.getOpenDesc() %>" size="60" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="30%"><label for="MemberCurrentMatkhau"><fmt:message key="mvnforum.user.myopenidx.prompt.current_mvnforum_password"/><span class="requiredfield"> *</span></label></td>
    <td><input type="password" id="MemberCurrentMatkhau" name="MemberCurrentMatkhau" onkeypress="checkEnter(event);" /></td>
  </tr>
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
    <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.common.action.edit"/>" onclick="javascript:SubmitForm();" class="portlet-form-button" />
    <input type="reset" value="<fmt:message key="mvnforum.common.action.go_back"/>" onclick="javascript:history.back(1)" class="liteoption" />
    </td>
  </tr>
</table>
</mvn:cssrows>
</form>

<br/>

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>
