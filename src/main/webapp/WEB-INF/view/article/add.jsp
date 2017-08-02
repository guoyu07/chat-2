<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/2
  Time: 14:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加文章 - chat</title>
    <meta name="keywords" content="chat">
    <meta name="description" content="chat">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css-v=3.3.5.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/font-awesome.min.css-v=4.4.0.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/style.min.css-v=4.0.0.css" rel="stylesheet">
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>添加文章 <small>带有*号的输入框是必须填写的内容</small></h5>
                </div>
                <div class="ibox-content">
                    <form method="post" action="/article/add" class="form-horizontal">
                        <input type="hidden" name="article.authorId" value="${sessionScope.loginUser.id}" />
                        <input type="hidden" name="article.authorName" value="${sessionScope.loginUser.nickname}" />
                        <input type="hidden" name="article.readNum" value="0" />
                        <input type="hidden" name="article.comments" value="0" />
                        <input type="hidden" name="article.content" id="content" />
                        <div class="form-group">
                            <label class="col-sm-2 control-label">标题 *</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="article.title" id="title" placeholder="请输入标题">
                            </div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">标识 *</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="article.keywords" id="keywords" placeholder="Java Android IOS ..">
                                <span class="help-block m-b-none">标识关键字使用空格区分开. 例: (Java Android)</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">描述 *</label>
                            <div class="col-sm-10">
                                <textarea class="form-control" name="article.desc" rows="5" id="desc" placeholder="请输入文章描述"></textarea>
                            </div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">内容 *</label>
                            <div class="col-sm-10">
                                <script id="container" type="text/plain" style="height:500px;"></script>
                            </div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">作者 *</label>
                            <div class="col-sm-10">
                                <p class="form-control-static">${sessionScope.loginUser.nickname}</p>
                            </div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <div class="col-sm-4 col-sm-offset-2">
                                <button class="btn btn-primary" type="submit">发表</button>
                                <button class="btn btn-white" type="submit">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js-v=2.1.4.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js-v=3.3.5.js"></script>
<script src="${pageContext.request.contextPath}/static/js/content.min.js-v=1.0.0.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins/iCheck/icheck.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/lang/zh-cn/zh-cn.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/ueditor/themes/default/css/ueditor.css"/>
<script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript"></script>
<script>
    var ue = UE.getEditor('container');
    $(document).ready(function(){$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",})});

    $('form').submit(function () {
        if ($.trim($('#title').val()) == '') {
            layer.msg('请输入文章标题', {icon: 5, offset: '200px'});
            return false;
        }
        if ($.trim($('#keywords').val()) == '') {
            layer.msg('请至少输入一个标识', {icon: 5, offset: '200px'});
            return false;
        }
        if ($.trim($('#desc').val()) == '') {
            layer.msg('请输入文章描述', {icon: 5, offset: '200px'});
            return false;
        }
        var content = ue.getContent();
        if ($.trim(content) == '') {
            layer.msg('请输入文章内容', {icon: 5, offset: '200px'});
            return false;
        }
        $('#content').val(content);
    })
</script>
</body>
</html>