<%--
 - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/im/inc_js_checkvalid_myvietnamlib.jsp,v 1.6 2009/03/11 09:11:54 trungth Exp $
 - $Author: trungth $
 - $Revision: 1.6 $
 - $Date: 2009/03/11 09:11:54 $
 -
 - ====================================================================
 -
 - Copyright (C) 2002-2007 by MyVietnam.net
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
 - @author: Minh Nguyen  
 - @author: Mai  Nguyen  
 --%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<script src="<%=contextPath%>/mvnplugin/mvnforum/js/myvietnam.js" type="text/javascript"></script>
<script type="text/javascript">
function isBlank(field, strBodyHeader) {
    strTrimmed = trim(field.value);
    if (strTrimmed.length > 0) return false;
    alert("\"" + strBodyHeader + "\" <fmt:message key="mvnforum.common.js.prompt.fieldrequired"/>");
    field.focus();
    return true;
}
function isEmail(field, strBodyHeader) {
    emailStr = field.value;
    if (emailStr.length == 0) return true;
    if (!complexEmailCheck(emailStr)) {
        alert(strBodyHeader + " <fmt:message key="mvnforum.common.js.prompt.invalidemail"/>");
        field.focus();
        return false;
    }
    return true;
}
function checkGoodName(str, desc) {
    s = trim(str);
    len = s.length; 
    for (i = 0; i < len; i++) {
        b = s.charCodeAt(i);
        if ((b >= toInt('a')) && (b <= toInt('z'))) { // not a cast, it's a function.
            // low chars
        } else if ((b >= toInt('A')) && (b <= toInt('Z'))) {
            // up chars
        } else if ((b >= toInt('0')) && (b <= toInt('9'))) {
            // numbers 
        } else if (( (b==toInt('_')) || (b==toInt('.')) || (b==toInt('@')) ) && (i != 0)) {
            // very litte special chars
        } else {
            alert(desc + " \"" + s +  "\" " + "<fmt:message key="mvnforum.common.js.prompt.not_goodname"/>. <fmt:message key="mvnforum.common.js.prompt.invalid_char_is"/> \"" + s.charAt(i) + "\""); 
            return false;
            // not good name error
        }
    }
    return true;
}

function toInt(c) {
  return c.charCodeAt(0);
}
</script>
</fmt:bundle>
