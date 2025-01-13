-- Clear All Tables
TRUNCATE TABLE SKU_MANAGEMENT CASCADE;
TRUNCATE TABLE PRODUCT_VARIATION CASCADE;
TRUNCATE TABLE PRODUCT_HAS_OPTION CASCADE;
TRUNCATE TABLE PRODUCT_CONTAINS_CATEGORY CASCADE;
TRUNCATE TABLE CATEGORY CASCADE;
TRUNCATE TABLE OPTION_VALUE CASCADE;
TRUNCATE TABLE PRODUCT_OPTION CASCADE;
TRUNCATE TABLE PRODUCT CASCADE;

-- Insert Categories
INSERT INTO CATEGORY (CategoryID, CategoryName)
VALUES
    (uuid_generate_v4(), 'Smartphones'),
    (uuid_generate_v4(), 'Laptops'),
    (uuid_generate_v4(), 'Headphones'),
    (uuid_generate_v4(), 'Smartwatches'),
    (uuid_generate_v4(), 'Chargers'),
    (uuid_generate_v4(), 'Keyboards'),
    (uuid_generate_v4(), 'Mice'),
    (uuid_generate_v4(), 'Gaming Consoles');

-- Insert Products
INSERT INTO PRODUCT (ProductID, ProductName, Brand, SKU, ShortDescription, Description, IsApproved, Status, Rating, BasePrice)
VALUES
    -- Smartphones
    (uuid_generate_v4(), 'iPhone 14', 'Apple', 'IP14-S1', 'Latest iPhone 14', 'The new iPhone 14 with A16 Bionic chip.', TRUE, 'Available', 4.8, 999.99),
    (uuid_generate_v4(), 'Samsung Galaxy S23', 'Samsung', 'SGS23-S1', 'Flagship Galaxy phone', 'The Samsung Galaxy S23 with Snapdragon 8 Gen 2.', TRUE, 'Available', 4.7, 899.99),
    (uuid_generate_v4(), 'Google Pixel 7', 'Google', 'GP7-S1', 'Pure Android experience', 'Google Pixel 7 with Tensor G2 chip.', TRUE, 'Available', 4.6, 799.99),

    -- Laptops
    (uuid_generate_v4(), 'MacBook Pro 14"', 'Apple', 'MBP14-S1', 'High-performance laptop', '14-inch MacBook Pro with M1 Pro chip.', TRUE, 'Available', 4.9, 1999.99),
    (uuid_generate_v4(), 'Dell XPS 13', 'Dell', 'DXPS13-S1', 'Ultrabook laptop', 'Dell XPS 13 with Intel Core i7.', TRUE, 'Available', 4.6, 1299.99),
    (uuid_generate_v4(), 'Lenovo ThinkPad X1', 'Lenovo', 'TPX1-S1', 'Business-class laptop', 'ThinkPad X1 Carbon with Intel Core i7.', TRUE, 'Available', 4.7, 1399.99),

    -- Headphones
    (uuid_generate_v4(), 'Sony WH-1000XM5', 'Sony', 'WHXM5-S1', 'Noise-cancelling headphones', 'Premium noise-cancelling over-ear headphones.', TRUE, 'Available', 4.7, 349.99),
    (uuid_generate_v4(), 'Bose QuietComfort 45', 'Bose', 'QC45-S1', 'Comfortable ANC headphones', 'Noise-cancelling headphones with premium comfort.', TRUE, 'Available', 4.8, 329.99),

    -- Smartwatches
    (uuid_generate_v4(), 'Galaxy Watch 6', 'Samsung', 'GW6-S1', 'Smartwatch with advanced health features', 'Track your fitness and stay connected.', TRUE, 'Available', 4.5, 299.99),
    (uuid_generate_v4(), 'Apple Watch Series 8', 'Apple', 'AW8-S1', 'Premium smartwatch', 'Advanced features for health and connectivity.', TRUE, 'Available', 4.9, 399.99),

    -- Chargers
    (uuid_generate_v4(), 'USB-C Charger', 'Anker', 'USBC45-S1', 'Fast charging adapter', '45W USB-C charger with fast charging support.', TRUE, 'Available', 4.6, 29.99),
    (uuid_generate_v4(), 'MagSafe Charger', 'Apple', 'MSC-S1', 'Wireless charger for iPhone', 'Fast wireless charging with MagSafe technology.', TRUE, 'Available', 4.7, 39.99),

    -- Keyboards
    (uuid_generate_v4(), 'Razer BlackWidow V3', 'Razer', 'RBWV3-S1', 'Mechanical keyboard', 'RGB mechanical keyboard.', TRUE, 'Available', 4.6, 129.99),
    (uuid_generate_v4(), 'Logitech K780', 'Logitech', 'K780-S1', 'Wireless multi-device keyboard', 'Multi-device Bluetooth keyboard for productivity.', TRUE, 'Available', 4.5, 79.99),

    -- Mice
    (uuid_generate_v4(), 'Logitech MX Master 3', 'Logitech', 'MXM3-S1', 'Wireless mouse', 'Ergonomic wireless mouse.', TRUE, 'Available', 4.9, 99.99),
    (uuid_generate_v4(), 'Razer DeathAdder V2', 'Razer', 'RDV2-S1', 'Gaming mouse', 'High-precision gaming mouse.', TRUE, 'Available', 4.7, 69.99),

    -- Gaming Consoles
    (uuid_generate_v4(), 'PlayStation 5', 'Sony', 'PS5-S1', 'Next-gen gaming console', 'PlayStation 5 with ultra-fast SSD and stunning visuals.', TRUE, 'Available', 4.9, 499.99),
    (uuid_generate_v4(), 'Xbox Series X', 'Microsoft', 'XSX-S1', 'Powerful gaming console', 'Xbox Series X with 4K gaming and fast load times.', TRUE, 'Available', 4.8, 499.99),
    (uuid_generate_v4(), 'Nintendo Switch OLED', 'Nintendo', 'NSOLED-S1', 'Portable gaming console', 'Nintendo Switch with OLED screen.', TRUE, 'Available', 4.7, 349.99),

    -- Repeated Products (Multiple Sellers)
    (uuid_generate_v4(), 'iPhone 14', 'Apple', 'IP14-S2', 'Latest iPhone 14', 'The new iPhone 14 with A16 Bionic chip.', TRUE, 'Available', 4.8, 999.99),
    (uuid_generate_v4(), 'MacBook Pro 14"', 'Apple', 'MBP14-S2', 'High-performance laptop', '14-inch MacBook Pro with M1 Pro chip.', TRUE, 'Available', 4.9, 1999.99);

