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
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css-v=3.3.5.css"
          tppabs="http://www.zi-han.net/theme/hplus/css/bootstrap.min.css?v=3.3.5" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/font-awesome.min.css-v=4.4.0.css"
          tppabs="http://www.zi-han.net/theme/hplus/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/plugins/jsTree/style.min.css"
          tppabs="http://www.zi-han.net/theme/hplus/css/plugins/jsTree/style.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/animate.min.css"
          tppabs="http://www.zi-han.net/theme/hplus/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/style.min.css-v=4.0.0.css"
          tppabs="http://www.zi-han.net/theme/hplus/css/style.min.css?v=4.0.0" rel="stylesheet">
    <base target="_blank">
</head>

<body class="gray-bg">
<div class="wrapper wrapper-content  animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox chat-view">
                <div class="ibox-title">
                    <small class="pull-right text-muted"></small>
                    robot
                </div>
                <div class="ibox-content">
                    <div class="row">
                        <div class="col-md-9 " style="width: 100%;">
                            <div class="chat-discussion">
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
    var name = '${sessionScope.loginUser.email}';
    var img = '${sessionScope.loginUser.picSummary}';
    if(img == ''){
        img = "${pageContext.request.contextPath}/static/img/defaultLogo.jpg";
    }
    function send(){
        var msg = $('#message');
        if($.trim(msg.val()) == ''){
            return false;
        }
        var time = new Date().toLocaleString();
        var html = '';
        html += '<div class="chat-message">';
        html += '<img class="message-avatar" src="'+img+'" alt="" width="64px" height="64px">';
        html += '<div class="message">';
        html += '<a class="message-author" href="#">' + name + '</a>';
        html += '<span class="message-date"><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())%></span>';
        html += '<span class="message-content">';
        html += msg.val();
        html += '</span>';
        html += '</div>';
        html += '</div>';
        $.ajax({
            async : false,
            type : "POST",
            url : "${pageContext.request.contextPath}/social/robot",
            data : {
                question : msg.val()
            },
            dataType : "JSON",
            success : function(data) {
                html += '<div class="chat-message">';
                html += '<img class="message-avatar" src="${sessionScope.loginUser.picSummary}" alt="" width="64px" height="64px">';
                html += '<div class="message">';
                html += '<a class="message-author" href="#">robot</a>';
                html += '<span class="message-date"><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())%></span>';
                html += '<span class="message-content">';
                html += data.text;
                html += '</span>';
                html += '</div>';
                html += '</div>';
            },
            error : function(XMLHttpRequest, textStatus, errorThrown) {
            }
        });
        $('.chat-discussion').append(html);
        $('.chat-discussion').scrollTop(1000);
    }

    $("body").keydown(function (e) {
        if (e.keyCode == "13") {
            e.preventDefault();
            send();
            $('#message').val("");
        }
    });
</script>
</html>