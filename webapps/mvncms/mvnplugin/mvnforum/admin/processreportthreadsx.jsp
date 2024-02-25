<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/processreportthreadsx.jsp,v 1.42 2009/07/16 03:28:23 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.42 $
  - $Date: 2009/07/16 03:28:23 $
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
<%@ page import="java.text.DateFormatSymbols"%>
<%@ page import="net.myvietnam.mvncore.util.ParamUtil"%>
<%@ page import="com.mvnforum.LocaleMessageUtil"%>
<%@ page import="com.mvnforum.db.ThreadBean"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.admin.processreportthreadsx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css" />
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<br/>
<script type="text/javascript">
//<![CDATA[
function SubmitFormGo() {
  <mvn:servlet>
    document.submitform.go.disabled=true;
  </mvn:servlet>  
  document.submitform.submit();
}
//]]>
</script>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isServlet) {%>
  <a href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "misctasks")%>"><fmt:message key="mvnforum.admin.misctasks.title"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "reportstatistics")%>"><fmt:message key="mvnforum.admin.reportstatisticsx.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.admin.processreportthreadsx.title"/>
</div>
<br/>

<div class="pagedesc">
  <fmt:message key="mvnforum.admin.processreportthreadsx.info"/><br />
  <fmt:message key="mvnforum.admin.reportstatisticsx.info_export"/>
</div>
<br/>

<%
DateFormatSymbols dfs;
String[] monthNames;

String fromDay = ((Integer) request.getAttribute("fromDay")).toString();
String fromMonth = ((Integer) request.getAttribute("fromMonth")).toString();
String fromYear = ((Integer) request.getAttribute("fromYear")).toString();
String toDay = ((Integer) request.getAttribute("toDay")).toString();
String toMonth = ((Integer) request.getAttribute("toMonth")).toString();
String toYear = ((Integer) request.getAttribute("toYear")).toString();

String sort  = ParamUtil.getParameterFilter(request, "sort");
String order = ParamUtil.getParameterFilter(request, "order");
if (sort.length()  == 0) sort  = "ThreadViewCount";
if (order.length() == 0) order = "DESC";
%>

<form action="<%=urlResolver.encodeURL(request, response, "processreportthreads", URLResolverService.ACTION_URL)%>" name="submitform" <mvn:method/>>
<%=urlResolver.generateFormAction(request, response, "processreportthreads")%>
<mvn:cssrows>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td><fmt:message key="mvnforum.admin.processreportthreadsx.title"/>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.processreportthreadsx.from_date"/>
<select name="fromDay"><option value="">--</option>
    <option value="1" <%if (fromDay.equals("1")) {%> selected="selected"<%}%>>1</option>
    <option value="2" <%if (fromDay.equals("2")) {%> selected="selected"<%}%>>2</option>
    <option value="3" <%if (fromDay.equals("3")) {%> selected="selected"<%}%>>3</option>
    <option value="4" <%if (fromDay.equals("4")) {%> selected="selected"<%}%>>4</option>
    <option value="5" <%if (fromDay.equals("5")) {%> selected="selected"<%}%>>5</option>
    <option value="6" <%if (fromDay.equals("6")) {%> selected="selected"<%}%>>6</option>
    <option value="7" <%if (fromDay.equals("7")) {%> selected="selected"<%}%>>7</option>
    <option value="8" <%if (fromDay.equals("8")) {%> selected="selected"<%}%>>8</option>
    <option value="9" <%if (fromDay.equals("9")) {%> selected="selected"<%}%>>9</option>
    <option value="10" <%if (fromDay.equals("10")) {%> selected="selected"<%}%>>10</option>
    <option value="11" <%if (fromDay.equals("11")) {%> selected="selected"<%}%>>11</option>
    <option value="12" <%if (fromDay.equals("12")) {%> selected="selected"<%}%>>12</option>
    <option value="13" <%if (fromDay.equals("13")) {%> selected="selected"<%}%>>13</option>
    <option value="14" <%if (fromDay.equals("14")) {%> selected="selected"<%}%>>14</option>
    <option value="15" <%if (fromDay.equals("15")) {%> selected="selected"<%}%>>15</option>
    <option value="16" <%if (fromDay.equals("16")) {%> selected="selected"<%}%>>16</option>
    <option value="17" <%if (fromDay.equals("17")) {%> selected="selected"<%}%>>17</option>
    <option value="18" <%if (fromDay.equals("18")) {%> selected="selected"<%}%>>18</option>
    <option value="19" <%if (fromDay.equals("19")) {%> selected="selected"<%}%>>19</option>
    <option value="20" <%if (fromDay.equals("20")) {%> selected="selected"<%}%>>20</option>
    <option value="21" <%if (fromDay.equals("21")) {%> selected="selected"<%}%>>21</option>
    <option value="22" <%if (fromDay.equals("22")) {%> selected="selected"<%}%>>22</option>
    <option value="23" <%if (fromDay.equals("23")) {%> selected="selected"<%}%>>23</option>
    <option value="24" <%if (fromDay.equals("24")) {%> selected="selected"<%}%>>24</option>
    <option value="25" <%if (fromDay.equals("25")) {%> selected="selected"<%}%>>25</option>
    <option value="26" <%if (fromDay.equals("26")) {%> selected="selected"<%}%>>26</option>
    <option value="27" <%if (fromDay.equals("27")) {%> selected="selected"<%}%>>27</option>
    <option value="28" <%if (fromDay.equals("28")) {%> selected="selected"<%}%>>28</option>
    <option value="29" <%if (fromDay.equals("29")) {%> selected="selected"<%}%>>29</option>
    <option value="30" <%if (fromDay.equals("30")) {%> selected="selected"<%}%>>30</option>
    <option value="31" <%if (fromDay.equals("31")) {%> selected="selected"<%}%>>31</option>
