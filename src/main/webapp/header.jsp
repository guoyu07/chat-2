<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} - chat</title>
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript"></script>
</head>
<body>
<nav class="navbar navbar-inverse" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="/">chat</a>
        </div>
        <div>
            <ul class="nav navbar-nav navbar-left">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        API <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath}/api/dream">周公解梦</a></li>
                        <li class="divider"></li>
                        <li><a href="${pageContext.request.contextPath}/api/mobile">手机号查询</a></li>
                        <li class="divider"></li>
                        <li><a href="${pageContext.request.contextPath}/api/todayOnHistory">历史上的今天</a></li>
                    </ul>
                </li>
                <li><a href="${pageContext.request.contextPath}/api/robot">robot</a></li>
                <li><a href="${pageContext.request.contextPath}/music/listSongs">music</a></li>
                <li><a href="${pageContext.request.contextPath}/api/weather">weather</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        文章 <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath}/article/list">所有文章</a></li>
                        <li class="divider"></li>
                        <li><a href="${pageContext.request.contextPath}/article/mylist">我的文章</a></li>
                        <li class="divider"></li>
                        <li><a href="${pageContext.request.contextPath}/article/add">写文章</a></li>
                    </ul>
                </li>
                <li>
                    <form class="navbar-form navbar-left" role="search">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="can't search,can only see" disabled="disabled">
                        </div>
                        <%--<button type="submit" class="btn btn-default" disabled="disabled">搜索</button>--%>
                    </form>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <c:choose>
                    <c:when test="${empty sessionScope.loginUser}">
                        <%--<li class="active"></li>--%>
                        <li><a href="/user/register"><span class="glyphicon glyphicon-user"></span>&nbsp;注册</a></li>
                        <li><a href="/user/login"><span class="glyphicon glyphicon-log-in"></span>&nbsp;登录</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    ${loginUser.email} <span class="badge">42</span><b class="caret"></b>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href="/user/my">个人信息</a></li>
                                <li><a href="#">消息<span class="badge pull-right">42</span></a></li>
                            </ul>
                        </li>
                        <li><a href="/user/exit">退出</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
<!-- 空气质量 -->
<script>
   function songs(){
       $.ajax({
           async: false,
           type: "POST",
           url: "${pageContext.request.contextPath}/api/songs",
           dataType: "JSON",
           success: function (data) {
               alert(data.song[0].url);
                   $('#songs').attr('src',data.song[0].url);
           },
           error: function (XMLHttpRequest, textStatus, errorThrown) {
           }
       });
   }

   function openWin() {
       var url = "";
       var name='二维码';                          //网页名称，可为空;
       var iWidth=600;                          //弹出窗口的宽度;
       var iHeight=250;                         //弹出窗口的高度;
       //获得窗口的垂直位置
       var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
       //获得窗口的水平位置
       var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
       window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',status=no,toolbar=no,menubar=no,location=no,resizable=no,scrollbars=0,titlebar=no');
   }
</script>