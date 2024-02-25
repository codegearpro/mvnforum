<%--
 - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/search_inner.jsp,v 1.17 2009/12/24 02:49:40 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.17 $
 - $Date: 2009/12/24 02:49:40 $
 -
 - ====================================================================
 -
 - Copyright (C) 2005 by MyVietnam.net
 -
 - MyVietnam.net PROPRIETARY/CONFIDENTIAL PROPERTIES. Use is subject to license terms.
 - You CANNOT use this software unless you receive a written permission from MyVietnam.net
 -
 - @author: MyVietnam.net developers
 -
 --%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="net.myvietnam.mvncore.security.Encoder"%>
<%Collection<String[]> channels = (Collection<String[]>) request.getAttribute("Channels");%>

<script type="text/javascript">
//<![CDATA[
// full day names
Calendar._DN = new Array
("<fmt:message key="mvncms.template1.calendar.day.sunday"/>",
 "<fmt:message key="mvncms.template1.calendar.day.monday"/>",
 "<fmt:message key="mvncms.template1.calendar.day.tuesday"/>",
 "<fmt:message key="mvncms.template1.calendar.day.wednesday"/>",
 "<fmt:message key="mvncms.template1.calendar.day.thursday"/>",
 "<fmt:message key="mvncms.template1.calendar.day.friday"/>",
 "<fmt:message key="mvncms.template1.calendar.day.saturday"/>",
 "<fmt:message key="mvncms.template1.calendar.day.sunday"/>");

// short day names
Calendar._SDN = new Array
("<fmt:message key="mvncms.template1.calendar.day.sun"/>",
 "<fmt:message key="mvncms.template1.calendar.day.mon"/>",
 "<fmt:message key="mvncms.template1.calendar.day.tue"/>",
 "<fmt:message key="mvncms.template1.calendar.day.wed"/>",
 "<fmt:message key="mvncms.template1.calendar.day.thu"/>",
 "<fmt:message key="mvncms.template1.calendar.day.fri"/>",
 "<fmt:message key="mvncms.template1.calendar.day.sat"/>",
 "<fmt:message key="mvncms.template1.calendar.day.sun"/>");

// First day of the week. "0" means display Sunday first, "1" means display
// Monday first, etc.
Calendar._FD = 0;

// full month names
Calendar._MN = new Array
("<fmt:message key="mvncms.template1.calendar.month.january"/>",
 "<fmt:message key="mvncms.template1.calendar.month.february"/>",
 "<fmt:message key="mvncms.template1.calendar.month.march"/>",
 "<fmt:message key="mvncms.template1.calendar.month.april"/>",
 "<fmt:message key="mvncms.template1.calendar.month.long_may"/>",
 "<fmt:message key="mvncms.template1.calendar.month.june"/>",
 "<fmt:message key="mvncms.template1.calendar.month.july"/>",
 "<fmt:message key="mvncms.template1.calendar.month.august"/>",
 "<fmt:message key="mvncms.template1.calendar.month.septemper"/>",
 "<fmt:message key="mvncms.template1.calendar.month.october"/>",
 "<fmt:message key="mvncms.template1.calendar.month.november"/>",
 "<fmt:message key="mvncms.template1.calendar.month.december"/>");

// short month names
Calendar._SMN = new Array
("<fmt:message key="mvncms.template1.calendar.month.jan"/>",
 "<fmt:message key="mvncms.template1.calendar.month.feb"/>",
 "<fmt:message key="mvncms.template1.calendar.month.mar"/>",
 "<fmt:message key="mvncms.template1.calendar.month.apr"/>",
 "<fmt:message key="mvncms.template1.calendar.month.short_may"/>",
 "<fmt:message key="mvncms.template1.calendar.month.jun"/>",
 "<fmt:message key="mvncms.template1.calendar.month.jul"/>",
 "<fmt:message key="mvncms.template1.calendar.month.aug"/>",
 "<fmt:message key="mvncms.template1.calendar.month.sep"/>",
 "<fmt:message key="mvncms.template1.calendar.month.oct"/>",
 "<fmt:message key="mvncms.template1.calendar.month.nov"/>",
 "<fmt:message key="mvncms.template1.calendar.month.dec"/>");

// tooltips
Calendar._TT_en = Calendar._TT = {};
Calendar._TT["INFO"] = "About the calendar";

