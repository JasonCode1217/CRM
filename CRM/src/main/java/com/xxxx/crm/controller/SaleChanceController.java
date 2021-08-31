package com.xxxx.crm.controller;

import com.xxxx.crm.base.BaseController;
import com.xxxx.crm.base.ResultInfo;
import com.xxxx.crm.enums.StateStatus;
import com.xxxx.crm.query.SaleChanceQuery;
import com.xxxx.crm.service.SaleChanceService;
import com.xxxx.crm.utils.CookieUtil;
import com.xxxx.crm.utils.LoginUserUtil;
import com.xxxx.crm.vo.SaleChance;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
@RequestMapping("sale_chance")
public class SaleChanceController extends BaseController {
    @Resource
    private SaleChanceService saleChanceService;

    /**
     * 多条件查询
     * 通过判断flag的值来确认是营销管理还是客户计划开发管理
     * 值为1-->客户开发计划
     * @param saleChanceQuery
     * @return
     */
    @RequestMapping("list")
    @ResponseBody
    public Map<String,Object> querySaleChanceParams(SaleChanceQuery saleChanceQuery,Integer flag,HttpServletRequest request){
        if(flag != null && flag == 1){
            //设置分配状态
            saleChanceQuery.setState(StateStatus.STATED.getType());
            //设置指派人-->当前用户id
            Integer userId = LoginUserUtil.releaseUserIdFromCookie(request);
            saleChanceQuery.setAssignMan(userId);
        }
        return saleChanceService.querySaleChanceParams(saleChanceQuery);
    }

    /**
     * 进入营销机会管理页面
     * @return
     */
    @RequestMapping("index")
    public String index(){
        return "saleChance/sale_chance";
    }

    /**
     * 添加营销机会
     * @param saleChance
     * @return
     */
    @PostMapping("add")
    @ResponseBody
    public ResultInfo addSaleChance(HttpServletRequest request,SaleChance saleChance){
        //通过cookie获取用户名
        String userName = CookieUtil.getCookieValue(request,"userName");
        saleChance.setCreateMan(userName);
        //调用service层添加方法
        saleChanceService.addSaleChance(saleChance);
        //success是BaseController中的一个方法可以返回一个ResultInfo对象
        return success("营销机会添加成功！");
    }

    /**
     * 更新营销机会
     * @param saleChance
     * @return
     */
    @PostMapping("update")
    @ResponseBody
    public ResultInfo updateSaleChance(SaleChance saleChance){
        //调用service层添加方法
        saleChanceService.updateSaleChance(saleChance);
        //success是BaseController中的一个方法可以返回一个ResultInfo对象
        return success("营销机会更新成功！");
    }

    /**
     * 删除营销机会（valid值设为0）
     * @param ids
     * @return
     */
    @PostMapping("delete")
    @ResponseBody
    public ResultInfo deleteSaleChances(Integer[] ids){
        saleChanceService.deleteBatch(ids);
        return success("营销机会删除成功！");
    }

    /**
     * 设置营销机会开发成功
     * @param id
     * @return
     */
    @RequestMapping("setDevSuccess")
    @ResponseBody
    public ResultInfo setDevSuccess(Integer id){
        saleChanceService.setDevSuccess(id);
        return success("设置成功！");
    }

    /**
     * 设置营销机会开发失败
     * @param id
     * @return
     */
    @RequestMapping("setDevFailed")
    @ResponseBody
    public ResultInfo setDevFailed(Integer id){
        saleChanceService.setDevFailed(id);
        return success("设置成功！");
    }


    /**
     * 添加营销机会弹出框
     * @return
     */
    @RequestMapping("dialog")
    public String addSaleChanceDialog(HttpServletRequest request,Integer saleChanceId){
        //判断saleChanceIf是否存在
        if(saleChanceId != null){
            SaleChance saleChance = saleChanceService.selectByPrimaryKey(saleChanceId);
            //将数据设置到请求域中
            request.setAttribute("saleChance",saleChance);
        }
        return "saleChance/add_update";
    }
}
