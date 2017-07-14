<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="${pageContext.request.contextPath}/header.jsp" flush="true"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/api/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/api/jquery.mobile.flatui.css" />
<ul id="myTab" class="nav nav-tabs">
    <li class="active"><a href="#home" data-toggle="tab">全部</a></li>
</ul>
<div id="myTabContent" class="tab-content">
    <div class="tab-pane fade in active" id="home">
        <div data-role="content" class="container" role="main">
            <ul class="content-reply-box mg10" id="msgBox" style="padding-bottom: 100px;">
            </ul>
        </div>
    </div>
</div>
<div id="footer" class="container">
    <nav class="navbar navbar-default navbar-fixed-bottom">
        <div class="navbar-inner navbar-content-center">
            <p class="text-muted credit" style="padding: 5px;">
            <div class="row">
                <div class="col-lg-12">
                    <div class="input-group">
                        <input type="text" class="form-control input-lg" id="message" placeholder="请输入..">
                        <span class="input-group-btn">
                            <button class="btn btn-info btn-lg" type="button" onclick="send();">发送</button>
                        </span>
                    </div>
                </div>
            </div>
            </p>
        </div>
    </nav>
</div>
</body>
</html>
<script type="text/javascript">
    $(function () {
        $('#myTab li:eq(0) a').tab('show');
        $('#message').focus();
        $("body").keydown(function () {
            if (event.keyCode == "13") {//keyCode=13是回车键
                send();
            }
        });
    });

    var websocket = null;
    var auth = new Object();
    auth.to = '';
    auth.toEmail ='';
    auth.msg = '';
    auth.from =  '${sessionScope.loginUser.id}';
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
        if('${sessionScope.loginUser.id}' == json.from)
            html += '<li class="even">';
        else
            html += '<li class="odd">';
        if('${sessionScope.loginUser.id}' == json.from)
            html += '<a class="user" href="javascript:;">';
        else
            html += '<a class="user" href="javascript:;" onclick="choose(this)">';
        html += '<img class="img-responsive avatar_" src="${pageContext.request.contextPath}/images/avatar.png" alt="">';
        html += ' <span class="user-name">' + json.fromEmail + '</span>';
        html += '</a>';
        html += '<div class="reply-content-box">';
        html += '<span class="reply-time"><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())%></span>';
        html += '<div class="reply-content pr" style="float:';
        if('${sessionScope.loginUser.id}' == json.from)
            html += 'right;">';
        else
            html += 'left;">';
        html += '<span class="arrow">&nbsp;</span>';
        html += json.content;
        html += '</div>';
        html += '</div>';
        html += '</li>';
        if(json.to == ''){ // 发送至所有人
            $('#msgBox').append(html);
        }else{ // 发送给固定用户

        }
    }

    //关闭连接
    function closeWebSocket() {
        websocket.close();
    }

    //发送消息
    function send() {
        var message = $('#message');
        auth.msg = message.val();
        var who = $('li[class="active"]').children('a').attr('href');
        if(who == '#home'){
            websocket.send(getMsg());
        }else{

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

    function choose(user) {
        var flag = false;
        var id = $("#myTab li[class='active']").children('a').attr('href');
        $('#myTab li').each(function () {
            if ($(this).children('a').attr('href') == ("#" + user.text)) {
                alert('已存在!');
                flag = true;
                return false;
            }
        })
        $('#myTab li').each(function () {
            $(this).attr('class', '');
            var href = $(this).children('a').attr('href');
            href = href.substring(1, href.length);
            $('#' + href).attr('class', 'tab-pane fade');
        })
        if (!flag) {
            var name = id.substring(1, id.length);
            $("#myTab li[class='active']").removeAttr('class');
            $('#myTab').append("<li class='active'><a href='#" + user.text + "' data-toggle='tab'>" + user.text + "</a></li>");
            $('#myTabContent').append("<div class='tab-pane fade active in' id='" + user.text + "'></div>");
        }
    }
</script>