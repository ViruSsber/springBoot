<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/10/13
  Time: 22:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userLogin.css">
</head>
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<body>
${userAccount}
${sessionScope.userPassword}
${applicationScope.uName}
<div class="wrap">
    <img src="${pageContext.request.contextPath}/images/back.jpg" class="imgStyle">
    <div class="loginForm">
        <form>
            <div class="logoHead">
                <!--<h2 style="margin-top: 15px">房产销售平台管理系统</h2>-->
            </div>
            <div class="usernameWrapDiv">
                <div class="usernameLabel">
                    <label>用户名:</label>
                </div>
                <div class="usernameDiv">
                    <i class="layui-icon layui-icon-username adminIcon"></i>
                    <input id="loginUsername" class="layui-input adminInput" type="text" name="account"
                           placeholder="输入用户名">
                </div>
            </div>
            <div class="usernameWrapDiv">
                <div class="usernameLabel">
                    <label>密码:</label>
                </div>
                <div class="passwordDiv">
                    <i class="layui-icon layui-icon-password adminIcon"></i>
                    <input id="loginPassword" class="layui-input adminInput" type="password" name="password"
                           placeholder="输入密码">
                </div>
            </div>
            <div class="usernameWrapDiv">
                <div class="usernameLabel">
                    <label>验证码:</label>
                </div>
                <div class="cardDiv">
                    <input id="loginCard" class="layui-input cardInput" type="text" name="card" placeholder="输入验证码">
                </div>
                <div class="codeDiv">
                    <input id="loginCode" class="layui-input codeInput" type="button">
                </div>
            </div>
            <div class="usernameWrapDiv">
                <div class="submitLabel">
                    <label>没有账号？<a href="#" id="loginRegister">点击注册</a></label>
                </div>
                <div class="submitDiv">
                    <input id="loginBtn" type="button" class="submit layui-btn layui-btn-primary" value="登录">
                </div>
            </div>
        </form>
    </div>
