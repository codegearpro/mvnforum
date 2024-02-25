<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/im/messagelogx.jsp,v 1.5 2007/12/18 05:43:26 minhnn Exp $
 - $Author: minhnn $
 - $Revision: 1.5 $
 - $Date: 2007/12/18 05:43:26 $
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
<% 
Collection messages = (Collection)request.getAttribute("data");
StringBuffer logMessage = new StringBuffer();

  if (messages != null) {
    for (Iterator iter = messages.iterator();iter.hasNext();) {
        Message data = (Message)iter.next();
        String time = (String)data.getProperty("time");
         String from = data.getFrom();
         String [] users = from.split("@");
         String user = users[0];
         String body = data.getBody();
         logMessage.append(time).append("*").append(user).append("@*").append(body).append("<br/>");
    }
  }
%>

<%= logMessage%>