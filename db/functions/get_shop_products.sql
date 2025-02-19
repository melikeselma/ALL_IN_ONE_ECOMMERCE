SELECT SHOP.ShopName, p.ProductName, sp.StockLevel, sp.Price
FROM SHOP
JOIN SHOP_SELLS_PRODUCT sp ON s.RegistrationNumber = sp.RegistrationNumber
JOIN PRODUCT p ON sp.ProductID = p.ProductID
WHERE (s.ShopName ILIKE '%' || 'TechZone' || '%');