</div>
<script src="${pageContext.request.contextPath}/layui/layui.js" type="text/javascript"></script>
<script>
    layui.use(['layer'], function () {
        var layer = layui.layer;
    })
    $(function () {
        // 页面初始化生成验证码
        window.onload = createCode('#loginCode');
        // 验证码切换
        $('#loginCode').click(function () {
            createCode('#loginCode');
        });
        // 登陆事件
        $('#loginBtn').click(function () {
            login();
        });
        // 注册事件
        $('#loginRegister').click(function () {
            register();
        });
    });

    // 生成验证码
    function createCode(codeID) {
        var code = "";
        // 验证码长度
        var codeLength = 4;
        // 验证码dom元素
        var checkCode = $(codeID);
        // 验证码随机数
        var random = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
            'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
        for (var i = 0; i < codeLength; i++) {
            // 随机数索引
            var index = Math.floor(Math.random() * 36);
            code += random[index];
        }
        // 将生成的随机验证码赋值
        checkCode.val(code);
    }

    // 校验验证码、用户名、密码
    function validateLogin(inputID, codeID) {
        var inputCode = $(inputID).val().toUpperCase();
        var cardCode = $(codeID).val();
        var loginUsername = $('#loginUsername').val();
        var loginPassword = $('#loginPassword').val();
        if ($.trim(loginUsername) == '' || $.trim(loginUsername).length <= 0) {
            layer.alert("用户名不能为空");
            return false;
        }
        if ($.trim(loginPassword) == '' || $.trim(loginPassword).length <= 0) {
            layer.alert("密码不能为空");
            return false;
        }
        if (inputCode.length <= 0) {
            layer.alert("验证码不能为空");
            return false;
        }
        if (inputCode != cardCode) {
            layer.alert("请输入正确验证码");
            return false;
        }
        return true;
    }

    // 登录流程
    function login() {
        if (!validateLogin('#loginCard', '#loginCode')) {
            //阻断提示
        } else {
            var loginUsername = $('#loginUsername').val();
            var loginPassword = $('#loginPassword').val();
            var params = {"loginUsername": loginUsername, "loginPassword": loginPassword};

            var loginLoadIndex = layer.load(2);
            $('#loginBtn').val("正在登录...");
            $.ajax({
                type: 'post',
                url: "userLogin",
                // dataType: 'text',//后台返回的数据格式
                data: params,
                // contentType:'application/json;charset=utf-8',//前端提交的数据格式
                success: function (data) {
                    // console.log(data);
                    layer.close(loginLoadIndex);
                    if (data == 'success') {
                        layer.alert("登录成功");
                    } else {
                        layer.alert("账号或者密码错误");
                        $('#loginBtn').val("登录");
                    }
                },
                error: function () {
                    layer.close(loginLoadIndex);
                    $('#loginBtn').val("登录");
                }
            });
        }

    }

    // 注册信息校验
    function validateRegister() {
        var registerUsername = $('#registerUsername').val();
        var registerAccount = $('#registerAccount').val();
        var registerPassword = $('#registerPassword').val();
        var registerWellPassword = $('#registerWellPassword').val();
        var registerEducation = $('#educationSelect option:selected').val();
        var registerProfession = $('#professionSelect option:selected').val();
        var registerPhone = $('#registerPhone').val();
        var registerEmail = $('#registerEmail').val();
        if ($.trim(registerUsername) == '' || $.trim(registerUsername).length <= 0) {
            layer.alert("用户名不能为空");
            return false;
        }
        if ($.trim(registerAccount) == '' || $.trim(registerAccount).length <= 0) {
            layer.alert("账号不能为空");
            return false;
        }
        if ($.trim(registerPassword) == '' || $.trim(registerPassword).length <= 0) {
            layer.alert("密码不能为空");
            return false;
        }
        if ($.trim(registerWellPassword) == '' || $.trim(registerWellPassword).length <= 0) {
            layer.alert("确认密码不能为空");
            return false;
        }
        if (registerPassword != registerWellPassword) {
            layer.alert("两次密码输入不一致");
            return false;
        }
        if ($.trim(registerEducation) == '' || $.trim(registerEducation).length <= 0) {
            layer.alert("学历不能为空");
            return false;
        }
        if ($.trim(registerProfession) == '' || $.trim(registerProfession).length <= 0) {
            layer.alert("职业不能为空");
            return false;
        }
        if ($.trim(registerPhone) == '' || $.trim(registerPhone).length <= 0) {
            layer.alert("手机不能为空");
            return false;
        }
        if ($.trim(registerEmail) == '' || $.trim(registerEmail).length <= 0) {
            layer.alert("email不能为空");
            return false;
        }

        return true;
    }

    // 注册流程
    function register() {
        layer.open({
            type: '1',
            content: $('.registerPage'),
            title: '注册',
            area: ['430px', '600px'],
            btn: ['注册', '重置', '取消'],
            closeBtn: '1',
            btn1: function (index, layero) {
                //注册回调
                var registerUsername = $('#registerUsername').val();
                var registerAccount = $('#registerAccount').val();
                var registerPassword = $('#registerPassword').val();
                var registerSex = $('input[name="sex"]:checked').val();
                var registerEducation = $('#educationSelect option:selected').val();
                var registerProfession = $('#professionSelect option:selected').val();
                var registerPhone = $('#registerPhone').val();
                var registerEmail = $('#registerEmail').val();
                var params = {
                    "uName": registerUsername,
                    "account": registerAccount,
                    "password": registerPassword,
                    "sex": registerSex,
                    "education": registerEducation,
                    "profession": registerProfession,
                    "phone": registerPhone,
                    "email": registerEmail,
                    "regTime": getCurTime()
                };

                var registerLoadIndex = layer.load(2);
                $.ajax({
                    type: 'post',
                    url: "userRegister",
                    dataType: 'text',
                    data: params,
                    // contentType:'application/json',
                    beforeSend: function () {
                        layer.close(registerLoadIndex);
                        return validateRegister();
                    },
                    success: function (data) {
                        if (data=='success'){
                            layer.close(registerLoadIndex);
                            layer.msg('注册成功');
                            layer.close(index);// 关闭注册页面
                        }else if (data == 'fail'){
                            layer.alert("注册失败，请重新操作")
                        }else {
                            layer.alert("该账号已被注册，请重新操作")
                        }
                    },
                    error: function () {
                        layer.close(registerLoadIndex);
                        layer.alert("请求超时！")
                    }
                });
            },
            btn2: function (index, layero) {
                //重置回调
                var registerUsername = $('#registerUsername').val("");
                var registerAccount = $('#registerAccount').val("");
                var registerPassword = $('#registerPassword').val("");
                var registerWellPassword = $('#registerWellPassword').val("");
                $('input[name="sex"]').attr('checked', false);
                // var registerEducation = $('#educationSelect option:selected').val("");
                // var registerProfession = $('#professionSelect option:selected').val("");
                $("select:first option:first").attr("selected", true);
                $("select:last option:first").attr("selected", true);
                var registerPhone = $('#registerPhone').val("");
                var registerEmail = $('#registerEmail').val("");

                // 防止注册页面关闭
                return false;
            },
            btn3: function (index, layero) {
                //取消回调
            }
        });
    }

    function getCurTime() {
        var myDate = new Date();
        //获取当前年
        var year = myDate.getFullYear();
        //获取当前月
        var month = myDate.getMonth() + 1;
        //获取当前日
        var date = myDate.getDate();
        var h = myDate.getHours();       //获取当前小时数(0-23)
        var m = myDate.getMinutes();     //获取当前分钟数(0-59)
        var s = myDate.getSeconds();
        var now = year + '-' + getNow(month) + "-" + getNow(date) + " " + getNow(h) + ':' + getNow(m) + ":" + getNow(s);
        // 返回时间
        return now;
    }

    // 获取当前时间
    function getNow(s) {
        return s < 10 ? '0' + s : s;
    }

