-- Insert Logistics Companies
INSERT INTO LOGISTIC (LogisticID, CompanyName, DeliveryStatus, LogisticType)
VALUES
    (uuid_generate_v4(), 'FedEx', 'Pending', 'MOSA_JET'),
    (uuid_generate_v4(), 'DHL', 'InTransit', 'MOSA_JET'),
    (uuid_generate_v4(), 'UPS', 'Delivered', 'OTHER'),
    (uuid_generate_v4(), 'USPS', 'Pending', 'OTHER'),
    (uuid_generate_v4(), 'Amazon Logistics', 'InTransit', 'MOSA_JET'),
    (uuid_generate_v4(), 'BlueDart', 'Delivered', 'MOSA_JET'),
    (uuid_generate_v4(), 'India Post', 'Pending', 'OTHER'),
    (uuid_generate_v4(), 'Canada Post', 'InTransit', 'MOSA_JET'),
    (uuid_generate_v4(), 'Royal Mail', 'Delivered', 'OTHER'),
    (uuid_generate_v4(), 'Aramex', 'Pending', 'MOSA_JET');
