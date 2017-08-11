<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/3
  Time: 10:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人资料 - chat</title>
    <meta name="keywords" content="chat">
    <meta name="description" content="chat">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css-v=3.3.5.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/font-awesome.min.css-v=4.4.0.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/style.min.css-v=4.0.0.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <%--<base target="_blank">--%>
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
<div class="wrapper wrapper-content">
    <div class="row animated fadeInRight">
        <div class="col-sm-4">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>个人资料</h5>
                </div>
                <div>
                    <div class="ibox-content no-padding border-left-right">
                        <c:if test="${way == 'my'}">
                            <c:if test="${sessionScope.loginUser.homePagePic == null}">
                                <div class="site-demo-upload">
                                    <img id="LAY_demo_upload" src="/images/homepage.jpg">
                                    <div class="site-demo-upbar">
                                        <div class="layui-box layui-upload-button">
                                            <form class="layui-form layui-form-pane" id="uploadForm" action="" method="post" enctype="multipart/form-data" >
                                                <input type="file" name="file" enc class="layui-upload-file" id="test">
                                            </form>
                                            <span class="layui-upload-icon">
                                                <i class="layui-icon"></i>上传图片
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${sessionScope.loginUser.homePagePic != null}">
                                <img alt="image" class="img-responsive" src="${sessionScope.loginUser.homePagePic}">
                            </c:if>
                        </c:if>
                    </div>
                    <div class="ibox-content profile-content">
                        <c:if test="${way == 'my'}">
                            <h4><strong>${sessionScope.loginUser.nickname}</strong></h4>
                            <p><i class="fa fa-map-marker"></i>&nbsp;&nbsp;${sessionScope.loginUser.addressDetails}</p>
                            <br/>
                            <h5>关于我</h5>
                            <p>
                                ${sessionScope.loginUser.description}
                            </p>
                            <div class="row m-t-lg">
                                <div class="col-sm-4">
                                    <span class="bar"></span>
                                    <h5><strong>0</strong> 文章</h5>
                                </div>
                                <div class="col-sm-4">
                                    <span class="line"></span>
                                    <h5><strong>0</strong> 关注</h5>
                                </div>
                                <div class="col-sm-4">
                                    <span class="bar"></span>
                                    <h5><strong>0</strong> 关注者</h5>
                                </div>
                            </div>
                        </c:if>

                        <br/>
                        <div class="user-button">
                            <div class="row">
                                <c:if test="${way == 'my'}">
                                    <div class="col-sm-6">
                                        <a data-toggle="modal" class="btn btn-primary btn-sm btn-block"
                                           href="#modal-form"><i class="fa fa-refresh fa-spin"></i> 修改资料</a>
                                    </div>
                                    <c:if test="${sessionScope.loginUser.homePagePic != null }">
                                        <div class="col-sm-6">
                                            <a data-toggle="modal" class="btn btn-primary btn-sm btn-block"
                                               href="javascript:;" onclick="changeBg();"><i class="fa fa-refresh"></i> 修改图片</a>
                                            <div style="display: none;">
                                            <form class="layui-form layui-form-pane" id="uploadForm1" action="" method="post" enctype="multipart/form-data" >
                                                <input type="file" name="file" enc class="layui-upload-file" id="test1">
                                            </form>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:if>
                                <c:if test="${way != 'my'}">
                                    <div class="col-sm-6">
                                        <button type="button" class="btn btn-primary btn-sm btn-block"><i
                                                class="fa fa-envelope"></i> 发送消息
                                        </button>
                                    </div>
                                    <div class="col-sm-6">
                                        <button type="button" class="btn btn-default btn-sm btn-block"><i
                                                class="fa fa-coffee"></i> 赞助
                                        </button>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--
        <div class="col-sm-8">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>最新动态</h5>
                </div>
                <div class="ibox-content">
                    <div>
                        <div class="feed-activity-list">
                            <div class="feed-element">
                                <a href="#" class="pull-left">
                                    <img alt="image" class="img-circle" src="${pageContext.request.contextPath}/static/img/a1.jpg">
                                </a>
                                <div class="media-body ">
                                    <small class="pull-right text-navy">1天前</small>
                                    <strong>奔波儿灞</strong> 关注了 <strong>灞波儿奔</strong>.
                                    <br>
                                    <small class="text-muted">54分钟前 来自 皮皮时光机</small>
                                    <div class="actions">
                                        <a class="btn btn-xs btn-white"><i class="fa fa-thumbs-up"></i> 赞 </a>
                                        <a class="btn btn-xs btn-danger"><i class="fa fa-heart"></i> 收藏</a>
                                    </div>
                                </div>
                            </div>
                            <div class="feed-element">
                                <a href="#" class="pull-left">
                                    <img alt="image" class="img-circle" src="${pageContext.request.contextPath}/static/img/profile.jpg">
                                </a>
                                <div class="media-body ">
                                    <small class="pull-right">5分钟前</small>
                                    <strong>作家崔成浩</strong> 发布了一篇文章
                                    <br>
                                    <small class="text-muted">今天 10:20 来自 iPhone 6 Plus</small>

                                </div>
                            </div>

                            <div class="feed-element">
                                <a href="#" class="pull-left">
                                    <img alt="image" class="img-circle" src="${pageContext.request.contextPath}/static/img/a2.jpg">
                                </a>
                                <div class="media-body ">
                                    <small class="pull-right">2小时前</small>
                                    <strong>作家崔成浩</strong> 抽奖中了20万
                                    <br>
                                    <small class="text-muted">今天 09:27 来自 Koryolink iPhone</small>
                                    <div class="well">
                                        抽奖，人民币2000元，从转发这个微博的粉丝中抽取一人。11月16日平台开奖。随手一转，万一中了呢？
                                    </div>
                                    <div class="pull-right">
                                        <a class="btn btn-xs btn-white"><i class="fa fa-thumbs-up"></i> 赞 </a>
                                        <a class="btn btn-xs btn-white"><i class="fa fa-heart"></i> 收藏</a>
                                        <a class="btn btn-xs btn-primary"><i class="fa fa-pencil"></i> 评论</a>
                                    </div>
                                </div>
                            </div>
                            <div class="feed-element">
                                <a href="#" class="pull-left">
                                    <img alt="image" class="img-circle" src="${pageContext.request.contextPath}/static/img/a3.jpg">
                                </a>
                                <div class="media-body ">
                                    <small class="pull-right">2天前</small>
                                    <strong>天猫</strong> 上传了2张图片
                                    <br>
                                    <small class="text-muted">11月7日 11:56 来自 微博 weibo.com</small>
                                    <div class="photos">
                                        <a target="_blank" href="#">
                                            <img alt="image" class="feed-photo" src="${pageContext.request.contextPath}/static/img/p1.jpg">
                                        </a>
                                        <a target="_blank" href="#">
                                            <img alt="image" class="feed-photo" src="${pageContext.request.contextPath}/static/img/p3.jpg">
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="feed-element">
                                <a href="#" class="pull-left">
                                    <img alt="image" class="img-circle" src="${pageContext.request.contextPath}/static/img/a4.jpg">
                                </a>
                                <div class="media-body ">
                                    <small class="pull-right text-navy">5小时前</small>
                                    <strong>在水一方Y</strong> 关注了 <strong>那二十年的单身</strong>.
                                    <br>
                                    <small class="text-muted">今天 10:39 来自 iPhone客户端</small>
                                    <div class="actions">
                                        <a class="btn btn-xs btn-white"><i class="fa fa-thumbs-up"></i> 赞 </a>
                                        <a class="btn btn-xs btn-white"><i class="fa fa-heart"></i> 收藏</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button class="btn btn-primary btn-block m"><i class="fa fa-arrow-down"></i> 显示更多</button>
                    </div>
                </div>
            </div>
        </div>
        -->
    </div>
