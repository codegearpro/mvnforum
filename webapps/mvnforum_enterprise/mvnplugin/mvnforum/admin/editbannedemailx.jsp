<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/editbannedemailx.jsp,v 1.40 2009/08/13 10:31:09 thonh Exp $
  - $Author: thonh $
  - $Revision: 1.40 $
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

<%@ page import="net.myvietnam.enterprise.db.BannedEmailBean"%>
<%@ page import="net.myvietnam.enterprise.db.BaseBean"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.admin.editbannedemailx.title"/></mvn:title>
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
  if (isBlank(document.submitform.email, "<fmt:message key="mvnforum.admin.listbannedemailsx.banned_email"/>")) return false;
  if (isBlank(document.submitform.note, "<fmt:message key="mvnforum.admin.listbannedemailsx.note"/>")) return false;
  //don't call check Email function, because admin will use regular expression for this field
  //if (!isEmail(document.submitform.email, "Banned Email")) return false;
  if (expiretype == <%=BaseBean.HAVE_EXPIRE_DATE%>) {
    if (isBlank(document.submitform.day, "<fmt:message key="mvnforum.common.date.day"/>")) return false;
    if (isBlank(document.submitform.month, "<fmt:message key="mvnforum.common.date.month"/>")) return false;
    if (isBlank(document.submitform.year, "<fmt:message key="mvnforum.common.date.year"/>")) return false;
  }
  
  return true;
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
  <a href="<%=urlResolver.encodeURL(request, response, "listbannedemails")%>"><fmt:message key="mvnforum.admin.listbannedemailsx.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.admin.editbannedemailx.title"/>
</div>
<br/>

<%
BannedEmailBean bannedEmail = (BannedEmailBean)request.getAttribute("BannedEmail");
%>

<form action="<%=urlResolver.encodeURL(request, response, "editbannedemailprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "editbannedemailprocess")%>
<mvn:securitytoken />
<input type="hidden" name="emailID" value="<%=bannedEmail.getId()%>" />
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.editbannedemailx.title"/>:</td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="email"><fmt:message key="mvnforum.admin.listbannedemailsx.banned_email"/><span class="requiredfield"> *</span></label></td>
    <td><input type="text" id="email" name="email" value="<%=bannedEmail.getBannedEmailAddress()%>" onkeyup="initTyper(this);" size="50" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="note"><fmt:message key="mvnforum.admin.listbannedemailsx.note"/><span class="requiredfield"> *</span></label></td>
    <td><input type="text" id="note" name="note" value="<%=bannedEmail.getNote()%>" onkeyup="initTyper(this);" size="50"/></td>
  </tr>
  <%
  boolean neverExpire = (bannedEmail.getCreationDate().compareTo(bannedEmail.getExpireDate()) == 0);
  %>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.date.expire_date"/><span class="requiredfield"> *</span></td>
    <td>
      <table class="noborder" cellpadding="3" cellspacing="0" width="100%">
        <tbody>
        <tr>
          <td> 
            <input name="expiretype" value="<%=BaseBean.NEVER_EXPIRE%>" class="noborder" type="radio" onclick="chooseExpireType(<%=BaseBean.NEVER_EXPIRE%>);" <%if (neverExpire) {%>checked="checked"<%} %>/> <fmt:message key="mvnforum.common.status.never_expired"/>&nbsp;&nbsp;<input name="expiretype" value="<%=BaseBean.HAVE_EXPIRE_DATE%>" class="noborder" type="radio" onclick="chooseExpireType(<%=BaseBean.HAVE_EXPIRE_DATE%>);" <%if (neverExpire == false) {%>checked="checked"<%} %>/> <fmt:message key="mvnforum.common.date.expire_date"/> (dd/mm/yyyy)
          </td>            
        </tr>
        <tr>               
          <td <%if (neverExpire) {%>style="display: none"<%} else {%> style="display:"<%}%> id="chooseexpiredate">
            <%if (neverExpire == false) {
                Timestamp bannedEmailExpireDate = bannedEmail.getExpireDate();
                request.setAttribute("TimeToDisplay", bannedEmailExpireDate);
              }  
            %>
            <%@ include file="inc_date_option.jsp"%>
          </td>
        </tr>
        </tbody>
      </table>
    </td>           
  </tr>
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.common.action.save"/>" onclick="javascript:SubmitForm();" class="portlet-form-button" />
      <input type="reset" value="<fmt:message key="mvnforum.common.action.reset"/>" class="liteoption" />
    </td>
  </tr>
</mvn:cssrows>
</table>
</form>

<br/>

<%@ include file="footer.jsp"%>

</mvn:body>
</mvn:html>
</fmt:bundle>