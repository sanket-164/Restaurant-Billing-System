USE mysql;

CREATE DATABASE billing_system;

USE billing_system;

CREATE TABLE login(
    username VARCHAR(255) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    user_role VARCHAR(255)
);

CREATE TABLE admin(
    admin_uname VARCHAR(255) PRIMARY KEY,
    admin_name VARCHAR(255) NOT NULL,
    admin_email VARCHAR(255) UNIQUE NOT NULL,
    admin_num VARCHAR(255) UNIQUE NOT NULL,
    admin_dob DATE
);

CREATE TABLE cashier(
    cashier_uname VARCHAR(255) PRIMARY KEY,
    cashier_name VARCHAR(255) NOT NULL,
    cashier_email VARCHAR(255) UNIQUE NOT NULL,
    cashier_num VARCHAR(255) UNIQUE NOT NULL,
    cashier_dob DATE
);

CREATE TABLE food_item (
    food_id INT(6) PRIMARY KEY,
    food_name VARCHAR(255) NOT NULL,
    food_category VARCHAR(255) NOT NULL,
    food_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE bills(
    bill_id INT(6) PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(255) NOT NULL,
    customer_num INT(12) NOT NULL,
    bill_amount DECIMAL(10,2) NOT NULL,
    bill_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    cashier_uname VARCHAR(255) NOT NULL
);

INSERT INTO food_item VALUES 
(106121, 'Khichadi', 'Gujarati', 80.00),
(106122, 'Sev Tameta Sak', 'Gujarati', 100.00),
(106123, 'Dal Bhat', 'Gujarati', 90.00),
(106124, 'Rotli', 'Gujarati', 15.00),
(306121, 'Manchurian', 'Chinese', 80.00),
(306122, 'Fried Rice', 'Chinese', 60.00),
(306123, 'Noodles', 'Chinese', 70.00),
(306124, 'Soup', 'Chinese', 40.00),
(506121, 'Pav Bhaji', 'Fast Food', 80.00),
(506122, 'Sandwhich', 'Fast Food', 60.00),
(506123, 'Vadapav', 'Fast Food', 25.00),
(506124, 'Alupuri', 'Fast Food', 20.00),
(666121, 'Chhas', 'Drinks', 15.00),
(666122, 'Pepsi', 'Drinks', 20.00),
(666123, 'Sprite', 'Drinks', 20.00),
(666124, 'Mazza', 'Drinks', 20.00);

INSERT INTO cashier VALUES ('sanket_164', 'Sanket Sadadiya', 'sanketsadadiya53@gmail.com', '7383409520', '2005-16-04');
INSERT INTO login VALUES('sanket_164', '12345678', 'Cashier');

INSERT INTO admin VALUES ('admin', 'Sanket Sadadiya', 'sanketsadadiya53@gmail.com', '7383409520', '2005-16-04');
INSERT INTO login VALUES('admin', 'adminadmin', 'Admin');

INSERT INTO bills (customer_name, customer_num, bill_amount, cashier_uname) VALUES ('Sanket Sadadiya', 123456789, 500.00, 'sanket_164');