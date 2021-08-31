package com.xxxx.crm.query;

import com.xxxx.crm.base.BaseQuery;

/**
 * 多条件查询参数
 */
public class SaleChanceQuery extends BaseQuery {
    private String customerName;
    private String createMan;
    private Integer state;

    //客户开发计划
    private Integer devResult;
    private Integer assignMan;

    public Integer getDevResult() {
        return devResult;
    }

    public void setDevResult(Integer devResult) {
        this.devResult = devResult;
    }

    public Integer getAssignMan() {
        return assignMan;
    }

    public void setAssignMan(Integer assignMan) {
        this.assignMan = assignMan;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCreateMan() {
        return createMan;
    }

    public void setCreateMan(String createMan) {
        this.createMan = createMan;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }
}
