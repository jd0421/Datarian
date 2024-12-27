-- LEFT JOIN 실습 

# 1
SELECT * 
FROM 
  customers c LEFT JOIN orders o ON c.id = o.customer_id
;

# 2
SELECT * 
FROM 
  customers c LEFT JOIN orders o ON c.id = o.customer_id
WHERE
  o.id IS null 
  -- c.grades = 'new' -- 같은 값
;

# 3
SELECT
  *
FROM 
  restaurants r LEFT JOIN orders o ON r.id = o.restaurant_id -- LEFT JOIN
WHERE
  r.created_at <= "2018-01-01 00:00:00"
  AND o.customer_id IS NULL
;

# 4
SELECT 
  r.restaurant_category
  , COUNT(r.restaurant_category)
FROM 
  restaurants r LEFT JOIN orders o ON r.id = o.restaurant_id  -- LEFT JOIN

WHERE
  o.customer_id IS NULL 


# 5
SELECT 
  c.* -- 대상 테이블 만 뽑겠다고 한다면  
FROM 
  orders o RIGHT JOIN customers c ON o.customer_id = c.id -- 조건은 좌우 상관이 없음

WHERE
  o.customer_id IS NULL 

;
