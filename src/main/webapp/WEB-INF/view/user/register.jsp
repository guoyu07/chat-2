<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/1
  Time: 14:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册 - chat</title>
    <meta name="keywords" content="chat">
    <meta name="description" content="chat">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css-v=3.3.5.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/font-awesome.min.css-v=4.4.0.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/style.min.css-v=4.0.0.css" rel="stylesheet">
    <%--<base target="_blank">--%>
    <script>if (window.top !== window.self) {
        window.top.location = window.location;
    }</script>
</head>

<body class="gray-bg">
<div class="middle-box text-center loginscreen   animated fadeInDown">
    <div>
        <div>
            <h1 class="logo-name">chat</h1>
        </div>
        <h3>创建一个chat新账户</h3>
        <form class="m-t" id="regForm" role="form" action="/user/register" method="post">
            <div class="form-group">
                <input type="text" minlength="2" maxlength="4" class="form-control" name="user.nickname"
                       placeholder="请输入您的姓名" required="">
            </div>
            <div class="form-group">
                <input type="email" class="form-control" name="user.email" placeholder="请输入您的邮箱" required="">
            </div>
            <div class="form-group">
                <input type="password" id="password" minlength="6" maxlength="16" class="form-control"
                       name="user.password" placeholder="请输入您的密码" required="">
            </div>
            <div class="form-group">
                <input type="password" id="repassword" minlength="6" maxlength="16" class="form-control"
                       placeholder="请再次输入您的密码" required="">
            </div>
            <div class="form-group text-left">
                <div class="checkbox i-checks">
                    <label class="no-padding">
                        <input type="checkbox" id="isCheck"><i></i> 我同意注册协议</label>
                </div>
            </div>
            <button type="submit" class="btn btn-primary block full-width m-b">注 册</button>
            <p class="text-muted text-center">
                <small>已经有账户了？</small>
                <a href="/user/login">点此登录</a>
            </p>
        </form>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js-v=2.1.4.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js-v=3.3.5.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins/iCheck/icheck.min.js"></script>
<script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript"></script>
<script>
    $(document).ready(function () {
        $(".i-checks").iCheck({checkboxClass: "icheckbox_square-green", radioClass: "iradio_square-green",})
        if ('${regErrMsg}' != '') {
            layer.msg('${regErrMsg}', {icon: 5, offset: '250px'});
        }
    });
    $('form').submit(function () {
        if ($('#password').val() != $('#repassword').val()) {
            layer.msg('两次输入的密码不一致', {icon: 5, offset: '250px'});
            return false;
        }
        if (!$('#isCheck').is(':checked')) {
            layer.msg('请同意注册协议', {icon: 5, offset: '250px'});
            return false;
        }
    })
</script>
</body>
</html>