<?xml version="1.0" encoding="utf-8" ?>
<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/im/notifyChatx.jsp,v 1.4 2007/01/15 07:18:39 dungbtm Exp $
 - $Author: dungbtm $
 - $Revision: 1.4 $
 - $Date: 2007/01/15 07:18:39 $
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
<% response.setContentType("text/xml;charset=utf-8");%>
<users>
<% 
Set waitingList = (Set)request.getAttribute("waitingList");
if (waitingList != null) {
    for (Iterator iter = waitingList.iterator();iter.hasNext();) {
        String userId = (String)iter.next();
        System.out.println("userId : " + userId);
%>        
     <user><%= userId %></user>
<%
    }
}
%>
</users>