Calendar._TT["ABOUT"] =
"DHTML Date/Time Selector\n" +
"(c) dynarch.com 2002-2005 / Author: Mihai Bazon\n" + // don't translate this this ;-)
"For latest version visit: http://www.dynarch.com/projects/calendar/\n" +
"Distributed under GNU LGPL.  See http://gnu.org/licenses/lgpl.html for details." +
"\n\n" +
"Date selection:\n" +
"- Use the \xab, \xbb buttons to select year\n" +
"- Use the " + String.fromCharCode(0x2039) + ", " + String.fromCharCode(0x203a) + " buttons to select month\n" +
"- Hold mouse button on any of the above buttons for faster selection.";
Calendar._TT["ABOUT_TIME"] = "\n\n" +
"Time selection:\n" +
"- Click on any of the time parts to increase it\n" +
"- or Shift-click to decrease it\n" +
"- or click and drag for faster selection.";

Calendar._TT["PREV_YEAR"] = "<fmt:message key="mvncms.template1.calendar.prev_year"/>";
Calendar._TT["PREV_MONTH"] = "<fmt:message key="mvncms.template1.calendar.prev_month"/>";
Calendar._TT["GO_TODAY"] = "<fmt:message key="mvncms.template1.calendar.go_today"/>";
Calendar._TT["NEXT_MONTH"] = "<fmt:message key="mvncms.template1.calendar.next_month"/>";
Calendar._TT["NEXT_YEAR"] = "<fmt:message key="mvncms.template1.calendar.next_year"/>";
Calendar._TT["SEL_DATE"] = "<fmt:message key="mvncms.template1.calendar.sel_date"/>";
Calendar._TT["DRAG_TO_MOVE"] = "<fmt:message key="mvncms.template1.calendar.drag_to_move"/>";
Calendar._TT["PART_TODAY"] = "<fmt:message key="mvncms.template1.calendar.part_today"/>";

// the following is to inform that "%s" is to be the first day of week
// %s will be replaced with the day name.
Calendar._TT["DAY_FIRST"] = "<fmt:message key="mvncms.template1.calendar.day_first"/>";

// This may be locale-dependent.  It specifies the week-end days, as an array
// of comma-separated numbers.  The numbers are from 0 to 6: 0 means Sunday, 1
// means Monday, etc.
Calendar._TT["WEEKEND"] = "0,6";

Calendar._TT["CLOSE"] = "<fmt:message key="mvncms.template1.calendar.close"/>";
Calendar._TT["TODAY"] = "<fmt:message key="mvncms.template1.calendar.today"/>";
Calendar._TT["TIME_PART"] = "<fmt:message key="mvncms.template1.calendar.time_part"/>";

// date formats
Calendar._TT["DEF_DATE_FORMAT"] = "<fmt:message key="mvncms.template1.calendar.def_date_format"/>";
Calendar._TT["TT_DATE_FORMAT"] = "<fmt:message key="mvncms.template1.calendar.tt_date_format"/>";

Calendar._TT["WK"] = "wk";
Calendar._TT["TIME"] = "Time:";
//]]>
</script>

