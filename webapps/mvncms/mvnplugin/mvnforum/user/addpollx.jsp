<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/addpollx.jsp,v 1.110 2009/11/18 08:12:07 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.110 $
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
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Collection"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="net.myvietnam.mvncore.util.DateUtil"%>
<%@ page import="net.myvietnam.mvncore.util.ParamUtil"%>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter"%>
<%@ page import="net.myvietnam.mvncore.filter.EnableMVNCodeFilter"%>
<%@ page import="net.myvietnam.mvncore.service.URLResolverService"%>
<%@ page import="com.mvnforum.LocaleMessageUtil"%>
<%@ page import="com.mvnforum.db.*"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<%
  String question = "";
  boolean multi = false;
  boolean changevote = false;
  boolean ispublic = false;
  boolean isanonymouspoll = false;
  int hidepoll = PollBean.POLL_SHOW_RESULT_TO_ANYONE;
  String poll_expire = "";
  Collection pollAnswerBeans = null;
  PollBean pollBean = null;
  String previewUrl = "";
  String previewAction = "addthreadpoll";
  boolean hasExpired = false;

  String pollAction = request.getAttribute("PollAction").toString();
  int pollType = ((Integer)request.getAttribute("PollType")).intValue();
  
  boolean isPreviewing = ParamUtil.getParameterBoolean(request, "preview");
  
  if (pollAction.equals("AddPoll")) {
    if (pollType == PollBean.THREAD) {
      previewUrl = urlResolver.encodeURL(request, response, "addthreadpoll", URLResolverService.ACTION_URL);
    } else if (pollType == PollBean.ALBUMITEM) {
      previewUrl = urlResolver.encodeURL(request, response, "addalbumitempoll", URLResolverService.ACTION_URL);
      previewAction = "addalbumitempoll";
    } else if (pollType == PollBean.ORPHAN) {
      previewUrl = urlResolver.encodeURL(request, response, "addorphanpoll", URLResolverService.ACTION_URL);
      previewAction = "addorphanpoll";
    }    
    pollBean = (PollBean)request.getAttribute("PollBean");
    if (isPreviewing) {
        question = ParamUtil.getParameter(request, "PollQuestion", true);
        question = DisableHtmlTagFilter.filter(question);
        multi = ParamUtil.getParameterBoolean(request, "PollMultiple");
        changevote = ParamUtil.getParameterBoolean(request, "PollVoteChange");
        ispublic = ParamUtil.getParameterBoolean(request, "PollPublic");
        hidepoll = ParamUtil.getParameterInt(request, "PollHideResult", PollBean.POLL_SHOW_RESULT_TO_ANYONE);
        poll_expire = ParamUtil.getParameter(request, "poll_expire", false);
        pollAnswerBeans = (Collection)request.getAttribute("PollAnswerBeans");
        Timestamp endDate = pollBean.getPollEndDate();
        Timestamp startDate = pollBean.getPollStartDate();
        Timestamp now = DateUtil.getCurrentGMTTimestamp();
        if ((endDate.compareTo(startDate) > 0) && ((endDate.compareTo(now) < 0) || (endDate.compareTo(now) == 0))) {
          hasExpired = true;
        }        
        if (permission.canSetPollToAnonymousType()) {
            isanonymouspoll = ParamUtil.getParameterBoolean(request, "isanonymouspoll");
        }
    } else {
        question = pollBean.getPollQuestion();
        multi = (pollBean.getPollMultiple() == PollBean.POLL_MULTIPLE_YES)? true : false;
        changevote = (pollBean.getPollVoteChange() == PollBean.POLL_VOTE_CHANGE) ? true : false;
        ispublic = (pollBean.getPollPublic() == PollBean.POLL_PUBLIC) ? true : false;
        if (permission.canSetPollToAnonymousType()) {
          isanonymouspoll = (pollBean.getPollType() == PollBean.POLL_TYPE_ANONYMOUS) ? true : false;
        }
        hidepoll = pollBean.getPollHideResult();
        Timestamp endDate = pollBean.getPollEndDate();
        Timestamp startDate = pollBean.getPollStartDate();
        Timestamp now = DateUtil.getCurrentGMTTimestamp();
        if ((endDate.compareTo(startDate) > 0) && ((endDate.compareTo(now) < 0) || (endDate.compareTo(now) == 0))) {
          hasExpired = true;
        }
        long endDateLong = endDate.getTime();
        long startDateLong = startDate.getTime();
        if ( (endDateLong - startDateLong) > 0 ) {
          poll_expire = "" + ((endDateLong - startDateLong)/(long)(1000*60*60*24));
        }
        
        pollAnswerBeans = (Collection)request.getAttribute("PollAnswerBeans");
    }
  }
