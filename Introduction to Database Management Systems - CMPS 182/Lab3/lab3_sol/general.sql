-- general.sql
-- 1. amountOwed must be greater than or equal to zero. name: owed_is_not_negative
-- other names besides owed_is_not_negative are acceptable.
ALTER TABLE Customers ADD CONSTRAINT owed_is_not_negative CHECK (amountOwed >= 0);

-- 2. In Sales, revenue isn’t an attribute, but it’s equal to paidPrice * quantity, and those are attributes of Sales. This constraint says that revenue must be at least 10.00
ALTER TABLE Sales ADD CHECK (paidPrice * quantity >= 10);

-- 3. In Customers, if lastPaidDate is NULL then status must be ‘L’.
ALTER TABLE Customers ADD CHECK ( lastPaidDate is NOT NULL OR status = 'L' );

-- For third constraint, it's okay to have extra parentheses, e.g.,
-- ( (lastPaidDate is NOT NULL) OR (status = 'L' ) );
-- Another way to write the constraint "if p then q" is as "(p AND q) OR (NOT p)"
-- ALTER TABLE Customers ADD CHECK ( (lastPaidDate is NULL AND status = 'L') OR (lastPaidDate is NOT NULL ) );

-- Constraints of q2 and q3 don't have to be named, but it's okay to name them.

-- Results:
-- lab1test=> \i general.sql
-- ALTER TABLE
-- ALTER TABLE
-- ALTER TABLE