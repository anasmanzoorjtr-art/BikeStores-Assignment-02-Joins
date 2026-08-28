-- ============================================================
-- ASSIGNMENT 02 — Joins
-- Database : BikeStores
-- SQL Server Version
-- ============================================================

USE BikeStores;
GO


-- ============================================================
-- Question 1
-- Retrieve the product_name, list_price, and category_name
-- for every product.
-- Sort the results by product_name ascending.
-- ============================================================

SELECT
    p.product_name,
    p.list_price,
    c.category_name
FROM production.products AS p
INNER JOIN production.categories AS c
    ON p.category_id = c.category_id
ORDER BY p.product_name ASC;
GO


-- ============================================================
-- Question 2
-- Show the customer full name (as full_name), order_id,
-- and order_date for all customers who have placed an order.
-- Sort by order_date descending.
-- ============================================================

SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    o.order_id,
    o.order_date
FROM sales.customers AS c
INNER JOIN sales.orders AS o
    ON c.customer_id = o.customer_id
ORDER BY o.order_date DESC;
GO


-- ============================================================
-- Question 3
-- Retrieve product_name, list_price, category_name, and
-- brand_name for every product.
-- Sort by brand_name then product_name (both ascending).
-- ============================================================

SELECT
    p.product_name,
    p.list_price,
    c.category_name,
    b.brand_name
FROM production.products AS p
INNER JOIN production.categories AS c
    ON p.category_id = c.category_id
INNER JOIN production.brands AS b
    ON p.brand_id = b.brand_id
ORDER BY
    b.brand_name ASC,
    p.product_name ASC;
GO


-- ============================================================
-- Question 4
-- List all products along with their order_id and item_id.
-- Make sure products that have NEVER been ordered also appear
-- in the result.
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    oi.order_id,
    oi.item_id
FROM production.products AS p
LEFT JOIN sales.order_items AS oi
    ON p.product_id = oi.product_id
ORDER BY oi.order_id ASC;
GO


-- ============================================================
-- Question 5
-- Using your answer from Question 4 as a base, filter the
-- results to show ONLY the products that have never been
-- ordered.
-- Display only product_id and product_name.
-- ============================================================

SELECT
    p.product_id,
    p.product_name
FROM production.products AS p
LEFT JOIN sales.order_items AS oi
    ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;
GO


-- ============================================================
-- Question 6
-- Show all stores along with any orders placed at each store.
-- Display store_name, store_id, order_id, and order_date.
-- Every store must appear in the result, even if it has
-- no orders yet.
-- ============================================================

SELECT
    s.store_name,
    s.store_id,
    o.order_id,
    o.order_date
FROM sales.stores AS s
LEFT JOIN sales.orders AS o
    ON s.store_id = o.store_id
ORDER BY
    s.store_id ASC,
    o.order_date ASC;
GO


-- ============================================================
-- Question 7
-- List every staff member alongside their manager's name.
-- Display:
--   staff full name   (as staff_name)
--   manager full name (as manager_name)
-- Use only the sales.staffs table.
-- Staff who have no manager should NOT appear.
-- ============================================================

SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name
FROM sales.staffs AS s
INNER JOIN sales.staffs AS m
    ON s.manager_id = m.staff_id;
GO


-- ============================================================
-- Question 8
-- Generate every possible combination of store name and
-- brand name.
-- Display store_name and brand_name.
-- How many total rows do you expect?
-- ============================================================

SELECT
    s.store_name,
    b.brand_name
FROM sales.stores AS s
CROSS JOIN production.brands AS b;

-- Expected count: 27 rows
-- 3 stores × 9 brands = 27
GO


-- ============================================================
-- Question 9
-- Retrieve the customer full name (as full_name), order_id,
-- order_date, product_name, and list_price for every order
-- that has been placed.
-- Sort by order_date ascending, then full_name ascending.
-- ============================================================

SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    o.order_id,
    o.order_date,
    p.product_name,
    p.list_price
FROM sales.customers AS c
INNER JOIN sales.orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN sales.order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN production.products AS p
    ON oi.product_id = p.product_id
ORDER BY
    o.order_date ASC,
    full_name ASC;
GO