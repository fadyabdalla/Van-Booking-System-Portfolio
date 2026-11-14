-- Van Booking System | Portfolio revision of academic database prototype
-- All identity-like values are synthetic; authentication is not implemented.
-- Import into an empty MySQL/MariaDB database.

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `van_booking_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `booking_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `route_id` int(11) NOT NULL,
  `pickup_location_id` int(11) NOT NULL,
  `dropoff_location_id` int(11) NOT NULL,
  `booking_status_id` int(11) NOT NULL,
  `booking_date` datetime NOT NULL,
  `scheduled_date` datetime NOT NULL,
  `total_estimated_cost` decimal(10,2) NOT NULL,
  `total_final_cost` decimal(10,2) DEFAULT NULL,
  `special_instructions` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`booking_id`, `customer_id`, `driver_id`, `route_id`, `pickup_location_id`, `dropoff_location_id`, `booking_status_id`, `booking_date`, `scheduled_date`, `total_estimated_cost`, `total_final_cost`, `special_instructions`) VALUES
(1, 1, 1, 1, 1, 2, 4, '2026-05-14 10:00:00', '2026-05-15 09:00:00', 45.00, 45.00, 'Handle items carefully'),
(2, 2, 2, 2, 3, 4, 2, '2026-05-14 11:00:00', '2026-05-16 13:00:00', 75.00, NULL, 'Customer needs help loading'),
(3, 3, 3, 3, 5, 2, 3, '2026-05-14 12:00:00', '2026-05-17 15:00:00', 60.00, NULL, 'Fragile boxes included'),
(4, 1, 2, 4, 1, 4, 4, '2026-05-14 13:00:00', '2026-05-18 10:00:00', 120.00, 125.00, 'Large furniture move'),
(5, 2, 1, 5, 3, 2, 1, '2026-05-14 14:00:00', '2026-05-19 11:00:00', 35.00, NULL, 'Small item delivery');

-- --------------------------------------------------------

--
-- Table structure for table `booking_status`
--