</div>

<div id="modal-form" class="modal fade" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div style="width: 100%;">
                        <h3 class="m-t-none m-b">修改信息</h3>
                        <p>请填写要修改的个人信息</p><br/>
                        <form action="/user/modifyInfo" method="post">
                            <input type="hidden" name="user.id" value="${sessionScope.loginUser.id}"/>
                            <input type="hidden" name="user.description" id="desc"/>
                            <div class="form-group">
                                <label>邮箱：</label>
                                ${sessionScope.loginUser.email}
                            </div>
                            <div class="form-group">
                                <label>姓名：</label>
                                ${sessionScope.loginUser.nickname}
                            </div>
                            <div class="form-group">
                                <label>性别：</label>
                                <input type="radio"
                                       <c:if test="${sessionScope.loginUser.gender == 0}">checked="checked"</c:if>
                                       value="0" name="user.gender"> 女
                                <input type="radio"
                                       <c:if test="${sessionScope.loginUser.gender == 1}">checked="checked"</c:if>
                                       value="1" name="user.gender"> 男
                                <input type="radio"
                                       <c:if test="${sessionScope.loginUser.gender == 2}">checked="checked"</c:if>
                                       value="2" name="user.gender"> 未知
                            </div>
                            <div class="form-group">
                                <label>生日：</label>
                                <input class="layui-input" placeholder="自定义日期格式" name="user.borndate"
                                <c:if test="${sessionScope.loginUser.borndate != null}">
                                       value='<fmt:formatDate value="${sessionScope.loginUser.borndate}" pattern="yyyy-MM-dd"/>'
                                </c:if> readonly="readonly"
                                       onclick="layui.laydate({elem: this,festival: true,istime: true, format: 'YYYY-MM-DD'})">
                            </div>
                            <div class="form-group">
                                <label>住址：</label>
                                <input type="text" placeholder="请输入住址" class="form-control" id="addressDetails"
                                       name="user.addressDetails" value="${sessionScope.loginUser.addressDetails}">
                            </div>
                            <div class="form-group">
                                <label>个人描述：</label>
                                <textarea class="layui-textarea" id="lay_editor" name="description"
                                          style="display: none"
                                          rows="4">${sessionScope.loginUser.description}</textarea>
                            </div>
                            <div>
                                <button type="submit" class="btn btn-primary btn-sm btn-block"><i></i> 更改</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js-v=2.1.4.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js-v=3.3.5.js"></script>
