<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/header.jsp" flush="true"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="${pageContext.request.contextPath}/css/api/weather.css" rel="stylesheet">
<div class="wrapper shadow">
    <div class="top">
        <div class="text-city" style="margin-top: 100px;">
            <span class="">输入电话号码：</span>
            <input type="text" id="phone" value="">
        </div>
    </div>
    <div class="bot">
        <div style="text-align: center;color: crimson;font-size: 16px;" id="message">
        </div>
        </ul>
    </div>
</div>
</body>
<script>
    var placeholder = '';
    $('#phone').focus(function (event) {
        placeholder = $("#phone").val();
        $("#phone").val("");
        $('#phone').css("border-bottom", "1px solid #F5F8FC");
    });

    $('#phone').blur(function (event) {
        if ($("#phone").val() == "") {
            $("#phone").val(placeholder);
        }
    });

    $('#phone').keypress(function () {
        if (event.which == 13) {
            search();
            $('#phone').blur();
        }
    });
    function search() {
        var phone = $('#phone').val();
        $.ajax({
            async: false,
            type: "POST",
            url: "${pageContext.request.contextPath}/api/mobile",
            data: {
                phone: phone
            },
            dataType: "JSON",
            success: function (data) {
                if (data.retCode == 200) {
                    var result = data.result;
                    var html = '';
                    html += result.province + '省' + result.city + ' ' + result.operator;
                    html += '<br/>' + result.city + '区号:' + result.cityCode + ',邮编:' + result.zipCode;
                    $.ajax({
                        async: false,
                        type: "POST",
                        url: "${pageContext.request.contextPath}/api/luckyMobile",
                        data: {
                            phone: phone
                        },
                        dataType: "JSON",
                        success: function (json) {
                            if (json.retCode == 200) {
                                html += '<br/><br/>' + json.result.conclusion;
                            } else {
                            }
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                        }
                    });
                    $('#message').html(html);
                } else {
                    $('#message').html(data.msg);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }
</script>
</html>
