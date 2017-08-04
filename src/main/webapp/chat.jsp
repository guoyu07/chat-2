<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/1
  Time: 10:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> 聊天室 - chat</title>
    <meta name="keywords" content="char">
    <meta name="description" content="chat">
    <link rel="shortcut icon" href="favicon.ico" tppabs="http://www.zi-han.net/theme/hplus/favicon.ico">
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css-v=3.3.5.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/font-awesome.min.css-v=4.4.0.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/plugins/jsTree/style.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/style.min.css-v=4.0.0.css" rel="stylesheet">
    <base target="_blank">
</head>

<body class="gray-bg">
<div class="wrapper wrapper-content  animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox chat-view">
                <div class="ibox-title">
                    <small class="pull-right text-muted">最新消息：2017-8-1 16:01:25</small>
                    聊天窗口
                </div>
                <div class="ibox-content">
                    <div class="row">
                        <div class="col-md-9 ">
                            <div class="chat-discussion">

                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="chat-users">
                                <div class="users-list">
                                    <div class="chat-user">
                                        <img class="chat-avatar"
                                             src="${pageContext.request.contextPath}/static/img/a4.jpg"
                                             tppabs="http://www.zi-han.net/theme/hplus/img/a4.jpg" alt="">
                                        <div class="chat-user-name">
                                            <a href="#">伤城Simple</a>
                                        </div>
                                    </div>
                                    <div class="chat-user">
                                        <img class="chat-avatar"
                                             src="${pageContext.request.contextPath}/static/img/a1.jpg"
                                             tppabs="http://www.zi-han.net/theme/hplus/img/a1.jpg" alt="">
                                        <div class="chat-user-name">
                                            <a href="#">从未出现过的风景__</a>
                                        </div>
                                    </div>
                                    <div class="chat-user">
                                        <span class="pull-right label label-primary">在线</span>
                                        <img class="chat-avatar"
                                             src="${pageContext.request.contextPath}/static/img/a2.jpg"
                                             tppabs="http://www.zi-han.net/theme/hplus/img/a2.jpg" alt="">
                                        <div class="chat-user-name">
                                            <a href="#">冬伴花暖</a>
                                        </div>
                                    </div>
                                    <div class="chat-user">
                                        <span class="pull-right label label-primary">在线</span>
                                        <img class="chat-avatar"
                                             src="${pageContext.request.contextPath}/static/img/a3.jpg"
                                             tppabs="http://www.zi-han.net/theme/hplus/img/a3.jpg" alt="">
                                        <div class="chat-user-name">
                                            <a href="#">ZM敏姑娘 </a>
                                        </div>
                                    </div>
                                    <div class="chat-user">
                                        <img class="chat-avatar"
                                             src="${pageContext.request.contextPath}/static/img/a5.jpg"
                                             tppabs="http://www.zi-han.net/theme/hplus/img/a5.jpg" alt="">
                                        <div class="chat-user-name">
                                            <a href="#">才越越</a>
                                        </div>
                                    </div>
                                    <div class="chat-user">
                                        <img class="chat-avatar"
                                             src="${pageContext.request.contextPath}/static/img/a6.jpg"
                                             tppabs="http://www.zi-han.net/theme/hplus/img/a6.jpg" alt="">
                                        <div class="chat-user-name">
                                            <a href="#">时光十年TENSHI</a>
                                        </div>
                                    </div>
                                    <div class="chat-user">
                                        <img class="chat-avatar"
                                             src="${pageContext.request.contextPath}/static/img/a2.jpg"
                                             tppabs="http://www.zi-han.net/theme/hplus/img/a2.jpg" alt="">
                                        <div class="chat-user-name">
                                            <a href="#">刘顰颖</a>
                                        </div>
                                    </div>
                                    <div class="chat-user">
                                        <span class="pull-right label label-primary">在线</span>
                                        <img class="chat-avatar"
                                             src="${pageContext.request.contextPath}/static/img/a3.jpg"
                                             tppabs="http://www.zi-han.net/theme/hplus/img/a3.jpg" alt="">
                                        <div class="chat-user-name">
                                            <a href="#">陈泳儿SccBaby</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="chat-message-form">
                                <div class="form-group">
                                    <textarea class="form-control message-input" name="message" id="message"
                                              placeholder="输入消息内容，按回车键发送"></textarea>
                                </div>
                            </div>
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
<script type="text/javascript">
    $(function () {
        $("#message").keydown(function (e) {
            if (e.keyCode == "13") {//keyCode=13是回车键
                e.preventDefault();
                send();
                $('#message').val("");
            }
        });
    });

    var websocket = null;
    var auth = new Object();
    auth.to = '';
    auth.toEmail = '';
    auth.msg = '';
    auth.from = '${sessionScope.loginUser.id}';
    auth.fromImg = '${sessionScope.loginUser.picSummary}';
    if(auth.fromImg == ''){
        auth.fromImg = "${sessionScope.loginUser.picSummary}";
    }
    auth.fromEmail = '${fn:substring(sessionScope.loginUser.email,0 ,fn:indexOf(sessionScope.loginUser.email,"@") )}';

    //判断当前浏览器是否支持WebSocket
    if ('WebSocket' in window) {
        websocket = new WebSocket("ws://localhost:80/chat");
    }
    else {
        alert('Not support websocket')
    }

    //连接发生错误的回调方法
    websocket.onerror = function () {
        setMessageInnerHTML("连接失败!");
    };

    //连接成功建立的回调方法
    websocket.onopen = function (event) {
//        setMessageInnerHTML("连接成功!");
    }

    //接收到消息的回调方法
    websocket.onmessage = function (event) {
        setMessageInnerHTML(event.data);
    }

    //连接关闭的回调方法
    websocket.onclose = function () {
//        setMessageInnerHTML("关闭连接!");
    }

    //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
    window.onbeforeunload = function () {
        websocket.close();
    }

    //将消息显示在网页上
    function setMessageInnerHTML(data) {
        var json = eval('(' + data + ')');
        var html = '';
        html += '<div class="chat-message">';
        <!-- 需要处理照片为发消息人的照片 -->
        html += '<img class="message-avatar" src="'+auth.fromImg+'" alt="" width="64px" height="64px">';
        html += '<div class="message">';
        html += '<a class="message-author" href="' + json.from + '">' + json.fromEmail + '</a>';
        html += '<span class="message-date"><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())%></span>';
        html += '<span class="message-content">';
        html += json.content;
        html += '</span>';
        html += '</div>';
        html += '</div>';
        $('.chat-discussion').append(html);
        $('.chat-discussion').scrollTop(1000);
    }

    //关闭连接
    function closeWebSocket() {
        websocket.close();
    }

    //发送消息
    function send() {
        if ('${sessionScope.loginUser}' != '') {
            var message = $('#message');
            auth.msg = message.val();
            auth.to = '';
            auth.toEmail = '';
            websocket.send(getMsg());
        } else {
            layer.msg('登录后才可以发送消息哦', function () {
                location.href = '/user/login';
            });
        }
        message.val('');
    }

    function getMsg() {
        var json = '';
        json += '{';
        json += '"to":"' + auth.to + '",';
        json += '"toEmail":"' + auth.toEmail + '",';
        json += '"content":"' + auth.msg + '",';
        json += '"from":"' + auth.from + '",';
        json += '"fromEmail":"' + auth.fromEmail + '"';
        json += '}';
        return json;
    }
</script>
</html>