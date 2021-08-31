package com.xxxx.crm.controller;

import com.xxxx.crm.base.BaseController;
import com.xxxx.crm.dao.PermissionMapper;
import com.xxxx.crm.service.PermissionService;
import com.xxxx.crm.service.UserService;
import com.xxxx.crm.utils.LoginUserUtil;
import com.xxxx.crm.vo.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class IndexController extends BaseController {
    @Resource
    private UserService userService;
    @Resource
    private PermissionService permissionService;
    /**
     * 系统登录页
     * @return
     */
    @RequestMapping("index")
    public String index(){
        return "index";
    }
    // 系统界面欢迎页
    @RequestMapping("welcome")
    public String welcome() {
        return "welcome";
    }
    /**
     * 后端管理主页面
     * @return
     */
    @RequestMapping("main")
    public String main(HttpServletRequest request){
        /**
         * User对象的获取 通过id在数据库中查找
         * id是经加密后存放在cookie中的 cookie通过request获取
         * 需要把cookie中的id解密，再到数据库中查找对应的用户信息
         * 调用工具类中的LoginUserUtil实现
         */
        Integer id = LoginUserUtil.releaseUserIdFromCookie(request);
        User user = userService.selectByPrimaryKey(id);
        request.getSession().setAttribute("user",user);

        //通过登录用户id查询其所拥有的资源权限
        List<String> permissions = permissionService.queryUserRoleHasPermission(id);
        //将查询结果设置到session中
        request.getSession().setAttribute("permissions",permissions);
        return "main";
    }
}
