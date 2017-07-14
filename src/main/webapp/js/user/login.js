$(function () {
    $("#loginForm").submit(function () {
        var flag = false;
        var username = $('#username');
        if ($.trim(username.val()) == '') {
            $('#usernameMsg').html('用户不能为空');
            username.focus();
        }else if($.trim(username.val()).length < 4){
            $('#usernameMsg').html('用户名长度最短为4位');
            username.focus();
        } else {
            flag = true;
            $('#usernameMsg').html('');
        }
        if (!flag) return flag;

        var password = $('#password');
        if ($.trim(password.val()) == '') {
            $('#passwordMsg').html('密码不能为空');
            password.focus();
            flag = false;
        } else if ($.trim(password.val()).length < 6 || $.trim(password.val()).length > 16) {
            $('#passwordMsg').html('密码的长度必须在6-16位之间');
            password.focus();
            flag = false;
        } else {
            $('#passwordMsg').html('');
            flag = true;
        }
        return flag;
    })
})