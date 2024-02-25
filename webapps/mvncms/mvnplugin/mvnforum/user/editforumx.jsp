<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/editforumx.jsp,v 1.31 2009/08/13 10:31:09 thonh Exp $
 - $Author: thonh $
 - $Revision: 1.31 $
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
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="com.mvnforum.db.ForumBean"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.editforumx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
<script src="<%=contextPath%>/mvnplugin/mvnforum/js/vietuni.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/js/md5.js"></script>
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">
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
    document.submitform.submit();
  }
}

function ValidateForm() {
  if (isBlank(document.submitform.ForumName, "<fmt:message key="mvnforum.common.forum.forum_name"/>")) {
    return false;
  }
  if (isBlank(document.submitform.MemberCurrentMatkhau, "<fmt:message key="mvnforum.common.prompt.current_password"/>")) {
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

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <a href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "myprofile")%>"><fmt:message key="mvnforum.user.myprofile.title"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "myprivateforums")%>"><fmt:message key="mvnforum.user.myprivateforumsx.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.editforumx.title"/>
</div>
<br/>

<%
ForumBean forumBean = (ForumBean)request.getAttribute("ForumBean");
%>
<form action="<%=urlResolver.encodeURL(request, response, "updateforum", URLResolverService.ACTION_URL)%>" method="post" name="submitform" onsubmit="return false;">
<%=urlResolver.generateFormAction(request, response, "updateforum")%>
<mvn:securitytoken />
<input type="hidden" name="md5pw" value="" />
<input type="hidden" name="ForumID" value="<%=forumBean.getForumID()%>" />
<mvn:cssrows>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.user.editforumx.title"/>:</td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="ForumName"><fmt:message key="mvnforum.common.forum.forum_name"/><span class="requiredfield"> *</span></label></td>
    <td><input type="text" id="ForumName" name="ForumName" value="<%=forumBean.getForumName()%>" size="62" onkeyup="initTyper(this);" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="ForumDesc"><fmt:message key="mvnforum.common.forum.forum_description"/>:</label></td>
    <td><textarea cols="60" rows="6" id="ForumDesc" name="ForumDesc" onkeyup="initTyper(this);"><%=forumBean.getForumDesc()%></textarea></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="ForumOwnerName"><fmt:message key="mvnforum.common.forum.forum_owner_name"/>:</label></td>
    <td><input type="text" id="ForumOwnerName" name="ForumOwnerName" value="<%=forumBean.getForumOwnerName()%>" size="30" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="ForumModerationMode"><fmt:message key="mvnforum.common.forum.moderation_mode"/>:</label></td>
    <td>
      <select id="ForumModerationMode" name="ForumModerationMode" style="width: 220px;">
        <option value="0" <%if (forumBean.getForumModerationMode() == 0) {%>selected="selected" <%}%>><fmt:message key="mvnforum.common.forum.moderation_mode.default"/></option>
        <option value="1" <%if (forumBean.getForumModerationMode() == 1) {%>selected="selected" <%}%>><fmt:message key="mvnforum.common.forum.moderation_mode.no"/></option>
        <option value="2" <%if (forumBean.getForumModerationMode() == 2) {%>selected="selected" <%}%>><fmt:message key="mvnforum.common.forum.moderation_mode.thread_post"/></option>
        <option value="3" <%if (forumBean.getForumModerationMode() == 3) {%>selected="selected" <%}%>><fmt:message key="mvnforum.common.forum.moderation_mode.thread"/></option>
        <option value="4" <%if (forumBean.getForumModerationMode() == 4) {%>selected="selected" <%}%>><fmt:message key="mvnforum.common.forum.moderation_mode.post"/></option>
      </select>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="MemberCurrentMatkhau"><fmt:message key="mvnforum.common.prompt.current_password"/><span class="requiredfield"> *</span></label></td>
    <td><input type="password" id="MemberCurrentMatkhau" name="MemberCurrentMatkhau" size="30" onkeypress="checkEnter(event);" /></td>
  </tr>

<%if (currentLocale.equals("vi")) {/*vietnamese here*/%>
  <tr class="<mvn:cssrow/>">
    <td valign="top" nowrap="nowrap"><fmt:message key="mvnforum.common.vietnamese_type"/>:</td>
    <td>
      <input type="radio" name="vnselector" id="TELEX" value="TELEX" onclick="setTypingMode(1);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.telex"/>&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" name="vnselector" id="VNI" value="VNI" onclick="setTypingMode(2);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.vni"/>&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" name="vnselector" id="VIQR" value="VIQR" onclick="setTypingMode(3);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.VIQR"/><br/>
      <input type="radio" name="vnselector" id="NOVN" value="NOVN" onclick="setTypingMode(0);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.not_use"/>
      <script type="text/javascript">
      //<![CDATA[
      initVNTyperMode();
      //]]>
      </script>
    </td>
  </tr>
<%}// end if vietnamese%>
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.common.action.save"/>" onclick="javascript:SubmitForm();" class="portlet-form-button" />
      <input type="reset" value="<fmt:message key="mvnforum.common.action.reset"/>" class="liteoption" />
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