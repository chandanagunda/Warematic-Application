
-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: March 29, 2020 at 23:49 PM
-- Server version: 10.1.36-MariaDB
-- PHP Version: 7.2.10
create database Warematic_DB;
use Warematic_DB;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `warematic_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `T_Users_Profiles`
--

CREATE TABLE `T_Users_Profiles` (
    `Profile_ID` INT NOT NULL AUTO_INCREMENT, 
    `Profile_Description` VARCHAR(50) NOT NULL,
    
    PRIMARY KEY(Profile_ID)

) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `T_Order_Type`
--

CREATE TABLE `T_Order_Type` (
    `ID_Order_Type` INT NOT NULL AUTO_INCREMENT, 
    `Desc_Type` VARCHAR(20) NOT NULL,
    
    PRIMARY KEY(ID_Order_Type)

) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `T_Order_Status`
--

CREATE TABLE `T_Order_Status` (
    `ID_Order_Status` INT NOT NULL AUTO_INCREMENT, 
    `Description` VARCHAR(30) NOT NULL,
    
    PRIMARY KEY(ID_Order_Status)

) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `T_States`
--

CREATE TABLE `T_States` (
    `ID_State` CHAR(2), 
    `State_Desc` VARCHAR(30),
    
    PRIMARY KEY(ID_State)

) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `T_Goods_Units`
--

CREATE TABLE `T_Goods_Units` (
    `ID_Good_Unit` INT NOT NULL AUTO_INCREMENT, 
    `Unit_Description` VARCHAR(20) NOT NULL,
    
    PRIMARY KEY(ID_Good_Unit)

) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `T_Bins`
--

CREATE TABLE `T_Bins` (
    `ID_Bin` INT(4) NOT NULL AUTO_INCREMENT, 
    `Description` VARCHAR(20) NOT NULL,
    
    PRIMARY KEY(ID_Bin)

) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `T_Location_Rows`
--

CREATE TABLE `T_Location_Rows` (
    `ID_Row` INT NOT NULL AUTO_INCREMENT, 
    `Description` VARCHAR(20) NOT NULL,
    
    PRIMARY KEY(ID_Row)

) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `T_Location_Slots`
--

CREATE TABLE `T_Location_Slots` (
    `ID_Slot` INT NOT NULL AUTO_INCREMENT, 
    `Description` VARCHAR(20) NOT NULL,
    `ID_Row` INT NOT NULL,
    
    PRIMARY KEY(ID_Slot),
    FOREIGN KEY (ID_Row)
        REFERENCES T_Location_Rows(ID_Row)

) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `T_Slots_Bins`
--

CREATE TABLE `T_Slots_Bins` (
    `ID_Slot` INT NOT NULL, 
    `ID_Bin` INT NOT NULL,
    
    PRIMARY KEY(ID_Slot, ID_Bin),
    
    FOREIGN KEY (ID_Slot)
        REFERENCES T_Location_Slots(ID_Slot),
	
    FOREIGN KEY (ID_Bin)
        REFERENCES T_Bins(ID_Bin)


) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `T_Users`
--

CREATE TABLE `T_Users` (
    `ID_User` INT NOT NULL AUTO_INCREMENT, 
    `User_Name` VARCHAR(100) NOT NULL,
    `User_Password` VARCHAR(100) NOT NULL,
    `User_FirstName` VARCHAR(50) NOT NULL,
    `User_LastName`  VARCHAR(50) NOT NULL,
    `User_Phone`  VARCHAR(15),
    `Street_Address`  VARCHAR(60),
    `House_Address`  VARCHAR(60),
    `City`  VARCHAR(50),
    `State`  VARCHAR(2),
    `ZipCode`  VARCHAR(5),
    `Register_Date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `Profile_ID`  INT NOT NULL,
    
     PRIMARY KEY(ID_User, User_Name),
     INDEX (User_Name),
     
     FOREIGN KEY (Profile_ID)
        REFERENCES T_Users_Profiles(Profile_ID)
     
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `T_Goods_User`
--