%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title>
    <fmt:message key="mvnforum.common.forum.title_name"/> - <%if (pollAction.equals("PrepareAddPoll")) {%><fmt:message key="mvnforum.common.poll.command.add_poll"/><%} else {%><fmt:message key="mvnforum.common.poll.command.edit_poll"/><%}%>
  </mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
<script src="<%=contextPath%>/mvnplugin/mvnforum/js/vietuni.js" type="text/javascript"></script>
<script type="text/javascript">
//<![CDATA[
function handleUnload() {
  if (document.pollform && document.pollform.submitbutton) {
    document.pollform.submitbutton.disabled=false;
  }
  if (document.pollform && document.pollform.updatebutton) {
    document.pollform.updatebutton.disabled=false;
  }
  if (document.pollanswerform && document.pollanswerform.addpollanswerbutton) {
    document.pollanswerform.addpollanswerbutton.disabled=false;
  }
  if (document.editpollanswerform && document.editpollanswerform.editpollanswerbutton) {
    document.editpollanswerform.editpollanswerbutton.disabled=false;
  }
  if (document.pollanswerform && document.pollanswerform.addpollanswerbutton) {
    document.pollanswerform.addpollanswerbutton.disabled=false;
  }
  if (document.editpollanswerform && document.editpollanswerform.editpollanswerbutton) {
    document.editpollanswerform.editpollanswerbutton.disabled=false;
  }
}
//]]>
</script>
</mvn:head>
<mvn:body onunload="handleUnload()">
<script type="text/javascript"><!--
//<![CDATA[
function SubmitForm() {
  if (ValidatePollForm() == true) {
    <mvn:servlet>
      document.pollform.submitbutton.disabled=true;
    </mvn:servlet>
    document.pollform.typeOfAction.value = "add";
    document.pollform.submit();
  }
}

function PreviewForm() {
  if (ValidatePollForm() == true) {
    document.pollform.preview.value = 'true';
    document.pollform.action = document.getElementById('previewUrl').value;
    <%=urlResolver.generateFormActionForJavascript(request, response, previewAction, "pollform")%>
    <mvn:servlet>
    document.pollform.previewbutton.disabled=true;
    document.pollform.updatebutton.disabled=true;
    document.pollform.updateanddonebutton.disabled=true;
    </mvn:servlet>
    document.pollform.submit();
  }
}

function UpdateForm() {
  if (ValidatePollForm() == true) {
    <mvn:servlet>
      document.pollform.previewbutton.disabled=true;
      document.pollform.updatebutton.disabled=true;
      document.pollform.updateanddonebutton.disabled=true;
    </mvn:servlet>
    document.pollform.typeOfAction.value = "update";
    document.pollform.submit();
  }
}

function UpdateAndDoneForm() {
  if (ValidatePollForm() == true) {
    <mvn:servlet>
      document.pollform.previewbutton.disabled=true;
      document.pollform.updatebutton.disabled=true;
      document.pollform.updateanddonebutton.disabled=true;
    </mvn:servlet>
    document.pollform.typeOfAction.value = "updateanddone";
    document.pollform.action = '<%= urlResolver.encodeURL(request, response, "addpollanddoneprocess", URLResolverService.ACTION_URL)%>';
    <% if (isPortlet) { %>
      document.pollform.portlet_action.value = 'addpollanddoneprocess';
    <%}%>
    document.pollform.submit();
  }
}

