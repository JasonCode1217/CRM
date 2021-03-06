package com.xxxx.crm.controller;

import com.xxxx.crm.base.BaseController;
import com.xxxx.crm.base.ResultInfo;
import com.xxxx.crm.query.CustomerReprieveQuery;
import com.xxxx.crm.service.CustomerReprieveService;
import com.xxxx.crm.vo.CustomerReprieve;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
@RequestMapping("customer_rep")
public class CustomerReprieveController extends BaseController {
    @Resource
    private CustomerReprieveService customerReprieveService;

    /**
     * 分页条件查询流失客户暂缓操作的列表
     *
     * @param customerReprieveQuery
     * @return java.util.Map<java.lang.String,java.lang.Object>
     */
    @RequestMapping("list")
    @ResponseBody
    public Map<String, Object> queryCustomerReprieveByParams(CustomerReprieveQuery customerReprieveQuery) {
        return customerReprieveService.queryCustomerReprieveByParams(customerReprieveQuery);
    }

    /**
     * 添加操作
     * @param customerReprieve
     * @return
     */
    @PostMapping("add")
    @ResponseBody
    public ResultInfo addCustomerReprieve(CustomerReprieve customerReprieve){
        customerReprieveService.addCustomerReprieve(customerReprieve);
        return success("添加成功！");
    }
    /**
     * 更新操作
     * @param customerReprieve
     * @return
     */
    @PostMapping("update")
    @ResponseBody
    public ResultInfo updateCustomerReprieve(CustomerReprieve customerReprieve){
        customerReprieveService.updateCustomerReprieve(customerReprieve);
        return success("添加成功！");
    }
    /**
     * 打开添加/修改暂缓数据的页面
     *
     * @param
     * @return java.lang.String
     */
    @RequestMapping("toAddOrUpdatePage")
    public String toAddOrUpdaterPage(Integer lossId, HttpServletRequest request, Integer id) {
        // 将流失客户ID存到作用域中
        request.setAttribute("lossId", lossId);
        // 判断ID是否为空
        if (id != null) {
            // 通过主键ID查询暂缓数据
            CustomerReprieve customerRep = customerReprieveService.selectByPrimaryKey(id);
            // 设置到请求域中
            request.setAttribute("customerRep", customerRep);
        }

        return "customerLoss/customer_rep_add_update";
    }


    /**
     * 删除暂缓数据
     *
     * @param id
     * @return com.xxxx.crm.base.ResultInfo
     */
    @PostMapping("delete")
    @ResponseBody
    public ResultInfo updateCustomerReprieve(Integer id) {
        customerReprieveService.deleteCustomerReprieve(id);
        return success("删除暂缓数据成功！");
    }
}
