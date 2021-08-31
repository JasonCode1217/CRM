layui.use(['form','jquery','jquery_cookie'], function () {
    var form = layui.form,
        layer = layui.layer,
        $ = layui.jquery,
        $ = layui.jquery_cookie($);

    form.on('submit(saveBtn)',function (data) {
        //发送ajax请求
        $.ajax({
            type:"post",
            url:ctx +"/user/updatePassword",
            data:{
                oldPwd:data.field.old_password,
                newPwd:data.field.new_password,
                repeatPwd:data.field.again_password
            },
            success:function (result) {
                if(result.code == 200){
                    layer.msg("修改成功！请重新登录...",function () {
                        //清空cookie
                        $.removeCookie("userSid",{domain:"localhost",path:"/crm"});
                        $.removeCookie("userName",{domain:"localhost",path:"/crm"});
                        $.removeCookie("trueName",{domain:"localhost",path:"/crm"});
                        //跳转到登录界面
                        window.parent.location.href = ctx+"/index";
                    })
                }
                else {
                    layer.msg(result.msg,{icon:5});
                }
            }
        });
    });
});