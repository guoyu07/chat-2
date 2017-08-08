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
                        <textarea class="form-control" rows="4" name="content"></textarea>
                        <button type="submit" class="btn btn-block btn-outline btn-primary" style="margin-top: 5px;">发布</button>
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
                                        <div class="tab-pane" id="tab-2">
                                            <table class="table table-striped">
                                                <thead>
                                                <tr>
                                                    <th>状态</th>
                                                    <th>标题</th>
                                                    <th>开始时间</th>
                                                    <th>结束时间</th>
                                                    <th>说明</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <tr>
                                                    <td>
                                                        <span class="label label-primary"><i class="fa fa-check"></i> 已完成</span>
                                                    </td>
                                                    <td>
                                                        文档在线预览功能
                                                    </td>
                                                    <td>
                                                        11月7日 22:03
                                                    </td>
                                                    <td>
                                                        11月7日 20:11
                                                    </td>
                                                    <td>
                                                        <p class="small">
                                                            已经测试通过
                                                        </p>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span class="label label-primary"><i class="fa fa-check"></i> 解决中</span>
                                                    </td>
                                                    <td>
                                                        会员登录
                                                    </td>
                                                    <td>
                                                        11月7日 22:03
                                                    </td>
                                                    <td>
                                                        11月7日 20:11
                                                    </td>
                                                    <td>
                                                        <p class="small">
                                                            测试中
                                                        </p>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span class="label label-primary"><i class="fa fa-check"></i> 解决中</span>
                                                    </td>
                                                    <td>
                                                        会员积分
                                                    </td>
                                                    <td>
                                                        11月7日 22:03
                                                    </td>
                                                    <td>
                                                        11月7日 20:11
                                                    </td>
                                                    <td>
                                                        <p class="small">
                                                            未测试
                                                        </p>
                                                    </td>

                                                </tr>


                                                </tbody>
                                            </table>

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
    <div class="col-sm-3">
        <div class="wrapper wrapper-content project-manager">
            <h4>项目描述</h4>
            <img src="${pageContext.request.contextPath}/static/img/wenku_logo.png" class="img-responsive">
            <p class="small">
                <br>在线互动式文档分享平台，在这里，您可以和千万网友分享自己手中的文档，全文阅读其他用户的文档，同时，也可以利用分享文档获取的积分下载文档
            </p>
            <p class="small font-bold">
                <span><i class="fa fa-circle text-warning"></i> 高优先级</span>
            </p>
            <h5>项目标签</h5>
            <ul class="tag-list" style="padding: 0">
                <li><a href="project_detail.html"><i class="fa fa-tag"></i> 文档</a>
                </li>
                <li><a href="project_detail.html"><i class="fa fa-tag"></i> 分享</a>
                </li>
                <li><a href="project_detail.html"><i class="fa fa-tag"></i> 下载</a>
                </li>
            </ul>
            <h5>项目文档</h5>
            <ul class="list-unstyled project-files">
                <li><a href="project_detail.html"><i class="fa fa-file"></i> Project_document.docx</a>
                </li>
                <li><a href="project_detail.html"><i class="fa fa-file-picture-o"></i> Logo_zender_company.jpg</a>
                </li>
                <li><a href="project_detail.html"><i class="fa fa-stack-exchange"></i> Email_from_Alex.mln</a>
                </li>
                <li><a href="project_detail.html"><i class="fa fa-file"></i> Contract_20_11_2014.docx</a>
                </li>
            </ul>
            <div class="m-t-md">
                <a href="project_detail.html#" class="btn btn-xs btn-primary">添加文档</a>

            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js-v=2.1.4.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js-v=3.3.5.js"></script>
<script src="${pageContext.request.contextPath}/static/js/content.min.js-v=1.0.0.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins/layer/layer.min.js"></script>
<script>
    var newPage = 1;
    var hotPage = 1;

    $(document).ready(function () {
        $("#loading-example-btn").click(function () {
            btn = $(this);
            simpleLoad(btn, true);
            simpleLoad(btn, false)
        })
        list(1, 'new');
//        loadNewst(1,'hot');
    });
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
            url: "/tweets/list",
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
                    html += '<i class="fa fa-comments-o"></i> 评论 ' + data.list[i].comments;
                    html += '</button>';
                    html += '<button class="btn btn-white btn-xs">';
                    html += '<i class="fa fa fa-star"></i> 收藏 0';
                    html += '</button>';
                    html += '<button class="btn btn-white btn-xs">';
                    html += '<i class="fa fa-share"></i> 分享';
                    html += '</button>';
                    html += '</div>';
                    html += '</div>';
                    html += '</div>';
                }
                $('#newest-list').append(html);
                if (data.pageNumber < data.totalPage) {
                    $('#loadMore').show();
                } else {
                    $('#loadMore').hide();
                    $('#loadEnd').show();
                }
                if (way == 'hot') {
                    hotPage = data.pageNumber + 1;
                } else if (way == 'new') {
                    newPage = data.pageNumber + 1;
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }
</script>
</body>
</html>