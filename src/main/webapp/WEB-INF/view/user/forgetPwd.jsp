<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/2
  Time: 16:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>忘记密码 - chat</title>
    <meta name="keywords" content="chat">
    <meta name="description" content="chat">

    <link rel="shortcut icon" href="favicon.ico">
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css-v=3.3.5.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/font-awesome.min.css-v=4.4.0.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/plugins/steps/jquery.steps.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/style.min.css-v=4.0.0.css" rel="stylesheet">
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox">
                <div class="ibox-title">
                    <h5>忘记密码</h5>
                </div>
                <div class="ibox-content">
                    <h2>
                        忘记密码
                    </h2>
                    <p>
                    </p>
                    <form id="form" action="/user/modifyPwd" method="post" class="wizard-big">
                        <h1>验证邮箱</h1>
                        <fieldset>
                            <h2>邮箱</h2>
                            <div class="row">
                                <div class="col-sm-8">
                                    <div class="form-group">
                                        <input id="email" name="email" type="email" class="form-control required">
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="text-center">
                                        <div style="margin-top: 20px">
                                            <i class="fa fa-sign-in" style="font-size: 180px;color: #e5e5e5 "></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                        <h1>验证标识码</h1>
                        <fieldset>
                            <div class="text-center" style="margin-top: 120px">
                                <h2>请在下方输入您邮箱中收到的标识码</h2>
                                <h3><span id="tips" style="color: #1AB394"></span></h3>
                                <input id="uuidConfirm" name="uuid" type="text" class="form-control required">
                            </div>
                        </fieldset>
                        <h1>设置新密码</h1>
                        <fieldset>
                            <h2>设置密码</h2>
                            <div class="row">
                                <div class="col-sm-8">
                                    <div class="form-group">
                                        <label>密码 *</label>
                                        <input id="password" name="password" type="password"
                                               class="form-control required" minlength="6" maxlength="16">
                                    </div>
                                    <div class="form-group">
                                        <label>确认密码 *</label>
                                        <input id="confirm" name="confirm" type="password"
                                               class="form-control required" minlength="6" maxlength="16">
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="text-center">
                                        <div style="margin-top: 20px">
                                            <i class="fa fa-sign-in" style="font-size: 180px;color: #e5e5e5 "></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                        <h1>完成</h1>
                        <fieldset>
                            <h2><span id="finalTips"></span></h2>
                        </fieldset>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js-v=2.1.4.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery.md5.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js-v=3.3.5.js"></script>
<script src="${pageContext.request.contextPath}/static/js/content.min.js-v=1.0.0.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins/staps/jquery.steps.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins/validate/jquery.validate.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins/validate/messages_zh.min.js"></script>
<script src="${pageContext.request.contextPath}/layer/layer.js" type="text/javascript"></script>
<script>
    var id = "";
    var uuid = "";
    $(document).ready(function () {
        $("#wizard").steps();
        $("#form").steps({
            bodyTag: "fieldset", onStepChanging: function (event, currentIndex, newIndex) {
                if (currentIndex > newIndex) {
                    return true
                }
                if (newIndex === 3 && Number($("#age").val()) < 18) {
                    return false
                }
                var form = $(this);
                if (currentIndex < newIndex) {
                    $(".body:eq(" + newIndex + ") label.error", form).remove();
                    $(".body:eq(" + newIndex + ") .error", form).removeClass("error")
                }
                form.validate().settings.ignore = ":disabled,:hidden";
                var flag = true;
                if (form.valid()) {
                    var mail = $('#email').val();
                    if (currentIndex == 0) {
                        $.ajax({
                            async: false,
                            type: "POST",
                            url: "${pageContext.request.contextPath}/user/verifyMailExists",
                            data: {
                                mail: mail
                            },
                            success: function (json) {
                                if (json.ret == '1') {
                                    layer.msg(json.msg, {icon: 5, offset: '250px'});
                                    flag = false;
                                } else {
                                    id = json.id
                                    uuid = json.uuid;
                                    $('#tips').text(json.msg);
                                }
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                            }
                        });
                    }
                    if (currentIndex == 1) {
                        if (uuid != $('#uuidConfirm').val()) {
                            layer.msg('您输入的激活码有误', {icon: 5, offset: '250px'});
                            flag = false;
                        }
                    }
                    if (currentIndex == 2) {
                        var pwd = $('#password').val()
                        $.ajax({
                            async: false,
                            type: "POST",
                            url: "${pageContext.request.contextPath}/user/modifyPwdAjax",
                            data: {
                                id: id,
                                pwd: pwd
                            },
                            success: function (json) {
                                if (json.ret == '1') {
                                    layer.msg(json.msg, {icon: 5, offset: '250px'});
                                    flag = false;
                                } else {
                                    $('#finalTips').text(json.msg + ",马上登录!");
                                    setTimout(location.href = '${pageContext.request.contextPath}/user/login', 3000);
                                }
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                            }
                        });
                    }
                }
                if (flag)
                    return form.valid()
            }, onStepChanged: function (event, currentIndex, priorIndex) {
                if (currentIndex === 2 && Number($("#age").val()) >= 18) {
                    $(this).steps("next")
                }
                if (currentIndex === 2 && priorIndex === 3) {
                    $(this).steps("previous")
                }
            }, onFinishing: function (event, currentIndex) {
                var form = $(this);
                form.validate().settings.ignore = ":disabled";
                /*if(form.valid()){

                 }*/
                return form.valid()
            }, onFinished: function (event, currentIndex) {
                var form = $(this);
                location.href = '${pageContext.request.contextPath}/user/login'
            }
        }).validate({
            errorPlacement: function (error, element) {
                element.before(error)
            }, rules: {confirm: {equalTo: "#password"}}
        })
    });
</script>
</body>
</html>