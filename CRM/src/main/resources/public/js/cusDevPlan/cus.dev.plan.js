layui.use(['table','layer'],function(){
    var layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        table = layui.table;

    //加载数据表格
    var tableIns = table.render({
        //table的id
        id:'saleChanceTable'
        ,elem: '#saleChanceList'
        , height: 'full-125'
        , cellMinWidth: 95 //单元格最小宽度
        , url: ctx + '/sale_chance/list?flag=1' //flag=1表明是客户开发计划查询
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
            , {field: 'createDate', title: '创建时间', align: 'center'}
            , {field: 'updateDate', title: '更新时间', align: 'center'}
            , {
                field: 'devResult', title: '开发结果', align: 'center', templet: function (d) {
                    return resultInfo(d.devResult);
                }
            }
            , {title: '操作', templet: '#op', fixed: 'right', align: 'center', minWidth: 150}
        ]]
    });


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

    //给搜索按钮添加点击事件
    $(".search_btn").click(function () {
        //表格重载
        tableIns.reload({
            //设置需要传递给后端的参数
            where: { //设定异步数据接口的额外参数，任意设
                customerName: $("[name='customerName']").val()
                , createMan: $("[name='createMan']").val()
                , devResult: $("[name='devResult']").val()
                //…
            }
            , page: {
                curr: 1 //重新从第 1 页开始
            }
        });
    })

    //添加行工具栏监听
    table.on('tool(saleChances)',function (data) {
        if(data.event == "dev"){
            //开发
            openDialog("计划项数据开发",data.data.id);
        }
        else if(data.event == "info"){
            //详情
            openDialog("计划项数据维护",data.data.id);
        }
    })
    function openDialog(title,id) {
        //iframe 层
        layui.layer.open({
            type: 2,
            title: title,
            maxmin: true, //开启最大化最小化按钮
            area: ['750px', '550px'],
            content: ctx+"/cus_dev_plan/dialog?id="+id
        });
    }
});
