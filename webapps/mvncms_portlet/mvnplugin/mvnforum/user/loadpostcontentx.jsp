<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/mvnplugin/mvnforum/user/loadpostcontentx.jsp,v 1.10 2010/06/22 03:12:47 minhnn Exp $
  - $Author: minhnn $
  - $Revision: 1.10 $
  - $Date: 2010/06/22 03:12:47 $
  -
  - ====================================================================
  -
  - Copyright (C) 2002-2009 by MyVietnam.net
  -
  - MyVietnam.net PROPRIETARY/CONFIDENTIAL PROPERTIES. Use is subject to license terms.
  - You CANNOT use this software unless you receive a written permission from MyVietnam.net
  -
  - @author: MyVietnam.net developers
  -
--%>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page errorPage="fatalerror.jsp"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="net.myvietnam.mvncore.util.AssertionUtil" %>
<%@ page import="net.myvietnam.mvncore.util.ParamUtil" %>
<%@ page import="net.myvietnam.mvncore.util.GenericParamUtil"%>
<%@ page import="net.myvietnam.mvncore.filter.EnableEmotionFilter" %>
<%@ page import="net.myvietnam.mvncore.filter.EnableMVNCodeFilter" %>
<%@ page import="net.myvietnam.mvncore.security.Encoder" %>
<%@ page import="net.myvietnam.mvncore.util.FriendlyURLParamUtil"%>
<%@ page import="net.myvietnam.mvncore.util.StringUtil"%>
<%@ page import="com.mvnforum.LocaleMessageUtil" %>
<%@ page import="com.mvnforum.db.*" %>
<%@ page import="com.mvnforum.common.*" %>
<%@ page import="com.mvnforum.MVNForumGlobal" %>
<%@ page import="com.mvnforum.MVNForumConstant" %>
<%@ page import="com.mvnforum.MVNForumResourceBundle" %>
<%@ page import="com.mvnforum.auth.OnlineUserAction" %>
<%@ page import="com.mvnforum.user.UserModuleConfig"%>

<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ include file="inc_common.jsp"%>
<%
PostBean postBean = (PostBean) request.getAttribute("postBean");
MemberBean memberBean = (MemberBean) request.getAttribute("memberBean");
ThreadBean threadBean = (ThreadBean) request.getAttribute("threadBean");
int forumID = threadBean.getForumID();
ForumCache forumCache = ForumCache.getInstance();
ForumBean currentForumBean = forumCache.getBean(forumID);
boolean enablePost = false;
boolean _highlightKey = false;
int offset = 0;
boolean enableInvisible = MVNForumConfig.getEnableInvisibleUsers();
int functionID = 0;
int lastPostCount = 1;
int indexCount = 0;
int memberPostsPerPage = 10000;
int threadID = threadBean.getThreadID();
AssertionUtil.doAssert((memberBean == null) || (postBean.getMemberID() == memberBean.getMemberID()), "Member info and Post info don't match!");
%>
<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:cssrows>

