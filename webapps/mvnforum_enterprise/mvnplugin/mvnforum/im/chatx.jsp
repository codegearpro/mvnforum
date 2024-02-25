<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/im/chatx.jsp,v 1.26 2009/09/15 03:18:00 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.26 $
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

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="org.jivesoftware.smack.Roster" %>
<%@ page import="org.jivesoftware.smack.RosterGroup" %>
<%@ page import="org.jivesoftware.smack.packet.Presence" %>
<%@ page import="org.jivesoftware.smack.XMPPConnection" %>
<%@ page import="com.mvnforum.auth.OnlineUser" %>
<%@ page import="com.mvnforum.enterprise.im.Group" %>
<%@ page import="com.mvnforum.enterprise.im.Buddy" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - Chat Windows</mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css">
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>

<script type="text/javascript">

      var req = null;
      
      var READY_STATE_UNINITIALIZED = 0;
      var READY_STATE_LOADING = 1;
      var READY_STATE_LOADED = 2;
      var READY_STATE_INTERACTIVE = 3;
      var READY_STATE_COMPLETE = 4;
      
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
          data = req.responseXML;
          //newData = data;
                    //alert("data : " + data);
          updateData(data);
                    //alert("after update");
        } else {
          data="loading...["+ready+"]";
        }
      }

      function updateData(data) {

        if (data == null) {
            return;
        }
        
        var docRoot = data.getElementsByTagName("users")[0]; //users Element
       
        if (docRoot == null) {
            alert("Cannot find node 'users'");
        }
                
        var usersArray = docRoot.childNodes;
        
        if (usersArray == null) {
            return;
        }
       
        var user;
        var receiver;
        for (var i = 0; i < usersArray.length; i++) {
            user = usersArray[i];
            if (user.nodeType == ELEMENT_NODE) { //ELEMENT_NODE
                receiver = usersArray[i].childNodes[0].nodeValue;
                alert(" value cua user thu " + i + " la : " + receiver);
                url = "<%=urlResolver.encodeURL(request, response, "pre_process_chat")%>";
                url = url + "?receiver=" + receiver;
                window.open(url, receiver, "location=1,status=1,scrollbars=1, width=400,height=400 resizable=yes"); 
            }
        }
      }

      function getWaitingList() {
        var url = "<%=urlResolver.encodeURL(request, response, "notifyChat?command=getwaittinglist")%>";
        return url;
      }
      
      function autoRefresh() {
          sendRequest(getWaitingList());
          setTimeout("autoRefresh()",10000);
     }

   //  
  function CheckInputForm() {
    var user = document.submitaddform.user.value;
    var username = document.submitaddform.username.value;
    var group = document.submitaddform.group.value;
    
      if (user == "" ) {
        alert ("The parameter 'User' is not allowed to be empty! Please try again.");
        return false;
      } else if (username == "" ) {
        alert ("The parameter 'Name' is not allowed to be empty! Please try again.");
        return false;
      } else if (group == "" ) {
        alert ("Please choose group name");
        return false;
      }
      return true;
  }
  
  
  function SubmitForm() {
    if (CheckInputForm() == true) {
      document.submitaddform.submit();
      
    }
  }

  function CheckGroupForm() {
    var group = document.groupform.group.value;
      if (group == "" ) {
        alert ("The parameter 'Group' is not allowed to be empty! Please try again.");
        return false;
      }
      return true;
  }
  
  function SubmitGroupForm() {
    
    if (CheckGroupForm() == true) {
      document.groupform.submit();
    }
  }
  
  function customStatus() {
    if (document.getElementById('status').value == "Custom Message") {
      document.getElementById('newStatus').innerHTML = "<label for='statusName'>Custom Status</label> : <input type='text' id='statusName' name='statusName'>" + "<input type='button' id='statusButton' value='Add Status' onclick='addStatus()'>";
    }
  }
  
  function addStatus() {
    var option = document.createElement("option");
    var newStatus = document.getElementById('statusName').value;
    option.setAttribute("name", newStatus);
    option.setAttribute("value", newStatus);
    var status = document.createTextNode(newStatus);
    option.appendChild(status);
    document.getElementById('status').appendChild(option);
    document.getElementById('newStatus').innerHTML = "";
  }

  function checkCreateRoom() {
     if (document.getElementById('room').value == "") {
        alert("The room field requires not empty");
       return false;
    } else if (document.getElementById('userRoom').value == "") {
        alert("The user field requires not empty");
       return false;
    }
    return true;
  }

  function submitCreateRoom() {
    if (checkCreateRoom() == true) {
      document.groupchatform.submit();
      document.getElementById('groupchat').innerHTML = "";
      
    }
  }
