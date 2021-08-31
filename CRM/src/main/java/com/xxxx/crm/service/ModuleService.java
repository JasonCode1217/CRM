package com.xxxx.crm.service;

import com.sun.org.apache.xpath.internal.operations.Mod;
import com.xxxx.crm.base.BaseService;
import com.xxxx.crm.dao.ModuleMapper;
import com.xxxx.crm.dao.PermissionMapper;
import com.xxxx.crm.model.TreeModel;
import com.xxxx.crm.utils.AssertUtil;
import com.xxxx.crm.vo.Module;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class ModuleService extends BaseService<Module,Integer> {
    @Resource
    private ModuleMapper moduleMapper;
    @Resource
    private PermissionMapper permissionMapper;

    /**
     * 查询资源列表（部分字段-->树形结构），treeModel
     * @param roleId
     * @return
     */
    public List<TreeModel> queryAllModules(Integer roleId){
        //查询所有资源列表
        List<TreeModel> treeModelList = moduleMapper.queryAllModules();
        //查询角色拥有的资源id
        List<Integer> permissionIds = permissionMapper.queryRoleHasModuleIds(roleId);
        if(permissionIds != null && permissionIds.size()>0){
            treeModelList.forEach(treeModel -> {
                if(permissionIds.contains(treeModel.getId())){
                    //若角色权限表中包含该权限id，则checked设置为true
                    treeModel.setChecked(true);
                }
            });
        }
        return treeModelList;
    }

    /**
     * 查询所有资源（所有字段）
     * @return
     */
    public Map<String,Object> queryModuleList(){
        Map<String,Object> map = new HashMap<>();
        //查询资源列表
        List<Module> moduleList = moduleMapper.queryModuleList();
        map.put("code",0);
        map.put("msg","");
        map.put("count",moduleList.size());
        map.put("data",moduleList);
        return map;
    }

    /**
     * 添加资源
     * 1. 参数校验
     *      模块名称 moduleName
     *          非空，同一层级唯一
     *      地址 url
     *          二级菜单非空且不重复
     *      父级菜单 parentId
     *          一级菜单为null
     *          二级三级非空
     *      层级 grade
     *          非空 0/1/2
     *      权限码 optValue
     *          非空，不可重复
     * 2. 设置默认值：is_valid，create_date、update_date
     * 3. 执行添加操作
     * @param module
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void addModule(Module module){
        Integer grade = module.getGrade();
        AssertUtil.isTrue(grade == null||!(grade==1||grade==2||grade==0),"层级错误！");
        AssertUtil.isTrue(StringUtils.isBlank(module.getModuleName()),"请输入菜单名!");
        //通过层级和模块名查找对象
        AssertUtil.isTrue(null !=moduleMapper.queryModuleByGradeAndModuleName(module.getGrade(),module.getModuleName()),"该层级下菜单重复!");
        if(grade==1){
            AssertUtil.isTrue(StringUtils.isBlank(module.getUrl()),"请指定二级菜单URL值");
            AssertUtil.isTrue(null !=moduleMapper.queryModuleByGradeAndUrl(module.getGrade(),module.getUrl()),"二级菜单URL不可重复!");
        }
        if(grade == 0){
            module.setParentId(-1);
        }
        if(grade !=0){
            Integer parentId = module.getParentId();
            AssertUtil.isTrue(null==parentId || null==selectByPrimaryKey(parentId),"请指定上级菜单!");
        }
        AssertUtil.isTrue(StringUtils.isBlank(module.getOptValue()),"请输入权限码!");
        AssertUtil.isTrue(null !=moduleMapper.queryModuleByOptValue(module.getOptValue()),"权限码重复!");
        module.setIsValid(1);
        module.setCreateDate(new Date());
        module.setUpdateDate(new Date());
        AssertUtil.isTrue(insertSelective(module)<1,"菜单添加失败!");

    }

    /**
     * 更新资源
     * 内容大致和添加一样，但是要注意验证模块名称唯一性时，前后未修改的情况
     *
     * @param module
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateModule(Module module){
        /* 1.非空判断 */
        AssertUtil.isTrue(module.getId() == null,"待更新记录不存在！");
        Module temp = moduleMapper.selectByPrimaryKey(module.getId());
        AssertUtil.isTrue(temp == null,"待更新记录不存在！");
        Integer grade = module.getGrade();
        AssertUtil.isTrue(grade == null||!(grade==1||grade==2||grade==0),"层级错误！");
        //模块名称非空、唯一性判断
        AssertUtil.isTrue(StringUtils.isBlank(module.getModuleName()),"菜单名称不能为空!");
        temp = moduleMapper.queryModuleByGradeAndModuleName(grade,module.getModuleName());
        if(temp != null){
            AssertUtil.isTrue(!(temp.getId().equals(module.getId())),"该菜单名称此层级下已存在！");
        }
        if(grade==1){
            AssertUtil.isTrue(StringUtils.isBlank(module.getUrl()),"请指定二级菜单url值");
            temp = moduleMapper.queryModuleByGradeAndUrl(grade,module.getUrl());
            if(temp != null){
                AssertUtil.isTrue(!(temp.getId().equals(module.getId())),"该URL此层级下已存在！");
            }
        }
        //判断权限码非空、唯一性
        AssertUtil.isTrue(StringUtils.isBlank(module.getOptValue()),"请输入权限码!");
        temp = moduleMapper.queryModuleByOptValue(module.getOptValue());
        if(temp != null){
            AssertUtil.isTrue(!(temp.getId().equals(module.getId())),"该权限码此层级下已存在！");
        }
        //设置默认值
        module.setUpdateDate(new Date());
        //执行更新操作
        AssertUtil.isTrue(moduleMapper.updateByPrimaryKeySelective(module) < 1,"更新失败！");
    }

    /**
     * 删除菜单
     */
    public void deleteModule(Integer id) {
        /* 1.非空判断 */
        AssertUtil.isTrue(id == null,"待更新记录不存在！");
        Module temp = moduleMapper.selectByPrimaryKey(id);
        AssertUtil.isTrue(temp == null,"待更新记录不存在！");

        //判断当前资源是否存在子记录
        Integer count = moduleMapper.queryModuleCountByParentId(id);
        //如果存在则不可删除
        AssertUtil.isTrue(count > 0,"存在子记录，不可删除！");
        //查权限表是否有数据，若有则一并删除
        count = moduleMapper.queryPermissionCountById(id);
        if(count > 0){
            moduleMapper.deletePermissionById(id);
        }
        temp.setIsValid(0);
        temp.setUpdateDate(new Date());
        AssertUtil.isTrue(moduleMapper.updateByPrimaryKeySelective(temp) < 1,"删除失败！");
    }
}
