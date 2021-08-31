package com.xxxx.crm.dao;

import com.xxxx.crm.base.BaseMapper;
import com.xxxx.crm.vo.SaleChance;

import java.util.List;
import java.util.Map;

public interface SaleChanceMapper extends BaseMapper<SaleChance,Integer> {
    //设置计划为开发成功
    public Integer setSuccess(Integer id);

    //设置计划为开发失败
    public Integer setFailed(Integer id);
}