-- Q1. Who is the senior most employee based on job title?
SELECT * 
FROM employee
ORDER BY levels DESC
LIMIT 1;

-- Q2. Which countries have the most Invoices?
SELECT COUNT(invoice_id) AS invoice, billing_country AS billing_country
FROM invoice
GROUP BY billing_country
ORDER BY billing_country DESC;

-- Q3. What are top 3 values of total invoices?
SELECT total 
FROM invoice
ORDER BY total DESC
LIMIT 3;
