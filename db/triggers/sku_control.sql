CREATE OR REPLACE FUNCTION fn_check_stock_and_warn()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if the stock level falls below the restock threshold
    IF NEW.StockLevel < NEW.RestockThreshold THEN
        -- Insert a warning into the WARN table
        INSERT INTO WARN (SellerID, SKU, WarningMessage)
        SELECT s.UserID, NEW.SKU,
               'Stock level for SKU ' || NEW.SKU ||
               ' has fallen below the restock threshold (' || NEW.RestockThreshold || ').'
        FROM SELLER s
        INNER JOIN SHOP sh ON s.RegistrationNumber = sh.RegistrationNumber
        WHERE s.RegistrationNumber = (SELECT RegistrationNumber FROM SHOP_SELLS_PRODUCT WHERE ProductID = NEW.ProductID);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_stock_check_and_warn
AFTER UPDATE ON SKU_MANAGEMENT
FOR EACH ROW
EXECUTE FUNCTION fn_check_stock_and_warn();
