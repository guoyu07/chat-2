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
    <title>添加歌曲 - chat</title>
    <meta name="keywords" content="chat">
    <meta name="description" content="chat">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css-v=3.3.5.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/font-awesome.min.css-v=4.4.0.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/style.min.css-v=4.0.0.css" rel="stylesheet">
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>添加歌曲 <small>带有*号的输入框是必须填写的内容</small></h5>
                </div>
                <div class="ibox-content">
                    <form method="post" action="/music/addSong" class="form-horizontal">
                        <input type="hidden" name="alias" value="[]" />
                        <div class="form-group">
                            <label class="col-sm-2 control-label">歌名 *</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="name" id="name" placeholder="请输入歌曲名称">
                            </div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">URL *</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="url" id="url" placeholder="请输入歌曲地址">
                            </div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">操作 *</label>
                            <div class="col-sm-10">
                                <button type="submit" class="btn btn-block btn-outline btn-primary">发表</button>
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
<script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript"></script>
<script>
    $(document).ready(function(){
        $(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",})
        if ('${addMsg}' != null) {
            layer.msg('${addMsg}', {icon: 5, offset: '200px'});
        }
    });

    $('form').submit(function () {
        if ($.trim($('#name').val()) == '') {
            layer.msg('请输入歌曲名称', {icon: 5, offset: '200px'});
            return false;
        }
        if ($.trim($('#url').val()) == '') {
            layer.msg('请输入歌曲播放地址', {icon: 5, offset: '200px'});
            return false;
        }
        layer.msg('功能维护中,请等待开放', {icon: 6, offset: '200px'});
        return false;
    })
</script>
</body>
</html>