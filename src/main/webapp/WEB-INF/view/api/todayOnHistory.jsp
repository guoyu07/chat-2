<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/10
  Time: 15:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/header.jsp" flush="true"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<div class="accordion" id="accordion" style="width: 1000px;margin: auto;">
</div>
</body>
<script>
    $(function () {
        $.ajax({
            async: false,
            type: "POST",
            url: "${pageContext.request.contextPath}/api/todayOnHistory",
            dataType: "JSON",
            success: function (data) {
                if (data.retCode == 200) {
                    var html = '';
                    var result = data.result;
                    for (var i = 0; i < result.length; i++) {
                        html += '<div class="accordion-group">';
                        html += '<div class="accordion-heading">';
                        if(i == 0)
                            html += '<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse' + i + '">';
                        else
                            html += '<a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapse' + i + '">';
                        html += '<h3>' + result[i].title + '</h3>';
                        html += '</a>';
                        html += '</div>';
                        if(i == 0)
                            html += '<div id="collapse' + i + '" class="accordion-body collapse in">';
                        else
                            html += '<div id="collapse' + i + '" class="accordion-body collapse">';
                        html += '<div class="accordion-inner">';
                        html += '<p class="lead">' + result[i].event + '</p>';
                        html += '</div>';
                        html += '</div>';
                        html += '</div>';
                    }
                    $('#accordion').html(html);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    })
</script>
</html>
