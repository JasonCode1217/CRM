# CRM
管理公司与客户之间的关系。本系统旨在协调企业与顾客间在销售、营销和服务上的交互，从而提升其管理方式，向客户提供创新式的个性化的客户交互和服务的过程。 
# 系统架构
Spring+SpringMVC+Mybatis+SpringBoot+Mysql8+LayUI
#开发环境
JDK1.8、IDEA、MySql8
# 使用需知
1.首先在本地导入crm_sql中的.sql文件，生成数据库所需要的的各种表
2.由于本项目之前是打成war包在Linux系统上部署的，若要在idea中运行，需在pom文件中将部分与war包相关的注释掉，同时在application.yml文件中将运行版本改为dev
3.运行项目
4.登录模块用户密码在数据库中已加密，默认密码是888888