</select>
<select name="fromMonth"><option value="">--</option>
<%
    dfs = new DateFormatSymbols(onlineUser.getLocale()); // get month names in current web User's locale settings...
    monthNames = dfs.getMonths();

    for (int m=0; m <= monthNames.length-1; m++) { %>
        <option value="<%=m+1%>" <%if (fromMonth.equals(Integer.toString(m+1))) {%>selected="selected"<%}%>><%=monthNames[m]%></option>
<%  }//for %>
</select>
<select name="fromYear">
    <option value="">--</option>
    <option value="2010" <%if (fromYear.equals("2010")) {%> selected="selected"<%}%>>2010</option>
    <option value="2009" <%if (fromYear.equals("2009")) {%> selected="selected"<%}%>>2009</option>
    <option value="2008" <%if (fromYear.equals("2008")) {%> selected="selected"<%}%>>2008</option>
    <option value="2007" <%if (fromYear.equals("2007")) {%> selected="selected"<%}%>>2007</option>
    <option value="2006" <%if (fromYear.equals("2006")) {%> selected="selected"<%}%>>2006</option>
    <option value="2005" <%if (fromYear.equals("2005")) {%> selected="selected"<%}%>>2005</option>
</select>
     &nbsp;&nbsp;&nbsp;<br />
    <fmt:message key="mvnforum.admin.processreportthreadsx.to_date"/>
<select name="toDay"><option value="">--</option>
<option value="1" <%if (toDay.equals("1")) {%> selected="selected"<%}%>>1</option>
    <option value="2" <%if (toDay.equals("2")) {%> selected="selected"<%}%>>2</option>
    <option value="3" <%if (toDay.equals("3")) {%> selected="selected"<%}%>>3</option>
    <option value="4" <%if (toDay.equals("4")) {%> selected="selected"<%}%>>4</option>
    <option value="5" <%if (toDay.equals("5")) {%> selected="selected"<%}%>>5</option>
    <option value="6" <%if (toDay.equals("6")) {%> selected="selected"<%}%>>6</option>
    <option value="7" <%if (toDay.equals("7")) {%> selected="selected"<%}%>>7</option>
    <option value="8" <%if (toDay.equals("8")) {%> selected="selected"<%}%>>8</option>
    <option value="9" <%if (toDay.equals("9")) {%> selected="selected"<%}%>>9</option>
    <option value="10" <%if (toDay.equals("10")) {%> selected="selected"<%}%>>10</option>
    <option value="11" <%if (toDay.equals("11")) {%> selected="selected"<%}%>>11</option>
    <option value="12" <%if (toDay.equals("12")) {%> selected="selected"<%}%>>12</option>
    <option value="13" <%if (toDay.equals("13")) {%> selected="selected"<%}%>>13</option>
    <option value="14" <%if (toDay.equals("14")) {%> selected="selected"<%}%>>14</option>
    <option value="15" <%if (toDay.equals("15")) {%> selected="selected"<%}%>>15</option>
    <option value="16" <%if (toDay.equals("16")) {%> selected="selected"<%}%>>16</option>
    <option value="17" <%if (toDay.equals("17")) {%> selected="selected"<%}%>>17</option>
    <option value="18" <%if (toDay.equals("18")) {%> selected="selected"<%}%>>18</option>
    <option value="19" <%if (toDay.equals("19")) {%> selected="selected"<%}%>>19</option>
    <option value="20" <%if (toDay.equals("20")) {%> selected="selected"<%}%>>20</option>
    <option value="21" <%if (toDay.equals("21")) {%> selected="selected"<%}%>>21</option>
    <option value="22" <%if (toDay.equals("22")) {%> selected="selected"<%}%>>22</option>
    <option value="23" <%if (toDay.equals("23")) {%> selected="selected"<%}%>>23</option>
    <option value="24" <%if (toDay.equals("24")) {%> selected="selected"<%}%>>24</option>
    <option value="25" <%if (toDay.equals("25")) {%> selected="selected"<%}%>>25</option>
    <option value="26" <%if (toDay.equals("26")) {%> selected="selected"<%}%>>26</option>
    <option value="27" <%if (toDay.equals("27")) {%> selected="selected"<%}%>>27</option>
    <option value="28" <%if (toDay.equals("28")) {%> selected="selected"<%}%>>28</option>
    <option value="29" <%if (toDay.equals("29")) {%> selected="selected"<%}%>>29</option>
    <option value="30" <%if (toDay.equals("30")) {%> selected="selected"<%}%>>30</option>
    <option value="31" <%if (toDay.equals("31")) {%> selected="selected"<%}%>>31</option>
