package com.xxxx.crm.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xxxx.crm.base.BaseService;
import com.xxxx.crm.dao.CusDevPlanMapper;
import com.xxxx.crm.dao.SaleChanceMapper;
import com.xxxx.crm.enums.StateStatus;
import com.xxxx.crm.query.CusDevPlanQuery;
import com.xxxx.crm.utils.AssertUtil;
import com.xxxx.crm.vo.CusDevPlan;
import com.xxxx.crm.vo.SaleChance;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Service
public class CusDevPlanService extends BaseService<CusDevPlan,Integer> {
    @Resource
    private CusDevPlanMapper cusDevPlanMapper;

    @Resource
    private SaleChanceMapper saleChanceMapper;
    /**
     * 多条件查询分页查询营销机会
     * @param cusDevPlanQuery
     * @return
     */
    public Map<String,Object> queryCusDevPlan(CusDevPlanQuery cusDevPlanQuery){
        Map<String,Object> map = new HashMap<>();
        //开启分页
        PageHelper.startPage(cusDevPlanQuery.getPage(),cusDevPlanQuery.getLimit());
        //得到对应分页对象
        PageInfo<CusDevPlan> pageInfo = new PageInfo<>(cusDevPlanMapper.selectByParams(cusDevPlanQuery));
        //设置map对象
        map.put("code",0);
        map.put("msg","success");
        map.put("count",pageInfo.getTotal());
        //添加数据
        map.put("data",pageInfo.getList());
        return map;
    }

    /**
     * 添加客户开发计划
     * 1.参数非空判断
     *      营销机会id
     *      计划内容
     *      计划时间
     * 2.默认值
     *      有效状态 默认有效
     *      创建时间 系统当前时间
     *      更新时间 系统当前时间
     * 3.执行添加操作，返回受影响行数
     * @param cusDevPlan
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void addCusDevPlan(CusDevPlan cusDevPlan){
        /* 1.参数校验 */
        checkParams(cusDevPlan);
        /* 2.设置默认值 */
        cusDevPlan.setIsValid(StateStatus.STATED.getType());
        cusDevPlan.setCreateDate(new Date());
        cusDevPlan.setUpdateDate(new Date());
        /* 3.执行添加操作 */
        AssertUtil.isTrue(cusDevPlanMapper.insertSelective(cusDevPlan)<1,"添加失败！");
    }

    /**
     * 更新客户开发计划
     * @param cusDevPlan
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateCusDevPlan(CusDevPlan cusDevPlan){
        /* 1.参数校验 */
        AssertUtil.isTrue(cusDevPlan.getId() == null,"数据异常，请重试！");
        checkParams(cusDevPlan);
        /* 2.设置修改时间 */
        cusDevPlan.setUpdateDate(new Date());
        /* 3.执行更新操作 */
        AssertUtil.isTrue(cusDevPlanMapper.updateByPrimaryKeySelective(cusDevPlan)<1,"更新失败！");
    }

    /**
     * 删除客户开发计划
     * @param id
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteCusDevPlan(Integer id){
        AssertUtil.isTrue(id == null,"待删记录不存在！");
        AssertUtil.isTrue(cusDevPlanMapper.deleteByPrimaryKey(id)<1,"删除失败！");
    }
    //参数校验
    private void checkParams(CusDevPlan cusDevPlan) {
        Integer sid = cusDevPlan.getSaleChanceId();
        AssertUtil.isTrue(sid == null||saleChanceMapper.selectByPrimaryKey(sid) == null,"数据异常，请重试！");
        AssertUtil.isTrue(StringUtils.isBlank(cusDevPlan.getPlanItem()),"计划内容不能为空！");
        AssertUtil.isTrue(cusDevPlan.getPlanDate() == null,"计划时间不能为空！");
    }
}