</script>

<br/>

<div class="nav center">
  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" class="middle" />
  <a href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
  MVN Instant Message
</div>

<br/>
<table width="95%" align="center">
  <tr>
    <td class="highlight">Control_Panel</td>
  </tr>
</table>
<table class="tborder" width="95%" align="center" cellpadding="3" cellspacing="1">
  <tr class="pagedesc">
    <td valign="top" nowrap="nowrap">
      <a href="<%=urlResolver.encodeURL(request, response, "online_users")%>" class="command">Online Users</a>
    </td>
    <td valign="top" nowrap="nowrap">
      <% if (onlineUser.getXMPPConnection() != null) { %> 
        <a class="command" href="#" onclick="window.open ('<%=urlResolver.encodeURL(request, response, "pre_lobbychat")%>', 'lobbychat','location=1,status=1,scrollbars=1, width=400,height=400 resizable=yes');">Lobby Chat </a>
      <%}%>

    </td> 
  </tr>
</table>
<br/>
<table width="95%" align="center">
  <tr>
    <td class="highlight">Status</td>
  </tr>
</table>
  <div class="pagedesc center">
    Your current status is 
    <%
        if (onlineUser.getXMPPConnection() == null) {
      %>
        &nbsp;<font color="#FF0080">Offline</font>&nbsp;&nbsp; - &nbsp;<a href="<%=urlResolver.encodeURL(request, response, "process_login_chat")%>" class="command">Login to chat</a>
      <% } else { %>
       &nbsp;<font color="#008000">Online</font>&nbsp;&nbsp; - &nbsp; <a href="<%=urlResolver.encodeURL(request, response, "logout_chat")%>" class="command" onclick="return window.confirm('Do you want to sign off ?');"><fmt:message key="mvnforum.common.action.logout"/></a>
  
      <% } %> 
  </div>

