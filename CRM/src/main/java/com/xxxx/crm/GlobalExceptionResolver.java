package com.xxxx.crm;

import com.alibaba.fastjson.JSON;
import com.xxxx.crm.base.ResultInfo;
import com.xxxx.crm.exceptions.NoLoginException;
import com.xxxx.crm.exceptions.ParamsException;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 全局异常处理
 */
@Component
public class GlobalExceptionResolver implements HandlerExceptionResolver {
    /**
     * 异常处理方法
     *      1.返回视图
     *      2.返回数据（JSON）
     * 通过判断是否有ResponseBody注解来区分返回的是视图还是JSON数据
     * @param request
     * @param response
     * @param handler
     * @param e
     * @return
     */
    @Override
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception e) {
        /**
         * 非法拦截
         */
        if(e instanceof NoLoginException){
            //重定向到登录页面
            ModelAndView modelAndView = new ModelAndView("redirect:/index");
            return modelAndView;
        }

        /**
         * 设置默认异常
         */
        ModelAndView modelAndView = new ModelAndView("error");
        modelAndView.addObject("code",500);
        modelAndView.addObject("msg","系统异常，请重试...");


        /**
         * 判断方法对象返回的是视图还是JSON数据
         */
        if(handler instanceof HandlerMethod){
            //类型转换
            HandlerMethod handlerMethod = (HandlerMethod) handler;
            //获取方法上声明的Response注解对象
            ResponseBody responseBody = handlerMethod.getMethod().getDeclaredAnnotation(ResponseBody.class);
            //判断responseBody是否为空
            if(responseBody == null){
                //返回视图
                //判断是否是自定义异常
                if(e instanceof ParamsException){
                    ParamsException p = (ParamsException) e;
                    modelAndView.addObject("code",p.getCode());
                    modelAndView.addObject("msg",p.getMsg());
                }
                return modelAndView;
            }
            else {
                //返回数据（JSON）
                ResultInfo resultInfo = new ResultInfo();
                resultInfo.setCode(500);
                resultInfo.setMsg("系统异常，请重试...");
                //判断是否是自定义异常
                if(e instanceof ParamsException){
                    ParamsException p = (ParamsException) e;
                    resultInfo.setCode(p.getCode());
                    resultInfo.setMsg(p.getMsg());
                }

                //设置响应类型及编码格式 这里是json格式
                response.setContentType("application/json;charset=utf-8");
                PrintWriter out = null;
                try {
                    out = response.getWriter();
                    //将返回的对象转换成JSON格式的字符
                    String json = JSON.toJSONString(resultInfo);
                    //输出数据
                    out.write(json);
                } catch (IOException ioException) {
                    ioException.printStackTrace();
                }finally {
                    if(out != null)
                        out.close();
                }
                return null;
            }
        }

        return modelAndView;
    }
}
