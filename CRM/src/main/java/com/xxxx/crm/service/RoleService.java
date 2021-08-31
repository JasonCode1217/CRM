package com.xxxx.crm.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xxxx.crm.base.BaseService;
import com.xxxx.crm.dao.ModuleMapper;
import com.xxxx.crm.dao.PermissionMapper;
import com.xxxx.crm.dao.RoleMapper;
import com.xxxx.crm.query.RoleQuery;
import com.xxxx.crm.utils.AssertUtil;
import com.xxxx.crm.vo.Module;
import com.xxxx.crm.vo.Permission;
import com.xxxx.crm.vo.Role;
import com.xxxx.crm.vo.SaleChance;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;

@Service
public class RoleService extends BaseService<Role,Integer> {
    @Resource
    private RoleMapper roleMapper;

    @Resource
    private PermissionMapper permissionMapper;

    @Resource
    private ModuleMapper moduleMapper;

    /**
     * 查询所有角色
     * @return
     */
    public List<Map<String,Object>> queryAllRoles(Integer userId){
        return roleMapper.queryAllRoles(userId);
    }

    /**
     * 通过角色名查询记录
     * @param roleQuery
     * @return
     */
    public Map<String,Object> queryByRoleName(RoleQuery roleQuery){
        Map<String,Object> map = new HashMap<>();
        //开启分页
        PageHelper.startPage(roleQuery.getPage(),roleQuery.getLimit());
        //得到对应分页对象
        PageInfo<Role> pageInfo = new PageInfo<>(roleMapper.selectByParams(roleQuery));
        //设置map对象
        map.put("code",0);
        map.put("msg","success");
        map.put("count",pageInfo.getTotal());
        //添加数据
        map.put("data",pageInfo.getList());
        return map;
    }

    /**
     * 添加角色
     * 1.参数非空校验
     *      角色名
     * 2.设置默认值
     *      创建时间
     *      更新时间
     *      有效状态
     * 3.执行操作
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void addRole(Role role){
        //1. 参数非空和唯一性校验
        checkRoleName(role.getRoleName(),null);
        //2. 设置默认值
        role.setCreateDate(new Date());
        role.setUpdateDate(new Date());
        role.setIsValid(1);
        //3. 执行操作
        AssertUtil.isTrue(roleMapper.insertSelective(role) != 1,"添加失败！");
    }

    /**
     * 更新角色
     * @param role
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateRole(Role role){
        //1. 参数非空和唯一性校验
        AssertUtil.isTrue(role.getId() == null,"待更新记录不存在！");
        Role temp = roleMapper.selectByPrimaryKey(role.getId());
        AssertUtil.isTrue(temp == null,"待更新记录不存在！");
        checkRoleName(role.getRoleName(),temp.getId());
        //2. 设置默认值
        role.setUpdateDate(new Date());
        //3. 执行操作
        AssertUtil.isTrue(roleMapper.updateByPrimaryKeySelective(role) !=1,"更新失败！");
    }

    /**
     * 删除角色
     * @param id
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteRole(Integer id){
        AssertUtil.isTrue(roleMapper.deleteRoleById(id) != 1,"删除失败！");
    }

    /**
     * 角色名非空及唯一性校验
     * @param roleName
     * @param id
     */
    private void checkRoleName(String roleName, Integer id) {
        AssertUtil.isTrue(StringUtils.isBlank(roleName),"角色名不能为空！");
        Role temp = roleMapper.selectByRoleName(roleName);
        AssertUtil.isTrue(temp != null && !(temp.getId().equals(id)),"角色名称已存在！请重新输入！");
    }

    /**
     * 为角色授权
     * @param mIds
     * @param roleId
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void addGrant(Integer[] mIds,Integer roleId){
        //1. 通过角色id查询对应的权限记录
        Integer count = permissionMapper.countPermissionByRoleId(roleId);
        //2. 如果记录存在，则删除
        if(count > 0){
            permissionMapper.deletePermissionByRoleId(roleId);
        }
        //3. 如果有权限记录，则执行添加（批量）
        if(mIds != null && mIds.length>0){
            List<Permission> permissionList = new ArrayList<>();
            //遍历mId数组
            for (Integer mId : mIds) {
                Permission permission = new Permission();
                permission.setModuleId(mId);
                permission.setRoleId(roleId);
                permission.setAclValue(moduleMapper.selectByPrimaryKey(mId).getOptValue());
                permission.setCreateDate(new Date());
                permission.setUpdateDate(new Date());
                permissionList.add(permission);
            }
            AssertUtil.isTrue(permissionMapper.insertBatch(permissionList) != permissionList.size(),"授权失败！");
        }
    }
}
