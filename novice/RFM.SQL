-- 컬럼 데이터타입 조회
DESC records
;

-- Q1. records 테이블 데이터 조회
SELECT *
FROM records
limit 10
;

-- Q2. customer_stats 테이블 데이터 조회
SELECT *
FROM customer_stats
limit 10
;

-- Q3. records 테이블 'JP-15520' 고객 데이터 조회. 주문한 횟수?
-- 2
SELECT count(DISTINCT order_id)
FROM records
WHERE customer_id = 'JP-15520'
;

-- Q4. records 테이블에 들어있는 'JP-15520' 고객 주문 총 금액
-- # 1824.184
SELECT sum(sales)
FROM records
WHERE customer_id = 'JP-15520'
;

-- Q5. records 테이블에 들어있는 'JP-15520' 고객 마지막 주문 날짜 
-- 2020-12-22
SELECT order_date
FROM records
WHERE customer_id = 'JP-15520'
ORDER BY order_date DESC
LIMIT 1
;

-- Q6. customer_stats 테이블 'JP-15520' 고객 데이터 조회하여 동일 여부 비교 
SELECT *
FROM records
WHERE customer_id = 'JP-15520'
;

SELECT * 
FROM customer_stats
WHERE customer_id = 'JP-15520'
;

-- records 테이블을 이용하여 아래 결과를 출력하려면 어떻게 해야 할까요

SELECT customer_id
     , min(order_date) first_order_date
     , max(order_date) last_order_date
     , count(DISTINCT order_id) cnt_orders
     , sum(sales) sales
FROM records
GROUP BY customer_id
limit 10
;
