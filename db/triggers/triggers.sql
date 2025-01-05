-- Trigger to Recalculate TotalPrice
CREATE TRIGGER trg_recalculate_order_total
AFTER INSERT OR UPDATE OR DELETE ON ORDER_ITEM
FOR EACH ROW
EXECUTE FUNCTION recalculate_order_total();

-- Trigger to Prevent Negative Stock
CREATE TRIGGER trg_prevent_negative_stock
BEFORE INSERT OR UPDATE ON PRODUCT_VARIATION
FOR EACH ROW
EXECUTE FUNCTION prevent_negative_stock();

-- Trigger to Validate Premium Dates
CREATE TRIGGER trg_validate_premium_dates
BEFORE INSERT OR UPDATE ON PREMIUM
FOR EACH ROW
EXECUTE FUNCTION validate_premium_dates();

-- Trigger to Update Product Rating
CREATE TRIGGER trg_update_product_rating
AFTER INSERT OR UPDATE ON REVIEW
FOR EACH ROW
EXECUTE FUNCTION update_product_rating();

-- Trigger to Recalculate Cart Items
CREATE TRIGGER trg_recalculate_cart_items
AFTER INSERT OR UPDATE OR DELETE ON CART_ITEM
FOR EACH ROW
EXECUTE FUNCTION recalculate_cart_items();



-- Trigger to Stop Premium Membership
CREATE TRIGGER trg_stop_premium
BEFORE UPDATE ON PREMIUM
FOR EACH ROW
WHEN (OLD.PremiumEndDate IS DISTINCT FROM NEW.PremiumEndDate AND NEW.PremiumEndDate IS NULL) -- Example Condition
EXECUTE FUNCTION stop_premium_membership();

