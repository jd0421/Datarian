4. INNER JOIN 연습

-- SELECT *
-- FROM orders AS o
--      JOIN reviews AS r ON o.review_id = r.review_id

-- # 1
customer_id
SELECT * 
from orders AS o
    INNER JOIN customers AS c ON o.customer_id = c.customer_id
limit 50;

-- SELECT * -- customer_id
-- from customers
-- limit 10;

-- # 2
SELECT * -- customer_id
from orders AS o
    INNER JOIN customers AS c ON o.customer_id = c.customer_id
WHERE c.country = 'Switzerland'
limit 50;

-- # 3
SELECT o.order_date, o.customer_id, c.country -- customer_id
from orders AS o
    INNER JOIN customers AS c ON o.customer_id = c.customer_id
WHERE o.order_date BETWEEN '2019-01-01' AND '2019-01-31'
limit 50;

-- # 4
SELECT
    o.customer_id -- 거래id
  , o.order_date -- 거래일
  , c.country -- 배송지 국가
  , oi.item_id -- 구매 상품 id
  , oi.price -- 상품 가격
  , oi.quantity -- 수량
FROM 
  orders AS o
  INNER JOIN customers AS c ON o.customer_id = c.customer_id
  INNER JOIN order_items AS oi ON o.order_id = oi.order_id
LIMIT
  10
;