function AddPollAnswerForm() {
  if (ValidateAddPollAnswerForm() == true) {
    <mvn:servlet>
      document.pollanswerform.addpollanswerbutton.disabled=true;
    </mvn:servlet>
    document.pollanswerform.submit();
  }
}

function EditPollAnswerForm() {
  if (ValidateEditPollAnswerForm() == true) {
    <mvn:servlet>
      document.editpollanswerform.editpollanswerbutton.disabled=true;
    </mvn:servlet>
    document.editpollanswerform.submit();
  }
}

function ValidatePollForm() {
  if (isBlank(document.pollform.question, "<fmt:message key="mvnforum.common.poll.poll_question"/>")) return false;
  var  val = document.pollform.poll_expire.value;
  if (val != '') {
    for (var i=0;i<val.length;i++) {
      if (!isDigit(val.charAt(i))) {
          alert("<fmt:message key="mvnforum.common.poll.time_to_run"/>" + " <fmt:message key="mvnforum.common.js.prompt.mustbe_unsigned_number"/>");
          document.pollform.poll_expire.focus();
          return false;
      }
    }
  }
  
  return true;
}

var attNum = 0;
var arr = new Array();
function ValidateAddPollAnswerForm() {
  if (isBlank(document.pollanswerform.PollAnswerText, "<fmt:message key="mvnforum.common.pollanswer"/>")) return false;
  for (var i=0;i<arr.length;i++) {
    if (isBlank(document.getElementById('PollAnswerText' + arr[i]) , "<fmt:message key="mvnforum.common.pollanswer"/>")) return false;
  }
  if (ValidateValueOfTexts() == false) {
    return false;
  }
  return true;
}

function ValidateValueOfTexts() {
  var pollAnswerText = document.pollanswerform.PollAnswerText.value;
  for (var i=0; i < arr.length; i++) {
    var pollAnswerTexts = document.getElementById('PollAnswerText' + arr[i]).value;
      if (pollAnswerText == pollAnswerTexts) {
        alert('<fmt:message key="mvnforum.common.pollanswer.same"/>:' + pollAnswerTexts);
        return false;
      }
  }
  for (var i=0; i < (arr.length - 1); i++) {
    var pollAnswerTexts = document.getElementById('PollAnswerText' + arr[i]).value;
    for (var j=(i+1); j < arr.length; j++) {
      var pollAnswerTextsNext = document.getElementById('PollAnswerText' + arr[j]).value;
      if (pollAnswerTexts == pollAnswerTextsNext) {
        alert('<fmt:message key="mvnforum.common.pollanswer.same"/>:' + pollAnswerTexts);
        return false;
      }
    }
  }
  return true;
}

function ValidateEditPollAnswerForm() {
  if (isBlank(document.editpollanswerform.NewPollAnswerText, "<fmt:message key="mvnforum.common.pollanswer"/>")) return false;
  return true;
}

function pollOptions() {
  var expireTime = document.getElementById("poll_expire");
  //fix bug with anonymous poll
  if ( (document.getElementsByName("PollHideResult")[2] != null) && (document.getElementsByName("PollHideResult")[1] != null) ) {
    if (trim(expireTime.value).lenghth > 0 || expireTime.value == 0) {
      document.getElementsByName("PollHideResult")[2].disabled = true;
      if (document.getElementsByName("PollHideResult")[2].checked) {
        document.getElementsByName("PollHideResult")[1].checked = true;
      }
    } else {
      document.getElementsByName("PollHideResult")[2].disabled = false;
    }
  }
}

function confirmDeletePollAnswer(pollAnswerID) {
  if (confirm("<fmt:message key="mvnforum.common.pollanswer.question.question_delete"/>")) {
    document.getElementsByName("deletepollanswerform_"+pollAnswerID)[0].submit();
    return true;
  }
  return false;
}

