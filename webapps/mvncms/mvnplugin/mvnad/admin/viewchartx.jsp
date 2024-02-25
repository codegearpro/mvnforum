<%--
 - $Header: /home/cvsroot/mvnad_enterprise/srcweb/mvnplugin/mvnad/admin/viewchartx.jsp,v 1.9 2009/07/16 03:36:57 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.9 $
 - $Date: 2009/07/16 03:36:57 $
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
<%@ page import="com.mvnsoft.mvnad.db.ZoneBean"%>
<%@ page import="com.mvnsoft.mvnad.db.BannerBean"%>
<%@ page import="com.mvnsoft.mvnad.db.ZoneDAO"%>
<%@ page import="com.mvnsoft.mvnad.db.BannerDAO"%>
<%@ page import="com.mvnsoft.mvnad.MVNAdConfig"%>
<%@ page import="com.mvnsoft.mvnad.enterprise.common.ChartKind"%>
<%@ page import="net.myvietnam.mvncore.util.I18nUtil"%>
<%@ page import="java.sql.Timestamp"%>
<%
int bannerID = ((Integer) request.getAttribute("BannerID")).intValue();
int zoneID = ((Integer) request.getAttribute("ZoneID")).intValue();
int chartID = ((Integer) request.getAttribute("ChartID")).intValue();

Timestamp fromDate = (Timestamp) request.getAttribute("FromDate");
Timestamp toDate = (Timestamp) request.getAttribute("ToDate");

String filename = (String) request.getAttribute("filename");
String graphURL = request.getContextPath() + "/servlet/DisplayChart?filename=" + filename;

Collection zoneBeans = (Collection) request.getAttribute("ZoneBeans");
Collection bannerBeans = (Collection) request.getAttribute("BannerBeans");
Map bannerZone = (Map) request.getAttribute("BannerZone");
String imageMap = (String) request.getAttribute("imageMap");
%>
<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="i18n/mvnad/mvnad_i18n">
<mvn:html>
<mvn:head>
  <mvn:title><fmt:message key="mvnad.common.ad.title_name"/> - <fmt:message key="mvnad.admin.viewchart.title"/></mvn:title>
  <%@ include file="/mvnplugin/mvnad/meta.jsp"%>
  <link href="<%=contextPath%>/mvnplugin/mvnad/css/style.css" rel="stylesheet" type="text/css" />
</mvn:head>
<mvn:body>
<%=imageMap%>
<div id="data" style="display:none">
<%
for (Iterator zoneIter = zoneBeans.iterator(); zoneIter.hasNext(); ) {
  ZoneBean zoneBean = (ZoneBean) zoneIter.next();
  Collection banners = (Collection) bannerZone.get(new Integer(zoneBean.getZoneID()));
  for (Iterator bannerIter = banners.iterator(); bannerIter.hasNext(); ) {
    BannerBean bannerBean = (BannerBean) bannerIter.next();
%>
  <div id="zone@<%=zoneBean.getZoneID()%>@banner@<%=bannerBean.getBannerID()%>"><%=bannerBean.getBannerID()%></div>
  <div id="zone@<%=zoneBean.getZoneID()%>@banner@<%=bannerBean.getBannerID()%>@bannername"><%=bannerBean.getBannerName()%></div>
<%}//bannerIter%>
<%}//zoneIter%>
<%
for (Iterator bannerIter = bannerBeans.iterator(); bannerIter.hasNext(); ) {
    BannerBean bannerBean = (BannerBean) bannerIter.next();
%>
  <div id="banners@banner<%=bannerBean.getBannerID()%>"><%=bannerBean.getBannerID()%></div>
  <div id="banners@bannername<%=bannerBean.getBannerID()%>"><%=bannerBean.getBannerName()%></div>  
<%}%>

</div>

