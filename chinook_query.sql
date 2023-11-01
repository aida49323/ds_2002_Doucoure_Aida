SELECT *
from chinook_dw.dim_customer;

SELECT *
from chinook_dw.dim_invoice;

SELECT *
from chinook_dw.fact_mt;

-- Here is an aggregate query that finds the average total cost by billing city
SELECT BillingCity, AVG(Total) as AverageTotal
FROM dim_invoice
GROUP BY BillingCity;



