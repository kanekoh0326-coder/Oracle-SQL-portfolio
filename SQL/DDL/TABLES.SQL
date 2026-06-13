CREATE TABLE suppliers (
supplier_id NUMBER CONSTRAINT supplier_pk PRIMARY KEY,
supplier_name VARCHAR2(100) NOT NULL,
phone VARCHAR2(20)
);

CREATE TABLE products (
product_id NUMBER CONSTRAINT product_pk PRIMARY KEY,
supplier_id NUMBER CONSTRAINT supplier_fk REFERENCES suppliers(
supplier_id)
ON DELETE SET NULL,
product_name VARCHAR2(100) NOT NULL,
price NUMBER,
current_stock NUMBER
last_updated DATE DEFAULT SYSDATE
);

CREATE TABLE purchase_orders (
po_id NUMBER CONSTRAINT po_pk PRIMARY KEY,
order_date DATE DEFAULT SYSDATE,
status VARCHAR2(15)CONSTRAINT po_status_ck CHECK(
status IN('発注中','納品済','キャンセル'))
);

CREATE TABLE purchase_order_details (
po_detail_id NUMBER CONSTRAINT po_datail_pk PRIMARY KEY,
po_id NUMBER CONSTRAINT po_fk REFERENCES purchase_orders(
po_id)
ON DELETE SET NULL,
product_id NUMBER CONSTRAINT product_po_datails_fk REFERENCES products(
product_id)
ON DELETE SET NULL,
quantity NUMBER
);

CREATE TABLE inventory_history(
history_id NUMBER CONSTRAINT inv_history_pk PRIMARY KEY,
product_id NUMBER CONSTRAINT product_inv_history_fk REFERENCES products(
product_id)
ON DELETE SET NULL,
stock_status VARCHAR2(10)CONSTRAINT stock_status_ck CHECK(
stock_status IN ('入庫','出庫','返品')),
quantity NUMBER,
date_history DATE DEFAULT SYSDATE
);
