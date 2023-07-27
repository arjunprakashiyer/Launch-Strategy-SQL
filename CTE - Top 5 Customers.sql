CTE for Step 2- Find out how many of the top 5 customers are based within each country.

WITH Top_5_Customers (customer_first_name,customer_id, customer_last_name, country, city, total_amount_paid)
AS (SELECT  C.first_name AS customer_first_name,C.customer_id AS customer_id, C.last_name AS customer_last_name, F.country, E.city, SUM(A.amount) AS total_amount_paid
FROM Payment A
INNER JOIN Rental B ON A.rental_id = B.rental_id
INNER JOIN Customer C ON B.customer_id = C.customer_id
INNER JOIN Address D ON C.address_id = D.address_id
INNER JOIN City E ON D.city_id = E.city_id
INNER JOIN Country F ON E.country_id = F.country_id
WHERE E.city IN ('Aurora','Acua','Citrus Heights','Iwaki','Ambattur','Shanwei','So Leopoldo','Teboksary','Tianjin','Cianjur')
GROUP BY F.country, E.city, C.first_name, C.last_name, C.customer_id
ORDER BY SUM(A.amount) DESC
LIMIT 5) 
SELECT E.country,COUNT(DISTINCT C.customer_id) AS all_customer_count, COUNT(DISTINCT Top_5_Customers.customer_id) AS top_customer_count
FROM Customer C
INNER JOIN Address A ON C.address_id = A.address_id
INNER JOIN City B ON A.city_id = B.city_id
INNER JOIN Country E ON B.country_id = E.country_id
LEFT JOIN Top_5_Customers
ON E.country = Top_5_Customers.country
GROUP BY E.country
HAVING COUNT(DISTINCT Top_5_Customers.customer_id) > 0
ORDER BY all_customer_count DESC;