<%
XMPPConnection con = (XMPPConnection)onlineUser.getXMPPConnection();
Roster roster = con.getRoster();
  if (onlineUser.getXMPPConnection() != null) { %>
<script type="text/javascript">
function createRoom() {

    <%
        String entryx = ((XMPPConnection)onlineUser.getXMPPConnection()).getUser();
        System.out.println("entryx : " + entryx);
        String [] entries = entryx.split("@");
        String loginId = entries[0];
%>
    document.getElementById('groupchat').innerHTML = "<label for='room'>Room</label> : <input type='text' id='room' name='room'>" + "&nbsp;&nbsp;&nbsp;" + "User : <select name='userRoom' id='userRoom'><option value="+"<%=loginId%>"+">"+"<%=loginId%>"+"</option></select>" + "&nbsp;&nbsp;&nbsp;" + "<input type='button' id='roomButton' value='Create Chat Room' onclick='submitCreateRoom();'>";
  }
</script>

<p>
<form action="<%=urlResolver.encodeURL(request, response, "add_buddy", URLResolverService.ACTION_URL)%>" name="submitaddform" method="post">
      <%=urlResolver.generateFormAction(request, response, "add_buddy")%>
    <table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
    <mvn:cssrows>
      <tr class="portlet-section-header">
        <td colspan="2">Add Buddy</td>
      </tr>
      <tr class="<mvn:cssrow/>">
        <td>
          <label for="user">User</label>  : <input type="text" name="user" id="user">
    &nbsp;&nbsp;&nbsp;<label for="username">Name</label>  : <input type="text" name="username" id="username"> 
    &nbsp;&nbsp;&nbsp;Group  : <select name="group">
      <% 
       
        Iterator groupsIter = roster.getGroups();
        while(groupsIter.hasNext()) {
            RosterGroup rosterGroup = (RosterGroup)groupsIter.next();
            if (rosterGroup.getName() != null) {
       %>
         <option name="groupname" value="<%=rosterGroup.getName()%>"><%=rosterGroup.getName()%></option>
        <% } %>
      <% } %>
    </select> 
        <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.common.action.add"/>" onclick="SubmitForm();" class="portlet-form-button">
        </td>
      </tr>
    </mvn:cssrows>
    </table>
</form>   

<p>
<form action="<%=urlResolver.encodeURL(request, response, "add_group", URLResolverService.ACTION_URL)%>" name="groupform" method="post">
      <%=urlResolver.generateFormAction(request, response, "add_group")%>
   <table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
   <mvn:cssrows>
      <tr class="portlet-section-header">
        <td colspan="2">Add Group</td>
      </tr>
      <tr class="<mvn:cssrow/>">
        <td>
          <label for="group">Group</label>  : <input type="text" name="group" id="group">
    
        <input type="button" name="addgroupbutton" value="<fmt:message key="mvnforum.common.action.add"/>" onclick="SubmitGroupForm();" class="portlet-form-button">
        </td>
      </tr>
    </mvn:cssrows>
    </table>
</form> 

<form action="<%=urlResolver.encodeURL(request, response, "remove_group", URLResolverService.ACTION_URL)%>" name="removegroupform" method="post">
      <%=urlResolver.generateFormAction(request, response, "remove_group")%>
   <table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
   <mvn:cssrows>
      <tr class="portlet-section-header">
        <td colspan="2">Remove Group</td>
      </tr>
      <tr class="<mvn:cssrow/>">
        <td>
          Group  : <select name="removegroup">
      <% 
        
        Iterator groupIters = roster.getGroups();
        while(groupIters.hasNext()) {
            RosterGroup allgroup = (RosterGroup)groupIters.next();
            if (allgroup.getName() != null) {
       %>
         <option name="groupname" value="<%=allgroup.getName()%>"><%=allgroup.getName()%></option>
        <% } %>
      <% } %>
    </select> 
            <input type="submit" name="removegroupbutton" value="<fmt:message key="mvnforum.common.action.remove"/>" class="portlet-form-button">
        </td>
      </tr>
    </mvn:cssrows>
    </table>
</form> 

<form action="<%=urlResolver.encodeURL(request, response, "set_status", URLResolverService.ACTION_URL)%>" name="statusform" method="post">
      <%=urlResolver.generateFormAction(request, response, "set_status")%>
   <table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
   <mvn:cssrows>
      <tr class="portlet-section-header">
        <td colspan="2">Status</td>
      </tr>
      <tr class="<mvn:cssrow/>"> 
        <td>
         Status : <select id="status" name="status" onchange="customStatus();">
         <option name="Available" value="Available">Available</option>
         <option name="Away" value="Away">Away</option>
         <option name="Chat" value="Chat">Chat</option>
         <option name="Do_not_disturb" value="Do_not_disturb">Do_not_disturb</option>
         <option name="Extended_away" value="Extended_away">Extended_away</option>
         <option name="Invisible" value="Invisible">Invisible</option>
          <option name="Custom Message" value="Custom Message">Custom Message</option>
    </select> some text
            <input type="submit" name="statusgroupbutton" value="Change" class="portlet-form-button">
        </td>
      </tr>
      <tr class="<mvn:cssrow/>">
        <td id="newStatus">
          
        </td>
      </tr>
    </mvn:cssrows>
    </table>
</form> 

<form action="<%=urlResolver.encodeURL(request, response, "groupchat", URLResolverService.ACTION_URL)%>" name="groupchatform" method="post">
      <%=urlResolver.generateFormAction(request, response, "groupchat")%>
   <table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
   <mvn:cssrows>
    <tr class="portlet-section-header">
      <td colspan="2">Chat Room</td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td>
        <input type="button" id="chatroom" name="chatroom" value="Chat Room" onclick="createRoom()">
      </td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td id="groupchat"></td>
    </tr>
  </mvn:cssrows>
  </table>
</form>


<!--<form>
  <input type="button" id="chatroom" name="chatroom" value="Chat Room" onclick="createRoom()">
</form>

<center><div id="groupchat"></div></center>-->

<br/>
<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2">Action</td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>
      <a href="<%=urlResolver.encodeURL(request, response, "view_online_buddies")%>" class="command">Online Buddies</a>
    &nbsp;&nbsp; - &nbsp;<a href="<%=urlResolver.encodeURL(request, response, "view_all_buddies")%>" class="command">All Buddies </a>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>
      <a href="<%=urlResolver.encodeURL(request, response, "view_empty_groups")%>" class="command">Empty Groups</a>
      &nbsp;&nbsp; - &nbsp;<a href="<%=urlResolver.encodeURL(request, response, "view_noempty_groups")%>" class="command"> No Empty Groups</a>
    </td>
  </tr>
</mvn:cssrows>
</table>

<br/>
<table class="tborder" width="95%" cellspacing="1" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td>Groups</td>
    <td>Budies</td>
    <td align="center">Send Message</td>
    <td align="center">Status</td>
    <td align="center"><fmt:message key="mvnforum.common.action.remove"/></td>
  </tr>

    <%
      String emptygroup = (String)request.getAttribute("emptygroups");
      ArrayList collection = (ArrayList)request.getAttribute("groupEntries");
      
      if (emptygroup == "true") {
          System.out.println("emptygroup : " + emptygroup); 
      if (collection != null) {
      Iterator groupIter = collection.iterator();
      
        //Loop through each group and display its members
          while(groupIter.hasNext()) {
            Group group = (Group)groupIter.next();
            System.out.println("Group: " + group.getName());
            System.out.println("group.getEntryCount(): " + group.getEntryCount());
            if (group.getEntryCount() == 0) {
 %>
              
  <tr class="<mvn:cssrow/>">  
    <td>
    <%=group.getName()%>
  </td>
      <td>
        
  </td>
      <td>
        
  </td>
      <td>
        
  </td>
      <td>
        
    </td>
    </tr> 

          <%  } else {
       
       //Get the members of each group.
            Collection col = group.getEntries();
        if (col != null) {
            Iterator groupEntries = col.iterator();
            //Iterator groupEntries = group.getEntries();
            while(groupEntries.hasNext()) {
                Buddy entry = (Buddy)groupEntries.next();

                System.out.println("entry: " + entry.getName());
                String statusx = entry.getStatus();
                System.out.println("statusx : " + statusx);
                Presence presence = entry.getPresence();
                System.out.println("presence : " + presence);
            if (entry.getUser() != null) {
                if (presence != null) {
                    String status = entry.getStatus();
                    System.out.println(entry.getUser() + ":" + status);
                    %>
              
  <tr class="<mvn:cssrow/>">  
    <td>
    <%=group.getName()%>
  </td>
    <td>
    <%= entry.getUser()%>
  </td>
  <td>
      <center><a class="command" href="#" onclick="window.open('<%=urlResolver.encodeURL(request, response, "pre_process_chat?receiver=" + entry.getUser() )%>', '<%=entry.getUser()%>','location=1,status=1,scrollbars=1, width=400,height=400 resizable=yes');"> Send Message</a></center>
  </td>
  <td>
    <center><%= status%></center>
  </td>
  <td>
      <center><a href="<%=urlResolver.encodeURL(request, response, "remove_buddy?userid=" + entry.getUser() + "&removegroupname=" + group.getName())%>" class="command"> Remove Buddy</a></center>
  </td>
  </tr>
              <%
                } else {
                    System.out.println(entry.getUser() + ":" + "offline");
              %>
  <tr class="<mvn:cssrow/>">  
     <td>
    <%=group.getName()%>
  </td>
    <td>
      <%= entry.getUser()%>
  </td>
  <td>
     <center><a class="command" href="#" onclick="window.open('<%=urlResolver.encodeURL(request, response, "pre_process_chat?receiver=" + entry.getUser() )%>', '<%=entry.getUser()%>','location=1,status=1,scrollbars=1, width=400,height=400 resizable=yes');"> Send Message</a></center>
  </td>
  <td>
    <center>OFFLINE</center>
  </td>
  <td>
      <center><a href="<%=urlResolver.encodeURL(request, response, "remove_buddy?userid=" + entry.getUser() + "&removegroupname=" + group.getName())%>" class="command"> Remove Buddy</a></center>
  </td>
  </tr>
      <%  }
         }
        }
       }
      }
     }
    }

} else {

      if (collection != null) {
      Iterator groupIter = collection.iterator();
      
        //Loop through each group and display its members
       while(groupIter.hasNext()) {
            Group group = (Group)groupIter.next();
            System.out.println("Group: " + group.getName());
            
            //Get the members of each group.
            Collection col = group.getEntries();
        if (col != null) {
            Iterator groupEntries = col.iterator();
            //Iterator groupEntries = group.getEntries();
            while(groupEntries.hasNext()) {
                Buddy entry = (Buddy)groupEntries.next();
                 System.out.println("entry: " + entry.getName());
                String statusx = entry.getStatus();
                System.out.println("statusx : " + statusx);
                Presence presence = entry.getPresence();
                System.out.println("presence : " + presence);
            if (entry.getUser() != null) {
                if (presence != null) {
                    String status = entry.getStatus();
                    System.out.println(entry.getUser() + ":" + status);
                    %>
              
  <tr class="<mvn:cssrow/>">  
    <td>
      <%=group.getName()%>
  </td>
    <td>
    <%= entry.getUser()%>
  </td>
  <td>
      <center><a class="command" href="#" onclick="window.open('<%=urlResolver.encodeURL(request, response, "pre_process_chat?receiver=" + entry.getUser() )%>', '<%=entry.getUser()%>','location=1,status=1,scrollbars=1, width=400,height=400 resizable=yes');"> Send Message</a></center>
  </td>
  <td>
    <center><%= status%></center>
  </td>
  <td>
      <center><a href="<%=urlResolver.encodeURL(request, response, "remove_buddy?userid=" + entry.getUser() + "&removegroupname=" + group.getName())%>" class="command"> Remove Buddy</a></center>
    </td>
  </tr>
              <%
                } else {
                    System.out.println(entry.getUser() + ":" + "offline");
              %>
  <tr class="<mvn:cssrow/>">  
    <td>
    <%=group.getName()%>
  </td>
    <td>
    <%= entry.getUser()%>
  </td>
  <td>
      <center><a class="command" href="#" onclick="window.open('<%=urlResolver.encodeURL(request, response, "pre_process_chat?receiver=" + entry.getUser() )%>', '<%=entry.getUser()%>','location=1,status=1,scrollbars=1, width=400,height=400 resizable=yes');"> Send Message</a></center>
  </td>
  <td>
    <center>OFFLINE</center>
  </td>
  <td>
      <center><a href="<%=urlResolver.encodeURL(request, response, "remove_buddy?userid=" + entry.getUser() + "&removegroupname=" + group.getName())%>" class="command"> Remove Buddy</a></center>
  </td>
  </tr>
                    <%
                   }
                }
            }
          }
        }
      }
    }
  %>
</mvn:cssrows>
</table>

<br/>
<input type="button" value="GetWaitingList" onclick="sendRequest(getWaitingList());">

  <% } %>

<br/>
<%@ include file="footer.jsp"%>

<!--<script type='text/javascript'>
     autoRefresh();
</script>-->
</mvn:body>
</mvn:html>
</fmt:bundle>
