create database luyenTapTongHop;
use luyenTapTongHop ;

create table Category (
id int auto_increment primary key ,
name varchar(100) not null unique ,
status tinyint(1) default 1
);

create table Room (
id int auto_increment primary key ,
name varchar(150) not null ,
index(name),
status Tinyint (1) default 1 ,
price float not null check (price >= 100000) ,
index(price),
salePrice float default 0 ,
check(salePrice <= price),
createdDate date default (now()),
categoryId int not null , 
foreign key (categoryId) references Category(id)
);

CREATE TABLE Customer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(50) NOT NULL UNIQUE,
    address VARCHAR(255),
    createdDate timestamp DEFAULT current_timestamp,
    gender TINYINT NOT NULL CHECK (Gender IN (0, 1, 2)),
    birthDay timestamp NOT NULL
);

CREATE TABLE Booking (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    customerId INT NOT NULL,
    status TINYINT DEFAULT 1 CHECK (Status IN (0, 1, 2, 3)),
    bookingDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customerId) REFERENCES Customer(id)
);

CREATE TABLE BookingDetail (
    bookingId INT NOT NULL,
    roomId INT NOT NULL,
    price FLOAT NOT NULL,
    startDate DATETIME NOT NULL,
    endDate DATETIME NOT NULL,
    PRIMARY KEY (bookingId, roomId),
    CHECK (endDate > startDate)		
);


-- insert data category 
INSERT INTO Category (name, status) VALUES ('Category 1', 1);
INSERT INTO Category (name, status) VALUES ('Category 2', 1);
INSERT INTO Category (name, status) VALUES ('Category 3', 0);
INSERT INTO Category (name, status) VALUES ('Category 4', 1);
INSERT INTO Category (name, status) VALUES ('Category 5', 0);

-- insert data Room
INSERT INTO Room (name, status, price, salePrice, createdDate, categoryId) VALUES 
('Room A', 1, 150000, 120000, CURRENT_DATE, 1),
('Room B', 1, 200000, 160000, CURRENT_DATE, 1),
('Room C', 0, 180000, 150000, CURRENT_DATE, 2),
('Room D', 1, 220000, 180000, CURRENT_DATE, 2),
('Room E', 1, 250000, 200000, CURRENT_DATE, 3),
('Room F', 1, 300000, 250000, CURRENT_DATE, 3),
('Room G', 1, 350000, 300000, CURRENT_DATE, 1),
('Room H', 0, 400000, 350000, CURRENT_DATE, 2),
('Room I', 1, 450000, 400000, CURRENT_DATE, 2),
('Room J', 1, 500000, 450000, CURRENT_DATE, 3),
('Room K', 1, 550000, 500000, CURRENT_DATE, 1),
('Room L', 1, 600000, 550000, CURRENT_DATE, 2),
('Room M', 1, 650000, 600000, CURRENT_DATE, 3),
('Room N', 1, 700000, 650000, CURRENT_DATE, 1),
('Room O', 1, 750000, 700000, CURRENT_DATE, 2);

-- insert data Customer
INSERT INTO Customer (name, email, phone, address, gender, birthDay) VALUES 
('Nguyễn Văn A', 'nguyenvana@example.com', '0123456789', '123 Đường ABC', 1, '1990-01-01'),
('Trần Thị B', 'tranthib@example.com', '0987654321', '456 Đường DEF', 0, '1985-05-15'),
('Lê Văn C', 'levanc@example.com', '0912345678', '789 Đường GHI', 2, '1992-10-20'),
('Phạm Văn D', 'phamvand@example.com', '0934567890', '321 Đường JKL', 1, '1988-03-30'),
('Bùi Thị E', 'buithie@example.com', '0945678901', '654 Đường MNO', 0, '1995-12-12');

