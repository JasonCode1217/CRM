package com.xxxx.crm.dao;

import com.xxxx.crm.base.BaseMapper;
import com.xxxx.crm.vo.Permission;

import java.util.List;

public interface PermissionMapper extends BaseMapper<Permission,Integer> {

    //通过角色id查询拥有的权限条数
    Integer countPermissionByRoleId(Integer roleId);

    //通过角色id删除对应的权限
    void deletePermissionByRoleId(Integer roleId);

    //查询角色所拥有的的资源id集合
    List<Integer> queryRoleHasModuleIds(Integer roleId);

    //通过登录用户id查询其所拥有的资源权限
    List<String> queryUserRoleHasPermission(Integer id);
}