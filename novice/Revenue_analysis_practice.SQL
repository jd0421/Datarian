-- DATA SET : UK E-Commerce Orders


-- Q. orders, order_items 두 테이블을 이용해 2018년 12월 1일부터 2019년 12월 9일까지 기간 내 쇼핑몰의 일별 매출액을 계산해 봅시다. 
-- 날짜는 거래일을 기준으로 계산하며 orders 테이블의 order_date 컬럼을 참고합니다. 매출 금액은 order_items 테이블의 price와 quantity를 곱한 값으로 계산합니다.
-- 단, 거래 ID(order_id)가 C로 시작하는 환불 건은 매출액 계산에 포함하지 않습니다.

SELECT
  o.order_date AS order_date
  , SUM(oi.price * oi.quantity) AS sales 
FROM
  orders o
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE
  o.order_date BETWEEN '2018-12-01' AND '2019-12-09'
  AND o.order_id NOT LIKE 'C%' -- 취소된 주문에 대한 SORT
GROUP BY
  o.order_date
ORDER BY
  o.order_date asc

LIMIT
  50
;


-- Q. orders, order_items 테이블을 이용하여 2018년 12월 1일부터 2019년 12월 9일까지 기간 내 쇼핑몰의 일별 매출액, 일별 구매 고객 수(PU; Paying User), 일별 ARPPU(Average Revenue Per Paying User)를 구해주세요. 
-- 일별 ARPPU는 일별 매출액을 일별 구매 고객 수로 나누어 계산할 수 있습니다. 날짜는 거래일을 기준으로 계산하며 orders 테이블의 order_date 컬럼을 참고합니다. 매출 금액은 order_items 테이블의 price와 quantity를 곱한 값을 기준으로 계산합니다.
-- 단, 거래 ID(order_id)가 C로 시작하는 환불 건은 매출액 계산에 포함하지 않습니다.


-- 일별 구매 고객 수
-- o.order_date를 1일 로 filter
-- 1개 customer_id 에 order_id 가 1:1 매칭인지 확인 및 , DISITNCT 처리를 통해 1:1 매칭 여부 추가 확인
-- 일별 구매 고객 수는 customer_id 기준으로 진행하며 주문순고객 기준이 아닌 주문총고객 기준으로 SORT
-- > 고객 계산을 DISTINCT 기준으로 해야 함 
SELECT
  o.order_date
  , count(o.customer_id) AS 'PU'
  , SUM(oi.price * oi.quantity) AS REVENUE
-- , SUM(oi.price * oi.quantity) / count(o.customer_id) AS 'ARPPU'
-- , count(DISTINCT o.customer_id)
  , SUM(oi.price * oi.quantity) / count(DISTINCT o.customer_id) DISTINCTED
FROM
  orders o
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE
  o.order_date BETWEEN '2018-12-01' AND '2019-12-09'
  AND o.order_id NOT LIKE 'C%' -- 취소된 주문에 대한 SORT
GROUP BY
  o.order_date
ORDER BY
  o.order_date asc

;

Q. 국내 고객과 국외 고객을 나누어 어떤 고객의 수가 증가한 것인지 알고 싶습니다. ‘United Kingdom’을 제외한 나머지 국가는 ‘Other Countries’로 분류하여 일별 구매 고객 수를 계산하는 쿼리를 작성해 주세요. orders, order_items, customers 테이블을 사용합니다.
쿼리로 테이블 피봇하는 데 익숙하지 않다면 구글 스프레드시트의 ‘피봇 테이블’ 기능을 이용해도 괜찮습니다.