SELECT p.*
FROM PRODUCT p
JOIN PRODUCT_CONTAINS_CATEGORY pc ON p.ProductID = pc.ProductID
JOIN CATEGORY c ON pc.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Smartphones';