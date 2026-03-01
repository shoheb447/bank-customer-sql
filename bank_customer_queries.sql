-- Bank Customer SQL Project
-- All 11 Questions Solutions

-- =====================
-- Q1: Average Balance per Customer (8 Rows)
-- =====================
SELECT
    c.customer_id,
    c.customer_name,
    AVG(a.Balance_amount) AS avg_balance
FROM BANK_CUSTOMER c
JOIN Bank_Account_Details a ON c.customer_id = a.Customer_id
GROUP BY c.customer_id, c.customer_name;

-- =====================
-- Q2: Credit Card Balance with COALESCE (4 Rows)
-- =====================
SELECT
    a.customer_id,
    a.account_number,
    COALESCE(NULLIF(a.balance_amount, 0), t.transaction_amount) AS balance_amount
FROM Bank_Account_Details a
LEFT JOIN BANK_ACCOUNT_TRANSACTION t ON a.account_number = t.account_number
WHERE a.account_type = 'Credit Card'
LIMIT 4;

-- =====================
-- Q3: March & April 2020 Transactions (12 Rows)
-- =====================
SELECT
    a.account_number,
    a.balance_amount,
    t.transaction_amount,
    t.Transaction_Date
FROM Bank_Account_Details a
JOIN BANK_ACCOUNT_TRANSACTION t ON a.account_number = t.account_number
WHERE t.Transaction_Date BETWEEN '2020-03-01' AND '2020-04-30';

-- =====================
-- Q4: Excluding March 2020 (22 Rows)
-- =====================
SELECT
    c.customer_id,
    a.account_number,
    a.balance_amount,
    t.transaction_amount,
    t.Transaction_Date
FROM BANK_CUSTOMER c
JOIN Bank_Account_Details a ON c.customer_id = a.Customer_id
LEFT JOIN BANK_ACCOUNT_TRANSACTION t
    ON a.account_number = t.account_number
    AND strftime('%Y-%m', t.Transaction_Date) != '2020-03'
ORDER BY c.customer_id;

-- =====================
-- Q5: First Quarter Transactions (16 Rows)
-- =====================
SELECT
    a.Customer_id,
    a.account_number,
    a.balance_amount,
    t.transaction_amount,
    t.Transaction_Date
FROM Bank_Account_Details a
INNER JOIN BANK_ACCOUNT_TRANSACTION t ON a.account_number = t.account_number
WHERE t.Transaction_Date BETWEEN '2020-01-01' AND '2020-03-31';

-- =====================
-- Q6: Adhoc Message for SAVINGS (8 Rows)
-- =====================
SELECT
    a.account_number,
    m.Event,
    m.Customer_message
FROM Bank_Account_Details a
CROSS JOIN BANK_CUSTOMER_MESSAGES m
WHERE a.account_type = 'SAVINGS'
  AND m.Event = 'Adhoc';

-- =====================
-- Q7: Deducted Balance (27 Rows)
-- =====================
SELECT
    a.Customer_id,
    a.Account_Number,
    a.Account_type,
    CASE
        WHEN t.transaction_amount < 0
        THEN a.Balance_amount - t.transaction_amount
        ELSE a.Balance_amount
    END AS deducted_balance
FROM Bank_Account_Details a
LEFT JOIN BANK_ACCOUNT_TRANSACTION t ON a.account_number = t.account_number
ORDER BY a.Customer_id;

-- =====================
-- Q8: Accounts with Linking Account (15 Rows)
-- =====================
SELECT
    a.Account_Number,
    a.Account_type,
    t.Transaction_amount,
    r.Linking_Account_Number,
    r2.Account_type AS Linking_Account_type
FROM Bank_Account_Details a
LEFT JOIN BANK_ACCOUNT_TRANSACTION t ON a.account_number = t.account_number
LEFT JOIN Bank_Account_Relationship_Details r ON a.account_number = r.Account_Number
LEFT JOIN Bank_Account_Relationship_Details r2 ON r.Linking_Account_Number = r2.Account_Number
WHERE r.Linking_Account_Number IS NOT NULL
  AND r.Linking_Account_Number != '';

-- =====================
-- Q9: Accounts + Linked Transaction (26 Rows)
-- =====================
SELECT
    a.Account_Number,
    a.Account_type,
    t.Transaction_amount,
    r.Linking_Account_Number,
    r2.Account_type AS Linking_Account_type,
    SUM(t2.Transaction_amount) AS Linking_Transaction_amount
FROM Bank_Account_Details a
LEFT JOIN BANK_ACCOUNT_TRANSACTION t ON a.account_number = t.account_number
LEFT JOIN Bank_Account_Relationship_Details r ON a.account_number = r.Account_Number
LEFT JOIN Bank_Account_Relationship_Details r2 ON r.Linking_Account_Number = r2.Account_Number
LEFT JOIN BANK_ACCOUNT_TRANSACTION t2 ON r.Linking_Account_Number = t2.Account_Number
GROUP BY a.Account_Number, a.Account_type, t.Transaction_amount,
         r.Linking_Account_Number, r2.Account_type;

-- =====================
-- Q10: SAVINGS with Credit Card (3 Rows)
-- =====================
SELECT DISTINCT
    a.Customer_id,
    a.Account_Number,
    a.Account_type
FROM Bank_Account_Details a
INNER JOIN Bank_Account_Details b ON a.Customer_id = b.Customer_id
WHERE a.Account_type = 'SAVINGS'
  AND b.Account_type IN ('Credit Card', 'Add-on Credit Card');

-- =====================
-- Q11: SAVINGS linked with Credit Card Sum (1 Row)
-- =====================
SELECT
    r.Linking_Account_Number AS savings_account,
    'SAVINGS' AS Account_type,
    r.Account_Number AS linked_credit_card,
    SUM(t.Transaction_amount) AS total_credit_transaction
FROM Bank_Account_Relationship_Details r
JOIN BANK_ACCOUNT_TRANSACTION t ON r.Account_Number = t.Account_Number
WHERE r.Account_type = 'Credit Card'
  AND r.Linking_Account_Number = '4000-1956-5698'
GROUP BY r.Linking_Account_Number, r.Account_Number;