<span id="post<%=postBean.getPostID()%>" style="display:none" /> 
<a name="<%=postBean.getPostID()%>"></a>
<table class="tborder" width="95%" cellspacing="0" cellpadding="5" align="center">
  <tr class="<mvn:cssrow wantToReturn="<%=(postBean.getParentPostID() == 0)%>" valueToReturn="trow0"/>">
    <td width="155" rowspan="2" valign="top">
      <%if ( (memberBean!=null) && (memberBean.getMemberID()!=0) && (memberBean.getMemberID()!=MVNForumConstant.MEMBER_ID_OF_GUEST) ) {%>
        <%if (MVNForumConfig.getEnableShowGender()) {%>  
          <%if (memberBean.getMemberGender()==1) {%>
          <img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/male.gif" border="0" alt="<fmt:message key="mvnforum.common.member.male"/>" title="<fmt:message key="mvnforum.common.member.male"/>" />
          <%} else {%>
          <img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/female.gif" border="0" alt="<fmt:message key="mvnforum.common.member.female"/>" title="<fmt:message key="mvnforum.common.member.female"/>" />
          <%}
          }%>
        <a href="<%=urlResolver.encodeURL(request, response, "viewmember?member=" + Encoder.encodeURL(memberBean.getMemberName()))%>" class="memberName"><%=memberBean.getMemberName()%></a>
        <br/>
        <%=(memberBean.getMemberTitle().length() > 0) ? EnableMVNCodeFilter.filter(memberBean.getMemberTitle()) : MyUtil.getMemberTitle(memberBean.getMemberPostCount())%>
        <br/>
        <% if ((memberBean.getMemberAvatar().length() > 0) && MVNForumConfig.getEnableAvatar() ) { %>
        <div align="center"><img src="<%=memberBean.getMemberAvatar_processed(request, response)%>" border="0" alt="<fmt:message key="mvnforum.common.member.avatar.has_avatar"/>" title="<fmt:message key="mvnforum.common.member.avatar.has_avatar"/>" /></div>
        <% } else { %>
        <br/><br/>
        <% } %>
        <br/>
        <%if (MVNForumConfig.getEnableShowCountry()) {%>
        <%=memberBean.getMemberCountry()%><br/>
        <%}%>
         <% if (MVNForumConfig.getEnableShowJoinDate()) {%>     
        <fmt:message key="mvnforum.user.viewthread.joined"/>: <b><%=onlineUser.getGMTDateFormat(memberBean.getMemberCreationDate())%></b><br/>
        <%} %>
        <% if (MVNForumConfig.getEnableShowPostCount()) {%>     
        <fmt:message key="mvnforum.common.member.post_count"/>: <b><%=memberBean.getMemberPostCount()%></b><br/>
        <%}%>

        <% if (MVNForumConfig.getEnableShowOnlineStatus()) {%>
          <fmt:message key="mvnforum.common.member.online_status"/>:
          <%
          boolean invisible = memberBean.isInvisible();
          boolean online = onlineUserManager.isUserOnline(memberBean.getMemberName());
        
          if ( online && (!enableInvisible || !invisible) ) {%>
            <%--
            (S)he is online now, the "online" text show only when the Invisible feature is disabled
            or his status is visible (not invisable). Otherwise, show "offline" text
            --%>
              <font color="#008000"><fmt:message key="mvnforum.common.member.online"/></font>
          <%} else if (online && permission.canAdminSystem()) {%>
              <font color="#008000"><fmt:message key="mvnforum.common.member.online.invisible_member"/></font>
          <%} else {%>
              <fmt:message key="mvnforum.common.member.offline"/>
          <%}%>
        <%}%>
      <%} else {%>
        <%-- @todo: replace alt string in next <img> --%>
        <img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/nogender.gif" border="0" alt="<fmt:message key="mvnforum.common.member.no_gender"/>" title="<fmt:message key="mvnforum.common.member.no_gender"/>" />
        <%if (memberBean == null) {
            String name = postBean.getMemberName();
            if (name.equalsIgnoreCase(MVNForumConstant.MEMBER_NAME_OF_GUEST)) {
              name = MVNForumConfig.getDefaultGuestName();
            }
            out.print(name);
          } else {%>
          <span class="memberName"><%=memberBean.getMemberName()%></span>
          <br/>
          <%if (memberBean.getMemberTitle()!=null) {%><%=EnableMVNCodeFilter.filter(memberBean.getMemberTitle())%><%}%>
          <br/>
          <%if ((memberBean.getMemberAvatar().length() > 0) && MVNForumConfig.getEnableAvatar() ) { %>
            <div align="center"><img src="<%=memberBean.getMemberAvatar_processed(request, response)%>" border="0" alt="<fmt:message key="mvnforum.common.member.avatar.has_avatar"/>" title="<fmt:message key="mvnforum.common.member.avatar.has_avatar"/>" /></div>
          <%}%>
        <%}%>
      <%}%>
    </td>
    <td valign="top">
      <table width="100%" class="noborder" cellpadding="0" cellspacing="0">
        <tr>
          <td width="80%" valign="top" class="messageTextBold">
            <%-- Note that if user don't have permission to edit own post, then he cannot add attachment --%>
            <%if ( ( (permission.canEditPost(forumID)) || ((memberBean!=null) && (memberBean.getMemberID()==memberID) && permission.canEditOwnPost(forumID)) )
                   && (threadBean.getThreadStatus()!=ThreadBean.THREAD_STATUS_LOCKED)
                   && (currentForumBean.getForumStatus()!=ForumBean.FORUM_STATUS_LOCKED) ) {%>
              <% if ( MVNForumConfig.getEnableAttachment() && permission.canAddAttachment(forumID) ) { %>
              <a href="<%=urlResolver.encodeURL(request, response, "addattachment?post=" + postBean.getPostID() + "&amp;offset=" + offset)%>"><img src="<%=imagePath%>/button_attach.gif" border="0" alt="<fmt:message key="mvnforum.user.viewthread.link.attach_file"/>" title="<fmt:message key="mvnforum.user.viewthread.link.attach_file"/>" /></a>&nbsp;
                 <% if (MVNForumConfig.getEnableAppletUploadImage()) { %>
                <a href="<%=urlResolver.encodeURL(request, response, "uploadimage?post=" + postBean.getPostID() + "&amp;offset=" + offset)%>"><img src="<%=imagePath%>/button_upload.gif" border="0" alt="<fmt:message key="mvnforum.user.viewthread.link.paste_file"/>" title="<fmt:message key="mvnforum.user.viewthread.link.paste_file"/>" /></a>&nbsp;
                 <% } %>
              <% } %>
              <a href="<%=urlResolver.encodeURL(request, response, "editpost?post=" + postBean.getPostID() + "&amp;offset=" + offset)%>"><img src="<%=imagePath%>/button_edit.gif" border="0" alt="<fmt:message key="mvnforum.user.viewthread.link.edit_post"/>" title="<fmt:message key="mvnforum.user.viewthread.link.edit_post"/>" /></a>&nbsp;
            <%}%>
            <%if (MVNForumConfig.getEnableNewPost() && permission.canAddPost(forumID) && (threadBean.getThreadStatus()==ThreadBean.THREAD_STATUS_DEFAULT) && (currentForumBean.getForumStatus()==ForumBean.FORUM_STATUS_DEFAULT)) { %>
              <a href="#message" onclick="QuickReply(<%=postBean.getPostID()%>);"><img src="<%=imagePath%>/button_quick_reply.gif" border="0" alt="<fmt:message key="mvnforum.user.viewthread.link.quickreply_post"/>" title="<fmt:message key="mvnforum.user.viewthread.link.quickreply_post"/>" /></a>&nbsp;
            <%enablePost = true; } %>  
            <% if (MVNForumConfig.getEnableNewPost() && (onlineUser.isGuest()||permission.canAddPost(forumID)) && (threadBean.getThreadStatus()==ThreadBean.THREAD_STATUS_DEFAULT) && (currentForumBean.getForumStatus()==ForumBean.FORUM_STATUS_DEFAULT) ) { %>
               <a href="<%=urlResolver.encodeURL(request, response, "addpost?parent=" + postBean.getPostID())%>"><img src="<%=imagePath%>/button_reply.gif" border="0" alt="<fmt:message key="mvnforum.user.viewthread.link.reply_post"/>" title="<fmt:message key="mvnforum.user.viewthread.link.reply_post"/>" /></a>&nbsp;
               <a href="<%=urlResolver.encodeURL(request, response, "addpost?parent=" + postBean.getPostID() + "&amp;quote=yes")%>"><img src="<%=imagePath%>/button_quote.gif" border="0" alt="<fmt:message key="mvnforum.user.viewthread.link.reply_with_quote"/>" title="<fmt:message key="mvnforum.user.viewthread.link.reply_with_quote"/>" /></a>&nbsp;
            <% }//if can new post%>
              <%if ( (permission.canDeletePost(forumID) || ((memberBean!=null) && (memberBean.getMemberID()==memberID)))
                && (currentForumBean.getForumStatus()!=ForumBean.FORUM_STATUS_LOCKED) ) {%>
            <%if (postBean.getParentPostID() == 0) {%>
             <a href="<%=urlResolver.encodeURL(request, response, "deletethread?thread=" + threadID)%>"><img src="<%=imagePath%>/button_delete_thread.gif" border="0" alt="<fmt:message key="mvnforum.user.viewthread.link.delete_thread"/>" title="<fmt:message key="mvnforum.user.viewthread.link.delete_thread"/>" /></a>
              <%} else {%>
             <a href="<%=urlResolver.encodeURL(request, response, "deletepost?post=" + postBean.getPostID())%>"><img src="<%=imagePath%>/button_delete_post.gif" border="0" alt="<fmt:message key="mvnforum.user.viewthread.link.delete_post"/>" title="<fmt:message key="mvnforum.user.viewthread.link.delete_post"/>" /></a>
             <a href="<%=urlResolver.encodeURL(request, response, "splitthread?post=" + postBean.getPostID())%>"><img src="<%=imagePath%>/button_split_thread.gif" border="0" alt="<fmt:message key="mvnforum.user.viewthread.link.split_thread"/>" title="<fmt:message key="mvnforum.user.viewthread.link.split_thread"/>" /></a>
              <%}%>
            <%}%>
