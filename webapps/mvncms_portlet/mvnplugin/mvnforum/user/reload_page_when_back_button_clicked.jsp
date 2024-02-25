<%--
  - $Header: /home/cvsroot/portlet-mvnforum/srcweb/mvnplugin/mvnforum/user/reload_page_when_back_button_clicked.jsp,v 1.2 2010/08/20 05:16:09 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.2 $
  - $Date: 2010/08/20 05:16:09 $
  -
  - ====================================================================
  -
  - Copyright (C) 2002-2010 by MyVietnam.net
  -
  - MyVietnam.net PROPRIETARY/CONFIDENTIAL PROPERTIES. Use is subject to license terms.
  - You CANNOT use this software unless you receive a written permission from MyVietnam.net
  -
  - @author: MyVietnam.net developers
  -
--%>
<input type="hidden" id="refreshed_by_clicking_back_button" value="no" />

<script type="text/javascript">
jQuery(document).ready(function($){
  var e = $('#refreshed_by_clicking_back_button');
  if (e.val() == "no") {
     e.attr('value', 'yes');
  } else {
     e.attr('value', 'no');
     location.reload();
  }
});
</script>