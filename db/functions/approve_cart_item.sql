CREATE OR REPLACE FUNCTION approve_cart_items(
    p_cart_id UUID,                   -- CartID to be approved
    p_cart_item_ids UUID[],           -- Array of CartItemIDs to approve
    p_payment_id UUID                 -- PaymentID for the approved cart
) RETURNS UUID AS $$
DECLARE
    v_approved_cart_id UUID;
    v_total_price FLOAT := 0.0;
BEGIN
    -- Step 1: Create a new ApprovedCart
    INSERT INTO APPROVED_CART (ApprovedCartID, TotalPrice, PaymentID)
    VALUES (uuid_generate_v4(), 0, p_payment_id)
    RETURNING ApprovedCartID INTO v_approved_cart_id;

    -- Debug: Raise notice to ensure ApprovedCartID is created
    RAISE NOTICE 'ApprovedCartID created: %', v_approved_cart_id;

    -- Step 2: Add the selected CartItems to APPROVE_ITEM
    INSERT INTO APPROVE_ITEM (
        ApprovedCartID, CartItemID, VariationID, OptionValueID, OptionID, ProductID, UserID
    )
    SELECT
        v_approved_cart_id, CartItemID, VariationID, OptionValueID, OptionID, ProductID, UserID
    FROM CART_ITEM
    WHERE CartID = p_cart_id
      AND CartItemID = ANY(p_cart_item_ids);

    -- Debug: Raise notice to ensure rows are inserted
    RAISE NOTICE 'Rows added to APPROVE_ITEM for ApprovedCartID: %', v_approved_cart_id;

    -- Step 3: Calculate TotalPrice for ApprovedCart (for selected CartItems only)
    SELECT COALESCE(SUM(FinalPrice), 0)
    INTO v_total_price
    FROM CART_ITEM
    WHERE CartID = p_cart_id
      AND CartItemID = ANY(p_cart_item_ids);

    -- Debug: Raise notice for total price
    RAISE NOTICE 'Total Price calculated: %', v_total_price;

    -- Step 4: Update the TotalPrice in APPROVED_CART
    UPDATE APPROVED_CART
    SET TotalPrice = v_total_price
    WHERE ApprovedCartID = v_approved_cart_id;

    -- Step 5: Return the ApprovedCartID
    RETURN v_approved_cart_id;
END;
$$ LANGUAGE plpgsql;


SELECT approve_cart_items(
    p_cart_id := '2db8d15b-eefa-46a5-8a26-024851050c25'::UUID,
    p_cart_item_ids := ARRAY[
        'c4d9a2bc-0744-474c-885d-c8e9f7cc8aad'
    ]::UUID[],
    p_payment_id := '4d3b4745-8d3f-48f2-8664-4481c2375600'::UUID
);