<script type="text/javascript">
//<![CDATA[
function onChangeZone(zoneID) {
  var codeselect = "";
  
  codeselect+= "<label for=\"bannerid\"><fmt:message key="mvnad.common.banner.name"/></label>&nbsp;&nbsp;";
  codeselect+= "<select id=\"bannerid\" name=\"bannerid\">";
  codeselect+= "<option value=\""+<%=BannerDAO.BANNER_TYPE_ALL%>+"\"><fmt:message key="mvnad.admin.viewchart.all_zones_banners"/></option>";
  if (zoneID != <%=ZoneDAO.ZONE_TYPE_ALL%>)  {
    var arrayElement = document.getElementsByTagName("div");  //get all element
    for (i = 0; i<arrayElement.length; i++) {
      if ((arrayElement[i] != null) && (arrayElement[i].getAttribute("id") != null ) && (arrayElement[i].getAttribute("id").length > 0)) {
        if (arrayElement[i].getAttribute("id").indexOf("zone@" + zoneID + "@banner@") != -1 &&
            arrayElement[i].getAttribute("id").indexOf("@bannername") == -1) {
          codeselect+="<option value=\""+arrayElement[i].innerHTML+"\">"+document.getElementById(arrayElement[i].getAttribute("id")+"@bannername").innerHTML +"</option>";
        }
      }
    }
  } else {
    <%
    for (Iterator bannerIter = bannerBeans.iterator(); bannerIter.hasNext(); ) {
        BannerBean bannerBean = (BannerBean) bannerIter.next();
    %>
      codeselect+="<option value=\""+<%=bannerBean.getBannerID()%>+"\">"+document.getElementById("banners@bannername<%=bannerBean.getBannerID()%>").innerHTML+"</option>";
    <%}%>
  }
  codeselect+= "</select>";
  document.getElementById("bannerspan").innerHTML = codeselect;
}
function onLoad() {
  var codeselect = "";
  codeselect+= "<label for=\"bannerid\"><fmt:message key="mvnad.common.banner.name"/></label>&nbsp;&nbsp;";
  codeselect+= "<select id=\"bannerid\" name=\"bannerid\">";
  codeselect+= "<option value=\""+<%=BannerDAO.BANNER_TYPE_ALL%>+"\"><fmt:message key="mvnad.admin.viewchart.all_zones_banners"/></option>";
  if (<%=zoneID%> != <%=ZoneDAO.ZONE_TYPE_ALL%>)  {
    var arrayElement = document.getElementsByTagName("div");  //get all element
    for (i = 0; i<arrayElement.length; i++) {
      if ((arrayElement[i] != null) && (arrayElement[i].getAttribute("id") != null ) && (arrayElement[i].getAttribute("id").length > 0)) {
        if (arrayElement[i].getAttribute("id").indexOf("zone@" + <%=zoneID%> + "@banner@") != -1 &&
            arrayElement[i].getAttribute("id").indexOf("@bannername") == -1) {
          codeselect+="<option value=\""+arrayElement[i].innerHTML+"\"";
          if (arrayElement[i].innerHTML == <%=bannerID%>) {
            codeselect+=" selected=\"selected\"";
          }
          codeselect+=">"+document.getElementById(arrayElement[i].getAttribute("id")+"@bannername").innerHTML +"</option>";
        }
      }
    }
  } else {
    <%
    for (Iterator bannerIter = bannerBeans.iterator(); bannerIter.hasNext(); ) {
        BannerBean bannerBean = (BannerBean) bannerIter.next();
    %>
      codeselect+="<option value=\""+<%=bannerBean.getBannerID()%>+"\"";
      if (<%=bannerBean.getBannerID()%> == <%=bannerID%>) {
        codeselect+=" selected=\"selected\"";
      }
      codeselect+=">"+document.getElementById("banners@bannername<%=bannerBean.getBannerID()%>").innerHTML+"</option>";
    <%}%>
  }
  codeselect+= "</select>";
  document.getElementById("bannerspan").innerHTML = codeselect;
}
function SubmitForm() {
  if (ValidateForm() == true) {
    <mvn:servlet>
      document.submitform.submitbutton.disabled=true;
    </mvn:servlet>
    document.submitform.submit();
  }
}
function ValidateForm() {
  var zoneID = document.submitform.zoneid.value;
  var bannerID = document.submitform.bannerid.value;
  if (zoneID == 0 && bannerID == 0) {
    alert('<fmt:message key="mvnad.admin.viewchart.require.zone_banner"/>');
    return false;
  }
  return true;
}
//]]>
</script>
<%@ include file="header.jsp"%>
<br />

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnad/images/nav.gif" alt="" class="middle" />
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnad.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
  <fmt:message key="mvnad.admin.viewchart.title"/>
