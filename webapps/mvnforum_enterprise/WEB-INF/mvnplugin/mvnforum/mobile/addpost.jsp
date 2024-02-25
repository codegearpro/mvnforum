<?xml version="1.0" encoding="UTF-8"?>
<%--
  - $Header: /home/cvsroot/mvnforum_enterprise/srcweb/WEB-INF/mvnplugin/mvnforum/mobile/addpost.jsp,v 1.13 2009/03/11 09:11:54 trungth Exp $
  - $Author: trungth $
  - $Revision: 1.13 $
  - $Date: 2009/03/11 09:11:54 $
  -
  - ====================================================================
  -
  - Copyright (C) 2002-2007 by MyVietnam.net
  -
  - MyVietnam.net PROPRIETARY/CONFIDENTIAL PROPERTIES. Use is subject to license terms.
  - You CANNOT use this software unless you receive a written permission from MyVietnam.net
  -
  - @author: Nhan Luu Duy
  -
--%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.1//EN"
  "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile11.dtd">
  
<%@ page errorPage="fatalerror.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="net.myvietnam.mvncore.util.*" %>
<%@ page import="net.myvietnam.mvncore.exception.BadInputException" %>
<%@ page import="net.myvietnam.mvncore.util.ParamUtil" %>
<%@ page import="net.myvietnam.mvncore.filter.EnableEmotionFilter" %>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter" %>
<%@ page import="net.myvietnam.mvncore.filter.EnableHtmlTagFilter" %>
<%@ page import="net.myvietnam.mvncore.filter.EnableMVNCodeFilter" %>
<%@ page import="net.myvietnam.mvncore.interceptor.InterceptorService"%>
<%@ page import="net.myvietnam.mvncore.security.Encoder" %>
<%@ page import="com.mvnforum.MVNForumResourceBundle" %>
<%@ page import="com.mvnforum.MVNForumGlobal" %>
<%@ page import="com.mvnforum.MyUtil" %>
<%@ page import="com.mvnforum.db.*" %>
<%@ include file="inc_common.jsp"%>

<fmt:bundle basename="i18n/mvnforum/mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
    <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/></mvn:title>
    <link href="<%=contextPath%>/mvnplugin/mvnforum/css/styleMobile.css" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<div class="topmenu"><a href="index"><fmt:message key="mvnforum.mobile.main_menu"/></a></div>
<br/>
<div id="bullet">
<%
int parentPostID = 0;
try {
    parentPostID = ParamUtil.getParameterInt(request, "parent");
} catch (BadInputException e) {
    // do nothing
}
boolean isQuote = ParamUtil.getParameterBoolean(request, "quote");
boolean isPreviewing = ParamUtil.getParameterBoolean(request, "preview");
boolean attachMore = ParamUtil.getParameterBoolean(request, "AttachMore");
boolean addPoll = ParamUtil.getParameterBoolean(request, "AddPoll");
boolean addFavoriteThread = ParamUtil.getParameterBoolean(request, "AddFavoriteParentThread");
boolean addWatchThread = ParamUtil.getParameterBoolean(request, "AddWatchParentThread");

String action = ParamUtil.getAttribute(request, "action");
if (action == null) action = "";

String mode;
String fullmode;
String replyTopic = "";
String postTopic = "";
String postBody = "";
String postIcon = "";
String previewUrl = "";
int threadPriority = 0;

PostBean postToEdit = null;// use when edit a post
PostBean parentPostBean = null;//use when reply to a post

String previewAction = "addpost";
if (action.equals("addnew")) {
    previewUrl = "addpost";
    if (parentPostID == 0) {
        mode = MVNForumResourceBundle.getString(onlineUser.getLocale(), "mvnforum.user.addpost.mode.addnew");
        fullmode = mode;
        replyTopic = "";
    } else {
        mode = MVNForumResourceBundle.getString(onlineUser.getLocale(), "mvnforum.user.addpost.mode.reply");
        // this is the parent of the reply
        parentPostBean = (PostBean)request.getAttribute("ParentPostBean");

        String REPLY_PREFIX = "Re: ";
        String parentPostTopic = parentPostBean.getPostTopic();
        if (parentPostTopic.startsWith(REPLY_PREFIX)) {
            postTopic = parentPostTopic;
        } else {
            postTopic = REPLY_PREFIX + parentPostTopic;
        }
        if (isQuote) {
            postBody = "[quote]" + parentPostBean.getPostBody() + "[/quote]\n";
        }
        replyTopic = parentPostBean.getPostTopic();
        fullmode = mode + " : " + replyTopic;
    }
} else {
    throw new BadInputException("Cannot find the action!");
}
if (isPreviewing) {
    postTopic = ParamUtil.getParameter(request, "PostTopic", true);
    postTopic = DisableHtmlTagFilter.filter(postTopic);// always disable HTML
    //postTopic = InterceptorService.getInstance().validateContent(postTopic);// we cannot call this method because it could throw Exception

    postBody = ParamUtil.getParameter(request, "message", true);// use message instead of MessageBody
    postBody = DisableHtmlTagFilter.filter(postBody);// always disable HTML
    //postBody = InterceptorService.getInstance().validateContent(postBody);// we cannot call this method because it could throw Exception

    //postIcon = ParamUtil.getParameter(request, "PostIcon");
    //postIcon = DisableHtmlTagFilter.filter(postIcon);// always disable HTML
    
    if (parentPostID == 0) {
        threadPriority = ParamUtil.getParameterInt(request, "ThreadPriority");
    }
}
CategoryCache categoryCache = CategoryCache.getInstance();
ForumCache forumCache = ForumCache.getInstance();
Collection categoryBeans = categoryCache.getBeans();
Collection forumBeans = forumCache.getBeans();

int forumID;
if (action.equals("addnew")) {
    if (parentPostID == 0) {// new thread
        forumID = ParamUtil.getParameterInt(request, "forum");
    } else {//reply to a post
        forumID = parentPostBean.getForumID();
    }
} else {//edit mode
    forumID = postToEdit.getForumID();
}
String forumName = forumCache.getBean(forumID).getForumName();
if (isPreviewing) {
    
    String prePostTopic = (String)request.getAttribute("prePostTopic");
    String prePostBody  = (String)request.getAttribute("prePostBody");
    //String prePostIcon  = (String)request.getAttribute("prePostIcon");
    
    MemberBean memberBean = (MemberBean)request.getAttribute("MemberBean");
}%> 
<%if (action.equals("addnew")) {%>
<form action="addpostprocess" method="post" name="mvnform">
    <input type="hidden" name="forum" value="<%=ParamUtil.getParameter(request, "forum")%>" />
    <input type="hidden" name="parent" value="<%=parentPostID%>" />
    <label for="PostTopic"><fmt:message key="mvnforum.common.post.topic"/></label> <span>*</span>   
    <span><input id="PostTopic" name="PostTopic" class="login" type="text" value="<%=postTopic%>" /></span>
    <span><textarea name="message" cols="15" rows="5" class="text_area"></textarea></span>
    <input type="submit" name="submitbutton" value="<%=mode%>" class="but_log"/>    
</form>
<%}%>
</div>     
</mvn:body>
</mvn:html>
</fmt:bundle>
