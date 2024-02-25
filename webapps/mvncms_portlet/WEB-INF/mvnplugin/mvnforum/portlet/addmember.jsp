<%--
  - $Header: /home/cvsroot/portlet-mvnforum/srcweb/WEB-INF/mvnplugin/mvnforum/portlet/addmember.jsp,v 1.14 2010/08/20 05:16:10 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.14 $
  - $Date: 2010/08/20 05:16:10 $
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
<%@ page errorPage="fatalerror.jsp"%>
<%@ page import="com.mvnforum.*" %>
<%@ include file="inc_common.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css">
<script type="text/javascript">
//<![CDATA[
function SubmitForm() {
  if (ValidateForm() == true ) {
    document.submitform.submitbutton.disabled=true;
    document.submitform.submit();
  }
}

function ValidateForm() {
  if (isBlank(document.submitform.MemberName, "Member ID")) return false;
  if (isBlank(document.submitform.MemberMatkhau, "Password")) return false;

  if (document.submitform.MemberMatkhau.value.length < 3) {
    alert("<fmt:message key="mvnforum.common.js.prompt.invalidlongpassword"/>");
    document.submitform.MemberMatkhau.focus();
    return false;
  }

  if (isBlank(document.submitform.MemberMatkhauConfirm, "Password Confirm")) return false;
  if (document.submitform.MemberMatkhau.value!=document.submitform.MemberMatkhauConfirm.value) {
    alert("Passwords don't match.");
    return false;
  }

  if (isBlank(document.submitform.MemberEmail, "E-mail")) return false;
  if (isBlank(document.submitform.MemberEmailConfirm, "E-mail Confirm")) return false;
  if (!isEmail(document.submitform.MemberEmail, "E-mail")) return false;
  if (!isEmail(document.submitform.MemberEmailConfirm, "E-mail Confirm")) return false;
  if (document.submitform.MemberEmail.value != document.submitform.MemberEmailConfirm.value ) {
    alert("E-mails don't match.");
    return false;
  }
  return true;
}
//]]>
</script>
<br />

<div class="pagedesc center">
  Pluto does not provide the function for registering new member. Therefore this page is provided
  to emulate a page to register new member which can be found in almost all standard portals.
</div>

<br />
<br />
<form action="<%=urlResolver.encodeURL(request, response, "addmemberprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "addmemberprocess")%>
<mvn:securitytoken />
<mvn:cssrows>
<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td colspan="2">Please enter the following information to register user</td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="MemberName">Member ID</label><span class="requiredfield"> *</span></td>
    <td><input type="text" size="60" id="MemberName" name="MemberName"></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="MemberMatkhau">Password</label><span class="requiredfield"> *</span></td>
    <td><input type="password" size="60" id="MemberMatkhau" name="MemberMatkhau"></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="MemberMatkhauConfirm">Password Confirm (retype)</label><span class="requiredfield"> *</span></td>
    <td><input type="password" size="60" id="MemberMatkhauConfirm" name="MemberMatkhauConfirm"></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="MemberEmail">E-mail</label><span class="requiredfield"> *</span></td>
    <td><input type="text" size="60" id="MemberEmail" name="MemberEmail"></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="MemberEmailConfirm">E-mail Confirm (retype)</label><span class="requiredfield"> *</span></td>
    <td><input type="text" size="60" id="MemberEmailConfirm" name="MemberEmailConfirm"></td>
  </tr>
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <input type="submit" name="submitbutton" value="Register User" class="portlet-form-button">
      <input type="Reset" class="liteoption">
    </td>
  </tr>
</table>
</mvn:cssrows>
</form>
</fmt:bundle>