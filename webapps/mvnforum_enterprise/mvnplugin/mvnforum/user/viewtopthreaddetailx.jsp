<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/viewtopthreaddetailx.jsp,v 1.2 2009/05/20 06:47:07 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.2 $
  - $Date: 2009/05/20 06:47:07 $
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
<%@ page import="java.util.*" %>
<%@ page import="com.mvnforum.MyUtil" %>
<%@ page import="com.mvnforum.db.*" %>
<%@ page import="net.myvietnam.mvncore.util.ParamUtil" %>
<%@ page import="com.mvnforum.enterprise.db.*" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:body>
<br />
<script type="text/javascript">
//<![CDATA[
function onLoadTab() {
    document.getElementById('viewtopthreads').className='on';
    document.getElementById('viewtopposts').className='off';
    document.getElementById('viewtopusers').className='off';
    document.getElementById('viewmemberresult').className='off';
}
//]]>
</script>
<%
ThreadBean threadBean = (ThreadBean) request.getAttribute("ThreadBean");
VotePeriodBean votePeriodBean = (VotePeriodBean) request.getAttribute("VotePeriodBean");
String sort  = ParamUtil.getParameterFilter(request, "sort");
String order = ParamUtil.getParameterFilter(request, "order");

if (sort.length() == 0) sort = "VoteeMemberName";
if (order.length() == 0) order = "DESC";
%>
<table width="95%" cellspacing="0" cellpadding="3" align="center" border="0">
  <tr class="portlet-section-body">
    <td>
      <div>
        <div><fmt:message key="mvnforum.common.vote_period.name"/>: <span class="messageTopic"><%=votePeriodBean.getVotePeriodName()%></span></div>
        <div><fmt:message key="mvnforum.common.thread"/>: <span class="messageTopic"><%=MyUtil.filter(threadBean.getThreadTopic(), false/*html*/, true/*emotion*/, false/*mvnCode*/, false/*newLine*/, false/*URL*/)%></span></div>
      </div>
      
      <div>
        <form name="form" action="<%=urlResolver.encodeURL(request, response, "viewtopthreaddetail", URLResolverService.ACTION_URL)%>">
        <%=urlResolver.generateFormAction(request, response, "viewtopthreaddetail")%>
          <input type="hidden" name="periodid" value="<%=votePeriodBean.getVotePeriodID()%>" />
          <input type="hidden" name="threadid" value="<%=threadBean.getThreadID()%>" />
          <label for="sort"><fmt:message key="mvnforum.common.sort_by"/></label>
          <select id="sort" name="sort">
          <option value="VoteeMemberName" <%if (sort.equals("VoteeMemberName")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.vote_period.votee"/></option>
          <option value="VoteThreadValue" <%if (sort.equals("VoteThreadValue")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.vote_period.vote_point"/></option>
          <option value="VoteThreadForumLevel" <%if (sort.equals("VoteThreadForumLevel")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.vote_period.forum_level"/></option>
          <option value="VoteThreadGroupLevel" <%if (sort.equals("VoteThreadGroupLevel")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.vote_period.group_level"/></option>
          <option value="VoteThreadModifiedDate" <%if (sort.equals("VoteThreadModifiedDate")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.vote_period.vote_date"/></option>
          </select>
          <label for="order"><fmt:message key="mvnforum.common.order"/></label>
          <select id="order" name="order">
          <option value="ASC" <%if (order.equals("ASC")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.ascending"/></option>
          <option value="DESC" <%if (order.equals("DESC")) {%>selected="selected"<%}%>><fmt:message key="mvnforum.common.descending"/></option>
          </select>
    
          <input type="button" name="go" value="<fmt:message key="mvnforum.common.go"/>" onclick="viewDetail('<%=urlResolver.encodeURL(request, response, "viewtopthreaddetail?periodid=" + votePeriodBean.getVotePeriodID() + "&threadid=" + threadBean.getThreadID())%>')" class="liteoption"/>
        </form>
      </div>
    </td>
  </tr>
</table>
<%
Collection voteThreadDetail = (Collection) request.getAttribute("VoteThreadDetail");
%>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td align="center"><fmt:message key="mvnforum.common.vote_period.votee" /></td>
    <td align="center"><fmt:message key="mvnforum.common.vote_period.vote_point" /></td>
    <td align="center"><fmt:message key="mvnforum.common.vote_period.forum_level" /></td>
    <td align="center"><fmt:message key="mvnforum.common.vote_period.group_level" /></td>
    <%if (permission.canAdminSystem()) {%>
    <td align="center"><fmt:message key="mvnforum.common.vote_period.vote_ip" /></td>
    <%}%>
    <td align="center"><fmt:message key="mvnforum.common.vote_period.vote_date" /></td>
  </tr>
  <%
  for (Iterator iter = voteThreadDetail.iterator(); iter.hasNext();) {
      VoteThreadBean voteThreadBean = (VoteThreadBean) iter.next();
  %>
  <tr class="portlet-section-body">
    <td><a href="<%=urlResolver.encodeURL(request, response, "viewmember?member=" + voteThreadBean.getVoteeMemberName())%>" class="memberName"><%=voteThreadBean.getVoteeMemberName()%></a></td>
    <td align="center"><%=voteThreadBean.getVoteThreadValue()%></td>
    <td align="center"><%=voteThreadBean.getVoteThreadForumLevel()%></td>
    <td align="center"><%=voteThreadBean.getVoteThreadGroupLevel()%></td>
    <%if (permission.canAdminSystem()) {%>
    <td align="center"><%=voteThreadBean.getVoteThreadModifiedIP()%></td>
    <%}%>
    <td align="center"><%=onlineUser.getGMTTimestampFormat(voteThreadBean.getVoteThreadModifiedDate())%></td>
  </tr>
  <%}%>
</table>
</mvn:body>
</mvn:html>
</fmt:bundle>