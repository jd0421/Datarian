-- CONDITION
-- Recency: 한 달 이내에 구매 기록이 있으면 ‘recent’ 이외는 ‘past’ (현재는 2021년 1월 1일로 가정)
-- Frequency: 3회 이상 구매 시 ‘high’, 3회 미만 구매 시 ‘low’
-- Monetary: 500달러 이상 구매 시 ‘high’, 500달러 미만 구매 시 ‘low’
 
-- Dataset
-- US E-commerce Records 2020

-- * grouping 대상 컬럼과 grouping 결과 컬럼이 같이 출력되어 즉시 비교할 수 있도록 진행
-- * grouping 기준은 case, 마지막 count 값에만 count 함수 적용
-- * if 적용 시 group by 절에서 Alias로 적용이 안되므로 case 적용 

-- Q1. 각 고객 Recency - 직접 푼 방식
SELECT IF (last_order_date > DATE_SUB('2021-01-01', INTERVAL 1 month), 'recent', 'past') AS 'Recency'
FROM customer_stats
;

-- Q1. Recency - CASE 방식
SELECT last_order_date
     , CASE
           WHEN last_order_date >= '2020-12-01' THEN 'recent'
           ELSE 'past'
       END AS Recency 
FROM customer_stats
;

-- Q2. Frequency 
SELECT sum(cnt_orders)  
FROM customer_stats
GROUP BY customer_id
;

-- Q2. Frequency - distinct 차이 확인
SELECT count(customer_id) , count(distinct customer_id)   
FROM customer_stats
;

-- Q2. Frequency - CASE 방식 - 처음에 cnt_orders 컬럼이랑 같이 조회
SELECT cnt_orders
     , CASE
           WHEN cnt_orders >= 3 THEN 'high'
           ELSE 'low'
       END AS Frequency 
FROM customer_stats
;

-- Q3. Recency group by counts ? total 693
SELECT DISTINCT IF (last_order_date >= DATE_SUB('2021-01-01', INTERVAL 1 month), 'recent', 'past') AS Recency
     , COUNT(IF (last_order_date >= DATE_SUB('2021-01-01', INTERVAL 1 month), 'recent', 'past')) AS Customers
FROM customer_stats
GROUP BY IF (last_order_date >= DATE_SUB('2021-01-01', INTERVAL 1 month), 'recent', 'past')
ORDER BY Recency DESC
;

-- Q3. Recency group by counts ? - CASE 방식
SELECT CASE
           WHEN last_order_date >= '2020-12-01' THEN 'recent'
           ELSE 'past'
       END AS Recency
       , COUNT(customer_id) AS Customers
FROM customer_stats
GROUP BY Recency
;

-- Q4. Recency, Frequency grouping 
-- Frequency: 3회 이상 구매 시 ‘high’, 3회 미만 구매 시 ‘low’
SELECT IF (last_order_date >= DATE_SUB('2021-01-01', INTERVAL 1 month), 'recent', 'past') AS Recency
     , IF (cnt_orders >= 3, 'high', 'low') AS Frequency
     , COUNT(IF (last_order_date >= DATE_SUB('2021-01-01', INTERVAL 1 month), 'recent', 'past')) AS Customers
FROM customer_stats
GROUP BY IF (last_order_date >= DATE_SUB('2021-01-01', INTERVAL 1 month), 'recent', 'past')
       , IF (cnt_orders >= 3, 'high', 'low')
ORDER BY Recency DESC
;

-- Q4. Recency, Frequency grouping - CASE 버전
SELECT CASE
           WHEN last_order_date >= '2020-12-01' THEN 'recent'
           ELSE 'past'
       END AS Recency
     , CASE
           WHEN cnt_orders >= 3 THEN 'high'
           ELSE 'low'
       END AS Frequency
     , COUNT(customer_id) AS Customers
FROM customer_stats
GROUP BY Recency, Frequency
;

-- Q5. Monetary 
-- Monetary: 500달러 이상 구매 시 ‘high’, 500달러 미만 구매 시 ‘low’

SELECT CASE
           WHEN last_order_date >= '2020-12-01' THEN 'recent'
           ELSE 'past'
       END AS Recency
     , CASE
           WHEN cnt_orders >= 3 THEN 'high'
           ELSE 'low'
       END AS Frequency
     , CASE
           WHEN sum_sales >= 500 THEN 'high'
           ELSE 'low'
       END AS Monetary
     , COUNT(customer_id) AS Customers
FROM customer_stats
GROUP BY Recency, Frequency, Monetary
;
