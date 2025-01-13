-- Insert Addresses
-- Insert Addresses
INSERT INTO ADDRESS (
    AddressID, ZipCode, Neighbourhood, Province, City, Country, Flat, Apartment, AddressType, UserID, RegistrationNumber
)
VALUES
    -- Customer Addresses
    (uuid_generate_v4(), '10001', 'Manhattan', 'New York', 'New York', 'USA', '10B', '3A', 'DeliveryPoint',
        (SELECT UserID FROM CUSTOMER WHERE UserID = (SELECT UserID FROM "USER" WHERE Email = 'john.doe@gmail.com')), NULL),
    (uuid_generate_v4(), '94105', 'SOMA', 'California', 'San Francisco', 'USA', '12C', '8F', 'DeliveryPoint',
        (SELECT UserID FROM CUSTOMER WHERE UserID = (SELECT UserID FROM "USER" WHERE Email = 'jane.smith@yahoo.com')), NULL),
    (uuid_generate_v4(), '60611', 'Near North Side', 'Illinois', 'Chicago', 'USA', '4E', '7B', 'DeliveryPoint',
        (SELECT UserID FROM CUSTOMER WHERE UserID = (SELECT UserID FROM "USER" WHERE Email = 'alice.johnson@outlook.com')), NULL);