CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(11) NOT NULL,
    dateOfBirth DATE NOT NULL,
    status BIT(1) NOT NULL
);
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DOUBLE NOT NULL CHECK (price > 0),
    stock INT NOT NULL CHECK (stock >= 0),
    status BIT(1) NOT NULL
);
CREATE TABLE shopping_cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    amount DOUBLE NOT NULL CHECK (amount >= 0),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

INSERT INTO users (name, address, phone, dateOfBirth, status)
VALUES ('Nguyen Van A', 'Hà Nội', '0123456789', '1990-01-01', 1),
       ('Le Thi B', 'Hải Phòng', '0987654321', '1995-05-05', 1);
INSERT INTO products (name, price, stock, status)
VALUES ('Điện thoại', 5000000, 100, 1),
       ('Máy tính bảng', 7000000, 50, 1),
       ('Laptop', 15000000, 30, 1);
INSERT INTO shopping_cart (user_id, product_id, quantity, amount)
VALUES (1, 1, 2, 10000000),
       (2, 2, 1, 7000000);

delimiter $$
CREATE TRIGGER update_amount_on_price_change
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    IF NEW.price != OLD.price THEN
        UPDATE shopping_cart
        SET amount = NEW.price * quantity
        WHERE product_id = NEW.id;
    END IF;
END;

CREATE TRIGGER delete_shopping_cart_on_product_delete
AFTER DELETE ON products
FOR EACH ROW
BEGIN
    DELETE FROM shopping_cart
    WHERE product_id = OLD.id;
END;

CREATE TRIGGER decrease_stock_on_shopping_cart_insert
AFTER INSERT ON shopping_cart
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE id = NEW.product_id;
END;
