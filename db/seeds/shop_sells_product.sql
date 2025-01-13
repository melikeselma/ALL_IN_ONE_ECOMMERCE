-- Insert Data into SHOP_SELLS_PRODUCT
INSERT INTO SHOP_SELLS_PRODUCT (RegistrationNumber, ProductID, StockLevel, Price)
VALUES
    -- TechZone sells multiple products
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'TechZone'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'IP14-S1'), 30, 999.99),
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'TechZone'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'SGS23-S1'), 20, 899.99),
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'TechZone'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'GP7-S1'), 25, 799.99),

    -- iStore specializes in Apple products
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'iStore'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'IP14-S1'), 50, 999.99),
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'iStore'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'MBP14-S1'), 15, 1999.99),
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'iStore'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'AW8-S1'), 20, 399.99),

    -- GameHaven sells gaming products
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'GameHaven'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'PS5-S1'), 10, 499.99),
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'GameHaven'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'XSX-S1'), 8, 499.99),
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'GameHaven'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'NSOLED-S1'), 12, 349.99),

    -- MobileMart focuses on smartphones
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'MobileMart'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'IP14-S1'), 40, 999.99),
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'MobileMart'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'SGS23-S1'), 35, 899.99),
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'MobileMart'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'GP7-S1'), 30, 799.99),

    -- ElectroHub sells miscellaneous electronics
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'ElectroHub'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'USBC45-S1'), 100, 29.99),
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'ElectroHub'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'MSC-S1'), 80, 39.99),
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'ElectroHub'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'WHXM5-S1'), 10, 349.99),

    -- FitTech sells fitness devices
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'FitTech'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'GW6-S1'), 25, 299.99),
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'FitTech'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'AW8-S1'), 15, 399.99),

    -- ConsoleZone focuses on gaming consoles
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'ConsoleZone'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'PS5-S1'), 20, 499.99),
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'ConsoleZone'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'XSX-S1'), 15, 499.99),
    ((SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'ConsoleZone'),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'NSOLED-S1'), 18, 349.99);