CREATE TABLE `T_Goods_User` (
    `SKU` VARCHAR(8) NOT NULL, 
    `Good_Description` VARCHAR(60) NOT NULL,
    `ID_Good_Unit` INT,
    `ID_Bin` INT,
    `ID_Slot`  INT,
    `Available_Quantity`  INT NOT NULL,
    `ID_User`  INT NOT NULL,
     
     PRIMARY KEY(SKU),
     INDEX (SKU),
     
	FOREIGN KEY (ID_Good_Unit)
        REFERENCES T_Goods_Units(ID_Good_Unit),
	
    FOREIGN KEY (ID_Bin)
        REFERENCES T_Bins(ID_Bin),
	
    FOREIGN KEY (ID_Slot)
        REFERENCES T_Location_Slots(ID_Slot),
	
    FOREIGN KEY (ID_User)
        REFERENCES T_Users(ID_User)
     
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


--
-- Table structure for table `T_Orders`
--

CREATE TABLE `T_Orders` (
	`ID_Order` INT NOT NULL AUTO_INCREMENT,
    `ID_Order_Type` INT NOT NULL,
    `Order_Date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `Receiver_Name` VARCHAR(60),
	`Street_Address`  VARCHAR(60),
    `House_Address`  VARCHAR(60),
    `City`  VARCHAR(50),
    `State`  VARCHAR(2),
    `ZipCode`  VARCHAR(5),
    `PickUp_Date` DATE,
    `Delivery_Date` DATE,
    `ID_User`  INT NOT NULL,
    `ID_Order_Status`  INT NOT NULL,
    
    PRIMARY KEY(ID_Order),
	INDEX (ID_Order),
    
    CONSTRAINT fk_orderType
    FOREIGN KEY (ID_Order_Type)
        REFERENCES T_Order_Type(ID_Order_Type),
    
    CONSTRAINT fk_user
    FOREIGN KEY (ID_User)
        REFERENCES T_Users(ID_User),
	
    CONSTRAINT fk_orderStatus
    FOREIGN KEY (ID_Order_Status)
        REFERENCES T_Order_Status(ID_Order_Status)
    
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


--
-- Table structure for table `T_Order_Goods`
--

CREATE TABLE `T_Order_Goods` (
    `ID_Order` INT NOT NULL, 
    `SKU` VARCHAR(8) NOT NULL,
    `Quantity_Order` INT NOT NULL,
    
    PRIMARY KEY(ID_Order, SKU),
    
    FOREIGN KEY (ID_Order)
        REFERENCES T_Orders(ID_Order),
	
    FOREIGN KEY (SKU)
        REFERENCES T_Goods_User(SKU)


) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `T_Order_Tracking`
--

CREATE TABLE `T_Order_Tracking` (
    `ID_Order` INT NOT NULL, 
    `Process_Date` DATE NOT NULL,
    `ID_Order_Status` INT NOT NULL,
    `ID_User` INT NOT NULL,
    `Order_Comments` VARCHAR(60),
    `Time_Stamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
         
     PRIMARY KEY(ID_Order, Process_Date, ID_Order_Status),
     INDEX (ID_Order),
     
	CONSTRAINT fk_order
	FOREIGN KEY (ID_Order)
        REFERENCES T_Orders(ID_Order),
    
    CONSTRAINT fk_orderStatus
    FOREIGN KEY (ID_Order_Status)
        REFERENCES T_Order_Status(ID_Order_Status),
	
    CONSTRAINT fk_user
    FOREIGN KEY (ID_User)
        REFERENCES T_Users(ID_User)
      
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `T_Order_Type`
--
INSERT INTO `T_Order_Type` (`Desc_Type`) VALUES ('Picking Goods'), ('Delivery Goods');

--
-- Dumping data for table `T_Users_Profiles`
--
INSERT INTO `T_Users_Profiles` (`Profile_Description`) VALUES ('Warehouse Admin'), ('Warehouse Clerk'), ('Runner'), ('General Customer');

--
-- Dumping data for table `T_Order_Status`
--
INSERT INTO `T_Order_Status` (`Description`) 
VALUES 
('In Process'), ('Processed'), ('In Transit'), ('Received at Warehouse'), ('Received at destination');

--
-- Dumping data for table `T_Goods_Units`
--
INSERT INTO `T_Goods_Units` (`Unit_Description`) 
VALUES 
('Each'), ('Box(5)'), ('Box(10)'), ('Box(12)'), ('Package(5)'), ('Package(10)'), ('Package(15)');

--
-- Dumping data for table `T_Bins`
--
INSERT INTO `T_Bins` (`Description`) 
VALUES 
('B001'), ('B002'), ('B003'), ('B004'), ('B005'), ('B006'), ('B007'), ('B008'), ('B009'), ('B010'),
('B011'), ('B012'), ('B013'), ('B014'), ('B015'), ('B016'), ('B017'), ('B018'), ('B019'), ('B020'),
('B021'), ('B022'), ('B023'), ('B024'), ('B025'), ('B026'), ('B027'), ('B028'), ('B029'), ('B030'),
('B031'), ('B032'), ('B033'), ('B034'), ('B035'), ('B036'), ('B037'), ('B038'), ('B039'), ('B040'),
('B041'), ('B042'), ('B043'), ('B044'), ('B045'), ('B046'), ('B047'), ('B048'), ('B049'), ('B050');

--
-- Dumping data for table `T_Location_Rows`
--
INSERT INTO `T_Location_Rows` (`Description`) 
VALUES 
('Row 1'), ('Row 2'), ('Row 3'), ('Row 4'), ('Row 5'), ('Row 6'), ('Row 7'), ('Row 8'), ('Row 9'), ('Row 10');

--
-- Dumping data for table `T_Location_Slots`
--
INSERT INTO `T_Location_Slots` (`Description`, `ID_Row`)
VALUES
('Slot 1', 1),('Slot 2', 1),('Slot 3', 1),('Slot 4', 1),('Slot 5', 1),('Slot 6', 1),
('Slot 7', 1),('Slot 8', 1),('Slot 9', 1),('Slot 10', 1),('Slot 11', 1),('Slot 12', 1),
('Slot 13', 1),('Slot 14', 1),('Slot 15', 1),('Slot 16', 1),('Slot 17', 1),('Slot 18', 1),
('Slot 19', 2),('Slot 20', 2),('Slot 21', 2),('Slot 22', 2),('Slot 23', 2),('Slot 24', 2),
('Slot 25', 2),('Slot 26', 2),('Slot 27', 2),('Slot 28', 2),('Slot 29', 2),('Slot 30', 2),
('Slot 31', 2),('Slot 32', 2),('Slot 33', 2),('Slot 34', 2),('Slot 35', 2),('Slot 36', 2),
('Slot 37', 3),('Slot 38', 3),('Slot 39', 3),('Slot 40', 3),('Slot 41', 3),('Slot 42', 3),
('Slot 43', 3),('Slot 44', 3),('Slot 45', 3),('Slot 46', 3),('Slot 47', 3),('Slot 48', 3),
('Slot 49', 3),('Slot 50', 3),('Slot 51', 3),('Slot 52', 3),('Slot 53', 3),('Slot 54', 3),
('Slot 55', 4),('Slot 56', 4),('Slot 57', 4),('Slot 58', 4),('Slot 59', 4),('Slot 60', 4),
('Slot 61', 4),('Slot 62', 4),('Slot 63', 4),('Slot 64', 4),('Slot 65', 4),('Slot 66', 4),
('Slot 67', 4),('Slot 68', 4),('Slot 69', 4),('Slot 70', 4),('Slot 71', 4),('Slot 72', 4),
('Slot 73', 5),('Slot 74', 5),('Slot 75', 5),('Slot 76', 5),('Slot 77', 5),('Slot 78', 5),
('Slot 79', 5),('Slot 82', 5),('Slot 81', 5),('Slot 82', 5),('Slot 83', 5),('Slot 84', 5),
('Slot 85', 5),('Slot 86', 5),('Slot 87', 5),('Slot 88', 5),('Slot 89', 5),('Slot 90', 5);

--
-- Dumping data for table `T_States`
--
INSERT INTO `T_States` (`ID_State`, `State_Desc`) VALUES
('AL', 'Alabama'), ('AK', 'Alaska'), ('AZ', 'Arizona'), ('AR', 'Arkansas'), ('CA', 'California'),
('CO', 'Colorado'), ('CT', 'Conneticut'), ('DE', 'Delaware'), ('FL', 'Florida'), ('GA', 'Georgia'),
('HI', 'Hawaii'), ('ID', 'Idaho'), ('IL', 'Illinois'), ('IN', 'Indianapolis'), ('IA', 'Iowa'),
('KS', 'Kansas'), ('KY', 'Kentucky'), ('LA', 'Louisiana'), ('ME', 'Maine'), ('MD', 'Maryland'),
('MA', 'Massachusetts'), ('MI', 'Michigan'), ('MN', 'Minnesota'), ('MS', 'Mississippi'), ('MO', 'Missouri'),
('MT', 'Montana'), ('NE', 'Nebraska'), ('NV', 'Nevada'), ('NH', 'New Hampshire'), ('NJ', 'New Jersey'),
('NM', 'New Mexico'), ('NY', 'New York'), ('NC', 'North Carolina'), ('ND', 'North Dakota'), ('OH', 'Ohio'),
('OK', 'Oklahoma City'), ('OR', 'Oregon'), ('PA', 'Pennsilvania'), ('RI', 'Rhode Island'), ('SC', 'South Carolina'),
('SD', 'South Dakota'), ('TN', 'Tennesse'), ('TX', 'Texas'), ('UT', 'Utah'), ('VT', 'Vermont'),
('WA', 'Washington'), ('WV', 'West Virginia'), ('WI', 'Wisconsin'), ('WY', 'Wyoming');

-- --------------------------------------------------------

 COMMIT;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_OrderGoods_toPickUP`(
	IN ORDER_ID INT
)
BEGIN

	SELECT
			GU.SKU,
			GU.Good_Description,
			U.Unit_Description,
			GU.Available_Quantity as PickUp_Quant
	FROM
			T_Goods_User GU
			INNER JOIN T_Order_Goods OG
			ON GU.SKU = OG.SKU
			INNER JOIN T_Goods_Units U
			ON GU.ID_Good_Unit = U.ID_Good_Unit
	WHERE
			OG.ID_Order = ORDER_ID;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_OrderInfo`(
	IN OrderID	INT
)
BEGIN
	SELECT	
			O.ID_Order,
			CONCAT(MONTH(O.Order_Date), "-", DAY(O.Order_Date), "-", YEAR(O.Order_Date)) as Order_Date,
			CONCAT(MONTH(O.PickUp_Date), "-", DAY(O.PickUp_Date), "-", YEAR(O.PickUp_Date)) as PickUp_Date,
			CONCAT(U.User_FirstName, " ", U.User_LastName) as 	Client_Name,
			CONCAT("(", SUBSTR(U.User_Phone, 1, 3) , ")",SUBSTR(U.User_Phone, 4, 3),"-",SUBSTR(U.User_Phone, 7, LENGTH(U.User_Phone))) as User_Phone,
			U.User_Name as Client_Email,
			O.Street_Address,
			O.House_Address,
			O.City,
			St.State_Desc as State,
			O.ZipCode
	FROM 	
			T_Orders O
			INNER JOIN T_Users U
			ON O.ID_User = U.ID_User
			INNER JOIN T_Order_Status S
			ON O.ID_Order_Status = S.ID_Order_Status
			INNER JOIN T_States St
			ON O.State = St.ID_State
	WHERE	
			O.ID_Order = OrderID;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_userInfo`(
	IN userId INT
)
BEGIN
	SELECT 	
		ID_User,
        User_Name,
		Concat(User_FirstName, ' ', User_LastName) as Full_Name,
		User_Phone,
		Street_Address,
        House_Address,
		City,
		State,
		ZipCode
	FROM
		T_Users
	WHERE
		ID_User = userId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_WarehouseOrders_toProcess`()
BEGIN

	SELECT	
			O.ID_Order,
			CONCAT(U.User_FirstName, " ", U.User_LastName) as 	Client_Name,
			U.User_Name as Client_Email,
			CONCAT(MONTH(O.Order_Date), "-", DAY(O.Order_Date), "-", YEAR(O.Order_Date)) as Order_Date,
			CONCAT(MONTH(O.PickUp_Date), "-", DAY(O.PickUp_Date), "-", YEAR(O.PickUp_Date)) as PickUp_Date,
			S.Description as Order_Status        
	FROM 	
			T_Orders O
			INNER JOIN T_Users U
			ON O.ID_User = U.ID_User
			INNER JOIN T_Order_Status S
			ON O.ID_Order_Status = S.ID_Order_Status
	WHERE	
			O.ID_Order_Type = 1
			AND (O.ID_Order_Status = 1 OR O.ID_Order_Status = 3);

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_GoodsUser`(
	IN _OrderID INT,
    IN _SKU VARCHAR(8),
    IN _GoodDesc VARCHAR(60),
    IN _Unit INT,
    IN _Quantity INT,
    IN _ID_User INT
)
BEGIN

	INSERT INTO `warematic_db`.`t_goods_user`
	(
		`SKU`,
		`Good_Description`,
		`ID_Good_Unit`,
		`Available_Quantity`,
		`ID_User`
	)
	VALUES
	(
		_SKU,
		_GoodDesc,
		_Unit,
		_Quantity,
		_ID_User
	);
    
	COMMIT;

    CALL `warematic_db`.`insert_OrderGoods`(_OrderID, _SKU, _Quantity);
    

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_NewPickUpOrder`(
	IN OrderType INT,
	IN Street VARCHAR(60),
	IN House VARCHAR(60),
	IN City VARCHAR(50),
	IN State VARCHAR(2),
	IN ZipCode VARCHAR(5),
	IN PickUp_Date DATE,
	IN IdUser INT,
	IN IdOrderStatus INT
)
BEGIN

	DECLARE _House VARCHAR(60);
    IF House = '' THEN
		SET House = NULL;
    END IF;

	INSERT INTO `warematic_db`.`t_orders`
	(
		`ID_Order_Type`,
		`Street_Address`,
		`House_Address`,
		`City`,
		`State`,
		`ZipCode`,
		`PickUp_Date`,
		`ID_User`,
		`ID_Order_Status`
	)
	VALUES
	(
		OrderType,
		Street,
		House,
		City,
		State,
		ZipCode,
		PickUp_Date,
		IdUser,
		IdOrderStatus
	);

	select @orderId := @@identity as Order_ID;
    
    CALL `warematic_db`.`insert_OrderTracking`(@orderId, IdOrderStatus, IdUser, 'New warehouse order registered');
    
	COMMIT;
     
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_OrderGoods`(
	IN OrderID INT,
    IN SKU VARCHAR(8),
    IN Quantity INT
)
BEGIN

	INSERT INTO `warematic_db`.`t_order_goods`
	(
		`ID_Order`,
		`SKU`,
		`Quantity_Order`
	)
	VALUES
	(
		OrderID,
		SKU,
		Quantity
	);
    
    COMMIT;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_OrderTracking`(
	IN OrderID INT,
    IN IdOrderStatus INT,
    IN UserID INT,
    IN Comments VARCHAR(60)
)
BEGIN
	INSERT INTO `warematic_db`.`t_order_tracking`
	(
		`ID_Order`,
		`Process_Date`,
		`ID_Order_Status`,
		`ID_User`,
		`Order_Comments`
	)
	VALUES
	(
		OrderID,
		curdate(),
		IdOrderStatus,
		UserID,
		Comments
	);
        
END$$
DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT   */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION   */;
