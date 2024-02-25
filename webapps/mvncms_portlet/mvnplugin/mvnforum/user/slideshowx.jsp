<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/slideshowx.jsp,v 1.40 2009/12/18 07:09:51 xuantl Exp $
  - $Author: xuantl $
  - $Revision: 1.40 $
  - $Date: 2009/12/18 07:09:51 $
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
<%@ page import="com.mvnforum.enterprise.db.AlbumBean"%>
<%@ page import="com.mvnforum.enterprise.db.AlbumItemBean"%>
<%@ page import="com.mvnforum.user.UserModuleConfig"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.slideshowx.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>
<%
Collection itemBeans = (Collection) request.getAttribute("AlbumItemBeans");
AlbumBean albumBean = (AlbumBean) request.getAttribute("AlbumBean");
int index = ((Integer) request.getAttribute("Index")).intValue();

int i = 0;
for (Iterator iterator = itemBeans.iterator(); iterator.hasNext(); i++) {
  AlbumItemBean albumItemBean = (AlbumItemBean) iterator.next(); %>
<div style="display:none">
  <a id="item_<%=i%>" href="<%=urlResolver.encodeURL(request, response, "getalbumitem?itemid=" + albumItemBean.getAlbumItemID(), URLResolverService.ACTION_URL)%>"></a>
  <span id="index_<%=i%>"><%=index%></span>
  <span id="title_<%=i%>"><%=albumItemBean.getItemTitle()%></span>
  <span id="date_<%=i%>"><%=onlineUser.getGMTTimestampFormat(albumItemBean.getItemCreationDate())%></span>
</div>
<%}%>

<script type="text/JavaScript">
//<![CDATA[
var image = new Image(), timer, iDelay = 3 * 1000, iDir = 1, iSize = 0;
var spanPause;
var bPause = 0;
var spanIndex, spanTitle, spanDate;
var index = <%=index%>, count = <%=itemBeans.size()%>;

function start_stop() {
  bPause = bPause ? 0 : 1;
  if (bPause) {
    clearTimeout(timer);
    document.images.iconpause.src = '<%=contextPath%>/mvnplugin/mvnforum/images/album/icon_play.gif';
  } else {
    goto_next_photo();
    document.images.iconpause.src = '<%=contextPath%>/mvnplugin/mvnforum/images/album/icon_pause.gif';
  }
  spanPause.innerHTML = bPause ? '<fmt:message key="mvnforum.user.slideshowx.resume"/>' : '<fmt:message key="mvnforum.user.slideshowx.pause"/>';
}
function move_index(by) {
  return (index + by + count)%count;
}
function goto_next_photo() {
  index = move_index(1);
  document.images.slide.src = document.getElementById('item_'+index).href;
}
function goto_back_photo() {
  index = move_index(-1);
  document.images.slide.src = document.getElementById('item_'+index).href;
}
function preload(i) {
    image.src = document.getElementById('item_'+i).href;
}
function slide_view_start() {
  spanIndex.innerHTML = index + 1;
  spanTitle.innerHTML = document.getElementById('title_'+index).innerHTML;
  spanDate.innerHTML = document.getElementById('date_'+index).innerHTML;
  preload(move_index(1));
  if (timer) { clearInterval(timer); clearTimeout(timer); } // Avoid extra timers in opera
  if (!bPause) timer = setTimeout('goto_next_photo()', iDelay);
}
function new_delay(delay) {
  iDelay = delay*1000;
  jump(-1);
}
function jump(by) {
  index = move_index(by);
  clearTimeout(timer);
  goto_next_photo();
}
//]]>
</script>

<table width="385" class="noborder" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>
<%
String adAlbum = (String) request.getAttribute("AdAlbumCode");
if (adAlbum != null) {%>      
      <table width="385" class="noborder" cellspacing="5" cellpadding="0" bgcolor="#EDF7FF">
        <tr>
          <td align="center">
            <div><%=adAlbum%></div>
          </td>
        </tr>
      </table>
<%}%>
      <table width="385" class="noborder" cellspacing="5" cellpadding="0" bgcolor="#EDF7FF">
        <tr>
          <td align="center">
            <div>
              <img id="slide" alt="" src="" width="375" height="338" />
            </div>
          </td>
        </tr>
        <tr>
          <td align="center">
            <span id="title">&nbsp;</span><br />
            <span id="date"></span>
          </td>
        </tr>
      </table>
      <table width="385" cellspacing="0" cellpadding="0" class="footervote noborder">
        <tr>
          <td rowspan="3" width="70" height="50" style="border-right: 1px solid #999999;">
            <a href="#" class="command" onclick="goto_back_photo();">
              <img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/arrow_left.gif" alt="" hspace="5" border="0" />
              <fmt:message key="mvnforum.user.slideshowx.previous"/>
            </a>
          </td>
          <td width="190" align="center" style="border-bottom: 1px solid #999999;">
            <fmt:message key="mvnforum.common.albumitem"/> <b><span id="index"></span></b>&nbsp;<fmt:message key="mvnforum.common.of"/>&nbsp;<b><%=itemBeans.size() %></b>
          </td>
          <td rowspan="3" width="70" align="center" style="border-left: 1px solid #999999;">
            <a href="#" class="command" onclick="goto_next_photo();">
              <fmt:message key="mvnforum.user.slideshowx.next"/>
              <img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/arrow_right.gif" alt="" hspace="5" border="0" />
            </a>
          </td>
          <td rowspan="3" align="center" style="border-left: 1px solid #999999;">
            <a href="#" onclick="window.close();"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/album/icon_close.gif" alt="" border="0" /></a><br />
            <a href="#" class="command" onclick="window.close();"><fmt:message key="mvnforum.common.action.close"/></a>
          </td>
        </tr>
        <tr>
          <td align="center" style="border-bottom: 1px solid #999999;">
            <label for="seconds"><fmt:message key="mvnforum.user.slideshowx.delay"/>:</label>
            <select id="seconds" onchange="new_delay(this.value)">
              <option value="3">3 <fmt:message key="mvnforum.common.date.X_seconds"/></option>
              <option value="5">5 <fmt:message key="mvnforum.common.date.X_seconds"/></option>
              <option value="10">10 <fmt:message key="mvnforum.common.date.X_seconds"/></option>
              <option value="15">15 <fmt:message key="mvnforum.common.date.X_seconds"/></option>
              <option value="20">20 <fmt:message key="mvnforum.common.date.X_seconds"/></option>
            </select>
          </td>
        </tr>
        <tr>
          <td align="center">
            <a href="#" class="command" onclick="start_stop(); return false;">
              <img id="iconpause" src="" width="5" height="7" hspace="5" alt="" border="0" />
              <span id="pause"><fmt:message key="mvnforum.user.slideshowx.pause"/></span>
            </a>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<script type="text/JavaScript">
//<![CDATA[
  spanPause = document.getElementById('pause');
  spanIndex = document.getElementById('index');
  spanTitle = document.getElementById('title');
  spanDate = document.getElementById('date');
  document.images.slide.onload = slide_view_start;
  document.images.slide.src = document.getElementById('item_'+index).href;
  document.images.iconpause.src = '<%=contextPath%>/mvnplugin/mvnforum/images/album/icon_pause.gif';
//]]>
</script>

</mvn:body>
</mvn:html>
</fmt:bundle>