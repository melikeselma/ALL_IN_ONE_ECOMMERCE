CREATE OR REPLACE FUNCTION add_product_to_cart(
    p_user_id UUID,
    p_cart_id UUID,
    p_variation_id UUID,
    p_product_id UUID,
    p_option_value_id UUID,
    p_option_id UUID,
    p_quantity INT,
    p_discount_id UUID DEFAULT NULL
) RETURNS VOID AS $$
DECLARE
    v_final_price FLOAT;
BEGIN
    -- Calculate the final price for the cart item
    SELECT (p.BasePrice + pv.Price) * p_quantity
    INTO v_final_price
    FROM PRODUCT p
    JOIN PRODUCT_VARIATION pv ON p.ProductID = pv.ProductID
    WHERE pv.VariationID = p_variation_id;

    -- Insert the product into the cart item
    INSERT INTO CART_ITEM (
        CartID, VariationID, ProductID, OptionValueID, OptionID, UserID, DiscountID, Quantity, FinalPrice
    ) VALUES (
        p_cart_id, p_variation_id, p_product_id, p_option_value_id, p_option_id, p_user_id, p_discount_id, p_quantity, v_final_price
    );

    -- Update the cart total (handled by the trigger)
END;
$$ LANGUAGE plpgsql;

SELECT add_product_to_cart(
    p_user_id := 'ca17da4b-ce27-4a12-a911-fba36324d243',
    p_cart_id := '2db8d15b-eefa-46a5-8a26-024851050c25',
    p_variation_id := '53ddd8cc-3c5f-469c-8add-1a5fd6805ec8',
    p_product_id := '881e6169-b564-4c64-9cbe-9d83c59c05f5',
    p_option_value_id := '03fb1dee-30ae-4b6d-8b59-6af537f66ddf',
    p_option_id := '5a54be35-755d-46e3-953f-543e2875700b',
    p_quantity := 2
);