-- Link Products to Categories
INSERT INTO PRODUCT_CONTAINS_CATEGORY (ProductID, CategoryID)
VALUES
    -- Smartphones
    ((SELECT ProductID FROM PRODUCT WHERE SKU = 'IP14-S1'), (SELECT CategoryID FROM CATEGORY WHERE CategoryName = 'Smartphones')),
    ((SELECT ProductID FROM PRODUCT WHERE SKU = 'IP14-S2'), (SELECT CategoryID FROM CATEGORY WHERE CategoryName = 'Smartphones')),
    ((SELECT ProductID FROM PRODUCT WHERE SKU = 'SGS23-S1'), (SELECT CategoryID FROM CATEGORY WHERE CategoryName = 'Smartphones')),
    ((SELECT ProductID FROM PRODUCT WHERE SKU = 'GP7-S1'), (SELECT CategoryID FROM CATEGORY WHERE CategoryName = 'Smartphones')),

    -- Laptops
    ((SELECT ProductID FROM PRODUCT WHERE SKU = 'MBP14-S1'), (SELECT CategoryID FROM CATEGORY WHERE CategoryName = 'Laptops')),
    ((SELECT ProductID FROM PRODUCT WHERE SKU = 'MBP14-S2'), (SELECT CategoryID FROM CATEGORY WHERE CategoryName = 'Laptops')),
    ((SELECT ProductID FROM PRODUCT WHERE SKU = 'DXPS13-S1'), (SELECT CategoryID FROM CATEGORY WHERE CategoryName = 'Laptops')),
    ((SELECT ProductID FROM PRODUCT WHERE SKU = 'TPX1-S1'), (SELECT CategoryID FROM CATEGORY WHERE CategoryName = 'Laptops')),

    -- Headphones
    ((SELECT ProductID FROM PRODUCT WHERE SKU = 'WHXM5-S1'), (SELECT CategoryID FROM CATEGORY WHERE CategoryName = 'Headphones')),
    ((SELECT ProductID FROM PRODUCT WHERE SKU = 'QC45-S1'), (SELECT CategoryID FROM CATEGORY WHERE CategoryName = 'Headphones')),

    -- Gaming Consoles
    ((SELECT ProductID FROM PRODUCT WHERE SKU = 'PS5-S1'), (SELECT CategoryID FROM CATEGORY WHERE CategoryName = 'Gaming Consoles')),
    ((SELECT ProductID FROM PRODUCT WHERE SKU = 'XSX-S1'), (SELECT CategoryID FROM CATEGORY WHERE CategoryName = 'Gaming Consoles')),
    ((SELECT ProductID FROM PRODUCT WHERE SKU = 'NSOLED-S1'), (SELECT CategoryID FROM CATEGORY WHERE CategoryName = 'Gaming Consoles'));

