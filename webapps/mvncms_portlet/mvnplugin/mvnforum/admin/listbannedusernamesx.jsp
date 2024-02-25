<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/listbannedusernamesx.jsp,v 1.45 2009/10/23 05:50:13 trungth Exp $
  - $Author: trungth $
  - $Revision: 1.45 $
  - $Date: 2009/10/23 05:50:13 $
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
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter"%>
<%@ page import="net.myvietnam.mvncore.security.SecurityUtil" %>
<%@ page import="net.myvietnam.enterprise.db.BannedUsernameBean"%>
<%@ page import="net.myvietnam.enterprise.db.BaseBean"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.admin.listbannedusernamesx.title"/></mvn:title>
  <%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
  <link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css" />
  <script src="<%=contextPath%>/mvnplugin/mvnforum/js/vietuni.js" type="text/javascript"></script>
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">

<script type="text/javascript">
//<![CDATA[
function SubmitForm() {
   if (ValidateForm() == true) {
      //don't call checkInput(), because admin will use regular expression for this field
      //if (checkInput() == true) {
         <mvn:servlet>
           document.submitform.submitbutton.disabled=true;
         </mvn:servlet>
         return document.submitform.submit();
      //}
   }
   return false;
}

function checkInput() {
   var name = document.submitform.username.value;
   var first = name.indexOf("*");//fisrt = 0|-1
   var last = name.lastIndexOf("*");//last = length-1 | -1
   if (first != -1) {
       var names = new Array();
       names = name.split("\*");
       //at lest 1 char different '*'
       if (names.length == 0) { // length == 1 if name doesn't have '*'
           alert("Bad Input");
           return false;
       }

       if (first == last) {
           if (first > 0 && first != (name.length-1)) {
               alert("Bad Input");
               return false;
           }
       } else {
           if ((first > 0) || (last != name.length-1)) {
                alert("Bad Input");
                return false;
           }
           var s = name.substring(first + 1, last);
           if (s.indexOf("*") != -1) {
             alert("Bad Input");
             return false;
           }
       }
   }
   return true;
}

var expiretype = <%=BaseBean.NEVER_EXPIRE%>;
function ValidateForm() {
   if (isBlank(document.submitform.username, "<fmt:message key="mvnforum.admin.listbannedusernamesx.username"/>")) return false;
   if (isBlank(document.submitform.note, "<fmt:message key="mvnforum.admin.listbannedusernamesx.note"/>")) return false;
   if (expiretype == <%=BaseBean.HAVE_EXPIRE_DATE%>) {
     if (isBlank(document.submitform.day, "<fmt:message key="mvnforum.common.date.day"/>")) return false;
     if (isBlank(document.submitform.month, "<fmt:message key="mvnforum.common.date.month"/>")) return false;
     if (isBlank(document.submitform.year, "<fmt:message key="mvnforum.common.date.year"/>")) return false;
   }
   return true;
}

function confirmDelete(deleteLink) {
  var msg;
  msg= "<fmt:message key="mvnforum.admin.listbannedusernamesx.js.confirm_delete"/>";
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
<br />

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isServlet) {%>
  <a href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "misctasks")%>"><fmt:message key="mvnforum.admin.misctasks.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.admin.listbannedusernamesx.title"/>
</div>
<br />

<div class="pagedesc">
  <fmt:message key="mvnforum.admin.listbannedusernamesx.info"/>
</div>
<br />

<form action="<%=urlResolver.encodeURL(request, response, "addbannedusernameprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "addbannedusernameprocess")%>
<mvn:securitytoken />
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.listbannedusernamesx.title"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="username"><fmt:message key="mvnforum.admin.listbannedusernamesx.username"/><span class="requiredfield"> *</span></label></td>
    <td><input type="text" name="username" id="username" size="30" maxlength="30" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="note"><fmt:message key="mvnforum.admin.listbannedusernamesx.note"/><span class="requiredfield"> *</span></label></td>
    <td><input type="text" id="note" name="note" onkeyup="initTyper(this);" size="50"/></td>
  </tr>
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
    <td align="center"><fmt:message key="mvnforum.admin.listbannedusernamesx.username"/></td>
    <td align="center"><fmt:message key="mvnforum.admin.listbannedusernamesx.note"/></td>
    <td align="center"><fmt:message key="mvnforum.common.date.expire_date"/></td>
    <td align="center"><fmt:message key="mvnforum.common.action.edit"/></td>
    <td align="center"><fmt:message key="mvnforum.common.action.delete"/></td>
  </tr>
<%
    Collection bannedUsernames = (Collection) request.getAttribute("BannedUsernames");
    for (Iterator iter = bannedUsernames.iterator(); iter.hasNext(); ) {
        BannedUsernameBean bannedUsername = (BannedUsernameBean)iter.next();
%>
  <tr class="<mvn:cssrow/>">
    <td align="center"><%= DisableHtmlTagFilter.filter(bannedUsername.getBannedUsernameText()) %></td>
    <td align="left"><%= DisableHtmlTagFilter.filter(bannedUsername.getNote()) %></td>
    <td align="center">
      <%
      Timestamp bannedUsernameCreationDate = bannedUsername.getCreationDate();
      Timestamp bannedUsernameExpireDate = bannedUsername.getExpireDate();
      
      if (bannedUsernameCreationDate.compareTo(bannedUsernameExpireDate) == 0) {
      %>
        <fmt:message key="mvnforum.common.status.never_expired"/>
      <%
      } else {
          if (DateUtil.getStartDate(bannedUsernameExpireDate).compareTo(DateUtil.getStartDate(DateUtil.getCurrentGMTTimestamp())) > 0) {
      %>
            <%=onlineUser.getGMTDateFormat(bannedUsernameExpireDate) %>
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
      <a class="command" href="<%=urlResolver.encodeURL(request, response, "editbannedusername?usernameID=" + bannedUsername.getId())%>"><fmt:message key="mvnforum.common.action.edit"/></a>
    </td>
    <td align="center">
      <a class="command" onclick="confirmDelete('<%=urlResolver.encodeURL(request, response, "deletebannedusernameprocess?usernameID="+bannedUsername.getId()+"&amp;mvncoreSecurityToken="+SecurityUtil.getSessionToken(request), URLResolverService.ACTION_URL)%>');return false;" href="#"><fmt:message key="mvnforum.common.action.delete" /></a>
    </td>
  </tr>
<%
}//for
if (bannedUsernames.size() == 0) {
%>
  <tr class="<mvn:cssrow/>"><td colspan="5" align="center"><fmt:message key="mvnforum.admin.listbannedusernamesx.no_banned_username"/></td></tr>
<% } %>
</mvn:cssrows>
</table>

<br />

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>