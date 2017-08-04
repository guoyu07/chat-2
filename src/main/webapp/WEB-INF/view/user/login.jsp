<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/1
  Time: 11:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录 - chat</title>
    <meta name="keywords" content="chat">
    <meta name="description" content="chat">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css-v=3.3.5.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/font-awesome.min.css-v=4.4.0.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/style.min.css-v=4.0.0.css" rel="stylesheet">
    <%--<base target="_blank">--%>
    <!--[if lt IE 8]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
    <script>if(window.top !== window.self){ window.top.location = window.location;}</script>
</head>

<body class="gray-bg">

<div class="middle-box text-center loginscreen  animated fadeInDown">
    <div>
        <div>
            <h1 class="logo-name">chat</h1>
        </div>
        <h3>欢迎使用 chat</h3>
        <form class="m-t" role="form" action="/user/login" method="post">
            <div class="form-group">
                <input type="email" name="username" class="form-control" placeholder="用户名" value="${username}" required="">
            </div>
            <div class="form-group">
                <input type="password" minlength="6" maxlength="16" name="user.password" class="form-control" placeholder="密码" required="">
            </div>
            <button type="submit" class="btn btn-primary block full-width m-b">登 录</button>
            <p class="text-muted text-center">
                <a href="/user/forgetPwd"><small>忘记密码了？</small></a> | <a href="/user/register">注册一个新账号</a>
            </p>
        </form>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js-v=2.1.4.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js-v=3.3.5.js"></script>
<script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript"></script>
</body>
<script>
    $(document).ready(function () {
        if ('${loginErrMsg}' != '') {
            layer.msg('${loginErrMsg}', {icon: 5, offset: '250px'});
        }
    });
</script>
</html>