-- Insert Product Options
INSERT INTO PRODUCT_OPTION (OptionID, OptionName, IsMandatory)
VALUES
    (uuid_generate_v4(), 'Color', TRUE),
    (uuid_generate_v4(), 'Storage', TRUE),
    (uuid_generate_v4(), 'Size', FALSE),
    (uuid_generate_v4(), 'Connectivity', FALSE);

-- Insert Option Values
INSERT INTO OPTION_VALUE (OptionValueID, OptionID, DimensionImpact, WeightImpact, AdditionalPrice)
VALUES
    -- Colors
    (uuid_generate_v4(), (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color'), 0, 0, 0),
    (uuid_generate_v4(), (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color'), 0, 0, 0),
    -- Storage
    (uuid_generate_v4(), (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Storage'), 0, 0, 100),
    -- Sizes
    (uuid_generate_v4(), (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Size'), 0, 0, 50),
    -- Connectivity
    (uuid_generate_v4(), (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Connectivity'), 0, 0, 20);



-- Insert Product Variations and Generate SKUs for Each Product
-- iPhone 14 Variations and SKUs
INSERT INTO PRODUCT_VARIATION (VariationID, ProductID, Status, StockLevel, Weight, OptionCombination, Price, OptionValueID, OptionID)
VALUES
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'IP14-S1'), 'Available', 50, 0.4, 'Color: Black, Storage: 128GB', 999.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color')),
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'IP14-S1'), 'Available', 30, 0.4, 'Color: White, Storage: 256GB', 1099.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Storage') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Storage'));

-- Add SKUs for iPhone 14
INSERT INTO SKU_MANAGEMENT (SKU, SupplierName, RestockDate, StockLevel, RestockThreshold, VariationID, ProductID, OptionValueID, OptionID)
VALUES
    ('IP14-BLK-128', 'Apple Inc.', NOW() + INTERVAL '30 days', 50, 10,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Color: Black, Storage: 128GB' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'IP14-S1')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'IP14-S1'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color')),
    ('IP14-WHT-256', 'Apple Inc.', NOW() + INTERVAL '30 days', 30, 10,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Color: White, Storage: 256GB' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'IP14-S1')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'IP14-S1'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Storage') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Storage'));
-- Galaxy S23 Variations
INSERT INTO PRODUCT_VARIATION (VariationID, ProductID, Status, StockLevel, Weight, OptionCombination, Price, OptionValueID, OptionID)
VALUES
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'SGS23-S1'), 'Available', 40, 0.4, 'Color: Blue, Storage: 128GB', 899.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color')),
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'SGS23-S1'), 'Available', 25, 0.4, 'Color: Green, Storage: 256GB', 999.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Storage') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Storage'));

-- Add SKUs for Galaxy S23
INSERT INTO SKU_MANAGEMENT (SKU, SupplierName, RestockDate, StockLevel, RestockThreshold, VariationID, ProductID, OptionValueID, OptionID)
VALUES
    ('SGS23-BLU-128', 'Samsung Inc.', NOW() + INTERVAL '30 days', 40, 10,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Color: Blue, Storage: 128GB' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'SGS23-S1')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'SGS23-S1'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color')),
    ('SGS23-GRN-256', 'Samsung Inc.', NOW() + INTERVAL '30 days', 25, 10,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Color: Green, Storage: 256GB' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'SGS23-S1')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'SGS23-S1'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Storage') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Storage'));

-- MacBook Pro 14 Variations (Seller 2)
INSERT INTO PRODUCT_VARIATION (VariationID, ProductID, Status, StockLevel, Weight, OptionCombination, Price, OptionValueID, OptionID)
VALUES
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'MBP14-S2'), 'Available', 20, 1.5, 'Size: 14-inch, Connectivity: WiFi', 1999.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Size') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Size')),
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'MBP14-S2'), 'Available', 15, 1.6, 'Size: 14-inch, Connectivity: WiFi + Ethernet', 2099.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Connectivity') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Connectivity'));

