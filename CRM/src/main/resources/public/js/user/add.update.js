layui.use(['form', 'layer','formSelects'], function () {
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery;
        // 引入 formSelects 模块
        formSelects = layui.formSelects;

    /**
     * 加载下拉框数据
     */
    var userId = $("[name='id']").val();
    formSelects.config('selectId',{
        type:"post",
        searchUrl:ctx + "/role/queryAllRoles?userId="+userId,
        //自定义返回数据中name的key, 默认 name
        keyName: 'roleName',
        //自定义返回数据中value的key, 默认 value
        keyVal: 'id'
    },true);


    //取消按钮 关闭当前弹出层
    $("#cancle").click(function () {
        //当你在iframe页面关闭自身时
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    })

    //提交表单
    form.on('submit(addOrUpdateUser)', function(data) {
        // 提交数据时的加载层
        var load = layer.msg("数据提交中,请稍后...",{
            icon:16, // 图标
            time:false, // 不关闭
            shade:0.8 // 设置遮罩的透明度
        });
        //发送ajax请求
        var url = ctx +"/user/add";

        //获取隐藏域中的id，并判断是否存在，若存在则是修改操作，反之为添加操作
        var id = $("[name='id']").val();
        if(id != null && id != ''){
            url = ctx +"/user/update";
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
});