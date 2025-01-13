DO $$
DECLARE
    new_product_id UUID;
    seller_registration_number UUID;
BEGIN
    -- Step 1: Get the seller's shop registration number
    SELECT RegistrationNumber INTO seller_registration_number
    FROM SELLER
    WHERE UserID = 'b6b8a683-94c4-45f3-8b46-882dced06b03'; -- Replace with the actual seller's UserID

    IF seller_registration_number IS NULL THEN
        RAISE EXCEPTION 'Seller does not have an associated shop.';
    END IF;

    -- Step 2: Insert the new product
    INSERT INTO PRODUCT (ProductID, ProductName, Brand, SKU, ShortDescription, Description, IsApproved, Status, Rating, BasePrice)
    VALUES
        (uuid_generate_v4(), 'iPhone14', 'Apple', 'IP14-S1', 'iphone best phone',
         'iPhone with brand new colors', TRUE, 'Available', 4.8, 1072.00)
    RETURNING ProductID INTO new_product_id;

    -- Step 3: Add product variations by selecting existing option values
    INSERT INTO PRODUCT_VARIATION (VariationID, ProductID, Status, StockLevel, Weight, OptionCombination, Price, OptionValueID, OptionID)
    VALUES
        -- Variation 1: Black, 128GB
        (uuid_generate_v4(), new_product_id, 'Available', 100, 0.4, 'Color: Black, Storage: 128GB', 749.99,
         (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color' LIMIT 1) AND DimensionImpact = 0 LIMIT 1),
         (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color' LIMIT 1)),

        -- Variation 2: White, 256GB
        (uuid_generate_v4(), new_product_id, 'Available', 50, 0.4, 'Color: White, Storage: 256GB', 849.99,
         (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Storage' LIMIT 1) AND AdditionalPrice = 100 LIMIT 1),
         (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Storage' LIMIT 1));

    -- Step 4: Add SKU management for variations
    INSERT INTO SKU_MANAGEMENT (SKU, SupplierName, RestockDate, StockLevel, RestockThreshold, VariationID, ProductID, OptionValueID, OptionID)
    VALUES
        ('SMZ-BLK-128', 'TechBrand Supplier', NOW() + INTERVAL '30 days', 100, 10,
         (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Color: Black, Storage: 128GB' AND ProductID = new_product_id),
         new_product_id,
         (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color' LIMIT 1) LIMIT 1),
         (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Color' LIMIT 1)),

        ('SMZ-WHT-256', 'TechBrand Supplier', NOW() + INTERVAL '30 days', 50, 10,
         (SELECT VariationID FROM PRODUCT_VARIATION WHERE OptionCombination = 'Color: White, Storage: 256GB' AND ProductID = new_product_id),
         new_product_id,
         (SELECT OptionValueID FROM OPTION_VALUE WHERE OptionID = (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Storage' LIMIT 1) LIMIT 1),
         (SELECT OptionID FROM PRODUCT_OPTION WHERE OptionName = 'Storage' LIMIT 1));

    -- Step 5: Link product to the seller's shop
    INSERT INTO SHOP_SELLS_PRODUCT (RegistrationNumber, ProductID, StockLevel, Price)
    VALUES
        (seller_registration_number, new_product_id, 150, 749.99);

END $$;
