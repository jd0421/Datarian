-- DATASET : US E-commerce Records 2020

-- #1
-- ELSE 조건으로 NULL을 의도한다면, 'ELSE NULL'을 꼭 입력하지 않아도 됨
SELECT order_id
    ,  CASE 
          WHEN category = 'Furniture' THEN order_id
          ELSE NULL  
       END AS furniture_order_id
FROM records
limit 100
;

-- SELECT DISTINCT category
-- from records
-- limit 10
-- ;

-- #2 
-- furniture_order_id 의 distinct 는 어떻게 적용되는건가요 > furniture_order_id 도 order_id와 같이 중복 db가 있어 제외
-- count 함수는 null을 기본적으로 배제
select count(DISTINCT order_id)
    ,  count(DISTINCT CASE 
          WHEN category = 'Furniture' THEN order_id
          ELSE NULL  
       END) AS furniture_order_id
from records
limit 100
; 

-- #3
select region as Region 
    , count(DISTINCT order_id) as Total 
    ,  count(DISTINCT CASE 
          WHEN category = 'Furniture' THEN order_id
          ELSE NULL  
       END) AS Furniture
from records
group by region
limit 100
; 


