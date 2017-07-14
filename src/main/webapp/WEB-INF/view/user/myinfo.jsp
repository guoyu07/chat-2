<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/header.jsp" flush="true"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    small {
        float: left;
        width: 50px;
    }

    .rightSpan {
        float: right;
        width: 80px;
    }
</style>
<div style="margin: 0 auto;width: 330px;">
    <h5>
        <span class="centerSpan">
        <c:if test="${not empty sessionScope.loginUser.picSummary}">
            <img src="${sessionScope.loginUser.picSummary}" class="img-circle" style="background-color: #cccccc;"
                 onclick="changePic();"/>
        </c:if>
        </span>
        <form method="post" action="/user/uploadPic" enctype="multipart/form-data" id="picForm">
            <img src="${pageContext.request.contextPath}/images/avatar.png" class="img-circle"
                 style="background-color: #cccccc;" onclick="changePic();">
            <input type="file" id="picFile" name="picSummary" style="display: none;">
        </form>
    </h5>
    <div>
        <h5>
            <small>账户</small>
            <span class="centerSpan">
                ${empty sessionScope.loginUser.username ? '<a href="javascript:;" onclick="setMyInfo(this);">设置账户</a>' : sessionScope.loginUser.username}
            </span>
            <span class="rightSpan">
                ${empty sessionScope.loginUser.username ? '' : '<a href="javascript:;" onclick="setMyInfo(this);">更改账户</a>'}
            </span>
        </h5>
    </div>
    <div style="display: none;">
        <h5>
            <small>账户</small>
        </h5>
        <form action="/user/update">
            <input type="text" name="user.username" id="username" placeholder="请输入新的账户名"/>
            <span style="color: crimson;" class="updateErrMsg"></span>
            <input type="button" onclick="updateMyInfo(this)" value="确定"/>
            <input type="button" onclick="setCancel(this);" value="取消"/>
        </form>
    </div>

    <h5>
        <small>邮箱</small>
        <span class="centerSpan">
            ${sessionScope.loginUser.email}
        </span>
    </h5>
    <div>
        <h5>
            <small>电话</small>
            <span class="centerSpan">
                ${empty sessionScope.loginUser.phone ? '<a href="javascript:;" onclick="setMyInfo(this);">设置电话</a>' : sessionScope.loginUser.phone}
            </span>
            <span class="rightSpan">
                ${empty sessionScope.loginUser.phone ? '' : '<a href="javascript:;" onclick="setMyInfo(this);">更改电话</a>'}
            </span>
        </h5>
    </div>
    <div style="display: none;">
        <h5>
            <small>电话</small>
        </h5>
        <form action="/user/update">
            <input type="text" name="user.phone" id="phone"/>
            <span style="color: crimson;" class="updateErrMsg"></span>
            <input type="button" onclick="updateMyInfo(this)" value="确定"/>
            <input type="button" onclick="setCancel(this);" value="取消"/>
        </form>
    </div>
    <div>
        <h5>
            <small>身份证</small>
            <span class="centerSpan">
                ${empty sessionScope.loginUser.idCard ? '<a href="javascript:;" onclick="setMyInfo(this);">设置身份证</a>' : sessionScope.loginUser.idCard}
            </span>
            <span class="rightSpan">
                ${empty sessionScope.loginUser.idCard ? '' : '<a href="javascript:;" onclick="setMyInfo(this);">更改身份证</a>'}
            </span>
        </h5>
    </div>
    <div style="display: none;">
        <h5>
            <small>身份证</small>
        </h5>
        <form action="/user/update">
            <input type="text" name="user.idCard" id="idCard"/>
            <span style="color: crimson;" class="updateErrMsg"></span>
            <input type="button" onclick="updateMyInfo(this)" value="确定"/>
            <input type="button" onclick="setCancel(this);" value="取消"/>
        </form>
    </div>

    <h5>
        <small>昵称</small>
        <span class="centerSpan">
            ${sessionScope.loginUser.nickname}
        </span>
    </h5>
    <h5>
        <small>性别</small>
        <span class="centerSpan">
            ${sessionScope.loginUser.gender == null ? '未知' : sessionScope.loginUser.gender == 0 ? '女' : sessionScope.loginUser.gender == 1 ? '男' : '未知'}
        </span>
    </h5>
    <h5>
        <small>住址</small>
        <span class="centerSpan">
            ${sessionScope.loginUser.addressDetails}&nbsp;
        </span>
    </h5>
    <h5>
        <small>出生日期</small>
        <span class="centerSpan">
            ${sessionScope.loginUser.borndate}&nbsp;
        </span>
    </h5>
    <h5>
        <small>个人简介</small>
        <span class="centerSpan">
            ${sessionScope.loginUser.description}&nbsp;
        </span>
    </h5>
    <h5>
        <a id="modal-583848" href="#modal-container-583848" role="button" data-toggle="modal">修改</a>&nbsp;
        <a href="/">主页</a>
    </h5>
