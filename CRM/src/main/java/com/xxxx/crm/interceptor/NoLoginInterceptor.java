package com.xxxx.crm.interceptor;

import com.xxxx.crm.dao.UserMapper;
import com.xxxx.crm.exceptions.NoLoginException;
import com.xxxx.crm.utils.LoginUserUtil;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 非法拦截
 *      若用户未登录就访问其他页面
 *      则抛出NoLoginException异常
 */
public class NoLoginInterceptor extends HandlerInterceptorAdapter {
    @Resource
    private UserMapper userMapper;
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //通过cookie获取id
        Integer userId = LoginUserUtil.releaseUserIdFromCookie(request);
        //判断id是否为空或在数据库中是否有相应用户
        if(userId == null||userMapper.selectByPrimaryKey(userId) == null){
            throw new NoLoginException();
        }
        return true;
    }
}
