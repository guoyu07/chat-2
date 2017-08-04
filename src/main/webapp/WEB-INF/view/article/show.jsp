<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${article.title} - chat</title>
    <meta name="keywords" content="chat">
    <meta name="description" content="chat">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css-v=3.3.5.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/font-awesome.min.css-v=4.4.0.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/style.min.css-v=4.0.0.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/ueditor/themes/default/css/ueditor.css"/>
</head>
<body class="gray-bg">
<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-sm-4">
        <h2><a class="btn-link" href="/article/${way}?p=${p}">返回</a></h2>
    </div>
</div>
<div class="wrapper wrapper-content  animated fadeInRight article">
    <div class="row">
        <div class="col-lg-10 col-lg-offset-1">
            <div class="ibox">
                <div class="ibox-content">
                    <div class="pull-right">
                        <c:forEach items="${fn:split(article.keywords,' ')}" var="key">
                            <button class="btn btn-primary btn-xs" type="button">${key}</button>
                        </c:forEach>
                    </div>
                    <div class="text-center article-title">
                        <h1>
                            ${article.title}
                        </h1>
                    </div>
                    <p>
                      ${article.content}
                    </p>
                    <hr>

                    <div class="row">
                        <div class="col-lg-12">
                            <h2>评论：</h2>
                            <div id="comments-ajax">
                            </div>
                                <div class="social-feed-box">
                                    <div class="social-body">
                                        <div id="pages"></div>
                                    </div>
                                </div>
                        </div>
                    </div>
                </div>
                    <div>
                        <script id="container" type="text/plain" style="height:500px;"></script>
                        <form action="/article/leaveMsg" method="post">
                            <input type="hidden" name="way" value="${way}" />
                            <input type="hidden" name="p" value="${p}" />
                            <input type="hidden" name="aid" value="${article.id}" />
                            <input type="hidden" name="uid" value="${sessionScope.loginUser.id}" />
                            <input type="hidden" name="content" id="content" />
                            <button type="submit" class="btn btn-primary btn-sm btn-block"><i></i> 留言 </button>
                        </form>
                    </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js-v=2.1.4.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js-v=3.3.5.js"></script>
<script src="${pageContext.request.contextPath}/static/js/content.min.js-v=1.0.0.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/lang/zh-cn/zh-cn.js"></script>
<script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/laypage/laypage.js" type="text/javascript"></script>
<script>
    $(function () {
        if('${leaveMsgSuccess}' != ''){
            layer.msg('${leaveMsgSuccess}', {icon: 6, offset: '200px'});
        }
    })
    var ue = UE.getEditor('container',{
        wordCount:true,
        maximumWords:500,
        elementPathEnabled:false,
        initialFrameHeight:300})
    $('form').submit(function () {
        var content = ue.getContent();
        if ($.trim(content) == '') {
            layer.msg('请输入留言内容', {icon: 5, offset: '200px'});
            return false;
        }
        $('#content').val(content);
    })

    var pages = '${page.totalPage}';
    //调用分页
    laypage({
        cont: $('#pages'), //容器。值支持id名、原生dom对象，jquery对象,
        pages: pages, //总页数
        skip: true, //是否开启跳页
        skin: '#00AA91',
        groups: 5, //连续显示分页数
        jump:function (obj) {
          // 加载评论
                $.ajax({
                    async : false,
                    type : "POST",
                    url : "/article/loadArticleComments",
                    data : {
                        aid : '${article.id}',
                        p : obj.curr
                    },
                    success : function(json) {
                        var html = '';
                        for(var i = 0; i < json.list.length; i++){
                            html += '<div class="social-feed-box">';
                            html += '<div class="social-avatar">';
                            html += '<a href="" class="pull-left">';
                            html += '<img alt="image" src="' + json.list[i].pic + '">';
                            html += '</a>';
                            html += '<div class="media-body">';
                            html += '<a href="#">';
                            html += json.list[i].name;
                            html += '</a>';
                            html += '<small class="text-muted"> ' + json.list[i].time + '</small>';
                            html += '</div>';
                            html += '</div>';
                            html += '<div class="social-body">';
                            html += '<p>';
                            html += json.list[i].content;
                            html += '</p>';
                            html += '</div>';
                            html += '</div>';
                        }
                        $('#comments-ajax').html(html);
                    },
                    error : function(XMLHttpRequest, textStatus,
                                     errorThrown) {
                    }
                });
        }
    });
</script>
</body>
</html>