layui.use(['form','jquery','jquery_cookie'], function () {
    var form = layui.form,
        layer = layui.layer,
        $ = layui.jquery,
        $ = layui.jquery_cookie($);

    form.on('submit(login)', function(data){
        console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
        //LayUI现成代码已经做了非空判断所以这里不用写
        //发送ajax请求，传递用户名和密码
        $.ajax({
            type:"post",
            url:ctx+"/user/login", //这个请求地址是对应到后端controller的相关地址
            data:{
                userName:data.field.username,
                userPwd:data.field.password
            },
            success:function (result) {
                if(result.code == 200){
                    layer.msg("登录成功！正在跳转...",function () {
                        //判断是否勾选了记住我
                        if($("#rememberMe").prop("checked")){
                            $.cookie("userSid",result.result.userSid,{expires:7});
                            $.cookie("userName",result.result.userName,{expires:7});
                            $.cookie("trueName",result.result.trueName,{expires:7});
                        }
                        else {
                            $.cookie("userSid",result.result.userSid);
                            $.cookie("userName",result.result.userName);
                            $.cookie("trueName",result.result.trueName);
                        }
                        //跳转到首页
                        window.location.href = ctx+"/main";
                    })
                }
                else {
                    layer.msg(result.msg,{icon:5});
                }
            }
        })
        return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
    });
});