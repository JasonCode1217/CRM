package com.xxxx.crm.task;

import com.xxxx.crm.service.CustomerService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * 定时任务
 */
@Component
public class JobTask {
    @Resource
    private CustomerService customerService;

    /**
     * 设置定时任务，设置定时时间Scheduled
     */
    @Scheduled(cron = "0/2 * * * * ?")//这里只是以两秒间隔为例
    public void job(){
        customerService.updateCustomerState();
    }
}
