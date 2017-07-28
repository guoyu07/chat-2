<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/27
  Time: 13:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/header.jsp" flush="true"/>
<html>
<head>
    <title>Title</title>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/lang/zh-cn/zh-cn.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/ueditor/themes/default/css/ueditor.css"/>
<style>
    .input-lg {
        margin: 10px;
        height: 50px;
        width: 600px;
    }

    #container {
        width: 66%;
        margin-left: 10px;
    }
</style>
<body>
<form action="/article/add" method="post" enctype="multipart/form-data" id="articleForm">
    <input type="text" class="form-control input-lg" id="title" name="article.title" placeholder="请输入文章标题">
    <input type="text" class="form-control input-lg" id="keywords" name="article.keywords" placeholder="请输入文章关键字,用空格分割">
    <input type="hidden" id="content" name="article.content"/>
    <input type="hidden" id="authorId" name="article.authorId" value="${sessionScope.loginUser.id}"/>
    <input type="hidden" id="authorName" name="article.authorName" value="${sessionScope.loginUser.email}"/>
    <!-- 加载编辑器的容器 -->
    <script id="container" type="text/plain" style="height:500px;">
    </script>
    <br/>
    <div style="margin-left: 10px;">
        <button class="btn btn-info btn-lg" type="submit" id="publish">发表</button>
        <button class="btn btn-info btn-lg" type="button">返回</button>
    </div>
</form>
</body>
<!-- 实例化编辑器 -->
<script type="text/javascript">
    var ue = UE.getEditor('container');

    $('#publish').click(function () {
        if ($.trim($('#title').val()) == '') {
            layer.tips('请输入文章标题', '#title');
            return false;
        }
        if ($.trim($('#keywords').val()) == '') {
            layer.tips('请至少输入一个关键词', '#keywords');
            return false;
        }
        var content = ue.getContent();
        if ($.trim(content) == '') {
            layer.tips('请输入文章内容', '#container');
            return false;
        }
        $('#content').val(content);
        var ii = layer.load();
        setTimeout(function () {
            $('#articleForm').submit();
            layer.close(ii);
        }, 1000);
    })
</script>
</html>
