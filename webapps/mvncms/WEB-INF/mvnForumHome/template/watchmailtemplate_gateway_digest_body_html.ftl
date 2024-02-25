<br/>mvnForum Watch Summary
<br/>New Threads since: ${lastSent}
<br/>Compiled at: ${now}
<br/>---------------------------------------
<br/>For the latest Forum updates, visit : <a href="${forumBase}/index">${forumBase}/index</a>
<br/>---------------------------------------
<br/>
<#list threadWatchList as mailbeans >
  <#if mailbeans.leader >
<br/>[Category: ${mailbeans.categoryName}] [Forum: ${mailbeans.forumName}]
  </#if>    
<br/>    Thread [${mailbeans.threadTopic}] given to us by ${mailbeans.memberName}
<br/>    Thread body
<br/>    ${mailbeans.threadBodyLong}
<br/>
<br/>      last posted by ${mailbeans.lastPostMemberName} on ${mailbeans.threadLastPostDate}
<br/>      <a href="${mailbeans.threadUrl}">${mailbeans.threadUrl}</a>
<br/>    Please <a href="mailto:${mailbeans.mailFrom}?subject=Reply:[mvnForum] - Reply for thread ${mailbeans.threadTopic}<#if mailbeans.haveConfirmedCode>&body=Please input your reply between the ThreadBody tag.%0A[THREADBODY]%0A%0A[/THREADBODY]%0ANOTE: Below is information we need to confirm your reply email. Please DO NOT remove or change it on your reply%0A[THREADID = ${mailbeans.threadID}]%0A[MEMBERNAME = ${mailbeans.memberReceiveMail}]%0A[CONFIRMEDCODE = ${mailbeans.confirmedCode}]<#else>&body=Please input your reply between the ThreadBody tag.%0A[THREADBODY]%0A%0A[/THREADBODY]%0A>[THREADID = ${mailbeans.threadID}]%0A>[MEMBERNAME = ${mailbeans.memberReceiveMail}]</#if>">click here</a> to reply this post
<br/>
</#list>
<br/>
<br/>
<br/>This is not a spam mail. If you would not like to receive this email,
<br/>please visit : <a href="${forumBase}/mywatch">${forumBase}/mywatch</a>