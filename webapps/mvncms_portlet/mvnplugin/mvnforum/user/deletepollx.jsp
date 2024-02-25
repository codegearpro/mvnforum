<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/deletepollx.jsp,v 1.47 2009/10/22 06:49:25 trungth Exp $
  - $Author: trungth $
  - $Revision: 1.47 $
  - $Date: 2009/10/22 06:49:25 $
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

<%@ page import="java.util.*" %>
<%@ page import="com.mvnforum.db.ThreadBean"%>
<%@ page import="com.mvnforum.db.PollBean"%>
<%@ page import="com.mvnforum.db.PollAnswerBean"%>
<%@ page import="com.mvnforum.MVNForumConfig"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<%
  PollBean pollBean = (PollBean) request.getAttribute("PollBean");
  int pollType = ((Integer)request.getAttribute("PollType")).intValue();
  ThreadBean threadBean = null;
  if (pollType == PollBean.THREAD) {
    threadBean = (ThreadBean) request.getAttribute("ThreadBean");
  }
  Collection pollAnswerBeans = (Collection) request.getAttribute("PollAnswerBeans");
%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.deletepollx.title"/></mvn:title>
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
  if (isBlank(document.submitform.MemberCurrentMatkhau, "<fmt:message key="mvnforum.common.prompt.current_password"/>")) return false;
  if (document.submitform.MemberCurrentMatkhau.value.length < 3) {
    alert("<fmt:message key="mvnforum.common.js.prompt.invalidlongpassword"/>");
    document.submitform.MemberCurrentMatkhau.focus();
    return false;
  }
  return true;
}
//]]>
</script>

<%if (isPollPortlet == false) {%>
  <%@ include file="header.jsp"%>
 
  <br/>
  
  <%if (pollType == PollBean.THREAD) {%>
  <div class="nav center">
    <%= request.getAttribute("tree") %>
  </div>
  <%} else {%>
  <div class="nav center">
    <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
    <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
    <a href="<%=urlResolver.encodeURL(request, response, "listpolls")%>"><fmt:message key="mvnforum.user.listpollsx.title"/></a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.user.deletepollx.title"/>
  </div>
  <%}%>
<%} else {%>
  <%@ include file="header_poll.jsp"%>
  <br/>
  
  <%if (pollType == PollBean.THREAD) {%>
  <div class="nav center">
    <%= request.getAttribute("tree") %>
  </div>
  <%} else {%>
  <div class="nav center">
    <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
    <a href="<%=urlResolver.encodeURL(request, response, "", URLResolverService.ACTION_URL)%>"><fmt:message key="mvnforum.user.header.index"/></a>&nbsp;&raquo;&nbsp;
    <a href="<%=urlResolver.encodeURL(request, response, "listpolls")%>"><fmt:message key="mvnforum.user.listpollsx.title"/></a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.user.deletepollx.title"/>
  </div>
  <%}%>
<%} %> 

<br/>
<form action="<%=urlResolver.encodeURL(request, response, "deletepollprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform" onsubmit="return false;">
<%=urlResolver.generateFormAction(request, response, "deletepollprocess")%>
<mvn:securitytoken />
<input type="hidden" name="pollid" value="<%=pollBean.getPollID()%>" />
<input type="hidden" name="typeOfPoll" value="<%=pollType%>" />
<%if (pollType == PollBean.THREAD) {%>
  <input type="hidden" name="threadid" value="<%=threadBean.getThreadID()%>" />
<%}%>
<input type="hidden" name="md5pw" value="" />
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
 <tbody>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.user.deletepollx.title"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td colspan="2">
      <b><%= pollBean.getPollQuestion() %></b>
      <ol>
      <%
        int i = 0;
        for (Iterator pollIter = pollAnswerBeans.iterator(); pollIter.hasNext(); ) {
          PollAnswerBean pollAnswerBean = (PollAnswerBean) pollIter.next();
      %>
          <li><%= pollAnswerBean.getPollAnswerText() %></li>
      <%}%>
      </ol>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="40%"><label for="MemberCurrentMatkhau"><fmt:message key="mvnforum.common.prompt.current_password"/><span class="requiredfield"> *</span></label></td>
    <td><input type="password" id="MemberCurrentMatkhau" name="MemberCurrentMatkhau" onkeypress="checkEnter(event);" /></td>
  </tr>
  <tr class="portlet-section-footer">
    <td align="center" colspan="2">
      <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.user.deletepollx.button.delete"/>" onclick="javascript:SubmitForm()" class="portlet-form-button" />
      <input type="reset" value="<fmt:message key="mvnforum.common.action.go_back"/>" onclick="javascript:history.back(1)" class="liteoption" />
    </td>
  </tr>
  </tbody>
</mvn:cssrows>
</table>
</form>
<br/>
<%if (isPollPortlet == false) {%>
  <%@ include file="footer.jsp"%>
<%} %>
</mvn:body>
</mvn:html>
</fmt:bundle>