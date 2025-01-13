INSERT INTO ADMIN (UserID, Role, LastLogin)
VALUES
((SELECT UserID FROM "USER" WHERE Email = 'alice.johnson@example.com'), 'SuperAdmin', NOW());
