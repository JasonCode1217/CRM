layui.use(['table','layer'],function(){
    var layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        table = layui.table;
    //加载数据表格
    var tableIns = table.render({
        //table的id
        id:'userTable'
        ,elem: '#userList'
        , height: 'full-125'
        , cellMinWidth: 95 //单元格最小宽度
        , url: ctx + '/user/list' //访问数据的url-->controller层的相关方法
        , toolbar: '#toolbarDemo' //开启头部工具栏
        , page: true //开启分页
        , limit: 10  //默认每页显示10条
        , limits: [10, 20, 30, 40, 50]  //可选择每页显示的记录条数
        , cols: [[ //表头
            {type: 'checkbox', fixed: 'center'}
            , {field: 'id', title: '编号', sort: true, fixed: 'left'}
            , {field: 'userName', title: '用户名', align: 'center'}
            , {field: 'email', title: '用户邮箱', align: 'center'}
            , {field: 'trueName', title: '真实姓名', align: 'center'}
            , {field: 'createDate', title: '创建时间', align: 'center'}
            , {field: 'updateDate', title: '更新时间', align: 'center'}
            , {title: '操作', templet: '#userListBar', fixed: 'right', align: 'center', minWidth: 150}
        ]]
    });

    //给搜索按钮添加点击事件
    $(".search_btn").click(function () {
        //表格重载
        tableIns.reload({
            //设置需要传递给后端的参数
            where: { //设定异步数据接口的额外参数，任意设
                userName: $("[name='userName']").val()
                , email: $("[name='email']").val()
                , phone: $("[name='phone']").val()
                //…
            }
            , page: {
                curr: 1 //重新从第 1 页开始
            }
        });
    })

    //头部工具栏事件监听
    table.on('toolbar(users)', function (data) {
        if (data.event == "add") {
            //添加操作
            openUpdateDialog();
        } else if (data.event == "del") {
            //删除操作
            deleteUser(data);
        }
    });

    //行工具栏事件监听
    table.on('tool(users)', function (data) {
        if (data.event == "edit") {
            var userId = data.data.id;
            openUpdateDialog(userId);
        } else {
            //弹出对话框
            layer.confirm('确定要删除该条记录吗？', {icon: 3, title: "用户信息管理"}, function (index) {
                //关闭确认框
                layer.close(index);
                //发送ajax请求
                $.ajax({
                    type: "post",
                    url: ctx + "/user/delete",
                    data: {
                        ids: data.data.id
                    },
                    success: function (result) {
                        if (result.code == 200) {
                            layer.msg("删除成功！", {icon: 6});
                            tableIns.reload();
                        } else {
                            layer.msg(result.msg, {icon: 5})
                        }
                    }
                })
            })
        }
    })

    /**
     * 打开对话框function
     * @param userId
     */
    function openUpdateDialog(userId) {
        var url = ctx + "/user/dialog"
        var title = '<h2>用户信息管理--添加用户</h2>';
        if (userId != null && userId != '') {
            title = '<h2>用户信息管理--编辑用户</h2>';
            //传递id参数值
            url += "?userId=" + userId;
        }

        //iframe 层
        layui.layer.open({
            type: 2,
            title: title,
            maxmin: true, //开启最大化最小化按钮
            area: ['650px', '400px'],
            content: url
        });
    }

    /**
     * 删除function
     * @param data
     */
    function deleteUser(data) {
        //获取数据表格中的行数据
        var checkStatus = table.checkStatus("userTable");//括号里是数据表格id值
        //获取选中记录的数据
        var checkStatusData = checkStatus.data;
        if (checkStatusData.length < 1) {
            layer.msg("未选中任何记录！", {icon: 5});
            return;
        }
        //询问用户是否要删除
        layer.confirm("确定要删除吗？", {icon: 3, title: "用户信息管理"}, function (index) {
            //关闭确认框
            layer.close(index);
            var ids = "ids=";
            for (var i = 0; i < checkStatusData.length; i++) {
                if (i < checkStatusData.length - 1) {
                    ids = ids + checkStatusData[i].id + "&ids=";
                } else {
                    ids = ids + checkStatusData[i].id;
                }
            }
            //发送ajax请求
            $.ajax({
                type: "post",
                url: ctx + "/user/delete",
                data:ids,
                success: function (result) {
                    if (result.code == 200) {
                        layer.msg("删除成功！", {icon: 6});
                        tableIns.reload();
                    } else {
                        layer.msg(result.msg, {icon: 5})
                    }
                }
            })
        })
    }

});