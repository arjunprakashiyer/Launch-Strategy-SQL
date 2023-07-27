--Find the average amount paid by the top 5 customers. 

SELECT AVG(total_amount_paid.sum_amount_paid) AS "average"
FROM 
(SELECT  C.first_name AS customer_first_name, C.last_name AS customer_last_name, F.country, E.city, SUM(A.amount) AS sum_amount_paid 
FROM Payment A
INNER JOIN Rental B ON A.rental_id = B.rental_id
INNER JOIN Customer C ON B.customer_id = C.customer_id
INNER JOIN Address D ON C.address_id = D.address_id
INNER JOIN City E ON D.city_id = E.city_id
INNER JOIN Country F ON E.country_id = F.country_id
WHERE E.city IN ('Aurora','Acua','Citrus Heights','Iwaki','Ambattur','Shanwei','So Leopoldo','Teboksary','Tianjin','Cianjur')
GROUP BY F.country, E.city, C.first_name, C.last_name
ORDER BY SUM(A.amount) DESC
LIMIT 5) AS total_amount_paid; 
