# Bank Tech Test

This is my solution to [this](https://github.com/makersacademy/course/blob/master/individual_challenges/bank_tech_test.md) practice tech test, written in Ruby.

## Specification

### Requirements

* You should be able to interact with your code via a REPL like IRB or the JavaScript console.  (You don't need to implement a command line interface that takes input from STDIN.)
* Deposits, withdrawal.
* Account statement (date, amount, balance) printing.
* Data can be kept in memory (it doesn't need to be stored to a database or anything).

### Acceptance criteria

**Given** a client makes a deposit of 1000 on 10-01-2012  
**And** a deposit of 2000 on 13-01-2012  
**And** a withdrawal of 500 on 14-01-2012  
**When** she prints her bank statement  
**Then** she would see

```
date || credit || debit || balance
14/01/2012 || || 500.00 || 2500.00
13/01/2012 || 2000.00 || || 3000.00
10/01/2012 || 1000.00 || || 1000.00
```

## User stories

As a bank customer,  
So I can keep track of my income and expenses,  
I would like to be able to specify a date for transactions.  

As a bank customer,  
So I know how much money I have,  
I would like for my bank balance to be automatically updated after each transaction.  

As a bank customer,  
So I can add money to my account,  
I would like to be able to set up payments into my account (credits).  

As a bank customer,  
So I can buy things with my account,  
I would like to be able to set up payments from my account (debits).  
