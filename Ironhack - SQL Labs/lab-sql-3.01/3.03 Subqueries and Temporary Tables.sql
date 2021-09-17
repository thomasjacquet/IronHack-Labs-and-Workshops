SELECT AVG(amount) FROM bank.loan;

SELECT * FROM bank.loan
WHERE amount > (SELECT AVG(amount) FROM bank.loan)
ORDER BY amount DESC 
LIMIT 10;

SELECT * FROM (SELECT account_id, bank_to, SUM(amount) AS Total
	FROM bank.order
	GROUP BY  account_id, account_to, bank_to) sub1
WHERE Total > 10000;

SELECT * FROM (SELECT bank, AVG(amount) AS Average
	FROM bank.trans
	WHERE bank <>''
    GROUP BY bank
HAVING Average > 5500) sub1;

SELECT * FROM bank.order
	WHERE bank_to IN (SELECT bank FROM
    (SELECT bank, AVG(amount) AS Average
	FROM bank.trans
    WHERE bank <>''
	GROUP BY bank
	HAVING Average > 5500) sub1)
AND k_symbol <> ' ';

# IN ONLY OPERATES THROUGH ONE COLUMN

SELECT * FROM bank.trans
WHERE k_symbol IN (SELECT k_symbol FROM	
	(SELECT AVG(amount) AS Average, k_symbol
	FROM bank.order
	GROUP BY k_symbol
	HAVING Average > 3000) sub1 );

-- A subquery is a select statement that is included with another query.
-- Enclose the subquery in parenthesis.
-- A subquery can return a single, a list of values or a complete table.
-- A subquery can't include an ORDER BY clause; they'll be ignored.
-- There can be many levels of subquery.

-- CREATE TEMPORARY TABLE to refers to:
CREATE TEMPORARY TABLE avg_balance_per_operation AS(	
	SELECT AVG(balance) AS Avg_balance, operation 
    FROM bank.trans
    WHERE k_symbol IN (
		SELECT k_symbol AS  symbol
        FROM (
			SELECT AVG(amount) AS Average, k_symbol
            FROM bank.order 
            WHERE k_symbol <> ' '
            GROUP BY k_symbol
            HAVING Average > 3000 
            ORDER BY Average DESC)  sub1 ) 
	GROUP BY operation);
    
SELECT operation
FROM avg_balance_per_operation
ORDER BY Avg_balance
LIMIT 1;

-- VIEWS: showing the data you want to show, but not more.
CREATE VIEW Customers_for_mailroom AS (
	SELECT customer_id, name, address_line1, address_line2, postcode, state, country
    FROM customers);

-- VIEWS are used to queries shared between Data Analyst and Data Administrator.