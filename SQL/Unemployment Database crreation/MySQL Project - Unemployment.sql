## Note: MySqlWorkbench was used with a localhost MySQL Server.

## My name is Kirat Kounsal and this is my first SQL project after a brief learning period. This Project will showcase several skills;
	## CREATE and ALTER tables in a database
	## Assign PRIMARY KEYS
	## Perform Exploratory Analysis using SELECT, WHERE, GROUP BY, HAVING, AND ...

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Creating and Selecting Database to insert tables into. The Tables will detail the Unemployment rates for a selection of countries.
CREATE DATABASE UnemploymentProject;
USE UnemploymentProject;

-- Creating Table Structure to hold General Country Information
CREATE TABLE countries (
	country_code char(3) NOT NULL,
    country_name varchar(64) unique, 
    continent varchar (24) NOT NULL,
    gdp_per_capita DECIMAL(10,2) NOT NULL, 
    life_expectancy DECIMAL(4,2) NOT NULL
);

-- Inserting values into table 'Country'

INSERT INTO countries (country_code, country_name, continent, gdp_per_capita, life_expectancy) VALUES
('AFG', 'Afghanistan', 'Asia', '368.75', '62.58'),
('ANG', 'Angola', 'Africa', '1953.53', '62.26'),
('ALB', 'Albania', 'Europe', '6492.87', '76.99'),
('ARG', 'Argentina', 'South America', '10636.12', '75.89'),
('AUS', 'Australia', 'Oceania', '60443.11', '83.20'),
('AUT', 'Austria', 'Europe', '53637.71', '81.19'),
('BEL', 'Belgium', 'Europe', '51247.01', '80.80'),
('BGD', 'Bangladesh', 'Asia', '2457.92', '71.97'),
('BGR', 'Bulgaria', 'Europe', '12221.50', '73.61'),
('BHR', 'Bahrain', 'Asia', '26562.97', '79.17'),
('BRA', 'Brazil', 'South America', '7507.16', '74.01'),
('CAN', 'Canada', 'North America', '51987.94', '81.75'),
('CHE', 'Switzerland', 'Europe', '91991.60', '83.10'),
('CHL', 'Chile', 'South America', '16265.10', '79.38'),
('CHN', 'China', 'Asia', '12556.33', '78.08'),
('COD', 'Congo', 'Africa', '577.21', '59.74'),
('DEU', 'Germany', 'Europe', '51203.55', '80.94'),
('DNK', 'Denmark', 'Europe', '68007.76', '81.55'),
('EGY', 'Egypt', 'Africa', '3698.83', '70.99'),
('ESP', 'Spain', 'Europe', '30103.51', '82.33'),
('ETH', 'Ethiopia', 'Africa', '925.08', '65.37'),
('FIN', 'Finland', 'Europe', '53654.75', '82.13'),
('FRA', 'France', 'Europe', '43658.98', '82.18'),
('GBR', 'United Kingdom', 'Europe', '46510.28', '80.90'),
('GHA', 'Ghana', 'Africa', '2363.30', '64.11'),
('GRC', 'Greece', 'Europe', '20192.60', '81.09'),
('HKG', 'Hong Kong', 'Asia', '49800.54', '85.39'),
('HRV', 'Croatia', 'Europe', '17685.33', '68.96'),
('HUN', 'Hungary', 'Europe', '18728.12', '75.62'),
('IDN', 'Indonesia', 'Asia', '4332.71', '68.81'),
('IND', 'India', 'Asia', '2256.29', '70.15'),
('ITA', 'Italy', 'Europe', '35657.50', '82.34'),
('JAM', 'Jamaica', 'North America', '5183.58', '71.87'),
('KEN', 'Kenya', 'Africa', '2081.80', '62.68'),
('KOR', 'Korea', 'Asia', '34997.78', '83.43'),
('LBN', 'Lebanon', 'Asia', '4136.15', '77.80'),
('LBY', 'Libya', 'Africa', '6357.20', '72.47'),
('MAR', 'Morocco', 'Africa', '3795.38', '73.92'),
('MDA', 'Moldova', 'Europe', '5230.66', '70.17'),
('MKD', 'Macedonia', 'Europe', '6694.64', '75.69'),
('MNG', 'Mongolia', 'Asia', '4566.14', '72.14'),
('NGA', 'Nigeria', 'Africa', '2065.75', '52.89'),
('NLD', 'Netherlands', 'Europe', '57767.88', '81.41'),
('NOR', 'Norway', 'Europe', '89154.28', '83.21'),
('NZL', 'New Zealand', 'Oceania', '48781.03', '82.06'),
('PAK', 'Pakistan', 'Asia', '1505.01', '66.27'),
('PRT', 'Portugal', 'Europe', '24567.51', '80.98'),
('PRY', 'Paraguay', 'South America', '5891.50', '73.18'),
('RUS', 'Russia', 'Europe', '12194.78', '71.34'),
('SGP', 'Singapore', 'Asia', '72794.00', '83.74'),
('SOM', 'Somalia', 'Africa', '446.98', '55.97'),
('SWE', 'Sweden', 'Europe', '61028.74', '82.41'),
('THA', 'Thailand', 'Asia', '7066.19', '79.27'),
('TUR', 'Turkiye', 'Europe', '9661.24', '75.85'),
('UGA', 'Uganda', 'Africa', '883.89', '62.85'),
('UKR', 'Ukraine', 'Europe', '4835.57', '71.19'),
('URY', 'Uraguay', 'South America', '17313.19', '78.43'),
('USA', 'United States', 'North America', '70248.63', '77.28'),
('VNM', 'Vietnam', 'Asia', '3756.49', '75.38'),
('WSM', 'Samoa', 'Oceania', '3857.32', '72.77')
;
   
