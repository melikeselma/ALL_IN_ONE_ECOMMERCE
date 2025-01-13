DROP FUNCTION IF EXISTS GetUserCartItems(TEXT, UUID, BOOLEAN);

CREATE OR REPLACE FUNCTION GetUserCartItems(
    p_user_email TEXT DEFAULT NULL,  -- Optional: User email
    p_user_id UUID DEFAULT NULL      -- Optional: User ID
) RETURNS TABLE (
    CartItemID UUID,
    ProductName VARCHAR(150),
    VariationDetails VARCHAR(255),
    ShopName VARCHAR(150),
    ShopRegistrationNumber UUID,
    Price FLOAT,
    Quantity INT,
    IsApproved BOOLEAN,              -- Dynamically included if it exists
    IsActive BOOLEAN
) AS $$
DECLARE
    v_user_id UUID;
    v_is_approved_exists BOOLEAN := FALSE;
BEGIN
    -- Step 1: Check if IsApproved column exists in APPROVE_ITEM table
    PERFORM 1
    FROM information_schema.columns
    WHERE table_name = 'approve_item'
      AND column_name = 'isapproved';

    IF FOUND THEN
        v_is_approved_exists := TRUE;
    END IF;

    -- Step 2: Resolve UserID based on the provided email or user ID
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

    -- Step 3: Ensure a valid UserID is available
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'A valid user email or user ID must be provided.';
    END IF;

    -- Step 4: Return cart items for the resolved UserID
    IF v_is_approved_exists THEN
        -- Query includes IsApproved column
        RETURN QUERY
        SELECT
            ci.CartItemID,
            p.ProductName::VARCHAR(150),          -- Cast to match the RETURNS TABLE definition
            pv.OptionCombination::VARCHAR(255),  -- Cast to match the RETURNS TABLE definition
            s.ShopName::VARCHAR(150),            -- Cast to match the RETURNS TABLE definition
            sp.RegistrationNumber AS ShopRegistrationNumber,
            ci.finalprice,
            ci.Quantity,                       -- Include IsApproved if it exists
            ci.IsActive
        FROM CART_ITEM ci
        JOIN APPROVE_ITEM ai ON ci.CartItemID = ai.CartItemID
        JOIN PRODUCT_VARIATION pv ON ci.VariationID = pv.VariationID
        JOIN PRODUCT p ON pv.ProductID = p.ProductID
        JOIN SHOP_SELLS_PRODUCT sp ON pv.ProductID = sp.ProductID
        JOIN SHOP s ON sp.RegistrationNumber = s.RegistrationNumber
        WHERE ai.UserID = v_user_id
        ORDER BY ci.IsActive DESC, p.ProductName;

    ELSE
        -- Query excludes IsApproved column
        RETURN QUERY
        SELECT
            ci.CartItemID,
            p.ProductName::VARCHAR(150),          -- Cast to match the RETURNS TABLE definition
            pv.OptionCombination::VARCHAR(255),  -- Cast to match the RETURNS TABLE definition
            s.ShopName::VARCHAR(150),            -- Cast to match the RETURNS TABLE definition
            sp.RegistrationNumber AS ShopRegistrationNumber,
            ci.finalprice,
            ci.Quantity,
            NULL AS IsApproved,                  -- Return NULL for IsApproved
            ci.IsActive
        FROM CART_ITEM ci
        JOIN APPROVE_ITEM ai ON ci.CartItemID = ai.CartItemID
        JOIN PRODUCT_VARIATION pv ON ci.VariationID = pv.VariationID
        JOIN PRODUCT p ON pv.ProductID = p.ProductID
        JOIN SHOP_SELLS_PRODUCT sp ON pv.ProductID = sp.ProductID
        JOIN SHOP s ON sp.RegistrationNumber = s.RegistrationNumber
        WHERE ai.UserID = v_user_id
        ORDER BY ci.IsActive DESC, p.ProductName;
    END IF;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM GetUserCartItems(NULL, 'user@example.com', FALSE);
