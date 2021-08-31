layui.use(['form', 'layer'], function () {
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery;

    //提交表单
    form.on('submit(addOrUpdateSaleChance)', function(data) {
        // 提交数据时的加载层
        var load = layer.msg("数据提交中,请稍后...",{
            icon:16, // 图标
            time:false, // 不关闭
            shade:0.8 // 设置遮罩的透明度
        });
        //发送ajax请求
        var url = ctx +"/sale_chance/add";

        //获取隐藏域中的id，并判断是否存在，若存在则是修改操作，反之为添加操作
        var id = $("[name='id']").val();
        if(id != null && id != ''){
            url = ctx +"/sale_chance/update";
        }
        $.post(url,data.field,function (result) {
            //console.log(result);
            //判断添加操作是否执行成功 coda==200为成功
            if(result.code == 200){
                layer.msg(result.msg,{icon:6})
                //关闭加载层
                layer.close(load);
                //关闭弹出层
                layer.closeAll();
                //刷新父窗口，重新加载数据
                parent.location.reload();
            }
            else{
                //添加失败
                layer.msg(result.msg,{icon:5});
            }
        })
        return false;

    })

    //取消按钮 关闭当前弹出层
    $("#cancle").click(function () {
        //当你在iframe页面关闭自身时
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    })

    /**
     * 加载指派人下拉框
     */
    $.ajax({
        type:"get",
        url:ctx+"/user/queryAllSales",
        data:{},
        success:function (data) {
            if(data!=null){
                //获取指派人id（隐藏域）
                var assignManId = $("#assignManId").val();
                for(var i = 0;i<data.length;i++){
                    //设置下拉选项
                    if(assignManId == data[i].id){
                        var opt = "<option value='"+data[i].id+"' selected>"+data[i].user_name+"</option>";
                    }else {
                        var opt = "<option value='"+data[i].id+"'>"+data[i].user_name+"</option>";
                    }
                    $("#assignMan").append(opt);
                }
            }
            //重新渲染加载下拉框
            layui.form.render("select");
        }
    })
    
});