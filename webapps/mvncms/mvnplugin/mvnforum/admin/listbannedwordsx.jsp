<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/listbannedwordsx.jsp,v 1.46 2009/08/13 10:31:09 thonh Exp $
  - $Author: thonh $
  - $Revision: 1.46 $
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

<%@ page import="java.util.*" %>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter"%>
<%@ page import="net.myvietnam.mvncore.security.SecurityUtil"%>
<%@ page import="net.myvietnam.enterprise.db.BannedWordBean"%>
<%@ page import="net.myvietnam.enterprise.db.BaseBean"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.admin.listbannedwordsx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css" />
<script src="<%=contextPath%>/mvnplugin/mvnforum/js/vietuni.js" type="text/javascript"></script>
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">
<script type="text/javascript">
//<![CDATA[
function SubmitForm() {
  if (ValidateForm() == true) {
    <mvn:servlet>
      document.submitform.submitbutton.disabled=true;
    </mvn:servlet>
    return document.submitform.submit();
  }
  return false;
}

var expiretype = <%=BaseBean.NEVER_EXPIRE%>;
function ValidateForm() {
  if (isBlank(document.submitform.BannedWord, "<fmt:message key="mvnforum.admin.listbannedwordsx.banned_word"/>")) return false;
  if (isBlank(document.submitform.ReplacementToken, "<fmt:message key="mvnforum.admin.listbannedwordsx.replace_token"/>")) return false;
  if (isBlank(document.submitform.note, "<fmt:message key="mvnforum.admin.listbannedwordsx.note"/>")) return false;
  //how about CASE???
  if (document.submitform.BannedWord.value == document.submitform.ReplacementToken.value) {
    alert('<fmt:message key="mvnforum.admin.listbannedwordsx.duplicate_bannedword_replacetoken"/>');
    return false;
  }
  if (expiretype == <%=BaseBean.HAVE_EXPIRE_DATE%>) {
    if (isBlank(document.submitform.day, "<fmt:message key="mvnforum.common.date.day"/>")) return false;
    if (isBlank(document.submitform.month, "<fmt:message key="mvnforum.common.date.month"/>")) return false;
    if (isBlank(document.submitform.year, "<fmt:message key="mvnforum.common.date.year"/>")) return false;
  }
   
  return true;
}

function confirmDelete(deleteLink) {
  var msg;
  msg= "<fmt:message key="mvnforum.admin.listbannedwordsx.js.confirm_delete"/>";
  var agree = confirm(msg);
  if (agree) {
    document.location.href=deleteLink;
  } else {
    document.location.href='#';
  }
}

function chooseExpireType(type) {
  expiretype = type;
  if (type == <%=BaseBean.NEVER_EXPIRE%>) {
    document.getElementById("chooseexpiredate").style.display = 'none';
  } else if (type == <%=BaseBean.HAVE_EXPIRE_DATE%>) {
    document.getElementById("chooseexpiredate").style.display = '';
  }
}
//]]>
</script>

<%@ include file="header.jsp"%>
<br/>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isServlet) {%>
  <a href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "misctasks")%>"><fmt:message key="mvnforum.admin.misctasks.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.admin.listbannedwordsx.title"/>
</div>
<br/>

<div class="pagedesc">
  <fmt:message key="mvnforum.admin.listbannedwordsx.info"/>
</div>
<br />

<form action="<%=urlResolver.encodeURL(request, response, "addbannedwordprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "addbannedwordprocess")%>
<mvn:securitytoken />
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.listbannedwordsx.add_banned_word"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="BannedWord"><fmt:message key="mvnforum.admin.listbannedwordsx.banned_word"/><span class="requiredfield"> *</span></label></td>
    <td><input type="text" id="BannedWord" name="BannedWord" onkeyup="initTyper(this);" size="50"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="ReplacementToken"><fmt:message key="mvnforum.admin.listbannedwordsx.replace_token"/><span class="requiredfield"> *</span></label></td>
    <td><input type="text" id="ReplacementToken" name="ReplacementToken" onkeyup="initTyper(this);" size="50"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="note"><fmt:message key="mvnforum.admin.listbannedwordsx.note"/><span class="requiredfield"> *</span></label></td>
    <td><input type="text" id="note" name="note" onkeyup="initTyper(this);" size="50" /></td>
  </tr>
