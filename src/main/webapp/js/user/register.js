$(function () {
    $("#regForm").submit(function () {
        var flag = false;
        var email = $('#email');
        if ($.trim(email.val()) == '') {
            $('#emailMsg').html('邮箱不能为空');
            email.focus();
        } else if (/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(email.val()) == false) {
            $('#emailMsg').html('邮箱格式不正确，请重新输入');
            email.focus();
        } else {
            flag = true;
            $('#emailMsg').html('');
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

function checkEmail() {
    $.get("/user/checkEmail", {email: $('#email').val()},
        function (data) {
            if (data == 'true') {
                $('#emailMsg').html('该邮箱已存在???..');
            } else {
                $('#emailMsg').html('');
            }
        });
}