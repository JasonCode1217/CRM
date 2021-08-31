package com.xxxx.crm.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xxxx.crm.base.BaseService;
import com.xxxx.crm.dao.SaleChanceMapper;
import com.xxxx.crm.enums.DevResult;
import com.xxxx.crm.enums.StateStatus;
import com.xxxx.crm.query.SaleChanceQuery;
import com.xxxx.crm.utils.AssertUtil;
import com.xxxx.crm.utils.PhoneUtil;
import com.xxxx.crm.vo.SaleChance;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Service
public class SaleChanceService extends BaseService<SaleChance,Integer> {
    @Resource
    private SaleChanceMapper saleChanceMapper;

    /**
     * 多条件查询分页查询营销机会
     * @param saleChanceQuery
     * @return
     */
    public Map<String,Object> querySaleChanceParams(SaleChanceQuery saleChanceQuery){
        Map<String,Object> map = new HashMap<>();
        //开启分页
        PageHelper.startPage(saleChanceQuery.getPage(),saleChanceQuery.getLimit());
        //得到对应分页对象
        PageInfo<SaleChance> pageInfo = new PageInfo<>(saleChanceMapper.selectByParams(saleChanceQuery));
        //设置map对象
        map.put("code",0);
        map.put("msg","success");
        map.put("count",pageInfo.getTotal());
        //添加数据
        map.put("data",pageInfo.getList());
        return map;
    }

    /**
     * 添加营销机会
     * 1.不能为空的参数
     *      customerName 客户名称
     *      linkMan 联系人
     *      linkPhone 电话（还需要校验手机号码格式）
     * 2.相关参数默认值
     *      createMan 当前用户名
     *      devResult 开发结果 默认为0--未开发
     *      isValid 有效状态 一旦添加记录则默认为1--有效
     *      assignMan 分配人
     *          若未指明分配人则默认未分配，分配时间为null，state 分配状态 默认为0--未分配
     *          若指明了分配人，分配时间为当前时间，state 分配状态设置为1--已分配，assignTime分配时间为当前时间，devResult开发结果为1--开发中
     *
     *      createDate创建时间  默认系统当前时间
     *      updateDate更新时间  默认系统当前时间
     * 3.执行添加操作，判断受影响行数
     * @param saleChance
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void addSaleChance(SaleChance saleChance){
        /* 1.参数校验 */
        checkParamsIsNull(saleChance.getCustomerName(),saleChance.getLinkMan(),saleChance.getLinkPhone());
        /* 2.设置参数默认值 */
        saleChance.setCreateDate(new Date());
        saleChance.setUpdateDate(new Date());
        saleChance.setIsValid(1);
        //是否设置指派人？
        if(StringUtils.isBlank(saleChance.getAssignMan())){
            //未设置指派人
            saleChance.setAssignTime(null);
            //通过枚举类来表示状态，方便后期维护与修改数据
            saleChance.setState(StateStatus.UNSTATE.getType());
            saleChance.setDevResult(DevResult.UNDEV.getStatus());
        }
        else {//设置了指派人
            saleChance.setAssignTime(new Date());
            saleChance.setState(StateStatus.STATED.getType());
            saleChance.setDevResult(DevResult.DEVING.getStatus());
        }
        /* 执行添加操作，返回受影响行数 */
        AssertUtil.isTrue(saleChanceMapper.insertSelective(saleChance)<1,"添加失败！");
    }

    /**
     * 更新营销机会
     * 1.参数非空校验
     *      id 营销id
     *      customerName 客户名称
     *      linkMan 联系人
     *      linkPhone 电话（还需要校验手机号码格式）
     * 2.设置默认值
     *      updateDate 更新时间（系统当前时间）
     *      assignMan 指派人
     *          原始数据未设置
     *              修改后未设置-->不需要操作
     *              修改后已设置-->assignTime 设置为当前时间
     *                           state=1
     *                           devResult=1
     *          原始数据已设置
     *              修改后未设置-->assignTime 设置为null
     *                           state=0
     *                           devResult=0
     *              修改后已设置
     *                  判断是否是同一个指派人
     *                      是-->不需要操作
     *                      不是-->assignTime 设置为当前时间
     * 3.执行更新操作，返回受影响行数
     *
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateSaleChance(SaleChance saleChance){
        /* 1.参数非空校验 */
        //判断id
        AssertUtil.isTrue(saleChance.getId() == null,"待更新记录不存在！");
        SaleChance temp = saleChanceMapper.selectByPrimaryKey(saleChance.getId());
        AssertUtil.isTrue(temp == null,"待更新记录不存在！");
        //参数非空校验
        checkParamsIsNull(saleChance.getCustomerName(),saleChance.getLinkMan(),saleChance.getLinkPhone());
        /* 2.设置默认值 */
        //updateDate 更新时间（系统当前时间）
        saleChance.setUpdateDate(new Date());
        //assignMan 指派人
        //判断原始数据是否存在
        if(StringUtils.isBlank(temp.getAssignMan())){
            //原始数据未设置
            //判断修改后是否设置
            if(!StringUtils.isBlank(saleChance.getAssignMan())){
                //修改后已设置
                saleChance.setAssignTime(new Date());
                saleChance.setState(StateStatus.STATED.getType());
                saleChance.setDevResult(DevResult.DEVING.getStatus());
            }
        }
        else {
            //原始数据已设置
            if(StringUtils.isBlank(saleChance.getAssignMan())){
                //修改后未设置
                saleChance.setAssignTime(null);
                saleChance.setState(StateStatus.UNSTATE.getType());
                saleChance.setDevResult(DevResult.UNDEV.getStatus());
            }
            else {
                //修改后已设置
                if(saleChance.getAssignMan() != temp.getAssignMan()){
                    saleChance.setAssignTime(new Date());
                }
                else {//修改前后为同一个分配人
                    saleChance.setAssignTime(temp.getAssignTime());
                }
            }
        }
        /* 3.执行更新操作 */
        AssertUtil.isTrue(saleChanceMapper.updateByPrimaryKeySelective(saleChance) < 1,"更新失败！");
    }

    /**
     * 删除营销机会
     * @param ids
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteSaleChances(Integer[] ids){
        AssertUtil.isTrue(ids == null||ids.length<1,"待删除记录不存在！");
        AssertUtil.isTrue(saleChanceMapper.deleteBatch(ids)!=ids.length,"营销记录删除失败！");
    }

    /**
     * 设置为开发成功
     * @param id
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void setDevSuccess(Integer id){
        AssertUtil.isTrue(id == null,"数据异常，请重试！");
        AssertUtil.isTrue(saleChanceMapper.setSuccess(id)<1,"设置失败！");
    }

    /**
     * 设置为开发失败
     * @param id
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void setDevFailed(Integer id){
        AssertUtil.isTrue(id == null,"数据异常，请重试！");
        AssertUtil.isTrue(saleChanceMapper.setFailed(id)<1,"设置失败！");
    }
    /**
     * 参数非空校验
     * @param customerName
     * @param linkMan
     * @param linkPhone
     */
    private void checkParamsIsNull(String customerName, String linkMan, String linkPhone) {
        AssertUtil.isTrue(StringUtils.isBlank(customerName),"客户名称不能为空！");
        AssertUtil.isTrue(StringUtils.isBlank(linkMan),"联系人不能为空！");
        AssertUtil.isTrue(StringUtils.isBlank(linkPhone),"联系电话不能为空！");
        AssertUtil.isTrue(!PhoneUtil.isMobile(linkPhone),"电话号码格式有误！");
    }
}
