# Bank Customer SQL Analysis Project

## Project Overview
This project contains SQL queries for analyzing bank customer data including accounts, transactions, and relationships.

## Database Tables
- **BANK_CUSTOMER** - Customer personal details
- **Bank_Account_Details** - Account information (Savings, RD, Credit Card)
- **BANK_ACCOUNT_TRANSACTION** - Transaction records
- **Bank_Account_Relationship_Details** - Account linking details
- **BANK_CUSTOMER_MESSAGES** - Customer notification messages

## Questions Solved
| Q No | Description | Rows |
|------|-------------|------|
| Q1 | Average balance per customer | 8 |
| Q2 | Credit Card balance using COALESCE | 4 |
| Q3 | Transactions in March & April 2020 | 12 |
| Q4 | All transactions excluding March 2020 | 22 |
| Q5 | First Quarter transactions only | 16 |
| Q6 | Adhoc messages for SAVINGS accounts | 8 |
| Q7 | Deducted balance for all accounts | 27 |
| Q8 | Accounts with linking account details | 15 |
| Q9 | Accounts with linked transaction amount | 26 |
| Q10 | SAVINGS holders with Credit Cards | 2 |
| Q11 | SAVINGS linked with Credit Card sum | 1 |

## Tools Used
- SQL (SQLite)
- Python
- Pandas
- Google Colab
