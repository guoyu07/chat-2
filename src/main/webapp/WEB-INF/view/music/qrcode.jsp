<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>查看二维码</title>
</head>
<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
<style type="text/css">
    body {
        text-align: center
    }

    #center-in-center {
        margin: 20% auto;
        width: 250px;
        height: 250px;
    }
</style>
<body>
<div id="center-in-center"
     style="background:url('${pageContext.request.contextPath}/music/createQRCode') no-repeat;background-size:100% 100%;">
</div>
</body>
</html>