-- Creating Table Structure to hold Yearly unemployment values from 1991-2021
CREATE TABLE unemployment_rate (
	country_code char(3) NOT NULL, 
    country_name varchar(64) unique,
    `1991` DECIMAL(6,2) NOT NULL, 
    `1992` DECIMAL(6,2) NOT NULL, 
	`1993` DECIMAL(6,2) NOT NULL, 
    `1994` DECIMAL(6,2) NOT NULL,
    `1995` DECIMAL(6,2) NOT NULL,
    `1996` DECIMAL(6,2) NOT NULL,
    `1997` DECIMAL(6,2) NOT NULL,
    `1998` DECIMAL(6,2) NOT NULL,
    `1999` DECIMAL(6,2) NOT NULL,
    `2000` DECIMAL(6,2) NOT NULL,
    `2001` DECIMAL(6,2) NOT NULL,
    `2002` DECIMAL(6,2) NOT NULL,
    `2003` DECIMAL(6,2) NOT NULL,
    `2004` DECIMAL(6,2) NOT NULL,
    `2005` DECIMAL(6,2) NOT NULL,
    `2006` DECIMAL(6,2) NOT NULL,
    `2007` DECIMAL(6,2) NOT NULL,
    `2008` DECIMAL(6,2) NOT NULL,
    `2009` DECIMAL(6,2) NOT NULL,
    `2010` DECIMAL(6,2) NOT NULL,
    `2011` DECIMAL(6,2) NOT NULL,
    `2012` DECIMAL(6,2) NOT NULL,
    `2013` DECIMAL(6,2) NOT NULL,
    `2014` DECIMAL(6,2) NOT NULL,
    `2015` DECIMAL(6,2) NOT NULL,
    `2016` DECIMAL(6,2) NOT NULL,
    `2017` DECIMAL(6,2) NOT NULL,
    `2018` DECIMAL(6,2) NOT NULL,
    `2019` DECIMAL(6,2) NOT NULL,
    `2020` DECIMAL(6,2) NOT NULL,
    `2021` DECIMAL(6,2) NOT NULL
);

-- Inserting values into table 'UnemploymentRate'

INSERT INTO unemployment_rate (country_code, country_name, `1991`, `1992`, `1993`, `1994`, `1995`, `1996`, `1997`, `1998`, `1999`, `2000`, `2001`, `2002`, `2003`, `2004`, 
										   `2005`, `2006`, `2007`, `2008`, `2009`, `2010`, `2011`, `2012`, `2013`, `2014`, `2015`, `2016`, `2017`, `2018`, 
                                           `2019`, `2020`, `2021`) VALUES
('AFG', 'Afghanistan', '10.65', '10.82', '10.72', '10.73', '11.18', '10.96', '10.78', '10.8', '10.81', '10.81', '10.81', '11.26', '11.14', '10.99', '11.22', '11.1', '11.3',
 '11.09', '11.31', '11.35', '11.05', '11.34', '11.19', '11.14', '11.13', '11.16', '11.18', '11.15', '11.22', '11.71', '13.28'),
('ANG', 'Angola', '4.21', '4.21', '4.23', '4.16', '4.11', '4.1', '4.09', '4.07', '4.05', '4.03', '4', '3.96', '3.96', '3.92', '3.88', '3.86', '3.82', '3.79', '3.78',
 '9.43', '7.36', '7.35', '7.37', '7.37', '7.39', '7.41', '7.41', '7.42', '7.42', '8.33', '8.53'),
('ALB', 'Albania', '10.31', '30.01', '25.26', '20.84', '14.61', '13.93', '16.88', '20.05', '20.84', '19.03', '18.58', '17.9', '16.99', '16.31', '15.97', '15.63', '15.97',
 '13.06', '13.67', '14.09', '13.48', '13.38', '15.87', '18.05', '17.19', '15.42', '13.62', '12.3', '11.47', '13.33', '11.82'),
('ARG', 'Argentina', '5.44', '6.36', '10.1', '11.76', '18.8', '17.11', '14.82', '12.65', '14.05', '15', '17.32', '19.59', '15.36', '13.52', '11.51', '10.08', '8.47', '7.84',
 '8.65', '7.71', '7.18', '7.22', '7.1', '7.27', '7.52', '8.11', '8.35', '9.22', '9.84', '11.46', '10.9'),
('AUS', 'Australia', '9.58', '10.73', '10.87', '9.72', '8.47', '8.51', '8.36', '7.68', '6.87', '6.28', '6.74', '6.37', '5.93', '5.39', '5.03', '4.78', '4.38', '4.23', '5.56',
 '5.21', '5.08', '5.22', '5.66', '6.08', '6.05', '5.71', '5.59', '5.3', '5.16', '6.46', '5.11'),
('AUT', 'Austria', '3.42', '3.59', '4.25', '3.54', '4.35', '5.28', '5.15', '5.52', '4.7', '4.69', '4.01', '4.85', '4.78', '5.83', '5.63', '5.24', '4.86', '4.13', '5.3',
 '4.82', '4.56', '4.87', '5.33', '5.62', '5.72', '6.01', '5.5', '4.85', '4.49', '5.36', '6.3'),
('BEL', 'Belgium', '6.99', '6.7', '8.08', '9.65', '9.34', '9.48', '8.96', '9.32', '8.65', '6.59', '6.18', '6.91', '7.68', '7.36', '8.44', '8.25', '7.46', '6.98', '7.91',
 '8.29', '7.14', '7.54', '8.43', '8.52', '8.48', '7.83', '7.09', '5.95', '5.36', '5.55', '6.42'),
('BGD', 'Bangladesh', '2.2', '2.33', '2.36', '2.38', '2.48', '2.51', '2.69', '2.9', '3.06', '3.27', '3.62', '3.9', '4.32', '4.26', '4.25', '3.59', '4.13', '4.57', '5', '3.38',
 '3.77', '4.12', '4.43', '4.38', '4.37', '4.35', '4.37', '4.41', '4.44', '5.41', '5.23'),
('BGR', 'Bulgaria', '11.1', '15.3', '16.4', '12.8', '11.1', '12.5', '13.7', '12.2', '14.1', '16.22', '19.92', '18.11', '13.73', '12.04', '10.08', '8.95', '6.88', '5.61', '6.82',
 '10.28', '11.26', '12.27', '12.94', '11.42', '9.14', '7.57', '6.16', '5.21', '4.23', '5.12', '5.42'),
('BHR', 'Bahrain', '1.01', '1.05', '1.01', '1.11', '1.08', '1.08', '1.09', '1.08', '1.09', '1.08', '1.11', '1.11', '1.09', '1.09', '1.09', '1.1', '1.09', '1.11', '1.14', '1.13',
 '1.18', '1.2', '1.18', '1.19', '1.2', '1.19', '1.18', '1.2', '1.2', '1.78', '1.87'),
('BRA', 'Brazil', '6.31', '6.42', '6.03', '6.17', '6.42', '7.25', '8.16', '9.42', '10.21', '9.56', '9.61', '9.37', '9.99', '9.11', '9.57', '8.64', '8.33', '7.34', '8.52', '7.27',
 '6.92', '7.19', '6.98', '6.66', '8.43', '11.6', '12.82', '12.33', '11.93', '13.69', '14.4'),