</script>

</body>
<div class="registerPage">
    <div class="registerDiv">
        <form>
            <div class="registerWrapDiv">
                <div class="registerLabel">
                    <label>用户名:</label>
                </div>
                <div class="registerUsernameDiv">
                    <i class="layui-icon layui-icon-username adminIcon"></i>
                    <input id="registerUsername" class="layui-input adminInput" type="text" name="username"
                           placeholder="输入用户名">
                </div>
            </div>
            <div class="registerWrapDiv">
                <div class="registerLabel">
                    <label>账号:</label>
                </div>
                <div class="registerUsernameDiv">
                    <i class="layui-icon layui-icon-username adminIcon"></i>
                    <input id="registerAccount" class="layui-input adminInput" type="text" name="username"
                           placeholder="输入账号">
                </div>
            </div>
            <div class="registerWrapDiv">
                <div class="registerLabel">
                    <label>密码:</label>
                </div>
                <div class="registerPasswordDiv">
                    <i class="layui-icon layui-icon-password adminIcon"></i>
                    <input id="registerPassword" class="layui-input adminInput" type="password" name="password"
                           placeholder="输入密码">
                </div>
            </div>
            <div class="registerWrapDiv">
                <div class="registerLabel">
                    <label>确认密码:</label>
                </div>
                <div class="registerPasswordDiv">
                    <i class="layui-icon layui-icon-password adminIcon"></i>
                    <input id="registerWellPassword" class="layui-input adminInput" type="password" name="password"
                           placeholder="输入密码">
                </div>
            </div>
            <div class="registerWrapDiv">
                <div class="registerLabel">
                    <label>性别:</label>
                </div>
                <div class="registerSexDiv">
                    <input type="radio" name="sex" value="男" title="男">男
                    <input type="radio" name="sex" value="女" title="女" checked>女
                </div>
            </div>
            <div class="registerWrapDiv">
                <div class="registerLabel">
                    <label>学历:</label>
                </div>
                <div class="registerSelectDiv">
                    <select name="education" lay-verify="required" id="educationSelect">
                        <option value=""></option>
                        <option value="专科">专科</option>
                        <option value="本科">本科</option>
                        <option value="硕士">硕士</option>
                        <option value="博士">博士</option>
                    </select>
                </div>
            </div>
            <div class="registerWrapDiv">
                <div class="registerLabel">
                    <label>职业:</label>
                </div>
                <div class="registerSelectDiv">
                    <select name="profession" lay-verify="required" id="professionSelect">
                        <option value=""></option>
                        <option value="网络工程师">网络工程师</option>
                        <option value="软件工程师">软件工程师</option>
                        <option value="建筑工程师">建筑工程师</option>
                        <option value="吃软饭大师">吃软饭大师</option>
                    </select>
                </div>
            </div>
            <div class="registerWrapDiv">
                <div class="registerLabel">
                    <label>手机:</label>
                </div>
                <div class="registerUsernameDiv">
                    <input id="registerPhone" class="layui-input adminInput" type="text" name="phone"
                           placeholder="输入手机号">
                </div>
            </div>
            <div class="registerWrapDiv">
                <div class="registerLabel">
                    <label>Email:</label>
                </div>
                <div class="registerPasswordDiv">
                    <input id="registerEmail" class="layui-input adminInput" type="text" name="email"
                           placeholder="输入Email">
                </div>
            </div>
        </form>
    </div>
</div>
</html>