function callAdd(attNum) {
  document.getElementById("SpanAtt" + (attNum + 1)).innerHTML='';
  arr.pop(attNum);
  return false;
}
function addAtt() {
    st = " <span id=SpanAtt" + (attNum + 1) + "><input type='text' name='PollAnswerText" + (attNum + 1) + "' id ='PollAnswerText" + (attNum + 1) + "' size='50'>&nbsp;<input type='checkbox' class='noborder' name='needYourOpinion" + (attNum + 1) + "' id ='needYourOpinion" + (attNum + 1) + "'><fmt:message key="mvnforum.common.pollanswer.type.need_your_opinion"/>&nbsp;<a href='#' onclick='return callAdd(" + attNum + ");'><fmt:message key="mvnforum.common.action.remove"/></" + "a></" + "span><div id=aDiv" + (attNum + 1) + "></ " + "div>";
    document.getElementById('aDiv' + attNum).innerHTML = st;
    //idoffile = "PollAnswer" + attNum;
    attNum = (attNum + 1);
    arr.push(attNum);
    //document.getElementById(idoffile).focus();
  }
//]]>
--></script>
<%if (isPollPortlet == false) {%>
  <%@ include file="header.jsp"%>
  <br/>
  <%if (request.getAttribute("tree") != null) {%>
  <div class="nav center">
    <%= request.getAttribute("tree") %>
  </div>
  <%} else {%>
  <div class="nav center">
    <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
    <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.common.poll.command.add_poll"/>
  </div>
  <%}%>
<%} else {%>
  <%@ include file="header_poll.jsp"%>
  <br/>
  <%if (request.getAttribute("tree") != null) {%>
  <div class="nav center">
    <%= request.getAttribute("tree") %>
  </div>
  <%} else {%>
  <div class="nav center">
    <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
    <a href="<%=urlResolver.encodeURL(request, response, "", URLResolverService.ACTION_URL)%>"><fmt:message key="mvnforum.user.header.index"/></a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.common.poll.command.add_poll"/>
  </div>
  <%}%>
<%} %>
<br/>
<%if (hasExpired) {%>
  <div class="pagedesc center warning">
    <fmt:message key="mvnforum.common.poll.info.expired"/>
  </div>
  <br/>
<%}%>  
<%
  if (isPreviewing) {
%>
<mvn:cssrows>
<table class="tborder" width="95%" cellspacing="0" cellpadding="5" align="center">
  <tr class="<mvn:cssrow/>">
    <td width="155" valign="top" nowrap="nowrap">
    <%= question%>
    <ol>
<%  String type;
    if (multi) {
      type = " type=\"checkbox\"";
    } else {
      type = " type=\"radio\"";
    }
    for (Iterator ite = pollAnswerBeans.iterator(); ite.hasNext(); ) {
      PollAnswerBean bean = (PollAnswerBean)ite.next(); %>
      <li><input <%=type%> name="onlyForPreview" class="noborder" /><%=bean.getPollAnswerText()%></li>
 <% } %>
    </ol>
    </td>
  </tr>
</table>
</mvn:cssrows>
<%
  }
