-- Tạo Transaction khi thêm sản phẩm vào giỏ hàng thì kiểm tra xem stock của products có đủ số lượng không nếu không thì rollback
DELIMITER //
	create procedure addToCart(IN user_id int ,IN product_id int,IN quantity int ,IN amount double)
    begin
    start transaction ;
    insert into shopping_cart(user_id,product_id,quantity,amount)
    values (user_id,product_id,quantity,amount);
    
    update products
    set stock = stock - quantity
    where id = product_id ;
    
    if (select quantity from products where id = product_id) >= quantity then
		commit ;
        else 
        rollback ;
    end if ;
    end ;
    
// 
DELIMITER ;


-- 	Tạo Transaction khi xóa sản phẩm trong giỏ hàng thì trả lại số lượng cho products
DELIMITER //
	create procedure deleteToCart(IN id_cart int)
    begin
    start transaction ;
    update products set stock = stock + (select quantity from shopping_cart where id = id_cart)
    where id = (select product_id from shopping_cart where id = id_cart);
    
    delete from shopping_cart where id = id_cart ;
    if (select count(id) from shopping_cart where id = id_cart ) = 0 then
		commit ;
        else 
        rollback ;
    end if ;
    end ;
    
// 
DELIMITER ;