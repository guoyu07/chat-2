<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${article.title} - chat</title>
    <meta name="keywords" content="chat">
    <meta name="description" content="chat">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css-v=3.3.5.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/font-awesome.min.css-v=4.4.0.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/style.min.css-v=4.0.0.css" rel="stylesheet">
</head>
<body class="gray-bg">
<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-sm-4">
        <h2><a class="btn-link" href="/article/${way}?p=${p}">返回</a></h2>
    </div>
</div>
<div class="wrapper wrapper-content  animated fadeInRight article">
    <div class="row">
        <div class="col-lg-10 col-lg-offset-1">
            <div class="ibox">
                <div class="ibox-content">
                    <div class="pull-right">
                        <c:forEach items="${fn:split(article.keywords,' ')}" var="key">
                            <button class="btn btn-primary btn-xs" type="button">${key}</button>
                        </c:forEach>
                    </div>
                    <div class="text-center article-title">
                        <h1>
                            ${article.title}
                        </h1>
                    </div>
                    <p>
                      ${article.content}
                    </p>
                    <hr>

                    <div class="row">
                        <div class="col-lg-12">
                            <h2>评论：</h2>
                            <!-- 评论 -->
                            <div class="social-feed-box">
                                <div class="social-avatar">
                                    <a href="" class="pull-left">
                                        <img alt="image" src="${pageContext.request.contextPath}/static/img/a1.jpg">
                                    </a>
                                    <div class="media-body">
                                        <a href="#">
                                            逆光狂胜蔡舞娘
                                        </a>
                                        <small class="text-muted">17 小时前</small>
                                    </div>
                                </div>
                                <div class="social-body">
                                    <p>
                                        好东西，我朝淘宝准备跟进，1折开卖
                                    </p>
                                </div>
                            </div>
                            <!-- 评论 -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js-v=2.1.4.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js-v=3.3.5.js"></script>
<script src="${pageContext.request.contextPath}/static/js/content.min.js-v=1.0.0.js"></script>
</body>
</html>