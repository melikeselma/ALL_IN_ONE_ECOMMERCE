CREATE OR REPLACE FUNCTION order_approved_cart(
    p_approved_cart_id UUID,  -- The ID of the ApprovedCart to be ordered
    p_address_id UUID,        -- The AddressID for shipping
    p_logistic_id UUID        -- The LogisticID for shipping
) RETURNS VOID AS $$
DECLARE
    v_order_item_id UUID;
    v_tracking_number UUID;
    v_shipping_date TIMESTAMP := CURRENT_TIMESTAMP;
BEGIN
    -- Step 1: Insert ORDER_ITEM entries for the ApprovedCart
    INSERT INTO ORDER_ITEM (OrderItemID, ApprovedCartID, Quantity, Price, AppliedDiscount, OrderStatus)
    SELECT
        uuid_generate_v4(),                -- Generate OrderItemID
        ai.ApprovedCartID,                 -- ApprovedCartID
        ci.Quantity,                       -- Quantity from CART_ITEM
        ci.FinalPrice,                     -- Price from CART_ITEM
        'None',                            -- AppliedDiscount (can be updated later)
        'Pending'                          -- Initial OrderStatus
    FROM APPROVE_ITEM ai
    JOIN CART_ITEM ci
      ON ai.CartItemID = ci.CartItemID
     AND ai.UserID = ci.UserID
     AND ai.VariationID = ci.VariationID
     AND ai.ProductID = ci.ProductID
     AND ai.OptionValueID = ci.OptionValueID
     AND ai.OptionID = ci.OptionID
    WHERE ai.ApprovedCartID = p_approved_cart_id;

    -- Step 2: Create SHIPPED entries for the ordered items
    FOR v_order_item_id IN
        SELECT OrderItemID
        FROM ORDER_ITEM
        WHERE ApprovedCartID = p_approved_cart_id
    LOOP
        INSERT INTO SHIPPED (
            TrackingNumber, Receipt, DeliveryDate, DeliveryStatus, ShippingDate, Lprice,
            OrderItemID, ApprovedCartID, AddressID, LogisticID
        )
        VALUES (
            uuid_generate_v4(),            -- Generate unique TrackingNumber
            NULL,                          -- Receipt (to be added later)
            NULL,                          -- DeliveryDate (to be added upon delivery)
            'Pending',                     -- Initial DeliveryStatus
            v_shipping_date,               -- ShippingDate
            0.0,                           -- Initial shipping price (can be updated later)
            v_order_item_id,               -- OrderItemID
            p_approved_cart_id,            -- ApprovedCartID
            p_address_id,                  -- AddressID
            p_logistic_id                  -- LogisticID
        );
    END LOOP;

    -- Step 3: Mark the ApprovedCart, APPROVE_ITEM, and CART_ITEM rows as inactive
    UPDATE APPROVED_CART
    SET IsActive = FALSE
    WHERE ApprovedCartID = p_approved_cart_id;

    UPDATE APPROVE_ITEM
    SET IsActive = FALSE
    WHERE ApprovedCartID = p_approved_cart_id;

    UPDATE CART_ITEM
    SET IsActive = FALSE
    WHERE CartID = (SELECT CartID FROM APPROVED_CART WHERE ApprovedCartID = p_approved_cart_id);

END;
$$ LANGUAGE plpgsql;

SELECT order_approved_cart(
    'bf91e674-2be0-446a-994b-11e4ee09f987', -- ApprovedCartID
    '6c5f408f-b73a-4b3c-8178-b596b55a7bec',       -- AddressID
     '28af129b-19fd-40b4-af1d-9505edf1a5f0'       -- LogisticID
);

