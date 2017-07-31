<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/31
  Time: 13:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/header.jsp" flush="true"/>
<style>
    .keywords {
        font-size: 16px;
        color: #49ab4f;
    }

    .title {
        width: 80%;
        margin:0 auto;
        text-align: center;
    }

    .content{
        width: 80%;
        margin:0 auto;
    }
</style>
<div class="title">
    <h1>${article.title}</h1>
    <span style="margin-left: 200px;">
            <fmt:formatDate value="${article.pubtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
            <a href="${article.authorId}">${article.authorName}</a>
            </span>
</div>
<div class="content">
    <c:forEach items="${fn:split(article.keywords,' ')}" var="key">
        <a href="${key}" class="keywords">#${key}#</a>&nbsp;
    </c:forEach>
</div>
<div class="content">
    <td>${article.content}</td>
</div>
</body>
</html>
