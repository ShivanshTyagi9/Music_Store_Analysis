-- Q1. Who is the senior most employee based on job title?
SELECT * 
FROM employee
ORDER BY levels DESC
LIMIT 1;

-- Q2. Which countries have the most Invoices?
SELECT COUNT(*) AS counter, billing_country
FROM invoice
GROUP BY billing_country
ORDER BY billing_country DESC;

-- Q3. What are top 3 values of total invoices?
SELECT total 
FROM invoice
ORDER BY total DESC
LIMIT 3;


-- Q4. Which city has the best customers? We would like to throw a promotional Music festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoices totals. Return both the city name and sum of all invoice totals.
SELECT billing_city, SUM(total) AS counter
FROM invoice
GROUP BY billing_city
ORDER BY counter DESC;

-- Q5. Who is the best customer? The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money.
SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) as spend
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY spend DESC
LIMIT 1;


-- Moderate
-- Q1. Write query to return the email, first name, last name, and Genre of all Rock Music listerners. Return your list ordered alphabetically by email starting with A.
--- My answer
SELECT DISTINCT customer.first_name, customer.last_name, customer.email, genre.name From invoice
JOIN customer ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
JOIN track ON invoice_line.track_id = track.track_id
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name = 'Rock'
ORDER BY email;

--- Efficient and professional answer
SELECT DISTINCT email, first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;

-- Q2. Let's invite the artists who have written the most rock music in our database. Write a query that returns the Artist name and total track count of the top 10 rock bands
--- Given number of albums contains atleast 1 rock music track per artist (Wrong).
SELECT DISTINCT artist.name, COUNT(artist.artist_id) AS total FROM album
JOIN artist ON album.artist_id = artist.artist_id
WHERE album_id IN(
	SELECT album_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name = 'Rock'
)
GROUP BY artist.name
ORDER BY total DESC;

--- Corrected, Returns number of rock songs per artist.
SELECT DISTINCT artist.name, COUNT(artist.artist_id) AS total FROM album
JOIN artist ON album.artist_id = artist.artist_id
JOIN track ON track.album_id = album.album_id
WHERE genre_id IN(
	SELECT genre_id FROM genre
	--JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name = 'Rock'
)
GROUP BY artist.name
ORDER BY total DESC
LIMIT 10;

--- Given by ChatGPt
SELECT artist.name, COUNT(track.track_id) AS total_songs
FROM artist
JOIN album ON album.artist_id = artist.artist_id
JOIN track ON track.album_id = album.album_id
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name = 'Rock'
GROUP BY artist.name
ORDER BY total_songs DESC
LIMIT 10;

-- Q3. Return all the track names that have a song length longer than the average song length. Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.
SELECT name, milliseconds  
FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track)
ORDER BY milliseconds DESC;