<script src="${pageContext.request.contextPath}/static/js/content.min.js-v=1.0.0.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins/peity/jquery.peity.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/demo/peity-demo.min.js"></script>
<script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js" charset="utf-8"></script>
</body>
<script>
    layui.use(['layedit', 'laydate'], function () {
        var layedit = layui.layedit, $ = layui.jquery;
        //自定义工具栏
        var index = layedit.build('lay_editor', {
            tool: ['face', 'link', 'unlink']
            , height: 160
        });

        $('form').submit(function () {
            if ($.trim($('#addressDetails').val()) == '') {
                layer.msg('请输入住址详情', {icon: 5, offset: '200px'});
                return false;
            }
            var content = layedit.getContent(index);
            if ($.trim(content) == '') {
                layer.msg('请输入个人描述', {icon: 5, offset: '200px'});
                return false;
            }
            $('#desc').val(content);
        });
    });

    layui.use('upload', function () {
        layui.upload({
            url: '/user/uploadMyBg'
            , elem: '#test'
            ,ext: 'jpg|png|gif'
            ,title: '主页图片'
            , method: 'post'
            , success: function (data) {
                location.href = data.url;
            }
        });
    });

    layui.use('upload', function () {
        layui.upload({
            url: '/user/uploadMyBg'
            , elem: '#test1'
            ,ext: 'jpg|png|gif'
            ,title: '主页图片'
            , method: 'post'
            , success: function (data) {
                location.href = data.url;
            }
        });
    });

    function changeBg() {
        $('#test1').click();
    }

    var laydate = layui.laydate;
    laydate.skin('molv');
</script>
</body>
</html>