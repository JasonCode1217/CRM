package com.xxxx.crm.dao;

import com.xxxx.crm.base.BaseMapper;
import com.xxxx.crm.model.TreeModel;
import com.xxxx.crm.vo.Module;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ModuleMapper extends BaseMapper<Module,Integer> {
    //查询所有的资源（指定返回值，树形结构）
    List<TreeModel> queryAllModules();

    //查询所有的资源数据（所有值）
    List<Module> queryModuleList();

    //通过层级和模块名查找对象
    //遇到多个参数的情况，使用注解，这样可以直接向xml文件传值
    Module queryModuleByGradeAndModuleName(@Param("grade") Integer grade, @Param("moduleName")String moduleName);

    //通过层级和url查找对象
    Module queryModuleByGradeAndUrl(@Param("grade")Integer grade, @Param("url")String url);

    //通过权限码查找对象
    Module queryModuleByOptValue(String optValue);
    //通过父id查询资源数量
    Integer queryModuleCountByParentId(Integer id);
    //通过id查权限数量
    Integer queryPermissionCountById(Integer id);
    //通过id删除权限
    void deletePermissionById(Integer id);
}