('CAN', 'Canada', '10.32', '11.2', '11.38', '10.4', '9.49', '9.62', '9.1', '8.28', '7.58', '6.83', '7.22', '7.66', '7.57', '7.19', '6.76', '6.32', '6.04', '6.14', '8.34', '8.06',
 '7.51', '7.29', '7.07', '6.91', '6.91', '7', '6.34', '5.83', '5.66', '9.46', '7.51'),
('CHE', 'Switzerland', '1.78', '2.81', '3.72', '3.88', '3.33', '3.71', '4.2', '3.6', '3.15', '2.67', '2.49', '2.92', '4.12', '4.32', '4.44', '4', '3.65', '3.35', '4.12', '4.8', '4.4',
 '4.48', '4.75', '4.83', '4.8', '4.92', '4.8', '4.71', '4.39', '4.82', '5.32'),
('CHL', 'Chile', '5.23', '4.35', '4.49', '5.87', '4.7', '7.41', '7.14', '7.31', '11.16', '10.49', '10.39', '10.17', '9.77', '10.16', '9.34', '9.02', '8.43', '9.29', '11.31', '8.42',
 '7.34', '6.66', '6.21', '6.66', '6.51', '6.74', '6.96', '7.23', '7.29', '11.18', '9.13'),
('CHN', 'China', '2.37', '2.37', '2.69', '2.9', '3', '3.12', '3.23', '3.24', '3.25', '3.26', '3.8', '4.24', '4.58', '4.49', '4.52', '4.43', '4.35', '4.59', '4.72', '4.53', '4.55',
 '4.57', '4.59', '4.61', '4.63', '4.53', '4.44', '4.28', '4.52', '5', '4.82'),
('COD', 'Congo', '2.93', '2.94', '2.94', '2.92', '2.9', '2.9', '2.91', '2.9', '2.9', '2.9', '2.89', '2.87', '2.86', '2.85', '2.85', '3.08', '3.31', '3.55' , '3.79', '4.01', '4.25',
 '4.49', '4.48', '4.46', '4.47', '4.48', '4.47', '4.45', '4.45', '5.27', '5.43'),
('DEU', 'Germany', '5.32', '6.32', '7.68', '8.73', '8.16', '8.82', '9.86', '9.79', '8.86', '7.92', '7.77', '8.48', '9.78', '10.73', '11.17', '10.25', '8.66', '7.52', '7.74', '6.97',
 '5.82', '5.38', '5.23', '4.98', '4.62', '4.12', '3.75', '3.38', '3.14', '3.81', '3.54'),
('DNK', 'Denmark', '9.1', '9.03', '10.72', '8.04', '6.99', '6.84', '5.4', '5.04', '5.14', '4.48', '4.16', '4.27', '5.4', '5.2', '4.83', '3.9', '3.8', '3.68', '6.41', '7.75', '7.77',
 '7.8', '7.38', '6.93', '6.28', '5.99', '5.83', '5.13', '5.02', '5.64', '4.8'),
('EGY', 'Egypt', '9.38', '8.92', '10.92', '10.93', '11.04', '9', '8.37', '8.03', '7.95', '8.98', '9.26', '10.01', '11.01', '10.32', '11.2', '10.49', '8.8', '8.52', '9.09', '8.76',
 '11.85', '12.6', '13.15', '13.1', '13.05', '12.41', '11.74', '9.82', '7.84', '9.17', '9.33'),
('ESP', 'Spain', '15.93', '17.7', '22.16', '24.21', '22.67', '22.14', '20.7', '18.67', '15.48', '13.79', '10.35', '11.15', '11.28', '11.09', '9.15', '8.45', '8.23', '11.25', '17.86',
 '19.86', '21.39', '24.79', '26.09', '24.44', '22.06', '19.63', '17.22', '15.25', '14.1', '15.53', '14.73'),
('ETH', 'Ethiopia', '3.08', '3.1', '3.05', '3.1', '3.21', '3.31', '3.47', '3.62', '3.71', '3.51', '3.3', '3.13', '2.94', '2.69', '2.5', '2.47', '2.43', '2.41', '2.38', '2.34', '2.31',
 '2.29', '2.25', '2.26', '2.27', '2.29', '2.3', '2.32', '2.33', '3.24', '3.69'),
('FIN', 'Finland', '6.5', '11.6', '16.2', '16.43', '17', '15.57', '14.97', '13.21', '11.69', '11.13', '10.29', '10.42', '10.47', '10.36', '8.38', '7.72', '6.85', '6.37', '8.25', '8.39',
 '7.78', '7.69', '8.19', '8.66', '9.38', '8.82', '8.64', '7.36', '6.69', '7.76', '7.53'),
('FRA', 'France', '9.13', '10.21', '11.32', '12.59', '11.84', '12.37', '12.57', '12.07', '11.98', '10.22', '8.61', '8.7', '8.31', '8.91', '8.49', '8.45', '7.66', '7.06', '8.74',
 '8.87', '8.81', '9.4', '9.92', '10.29', '10.35', '10.05', '9.41', '9.02', '8.41', '8.01', '8.06'),
('GBR', 'United Kingdom', '8.55', '9.78', '10.35', '9.65', '8.69', '8.19', '7.07', '6.2', '6.04', '5.56', '4.7', '5.04', '4.81', '4.59', '4.75', '5.35', '5.26', '5.62', '7.54', '7.79',
 '8.04', '7.88', '7.52', '6.11', '5.3', '4.81', '4.33', '4', '3.74', '4.47', '4.53'),
('GHA', 'Ghana', '3.49', '4.7', '5.27', '5.86', '6.44', '7.02', '7.61', '8.2', '10.1', '10.46', '9.5', '8.53', '7.56', '6.59', '5.62', '4.64', '4.84', '4.99', '5.22', '5.38', '5.6',
 '5.91', '6.2', '6.52', '6.81', '5.53', '4.22', '4.28', '4.32', '4.65', '4.7'),
('GRC', 'Greece', '7.66', '7.84', '8.61', '8.86', '9.06', '9.66', '9.58', '10.84', '11.85', '11.25', '10.46', '9.97', '9.41', '10.31', '9.99', '9.01', '8.4', '7.76', '9.62', '12.71',
 '17.86', '24.44', '27.47', '26.49', '24.9', '23.54', '21.49', '19.29', '17.31', '16.3', '14.8'),
('HKG', 'Hong Kong', '1.8', '1.96', '1.96', '1.9', '3.22', '2.83', '2.22', '4.58', '6.25', '4.92', '5.09', '7.28', '7.86', '6.74', '5.58', '4.77', '4.01', '3.56', '5.26', '4.33', '3.42',
 '3.29', '3.4', '3.3', '3.31', '3.39', '3.13', '2.82', '2.93', '5.83', '5.32'),