<%  // start implement vote for post
    try {
        Integer maxvalue = (Integer) request.getAttribute("maxvalue");
        Integer minvalue = (Integer) request.getAttribute("minvalue");
        Integer option = (Integer) request.getAttribute("option");
        Integer periodID = (Integer) request.getAttribute("period");
        Timestamp startDate = (Timestamp) request.getAttribute("startDate");
        Timestamp endDate = (Timestamp) request.getAttribute("endDate");
        Integer disableForum = (Integer) request.getAttribute("forumLevel");
        int votePeriodMinValue = minvalue.intValue();
        int votePeriodMaxValue = maxvalue.intValue();
        int votePeriodOption = option.intValue();
        int period = periodID.intValue();
        int isDisable = disableForum.intValue();
        String voteeMemberName = onlineUser.getMemberName();
        
        if (currentForumBean.getForumStatus()!=ForumBean.FORUM_STATUS_LOCKED && isDisable==0 && onlineUser.isMember()&& !voteeMemberName.equals(postBean.getMemberName()) && votePeriodMinValue!=0 && threadBean.getThreadStatus()!=ThreadBean.THREAD_STATUS_LOCKED && threadBean.getThreadCreationDate().after(startDate) && threadBean.getThreadCreationDate().before(endDate))  {
            
            if (votePeriodOption == 2) {                   
                %>
                <td width="20%" valign="top" align="right" class="messageTextBold">
                  <form name="form" action="<%=urlResolver.encodeURL(request, response, "votepostprocess", URLResolverService.ACTION_URL)%>" <mvn:method/>>
                    <%=urlResolver.generateFormAction(request, response, "votepostprocess")%>
                    <input type="hidden" name="threadID" value="<%=threadBean.getThreadID()%>"/>
                    <input type="hidden" name="postID" value="<%=postBean.getPostID()%>"/>
                    <input type="hidden" name="statusvote" value="star" />
                    <input type="hidden" name="voteperiodtype" value="1"/>
                    <input type="hidden" name="voteperiodoption" value="1"/>
                    <input type="hidden" name="period" value="<%=period %>"/>
                    <input type="hidden" name="voteemembername" value="<%=voteeMemberName %>" />
                    <select name="postVoteValue" class="command" border="0">
                        <% for (int i = votePeriodMinValue; i <= votePeriodMaxValue; i++) { %>
                            <option id="<%=i%>"><%=i %></option>
                        <% } %>
                    </select>
                    <input type="submit" name="sendVote" value="Vote"  class="command" />
                  </form>
                </td>
                <%
            }
        }
         //end vote form
    } catch (Exception e) {
           //TODO: implement catch
    } // end implement vote for post
