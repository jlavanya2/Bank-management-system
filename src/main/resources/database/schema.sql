-- Create database
CREATE DATABASE IF NOT EXISTS bank_schema;
USE bank_schema;

-- Drop tables if they exist
DROP TABLE IF EXISTS transaction_history;
DROP TABLE IF EXISTS cardless_withdrawl;
DROP TABLE IF EXISTS bank_account;
DROP TABLE IF EXISTS card;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS login_account;
DROP TABLE IF EXISTS client;

-- Create tables with proper constraints
CREATE TABLE client (
    client_id INT NOT NULL AUTO_INCREMENT,
    f_name VARCHAR(45) NOT NULL,
    l_name VARCHAR(45) NOT NULL,
    father_name VARCHAR(45) NOT NULL,
    mother_name VARCHAR(45) NOT NULL,
    CNIC VARCHAR(45) NOT NULL UNIQUE,
    DOB DATE NOT NULL,
    phone VARCHAR(45) NOT NULL,
    email VARCHAR(45),
    address VARCHAR(100) NOT NULL,
    PRIMARY KEY (client_id)
) ENGINE=InnoDB AUTO_INCREMENT=10000;

CREATE TABLE login_account (
    login_id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(45) NOT NULL UNIQUE,
    password CHAR(8) NOT NULL,
    type CHAR(1) NOT NULL CHECK (type IN ('C', 'M', 'A')),
    PRIMARY KEY (login_id)
) ENGINE=InnoDB AUTO_INCREMENT=60000;

CREATE TABLE employee (
    employee_id INT NOT NULL AUTO_INCREMENT,
    f_name VARCHAR(45) NOT NULL,
    l_name VARCHAR(45) NOT NULL,
    father_name VARCHAR(45) NOT NULL,
    mother_name VARCHAR(45) NOT NULL,
    job VARCHAR(45) NOT NULL,
    phone_no VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL,
    login_id INT,
    PRIMARY KEY (employee_id),
    FOREIGN KEY (login_id) REFERENCES login_account(login_id)
) ENGINE=InnoDB AUTO_INCREMENT=20000;

CREATE TABLE card (
    card_num INT NOT NULL AUTO_INCREMENT,
    type CHAR(1) NOT NULL CHECK (type IN ('C', 'D')),
    Status CHAR(1) NOT NULL CHECK (Status IN ('A', 'B')),
    Pin_code CHAR(4) NOT NULL,
    Issue_date DATE NOT NULL,
    PRIMARY KEY (card_num)
) ENGINE=InnoDB AUTO_INCREMENT=40000;

CREATE TABLE bank_account (
    acc_num INT NOT NULL AUTO_INCREMENT,
    client_id INT NOT NULL,
    login_id INT,
    type VARCHAR(10) NOT NULL CHECK (type IN ('Current', 'Saving')),
    balance INT NOT NULL DEFAULT 0,
    status INT NOT NULL DEFAULT 1,
    opening_date DATE NOT NULL,
    closing_date DATE,
    card_num INT,
    PRIMARY KEY (acc_num),
    FOREIGN KEY (client_id) REFERENCES client(client_id),
    FOREIGN KEY (login_id) REFERENCES login_account(login_id),
    FOREIGN KEY (card_num) REFERENCES card(card_num)
) ENGINE=InnoDB AUTO_INCREMENT=500000;

CREATE TABLE transaction_history (
    serial_no INT NOT NULL AUTO_INCREMENT,
    amount INT NOT NULL,
    type VARCHAR(45) NOT NULL,
    date DATE NOT NULL,
    time VARCHAR(45) NOT NULL,
    account_num INT NOT NULL,
    recv_acc_num INT,
    cheque_num INT,
    PRIMARY KEY (serial_no),
    FOREIGN KEY (account_num) REFERENCES bank_account(acc_num),
    FOREIGN KEY (recv_acc_num) REFERENCES bank_account(acc_num)
) ENGINE=InnoDB AUTO_INCREMENT=70000;

