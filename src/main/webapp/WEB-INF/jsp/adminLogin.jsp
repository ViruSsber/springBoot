<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/10/13
  Time: 15:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>欢迎登录</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">

    <style>
        #father{
            width:400px;
            height:300px;
            position:absolute;
            left:50%;
            top:40%;
            margin-left:-180px;
            margin-top:-100px;
            border: 1px solid #5FB878;
        }
    </style>
</head>
<body>
<div style="width: 100%;height: 100%;background: url('${pageContext.request.contextPath}/images/back.jpg') no-repeat;">
<img src="${pageContext.request.contextPath}/images/back.jpg" style="width: 100%;height: 100%;">
<div id="father">
    <form action="" class="layui-form" style="padding: 60px 1px;">
            <div class="layui-form-item">
                <label class="layui-form-label">账号</label>
                <div class="layui-input-inline">
                    <input type="text" name="account" required  lay-verify="required" placeholder="请输入账号" autocomplete="off" class="layui-input"><br>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">密码</label>
                <div class="layui-input-inline">
                    <input type="password" name="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">辅助文字</div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
<%--                    <button id="loginBtn" class="layui-btn">立即登录</button>--%>
                    <input id="loginBtn" type="button" class="submit layui-btn layui-btn-primary" value="登录">
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
    </form>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script>
        layui.use(['layer'],function () {
            var layer = layui.layer;
        })
        // 登陆事件
        $('#loginBtn').click(function () {
            login();
        });
        function login() {
            var loginAccount = $('input[name=account]').val();
            var loginPassword = $('input[name=password]').val();
            console.log(loginAccount+"   "+loginPassword)
            $.ajax({
                url:'adminLogin',
                type: 'post',
                dataType: 'text',
                data:{"loginAccount":loginAccount,"loginPassword":loginPassword},
                success:function (data) {
                    if (data == 'success'){
                        <%--window.location.href = '${pageContext.request.contextPath}/jsp/backMain.jsp';--%>
                        // var ok = layer.alert("登录成功");
                        // console.log(ok)
                        // if (ok==1){
                            window.location.href = 'backMainJsp';
                        // }
                    }else{
                        layer.alert("账号或者密码错误");
                    }
                },
                error:function () {
                    layer.alert("网络异常");
                }
            })
        }
    </script>
</div>
</div>
</body>
</html>
