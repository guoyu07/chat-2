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
            <ul class="content-reply-box mg10" style="padding-bottom: 100px;">
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
        $("body").keydown(function (e) {
            if (e.keyCode == "13") {//keyCode=13是回车键
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
            html += '<a class="user" href="javascript:;" data="'+json.from+'" onclick="choose(this)">';
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
        // 获取当前选中
        var href = $('.active').children('a').attr('href');
        href = href.substring(1,href.length);
        if(json.to == ''){ // 发送至所有人
            $('#'+href).children().children().append(html);
        }else{ // 发送给固定用户
            if(json.from == '${sessionScope.loginUser.id}'){ // 发送者显示
                $('#'+href).children().children().append(html);
            }
            if(json.to == '${sessionScope.loginUser.id}'){ // 接收者显示
                var flag = false;
                $('#myTab li').each(function () {
                    if($(this).children('a').attr('href') == ('#'+json.from)){ // 如果已存在,切换至
                        $('#myTab li').each(function () { // 清除
                            $(this).attr('class', '');
                            $($(this).children('a').attr('href')).attr('class', 'tab-pane fade');
                        });
                        // 设置
                        $(this).attr('class', 'active');
                        $('#' + json.from).attr('class', 'tab-pane fade in active');
                        $('#'+json.from).children().children().append(html);
                        flag = true;
                        return false;
                    }
                });
                if(!flag) {
                    // 不存在则添加聊天界面
                    $('#myTab li').each(function () { // 清除
                        $(this).attr('class', '');
                        $($(this).children('a').attr('href')).attr('class', 'tab-pane fade');
                    });
                    $('#myTab').append("<li class='active'><a href='#" + json.from + "' data-toggle='tab'>" + json.fromEmail + "</a></li>");
                    var otherHtml = '';
                    otherHtml += '<div class="tab-pane fade in active" id="' + json.from + '">';
                    otherHtml += '<div data-role="content" class="container" role="main">';
                    otherHtml += '<ul class="content-reply-box mg10" style="padding-bottom: 100px;">';
                    otherHtml += html;
                    otherHtml += '</ul>';
                    otherHtml += '</div>';
                    otherHtml += '</div>';
                    $('#myTabContent').append(otherHtml);
                }
            }
        }
    }

    //关闭连接
    function closeWebSocket() {
        websocket.close();
    }

    //发送消息
    function send() {
        if('${sessionScope.loginUser}' != '') {
            var message = $('#message');
            auth.msg = message.val();
            var who = $('li[class="active"]').children('a').attr('href');
            if (who == '#home') {
                auth.to = '';
                auth.toEmail = '';
                websocket.send(getMsg());
            } else { // 发送给其他人
                var to = $('li[class="active"]').children('a').attr('href');
                var toEmail = $.trim($('li[class="active"]').children('a').text());
                auth.to = to.substring(1, to.length);
                auth.toEmail = toEmail;
                websocket.send(getMsg());
            }
        }else{
            layer.msg('登录后才可以发送消息哦', function(){
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

    function choose(user) {
        var flag = false;
        var data = $(user).attr('data');
        $('#myTab li').each(function () { // 验证是否已打开聊天窗口
            if ($(this).children('a').attr('href') == ('#'+data)) {
                flag = true;
            }
        })
        $('#myTab li').each(function () { // 清除
            $(this).attr('class', '');
            $($(this).children('a').attr('href')).attr('class', 'tab-pane fade');
        });
        if (!flag) {
            $("#myTab li[class='active']").removeAttr('class');
            $('#myTab').append("<li class='active'><a href='#" + data + "' data-toggle='tab'>" + user.text + "</a></li>");
            var html = '';
            html += '<div class="tab-pane fade in active" id="' + data + '">';
            html += '<div data-role="content" class="container" role="main">';
            html += '<ul class="content-reply-box mg10" style="padding-bottom: 100px;">';
            html += '</ul>';
            html += '</div>';
            html += '</div>';
            $('#myTabContent').append(html);
        } else {
            $('#myTab li').each(function () { // 切换至聊天窗口
                if ($(this).children('a').attr('href') == ('#' + data)) {
                    $(this).attr('class', 'active');
                }
            });
            $('#' + data).attr('class', 'tab-pane fade in active');
        }
    }
</script>