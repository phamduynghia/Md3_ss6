create database session06_bai3 ;
use session06_bai3 ;

create table users (
id int auto_increment primary key ,
name varchar(100) not null ,
myMoney double not null check (myMoney >= 0),
address varchar(255) not null ,
phone varchar(11) not null unique,
dateOfBirth date not null ,
status bit(1) default 1
);

create table transfer (
sender_id int not null ,
receiver_id int not null ,
money double check(money > 0) not null ,
transfer_date datetime default (now())
);

-- Tạo transaction (phiên giao dịnh) khi gửi tiền đến tài khoản người nếu vượt quá số tiền trong tài khoản thì sẽ (rollback) trở lại vị trí ban đầu khi bắt đầu giao dịnh

DELIMITER //
	create procedure check_transfer(IN sender_id int , IN receiver_id int ,IN money double)
    begin
		start transaction ;
        insert into transfer(sender_id,receiver_id, money)
        values (sender_id , receiver_id , money);
        
        update users set myMoney = myMoney + money where id = receiver_id ;
        update users set myMoney = myMoney - money where id = sender_id ;
        
        if(select count(id) from users where id = receiver_id) = 1 then
			if (select myMoney from users where id = sender_id) >= money then
            commit ;
            else 
            rollback ;
            end if ;
        else
        rollback ;
        end if ;
    end ;
//
DELIMITER ;