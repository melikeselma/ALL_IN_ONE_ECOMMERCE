

-- Insert Shops
INSERT INTO SHOP (RegistrationNumber, ShopDescription, ShopRate, ShopName, ShopPhone)
VALUES
    (uuid_generate_v4(), 'Electronics and gadgets store', 4.8, 'TechZone', '1234567890'),
    (uuid_generate_v4(), 'Premium Apple products reseller', 4.9, 'iStore', '0987654321'),
    (uuid_generate_v4(), 'Gaming and accessories store', 4.7, 'GameHaven', '1122334455'),
    (uuid_generate_v4(), 'Mobile phones and accessories', 4.6, 'MobileMart', '5566778899'),
    (uuid_generate_v4(), 'Affordable electronics', 4.5, 'ElectroHub', '6677889900'),
    (uuid_generate_v4(), 'High-quality audio products', 4.8, 'SoundWorld', '7788990011'),
    (uuid_generate_v4(), 'Gaming laptops and PCs', 4.7, 'GamingGear', '8899001122'),
    (uuid_generate_v4(), 'Photography equipment and accessories', 4.9, 'PhotoExpert', '9900112233'),
    (uuid_generate_v4(), 'Smart home devices', 4.6, 'SmartHomeHub', '1002003004'),
    (uuid_generate_v4(), 'Fitness and wearable technology', 4.7, 'FitTech', '3004005006'),
    (uuid_generate_v4(), 'Office supplies and accessories', 4.4, 'OfficeWorld', '5006007008'),
    (uuid_generate_v4(), 'PC parts and custom builds', 4.9, 'BuildYourPC', '6007008009'),
    (uuid_generate_v4(), 'Gaming consoles and accessories', 4.7, 'ConsoleZone', '7008009000'),
    (uuid_generate_v4(), 'Drone and camera equipment', 4.6, 'DronePro', '8009001001'),
    (uuid_generate_v4(), 'Tech gadgets and innovations', 4.8, 'InnoTech', '9001002002');


-- Insert Users
INSERT INTO "USER" (UserID, FirstName, LastName, PhoneNumber, HashedPassword, Email, UserType)
VALUES
    (uuid_generate_v4(), 'John', 'Doe', '1112223333', 'hashed_password_1', 'john.doe@example.com', 'Seller'),
    (uuid_generate_v4(), 'Jane', 'Smith', '4445556666', 'hashed_password_2', 'jane.smith@example.com', 'Seller'),
    (uuid_generate_v4(), 'Alice', 'Johnson', '7778889990', 'hashed_password_3', 'alice.johnson@example.com', 'Seller'),
    (uuid_generate_v4(), 'Bob', 'Brown', '9998887776', 'hashed_password_4', 'bob.brown@example.com', 'Seller'),
    (uuid_generate_v4(), 'Charlie', 'Davis', '6665554443', 'hashed_password_5', 'charlie.davis@example.com', 'Seller'),
    (uuid_generate_v4(), 'Emma', 'Williams', '1113335557', 'hashed_password_6', 'emma.williams@example.com', 'Seller'),
    (uuid_generate_v4(), 'Liam', 'Martinez', '2224446668', 'hashed_password_7', 'liam.martinez@example.com', 'Seller'),
    (uuid_generate_v4(), 'Sophia', 'Garcia', '3335557779', 'hashed_password_8', 'sophia.garcia@example.com', 'Seller'),
    (uuid_generate_v4(), 'James', 'Lopez', '4446668880', 'hashed_password_9', 'james.lopez@example.com', 'Seller'),
    (uuid_generate_v4(), 'Olivia', 'Hernandez', '5557779991', 'hashed_password_10', 'olivia.hernandez@example.com', 'Seller'),
    (uuid_generate_v4(), 'Ethan', 'Rodriguez', '6668880002', 'hashed_password_11', 'ethan.rodriguez@example.com', 'Seller'),
    (uuid_generate_v4(), 'Mia', 'Wilson', '7779991113', 'hashed_password_12', 'mia.wilson@example.com', 'Seller'),
    (uuid_generate_v4(), 'Noah', 'Perez', '8880002224', 'hashed_password_13', 'noah.perez@example.com', 'Seller'),
    (uuid_generate_v4(), 'Ava', 'Gonzalez', '9991113335', 'hashed_password_14', 'ava.gonzalez@example.com', 'Seller'),
    (uuid_generate_v4(), 'Lucas', 'Anderson', '0002224446', 'hashed_password_15', 'lucas.anderson@example.com', 'Seller');


-- Insert Sellers
INSERT INTO SELLER (UserID, RegistrationNumber, SellerRate)
VALUES
    ((SELECT UserID FROM "USER" WHERE Email = 'john.doe@example.com'),
     (SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'TechZone'), 4.7),
    ((SELECT UserID FROM "USER" WHERE Email = 'jane.smith@example.com'),
     (SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'iStore'), 4.9),
    ((SELECT UserID FROM "USER" WHERE Email = 'alice.johnson@example.com'),
     (SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'GameHaven'), 4.6),
    ((SELECT UserID FROM "USER" WHERE Email = 'bob.brown@example.com'),
     (SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'MobileMart'), 4.5),
    ((SELECT UserID FROM "USER" WHERE Email = 'charlie.davis@example.com'),
     (SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'ElectroHub'), 4.4),
    ((SELECT UserID FROM "USER" WHERE Email = 'emma.williams@example.com'),
     (SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'SoundWorld'), 4.8),
    ((SELECT UserID FROM "USER" WHERE Email = 'liam.martinez@example.com'),
     (SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'GamingGear'), 4.7),
    ((SELECT UserID FROM "USER" WHERE Email = 'sophia.garcia@example.com'),
     (SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'PhotoExpert'), 4.9),
    ((SELECT UserID FROM "USER" WHERE Email = 'james.lopez@example.com'),
     (SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'SmartHomeHub'), 4.6),
    ((SELECT UserID FROM "USER" WHERE Email = 'olivia.hernandez@example.com'),
     (SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'FitTech'), 4.7),
    ((SELECT UserID FROM "USER" WHERE Email = 'ethan.rodriguez@example.com'),
     (SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'OfficeWorld'), 4.4),
    ((SELECT UserID FROM "USER" WHERE Email = 'mia.wilson@example.com'),
     (SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'BuildYourPC'), 4.9),
    ((SELECT UserID FROM "USER" WHERE Email = 'noah.perez@example.com'),
     (SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'ConsoleZone'), 4.7),
    ((SELECT UserID FROM "USER" WHERE Email = 'ava.gonzalez@example.com'),
     (SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'DronePro'), 4.6),
    ((SELECT UserID FROM "USER" WHERE Email = 'lucas.anderson@example.com'),
     (SELECT RegistrationNumber FROM SHOP WHERE ShopName = 'InnoTech'), 4.8);