<%
if (currentLocale.equals("vi")) {/*vietnamese here*/
%>
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
<%
}// end if vietnamese
%>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.date.expire_date"/><span class="requiredfield"> *</span></td>
    <td>
      <table class="noborder" cellpadding="3" cellspacing="0" width="100%">
        <tbody>
        <tr>
          <td> 
            <input name="expiretype" value="<%=BaseBean.NEVER_EXPIRE%>" class="noborder" type="radio" onclick="chooseExpireType(<%=BaseBean.NEVER_EXPIRE%>);" checked="checked"/> <fmt:message key="mvnforum.common.status.never_expired"/>&nbsp;&nbsp;<input name="expiretype" value="<%=BaseBean.HAVE_EXPIRE_DATE%>" class="noborder" type="radio" onclick="chooseExpireType(<%=BaseBean.HAVE_EXPIRE_DATE%>);"/> <fmt:message key="mvnforum.common.date.expire_date"/> (dd/mm/yyyy)
          </td>            
        </tr>
        <tr>               
          <td style="display: none" id="chooseexpiredate">
            <%@ include file="inc_date_option.jsp"%>
          </td>
        </tr>
        </tbody>
      </table>
    </td>
  </tr>
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.common.action.add"/>" onclick="javascript:SubmitForm();" class="portlet-form-button" />
      <input type="reset" value="<fmt:message key="mvnforum.common.action.reset"/>" class="liteoption" />
    </td>
  </tr>
</mvn:cssrows>
</table>
</form>

<br />
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td align="center"><fmt:message key="mvnforum.admin.listbannedwordsx.banned_word"/></td>
    <td align="center"><fmt:message key="mvnforum.admin.listbannedwordsx.replace_token"/></td>
    <td align="center"><fmt:message key="mvnforum.admin.listbannedwordsx.note"/></td>
    <td align="center"><fmt:message key="mvnforum.common.date.expire_date"/></td>
    <td align="center"><fmt:message key="mvnforum.common.action.edit"/></td>
    <td align="center"><fmt:message key="mvnforum.common.action.delete"/></td>
  </tr>
<%
Collection bannedWords = (Collection) request.getAttribute("BannedWords");
for (Iterator iter = bannedWords.iterator(); iter.hasNext(); ) {
    BannedWordBean bannedWord = (BannedWordBean)iter.next();
%>
  <tr class="<mvn:cssrow/>">
    <td align="center"><%=DisableHtmlTagFilter.filter(bannedWord.getBannedWordText())%></td>
    <td align="center"><%=DisableHtmlTagFilter.filter(bannedWord.getBannedWordReplacement())%></td>
    <td align="left"><%=DisableHtmlTagFilter.filter(bannedWord.getNote())%></td>
    <td align="center">
      <%
      Timestamp bannedWordCreationDate = bannedWord.getCreationDate();
      Timestamp bannedWordExpireDate = bannedWord.getExpireDate();
      
      if (bannedWordCreationDate.compareTo(bannedWordExpireDate) == 0) {
      %>
        <fmt:message key="mvnforum.common.status.never_expired"/>
      <%
      } else {
          if (DateUtil.getStartDate(bannedWordExpireDate).compareTo(DateUtil.getStartDate(DateUtil.getCurrentGMTTimestamp())) > 0) {
      %>
            <%=onlineUser.getGMTDateFormat(bannedWordExpireDate) %>
      <%              
          } else {
      %>
            <fmt:message key="mvnforum.common.status.expired"/>
      <%              
          }
      }
      %>
    </td>
    <td align="center">
      <a class="command" href="<%=urlResolver.encodeURL(request, response, "editbannedword?BannedWordID=" + bannedWord.getId())%>"><fmt:message key="mvnforum.common.action.edit"/></a>
    </td>
    <td align="center">
      <a class="command" onclick="confirmDelete('<%=urlResolver.encodeURL(request, response, "deletebannedwordprocess?BannedWordID="+bannedWord.getId()+"&amp;mvncoreSecurityToken="+SecurityUtil.getSessionToken(request), URLResolverService.ACTION_URL)%>');return false;" href="#"><fmt:message key="mvnforum.common.action.delete" /></a>
    </td>
  </tr>
<%
}//for
if (bannedWords.size() == 0) {
%>
  <tr class="<mvn:cssrow/>"><td colspan="6" align="center"><fmt:message key="mvnforum.admin.listbannedwordsx.no_banned_word"/></td></tr>
<% } %>
</mvn:cssrows>
</table>

<br/>

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>