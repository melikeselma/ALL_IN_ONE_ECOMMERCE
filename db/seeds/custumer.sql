-- Insert Customers
INSERT INTO CUSTOMER (UserID, CustomerType)
VALUES
((SELECT UserID FROM "USER" WHERE Email = 'john.doe@example.com'), 'Regular'),
((SELECT UserID FROM "USER" WHERE Email = 'jane.smith@example.com'), 'Premium'),
((SELECT UserID FROM "USER" WHERE Email = 'alice.johnson@example.com'), 'Regular');
