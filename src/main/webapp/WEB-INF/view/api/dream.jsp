<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/header.jsp" flush="true"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="${pageContext.request.contextPath}/css/api/weather.css" rel="stylesheet">
<div class="wrapper shadow">
    <div class="top">
        <div class="text-city" style="margin-top: 100px;">
            <span class="">输入梦源关键字：</span>
            <input type="text" id="name" value="">
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
    $('#name').focus(function (event) {
        placeholder = $("#name").val();
        $("#name").val("");
        $('#name').css("border-bottom", "1px solid #F5F8FC");
    });

    $('#name').blur(function (event) {
        if ($("name").val() == "") {
            $("#name").val(placeholder);
        }
    });

    $('#name').keypress(function (e) {
        if (e.keyCode == 13) {
            search();
            $('#name').blur();
        }
    });
    function search() {
        var name = $('#name').val();
        $.ajax({
            async: false,
            type: "POST",
            url: "${pageContext.request.contextPath}/api/dream",
            data: {
                name: name
            },
            dataType: "JSON",
            success: function (data) {
                if (data.retCode == 200) {
                    var html = '';
                    var result = data.result;
                    for (var i = 0; i < result.list.length; i++) {
                        html += result.list[i].detail + '<br/>';
                    }
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
