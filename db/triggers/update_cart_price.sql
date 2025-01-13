CREATE OR REPLACE FUNCTION update_cart_total_price()
RETURNS TRIGGER AS $$
BEGIN
    -- Update the TotalPrice in the CART table
    UPDATE CART
    SET TotalPrice = COALESCE((
        SELECT SUM(FinalPrice)
        FROM CART_ITEM
        WHERE CartID = NEW.CartID
    ), 0),
    UpdateDate = CURRENT_TIMESTAMP
    WHERE CartID = NEW.CartID;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_cart_total
AFTER INSERT OR DELETE OR UPDATE ON CART_ITEM
FOR EACH ROW
EXECUTE FUNCTION update_cart_total_price();
