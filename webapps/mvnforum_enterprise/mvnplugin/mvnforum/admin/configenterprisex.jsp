<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/admin/configenterprisex.jsp,v 1.62 2009/11/04 05:07:46 trungth Exp $
  - $Author: trungth $
  - $Revision: 1.62 $
  - $Date: 2009/11/04 05:07:46 $
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
<%@ page import="net.myvietnam.mvncore.configuration.DOM4JConfiguration" %>
<%@ page import="net.myvietnam.mvncore.security.SecurityUtil" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:setBundle basename="i18n/mvnforum/guide_mvnForum_i18n" scope="request" var="guide" />
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.admin.configenterprisex.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css" />
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/js/overlib.js"></script>
<script type="text/javascript" src="<%=contextPath%>/mvnplugin/mvnforum/js/md5.js"></script>
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
  if (!isUnsignedInteger(document.submitform.cms_news_view_mode, "cms_news_view_mode")) return false;
  if (!isUnsignedInteger(document.submitform.cms_news_table_width, "cms_news_table_width")) return false;
  if (isBlank(document.submitform.webservice_serverurl, "webservice_serverurl")) return false;
  if (isBlank(document.submitform.max_album_disk_size, "max_album_disk_size")) return false;
  if (!isUnsignedInteger(document.submitform.max_albumitem_width, "max_albumitem_width")) return false;
  if (!isUnsignedInteger(document.submitform.max_albumitem_height, "max_albumitem_height")) return false;
  if (isBlank(document.submitform.max_albumitem_attachment_size, "max_albumitem_attachment_size")) return false;
  if (!isUnsignedInteger(document.submitform.minutes_to_rate_albumitem_again, "minutes_to_rate_albumitem_again")) return false;
  if (!isUnsignedInteger(document.submitform.minutes_to_vote_poll_again, "minutes_to_vote_poll_again")) return false;
  if (isBlank(document.submitform.MemberCurrentMatkhau, "<fmt:message key="mvnforum.common.prompt.current_password"/>")) {
      return false;
  }
  if (document.submitform.MemberCurrentMatkhau.value.length < 3) {
    alert("<fmt:message key="mvnforum.common.js.prompt.invalidlongpassword"/>");
    document.submitform.MemberCurrentMatkhau.focus();
    return false;
  }
  return true;
}
//]]>
</script>

<%@ include file="header.jsp"%>
<br/>
<%
DOM4JConfiguration forumEntConfig = (DOM4JConfiguration)request.getAttribute("ForumEntConfig");
%>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <%if (isServlet) {%>
  <a href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  <%}%>
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
  <a href="<%=urlResolver.encodeURL(request, response, "configindex")%>"><fmt:message key="mvnforum.admin.configindex.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnforum.admin.configenterprisex.title"/>
</div>

<br/>
<div class="pagedesc">
  <fmt:message key="mvnforum.admin.configenterprisex.info"/><br/>
  <a href="<%=urlResolver.encodeURL(request, response, "reloadconfigenterprise?mvncoreSecurityToken=" + SecurityUtil.getSessionToken(request), URLResolverService.ACTION_URL)%>" class="command"><fmt:message key="mvnforum.admin.configenterprisex.reload_enterprise"/></a> (mvnforum_enterprise.xml)<br/>
</div>
<br/>

