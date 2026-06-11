# classDemo 网上书城系统

`classDemo` 是一个 Java Web 课程设计项目，实现了一个简洁现代风格的网上书城系统。项目包含普通用户端和管理员后台，覆盖图书浏览、购物车、下单、订单查看、图书管理、订单管理、用户管理和权限控制等功能。

## 项目特点

- 采用 MVC 分层架构，结构清晰，便于课程报告说明和后续维护。
- 使用 Servlet + JSP + JSTL 实现页面跳转和数据展示。
- 使用 MyBatis XML Mapper 完成数据库 CRUD。
- 使用 Druid 数据库连接池管理 MySQL 连接。
- 前端页面基于 Stitch 生成的简洁高级风界面改造成 JSP 动态页面。
- 使用 Filter 实现登录拦截、管理员权限拦截和 UTF-8 编码处理。

## 技术栈

- JDK 8
- Maven 3.9+
- Apache Tomcat 9
- Servlet 4.0
- JSP / JSTL
- MyBatis 3.5
- Druid 连接池
- MySQL 8
- HTML / Tailwind CSS / Material Symbols

## 功能模块

### 普通用户端

- 用户登录
- 图书列表浏览
- 按书名、作者搜索
- 按分类筛选图书
- 加入购物车
- 修改购物车商品数量
- 删除购物车商品
- 提交订单
- 查看我的订单和订单明细

### 管理员后台

- 后台首页统计
- 查看书籍总数、订单总数、用户总数、今日订单
- 低库存图书预警
- 图书新增、编辑、删除、查询
- 订单列表查看
- 按订单状态筛选
- 修改订单状态
- 用户列表查看

## 目录结构

```text
classDemo
├── database
│   └── book_store.sql
├── src/main/java/cn/gzu/classdemo
│   ├── controller
│   ├── dao
│   ├── entity
│   ├── filter
│   ├── service
│   └── util
├── src/main/resources
│   ├── mapper
│   ├── jdbc.properties
│   ├── druid.properties
│   └── mybatis-config.xml
├── src/main/webapp
│   ├── WEB-INF/jsp
│   ├── assets
│   └── index.jsp
└── pom.xml
```

## 数据库初始化

MySQL 默认配置：

- 用户名：`root`
- 密码：空
- 数据库名：`book_store`

执行脚本：

```bash
mysql --default-character-set=utf8mb4 -uroot < database/book_store.sql
```

脚本会自动创建数据库、数据表，并插入测试用户、图书和订单数据。

## 运行方式

1. 打包项目：

```bash
mvn clean package
```

2. 将生成的 WAR 包部署到 Tomcat 9：

```text
target/classDemo.war
```

3. 浏览器访问：

```text
http://localhost:8080/classDemo
```

## 测试账号

管理员账号：

```text
用户名：admin
密码：123456
```

普通用户账号：

```text
用户名：user
密码：123456
```

登录后系统会根据数据库中的用户角色自动跳转到对应页面。

## DeepSeek AI 客服

用户端书籍、购物车和订单页面提供右下角 AI 客服，可根据当前数据库书目回答图书推荐、价格、库存和购物流程问题。

API Key 不写入源码。启动 Tomcat 前设置以下环境变量：

```text
DEEPSEEK_API_KEY=你的 DeepSeek API Key
```

可选模型配置：

```text
DEEPSEEK_MODEL=deepseek-chat
```

在 Eclipse 中可以打开 Tomcat 的启动配置，在 `Environment` 中添加上述变量；也可以通过 Tomcat 的 `bin/setenv.bat` 设置。修改后需要彻底重启 Tomcat。

## 课程设计对应内容

本项目对应实验报告中的“网上书城系统”，覆盖 Maven 项目管理、Tomcat 部署、MVC 分层开发、MyBatis 数据库访问、Druid 连接池、权限过滤、前后端页面交互和 CRUD 功能实现等要求。
