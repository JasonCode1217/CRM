package com.xxxx.crm.controller;

import com.xxxx.crm.base.BaseController;
import com.xxxx.crm.base.ResultInfo;
import com.xxxx.crm.query.CustomerLossQuery;
import com.xxxx.crm.service.CustomerLossService;
import com.xxxx.crm.service.CustomerService;
import com.xxxx.crm.vo.CustomerLoss;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("customer_loss")
public class CustomerLossController extends BaseController {
    @Resource
    private CustomerLossService customerLossService;

    /**
     * 多条件查询客户流失信息
     * @param customerLossQuery
     * @return
     */
    @RequestMapping("list")
    @ResponseBody
    public Map<String, Object> queryCustomerLossByParams(CustomerLossQuery customerLossQuery){
        return customerLossService.queryCustomerLossByParams(customerLossQuery);
    }
    /**
     * 更新流失客户的流失状态
     *
     * @param
     * @return com.xxxx.crm.base.ResultInfo
     */
    @PostMapping("updateCustomerLossStateById")
    @ResponseBody
    public ResultInfo updateCustomerLossStateById(Integer id, String lossReason) {
        customerLossService.updateCustomerLossStateById(id, lossReason);
        return success("确认流失成功！");
    }
    //打开客户流失管理主页
    @RequestMapping("index")
    public String index(){
        return "customerLoss/customer_loss";
    }
    //打开暂缓措施页面
    @RequestMapping("toCustomerLossPage")
    public String toCustomerLossPage(Integer lossId, Model model){
        //通过流失id查询对应的流失客户信息
        CustomerLoss customerLoss = customerLossService.selectByPrimaryKey(lossId);
        //将查到的信息存到请求域中
        model.addAttribute("customerLoss",customerLoss);
        return "customerLoss/customer_rep";
    }
}
