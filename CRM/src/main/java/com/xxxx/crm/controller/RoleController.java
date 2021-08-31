package com.xxxx.crm.controller;

import com.xxxx.crm.base.BaseController;
import com.xxxx.crm.base.ResultInfo;
import com.xxxx.crm.enums.StateStatus;
import com.xxxx.crm.query.RoleQuery;
import com.xxxx.crm.service.RoleService;
import com.xxxx.crm.utils.LoginUserUtil;
import com.xxxx.crm.vo.Role;
import com.xxxx.crm.vo.SaleChance;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("role")
public class RoleController extends BaseController {
    @Resource
    private RoleService roleService;

    /**
     * 查询所有角色
     * @return
     */
    @RequestMapping("queryAllRoles")
    @ResponseBody
    public List<Map<String,Object>> queryAllRoles(Integer userId){
        return roleService.queryAllRoles(userId);
    }

    /**
     * 通过角色名查询记录
     * @param roleQuery
     * @return
     */
    @RequestMapping("list")
    @ResponseBody
    public Map<String,Object> queryByRoleName(RoleQuery roleQuery){
        return roleService.queryByRoleName(roleQuery);
    }

    /**
     * 添加角色
     * @param role
     * @return
     */
    @PostMapping("add")
    @ResponseBody
    public ResultInfo addRole(Role role){
        roleService.addRole(role);
        return success("添加成功！");
    }

    /**
     * 更新角色
     * @param role
     * @return
     */
    @PostMapping("update")
    @ResponseBody
    public ResultInfo updateRole(Role role){
        roleService.updateRole(role);
        return success("修改成功！");
    }

    /**
     * 删除角色
     * @param roleId
     * @return
     */
    @PostMapping("delete")
    @ResponseBody
    public ResultInfo deleteRole(Integer roleId){
        roleService.deleteRole(roleId);
        return success("删除成功！");
    }

    //转到角色管理主页面
    @RequestMapping("index")
    public String index(){
        return "role/role";
    }

    //打开添加/更新窗口
    @RequestMapping("toAddUpdatePage")
    public String toAddUpdatePage(HttpServletRequest request,Integer roleId){
        //判断roleId是否存在
        if(roleId != null){
            Role role = roleService.selectByPrimaryKey(roleId);
            //将数据设置到请求域中
            request.setAttribute("role",role);
        }
        return "role/add_update";
    }

    /**
     * 对角色进行授权操作
     * @param mIds
     * @param roleId
     * @return
     */
    @PostMapping("addGrant")
    @ResponseBody
    public ResultInfo addGrant(Integer[] mIds,Integer roleId){
        roleService.addGrant(mIds,roleId);
        return success("角色授权成功！");
    }
}