%>
<br />
<form action="<%=urlResolver.encodeURL(request, response, "addpollprocess", URLResolverService.ACTION_URL)%>" method="post" name="pollform">
<%=urlResolver.generateFormAction(request, response, "addpollprocess")%>
<mvn:securitytoken />
<input type="hidden" name="typeOfAction" value="" />
<input type="hidden" name="typeOfPoll" value="<%=pollType%>" />
<%
if (pollAction.equals("PrepareAddPoll")) {
  if (pollType == PollBean.THREAD) { %>
  <input type="hidden" name="threadid" value="<%=ParamUtil.getParameter(request, "thread")%>" />
<%} else if (pollType == PollBean.ALBUMITEM) { %>
  <input type="hidden" name="itemid" value="<%=ParamUtil.getParameter(request, "itemid")%>" />
<%}
} else {%>
  <input type="hidden" name="pollid" value="<%=pollBean.getPollID()%>" />
<%}%>
<mvn:cssrows>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td colspan="2">
    <% if (pollAction.equals("PrepareAddPoll")) { %>
      <fmt:message key="mvnforum.common.poll.command.add_poll"/>
    <% } else if (pollAction.equals("AddPoll")) { %>
      <fmt:message key="mvnforum.common.poll.command.edit_poll"/>
    <% } %>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="question"><fmt:message key="mvnforum.common.poll.poll_question"/></label></td>
    <td><input type="text" name="PollQuestion" id="question" size="50" value="<%=question%>" onkeyup="initTyper(this);"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.poll.option"/></td>
    <td>
      <% if (pollAction.equals("PrepareAddPoll")) { %>
        <fmt:message key="mvnforum.user.addpollx.run_poll_for"/>&nbsp;<input id="poll_expire" name="poll_expire" size="2" value="<%=poll_expire%>" onchange="pollOptions();" type="text" class="portlet-section-body" /> <fmt:message key="mvnforum.user.addpollx.run_from_now"/>. (<fmt:message key="mvnforum.user.addpollx.leave_blank_case"/>)
      <% } else {%>         
        <%if (hasExpired == false) {%>
          <fmt:message key="mvnforum.user.addpollx.run_poll_for"/>&nbsp;<input id="poll_expire" name="poll_expire" size="2" value="<%=poll_expire%>" onchange="pollOptions();" type="text" class="portlet-section-body" /> <fmt:message key="mvnforum.user.addpollx.run_from"/> <b><%=onlineUser.getGMTTimestampFormat(pollBean.getPollStartDate()) %></b>. (<fmt:message key="mvnforum.user.addpollx.leave_blank_case"/>)
        <%} else {%>
          <fmt:message key="mvnforum.user.addpollx.expire_and_run_poll_for"/>&nbsp;<input id="poll_expire" name="poll_expire" size="2" value="<%=poll_expire%>" onchange="pollOptions();" type="text" class="portlet-section-body" /> <fmt:message key="mvnforum.user.addpollx.run_from_now"/> (<fmt:message key="mvnforum.user.addpollx.leave_blank_case"/>)
        <%}%>      
      <%}%>  
      <br/><br/>
      <input type="checkbox" name="PollMultiple" class="noborder" value="1"<%if (multi) {%> checked="checked"<%}%> /> <fmt:message key="mvnforum.user.addpollx.multi"/><br/>

      <input type="checkbox" name="PollVoteChange" class="noborder" id="changevote" value="1"<%if (changevote) {%> checked="checked"<%}%> /> <fmt:message key="mvnforum.user.addpollx.change_vote"/><br/>

      <input type="checkbox" name="PollPublic" class="noborder" id="ispublic" value="1"<%if (ispublic) {%> checked="checked"<%}%> /> <fmt:message key="mvnforum.user.addpollx.is_public"/><br/>
      
    <%if (permission.canSetPollToAnonymousType()) {%>
      <input type="checkbox" name="isanonymouspoll" class="noborder" id="isanonymouspoll" value="1"<%if (isanonymouspoll || ((request.getAttribute("CannotEditPollType") != null) && ((pollBean.getPollType() == PollBean.POLL_TYPE_ANONYMOUS)))) {%> checked="checked"<%}%><%if (request.getAttribute("CannotEditPollType") != null) {%> disabled="disabled"<%}%> /> <span class="forumdesc"><fmt:message key="mvnforum.user.addpollx.is_anonymous"/></span>
      <%if (request.getAttribute("CannotEditPollType") != null) {%>
      <br />
      &nbsp;&nbsp;&nbsp;(<fmt:message key="mvnforum.user.addpollx.cannot_change_is_anonymous"/>)
      <%}%>
    <%} %>  
      <br/><br/>      
      <input type="radio" name="PollHideResult" value="<%=PollBean.POLL_SHOW_RESULT_TO_ANYONE%>" class="noborder"<%if ((hidepoll != PollBean.POLL_SHOW_RESULT_AFTER_VOTED) && (hidepoll != PollBean.POLL_SHOW_RESULT_AFTER_EXPIRED)) {%> checked="checked"<%}%> /> <fmt:message key="mvnforum.user.addpollx.show_result.anyone"/><br/>
      <input type="radio" name="PollHideResult" value="<%=PollBean.POLL_SHOW_RESULT_AFTER_VOTED%>" class="noborder"<%if (hidepoll == PollBean.POLL_SHOW_RESULT_AFTER_VOTED) {%> checked="checked"<%}%> /> <fmt:message key="mvnforum.user.addpollx.show_result.only_after_voted"/><br/>
      <input type="radio" name="PollHideResult" value="<%=PollBean.POLL_SHOW_RESULT_AFTER_EXPIRED%>" disabled="disabled" class="noborder"<%if (hidepoll == PollBean.POLL_SHOW_RESULT_AFTER_EXPIRED) {%> checked="checked"<%}%> /> <fmt:message key="mvnforum.user.addpollx.show_result.only_after_expired"/>
    </td>
  </tr>