-- Add SKUs for MacBook Pro 14 (Seller 2)
INSERT INTO SKU_MANAGEMENT (SKU, SupplierName, RestockDate, StockLevel, RestockThreshold, VariationID, ProductID, OptionValueID, OptionID)
VALUES
    ('MBP14-S2-WIFI', 'Apple Inc.', NOW() + INTERVAL '30 days', 20, 5,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Size: 14-inch, Connectivity: WiFi' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'MBP14-S2')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'MBP14-S2'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Size') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Size')),
    ('MBP14-S2-WIFI-ETH', 'Apple Inc.', NOW() + INTERVAL '30 days', 15, 5,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Size: 14-inch, Connectivity: WiFi + Ethernet' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'MBP14-S2')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'MBP14-S2'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Connectivity') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Connectivity'));

-- Google Pixel 7 Variations
INSERT INTO PRODUCT_VARIATION (VariationID, ProductID, Status, StockLevel, Weight, OptionCombination, Price, OptionValueID, OptionID)
VALUES
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'GP7-S1'), 'Available', 60, 0.4, 'Color: Black, Storage: 128GB', 799.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color')),
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'GP7-S1'), 'Available', 50, 0.4, 'Color: White, Storage: 256GB', 899.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Storage') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Storage'));

-- Google Pixel 7 SKUs
INSERT INTO SKU_MANAGEMENT (SKU, SupplierName, RestockDate, StockLevel, RestockThreshold, VariationID, ProductID, OptionValueID, OptionID)
VALUES
    ('GP7-BLK-128', 'Google Inc.', NOW() + INTERVAL '30 days', 60, 10,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Color: Black, Storage: 128GB' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'GP7-S1')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'GP7-S1'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color')),
    ('GP7-WHT-256', 'Google Inc.', NOW() + INTERVAL '30 days', 50, 10,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Color: White, Storage: 256GB' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'GP7-S1')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'GP7-S1'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Storage') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Storage'));

-- Sony WH-1000XM5 Variations
INSERT INTO PRODUCT_VARIATION (VariationID, ProductID, Status, StockLevel, Weight, OptionCombination, Price, OptionValueID, OptionID)
VALUES
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'WHXM5-S1'), 'Available', 80, 0.3, 'Color: Black', 349.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color')),
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'WHXM5-S1'), 'Available', 70, 0.3, 'Color: Silver', 349.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color'));

INSERT INTO SKU_MANAGEMENT (SKU, SupplierName, RestockDate, StockLevel, RestockThreshold, VariationID, ProductID, OptionValueID, OptionID)
VALUES
    ('WHXM5-BLK', 'Sony Inc.', NOW() + INTERVAL '30 days', 80, 20,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Color: Black' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'WHXM5-S1')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'WHXM5-S1'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color')),
    ('WHXM5-SLV', 'Sony Inc.', NOW() + INTERVAL '30 days', 70, 20,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Color: Silver' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'WHXM5-S1')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'WHXM5-S1'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color'));


-- MacBook Pro Variations for Seller 2
INSERT INTO PRODUCT_VARIATION (VariationID, ProductID, Status, StockLevel, Weight, OptionCombination, Price, OptionValueID, OptionID)
VALUES
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'MBP14-S2'), 'Available', 20, 1.5, 'Size: 14-inch, Connectivity: WiFi', 1999.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Size') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Size')),
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'MBP14-S2'), 'Available', 15, 1.6, 'Size: 14-inch, Connectivity: WiFi + Ethernet', 2099.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Connectivity') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Connectivity'));

INSERT INTO SKU_MANAGEMENT (SKU, SupplierName, RestockDate, StockLevel, RestockThreshold, VariationID, ProductID, OptionValueID, OptionID)
VALUES
    ('MBP14-S2-WIFI', 'Apple Inc.', NOW() + INTERVAL '30 days', 20, 5,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Size: 14-inch, Connectivity: WiFi' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'MBP14-S2')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'MBP14-S2'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Size') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Size')),
    ('MBP14-S2-WIFI-ETH', 'Apple Inc.', NOW() + INTERVAL '30 days', 15, 5,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Size: 14-inch, Connectivity: WiFi + Ethernet' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'MBP14-S2')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'MBP14-S2'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Connectivity') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Connectivity'));

