# classDemo 网上书城系统

Java Web 课设项目，使用 Maven、Servlet、JSP、MyBatis、Druid、MySQL 实现网上书城系统。

## 技术栈

- JDK 8
- Maven 3.9+
- Tomcat 9
- Servlet 4.0 / JSP / JSTL
- MyBatis 3.5
- Druid 连接池
- MySQL 8

## 功能

- 普通用户：登录、浏览书籍、搜索筛选、加入购物车、修改数量、提交订单、查看订单。
- 管理员：后台统计、书籍增删改查、订单管理、用户管理。
- 权限控制：未登录拦截、管理员路径角色拦截、UTF-8 编码过滤。

## 数据库

MySQL 用户名为 `root`，密码为空。数据库脚本位于 `database/book_store.sql`。

```bash
mysql -uroot < database/book_store.sql
```

## 运行

```bash
mvn clean package
```

将 `target/classDemo.war` 部署到 Tomcat 9，访问：

```text
http://localhost:8080/classDemo
```

测试账号：

- 管理员：`admin` / `123456`
- 普通用户：`user` / `123456`

