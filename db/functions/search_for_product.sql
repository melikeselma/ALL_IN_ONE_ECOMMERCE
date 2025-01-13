DROP FUNCTION IF EXISTS search_products(TEXT, TEXT, TEXT, DOUBLE PRECISION, DOUBLE PRECISION);

CREATE OR REPLACE FUNCTION search_products(
    search_term TEXT DEFAULT NULL,     -- Product name filter
    category_term TEXT DEFAULT NULL,  -- Category name filter
    brand_term TEXT DEFAULT NULL,     -- Brand name filter
    min_price FLOAT DEFAULT NULL,     -- Minimum price filter
    max_price FLOAT DEFAULT NULL      -- Maximum price filter
)
RETURNS TABLE (
    ProductID UUID,               -- Unique ID for the product
    VariationID UUID,             -- Unique ID for the variation
    ProductName VARCHAR(150),     -- Match schema type
    Brand VARCHAR(100),           -- Match schema type
    SKU VARCHAR(100),             -- Match schema type
    OptionCombination VARCHAR(255), -- Match schema type
    StockLevel INT,
    FinalPrice FLOAT,
    ShopName VARCHAR(150),        -- Match schema type
    ShopRate FLOAT,
    CategoryName VARCHAR(100)     -- Match schema type
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        p.ProductID,
        pv.VariationID,
        p.ProductName,
        p.Brand,
        p.SKU,
        pv.OptionCombination,
        sm.StockLevel,
        (p.BasePrice + pv.Price) AS FinalPrice, -- Calculate final price dynamically
        s.ShopName,
        s.ShopRate,
        c.CategoryName
    FROM
        PRODUCT p
    JOIN
        PRODUCT_VARIATION pv ON p.ProductID = pv.ProductID
    JOIN
        SKU_MANAGEMENT sm ON pv.VariationID = sm.VariationID AND pv.ProductID = sm.ProductID
    JOIN
        SHOP_SELLS_PRODUCT sp ON sm.ProductID = sp.ProductID
    JOIN
        SHOP s ON sp.RegistrationNumber = s.RegistrationNumber
    JOIN
        PRODUCT_CONTAINS_CATEGORY pc ON p.ProductID = pc.ProductID
    JOIN
        CATEGORY c ON pc.CategoryID = c.CategoryID
    WHERE
        -- Optional product name filter
        (search_term IS NULL OR p.ProductName ILIKE '%' || search_term || '%')
        -- Optional category filter
        AND (category_term IS NULL OR c.CategoryName ILIKE '%' || category_term || '%')
        -- Optional brand filter
        AND (brand_term IS NULL OR p.Brand ILIKE '%' || brand_term || '%')
        -- Optional price range filter
        AND (min_price IS NULL OR (p.BasePrice + pv.Price) >= min_price)
        AND (max_price IS NULL OR (p.BasePrice + pv.Price) <= max_price)
    ORDER BY
        FinalPrice ASC; -- Sort by final price
END;
$$ LANGUAGE plpgsql;

SELECT * FROM search_products(
    search_term := 'iPhone',
    category_term := 'Smartphones',
    brand_term := 'Apple'
);
