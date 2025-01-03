-- Function to Recalculate TotalPrice
CREATE OR REPLACE FUNCTION recalculate_order_total() RETURNS TRIGGER AS $$
DECLARE
    new_total FLOAT;
BEGIN
    SELECT COALESCE(SUM(Price), 0) INTO new_total
    FROM ORDER_ITEM
    WHERE OrderID = NEW.OrderID;

    UPDATE "ORDER"
    SET TotalPrice = new_total
    WHERE OrderNo = NEW.OrderID;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Function to Prevent Negative Stock
CREATE OR REPLACE FUNCTION prevent_negative_stock() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.StockLevel < 0 THEN
        RAISE EXCEPTION 'Stock level cannot be negative. Tried to set %', NEW.StockLevel;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Function to Validate Premium Dates
CREATE OR REPLACE FUNCTION validate_premium_dates() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.PremiumStartDate >= NEW.PremiumEndDate THEN
        RAISE EXCEPTION 'PremiumStartDate (%s) must be earlier than PremiumEndDate (%s)', 
            NEW.PremiumStartDate, NEW.PremiumEndDate;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Function to Update Product Rating
CREATE OR REPLACE FUNCTION update_product_rating() RETURNS TRIGGER AS $$
DECLARE
    avg_rating FLOAT;
BEGIN
    SELECT COALESCE(AVG(Rating), 0) INTO avg_rating
    FROM REVIEW
    WHERE ProductID = NEW.ProductID;

    UPDATE PRODUCT
    SET Rating = avg_rating
    WHERE ProductID = NEW.ProductID;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Function to Recalculate Cart Items
CREATE OR REPLACE FUNCTION recalculate_cart_items() RETURNS TRIGGER AS $$
DECLARE
    item_count INT;
BEGIN
    SELECT COALESCE(SUM(Quantity), 0) INTO item_count
    FROM CART_ITEM
    WHERE CartID = NEW.CartID;

    UPDATE CART
    SET TotalItems = item_count
    WHERE CartID = NEW.CartID;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
