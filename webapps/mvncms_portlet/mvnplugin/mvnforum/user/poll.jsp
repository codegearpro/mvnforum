<%--
  - $Header: /home/cvsroot/portlet-mvnforum/srcweb/mvnplugin/mvnforum/user/poll.jsp,v 1.16 2010/08/20 05:16:09 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.16 $
  - $Date: 2010/08/20 05:16:09 $
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
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="java.util.*"%>
<%@ page import="net.myvietnam.mvncore.security.SecurityUtil" %>
<%@ page import="net.myvietnam.mvncore.service.URLResolverService" %>
<%@ page import="com.mvnforum.db.*"%>
<%@ page import="com.mvnforum.user.UserModuleConfig"%>
<%@ page import="com.mvnforum.db.PollAnswerBean"%>

<%@ include file="inc_common.jsp"%>
<link rel="stylesheet" type="text/css" media="all" href="<%=contextPath%>/mvnplugin/mvnforum/css/style.css" />
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/js/myvietnam.js"></script>
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
    <%--params = params + "&pollid="+<%=pollBean.getPollID()%>;
    showDialog('<%=urlResolver.encodeURL(request, response, "votepoll_process?mvncoreSecurityToken=" + SecurityUtil.getSessionToken(request), URLResolverService.ACTION_URL)%>', 450, 170);
    --%>
    document.submitform.submit();
    <%--
    window.location.href='<%=urlResolver.encodeURL(request, response, "votepoll_process?pollid=" + pollBean.getPollID())%>';
    --%>
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
  window.location.href='<%=urlResolver.encodeURL(request, response, "viewpoll_result?pollid=" + pollBean.getPollID())%>';
}
//]]>
</script>

<% if (pollBean.getPollStatus() == PollBean.POLL_STATUS_EDITING) { %>
  <table width="240" cellspacing="0" cellpadding="3" align="center" class="left_box">
    <tr>
      <td><fmt:message key="mvnforum.common.poll.info.editing_status"/></td>
    </tr>
    <tr>
      <td><fmt:message key="mvnforum.user.votepollx.warning"/></td>
    </tr>  
    <%if(permission.isAuthenticated()) {%>
    <tr>
      <td>
          <a href="<%=urlResolver.encodeURL(request, response, "listpolls", URLResolverService.ACTION_URL)%>" style="color: blue;"><fmt:message key="mvnforum.common.poll.command.manage"/></a>
      </td>
    </tr> 
    <%} %> 
  </table>  
<% } else { %>
  <form action="<%=urlResolver.encodeURL(request, response, "votepoll_process", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
  <%=urlResolver.generateFormAction(request, response, "votepoll_process")%>
  
  <input type="hidden" name="pollid" value="<%=pollBean.getPollID()%>" />
  <table width="100%" cellspacing="0" cellpadding="3" align="center" class="left_box">
    <tr>
      <td>
        <div class="title_poll"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/poll_icon.gif" alt=""  class="icon_box" />Ý kiến bạn đọc</div>
        <div class="margin_box">    
          <div class="poll_title"><%=pollBean.getPollQuestion()%></div>
          <ul class="poll">
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
            <li>
              <input <%=type%> class="radio_poll noborder" name="option_<% if (pollBean.getPollMultiple() == PollBean.POLL_MULTIPLE_YES) {%><%=++i%><%}%>" value="<%=pollAnswerBean.getPollAnswerID()%>" <% if (isExpired || cannotVoteNow) { %> disabled="disabled" <%}%>/>
           
                <%= pollAnswerBean.getPollAnswerText() %>
                <% if (pollAnswerBean.getPollAnswerType() == PollAnswerBean.POLL_ANSWER_TYPE_NEED_YOUR_OPINION) { %>
                  <br/>
                  <input type="text" id="your_opinion_<%=pollAnswerBean.getPollAnswerID()%>" name="your_opinion_<%=pollAnswerBean.getPollAnswerID()%>" size="20"/>
                <% } %>
          <%
            }
          %>
            </li>
          </ul>
          <div style="text-align:center">
            <input type="button" id="submitbutton" name="submitbutton" class="btn" value="B&igrave;nh ch&#7885;n" onclick="javascript:SubmitForm()" <% if (isExpired || cannotVoteNow) { %> disabled="disabled" <%}%> />
            <input type="button" id="viewresultbutton" name="viewresultbutton" class="btn" value="Xem k&#7871;t qu&#7843;" onclick="javascript:ViewResultForm()" />
          </div>
          <br />
          <%if(permission.isAuthenticated()) {%>
            <div>
              <a href="<%=urlResolver.encodeURL(request, response, "listpolls", URLResolverService.ACTION_URL)%>" style="color: blue;"><fmt:message key="mvnforum.common.poll.command.manage"/></a>
            </div>
          <%} %>
        </div>
      </td>
    </tr>
  </table>
</form>
<% } %>
</fmt:bundle>
