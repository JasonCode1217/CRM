layui.use(['table','layer'],function() {
    var layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        table = layui.table;
    //加载数据表格
    var tableIns = table.render({
        //table的id
        elem: '#saleChanceList'
        , height: 'full-125'
        , cellMinWidth: 95 //单元格最小宽度
        , url: ctx + '/sale_chance/list' //访问数据的url-->controller层的相关方法
        , toolbar: '#toolbarDemo' //开启头部工具栏
        , page: true //开启分页
        , limit: 10  //默认每页显示10条
        , limits: [10, 20, 30, 40, 50]  //可选择每页显示的记录条数
        , cols: [[ //表头
            {type: 'checkbox', fixed: 'center'}
            , {field: 'id', title: '编号', sort: true, fixed: 'left'}
            , {field: 'chanceSource', title: '机会来源', align: 'center'}
            , {field: 'customerName', title: '客户名称', align: 'center'}
            , {field: 'cgjl', title: '成功几率', align: 'center'}
            , {field: 'overview', title: '概要', align: 'center'}
            , {field: 'linkMan', title: '联系人', align: 'center'}
            , {field: 'linkPhone', title: '电话', align: 'center'}
            , {field: 'description', title: '描述', align: 'center'}
            , {field: 'createMan', title: '创建人', align: 'center'}
            , {field: 'uname', title: '分配人', align: 'center'}
            , {field: 'assignTime', title: '分配时间', align: 'center'}
            , {
                field: 'state', title: '分配状态', align: 'center', templet: function (d) {
                    return stateInfo(d.state);
                }
            }
            , {
                field: 'devResult', title: '开发结果', align: 'center', templet: function (d) {
                    return resultInfo(d.devResult);
                }
            }
            , {
                field: 'isValid', title: '有效状态', align: 'center', templet: function (d) {
                    return validInfo(d.isValid);
                }
            }
            , {field: 'createDate', title: '创建时间', align: 'center'}
            , {field: 'updateDate', title: '更新时间', align: 'center'}
            , {title: '操作', templet: '#saleChanceListBar', fixed: 'right', align: 'center', minWidth: 150}
        ]]
    });

    function stateInfo(state) {
        if (state == 0)
            return '<div style="color: red">未分配</div>';
        else
            return '<div style="color: green">已分配</div>';
    }

    function resultInfo(devResult) {
        if (devResult == 0)
            return '<div style="color: red">未开发</div>'
        else if (devResult == 1)
            return '<div style="color: yellow">开发中</div>'
        else if (devResult == 2)
            return '<div style="color: green">开发成功</div>'
        else
            return '<div style="color: red">开发失败</div>'
    }

    function validInfo(devResult) {
        if (devResult == 0)
            return '<div style="color: red">已失效</div>'
        else
            return '<div style="color: green">有 效</div>'
    }

    //给搜索按钮添加点击事件
    $(".search_btn").click(function () {
        //表格重载
        tableIns.reload({
            //设置需要传递给后端的参数
            where: { //设定异步数据接口的额外参数，任意设
                customerName: $("[name='customerName']").val()
                , createMan: $("[name='createMan']").val()
                , state: $("[name='state']").val()
                //…
            }
            , page: {
                curr: 1 //重新从第 1 页开始
            }
        });
    })

    //头部工具栏事件监听
    table.on('toolbar(saleChances)', function (data) {
        if (data.event == "add") {
            //添加操作
            openDialog();
        } else if (data.event == "del") {
            //删除操作
            deleteSaleChances(data);
        }
    });
    //行工具栏事件监听
    table.on('tool(saleChances)', function (data) {
        if (data.event == "edit") {
            var saleChanceId = data.data.id;
            openDialog(saleChanceId);
        } else {
            //弹出对话框
            layer.confirm('确定要删除该条记录吗？', {icon: 3, title: "营销机会管理"}, function (index) {
                //关闭确认框
                layer.close(index);
                //发送ajax请求
                $.ajax({
                    type: "post",
                    url: ctx + "/sale_chance/delete",
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
     * @param saleChanceId
     */
    function openDialog(saleChanceId) {
        var url = ctx + "/sale_chance/dialog"
        var title = '<h2>营销机会管理--营销机会添加</h2>';
        if (saleChanceId != null && saleChanceId != '') {
            title = '<h2>营销机会管理--营销机会修改</h2>';
            //传递id参数值
            url += "?saleChanceId=" + saleChanceId;
        }

        //iframe 层
        layui.layer.open({
            type: 2,
            title: title,
            maxmin: true, //开启最大化最小化按钮
            area: ['500px', '620px'],
            content: url
        });
    }

    /**
     * 删除function
     * @param data
     */
    function deleteSaleChances(data) {
        //获取数据表格中的行数据
        var checkStatus = table.checkStatus("saleChanceList");//括号里是数据表格id值
        //获取选中记录的数据
        var checkStatusData = checkStatus.data;
        if (checkStatusData.length < 1) {
            layer.msg("未选中任何记录！", {icon: 5});
            return;
        }
        //询问用户是否要删除
        layer.confirm("确定要删除吗？", {icon: 3, title: "营销机会管理"}, function (index) {
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
            console.log(ids);
            //发送ajax请求
            $.ajax({
                type: "post",
                url: ctx + "/sale_chance/delete",
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
})


