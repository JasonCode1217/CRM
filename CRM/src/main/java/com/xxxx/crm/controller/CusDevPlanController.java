package com.xxxx.crm.controller;

import com.xxxx.crm.base.BaseController;
import com.xxxx.crm.base.ResultInfo;
import com.xxxx.crm.query.CusDevPlanQuery;
import com.xxxx.crm.service.CusDevPlanService;
import com.xxxx.crm.service.SaleChanceService;
import com.xxxx.crm.vo.CusDevPlan;
import com.xxxx.crm.vo.SaleChance;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
@RequestMapping("cus_dev_plan")
public class CusDevPlanController extends BaseController {
    @Resource
    private SaleChanceService saleChanceService;

    @Resource
    private CusDevPlanService cusDevPlanService;
    /**
     * 加载客户开发计划主页面
     * @return
     */
    @RequestMapping("index")
    public String index(){
        return "cusDevPlan/cus_dev_plan";
    }

    /**
     * 打开开发计划窗口
     * @return
     */
    @RequestMapping("dialog")
    public String openDialog(Integer id, HttpServletRequest request){
        //通过主键获取营销机会信息
        SaleChance saleChance = saleChanceService.selectByPrimaryKey(id);
        //把获取的数据设置到请求域中
        request.setAttribute("saleChance",saleChance);
        return "cusDevPlan/cus_dev_plan_data";
    }


    /**
     * 打开添加/更新对话框
     * @return
     */
    @RequestMapping("toAddUpdatePage")
    public String toAddUpdatePage(HttpServletRequest request,Integer sId,Integer id){
        request.setAttribute("sId",sId);
        //判断id是否存在
        if(id != null){
            CusDevPlan cusDevPlan = cusDevPlanService.selectByPrimaryKey(id);
            //将数据设置到请求域中
            request.setAttribute("cusDevPlan",cusDevPlan);
        }
        return "cusDevPlan/add_update";
    }

    /**
     * 多条件查询
     * @param cusDevPlanQuery
     * @return
     */
    @RequestMapping("list")
    @ResponseBody
    public Map<String,Object> queryCusDevPlan(CusDevPlanQuery cusDevPlanQuery){
        return cusDevPlanService.queryCusDevPlan(cusDevPlanQuery);
    }

    /**
     * 添加计划
     * @param cusDevPlan
     * @return
     */
    @PostMapping("add")
    @ResponseBody
    public ResultInfo addCusDevPlan(CusDevPlan cusDevPlan){
        cusDevPlanService.addCusDevPlan(cusDevPlan);
        return success("添加计划成功！");
    }

    /**
     * 更新计划
     * @param cusDevPlan
     * @return
     */
    @PostMapping("update")
    @ResponseBody
    public ResultInfo updateCusDevPlan(CusDevPlan cusDevPlan){
        cusDevPlanService.updateCusDevPlan(cusDevPlan);
        return success("更新成功！");
    }

    /**
     * 删除计划
     * @param id
     * @return
     */
    @PostMapping("delete")
    @ResponseBody
    public ResultInfo deleteCusDevPlan(Integer id){
        cusDevPlanService.deleteCusDevPlan(id);
        return success("删除成功！");
    }
}
