$(function () {
    //加载资源树形结构
    loadModuleData();
})
//定义树形结构对象
var zTreeObj;

function loadModuleData() {
    //zTree参数配置
    var setting = {
        check:{//使用复选框
            enable:true
        },
        data:{//使用简单JSON数据
            simpleData: {
                enable:true
            }
        },
        //绑定函数
        callback:{
            onCheck:zTreeOnCheck
        }
    }
    //通过ajax查询资源列表
    $.ajax({
        type:"get",
        //通过角色id查询所拥有的资源
        url:ctx + "/module/queryAllModules?roleId="+$("[name='roleId']").val(),
        dataType:"json",
        success:function (data) {//data是查询结果即资源列表
            //加载zTree插件
            zTreeObj = $.fn.zTree.init($("#test1"),setting,data);
        }
    })
}

function zTreeOnCheck(event, treeId, treeNode) {
    var nodes= zTreeObj.getCheckedNodes(true);
    var roleId=$("[name='roleId']").val();
    console.log(roleId);
    var mIds="mIds=";
    for(var i=0;i<nodes.length;i++){
        if(i < nodes.length-1){
            mIds=mIds+nodes[i].id+"&mIds=";
        }else{
            mIds=mIds+nodes[i].id;
        }
    }
    console.log(mIds)
    $.ajax({
        type:"post",
        url:ctx + "/role/addGrant",
        data:mIds+"&roleId="+roleId,
        dataType:"json",
        success:function (data) {
            console.log(data);
        }
    })
    console.log(mIds)
}