CREATE TABLE cardless_withdrawl (
    serial_no INT NOT NULL AUTO_INCREMENT,
    card_no INT NOT NULL,
    amount INT NOT NULL,
    OTC VARCHAR(13) NOT NULL,
    temp_pin CHAR(4) NOT NULL,
    Status CHAR(1) NOT NULL CHECK (Status IN ('P', 'C')),
    date DATE,
    time VARCHAR(45),
    PRIMARY KEY (serial_no),
    FOREIGN KEY (card_no) REFERENCES card(card_num)
) ENGINE=InnoDB AUTO_INCREMENT=80000;

-- Insert sample data
-- Manager
INSERT INTO login_account VALUES (NULL, 'nasir55', '122221', 'M');
INSERT INTO employee VALUES (NULL, 'Nasir', 'Saeed', 'Saaed Yonus', 'Sara Naeem', 'Manager', '03908967581', 'nasir_saeed2311@gmail.com', LAST_INSERT_ID());

-- Accountant
INSERT INTO login_account VALUES (NULL, 'faizan211', '909094', 'A');
INSERT INTO employee VALUES (NULL, 'Faizan', 'Raheem', 'Raheem Aslam', 'Asma Javeed', 'Accountant', '03778234199', 'faizan0045@gmail.com', LAST_INSERT_ID());

-- Sample Clients
INSERT INTO client VALUES 
(NULL, 'Ahmed', 'Ali', 'Zubair Ali', 'Ayesha Khan', '67153-7853257-8', '1999-09-17', '03787817865', 'ahmedali987@gmail.com', 'House No. 412, Street 7, Fasil Colony, Rawalpindi'),
(NULL, 'Maria', 'Yasir', 'Sohail Jameel', 'Faiza Saleem', '78342-0978912-8', '1995-03-21', '03569899631', 'maria_y03@gmail.com', 'House No. 112, Street 3B, Block 2, DHA Islamabad'),
(NULL, 'Daniel', 'Zaid', 'Zaid Bilal', 'Saba Tahir', '43210-7809821-1', '1995-11-07', '03665132497', 'danielzahid909@gmail.com', 'House No. 8, Street 12, Ramzan Colony, Rawalpindi');

-- Client Login Accounts
INSERT INTO login_account VALUES 
(NULL, 'ahmed107', 'tom891', 'C'),
(NULL, 'maria_y70', 'green8', 'C'),
(NULL, 'daniel345', '90jeep', 'C');

-- Cards
INSERT INTO card VALUES
(NULL, 'C', 'A', '8947', CURDATE()),
(NULL, 'D', 'A', '3921', CURDATE());

-- Bank Accounts
INSERT INTO bank_account VALUES
(NULL, 10000, 60002, 'Current', 1000, 1, CURDATE(), NULL, 40000),
(NULL, 10001, 60003, 'Current', 20000, 1, CURDATE(), NULL, 40001),
(NULL, 10002, 60004, 'Saving', 7000, 1, CURDATE(), NULL, NULL);

-- Sample Transactions
INSERT INTO transaction_history VALUES
(NULL, 1500, 'withdraw', CURDATE(), CURRENT_TIME(), 500000, NULL, NULL),
(NULL, 2000, 'deposit', CURDATE(), CURRENT_TIME(), 500000, NULL, 7856459),
(NULL, 5000, 'deposit', CURDATE(), CURRENT_TIME(), 500000, NULL, NULL),
(NULL, 1500, 'transfer', CURDATE(), CURRENT_TIME(), 500001, 500000, NULL),
(NULL, 1000, 'withdraw', CURDATE(), CURRENT_TIME(), 500001, NULL, NULL),
(NULL, 1800, 'withdraw', CURDATE(), CURRENT_TIME(), 500002, NULL, NULL),
(NULL, 1200, 'deposit', CURDATE(), CURRENT_TIME(), 500002, NULL, 1674534); 