INSERT IGNORE INTO BookingDetail (bookingId, roomId, price, startDate, endDate) VALUES
(1, 1, 150000, '2024-09-01 14:00:00', '2024-09-05 12:00:00'),
(1, 2, 200000, '2024-09-03 14:00:00', '2024-09-07 12:00:00'),
(2, 3, 180000, '2024-09-04 14:00:00', '2024-09-08 12:00:00'),
(2, 4, 220000, '2024-09-05 14:00:00', '2024-09-09 12:00:00'),
(3, 5, 250000, '2024-09-06 14:00:00', '2024-09-10 12:00:00'),
(3, 1, 300000, '2024-09-07 14:00:00', '2024-09-11 12:00:00'),
(4, 2, 350000, '2024-09-08 14:00:00', '2024-09-12 12:00:00'),
(4, 3, 400000, '2024-09-09 14:00:00', '2024-09-13 12:00:00'),
(5, 4, 450000, '2024-09-10 14:00:00', '2024-09-14 12:00:00'),
(5, 5, 500000, '2024-09-11 14:00:00', '2024-09-15 12:00:00'),
(1, 6, 550000, '2024-09-12 14:00:00', '2024-09-16 12:00:00'),
(1, 1, 600000, '2024-09-13 14:00:00', '2024-09-17 12:00:00'),
(2, 2, 650000, '2024-09-14 14:00:00', '2024-09-18 12:00:00'),
(2, 3, 700000, '2024-09-15 14:00:00', '2024-09-19 12:00:00'),
(3, 4, 750000, '2024-09-16 14:00:00', '2024-09-20 12:00:00'),
(3, 5, 800000, '2024-09-17 14:00:00', '2024-09-21 12:00:00'),
(4, 6, 850000, '2024-09-18 14:00:00', '2024-09-22 12:00:00'),
(4, 1, 900000, '2024-09-19 14:00:00', '2024-09-23 12:00:00'),
(5, 2, 950000, '2024-09-20 14:00:00', '2024-09-24 12:00:00'),
(5, 3, 1000000, '2024-09-21 14:00:00', '2024-09-25 12:00:00'),
(1, 4, 1100000, '2024-09-22 14:00:00', '2024-09-26 12:00:00'),
(1, 5, 1200000, '2024-09-23 14:00:00', '2024-09-27 12:00:00'),
(2, 6, 1300000, '2024-09-24 14:00:00', '2024-09-28 12:00:00'),
(2, 1, 1400000, '2024-09-25 14:00:00', '2024-09-29 12:00:00'),
(3, 2, 1500000, '2024-09-26 14:00:00', '2024-09-30 12:00:00'),
(3, 3, 1600000, '2024-09-27 14:00:00', '2024-10-01 12:00:00'),
(4, 4, 1700000, '2024-09-28 14:00:00', '2024-10-02 12:00:00'),
(4, 5, 1800000, '2024-09-29 14:00:00', '2024-10-03 12:00:00'),
(5, 6, 1900000, '2024-09-30 14:00:00', '2024-10-04 12:00:00');

-- insert data booking
INSERT INTO Booking (customerId, status, bookingDate) VALUES 
(1, 1, CURRENT_TIMESTAMP),  -- Giả sử customerId 1 tồn tại
(2, 0, CURRENT_TIMESTAMP),  -- Giả sử customerId 2 tồn tại
(3, 1, CURRENT_TIMESTAMP),  -- Giả sử customerId 3 tồn tại
(1, 2, CURRENT_TIMESTAMP),  -- Giả sử customerId 1 tồn tại
(4, 3, CURRENT_TIMESTAMP);  -- Giả sử customerId 4 tồn tại 


-- Yêu cầu 1 ( Sử dụng lệnh SQL để truy vấn cơ bản ): 
-- 1.	Lấy ra danh phòng có sắp xếp giảm dần theo Price gồm các cột sau: Id, Name, Price, SalePrice, Status, CategoryName, CreatedDate
select r.id , r.name , r.price , r.salePrice , r.status ,c.name , r.createdDate from Room r
inner join category c on r.categoryId = c.id;

-- 2.	Lấy ra danh sách Category gồm: Id, Name, TotalRoom, Status (Trong đó cột Status nếu = 0, Ẩn, = 1 là Hiển thị )
select c.id , c.name , count(r.categoryId) as TotalRoom , case when c.status = 0 then 'ẩn' when c.status = 1 then 'hiển thị' end as status from category c
left join room r on c.id = r.categoryId 
group by c.id; 

-- 3.	Truy vấn danh sách Customer gồm: Id, Name, Email, Phone, Address, CreatedDate, Gender, BirthDay, Age (Age là cột suy ra từ BirthDay, Gender nếu = 0 là Nam, 1 là Nữ,2 là khác )
select c.id , c.name , c.email , c.phone , c.address , c.createdDate , 
case when c.gender = 0  then 'nam' when c.gender = 1 then 'nữ' when c.gender = 2 then 'khác' end as gender ,
c.birthday , timestampdiff(year,c.birthday ,curdate()) as age from customer c ;

-- 4.	Truy vấn xóa các sản phẩm chưa được bán
	SET SQL_SAFE_UPDATES = 0;
	delete from room
    where id  not in  (select distinct id from bookingDetail) ;
-- 5.	Cập nhật Cột SalePrice tăng thêm 10% cho tất cả các phòng có Price >= 250000
	DELIMITER //
			create procedure update_sale_price()
            begin
            update room
            set salePrice = salePrice*1.1
            where salePrice*1.1 <= price & price >= 250000;
            end ;
    // 
    DELIMITER ;

