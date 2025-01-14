SELECT
    s.ShopName,
    p.ProductName,
    pv.OptionCombination AS VariationDetails,
    sm.SKU,
    sm.StockLevel,
    sm.RestockThreshold,
    sm.RestockDate,
    sp.Price AS ShopPrice
FROM SHOP s
JOIN SHOP_SELLS_PRODUCT sp ON s.RegistrationNumber = sp.RegistrationNumber
JOIN PRODUCT p ON sp.ProductID = p.ProductID
JOIN PRODUCT_VARIATION pv ON p.ProductID = pv.ProductID
JOIN SKU_MANAGEMENT sm ON pv.VariationID = sm.VariationID AND pv.ProductID = sm.ProductID
WHERE s.ShopName ILIKE '%' || 'TechZone' || '%'
  AND sp.Price BETWEEN 500 AND 2000  -- Add this line for price range filtering
ORDER BY s.ShopName, p.ProductName, sm.StockLevel DESC;

