<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/requestforumx.jsp,v 1.14 2009/08/13 10:31:09 thonh Exp $
  - $Author: thonh $
  - $Revision: 1.14 $
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

<%@ page import="java.util.*"%>
<%@ page import="com.mvnforum.db.*"%>
<%@ page import="net.myvietnam.mvncore.util.ParamUtil"%>
<%@ page import="net.myvietnam.mvncore.filter.HtmlNewLineFilter"%>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.requestforumx.title"/></mvn:title>
  <%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
  <link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;document.submitform.previewbutton.disabled=false;">
<%
boolean preview = ParamUtil.getParameterBoolean(request, "preview");
String subject = ParamUtil.getAttribute(request, "Subject");
String fromEmail = ParamUtil.getAttribute(request, "FromEmail");

String forumName = "";
String forumDesc = "";
String userComment = "";
String emailContent = "";

if (preview) {
  forumName = ParamUtil.getAttribute(request, "ForumName");
  forumDesc = ParamUtil.getAttribute(request, "ForumDesc");
  userComment = ParamUtil.getAttribute(request, "UserComment");
  emailContent = ParamUtil.getAttribute(request, "EmailContent");
}
%>
<script type="text/javascript">
//<![CDATA[
function SubmitForm() {
  if (ValidateForm() == true) {
    <mvn:servlet>
      document.submitform.submitbutton.disabled=true;
      document.submitform.previewbutton.disabled=true;
    </mvn:servlet>  
    document.submitform.submit();
  }
}

function SubmitPreviewForm() {
  if (ValidateForm() == true) {
    document.submitform.preview.value='true';
    document.submitform.action=document.getElementById('previewUrl').value;
    <%=urlResolver.generateFormActionForJavascript(request, response, "requestforum", "submitform")%>
    <mvn:servlet>
    document.submitform.submitbutton.disabled=true;
    document.submitform.previewbutton.disabled=true;
    </mvn:servlet>  
    document.submitform.submit();
  }
}

function ValidateForm() {
  if (isBlank(document.submitform.ForumName, "<fmt:message key="mvnforum.common.forum.forum_name"/>")) {
    return false;
  }
  if (isBlank(document.submitform.ForumDesc, "<fmt:message key="mvnforum.common.forum.forum_description"/>")) {
    return false;
  }
  if (isBlank(document.submitform.UserComment, "<fmt:message key="mvnforum.user.requestforumx.user_comment"/>")) {
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
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index" /></a>&nbsp;&raquo;&nbsp; 
  <a href="<%=urlResolver.encodeURL(request, response, "myprofile")%>"><fmt:message key="mvnforum.user.myprofile.title"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "myprivateforums")%>"><fmt:message key="mvnforum.user.myprivateforumsx.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.user.requestforumx.title"/>
</div>
<br/>

<% if (preview) { %>
<mvn:cssrows>
  <table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
    <tr class="portlet-section-header">
      <td colspan="2"><fmt:message key="mvnforum.common.action.preview"/></td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td align="right" nowrap="nowrap" width="30%"><fmt:message key="mvnforum.common.email.from"/>:</td>
      <td><%=fromEmail%></td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td align="right" nowrap="nowrap"><fmt:message key="mvnforum.common.email.subject"/>:</td>
      <td><%=subject%></td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td align="right" nowrap="nowrap"><fmt:message key="mvnforum.common.email.subject"/>:</td>
      <td><%=HtmlNewLineFilter.filter(DisableHtmlTagFilter.filter(emailContent))%></td>
    </tr>
  </table>
</mvn:cssrows>
<br/>
<% } // if preview %>

<input type="hidden" name="previewUrl" id="previewUrl" value="<%=urlResolver.encodeURL(request, response, "requestforum", URLResolverService.ACTION_URL)%>" />
<form action="<%=urlResolver.encodeURL(request, response, "requestforumprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "requestforumprocess")%>
<mvn:securitytoken />
<input type="hidden" name="preview" value="" />
<mvn:cssrows>
  <table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
    <tr class="portlet-section-header">
      <td colspan="2"><fmt:message key="mvnforum.user.requestforumx.title"/>:</td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td align="right" nowrap="nowrap" width="30%"><fmt:message key="mvnforum.common.email.from"/>:</td>
      <td><%=fromEmail%></td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td align="right" nowrap="nowrap"><fmt:message key="mvnforum.common.email.subject"/>:</td>
      <td><%=subject%></td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td align="right" nowrap="nowrap"><label for="ForumName"><fmt:message key="mvnforum.common.forum.forum_name"/><span class="requiredfield"> *</span></label></td>
      <td><input type="text" id="ForumName" name="ForumName" value="<%=DisableHtmlTagFilter.filter(forumName)%>" size="62" /></td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td align="right" valign="top" nowrap="nowrap"><label for="ForumDesc"><fmt:message key="mvnforum.common.forum.forum_description"/><span class="requiredfield"> *</span></label></td>
      <td><textarea cols="60" rows="5" id="ForumDesc" name="ForumDesc"><%=DisableHtmlTagFilter.filter(forumDesc)%></textarea></td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td align="right" valign="top" nowrap="nowrap"><label for="UserComment"><fmt:message key="mvnforum.user.requestforumx.user_comment"/><span class="requiredfield"> *</span></label></td>
      <td><textarea cols="60" rows="10" id="UserComment" name="UserComment"><%=DisableHtmlTagFilter.filter(userComment)%></textarea></td>
    </tr>
    <tr class="portlet-section-footer">
      <td colspan="2" align="center">
        <input type="button" name="previewbutton" value="<fmt:message key="mvnforum.common.action.preview"/>" onclick="javascript:SubmitPreviewForm();" class="liteoption" /> 
        <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.common.action.send_mail"/>" onclick="javascript:SubmitForm();" class="portlet-form-button" /> 
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
