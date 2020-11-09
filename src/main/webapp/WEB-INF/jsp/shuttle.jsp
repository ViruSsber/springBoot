<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/10/15
  Time: 23:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
    <legend>权限分配</legend>
</fieldset>
<div id="test1" class="demo-transfer"></div>

<div id="test7" class="demo-transfer"></div>

<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use(['transfer', 'layer', 'util'], function(){
        var $ = layui.$
            ,transfer = layui.transfer
            ,layer = layui.layer
            ,util = layui.util;

        //模拟数据
        var data1 = [
            {"value": "1", "title": "预约诊断"}
            ,{"value": "2", "title": "预约管理"}
            ,{"value": "3", "title": "时间设置"}
            ,{"value": "4", "title": "用户管理"}
            ,{"value": "5", "title": "系统管理", "disabled": true}
            ,{"value": "6", "title": "后台用户管理"}
            ,{"value": "7", "title": "用户统计"}
            ,{"value": "8", "title": "渠道统计"}
            ,{"value": "9", "title": "参数设置"}
        ]

        //基础效果
        transfer.render({
            elem: '#test1'
            ,title: ['已分配', '未分配']  //自定义标题
            ,data: data1
            ,onchange: function(obj, index){
                var arr = ['左边', '右边'];
                // layer.alert('来自 <strong>'+ arr[index] + '</strong> 的数据：'+ JSON.stringify(obj)); //获得被穿梭时的数据
                console.log(JSON.stringify(obj)+JSON.stringify({"index":index}))
            }
        })
    });
</script>

</body>
</html>
