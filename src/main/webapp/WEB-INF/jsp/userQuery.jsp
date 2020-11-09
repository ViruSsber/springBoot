<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/10/13
  Time: 20:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
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
<div class="layui-form"  id="infoDiv" style="display: none">
    <table class="layui-table" id="testTable">
        <colgroup>
            <col width="100">
            <col>
        </colgroup>
        <tbody>
        <tr>
            <td>姓名</td>
            <td id="sName"></td>
        </tr>
        <tr>
            <td>注册时间</td>
            <td id="sTime"></td>
        </tr>
        <tr>
            <td>性别</td>
            <td id="sSex"></td>
        </tr>
        <tr>
            <td>学历</td>
            <td id="sEducation"></td>
        </tr>
        <tr>
            <td>职业</td>
            <td id="sProfession"></td>
        </tr>
        <tr>
            <td>联系方式</td>
            <td id="sPhone"></td>
        </tr>
        <tr>
            <td>email</td>
            <td id="sEmail"></td>
        </tr>
        <tr>
            <td>状态</td>
            <td id="sState"></td>
        </tr>
        </tbody>
    </table>
</div>
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
    <label class="layui-form-label">用户名：</label>

    <div class="layui-inline">
        <input class="layui-input" name="uName" id="demoReload" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload" style="margin-left: 165px">搜索</button>
</div>
<table id="demo" lay-filter="test"></table>

<script src="${pageContext.request.contextPath}/layui/layui.js"></script>

<table class="layui-hide" id="test" lay-filter="test"></table>


</table>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <!-- 这里同样支持 laytpl 语法，如： -->
<%--    {{#  if(d.auth > 2){ }}--%>
<%--    <a class="layui-btn layui-btn-xs" lay-event="check">审核</a>--%>
<%--    {{#  } }}--%>
</script>
<script>
    var sTime,eTime;
    layui.use('table', function(){
        var table = layui.table;

        //渲染表格
        var tableIns = table.render({
            elem: '#demo'
            // ,height: 1500
            ,width:1140
            ,url: 'userQuery' //数据接口
            // ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,page: true //开启分页
            // ,contentType : "application/json;charset=utf-8"
            ,cols: [[ //表头
                {field: 'uId', title: 'ID', width:80, sort: true, fixed: 'left'}
                ,{field: 'uName', title: '用户名', width:80}
                ,{field: 'regTime', title: '注册时间', width:160, sort: true}
                ,{field: 'integral', title: '积分', width:80}
                ,{field: 'upLoads', title: '上传文档书', width: 177}
                ,{field: 'downloadTimes', title: '下载文档数', width: 177, sort: true}
                ,{field: 'pName', title: '用户状态', width: 160, sort: true}
                ,{fixed: 'right', title:'操作', width:200, align:'center', toolbar: '#barDemo'}
            ]]
            ,id: 'testReload'
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            console.log(data);
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    $.ajax({
                        url:'../delUserServlet',
                        type: 'post',
                        dataType: 'json',
                        data:{"uId":data.uId},
                        // contentType:'application/json;charset=utf-8',
                        success:function (mes) {
                            // var jsonData = JSON.parse(data);
                            console.log(mes.msg);
                            if (mes.msg == '删除成功'){
                                obj.del();
                                layer.close(index);
                            }else{
                                layer.alert(mes.msg);
                            }
                        },
                        error:function () {
                            layer.config('操作异常',function (index) {
                                layer.close(index);
                            });
                        }
                    })
                });
            } else if(obj.event === 'edit'){
                layer.prompt({
                    formType: 2
                    ,value: data.uName
                }, function(value, index){
                    obj.update({
                        email: value
                    });
                    layer.close(index);
                });
            }else if(obj.event === 'detail'){
                layui.use('layer',function () {
                    var layer = layui.layer;

                    $("#sName").html(data.uName);
                    $("#sTime").html(data.regTime);
                    $("#sState").html(data.pName);
                    layer.open({
                        type:1
                        ,content:$('#infoDiv')
                        ,btn:'返回'
                    });
                });
            }
        });

        var $ = layui.$, active = {
            reload: function(){
                var uName = $('#demoReload');
                //执行重载
                table.reload('testReload', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        uName: uName.val()
                        ,startTime:sTime
                        ,endTime:eTime
                    }
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
