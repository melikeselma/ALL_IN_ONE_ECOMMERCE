-- Insert Carts for Each Customer
INSERT INTO CART (CartID, UserID, CartStatus, CreateDate, UpdateDate, TotalPrice)
SELECT
    uuid_generate_v4(),           -- Generate a unique CartID
    UserID,                       -- Use the existing UserID from CUSTOMER
    'Active',                     -- Default CartStatus
    CURRENT_TIMESTAMP,            -- CreateDate
    CURRENT_TIMESTAMP,            -- UpdateDate
    0.0                           -- Initial TotalPrice
FROM CUSTOMER;
