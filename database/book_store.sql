SET NAMES utf8mb4;
DROP DATABASE IF EXISTS book_store;
CREATE DATABASE book_store DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE book_store;

CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    real_name VARCHAR(50),
    email VARCHAR(100),
    role VARCHAR(20) NOT NULL DEFAULT 'USER',
    status VARCHAR(20) NOT NULL DEFAULT 'ENABLED',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE book (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(80) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    description VARCHAR(500),
    cover_url VARCHAR(500),
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cart (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_cart_user_book (user_id, book_id),
    CONSTRAINT fk_cart_user FOREIGN KEY (user_id) REFERENCES user(id),
    CONSTRAINT fk_cart_book FOREIGN KEY (book_id) REFERENCES book(id)
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_no VARCHAR(40) NOT NULL UNIQUE,
    user_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'SUBMITTED',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE order_item (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    book_title VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT fk_order_item_order FOREIGN KEY (order_id) REFERENCES orders(id),
    CONSTRAINT fk_order_item_book FOREIGN KEY (book_id) REFERENCES book(id)
);

INSERT INTO user(username, password, real_name, email, role) VALUES
('admin', '123456', '系统管理员', 'admin@classdemo.local', 'ADMIN'),
('user', '123456', '张三', 'user@classdemo.local', 'USER'),
('lisi', '123456', '李四', 'lisi@classdemo.local', 'USER');

INSERT INTO book(title, author, category, price, stock, description, cover_url) VALUES
('Java Web 程序设计', '王晓明', '计算机科学', 69.80, 35, '系统讲解 Servlet、JSP、Filter 与 MVC 开发流程，适合课程设计实践。', 'assets/img/book-java.svg'),
('MyBatis 从入门到实践', '陈晨', '数据库', 58.00, 28, '围绕 Mapper、动态 SQL、事务和连接池展开，适合 Java Web 后端开发。', 'assets/img/book-mybatis.svg'),
('软件设计模式', '刘洋', '系统设计', 72.50, 18, '用简洁案例讲解常用设计模式，帮助提升系统结构设计能力。', 'assets/img/book-pattern.svg'),
('数据库系统概论', '萨师煊', '数据库', 65.00, 22, '数据库基础理论、关系模型、SQL 与事务处理经典教材。', 'assets/img/book-db.svg'),
('算法导论精选', 'Thomas H. Cormen', '计算机科学', 88.00, 12, '覆盖排序、图论、动态规划等核心算法主题。', 'assets/img/book-algo.svg'),
('前端界面设计基础', '赵一鸣', '前端设计', 49.90, 40, '讲解布局、色彩、交互和响应式页面设计。', 'assets/img/book-ui.svg');

INSERT INTO orders(order_no, user_id, total_amount, status) VALUES
('OD202605250001', 2, 127.80, 'COMPLETED'),
('OD202605250002', 2, 72.50, 'SUBMITTED');

INSERT INTO order_item(order_id, book_id, book_title, price, quantity) VALUES
(1, 1, 'Java Web 程序设计', 69.80, 1),
(1, 2, 'MyBatis 从入门到实践', 58.00, 1),
(2, 3, '软件设计模式', 72.50, 1);
