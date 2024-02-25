<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/votepollx.jsp,v 1.46 2009/03/11 09:11:54 trungth Exp $
  - $Author: trungth $
  - $Revision: 1.46 $
  - $Date: 2009/03/11 09:11:54 $
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
<%@ page import="com.mvnforum.user.UserModuleConfig"%>

<%@ include file="inc_common.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<%
  PollBean pollBean = (PollBean) request.getAttribute("PollBean");
  Collection pollAnswerBeans = null;

  if (pollBean.getPollStatus() != PollBean.POLL_STATUS_EDITING) {
    pollAnswerBeans = (Collection) request.getAttribute("PollAnswerBeans");
  }

  boolean isExpired = (request.getAttribute("IsExpired") != null) ? true : false;
  boolean cannotVoteNow = (request.getAttribute("CannotVoteNow") != null) ? true : false;
%>
<script type="text/javascript">
//<![CDATA[
function SubmitForm() {
  document.getElementById("submitbutton").disabled = true;
  var params="";

  var inputArray = document.getElementsByTagName("input");

  if (inputArray != null) {
    for (var i=0; i < inputArray.length; i++) {
      if ((inputArray[i] != null) && (inputArray[i].getAttribute("name") != null )) {
        if (inputArray[i].getAttribute("name").indexOf("option_") != -1) {
          if (inputArray[i].checked) {
            if (params.indexOf("option_") != -1) {
              params = params + "&";
            }
            params = params + inputArray[i].getAttribute("name") + "=" + inputArray[i].getAttribute("value");

            optionid = inputArray[i].getAttribute("value");
            otheropinion = "";
            if (document.getElementById("your_opinion_"+optionid)) {
              otheropinion = document.getElementById("your_opinion_"+optionid).value;
              if (otheropinion == "") {
                alert("<fmt:message key="mvnforum.user.votepollx.other_opinion.must_enter_your_opinion"/>");
                document.getElementById("submitbutton").disabled = false;
                return false;
              } else {
                params= params + "&your_opinion_"+optionid+"="+otheropinion;
              }
            }
          }
        } else if (inputArray[i].getAttribute("name").indexOf("your_opinion_") != -1) {
          if (inputArray[i].checked) {
            if (params.indexOf("option_") != -1 || params.indexOf("your_opinion_") != -1) {
              params = params + "&";
            }
            params= params + inputArray[i].getAttribute("name") + "=" + inputArray[i].value;
          }
        }
      }
    }
  }
  if (params.indexOf("option_") == -1) {
    alert("<fmt:message key="mvnforum.user.votepollx.other_opinion.must_choose_your_option"/>");
    document.getElementById("submitbutton").disabled = false;
    return false;
  } else {
    params = params + "&pollid="+<%=pollBean.getPollID()%>;
    showDialog('<%=contextPath%><%=UserModuleConfig.getUrlPattern()%>/votepoll_process?' + params, 450, 170);

    //reset
    document.getElementById("submitbutton").disabled = false;
    for (var i=0; i < inputArray.length; i++) {
      if ((inputArray[i] != null) && (inputArray[i].getAttribute("name") != null )) {
        if (inputArray[i].getAttribute("name").indexOf("option_") != -1) {
          if (inputArray[i].checked) {
            inputArray[i].checked = false;
          }
        }
      }
    }
  }
}

function ViewResultForm() {
  showDialog('<%=contextPath%><%=UserModuleConfig.getUrlPattern()%>/viewpoll_result?pollid=<%=pollBean.getPollID()%>', 450, 170);
}
//]]>
</script>

<% if (pollBean.getPollStatus() == PollBean.POLL_STATUS_EDITING) { %>
  <table width="100%" cellspacing="0" cellpadding="3" align="center">
    <tr>
      <td class="textvote"><fmt:message key="mvnforum.common.poll.info.editing_status"/></td>
    </tr>
    <tr>
      <td><fmt:message key="mvnforum.user.votepollx.warning"/></td>
    </tr>  
  </table>  
<% } else { %>
  <form action="<%=urlResolver.encodeURL(request, response, "votepoll_process", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
  <%=urlResolver.generateFormAction(request, response, "votepoll_process")%>
  <mvn:securitytoken />
  <input type="hidden" name="pollid" value="<%=pollBean.getPollID()%>" />
  <table width="100%" cellspacing="0" cellpadding="3" align="center" class="noborder">
    <tbody>
    <tr>
      <td>
        <table cellpadding="0" cellspacing="3" width="100%">
        <tbody>
          <tr>
            <td colspan="2" class="textvote"><%=pollBean.getPollQuestion()%></td>
          </tr>
        <%
          String type;
          if (pollBean.getPollMultiple() == PollBean.POLL_MULTIPLE_YES) {
            type = " type=\"checkbox\" ";
          } else {
            type = " type=\"radio\" ";
          }
          int i = 0;
          for (Iterator pollIter = pollAnswerBeans.iterator(); pollIter.hasNext(); ) {
            PollAnswerBean pollAnswerBean = (PollAnswerBean) pollIter.next();
        %>
          <tr>
            <td width="10%"><input <%=type%> class="noborder" name="option_<% if (pollBean.getPollMultiple() == PollBean.POLL_MULTIPLE_YES) {%><%=++i%><%}%>" value="<%=pollAnswerBean.getPollAnswerID()%>" <% if (isExpired || cannotVoteNow) { %> disabled="disabled" <%}%> /></td>
            <td class="textpoll">
              <%= pollAnswerBean.getPollAnswerText() %>
              <% if (pollAnswerBean.getPollAnswerType() == PollAnswerBean.POLL_ANSWER_TYPE_NEED_YOUR_OPINION) { %>
                <br/>
                <input type="text" id="your_opinion_<%=pollAnswerBean.getPollAnswerID()%>" name="your_opinion_<%=pollAnswerBean.getPollAnswerID()%>" size="10"/>
              <% } %>
            </td>
          </tr>
        <%
          }
        %>
        </tbody>
        </table>
      </td>
    </tr>
    <tr>
      <td align="center">
        <input type="button" id="submitbutton" name="submitbutton" value="<fmt:message key="mvnforum.common.poll.button.vote"/>" onclick="javascript:SubmitForm()" class="buttonvote" <% if (isExpired || cannotVoteNow) { %> disabled="disabled" <%}%> />
        <input type="button" id="viewresultbutton" name="viewresultbutton" value="<fmt:message key="mvnforum.common.poll.button.view"/>" onclick="javascript:ViewResultForm()" class="buttonvote" />
      </td>
    </tr>
    </tbody>
  </table>
</form>
<% } %>
</fmt:bundle>