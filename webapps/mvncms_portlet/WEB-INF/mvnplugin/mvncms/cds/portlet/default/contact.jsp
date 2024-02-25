<%--
 - $Header: /home/cvsroot/mvncms-portlet/srcweb/WEB-INF/mvnplugin/mvncms/cds/portlet/default/contact.jsp,v 1.10 2009/12/08 03:13:20 xuantl Exp $
 - $Author: xuantl $
 - $Revision: 1.10 $
 - $Date: 2009/12/08 03:13:20 $
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
<%-- including file --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page session="false" errorPage="fatalerror.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mvnsoft.mvncms.db.*"%>
<%@ page import="com.mvnsoft.mvncms.cds.*"%>
<%@include file="inc_common.jsp"%>

<link rel="stylesheet" type="text/css" media="all" href="<%=cdsTemplate%>/css/style.css" />
<script type="text/javascript" src="<%=cdsTemplate%>/js/addclasskillclass.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/attachevent.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/addcss.js"></script>
<script type="text/javascript" src="<%=cdsTemplate%>/js/tabtastic.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/mvnplugin/mvnforum/js/myvietnam.js"></script>
<script type="text/javascript">
//<![CDATA[
function onSubmit() {
    var Name = document.sendcontact.Name.value;
    var From = document.sendcontact.From.value;
    var Organization = document.sendcontact.Organization.value;
    var Reviews = document.sendcontact.Reviews.value;
    if (Name.length == 0) {
      alert('Bạn hãy nhập Tên của bạn.')
    } else if (Organization.length == 0) {
      alert('Bạn hãy nhập Ban ngành.')
    } else if (From.length == 0) {
      alert('Bạn hãy nhập Email của bạn.')
    } else if (complexEmailCheck(From) == false) {
      alert('Bạn nhập sai Email của bạn.')
    } else if (Reviews.length == 0) {
      alert('Bạn hãy nhập Nhận xét.')
    } else {
      document.sendcontact.submit();
    }
    return false;
  }
//]]>
</script>
<% ContentBean contentBean = (ContentBean)request.getAttribute("ContentBean"); %>
<table width="930" border="0" cellspacing="0" cellpadding="0" class="box_border" style="margin:0 auto">
  <tr>
    <td>
      <div style="font-size:16px; color:#009900; border-bottom:2px solid #009900; font-weight:bold; margin:10px;">Thông tin liên hệ</div>
      <div style="width:55%; float:left; margin:10px;">
      <div style="color:#0f5baf; font-weight:bold; font-size:16px; text-transform:uppercase;"><%=contentBean.getContentTitle()%></div>
      <div style="padding:8px 0px;"><%=contentBean.getContentBody()%></div>
      
      <div style="background-color:#fff; border:1px solid #ccc; width:450px; margin-top:30px; padding-bottom:10px;">
        <div style="color:#0f5baf; font-weight:bold; font-size:16px; margin:10px; border-bottom:1px solid #c2cad3;">Liên hệ</div>
        <form action="<%=urlResolver.encodeURL(request, response, "contact", URLResolverService.ACTION_URL)%>" method="post" name="sendcontact">
        <%=urlResolver.generateFormAction(request, response, "contact")%>
             
          <p style="margin:3px 0 3px 10px;"><label>Tên<span class="requiredfield"> *</span></label><input class="inp" name="Name"></p>
          <p style="margin:3px 0 3px 10px;"><label>Tổ chức / ban ngành<span class="requiredfield"> *</span></label><input class="inp" name="Organization"></p>
          <p style="margin:3px 0 3px 10px;"><label>Địa chỉ Email<span class="requiredfield"> *</span></label><input class="inp" name="From"></p>
          <p style="margin:3px 0 3px 10px;"><label>Phản hồi / Nhận xét<span class="requiredfield"> *</span></label><textarea name="Reviews" cols="" rows="" class="inp"></textarea></p>
          <p style="margin:3px 10px 3px 10px; border-bottom:1px solid #c2cad3;">&nbsp;</p>
          <p style="text-align:center; margin-top:10px;"><input onClick="onSubmit();return false;" class="btn" value="Chấp nhận" type="submit">&nbsp;&nbsp;<input value="Nhập lại" type="reset" class="btn" ></p>
        </form>
      </div>
    </div>
    <%if (contentBean.getContentDefaultImage().length() > 0) { %>
      <div style="float:right; margin:10px"><img style=" border:1px solid #ccc;" src="<%=request.getContextPath() + contentBean.getContentDefaultImage_translated()%>" alt="" width="350" height="220"/>
    <%} %>
    </div>
    </td>
  </tr>
</table>
