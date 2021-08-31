layui.use(['table','layer'],function(){
       var layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        table = layui.table;


       //加载数据表格
       var tableIns = table.render({
              //table的id
              id:'roleTable'
              ,elem: '#roleList'
              , height: 'full-125'
              , cellMinWidth: 95 //单元格最小宽度
              , url: ctx + '/role/list' //访问数据的url-->controller层的相关方法
              , toolbar: '#toolbarDemo' //开启头部工具栏
              , page: true //开启分页
              , limit: 10  //默认每页显示10条
              , limits: [10, 20, 30, 40, 50]  //可选择每页显示的记录条数
              , cols: [[ //表头
                     {type: 'checkbox', fixed: 'center'}
                     , {field: 'id', title: '编号', sort: true, fixed: 'left'}
                     , {field: 'roleName', title: '角色名称', align: 'center'}
                     , {field: 'roleRemark', title: '角色备注', align: 'center'}
                     , {field: 'updateDate', title: '更新时间', align: 'center'}
                     , {title: '操作', templet: '#roleListBar', fixed: 'right', align: 'center', minWidth: 150}
              ]]
       });

       //给搜索按钮添加点击事件
       $(".search_btn").click(function () {
              //表格重载
              tableIns.reload({
                     //设置需要传递给后端的参数
                     where: { //设定异步数据接口的额外参数，任意设
                            roleName: $("[name='roleName']").val()
                     }
                     , page: {
                            curr: 1 //重新从第 1 页开始
                     }
              });
       })

       //头部工具栏事件监听
       table.on('toolbar(roles)', function (data) {
              if (data.event == "add") {
                     //添加操作
                     openUpdateDialog();
              } else if (data.event == "grant") {
                     //授权操作
                     openGrantDialog(data);
              }
       });

       /**
        * 打开添加/更新窗口
        * @param roleId
        */
       function openUpdateDialog(roleId) {
              var url = ctx + "/role/toAddUpdatePage"
              var title = '<h2>角色管理--角色添加</h2>';
              if (roleId != null && roleId != '') {
                     title = '<h2>角色管理--角色修改</h2>';
                     //传递id参数值
                     url += "?roleId=" + roleId;
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
       function openGrantDialog(data){
              //获取数据表格中的行数据
              var checkStatus = table.checkStatus("roleTable");//括号里是数据表格id值
              //获取选中记录的数据
              var checkStatusData = checkStatus.data;
              if (checkStatusData.length < 1) {
                     layer.msg("请选择要授权的角色！", {icon: 5});
                     return;
              }
              //只支持单个授权
              if (checkStatusData.length > 1) {
                     layer.msg("暂不支持多个角色授权！", {icon: 5});
                     return;
              }
              console.log(checkStatusData[0].id);
              var url = ctx +"/module/toGrantPage?roleId=" + checkStatusData[0].id;
              var title = "<h3>角色管理--角色授权</h3>"
              //iframe 层
              layui.layer.open({
                     type: 2,
                     title: title,
                     maxmin: true, //开启最大化最小化按钮
                     area: ['600px', '350px'],
                     content: url
              });
       }

       //行工具栏事件监听
       table.on('tool(roles)', function (data) {
              var roleId = data.data.id;
              if (data.event == "edit") {
                     openUpdateDialog(roleId);
              } else {
                     //弹出对话框
                     layer.confirm('确定要删除该条记录吗？', {icon: 3, title: "角色管理"}, function (index) {
                            //关闭确认框
                            layer.close(index);
                            //发送ajax请求
                            $.ajax({
                                   type: "post",
                                   url: ctx + "/role/delete?roleId="+roleId,
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
});
