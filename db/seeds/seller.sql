INSERT INTO SELLER (UserID, ShopID, SellerRate)
VALUES
((SELECT UserID FROM "USER" WHERE Email = 'john.doe@example.com'), 
 (SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'TechStore'), 4.7),
((SELECT UserID FROM "USER" WHERE Email = 'oyku@example.com'),
 (SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'Bornova Incisi'), 4.5); -- Added SellerRate for the second row