<form action="<%=urlResolver.encodeURL(request, response, "configenterpriseprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform" onsubmit="return false;">
<%=urlResolver.generateFormAction(request, response, "configenterpriseprocess")%>
<mvn:securitytoken />
<input type="hidden" name="md5pw" value="" />
<mvn:cssrows>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.configenterprisex.title"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_cache_domainresolver" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_cache_domainresolver">enable_cache_domainresolver</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_cache_domainresolver = forumEntConfig.getString("mvnforumenterpriseconfig.enable_cache_domainresolver", "");%>
    <input type="checkbox" id="enable_cache_domainresolver" name="enable_cache_domainresolver" value="true" class="noborder"
    <% if ("true".equals(enable_cache_domainresolver)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.webservice_serverurl" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="webservice_serverurl">webservice_serverurl</label> <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="100" id="webservice_serverurl" name="webservice_serverurl" value="<%=forumEntConfig.getString("mvnforumenterpriseconfig.webservice_serverurl", "")%>" />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_login_info_in_cas" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_login_info_in_cas">enable_login_info_in_cas</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_login_info_in_cas = forumEntConfig.getString("mvnforumenterpriseconfig.enable_login_info_in_cas", "");%>
    <input type="checkbox" id="enable_login_info_in_cas" name="enable_login_info_in_cas" value="true" class="noborder"
    <% if ("true".equals(enable_login_info_in_cas)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.cas_validate_url" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="cas_validate_url">cas_validate_url</label> <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="100" id="cas_validate_url" name="cas_validate_url" value="<%=forumEntConfig.getString("mvnforumenterpriseconfig.cas_validate_url", "")%>" />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_login_info_in_openid" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_login_info_in_openid">enable_login_info_in_openid</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_login_info_in_openid = forumEntConfig.getString("mvnforumenterpriseconfig.enable_login_info_in_openid", "");%>
    <input type="checkbox" id="enable_login_info_in_openid" name="enable_login_info_in_openid" value="true" class="noborder"
    <% if ("true".equals(enable_login_info_in_openid)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.openid_realm" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="openid_realm">openid_realm</label> <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="100" id="openid_realm" name="openid_realm" value="<%=forumEntConfig.getString("mvnforumenterpriseconfig.openid_realm", "")%>" />
    </td>
  </tr>
  
  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_database_storage" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_database_storage">enable_database_storage</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_database_storage = forumEntConfig.getString("mvnforumenterpriseconfig.enable_database_storage", "");%>
    <input type="checkbox" id="enable_database_storage" name="enable_database_storage" value="true" class="noborder"
    <% if ("true".equals(enable_database_storage)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_jaas_login_context" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_jaas_login_context">enable_jaas_login_context</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_jaas_login_context = forumEntConfig.getString("mvnforumenterpriseconfig.enable_jaas_login_context", "");%>
    <input type="checkbox" id="enable_jaas_login_context" name="enable_jaas_login_context" value="true" class="noborder"
    <% if ("true".equals(enable_jaas_login_context)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_oid_login_context" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_oid_login_context">enable_oid_login_context</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_oid_login_context = forumEntConfig.getString("mvnforumenterpriseconfig.enable_oid_login_context", "");%>
    <input type="checkbox" id="enable_oid_login_context" name="enable_oid_login_context" value="true" class="noborder"
    <% if ("true".equals(enable_oid_login_context)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.ldap_type" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="ldap_type">ldap_type</label></td>
    <td>
    <input type="text" size="100" id="ldap_type" name="ldap_type" value="<%=forumEntConfig.getString("mvnforumenterpriseconfig.ldap_type", "")%>" />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_watch_mail_gateway" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_watch_mail_gateway">enable_watch_mail_gateway</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_watch_mail_gateway = forumEntConfig.getString("mvnforumenterpriseconfig.enable_watch_mail_gateway", "");%>
    <input type="checkbox" id="enable_watch_mail_gateway" name="enable_watch_mail_gateway" value="true" class="noborder"
    <% if ("true".equals(enable_watch_mail_gateway)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_gateway_with_confirmedcode" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_gateway_with_confirmedcode">enable_gateway_with_confirmedcode</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_gateway_with_confirmedcode = forumEntConfig.getString("mvnforumenterpriseconfig.enable_gateway_with_confirmedcode", "");%>
    <input type="checkbox" id="enable_gateway_with_confirmedcode" name="enable_gateway_with_confirmedcode" value="true" class="noborder"
    <% if ("true".equals(enable_gateway_with_confirmedcode)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_applet_upload_image" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_applet_upload_image">enable_applet_upload_image</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_applet_upload_image = forumEntConfig.getString("mvnforumenterpriseconfig.enable_applet_upload_image", "");%>
    <input type="checkbox" id="enable_applet_upload_image" name="enable_applet_upload_image" value="true" class="noborder"
    <% if ("true".equals(enable_applet_upload_image)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_request_private_forum" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_request_private_forum">enable_request_private_forum</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_request_private_forum = forumEntConfig.getString("mvnforumenterpriseconfig.enable_request_private_forum", "");%>
    <input type="checkbox" id="enable_request_private_forum" name="enable_request_private_forum" value="true" class="noborder"
    <% if ("true".equals(enable_request_private_forum)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>

<%--
  <tr class="<mvn:cssrow/>">
    <td>enable_chat <span class="requiredfield">*</span></td>
    <td>
    <% String enable_chat = forumEntConfig.getString("mvnforumenterpriseconfig.enable_chat", ""); %>
    <input type="checkbox" name="enable_chat" value="true" class="noborder"
    <% if ("true".equals(enable_chat)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
--%>
  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.cms_news_view_mode" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="cms_news_view_mode">cms_news_view_mode</label> <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="30" id="cms_news_view_mode" name="cms_news_view_mode" value="<%=forumEntConfig.getString("mvnforumenterpriseconfig.cms_news_view_mode", "")%>" />
    </td>
  </tr>
  
  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.cms_news_table_width" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="cms_news_table_width">cms_news_table_width</label> <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="30" id="cms_news_table_width" name="cms_news_table_width" value="<%=forumEntConfig.getString("mvnforumenterpriseconfig.cms_news_table_width", "")%>" />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_poll" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_poll">enable_poll</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_poll = forumEntConfig.getString("mvnforumenterpriseconfig.enable_poll", ""); %>
    <input type="checkbox" id="enable_poll" name="enable_poll" value="true" class="noborder"
    <% if ("true".equals(enable_poll)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.minutes_to_vote_poll_again" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="minutes_to_vote_poll_again">minutes_to_vote_poll_again</label> <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="30" id="minutes_to_vote_poll_again" name="minutes_to_vote_poll_again" value="<%=forumEntConfig.getString("mvnforumenterpriseconfig.minutes_to_vote_poll_again", "")%>" />
    </td>
  </tr>
  
  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_vote" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_vote">enable_vote</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_vote = forumEntConfig.getString("mvnforumenterpriseconfig.enable_vote", ""); %>
    <input type="checkbox" id="enable_vote" name="enable_vote" value="true" class="noborder"
    <% if ("true".equals(enable_vote)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  
  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_revote" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_revote">enable_revote</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_revote = forumEntConfig.getString("mvnforumenterpriseconfig.enable_revote", ""); %>
    <input type="checkbox" id="enable_revote" name="enable_revote" value="true" class="noborder"
    <% if ("true".equals(enable_revote)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  
  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_view_vote_result" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_view_vote_result">enable_view_vote_result</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_view_vote_result = forumEntConfig.getString("mvnforumenterpriseconfig.enable_view_vote_result", "");%>
    <input type="checkbox" id="enable_view_vote_result" name="enable_view_vote_result" value="true" class="noborder"
    <% if ("true".equals(enable_view_vote_result)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  
  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_private_album" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_private_album">enable_private_album</label><span class="requiredfield">*</span></td>
    <td>
    <% String enable_private_album = forumEntConfig.getString("mvnforumenterpriseconfig.enable_private_album", "");%>
    <input type="checkbox" id="enable_private_album" name="enable_private_album" value="true" class="noborder"
    <% if ("true".equals(enable_private_album)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_public_album" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_public_album">enable_public_album</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_public_album = forumEntConfig.getString("mvnforumenterpriseconfig.enable_public_album", "");%>
    <input type="checkbox" id="enable_public_album" name="enable_public_album" value="true" class="noborder"
    <% if ("true".equals(enable_public_album)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_albumitem_poll" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_albumitem_poll">enable_albumitem_poll</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_albumitem_poll = forumEntConfig.getString("mvnforumenterpriseconfig.enable_albumitem_poll", "");%>
    <input type="checkbox" id="enable_albumitem_poll" name="enable_albumitem_poll" value="true" class="noborder"
    <% if ("true".equals(enable_albumitem_poll)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_albumitem_rate" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_albumitem_rate">enable_albumitem_rate</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_albumitem_rate = forumEntConfig.getString("mvnforumenterpriseconfig.enable_albumitem_rate", "");%>
    <input type="checkbox" id="enable_albumitem_rate" name="enable_albumitem_rate" value="true" class="noborder"
    <% if ("true".equals(enable_albumitem_rate)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_show_album_member" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_show_album_member">enable_show_album_member</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_album_member = forumEntConfig.getString("mvnforumenterpriseconfig.enable_show_album_member", "");%>
    <input type="checkbox" id="enable_show_album_member" name="enable_show_album_member" value="true" class="noborder"
    <% if ("true".equals(enable_show_album_member)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  
  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.enable_album_type_shopping" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="enable_album_type_shopping">enable_album_type_shopping</label> <span class="requiredfield">*</span></td>
    <td>
    <% String enable_album_type_shopping = forumEntConfig.getString("mvnforumenterpriseconfig.enable_album_type_shopping", "");%>
    <input type="checkbox" id="enable_album_type_shopping" name="enable_album_type_shopping" value="true" class="noborder"
    <% if ("true".equals(enable_album_type_shopping)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  
  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.minutes_to_rate_albumitem_again" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="minutes_to_rate_albumitem_again">minutes_to_rate_albumitem_again</label> <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="30" id="minutes_to_rate_albumitem_again" name="minutes_to_rate_albumitem_again" value="<%=forumEntConfig.getString("mvnforumenterpriseconfig.minutes_to_rate_albumitem_again", "")%>" />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.max_albumitem_width" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="max_albumitem_width">max_albumitem_width</label> <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="30" id="max_albumitem_width" name="max_albumitem_width" value="<%=forumEntConfig.getString("mvnforumenterpriseconfig.max_albumitem_width", "")%>" />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.max_albumitem_height" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="max_albumitem_height">max_albumitem_height</label> <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="30" id="max_albumitem_height" name="max_albumitem_height" value="<%=forumEntConfig.getString("mvnforumenterpriseconfig.max_albumitem_height", "")%>" />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.max_album_disk_size" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="max_album_disk_size">max_album_disk_size</label> <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="30" id="max_album_disk_size" name="max_album_disk_size" value="<%=forumEntConfig.getString("mvnforumenterpriseconfig.max_album_disk_size", "")%>" />
    </td>
  </tr>

  <tr class="<mvn:cssrow/>">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icon_help.gif" onmouseover="return overlib('<fmt:message key="mvnforum_enterprise.help.max_albumitem_attachment_size" bundle="${guide}" />')" onmouseout="return nd();" alt=""/><label for="max_albumitem_attachment_size">max_albumitem_attachment_size</label> <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="30" id="max_albumitem_attachment_size" name="max_albumitem_attachment_size" value="<%=forumEntConfig.getString("mvnforumenterpriseconfig.max_albumitem_attachment_size", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><label for="MemberCurrentMatkhau"><fmt:message key="mvnforum.common.prompt.current_password"/><span class="requiredfield"> *</span></label></td>
    <td><input type="password" id="MemberCurrentMatkhau" name="MemberCurrentMatkhau" size="30" onkeypress="checkEnter(event);" /></td>
  </tr>

  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.common.action.save_and_reload"/>" class="portlet-form-button" onclick="javascript:SubmitForm();" />
      <input type="button" value="<fmt:message key="mvnforum.common.action.cancel"/>" class="liteoption" onclick="javascript:gotoPage('<%=urlResolver.encodeURL(request, response, "configindex")%>');" />
    </td>
  </tr>
</table>
</mvn:cssrows>
</form>

<br/>

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>
