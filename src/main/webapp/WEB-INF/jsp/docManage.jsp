<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/10/13
  Time: 20:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>table模块快速使用</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
</head>
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<body>
<input type="hidden" value="${pageContext.request.contextPath}" id="path">

<div class="demoTime">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">注册时间</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="startTime" id="test1" placeholder="yyyy-MM-dd">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">至</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="endTime" id="test1-1" placeholder="yyyy-MM-dd">
            </div>
        </div>
    </div>
</div>

<div class="demoTable">
    <label class="layui-form-label">文档标题：</label>

    <div class="layui-inline">
        <input class="layui-input" name="dName" id="demoReload" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload" style="margin-left: 165px">搜索</button>
</div>
<table id="demo" lay-filter="test"></table>

<script src="${pageContext.request.contextPath}/layui/layui.js"></script>

<table class="layui-hide" id="test" lay-filter="test"></table>


</table>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="detail">下载</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">审核通过</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">审核不通过</a>
    <!-- 这里同样支持 laytpl 语法，如： -->
        {{#  if(d.auth > 2){ }}
        <a class="layui-btn layui-btn-xs" lay-event="check">审核</a>
        {{#  } }}
</script>
<script>
    var sTime,eTime;
    layui.use('table', function(){
        var table = layui.table;

        //渲染表格
        var tableIns = table.render({
            elem: '#demo'
            ,height: 476
            ,width:1205
            ,url: 'docList?parameterName=findAllDoc' //数据接口
            // ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'dId', title: 'ID', width:80, sort: true, fixed: 'left'}
                ,{field: 'dName', title: '文档标题', width:160}
                ,{field: 'uName', title: '上传人', width:120, templet: '<div>{{d.user.uName}}</div>'}
                ,{field: 'upTime', title: '上传时间', width:200}
                ,{field: 'docIntegral', title: '下载积分', width: 160}
                ,{field: 'dType', title: '文档类型', width: 160, sort: true}
                ,{fixed: 'right', title:'操作', width:300, align:'center', toolbar: '#barDemo'}
            ]]
            ,id: 'testReload'
            ,page: true
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            console.log(data);
            if(obj.event === 'del'){

            } else if(obj.event === 'edit'){

            }else if(obj.event === 'detail'){

            }
        });

        var $ = layui.$, active = {
            reload: function(){
                var dName = $('#demoReload');
                //执行重载
                table.reload('testReload', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        dName: dName.val()
                        ,startTime:sTime
                        ,endTime:eTime
                    }
                    // ,done: function (res, curr, count) {
                    //     this.where={};
                    // }
                }, 'data');
            }
        };
        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });

    //获取搜索时间
    layui.use('laydate', function() {
        var laydate = layui.laydate;

        //注册时间
        laydate.render({
            elem: '#test1'
            ,done:function(value,date,startDate){
                sTime = value;
            }
        });

        //至
        laydate.render({
            elem: '#test1-1'
            ,done:function(value,date,endDate){
                eTime = value;
            }
        });
    });
</script>

</body>
</html>
