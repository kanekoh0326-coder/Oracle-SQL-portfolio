SELECT s.supplier_name,
COUNT(p.product_id) AS product_count
FROM suppliers s
INNER JOIN products p
ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_name
ORDER BY product_count DESC
;

① 仕入先ごとの仕入商品数

SELECT p.product_id,p.product_name,p.current_stock,
SUM(pod.quantity) AS order_quantity
FROM products p
INNER JOIN purchase_order_details pod
ON p.product_id = pod.product_id
INNER JOIN purchase_orders po
ON pod.po_id = po.po_id
WHERE po.status = '発注中'
GROUP BY p.product_id,p.product_name,p.current_stock
HAVING p.current_stock - SUM(pod.quantity) > 500
;

② 現在庫と注文数量（現在発注中の商品のみ）を比較し、在庫が500以上残っている商品を抽出
(残在庫数が出庫量に対し500を上回る場合入庫はしない)
  
SELECT p.product_name,p.current_stock,
SUM(pod.quantity) AS order_quantity,
p.current_stock - SUM(pod.quantity) AS remaining_stock
FROM products p
INNER JOIN purchase_order_details pod
ON p.product_id = pod.product_id
INNER JOIN purchase_orders po
ON pod.po_id = po.po_id
WHERE po.status = '発注中'
GROUP BY p.product_id,p.product_name,p.current_stock
ORDER BY remaining_stock
;

③ 現在庫から発注済み商品が出荷された（納品した）際の想定残在庫

SELECT product_id,
SUM(quantity) AS current_stock
FROM (
SELECT product_id,quantity
FROM inventory_history
WHERE stock_status IN ('入庫','返品')
UNION ALL
SELECT product_id,-quantity
FROM inventory_history
WHERE stock_status = '出庫'
)
GROUP BY product_id
;

④ inventory_historyの履歴から算出した現在庫
(入出庫時に都度productsのcurrent_stockとlast_updatedを更新する)

SELECT p.product_name,
SUM(pod.quantity) AS total_order_quantity
FROM products p
INNER JOIN purchase_order_details pod
ON p.product_id = pod.product_id
INNER JOIN purchase_orders po
ON pod.po_id = po.po_id
WHERE TO_CHAR(po.order_date,'YYYY/MM') = '2026/01'
AND po.status = '納品済'
GROUP BY p.product_name
ORDER BY total_order_quantity DESC
;

⑤ 指定した月の合計納品数量
