layui.use(['table','layer'],function(){
    var layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        table = layui.table;

    //加载数据表格
    var tableIns = table.render({
        //table的id
        id:'cusDevPlanTable'
        ,elem: '#cusDevPlanList'
        , height: 'full-125'
        , cellMinWidth: 95 //单元格最小宽度
        , url: ctx + '/cus_dev_plan/list?saleChanceId='+$("[name='id']").val()
        , toolbar: '#toolbarDemo' //开启头部工具栏
        , page: true //开启分页
        , limit: 10  //默认每页显示10条
        , limits: [10, 20, 30, 40, 50]  //可选择每页显示的记录条数
        , cols: [[ //表头
            {type: 'checkbox', fixed: 'center'}
            , {field: 'id', title: '编号', sort: true, fixed: 'left'}
            , {field: 'planItem', title: '计划内容', align: 'center'}
            , {field: 'planDate', title: '计划时间', align: 'center'}
            , {field: 'exeAffect', title: '执行效果', align: 'center'}
            , {field: 'createDate', title: '创建时间', align: 'center'}
            , {field: 'updateDate', title: '更新时间', align: 'center'}
            , {title: '操作', templet: '#cusDevPlanListBar', fixed: 'right', align: 'center', minWidth: 150}
        ]]
    });

    //头部工具栏事件监听
    table.on('toolbar(cusDevPlans)',function (data) {
        if(data.event == "add"){
            //添加
            openDialog()
        }
        else if(data.event == "success"){
            //开发成功
            setDev(data,1);
        }
        else if(data.event == "failed"){
            //开发失败
            setDev(data,0);
        }
    })

    //行工具栏事件监听
    table.on('tool(cusDevPlans)', function (data) {
        var id = data.data.id;
        if (data.event == "edit") {
            openDialog(id);
        } else {
            //弹出对话框
            layer.confirm('确定要删除该条记录吗？', {icon: 3, title: "计划项管理"}, function (index) {
                //关闭确认框
                layer.close(index);
                //发送ajax请求
                $.ajax({
                    type: "post",
                    url: ctx + "/cus_dev_plan/delete?id=" + id,
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
     * 打开编辑窗口
     * @param id
     */
    function openDialog(id) {
        var url = ctx +"/cus_dev_plan/toAddUpdatePage?sId="+$("[name='id']").val()//获取当前开发计划中的营销机会id，通过控制层接收并设置到请求域中;
        var title = '<h2>计划项管理--计划项添加</h2>';
        if (id != null && id != '') {
            title = '<h2>计划项管理--计划项修改</h2>';
            //传递id参数值
            url += "&id=" + id;
        }
        //iframe 层
        layui.layer.open({
            type: 2,
            title: title,
            maxmin: true, //开启最大化最小化按钮
            area: ['500px', '300px'],
            content: url
        });
    }

    /**
     * 设置开发状态
     */
    function setDev(data,flag) {
        var id = $("[name='id']").val();
        if(flag == 1){
            var title = "是否设置为开发成功？";
            var url =  ctx + "/sale_chance/setDevSuccess?id="+ id;
        }
        else if(flag == 0){
            var title = "是否设置为开发失败？";
            var url =  ctx + "/sale_chance/setDevFailed?id="+ id;
        }
        //询问用户是否要设置
        layer.confirm(title, {icon: 3, title: "计划项管理"}, function (index) {
            //关闭确认框
            layer.close(index);
            //发送ajax请求
            $.ajax({
                type: "post",
                url: url,
                success: function (result) {
                    if (result.code == 200) {
                        layer.msg("设置成功！", {icon: 6});
                        parent.location.reload();
                    } else {
                        layer.msg(result.msg, {icon: 5})
                    }
                }
            })
        })
    }


});