</div>
<div class="col-md-12 column">
    <div class="modal fade" id="modal-container-583848" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="myModalLabel">
                        修改信息
                    </h4>
                </div>
                <form action="/user/update" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="user.id" id="userId" value="${sessionScope.loginUser.id}"/>
                        <table>
                            <tr>
                                <td>账户</td>
                                <td>${sessionScope.loginUser.username}</td>
                            </tr>
                            <tr>
                                <td>邮箱</td>
                                <td>${sessionScope.loginUser.email}</td>
                            </tr>
                            <tr>
                                <td>电话</td>
                                <td>${sessionScope.loginUser.phone}</td>
                            </tr>
                            <tr>
                                <td>身份证</td>
                                <td>${sessionScope.loginUser.idCard}</td>
                            </tr>
                            <tr>
                                <td>昵称</td>
                                <td><input type="text" name="user.nickname" value="${sessionScope.loginUser.nickname}"/>
                                </td>
                            </tr>
                            <tr>
                                <td>性别</td>
                                <td>
                                    <input type="radio" name="user.gender" value="0"
                                           <c:if test="${sessionScope.loginUser.gender == 0}">checked</c:if> />女&nbsp;
                                    <input type="radio" name="user.gender" value="1"
                                           <c:if test="${sessionScope.loginUser.gender == 1}">checked</c:if> />男&nbsp;
                                    <input type="radio" name="user.gender" value="2"
                                           <c:if test="${sessionScope.loginUser.gender == 2}">checked</c:if> />未知
                                </td>
                            </tr>
                            <tr>
                                <td>国籍</td>
                                <td>${sessionScope.loginUser.country}</td>
                            </tr>
                            <tr>
                                <td>住址</td>
                                <td><input type="text" name="user.addressDetails"
                                           value="${sessionScope.loginUser.addressDetails}" style="width: 330px"></td>
                            </tr>
                            <tr>
                                <td>出生日期</td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>个人介绍</td>
                                <td><textarea rows="4" cols="52" maxlength="200"
                                              name="user.description">${sessionScope.loginUser.description}</textarea>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="submit" class="btn btn-primary">保存</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    $("#picFile").change(function () {
        var picFile = $("#picFile").val();
        if (picFile != null & picFile != '' & !/\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/.test(picFile)) {
            alert('图片类型必须是.gif,jpeg,jpg,png中的一种');
            $('#picFile').val('');
        } else {
            $('#picForm').submit();
        }
    });

    function changePic() {
        $("#picFile").click();
    }

    function setMyInfo(user) {
        $(user).parent().parent().parent().hide().next().show();
    }

    function setCancel(user) {
        $(user).parent().parent().hide().prev().show();
    }

    function updateMyInfo(user) {
        var id = $('#userId').val();
        var key = $(user).prev().prev().attr('name');
        var value = $(user).prev().prev().val();
        var title = '';
        var arg = {};
        arg['user.id'] = id;
        arg[key] = value;
        var name, errMsg;
        if (key == 'user.username') {
            title = '账户';
            name = '更改账户';
            errMsg = '账户已存在';
        } else if (key == 'user.phone') {
            title = '电话';
            name = '更改电话';
            errMsg = '电话已存在';
        } else if (key == 'user.idCard') {
            title = '身份证';
            name = '更改身份证';
            errMsg = '身份证已存在';
        }
        $.post('/user/updateAjax', arg, function (data) {
            if (data.errMsg == true) {
                var html = '';
                html += '<h5>';
                html += '<small>' + title + '</small>';
                html += '<span class="centerSpan">' + value + '</span>';
                html += '<span class="rightSpan">';
                html += '<a href="javascript:;" onclick="setMyInfo(this);">' + name + '</a>';
                html += '</span>';
                html += '</h5>';
                $(user).parent().parent().hide().prev().show().html(html);
                $('.updateErrMsg').text('');
            } else {
                $('.updateErrMsg').text(errMsg);
            }
        }, 'json');
    }
</script>
</html>