</select>
<select name="toMonth"><option value="">--</option>
<%
    dfs = new DateFormatSymbols(onlineUser.getLocale()); // get month names in current web User's locale settings...
    monthNames = dfs.getMonths();

    for (int m=0; m <= monthNames.length-1; m++) { %>
        <option value="<%=m+1%>" <%if (toMonth.equals(Integer.toString(m+1))) {%>selected="selected"<%}%>><%=monthNames[m]%></option>
<%  }//for %>
</select>
<select name="toYear">
    <option value="">--</option>
    <option value="2010" <%if (toYear.equals("2010")) {%> selected="selected"<%}%>>2010</option>
    <option value="2009" <%if (toYear.equals("2009")) {%> selected="selected"<%}%>>2009</option>
    <option value="2008" <%if (toYear.equals("2008")) {%> selected="selected"<%}%>>2008</option>
    <option value="2007" <%if (toYear.equals("2007")) {%> selected="selected"<%}%>>2007</option>
    <option value="2006" <%if (toYear.equals("2006")) {%> selected="selected"<%}%>>2006</option>
    <option value="2005" <%if (toYear.equals("2005")) {%> selected="selected"<%}%>>2005</option>
</select>
    &nbsp;&nbsp;&nbsp;<br />
      <label for="sort"><fmt:message key="mvnforum.common.sort_by"/></label>
      <select id="sort" name="sort">
      <option value="ThreadTopic" <%if (sort.equals("ThreadTopic")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.thread.topic"/></option>
      <option value="MemberName" <%if (sort.equals("MemberName")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.thread.author"/></option>
      <option value="ThreadCreationDate" <%if (sort.equals("ThreadCreationDate")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.thread.creation_date"/></option>
      <option value="LastPostMemberName" <%if (sort.equals("LastPostMemberName")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.thread.last_post_member_name"/></option>
      <option value="ThreadLastPostDate" <%if (sort.equals("ThreadLastPostDate")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.thread.last_post_date"/></option>
      <option value="ThreadType" <%if (sort.equals("ThreadType")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.thread.type"/></option>
      <option value="ThreadPriority" <%if (sort.equals("ThreadPriority")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.thread.priority"/></option>
      <option value="ThreadStatus" <%if (sort.equals("ThreadStatus")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.thread.status"/></option>
      <option value="ThreadViewCount" <%if (sort.equals("ThreadViewCount")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.thread.view_count"/></option>
      <option value="ThreadReplyCount" <%if (sort.equals("ThreadReplyCount")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.thread.reply_count"/></option>
      <option value="ThreadAttachCount" <%if (sort.equals("ThreadAttachCount")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.thread.attachment_count"/></option>
    </select>
    &nbsp;&nbsp;&nbsp;
    <label for="order"><fmt:message key="mvnforum.common.order"/></label>
      <select id="order" name="order">
      <option value="ASC" <%if (order.equals("ASC")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.ascending"/></option>
      <option value="DESC" <%if (order.equals("DESC")) {%> selected="selected"<%}%>><fmt:message key="mvnforum.common.descending"/></option>
    </select>
    <input type="submit" name="go" value="<fmt:message key="mvnforum.common.go"/>" onclick="SubmitFormGo()" class="liteoption" />
    </td>
  </tr>
</table>
</mvn:cssrows>
</form>
<br/>

<form name="formexport" action="<%=urlResolver.encodeURL(request, response, "processexportfile", URLResolverService.ACTION_URL)%>" <mvn:method/>>
<%=urlResolver.generateFormAction(request, response, "processexportfile") %>
<mvn:securitytoken />
<input type="hidden" name="type" value="threads" />
<input type="hidden" name="fromDay" value="<%=fromDay%>" />
<input type="hidden" name="fromMonth" value="<%=fromMonth%>" />
<input type="hidden" name="fromYear" value="<%=fromYear%>" />
<input type="hidden" name="toDay" value="<%=toDay%>" />
<input type="hidden" name="toMonth" value="<%=toMonth%>" />
<input type="hidden" name="toYear" value="<%=toYear%>" />
<input type="hidden" name="sort" value="<%=sort%>" />
<input type="hidden" name="order" value="<%=order%>" />

<table width="95%" align="center">
   <tr class="nav">
     <td align="right">
       <input type="submit" value="<fmt:message key="mvnforum.common.action.export_file"/>" class="liteoption" />
     </td>
   </tr>
</table>
</form>

<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td align="center"><fmt:message key="mvnforum.common.thread.topic"/></td>
    <td align="center"><fmt:message key="mvnforum.common.thread.author"/></td>
    <td align="center"><fmt:message key="mvnforum.common.thread.creation_date"/></td>
    <td align="center"><fmt:message key="mvnforum.common.thread.last_post_member_name"/></td>
    <td align="center"><fmt:message key="mvnforum.common.thread.last_post_date"/></td>
    <td align="center"><fmt:message key="mvnforum.common.thread.type"/></td>
    <td align="center"><fmt:message key="mvnforum.common.thread.priority"/></td>
    <td align="center"><fmt:message key="mvnforum.common.thread.status"/></td>
    <td align="center"><fmt:message key="mvnforum.common.thread.view_count"/></td>
    <td align="center"><fmt:message key="mvnforum.common.thread.reply_count"/></td>
    <td align="center"><fmt:message key="mvnforum.common.thread.attachment_count"/></td>
  </tr>
<mvn:cssrows>
<%
Collection threadBeans = (Collection)request.getAttribute("ThreadBeans");
for (Iterator iter = threadBeans.iterator(); iter.hasNext(); ) {
   ThreadBean threadBean = (ThreadBean)iter.next();
%>
  <tr class="<mvn:cssrow/>">
    <td align="center"><%=threadBean.getThreadTopic()%></td>
    <td align="center"><%=threadBean.getMemberName()%></td>
    <td align="center"><%=onlineUser.getGMTTimestampFormat(threadBean.getThreadCreationDate())%></td>
    <td align="center"><%=threadBean.getLastPostMemberName()%></td>
    <td align="center"><%=onlineUser.getGMTTimestampFormat(threadBean.getThreadLastPostDate())%></td>
    <td align="center"><%=LocaleMessageUtil.getThreadTypeDescFromInt(onlineUser.getLocale(), threadBean.getThreadType())%></td>
    <td align="center"><%=LocaleMessageUtil.getThreadPriorityDescFromInt(onlineUser.getLocale(), threadBean.getThreadPriority())%></td>
    <td align="center"><%=LocaleMessageUtil.getThreadStatusDescFromInt(onlineUser.getLocale(), threadBean.getThreadStatus())%></td>
    <td align="center"><%=threadBean.getThreadViewCount()%></td>
    <td align="center"><%=threadBean.getThreadReplyCount()%></td>
    <td align="center"><%=threadBean.getThreadAttachCount()%></td>
  </tr>
<%} %>
<% if (threadBeans.size() == 0) { %>
  <tr class="<mvn:cssrow/>">
    <td colspan="11" align="center"><fmt:message key="mvnforum.admin.processreportthreadsx.no_thread"/></td>
  </tr>
<%} %>
</mvn:cssrows>
</table>

<br />
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>
