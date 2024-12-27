-- DATA SET : UK E-Commerce Orders

-- Q1. orders 테이블 안에 며칠 치의 데이터가 들어있나요? 
-- order_date 컬럼을 기준으로 데이터의 시작 시점과 끝 시점을 알려주세요.

-- 23024

----> 미확인 : min(datetime), max(datetime) 으로 데이터의 집계 기간 가파악
----> 문제 제대로 파악 못했음

SELECT COUNT(*)
FROM orders
;

-- 정답
-- SELECT
--     MIN(order_date) 
--     , MAX(order_date) 
-- FROM 
--     orders
-- ;


-- Q2. 고객 정보는 어느 테이블에 들어있나요? 
-- customers 테이블 안에 country 컬럼을 참고하여 UK 이커머스 업체의 고객들이 어떤 나라에 살고 있는지 알아봅시다.
-- UK가 가장 많고, 이어 Germany, France, Spain 순

SELECT country, count(customer_id) 
FROM
  customers
GROUP BY 
  country 
ORDER BY
  COUNT(customer_id) DESC
;

-- 정답
-- SELECT
--     DISTINCT country
-- FROM
--     customers
-- ;


-- Q3. 고객 정보 테이블과 주문 테이블 사이의 관계는 어떤가요? 
-- 고객 정보 테이블(customers)과 주문 테이블(orders)은 어떤 컬럼을 기준으로 연결할 수 있나요? 
-- 고객 한 명이 하나의 주문만 할 수 있는 1:1 관계인가요, 아니면 고객 한 명이 주문을 여러 개 할 수 있는 1:N 관계인가요? 

-- customers, orders 테이블은 공통된 customer_id 컬럼으로 연결 가능
-- 고객 한 명이 여러가지 주문 가능한 것으로 확인 고객:주문 = 1:다 관계

SELECT 
    count(DISTINCT customer_id)
    , count(customer_id)
    , count(order_id)
    , count(*) 
FROM
  orders
;

-- 정답
-- 고객 한 명 당 주문 건 수 확인
-- SELECT
--     c.customer_id
--     , count(o.order_id)

-- FROM customer c
--     INNER JOIN orders o ON c.customer_id = o.customer_id

-- GROUP BY 
--     c.customer_id



-- Q4. 고객이 주문한 상품의 수량과 가격은 어느 테이블에 들어있나요? 
-- 주문 테이블(orders)과 주문된 상품별 가격, 수량 데이터가 들어있는 테이블(order_items)은 어떤 관계인가요? 
-- 하나의 주문에 하나의 상품 정보만 있는 1:1 관계인가요, 
-- 아니면 하나의 주문에 여러 종류의 상품 정보가 있을 수 있는 1:N 관계인가요?

-- 주문 상품의 수량, 가격은 order_items 테이블에서 확인 가능
-- orders 테이블 과 order_items 테이블은 공통 컬럼 order_id를 가지고 있음
-- DISTINCT order_id 와 order_id 차를 근거로 하나의 주문에 여러 종류 상품 정보 할당 주문:상품 = 1:다 관계

SELECT 
  COUNT(DISTINCT order_id)
  , COUNT(order_id)
  , COUNT(item_id)
  , COUNT(price)
  , COUNT(quantity)
FROM 
  order_items
;

-- 정답
-- 데이터가 너무 많은 경우 WHERE 조건에 DATE 조건을 1일만 지정해서 또는 1주일만 지정해서 실행
-- ORDER BY COUNT() DESC 를 통해서 최상단에 COUNT() 값이 1 초과 아니라면 1:1 관계

-- SELECT 
--   o.order_id
--   , count(oi.item_id)
-- FROM 
--   orders o INNER JOIN order_items oi ON o.order_id = oi.order_id

-- GROUP BY
--   o.order_id

-- -- WHERE
-- --   o.ordr_date = 
-- LIMIT
--   50
-- ;

-- Q5. 고객 정보(customers)와 각 고객이 주문한 상품 수량과 가격(order_items)을 함께 보고 싶다면 
-- 쿼리를 어떻게 작성해야 할까요?

-- orders 테이블의 order_id를 경유하는 2개 테이블을 LEFT JOIN

-- SELECT
--   *
-- FROM
--   orders o
--     LEFT JOIN customers c ON c.customer_id = o.customer_id
--     LEFT JOIN order_items oi ON o.order_id = oi.order_id
-- LIMIT
--   100
-- ;


-- Q6. customers, orders, order_items 테이블을 사용하여
-- 2019년 11월에 가장 매출이 많이 나온 국가(country)가 어디인지 알아봅시다. 
-- 매출 Top 3 국가를 꼽아주세요.

SELECT
  c.country AS country
  , SUM(oi.price * oi.quantity) AS sales 
FROM
  orders o
    LEFT JOIN customers c ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE
  o.order_date BETWEEN '2019-11-01' AND '2019-11-30'
  AND o.order_id NOT LIKE 'C%' -- 취소된 주문에 대한 SORT ★, 제외된 조건에 대해서 반드시 꼭 점검
GROUP BY
  c.country
ORDER BY
  sales DESC

LIMIT
  3
;
