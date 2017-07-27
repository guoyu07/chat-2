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
<link rel="stylesheet" href="${pageContext.request.contextPath}/ueditor/themes/default/css/ueditor.css" />
<style>
    .input-lg{
        margin: 10px;
        height: 50px;
        width: 600px;
    }
    #container{
        width:80%;
        height: 600px;
        margin-left:10px;
    }
</style>
<body>
<input type="text" class="form-control input-lg" id="title" placeholder="请输入文章标题">
<input type="text" class="form-control input-lg" id="keywords" placeholder="请输入文章关键字,用','分割">
<!-- 加载编辑器的容器 -->
<script id="container" name="content" type="text/plain">
</script>
<br/><br/><br/><br/><br/>
<div style="margin-left: 10px;">
    <button class="btn btn-info btn-lg" type="button">发表</button>
    <button class="btn btn-info btn-lg" type="button">返回</button>
</div>
</body>
<!-- 实例化编辑器 -->
<script type="text/javascript">
    var ue = UE.getEditor('container');
</script>
</html>
