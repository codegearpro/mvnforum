<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/im/groupchatx.jsp,v 1.18 2009/09/15 03:18:00 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.18 $
 - $Date: 2009/09/15 03:18:00 $
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
<%@ page import="com.mvnforum.MVNForumConfig" %>
<%@ page import="com.mvnforum.auth.OnlineUser" %>
<%@ page import="org.jivesoftware.smack.Roster" %>
<%@ page import="org.jivesoftware.smack.RosterEntry" %>
<%@ page import="org.jivesoftware.smack.XMPPConnection" %>
<%@ page import="org.jivesoftware.smack.packet.Message" %>
<%@page import="java.util.Iterator"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - Group Chat Windows</mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css">
<link href="<%=contextPath%>/mvnplugin/mvnforum/css/HideShow.css" rel="stylesheet" type="text/css">
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">
<%@ include file="header.jsp"%>

<br/>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  MVN Instant Message
</div>

     <% 
          String room = request.getParameter("room");
      %>
      
    <script type="text/javascript">
      var time = true;
                
      var req = null;
      var req = null;
      var input = null;
      var READY_STATE_UNINITIALIZED = 0;
      var READY_STATE_LOADING = 1;
      var READY_STATE_LOADED = 2;
      var READY_STATE_INTERACTIVE = 3;
      var READY_STATE_COMPLETE = 4;
      function sendRequest(url, params, HttpMethod) {
        if (!HttpMethod) {
          HttpMethod="GET";
        }
        req = initXMLHTTPRequest();
        if (req) {
               req.onreadystatechange = onReadyState;
          req.open(HttpMethod, url, true);
          req.send(params);
        }
      }
      function initXMLHTTPRequest() {
        var xRequest = null;
        if (window.XMLHttpRequest) {
          xRequest = new XMLHttpRequest();
        } else if (window.ActiveXObject) {
          xRequest = new ActiveXObject("Microsoft.XMLHTTP");
        }
        return xRequest;
      }
      function onReadyState() {
        var ready = req.readyState;
        var data = null;
        if (ready == READY_STATE_COMPLETE) {
          data = req.responseText;
          updateData(data);
        } else {
          data="loading...["+ready+"]";
        }
      }
      function updateData(data) {
        if (data != null) {
        var systemTime = new Date().toUTCString();
        var datas = new Array();
        var dataParts = new Array();
        datas = data.split("<br/>");
        alert("datas.length :  " + datas.length);
        if (datas.length >1) {
        for (i = 0; i < datas.length-1; i++) {
          
          data = datas[i];
          alert("data :  " + data);
          dataParts = data.split(":");
          //alert("dataParts :  " + dataParts);
          //alert("dataParts[0] :  " + dataParts[0]);
          //alert("dataParts[1] :  " + dataParts[1]);
          if (dataParts != null) {
          var newRow = document.createElement("div");

          var newtime = document.createElement("span");
          newtime.setAttribute("class", 'timeStyle');
          var mytime = document.createTextNode(systemTime);
          newtime.appendChild(mytime);
          newRow.appendChild(newtime);

          var newfrom = document.createElement("span");
          newfrom.setAttribute("class", 'userIdStyle');
          var from = document.createTextNode(dataParts[0]);
          newfrom.appendChild(from);
          newRow.appendChild(newfrom);

          var newbody = document.createElement("span");
          newbody.setAttribute("class", 'contentStyle');
          var body = document.createTextNode(dataParts[1]);
          newbody.appendChild(body);
          newRow.appendChild(newbody);

          document.getElementById('output').appendChild(newRow);
          //output.value = data;
          //output.scrollTop = output.scrollHeight - output.clientHeight;
        }
        }
}
          }
      }
      
      function sendMessage() { 
        if (CheckForm() == true) {
      var url = "<%=urlResolver.encodeURL(request, response, "process_groupchat?room=" + room)%>";
      message = document.getElementById('data').value;
      url = url + "&sendbt=true&message=" + message;
      return url;
        }
      }
      
      function getLogMessage() {
        var url = "<%=urlResolver.encodeURL(request, response, "process_groupchat?refresh=true&room=" + room)%>";
        //var t=setTimeout(,1000);
        return url;
      }
      
      function autoRefresh() {
        //alert("autoRefresh");
        sendRequest(getLogMessage());
        setTimeout("autoRefresh()",10000);
      }
      
      function CheckForm() {
        data = document.getElementById('data').value;
        if (data == "" ) {
          alert("Please complete this form");
          return false;
        }
        return true;
      }
      
      function SubmitForm() {
      
        if (CheckForm() == true) {
          //document.submitform.submitbutton.disabled=true;
         
          document.submitform.submit();
        }
        
      }
      
      function hideTime() {
        var data = document.getElementsByTagName('span');
        for (var element = 0; element < data.length; element++) {
          if (data[element].className == "timeStyle") {
            data[element].className="timeStyle hidden";
          } 
        }
        document.getElementById('button').value="ShowTime";
      }
      
      function showTime() {
        var data = document.getElementsByTagName('span');
        for (var element = 0; element < data.length; element++) {
          if (data[element].className == "timeStyle hidden") {
            data[element].className="timeStyle";
          } 
        }
        document.getElementById('button').value="HideTime";
      }
      
      function hideShowTime() {
        if (time == true) {
          hideTime();
          time = false;
        } else {
          showTime();
          time = true;
        }
      }
      
      function getMessage() {
        var systemTime = new Date().toUTCString();
        document.submitform.action="<%=urlResolver.encodeURL(request, response, "process_groupchat?room=" + room)%>";
        document.submitform.submit();
      }

      function addData() {

        var systemTime = new Date().toUTCString();
        
        var newRow = document.createElement("div");
        
        
        <% 
            //XMPPConnection con = (XMPPConnection)onlineUser.getXMPPConnection();
            //String userId = con.getUser();
            Collection messages = (Collection)request.getAttribute("data");

                if (messages != null) {
                      for (Iterator iter = messages.iterator();iter.hasNext();) {
                          Message data = (Message)iter.next();
                         String from = data.getFrom();
                         String body = data.getBody();
                         System.out.println(from);
                         System.out.println(body);
                         %>
       newRow.innerHTML = "hello";
          document.getElementById('output').appendChild(newRow);
          <%
                  } 
            }
    %>
      }
      
    </script>
    
    <!--<div id="output"></div>-->
