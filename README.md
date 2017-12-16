# R_Shoping_Cart_Predection

With frequent item sets and association rules of high confidence we can conclude that if a rule holds 90% confidence, it is likely to hold for the next customer. It helps customers in buying items they may often forget. Or items they may need for a purpose but are unaware of.

The rules generated were of a large scale and needed to be pruned and tuned to obtain a workable set of rules. Also, a much larger dataset would guarantee rules with much confidence and help for a better prediction.  

## How to run the code

### Step 1: SQL code
  * Run the SQL Scrip in the database that you are using 
  * My Table Name : local_schema
### Setp 2: R code
  * Run the R Code and Check that its connected to the database tha you are using
### Step 3: Web app
  * The jsp file contains the web application that should be run
  * Use eclipe to run this application
  * Also needs database connection i.e the same table that is created in Setp 1
  * Run on server
  * Code wount need much changes