<%if (currentLocale.equals("vi")) {/*vietnamese here*/%>
  <tr class="<mvn:cssrow/>">
    <td valign="top" nowrap="nowrap"><fmt:message key="mvnforum.common.vietnamese_type"/>:</td>
    <td>
      <input type="radio" name="vnselector" id="TELEX" value="TELEX" onclick="setTypingMode(1);" class="noborder" /> <fmt:message key="mvnforum.common.vietnamese_type.telex"/>&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" name="vnselector" id="VNI" value="VNI" onclick="setTypingMode(2);" class="noborder" /> <fmt:message key="mvnforum.common.vietnamese_type.vni"/>&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" name="vnselector" id="VIQR" value="VIQR" onclick="setTypingMode(3);" class="noborder" /> <fmt:message key="mvnforum.common.vietnamese_type.VIQR"/><br/>
      <input type="radio" name="vnselector" id="NOVN" value="NOVN" onclick="setTypingMode(0);" class="noborder" /> <fmt:message key="mvnforum.common.vietnamese_type.not_use"/>
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
      <% if (pollAction.equals("PrepareAddPoll")) { %>
        <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.common.action.add"/>" onclick="javascript:SubmitForm();" class="portlet-form-button" />
      <% } else if (pollAction.equals("AddPoll")) { %>
        <input type="hidden" name="preview" value="" />
        <input type="hidden" name="previewUrl" id="previewUrl" value="<%=previewUrl%>" />
        <input type="button" name="previewbutton" value="<fmt:message key="mvnforum.common.action.preview"/>" onclick="javascript:PreviewForm();" class="portlet-form-button" <% if (pollAnswerBeans.size() == 0) { %> disabled="disabled" <% } %> />
        <input type="button" name="updatebutton" value="<fmt:message key="mvnforum.common.action.save"/>" onclick="javascript:UpdateForm();" class="portlet-form-button" />
        <input type="button" name="updateanddonebutton" value="<fmt:message key="mvnforum.user.addpollx.save_and_done"/>" onclick="javascript:UpdateAndDoneForm();" class="portlet-form-button" <% if (pollAnswerBeans.size() == 0) { %> disabled="disabled" <% } %> />
      <% } %>
    </td>
  </tr>
</table>
</mvn:cssrows>
</form>
<br />

<%if (pollAction.equals("AddPoll")) { %>
  <a name="pollanswer"></a>
  <form action="<%=urlResolver.encodeURL(request, response, "addpollanswerprocess#pollanswer", URLResolverService.ACTION_URL)%>" method="post" name="pollanswerform">
  <%=urlResolver.generateFormAction(request, response, "addpollanswerprocess")%>
  <mvn:securitytoken />
  <input type="hidden" name="pollid" value="<%=pollBean.getPollID()%>" />
  <input type="hidden" name="typeOfPoll" value="<%=pollType%>" />
  <mvn:cssrows>
  <table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
    <tr class="portlet-section-header" id="addPollAnswer">
      <td><fmt:message key="mvnforum.user.addpollx.add_poll_answer" /></td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td>
        <div id="PollAnswer">
          <input type="text" name="PollAnswerText" size="50" value="" onkeyup="initTyper(this);" />
          <input type="checkbox" name="needYourOpinion" class="noborder" /> <fmt:message key="mvnforum.common.pollanswer.type.need_your_opinion"/> &nbsp;
          <div id="aDiv0"></div>
        </div>
        <a href="#addPollAnswer" onclick="addAtt()"><fmt:message key="mvnforum.common.action.pollanswer_more"/></a><br />
        <input type="button" name="addpollanswerbutton" value="<fmt:message key="mvnforum.common.action.add"/>" onclick="javascript:AddPollAnswerForm();" class="portlet-form-button" />
      </td>
    </tr>
  </table>
  </mvn:cssrows>
  </form>
  <br />
  <%-- Generate delete poll answer form --%>
  <%if (pollAnswerBeans != null) {
      for (Iterator ite = pollAnswerBeans.iterator(); ite.hasNext(); ) {
        PollAnswerBean pollAnswerBean = (PollAnswerBean)ite.next(); %>

        <form action="<%=urlResolver.encodeURL(request, response, "deletepollanswerprocess#pollanswer", URLResolverService.ACTION_URL)%>" method="post" name="deletepollanswerform_<%=pollAnswerBean.getPollAnswerID()%>">
        <%=urlResolver.generateFormAction(request, response, "deletepollanswerprocess")%>
        <mvn:securitytoken />
          <input name="pollanswerid" value="<%=pollAnswerBean.getPollAnswerID()%>" type="hidden" />
          <input name="type" value="<%=pollType%>" type="hidden" />
        </form>
  <%  }
    }
  %>    
  
  <!-- view poll Answer -->
  <form action="<%=urlResolver.encodeURL(request, response, "editpollanswerprocess#pollanswer", URLResolverService.ACTION_URL)%>" method="post" name="editpollanswerform">
  <%=urlResolver.generateFormAction(request, response, "editpollanswerprocess")%>
  <mvn:securitytoken />
  <input type="hidden" name="pollid" value="<%=pollBean.getPollID()%>" />
  <input type="hidden" name="typeOfPoll" value="<%=pollType%>" />
  <mvn:cssrows>
  <table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
    <tr class="portlet-section-header">
      <td width="80%"><fmt:message key="mvnforum.common.pollanswer"/></td>
      <td align="center" width="5%" nowrap="nowrap"><fmt:message key="mvnforum.common.pollanswer.type"/></td>
      <td align="center" width="5%" nowrap="nowrap"><fmt:message key="mvnforum.common.order"/></td>
      <td align="center" width="5%" nowrap="nowrap"><fmt:message key="mvnforum.common.action.edit"/></td>
      <td align="center" width="5%" nowrap="nowrap"><fmt:message key="mvnforum.common.action.delete"/></td>
    </tr>
<%if (pollAnswerBeans != null) {
    //currentTime for fix problem with # when update poll answer order
    long currentTime = System.currentTimeMillis();
    for (Iterator ite = pollAnswerBeans.iterator(); ite.hasNext(); ) {
      PollAnswerBean pollAnswerBean = (PollAnswerBean)ite.next(); %>
      <tr class="<mvn:cssrow/>">
        <td>
          <%
            int editPollAnswerID = 0;
            if (request.getAttribute("EditPollAnswerID") != null) {
               editPollAnswerID = ((Integer)request.getAttribute("EditPollAnswerID")).intValue();
            }
            if (pollAnswerBean.getPollAnswerID() == editPollAnswerID) { %>
              <input type="text" name="NewPollAnswerText" size="50" value="<%=pollAnswerBean.getPollAnswerText()%>" onkeyup="initTyper(this);" />&nbsp;
              <input type="checkbox" name="needYourOpinion" class="noborder" value="1" <%if (pollAnswerBean.getPollAnswerType() == PollAnswerBean.POLL_ANSWER_TYPE_NEED_YOUR_OPINION) { %>checked="checked"<%}%> />
              <fmt:message key="mvnforum.common.pollanswer.type.need_your_opinion"/>
          <%} else {%>
              <%=pollAnswerBean.getPollAnswerText()%>
          <%}%>
        </td>
        <td align="center" nowrap="nowrap"><%=LocaleMessageUtil.getPollAnswerTypeDescFromInt(onlineUser.getLocale(), pollAnswerBean.getPollAnswerType())%></td>
        <td align="center">
          <table width="100%" class="noborder">
          <tbody>
            <tr>
              <td align="center" width="30%">
              <% if (pollAnswerBean.getPollAnswerOrder() > 0) {%>
                <a href="<%=urlResolver.encodeURL(request, response, "updatepollanswerorder?pollanswerid=" + pollAnswerBean.getPollAnswerID() + "&amp;type=" + pollType + "&amp;action=up&amp;t=" + currentTime + "#pollanswer", URLResolverService.ACTION_URL)%>">
                  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/up.gif" border="0" alt="" />
                </a>
              <% } %>
              </td>
              <td align="center" width="40%">
                <b><%=pollAnswerBean.getPollAnswerOrder()%></b>
              </td>
              <td align="center" width="30%">
                <a href="<%=urlResolver.encodeURL(request, response, "updatepollanswerorder?pollanswerid=" + pollAnswerBean.getPollAnswerID() + "&amp;type=" + pollType + "&amp;action=down&amp;t=" + currentTime + "#pollanswer", URLResolverService.ACTION_URL)%>">
                  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/down.gif" border="0" alt="" />
                </a>
              </td>
            </tr>
          </tbody>
          </table>
        </td>
        <td align="center">
        <% if (pollAnswerBean.getPollAnswerID() == editPollAnswerID) { %>
          <input type="hidden" name="pollanswerid" value="<%=pollAnswerBean.getPollAnswerID()%>" />
          <input type="button" name="editpollanswerbutton" value="<fmt:message key="mvnforum.common.action.save"/>" onclick="javascript:EditPollAnswerForm();" class="portlet-form-button" />
        <% } else { %>
          <a class="command" href="<%=urlResolver.encodeURL(request, response, "editpollanswer?pollanswerid=" + pollAnswerBean.getPollAnswerID() + "&amp;type=" + pollType  + "#pollanswer", URLResolverService.RENDER_URL)%>"><fmt:message key="mvnforum.common.action.edit"/></a>
        <% } %>
        </td>
        <td align="center">
          <a class="command" onclick="confirmDeletePollAnswer(<%=pollAnswerBean.getPollAnswerID()%>)" href="#"><fmt:message key="mvnforum.common.action.delete"/></a>
        </td>
      </tr>
<%
    }// for
    if (pollAnswerBeans.size() == 0) { %>
      <tr class="<mvn:cssrow/>"><td colspan="5" align="center"><fmt:message key="mvnforum.user.addpollx.no_poll_answer"/></td></tr>
<%  }//if
  }//if
%>
  </table>
  </mvn:cssrows>
  </form>
<% } %>

<%if (poll_expire.equals("") == false) {%>
<script type="text/javascript">
//<![CDATA[
  if (document.getElementsByName("PollHideResult")[2] != null) {
    document.getElementsByName("PollHideResult")[2].disabled = false;
  }
//]]>
</script>
<%}%>

<br/>
<%if (isPollPortlet == false) {%>
  <%@ include file="footer.jsp"%>
<%} %>

</mvn:body>
</mvn:html>
</fmt:bundle>