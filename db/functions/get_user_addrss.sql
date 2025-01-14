SELECT
    u.Email AS CustomerEmail,
    a.AddressID,
    a.ZipCode,
    a.Neighbourhood,
    a.Province,
    a.City,
    a.Country,
    a.Flat,
    a.Apartment,
    a.AddressType
FROM ADDRESS a
JOIN CUSTOMER c ON a.UserID = c.UserID
JOIN "USER" u ON c.UserID = u.UserID
WHERE u.Email = 'john.doe@example.com';
