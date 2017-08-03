<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/1
  Time: 16:20
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>歌曲列表 - chat</title>
    <meta name="keywords" content="chat">
    <meta name="description" content="chat">
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css-v=3.3.5.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/font-awesome.min.css-v=4.4.0.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/plugins/footable/footable.core.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/style.min.css-v=4.0.0.css" rel="stylesheet">
    <style>
        ul.pagination1 {
            display: inline-block;
            padding: 0;
            margin: 0;
        }

        ul.pagination1 li {display: inline;}

        ul.pagination1 li a {
            color: black;
            float: left;
            padding: 8px 16px;
            text-decoration: none;
        }

        ul.pagination1 li a.active {
            background-color: #4CAF50;
            color: white;
        }

        ul.pagination1 li a:hover:not(.active) {background-color: #ddd;}
        ul.pagination1 li a {
            border: 1px solid #ddd;
        }
        .pagination1 li:first-child a {
            border-top-left-radius: 5px;
            border-bottom-left-radius: 5px;
        }

        .pagination1 li:last-child a {
            border-top-right-radius: 5px;
            border-bottom-right-radius: 5px;
        }
        ul.pagination1 li a {
            margin: 0 4px; /* 0 is for top and bottom. Feel free to change it */
        }
    </style>
</head>
<body class="gray-bg">
<jsp:useBean id="dateValue" class="java.util.Date" />
<div class="wrapper wrapper-content animated fadeInRight" style="height: 100%;">
    <div class="row" style="height: 100%;">
        <div class="col-sm-12" style="height: 100%;">
            <div class="ibox float-e-margins" style="height: 100%;">
                <div class="ibox-title">
                    <h5 id="h5Title">
                        共 <span style="color: #8b0000;">${page.totalRow}</span> 条数据 .
                        &nbsp;&nbsp;当前为第 <span style="color: #8b0000;">${page.pageNumber}</span> 页 ,
                        共 <span style="color: #8b0000;">${page.totalPage}</span> 页 .</h5>
                    <div class="ibox-tools" style="height: 100%;">
                        <!--
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                        -->
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fa fa-wrench"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                            <li><input type="checkbox" name="songs" id="songs"
                                       onclick="showColor(this);" ${songs == null ? '' : 'checked'} />歌曲
                            </li>
                            <li><input type="checkbox" name="album" id="album"
                                       onclick="showColor(this);" ${album == null ? '' : 'checked'} />专辑
                            </li>
                            <li><input type="checkbox" name="singers" id="singers"
                                       onclick="showColor(this);" ${singers == null ? '' : 'checked'} />歌手
                            </li>
                        </ul>
                        <!--
                        <a class="close-link">
                            <i class="fa fa-times"></i>
                        </a>
                        -->
                    </div>
                </div>
                <div class="ibox-content" style="height: 93%;">
                    <input type="text" class="form-control input-sm m-b-xs" id="filter" value="${queryName}" placeholder="请输入要搜索的关键字...">
                    <table class="footable table table-stripped toggle-arrow-tiny" data-page-size="15">
                        <thead>
                        <tr>
                            <th data-toggle="true">歌名</th>
                            <th>MV</th>
                            <th>时长</th>
                            <th>专辑</th>
                            <th>歌手</th>
                            <th data-hide="all"></th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="s" varStatus="status">
                            <tr>
                                <td>
                                    <a href="${s.url}" target="_blank">
                                         <span class="songsSpan1">
                                             <c:if test="${fn:contains(s.name,queryName)}">
                                                 ${fn:substring(s.name,0 ,fn:indexOf(s.name,queryName ))}<span style="color: crimson;">${queryName}</span>${fn:substring(s.name,fn:indexOf(s.name,queryName) + fn:length(queryName) , fn:length(s.name) )}
                                             </c:if>
                                             <c:if test="${not fn:contains(s.name,queryName )}">
                                                 ${s.name}
                                             </c:if>
                                         </span>
                                        <span class="songsSpan2" style="display: none;">
                                                ${s.name}
                                        </span>
                                            ${s.alias == '[]' ? '' : s.alias}
                                    </a>
                                </td>
                                <td><a href="${s.mvurl}" target="_blank">${s.mvurl}</a></td>
                                <td>
                                    <jsp:setProperty name="dateValue" property="time" value="${s.duration}"/>
                                    <fmt:formatDate value="${dateValue}" pattern="mm:ss"/>
                                </td>
                                <td><a href="${s.albumurl}" target="_blank">
                        <span class="albumSpan1">
                        <c:if test="${fn:contains(s.albumname,queryName)}">
                            ${fn:substring(s.albumname,0 ,fn:indexOf(s.albumname,queryName ))}<span style="color: crimson;">${queryName}</span>${fn:substring(s.albumname,fn:indexOf(s.albumname,queryName) + fn:length(queryName) , fn:length(s.albumname) )}
                        </c:if>
                        <c:if test="${not fn:contains(s.albumname,queryName )}">
                            ${s.albumname}
                        </c:if>
                        </span>
                                    <span class="albumSpan2" style="display: none;">
                                            ${s.albumname}
                                    </span>
                                </a></td>
                                <td><a href="${s.homepage}" target="_blank">
                        <span class="singersSpan1">
                        <c:if test="${fn:contains(s.sname,queryName)}">
                            ${fn:substring(s.sname,0 ,fn:indexOf(s.sname,queryName ))}<span style="color: crimson;">${queryName}</span>${fn:substring(s.sname,fn:indexOf(s.sname,queryName) + fn:length(queryName) , fn:length(s.sname) )}
                        </c:if>
                        <c:if test="${not fn:contains(s.sname,queryName )}">
                            ${s.sname}
                        </c:if>
                         </span>
                                    <span class="singersSpan1" style="display: none;">
                                            ${s.sname}
                                    </span>
                                </a></td>
                                <td>
                                    <a href="javascript:;" onclick="openWin('${pageContext.request.contextPath}/music/showQRCode')">查看二维码</a>
                                    <a href="/music/downloadQRCode">下载二维码</a>
                                </td>
                                <td><a href="javascript:;" onclick="playMusic('${s.url}');"><i
                                        class="fa fa-play-circle text-navy"></i> 播放</a></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="6">
                                <ul class="pagination1" style="float: right;">
                                    <li>
                                        <a href="javascript:;" onclick="jump('1${empty queryName ? "" : "&q="}${queryName}')">«</a>
                                    </li>
                                    <li>
                                        <a href="javascript:;" onclick="jump('${page.pageNumber > 1 ? page.pageNumber - 1 : 1}${empty queryName ? "" : "&q="}${queryName}')">‹</a>
                                    </li>
                                    <li>
                                        <a href="#">${page.pageNumber}</a>
                                    </li>
                                    <li>
                                    <a href="javascript:;" onclick="jump('${page.pageNumber + 1 > page.totalPage ? songsPage.totalPage : page.pageNumber + 1}${empty queryName ? "" : "&q="}${queryName}')">›</a>
                                    </li>
                                    <li>
                                        <a href="javascript:;" onclick="jump('${(page.totalPage == '' || page.totalPage == null) ? 1 : page.totalPage}${empty queryName ? '' : '&q='}${queryName}')">»</a>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js-v=2.1.4.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js-v=3.3.5.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins/footable/footable.all.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/content.min.js-v=1.0.0.js"></script>
<script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript"></script>
<script>
    $(function () {
        $(".footable").footable();
        var queryName = $('#filter').val();
        if (queryName != null && queryName != '') {
            var array = ['songs', 'album', 'singers'];
            for (var i = 0; i < array.length; i++) {
                var id = $('#' + array[i]).attr('id');
                var checked = $('#' + array[i]).is(':checked');
                if (checked)
                    $('.' + id + 'Span1').show().next().hide();
                else
                    $('.' + id + 'Span1').hide().next().show();
            }
        }
        $("#filter").keydown(function (e) {
            if (e.keyCode == "13") {//keyCode=13是回车键
                // ?q=a&songs=on&album=on&singers=on
                var q = $(this).val();
                var songs = $('#songs').is(':checked');
                var album = $('#album').is(':checked');
                var singers = $('#singers').is(':checked');
                location.href = '${pageContext.request.contextPath}/music/list?q='+q+"&songs="+songs+"&album="+album+"&singers="+singers;
            }
        });
    })
    function playMusic(data) {
        /*var id = data.substr(data.lastIndexOf('=') + 1, data.length);
        var prefix = '//music.163.com/outchain/player?type=2&id=';
        var suffix = '&auto=1&height=66';
        var url = prefix + id + suffix;
        $('#music').attr('src', url);*/
        layer.msg('暂时不提供', {icon: 6, offset: '200px'});
    }

    function jump(url) {
        var songs = $('#songs').is(':checked');
        var album = $('#album').is(':checked');
        var singers = $('#singers').is(':checked');
        var baseUrl = "${pageContext.request.contextPath}/music/list?p=" + url;
        if (songs == true) baseUrl += '&songs=true';
        if (album == true) baseUrl += '&album=true';
        if (singers == true) baseUrl += '&singers=true';
        location.href = baseUrl;
    }

    function showColor(condition) {
        var id = $(condition).attr('id');
        var checked = $(condition).is(':checked');
        if (checked)
            $('.' + id + 'Span1').show().next().hide();
        else
            $('.' + id + 'Span1').hide().next().show();
    }

    function openWin(url) {
        var name = '二维码';                          //网页名称，可为空;
        var iWidth = 550;                          //弹出窗口的宽度;
        var iHeight = 460;                         //弹出窗口的高度;
        //获得窗口的垂直位置
        var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
        //获得窗口的水平位置
        var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
        window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',status=no,toolbar=no,menubar=no,location=no,resizable=no,scrollbars=0,titlebar=no');
    }
</script>
</body>

</html>