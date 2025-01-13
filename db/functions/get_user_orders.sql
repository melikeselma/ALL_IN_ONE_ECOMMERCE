DROP FUNCTION IF EXISTS get_user_order_items(TEXT, UUID);

CREATE OR REPLACE FUNCTION get_user_order_items(
    p_user_email TEXT DEFAULT NULL,  -- Optional: User email
    p_user_id UUID DEFAULT NULL      -- Optional: User ID
) RETURNS TABLE (
    OrderItemID UUID,
    ProductName VARCHAR(150),
    VariationDetails VARCHAR(255),
    ShopName VARCHAR(150),
    ShopRegistrationNumber UUID,
    ShippingStatus delivery_status_enum,
    TrackingNumber UUID,
    DeliveryDate TIMESTAMP,
    Price FLOAT,
    Quantity INT,
    OrderStatus order_status_enum
) AS $$
DECLARE
    v_user_id UUID;
BEGIN
    -- Step 1: Resolve UserID based on the provided email or user ID
    IF p_user_email IS NOT NULL THEN
        SELECT UserID INTO v_user_id
        FROM "USER"
        WHERE Email = p_user_email;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'No user found with the provided email: %', p_user_email;
        END IF;
    ELSE
        v_user_id := p_user_id;
    END IF;

    -- Step 2: Ensure a valid UserID is available
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'A valid user email or user ID must be provided.';
    END IF;

    -- Step 3: Return order items for the resolved UserID
    RETURN QUERY
    SELECT
        oi.OrderItemID,
        p.ProductName::VARCHAR(150),          -- Cast to match the RETURNS TABLE definition
        pv.OptionCombination::VARCHAR(255),  -- Cast to match the RETURNS TABLE definition
        s.ShopName::VARCHAR(150),            -- Cast to match the RETURNS TABLE definition
        sp.RegistrationNumber AS ShopRegistrationNumber,
        sh.DeliveryStatus AS ShippingStatus,
        sh.TrackingNumber,
        sh.DeliveryDate,
        oi.Price,
        oi.Quantity,
        oi.OrderStatus
    FROM ORDER_ITEM oi
    JOIN APPROVED_CART ac ON oi.ApprovedCartID = ac.ApprovedCartID
    JOIN APPROVE_ITEM ai ON ai.ApprovedCartID = ac.ApprovedCartID
    JOIN PRODUCT_VARIATION pv ON ai.VariationID = pv.VariationID
                             AND ai.ProductID = pv.ProductID
    JOIN PRODUCT p ON pv.ProductID = p.ProductID
    JOIN SHOP_SELLS_PRODUCT sp ON pv.ProductID = sp.ProductID
    JOIN SHOP s ON sp.RegistrationNumber = s.RegistrationNumber
    LEFT JOIN SHIPPED sh ON sh.OrderItemID = oi.OrderItemID
                        AND sh.ApprovedCartID = ac.ApprovedCartID
    WHERE ai.UserID = v_user_id
    ORDER BY oi.OrderStatus, sh.DeliveryStatus, p.ProductName;
END;
$$ LANGUAGE plpgsql;



SELECT * FROM get_user_order_items( 'john.doe@gmail.com');