('HRV', 'Croatia', '11.14', '11.01', '10.68', '10.63', '10.17', '9.68', '9.71', '11.39', '13.56', '16.06', '15.82', '15.05', '13.92', '13.66', '12.6', '11.13', '9.91', '8.53', '9.2',
 '11.62', '13.68', '15.93', '17.25', '17.29', '16.18', '13.1', '11.21', '8.43', '6.62', '7.51', '8.68'),
('HUN', 'Hungary', '8.5', '9.94', '12.1', '10.85', '10.17', '10.02', '8.99', '8.93', '6.93', '6.56', '5.67', '5.61', '5.79', '5.83', '7.19', '7.49', '7.41', '7.82', '10.03', '11.17',
 '11.03', '11', '10.18', '7.73', '6.81', '5.11','4.16', '3.71', '3.42', '4.25', '4.12'),
('IDN', 'Indonesia', '2.62', '2.73', '2.78', '4.37', '4.6', '4.86', '4.68', '5.46', '6.36', '6.08', '6.08', '6.6', '6.66', '7.3', '7.94', '7.55', '8.06', '7.21', '6.11', '5.61', '5.15',
 '4.47', '4.34', '4.05', '4.51', '4.3', '3.88', '4.4', '3.62', '4.28', '4.41'),
('IND', 'India', '5.6', '5.73', '5.69', '5.74', '5.76', '5.74', '5.61', '5.67', '5.74', '5.56', '5.58', '5.53', '5.64', '5.63', '5.61', '5.6', '5.57', '5.41', '5.54', '5.55', '5.43',
 '5.41', '5.42', '5.44', '5.43', '5.42', '5.36', '5.33', '5.27', '8', '5.98'),
('ITA', 'Italy', '10.1', '9.33', '10.24', '11.09', '11.67', '11.87', '12', '12.12', '11.69', '10.84', '9.6', '9.21', '8.87', '7.87', '7.73', '6.78', '6.08', '6.72', '7.75', '8.36',
 '8.36', '10.65', '12.15', '12.68', '11.9', '11.69', '11.21', '10.61', '9.95', '9.16', '9.83'),
('JAM', 'Jamaica', '15.74', '15.75', '16.32', '15.34', '16.23', '16.01', '16.35', '15.5', '15.74', '15.54', '14.93', '14.19', '11.73', '12.21', '11.26', '10.32', '9.75', '10.59',
 '11.36', '12.37', '12.7', '13.93', '15.25', '13.74', '13.51', '13.19', '11.63', '9.1', '7.69', '9.48', '9.18'),
('KEN', 'Kenya', '3.12', '3.12', '3.1', '3.08', '3.06', '3.05', '3.06', '3.03', '3.02', '3.02', '2.99', '3', '2.97', '2.94', '2.92', '2.91', '2.89', '2.92', '2.88', '2.84', '2.84',
 '2.83', '2.81', '2.8', '2.78', '2.76', '3.51', '4.25', '5.01', '5.73', '5.74'),
('KOR', 'Korea', '2.41', '2.51', '2.88', '2.48', '2.06', '2.05', '2.61', '6.96', '6.34', '4.06', '3.7', '3.05', '3.35', '3.42', '3.48', '3.25', '3.01', '2.96', '3.36', '3.32',
 '2.99', '2.81', '2.75', '3.08', '3.55', '3.65', '3.65', '3.82', '3.75', '3.93', '3.53'),
('LBN', 'Lebanon', '8.37', '8.36', '8.44', '8.49', '8.52', '8.49', '8.62', '8.49', '8.44', '8.31', '8.19', '8.09', '7.99', '7.85', '8.28', '8.68', '8.98', '7.67', '6.35', '6.84',
 '7.39', '7.85', '8.31', '8.81', '9.32', '9.78', '10.27', '10.8', '11.35', '13.3', '14.49'),
('LBY', 'Libya', '19.85', '20.02', '20', '19.91', '20.03', '19.83', '19.83', '19.79', '19.75', '19.67', '19.7', '19.65', '19.46', '19.51', '19.39', '19.41', '19.38', '19.38',
 '19.37', '19.27', '19.39', '19.03', '19.45', '19.46', '19.53', '19.53', '19.37', '19.45', '19.66', '20.07', '19.58'),
('MAR', 'Morocco', '2.6', '12.99', '13.1', '12.94', '13.53', '13.17', '13.71', '13.61', '13.94', '13.58', '12.46', '11.59', '11.92', '10.83', '11.01', '9.67', '9.56', '9.57', '8.96',
 '9.09', '8.91', '8.99', '9.23', '9.7', '9.46', '9.3', '9.24', '9.27', '9.28', '11.45', '11.47'),
('MDA', 'Moldova', '1.9', '3.7', '3.7', '5.8', '5.3', '7.9', '7.9', '10', '11.14', '8.46', '7.29', '6.8', '7.95', '8.17', '7.29', '7.38', '5.07', '3.98', '6.4', '7.45', '6.68',
 '5.58', '5.1', '3.73', '4.7', '4.02', '4.1', '4.11', '5.1', '3.82', '3.96'),
('MKD', 'Macedonia', '24.5', '26.3', '27.7', '30', '35.6', '38.8', '36', '34.5', '32.4', '32.2', '30.52', '31.94', '36.69', '37.16', '37.25', '36.03', '34.93', '33.76', '32.18',
 '32.02', '31.38', '31.02', '29', '28.03', '26.07', '23.72', '22.38', '20.74', '17.26', '17.2', '16.2'),
('MNG', 'Mongolia', '6.39', '6.42', '6.27', '6.14', '6.05', '6.16', '6.12', '6.14', '6.16', '6.23', '6.21', '6.2', '6.8', '6.82', '7.04', '7.13', '7.2', '5.56', '5.86', '6.55',
 '4.77', '3.9', '4.23', '4.8', '4.86', '7.24', '6.36', '5.38', '5.44', '7.01', '7.08'),
('NGA', 'Nigeria', '4.12', '4.09', '4.1', '4.09', '4.06', '4.03', '4.01', '4', '3.99', '3.95', '3.93', '3.88', '3.9', '3.88', '3.87', '3.86', '3.84', '3.82', '3.8', '3.78', '3.77',
 '3.74', '3.7', '4.56', '4.31', '7.06', '8.39', '8.46', '8.53', '9.71', '9.79'),
