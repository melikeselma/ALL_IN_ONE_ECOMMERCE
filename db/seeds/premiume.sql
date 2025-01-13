INSERT INTO PREMIUM (UserID, PremiumStartDate, PremiumEndDate, MembershipPlan)
VALUES
((SELECT UserID FROM CUSTOMER WHERE CustomerType = 'Premium'), NOW(), NOW() + INTERVAL '1 year', 'Gold');
