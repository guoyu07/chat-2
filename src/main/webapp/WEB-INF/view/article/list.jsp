<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/27
  Time: 13:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/header.jsp" flush="true"/>
<ul class="list-group" style="width: 30%">
    <c:forEach items="${page.list}" var="article">
        <li class="list-group-item">
            <span class="badge">${article.authorName}</span>
            <a href="/article/details?id=${article.id}">${article.title}</a>
        </li>
    </c:forEach>
</ul>
<ul class="pagination">
    <li <c:if test="${page.pageNumber - 1 < 1}">class="disabled"</c:if>>
        <c:if test="${page.pageNumber - 1 < 1}">
            <a href="#">上一页</a>
        </c:if>
        <c:if test="${page.pageNumber - 1 >= 1}">
            <a href="/article/list?p=${page.pageNumber - 1}">上一页</a>
        </c:if>
    </li>
    <li class="active"><a href="#">${page.pageNumber}</a></li>
    <li <c:if test="${page.pageNumber + 1 > page.totalPage}">class="disabled"</c:if>>
        <c:if test="${page.pageNumber + 1 > page.totalPage}">
            <a href="#">下一页</a>
        </c:if>
        <c:if test="${page.pageNumber + 1 <= page.totalPage}">
            <a href="/article/list?p=${page.pageNumber + 1}">下一页</a>
        </c:if>
    </li>
</ul>
</body>
</html>
