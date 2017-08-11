<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/11
  Time: 14:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>所有用户 - chat</title>
    <meta name="keywords" content="chat">
    <meta name="description" content="chat">

    <link rel="shortcut icon" href="favicon.ico">
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css-v=3.3.5.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/font-awesome.min.css-v=4.4.0.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/style.min.css-v=4.0.0.css" rel="stylesheet">
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <c:forEach items="${list}" var="u">
            <div class="col-sm-4">
                <div class="contact-box">
                    <a href="/user/profile?id=${u.id}">
                        <div class="col-sm-4">
                            <div class="text-center">
                                <img alt="image" class="img-circle m-t-xs img-responsive" src="${u.picSummary}" style="height: 133.09px; width: 133.09px;">
                                <div class="m-t-xs font-bold">BOT</div>
                            </div>
                        </div>
                        <div class="col-sm-8">
                            <h3><strong>${u.nickname}</strong></h3>
                            <p><i class="fa fa-map-marker"></i> ${u.addressDetails}</p>
                            <address>
                               ${u.description}
                            </address>
                        </div>
                        <div class="clearfix"></div>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js-v=2.1.4.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js-v=3.3.5.js"></script>
<script src="${pageContext.request.contextPath}/static/js/content.min.js-v=1.0.0.js"></script>
<script>
    $(document).ready(function () {
        $(".contact-box").each(function () {
            animationHover(this, "pulse")
        })
    });
</script>
</body>
</html>