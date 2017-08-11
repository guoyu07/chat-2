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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/plugins/plyr/plyr.css">
    <style>
        ul.pagination1 {
            display: inline-block;
            padding: 0;
            margin: 0;
        }

        ul.pagination1 li {
            display: inline;
        }

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

        ul.pagination1 li a:hover:not(.active) {
            background-color: #ddd;
        }

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
<jsp:useBean id="dateValue" class="java.util.Date"/>
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
                    <input type="text" class="form-control input-sm m-b-xs" id="filter" value="${queryName}"
                           placeholder="请输入要搜索的关键字...">
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
                                                 ${fn:substring(s.name,0 ,fn:indexOf(s.name,queryName ))}<span
                                                     style="color: crimson;">${queryName}</span>${fn:substring(s.name,fn:indexOf(s.name,queryName) + fn:length(queryName) , fn:length(s.name) )}
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
                            ${fn:substring(s.albumname,0 ,fn:indexOf(s.albumname,queryName ))}<span
                                style="color: crimson;">${queryName}</span>${fn:substring(s.albumname,fn:indexOf(s.albumname,queryName) + fn:length(queryName) , fn:length(s.albumname) )}
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
                            ${fn:substring(s.sname,0 ,fn:indexOf(s.sname,queryName ))}<span
                                style="color: crimson;">${queryName}</span>${fn:substring(s.sname,fn:indexOf(s.sname,queryName) + fn:length(queryName) , fn:length(s.sname) )}
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
                                    <a href="javascript:;"
                                       onclick="openWin('${pageContext.request.contextPath}/music/showQRCode')">查看二维码</a>
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
                                        <a href="javascript:;"
                                           onclick="jump('1${empty queryName ? "" : "&q="}${queryName}')">«</a>
                                    </li>
                                    <li>
                                        <a href="javascript:;"
                                           onclick="jump('${page.pageNumber > 1 ? page.pageNumber - 1 : 1}${empty queryName ? "" : "&q="}${queryName}')">‹</a>
                                    </li>
                                    <li>
                                        <a href="#">${page.pageNumber}</a>
                                    </li>
                                    <li>
                                        <a href="javascript:;"
                                           onclick="jump('${page.pageNumber + 1 > page.totalPage ? songsPage.totalPage : page.pageNumber + 1}${empty queryName ? "" : "&q="}${queryName}')">›</a>
                                    </li>
                                    <li>
                                        <a href="javascript:;"
                                           onclick="jump('${(page.totalPage == '' || page.totalPage == null) ? 1 : page.totalPage}${empty queryName ? '' : '&q='}${queryName}')">»</a>
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
<script src="${pageContext.request.contextPath}/static/js/plugins/plyr/plyr.js"></script>
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
                location.href = '${pageContext.request.contextPath}/music/list?q=' + q + "&songs=" + songs + "&album=" + album + "&singers=" + singers;
            }
        });
    });

    function playMusic(data) {
        var html = '';
        html += '<div class="ibox float-e-margins">';
        html += '<div class="ibox-title">';
        html += '<h5>歌曲播放</h5>';
        html += '<div class="ibox-tools">';
        html += '<a class="collapse-link">';
        html += '<i class="fa fa-chevron-up"></i>';
        html += '</a>';
        html += '<a class="dropdown-toggle" data-toggle="dropdown" href="#">';
        html += '<i class="fa fa-wrench"></i>';
        html += '</a>';
        html += '<ul class="dropdown-menu dropdown-user">';
        html += '<li>'
        html += '<a href="form_basic.html#" tppabs="http://www.zi-han.net/theme/hplus/form_basic.html#">选项1</a>';
        html += '</li>';
        html += '<li>';
        html += '<a href="form_basic.html#" tppabs="http://www.zi-han.net/theme/hplus/form_basic.html#">选项2</a>';
        html += '</li>';
        html += '</ul>';
        html += '<a class="close-link">';
        html += '<i class="fa fa-times"></i>';
        html += '</a>';
        html += '</div>';
        html += '</div>';
        html += '<div class="ibox-content">';
        html += '<div class="player player-audio stopped">';
        html += '<audio>';
        html += '<source src="' + data + '" type="audio/mp3">';
        html += ' 您的浏览器不支持在线播放，请<a href="#">下载</a>';
        html += '</audio>';
        html += '<div class="player-controls">';
        html += '<div class="player-progress">';
        html += '<label for="seek5292" class="sr-only">Seek</label>';
        html += '<input id="seek5292" class="player-progress-seek" type="range" min="0" max="100" step="0.5" value="0" data-player="seek">';
        html += '<progress class="player-progress-played" max="100" value="0"><span>0</span>% 播放中</progress>';
        html += '<progress class="player-progress-buffer" max="100" value="0"><span>0</span>% 缓冲中</progress>';
        html += '</div>';
        html += '<span class="player-controls-left">';
        html += '<button type="button" data-player="restart">';
        html += '<svg><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-restart"></use></svg>';
        html += '<span class="player-tooltip">重新播放</span></button><button type="button" data-player="rewind">';
        html += '<svg><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-rewind"></use></svg>';
        html += '<span class="player-tooltip">后退10秒</span>';
        html += '</button>';
        html += '<button type="button" data-player="play" aria-label="播放">';
        html += ' <svg><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-play"></use></svg>';
        html += '<span class="player-tooltip">播放</span></button><button type="button" data-player="pause">';
        html += '<svg><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-pause"></use></svg>';
        html += '<span class="player-tooltip">暂停</span>';
        html += '</button>';
        html += '<button type="button" data-player="fast-forward">';
        html += '<svg><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-fast-forward"></use></svg>';
        html += '<span class="player-tooltip">快进10秒</span>';
        html += '</button>';
        html += '<span class="player-time"><span class="sr-only">当前时间</span><span class="player-current-time">00:00</span></span>';
        html += '<span class="player-time"><span class="sr-only">持续时间</span><span class="player-duration">00:00</span></span></span>';
        html += '<span class="player-controls-right">';
        html += '<button type="button" data-player="mute" aria-pressed="false">';
        html += '<svg class="icon-muted"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-muted"></use></svg>';
        html += '<svg><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-volume"></use></svg>';
        html += '<span class="player-tooltip">静音</span>';
        html += '</button>';
        html += '<label for="volume5292" class="sr-only">音量</label>';
        html += '<input id="volume5292" class="player-volume" type="range" min="0" max="10" value="5" data-player="volume">';
        html += '<button type="button" data-player="fullscreen">';
        html += '<svg class="icon-exit-fullscreen"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-exit-fullscreen"></use></svg>';
        html += '<svg><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-enter-fullscreen"></use></svg>';
        html += '<span class="player-tooltip">全屏</span>';
        html += '</button>';
        html += '</span>';
        html += '</div>';
        html += '</div>';
        html += '</div>';
        html += '</div>';
        layer.open({
            type: 1,
            title: false,
            closeBtn: 0,
            shadeClose: true,
            skin: 'yourclass',
            content: html
        });
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