CREATE TABLE `booking_status` (
  `booking_status_id` int(11) NOT NULL,
  `status_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking_status`
--

INSERT INTO `booking_status` (`booking_status_id`, `status_name`) VALUES
(2, 'Accepted'),
(5, 'Cancelled'),
(4, 'Completed'),
(3, 'In Progress'),
(1, 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `date_registered` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `first_name`, `last_name`, `phone`, `email`, `password_hash`, `date_registered`) VALUES
(1, 'Demo', 'Customer 01', '07700900001', 'customer1@example.com', 'DEMO_LOGIN_DISABLED', '2026-05-14'),
(2, 'Demo', 'Customer 02', '07700900002', 'customer2@example.com', 'DEMO_LOGIN_DISABLED', '2026-05-14'),
(3, 'Demo', 'Customer 03', '07700900003', 'customer3@example.com', 'DEMO_LOGIN_DISABLED', '2026-05-14'),
(4, 'Demo', 'Customer 04', '07700900004', 'customer4@example.com', 'DEMO_LOGIN_DISABLED', '2026-05-14'),
(5, 'Demo', 'Customer 05', '07700900005', 'customer5@example.com', 'DEMO_LOGIN_DISABLED', '2026-05-14');

-- --------------------------------------------------------

--
-- Table structure for table `driver`
--

CREATE TABLE `driver` (
  `driver_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `license_number` varchar(50) NOT NULL,
  `rating` decimal(2,1) DEFAULT NULL,
  `driver_status` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `driver`
--

INSERT INTO `driver` (`driver_id`, `first_name`, `last_name`, `phone`, `email`, `license_number`, `rating`, `driver_status`, `date_joined`) VALUES
(1, 'Demo', 'Driver 01', '07700900006', 'driver1@example.com', 'DEMO-LIC-001', 4.8, 1, '2026-05-14 10:00:00'),
(2, 'Demo', 'Driver 02', '07700900007', 'driver2@example.com', 'DEMO-LIC-002', 4.5, 1, '2026-05-14 11:00:00'),
(3, 'Demo', 'Driver 03', '07700900008', 'driver3@example.com', 'DEMO-LIC-003', 4.2, 0, '2026-05-14 12:00:00'),
(4, 'Demo', 'Driver 04', '07700900009', 'driver4@example.com', 'DEMO-LIC-004', 4.7, 1, '2026-05-14 13:00:00'),
(5, 'Demo', 'Driver 05', '07700900010', 'driver5@example.com', 'DEMO-LIC-005', 4.6, 1, '2026-05-14 14:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `item_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `item_category_id` int(11) NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `quantity` int(11) NOT NULL,
  `weight_kg` decimal(8,2) DEFAULT NULL,
  `fragile_flag` tinyint(1) NOT NULL,
  `requires_two_people` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`item_id`, `booking_id`, `item_category_id`, `item_name`, `quantity`, `weight_kg`, `fragile_flag`, `requires_two_people`) VALUES
(1, 1, 1, 'Sofa', 1, 45.00, 1, 1),
(2, 2, 2, 'Washing Machine', 1, 70.00, 0, 1),
(3, 3, 3, 'Moving Boxes', 6, 30.00, 0, 0),
(4, 4, 1, 'Wardrobe', 1, 90.00, 0, 1),
(5, 5, 4, 'Television', 1, 12.00, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `item_category`
--

CREATE TABLE `item_category` (
  `item_category_id` int(11) NOT NULL,
  `category_name` varchar(50) NOT NULL,
  `handling_notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `item_category`
--

INSERT INTO `item_category` (`item_category_id`, `category_name`, `handling_notes`) VALUES
(1, 'Furniture', 'Large items may require two people'),
(2, 'Appliances', 'Handle carefully'),
(3, 'Boxes', 'Stackable items'),
(4, 'Electronics', 'Fragile items'),
(5, 'Office Equipment', 'May require careful handling');

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `location_id` int(11) NOT NULL,
  `building_name` varchar(100) NOT NULL,
  `street` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `postcode` varchar(20) NOT NULL,
  `location_type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`location_id`, `building_name`, `street`, `city`, `postcode`, `location_type`) VALUES
(1, 'Demo Site 01', 'Example Zone 01', 'London', 'DEMO-001', 'Pickup'),
(2, 'Demo Site 02', 'Example Zone 02', 'London', 'DEMO-002', 'Dropoff'),
(3, 'Demo Site 03', 'Example Zone 03', 'London', 'DEMO-003', 'Pickup'),
(4, 'Demo Site 04', 'Example Zone 04', 'London', 'DEMO-004', 'Dropoff'),
(5, 'Demo Site 05', 'Example Zone 05', 'London', 'DEMO-005', 'Pickup');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `payment_date` datetime NOT NULL,
  `amount_paid` decimal(10,2) NOT NULL,
  `payment_status` varchar(30) NOT NULL,
  `transaction_reference` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `booking_id`, `payment_method_id`, `payment_date`, `amount_paid`, `payment_status`, `transaction_reference`) VALUES
(1, 1, 1, '2026-05-14 10:05:00', 45.00, 'Completed', 'TXN001'),
(2, 2, 2, '2026-05-14 11:05:00', 20.00, 'Deposit Paid', 'TXN002'),
(3, 3, 3, '2026-05-14 12:05:00', 30.00, 'Pending', 'TXN003'),
(4, 4, 1, '2026-05-14 13:05:00', 125.00, 'Completed', 'TXN004'),
(5, 5, 4, '2026-05-14 14:05:00', 35.00, 'Completed', 'TXN005');

-- --------------------------------------------------------

--
-- Table structure for table `payment_method`
--

CREATE TABLE `payment_method` (
  `payment_method_id` int(11) NOT NULL,
  `method_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment_method`
--

INSERT INTO `payment_method` (`payment_method_id`, `method_name`) VALUES
(3, 'Apple Pay'),
(5, 'Bank Transfer'),
(1, 'Card'),
(2, 'Cash'),
(4, 'Google Pay');

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `review_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `review_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`review_id`, `booking_id`, `customer_id`, `driver_id`, `rating`, `comment`, `review_date`) VALUES
(1, 1, 1, 1, 5, 'Excellent service', '2026-05-15 12:00:00'),
(2, 4, 1, 2, 4, 'Good but slightly late', '2026-05-18 15:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `route`
--

CREATE TABLE `route` (
  `route_id` int(11) NOT NULL,
  `distance_km` decimal(8,2) NOT NULL,
  `duration_minutes` int(11) NOT NULL,
  `congestion_level` varchar(30) NOT NULL,
  `toll_cost` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `route`
--

INSERT INTO `route` (`route_id`, `distance_km`, `duration_minutes`, `congestion_level`, `toll_cost`) VALUES
(1, 5.20, 18, 'Low', 0.00),
(2, 12.40, 35, 'Medium', 2.50),
(3, 8.70, 25, 'Medium', 0.00),
(4, 20.10, 55, 'High', 5.00),
(5, 3.90, 12, 'Low', 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `van`
--

CREATE TABLE `van` (
  `van_id` int(11) NOT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `van_type_id` int(11) DEFAULT NULL,
  `registration_number` varchar(20) NOT NULL,
  `colour` varchar(30) NOT NULL,
  `capacity_kg` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `van`
--

INSERT INTO `van` (`van_id`, `driver_id`, `van_type_id`, `registration_number`, `colour`, `capacity_kg`) VALUES
(1, 1, 1, 'DEMO-VAN-01', 'White', 1200.00),
(2, 2, 2, 'DEMO-VAN-02', 'Black', 2500.00),
(3, 3, 3, 'DEMO-VAN-03', 'Blue', 4000.00),
(4, 1, 2, 'DEMO-VAN-04', 'Silver', 3000.00),
(5, 2, 3, 'DEMO-VAN-05', 'Red', 4500.00);

-- --------------------------------------------------------

--
-- Table structure for table `van_type`
--

CREATE TABLE `van_type` (
  `van_type_id` int(11) NOT NULL,
  `van_type_name` varchar(50) NOT NULL,
  `size_description` varchar(100) NOT NULL,
  `max_volume_m3` decimal(6,2) NOT NULL,
  `base_rate` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `van_type`
--

INSERT INTO `van_type` (`van_type_id`, `van_type_name`, `size_description`, `max_volume_m3`, `base_rate`) VALUES
(1, 'Small Van', 'Suitable for small furniture', 3.50, 25.00),
(2, 'Medium Van', 'Suitable for apartment moves', 7.00, 45.00),
(3, 'Large Van', 'Suitable for full house moves', 12.50, 70.00),
(4, 'Extra Large Van', 'Suitable for commercial moves', 18.00, 95.00),
(5, 'Luton Van', 'Suitable for heavy furniture and long-distance moves', 22.50, 120.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `driver_id` (`driver_id`),
  ADD UNIQUE KEY `route_id` (`route_id`),
  ADD KEY `pickup_location_id` (`pickup_location_id`),
  ADD KEY `dropoff_location_id` (`dropoff_location_id`),
  ADD KEY `booking_status_id` (`booking_status_id`);

--
-- Indexes for table `booking_status`
--
ALTER TABLE `booking_status`
  ADD PRIMARY KEY (`booking_status_id`),
  ADD UNIQUE KEY `status_name` (`status_name`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `driver`
--
ALTER TABLE `driver`
  ADD PRIMARY KEY (`driver_id`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `booking_id` (`booking_id`),
  ADD KEY `item_category_id` (`item_category_id`);

--
-- Indexes for table `item_category`
--
ALTER TABLE `item_category`
  ADD PRIMARY KEY (`item_category_id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `transaction_reference` (`transaction_reference`),
  ADD KEY `booking_id` (`booking_id`),
  ADD KEY `payment_method_id` (`payment_method_id`);

--
-- Indexes for table `payment_method`
--
ALTER TABLE `payment_method`
  ADD PRIMARY KEY (`payment_method_id`),
  ADD UNIQUE KEY `method_name` (`method_name`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`review_id`),
  ADD UNIQUE KEY `booking_id` (`booking_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `driver_id` (`driver_id`);

--
-- Indexes for table `route`
--
ALTER TABLE `route`
  ADD PRIMARY KEY (`route_id`);

--
-- Indexes for table `van`
--
ALTER TABLE `van`
  ADD PRIMARY KEY (`van_id`),
  ADD UNIQUE KEY `registration_number` (`registration_number`),
  ADD KEY `driver_id` (`driver_id`),
  ADD KEY `van_type_id` (`van_type_id`);

--
-- Indexes for table `van_type`
--
ALTER TABLE `van_type`
  ADD PRIMARY KEY (`van_type_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`driver_id`),
  ADD CONSTRAINT `booking_ibfk_3` FOREIGN KEY (`route_id`) REFERENCES `route` (`route_id`),
  ADD CONSTRAINT `booking_ibfk_4` FOREIGN KEY (`pickup_location_id`) REFERENCES `location` (`location_id`),
  ADD CONSTRAINT `booking_ibfk_5` FOREIGN KEY (`dropoff_location_id`) REFERENCES `location` (`location_id`),
  ADD CONSTRAINT `booking_ibfk_6` FOREIGN KEY (`booking_status_id`) REFERENCES `booking_status` (`booking_status_id`);

--
-- Constraints for table `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `item_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`),
  ADD CONSTRAINT `item_ibfk_2` FOREIGN KEY (`item_category_id`) REFERENCES `item_category` (`item_category_id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`),
  ADD CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`payment_method_id`);

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`),
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `review_ibfk_3` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`driver_id`);

--
-- Constraints for table `van`
--
ALTER TABLE `van`
  ADD CONSTRAINT `van_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`driver_id`),
  ADD CONSTRAINT `van_ibfk_2` FOREIGN KEY (`van_type_id`) REFERENCES `van_type` (`van_type_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
