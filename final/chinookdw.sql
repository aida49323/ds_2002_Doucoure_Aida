-- Chinook datawarehouse

 DROP DATABASE IF EXISTS `chinook_dw`;
CREATE DATABASE `chinook_dw` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;

use chinook_dw;

DROP TABLE IF EXISTS dim_genre;

 CREATE TABLE `dim_genre` (
  `GenreKey` int NOT NULL,
  `Name` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`GenreKey`)
)  ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

INSERT INTO `chinook_dw`.`dim_genre`
(`GenreKey`,
`Name`)
SELECT
 `genre`.`GenreId`,
    `genre`.`Name`
FROM `chinook`.`genre`;



DROP TABLE IF EXISTS dim_employee; 
CREATE TABLE `dim_employee` (
  `EmployeeKey` int NOT NULL,
  `LastName` varchar(20) DEFAULT NULL,
  `FirstName` varchar(20) DEFAULT NULL,
  `Title` varchar(30) DEFAULT NULL,
  `ReportsTo` int DEFAULT NULL,
  `BirthDate` datetime DEFAULT NULL,
  `HireDate` datetime DEFAULT NULL,
  `Address` varchar(70) DEFAULT NULL,
  `City` varchar(40) DEFAULT NULL,
  `State` varchar(40) DEFAULT NULL,
  `Country` varchar(40) DEFAULT NULL,
  `PostalCode` varchar(10) DEFAULT NULL,
  `Phone` varchar(24) DEFAULT NULL,
  `Fax` varchar(24) DEFAULT NULL,
  `Email` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`EmployeeKey`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

INSERT INTO `chinook_dw`.`dim_employee`
(`EmployeeKey`,
`LastName`,
`FirstName`,
`Title`,
`ReportsTo`,
`BirthDate`,
`HireDate`,
`Address`,
`City`,
`State`,
`Country`,
`PostalCode`,
`Phone`,
`Fax`,
`Email`)
SELECT `employee`.`EmployeeId`,
    `employee`.`LastName`,
    `employee`.`FirstName`,
    `employee`.`Title`,
    `employee`.`ReportsTo`,
    `employee`.`BirthDate`,
    `employee`.`HireDate`,
    `employee`.`Address`,
    `employee`.`City`,
    `employee`.`State`,
    `employee`.`Country`,
    `employee`.`PostalCode`,
    `employee`.`Phone`,
    `employee`.`Fax`,
    `employee`.`Email`
FROM `chinook`.`employee`;

DROP TABLE IF EXISTS dim_customer; 
CREATE TABLE `dim_customer` (
  `CustomerKey` int NOT NULL,
  `FirstName` varchar(40) DEFAULT NULL,
  `LastName` varchar(20) DEFAULT NULL,
  `Company` varchar(80) DEFAULT NULL,
  `Address` varchar(70) DEFAULT NULL,
  `City` varchar(40) DEFAULT NULL,
  `State` varchar(40) DEFAULT NULL,
  `Country` varchar(40) DEFAULT NULL,
  `PostalCode` varchar(10) DEFAULT NULL,
  `Phone` varchar(24) DEFAULT NULL,
  `Fax` varchar(24) DEFAULT NULL,
  `Email` varchar(60) DEFAULT NULL,
  `SupportRepId` int DEFAULT NULL,
  PRIMARY KEY (`CustomerKey`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

INSERT INTO `chinook_dw`.`dim_customer`
(`CustomerKey`,
`FirstName`,
`LastName`,
`Company`,
`Address`,
`City`,
`State`,
`Country`,
`PostalCode`,
`Phone`,
`Fax`,
`Email`,
`SupportRepId`)

SELECT `customer`.`CustomerId`,
    `customer`.`FirstName`,
    `customer`.`LastName`,
    `customer`.`Company`,
    `customer`.`Address`,
    `customer`.`City`,
    `customer`.`State`,
    `customer`.`Country`,
    `customer`.`PostalCode`,
    `customer`.`Phone`,
    `customer`.`Fax`,
    `customer`.`Email`,
    `customer`.`SupportRepId`
FROM `chinook`.`customer`;

DROP TABLE IF EXISTS dim_invoiceline;

CREATE TABLE `dim_invoiceline` (
  `InvoiceLineKey` int NOT NULL,
  `InvoiceKey` int NOT NULL,
  `TrackKey` int NOT NULL,
  `UnitPrice` decimal(10,2) NOT NULL,
  `Quantity` int NOT NULL,
  PRIMARY KEY (`InvoiceLineKey`),
  KEY `IFK_InvoiceLineInvoiceKey` (`InvoiceKey`),
  KEY `IFK_InvoiceLineTrackKey` (`TrackKey`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

INSERT INTO `chinook_dw`.`dim_invoiceline`
(`InvoiceLineKey`,
`InvoiceKey`,
`TrackKey`,
`UnitPrice`,
`Quantity`)
SELECT `invoiceline`.`InvoiceLineId`,
    `invoiceline`.`InvoiceId`,
    `invoiceline`.`TrackId`,
    `invoiceline`.`UnitPrice`,
    `invoiceline`.`Quantity`
FROM `chinook`.`invoiceline`;



CREATE TABLE `dim_invoice` (
  `InvoiceKey` int NOT NULL,
  `CustomerKey` int NOT NULL,
  `InvoiceDate` datetime NOT NULL,
  `BillingAddress` varchar(70) DEFAULT NULL,
  `BillingCity` varchar(40) DEFAULT NULL,
  `BillingState` varchar(40) DEFAULT NULL,
  `BillingCountry` varchar(40) DEFAULT NULL,
  `BillingPostalCode` varchar(10) DEFAULT NULL,
  `Total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`InvoiceKey`)
)ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

INSERT INTO `chinook_dw`.`dim_invoice`
(`InvoiceKey`,
`CustomerKey`,
`InvoiceDate`,
`BillingAddress`,
`BillingCity`,
`BillingState`,
`BillingCountry`,
`BillingPostalCode`,
`Total`)
SELECT `invoice`.`InvoiceID`,
    `invoice`.`CustomerID`,
    `invoice`.`InvoiceDate`,
    `invoice`.`BillingAddress`,
    `invoice`.`BillingCity`,
    `invoice`.`BillingState`,
    `invoice`.`BillingCountry`,
    `invoice`.`BillingPostalCode`,
    `invoice`.`Total`
FROM `chinook`.`invoice`;

DROP TABLE IF EXISTS invoice_details;

CREATE TABLE invoice_details AS
SELECT di.* 
  FROM dim_invoice di
    JOIN dim_employee dc ON di.InvoiceKey=dc.EmployeeKey;
    
    select * from dim_invoice;
-- Splitting invoice details into three intervals
SELECT * FROM invoice_details 
WHERE InvoiceKey < 

    
    
