INSERT INTO C##supply.products (name, sku, price) VALUES
('Palette Europe', 'PAL-EUR', 25.00),
('Carton 60x40', 'CRT-6040', 2.50),
('Film plastique', 'FILM-STD', 1.20);

INSERT INTO C##supply.orders (product_id, quantity, order_date) VALUES
(1, 100, SYSDATE-5),
(2, 250, SYSDATE-3),
(3, 500, SYSDATE-1);


INSERT INTO C##supply.suppliers (name, email, phone) VALUES
('Fournisseur A', 'info@fournisseura.fr', '0123456789'),
('Fournisseur B', 'info@fournisseurb.fr', '0223456789'),
('Fournisseur C', 'info@fournisseurc.fr', '0323456789');