-- Razer BlackWidow V3 Variations
INSERT INTO PRODUCT_VARIATION (VariationID, ProductID, Status, StockLevel, Weight, OptionCombination, Price, OptionValueID, OptionID)
VALUES
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'RBWV3-S1'), 'Available', 60, 1.2, 'Color: Black', 129.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color')),
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'RBWV3-S1'), 'Available', 50, 1.2, 'Color: White', 129.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color'));

INSERT INTO SKU_MANAGEMENT (SKU, SupplierName, RestockDate, StockLevel, RestockThreshold, VariationID, ProductID, OptionValueID, OptionID)
VALUES
    ('RBWV3-BLK', 'Razer Inc.', NOW() + INTERVAL '30 days', 60, 15,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Color: Black' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'RBWV3-S1')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'RBWV3-S1'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color')),
    ('RBWV3-WHT', 'Razer Inc.', NOW() + INTERVAL '30 days', 50, 15,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Color: White' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'RBWV3-S1')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'RBWV3-S1'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color'));

-- PlayStation 5 Variations
INSERT INTO PRODUCT_VARIATION (VariationID, ProductID, Status, StockLevel, Weight, OptionCombination, Price, OptionValueID, OptionID)
VALUES
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'PS5-S1'), 'Available', 30, 4.5, 'Connectivity: WiFi', 499.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Connectivity') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Connectivity')),
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'PS5-S1'), 'Available', 20, 4.6, 'Connectivity: WiFi + Ethernet', 549.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Connectivity') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Connectivity'));

-- PlayStation 5 SKUs
INSERT INTO SKU_MANAGEMENT (SKU, SupplierName, RestockDate, StockLevel, RestockThreshold, VariationID, ProductID, OptionValueID, OptionID)
VALUES
    ('PS5-WIFI', 'Sony Inc.', NOW() + INTERVAL '30 days', 30, 5,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Connectivity: WiFi' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'PS5-S1')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'PS5-S1'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Connectivity') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Connectivity')),
    ('PS5-WIFI-ETH', 'Sony Inc.', NOW() + INTERVAL '30 days', 20, 5,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Connectivity: WiFi + Ethernet' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'PS5-S1')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'PS5-S1'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Connectivity') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Connectivity'));

-- AirPods Pro 2 Variations
INSERT INTO PRODUCT_VARIATION (VariationID, ProductID, Status, StockLevel, Weight, OptionCombination, Price, OptionValueID, OptionID)
VALUES
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'APPRO2-S1'), 'Available', 50, 0.2, 'Color: White', 249.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color'));

-- AirPods Pro 2 SKUs
INSERT INTO SKU_MANAGEMENT (SKU, SupplierName, RestockDate, StockLevel, RestockThreshold, VariationID, ProductID, OptionValueID, OptionID)
VALUES
    ('APPRO2-WHT', 'Apple Inc.', NOW() + INTERVAL '30 days', 50, 5,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Color: White' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'APPRO2-S1')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'APPRO2-S1'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color'));

-- Galaxy Watch 6 Variations
INSERT INTO PRODUCT_VARIATION (VariationID, ProductID, Status, StockLevel, Weight, OptionCombination, Price, OptionValueID, OptionID)
VALUES
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'GW6-S1'), 'Available', 40, 0.3, 'Color: Black', 299.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color')),
    (uuid_generate_v4(), (SELECT ProductID FROM PRODUCT WHERE SKU = 'GW6-S1'), 'Available', 30, 0.3, 'Color: Silver', 309.99,
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color'));

-- Galaxy Watch 6 SKUs
INSERT INTO SKU_MANAGEMENT (SKU, SupplierName, RestockDate, StockLevel, RestockThreshold, VariationID, ProductID, OptionValueID, OptionID)
VALUES
    ('GW6-BLK', 'Samsung Inc.', NOW() + INTERVAL '30 days', 40, 10,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Color: Black' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'GW6-S1')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'GW6-S1'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color')),
    ('GW6-SLV', 'Samsung Inc.', NOW() + INTERVAL '30 days', 30, 10,
     (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Color: Silver' AND ProductID = (SELECT ProductID FROM PRODUCT WHERE SKU = 'GW6-S1')),
     (SELECT ProductID FROM PRODUCT WHERE SKU = 'GW6-S1'),
     (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color') LIMIT 1),
     (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color'));
