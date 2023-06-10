/*1) Which country has maximum invoice?*/

SELECT COUNT(*), billing_country FROM invoice
group by billing_country
order by billing_country DESC
LIMIT 1

/*2) Who is the senior most employee?*/

SELECT * FROM employee WHERE levels = (SELECT MAX(levels) FROM employee)
/*OR*/
SELECT * FROM employee 
order by levels desc 
limit 1

/*3) Which city has the best customers? Write a query to find the city name and the sum of total iinvoice of the city*/

SELECT SUM(total) as invoice_total,billing_city  FROM invoice
group by billing_city
order by invoice_total desc
limit 1

/*4) Who is the best customer? The customer who has spent the largest amount of money is the best customer.Write a query to find the custome name */

SELECT customer.customer_id, customer.first_name, customer.last_name, customer.email, customer.phone,SUM(invoice.total) as total 
FROM customer
JOIN invoice on customer.customer_id=invoice.customer_id
group by customer.customer_id
order by total desc
limit 1

/*5)Write a query to return the email, first name, last name and genre of all rock music listeners. Return your list ordered alphabetically by email starting with A.*/

SELECT customer.email, customer.first_name,customer.last_name, genre.name FROM customer 
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id=invoice.invoice_id
JOIN track ON track.track_id=invoice_line.track_id
JOIN genre ON genre.genre_id=track.genre_id WHERE genre.name='Rock'
group by genre.name,customer.customer_id
order by email

/*6) Lets invite the artists who have written the most rock music in our dataset. Write a query that returns the artist name and total track count of the top 10 rock bands*/
SELECT artist.artist_id,artist.name,COUNT(artist.artist_id) as no_of_songs
FROM track
JOIN album on album.album_id=track.album_id
JOIN artist on artist.artist_id=album.artist_id
JOIN genre on genre.genre_id = track.genre_id WHERE genre.name='Rock'
group by artist.artist_id
order by no_of_songs desc

/*or(down one is my own method)*/

SELECT artist.name,artist.artist_id, COUNT(artist.artist_id)as num_of_songs
from artist
JOIN album ON album.artist_id = artist.artist_id
JOIN track ON track.album_id=album.album_id
JOIN genre ON genre.genre_id=track.genre_id WHERE genre.name='Rock'
group by artist.artist_id 
order by num_of_songs desc
limit 10

/*7) Return all the track names that have a song length longer than the average song length. Return the name and milliseconds for each track. Order by the song length with the longest songs listed first.*/

SELECT name, milliseconds from track WHERE milliseconds>=(SELECT avg(milliseconds) as avg_song_length from track)
order by milliseconds desc

/*8) Find how much amount spent by each customer on an artist. Write a query to return customer_namre, artist_name and total spent.*/

SELECT customer.first_name, customer.last_name, artist.name, SUM(total) as total_amount_spent 
FROM customer
JOIN invoice ON invoice.customer_id=customer.customer_id
JOIN invoice_line on invoice_line.invoice_id=invoice.invoice_id
JOIN track on track.track_id=invoice_line.track_id
JOIN album on album.album_id=track.album_id
JOIN artist on artist.artist_id=album.artist_id
group by customer.customer_id, artist.name
order by total_amount_spent desc