package com.xxxx.crm.controller;

import com.xxxx.crm.base.BaseController;
import com.xxxx.crm.base.ResultInfo;
import com.xxxx.crm.exceptions.ParamsException;
import com.xxxx.crm.model.UserModel;
import com.xxxx.crm.query.UserQuery;
import com.xxxx.crm.service.UserService;
import com.xxxx.crm.utils.LoginUserUtil;
import com.xxxx.crm.vo.SaleChance;
import com.xxxx.crm.vo.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("user")
public class UserController extends BaseController {
    @Resource
    private UserService userService;

    /**
     * 用户登录
     * @param userName
     * @param userPwd
     * @return
     */
    @PostMapping("login")
    @ResponseBody
    public ResultInfo userLogin(String userName,String userPwd){
        ResultInfo resultInfo = new ResultInfo();
        //调用userService的方法
        UserModel userModel = userService.userLogin(userName,userPwd);
        //设置ResultInfo的result值
        resultInfo.setResult(userModel);
//        try{
//            //调用userService的方法
//            UserModel userModel = userService.userLogin(userName,userPwd);
//            //设置ResultInfo的result值
//            resultInfo.setResult(userModel);
//
//        }catch (ParamsException e){
//            resultInfo.setCode(e.getCode());
//            resultInfo.setMsg(e.getMsg());
//            e.printStackTrace();
//        }catch (Exception e){
//            resultInfo.setCode(500);
//            resultInfo.setMsg("ERROR：登录出现了问题！");
//            e.printStackTrace();
//        }
        return resultInfo;
    }

    /**
     * 修改密码
     * @param request
     * @param oldPwd
     * @param newPwd
     * @param repeatPwd
     * @return
     */
    @PostMapping("updatePassword")
    @ResponseBody
    public ResultInfo updatePassword(HttpServletRequest request,String oldPwd,String newPwd,String repeatPwd){
        ResultInfo resultInfo = new ResultInfo();
        //通过cookie获取用户id
        Integer userId = LoginUserUtil.releaseUserIdFromCookie(request);
        //调用service层的修改密码方法
        userService.updatePassword(userId,oldPwd,newPwd,repeatPwd);
        /* 因为设置了全局异常处理，这样就降低了代码的耦合度，不需要对每一个功能都进行try/catch */
//        try{
//            //通过cookie获取用户id
//            Integer userId = LoginUserUtil.releaseUserIdFromCookie(request);
//            //调用service层的修改密码方法
//            userService.updatePassword(userId,oldPwd,newPwd,repeatPwd);
//        }catch (ParamsException e){
//            resultInfo.setCode(e.getCode());
//            resultInfo.setMsg(e.getMsg());
//            e.printStackTrace();
//        }catch (Exception e){
//            resultInfo.setCode(500);
//            resultInfo.setMsg("ERROR：修改密码出现了问题！");
//            e.printStackTrace();
//        }
        return resultInfo;
    }

    /**
     * 查询所有销售人员
     * @return
     */
    @RequestMapping("queryAllSales")
    @ResponseBody
    public List<Map<String,Object>> queryAllSales(){
        return userService.queryAllSales();
    }

    /**
     * 分页多条件查询用户信息
     * @param userQuery
     * @return
     */
    @RequestMapping("list")
    @ResponseBody
    public Map<String,Object> selectByParams(UserQuery userQuery){
        return userService.queryByParamsForTable(userQuery);
    }

    /**
     * 批量删除用户信息
     * @param ids
     * @return
     */
    @PostMapping("delete")
    @ResponseBody
    public ResultInfo deleteBatchByIds(Integer[] ids){
        userService.deleteBatchByIds(ids);
        return success("删除成功！");
    }

    /**
     * 添加用户信息
     * @param user
     * @return
     */
    @PostMapping("add")
    @ResponseBody
    public ResultInfo addUser(User user){
        userService.addUser(user);
        return success("添加成功！");
    }

    /**
     * 更新用户信息
     * @param user
     * @return
     */
    @PostMapping("update")
    @ResponseBody
    public ResultInfo updateUser(User user){
        userService.updateUser(user);
        return success("更新成功！");
    }
    /**
     * 查询所有的客户经理
     *
     *
     * @param
     * @return java.util.List<java.util.Map<java.lang.String,java.lang.Object>>
     */
    @RequestMapping("queryAllCustomerManagers")
    @ResponseBody
    public List<Map<String,Object>> queryAllCustomerManagers(){
        return userService.queryAllCustomerManagers();
    }
    /* 用户信息管理主页面 */
    @RequestMapping("index")
    public String index(){
        return "user/user";
    }

    //打开添加/更新窗口
    @RequestMapping("dialog")
    public String openUpdateDialog(HttpServletRequest request,Integer userId){
        //判断userId是否存在
        if(userId != null){
            User user = userService.selectByPrimaryKey(userId);
            //将数据设置到请求域中,由于之前用过user这个名字，所以最好换一个命名，否则会出现数据重叠
            request.setAttribute("userInfo",user);
        }
        return "user/add_update";
    }

    //页面跳转-->修改密码
    @RequestMapping("toPasswordPage")
    public String toPasswordPage(){
        return "user/password";
    }
    //页面跳转-->基本资料
    @RequestMapping("toSettingPage")
    public String toSettingPage(){
        return "user/setting";
    }
}
