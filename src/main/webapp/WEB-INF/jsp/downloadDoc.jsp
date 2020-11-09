<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/11/2
  Time: 14:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>文件下载</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
</head>
<body>
    <form action="fileAct" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
        please select file:<input type="file" name="imgFile">
        <input type="submit" value="submit">
    </form>

    <h1>file download</h1>
    <a href="download?fileName=9ce72173-113e-475d-87f6-8220b5d9c3dd.chm">张孝祥面试宝典</a>
    <a href="xxx.jpg">download-2</a>
</body>
</html>
