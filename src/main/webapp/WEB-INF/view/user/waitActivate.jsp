<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/header.jsp" flush="true"/>
    激活邮件已发送至您的邮箱"<span style="color:red;">${email}</span>"!<br/>
    <a href="#">立即激活</a>&nbsp;<a href="/user/login">已激活,马上登录</a>
</body>
</html>
