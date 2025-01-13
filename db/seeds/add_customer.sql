-- Insert Users
INSERT INTO "USER" (UserID, FirstName, LastName, PhoneNumber, HashedPassword, Email, MembershipDate, UserType)
VALUES
    (uuid_generate_v4(), 'John', 'Doe', '1234567890', 'hashed_pw_1', 'john.doe@gmail.com', CURRENT_TIMESTAMP, 'Customer'),
    (uuid_generate_v4(), 'Jane', 'Smith', '1234567891', 'hashed_pw_2', 'jane.smith@yahoo.com', CURRENT_TIMESTAMP, 'Customer'),
    (uuid_generate_v4(), 'Alice', 'Johnson', '1234567892', 'hashed_pw_3', 'alice.johnson@outlook.com', CURRENT_TIMESTAMP, 'Customer'),
    (uuid_generate_v4(), 'Bob', 'Brown', '1234567893', 'hashed_pw_4', 'bob.brown@icloud.com', CURRENT_TIMESTAMP, 'Admin');

-- Insert Customers
INSERT INTO CUSTOMER (UserID, CustomerType)
SELECT UserID, 'Regular'
FROM "USER"
WHERE Email IN ('john.doe@gmail.com', 'jane.smith@yahoo.com', 'alice.johnson@outlook.com');

-- Insert Premium Customers
INSERT INTO PREMIUM (UserID, PremiumStartDate, PremiumEndDate, MembershipPlan)
SELECT UserID, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '1 year', 'Gold Plan'
FROM CUSTOMER
WHERE UserID = (SELECT UserID FROM "USER" WHERE Email = 'jane.smith@yahoo.com');

-- Insert Admins
INSERT INTO ADMIN (UserID, Role, LastLogin)
SELECT UserID, 'SuperAdmin', CURRENT_TIMESTAMP
FROM "USER"
WHERE Email = 'bob.brown@icloud.com';

-- Insert Payment Methods
INSERT INTO PAYMENT_METHOD (PaymentID, InstallmentCount, InstallmentAmount, InstallmentRate, UserID)
VALUES
    (uuid_generate_v4(), 6, 50.0, 5.0, (SELECT UserID FROM CUSTOMER WHERE UserID = (SELECT UserID FROM "USER" WHERE Email = 'john.doe@gmail.com'))),
    (uuid_generate_v4(), 12, 100.0, 3.0, (SELECT UserID FROM CUSTOMER WHERE UserID = (SELECT UserID FROM "USER" WHERE Email = 'jane.smith@yahoo.com'))),
    (uuid_generate_v4(), 0, 0.0, 0.0, (SELECT UserID FROM CUSTOMER WHERE UserID = (SELECT UserID FROM "USER" WHERE Email = 'alice.johnson@outlook.com')));

-- Insert Bank Cards
INSERT INTO BANK_CARD (PaymentID, CardLastFourDigits, ExpiryDate, CVV, CardHolderName, PaymentType)
VALUES
    ((SELECT PaymentID FROM PAYMENT_METHOD WHERE UserID = (SELECT UserID FROM "USER" WHERE Email = 'john.doe@gmail.com')), '1234', '2026-01-01', '123', 'John Doe', 'Credit'),
    ((SELECT PaymentID FROM PAYMENT_METHOD WHERE UserID = (SELECT UserID FROM "USER" WHERE Email = 'jane.smith@yahoo.com')), '5678', '2025-12-31', '456', 'Jane Smith', 'Debit');

-- Insert Wallets
INSERT INTO WALLET (PaymentID, Balance, ExpDate)
VALUES
    ((SELECT PaymentID FROM PAYMENT_METHOD WHERE UserID = (SELECT UserID FROM "USER" WHERE Email = 'john.doe@gmail.com')), 150.0, CURRENT_TIMESTAMP + INTERVAL '6 months'),
    ((SELECT PaymentID FROM PAYMENT_METHOD WHERE UserID = (SELECT UserID FROM "USER" WHERE Email = 'alice.johnson@outlook.com')), 200.0, CURRENT_TIMESTAMP + INTERVAL '1 year');

-- Insert Gift Cards
INSERT INTO GIFT_CARD (PaymentID, Balance, ExpDate, RequestCode)
VALUES
    ((SELECT PaymentID FROM PAYMENT_METHOD WHERE UserID = (SELECT UserID FROM "USER" WHERE Email = 'jane.smith@yahoo.com')), 50.0, CURRENT_TIMESTAMP + INTERVAL '3 months', 12345);
