layui.use(['table', 'treetable'], function () {
    var $ = layui.jquery;
    var table = layui.table;
    var treeTable = layui.treetable;

    // 渲染表格
    treeTable.render({
        treeColIndex: 1,
        treeSpid: -1,
        treeIdName: 'id',
        treePidName: 'parentId',
        elem: '#munu-table',
        url: ctx+'/module/list',
        toolbar: "#toolbarDemo",
        treeDefaultClose:true,
        page: true,
        cols: [[
            {type: 'numbers'},
            {field: 'moduleName', minWidth: 100, title: '菜单名称'},
            {field: 'optValue', title: '权限码'},
            {field: 'url', title: '菜单url'},
            {field: 'createDate', title: '创建时间'},
            {field: 'updateDate', title: '更新时间'},
            {
                field: 'grade', width: 80, align: 'center', templet: function (d) {
                    if (d.grade == 0) {
                        return '<span class="layui-badge layui-bg-blue">目录</span>';
                    }
                    if(d.grade==1){
                        return '<span class="layui-badge-rim">菜单</span>';
                    }
                    if (d.grade == 2) {
                        return '<span class="layui-badge layui-bg-gray">按钮</span>';
                    }
                }, title: '类型'
            },
            {templet: '#auth-state', width: 180, align: 'center', title: '操作'}
        ]],
        done: function () {
            layer.closeAll('loading');
        }
    });

    /**
     * 头部工具栏
     */
    table.on('toolbar(munu-table)',function (data) {
        if(data.event == "expand"){
            //全部展开
            treeTable.expandAll("#munu-table");
        }
        else if(data.event == "fold"){
            //全部折叠
            treeTable.foldAll("#munu-table");
        }
        else if(data.event == "add"){
            //添加--0层级，-1父菜单
            openAddModuleDialog(0,-1);
        }
    })

    /**
     * 行工具栏
     */
    table.on('tool(munu-table)',function (data) {
        if(data.event == "add"){
            //添加子项，判断当前层级，若是三级菜单，则没有添加操作
            if(data.data.grade == 2){
                layer.msg("当前项不能继续添加！");
                return;
            }
            //一级|二级菜单，grade=当前层级+1，parentId=当前资源的id
            openAddModuleDialog(data.data.grade+1,data.data.id);
        }
        else if(data.event == "edit"){
            //更新
            openUpdateModuleDialog(data.data.id);
        }
        else if(data.event == "del"){
            //删除
            deleteModule(data.data.id);
        }
    })

    /**
     * 打开添加对话框
     * @param data
     */
    function openAddModuleDialog(grade,parentId) {
        var url = ctx + "/module/addDialog?grade=" + grade +"&parentId=" + parentId;
        var title = '<h2>菜单管理--添加菜单</h2>';
        // if (userId != null && userId != '') {
        //     title = '<h2>资源管理--更新资源</h2>';
        //     //传递id参数值
        //     url += "?userId=" + userId;
        // }

        //iframe 层
        layui.layer.open({
            type: 2,
            title: title,
            maxmin: true, //开启最大化最小化按钮
            area: ['700px', '450px'],
            content: url
        });

    }

    /**
     * 打开更新对话框
     */
    function openUpdateModuleDialog(id) {
        var url = ctx + "/module/updateDialog?id=" + id;
        var title = '<h2>菜单管理--更新菜单</h2>';
        //iframe 层
        layui.layer.open({
            type: 2,
            title: title,
            maxmin: true, //开启最大化最小化按钮
            area: ['700px', '450px'],
            content: url
        });
    }

    /**
     * 删除操作
     * @param id
     */
    function deleteModule(id) {
        //弹出对话框
        layer.confirm('确定要删除该条记录吗？', {icon: 3, title: "菜单管理"}, function (index) {
            //关闭确认框
            layer.close(index);
            //发送ajax请求
            $.ajax({
                type: "post",
                url: ctx + "/module/delete",
                data: {
                    id: id
                },
                success: function (result) {
                    if (result.code == 200) {
                        layer.msg("删除成功！", {icon: 6});
                        window.location.reload();
                    } else {
                        layer.msg(result.msg, {icon: 5})
                    }
                }
            })
        })
    }
});