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
                    <div class="row m-t-sm">
                        <div class="col-sm-12">
                            <div class="panel blank-panel">
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div class="social-feed-box">
                                            <div class="pull-right social-action dropdown">
                                                <button data-toggle="dropdown"
                                                        class="dropdown-toggle btn-white">
                                                    <i class="fa fa-angle-down"></i>
                                                </button>
                                                <ul class="dropdown-menu m-t-xs">
                                                    <li><a href="#">设置</a></li>
                                                </ul>
                                            </div>
                                            <div class="social-avatar">
                                                <a href="" class="pull-left">
                                                    <img alt="image" src="${tweets.ulogo}">
                                                </a>
                                                <div class="media-body">
                                                    <a href="#">
                                                        ${tweets.uname}
                                                    </a>
                                                    <small class="text-muted">${tweets.time}</small>
                                                </div>
                                            </div>
                                            <div class="social-body">
                                                <p>
                                                    ${tweets.content}
                                                </p>

                                                <div class="btn-group">
                                                    <button class="btn btn-white btn-xs"><i
                                                            class="fa fa-thumbs-up"></i> 赞
                                                    </button>
                                                    <button class="btn btn-white btn-xs"><i
                                                            class="fa fa-comments"></i> 评论
                                                    </button>
                                                    <button class="btn btn-white btn-xs">
                                                        <i class="fa fa fa-star"></i> 收藏 0
                                                    </button>
                                                    <button class="btn btn-white btn-xs"><i
                                                            class="fa fa-share"></i>
                                                        分享
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="social-footer">
                                                <!-- 加载评论 -->
                                                <div id="loadComments">
                                                </div>
                                                <!-- /加载评论 -->
                                                <div class="social-comment">
                                                    <div class="media-body">
                                                        <div id="pages"></div>
                                                    </div>
                                                </div>
                                                <div class="social-comment">
                                                    <a href="" class="pull-left">
                                                        <img alt="image"
                                                             src="${sessionScope.loginUser.picSummary}"
                                                             style="height: 32px;">
                                                    </a>
                                                    <div class="media-body">
                                                        <form action="/tweets/addComment" method="post">
                                                            <input type="hidden" name="cid" value="${tweets.id}"/>
                                                            <input type="hidden" name="uid"
                                                                   value="${sessionScope.loginUser.id}"/>
                                                            <textarea class="form-control" placeholder="填写评论..." id="content_focus"></textarea>
                                                            <div id="content_hide" style="display: none;">
                                                            <textarea class="layui-textarea" id="lay_editor" name="content"
                                                                      style="display: none" placeholder="输入评论.."></textarea>
                                                            <button type="submit" class="btn btn-block btn-outline btn-primary" style="margin-top: 5px;">
                                                                确定
                                                            </button>
                                                            </div>
                                                        </form>
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
<script src="${pageContext.request.contextPath}/laypage/laypage.js" type="text/javascript"></script>
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

    $(function () {
        loadComment();
        $('#content_focus').focus(function () {
            $('#content_focus').css('display','none');
            $('#content_hide').show();
            $('#lay_editor').focus();
        });
    });

    $('form').submit(function () {
        if ($.trim($('#lay_editor').val()) == '') {
            layer.msg('请填写评论内容', function () {
                $('#content').focus();
            });
            return false;
        }
    })

    var pages = '${list.totalPage}';

    function loadComment() {
        //调用分页
        laypage({
            cont: $('#pages'), //容器。值支持id名、原生dom对象，jquery对象,
            pages: pages, //总页数
            skip: true, //是否开启跳页
            skin: '#00AA91',
            groups: 5, //连续显示分页数
            jump: function (obj) {
                $.ajax({
                    async: false,
                    type: "GET",
                    url: "${pageContext.request.contextPath}/tweets/loadTweetsComments",
                    data: {
                        p: obj.curr,
                        id: '${tweets.id}'
                    },
                    success: function (data) {
                        var html = '';
                        for (var i = 0; i < data.list.length; i++) {
                            html += '<div class="social-comment">';
                            html += '<a href="" class="pull-left">';
                            html += '<img alt="image" src="' + data.list[i].ulogo + '" style="height: 32px;"/>';
                            html += '</a>';
                            html += '<div class="media-body">';
                            html += '<a href="#">';
                            html += data.list[i].uname;
                            html += '</a>';
                            html += ' ' + data.list[i].content;
                            html += '<br/>';
                            html += '<a href="#" class="small">';
                            html += '<i class="fa fa-thumbs-up"></i> 0</a>';
                            html += ' - <small class="text-muted">' + data.list[i].time + '</small>';
                            html += '</div>';
                            html += '</div>';
                        }
                        $('#loadComments').html(html)
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                    }
                });
            }
        });
    }
</script>
</body>
</html>