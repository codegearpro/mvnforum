<%--
 - $Header: /cvsroot/mvnforum/mvnad/srcweb/mvnplugin/mvnad/delivery/footer.jsp,v 1.3 2009/03/30 06:57:34 minhnn Exp $
 - $Author: minhnn $
 - $Revision: 1.3 $
 - $Date: 2009/03/30 06:57:34 $
 -
 - ====================================================================
 -
 - Copyright (C) 2002-2008 by MyVietnam.net
 -
 - All copyright notices regarding mvnForum MUST remain 
 - intact in the scripts and in the outputted HTML.
 - The "powered by" text/logo with a link back to
 - http://www.mvnForum.com and http://www.MyVietnam.net in 
 - the footer of the pages MUST remain visible when the pages
 - are viewed on the internet or intranet.
 -
 - This program is free software; you can redistribute it and/or modify
 - it under the terms of the GNU General Public License as published by
 - the Free Software Foundation; either version 2 of the License, or
 - any later version.
 -
 - This program is distributed in the hope that it will be useful,
 - but WITHOUT ANY WARRANTY; without even the implied warranty of
 - MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 - GNU General Public License for more details.
 -
 - You should have received a copy of the GNU General Public License
 - along with this program; if not, write to the Free Software
 - Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 -
 - Support can be obtained from support forums at:
 - http://www.mvnForum.com/mvnforum/index
 -
 - Correspondence and Marketing Questions can be sent to:
 - info at MyVietnam net
 -
 - @author: MyVietnam.net developers
 -
 --%>
<%-- not localized yet --%>
<%@ page import="com.mvnsoft.mvnad.service.MvnAdInfoService"%>
<%@ page import="com.mvnsoft.mvnad.service.MvnAdServiceFactory"%>
<%
MvnAdInfoService mvnAdInfo = MvnAdServiceFactory.getMvnAdService().getMvnAdInfoService();
%>
<div align="center" class="pageFooter">
  Powered by <a href="http://www.MyVietnam.net" target="_blank"><%= mvnAdInfo.getProductDesc()%></a> (Build: <%= mvnAdInfo.getProductReleaseDate()%>)<br />
  Copyright &copy; 2002-2009 by <a href="http://www.MyVietnam.net" target="_blank">MyVietnam.net</a>
  <p>&nbsp;</p>
</div>