%>
            </td>
          <%if (MVNForumConfig.getEnableUsePopupMenuInViewThread()) {
              String deleteURL="";
          %>
          <td align="right" valign="top" nowrap="nowrap" width="100">
            <div id="domMenu_main<%=functionID%>"></div>
            <script type="text/javascript">
            //<![CDATA[
              <%if ( (permission.canDeletePost(forumID) || ((memberBean!=null) && (memberBean.getMemberID()==memberID)))
                  && (currentForumBean.getForumStatus()!=ForumBean.FORUM_STATUS_LOCKED) ) {
                  if (postBean.getParentPostID() == 0) {
                    deleteURL = urlResolver.encodeURL(request, response, "deletethread?thread=" + threadID);
                  } else {
                    deleteURL = urlResolver.encodeURL(request, response, "deletepost?post=" + postBean.getPostID()); 
                  }
                }%>
              createMenuData<%=functionID%>('<%=postBean.getPostID()%>','<%=postBean.getPostTopic()%>','<%=urlResolver.encodeURL(request, response, "addpost?parent=" + postBean.getPostID())%>','<%=urlResolver.encodeURL(request, response, "addpost?parent=" + postBean.getPostID() + "&quote=yes")%>','<%=urlResolver.encodeURL(request, response, "addattachment?post=" + postBean.getPostID() + "&offset=" + offset)%>','<%=urlResolver.encodeURL(request, response, "uploadimage?post=" + postBean.getPostID() + "&offset=" + offset)%>','<%=urlResolver.encodeURL(request, response, "editpost?post=" + postBean.getPostID() + "&offset=" + offset)%>','<%=deleteURL%>');
              domMenu_activate('domMenu_main<%=functionID++%>');
            //]]>
            </script>
          </td>
          <%} %>
        </tr>
        <tr>
          <td width="100%" colspan="2" valign="top" class="messageTextBold" align="left">
            <%if (postBean.getPostIcon().length() > 0) {%>
                <%= EnableEmotionFilter.filter(postBean.getPostIcon(), contextPath + MVNForumGlobal.EMOTION_DIR)%> 
            <%}%>

            <%if (postBean.getParentPostID() == 0) {
                String threadPriorityIcon = MyUtil.getThreadPriorityIcon(threadBean.getThreadPriority());
                if ( ( (threadBean.getThreadPriority() == ThreadBean.THREAD_PRIORITY_LOW) && MVNForumConfig.getEnableLowPriorityIcon() ) || ( (threadBean.getThreadPriority() == ThreadBean.THREAD_PRIORITY_NORMAL) && MVNForumConfig.getEnableNormalPriorityIcon()) || ( (threadBean.getThreadPriority() == ThreadBean.THREAD_PRIORITY_HIGH) && MVNForumConfig.getEnableHighPriorityIcon() ) ) { 
            %>
                  <img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/<%=threadPriorityIcon%>" border="0" alt="" /> 
            <%  }
              } %>
            <span id="posttopic_<%=postBean.getPostID()%>">
              <%=MyUtil.filter(postBean.getPostTopic(), false/*html*/, true/*emotion*/, true/*mvnCode*/, false/*newLine*/, false/*URL*/)%>
            </span>
          </td>
        </tr>   
      </table>
      <hr size="1" noshade="noshade"/>
    <%if (_highlightKey) {%>
      <span class="searchname"><%=MyUtil.filter(postBean.getPostBody(), false/*html*/, true/*emotion*/, true/*mvnCode*/, true/*newLine*/, true/*URL*/)%></span>
    <%} else {%>
      <%=MyUtil.filter(postBean.getPostBody(), false/*html*/, true/*emotion*/, true/*mvnCode*/, true/*newLine*/, true/*URL*/)%>
    <%}%>
      <%
      Collection attachBeans = postBean.getAttachmentBeans();
      if (attachBeans != null) {
        for (Iterator attachIter = attachBeans.iterator(); attachIter.hasNext(); ) {
            AttachmentBean attachBean = (AttachmentBean)attachIter.next();
      %>
          ----------------------------------------<br/>
<%if (permission.canDeletePost(forumID)) {%>
<%-- @todo: or it should be canEditPost(forumID) ? --%>
          <a class="command" href="<%=urlResolver.encodeURL(request, response, "deleteattachment?attach=" + attachBean.getAttachID() + "&amp;offset=" + offset)%>">[<fmt:message key="mvnforum.common.action.delete"/>]</a>&nbsp;
          <a class="command" href="<%=urlResolver.encodeURL(request, response, "editattachment?attach=" + attachBean.getAttachID() + "&amp;offset=" + offset)%>">[<fmt:message key="mvnforum.common.action.edit"/>]</a>&nbsp;
<%}%>
          <img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/attach.gif" border="0" alt="<fmt:message key="mvnforum.common.attachment"/>" />
          <a class="command" href="<%=urlResolver.encodeURL(request, response, "getattachment?attach=" + attachBean.getAttachID(), URLResolverService.ACTION_URL)%>"><%=attachBean.getAttachFilename()%></a>
          (<%=attachBean.getAttachFileSize()%> bytes)
          (<fmt:message key="mvnforum.common.attachment.download_count"/>: <%=attachBean.getAttachDownloadCount()%>)
          <%
          String enablethumbnail = "";
          if (MVNForumConfig.getEnableThumbnail()) {
              enablethumbnail = "thumbnail=yes&amp;";
          }
          %>
          <%if (attachBean.getAttachDesc().length() > 0) {%>(<%=MyUtil.filter(attachBean.getAttachDesc(), false/*html*/, true/*emotion*/, true/*mvnCode*/, false/*newLine*/, true/*URL*/)%>)<%}%><br/>
          <%if (attachBean.getAttachMimeType().startsWith("image/") && (permission.canGetAttachment(forumID) || MVNForumConfig.getEnableGuestViewImageAttachment()) ) {%>
              <a class="command" href="<%=urlResolver.encodeURL(request, response, "getattachment?attach=" + attachBean.getAttachID(), URLResolverService.ACTION_URL)%>">
                <img src="<%=urlResolver.encodeURL(request, response, "getattachment?" + enablethumbnail + "attach=" + attachBean.getAttachID(), URLResolverService.ACTION_URL)%>" alt="<%=attachBean.getAttachFilename()%>" title="<%=attachBean.getAttachFilename()%>" border="0" />
              </a>
          <%}%>
          <br/>
        <%
        }
      }
      %>
      <%if (memberBean != null) {
          String signature = MyUtil.filter(memberBean.getMemberSignature(), false/*html*/, true/*emotion*/, true/*mvnCode*/, true/*newLine*/, true/*URL*/);
          if ( (signature.length() > 0) && MVNForumConfig.getEnableShowSignature() ) { %>
            ----------------------------------------<br/>
            <%=signature%>
        <%}
        }%>

      <%if (postBean.getPostEditCount() > 0) {%>
        ----------------------------------------<br/>
        [<fmt:message key="mvnforum.user.viewthread.edit"/> <%=postBean.getPostEditCount()%> <fmt:message key="mvnforum.user.viewthread.times"/>,
        <fmt:message key="mvnforum.user.viewthread.last_edit_by"/> <a href="<%=urlResolver.encodeURL(request, response, "viewmember?member=" + Encoder.encodeURL(postBean.getLastEditMemberName()))%>" class="memberName"><%=postBean.getLastEditMemberName()%></a> <fmt:message key="mvnforum.common.at"/> <%=onlineUser.getGMTTimestampFormat(postBean.getPostLastEditDate())%>]
      <%}%>
      <%if ( (postBean.getParentPostID() == 0) && (mvnForumAdService.getAdZone(MvnForumAdService.ZONE_NAME_FORUM_FIRST_POST) > 0) ) {%>
        <br/>
        <%=mvnForumAdService.getZone(mvnForumAdService.getAdZone(MvnForumAdService.ZONE_NAME_FORUM_FIRST_POST))%>
      <%}%>
      <%if ( (lastPostCount%memberPostsPerPage == 1) && (postBean.getParentPostID() != 0) && (mvnForumAdService.getAdZone(MvnForumAdService.ZONE_NAME_FORUM_FIRST_POST_PAGE_2) > 0) ) {%>
        <br/>
        <%=mvnForumAdService.getZone(mvnForumAdService.getAdZone(MvnForumAdService.ZONE_NAME_FORUM_FIRST_POST_PAGE_2))%>
      <%}%>
      <%if ( false ) {
          if ( (lastPostCount%2 == 0) && (mvnForumAdService.getAdZone(MvnForumAdService.ZONE_NAME_FORUM_LAST_ODD_POST) > 0) ) {%>
        <br/>
        <%=mvnForumAdService.getZone(mvnForumAdService.getAdZone(MvnForumAdService.ZONE_NAME_FORUM_LAST_ODD_POST))%>
        <%}
          if ( (lastPostCount%2 == 1) && (mvnForumAdService.getAdZone(MvnForumAdService.ZONE_NAME_FORUM_LAST_EVEN_POST) > 0) ) {%>
        <br/>
        <%=mvnForumAdService.getZone(mvnForumAdService.getAdZone(MvnForumAdService.ZONE_NAME_FORUM_LAST_EVEN_POST))%>
        <%}
        }%>
    </td>
  </tr>
  <tr class="<mvn:cssrow wantToReturn="<%=(postBean.getParentPostID() == 0)%>" valueToReturn="trow0" autoIncrease="false"/>">
    <td>
      <table class="noborder" width="100%" cellpadding="0" cellspacing="0">
        <tr class="<mvn:cssrow wantToReturn="<%=(postBean.getParentPostID() == 0)%>" valueToReturn="trow0" autoIncrease="false"/>">
          <td nowrap="nowrap">
          [<%=onlineUser.getGMTTimestampFormat(postBean.getPostCreationDate())%>]
          <%if (permission.canAdminSystem()) {%>
            <%if (postBean.getPostEditCount() > 0) { /* has edited*/%>
              [<fmt:message key="mvnforum.common.member.first_ip"/>: <font color="red"><%=postBean.getPostCreationIP()%></font> - <fmt:message key="mvnforum.common.member.last_ip"/>: <font color="red"><%=postBean.getPostLastEditIP()%></font>]
            <%} else {/* never been edited*/%>
              [<font color="red"><%=postBean.getPostCreationIP()%></font>]
            <%}%>
          <%}%>
            <a href="<%=urlResolver.encodeURL(request, response, "printpost?post=" + postBean.getPostID())%>"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/printer.gif" border="0" alt="<fmt:message key="mvnforum.user.viewthread.link.print_post"/>" title="<fmt:message key="mvnforum.user.viewthread.link.print_post"/>" /></a>
          </td>
          <td width="100%">
            <%if (memberBean!=null) {%>
              &nbsp;&nbsp;&nbsp;<a href="<%=urlResolver.encodeURL(request, response, "viewmember?member=" + Encoder.encodeURL(memberBean.getMemberName()))%>"><img src="<%=imagePath%>/button_profile.gif" border="0" alt="<fmt:message key="mvnforum.user.viewmember.title"/>" title="<fmt:message key="mvnforum.user.viewmember.title"/>" /></a>
              <%if (MVNForumConfig.getEnablePrivateMessage()) { %>&nbsp;&nbsp;&nbsp;<a href="<%=urlResolver.encodeURL(request, response, "addmessage?MessageToList=" + Encoder.encodeURL(memberBean.getMemberName()))%>"><img src="<%=imagePath%>/button_pm.gif" border="0" alt="<fmt:message key="mvnforum.user.addmessage.title"/>" title="<fmt:message key="mvnforum.user.addmessage.title"/>" /></a><%}%>
              <%if ((memberBean.getMemberEmailVisible() == 1) && MVNForumConfig.getEnableShowEmail()) {
                  if (onlineUser.isGuest()) {%>
                    &nbsp;&nbsp;&nbsp;<img src="<%=imagePath%>/button_email.gif" border="0" alt="<fmt:message key="mvnforum.common.member.email.hidden_to_guest"/>" title="<fmt:message key="mvnforum.common.member.email.hidden_to_guest"/>" />
                <%} else { %>
                    &nbsp;&nbsp;&nbsp;<a href="mailto:<%=memberBean.getMemberEmail()%>"><img src="<%=imagePath%>/button_email.gif" border="0" alt="<%=memberBean.getMemberEmail()%>" title="<%=memberBean.getMemberEmail()%>" /></a>
                <%}
                } %>
               
              <%if ((MVNForumConfig.getEnableShowHomepage()) && (memberBean.getMemberHomepage().length() > 0) && (memberBean.getMemberHomepage().equals("http://")==false)) {%>&nbsp;&nbsp;&nbsp;<a href="<%=memberBean.getMemberHomepage_http()%>"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/www.gif" border="0" alt="<%=memberBean.getMemberHomepage()%>" title="<%=memberBean.getMemberHomepage()%>" /></a><%}%>
              <%if ((MVNForumConfig.getEnableShowYahoo()) && memberBean.getMemberYahoo().length() > 0) {%>&nbsp;&nbsp;&nbsp;<a href="http://edit.yahoo.com/config/send_webmesg?.target=<%=memberBean.getMemberYahoo()%>&amp;.src=pg"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/yim.gif" border="0" alt="<%=memberBean.getMemberYahoo()%>" title="<%=memberBean.getMemberYahoo()%>" /></a><%}%>
              <%if ((MVNForumConfig.getEnableShowAOL()) && memberBean.getMemberAol().length() > 0) {%>&nbsp;&nbsp;&nbsp;<a href="aim:goim?screenname=<%=memberBean.getMemberAol()%>&amp;message=Hello+Are+you+there?"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/aim.gif" border="0" alt="<%=memberBean.getMemberAol()%>" title="<%=memberBean.getMemberAol()%>" /></a><%}%>
              <%if ((MVNForumConfig.getEnableShowICQ()) && memberBean.getMemberIcq().length() > 0) {%>&nbsp;&nbsp;&nbsp;<a href="http://wwp.icq.com/scripts/search.dll?to=<%=memberBean.getMemberIcq()%>"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/icq.gif" border="0" alt="<%=memberBean.getMemberIcq()%>" title="<%=memberBean.getMemberIcq()%>" /></a><%}%>
            <%} else { /*guest*/%>
                &nbsp;
            <%}%>
          </td>
          <td nowrap="nowrap">
            <a href="#<%=postBean.getPostID()%>">[<fmt:message key="mvnforum.user.viewthread.current_link"/>]</a>
            <%if (onlineUser.isGuest()) {%>
              <img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/threat.gif" border="0" alt="<fmt:message key="mvnforum.user.viewthread.report_need_login"/>" title="<fmt:message key="mvnforum.user.viewthread.report_need_login"/>" />
            <%} else { 
                if (MVNForumConfig.getEnableEmailThreateningContent()) {
            %>  
            <a href="<%=urlResolver.encodeURL(request, response, "sendmail?ToAdmin=true&amp;Subject=Report threatening content (ThreadID = " + postBean.getThreadID() + " and PostID = " + postBean.getPostID()+ ")")%>"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/threat.gif" border="0" alt="Report threatening content to Admin" title="Report threatening content to Admin" /></a>
              <%} else { %>
            <a href="mailto:<%=MVNForumConfig.getWebMasterEmail()%>?subject=Report threaten message (threadid = <%=postBean.getThreadID()%> and postid = <%=postBean.getPostID()%>)"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/threat.gif" border="0" alt="<fmt:message key="mvnforum.user.viewthread.report"/>" title="<fmt:message key="mvnforum.user.viewthread.report"/>" /></a>
              <%}            
            } %>
            &nbsp;<a href="#"><img src="<%=contextPath%>/mvnplugin/mvnforum/images/icon/up.gif" border="0" alt="<fmt:message key="mvnforum.user.viewthread.go_top"/>" title="<fmt:message key="mvnforum.user.viewthread.go_top"/>" /></a>&nbsp;
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</span>
</mvn:cssrows>
</mvn:html>
</fmt:bundle>