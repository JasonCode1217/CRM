package com.xxxx.crm.service;

import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.xxxx.crm.base.BaseService;
import com.xxxx.crm.dao.UserMapper;
import com.xxxx.crm.dao.UserRoleMapper;
import com.xxxx.crm.model.UserModel;
import com.xxxx.crm.utils.AssertUtil;
import com.xxxx.crm.utils.Md5Util;
import com.xxxx.crm.utils.PhoneUtil;
import com.xxxx.crm.utils.UserIDBase64;
import com.xxxx.crm.vo.User;
import com.xxxx.crm.vo.UserRole;
import org.apache.commons.lang3.StringUtils;
import org.omg.CORBA.INTERNAL;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class UserService extends BaseService<User,Integer> {
    @Resource
    private UserMapper userMapper;
    @Resource
    private UserRoleMapper userRoleMapper;

    /**
     * 用户登录
     * 1. 参数判断，判断用户姓名、用户密码非空弄
     *    如果参数为空，抛出异常（异常被控制层捕获并处理）
     * 2. 调用数据访问层，通过用户名查询用户记录，返回用户对象
     * 3. 判断用户对象是否为空
     *    如果对象为空，抛出异常（异常被控制层捕获并处理）
     * 4. 判断密码是否正确，比较客户端传递的用户密码与数据库中查询的用户对象中的用户密码
     *    如果密码不相等，抛出异常（异常被控制层捕获并处理）
     * 5. 如果密码正确，登录成功
     * @param userName
     * @param userPwd
     */
    public UserModel userLogin(String userName,String userPwd){
        //1. 参数判断，判断用户姓名、用户密码非空
        AssertUtil.isTrue(StringUtils.isBlank(userName),"用户名不能为空！");
        AssertUtil.isTrue(StringUtils.isBlank(userPwd),"密码不能为空！");

        //2. 调用数据访问层，通过用户名查询用户记录，返回用户对象
        User user = userMapper.queryByName(userName);

        //3. 判断用户对象是否为空
        AssertUtil.isTrue(null == user ,"该用户不存在！");

        //4. 判断密码是否正确，比较客户端传递的用户密码与数据库中查询的用户对象中的用户密码
        checkPwd(userPwd,user.getUserPwd());

        //5. 登录成功 返回并构建用户对象
        return createUserModel(user);

    }

    /**
     * 修改密码
     *  1. 通过用户ID查询用户记录，返回用户对象
     *  2. 参数校验
         *待更新用户记录是否存在 （用户对象是否为空）
         *判断原始密码是否为空
         *判断原始密码是否正确（查询的用户对象中的用户密码是否原始密码一致）
         *判断新密码是否为空
         *判断新密码是否与原始密码一致 （不允许新密码与原始密码）
         *判断确认密码是否为空
         *判断确认密码是否与新密码一致
     *  3. 设置用户的新密码
     *  需要将新密码通过指定算法进行加密（md5加密）
     *  4. 执行更新操作，判断受影响的行数
     * @param userId
     * @param oldPwd
     * @param newPwd
     * @param repeatPwd
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updatePassword(Integer userId,String oldPwd,String newPwd,String repeatPwd){
        //获取用户对象
        User user = userMapper.selectByPrimaryKey(userId);
        //密码参数校验
        checkPwdParams(user,oldPwd,newPwd,repeatPwd);
        //设置新密码
        user.setUserPwd(Md5Util.encode(newPwd));
        //执行更新，判断受影响行数
        AssertUtil.isTrue(userMapper.updateByPrimaryKeySelective(user)<1,"修改密码失败！");
    }

    /**
     * 查询所有销售人员
     * @return
     */
    public List<Map<String,Object>> queryAllSales(){
        return userMapper.queryAllSales();
    }

    /**
     * 添加用户信息
     * @param user
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void addUser(User user){
        /* 1.非空参数校验 */
        checkUserParams(user.getUserName(),user.getTrueName(),user.getEmail(),user.getPhone(),null);
        /* 2.设置默认值 */
        user.setUserPwd(Md5Util.encode("888888"));
        user.setIsValid(1);
        user.setCreateDate(new Date());
        user.setUpdateDate(new Date());
        /* 3.执行添加操作 */
        AssertUtil.isTrue(userMapper.insertSelective(user) < 1,"添加失败！");
        /* 4.用户角色关联 */
        userRoleRelation(user.getId(),user.getRoleIds());
    }

    /**
     * 删除用户信息
     * @param ids
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteBatchByIds(Integer[] ids){
        AssertUtil.isTrue(ids == null||ids.length == 0,"待删记录不存在！");
        AssertUtil.isTrue(userMapper.deleteBatch(ids) != ids.length,"删除失败！");

        //遍历用户id数组，删除角色关联
        for (Integer id : ids) {
            Integer count = userRoleMapper.countUserRoleByUserId(id);
            if(count > 0){
                AssertUtil.isTrue(userRoleMapper.deleteUserRoleByUserId(id) != count,"删除失败！");
            }
        }
    }

    /**
     * 用户角色关联
     * @param id
     * @param roleIds
     */
    private void userRoleRelation(Integer id, String roleIds) {
        //查询角色记录条数
        Integer count = userRoleMapper.countUserRoleByUserId(id);
        if(count >0 ){
            //角色记录存在，删除原角色记录
            AssertUtil.isTrue(userRoleMapper.deleteUserRoleByUserId(id) != count,"用户角色关联失败！");
        }
        //判断前端传来的角色id是否存在（roleIds），若存在，则添加该用户对应的角色记录
        if(StringUtils.isNotBlank(roleIds)){
            List<UserRole> userRoleList = new ArrayList<>();
            //将roleIds转成字符串
            String[] roleIdsArray = roleIds.split(",");
            for (String roleId : roleIdsArray) {
                UserRole userRole = new UserRole();
                userRole.setRoleId(Integer.parseInt(roleId));
                userRole.setUserId(id);
                userRole.setCreateDate(new Date());
                userRole.setUpdateDate(new Date());
                //将角色记录设置到集合中
                userRoleList.add(userRole);
            }
            //批量添加用户角色记录
            AssertUtil.isTrue(userRoleMapper.insertBatch(userRoleList) != userRoleList.size(),"用户角色关联失败！");
        }
    }


    /**
     * 修改用户信息
     * @param user
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateUser(User user){
        /* 1.参数非空校验 */
        AssertUtil.isTrue(user.getId() == null,"待更新记录不存在！");
        User temp = userMapper.selectByPrimaryKey(user.getId());
        AssertUtil.isTrue(temp == null,"待更新记录不存在！");
        checkUserParams(user.getUserName(),user.getTrueName(),user.getEmail(),user.getPhone(),temp.getId());
        /* 2.设置默认值 */
        user.setUpdateDate(new Date());
        /* 3.执行修改操作 */
        AssertUtil.isTrue(userMapper.updateByPrimaryKeySelective(user) != 1,"修改失败！");
        /* 4.用户角色关联 */
        userRoleRelation(user.getId(),user.getRoleIds());
    }


    /**
     * 新旧密码参数校验
     * @param user
     * @param oldPwd
     * @param newPwd
     * @param repeatPwd
     */
    private void checkPwdParams(User user, String oldPwd, String newPwd, String repeatPwd) {
        AssertUtil.isTrue(StringUtils.isBlank(oldPwd),"原始密码不能为空！");
        AssertUtil.isTrue(!(user.getUserPwd().equals(Md5Util.encode(oldPwd))),"原始密码错误！");
        AssertUtil.isTrue(StringUtils.isBlank(newPwd),"新密码不能为空！");
        AssertUtil.isTrue(newPwd.equals(oldPwd),"新密码不能和原始密码相同！");
        AssertUtil.isTrue(StringUtils.isBlank(repeatPwd),"确认密码不能为空！");
        AssertUtil.isTrue(!newPwd.equals(repeatPwd),"两次输入的密码不一致！");
    }

    /**
     * 将返回的对象存入到一个model中
     * @param user
     * @return
     */
    private UserModel createUserModel(User user) {
        UserModel userModel = new UserModel();
        //对id进行加密
        userModel.setUserSid(UserIDBase64.encoderUserID(user.getId()));
        userModel.setUserName(user.getUserName());
        userModel.setTrueName(user.getTrueName());
        return userModel;
    }

    /**
     * 比较客户端传递的用户密码与数据库中查询的用户对象中的用户密码
     *         由于在实际开发中存到数据库中的密码都是经过加密处理的
     *         因此这里从前端获取的密码需要先经过加密再与数据库中的
     *         密码作比较
     * @param userPwd
     * @param pwd
     */
    public void checkPwd(String userPwd,String pwd){
        userPwd = Md5Util.encode(userPwd);
        AssertUtil.isTrue(!userPwd.equals(pwd),"密码错误！");
    }

    /**
     * 用户信息非空校验
     * @param userName
     * @param trueName
     * @param email
     * @param phone
     */
    private void checkUserParams(String userName, String trueName, String email, String phone,Integer id) {
        AssertUtil.isTrue(StringUtils.isBlank(userName),"用户名不能为空！");
        User temp = userMapper.queryByName(userName);
        AssertUtil.isTrue(temp != null && !(temp.getId().equals(id)),"用户名已存在，请重新输入！");
        AssertUtil.isTrue(StringUtils.isBlank(trueName),"真实姓名不能为空！");
        AssertUtil.isTrue(StringUtils.isBlank(email),"邮箱不能为空！");
        AssertUtil.isTrue(StringUtils.isBlank(phone),"电话不能为空！");
        AssertUtil.isTrue(!PhoneUtil.isMobile(phone),"电话格式有误！");
    }

    /**
     * 查询所有的客户经理
     *
     * @param
     * @return java.util.List<java.util.Map<java.lang.String,java.lang.Object>>
     */
    public List<Map<String, Object>> queryAllCustomerManagers() {
        return userMapper.queryAllCustomerManagers();
    }
}
