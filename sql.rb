# 1 Given the ER model above, write an SQL query that reports the id of all customers who
# have placed at least one product order with sku X_Y_Z .

SELECT DISTINCT CUSTOMERS.id
FROM CUSTOMERS
INNER JOIN ORDERS
ON CUSTOMERS.id = ORDERS.customer_id
INNER JOIN LINE_ITEMS
ON LINE_ITEMS.order_id = ORDERS.id
INNER JOIN PRODUCTS
ON LINE_ITEMS.product_id = PRODUCTS.id AND PRODUCTS.sku = "X_Y_Z"


# 2 Given the ER model above, write an SQL query that reports the id of all the orders
# containing at least two products whose sku starts with a G .
SELECT ORDERS.id as ORDER_ID
FROM ORDERS
INNER JOIN LINE_ITEMS
ON LINE_ITEMS.order_id = ORDERS.id
INNER JOIN PRODUCTS
ON LINE_ITEMS.product_id = PRODUCTS.id
AND PRODUCTS.sku LIKE "G%"
GROUP BY ORDER_ID
HAVING COUNT(*) > 2

# This one includes a COUNT column
SELECT ORDERS.id as ORDER_ID, COUNT(*) as COUNT
FROM ORDERS
INNER JOIN LINE_ITEMS
ON LINE_ITEMS.order_id = ORDERS.id
INNER JOIN PRODUCTS
ON LINE_ITEMS.product_id = PRODUCTS.id
AND PRODUCTS.sku LIKE "G%"
GROUP BY ORDER_ID
HAVING COUNT(*) > 2





