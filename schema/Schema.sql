SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 
--

-- --------------------------------------------------------

--
-- `Client`
--

CREATE TABLE `Client` (
  `client_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `client_type` enum('individual','company') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- `Client`
--

INSERT INTO `Client` (`client_id`, `name`, `client_type`) VALUES
(1, 'Michael Brown', 'individual'),
(2, 'TechCorp Inc.', 'company');

-- --------------------------------------------------------

--
-- `Company_Client`
--

CREATE TABLE `Company_Client` (
  `client_id` int(11) NOT NULL,
  `tax_id` char(11) DEFAULT NULL,
  `num_employees` int(11) NOT NULL,
  `industry` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- `Company_Client`
--

INSERT INTO `Company_Client` (`client_id`, `tax_id`, `num_employees`, `industry`) VALUES
(2, '12-3456789', 250, 'Technology');

-- --------------------------------------------------------

--
-- `Contact_Info`
--

CREATE TABLE `Contact_Info` (
  `contact_id` int(11) NOT NULL COMMENT 'AUTO_INCREMENT',
  `client_id` int(11) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- `Contact_Info`
--

INSERT INTO `Contact_Info` (`contact_id`, `client_id`, `phone`, `email`) VALUES
(1, 1, '555-111-2222', 'michael.brown@gmail.com'),
(2, 2, '555-333-4444', 'contact@techcorp.com');

-- --------------------------------------------------------

--
-- `Contract`
--

CREATE TABLE `Contract` (
  `contract_id` int(11) NOT NULL COMMENT 'AUTO_INCREMENT',
  `officer_id` int(11) NOT NULL,
  `contract_date` date NOT NULL,
  `contract_type` enum('individual','company') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- `Contract`
--

INSERT INTO `Contract` (`contract_id`, `officer_id`, `contract_date`, `contract_type`) VALUES
(1, 1, '2024-01-10', 'individual'),
(2, 2, '2024-02-15', 'company');

-- --------------------------------------------------------

--
-- `Contract_Client`
--

CREATE TABLE `Contract_Client` (
  `contract_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- `Contract_Client`
--

INSERT INTO `Contract_Client` (`contract_id`, `client_id`) VALUES
(1, 1),
(2, 2);

-- --------------------------------------------------------

--
-- `Financial_Officer`
--

CREATE TABLE `Financial_Officer` (
  `officer_id` int(11) NOT NULL COMMENT 'PK + Auto Increment',
  `name` varchar(100) NOT NULL,
  `ssn` char(11) DEFAULT NULL,
  `salary` decimal(12,0) DEFAULT NULL,
  `bonus` decimal(12,2) DEFAULT NULL,
  `hire_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- `Financial_Officer`
--

INSERT INTO `Financial_Officer` (`officer_id`, `name`, `ssn`, `salary`, `bonus`, `hire_date`) VALUES
(1, 'John Smith', '123-45-6789', 120000, 10000.00, '2022-01-15'),
(2, 'Alice Lee', '234-56-7890', 130000, 15000.00, '2021-03-10');

-- --------------------------------------------------------

--
-- `Individual_Client`
--

CREATE TABLE `Individual_Client` (
  `client_id` int(11) NOT NULL,
  `ssn` char(11) DEFAULT NULL,
  `age` int(11) NOT NULL,
  `gender` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- `Individual_Client`
--

INSERT INTO `Individual_Client` (`client_id`, `ssn`, `age`, `gender`) VALUES
(1, '567-89-1234', 30, 'male');

--
--
--

--
-- `Client`
--
ALTER TABLE `Client`
  ADD PRIMARY KEY (`client_id`);

--
-- `Company_Client`
--
ALTER TABLE `Company_Client`
  ADD PRIMARY KEY (`client_id`),
  ADD UNIQUE KEY `tax_id` (`tax_id`);

--
-- `Contact_Info`
--
ALTER TABLE `Contact_Info`
  ADD PRIMARY KEY (`contact_id`),
  ADD KEY `client_id` (`client_id`);

--
-- `Contract`
--
ALTER TABLE `Contract`
  ADD PRIMARY KEY (`contract_id`),
  ADD KEY `officer_id` (`officer_id`);

--
-- `Contract_Client`
--
ALTER TABLE `Contract_Client`
  ADD PRIMARY KEY (`contract_id`,`client_id`),
  ADD KEY `client_id` (`client_id`);

--
-- `Financial_Officer`
--
ALTER TABLE `Financial_Officer`
  ADD PRIMARY KEY (`officer_id`),
  ADD UNIQUE KEY `ssn` (`ssn`);

--
-- `Individual_Client`
--
ALTER TABLE `Individual_Client`
  ADD PRIMARY KEY (`client_id`),
  ADD UNIQUE KEY `ssn` (`ssn`);

--
-- AUTO_INCREMENT
--

--
-- AUTO_INCREMENT `Client`
--
ALTER TABLE `Client`
  MODIFY `client_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT `Contact_Info`
--
ALTER TABLE `Contact_Info`
  MODIFY `contact_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'AUTO_INCREMENT', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT `Contract`
--
ALTER TABLE `Contract`
  MODIFY `contract_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'AUTO_INCREMENT', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT `Financial_Officer`
--
ALTER TABLE `Financial_Officer`
  MODIFY `officer_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK + Auto Increment', AUTO_INCREMENT=3;

--
--
--

--
-- `Company_Client`
--
ALTER TABLE `Company_Client`
  ADD CONSTRAINT `Company_Client_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `Client` (`client_id`);

--
-- `Contact_Info`
--
ALTER TABLE `Contact_Info`
  ADD CONSTRAINT `Contact_Info_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `Client` (`client_id`);

--
-- `Contract`
--
ALTER TABLE `Contract`
  ADD CONSTRAINT `Contract_ibfk_1` FOREIGN KEY (`officer_id`) REFERENCES `Financial_Officer` (`officer_id`);

--
-- `Contract_Client`
--
ALTER TABLE `Contract_Client`
  ADD CONSTRAINT `Contract_Client_ibfk_1` FOREIGN KEY (`contract_id`) REFERENCES `Contract` (`contract_id`),
  ADD CONSTRAINT `Contract_Client_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `Client` (`client_id`);

--
-- `Individual_Client`
--
ALTER TABLE `Individual_Client`
  ADD CONSTRAINT `Individual_Client_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `Client` (`client_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
