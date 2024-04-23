CREATE DATABASE IF NOT EXISTS `MichaelsBookClub`;

USE `MichaelsBookClub`;

CREATE TABLE IF NOT EXISTS `Coupons`(
    `CouponID` INT(11) NOT NULL AUTO_INCREMENT,
    `Code` VARCHAR(30) NOT NULL,
    `DiscountPercent` TINYINT NOT NULL,
    `Expires` DATETIME NOT NULL,
    
    PRIMARY KEY (`CouponID`)
);

CREATE TABLE IF NOT EXISTS `Books`(
    `BookID` INT(11) NOT NULL AUTO_INCREMENT,
    `ReleasedOn` INT NOT NULL,
    `Stock` INT NOT NULL,
    `Genre` VARCHAR(20) NOT NULL,
    `Category` VARCHAR(20) NOT NULL,
    `Price` INT NOT NULL,
    `Name` VARCHAR(50) NOT NULL,
    `ISBN` INT NOT NULL,
    `Language` VARCHAR(30) NOT NULL,

    PRIMARY KEY (`BookID`)
);

CREATE TABLE IF NOT EXISTS `Authors`(
    `AuthorID` INT(11) NOT NULL AUTO_INCREMENT,
    `Name` VARCHAR(30) NOT NULL,
    `Published` DATETIME NOT NULL,

    PRIMARY KEY(`AuthorID`)
);


CREATE TABLE IF NOT EXISTS `AuthorBooks`(
    `ABID` INT(11) NOT NULL AUTO_INCREMENT,
    `AuthorID` INT(11) NOT NULL,
    `BookID` INT(11) NOT NULL,

    PRIMARY KEY(`ABID`),
    FOREIGN KEY(`AuthorID`) REFERENCES `Authors` (`AuthorID`),
    FOREIGN KEY(`BookID`) REFERENCES `Books` (`BookID`)
);

CREATE TABLE IF NOT EXISTS `Cities`(
    `CityID` INT(11) NOT NULL AUTO_INCREMENT,
    `City` VARCHAR(30) NOT NULL,
    `ZipCode` INT NOT NULL,

    PRIMARY KEY(`CityID`)
);

CREATE TABLE IF NOT EXISTS `Addresses`(
    `AddressID` INT(11) NOT NULL AUTO_INCREMENT,
    `CityID` INT(11) NOT NULL,
    `StreetName` VARCHAR(30) NOT NULL,
    `HouseNumber` VARCHAR(15) NOT NULL,

    PRIMARY KEY(`AddressID`)
);
CREATE TABLE IF NOT EXISTS `Customers`(
    `CustomerID` INT(11) NOT NULL AUTO_INCREMENT,
    `AddressID` INT NOT NULL,
    `Name` VARCHAR(50) NOT NULL,
    `Password` VARCHAR(256) NOT NULL,
    `Email` VARCHAR(256) NOT NULL,
    `CreatedAt` DATETIME NOT NULL,

    PRIMARY KEY(`CustomerID`),
    FOREIGN KEY(`AddressID`) REFERENCES `Addresses` (`AddressID`)
);

CREATE TABLE IF NOT EXISTS `Orders`(
    `OrderID` INT(11) NOT NULL AUTO_INCREMENT,
    `CustomerID` INT NOT NULL,
    `CouponID` INT,
    `TotalPrice` DOUBLE NOT NULL,
    `CreatedAt` DATETIME NOT NULL,

    PRIMARY KEY(`OrderID`),
    FOREIGN KEY(`CustomerID`) REFERENCES `Customers` (`CustomerID`),
    FOREIGN KEY(`CouponID`) REFERENCES `Coupons` (`CouponID`)
);

CREATE TABLE IF NOT EXISTS `OrderItems`(
    `OrderItemID` INT(11) NOT NULL AUTO_INCREMENT,
    `BookID` INT NOT NULL,
    `OrderID` INT NOT NULL,
    `Price` DOUBLE NOT NULL,
    `Quantity` INT NOT NULL,

    PRIMARY KEY(`OrderItemID`),
    FOREIGN KEY(`BookID`) REFERENCES `Books` (`BookID`),
    FOREIGN KEY(`OrderID`) REFERENCES `Orders` (`OrderID`)
);

INSERT INTO Coupons (Code, DiscountPercent, Expires) VALUES
('10OFF', 10, '2025-05-10 22:55:52'),
('20OFF', 25, '2027-12-31 23:59:59'),
('HALF', 50, '2031-10-13 12:00:00'),
('75OFF', 75, '2028-01-01 00:00:00'),
('GUNPOINT_DISCOUNT', 100, '2034-08-14 14:08:04');

INSERT INTO Cities (City, ZipCode) VALUES
('Slagelse', 4200),
('Amagerbro', 2300),
('Sorø', 4180),
('Hellerup', 2900),
('Albertslund', 2620);

INSERT INTO Addresses (CityID, StreetName, HouseNumber) VALUES
(1, 'Sorøvej', '1'),
(2, 'Store mølle vej', '2'),
(3, 'Slagelsevej', '3'),
(4, 'Forårsvej', '4'),
(5, 'Teglmosevej', '5');

INSERT INTO Customers (AddressID, Name, Password, Email, CreatedAt) VALUES
(1, 'Shazil Shahid', 'hashedvalue', 'terrorist@techtonic.com', NOW()),
(2, 'Marcus Lystrup', 'hashedvalue', 'Marcusse@gmail.com', NOW()),
(3, 'Yordan Mitov', 'hashedvalue', 'linuxlover@gmail.com', NOW()),
(4, 'Lucas Bangsborg', 'hashedvalue', 'LucasBangersborg@outlook.com', NOW()),
(5, 'Magnus Lund', 'hashedvalue', 'magussy@hotmail.com', NOW());

INSERT INTO Authors (Name) VALUES
('Michael Hansen'),
('Tom Stevns'),
('David Svarrer'),
('Yordan Yapster'),
('Mikkel Krøll');

INSERT INTO Books (ReleasedOn, Stock, Genre, Category, Price, Name, ISBN, Language) VALUES
('2012-02-01', 6, 'Romance', 'Women', 59, 'The lover boyz', 1234567890, 'English'),
('2022-05-22', 8, 'Fiction', 'Teenagers', 29, 'No facts', 1234567891, 'English'),
('2024-03-04', 15, 'Sci-fi', 'Boys', 39, 'Star claws', 1234567892, 'English'),
('2021-11-14', 22, 'Fiction', 'Boys', 69, 'Doomsday', 1234567893, 'English'),
('2018-12-19', 5, 'Horror', 'Adults', 100, 'Zombies in spaceland', 1234567894, 'English');

INSERT INTO AuthorsBooks (AuthorID, BookID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO Orders (CustomerID, CouponID, CreatedAt, TotalPrice) VALUES
(1, 1, '2024-10-03 16:14:32', 90),
(2, 2, '2027-01-21 07:25:27', 180),
(3, 3, '2033-11-05 12:17:54', 270),
(4, 4, '2034-06-06 16:25:31', 360),
(5, 5, '2028-07-16 18:21:53', 450);

INSERT INTO OrderItems (BookID, OrderID, Price, Quantity) VALUES
(1, 1, 59, 2),
(2, 1, 29, 1),
(2, 2, 29, 1),
(3, 3, 39, 1),
(4, 4, 69, 1),
(5, 5, 100, 1);
