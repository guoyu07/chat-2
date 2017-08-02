<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/2
  Time: 11:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>文章列表 - chat</title>
    <meta name="keywords" content="chat">
    <meta name="description" content="chat">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css-v=3.3.5.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/font-awesome.min.css-v=4.4.0.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/style.min.css-v=4.0.0.css" rel="stylesheet">
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content  animated fadeInRight blog">
    <div class="row">
        <c:forEach items="${page.list}" var="article">
            <c:if test="${way == 'list'}">
                <div class="col-lg-4">
            </c:if>
            <div class="ibox">
                <div class="ibox-content">
                    <a href="${pageContext.request.contextPath}/article/detail?id=${article.id}&way=${way}&p=${page.pageNumber}" class="btn-link">
                        <h2>
                            ${article.title}
                        </h2>
                    </a>
                    <div class="small m-b-xs">
                        <strong>${article.authorName}</strong> <span class="text-muted"><i class="fa fa-clock-o"></i>  <fmt:formatDate value="${article.pubtime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                    </div>
                    <p>
                        ${article.desc}
                    </p>
                    <div class="row">
                        <div class="col-md-6">
                            <h5>标签：</h5>
                            <%--<button class="btn btn-white btn-xs" type="button">调查</button>--%>
                            <c:forEach items="${fn:split(article.keywords,' ')}" var="key">
                                <button class="btn btn-primary btn-xs" type="button">${key}</button>
                            </c:forEach>
                        </div>
                        <div class="col-md-6">
                            <div class="small text-right">
                                <h5>状态：</h5>
                                <div> <i class="fa fa-comments-o"> </i> ${article.comments} 评论 </div>
                                <i class="fa fa-eye"> </i> ${article.readNum} 浏览
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <c:if test="${way == 'list'}">
                </div>
            </c:if>
        </c:forEach>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js-v=2.1.4.js" tppabs="http://www.zi-han.net/theme/hplus/js/jquery.min.js?v=2.1.4"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js-v=3.3.5.js" tppabs="http://www.zi-han.net/theme/hplus/js/bootstrap.min.js?v=3.3.5"></script>
<script src="${pageContext.request.contextPath}/static/js/content.min.js-v=1.0.0.js" tppabs="http://www.zi-han.net/theme/hplus/js/content.min.js?v=1.0.0"></script>
</body>
</html>