<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
     <%=urlResolver.generateFormAction(request, response, "process_groupchat")%>
<mvn:cssrows>
  <tr class="portlet-section-header">
      <td colspan="2"><%=room %></td>
  </tr>
  
  <tr class="<mvn:cssrow/>">
  <td width="100%" align="right">
    <table width="100%">
    <tr width="100%" class="<mvn:cssrow/>">
          <td> 
            <textarea rows="10" cols="120" id="output" name="output" readonly="readonly"></textarea> 
          </td>
    </tr>
    </table>
    </td>
    <td align="left">
      <table>
        <tr class="<mvn:cssrow/>"> 
        <td>
          <form action="">
        <select name="group">
                <% 
                 XMPPConnection con = (XMPPConnection)onlineUser.getXMPPConnection();
                Roster roster = con.getRoster();
                  Iterator rosterEntries = roster.getEntries();
          
                 while(rosterEntries.hasNext()) {
                  RosterEntry entry = (RosterEntry)rosterEntries.next();
                %>
            <option name="groupname" value="<%=entry.getUser()%>"><%=entry.getUser()%></option>
               <% } %>
             
          </select> 
          <input type="button" name="invite" id="invite" value="Invite">
          </form>
         </td>
         </tr>
           
         <tr class="<mvn:cssrow/>">
         <td>
          <textarea rows="10" cols="30" id="participants" name="participants" readonly="readonly"></textarea> 
         </td>
         </tr>
      </table>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>
       <label for="data">Message</label> : <input type="text" id="data" name="data">
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>
     <input type="button" name="submitbutton" value="Send" onclick="sendRequest(sendMessage()); document.getElementById('data').value = '';" class="portlet-form-button">
     <input type="button" id="button" value="Hide Time" onclick="hideShowTime();" class="portlet-form-button">
     <input type="button" id="getbutton" value="Get Message" onclick="sendRequest(getLogMessage());" class="portlet-form-button">  
    </td>
  </tr>
</mvn:cssrows>
</table>

<br/>  
<%@ include file="footer.jsp"%>

<!--<script type='text/javascript'>
    autoRefresh();
  </script>-->
</mvn:body>
</mvn:html>
</fmt:bundle>
