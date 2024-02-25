mvnForum Watch Summary
New Threads since: ${lastSent}
Compiled at: ${now}
---------------------------------------
For the latest Forum updates, visit : ${forumBase}/index
---------------------------------------
<#if threadWatch.haveConfirmedCode >
---------------------------------------
NOTE: Below is information we need to confirm your reply email. Please DO NOT remove or change it on your reply
[MEMBERNAME = ${threadWatch.memberName}]
[CONFIRMEDCODE = ${threadWatch.confirmedCode}]

---------------------------------------
</#if>

<#if threadWatch.leader >
[Category: ${threadWatch.categoryName}] [Forum: ${threadWatch.forumName}]
</#if>
    Thread [${threadWatch.threadTopic}] given to us by ${threadWatch.memberName}
    Thread body
    
    ${threadWatch.threadBodyLong}
    
      last posted by ${threadWatch.lastPostMemberName} on ${threadWatch.threadLastPostDate}
      ${threadWatch.threadUrl}


This is not a spam mail. If you would not like to receive this email,
please visit : ${forumBase}/mywatch

Please input your reply between the [THREADBODY][/THREADBODY] tag.