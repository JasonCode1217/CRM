package com.xxxx.crm.dao;

import com.xxxx.crm.base.BaseMapper;
import com.xxxx.crm.query.RoleQuery;
import com.xxxx.crm.vo.Role;

import java.util.List;
import java.util.Map;

public interface RoleMapper extends BaseMapper<Role,Integer> {
    //查询所有角色名
    List<Map<String,Object>> queryAllRoles(Integer userId);
    //通过角色名查询角色记录
    Role selectByRoleName(String roleName);
    //删除角色
    Integer deleteRoleById(Integer id);
}