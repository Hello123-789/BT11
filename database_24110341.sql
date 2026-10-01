

DROP DATABASE IF EXISTS web_de05_24110341;
CREATE DATABASE web_de05_24110341 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE web_de05_24110341;

-- 1. BẢNG UserRoles
CREATE TABLE UserRoles (
    roleId INT AUTO_INCREMENT PRIMARY KEY,
    roleName VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- 2. BẢNG Seller (Các thương hiệu / nhà phân phối cầu lông)
CREATE TABLE Seller (
    sellerId INT AUTO_INCREMENT PRIMARY KEY,
    sellername VARCHAR(50) NOT NULL,
    images VARCHAR(500),
    status INT DEFAULT 1
) ENGINE=InnoDB;

-- 3. BẢNG Users
CREATE TABLE Users (
    userId INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    fullname VARCHAR(50),
    password VARCHAR(50) NOT NULL,
    images VARCHAR(500),
    phone VARCHAR(20),
    status INT DEFAULT 0, -- 0: Chưa kích hoạt OTP, 1: Đã kích hoạt
    code VARCHAR(50),     -- Lưu mã OTP
    roleId INT,
    sellerId INT NULL,
    CONSTRAINT fk_users_role FOREIGN KEY (roleId) REFERENCES UserRoles(roleId) ON DELETE SET NULL,
    CONSTRAINT fk_users_seller FOREIGN KEY (sellerId) REFERENCES Seller(sellerId) ON DELETE SET NULL
) ENGINE=InnoDB;

-- 4. BẢNG Category (Danh mục sản phẩm)
CREATE TABLE Category (
    categoryId INT AUTO_INCREMENT PRIMARY KEY,
    categoryName VARCHAR(200) NOT NULL,
    images VARCHAR(500),
    status INT DEFAULT 1
) ENGINE=InnoDB;

-- 5. BẢNG Product (Kho sản phẩm vợt, giày, phụ kiện cầu lông)
CREATE TABLE Product (
    productId INT AUTO_INCREMENT PRIMARY KEY,
    productName VARCHAR(200) NOT NULL,
    productCode BIGINT,
    categoryId INT,
    description VARCHAR(500),
    price DOUBLE DEFAULT 0,
    amount INT DEFAULT 0,
    stock INT DEFAULT 0,
    images VARCHAR(500),
    wishlist INT DEFAULT 0,
    status INT DEFAULT 1,
    createDate DATE,
    sellerId INT,
    CONSTRAINT fk_product_category FOREIGN KEY (categoryId) REFERENCES Category(categoryId) ON DELETE SET NULL,
    CONSTRAINT fk_product_seller FOREIGN KEY (sellerId) REFERENCES Seller(sellerId) ON DELETE SET NULL
) ENGINE=InnoDB;

-- 6. BẢNG Cart (Hỗ trợ quản lý đơn hàng & Thanh toán COD)
CREATE TABLE Cart (
    cartId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NULL,
    buyDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    status INT DEFAULT 1, -- 1: Chờ xử lý / Đã đặt hàng COD, 0: Đã hủy, 2: Đang giao, 3: Hoàn thành
    receiverName VARCHAR(100),
    receiverPhone VARCHAR(20),
    address VARCHAR(500),
    note VARCHAR(500),
    paymentMethod VARCHAR(50) DEFAULT 'COD',
    totalMoney DOUBLE DEFAULT 0,
    CONSTRAINT fk_cart_user FOREIGN KEY (userId) REFERENCES Users(userId) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 7. BẢNG CartItem
CREATE TABLE CartItem (
    cartItemId INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT DEFAULT 1,
    unitPrice DOUBLE DEFAULT 0,
    productId INT,
    cartId INT,
    CONSTRAINT fk_cartitem_product FOREIGN KEY (productId) REFERENCES Product(productId) ON DELETE CASCADE,
    CONSTRAINT fk_cartitem_cart FOREIGN KEY (cartId) REFERENCES Cart(cartId) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Thêm Roles
INSERT INTO UserRoles (roleId, roleName) VALUES 
(1, 'ADMIN'),
(2, 'SELLER'),
(3, 'USER');

-- Thêm Sellers (Các thương hiệu đại diện)
INSERT INTO Seller (sellerId, sellername, images, status) VALUES 
(1, 'Yonex Official Store', 'uploads/yonex.jpg', 1),
(2, 'Victor Sport Store', 'uploads/victor.png', 1),
(3, 'Li-Ning Badminton Store', 'uploads/lining.jpg', 1),
(4, 'Mizuno Pro Shop', 'uploads/mizuno.jpg', 1);

-- Thêm Users (Tất cả mật khẩu mặc định là 123456)
INSERT INTO Users (userId, username, email, fullname, password, images, phone, status, code, roleId, sellerId) VALUES 
(1, 'admin', 'admin@example.com', 'Quản trị viên', '123456', 'images/athletes/axelsen.jpg', '0901234567', 1, NULL, 1, NULL),
(2, 'seller1', 'yonex@example.com', 'Yonex Store Manager', '123456', 'images/athletes/axelsen.jpg', '0902345678', 1, NULL, 2, 1),
(3, 'seller2', 'victor@example.com', 'Victor Store Manager', '123456', 'images/athletes/lee-zii-jia.jpg', '0903456789', 1, NULL, 2, 2),
(4, 'seller3', 'lining@example.com', 'Li-Ning Store Manager', '123456', 'images/athletes/shi-yu-qi.jpg', '0904567890', 1, NULL, 2, 3),
(5, 'seller4', 'mizuno@example.com', 'Mizuno Store Manager', '123456', 'images/athletes/an-se-young.jpg', '0905678901', 1, NULL, 2, 4),
(6, 'user', 'user@example.com', 'Khách hàng Thân Thiết', '123456', 'images/athletes/an-se-young.jpg', '0906789012', 1, NULL, 3, NULL),
(7, 'user1', 'user1@ute.edu.vn', 'Nguyễn Văn Cầu Lông', '123456', 'images/athletes/axelsen.jpg', '0907890123', 1, NULL, 3, NULL);

-- Thêm Categories
INSERT INTO Category (categoryId, categoryName, images, status) VALUES 
(1, 'Vợt cầu lông', 'images/uploads/astrox100zz.jpg', 1),
(2, 'Phụ kiện', 'images/uploads/ac102ex.jpg', 1),
(3, 'Giày cầu lông', 'images/uploads/65z3.jpg', 1);

-- Thêm Products (32 sản phẩm vợt, giày và phụ kiện từ project mẫu)
INSERT INTO Product (productName, productCode, categoryId, description, price, amount, stock, images, wishlist, status, createDate, sellerId) VALUES 

-- 1. VỢT CẦU LÔNG (categoryId = 1)
('Yonex Astrox 100 ZZ', 1001, 1, 'Vợt cầu lông cao cấp Yonex Astrox 100 ZZ.', 4500000, 10, 100, 'images/uploads/astrox100zz.jpg', 25, 1, '2026-09-01', 1),
('Yonex Astrox 88D Pro', 1002, 1, 'Vợt cầu lông Yonex Astrox 88D Pro.', 4200000, 12, 80, 'images/uploads/astrox88dpro.jpg', 18, 1, '2026-09-02', 1),
('Yonex Astrox 88S Pro', 1003, 1, 'Vợt cầu lông Yonex Astrox 88S Pro.', 4100000, 10, 75, 'images/uploads/astrox88spro.jpg', 15, 1, '2026-09-03', 1),
('Yonex Nanoflare 1000 Z', 1004, 1, 'Vợt cầu lông tốc độ cao Yonex Nanoflare 1000 Z.', 4600000, 8, 50, 'images/uploads/nanoflare1000z.jpg', 30, 1, '2026-09-04', 1),
('Yonex Nanoflare 800 Pro', 1005, 1, 'Vợt cầu lông Yonex Nanoflare 800 Pro.', 3900000, 15, 90, 'images/uploads/nanoflare800pro.jpg', 12, 1, '2026-09-05', 1),
('Yonex Arcsaber 11 Pro', 1006, 1, 'Vợt cầu lông Yonex Arcsaber 11 Pro.', 4000000, 10, 60, 'images/uploads/arcsaber11pro.jpg', 22, 1, '2026-09-06', 1),
('Yonex Duora Z Strike', 1007, 1, 'Vợt cầu lông Yonex Duora Z Strike.', 3400000, 7, 40, 'images/uploads/duorazstrike.jpg', 14, 1, '2026-09-07', 1),
('Yonex Voltric Z Force II', 1008, 1, 'Vợt cầu lông Yonex Voltric Z Force II.', 3700000, 6, 35, 'images/uploads/voltriczforce2.jpg', 28, 1, '2026-09-08', 1),

('Victor Thruster Ryuga II', 2001, 1, 'Vợt cầu lông Victor Thruster Ryuga II.', 3800000, 9, 65, 'images/uploads/ryuga2.jpg', 35, 1, '2026-09-09', 2),
('Victor Auraspeed 100X', 2002, 1, 'Vợt cầu lông Victor Auraspeed 100X.', 3600000, 11, 70, 'images/uploads/auraspeed100x.jpg', 19, 1, '2026-09-10', 2),
('Victor Auraspeed 90K', 2003, 1, 'Vợt cầu lông Victor Auraspeed 90K.', 3500000, 14, 80, 'images/uploads/auraspeed90k.jpg', 16, 1, '2026-09-11', 2),
('Victor Thruster K Falcon', 2004, 1, 'Vợt cầu lông Victor Thruster K Falcon.', 3200000, 10, 55, 'images/uploads/thrusterkfalcon.jpg', 11, 1, '2026-09-12', 2),
('Victor DriveX 9X', 2005, 1, 'Vợt cầu lông Victor DriveX 9X.', 3000000, 15, 60, 'images/uploads/drivex9x.jpg', 13, 1, '2026-09-13', 2),
('Victor Auraspeed 80X', 2006, 1, 'Vợt cầu lông Victor Auraspeed 80X.', 2900000, 10, 50, 'images/uploads/auraspeed80x.jpg', 8, 1, '2026-09-14', 2),

('Li-Ning Axforce 100', 3001, 1, 'Vợt cầu lông Li-Ning Axforce 100.', 4300000, 8, 45, 'images/uploads/axforce100.jpg', 40, 1, '2026-09-15', 3),
('Li-Ning Axforce 80', 3002, 1, 'Vợt cầu lông Li-Ning Axforce 80.', 3900000, 10, 70, 'images/uploads/axforce80.jpg', 24, 1, '2026-09-16', 3),
('Li-Ning Axforce 75', 3003, 1, 'Vợt cầu lông Li-Ning Axforce 75.', 3700000, 12, 60, 'images/uploads/axforce75.jpg', 17, 1, '2026-09-17', 3),
('Li-Ning Tectonic 9', 3004, 1, 'Vợt cầu lông Li-Ning Tectonic 9.', 3500000, 9, 50, 'images/uploads/tectonic9.jpg', 21, 1, '2026-09-18', 3),

('Mizuno Fortius 11 Power', 4001, 1, 'Vợt cầu lông Mizuno Fortius 11 Power.', 3300000, 10, 55, 'images/uploads/fortius11power.jpg', 15, 1, '2026-09-19', 4),
('Mizuno Fortius 10 Power', 4002, 1, 'Vợt cầu lông Mizuno Fortius 10 Power.', 3100000, 12, 65, 'images/uploads/fortius10power.jpg', 10, 1, '2026-09-20', 4),

-- 2. GIÀY CẦU LÔNG (categoryId = 3)
('Yonex Power Cushion 65 Z3', 1009, 3, 'Giày cầu lông Yonex Power Cushion 65 Z3.', 3200000, 10, 120, 'images/uploads/65z3.jpg', 38, 1, '2026-09-21', 1),
('Yonex Power Cushion 88 Dial', 1010, 3, 'Giày cầu lông Yonex Power Cushion 88 Dial.', 3500000, 8, 90, 'images/uploads/88dial.jpg', 29, 1, '2026-09-22', 1),
('Victor P9200 III', 2007, 3, 'Giày cầu lông Victor P9200 III.', 3000000, 10, 80, 'images/uploads/p9200iii.jpg', 20, 1, '2026-09-23', 2),
('Victor A970 Nitro Lite', 2008, 3, 'Giày cầu lông Victor A970 Nitro Lite.', 2800000, 12, 75, 'images/uploads/a970.jpg', 18, 1, '2026-09-24', 2),
('Li-Ning Ranger Lite', 3005, 3, 'Giày cầu lông Li-Ning Ranger Lite.', 2200000, 10, 85, 'images/uploads/rangerlite.jpg', 14, 1, '2026-09-25', 3),
('Mizuno Wave Claw Neo', 4003, 3, 'Giày cầu lông Mizuno Wave Claw Neo.', 2900000, 8, 60, 'images/uploads/waveclawneo.jpg', 16, 1, '2026-09-26', 4),

-- 3. PHỤ KIỆN (categoryId = 2)
('Yonex AC102EX Power Cushion Grip', 1011, 2, 'Quấn cán vợt Yonex AC102EX.', 80000, 50, 500, 'images/uploads/ac102ex.jpg', 60, 1, '2026-09-27', 1),
('Yonex Aerosensa 50', 1012, 2, 'Cầu lông Yonex Aerosensa 50.', 650000, 30, 200, 'images/uploads/aerosensa50.jpg', 45, 1, '2026-09-28', 1),
('Yonex AC110EX Towel Grip', 1013, 2, 'Quấn cán khăn Yonex AC110EX.', 90000, 40, 300, 'images/uploads/ac110ex.jpg', 25, 1, '2026-09-29', 1),
('Victor GR262', 2009, 2, 'Quấn cán Victor GR262.', 70000, 45, 350, 'images/uploads/gr262.jpg', 20, 1, '2026-09-30', 2),
('Li-Ning GP20', 3006, 2, 'Quấn cán vợt Li-Ning GP20.', 75000, 40, 400, 'images/uploads/gp20.jpg', 22, 1, '2026-10-01', 3),
('Yonex 3D Power Cushion Socks', 1014, 2, 'Vớ cầu lông Yonex 3D Power Cushion.', 120000, 35, 250, 'images/uploads/powersocks.jpg', 30, 1, '2026-10-02', 1);
