<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/listbannedipsx.jsp,v 1.44 2009/08/13 10:31:09 thonh Exp $
  - $Author: thonh $
  - $Revision: 1.44 $
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

<%@ page import="java.util.*" %>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter"%>
<%@ page import="net.myvietnam.mvncore.security.SecurityUtil" %>
<%@ page import="net.myvietnam.enterprise.db.BannedIPBean" %>
<%@ page import="net.myvietnam.enterprise.db.BaseBean"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name" /> - <fmt:message key="mvnforum.admin.listbannedipsx.title" /></mvn:title>
  <%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
  <link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css" />
  <script src="<%=contextPath%>/mvnplugin/mvnforum/js/vietuni.js" type="text/javascript"></script>
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">
<script type="text/javascript"> 
//<![CDATA[
function SubmitForm() {
  if (ValidateForm() == true) {
    if (checkMatchIP() == true) {
      <mvn:servlet>
        document.submitform.submitbutton.disabled=true;
      </mvn:servlet>
      return document.submitform.submit();
    }
  }
  return false;  
}

var expiretype = <%=BaseBean.NEVER_EXPIRE%>;
function ValidateForm() {
    if (isBlank(document.submitform.IPAddress, "<fmt:message key="mvnforum.admin.listbannedipsx.ip_address"/>")) return false;
    if (isBlank(document.submitform.Note, "<fmt:message key="mvnforum.admin.listbannedipsx.note"/>")) return false;
    if (expiretype == <%=BaseBean.HAVE_EXPIRE_DATE%>) {
      if (isBlank(document.submitform.day, "<fmt:message key="mvnforum.common.date.day"/>")) return false;
      if (isBlank(document.submitform.month, "<fmt:message key="mvnforum.common.date.month"/>")) return false;
      if (isBlank(document.submitform.year, "<fmt:message key="mvnforum.common.date.year"/>")) return false;
    }
    return true;
}

function isNumber(sText) {
    var ValidChars = "0123456789";
    var IsNumber=true;
    var Char;
    for (var i = 0; i < sText.length && IsNumber == true; i++) {
        Char = sText.charAt(i);
        if (ValidChars.indexOf(Char) == -1) {
            IsNumber = false;
        }
    }
    return IsNumber;
}

function checkMatchIP() {
    var IPAddress = document.getElementById('IPAddress').value;
    var range = document.getElementById('Range').value;
    var IPs = new Array();
    var ranges = new Array();

    if (checkIP(IPAddress) == false) {
        alert("Invalid IP Format : " + IPAddress);
        return false;
    }
    if (range == "") {
      return true;
    }
    if (checkIP(range) == false) {
        alert("Invalid IP Format : " + range);
        return false;
    }

    IPs = IPAddress.split(".");
    ranges = range.split(".");

    //3 first part of iPAddress and range are matched together
    /*for (var i = 0; i < IPs.length; i++) {
        if (IPs[i] != ranges[i]) {
            alert("Range not match IP Address");
            return false;
        }
    }*/
    if (IPs[IPs.length] >= ranges[ranges.length]) {
        alert("Range is incorrect" + range);
        return false;
    }
    return true;
}

function checkIP(IPAddress) {
    var IPs = new Array();
    IPs = IPAddress.split(".");
    if (IPs.length != 4) {
        return false;
    }
    for (var i = 0; i < IPs.length; i++) {
        if (isNumber(IPs[i]) == false) {
            return false;
        }
        if (IPs[i] > 255) { // don't need to check (IPs[i] < 0) b/c it is checked
            return false; // in isNumber(IPs[i])
        }
    }
    return true;
}

function confirmDelete(deleteLink) {
  var msg;
  msg= "<fmt:message key="mvnforum.admin.listbannedipsx.js.confirm_delete"/>";
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
    <fmt:message key="mvnforum.admin.listbannedipsx.title"/>
</div>
<br />

<div class="pagedesc">
  <fmt:message key="mvnforum.admin.listbannedipsx.info"/>
</div>
<br />

<form action="<%=urlResolver.encodeURL(request, response, "addbannedipprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "addbannedipprocess")%>
<mvn:securitytoken />
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.listbannedipsx.add_banned_ip" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="IPAddress"><fmt:message key="mvnforum.admin.listbannedipsx.ip_address"/><span class="requiredfield"> *</span></label></td>
    <td><input type="text" name="IPAddress" id="IPAddress" size="20" maxlength="20" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="Range"><fmt:message key="mvnforum.admin.listbannedipsx.ip_range"/></label></td>
    <td><input type="text" name="Range" id="Range" onkeyup="initTyper(this);" size="20" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="Note"><fmt:message key="mvnforum.admin.listbannedipsx.note"/><span class="requiredfield"> *</span></label></td>
    <td><input type="text" id="Note" name="Note" onkeyup="initTyper(this);" size="50" /></td>
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
    <td align="center"><fmt:message key="mvnforum.admin.listbannedipsx.ip_address"/></td>
    <td align="center"><fmt:message key="mvnforum.admin.listbannedipsx.ip_range"/></td>
    <td align="center"><fmt:message key="mvnforum.admin.listbannedipsx.note"/></td>
    <td align="center"><fmt:message key="mvnforum.common.date.expire_date"/></td>
    <td align="center"><fmt:message key="mvnforum.common.action.edit"/></td>
    <td align="center"><fmt:message key="mvnforum.common.action.delete"/></td>
  </tr>
<%
Collection filteredIPs = (Collection)request.getAttribute("FilteredIPs");
for (Iterator iter = filteredIPs.iterator(); iter.hasNext(); ) {
    BannedIPBean filteredIP = (BannedIPBean)iter.next();
%>
  <tr class="<mvn:cssrow/>">
    <td align="center"><%=DisableHtmlTagFilter.filter(filteredIP.getBannedIPAddress())%></td>
    <td align="center"><%=DisableHtmlTagFilter.filter(filteredIP.getBannedIPRange())%></td>
    <td align="left"><%=DisableHtmlTagFilter.filter(filteredIP.getNote())%></td>
    <td align="center">
      <%
      Timestamp bannedIPCreationDate = filteredIP.getCreationDate();
      Timestamp bannedIPExpireDate = filteredIP.getExpireDate();
      
      if (bannedIPCreationDate.compareTo(bannedIPExpireDate) == 0) {
      %>
        <fmt:message key="mvnforum.common.status.never_expired"/>
      <%
      } else {
          if (DateUtil.getStartDate(bannedIPExpireDate).compareTo(DateUtil.getStartDate(DateUtil.getCurrentGMTTimestamp())) > 0) {
      %>
            <%=onlineUser.getGMTDateFormat(bannedIPExpireDate) %>
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
      <a class="command" href="<%=urlResolver.encodeURL(request, response, "editbannedip?ipID=" + filteredIP.getId())%>"><fmt:message key="mvnforum.common.action.edit" /></a>
    </td>
    <td align="center">
      <a class="command" onclick="confirmDelete('<%=urlResolver.encodeURL(request, response, "deletebannedipprocess?IPAddressID="+filteredIP.getId()+"&amp;mvncoreSecurityToken="+SecurityUtil.getSessionToken(request), URLResolverService.ACTION_URL)%>');return false;" href="#"><fmt:message key="mvnforum.common.action.delete" /></a>
    </td>
  </tr>
<%
}//for
if (filteredIPs.size() == 0) {
%>
  <tr class="<mvn:cssrow/>"><td colspan="6" align="center"><fmt:message key="mvnforum.admin.listbannedipsx.no_banned_ip"/></td></tr>
<% } %>
</mvn:cssrows>
</table>

<br />

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>