('NLD', 'Netherlands', '7.28', '5.56', '6.29', '7.16', '7.16', '6.42', '5.51', '4.39', '3.62', '2.73', '2.12', '2.55', '3.59', '4.65', '5.87', '5', '4.15', '3.65', '4.35', '4.99', '4.98',
 '5.82', '7.24', '7.42', '6.87', '6.01', '4.84', '3.83', '3.38', '3.82', '4.01'),
('NOR', 'Norway', '5.41', '5.91', '5.97', '5.35', '6.31', '5.04', '4.69', '3.74', '3.25', '3.46', '3.74', '4.02', '4.22', '4.26', '4.38', '3.4', '2.49', '2.55', '3.1', '3.52',
 '3.21', '3.12', '3.42', '3.48', '4.3', '4.68', '4.16', '3.8', '3.69', '4.42', '4.99'),
('NZL', 'New Zealand', '10.61', '10.67', '9.8', '8.35', '6.46', '6.29', '6.86', '7.72', '7.02', '6.13', '5.43', '5.28', '4.75', '4.01', '3.81', '3.86', '3.66', '4.17', '6.12', '6.56',
 '6.49', '6.93', '5.84', '5.43', '5.41', '5.15', '4.74', '4.33', '4.11', '4.59', '4.12'),
('PAK', 'Pakistan', '0.62', '0.66', '0.56', '0.59', '0.6', '0.6', '0.54', '0.56', '0.57', '0.58', '0.56', '0.55', '0.59', '0.61', '0.59', '0.58', '0.4', '0.42', '0.54', '0.65', '0.8',
 '1.85', '2.95', '1.83', '3.57', '3.78', '3.92', '4.08', '3.54', '4.3', '4.35'),
('PRT', 'Portugal', '3.92', '3.98', '5.3', '6.71', '7.06', '7.3', '6.57', '4.65', '4.58', '3.81', '3.83', '4.5', '6.13', '6.32', '7.58', '7.65', '7.96', '7.55', '9.43', '10.77',
 '12.68', '15.53', '16.18', '13.89', '12.44', '11.07', '8.87', '6.99', '6.46', '6.79', '6.65'),
('PRY', 'Paraguay', '5.1', '4.98', '5.06', '4.41', '3.4', '8.15', '5.36', '4.42', '5.34', '7.61', '6.21', '9.39', '6.81', '6.51', '4.82', '5.28', '4.71', '4.42', '5.46', '4.57', 
 '4.67', '4.09', '4.38', '5.03', '4.56', '5.25', '4.61', '6.22', '6.59', '7.55', '7.21'),
('RUS', 'Russia', '5.41', '5.18', '5.88', '8.13', '9.45', '9.67', '11.81', '13.26', '13.04', '10.58', '8.98', '7.88', '8.21', '7.76', '7.12', '7.06', '6', '6.21', '8.3', '7.37',
 '6.54', '5.44', '5.46', '5.16', '5.57', '5.56', '5.21', '4.85', '4.5', '5.59', '5.01'),
('SGP', 'Singapore', '2.18', '3.09', '3.07', '3.03', '3.3', '3.57', '2.5', '3.41', '4.85', '3.7', '3.76', '5.65', '5.93', '5.84', '5.59', '4.48', '3.9', '3.96', '5.86', '4.12', 
 '3.89', '3.72', '3.86', '3.74', '3.79', '4.08', '4.2', '3.64', '3.1', '4.1', '3.62'),
('SOM', 'Somalia', '19.19', '19.27', '19.16', '19.33', '19.14', '19.1', '19.14', '19.08', '19.06', '19.05', '19.04', '19.02', '19.02', '19.02', '19.01', '19.01', '18.9', '18.92',
 '18.94', '18.96', '18.98', '18.97', '18.95', '18.93', '18.9', '18.89', '18.88', '18.85', '18.83', '19.72', '19.86'),
('SWE', 'Sweden', '3.24', '5.72', '9.33', '9.58', '8.9', '9.55', '10.36', '8.94', '7.61', '5.47', '4.73', '4.97', '5.55', '6.69', '7.49', '7.07', '6.16', '6.23', '8.35', '8.61',
 '7.8', '7.98', '8.05', '7.95', '7.43', '6.99', '6.72', '6.36', '6.83', '8.29', '8.66'),
('THA', 'Thailand', '2.63', '1.35', '1.49', '1.35', '1.1', '1.07', '0.87', '3.4', '2.97', '2.39', '2.6', '1.82', '1.54', '1.51', '1.35', '1.22', '1.18', '1.18', '0.95', '0.62', '0.66',
 '0.58', '0.25', '0.58', '0.6', '0.69', '0.83', '0.77', '0.72', '1.1' ,'1.42'),
('TUR', 'Turkiye', '8.21', '8.51', '8.96', '8.58', '7.64', '6.63', '6.84', '6.89', '7.69', '6.5', '8.38', '10.36', '10.54', '10.84', '10.64', '8.72', '8.87', '9.71', '12.55',
 '10.66', '8.8', '8.15', '8.73', '9.88', '10.24', '10.84', '10.82', '10.89', '13.67', '13.11', '13.39'),
('UGA', 'Uganda', '0.94', '0.92', '1.16', '1.42', '1.65', '1.92', '2.21', '2.47', '2.71', '3.03', '3.27', '3.5', '3.6', '2.75', '1.9', '2.29', '2.73', '3.15', '3.6', '3.59', '3.51',
 '3.55', '1.91', '1.91', '1.91', '1.92', '1.93', '1.92', '1.92', '2.77', '2.94'),
('UKR', 'Ukraine', '1.9', '1.9', '2', '2', '5.62', '7.65', '8.93', '11.32', '11.86', '11.71', '11.06', '10.14', '9.06', '8.59', '7.18', '6.81', '6.35', '6.36', '8.84', '8.1', '7.85',
 '7.53', '7.17', '9.27', '9.14', '9.35', '9.5', '8.8', '8.19', '9.13', '8.88'),
('URY', 'Uruguay', '8.95', '8.96', '8.35', '9.04', '10.02', '11.93', '11.44', '9.36', '10.47', '12.63', '15.05', '16.65', '16.66', '12.98', '12.01', '10.84', '9.4', '8.03', '7.74',
 '7.16', '6.31', '6.45', '6.44', '6.55', '7.49', '7.84', '7.89', '8.34', '8.88', '10.35', '10.45'),
('USA', 'United States', '6.8', '7.5', '6.9', '6.12', '5.65', '5.45', '5', '4.51', '4.22', '3.99', '4.73', '5.78', '5.99', '5.53', '5.08', '4.62', '4.62', '5.78', '9.25', '9.63', '8.95',
 '8.07', '7.37', '6.17', '5.28', '4.87', '4.36', '3.9', '3.67', '8.05', '5.46'),