</div>
<br />

<table align="center" border="0" cellpadding="3" cellspacing="0" width="95%">
  <tr valign="top">
    <td valign="top" width="20%">
      <table class="tborder" align="center" border="0" cellpadding="3" cellspacing="0" width="100%">
        <tr class="portlet-section-header">
          <td><fmt:message key="mvnad.admin.viewchart.chart"/></td>
        </tr>
      <%
      for (Iterator chartIter = ChartKind.getChartList().iterator(); chartIter.hasNext(); ) {
        ChartKind chartKind = (ChartKind) chartIter.next();
      %>
        <tr class="portlet-section-body">
          <td valign="top">
            <a href="<%=urlResolver.encodeURL(request, response, "viewchart?chartid=" + chartKind.getId() + "&amp;zoneid=" + zoneID + "&amp;bannerid=" + bannerID)%>">
            <%if (chartID == chartKind.getId()) {%><b><%}%>
            <%=chartKind.getLocaleValue(I18nUtil.getLocaleInRequest(request))%>
            <%if (chartID == chartKind.getId()) {%></b><%}%>
            </a>
          </td>
        </tr>
      <%}%>
      </table>
    </td>
    <td style="width: 5px;">&nbsp;&nbsp;</td> 
    <td class="portlet-font">
      <form name="submitform" action="<%=urlResolver.encodeURL(request, response, "viewchart", URLResolverService.ACTION_URL)%>" <mvn:method/>>
        <%=urlResolver.generateFormAction(request, response, "viewchart")%>
        <label for="zoneid"><fmt:message key="mvnad.common.zone.name"/></label>&nbsp;&nbsp;
        <select id="zoneid" name="zoneid" onchange="onChangeZone(this.options[this.selectedIndex].value);">
          <option value="<%=ZoneDAO.ZONE_TYPE_ALL%>"><fmt:message key="mvnad.admin.viewchart.all_zones_banners"/></option>
          <%
            for (Iterator iter = zoneBeans.iterator(); iter.hasNext(); ) {
              ZoneBean zoneBean = (ZoneBean) iter.next();
              
          %>
          <option value="<%=zoneBean.getZoneID()%>"<%if (zoneBean.getZoneID() == zoneID) {%> selected="selected"<%}%>><%=zoneBean.getZoneName()%></option>
          <%}%>
        </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <span id="bannerspan"></span>
        <br />
        <fmt:message key="mvnad.common.ad.start_date"/>
        <%prefixName = "FromDate";
          Timestamp currentTimestamp = fromDate;
          float startYear = 0;%>
        <%@ include file="inc_date_option.jsp"%>
        <fmt:message key="mvnad.common.ad.end_date"/>
        <%prefixName = "ToDate";
          currentTimestamp = toDate;%>
        <%@ include file="inc_date_option.jsp"%>
        &nbsp;&nbsp;<input type="button" name="submitbutton" value="<fmt:message key="mvnad.common.action.view"/>" onclick="SubmitForm();" />
        <input type="hidden" name="chartid" value="<%=chartID%>" />
      </form>
      <br />
      <img usemap="#<%=filename%>" src="<%=graphURL%>" border="0" alt="" />
    </td>
  </tr>
</table>
<br />

<script type="text/javascript">
//<![CDATA[
onLoad();
//]]>
</script>
<br />
<%@ include file="footer.jsp"%>

</mvn:body>
</mvn:html>
</fmt:bundle>