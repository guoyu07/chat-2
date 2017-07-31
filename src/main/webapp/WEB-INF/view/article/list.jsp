<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/27
  Time: 13:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/header.jsp" flush="true"/>
<style>
    .table th, .table td {
        text-align: center;
        height: 38px;
    }

    table {
        margin: 0 auto;
        text-align: center;
    }
</style>
<table class="table table-hover" style="width: 60%">
    <tr>
        <td>标题</td>
        <td>作者</td>
        <td>发布日期</td>
    </tr>
    <c:forEach items="${page.list}" var="article">
        <tr>
            <td><a href="/article/detail?id=${article.id}">${article.title}</a></td>
            <td><span class="badge">${article.authorName}</span</td>
            <td><fmt:formatDate value="${article.pubtime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
        </tr>
    </c:forEach>
    <tr>
        <td>
                <c:if test="${page.pageNumber - 1 < 1}">
                    <a href="#" style="color: #8D8D8D;">上一页</a>
                </c:if>
                <c:if test="${page.pageNumber - 1 >= 1}">
                    <a href="/article/${way}?p=${page.pageNumber - 1}">上一页</a>
                </c:if>
        </td>
        <td>
            <a href="#" style="color: #8D8D8D;">${page.pageNumber}</a>
        </td>
        <td>
                <c:if test="${page.pageNumber + 1 > page.totalPage}">
                    <a href="#" style="color: #8D8D8D;">下一页</a>
                </c:if>
                <c:if test="${page.pageNumber + 1 <= page.totalPage}">
                    <a href="/article/${way}?p=${page.pageNumber + 1}">下一页</a>
                </c:if>
        </td>
    </tr>
</table>
</body>
</html>
