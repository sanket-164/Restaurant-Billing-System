USE mysql;

CREATE DATABASE billing_system;

USE billing_system;

CREATE TABLE login(
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    user_role VARCHAR(255),
);

CREATE TABLE admin(
    admin_id INT(6) PRIMARY KEY,
    admin_uname VARCHAR(255) UNIQUE NOT NULL,
    admin_name VARCHAR(255) NOT NULL,
    admin_email VARCHAR(255) UNIQUE NOT NULL,
    admin_num VARCHAR(255) UNIQUE NOT NULL,
    admin_dob DATE
);

CREATE TABLE cashier(
    cashier_id INT(6) PRIMARY KEY,
    cashier_uname VARCHAR(255) UNIQUE NOT NULL,
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
    bill_id INT(6) PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    bill_amount DECIMAL(10,2) NOT NULL,
    bill_time DATETIME NOT NULL,
    cashier_id INT(6),
    FOREIGN KEY(cashier_id) REFERENCES cashier(cashier_id)
);

INSERT INTO food_item VALUES 
(106121, 'Khichadi', 'Gujarati', 80.00),
(106122, 'Sev Tameta Sak', 'Gujarati', 100.00),
(106123, 'Dal Bhat', 'Gujarati', 90.00),
(106124, 'Rotli', 'Gujarati', 15.00),
(206121, 'Paneer Tikka', 'Punjabi', 100.00),
(206122, 'Chhole Chana', 'Punajabi', 90.00),
(206123, 'Palak Paneer', 'Punjabi', 80.00),
(206124, 'Dal Makhani', 'Punjabi', 120.00),
(306121, 'Manchurian', 'Chinese', 80.00),
(306122, 'Fried Rice', 'Chinese', 60.00),
(306123, 'Noodles', 'Chinese', 70.00),
(306124, 'Soup', 'Chinese', 40.00),
(406121, 'Masala Dosa', 'South Indian', 60.00),
(406122, 'Uttapam', 'South Indian', 30.00),
(406123, 'Mendu Vada', 'South Indian', 30.00),
(406124, 'Idli Sambhar', 'South Indian', 50.00),
(506121, 'Pav Bhaji', 'Fast Food', 80.00),
(506122, 'Sandwhich', 'Fast Food', 60.00),
(506123, 'Vadapav', 'Fast Food', 25.00),
(506124, 'Alupuri', 'Fast Food', 20.00),
(666121, 'Chhas', 'Drinks', 15.00),
(666122, 'Pepsi', 'Drinks', 20.00),
(666123, 'Sprite', 'Drinks', 20.00),
(666124, 'Mazza', 'Drinks', 20.00);

INSERT INTO cashier VALUES (160380, 'sanket_164', 'Sanket Sadadiya', 'sanketsadadiya53@gmail.com', '7383409520', '2005-16-04');
INSERT INTO login VALUES('sanket_164', '12345678', 'Cashier');

INSERT INTO admin VALUES (160380, 'admin', 'Sanket Sadadiya', 'sanketsadadiya53@gmail.com', '7383409520', '2005-16-04');
INSERT INTO login VALUES('admin', 'adminadmin', 'Admin');