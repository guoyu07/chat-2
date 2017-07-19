<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/10
  Time: 15:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/header.jsp" flush="true"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/api/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/api/jquery.mobile.flatui.css" />
    <div data-role="content" class="container" role="main">
    <ul class="content-reply-box mg10" id="msgBox" style="padding-bottom: 100px;">
        <li class="odd">
            <a class="user" href="#"><img class="img-responsive avatar_" src="${pageContext.request.contextPath}/images/avatar.png" alt="">
                <span class="user-name">robot</span>
            </a>
            <div class="reply-content-box">
                <span class="reply-time"><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())%></span>
                <div class="reply-content pr">
                    <span class="arrow">&nbsp;</span>
                    ${sessionScope.loginUser.email},欢迎来找我聊天诶
                    <br/>
                    把你想说想问的就写在下面的聊天框里面呗(ˇˍˇ）
                </div>
            </div>
        </li>
    </ul>
    <%--
    <ul class="operating row text-center linear-g">
        <li class="col-xs-4"><a href="#"><span class="glyphicon glyphicon-tags"></span> &nbsp;标签</a></li>
        <li class="col-xs-4"><a href="#"><span class="glyphicon glyphicon-comment"></span> &nbsp;回复</a></li>
        <li class="col-xs-4"><a href="#"><span class="glyphicon glyphicon-heart"></span> &nbsp;喜欢</a></li>
    </ul>
    --%>
    <nav class="navbar navbar-default navbar-fixed-bottom">
        <div class="navbar-inner navbar-content-center">
            <p class="text-muted credit" style="padding: 5px;">
            </p><div class="row">
            <div class="col-lg-12">
                <div class="input-group">
                    <input type="text" id="message" class="form-control input-lg" placeholder="请输入..">
                    <span class="input-group-btn">
                            <button class="btn btn-info btn-lg" type="button" onclick="send();">发送</button>
                        </span>
                </div>
            </div>
        </div>
            <p></p>
        </div>
    </nav>
</div>
</body>
<script>
    var name = '${sessionScope.loginUser.email == null ? "游客" : sessionScope.loginUser.email}';
    var img = "${pageContext.request.contextPath}/images/avatar.png";
    function send(){
        var msg = $('#message');
        if($.trim(msg.val()) == ''){
            return false;
        }
        var time = new Date().toLocaleString();
        var html = '';
        html += ' <li class="even">';
        html += ' <a class="user" href="#"><img class="img-responsive avatar_" src='+img+' alt=""><span class="user-name">' + name + '</span></a>';
        html += '<div class="reply-content-box">';
        html += '<span class="reply-time">'+time+'</span>';
        html += '<div class="reply-content pr">';
        html += ' <span class="arrow">&nbsp;</span>';
        html += msg.val();
        html += '</div>';
        html += '</div>';
        html += '</li>';
        $.ajax({
                async : false,
                type : "GET",
                url : "${pageContext.request.contextPath}/api/tuling",
                data : {
                    question : msg.val()
                },
                dataType : "JSON",
                success : function(data) {
                    html += '<li class="odd">';
                    html += '<a class="user" href="#"><img class="img-responsive avatar_" src="${pageContext.request.contextPath}/images/avatar.png" alt=""><span class="user-name">robot</span></a>';
                    html += '<div class="reply-content-box">';
                    html += '<span class="reply-time">' + new Date().toLocaleString() + '</span>';
                    html += '<div class="reply-content pr">';
                    html += '<span class="arrow">&nbsp;</span>';
                    html += data.text;
                    html += '</div>';
                    html += '</div>';
                    html += '</li>';
                },
                error : function(XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        $('#msgBox').append(html);
        document.body.scrollTop +=1000;
        msg.val('');
    }

        $("body").keydown(function (e) {
            if (e.keyCode == "13") {//keyCode=13是回车键
                send();
            }
        });
</script>
</html>
