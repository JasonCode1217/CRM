package com.xxxx.crm.dao;

import com.xxxx.crm.base.BaseMapper;
import com.xxxx.crm.vo.User;

import java.util.List;
import java.util.Map;

public interface UserMapper extends BaseMapper<User,Integer> {
    public User queryByName(String userName);
    /**
     * 查询所有销售人员
     * @return
     */
    public List<Map<String,Object>> queryAllSales();
    //查询所有的客户经理
    List<Map<String, Object>> queryAllCustomerManagers();
}