<script type="text/javascript">
//<![CDATA[
function clickFormSearch() {
  if (ValidateForm() == true ) {
    document.submitform.submit();
  }
}
function ValidateForm() {
  if (isBlank(document.submitform.key, '<fmt:message key="mvnforum.user.search.search_text" bundle="${forum}"/>')) return false;
  return true;
}
//]]>
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="1">
  <tr>
    <td class="bgsearchtitle"><fmt:message key="mvncms.template1.search.title"/></td>
  </tr>
  <tr>
    <td>
      <%if (isPortlet) { %>
        <form action="<%=urlResolver.encodeURL(request, response, "search", URLResolverService.ACTION_URL)%>" method="get" name="submitform">
              <%=urlResolver.generateFormAction(request, response, "search")%>
      <%} else { %>
        <form action="search" name="submitform">
      <%} %>
      <table width="100%" border="0" cellspacing="0" cellpadding="3" style="border-collapse: collapse;" class="timkiem">
        <%if (currentLocale.equals("vi")) {%>      
        <tr>
          <td width="27%" align="left"><fmt:message key="mvnforum.common.vietnamese_type" bundle="${forum}"/>:</td>
          <td align="left">
            <div align="left">
              <input id="him_auto" onclick="setMethod(0);" type="radio" name="viet_method" class="noborder"/> AUTO
              <input id="him_telex" onclick="setMethod(1);" type="radio" name="viet_method" class="noborder"/> TELEX
              <input id="him_vni" onclick="setMethod(2);" type="radio" name="viet_method" checked="checked" class="noborder"/> VNI
              <input id="him_viqr" onclick="setMethod(3);" type="radio" name="viet_method" class="noborder"/> VIQR
              <input id="him_off" onclick="setMethod(-1);" type="radio" name="viet_method" class="noborder"/> OFF 
            </div>
          </td>
        </tr>
        <%}%>
        <tr>
          <td valign="top"><fmt:message key="mvnforum.user.search.search_text" bundle="${forum}"/></td>
          <td>
            <table width="100%" cellspacing="0" cellpadding="3" class="notimkiem">
              <tr>
                <td align="left"><input class="textbox_off" size="0" type="text" name="key" value="<%=key%>" onkeydown="if(event.keyCode==13)clickFormSearch();" /></td>
              </tr>
              <%--
              <tr>
                <td align="left"><input name="mode" value="<%=ContentSearchQuery.SEARCH_WITH_AT_LEAST_ONE_WORD%>" type="radio" class="noborder"/>                
                  N&#7897;i dung t&#236;m c&#243; b&#7845;t k&#7923; t&#7915; n&#224;o trong chu&#7895;i t&#236;m ki&#7871;m
                </td>
              </tr>
              <tr>
                <td align="left"><input name="mode" value="<%=ContentSearchQuery.SEARCH_WITH_EXACT_PHRASE%>" type="radio" class="noborder"/>
                  T&#236;m ch&#237;nh x&#225;c c&#7909;m t&#7915;
                </td>
              </tr>
              <tr>
                <td align="left"><input name="mode" value="<%=ContentSearchQuery.SEARCH_WITH_ALL_WORDS%>" type="radio" class="noborder"/>
                  N&#7897;i dung t&#236;m ph&#7843;i ch&#7913;a t&#7845;t c&#7843; c&#225;c t&#7915;
                </td>
              </tr>
              --%>
            </table>
          </td>
        </tr>
        <tr>
          <td align="left"><label for="channel"><fmt:message key="mvncms.template1.common.channel"/></label></td>
          <td align="left">
            <select class="textbox_off" id="channel" name="channel">
              <option value="<%=webHandlerManager.getPropertyInt(CDSConstants.PROPERTY_ROOT_CHANNEL_ID)%>" selected="selected"><fmt:message key="mvncms.template1.search.channel.all_channels"/></option>
              <% 
              for (Iterator<String[]> channelsIter = channels.iterator(); channelsIter.hasNext(); ) { 
                String[] channel1 = channelsIter.next();
                String channelNames = channel1[0];
                int channelIDs = Integer.parseInt(channel1[1]);
              %>
                <option value="<%=channelIDs%>"><%=channelNames%></option>
              <%}%>
            </select>
          </td>
        </tr>
        <tr>
          <td align="left"><label for="scope"><fmt:message key="mvncms.template1.search.scope.scope_in_content"/></label></td>
          <td align="left">
            <select name="scope" id="scope" class="textbox_off">
              <option value="<%=ContentSearchQuery.SEARCH_BOTH%>"><fmt:message key="mvncms.template1.search.scope.all"/></option>
              <option value="<%=ContentSearchQuery.SEARCH_ONLY_TITLE%>"><fmt:message key="mvncms.template1.common.content.title"/></option>
              <option value="<%=ContentSearchQuery.SEARCH_ONLY_BODY%>"><fmt:message key="mvncms.template1.common.content.body"/></option>
            </select>
          </td>
        </tr>
        <tr>
          <td align="left"><label for="sort"><fmt:message key="mvnforum.common.sort_by" bundle="${forum}"/></label></td>
          <td align="left">
            <select name="sort" id="sort" class="textbox_off">
              <option value="<%=ContentSearchQuery.SEARCH_SORT_DEFAULT%>"><fmt:message key="mvnforum.user.search.sort.default" bundle="${forum}"/></option>
              <option value="<%=ContentSearchQuery.SEARCH_SORT_TIME_DESC%>"><fmt:message key="mvnforum.user.search.sort.time_desc" bundle="${forum}"/></option>
              <option value="<%=ContentSearchQuery.SEARCH_SORT_TIME_ASC%>"><fmt:message key="mvnforum.user.search.sort.time_asc" bundle="${forum}"/></option>
            </select>
          </td>
        </tr>
        <tr>
          <td align="left"><fmt:message key="mvncms.template1.search.from_date"/></td>
          <td align="left"><input type="text" name="fromdate" id="f_date_c" readonly="readonly" class="textbox_off" />&nbsp;<img src="<%=cdsTemplate%>/jscalendar/img.gif" id="f_trigger_c" title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''" style=" vertical-align:top" alt=""/></td>
        </tr>
        <tr>
          <td align="left"><fmt:message key="mvncms.template1.search.to_date"/></td>
          <td align="left"><input type="text" name="todate" id="t_date_c" readonly="readonly" class="textbox_off" />&nbsp;<img src="<%=cdsTemplate%>/jscalendar/img.gif" id="t_trigger_c" title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''" style=" vertical-align:top" alt=""/></td>
        </tr>
        <tr>
          <td colspan="2" align="center"><input name="submitsearch" value="<fmt:message key="mvnforum.common.action.search" bundle="${forum}"/>" type="button" onclick="clickFormSearch();" class="seealso" />
            <input name="Reset" type="reset" class="seealso" value="<fmt:message key="mvnforum.common.action.reset" bundle="${forum}"/>" />
          </td>
        </tr>
      </table>
      </form>
      <pg:pager
        url="search"
        items="<%= totalContents %>"
        maxPageItems="<%= resultPerPage %>"
        isOffset="true"
        export="offset,currentPageNumber=pageNumber"
        scope="request">
        <pg:param name="key"/>
        <%--<pg:param name="mode" value="<%=String.valueOf(mode)%>"/>--%>
        <pg:param name="channel"/>
        <pg:param name="scope"/>
        <pg:param name="sort"/>
        <pg:param name="fromdate"/>
        <pg:param name="todate"/>
        
      <table width="100%" border="0" cellspacing="0" cellpadding="3" style="border-collapse: collapse;">          
        <%if (contentBeans.size() > 0) {%>
          <tr>
            <td colspan="2" class="kqtimkiem"><span class="nosearchhi"><fmt:message key="mvnforum.user.searchresult.title" bundle="${forum}"/></span></td>
          </tr>
          <tr>
            <td colspan="2" align="left">
              <table id="searcharea" border="0" cellpadding="3" cellspacing="0" width="100%" class="notimkiem">
                <tbody>
                <%
                String _highlightKey = "";
                if (highlightKey.length() > 0) {
                  _highlightKey = "?hl=" + Encoder.encodeURL(highlightKey);
                }
                
                for (Iterator iterator = contentBeans.iterator(); iterator.hasNext(); ) {
                  ContentBean moreContentBean = (ContentBean) iterator.next();
                  cdsURL = new CDSURL(moreContentBean.getDefaultChannelID(), moreContentBean.getContentID(), CDSURL.CDS_URL_PAGE_VIEW, null);
                  String viewURL = cdsURLResolver.encode(request, cdsURL, webHandlerManager) + _highlightKey;
                %>
                <pg:item>
                  <tr>
                    <td>&nbsp;<img src="<%=cdsTemplate%>/images/arrow2.gif" width="10" height="9" alt=""/> <a href="<%=viewURL%>" class="listcontents_title"><%= ContentUtil.getContentTitle(moreContentBean, currentLocale)%></a><br />
                      <%=ContentUtil.getContentSummary(request, moreContentBean, currentLocale)%>
                    </td>
                  </tr>
                </pg:item>
                <%} //for %>
                </tbody>
              </table>
            </td>
          </tr>
        <%} else {
          if (key.length() > 0) {%>
          <tr>
            <td colspan="2"><div align="center"><font color="Red"><fmt:message key="mvncms.template1.searchresult.no_content"/></font></div></td>
          </tr>
          <%}
          }%>
      </table>
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
          <td><%@ include file="inc_pager.jsp"%></td>
        </tr>
      </table>
      </pg:pager>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>

<script type="text/javascript">
//<![CDATA[
    InitParam();
    Calendar.setup({
        inputField     :    "f_date_c",
        electric       :    false,
        ifFormat       :    "%d/%m/%Y",
        daFormat       :    "%Y/%m/%d",
        button         :    "f_trigger_c",
        align          :    "Tl",
        singleClick    :    true
    });
    Calendar.setup({
        inputField     :    "t_date_c",
        electric       :    false,
        ifFormat       :    "%d/%m/%Y",
        daFormat       :    "%Y/%m/%d",
        button         :    "t_trigger_c",
        align          :    "Tl",
        singleClick    :    true
    });
  <%if (highlightKey.length() > 0 && contentBeans.size() > 0) {%>    
    searchhi.highlightWords(document.getElementById("searcharea"),"<%=StringUtil.escapeJavaScript(highlightKey)%>");
  <%}%>    
//]]>
</script>