('VNM', 'Vietnam', '2.09', '1.91', '1.97', '1.93', '1.9', '1.93', '2.87', '2.29', '2.33', '2.26', '2.76', '2.12', '2.25', '2.14', '2.1', '2.09', '2.03', '1.93', '1.74', '1.11', '1',
 '1.03', '1.32', '1.26', '1.85', '1.85', '1.87', '1.16', '2.04', '2.39', '2.17'),
('WSM', 'Samoa', '2.1', '2.38', '2.63', '3.04', '3.19', '3.47', '3.9', '4.18', '4.48', '4.66', '4.96', '5.1', '5.16', '5.22', '5.29', '5.42', '5.36', '5.58', '5.83', '5.73',
 '5.68', '8.75', '8.67' ,'8.72', '8.5', '8.31', '8.58', '8.69', '8.41', '9.15', '9.84')
;

-- Altering tables to assign primary keys (to uniquely identify each row of our tables)

ALTER TABLE countries
	ADD PRIMARY KEY (country_name);

ALTER TABLE unemployment_rate
	ADD PRIMARY KEY (country_name);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

																   ## Initial Exploratory Analysis of Data ##

																				## Countries ##

-- CHecking data types for countries table
SELECT
	column_name,
    data_type
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'countries';
		# Everything looks good


-- Retrieving first 5 rows in both tables to check structure of data tables
SELECT *
FROM
    countries
LIMIT 5;


SELECT *
FROM
    unemployment_rate
LIMIT 5;


-- Retrieving total amount of countries in table
SELECT 
    COUNT(country_code) AS `Number of Countries`
FROM countries;
		# 60 Countries in total


-- GDP bins (10000)
SELECT 
    TRUNCATE(gdp_per_capita, - 4) AS gdp_bin,
    COUNT(*) AS `Number of countries`
FROM countries
GROUP BY gdp_bin
ORDER BY gdp_bin;


-- Zooming in on GDP under 10000 (1000)
SELECT 
    TRUNCATE(gdp_per_capita, - 3) AS gdp_bin,
    COUNT(*) AS `Number of countries`
FROM countries
WHERE gdp_per_capita < 10000
GROUP BY gdp_bin
ORDER BY gdp_bin;


-- Examining distribution of countries in dataset by continent
SELECT 
	ROW_NUMBER() OVER(ORDER BY COUNT(country_code) DESC) AS 'Rank',
    UPPER(continent) AS continent, 
    COUNT(country_code) AS `Number of Countries in Table` 
FROM countries 
GROUP BY continent;
		# Europe has most with 24 countries, North America has least with 3


-- Finding Average GDP per Capita across continents
SELECT 
	ROW_NUMBER() OVER(ORDER BY AVG(gdp_per_capita) DESC) AS 'Rank',
    UPPER(continent) AS continent, 
    FLOOR(AVG(gdp_per_capita)) AS `Average GDP per Capita in US Dollars`
FROM countries 
GROUP BY continent;
		# North America has highest average GDP whilst Africa has least


-- Finding GDP per Capita for European countries with Life Expectancy above 80
SELECT 
    country_name, FLOOR(gdp_per_Capita) AS gdp
FROM countries
WHERE continent = 'Europe' AND life_expectancy > 80.00
ORDER BY gdp DESC;
		# Switzerland leads the way witha. GDP above 90K, whilst Greece is bottom with a GDP of just above 20K


-- Finding continents with countries that have GDP per Capita between 50K and 80K AND Life Expectancy between 75 AND 82
SELECT 
    continent
FROM countries
WHERE (life_expectancy BETWEEN 75 AND 82)
        AND (gdp_per_capita BETWEEN 50000 AND 80000)
GROUP BY continent;
		# Europe and North America


-- Finding countries with poor global metrics
SELECT 
    country_name
FROM countries
WHERE life_expectancy < 60.00
        OR gdp_per_capita < 500;
		# Afghanistan, Congo, Nigeria, Somalia


-- Finding Average Life Expectancy across continents
SELECT 
    continent,
    ROUND(AVG(life_expectancy), 2) AS `Average Life Expectancy`
FROM countries
GROUP BY continent
ORDER BY AVG(gdp_per_capita) DESC;
		# North America again has highest average life expectancy and Africa again has least


-- Top 3 countries by GDP Per Capita in US Dollars:
SELECT 
    CONCAT(country_name, ', ', UPPER(continent)) AS country, 
    gdp_per_capita AS GDP
FROM countries
ORDER BY gdp_per_capita DESC
LIMIT 3; 
		# Switzerland, Norway, Singapore (Interestingly, no North American countries but 2 European which implies Europe has greater spread/outliers)


-- Bottom 3 countries by Life Expectancy:
SELECT 
    CONCAT(country_name, ', ', UPPER(continent)) AS country, 
    life_expectancy
FROM countries
ORDER BY life_expectancy
LIMIT 3;
		# Nigeria, Somalia, Congo (Note: ALl from African continent)


-- Lowest GDPperCapita value for Europe in US Dollars

SELECT 
    country_name AS `Country with Lowest GDP per Capita in Europe`,
    gdp_per_capita
FROM countries
WHERE
    continent = 'Europe'
ORDER BY gdp_per_capita
LIMIT 1;
		# Ukraine has lowest GDP per Capita in Europe with $4835.57 US. Note: can be replicated for each continent, results are Afghanistan for Asia, Somalia for Africa, 
        # Paraguay for South America, Jamaica for North America, Samoa for Oceania

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

																	    ## Unemployment Data ##

-- FInding countries with the biggest change in unemployment rate for range of data (1991-2021)
SELECT 
    country_name,
    100 * ROUND((`2021` - `1991`) / `2021`, 2) AS `% Change in Unemployment Rate`
FROM unemployment_rate
ORDER BY `% Change in Unemployment Rate` DESC;
		# Pakistan has highest jump in unemployment at a steggaring 86% whilst New Zealand has most effectively reduced Unemployment by a heafty 158%


-- Finding the 5 countries with highest average Unemployment rate since beginning of COVID-19 (i.e. 2020)                                                                   
SELECT 
    country_name,
    ROUND((`2021` + `2021`, 1) / 2, 2) AS `Average Unemployment Rate`
FROM unemployment_rate
ORDER BY `Average Unemployment Rate` DESC
LIMIT 5;
		# Libya, Somalia, Macedonia, Greece, Spain (Note: 2 from Africa and 3 from Europe)


