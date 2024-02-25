<%--
 - $Header: /home/cvsroot/mvncms/srcweb/mvnplugin/mvncms/cds/standard/template1/inc_js_common.jsp,v 1.2 2009/02/20 06:56:15 minhnn Exp $
 - $Author: minhnn $
 - $Revision: 1.2 $
 - $Date: 2009/02/20 06:56:15 $
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
<script type="text/javascript">
//<![CDATA[
function isBlank(field, strBodyHeader) {
    strTrimmed = trim(field.value);
    if (strTrimmed.length > 0) return false;
    alert("\"" + strBodyHeader + "\" <fmt:message key="mvnforum.common.js.prompt.fieldrequired" bundle="${forum}"/>");
    field.focus();
    return true;
}

function trim(str) {
  return str.replace(/(^\s+)([^\s]*)(\s+$)/, '$2');
}
//]]>
</script>