<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/2
  Time: 15:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改头像 - chat</title>
    <meta name="keywords" content="chat">
    <meta name="description" content="chat">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css-v=3.3.5.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/font-awesome.min.css-v=4.4.0.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/plugins/cropper/cropper.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/style.min.css-v=4.0.0.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
</head>
<style>
    .site-demo-upload {
        position: relative;
        background: #e2e2e2;
    }

    .site-demo-upload, .site-demo-upload img {
        width: 200px;
        height: 200px;
        border-radius: 100%;
    }

    .site-demo-upload .site-demo-upbar {
        position: absolute;
        top: 50%;
        left: 50%;
        margin: -18px 0 0 -56px;
    }

    .site-demo-upload .layui-upload-button {
        background-color: rgba(0, 0, 0, .2);
        color: rgba(255, 255, 255, 1);
    }

    .layui-box, .layui-box * {
        -webkit-box-sizing: content-box !important;
        -moz-box-sizing: content-box !important;
        box-sizing: content-box !important;
    }

    .layui-upload-button input {
        position: absolute;
        left: 0;
        top: 0;
        z-index: 10;
        font-size: 100px;
        width: 100%;
        height: 100%;
    }

    .layui-upload-icon {
        display: block;
        margin: 0 15px;
        text-align: center;
    }

    .layui-upload-icon i {
        margin-right: 5px;
        vertical-align: top;
        font-size: 20px;
        color: #5FB878;
    }
</style>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="ibox float-e-margins">
            <div class="ibox-title  back-change">
                <h5>修改头像
                    <small>请上传您的新头像</small>
                </h5>
            </div>
            <div class="ibox-content">
                <div class="row">
                    <div class="col-md-6">
                        <div class="image-crop">
                            <img src="${sessionScope.loginUser.picSummary}">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <h4>图片预览：</h4>
                        <div class="img-preview img-preview-sm"></div>
                        <h4>说明：</h4>
                        <p>
                            你可以选择新图片上传，然后下载裁剪后的图片
                        </p>
                        <div class="btn-group">
                            <form action="/user/modifyAvatar" method="post" id="modifyAvatarForm">
                                <label title="上传新图片" for="inputImage" class="btn btn-primary">
                                    <input type="file" accept="image/*" id="inputImage" class="hide"> 上传新图片
                                </label>
                                <input type="hidden" name="logo" id="logo"/>
                                <label title="保存头像" id="download" class="btn btn-primary">保存头像</label>
                            </form>
                        </div>
                        <h4>其他说明：</h4>
                        <p>
                            可以使用<code>$({image}).cropper(options)</code>来配置插件
                        </p>
                        <div class="btn-group">
                            <button class="btn btn-white" id="zoomIn" type="button">放大</button>
                            <button class="btn btn-white" id="zoomOut" type="button">缩小</button>
                            <button class="btn btn-white" id="rotateLeft" type="button">左旋转</button>
                            <button class="btn btn-white" id="rotateRight" type="button">右旋转</button>
                            <button class="btn btn-warning" id="setDrag" type="button">裁剪</button>
                        </div>


                        <div class="site-demo-upload">
                            <img id="LAY_demo_upload" src="/images/homepage.jpg">
                            <div class="site-demo-upbar">
                                <div class="layui-box layui-upload-button">
                                    <form class="layui-form layui-form-pane" id="uploadForm" action="" method="post"
                                          enctype="multipart/form-data">
                                        <input type="file" name="file" enc class="layui-upload-file" id="test">
                                    </form>
                                    <span class="layui-upload-icon">
                                            <i class="layui-icon"></i>上传图片
                                        </span>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js-v=2.1.4.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js-v=3.3.5.js"></script>
<script src="${pageContext.request.contextPath}/static/js/content.min.js-v=1.0.0.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins/cropper/cropper.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/demo/form-advanced-demo.min.js"></script>
<script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js" charset="utf-8"></script>
<script>
    layui.use('layedit', function () {
        var layedit = layui.layedit, $ = layui.jquery;
        //自定义工具栏
        var index = layedit.build('lay_editor', {
            tool: ['face', 'link', 'unlink']
            , height: 160
        });

        layui.use('upload', function () {
            layui.upload({
                url: '/user/uploadMyAvatar'
                , elem: '#test'
                , ext: 'jpg|png|gif'
                , title: '上传头像咯'
                , method: 'post'
                , success: function (data) {
                    location.href = data.url;
                }
            });
        });
    });
</script>
</html>