-- Finding the 5 countries with lowest average Unemployment rate since beginning of COVID-19 (i.e. 2020)                                                                        
SELECT 
    country_code,
    ROUND((`2021` + `2020`) / 2, 2) AS `Average Unemployment Rate`
FROM unemployment_rate
ORDER BY `Average Unemployment Rate`
LIMIT 5;
		# Thailand, Bahrain, Vietnam, Uganda, Ethiopia (Note: 3 from Asia, 2 from Africa). Thailand and Bahrain had a sub 2% unemployment rate


-- Unemployment rates post GFC of 2008
SELECT 
	country_name,
    ROUND((100 * ((`2009` - `2008`) / `2009`)), 2) AS `Percentage change in Unemployment post GFC` 
FROM unemployment_rate 
ORDER BY `Percentage change in Unemployment post GFC` DESC;
		# Denmark expereinced the greatest yearly increase in Unemployment post the GFC jumping 42.59%
        # Thailand experienced the greatest reduction in Unemployment post the GFC with falling 24.21%


-- Finding out how many countries experienced jumps in Unemployment post the GFC 
CREATE TABLE unemployment_postgfc AS 
	SELECT 
		country_name, 
		ROUND((100 * ((`2009` - `2008`) / `2009`)), 2) AS percentage_change 
    FROM unemployment_rate
    ;
    
