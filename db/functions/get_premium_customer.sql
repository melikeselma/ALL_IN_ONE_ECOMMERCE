SELECT *
FROM PREMIUM
JOIN CUSTOMER ON PREMIUM.UserID = CUSTOMER.UserID
JOIN "USER" ON CUSTOMER.UserID = "USER".UserID;