<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/im/lobbymessagesx.jsp,v 1.13 2009/03/11 09:11:54 trungth Exp $
 - $Author: trungth $
 - $Revision: 1.13 $
 - $Date: 2009/03/11 09:11:54 $
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
<%@ page import="net.myvietnam.mvncore.util.ParamUtil" %>
<%@ page import="net.myvietnam.mvncore.util.DateUtil" %>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter" %>
<%@ page import="com.mvnforum.MVNForumConfig" %>
<%@ page import="java.util.*" %>
<%@ page import="com.mvnforum.auth.OnlineUser" %>
<%@ page import="org.jivesoftware.smack.XMPPConnection" %>
<%@ page import="org.jivesoftware.smack.packet.Message" %>
<%@ page import="java.util.Iterator"%>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - Lobby Chat Windows</mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
 
<style type="text/css">
.whatever {
    margin-bottom: 2px;
    margin-top: 2px 
    border: white solid 1px;
    white-space: nowrap
    overflow-x: auto; 
    overflow-y: auto;
    background: white;
    vertical-align: 25%; 
    font-size: 90%; 
    cursor: default;
}
.whatever:hover {
    border: rgb(115, 166, 255) solid 1px;
    background: #ECEAEA;
}
</style>
    
</mvn:head>
<link href="<%=contextPath%>/mvnplugin/mvnforum/css/mystyle.css" rel="stylesheet" type="text/css">
<mvn:body>
    <script type="text/javascript">
      var time = true;
      var timer = 0;
      var t;
      var newData = null;
      var test = false;
            
      var req = null;
      
      var READY_STATE_UNINITIALIZED = 0;
      var READY_STATE_LOADING = 1;
      var READY_STATE_LOADED = 2;
      var READY_STATE_INTERACTIVE = 3;
      var READY_STATE_COMPLETE = 4;
      
        window.onresize=resize; 
        
        function resize() {
            var windowheight = window.innerHeight;
            var windowwidth = window.innerWidth;
            var height = 300 + (windowheight-400);
            document.getElementById('outputMessage').style.width = windowwidth;
            document.getElementById('outputMessage').style.height = height;
          }

        function mouseOver() {
            //alert("document.getElementById('send').style.border : "+document.getElementById('send').style.border);
            document.getElementById('send').style.border="2px solid rgb(115, 166, 255)";
            document.getElementById('send').style.background="#ECEAEA";
            //alert("document.getElementById('send').style.border : "+document.getElementById('send').style.border);
          }
          function mouseOut() {
            document.getElementById('send').style.border="2px solid white";
            document.getElementById('send').style.background="white";
          }
          
          function mouseOverHideShow() {
            document.getElementById('hideshow').style.border="2px solid rgb(115, 166, 255)";
            document.getElementById('hideshow').style.background="#ECEAEA";
          }
          function mouseOutHideShow() {
            document.getElementById('hideshow').style.border="2px solid white";
            document.getElementById('hideshow').style.background="white";
          }
        
      function sendRequest(url, params, HttpMethod) {
        //test = true;
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
          //newData = data;
          updateData(data);
        } else {
          data="loading...["+ready+"]";
        }
      }
      
      function checkEnter(e) {
        var characterCode; //literal character code will be stored in this variable
        
        if (e && e.which) { //if which property of event object is supported (NN4)
          e = e;
          characterCode = e.which; //character code is contained in NN4's which property
        } else{
          e = event;
          characterCode = e.keyCode; //character code is contained in IE's keyCode property
        }

        if (characterCode == 13) { //if generated character code is equal to ascii 13 (if enter key)
             sendRequest(sendMessage()); 
             document.getElementById('data').value = '';
            return false;
        }
      }

      function updateData(data) {
         //alert('updateData'); 
        if (data != null) {
        
        //var myOutput = document.getElementById('output').innerHTML;
        //myOutput.length
        var datas = new Array();
        var dataParts = new Array();
        datas = data.split("<br/>");
        
        if (datas.length >1) {
        var newMessages = document.createElement("div");
        for (i = 0; i < datas.length-1; i++) {
          
          data = datas[i];
          
          dataParts = data.split("*");
          //alert("dataParts :  " + dataParts);
          //alert("dataParts[0] :  " + dataParts[0]);
          //alert("dataParts[1] :  " + dataParts[1]);
          if (dataParts != null) {
          var newRow = document.createElement("div");

          var newtime = document.createElement("span");
          newtime.setAttribute("class", 'timeStyle');
          var mytime = document.createTextNode(dataParts[0]+ " : ");
          newtime.appendChild(mytime);
          newRow.appendChild(newtime);

          var newfrom = document.createElement("span");
          newfrom.setAttribute("class", 'userIdStyle');
          var from = document.createTextNode(dataParts[1] + " : ");
          newfrom.appendChild(from);
          newRow.appendChild(newfrom);

          var newbody = document.createElement("span");
          newbody.setAttribute("class", 'contentStyle');
          var body = document.createTextNode(dataParts[2]);
          newbody.appendChild(body);
          newRow.appendChild(newbody);
          
          newMessages.appendChild(newRow);
            
            //output.value = data;
           //output.scrollTop = output.scrollHeight - output.clientHeight;
          //}          
                }
          document.getElementById('output').innerHTML = "";
          document.getElementById('output').appendChild(newMessages);
              }
            }
          }
      }
      
      function getLogMessage() {
        test =true;
        var url = "<%=urlResolver.encodeURL(request, response, "lobbymessages")%>";
        return url;
      }
      
      function autoRefresh() {
          if (test == false) {
            sendRequest(getLogMessage());
            setTimeout("autoRefresh()",5000); 
          } else {
            sendRequest(getLogMessage());
            //sendRequest(getLogMessage());
            setTimeout("autoRefresh()",2000);
          }          
     }
      
      function hideTime() {
        var data = document.getElementsByTagName('span');
        for (var element = 0; element < data.length; element++) {
          if (data[element].className == "timeStyle") {
            data[element].className="timeStyle hidden";
          } 
        }
        document.getElementById('hideshow').value="ShowTime";
      }
      
      function showTime() {
        var data = document.getElementsByTagName('span');
        for (var element = 0; element < data.length; element++) {
          if (data[element].className == "timeStyle hidden") {
            data[element].className="timeStyle";
          } 
        }
        document.getElementById('hideshow').value="HideTime";
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
      function timedCount() {
          timer = timer + 1;
          if (timer == 5) {
            clearTimeout(t)
          }
          alert("timer1 : " + timer);
          t=setTimeout("timedCount()",1000)
      }
    </script>
    
<table style="width:100%; height:15px;" cellspacing="0" cellpadding="0" class="noborder">
    <tr style="width:100%; background-color: rgb(115, 166, 255);">
      <td class="receiver">
        <span>lobbychat</span>
       </td>
    </tr>
  </table>
    
  <div class="scrollable-table-area" style="width:400px; height:300px;" id="outputMessage">
  <table style="width:100%" cellspacing="0" cellpadding="0" class="noborder">
    <tr style="width:100%">
      <td valign="top" class="output">
      <div id="output"></div>
      </td>
    </tr>
  </table>
  </div>
    
<table style="width:100%;" cellspacing="0" cellpadding="0" border="0">
    <tr style="width:100%; height:30px;">
      <td>
      <div>
        <span class="whatever" style="float: right; margin-right: 2px;" onclick="hideShowTime();" id="hideshow" onmouseover="mouseOverHideShow();" onmouseout="mouseOutHideShow();"> ShowHideTime </span> 
      </div>
    </td>
    </tr>
  </table>
 
<script type='text/javascript'>
  autoRefresh();
</script>

</mvn:body>
</mvn:html>
</fmt:bundle>
