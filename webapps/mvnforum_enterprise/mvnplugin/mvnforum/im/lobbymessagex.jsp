<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/im/lobbymessagex.jsp,v 1.5 2007/12/31 03:08:52 minhnn Exp $
 - $Author: minhnn $
 - $Revision: 1.5 $
 - $Date: 2007/12/31 03:08:52 $
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
<%@ page import="java.util.*" %>
<%@ page import="org.jivesoftware.smack.packet.Message" %>
<%@ page import="com.mvnforum.auth.OnlineUser" %>
<%@ page import="org.jivesoftware.smack.XMPPConnection" %>
<%@ include file="inc_common.jsp"%>

<% 
Collection messages = (Collection)request.getAttribute("data");
StringBuffer logMessage = new StringBuffer();
XMPPConnection con = (XMPPConnection)onlineUser.getXMPPConnection();

  if (messages != null) {
    for (Iterator iter = messages.iterator();iter.hasNext();) {
        Message data = (Message)iter.next();
        String time = (String)data.getProperty("time");
        String body = data.getBody();
        String from = data.getFrom();
        if (from.indexOf("/") >= 0) {
          String [] users = from.split("/");
          String user = users[1];
          
          logMessage.append(time).append("*").append(user).append("*").append(body).append("<br/>");
        } else {
            logMessage.append(time).append("*").append("lobby").append("*").append(body).append("<br/>");
        }
    }
  } 
%>

<%= logMessage%>
