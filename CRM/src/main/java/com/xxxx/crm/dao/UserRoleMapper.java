package com.xxxx.crm.dao;

import com.xxxx.crm.base.BaseMapper;
import com.xxxx.crm.vo.UserRole;

public interface UserRoleMapper extends BaseMapper<UserRole,Integer> {
    //通过用户id查询角色记录条数
    Integer countUserRoleByUserId(Integer userId);
    //删除角色记录，返回删除条数
    Integer deleteUserRoleByUserId(Integer userId);
}