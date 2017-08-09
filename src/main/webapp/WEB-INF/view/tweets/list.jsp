<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/7
  Time: 14:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>tweets - chat</title>
    <meta name="keywords" content="chat">
    <meta name="description" content="chat">
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css-v=3.3.5.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/font-awesome.min.css-v=4.4.0.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/style.min.css-v=4.0.0.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <%--<base target="_blank">--%>
</head>
<body class="gray-bg">
<div class="row">
    <div class="col-sm-9">
        <div class="wrapper wrapper-content animated fadeInUp">
            <div class="ibox">
                <div class="ibox-content">
                    <h3 class="m-b-xxs">发表状态</h3>
                    <form action="/tweets/add" method="post">
                        <textarea class="layui-textarea" id="lay_editor" name="content"
                                  style="display: none"></textarea>
                        <button type="submit" class="btn btn-block btn-outline btn-primary" style="margin-top: 5px;">
                            发布
                        </button>
                    </form>
                </div>
                <div class="ibox-content">
                    <div class="row m-t-sm">
                        <div class="col-sm-12">
                            <div class="panel blank-panel">
                                <div class="panel-heading">
                                    <div class="panel-options">
                                        <ul class="nav nav-tabs">
                                            <li class="active" id="new"><a href="#tab-1" data-toggle="tab">最新</a>
                                            </li>
                                            <li class="" id="hot"><a href="#tab-2" data-toggle="tab">最热</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div class="tab-pane active" id="tab-1">
                                            <div class="feed-activity-list" id="newest-list">
                                                <!-- 列表 -->
                                            </div>
                                        </div>
                                        <div class="tab-pane" id="tab-2">
                                            <div class="feed-activity-list" id="hotest-list">
                                                <!-- 列表 -->
                                            </div>
                                        </div>
                                        <div id="loadMore" style="display: none;">
                                            <button type="button" class="btn btn-block btn-outline btn-primary"
                                                    onclick="loadMore();">加载更多
                                            </button>
                                            <%--<a class="btn btn-primary btn-rounded btn-block" href="#"><i class="fa fa-refresh"></i> 加载更多</a>--%>
                                        </div>
                                        <div id="loadEnd" style="display: none;">
                                            <div class="well">
                                                没有数据可以加载了 :)
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- right -->
    <div class="col-sm-3">
        <div class="wrapper wrapper-content project-manager">
            <h4>打广告</h4>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js-v=2.1.4.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js-v=3.3.5.js"></script>
<script src="${pageContext.request.contextPath}/static/js/content.min.js-v=1.0.0.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins/layer/layer.min.js"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js" charset="utf-8"></script>
<script>
    layui.use('layedit', function () {
        var layedit = layui.layedit, $ = layui.jquery;
        //自定义工具栏
        layedit.build('lay_editor', {
            tool: ['strong', 'italic', 'underline', '|', 'face', 'link', 'unlink']
            , height: 100
        })
    });

    var newPage = 1;
    var hotPage = 1;

    $(document).ready(function () {
        $("#loading-example-btn").click(function () {
            btn = $(this);
            simpleLoad(btn, true);
            simpleLoad(btn, false)
        })
        list(1, 'new');
        list(1, 'hot');
    });

    $('form').submit(function () {
        if ($.trim($('#lay_editor').val()) == '') {
            layer.msg('请输入状态内容..', {icon: 5, offset: 200, time: 1000});
            return false;
        }
    })

    function simpleLoad(btn, state) {
        if (state) {
            btn.children().addClass("fa-spin");
            btn.contents().last().replaceWith(" Loading")
        } else {
            setTimeout(function () {
                btn.children().removeClass("fa-spin");
                btn.contents().last().replaceWith(" Refresh")
            }, 2000)
        }
    }
    ;

    function loadMore() {
        var way = $('li.active').attr('id'); // 获取方式
        var p = 1;
        switch (way) {
            case 'new':
                p = newPage;
                break;
            case 'hot':
                p = hotPage;
                break;
        }
        list(p, way);
    }

    function list(p, way) {
        $.ajax({
            async: false,
            type: "GET",
            url: "${pageContext.request.contextPath}/tweets/list",
            data: {
                p: p,
                way: way
            },
            success: function (data) {
                var html = '';
                for (var i = 0; i < data.list.length; i++) {
                    html += '<div class="social-feed-box">';
                    html += '<div class="pull-right social-action dropdown">';
                    html += '<button data-toggle="dropdown" class="dropdown-toggle btn-white">';
                    html += '<i class="fa fa-angle-down"></i>';
                    html += '</button>';
                    html += '<ul class="dropdown-menu m-t-xs">';
                    html += '<li><a href="#">设置</a></li>';
                    html += '</ul>';
                    html += '</div>';
                    html += '<div class="social-avatar">';
                    html += '<a href="" class="pull-left">';
                    html += '<img alt="image" src="' + data.list[i].ulogo + '">';
                    html += '</a>';
                    html += '<div class="media-body">';
                    html += '<a href="#">';
                    html += data.list[i].uname;
                    html += '</a>';
                    html += '<small class="text-muted">' + data.list[i].time + ' 来自 chat chat.my';
                    html += '</small>';
                    html += '</div>';
                    html += '</div>';
                    html += '<div class="social-body">';
                    html += '<p>';
                    html += data.list[i].content;
                    html += ' </p>';
                    html += '<div class="btn-group">';
                    html += '<button class="btn btn-white btn-xs">';
                    html += '<i class="fa fa-thumbs-o-up"></i> 点赞 0';
                    html += '</button>';
                    html += '<button class="btn btn-white btn-xs">';
                    html += '<i class="fa fa-pencil-square-o"></i> 评论 ' + data.list[i].comments;
                    html += '</button>';
                    html += '<button class="btn btn-white btn-xs">';
                    html += '<i class="fa fa fa-star"></i> 收藏 0';
                    html += '</button>';
                    html += '<button class="btn btn-white btn-xs">';
                    html += '<i class="fa fa-share"></i> 分享';
                    html += '</button>';
                    html += '<button class="btn btn-white btn-xs" onclick="showDetail(' + data.list[i].id + ');">';
                    html += '<i class=""></i> 查看详情';
                    html += '</button>';
                    html += '</div>';
                    html += '</div>';
                    html += '</div>';
                }
                if (data.pageNumber < data.totalPage) {
                    $('#loadMore').show();
                } else {
                    $('#loadMore').hide();
                    $('#loadEnd').show();
                }
                if (way == 'hot') {
                    hotPage = data.pageNumber + 1;
                    $('#hotest-list').append(html);
                } else if (way == 'new') {
                    newPage = data.pageNumber + 1;
                    $('#newest-list').append(html);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }

    function showDetail(id) {
        location.href = '${pageContext.request.contextPath}/tweets/detail?id=' + id;
    }
</script>
</body>
</html>