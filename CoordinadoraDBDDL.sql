CREATE TABLE `country` (
  `id` INT AUTO_INCREMENT,
  `Name` VARCHAR(50) UNIQUE NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `department` (
  `Id` INT AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  `fkIdCountry` INT(11) NOT NULL,
  PRIMARY KEY (`Id`),
  FOREIGN KEY (`fkIdCountry`) REFERENCES `country`(`id`)
);

CREATE TABLE `city` (
  `id` INT AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  `fkIdDepartment` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`fkIdDepartment`) REFERENCES `department`(`Id`)
);

CREATE TABLE `addressType` (
  `id` INT AUTO_INCREMENT,
  `Name` VARCHAR(50) UNIQUE NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `address` (
  `id` INT AUTO_INCREMENT,
  `firstNumber` SMALLINT NOT NULL,
  `firstLetter` CHAR(1) NOT NULL,
  `bis` VARCHAR(10) NULL,
  `secondNumber` SMALLINT NULL,
  `secondLetter` CHAR(1) NULL,
  `cardinal` VARCHAR(10) NULL,
  `complement` VARCHAR(100) NULL,
  `IkIdCity` INT(11) NOT NULL,
  `fkIdAddressType` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`IkIdCity`) REFERENCES `city`(`id`),
  FOREIGN KEY (`fkIdAddressType`) REFERENCES `addressType`(`id`)
);

CREATE TABLE `route` (
  `id` INT AUTO_INCREMENT,
  `fkIdArrivalPoint` INT(11) NOT NULL,
  `fkIdStartingPoint` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`fkIdStartingPoint`) REFERENCES `city`(`id`),
  FOREIGN KEY (`fkIdArrivalPoint`) REFERENCES `city`(`id`)
);

CREATE TABLE `routeCitiyPoints` (
  `fkIdRoute` INT(11) NOT NULL,
  `fkIdCity` INT(11) NOT NULL,
  PRIMARY KEY (`fkIdRoute`, `fkIdCity`),
  FOREIGN KEY (`fkIdRoute`) REFERENCES `route`(`id`),
  FOREIGN KEY (`fkIdCity`) REFERENCES `city`(`id`)
);

CREATE TABLE `product` (
  `id` INT AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `vehicleType` (
  `id` INT AUTO_INCREMENT,
  `name` VARCHAR(50) UNIQUE NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `vehicle` (
  `id` INT AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `color` VARCHAR(30) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `fkIdVehicleType` INT(11) NOT NULL,
  `fkIdRoute` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`fkIdRoute`) REFERENCES `route`(`id`),
  FOREIGN KEY (`fkIdVehicleType`) REFERENCES `vehicleType`(`id`)
);

CREATE TABLE `employeeType` (
  `id` INT AUTO_INCREMENT,
  `Name` VARCHAR(50) UNIQUE NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `contactType` (
  `id` INT AUTO_INCREMENT,
  `Name` VARCHAR(50) UNIQUE NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `contact` (
  `id` INT AUTO_INCREMENT,
  `number` VARCHAR(30) NOT NULL,
  `fkIdTypeContact` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`fkIdTypeContact`) REFERENCES `contactType`(`id`)
);

CREATE TABLE `employee` (
  `code` VARCHAR(30) NOT NULL UNIQUE,
  `name` VARCHAR(50) NOT NULL,
  `lastname` VARCHAR(50) NOT NULL,
  `fkIdContact` INT(11) NOT NULL,
  `fkIdEmployeeType` INT(11) NOT NULL,
  `fkIdVehicle` INT(11) NULL,
  PRIMARY KEY (`code`),
  FOREIGN KEY (`fkIdEmployeeType`) REFERENCES `employeeType`(`id`),
  FOREIGN KEY (`fkIdContact`) REFERENCES `contact`(`id`)
);

CREATE TABLE `client` (
  `code` VARCHAR(30) NOT NULL UNIQUE,
  `name` VARCHAR(50) NOT NULL,
  `lastName` VARCHAR(50) NOT NULL,
  `Age` SMALLINT NOT NULL,
  `creationDate` DATETIME NOT NULL,
  `fkIdAddress` INT(11) NOT NULL,
  `fkIdContact` INT(11) NOT NULL,
  PRIMARY KEY (`code`),
  FOREIGN KEY (`fkIdAddress`) REFERENCES `address`(`id`),
  FOREIGN KEY (`fkIdContact`) REFERENCES `contact`(`id`)
);

CREATE TABLE `order` (
  `id` INT AUTO_INCREMENT,
  `creationDate` DATETIME NOT NULL,
  `fkIdArrivalPoint` INT(11) NOT NULL,
  `fkIdClient` VARCHAR(30) NOT NULL,
  `fkIdVehicle` INT(11) NOT NULL,
  `fkIdEmployee` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`fkIdVehicle`) REFERENCES `vehicle`(`id`),
  FOREIGN KEY (`fkIdEmployee`) REFERENCES `employee`(`code`),
  FOREIGN KEY (`fkIdClient`) REFERENCES `client`(`code`)
);

CREATE TABLE `package` (
  `id` INT AUTO_INCREMENT,
  `description` VARCHAR(150) NULL,
  `size` VARCHAR(7) NOT NULL,
  `width` VARCHAR(7) NOT NULL,
  `height` VARCHAR(7) NOT NULL,
  `fkIdOrder` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`fkIdOrder`) REFERENCES `order`(`id`)
);

CREATE TABLE `packageProduct` (
  `fkIdProduct` INT(11) NOT NULL,
  `fkIdPackage` INT(11) NOT NULL,
  PRIMARY KEY (`fkIdProduct`, `fkIdPackage`),
  FOREIGN KEY (`fkIdProduct`) REFERENCES `product`(`id`),
  FOREIGN KEY (`fkIdPackage`) REFERENCES `package`(`id`)
);

CREATE TABLE `Token` (
  `id` INT AUTO_INCREMENT,
  `code` VARCHAR(70) NOT NULL UNIQUE,
  `creationDate` DATETIME NOT NULL,
  `fkIdUser` VARCHAR(30) NOT NULL ,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`fkIdUser`) REFERENCES `client`(`code`)
);

