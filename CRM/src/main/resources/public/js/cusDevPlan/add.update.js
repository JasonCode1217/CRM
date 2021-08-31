layui.use(['form', 'layer'], function () {
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery;

    //提交表单
    form.on('submit(addOrUpdateCusDevPlan)', function(data) {
        // 提交数据时的加载层
        var load = top.layer.msg("数据提交中,请稍后...",{
            icon:16, // 图标
            time:false, // 不关闭
            shade:0.8 // 设置遮罩的透明度
        });

        //发送ajax请求
        var url = ctx +"/cus_dev_plan/add";

        //获取隐藏域中的id，并判断是否存在，若存在则是修改操作，反之为添加操作
        var id = $("[name='id']").val();
        if(id != null && id != ''){
            url = ctx +"/cus_dev_plan/update";
        }
        $.post(url,data.field,function (result) {
            //判断添加操作是否执行成功 coda==200为成功
            if(result.code == 200){
                top.layer.msg("添加成功！",{icon:6})
                //关闭加载层
                top.layer.close(load);
                //关闭弹出层
                layer.closeAll();
                //刷新父窗口，重新加载数据
                parent.location.reload();
            }
            else{
                //添加失败
                top.layer.msg(result.msg,{icon:5});
            }
        })
        return false;

    })

    //取消按钮 关闭当前弹出层
    $("#closeBtn").click(function () {
        //当你在iframe页面关闭自身时
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    })

});