ALTER TABLE unemployment_postgfc RENAME postgfc; -- (Fixing table names to be more different

ALTER TABLE postgfc
	ADD PRIMARY KEY (country_name);

SELECT COUNT(country_name) AS `Number of Countries`
FROM postgfc 
WHERE percentage_change > 0;
		# 48 Countries experienced worsened Unemployment as a result of the 2008 crisis


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

															## Joining Tables to extrapolate more insights ##

-- Joining Countries and UnemploymentRate tables by rates to analyse unemployment for each continent 
CREATE TABLE continental_unemployment AS
	SELECT countries.country_name, countries.continent, unemployment_rate.`1991`, unemployment_rate.`1992`, unemployment_rate.`1993`, unemployment_rate.`1994`, 
		                                                unemployment_rate.`1995`, unemployment_rate.`1996`, unemployment_rate.`1997`, unemployment_rate.`1998`,
                                                        unemployment_rate.`1999`, unemployment_rate.`2000`, unemployment_rate.`2001`, unemployment_rate.`2002`,
                                                        unemployment_rate.`2003`, unemployment_rate.`2004`, unemployment_rate.`2005`, unemployment_rate.`2006`,
													    unemployment_rate.`2007`, unemployment_rate.`2008`, unemployment_rate.`2009`, unemployment_rate.`2010`,
                                                        unemployment_rate.`2011`, unemployment_rate.`2012`, unemployment_rate.`2013`, unemployment_rate.`2014`,
                                                        unemployment_rate.`2015`, unemployment_rate.`2016`, unemployment_rate.`2017`, unemployment_rate.`2018`,
                                                        unemployment_rate.`2019`, unemployment_rate.`2020`, unemployment_rate.`2021`
    FROM countries
    INNER JOIN unemployment_rate ON countries.country_code = unemployment_rate.country_code
    ;

ALTER TABLE continental_unemployment
	ADD PRIMARY KEY (country_name);

-- Average Unemployment for Each Continent in 2021    
SELECT 
	continent, 
    ROUND(AVG(`2021`), 2) AS `Average Continental Unemployment` 
FROM continental_unemployment 
GROUP BY continent 
ORDER BY AVG(`2021`) DESC;
		# South America has highest unemployment in 2021, Asia has least


-- Continent with greathest reduction in Average Unemployment from 2015-2020
SELECT 
	continent, 
    ROUND(100 * ((AVG(`2020`) - AVG(`2015`)) / AVG(`2020`)) , 2) AS `Growth in Average Unemployment from 2015 to 2020`
FROM continental_unemployment 
GROUP BY continent  
ORDER BY `Growth in Average Unemployment from 2015 to 2020` DESC;
		# Only Europe has experienced a reduction in Average Unemployment from 2015-2020, with South America expereincing the greatest growth


-- Partitioning Continental Average across values
SELECT 
    continent,
    country_name AS country,
    `2021`,
    ROUND(AVG(`2021`) OVER(PARTITION BY continent), 2) AS `Continental Average 2021`
FROM continental_unemployment
WHERE continent IN ('North America', 'Europe', 'Asia')
ORDER BY continent, `2021`	DESC;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Joining GDP and Unemployment Rate
CREATE TABLE gdp_unemployment AS
	SELECT countries.country_name, countries.continent, countries.gdp_per_capita, unemployment_rate.`1991`, unemployment_rate.`1992`, unemployment_rate.`1993`, 
                                                                                  unemployment_rate.`1994`, unemployment_rate.`1995`, unemployment_rate.`1996`, 
                                                                                  unemployment_rate.`1997`, unemployment_rate.`1998`, unemployment_rate.`1999`, 
                                                                                  unemployment_rate.`2000`, unemployment_rate.`2001`, unemployment_rate.`2002`,
                                                                                  unemployment_rate.`2003`, unemployment_rate.`2004`, unemployment_rate.`2005`, 
                                                                                  unemployment_rate.`2006`, unemployment_rate.`2007`, unemployment_rate.`2008`, 
                                                                                  unemployment_rate.`2009`, unemployment_rate.`2010`, unemployment_rate.`2011`, 
                                                                                  unemployment_rate.`2012`, unemployment_rate.`2013`, unemployment_rate.`2014`,
                                                                                  unemployment_rate.`2015`, unemployment_rate.`2016`, unemployment_rate.`2017`, 
                                                                                  unemployment_rate.`2018`, unemployment_rate.`2019`, unemployment_rate.`2020`, 
                                                                                  unemployment_rate.`2021`
    FROM countries
    INNER JOIN unemployment_rate ON countries.country_code = unemployment_rate.country_code
;

ALTER TABLE gdp_unemployment
	ADD PRIMARY KEY (country_name);

-- Looking for link between average GDP and average unemployment rate in 2021 by continent
SELECT 
	continent, 
    ROUND(AVG(gdp_per_capita), 2) AS `Average GDP per Capita in US Dollars`, 
    ROUND(AVG(`2021`), 2) AS `Average Unemployment Rate in 2021` 
FROM gdp_unemployment 
GROUP BY continent 
ORDER BY `Average GDP per Capita in US Dollars` DESC;
		# No obvious trend between GDP and Unemployment in 2021, although two continent with lowest average GDP also have highest average unemployment in 2021


-- Looking for link between average GDP and growth in average unemployment from 2015-2020 by continent
SELECT 
	continent, 
    ROUND(AVG(gdp_per_capita), 2) AS `Average GDP per Capita in US Dollars`, 
    ROUND(100 * ((AVG(`2020`) - AVG(`2015`)) / AVG(`2020`)) , 2) AS `Growth in Average Unemployment from 2015 to 2020` 
FROM gdp_unemployment 
GROUP BY continent 
ORDER BY `Average GDP per Capita in US Dollars` DESC;
		# No obvious trend between GDP and Growth in Unemployment although 3 continents with lowest average GDP also have highest average growth in unemployment


-- Finding countries with GDP > Average continental GDP and Unemployment rate < 5% from 2019 onwards (5% in middle of healthy range). Note, tables need to be formed first
CREATE TABLE average_gdp AS
	SELECT 
		continent, 
        ROUND(AVG(gdp_per_capita), 2) AS ave_gdp
    FROM gdp_unemployment
    GROUP BY continent
    ;

CREATE TABLE country_average_gdp AS
	SELECT 
		c.country_name, 
        c.gdp_per_capita, 
        a.continent, 
        a.ave_gdp
    FROM countries AS c
    INNER JOIN average_gdp AS a
    ON c.continent = a.continent
    ;

CREATE TABLE country_gdp_unemployment AS
	SELECT 
		ca.country_name, 
        ca.continent, 
        ca.gdp_per_capita, 
        ca.ave_gdp, 
        g.`2019`, 
        g.`2020`, 
        g.`2021`
    FROM country_average_gdp AS ca
    INNER JOIN gdp_unemployment as g 
    USING(gdp_per_capita)
    ;

ALTER TABLE country_gdp_unemployment
	ADD PRIMARY KEY (country_name);

SELECT country_name 
FROM country_gdp_unemployment 
WHERE gdp_per_capita > ave_gdp 
GROUP BY country_name 
HAVING AVG(`2021`) < 5 AND AVG(`2020`) < 5 AND AVG(`2019`) < 5;
		# Germany, United Kingdom, Ghana, Korea, Netherlands, Norway, New Zealand, Singapore.
        # These countries outperform continental counterparts in terms of GDP whilst also retaining a healthy unemployment rate across the COVID-19 pandemic.
		# Note if Unemployment rate threshold set to only a maximum of 4% each year, only Bahrain, Germany and Korea remain.
        # If max is set to 3%, only Bahrain remains - implying that given the circumstances, Bahrain haas done well to ensure economic and social stability.


-- Labelling each country's gdp as below or above continental average
SELECT
	continent,
    country_name,
    gdp_per_capita, 
    CASE WHEN gdp_per_capita > ave_gdp THEN 'Above'
		 WHEN gdp_per_capita < ave_gdp THEN 'Below'
         ELSE 'Equal to Average' END AS `Compared to Continental Average`
FROM country_average_gdp
ORDER BY ave_gdp DESC, `Compared to Continental Average`;

-- GDP below Average and worsening Unemployment since commencement of COVID-19, grouped by Continent
SELECT 
	continent, 
    COUNT(country_name) AS `Number of Countries` 
FROM country_gdp_unemployment 
WHERE gdp_per_capita < ave_gdp 
GROUP BY continent 
HAVING (100 * ((AVG(`2021`) - AVG(`2019`)) / AVG(`2021`)) > 0) 
ORDER BY `Number of Countries` DESC;
		# Interestingly, Europe leads in countries that have worsened post COVID-19 closely followed by Asia, however it is important to keep in mind 
        # that the dataset omits many countries (although randomly selected) and Europe and Asia inheerently have the most countries.


-------------------------------------------------------------------------------------------------------------------------------------------------------------------

																			## UNION EXAMPLE ##

SELECT 
	country_name AS country, 
    continent
FROM countries
	WHERE country_name LIKE "a%"
UNION
SELECT 
	country_name AS country, 
    continent
FROM countries 
	WHERE country_name LIKE "b%";

# Note: no duplicates would be returned even if they exist

																	      ## INTERSECT EXAMPLE ##
-- creating table 1
CREATE TABLE intersect1 AS 
SELECT 
	country_name AS country, 
    continent
FROM countries
	WHERE country_name LIKE "a%"
UNION
SELECT 
	country_name AS country, 
    continent
FROM countries 
	WHERE country_name LIKE "b%";

-- creating table 2
CREATE TABLE intersect2 AS
SELECT 
	country_name AS country, 
    continent
FROM countries
	WHERE country_name LIKE "a%";

-- finding intersect
SELECT country as intersect_country
FROM intersect1
INTERSECT
SELECT country
FROM intersect2;

-- Differs from Inner join as it does not return duplicates even if they exist in left table (Inner join would return duplicates)


																			## Sub queries ##

SELECT country_name
FROM countries
WHERE continent = 'Europe' AND life_expectancy <= 0.90 * 
	(SELECT FLOOR(AVG(life_expectancy))
    FROM countries
    WHERE continent = 'Europe');

# Above code finds countries in Europe that have life expectancies at least less than 90% of the European average (Results are Croatia and Moldova)

SELECT COUNT(country_name) AS `Number of Countries`
FROM countries
WHERE continent = 'Asia' AND country_name IN 
	(SELECT country_name
    FROM country_gdp_unemployment
    WHERE `2020` < 
		(SELECT AVG(`2020`)
        FROM unemployment_rate
        WHERE continent = 'Asia')
    AND `2021` < 
		(SELECT AVG(`2021`) 
        FROM unemployment_rate
        WHERE continent = 'Asia'));

# Above code finds the number of Asian countries that have unemployment rates for 2020 and 2021 lower than the Asian average for both those years. 
# Note: Nested sub queries
# Answer is 11


																	## MOST INTERESTING RESULTS ##

-- Using only Unemplyoment rate and comparison to contential average GDP, Bahrain has performed most admirably.
 
-- Europe is the only continent that expereinced a reduction/improvement in Unemployment from 2015-2020.

-- 80% of countries in this data table experienced worsened Unemployment post the 2008 GFC, with Denmark leading the way (a =n almost 43% increase in 
-- unemployment by 2009.

-- Of all countries in this table, Nigeria has lowest Life Expectancy, just a smudge above 50 years. Note, the next two are also African countries.

-- North America has the highest average GDP per capita from a continent perspective, however no North American countries make the top 3 list for 
-- countries with highest GDP per capita, which Europe dominates. Interestingly, Europe also has the most countries that severly worsened both 
-- post the 2008 GFC and post COVID-19, indicative of slight instability and high variability. Possibly even abnormal distributoin of wealth.




