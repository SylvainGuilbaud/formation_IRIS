INSERT INTO supply.products (name, sku, price) VALUES
('Palette Europe', 'PAL-EUR', 25.00),
('Carton 60x40', 'CRT-6040', 2.50),
('Film étirable', 'FILM-STD', 1.20);

INSERT INTO supply.orders (product_id, quantity, order_date) VALUES
(1, 100, SYSDATE-5),
(2, 250, SYSDATE-3),
(3, 500, SYSDATE-1);
