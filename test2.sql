create database test02;
use test02;

DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS guests;

CREATE TABLE guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_name VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_type VARCHAR(50),
    price_per_day DECIMAL(10,0)
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

INSERT INTO guests (guest_name, phone) VALUES
('Nguyễn Văn A', '0901111112'),
('Trần Thị B', '0902222223'),
('Lê Văn C', '0903333334'),
('Phạm Thị D', '0904444445'),
('Hoàng Văn E', '0905555556');

INSERT INTO rooms (room_type, price_per_day) VALUES
('Standard', 500000),
('Standard', 500000),
('Deluxe', 800000),
('Deluxe', 800000),
('VIP', 1500000),
('VIP', 2000000);

INSERT INTO bookings (guest_id, room_id, check_in, check_out) VALUES
(1, 1, '2024-01-10', '2024-01-12'), -- 2 ngày
(1, 3, '2024-03-05', '2024-03-10'), -- 5 ngày
(2, 2, '2024-02-01', '2024-02-03'), -- 2 ngày
(2, 5, '2024-04-15', '2024-04-18'), -- 3 ngày
(3, 4, '2023-12-20', '2023-12-25'), -- 5 ngày
(3, 6, '2024-05-01', '2024-05-06'), -- 5 ngày
(4, 1, '2024-06-10', '2024-06-11'); -- 1 ngày

-- P1
select guest_name, phone
from guests;

select room_type
from rooms
group by room_type;

select room_type, price_per_day
from rooms
order by price_per_day asc;

select room_id, room_type, price_per_day
from rooms
where price_per_day > 1000000;

select booking_id,guest_id,room_id,check_in,check_out
from bookings
where year(check_in) = 2024;

select room_type, count(*) as 'Số Phòng'
from rooms
group by room_type;

-- P2
select g.guest_name,r.room_type,b.check_in
from bookings b
join guests g on b.guest_id = g.guest_id
join rooms r on b.room_id = r.room_id;

select g.guest_name,count(b.booking_id)
from guests g join bookings b on g.guest_id = b.guest_id
			  join rooms r on r.room_id = b.room_id
group by b.guest_id;

select b.room_id as 'Mã Phòng', sum((b.check_out - b.check_in)* r.price_per_day) as 'Doanh thu mỗi phòng'
from bookings b join rooms r on r.room_id = b.room_id
group by b.room_id;

select r.room_type as 'Loại Phòng', sum((b.check_out - b.check_in)* r.price_per_day) 'Tổng doanh thu'
from bookings b join rooms r on r.room_id = b.room_id
group by r.room_type;