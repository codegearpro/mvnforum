mvnForum Watch Summary
New Threads since: ${lastSent}
Compiled at: ${now}
---------------------------------------
For the latest Forum updates, visit : ${forumBase}/index
---------------------------------------

<#list threadWatchList as mailbeans >
  <#if mailbeans.leader >
[Category: ${mailbeans.categoryName}] [Forum: ${mailbeans.forumName}]
  </#if>    
    Thread [${mailbeans.threadTopic}] given to us by ${mailbeans.memberName}
    ThreadBody
    ${mailbeans.threadBodyLong}
    
      last posted by ${mailbeans.lastPostMemberName} on ${mailbeans.threadLastPostDate}
      ${mailbeans.threadUrl}
    Please <a href="mailto:${mailbeans.mailFrom}?subject=Reply:[mvnForum] - Reply for thread ${mailbeans.threadTopic}<#if mailbeans.haveConfirmedCode>&body=Please input your reply between the ThreadBody tag.%0A[THREADBODY]%0A%0A[/THREADBODY]%0ANOTE: Below is information we need to confirm your reply email. Please DO NOT remove or change it on your reply%0A[THREADID = ${mailbeans.threadID}]%0A[MEMBERNAME = ${mailbeans.memberReceiveMail}]%0A[CONFIRMEDCODE = ${mailbeans.confirmedCode}]<#else>&body=Please input your reply between the ThreadBody tag.%0A[THREADBODY]%0A%0A[/THREADBODY]%0A>[THREADID = ${mailbeans.threadID}]%0A>[MEMBERNAME = ${mailbeans.memberReceiveMail}]</#if>">click here</a> to reply this post
</#list>


This is not a spam mail. If you would not like to receive this email,
please visit : ${forumBase}/mywatch