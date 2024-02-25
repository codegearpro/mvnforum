<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/sendcontactsuccess.jsp,v 1.3 2009/10/23 08:51:42 trungth Exp $
 - $Author: trungth $
 - $Revision: 1.3 $
 - $Date: 2009/10/23 08:51:42 $
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
<%@ page contentType="text/html;charset=utf-8" %>
<%@include file="inc_common.jsp"%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<%                                              
String flag = ((String) request.getAttribute("SendMailSuccess"));
%>
<div id="content">
  <div class="content_inner">
    <h3>Li&#234;n h&#7879;</h3>
    <%if (flag.equals("true")) {%> 
      <div align="center">B&#7841;n &#273;&#227; g&#7917;i mail th&#224;nh c&#244;ng. C&#7843;m &#417;n b&#7841;n &#273;&#227; g&#7917;i mail.</div>
    <%} else {%>
      <div align="center">G&#7917;i mail kh&#244;ng th&#224;nh c&#244;ng. B&#7841;n h&#227;y quay l&#7841;i sau.</div>
    <%}%>  
    <div align="right"><a href="<%=urlResolver.encodeURL(request, response, "")%>" style="color: blue;"><img src="<%=cdsTemplate%>/images/back_arrow.gif" alt="" border="0" /><fmt:message key="mvnforum.admin.success.return"/></a> </div>
    <div style="clear:both; line-height:15px;">&nbsp;</div>
  </div>
</div>
</fmt:bundle>